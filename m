Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F48C10F13
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 04:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7706870F4;
	Mon,  4 Dec 2023 05:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gzAw/kA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 284FB870F8; Mon,  4 Dec 2023 05:31:57 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A862D870D2
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 05:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ce3df4c282so466816b3a.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 20:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701664310; x=1702269110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hCZUSWlHJqay1vqfYCyBN6dB4NgBgYymYb0/yPG4b4Y=;
 b=gzAw/kA3tOcX6FngV/iM5rrPSIPEad6KWBd4yNjBB54bJ5jkVAg70iOSC4+BErw8+B
 8vfH9VMsLxMfsTIJxadSPpW/mqwVsdLDyTQ58qhV+MFOxt0lGK0oLkMMKCSUEssTP/lX
 eptyiXiJvNoPGaiiPAm+sG/8CkBlUQLgFGy25fEedC/OTrFkKJ+mLDtdP3EDN3qb9OnI
 TWTFS7t31wcIin/397zB8RyldFPetln2xdUugPZ4og1KprGXy9v5L5ITaITQkbBirl5g
 fIjrVHDAmZIGnRfZ8W1cRnzk90uu/2EuiYy4L0L1jhSKfJyglhPKmZ+7a0VoKUAVLzGi
 HhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701664310; x=1702269110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCZUSWlHJqay1vqfYCyBN6dB4NgBgYymYb0/yPG4b4Y=;
 b=EJODwV/wJ7G3Jar2YUJ0hhoi3QIAiObE3bHkZ8EjDUPdFSDA1U+PyU1obCwbNWk8Kk
 qpByFNxsSMge0+iaWZcbknHY2Gdq7CA+mPAPAv4qFFfFx5EdomZtgBP6T6cIRcquqGZd
 P7Dot9fAtQqVBpwaK6D7GCcAlvYSkb6xi7SOIJwbS9Mq7DyfCdqQqSHHZ8YXnFuYO2wG
 86F6q2JsPNERmzDZMEcYwrxt3cVC0FfM4H12LC2udFw+SPx05NRm76XQwNy7A+/i3tAF
 zj/87L082JFghywYlbdEioTQ22R3uI0CsN599NvCO9Vb7pfy5whJKqJPlsEaK5rsQnEq
 WW9g==
X-Gm-Message-State: AOJu0YyPhufNJpIp0dSuRSsm+hhU3vOEPxmCKZmIGEYqJVNGMjEGVwa9
 UfdkvfOSsT4iABCGPgaVcDjZLUViU+qk7JbxRRs=
X-Google-Smtp-Source: AGHT+IGSHl5wj/cf8EkSMRi16xnWKocDqo8lzvpPwhblxu7jx4oiv2NnEHQImnA3AfFU8VfYElHg3A==
X-Received: by 2002:a05:6a00:b53:b0:6ce:2731:5f85 with SMTP id
 p19-20020a056a000b5300b006ce27315f85mr1462424pfo.68.1701664310281; 
 Sun, 03 Dec 2023 20:31:50 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 b24-20020aa78718000000b006cb60b188basm6585890pfo.206.2023.12.03.20.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 20:31:49 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH] efi_loader: use event callback for initrd deregistration
Date: Mon,  4 Dec 2023 13:30:14 +0900
Message-Id: <20231204043014.122793-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Currently efi_initrd_deregister() is called in bootefi.c
when the image started from bootefi command returns.
Since efi_guid_event_group_return_to_efibootmgr event is
implemented, so let's use this event for invoking
initrd deregistration.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
Note that this patch can be applied to u-boot/next.
This patch requires the patch e0d1a1ea68("efi_loader: add return to efibootmgr event group")

 cmd/bootefi.c                    |  5 --
 lib/efi_loader/efi_load_initrd.c | 82 +++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 4d74969ad6..e52bd3f743 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -390,11 +390,6 @@ static efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
 out:
 	free(load_options);
 
