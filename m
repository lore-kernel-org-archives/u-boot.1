Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0732CD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 14:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3D538469F;
	Thu, 14 May 2026 16:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="XdC8hSKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E94784687; Thu, 14 May 2026 14:49:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 81C2D83FB0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 14:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 684FF244C;
 Thu, 14 May 2026 05:49:50 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A92B53F7B4;
 Thu, 14 May 2026 05:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778762995; bh=3y4AebcocouDI4ZsFRvLHYV5wvYXXn2VojxfodN7pc0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XdC8hSKiiYMKT1iPpRYsDWLyQA5BiSoQ7quc21m6tdaj3gok5mjtEdasJJWWBCQ8I
 8Q4Fe1w+RrR0qlbxC9OnfE3zDII3GkHFO2WxN3T9XyXvgMa3+99wvhCXc7TaQ3DsSa
 9CQwtEAzCF0zP95cQ98HcaVvCGbqT+BuFC7TyKIg=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: abdellatif.elkhlifi@arm.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 hugues.kambampiana@arm.com, sjg@chromium.org,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v2 03/11] efi_loader: add FF-A runtime support in EFI variable
 TEE driver
Date: Thu, 14 May 2026 13:49:16 +0100
Message-Id: <20260514124924.1804332-4-harsimransingh.tungal@arm.com>
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

Enable MM variable services over FF-A after ExitBootServices

Extend lib/efi_loader/efi_variable_tee.c to support FF-A
communication with the secure world during EFI runtime. Reuse the
statically reserved FF-A shared buffer after ExitBootServices(),
make the MM communication path runtime-safe so runtime variable
operations continue to reach the secure partition.

Share the MM communication and MM SP notification helpers between the
boot and runtime paths instead of maintaining separate runtime-only
variants. Select dynamic allocation during boot and the fixed FF-A
shared buffer at runtime, and reject requests that would exceed the
shared buffer size.

Mark the required code and data with __efi_runtime and
__efi_runtime_data, use range-based cache maintenance on the shared
buffer for the runtime FF-A path, and add the shared buffer to the EFI
runtime memory map. Document the FF-A shared MM buffer
cacheline-alignment requirement in Kconfig and add BUILD_BUG_ON()
checks for the shared buffer address and size in the arm64
cache-maintenance path.

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---

Changelog:
===============

v2:

Ilias, Simon:

- Reuse common MM SP error mapping
- Rename runtime-phase tracking to `efi_at_runtime()`
- Collapse boot and runtime MM communication helpers
- Fold runtime MM SP notification into the common path
- Make the arm64 cache-maintenance path runtime-safe
- Document the FF-A shared buffer cacheline-alignment requirement and
  add BUILD_BUG_ON() checks for the address and size
- Move shared-buffer reservation to the end of init
- Add a runtime shared-buffer bounds check
- Document the shared-buffer page-alignment assumption
- Reword `setup_mm_hdr()` documentation
- Narrow `mm_var_guid` variable scope
- Update the copyright header

 arch/arm/cpu/armv8/cache.S        |   8 +
 arch/arm/cpu/armv8/cache_v8.c     |  13 +-
 lib/efi_loader/Kconfig            |   4 +
 lib/efi_loader/efi_variable_tee.c | 330 ++++++++++++++++++++++--------
 4 files changed, 260 insertions(+), 95 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache.S b/arch/arm/cpu/armv8/cache.S
index c9e46859b4f..916558fe477 100644
--- a/arch/arm/cpu/armv8/cache.S
+++ b/arch/arm/cpu/armv8/cache.S
@@ -169,7 +169,11 @@ ENDPROC(__asm_flush_l3_dcache)
  * x0: start address
  * x1: end address
  */
+#ifdef CONFIG_EFI_LOADER
+.pushsection .text.efi_runtime.__asm_flush_dcache_range, "ax"
+#else
 .pushsection .text.__asm_flush_dcache_range, "ax"
+#endif
 ENTRY(__asm_flush_dcache_range)
 	mrs	x3, ctr_el0
 	ubfx	x3, x3, #16, #4
