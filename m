Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A677DE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F56F8037B;
	Wed, 11 Dec 2024 14:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OW8uqIWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7295180379; Wed, 11 Dec 2024 14:55:06 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED2C8033A
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844c819cce7so87179839f.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925302; x=1734530102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dA9RxENhbPBGyenU2f/RjF/jUlOjzqbVaDH8sM0emGw=;
 b=OW8uqIWZYHH1bFXKXfNN2Kdts2w29NfyXHGUkl4Fa0AhYCqv7/6COHBCZu0BNxcIWV
 Grq8x6yfx6UlQHxstIAyzrrvbYBszbNM9UBgDwpwNzo+CizVrH59C7+EuxyOp21JQINc
 cwCnppze5OkTuprLV3c0iVRmzUMBlK1ZLnRFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925302; x=1734530102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dA9RxENhbPBGyenU2f/RjF/jUlOjzqbVaDH8sM0emGw=;
 b=TjNtpND5IMLmWX6xhgJCGaBTs4l3ESxWiqdKEnXKcir6H2gR+w8/Rrg7iQg8YMr8eA
 Ynxg0j05IJUNz6NEsgd8Gp4grA3CPfQbQnPyt8FE4PkqwjM1bvtKmwHuYE7lKqf4TSiW
 WjJtzANpOtnf0BEXp1rGEhUJupKOwoc1J9+4oTubA/cvBk4C5LbVaXV4giSYOoyOwP1J
 rMroxdHGQCjrDgJiue2By+tsd0ksz/jy19MIt0Ht6iZIgmSHYIXWZmEm8jU4xSXADG5Y
 RjuW/w8Q4PvaR9+uCqeJ6vkW86APOf9RZ12iXb8KVBDgi0HBwQDYm+70W6SstZTpq2xP
 zH1A==
X-Gm-Message-State: AOJu0YzxG1dBRzzhZUasnNjCH4rGNe4iu/NT96+1J9g3Titck287e+ju
 sZctQvYCoY3WnstiJm5pLQNSmdrf8pTzXKLYvuUt+NmUpo8whtnz/NlOAQmdgq43OkOSK1iJLfE
 =
X-Gm-Gg: ASbGnctdjPmiZNm0C9Iqzb1c4Tm2a0iDjFl/L325ISNEQVbYH1kBVw/B9Z523p0JzSz
 UW1c5YMMqyM5dlZQ7U8EYpB+fuyt4DOXrkl7JCbmGadAQTW5to7GeOqZ/St/+vgiwHBEdnxh47f
 GLrARaWconAGSuTxbryJXDfwsBw1qlkjcFT5FecpV2prBSyNvFRhPIgaOldTwdgOndMCStwENCP
 K+CZCda3A/Ei6gc4t9P986leLBff+GLQS2x20BWgEjLm8n6v/2+8++RbTyARbGRlNMe66QiR2yW
 qhz5e1QvmuCuWg8=
X-Google-Smtp-Source: AGHT+IHAJKUboB8eocwim4hVVxmgj8skbQOlNrfLT037qK4dMGtpsnF6k6C47edRooUPTumSjVFU9w==
X-Received: by 2002:a05:6e02:1fe5:b0:3a4:eca2:95f1 with SMTP id
 e9e14a558f8ab-3aa0606e1afmr36611595ab.6.1733925302551; 
 Wed, 11 Dec 2024 05:55:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:55:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 22/23] efi_bootmgr: Avoid casts in try_load_from_uri_path()
Date: Wed, 11 Dec 2024 06:54:16 -0700
Message-Id: <20241211135418.563803-23-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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

Update this function to use map_sysmem() so that it can work correctly
on sandbox

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_bootmgr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 9383adbd958..98799aead84 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -498,6 +498,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 	 * If the file is PE-COFF image, load the downloaded file.
 	 */
 	uri_len = strlen(uridp->uri);
+	source_buffer = map_sysmem(image_addr, image_size);
 	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
 	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
 		ret = prepare_loaded_image(lo_label, image_addr, image_size,
@@ -507,21 +508,19 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 
 		source_buffer = NULL;
 		source_size = 0;
-
-	/* TODO(sjg): This does not work on sandbox */
-	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
+	} else if (efi_check_pe(source_buffer, image_size, NULL) ==
+			EFI_SUCCESS) {
 		/*
 		 * loaded_dp must exist until efi application returns,
 		 * will be freed in return_to_efibootmgr event callback.
 		 */
 		loaded_dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
-					    (uintptr_t)image_addr, image_size);
+					    image_addr, image_size);
 		ret = efi_install_multiple_protocol_interfaces(
 			&mem_handle, &efi_guid_device_path, loaded_dp, NULL);
 		if (ret != EFI_SUCCESS)
 			goto err;
 
-		source_buffer = (void *)image_addr;
 		source_size = image_size;
 	} else {
 		log_err("Error: file type is not supported\n");
-- 
2.34.1

