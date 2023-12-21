Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0B1C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 09:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D87D8785A;
	Thu, 21 Dec 2023 10:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ykYFhmN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B3E4877A1; Thu, 21 Dec 2023 10:55:00 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB2A8785C
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 10:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cdc159034eso275571a12.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703152495; x=1703757295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xv+fGi7LNcnsBebszm2kBJ6oJjfbgAATJGkrRuVzCvk=;
 b=ykYFhmN31vLmzpnDGGVmtZVkGUZvmCDpjuWVx7G2kFQ3c0QtLA4B3IjwrcUB69Hw0g
 nhPZWBdF5xAZUHn2EbbeLjQO9xuU4gubOBg470xh8TBFT2zubtnSGGHaK23od0Na6yV3
 cR0373U6zr+677AmfNM+VwJWqHo0tcOSdbBAH/OUU2P7BotO9r33ZrDw/mcIo3P+2P4z
 epa5TYMQBfWy0nYHupcy8Ou1stjDzL/siVEq6phjlWzZ0EqyhrwyaqoweMcZUYxo+xZD
 MBcGH95rbCini2i8gbQiy5eNi5DNtXSDh/dYyihy9/9eytf86vumuSjDc6b0QhrWddQF
 9i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703152495; x=1703757295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xv+fGi7LNcnsBebszm2kBJ6oJjfbgAATJGkrRuVzCvk=;
 b=RlISXh+ltl13MS6RezcZM3LK5f0nqBtY4LRQaUcSpCSzPibrgHlxP9qEhMUCWOOuvX
 rA7+XmBtnLaw5S1AgkNlsT3yEkd9Hp31Uo2+kDMg3ysgfYqe4MbtqLj7V68YgHnHag35
 SSOgDLUsI0nTTMaZEEvJ3cRqE4r2Uj/GzKKfJpRx8Oh7b4tqUUn/AhZxM/FnG6XO85hI
 spd0BJ8RQmg+sAzue3T9+L3BvCh2P24JfsM3tPYGqUSYSjxJW4zNdC7OrGfktpDPzc6Z
 qiyNyrV+cyFposEdFVcUwglDL26yr4YoO7OczgThEvbqwm9Pd5bbpPaiFrYqLRUW9ADf
 aZfA==
X-Gm-Message-State: AOJu0Ywa69VjpHR/MjIwgzxQrhcJPuH3/kZ4jgI+3tczFocmMt5Xe+h+
 z0rYQYO/TsjJh5IOLk4Xwc7GQJefJ6JD3BAJrCc=
X-Google-Smtp-Source: AGHT+IG7iQv8E0YePwtD1L53jkPk4/Qqx2TsK/Coq3m8saAV/D40gFfQWpsI+ybKcFFWF++TdhmnFw==
X-Received: by 2002:a05:6a20:7f97:b0:18f:20bf:d855 with SMTP id
 d23-20020a056a207f9700b0018f20bfd855mr796949pzj.1.1703152495358; 
 Thu, 21 Dec 2023 01:54:55 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 jx20-20020a17090b46d400b0028b66796002sm1369417pjb.6.2023.12.21.01.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 01:54:54 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 2/2] efi_loader: support fmp versioning for multi bank
 update
Date: Thu, 21 Dec 2023 18:52:58 +0900
Message-Id: <20231221095258.592275-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221095258.592275-1-masahisa.kojima@linaro.org>
References: <20231221095258.592275-1-masahisa.kojima@linaro.org>
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
 lib/efi_loader/efi_firmware.c | 69 +++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 9b8630625f..5459f3d38d 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -207,18 +207,10 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
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
@@ -227,6 +219,31 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
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
@@ -362,8 +379,11 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
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
@@ -372,19 +392,38 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
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
+	ret = efi_get_variable_int(varname, image_type_id, NULL, &size,
+				   var_state, NULL);
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

