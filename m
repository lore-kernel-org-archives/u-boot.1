Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010A0C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 11:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1CA7875AE;
	Tue, 21 Nov 2023 12:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DDVHdJxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27EA887498; Tue, 21 Nov 2023 12:36:11 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A35087581
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7ad501cb1f9so215859139f.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700566566; x=1701171366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaT0o1eoeaxqL7gjgw1ca96VQVytqdHjdZx6No35tJM=;
 b=DDVHdJxVITqc+EyZhlh90VMZ4sFI+X6TE3GFA4Q0deYNH5Tah1kw4+GkRyVQ0jPC0d
 BlrzoPj5cMR/K25YvZvu5P0e4vM0Pg6ryowC4rARfXZXBaBPMGQlEDvqtq9SlXwPQHcp
 3w2qZhD7oGNta95JrO3SdmNJDvHChCMESJvkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700566566; x=1701171366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DaT0o1eoeaxqL7gjgw1ca96VQVytqdHjdZx6No35tJM=;
 b=ltyu7XWNURQCb00nCDaL8DnJR+SMz+Sxe+xIDgXkbYNyMuabRhy4zqpt2FLrXx2UpM
 yIMY/ILo0mW9gsKFPaHUgzmtzvsBKE51/xnWaOdB4Cb3i2UVOctkfvTBhJtelczWHpZg
 cuHsHUVTJbt7MZ0tNfr7y9OprZA4hPgmYq0lQwgfQpvcUOaoxjMvyQNs/zo4uRqcC6qD
 6scRSpPbi0SVjKNyTq0gRqmOK4w/WwQs49rEHjKguJ3+UuuZsrtPFM2L4yObhRdLF5xF
 bob1RCqmViLYu6J6YYXItVdcF5E3H+qCJMieBqbDwXwdglnSuIM2WitVT52Pw3Jzhsjs
 6aEQ==
X-Gm-Message-State: AOJu0YyPhSSMmXxmslPf6aHVoGAmA4dZjlbJogJhN8XhsrQSAwAO7z/V
 Uk8u5o7GL9RuySU+vMz4C1DegpC/EYM1N9iaWZi47Q==
X-Google-Smtp-Source: AGHT+IHVJSHYZ0ZFEwfu/F3R5O2MyX6zmwepbaTTVPXMU4euOCtAmU4CwK3bjCdGNwuIU1v/dTkyIw==
X-Received: by 2002:a05:6602:400c:b0:7af:f3d4:f7a0 with SMTP id
 bk12-20020a056602400c00b007aff3d4f7a0mr5799469iob.4.1700566566679; 
 Tue, 21 Nov 2023 03:36:06 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a0566380f8a00b0045bb982a3d2sm2559190jal.60.2023.11.21.03.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 03:36:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/7] WIP: efi: Disable ANSI output
Date: Tue, 21 Nov 2023 04:35:50 -0700
Message-ID: <20231121113557.800353-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121113557.800353-1-sjg@chromium.org>
References: <20231121113557.800353-1-sjg@chromium.org>
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

We don't want ANSI characters written in tests since it is a pain to
check the output.

For now, don't bother checking the console size.

A better solution is need, which allows ANSI output to be controlled
within EFI.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/efi_loader.h         | 14 ++++++++++++--
 lib/efi_loader/efi_console.c | 17 +++++++----------
 lib/efi_loader/efi_setup.c   |  2 +-
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 247be060e1c0..ebe951922791 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -527,8 +527,18 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void);
 efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
 /* search the boot option index in BootOrder */
 bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target, u32 *index);
-/* Set up console modes */
-void efi_setup_console_size(void);
+
+/**
+ * efi_setup_console_size() - update the mode table.
+ *
+ * @allow_ansi: Allow emitting ANSI characters
+ *
+ * By default the only mode available is 80x25. If the console has at least 50
+ * lines, enable mode 80x50. If we can query the console size and it is neither
+ * 80x25 nor 80x50, set it as an additional mode.
+ */
+void efi_setup_console_size(bool allow_ansi);
+
 /* Install device tree */
 efi_status_t efi_install_fdt(void *fdt);
 /* Run loaded UEFI image */
diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index 28087582e8d6..ea1608f8e6ec 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -349,22 +349,19 @@ static int __maybe_unused query_vidconsole(int *rows, int *cols)
 	return 0;
 }
 
-/**
- * efi_setup_console_size() - update the mode table.
- *
- * By default the only mode available is 80x25. If the console has at least 50
- * lines, enable mode 80x50. If we can query the console size and it is neither
- * 80x25 nor 80x50, set it as an additional mode.
- */
-void efi_setup_console_size(void)
+void efi_setup_console_size(bool allow_ansi)
 {
 	int rows = 25, cols = 80;
 	int ret = -ENODEV;
 
 	if (IS_ENABLED(CONFIG_VIDEO))
 		ret = query_vidconsole(&rows, &cols);
-	if (ret)
-		ret = query_console_serial(&rows, &cols);
+	if (ret) {
+		if (allow_ansi)
+			ret = query_console_serial(&rows, &cols);
+		else
+			ret = 0;
+	}
 	if (ret)
 		return;
 
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index e6de685e8795..d4226a3011ac 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -230,7 +230,7 @@ efi_status_t efi_init_obj_list(void)
 		return efi_obj_list_initialized;
 
 	/* Set up console modes */
-	efi_setup_console_size();
+	efi_setup_console_size(false);
 
 	/*
 	 * Probe block devices to find the ESP.
-- 
2.43.0.rc1.413.gea7ed67945-goog