@@ -195,7 +199,11 @@ ENDPROC(__asm_flush_dcache_range)
  * x0: start address
  * x1: end address
  */
+#ifdef CONFIG_EFI_LOADER
+.pushsection .text.efi_runtime.__asm_invalidate_dcache_range, "ax"
+#else
 .pushsection .text.__asm_invalidate_dcache_range, "ax"
+#endif
 ENTRY(__asm_invalidate_dcache_range)
 	mrs	x3, ctr_el0
 	ubfx	x3, x3, #16, #4
diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 39479df7b21..7c2840fc545 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -8,6 +8,7 @@
  */
 
 #include <cpu_func.h>
+#include <efi_loader.h>
 #include <hang.h>
 #include <log.h>
 #include <asm/cache.h>
@@ -853,7 +854,8 @@ inline void flush_dcache_all(void)
 /*
  * Invalidates range in all levels of D-cache/unified cache
  */
-void invalidate_dcache_range(unsigned long start, unsigned long stop)
+void __efi_runtime invalidate_dcache_range(unsigned long start,
+					   unsigned long stop)
 {
 	__asm_invalidate_dcache_range(start, stop);
 }
@@ -861,16 +863,19 @@ void invalidate_dcache_range(unsigned long start, unsigned long stop)
 /*
  * Flush range(clean & invalidate) from all levels of D-cache/unified cache
  */
-void flush_dcache_range(unsigned long start, unsigned long stop)
+void __efi_runtime flush_dcache_range(unsigned long start,
+				      unsigned long stop)
 {
 	__asm_flush_dcache_range(start, stop);
 }
 #else
-void invalidate_dcache_range(unsigned long start, unsigned long stop)
+void __efi_runtime invalidate_dcache_range(unsigned long start,
+					   unsigned long stop)
 {
 }
 
-void flush_dcache_range(unsigned long start, unsigned long stop)
+void __efi_runtime flush_dcache_range(unsigned long start,
+				      unsigned long stop)
 {
 }
 #endif /* CONFIG_SYS_DISABLE_DCACHE_OPS */
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 4cb13ae7c8a..a9791b8f2e3 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -195,6 +195,8 @@ config FFA_SHARED_MM_BUF_SIZE
 	  the MM SP in secure world.
 	  The size of the memory region must be a multiple of the size of the maximum
 	  translation granule size that is specified in the ID_AA64MMFR0_EL1 System register.
+	  For arm64 FF-A cache maintenance, this size must also be aligned to
+	  CONFIG_SYS_CACHELINE_SIZE.
 	  It is assumed that the MM SP knows the size of the shared MM communication buffer.
 
 config FFA_SHARED_MM_BUF_OFFSET
@@ -211,6 +213,8 @@ config FFA_SHARED_MM_BUF_ADDR
 	  This defines the address of the shared MM communication buffer
 	  used for communication between the MM feature in U-Boot and
 	  the MM SP in secure world.
+	  For arm64 FF-A cache maintenance, this address must also be aligned to
+	  CONFIG_SYS_CACHELINE_SIZE.
 	  It is assumed that the MM SP knows the address of the shared MM communication buffer.
 
 config EFI_VARIABLE_SF_OFFSET
diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 6a1fa39bb6f..ccd8d94a51e 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -4,7 +4,7 @@
  *
  *  Copyright (C) 2019 Linaro Ltd. <sughosh.ganu@linaro.org>
  *  Copyright (C) 2019 Linaro Ltd. <ilias.apalodimas@linaro.org>
- *  Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *  Copyright 2022-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  *  Authors:
  *    Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -14,6 +14,7 @@
 
 #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
 #include <arm_ffa.h>
+#include <arm_ffa_runtime.h>
 #endif
 #include <cpu_func.h>
 #include <dm.h>
@@ -21,6 +22,7 @@
 #include <efi_api.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
+#include <linux/build_bug.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <mm_communication.h>
@@ -34,20 +36,44 @@
 #define MM_DENIED (-3)
 #define MM_NO_MEMORY (-5)
 
