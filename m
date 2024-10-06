Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DC6CFB43F
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 22:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 459CC889FC;
	Mon,  7 Oct 2024 00:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fX8BcMr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D730E88AB9; Mon,  7 Oct 2024 00:50:41 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D1388AB2
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 00:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4583083d05eso33739001cf.3
 for <u-boot@lists.denx.de>; Sun, 06 Oct 2024 15:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728255037; x=1728859837; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rT7f6DRP6SV9AcgShbPz5A6j09hNufiPiR1ftZXCwKQ=;
 b=fX8BcMr7AiIKiychXsP4SwNCWF3Lr0jfW/TrxgIV7wh1/Q3XnwLjbo6JUqjkQ969wW
 hMYZQuCNy+FK8+RAvbs+N71NpL8wPxencszvNx9UScOEaBVCuYI/pBMR7TUiL1yYsPN5
 LH9XI5H01qg7tpnQa2kgTjbk2c+qPvU+7RGtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728255037; x=1728859837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rT7f6DRP6SV9AcgShbPz5A6j09hNufiPiR1ftZXCwKQ=;
 b=J3g/GUEPZ3V+Nbgr71uzUvn7v6+ZKy7K6uywbLpodXTvE49Tm+kMt+QQOQKRjkZpWC
 77DRaoR1U2XRGbJFPo/twlIlb3LMrog7EVw56uXV7IstBFXZWqzMVfPXZObMsGEGtP0P
 u1B6ME/MP+kGTZIhZy02gxnZMkO4iOH6ga52aEskcJowe2nwhQDN3a7CqmZXRvKBnHSb
 QkC+XgssPOyxghMQgU4lAzAVxT/VvR3aV9//e6d1ulpoBcM6m9McQp5gRyhuwxESVyRt
 TXbFwK+qRxVBIhHtlg3vVjWc6XN75inaal9in2wao6CTgN2gzPEGDskKI0j8T9Ju84g2
 9dtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXqecpy0sPM/zGslgk0dl0GGpxk1LAo1l1roWHztknkExrd6EPFTGy717YMlz6taMycSCeiDA=@lists.denx.de
X-Gm-Message-State: AOJu0YyJYqJiRvXr2mFMBkItrr+xlSgb11MdIqMJkYJmjIEJq82ShY3i
 7PxvxaSWzSIKVmGnVjr0TzX8D8tlm6mua6j1xxwM1kri+LtctIN1Zex6BdU0U74=
X-Google-Smtp-Source: AGHT+IEJxL7AuDAxjghUOlBjkAHp0mks3DvAxIZ0tcQlwtiXAkVX9S3zcABEDlA8CPAAYsSt2I48CA==
X-Received: by 2002:ac8:5a4c:0:b0:45d:93dc:bda7 with SMTP id
 d75a77b69052e-45d9bb2545amr182513471cf.54.1728255037503; 
 Sun, 06 Oct 2024 15:50:37 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45da74ea488sm20495171cf.26.2024.10.06.15.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Oct 2024 15:50:36 -0700 (PDT)
Date: Sun, 6 Oct 2024 16:50:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: alice.guo@oss.nxp.com, u-boot@lists.denx.de, sbabic@denx.de,
 festevam@gmail.com, uboot-imx@nxp.com, peng.fan@nxp.com,
 fedor.ross@ifm.com, ye.li@nxp.com, seanga2@gmail.com,
 Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
Message-ID: <20241006225032.GS4737@bill-the-cat>
References: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
 <20241006212332.GQ4737@bill-the-cat>
 <f2f2ff63-e186-4065-8e75-7e0064d16037@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XeoQUJs9NimcDeEj"
Content-Disposition: inline
In-Reply-To: <f2f2ff63-e186-4065-8e75-7e0064d16037@denx.de>
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


--XeoQUJs9NimcDeEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 12:28:44AM +0200, Marek Vasut wrote:
> On 10/6/24 11:23 PM, Tom Rini wrote:
> > On Sun, Oct 06, 2024 at 07:31:16AM +0800, alice.guo@oss.nxp.com wrote:
> >=20
> > > From: Peng Fan <peng.fan@nxp.com>
> > >=20
> > > Make CONFIG_IMX8_ROMAPI could be configured in defconfig.
> > >=20
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > Reviewed-by: Ye Li <ye.li@nxp.com>
> > > ---
> > >   arch/arm/mach-imx/Kconfig | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > index 134e42028c..9d3aafd2f8 100644
> > > --- a/arch/arm/mach-imx/Kconfig
> > > +++ b/arch/arm/mach-imx/Kconfig
> > > @@ -179,7 +179,8 @@ config DDRMC_VF610_CALIBRATION
> > >   	  the ddrmc_cr_setting on relevant board file.
> > >   config IMX8_ROMAPI
> > > -	def_bool y
> > > +	bool "Enable i.MX ROMAPI"
> > > +	default y
> > >   	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
> >=20
> > Since there's no help here, is this truly configurable, or is this
> > something that should be select'd based on the SoC and presumably some
> > of the newer IMX9 parts cannot use this?
> I can imagine the MX95 calls into this custom ELE firmware stuff instead =
of
> ROMAPI ?

Alright. Perhaps this should be depending on the above and
!main-ELE-symbol instead.

--=20
Tom

--XeoQUJs9NimcDeEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcDFDQACgkQFHw5/5Y0
tyypRgv+LUI7PXa8IV5BIXdGvIYl1JlrnV1nN3eGPtCJlS1iAsOnhpaIXX6pPmJO
TdElHBHyOcuAJv4LkVvZ8q5l9BAsNfkn5XbCEHwkp9RW+6xo3Vs/PBbDL9ULL52m
i/NBSpuKZ3b6qhI4SOp2w8Vogd566JvqPxaMrD2aspoZb+4IF4u3/M90nuJb0Ol8
tHKDD7dCbNkAA2dpJBwCt4XkZnuESzQgCkmoIovh3Hp4nN8BT2E+ka8tbBVamF3o
qUa04FpDxvYYbMpAHgwsvcMp4cyoBGn6hW0BfulV+rBoZMF/sHsSmxPWpKHy4PPn
h8iC/eZWpW4mYQc5ebIkq4hGpKYCKoPgSQ4PVKJtqQtA0BZRMDSr+uiixrDwgfpq
54tm9euah4VHSgVFkHC4QQI2GlNpi5V0AmKiVQCEwbwyE6CFFVGsIQdnzAknLxqX
NKfgjvtE1Hivl+jDBDNVI2WKyMzybtG3WDYFEG53l2Oor8/Pr33AQE6NPAoEgefP
BKINIIML
=Xu+f
-----END PGP SIGNATURE-----

--XeoQUJs9NimcDeEj--
