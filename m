Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C357D1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 09:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AA1E83BC8;
	Tue,  9 Dec 2025 10:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZSa4aORl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50162838FA; Tue,  9 Dec 2025 10:27:47 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D735083C8C
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 10:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b735487129fso794757566b.0
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 01:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765272464; x=1765877264;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQ1+fvSu8eIqc+55Qntnyjf0rczQjN9WnNObXXkKJyw=;
 b=ZSa4aORlnLTm/jSweYcHJVA9zvB73VW/+ZMeNk59t6fmghCTDKGhCyL1hIqUJocuDS
 eNYDXlgl/ztAXpp7voXezTugR1gbftsGVSmcYYfN6Hx4GOzrniLiK87SHCgK1iqr+wtf
 +nhc/7jR1LwPeONiGujCnqacAhW7wpJi6pjxGuN4L4Ba5EABjBIhOnO/jcjbEzXehRK/
 HOE9KtvwQul5wne8eVOYz2xlu/oX43aSZa9iJC6YToZ8HO8f7+iOfa9HlVQ4SBawR7PZ
 Qwg01RzaohK+FjEGSgPSQjMk8VfsSJ83lOoE/Vk/v4Ex5TeNkP4/UeO3MVmFyJY9aJJa
 YywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765272464; x=1765877264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iQ1+fvSu8eIqc+55Qntnyjf0rczQjN9WnNObXXkKJyw=;
 b=Pzm/mzu5RhSSMBgWPaW8HiQ/zKq1ykS1iKR1xG/7TJ8EAyWh4cKQoM1sBoJEOg05s8
 97J6PpIMmGDg1aXFmNHbtvVlx+CWAsR0iqQy1WBFxefQgB8Yz3EgPXTfgTWMiTduU90+
 dmhYq3qM7tZhx1jlJZvmIVPbo17og9GYmCUStypnPYCiaFPv/4TLWFlmaiji8bUIdGdh
 iVRf62WJeMdB3knALzx00Hb88JaV+Auxay3WBAmm0+/AL5eKz373k/cfNQtG1NfdV2Wq
 JVkjR1ggeZAKldtEOh9my2SDY7+/LaVdPTwLbjYJZn+iut50US8AUugeoM0z9fAIyk8L
 8glQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgJ+GYaxG5wzwzWvxYsSI9FG6w1UiN5YBY77ClJvHVsPIfuF5VwNdAQw3z5hGnX323xaY2y/Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwwZc1kz1JSDOlVaDltslooA8JmsxCjuNZi/MCpdrjwneYh0Rtc
 JvtCH3v3Fh2XCAtqzZAzDcuFPIdw4LKy2dUQIxED0MehVQ1pErUKuU3dzHXQjzRuktO6d8n0Rjd
 osbPVhzaTRwrUREPlBJIJl1gmsWslrOIv0jA8c2/zEg==
X-Gm-Gg: ASbGncu44Q/lc77hZ4tjtlfInJ4ZzV2HsvelL31+ASEaDIgQUTBBVdjE6rxgx/pMJaz
 fUKpzN/JecSW2bM2/oC/W/0x+mP4yVOogIB/rF8KXGewTvNSUF3mYOMp6Fz2LV7Rg9hZZIr4Eqa
 Dny1+WyP7vJB1MYaIqi16BVuJkDZBLO84sLXZdJF+RGdLzxBgwualvsw46hzjHrKBbuelNLYUx7
 ylYKm1/sJdV5PKOMrVop7nQ0Sj/zkRwJwbWP6JGa1Zstp5H6nnwrUOUehsNNY2rwNZ18HGH+ecO
 FhdSQOJ3a2uePFF9mxkG99ES70DqFQ==
X-Google-Smtp-Source: AGHT+IEz5mnCeyaRih8IxZHyZsqmCVHYs4L4mTKQRNoCpBk8C4OPMs+AB54X9zTWEAdGq+WOxfMZGp5RtlNXX0QLhZQ=
X-Received: by 2002:a17:907:3c93:b0:b40:8deb:9cbe with SMTP id
 a640c23a62f3a-b7a243058f9mr940264366b.2.1765272464161; Tue, 09 Dec 2025
 01:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com>
 <20251203-add-mt8188-support-v1-2-9a06ebb97734@baylibre.com>
 <20251205144711.543ba2a8@kmaincent-XPS-13-7390>
In-Reply-To: <20251205144711.543ba2a8@kmaincent-XPS-13-7390>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 9 Dec 2025 10:27:32 +0100
X-Gm-Features: AQt7F2oC1K7oR59WEztvRwdZIVNgzcdw6Ofm9xAi8pw17bWXCnAmS3AyssDDMuA
Message-ID: <CAEHHSvbW4usYU0SBZDOqX0ktseDbPMSnTaywrNCx2bsGkSMG3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: mediatek: add MT8188 clock driver
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>,
 Yao Zi <ziyao@disroot.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Sam Shih <sam.shih@mediatek.com>, David Lechner <dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
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

