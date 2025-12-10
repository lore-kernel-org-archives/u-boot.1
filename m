Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A456AD3E765
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 17:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B920383B48;
	Wed, 10 Dec 2025 18:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aKcBCFIb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EF3E83C08; Wed, 10 Dec 2025 18:57:03 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A068367F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 18:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c76d855ddbso57985a34.3
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 09:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765389418; x=1765994218; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fJU66UsfzzvP8Dzkc/3UvZ82UK36nmFmDC5xHjmFtV8=;
 b=aKcBCFIbM9wlzQ62tFbzDVpDhNqDL8WC7cRAcrrrbXLFCHF93xwq+X8nK4OmD3Zah4
 OTxIcwHd6Uyrgg4ryV7MBw/cDGrxrS1LdXlz+ii0I8bEUMBpsHovibBervOukfi3CHz4
 8VJKMhPeg/Nvf9m88BMmLhaZdLNchSSzZe95g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765389418; x=1765994218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJU66UsfzzvP8Dzkc/3UvZ82UK36nmFmDC5xHjmFtV8=;
 b=KK3czICA4Qblox6xKT/ew+VDXMsTDJrjGK+JbxJrJSRCZ30XTi+ru+NMMUodendRXu
 64CD1Zp5y6MJ7eTVbzAINsES7yeYbpssAqPDErk3Ywnopn78zY4dzHNORlHvn6HQYheM
 ig4VzQSrtHHl7l+1uC57khHG4gIPEeRBVVlkJQ3d8ZxZzfJHGOgBPzMbr0rQsjMy065c
 9egFPsr5KsseulSe9umsbKDgN2jBpWO/geTVFmDxYL1lZfje0RzehIM6EFYbrD1XNw7U
 mtaTHzjQuq8CVrQxQ3qqUf6piJk2nsB4JL67oVxVhFTYKLc3U3JUbjg3iENwLeb/HrWH
 0zwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvDpujUOJT3ZKEoh/dfECDYM9qXyyc1cg43f+0Eu1LdlR2M5QEXFO016dwfe4oDL2KFz88gSU=@lists.denx.de
X-Gm-Message-State: AOJu0YziY5oNXEw/dSGHN2kg6bS6dsXHg2ExCl+QwGLztbf/T/nqCcAR
 zmSjkbhcwXMvKk3Xk8ewBbmXXnycNfAFMFafbwYePTMH3q38VdR2NqPR2FqEtytj/HU=
X-Gm-Gg: ASbGncuaR9U7TYLl3jS/QKLtdibpzHEGJYTBeiLRYcYBdvVIPnr6EQAvcJPUb/3g00S
 VlqUETs+76ggYo/nnX0QQhuWZ4W0RNmJSE72R6bSGu+A6Mh0EjZOAvrojClndcVQdki5y2pjA2U
 TaHmVsrjsfjV3C787GMxE5mVuK1o00LLpeRQty76aQic1kYFwB23Snw4Oy8NceG/erhLuvuxndL
 n7c1g2WQYKxegZUzg5n6TZN4mNkPW0TEzHxhHdfpueec/HD1213jZVpjPqbJ3D6WpxH6sZlcGHc
 MLUEoewYslaQeTbSXQBZHgqkLnxTwWJnyRH6KXVgg80o+woK80gOg0AGjNnwjXIOQfTa1b2EIoY
 TDffxXcnJxc4cbD9aX4ZIr9sHe7ARFFDsXm8s2AqJVNNHwR3O0vKSD3TgGOa6GMlmMA24Em/555
 Yf+oiQwt0XWaWNp5hTTigqnytw9Qod7uK91vkV4oyNP2e3uhDj9A==
