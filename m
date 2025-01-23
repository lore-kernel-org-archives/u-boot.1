Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1C4C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A924980815;
	Thu, 23 Jan 2025 23:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gGXDzEix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6932D806DC; Thu, 23 Jan 2025 23:07:43 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A820807CD
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5f2ed0b70d6so697674eaf.3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 14:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737670059; x=1738274859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aM/9vkVPA9P5IWBjw9qg6Kd13MGbm0KTGn/Wp1YspLA=;
 b=gGXDzEix18UhM1QEzu+TqJbrkVmnxzvHRsS7YVCj2cioTKHekr9ApAJ/wX3axWRoah
 lII6SeqAaApHJwQEuAHqeVte0uTTA1RYRVoea1QjlgvHL6lXJYh+5WM/czAx5bWoB9nw
 rGuib9FLtpLQ2qNR8EWc4XstTEAsbxPWR8E1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737670059; x=1738274859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aM/9vkVPA9P5IWBjw9qg6Kd13MGbm0KTGn/Wp1YspLA=;
 b=u743i3a9xq1c1cvnd6EoVWBEdowtwgRFhu+bIhm42WBa62oyXlQ3ThsBw6DQX2EsK7
 uOSXVDqb+FtfknVI21rQsz7NzE5FAyFXK7kKOmS0Fw3P6iuhBvTtbzCrel65k5boxgcD
 ++yeZ5/hSHpjxScw6pAdUVj24OXyZurt5/kbxdthKx9G+BLr1tTBWSOWC+pqQg5wtSw/
 FDdfY+7n3r3RE3wrnfI3znf6Ocdig87WWkayMA1dJEWc/btJPcJooUeNipUEwUKedYyu
 5yDYlmfd0KBb51EtqU8+gsJLx2KLb/gF++wUh8NAT2eBSmGKMRldyN37HWA3iLaOb2R+
 G8ig==
X-Gm-Message-State: AOJu0YzS+qJFRl8DdwZgmP4qrhHQpeyj6w/dxmln/hvzyMG9KQMdqgyZ
 dkj3/IJA55h7m0Z0kseYKPOIHrhPzpScvTJcqe4iPNr+lOQu6e2wOLMoqUqANqcUbM/fzXhFFEY
 =
X-Gm-Gg: ASbGncuJGdOcE+K06PTMfRCY1kMZwPZpLBUqiCDhi3ledlcvaDXOEb7dhl4WsR/ALEZ
 uwIPLhv3ZNKDsjrMlVIybN0q71CGeh20V/vpeitqpb0JVio7nRWrR9H5YP3WUXFH8QHi4mgRvAD
 aap6W1DryzXNQ1OhvoeUQPcmdpKj7LTQo6NzZ1XtQdHt6pM9FsywiSzP+aC+BuP0lg0tHTo+FMM
 +Ll9UIRx19gsni4dccjU4XisVTt1Of1/GUOuQFjQqgKxs8T/+2RscbT6qui1+6UwnS3kw3YCX2x
 Ulu1+vMPGSUnTnhdkfMBBz6B2KvRi5WuZa3guZZG7w==
X-Google-Smtp-Source: AGHT+IFENY5lk6Ew/DD3PtEoUwQkTf1IZyYmGw5pP1IdRMfC4jeyFs48Y7Jo/cHyzmGTEsxwlNWb/w==
X-Received: by 2002:a05:6871:8005:b0:29e:1325:760a with SMTP id
 586e51a60fabf-2b1c099e39cmr15377279fac.8.1737670059352; 
 Thu, 23 Jan 2025 14:07:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-724ecda47bbsm143136a34.2.2025.01.23.14.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 14:07:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Moritz Fischer <moritzf@google.com>
Subject: [PATCH v5 3/5] efi_loader: Move the fallback code from efi_run_image()
Date: Thu, 23 Jan 2025 15:07:22 -0700
Message-ID: <20250123220726.412396-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123220726.412396-1-sjg@chromium.org>
References: <20250123220726.412396-1-sjg@chromium.org>
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

