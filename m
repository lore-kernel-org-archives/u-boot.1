Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA47CD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 14:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9FBA84690;
	Thu, 14 May 2026 16:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="WSqH2tVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA7088467C; Thu, 14 May 2026 14:49:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6696584676
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 14:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 059F9244C;
 Thu, 14 May 2026 05:49:48 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EB0C3F7B4;
 Thu, 14 May 2026 05:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778762993; bh=lPdrxd7ebTea/KcvEkwB/LDqb2JF/kqN+DozKAMwsRs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WSqH2tVDj1G45clgIEPWhgT/8YTMYO5fvDmYtGe4xKCcAuCIJRGApkUQr2D0eAb4t
 ncTiIZi8cwKWjEk7zhi5Bu87Khc6+RWtpEOd0W6wYDEh5gfjaFIobvxOy+ipaNa8Ti
 oxOPeOs/flzGF1+oU8HnxqT8QcF/+eKbGqSVtNdk=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: abdellatif.elkhlifi@arm.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 hugues.kambampiana@arm.com, sjg@chromium.org,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v2 02/11] arm-ffa: add FF-A bus runtime support
Date: Thu, 14 May 2026 13:49:15 +0100
Message-Id: <20260514124924.1804332-3-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 May 2026 16:49:29 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Enable FF-A runtime transport for EFI services

Add the FF-A runtime infrastructure needed after ExitBootServices() so
EFI runtime services can continue to use the FF-A transport layer.
Introduce `drivers/firmware/arm-ffa/arm-ffa-runtime.c` and
`include/arm_ffa_runtime.h` with runtime-resident FF-A helpers for
direct messaging, SMC invocation, and error translation. Add the
sandbox runtime SMC wrapper, the `ARM_FFA_RT_MODE` Kconfig option, and
the ExitBootServices hook that copies the required FF-A runtime data
into resident storage before enabling the runtime context.

Tag the runtime code and data with `__efi_runtime` and
`__efi_runtime_data` so they remain available after
ExitBootServices().

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

----

Changelog:
===============

v2:

Simon:

- Leave runtime mode disabled if private data is missing
  and update the log message
- Remove unused global-data plumbing
- Switch to `IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)`
- Fix style issues
- Register the ExitBootServices event earlier in probe
- Keep the runtime-enabled flag separate from copied boot time data

 drivers/firmware/arm-ffa/Kconfig           |  11 +
 drivers/firmware/arm-ffa/Makefile          |   4 +-
 drivers/firmware/arm-ffa/arm-ffa-runtime.c | 295 +++++++++++++++++++++
 drivers/firmware/arm-ffa/arm-ffa-uclass.c  | 113 ++------
 drivers/firmware/arm-ffa/arm-ffa.c         |  16 +-
 drivers/firmware/arm-ffa/ffa-emul-uclass.c |  12 +
 include/arm_ffa.h                          |  16 +-
 include/arm_ffa_priv.h                     |  22 +-
 include/arm_ffa_runtime.h                  | 191 +++++++++++++
 test/dm/ffa.c                              |   6 +-
 10 files changed, 566 insertions(+), 120 deletions(-)
 create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
 create mode 100644 include/arm_ffa_runtime.h

diff --git a/drivers/firmware/arm-ffa/Kconfig b/drivers/firmware/arm-ffa/Kconfig
index 3706a889305..7aaf25fdb58 100644
--- a/drivers/firmware/arm-ffa/Kconfig
+++ b/drivers/firmware/arm-ffa/Kconfig
@@ -18,6 +18,9 @@ config ARM_FFA_TRANSPORT
 	  The FF-A support in U-Boot is based on FF-A specification v1.0 and uses SMC32
 	  calling convention.
 
+	  The FF-A bus also provides a runtime layer to keep a minimal set of FF-A
+	  operations available after ExitBootServices().
+
 	  FF-A specification:
 
 	  https://developer.arm.com/documentation/den0077/a/?lang=en
@@ -41,3 +44,11 @@ config ARM_FFA_TRANSPORT
 	  Secure World (sandbox_ffa.c).
 
 	  For more details about the FF-A support, please refer to doc/arch/arm64.ffa.rst
+
+config ARM_FFA_RT_MODE
+	bool "Enable FF-A runtime support"
+	depends on ARM_FFA_TRANSPORT && EFI_LOADER
+	default y
+	help
+	  Enable the FF-A runtime layer, keeping a minimal set of FF-A
+	  operations available after ExitBootServices().
diff --git a/drivers/firmware/arm-ffa/Makefile b/drivers/firmware/arm-ffa/Makefile
index 318123a7f42..9deb59ba640 100644
--- a/drivers/firmware/arm-ffa/Makefile
+++ b/drivers/firmware/arm-ffa/Makefile
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+# Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
 #
 # Authors:
 #   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
 
 # build the generic FF-A methods
