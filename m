Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFDAC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 13:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F01740AAA;
	Fri,  7 Aug 2026 13:08:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BC3VfwzzUSTC; Fri,  7 Aug 2026 13:08:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FF0540A83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786108082;
	bh=SEyotF8hGX/cfAoY8LTl2yaxUomJZVBPBufbCIvZtTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=isfxWdAqVWloKDKtBoJdWIwjsawhArBHVXz4ORzOJwYzmQVvXyDWSuwWLEwZsFx4h
	 /Q+CmgUeQF2K/igNVWpDm0xwfY+/xpSD0anIIKksJSzIK+IgkfgCIrl1YCLFjVMHjN
	 /AWHPPWeP8edveXLeR4vmcZbuzy/TsOSNrGAJ/XZ40XpioNnRvkGqYoJJSU4YYEDgj
	 yccSk5cHjJd8Mjaq8ZFlrAfRoJrbCUEXuQhdT+6wShI8eqiDp5VeR4+wXjvHHtsSLS
	 FlDglf04ehmeW3vzCS7LzFs7IsaToFrHL5BbEP4VT3JQQm87x7gMm1VnDUxwSmp6UT
	 62QURbukrBULg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FF0540A83;
	Fri,  7 Aug 2026 13:08:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A4EF392
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60CC240270
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:08:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aqWaQb_p_y6Y for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 13:07:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 38D57400FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38D57400FE
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38D57400FE
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:07:57 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so434524366b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 06:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786108076; cv=none;
 d=google.com; s=arc-20260327;
 b=dG+mcEsjCM9zZWCutsoo1AZrAUUrREKH8iu++cVnUNfmsXkH8IEEFon05RBHKdKTmf
 eojOPyN6b+4jJpvJw/nclGijy08hFYOekkKV8wyXyXIW+86IXyqTzRXIa3+3MsZwVkPV
 Xnl/euFKT0KsNLzeMfMcjBfG0BXsPsgNWRDbKlMhi2STM5eiClHMnWssOoJxjCINgRhH
 WKdvPr1QJrOFvJLUWZLz+IIbkZeNWpyt7s0yW8RJxxY63XPlw/o2vmVPWcd5paM7sort
 Q24E/LzmOGDvtmbtoICM4WWMAkt4/jINVcY5fE7BfhbjhAsFCr2cebUhkcnSz8K4cRB7
 hnNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SEyotF8hGX/cfAoY8LTl2yaxUomJZVBPBufbCIvZtTI=;
 fh=iRikB6WQhpGZSVqKURLTrD02niQXIDjtrvBys31Pbxk=;
 b=X3jCxwg0GXNRC4RycrbVzoZ5/unb2JTqJoyjcqbivfi2fAGz8XxULp9tRHUJjDWsK/
 q6vW8XBEqQMqYZaDCfHv6Sm9QFcADH5y/TM+ZZt00ADL1nNa6ZiyV/7BGo6I9xVAk+4E
 2BFBAXWxtl39jGSMy0dRuzkYUtcWrtCPxqP9MJk55WeJPiztUWUE5Lpq2wafn2qcX/mw
 HjK4/KXlqhu1V4uzxUPt92nb5WQAO9JofvBW3QQRFBimWjpz3JJrPKk+ILZrKihR+9yq
 J/IFwOvN8Wgy8v6qouaKLdroz1zxTwT22kmfYGMxvCiymfVB8pxDbSTeisIrzavcNCLc
 G+Lw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786108076; x=1786712876;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SEyotF8hGX/cfAoY8LTl2yaxUomJZVBPBufbCIvZtTI=;
 b=WKP6dPdCoJSIqLhVe+bjx8FTux0jLybVpNg4Z5maMDk7gY3YlNGzO3Lxtw4gx3bxdy
 VEmfu1Sd1zHzFED/NjlfleNy/bgzjhf3sHPW0zEVJF/WaV1U7ovczHhfYHqIJI47DU2D
 X1TYLoYvUxwlrOqGEIQ2uBznGYIj8glmq2AV6aCShu5spPKd9Tx4PanFs+zDGkTsMSkv
 I8jk2coQY881CrSZQmoW6tUBAh6UzKTYINO4cuAh6ZxwENgEAzlOvs5Sb4+Md5yfcHge
 jfvzmAo6Zqb3FKjoGMTkh+e3G+2bSPyjYCHrju3THBP2LiLGfXyph8zdeVKg7Xpmm8Ue
 eUZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLyhsGsHoJ3C0tl3bc1uyt3VaC+jAmfmegvx1bh4ZgpLJ6duS7O1TcuR67BRfXBSlavGMkhlM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzTm55Xyo87ZgLj+MB6t1ZIR+OSi7Htb3anMxfQD1rPLPlmy07C
 KVna4IBpyg7Tu63PVvHjvaKg4ac0h1jAcsknhrZBpuO3Nn4sOYoEFli6sxCGkUyC/SUk6uYz3MR
 ua2c6XNOY3teKT2rBSI9NGYPfOy9pAE3Hnn1h3JtaHw==
X-Gm-Gg: AR+sD137BGN0tnkzmhRQ2SEpJk/PR5hkTl2FNYSf3yG17hl54o976xiWWQ1x6ULeldh
 bvRa9zWR4/Hcy7zx/2R6TAa+UX5wyv6btB3ajZM+dpsCNmKazSTeDo98OdDx+wDTM6SOX4rYVWc
 gRv+JQw+uq4RgrDxBDSEusa+JZ/Akut1kg7awKNEVvHfQ6L9F1K826q8sjSISVIx/GApva/WHBr
 14G2bdaDPR0MXoPUOYBU4LHBHreclOKqZQXsHscYkddfp+U+M624eXoNQTt1wM3JN0O+rod7wav
 mB6733PXvJEfBAhb5aKoeb5rnTCYiquvNuT0lz/gPc0CNw9LcOrz5FV3a2zA3HJYptQHOWzfwaE
 32tWnYp5kswOfHP2QdbHyfASpDtk7ItU6UCiYM1Ah0pIOrBSkEpCjxvjtpe+UHrY=
X-Received: by 2002:a17:907:3e08:b0:c1c:3b06:ed03 with SMTP id
 a640c23a62f3a-c2039c74c1amr1238980166b.23.1786108075291; Fri, 07 Aug 2026
 06:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-mtk-pinctrl-mt8366-v1-1-247d327e21b6@baylibre.com>
In-Reply-To: <20260803-mtk-pinctrl-mt8366-v1-1-247d327e21b6@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 15:07:44 +0200
X-Gm-Features: AUfX_mw37bJV26zf2f6Co57I1P5HA7H-Ve7-VhA6GUOIlc70JJGQwwJUyS5wvbk
Message-ID: <CAEHHSvYOrAeETQPaye47k6KtZYF4reo1dn+SpeirnV=e4=dpug@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: add new mt8366 driver
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, 
 Deep Pani <deep.pani@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786108076; x=1786712876;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SEyotF8hGX/cfAoY8LTl2yaxUomJZVBPBufbCIvZtTI=;
 b=YY2tgnOwDASgo9s3sRaPuOkAw4XG8sV2ZeyrVowPhCyKpGZBOHjMU14LWt1UKu4a5Z
 3nWVE5x03SqpbOlIj49LZYOxPXCBfSl/aguTJ8xu2CMmvFnKnRkvPaYRzQo6okrrDFX+
 FtQpUp4bm1y+31d8oIsoaFdkksQUkX+D2Ul54CHszoEp1Az6Nc5jHk+wPTbVmK1Wg2nV
 QcxHwbLpIUm4i7BUTYPqAQ5WIkyRanfIIxrAfrhXb8LSb8vv9H4tB4M6K9lpHAnaUggx
 6S23ZzdiKpWIOVycFgRFP2X8eu7AP4wuVDH8OZ3zdNc8aSgg7o8om9XgjS1G4j9vVt9+
 7msg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YY2tgnOw
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

Le lun. 3 ao=C3=BBt 2026 =C3=A0 23:35, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit :
>
> From: Deep Pani <deep.pani@mediatek.com>
>
> Add driver containing pinctrl register maps for MT8366.
>
> Signed-off-by: Deep Pani <deep.pani@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This will be used by Genio 360, which will be added in a separate series.
> Tested on Genio 360 EVK.
> ---
>  drivers/pinctrl/mediatek/Makefile         |    1 +
>  drivers/pinctrl/mediatek/pinctrl-mt8366.c | 1233 +++++++++++++++++++++++=
++++++
>  2 files changed, 1234 insertions(+)
>
> diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek=
/Makefile
> index 983de040ba3..8dd2a63149b 100644
> --- a/drivers/pinctrl/mediatek/Makefile
> +++ b/drivers/pinctrl/mediatek/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_TARGET_MT8188) +=3D pinctrl-mt8188.o
>  obj-$(CONFIG_TARGET_MT8195) +=3D pinctrl-mt8195.o
>  obj-$(CONFIG_TARGET_MT8189) +=3D pinctrl-mt8189.o
>  obj-$(CONFIG_TARGET_MT8365) +=3D pinctrl-mt8365.o
> +obj-$(CONFIG_TARGET_MT8366) +=3D pinctrl-mt8366.o
>  obj-$(CONFIG_TARGET_MT8512) +=3D pinctrl-mt8512.o
>  obj-$(CONFIG_TARGET_MT8516) +=3D pinctrl-mt8516.o
>  obj-$(CONFIG_TARGET_MT8518) +=3D pinctrl-mt8518.o
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8366.c b/drivers/pinctrl/=
mediatek/pinctrl-mt8366.c
> new file mode 100644
> index 00000000000..9177c3dd18c
> --- /dev/null
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8366.c
> @@ -0,0 +1,1233 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * The MT8366 driver based on Linux generic pinctrl binding.
> + *
> + * Copyright (C) 2026 MediaTek Inc.
> + * Author: Deep Pani <deep.pani@mediatek.com>
> + * Author: David Lechner <dlechner@baylibre.com>
> + */
> +#include <dm.h>
> +#include "pinctrl-mtk-common.h"
> +
> +#define PIN_FIELD_GPIO(_s_pin, _e_pin, _s_addr, _s_bit, _x_bits)        =
       \
> +       PIN_FIELD_BASE_CALC(_s_pin, _e_pin, GPIO_BASE, _s_addr, 0x10, _s_=
bit,   \
> +                           _x_bits, 32, 0)
> +
> +#define PIN_FIELD_BASE(_s_pin, _i_base, _s_addr, _s_bit, _x_bits)       =
       \