+static const int __efi_runtime_rodata mm_sp_errmap[] = {
+	[-MM_NOT_SUPPORTED]	 = -EINVAL,
+	[-MM_INVALID_PARAMETER]	 = -EPERM,
+	[-MM_DENIED]		 = -EACCES,
+	[-MM_NO_MEMORY]		 = -EBUSY,
+};
+
 static const char *mm_sp_svc_uuid = MM_SP_UUID;
-static u16 mm_sp_id;
+static u16 __efi_runtime_data mm_sp_id;
 #endif
 
+static void *__efi_runtime_data ffa_shared_buf;
 extern struct efi_var_file __efi_runtime_data *efi_var_buf;
-static efi_uintn_t max_buffer_size;	/* comm + var + func + data */
-static efi_uintn_t max_payload_size;	/* func + data */
+static efi_uintn_t __efi_runtime_data max_buffer_size;	/* comm + var + func + data */
+static efi_uintn_t __efi_runtime_data max_payload_size;	/* func + data */
 static const u16 __efi_runtime_rodata pk[] = u"PK";
+static bool __efi_runtime_data ebs_called;
 
 struct mm_connection {
 	struct udevice *tee;
 	u32 session;
 };
 
+/**
+ * efi_at_runtime() - Indicate whether the system is in the UEFI runtime phase
+ *
+ * This helper returns whether the firmware has transitioned into the
+ * UEFI runtime phase, meaning that ExitBootServices() has been invoked.
+ *
+ * Return:
+ *   true  - The system is operating in UEFI runtime mode.
+ *   false - The system is still in the boot services phase.
+ */
+static bool __efi_runtime efi_at_runtime(void)
+{
+	return ebs_called;
+}
+
 /**
  * get_connection() - Retrieve OP-TEE session for a specific UUID.
  *
@@ -169,6 +195,28 @@ static efi_status_t optee_mm_communicate(void *comm_buf, ulong dsize)
 }
 
 #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
+/**
+ * ffa_map_sp_event() - Map MM SP response to errno
+ * @sp_event_ret: MM SP return code from MM SP notification
+ *
+ * Convert the MM SP return code into a standard U-Boot errno. This helper
+ * is marked __efi_runtime so it can be shared by both the boot and runtime
+ * FF-A notification paths.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int __efi_runtime ffa_map_sp_event(int sp_event_ret)
+{
+	int idx = -sp_event_ret;
+
+	if (sp_event_ret == MM_SUCCESS)
+		return 0;
+	if (idx > 0 && idx < (int)ARRAY_SIZE(mm_sp_errmap) &&
+	    mm_sp_errmap[idx])
+		return mm_sp_errmap[idx];
+	return -EACCES;
+}
+
 /**
  * ffa_notify_mm_sp() - Announce there is data in the shared buffer
  *
@@ -177,52 +225,36 @@ static efi_status_t optee_mm_communicate(void *comm_buf, ulong dsize)
  * This is a blocking call during which trusted world has exclusive access
  * to the MM shared buffer.
  *
- * Return:
- *
- * 0 on success
+ * Return: 0 on success
  */
