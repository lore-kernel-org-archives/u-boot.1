Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FD5D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3193B893C2;
	Sun,  1 Dec 2024 16:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jqFBe7Ya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B695A893D1; Sun,  1 Dec 2024 16:26:25 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B8FB8914D
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-841a7ae8d8aso125222639f.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066778; x=1733671578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFfL0SuD818sNDgskQmzQ+Yqs0cttN0sMzc7o6oenWc=;
 b=jqFBe7YasLIZx4CJzFBUtSC0jOjznb6iah+VqmKx/WvU3CIH9qhNHN0s4I8TYVXx7/
 NkGpK9s9wuyJJzgEfoHqmxdKIMA8/OnWfYyMQEtSuxU0As2XzAK3YDDVD/MruXVVG1EF
 Kn7tTneYQ4/Q/KDgOqu1BvrkxPj0WaCT/F77c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066778; x=1733671578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFfL0SuD818sNDgskQmzQ+Yqs0cttN0sMzc7o6oenWc=;
 b=KARujUYwLH2+DLhO65zF5Oj+/voR6a1ae4CdhffQE1VyjYDGbNnZMIAkb/M/uSXhJC
 mjFqAakVpbiY8OQsC/WlH71Lgpvs4N1ewWA0M+1owQcQD5ORsfmf0bfnNVDkWVFL9M0g
 ziE5LlJz5R2WFIoosxLdYGypg3XAxshcK9ia1nGtcdPtDoAvehASdX4OzbR1cOwvC8f5
 8B2raxndMKu9CJdcIxyzszC95hJiE1F1u/Tw3M/s1Wo4rivfD219RvvPpwuUnsjzLCEL
 OzRRXV/9mmubskAt3pBY7VThph7FYQVG1xyzyB8kxfLKABrB4oVvQVYfepGoCG+zEtvF
 8riA==
X-Gm-Message-State: AOJu0YxoXIx77HtclboATV1HZ4uHpL1eUfi91VNBteZbIWaT138Sa24B
 RqveMeecXFgYPoMtENeLnt1g8xEyTi5OmKQ9YyCDOx0oMSuYgjG3OZrBIQwS6RoSZgp7158K4fc
 =
X-Gm-Gg: ASbGnct26fm1VTllYnEvqaszv03n49OaNlYsQiFt6rKHB7gd3CO7w3IriMoo3T2PNc+
 vTkTH0JzG5rc9ZumtSCvadI+j137yqVuEuvgzb9INfsUxswC025NPopzxdHzfHzcdDvruk8jAjs
 Ix7SvZVMSex7Id3VqG/YD6KDbAmavrqfOLuxwDgT3CtcIi1anBy7NVIlVYyIU8nVbvFC921yEmp
 T8rMJSoDN2n1A8+h8qExEjbvX9+h+BtG9OT1c6wQLoz
X-Google-Smtp-Source: AGHT+IFzM5hncQarBdc9rVVL4jI0zvHOYO9bhW2W8p+QrqeJCN47qCgaWxfisWgTwpdxV08QkK1ZUw==
X-Received: by 2002:a05:6602:6c15:b0:843:e30e:9893 with SMTP id
 ca18e2360f4ac-843ed0d5663mr2082973739f.12.1733066778021; 
 Sun, 01 Dec 2024 07:26:18 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:26:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 24/25] efi_bootmgr: Avoid casts in try_load_from_uri_path()
Date: Sun,  1 Dec 2024 08:24:43 -0700
Message-ID: <20241201152505.1666789-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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
2.43.0