> +       PIN_FIELD_BASE_CALC(_s_pin, _s_pin, _i_base, _s_addr, 0x10, _s_bi=
t,     \
> +                           _x_bits, 32, 0)
> +
> +enum {
> +       GPIO_BASE,
> +       IOCFG_RM_BASE,
> +       IOCFG_BM_BASE,
> +       IOCFG_LB_BASE,
> +       IOCFG_TR_BASE,
> +       IOCFG_LT_BASE,
> +       IOCFG_TL_BASE,
> +};
> +
> +static const char * const mt8366_pinctrl_register_base_names[] =3D {
> +       "gpio", "iocfg_rm", "iocfg_bm",
> +       "iocfg_lb", "iocfg_tr", "iocfg_lt",
> +       "iocfg_tl",
> +};
> +
> +static const struct mtk_pin_field_calc mt8366_pin_mode_range[] =3D {
> +       PIN_FIELD_GPIO(0, 171, 0x300, 0, 4),
> +};
> +
> +static const struct mtk_pin_field_calc mt8366_pin_dir_range[] =3D {
> +       PIN_FIELD_GPIO(0, 171, 0x0, 0, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8366_pin_di_range[] =3D {
> +       PIN_FIELD_GPIO(0, 171, 0x200, 0, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8366_pin_do_range[] =3D {
> +       PIN_FIELD_GPIO(0, 171, 0x100, 0, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8366_pin_smt_range[] =3D {
> +       PIN_FIELD_BASE(0, IOCFG_RM_BASE, 0x0100, 8, 1),
> +       PIN_FIELD_BASE(1, IOCFG_RM_BASE, 0x0100, 8, 1),
> +       PIN_FIELD_BASE(2, IOCFG_RM_BASE, 0x0100, 8, 1),
> +       PIN_FIELD_BASE(3, IOCFG_LB_BASE, 0x0100, 8, 1),
> +       PIN_FIELD_BASE(4, IOCFG_LB_BASE, 0x0100, 8, 1),
> +       PIN_FIELD_BASE(5, IOCFG_LB_BASE, 0x0100, 8, 1),
> +       PIN_FIELD_BASE(6, IOCFG_LB_BASE, 0x0100, 12, 1),
> +       PIN_FIELD_BASE(7, IOCFG_LB_BASE, 0x0100, 11, 1),
> +       PIN_FIELD_BASE(8, IOCFG_LB_BASE, 0x0100, 12, 1),
> +       PIN_FIELD_BASE(9, IOCFG_LB_BASE, 0x0100, 8, 1),
> +       PIN_FIELD_BASE(10, IOCFG_LB_BASE, 0x0100, 8, 1),
> +       PIN_FIELD_BASE(11, IOCFG_LB_BASE, 0x0100, 12, 1),
> +       PIN_FIELD_BASE(12, IOCFG_BM_BASE, 0x0170, 0, 1),
> +       PIN_FIELD_BASE(13, IOCFG_BM_BASE, 0x0170, 1, 1),
> +       PIN_FIELD_BASE(14, IOCFG_BM_BASE, 0x0170, 12, 1),
> +       PIN_FIELD_BASE(15, IOCFG_BM_BASE, 0x0170, 17, 1),
> +       PIN_FIELD_BASE(16, IOCFG_BM_BASE, 0x0170, 18, 1),
> +       PIN_FIELD_BASE(17, IOCFG_BM_BASE, 0x0170, 19, 1),
> +       PIN_FIELD_BASE(18, IOCFG_BM_BASE, 0x0170, 20, 1),
> +       PIN_FIELD_BASE(19, IOCFG_BM_BASE, 0x0170, 21, 1),
> +       PIN_FIELD_BASE(20, IOCFG_BM_BASE, 0x0170, 22, 1),
> +       PIN_FIELD_BASE(21, IOCFG_BM_BASE, 0x0170, 23, 1),
> +       PIN_FIELD_BASE(22, IOCFG_BM_BASE, 0x0170, 2, 1),
> +       PIN_FIELD_BASE(23, IOCFG_BM_BASE, 0x0170, 3, 1),
> +       PIN_FIELD_BASE(24, IOCFG_BM_BASE, 0x0170, 4, 1),
> +       PIN_FIELD_BASE(25, IOCFG_BM_BASE, 0x0170, 5, 1),
> +       PIN_FIELD_BASE(26, IOCFG_BM_BASE, 0x0170, 6, 1),
> +       PIN_FIELD_BASE(27, IOCFG_BM_BASE, 0x0170, 7, 1),
> +       PIN_FIELD_BASE(28, IOCFG_BM_BASE, 0x0170, 8, 1),
> +       PIN_FIELD_BASE(29, IOCFG_BM_BASE, 0x0170, 9, 1),
> +       PIN_FIELD_BASE(30, IOCFG_BM_BASE, 0x0170, 10, 1),
> +       PIN_FIELD_BASE(31, IOCFG_BM_BASE, 0x0170, 11, 1),
> +       PIN_FIELD_BASE(32, IOCFG_BM_BASE, 0x0170, 13, 1),
> +       PIN_FIELD_BASE(33, IOCFG_BM_BASE, 0x0170, 14, 1),
> +       PIN_FIELD_BASE(34, IOCFG_BM_BASE, 0x0170, 15, 1),
> +       PIN_FIELD_BASE(35, IOCFG_BM_BASE, 0x0170, 16, 1),
> +       PIN_FIELD_BASE(36, IOCFG_BM_BASE, 0x0170, 28, 1),
> +       PIN_FIELD_BASE(37, IOCFG_BM_BASE, 0x0170, 29, 1),
> +       PIN_FIELD_BASE(38, IOCFG_BM_BASE, 0x0170, 30, 1),
> +       PIN_FIELD_BASE(39, IOCFG_BM_BASE, 0x0170, 24, 1),
> +       PIN_FIELD_BASE(40, IOCFG_BM_BASE, 0x0170, 25, 1),
> +       PIN_FIELD_BASE(41, IOCFG_BM_BASE, 0x0170, 26, 1),
> +       PIN_FIELD_BASE(42, IOCFG_BM_BASE, 0x0180, 0, 1),
> +       PIN_FIELD_BASE(43, IOCFG_BM_BASE, 0x0180, 9, 1),
> +       PIN_FIELD_BASE(44, IOCFG_BM_BASE, 0x0180, 7, 1),
> +       PIN_FIELD_BASE(45, IOCFG_BM_BASE, 0x0180, 7, 1),
> +       PIN_FIELD_BASE(46, IOCFG_BM_BASE, 0x0180, 7, 1),
> +       PIN_FIELD_BASE(47, IOCFG_BM_BASE, 0x0170, 27, 1),
> +       PIN_FIELD_BASE(48, IOCFG_BM_BASE, 0x0180, 7, 1),
> +       PIN_FIELD_BASE(49, IOCFG_BM_BASE, 0x0180, 8, 1),
> +       PIN_FIELD_BASE(50, IOCFG_BM_BASE, 0x0170, 31, 1),
> +       PIN_FIELD_BASE(51, IOCFG_BM_BASE, 0x0180, 8, 1),
> +       PIN_FIELD_BASE(52, IOCFG_RM_BASE, 0x0100, 10, 1),
> +       PIN_FIELD_BASE(53, IOCFG_RM_BASE, 0x0100, 10, 1),
> +       PIN_FIELD_BASE(54, IOCFG_RM_BASE, 0x0100, 10, 1),
> +       PIN_FIELD_BASE(55, IOCFG_RM_BASE, 0x0100, 11, 1),
> +       PIN_FIELD_BASE(56, IOCFG_LT_BASE, 0x0090, 3, 1),
> +       PIN_FIELD_BASE(57, IOCFG_RM_BASE, 0x0100, 8, 1),
> +       PIN_FIELD_BASE(58, IOCFG_RM_BASE, 0x0100, 8, 1),
> +       PIN_FIELD_BASE(59, IOCFG_RM_BASE, 0x0100, 0, 1),
> +       PIN_FIELD_BASE(60, IOCFG_RM_BASE, 0x0100, 8, 1),
> +       PIN_FIELD_BASE(61, IOCFG_RM_BASE, 0x0100, 8, 1),
> +       PIN_FIELD_BASE(62, IOCFG_RM_BASE, 0x0100, 1, 1),
> +       PIN_FIELD_BASE(63, IOCFG_LB_BASE, 0x0100, 11, 1),
> +       PIN_FIELD_BASE(64, IOCFG_LB_BASE, 0x0100, 11, 1),
> +       PIN_FIELD_BASE(65, IOCFG_LB_BASE, 0x0100, 11, 1),
> +       PIN_FIELD_BASE(66, IOCFG_LB_BASE, 0x0100, 14, 1),
> +       PIN_FIELD_BASE(67, IOCFG_LB_BASE, 0x0100, 14, 1),
> +       PIN_FIELD_BASE(68, IOCFG_LB_BASE, 0x0100, 9, 1),
> +       PIN_FIELD_BASE(69, IOCFG_LB_BASE, 0x0100, 9, 1),
> +       PIN_FIELD_BASE(70, IOCFG_LB_BASE, 0x0100, 9, 1),
> +       PIN_FIELD_BASE(71, IOCFG_LB_BASE, 0x0100, 9, 1),
> +       PIN_FIELD_BASE(72, IOCFG_LB_BASE, 0x0100, 14, 1),
> +       PIN_FIELD_BASE(73, IOCFG_LB_BASE, 0x0100, 9, 1),
> +       PIN_FIELD_BASE(74, IOCFG_LB_BASE, 0x0100, 13, 1),
> +       PIN_FIELD_BASE(75, IOCFG_LB_BASE, 0x0100, 13, 1),
> +       PIN_FIELD_BASE(76, IOCFG_LB_BASE, 0x0100, 12, 1),
> +       PIN_FIELD_BASE(77, IOCFG_LB_BASE, 0x0100, 13, 1),
> +       PIN_FIELD_BASE(78, IOCFG_LB_BASE, 0x0100, 13, 1),
> +       PIN_FIELD_BASE(79, IOCFG_RM_BASE, 0x0100, 11, 1),
> +       PIN_FIELD_BASE(80, IOCFG_RM_BASE, 0x0100, 9, 1),
> +       PIN_FIELD_BASE(81, IOCFG_RM_BASE, 0x0100, 11, 1),
> +       PIN_FIELD_BASE(82, IOCFG_RM_BASE, 0x0100, 9, 1),
> +       PIN_FIELD_BASE(83, IOCFG_RM_BASE, 0x0100, 9, 1),
> +       PIN_FIELD_BASE(84, IOCFG_RM_BASE, 0x0100, 9, 1),
> +       PIN_FIELD_BASE(85, IOCFG_RM_BASE, 0x0100, 9, 1),
> +       PIN_FIELD_BASE(86, IOCFG_RM_BASE, 0x0100, 9, 1),
> +       PIN_FIELD_BASE(87, IOCFG_RM_BASE, 0x0100, 9, 1),
> +       PIN_FIELD_BASE(88, IOCFG_RM_BASE, 0x0100, 10, 1),
> +       PIN_FIELD_BASE(89, IOCFG_RM_BASE, 0x0100, 11, 1),
> +       PIN_FIELD_BASE(90, IOCFG_LB_BASE, 0x0100, 2, 1),
> +       PIN_FIELD_BASE(91, IOCFG_LB_BASE, 0x0100, 0, 1),
> +       PIN_FIELD_BASE(92, IOCFG_LB_BASE, 0x0100, 3, 1),
> +       PIN_FIELD_BASE(93, IOCFG_LB_BASE, 0x0100, 1, 1),
> +       PIN_FIELD_BASE(94, IOCFG_LB_BASE, 0x0100, 6, 1),
> +       PIN_FIELD_BASE(95, IOCFG_LB_BASE, 0x0100, 4, 1),
> +       PIN_FIELD_BASE(96, IOCFG_LB_BASE, 0x0100, 7, 1),
> +       PIN_FIELD_BASE(97, IOCFG_LB_BASE, 0x0100, 5, 1),
> +       PIN_FIELD_BASE(98, IOCFG_LT_BASE, 0x0090, 4, 1),
> +       PIN_FIELD_BASE(99, IOCFG_LT_BASE, 0x0090, 6, 1),
> +       PIN_FIELD_BASE(100, IOCFG_RM_BASE, 0x0100, 12, 1),
> +       PIN_FIELD_BASE(101, IOCFG_RM_BASE, 0x0100, 15, 1),
> +       PIN_FIELD_BASE(102, IOCFG_RM_BASE, 0x0100, 13, 1),
> +       PIN_FIELD_BASE(103, IOCFG_RM_BASE, 0x0100, 16, 1),
> +       PIN_FIELD_BASE(104, IOCFG_RM_BASE, 0x0100, 14, 1),
> +       PIN_FIELD_BASE(105, IOCFG_RM_BASE, 0x0100, 17, 1),
> +       PIN_FIELD_BASE(106, IOCFG_LT_BASE, 0x0090, 5, 1),
> +       PIN_FIELD_BASE(107, IOCFG_LT_BASE, 0x0090, 7, 1),
> +       PIN_FIELD_BASE(108, IOCFG_LB_BASE, 0x0100, 15, 1),
> +       PIN_FIELD_BASE(109, IOCFG_LB_BASE, 0x0100, 20, 1),
> +       PIN_FIELD_BASE(110, IOCFG_LB_BASE, 0x0100, 16, 1),
> +       PIN_FIELD_BASE(111, IOCFG_LB_BASE, 0x0100, 21, 1),
> +       PIN_FIELD_BASE(112, IOCFG_LB_BASE, 0x0100, 17, 1),
> +       PIN_FIELD_BASE(113, IOCFG_LB_BASE, 0x0100, 22, 1),
> +       PIN_FIELD_BASE(114, IOCFG_LB_BASE, 0x0100, 18, 1),
> +       PIN_FIELD_BASE(115, IOCFG_LB_BASE, 0x0100, 23, 1),
> +       PIN_FIELD_BASE(116, IOCFG_LB_BASE, 0x0100, 24, 1),
> +       PIN_FIELD_BASE(117, IOCFG_LB_BASE, 0x0100, 19, 1),
> +       PIN_FIELD_BASE(118, IOCFG_LB_BASE, 0x0100, 25, 1),
> +       PIN_FIELD_BASE(119, IOCFG_LB_BASE, 0x0100, 26, 1),
> +       PIN_FIELD_BASE(120, IOCFG_LB_BASE, 0x0100, 28, 1),
> +       PIN_FIELD_BASE(121, IOCFG_LB_BASE, 0x0100, 27, 1),
> +       PIN_FIELD_BASE(122, IOCFG_TR_BASE, 0x0090, 10, 1),
> +       PIN_FIELD_BASE(123, IOCFG_TR_BASE, 0x0090, 0, 1),
> +       PIN_FIELD_BASE(124, IOCFG_TR_BASE, 0x0090, 1, 1),
> +       PIN_FIELD_BASE(125, IOCFG_TR_BASE, 0x0090, 11, 1),
> +       PIN_FIELD_BASE(126, IOCFG_TR_BASE, 0x0090, 2, 1),
> +       PIN_FIELD_BASE(127, IOCFG_TR_BASE, 0x0090, 3, 1),
> +       PIN_FIELD_BASE(128, IOCFG_TR_BASE, 0x0090, 4, 1),
> +       PIN_FIELD_BASE(129, IOCFG_TR_BASE, 0x0090, 5, 1),
> +       PIN_FIELD_BASE(130, IOCFG_TR_BASE, 0x0090, 6, 1),
> +       PIN_FIELD_BASE(131, IOCFG_TR_BASE, 0x0090, 7, 1),
> +       PIN_FIELD_BASE(132, IOCFG_TR_BASE, 0x0090, 8, 1),
> +       PIN_FIELD_BASE(133, IOCFG_TR_BASE, 0x0090, 9, 1),
> +       PIN_FIELD_BASE(134, IOCFG_BM_BASE, 0x0180, 1, 1),
> +       PIN_FIELD_BASE(135, IOCFG_BM_BASE, 0x0180, 2, 1),
> +       PIN_FIELD_BASE(136, IOCFG_BM_BASE, 0x0180, 3, 1),
> +       PIN_FIELD_BASE(137, IOCFG_BM_BASE, 0x0180, 4, 1),
> +       PIN_FIELD_BASE(138, IOCFG_BM_BASE, 0x0180, 5, 1),
> +       PIN_FIELD_BASE(139, IOCFG_BM_BASE, 0x0180, 6, 1),
> +       PIN_FIELD_BASE(140, IOCFG_RM_BASE, 0x0100, 2, 1),
> +       PIN_FIELD_BASE(141, IOCFG_RM_BASE, 0x0100, 3, 1),
> +       PIN_FIELD_BASE(142, IOCFG_RM_BASE, 0x0100, 4, 1),
> +       PIN_FIELD_BASE(143, IOCFG_RM_BASE, 0x0100, 5, 1),
> +       PIN_FIELD_BASE(144, IOCFG_RM_BASE, 0x0100, 6, 1),
> +       PIN_FIELD_BASE(145, IOCFG_RM_BASE, 0x0100, 7, 1),
> +       PIN_FIELD_BASE(146, IOCFG_LB_BASE, 0x0100, 10, 1),
> +       PIN_FIELD_BASE(147, IOCFG_LB_BASE, 0x0100, 10, 1),
> +       PIN_FIELD_BASE(148, IOCFG_LB_BASE, 0x0100, 10, 1),
> +       PIN_FIELD_BASE(149, IOCFG_LB_BASE, 0x0100, 10, 1),
> +       PIN_FIELD_BASE(150, IOCFG_LB_BASE, 0x0100, 10, 1),
> +       PIN_FIELD_BASE(151, IOCFG_LB_BASE, 0x0100, 10, 1),
> +       PIN_FIELD_BASE(152, IOCFG_LB_BASE, 0x0100, 10, 1),
> +       PIN_FIELD_BASE(153, IOCFG_LB_BASE, 0x0100, 10, 1),
> +       PIN_FIELD_BASE(154, IOCFG_LB_BASE, 0x0100, 10, 1),
> +       PIN_FIELD_BASE(155, IOCFG_LT_BASE, 0x0090, 1, 1),
> +       PIN_FIELD_BASE(156, IOCFG_LT_BASE, 0x0090, 2, 1),
> +       PIN_FIELD_BASE(157, IOCFG_LT_BASE, 0x0090, 1, 1),
> +       PIN_FIELD_BASE(158, IOCFG_LT_BASE, 0x0090, 3, 1),
> +       PIN_FIELD_BASE(159, IOCFG_LT_BASE, 0x0090, 2, 1),
> +       PIN_FIELD_BASE(160, IOCFG_LT_BASE, 0x0090, 2, 1),
> +       PIN_FIELD_BASE(161, IOCFG_LT_BASE, 0x0090, 2, 1),
> +       PIN_FIELD_BASE(162, IOCFG_LT_BASE, 0x0090, 1, 1),
> +       PIN_FIELD_BASE(163, IOCFG_TL_BASE, 0x0050, 1, 1),
> +       PIN_FIELD_BASE(164, IOCFG_TL_BASE, 0x0050, 1, 1),
> +       PIN_FIELD_BASE(165, IOCFG_TL_BASE, 0x0050, 1, 1),
> +       PIN_FIELD_BASE(166, IOCFG_TL_BASE, 0x0050, 1, 1),
> +       PIN_FIELD_BASE(167, IOCFG_TL_BASE, 0x0050, 2, 1),
> +       PIN_FIELD_BASE(168, IOCFG_TL_BASE, 0x0050, 2, 1),
> +       PIN_FIELD_BASE(169, IOCFG_LT_BASE, 0x0090, 0, 1),
> +       PIN_FIELD_BASE(170, IOCFG_LT_BASE, 0x0090, 1, 1),
> +       PIN_FIELD_BASE(171, IOCFG_TL_BASE, 0x0050, 0, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8366_pin_ies_range[] =3D {
> +       PIN_FIELD_BASE(0, IOCFG_RM_BASE, 0x0060, 9, 1),
> +       PIN_FIELD_BASE(1, IOCFG_RM_BASE, 0x0060, 10, 1),
> +       PIN_FIELD_BASE(2, IOCFG_RM_BASE, 0x0060, 11, 1),
> +       PIN_FIELD_BASE(3, IOCFG_LB_BASE, 0x0070, 13, 1),
> +       PIN_FIELD_BASE(4, IOCFG_LB_BASE, 0x0070, 14, 1),
> +       PIN_FIELD_BASE(5, IOCFG_LB_BASE, 0x0070, 15, 1),
> +       PIN_FIELD_BASE(6, IOCFG_LB_BASE, 0x0070, 16, 1),
> +       PIN_FIELD_BASE(7, IOCFG_LB_BASE, 0x0070, 17, 1),
> +       PIN_FIELD_BASE(8, IOCFG_LB_BASE, 0x0070, 18, 1),
> +       PIN_FIELD_BASE(9, IOCFG_LB_BASE, 0x0070, 19, 1),
> +       PIN_FIELD_BASE(10, IOCFG_LB_BASE, 0x0070, 11, 1),
> +       PIN_FIELD_BASE(11, IOCFG_LB_BASE, 0x0070, 12, 1),
> +       PIN_FIELD_BASE(12, IOCFG_BM_BASE, 0x0050, 0, 1),
> +       PIN_FIELD_BASE(13, IOCFG_BM_BASE, 0x0050, 1, 1),
> +       PIN_FIELD_BASE(14, IOCFG_BM_BASE, 0x0050, 12, 1),
> +       PIN_FIELD_BASE(15, IOCFG_BM_BASE, 0x0050, 17, 1),
> +       PIN_FIELD_BASE(16, IOCFG_BM_BASE, 0x0050, 18, 1),
> +       PIN_FIELD_BASE(17, IOCFG_BM_BASE, 0x0050, 19, 1),
> +       PIN_FIELD_BASE(18, IOCFG_BM_BASE, 0x0050, 20, 1),
> +       PIN_FIELD_BASE(19, IOCFG_BM_BASE, 0x0050, 21, 1),
> +       PIN_FIELD_BASE(20, IOCFG_BM_BASE, 0x0050, 22, 1),
> +       PIN_FIELD_BASE(21, IOCFG_BM_BASE, 0x0050, 23, 1),
> +       PIN_FIELD_BASE(22, IOCFG_BM_BASE, 0x0050, 2, 1),
> +       PIN_FIELD_BASE(23, IOCFG_BM_BASE, 0x0050, 3, 1),
> +       PIN_FIELD_BASE(24, IOCFG_BM_BASE, 0x0050, 4, 1),
> +       PIN_FIELD_BASE(25, IOCFG_BM_BASE, 0x0050, 5, 1),
> +       PIN_FIELD_BASE(26, IOCFG_BM_BASE, 0x0050, 6, 1),
> +       PIN_FIELD_BASE(27, IOCFG_BM_BASE, 0x0050, 7, 1),
> +       PIN_FIELD_BASE(28, IOCFG_BM_BASE, 0x0050, 8, 1),
> +       PIN_FIELD_BASE(29, IOCFG_BM_BASE, 0x0050, 9, 1),
> +       PIN_FIELD_BASE(30, IOCFG_BM_BASE, 0x0050, 10, 1),
> +       PIN_FIELD_BASE(31, IOCFG_BM_BASE, 0x0050, 11, 1),
> +       PIN_FIELD_BASE(32, IOCFG_BM_BASE, 0x0050, 13, 1),
> +       PIN_FIELD_BASE(33, IOCFG_BM_BASE, 0x0050, 14, 1),
> +       PIN_FIELD_BASE(34, IOCFG_BM_BASE, 0x0050, 15, 1),
> +       PIN_FIELD_BASE(35, IOCFG_BM_BASE, 0x0050, 16, 1),
> +       PIN_FIELD_BASE(36, IOCFG_BM_BASE, 0x0050, 31, 1),
> +       PIN_FIELD_BASE(37, IOCFG_BM_BASE, 0x0060, 0, 1),
> +       PIN_FIELD_BASE(38, IOCFG_BM_BASE, 0x0060, 1, 1),
> +       PIN_FIELD_BASE(39, IOCFG_BM_BASE, 0x0050, 24, 1),
> +       PIN_FIELD_BASE(40, IOCFG_BM_BASE, 0x0050, 25, 1),
> +       PIN_FIELD_BASE(41, IOCFG_BM_BASE, 0x0050, 26, 1),
> +       PIN_FIELD_BASE(42, IOCFG_BM_BASE, 0x0060, 5, 1),
> +       PIN_FIELD_BASE(43, IOCFG_BM_BASE, 0x0060, 13, 1),
> +       PIN_FIELD_BASE(44, IOCFG_BM_BASE, 0x0060, 6, 1),
> +       PIN_FIELD_BASE(45, IOCFG_BM_BASE, 0x0050, 27, 1),
> +       PIN_FIELD_BASE(46, IOCFG_BM_BASE, 0x0050, 28, 1),
> +       PIN_FIELD_BASE(47, IOCFG_BM_BASE, 0x0050, 29, 1),
> +       PIN_FIELD_BASE(48, IOCFG_BM_BASE, 0x0050, 30, 1),
> +       PIN_FIELD_BASE(49, IOCFG_BM_BASE, 0x0060, 3, 1),
> +       PIN_FIELD_BASE(50, IOCFG_BM_BASE, 0x0060, 4, 1),
> +       PIN_FIELD_BASE(51, IOCFG_BM_BASE, 0x0060, 2, 1),
> +       PIN_FIELD_BASE(52, IOCFG_RM_BASE, 0x0060, 12, 1),
> +       PIN_FIELD_BASE(53, IOCFG_RM_BASE, 0x0070, 1, 1),
> +       PIN_FIELD_BASE(54, IOCFG_RM_BASE, 0x0070, 3, 1),
> +       PIN_FIELD_BASE(55, IOCFG_RM_BASE, 0x0070, 2, 1),
> +       PIN_FIELD_BASE(56, IOCFG_LT_BASE, 0x0040, 13, 1),
> +       PIN_FIELD_BASE(57, IOCFG_RM_BASE, 0x0060, 2, 1),
> +       PIN_FIELD_BASE(58, IOCFG_RM_BASE, 0x0060, 4, 1),
> +       PIN_FIELD_BASE(59, IOCFG_RM_BASE, 0x0060, 0, 1),
> +       PIN_FIELD_BASE(60, IOCFG_RM_BASE, 0x0060, 3, 1),
> +       PIN_FIELD_BASE(61, IOCFG_RM_BASE, 0x0060, 5, 1),
> +       PIN_FIELD_BASE(62, IOCFG_RM_BASE, 0x0060, 1, 1),
> +       PIN_FIELD_BASE(63, IOCFG_LB_BASE, 0x0070, 10, 1),
> +       PIN_FIELD_BASE(64, IOCFG_LB_BASE, 0x0070, 9, 1),
> +       PIN_FIELD_BASE(65, IOCFG_LB_BASE, 0x0080, 1, 1),
> +       PIN_FIELD_BASE(66, IOCFG_LB_BASE, 0x0080, 16, 1),
> +       PIN_FIELD_BASE(67, IOCFG_LB_BASE, 0x0080, 20, 1),
> +       PIN_FIELD_BASE(68, IOCFG_LB_BASE, 0x0080, 17, 1),
> +       PIN_FIELD_BASE(69, IOCFG_LB_BASE, 0x0080, 21, 1),
> +       PIN_FIELD_BASE(70, IOCFG_LB_BASE, 0x0080, 18, 1),
> +       PIN_FIELD_BASE(71, IOCFG_LB_BASE, 0x0080, 22, 1),
> +       PIN_FIELD_BASE(72, IOCFG_LB_BASE, 0x0080, 19, 1),
> +       PIN_FIELD_BASE(73, IOCFG_LB_BASE, 0x0080, 23, 1),
> +       PIN_FIELD_BASE(74, IOCFG_LB_BASE, 0x0070, 31, 1),
> +       PIN_FIELD_BASE(75, IOCFG_LB_BASE, 0x0070, 28, 1),
> +       PIN_FIELD_BASE(76, IOCFG_LB_BASE, 0x0070, 29, 1),
> +       PIN_FIELD_BASE(77, IOCFG_LB_BASE, 0x0070, 30, 1),
> +       PIN_FIELD_BASE(78, IOCFG_LB_BASE, 0x0080, 0, 1),
> +       PIN_FIELD_BASE(79, IOCFG_RM_BASE, 0x0060, 13, 1),
> +       PIN_FIELD_BASE(80, IOCFG_RM_BASE, 0x0060, 14, 1),
> +       PIN_FIELD_BASE(81, IOCFG_RM_BASE, 0x0060, 15, 1),
> +       PIN_FIELD_BASE(82, IOCFG_RM_BASE, 0x0060, 16, 1),
> +       PIN_FIELD_BASE(83, IOCFG_RM_BASE, 0x0060, 6, 1),
> +       PIN_FIELD_BASE(84, IOCFG_RM_BASE, 0x0060, 7, 1),
> +       PIN_FIELD_BASE(85, IOCFG_RM_BASE, 0x0060, 8, 1),
> +       PIN_FIELD_BASE(86, IOCFG_RM_BASE, 0x0060, 23, 1),
> +       PIN_FIELD_BASE(87, IOCFG_RM_BASE, 0x0060, 26, 1),
> +       PIN_FIELD_BASE(88, IOCFG_RM_BASE, 0x0060, 24, 1),
> +       PIN_FIELD_BASE(89, IOCFG_RM_BASE, 0x0060, 25, 1),
> +       PIN_FIELD_BASE(90, IOCFG_LB_BASE, 0x0070, 22, 1),
> +       PIN_FIELD_BASE(91, IOCFG_LB_BASE, 0x0070, 20, 1),
> +       PIN_FIELD_BASE(92, IOCFG_LB_BASE, 0x0070, 23, 1),
> +       PIN_FIELD_BASE(93, IOCFG_LB_BASE, 0x0070, 21, 1),
> +       PIN_FIELD_BASE(94, IOCFG_LB_BASE, 0x0070, 26, 1),
> +       PIN_FIELD_BASE(95, IOCFG_LB_BASE, 0x0070, 24, 1),
> +       PIN_FIELD_BASE(96, IOCFG_LB_BASE, 0x0070, 27, 1),
> +       PIN_FIELD_BASE(97, IOCFG_LB_BASE, 0x0070, 25, 1),
> +       PIN_FIELD_BASE(98, IOCFG_LT_BASE, 0x0040, 9, 1),
> +       PIN_FIELD_BASE(99, IOCFG_LT_BASE, 0x0040, 11, 1),
> +       PIN_FIELD_BASE(100, IOCFG_RM_BASE, 0x0060, 27, 1),
> +       PIN_FIELD_BASE(101, IOCFG_RM_BASE, 0x0060, 30, 1),
> +       PIN_FIELD_BASE(102, IOCFG_RM_BASE, 0x0060, 28, 1),
> +       PIN_FIELD_BASE(103, IOCFG_RM_BASE, 0x0060, 31, 1),
> +       PIN_FIELD_BASE(104, IOCFG_RM_BASE, 0x0060, 29, 1),
> +       PIN_FIELD_BASE(105, IOCFG_RM_BASE, 0x0070, 0, 1),
> +       PIN_FIELD_BASE(106, IOCFG_LT_BASE, 0x0040, 10, 1),
> +       PIN_FIELD_BASE(107, IOCFG_LT_BASE, 0x0040, 12, 1),
> +       PIN_FIELD_BASE(108, IOCFG_LB_BASE, 0x0080, 2, 1),
> +       PIN_FIELD_BASE(109, IOCFG_LB_BASE, 0x0080, 7, 1),
> +       PIN_FIELD_BASE(110, IOCFG_LB_BASE, 0x0080, 3, 1),
> +       PIN_FIELD_BASE(111, IOCFG_LB_BASE, 0x0080, 8, 1),
> +       PIN_FIELD_BASE(112, IOCFG_LB_BASE, 0x0080, 4, 1),
> +       PIN_FIELD_BASE(113, IOCFG_LB_BASE, 0x0080, 9, 1),
> +       PIN_FIELD_BASE(114, IOCFG_LB_BASE, 0x0080, 5, 1),
> +       PIN_FIELD_BASE(115, IOCFG_LB_BASE, 0x0080, 10, 1),
> +       PIN_FIELD_BASE(116, IOCFG_LB_BASE, 0x0080, 11, 1),
> +       PIN_FIELD_BASE(117, IOCFG_LB_BASE, 0x0080, 6, 1),
> +       PIN_FIELD_BASE(118, IOCFG_LB_BASE, 0x0080, 12, 1),
> +       PIN_FIELD_BASE(119, IOCFG_LB_BASE, 0x0080, 13, 1),
> +       PIN_FIELD_BASE(120, IOCFG_LB_BASE, 0x0080, 15, 1),
> +       PIN_FIELD_BASE(121, IOCFG_LB_BASE, 0x0080, 14, 1),
> +       PIN_FIELD_BASE(122, IOCFG_TR_BASE, 0x0020, 10, 1),
> +       PIN_FIELD_BASE(123, IOCFG_TR_BASE, 0x0020, 0, 1),
> +       PIN_FIELD_BASE(124, IOCFG_TR_BASE, 0x0020, 1, 1),
> +       PIN_FIELD_BASE(125, IOCFG_TR_BASE, 0x0020, 11, 1),
> +       PIN_FIELD_BASE(126, IOCFG_TR_BASE, 0x0020, 2, 1),
> +       PIN_FIELD_BASE(127, IOCFG_TR_BASE, 0x0020, 3, 1),
> +       PIN_FIELD_BASE(128, IOCFG_TR_BASE, 0x0020, 4, 1),
> +       PIN_FIELD_BASE(129, IOCFG_TR_BASE, 0x0020, 5, 1),
> +       PIN_FIELD_BASE(130, IOCFG_TR_BASE, 0x0020, 6, 1),
> +       PIN_FIELD_BASE(131, IOCFG_TR_BASE, 0x0020, 7, 1),
> +       PIN_FIELD_BASE(132, IOCFG_TR_BASE, 0x0020, 8, 1),
> +       PIN_FIELD_BASE(133, IOCFG_TR_BASE, 0x0020, 9, 1),
> +       PIN_FIELD_BASE(134, IOCFG_BM_BASE, 0x0060, 7, 1),
> +       PIN_FIELD_BASE(135, IOCFG_BM_BASE, 0x0060, 8, 1),
> +       PIN_FIELD_BASE(136, IOCFG_BM_BASE, 0x0060, 9, 1),
> +       PIN_FIELD_BASE(137, IOCFG_BM_BASE, 0x0060, 10, 1),
> +       PIN_FIELD_BASE(138, IOCFG_BM_BASE, 0x0060, 11, 1),
> +       PIN_FIELD_BASE(139, IOCFG_BM_BASE, 0x0060, 12, 1),
> +       PIN_FIELD_BASE(140, IOCFG_RM_BASE, 0x0060, 17, 1),
> +       PIN_FIELD_BASE(141, IOCFG_RM_BASE, 0x0060, 18, 1),
> +       PIN_FIELD_BASE(142, IOCFG_RM_BASE, 0x0060, 19, 1),
> +       PIN_FIELD_BASE(143, IOCFG_RM_BASE, 0x0060, 20, 1),
> +       PIN_FIELD_BASE(144, IOCFG_RM_BASE, 0x0060, 21, 1),
> +       PIN_FIELD_BASE(145, IOCFG_RM_BASE, 0x0060, 22, 1),
> +       PIN_FIELD_BASE(146, IOCFG_LB_BASE, 0x0070, 3, 1),
> +       PIN_FIELD_BASE(147, IOCFG_LB_BASE, 0x0070, 4, 1),
> +       PIN_FIELD_BASE(148, IOCFG_LB_BASE, 0x0070, 0, 1),
> +       PIN_FIELD_BASE(149, IOCFG_LB_BASE, 0x0070, 1, 1),
> +       PIN_FIELD_BASE(150, IOCFG_LB_BASE, 0x0070, 2, 1),
> +       PIN_FIELD_BASE(151, IOCFG_LB_BASE, 0x0070, 5, 1),
> +       PIN_FIELD_BASE(152, IOCFG_LB_BASE, 0x0070, 6, 1),
> +       PIN_FIELD_BASE(153, IOCFG_LB_BASE, 0x0070, 7, 1),
> +       PIN_FIELD_BASE(154, IOCFG_LB_BASE, 0x0070, 8, 1),
> +       PIN_FIELD_BASE(155, IOCFG_LT_BASE, 0x0040, 1, 1),
> +       PIN_FIELD_BASE(156, IOCFG_LT_BASE, 0x0040, 7, 1),
> +       PIN_FIELD_BASE(157, IOCFG_LT_BASE, 0x0040, 4, 1),
> +       PIN_FIELD_BASE(158, IOCFG_LT_BASE, 0x0040, 5, 1),
> +       PIN_FIELD_BASE(159, IOCFG_LT_BASE, 0x0040, 0, 1),
> +       PIN_FIELD_BASE(160, IOCFG_LT_BASE, 0x0040, 6, 1),
> +       PIN_FIELD_BASE(161, IOCFG_LT_BASE, 0x0040, 2, 1),
> +       PIN_FIELD_BASE(162, IOCFG_LT_BASE, 0x0040, 3, 1),
> +       PIN_FIELD_BASE(163, IOCFG_TL_BASE, 0x0010, 2, 1),
> +       PIN_FIELD_BASE(164, IOCFG_TL_BASE, 0x0010, 1, 1),
> +       PIN_FIELD_BASE(165, IOCFG_TL_BASE, 0x0010, 4, 1),
> +       PIN_FIELD_BASE(166, IOCFG_TL_BASE, 0x0010, 3, 1),
> +       PIN_FIELD_BASE(167, IOCFG_TL_BASE, 0x0010, 5, 1),
> +       PIN_FIELD_BASE(168, IOCFG_TL_BASE, 0x0010, 6, 1),
> +       PIN_FIELD_BASE(169, IOCFG_LT_BASE, 0x0040, 14, 1),
> +       PIN_FIELD_BASE(170, IOCFG_LT_BASE, 0x0040, 8, 1),
> +       PIN_FIELD_BASE(171, IOCFG_TL_BASE, 0x0010, 0, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8366_pin_pu_range[] =3D {
> +       PIN_FIELD_BASE(0, IOCFG_RM_BASE, 0x00a0, 9, 1),
> +       PIN_FIELD_BASE(1, IOCFG_RM_BASE, 0x00a0, 10, 1),
> +       PIN_FIELD_BASE(2, IOCFG_RM_BASE, 0x00a0, 11, 1),
> +       PIN_FIELD_BASE(3, IOCFG_LB_BASE, 0x00b0, 13, 1),
> +       PIN_FIELD_BASE(4, IOCFG_LB_BASE, 0x00b0, 14, 1),
> +       PIN_FIELD_BASE(5, IOCFG_LB_BASE, 0x00b0, 15, 1),
> +       PIN_FIELD_BASE(6, IOCFG_LB_BASE, 0x00b0, 16, 1),
> +       PIN_FIELD_BASE(7, IOCFG_LB_BASE, 0x00b0, 17, 1),
> +       PIN_FIELD_BASE(8, IOCFG_LB_BASE, 0x00b0, 18, 1),
> +       PIN_FIELD_BASE(9, IOCFG_LB_BASE, 0x00b0, 19, 1),
> +       PIN_FIELD_BASE(10, IOCFG_LB_BASE, 0x00b0, 11, 1),
> +       PIN_FIELD_BASE(11, IOCFG_LB_BASE, 0x00b0, 12, 1),
> +       PIN_FIELD_BASE(12, IOCFG_BM_BASE, 0x00a0, 0, 1),
> +       PIN_FIELD_BASE(13, IOCFG_BM_BASE, 0x00a0, 1, 1),
> +       PIN_FIELD_BASE(14, IOCFG_BM_BASE, 0x00a0, 12, 1),
> +       PIN_FIELD_BASE(15, IOCFG_BM_BASE, 0x00a0, 17, 1),
> +       PIN_FIELD_BASE(16, IOCFG_BM_BASE, 0x00a0, 18, 1),
> +       PIN_FIELD_BASE(17, IOCFG_BM_BASE, 0x00a0, 19, 1),
> +       PIN_FIELD_BASE(18, IOCFG_BM_BASE, 0x00a0, 20, 1),
> +       PIN_FIELD_BASE(19, IOCFG_BM_BASE, 0x00a0, 21, 1),
> +       PIN_FIELD_BASE(20, IOCFG_BM_BASE, 0x00a0, 22, 1),
> +       PIN_FIELD_BASE(21, IOCFG_BM_BASE, 0x00a0, 23, 1),
> +       PIN_FIELD_BASE(22, IOCFG_BM_BASE, 0x00a0, 2, 1),
> +       PIN_FIELD_BASE(23, IOCFG_BM_BASE, 0x00a0, 3, 1),
> +       PIN_FIELD_BASE(24, IOCFG_BM_BASE, 0x00a0, 4, 1),
> +       PIN_FIELD_BASE(25, IOCFG_BM_BASE, 0x00a0, 5, 1),
> +       PIN_FIELD_BASE(26, IOCFG_BM_BASE, 0x00a0, 6, 1),
> +       PIN_FIELD_BASE(27, IOCFG_BM_BASE, 0x00a0, 7, 1),
> +       PIN_FIELD_BASE(28, IOCFG_BM_BASE, 0x00a0, 8, 1),
> +       PIN_FIELD_BASE(29, IOCFG_BM_BASE, 0x00a0, 9, 1),
> +       PIN_FIELD_BASE(30, IOCFG_BM_BASE, 0x00a0, 10, 1),
> +       PIN_FIELD_BASE(31, IOCFG_BM_BASE, 0x00a0, 11, 1),
> +       PIN_FIELD_BASE(32, IOCFG_BM_BASE, 0x00a0, 13, 1),
> +       PIN_FIELD_BASE(33, IOCFG_BM_BASE, 0x00a0, 14, 1),
> +       PIN_FIELD_BASE(34, IOCFG_BM_BASE, 0x00a0, 15, 1),
> +       PIN_FIELD_BASE(35, IOCFG_BM_BASE, 0x00a0, 16, 1),
> +       PIN_FIELD_BASE(36, IOCFG_BM_BASE, 0x00a0, 31, 1),
> +       PIN_FIELD_BASE(37, IOCFG_BM_BASE, 0x00b0, 0, 1),
> +       PIN_FIELD_BASE(38, IOCFG_BM_BASE, 0x00b0, 1, 1),
> +       PIN_FIELD_BASE(39, IOCFG_BM_BASE, 0x00a0, 24, 1),
> +       PIN_FIELD_BASE(40, IOCFG_BM_BASE, 0x00a0, 25, 1),
> +       PIN_FIELD_BASE(41, IOCFG_BM_BASE, 0x00a0, 26, 1),
> +       PIN_FIELD_BASE(42, IOCFG_BM_BASE, 0x00b0, 5, 1),
> +       PIN_FIELD_BASE(43, IOCFG_BM_BASE, 0x00b0, 7, 1),
> +       PIN_FIELD_BASE(44, IOCFG_BM_BASE, 0x00b0, 6, 1),
> +       PIN_FIELD_BASE(45, IOCFG_BM_BASE, 0x00a0, 27, 1),
> +       PIN_FIELD_BASE(46, IOCFG_BM_BASE, 0x00a0, 28, 1),
> +       PIN_FIELD_BASE(47, IOCFG_BM_BASE, 0x00a0, 29, 1),
> +       PIN_FIELD_BASE(48, IOCFG_BM_BASE, 0x00a0, 30, 1),
> +       PIN_FIELD_BASE(49, IOCFG_BM_BASE, 0x00b0, 3, 1),
> +       PIN_FIELD_BASE(50, IOCFG_BM_BASE, 0x00b0, 4, 1),
> +       PIN_FIELD_BASE(51, IOCFG_BM_BASE, 0x00b0, 2, 1),
> +       PIN_FIELD_BASE(52, IOCFG_RM_BASE, 0x00a0, 12, 1),
> +       PIN_FIELD_BASE(53, IOCFG_RM_BASE, 0x00a0, 23, 1),
> +       PIN_FIELD_BASE(54, IOCFG_RM_BASE, 0x00a0, 25, 1),
> +       PIN_FIELD_BASE(55, IOCFG_RM_BASE, 0x00a0, 24, 1),
> +       PIN_FIELD_BASE(56, IOCFG_LT_BASE, 0x0060, 15, 1),
> +       PIN_FIELD_BASE(57, IOCFG_RM_BASE, 0x00a0, 2, 1),
> +       PIN_FIELD_BASE(58, IOCFG_RM_BASE, 0x00a0, 4, 1),
> +       PIN_FIELD_BASE(59, IOCFG_RM_BASE, 0x00a0, 0, 1),
> +       PIN_FIELD_BASE(60, IOCFG_RM_BASE, 0x00a0, 3, 1),
> +       PIN_FIELD_BASE(61, IOCFG_RM_BASE, 0x00a0, 5, 1),
> +       PIN_FIELD_BASE(62, IOCFG_RM_BASE, 0x00a0, 1, 1),
> +       PIN_FIELD_BASE(63, IOCFG_LB_BASE, 0x00b0, 10, 1),
> +       PIN_FIELD_BASE(64, IOCFG_LB_BASE, 0x00b0, 9, 1),
> +       PIN_FIELD_BASE(65, IOCFG_LB_BASE, 0x00c0, 1, 1),
> +       PIN_FIELD_BASE(66, IOCFG_LB_BASE, 0x00c0, 16, 1),
> +       PIN_FIELD_BASE(67, IOCFG_LB_BASE, 0x00c0, 20, 1),
> +       PIN_FIELD_BASE(68, IOCFG_LB_BASE, 0x00c0, 17, 1),
> +       PIN_FIELD_BASE(69, IOCFG_LB_BASE, 0x00c0, 21, 1),
> +       PIN_FIELD_BASE(70, IOCFG_LB_BASE, 0x00c0, 18, 1),
> +       PIN_FIELD_BASE(71, IOCFG_LB_BASE, 0x00c0, 22, 1),
> +       PIN_FIELD_BASE(72, IOCFG_LB_BASE, 0x00c0, 19, 1),
> +       PIN_FIELD_BASE(73, IOCFG_LB_BASE, 0x00c0, 23, 1),
> +       PIN_FIELD_BASE(74, IOCFG_LB_BASE, 0x00b0, 31, 1),
> +       PIN_FIELD_BASE(75, IOCFG_LB_BASE, 0x00b0, 28, 1),
> +       PIN_FIELD_BASE(76, IOCFG_LB_BASE, 0x00b0, 29, 1),
> +       PIN_FIELD_BASE(77, IOCFG_LB_BASE, 0x00b0, 30, 1),
> +       PIN_FIELD_BASE(78, IOCFG_LB_BASE, 0x00c0, 0, 1),
> +       PIN_FIELD_BASE(83, IOCFG_RM_BASE, 0x00a0, 6, 1),
> +       PIN_FIELD_BASE(84, IOCFG_RM_BASE, 0x00a0, 7, 1),
> +       PIN_FIELD_BASE(85, IOCFG_RM_BASE, 0x00a0, 8, 1),
> +       PIN_FIELD_BASE(86, IOCFG_RM_BASE, 0x00a0, 13, 1),
> +       PIN_FIELD_BASE(87, IOCFG_RM_BASE, 0x00a0, 16, 1),
> +       PIN_FIELD_BASE(88, IOCFG_RM_BASE, 0x00a0, 14, 1),
> +       PIN_FIELD_BASE(89, IOCFG_RM_BASE, 0x00a0, 15, 1),
> +       PIN_FIELD_BASE(90, IOCFG_LB_BASE, 0x00b0, 22, 1),
> +       PIN_FIELD_BASE(91, IOCFG_LB_BASE, 0x00b0, 20, 1),
> +       PIN_FIELD_BASE(92, IOCFG_LB_BASE, 0x00b0, 23, 1),
> +       PIN_FIELD_BASE(93, IOCFG_LB_BASE, 0x00b0, 21, 1),
> +       PIN_FIELD_BASE(94, IOCFG_LB_BASE, 0x00b0, 26, 1),
> +       PIN_FIELD_BASE(95, IOCFG_LB_BASE, 0x00b0, 24, 1),
> +       PIN_FIELD_BASE(96, IOCFG_LB_BASE, 0x00b0, 27, 1),
> +       PIN_FIELD_BASE(97, IOCFG_LB_BASE, 0x00b0, 25, 1),
> +       PIN_FIELD_BASE(98, IOCFG_LT_BASE, 0x0060, 9, 1),
> +       PIN_FIELD_BASE(99, IOCFG_LT_BASE, 0x0060, 11, 1),
> +       PIN_FIELD_BASE(100, IOCFG_RM_BASE, 0x00a0, 17, 1),
> +       PIN_FIELD_BASE(101, IOCFG_RM_BASE, 0x00a0, 20, 1),
> +       PIN_FIELD_BASE(102, IOCFG_RM_BASE, 0x00a0, 18, 1),
> +       PIN_FIELD_BASE(103, IOCFG_RM_BASE, 0x00a0, 21, 1),
> +       PIN_FIELD_BASE(104, IOCFG_RM_BASE, 0x00a0, 19, 1),
> +       PIN_FIELD_BASE(105, IOCFG_RM_BASE, 0x00a0, 22, 1),
> +       PIN_FIELD_BASE(106, IOCFG_LT_BASE, 0x0060, 10, 1),
> +       PIN_FIELD_BASE(107, IOCFG_LT_BASE, 0x0060, 12, 1),
> +       PIN_FIELD_BASE(108, IOCFG_LB_BASE, 0x00c0, 2, 1),
> +       PIN_FIELD_BASE(109, IOCFG_LB_BASE, 0x00c0, 7, 1),
> +       PIN_FIELD_BASE(110, IOCFG_LB_BASE, 0x00c0, 3, 1),
> +       PIN_FIELD_BASE(111, IOCFG_LB_BASE, 0x00c0, 8, 1),
> +       PIN_FIELD_BASE(112, IOCFG_LB_BASE, 0x00c0, 4, 1),
> +       PIN_FIELD_BASE(113, IOCFG_LB_BASE, 0x00c0, 9, 1),
> +       PIN_FIELD_BASE(114, IOCFG_LB_BASE, 0x00c0, 5, 1),
> +       PIN_FIELD_BASE(115, IOCFG_LB_BASE, 0x00c0, 10, 1),
> +       PIN_FIELD_BASE(116, IOCFG_LB_BASE, 0x00c0, 11, 1),
> +       PIN_FIELD_BASE(117, IOCFG_LB_BASE, 0x00c0, 6, 1),
> +       PIN_FIELD_BASE(118, IOCFG_LB_BASE, 0x00c0, 12, 1),
> +       PIN_FIELD_BASE(119, IOCFG_LB_BASE, 0x00c0, 13, 1),
> +       PIN_FIELD_BASE(120, IOCFG_LB_BASE, 0x00c0, 15, 1),
> +       PIN_FIELD_BASE(121, IOCFG_LB_BASE, 0x00c0, 14, 1),
> +       PIN_FIELD_BASE(146, IOCFG_LB_BASE, 0x00b0, 3, 1),
> +       PIN_FIELD_BASE(147, IOCFG_LB_BASE, 0x00b0, 4, 1),
> +       PIN_FIELD_BASE(148, IOCFG_LB_BASE, 0x00b0, 0, 1),
> +       PIN_FIELD_BASE(149, IOCFG_LB_BASE, 0x00b0, 1, 1),
> +       PIN_FIELD_BASE(150, IOCFG_LB_BASE, 0x00b0, 2, 1),
> +       PIN_FIELD_BASE(151, IOCFG_LB_BASE, 0x00b0, 5, 1),
> +       PIN_FIELD_BASE(152, IOCFG_LB_BASE, 0x00b0, 6, 1),
> +       PIN_FIELD_BASE(153, IOCFG_LB_BASE, 0x00b0, 7, 1),
> +       PIN_FIELD_BASE(154, IOCFG_LB_BASE, 0x00b0, 8, 1),
> +       PIN_FIELD_BASE(155, IOCFG_LT_BASE, 0x0060, 1, 1),
> +       PIN_FIELD_BASE(156, IOCFG_LT_BASE, 0x0060, 7, 1),
> +       PIN_FIELD_BASE(157, IOCFG_LT_BASE, 0x0060, 4, 1),
> +       PIN_FIELD_BASE(158, IOCFG_LT_BASE, 0x0060, 5, 1),
> +       PIN_FIELD_BASE(159, IOCFG_LT_BASE, 0x0060, 0, 1),
> +       PIN_FIELD_BASE(160, IOCFG_LT_BASE, 0x0060, 6, 1),
> +       PIN_FIELD_BASE(161, IOCFG_LT_BASE, 0x0060, 2, 1),
> +       PIN_FIELD_BASE(162, IOCFG_LT_BASE, 0x0060, 3, 1),
> +       PIN_FIELD_BASE(163, IOCFG_TL_BASE, 0x0030, 2, 1),
> +       PIN_FIELD_BASE(164, IOCFG_TL_BASE, 0x0030, 1, 1),
> +       PIN_FIELD_BASE(165, IOCFG_TL_BASE, 0x0030, 4, 1),
> +       PIN_FIELD_BASE(166, IOCFG_TL_BASE, 0x0030, 3, 1),
> +       PIN_FIELD_BASE(167, IOCFG_TL_BASE, 0x0030, 5, 1),
> +       PIN_FIELD_BASE(168, IOCFG_TL_BASE, 0x0030, 6, 1),
> +       PIN_FIELD_BASE(169, IOCFG_LT_BASE, 0x0060, 16, 1),
> +       PIN_FIELD_BASE(170, IOCFG_LT_BASE, 0x0060, 8, 1),
> +       PIN_FIELD_BASE(171, IOCFG_TL_BASE, 0x0030, 0, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8366_pin_pd_range[] =3D {
> +       PIN_FIELD_BASE(0, IOCFG_RM_BASE, 0x0080, 9, 1),
> +       PIN_FIELD_BASE(1, IOCFG_RM_BASE, 0x0080, 10, 1),
> +       PIN_FIELD_BASE(2, IOCFG_RM_BASE, 0x0080, 11, 1),
> +       PIN_FIELD_BASE(3, IOCFG_LB_BASE, 0x0090, 13, 1),
> +       PIN_FIELD_BASE(4, IOCFG_LB_BASE, 0x0090, 14, 1),
> +       PIN_FIELD_BASE(5, IOCFG_LB_BASE, 0x0090, 15, 1),
> +       PIN_FIELD_BASE(6, IOCFG_LB_BASE, 0x0090, 16, 1),
> +       PIN_FIELD_BASE(7, IOCFG_LB_BASE, 0x0090, 17, 1),
> +       PIN_FIELD_BASE(8, IOCFG_LB_BASE, 0x0090, 18, 1),
> +       PIN_FIELD_BASE(9, IOCFG_LB_BASE, 0x0090, 19, 1),
> +       PIN_FIELD_BASE(10, IOCFG_LB_BASE, 0x0090, 11, 1),
> +       PIN_FIELD_BASE(11, IOCFG_LB_BASE, 0x0090, 12, 1),
> +       PIN_FIELD_BASE(12, IOCFG_BM_BASE, 0x0070, 0, 1),
> +       PIN_FIELD_BASE(13, IOCFG_BM_BASE, 0x0070, 1, 1),
> +       PIN_FIELD_BASE(14, IOCFG_BM_BASE, 0x0070, 12, 1),
> +       PIN_FIELD_BASE(15, IOCFG_BM_BASE, 0x0070, 17, 1),
> +       PIN_FIELD_BASE(16, IOCFG_BM_BASE, 0x0070, 18, 1),
> +       PIN_FIELD_BASE(17, IOCFG_BM_BASE, 0x0070, 19, 1),
> +       PIN_FIELD_BASE(18, IOCFG_BM_BASE, 0x0070, 20, 1),
> +       PIN_FIELD_BASE(19, IOCFG_BM_BASE, 0x0070, 21, 1),
> +       PIN_FIELD_BASE(20, IOCFG_BM_BASE, 0x0070, 22, 1),
> +       PIN_FIELD_BASE(21, IOCFG_BM_BASE, 0x0070, 23, 1),
> +       PIN_FIELD_BASE(22, IOCFG_BM_BASE, 0x0070, 2, 1),
> +       PIN_FIELD_BASE(23, IOCFG_BM_BASE, 0x0070, 3, 1),
> +       PIN_FIELD_BASE(24, IOCFG_BM_BASE, 0x0070, 4, 1),
> +       PIN_FIELD_BASE(25, IOCFG_BM_BASE, 0x0070, 5, 1),
> +       PIN_FIELD_BASE(26, IOCFG_BM_BASE, 0x0070, 6, 1),
> +       PIN_FIELD_BASE(27, IOCFG_BM_BASE, 0x0070, 7, 1),
> +       PIN_FIELD_BASE(28, IOCFG_BM_BASE, 0x0070, 8, 1),
> +       PIN_FIELD_BASE(29, IOCFG_BM_BASE, 0x0070, 9, 1),
> +       PIN_FIELD_BASE(30, IOCFG_BM_BASE, 0x0070, 10, 1),
> +       PIN_FIELD_BASE(31, IOCFG_BM_BASE, 0x0070, 11, 1),
> +       PIN_FIELD_BASE(32, IOCFG_BM_BASE, 0x0070, 13, 1),
> +       PIN_FIELD_BASE(33, IOCFG_BM_BASE, 0x0070, 14, 1),
> +       PIN_FIELD_BASE(34, IOCFG_BM_BASE, 0x0070, 15, 1),
> +       PIN_FIELD_BASE(35, IOCFG_BM_BASE, 0x0070, 16, 1),
> +       PIN_FIELD_BASE(36, IOCFG_BM_BASE, 0x0070, 31, 1),
> +       PIN_FIELD_BASE(37, IOCFG_BM_BASE, 0x0080, 0, 1),
> +       PIN_FIELD_BASE(38, IOCFG_BM_BASE, 0x0080, 1, 1),
> +       PIN_FIELD_BASE(39, IOCFG_BM_BASE, 0x0070, 24, 1),
> +       PIN_FIELD_BASE(40, IOCFG_BM_BASE, 0x0070, 25, 1),
> +       PIN_FIELD_BASE(41, IOCFG_BM_BASE, 0x0070, 26, 1),
> +       PIN_FIELD_BASE(42, IOCFG_BM_BASE, 0x0080, 5, 1),
> +       PIN_FIELD_BASE(43, IOCFG_BM_BASE, 0x0080, 7, 1),
> +       PIN_FIELD_BASE(44, IOCFG_BM_BASE, 0x0080, 6, 1),
> +       PIN_FIELD_BASE(45, IOCFG_BM_BASE, 0x0070, 27, 1),
> +       PIN_FIELD_BASE(46, IOCFG_BM_BASE, 0x0070, 28, 1),
> +       PIN_FIELD_BASE(47, IOCFG_BM_BASE, 0x0070, 29, 1),
> +       PIN_FIELD_BASE(48, IOCFG_BM_BASE, 0x0070, 30, 1),
> +       PIN_FIELD_BASE(49, IOCFG_BM_BASE, 0x0080, 3, 1),
> +       PIN_FIELD_BASE(50, IOCFG_BM_BASE, 0x0080, 4, 1),
> +       PIN_FIELD_BASE(51, IOCFG_BM_BASE, 0x0080, 2, 1),
> +       PIN_FIELD_BASE(52, IOCFG_RM_BASE, 0x0080, 12, 1),
> +       PIN_FIELD_BASE(53, IOCFG_RM_BASE, 0x0080, 23, 1),
> +       PIN_FIELD_BASE(54, IOCFG_RM_BASE, 0x0080, 25, 1),
> +       PIN_FIELD_BASE(55, IOCFG_RM_BASE, 0x0080, 24, 1),
> +       PIN_FIELD_BASE(56, IOCFG_LT_BASE, 0x0050, 15, 1),
> +       PIN_FIELD_BASE(57, IOCFG_RM_BASE, 0x0080, 2, 1),
> +       PIN_FIELD_BASE(58, IOCFG_RM_BASE, 0x0080, 4, 1),
> +       PIN_FIELD_BASE(59, IOCFG_RM_BASE, 0x0080, 0, 1),
> +       PIN_FIELD_BASE(60, IOCFG_RM_BASE, 0x0080, 3, 1),
> +       PIN_FIELD_BASE(61, IOCFG_RM_BASE, 0x0080, 5, 1),
> +       PIN_FIELD_BASE(62, IOCFG_RM_BASE, 0x0080, 1, 1),
> +       PIN_FIELD_BASE(63, IOCFG_LB_BASE, 0x0090, 10, 1),
> +       PIN_FIELD_BASE(64, IOCFG_LB_BASE, 0x0090, 9, 1),
> +       PIN_FIELD_BASE(65, IOCFG_LB_BASE, 0x00a0, 1, 1),
> +       PIN_FIELD_BASE(66, IOCFG_LB_BASE, 0x00a0, 16, 1),
> +       PIN_FIELD_BASE(67, IOCFG_LB_BASE, 0x00a0, 20, 1),
> +       PIN_FIELD_BASE(68, IOCFG_LB_BASE, 0x00a0, 17, 1),
> +       PIN_FIELD_BASE(69, IOCFG_LB_BASE, 0x00a0, 21, 1),
> +       PIN_FIELD_BASE(70, IOCFG_LB_BASE, 0x00a0, 18, 1),
> +       PIN_FIELD_BASE(71, IOCFG_LB_BASE, 0x00a0, 22, 1),
> +       PIN_FIELD_BASE(72, IOCFG_LB_BASE, 0x00a0, 19, 1),
> +       PIN_FIELD_BASE(73, IOCFG_LB_BASE, 0x00a0, 23, 1),
> +       PIN_FIELD_BASE(74, IOCFG_LB_BASE, 0x0090, 31, 1),
> +       PIN_FIELD_BASE(75, IOCFG_LB_BASE, 0x0090, 28, 1),
> +       PIN_FIELD_BASE(76, IOCFG_LB_BASE, 0x0090, 29, 1),
> +       PIN_FIELD_BASE(77, IOCFG_LB_BASE, 0x0090, 30, 1),
> +       PIN_FIELD_BASE(78, IOCFG_LB_BASE, 0x00a0, 0, 1),
> +       PIN_FIELD_BASE(83, IOCFG_RM_BASE, 0x0080, 6, 1),
> +       PIN_FIELD_BASE(84, IOCFG_RM_BASE, 0x0080, 7, 1),
> +       PIN_FIELD_BASE(85, IOCFG_RM_BASE, 0x0080, 8, 1),
> +       PIN_FIELD_BASE(86, IOCFG_RM_BASE, 0x0080, 13, 1),
> +       PIN_FIELD_BASE(87, IOCFG_RM_BASE, 0x0080, 16, 1),
> +       PIN_FIELD_BASE(88, IOCFG_RM_BASE, 0x0080, 14, 1),
> +       PIN_FIELD_BASE(89, IOCFG_RM_BASE, 0x0080, 15, 1),
> +       PIN_FIELD_BASE(90, IOCFG_LB_BASE, 0x0090, 22, 1),
> +       PIN_FIELD_BASE(91, IOCFG_LB_BASE, 0x0090, 20, 1),
> +       PIN_FIELD_BASE(92, IOCFG_LB_BASE, 0x0090, 23, 1),
> +       PIN_FIELD_BASE(93, IOCFG_LB_BASE, 0x0090, 21, 1),
> +       PIN_FIELD_BASE(94, IOCFG_LB_BASE, 0x0090, 26, 1),
> +       PIN_FIELD_BASE(95, IOCFG_LB_BASE, 0x0090, 24, 1),
> +       PIN_FIELD_BASE(96, IOCFG_LB_BASE, 0x0090, 27, 1),
> +       PIN_FIELD_BASE(97, IOCFG_LB_BASE, 0x0090, 25, 1),
> +       PIN_FIELD_BASE(98, IOCFG_LT_BASE, 0x0050, 9, 1),
> +       PIN_FIELD_BASE(99, IOCFG_LT_BASE, 0x0050, 11, 1),
> +       PIN_FIELD_BASE(100, IOCFG_RM_BASE, 0x0080, 17, 1),
> +       PIN_FIELD_BASE(101, IOCFG_RM_BASE, 0x0080, 20, 1),
> +       PIN_FIELD_BASE(102, IOCFG_RM_BASE, 0x0080, 18, 1),
> +       PIN_FIELD_BASE(103, IOCFG_RM_BASE, 0x0080, 21, 1),
> +       PIN_FIELD_BASE(104, IOCFG_RM_BASE, 0x0080, 19, 1),
> +       PIN_FIELD_BASE(105, IOCFG_RM_BASE, 0x0080, 22, 1),
> +       PIN_FIELD_BASE(106, IOCFG_LT_BASE, 0x0050, 10, 1),
> +       PIN_FIELD_BASE(107, IOCFG_LT_BASE, 0x0050, 12, 1),
> +       PIN_FIELD_BASE(108, IOCFG_LB_BASE, 0x00a0, 2, 1),
> +       PIN_FIELD_BASE(109, IOCFG_LB_BASE, 0x00a0, 7, 1),
> +       PIN_FIELD_BASE(110, IOCFG_LB_BASE, 0x00a0, 3, 1),
> +       PIN_FIELD_BASE(111, IOCFG_LB_BASE, 0x00a0, 8, 1),
> +       PIN_FIELD_BASE(112, IOCFG_LB_BASE, 0x00a0, 4, 1),
> +       PIN_FIELD_BASE(113, IOCFG_LB_BASE, 0x00a0, 9, 1),
> +       PIN_FIELD_BASE(114, IOCFG_LB_BASE, 0x00a0, 5, 1),
> +       PIN_FIELD_BASE(115, IOCFG_LB_BASE, 0x00a0, 10, 1),
> +       PIN_FIELD_BASE(116, IOCFG_LB_BASE, 0x00a0, 11, 1),
> +       PIN_FIELD_BASE(117, IOCFG_LB_BASE, 0x00a0, 6, 1),
> +       PIN_FIELD_BASE(118, IOCFG_LB_BASE, 0x00a0, 12, 1),
> +       PIN_FIELD_BASE(119, IOCFG_LB_BASE, 0x00a0, 13, 1),
> +       PIN_FIELD_BASE(120, IOCFG_LB_BASE, 0x00a0, 15, 1),
> +       PIN_FIELD_BASE(121, IOCFG_LB_BASE, 0x00a0, 14, 1),
> +       PIN_FIELD_BASE(146, IOCFG_LB_BASE, 0x0090, 3, 1),
> +       PIN_FIELD_BASE(147, IOCFG_LB_BASE, 0x0090, 4, 1),
> +       PIN_FIELD_BASE(148, IOCFG_LB_BASE, 0x0090, 0, 1),
> +       PIN_FIELD_BASE(149, IOCFG_LB_BASE, 0x0090, 1, 1),
> +       PIN_FIELD_BASE(150, IOCFG_LB_BASE, 0x0090, 2, 1),
> +       PIN_FIELD_BASE(151, IOCFG_LB_BASE, 0x0090, 5, 1),
> +       PIN_FIELD_BASE(152, IOCFG_LB_BASE, 0x0090, 6, 1),
> +       PIN_FIELD_BASE(153, IOCFG_LB_BASE, 0x0090, 7, 1),
> +       PIN_FIELD_BASE(154, IOCFG_LB_BASE, 0x0090, 8, 1),
> +       PIN_FIELD_BASE(155, IOCFG_LT_BASE, 0x0050, 1, 1),
> +       PIN_FIELD_BASE(156, IOCFG_LT_BASE, 0x0050, 7, 1),
> +       PIN_FIELD_BASE(157, IOCFG_LT_BASE, 0x0050, 4, 1),
> +       PIN_FIELD_BASE(158, IOCFG_LT_BASE, 0x0050, 5, 1),
> +       PIN_FIELD_BASE(159, IOCFG_LT_BASE, 0x0050, 0, 1),
> +       PIN_FIELD_BASE(160, IOCFG_LT_BASE, 0x0050, 6, 1),
> +       PIN_FIELD_BASE(161, IOCFG_LT_BASE, 0x0050, 2, 1),
> +       PIN_FIELD_BASE(162, IOCFG_LT_BASE, 0x0050, 3, 1),
> +       PIN_FIELD_BASE(163, IOCFG_TL_BASE, 0x0020, 2, 1),
> +       PIN_FIELD_BASE(164, IOCFG_TL_BASE, 0x0020, 1, 1),
> +       PIN_FIELD_BASE(165, IOCFG_TL_BASE, 0x0020, 4, 1),
> +       PIN_FIELD_BASE(166, IOCFG_TL_BASE, 0x0020, 3, 1),
> +       PIN_FIELD_BASE(167, IOCFG_TL_BASE, 0x0020, 5, 1),
> +       PIN_FIELD_BASE(168, IOCFG_TL_BASE, 0x0020, 6, 1),
> +       PIN_FIELD_BASE(169, IOCFG_LT_BASE, 0x0050, 16, 1),
> +       PIN_FIELD_BASE(170, IOCFG_LT_BASE, 0x0050, 8, 1),
> +       PIN_FIELD_BASE(171, IOCFG_TL_BASE, 0x0020, 0, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8366_pin_drv_range[] =3D {
> +       PIN_FIELD_BASE(0, IOCFG_RM_BASE, 0x0000, 27, 3),
> +       PIN_FIELD_BASE(1, IOCFG_RM_BASE, 0x0010, 0, 3),
> +       PIN_FIELD_BASE(2, IOCFG_RM_BASE, 0x0010, 3, 3),
> +       PIN_FIELD_BASE(3, IOCFG_LB_BASE, 0x0010, 3, 3),
> +       PIN_FIELD_BASE(4, IOCFG_LB_BASE, 0x0010, 6, 3),
> +       PIN_FIELD_BASE(5, IOCFG_LB_BASE, 0x0010, 9, 3),
> +       PIN_FIELD_BASE(6, IOCFG_LB_BASE, 0x0020, 15, 3),
> +       PIN_FIELD_BASE(7, IOCFG_LB_BASE, 0x0020, 15, 3),
> +       PIN_FIELD_BASE(8, IOCFG_LB_BASE, 0x0020, 15, 3),
> +       PIN_FIELD_BASE(9, IOCFG_LB_BASE, 0x0020, 9, 3),
> +       PIN_FIELD_BASE(10, IOCFG_LB_BASE, 0x0020, 9, 3),
> +       PIN_FIELD_BASE(11, IOCFG_LB_BASE, 0x0020, 15, 3),
> +       PIN_FIELD_BASE(12, IOCFG_BM_BASE, 0x0000, 0, 3),
> +       PIN_FIELD_BASE(13, IOCFG_BM_BASE, 0x0010, 3, 3),
> +       PIN_FIELD_BASE(14, IOCFG_BM_BASE, 0x0010, 18, 3),
> +       PIN_FIELD_BASE(15, IOCFG_BM_BASE, 0x0010, 21, 3),
> +       PIN_FIELD_BASE(16, IOCFG_BM_BASE, 0x0010, 24, 3),
> +       PIN_FIELD_BASE(17, IOCFG_BM_BASE, 0x0010, 27, 3),
> +       PIN_FIELD_BASE(18, IOCFG_BM_BASE, 0x0020, 0, 3),
> +       PIN_FIELD_BASE(19, IOCFG_BM_BASE, 0x0020, 3, 3),
> +       PIN_FIELD_BASE(20, IOCFG_BM_BASE, 0x0020, 6, 3),
> +       PIN_FIELD_BASE(21, IOCFG_BM_BASE, 0x0020, 9, 3),
> +       PIN_FIELD_BASE(22, IOCFG_BM_BASE, 0x0000, 3, 3),
> +       PIN_FIELD_BASE(23, IOCFG_BM_BASE, 0x0000, 6, 3),
> +       PIN_FIELD_BASE(24, IOCFG_BM_BASE, 0x0000, 9, 3),
> +       PIN_FIELD_BASE(25, IOCFG_BM_BASE, 0x0000, 12, 3),
> +       PIN_FIELD_BASE(26, IOCFG_BM_BASE, 0x0000, 15, 3),
> +       PIN_FIELD_BASE(27, IOCFG_BM_BASE, 0x0000, 18, 3),
> +       PIN_FIELD_BASE(28, IOCFG_BM_BASE, 0x0000, 21, 3),
> +       PIN_FIELD_BASE(29, IOCFG_BM_BASE, 0x0000, 24, 3),
> +       PIN_FIELD_BASE(30, IOCFG_BM_BASE, 0x0000, 27, 3),
> +       PIN_FIELD_BASE(31, IOCFG_BM_BASE, 0x0010, 0, 3),
> +       PIN_FIELD_BASE(32, IOCFG_BM_BASE, 0x0010, 6, 3),
> +       PIN_FIELD_BASE(33, IOCFG_BM_BASE, 0x0010, 9, 3),
> +       PIN_FIELD_BASE(34, IOCFG_BM_BASE, 0x0010, 12, 3),
> +       PIN_FIELD_BASE(35, IOCFG_BM_BASE, 0x0010, 15, 3),
> +       PIN_FIELD_BASE(36, IOCFG_BM_BASE, 0x0020, 27, 3),
> +       PIN_FIELD_BASE(37, IOCFG_BM_BASE, 0x0030, 0, 3),
> +       PIN_FIELD_BASE(38, IOCFG_BM_BASE, 0x0030, 3, 3),
> +       PIN_FIELD_BASE(39, IOCFG_BM_BASE, 0x0020, 12, 3),
> +       PIN_FIELD_BASE(40, IOCFG_BM_BASE, 0x0020, 15, 3),
> +       PIN_FIELD_BASE(41, IOCFG_BM_BASE, 0x0020, 18, 3),
> +       PIN_FIELD_BASE(42, IOCFG_BM_BASE, 0x0030, 12, 3),
> +       PIN_FIELD_BASE(43, IOCFG_BM_BASE, 0x0040, 6, 3),
> +       PIN_FIELD_BASE(44, IOCFG_BM_BASE, 0x0040, 3, 3),
> +       PIN_FIELD_BASE(45, IOCFG_BM_BASE, 0x0040, 3, 3),
> +       PIN_FIELD_BASE(46, IOCFG_BM_BASE, 0x0040, 3, 3),
> +       PIN_FIELD_BASE(47, IOCFG_BM_BASE, 0x0020, 21, 3),
> +       PIN_FIELD_BASE(48, IOCFG_BM_BASE, 0x0020, 24, 3),
> +       PIN_FIELD_BASE(49, IOCFG_BM_BASE, 0x0030, 6, 3),
> +       PIN_FIELD_BASE(50, IOCFG_BM_BASE, 0x0030, 9, 3),
> +       PIN_FIELD_BASE(51, IOCFG_BM_BASE, 0x0040, 3, 3),
> +       PIN_FIELD_BASE(52, IOCFG_RM_BASE, 0x0020, 6, 3),
> +       PIN_FIELD_BASE(53, IOCFG_RM_BASE, 0x0020, 6, 3),
> +       PIN_FIELD_BASE(54, IOCFG_RM_BASE, 0x0020, 6, 3),
> +       PIN_FIELD_BASE(55, IOCFG_RM_BASE, 0x0020, 12, 3),
> +       PIN_FIELD_BASE(56, IOCFG_LT_BASE, 0x0000, 24, 3),
> +       PIN_FIELD_BASE(57, IOCFG_RM_BASE, 0x0000, 6, 3),
> +       PIN_FIELD_BASE(58, IOCFG_RM_BASE, 0x0000, 12, 3),
> +       PIN_FIELD_BASE(59, IOCFG_RM_BASE, 0x0000, 0, 3),
> +       PIN_FIELD_BASE(60, IOCFG_RM_BASE, 0x0000, 9, 3),
> +       PIN_FIELD_BASE(61, IOCFG_RM_BASE, 0x0000, 15, 3),
> +       PIN_FIELD_BASE(62, IOCFG_RM_BASE, 0x0000, 3, 3),
> +       PIN_FIELD_BASE(63, IOCFG_LB_BASE, 0x0010, 0, 3),
> +       PIN_FIELD_BASE(64, IOCFG_LB_BASE, 0x0000, 27, 3),
> +       PIN_FIELD_BASE(65, IOCFG_LB_BASE, 0x0020, 6, 3),
> +       PIN_FIELD_BASE(66, IOCFG_LB_BASE, 0x0020, 21, 3),
> +       PIN_FIELD_BASE(67, IOCFG_LB_BASE, 0x0020, 21, 3),
> +       PIN_FIELD_BASE(68, IOCFG_LB_BASE, 0x0020, 12, 3),
> +       PIN_FIELD_BASE(69, IOCFG_LB_BASE, 0x0020, 12, 3),
> +       PIN_FIELD_BASE(70, IOCFG_LB_BASE, 0x0020, 12, 3),
> +       PIN_FIELD_BASE(71, IOCFG_LB_BASE, 0x0020, 12, 3),
> +       PIN_FIELD_BASE(72, IOCFG_LB_BASE, 0x0020, 21, 3),
> +       PIN_FIELD_BASE(73, IOCFG_LB_BASE, 0x0020, 12, 3),
> +       PIN_FIELD_BASE(74, IOCFG_LB_BASE, 0x0020, 18, 3),
> +       PIN_FIELD_BASE(75, IOCFG_LB_BASE, 0x0020, 21, 3),
> +       PIN_FIELD_BASE(76, IOCFG_LB_BASE, 0x0020, 18, 3),
> +       PIN_FIELD_BASE(77, IOCFG_LB_BASE, 0x0020, 18, 3),
> +       PIN_FIELD_BASE(78, IOCFG_LB_BASE, 0x0020, 18, 3),
> +       PIN_FIELD_BASE(79, IOCFG_RM_BASE, 0x0020, 12, 3),
> +       PIN_FIELD_BASE(80, IOCFG_RM_BASE, 0x0010, 6, 3),
> +       PIN_FIELD_BASE(81, IOCFG_RM_BASE, 0x0020, 12, 3),
> +       PIN_FIELD_BASE(82, IOCFG_RM_BASE, 0x0020, 3, 3),
> +       PIN_FIELD_BASE(83, IOCFG_RM_BASE, 0x0000, 18, 3),
> +       PIN_FIELD_BASE(84, IOCFG_RM_BASE, 0x0000, 21, 3),
> +       PIN_FIELD_BASE(85, IOCFG_RM_BASE, 0x0000, 24, 3),
> +       PIN_FIELD_BASE(86, IOCFG_RM_BASE, 0x0010, 27, 3),
> +       PIN_FIELD_BASE(87, IOCFG_RM_BASE, 0x0020, 0, 3),
> +       PIN_FIELD_BASE(88, IOCFG_RM_BASE, 0x0020, 9, 3),
> +       PIN_FIELD_BASE(89, IOCFG_RM_BASE, 0x0020, 15, 3),
> +       PIN_FIELD_BASE(90, IOCFG_LB_BASE, 0x0010, 18, 3),
> +       PIN_FIELD_BASE(91, IOCFG_LB_BASE, 0x0010, 12, 3),
> +       PIN_FIELD_BASE(92, IOCFG_LB_BASE, 0x0010, 21, 3),
> +       PIN_FIELD_BASE(93, IOCFG_LB_BASE, 0x0010, 15, 3),
> +       PIN_FIELD_BASE(94, IOCFG_LB_BASE, 0x0020, 0, 3),
> +       PIN_FIELD_BASE(95, IOCFG_LB_BASE, 0x0010, 24, 3),
> +       PIN_FIELD_BASE(96, IOCFG_LB_BASE, 0x0020, 3, 3),
> +       PIN_FIELD_BASE(97, IOCFG_LB_BASE, 0x0010, 27, 3),
> +       PIN_FIELD_BASE(98, IOCFG_LT_BASE, 0x0000, 27, 3),
> +       PIN_FIELD_BASE(99, IOCFG_LT_BASE, 0x0010, 3, 3),
> +       PIN_FIELD_BASE(100, IOCFG_RM_BASE, 0x0020, 18, 3),
> +       PIN_FIELD_BASE(101, IOCFG_RM_BASE, 0x0020, 27, 3),
> +       PIN_FIELD_BASE(102, IOCFG_RM_BASE, 0x0020, 21, 3),
> +       PIN_FIELD_BASE(103, IOCFG_RM_BASE, 0x0030, 0, 3),
> +       PIN_FIELD_BASE(104, IOCFG_RM_BASE, 0x0020, 24, 3),
> +       PIN_FIELD_BASE(105, IOCFG_RM_BASE, 0x0030, 3, 3),
> +       PIN_FIELD_BASE(106, IOCFG_LT_BASE, 0x0010, 0, 3),
> +       PIN_FIELD_BASE(107, IOCFG_LT_BASE, 0x0010, 6, 3),
> +       PIN_FIELD_BASE(108, IOCFG_LB_BASE, 0x0020, 24, 3),
> +       PIN_FIELD_BASE(109, IOCFG_LB_BASE, 0x0030, 9, 3),
> +       PIN_FIELD_BASE(110, IOCFG_LB_BASE, 0x0020, 27, 3),
> +       PIN_FIELD_BASE(111, IOCFG_LB_BASE, 0x0030, 12, 3),
> +       PIN_FIELD_BASE(112, IOCFG_LB_BASE, 0x0030, 0, 3),
> +       PIN_FIELD_BASE(113, IOCFG_LB_BASE, 0x0030, 15, 3),
> +       PIN_FIELD_BASE(114, IOCFG_LB_BASE, 0x0030, 3, 3),
> +       PIN_FIELD_BASE(115, IOCFG_LB_BASE, 0x0030, 18, 3),
> +       PIN_FIELD_BASE(116, IOCFG_LB_BASE, 0x0030, 21, 3),
> +       PIN_FIELD_BASE(117, IOCFG_LB_BASE, 0x0030, 6, 3),
> +       PIN_FIELD_BASE(118, IOCFG_LB_BASE, 0x0030, 24, 3),
> +       PIN_FIELD_BASE(119, IOCFG_LB_BASE, 0x0030, 27, 3),
> +       PIN_FIELD_BASE(120, IOCFG_LB_BASE, 0x0040, 3, 3),
> +       PIN_FIELD_BASE(121, IOCFG_LB_BASE, 0x0040, 0, 3),
> +       PIN_FIELD_BASE(122, IOCFG_TR_BASE, 0x0010, 0, 3),
> +       PIN_FIELD_BASE(123, IOCFG_TR_BASE, 0x0000, 0, 3),
> +       PIN_FIELD_BASE(124, IOCFG_TR_BASE, 0x0000, 3, 3),
> +       PIN_FIELD_BASE(125, IOCFG_TR_BASE, 0x0010, 3, 3),
> +       PIN_FIELD_BASE(126, IOCFG_TR_BASE, 0x0000, 6, 3),
> +       PIN_FIELD_BASE(127, IOCFG_TR_BASE, 0x0000, 9, 3),
> +       PIN_FIELD_BASE(128, IOCFG_TR_BASE, 0x0000, 12, 3),
> +       PIN_FIELD_BASE(129, IOCFG_TR_BASE, 0x0000, 15, 3),
> +       PIN_FIELD_BASE(130, IOCFG_TR_BASE, 0x0000, 18, 3),
> +       PIN_FIELD_BASE(131, IOCFG_TR_BASE, 0x0000, 21, 3),
> +       PIN_FIELD_BASE(132, IOCFG_TR_BASE, 0x0000, 24, 3),
> +       PIN_FIELD_BASE(133, IOCFG_TR_BASE, 0x0000, 27, 3),
> +       PIN_FIELD_BASE(134, IOCFG_BM_BASE, 0x0030, 15, 3),
> +       PIN_FIELD_BASE(135, IOCFG_BM_BASE, 0x0030, 18, 3),
> +       PIN_FIELD_BASE(136, IOCFG_BM_BASE, 0x0030, 21, 3),
> +       PIN_FIELD_BASE(137, IOCFG_BM_BASE, 0x0030, 24, 3),
> +       PIN_FIELD_BASE(138, IOCFG_BM_BASE, 0x0030, 27, 3),
> +       PIN_FIELD_BASE(139, IOCFG_BM_BASE, 0x0040, 0, 3),
> +       PIN_FIELD_BASE(140, IOCFG_RM_BASE, 0x0010, 9, 3),
> +       PIN_FIELD_BASE(141, IOCFG_RM_BASE, 0x0010, 12, 3),
> +       PIN_FIELD_BASE(142, IOCFG_RM_BASE, 0x0010, 15, 3),
> +       PIN_FIELD_BASE(143, IOCFG_RM_BASE, 0x0010, 18, 3),
> +       PIN_FIELD_BASE(144, IOCFG_RM_BASE, 0x0010, 21, 3),
> +       PIN_FIELD_BASE(145, IOCFG_RM_BASE, 0x0010, 24, 3),
> +       PIN_FIELD_BASE(146, IOCFG_LB_BASE, 0x0000, 9, 3),
> +       PIN_FIELD_BASE(147, IOCFG_LB_BASE, 0x0000, 12, 3),
> +       PIN_FIELD_BASE(148, IOCFG_LB_BASE, 0x0000, 0, 3),
> +       PIN_FIELD_BASE(149, IOCFG_LB_BASE, 0x0000, 3, 3),
> +       PIN_FIELD_BASE(150, IOCFG_LB_BASE, 0x0000, 6, 3),
> +       PIN_FIELD_BASE(151, IOCFG_LB_BASE, 0x0000, 15, 3),
> +       PIN_FIELD_BASE(152, IOCFG_LB_BASE, 0x0000, 18, 3),
> +       PIN_FIELD_BASE(153, IOCFG_LB_BASE, 0x0000, 21, 3),
> +       PIN_FIELD_BASE(154, IOCFG_LB_BASE, 0x0000, 24, 3),
> +       PIN_FIELD_BASE(155, IOCFG_LT_BASE, 0x0000, 3, 3),
> +       PIN_FIELD_BASE(156, IOCFG_LT_BASE, 0x0000, 21, 3),
> +       PIN_FIELD_BASE(157, IOCFG_LT_BASE, 0x0000, 12, 3),
> +       PIN_FIELD_BASE(158, IOCFG_LT_BASE, 0x0000, 15, 3),
> +       PIN_FIELD_BASE(159, IOCFG_LT_BASE, 0x0000, 0, 3),
> +       PIN_FIELD_BASE(160, IOCFG_LT_BASE, 0x0000, 18, 3),
> +       PIN_FIELD_BASE(161, IOCFG_LT_BASE, 0x0000, 6, 3),
> +       PIN_FIELD_BASE(162, IOCFG_LT_BASE, 0x0000, 9, 3),
> +       PIN_FIELD_BASE(163, IOCFG_TL_BASE, 0x0000, 3, 3),
> +       PIN_FIELD_BASE(164, IOCFG_TL_BASE, 0x0000, 3, 3),
> +       PIN_FIELD_BASE(165, IOCFG_TL_BASE, 0x0000, 3, 3),
> +       PIN_FIELD_BASE(166, IOCFG_TL_BASE, 0x0000, 3, 3),
> +       PIN_FIELD_BASE(167, IOCFG_TL_BASE, 0x0000, 6, 3),
> +       PIN_FIELD_BASE(168, IOCFG_TL_BASE, 0x0000, 6, 3),
> +       PIN_FIELD_BASE(169, IOCFG_LT_BASE, 0x0010, 9, 3),
> +       PIN_FIELD_BASE(170, IOCFG_LT_BASE, 0x0000, 24, 3),
> +       PIN_FIELD_BASE(171, IOCFG_TL_BASE, 0x0000, 0, 3),
> +};
> +
> +static const struct mtk_pin_field_calc mt8366_pin_pupd_range[] =3D {
> +       PIN_FIELD_BASE(79, IOCFG_RM_BASE, 0x0090, 0, 1),
> +       PIN_FIELD_BASE(80, IOCFG_RM_BASE, 0x0090, 1, 1),
> +       PIN_FIELD_BASE(81, IOCFG_RM_BASE, 0x0090, 2, 1),
> +       PIN_FIELD_BASE(82, IOCFG_RM_BASE, 0x0090, 3, 1),
> +       PIN_FIELD_BASE(122, IOCFG_TR_BASE, 0x0030, 10, 1),
> +       PIN_FIELD_BASE(123, IOCFG_TR_BASE, 0x0030, 0, 1),
> +       PIN_FIELD_BASE(124, IOCFG_TR_BASE, 0x0030, 1, 1),
> +       PIN_FIELD_BASE(125, IOCFG_TR_BASE, 0x0030, 11, 1),
> +       PIN_FIELD_BASE(126, IOCFG_TR_BASE, 0x0030, 2, 1),
> +       PIN_FIELD_BASE(127, IOCFG_TR_BASE, 0x0030, 3, 1),
> +       PIN_FIELD_BASE(128, IOCFG_TR_BASE, 0x0030, 4, 1),
> +       PIN_FIELD_BASE(129, IOCFG_TR_BASE, 0x0030, 5, 1),
> +       PIN_FIELD_BASE(130, IOCFG_TR_BASE, 0x0030, 6, 1),
> +       PIN_FIELD_BASE(131, IOCFG_TR_BASE, 0x0030, 7, 1),
> +       PIN_FIELD_BASE(132, IOCFG_TR_BASE, 0x0030, 8, 1),
> +       PIN_FIELD_BASE(133, IOCFG_TR_BASE, 0x0030, 9, 1),
> +       PIN_FIELD_BASE(134, IOCFG_BM_BASE, 0x0090, 0, 1),
> +       PIN_FIELD_BASE(135, IOCFG_BM_BASE, 0x0090, 1, 1),
> +       PIN_FIELD_BASE(136, IOCFG_BM_BASE, 0x0090, 2, 1),
> +       PIN_FIELD_BASE(137, IOCFG_BM_BASE, 0x0090, 3, 1),
> +       PIN_FIELD_BASE(138, IOCFG_BM_BASE, 0x0090, 4, 1),
> +       PIN_FIELD_BASE(139, IOCFG_BM_BASE, 0x0090, 5, 1),
> +       PIN_FIELD_BASE(140, IOCFG_RM_BASE, 0x0090, 4, 1),
> +       PIN_FIELD_BASE(141, IOCFG_RM_BASE, 0x0090, 5, 1),
> +       PIN_FIELD_BASE(142, IOCFG_RM_BASE, 0x0090, 6, 1),
> +       PIN_FIELD_BASE(143, IOCFG_RM_BASE, 0x0090, 7, 1),
> +       PIN_FIELD_BASE(144, IOCFG_RM_BASE, 0x0090, 8, 1),
> +       PIN_FIELD_BASE(145, IOCFG_RM_BASE, 0x0090, 9, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8366_pin_r0_range[] =3D {
> +       PIN_FIELD_BASE(79, IOCFG_RM_BASE, 0x00b0, 0, 1),
> +       PIN_FIELD_BASE(80, IOCFG_RM_BASE, 0x00b0, 1, 1),
> +       PIN_FIELD_BASE(81, IOCFG_RM_BASE, 0x00b0, 2, 1),
> +       PIN_FIELD_BASE(82, IOCFG_RM_BASE, 0x00b0, 3, 1),
> +       PIN_FIELD_BASE(122, IOCFG_TR_BASE, 0x0040, 10, 1),
> +       PIN_FIELD_BASE(123, IOCFG_TR_BASE, 0x0040, 0, 1),
> +       PIN_FIELD_BASE(124, IOCFG_TR_BASE, 0x0040, 1, 1),
> +       PIN_FIELD_BASE(125, IOCFG_TR_BASE, 0x0040, 11, 1),
> +       PIN_FIELD_BASE(126, IOCFG_TR_BASE, 0x0040, 2, 1),
> +       PIN_FIELD_BASE(127, IOCFG_TR_BASE, 0x0040, 3, 1),
> +       PIN_FIELD_BASE(128, IOCFG_TR_BASE, 0x0040, 4, 1),
> +       PIN_FIELD_BASE(129, IOCFG_TR_BASE, 0x0040, 5, 1),
> +       PIN_FIELD_BASE(130, IOCFG_TR_BASE, 0x0040, 6, 1),
> +       PIN_FIELD_BASE(131, IOCFG_TR_BASE, 0x0040, 7, 1),
> +       PIN_FIELD_BASE(132, IOCFG_TR_BASE, 0x0040, 8, 1),
> +       PIN_FIELD_BASE(133, IOCFG_TR_BASE, 0x0040, 9, 1),
> +       PIN_FIELD_BASE(134, IOCFG_BM_BASE, 0x00c0, 0, 1),
> +       PIN_FIELD_BASE(135, IOCFG_BM_BASE, 0x00c0, 1, 1),
> +       PIN_FIELD_BASE(136, IOCFG_BM_BASE, 0x00c0, 2, 1),
> +       PIN_FIELD_BASE(137, IOCFG_BM_BASE, 0x00c0, 3, 1),
> +       PIN_FIELD_BASE(138, IOCFG_BM_BASE, 0x00c0, 4, 1),
> +       PIN_FIELD_BASE(139, IOCFG_BM_BASE, 0x00c0, 5, 1),
> +       PIN_FIELD_BASE(140, IOCFG_RM_BASE, 0x00b0, 4, 1),
> +       PIN_FIELD_BASE(141, IOCFG_RM_BASE, 0x00b0, 5, 1),
> +       PIN_FIELD_BASE(142, IOCFG_RM_BASE, 0x00b0, 6, 1),
> +       PIN_FIELD_BASE(143, IOCFG_RM_BASE, 0x00b0, 7, 1),
> +       PIN_FIELD_BASE(144, IOCFG_RM_BASE, 0x00b0, 8, 1),
> +       PIN_FIELD_BASE(145, IOCFG_RM_BASE, 0x00b0, 9, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8366_pin_r1_range[] =3D {
> +       PIN_FIELD_BASE(79, IOCFG_RM_BASE, 0x00c0, 0, 1),
> +       PIN_FIELD_BASE(80, IOCFG_RM_BASE, 0x00c0, 1, 1),
> +       PIN_FIELD_BASE(81, IOCFG_RM_BASE, 0x00c0, 2, 1),
> +       PIN_FIELD_BASE(82, IOCFG_RM_BASE, 0x00c0, 3, 1),
> +       PIN_FIELD_BASE(122, IOCFG_TR_BASE, 0x0050, 10, 1),
> +       PIN_FIELD_BASE(123, IOCFG_TR_BASE, 0x0050, 0, 1),
> +       PIN_FIELD_BASE(124, IOCFG_TR_BASE, 0x0050, 1, 1),
> +       PIN_FIELD_BASE(125, IOCFG_TR_BASE, 0x0050, 11, 1),
> +       PIN_FIELD_BASE(126, IOCFG_TR_BASE, 0x0050, 2, 1),
> +       PIN_FIELD_BASE(127, IOCFG_TR_BASE, 0x0050, 3, 1),
> +       PIN_FIELD_BASE(128, IOCFG_TR_BASE, 0x0050, 4, 1),
> +       PIN_FIELD_BASE(129, IOCFG_TR_BASE, 0x0050, 5, 1),
> +       PIN_FIELD_BASE(130, IOCFG_TR_BASE, 0x0050, 6, 1),
> +       PIN_FIELD_BASE(131, IOCFG_TR_BASE, 0x0050, 7, 1),
> +       PIN_FIELD_BASE(132, IOCFG_TR_BASE, 0x0050, 8, 1),
> +       PIN_FIELD_BASE(133, IOCFG_TR_BASE, 0x0050, 9, 1),
> +       PIN_FIELD_BASE(134, IOCFG_BM_BASE, 0x00d0, 0, 1),
> +       PIN_FIELD_BASE(135, IOCFG_BM_BASE, 0x00d0, 1, 1),
> +       PIN_FIELD_BASE(136, IOCFG_BM_BASE, 0x00d0, 2, 1),
> +       PIN_FIELD_BASE(137, IOCFG_BM_BASE, 0x00d0, 3, 1),
> +       PIN_FIELD_BASE(138, IOCFG_BM_BASE, 0x00d0, 4, 1),
> +       PIN_FIELD_BASE(139, IOCFG_BM_BASE, 0x00d0, 5, 1),
> +       PIN_FIELD_BASE(140, IOCFG_RM_BASE, 0x00c0, 4, 1),
> +       PIN_FIELD_BASE(141, IOCFG_RM_BASE, 0x00c0, 5, 1),
> +       PIN_FIELD_BASE(142, IOCFG_RM_BASE, 0x00c0, 6, 1),
> +       PIN_FIELD_BASE(143, IOCFG_RM_BASE, 0x00c0, 7, 1),
> +       PIN_FIELD_BASE(144, IOCFG_RM_BASE, 0x00c0, 8, 1),
> +       PIN_FIELD_BASE(145, IOCFG_RM_BASE, 0x00c0, 9, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8366_pin_rsel_range[] =3D {
> +       PIN_FIELD_BASE(98, IOCFG_LT_BASE, 0x0080, 0, 3),
> +       PIN_FIELD_BASE(99, IOCFG_LT_BASE, 0x0080, 6, 3),
> +       PIN_FIELD_BASE(100, IOCFG_RM_BASE, 0x00f0, 0, 3),
> +       PIN_FIELD_BASE(101, IOCFG_RM_BASE, 0x00f0, 9, 3),
> +       PIN_FIELD_BASE(102, IOCFG_RM_BASE, 0x00f0, 3, 3),
> +       PIN_FIELD_BASE(103, IOCFG_RM_BASE, 0x00f0, 12, 3),
> +       PIN_FIELD_BASE(104, IOCFG_RM_BASE, 0x00f0, 6, 3),
> +       PIN_FIELD_BASE(105, IOCFG_RM_BASE, 0x00f0, 15, 3),
> +       PIN_FIELD_BASE(106, IOCFG_LT_BASE, 0x0080, 3, 3),
> +       PIN_FIELD_BASE(107, IOCFG_LT_BASE, 0x0080, 9, 3),
> +       PIN_FIELD_BASE(108, IOCFG_LB_BASE, 0x00f0, 0, 3),
> +       PIN_FIELD_BASE(109, IOCFG_LB_BASE, 0x00f0, 15, 3),
> +       PIN_FIELD_BASE(110, IOCFG_LB_BASE, 0x00f0, 3, 3),
> +       PIN_FIELD_BASE(111, IOCFG_LB_BASE, 0x00f0, 18, 3),
> +       PIN_FIELD_BASE(112, IOCFG_LB_BASE, 0x00f0, 6, 3),
> +       PIN_FIELD_BASE(113, IOCFG_LB_BASE, 0x00f0, 21, 3),
> +       PIN_FIELD_BASE(114, IOCFG_LB_BASE, 0x00f0, 9, 3),
> +       PIN_FIELD_BASE(115, IOCFG_LB_BASE, 0x00f0, 24, 3),
> +       PIN_FIELD_BASE(116, IOCFG_LB_BASE, 0x00f0, 12, 3),
> +       PIN_FIELD_BASE(117, IOCFG_LB_BASE, 0x00f0, 27, 3),
> +};
> +
> +static const struct mtk_pin_reg_calc mt8366_reg_cals[] =3D {
> +       [PINCTRL_PIN_REG_MODE] =3D MTK_RANGE(mt8366_pin_mode_range),
> +       [PINCTRL_PIN_REG_DIR] =3D MTK_RANGE(mt8366_pin_dir_range),
> +       [PINCTRL_PIN_REG_DI] =3D MTK_RANGE(mt8366_pin_di_range),
> +       [PINCTRL_PIN_REG_DO] =3D MTK_RANGE(mt8366_pin_do_range),
> +       [PINCTRL_PIN_REG_SMT] =3D MTK_RANGE(mt8366_pin_smt_range),
> +       [PINCTRL_PIN_REG_IES] =3D MTK_RANGE(mt8366_pin_ies_range),
> +       [PINCTRL_PIN_REG_PU] =3D MTK_RANGE(mt8366_pin_pu_range),
> +       [PINCTRL_PIN_REG_PD] =3D MTK_RANGE(mt8366_pin_pd_range),
> +       [PINCTRL_PIN_REG_DRV] =3D MTK_RANGE(mt8366_pin_drv_range),
> +       [PINCTRL_PIN_REG_PUPD] =3D MTK_RANGE(mt8366_pin_pupd_range),
> +       [PINCTRL_PIN_REG_R0] =3D MTK_RANGE(mt8366_pin_r0_range),
> +       [PINCTRL_PIN_REG_R1] =3D MTK_RANGE(mt8366_pin_r1_range),
> +       [PINCTRL_PIN_REG_RSEL] =3D MTK_RANGE(mt8366_pin_rsel_range),
> +};
> +
> +static const struct mtk_pin_desc mt8366_pins[] =3D {
> +       MTK_TYPED_PIN(0, "GPIO0", DRV_GRP4, IO_TYPE_GRP0),

nitpick: some drivers such as mt8188 declares some defines to simplify this=
:

#define MT8188_TYPE0_PIN(_number, _name)        \
        MTK_TYPED_PIN(_number, _name, DRV_GRP4, IO_TYPE_GRP0)

#define MT8188_TYPE1_PIN(_number, _name)        \
        MTK_TYPED_PIN(_number, _name, DRV_GRP4, IO_TYPE_GRP1)

maybe worth adding such defines?

> +       MTK_TYPED_PIN(1, "GPIO1", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(2, "GPIO2", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(3, "GPIO3", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(4, "GPIO4", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(5, "GPIO5", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(6, "GPIO6", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(7, "GPIO7", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(8, "GPIO8", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(9, "GPIO9", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(10, "GPIO10", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(11, "GPIO11", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(12, "GPIO12", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(13, "GPIO13", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(14, "GPIO14", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(15, "GPIO15", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(16, "GPIO16", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(17, "GPIO17", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(18, "GPIO18", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(19, "GPIO19", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(20, "GPIO20", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(21, "GPIO21", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(22, "GPIO22", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(23, "GPIO23", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(24, "GPIO24", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(25, "GPIO25", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(26, "GPIO26", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(27, "GPIO27", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(28, "GPIO28", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(29, "GPIO29", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(30, "GPIO30", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(31, "GPIO31", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(32, "GPIO32", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(33, "GPIO33", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(34, "GPIO34", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(35, "GPIO35", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(36, "GPIO36", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(37, "GPIO37", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(38, "GPIO38", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(39, "GPIO39", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(40, "GPIO40", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(41, "GPIO41", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(42, "GPIO42", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(43, "GPIO43", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(44, "GPIO44", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(45, "GPIO45", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(46, "GPIO46", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(47, "GPIO47", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(48, "GPIO48", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(49, "GPIO49", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(50, "GPIO50", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(51, "GPIO51", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(52, "GPIO52", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(53, "GPIO53", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(54, "GPIO54", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(55, "GPIO55", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(56, "GPIO56", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(57, "GPIO57", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(58, "GPIO58", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(59, "GPIO59", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(60, "GPIO60", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(61, "GPIO61", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(62, "GPIO62", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(63, "GPIO63", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(64, "GPIO64", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(65, "GPIO65", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(66, "GPIO66", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(67, "GPIO67", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(68, "GPIO68", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(69, "GPIO69", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(70, "GPIO70", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(71, "GPIO71", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(72, "GPIO72", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(73, "GPIO73", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(74, "GPIO74", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(75, "GPIO75", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(76, "GPIO76", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(77, "GPIO77", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(78, "GPIO78", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(79, "GPIO79", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(80, "GPIO80", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(81, "GPIO81", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(82, "GPIO82", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(83, "GPIO83", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(84, "GPIO84", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(85, "GPIO85", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(86, "GPIO86", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(87, "GPIO87", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(88, "GPIO88", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(89, "GPIO89", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(90, "GPIO90", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(91, "GPIO91", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(92, "GPIO92", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(93, "GPIO93", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(94, "GPIO94", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(95, "GPIO95", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(96, "GPIO96", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(97, "GPIO97", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(98, "GPIO98", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(99, "GPIO99", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(100, "GPIO100", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(101, "GPIO101", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(102, "GPIO102", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(103, "GPIO103", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(104, "GPIO104", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(105, "GPIO105", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(106, "GPIO106", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(107, "GPIO107", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(108, "GPIO108", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(109, "GPIO109", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(110, "GPIO110", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(111, "GPIO111", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(112, "GPIO112", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(113, "GPIO113", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(114, "GPIO114", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(115, "GPIO115", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(116, "GPIO116", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(117, "GPIO117", DRV_GRP4, IO_TYPE_GRP2),
> +       MTK_TYPED_PIN(118, "GPIO118", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(119, "GPIO119", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(120, "GPIO120", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(121, "GPIO121", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(122, "GPIO122", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(123, "GPIO123", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(124, "GPIO124", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(125, "GPIO125", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(126, "GPIO126", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(127, "GPIO127", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(128, "GPIO128", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(129, "GPIO129", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(130, "GPIO130", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(131, "GPIO131", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(132, "GPIO132", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(133, "GPIO133", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(134, "GPIO134", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(135, "GPIO135", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(136, "GPIO136", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(137, "GPIO137", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(138, "GPIO138", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(139, "GPIO139", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(140, "GPIO140", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(141, "GPIO141", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(142, "GPIO142", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(143, "GPIO143", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(144, "GPIO144", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(145, "GPIO145", DRV_GRP4, IO_TYPE_GRP1),
> +       MTK_TYPED_PIN(146, "GPIO146", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(147, "GPIO147", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(148, "GPIO148", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(149, "GPIO149", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(150, "GPIO150", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(151, "GPIO151", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(152, "GPIO152", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(153, "GPIO153", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(154, "GPIO154", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(155, "GPIO155", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(156, "GPIO156", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(157, "GPIO157", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(158, "GPIO158", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(159, "GPIO159", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(160, "GPIO160", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(161, "GPIO161", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(162, "GPIO162", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(163, "GPIO163", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(164, "GPIO164", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(165, "GPIO165", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(166, "GPIO166", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(167, "GPIO167", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(168, "GPIO168", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(169, "GPIO169", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(170, "GPIO170", DRV_GRP4, IO_TYPE_GRP0),
> +       MTK_TYPED_PIN(171, "GPIO171", DRV_GRP4, IO_TYPE_GRP0),
> +};
> +
> +static const struct mtk_io_type_desc mt8366_io_type_desc[] =3D {
> +       [IO_TYPE_GRP0] =3D {
> +               .name =3D "mt8366_pupd",
> +               .bias_set =3D mtk_pinconf_bias_set_pu_pd,
> +               .drive_set =3D mtk_pinconf_drive_set_v1,
> +               .input_enable =3D mtk_pinconf_input_enable_v1,
> +               .get_pinconf =3D mtk_pinconf_get_pu_pd,
> +       },
> +       [IO_TYPE_GRP1] =3D {
> +               .name =3D "mt8366_pupdr1r0",
> +               .bias_set =3D mtk_pinconf_bias_set_pupd_r1_r0,
> +               .drive_set =3D mtk_pinconf_drive_set_v1,
> +               .input_enable =3D mtk_pinconf_input_enable_v1,
> +               .get_pinconf =3D mtk_pinconf_get_pupd_r1_r0,
> +       },
> +       [IO_TYPE_GRP2] =3D {
> +               .name =3D "mt8366_pupd_rsel",
> +               .bias_set =3D mtk_pinconf_bias_set_pu_pd_rsel,
> +               .drive_set =3D mtk_pinconf_drive_set_v1,
> +               .input_enable =3D mtk_pinconf_input_enable_v1,
> +               .get_pinconf =3D mtk_pinconf_get_pu_pd_rsel,
> +       },
> +};
> +
> +static struct mtk_pinctrl_soc mt8366_data =3D {

should be const

> +       .name =3D "mt8366_pinctrl",
> +       .reg_cal =3D mt8366_reg_cals,
> +       .pins =3D mt8366_pins,
> +       .npins =3D ARRAY_SIZE(mt8366_pins),
> +       .io_type =3D mt8366_io_type_desc,
> +       .ntype =3D ARRAY_SIZE(mt8366_io_type_desc),
> +       .gpio_mode =3D 0,
> +       .base_names =3D mt8366_pinctrl_register_base_names,
> +       .nbase_names =3D ARRAY_SIZE(mt8366_pinctrl_register_base_names),
> +       .base_calc =3D 1,
> +};
> +
> +static int mtk_pinctrl_mt8366_probe(struct udevice *dev)
> +{
> +       return mtk_pinctrl_common_probe(dev, &mt8366_data);
> +}
> +
> +static const struct udevice_id mt8366_pctrl_match[] =3D {
> +       { .compatible =3D "mediatek,mt8366-pinctrl" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(mt8366_pinctrl) =3D {
> +       .name =3D "mt8366_pinctrl",
> +       .id =3D UCLASS_PINCTRL,
> +       .of_match =3D mt8366_pctrl_match,
> +       .ops =3D &mtk_pinctrl_ops,
> +       .bind =3D mtk_pinctrl_common_bind,
> +       .probe =3D mtk_pinctrl_mt8366_probe,
> +       .priv_auto =3D sizeof(struct mtk_pinctrl_priv),
> +};
>
> ---
> base-commit: 05b9e779d2be304609f7e9570edac049092c7736
> change-id: 20260803-mtk-pinctrl-mt8366-ee0c69cc4914
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

considering you can add the const while applying,

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
