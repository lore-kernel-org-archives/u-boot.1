Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5228D3E77B
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 21:20:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B3B83A91;
	Wed, 10 Dec 2025 22:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eGZ+pLAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9CC783C7B; Wed, 10 Dec 2025 22:20:48 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B9183A26
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 22:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so41181066b.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 13:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765401646; x=1766006446;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULjdmtUmGRLTST9mtHfQ9wyPjf1RWCsOUPQryvbalh0=;
 b=eGZ+pLAFMyF5az+3M1yUKPIa003Ex570KXRAWA7lXGwStgOu3ywSvHMBM7gAIHbo1h
 S3X67qUSqr+2aCnfdhKrryGJgIsKkBZBytE4EQJeht8sPWyuZmdXYEa79cwQgoHCvYFJ
 /pQ5KBHVmHGAhpi93n6Byu/2pJxZztblZsgGk0Nwkn8m4cLA2kTH4TeRS0TV53hVcPgt
 BAcj1OVxaqSirb3SoIpPsg7X31R98ju7ZZfZvye1IuUKFKDB+ET6DgsQ9lV4O4buXuaA
 UTURFWN4Nox30X47xkSnJIrPZg4gdNp1xvaFX5e+sSiozyxIwm0yVyiXTq6zo4vybMaF
 juwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765401646; x=1766006446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ULjdmtUmGRLTST9mtHfQ9wyPjf1RWCsOUPQryvbalh0=;
 b=AupeccBNJkBu0bt2kUpf6O2u0mOB+42/+mV51yH1xIag7wsxGnB2ktFffObbrlulOp
 Gmge+DdgPWevfnWMRKcVyutOjLiOuHChlmo5PwkZkrR98KWWGQ5SctOO0zwGtmwkKOL6
 fhTBJwov5GWG88ORaa/oeVAA6kUrgUqbAvyOPGq7xPmmJpt7ch1jIl6y70nmQo4WSGOn
 j1YCzUKcC9nw8Xp9LqnxfzV0PHPy+zpSXVwKieBgVPz4YDINUT1dzzHFktdO+LCdsl+D
 02HjYGPhQnF1rfGIWt/IO+w2s4qOigkbLKThLv7KoTFt8rw6vSZ/8xft7LWI+h4PZvV5
 c1jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgy1fsjD3bPzSpXYtF3iYkyv0zMj6hUk+5K0FwR/pv4mxlBLUstN6j1QJp+ixXdV5DJH0S9Ws=@lists.denx.de
X-Gm-Message-State: AOJu0YxA33IRz0t4LTAlJJfLOSctDVmCK3lo8BaR8Y/H/xkypjSCONpR
 CeTwTqOPzQvVTW42VfBzUd6LOcorL7+RN9EwSry0dgeplp2OuZeJvoEn+I6gDjBflYdr+wpLK+x
 /9w2PQ1YtTCqQ6Gyu86xKTBSkmrP8K6y97xUGTaeCUA==
X-Gm-Gg: AY/fxX6btjLIBl9EBdIu+JcwLsTxtvx1ys9esdGFLl+MUM0sK/Yu4OIMdTvDzLGxz7v
 TL/+DfHGl7pBxGSonymspc0/915LsBmQWO8X582btIyxJ95+FSHnVcKli/Zsnm9Ygu5BC8MJlDT
 Jc01OVZbOA9DlUVpPb7x2GvJ731a8yZAdrKRf0StE+fE/VtFyABQ/6Qv+Oi93J4d8o0c+42Cs9t
 4X8nM6C8wnoDtlNfjnp5TtJV7TFwnzrCSEGMQU9lGawftjezMxOr3Rreyh0xBy6KiQchElz2HF4
 +TK6GtksGHpy7xzilW3tJsqKcoNDlQ==
