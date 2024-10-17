Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B773D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F74891E5;
	Fri, 18 Oct 2024 01:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="erh9fuLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E18DF8925B; Fri, 18 Oct 2024 01:25:07 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1933B891E3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a39cabb9b8so5628915ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207504; x=1729812304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZrXiWmib5t7dXbxlkKVf0HEL2wYfFeUYZCILYkhFLU=;
 b=erh9fuLEWCpqusDXvCrc3mws/ILNh1roFQL8uwuzvJUKCop8KBXZUf7PYUKAzsEf0c
 zT6sjjQ+nJLGE+xT9UM16fLtir4KbdKzacb8ckoqgUhvf6l+za5xk3I8hAdI0HLZUgJ9
 TorTOp47KjQD/kGg2siSUNRG80jcF71rvWnxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207504; x=1729812304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZrXiWmib5t7dXbxlkKVf0HEL2wYfFeUYZCILYkhFLU=;
 b=T08aPacFfu1Bnv08Sl1jkkfsrp4uVuT29LKvoxHezbhXzgiC85zuNNMgDUuPcvvR67
 XWeBIWXj+h2AX2SAFdeBtwvwe3e1TVFMUE3bg10FBJM2UIi6LEdrBPGZBO3L7NN7KIuv
 KDHE8VjcU0dG3G9sBm3UVHtt71PyMLhAy5Ekma5pAfKHP5490Db2irwKt4OPKhIBMVqZ
 3FfjgnYXycZ3dRgx1ZZwfjCVYt2CSzy+mvJcuoi0z3R1D5YUSTja/lz6msjzUKBX4KsF
 gplADMcpAyojrkwMlojEZCMwlSVrZjOMoW1GRm/t0szMwt427ppeP8P5ovPxK0gHXOoM
 gXVA==
X-Gm-Message-State: AOJu0YyfyFNWWHgLwbVSAG8xuFUaYn/JMITGlTNqaSkqC00uB9JzZ6Qb
 mdQUBEfbYuIhIn9uQAkDeBusEq8TwbRdk+Ihuto8CpDZ2cUhdiAO9sJQQBwJf8mSlZ7GjoE13qg
 =
X-Google-Smtp-Source: AGHT+IHI9sBaLbbABzBnHdFtWmQBZSdrulei28X2SRi1kPHoOp33u75Fx4Qpjv1eGjOIiMXiST/WHg==
X-Received: by 2002:a05:6e02:1d97:b0:3a0:a0bd:f92b with SMTP id
 e9e14a558f8ab-3a3f405e45dmr4318675ab.10.1729207503694; 
 Thu, 17 Oct 2024 16:25:03 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH 23/34] bootstd: Maintain a list of images
Date: Thu, 17 Oct 2024 17:24:02 -0600
Message-Id: <20241017232413.724808-24-sjg@chromium.org>
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

We want to keep track of images which are loaded, or those which could
perhaps be loaded. This will make it easier to manage memory allocation,
as well as permit removal of the EFI set_efi_bootdev() hack.

Add a list of these, attached to the bootflow. For now the list is
empty.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow.c    |  7 +++++++
 include/bootflow.h | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 72b51ebd49b..10bda8eac79 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -455,10 +455,13 @@ void bootflow_init(struct bootflow *bflow, struct udevice *bootdev,
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
@@ -467,6 +470,10 @@ void bootflow_free(struct bootflow *bflow)
 	free(bflow->os_name);
 	free(bflow->fdt_fname);
 	free(bflow->bootmeth_priv);
+
+	alist_for_each(img, &bflow->images)
+		free(img->fname);
+	alist_empty(&bflow->images);
 }
 
 void bootflow_remove(struct bootflow *bflow)
diff --git a/include/bootflow.h b/include/bootflow.h
index 9b24fb5c3eb..3d9a9e2025a 100644
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
@@ -109,6 +112,24 @@ struct bootflow {
 	char *cmdline;
 	void *x86_setup;
 	void *bootmeth_priv;
+	struct alist images;
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
+	enum image_type_t type;
+	ulong addr;
+	ulong size;
 };
 
 /**
-- 
2.34.1