-obj-y += arm-ffa-uclass.o
+obj-y += arm-ffa-uclass.o arm-ffa-runtime.o
 ifeq ($(CONFIG_SANDBOX),y)
 # build the FF-A sandbox emulator and driver
 obj-y += ffa-emul-uclass.o sandbox_ffa.o
diff --git a/drivers/firmware/arm-ffa/arm-ffa-runtime.c b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
new file mode 100644
index 00000000000..4261e8ddf24
--- /dev/null
+++ b/drivers/firmware/arm-ffa/arm-ffa-runtime.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *
+ * Authors:
+ *      Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
+ *      Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+ */
+
+#include <arm_ffa_runtime.h>
+#include <arm_ffa_priv.h>
+#include <log.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+/* Error mapping declarations */
+
+int __ffa_runtime_data ffa_to_std_errmap[MAX_NUMBER_FFA_ERR] = {
+	[NOT_SUPPORTED] = -EOPNOTSUPP,
+	[INVALID_PARAMETERS] = -EINVAL,
+	[NO_MEMORY] = -ENOMEM,
+	[BUSY] = -EBUSY,
+	[INTERRUPTED] = -EINTR,
+	[DENIED] = -EACCES,
+	[RETRY] = -EAGAIN,
+	[ABORTED] = -ECANCELED,
+};
+
+static __ffa_runtime_data struct ffa_priv_runtime ffa_priv_rt = {0};
+static __ffa_runtime_data bool ffa_runtime_enabled;
+
+/* Arm FF-A driver runtime operations */
+static const __ffa_runtime_data struct ffa_bus_ops_runtime ffa_ops_rt = {
+	.sync_send_receive = ffa_msg_send_direct_req_hdlr_runtime,
+};
+
+#define ffa_get_ops_runtime()		(&ffa_ops_rt)
+#define ffa_get_priv_runtime()		(&ffa_priv_rt)
+
+#if IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)
+static void EFIAPI ffa_rt_exit_boot_services_notify(struct efi_event *event,
+						    void *context)
+{
+	struct ffa_priv *priv = context;
+
+	if (priv) {
+		ffa_copy_runtime_priv(&priv->rt);
+	} else {
+		log_err("FF-A: runtime data missing, keeping RT mode disabled\n");
+		return;
+	}
+
+	ffa_enable_runtime_context();
+}
+
+/**
+ * ffa_setup_efi_exit_boot_services_event() - register ExitBootServices event
+ * @priv: pointer to the FF-A private data
+ *
+ * Register an EFI event that enables the FF-A runtime context when
+ * ExitBootServices() is invoked.
+ *
+ * Return: 0 on success, -EPERM on failure to create the event.
+ */
+int ffa_setup_efi_exit_boot_services_event(struct ffa_priv *priv)
+{
+	efi_status_t efi_ret;
+	struct efi_event *evt = NULL;
+
+	efi_ret = efi_create_event(EVT_SIGNAL_EXIT_BOOT_SERVICES, TPL_CALLBACK,
+				   ffa_rt_exit_boot_services_notify, priv,
+				   &efi_guid_event_group_exit_boot_services,
+				   &evt);
+	if (efi_ret != EFI_SUCCESS) {
+		log_err("FF-A: cannot install ExitBootServices event %p, err (%lu)\n",
+			evt, efi_ret);
+		return -EPERM;
+	}
+
+	return 0;
+}
+#endif
+
+/**
+ * ffa_copy_runtime_priv() - copy runtime data into resident storage
+ * @priv: pointer to the runtime private data
+ *
+ * Copy boot-time runtime data into the resident runtime storage to be used
+ * after ExitBootServices().
+ */
+void ffa_copy_runtime_priv(const struct ffa_priv_runtime *priv)
+{
+	struct ffa_priv_runtime *priv_rt = ffa_get_priv_runtime();
+
+	if (priv)
+		*priv_rt = *priv;
+}
+
+/**
+ * ffa_enable_runtime_context() - Enable FF-A runtime context
+ *
+ * This function marks the FF-A runtime environment as ready for use by
+ * EFI runtime services. It is called when ExitBootServices() is invoked,
+ * after the FF-A bus device has successfully probed and U-Boot's FF-A
+ * endpoint ID has been discovered and stored in the runtime private data
+ * structure.
+ *
+ * The FF-A runtime flag allows the EFI runtime layer to verify that the
+ * FF-A transport was initialized during the boot phase and that all
+ * runtime-safe FF-A operations may now be used after ExitBootServices().
+ *
+ */
+void ffa_enable_runtime_context(void)
+{
+	ffa_runtime_enabled = true;
+}
+
+/**
+ * ffa_reset_runtime_context() - Reset FF-A runtime resident state
+ *
+ * Clear the resident runtime flag and private data. This is used by the
+ * FF-A unit tests to avoid leaking runtime state across test cases.
+ */
+void ffa_reset_runtime_context(void)
+{
+	struct ffa_priv_runtime *priv_rt = ffa_get_priv_runtime();
+
+	*priv_rt = (struct ffa_priv_runtime){0};
+	ffa_runtime_enabled = false;
+}
+
+/**
+ * ffa_get_status_runtime_context() - Query FF-A runtime readiness
+ *
+ * This helper returns whether the FF-A runtime environment has been
+ * enabled during the boot phase. Runtime FF-A operations must check this
+ * flag before attempting any FF-A access, as the U-Boot driver model
+ * (DM/uclass) is no longer available after ExitBootServices().
+ *
+ * The runtime context becomes enabled when ffa_enable_runtime_context()
+ * is called, typically after the FF-A bus device has probed and the
+ * endpoint ID has been discovered and stored in the runtime private
+ * data structure.
+ *
+ * Return: true if FF-A runtime support is ready, false otherwise.
+ */
+bool __ffa_runtime ffa_get_status_runtime_context(void)
+{
+	return ffa_runtime_enabled;
+}
+
+/**
+ * ffa_to_std_errno() - convert FF-A error code to standard error code
+ * @ffa_errno:	Error code returned by the FF-A ABI
+ *
+ * Map the given FF-A error code as specified
+ * by the spec to a u-boot standard error code.
+ *
+ * Return: Standard U-Boot errno for known FF-A errors, or -EINVAL otherwise.
+ */
+int __ffa_runtime ffa_to_std_errno(int ffa_errno)
+{
+	int err_idx = -ffa_errno;
+
+	/* Map the FF-A error code to the standard u-boot error code */
+	if (err_idx > 0 && err_idx < MAX_NUMBER_FFA_ERR)
+		return ffa_to_std_errmap[err_idx];
+	return -EINVAL;
+}
+
+/**
+ * ffa_invoke_msg_send_direct_req() - Invokes FFA_MSG_SEND_DIRECT_{REQ,RESP}
+ * @endpoint_id: u-boot endpoint id
+ * @dst_part_id: destination partition ID
+ * @msg: pointer to the message data preallocated by the client (in/out)
+ * @is_smc64: select 64-bit or 32-bit FF-A ABI
+ *
+ * This function invokes FFA_MSG_SEND_DIRECT_{REQ,RESP} FF-A functions.
+ *
+ * FFA_MSG_SEND_DIRECT_REQ is used to send the data to the secure partition.
+ * The response from the secure partition is handled by reading the
+ * FFA_MSG_SEND_DIRECT_RESP arguments.
+ *
+ * The maximum size of the data that can be exchanged is 40 bytes which is
+ * sizeof(struct ffa_send_direct_data) as defined by the FF-A specification 1.0
+ * in the section relevant to FFA_MSG_SEND_DIRECT_{REQ,RESP}
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int __ffa_runtime ffa_invoke_msg_send_direct_req(u16 endpoint_id, u16 dst_part_id,
+						 struct ffa_send_direct_data *msg, bool is_smc64)
+{
+	int ffa_errno;
+	u64 req_mode;
+	ffa_value_t ffa_args_rt;
+	ffa_value_t ffa_res_rt;
+
+	if (is_smc64)
+		req_mode = FFA_SMC_64(FFA_MSG_SEND_DIRECT_REQ);
+	else
+		req_mode = FFA_SMC_32(FFA_MSG_SEND_DIRECT_REQ);
+	efi_memset_runtime(&ffa_args_rt, 0, sizeof(ffa_args_rt));
+	efi_memset_runtime(&ffa_res_rt, 0, sizeof(ffa_res_rt));
+	ffa_args_rt.a0 = req_mode;
+	ffa_args_rt.a1 = PREP_SELF_ENDPOINT_ID(endpoint_id) |
+			 PREP_PART_ENDPOINT_ID(dst_part_id);
+	ffa_args_rt.a2 = 0;
+	ffa_args_rt.a3 = msg->data0;
+	ffa_args_rt.a4 = msg->data1;
+	ffa_args_rt.a5 = msg->data2;
+	ffa_args_rt.a6 = msg->data3;
+	ffa_args_rt.a7 = msg->data4;
+
+	invoke_ffa_fn_runtime(&ffa_args_rt, &ffa_res_rt);
+
+	while (ffa_res_rt.a0 == FFA_SMC_32(FFA_INTERRUPT) ||
+	       ffa_res_rt.a0 == FFA_SMC_64(FFA_INTERRUPT)) {
+		efi_memset_runtime(&ffa_args_rt, 0, sizeof(ffa_args_rt));
+		ffa_args_rt.a0 = (ffa_res_rt.a0 == FFA_SMC_64(FFA_INTERRUPT)) ?
+				  FFA_SMC_64(FFA_RUN) : FFA_SMC_32(FFA_RUN);
+		ffa_args_rt.a1 = ffa_res_rt.a1;
+
+		invoke_ffa_fn_runtime(&ffa_args_rt, &ffa_res_rt);
+	}
+	if (ffa_res_rt.a0 == FFA_SMC_32(FFA_SUCCESS) ||
+	    ffa_res_rt.a0 == FFA_SMC_64(FFA_SUCCESS)) {
+		/* Message sent with no response */
+		return 0;
+	}
+
+	if (ffa_res_rt.a0 == FFA_SMC_32(FFA_MSG_SEND_DIRECT_RESP) ||
+	    ffa_res_rt.a0 == FFA_SMC_64(FFA_MSG_SEND_DIRECT_RESP)) {
+		/* Message sent with response extract the return data */
+		msg->data0 = ffa_res_rt.a3;
+		msg->data1 = ffa_res_rt.a4;
+		msg->data2 = ffa_res_rt.a5;
+		msg->data3 = ffa_res_rt.a6;
+		msg->data4 = ffa_res_rt.a7;
+		return 0;
+	}
+
+	ffa_errno = ffa_res_rt.a2;
+	return ffa_to_std_errno(ffa_errno);
+}
+
+/**
+ * ffa_msg_send_direct_req_hdlr_runtime() - Runtime implementation of
+ * FFA_MSG_SEND_DIRECT_{REQ,RESP} handler function
+ * @dst_part_id: destination partition ID
+ * @msg: pointer to the message data preallocated by the client (in/out)
+ * @is_smc64: select 64-bit or 32-bit FF-A ABI
+ *
+ * This function calls the ffa_invoke_msg_send_direct_req() function which
+ * invokes FFA_MSG_SEND_DIRECT_{REQ,RESP} FF-A functions.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+int __ffa_runtime ffa_msg_send_direct_req_hdlr_runtime(u16 dst_part_id,
+						       struct ffa_send_direct_data *msg,
+						       bool is_smc64)
+{
+	struct ffa_priv_runtime *priv_rt = ffa_get_priv_runtime();
+
+	return ffa_invoke_msg_send_direct_req(priv_rt->id, dst_part_id, msg, is_smc64);
+}
+
+/**
+ * ffa_sync_send_receive_runtime() - Runtime implementation of
+ *                              ffa_sync_send_receive()
+ * @dst_part_id: destination partition ID
+ * @msg: pointer to the message data preallocated by the client (in/out)
+ * @is_smc64: select 64-bit or 32-bit FF-A ABI
+ *
+ * Please see ffa_msg_send_direct_req_hdlr_runtime() description for more details.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+int __ffa_runtime ffa_sync_send_receive_runtime(u16 dst_part_id,
+						struct ffa_send_direct_data *msg,
+						bool is_smc64)
+{
+	const struct ffa_bus_ops_runtime *ops_rt = ffa_get_ops_runtime();
+
+	if (!ffa_get_status_runtime_context())
+		return -EPERM;
+
+	if (!ops_rt->sync_send_receive)
+		return -ENOSYS;
+
+	return ops_rt->sync_send_receive(dst_part_id, msg, is_smc64);
+}
diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index 76a8775e911..548268a42d0 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -1,12 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 #include <arm_ffa.h>
 #include <arm_ffa_priv.h>
+#include <arm_ffa_runtime.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
@@ -18,19 +19,6 @@
 #include <linux/errno.h>
 #include <linux/sizes.h>
 
-/* Error mapping declarations */
-
-int ffa_to_std_errmap[MAX_NUMBER_FFA_ERR] = {
-	[NOT_SUPPORTED] = -EOPNOTSUPP,
-	[INVALID_PARAMETERS] = -EINVAL,
-	[NO_MEMORY] = -ENOMEM,
-	[BUSY] = -EBUSY,
-	[INTERRUPTED] = -EINTR,
-	[DENIED] = -EACCES,
-	[RETRY] = -EAGAIN,
-	[ABORTED] = -ECANCELED,
-};
-
 static struct ffa_abi_errmap err_msg_map[FFA_ERRMAP_COUNT] = {
 	[FFA_ID_TO_ERRMAP_ID(FFA_VERSION)] = {
 		{
@@ -94,27 +82,6 @@ static struct ffa_abi_errmap err_msg_map[FFA_ERRMAP_COUNT] = {
 	},
 };
 
-/**
- * ffa_to_std_errno() - convert FF-A error code to standard error code
- * @ffa_errno:	Error code returned by the FF-A ABI
- *
- * Map the given FF-A error code as specified
- * by the spec to a u-boot standard error code.
- *
- * Return:
- *
- * The standard error code on success. . Otherwise, failure
- */
-static int ffa_to_std_errno(int ffa_errno)
-{
-	int err_idx = -ffa_errno;
-
-	/* Map the FF-A error code to the standard u-boot error code */
-	if (err_idx > 0 && err_idx < MAX_NUMBER_FFA_ERR)
-		return ffa_to_std_errmap[err_idx];
-	return -EINVAL;
-}
-
 /**
  * ffa_print_error_log() - print the error log corresponding to the selected FF-A ABI
  * @ffa_id:	FF-A ABI ID
@@ -204,7 +171,7 @@ int ffa_get_version_hdlr(struct udevice *dev)
 		if (dev) {
 			uc_priv = dev_get_uclass_priv(dev);
 			if (uc_priv)
-				uc_priv->fwk_version = res.a0;
+				uc_priv->rt.fwk_version = res.a0;
 		}
 
 		return 0;
@@ -238,8 +205,8 @@ static int ffa_get_endpoint_id(struct udevice *dev)
 			}, &res);
 
 	if (res.a0 == FFA_SMC_32(FFA_SUCCESS)) {
-		uc_priv->id = GET_SELF_ENDPOINT_ID((u32)res.a2);
-		log_debug("FF-A endpoint ID is %u\n", uc_priv->id);
+		uc_priv->rt.id = GET_SELF_ENDPOINT_ID((u32)res.a2);
+		log_debug("FF-A endpoint ID is %u\n", uc_priv->rt.id);
 
 		return 0;
 	}
@@ -461,7 +428,7 @@ int ffa_unmap_rxtx_buffers_hdlr(struct udevice *dev)
 
 	invoke_ffa_fn((ffa_value_t){
 			.a0 = FFA_SMC_32(FFA_RXTX_UNMAP),
-			.a1 = PREP_SELF_ENDPOINT_ID(uc_priv->id),
+			.a1 = PREP_SELF_ENDPOINT_ID(uc_priv->rt.id),
 			}, &res);
 
 	if (res.a0 == FFA_SMC_32(FFA_SUCCESS)) {
@@ -851,16 +818,8 @@ static int ffa_cache_partitions_info(struct udevice *dev)
  * @msg: pointer to the message data preallocated by the client (in/out)
  * @is_smc64: select 64-bit or 32-bit FF-A ABI
  *
- * Implement FFA_MSG_SEND_DIRECT_{REQ,RESP}
- * FF-A functions.
- *
- * FFA_MSG_SEND_DIRECT_REQ is used to send the data to the secure partition.
- * The response from the secure partition is handled by reading the
- * FFA_MSG_SEND_DIRECT_RESP arguments.
- *
- * The maximum size of the data that can be exchanged is 40 bytes which is
- * sizeof(struct ffa_send_direct_data) as defined by the FF-A specification 1.0
- * in the section relevant to FFA_MSG_SEND_DIRECT_{REQ,RESP}
+ * This function calls the ffa_invoke_msg_send_direct_req() function which
+ * invokes FFA_MSG_SEND_DIRECT_{REQ,RESP} FF-A functions.
  *
  * Return:
  *
@@ -869,9 +828,6 @@ static int ffa_cache_partitions_info(struct udevice *dev)
 int ffa_msg_send_direct_req_hdlr(struct udevice *dev, u16 dst_part_id,
 				 struct ffa_send_direct_data *msg, bool is_smc64)
 {
-	ffa_value_t res = {0};
-	int ffa_errno;
-	u64 req_mode, resp_mode;
 	struct ffa_priv *uc_priv;
 
 	uc_priv = dev_get_uclass_priv(dev);
@@ -880,50 +836,7 @@ int ffa_msg_send_direct_req_hdlr(struct udevice *dev, u16 dst_part_id,
 	if (!uc_priv->partitions.count || !uc_priv->partitions.descs)
 		return -ENODEV;
 
-	if (is_smc64) {
-		req_mode = FFA_SMC_64(FFA_MSG_SEND_DIRECT_REQ);
-		resp_mode = FFA_SMC_64(FFA_MSG_SEND_DIRECT_RESP);
-	} else {
-		req_mode = FFA_SMC_32(FFA_MSG_SEND_DIRECT_REQ);
-		resp_mode = FFA_SMC_32(FFA_MSG_SEND_DIRECT_RESP);
-	}
-
-	invoke_ffa_fn((ffa_value_t){
-			.a0 = req_mode,
-			.a1 = PREP_SELF_ENDPOINT_ID(uc_priv->id) |
-				PREP_PART_ENDPOINT_ID(dst_part_id),
-			.a2 = 0,
-			.a3 = msg->data0,
-			.a4 = msg->data1,
-			.a5 = msg->data2,
-			.a6 = msg->data3,
-			.a7 = msg->data4,
-			}, &res);
-
-	while (res.a0 == FFA_SMC_32(FFA_INTERRUPT))
-		invoke_ffa_fn((ffa_value_t){
-			.a0 = FFA_SMC_32(FFA_RUN),
-			.a1 = res.a1,
-			}, &res);
-
-	if (res.a0 == FFA_SMC_32(FFA_SUCCESS)) {
-		/* Message sent with no response */
-		return 0;
-	}
-
-	if (res.a0 == resp_mode) {
-		/* Message sent with response extract the return data */
-		msg->data0 = res.a3;
-		msg->data1 = res.a4;
-		msg->data2 = res.a5;
-		msg->data3 = res.a6;
-		msg->data4 = res.a7;
-
-		return 0;
-	}
-
-	ffa_errno = res.a2;
-	return ffa_to_std_errno(ffa_errno);
+	return ffa_invoke_msg_send_direct_req(uc_priv->rt.id, dst_part_id, msg, is_smc64);
 }
 
 /* FF-A driver operations (used by clients for communicating with FF-A)*/
