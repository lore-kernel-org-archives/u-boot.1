Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7CEC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F8E87950;
	Wed, 17 Jan 2024 08:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="o4RL1qOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F258487A77; Wed, 17 Jan 2024 08:52:58 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29728795B
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d5f388407bso7360825ad.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477975; x=1706082775;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSxIA3gvV9QOlGby6Rh9zf0Jqfao5XpbOuNEEnLKMEo=;
 b=o4RL1qOnbv5umDjJjSfS9wVhu7OOzGHLvnTku+xXUjs+KlWkbMNg47SRGy8pesdBbL
 gLNVHw7bXF1GG5aLOz8mMW8F6XngGQpwool9sirHEP0DVMhUTB7baFF4XBZqiZ9pTojO
 Ow2xFGdTJz5/Z220BzyBRWHsmy+w/vj+LasiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477975; x=1706082775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WSxIA3gvV9QOlGby6Rh9zf0Jqfao5XpbOuNEEnLKMEo=;
 b=Iv7MyYupjJ9QQHMz8w5oisXhxh4lDgIJOM+/nUKyO7olEVw1L8UmlbUcRNAhX1LM4E
 wqoRKA6vfxXp041JhbZHfqkUbv66k0VdvbYu9D7O+h7xCqVnvWFlI57rpTGIx+VoBbRc
 sH718eCbmNYLjwMQjkAdCa+Bp9HMnZ7S5utG6AFUilvjaf4v9FHCT7Eyi8cShPdhFBh5
 TeN2Yn1m2Ahwi9hfoZJfgxRUJmZVqt3pmTWO+aHcG1e+/EwryWwZPmqXcHcRW9l4luU1
 5yaDEzHAZml147qQVNc8l/VJ0D4O2hQc/XpqvDuXRMLJdzyeqgxEXY6DOcNH+ZYpYH6z
 jDrw==
X-Gm-Message-State: AOJu0Yy0hAiF71VVmeJN2ouxlVv+g5j+oEflvMQ2bRlXEb5id8Wsym/Q
 J1LXP02vmkat1QkECfyMB8o2BlYs3H+3lyh9TppOjHkTyynZVQ==
X-Google-Smtp-Source: AGHT+IHsUAwIBiCf2MxnSWsvvVCZSV8Q7mJNBgzrFABpRI/yKxHncISO0sZbU49QUeBtbBuLs+79MA==
X-Received: by 2002:a17:902:f547:b0:1d4:e308:d6ff with SMTP id
 h7-20020a170902f54700b001d4e308d6ffmr6199665plf.113.1705477975345; 
 Tue, 16 Jan 2024 23:52:55 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:52:55 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v3 10/17] clk: rk3328: Add get hdmiphy clock
Date: Wed, 17 Jan 2024 13:21:47 +0530
Message-Id: <20240117075154.58747-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117075154.58747-1-jagan@amarulasolutions.com>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
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
Changes for v3, v2:
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

