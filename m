Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD059C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 09:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 285778749D;
	Thu, 16 Nov 2023 10:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kToM6z7s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29ED0874A1; Thu, 16 Nov 2023 10:29:43 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7530E8749D
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6A2423F2A8; 
 Thu, 16 Nov 2023 09:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700126975;
 bh=/U0K7gXAemHirbAs0Q+yr2RwCnFo6Kc+4Eip2lvXVVU=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=kToM6z7sdKzjzIyZbVT6S1m+3Mg+CVDhl6M0n3Gx2XdGBdpciY5gDnx/gzaYL60Ex
 531HfR6talKmfxyV65GFuKk6GdsYGl1gcd3H0l8xsEmglx4CwI328yvKvdedh5WDyC
 RH4LqzgCgEmm32EmdaqqVidOTmsiooPOcdufUgPsW4sHRQ0R5a9p1Z/iJa6zlABKxu
 Y/O/UA8Ww52URYpUGl8LtGLWSmH6FQBsW5pnXZVXjbSGnq7APz6c9/cLDMJ3W02Y3+
 kJsrd/lFKEkmcXtNy6BU6vXESRvZdKZdHKV59Zao80Tug28zTT9sYcpT1AU6G4IyrC
 fzyyi/EiuvSOw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: create memory reservations in ACPI case
Date: Thu, 16 Nov 2023 10:29:28 +0100
Message-Id: <20231116092928.21633-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

ACPI tables cannot convey memory reservations for least ARM and RISC-V.
x86 uses the BIOS E820 table for this purpose. We cannot simply ignore the
device-tree when booting via ACPI. We have to assign EfiReservedMemory
according to the prior stage device-tree ($fdtaddr) or as fallback the
control device-tree ($fdtcontroladdr).

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/bootefi.c           | 25 ++++++++++---------------
 lib/efi_loader/Makefile |  2 --
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 20e5c94a33..395b0629de 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -162,8 +162,6 @@ static efi_status_t efi_env_set_load_options(efi_handle_t handle,
 	return ret;
 }
 
-#if !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
-
 /**
  * copy_fdt() - Copy the device tree to a new location available to EFI
  *
@@ -237,8 +235,6 @@ static void *get_config_table(const efi_guid_t *guid)
 	return NULL;
 }
 
-#endif /* !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) */
-
 /**
  * efi_install_fdt() - install device tree
  *
@@ -258,18 +254,15 @@ static void *get_config_table(const efi_guid_t *guid)
  */
 efi_status_t efi_install_fdt(void *fdt)
 {
+	struct bootm_headers img = { 0 };
+	efi_status_t ret;
+
 	/*
 	 * The EBBR spec requires that we have either an FDT or an ACPI table
 	 * but not both.
 	 */
-#if CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
-	if (fdt) {
+	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) && fdt)
 		log_warning("WARNING: Can't have ACPI table and device tree - ignoring DT.\n");
-		return EFI_SUCCESS;
-	}
-#else
-	struct bootm_headers img = { 0 };
-	efi_status_t ret;
 
 	if (fdt == EFI_FDT_USE_INTERNAL) {
 		const char *fdt_opt;
@@ -302,6 +295,12 @@ efi_status_t efi_install_fdt(void *fdt)
 		return EFI_LOAD_ERROR;
 	}
 
+	/* Create memory reservations as indicated by the device tree */
+	efi_carve_out_dt_rsv(fdt);
+
+	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE))
+		return EFI_SUCCESS;
+
 	/* Prepare device tree for payload */
 	ret = copy_fdt(&fdt);
 	if (ret) {
@@ -314,9 +313,6 @@ efi_status_t efi_install_fdt(void *fdt)
 		return EFI_LOAD_ERROR;
 	}
 
-	/* Create memory reservations as indicated by the device tree */
-	efi_carve_out_dt_rsv(fdt);
-
 	efi_try_purge_kaslr_seed(fdt);
 
 	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
@@ -333,7 +329,6 @@ efi_status_t efi_install_fdt(void *fdt)
 		log_err("ERROR: failed to install device tree\n");
 		return ret;
 	}
-#endif /* GENERATE_ACPI_TABLE */
 
 	return EFI_SUCCESS;
 }
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 8d31fc61c6..d476df112b 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -51,9 +51,7 @@ obj-y += efi_console.o
 obj-y += efi_device_path.o
 obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_device_path_to_text.o
 obj-$(CONFIG_EFI_DEVICE_PATH_UTIL) += efi_device_path_utilities.o
-ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
 obj-y += efi_dt_fixup.o
-endif
 obj-y += efi_file.o
 obj-$(CONFIG_EFI_LOADER_HII) += efi_hii.o
 obj-y += efi_image_loader.o
-- 
2.40.1

