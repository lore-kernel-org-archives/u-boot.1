Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09F4C4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 19:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1BFE87772;
	Mon, 11 Dec 2023 20:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rAZqe1nG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B65E87777; Mon, 11 Dec 2023 20:17:32 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA908272A
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 20:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-db3fa47c2f7so5074499276.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 11:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702322248; x=1702927048; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5Gs09bGqY1MyRbVCH1HNvxYZHhYAXlzCNl+g5Ipef9o=;
 b=rAZqe1nGkFj0xSHaQpJdp3Z4HKuwNKeIWLbqfMaLudLDCT3VccvYSeilVmHclFCWya
 qL0n/Z/+TVIj0RSZgkJymFPXzZz+Qzr7a4dyKuFLBFTAxdBr4xoHADf6REh/MDAZc2jl
 IlnOWaxBiVZo/ASS6EOTPMiKNcwjHv2oOwRz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702322248; x=1702927048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Gs09bGqY1MyRbVCH1HNvxYZHhYAXlzCNl+g5Ipef9o=;
 b=AmxOiiuBnM5okpPXpMHgYfjl/IqaNPZ/QzFuRxVwmor9hmTTrIt8H7JA1Ka5grjBE2
 LUF4gSnkEVfHQsNrtngLJuiyPCdQMOHM8Cxc8Yd3ScwxLijrMeoaGe16wx/qZ2pcm8NY
 OvUK1nkRGWkF8sQVhbyH6vS1VkZXIxxx7O4/8pxvmEjSTGJzHuykokV3b9/rdc07uwUb
 xrb8D3TWQnqdSs+hmuknVpThm4XbeUSAy05ExhW8jK2dePf3chhVsIylPNxBY4LR95D/
 w9Yxy+Sz5A3BHrg4PVG10ZXs+ApbbmRc+hBjfvN2PsPJ7vR6wVcSOXT6Xkcm4xbp/5sA
 6eOw==
X-Gm-Message-State: AOJu0YwGoGkUxMYhrFmo+gQiRrB3OgkBBaTOk2TQ5g4u6kzlK1rs3bQH
 UsQqhfhErj7H82LcFGS//x9jkA==
X-Google-Smtp-Source: AGHT+IGCdr8ZoFntLO5fXGYdDmSVhSeU7DOmGzQYAh+HYz8aWd45cR6RRO3ayOyF5EGN2+zCSvlmwA==
X-Received: by 2002:a25:243:0:b0:dbc:51a4:ba19 with SMTP id
 64-20020a250243000000b00dbc51a4ba19mr3343543ybc.97.1702322248598; 
 Mon, 11 Dec 2023 11:17:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fa42-ae3b-3aac-d543.res6.spectrum.com.
 [2603:6081:7b00:6400:fa42:ae3b:3aac:d543])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a25e704000000b00d9a43500f1dsm204542ybh.28.2023.12.11.11.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 11:17:28 -0800 (PST)
Date: Mon, 11 Dec 2023 14:17:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] iommu: fix compilation when CONFIG_PCI disabled
Message-ID: <20231211191726.GV2513409@bill-the-cat>
References: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
 <20231211-b4-dwc3-qcom-v1-1-46275113b4f2@linaro.org>
 <e99c00cbe8b0cf7f8a4c9217d5298625@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qqwI8Kb4Ew5AZcGn"
Content-Disposition: inline
In-Reply-To: <e99c00cbe8b0cf7f8a4c9217d5298625@manjaro.org>
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


--qqwI8Kb4Ew5AZcGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 08:08:32PM +0100, Dragan Simic wrote:
> On 2023-12-11 19:41, Caleb Connolly wrote:
> > The dev_pci_iommu_enable() function is only available when CONFIG_PCI is
> > enabled, replace the runtime check with a preprocessor one to fix
> > compilation with pci disabled.
> >=20
> > Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> > ---
> >  drivers/iommu/iommu-uclass.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iommu/iommu-uclass.c b/drivers/iommu/iommu-uclass.c
> > index 72f123df55a5..98731d5e2c44 100644
> > --- a/drivers/iommu/iommu-uclass.c
> > +++ b/drivers/iommu/iommu-uclass.c
> > @@ -100,9 +100,10 @@ int dev_iommu_enable(struct udevice *dev)
> >  		dev->iommu =3D dev_iommu;
> >  	}
> >=20
> > -	if (CONFIG_IS_ENABLED(PCI) && count < 0 &&
> > -	    device_is_on_pci_bus(dev))
> > +#if CONFIG_IS_ENABLED(PCI)
> > +	if (count < 0 && device_is_on_pci_bus(dev))
> >  		return dev_pci_iommu_enable(dev);
> > +#endif
> >=20
> >  	return 0;
> >  }
>=20
> Perhaps there's no need to introduce an ifdef here.

Yes, how exactly are you getting a build failure? dev_pci_iommu_enable
should be available and return false with CONFIG_PCI=3Dn.

--=20
Tom

--qqwI8Kb4Ew5AZcGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV3YEYACgkQFHw5/5Y0
tyxOhgwArocrH4V4QZ3Qmr7LnTrIpg0XrJU69u1mttWXGKBojXusfzKnM5RU3WyF
JSTf41ozo7Fi9OeIRC+wbykuPE7JN4Wgisrvk76dnn/xTdEJ5hUyJ+FqafILqv3Q
Jd8SWrEMGcpTTtY6hq9m1CalVI4F5fFeYHA12k/mFrO2JCoHDgWAA6Z/9RnpLfMq
dfNZ9qYUNISFh12QQg5MmoUG6vZHuCJ2ezoBlq+ePmgSrr1N5sD4H+6up2miqZH/
VbcsYAqI9epu/n556BVZFAmIsLBaembjIW313lUXZ7uu6pBjFkUaf82cYS0kzFOx
x5Zl7yfRgew0FYIuZdK5VuZ8yZplSckxlMspRfXccj+rMa6+X8GbmHKWZBNf/D+R
SGNBk/v1k1ApbXUNJ26F36MCKecoYuwFiyde4SQBIIEDTmijH8YoIbn8m4oFcn2P
BNZTh+ZzwX6m26VkKD6ji2kDWROgyccdJm/ntfh76xfx8B2mtGgxr9C21ViCin1z
cb06/KzY
=nq0C
-----END PGP SIGNATURE-----

--qqwI8Kb4Ew5AZcGn--
