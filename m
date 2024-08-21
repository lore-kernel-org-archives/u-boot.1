Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2432FC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:21:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6F6288E1E;
	Wed, 21 Aug 2024 18:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IzFFi/f8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C5188E20; Wed, 21 Aug 2024 18:19:47 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097C688E1B
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-26ff21d82e4so3643652fac.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257182; x=1724861982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YyY5JYjIB5ceFMr/xDwv4fIw4GEHyA6IKge5FER4Tc=;
 b=IzFFi/f8VtpJdR5ItIniPhgKrFwEIhYMTLe/w6fSr2IxlbKFEKDDpmPlyqpGHQixq5
 UiWow1XY1aFUpUtnG0K/kn64RkTTW8ovbGcyLP1Akz+0RNKV1suX96CvLOl6hv/BPWdo
 M1wPSLTEvuUo0kwh0BK0zFMLzozTuUBk2o0Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257182; x=1724861982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YyY5JYjIB5ceFMr/xDwv4fIw4GEHyA6IKge5FER4Tc=;
 b=eA3g+wVn12FCZL8Ff3YXSZW1wPAVVAEubsAmFqubyJpTzUtnqRmVvZGoaIS+dLOnhI
 L/HAbUO98+Q2D0+PtoiuDsnr6lXXTwDGwt9gg0HmrIZkfEwH6gLD61a1pKo1VhKbITJM
 oAWoLU+uBcCBovFGvhPCdsMJE+WfSYTbGmJRNwzGHYuAiTXsE4tz4Us6CO0ENUtxWUmi
 WGISVrFyKM5YoEssl2UUftHRJafRP+tDG0HThlHNoavKkxpb+Kedk5yXK4NCBAR9Idr6
 ZdNJczJ/cF8hu2u4zXkJvN2cCO8YSFM1w7k83Hyyh/ImnnjOD2ZUpZ6g6K54eh1OTNd0
 BTRg==
X-Gm-Message-State: AOJu0YzeyXMUT3Hs4Y8Q3BmuZXzbFGx0vwfYMiAxDm1HXcEkUEiJJA9r
 PkeNnxeLZwbzCb5eUJIvDfAuZpO08blbvQcMt4H99lv22hZCFUT/ZxLXNmInTw1FkexTG/5dOFE
 =
X-Google-Smtp-Source: AGHT+IEUAupLSgKmimlNzYQIgCEUhvARzjMVNAL8kO1dH4akS0OSqNUl8l2Lh3RkMQDICyliOS6u1A==
X-Received: by 2002:a05:6871:5223:b0:270:1498:6a36 with SMTP id
 586e51a60fabf-2737ef54d6dmr3221457fac.29.1724257182578; 
 Wed, 21 Aug 2024 09:19:42 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 08/35] zynqmp: Avoid setting the framebuffer address
Date: Wed, 21 Aug 2024 10:19:00 -0600
Message-Id: <20240821161927.695717-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

This is handled by driver model so this driver should not be setting the
framebuffer address. Drop the assignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/zynqmp/zynqmp_dpsub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/zynqmp/zynqmp_dpsub.c b/drivers/video/zynqmp/zynqmp_dpsub.c
index 1405b29cb8b..76abfeac443 100644
--- a/drivers/video/zynqmp/zynqmp_dpsub.c
+++ b/drivers/video/zynqmp/zynqmp_dpsub.c
@@ -49,7 +49,7 @@ static void dma_init_video_descriptor(struct udevice *dev)
 			     DPDMA_DESCRIPTOR_ADDR_EXT_SRC_ADDR_EXT_SHIFT) |
 			     (upper_32_bits((u64)&cur_desc)));
 	cur_desc.next_desr = lower_32_bits((u64)&cur_desc);
-	cur_desc.src_addr = lower_32_bits((u64)gd->fb_base);
+	cur_desc.src_addr = lower_32_bits((u64)video_get_fb());
 }
 
 static void dma_set_descriptor_address(struct udevice *dev)
@@ -2134,7 +2134,6 @@ static int zynqmp_dpsub_probe(struct udevice *dev)
 	dev_dbg(dev, "BPP in bits %d, bpix %d\n",
 		priv->non_live_graphics->bpp, uc_priv->bpix);
 
-	uc_priv->fb = (void *)gd->fb_base;
 	uc_priv->xsize = vidc_video_timing_modes[priv->video_mode].video_timing.h_active;
 	uc_priv->ysize = vidc_video_timing_modes[priv->video_mode].video_timing.v_active;
 	/* Calculated by core but need it for my own setup */
-- 
2.34.1

