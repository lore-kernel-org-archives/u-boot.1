Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B121DD2F7E1
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 03:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BFFE88DE1;
	Thu, 17 Oct 2024 05:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dshw+6My";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C821E88D40; Thu, 17 Oct 2024 05:05:13 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD4C888DF1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 05:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-460414d5250so3773801cf.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729134308; x=1729739108; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ln5lH4hu6rZRGONk962qcYbccXZTLKV2OK+JHsp4H2c=;
 b=dshw+6MyYF/wqAfS5aL9f3izRlhpflHK+aLlSryReMQEFFJaaDOCKoKVK4b9oxya7D
 7vkD3nq63rV9GFDrKM9MsWa+Fio3LDFlJBrmCO0j0KhCcrm8ZQ4zJlYCq7546XXkinkf
 7AfOAtB7D0wLkghU7r0dEmYqSb7MZ2/BSIyj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729134308; x=1729739108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ln5lH4hu6rZRGONk962qcYbccXZTLKV2OK+JHsp4H2c=;
 b=Du2B0581K2P+p24nG6+V54e/aRJ6BvmzCPHVi/UsYWStKs2YmXTcdXopoOk75dqUtW
 fpYHsU5SvfMh0oEg25qKtPhYiiHu/z/ziiqpJWYLrbqMJJKm+p3swgAf37ykkaTyopPD
 kYuEuT1zCkYOcBWbb6Jjejg/nKNjAeY9+MHiMGKfsq38R5CeEWnrGBbAt1vIh/ydAW5Z
 Qu1G25kJEFm/FT3xSDIoExD4l+6+YfpGOJnt3lHlOFX/4rrAGc/B57gRy5QwC+1smsBm
 h/8D2jdLKNL6bBF4+koXpGHhKEF1xfMRJ1jbaLZADX5nWTJ2vpKlw52OiExaYusmG8i2
 3MeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4docS+TzVlTTamm9AioVG/LoroFkofWkpSAlO3kS8RLbZxoX0S72H0huZbJiphCpukhNwBzY=@lists.denx.de
X-Gm-Message-State: AOJu0YxJx5NCCqgL4yT1nVF5aXQnfMou+fRs5iwNb5DeM6SZ1VuqEFbR
 Xprv4EosznQwqb+62pRaFQQ2YIjrdEWlM1u61ZrKwJ+4Cq7UXzJu7FFWxpq02j8=
X-Google-Smtp-Source: AGHT+IGUchJJ10uCMB8qsAKCxmm7pVZirTG99G4GXu5WwtQ927sQRnkWx4DUnak0fjLLV+larI8iVg==
X-Received: by 2002:a05:622a:1b93:b0:457:c435:a5c2 with SMTP id
 d75a77b69052e-4604bc492c0mr266772941cf.58.1729134308372; 
 Wed, 16 Oct 2024 20:05:08 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4607b38b976sm23434211cf.80.2024.10.16.20.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 20:05:07 -0700 (PDT)
Date: Wed, 16 Oct 2024 21:05:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Simon Glass <sjg@chromium.org>, "sbabic@denx.de" <sbabic@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, Gilles Talis <gilles.talis@nxp.com>
Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Message-ID: <20241017030503.GI4959@bill-the-cat>
References: <20241011105827.7729-1-peng.fan@oss.nxp.com>
 <20241011165616.GW14210@bill-the-cat>
 <CAOMZO5CSK74_TcubtN1W1MpVmTwTmbv_XfhaOexpdvoc5WGb=w@mail.gmail.com>
 <PAXPR04MB845979AC895A90D969E5F216887A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241016184539.GF4959@bill-the-cat>
 <PAXPR04MB845987E412CB6526FAC7D7F188472@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bTdNpFiRrv1QcB6v"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845987E412CB6526FAC7D7F188472@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--bTdNpFiRrv1QcB6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 01:10:02AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device
> > tree
> >=20
> > On Sat, Oct 12, 2024 at 12:16:14AM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt
> > device
> > > > tree
> > > >
> > > > > Why isn't this padding and alignment with the BSS being taken
> > care
> > > > of
> > > > > in either the linker script or the binman dts?
> > >
> > > Sorry, I am not sure what you mean.
> >=20
> > I mean, why are things placed in this position to start with? Why is the
> > device tree not already in a place where we aren't smashing it at run
> > time? Is this a problem of the alignment / placement of items in a blob?
> > A runtime placement problem? What?
>=20
> Whether binman or not. I think u-boot.dtb is padded just end
> of u-boot-nodtb.bin. Not alignment or else.
>=20
> This is a common issue, bss should not be written before reloc_fdt.

It's possible I'm missing the examples in my quick grep right now but,
yes, why are you needing to make this device tree change so early? We
should not be using the "put this in the data section" kludge unless
strictly necessary. Why is this necessary and cannot wait until, well,
further along in the boot? This is supposed to be for
pre-DRAM-initialization stuff.

--=20
Tom

--bTdNpFiRrv1QcB6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcQftsACgkQFHw5/5Y0
tyzbggv/d5YoImFD4uEdLPmbgQkkWnL1FQO0se+Co5EeLMdU0U72U50cOisS0dT9
IkwOmvPwkgRDAB253q9pwzh8ay2sBIH61zqSqpMuMr1CzuPBydSN8As6ZosvbbHX
uVuwXhjS+bF8SNGYraSDtKu+CfPAXuZG3M3HLCLAM2qx76FyVvXPn8jlxlE+OlMH
F2DNelhqVSwg2OiOxIXuLY7zwDk2Tdp51ryGZMPzHvBuAhWD05XGwmYKb4bP5Dzo
MTKCjmv319T+EI4t5JKAWBBv05L2Z/Z/CqGWR+jFFh9R1MBbw4fF4p2+RMMdpGgL
GdEE3co2ze5ZFJJ7YQZ/FIZQ0LHTm7bGEOMQZLIFCN/V2KN9dTTVejsZoDraCGzR
VMVezRGjLVgxlY59rmTs5C5Q+uNTs77UPNDPA1pic5oPdpbhCW7MwtSRkzkohFMK
TYyErk/wVF1WRNqfqHjca0/jlNKG28gioFZHRewWEDcjen1dcKymvGcjtngXu6wA
6YuqSGOG
=5++b
-----END PGP SIGNATURE-----

--bTdNpFiRrv1QcB6v--
