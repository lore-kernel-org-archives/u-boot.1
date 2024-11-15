Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EDED68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6215896FD;
	Sat, 16 Nov 2024 00:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FGrwZFe2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68C0F8970B; Sat, 16 Nov 2024 00:19:56 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2330D891A5
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83e2d80ad51so80904739f.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712792; x=1732317592; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ozNG7fiNCfQdI+g22LplNj6OcHOBkmFo6yfCi0oTzto=;
 b=FGrwZFe24iuRCTzGvr/dgt4yefSAGQAY9QtxOGv5tYLa7I2AMFWn6lM1KeVaE+k0Q1
 qDA/S1wL0GLJAEIpeWIDwqf7p7GX0PxV08wLwLAtBQqRwryz8II4eLg9N8Z2Yc1tsyDs
 NcAR6z5f9572dmD9rb9zVdymTuh7dpVFAQHns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712792; x=1732317592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ozNG7fiNCfQdI+g22LplNj6OcHOBkmFo6yfCi0oTzto=;
 b=cvqc+S/QCshh+4mcOR/6Z5TcDABzB/YY+KuS42AKCvfru1D1Q7Lx6/KoaijaVBalMg
 5ieZ5T4VS0XohUFTf3gionBAp+N4bPz259rNwZl9qiRqfRlJB804Gon2uh8VUeNe7V9j
 dsl4xdL6aYjbDDvUsTdwvSR/ZAnYsnHrV06pUWd/Q7E8cOuRW1fVOTw7hIQGwk1QCqiS
 ARb2ad03dMcn/ZQkOukCs8B5OpyfsNB0YBUlaHHgTnZhj6g0LL0fithSkTyQqG21b4c8
 oJfif2X+K4BHjhcRYJUtJwwVb3Sia3ISWAjV+GfsyAZagTmHuHHdBTT/U38Ad5qCCTzJ
 DSjA==
X-Gm-Message-State: AOJu0Yy5HnW8wsew0YU2wrXVRuqyeoVDFtbeVq22t0rg3KGzY4FMGMS8
 BP1BFVp3n5CZHUxC/lJ7PxA8dO0cpBt3HQRuwfK21FPhgwi84qma8GbLkJfkT4/uHzdmYcv5yTQ
 =
X-Google-Smtp-Source: AGHT+IEixDmhphKJ2gqdbQvXF1o0CbWXGyMGATPOaiSM9TKIEm+O8lkZCYTPzPJzT9gB7G9eTU/Vqg==
X-Received: by 2002:a05:6602:164c:b0:82a:7181:200f with SMTP id
 ca18e2360f4ac-83e6c284c35mr495505439f.9.1731712792355; 
 Fri, 15 Nov 2024 15:19:52 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:19:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>
Subject: [PATCH v4 06/19] bootstd: Maintain a list of images
Date: Fri, 15 Nov 2024 16:19:13 -0700
Message-Id: <20241115231926.211999-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115231926.211999-1-sjg@chromium.org>
References: <20241115231926.211999-1-sjg@chromium.org>
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

We want to keep track of images which are loaded, or those which could
perhaps be loaded. This will make it easier to manage memory allocation,
as well as permit removal of the EFI set_efi_bootdev() feature.

Add a list of these, attached to the bootflow. For now the list is
empty.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add an image type extension in bootflow.h
- Use the word 'feature' instead of 'hack'

 boot/bootflow.c    | 26 +++++++++++++++++++++++++
 include/bootflow.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 7ce04fd92cd..94f34dcad0f 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -23,6 +23,13 @@ enum {
 	BF_NO_MORE_DEVICES	= -ENODEV,
 };
 
