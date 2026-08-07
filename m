Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DB0C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 13:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C8FD60A43;
	Fri,  7 Aug 2026 13:39:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dR10ktPboMke; Fri,  7 Aug 2026 13:39:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25645607E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786109959;
	bh=ltFYzDt5rgVsQSxnF74VlOPhS9o7yR+CgLe5oBt9K1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NJxyAVbmbknQgWCWZP9YZTLPVb4ayaeDutfCNg3HStzxQhVFw3mvWOEtXaB5V80T+
	 z+IzVeP0EqDEmwph3albN3spJke+hisNCJO7NC7eKcdd8+ORH70w441H2S0ymvm4zG
	 n9lK6gVGRun9org1ULfF6HV8QAvm2XomaotKyKwxzcaNJHzgw5ZoLa1hzamdWnehMN
	 cekcNA0z+b+dWv5Os32jiij4A85JqvnWEuRtTz3MjxLcEnmFA1YIJkJG7/C8HxREjz
	 dIqCnKS484WFaflZx8UJiuLIjpGZ40nAMdmVGiWGZSiqAGjSKCSYYa/dTX8osL9SY8
	 mCSkfz0qvjjiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25645607E6;
	Fri,  7 Aug 2026 13:39:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30E282F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 190DC40A2D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:39:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nGsjQHhM3A7M for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 13:39:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A8C0A40A2A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8C0A40A2A
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8C0A40A2A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:39:13 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a17f91so5317668a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 06:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786109952; cv=none;
 d=google.com; s=arc-20260327;
 b=bFJuRobCr0G2muI91l0f+bjl7SFGKWJLZs+mfrlvx8nzki4C8QyHKQEiDg3OIOhJIk
 7e6RpXNbDjeEfrlOT8yZEP/cJWl2iQfumChvTeS71mKEESTkKYoBxlFyr1yU/aSJ1vfG
 V/NX5dPrtv9HxmX5vT+E49x3b2KRc3aEjAZsnQezofxSHkeBonU/y1jRheJEb7MOThlf
 oDq8aJ8lvbj++lB/wNEZ+og5WD7q+FQ0nyNqlk7/IkmHchzvhdM5udPuYL2zXM8lXQdo
 W685HbwESfd5obd4bls/SbtZF3r5IiZzz+Ii88IfTpH2BVEDffzph2xCgTGCC3DCja7x
 zSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ltFYzDt5rgVsQSxnF74VlOPhS9o7yR+CgLe5oBt9K1c=;
 fh=n6GhLmYE/WZYPn6baN3AgX8goGRvAv2iRjOy0SHcqMw=;
 b=jkY0GIDT0oRP5DGVWz2pWXiWN+ae+0dLgtIEnaUWryUuYwGtcJSQfDMNAo9tnGZgEY
 0lpSye0x8eWB5B3jFCnzWeaKbR/7TBc9AqJZ2SP0ia0MbsEeXjm0vsTn/MvdakLCx/OE
 KZp2mSVBipL15mxUU/uYnwQTsWd5uy7J3EW6TnUWlE/EbBduBYBtIa+l7WnCMS2InY9J
 qgutZXAnEAA1x8vz12m1EH9BN4vWeh1jwgZGDv97I85CcZc4vFcAhAzK23k4+WP4pU7d
 FPXiQNX/pdjEbPMyGTS40e+JojKMyIRvJX2jvIk0UEQGb8yVXLDv/DWaZ14j79+P5JbU
 Ultg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786109952; x=1786714752;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ltFYzDt5rgVsQSxnF74VlOPhS9o7yR+CgLe5oBt9K1c=;
 b=SiWVvlwSrdekMeQuj7eV9CffjEhuIHTK7FJS9FLOEJj11WkCLNHMag2UHxuM5uww9B
 qJVYiXCQ3Jwo5KkaJO6HAy0R98W5ABRCOagbt1z88BrOS5ce0A7wSa0+TynhwignSBkm
 nQPL7Un2w/r4WfPXBV7reg+gg4cw/VU5koAg8mx5zuqerW4pqkhDNCSFtOtZZ39+mmT+
 evSXKms/HnUgfNiZUbGZp3rIwX7AQiomkTSe13q/wIaf5fB2my/e3SOncZ1Er6+iJb/q
 6tziQ5/gD95AWPu2rLFnSmqheTKYSfWTnlSYWv4Z6kxSlNU5TII0Le7I27hyHfq6iMrp
 24Ig==
X-Forwarded-Encrypted: i=1;
 AHgh+RqW4CMEhrcM87jb/YEOKmkeIwLPLJTYfqb01TvKavpugcXGUpvE5++SflzuzpD6+S09+qmYN6M=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxHQgQypFhj82Lk2j0vW+D5953CJDrkIvof3s854QHEgMekjXZM
 uA0KbUnRbuNepZIDhMdJQuN/i4DGuhj0qRpoKf/5aBajYZyXPaPR8kIU6a2QNEluEE8bCQxn3Ev
 UQc2ILKzHy5NeJ1e9fRlmKBrilavQdqEoW0hev5l+DQ==
X-Gm-Gg: AR+sD10TmRX17OtU3zeWY6eC3f1RtIVvo8G704fkhAhQyb9MX8IE+yBsJr+mq/RAwdR
 JIP8syXDwGiDbPAIolj16RHHRovIY28BWzB5L+NHC0IVqXuGnBiXsop/dZpFkxh1HpcY43CuBQ6
 HfE8HZsS9A5bYfs95yO9gVTba8vr17ZdT9cEoB+gTVOUIFTmxf1JGUxHPBwsYtw3K0mmgy7wCFm
 NGb5i/9vaK6zQUfQwXbbkHGZpdLGLajrRCFe40Nqay8B6bgCZHZpH2vYn+VD2MtEOllWKNCy4y/
 nVKIdqC702uoQwSOhfCZ8Gr9QMHk3RhUvhwTicIv8udEymuavzvQxUroAb1iJ2n4ADu9haUh+x/
 lNRsFS7mW2e1MDf+JJ6f36/wfO8T+D2K14UybFw4x14pCrMo3MLV1ko2I+qP8gr1JwgrLJzygcA
 ==
X-Received: by 2002:a17:907:3e08:b0:c1c:3b06:ed03 with SMTP id
 a640c23a62f3a-c2039c74c1amr1251498666b.23.1786109951523; Fri, 07 Aug 2026
 06:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-mtk-clk-mt8366-v1-1-465e0f1286db@baylibre.com>
In-Reply-To: <20260803-mtk-clk-mt8366-v1-1-465e0f1286db@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 15:39:00 +0200
X-Gm-Features: AUfX_mw5IZDyigQqCeDZA2dbS7X0jBRWwlep4X1AW5kW7oa-ky0Jr8M7Nhl2lys
Message-ID: <CAEHHSvY5bKwT9Apm8HF_yfZNsnahdJd6aCuR22bF=nZBU3ONOA@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: add support for MT8366
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786109952; x=1786714752;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ltFYzDt5rgVsQSxnF74VlOPhS9o7yR+CgLe5oBt9K1c=;
 b=BitK9LaVbKBrXcwoHvNgR/d/q3ZqlrlFXMQypqjZcVMOpsXqsBknCjidk9SK5uJAAr
 hGESeaWFytt34FbK8P7GTXfhcyoLikd00rMPdmTSRG8rRRsKFLh/DlmAWHhSuIiBR8y7
 qfhV/7IRQeR5USZYht5+P+XYIQ30foy/w68h3t3Reo1BeYM03v28FHDUvJX7lotGwIff
 OnXJ8pWEFwyrPlLiiYWCZNGepzEopy+6d/Zqu5tlDRQXbjXqKDoh7dxxufJzVC5SXlp4
 FTIKMBfUW3qLwbKmqiV0/j5B2xAUPAhRpWQQ3xKdER+b8Pv/vJxLEorIgSbc22IdKY/N
 ZTBQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=BitK9LaV
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Le mar. 4 ao=C3=BBt 2026 =C3=A0 00:40, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit :
>
> From: "irving.ch.lin" <irving-ch.lin@mediatek.com>
>
> Add new clock tables/drivers for MT8366.
>
> Signed-off-by: irving.ch.lin <irving-ch.lin@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/clk/mediatek/Makefile     |    1 +
>  drivers/clk/mediatek/clk-mt8366.c | 1100 +++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 1101 insertions(+)
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefil=
e
> index d4cac6aaf52..00ebb50ae6f 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_TARGET_MT8188) +=3D clk-mt8188.o
>  obj-$(CONFIG_TARGET_MT8189) +=3D clk-mt8189.o
>  obj-$(CONFIG_TARGET_MT8195) +=3D clk-mt8195.o
>  obj-$(CONFIG_TARGET_MT8365) +=3D clk-mt8365.o
> +obj-$(CONFIG_TARGET_MT8366) +=3D clk-mt8366.o
>  obj-$(CONFIG_TARGET_MT8512) +=3D clk-mt8512.o
>  obj-$(CONFIG_TARGET_MT8516) +=3D clk-mt8516.o
>  obj-$(CONFIG_TARGET_MT8518) +=3D clk-mt8518.o
> diff --git a/drivers/clk/mediatek/clk-mt8366.c b/drivers/clk/mediatek/clk=
-mt8366.c
> new file mode 100644
> index 00000000000..fd86679ebd6
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8366.c
> @@ -0,0 +1,1100 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026 BayLibre, SAS
> + * Copyright (c) 2026 MediaTek Inc.
> + * Author: Irving-CH Lin <irving-ch.lin@mediatek.com>
> + * Author: David Lechner <dlechner@baylibre.com>
> + */
> +
> +#include <dm.h>
> +#include <dt-bindings/clock/mt8366-clk.h>
> +#include <linux/kernel.h>
> +#include "clk-mtk.h"
> +
> +enum {
> +       CLK_PAD_CLK32K,
> +       CLK_PAD_CLK26M,
> +       CLK_PAD_CLK13M,
> +       CLK_PAD_ULPOSC,
> +       CLK_PAD_ANA_LVDS,
> +};
> +
> +static const ulong ext_clock_rates[] =3D {
> +       [CLK_PAD_CLK32K] =3D 32000,
> +       [CLK_PAD_CLK26M] =3D 26 * MHZ,
> +       [CLK_PAD_CLK13M] =3D 13 * MHZ,
> +       [CLK_PAD_ULPOSC] =3D 260 * MHZ,
> +       [CLK_PAD_ANA_LVDS] =3D 118.9 * MHZ,
> +};
> +
> +#define MT8366_PLL_FMAX                (3800UL * MHZ)
> +#define MT8366_PLL_FMIN                (1500UL * MHZ)
> +#define MT8366_INTEGER_BITS    8
> +
> +#define PLL(_id, _reg, _flags, _pd_reg, _pd_shift, _pcw_reg, _pcw_shift,=
 \
