Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0FDC4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 19:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 079FD877A1;
	Mon, 11 Dec 2023 20:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nmn5GiS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27214877AA; Mon, 11 Dec 2023 20:55:40 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA153876F4
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 20:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e180547bdeso5210157b3.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 11:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702324536; x=1702929336; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SPGC/f4cTnZJtKQ2BnJhqqIgqjIlnOAA6OdQG1rgIco=;
 b=nmn5GiS3bNnPz9GcMoAqCrNEWtB/RybAN4SOXfHvQq9GBEBahX8cLPDhgB4u/TAPAx
 uqFcw3LhdZbY7dB1NbE1+SewfPBMOTiMxIfVDcBKL2uDI5KAYqBYsRkH3NG+YInfcgAI
 9RVtJWdRVr8STi7/LRiuPYXntWs7AThcma4kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702324536; x=1702929336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPGC/f4cTnZJtKQ2BnJhqqIgqjIlnOAA6OdQG1rgIco=;
 b=UueF89vdF9kA4T+S4VauFJNMiT1bZ+fAlmbjjZ/B2xNkwTEXAsNt53iH7BmrdyMqh9
 FCsUj81Mond7Q+/DRmZTv+yEdv3vzVP4UmE0lCLcqCEb+DDK0rhSO7dbMh2oo0ACBwJn
 /Ck79eEqugD7QIMrTW2XktFx7OeUi58WEObqil6YuoGRPCKSAe17HJJ0LcUji2lGHQg5
 GMK4xxj1H0n+ZKzbcAZI7QgEMEMI7GKKHelwIc8HoHxECCMLEAE/iop5tczAOaC2kY76
 ursqIhqZyrLGD7uTdmWGEPvU7JuVLFxtFQYMaPxXHjtdC0lzojKNopdOi26f/Jw1emST
 v5SQ==
X-Gm-Message-State: AOJu0Yz4MoLJQ78/t9ZS5p9LmwX4FhqwYyF8bXoFONTBzN6OWg3k+K0o
 mZwJMuMuLiJCAesBjgZEu04iWA==
X-Google-Smtp-Source: AGHT+IFR+huD3K0weUZs5R9ZrMG4FGvvnVVdXWXlr1/WBvZ/p6sj+wdPGwXxNuR8j8ZQ6noWGY4b+w==
X-Received: by 2002:a25:395:0:b0:da0:aac9:aa11 with SMTP id
 143-20020a250395000000b00da0aac9aa11mr3960723ybd.12.1702324536405; 
 Mon, 11 Dec 2023 11:55:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fa42-ae3b-3aac-d543.res6.spectrum.com.
 [2603:6081:7b00:6400:fa42:ae3b:3aac:d543])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a5b0a46000000b00d9cc606c78csm2685560ybq.41.2023.12.11.11.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 11:55:35 -0800 (PST)
Date: Mon, 11 Dec 2023 14:55:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: Dragan Simic <dsimic@manjaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] iommu: fix compilation when CONFIG_PCI disabled
Message-ID: <20231211195533.GW2513409@bill-the-cat>
References: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
 <20231211-b4-dwc3-qcom-v1-1-46275113b4f2@linaro.org>
 <e99c00cbe8b0cf7f8a4c9217d5298625@manjaro.org>
 <20231211191726.GV2513409@bill-the-cat>
 <8eeafbf4-04c9-465a-ac79-4356664033f5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o2HLKCjV3e0cu+UW"
Content-Disposition: inline
In-Reply-To: <8eeafbf4-04c9-465a-ac79-4356664033f5@linaro.org>
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


--o2HLKCjV3e0cu+UW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 07:47:04PM +0000, Caleb Connolly wrote:
>=20
>=20
> On 11/12/2023 19:17, Tom Rini wrote:
> > On Mon, Dec 11, 2023 at 08:08:32PM +0100, Dragan Simic wrote:
> >> On 2023-12-11 19:41, Caleb Connolly wrote:
> >>> The dev_pci_iommu_enable() function is only available when CONFIG_PCI=
 is
