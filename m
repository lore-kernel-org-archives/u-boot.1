Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA91CC2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 19:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9265C8853F;
	Thu, 20 Jun 2024 21:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mRK98fbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 308188854A; Thu, 20 Jun 2024 21:16:43 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0547888532
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 21:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57d20d89748so1215373a12.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 12:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718911000; x=1719515800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQL7TTBh5UurQJIRJY0lCqzcPiE8DsAEcM0l5HTs0jc=;
 b=mRK98fbxbTvSjVKkod/MLPw1c3AD/9ecdVKvlU7eoK0rEtsStNm7ExZCq6vV9VP5kk
 86p30gIsJlDQKy4ivUENfisXoxHXWTP9L9+LRBsAW50rrt/Gw773nSO6TGpJMoQgSuw+
 XY85bTxFnlpG2VLW8JH7LD8L0sFOgHLussA9GB9ty4QqHlMPHpOmOC3U62V1wz6Sf+OK
 +T6ha6vQLc8q8p0N5NxkkJ1rgi0SrN3mV+y7J0/IItghiv2SghRlVAmqk9IVd3DjB7nu
 Rj9LJ3rEZizYK2ruIW82EBfNWRHafadiS7DE0Y9yVi9hXhDhYZgkBs6Vh7wPY5TXJ4Nw
 df4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718911000; x=1719515800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQL7TTBh5UurQJIRJY0lCqzcPiE8DsAEcM0l5HTs0jc=;
 b=nxkQM8pbmQUIlA7Br5+dk/PNh4hVtfvik2UkqqrlHWGsk29OPomUAGEP2zQQQqlstu
 +YoiGurG0gLID18hi5r/r2rYRMTwpVsm4Wbg2rOc59m6Wl75A4MinasfSIgdaQVg2drC
 VPjwn7RlnW6zg7YHYty7hK20Op543rnYI8ys5npWNsL2bz2/DBbU8F9CuokwxheNwxGx
 OuEyncJQepjRQexmCDqLwaXpX8tiibvEliKA+boglTnuVmFKh3GOebgV2mZKZu/LiH4Q
 USGd9M6aQA6orS1cE59BQCR0UAngVTMTZNCCIJ6J2Y6UPpEbYHx3wDnvqSzWeo7s4gy4
 C8MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyxUaGCukrJfYzlqyI9qrT+rq7acfzzArEwlneGcxrvc61l2GWqlbstIp2PVMNxQ/x5NjorQoXXD/zxSIY9IU2sPnCqg==
X-Gm-Message-State: AOJu0YwCS6/P6JlTP8Bjasd1EiBAw4wvxbuQlSsbo/KUlo5Oi1mOjIXj
 u+LiCVG7VcAUEwvkpY7vdaARwfrtWg3nAiJA3OdDLHq4jv1THKXs5Mqg7GWWYYw=
X-Google-Smtp-Source: AGHT+IEbiBC1d6xtetNnfNjVGp9Czx0atlDEAXdpuJMRdLozV28rbIqFqvD/BD9N3SReLDVi3g9hDA==
X-Received: by 2002:a50:f681:0:b0:572:1589:eb98 with SMTP id
 4fb4d7f45d1cf-57d07e7ad48mr3506455a12.12.1718910999924; 
 Thu, 20 Jun 2024 12:16:39 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72da790sm10015660a12.35.2024.06.20.12.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 12:16:39 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