Le ven. 5 d=C3=A9c. 2025 =C3=A0 14:47, Kory Maincent <kory.maincent@bootlin=
.com> a =C3=A9crit :
>
> On Wed, 03 Dec 2025 10:31:53 +0100
> Julien Stephan <jstephan@baylibre.com> wrote:
>
> > From: Julien Masson <jmasson@baylibre.com>
> >
> > The following clocks have been added for MT8188 SoC:
> > apmixedsys, topckgen, infracfg, pericfg and imp_iic_wrap
> >
> > These clocks driver are based on the ones present in the kernel:
> > drivers/clk/mediatek/clk-mt8188-*
> >
> > Signed-off-by: Julien Masson <jmasson@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >  drivers/clk/mediatek/Makefile     |    1 +
> >  drivers/clk/mediatek/clk-mt8188.c | 1840
> > +++++++++++++++++++++++++++++++++++++ 2 files changed, 1841 insertions(=
+)
> >
>
> ...
>
> > +
> > +static int mt8188_apmixedsys_probe(struct udevice *dev)
> > +{
> > +     return mtk_common_clk_init(dev, &mt8188_apmixedsys_clk_tree);
> > +}
> > +
> > +static int mt8188_topckgen_probe(struct udevice *dev)
> > +{
> > +     return mtk_common_clk_init(dev, &mt8188_topckgen_clk_tree);
> > +}
> > +
> > +static int mt8188_topckgen_cg_probe(struct udevice *dev)
> > +{
> > +     return mtk_common_clk_gate_init(dev, &mt8188_topckgen_cg_clk_tree=
,
> > topckgen_cg_clks); +}
> > +
> > +static int mt8188_infracfg_ao_probe(struct udevice *dev)
> > +{
> > +     return mtk_common_clk_gate_init(dev, &mt8188_infracfg_ao_clk_tree=
,
> > infracfg_ao_clks); +}
> > +
> > +static int mt8188_pericfg_ao_probe(struct udevice *dev)
> > +{
> > +     return mtk_common_clk_gate_init(dev, &mt8188_pericfg_ao_clk_tree,
> > pericfg_ao_clks); +}
> > +
> > +static int mt8188_imp_iic_wrap_c_probe(struct udevice *dev)
> > +{
> > +     return mtk_common_clk_gate_init(dev,
> > &mt8188_imp_iic_wrap_c_clk_tree, imp_iic_wrap_c_clks); +}
> > +
> > +static int mt8188_imp_iic_wrap_w_probe(struct udevice *dev)
> > +{
> > +     return mtk_common_clk_gate_init(dev,
> > &mt8188_imp_iic_wrap_w_clk_tree, imp_iic_wrap_w_clks); +}
> > +
> > +static int mt8188_imp_iic_wrap_en_probe(struct udevice *dev)
> > +{
> > +     return mtk_common_clk_gate_init(dev,
> > &mt8188_imp_iic_wrap_en_clk_tree,
> > +                                     imp_iic_wrap_en_clks);
> > +}
> > +
> > +static const struct udevice_id mt8188_apmixed_compat[] =3D {
> > +     { .compatible =3D "mediatek,mt8188-apmixedsys", },
> > +     { }
> > +};
> > +
> > +static const struct udevice_id mt8188_topckgen_compat[] =3D {
> > +     { .compatible =3D "mediatek,mt8188-topckgen", },
> > +     { }
> > +};
> > +
> > +static const struct udevice_id mt8188_topckgen_cg_compat[] =3D {
> > +     { .compatible =3D "mediatek,mt8188-topckgen-cg", },
> > +     { }
> > +};
> > +
> > +static const struct udevice_id mt8188_infracfg_ao_compat[] =3D {
> > +     { .compatible =3D "mediatek,mt8188-infracfg-ao", },
> > +     { }
> > +};
> > +
> > +static const struct udevice_id mt8188_pericfg_ao_compat[] =3D {
> > +     { .compatible =3D "mediatek,mt8188-pericfg-ao", },
> > +     { }
> > +};
> > +
> > +static const struct udevice_id mt8188_imp_iic_wrap_c_compat[] =3D {
> > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-c", },
> > +     { }
> > +};
> > +
> > +static const struct udevice_id mt8188_imp_iic_wrap_w_compat[] =3D {
> > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-w", },
> > +     { }
> > +};
> > +
> > +static const struct udevice_id mt8188_imp_iic_wrap_en_compat[] =3D {
> > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-en", },
> > +     { }
> > +};
>
> Why don't you use udevice_id data field to describe each of the mediatek,=
mt8188
> version? This would avoid having this number of probe function, udevice_i=
d
> structs and U_BOOT_DRIVER definitions.
>

Hi Kory,

