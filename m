Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75030C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EC83811EE;
	Wed, 29 Jul 2026 12:28:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GcJdiOCkUqzg; Wed, 29 Jul 2026 12:28:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEA7F81221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328114;
	bh=KWspMXDWMIkoIYij8Ie+W9HoJtV4QiMpMOzmOB6bxJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KRye8Jimi02aKgjL09paIuuseb11kRfvMOOVzypWBpawfpw5yWL0mARCawWMIZIad
	 gGM7VmvVMvpJCEMy71ar3lgghet4ry86EwBMnDDcKE279im91LZ1KiJX/PlondNph/
	 7zk3dzC2F6BohXniy8CtNbf+vK0w6apadm2qwiz0rXHIldICFF8km+rb4xYt1xoTAb
	 FGpUqsorF1zEwsTkCK6KQwzeAxAiG6kNV9nFnYlbc738RIhlPT02qYyT2a4oO+Qvah
	 Jsoerjm52qGki0i9kV92aVaKkq/UOY1lPGD20DFXLOsilDH+N9kNaDQ1R2mkoJxQiU
	 BrUacJMP83dSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEA7F81221;
	Wed, 29 Jul 2026 12:28:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 29ABE45B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1023F40891
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tNP0aYd37G58 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4691440879
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4691440879
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4691440879
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:08 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88806849BC; Wed, 29 Jul 2026 10:52:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2CDB88404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:52:04 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68185169C;
 Wed, 29 Jul 2026 01:51:59 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 113683F66F;
 Wed, 29 Jul 2026 01:52:01 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 11/22] efi_loader: make FF-A MM communication runtime-safe
Date: Wed, 29 Jul 2026 09:51:13 +0100
Message-Id: <20260729085124.2618817-12-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:28:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1785315123; bh=ctXhchMSoH7MGffNsUcxl76YWb4Dy/y9c5KiG3pDLKU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kkdfGajCA6N8xyj9icvHCxGwL1lDyscOqkrHFqIqLNHd9fBD/tRvJv3w8861N1u4q
 /3WXa2SbBb+7a+unNaOlOfpH29k6YkJ996L1W3OiI6OQ6041aYPTsPdw+X4FCbL5BF
 dmt5ag95hZx/Fk2Lpg/XIlFQ8kOkcx6iUgT06f0o=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=kkdfGajC
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="kkdfGajC"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Make the FF-A MM communication helper usable from EFI runtime code. The
boot path copies requests into the configured FF-A shared buffer, while
the runtime path operates directly on the runtime communication buffer.

Use range-based cache maintenance on the active shared-buffer request
and response sizes, and document the shared-buffer cacheline-alignment
requirements in Kconfig.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 lib/efi_loader/Kconfig            |   4 +
 lib/efi_loader/efi_variable_tee.c | 130 +++++++++++++++++++++---------
 2 files changed, 95 insertions(+), 39 deletions(-)

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
index 4ebba83036c..8de258bb36b 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -22,6 +22,7 @@
 #include <efi_api.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
+#include <linux/build_bug.h>
 #include <linux/kernel.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -301,77 +302,128 @@ static int ffa_discover_mm_sp_id(void)
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
+ * The response data is copied back to the communication buffer during the
+ * boot phase. At runtime, the communication buffer is already the FF-A
+ * shared buffer and is updated in place.
  *
- * Return:
- *
- * EFI status code
+ * Return: EFI status code
  */
-static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
+static efi_status_t __efi_runtime ffa_mm_communicate(void *comm_buf,
+						     ulong comm_buf_size)
 {
+	ulong hdr_cache_size;
 	ulong tx_data_size;
+	ulong tx_cache_size;
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
+		if (ffa_discover_mm_sp_id())
+			return EFI_UNSUPPORTED;
 	}
 
 	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
 	tx_data_size = mm_hdr->message_len + sizeof(efi_guid_t) + sizeof(size_t);
+	hdr_cache_size = ALIGN(sizeof(*mm_hdr), CONFIG_SYS_CACHELINE_SIZE);
+	tx_cache_size = ALIGN(tx_data_size, CONFIG_SYS_CACHELINE_SIZE);
 
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
+					   tx_cache_size));
+	}
 
 	/* Announce there is data in the shared buffer */
-
 	ffa_ret = ffa_notify_mm_sp();
 
 	switch (ffa_ret) {
 	case 0: {
 		ulong rx_data_size;
-		/* Copy the MM SP response from the shared buffer to the communication buffer */
-		rx_data_size = ((struct efi_mm_communicate_header *)virt_shared_buf)->message_len +
+		ulong rx_cache_size;
+
+		if (IS_ENABLED(CONFIG_ARM64))
+			invalidate_dcache_range((unsigned long)shared_buf,
+						(unsigned long)(shared_buf +
+							hdr_cache_size));
+
+		rx_data_size = ((struct efi_mm_communicate_header *)shared_buf)->message_len +
 			sizeof(efi_guid_t) +
 			sizeof(size_t);
 
-		if (rx_data_size > comm_buf_size) {
+		if (rx_data_size > comm_buf_size ||
+		    rx_data_size > CONFIG_FFA_SHARED_MM_BUF_SIZE) {
 			efi_ret = EFI_OUT_OF_RESOURCES;
 			break;
 		}
 
-		memcpy(comm_buf, virt_shared_buf, rx_data_size);
+		if (IS_ENABLED(CONFIG_ARM64)) {
+			rx_cache_size = ALIGN(rx_data_size,
+					      CONFIG_SYS_CACHELINE_SIZE);
+			if (rx_cache_size > hdr_cache_size)
+				invalidate_dcache_range((unsigned long)(shared_buf +
+							hdr_cache_size),
+						(unsigned long)(shared_buf +
+							rx_cache_size));
+		}
+
+		if (!at_runtime)
+			memcpy(comm_buf, shared_buf, rx_data_size);
 		efi_ret = EFI_SUCCESS;
 		break;
 	}
@@ -391,7 +443,8 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
 		efi_ret = EFI_ACCESS_DENIED;
 	}
 
-	unmap_sysmem(virt_shared_buf);
+	if (!at_runtime)
+		unmap_sysmem(shared_buf);
 	return efi_ret;
 }
 
@@ -427,8 +480,8 @@ static enum mm_comms_select __efi_runtime get_mm_comms(void)
 #endif
 
 /**
- * mm_communicate() - Adjust the communication buffer to the MM SP and send
- * it to OP-TEE
+ * mm_communicate() - Adjust the communication buffer to the MM SP and send it
+ * to the selected MM transport
  *
  * @comm_buf:		locally allocated communication buffer
  * @dsize:		buffer size
@@ -438,11 +491,12 @@ static enum mm_comms_select __efi_runtime get_mm_comms(void)
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
@@ -457,16 +511,14 @@ static efi_status_t mm_communicate(u8 *comm_buf, efi_uintn_t dsize)
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
 
-	if (ret != EFI_SUCCESS) {
-		log_err("%s failed!\n", __func__);
+	if (ret != EFI_SUCCESS)
 		return ret;
-	}
 
 	return var_hdr->ret_status;
 }
-- 
2.34.1

