Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03048CD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E76784686;
	Mon,  4 May 2026 15:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="O36Poaxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799A98468A; Mon,  4 May 2026 15:45:19 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E7A8467F
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so61224775e9.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 06:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1777902317; x=1778507117; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YBNDJmTrxHIv7j/53bKFRxtruZ5ImNQMkl3pURX38jw=;
 b=O36PoaxwrvR3g9zfsBrGpNd+pgmKYF5KW2W8/gITVPjxMm6rnpFhKn7aBYTYnzJ1TV
 vgF+45Iwpy7ZN0595qJE3Mv8823DkRaD3z+SBf3CHcq+5vuIyvds3TkFzyDn1YN55rct
 p+bBrpA2qqMjV+x4+zLkALMcYyp0MtZktEvYdh3ou673okZ/0HEKVcXQ0YiayUPchUzA
 D6+pNJSytMRLFORtZI2kT5aFnpUiWOKlQUHxeeo4vwftd7knxEs6Z1JsnAcjChX5xPFd
 IZ7womdr8xY2FR6kxPbzmn1Jduc6iDrD0nMUpxIjEaO1yEYw9V3cRb7wzrYPzZqfj4R0
 I7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777902317; x=1778507117;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBNDJmTrxHIv7j/53bKFRxtruZ5ImNQMkl3pURX38jw=;
 b=XxYZgx4f4xnyrcl7GvU0n6yNNpjwR63ChwLZ26XNuZijKCtjA0Vw7CliLBqyvN6Fv6
 5zoBAk067SL8rGjIN1T4t8zG7iXT+gQOPpiExdGOozbG3ZSPRX+ZDI2ocGb6iWJ5c10/
 QdV0XVp/+Uz19OLGLasvqJlabhivBejAqINN9LB+M3oSVXSu0TCYPZDu1DlYJ4PUJk6B
 HDOVrAowZs/2xl7M7/cE+m0m++/f1l/cVuuoBUKilCf8R60JSwrWMlAn8bdfsI83Ava6
 49vWOvbRK+lwO06IGdY0RYtaGqiDn5DYVBdjT9bWQfZhn3hWMbgAQYKvYOI6Vk7G1h47
 baIQ==
X-Gm-Message-State: AOJu0YzyW8cN8KyESByuAvfCoX5+bLZm2W6dMOSTXMLUlX906OiiosEs
 Hl/ap18G4QLKD4CVQfWoPVSvdCN/yp21CCGW/iPXt4cBmgAENL1FzWnvWjTmZR5Hkbs=
X-Gm-Gg: AeBDieutKnFChxiaym/vk1H35DGhLIgkQUt9MZs3f6Mlk2SfdVu4L5g+X113BWju+ks
 OS2XmaKx0Fh8OkQdONjmsQKslL1K/eWBAO86GOKVaf8Hl1VqDqG/nkTV9HXp+PTmAjUZt0aMKCm
 MvmR/Qd7k8aSIBKGavJ+tAFjUh2FZZpu2MhxlovDAWFDjgowSQLLaMGVz3GOWu7iqqXawaP1Sdl
 4hPx2Uf0ENZOYBeEa0oFrAtTPXoINr7o5vPbPFzyvbQ5WN/rpnPE6ErnGUALFkT0qd6k29iDh+b
 vtu+CGCp4exeq7Gq0YsJCKIAysON4bIBkJuzi3DKrzZ9N4DQmEtL7uTwdyoeM4UY1HGHMY9MFvK
 470P4oX5lzKKA3G9zWDYFWtAF7k7A4I+16QYqxaIW5TDPYcEVoUxRhx97opYUhVkI/zzxqMP4/z
 cgR3F5bdCuBAOwLt43GTgT5eSSCiyeWFazmkPcoWQpvY0OC7X3rNADFLMdvGffOLMQtvwfpk7mt
 Ji62JZNDGInrhLE