X-Google-Smtp-Source: AGHT+IG3UtUY9suq8WIzMh8+kRPJfyB3oSuz8YqO16PfGzn6HuR4J2vTbSaWlxRURmhzW6hfkL+pqOsz8qzpVP9VBKs=
X-Received: by 2002:a17:907:d8d:b0:b72:6728:5bb1 with SMTP id
 a640c23a62f3a-b7ce856873dmr444952066b.56.1765401645474; Wed, 10 Dec 2025
 13:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com>
 <20251203-add-mt8188-support-v1-2-9a06ebb97734@baylibre.com>
 <20251205144711.543ba2a8@kmaincent-XPS-13-7390>
 <CAEHHSvbW4usYU0SBZDOqX0ktseDbPMSnTaywrNCx2bsGkSMG3g@mail.gmail.com>
 <20251209110320.57aa9a54@kmaincent-XPS-13-7390>
 <20251210175654.GA3377532@bill-the-cat>
In-Reply-To: <20251210175654.GA3377532@bill-the-cat>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 10 Dec 2025 22:20:34 +0100
X-Gm-Features: AQt7F2ozCikrzDb5aoeCzVhgEVhcwPwPtfWPp0HAXYO67oXgHfJa4VsC9M4A8oU
Message-ID: <CAEHHSvZD8wzJ=NK5OYJdbPe=aweJ9RQZhkU8bk_RcROAdQKcVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: mediatek: add MT8188 clock driver
To: Tom Rini <trini@konsulko.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
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

