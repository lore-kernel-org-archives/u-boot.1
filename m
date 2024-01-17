Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B3DC47DA7
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C97E3878A5;
	Wed, 17 Jan 2024 08:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hyFeJF2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03D388795B; Wed, 17 Jan 2024 08:52:55 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86E387A59
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so5650841a12.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477971; x=1706082771;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjiMp5TfDTDN49+UQbMKIM4bQWeeH8LlyW/eIySrjN0=;
 b=hyFeJF2kSPHsASBDREA2aQlPrkFgOyLqNTn3eFIMbhxSsgkCdjprJ+B+1y/prijVQ9
 vjNEewe9im08ZGmQyUfiqsxW62mN4G0It1HbHLqakd3apGVGQemHwQASAnAgylVYaDZc
 Bco/Ue0DxH+gkhGZhZFt1QAvMotj2iO7frlo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477971; x=1706082771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vjiMp5TfDTDN49+UQbMKIM4bQWeeH8LlyW/eIySrjN0=;
 b=BeM2l2Y7FXPvQysGEas9wvcGceAQgJA43eyYWl/qYy3oE8URotQgEoL17k8fUEyI/6
 7C8C+FINt4JZaUYtQYw09BbuLS/HfftHLGGQBVgiLkETywxts2LW4Jc7wGIUseex//6f
 BZvxdh+uOWlvZ1t027awmS4Y4WTgFWHXr59sqCGK0RH3ZFYLDWJ1mmWhIPBb24WSsVNk
 qXian4JCBF+dWrIoRfKf7Rw4/GQWmBG1USIRpgXGRPfSqbN3kLWDECgj/Id7jYcLVOW3
 4zX8IBFcsmVniTnzL2m4Mfw9jdy0aunVJL3zcFradEDxUPJTnaW7hX4hPVzWAT9ffvXD
 uagQ==
X-Gm-Message-State: AOJu0Yz3YfRlaw3PLwmkT1eZqKc+VmRiWPoz4q7WfoHSK97wUQ9j14z5
 P0l7/iJqNdozfTe7ET/6QbqWXJc4RZT1ag==
X-Google-Smtp-Source: AGHT+IFGtoI691J5zITNIuULDtboYQqM+bm3xk4Xo65Z3xTkTbZ0mxu5KYaIdPqGvUViJ08Aee27Fw==
X-Received: by 2002:a05:6a21:1f02:b0:19a:13cc:bdc3 with SMTP id
 ry2-20020a056a211f0200b0019a13ccbdc3mr3750072pzb.50.1705477971105; 
 Tue, 16 Jan 2024 23:52:51 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:52:50 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v3 09/17] clk: rockchip: rk3328: Add VOP clk support
Date: Wed, 17 Jan 2024 13:21:46 +0530
Message-Id: <20240117075154.58747-10-jagan@amarulasolutions.com>
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

VOP get and set clock would needed for VOP drivers.

Add support for it.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v3:
- none
Changes for v2:
- Add DCLK get rate

 .../include/asm/arch-rockchip/cru_rk3328.h    | 34 +++++++
 drivers/clk/rockchip/clk_rk3328.c             | 88 ++++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3328.h b/arch/arm/include/asm/arch-rockchip/cru_rk3328.h
