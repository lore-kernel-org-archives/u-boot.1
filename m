Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47654C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7B3876C9;
	Mon, 11 Dec 2023 10:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SQnft34q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE7D0876C7; Mon, 11 Dec 2023 10:01:28 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE24876E1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d307cf18fdso3082625ad.3
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285284; x=1702890084;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rteIT0B5ifoqaM308MSBbo81XokTnfHTG1hQ+EOR2C0=;
 b=SQnft34qNw/SXUERa+E7fVNGT4QE8rsRFAunqeKymM73bIjr8l3j11GUjQjdbgWM8k
 vC/4/+WCroB6XSC43z9b0Hw8k3MaUyxRjVmsIjqKN0bjzVcyPBuZCKZk6S4LiooFG1dl
 W+kOYGu20Udpbnhb+xx+XL5zyS4o/ffPfQ7K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285284; x=1702890084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rteIT0B5ifoqaM308MSBbo81XokTnfHTG1hQ+EOR2C0=;
 b=uJa/71Sj/ORPNp68vVJ91I/iOY1c/z4uzAqOmlo71s63KvpY0C5nPOjKVL2ubayeeS
 /lP08jq04AHSgRJNOvNhLJkf7npIfB3Ws0+DjqT2l0qBFztabCKaDJc/yd5DFtluIkQv
 1WL8YBT2A5GGyM4BV4lJW+NwiCMss9EdC1WjCx/VwEK6n5eemIecG+owe2G5n6sORbOW
 sTKofqKdkM0QZEbDJDQEGzoF/P5JxFN0eaW0Zy87lGswls7skQmj7viy8xl3hRRZ7xDr
 L9iEBMxlM950BQDsqdJb0FXsydny3zwSNOjoE6QUmupJwrLfRUBj0EpPja2WYszHWKyO
 igoA==
X-Gm-Message-State: AOJu0YxYAJlhxaQ22BtJ2PlWHm58odsOS6YryOADmnHS5TyC5Y8UO57G
 80Y7naDGqzG/zjUUEzi+YzRBhg==
X-Google-Smtp-Source: AGHT+IFpLMqKh13HI5bWCMBC7anLztfIL1LAd6O9Xte/78akIf0hSXZd1Swb+R92md9YIkYhoLoK+A==
X-Received: by 2002:a17:902:f682:b0:1d0:45bb:aa11 with SMTP id
 l2-20020a170902f68200b001d045bbaa11mr2259658plg.4.1702285284169; 
 Mon, 11 Dec 2023 01:01:24 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:01:23 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH 10/17] clk: rk3328: Add get hdmiphy clock
Date: Mon, 11 Dec 2023 14:29:32 +0530
Message-Id: <20231211085939.5478-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211085939.5478-1-jagan@amarulasolutions.com>
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
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
 drivers/clk/rockchip/clk_rk3328.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index 7fcf84f08e..5a4a555d36 100644
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
@@ -656,6 +660,16 @@ static ulong rk3328_vop_set_clk(struct rk3328_clk_priv *priv,
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
@@ -685,6 +699,9 @@ static ulong rk3328_clk_get_rate(struct clk *clk)
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

