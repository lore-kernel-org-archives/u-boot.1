Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABB4CA600C
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 13:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1327981299;
	Thu,  8 Oct 2026 13:52:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3sF96ooQ9piV; Thu,  8 Oct 2026 13:52:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2B3FA8129A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791467531;
	b=ibHGBVscePTmPO8pTgfBX1g2cblpm+PmOXya6Wbq2fa3Tq9YsvNKZF1YEePmfLV9MPKL
	 AzNHQ478Tt/6mm1KIfCpUOHXR566P/r5TDva/LTxPeyUUNANeGxQrChdqC8tenJOPiMBb
	 Ei8Gm7xTDzoCym+IAqZ0zxkcTRKuT3jnRZrlLjDZcNQRDXv4WGoIKH+9jxUpYYmCgg/+A
	 zjxF3A2+HtjFmgd8R2d3xEjWbk6FyWf47IqE9GqrDL+CxhesbhbUCKp50u0NnwDrAQR3+
	 5waRLzC0N/yBTOKvoQt4aDOH1ATgLd6WNkkTeVsJAFqvLvu8p5y7BITK0TkvjLwMzLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791467531;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Dn8RF1SlB8ReJPw/P8YPsbYZ55Bt7/tGU57ZmuSD/eE=;
	b=UbRK8OeomAG6oW+WHB6+UVRDcXJ2Y9jGzuoIQxtImeUmesNPN6wj+rPqdZJL3ZauBRDP
	 dxGZozgNETA/a47SeYJ0Qtm9GlbLIJQqaq8731Wb8dzRCq9xlem3AjUiV177DnJ0YcGoY
	 hHZdbrdWgvm7i2Q6PYaz9tijOeA65hQdKrC51Kx5s/o4UfZ8mYQ9gdT/OZq/5WnCYangl
	 ZLwNe51nkyBSaktsjojqKbmohXB39Lr5vWhyXvwRq/BiFBkFPJwrn3WzlYHRdWOvtfjxJ
	 D1XjyUSG32HAobxP64FjhXZem2m7RZ7EM4A9ikvslhjJgi8Dag4QNFd7P9ItG6nO6pg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791467531;
	bh=Dn8RF1SlB8ReJPw/P8YPsbYZ55Bt7/tGU57ZmuSD/eE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0uN3/8Kl3fKBsexxK3A91qR65+R2KwHDCk6eheSQRO+SACKTEsGzfMWLDCHnxrzNL
	 6RzU7PAgPkBXFiaFWoHprEvQ/wM+6F/nqMg7kML+R2ptVVjm3qeJv2+RHsf+Sh4e0d
	 cfjcYjkTa7u97FK2KDfcjniit6wZb1TbhXWOxY79DqbzQ4ofNM/lHPweXd5I/9Apsh
	 l1NG6lyKk3sPIQHD496vam6D2uwwDkOxpsFJtEwOqNn/JyV5wnh121FI/VFcVRxybU
	 jAs02LlSSovCUHakkSafI3iScknxINeohQNlHyqkLf4T62kDWiJsB8fcFf8nH+xhDh
	 Cp5Am4kXZNXyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B3FA8129A;
	Thu,  8 Oct 2026 13:52:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 90C302E0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 13:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7689540AEF
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 13:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QNgj1B7Q9p9m for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 13:52:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 92F4940AE2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791467528;
 b=bK5vcbR1J3r4OZet6BEn4T7cbfMEHR+DbYWGFOUniJMsMGKIRn2Km0wjBotCrcIr+6Dz
 P8AKnx2TowdIXpiIPRTb0pt18TuuWVqMU7Qv8RxV3i5LuALW7m9JGGH7gl7wEVx0TMHIb
 WSrchVl0rNjGY5nF6zzx2/ESNDECbnIJWEl360Na3ejwROM6kOnXzwEhQPQ4vMKzZf5Wm
 xC4QjIpNmuE/niVJZJfFSwDtfkEByWnlR+jdxCnqT5THhJEDJwc+h1+rCS3aNN4yqIe+s
 q8FyHLbeX5YhKN91tCUb3WdIipDeU1I8sGnP6dyo96JUH64dpA4QuEDBbo/ghA56/5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791467528;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=Dn8RF1SlB8ReJPw/P8YPsbYZ55Bt7/tGU57ZmuSD/eE=;
 b=o8+NblQI7l1PNL2pxtA9mGi8gHf1x9MFWedAgiCDHn9ZbrivIvjBAcG+JGMQ023UNkV8
 Ge7Os7H46OTO7oa/jsAKN2m8cqL/Y/C+GJuk+swTvuN17wdYEoT3DfC0bDYTfKQLyFZIf
 zmjDDjvbzePZXzjCPdxOhMLXZxExIk0On8cU2cAwfwXSLkIP4QPBBAajOkkbo5cZtsdp2
 y0H4p8qOcbQMDKxG3HiUN5qfpdyc/bD3ynUJLbNDjSy3zk4sVwFJ6oad4QuBgPjQFpwYE
 UO+2TVCTRN8T5ic8Zlh7ZuOncQh8zdI8JuwW/rv9H2xqmVSFQV3KxA8TWhFIB74D4NQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DZJtxgTr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DZJtxgTr
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92F4940AE2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 13:52:08 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2df982e04c1so19230025ad.2
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791467527; x=1792072327;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dn8RF1SlB8ReJPw/P8YPsbYZ55Bt7/tGU57ZmuSD/eE=;
 b=DZJtxgTr7/01IGlur3Zn5w8TxQHR5DUrsnoquiROE/MyRHXV6BdgzWIN9OehTh/ARF
 L5lsMC2RGe0wMETLfmXtLnJp/OG7hbevbT0BhiGuOjFjCIuFpVdTuUA2+oYNN/ywPG83
 GyMhFIganZcjP7mYDm1m73pHSGZLfcYwMnyTP9bYRYyJmXVBvTMeTVyaMYti3cZepwGZ
 fsnQ47OvFCGHG8LFpgRk1gvEkUfNv39fwTiWSi3J06GjUIhdAMCn7xoJnS2RJaudexFP
 dfKd1ZHjfU6Ppns04fF325COkAf2HMHzfp0qV/yfTm8uCitDs92vUVwSu1J2HKZD+6+G
 m+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791467527; x=1792072327;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dn8RF1SlB8ReJPw/P8YPsbYZ55Bt7/tGU57ZmuSD/eE=;
 b=Dv1bgVwFZ1jkN6d2XDFk3X+x1y3WhTcP5nayCci4WAbLQGCT4lKd+xsdcF9rnKYk/8
 PpIhs63RCWbOkCO0v40HAkF7+EREpgQYZ5t1p0YSuVLnTt3WmNz5F7jBKYuxCjTY5MA9
 nrz5kOc3DU2dKZYyaIfg6uwMr/yFwsVaBhKtpOEXG38gX0W33e//c8y5d9Q3e2i8URqP
 LnP13ryqbaRIiseTWa0NK5IBMSNazh5YOX1gj0JvtlomdeTI2vynO8R7R6G9H/1Inbqn
 YI1ZfGwFedq3vdmCnOQH+PFlIcoSHFm1tAJXDqDUxHN6vF5N6Ql8b92NCpe0nCwKphR7
 lY9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxB6qvY7h+vRidr3MbwPQTmLwYZzWgFwHUs/gNVWGZaYMJS42cq8og76/Ykal96UknwVqAh4gw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKdVJWDT8O7DIWlB3hgTk9q0fl3YsTXcBevx5zeRt4msd6Xu0rq
 9NQh3K06aE3o+GxuhGcoyWMGgpK1LfgSFtXvDmu3Yb7O3AANGIPR6l61
