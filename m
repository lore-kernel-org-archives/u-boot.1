Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD738C02194
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 22:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D90EB800B3;
	Mon,  3 Feb 2025 23:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HBoVp4yR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4768080107; Mon,  3 Feb 2025 23:22:26 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E95480087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 23:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6dfbc45355bso53317926d6.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 14:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738621342; x=1739226142; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U3jF9MyDwGRUV9o60jc2g6D+KLtX3bE6MBCiikhBNOQ=;
 b=HBoVp4yReRH5kCmamGsL1ICUAnwCDhCvoYbGTLsevO8RzO0QTkLzTcXlyNgKHU2pAu
 1Y7nqInsnaSVvKj8VfvUSWeKb8nuno7jsbgTkkIsfM88D9U0rjTTOmWvttV06JmX9JS5
 lq2YhQRMSze/JhgD3v1MjJw/nXmVD0TkJp8Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738621342; x=1739226142;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3jF9MyDwGRUV9o60jc2g6D+KLtX3bE6MBCiikhBNOQ=;
 b=fvrBdmBaMzdLP8qWPaq+DxEV++ibgJhxQ3DlebZY2GK/OOeK0hEDZdtZoEucG6iAAj
 TMewDhAiinZrxuc4BD6PlcUHvk4PQCCbo5VjYEPN/vFnoqFGj140ZvCwQKqZpMunMFB7
 xpMXX//akLAS/FDiS0zM/xLnG34rhapq2kIuKTAcTmdsGi/xceAeH98OTVV1vVHY5w1G
 0Snk8bAvOb2ErZ7AxCizV29scS20NxgQ7m3XlN4sE2devq4CRTyJIj/sJ1U990SDnpjS
 HsvdOlmW/5d7ZB0gwZB/+LRjzur+Vt/sWqB5cxQT4mXf1LSmuRC+0aiZKfpq7sGkcT+g
 ct8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWssqO07RHw0zn77MUbDWXG/dhhCuy7fH+HZAlpfm9Vi0qnKPag+sxMsHFqBXbOz7ws/KFeIh0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1+IMBInyCCoDXWt6vrCHuNHmug+T5U3mIBxP/7JcMc1N+lAb+
 0i09oxaN0wtGYc5pT1wFRuIBbvHff7dY3CJ7KGjctCYqU7mGYGSnI9UStcXqbaI=
X-Gm-Gg: ASbGncszyD7StoASrX8r5phspCTwRFMjZQVNqFP1AT9c1Hz2QVZHW0KUePouKv4Wvxi
 htqEeo6zR9jbFNCHs1QiRSFWOnjiYlThBIKP6JuUefb2kEAfFOzGvSEOgym3isEZhnklC67aHHD
 NO3CHI1+WpTYY0c0gzN3OdMGL5vFhmznDxls7qx9fcT8R0dD5MPO7aT6eNl/UUVObMzFqu82uCL
 NAISEv4kp5PPveRmd1kLkJYycaaZ0y/R5aw2WsDH0Loh/UiN2aKNLfN5O6DOwvIZe9dVzaM2WXd
 2F/whNht1/RTcyc=
X-Google-Smtp-Source: AGHT+IHqFGrzCm1Z+3PJBadhWaLDKXtuZM5CTyR8HVsIs546liFbksq1mV+DSbO2xWVjX0kxOUUS9A==
X-Received: by 2002:a05:6214:f2a:b0:6d8:7ed4:336c with SMTP id
 6a1803df08f44-6e243b912a9mr310440386d6.9.1738621342464; 
 Mon, 03 Feb 2025 14:22:22 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e25493ee59sm54495256d6.96.2025.02.03.14.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 14:22:21 -0800 (PST)
Date: Mon, 3 Feb 2025 16:22:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/4] bloblist: add support for CONFIG_BLOBLIST_PASSAGE
Message-ID: <20250203222218.GA1233568@bill-the-cat>
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-4-harrison.mutai@arm.com>
 <20250122172103.GA52306@bill-the-cat>
 <71c99ce9-673f-43e7-8bdd-86afb64c3707@arm.com>
 <20250123171239.GM60249@bill-the-cat>
 <e2cbe06e-c83b-4bbf-94dd-386fea7fb41f@arm.com>
 <20250131001021.GN1233568@bill-the-cat>
 <e9fee281-70aa-4a8c-a8ae-b1ed76eeefa5@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vfGe2bMqW5qWLYc3"
Content-Disposition: inline
In-Reply-To: <e9fee281-70aa-4a8c-a8ae-b1ed76eeefa5@arm.com>
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


--vfGe2bMqW5qWLYc3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 12:28:25PM +0000, Harrison Mutai wrote:
> On 31/01/2025 00:10, Tom Rini wrote:
> > On Mon, Jan 27, 2025 at 12:42:30PM +0000, Harrison Mutai wrote:
> > > Hi Tom,
> > >=20
> > > Thanks for the additional details, that helped!
> > >=20
> > > On 23/01/2025 17:12, Tom Rini wrote:
> > > > On Thu, Jan 23, 2025 at 05:03:40PM +0000, Harrison Mutai wrote:
> > > > > On 22/01/2025 17:21, Tom Rini wrote:
> > > > > > On Wed, Jan 15, 2025 at 01:52:06PM +0000, Harrison Mutai wrote:
> > > > > >=20
> > > > > > > When the configuration option CONFIG_BLOBLIST_PASSAGE is sele=
cted, the
> > > > > > > bloblist present in the incoming standard passage is utilised=
 in-place.
