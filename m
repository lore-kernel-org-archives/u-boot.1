Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4983DC5478C
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 15:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C4687DD3;
	Wed, 28 Feb 2024 16:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="beF4PGi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7349887DD3; Wed, 28 Feb 2024 16:20:47 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6083F8806E
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 16:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-607eefeea90so9720237b3.1
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 07:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709133638; x=1709738438; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PY9nlWKY9EZzxPt7oSog1YG4ECxo+Sh7ZK/SXdvlNsA=;
 b=beF4PGi4K87P+3+of9JEFX+LemUFIA8z/yT29rGsM9OJunTYqplcNIkkWkqV5DwpT5
 o1wKiI0kJMU0b0QgI/hSdkXA2BdZMgJONFvTYP3UaG1/Dh2TssW4Qu2zZMo/2oP1XSxH
 M2JetE+wyN4ZJFxRpQxQu4wNa5LYPxt83w6QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709133638; x=1709738438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PY9nlWKY9EZzxPt7oSog1YG4ECxo+Sh7ZK/SXdvlNsA=;
 b=GBP+D2+2wZEmFniXwKdWZaaqT9VqQ3xNMLrniuLIw6iK7GJq8FZtds64BF80okTUb8
 oNNCW3j6OC0SHMkjUInWQV1eNDGV+g9mx7Db84/xBS8rU3miuf7WlBpjMR9OOJXPnAep
 OvbdmLUS7QptkVhqmr7jNssfXu7K35XuFHVdB/adHPyI99EzXjRcYjno302C53ZAMP7E
 uoQiPmHkBvwz1wZEhr2TNjKa6jShQA1DfhtPvLwNhI2UGYGEQypoK9pqgJeDq05Q3lFR
 vKzGjsIFfVWC86hQ0VWCrQVwE01ENBpgDuukypU7D+TqqjbngSbbv/N0cAVpqNTqTcQy
 yPsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5O29B+U51dDjD39p/85l2L7w7hOBlGM7GqloNG6MUWdTtjDO5oFlBrnV1YZuhe+AZapE5Elgh5WOPmzRODdkv1bqmRw==
X-Gm-Message-State: AOJu0Yxxad63mGJAGMysYFrSIbg9xwYA8irnQE8bOYksQgMQJmKvHOyV
 MPx/pqaGrcOCEBUu5K9n05iMg0XJ6CPImMOyOFXxUoHwvPoNItixxWHu9TeFw0kB9WosLwnPhnq
 c
X-Google-Smtp-Source: AGHT+IFELUWWAhpjCggFlmxI1DZKgG5hz2CY+PURBYsE82ZBvZvoPQIVUrKcZoaDP9YQfXSBL7wPoQ==
X-Received: by 2002:a81:ca08:0:b0:608:cde6:3dcf with SMTP id
 p8-20020a81ca08000000b00608cde63dcfmr1831985ywi.2.1709133637864; 
 Wed, 28 Feb 2024 07:20:37 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 j205-20020a8192d6000000b006092455230asm1080479ywg.47.2024.02.28.07.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 07:20:36 -0800 (PST)
Date: Wed, 28 Feb 2024 10:20:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, shawnguo@kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>, Rob Herring <robh@kernel.org>,
 =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
Message-ID: <20240228152034.GN3040305@bill-the-cat>
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
 <47c12ca3-ea7c-4097-90b5-0333c74b05aa@moroto.mountain>
 <20240228131029.GM3040305@bill-the-cat>
 <CAFA6WYN4sCk9Q66i_n+aXxRkGEbh66dh+Sr_C5SbioQ_s5BBbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7S49yJbeQ53aXwCx"
Content-Disposition: inline
In-Reply-To: <CAFA6WYN4sCk9Q66i_n+aXxRkGEbh66dh+Sr_C5SbioQ_s5BBbQ@mail.gmail.com>
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


