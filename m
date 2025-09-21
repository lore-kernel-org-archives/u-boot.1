Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62D9CAC5A7
	for <u-boot@archiver.kernel.org>; Sun, 21 Sep 2025 16:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C76483211;
	Sun, 21 Sep 2025 18:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d2HiiOBe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F76883335; Sun, 21 Sep 2025 18:06:49 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09CEE8317B
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 18:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-4247d991161so17128225ab.3
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758470806; x=1759075606; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p9iSHrGWGVS68QoTchk+EEnBDumLOUmymsKJcniS9hg=;
 b=d2HiiOBept7dLMzKp1LDCvfj3Z2MvYCdRkEUNXx4E2rt96/secATk4SjrLf6hVoH+1
 OIGiIQgKgGnPOp1UShbUR5O6zqATr51b9ovIrKDFjX7OqY0TO20e66qJhrhsSXLHH8ss
 rhmhkkIlSSEg/eY4KsZwANCTNXfEylzFX1GyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758470806; x=1759075606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9iSHrGWGVS68QoTchk+EEnBDumLOUmymsKJcniS9hg=;
 b=DRQn3RfVep7PmuGtq0zm91I3KtMKDtkv6nOS+hAJeDikY3Nyd1sQ/T2Hw5jv4DZTO2
 rFlwFD6pdpMMTpLC8y+9qPUl8CFXx06utGBK+xJc9UFGuiMQx0HBP2xtvgjfmfZbCyff
 Ypma9zL9FYeHaEtWx00+ibCV9Jui3tYTABOLROK77U26kK8rNK3T0DnYmH54TS/oZD8s
 5mnxt2na1Nt9DqG69EUZFPO4CzY6aB8rolOXNxS73nQFqGkpWSp2IXCCUpOn5a9CFohD
 EBgPtPonqJYueAQXtrVzy6YN2O09Ldu9a+3SPI6NXnmBk/obz5tpFNkz5OvHbm35wZy3
 zafQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo2CPXJpL3KA9kq1yUTWQ53lmvwAHvf6zl8aCKxBIsiclIELwJfe20CBwTdupxRa2QdTRunUw=@lists.denx.de
X-Gm-Message-State: AOJu0YwtQ3lQc73JvmGkPLjw2JXJy8nGTCpm7mXSEd1N/fZqzJKFmxz2
 HaIbxHXZbP9jKGleCIpbOT5HKIPTI0VEm/QSoHxu8mMVoCa/Cdu+ZXr45AP1YbB3neA=
X-Gm-Gg: ASbGncvmjPSviHaUZEpt8v9o9f/Id+sK1jAc6KSC5HUzxtEZZV9uzmo3vl3yKzBx+Rp
 M3FihCd27N5aCL3MnJ2zbK2g5MdmiC6vVsYhWDCTABSuqG0+zpo6rADnrGB52yGqzmijFdRZQKW
 9VVS2IKD6WFkUjeYNGn5LbfH8sUcKh1OGKqQUtu9T/TlL2X2WScgERa6mxh0hs3vECjefJPh1hB
 icuy0r1yze/ZRd5UU0v87iacMLMWgyxtMBDiy7t6dd/xVTW0aSQllFhTfaP6dIfzN8BxnSlVcHh
 hNm5glo8GcszRaG8EcpklRJuJ7dL9P32+OdL0GvwCV6EujXLaTCf6i6+rVs9AqBjl8YPtVJtLWv
 ATgSQOqtias3hQcrL//TVB83eh9i/L2AH1DAjL5ksWOviLXHUd/xvsTHg
X-Google-Smtp-Source: AGHT+IFps5TDi/QiczfNmgB3lXAO2XoRAXGPRGFTpVCZHa0UKXqvWMpA/ilctNQoKMFvIXg/vp+ktg==
X-Received: by 2002:a05:6e02:160b:b0:424:8b1b:73ff with SMTP id
 e9e14a558f8ab-4248b1b7442mr94506795ab.31.1758470804698; 
 Sun, 21 Sep 2025 09:06:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-53d53990158sm4624300173.55.2025.09.21.09.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Sep 2025 09:06:43 -0700 (PDT)
Date: Sun, 21 Sep 2025 10:06:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, E Shattow <e@freeshell.de>,
 Stefano Babic <sbabic@nabladev.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>
Subject: Re: [EXT] Re: [PATCH v1 4/8] imx9: scmi: Update the files under
 arch/arm/mach-imx/imx9/scmi/ to support i.MX94
Message-ID: <20250921160641.GZ124814@bill-the-cat>
References: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
 <20250901-imx94-v1-4-c85ae7cdd95c@oss.nxp.com>
 <5ce9ad71-2d24-408b-ba55-cd87bf96afb1@freeshell.de>
 <PAXPR04MB96448A9D96B04749D3E882FBE209A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <CAOMZO5CmBuOBT7snFVV_KLw_jJJ_b1-BGUk+pVAEYC6JMOFBRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k6NQSwni9wMQOf5P"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CmBuOBT7snFVV_KLw_jJJ_b1-BGUk+pVAEYC6JMOFBRw@mail.gmail.com>
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


--k6NQSwni9wMQOf5P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 09:15:43AM -0300, Fabio Estevam wrote:
> Hi Alice,
>=20
> On Thu, Sep 11, 2025 at 3:42=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nx=
p.com> wrote:
>=20
> > > >  #include "../../../../../dts/upstream/src/arm64/freescale/imx95-cl=
ock.h"
> > >
> > > What is this? I asked and it was suggested to send a patch upstream, =
but they
> > > said no. Ref:
> ...
> > This line of code is unnecessary and can be deleted.
>=20
> > > Again this weird include relative-global path... not good.
> > >
> > > I don't know what it should be, sorry. It is fragile and we should do=
 something
> > > better.
> > >
> >
> > These files are derived from the Linux source code.
>=20
> Please address E Shattow's comments and send a v2 that also contains
> the imx94-evk support.
>=20
> This way, we can achieve build coverage for the entire series.

There was some discussion of this on IRC as well, and the issue is that
(for now?) this header in the kernel is supposed to be with the dts
files and not dt-bindings and so it's not in a normal search path.

I think that for us that means we should do some Makefile games in that
directory and add a -I$(srctree)/dts/... and comment in the code to say
this is a DT header file.

--=20
Tom

--k6NQSwni9wMQOf5P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNAijQAKCRAr4qD1Cr/k
CvdcAP9Jvp4xbZ8d1j204xf0AI/SceoZoOpNLZZO3PV8LN7aogD3XPSqYrBkFOgP
l+iMc/VldKu+7XJ73z3DohbKIR4JAQ==
=K49O
-----END PGP SIGNATURE-----

--k6NQSwni9wMQOf5P--