> +           _pcwbits)                                                    =
\
> +       {                                                                =
\
> +               .id =3D _id,                                             =
  \
> +               .reg =3D _reg,                                           =
  \
> +               .flags =3D (_flags),                                     =
  \
> +               .fmax =3D MT8366_PLL_FMAX,                               =
  \
> +               .fmin =3D MT8366_PLL_FMIN,                               =
  \
> +               .pd_reg =3D _pd_reg,                                     =
  \
> +               .pd_shift =3D _pd_shift,                                 =
  \
> +               .pcw_reg =3D _pcw_reg,                                   =
  \
> +               .pcw_shift =3D _pcw_shift,                               =
  \
> +               .pcwbits =3D _pcwbits,                                   =
  \
> +               .pcwibits =3D MT8366_INTEGER_BITS,                       =
  \
> +       }
> +
> +static const struct mtk_pll_data apmixed_plls[] =3D {
> +       PLL(CLK_APMIXED_MAINPLL, 0x424, 0, 0x428, 24, 0x428, 0, 22),
> +       PLL(CLK_APMIXED_UNIVPLL, 0x434, 0, 0x438, 24, 0x438, 0, 22),
> +       PLL(CLK_APMIXED_MMPLL, 0x604, 0, 0x608, 24, 0x608, 0, 22),
> +       PLL(CLK_APMIXED_TVDPLL1, 0x614, 0, 0x618, 24, 0x618, 0, 22),
> +       PLL(CLK_APMIXED_TVDPLL2, 0x624, 0, 0x628, 24, 0x628, 0, 22),
> +       PLL(CLK_APMIXED_MSDCPLL, 0x634, 0, 0x638, 24, 0x638, 0, 22),
> +       PLL(CLK_APMIXED_CANPLL, 0x524, 0, 0x528, 24, 0x528, 0, 22),
> +       PLL(CLK_APMIXED_EMIPLL, 0x534, 0, 0x538, 24, 0x538, 0, 22),
> +       PLL(CLK_APMIXED_ETHPLL, 0x514, 0, 0x518, 24, 0x518, 0, 22),
> +       PLL(CLK_APMIXED_APLL1, 0x204, 0, 0x208, 24, 0x20c, 0, 32),
> +       PLL(CLK_APMIXED_APLL2, 0x218, 0, 0x21c, 24, 0x220, 0, 32),
> +};
> +
> +static const struct mtk_clk_tree mt8366_apmixed_tree =3D {
> +       .pll_parent =3D EXT_PARENT(CLK_PAD_CLK26M),
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
> +       .plls =3D apmixed_plls,
> +       .num_plls =3D ARRAY_SIZE(apmixed_plls),
> +       .type =3D MTK_CLK_TREE_APMIXED,
> +};
> +
> +static const struct mtk_fixed_factor top_divs[] =3D {
> +       FACTOR(CLK_TOP_MAINPLL_D4, CLK_APMIXED_MAINPLL, 1, 4, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_MAINPLL_D4_D2, CLK_APMIXED_MAINPLL, 1, 8, CLK_PARE=
NT_APMIXED),
> +       FACTOR(CLK_TOP_MAINPLL_D4_D4, CLK_APMIXED_MAINPLL, 1, 16, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_MAINPLL_D4_D8, CLK_APMIXED_MAINPLL, 43, 1375, CLK_=
PARENT_APMIXED),
> +       FACTOR(CLK_TOP_MAINPLL_D5, CLK_APMIXED_MAINPLL, 1, 5, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_MAINPLL_D5_D2, CLK_APMIXED_MAINPLL, 1, 10, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_MAINPLL_D6, CLK_APMIXED_MAINPLL, 1, 6, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_MAINPLL_D6_D2, CLK_APMIXED_MAINPLL, 1, 12, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_MAINPLL_D6_D4, CLK_APMIXED_MAINPLL, 1, 24, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_MAINPLL_D7_D2, CLK_APMIXED_MAINPLL, 1, 14, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_MAINPLL_D7_D4, CLK_APMIXED_MAINPLL, 1, 28, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_MAINPLL_D7_D8, CLK_APMIXED_MAINPLL, 1, 56, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_UNIVPLL_D4, CLK_APMIXED_UNIVPLL, 1, 4, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_UNIVPLL_D4_D2, CLK_APMIXED_UNIVPLL, 1, 8, CLK_PARE=
NT_APMIXED),
> +       FACTOR(CLK_TOP_UNIVPLL_D4_D4, CLK_APMIXED_UNIVPLL, 1, 16, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_UNIVPLL_D4_D8, CLK_APMIXED_UNIVPLL, 1, 32, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_UNIVPLL_D5_D2, CLK_APMIXED_UNIVPLL, 1, 10, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_UNIVPLL_D5_D4, CLK_APMIXED_UNIVPLL, 1, 20, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_UNIVPLL_D5_D8, CLK_APMIXED_UNIVPLL, 1, 40, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_UNIVPLL_D6, CLK_APMIXED_UNIVPLL, 1, 6, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_UNIVPLL_D6_D2, CLK_APMIXED_UNIVPLL, 1, 12, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_UNIVPLL_D6_D4, CLK_APMIXED_UNIVPLL, 1, 24, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_UNIVPLL_D6_D8, CLK_APMIXED_UNIVPLL, 1, 48, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_UNIVPLL_D7_D3, CLK_APMIXED_UNIVPLL, 1, 21, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_UNIVPLL_192M_D4, CLK_APMIXED_UNIVPLL, 1, 52, CLK_P=
ARENT_APMIXED),
> +       FACTOR(CLK_TOP_MMPLL_D4_D4, CLK_APMIXED_MMPLL, 1, 16, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_MMPLL_D5, CLK_APMIXED_MMPLL, 1, 5, CLK_PARENT_APMI=
XED),
> +       FACTOR(CLK_TOP_MMPLL_D5_D2, CLK_APMIXED_MMPLL, 1, 10, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_MMPLL_D6_D2, CLK_APMIXED_MMPLL, 1, 12, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_MMPLL_D7, CLK_APMIXED_MMPLL, 1, 7, CLK_PARENT_APMI=
XED),
> +       FACTOR(CLK_TOP_TVDPLL1_D2, CLK_APMIXED_TVDPLL1, 1, 2, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_TVDPLL1_D4, CLK_APMIXED_TVDPLL1, 1, 4, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_TVDPLL1_D8, CLK_APMIXED_TVDPLL1, 1, 8, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_TVDPLL1_D16, CLK_APMIXED_TVDPLL1, 31, 495, CLK_PAR=
ENT_APMIXED),
> +       FACTOR(CLK_TOP_TVDPLL2_D4, CLK_APMIXED_TVDPLL2, 1, 4, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_TVDPLL2_D8, CLK_APMIXED_TVDPLL2, 1, 8, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_MSDCPLL_D2, CLK_APMIXED_MSDCPLL, 1, 2, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_CANPLL_D5, CLK_APMIXED_CANPLL, 1, 5, CLK_PARENT_AP=
MIXED),
> +       FACTOR(CLK_TOP_CANPLL_D10, CLK_APMIXED_CANPLL, 1, 10, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_CANPLL_D20, CLK_APMIXED_CANPLL, 1, 20, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_CANPLL_D25, CLK_APMIXED_CANPLL, 1, 25, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_ETHPLL_D2, CLK_APMIXED_ETHPLL, 1, 2, CLK_PARENT_AP=
MIXED),
> +       FACTOR(CLK_TOP_ETHPLL_D8, CLK_APMIXED_ETHPLL, 1, 8, CLK_PARENT_AP=
MIXED),
> +       FACTOR(CLK_TOP_ETHPLL_D10, CLK_APMIXED_ETHPLL, 1, 10, CLK_PARENT_=
APMIXED),
> +       FACTOR(CLK_TOP_APLL1_D3, CLK_APMIXED_APLL1, 1, 3, CLK_PARENT_APMI=
XED),
> +       FACTOR(CLK_TOP_APLL2_D3, CLK_APMIXED_APLL2, 1, 3, CLK_PARENT_APMI=
XED),
> +       FACTOR(CLK_TOP_OSC_D2, CLK_PAD_ULPOSC, 1, 2, CLK_PARENT_EXT),
> +       FACTOR(CLK_TOP_OSC_D4, CLK_PAD_ULPOSC, 1, 4, CLK_PARENT_EXT),
> +       FACTOR(CLK_TOP_OSC_D8, CLK_PAD_ULPOSC, 1, 8, CLK_PARENT_EXT),
> +       FACTOR(CLK_TOP_OSC_D10, CLK_PAD_ULPOSC, 1, 10, CLK_PARENT_EXT),
> +       FACTOR(CLK_TOP_OSC_D16, CLK_PAD_ULPOSC, 61, 973, CLK_PARENT_EXT),
> +};
> +
> +static const struct mtk_parent kp_irq_gen_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
> +};
> +
> +static const struct mtk_parent lvdstx_clkdig_cts_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       EXT_PARENT(CLK_PAD_ANA_LVDS),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D7_D3),
> +};
> +
> +static const struct mtk_parent mcupm_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6_D4),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
> +};
> +
> +static const struct mtk_parent msdc5hclk_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
> +};
> +
> +static const struct mtk_parent pcie_mac_tl_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
> +};
> +
> +static const struct mtk_parent pwm_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_OSC_D10),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D4_D8),
> +};
> +
> +static const struct mtk_parent usb_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
> +};
> +
> +static const struct mtk_parent snps_eth_250m_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_ETHPLL_D2),
> +};
> +
> +static const struct mtk_parent snps_eth_50m_rmii_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_ETHPLL_D10),
> +};
> +
> +static const struct mtk_parent snps_eth_62p4m_ptp_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_ETHPLL_D8),
> +       TOP_PARENT(CLK_TOP_APLL1_D3),
> +       TOP_PARENT(CLK_TOP_APLL2_D3),
> +};
> +
> +static const struct mtk_parent dsi_occ_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
> +};
> +
> +static const struct mtk_parent msdc30_1_h_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
> +       TOP_PARENT(CLK_TOP_MSDCPLL_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
> +};
> +
> +static const struct mtk_parent msdc30_2_h_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_MSDCPLL_D2),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
> +};
> +
> +static const struct mtk_parent pwrap_ulposc_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_OSC_D10),
> +       TOP_PARENT(CLK_TOP_OSC_D8),
> +       TOP_PARENT(CLK_TOP_OSC_D16),
> +};
> +
> +static const struct mtk_parent can0_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_CANPLL_D5),
> +       TOP_PARENT(CLK_TOP_CANPLL_D10),
> +       TOP_PARENT(CLK_TOP_CANPLL_D20),
> +       TOP_PARENT(CLK_TOP_CANPLL_D25),
> +};
> +
> +static const struct mtk_parent i2cp_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_OSC_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
> +};
> +
> +static const struct mtk_parent msdc30_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
> +       TOP_PARENT(CLK_TOP_MSDCPLL_D2),
> +};
> +
> +static const struct mtk_parent aes_msdcfbe_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6),
> +};
> +
> +static const struct mtk_parent disp_pwm_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
> +       TOP_PARENT(CLK_TOP_OSC_D2),
> +       TOP_PARENT(CLK_TOP_OSC_D4),
> +       TOP_PARENT(CLK_TOP_OSC_D16),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
> +};
> +
> +static const struct mtk_parent dp_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_TVDPLL2_D4),
> +       TOP_PARENT(CLK_TOP_TVDPLL2_D8),
> +       TOP_PARENT(CLK_TOP_TVDPLL1_D8),
> +       TOP_PARENT(CLK_TOP_TVDPLL1_D4),
> +       TOP_PARENT(CLK_TOP_TVDPLL1_D2),
> +};
> +
> +static const struct mtk_parent ecc_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D4),
> +};
> +
> +static const struct mtk_parent emi_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_OSC_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D5),
> +       APMIXED_PARENT(CLK_APMIXED_EMIPLL),
> +};
> +
> +static const struct mtk_parent i2c_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_OSC_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
> +};
> +
> +static const struct mtk_parent msdc50_0_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
> +       APMIXED_PARENT(CLK_APMIXED_MSDCPLL),
> +};
> +
> +static const struct mtk_parent axi_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
> +       TOP_PARENT(CLK_TOP_OSC_D4),
> +};
> +
> +static const struct mtk_parent epd_dpi_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       EXT_PARENT(CLK_PAD_ANA_LVDS),
> +       APMIXED_PARENT(CLK_APMIXED_TVDPLL1),
> +       TOP_PARENT(CLK_TOP_TVDPLL1_D2),
> +       TOP_PARENT(CLK_TOP_TVDPLL1_D4),
> +       TOP_PARENT(CLK_TOP_TVDPLL1_D8),
> +       TOP_PARENT(CLK_TOP_TVDPLL1_D16),
> +};
> +
> +static const struct mtk_parent gcpu_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6),
> +};
> +
> +static const struct mtk_parent sflash_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D7_D8),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D7_D3),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
> +};
> +
> +static const struct mtk_parent spi_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
> +};
> +
> +static const struct mtk_parent vpll_dpix_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       EXT_PARENT(CLK_PAD_ANA_LVDS),
> +       TOP_PARENT(CLK_TOP_MMPLL_D4_D4),
> +       APMIXED_PARENT(CLK_APMIXED_TVDPLL1),
> +       TOP_PARENT(CLK_TOP_TVDPLL1_D2),
> +       TOP_PARENT(CLK_TOP_TVDPLL1_D4),
> +       TOP_PARENT(CLK_TOP_TVDPLL1_D8),
> +       TOP_PARENT(CLK_TOP_TVDPLL1_D16),
> +};
> +
> +static const struct mtk_parent disp_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
> +       TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
> +       APMIXED_PARENT(CLK_APMIXED_TVDPLL2),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
> +       TOP_PARENT(CLK_TOP_MMPLL_D7),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D4),
> +       TOP_PARENT(CLK_TOP_MMPLL_D5_D2),
> +};
> +
> +static const struct mtk_parent nfi_b_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D5_D8),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
> +};
> +
> +static const struct mtk_parent epd_parents[] =3D {
> +       EXT_PARENT(CLK_PAD_CLK26M),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
> +       TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D6),
> +       TOP_PARENT(CLK_TOP_MAINPLL_D5),
> +       TOP_PARENT(CLK_TOP_MMPLL_D5),
> +       APMIXED_PARENT(CLK_APMIXED_TVDPLL2),
> +       TOP_PARENT(CLK_TOP_UNIVPLL_D6),
> +       TOP_PARENT(CLK_TOP_MMPLL_D5_D2),
> +};
> +
> +#define MUX_CLR_SET_UPD(_id, _parents, _mux_ofs, _mux_set_ofs, _mux_clr_=
ofs, \
> +                       _shift, _width, _upd_ofs, _upd) \
> +       MUX_CLR_SET_UPD_FLAGS(_id, _parents, _mux_ofs, _mux_set_ofs, \
> +                             _mux_clr_ofs, _shift, _width, -1, _upd_ofs,=
 \
> +                             _upd, CLK_MUX_SETCLR_UPD)
> +
> +#define MUX_GATE_CLR_SET_UPD(_id, _parents, _mux_ofs, _mux_set_ofs, \
> +                            _mux_clr_ofs, _shift, _width, _gate, _upd_of=
s, \
> +                            _upd) \
> +       MUX_CLR_SET_UPD_FLAGS(_id, _parents, _mux_ofs, _mux_set_ofs, \
> +                             _mux_clr_ofs, _shift, _width, _gate, \
> +                             _upd_ofs, _upd, CLK_MUX_SETCLR_UPD)
> +
> +static const struct mtk_composite top_muxes[] =3D {
> +       /* CLK_CFG_0 */
> +       MUX_CLR_SET_UPD(CLK_TOP_AXI_SEL, axi_parents,
> +                       0x010, 0x014, 0x018, 0, 3, 0x04, 0),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_SEL, disp_parents,
> +                            0x010, 0x014, 0x018, 24, 4, 31, 0x04, 3),
> +       /* CLK_CFG_1 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_EPD_SEL, epd_parents,
> +                            0x020, 0x024, 0x028, 0, 4, 7, 0x04, 4),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_DP_SEL, dp_parents,
> +                            0x020, 0x024, 0x028, 16, 3, 23, 0x04, 6),
> +       /* CLK_CFG_3 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI0_SEL, spi_parents,
> +                            0x040, 0x044, 0x048, 24, 3, 31, 0x04, 15),
> +       /* CLK_CFG_4 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI1_SEL, spi_parents,
> +                            0x050, 0x054, 0x058, 0, 3, 7, 0x04, 16),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI2_SEL, spi_parents,
> +                            0x050, 0x054, 0x058, 8, 3, 15, 0x04, 17),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI3_SEL, spi_parents,
> +                            0x050, 0x054, 0x058, 16, 3, 23, 0x04, 18),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI4_SEL, spi_parents,
> +                            0x050, 0x054, 0x058, 24, 3, 31, 0x04, 19),
> +       /* CLK_CFG_5 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI5_SEL, spi_parents,
> +                            0x060, 0x064, 0x068, 0, 3, 7, 0x04, 20),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_I2CP_SEL, i2cp_parents,
> +                            0x060, 0x064, 0x068, 8, 3, 15, 0x04, 21),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C_SEL, i2c_parents,
> +                            0x060, 0x064, 0x068, 16, 3, 23, 0x04, 22),
> +       /* CLK_CFG_6 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM_SEL, pwm_parents,
> +                            0x070, 0x074, 0x078, 24, 2, 31, 0x04, 27),
> +       /* CLK_CFG_7 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_AES_MSDCFBE_SEL, aes_msdcfbe_parents=
,
> +                            0x080, 0x084, 0x088, 8, 3, 15, 0x04, 29),
> +       /* CLK_CFG_8 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL, msdc50_0_parents,
> +                            0x090, 0x094, 0x098, 8, 3, 15, 0x08, 2),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL, msdc30_parents,
> +                            0x090, 0x094, 0x098, 16, 3, 23, 0x08, 3),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2_SEL, msdc30_parents,
> +                            0x090, 0x094, 0x098, 24, 3, 31, 0x08, 4),
> +       /* CLK_CFG_9 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK_SEL, msdc5hclk_parents=
,
> +                            0x0a0, 0x0a4, 0x0a8, 0, 2, 7, 0x08, 5),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_HCLK_SEL, msdc30_1_h_parent=
s,
> +                            0x0a0, 0x0a4, 0x0a8, 8, 2, 15, 0x08, 6),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2_HCLK_SEL, msdc30_2_h_parent=
s,
> +                            0x0a0, 0x0a4, 0x0a8, 16, 2, 23, 0x08, 7),
> +       MUX_CLR_SET_UPD(CLK_TOP_MCUPM_SEL, mcupm_parents,
> +                       0x0a0, 0x0a4, 0x0a8, 24, 2, 0x08, 8),
> +       /* CLK_CFG_10 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_DSI_OCC_SEL, dsi_occ_parents,
> +                            0x0b0, 0x0b4, 0x0b8, 0, 2, 7, 0x08, 9),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_KP_IRQ_GEN_SEL, kp_irq_gen_parents,
> +                            0x0b0, 0x0b4, 0x0b8, 8, 1, 15, 0x08, 10),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_NFI_BCLK_SEL, nfi_b_parents,
> +                            0x0b0, 0x0b4, 0x0b8, 16, 4, 23, 0x08, 11),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SFLASH_SEL, sflash_parents,
> +                            0x0b0, 0x0b4, 0x0b8, 24, 3, 31, 0x08, 12),
> +       /* CLK_CFG_11 */
> +       MUX_CLR_SET_UPD(CLK_TOP_EMI_SEL, emi_parents,
> +                       0x0c0, 0x0c4, 0x0c8, 0, 3, 0x08, 13),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MAC_TL_SEL, pcie_mac_tl_parents,
> +                            0x0c0, 0x0c4, 0x0c8, 8, 2, 15, 0x08, 14),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SNPS_ETH_250M_SEL, snps_eth_250m_par=
ents,
> +                            0x0c0, 0x0c4, 0x0c8, 16, 1, 23, 0x08, 15),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SNPS_ETH_62P4M_PTP_SEL,
> +                            snps_eth_62p4m_ptp_parents,
> +                            0x0c0, 0x0c4, 0x0c8, 24, 2, 31, 0x08, 16),
> +       /* CLK_CFG_12 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SNPS_ETH_50M_RMII_SEL,
> +                            snps_eth_50m_rmii_parents,
> +                            0x0d0, 0x0d4, 0x0d8, 0, 1, 7, 0x08, 17),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_LVDSTX_CLKDIG_CTS_SEL,
> +                            lvdstx_clkdig_cts_parents,
> +                            0x0d0, 0x0d4, 0x0d8, 8, 2, 15, 0x08, 18),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_VPLL_DPIX_SEL, vpll_dpix_parents,
> +                            0x0d0, 0x0d4, 0x0d8, 16, 3, 23, 0x08, 19),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_EPD_DPI_SEL, epd_dpi_parents,
> +                            0x0d0, 0x0d4, 0x0d8, 24, 3, 31, 0x08, 20),
> +       /* CLK_CFG_13 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_ECC_SEL, ecc_parents,
> +                            0x0e0, 0x0e4, 0x0e8, 8, 3, 15, 0x08, 22),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_GCPU_SEL, gcpu_parents,
> +                            0x0e0, 0x0e4, 0x0e8, 16, 3, 23, 0x08, 23),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P0_SEL, usb_parents,
> +                            0x0e0, 0x0e4, 0x0e8, 24, 2, 31, 0x08, 24),
> +       /* CLK_CFG_14 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P0_SEL, usb_parents,
> +                            0x0f0, 0x0f4, 0x0f8, 0, 2, 7, 0x08, 25),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P1_SEL, usb_parents,
> +                            0x0f0, 0x0f4, 0x0f8, 8, 2, 15, 0x08, 26),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P1_SEL, usb_parents,
> +                            0x0f0, 0x0f4, 0x0f8, 16, 2, 23, 0x08, 27),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P2_SEL, usb_parents,
> +                            0x0f0, 0x0f4, 0x0f8, 24, 2, 31, 0x08, 28),
> +       /* CLK_CFG_15 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P2_SEL, usb_parents,
> +                            0x100, 0x104, 0x108, 0, 2, 7, 0x08, 29),
> +       /* CLK_CFG_20 */
> +       MUX_CLR_SET_UPD(CLK_TOP_PWRAP_ULPOSC_SEL, pwrap_ulposc_parents,
> +                       0x120, 0x124, 0x128, 8, 2, 0x0c, 19),
> +       /* CLK_CFG_19 */
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_CAN0_SEL, can0_parents,
> +                            0x260, 0x264, 0x268, 0, 3, 7, 0x0c, 14),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_PWM_SEL, disp_pwm_parents,
> +                            0x260, 0x264, 0x268, 8, 3, 15, 0x0c, 15),
> +};
> +
> +static const struct mtk_gate_regs top_cg_regs =3D {
> +       .set_ofs =3D 0x508,
> +       .clr_ofs =3D 0x50C,
> +       .sta_ofs =3D 0x504,
> +};
> +
> +#define GATE_EXT(_id, _parent, _shift)  \
> +       GATE_FLAGS(_id, _parent, &top_cg_regs, _shift,\
> +                  CLK_PARENT_EXT | CLK_GATE_SETCLR_INV)
> +
> +#define GATE_TOP(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &top_cg_regs, _shift, \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR_INV)
> +
> +static const struct mtk_gate top_gates[] =3D {
> +       /* TOP1 */
> +       GATE_EXT(CLK_TOP_F26M_CK_EN, CLK_PAD_CLK26M, 2),
> +       GATE_EXT(CLK_TOP_USB_F26M_CK_EN, CLK_PAD_CLK26M, 3),
> +       GATE_EXT(CLK_TOP_USB2_PHY_REFCK_P0_EN, CLK_PAD_CLK26M, 4),
> +       GATE_EXT(CLK_TOP_USB2_PHY_REFCK_P1_EN, CLK_PAD_CLK26M, 5),
> +       GATE_EXT(CLK_TOP_USB2_PHY_REFCK_P2_EN, CLK_PAD_CLK26M, 6),
> +       GATE_EXT(CLK_TOP_USB2_26M_CK_P0_EN, CLK_PAD_CLK26M, 7),
> +       GATE_EXT(CLK_TOP_USB2_26M_CK_P1_EN, CLK_PAD_CLK26M, 8),
> +       GATE_EXT(CLK_TOP_USB2_26M_CK_P2_EN, CLK_PAD_CLK26M, 9),
> +       GATE_TOP(CLK_TOP_FMCNT_P0_EN, CLK_TOP_UNIVPLL_192M_D4, 10),
> +       GATE_TOP(CLK_TOP_FMCNT_P1_EN, CLK_TOP_UNIVPLL_192M_D4, 11),
> +       GATE_TOP(CLK_TOP_FMCNT_P2_EN, CLK_TOP_UNIVPLL_192M_D4, 12),
> +};
> +
> +static const struct mtk_clk_tree mt8366_topckgen_tree =3D {
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
> +       .fdivs_offs =3D CLK_TOP_MAINPLL_D4,
> +       .muxes_offs =3D CLK_TOP_AXI_SEL,
> +       .gates_offs =3D CLK_TOP_F26M_CK_EN,
> +       .fdivs =3D top_divs,
> +       .muxes =3D top_muxes,
> +       .gates =3D top_gates,
> +       .num_fdivs =3D ARRAY_SIZE(top_divs),
> +       .num_muxes =3D ARRAY_SIZE(top_muxes),
> +       .num_gates =3D ARRAY_SIZE(top_gates),
> +       .type =3D MTK_CLK_TREE_TOPCKGEN,
> +};
> +
> +/* infracfg */
> +
> +static const struct mtk_gate_regs infracfg_ao_reg0_cg_regs =3D {
> +       .set_ofs =3D 0x10,
> +       .clr_ofs =3D 0x14,
> +       .sta_ofs =3D 0x18,
> +};
> +
> +static const struct mtk_gate_regs infracfg_ao_reg1_cg_regs =3D {
> +       .set_ofs =3D 0x1c,
> +       .clr_ofs =3D 0x20,
> +       .sta_ofs =3D 0x24,
> +};
> +
> +static const struct mtk_gate_regs infracfg_ao_reg2_cg_regs =3D {
> +       .set_ofs =3D 0x80,
> +       .clr_ofs =3D 0x84,
> +       .sta_ofs =3D 0x90,
> +};
> +
> +static const struct mtk_gate_regs infracfg_ao_reg3_cg_regs =3D {
> +       .set_ofs =3D 0x88,
> +       .clr_ofs =3D 0x8c,
> +       .sta_ofs =3D 0x94,
> +};
> +
> +static const struct mtk_gate_regs infracfg_ao_reg4_cg_regs =3D {
> +       .set_ofs =3D 0xa4,
> +       .clr_ofs =3D 0xa8,
> +       .sta_ofs =3D 0xac,
> +};
> +
> +static const struct mtk_gate_regs infracfg_ao_reg5_cg_regs =3D {
> +       .set_ofs =3D 0xc0,
> +       .clr_ofs =3D 0xc4,
> +       .sta_ofs =3D 0xc8,
> +};
> +
> +static const struct mtk_gate_regs infracfg_ao_reg6_cg_regs =3D {
> +       .set_ofs =3D 0xf0,
> +       .clr_ofs =3D 0xf4,
> +       .sta_ofs =3D 0xf8,
> +};
> +
> +#define GATE_INFRACFG_AO_REG0(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg0_cg_regs, _shift, \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
> +
> +#define GATE_INFRACFG_AO_REG0E(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg0_cg_regs, _shift, \
> +                  CLK_PARENT_EXT | CLK_GATE_SETCLR)
> +
> +#define GATE_INFRACFG_AO_REG1(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg1_cg_regs, _shift, \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
> +
> +#define GATE_INFRACFG_AO_REG1E(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg1_cg_regs, _shift, \
> +                  CLK_PARENT_EXT | CLK_GATE_SETCLR)
> +
> +#define GATE_INFRACFG_AO_REG2(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg2_cg_regs, _shift, \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
> +
> +#define GATE_INFRACFG_AO_REG2E(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg2_cg_regs, _shift, \
> +                  CLK_PARENT_EXT | CLK_GATE_SETCLR)
> +
> +#define GATE_INFRACFG_AO_REG3(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg3_cg_regs, _shift, \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
> +
> +#define GATE_INFRACFG_AO_REG3E(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg3_cg_regs, _shift, \
> +                  CLK_PARENT_EXT | CLK_GATE_SETCLR)
> +
> +#define GATE_INFRACFG_AO_REG4(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg4_cg_regs, _shift, \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
> +
> +#define GATE_INFRACFG_AO_REG4E(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg4_cg_regs, _shift, \
> +                  CLK_PARENT_EXT | CLK_GATE_SETCLR)
> +
> +#define GATE_INFRACFG_AO_REG5(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg5_cg_regs, _shift, \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
> +
> +#define GATE_INFRACFG_AO_REG5E(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg5_cg_regs, _shift, \
> +                  CLK_PARENT_EXT | CLK_GATE_SETCLR)
> +
> +#define GATE_INFRACFG_AO_REG6(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg6_cg_regs, _shift, \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
> +
> +#define GATE_INFRACFG_AO_REG6E(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &infracfg_ao_reg6_cg_regs, _shift, \
> +                  CLK_PARENT_EXT | CLK_GATE_SETCLR)
> +
> +static const struct mtk_gate infracfg_ao_reg_clks[] =3D {
> +       /* INFRACFG_AO_REG0 */
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_UART0, CLK_TOP_AXI_SEL=
, 0),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_UART1, CLK_TOP_AXI_SEL=
, 1),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_UART2, CLK_TOP_AXI_SEL=
, 2),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_UART3, CLK_TOP_AXI_SEL=
, 3),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_DISP_PWM0, CLK_TOP_DIS=
P_PWM_SEL, 10),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_DISP_PWM1, CLK_TOP_DIS=
P_PWM_SEL, 11),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_SPI0_B, CLK_TOP_SPI0_S=
EL, 12),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_SPI1_B, CLK_TOP_SPI1_S=
EL, 13),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_SPI2_B, CLK_TOP_SPI2_S=
EL, 14),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_SPI3_B, CLK_TOP_SPI3_S=
EL, 15),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_SPI4_B, CLK_TOP_SPI4_S=
EL, 16),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_SPI5_B, CLK_TOP_SPI5_S=
EL, 17),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_SPI0_H, CLK_TOP_AXI_SE=
L, 18),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_SPI1_H, CLK_TOP_AXI_SE=
L, 19),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_SPI2_H, CLK_TOP_AXI_SE=
L, 20),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_SPI3_H, CLK_TOP_AXI_SE=
L, 21),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_SPI4_H, CLK_TOP_AXI_SE=
L, 22),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_SPI5_H, CLK_TOP_AXI_SE=
L, 23),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_AXI, CLK_TOP_EMI_SEL, =
24),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_AHB, CLK_TOP_AXI_SEL, =
25),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_TL, CLK_TOP_MAC_TL_SEL=
, 26),
> +       GATE_INFRACFG_AO_REG0E(CLK_INFRACFG_AO_REGP_REF, CLK_PAD_CLK26M, =
27),
> +       GATE_INFRACFG_AO_REG0(CLK_INFRACFG_AO_REGP_DMA_B, CLK_TOP_AXI_SEL=
, 30),
> +       /* INFRACFG_AO_REG1 */
> +       GATE_INFRACFG_AO_REG1E(CLK_INFRACFG_AO_REGP_SSUSB0_PIPE, CLK_PAD_=
CLK26M, 0),
> +       GATE_INFRACFG_AO_REG1E(CLK_INFRACFG_AO_REGP_SSUSB0_REF, CLK_PAD_C=
LK26M, 1),
> +       GATE_INFRACFG_AO_REG1E(CLK_INFRACFG_AO_REGP_SSUSB0_FRMCNT, CLK_PA=
D_CLK26M, 2),
> +       GATE_INFRACFG_AO_REG1E(CLK_INFRACFG_AO_REGP_SSUSB0_UTMI, CLK_PAD_=
CLK26M, 3),
> +       GATE_INFRACFG_AO_REG1(CLK_INFRACFG_AO_REGP_SSUSB0_SYS, CLK_TOP_US=
B_TOP_P0_SEL, 4),
> +       GATE_INFRACFG_AO_REG1(CLK_INFRACFG_AO_REGP_SSUSB0_XCHI, CLK_TOP_U=
SB_XHCI_P0_SEL, 5),
> +       GATE_INFRACFG_AO_REG1(CLK_INFRACFG_AO_REGP_SSUSB0_F, CLK_TOP_AXI_=
SEL, 6),
> +       GATE_INFRACFG_AO_REG1(CLK_INFRACFG_AO_REGP_SSUSB0_H, CLK_TOP_AXI_=
SEL, 7),
> +       GATE_INFRACFG_AO_REG1E(CLK_INFRACFG_AO_REGP_SSUSB1_REF, CLK_PAD_C=
LK26M, 8),
> +       GATE_INFRACFG_AO_REG1E(CLK_INFRACFG_AO_REGP_SSUSB1_FRMCNT, CLK_PA=
D_CLK26M, 9),
> +       GATE_INFRACFG_AO_REG1E(CLK_INFRACFG_AO_REGP_SSUSB1_UTMI, CLK_PAD_=
CLK26M, 10),
> +       GATE_INFRACFG_AO_REG1(CLK_INFRACFG_AO_REGP_SSUSB1_SYS, CLK_TOP_US=
B_TOP_P1_SEL, 11),
> +       GATE_INFRACFG_AO_REG1(CLK_INFRACFG_AO_REGP_SSUSB1_XCHI, CLK_TOP_U=
SB_XHCI_P1_SEL, 12),
> +       GATE_INFRACFG_AO_REG1(CLK_INFRACFG_AO_REGP_SSUSB1_F, CLK_TOP_AXI_=
SEL, 13),
> +       GATE_INFRACFG_AO_REG1(CLK_INFRACFG_AO_REGP_SSUSB1_H, CLK_TOP_AXI_=
SEL, 14),
> +       GATE_INFRACFG_AO_REG1E(CLK_INFRACFG_AO_REGP_SSUSB2_REF, CLK_PAD_C=
LK26M, 15),
> +       GATE_INFRACFG_AO_REG1E(CLK_INFRACFG_AO_REGP_SSUSB2_FRMCNT, CLK_PA=
D_CLK26M, 16),
> +       GATE_INFRACFG_AO_REG1E(CLK_INFRACFG_AO_REGP_SSUSB2_UTMI, CLK_PAD_=
CLK26M, 17),
> +       GATE_INFRACFG_AO_REG1(CLK_INFRACFG_AO_REGP_SSUSB2_SYS, CLK_TOP_US=
B_TOP_P2_SEL, 18),
> +       GATE_INFRACFG_AO_REG1(CLK_INFRACFG_AO_REGP_SSUSB2_XCHI, CLK_TOP_U=
SB_XHCI_P2_SEL, 19),
> +       GATE_INFRACFG_AO_REG1(CLK_INFRACFG_AO_REGP_SSUSB2_F, CLK_TOP_AXI_=
SEL, 20),
> +       GATE_INFRACFG_AO_REG1(CLK_INFRACFG_AO_REGP_SSUSB2_H, CLK_TOP_AXI_=
SEL, 21),
> +       /* INFRACFG_AO_REG2 */
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_PMIC_TMR, CLK_TOP_PWRAP=
_ULPOSC_SEL, 0),
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_PMIC_AP, CLK_TOP_PWRAP_=
ULPOSC_SEL, 1),
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_SEJ, CLK_TOP_AXI_SEL, 5=
),
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_MCUPM, CLK_TOP_MCUPM_SE=
L, 7),
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_GCE, CLK_TOP_AXI_SEL, 8=
),
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_GCE2, CLK_TOP_AXI_SEL, =
9),
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_PWM_H, CLK_TOP_AXI_SEL,=
 15),
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_PWM1, CLK_TOP_PWM_SEL, =
16),
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_PWM2, CLK_TOP_PWM_SEL, =
17),
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_PWM3, CLK_TOP_PWM_SEL, =
18),
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_PWM4, CLK_TOP_PWM_SEL, =
19),
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_PWM, CLK_TOP_PWM_SEL, 2=
1),
> +       GATE_INFRACFG_AO_REG2E(CLK_INFRACFG_AO_REG_GCE_26M, CLK_PAD_CLK26=
M, 27),
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_CQ_DMA_FPC, CLK_TOP_AXI=
_SEL, 28),
> +       GATE_INFRACFG_AO_REG2(CLK_INFRACFG_AO_REG_BTIF, CLK_TOP_AXI_SEL, =
31),
> +       /* INFRACFG_AO_REG3 */
> +       GATE_INFRACFG_AO_REG3(CLK_INFRACFG_AO_REG_SPI0, CLK_TOP_SPI0_SEL,=
 1),
