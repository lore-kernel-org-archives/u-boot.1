Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFEED3E77B
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 21:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 729F183A91;
	Wed, 10 Dec 2025 22:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BFAloRw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BED583CAA; Wed, 10 Dec 2025 22:22:26 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7215E83A26
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 22:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-65968986a0cso157538eaf.3
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 13:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765401742; x=1766006542; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=peeGyYfu1h4lyfqTwsCAANzum8Fk18jeEgeDqCLlUSM=;
 b=BFAloRw18/GSD7nFcAVsuGq26ktnh1+uqjxUE+19NWJO0Vp1YdkbwtQMxT+PkGJDY1
 mzYfk0VC22eHby+ES3zR3n5iMpvuAXwfric8u+Fyr9Q1h4tx1Mbk7cacpng9GWAFW5GF
 zJ2DYmP/0uostCg196JCGQKQePPVapYY5NPqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765401742; x=1766006542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=peeGyYfu1h4lyfqTwsCAANzum8Fk18jeEgeDqCLlUSM=;
 b=kT9uJR4vKKnMY6jHXn5EPd4fWjFvgmmLpdEpCRh5oKFnV7hqaH3T8VkIsEl2G7/mI/
 q4NQW5gy2T0lIH58J5L/t1LKAGPCp5rIimf+JmdD05MNp/dkv3mNAq+53j/Js3MGkBKh
 bjTkbi+mopJduC6uyjDS6cR3Vu3GZrs4gggKTZlBxTYplQRA3YXHmwqOd/0Aoe/TgcZq
 05WUuU/qs4mM3Da56DfNOA2XsPGoo3FOJASPVKNEZV4yQZcy7g40+e84BxrVQvgek7Jc
 BOKTrBkqYYRWXyfUfQnes8LgAoW6QgJKcVMxo5kLQn9x66j76KGYoe4Bg2ULFVQBvA7Q
 NjpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLful/k+2Pglq+Pz9APWtYMbzAR6CXJpuQb5XhK15PGCztZQa6F9j3Fg50FSJytZXAuKLw25w=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf9dsZPHIhE5uQoEmi+8wnfRHuzx6rpiAa5drvU3M894BjeymK
 nI6BZv4vd8/UbtTQ8OPgcTvUEqI2v2RJvjicGb1H01jyzXTQXNVzAi4h62l8v4fm1MY=
X-Gm-Gg: ASbGncsOL2Mo0lmr/Roe4EwcnhQQPRLDqOabMUaqDY7WzV9TCFyQF0UrtHnpQAJOv5N
 QeGgzsQc2rYoiA2lXI4qJVbGE5LTu9y0JTdwnt2bEbNvIwfY9/DBGIMQk1PR5//qkWRcFfMtpZj
 /hOTFKin+czMJ3LCgBtu2ZMBuWZaPw8J4sR4wFa7jTqs60F8aqp5u6/+7l7T0xp/q5qxb8E0l9h
 MkS6UMH3alsfF8XVwWdXNzyw/iOAgdspRxCvyGb2e2Vg8qAtYRbToqhmsr6ag15jN6cON5/5YXe
 QGrhJNeXPLSDuda7BJKWABNFXBIc9MNL60+RoFRObQ6qpz1sAeVyFTHBTs1ApBP2+JmqfleEjJI
 8psdFI8zqicXldTunEOihXKiJcjgS+mI9ymvH/DFEL1UDAtkXsrEcijMptm0xRysBiQd+7MY6fC
 /0OTYErbYMefalcrNlZiIQSvTZUIxACMDHxGWQI0uo45eTw6vasg==
X-Google-Smtp-Source: AGHT+IGAlgjSCC5fnlCkZ32gXg6F/tFifL0R8x7RdiGsYyxD+V9t7W/kbM8AKiRAQG1ND567oYyrdA==
X-Received: by 2002:a4a:ee05:0:b0:657:717a:8c8 with SMTP id
 006d021491bc7-65b2abef8e5mr2223375eaf.3.1765401741882; 
 Wed, 10 Dec 2025 13:22:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d5149058sm509747fac.18.2025.12.10.13.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 13:22:21 -0800 (PST)
