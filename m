Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B49DC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 10:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3BE0878B4;
	Tue,  5 Dec 2023 11:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="m7Y5dOFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B6898784C; Tue,  5 Dec 2023 11:38:20 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7996C86F26
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 11:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3332f1512e8so3681269f8f.2
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 02:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701772697; x=1702377497;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/0CBAo4/I2cR285taWcSChAx342SpKwYXiwx0zr0P2Y=;
 b=m7Y5dOFMIX8TdllPvMRZ8b8dX5f/CJFIKPGLR3WV8pJht7AgpWVDckoUPC+6Ren5Eo
 H+OyYfmqiT/QoOwzdUGbE+eLSfVjonzZWXBDBHviuVf2JeiV0pRERe+fV/0ICr1UwATd
 Gdtb504aVp2e91gwqqHOMeLfpgGnvnpaxleFdBsktHlJXZc4T1YQJ69taDQ2Q1opi7bu
 iGh7JsCfO9XDYxIWbmT7SeVNiaQaNhZzInySpvJPnj/mx7TZ2IyHxX4g0gB9cU66PSBb
 1ogTy+ssvjwt09IsvDaO5KKvtBg9XjR43x6ZmmhYGpOeIfEMwexaV9jYz/s2H27uNpvd
 lskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701772697; x=1702377497;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/0CBAo4/I2cR285taWcSChAx342SpKwYXiwx0zr0P2Y=;
 b=m/2nRyiaaDMKpyJ/eS0fVgEkDSSoYy4UdFnGKY2GwoXletW0TOk6DetpezxZFIBj75
 WLepwzEo8wbtV1Up76bOuuj6MHqxyllGOz4LA0GaEQg3YC3jPao0eEI9VyLXOCkhqhZW
 t+mkE0T9CQu6cFKAwUwuaOrK7oe/fX4HXCXMaL8ExPK1gwV27Pgj4g2AMYCU0OcWRlKr
 lO24TQgfJ5HY2M03LjwIDLqAjG26NdYyGMHcYLrcmPYz333EOgZITCVRNzx4hOU7Lgry
 QjufWiotgB3chBfB9sMbRjn+LLo1ZjsB2XyHGssky7+gYnIxOtOdi//BEoaCv2tklRf9
 JR3w==
X-Gm-Message-State: AOJu0Yy38BgQow5Q3SEEhSQQz81hHWtcCUqtdEEnws+RLcx9Hx7FvtcY
 lG4k1E67qZb92BL50uE+AqAZNQ==
X-Google-Smtp-Source: AGHT+IFBjPhXgwcL7wrePj7cFGtJUWJM35nH3MP4P9L/elTmk3Yy+Mj6lXOCQlhSvTrFEFWzv1FCTA==
X-Received: by 2002:adf:fa50:0:b0:333:381d:6a26 with SMTP id
 y16-20020adffa50000000b00333381d6a26mr2725741wrr.135.1701772696814; 
 Tue, 05 Dec 2023 02:38:16 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 q18-20020a05600000d200b003334041c3edsm7429746wrx.41.2023.12.05.02.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 02:38:16 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Sean Anderson <seanga2@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Vitor Sato Eschholz <vsatoes@baylibre.com>
Subject: Re: [PATCH 2/6] clk: mediatek: add clock driver support for
 MediaTek MT8365 SoC
In-Reply-To: <87msuq450r.fsf@baylibre.com>
References: <87plzm450u.fsf@baylibre.com> <87msuq450r.fsf@baylibre.com>
Date: Tue, 05 Dec 2023 11:38:15 +0100
Message-ID: <87fs0hylwo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Julien,

Thank you for your patch.

On lun., d=C3=A9c. 04, 2023 at 11:48, Julien Masson <jmasson@baylibre.com> =
wrote:

> This patch adds clock driver support for MediaTek MT8365 SoC.
> The changes are based on the Linux source code tag v6.7-rc2.
>
> clk-mt8365.c has been written based on these kernel files:
> - clk-mt8365.c (a96cbb146a9736f501fe66ebda6a9018735e5e8a)
> - clk-mt8365-apmixedsys.c (65c9ad77cbc0eed78db94d80041aba675cfbdfa9)
> And adapted following the clk attributes supported by U-Boot.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/clk/mediatek/Makefile     |   1 +
>  drivers/clk/mediatek/clk-mt8365.c | 766 ++++++++++++++++++++++++++++++
>  2 files changed, 767 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8365.c
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index e74c6f9780..e631f79e4d 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -11,5 +11,6 @@ obj-$(CONFIG_TARGET_MT7986) +=3D clk-mt7986.o
>  obj-$(CONFIG_TARGET_MT7981) +=3D clk-mt7981.o
>  obj-$(CONFIG_TARGET_MT7988) +=3D clk-mt7988.o
>  obj-$(CONFIG_TARGET_MT8183) +=3D clk-mt8183.o
> +obj-$(CONFIG_TARGET_MT8365) +=3D clk-mt8365.o
>  obj-$(CONFIG_TARGET_MT8516) +=3D clk-mt8516.o
>  obj-$(CONFIG_TARGET_MT8518) +=3D clk-mt8518.o
> diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk=
-mt8365.c
> new file mode 100644
> index 0000000000..61ccd4a210
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8365.c
> @@ -0,0 +1,766 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MediaTek clock driver for MT8365 SoC
> + *
> + * Copyright (C) 2023 BayLibre, SAS
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Julien Masson <jmasson@baylibre.com>
> + * Author: Fabien Parent <fparent@baylibre.com>
> + * Author: Weiyi Lu <weiyi.lu@mediatek.com>
> + */
> +
> +#include <dm.h>
> +#include <dt-bindings/clock/mediatek,mt8365-clk.h>
> +#include "clk-mtk.h"
> +
> +/* apmixedsys */
> +#define MT8365_PLL_FMAX		(3800UL * MHZ)
> +#define MT8365_PLL_FMIN		(1500UL * MHZ)
> +#define CON0_MT8365_RST_BAR	BIT(23)
> +#define PLL_AO			BIT(1)
> +
> +#define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,	  =
  \