+static const char *const bootflow_img[BFI_COUNT - BFI_FIRST] = {
+	"extlinux_cfg",
+	"logo",
+	"efi",
+	"cmdline",
+};
+
 /**
  * bootflow_state - name for each state
  *
@@ -455,10 +462,13 @@ void bootflow_init(struct bootflow *bflow, struct udevice *bootdev,
 	bflow->dev = bootdev;
 	bflow->method = meth;
 	bflow->state = BOOTFLOWST_BASE;
+	alist_init_struct(&bflow->images, struct bootflow_img);
 }
 
 void bootflow_free(struct bootflow *bflow)
 {
+	struct bootflow_img *img;
+
 	free(bflow->name);
 	free(bflow->subdir);
 	free(bflow->fname);
@@ -467,6 +477,10 @@ void bootflow_free(struct bootflow *bflow)
 	free(bflow->os_name);
 	free(bflow->fdt_fname);
 	free(bflow->bootmeth_priv);
+
+	alist_for_each(img, &bflow->images)
+		free(img->fname);
+	alist_empty(&bflow->images);
 }
 
 void bootflow_remove(struct bootflow *bflow)
@@ -950,3 +964,15 @@ int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg)
 
 	return 0;
 }
+
+const char *bootflow_img_type_name(enum bootflow_img_t type)
+{
+	const char *name;
+
+	if (type >= BFI_FIRST && type < BFI_COUNT)
+		name = bootflow_img[type - BFI_FIRST];
+	else
+		name = genimg_get_type_short_name(type);
+
+	return name;
+}
diff --git a/include/bootflow.h b/include/bootflow.h
index 9b24fb5c3eb..f407bb356b4 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -7,7 +7,9 @@
 #ifndef __bootflow_h
 #define __bootflow_h
 
+#include <alist.h>
 #include <bootdev.h>
+#include <image.h>
 #include <dm/ofnode_decl.h>
 #include <linux/list.h>
 
@@ -85,6 +87,7 @@ enum bootflow_flags_t {
  * @cmdline: OS command line, or NULL if not known (allocated)
  * @x86_setup: Pointer to x86 setup block inside @buf, NULL if not present
  * @bootmeth_priv: Private data for the bootmeth
+ * @images: List of loaded images (struct bootstd_img)
  */
 struct bootflow {
 	struct udevice *dev;
@@ -109,6 +112,44 @@ struct bootflow {
 	char *cmdline;
 	void *x86_setup;
 	void *bootmeth_priv;
+	struct alist images;
+};
+
+/**
+ * bootflow_img_t: Supported image types
+ *
+ * This uses image_type_t for most types, but extends it
+ *
+ * @BFI_EXTLINUX_CFG: extlinux configuration-file
+ * @BFI_LOGO: logo image
+ * @BFI_EFI: EFI PE image
+ * @BFI_CMDLINE: OS command-line string
+ */
+enum bootflow_img_t {
+	BFI_FIRST = IH_TYPE_COUNT,
+	BFI_EXTLINUX_CFG = BFI_FIRST,
+	BFI_LOGO,
+	BFI_EFI,
+	BFI_CMDLINE,
+
+	BFI_COUNT,
+};
+
+/**
+ * struct bootflow_img - Information about an image which has been loaded
+ *
+ * This keeps track of a single, loaded image.
+ *
+ * @fname: Filename used to load the image (allocated)
+ * @type: Image type (IH_TYPE_...)
+ * @addr: Address to which the image was loaded, 0 if not yet loaded
+ * @size: Size of the image
+ */
+struct bootflow_img {
+	char *fname;
+	enum bootflow_img_t type;
+	ulong addr;
+	ulong size;
 };
 
 /**
@@ -565,4 +606,11 @@ int bootflow_cmdline_get_arg(struct bootflow *bflow, const char *arg,
  */
 int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg);
 
+/**
+ * bootflow_img_type_name() - Get the name for an image type
+ *
+ * @type: Type to check (either enum bootflow_img_t or enum image_type_t
+ * Return: Image name, or "unknown" if not known
+ */
+const char *bootflow_img_type_name(enum bootflow_img_t type);
 #endif
-- 
2.34.1

