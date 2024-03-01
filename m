Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B204C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 18:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14DC788155;
	Fri,  1 Mar 2024 19:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tj5tJXMv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC1188155; Fri,  1 Mar 2024 19:54:22 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A01618816F
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 19:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-60821136c5aso19000857b3.1
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 10:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709319256; x=1709924056; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o8i0qqXUnIhq33bpYfad/EzCcijQh8iuICSKW3xc3K0=;
 b=Tj5tJXMvpsmBMZFGf+MlFXZMy4eQge2UDo5YXqmJ0AB8Y5MBRvoKebXes4GKxWzSZz
 8+JHexlyDpOuLugnFfxl1ywlJ4abDz9/QiCrbOOjxh7wt+2m7YdJHOL8/p2LNG3V/D6z
 5kXTGgRcF0HGe53pJdNh+PfWYLsXGZpp4Q4qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319256; x=1709924056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8i0qqXUnIhq33bpYfad/EzCcijQh8iuICSKW3xc3K0=;
 b=WH86JLJdgpo3r2h208sFlpJacOAT1zs8q41VWWaXiWR19Ki3SvrPofUt39YSrZxUHt
 8JoiBCKQPNUdvjQBRxXZ0WhNCRO3FB3gAZLSghbYVeSQNAcuxiJ910SNvHhl4jZ4xMSU
 k6eLtKFLvEwq+b1oKjYj1Ulo9qR26EPLJ9GDsMGu33Rf9/vV1/iJdznlc8Pj4wRt1Jhp
 b94W8EdEiGeIE6Co/KpVg+F6cFnqloLzCheL3bflNai+TVS2m6mSgWS92aKyanq1rLFu
 O3VxdaBc/CZzIS0udv3ti8WpPensYAqIoUiF9WXRrg8gqnNttBMIJpZyUPOyrBL2i5/O
 03ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv9OhmB0TQ+Ly3fNBAwKEl16YbuhuWtA+5HRJxOZy9bf7rRpPfBYtQbs9Brzd1fAJgB0dhq1Hn/Xi6ETN0lf9GmijjZA==
X-Gm-Message-State: AOJu0YxZ/9tnCEsIX7X1W2hKhhxVFkyYzbu4Bqu5TsmQ2enNLBXFPz9f
 X6zTkrV6Yir9f0IqHRMFVcN+jXIVAGzO/y8ZzmhOY1x+IfdM0S5JxiF9AQcU8AU=
X-Google-Smtp-Source: AGHT+IFCK8AaVwCm/CWIFVzCHQlDAvGuIdDMjcRAmXTRq15wLZxlAJqkrduh1sDqCjlExcepK7TVxw==
X-Received: by 2002:a05:690c:f8f:b0:609:708d:3a6e with SMTP id
 df15-20020a05690c0f8f00b00609708d3a6emr2818670ywb.12.1709319256297; 
 Fri, 01 Mar 2024 10:54:16 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 u144-20020a0deb96000000b0060976eae3b8sm860136ywe.140.2024.03.01.10.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:54:15 -0800 (PST)
Date: Fri, 1 Mar 2024 13:54:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, 
 Sumit Garg <sumit.garg@linaro.org>, shawnguo@kernel.org,
 Fabio Estevam <festevam@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Rob Herring <robh@kernel.org>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
Message-ID: <20240301185413.GF3040305@bill-the-cat>
References: <47c12ca3-ea7c-4097-90b5-0333c74b05aa@moroto.mountain>
 <20240228131029.GM3040305@bill-the-cat>
 <CAFA6WYN4sCk9Q66i_n+aXxRkGEbh66dh+Sr_C5SbioQ_s5BBbQ@mail.gmail.com>
 <20240228152034.GN3040305@bill-the-cat>
 <CAFA6WYMkdjE6Vrd2_fV_6Rzj8MOiPhO4EJ4kkik1_9vQnhzMqQ@mail.gmail.com>
 <20240229134242.GR3040305@bill-the-cat>
 <20240229140140.GS3040305@bill-the-cat>
 <CAFA6WYPkSd=roYiZrK-9oKOse+zTsbtBj8mrgV=HHFVHtCwHGg@mail.gmail.com>
 <3f6e7fef-b1ee-4c1a-9ca6-fad4959631b3@armadeus.com>
 <20240301-unstuffed-sixtyfold-0a875a031043@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6yAVRrZ8msL29tKy"