-static int ffa_notify_mm_sp(void)
+static int __efi_runtime ffa_notify_mm_sp(void)
 {
 	struct ffa_send_direct_data msg = {0};
 	int ret;
 	int sp_event_ret;
-	struct udevice *dev;
+	bool at_runtime = efi_at_runtime();
 
-	ret = uclass_first_device_err(UCLASS_FFA, &dev);
-	if (ret) {
-		log_err("EFI: Cannot find FF-A bus device, notify MM SP failure\n");
-		return ret;
-	}
+	msg.data0 = CONFIG_FFA_SHARED_MM_BUF_OFFSET;
+
+	if (at_runtime) {
+		ret = ffa_sync_send_receive_runtime(mm_sp_id, &msg, 1);
+	} else {
+		struct udevice *dev;
 
-	msg.data0 = CONFIG_FFA_SHARED_MM_BUF_OFFSET; /* x3 */
+		ret = uclass_first_device_err(UCLASS_FFA, &dev);
+		if (ret) {
+			log_err("EFI: Cannot find FF-A bus device, notify MM SP failure\n");
+			return ret;
+		}
 
-	ret = ffa_sync_send_receive(dev, mm_sp_id, &msg, 1);
+		ret = ffa_sync_send_receive(dev, mm_sp_id, &msg, 1);
+	}
 	if (ret)
 		return ret;
 
-	sp_event_ret = msg.data0; /* x3 */
-
-	switch (sp_event_ret) {
-	case MM_SUCCESS:
-		ret = 0;
-		break;
-	case MM_NOT_SUPPORTED:
-		ret = -EINVAL;
-		break;
-	case MM_INVALID_PARAMETER:
-		ret = -EPERM;
-		break;
-	case MM_DENIED:
-		ret = -EACCES;
-		break;
-	case MM_NO_MEMORY:
-		ret = -EBUSY;
-		break;
-	default:
-		ret = -EACCES;
-	}
+	sp_event_ret = msg.data0;
 
-	return ret;
+	return ffa_map_sp_event(sp_event_ret);
 }
 
 /**
@@ -266,36 +298,41 @@ static int ffa_discover_mm_sp_id(void)
 }
 
 /**
- * ffa_mm_communicate() - Exchange EFI services data with  the MM partition using FF-A
+ * ffa_mm_communicate() - Exchange EFI services data with the MM partition using FF-A
  * @comm_buf:		locally allocated communication buffer used for rx/tx
- * @dsize:				communication buffer size
+ * @comm_buf_size:	communication buffer size
  *
  * Issue a door bell event to notify the MM partition (SP) running in OP-TEE
  * that there is data to read from the shared buffer.
  * Communication with the MM SP is performed using FF-A transport.
  * On the event, MM SP can read the data from the buffer and
  * update the MM shared buffer with response data.
- * The response data is copied back to the communication buffer.
- *
- * Return:
+ * The response data is copied back to the communication buffer during the
+ * boot phase. At runtime, the communication buffer is already the FF-A
+ * shared buffer and is updated in place.
  *
- * EFI status code
+ * Return: EFI status code
  */
