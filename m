Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BE4D3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41CDF89326;
	Sat, 19 Oct 2024 17:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xaev/EDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C81892F3; Sat, 19 Oct 2024 17:22:57 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE69189308
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-83aad8586d3so139991839f.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351373; x=1729956173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMKr6m/yj4u89YqPx3c1qUjYcie1e3SRIGIqZti4rGs=;
 b=Xaev/EDsOCqkHwtgqwsHQYJoZJAjuKjOXc2AfR+1WYPdvPKaAuBiTSCiOCyab7Wj9w
 Eplb5tssMkniu99JdEH+3F2yyKSp/ZlWOqe/T65m0jvxGRLa+rayPlW2un8t86b9IF18
 /ZV7QOyspi0IDWKV8Q97UGATjVqC3iYUzOnBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351373; x=1729956173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMKr6m/yj4u89YqPx3c1qUjYcie1e3SRIGIqZti4rGs=;
 b=xMxzHsiuY6eBW2YEIouRZ29GYDTFMj92wXLUrp9mvPBOjAaQ61ZDUxPAuQyDGG7Y5G
 xZkhNt8jRjKVuXlx//g3ZjIqzeOmiqkNNlm+aLJO+warur9XlQWKOCwmBcy3HPAldZlE
 cgydnmS1Kz/jIzDZA8IeHDnrev/M9DBjX7FlHq37roK615pBjAyhD1oUQtn3+cWuMaI5
 s6q3kM/YHP3ubyUMjPN+Ax2LeF0IORasvxTiL7BXU9hofoWkaPFeaPhtKfKXjYwKAc4f
 dC6Mw+g4Ut7Et2muMVbx+BjFri3Ll5YYgflctCEVY6JzjSEvlaU97eWqiqQSyluQdL36
 rLlQ==
X-Gm-Message-State: AOJu0YxQ2xW9HUYyPHxADc5z6uFd/RmKfny0xyUUrwCdqwfZZ7mBN8IE
 TgJfVRxBPJ77zjH2USz841u2DEYfgZib5k4G0C5Wyq2kYYtCVAMrcweQ1MxDMafeCBSnxu2k9/Q
 =
X-Google-Smtp-Source: AGHT+IFPx1CmZspbjm2cR+nGhF2kODUfn6ReDDkQ6Y/pcD/bEQtD6K7eAIDdZBWv6WOZwCNPM9zfIg==
X-Received: by 2002:a05:6602:641e:b0:83a:a82b:f856 with SMTP id
 ca18e2360f4ac-83aba5bbec0mr511335639f.3.1729351373599; 
 Sat, 19 Oct 2024 08:22:53 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Stefan Roese <sr@denx.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2 21/31] bootstd: Update bootmeth_alloc_file() to record
 images
Date: Sat, 19 Oct 2024 09:22:01 -0600
Message-Id: <20241019152211.1014896-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

As a first step to recording images and where they came from, update
this function to do so, since it is used by two bootmeths

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Update to use a new image-type enum in bootflow.h

 boot/bootmeth-uclass.c   | 17 ++++++++++++++++-
 boot/bootmeth_extlinux.c |  2 +-
 boot/bootmeth_script.c   |  3 ++-
 include/bootmeth.h       |  8 +++++---
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 5b5fea39b3b..9178fca09cc 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -6,6 +6,7 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
+#include <alist.h>
 #include <blk.h>
 #include <bootflow.h>
 #include <bootmeth.h>
@@ -326,8 +327,11 @@ int bootmeth_try_file(struct bootflow *bflow, struct blk_desc *desc,
 	return 0;
 }
 
-int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align)
+int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
+			enum bootflow_img_t type)
 {
+	struct bootflow_img *img;
+	char *fname;
 	void *buf;
 	uint size;
 	int ret;
@@ -344,6 +348,17 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align)
 	bflow->state = BOOTFLOWST_READY;
 	bflow->buf = buf;
 
+	fname = strdup(bflow->fname);
+	if (!fname)
+		return log_msg_ret("alf", -ENOMEM);
+	img = alist_add_placeholder(&bflow->images);
+	if (!img)
+		return log_msg_ret("als", -ENOMEM);
+	img->fname = fname;
+	img->type = type;
+	img->addr = map_to_sysmem(buf);
+	img->size = size;
+
 	return 0;
 }
 
diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index be8fbf4df63..6c158c2a6c6 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -159,7 +159,7 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		return log_msg_ret("try", ret);
 	size = bflow->size;
 
-	ret = bootmeth_alloc_file(bflow, 0x10000, 1);
+	ret = bootmeth_alloc_file(bflow, 0x10000, 1, BFI_EXTLINUX_CFG);
 	if (ret)
 		return log_msg_ret("read", ret);
 
diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index c5cbf18c2e6..a2fb2899885 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -98,7 +98,8 @@ static int script_read_bootflow_file(struct udevice *bootstd,
 	if (!bflow->subdir)
 		return log_msg_ret("prefix", -ENOMEM);
 
-	ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN);
+	ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN,
+				  (enum bootflow_img_t)IH_TYPE_SCRIPT);
 	if (ret)
 		return log_msg_ret("read", ret);
 
diff --git a/include/bootmeth.h b/include/bootmeth.h
index a08ebf005ad..e812974ec4d 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -7,11 +7,11 @@
 #ifndef __bootmeth_h
 #define __bootmeth_h
 
+#include <bootflow.h>
+#include <image.h>
 #include <linux/bitops.h>
 
 struct blk_desc;
-struct bootflow;
-struct bootflow_iter;
 struct udevice;
 
 /**
@@ -365,10 +365,12 @@ int bootmeth_try_file(struct bootflow *bflow, struct blk_desc *desc,
  * @bflow: Information about file to read
  * @size_limit: Maximum file size to permit
  * @align: Allocation alignment (1 for unaligned)
+ * @type: File type (IH_TYPE_...)
  * Return: 0 if OK, -E2BIG if file is too large, -ENOMEM if out of memory,
  *	other -ve on other error
  */
-int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align);
+int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
+			enum bootflow_img_t type);
 
 /**
  * bootmeth_alloc_other() - Allocate and read a file for a bootflow
-- 
2.34.1