> +       GATE_INFRACFG_AO_REG3E(CLK_INFRACFG_AO_REG_AUXADC, CLK_PAD_CLK26M=
, 10),
> +       GATE_INFRACFG_AO_REG3(CLK_INFRACFG_AO_REG_CPUM, CLK_TOP_AXI_SEL, =
11),
> +       GATE_INFRACFG_AO_REG3(CLK_INFRACFG_AO_REG_CCIF1_AP, CLK_TOP_AXI_S=
EL, 12),
> +       GATE_INFRACFG_AO_REG3(CLK_INFRACFG_AO_REG_CCIF1_MD, CLK_TOP_AXI_S=
EL, 13),
> +       GATE_INFRACFG_AO_REG3E(CLK_INFRACFG_AO_REG_AUXADC_MD, CLK_PAD_CLK=
26M, 14),
> +       GATE_INFRACFG_AO_REG3(CLK_INFRACFG_AO_REG_TL_26M, CLK_TOP_AXI_SEL=
, 15),
> +       GATE_INFRACFG_AO_REG3(CLK_INFRACFG_AO_REG_TL_96M, CLK_TOP_AXI_SEL=
, 18),
> +       GATE_INFRACFG_AO_REG3(CLK_INFRACFG_AO_REG_PL_P_250M, CLK_TOP_AXI_=
SEL, 19),
> +       GATE_INFRACFG_AO_REG3(CLK_INFRACFG_AO_REG_CCIF_AP, CLK_TOP_AXI_SE=
L, 23),
> +       GATE_INFRACFG_AO_REG3(CLK_INFRACFG_AO_REG_DEBUGSYS, CLK_TOP_AXI_S=
EL, 24),
> +       GATE_INFRACFG_AO_REG3(CLK_INFRACFG_AO_REG_AUDIO, CLK_TOP_AXI_SEL,=
 25),
