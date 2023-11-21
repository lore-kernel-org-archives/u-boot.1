Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99234C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2B3087582;
	Tue, 21 Nov 2023 15:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MwA0PqdK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D86587582; Tue, 21 Nov 2023 15:03:27 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2795D875DE
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-677a12f1362so19202836d6.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 06:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700575404; x=1701180204; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4/p02L//s7FYysLucvmRskw2doX42GNebb5pkPk93dQ=;
 b=MwA0PqdKz3Hf1wa/2Ip2Dg4gGHElV6S84VnHKte04eUGCwfOhtywl0IbyGYIYSV9Uo
 4E0YDkVwQDR5cbtoFYo8raUtiK61Phb/Cb+qUaItLGhbX8pZcrGHbri3jXveK2l37xxl
 x5223ruzpKOm6+RUdYFTDTSuTIs47P9qac1XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700575404; x=1701180204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/p02L//s7FYysLucvmRskw2doX42GNebb5pkPk93dQ=;
 b=IWkJuV+hFzcOQ7hU4Oa0jit+3A7wHO8x2RdhdJQTlDmER55Xq6Wii3dPsze8fY46fG
 4Haspm58jUCtnTGQ9/zpEqd+hLVCcwrywsj6In8xW29WRiGyDElnHIhEGeo9c8Bz4FaX
 TuEmf6fotI3yjrDhEVmnI0CXDApn13rb3XPjQOu9TbFGE0brOHrhubK29I09sm/d1LUT
 oMFbbpCt046ET9gRO/k5Genkyb5A3XBhmeYzKplZ1EBfuCmqAqGIqr7GhBaxeGkHzmyw
 35PIjwYcs3teR8sku8iT4Fi007KDN22Fvv2r/QPPRNF/emPpyODW1IY8FKvsTDxcvvfb
 BQrA==
X-Gm-Message-State: AOJu0YygD01Gt0iMm5Ugv40+o9KsRS4TT7Wt6YmnzweXi4ZGmSsli5uL
 ScZOb6ljXSTdvCqCGKcJmczFHSeOPJsccu5i5r3GEw==
X-Google-Smtp-Source: AGHT+IGxGD/a06TlsErIBGLZ7HlW/3lTWAs0HQVOv2Zy7Om2pvANKxu/89Z/NSvRF33z8Nal6vM0uQ==
X-Received: by 2002:ad4:5c61:0:b0:66d:1d3f:17d7 with SMTP id
 i1-20020ad45c61000000b0066d1d3f17d7mr16508702qvh.8.1700575403781; 
 Tue, 21 Nov 2023 06:03:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 k4-20020ad44504000000b00678d010774bsm2817843qvu.104.2023.11.21.06.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 06:03:23 -0800 (PST)
