Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752C4D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AEA689255;
	Fri, 18 Oct 2024 01:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l8fN9RPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4542489275; Fri, 18 Oct 2024 01:25:09 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8039B8921E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-8323b555a6aso88025939f.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207505; x=1729812305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NAnRtxqtgYW50bSnZp5kCnSeaLZQIJqHTBmbASu/I0=;
 b=l8fN9RPmBfDmZRzQswaQczHPwqE08NGATq92gGthxZ3iTmMgyNeEFuRbsTlg0Tk/Qh
 3HL2nirvqrT4awS1KTBdx6JLW4iwG0mamtTPnj6rIaqAREzy2c4c7jXxEB/yAjAAKTvY
 rUSr35ga5zvgJpdmwu46y0yarf3SGkTqPWbU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207505; x=1729812305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NAnRtxqtgYW50bSnZp5kCnSeaLZQIJqHTBmbASu/I0=;
 b=DJbboZcuMtM0qQoQHL7U4yPFdEXJSv2Or8cyfBSCOrmk7J7OYY1BnEchoQ5RxtUwU0
 z5ph2ZH/tZXvWrz4C1weiyjBiN2tk2PxNNx29yNwhHQ3+gkQB5wJLfAc3roWGUX1H7N8
 y3NsfQBYMVqQi0MySh/nKw+wq+5PfMi5vGbvjay5yNqvkonE6Zhnj0FSGL7ra4kNp3cF
 SA/y334RM3UtR9BIgQQx7GWtjvpiG3mxgoHppzJSUnCtPz9dZeJLI/udeoAmpCpcYFWv
 FDrFMaJtiYrmcHxU55SifjsjmsTVqFgnIXoffxyMvgGD8UkYgWO8ype4az+gZCT+GdsI
 4Crw==
X-Gm-Message-State: AOJu0YwrJ1VnAQicqrZQ5EMleWhWm8305Ug/eGv6RHL8HtUMPZfsT36B
 b6J53C70cs06vt672N2Wt2bcfomloTufzHlr2bs3SYkBEsHY0x30KsO28OBoks4uSVPiEtlZda0
 =
X-Google-Smtp-Source: AGHT+IHGivDgTKf1bO6VVUwjRMWmmWJF48AAnudX6IMR6uBkZcoMJY9chU6fx1OtykW9MZWLbt/bhA==
X-Received: by 2002:a05:6e02:154c:b0:3a3:972a:3991 with SMTP id
 e9e14a558f8ab-3a3f40a859dmr5482105ab.16.1729207505114; 
 Thu, 17 Oct 2024 16:25:05 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH 24/34] bootstd: Update bootmeth_alloc_file() to record images
Date: Thu, 17 Oct 2024 17:24:03 -0600
Message-Id: <20241017232413.724808-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

 boot/bootmeth-uclass.c   | 17 ++++++++++++++++-
 boot/bootmeth_extlinux.c |  2 +-
 boot/bootmeth_script.c   |  3 ++-
 include/bootmeth.h       |  5 ++++-
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 5b5fea39b3b..34fff004b43 100644
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
+			enum image_type_t type)
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
index be8fbf4df63..755a80350d9 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -159,7 +159,7 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		return log_msg_ret("try", ret);
 	size = bflow->size;
 
-	ret = bootmeth_alloc_file(bflow, 0x10000, 1);
+	ret = bootmeth_alloc_file(bflow, 0x10000, 1, IH_TYPE_EXTLINUX_CFG);
 	if (ret)
 		return log_msg_ret("read", ret);
 
diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index c5cbf18c2e6..f01b22b064d 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -98,7 +98,8 @@ static int script_read_bootflow_file(struct udevice *bootstd,
 	if (!bflow->subdir)
 		return log_msg_ret("prefix", -ENOMEM);
 
-	ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN);
+	ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN,
+				  IH_TYPE_SCRIPT);
 	if (ret)
 		return log_msg_ret("read", ret);
 
diff --git a/include/bootmeth.h b/include/bootmeth.h
index a08ebf005ad..322169c6b2e 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -7,6 +7,7 @@
 #ifndef __bootmeth_h
 #define __bootmeth_h
 
+#include <image.h>
 #include <linux/bitops.h>
 
 struct blk_desc;
@@ -365,10 +366,12 @@ int bootmeth_try_file(struct bootflow *bflow, struct blk_desc *desc,
  * @bflow: Information about file to read
  * @size_limit: Maximum file size to permit
  * @align: Allocation alignment (1 for unaligned)
+ * @type: File type (IH_TYPE_...)
  * Return: 0 if OK, -E2BIG if file is too large, -ENOMEM if out of memory,
  *	other -ve on other error
  */
-int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align);
+int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
+			enum image_type_t type);
 
 /**
  * bootmeth_alloc_other() - Allocate and read a file for a bootflow
-- 
2.34.1