index 226744d67d..4ad1d33e05 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3328.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3328.h
@@ -62,6 +62,40 @@ check_member(rk3328_cru, sdmmc_ext_con[1], 0x39c);
 enum apll_frequencies {
 	APLL_816_MHZ,
 	APLL_600_MHZ,
+
+	/* CRU_CLK_SEL37_CON */
+	ACLK_VIO_PLL_SEL_CPLL		= 0,
+	ACLK_VIO_PLL_SEL_GPLL		= 1,
+	ACLK_VIO_PLL_SEL_HDMIPHY	= 2,
+	ACLK_VIO_PLL_SEL_USB480M	= 3,
+	ACLK_VIO_PLL_SEL_SHIFT		= 6,
+	ACLK_VIO_PLL_SEL_MASK		= 3 << ACLK_VIO_PLL_SEL_SHIFT,
+	ACLK_VIO_DIV_CON_SHIFT		= 0,
+	ACLK_VIO_DIV_CON_MASK		= 0x1f << ACLK_VIO_DIV_CON_SHIFT,
+	HCLK_VIO_DIV_CON_SHIFT		= 8,
+	HCLK_VIO_DIV_CON_MASK		= 0x1f << HCLK_VIO_DIV_CON_SHIFT,
+
+	/* CRU_CLK_SEL39_CON */
+	ACLK_VOP_PLL_SEL_CPLL		= 0,
+	ACLK_VOP_PLL_SEL_GPLL		= 1,
+	ACLK_VOP_PLL_SEL_HDMIPHY	= 2,
+	ACLK_VOP_PLL_SEL_USB480M	= 3,
+	ACLK_VOP_PLL_SEL_SHIFT		= 6,
+	ACLK_VOP_PLL_SEL_MASK		= 3 << ACLK_VOP_PLL_SEL_SHIFT,
+	ACLK_VOP_DIV_CON_SHIFT		= 0,
+	ACLK_VOP_DIV_CON_MASK		= 0x1f << ACLK_VOP_DIV_CON_SHIFT,
+
+	/* CRU_CLK_SEL40_CON */
+	DCLK_LCDC_PLL_SEL_GPLL		= 0,
+	DCLK_LCDC_PLL_SEL_CPLL		= 1,
+	DCLK_LCDC_PLL_SEL_SHIFT		= 0,
+	DCLK_LCDC_PLL_SEL_MASK		= 1 << DCLK_LCDC_PLL_SEL_SHIFT,
+	DCLK_LCDC_SEL_HDMIPHY		= 0,
+	DCLK_LCDC_SEL_PLL		= 1,
+	DCLK_LCDC_SEL_SHIFT		= 1,
+	DCLK_LCDC_SEL_MASK		= 1 << DCLK_LCDC_SEL_SHIFT,
+	DCLK_LCDC_DIV_CON_SHIFT		= 8,
+	DCLK_LCDC_DIV_CON_MASK		= 0xFf << DCLK_LCDC_DIV_CON_SHIFT,
 };
 
 void rk3328_configure_cpu(struct rk3328_cru *cru,
diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index ef97381f0e..ee7edb9d10 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -581,6 +581,86 @@ static ulong rk3328_spi_set_clk(struct rk3328_cru *cru, uint hz)
 	return rk3328_spi_get_clk(cru);
 }
 
