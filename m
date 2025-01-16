Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBF5C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF9C380755;
	Thu, 16 Jan 2025 02:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b0RnSftW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB54380755; Thu, 16 Jan 2025 02:27:43 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E2B9806FE
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-844ce6d0716so31960639f.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990859; x=1737595659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BR/Q39EWIgBirys5pYLgMSJCEDjegCCTBSJF0w2R/I=;
 b=b0RnSftWP5rq2BO8K1nxDftK0Jh8akhoxjp6udXG5HDKp5mTZqDDCgPDvgUZvm80s6
 R4C/vKr/yVd0YHpIx3t9nqCgKXSshb7ckE84DcWxCE0azijaZEOGxDi4zmieGB3YyEEl
 asEPVeJrdSqxnLJU92bBmVRj40fPDkTQPUqeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990860; x=1737595660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1BR/Q39EWIgBirys5pYLgMSJCEDjegCCTBSJF0w2R/I=;
 b=EK2yJ5Ktx6ZkkB5W36B7zl5o+M9BO/bBlT3HxLP7e521F6DhaiS/DpQNOZ/lmjGx/G
 Dg0/7kArjzRws4eSpESMWvJa1wRom7Rh+utLPe9tNfz3QGF0OICa3EsBIsjaizQJ6F8a
 02JZkObLfxVlgtY86hw88Da1DZESUSFE3T2egMmaHzXTIdnI7tRRDwsfyJaLrr60LcDd
 hJCpbzteSxST5RTap5iNv3q3jEmPyZgybHs0zUj/fS2P0Rza4p/S4QFpbT0FBc2i16W4
 LxOPdoIvgLLjR8AH90s7XmfmimHpc6p9ccEi79oEecLW+bRvYYm49MUqM0xRAJrZ6J9D
 U2qg==
X-Gm-Message-State: AOJu0YyjjpFf40v0PK3in5hf6oNxpiR3bn7i/CKa0gI/qY6SQu8cA1yh
 c3FZeohqw+eplvZE8rcRO33SJDJReJDOMoX3vxlX/f8O8derICX2LElT+OKrq39H4ntnlKau3lk
 =
X-Gm-Gg: ASbGncv864/PcsbeV7pyj/NxUk8xtqXWDfDILcWUdSvNCTmQVJvW0/KNGK7+rDixzxT
 tj5/bUW8nHspCeib9LBo627brWXY4VkxlyWJpizT2W+EIm1guvONam8Uvty9qH5lU68zw+VY+OY
 8vafW0xP+ido8Hru5xPZFzWCD0AmMhYxaiwcIYdRFGLwOihk1ofyvVKoerMmNoDkF0LrUAJIZMs
 nm9BstTbzDpDurVIvbXRppt2STvqlAtVNGzE1XgsErOx/W6ydbezqtXUmRe2UFgRzNooNksE0Tk
 ZNEHvxeK5PC21JiGiw==
X-Google-Smtp-Source: AGHT+IGz6N80XvaMN9H+UyPlawM+PyYEdZQ0PMbJvCqurPmfQTXmSadtIx89kBtFZmYx+iJAeDAYzg==
X-Received: by 2002:a05:6e02:9b:b0:3ce:78ab:dcd1 with SMTP id
 e9e14a558f8ab-3ce78abdeb1mr111501615ab.19.1736990859631; 
 Wed, 15 Jan 2025 17:27:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:27:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 02/22] vbe: Start a common header file
Date: Wed, 15 Jan 2025 18:27:03 -0700
Message-Id: <20250116012723.2820301-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
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

Move a few things into a new, common header file so that vbe-simple can
share code with the upcoming abrec.

Put struct simple_nvdata in it and rename it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split patch into several pieces

 boot/vbe_common.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 boot/vbe_simple.c | 13 ++----------
 boot/vbe_simple.h | 16 ++-------------
 3 files changed, 55 insertions(+), 25 deletions(-)
 create mode 100644 boot/vbe_common.h

