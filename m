Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1969EC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD7E88464;
	Wed,  5 Jun 2024 21:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nod7a0Fz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C6EA87F39; Wed,  5 Jun 2024 21:03:54 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C69E88096
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-421578c546eso2123805e9.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717614232; x=1718219032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZenwWrDeFzRe8cHFaTxY5C2wi9H9AcMzagN3f1ue2mY=;
 b=Nod7a0Fz2p3VaPFZt97qUl+ZHqKQizhKBgH0Kmx6tGSPt5kBz/0Hc3RC2uj6CpFUti
 lCd51TgTxSaEi0aWZQJQGL5eUFNQhin2e9M8znQK1SK3t7tmT1JdadkBogyN4HONok7x
 0H4stMGGcQlyXXKpTDntkJFGza4e0d69B8eh9u/NDAZ6DKUD+SY0+YiDNDfT207VHpWS
 zOM3F/eZowMODTJYThHC/fA6OysKNCZymtuPZm97kqL1Np12RfNAcqvYf2WDf7XXhx1I
 Fo5pZ2hsYaVhYM7QLTXaAbK0qkTeTVOyDsKBDa7Sfi4YhjUhK74GFnmaaKvEe82bsivb
 TfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614232; x=1718219032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZenwWrDeFzRe8cHFaTxY5C2wi9H9AcMzagN3f1ue2mY=;
 b=PfAL7d3EN2IT1dXLTVFynAfnYueYe+rgDTmyRsr6Mi623a1y6qzUvjEn/7qqvyRZ3f
 rFgjCeBmQg4sfFjgTY+sywGSyvYfZ+juz0CUhbnrfhv+LitYwjZzUB+TGIFSLGT1ZEhb
 lqR3omLDOVevNZPtuY1Y2WX9+3xT3Le9JTlV7hTgLQ+Ns8wHdQJVNboANsS1yEW8YxAb
 zFoMxlcnTtwbsfk4pKFTlmERPLwVXm+l5mCh68Rj2JRlqEiCctfj+ZavNoW47aWtPNwf
 PWSqtgSzR9NIY8vovg3oeoOA5fTk1eLg0VoJQqa81P/HofDK+vlSGMciAxvpeuT529LN
 g/gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZeZdCOSXdxb5kJdySqbmQ4ne61iqsBJjAu4icz9Eio3FYdBbS4ngeF6oHW8rssZEmAdxK+gGPqU2JCQjJ38otAohkLQ==
X-Gm-Message-State: AOJu0YxjlhjGrtmy4PSUcoVnwqunjwb8J+njA5f9fDIldqc0A3Al8k3U
 L9ZHd6N65ciSaJD91pIdDHmuU4Flciys2NWo7XMuRjPfXv027q+9
X-Google-Smtp-Source: AGHT+IH1QRNyf6gH5QsiayNFU7OGqHb1tL9uttUD/JJZsQnOIzo40PGkz7TGOwETIex1FbAhaUFIyw==
X-Received: by 2002:a05:600c:3795:b0:41b:e416:43d3 with SMTP id
 5b1f17b1804b1-421563595a6mr28602425e9.35.1717614231549; 
 Wed, 05 Jun 2024 12:03:51 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214a4abdd5sm44772195e9.0.2024.06.05.12.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:03:51 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 Francois Berder <fberder@outlook.fr>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Michal Simek <michal.simek@amd.com>, John Crispin <john@phrozen.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mason Huo <mason.huo@starfivetech.com>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Sergei Antonov <saproj@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 08/11] mmc: mediatek: add support for upstream linux clock and
 property
Date: Wed,  5 Jun 2024 21:02:15 +0200
Message-ID: <20240605190220.17616-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605190220.17616-1-ansuelsmth@gmail.com>
References: <20240605190220.17616-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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
 drivers/mmc/mtk-sd.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index 296aaee7331..93878900dec 100644
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
@@ -1716,19 +1726,33 @@ static int msdc_of_to_plat(struct udevice *dev)
 
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
-	host->builtin_cd = dev_read_u32_default(dev, "builtin-cd", 0);
+	if (dev_read_bool(dev, "mediatek,hs400-cmd-resp-sel-rising"))
+		host->r_smpl = 1;
+
+	host->builtin_cd = dev_read_u32_default(dev, "builtin-cd", 0) ||
+			   host->dev_comp->use_internal_cd;
 	host->cd_active_high = dev_read_bool(dev, "cd-active-high");
 
 	return 0;
@@ -1776,6 +1800,7 @@ static const struct msdc_compatible mt7620_compat = {
 	.enhance_rx = false,
 	.builtin_pad_ctrl = true,
 	.default_pad_dly = true,
+	.use_internal_cd = true,
 };
 
 static const struct msdc_compatible mt7621_compat = {
-- 
2.43.0

