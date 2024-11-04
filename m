Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED832D1BDD4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D46E88F0C;
	Mon,  4 Nov 2024 18:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dm8ZtxV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F358C88618; Mon,  4 Nov 2024 18:51:31 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3EC988E50
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a6ad7c5827so14076755ab.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742688; x=1731347488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orKIWmqFcQLkEeTWHV5zZxMKRZEip9/cAkBzwg8IJuo=;
 b=Dm8ZtxV73377e39Sv0uEERTaUWfPqRYJSGaCIZQwY35J5Jlg47ZCrdMAO9ga77ho1Q
 zxcHp42lq+QjScQqXlHceRGkwKwOiGd5phZBftO/njSrJCCD2W6P3UAojP/DFxyIFKa8
 NQJwKEdvZ9uyZpopDhWBOMEan/8gQ0aSe5pCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742688; x=1731347488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orKIWmqFcQLkEeTWHV5zZxMKRZEip9/cAkBzwg8IJuo=;
 b=L8bM28u0at2+pqQAhUSsnOwKmcDZ+Y4KlFfz66KlquLe1OU4+ZLqQvdvt16FK83Qxw
 06CBn/WRkfr2/Yd+OrHJl5NymGb6cNELvrearQZhQTwxd7DhN5AKyxia35posY47y0CF
 xrANkPru73dkrW1RHGYhsBwTXG75xs1Uh2LLTekeXmiS89PRZkymiZzFXZ08bzxrbmVu
 NiDB/s5IUaFgCdjIYCuArJfRztYeRwvbOxJanCk4B4aNZ8JyqucLGIK1m5Bi2N40YUSm
 2NEVp3MUcGrTEio8/doQiuIOl5riXXnWYF4C6Bg6gSM5PoCIw1TrKNN+oSC86ErJHhEA
 xVGA==
X-Gm-Message-State: AOJu0Yw+D7laktyCc+1XQHOaU2JzIxsOua7Sgpdw/Gs/XcWkV9LPxUc5
 cSsZRQzRryUSp0OyJP6O+Zpog6Jk/9YwbbtCJI1XNzmcfdHKJLJe8DnKJHuuFmy9LWIKERMX4uw
 =
X-Google-Smtp-Source: AGHT+IFlawNcN/HyEMMUFyFM58n/l8msfo0vhkveodlFgs0t9loQaesiY18tFTDWASlkBiUdErcxDQ==
X-Received: by 2002:a05:6e02:218f:b0:3a6:af24:b8c4 with SMTP id
 e9e14a558f8ab-3a6b0354e19mr132529085ab.20.1730742687910; 
 Mon, 04 Nov 2024 09:51:27 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ion Agorria <ion@agorria.com>,
 Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v3 07/19] bootstd: Update bootmeth_alloc_file() to record
 images
Date: Mon,  4 Nov 2024 10:50:58 -0700
Message-Id: <20241104175110.1048449-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175110.1048449-1-sjg@chromium.org>
References: <20241104175110.1048449-1-sjg@chromium.org>
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

Create a helper function in the bootflow system, since recorded
images are always associated with bootflows.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add a helper in bootflow

Changes in v2:
- Update to use a new image-type enum in bootflow.h

 boot/bootflow.c          | 21 +++++++++++++++++++++
 boot/bootmeth-uclass.c   | 12 +++++++++++-
 boot/bootmeth_extlinux.c |  2 +-
 boot/bootmeth_script.c   |  3 ++-
 include/bootflow.h       | 15 +++++++++++++++
 include/bootmeth.h       |  8 +++++---
 6 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 94f34dcad0f..a10d3012b48 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -976,3 +976,24 @@ const char *bootflow_img_type_name(enum bootflow_img_t type)
 
 	return name;
 }
+
+struct bootflow_img *bootflow_img_add(struct bootflow *bflow, const char *fname,
+				      enum bootflow_img_t type, ulong addr,
+				      ulong size)
+{
+	struct bootflow_img img, *ptr;
+
+	memset(&img, '\0', sizeof(struct bootflow_img));
+	img.fname = strdup(fname);
+	if (!img.fname)
+		return NULL;
+
+	img.type = type;
+	img.addr = addr;
+	img.size = size;
+	ptr = alist_add(&bflow->images, img);
+	if (!ptr)
+		return NULL;
+
+	return ptr;
+}
diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 5b5fea39b3b..c219631816f 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -6,6 +6,7 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
+#include <alist.h>
 #include <blk.h>
 #include <bootflow.h>
 #include <bootmeth.h>
@@ -326,8 +327,10 @@ int bootmeth_try_file(struct bootflow *bflow, struct blk_desc *desc,
 	return 0;
 }
 
-int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align)
+int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
+			enum bootflow_img_t type)
 {
+	struct blk_desc *desc = NULL;
 	void *buf;
 	uint size;
 	int ret;
@@ -344,6 +347,13 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align)
 	bflow->state = BOOTFLOWST_READY;
 	bflow->buf = buf;
 
+	if (bflow->blk)
+		desc = dev_get_uclass_plat(bflow->blk);
+
+	if (!bootflow_img_add(bflow, bflow->fname, type, map_to_sysmem(buf),
+			      size))
+		return log_msg_ret("bai", -ENOMEM);
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
 
diff --git a/include/bootflow.h b/include/bootflow.h
index f407bb356b4..e09cff285e4 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -613,4 +613,19 @@ int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg);
  * Return: Image name, or "unknown" if not known
  */
 const char *bootflow_img_type_name(enum bootflow_img_t type);
+
+/**
+ * bootflow_img_add() - Add a new image to a bootflow
+ *
+ * @bflow: Bootflow to add to
+ * @fname: Image filename (will be allocated)
+ * @type: Image type
+ * @addr: Address the image was loaded to, or 0 if not loaded
+ * @size: Image size
+ * Return: pointer to the added image, or NULL if out of memory
+ */
+struct bootflow_img *bootflow_img_add(struct bootflow *bflow, const char *fname,
+				      enum bootflow_img_t type, ulong addr,
+				      ulong size);
+
 #endif
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