Content-Disposition: inline
In-Reply-To: <20240301-unstuffed-sixtyfold-0a875a031043@wendy>
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


--6yAVRrZ8msL29tKy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 01:32:53PM +0000, Conor Dooley wrote:
> Hey,
>=20
> Replying here because this is only version of this in my inbox atm.

Please note that for additional context, in 2019 when d9aa4d4fca67 ("ARM:
dts: opos6uldev: use OF graph to describe the display") was merged
re-sync of DTS files to U-Boot was a best-effort per platform and
infrequent. As of yesterday we have devicetree-rebasing included as a
git subtree and platforms can and should switch to using that, and that
tree will be updated every U-Boot merge window. So I wanted to ask a
broader question in this thread about how to handle dts changes break
U-Boot functionality, and have an example that wasn't ancient (the
serial problem from 2013 or so) nor incorrect PHY mode was specified in
the dts file to start with.  This thread is that example.

> On Fri, Mar 01, 2024 at 10:17:35AM +0100, S=E9bastien Szymanski wrote:
> > On 3/1/24 07:02, Sumit Garg wrote:
> > > On Thu, 29 Feb 2024 at 19:31, Tom Rini <trini@konsulko.com> wrote:
> > > > On Thu, Feb 29, 2024 at 08:42:42AM -0500, Tom Rini wrote:
> > > > > On Thu, Feb 29, 2024 at 11:17:28AM +0530, Sumit Garg wrote:
> > > > > > On Wed, 28 Feb 2024 at 20:50, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > > On Wed, Feb 28, 2024 at 07:44:42PM +0530, Sumit Garg wrote:
> > > > > > > > On Wed, 28 Feb 2024 at 18:40, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >=20
> > > > > > > > > On Wed, Feb 28, 2024 at 10:09:13AM +0300, Dan Carpenter w=
rote:
> > > > > > > > > > On Tue, Feb 27, 2024 at 04:40:01PM +0100, S=E9bastien S=
zymanski wrote:
> > > > > > > > > > > Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise dev=
ice trees with
> > > > > > > > > > > linux") removed the display timings from the board de=
vice tree whereas
> > > > > > > > > > > they are still needed by the mxsfb driver.
> > > > > > > > > > > Add the timings back (the correct ones) in the
> > > > > > > > > > > imx6ul-opos6uldev-u-boot.dtsi file and remove them fr=
om the
> > > > > > > > > > > opos6uldev.env file.
> > > > > > > > > > >=20
> > > > > > > > > > > Update the opos6uldev_defconfig file so that the LCD =
turns on at boot.
> > > > > > > > > > >=20
> > > > > > > > > > > Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise dev=
ice trees with linux")
> > > > > > > > > > > Signed-off-by: S=E9bastien Szymanski <sebastien.szyma=
nski@armadeus.com>
> > > > > > > > > >=20
> > > > > > > > > > Huh.  This is the commit that did that upstream.
> > > > > > > > > >=20
> > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvald=
s/linux.git/commit/?id=3Dd9aa4d4fca67823838fe9861456201430c545e69
> > > > > > > > > >=20
> > > > > > > > > > It's interesting how the timings in linux were always s=
lightly different
> > > > > > > > > > from in u-boot.
> > > > > > > > >=20
> > > > > > > > > Thanks for tracking that down, Dan. I'm adding in Sumit a=
nd Rob here
> > > > > > > > > because this is a recent (rather than ancient) example of=
 one of the
> > > > > > > > > concerns about OF_UPSTREAM.
> > > > > > > >=20
> > > > > > > > I rather think about this as an opportunity to improve with
> > > > > > > > OF_UPSTREAM. We can feed these kinds of DT ABI breakages to
> > > > > > > > corresponding Linux kernel sub-arch maintainers. Especially=
 once we