-static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
+static efi_status_t __efi_runtime ffa_mm_communicate(void *comm_buf,
+						     ulong comm_buf_size)
 {
 	ulong tx_data_size;
 	int ffa_ret;
 	efi_status_t efi_ret;
 	struct efi_mm_communicate_header *mm_hdr;
-	void *virt_shared_buf;
+	u8 *shared_buf;
+	bool at_runtime = efi_at_runtime();
 
 	if (!comm_buf)
 		return EFI_INVALID_PARAMETER;
 
-	/* Discover MM partition ID at boot time */
-	if (!mm_sp_id && ffa_discover_mm_sp_id()) {
-		log_err("EFI: Failure to discover MM SP ID at boot time, FF-A MM comms failure\n");
-		return EFI_UNSUPPORTED;
+	if (!mm_sp_id) {
+		if (at_runtime)
+			return EFI_UNSUPPORTED;
+		if (ffa_discover_mm_sp_id()) {
+			log_err("EFI: Failure to discover MM SP ID at boot time, FF-A MM comms failure\n");
+			return EFI_UNSUPPORTED;
+		}
 	}
 
 	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
@@ -304,30 +341,61 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
 	if (comm_buf_size != tx_data_size || tx_data_size > CONFIG_FFA_SHARED_MM_BUF_SIZE)
 		return EFI_INVALID_PARAMETER;
 
-	/* Copy the data to the shared buffer */
-
-	virt_shared_buf = map_sysmem((phys_addr_t)CONFIG_FFA_SHARED_MM_BUF_ADDR, 0);
-	memcpy(virt_shared_buf, comm_buf, tx_data_size);
+	if (at_runtime) {
+		shared_buf = comm_buf;
+	} else {
+		/* Copy the data to the shared buffer */
+		shared_buf = map_sysmem((phys_addr_t)CONFIG_FFA_SHARED_MM_BUF_ADDR, 0);
+		memcpy(shared_buf, comm_buf, tx_data_size);
+	}
 
 	/*
-	 * The secure world might have cache disabled for
-	 * the device region used for shared buffer (which is the case for Optee).
-	 * In this case, the secure world reads the data from DRAM.
-	 * Let's flush the cache so the DRAM is updated with the latest data.
+	 * Shared buffer cache maintenance for FF-A / OP-TEE communication:
+	 *
+	 * NS -> S (request path):
+	 *
+	 * The non-secure side populates the shared buffer. If the buffer is cached
+	 * in NS, the updated bytes may reside in dirty D-cache lines and not yet be
+	 * visible in DDR. Since the secure world typically reads the shared buffer
+	 * directly from DDR (e.g. with caches disabled / non-coherent mapping), we
+	 * must clean the corresponding cache lines to the Point of Coherency (PoC)
+	 * before entering secure world.
+	 *
+	 * S -> NS (response path):
+	 *
+	 * The secure world may update the same shared buffer in DDR. After returning
+	 * to non-secure, any cached copies of that region in NS may be stale. We
+	 * therefore invalidate the shared buffer range after the FF-A call to drop
+	 * those lines and force subsequent reads to fetch the latest data from DDR.
+	 *
+	 * Note: Whole-cache invalidation must not be used in EFI runtime context.
+	 * After ExitBootServices(), the OS owns the cache hierarchy; global
+	 * invalidation could drop OS dirty lines and violate the OS coherency
+	 * model. Always operate on the shared buffer range only.
 	 */
-#ifdef CONFIG_ARM64
-	invalidate_dcache_all();
-#endif
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_ADDR %
+			     CONFIG_SYS_CACHELINE_SIZE);
+		BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_SIZE %
+			     CONFIG_SYS_CACHELINE_SIZE);
+		flush_dcache_range((unsigned long)shared_buf,
+				   (unsigned long)(shared_buf +
+					   CONFIG_FFA_SHARED_MM_BUF_SIZE));
+	}
 
 	/* Announce there is data in the shared buffer */
-
 	ffa_ret = ffa_notify_mm_sp();
 
+	if (IS_ENABLED(CONFIG_ARM64))
+		invalidate_dcache_range((unsigned long)shared_buf,
+					(unsigned long)(shared_buf +
+						CONFIG_FFA_SHARED_MM_BUF_SIZE));
+
 	switch (ffa_ret) {
 	case 0: {
 		ulong rx_data_size;
-		/* Copy the MM SP response from the shared buffer to the communication buffer */
-		rx_data_size = ((struct efi_mm_communicate_header *)virt_shared_buf)->message_len +
+
+		rx_data_size = ((struct efi_mm_communicate_header *)shared_buf)->message_len +
 			sizeof(efi_guid_t) +
 			sizeof(size_t);
 
@@ -336,7 +404,8 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
 			break;
 		}
 
-		memcpy(comm_buf, virt_shared_buf, rx_data_size);
+		if (!at_runtime)
+			memcpy(comm_buf, shared_buf, rx_data_size);
 		efi_ret = EFI_SUCCESS;
 		break;
 	}
@@ -356,28 +425,34 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
 		efi_ret = EFI_ACCESS_DENIED;
 	}
 
-	unmap_sysmem(virt_shared_buf);
+	if (!at_runtime)
+		unmap_sysmem(shared_buf);
 	return efi_ret;
 }
 
 /**
  * get_mm_comms() - detect the available MM transport
  *
- * Make sure the FF-A bus is probed successfully
- * which means FF-A communication with secure world works and ready
- * for use.
- *
- * If FF-A bus is not ready, use OPTEE comms.
+ * Make sure the FF-A bus is probed successfully during the boot phase,
+ * which means FF-A communication with secure world works and is ready for
+ * use. During the runtime phase, only the FF-A runtime transport can be
+ * selected.
  *
- * Return:
+ * If FF-A bus is not ready at boot, use OP-TEE comms.
  *
- * MM_COMMS_FFA or MM_COMMS_OPTEE
+ * Return: MM_COMMS_FFA, MM_COMMS_OPTEE, or MM_COMMS_UNDEFINED
  */
