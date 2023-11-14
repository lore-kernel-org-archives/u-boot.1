Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D9AC4167D
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 09:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98BB88743F;
	Tue, 14 Nov 2023 10:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hwarLweO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9F0E86FB2; Tue, 14 Nov 2023 10:26:46 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B12087271
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 10:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6c431b91b2aso4661650b3a.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 01:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699954002; x=1700558802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CkSBtwaeB8jyAuuM+8xPXjQ7oYypGnan+rmjksDicoY=;
 b=hwarLweOvcCr/UwTr7E1AK56A0C8KYhjsve0rjXrpJZdBOGsZwLPf5bOAa+nXHhWPj
 wtmYIolLUMukIsoM7XX/Iz7LccXVXoRD95FCATODDhlwjdFwQN99I8qCDQf57tWbX2b6
 vpQjz8rUs4PCKiAbgBGUGBMs6NreasZgYNxH8BHWTrWUiY0qRNETgIVPcZiH26RCSTt5
 A2gwMd9kiRLtolMO3uzQ8LBO63E0NhTkeqJMmF97IPziL01wFbmQDY41JoZzdkKsyPLE
 xkNID8AIhjmSDThxiqwCWIvB7ICoX/vphkKKKtmqjE+0pWS9rz8gFs3QSzPBfguuyECL
 OmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699954002; x=1700558802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CkSBtwaeB8jyAuuM+8xPXjQ7oYypGnan+rmjksDicoY=;
 b=ZF733BTTPK9z+fieTXoT8pCZBQcHMhiBdb+cpOu+fy6WNK7ZRYVoSGNi37rCdbfHXN
 KG8d5om7plmQndwaffwSWqQIR0YwNHDl7IKKm3sXIHhJ/MQz5dN4BVIv9QJ1wTL/haMW
 pGmWyH25zAa/dj86Zzzdf0wL/3n1ok3r8nCT54hjAOzzmMlT9EUuW2mRdten/8yneQOM
 y8QFzONIH60AiwlylCIB0Ff33xX4lNC3VH/mNvki7+8Y/VmEBqXOYpxBUeA9WO44osf2
 Z/IZGwds1cRGMUCoBQrMMMhJISAavgmETNDJedpaWWs/r7R0PDyvbpi043HhumBr0XWG
 By+w==
X-Gm-Message-State: AOJu0YzbJMThePK6c5P72/NMVdcr8PTNI2+4vjYvFZVYqvcX3WCcaXhH
 iAwcRoLEuLx8fEDlhLfepnJOAmnS3VEJ13gQ4+c=
X-Google-Smtp-Source: AGHT+IGoSXDkdaSYw+cZ4J7ZSoDjEzOfH1DNfBS2Ayz7UNaDWMxUOtsAD7Nam/PZwqGkDRVkopUmtQ==
X-Received: by 2002:a05:6a00:39a5:b0:6c3:4cac:f9ad with SMTP id
 fi37-20020a056a0039a500b006c34cacf9admr7930839pfb.19.1699954001826; 
 Tue, 14 Nov 2023 01:26:41 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 fh30-20020a056a00391e00b006b8bb35e313sm814457pfb.103.2023.11.14.01.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 01:26:41 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] efi_loader: support FMP versioning for FWU multi bank
 update
Date: Tue, 14 Nov 2023 18:25:08 +0900
Message-Id: <20231114092508.3955838-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114092508.3955838-1-masahisa.kojima@linaro.org>
References: <20231114092508.3955838-1-masahisa.kojima@linaro.org>
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

Current FMP versioning uses the FMPStateXXXX UEFI variables
that XXXX indicates image_index. When CONFIG_FWU_MULTI_BANK_UPDATE
is enabled, U-Boot instances installed in different banks
read the same FMPStateXXXX variable and it ends up with reading
wrong fw_version.

This commit includes the bank_index in the FMPStateXXYY variable.
XX indicates a bank_index, YY indicates an image_index.
With this, it keeps backward compatibility for the case that
CONFIG_FWU_MULTI_BANK_UPDATE is not enabled, bank_index is
always 0 for this case.

