Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AA3D637C4
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 21:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E93F8926E;
	Wed, 13 Nov 2024 22:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uX/ssAv9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A68888F8E; Wed, 13 Nov 2024 22:53:32 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB6458926F
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 22:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-288a90e4394so27302fac.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 13:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731534808; x=1732139608; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8g66xARnzgRFjK+yuJmAc741TJHUIhzmiMxx2+lNuLs=;
 b=uX/ssAv9cn6Px39IavTsBF7JJ/9gMx4MNvmlRnymMaaErfvlVm2g83wRu0Vx8f8ciD
 v28uDc9FWujIsa+A28LLYLh594lXpaDh2xKuTTmHhspLbbAEN4klkkkf7+WbjIzTrrdP
 FyvHOZduyWzQvtdiiC3uOGOlQQZxocmkmJic8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731534808; x=1732139608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8g66xARnzgRFjK+yuJmAc741TJHUIhzmiMxx2+lNuLs=;
 b=qJ8HY8p6AtpDxYQwmQ9N8kaRoSyNnMrbxX16KkK0IXGm0qdhcDgjvSbsi0GcVchRBr
 aKwoTs9vUnRxK3J+KrQCgROksRXehVGSmBXI90+TDkRYx4y/rpPODpso3FMv55/P+5yc
 XJqiqFc1fbB3sVbHRT2xXb84OwQC/RKSKr3Gj+z4T/sN7b6bDxL5egHBgTGKPPn+y9Dm
 HCd0TcTndRfKdl9u4lIv9ZKtL8LGeL8EHmD+tC7SfqEuK+BqCUDvnWty7W6RPyuAzgke
 oNX18m7XBqjHrS7f+vMOUrjimKowc+uoVnhT/f7QLHcl/qdmTQrWQN/ZmZHm02w/ev94
 QJAw==
X-Gm-Message-State: AOJu0YxpiLhTBUd1yCd8ll+r/XsuXCW1BVYK6663y6Qq72HrZIfJhwGS
 wjLE6rutM6TPPBBOl0gk0ohErcZPsTMzOb7vK7k3Csy3it0kNU4TKEKTfQPyr+g=
X-Google-Smtp-Source: AGHT+IFBe41w6NVXP4QlX8++wlO2Mc7lRnlCTdu+FQgwbIlkBZ1pzsfEv3YKGM7IB03aNM7o1HMr6w==
X-Received: by 2002:a05:6871:4005:b0:288:816a:72e6 with SMTP id
 586e51a60fabf-295ccf33337mr7716177fac.7.1731534808487; 
 Wed, 13 Nov 2024 13:53:28 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a60079ea3sm973598a34.55.2024.11.13.13.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 13:53:27 -0800 (PST)
Date: Wed, 13 Nov 2024 15:53:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 3/9] buildman: Support #include files in defconfigs
Message-ID: <20241113215324.GW3600562@bill-the-cat>
References: <20241108152350.3686274-1-sjg@chromium.org>
 <20241108152350.3686274-4-sjg@chromium.org>
 <20241113024035.GI3600562@bill-the-cat>
 <CAFLszTibM9CwXeTbF6OuFrW4YSSs058qa0OysY+fWy7vV6WRkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mW14W61AEndAf0J6"
Content-Disposition: inline
In-Reply-To: <CAFLszTibM9CwXeTbF6OuFrW4YSSs058qa0OysY+fWy7vV6WRkQ@mail.gmail.com>
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