X-Received: by 2002:a05:600c:1386:b0:488:9e54:94c0 with SMTP id
 5b1f17b1804b1-48a985391a3mr160661995e9.8.1777902316747; 
 Mon, 04 May 2026 06:45:16 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae.
 [86.98.192.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb6fffcsm290303595e9.4.2026.05.04.06.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 06:45:16 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 04 May 2026 17:45:08 +0400
Subject: [PATCH] rockchip: clk: clk_rk3576: Add support for RK3576 GMAC
 25MHz clock output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-rk3576-rgmii-refclk-v1-1-c6604a4b69ac@flipper.net>
X-B4-Tracking: v=1; b=H4sIAOOi+GkC/x2MSQqAMAwAvyI5G6h2UfyKeKg2anAlBRHEv1s8z
 sDMA5GEKUKTPSB0ceRjT1DkGQyz3ydCDomhVKVTVhmURdvKoUwbMwqNw7qgsaGoval60hpSeSb
 P939tu/f9AFBMqpNlAAAA
X-Change-ID: 20260504-rk3576-rgmii-refclk-45d18a47be33
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Heiko Stuebner <heiko@sntech.de>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@denx.de>, Yao Zi <me@ziyao.cc>, 
 Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5003; i=alchark@flipper.net;
 h=from:subject:message-id; bh=9SNm0RTwfQk2KMdUys73Ndv6Waj5HEo9utl0zVxQoQM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT+WPRWRdj+2cSbf/t/vhdkFAxj/J/FJ+bb5VPDmfvg4
 eo12wxlOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhquTyG/wWzQ0p7/3cpnt82b9KGmu/f7eu+bLE/IxDXU5A6Y2upUzbDX7n7vsx
 f2yru/7E4enFp48y913l4tUvMvhbPdLVv5TvymxEA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Rockchip RK3576 SoC has two built-in GMACs which connect to external PHYs
via RGMII interface. The RGMII link can be clocked by either the PHY or
the SoC. When the SoC is the master, as is the case on the RK3576 EVB1,
the output clock needs to be configured in the CRU.

Add the respective logic for getting and setting the RGMII reference clock
output for both GMAC0 and GMAC1.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h | 14 +++++++
 drivers/clk/rockchip/clk_rk3576.c               | 50 +++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
index c51750beff28..fb77fbd7307a 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
@@ -222,6 +222,20 @@ enum {
 	REF_CLK0_OUT_PLL_DIV_SHIFT	= 0,
 	REF_CLK0_OUT_PLL_DIV_MASK	= 0xff << REF_CLK0_OUT_PLL_DIV_SHIFT,
 
+	/* CRU_CLK_SEL36_CON */
+	CLK_REFCLKO25M_GMAC0_DIV_SHIFT	= 0,
+	CLK_REFCLKO25M_GMAC0_DIV_MASK	= 0x7f << CLK_REFCLKO25M_GMAC0_DIV_SHIFT,
+	CLK_REFCLKO25M_GMAC0_SEL_SHIFT	= 7,
+	CLK_REFCLKO25M_GMAC0_SEL_MASK	= 1 << CLK_REFCLKO25M_GMAC0_SEL_SHIFT,
+	CLK_REFCLKO25M_GMAC0_SEL_GPLL	= 0,
+	CLK_REFCLKO25M_GMAC0_SEL_CPLL	= 1,
+	CLK_REFCLKO25M_GMAC1_DIV_SHIFT	= 8,
+	CLK_REFCLKO25M_GMAC1_DIV_MASK	= 0x7f << CLK_REFCLKO25M_GMAC1_DIV_SHIFT,
+	CLK_REFCLKO25M_GMAC1_SEL_SHIFT	= 15,
+	CLK_REFCLKO25M_GMAC1_SEL_MASK	= 1 << CLK_REFCLKO25M_GMAC1_SEL_SHIFT,
+	CLK_REFCLKO25M_GMAC1_SEL_GPLL	= 0,
+	CLK_REFCLKO25M_GMAC1_SEL_CPLL	= 1,
+
 	/* CRU_CLK_SEL55_CON */
 	ACLK_BUS_ROOT_SEL_SHIFT		= 9,
 	ACLK_BUS_ROOT_SEL_MASK		= 1 << ACLK_BUS_ROOT_SEL_SHIFT,
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 1026af27ca13..5168196b14e8 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -1549,6 +1549,24 @@ static ulong rk3576_gmac_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
 		con = readl(&cru->clksel_con[31]);
 		div = (con & CLK_GMAC1_125M_DIV_MASK) >> CLK_GMAC1_125M_DIV_SHIFT;
 		return DIV_TO_RATE(priv->cpll_hz, div);
+	case REFCLKO25M_GMAC0_OUT:
+		con = readl(&cru->clksel_con[36]);
+		div = (con & CLK_REFCLKO25M_GMAC0_DIV_MASK) >> CLK_REFCLKO25M_GMAC0_DIV_SHIFT;
+		src = (con & CLK_REFCLKO25M_GMAC0_SEL_MASK) >> CLK_REFCLKO25M_GMAC0_SEL_SHIFT;
+		if (src == CLK_REFCLKO25M_GMAC0_SEL_CPLL)
+			p_rate = priv->cpll_hz;
+		else
+			p_rate = priv->gpll_hz;
+		return DIV_TO_RATE(p_rate, div);
+	case REFCLKO25M_GMAC1_OUT:
+		con = readl(&cru->clksel_con[36]);
+		div = (con & CLK_REFCLKO25M_GMAC1_DIV_MASK) >> CLK_REFCLKO25M_GMAC1_DIV_SHIFT;
+		src = (con & CLK_REFCLKO25M_GMAC1_SEL_MASK) >> CLK_REFCLKO25M_GMAC1_SEL_SHIFT;
+		if (src == CLK_REFCLKO25M_GMAC1_SEL_CPLL)
+			p_rate = priv->cpll_hz;
+		else
+			p_rate = priv->gpll_hz;
+		return DIV_TO_RATE(p_rate, div);
 	default:
 		return -ENOENT;
 	}
@@ -1608,6 +1626,34 @@ static ulong rk3576_gmac_set_clk(struct rk3576_clk_priv *priv,
 			     CLK_GMAC1_125M_DIV_MASK,
 			     (div - 1) << CLK_GMAC1_125M_DIV_SHIFT);
 		break;
+	case REFCLKO25M_GMAC0_OUT:
+		if (!(priv->gpll_hz % rate)) {
+			src = CLK_REFCLKO25M_GMAC0_SEL_GPLL;
+			div = priv->gpll_hz / rate;
+		} else {
+			src = CLK_REFCLKO25M_GMAC0_SEL_CPLL;
+			div = priv->cpll_hz / rate;
+		}
+		rk_clrsetreg(&cru->clksel_con[36],
+			     CLK_REFCLKO25M_GMAC0_SEL_MASK |
+			     CLK_REFCLKO25M_GMAC0_DIV_MASK,
+			     src << CLK_REFCLKO25M_GMAC0_SEL_SHIFT |
+			     (div - 1) << CLK_REFCLKO25M_GMAC0_DIV_SHIFT);
+		break;
+	case REFCLKO25M_GMAC1_OUT:
+		if (!(priv->gpll_hz % rate)) {
+			src = CLK_REFCLKO25M_GMAC1_SEL_GPLL;
+			div = priv->gpll_hz / rate;
+		} else {
+			src = CLK_REFCLKO25M_GMAC1_SEL_CPLL;
+			div = priv->cpll_hz / rate;
+		}
+		rk_clrsetreg(&cru->clksel_con[36],
+			     CLK_REFCLKO25M_GMAC1_SEL_MASK |
+			     CLK_REFCLKO25M_GMAC1_DIV_MASK,
+			     src << CLK_REFCLKO25M_GMAC1_SEL_SHIFT |
+			     (div - 1) << CLK_REFCLKO25M_GMAC1_DIV_SHIFT);
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -2014,6 +2060,8 @@ static ulong rk3576_clk_get_rate(struct clk *clk)
 	case CLK_GMAC1_PTP_REF:
 	case CLK_GMAC0_125M_SRC:
 	case CLK_GMAC1_125M_SRC:
+	case REFCLKO25M_GMAC0_OUT:
+	case REFCLKO25M_GMAC1_OUT:
 		rate = rk3576_gmac_get_clk(priv, clk->id);
 		break;
 	case CLK_UART_FRAC_0:
@@ -2193,6 +2241,8 @@ static ulong rk3576_clk_set_rate(struct clk *clk, ulong rate)
 	case CLK_GMAC1_PTP_REF:
 	case CLK_GMAC0_125M_SRC:
 	case CLK_GMAC1_125M_SRC:
+	case REFCLKO25M_GMAC0_OUT:
+	case REFCLKO25M_GMAC1_OUT:
 		ret = rk3576_gmac_set_clk(priv, clk->id, rate);
 		break;
 	case CLK_UART_FRAC_0:

---
base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
change-id: 20260504-rk3576-rgmii-refclk-45d18a47be33

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>

