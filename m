Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C52C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 05:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0674187AAB;
	Thu, 11 Jan 2024 06:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WCbU9ER2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05CE887A88; Thu, 11 Jan 2024 06:37:55 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB5587823
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 06:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d4ab4e65aeso38499165ad.0
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 21:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704951470; x=1705556270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oiu3XdFGrY9VUxnGd/RC4lYGuf7y4wN/HseMcD3PiKg=;
 b=WCbU9ER2wvtT6afh0myuF7rTHZl6bxfDIEfhGpasktam1zCs62grWs80/YKG2i4Y0G
 0pEkQ+69epWUuirZwytkfPcxl5NpCesnSz25r6shLhALXxQschRkjpONaBm+JRAK+KKT
 ptfOD9ZVM3eaYeDCH71XKzr+jBFh7Xhqrfh+O/3OeJbIALtFJWXKBPCVOUwtEdOq3Xjb
 Bj1U8xw2jgK3pdJJAiCp7u6foT+zcP28L6GBKcHcRGw8/k2K7Owk1+nGxRcquh6UMhaq
 A5vLtjQ2cF3oi6X48376XxxWVCf2Ow8uvAF6v0g8DHZrR9tQJKGrNhRFD6i4DHzAdkCy
 8Vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704951470; x=1705556270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oiu3XdFGrY9VUxnGd/RC4lYGuf7y4wN/HseMcD3PiKg=;
 b=OquzWzRE/TBtMEi72K5+/1mArkpko9h0wdaCAQ0CfVUtWMlnaF/9gi7qJkOKxi9k7X
 9JBf0bhCKmTmAv/S5+0P13Fz0l3MFCzAbq4gZgtBHg/iamwclEgYMj3taJsEIcr+ibHP
 WoCMvDDRtDJQDpbVoL0fI8f9MdDgxX3EQKeZDlhVmJ/vzt8qZbLoHhAYMPV7oEe6h89q
 gyKKpPGzS2fgNeTI7Igr8yO0uMJdzxuhkdj1rvnLjq8tL/wkYozzBjLqOOQndFhmfNPD
 cQ1E+xmzqN1hf8YI0L5sAPyP+Uc7/YH+6l4WVMNKZCPrB8snORLXSbDS2pc7KP9Ain3V
 nUtw==
X-Gm-Message-State: AOJu0Yz9wTFFJb+PrPd++8oVmQawgYL6Z4ELb8JIpBow+58trqiCVtoU
 +sH6JTPa1OlT+zpbTvmtqURukOBDjhuPyNWBKI/+2mj4wmg=
X-Google-Smtp-Source: AGHT+IHtEyJO8ZdSktkrMYb66wS8VHa0B+NJQs8KRhWYvSvVIweLrHfnqPV+JShqpQt+Z93hEnHKKw==
X-Received: by 2002:a17:902:ee51:b0:1d4:381c:a3e5 with SMTP id
 17-20020a170902ee5100b001d4381ca3e5mr301246plo.66.1704951470298; 
 Wed, 10 Jan 2024 21:37:50 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 r19-20020a170902c61300b001d3e9937d92sm273645plr.51.2024.01.10.21.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 21:37:49 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 2/2] efi_loader: support fmp versioning for multi bank
 update
Date: Thu, 11 Jan 2024 14:35:40 +0900
Message-Id: <20240111053540.899997-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111053540.899997-1-masahisa.kojima@linaro.org>
References: <20240111053540.899997-1-masahisa.kojima@linaro.org>
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

This commit stores the firmware version into the array
of fmp_state structure to support the fmp versioning
for multi bank update. The index of the array is identified
by the bank index.

This modification keeps the backward compatibility with
the existing versioning feature.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_firmware.c | 75 ++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 15 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index e558336bc1..9fd13297a6 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -206,18 +206,10 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
 {
 	u16 varname[13]; /* u"FmpStateXXXX" */
 	efi_status_t ret;
-	efi_uintn_t size;
-	struct fmp_state var_state = { 0 };
-
-	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
-				fw_array->image_index);
-	size = sizeof(var_state);
-	ret = efi_get_variable_int(varname, &fw_array->image_type_id,
-				   NULL, &size, &var_state, NULL);
-	if (ret == EFI_SUCCESS)
-		image_info->version = var_state.fw_version;
-	else
-		image_info->version = 0;
+	efi_uintn_t size, expected_size;
+	uint num_banks = 1;
+	uint active_index = 0;
+	struct fmp_state *var_state;
 
 	efi_firmware_get_lsv_from_dtb(fw_array->image_index,
 				      &fw_array->image_type_id,
@@ -226,6 +218,31 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
 	image_info->version_name = NULL; /* not supported */
 	image_info->last_attempt_version = 0;
 	image_info->last_attempt_status = LAST_ATTEMPT_STATUS_SUCCESS;
+	image_info->version = 0;
+
+	/* get the fw_version */
+	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
+				fw_array->image_index);
+	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+		ret = fwu_get_active_index(&active_index);
+		if (ret)
+			return;
+
+		num_banks = CONFIG_FWU_NUM_BANKS;
+	}
+
+	size = num_banks * sizeof(*var_state);
+	expected_size = size;
+	var_state = calloc(1, size);
+	if (!var_state)
+		return;
+
+	ret = efi_get_variable_int(varname, &fw_array->image_type_id,
+				   NULL, &size, var_state, NULL);
+	if (ret == EFI_SUCCESS && expected_size == size)
+		image_info->version = var_state[active_index].fw_version;
+
+	free(var_state);
 }
 
 /**
@@ -361,8 +378,11 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
 {
 	u16 varname[13]; /* u"FmpStateXXXX" */
 	efi_status_t ret;
+	uint num_banks = 1;
+	uint update_bank = 0;
+	efi_uintn_t size;
 	efi_guid_t *image_type_id;
-	struct fmp_state var_state = { 0 };
+	struct fmp_state *var_state;
 
 	image_type_id = efi_firmware_get_image_type_id(image_index);
 	if (!image_type_id)
@@ -371,19 +391,44 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
 	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
 				image_index);
 
+	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+		ret = fwu_plat_get_update_index(&update_bank);
+		if (ret)
+			return EFI_INVALID_PARAMETER;
+
+		num_banks = CONFIG_FWU_NUM_BANKS;
+	}
+
+	size = num_banks * sizeof(*var_state);
+	var_state = calloc(1, size);
+	if (!var_state)
+		return EFI_OUT_OF_RESOURCES;
+
+	/*
+	 * GetVariable may fail, EFI_NOT_FOUND is returned if FmpState
+	 * variable has not been set yet.
+	 * Ignore the error here since the correct FmpState variable
+	 * is set later.
+	 */
+	efi_get_variable_int(varname, image_type_id, NULL, &size, var_state,
+			     NULL);
+
 	/*
 	 * Only the fw_version is set here.
 	 * lowest_supported_version in FmpState variable is ignored since
 	 * it can be tampered if the file based EFI variable storage is used.
 	 */
-	var_state.fw_version = state->fw_version;
+	var_state[update_bank].fw_version = state->fw_version;
 
+	size = num_banks * sizeof(*var_state);
 	ret = efi_set_variable_int(varname, image_type_id,
 				   EFI_VARIABLE_READ_ONLY |
 				   EFI_VARIABLE_NON_VOLATILE |
 				   EFI_VARIABLE_BOOTSERVICE_ACCESS |
 				   EFI_VARIABLE_RUNTIME_ACCESS,
-				   sizeof(var_state), &var_state, false);
+				   size, var_state, false);
+
+	free(var_state);
 
 	return ret;
 }
-- 
2.34.1