> +       GATE_INFRACFG_AO_REG3(CLK_INFRACFG_AO_REG_CCIF_MD, CLK_TOP_AXI_SE=
L, 26),
> +       GATE_INFRACFG_AO_REG3(CLK_INFRACFG_AO_REG_DBG_TRACE, CLK_TOP_AXI_=
SEL, 29),
> +       /* INFRACFG_AO_REG4 */
> +       GATE_INFRACFG_AO_REG4(CLK_INFRACFG_AO_REG_CLDMA_BCLK, CLK_TOP_AXI=
_SEL, 3),
> +       GATE_INFRACFG_AO_REG4E(CLK_INFRACFG_AO_REG_AUDIO_26M_BCLK, CLK_PA=
D_CLK26M, 4),
> +       GATE_INFRACFG_AO_REG4E(CLK_INFRACFG_AO_REG_MODEM_TEMP_SHARE, CLK_=
PAD_CLK26M, 5),
> +       GATE_INFRACFG_AO_REG4(CLK_INFRACFG_AO_REG_SPI1, CLK_TOP_SPI1_SEL,=
 6),
> +       GATE_INFRACFG_AO_REG4(CLK_INFRACFG_AO_REG_SPI2, CLK_TOP_SPI2_SEL,=
 9),
> +       GATE_INFRACFG_AO_REG4(CLK_INFRACFG_AO_REG_SPI3, CLK_TOP_SPI3_SEL,=
 10),
