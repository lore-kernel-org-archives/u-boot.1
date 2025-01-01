Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD044E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82A680634;
	Wed,  1 Jan 2025 23:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OqY/+Tn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A9080352; Wed,  1 Jan 2025 23:13:26 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EBBB8069A
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21683192bf9so146013665ad.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769601; x=1736374401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NGWGv/wVO7y8mpYpfLkGoTB9zoye+I67omqyyrRHZA=;
 b=OqY/+Tn1h2O5k+Yz6CNFwMqPIisnjbHioDSznQh3LV+sO1GBRyfXsSYAygCmR8UyrY
 pKt+QL2SqnLrEi9uuysbSvwkw/WNjSgrfj3ZIFlkGZ7i6Uyuh+Ogm4ZQjoIW+RwwbpfB
 aAktFRidChjKixtvO0fme/Z1l5SAXE9HIahfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769601; x=1736374401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5NGWGv/wVO7y8mpYpfLkGoTB9zoye+I67omqyyrRHZA=;
 b=kzChmFyJwi3Rpq3Uau3xDuge5q32BcFeAHI/UPmZ2NY+KGTJj5GIcTWXRJINa4hvmN
 cdm/mM6nc+84IKDrDwWnkewqiz9K8QRrS3Iymnt6MieGIrBscLLDnUfKuTYlpmdajpSg
 kk/mBkLE2EVN/sDa893nqOJ7ktNkcYoBTSn2AHUa5mAK+Okn/ZK2sLJG9UkUaPH+CcL2
 jrSxp81p518RQyfdIoZY+1oFVyBfhiV612JEYJmKicu2wgd4tPO+mcDlQr0eiO1+jW/k
 8cyvg0AlpfnpYExPknMCgPqT67qZ3casFgfplylB/08FJcHXxQgFtGMIugVEmFZ0qOSh
 yGHg==
X-Gm-Message-State: AOJu0Yx6qmuwt14/3iKBLHYTNoXlpsVAUc8QC3bQgkG5G8fToDA7lcAE
 tjsAdb1Vl4Nlf4xPCD7q7uE+oj2kgSleUetIyjKhR2YjYdiYgbDvUr/xS6dHTkWuc4D3fHfuD98
 =
X-Gm-Gg: ASbGncsC2LXxyK+veime38DXG/pgxZAbBJDUhx3nInDofQKQH5ZdMxQN/RF4xGnnWTy
 yLOS6m2npdPCptfoE7DGp2vWhE7Adc6UvE2PcQ6iIYZAm2Lm/azAOkYtKUYgdEhZ85mErvCuxLk
 LZE1Xb0q1jpFTdhYTSm9vVmoiZYmNz8Lwz/6OjZG+DKvf4CIANmVyBuAKKohxVbQGXde4h2NP8r
 78Xv1Yx6d0FWAss0gufdKKAJUsFZOzb4GmEGIHUn+puO2CSyzYsVpU=
X-Google-Smtp-Source: AGHT+IFE/ZvUf9WBRqSn5MMqMUA/fJF0EUU7sX67BAYbcBMvmp4TLjUIJz92EkTuiM2RDE8pFH8sOQ==
X-Received: by 2002:a05:6a00:3cc1:b0:725:df1a:288 with SMTP id
 d2e1a72fcca58-72abe18acb0mr57357925b3a.24.1735769601597; 
 Wed, 01 Jan 2025 14:13:21 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:13:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Heiko Schocher <hs@denx.de>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 29/67] pci: video: Set up the pixel-format field
Date: Thu,  2 Jan 2025 11:09:15 +1300
Message-ID: <20250101221003.1944600-30-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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
2.43.0