> > > > > > > > move to OF_UPSTREAM and a sub-arch maintainer profile in Li=
nux kernel
> > > > > > > > to keep them aware that U-Boot should be considered too.
> > > > > > >=20
> > > > > > > Yes, a more extensive check around when removing information =
=66rom dts
> > > > > > > files would be good.
>=20
> Whenever people remove things from bindings (or from being required) we
> do ask them "have you checked that there's no users for this outside of
> linux" - but for me at least I don't apply that scrutiny for most (read
> arm{,64}) devicetrees. There's just too much volume if I went asking
> those questions on every removal, it's up to the platform maintainers to
> keep an eye on that.
>=20
> That said, modifications to a devicetree are fixable with a revert,
> while modifications to a binding may not really be fixable in a way that
> isn't disruptive for some user, so I think that I am spending my time
> wisely.

I agree that so long as reverting dts changes, even after a release
includes them, is possible, it's not the end of the world and we can all
manage.

> > > > > > > > > I think the commit in question can be
> > > > > > > > > summarized as "remove a bunch of explicit HW information =
because there's
> > > > > > > > > now a Linux Kernel driver that determines that dynamicall=
y". What do we
> > > > > > > > > do next? The old information is in a presumably valid bin=
ding still, can
> > > > > > > > > we just put it back and comment that consumers outside of=
 Linux use this
> > > > > > > > > still so it's not removed again later? Or am I just missi=
ng where we can
> > > > > > > > > instead get this information from the DT still and not ne=
ed to come up
> > > > > > > > > with a new driver and subsystems?
>=20
> I don't think this is an accurate summary. The "explict hw information"
> was never allowed for an imx6ul, only for some older devices, so "the
> old information is in a presumably valid binding" is not accurate.
> See 7b920aae917d ("dt-bindings: mxsfb: Add new bindings for the MXSFB
> driver") for when doing things that way was deprecated. The imx6ul was
> only documented several years after it was introduced (so likely several
> years after it started incorrectly using that binding).
>=20
> Seeing that, I am not sure that I would even question the kernel patch
> cited above, the change was done for binding compliance and I would not
> be inclined to think twice, given the bindings are the ABI.

So part of the problem I see here is that legacy platforms (which to me
is a large chunk of 32bit ARM) are trickier. I'm not asking for anything
more to be done in this example to be clear (I think the new panel-dpi
binding is what U-Boot needs to implement and solve the issue here).

But I don't think the fact that the old binding was handled
suboptimally means that its usage should be ignored. They were added in
2017 which is after they were deprecated and not caught then. I consider
that to mean it was still valid. And I also assume that today we have
the tooling to catch that and not let it in, in the first place.

Time will tell now how bumpy a ride things end up being as I do agree
that getting all the DTS files following the ABI correctly is an
important goal.

--=20
Tom

--6yAVRrZ8msL29tKy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXiJFUACgkQFHw5/5Y0
tyzAaAwAj9dXFIOri6j6U4KqTnNTCbpBu3wfx8X5cACHK2UYQkQPDAUtxGPnSPxG
j+X0vkz1233oN8d0lQIx4d2iO10aYgVqZovwNb/gKUkIvIRIDQ6ulTwAWaG1MeI4
FnxDj+jiO4zSgO3cXDzUpfPsfiKUqGSbXcZTZIcRHSml4ChTaOiWzUuZVJmmZwgr
bUDSMLdrtU/29945VAie0/PcT+m8RA1dHSyQ6/w77HRQlkQVUSaPvlev7TCbVTwx
ciA6tR8EbMc12xda00t2wzTOIqaSRyFhzU7j6I3+xsX8/llrMLT1ZBsAWWYuNJrm
9RhWJ1NI1jQuW8L0jJMg4Gv1ceqBcNvw7sioYvULGo9xOqbgOYeV49xoB0mscE78
Z4Xj/y5MhKMpODEBzoe1Ih/nFshynVCvmQgwd89TEtcKYVzXTc1324Ldti+kX+Ic
3bcl9jGQUwjLFIyLMqBtiVEMYPN2YP7qb22l94AdSYJNHvX3IOymvX0Y9RRoq0Bz
xKtJSdwW
=VadY
-----END PGP SIGNATURE-----

--6yAVRrZ8msL29tKy--