> +       GATE_INFRACFG_AO_REG4E(CLK_INFRACFG_AO_REG_U_SAP_B, CLK_PAD_CLK26=
M, 13),
> +       GATE_INFRACFG_AO_REG4(CLK_INFRACFG_AO_REG_UNIPRO_MBIST, CLK_TOP_A=
XI_SEL, 16),
> +       GATE_INFRACFG_AO_REG4(CLK_INFRACFG_AO_REG_SPI4, CLK_TOP_SPI4_SEL,=
 25),
> +       GATE_INFRACFG_AO_REG4(CLK_INFRACFG_AO_REG_SPI5, CLK_TOP_SPI5_SEL,=
 26),
> +       GATE_INFRACFG_AO_REG4(CLK_INFRACFG_AO_REG_CQ_DMA, CLK_TOP_AXI_SEL=
, 27),
> +       GATE_INFRACFG_AO_REG4(CLK_INFRACFG_AO_REG_KP_IRQ_GEN, CLK_TOP_KP_=
IRQ_GEN_SEL, 28),
> +       GATE_INFRACFG_AO_REG4E(CLK_INFRACFG_AO_REG_KP_32K, CLK_PAD_CLK32K=
, 29),
> +       /* INFRACFG_AO_REG5 */
> +       GATE_INFRACFG_AO_REG5(CLK_INFRACFG_AO_REG_U_AXI, CLK_TOP_AXI_SEL,=
 5),
