Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E87BFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC2484687;
	Mon,  4 May 2026 20:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TEyAou21";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADB48467A; Mon,  4 May 2026 20:04:39 +0200 (CEST)
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C80D84686
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so3172861fac.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777917873; x=1778522673; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yfk0hCmy80+fh0FlntF1tRv/EvPPiI5wsdih5eriD+g=;
 b=TEyAou21Q2WIYO6e15zE2Gs7OkTvwrHIkPe9RpFxdBQApuNxg9wGSmtVU5ql7VNO1n
 VBHnsdVHSl3bCID5+SfEtrkD2JWjmmfxosA4MeQw3ZWk4eAlI8qyJln4GZuOF2HrWFwz
 x00sRqm263CqpniqxBbwoShR5HvReUXyQON7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777917873; x=1778522673;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfk0hCmy80+fh0FlntF1tRv/EvPPiI5wsdih5eriD+g=;
 b=jvu5AYiT24u+o7Jz1JEb1Vf2NDEqcr56yGtff/39qfUYeadGp81RYjWeFTtoJxrMzl
 l2JaFIK07QDEwTW3WnqJlPlJzDqVCgU2fpzCAzK5fSfpuToA+48f+VmD05ajt1CYo9Uh
 WRq1go8AOSMzHOL2hDjlzDavDHS0Dyh35UUmIm4AAMSaQVyLCR4tgw1R4xO6Z9VjvKh1
 79J5yGcKwporskpO6PWx3EHtp2sdqMX+7sb0KoZtA6qCltrHjGO7rEax9MlCRWyxl4r0
 hwewDlNIISckaX6f0T/RH/QokBqhinpszUD7e297/XQ00VThOUgE+jhhVOHJZYZAN1bB
 VSFA==
X-Gm-Message-State: AOJu0Yzm3iXbWsWAVmE9rh41VOHhyQvp/ZvO9EvHKbvg0xH4cTjliwHM
 SveyzNshUOsW5gHrVa54xutwY2abXMHvIpGbzZ3Wz/SjeCe1icOf4PYdrmrbbA1v3U8=
X-Gm-Gg: AeBDietxyWo2geZG6fVbuBecKAMvd56XdUHv5sePTD71ZYzm5a06dalwq75F1IvJfHO
 nvrRT+Gu75bbtmcw+qSP72vlsV/kmlEzzXyjlnS4Glyyu68Fs0wPGWVIqkCLbKrF9hlXAqdYUUK
 TPA/hzNRoqqNla/07i0JTJvYxnT3PJ78+y//2mSBI5H7m+CC806Inl0rhMeq8BK1sopAp8Zj7yN
 suoloY/XRjIZOEgMT++kSKbrBMcHPsDLCHaBbEUm8gRKbcD3qj7siZlcvWHosdQzNbrmeUspa+0
 GOwSCNqBvJX7XCL6Eu3jb3ZZCFhNgQp5BgPTp8TC4CDRDnKexTmO3PjLtyKd345o7uk00kSGNbw
 PVufWhmgNBTKxNINbOweVS66OBjHaVBXDwe2f6ab3883GGWZ9nTfAQpsnfoseyJ70W/hCjPmmgP
 +ImheiBr+8D1dFwrDMwflHCaHj54AYF58uYAf0Jjq6cDhohnG+zjFdw523S5+ibz0xZgvZyFRPW
 Y10slBqeC30u2zpwKDDpjM2SoJCOKvkf0zML/IsXE6MEXPmFvCRv+/4xIJFDA==
X-Received: by 2002:a05:6870:89a2:b0:430:3ddf:9712 with SMTP id
 586e51a60fabf-43475f950c4mr5879137fac.5.1777917872930; 
 Mon, 04 May 2026 11:04:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454cbd8dbsm11433727fac.11.2026.05.04.11.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:04:32 -0700 (PDT)
