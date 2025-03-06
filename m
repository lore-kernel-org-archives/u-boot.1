Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31ECC19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 102D281671;
	Thu,  6 Mar 2025 01:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QmXPdysy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5385081671; Thu,  6 Mar 2025 01:27:11 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 517B580805
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85af81a1febso3710739f.3
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220825; x=1741825625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZ2Vz6+/oxh/L1LcuMimI90hD3JALhekdpQIIYvHDU0=;
 b=QmXPdysyZsG5vQddBoEdO1HfHcuGdFcz1iSvIY6k0kER89zU4sufI2TGfdLnzegxVA
 THLpUYN+/iTY354JRbUfEO0+YMd0FdqNH4IXFTDaDKOeuaN85vHwB3nkEFmozOj+MDoI
 yNxx18pD6fG3fTMBvvJpNJfDFbC7DN3yP6PEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220825; x=1741825625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZ2Vz6+/oxh/L1LcuMimI90hD3JALhekdpQIIYvHDU0=;
 b=QVEHWCCr6L5is17VRLILEQHxuiANSLIP5f5NnKNeoE1iISEMFs+K598H+6iCLlHQBM
 JcsMnFJYuyWkeDxnbDsX2VgiZMeEtkyfqz31PYTsdboQSjB6OV8dr1BrQVHag8hx1cNe
 pcgdHDMCYwRZj3Vm4n5QyKDDcEEWh9FUJ2Sw/AiwpowCgHElAuvQAY/hdsaW5a0dUvTP
 3vZaRWUQqzetqW6LyGvtYdFHPiX+VgWzD6Ux4gRzJZh/2axNBhJoWFAT5C7fDiAYe5eV
 fN9CfFnIU+zAQF749akxa/8CoXbnx0Uws9fIpoF7+dD7apMkbJzCWxI8csK2/WOeW/sp
 Bykg==
X-Gm-Message-State: AOJu0Yxkyyf72A7hFhtlXh4Opmc3ZmcnduKL9UXPSNBJUkg+wPNxopuh
 v4vyvgjaRO88ycyckXeCw7u6x8xIWWN2yE6EXT21nYCTqGXf2/Uil4gvKxbsyp6uXJnynF7lWdg
 =
X-Gm-Gg: ASbGncua+MGxW40UhadLE/Zt3dApYuuhqzdBv+9o/xURMrAtI3F4B2NmONl9YWOz2+X
 bC1ygKJ+nw06F4/KMpYgKnqKfiSOG2lxDmQSRQPC7ktGIiqZsdU9GW1QySeeSJXWGL28wdw67My
 BTGSie0/Lsq4rz7UwjK2r0izqCLOPsSKroX8pe+XjBgUcdsqB702fwwQGMnKsxXvWXfKGcmDo1T
 mCJW/Azq9VWGFDCxJCD9bBqnOl38yADQ2sAsEqFt5kHuS0XtXtNaNrTDGPYhFJxEANKn7JtxylO
 MP04OqYHvM2ZqSaL/M8hhT19sS8BDSPa3Hs73XVklMtOp+CRj8IBx2o2KpsLIML5J0NcBcGQRzh
 25m2wUQ==
X-Google-Smtp-Source: AGHT+IEVUfkFyGoJfzba2SxmbyimJTKM1ycFl8rJazwbHp5wG27O/maG0BUe+wPhF7jY1uSvWuPlAw==
X-Received: by 2002:a05:6602:728e:b0:85a:fcac:2f57 with SMTP id
 ca18e2360f4ac-85aff9d24demr878180339f.4.1741220825437; 
 Wed, 05 Mar 2025 16:27:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>, Rick Chen <rick@andestech.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v5 15/29] boot: arm: riscv: sandbox: Add a format for the
 booti file
Date: Wed,  5 Mar 2025 17:25:09 -0700
Message-ID: <20250306002533.2380866-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

(no changes since v3)

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
index addccf87c80..07931c64198 100644
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
index dc1a7c307cc..f8f2c887a4b 100644
--- a/include/image.h
+++ b/include/image.h
@@ -603,6 +603,7 @@ enum image_fmt_t {
 	IMAGE_FORMAT_LEGACY,		/* legacy image_header based format */
 	IMAGE_FORMAT_FIT,		/* new, libfdt based format */
 	IMAGE_FORMAT_ANDROID,		/* Android boot image */
+	IMAGE_FORMAT_BOOTI,		/* Arm64/RISC-V boot image */
 };
 
 /**
@@ -649,6 +650,14 @@ enum image_fmt_t genimg_get_format(const void *img_addr);
 
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
2.43.0

