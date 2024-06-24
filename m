Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA48AC2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEE9288571;
	Mon, 24 Jun 2024 23:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="joi3AnLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 714968856F; Mon, 24 Jun 2024 23:04:41 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DA8188569
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-421cd1e5f93so36771135e9.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263078; x=1719867878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yQ9ptLzwgAWUjSdARsAxXvjz5j8RCBFJlrszRabnvWs=;
 b=joi3AnLM9OVr7yRf+lVdvKqa5vAj6Rl86z6xwj+KYXvsaW43pn8iBFdQlXhzAR/l5w
 m1EmjnJdH2GrDQGQYpY9MWnQQL4L1rwkw+f8k9eFp7CljAekEYXqvffT2nT2fMZqCrbK
 gTRcZKqYvW/T/sEp1w6tmZr5RqW4iSfEy4kiFh/2/pxwkc1w9xz+MWy39o5Q9ZJd8+Pl
 kU5bsCAMFrvFQWjANN4SElrrilX9fvU7EjkhvsQx3xW0NZLCEodnkl4Wg8idh0QojG5x
 PBycTwfLHEMCE1jAd8Ul8zFzIQI7s5NSiAYzV+rHzgUVoc8X0y5I4C+Q+dUo+eaBTKqd
 wMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263078; x=1719867878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQ9ptLzwgAWUjSdARsAxXvjz5j8RCBFJlrszRabnvWs=;
 b=haCrYyUyhOyAYEfGMjh10fhNbkpq9fAVZBig4Y/soCB9maKzohFKTG9Oh13TGueMYb
 p9vmV3+ud3zlo9TaP1diWYnBTK/sSbdYBuMwkdQbZzranbl/BvvKcrZHr6d2thrzc8ZW
 4aGImeQY0onA7FhZ0mlxQt2beVj71zzXSms4mc4YKoU3RXmrOs+VUrOqXHZfaTKwQPUL
 1Dx+kk5uVOrh+8kB44fAIB90LuOCpg965bJEmn+1j7Ws/A8iJv6UACyhqyaB7+vWQA2V
 oj5L90GkexH1uUb81fA0d5wfn7yCwmWgz99mbX/cEms37Fipce9XtsAyIHVeNuRwf/av
 zjrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlzBiMpROeoh9AKBROk1hjC/PihC5LFjH/eokysJ0eTo1ehUv+2AWJGUGJsk43U0rOMxaiE5OYtnIalXIQotX7JJJjnA==
X-Gm-Message-State: AOJu0Yw6N5paCrAX5Cn2ldAr16emHL2aounu1IzYic/VWAQZ/KvILA+2
 QkDA4I8JsZuhTArBLGz6wDbH3xxw0lqaBH6LKJyGkmfGVoUWllQY
X-Google-Smtp-Source: AGHT+IEWcA08/sNmRERDTnuRH8Cm3jwYrNBJ7OGCDRT3gdyXQlZF3kbiq4pcwqNeY2kwzt7aQqoAZw==
X-Received: by 2002:a05:6000:371:b0:362:f9c2:f76f with SMTP id
 ffacd0b85a97d-366e962957emr4307487f8f.60.1719263078478; 
 Mon, 24 Jun 2024 14:04:38 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:38 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>, John Crispin <john@phrozen.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Marek Vasut <marex@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH v4 08/14] mmc: mediatek: add support for upstream linux clock
 and property
Date: Mon, 24 Jun 2024 23:03:34 +0200
Message-ID: <20240624210418.19324-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624210418.19324-1-ansuelsmth@gmail.com>
References: <20240624210418.19324-1-ansuelsmth@gmail.com>
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

Add support for upstream linux clock and map U-Boot property to the one
use in upstream linux where supported.

Also add handling for the use_internal_cd that on upstream is hardcoded
enabled on mt7620.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mmc/mtk-sd.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index 3a9258255a7..ebd72178b59 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -335,6 +335,7 @@ struct msdc_compatible {
 	bool enhance_rx;
 	bool builtin_pad_ctrl;
 	bool default_pad_dly;
+	bool use_internal_cd;
 };
 
 struct msdc_delay_phase {
@@ -365,6 +366,10 @@ struct msdc_host {
 	struct clk src_clk_cg;	/* optional, MSDC source clock control gate */
 	struct clk h_clk;	/* MSDC core clock */
 
+	/* upstream linux clock */
+	struct clk axi_cg_clk;	/* optional, AXI clock */
+	struct clk ahb_cg_clk;	/* optional, AHB clock */
+
 	u32 src_clk_freq;	/* source clock */
 	u32 mclk;		/* mmc framework required bus clock */
 	u32 sclk;		/* actual calculated bus clock */
@@ -1637,6 +1642,11 @@ static void msdc_ungate_clock(struct msdc_host *host)
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
@@ -1650,6 +1660,9 @@ static int msdc_drv_probe(struct udevice *dev)
 
 	host->dev_comp = (struct msdc_compatible *)dev_get_driver_data(dev);
 
+	if (host->dev_comp->use_internal_cd)
+		host->builtin_cd = 1;
+
 	host->src_clk_freq = clk_get_rate(&host->src_clk);
 
 	if (host->dev_comp->clk_div_bits == 8)
@@ -1715,18 +1728,31 @@ static int msdc_of_to_plat(struct udevice *dev)
 
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
 
@@ -1775,6 +1801,7 @@ static const struct msdc_compatible mt7620_compat = {
 	.enhance_rx = false,
 	.builtin_pad_ctrl = true,
 	.default_pad_dly = true,
+	.use_internal_cd = true,
 };
 
 static const struct msdc_compatible mt7621_compat = {
@@ -1805,7 +1832,7 @@ static const struct msdc_compatible mt7623_compat = {
 	.data_tune = true,
 	.busy_check = false,
 	.stop_clk_fix = false,
-	.enhance_rx = false
+	.enhance_rx = false,
 };
 
 static const struct msdc_compatible mt7986_compat = {
-- 
2.45.1