X-Gm-Gg: AYBFou3ikb9G1gDzQfdkhhzim6oCOF71jfgaVl3qrjdek1c2YtUey/Pw8wqH6VU6RXu
 ww4AW/QqJ9Y25iZjFC8/LJQ6NtHi4u8SHqeAWX7mNYH0VII6dfsKwFgoFKdjhYytr+ea2lVszE5
 XFzGTzBc1JITiZH3T3voWQfGPEjbp4GuxIb3mC+3Kc9gDmY9uB4qy/OvfEufDKWteTfNsWYpT7Z
 oHLQsMii+0j6cMrYXSMkjeQkuuQIOMg2eptbbg1dBeHzTEqAUNVr26bmkHWerLL3eiKgqxA5STQ
 V+AVM7X1F6k0WSuq7M7ol8mSEYFcmADpVJRgu9WOlREStvn8alYzSoQDi2ylVqiYtwJL+nyMjKD
 dlebOpfFFpuoFZapJY4hD1ucpJ1DNNZQ2nEsliVzsppWhROyXPb5i2qxMYfSJN1pL5teqLPRjUd
 FSzfUB9cxC2fTXyHG6+fMWUWfj8sXh8KE6wodtnUwQTfNSOfioxWyw0B+/FESf
X-Received: by 2002:a17:903:3910:b0:2dd:c0ff:e727 with SMTP id
 d9443c01a7336-2e600545a20mr48417325ad.57.1791467527446; 
 Thu, 08 Oct 2026 06:52:07 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:7618:4e1c:8916:e003:1be:df99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e6046fe391sm25019425ad.29.2026.10.08.06.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:52:06 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Thu, 08 Oct 2026 20:51:38 +0700