Le mer. 10 d=C3=A9c. 2025 =C3=A0 18:56, Tom Rini <trini@konsulko.com> a =C3=
=A9crit :
>
> On Tue, Dec 09, 2025 at 11:03:20AM +0100, Kory Maincent wrote:
> > On Tue, 9 Dec 2025 10:27:32 +0100
> > Julien Stephan <jstephan@baylibre.com> wrote:
> >
> > > Le ven. 5 d=C3=A9c. 2025 =C3=A0 14:47, Kory Maincent <kory.maincent@b=
ootlin.com> a
> > > =C3=A9crit :
> > > >
> > > > On Wed, 03 Dec 2025 10:31:53 +0100
> > > > Julien Stephan <jstephan@baylibre.com> wrote:
> > > >
> > > > > From: Julien Masson <jmasson@baylibre.com>
> > > > >
> > > > > The following clocks have been added for MT8188 SoC:
> > > > > apmixedsys, topckgen, infracfg, pericfg and imp_iic_wrap
> > > > >
> > > > > These clocks driver are based on the ones present in the kernel:
> > > > > drivers/clk/mediatek/clk-mt8188-*
> > > > >
> > > > > Signed-off-by: Julien Masson <jmasson@baylibre.com>
> > > > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > > > ---
> > > > >  drivers/clk/mediatek/Makefile     |    1 +
> > > > >  drivers/clk/mediatek/clk-mt8188.c | 1840
> > > > > +++++++++++++++++++++++++++++++++++++ 2 files changed, 1841 inser=
tions(+)
> > > > >
> > > >
> > > > ...
> > > >
> > > > > +
> > > > > +static int mt8188_apmixedsys_probe(struct udevice *dev)
> > > > > +{
> > > > > +     return mtk_common_clk_init(dev, &mt8188_apmixedsys_clk_tree=
);
> > > > > +}
> > > > > +
> > > > > +static int mt8188_topckgen_probe(struct udevice *dev)
> > > > > +{
> > > > > +     return mtk_common_clk_init(dev, &mt8188_topckgen_clk_tree);
> > > > > +}
> > > > > +
> > > > > +static int mt8188_topckgen_cg_probe(struct udevice *dev)
> > > > > +{
> > > > > +     return mtk_common_clk_gate_init(dev, &mt8188_topckgen_cg_cl=
k_tree,
> > > > > topckgen_cg_clks); +}
> > > > > +
> > > > > +static int mt8188_infracfg_ao_probe(struct udevice *dev)
> > > > > +{
> > > > > +     return mtk_common_clk_gate_init(dev, &mt8188_infracfg_ao_cl=
k_tree,
> > > > > infracfg_ao_clks); +}
> > > > > +
> > > > > +static int mt8188_pericfg_ao_probe(struct udevice *dev)
> > > > > +{
> > > > > +     return mtk_common_clk_gate_init(dev, &mt8188_pericfg_ao_clk=
_tree,
> > > > > pericfg_ao_clks); +}
> > > > > +
> > > > > +static int mt8188_imp_iic_wrap_c_probe(struct udevice *dev)
> > > > > +{
> > > > > +     return mtk_common_clk_gate_init(dev,
> > > > > &mt8188_imp_iic_wrap_c_clk_tree, imp_iic_wrap_c_clks); +}
> > > > > +
> > > > > +static int mt8188_imp_iic_wrap_w_probe(struct udevice *dev)
> > > > > +{
> > > > > +     return mtk_common_clk_gate_init(dev,
> > > > > &mt8188_imp_iic_wrap_w_clk_tree, imp_iic_wrap_w_clks); +}
> > > > > +
> > > > > +static int mt8188_imp_iic_wrap_en_probe(struct udevice *dev)
> > > > > +{
> > > > > +     return mtk_common_clk_gate_init(dev,
> > > > > &mt8188_imp_iic_wrap_en_clk_tree,
> > > > > +                                     imp_iic_wrap_en_clks);
> > > > > +}
> > > > > +
> > > > > +static const struct udevice_id mt8188_apmixed_compat[] =3D {
> > > > > +     { .compatible =3D "mediatek,mt8188-apmixedsys", },
> > > > > +     { }
> > > > > +};
> > > > > +
> > > > > +static const struct udevice_id mt8188_topckgen_compat[] =3D {
> > > > > +     { .compatible =3D "mediatek,mt8188-topckgen", },
> > > > > +     { }
> > > > > +};
> > > > > +
> > > > > +static const struct udevice_id mt8188_topckgen_cg_compat[] =3D {
> > > > > +     { .compatible =3D "mediatek,mt8188-topckgen-cg", },
> > > > > +     { }
> > > > > +};
> > > > > +
> > > > > +static const struct udevice_id mt8188_infracfg_ao_compat[] =3D {
> > > > > +     { .compatible =3D "mediatek,mt8188-infracfg-ao", },
> > > > > +     { }
> > > > > +};
> > > > > +
> > > > > +static const struct udevice_id mt8188_pericfg_ao_compat[] =3D {
> > > > > +     { .compatible =3D "mediatek,mt8188-pericfg-ao", },
> > > > > +     { }
> > > > > +};
> > > > > +
> > > > > +static const struct udevice_id mt8188_imp_iic_wrap_c_compat[] =
=3D {
> > > > > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-c", },
> > > > > +     { }
> > > > > +};
> > > > > +
> > > > > +static const struct udevice_id mt8188_imp_iic_wrap_w_compat[] =
=3D {
> > > > > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-w", },
> > > > > +     { }
> > > > > +};
> > > > > +
> > > > > +static const struct udevice_id mt8188_imp_iic_wrap_en_compat[] =
=3D {
> > > > > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-en", },
> > > > > +     { }
> > > > > +};
> > > >
> > > > Why don't you use udevice_id data field to describe each of the
> > > > mediatek,mt8188 version? This would avoid having this number of pro=
be
> > > > function, udevice_id structs and U_BOOT_DRIVER definitions.
> > > >
> > >
> > > Hi Kory,
> > >
> > > I am not the original author, but I guess it's done that way to be as
> > > close as possible to the Kernel.
> >
> > Linux is using one file per clock driver so your argument does not work=
.
> > And even within a file if there are several sub possibility it uses dat=
a field:
> > https://elixir.bootlin.com/linux/v6.18/source/drivers/clk/mediatek/clk-=
mt8188-imp_iic_wrap.c#L64
> >
> > > Moreover all drivers in drivers/clk/mediatek/ are designed that way,
> > > so we keep consistency between Mediatek clock driverss
> >
> > Indeed this type of design seems quite common in U-boot. I don't really=
 like
> > this as it adds more code for nothing. Anyway ok then.
>
> We can always rework things to be better :)
>

Hi Tom,

Sure!
I already sent a V2, but I can send a V3 reworked if you prefer.
Or do you prefer me to send a series later fixing all mediatek clock
drivers at once?
Let me know.

Cheers
Julien
> --
> Tom
