Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8B0C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E38D88927;
	Thu, 13 Jun 2024 14:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KWqwGRic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A693888D1; Thu, 13 Jun 2024 13:10:29 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639A4888F8
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6f1f33486eso50373266b.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277027; x=1718881827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LV+Jt19oXYiKLeTjJLpt7yR2GDuRd0rePLdFN8b780U=;
 b=KWqwGRice96euTvGyzvu7t4SgPkYT1dj+w5z1WPV6tYWrJo9au+Qje1luIvmstQ3lN
 G9ZmOoWXvehPUKLDmZCxtd89qnfBDC6qI5q8hUrjBi4YC+KC06hBCtYf1+YJ/FIy8Fs+
 lEp0Tr/cCXtjZswCP5aawUTM3OVLAyPWi/eLNrDQELatf4xn6KBJsd3P5K0uYblleHvs
 40H6vNQLfsfOhLL93ADMbrYMqsyN28fHOcQhkqvbFiaW95Z9knRyz0wVa64zlQqqjYAU
 ODXEZY19smQ8iaFjGq+MxEzrt6GykDHm3V0ThAc7lbEcPX+Oz2V5hwLGx6kzgm1DdIYI
 lE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277027; x=1718881827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LV+Jt19oXYiKLeTjJLpt7yR2GDuRd0rePLdFN8b780U=;
 b=GNFGEprFk2QZyWFNm6M5kR+l95667QC7JEE18411pNF4nG9kqZhsE+z1gLWeCdUi+l
 vYb03UoKaFLByd3P3Jfx83/Yj1NG3L+G9M0Z+zpVKrGP2+ZqCHfv4pcX7LeMQbIjeFRs
 BwO8Fnv4lwb8WHZoQS+P0yxBpF/TgNBfyt2eU9trT8Zgus4zJHA1R/306lzJd5kdDEad
 LB6Sf6HxlAgHDH2QsVQ6qwz0gKn2jNgOxBiCyoQ/Gpuo25r5fK4g/7Tm5ydnhJSPcPPx
 2DfwYnW3kP7pKTyx0Ra40nm9qT/lqnLkEnGGP+NXDb1kR9/2DdStl9zSwgvchVCeRbUb
 yRTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt2HN3+L+Q4T/mY2yRdJL9CFdbpPTI7p0aL9pPmkdtMcGJ0NY6r7OoRD7Z5jURf3KBqXI/Z3BZTcLrzYl8sZsDY/oapA==
X-Gm-Message-State: AOJu0Yxl23CGTNESpgoiu+hTyW3yyq/3uTYIbCGVbit4au5G+aRciwTf
 HW7zS9i5pQZWebrqjiSylfIOlnv316OHcqbtq4AQBW3bhKEKCh0Q
X-Google-Smtp-Source: AGHT+IHDDdFL5rRg3QPEKqEplmdCho8CtRf8hyOjMbU/oU0cD5z38IfVUFrze+TvxVGju2h6rm8eTg==
X-Received: by 2002:a50:cd55:0:b0:57c:8e57:c3f0 with SMTP id
 4fb4d7f45d1cf-57caaabd37amr3757634a12.16.1718277026486; 
 Thu, 13 Jun 2024 04:10:26 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Mark Kettenis <kettenis@openbsd.org>, Sumit Garg <sumit.garg@linaro.org>,
 John Crispin <john@phrozen.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Stefan Roese <sr@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 08/14] mmc: mediatek: add support for upstream linux clock
 and property
Date: Thu, 13 Jun 2024 13:09:26 +0200
Message-ID: <20240613110949.11076-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613110949.11076-1-ansuelsmth@gmail.com>
References: <20240613110949.11076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Jun 2024 14:43:53 +0200
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

Add support for upstream linux clock and map U-Boot property to the one
use in upstream linux where supported.

