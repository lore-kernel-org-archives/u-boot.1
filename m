Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78156E7AD52
	for <u-boot@archiver.kernel.org>; Thu, 25 Dec 2025 15:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C5B84368;
	Thu, 25 Dec 2025 16:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FETXtlvd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DACA8436C; Thu, 25 Dec 2025 16:06:46 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1137A842F2
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 16:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c701097a75so3589027a34.3
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 07:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766675203; x=1767280003; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X4b3xtFHotFObE1mbXlwDPczUeJBUne5ihsWRT7qjrk=;
 b=FETXtlvd1ewnWg90fu4Q6vbh2hBNIVs1UfGs8uDbu/vSWeezHDCWrwUM3OWnDrovQ6
 FcRSXq4tYWK9Zv0/9XnivsLLUoavPFZzWwe6D9Sy9qpF+Pt7ZzZGCFhaepEHtI/ZRUkk
 GhqnU7LML5X9CWJhFBCh+ZcCh2QfvbjB2LUNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766675203; x=1767280003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4b3xtFHotFObE1mbXlwDPczUeJBUne5ihsWRT7qjrk=;
 b=VqNr/kowUDUlCwMbG7cDICByG8lu1/URMRvq4V9TmU+CJf8qk+YpT4R46lIi4fOKJS
 IerXg5mPbMXVp/xeG4D7hbRexCKm3LZdQ9EaoX10z8O46akGxi3hb6Ae8p7dmvB1GL5k
 TLm5WxX/HxHjWMXfPz8RwAcLNeW+2KR50M1ngEuSL2vSrcDZs+5WdGO1iEI/0IYLLlEs
 RCRO9ZG+6B+ydA28bpgHlmTp2AsHL7FvEOdVIkdUHCX0lGWwkxcJRkpmqcT2jVXUzMne
 gqPjYPo5XoHUmdB8db3G7UzaDo3DAoTtCxBYEJbWaNgAp6WCsOGAj859bCtfz0Y40R0r
 dr4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhxx99ILs5HVfwJwmXBg+9+D7fSA9fY/KFqf6n1GgkopQy5EAWcju/6+jcvWLEUh0mPz/CrPE=@lists.denx.de
X-Gm-Message-State: AOJu0YzC+I0suLwEu75pkN8zLz76hLqikYbXQ8J8j3wdvjKWy6nsehPA
 MgPLU0yqnRoHasJX3vKmGVbCFf+shchbg/aEIJ7YCwAEDF/VRxMb0KTptzkAE7lq50o=
X-Gm-Gg: AY/fxX7puDUQcuhzlwGnIH6Q/qFUuK5YfKaDmLcEfnpKMB7FFrpUX9es/Hc8Bt25RH6
 6e+sDObbMgm+XVdBgbuHytxdCkRxvXCbdKRt2Gzcp+HhV6gxsSjKg7RP2f7bT6sN+MKTiYYWadD
 dzJYckjNi9efiYO0OvL+a7UZhVCjNvH2rANBUrZX8sVf6/S+hR/4nwYSZGBjtx0o+/djvrh11xI
 DXAxicm0lU/aPLAxw0lfeJIzG718Py57mLobkOmKJojaxyjsOUIr/dYggu6JfKLgp+ctr7Ed1EH
 R0cYc7Xoexl3Q/VgIizsEHCA1mAMcc+m5eNqHWR7he2nhCLER2HygCWh6F+fgGKAE9uqGp9AjVd
 t+QDSkj3WWh/+HTSJfRoS20H7f8LlUOa1Oek5mw9puL5cMvwYZCuz2GRf24kstemW5eFUMhRKsh
 /uhKRAK2+E1++XFShQe2CjCrI06W4PAMYkpIbt+6VsIeAxmw6ykw==
X-Google-Smtp-Source: AGHT+IETkcYvTMNzCM56rN8LHVRdFt6uyGbGc6yFgAeLIPfxco45iT6xKwrafgUwfAZSL8vWTsYdxA==
X-Received: by 2002:a05:6830:44aa:b0:7c7:6977:17cb with SMTP id
 46e09a7af769-7cc66a0eb4amr8647313a34.21.1766675202692; 
 Thu, 25 Dec 2025 07:06:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667f9201sm13312405a34.26.2025.12.25.07.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Dec 2025 07:06:41 -0800 (PST)
