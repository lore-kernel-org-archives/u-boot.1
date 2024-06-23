Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFDCC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 11:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9431A882D6;
	Sun, 23 Jun 2024 13:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X7seJFOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED734882E6; Sun, 23 Jun 2024 13:48:54 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4FFA883B1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ec50a5e230so19857931fa.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 04:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719143332; x=1719748132; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mVDZVCRMXug7xO/RF4D6eWCB8fZxupakOcO7ByODqk=;
 b=X7seJFOL1+1LAlzIEXMHm/husRY8dshDuHSqJUgWgNMHoK45PdAWDyXI6nQUBkK9Xe
 rmbgejQbzsFPF1r5jsmUV+FZQnUjCoEbiiOtZjpgHrLv4KWkA+9hN7gcgmjo7EGQfuRP
 X4Qc6/B8udKhsaPD+tUC9MDEi2/IBcOnXtuq61UoXKUVgew2hpKQdz0UfS0xuPKoHJ6U
 UO8fnR1nnGscBZ4bPsV2axf/dqJkZpKPVUmghIyTkWLVDOSURjgh8UQwgKWeWDsAwInH
 uJYDmkb5UsX+gPThY7VAxy3J0fvGp0ko4O6tjRZhzpFnt9s17AeovBTSrKjv45VZrWMm
 NwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719143332; x=1719748132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mVDZVCRMXug7xO/RF4D6eWCB8fZxupakOcO7ByODqk=;
 b=itYBCBM5W7xg5mUJytHH/GGlFmobfTJvoyWCBs9TGlwiEHGNmCL7sOJ8mcZJ99p9Mc
 x7k7OWsTMUsIcY4RTYx0YkgV9SLvjD3xAX09AuPe6QFu8k+TDtgpFxjFJ/OOq6ar2HCK
 G5akjsVN/eQWbgKholFcpynDEpPQJl/jRepd+DWfAHb4hPmeYs6bgLvQ26sjes6bqRao
 Oa4sPUmIzVCA3ZWLJNFAd4BfZkdIJsgS6rQGKUEeKa18n6O3ulIggZUNDuNVqySB2n34
 raiK4Po4ztiOb6MuZYeH0NwkjnifZ6YSBwQ7bA0nGGyeCraVEvd6X3X50bFmiLe99kzT
 Iwpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXboaTLrySsP2L+F1uTQPsH8W0SC2EgfWlzR6dIW3IwDEpqftk5o4Gm9N9WoWgq4dFndsGcGhI7y+9pmoBFrd71WHC4g==
X-Gm-Message-State: AOJu0Yx9PlmgRHtby/fIAw2mIzpLp93ih2uiuhIyhYBqNlylILGWO9Xe
 LkN7Lo+zlTCZE9fpIYVW/Ekimoo0GyY139iVI3cGxT50D8Eqez7obHJmlXQTNNs=
X-Google-Smtp-Source: AGHT+IH2OvcaiwoupxQfYrqwag/iYOavjiHsrdaymLmq8Z5ePOEezSTaw4q7kvBb3jM0iXQm/knvXw==
X-Received: by 2002:a2e:8607:0:b0:2eb:f31e:9e7b with SMTP id
 38308e7fff4ca-2ec5b27d17emr10482741fa.14.1719143331690; 
 Sun, 23 Jun 2024 04:48:51 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d30534ffasm3402053a12.60.2024.06.23.04.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 04:48:50 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/8] efi_loader: fix the return values on efi_tcg
Date: Sun, 23 Jun 2024 14:48:12 +0300
Message-ID: <20240623114838.14639-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
References: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
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

A while back we moved the core functions of the EFI TCG protocol to the
TPM APIs in order for them to be used with bootm, booti etc.
Some prototypes changed from returning efi_status_t to int, which is more
appropriate for the non-EFI APIs. However, some of the EFI callsites never
changed and we ended up assigning the int value to efi_status_t.

This is unlikely to cause any problems, apart from returning invalid
values on failures and violating the EFI spec. Let's fix them
by looking at the new return code and map it to the proper EFI return
code on failures.

