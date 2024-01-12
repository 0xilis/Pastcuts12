#include <Foundation/Foundation.h>
#include <objc/runtime.h>

static void (*orig_WFWorkflow_setMinimumClientVersion)();

static void hook_WFWorkflow_setMinimumClientVersion(void) {
 orig_WFWorkflow_setMinimumClientVersion(@"1");
}

__attribute__((constructor)) static void init() {
 Class cls = objc_getClass("WFWorkflow"); /* wrapper around look_up_class */
 SEL name = sel_getUid("setMinimumClientVersion"); /* perhaps this can be done via dyld_get_objc_selector ? */
 Method meth = class_getInstanceMethod(cls, name);
 IMP imp = (IMP)&hook_WFWorkflow_setMinimumClientVersion;
 *orig_WFWorkflow_setMinimumClientVersion = method_setImplementation(meth, imp); /* this function already checks meth for nil so this is safe */
}