> +       GATE_INFRACFG_AO_REG5(CLK_INFRACFG_AO_REG_CCIF5_AP, CLK_TOP_AXI_S=
EL, 9),
> +       GATE_INFRACFG_AO_REG5(CLK_INFRACFG_AO_REG_CCIF5_MD, CLK_TOP_AXI_S=
EL, 10),
> +       GATE_INFRACFG_AO_REG5(CLK_INFRACFG_AO_REG_CCIF2_AP, CLK_TOP_AXI_S=
EL, 16),
> +       GATE_INFRACFG_AO_REG5(CLK_INFRACFG_AO_REG_CCIF2_MD, CLK_TOP_AXI_S=
EL, 17),
> +       GATE_INFRACFG_AO_REG5(CLK_INFRACFG_AO_REG_CCIF3_AP, CLK_TOP_AXI_S=
EL, 18),
> +       GATE_INFRACFG_AO_REG5(CLK_INFRACFG_AO_REG_CCIF3_MD, CLK_TOP_AXI_S=
EL, 19),
> +       GATE_INFRACFG_AO_REG5E(CLK_INFRACFG_AO_REG_SEJ_F13M, CLK_PAD_CLK2=
6M, 20),
> +       GATE_INFRACFG_AO_REG5(CLK_INFRACFG_AO_REG_AES, CLK_TOP_AXI_SEL, 2=
1),
> +       GATE_INFRACFG_AO_REG5(CLK_INFRACFG_AO_REG_GCPU, CLK_TOP_GCPU_SEL,=
 26),