Fixes: commit 97707f12fdab ("tpm: Support boot measurements")
Fixes: commit d6b55a420cfc ("efi_loader: startup the tpm device when installing the protocol")
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_tcg2.c | 126 +++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 57 deletions(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index d56bd5657c8a..b4915cab6be7 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -257,8 +257,8 @@ efi_tcg2_get_capability(struct efi_tcg2_protocol *this,
 	capability->protocol_version.major = 1;
 	capability->protocol_version.minor = 1;
 
-	efi_ret = tcg2_platform_get_tpm2(&dev);
-	if (efi_ret != EFI_SUCCESS) {
+	ret = tcg2_platform_get_tpm2(&dev);
+	if (ret) {
 		capability->supported_event_logs = 0;
 		capability->hash_algorithm_bitmap = 0;
 		capability->tpm_present_flag = false;
@@ -353,8 +353,7 @@ efi_tcg2_get_eventlog(struct efi_tcg2_protocol *this,
 		goto out;
 	}
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS) {
+	if (tcg2_platform_get_tpm2(&dev)) {
 		event_log_location = NULL;
 		event_log_last_entry = NULL;
 		*event_log_truncated = false;
@@ -389,7 +388,7 @@ static efi_status_t tcg2_hash_pe_image(void *efi, u64 efi_size,
 	void *new_efi = NULL;
 	u8 hash[TPM2_SHA512_DIGEST_SIZE];
 	struct udevice *dev;
-	efi_status_t ret;
+	efi_status_t ret = EFI_SUCCESS;
 	u32 active;
 	int i;
 
@@ -404,12 +403,13 @@ static efi_status_t tcg2_hash_pe_image(void *efi, u64 efi_size,
 		goto out;
 	}
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
+	if (tcg2_platform_get_tpm2(&dev)) {
+		ret = EFI_DEVICE_ERROR;
 		goto out;
+	}
 
-	ret = tcg2_get_active_pcr_banks(dev, &active);
-	if (ret != EFI_SUCCESS) {
+	if (tcg2_get_active_pcr_banks(dev, &active)) {
+		ret = EFI_DEVICE_ERROR;
 		goto out;
 	}
 
@@ -473,12 +473,12 @@ efi_status_t tcg2_measure_pe_image(void *efi, u64 efi_size,
 	IMAGE_DOS_HEADER *dos;
 	IMAGE_NT_HEADERS32 *nt;
 	struct efi_handler *handler;
+	int rc;
 
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
+	if (tcg2_platform_get_tpm2(&dev))
 		return EFI_SECURITY_VIOLATION;
 
 	switch (handle->image_type) {
@@ -502,9 +502,9 @@ efi_status_t tcg2_measure_pe_image(void *efi, u64 efi_size,
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	ret = tcg2_pcr_extend(dev, pcr_index, &digest_list);
-	if (ret != EFI_SUCCESS)
-		return ret;
+	rc = tcg2_pcr_extend(dev, pcr_index, &digest_list);
+	if (rc)
+		return EFI_DEVICE_ERROR;
 
 	ret = efi_search_protocol(&handle->header,
 				  &efi_guid_loaded_image_device_path, &handler);
@@ -574,9 +574,10 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_protocol *this, u64 flags,
 			       struct efi_tcg2_event *efi_tcg_event)
 {
 	struct udevice *dev;
-	efi_status_t ret;
+	efi_status_t ret = EFI_SUCCESS;
 	u32 event_type, pcr_index, event_size;
 	struct tpml_digest_values digest_list;
+	int rc = 0;
 
 	EFI_ENTRY("%p, %llu, %llu, %llu, %p", this, flags, data_to_hash,
 		  data_to_hash_len, efi_tcg_event);
@@ -586,9 +587,10 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_protocol *this, u64 flags,
 		goto out;
 	}
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
+	if (tcg2_platform_get_tpm2(&dev)) {
+		ret = EFI_DEVICE_ERROR;
 		goto out;
+	}
 
 	if (efi_tcg_event->size < efi_tcg_event->header.header_size +
 	    sizeof(u32)) {
@@ -621,8 +623,10 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_protocol *this, u64 flags,
 		ret = tcg2_hash_pe_image((void *)(uintptr_t)data_to_hash,
 					 data_to_hash_len, &digest_list);
 	} else {
-		ret = tcg2_create_digest(dev, (u8 *)(uintptr_t)data_to_hash,
-					 data_to_hash_len, &digest_list);
+		rc = tcg2_create_digest(dev, (u8 *)(uintptr_t)data_to_hash,
+					data_to_hash_len, &digest_list);
+		if (rc)
+			ret = EFI_DEVICE_ERROR;
 	}
 
 	if (ret != EFI_SUCCESS)
@@ -631,9 +635,11 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_protocol *this, u64 flags,
 	pcr_index = efi_tcg_event->header.pcr_index;
 	event_type = efi_tcg_event->header.event_type;
 
-	ret = tcg2_pcr_extend(dev, pcr_index, &digest_list);
-	if (ret != EFI_SUCCESS)
+	rc = tcg2_pcr_extend(dev, pcr_index, &digest_list);
+	if (rc) {
+		ret = EFI_DEVICE_ERROR;
 		goto out;
+	}
 
 	if (flags & EFI_TCG2_EXTEND_ONLY) {
 		if (event_log.truncated)
@@ -672,7 +678,7 @@ efi_tcg2_submit_command(struct efi_tcg2_protocol *this,
 			u8 *output_param_block)
 {
 	struct udevice *dev;
-	efi_status_t ret;
+	efi_status_t ret = EFI_SUCCESS;
 	u32 rc;
 	size_t resp_buf_size = output_param_block_size;
 
@@ -684,9 +690,10 @@ efi_tcg2_submit_command(struct efi_tcg2_protocol *this,
 		goto out;
 	}
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
+	if (tcg2_platform_get_tpm2(&dev)) {
+		ret = EFI_DEVICE_ERROR;
 		goto out;
+	}
 
 	rc = tpm2_submit_command(dev, input_param_block,
 				 output_param_block, &resp_buf_size);
@@ -714,19 +721,25 @@ efi_tcg2_get_active_pcr_banks(struct efi_tcg2_protocol *this,
 			      u32 *active_pcr_banks)
 {
 	struct udevice *dev;
-	efi_status_t ret;
+	efi_status_t ret = EFI_INVALID_PARAMETER;
 
 	EFI_ENTRY("%p, %p", this, active_pcr_banks);
 
-	if (!this || !active_pcr_banks) {
-		ret = EFI_INVALID_PARAMETER;
+	if (!this || !active_pcr_banks)
 		goto out;
-	}
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
+
+	if (tcg2_platform_get_tpm2(&dev))
+		goto out;
+
+	/*
+	 * EFI_INVALID_PARAMETER does not convey the problem type.
+	 * but that's what currently the spec specifies.
+	 * EFI_DEVICE_ERROR would be better
+	 */
+	if (tcg2_get_active_pcr_banks(dev, active_pcr_banks))
 		goto out;
 
-	ret = tcg2_get_active_pcr_banks(dev, active_pcr_banks);
+	ret = EFI_SUCCESS;
 
 out:
 	return EFI_EXIT(ret);
@@ -852,14 +865,15 @@ static efi_status_t measure_event(struct udevice *dev, u32 pcr_index,
 				  u32 event_type, u32 size, u8 event[])
 {
 	struct tpml_digest_values digest_list;
-	efi_status_t ret;
+	efi_status_t ret = EFI_DEVICE_ERROR;
+	int rc;
 
-	ret = tcg2_create_digest(dev, event, size, &digest_list);
-	if (ret != EFI_SUCCESS)
+	rc = tcg2_create_digest(dev, event, size, &digest_list);
+	if (rc)
 		goto out;
 
-	ret = tcg2_pcr_extend(dev, pcr_index, &digest_list);
-	if (ret != EFI_SUCCESS)
+	rc = tcg2_pcr_extend(dev, pcr_index, &digest_list);
+	if (rc)
 		goto out;
 
 	ret = tcg2_agile_log_append(pcr_index, event_type, &digest_list,
@@ -901,10 +915,10 @@ static efi_status_t efi_init_event_log(void)
 	struct tcg2_event_log elog;
 	struct udevice *dev;
 	efi_status_t ret;
+	int rc;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
-		return ret;
+	if (tcg2_platform_get_tpm2(&dev))
+		return EFI_DEVICE_ERROR;
 
 	ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, TPM2_EVENT_LOG_SIZE,
 				(void **)&event_log.buffer);
@@ -933,9 +947,11 @@ static efi_status_t efi_init_event_log(void)
 	 */
 	elog.log = event_log.buffer;
 	elog.log_size = TPM2_EVENT_LOG_SIZE;
-	ret = tcg2_log_prepare_buffer(dev, &elog, false);
-	if (ret != EFI_SUCCESS)
+	rc = tcg2_log_prepare_buffer(dev, &elog, false);
+	if (rc) {
+		ret = (rc == -ENOBUFS) ? EFI_BUFFER_TOO_SMALL : EFI_DEVICE_ERROR;
 		goto free_pool;
+	}
 
 	event_log.pos = elog.log_position;
 
@@ -1306,8 +1322,7 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb)
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
+	if (tcg2_platform_get_tpm2(&dev))
 		return EFI_SECURITY_VIOLATION;
 
 	rsvmap_size = size_of_rsvmap(dtb);
@@ -1356,8 +1371,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(struct efi_loaded_image_obj *ha
 	if (tcg2_efi_app_invoked)
 		return EFI_SUCCESS;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
+	if (tcg2_platform_get_tpm2(&dev))
 		return EFI_SECURITY_VIOLATION;
 
 	ret = tcg2_measure_boot_variable(dev);
@@ -1406,9 +1420,8 @@ efi_status_t efi_tcg2_measure_efi_app_exit(void)
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
-		return ret;
+	if (tcg2_platform_get_tpm2(&dev))
+		return EFI_SECURITY_VIOLATION;
 
 	ret = measure_event(dev, 4, EV_EFI_ACTION,
 			    strlen(EFI_RETURNING_FROM_EFI_APPLICATION),
@@ -1437,9 +1450,10 @@ efi_tcg2_notify_exit_boot_services(struct efi_event *event, void *context)
 		goto out;
 	}
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
+	if (tcg2_platform_get_tpm2(&dev)) {
+		ret = EFI_SECURITY_VIOLATION;
 		goto out;
+	}
 
 	ret = measure_event(dev, 5, EV_EFI_ACTION,
 			    strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
@@ -1469,9 +1483,8 @@ efi_status_t efi_tcg2_notify_exit_boot_services_failed(void)
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
-		goto out;
+	if (tcg2_platform_get_tpm2(&dev))
+		return EFI_SECURITY_VIOLATION;
 
 	ret = measure_event(dev, 5, EV_EFI_ACTION,
 			    strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
@@ -1551,8 +1564,7 @@ efi_status_t efi_tcg2_do_initial_measurement(void)
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
+	if (tcg2_platform_get_tpm2(&dev))
 		return EFI_SECURITY_VIOLATION;
 
 	ret = tcg2_measure_secure_boot_variable(dev);
@@ -1577,8 +1589,7 @@ efi_status_t efi_tcg2_register(void)
 	struct efi_event *event;
 	u32 err;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS) {
+	if (tcg2_platform_get_tpm2(&dev)) {
 		log_warning("Missing TPMv2 device for EFI_TCG_PROTOCOL\n");
 		return EFI_SUCCESS;
 	}
@@ -1586,6 +1597,7 @@ efi_status_t efi_tcg2_register(void)
 	/* initialize the TPM as early as possible. */
 	err = tpm_auto_start(dev);
 	if (err) {
+		ret = EFI_DEVICE_ERROR;
 		log_err("TPM startup failed\n");
 		goto fail;
 	}
-- 
2.45.2

