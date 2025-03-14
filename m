Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EBEC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1D0181EC5;
	Fri, 14 Mar 2025 17:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V94LveiY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A2A81ECA; Fri, 14 Mar 2025 17:57:08 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2420D81EC0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4766cb762b6so22845971cf.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741971425; x=1742576225; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Am5VhibFwbCKLjne9UlT4Fg6sL1ciN7jmt8OOCMOqz0=;
 b=V94LveiYwugxEXvIZXlZQZwDAZOCOh53EKaZGl5kDv0vu0QyaW5XJTsgs3m0AVTuWR
 WWt66Sw2TukZdwdIUvK3huOXExWql1HsYvmzRmCtf9DEjaxwniw/AtR+HULx8P9IvOum
 6Lb+8KUfVK/tpGtOvFF1UiWET1V5gifxeesHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741971425; x=1742576225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Am5VhibFwbCKLjne9UlT4Fg6sL1ciN7jmt8OOCMOqz0=;
 b=wRRjiy5F1F5uSiFgMcaLWrMJPydjqwnx0TkA+3MGtUdNqT/PoDBqBiDhgZxtHTHiSW
 XGdnOKxrPoYXAOVp6e19pYaOiXKE7c3IzGo2u99qKKlfTUt+IkU1/LZ++RCmS7mY6gNb
 qM4Pf0bNucyZTriTuXCQjAW8T1IipszODQ4lcxdGU9L0/4Mw+ic6UfviLi5Yf0KoMDen
 0S9ENUkg/HGwDTsC/YxWIH4/rCo7pswVtU2SIqGfkttTUJl47YrrOhhhanfEcnGvcQpT
 ujYEgi6wRNYhae8OCDyAC8/klqRc+ky+R7mWeGvjeYhSzeqljynfw83d9fqMXF/zisaJ
 Hm4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg6fE2gB/Y31SuIX9fy8BP7X3LnhZoywZ9GQWRY1JyFzYDxQ2pI7RG0WBtZLl55IUwrP0LSxo=@lists.denx.de
X-Gm-Message-State: AOJu0YxoPRKZ98EDWE+ORfqqPxkp7ULuL4iT+bPiGf7LbStsRTsH1bAw
 3PXFX2YNyfLHzjVMXGIpMW6d1erx3YUfCrcnF6XpthJWkM/OnC3BhJngb+MixFs=
X-Gm-Gg: ASbGnctQkllVMlpDQ1K5gHkWzGDZ756irNxL/CIkcVg4XkPv82GClEEajq8kX9Zv3O3
 np1yJkTj7xeu/poF42MqhlpUpRtPTXrZMPSXO6d+vhYq6N8b/hw24GRZx/iJeVH8ossZSqXkNSy
 SuKZ4tifN1u9cg9bZ+aTJEREdxGLmqPyBR96VYjCtS9OQun6cDNcX5ZpbWG1WtPJdp5tEYtFMg1
 mDbf7YMHG/AN8WsTrZLl0pnJMPFbenog46muF4GILltKDQF37/AjfPmTWsVhOUKi5GKSDJi+/qH
 HQj3yTKZVF9JzzAusQuwiiBOFmTP0+vGBx8QNk5kxSwvmQ==
X-Google-Smtp-Source: AGHT+IFiALtQKr/GCQBHffP29zq45PwVQZ6u+M2A+FLMyScEBr2+L7S9SVWy9W81buPtgPbdxLzEVg==
X-Received: by 2002:a05:622a:510:b0:468:f858:6662 with SMTP id
 d75a77b69052e-476ba8c5070mr130788501cf.10.1741971424754; 
 Fri, 14 Mar 2025 09:57:04 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb65e9b5sm25327321cf.37.2025.03.14.09.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:57:04 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:57:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Anatolij Gustschin <agust@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>,
 Anton Bambura <jenneron@protonmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] video: edid: guard standard timings EDID
 expansion behind kconfig
Message-ID: <20250314165701.GD2640854@bill-the-cat>
References: <20250314064720.5767-1-clamor95@gmail.com>
 <20250314162118.GU2640854@bill-the-cat>
 <CAPVz0n0GyC2EdzaGKynCGmMpEyZLb3YG8La-3fxvkWHnWvWdog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iczPpH/yMTI6w7fI"
Content-Disposition: inline
In-Reply-To: <CAPVz0n0GyC2EdzaGKynCGmMpEyZLb3YG8La-3fxvkWHnWvWdog@mail.gmail.com>
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


--iczPpH/yMTI6w7fI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 06:47:26PM +0200, Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 14 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 18:21 To=
m Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Fri, Mar 14, 2025 at 08:47:19AM +0200, Svyatoslav Ryhel wrote:
> >
> > > Since EDID only indicates supported standard timings, a large table w=
ith
> > > detailed timing information is necessary, consuming significant space=
=2E To
> > > mitigate this, the table is made configurable via kconfig, allowing i=
t to
> > > be excluded when not needed.
> > >
> > > Svyatoslav Ryhel (1):
> > >   video: edid: guard standard timings EDID expansion behind kconfig
> > >
> > >  common/edid.c         | 6 ++++++
> > >  drivers/video/Kconfig | 6 ++++++
> > >  2 files changed, 12 insertions(+)
> >
> > To be clear, when the flag is not enabled do we have something similar
> > to the old behavior, at least in the correctly functions case?
> >
>=20
> As long as I2C_EDID_STANDARD is disabled the old behavior isn't
> changed, there were performed a bit of code refactoring, in the
> previous patch by Jonas, to simplify readability but nothing more then
> that. Significant size increase is not detected as well, as long as
> I2C_EDID_STANDARD=3Dn

Great, thanks for clarifying.

--=20
Tom

--iczPpH/yMTI6w7fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUX90ACgkQFHw5/5Y0
tyyofwv/f78QvFJkJxgx8p5jBRRONS5zuC2o797njruFdF9cwSOHCeBUUsZpjyun
Hn4a6L8bClmOVymwftMA3aulrvjmE6HKc6Ey2hNGmDSCaEnsME01lTb4MabZKm+4
DyqRFFdA53mZ/Si267epZsCF7kDde284CjCiWtOzQFVeQw0VZgREcddDLVO/grH/
qqSmgs/cpCWxvzjrFxQDgBabsYeHZGgV0MafunRfFbXfnWmB1oTBiIeiiOVsc5RE
5ZY524AFBX/PUJiBdVXFo/nentGd5xx0VHysQ5WtCWimbw+zhq29Gf+K6FLwZkw3
kB0CCDCHWmfHm09Nj8KxD249G1AgiBH+pEMAS9upt31no3/wiN3h9vvJPmWTlSYO
wedNzi6/Rkb2DDO/Gs13CfJml0O1M7/LJ9/1gft9NP7RdV/TU9BL84K3Xn0h9Hq+
4q/v0Rd3KzhLynHbM8ghHYzSPC810o21iyue4oMXH0RQ6+cc59whWXxQt6BmGhnS
CxgJpo7w
=6Y17
-----END PGP SIGNATURE-----

--iczPpH/yMTI6w7fI--
