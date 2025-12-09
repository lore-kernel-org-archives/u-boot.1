Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3BED1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 10:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D41B83AEE;
	Tue,  9 Dec 2025 11:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="aCI0X3L+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22F7B83B81; Tue,  9 Dec 2025 11:03:36 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B0778352B
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 11:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id C0B4CC180DB;
 Tue,  9 Dec 2025 10:03:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8C787606E2;
 Tue,  9 Dec 2025 10:03:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2177011930396; Tue,  9 Dec 2025 11:03:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1765274611; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=wfCiGMJhRY3SJQE6Sk8UtB+m+6sTPRHokd0L1REY5zQ=;
 b=aCI0X3L+agEmmnWhDvRYSS7HCf1N7WgRrzU6stKKSNV2PsHhX7cTg5hKMNJGEMdYtflzsg
 STsWDbf7IKb+st4dUymkiLsMWiJJsH8DeAEgIUcSOxUVAZwPszhYAY9hsTz8oLS0jS6vNo
 qT96H4IV1eH3krLJf7sgdDC+gTbW2sbEyhO+v6QIyikTFko3mgRTCyFm32ZTG+cbHEUBlR
 jT4Lo3RfYEav9XBkSt0AGQo3jWLSZdkElip3Qqgwl+h3bVt7ccnSpjAyghBs8A6jCmUYpB
 zCoYWrv6T3lB8TDRGa4lEsmrr8X7gqje8JvaFpgDOJbYhvErdpvom0RletDpfA==
Date: Tue, 9 Dec 2025 11:03:20 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, Stefan Roese
 <stefan.roese@mailbox.org>, Greg Malysa <malysagreg@gmail.com>, Vasileios
 Bimpikas <vasileios.bimpikas@analog.com>, Arturs Artamonovs
 <arturs.artamonovs@analog.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Peng Fan <peng.fan@nxp.com>, Simon Glass
 <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi
 <ziyao@disroot.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Alif
 Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, Sumit Garg
 <sumit.garg@kernel.org>, Julien Masson <jmasson@baylibre.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Sam Shih
 <sam.shih@mediatek.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 2/2] clk: mediatek: add MT8188 clock driver
Message-ID: <20251209110320.57aa9a54@kmaincent-XPS-13-7390>
In-Reply-To: <CAEHHSvbW4usYU0SBZDOqX0ktseDbPMSnTaywrNCx2bsGkSMG3g@mail.gmail.com>
References: <20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com>
 <20251203-add-mt8188-support-v1-2-9a06ebb97734@baylibre.com>
 <20251205144711.543ba2a8@kmaincent-XPS-13-7390>
 <CAEHHSvbW4usYU0SBZDOqX0ktseDbPMSnTaywrNCx2bsGkSMG3g@mail.gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Tue, 9 Dec 2025 10:27:32 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Le ven. 5 d=C3=A9c. 2025 =C3=A0 14:47, Kory Maincent <kory.maincent@bootl=