--mW14W61AEndAf0J6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 07:39:37AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 12 Nov 2024 at 19:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Nov 08, 2024 at 08:23:44AM -0700, Simon Glass wrote:
> >
> > > This is used by some boards in U-Boot and is a convenient way to deal
> > > with common settings where using a Kconfig files is not desirable.
> > >
> > > Detect #include files and process them as if they were part of the
> > > original file.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/30
> > [snip]
> > > +defconfig fragments
> > > +-------------------
> > > +
> > > +Buildman provides some initial support for configuration fragments. =
It can scan
> > > +these when present in defconfig files and handle the resuiting Kconf=
ig
> > > +correctly. Thus it is possible to build a board which has a ``#inclu=
de`` in the
> > > +defconfig file.
> > > +
> > > +For now, Buildman simply includes the files to produce a single outp=
ut file,
> > > +using the C preprocessor. It does not call the ``merge_config.sh`` s=
cript. The
> > > +redefined/redundant logic in that script could fairly easily be repe=
ated in
> > > +Buildman, to detect potential problems. For now it is not clear that=
 this is
> > > +useful.
> >
> > I don't like this logic because the whole point of merge_config.sh is
> > that it IS the canonical way to handle Kconfig config files + fragments
> > and provides handy feedback like "You expected CONFIG_FOO=3Dy but you
> > ended up with '# CONFIG_FOO is not set'". It's frankly an at least small
> > problem of our current cpp rule, but calling that for every defconfig
> > would be a performance nightmare too.
>=20
> Here is the part of scripts/kconfig/merge_config.sh which actually
> does something:
>=20
> # Merge files, printing warnings on overridden values
> for MERGE_FILE in $MERGE_LIST ; do
>         echo "Merging $MERGE_FILE"
>         if [ ! -r "$MERGE_FILE" ]; then
>                 echo "The merge file '$MERGE_FILE' does not exist.  Exit.=
" >&2
>                 exit 1
>         fi
>         CFG_LIST=3D$(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2"
> $MERGE_FILE)
>=20
>         for CFG in $CFG_LIST ; do
>                 grep -q -w $CFG $TMP_FILE || continue
>                 PREV_VAL=3D$(grep -w $CFG $TMP_FILE)
>                 NEW_VAL=3D$(grep -w $CFG $MERGE_FILE)
>                 if [ "x$PREV_VAL" !=3D "x$NEW_VAL" ] ; then
>                         echo Value of $CFG is redefined by fragment $MERG=
E_FILE:
>                         echo Previous  value: $PREV_VAL
>                         echo New value:       $NEW_VAL
>                         echo
>                 elif [ "$WARNREDUN" =3D "true" ]; then
>                         echo Value of $CFG is redundant by fragment $MERG=
E_FILE:
>                 fi
>                 sed -i "/$CFG[ =3D]/d" $TMP_FILE
>         done
>         cat $MERGE_FILE >> $TMP_FILE
> done
>=20
> So for every line in the fragment it greps the file to check for
> redefines/redundancies. I feel we can do this in a much more efficient
> way in Python.

I was too literal then. Yes, we should do the above, but in a more
python way.

> > > +To specify the C preprocessor to use, set the ``CPP`` environment va=
riable. The
> > > +default is ``cpp``.
> >
> > Uh, I was hoping it would get the correct CPP and flags from the
> > Makefile? Otherwise this is going to fall down in some corner cases such
> > as I expect clang.
>=20
> I don't want to parse Makefile, if that's what you're suggesting.
>=20
> It shouldn't really matter which cpp we use. U-Boot seems to use
> '$(CC) -E' so we could do the same in buildman, perhaps.

It doesn't matter up until it matters. In the Linux Kernel:
commit feb843a469fb0ab00d2d23cfb9bcc379791011bb
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun Apr 9 23:53:57 2023 +0900

    kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS

is what I was remembering. But it's likely not going to be a problem for
just handling Kconfig fragments (the above failed on parsing out linker
scripts, iirc)

> But actually, having thought about this patch a bit, I think the
> better thing is to process the #include in buildman, rather than
> running the CPP. That way we can avoid people adding #defines in
> there, etc. It locks down the format a bit better.

It's a defined format, and "make foo_defconfig bar.config" must work.

