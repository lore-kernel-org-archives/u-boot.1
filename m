Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED0AD3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B13D789320;
	Sat, 19 Oct 2024 17:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RAPm6xpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B1689319; Sat, 19 Oct 2024 17:22:56 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 894E6892F7
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-83abcfb9f39so47898439f.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351372; x=1729956172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUL5md+LgUKdu+F/kZka4UIWL3AXPmoTpZBp0wPGdTw=;
 b=RAPm6xpG1VnwiaX8d2Sgv9ZUZI5QeVtKcP3eenBYdKGkrQphV0lH9i2FS9PPciLtpH
 r5cGWCBMjZLGi9wWCi/Utdzo/tbUfYQDr4R3nCdmKNWxdW5yJwRXgQvJZLFOGA0uVp6f
 Z8hu5HA0KjeGegByw8Fpw0l2WfqI/OFh0967I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351372; x=1729956172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fUL5md+LgUKdu+F/kZka4UIWL3AXPmoTpZBp0wPGdTw=;
 b=MlKsd03fqvngpfJy6KLkuFAlU6UwKnCfRyaAQ7u1I6M1EWgUAcg9zpCKzpDilirK/i
 fx6g9OO5iXqF3rliEaIx89Kle3B7/3X3sDdtwZpq98xoAVlNtVCeyubc+ldWP8PNH+nH
 cg1sdapWDqCQU+/kMBTdm0ToRTfkLJGkA8dYZO2rY8zLKPYoIfXKihl2hz1KGLjVF3YO
 BSbCvjbh3nN5yXwsKaWBmNjA1NafMNODjZV47TS/0Cpr2hpvImcRxSPpJcOo+bPKxcmW
 fK9K1L+2i4/P7XdlsV3PIXYkKtaAdNP6w/9UCvnutjneqe+P9s1gVK5wUAfAG4jbAZS8
 5snQ==
X-Gm-Message-State: AOJu0YyNKfv8DmdmoCvbwuzvvvUYcDRQMBgFMVvAxTljkSMCDJj9xLUd
 qgLRaPQIakrFqBB3+FAF4IeMJd1t0II19ynKxpcyjzHeQ/QbR12l22vD8jTwIfDJiUdkXAiDx9M
 =
X-Google-Smtp-Source: AGHT+IEDmS1+Ojb0Uxz6+NnVUVqie/PeIyMRvfiD3n02JcCwb2rU+lE1FQEGfDukYbz4SFw0hPG22Q==
X-Received: by 2002:a05:6602:6709:b0:835:3dfc:5ba5 with SMTP id
 ca18e2360f4ac-83aadec58fcmr666502439f.5.1729351372216; 
 Sat, 19 Oct 2024 08:22:52 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v2 20/31] bootstd: Maintain a list of images
Date: Sat, 19 Oct 2024 09:22:00 -0600
Message-Id: <20241019152211.1014896-21-sjg@chromium.org>
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

We want to keep track of images which are loaded, or those which could
perhaps be loaded. This will make it easier to manage memory allocation,
as well as permit removal of the EFI set_efi_bootdev() feature.

Add a list of these, attached to the bootflow. For now the list is
empty.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add an image type extension in bootflow.h
- Use the word 'feature' instead of 'hack'

 boot/bootflow.c    | 26 +++++++++++++++++++++++++
 include/bootflow.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 72b51ebd49b..33725bde602 100644
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
@@ -946,3 +960,15 @@ int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg)
 
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