diff --git a/boot/vbe_common.h b/boot/vbe_common.h
new file mode 100644
index 00000000000..1fc70ee74c8
--- /dev/null
+++ b/boot/vbe_common.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Verified Boot for Embedded (VBE) common functions
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#ifndef __VBE_COMMON_H
+#define __VBE_COMMON_H
+
+#include <linux/types.h>
+
+struct udevice;
+
+enum {
+	MAX_VERSION_LEN		= 256,
+
+	NVD_HDR_VER_SHIFT	= 0,
+	NVD_HDR_VER_MASK	= 0xf,
+	NVD_HDR_SIZE_SHIFT	= 4,
+	NVD_HDR_SIZE_MASK	= 0xf << NVD_HDR_SIZE_SHIFT,
+
+	/* Firmware key-version is in the top 16 bits of fw_ver */
+	FWVER_KEY_SHIFT		= 16,
+	FWVER_FW_MASK		= 0xffff,
+
+	NVD_HDR_VER_CUR		= 1,	/* current version */
+};
+
+/**
+ * struct vbe_nvdata - basic storage format for non-volatile data
+ *
+ * This is used for all VBE methods
+ *
+ * @crc8: crc8 for the entire record except @crc8 field itself
+ * @hdr: header size and version (NVD_HDR_...)
+ * @spare1: unused, must be 0
+ * @fw_vernum: version and key version (FWVER_...)
+ * @flags: Flags controlling operation (enum vbe_flags)
+ */
+struct vbe_nvdata {
+	u8 crc8;
+	u8 hdr;
+	u16 spare1;
+	u32 fw_vernum;
+	u32 flags;
+	u8 spare2[0x34];
+};
+
+#endif /* __VBE_ABREC_H */
diff --git a/boot/vbe_simple.c b/boot/vbe_simple.c
index f260e9b731d..b175c5d3a59 100644
--- a/boot/vbe_simple.c
+++ b/boot/vbe_simple.c
@@ -21,15 +21,6 @@
 #include <u-boot/crc.h>
 #include "vbe_simple.h"
 
-/** struct simple_nvdata - storage format for non-volatile data */
-struct simple_nvdata {
-	u8 crc8;
-	u8 hdr;
-	u16 spare1;
-	u32 fw_vernum;
-	u8 spare2[0x38];
-};
-
 static int simple_read_version(struct udevice *dev, struct blk_desc *desc,
 			       u8 *buf, struct simple_state *state)
 {
@@ -57,7 +48,7 @@ static int simple_read_nvdata(struct udevice *dev, struct blk_desc *desc,
 {
 	struct simple_priv *priv = dev_get_priv(dev);
 	uint hdr_ver, hdr_size, size, crc;
-	const struct simple_nvdata *nvd;
+	const struct vbe_nvdata *nvd;
 	int start;
 
 	if (priv->state_size > MMC_MAX_BLOCK_LEN)
@@ -70,7 +61,7 @@ static int simple_read_nvdata(struct udevice *dev, struct blk_desc *desc,
 
 	if (blk_read(desc->bdev, start, 1, buf) != 1)
 		return log_msg_ret("read", -EIO);
-	nvd = (struct simple_nvdata *)buf;
+	nvd = (struct vbe_nvdata *)buf;
 	hdr_ver = (nvd->hdr & NVD_HDR_VER_MASK) >> NVD_HDR_VER_SHIFT;
 	hdr_size = (nvd->hdr & NVD_HDR_SIZE_MASK) >> NVD_HDR_SIZE_SHIFT;
 	if (hdr_ver != NVD_HDR_VER_CUR)
diff --git a/boot/vbe_simple.h b/boot/vbe_simple.h
index 56d319206f2..dc3f70052b0 100644
--- a/boot/vbe_simple.h
+++ b/boot/vbe_simple.h
@@ -9,20 +9,8 @@
 #ifndef __VBE_SIMPLE_H
 #define __VBE_SIMPLE_H
 
-enum {
-	MAX_VERSION_LEN		= 256,
-
-	NVD_HDR_VER_SHIFT	= 0,
-	NVD_HDR_VER_MASK	= 0xf,
-	NVD_HDR_SIZE_SHIFT	= 4,
-	NVD_HDR_SIZE_MASK	= 0xf << NVD_HDR_SIZE_SHIFT,
-
-	/* Firmware key-version is in the top 16 bits of fw_ver */
-	FWVER_KEY_SHIFT		= 16,
-	FWVER_FW_MASK		= 0xffff,
-
-	NVD_HDR_VER_CUR		= 1,	/* current version */
-};
+#include <linux/types.h>
+#include "vbe_common.h"
 
 /** struct simple_priv - information read from the device tree */
 struct simple_priv {
-- 
2.34.1

