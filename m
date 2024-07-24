Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48957C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC5F889B8;
	Wed, 24 Jul 2024 17:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oVT2gqUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A240688962; Wed, 24 Jul 2024 17:09:46 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9169E88981
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-36da84df7adso3414625ab.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833783; x=1722438583; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9iTUCgCZQC38prs7P9iyeH8/iS/G6FkjiH0x9lkh0Wg=;
 b=oVT2gqUcvlWS85vZ9VB2ROkPO8fL7PAnyP3NDcmAYCp7E21il9KD4gl+y11bZ0LVXI
 T95k+yWRMN6gVPdYZ/a+zPW8xLglopBZ0KtahxYyq8gi4tFHPVq5Uh0y6RaEYnME9uVr
 Tvy5LAhtpfas7YHeHrN4N5AMxLiXxGJdo+UeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833783; x=1722438583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9iTUCgCZQC38prs7P9iyeH8/iS/G6FkjiH0x9lkh0Wg=;
 b=QQZYrKa7AeQaRit7eofTqYsMAVuQhtD1sXRNya73CMMqAv0DywR7rAlJxIevhzeTmr
 rKoXiesfEBIAxVZdHDM20lPvch+cjyeGUXr/yZzVgyISLv9MPLE3PjIzby6IeXfoSXBJ
 2ssJXL2z9TSaYjH8UL2aqgCZnQ+bZCr36FpqAijQiubZ2YGRPrELbrvYPbVWu6RzLr1i
 9kepaPjEKRdaOaGKFK8MBDfHuEjEZxvH1KvQf/IG6BLSY58secXjdogssWMNRXorSZmy
 rZd0EQNuyOPonxHZo2S008Af4XayUfsELh0I6H5QAUMqcigruCynnDbmhOXsWMAIPjCK
 QoPw==
X-Gm-Message-State: AOJu0YyshCWt0wSgPikly+NnvVwerpZOm3Qzpy1W7SdBDyFdgsJ8u7KB
 fmfajfSoz/UX0V5HA0utYhtHzpnwxMXpTqY6AAzErs6vVc/F9VG5yr4N7zi4tbTqlHeJHlVt0fo
 =
X-Google-Smtp-Source: AGHT+IFdtiLQGMgLrgRrvCDFWyLmy0JwG78aXFeQyZAErZB/QPymWEpT76rgZCLKrjouSGox3SpUrw==
X-Received: by 2002:a92:c569:0:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-39a1a775175mr14008865ab.1.1721833783326; 
 Wed, 24 Jul 2024 08:09:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>, Michal Simek <michal.simek@amd.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 08/35] zynqmp: Avoid setting the framebuffer address
Date: Wed, 24 Jul 2024 09:08:55 -0600
Message-Id: <20240724150922.2343249-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

