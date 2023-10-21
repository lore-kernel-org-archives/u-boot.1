Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F90C001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 18:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BE788764E;
	Sat, 21 Oct 2023 20:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cm/pG2Zp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ECA987650; Sat, 21 Oct 2023 20:26:21 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F2E587642
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 20:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-66cee0d62fbso13640496d6.3
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 11:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697912775; x=1698517575; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lWnqrnijcCqHsGNz0H0/O2JnKfxmrQq9GdRtkqE4Rq4=;
 b=cm/pG2ZptW1K0wR7w88WDkZ9S6iMpN5Dco786w0vpKzodAz7jMn0Fi0S3Un4VJiRyM
 rFzae2wmUPrUVOa5agFrr0wADimg84fUjJEYVONAJAMbe4No+gXMcATFS380rifFIqNx
 GUVLn0ClBW51WP5YJH8aCIX9QvajpBSvOlmjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697912775; x=1698517575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWnqrnijcCqHsGNz0H0/O2JnKfxmrQq9GdRtkqE4Rq4=;
 b=JYa7XgAUEZpJ0vPOJiWAUZTaNPWaiwjgukIGyBout1zeFQ6w5qqFJdos7cQhSJGhZa
 A2D/0sA51pGFz7fntRcbs+E4IvVs7VpoRhcBmBCxbCReJ2Wu1t7Xj0kt3PIjtINJ86QH
 KgTMW0q0epEzWx7nEoOloswY+N1iJg9frbVtAnt9jbR6192iKOQwDyEpk5GtiDFRg7eW
 BY6vuONx6XEtNFwrpc6pVPhqDik+OEW5J5s6Thy/nmSILQ9t54mViv1rTEdKLYuH/tRR
 xFHEidE7VFhY2EF+Br7nqzuVI8uEtTYNXODiDCSFho2x271VxhMIbem7ntI9Aqs4Jhxx
 tFrA==
X-Gm-Message-State: AOJu0Yw2vZrzKd2zsgxRqeijz/eR6zxMIZESoUNgy2gkwU9vi5p1B5dj
 pogRPWpUcUGKPzE8M3hAs+EJ2A==
X-Google-Smtp-Source: AGHT+IEYd0hfDTr2bHpKS2rv4lNyD4S7jmz4DBfZh8oavNPpgt1qAKLrLAV7ZL/70vl3sVolsLJYRw==
X-Received: by 2002:ad4:5e87:0:b0:66d:11fd:c9c2 with SMTP id
 jl7-20020ad45e87000000b0066d11fdc9c2mr8234126qvb.17.1697912775283; 
 Sat, 21 Oct 2023 11:26:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d02f-b9d9-0a79-793c.res6.spectrum.com.
 [2603:6081:7b00:6400:d02f:b9d9:a79:793c])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a0cd60f000000b00658266be23fsm1607022qvj.41.2023.10.21.11.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 11:26:14 -0700 (PDT)
Date: Sat, 21 Oct 2023 14:26:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Message-ID: <20231021182612.GA53397@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231017140925.GB3119521@bill-the-cat>
 <cac1ad58-5a7a-41fd-84db-f972609f95c6@gmx.de>
 <CAPnjgZ2tJEBNWsx_tLDTWyQ+xNyLj6feDenqEcCe+t3JNEdv8g@mail.gmail.com>
 <ZTHKKurIp67bx2MJ@octopus>
 <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tcTzDm0OUEcOL1aA"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
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