Date: Wed, 10 Dec 2025 15:22:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sumit Garg <sumit.garg@kernel.org>, Julien Masson <jmasson@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 2/2] clk: mediatek: add MT8188 clock driver
Message-ID: <20251210212218.GJ303283@bill-the-cat>
References: <20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com>
 <20251203-add-mt8188-support-v1-2-9a06ebb97734@baylibre.com>
 <20251205144711.543ba2a8@kmaincent-XPS-13-7390>
 <CAEHHSvbW4usYU0SBZDOqX0ktseDbPMSnTaywrNCx2bsGkSMG3g@mail.gmail.com>
 <20251209110320.57aa9a54@kmaincent-XPS-13-7390>
 <20251210175654.GA3377532@bill-the-cat>
 <CAEHHSvZD8wzJ=NK5OYJdbPe=aweJ9RQZhkU8bk_RcROAdQKcVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BGKGq//99/n/dOP+"
Content-Disposition: inline
In-Reply-To: <CAEHHSvZD8wzJ=NK5OYJdbPe=aweJ9RQZhkU8bk_RcROAdQKcVg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--BGKGq//99/n/dOP+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 10:20:34PM +0100, Julien Stephan wrote:
> Le mer. 10 d=E9c. 2025 =E0 18:56, Tom Rini <trini@konsulko.com> a =E9crit=
 :
