Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BD4E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9238A805E1;
	Mon,  6 Jan 2025 15:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F3eeXkd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C67F0805F0; Mon,  6 Jan 2025 15:33:52 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13A9B80702
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a817ee9936so56072405ab.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174027; x=1736778827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99uYeI9uf1pRbVP7B5riPESim7hLJ3AZvaxNGre8ezM=;
 b=F3eeXkd+bO2C+YJ50ZorjIxsY7vl4p2pNkgUhZb3+91lOwrFKlH3CNpMkO4P9huX/A
 GdOSkY9RNH5rUF9DK5PbkRXdo4b6wdUUTrDRME9FXtsAx2mFX7gusjiJfCZnlqtQiF4C
 B02v7Peyeny3DOAwbh2UPKvYMltqpqKWqZOTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174027; x=1736778827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99uYeI9uf1pRbVP7B5riPESim7hLJ3AZvaxNGre8ezM=;
 b=GVQe2ciEF6+gK836IigWRrxHaGBHzUrEkPNT80hy1FfcxG3myehHgQMMi9QWqDiESy
 BjWIJaFwpn+TTmdliodGHmsItxO1D3HlI2GKfCQoRbnJstSZaYhZPASW2iyUkdzq6aJX
 dnuaURLs+zKbp1zMazNNu1fe6cGI7+4T2Yi7DH0Yhwys9Z7f2yGRTDnGR7qTHVf7CqiL
 Yi6WzRh+KM4A1dyKP/aWGOJ1kmbctsPFrWDN4W+NIl73ubPQ1xRVP4HQ5hWUTPoQXlx7
 HmWAoaQ4Nx3vufejRcPaLJbRP1H51dxpjYfbdQiXUsdUD5H9k0JbjyUSkleVpFcxp5F7
 R8mg==
X-Gm-Message-State: AOJu0YwO/3RgCUtcTj+fAlT8S+gFQHxkOCZC5Bb/m3IlZh8tvEBJ2qQX
 moTWCjYKCgRdkHzEVTOj3+RkQ8+AqeTD/yquAosPl7ZmTqUxGAF7C3i1zvo3KXXiC2S+qi2wo8w
 =
X-Gm-Gg: ASbGncsiOvfoKAiA+zjOcG5wrSseqyn0xvtYnxSrMV2J3j7+n4n4Bo5/IsAEnFvhBFY
 C1vQ0B4FJd2od+6mEOnXF3MU1OkKAu0vx9P28yIO6KbjYppslq7pNxTNAYHrnAzQ/FjUmA6g3p8
 QNLmGJcnG0pZuroiMqqDFBojUPt3ty5uFuWhYTmRI3uAaKw+7krkQ+ZtPVX91OXZe//f2ZQql3v
 Yfs2lp5AtnCUtIkxMQ3XHAp+4evwGiQMLfKFMM09YumSffp6yiPPZCv+ZD7rtNtEfdJex87Ztxy
 7q5zBQOX7OxeZyBU1A==
X-Google-Smtp-Source: AGHT+IEWOS0rHvnyeO45uXjjiNVr84pss2SBdKprtFYgbCUDVxt63Lz2SQTm7y0WpEx0pSCy8jF5Kg==
X-Received: by 2002:a05:6e02:219c:b0:3ab:4bea:df97 with SMTP id
 e9e14a558f8ab-3c2d591a3b4mr556369805ab.23.1736174027004; 
 Mon, 06 Jan 2025 06:33:47 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Heiko Schocher <hs@denx.de>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 24/33] pci: video: Set up the pixel-format field
Date: Mon,  6 Jan 2025 07:32:20 -0700
Message-Id: <20250106143229.3023771-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

Add this information to the handoff structure so that it is available to
U-Boot proper. Update bochs and the video handoff.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/pci/pci_rom.c        | 3 +++
 drivers/video/bochs.c        | 1 +
 drivers/video/video-uclass.c | 1 +
 include/video.h              | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/drivers/pci/pci_rom.c b/drivers/pci/pci_rom.c
index 2753df275ca..3697ad00be2 100644
--- a/drivers/pci/pci_rom.c
+++ b/drivers/pci/pci_rom.c
@@ -347,6 +347,7 @@ int vesa_setup_video_priv(struct vesa_mode_info *vesa, u64 fb,
 	case 32:
 	case 24:
 		uc_priv->bpix = VIDEO_BPP32;
+		uc_priv->format = VIDEO_X8B8G8R8;
 		break;
 	case 16:
 		uc_priv->bpix = VIDEO_BPP16;
@@ -392,6 +393,7 @@ int vesa_setup_video(struct udevice *dev, int (*int15_handler)(void))
 		uc_priv->ysize = ho->ysize;
 		uc_priv->line_length = ho->line_length;
 		uc_priv->bpix = ho->bpix;
+		uc_priv->format = ho->format;
 	} else {
 		bootstage_start(BOOTSTAGE_ID_ACCUM_LCD, "vesa display");
 		ret = dm_pci_run_vga_bios(dev, int15_handler,
@@ -438,6 +440,7 @@ int vesa_setup_video(struct udevice *dev, int (*int15_handler)(void))
 		ho->ysize = uc_priv->ysize;
 		ho->line_length = uc_priv->line_length;
 		ho->bpix = uc_priv->bpix;
+		ho->format = uc_priv->format;
 	}
 
 	return 0;
diff --git a/drivers/video/bochs.c b/drivers/video/bochs.c
index 00e673a4db0..c34bc23f274 100644
--- a/drivers/video/bochs.c
+++ b/drivers/video/bochs.c
@@ -64,6 +64,7 @@ static int bochs_init_fb(struct udevice *dev)
 	uc_priv->xsize = xsize;
 	uc_priv->ysize = ysize;
 	uc_priv->bpix = VIDEO_BPP32;
+	uc_priv->format = VIDEO_X8B8G8R8;
 
 	/* setup video mode */
 	bochs_write(mmio, INDEX_ENABLE,  0);
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 407fb9fbe20..1e385f12f8e 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -616,6 +616,7 @@ static int video_post_probe(struct udevice *dev)
 		ho->ysize = priv->ysize;
 		ho->line_length = priv->line_length;
 		ho->bpix = priv->bpix;
+		ho->format = priv->format;
 	}
 
 	if (IS_ENABLED(CONFIG_VIDEO_COPY) && plat->copy_base)
diff --git a/include/video.h b/include/video.h
index 0d7b0d27e25..2fe2f73a865 100644
--- a/include/video.h
+++ b/include/video.h
@@ -161,6 +161,7 @@ struct video_ops {
  *		set by the driver, but if not, the uclass will set it after
  *		probing
  * @bpix:	Encoded bits per pixel (enum video_log2_bpp)
+ * @format:	Video format (enum video_format)
  */
 struct video_handoff {
 	u64 fb;
@@ -169,6 +170,7 @@ struct video_handoff {
 	u16 ysize;
 	u32 line_length;
 	u8 bpix;
+	u8 format;
 };
 
 /** enum colour_idx - the 16 colors supported by consoles */
-- 
2.34.1

