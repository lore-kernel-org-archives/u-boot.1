Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC85FD6911B
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFEA889D92;
	Thu, 28 Nov 2024 16:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KjX3NZ9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBBB89D92; Thu, 28 Nov 2024 16:49:03 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2216E89885
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3e786167712so480067b6e.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808939; x=1733413739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmrBFPpqz3a9b7Ie49II2QIxVH35uzk7Uwx/yEzQbvA=;
 b=KjX3NZ9LFe/kDmFIWxFAOlZ9lfM+rTNpCbO3XCEjyMS4pqZ2b6WLlJl+16iDtWLUqt
 92+4oYx0QVWyedFKSSiRryzatXfEcDVfb7bW1KFbNQX5TmezIgNWRL9RIM4F23WszMO8
 mFcrjwyqavgTh00PbJiuLTSoJqs0ioVon0n3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808939; x=1733413739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmrBFPpqz3a9b7Ie49II2QIxVH35uzk7Uwx/yEzQbvA=;
 b=vE0wqSsbf5BE/UsiKlSGsUiKpd+0nG51up0bmR5dCQ2gVeN1XVVU+C86b/iBwdb3Bk
 /xVcMEkxDRu8380cdSKHDc9teQFSiQK24ldJ6kWHKzI2bwfe49k9WfD0vdd5oGim9O8E
 0i+h+15MI0lx4TRurJOaySHdohDff0x+LM3AEAic4/ZmpIHTDnwpJTySCPrHxyHFk20o
 wb7pIwXNTwRy1G0Wlvl4hBXFpbxw6s3FNmB8vyi21SSJ2RxoGXIP0izwbS3QBJ/9cTpO
 A0LQyNJX5bpFqBSmDc7LLKPXWGdZ8GCODV4xNxfAnQnrO8RNwWnlsc+SEUreBv9qhNpc
 u8qQ==
X-Gm-Message-State: AOJu0YzeX7BKyb6MayjUrY3p7GCIWHJRN7OiBwgc1egmP7fMpX/IAX2q
 l71/V5DB289PnMz039AX8/9n0KHIWNeV3vI3/+yfEc4FTy9ALadAjr4coItaqyXTJLLDEZk078k
 =
X-Gm-Gg: ASbGnctHx1XsHYHxUikL5nzCZzP0cwHWvE481cSWoUFqk0DZ/qHIKYQJWQkYvC24Xj1
 VkisS57jDpGr0M9UOzWm4evkkAAqZUweX1eSz8hKDwL0StEPSj6zVjUL8qAp8KXLn8nSQfDTasT
 xf7CdyY3d6hjBG0BQwtAALIJIeJA22Nw9Sr3qn8ehKWtx35/YiaIcvDdAFBC28l0TBNymE7AarQ
 n0/2VkvPoRHGu/gUTVPDbviHxxIgWJq2iCgdpmpELuLtw==
X-Google-Smtp-Source: AGHT+IGKVLIu5pmKJpzGLXSO5d243w+e+TdzbAW4kEJPbsbdRl0NpJk8SqLLGblAykzyi7S0OVTYAQ==
X-Received: by 2002:a05:6808:1304:b0:3e6:37f7:5a3a with SMTP id
 5614622812f47-3ea6dd9fbffmr6905174b6e.41.1732808939119; 
 Thu, 28 Nov 2024 07:48:59 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:48:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 26/28] efi_bootmgr: Avoid casts in try_load_from_uri_path()
Date: Thu, 28 Nov 2024 08:47:25 -0700
Message-Id: <20241128154727.771871-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

 lib/efi_loader/efi_bootmgr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index b4ea6b817b6..98799aead84 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -14,6 +14,7 @@
 #include <efi.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <net.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
@@ -497,6 +498,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 	 * If the file is PE-COFF image, load the downloaded file.
 	 */
 	uri_len = strlen(uridp->uri);
+	source_buffer = map_sysmem(image_addr, image_size);
 	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
 	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
 		ret = prepare_loaded_image(lo_label, image_addr, image_size,
@@ -506,21 +508,19 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 
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