@@ -1024,6 +937,7 @@ int ffa_rxtx_unmap(struct udevice *dev)
 static int ffa_do_probe(struct udevice *dev)
 {
 	int ret;
+	struct ffa_priv *uc_priv = dev_get_uclass_priv(dev);
 
 	ret = ffa_get_version_hdlr(dev);
 	if (ret)
@@ -1033,6 +947,12 @@ static int ffa_do_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
+		ret = ffa_setup_efi_exit_boot_services_event(uc_priv);
+		if (ret)
+			return ret;
+	}
+
 	ret = ffa_get_rxtx_map_features_hdlr(dev);
 	if (ret)
 		return ret;
@@ -1046,7 +966,6 @@ static int ffa_do_probe(struct udevice *dev)
 		ffa_unmap_rxtx_buffers_hdlr(dev);
 		return ret;
 	}
-
 	return 0;
 }
 
diff --git a/drivers/firmware/arm-ffa/arm-ffa.c b/drivers/firmware/arm-ffa/arm-ffa.c
index 9e6b5dcc542..241ef018817 100644
--- a/drivers/firmware/arm-ffa/arm-ffa.c
+++ b/drivers/firmware/arm-ffa/arm-ffa.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -8,6 +8,7 @@
 
 #include <arm_ffa.h>
 #include <arm_ffa_priv.h>