I am not the original author, but I guess it's done that way to be as
close as possible to the Kernel.
Moreover all drivers in drivers/clk/mediatek/ are designed that way,
so we keep consistency between Mediatek clock driverss

Cheers,
Julien Stephan

> > +
> > +U_BOOT_DRIVER(mtk_clk_apmixedsys) =3D {
> > +     .name =3D "mt8188-apmixedsys",
> > +     .id =3D UCLASS_CLK,
> > +     .of_match =3D mt8188_apmixed_compat,
> > +     .probe =3D mt8188_apmixedsys_probe,
> > +     .priv_auto =3D sizeof(struct mtk_clk_priv),
> > +     .ops =3D &mtk_clk_apmixedsys_ops,
> > +     .flags =3D DM_FLAG_PRE_RELOC,
> > +};
> > +
> > +U_BOOT_DRIVER(mtk_clk_topckgen) =3D {
> > +     .name =3D "mt8188-topckgen",
> > +     .id =3D UCLASS_CLK,
> > +     .of_match =3D mt8188_topckgen_compat,
> > +     .probe =3D mt8188_topckgen_probe,
> > +     .priv_auto =3D sizeof(struct mtk_clk_priv),
> > +     .ops =3D &mtk_clk_topckgen_ops,
> > +     .flags =3D DM_FLAG_PRE_RELOC,
> > +};
> > +
> > +U_BOOT_DRIVER(mtk_clk_topckgen_cg) =3D {
> > +     .name =3D "mt8188-topckgen-cg",
> > +     .id =3D UCLASS_CLK,
> > +     .of_match =3D mt8188_topckgen_cg_compat,
> > +     .probe =3D mt8188_topckgen_cg_probe,
> > +     .priv_auto =3D sizeof(struct mtk_cg_priv),
> > +     .ops =3D &mtk_clk_gate_ops,
> > +     .flags =3D DM_FLAG_PRE_RELOC,
> > +};
> > +
> > +U_BOOT_DRIVER(mtk_clk_infracfg_ao) =3D {
> > +     .name =3D "mt8188-infracfg-ao",
> > +     .id =3D UCLASS_CLK,
> > +     .of_match =3D mt8188_infracfg_ao_compat,
> > +     .probe =3D mt8188_infracfg_ao_probe,
> > +     .priv_auto =3D sizeof(struct mtk_cg_priv),
> > +     .ops =3D &mtk_clk_gate_ops,
> > +     .flags =3D DM_FLAG_PRE_RELOC,
> > +};
> > +
> > +U_BOOT_DRIVER(mtk_clk_pericfg_ao) =3D {
> > +     .name =3D "mt8188-pericfg-ao",
> > +     .id =3D UCLASS_CLK,
> > +     .of_match =3D mt8188_pericfg_ao_compat,
> > +     .probe =3D mt8188_pericfg_ao_probe,
> > +     .priv_auto =3D sizeof(struct mtk_cg_priv),
> > +     .ops =3D &mtk_clk_gate_ops,
> > +     .flags =3D DM_FLAG_PRE_RELOC,
> > +};
> > +
> > +U_BOOT_DRIVER(mtk_clk_imp_iic_wrap_c) =3D {
> > +     .name =3D "mt8188-imp_iic_wrap_c",
> > +     .id =3D UCLASS_CLK,
> > +     .of_match =3D mt8188_imp_iic_wrap_c_compat,
> > +     .probe =3D mt8188_imp_iic_wrap_c_probe,
> > +     .priv_auto =3D sizeof(struct mtk_cg_priv),
> > +     .ops =3D &mtk_clk_gate_ops,
> > +     .flags =3D DM_FLAG_PRE_RELOC,
> > +};
> > +
> > +U_BOOT_DRIVER(mtk_clk_imp_iic_wrap_w) =3D {
> > +     .name =3D "mt8188-imp_iic_wrap_w",
> > +     .id =3D UCLASS_CLK,
> > +     .of_match =3D mt8188_imp_iic_wrap_w_compat,
> > +     .probe =3D mt8188_imp_iic_wrap_w_probe,
> > +     .priv_auto =3D sizeof(struct mtk_cg_priv),
> > +     .ops =3D &mtk_clk_gate_ops,
> > +     .flags =3D DM_FLAG_PRE_RELOC,
> > +};
> > +
> > +U_BOOT_DRIVER(mtk_clk_imp_iic_wrap_en) =3D {
> > +     .name =3D "mt8188-imp_iic_wrap_en",
> > +     .id =3D UCLASS_CLK,
> > +     .of_match =3D mt8188_imp_iic_wrap_en_compat,
> > +     .probe =3D mt8188_imp_iic_wrap_en_probe,
> > +     .priv_auto =3D sizeof(struct mtk_cg_priv),
> > +     .ops =3D &mtk_clk_gate_ops,
> > +     .flags =3D DM_FLAG_PRE_RELOC,
> > +};
> >
>
>
>
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
