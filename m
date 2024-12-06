Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9590E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA0B896D5;
	Fri,  6 Dec 2024 03:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mt3gNPWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609E78918C; Fri,  6 Dec 2024 03:37:14 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1379289734
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a777c67c45so5889525ab.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452630; x=1734057430; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nYuQKd/i6J8gzVoWw5MFu3/dgDGjbgus2wpZ1fWwLs=;
 b=mt3gNPWNUZnIserrMF4M32SXO8VZho7gP6x5i4ZT2X4fJc7Kie4K5H4ATqAtby02QQ
 svNx/C3755iHJZIwqhLe897jT0gGN0nBvGjXBuBEuCmcQdS6kfBP6AjkX1lPVUhK8Y8C
 FeJl5vAcaIVOmFeANLZagtjwz+g0ncbz6vnms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452630; x=1734057430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nYuQKd/i6J8gzVoWw5MFu3/dgDGjbgus2wpZ1fWwLs=;
 b=vkPBUXh4HzIsZZEg7Xx+NRcBO2o5z9Ba/9yLMigOYhkYloOmQvVUNVDnllaQJle0JJ
 PfYLYU5sSnOR8da3VkcQw5mxjOOSt0eRm7h6Rm7x7DYCd1KdRJWukmXkbvT0cHnaXRbK
 gzfgKX4sXUvudvQwy3aShxC7Ux+tO+lAFPqnnX0JffXsVFAsOyZZTIQwbxY72zmNnw3u
 rEfHuBlRJNWzs5srwK5B7F5alMDTNDcxbAKPaFvn3PhveGQAK2NvPExzDQkptGi5oB3v
 h/lMCIYoip+ooiTxRnMu7scf641C/VS612JaEDC7s7ImY8cftU0I506wAN5ShkMPftOr
 hI9Q==
X-Gm-Message-State: AOJu0YxqiQsTqaajrhF76uXV4+Er06TtzscG4GeDr3iByJvTp0bu3Zi1
 ExJoGNjjqggK88evYxt4NQXMiGMf7ooyLHCjCdEZh6qFuwu3hVVhlz+a/znopIcgp0pWqKaYWfU
 =
X-Gm-Gg: ASbGnctkOgbE16BubAb0/sLBeVMYbn2ssZnLj9r7P18TaoccPtxfJXFSFBvdBhRcQPK
 0341S54iioJwVLiYtDcJuBRj4mMDaH1OpI/WjQrODEh4x9J3/X4vzrdM9vIWXzCvBAw7yOGsbL1
 ugTVuXBtKsfzUu0CbZN52Xjk0pmyyc28VXBhR9UcIRuY4e7U82wA6yl7UTNjfB+ZQTWUWiJX2Ux
 5OkQH7BjwYIu0v0cAI3+OfWbceaOUILHVjVqqqbru/85HRPbQVT91sMkQ8ohLEvdbjVosw4DEme
 kN3vPeiuFkI=
X-Google-Smtp-Source: AGHT+IFjezkKEvTtm4Tcrq+3CmDPOLy4qHqeu00bAfCd8fIiV/KbYmiGhNznchztexhS+auEJoPHcw==
X-Received: by 2002:a05:6e02:10ce:b0:3a8:13d5:bd2c with SMTP id
 e9e14a558f8ab-3a813d5bd8emr8154075ab.2.1733452630178; 
 Thu, 05 Dec 2024 18:37:10 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, Rick Chen <rick@andestech.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 15/46] boot: arm: riscv: sandbox: Add a format for the
 booti file
Date: Thu,  5 Dec 2024 19:35:54 -0700
Message-Id: <20241206023626.2456858-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Arm invented a new format for arm64 and something similar is also used
with RISC-V. Add this to the list of supported formats and provide a way
for the format to be detected on both architectures.

Update the genimg_get_format() function to support this.

Fix up switch() statements which don't currently mention this format.
Booti does not support a ramdisk, so this can be ignored.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to add a format for the booti file

 arch/arm/lib/image.c     | 9 ++++++++-
 arch/riscv/lib/image.c   | 9 ++++++++-
 arch/sandbox/lib/bootm.c | 5 +++++
 boot/image-board.c       | 5 +++++
 include/image.h          | 9 +++++++++
 5 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/image.c b/arch/arm/lib/image.c
