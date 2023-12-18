Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB10CC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D5B8763E;
	Mon, 18 Dec 2023 20:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WttAI543";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 135BB8763E; Mon, 18 Dec 2023 20:12:10 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC74C8715C
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5c21e185df5so2875554a12.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926725; x=1703531525;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iUm3IEq0PMw6VARhLafpRnKuDQlhlEvJ+yPniR1MY30=;
 b=WttAI543t0wYX6tIYVP7emUATiHGSa+hGGaPS5QJBvZgFPyPM33fXz3htDLGNKbDlL
 e13B7VBgQbW/MUHRmrb0DUPZclRAWh1vSiicCDHeUddaHnZCFqilNKe1LSrjFb38Xodx
 oiahCnGBrde1yOp7D6fHsIBdptdOfH6kBNFZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926725; x=1703531525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iUm3IEq0PMw6VARhLafpRnKuDQlhlEvJ+yPniR1MY30=;
 b=aF0hPiSpbBtk0ICI2UO8PpYsLH3tJcKVNvHngAjWOGLSN0q39UqKwA1LHEEapXDfPV
 c6Eux9Kvdq/lADljZMn6SpUXFTSxctG0bug5uYz9Y2svJuVZ/XIW2vqvJUure+MhItBr
 hArPwIt1d6+G3Kuwuwlktq9AWzqndywvbtkFszuqr6R1f3quAoJW/cyejkuDD4XFreoY
 Cn230qxxfbhrrSEpnFTYxsWYVbM77q0nhHUnYWTtCPhOweYNj011dhClhbt5W6fxIdYM
 PEDtJga/qXo4bs5k3nK+STKkag1GNThmw8oGtfnkX0kbkamv3N5EhpREth9VFxVf8kg7
 BWPg==
X-Gm-Message-State: AOJu0YzxnMFHGJOxQg88SCYKIBLKSZRSWys8knuU474/ixd1XgD9iQfT
 2ZvhVDZcfPoYR4lL1qk+VgkGNg==
X-Google-Smtp-Source: AGHT+IHWGgbCBJxlaq3mMKigV27Ghy1ElK5xw5LJpiBPuWbUSOv8BOIEcTD18A+leBQ389MDr9qMPw==
X-Received: by 2002:a17:90b:2415:b0:28b:4a9b:cf5c with SMTP id
 nr21-20020a17090b241500b0028b4a9bcf5cmr1994576pjb.67.1702926725115; 
 Mon, 18 Dec 2023 11:12:05 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:12:04 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 10/17] clk: rk3328: Add get hdmiphy clock
Date: Tue, 19 Dec 2023 00:41:07 +0530
Message-Id: <20231218191114.129329-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218191114.129329-1-jagan@amarulasolutions.com>
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
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

From: Jagan Teki <jagan@edgeble.ai>

Add support to get the hdmiphy clock for RK3328 PCLK_HDMIPHY.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v2:
- none

 drivers/clk/rockchip/clk_rk3328.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index ee7edb9d10..5bb9238abb 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -179,6 +179,10 @@ enum {
 	CLK_I2C3_DIV_CON_SHIFT		= 8,
 	CLK_I2C2_PLL_SEL_SHIFT		= 7,
 	CLK_I2C2_DIV_CON_SHIFT		= 0,
+
+	/* CLKSEL_CON40 */
+	CLK_HDMIPHY_DIV_CON_SHIFT	= 3,
+	CLK_HDMIPHY_DIV_CON_MASK	= 0x7 << CLK_HDMIPHY_DIV_CON_SHIFT,
 };
 
 #define VCO_MAX_KHZ	(3200 * (MHz / KHz))
@@ -661,6 +665,16 @@ static ulong rk3328_vop_set_clk(struct rk3328_clk_priv *priv,
 }
 #endif
 
+static ulong rk3328_hdmiphy_get_clk(struct rk3328_cru *cru)
+{
+	u32 div, con;
+
+	con = readl(&cru->clksel_con[40]);
+	div = (con & CLK_HDMIPHY_DIV_CON_MASK) >> CLK_HDMIPHY_DIV_CON_SHIFT;
+
+	return DIV_TO_RATE(GPLL_HZ, div);
+}
+
 static ulong rk3328_clk_get_rate(struct clk *clk)
 {
 	struct rk3328_clk_priv *priv = dev_get_priv(clk->dev);
@@ -690,6 +704,9 @@ static ulong rk3328_clk_get_rate(struct clk *clk)
 	case SCLK_SPI:
 		rate = rk3328_spi_get_clk(priv->cru);
 		break;
+	case PCLK_HDMIPHY:
+		rate = rk3328_hdmiphy_get_clk(priv->cru);
+		break;
 	default:
 		return -ENOENT;
 	}
-- 
2.25.1

