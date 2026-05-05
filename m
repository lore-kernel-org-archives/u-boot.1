Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB60CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D16B784968;
	Tue,  5 May 2026 17:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UlFQKQlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E9684970; Tue,  5 May 2026 17:10:15 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CB93848FC
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 17:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7dcc9b506d9so5176308a34.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 08:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777993811; x=1778598611; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=39cKk9ASWZFZG5T2b2Pzkl0dXsXogwgWpsmt1RNk6p8=;
 b=UlFQKQlH9ynsrimEuWSHJO+Urk1AIP1/WdzAZExGKd4PgJ4YVLExFb4D/MPU+ZAliX
 EOTkZ1syWQKuyIh11vYk8FMGFJRVOE7RAQN5PD7WcTAF9mX1pfhkaogWRWkNrTYhxzHN
 0fs3UNjzNwdYMEgWttsVaF63X/oHRjkp4/Fak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777993811; x=1778598611;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39cKk9ASWZFZG5T2b2Pzkl0dXsXogwgWpsmt1RNk6p8=;
 b=Jx81UGfoyyG0m/gIVUnK+lMAOUt2tdi7fgfk2wllUSXmcVMChRqeiVS1d2Sge+H/M0
 GIeopHh5CE2MeKCOP7V4ZW8FFcnb9GIa8+f1LeS43fyQSw9vqv3++1HvGhkcQ4+e5pUR
 KO4c2S5/ICHAkUWXuel6X5unt+R/YT+s+3MyPD+7CoLKxw0i+iINN1DEJzKWWJc8caoa
 f7nwod/PETQaXhvOgvRyfVgirY7RfQ3yNDavP4JNR9Hf7KbtMA6kxC6EPAXcutNoV70X
 8b2rgCQgu7AIdmkF+8BMvqGZd16AsaXl35eoGHCC0VUBxkkMDM6a+7cXBB83tyFuIvQZ
 dQdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xAps4L9021jVRkRJdtfROC8UqNNyb/DtM13Xsvcaajw7hvaUwGJM26xLGgXvrkFbJy1KJ+OA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/olXXZTAKxRQqLbl55rXr7oPSkHl+83on5ivjDO9TA6W47esx
 8RY3rn4/1AGmVzyaoFviCLVbEPe7L8kNnJvICiFWn/45x4xs18iKuS8TGyoCdL/wALg=
X-Gm-Gg: AeBDievGZHgj9oRpQbMo78BDIegzLrTYRdEMjWDX1tvwd3BK0rP7vKECVfTECllzM5L
 clnRdu2GYLeoWJU8deYm/N5/B47WgVaiKhSByErUQoLQzaPh9Oe2OlRZm0frMBdjP36vlmj26/h
 IWSOsVfHpDYj7Tdt1BaV7CMk8SUe5aIaIBoHLZVYbhNEDAIcBBSrldA568PUqocRpQLQ/WtoHhv
 395QeOoBveXBlXj1ZMWy6Gl6ifqGnJ8YwJQWMGkV/+Lv3OeVo7oFD0slctDYzcWRLZmbxkyrSwp
 OSQl9phsb8IpTqyTa8gMcSVvnma8l27eC0DvhtoKkdJVtao9Mm6iF2um9gj/4Iyyr/3AGkDselh
 SirFp0WHwRYvGTMhF9cww1nnWBtfvhFsp16uBbtdOHY9yGka2/K8keGM5uAPxJ/Qo/l+DqOZFE6
 jFLIuJHZ/MI4xYkIBeu58wCtHM8TFtcaS2+508AEUCBkWhbqJ4OVwCeXR05AbVrktyG/O+PBH6+
 iUnompTf1Lbp4XAZ9/QqElaOZ2kLroyZi9EqPt6YvihhXlI+cDbJSR0FwyePA==
X-Received: by 2002:a05:6808:e687:b0:46a:746c:2d53 with SMTP id
 5614622812f47-47c88fdb5e1mr5351168b6e.2.1777993810969; 
 Tue, 05 May 2026 08:10:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c763b33c1sm8820037b6e.1.2026.05.05.08.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 08:10:10 -0700 (PDT)
Date: Tue, 5 May 2026 09:10:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
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
 Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH RFC next 00/18] sync scripts/Makefile.extrawarn with 6.1, 
 enable WERROR for host tools
Message-ID: <20260505151007.GR1614990@bill-the-cat>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504180429.GJ1614990@bill-the-cat>
 <af74c5ed-a3a0-4f2d-a261-269e31882711@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LgJkBSrPtVE9Fp9D"
Content-Disposition: inline
In-Reply-To: <af74c5ed-a3a0-4f2d-a261-269e31882711@cherry.de>
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