> +       GATE_INFRACFG_AO_REG5(CLK_INFRACFG_AO_REG_ECC, CLK_TOP_ECC_SEL, 2=
7),
> +       GATE_INFRACFG_AO_REG5(CLK_INFRACFG_AO_REG_CCIF4_AP, CLK_TOP_AXI_S=
EL, 28),
> +       GATE_INFRACFG_AO_REG5(CLK_INFRACFG_AO_REG_CCIF4_MD, CLK_TOP_AXI_S=
EL, 29),
> +       /* INFRACFG_AO_REG6 */
> +       GATE_INFRACFG_AO_REG6E(CLK_INFRACFG_AO_REGP_AUXADC_26M, CLK_PAD_C=
LK26M, 0),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_MSDC0, CLK_TOP_MSDC50_=
0_SEL, 1),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_MSDC0_H, CLK_TOP_MSDC5=
0_0_HCLK_SEL, 2),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_MSDC0_FAES, CLK_TOP_AE=
S_MSDCFBE_SEL, 3),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_MSDC0_MST_F, CLK_TOP_A=
XI_SEL, 4),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_MSDC0_SLV_H, CLK_TOP_A=
XI_SEL, 5),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_MSDC1, CLK_TOP_MSDC30_=
1_SEL, 6),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_MSDC1_H, CLK_TOP_MSDC3=
0_1_HCLK_SEL, 7),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_MSDC1_MST_F, CLK_TOP_A=
XI_SEL, 8),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_MSDC1_SLV_H, CLK_TOP_A=
XI_SEL, 9),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_MSDC2, CLK_TOP_MSDC30_=
2_SEL, 10),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_MSDC2_H, CLK_TOP_MSDC3=
0_2_HCLK_SEL, 11),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_MSDC2_MST_F, CLK_TOP_A=
XI_SEL, 12),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_MSDC2_SLV_H, CLK_TOP_A=
XI_SEL, 13),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_SFLASH, CLK_TOP_SFLASH=
_SEL, 14),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_SFLASH_F, CLK_TOP_AXI_=
SEL, 15),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_SFLASH_H, CLK_TOP_AXI_=
SEL, 16),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_SFLASH_P, CLK_TOP_AXI_=
SEL, 17),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_BTIF_B, CLK_TOP_AXI_SE=
L, 18),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_CAN0_P, CLK_TOP_AXI_SE=
L, 20),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_CAN0, CLK_TOP_CAN0_SEL=
, 21),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_NFI_H, CLK_TOP_AXI_SEL=
, 22),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_NFI_B, CLK_TOP_NFI_BCL=
K_SEL, 23),
> +       GATE_INFRACFG_AO_REG6(CLK_INFRACFG_AO_REGP_NFIECC_B, CLK_TOP_NFI_=
BCLK_SEL, 24),
> +};
> +
> +static const struct mtk_clk_tree infracfg_ao_reg_clks_tree =3D {
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
> +       .gates =3D infracfg_ao_reg_clks,
> +       .num_gates =3D ARRAY_SIZE(infracfg_ao_reg_clks),
> +};
> +
> +static const struct mtk_gate_regs impc_cg_regs =3D {
> +       .set_ofs =3D 0xe08,
> +       .clr_ofs =3D 0xe04,
> +       .sta_ofs =3D 0xe00,
> +};
> +
> +#define GATE_IMPC(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &impc_cg_regs, _shift, \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
> +
> +static const struct mtk_gate impc_clks[] =3D {
> +       GATE_IMPC(CLK_IMPC_I2C1, CLK_TOP_I2CP_SEL, 0),
> +       GATE_IMPC(CLK_IMPC_I2C2, CLK_TOP_I2CP_SEL, 1),
> +       GATE_IMPC(CLK_IMPC_I2C3, CLK_TOP_I2CP_SEL, 2),
> +       GATE_IMPC(CLK_IMPC_I2C5, CLK_TOP_I2CP_SEL, 3),
> +       GATE_IMPC(CLK_IMPC_I2C6, CLK_TOP_I2CP_SEL, 4),
> +       GATE_IMPC(CLK_IMPC_I2C7, CLK_TOP_I2CP_SEL, 5),
> +       GATE_IMPC(CLK_IMPC_I2C8, CLK_TOP_I2CP_SEL, 6),
> +       GATE_IMPC(CLK_IMPC_I2C9, CLK_TOP_I2CP_SEL, 7),
> +};
> +
> +static const struct mtk_clk_tree impc_clks_tree =3D {
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
> +       .gates =3D impc_clks,
> +       .num_gates =3D ARRAY_SIZE(impc_clks),
> +};
> +
> +static const struct mtk_gate_regs impe_cg_regs =3D {
> +       .set_ofs =3D 0xe08,
> +       .clr_ofs =3D 0xe04,
> +       .sta_ofs =3D 0xe00,
> +};
> +
> +#define GATE_IMPE(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &impe_cg_regs, _shift, \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_SETCLR)
> +
> +static const struct mtk_gate impe_clks[] =3D {
> +       GATE_IMPE(CLK_IMPE_I2C0, CLK_TOP_I2C_SEL, 0),
> +       GATE_IMPE(CLK_IMPE_I2C4, CLK_TOP_I2C_SEL, 1),
> +};
> +
> +static const struct mtk_clk_tree impe_clks_tree =3D {
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
> +       .gates =3D impe_clks,
> +       .num_gates =3D ARRAY_SIZE(impe_clks),
> +};
> +
> +static const struct mtk_gate_regs mm0_cg_regs =3D {
> +       .set_ofs =3D 0x100,
> +       .clr_ofs =3D 0x100,
> +       .sta_ofs =3D 0x100,
> +};
> +
> +static const struct mtk_gate_regs mm1_cg_regs =3D {
> +       .set_ofs =3D 0x110,
> +       .clr_ofs =3D 0x110,
> +       .sta_ofs =3D 0x110,
> +};
> +
> +#define GATE_MM0(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &mm0_cg_regs, _shift,  \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_NO_SETCLR)
> +
> +#define GATE_MM1(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &mm1_cg_regs, _shift,  \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_NO_SETCLR)
> +
> +#define GATE_MM1E(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &mm1_cg_regs, _shift,  \
> +                  CLK_PARENT_EXT | CLK_GATE_NO_SETCLR)
> +
> +static const struct mtk_gate mm_clks[] =3D {
> +       /* MM0 */
> +       GATE_MM0(CLK_MM_DISP_OVL0_4L, CLK_TOP_DISP_SEL, 0),
> +       GATE_MM0(CLK_MM_DISP_OVL1_4L, CLK_TOP_DISP_SEL, 1),
> +       GATE_MM0(CLK_MM_DISP_RSZ0, CLK_TOP_DISP_SEL, 2),
> +       GATE_MM0(CLK_MM_DISP_RSZ1, CLK_TOP_DISP_SEL, 3),
> +       GATE_MM0(CLK_MM_DISP_RDMA0, CLK_TOP_DISP_SEL, 4),
> +       GATE_MM0(CLK_MM_DISP_RDMA1, CLK_TOP_DISP_SEL, 5),
> +       GATE_MM0(CLK_MM_DISP_COLOR1, CLK_TOP_DISP_SEL, 7),
> +       GATE_MM0(CLK_MM_DISP_CCORR1, CLK_TOP_DISP_SEL, 9),
> +       GATE_MM0(CLK_MM_DISP_CCORR3, CLK_TOP_DISP_SEL, 11),
> +       GATE_MM0(CLK_MM_DISP_AAL1, CLK_TOP_DISP_SEL, 13),
> +       GATE_MM0(CLK_MM_DISP_GAMMA1, CLK_TOP_DISP_SEL, 15),
> +       GATE_MM0(CLK_MM_DISP_DITHER1, CLK_TOP_DISP_SEL, 17),
> +       GATE_MM0(CLK_MM_VPP_MERGE0, CLK_TOP_DISP_SEL, 19),
> +       GATE_MM0(CLK_MM_DISP_DSI0_MM, CLK_TOP_DISP_SEL, 21),
> +       GATE_MM0(CLK_MM_DP_INTF0_MM, CLK_TOP_DISP_SEL, 22),
> +       GATE_MM0(CLK_MM_DPI0_MM, CLK_TOP_DISP_SEL, 23),
> +       GATE_MM0(CLK_MM_DISP_WDMA0, CLK_TOP_DISP_SEL, 24),
> +       GATE_MM0(CLK_MM_DISP_DSI1_MM, CLK_TOP_DISP_SEL, 25),
> +       GATE_MM0(CLK_MM_DISP_FAKE_ENG0, CLK_TOP_DISP_SEL, 26),
> +       GATE_MM0(CLK_MM_DISP_FAKE_ENG1, CLK_TOP_DISP_SEL, 27),
> +       GATE_MM0(CLK_MM_SMI_SUB_COMMON, CLK_TOP_DISP_SEL, 28),
> +       GATE_MM0(CLK_MM_DISP_MUTEX0, CLK_TOP_DISP_SEL, 29),
> +       GATE_MM0(CLK_MM_DISP_APB_BUS, CLK_TOP_DISP_SEL, 30),
> +       GATE_MM0(CLK_MM_LVDS_ENCODER, CLK_TOP_DISP_SEL, 31),
> +       /* MM1 */
> +       GATE_MM1(CLK_MM_EPD_DLI_ASYNC, CLK_TOP_DISP_SEL, 0),
> +       GATE_MM1(CLK_MM_SMI, CLK_TOP_DISP_SEL, 1),
> +       GATE_MM1(CLK_MM_DISP_DSI0, CLK_TOP_DSI_OCC_SEL, 2),
> +       GATE_MM1(CLK_MM_DPI0, CLK_TOP_VPLL_DPIX_SEL, 3),
> +       GATE_MM1(CLK_MM_LVDS_ENCODER_PXL, CLK_TOP_VPLL_DPIX_SEL, 4),
> +       GATE_MM1(CLK_MM_DISP_DSI1, CLK_TOP_DSI_OCC_SEL, 5),
> +       GATE_MM1(CLK_MM_DP_INTF0, CLK_TOP_DP_SEL, 6),
> +       GATE_MM1(CLK_MM_LVDS_ENCODER_CTS, CLK_TOP_LVDSTX_CLKDIG_CTS_SEL, =
7),
> +       GATE_MM1(CLK_MM_AXI, CLK_TOP_AXI_SEL, 8),
> +       GATE_MM1(CLK_MM_EPDSYS, CLK_TOP_EPD_SEL, 9),
> +       GATE_MM1(CLK_MM_MM_CK_GLOBAL, CLK_TOP_DISP_SEL, 10),
> +       GATE_MM1(CLK_MM_DISP_DSI0_CK_GLOBAL, CLK_TOP_DSI_OCC_SEL, 11),
> +       GATE_MM1(CLK_MM_LVDS_PXL_CK_GLOBAL, CLK_TOP_VPLL_DPIX_SEL, 12),
> +       GATE_MM1(CLK_MM_DISP_DSI1_GLOBAL, CLK_TOP_DSI_OCC_SEL, 13),
> +       GATE_MM1(CLK_MM_DP_CK_GLOBAL, CLK_TOP_DP_SEL, 14),
> +       GATE_MM1(CLK_MM_LVDS_CTS_CK_GLOBAL, CLK_TOP_LVDSTX_CLKDIG_CTS_SEL=
, 15),
> +       GATE_MM1(CLK_MM_AXI_CK_GLOBAL, CLK_TOP_AXI_SEL, 16),
> +       GATE_MM1(CLK_MM_EPDSYS_CK_GLOBAL, CLK_TOP_EPD_SEL, 17),
> +       GATE_MM1E(CLK_MM_26M, CLK_PAD_CLK26M, 18),
> +       GATE_MM1E(CLK_MM_32K, CLK_PAD_CLK32K, 19),
> +};
> +
> +static const struct mtk_clk_tree mm_clks_tree =3D {
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
> +       .gates =3D mm_clks,
> +       .num_gates =3D ARRAY_SIZE(mm_clks),
> +};
> +
> +static const struct mtk_gate_regs dptx_phyd_sifslv_dig_glb_cg_regs =3D {
> +       .set_ofs =3D 0x8,
> +       .clr_ofs =3D 0x8,
> +       .sta_ofs =3D 0x8,
> +};
> +
> +#define GATE_DPTX_PHYD_SIFSLV_DIG_GLB(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &dptx_phyd_sifslv_dig_glb_cg_regs, _shif=
t, \
> +                  CLK_PARENT_EXT | CLK_GATE_NO_SETCLR_INV)
> +
> +static const struct mtk_gate dptx_phyd_sifslv_dig_glb_clks[] =3D {
> +       GATE_DPTX_PHYD_SIFSLV_DIG_GLB(CLK_DPTX_PHYD_SIFSLV_DIG_GLB_RG_REF=
_CK_ENA,
> +                                     CLK_PAD_CLK26M, 0),
> +};
> +
> +static const struct mtk_clk_tree dptx_phyd_sifslv_dig_glb_clks_tree =3D =
{
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
> +       .gates =3D dptx_phyd_sifslv_dig_glb_clks,
> +       .num_gates =3D ARRAY_SIZE(dptx_phyd_sifslv_dig_glb_clks),
> +};
> +
> +static const struct mtk_gate_regs epdsys_config0_cg_regs =3D {
> +       .set_ofs =3D 0x100,
> +       .clr_ofs =3D 0x100,
> +       .sta_ofs =3D 0x100,
> +};
> +
> +static const struct mtk_gate_regs epdsys_config1_cg_regs =3D {
> +       .set_ofs =3D 0x110,
> +       .clr_ofs =3D 0x110,
> +       .sta_ofs =3D 0x110,
> +};
> +
> +#define GATE_EPDSYS_CONFIG0(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &epdsys_config0_cg_regs, _shift, \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_NO_SETCLR)
> +
> +#define GATE_EPDSYS_CONFIG1(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &epdsys_config1_cg_regs, _shift, \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_NO_SETCLR)
> +
> +#define GATE_EPDSYS_CONFIG1E(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &epdsys_config1_cg_regs, _shift, \
> +                  CLK_PARENT_EXT | CLK_GATE_NO_SETCLR)
> +
> +static const struct mtk_gate epdsys_config_clks[] =3D {
> +       /* EPDSYS_CONFIG0 */
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_PIPELINE_TOP, CLK_TOP_EPD_SEL, 0),
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_PIPELINE_IMAGE_RDMA, CLK_TOP_EPD_S=
EL, 1),
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_PIPELINE_WORKING_RDMA, CLK_TOP_EPD=
_SEL, 2),
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_PIPELINE_WDMA, CLK_TOP_EPD_SEL, 3)=
,
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_PIPELINE_WF_LUT_TOP, CLK_TOP_EPD_S=
EL, 4),
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_PIPELINE_DPI, CLK_TOP_EPD_SEL, 5),
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_PIPELINE_6, CLK_TOP_EPD_SEL, 6),
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_PIPELINE_IMAGE_PROCESS, CLK_TOP_EP=
D_SEL, 7),
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_DISP_COLOR, CLK_TOP_EPD_SEL, 12),
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_DISP_CCORR, CLK_TOP_EPD_SEL, 13),
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_DPI, CLK_TOP_EPD_DPI_SEL, 19),
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_TCON, CLK_TOP_EPD_DPI_SEL, 20),
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_SMI_LARB3, CLK_TOP_EPD_SEL, 23),
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_SMI_LARB8, CLK_TOP_EPD_SEL, 26),
> +       GATE_EPDSYS_CONFIG0(CLK_EPDSYS_IMG_DL_RELAY, CLK_TOP_EPD_SEL, 29)=
,
> +       /* EPDSYS_CONFIG1 */
> +       GATE_EPDSYS_CONFIG1E(CLK_EPDSYS_26M_HRTWT, CLK_PAD_CLK26M, 0),
> +       GATE_EPDSYS_CONFIG1(CLK_EPDSYS_DPI0_MM, CLK_TOP_EPD_SEL, 1),
> +};
> +
> +static const struct mtk_clk_tree epdsys_config_clks_tree =3D {
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
> +       .gates =3D epdsys_config_clks,
> +       .num_gates =3D ARRAY_SIZE(epdsys_config_clks),
> +};
> +
> +static const struct mtk_gate_regs gce_cg_regs =3D {
> +       .set_ofs =3D 0xf0,
> +       .clr_ofs =3D 0xf0,
> +       .sta_ofs =3D 0xf0,
> +};
> +
> +#define GATE_GCE(_id, _parent, _shift) \
> +       GATE_FLAGS(_id, _parent, &gce_cg_regs, _shift, \
> +                  CLK_PARENT_TOPCKGEN | CLK_GATE_NO_SETCLR)
> +
> +static const struct mtk_gate gce_clks[] =3D {
> +       GATE_GCE(CLK_GCE_TOP, CLK_INFRACFG_AO_REG_GCE, 16),
> +};
> +
> +static const struct mtk_clk_tree gce_clks_tree =3D {
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
> +       .gates =3D gce_clks,
> +       .num_gates =3D ARRAY_SIZE(gce_clks),
> +};
> +
> +static const struct udevice_id mt8366_apmixed_compat[] =3D {
> +       {
> +               .compatible =3D "mediatek,mt8366-apmixedsys",
> +               .data =3D (ulong)&mt8366_apmixed_tree,
> +       },
> +       { }
> +};
> +
> +static const struct udevice_id mt8366_clk_compat[] =3D {
> +       {
> +               .compatible =3D "mediatek,mt8366-topckgen",
> +               .data =3D (ulong)&mt8366_topckgen_tree,
> +       },
> +       {
> +               .compatible =3D "mediatek,mt8366-infracfg-ao",
> +               .data =3D (ulong)&infracfg_ao_reg_clks_tree,
> +       },
> +       {
> +               .compatible =3D "mediatek,mt8366-iic-wrap-c",
> +               .data =3D (ulong)&impc_clks_tree,
> +       },
> +       {
> +               .compatible =3D "mediatek,mt8366-iic-wrap-e",
> +               .data =3D (ulong)&impe_clks_tree,
> +       },
> +       {
> +               .compatible =3D "mediatek,mt8366-dispsys",
> +               .data =3D (ulong)&mm_clks_tree,
> +       },
> +       {
> +               .compatible =3D "mediatek,mt8366-dptx",
> +               .data =3D (ulong)&dptx_phyd_sifslv_dig_glb_clks_tree,
> +       },
> +       {
> +               .compatible =3D "mediatek,mt8366-epdsys",
> +               .data =3D (ulong)&epdsys_config_clks_tree,
> +       },
> +       {
> +               .compatible =3D "mediatek,mt8366-gce",
> +               .data =3D (ulong)&gce_clks_tree,
> +       },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(mt8366_clk_apmixedsys) =3D {
> +       .name =3D "mt8366-apmixedsys",
> +       .id =3D UCLASS_CLK,
> +       .of_match =3D mt8366_apmixed_compat,
> +       .probe =3D mtk_clk_probe,
> +       .priv_auto =3D sizeof(struct mtk_clk_priv),
> +       .ops =3D &mtk_clk_apmixedsys_ops,
> +       .flags =3D DM_FLAG_PRE_RELOC,
> +};
> +
> +U_BOOT_DRIVER(mt8366_clk) =3D {
> +       .name =3D "mt8366-clk",
> +       .id =3D UCLASS_CLK,
> +       .of_match =3D mt8366_clk_compat,
> +       .probe =3D mtk_clk_probe,
> +       .priv_auto =3D sizeof(struct mtk_clk_priv),
> +       .ops =3D &mtk_clk_topckgen_ops,
> +       .flags =3D DM_FLAG_PRE_RELOC,
> +};
>
> ---
> base-commit: 4e93493a1b9c1866abcd46bb41bbcf86edd940bf
> change-id: 20260803-mtk-clk-mt8366-cbf571077097
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