in.com> a
> =C3=A9crit :
> >
> > On Wed, 03 Dec 2025 10:31:53 +0100
> > Julien Stephan <jstephan@baylibre.com> wrote:
> > =20
> > > From: Julien Masson <jmasson@baylibre.com>
> > >
> > > The following clocks have been added for MT8188 SoC:
> > > apmixedsys, topckgen, infracfg, pericfg and imp_iic_wrap
> > >
> > > These clocks driver are based on the ones present in the kernel:
> > > drivers/clk/mediatek/clk-mt8188-*
> > >
> > > Signed-off-by: Julien Masson <jmasson@baylibre.com>
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > ---
> > >  drivers/clk/mediatek/Makefile     |    1 +
> > >  drivers/clk/mediatek/clk-mt8188.c | 1840
> > > +++++++++++++++++++++++++++++++++++++ 2 files changed, 1841 insertion=
s(+)
> > > =20
> >
> > ...
> > =20
> > > +
> > > +static int mt8188_apmixedsys_probe(struct udevice *dev)
> > > +{
> > > +     return mtk_common_clk_init(dev, &mt8188_apmixedsys_clk_tree);
> > > +}
> > > +
> > > +static int mt8188_topckgen_probe(struct udevice *dev)
> > > +{
> > > +     return mtk_common_clk_init(dev, &mt8188_topckgen_clk_tree);
> > > +}
> > > +
> > > +static int mt8188_topckgen_cg_probe(struct udevice *dev)
> > > +{
> > > +     return mtk_common_clk_gate_init(dev, &mt8188_topckgen_cg_clk_tr=
ee,
> > > topckgen_cg_clks); +}
> > > +
> > > +static int mt8188_infracfg_ao_probe(struct udevice *dev)
> > > +{
> > > +     return mtk_common_clk_gate_init(dev, &mt8188_infracfg_ao_clk_tr=
ee,
> > > infracfg_ao_clks); +}
> > > +
> > > +static int mt8188_pericfg_ao_probe(struct udevice *dev)
> > > +{
> > > +     return mtk_common_clk_gate_init(dev, &mt8188_pericfg_ao_clk_tre=
e,
> > > pericfg_ao_clks); +}
> > > +
> > > +static int mt8188_imp_iic_wrap_c_probe(struct udevice *dev)
> > > +{
> > > +     return mtk_common_clk_gate_init(dev,
> > > &mt8188_imp_iic_wrap_c_clk_tree, imp_iic_wrap_c_clks); +}
> > > +
> > > +static int mt8188_imp_iic_wrap_w_probe(struct udevice *dev)
> > > +{
> > > +     return mtk_common_clk_gate_init(dev,
> > > &mt8188_imp_iic_wrap_w_clk_tree, imp_iic_wrap_w_clks); +}
> > > +
> > > +static int mt8188_imp_iic_wrap_en_probe(struct udevice *dev)
> > > +{
> > > +     return mtk_common_clk_gate_init(dev,
> > > &mt8188_imp_iic_wrap_en_clk_tree,
> > > +                                     imp_iic_wrap_en_clks);
> > > +}
> > > +
> > > +static const struct udevice_id mt8188_apmixed_compat[] =3D {
> > > +     { .compatible =3D "mediatek,mt8188-apmixedsys", },
> > > +     { }
> > > +};
> > > +
> > > +static const struct udevice_id mt8188_topckgen_compat[] =3D {
> > > +     { .compatible =3D "mediatek,mt8188-topckgen", },
> > > +     { }
> > > +};
> > > +
> > > +static const struct udevice_id mt8188_topckgen_cg_compat[] =3D {
> > > +     { .compatible =3D "mediatek,mt8188-topckgen-cg", },
> > > +     { }
> > > +};
> > > +
> > > +static const struct udevice_id mt8188_infracfg_ao_compat[] =3D {
> > > +     { .compatible =3D "mediatek,mt8188-infracfg-ao", },
> > > +     { }
> > > +};
> > > +
> > > +static const struct udevice_id mt8188_pericfg_ao_compat[] =3D {
> > > +     { .compatible =3D "mediatek,mt8188-pericfg-ao", },
> > > +     { }
> > > +};
> > > +
> > > +static const struct udevice_id mt8188_imp_iic_wrap_c_compat[] =3D {
> > > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-c", },
> > > +     { }
> > > +};
> > > +
> > > +static const struct udevice_id mt8188_imp_iic_wrap_w_compat[] =3D {
> > > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-w", },
> > > +     { }
> > > +};
> > > +
> > > +static const struct udevice_id mt8188_imp_iic_wrap_en_compat[] =3D {
> > > +     { .compatible =3D "mediatek,mt8188-imp-iic-wrap-en", },
> > > +     { }
> > > +}; =20
> >
> > Why don't you use udevice_id data field to describe each of the
> > mediatek,mt8188 version? This would avoid having this number of probe
> > function, udevice_id structs and U_BOOT_DRIVER definitions.
> > =20
>=20
> Hi Kory,
>=20
> I am not the original author, but I guess it's done that way to be as
> close as possible to the Kernel.

Linux is using one file per clock driver so your argument does not work.
And even within a file if there are several sub possibility it uses data fi=
eld:
https://elixir.bootlin.com/linux/v6.18/source/drivers/clk/mediatek/clk-mt81=
88-imp_iic_wrap.c#L64

> Moreover all drivers in drivers/clk/mediatek/ are designed that way,
> so we keep consistency between Mediatek clock driverss

Indeed this type of design seems quite common in U-boot. I don't really like
this as it adds more code for nothing. Anyway ok then.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