Subject: [PATCH] video: use bpp conversion helpers consistently
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBBA0avErBPUQKKrRAvNqSbCxKkIortnt
 XyL/y9gTIQMTXFBwoOY1pChygL6yYYRBfls0FIbJaURLkYx4RIxsfC1N5VTWvraQi5iwoHO79Z
 2v3l3M/bbu4D7fgDGOK8jbwAAAA==
X-Change-ID: 20261006-bpp-helpers-d8d63b120d8a
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Eugen Hristev <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Use bpp conversion helpers for consistency and to reduce the
reliance on the specially crafted VIDEO_BPP* enum values. No
functional change is made.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
 cmd/bdinfo.c                           | 2 +-
 drivers/video/atmel_hlcdfb.c           | 2 +-
 drivers/video/imx/mxc_ipuv3_fb.c       | 2 +-
 drivers/video/meson/meson_vpu.c        | 4 ++--
 drivers/video/mvebu_lcd.c              | 2 +-
 drivers/video/sunxi/sunxi_de2.c        | 2 +-
 drivers/video/tegra/dc.c               | 4 ++--
 drivers/video/tegra/tegra124/display.c | 2 +-
 drivers/video/ti/tilcdc.c              | 4 ++--
 drivers/video/tidss/tidss_drv.c        | 4 ++--
 test/cmd/bdinfo.c                      | 2 +-
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index bf1eca759..37981764b 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -114,7 +114,7 @@ static void show_video_info(void)
 						   plat->copy_size);
 			}
 			printf("%-12s= %dx%dx%d\n", "FB size", upriv->xsize,
-			       upriv->ysize, 1 << upriv->bpix);
+			       upriv->ysize, VNBITS(upriv->bpix));
 		}
 	}
 }
diff --git a/drivers/video/atmel_hlcdfb.c b/drivers/video/atmel_hlcdfb.c
index 89bc0eeb6..8a0096cec 100644
--- a/drivers/video/atmel_hlcdfb.c
+++ b/drivers/video/atmel_hlcdfb.c
@@ -315,7 +315,7 @@ static int atmel_hlcdc_bind(struct udevice *dev)
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
 	uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-				(1 << LCD_MAX_LOG2_BPP) / 8;
+				VNBYTES(LCD_MAX_LOG2_BPP);
 
 	debug("%s: Frame buffer size %x\n", __func__, uc_plat->size);
 
diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3_fb.c
index 3a327b9e9..447644f5b 100644
--- a/drivers/video/imx/mxc_ipuv3_fb.c
+++ b/drivers/video/imx/mxc_ipuv3_fb.c
@@ -654,7 +654,7 @@ static int ipuv3_video_bind(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
-	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT * (1 << VIDEO_BPP32) / 8;
+	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT * VNBYTES(VIDEO_BPP32);
 
 	return 0;
 }
diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
index a686faf9f..21ac60749 100644
--- a/drivers/video/meson/meson_vpu.c
+++ b/drivers/video/meson/meson_vpu.c
@@ -79,7 +79,7 @@ cvbs:
 
 	/* Move the framebuffer to the end of addressable ram */
 	meson_fb.fb_size = ALIGN(meson_fb.xsize * meson_fb.ysize *
-				 ((1 << VPU_MAX_LOG2_BPP) / 8) +
+				 VNBYTES(VPU_MAX_LOG2_BPP) +
 				 MESON_VPU_OVERSCAN, EFI_PAGE_SIZE);
 	meson_fb.base = gd->dram[0].start +
 			gd->dram[0].size - meson_fb.fb_size;
@@ -141,7 +141,7 @@ static int meson_vpu_bind(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->size = VPU_MAX_WIDTH * VPU_MAX_HEIGHT *
-		(1 << VPU_MAX_LOG2_BPP) / 8;
+		VNBYTES(VPU_MAX_LOG2_BPP);
 
 	return 0;
 }
