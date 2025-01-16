Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A42C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51DBA80703;
	Thu, 16 Jan 2025 02:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SVyo2FzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE16806D8; Thu, 16 Jan 2025 02:27:47 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31E380703
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844ee166150so14178639f.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990862; x=1737595662; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tf8v+Llq0+U6nR459HKy7dt1kXEvv0+YDvGUYk/mUu0=;
 b=SVyo2FzNgK4KSjP1NnEiC8AYzgZlYI3W4zZ/GRzt0hdDGdS8smzlLW+bJJM/E4bc5L
 P9aPoR/BXJvpRgj4quhZJ5EaxoxL43qxcnYyZcvJMYZnp6i8LXeXd1FHYTEerKINtKLa
 coXLrv4fLthQxozluxsdFKpM19Tn0VUKjN7C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990862; x=1737595662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tf8v+Llq0+U6nR459HKy7dt1kXEvv0+YDvGUYk/mUu0=;
 b=wGgJyWR4P9dghIMnCS3zjK82/3+Jz+3QCTn3sQbV5rck/5l8Ya1c0fFywG51cD1P2w
 E+ePcAc4KmU1848E40mZBgqb+epdGgHLeKxCFwzcw5CNeMXMiCZHxdc+umaFj1qqV/69
 Vv1jInRZROUbbef2ErGwRh4j4GMWGxa7WuYU1GsHj46V6rFVW3sIBBUBPbxn40WqXGF/
 GCjXNJXySM1Z9dgNen6YGpT/3c0K6kbu0zoLn335bG7xitPuqNU48eaoOvGH506qfIKs
 2cbi5YT85PTw/TuAmkQtCkcRE5bsjJWcvSXTFWyg42HBy8U1F63geh6+GDqGvwEayyKp
 2kJQ==
X-Gm-Message-State: AOJu0YySvFnRqf49AYZQD1/woeGc7EzWaZA71e4wGQNQTRyU2pcMv/Np
 YiMZJ+Bgpnctx674m2U3PdoFpa4kViT/0eMGJlvVFdSp4GI3iGIlyej9t1Ty5/gxMAZVZ/Y08vU
 =
X-Gm-Gg: ASbGnctZbCneH+mZEFa9bAos1bDZtpBcxmWe/SL/0MpH4Uls2/Q3Q0gIVOfa8OytWQF
 UbuNHWYeBwh6RRhZh20AaMX8xclc/CB6MKjS+mLylNaJKxLaj9ZHuMlEX3YMa/fMAArXAvW+RSm
 hc3Ti1Bk8MM8a3wVAeVmPOAu7lzOutWj41va58TVYkBE1NX5kHCxgnMkRyxXRpm5TQRmjwOe91J
 yznomA0m7Xhx7VwbvbrVqFZkDU/brZ2CPMXg802JqkpujhwvVsP+6JC3Y0dCBu/n9DA6ERjhN4s
 /ZdlPL7tDqganroL9g==
X-Google-Smtp-Source: AGHT+IFq4aWeDvextK780/mysqVWRO/5DAj4lB30mQUmMYbbKPArfI6nPC9tzLdr8XMG7PTdjnwjjQ==
X-Received: by 2002:a05:6e02:1a2b:b0:3ce:78e5:d370 with SMTP id
 e9e14a558f8ab-3ce78e5d557mr94937415ab.12.1736990862545; 
 Wed, 15 Jan 2025 17:27:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:27:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 03/22] vbe: Use a block device instead of descriptor
Date: Wed, 15 Jan 2025 18:27:04 -0700
Message-Id: <20250116012723.2820301-4-sjg@chromium.org>
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

Pass a struct udevice instead of the descriptor structure, since this is
the native argument for blk_read()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split patch into several pieces

 boot/vbe_simple.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/boot/vbe_simple.c b/boot/vbe_simple.c
index b175c5d3a59..fb971cc0632 100644
--- a/boot/vbe_simple.c
+++ b/boot/vbe_simple.c
@@ -21,7 +21,7 @@
 #include <u-boot/crc.h>
 #include "vbe_simple.h"
 
-static int simple_read_version(struct udevice *dev, struct blk_desc *desc,
+static int simple_read_version(struct udevice *dev, struct udevice *blk,
 			       u8 *buf, struct simple_state *state)
 {
 	struct simple_priv *priv = dev_get_priv(dev);
@@ -35,7 +35,7 @@ static int simple_read_version(struct udevice *dev, struct blk_desc *desc,
 		return log_msg_ret("get", -EBADF);
 	start /= MMC_MAX_BLOCK_LEN;
 
-	if (blk_read(desc->bdev, start, 1, buf) != 1)
+	if (blk_read(blk, start, 1, buf) != 1)
 		return log_msg_ret("read", -EIO);
 	strlcpy(state->fw_version, buf, MAX_VERSION_LEN);
 	log_debug("version=%s\n", state->fw_version);
@@ -43,7 +43,7 @@ static int simple_read_version(struct udevice *dev, struct blk_desc *desc,
 	return 0;
 }
 
-static int simple_read_nvdata(struct udevice *dev, struct blk_desc *desc,
+static int simple_read_nvdata(struct udevice *dev, struct udevice *blk,
 			      u8 *buf, struct simple_state *state)
 {
 	struct simple_priv *priv = dev_get_priv(dev);
@@ -59,7 +59,7 @@ static int simple_read_nvdata(struct udevice *dev, struct blk_desc *desc,
 		return log_msg_ret("get", -EBADF);
 	start /= MMC_MAX_BLOCK_LEN;
 
-	if (blk_read(desc->bdev, start, 1, buf) != 1)
+	if (blk_read(blk, start, 1, buf) != 1)
 		return log_msg_ret("read", -EIO);
 	nvd = (struct vbe_nvdata *)buf;
 	hdr_ver = (nvd->hdr & NVD_HDR_VER_MASK) >> NVD_HDR_VER_SHIFT;
@@ -85,6 +85,7 @@ int vbe_simple_read_state(struct udevice *dev, struct simple_state *state)
 	ALLOC_CACHE_ALIGN_BUFFER(u8, buf, MMC_MAX_BLOCK_LEN);
 	struct simple_priv *priv = dev_get_priv(dev);
 	struct blk_desc *desc;
+	struct udevice *blk;
 	char devname[16];
 	const char *end;
 	int devnum;
@@ -104,11 +105,12 @@ int vbe_simple_read_state(struct udevice *dev, struct simple_state *state)
 	if (!desc)
 		return log_msg_ret("get", -ENXIO);
 
-	ret = simple_read_version(dev, desc, buf, state);
+	blk = desc->bdev;
+	ret = simple_read_version(dev, blk, buf, state);
 	if (ret)
 		return log_msg_ret("ver", ret);
 
-	ret = simple_read_nvdata(dev, desc, buf, state);
+	ret = simple_read_nvdata(dev, blk, buf, state);
 	if (ret)
 		return log_msg_ret("nvd", ret);
 
-- 
2.34.1