> >
> > On Tue, Dec 09, 2025 at 11:03:20AM +0100, Kory Maincent wrote:
> > > On Tue, 9 Dec 2025 10:27:32 +0100
> > > Julien Stephan <jstephan@baylibre.com> wrote:
> > >
> > > > Le ven. 5 d=E9c. 2025 =E0 14:47, Kory Maincent <kory.maincent@bootl=
in.com> a
> > > > =E9crit :
> > > > >
> > > > > On Wed, 03 Dec 2025 10:31:53 +0100
> > > > > Julien Stephan <jstephan@baylibre.com> wrote:
> > > > >
> > > > > > From: Julien Masson <jmasson@baylibre.com>
> > > > > >
> > > > > > The following clocks have been added for MT8188 SoC:
> > > > > > apmixedsys, topckgen, infracfg, pericfg and imp_iic_wrap
> > > > > >
> > > > > > These clocks driver are based on the ones present in the kernel:
> > > > > > drivers/clk/mediatek/clk-mt8188-*
> > > > > >
> > > > > > Signed-off-by: Julien Masson <jmasson@baylibre.com>
> > > > > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > > > > ---
> > > > > >  drivers/clk/mediatek/Makefile     |    1 +
> > > > > >  drivers/clk/mediatek/clk-mt8188.c | 1840
> > > > > > +++++++++++++++++++++++++++++++++++++ 2 files changed, 1841 ins=
ertions(+)
> > > > > >
> > > > >
> > > > > ...
> > > > >
> > > > > > +
> > > > > > +static int mt8188_apmixedsys_probe(struct udevice *dev)
> > > > > > +{
> > > > > > +     return mtk_common_clk_init(dev, &mt8188_apmixedsys_clk_tr=
ee);
> > > > > > +}
> > > > > > +
> > > > > > +static int mt8188_topckgen_probe(struct udevice *dev)
> > > > > > +{
> > > > > > +     return mtk_common_clk_init(dev, &mt8188_topckgen_clk_tree=
);
> > > > > > +}
> > > > > > +
> > > > > > +static int mt8188_topckgen_cg_probe(struct udevice *dev)
> > > > > > +{
> > > > > > +     return mtk_common_clk_gate_init(dev, &mt8188_topckgen_cg_=
clk_tree,
> > > > > > topckgen_cg_clks); +}
> > > > > > +
> > > > > > +static int mt8188_infracfg_ao_probe(struct udevice *dev)
> > > > > > +{
> > > > > > +     return mtk_common_clk_gate_init(dev, &mt8188_infracfg_ao_=
clk_tree,
> > > > > > infracfg_ao_clks); +}
> > > > > > +
> > > > > > +static int mt8188_pericfg_ao_probe(struct udevice *dev)
> > > > > > +{
> > > > > > +     return mtk_common_clk_gate_init(dev, &mt8188_pericfg_ao_c=
lk_tree,
> > > > > > pericfg_ao_clks); +}
> > > > > > +
> > > > > > +static int mt8188_imp_iic_wrap_c_probe(struct udevice *dev)
> > > > > > +{
> > > > > > +     return mtk_common_clk_gate_init(dev,
> > > > > > &mt8188_imp_iic_wrap_c_clk_tree, imp_iic_wrap_c_clks); +}
> > > > > > +
> > > > > > +static int mt8188_imp_iic_wrap_w_probe(struct udevice *dev)
> > > > > > +{
> > > > > > +     return mtk_common_clk_gate_init(dev,
> > > > > > &mt8188_imp_iic_wrap_w_clk_tree, imp_iic_wrap_w_clks); +}
> > > > > > +
> > > > > > +static int mt8188_imp_iic_wrap_en_probe(struct udevice *dev)
> > > > > > +{
> > > > > > +     return mtk_common_clk_gate_init(dev,
> > > > > > &mt8188_imp_iic_wrap_en_clk_tree,
> > > > > > +                                     imp_iic_wrap_en_clks);
> > > > > > +}
> > > > > > +
> > > > > > +static const struct udevice_id mt8188_apmixed_compat[] =3D {
> > > > > > +     { .compatible =3D "mediatek,mt8188-apmixedsys", },
> > > > > > +     { }
> > > > > > +};
> > > > > > +
> > > > > > +static const struct udevice_id mt8188_topckgen_compat[] =3D {
> > > > > > +     { .compatible =3D "mediatek,mt8188-topckgen", },
> > > > > > +     { }
> > > > > > +};
> > > > > > +
> > > > > > +static const struct udevice_id mt8188_topckgen_cg_compat[] =3D=
 {
> > > > > > +     { .compatible =3D "mediatek,mt8188-topckgen-cg", },
> > > > > > +     { }
> > > > > > +};
> > > > > > +
> > > > > > +static const struct udevice_id mt8188_infracfg_ao_compat[] =3D=
 {
> > > > > > +     { .compatible =3D "mediatek,mt8188-infracfg-ao", },
> > > > > > +     { }
> > > > > > +};
> > > > > > +
> > > > > > +static const struct udevice_id mt8188_pericfg_ao_compat[] =3D {
> > > > > > +     { .compatible =3D "mediatek,mt8188-pericfg-ao", },
> > > > > > +     { }
> > > > > > +};
> > > > > > +
> > > > > > +static const struct udevice_id mt8188_imp_iic_wrap_c_compat[] =
=3D {
> > > > > > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-c", },
> > > > > > +     { }
> > > > > > +};
> > > > > > +
> > > > > > +static const struct udevice_id mt8188_imp_iic_wrap_w_compat[] =
=3D {
> > > > > > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-w", },
> > > > > > +     { }
> > > > > > +};
> > > > > > +
> > > > > > +static const struct udevice_id mt8188_imp_iic_wrap_en_compat[]=
 =3D {
> > > > > > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-en", },
> > > > > > +     { }
> > > > > > +};
> > > > >
> > > > > Why don't you use udevice_id data field to describe each of the
> > > > > mediatek,mt8188 version? This would avoid having this number of p=
robe
> > > > > function, udevice_id structs and U_BOOT_DRIVER definitions.
> > > > >
> > > >
> > > > Hi Kory,
> > > >
> > > > I am not the original author, but I guess it's done that way to be =
as
> > > > close as possible to the Kernel.
> > >
> > > Linux is using one file per clock driver so your argument does not wo=
rk.
> > > And even within a file if there are several sub possibility it uses d=
ata field:
> > > https://elixir.bootlin.com/linux/v6.18/source/drivers/clk/mediatek/cl=
k-mt8188-imp_iic_wrap.c#L64
> > >
> > > > Moreover all drivers in drivers/clk/mediatek/ are designed that way,
> > > > so we keep consistency between Mediatek clock driverss
> > >
> > > Indeed this type of design seems quite common in U-boot. I don't real=
ly like
> > > this as it adds more code for nothing. Anyway ok then.
> >
> > We can always rework things to be better :)
> >
>=20
> Hi Tom,
>=20
> Sure!
> I already sent a V2, but I can send a V3 reworked if you prefer.
> Or do you prefer me to send a series later fixing all mediatek clock
> drivers at once?
> Let me know.

I think reworking and cleaning up the mediatek clock drivers is good
follow-up work, and can be submitted on top of your current v2 (baring
other feedback).

--=20
Tom

--BGKGq//99/n/dOP+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTnkfwAKCRAr4qD1Cr/k
Cr9JAP9Ba3DzXX6IuWsHjj4oBHY9yoGhHWqqlISQPuo6xgivxAEA8MT9Lz/wjvPG
q8BscdAAUW4gVRfJ+9Pg63iOvRRHjQA=
=o1m1
-----END PGP SIGNATURE-----

--BGKGq//99/n/dOP+--