-static enum mm_comms_select get_mm_comms(void)
+static enum mm_comms_select __efi_runtime get_mm_comms(void)
 {
 	struct udevice *dev;
 	int ret;
 
+	if (efi_at_runtime()) {
+		if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE))
+			return MM_COMMS_FFA;
+		return MM_COMMS_UNDEFINED;
+	}
+
 	ret = uclass_first_device_err(UCLASS_FFA, &dev);
 	if (ret) {
 		log_debug("EFI: Cannot find FF-A bus device, trying Optee comms\n");
@@ -389,8 +464,8 @@ static enum mm_comms_select get_mm_comms(void)
 #endif
 
 /**
- * mm_communicate() - Adjust the communication buffer to the MM SP and send
- * it to OP-TEE
+ * mm_communicate() - Adjust the communication buffer to the MM SP and send it
+ * to the selected MM transport
  *
  * @comm_buf:		locally allocated communication buffer
  * @dsize:		buffer size
@@ -400,11 +475,12 @@ static enum mm_comms_select get_mm_comms(void)
  * When using the u-boot OP-TEE driver, StandAlonneMM is supported.
  * When using the u-boot FF-A  driver, any MM SP is supported.
  *
- * Return:		status code
+ * Return: status code
  */
-static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
+static efi_status_t __efi_runtime mm_communicate(u8 *comm_buf,
+						 efi_uintn_t dsize)
 {
-	efi_status_t ret;
+	efi_status_t ret = EFI_UNSUPPORTED;
 	struct efi_mm_communicate_header *mm_hdr;
 	struct smm_variable_communicate_header *var_hdr;
 #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
@@ -419,14 +495,15 @@ static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
 	mm_comms = get_mm_comms();
 	if (mm_comms == MM_COMMS_FFA)
 		ret = ffa_mm_communicate(comm_buf, dsize);
-	else
+	else if (mm_comms == MM_COMMS_OPTEE)
 		ret = optee_mm_communicate(comm_buf, dsize);
 #else
-		ret = optee_mm_communicate(comm_buf, dsize);
+	ret = optee_mm_communicate(comm_buf, dsize);
 #endif
 
 	if (ret != EFI_SUCCESS) {
-		log_err("%s failed!\n", __func__);
+		if (!efi_at_runtime())
+			log_err("%s failed!\n", __func__);
 		return ret;
 	}
 
@@ -434,8 +511,55 @@ static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
 }
 
 /**
- * setup_mm_hdr() -	Allocate a buffer for StandAloneMM and initialize the
- *			header data.
+ * get_comm_buf() - Obtain a communication buffer for MM/FF-A exchange
+ * @payload_size: size of the payload that will be appended to the
+ *                MM communication header
+ * This helper returns a buffer suitable for constructing an
+ * EFI_MM_COMMUNICATE message. During the boot phase a new buffer is
+ * dynamically allocated. After ExitBootServices(), dynamic
+ * allocation is no longer permitted, and all runtime communication must
+ * use the statically reserved FF-A shared buffer.
+ *
+ * Return:
+ *   Pointer to a valid communication buffer on success,
+ *   NULL if allocation fails during the boot phase.
+ */
+static __efi_runtime u8 *get_comm_buf(efi_uintn_t payload_size)
+{
+	efi_uintn_t comm_buf_size;
+	u8 *comm_buf;
+
+	comm_buf_size = MM_COMMUNICATE_HEADER_SIZE +
+			MM_VARIABLE_COMMUNICATE_SIZE +
+			payload_size;
+
+	/*
+	 * After ExitBootServices(), dynamic allocation is no longer permitted.
+	 * Use the predefined FF-A shared buffer at runtime; otherwise allocate
+	 * a fresh buffer during the boot phase.
+	 */
+	if (efi_at_runtime()) {
+		if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
+			if (comm_buf_size > CONFIG_FFA_SHARED_MM_BUF_SIZE)
+				return NULL;
+			comm_buf = ffa_shared_buf;
+			if (!comm_buf)
+				return NULL;
+			efi_memset_runtime(comm_buf, 0, CONFIG_FFA_SHARED_MM_BUF_SIZE);
+		} else {
+			return NULL;
+		}
+	} else {
+		comm_buf = calloc(1, comm_buf_size);
+		if (!comm_buf)
+			return NULL;
+	}
+	return comm_buf;
+}
+
+/**
+ * setup_mm_hdr() -	Obtain a communication buffer for StandAloneMM and
+ *			initialize the MM header
  *
  * @dptr:		pointer address of the corresponding StandAloneMM
  *			function
@@ -444,10 +568,11 @@ static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
  * @ret:		EFI return code
  * Return:		buffer or NULL
  */