--LgJkBSrPtVE9Fp9D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2026 at 01:58:26PM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 5/4/26 8:04 PM, Tom Rini wrote:
> > On Mon, May 04, 2026 at 03:20:27PM +0200, Quentin Schulz wrote:
> [...]
> > > The first two patches are for fixing pytest calling make directly on a
> > > "dirty" build directory as generated by buildman using the clang-20
> > > toolchain, but pytest does not set HOSTCC and CC to clang-20, resulti=
ng
> > > in clang flags being used with gcc).
> > >=20
> > > One can simply reproduce it (after backporting up to patch
> > > "scripts/Makefile.extrawarn: sync with 6.1") by doing so in the
> > > container:
> > >=20
> > > make HOSTCC=3Dclang-20 CC=3Dclang-20 O=3Dbuild/sandbox sandbox_defcon=
fig
> > > make HOSTCC=3Dclang-20 CC=3Dclang-20 O=3Dbuild/sandbox -j`nproc
> > > make O=3Dbuild/sandbox u-boot-initial-env
> > >=20
> > > It'll print:
> > > gcc: error: unrecognized command-line option '-mno-global-merge'
> > > gcc: error: unrecognized command-line option '-Wformat-invalid-specif=
ier'
> > > gcc: error: unrecognized command-line option '-Qunused-arguments'
> > >=20
> > > This is essentially what's run within test_env_initial_env_file in
> > > test/py/tests/test_env.py.
> > >=20
> > > While I'm not unhappy with the patches to pytest, it feels to me we m=
ay
> > > be missing something else for the u-boot-initial-env make target to
> > > update the kconfig symbol based on the toolchain being used when call=
ed.
> >=20
> > Is there some other target in the Makefile that should catch this kind
> > of change? It's not just that build target that needs to be remade, it's
> > everything, yes?
> >=20
>=20
> For the reproducer, one actually needs to do
>=20
> diff --git a/Makefile b/Makefile
> index bd33437fdfd..9079131f81e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1007,15 +1007,15 @@ KBUILD_CFLAGS +=3D $(call
> cc-option,-Wno-format-nonliteral)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, address-of-packed-member)
>=20
>  ifdef CONFIG_CC_IS_CLANG
> -KBUILD_CPPFLAGS +=3D $(call cc-option,-Qunused-arguments,)
> -KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-invalid-specifier)
> -KBUILD_CFLAGS +=3D $(call cc-disable-warning, gnu)
> +KBUILD_CPPFLAGS +=3D -Qunused-arguments
> +KBUILD_CFLAGS +=3D -Wno-format-invalid-specifier
> +KBUILD_CFLAGS +=3D -Wno-gnu
>  # Quiet clang warning: comparison of unsigned expression < 0 is always
> false
> -KBUILD_CFLAGS +=3D $(call cc-disable-warning, tautological-compare)
> +KBUILD_CFLAGS +=3D -Wno-tautological-compare
>  # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, =
as
> the
>  # source of a reference will be _MergedGlobals and not on of the
> whitelisted names.
>  # See modpost pattern 2
> -KBUILD_CFLAGS +=3D $(call cc-option, -mno-global-merge,)
> +KBUILD_CFLAGS +=3D -mno-global-merge
>  else
>=20
>  # These warnings generated too much noise in a regular build.
>=20
> Which is what's being done since kernel commit a1494304346a ("kbuild: add
> all Clang-specific flags unconditionally"). I actually had this in an
> earlier version of this patch series and forgot I removed it.
>=20
> This seems to apply to envtools and tools-only as well, though make promp=
ts
> me for the desired state of symbols that are now reachable, e.g.
> ARM64_CRC32. And if I rerun the same command, then it works. It seems like
> the config from the previous run is used? I don't know if it's related but
> those two commands call make directly ($(Q)$(MAKE) $(build)=3D<path>). Do=
 you
> have something in mind maybe? Or some more commands to run?

I think I partly misunderstood at first. It's not that we switch from
one toolchain to another, it's that we can't (as easily) use gcc for the
target and clang for host tools (and vice-versa) because of how flags
are set now, yes? If so, how does this work in the kernel?

--=20
Tom

--LgJkBSrPtVE9Fp9D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafoITAAKCRAr4qD1Cr/k
ChiqAQC/c1UAvD78NZAwbOiM6SU5mDwvYRC4bKL6gw/1KUpb0AEA2rBnurYV6t3b
uWd4RYzeNhb+J2vUtWHcfI4vcXZvSwQ=
=72bg
-----END PGP SIGNATURE-----

--LgJkBSrPtVE9Fp9D--
