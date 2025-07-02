Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1649C83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 15:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6536082F8F;
	Wed,  2 Jul 2025 17:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABD688303B; Wed,  2 Jul 2025 17:26:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 64D6F82F6D
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 17:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED4EA2F28;
 Wed,  2 Jul 2025 08:25:51 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.38.90])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9CDF3F6A8;
 Wed,  2 Jul 2025 08:26:04 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, abdellatif.elkhlifi@arm.com,
 Davidson kumaresan <davidson.kumaresan@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 13/25] efi_loader: fwu_arm_psa: Add set_image and
 get_image_info support
Date: Wed,  2 Jul 2025 16:25:16 +0100
Message-Id: <20250702152528.1180414-14-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
References: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Implement set_image and get_image_info through RAW functions

The implementation is done using efi_firmware_raw_set_image()
and efi_firmware_get_image_info()

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>
---
 lib/efi_loader/efi_firmware.c | 97 ++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 37 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 75501e21557..dad80beb23e 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -4,6 +4,12 @@
  *
  *  Copyright (c) 2020 Linaro Limited
  *			Author: AKASHI Takahiro
+ *
+ * Copyright 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *
+ * Authors:
+ *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+ *   Davidson kumaresan <davidson.kumaresan@arm.com>
  */
 
 #define LOG_CATEGORY LOGC_EFI
@@ -14,6 +20,7 @@
 #include <efi_variable.h>
 #include <env.h>
 #include <fwu.h>
+#include <fwu_arm_psa.h>
 #include <image.h>
 #include <signatures.h>
 
@@ -601,10 +608,21 @@ efi_status_t EFIAPI efi_firmware_get_image_info(
 	     !descriptor_size || !package_version || !package_version_name))
 		return EFI_EXIT(EFI_INVALID_PARAMETER);
 
-	ret = efi_fill_image_desc_array(image_info_size, image_info,
-					descriptor_version, descriptor_count,
-					descriptor_size, package_version,
-					package_version_name);
+	if (IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
+		ret = fwu_arm_psa_get_image_info(image_info_size, image_info,
+						 descriptor_version,
+						 descriptor_count,
+						 descriptor_size,
+						 package_version,
+						 package_version_name);
+	} else {
+		ret = efi_fill_image_desc_array(image_info_size, image_info,
+						descriptor_version,
+						descriptor_count,
+						descriptor_size,
+						package_version,
+						package_version_name);
+	}
 
 	return EFI_EXIT(ret);
 }
@@ -749,48 +767,53 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 	if (status != EFI_SUCCESS)
 		return EFI_EXIT(status);
 
-	/*
-	 * dfu_alt_num is assigned from 0 while image_index starts from 1.
-	 * dfu_alt_num is calculated by (image_index - 1) when multi bank update
-	 * is not used.
-	 */
-	dfu_alt_num = image_index - 1;
-	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+	if (IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
+		if (fwu_update_image(image, image_index, image_size))
+			return EFI_EXIT(EFI_DEVICE_ERROR);
+	} else {
 		/*
-		 * Based on the value of update bank, derive the
-		 * image index value.
+		 * dfu_alt_num is assigned from 0 while image_index starts from 1.
+		 * dfu_alt_num is calculated by (image_index - 1) when multi bank update
+		 * is not used.
 		 */
-		ret = fwu_get_dfu_alt_num(image_index, &dfu_alt_num);
-		if (ret) {
-			log_debug("Unable to get FWU image_index\n");
-			return EFI_EXIT(EFI_DEVICE_ERROR);
+		dfu_alt_num = image_index - 1;
+		if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+			/*
+			 * Based on the value of update bank, derive the
+			 * image index value.
+			 */
+			ret = fwu_get_dfu_alt_num(image_index, &dfu_alt_num);
+			if (ret) {
+				log_debug("Unable to get FWU image_index\n");
+				return EFI_EXIT(EFI_DEVICE_ERROR);
+			}
 		}
-	}
 
-	orig_dfu_env = env_get("dfu_alt_info");
-	if (orig_dfu_env) {
-		orig_dfu_env = strdup(orig_dfu_env);
-		if (!orig_dfu_env) {
-			log_err("strdup() failed!\n");
-			return EFI_EXIT(EFI_OUT_OF_RESOURCES);
+		orig_dfu_env = env_get("dfu_alt_info");
+		if (orig_dfu_env) {
+			orig_dfu_env = strdup(orig_dfu_env);
+			if (!orig_dfu_env) {
+				log_err("strdup() failed!\n");
+				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
+			}
+		}
+		if (env_set("dfu_alt_info", update_info.dfu_string)) {
+			log_err("Unable to set env variable \"dfu_alt_info\"!\n");
+			free(orig_dfu_env);
+			return EFI_EXIT(EFI_DEVICE_ERROR);
 		}
-	}
-	if (env_set("dfu_alt_info", update_info.dfu_string)) {
-		log_err("Unable to set env variable \"dfu_alt_info\"!\n");
-		free(orig_dfu_env);
-		return EFI_EXIT(EFI_DEVICE_ERROR);
-	}
 
-	ret = dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
-			       NULL, NULL);
+		ret = dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
+				       NULL, NULL);
 
-	if (env_set("dfu_alt_info", orig_dfu_env))
-		log_warning("Unable to restore env variable \"dfu_alt_info\".  Further DFU operations may fail!\n");
+		if (env_set("dfu_alt_info", orig_dfu_env))
+			log_warning("Unable to restore env variable \"dfu_alt_info\".  Further DFU operations may fail!\n");
 
-	free(orig_dfu_env);
+		free(orig_dfu_env);
 
-	if (ret)
-		return EFI_EXIT(EFI_DEVICE_ERROR);
+		if (ret)
+			return EFI_EXIT(EFI_DEVICE_ERROR);
+	}
 
 	efi_firmware_set_fmp_state_var(&state, image_index);
 
-- 
2.25.1

