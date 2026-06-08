Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF2ACD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C51C28466E;
	Mon,  8 Jun 2026 15:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="giuqno2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D679884825; Mon,  8 Jun 2026 15:45:26 +0200 (CEST)
Received: from mail-m1052.netease.com (mail-m1052.netease.com [154.81.10.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FBD841C2
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from smtpclient.apple (unknown [59.56.83.5])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4187a3d76;
 Mon, 8 Jun 2026 21:45:19 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
Message-Id: <E152A6FF-DD90-458B-9AD1-46511C52F4A2@rock-chips.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] rockchip: clk: clk_rk3576: Add support for RK3576 GMAC
 25MHz clock output
Date: Mon, 8 Jun 2026 21:45:08 +0800
In-Reply-To: <20260504-rk3576-rgmii-refclk-v1-1-c6604a4b69ac@flipper.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Heiko Stuebner <heiko@sntech.de>, Lukasz Majewski <lukma@denx.de>,
 Yao Zi <me@ziyao.cc>, Jonas Karlman <jonas@kwiboo.se>,
 Peng Fan <peng.fan@nxp.com>
To: Alexey Charkov <alchark@flipper.net>
References: <20260504-rk3576-rgmii-refclk-v1-1-c6604a4b69ac@flipper.net>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-HM-Tid: 0a9ea77b0c0109cckunm36e357d334fcb4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0waVkweShoeGktMHh9OGlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlOQlVOTVVDSFVOWVdZFhoPEhUdFFlBWU9LSFVKS0lPT0
 9IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=giuqno2fkGSoHFrBVhaoQbusTqA3PaCyyhBLNe9KrYDVrezpEmDiMmNP+CtCbQHjBGMceDIsNCXXyLDtF81xu917453qUA+YBgmozPtV180HxO1q/INGhW7Z0o7UNocHA/dOPCzRoWd5N4kT7IAb7SdxUt2vcI0DhWRxa4J4eRU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=gEi6iWHMtvDuupUQiShF+zW+LurS4HeTyZ3f1NCRGWM=;
 h=date:mime-version:subject:message-id:from;
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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



> 2026=E5=B9=B45=E6=9C=884=E6=97=A5 21:45=EF=BC=8CAlexey Charkov =
<alchark@flipper.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Rockchip RK3576 SoC has two built-in GMACs which connect to external =
PHYs
> via RGMII interface. The RGMII link can be clocked by either the PHY =
or
> the SoC. When the SoC is the master, as is the case on the RK3576 =
EVB1,
> the output clock needs to be configured in the CRU.
>=20
> Add the respective logic for getting and setting the RGMII reference =
clock
> output for both GMAC0 and GMAC1.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com =
<mailto:kever.yang@rock-chips.com>>

Thanks,
- Kever
> ---
> arch/arm/include/asm/arch-rockchip/cru_rk3576.h | 14 +++++++
> drivers/clk/rockchip/clk_rk3576.c               | 50 =
+++++++++++++++++++++++++
> 2 files changed, 64 insertions(+)
>=20
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h =
b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
> index c51750beff28..fb77fbd7307a 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
> @@ -222,6 +222,20 @@ enum {
> 	REF_CLK0_OUT_PLL_DIV_SHIFT	=3D 0,
> 	REF_CLK0_OUT_PLL_DIV_MASK	=3D 0xff << =
REF_CLK0_OUT_PLL_DIV_SHIFT,
>=20
> +	/* CRU_CLK_SEL36_CON */
> +	CLK_REFCLKO25M_GMAC0_DIV_SHIFT	=3D 0,
> +	CLK_REFCLKO25M_GMAC0_DIV_MASK	=3D 0x7f << =
CLK_REFCLKO25M_GMAC0_DIV_SHIFT,
> +	CLK_REFCLKO25M_GMAC0_SEL_SHIFT	=3D 7,
> +	CLK_REFCLKO25M_GMAC0_SEL_MASK	=3D 1 << =
CLK_REFCLKO25M_GMAC0_SEL_SHIFT,
> +	CLK_REFCLKO25M_GMAC0_SEL_GPLL	=3D 0,
> +	CLK_REFCLKO25M_GMAC0_SEL_CPLL	=3D 1,
> +	CLK_REFCLKO25M_GMAC1_DIV_SHIFT	=3D 8,
> +	CLK_REFCLKO25M_GMAC1_DIV_MASK	=3D 0x7f << =
CLK_REFCLKO25M_GMAC1_DIV_SHIFT,
> +	CLK_REFCLKO25M_GMAC1_SEL_SHIFT	=3D 15,
> +	CLK_REFCLKO25M_GMAC1_SEL_MASK	=3D 1 << =
CLK_REFCLKO25M_GMAC1_SEL_SHIFT,
> +	CLK_REFCLKO25M_GMAC1_SEL_GPLL	=3D 0,
> +	CLK_REFCLKO25M_GMAC1_SEL_CPLL	=3D 1,
> +
> 	/* CRU_CLK_SEL55_CON */
> 	ACLK_BUS_ROOT_SEL_SHIFT		=3D 9,
> 	ACLK_BUS_ROOT_SEL_MASK		=3D 1 << =
ACLK_BUS_ROOT_SEL_SHIFT,
> diff --git a/drivers/clk/rockchip/clk_rk3576.c =
b/drivers/clk/rockchip/clk_rk3576.c
> index 1026af27ca13..5168196b14e8 100644
> --- a/drivers/clk/rockchip/clk_rk3576.c
> +++ b/drivers/clk/rockchip/clk_rk3576.c
> @@ -1549,6 +1549,24 @@ static ulong rk3576_gmac_get_clk(struct =
rk3576_clk_priv *priv, ulong clk_id)
> 		con =3D readl(&cru->clksel_con[31]);
> 		div =3D (con & CLK_GMAC1_125M_DIV_MASK) >> =
CLK_GMAC1_125M_DIV_SHIFT;
> 		return DIV_TO_RATE(priv->cpll_hz, div);
> +	case REFCLKO25M_GMAC0_OUT:
> +		con =3D readl(&cru->clksel_con[36]);
> +		div =3D (con & CLK_REFCLKO25M_GMAC0_DIV_MASK) >> =
CLK_REFCLKO25M_GMAC0_DIV_SHIFT;
> +		src =3D (con & CLK_REFCLKO25M_GMAC0_SEL_MASK) >> =
CLK_REFCLKO25M_GMAC0_SEL_SHIFT;
> +		if (src =3D=3D CLK_REFCLKO25M_GMAC0_SEL_CPLL)
> +			p_rate =3D priv->cpll_hz;
> +		else
> +			p_rate =3D priv->gpll_hz;
> +		return DIV_TO_RATE(p_rate, div);
> +	case REFCLKO25M_GMAC1_OUT:
> +		con =3D readl(&cru->clksel_con[36]);
> +		div =3D (con & CLK_REFCLKO25M_GMAC1_DIV_MASK) >> =
CLK_REFCLKO25M_GMAC1_DIV_SHIFT;
> +		src =3D (con & CLK_REFCLKO25M_GMAC1_SEL_MASK) >> =
CLK_REFCLKO25M_GMAC1_SEL_SHIFT;
> +		if (src =3D=3D CLK_REFCLKO25M_GMAC1_SEL_CPLL)
> +			p_rate =3D priv->cpll_hz;
> +		else
> +			p_rate =3D priv->gpll_hz;
> +		return DIV_TO_RATE(p_rate, div);
> 	default:
> 		return -ENOENT;
> 	}
> @@ -1608,6 +1626,34 @@ static ulong rk3576_gmac_set_clk(struct =
rk3576_clk_priv *priv,
> 			     CLK_GMAC1_125M_DIV_MASK,
> 			     (div - 1) << CLK_GMAC1_125M_DIV_SHIFT);
> 		break;
> +	case REFCLKO25M_GMAC0_OUT:
> +		if (!(priv->gpll_hz % rate)) {
> +			src =3D CLK_REFCLKO25M_GMAC0_SEL_GPLL;
> +			div =3D priv->gpll_hz / rate;
> +		} else {
> +			src =3D CLK_REFCLKO25M_GMAC0_SEL_CPLL;
> +			div =3D priv->cpll_hz / rate;
> +		}
> +		rk_clrsetreg(&cru->clksel_con[36],
> +			     CLK_REFCLKO25M_GMAC0_SEL_MASK |
> +			     CLK_REFCLKO25M_GMAC0_DIV_MASK,
> +			     src << CLK_REFCLKO25M_GMAC0_SEL_SHIFT |
> +			     (div - 1) << =
CLK_REFCLKO25M_GMAC0_DIV_SHIFT);
> +		break;
> +	case REFCLKO25M_GMAC1_OUT:
> +		if (!(priv->gpll_hz % rate)) {
> +			src =3D CLK_REFCLKO25M_GMAC1_SEL_GPLL;
> +			div =3D priv->gpll_hz / rate;
> +		} else {
> +			src =3D CLK_REFCLKO25M_GMAC1_SEL_CPLL;
> +			div =3D priv->cpll_hz / rate;
> +		}
> +		rk_clrsetreg(&cru->clksel_con[36],
> +			     CLK_REFCLKO25M_GMAC1_SEL_MASK |
> +			     CLK_REFCLKO25M_GMAC1_DIV_MASK,
> +			     src << CLK_REFCLKO25M_GMAC1_SEL_SHIFT |
> +			     (div - 1) << =
CLK_REFCLKO25M_GMAC1_DIV_SHIFT);
> +		break;
> 	default:
> 		return -ENOENT;
> 	}
> @@ -2014,6 +2060,8 @@ static ulong rk3576_clk_get_rate(struct clk =
*clk)
> 	case CLK_GMAC1_PTP_REF:
> 	case CLK_GMAC0_125M_SRC:
> 	case CLK_GMAC1_125M_SRC:
> +	case REFCLKO25M_GMAC0_OUT:
> +	case REFCLKO25M_GMAC1_OUT:
> 		rate =3D rk3576_gmac_get_clk(priv, clk->id);
> 		break;
> 	case CLK_UART_FRAC_0:
> @@ -2193,6 +2241,8 @@ static ulong rk3576_clk_set_rate(struct clk =
*clk, ulong rate)
> 	case CLK_GMAC1_PTP_REF:
> 	case CLK_GMAC0_125M_SRC:
> 	case CLK_GMAC1_125M_SRC:
> +	case REFCLKO25M_GMAC0_OUT:
> +	case REFCLKO25M_GMAC1_OUT:
> 		ret =3D rk3576_gmac_set_clk(priv, clk->id, rate);
> 		break;
> 	case CLK_UART_FRAC_0:
>=20
> ---
> base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
> change-id: 20260504-rk3576-rgmii-refclk-45d18a47be33
>=20
> Best regards,
> --=20
> Alexey Charkov <alchark@flipper.net>
>=20
>=20
>=20