--7S49yJbeQ53aXwCx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 07:44:42PM +0530, Sumit Garg wrote:
> + Shawn, Krzysztof, Conor
>=20
> Hi Tom,
>=20
> On Wed, 28 Feb 2024 at 18:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Feb 28, 2024 at 10:09:13AM +0300, Dan Carpenter wrote:
> > > On Tue, Feb 27, 2024 at 04:40:01PM +0100, S=E9bastien Szymanski wrote:
> > > > Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with
> > > > linux") removed the display timings from the board device tree wher=
eas
> > > > they are still needed by the mxsfb driver.
> > > > Add the timings back (the correct ones) in the
> > > > imx6ul-opos6uldev-u-boot.dtsi file and remove them from the
> > > > opos6uldev.env file.
> > > >
> > > > Update the opos6uldev_defconfig file so that the LCD turns on at bo=
ot.
> > > >
> > > > Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with=
 linux")
> > > > Signed-off-by: S=E9bastien Szymanski <sebastien.szymanski@armadeus.=
com>
> > >
> > > Huh.  This is the commit that did that upstream.
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dd9aa4d4fca67823838fe9861456201430c545e69
> > >
> > > It's interesting how the timings in linux were always slightly differ=
ent
> > > from in u-boot.
> >
> > Thanks for tracking that down, Dan. I'm adding in Sumit and Rob here
> > because this is a recent (rather than ancient) example of one of the
> > concerns about OF_UPSTREAM.
>=20
> I rather think about this as an opportunity to improve with
> OF_UPSTREAM. We can feed these kinds of DT ABI breakages to
> corresponding Linux kernel sub-arch maintainers. Especially once we
> move to OF_UPSTREAM and a sub-arch maintainer profile in Linux kernel
> to keep them aware that U-Boot should be considered too.

Yes, a more extensive check around when removing information from dts
files would be good.

> > I think the commit in question can be
> > summarized as "remove a bunch of explicit HW information because there's
> > now a Linux Kernel driver that determines that dynamically". What do we
> > do next? The old information is in a presumably valid binding still, can
> > we just put it back and comment that consumers outside of Linux use this
> > still so it's not removed again later? Or am I just missing where we can
> > instead get this information from the DT still and not need to come up
> > with a new driver and subsystems?
>=20
> I can see following two paths forward:
>=20
> 1) Partially revert the Linux kernel commit to add back the display
> timings in DT.
> 2) Extend drivers/video/simple_panel.c in U-Boot to add support for
> compatible: "armadeus,st0700-adapt".
>=20
> If possible then I would be in favour of (2) rather than the current
> patch to do this properly.

Well, looking at the kernel drivers/gpu/drm/panel/panel-simple.c driver
and then our drivers/video/simple_panel.c it sure would be nice if it's
just a matter of adding a compatible but I wouldn't be surprised if it
ends up needing more information being passed along too? And I'm going
assume there's good reasons for the design change in how the drivers
work in Linux now and note that it might make things more challenging
for us when we do care about space.

--=20
Tom

--7S49yJbeQ53aXwCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXfTz8ACgkQFHw5/5Y0
tyxPMAv9F7T4/anonGHj2PJpEHSZxCIXBeFO5I6007rix2C3wAwad3j+g3yz2eBh
KVones1XAh4D1QtTCEcWGGTzw0vz+F/rIDx+JWmsT2rO905bRbWTZcKaT5j2W2FM
bMYy4CFSupahX8l/psZc7NSELKNGMbom2GC7+Yjp5w6/u0xI8ddZwOmSaVp8D5FM
/35ymG0EADTii7jR3NWx+m5v4dPpDUvr3ERtxfTHwSvfdx5TxFKKgCq0HafKrnhp
ScN1QWlfSVU85apBxayuhMWwnv9j+5f4M2YPmXpKXZH+xb9CcS5xsiEKk47SsC87
1LT2PTIAWoqQH03w6sJ0bAhQQMAtKQsimEQDgAFKd0qZcm6jHeflf1gBmbzhSWjI
GrTCe0SJeF5G2+2aznbFoeYt2WP1BeN+n+lA8FiLahvRD+Iaj+ZStFF/GJYrNfXF
oRYLMuhnbjKUwKRyncA6YmhGJ5XZ39QsBNa2Ftc1wZ7qnhjifagbEhHUpl22ERP3
VjkIdyzI
=d14D
-----END PGP SIGNATURE-----

--7S49yJbeQ53aXwCx--