The bank index size is defined 4 bytes in FWU-PSA-A_DEN0118_1.0ALP3.pdf,
but 1-255 range is practically enough big. This commit adds the range
for FWU_NUM_BANKS since above XX(bank_index) has 1 byte.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_firmware.c | 63 ++++++++++++++++++++++++++---------
 lib/fwu_updates/Kconfig       |  1 +
 2 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 9c1a273926..6d3620a649 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -205,13 +205,33 @@ static
 void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_info,
 				    struct efi_fw_image *fw_array)
 {
-	u16 varname[13]; /* u"FmpStateXXXX" */
+	int err;
+	u16 varname[13]; /* u"FmpStateXXYY" */
 	efi_status_t ret;
 	efi_uintn_t size;
+	uint active_bank = 0, var_index;
 	struct fmp_state var_state = { 0 };
 
+	efi_firmware_get_lsv_from_dtb(fw_array->image_index,
+				      &fw_array->image_type_id,
+				      &image_info->lowest_supported_image_version);
+
+	image_info->version_name = NULL; /* not supported */
+	image_info->last_attempt_version = 0;
+	image_info->last_attempt_status = LAST_ATTEMPT_STATUS_SUCCESS;
+
+	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+		err = fwu_get_active_index(&active_bank);
+		if (err) {
+			log_debug("Unable to get active index\n");
+			image_info->version = 0;
+			return;
+		}
+	}
+
+	var_index = ((active_bank & 0xFF) << 8 | (fw_array->image_index & 0xFF));
 	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
-				fw_array->image_index);
+				var_index);
 	size = sizeof(var_state);
 	ret = efi_get_variable_int(varname, &fw_array->image_type_id,
 				   NULL, &size, &var_state, NULL);
@@ -219,14 +239,6 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
 		image_info->version = var_state.fw_version;
 	else
 		image_info->version = 0;
-
-	efi_firmware_get_lsv_from_dtb(fw_array->image_index,
-				      &fw_array->image_type_id,
-				      &image_info->lowest_supported_image_version);
-
-	image_info->version_name = NULL; /* not supported */
-	image_info->last_attempt_version = 0;
-	image_info->last_attempt_status = LAST_ATTEMPT_STATUS_SUCCESS;
 }
 
 /**
@@ -353,15 +365,20 @@ efi_status_t efi_firmware_capsule_authenticate(const void **p_image,
  * @state:		Pointer to fmp state
  * @image_index:	image index
  *
- * Update the FmpStateXXXX variable with the firmware update state.
+ * Update the FmpStateXXYY variable with the firmware update state.
+ * XX is a bank index, YY is an image_index
+ * When CONFIG_FWU_MULTI_BANK_UPDATE is not enabled, update_bank is always 0.
  *
  * Return:		status code
  */
 static
 efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_index)
 {
-	u16 varname[13]; /* u"FmpStateXXXX" */
+	int err;
+	u16 varname[13]; /* u"FmpStateXXYY" */
 	efi_status_t ret;
+	uint update_bank = 0;
+	unsigned int var_index;
 	efi_guid_t *image_type_id;
 	struct fmp_state var_state = { 0 };
 
@@ -369,9 +386,15 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
 	if (!image_type_id)
 		return EFI_INVALID_PARAMETER;
 
-	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
-				image_index);
+	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+		err = fwu_plat_get_update_index(&update_bank);
+		if (err)
+			return EFI_INVALID_PARAMETER;
+	}
 
+	var_index = ((update_bank & 0xFF) << 8 | (image_index & 0xFF));
+	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
+				var_index);
 	/*
 	 * Only the fw_version is set here.
 	 * lowest_supported_version in FmpState variable is ignored since
@@ -563,7 +586,11 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
 	if (fit_update(image))
 		return EFI_EXIT(EFI_DEVICE_ERROR);
 
-	efi_firmware_set_fmp_state_var(&state, image_index);
+	status = efi_firmware_set_fmp_state_var(&state, image_index);
+	if (status != EFI_SUCCESS) {
+		log_err("Set FmpState variable failed\n");
+		return EFI_EXIT(status);
+	}
 
 	return EFI_EXIT(EFI_SUCCESS);
 }
@@ -643,7 +670,11 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 			     NULL, NULL))
 		return EFI_EXIT(EFI_DEVICE_ERROR);
 
-	efi_firmware_set_fmp_state_var(&state, original_image_index);
+	status = efi_firmware_set_fmp_state_var(&state, original_image_index);
+	if (status != EFI_SUCCESS) {
+		log_err("Set FmpState variable failed\n");
+		return EFI_EXIT(status);
+	}
 
 	return EFI_EXIT(EFI_SUCCESS);
 }
diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
index d35247d0e5..eb42f25fc0 100644
--- a/lib/fwu_updates/Kconfig
+++ b/lib/fwu_updates/Kconfig
@@ -14,6 +14,7 @@ if FWU_MULTI_BANK_UPDATE
 
 config FWU_NUM_BANKS
 	int "Number of Banks defined by the platform"
+	range 1 255
 	help
 	  Define the number of banks of firmware images on a platform
 
-- 
2.34.1