Date: Thu, 25 Dec 2025 09:06:39 -0600
From: Tom Rini <trini@konsulko.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Zang <davidzangcs@gmail.com>,
 Alice Guo <alice.guo@nxp.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH v1 5/7] usb:
 Kconfig: imply DM_USB_GADGET
Message-ID: <20251225150639.GA710860@bill-the-cat>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
 <20251216-imx8ulp-v1-5-504115a53020@nxp.com>
 <13e5946a-26d7-4b60-91f1-df9a3ba36f52@cherry.de>
 <PAXPR04MB9644C66E9B8C3109941561E1E2B3A@PAXPR04MB9644.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4CpZJjgutH60JG/T"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9644C66E9B8C3109941561E1E2B3A@PAXPR04MB9644.eurprd04.prod.outlook.com>
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


--4CpZJjgutH60JG/T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 25, 2025 at 10:16:29AM +0000, Alice Guo (OSS) wrote:
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Quentin Schulz <quentin.schulz@cherry.de>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B412=E6=9C=8816=E6=97=
=A5 17:50
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>; d=
l-uboot-imx
> > <uboot-imx@nxp.com>; u-boot@lists.denx.de
> > =E6=8A=84=E9=80=81: Stefano Babic <sbabic@nabladev.com>; Fabio Estevam
> > <festevam@gmail.com>; Tom Rini <trini@konsulko.com>; Marek Vasut
> > <marex@denx.de>; Marek Vasut <marek.vasut@mailbox.org>; Ye Li
> > <ye.li@nxp.com>; tharvey@gateworks.com; Peng Fan <peng.fan@nxp.com>;
> > Mattijs Korpershoek <mkorpershoek@kernel.org>; Lukasz Majewski
> > <lukma@denx.de>; Sherry Sun <sherry.sun@nxp.com>; Kever Yang
> > <kever.yang@rock-chips.com>; Jonas Karlman <jonas@kwiboo.se>; George
> > Chan <gchan9527@gmail.com>; Simon Glass <sjg@chromium.org>; David Zang
> > <davidzangcs@gmail.com>; Alice Guo <alice.guo@nxp.com>
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v1 5/7] usb: Kconfig: imply DM_USB_GADGET
> >=20
> > Hi Alice,
> >=20
> > On 12/16/25 7:38 AM, alice.guo@oss.nxp.com wrote:
> > > From: Sherry Sun <sherry.sun@nxp.com>
> > >
> > > Since the ci_udc driver has been converted to DM driver, the
> > > CONFIG_DM_USB_GADGET should also be selected when CONFIG_CI_UDC is
> > > enabled, then we can use DM ci_udc driver.
> > >
> >=20
> > Is DM_USB_GADGET *required* for CI_UDC to work? "imply" allows to have
> > DM_USB_GADGET=3Dy AND CI_UDC=3Dn, which is probably not what you want. =
You
> > probably simply want "depends on DM_USB_GADGET"
>=20
> There are 2 implementations supported in drivers/usb/gadget/ci_udc.c: a n=
on-DM path and a DM-based path. The current commit log wording might be amb=
iguous.

OK. But the key here is that we shouldn't keep code around for the case
of both non-DM and full U-Boot. It's valid to have non-DM and xPL, or DM
and xPL or DM and full U-Boot. We just need to be clear and sure that
we're doing this in both code and commit message.

--=20
Tom

--4CpZJjgutH60JG/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaU1S/AAKCRAr4qD1Cr/k
ChbcAQCoGZyGxNvuwRj6kWNScImgzY5tkDOeRG9BrsPlyDEM4AD/RJtjKHc6741m
SCWzM+PXXSJHyECt5rXQ1SY6swWhmgU=
=Bk56
-----END PGP SIGNATURE-----

--4CpZJjgutH60JG/T--