> > > +Note that Buildman does not support adding fragments to existing boa=
rds, e.g.
> > > +like::
> > > +
> > > +    make qemu_riscv64_defconfig acpi.config
> > > +
> > > +This is partly because there is no way for Buildman to know which fr=
agments are
> > > +valid on which boards.
> >
> > That seems like a really weird deficiency and non-sequitur. I don't know
> > why buildman would be attempting any sort of validation beyond syntax
> > validation. It's more that we don't have any way to pass additional
> > arguments to the "make defconfig" part of the build, yes? And then in
> > turn because buildman reads the defconfig itself too, prior to that
> > stage?
>=20
> Yes, everything is seeming weird at the moment for me too.
>=20
> Buildman needs to know the architecture, so it can select the
> toolchain. So it generates a boards.cfg file. It does this using
> Kconfiglib, which processes the defconfig along with the Kconfig files
> in U-Boot, to produce a final .config - see KconfigScanner

Right. And this won't have any idea about the contents of #include
because that's not a normal feature. The Linux Kernel only supports
merging fragments via that script and then dealing with a complete
".config". That's the behavior we need to emulate in order for something
like configs/am68_sk_a72_defconfig work without duplicating entries from
configs/j721s2_evm_a72_defconfig.

> Anyway, this problem[1] is exactly why I complained about fragments a
> year or so back[2]. I'm not sure what the disconnect here is. IMO
> unless we build boards with the fragments in CI they may stop working
> at any time. Therefore IMO we need a file which collects the defconfig
> and its fragments, so we can build the valid combination in CI.
>=20
> What am I missing?
>=20
> Regards,
> Simon
>=20
> [1] https://lore.kernel.org/u-boot/4d55f212-ee39-4886-9246-3596fc4268f7@g=
mx.de/
> [2] https://lore.kernel.org/u-boot/CAPnjgZ14CUVt=3DrM943hh9PQUhK9LJDgZYPx=
UsATYQe3wwOUYqQ@mail.gmail.com/

What you're missing is that the solution is that only
configs/*defconfigs are valid config files for CI to test, and buildman
doesn't support handling #include files correctly yet. It's clunky to
use in that we have to have duplicate information in the combined
defconfig file and so it's non-obvious to fix and I believe discouraging
to more developers.

A CI-only feature of "buildman knows how to combine foo_defconfig +
feature.config" is duplicating the work of "make foo_defconfig
feature.config" that regular developers will use or "make
foo_feature_defconfig" like we have numerous examples of now. Telling
developers they need to update some file to validate their new defconfig
is likely to result in a new and differently perplexing CI error along
the lines of "Why did the test for building every board not count my
board?".

--=20
Tom

--mW14W61AEndAf0J6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc1H9AACgkQFHw5/5Y0
tyz+lgv/YwsZY62bvrR/UOs1kEgxX/P88/6WILsZ4i0v9jOcFW+29yOD2YQU1ASt
0frphMR6/DdDwl93yvjnqlKhJQ99j3lTt29dUjVigi0FNHE/kUUguy1jWdJbkIkG
vLg2SbAJ8JtWKhIg9JT7WfiaJajAtkwTh6zSXfWMXcResITs65SM+8VJ11GZ8Ktk
hnPqo23HhX6gmkdUvUrOv0cvIgEt1hoTQb6qFczM5k00xdvwcH4GcJ1j575d/tOt
pq+iwrHsAtb2OyFYpXmyETcsHdwIkhMUBOyk192AYIYYHbWjhLoJ/x8Ly2dkGELu
orAqA4u926DmYiMx4cBR/X6B7jYcwf3DM64FBgFvocx6QpLAmdEweviSvNOxtVur
SkW4WgGLW7CgSUjZm0ZQsnLby1Js20c3EK+R8MMoKR7P1Tyuuu2wnbiLS3Z+q9sl
gCjvJl77Xxj7PEzjq3n4x5rYbXP52zlF4AqA5w9eIDc/m9JtqFR1wlsuJCl5PWn6
1P8uduKG
=PxpH
-----END PGP SIGNATURE-----

--mW14W61AEndAf0J6--