X-Google-Smtp-Source: AGHT+IEWCWgq7tYzBEiDbIlC1k4tIfO3daOKpG5u/FbmrI3I7GDyUarkzq2mxZ6kE4Ocl4zzVr2Xcw==
X-Received: by 2002:a05:6830:448b:b0:799:c0c8:e9d1 with SMTP id
 46e09a7af769-7cacebf3decmr2346932a34.24.1765389417906; 
 Wed, 10 Dec 2025 09:56:57 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cad91227b1sm139538a34.6.2025.12.10.09.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 09:56:57 -0800 (PST)
Date: Wed, 10 Dec 2025 11:56:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Julien Stephan <jstephan@baylibre.com>,
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
Message-ID: <20251210175654.GA3377532@bill-the-cat>
References: <20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com>
 <20251203-add-mt8188-support-v1-2-9a06ebb97734@baylibre.com>
 <20251205144711.543ba2a8@kmaincent-XPS-13-7390>
 <CAEHHSvbW4usYU0SBZDOqX0ktseDbPMSnTaywrNCx2bsGkSMG3g@mail.gmail.com>
 <20251209110320.57aa9a54@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ixqJJ/1K/B4p9kkx"
Content-Disposition: inline
In-Reply-To: <20251209110320.57aa9a54@kmaincent-XPS-13-7390>
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


