Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9718FCCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 23:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFAB783804;
	Sat, 18 Oct 2025 01:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TtWUrjfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE87C8382E; Sat, 18 Oct 2025 01:00:22 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F0C9836D1
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 01:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-651ccdf5d0eso428424eaf.0
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 16:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760742019; x=1761346819; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DJlS/HiBu7fhxhxxwoIVS2qrQUppxXj+jFiEu4dapik=;
 b=TtWUrjfl05Q6Xu6lOVGNKZnioJpF7eY3e2RgjfMQJ+kxBhdRll/RSuVgpokq2hZhmv
 aNs/ujASjgNARnkPXfMi2bxS2qXjbu0NijrFr08OiOTSN/+Z4Wx1BWecFtt+5x655Bi5
 qbIfP1kGL43Q/3sgovnV7Paf6mESzmPg39wtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760742019; x=1761346819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJlS/HiBu7fhxhxxwoIVS2qrQUppxXj+jFiEu4dapik=;
 b=I5VOmMz8sIB3Rwo8+7WP4Bnq4/mBegK44GdwjdhkmGEOuW64ZBRLbLoM9NkkEIrWln
 cEvdUq08hjsCPROsckBr62GDlkJnwEpwsGdLHgW/358BJ/x775wVtLbdsAtt52R/XBrO
 j99E/2OmxaHVmqqa23ySLmGHdXADKy+R+AMPZwAzuZ0k5fiAidREQPqAnCsswUT0plSn
 9UUVNDzJYqyku4lVy9SJJ+dLfeM0lqhyS4bosyD8PJlvNFRFfBkQAgQwXOywF5TwnjUr
 MJu7f5Awf6IoaiHxk7TFrRHMsJMUdhXIQieKI88k9pTneKmnps5hqzY81rrBzg6F2Kkl
 tYaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTAh80n63PhWA+gFcUbWy6sIWbyn6jj428jvehK+nihRN6DgBG+xxxQVlBzIQbpIKdglFbHGU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+8jqP/raWLnqVu4UA45qK/RU2HyLfNskWPvjvgx+Ft74rH75Z
 C+DqWWLiCSUAPzRDBR8XWu974fcm1uKG16bL2bZ+1/CsTQiO60km4k1A23p7Y9AQNQw=
X-Gm-Gg: ASbGncvctJwycTv1bqFSx37i/bZ4ezKm8SlO2iZcXwCk0dJW+GRHgyplhi8JC9HCelO
 ngcioH0ws5DdjuPrxxzB+QnQcjyckcgsNsU0zPfJ9OufH1RGTg0KDddTkxZVSPK8BBmqB6qU0UA
 poH7lSFI7Xr9RurniDnJYxxtqYb0g40TgVxe99/0fF419efTmnF7mSO004wMGelQhBRQ7Sce4nj
 5j2psrr7fTmIWfLaRoMuP/QKw2xQvMCrI1IHrNQz1IiEyJXpSxa3ZIJ7Q8zySCQ5nzTihZO6ABn
 G5KOFiGxxsidyC/jStDAjbrvG85UD18rxdhf5hkoLSBQAaGA+cic2Hxe4p0tq+Xb5USHoXWMtAY
 8D5dcv3SXbdwBK+W8P5ZIqrWu9QKiATBaWoYiSh+FIl/ZecdZyt9eWkXGCbDEz5Pn43bnWBObFl
 Mq6WL+uUwculW0V46FDqChOR7GjwDld0I7ZMDii+s=
X-Google-Smtp-Source: AGHT+IFGX/YbYAnuzdqj97oed1fUneJeSCGkinN+AAkqfQaaBgeFsRdOxDg9x3+KTZxu97TUjgRcww==
X-Received: by 2002:a05:6808:2388:b0:43f:5fc5:e04a with SMTP id
 5614622812f47-443a30af9cfmr2208759b6e.31.1760742018856; 
 Fri, 17 Oct 2025 16:00:18 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443dcaf222fsm213392b6e.9.2025.10.17.16.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 16:00:17 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:00:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC] lib: optee: forbid OP-TEE OS loading without adding
 OP-TEE OS reserved-memory nodes