Date: Mon, 4 May 2026 12:04:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <simon.glass@canonical.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH RFC next 00/18] sync scripts/Makefile.extrawarn with 6.1, 
 enable WERROR for host tools
Message-ID: <20260504180429.GJ1614990@bill-the-cat>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zoEmg6758z+9ZUHj"
Content-Disposition: inline
In-Reply-To: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
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


--zoEmg6758z+9ZUHj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2026 at 03:20:27PM +0200, Quentin Schulz wrote:

> I ended up being surprised host tools aren't compiled with -Werror even
> when CONFIG_WERROR is set.
>=20
> While this is an issue for local builds, buildman (used in CI) adds
> -Werror to KCFLAGS and HOSTCFLAGS when passed -E (or
> --warnings-as-errors), which we do, see
> 'build all platforms in a single job' job and &buildman_and_testpy_dfn
> template.
>=20
> It turns out that even though we claim to have synchronized our kbuild
> with Linux kernel v6.1, some of it was stuck to v5.1 +- some partial
> backports. This doesn't attempt to update everything that isn't in sync
> with 6.1 though!

Thanks for doing this. Having done a few of the previous re-syncs it's
always hard to find every file that needs to be updated.

> The first two patches are for fixing pytest calling make directly on a
> "dirty" build directory as generated by buildman using the clang-20
> toolchain, but pytest does not set HOSTCC and CC to clang-20, resulting
> in clang flags being used with gcc).
>=20
> One can simply reproduce it (after backporting up to patch
> "scripts/Makefile.extrawarn: sync with 6.1") by doing so in the
> container:
>=20
> make HOSTCC=3Dclang-20 CC=3Dclang-20 O=3Dbuild/sandbox sandbox_defconfig
> make HOSTCC=3Dclang-20 CC=3Dclang-20 O=3Dbuild/sandbox -j`nproc
> make O=3Dbuild/sandbox u-boot-initial-env
>=20
> It'll print:
> gcc: error: unrecognized command-line option '-mno-global-merge'
> gcc: error: unrecognized command-line option '-Wformat-invalid-specifier'
> gcc: error: unrecognized command-line option '-Qunused-arguments'
>=20
> This is essentially what's run within test_env_initial_env_file in
> test/py/tests/test_env.py.
>=20
> While I'm not unhappy with the patches to pytest, it feels to me we may
> be missing something else for the u-boot-initial-env make target to
> update the kconfig symbol based on the toolchain being used when called.

Is there some other target in the Makefile that should catch this kind
of change? It's not just that build target that needs to be remade, it's
everything, yes?

> While looking at the kernel git history for Makefile and
> scripts/Makefile.extrawarn I also saw a few flags being removed or
> reworked so I took the liberty of backporting some.
>=20
> Then, scripts/Makefile.extrawarn is directly imported verbatim from v6.1
> which is the version we've claimed to be synced with so far.
>=20
> Also, patches to apply CONFIG_WERROR to the host tools as well as linker
> and assembler are backported.
>=20
> kernel-doc is made to ignore KBUILD_EXTRA_WARN since we have too many
> warnings for now and it prevents us from being able to use W=3De Make
> variable which is extremely convenient to essentially do the same as
> setting CONFIG_WERROR in Kconfig, just without needing to actually set
> it in the defconfig or in a .config. I don't like it but it is what it
> is. Our kernel-doc has a couple of patches on top of Linux kernel
> v5.11's. The kernel has moved to a Python script this year, so it's
> probably wise to migrate to that before trying to tackle kernel-doc
> warnings.

This makes sense, yes.

--=20
Tom

--zoEmg6758z+9ZUHj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafjfqgAKCRAr4qD1Cr/k
CqEIAP9xVlyyOhx3gNLs0zizYE+KMgqKzhLyI8yvbE2lxcPe6gD/ZxwpP5SX+ErT
CXMVAvPVKu/WNmssauiO9Okbw5IgVAk=
=Wfre
-----END PGP SIGNATURE-----

--zoEmg6758z+9ZUHj--