--ixqJJ/1K/B4p9kkx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2025 at 11:03:20AM +0100, Kory Maincent wrote:
> On Tue, 9 Dec 2025 10:27:32 +0100
> Julien Stephan <jstephan@baylibre.com> wrote:
>=20
> > Le ven. 5 d=E9c. 2025 =E0 14:47, Kory Maincent <kory.maincent@bootlin.c=
om> a
> > =E9crit :
> > >
> > > On Wed, 03 Dec 2025 10:31:53 +0100
> > > Julien Stephan <jstephan@baylibre.com> wrote:
> > > =20
> > > > From: Julien Masson <jmasson@baylibre.com>
> > > >
> > > > The following clocks have been added for MT8188 SoC:
> > > > apmixedsys, topckgen, infracfg, pericfg and imp_iic_wrap
> > > >
> > > > These clocks driver are based on the ones present in the kernel:
> > > > drivers/clk/mediatek/clk-mt8188-*
> > > >
> > > > Signed-off-by: Julien Masson <jmasson@baylibre.com>
> > > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > > ---
> > > >  drivers/clk/mediatek/Makefile     |    1 +
> > > >  drivers/clk/mediatek/clk-mt8188.c | 1840
> > > > +++++++++++++++++++++++++++++++++++++ 2 files changed, 1841 inserti=
ons(+)
> > > > =20
> > >
> > > ...
> > > =20
> > > > +
> > > > +static int mt8188_apmixedsys_probe(struct udevice *dev)
> > > > +{
> > > > +     return mtk_common_clk_init(dev, &mt8188_apmixedsys_clk_tree);
> > > > +}
> > > > +
> > > > +static int mt8188_topckgen_probe(struct udevice *dev)
> > > > +{
> > > > +     return mtk_common_clk_init(dev, &mt8188_topckgen_clk_tree);
> > > > +}
> > > > +
> > > > +static int mt8188_topckgen_cg_probe(struct udevice *dev)
> > > > +{
> > > > +     return mtk_common_clk_gate_init(dev, &mt8188_topckgen_cg_clk_=
tree,
> > > > topckgen_cg_clks); +}
> > > > +
> > > > +static int mt8188_infracfg_ao_probe(struct udevice *dev)
> > > > +{
> > > > +     return mtk_common_clk_gate_init(dev, &mt8188_infracfg_ao_clk_=
tree,
> > > > infracfg_ao_clks); +}
> > > > +
> > > > +static int mt8188_pericfg_ao_probe(struct udevice *dev)
> > > > +{
> > > > +     return mtk_common_clk_gate_init(dev, &mt8188_pericfg_ao_clk_t=
ree,
> > > > pericfg_ao_clks); +}
> > > > +
> > > > +static int mt8188_imp_iic_wrap_c_probe(struct udevice *dev)
> > > > +{
> > > > +     return mtk_common_clk_gate_init(dev,
> > > > &mt8188_imp_iic_wrap_c_clk_tree, imp_iic_wrap_c_clks); +}
> > > > +
> > > > +static int mt8188_imp_iic_wrap_w_probe(struct udevice *dev)
> > > > +{
> > > > +     return mtk_common_clk_gate_init(dev,
> > > > &mt8188_imp_iic_wrap_w_clk_tree, imp_iic_wrap_w_clks); +}
> > > > +
> > > > +static int mt8188_imp_iic_wrap_en_probe(struct udevice *dev)
> > > > +{
> > > > +     return mtk_common_clk_gate_init(dev,
> > > > &mt8188_imp_iic_wrap_en_clk_tree,
> > > > +                                     imp_iic_wrap_en_clks);
> > > > +}
> > > > +
> > > > +static const struct udevice_id mt8188_apmixed_compat[] =3D {
> > > > +     { .compatible =3D "mediatek,mt8188-apmixedsys", },
> > > > +     { }
> > > > +};
> > > > +
> > > > +static const struct udevice_id mt8188_topckgen_compat[] =3D {
> > > > +     { .compatible =3D "mediatek,mt8188-topckgen", },
> > > > +     { }
> > > > +};
> > > > +
> > > > +static const struct udevice_id mt8188_topckgen_cg_compat[] =3D {
> > > > +     { .compatible =3D "mediatek,mt8188-topckgen-cg", },
> > > > +     { }
> > > > +};
> > > > +
> > > > +static const struct udevice_id mt8188_infracfg_ao_compat[] =3D {
> > > > +     { .compatible =3D "mediatek,mt8188-infracfg-ao", },
> > > > +     { }
> > > > +};
> > > > +
> > > > +static const struct udevice_id mt8188_pericfg_ao_compat[] =3D {
> > > > +     { .compatible =3D "mediatek,mt8188-pericfg-ao", },
> > > > +     { }
> > > > +};
> > > > +
> > > > +static const struct udevice_id mt8188_imp_iic_wrap_c_compat[] =3D {
> > > > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-c", },
> > > > +     { }
> > > > +};
> > > > +
> > > > +static const struct udevice_id mt8188_imp_iic_wrap_w_compat[] =3D {
> > > > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-w", },
> > > > +     { }
> > > > +};
> > > > +
> > > > +static const struct udevice_id mt8188_imp_iic_wrap_en_compat[] =3D=
 {
> > > > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-en", },
> > > > +     { }
> > > > +}; =20
> > >
> > > Why don't you use udevice_id data field to describe each of the
> > > mediatek,mt8188 version? This would avoid having this number of probe
> > > function, udevice_id structs and U_BOOT_DRIVER definitions.
> > > =20
> >=20
> > Hi Kory,
> >=20
> > I am not the original author, but I guess it's done that way to be as
> > close as possible to the Kernel.
>=20
> Linux is using one file per clock driver so your argument does not work.
> And even within a file if there are several sub possibility it uses data =
field:
> https://elixir.bootlin.com/linux/v6.18/source/drivers/clk/mediatek/clk-mt=
8188-imp_iic_wrap.c#L64
>=20
> > Moreover all drivers in drivers/clk/mediatek/ are designed that way,
> > so we keep consistency between Mediatek clock driverss
>=20
> Indeed this type of design seems quite common in U-boot. I don't really l=
ike
> this as it adds more code for nothing. Anyway ok then.

We can always rework things to be better :)

--=20
Tom

--ixqJJ/1K/B4p9kkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTm0XgAKCRAr4qD1Cr/k
CpTEAQC4iydlUuYHoBgkxbGVmxWa12F3kyKb/M6vVa3pR0Vy4AD9G7WXH4jpIeUP
LRNutUvyxm29JG73U/v7DpejMnY8Ygo=
=AoTC
-----END PGP SIGNATURE-----

--ixqJJ/1K/B4p9kkx--