Message-ID: <20251017230014.GM6688@bill-the-cat>
References: <20250919-tee-env-needs-optee-lib-v1-1-2d52e75f7580@cherry.de>
 <20250919161009.GX124814@bill-the-cat>
 <90dbc926-fe8e-47f2-8bb3-abed563742d0@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z9jYBdtCPfiAGhSJ"
Content-Disposition: inline
In-Reply-To: <90dbc926-fe8e-47f2-8bb3-abed563742d0@cherry.de>
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


--z9jYBdtCPfiAGhSJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 11:29:07AM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 9/19/25 6:10 PM, Tom Rini wrote:
> > On Fri, Sep 19, 2025 at 05:50:21PM +0200, Quentin Schulz wrote:
> >=20
> > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > >=20
> > > It is currently possible to build an image with an OP-TEE OS (via the
> > > TEE environment variable) without OPTEE_LIB. U-Boot will happily load
> > > the TEE OS and the next OS (e.g. the Linux kernel).
> > >=20
> > > This is an issue because on FDT-enabled devices, OP-TEE OS adds nodes=
 to
> > > the reserved-memory FDT node for the memory regions it just reserved =
for
> > > itself. This updated is then passed to U-Boot proper which should know
> > > better not to use memory from there. The actual issue is that without
> > > OPTEE_LIB and OF_LIBFDT enabled, U-Boot proper will not copy those no=
des
> > > over to the next OS's FDT before starting it. This results in the next
> > > OS's (e.g. Linux kernel) to not be aware of reserved memory, incurring
> > > random crashes or device reboots when it tries to access secure reser=
ved
> > > memory area.
> > >=20
> > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > ---
> > > I've just lost a day trying to figure out why my board suddenly boot
> > > loops when running a specific program in Linux userspace after updati=
ng
> > > U-Boot. I actually inadvertently had the TEE environment variable set
> > > for a device which doesn't actually need to run any TEE OS (so had
> > > OPTEE_LIB disabled).
> > >=20
> > > This device is Rockchip PX30-based and the image is built with binman
> > > like all Rockchip-based devices.
> > >=20
> > > The issue is that I built a U-Boot FIT with an OP-TEE OS that reserves
> > > some memory regions for itself (via the TEE environment variable) but
> > > U-Boot proper "forgot" to propagate those to the Linux kernel's FDT
> > > (because of the missing OPTEE_LIB).
> > >=20
> > > Unfortunately, binman doesn't seem to have access to Kconfig symbols
> > > (grep CONFIG_ doesn't return anything meaningful and binman is either
> > >   configured through FDT nodes or via CLI arguments, c.f. cmd_binman =
in
> > >   the root Makefile) so I cannot try to be smart and guide the user to
> > > the correct Kconfig option to select if TEE is set. I could add a
> > > property based on the presence of OPTEE_LIB in rockchip-u-boot.dtsi f=
or
> > > example and have a custom message based on that, the issue is that I
> > > assume all FDT-based platforms do actually need to do this dance, and
> > > not only Rockchip.
> > > Another option could be to add a CLI argument to binman through which
> > > we would pass the state of OPTEE_LIB and error out the build in that
> > > case, but that feels like opening the door to dirty hacks (though this
> > > patch is admittedly another dirty hack :) ).
> > >=20
> > > Another option is to propagate the TEE environment variable to the
> > > preprocessor of the FDT (via dtc_cpp_flags) and then I can do
> > >=20
> > >   #if defined(TEE) && !IS_ENABLED(CONFIG_OPTEE_LIB)
> > >   #error "CONFIG_OPTEE_LIB must be enabled!"
> > >   #endif
> > >=20
> > > but we have the same issue as above, it is then Rockchip specific and
> > > also feels bad.
> > >=20
> > > Another option is to remove the @tee-SEQ node from the binman FIT
> > > description when OPTEE_LIB isn't set but then I would lose the nice
> > > message when no TEE is provided:
> > >=20
> > > Image 'simple-bin' is missing optional external blobs but is still fu=
nctional: tee-os
> > >=20
> > > and even worse, build without any TEE OS even though I could provide =
one
> > > with the TEE environment variable.
> > >=20
> > > Finally, another option could be to move this hack under
> > > arch/arm/mach-rockchip/Kconfig to make it Rockchip specific or add a
> > > depends on ARCH_ROCKCHIP
> > >=20
> > > OP-TEE OS on Aarch32 Rockchip boards doesn't actually need any of that
> > > if SPL_OPTEE_IMAGE is set because arch/arm/mach-rockchip/sdram.c then
> > > marks some hardcoded memory regions in RAM as holes in DRAM, which has
> > > the same effect as reserved memory regions I guess. I assume other
> > > platforms may use something different, so it may be casting too wide =
of
> > > a net.
> > >=20
> > > Does anyone have something more delicate than this sledgehammer of a
> > > solution?
> >=20
> > It looks like on other SoCs there's an ARCH_x wide imply/select OPTEE
> > (which in turn gets OPTEE_LIB), so is there a case for ARCH_ROCKCHIP &&
> > !ARM64 && !OPTEE ? I see you explained that 32bit has a workaround for
> > this already.
> >=20
>=20
> The issue is that on Rockchip you don't need OPTEE to be selected for the
> OP-TEE OS to be integrated in the U-Boot FIT image. You simply set the TEE
> environment variable to the path to the bl32 binary and it's going to
> include it in the U-Boot FIT.
>=20
> I think this is actually a good thing to be allowed to have the OP-TEE OS
> image **without** the OPTEE driver being compiled: if I want OP-TEE OS to=
 be