index 1f672eee2c8..d78d704cb58 100644
--- a/arch/arm/lib/image.c
+++ b/arch/arm/lib/image.c
@@ -28,6 +28,13 @@ struct Image_header {
 	uint32_t	res5;
 };
 
+bool booti_is_valid(const void *img)
+{
+	const struct Image_header *ih = img;
+
+	return ih->magic == le32_to_cpu(LINUX_ARM64_IMAGE_MAGIC);
+}
+
 int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 		bool force_reloc)
 {
@@ -39,7 +46,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 
 	ih = (struct Image_header *)map_sysmem(image, 0);
 
-	if (ih->magic != le32_to_cpu(LINUX_ARM64_IMAGE_MAGIC)) {
+	if (!booti_is_valid(ih)) {
 		puts("Bad Linux ARM64 Image magic!\n");
 		return 1;
 	}
diff --git a/arch/riscv/lib/image.c b/arch/riscv/lib/image.c
index a82f48e9a50..859326cbac8 100644
--- a/arch/riscv/lib/image.c
+++ b/arch/riscv/lib/image.c
@@ -32,6 +32,13 @@ struct linux_image_h {
 	uint32_t	res4;		/* reserved */
 };
 
+bool booti_is_valid(const void *img)
+{
+	const struct linux_image_h *lhdr = img;
+
+	return lhdr->magic == LINUX_RISCV_IMAGE_MAGIC;
+}
+
 int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 		bool force_reloc)
 {
@@ -39,7 +46,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 
 	lhdr = (struct linux_image_h *)map_sysmem(image, 0);
 
-	if (lhdr->magic != LINUX_RISCV_IMAGE_MAGIC) {
+	if (!booti_is_valid(lhdr)) {
 		puts("Bad Linux RISCV Image magic!\n");
 		return -EINVAL;
 	}
diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
index 44ba8b52e13..8ed923750f4 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -89,3 +89,8 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 
 	return 1;
 }
+
+bool booti_is_valid(const void *img)
+{
+	return false;
+}
diff --git a/boot/image-board.c b/boot/image-board.c
index c681972109e..e096dc49eef 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -250,6 +250,9 @@ enum image_fmt_t genimg_get_format(const void *img_addr)
 	if (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE) &&
 	    is_android_boot_image_header(img_addr))
 		return IMAGE_FORMAT_ANDROID;
+	if (IS_ENABLED(CONFIG_CMD_BOOTI) &&
+	    booti_is_valid(img_addr))
+		return IMAGE_FORMAT_BOOTI;
 
 	return IMAGE_FORMAT_INVALID;
 }
@@ -420,6 +423,8 @@ static int select_ramdisk(struct bootm_headers *images, const char *select, u8 a
 			done = true;
 		}
 		break;
+	case IMAGE_FORMAT_BOOTI:
+		break;
 	case IMAGE_FORMAT_INVALID:
 		break;
 	}
diff --git a/include/image.h b/include/image.h
index e3fc4b83b1d..b2699ecff3d 100644
--- a/include/image.h
+++ b/include/image.h
@@ -602,6 +602,7 @@ enum image_fmt_t {
 	IMAGE_FORMAT_LEGACY,		/* legacy image_header based format */
 	IMAGE_FORMAT_FIT,		/* new, libfdt based format */
 	IMAGE_FORMAT_ANDROID,		/* Android boot image */
+	IMAGE_FORMAT_BOOTI,		/* Arm64/RISC-V boot image */
 };
 
 /**
@@ -648,6 +649,14 @@ enum image_fmt_t genimg_get_format(const void *img_addr);
 
 int genimg_has_config(struct bootm_headers *images);
 
+/**
+ * booti_is_valid() - Check if an image appears to be an Arm64 image
+ *
+ * @img: Pointer to image
+ * Return: true if the image has the Arm64 magic
+ */
+bool booti_is_valid(const void *img);
+
 /**
  * boot_get_fpga() - Locate the FPGA image
  *
-- 
2.34.1