Subject: [PATCH 2/2] efi_loader: fix return values on efi_tcg
Date: Thu, 20 Jun 2024 22:16:30 +0300
Message-ID: <20240620191631.28811-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620191631.28811-1-ilias.apalodimas@linaro.org>
References: <20240620191631.28811-1-ilias.apalodimas@linaro.org>
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
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_tcg2.c | 121 ++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 57 deletions(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 51264c1b998c..37783942d716 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -254,8 +254,8 @@ efi_tcg2_get_capability(struct efi_tcg2_protocol *this,
 	capability->protocol_version.major = 1;
 	capability->protocol_version.minor = 1;
 
-	efi_ret = tcg2_platform_get_tpm2(&dev);
-	if (efi_ret != EFI_SUCCESS) {
+	ret = tcg2_platform_get_tpm2(&dev);
+	if (ret) {
 		capability->supported_event_logs = 0;
 		capability->hash_algorithm_bitmap = 0;
 		capability->tpm_present_flag = false;
@@ -350,8 +350,7 @@ efi_tcg2_get_eventlog(struct efi_tcg2_protocol *this,
 		goto out;
 	}
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS) {
+	if (tcg2_platform_get_tpm2(&dev)) {
 		event_log_location = NULL;
 		event_log_last_entry = NULL;
 		*event_log_truncated = false;
@@ -386,7 +385,7 @@ static efi_status_t tcg2_hash_pe_image(void *efi, u64 efi_size,
 	void *new_efi = NULL;
 	u8 hash[TPM2_SHA512_DIGEST_SIZE];
 	struct udevice *dev;
-	efi_status_t ret;
+	efi_status_t ret = EFI_SUCCESS;
 	u32 active;
 	int i;
 
@@ -401,12 +400,13 @@ static efi_status_t tcg2_hash_pe_image(void *efi, u64 efi_size,
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
 
@@ -470,12 +470,12 @@ efi_status_t tcg2_measure_pe_image(void *efi, u64 efi_size,
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
@@ -499,9 +499,9 @@ efi_status_t tcg2_measure_pe_image(void *efi, u64 efi_size,
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
@@ -571,9 +571,10 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_protocol *this, u64 flags,
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
@@ -583,9 +584,10 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_protocol *this, u64 flags,
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
@@ -618,8 +620,10 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_protocol *this, u64 flags,
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
@@ -628,9 +632,11 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_protocol *this, u64 flags,
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
@@ -669,7 +675,7 @@ efi_tcg2_submit_command(struct efi_tcg2_protocol *this,
 			u8 *output_param_block)
 {
 	struct udevice *dev;
-	efi_status_t ret;
+	efi_status_t ret = EFI_SUCCESS;
 	u32 rc;
 	size_t resp_buf_size = output_param_block_size;
 
@@ -681,9 +687,10 @@ efi_tcg2_submit_command(struct efi_tcg2_protocol *this,
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
@@ -711,19 +718,20 @@ efi_tcg2_get_active_pcr_banks(struct efi_tcg2_protocol *this,
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
+	if (tcg2_get_active_pcr_banks(dev, active_pcr_banks))
 		goto out;
 
-	ret = tcg2_get_active_pcr_banks(dev, active_pcr_banks);
+	ret = EFI_SUCCESS;
 
 out:
 	return EFI_EXIT(ret);
@@ -849,14 +857,15 @@ static efi_status_t measure_event(struct udevice *dev, u32 pcr_index,
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
@@ -898,10 +907,10 @@ static efi_status_t efi_init_event_log(void)
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
@@ -930,9 +939,11 @@ static efi_status_t efi_init_event_log(void)
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
 
@@ -1303,8 +1314,7 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb)
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
+	if (tcg2_platform_get_tpm2(&dev))
 		return EFI_SECURITY_VIOLATION;
 
 	rsvmap_size = size_of_rsvmap(dtb);
@@ -1353,8 +1363,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(struct efi_loaded_image_obj *ha
 	if (tcg2_efi_app_invoked)
 		return EFI_SUCCESS;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
+	if (tcg2_platform_get_tpm2(&dev))
 		return EFI_SECURITY_VIOLATION;
 
 	ret = tcg2_measure_boot_variable(dev);
@@ -1403,9 +1412,8 @@ efi_status_t efi_tcg2_measure_efi_app_exit(void)
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
-		return ret;
+	if (tcg2_platform_get_tpm2(&dev))
+		return EFI_SECURITY_VIOLATION;
 
 	ret = measure_event(dev, 4, EV_EFI_ACTION,
 			    strlen(EFI_RETURNING_FROM_EFI_APPLICATION),
@@ -1434,9 +1442,10 @@ efi_tcg2_notify_exit_boot_services(struct efi_event *event, void *context)
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
@@ -1466,9 +1475,8 @@ efi_status_t efi_tcg2_notify_exit_boot_services_failed(void)
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
-		goto out;
+	if (tcg2_platform_get_tpm2(&dev))
+		return EFI_SECURITY_VIOLATION;
 
 	ret = measure_event(dev, 5, EV_EFI_ACTION,
 			    strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
@@ -1548,8 +1556,7 @@ efi_status_t efi_tcg2_do_initial_measurement(void)
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS)
+	if (tcg2_platform_get_tpm2(&dev))
 		return EFI_SECURITY_VIOLATION;
 
 	ret = tcg2_measure_secure_boot_variable(dev);
@@ -1574,8 +1581,7 @@ efi_status_t efi_tcg2_register(void)
 	struct efi_event *event;
 	u32 err;
 
-	ret = tcg2_platform_get_tpm2(&dev);
-	if (ret != EFI_SUCCESS) {
+	if (tcg2_platform_get_tpm2(&dev)) {
 		log_warning("Missing TPMv2 device for EFI_TCG_PROTOCOL\n");
 		return EFI_SUCCESS;
 	}
@@ -1583,6 +1589,7 @@ efi_status_t efi_tcg2_register(void)
 	/* initialize the TPM as early as possible. */
 	err = tpm_auto_start(dev);
 	if (err) {
+		ret = EFI_DEVICE_ERROR;
 		log_err("TPM startup failed\n");
 		goto fail;
 	}
-- 
2.45.2