> >>> enabled, replace the runtime check with a preprocessor one to fix
> >>> compilation with pci disabled.
> >>>
> >>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >>> ---
> >>>  drivers/iommu/iommu-uclass.c | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/iommu-uclass.c b/drivers/iommu/iommu-uclas=
s.c
> >>> index 72f123df55a5..98731d5e2c44 100644
> >>> --- a/drivers/iommu/iommu-uclass.c
> >>> +++ b/drivers/iommu/iommu-uclass.c
> >>> @@ -100,9 +100,10 @@ int dev_iommu_enable(struct udevice *dev)
> >>>  		dev->iommu =3D dev_iommu;
> >>>  	}
> >>>
> >>> -	if (CONFIG_IS_ENABLED(PCI) && count < 0 &&
> >>> -	    device_is_on_pci_bus(dev))
> >>> +#if CONFIG_IS_ENABLED(PCI)
> >>> +	if (count < 0 && device_is_on_pci_bus(dev))
> >>>  		return dev_pci_iommu_enable(dev);
> >>> +#endif
> >>>
> >>>  	return 0;
> >>>  }
> >>
> >> Perhaps there's no need to introduce an ifdef here.
> >=20
> > Yes, how exactly are you getting a build failure? dev_pci_iommu_enable
> > should be available and return false with CONFIG_PCI=3Dn.
>=20
> Hi,
>=20
> Without this patch I get
>=20
> ../drivers/iommu/iommu-uclass.c: In function 'dev_iommu_enable':
> ../drivers/iommu/iommu-uclass.c:116:24: warning: implicit declaration of
> function 'dev_pci_iommu_enable'; did you mean 'dev_iommu_enable'?
> [-Wimplicit-function-declaration]
>   116 |                 return dev_pci_iommu_enable(dev);
>       |                        ^~~~~~~~~~~~~~~~~~~~
>       |                        dev_iommu_enable
>=20
> Grepping shows there is only one definition, which is the static
> function definition in iommu-uclass which is #ifdef'd out when
> CONFIG_PCI is disabled.
>=20
> ; rg "dev_pci_iommu_enable"
> drivers/iommu/iommu-uclass.c
> 18:static int dev_pci_iommu_enable(struct udevice *dev)
> 116:            return dev_pci_iommu_enable(dev);
> >=20
>=20
> Am I missing a patch or something? The function is only defined in one
> place in the whole of U-Boot.

Oh sorry, you're right, I checked the wrong function. I guess I'll defer
to Simon on if he prefers to just use #ifdef here or __maybe_unused
dev_pci_iommu_enable instead.

--=20
Tom

--o2HLKCjV3e0cu+UW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV3aTIACgkQFHw5/5Y0
tyzEngv/cPsTKL/aFWjGc0Or2sOdgcAqI20l62IbRQ7iPm8FBzjI9KT91BMODnVL
J11H4EHJ12keAqzZ7ytEyDX/AhHDHM8U5940aOzAhBV0xgEN+tCfPytuIrr08jh1
0ITQfcZ9pfdObt4MhCcv4WZ38R423ztQA+j0xvN80gpxr5aDBHpRekIltkAqeYnX
vlL5a4tUdPqDRGRAFsl5y5txiuxSS3QWl7jj3YeC54DeITvOvUXguG1CzVuaB/ZG
SkBO9+WhbG2gyG7FvbQvTnRMAU4GMGqpu7alKkTDSMrVI7atEOU0feQR1b/ep4UU
FBE3EiS3rwXW+1aBys2q3nCXEmF8NzsjEAGSoHc7pLVlEcNEnalRkO7de2xmW2nj
SpK8zHECcW/UF9+qnsCKJfl6b3oXR/3SceTLrWpghnA1B9zqih0zwnpj5+AFG26Z
+Spq8W9MARM1jF5yrxlzCFVsUBjoJTppS58bq+Ik3k8fBfhEwoEyfNGaZMBvjBAO
WLMFGlfB
=EE5K
-----END PGP SIGNATURE-----

--o2HLKCjV3e0cu+UW--