This code is only needed if an invalid image/device path is passed in.
Move the code out to a caller where this can be dealt with. The normal
flow will provide these parameters.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Rebase on earlier changes

 lib/efi_loader/efi_bootbin.c | 90 +++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 789da8bcda0..fdb4c6e4b51 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -165,37 +165,13 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
 				  struct efi_device_path *dp_dev,
 				  struct efi_device_path *dp_img)
 {
-	efi_handle_t mem_handle = NULL, handle;
-	struct efi_device_path *file_path = NULL;
-	struct efi_device_path *msg_path;
+	efi_handle_t handle;
+	struct efi_device_path *msg_path, *file_path;
 	efi_status_t ret;
 	u16 *load_options;
 
-	if (!dp_img || !dp_img) {
-		log_debug("Not loaded from disk\n");
-		/*
-		 * Special case for efi payload not loaded from disk,
-		 * such as 'bootefi hello' or for example payload
-		 * loaded directly into memory via JTAG, etc:
-		 */
-		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
-					    (uintptr_t)source_buffer,
-					    source_size);
-		/*
-		 * Make sure that device for device_path exist
-		 * in load_image(). Otherwise, shell and grub will fail.
-		 */
-		ret = efi_install_multiple_protocol_interfaces(&mem_handle,
-							       &efi_guid_device_path,
-							       file_path, NULL);
-		if (ret != EFI_SUCCESS)
-			goto out;
-		msg_path = file_path;
-	} else {
-		file_path = efi_dp_concat(dp_img, dp_img, 0);
-		msg_path = dp_img;
-		log_debug("Loaded from disk\n");
-	}
+	file_path = efi_dp_concat(dp_dev, dp_img, 0);
+	msg_path = dp_img;
 
 	log_info("Booting %pD\n", msg_path);
 
@@ -214,15 +190,6 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
 	ret = do_bootefi_exec(handle, load_options);
 
 out:
-	if (mem_handle) {
-		efi_status_t r;
-
-		r = efi_uninstall_multiple_protocol_interfaces(
-			mem_handle, &efi_guid_device_path, file_path, NULL);
-		if (r != EFI_SUCCESS)
-			log_err("Uninstalling protocol interfaces failed\n");
-	}
-	efi_free_pool(file_path);
 
 	return ret;
 }
@@ -241,9 +208,9 @@ out:
  *
  * Return:	status code
  */
-efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
-			       struct efi_device_path *dp_dev,
-			       struct efi_device_path *dp_img)
+static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
+				      struct efi_device_path *dp_dev,
+				      struct efi_device_path *dp_img)
 {
 	efi_status_t ret;
 
@@ -276,6 +243,45 @@ efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
  */
 efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 {
-	return efi_binary_run_dp(image, size, fdt, bootefi_device_path,
-				 bootefi_image_path);
+	efi_handle_t mem_handle = NULL;
+	struct efi_device_path *file_path = NULL;
+	efi_status_t ret;
+
+	if (!bootefi_device_path || !bootefi_image_path) {
+		log_debug("Not loaded from disk\n");
+		/*
+		 * Special case for efi payload not loaded from disk,
+		 * such as 'bootefi hello' or for example payload
+		 * loaded directly into memory via JTAG, etc:
+		 */
+		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
+					    (uintptr_t)image, size);
+		/*
+		 * Make sure that device for device_path exist
+		 * in load_image(). Otherwise, shell and grub will fail.
+		 */
+		ret = efi_install_multiple_protocol_interfaces(&mem_handle,
+							       &efi_guid_device_path,
+							       file_path, NULL);
+		if (ret != EFI_SUCCESS)
+			goto out;
+	} else {
+		log_debug("Loaded from disk\n");
+	}
+
+	ret = efi_binary_run_dp(image, size, fdt, bootefi_device_path,
+				bootefi_image_path);
+out:
+	if (mem_handle) {
+		efi_status_t r;
+
+		r = efi_uninstall_multiple_protocol_interfaces(mem_handle,
+					&efi_guid_device_path, file_path, NULL);
+		if (r != EFI_SUCCESS)
+			log_err("Uninstalling protocol interfaces failed\n");
+	}
+	efi_free_pool(file_path);
+
+	return ret;
 }
+
-- 
2.43.0

