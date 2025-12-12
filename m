Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05279D49230
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 14:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27C8B83106;
	Fri, 12 Dec 2025 15:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HjopqPgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 789128312A; Fri, 12 Dec 2025 15:27:28 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FB3D80325
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 15:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3ec41466a30so1033277fac.0
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 06:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765549635; x=1766154435; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aAGy9ELW7XAsszTnqdIgi78lC50du7CAlZWk643WuCc=;
 b=HjopqPgj5LFETZL49btn9I/gr8LXPFreLfzMjuIP0+A9tQnEie4yaA2nRY+8uryygL
 IHT+OZdNJ6d2RUplCmHKUchuZmG0qvcLbIqkubjcIAzIjgIv4Dduwt0OZUeQ8D0rUrlP
 Pbh9JkQrY9dMv7LrYsgwIkyw8qL+aBH/5gOtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765549635; x=1766154435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aAGy9ELW7XAsszTnqdIgi78lC50du7CAlZWk643WuCc=;
 b=ZQ4ABCOypLoUyOqKqwt4PNCoqbxtcz3fH7e7KnvrP8rt/WRlPQKRheAdYFtnryhvs0
 WjIpHHDun/jZGCdVX9dOuhAZkqgEbEGOgCSEmR2meHOGNwpdBcUu5MRWrfuqpAxuDDH6
 6XVzSFhTl8yYnFf9IcPaCNQLgOJxTodSSbHlNIIgk8D4jO4nPhGfPsJdA5KXtvTxTz/H
 dGYAgkULJCgeIteuvKRXjjJMBjur92eDTqK/spTGWW9NcKrMKS8dl8Bw4gQ6Q0YsoXhe
 Lz2do6u0+TgqyM3F5jRgqyaO0jjinhpAIjNUlLLfq8f+9/r18ET/Z7wEAmhRBvtlzEot
 GUnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Pjs/klK5XpfMVoHniHhO9A9z6KdUt3CLKkd4EQqHgQuVo/6qQqGaoiRoq8JUh3DlQejxF4w=@lists.denx.de
X-Gm-Message-State: AOJu0YxdZ5w9PjxEEbRYNwO3ubCy485ui/iF4AS8S/3SC/XzeIGu3W7Z
 5QInzS6ejr1AuAKjj/zBrEMYa5zmoNh/p3fMWLPJWcfdq0zpPdqP+p94t4NI6W5buDc=
X-Gm-Gg: AY/fxX4zZXSwpTIew7sMvCzzl0UZyuT2DpKcsKq4Coa1lHMMX4zX8cIpLnnkJKDn9M8
 7Kh+Pr3FCnns7ab1aqPNEKdKq/IERARZgQY0/UgjsCnY3WXx/n/mdqU2Df8sKEX6V59bf+PTNC3
 EAPzemNnunF8U0jA0PxMV+dRz+esbiuMvCG9mIUibYbE3R9zF9YQ99v3sdPEUrrzi8MJSKpERts
 NBkU2Mkm0R+ZAJhm3ErOjkxEnBNwj/yTxX+BAwon5umnXZr76wurVCDPQou5kOjxzcB9e76fDJC
 5nEXtYr4R9nrNNlyplIgsAR16kJeqhiK0YsiasFRbBAc+JEBM2oDrxDmgNyMDmYzWgRysmMme4e
 DofSfCuT9sTIKe/dVjF2tbIiXnRsHBpPWrqnO+WFDPHszqjuTK8hSAPwSjqLxEqvkUxDeF8UzBG
 +iN08wWEwRX4MfrdG7p6jvt1lo9wiHrHcjwgkXaG4vC23ZESecehzXSX9P59is
X-Google-Smtp-Source: AGHT+IFhIUv3UbzLfZZp9sGWUwd2pFqd4CZdl5KiZ90LajxBGC8Hi2mY/WNqb++26c0avbEK5/gfvQ==
X-Received: by 2002:a05:6871:230e:b0:3ec:57e7:6816 with SMTP id
 586e51a60fabf-3f5df9ca7f4mr2868417fac.6.1765549634808; 
 Fri, 12 Dec 2025 06:27:14 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5fe4e4169sm1063109fac.12.2025.12.12.06.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 06:27:13 -0800 (PST)
Date: Fri, 12 Dec 2025 08:27:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/5] net: Port NFS to LWIP
Message-ID: <20251212142711.GP303283@bill-the-cat>
References: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
 <d9abea30-3604-4c06-9ec0-15e67edf34f7@gmx.de>
 <0e7b7801-1066-4ed5-9407-a0dd62f2b8a9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mAXiSJeoh+O18cTG"