--tcTzDm0OUEcOL1aA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 08:43:08AM -0700, Simon Glass wrote:
> Hi,
>=20
> On Thu, 19 Oct 2023 at 17:30, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
> > > >
> > > > On 10/17/23 16:09, Tom Rini wrote:
> > > > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
> > > > >
> > > > >> Since efi_device_path.c calls eth_get_dev() and assumes that Eth=
ernet is
> > > > >> available, add it as an explicit dependency.
> > > > >>
> > > > >> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >> ---
> > > > >>
> > > > >> (no changes since v2)
> > > > >>
> > > > >> Changes in v2:
> > > > >> - Add new patch to update EFI_LOADER to depend on DM_ETH
> > > > >>
> > > > >>   lib/efi_loader/Kconfig | 1 +
> > > > >>   1 file changed, 1 insertion(+)
> > > > >>
> > > > >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > >> index 13cad6342c36..fca4b3eef270 100644
> > > > >> --- a/lib/efi_loader/Kconfig
> > > > >> +++ b/lib/efi_loader/Kconfig
> > > > >> @@ -11,6 +11,7 @@ config EFI_LOADER
> > > > >>      # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> > > > >>      depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> > > > >>      depends on BLK
> > > > >> +    depends on DM_ETH
> > > > >>      depends on !EFI_APP
> > > > >>      default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8
> > > > >>      select CHARSET
> > > > >
> > > > > Does this work for you Heinrich, or do you want to clarify the
> > > > > dependencies (and re-organize the code as needed) around networki=
ng?
> > > > >
> > > >
> > > > We should be able to boot via EFI on devices without U-Boot network=
 support.
> > > >
> > > > We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid invoking
> > > > eth_get_dev() if there is no network. CONFIG_NETDEVICES=3Dy selects
> > > > CONFIG_DM_ETH.
> > > >
> > > > Why is this not sufficient?
> > > > Is there a configuration that does not build?
> > >
> > > The point of this series is to disable CMDLINE and fix up what breaks.
> > >
> > > In this case we have some sort of breakage...perhaps Tom has already
> > > found it, but otherwise could you take a look?
> > >
> > > We should be able to disable NET and LTO in sandbox and still build.
> > > But this fails at present[1]. You can try it on -master
> >
> > Obviously, it would be necessary to enclose efi_dp_from_eth()
> > with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
> > Then, we could drop "depends on DM_ETH".
>=20
> Strange that it only happens on the non-LTO board, though?

There's two issues. The first of which is that I think you need to
re-check your error exactly? With my series, and LTO also disabled the
problem is a call to efi_get_image_parameters() as that's defined in
cmd/bootefi.c, but also only used with cmdline invocations. So we can
fix that CMDLINE=3Dn && LTO=3Dn case with a IS_ENABLED(CONFIG_CMDLINE)
around that, and then discard efi_dp_from_name() entirely.

The second issue is that with LTO we more completely find the cases
where if x() calls y() and y() is undefined but nothing calls x() we can
just discard x() and not care that y() is undefined.

--=20
Tom

--tcTzDm0OUEcOL1aA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU0F8AACgkQFHw5/5Y0
tyzdhQwAgBKmPWSLzPvkpf7tEYzcbWyuwSma8tspDHJKed3A6JUlG+0HJSuRopkG
/WT2GpO1xyUPvgtipkzE9Z8Q2XoohTbAfVrxvbehOV1l7BZaBuCrwUH2N0QyFzeJ
6pj4D3or09EhHn5oaKLrlvMalcNGoeVpt/pPlICaolJYc+j9wgVsHsdt2jCmyZ4G
c6pf9xt7281uHFt6kcHBO/xJ9KgNPkeLzyuN9WL5RtGcqO6fi7RAovXo/blGUoRe
A6NJK+2ObxYRmCh63cNusM++u9QgB3uyErmXssU9iANmYbu3CgEPeAdqK8Zs+StR
Qlgy8GIaZnw41cFpHp3LZQ4EqSffY/u63zsaQ5UJh6sbtJT8e+LSXffm3uxRWhsd
qd7QPqm8iIYujEsnCQpUo80+ENBHeZ1N6XK0O8Au5n7nr09aEzcT+3qfiaDsgKhF
T8EFed10Ngj7tRvMHlN0EKZEDuVkeKatTEAWk90LccZxpQnXj4b1OwGcM1mQDkcr
XQjvqVuT
=LfcF
-----END PGP SIGNATURE-----

--tcTzDm0OUEcOL1aA--
