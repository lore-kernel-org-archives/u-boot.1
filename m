Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC76C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB35D8897F;
	Wed, 24 Jul 2024 17:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ijq/BQdn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 829108896F; Wed, 24 Jul 2024 17:09:43 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 758438889B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-389ccd2f0abso27269165ab.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833780; x=1722438580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kH3upmxm7qhnWVPofNoP2IqZuFHxjStg1kGfNSvJbHQ=;
 b=Ijq/BQdnBCN+flCjyKdhx5sXKbLAfS169lb2/7fEqiClc5KR6+wvQI0pCRPTK0E18g
 iM323aUzdEEgI8cT+IWJX0qyslDAC2vIvwfODxd6m3z81ZaOMn8w+B9GvZ9HmmjgdzjB
 X9DsS5y7xXPm1CSlRvVDrsx7VFb+KNGtYUoaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833780; x=1722438580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kH3upmxm7qhnWVPofNoP2IqZuFHxjStg1kGfNSvJbHQ=;
 b=Lyz6X5VGcIbrj6iS0sJR+0QDIZGc12UnkLzH/E5tU20Ev1A3PO2HXkCTuqyghz2LPF
 2LDbgxwBpDHv8kMrnazFTtBj/Vf3j0NgiYb7rDMgxar0pqDuPMEOiGJNyhQL4/C9KG2w
 mvgChHNEg1VQEkDIybsatX7WJz58fYyo6K+aA7Xf0Dffge1Qzi3p4+Fp5pscygIaMr65
 AcknBW4vScDBUuC363WHRLxjxq5VlFyMXWzMgPXU5dAUouMO1QU/grSVTuf5I0QJxok5
 DT0VACkmSVsKCKlnc2M0PAiK83s4phLd3cuvylhcsPfNV4PaC6TIGceafe01tJPHG4YK
 jolw==
X-Gm-Message-State: AOJu0Yxl+V5TQgnnb1yyGappG9SjHQhNBWdlps6taNnqzmOr4khMdcIv
 wClwhiNOWCLcAoxMEZO0wlYt2cd6guDSrE1zDb7u4u55PLCVQTOsQUeQLP321kXIjypAQ7CtuGg
 =
X-Google-Smtp-Source: AGHT+IGGuIi1oNqIPnHGcbVtojs+hBz9rmx7NDymy+aKmbOsPwB4n1NCVDOoYRK/8kKMKDszwty7RQ==
X-Received: by 2002:a05:6e02:1544:b0:375:9c7e:d09 with SMTP id
 e9e14a558f8ab-398e4bccf55mr188830245ab.7.1721833780115; 
 Wed, 24 Jul 2024 08:09:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 04/35] video: mxc: Avoid setting global_data fb_base
Date: Wed, 24 Jul 2024 09:08:51 -0600
Message-Id: <20240724150922.2343249-5-sjg@chromium.org>
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

This is not used, so don't set it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/imx/mxc_ipuv3_fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3_fb.c
index 039b22086a9..fdeb3cabea7 100644
--- a/drivers/video/imx/mxc_ipuv3_fb.c
+++ b/drivers/video/imx/mxc_ipuv3_fb.c
@@ -403,7 +403,6 @@ static int mxcfb_map_video_memory(struct fb_info *fbi)
 		(uint32_t) fbi->fix.smem_start, fbi->fix.smem_len);
 
 	fbi->screen_size = fbi->fix.smem_len;
-	gd->fb_base = fbi->fix.smem_start;
 
 	/* Clear the screen */
 	memset((char *)fbi->screen_base, 0, fbi->fix.smem_len);
@@ -633,7 +632,6 @@ static int ipuv3_video_probe(struct udevice *dev)
 	mmu_set_region_dcache_behaviour(fb_start, fb_end - fb_start,
 					DCACHE_WRITEBACK);
 	video_set_flush_dcache(dev, true);
-	gd->fb_base = fb_start;
 
 	return 0;
 }
-- 
2.34.1