Content-Disposition: inline
In-Reply-To: <0e7b7801-1066-4ed5-9407-a0dd62f2b8a9@linaro.org>
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


--mAXiSJeoh+O18cTG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 09:07:59AM +0000, Andrew Goodbody wrote:
> On 10/12/2025 12:55, Heinrich Schuchardt wrote:
> > On 12/8/25 13:52, Andrew Goodbody wrote:
> > > This series ports the existing NFS code so that it can be used with b=
oth
> > > the legacy network code and also with LWIP.
> > > Firstly some legacy network code, mostly variables, is moved into com=
mon
> > > files so that it is accessible to LWIP.
> > > Secondly the NFS code is refactored so that the parts that are not
> > > specific to the network code can be shared with both network
> > > implementations.
> > > Finally the LWIP specific parts needed to interface the NFS shared co=
de
> > > to that network stack are added and enabled.
> > >=20
> > > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > ---
> > > Andrew Goodbody (5):
> > > =A0=A0=A0=A0=A0=A0 net: move net_state to net-common
> > > =A0=A0=A0=A0=A0=A0 net: Move some variables to net-common files
> > > =A0=A0=A0=A0=A0=A0 net: nfs: Add licence header
> > > =A0=A0=A0=A0=A0=A0 net: nfs: Move most NFS code to common files
> > > =A0=A0=A0=A0=A0=A0 net: lwip: nfs: Port the NFS code to work with LWIP
> > >=20
> > > =A0 cmd/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 28 +-
> > > =A0 cmd/lwip/Makefile=A0=A0=A0 |=A0=A0 1 +
> > > =A0 cmd/lwip/nfs.c=A0=A0=A0=A0=A0=A0 |=A0 11 +
> > > =A0 include/net-common.h |=A0 38 ++-
> > > =A0 include/net-legacy.h |=A0 26 --
> > > =A0 include/net-lwip.h=A0=A0 |=A0=A0 1 +
> > > =A0 net/Makefile=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
> > > =A0 net/lwip/Makefile=A0=A0=A0 |=A0=A0 1 +
> > > =A0 net/lwip/net-lwip.c=A0 |=A0=A0 5 -
> > > =A0 net/lwip/nfs.c=A0=A0=A0=A0=A0=A0 | 282 +++++++++++++++++
> > > =A0 net/net-common.c=A0=A0=A0=A0 |=A0 21 ++
> > > =A0 net/net.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 23 --
> > > =A0 net/nfs-common.c=A0=A0=A0=A0 | 863
> > > +++++++++++++++++++++++++++++++++++++++++ ++++++++++
> > > =A0 net/nfs-common.h=A0=A0=A0=A0 | 123 ++++++++
> > > =A0 net/nfs.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 849
> > > +-------------------------------------------------
> > > =A0 net/nfs.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 59 ----
> > > =A0 16 files changed, 1368 insertions(+), 964 deletions(-)
> > > ---
> > > base-commit: 59f9fcc1f514762674ac07c13c2a85f7aace7250
> > > change-id: 20251029-lwip_nfs-5385efca71bc
> > >=20
> > > Best regards,
> >=20
> > Thank you for looking into the LWIP port.
> >=20
> > We lack an NFS server in our Gitlab CI to run the NFS test.
> >=20
> > For HTTP we are running
> > python3 -m http.server 80 --directory "${UBOOT_TRAVIS_BUILD_DIR}"
> > in .gitlab-ci.yml.
> >=20
> > We should do something similar for NFS.
> >=20
> > There is a userspace NFS server available
> > at https://github.com/unfs3/unfs3.
> >=20
> > This worked on my workstation:
> >=20
> > cat > exports << EOF
> > /home/ubuntu
> > EOF
> > ./unfsd -e `pwd`/exports=A0 -u=A0 -n 4096 -m 4096
> > sudo mount -t nfs \
> > -o port=3D4096,mountport=3D4096,mountvers=3D3,nolock \
> > localhost:/home/ubuntu /mnt
> >=20
> > Now in /mnt I could see the /home/ubuntu file-system.
>=20
> Tom, is this something that can be added to the build containers?

Yes, that sounds reasonable.

--=20
Tom

--mAXiSJeoh+O18cTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTwmOwAKCRAr4qD1Cr/k
CrVWAPkBhGBiLHBVmCPQkQ2Up/2skR4j5cvY5yZaRyTx6c/R9wEAt+dR3zLVItUY
Y39TQzdtgu5t0+jngaPXa+Y8uKsqnA8=
=5kFN
-----END PGP SIGNATURE-----

--mAXiSJeoh+O18cTG--
