Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069EFE77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3145780752;
	Sat, 11 Jan 2025 01:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KG6Ppwm1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EEB180657; Sat, 11 Jan 2025 01:01:39 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D1980717
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844df397754so79629639f.2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553695; x=1737158495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99uYeI9uf1pRbVP7B5riPESim7hLJ3AZvaxNGre8ezM=;
 b=KG6Ppwm1tfeVkmipxXQFkHLN5s+05THeAuMy5uFuPs/hD4xd3bhDP35bDrbt7J2bn0
 pNq8LES82a2l7AIKoE/UBgE1TqWi16iH5hWlJ2VagXUNTW5jxIsjBb/bc9QPF9UmoMZi
 1AdU2lnjMLH2HgpUE+FpFnCJvDuLoVfdSuOBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553695; x=1737158495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99uYeI9uf1pRbVP7B5riPESim7hLJ3AZvaxNGre8ezM=;
 b=r4iAMLrYzagUlUYbSE3RWhLX/omLIusn+HFU+Fo4QKT9kelVMzNov0F1862fFS9fNq
 V7GyU+B9dI3lDKgSZOF+WXiVetBBihhm8FEE16huktMQQsUnCljAJHRRjUAotVK8IxGJ
 BRQZJgE0vRMYTjwqhYQ/IpAQSvbOw2TnyAQdhbvP6GKjmHRkwHvhmTPfa+ILfOLXIf7e
 SvxwqViKTOM/gxyFR75wtj8x7FeUWIO7XGMJXDPoXw1RKfSLdJGrxSFF3oX9LoMVV/f0
 4hTYb93jnjua2UwAKmZK+MkVH+RH2YCnymrwzV2wcRWsxRsL/pk7q6YBHL/4zKXqpNev
 Rl1A==
X-Gm-Message-State: AOJu0YzB2lnykyhHNz5hmoYaAS9xzRTkpi8dpSWPOI/UlnrQpGg3SIfK
 4TqT4lgjX78MWDOYUqYVlqGAXhT7RM4VQZ+Mcv7refpsiBTYbt5wlGa0sRpLIVl76GqUpqrVqZQ
 =
X-Gm-Gg: ASbGnctZGg6npoNS1rQ6zrv+BQuNqVIuRYGsOee/cIncy7tTOePKXdvThTDc7qX9CJZ
 OdkBLwQwEHD9s1CIjNRCyzokM4z5VaSwfDC9GgmyBqfQGwI8V83YfV6X/2A1vDo82HgJy//ZB1a
 oWUhkHCL19ZuO4BghuQDbuJimvcneRne28FJkpktOuOOfX7L6Sk/uTH6yzAMwvKXJ4u9IEzyqVG
 2q5EI6hMTI3qvI+Se7zA05zet/LRHCJCSBwX1SvdXIxj4rv8a2+Szo3y2Gr4kDNpusUpEqrvyCZ
 HWedZVK/0gVHWolvMQ==
X-Google-Smtp-Source: AGHT+IHDEjBU5vKsJkxKfIrOvmh0bzYNE8Ep7L3PMBC9Q2qUk4r5xQKOTi1Rn/9K5hc1Pgo/nwsL/w==
X-Received: by 2002:a05:6602:4899:b0:84a:5133:9cd8 with SMTP id
 ca18e2360f4ac-84ce0154689mr1022626739f.10.1736553695481; 
 Fri, 10 Jan 2025 16:01:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Heiko Schocher <hs@denx.de>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 20/30] pci: video: Set up the pixel-format field
Date: Fri, 10 Jan 2025 17:00:19 -0700
Message-Id: <20250111000029.245022-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