Also add handling for the use_internal_cd that on upstream is hardcoded
enabled on mt7620.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mmc/mtk-sd.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index 296aaee7331..65b6b02e759 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -336,6 +336,7 @@ struct msdc_compatible {
 	bool enhance_rx;
 	bool builtin_pad_ctrl;
 	bool default_pad_dly;
+	bool use_internal_cd;
 };
 
 struct msdc_delay_phase {
@@ -366,6 +367,10 @@ struct msdc_host {
 	struct clk src_clk_cg;	/* optional, MSDC source clock control gate */
 	struct clk h_clk;	/* MSDC core clock */
 
+	/* upstream linux clock */
+	struct clk axi_cg_clk;	/* optional, AXI clock */
+	struct clk ahb_cg_clk;	/* optional, AHB clock */
+
 	u32 src_clk_freq;	/* source clock */
 	u32 mclk;		/* mmc framework required bus clock */
 	u32 sclk;		/* actual calculated bus clock */
@@ -1638,6 +1643,11 @@ static void msdc_ungate_clock(struct msdc_host *host)
 	clk_enable(&host->h_clk);
 	if (host->src_clk_cg.dev)
 		clk_enable(&host->src_clk_cg);
+
+	if (host->axi_cg_clk.dev)
+		clk_enable(&host->axi_cg_clk);
+	if (host->ahb_cg_clk.dev)
+		clk_enable(&host->ahb_cg_clk);
 }
 
 static int msdc_drv_probe(struct udevice *dev)
@@ -1651,6 +1661,9 @@ static int msdc_drv_probe(struct udevice *dev)
 
 	host->dev_comp = (struct msdc_compatible *)dev_get_driver_data(dev);
 
+	if (host->dev_comp->use_internal_cd)
+		host->builtin_cd = 1;
+
 	host->src_clk_freq = clk_get_rate(&host->src_clk);
 
 	if (host->dev_comp->clk_div_bits == 8)
@@ -1716,18 +1729,31 @@ static int msdc_of_to_plat(struct udevice *dev)
 
 	clk_get_by_name(dev, "source_cg", &host->src_clk_cg); /* optional */
 
+	/* upstream linux clock */
+	clk_get_by_name(dev, "axi_cg", &host->axi_cg_clk); /* optional */
+	clk_get_by_name(dev, "ahb_cg", &host->ahb_cg_clk); /* optional */
+
 #if CONFIG_IS_ENABLED(DM_GPIO)
 	gpio_request_by_name(dev, "wp-gpios", 0, &host->gpio_wp, GPIOD_IS_IN);
 	gpio_request_by_name(dev, "cd-gpios", 0, &host->gpio_cd, GPIOD_IS_IN);
 #endif
 
 	host->hs400_ds_delay = dev_read_u32_default(dev, "hs400-ds-delay", 0);
-	host->hs200_cmd_int_delay =
-			dev_read_u32_default(dev, "cmd_int_delay", 0);
+	if (dev_read_u32(dev, "mediatek,hs200-cmd-int-delay",
+			 &host->hs200_cmd_int_delay))
+		host->hs200_cmd_int_delay =
+				dev_read_u32_default(dev, "cmd_int_delay", 0);
+
 	host->hs200_write_int_delay =
 			dev_read_u32_default(dev, "write_int_delay", 0);
-	host->latch_ck = dev_read_u32_default(dev, "latch-ck", 0);
+
+	if (dev_read_u32(dev, "mediatek,latch-ck", &host->latch_ck))
+		host->latch_ck = dev_read_u32_default(dev, "latch-ck", 0);
+
 	host->r_smpl = dev_read_u32_default(dev, "r_smpl", 0);
+	if (dev_read_bool(dev, "mediatek,hs400-cmd-resp-sel-rising"))
+		host->r_smpl = 1;
+
 	host->builtin_cd = dev_read_u32_default(dev, "builtin-cd", 0);
 	host->cd_active_high = dev_read_bool(dev, "cd-active-high");
 
@@ -1776,6 +1802,7 @@ static const struct msdc_compatible mt7620_compat = {
 	.enhance_rx = false,
 	.builtin_pad_ctrl = true,
 	.default_pad_dly = true,
+	.use_internal_cd = true,
 };
 
 static const struct msdc_compatible mt7621_compat = {
@@ -1806,7 +1833,7 @@ static const struct msdc_compatible mt7623_compat = {
 	.data_tune = true,
 	.busy_check = false,
 	.stop_clk_fix = false,
-	.enhance_rx = false
+	.enhance_rx = false,
 };
 
 static const struct msdc_compatible mt7986_compat = {
-- 
2.43.0