-static u8 *setup_mm_hdr(void **dptr, efi_uintn_t payload_size,
-			efi_uintn_t func, efi_status_t *ret)
+static __efi_runtime u8 *setup_mm_hdr(void **dptr, efi_uintn_t payload_size,
+				      efi_uintn_t func, efi_status_t *ret)
 {
-	const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
+	static const __efi_runtime_rodata efi_guid_t mm_var_guid =
+		EFI_MM_VARIABLE_GUID;
 	struct efi_mm_communicate_header *mm_hdr;
 	struct smm_variable_communicate_header *var_hdr;
 	u8 *comm_buf;
@@ -465,16 +590,15 @@ static u8 *setup_mm_hdr(void **dptr, efi_uintn_t payload_size,
 		return NULL;
 	}
 
-	comm_buf = calloc(1, MM_COMMUNICATE_HEADER_SIZE +
-			  MM_VARIABLE_COMMUNICATE_SIZE +
-			  payload_size);
+	comm_buf = get_comm_buf(payload_size);
 	if (!comm_buf) {
 		*ret = EFI_OUT_OF_RESOURCES;
 		return NULL;
 	}
 
 	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
-	guidcpy(&mm_hdr->header_guid, &mm_var_guid);
+	efi_memcpy_runtime(&mm_hdr->header_guid, &mm_var_guid,
+			   sizeof(mm_hdr->header_guid));
 	mm_hdr->message_len = MM_VARIABLE_COMMUNICATE_SIZE + payload_size;
 
 	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
@@ -982,6 +1106,9 @@ void efi_variables_boot_exit_notify(void)
 			efi_get_next_variable_name_runtime;
 	efi_runtime_services.set_variable = efi_set_variable_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
+
+	/* Record that ExitBootServices() has been called */
+	ebs_called = true;
 }
 
 /**
@@ -1010,5 +1137,26 @@ efi_status_t efi_init_variables(void)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
+	if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
+		/*
+		 * The FF-A shared buffer is accessed by EFI runtime services, so it
+		 * must be marked as runtime memory in the EFI memory map.
+		 *
+		 * CONFIG_FFA_SHARED_MM_BUF_ADDR is expected to be EFI-page aligned.
+		 */
+		ffa_shared_buf = (void *)CONFIG_FFA_SHARED_MM_BUF_ADDR;
+		ret = efi_add_memory_map(CONFIG_FFA_SHARED_MM_BUF_ADDR,
+					 CONFIG_FFA_SHARED_MM_BUF_SIZE,
+					 EFI_RUNTIME_SERVICES_DATA);
+		if (ret != EFI_SUCCESS) {
+			log_err("EFI: failed to add FF-A shared buffer to runtime map (%lu)\n",
+				ret);
+			return ret;
+		}
+		log_info("EFI: FF-A shared buffer runtime map: addr=0x%lx size=0x%lx\n",
+			 (ulong)CONFIG_FFA_SHARED_MM_BUF_ADDR,
+			 (ulong)CONFIG_FFA_SHARED_MM_BUF_SIZE);
+	}
+
 	return EFI_SUCCESS;
 }
-- 
2.34.1