> +	    _pd_shift, _pcw_reg, _pcw_shift, _rst_bar_mask, _pcw_chg_reg) { \
> +		.id =3D _id,						    \
> +		.reg =3D _reg,						    \
> +		.pwr_reg =3D _pwr_reg,					    \
> +		.en_mask =3D _en_mask,					    \
> +		.pd_reg =3D _pd_reg,					    \
> +		.pd_shift =3D _pd_shift,					    \
> +		.flags =3D _flags,					    \
> +		.rst_bar_mask =3D _rst_bar_mask,				    \
> +		.fmax =3D MT8365_PLL_FMAX,				    \
> +		.fmin =3D MT8365_PLL_FMIN,				    \
> +		.pcwbits =3D _pcwbits,					    \
> +		.pcwibits =3D 8,						    \
> +		.pcw_reg =3D _pcw_reg,					    \
> +		.pcw_shift =3D _pcw_shift,				    \
> +		.pcw_chg_reg =3D _pcw_chg_reg,				    \
> +	}
> +
> +static const struct mtk_pll_data apmixed_plls[] =3D {
> +	PLL(CLK_APMIXED_ARMPLL, 0x030C, 0x0318, 0x00000001, PLL_AO, 22, 0x0310,
> +	    24, 0x0310, 0, 0, 0),
> +	PLL(CLK_APMIXED_MAINPLL, 0x0228, 0x0234, 0xFF000001, HAVE_RST_BAR, 22,
> +	    0x022C, 24, 0x022C, 0, CON0_MT8365_RST_BAR, 0),
> +	PLL(CLK_APMIXED_UNIVPLL, 0x0208, 0x0214, 0xFF000001, HAVE_RST_BAR, 22,
> +	    0x020C, 24, 0x020C, 0, CON0_MT8365_RST_BAR, 0),
> +	PLL(CLK_APMIXED_MFGPLL, 0x0218, 0x0224, 0x00000001, 0, 22, 0x021C, 24,
> +	    0x021C, 0, 0, 0),
> +	PLL(CLK_APMIXED_MSDCPLL, 0x0350, 0x035C, 0x00000001, 0, 22, 0x0354, 24,
> +	    0x0354, 0, 0, 0),
> +	PLL(CLK_APMIXED_MMPLL, 0x0330, 0x033C, 0x00000001, 0, 22, 0x0334, 24,
> +	    0x0334, 0, 0, 0),
> +	PLL(CLK_APMIXED_APLL1, 0x031C, 0x032C, 0x00000001, 0, 32, 0x0320, 24,
> +	    0x0324, 0, 0, 0x0320),
> +	PLL(CLK_APMIXED_APLL2, 0x0360, 0x0370, 0x00000001, 0, 32, 0x0364, 24,
> +	    0x0368, 0, 0, 0x0364),
> +	PLL(CLK_APMIXED_LVDSPLL, 0x0374, 0x0380, 0x00000001, 0, 22, 0x0378, 24,
> +	    0x0378, 0, 0, 0),
> +	PLL(CLK_APMIXED_DSPPLL, 0x0390, 0x039C, 0x00000001, 0, 22, 0x0394, 24,
> +	    0x0394, 0, 0, 0),
> +	PLL(CLK_APMIXED_APUPLL, 0x03A0, 0x03AC, 0x00000001, 0, 22, 0x03A4, 24,
> +	    0x03A4, 0, 0, 0),
> +};
> +
> +/* topckgen */
> +static const struct mtk_fixed_clk top_fixed_clks[] =3D {
> +	FIXED_CLK(CLK_TOP_CLK_NULL, CLK_XTAL, 0),
> +	FIXED_CLK(CLK_TOP_I2S0_BCK, CLK_XTAL, 26000000),
> +	FIXED_CLK(CLK_TOP_DSI0_LNTC_DSICK, CLK_TOP_CLK26M, 75000000),
> +	FIXED_CLK(CLK_TOP_VPLL_DPIX, CLK_TOP_CLK26M, 75000000),
> +	FIXED_CLK(CLK_TOP_LVDSTX_CLKDIG_CTS, CLK_TOP_CLK26M, 52500000),
> +};
> +
> +#define PLL_FACTOR(_id, _name, _parent, _mult, _div)			\
> +	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
> +
> +static const struct mtk_fixed_factor top_divs[] =3D {
> +	PLL_FACTOR(CLK_TOP_SYS_26M_D2, "sys_26m_d2", CLK_XTAL, 1, 2),
> +	PLL_FACTOR(CLK_TOP_SYSPLL_D2, "syspll_d2", CLK_APMIXED_MAINPLL, 1, 2),
> +	PLL_FACTOR(CLK_TOP_SYSPLL1_D2, "syspll1_d2", CLK_APMIXED_MAINPLL, 1, 4),
> +	PLL_FACTOR(CLK_TOP_SYSPLL1_D4, "syspll1_d4", CLK_APMIXED_MAINPLL, 1, 8),
> +	PLL_FACTOR(CLK_TOP_SYSPLL1_D8, "syspll1_d8", CLK_APMIXED_MAINPLL, 1, 16=
),
> +	PLL_FACTOR(CLK_TOP_SYSPLL1_D16, "syspll1_d16", CLK_APMIXED_MAINPLL, 1, =
32),
> +	PLL_FACTOR(CLK_TOP_SYSPLL_D3, "syspll_d3", CLK_APMIXED_MAINPLL, 1, 3),
> +	PLL_FACTOR(CLK_TOP_SYSPLL2_D2, "syspll2_d2", CLK_APMIXED_MAINPLL, 1, 6),
> +	PLL_FACTOR(CLK_TOP_SYSPLL2_D4, "syspll2_d4", CLK_APMIXED_MAINPLL, 1, 12=
),
> +	PLL_FACTOR(CLK_TOP_SYSPLL2_D8, "syspll2_d8", CLK_APMIXED_MAINPLL, 1, 24=
),
> +	PLL_FACTOR(CLK_TOP_SYSPLL_D5, "syspll_d5", CLK_APMIXED_MAINPLL, 1, 5),
> +	PLL_FACTOR(CLK_TOP_SYSPLL3_D2, "syspll3_d2", CLK_APMIXED_MAINPLL, 1, 10=
),
> +	PLL_FACTOR(CLK_TOP_SYSPLL3_D4, "syspll3_d4", CLK_APMIXED_MAINPLL, 1, 20=
),
> +	PLL_FACTOR(CLK_TOP_SYSPLL_D7, "syspll_d7", CLK_APMIXED_MAINPLL, 1, 7),
> +	PLL_FACTOR(CLK_TOP_SYSPLL4_D2, "syspll4_d2", CLK_APMIXED_MAINPLL, 1, 14=
),
> +	PLL_FACTOR(CLK_TOP_SYSPLL4_D4, "syspll4_d4", CLK_APMIXED_MAINPLL, 1, 28=
),
> +	PLL_FACTOR(CLK_TOP_UNIVPLL, "univpll", CLK_APMIXED_UNIV_EN, 1, 2),
> +	PLL_FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", CLK_APMIXED_UNIVPLL, 1, 2),
> +	PLL_FACTOR(CLK_TOP_UNIVPLL1_D2, "univpll1_d2", CLK_APMIXED_UNIVPLL, 1, =
4),
> +	PLL_FACTOR(CLK_TOP_UNIVPLL1_D4, "univpll1_d4", CLK_APMIXED_UNIVPLL, 1, =
8),
> +	PLL_FACTOR(CLK_TOP_UNIVPLL_D3, "univpll_d3", CLK_APMIXED_UNIVPLL, 1, 3),
> +	PLL_FACTOR(CLK_TOP_UNIVPLL2_D2, "univpll2_d2", CLK_APMIXED_UNIVPLL, 1, =
6),
> +	PLL_FACTOR(CLK_TOP_UNIVPLL2_D4, "univpll2_d4", CLK_APMIXED_UNIVPLL, 1, =
12),
> +	PLL_FACTOR(CLK_TOP_UNIVPLL2_D8, "univpll2_d8", CLK_APMIXED_UNIVPLL, 1, =
24),
> +	PLL_FACTOR(CLK_TOP_UNIVPLL2_D32, "univpll2_d32", CLK_APMIXED_UNIVPLL, 1=
, 96),
> +	PLL_FACTOR(CLK_TOP_UNIVPLL_D5, "univpll_d5", CLK_APMIXED_UNIVPLL, 1, 5),
> +	PLL_FACTOR(CLK_TOP_UNIVPLL3_D2, "univpll3_d2", CLK_APMIXED_UNIVPLL, 1, =
10),
> +	PLL_FACTOR(CLK_TOP_UNIVPLL3_D4, "univpll3_d4", CLK_APMIXED_UNIVPLL, 1, =
20),
> +	PLL_FACTOR(CLK_TOP_MMPLL, "mmpll_ck", CLK_APMIXED_MMPLL, 1, 1),
> +	PLL_FACTOR(CLK_TOP_MMPLL_D2, "mmpll_d2", CLK_APMIXED_MMPLL, 1, 2),
> +	PLL_FACTOR(CLK_TOP_MFGPLL, "mfgpll_ck", CLK_APMIXED_MFGPLL, 1, 1),
> +	PLL_FACTOR(CLK_TOP_LVDSPLL_D2, "lvdspll_d2", CLK_APMIXED_LVDSPLL, 1, 2),
> +	PLL_FACTOR(CLK_TOP_LVDSPLL_D4, "lvdspll_d4", CLK_APMIXED_LVDSPLL, 1, 4),
> +	PLL_FACTOR(CLK_TOP_LVDSPLL_D8, "lvdspll_d8", CLK_APMIXED_LVDSPLL, 1, 8),
> +	PLL_FACTOR(CLK_TOP_LVDSPLL_D16, "lvdspll_d16", CLK_APMIXED_LVDSPLL, 1, =
16),
> +	PLL_FACTOR(CLK_TOP_USB20_192M, "usb20_192m_ck", CLK_APMIXED_USB20_EN, 1=
, 13),
> +	PLL_FACTOR(CLK_TOP_USB20_192M_D4, "usb20_192m_d4", CLK_TOP_USB20_192M, =
1, 4),
> +	PLL_FACTOR(CLK_TOP_USB20_192M_D8, "usb20_192m_d8", CLK_TOP_USB20_192M, =
1, 8),
> +	PLL_FACTOR(CLK_TOP_USB20_192M_D16, "usb20_192m_d16", CLK_TOP_USB20_192M=
, 1, 16),
> +	PLL_FACTOR(CLK_TOP_USB20_192M_D32, "usb20_192m_d32", CLK_TOP_USB20_192M=
, 1, 32),
> +	PLL_FACTOR(CLK_TOP_APLL1, "apll1_ck", CLK_APMIXED_APLL1, 1, 1),
> +	PLL_FACTOR(CLK_TOP_APLL1_D2, "apll1_d2", CLK_APMIXED_APLL1, 1, 2),
> +	PLL_FACTOR(CLK_TOP_APLL1_D4, "apll1_d4", CLK_APMIXED_APLL1, 1, 4),
> +	PLL_FACTOR(CLK_TOP_APLL1_D8, "apll1_d8", CLK_APMIXED_APLL1, 1, 8),
> +	PLL_FACTOR(CLK_TOP_APLL2, "apll2_ck", CLK_APMIXED_APLL2, 1, 1),
> +	PLL_FACTOR(CLK_TOP_APLL2_D2, "apll2_d2", CLK_APMIXED_APLL2, 1, 2),
> +	PLL_FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", CLK_APMIXED_APLL2, 1, 4),
> +	PLL_FACTOR(CLK_TOP_APLL2_D8, "apll2_d8", CLK_APMIXED_APLL2, 1, 8),
> +	PLL_FACTOR(CLK_TOP_MSDCPLL, "msdcpll_ck", CLK_APMIXED_MSDCPLL, 1, 1),
> +	PLL_FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", CLK_APMIXED_MSDCPLL, 1, 2),
> +	PLL_FACTOR(CLK_TOP_DSPPLL, "dsppll_ck", CLK_APMIXED_DSPPLL, 1, 1),
> +	PLL_FACTOR(CLK_TOP_DSPPLL_D2, "dsppll_d2", CLK_APMIXED_DSPPLL, 1, 2),
> +	PLL_FACTOR(CLK_TOP_DSPPLL_D4, "dsppll_d4", CLK_APMIXED_DSPPLL, 1, 4),
> +	PLL_FACTOR(CLK_TOP_DSPPLL_D8, "dsppll_d8", CLK_APMIXED_DSPPLL, 1, 8),
> +	PLL_FACTOR(CLK_TOP_APUPLL, "apupll_ck", CLK_APMIXED_APUPLL, 1, 1),
> +	PLL_FACTOR(CLK_TOP_CLK26M_D52, "clk26m_d52", CLK_XTAL, 1, 52),
> +};
> +
> +static const int axi_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_SYSPLL_D7,
> +	CLK_TOP_SYSPLL1_D4,
> +	CLK_TOP_SYSPLL3_D2
> +};
> +
> +static const int mem_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_MMPLL,
> +	CLK_TOP_SYSPLL_D3,
> +	CLK_TOP_SYSPLL1_D2
> +};
> +
> +static const int mm_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_MMPLL,
> +	CLK_TOP_SYSPLL1_D2,
> +	CLK_TOP_SYSPLL_D5,
> +	CLK_TOP_SYSPLL1_D4,
> +	CLK_TOP_UNIVPLL_D5,
> +	CLK_TOP_UNIVPLL1_D2,
> +	CLK_TOP_MMPLL_D2,
> +};
> +
> +static const int scp_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_SYSPLL4_D2,
> +	CLK_TOP_UNIVPLL2_D2,
> +	CLK_TOP_SYSPLL1_D2,
> +	CLK_TOP_UNIVPLL1_D2,
> +	CLK_TOP_SYSPLL_D3,
> +	CLK_TOP_UNIVPLL_D3
> +};
> +
> +static const int mfg_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_MFGPLL,
> +	CLK_TOP_SYSPLL_D3,
> +	CLK_TOP_UNIVPLL_D3
> +};
> +
> +static const int atb_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_SYSPLL1_D4,
> +	CLK_TOP_SYSPLL1_D2
> +};
> +
> +static const int camtg_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_USB20_192M_D8,
> +	CLK_TOP_UNIVPLL2_D8,
> +	CLK_TOP_USB20_192M_D4,
> +	CLK_TOP_UNIVPLL2_D32,
> +	CLK_TOP_USB20_192M_D16,
> +	CLK_TOP_USB20_192M_D32,
> +};
> +
> +static const int uart_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_UNIVPLL2_D8
> +};
> +
> +static const int spi_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_UNIVPLL2_D2,
> +	CLK_TOP_UNIVPLL2_D4,
> +	CLK_TOP_UNIVPLL2_D8
> +};
> +
> +static const int msdc50_0_hc_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_SYSPLL1_D2,
> +	CLK_TOP_UNIVPLL1_D4,
> +	CLK_TOP_SYSPLL2_D2
> +};
> +
> +static const int msdc50_0_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_MSDCPLL,
> +	CLK_TOP_UNIVPLL1_D2,
> +	CLK_TOP_SYSPLL1_D2,
> +	CLK_TOP_UNIVPLL_D5,
> +	CLK_TOP_SYSPLL2_D2,
> +	CLK_TOP_UNIVPLL1_D4,
> +	CLK_TOP_SYSPLL4_D2
> +};
> +
> +static const int msdc50_2_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_MSDCPLL,
> +	CLK_TOP_UNIVPLL_D3,
> +	CLK_TOP_UNIVPLL1_D2,
> +	CLK_TOP_SYSPLL1_D2,
> +	CLK_TOP_UNIVPLL2_D2,
> +	CLK_TOP_SYSPLL2_D2,
> +	CLK_TOP_UNIVPLL1_D4
> +};
> +
> +static const int msdc30_1_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_MSDCPLL_D2,
> +	CLK_TOP_UNIVPLL2_D2,
> +	CLK_TOP_SYSPLL2_D2,
> +	CLK_TOP_UNIVPLL1_D4,
> +	CLK_TOP_SYSPLL1_D4,
> +	CLK_TOP_SYSPLL2_D4,
> +	CLK_TOP_UNIVPLL2_D8
> +};
> +
> +static const int audio_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_SYSPLL3_D4,
> +	CLK_TOP_SYSPLL4_D4,
> +	CLK_TOP_SYSPLL1_D16
> +};
> +
> +static const int aud_intbus_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_SYSPLL1_D4,
> +	CLK_TOP_SYSPLL4_D2
> +};
> +
> +static const int aud_1_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_APLL1
> +};
> +
> +static const int aud_2_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_APLL2
> +};
> +
> +static const int aud_engen1_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_APLL1_D2,
> +	CLK_TOP_APLL1_D4,
> +	CLK_TOP_APLL1_D8
> +};
> +
> +static const int aud_engen2_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_APLL2_D2,
> +	CLK_TOP_APLL2_D4,
> +	CLK_TOP_APLL2_D8,
> +};
> +
> +static const int aud_spdif_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_UNIVPLL_D2
> +};
> +
> +static const int disp_pwm_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_UNIVPLL2_D4
> +};
> +
> +static const int dxcc_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_SYSPLL1_D2,
> +	CLK_TOP_SYSPLL1_D4,
> +	CLK_TOP_SYSPLL1_D8
> +};
> +
> +static const int ssusb_sys_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_UNIVPLL3_D4,
> +	CLK_TOP_UNIVPLL2_D4,
> +	CLK_TOP_UNIVPLL3_D2
> +};
> +
> +static const int spm_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_SYSPLL1_D8
> +};
> +
> +static const int i2c_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_UNIVPLL3_D4,
> +	CLK_TOP_UNIVPLL3_D2,
> +	CLK_TOP_SYSPLL1_D8,
> +	CLK_TOP_SYSPLL2_D8
> +};
> +
> +static const int pwm_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_UNIVPLL3_D4,
> +	CLK_TOP_SYSPLL1_D8
> +};
> +
> +static const int senif_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_UNIVPLL1_D4,
> +	CLK_TOP_UNIVPLL1_D2,
> +	CLK_TOP_UNIVPLL2_D2
> +};
> +
> +static const int aes_fde_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_MSDCPLL,
> +	CLK_TOP_UNIVPLL_D3,
> +	CLK_TOP_UNIVPLL2_D2,
> +	CLK_TOP_UNIVPLL1_D2,
> +	CLK_TOP_SYSPLL1_D2
> +};
> +
> +static const int dpi0_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_LVDSPLL_D2,
> +	CLK_TOP_LVDSPLL_D4,
> +	CLK_TOP_LVDSPLL_D8,
> +	CLK_TOP_LVDSPLL_D16
> +};
> +
> +static const int dsp_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_SYS_26M_D2,
> +	CLK_TOP_DSPPLL,
> +	CLK_TOP_DSPPLL_D2,
> +	CLK_TOP_DSPPLL_D4,
> +	CLK_TOP_DSPPLL_D8
> +};
> +
> +static const int nfi2x_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_SYSPLL2_D2,
> +	CLK_TOP_SYSPLL_D7,
> +	CLK_TOP_SYSPLL_D3,
> +	CLK_TOP_SYSPLL2_D4,
> +	CLK_TOP_MSDCPLL_D2,
> +	CLK_TOP_UNIVPLL1_D2,
> +	CLK_TOP_UNIVPLL_D5
> +};
> +
> +static const int nfiecc_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_SYSPLL4_D2,
> +	CLK_TOP_UNIVPLL2_D4,
> +	CLK_TOP_SYSPLL_D7,
> +	CLK_TOP_UNIVPLL1_D2,
> +	CLK_TOP_SYSPLL1_D2,
> +	CLK_TOP_UNIVPLL2_D2,
> +	CLK_TOP_SYSPLL_D5
> +};
> +
> +static const int ecc_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_UNIVPLL2_D2,
> +	CLK_TOP_UNIVPLL1_D2,
> +	CLK_TOP_UNIVPLL_D3,
> +	CLK_TOP_SYSPLL_D2
> +};
> +
> +static const int eth_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_UNIVPLL2_D8,
> +	CLK_TOP_SYSPLL4_D4,
> +	CLK_TOP_SYSPLL1_D8,
> +	CLK_TOP_SYSPLL4_D2
> +};
> +
> +static const int gcpu_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_UNIVPLL_D3,
> +	CLK_TOP_UNIVPLL2_D2,
> +	CLK_TOP_SYSPLL_D3,
> +	CLK_TOP_SYSPLL2_D2
> +};
> +
> +static const int gcpu_cpm_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_UNIVPLL2_D2,
> +	CLK_TOP_SYSPLL2_D2
> +};
> +
> +static const int apu_parents[] =3D {
> +	CLK_TOP_CLK26M,
> +	CLK_TOP_UNIVPLL_D2,
> +	CLK_APMIXED_APUPLL,
> +	CLK_TOP_MMPLL,
> +	CLK_TOP_SYSPLL_D3,
> +	CLK_TOP_UNIVPLL1_D2,
> +	CLK_TOP_SYSPLL1_D2,
> +	CLK_TOP_SYSPLL1_D4
> +};
> +
> +static const struct mtk_composite top_muxes[] =3D {
> +	/* CLK_CFG_0 */
> +	MUX_GATE(CLK_TOP_AXI_SEL, axi_parents, 0x040, 0, 2, 7),
> +	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x040, 8, 2, 15),
> +	MUX_GATE(CLK_TOP_MM_SEL, mm_parents, 0x040, 16, 3, 23),
> +	MUX_GATE(CLK_TOP_SCP_SEL, scp_parents, 0x040, 24, 3, 31),
> +	/* CLK_CFG_1 */
> +	MUX_GATE(CLK_TOP_MFG_SEL, mfg_parents, 0x050, 0, 2, 7),
> +	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x050, 8, 2, 15),
> +	MUX_GATE(CLK_TOP_CAMTG_SEL, camtg_parents, 0x050, 16, 3, 23),
> +	MUX_GATE(CLK_TOP_CAMTG1_SEL, camtg_parents, 0x050, 24, 3, 31),
> +	/* CLK_CFG_2 */
> +	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x060, 0, 1, 7),
> +	MUX_GATE(CLK_TOP_SPI_SEL, spi_parents, 0x060, 8, 2, 15),
> +	MUX_GATE(CLK_TOP_MSDC50_0_HC_SEL, msdc50_0_hc_parents, 0x060, 16, 2, 23=
),
> +	MUX_GATE(CLK_TOP_MSDC2_2_HC_SEL, msdc50_0_hc_parents, 0x060, 24, 2, 31),
> +	/* CLK_CFG_3 */
> +	MUX_GATE(CLK_TOP_MSDC50_0_SEL, msdc50_0_parents, 0x070, 0, 3, 7),
> +	MUX_GATE(CLK_TOP_MSDC50_2_SEL, msdc50_2_parents, 0x070, 8, 3, 15),
> +	MUX_GATE(CLK_TOP_MSDC30_1_SEL, msdc30_1_parents, 0x070, 16, 3, 23),
> +	MUX_GATE(CLK_TOP_AUDIO_SEL, audio_parents, 0x070, 24, 2, 31),
> +	/* CLK_CFG_4 */
> +	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x080, 0, 2, 7),
> +	MUX_GATE(CLK_TOP_AUD_1_SEL, aud_1_parents, 0x080, 8, 1, 15),
> +	MUX_GATE(CLK_TOP_AUD_2_SEL, aud_2_parents, 0x080, 16, 1, 23),
> +	MUX_GATE(CLK_TOP_AUD_ENGEN1_SEL, aud_engen1_parents, 0x080, 24, 2, 31),
> +	/* CLK_CFG_5 */
> +	MUX_GATE(CLK_TOP_AUD_ENGEN2_SEL, aud_engen2_parents, 0x090, 0, 2, 7),
> +	MUX_GATE(CLK_TOP_AUD_SPDIF_SEL, aud_spdif_parents, 0x090, 8, 1, 15),
> +	MUX_GATE(CLK_TOP_DISP_PWM_SEL, disp_pwm_parents, 0x090, 16, 2, 23),
> +	/* CLK_CFG_6 */
> +	MUX_GATE(CLK_TOP_DXCC_SEL, dxcc_parents, 0x0a0, 0, 2, 7),
> +	MUX_GATE(CLK_TOP_SSUSB_SYS_SEL, ssusb_sys_parents, 0x0a0, 8, 2, 15),
> +	MUX_GATE(CLK_TOP_SSUSB_XHCI_SEL, ssusb_sys_parents, 0x0a0, 16, 2, 23),
> +	MUX_GATE(CLK_TOP_SPM_SEL, spm_parents, 0x0a0, 24, 1, 31),
> +	/* CLK_CFG_7 */
> +	MUX_GATE(CLK_TOP_I2C_SEL, i2c_parents, 0x0b0, 0, 3, 7),
> +	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x0b0, 8, 2, 15),
> +	MUX_GATE(CLK_TOP_SENIF_SEL, senif_parents, 0x0b0, 16, 2, 23),
> +	MUX_GATE(CLK_TOP_AES_FDE_SEL, aes_fde_parents, 0x0b0, 24, 3, 31),
> +	/* CLK_CFG_8 */
> +	MUX_GATE(CLK_TOP_CAMTM_SEL, senif_parents, 0x0c0, 0, 2, 7),
> +	MUX_GATE(CLK_TOP_DPI0_SEL, dpi0_parents, 0x0c0, 8, 3, 15),
> +	MUX_GATE(CLK_TOP_DPI1_SEL, dpi0_parents, 0x0c0, 16, 3, 23),
> +	MUX_GATE(CLK_TOP_DSP_SEL, dsp_parents, 0x0c0, 24, 3, 31),
> +	/* CLK_CFG_9 */
> +	MUX_GATE(CLK_TOP_NFI2X_SEL, nfi2x_parents, 0x0d0, 0, 3, 7),
> +	MUX_GATE(CLK_TOP_NFIECC_SEL, nfiecc_parents, 0x0d0, 8, 3, 15),
> +	MUX_GATE(CLK_TOP_ECC_SEL, ecc_parents, 0x0d0, 16, 3, 23),
> +	MUX_GATE(CLK_TOP_ETH_SEL, eth_parents, 0x0d0, 24, 3, 31),
> +	/* CLK_CFG_10 */
> +	MUX_GATE(CLK_TOP_GCPU_SEL, gcpu_parents, 0x0e0, 0, 3, 7),
> +	MUX_GATE(CLK_TOP_GCPU_CPM_SEL, gcpu_cpm_parents, 0x0e0, 8, 2, 15),
> +	MUX_GATE(CLK_TOP_APU_SEL, apu_parents, 0x0e0, 16, 3, 23),
> +	MUX_GATE(CLK_TOP_APU_IF_SEL, apu_parents, 0x0e0, 24, 3, 31),
> +};
> +
> +static const struct mtk_clk_tree mt8365_clk_tree =3D {
> +	.xtal_rate =3D 26 * MHZ,
> +	.xtal2_rate =3D 26 * MHZ,
> +	.fdivs_offs =3D CLK_TOP_SYSPLL_D2,
> +	.muxes_offs =3D CLK_TOP_AXI_SEL,
> +	.plls =3D apmixed_plls,
> +	.fclks =3D top_fixed_clks,
> +	.fdivs =3D top_divs,
> +	.muxes =3D top_muxes,
> +};
> +
> +/* topckgen cg */
> +static const struct mtk_gate_regs top0_cg_regs =3D {
> +	.set_ofs =3D 0,
> +	.clr_ofs =3D 0,
> +	.sta_ofs =3D 0,
> +};
> +
> +static const struct mtk_gate_regs top1_cg_regs =3D {
> +	.set_ofs =3D 0x104,
> +	.clr_ofs =3D 0x104,
> +	.sta_ofs =3D 0x104,
> +};
> +
> +static const struct mtk_gate_regs top2_cg_regs =3D {
> +	.set_ofs =3D 0x320,
> +	.clr_ofs =3D 0x320,
> +	.sta_ofs =3D 0x320,
> +};
> +
> +#define GATE_TOP0(_id, _parent, _shift) {			       \
> +		.id =3D _id,					       \
> +		.parent =3D _parent,				       \
> +		.regs =3D &top0_cg_regs,				       \
> +		.shift =3D _shift,				       \
> +		.flags =3D CLK_GATE_NO_SETCLR | CLK_PARENT_TOPCKGEN,     \
> +	}
> +
> +#define GATE_TOP1(_id, _parent, _shift) {			       \
> +		.id =3D _id,					       \
> +		.parent =3D _parent,				       \
> +		.regs =3D &top1_cg_regs,				       \
> +		.shift =3D _shift,				       \
> +		.flags =3D CLK_GATE_NO_SETCLR_INV | CLK_PARENT_TOPCKGEN, \
> +	}
> +
> +#define GATE_TOP2(_id, _parent, _shift) {			       \
> +		.id =3D _id,					       \
> +		.parent =3D _parent,				       \
> +		.regs =3D &top2_cg_regs,				       \
> +		.shift =3D _shift,				       \
> +		.flags =3D CLK_GATE_NO_SETCLR_INV | CLK_PARENT_TOPCKGEN, \
> +	}
> +
> +static const struct mtk_gate top_clk_gates[] =3D {
> +	GATE_TOP0(CLK_TOP_CONN_32K, CLK_TOP_CLK32K, 10),
> +	GATE_TOP0(CLK_TOP_CONN_26M, CLK_TOP_CLK26M, 11),
> +	GATE_TOP0(CLK_TOP_DSP_32K, CLK_TOP_CLK32K, 16),
> +	GATE_TOP0(CLK_TOP_DSP_26M, CLK_TOP_CLK26M, 17),
> +	GATE_TOP1(CLK_TOP_USB20_48M_EN, CLK_TOP_USB20_192M_D4, 8),
> +	GATE_TOP1(CLK_TOP_UNIVPLL_48M_EN, CLK_TOP_USB20_192M_D4, 9),
> +	GATE_TOP1(CLK_TOP_LVDSTX_CLKDIG_EN, CLK_TOP_LVDSTX_CLKDIG_CTS, 20),
> +	GATE_TOP1(CLK_TOP_VPLL_DPIX_EN, CLK_TOP_VPLL_DPIX, 21),
> +	GATE_TOP1(CLK_TOP_SSUSB_TOP_CK_EN, CLK_TOP_CLK_NULL, 22),
> +	GATE_TOP1(CLK_TOP_SSUSB_PHY_CK_EN, CLK_TOP_CLK_NULL, 23),
> +	GATE_TOP2(CLK_TOP_AUD_I2S0_M, CLK_TOP_APLL12_CK_DIV0, 0),
> +	GATE_TOP2(CLK_TOP_AUD_I2S1_M, CLK_TOP_APLL12_CK_DIV1, 1),
> +	GATE_TOP2(CLK_TOP_AUD_I2S2_M, CLK_TOP_APLL12_CK_DIV2, 2),
> +	GATE_TOP2(CLK_TOP_AUD_I2S3_M, CLK_TOP_APLL12_CK_DIV3, 3),
> +	GATE_TOP2(CLK_TOP_AUD_TDMOUT_M, CLK_TOP_APLL12_CK_DIV4, 4),
> +	GATE_TOP2(CLK_TOP_AUD_TDMOUT_B, CLK_TOP_APLL12_CK_DIV4B, 5),
> +	GATE_TOP2(CLK_TOP_AUD_TDMIN_M, CLK_TOP_APLL12_CK_DIV5, 6),
> +	GATE_TOP2(CLK_TOP_AUD_TDMIN_B, CLK_TOP_APLL12_CK_DIV5B, 7),
> +	GATE_TOP2(CLK_TOP_AUD_SPDIF_M, CLK_TOP_APLL12_CK_DIV6, 8),
> +};
> +
> +/* infracfg */
> +static const struct mtk_gate_regs ifr2_cg_regs =3D {
> +	.set_ofs =3D 0x80,
> +	.clr_ofs =3D 0x84,
> +	.sta_ofs =3D 0x90,
> +};
> +
> +static const struct mtk_gate_regs ifr3_cg_regs =3D {
> +	.set_ofs =3D 0x88,
> +	.clr_ofs =3D 0x8c,
> +	.sta_ofs =3D 0x94,
> +};
> +
> +static const struct mtk_gate_regs ifr4_cg_regs =3D {
> +	.set_ofs =3D 0xa4,
> +	.clr_ofs =3D 0xa8,
> +	.sta_ofs =3D 0xac,
> +};
> +
> +static const struct mtk_gate_regs ifr5_cg_regs =3D {
> +	.set_ofs =3D 0xc0,
> +	.clr_ofs =3D 0xc4,
> +	.sta_ofs =3D 0xc8,
> +};
> +
> +static const struct mtk_gate_regs ifr6_cg_regs =3D {
> +	.set_ofs =3D 0xd0,
> +	.clr_ofs =3D 0xd4,
> +	.sta_ofs =3D 0xd8,
> +};
> +
> +#define GATE_IFRX(_id, _parent, _shift, _regs)			\
> +	{							\
> +		.id =3D _id,					\
> +		.parent =3D _parent,				\
> +		.regs =3D _regs,					\
> +		.shift =3D _shift,				\
> +		.flags =3D CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN,	\
> +	}
> +
> +#define GATE_IFR2(_id, _parent, _shift)				\
> +	GATE_IFRX(_id, _parent, _shift, &ifr2_cg_regs)
> +
> +#define GATE_IFR3(_id, _parent, _shift)				\
> +	GATE_IFRX(_id, _parent, _shift, &ifr3_cg_regs)
> +
> +#define GATE_IFR4(_id, _parent, _shift)				\
> +	GATE_IFRX(_id, _parent, _shift, &ifr4_cg_regs)
> +
> +#define GATE_IFR5(_id, _parent, _shift)				\
> +	GATE_IFRX(_id, _parent, _shift, &ifr5_cg_regs)
> +
> +#define GATE_IFR6(_id, _parent, _shift)				\
> +	GATE_IFRX(_id, _parent, _shift, &ifr6_cg_regs)
> +
> +static const struct mtk_gate ifr_clks[] =3D {
> +	/* IFR2 */
> +	GATE_IFR2(CLK_IFR_PMIC_TMR, CLK_TOP_CLK26M, 0),
> +	GATE_IFR2(CLK_IFR_PMIC_AP, CLK_TOP_CLK26M, 1),
> +	GATE_IFR2(CLK_IFR_PMIC_MD, CLK_TOP_CLK26M, 2),
> +	GATE_IFR2(CLK_IFR_PMIC_CONN, CLK_TOP_CLK26M, 3),
> +	GATE_IFR2(CLK_IFR_ICUSB, CLK_TOP_AXI_SEL, 8),
> +	GATE_IFR2(CLK_IFR_GCE, CLK_TOP_AXI_SEL, 9),
> +	GATE_IFR2(CLK_IFR_THERM, CLK_TOP_AXI_SEL, 10),
> +	GATE_IFR2(CLK_IFR_PWM_HCLK, CLK_TOP_AXI_SEL, 15),
> +	GATE_IFR2(CLK_IFR_PWM1, CLK_TOP_PWM_SEL, 16),
> +	GATE_IFR2(CLK_IFR_PWM2, CLK_TOP_PWM_SEL, 17),
> +	GATE_IFR2(CLK_IFR_PWM3, CLK_TOP_PWM_SEL, 18),
> +	GATE_IFR2(CLK_IFR_PWM4, CLK_TOP_PWM_SEL, 19),
> +	GATE_IFR2(CLK_IFR_PWM5, CLK_TOP_PWM_SEL, 20),
> +	GATE_IFR2(CLK_IFR_PWM, CLK_TOP_PWM_SEL, 21),
> +	GATE_IFR2(CLK_IFR_UART0, CLK_TOP_UART_SEL, 22),
> +	GATE_IFR2(CLK_IFR_UART1, CLK_TOP_UART_SEL, 23),
> +	GATE_IFR2(CLK_IFR_UART2, CLK_TOP_UART_SEL, 24),
> +	GATE_IFR2(CLK_IFR_DSP_UART, CLK_TOP_UART_SEL, 26),
> +	GATE_IFR2(CLK_IFR_GCE_26M, CLK_TOP_CLK26M, 27),
> +	GATE_IFR2(CLK_IFR_CQ_DMA_FPC, CLK_TOP_AXI_SEL, 28),
> +	GATE_IFR2(CLK_IFR_BTIF, CLK_TOP_AXI_SEL, 31),
> +	/* IFR3 */
> +	GATE_IFR3(CLK_IFR_SPI0, CLK_TOP_SPI_SEL, 1),
> +	GATE_IFR3(CLK_IFR_MSDC0_HCLK, CLK_TOP_MSDC50_0_HC_SEL, 2),
> +	GATE_IFR3(CLK_IFR_MSDC2_HCLK, CLK_TOP_MSDC2_2_HC_SEL, 3),
> +	GATE_IFR3(CLK_IFR_MSDC1_HCLK, CLK_TOP_AXI_SEL, 4),
> +	GATE_IFR3(CLK_IFR_DVFSRC, CLK_TOP_CLK26M, 7),
> +	GATE_IFR3(CLK_IFR_GCPU, CLK_TOP_AXI_SEL, 8),
> +	GATE_IFR3(CLK_IFR_TRNG, CLK_TOP_AXI_SEL, 9),
> +	GATE_IFR3(CLK_IFR_AUXADC, CLK_TOP_CLK26M, 10),
> +	GATE_IFR3(CLK_IFR_AUXADC_MD, CLK_TOP_CLK26M, 14),
> +	GATE_IFR3(CLK_IFR_AP_DMA, CLK_TOP_AXI_SEL, 18),
> +	GATE_IFR3(CLK_IFR_DEBUGSYS, CLK_TOP_AXI_SEL, 24),
> +	GATE_IFR3(CLK_IFR_AUDIO, CLK_TOP_AXI_SEL, 25),
> +	/* IFR4 */
> +	GATE_IFR4(CLK_IFR_PWM_FBCLK6, CLK_TOP_PWM_SEL, 0),
> +	GATE_IFR4(CLK_IFR_DISP_PWM, CLK_TOP_DISP_PWM_SEL, 2),
> +	GATE_IFR4(CLK_IFR_AUD_26M_BK, CLK_TOP_CLK26M, 4),
> +	GATE_IFR4(CLK_IFR_CQ_DMA, CLK_TOP_AXI_SEL, 27),
> +	/* IFR5 */
> +	GATE_IFR5(CLK_IFR_MSDC0_SF, CLK_TOP_MSDC50_0_SEL, 0),
> +	GATE_IFR5(CLK_IFR_MSDC1_SF, CLK_TOP_MSDC50_0_SEL, 1),
> +	GATE_IFR5(CLK_IFR_MSDC2_SF, CLK_TOP_MSDC50_0_SEL, 2),
> +	GATE_IFR5(CLK_IFR_AP_MSDC0, CLK_TOP_MSDC50_0_SEL, 7),
> +	GATE_IFR5(CLK_IFR_MD_MSDC0, CLK_TOP_MSDC50_0_SEL, 8),
> +	GATE_IFR5(CLK_IFR_MSDC0_SRC, CLK_TOP_MSDC50_0_SEL, 9),
> +	GATE_IFR5(CLK_IFR_MSDC1_SRC, CLK_TOP_MSDC30_1_SEL, 10),
> +	GATE_IFR5(CLK_IFR_MSDC2_SRC, CLK_TOP_MSDC50_2_SEL, 11),
> +	GATE_IFR5(CLK_IFR_PWRAP_TMR, CLK_TOP_CLK26M, 12),
> +	GATE_IFR5(CLK_IFR_PWRAP_SPI, CLK_TOP_CLK26M, 13),
> +	GATE_IFR5(CLK_IFR_PWRAP_SYS, CLK_TOP_CLK26M, 14),
> +	GATE_IFR5(CLK_IFR_IRRX_26M, CLK_TOP_CLK26M, 22),
> +	GATE_IFR5(CLK_IFR_IRRX_32K, CLK_TOP_CLK32K, 23),
> +	GATE_IFR5(CLK_IFR_I2C0_AXI, CLK_TOP_I2C_SEL, 24),
> +	GATE_IFR5(CLK_IFR_I2C1_AXI, CLK_TOP_I2C_SEL, 25),
> +	GATE_IFR5(CLK_IFR_I2C2_AXI, CLK_TOP_I2C_SEL, 26),
> +	GATE_IFR5(CLK_IFR_I2C3_AXI, CLK_TOP_I2C_SEL, 27),
> +	GATE_IFR5(CLK_IFR_NIC_AXI, CLK_TOP_AXI_SEL, 28),
> +	GATE_IFR5(CLK_IFR_NIC_SLV_AXI, CLK_TOP_AXI_SEL, 29),
> +	GATE_IFR5(CLK_IFR_APU_AXI, CLK_TOP_AXI_SEL, 30),
> +	/* IFR6 */
> +	GATE_IFR6(CLK_IFR_NFIECC, CLK_TOP_NFIECC_SEL, 0),
> +	GATE_IFR6(CLK_IFR_NFI1X_BK, CLK_TOP_NFI2X_SEL, 1),
> +	GATE_IFR6(CLK_IFR_NFIECC_BK, CLK_TOP_NFI2X_SEL, 2),
> +	GATE_IFR6(CLK_IFR_NFI_BK, CLK_TOP_AXI_SEL, 3),
> +	GATE_IFR6(CLK_IFR_MSDC2_AP_BK, CLK_TOP_AXI_SEL, 4),
> +	GATE_IFR6(CLK_IFR_MSDC2_MD_BK, CLK_TOP_AXI_SEL, 5),
> +	GATE_IFR6(CLK_IFR_MSDC2_BK, CLK_TOP_AXI_SEL, 6),
> +	GATE_IFR6(CLK_IFR_SUSB_133_BK, CLK_TOP_AXI_SEL, 7),
> +	GATE_IFR6(CLK_IFR_SUSB_66_BK, CLK_TOP_AXI_SEL, 8),
> +	GATE_IFR6(CLK_IFR_SSUSB_SYS, CLK_TOP_SSUSB_SYS_SEL, 9),
> +	GATE_IFR6(CLK_IFR_SSUSB_REF, CLK_TOP_SSUSB_SYS_SEL, 10),
> +	GATE_IFR6(CLK_IFR_SSUSB_XHCI, CLK_TOP_SSUSB_XHCI_SEL, 11),
> +};
> +
> +static int mt8365_apmixedsys_probe(struct udevice *dev)
> +{
> +	return mtk_common_clk_init(dev, &mt8365_clk_tree);
> +}
> +
> +static int mt8365_topckgen_probe(struct udevice *dev)
> +{
> +	return mtk_common_clk_init(dev, &mt8365_clk_tree);
> +}
> +
> +static int mt8365_topckgen_cg_probe(struct udevice *dev)
> +{
> +	return mtk_common_clk_gate_init(dev, &mt8365_clk_tree, top_clk_gates);
> +}
> +
> +static int mt8365_infracfg_probe(struct udevice *dev)
> +{
> +	return mtk_common_clk_gate_init(dev, &mt8365_clk_tree, ifr_clks);
> +}
> +
> +static const struct udevice_id mt8365_apmixed_compat[] =3D {
> +	{ .compatible =3D "mediatek,mt8365-apmixedsys", },
> +	{ }
> +};
> +
> +static const struct udevice_id mt8365_topckgen_compat[] =3D {
> +	{ .compatible =3D "mediatek,mt8365-topckgen", },
> +	{ }
> +};
> +
> +static const struct udevice_id mt8365_topckgen_cg_compat[] =3D {
> +	{ .compatible =3D "mediatek,mt8365-topckgen-cg", },
> +	{ }
> +};
> +
> +static const struct udevice_id mt8365_infracfg_compat[] =3D {
> +	{ .compatible =3D "mediatek,mt8365-infracfg", },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(mtk_clk_apmixedsys) =3D {
> +	.name =3D "mt8365-apmixedsys",
> +	.id =3D UCLASS_CLK,
> +	.of_match =3D mt8365_apmixed_compat,
> +	.probe =3D mt8365_apmixedsys_probe,
> +	.priv_auto =3D sizeof(struct mtk_clk_priv),
> +	.ops =3D &mtk_clk_apmixedsys_ops,
> +	.flags =3D DM_FLAG_PRE_RELOC,
> +};
> +
> +U_BOOT_DRIVER(mtk_clk_topckgen) =3D {
> +	.name =3D "mt8365-topckgen",
> +	.id =3D UCLASS_CLK,
> +	.of_match =3D mt8365_topckgen_compat,
> +	.probe =3D mt8365_topckgen_probe,
> +	.priv_auto =3D sizeof(struct mtk_clk_priv),
> +	.ops =3D &mtk_clk_topckgen_ops,
> +	.flags =3D DM_FLAG_PRE_RELOC,
> +};
> +
> +U_BOOT_DRIVER(mtk_clk_topckgen_cg) =3D {
> +	.name =3D "mt8365-topckgen-cg",
> +	.id =3D UCLASS_CLK,
> +	.of_match =3D mt8365_topckgen_cg_compat,
> +	.probe =3D mt8365_topckgen_cg_probe,
> +	.priv_auto =3D sizeof(struct mtk_cg_priv),
> +	.ops =3D &mtk_clk_gate_ops,
> +	.flags =3D DM_FLAG_PRE_RELOC,
> +};
> +
> +U_BOOT_DRIVER(mtk_clk_infracfg) =3D {
> +	.name =3D "mt8365-infracfg",
> +	.id =3D UCLASS_CLK,
> +	.of_match =3D mt8365_infracfg_compat,
> +	.probe =3D mt8365_infracfg_probe,
> +	.priv_auto =3D sizeof(struct mtk_cg_priv),
> +	.ops =3D &mtk_clk_gate_ops,
> +	.flags =3D DM_FLAG_PRE_RELOC,
> +};
> --=20
> 2.43.0