diff --git a/drivers/video/mvebu_lcd.c b/drivers/video/mvebu_lcd.c
index 9f1ea9c35..234b27c90 100644
--- a/drivers/video/mvebu_lcd.c
+++ b/drivers/video/mvebu_lcd.c
@@ -576,7 +576,7 @@ static int mvebu_video_bind(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-		(1 << LCD_MAX_LOG2_BPP) / 8;
+		VNBYTES(LCD_MAX_LOG2_BPP);
 
 	return 0;
 }
diff --git a/drivers/video/sunxi/sunxi_de2.c b/drivers/video/sunxi/sunxi_de2.c
index ab36ee159..9039fb2e6 100644
--- a/drivers/video/sunxi/sunxi_de2.c
+++ b/drivers/video/sunxi/sunxi_de2.c
@@ -279,7 +279,7 @@ static int sunxi_de2_bind(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-		(1 << LCD_MAX_LOG2_BPP) / 8;
+		VNBYTES(LCD_MAX_LOG2_BPP);
 
 	return 0;
 }
diff --git a/drivers/video/tegra/dc.c b/drivers/video/tegra/dc.c
index ced497188..6aca106f1 100644
--- a/drivers/video/tegra/dc.c
+++ b/drivers/video/tegra/dc.c
@@ -278,7 +278,7 @@ static int setup_window(struct tegra_lcd_priv *priv,
 	win->out_w = priv->width;
 	win->out_h = priv->height;
 	win->phys_addr = priv->frame_buffer;
-	win->stride = priv->width * (1 << priv->log2_bpp) / 8;
+	win->stride = priv->width * VNBYTES(priv->log2_bpp);
 
 	log_debug("%s: depth = %d\n", __func__, priv->log2_bpp);
 
@@ -646,7 +646,7 @@ static int tegra_lcd_bind(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-		(1 << LCD_MAX_LOG2_BPP) / 8;
+		VNBYTES(LCD_MAX_LOG2_BPP);
 
 	return dm_scan_fdt_dev(dev);
 }
diff --git a/drivers/video/tegra/tegra124/display.c b/drivers/video/tegra/tegra124/display.c
index abe31e27d..fd2b92c5e 100644
--- a/drivers/video/tegra/tegra124/display.c
+++ b/drivers/video/tegra/tegra124/display.c
@@ -484,7 +484,7 @@ static int tegra124_lcd_bind(struct udevice *dev)
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
 	uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-			(1 << VIDEO_BPP16) / 8;
+			VNBYTES(VIDEO_BPP16);
 	debug("%s: Frame buffer size %x\n", __func__, uc_plat->size);
 
 	return 0;
diff --git a/drivers/video/ti/tilcdc.c b/drivers/video/ti/tilcdc.c
index b498e8186..6b2e591ce 100644
--- a/drivers/video/ti/tilcdc.c
+++ b/drivers/video/ti/tilcdc.c
@@ -430,8 +430,8 @@ static int tilcdc_bind(struct udevice *dev)
 {
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
-	uc_plat->size = ((LCDC_MAX_WIDTH * LCDC_MAX_HEIGHT *
-			  (1 << LCDC_MAX_LOG2_BPP)) >> 3) + 0x20;
+	uc_plat->size = LCDC_MAX_WIDTH * LCDC_MAX_HEIGHT *
+			VNBYTES(LCDC_MAX_LOG2_BPP) + 0x20;
 
 	dev_dbg(dev, "frame buffer size 0x%x\n", uc_plat->size);
 	return 0;
diff --git a/drivers/video/tidss/tidss_drv.c b/drivers/video/tidss/tidss_drv.c
index c231fd034..7c8bfe418 100644
--- a/drivers/video/tidss/tidss_drv.c
+++ b/drivers/video/tidss/tidss_drv.c
@@ -986,8 +986,8 @@ static int tidss_drv_bind(struct udevice *dev)
 {
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
-	uc_plat->size = ((LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-			  (1 << LCD_MAX_LOG2_BPP)) >> 3) + 0x20;
+	uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
+			VNBYTES(LCD_MAX_LOG2_BPP) + 0x20;
 	return 0;
 }
 
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 7b7fb0894..f53665446 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -91,7 +91,7 @@ static int test_video_info(struct unit_test_state *uts)
 			}
 			ut_assert_nextline("%-12s= %dx%dx%d", "FB size",
 					   upriv->xsize, upriv->ysize,
-					   1 << upriv->bpix);
+					   VNBITS(upriv->bpix));
 		}
 	}
 

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261006-bpp-helpers-d8d63b120d8a

Best regards,
--  
Reza Kurniawan <imkyufie@gmail.com>