+#ifndef CONFIG_SPL_BUILD
+static ulong rk3328_vop_get_clk(struct rk3328_clk_priv *priv, ulong clk_id)
+{
+	struct rk3328_cru *cru = priv->cru;
+	u32 div, con, parent;
+
+	switch (clk_id) {
+	case ACLK_VOP_PRE:
+		con = readl(&cru->clksel_con[39]);
+		div = (con & ACLK_VOP_DIV_CON_MASK) >> ACLK_VOP_DIV_CON_SHIFT;
+		parent = GPLL_HZ;
+		break;
+	case ACLK_VIO_PRE:
+		con = readl(&cru->clksel_con[37]);
+		div = (con & ACLK_VIO_DIV_CON_MASK) >> ACLK_VIO_DIV_CON_SHIFT;
+		parent = GPLL_HZ;
+		break;
+	case DCLK_LCDC:
+		con = readl(&cru->clksel_con[40]);
+		div = (con & DCLK_LCDC_DIV_CON_MASK) >> DCLK_LCDC_DIV_CON_SHIFT;
+		parent = GPLL_HZ;
+		break;
+	default:
+		printf("%s: Unsupported vop get clk#%ld\n", __func__, clk_id);
+		return -ENOENT;
+	}
+
+	return DIV_TO_RATE(parent, div);
+}
+
+static ulong rk3328_vop_set_clk(struct rk3328_clk_priv *priv,
+				ulong clk_id, uint hz)
+{
+	struct rk3328_cru *cru = priv->cru;
+	int src_clk_div;
+	u32 con, parent;
+
+	src_clk_div = DIV_ROUND_UP(GPLL_HZ, hz);
+	assert(src_clk_div - 1 < 31);
+
+	switch (clk_id) {
+	case ACLK_VOP_PRE:
+		rk_clrsetreg(&cru->clksel_con[39],
+			     ACLK_VOP_PLL_SEL_MASK | ACLK_VOP_DIV_CON_MASK,
+			     ACLK_VOP_PLL_SEL_CPLL << ACLK_VOP_PLL_SEL_SHIFT |
+			     (src_clk_div - 1) << ACLK_VOP_DIV_CON_SHIFT);
+		break;
+	case ACLK_VIO_PRE:
+		rk_clrsetreg(&cru->clksel_con[37],
+			     ACLK_VIO_PLL_SEL_MASK | ACLK_VIO_DIV_CON_MASK,
+			     ACLK_VIO_PLL_SEL_CPLL << ACLK_VIO_PLL_SEL_SHIFT |
+			     (src_clk_div - 1) << ACLK_VIO_DIV_CON_SHIFT);
+		break;
+	case DCLK_LCDC:
+		con = readl(&cru->clksel_con[40]);
+		con = (con & DCLK_LCDC_SEL_MASK) >> DCLK_LCDC_SEL_SHIFT;
+		if (con) {
+			parent = readl(&cru->clksel_con[40]);
+			parent = (parent & DCLK_LCDC_PLL_SEL_MASK) >>
+				 DCLK_LCDC_PLL_SEL_SHIFT;
+			if (parent)
+				src_clk_div = DIV_ROUND_UP(GPLL_HZ, hz);
+			else
+				src_clk_div = DIV_ROUND_UP(GPLL_HZ, hz);
+
+			rk_clrsetreg(&cru->clksel_con[40],
+				     DCLK_LCDC_DIV_CON_MASK,
+				     (src_clk_div - 1) <<
+				     DCLK_LCDC_DIV_CON_SHIFT);
+		}
+		break;
+	default:
+		printf("%s: Unable to set vop clk#%ld\n", __func__, clk_id);
+		return -EINVAL;
+	}
+
+	return rk3328_vop_get_clk(priv, clk_id);
+}
+#endif
+
 static ulong rk3328_clk_get_rate(struct clk *clk)
 {
 	struct rk3328_clk_priv *priv = dev_get_priv(clk->dev);
@@ -649,7 +729,13 @@ static ulong rk3328_clk_set_rate(struct clk *clk, ulong rate)
 	case SCLK_SPI:
 		ret = rk3328_spi_set_clk(priv->cru, rate);
 		break;
+#ifndef CONFIG_SPL_BUILD
 	case DCLK_LCDC:
+	case ACLK_VOP_PRE:
+	case ACLK_VIO_PRE:
+		rate = rk3328_vop_set_clk(priv, clk->id, rate);
+		break;
+#endif
 	case SCLK_PDM:
 	case SCLK_RTC32K:
 	case SCLK_UART0:
@@ -664,11 +750,9 @@ static ulong rk3328_clk_set_rate(struct clk *clk, ulong rate)
 	case ACLK_PERI_PRE:
 	case HCLK_PERI:
 	case PCLK_PERI:
-	case ACLK_VIO_PRE:
 	case HCLK_VIO_PRE:
 	case ACLK_RGA_PRE:
 	case SCLK_RGA:
-	case ACLK_VOP_PRE:
 	case ACLK_RKVDEC_PRE:
 	case ACLK_RKVENC:
 	case ACLK_VPU_PRE:
-- 
2.25.1