+#include <arm_ffa_runtime.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/device-internal.h>
@@ -25,6 +26,19 @@ void invoke_ffa_fn(ffa_value_t args, ffa_value_t *res)
 	arm_smccc_1_2_smc(&args, res);
 }
 
+/**
+ * invoke_ffa_fn_runtime() - Runtime-safe SMC wrapper
+ * @args: FF-A ABI arguments to be copied to Xn registers
+ * @res:  FF-A ABI return values copied from Xn registers
+ *
+ * Calls the SMCCC SMC 1.2 helper from EFI runtime context. This wrapper
+ * is marked __ffa_runtime so it remains available after ExitBootServices().
+ */
+void __ffa_runtime invoke_ffa_fn_runtime(ffa_value_t *args, ffa_value_t *res)
+{
+	arm_smccc_1_2_smc(args, res);
+}
+
 /**
  * arm_ffa_discover() - perform FF-A discovery
  * @dev: The Arm FF-A bus device (arm_ffa)
diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index 6198d687354..d270f7b614e 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -671,6 +671,18 @@ void invoke_ffa_fn(ffa_value_t args, ffa_value_t *res)
 	sandbox_arm_ffa_smccc_smc(&args, res);
 }
 
+/**
+ * invoke_ffa_fn_runtime() - Runtime-safe SMC wrapper
+ * @args: FF-A ABI arguments to be copied to Xn registers
+ * @res: FF-A ABI return data to be copied from Xn registers
+ *
+ * Calls the emulated SMC call.
+ */
+void invoke_ffa_fn_runtime(ffa_value_t *args, ffa_value_t *res)
+{
+	sandbox_arm_ffa_smccc_smc(args, res);
+}
+
 /**
  * ffa_emul_find() - Find the FF-A emulator
  * @dev:	the sandbox FF-A device (sandbox-arm-ffa)
diff --git a/include/arm_ffa.h b/include/arm_ffa.h
index 2994d8ee3ae..6a03aad81a8 100644
--- a/include/arm_ffa.h
+++ b/include/arm_ffa.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -129,21 +129,13 @@ int ffa_sync_send_receive(struct udevice *dev, u16 dst_part_id,
 
 /**
  * ffa_msg_send_direct_req_hdlr() - FFA_MSG_SEND_DIRECT_{REQ,RESP} handler function
- * @dev: The arm_ffa bus device
+ * @dev: The FF-A bus device
  * @dst_part_id: destination partition ID
  * @msg: pointer to the message data preallocated by the client (in/out)
  * @is_smc64: select 64-bit or 32-bit FF-A ABI
  *
- * This function implements FFA_MSG_SEND_DIRECT_{REQ,RESP}
- * FF-A functions.
- *
- * FFA_MSG_SEND_DIRECT_REQ is used to send the data to the secure partition.
- * The response from the secure partition is handled by reading the
- * FFA_MSG_SEND_DIRECT_RESP arguments.
- *
- * The maximum size of the data that can be exchanged is 40 bytes which is
- * sizeof(struct ffa_send_direct_data) as defined by the FF-A specification 1.0
- * in the section relevant to FFA_MSG_SEND_DIRECT_{REQ,RESP}
+ * This function calls the ffa_invoke_msg_send_direct_req() function which
+ * invokes FFA_MSG_SEND_DIRECT_{REQ,RESP} FF-A functions.
  *
  * Return:
  *
diff --git a/include/arm_ffa_priv.h b/include/arm_ffa_priv.h
index d564c33c647..3c74c63dfa6 100644
--- a/include/arm_ffa_priv.h
+++ b/include/arm_ffa_priv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -200,11 +200,24 @@ struct ffa_partitions {
 };
 
 /**
- * struct ffa_priv - the driver private data structure
+ * struct ffa_priv_runtime - the driver's private runtime data structure
  *
  * @fwk_version:	FF-A framework version
- * @emul:	FF-A sandbox emulator
  * @id:	u-boot endpoint ID
+ *
+ * The device private runtime data structure containing all the
+ * data read from secure world.
+ */
+struct ffa_priv_runtime {
+	u32 fwk_version;
+	u16 id;
+};
+
+/**
+ * struct ffa_priv - the driver private data structure
+ *
+ * @rt:		Runtime data captured at boot time
+ * @emul:	FF-A sandbox emulator
  * @partitions:	The partitions descriptors structure
  * @pair:	The RX/TX buffers pair
  *
@@ -212,9 +225,8 @@ struct ffa_partitions {
  * data read from secure world.
  */
 struct ffa_priv {
-	u32 fwk_version;
+	struct ffa_priv_runtime rt;
 	struct udevice *emul;
-	u16 id;
 	struct ffa_partitions partitions;
 	struct ffa_rxtxpair pair;
 };