Date: Tue, 21 Nov 2023 09:03:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 1/2] global: Clean up arch/*/dts/Makefile
Message-ID: <20231121140321.GT2513409@bill-the-cat>
References: <20231117225214.2144414-1-trini@konsulko.com>
 <CAPnjgZ23gJb6mu53Tmmy9OdaRLu9zCCLgJTGsTVjjKcCv63VqA@mail.gmail.com>
 <20231119202802.GF2513409@bill-the-cat>
 <CAPnjgZ3D_KRDYsA8u5K+kSKAe5n-w2vXMizPTxZphyeavQcbSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7pD6cJEkqVzd56GC"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3D_KRDYsA8u5K+kSKAe5n-w2vXMizPTxZphyeavQcbSg@mail.gmail.com>
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


--7pD6cJEkqVzd56GC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 07:16:12PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 19 Nov 2023 at 13:28, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Nov 19, 2023 at 12:09:07PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 17 Nov 2023 at 15:52, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > With commit 3609e1dc ("dts: automatically build necessary .dtb file=
s")
> > > > we now have logic that will ensure that all device trees needed in =
the
> > > > binary are built automatically. Any device tree that the developer =
needs
> > > > while working can still be built normally via make arch/.../foo.dtb=
 so
> > > > we can simply drop the rest of this logic.
> > > >
> > > > Suggested-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > >  arch/arc/dts/Makefile        |    8 -
> > > >  arch/arm/dts/Makefile        | 1436 +-----------------------------=
----
> > > >  arch/m68k/dts/Makefile       |   18 -
> > > >  arch/microblaze/dts/Makefile |    2 -
> > > >  arch/mips/dts/Makefile       |   37 -
> > > >  arch/nios2/dts/Makefile      |    2 -
> > > >  arch/powerpc/dts/Makefile    |   32 -
> > > >  arch/riscv/dts/Makefile      |    9 -
> > > >  arch/sandbox/dts/Makefile    |    5 -
> > > >  arch/sh/dts/Makefile         |    2 +-
> > > >  arch/x86/dts/Makefile        |   22 -
> > > >  arch/xtensa/dts/Makefile     |    2 -
> > > >  configs/iot2050_defconfig    |    1 +
> > > >  13 files changed, 6 insertions(+), 1570 deletions(-)
> > >
> > > I can see the motivation for this, but it ends up moving us away from
> > > driver model and devicetree, IMO. For example, rk3399 and other
> > > rockchip boards use DT for their init so the same U-Boot can be used
> > > for all, mostly. Ideally that is the way all boards would be, as they
> > > are in Linux.
> > >
> > > But here I have to manually add all the rk3399 boards to OF_LIST for
> > > each board and enable SPL_LOAD_FIT (and SPL_FRAMEWORK but that is
> > > fine) to make this work.
> >
> > How are you doing this today on N rk3399 boards if you aren't tweaking a
> > CONFIG option to get the correct dtb in to the final binary? That I
> > think is where we go back-and-forth on stuff like this.
>=20
> Basically without SPL_FIT_LOAD it works by stuffing the correct DT
> into the final image just before it is flashed. But I do imagine in a
> world where (say) TPL is different for each board but SPL, TF-A,
> OP-TEE and U-Boot proper are the same for each board.
>=20
> But really we need to encourage these complex SoCs to use runtime
> configuration from go to whoa. Where DT cannot be used (e.g. TPL) we
> can do the Zephyr trick or perhaps create a little SoC-specific config
> block which is provided separately and tacked onto the generic TPL
> image. Having said that, TPL images are small, so the impact of having
> one per board is not great.
>=20
> > If there's
> > deconfigs that can support N boards, but only list a, or only a few, dtb
> > files in the right CONFIG variable how do you get it to run on the
> > others? I know you noted some Exynos platforms it's a simple concat to
> > make another platform work instead. But I really don't know how common
> > that is in theory, and even less so in practice. Picking up rk3399, you
> > need bl31 and op-tee and you can only get those so generic too.
>=20
> I understand that they are 100% generic for rk3399. E.g. for TF-A you
> use PLAT=3Drk3399 and that is that.
>=20
> >
> > And part of the issue is that with Linux, the "do board specific things"
> > just gets pushed down a layer, to us. We have to just know X/Y/Z at
> > build time so that someone else can know it at run time.
>=20
> Sure, and naturally that gets pushed down from U-Boot proper (which I
> think is becoming quite generic) to SPL, TPL, etc.
>=20
> If it would help, I could try out (say) rockpro64-rk3399 and
> firefly-rk3399 to show how this works?
>=20
> I know it is tempting to build everything individually, but it won't
> be nice. Binman knows what is needed for each board and can be used
> (one day) to create update files for an SoC without duplication. As
> soon as you give up on the commonality, everything just explodes in
> size, complexity and user confusion.

I guess with all of what you said I still don't understand why we need
the sometimes wrong and not really used lists of dtb files in
arch/*/dts/Makefile. A rockpro64-rk3399-tpl-only_defconfig still needs
to say CONFIG_DEFAULT_DEVICETREE=3D"rk3399-rockpro64" so that you build
the tree so that it's available to binman. We have configs today that
build and support N boards, and so use SPL_LOAD_FIT and are as generic
as they can be. The only thing that this patch here changes is that
you're relying on an implicit CONFIG symbol to list whatever device
trees you want to be built and this patch says that you need to use one
of the explicit CONFIG symbols instead.

If you want to try and demonstrate a more generic way of doing things,
sunxi is probably the best bet for that because there's no TARGET
configs there, everything is SoC + device tree. But it's not making any
use of the lists that get removed here.

--=20
Tom

--7pD6cJEkqVzd56GC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVcuKMACgkQFHw5/5Y0
tyy7Ggv/aIeObZfeXmTzJ2VMrk6bYI8Q7gkTFgLqNHEUbty96kAqrQJ0WEpYSNnl
AVhwq5fcLjntUpiARH7AAV0k3Ck9XoYx1vueG6LYpmhzTAbXZrIU/1JzyOUFjhxm
U2Bj3gNmH5rmP/bnmeXxfTRkJfLt8kv/1h0PIJpwS/sfG4AzLbGw0iDZNY5ObSNW
C2MMlK5JxY6kl5XZP9rxrizk+z44tgndQ4eXpBhuoxfZrQmyXFVP7pISqEx2Lfmo
cScFHM6JQk/JAjGJ++PxEy2Uq1+eSwdzMQOgj9aA8y8RG0O7eDQwJ+ZVHRg2nmrd
JEGP8cs2EGs5SlXlm9t+WPeBl705exAfhTuZ12SU9umKaGD+wnCoj7IHEEoI1Y4b
2xL8v8TU/YdBNdjAqwUGGQvg/pyV/JBXEyaeEjlrKLw8K/sCZlJIZJ28dWOpKkf0
l8zB0reBPuddy3KCs4iw1jCgN5zX464b0QnOq5BMUuAZdRNN1fG7dC6dsiq7l7kM
MaMHbDpT
=Dk2N
-----END PGP SIGNATURE-----

--7pD6cJEkqVzd56GC--