> loaded in the system, this will be done by the SPL by loading the binary =
at
> a specific location in RAM, but I may not want to increase the attack
> surface by enabling the OP-TEE driver in U-Boot if I don't need to intera=
ct
> with OP-TEE OS from U-Boot at all.
>=20
> The Aarch64 Rockchip SoCs also do not require OP-TEE OS to work (but I
> **think** Aarch32 SoCs do?). "imply" in that case would not be enough
> because we would still be able to include the OP-TEE OS image in the U-Bo=
ot
> FIT without OPTEE driver compiled in (and thus OPTEE_LIB). "select" would=
 be
> too strong, because we really don't need OP-TEE OS (or rather its driver,
> but the latter kind of implies the former) to be in the image in order for
> the kernel to work just fine.
>=20
> It all boils down to the ability to add OP-TEE OS to U-Boot FIT via the T=
EE
> environment variable without changing the defconfig (i.e. it's optional).=
 We
> could make the @tee-SEQ node in arch/arm/dts/rockchip-u-boot.dtsi presence
> depend on OPTEE_LIB for example, but then we wouldn't be able to tell the
> user that the TEE OS image is missing. Also, this would limit TEE OS to
> OP-TEE OS (which I assume is probably what everybody is using on Rockchip
> but we could be using something else technically?). That may be an
> acceptable limitation though!
>=20
> As for forcing OPTEE_LIB on Aarch32 Rockchip SoCs on, this OPTEE_LIB thing
> relies on OP-TEE OS patching the DTB passed to U-Boot proper so that the
> reserved memory nodes for OP-TEE are made explicit. I somehow doubt this =
is
> necessarily handled by OP-TEE blobs from Rockchip? Which means that I'm n=
ot
> sure that switching the hardcoded implementation to use the logic in
> OPTEE_LIB will be enough.
> This also reminds me that TF-A blobs from Rockchip (used to?) crash for s=
ome
> DTBs, which was worked around by simply just no passing the DTB to TF-A (=
see
> SPL_ATF_NO_PLATFORM_PARAM), which I assume means OP-TEE OS doesn't have
> access to a DTB so cannot patch it. I'm not sure how (if!) it is handled =
by
> U-Boot in that case.

Getting back to this, thanks for detailing the explanation. I could not
think of a more clever way to deal with the problem you're describing,
so whatever you think looks sufficiently clean, please non-RFC and this
is a case where a long commit message is likely good for future
reference in case someone wants to clean this up. Thanks!

--=20
Tom

--z9jYBdtCPfiAGhSJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPLKdgAKCRAr4qD1Cr/k
Ct/mAQCci6zim9e1VAfFsbuN24CTqj03mtbsf5z6p+tW43ruBwD/UYDVrPCFYQn8
SXmcbVQLQSaAz+mV9eJTjY4BlfKKDAA=
=tF99
-----END PGP SIGNATURE-----

--z9jYBdtCPfiAGhSJ--