diff --git a/include/arm_ffa_runtime.h b/include/arm_ffa_runtime.h
new file mode 100644
index 00000000000..2411218cb12
--- /dev/null
+++ b/include/arm_ffa_runtime.h
@@ -0,0 +1,191 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *
+ * Authors:
+ *   Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
+ *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+ */
+
+#ifndef __ARM_FFA_RUNTIME_H
+#define __ARM_FFA_RUNTIME_H
+
+#include <linux/types.h>
+#include <arm_ffa.h>
+#include <arm_ffa_priv.h>
+#include <efi_loader.h>
+
+/**
+ *  __ffa_runtime - controls whether functions are
+ * available after calling the EFI ExitBootServices service.
+ * Functions tagged with these keywords are resident (available at boot time and
+ * at runtime)
+ */
+#if IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)
+#define __ffa_runtime_data __efi_runtime_data
+#define __ffa_runtime __efi_runtime
+#else
+#define __ffa_runtime_data
+#define __ffa_runtime
+#endif
+
+/**
+ * invoke_ffa_fn_runtime() - Runtime-safe SMC wrapper
+ * @args: FF-A ABI arguments to be copied to Xn registers
+ * @res:  FF-A ABI return values copied from Xn registers
+ *
+ * Calls low level SMC implementation. This wrapper
+ * is marked __ffa_runtime so it remains available after ExitBootServices().
+ */
+void __ffa_runtime invoke_ffa_fn_runtime(ffa_value_t *args, ffa_value_t *res);
+
+/**
+ * struct ffa_bus_ops_runtime - Operations for FF-A runtime
+ * @sync_send_receive:	callback for the FFA_MSG_SEND_DIRECT_REQ
+ *
+ * The data structure providing all the runtime operations supported by the driver.
+ * This structure is an EFI runtime resident.
+ */
+struct ffa_bus_ops_runtime {
+	int (*sync_send_receive)(u16 dst_part_id, struct ffa_send_direct_data *msg,
+				 bool is_smc64);
+};
+
+/**
+ * ffa_enable_runtime_context() - Enable FF-A runtime context
+ *
+ * This function marks the FF-A runtime environment as ready for use by
+ * EFI runtime services. It is called when ExitBootServices() is invoked,
+ * after the FF-A bus device has successfully probed and U-Boot's FF-A
+ * endpoint ID has been discovered and stored in the runtime private data
+ * structure.
+ *
+ * The FF-A runtime flag allows the EFI runtime layer to verify that the
+ * FF-A transport was initialized during the boot phase and that all
+ * runtime-safe FF-A operations may now be used after ExitBootServices().
+ *
+ */
+void ffa_enable_runtime_context(void);
+
+/**
+ * ffa_reset_runtime_context() - Reset FF-A runtime resident state
+ *
+ * Clear the resident runtime flag and private data. This is used by the
+ * FF-A unit tests to avoid leaking runtime state across test cases.
+ */
+void ffa_reset_runtime_context(void);
+
+/**
+ * ffa_copy_runtime_priv() - copy runtime data into resident storage
+ * @priv: pointer to the runtime private data
+ *
+ * Copy boot-time runtime data into the resident runtime storage to be used
+ * after ExitBootServices().
+ */
+void ffa_copy_runtime_priv(const struct ffa_priv_runtime *priv);
+
+/**
+ * ffa_setup_efi_exit_boot_services_event() - register ExitBootServices event
+ * @priv: pointer to the FF-A private data
+ *
+ * Register an EFI event that enables the FF-A runtime context when
+ * ExitBootServices() is invoked.
+ *
+ * Return: 0 on success, -EPERM on failure to create the event.
+ */
+#if IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)
+int ffa_setup_efi_exit_boot_services_event(struct ffa_priv *priv);
+#else
+static inline int ffa_setup_efi_exit_boot_services_event(struct ffa_priv *priv)
+{
+	return 0;
+}
+#endif
+
+/**
+ * ffa_get_status_runtime_context() - Query FF-A runtime readiness
+ *
+ * This helper returns whether the FF-A runtime environment has been
+ * enabled during the boot phase. Runtime FF-A operations must check this
+ * flag before attempting any FF-A access, as the U-Boot driver model
+ * (DM/uclass) is no longer available after ExitBootServices().
+ *
+ * The runtime context becomes enabled when ffa_enable_runtime_context()
+ * is called, typically after the FF-A bus device has probed and the
+ * endpoint ID has been discovered and stored in the runtime private
+ * data structure.
+ *
+ * Return: true if FF-A runtime support is ready, false otherwise.
+ */
+bool __ffa_runtime ffa_get_status_runtime_context(void);
+
+/**
+ * ffa_to_std_errno() - convert FF-A error code to standard error code
+ * @ffa_errno:	Error code returned by the FF-A ABI
+ *
+ * Map the given FF-A error code as specified
+ * by the spec to a u-boot standard error code.
+ *
+ * Return: Standard U-Boot errno for known FF-A errors, or -EINVAL otherwise.
+ */
+int __ffa_runtime ffa_to_std_errno(int ffa_errno);
+
+/**
+ * ffa_sync_send_receive_runtime() - Runtime implementation of
+ *                              ffa_sync_send_receive()
+ * @dst_part_id: destination partition ID
+ * @msg: pointer to the message data preallocated by the client (in/out)
+ * @is_smc64: select 64-bit or 32-bit FF-A ABI
+ *
+ * Please see ffa_msg_send_direct_req_hdlr_runtime() description for more details.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int __ffa_runtime ffa_sync_send_receive_runtime(u16 dst_part_id,
+						struct ffa_send_direct_data *msg,
+						bool is_smc64);
+
+/**
+ * ffa_invoke_msg_send_direct_req() - Invokes FFA_MSG_SEND_DIRECT_{REQ,RESP}
+ * @endpoint_id: u-boot endpoint id
+ * @dst_part_id: destination partition ID
+ * @msg: pointer to the message data preallocated by the client (in/out)
+ * @is_smc64: select 64-bit or 32-bit FF-A ABI
+ *
+ * This function invokes FFA_MSG_SEND_DIRECT_{REQ,RESP} FF-A functions.
+ *
+ * FFA_MSG_SEND_DIRECT_REQ is used to send the data to the secure partition.
+ * The response from the secure partition is handled by reading the
+ * FFA_MSG_SEND_DIRECT_RESP arguments.
+ *
+ * The maximum size of the data that can be exchanged is 40 bytes which is
+ * sizeof(struct ffa_send_direct_data) as defined by the FF-A specification 1.0
+ * in the section relevant to FFA_MSG_SEND_DIRECT_{REQ,RESP}
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, error on failure
+ */
+int __ffa_runtime ffa_invoke_msg_send_direct_req(u16 endpoint_id, u16 dst_part_id,
+						 struct ffa_send_direct_data *msg,
+						 bool is_smc64);
+
+/**
+ * ffa_msg_send_direct_req_hdlr_runtime() - Runtime implementation of
+ * FFA_MSG_SEND_DIRECT_{REQ,RESP} handler function
+ * @dst_part_id: destination partition ID
+ * @msg: pointer to the message data preallocated by the client (in/out)
+ * @is_smc64: select 64-bit or 32-bit FF-A ABI
+ *
+ * This function calls the ffa_invoke_msg_send_direct_req() function which
+ * invokes FFA_MSG_SEND_DIRECT_{REQ,RESP} FF-A functions.
+ *
+ * Return:
+ *
+ * 0 on success. Otherwise, failure
+ */
+int __ffa_runtime ffa_msg_send_direct_req_hdlr_runtime(u16 dst_part_id,
+						       struct ffa_send_direct_data *msg,
+						       bool is_smc64);
+
+#endif
diff --git a/test/dm/ffa.c b/test/dm/ffa.c
index 593b7177fce..a0c95e62607 100644
--- a/test/dm/ffa.c
+++ b/test/dm/ffa.c
@@ -2,7 +2,7 @@
 /*
  * Functional tests for UCLASS_FFA  class
  *
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -26,14 +26,14 @@ static int check_fwk_version(struct ffa_priv *uc_priv, struct unit_test_state *u
 	func_data.data0 = &fwk_version;
 	func_data.data0_size = sizeof(fwk_version);
 	ut_assertok(sandbox_query_ffa_emul_state(FFA_VERSION, &func_data));
-	ut_asserteq(uc_priv->fwk_version, fwk_version);
+	ut_asserteq(uc_priv->rt.fwk_version, fwk_version);
 
 	return 0;
 }
 
 static int check_endpoint_id(struct ffa_priv *uc_priv, struct unit_test_state *uts)
 {
-	ut_asserteq(0, uc_priv->id);
+	ut_asserteq(0, uc_priv->rt.id);
 
 	return 0;
 }
-- 
2.34.1