-	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
-		if (efi_initrd_deregister() != EFI_SUCCESS)
-			log_err("Failed to remove loadfile2 for initrd\n");
-	}
-
 	/* Notify EFI_EVENT_GROUP_RETURN_TO_EFIBOOTMGR event group. */
 	list_for_each_entry(evt, &efi_events, link) {
 		if (evt->group &&
diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_initrd.c
index 193433782c..7ca7785c04 100644
--- a/lib/efi_loader/efi_load_initrd.c
+++ b/lib/efi_loader/efi_load_initrd.c
@@ -184,6 +184,50 @@ out:
 	return ret;
 }
 
+/**
+ * efi_initrd_deregister() - delete the handle for loading initial RAM disk
+ *
+ * This will delete the handle containing the Linux specific vendor device
+ * path and EFI_LOAD_FILE2_PROTOCOL for loading an initrd
+ *
+ * Return:	status code
+ */
+efi_status_t efi_initrd_deregister(void)
+{
+	efi_status_t ret;
+
+	if (!efi_initrd_handle)
+		return EFI_SUCCESS;
+
+	ret = efi_uninstall_multiple_protocol_interfaces(efi_initrd_handle,
+							 /* initramfs */
+							 &efi_guid_device_path,
+							 &dp_lf2_handle,
+							 /* LOAD_FILE2 */
+							 &efi_guid_load_file2_protocol,
+							 &efi_lf2_protocol,
+							 NULL);
+	efi_initrd_handle = NULL;
+
+	return ret;
+}
+
+/**
+ * efi_initrd_return_notify() - return to efibootmgr callback
+ *
+ * @event:	the event for which this notification function is registered
+ * @context:	event context
+ */
+static void EFIAPI efi_initrd_return_notify(struct efi_event *event,
+						  void *context)
+{
+	efi_status_t ret;
+
+	EFI_ENTRY("%p, %p", event, context);
+	ret = efi_initrd_deregister();
+	EFI_EXIT(ret);
+}
+
 /**
  * efi_initrd_register() - create handle for loading initial RAM disk
  *
@@ -197,6 +241,7 @@ out:
 efi_status_t efi_initrd_register(void)
 {
 	efi_status_t ret;
+	struct efi_event *event;
 
 	/*
 	 * Allow the user to continue if Boot#### file path is not set for
@@ -215,34 +260,17 @@ efi_status_t efi_initrd_register(void)
 						       &efi_guid_load_file2_protocol,
 						       &efi_lf2_protocol,
 						       NULL);
+	if (ret != EFI_SUCCESS) {
+		log_err("installing EFI_LOAD_FILE2_PROTOCOL failed\n");
+		return ret;
+	}
 
-	return ret;
-}
-
-/**
- * efi_initrd_deregister() - delete the handle for loading initial RAM disk
- *
- * This will delete the handle containing the Linux specific vendor device
- * path and EFI_LOAD_FILE2_PROTOCOL for loading an initrd
- *
- * Return:	status code
- */
-efi_status_t efi_initrd_deregister(void)
-{
-	efi_status_t ret;
-
-	if (!efi_initrd_handle)
-		return EFI_SUCCESS;
-
-	ret = efi_uninstall_multiple_protocol_interfaces(efi_initrd_handle,
-							 /* initramfs */
-							 &efi_guid_device_path,
-							 &dp_lf2_handle,
-							 /* LOAD_FILE2 */
-							 &efi_guid_load_file2_protocol,
-							 &efi_lf2_protocol,
-							 NULL);
-	efi_initrd_handle = NULL;
+	ret = efi_create_event(EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
+			       efi_initrd_return_notify, NULL,
+			       &efi_guid_event_group_return_to_efibootmgr,
+			       &event);
+	if (ret != EFI_SUCCESS)
+		log_err("Creating event failed\n");
 
 	return ret;
 }

base-commit: 4a363dd516856344558034027e40d903868f67b4
-- 
2.34.1

