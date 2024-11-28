Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB64FD70DEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8472289D74;
	Thu, 28 Nov 2024 20:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JMWurwSq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC1889D8A; Thu, 28 Nov 2024 20:13:55 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBB0589D33
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71d4e043dd9so501137a34.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821231; x=1733426031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmrBFPpqz3a9b7Ie49II2QIxVH35uzk7Uwx/yEzQbvA=;
 b=JMWurwSqhfSp0Cf8oeiTgMvWEtPmWtBig3bFnOVPFq9CD2qJw7GER5UudXR9Vq3u+X
 ZZSX2UIiboWjEKl/xT0rpcmyHd5RPIwew9o2BjLaFLFGhdST8lyi8fc7iv+7rSPUa6R8
 Rfk1XuVsN0GmWfg1RUWltIGPBZB0lkXB1Z8tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821231; x=1733426031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmrBFPpqz3a9b7Ie49II2QIxVH35uzk7Uwx/yEzQbvA=;
 b=BasUOMS9zfwyRZBHgnHQxKI3FDciAclSvrOL1OFVDJfWT2T9UMlURJXKWU9BRU4Kcs
 TvUoNxb9l0SRxx+7D9YK0rGWJxykFr3tGNy/9J6ayL28nUEKfvVGL/r/jmvzBP7SOVbj
 ZDz+sM7bttJjEuGnVIoGOJIKy1i0HjNh7JxVn1gEp8T8MUv0/RQttwu1rl1qxW3o3fyM
 ldYD/vbUZC87hcziKE/HAdU9pzZM2l0S11KtEDMQIcEOs15UY7jUb+ZsFb+FjoXbfWUb
 MclKkx5nEq5w7rfx1vt4XHG56EI6hHsMSN8l+vA1ExLf7acwsCCkYRChW9GwpnUNM8fx
 CrQw==
X-Gm-Message-State: AOJu0YwGu5Uixc5FSVG84OaXlcsXZqpY5rfoe6Njy98m770U+Bl7q2zF
 6cwYtH0dns4VBIbd2JQApU4Lwffn22B+oUWQ2lDWo7+gxQ4NAcGr+tWfLhuksiYRsHIh6+Hk/3E
 =
X-Gm-Gg: ASbGncvLLyxZS4iveXEc5bVYGopvu8CJTrADzkke3vKv7t/egBpC8q3zTAiOHOJ84wx
 dI+MRv6SYQXH66YagGnpLV5tbYT0bqgihmCgoN2lluHesuMH8Fl3xR6yG+LuuQcCzJWJtoMd4j3
 S9Gjbuej5o8UmG0sIy03x95zZ9Y1Yz3kNYHWz6wILPvTN4P2Vx6atQuppPS9wRrSQpWQS/RPiCJ
 FgtIG5a5PTgR/2khZVufAPxV0LcPRvF1cp0czK3Ub0L2g==
X-Google-Smtp-Source: AGHT+IFwAoSpZjSJYy8ehftvqItOu7rSg1KVH6KBgUeLx37TddSIKjoMIDSa+nIXMdoMTahw96eZYQ==
X-Received: by 2002:a05:6830:6e9c:b0:717:d2f8:6bb8 with SMTP id
 46e09a7af769-71d65cb2043mr7703652a34.12.1732821231093; 
 Thu, 28 Nov 2024 11:13:51 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 26/28] efi_bootmgr: Avoid casts in try_load_from_uri_path()
Date: Thu, 28 Nov 2024 12:12:42 -0700
Message-Id: <20241128191244.900006-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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