> > > > > > > There is no need to specify the size of the bloblist as the s=
ystem
> > > > > > > automatically detects it using the header information.
> > > > > > >=20
> > > > > > > Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
> > > > > > > ---
> > > > > > >     common/Kconfig    | 8 +++++++-
> > > > > > >     common/bloblist.c | 5 ++++-
> > > > > > >     2 files changed, 11 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > This leads to failure to boot on qemu-arm-sbsa as seen in CI:
> > > > > > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10=
392&view=3Dlogs&j=3Dac5e904b-a30c-5e1d-9570-462b8181c990&t=3D863544fb-ed04-=
5d34-fdac-10f5bbb057bd&l=3D423
> > > > > >=20
> > > > > Sorry, I'm unfamilliar with U-Boot's CI but I can't make out what=
 the source
> > > > > of the failure is. All I see in the logs is what looks like an in=
termittent
> > > > > error.
> > > > >=20
> > > > > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D1039=
2&view=3Dlogs&j=3Dac5e904b-a30c-5e1d-9570-462b8181c990&t=3D863544fb-ed04-5d=
34-fdac-10f5bbb057bd&l=3D423
> > > > >=20
> > > > > Would you be able to share the results XML?
> > > >=20
> > > > The problem is that qemu doesn't start anymore, sorry for being unc=
lear.
> > > > Looking at
> > > > https://source.denx.de/u-boot/u-boot-test-hooks/-/blob/master/bin/t=
ravis-ci/conf.qemu-arm-sbsa_na?ref_type=3Dheads
> > > > we can see how qemu is invoked.
> > > >=20
> > >=20
> > > I've successfully reproduced and resolved the error. The issue occurr=
ed
> > > because I relaxed the condition for calling the architecture-specific=
 hook
> > > xferlist_from_boot_arg. Previously, this hook was only called if the
> > > bloblist was at a fixed address and U-Boot was in the first phase. Ho=
wever,
> > > since we also need the hook for BLOBLIST_PASSAGE, I've added a condit=
ion to
> > > prevent calling the hook if BLOBLIST_ALLOC is enabled, assuming we do=
n't
> > > expect to receive a bloblist from the previous stage in this mode.
> > >=20
> > > However, I'm slightly unsure if this assumption is correct. Generally=
, when
> > > BLOBLIST_ALLOC is enabled, is it expected that U-Boot will allocate m=
emory
> > > for the bloblist, ignoring the bloblist from previous stages? In the =
case of
> > > BLOBLIST_FIXED, we relocate any bloblist received from the prior stag=
e to
> > > the fixed address. I'm surprised we don't do the same with BLOBLIST_A=
LLOC.
> >=20
> > The problem is that today at least yes, BLOBLIST_ALLOC is only viable
> > for full U-Boot as we don't have a mechanism to pass our own from one
> > stage to the next unless it's fixed.
> >=20
>=20
> To summarize, BLOBLIST_ALLOC is meant to serve as a fallback buffer for
> internal use when a prior-stage bootloader hasn't provided a bloblist at a
> fixed address (BLOBLIST_FIXED) or a pointer to a bloblist
> (BLOBLIST_PASSAGE). From the perspective of a prior-stage bootloader, the=
se
> are the only relevant options. BLOBLIST_ALLOC is also entirely irrelevant
> when U-Boot is staged. Have a I missed anything?

With the perspective of a non-U-Boot prior stage, this is right.
Ideally, U-Boot should be able to use BLOBLIST_ALLOC in one phase and
pass bloblist to a later stage. But that's outside of the scope of what
you're dealing with right now, yes?

--=20
Tom

--vfGe2bMqW5qWLYc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehQZYACgkQFHw5/5Y0
tyyQhQwAr59z/SORQneYQCXXXqWjkn4xKmqaFc7kJW4g7pChyONwznLZdJytZ6BW
8x8Q/a6k4BUIHCELUGnSq69LIa2k4/x/UW86gbz/Fi+wR2pBs7cIasD0j7FQsd2i
Zk1711RHJNuFgUGQTfOOELt6pPBAD1Ri7/1p7hL9C5ncdjrmR4z1Xo1uO94qoOm6
6aMvxcdAWXFxaJVxbW+GMOIxevzSixX/Zo8a1o9/VEPLOwYaffd1OjYw7qQeaaLt
dsEdLnOfqy37WeFd7TeceSZc7NjmcmASgMmPQLhBesj4m1cL107XKBG7/H9c8fAP
5wa/A7GFStyaA8aibvGKkyJDSg27sIqS0PpBNuXQjjyik5vFd1gThOtCT3j0eYEr
qCqCuLkzUYYu6Ve1q7RFGL2jx4PHx2i/1znMxX3gZvDDmjHOpObD+l0xocxHmTHC
XgEbK/nuAM0FqhP3rHOgGr7pTuOHl5y8lO8KDc8h2rtmPKnAnZ1mRt3pn+80MVDE
54b1jtNR
=kW3x
-----END PGP SIGNATURE-----

--vfGe2bMqW5qWLYc3--
