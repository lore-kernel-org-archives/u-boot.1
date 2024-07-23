Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB18C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 20:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53F378831F;
	Tue, 23 Jul 2024 22:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RZ0D1X5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD7287876; Tue, 23 Jul 2024 22:45:11 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C20885B9
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 22:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5ce74defe43so3212263eaf.2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721767506; x=1722372306; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wAbfYoKc5RFlTIXX7sLj4QHjmMPzmMwfrVQ3TOIHJ7g=;
 b=RZ0D1X5JO46zrWQuC4XDQdCKl4makLVKsyvdznttJJRLntHc01yErBVVmrORC1o3WK
 HfXdLoDIS4ORQPbmQZaxVHQEkTOw0nJXRtNlmAWEuq02cBx+EKHyDNJs7R4HUdx1xu5f
 eaXw0TGbitj+qNLrH4Q0tu3FofT3uUMnWHZl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767506; x=1722372306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wAbfYoKc5RFlTIXX7sLj4QHjmMPzmMwfrVQ3TOIHJ7g=;
 b=B0NP3R1tWAl3e5Ew7koc9AemiH2E4OO7cb1vUJxTrCvQ1le4FpIPkXh4PvmDotk+AB
 w4co/vy25uzSVq5QNxWNYrtHmMYz7ifrNOkCg1np/djyVJZMkthJtFMliFOfHzCkp4hk
 FdLPo7RKn6tvdzjcpGsl0t7/+Qt2tTqQ4EO+RxSxaiMBUBerrB/GHXMjuDKxyYS5gJiL
 ujt3um/c+T1R+zG0FVL/vBjADBf6RE084BVR5hr5PJ8mDs64LI4llEidXdxJHszEV/oP
 er9nr7qdGg1kDPQJgDTtbxv8EFshsEZgwvg5v2ygUFaweBdhYKhO6laHoXu3jMYU0r3O
 e65Q==
X-Gm-Message-State: AOJu0YwOd4u75hFtJzuri3GfkI9vonaEWpo+A9bjvqzHPEtX3VUqo5lt
 SqmW8YEL0RvTPxgttXCl7e7xJuyvEOfdzqlBkn1+i9xXSTW8T03LMJBzWlVf6+w=
X-Google-Smtp-Source: AGHT+IGg9zAnKuB2v6Rh8lpaMMFOkt5Wx3UzcVyxQHUtEzB7aaFv+5g1OSVbxNfNuDlhABWuoSR5Lw==
X-Received: by 2002:a05:6870:f10e:b0:260:f24f:62d2 with SMTP id
 586e51a60fabf-2648ca44c9fmr36970fac.17.1721767506130; 
 Tue, 23 Jul 2024 13:45:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2610c716d8fsm2324709fac.5.2024.07.23.13.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 13:45:05 -0700 (PDT)
Date: Tue, 23 Jul 2024 14:45:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v4 00/29] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240723204502.GJ989285@bill-the-cat>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240703012555.GX38804@bill-the-cat>
 <CAEfUkUKhso=O4oFDoJsEd=m+o-avKYvTHMDUHGQsLFQs7vpy-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xdar3rRqsuKKYDru"
Content-Disposition: inline
In-Reply-To: <CAEfUkUKhso=O4oFDoJsEd=m+o-avKYvTHMDUHGQsLFQs7vpy-w@mail.gmail.com>
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


--xdar3rRqsuKKYDru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 03:24:29PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, 2 Jul 2024 at 21:26, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, Jul 02, 2024 at 11:22:36AM -0700, Raymond Mao wrote:
> >
> > > Integrate MbedTLS v3.6 LTS (currently v3.6.0-RC1) with U-Boot.
> > >
> > > Motivations:
> > > ------------
> > >
> > > 1. MbedTLS is well maintained with LTS versions.
> > > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> > > 3. MbedTLS recently switched license back to GPLv2.
> > >
> > > Prerequisite:
> > > -------------
> > >
> > > This patch series requires mbedtls git repo to be added as a
> > > subtree to the main U-Boot repo via:
> > >     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> > >           https://github.com/Mbed-TLS/mbedtls.git \
> > >           v3.6.0 --squash
> > > Moreover, due to the Windows-style files from mbedtls git repo,
> > > we need to convert the CRLF endings to LF and do a commit manually:
> > >     $ git add --renormalize .
> > >     $ git commit
> > >
> > > New Kconfig options:
> > > --------------------
> > >
> > > `MBEDTLS_LIB` is for MbedTLS general switch.
> > > `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs
> > with
> > > MbedTLS.
> > > `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, ASN=
1,
> > > and Pubkey parser with MbedTLS.
> > > `MBEDTLS_LIB_TLS` is for SSL/TLS (Disabled until LWIP port for MbedTL=
S is
> > > ready).
> > > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto libr=
ary.
> > > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> > > `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
> > > For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTL=
S`
> > > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
> > > introduced.
> > >
> > > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X5=
09
> > > are by default enabled in qemu_arm64_defconfig for testing purpose.
> > >
> > > Patches for external MbedTLS project:
> > > -------------------------------------
> > >
> > > Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
> > > executables which is not supported by MbedTLS at the moment,
> > > addtional patches for MbedTLS are created to adapt with the EFI loade=
r:
> > > 1. Decoding of Microsoft Authentication Code.
> > > 2. Decoding of PKCS#9 Authenticate Attributes.
> > > 3. Extending MbedTLS PKCS#7 lib to support multiple signer's
> > certificates.
> > > 4. MbedTLS native test suites for PKCS#7 signer's info.
> > >
> > > All above 4 patches (tagged with `mbedtls/external`) are submitted to
> > > MbedTLS project and being reviewed, eventually they should be part of
> > > MbedTLS LTS release.
> > > But before that, please merge them into U-Boot, otherwise the building
> > > will be broken when MBEDTLS_LIB_X509 is enabled.
> > >
> > > See below PR link for the reference:
> > > https://github.com/Mbed-TLS/mbedtls/pull/9001
> > >
> > > Miscellaneous:
> > > --------------
> > >
> > > Optimized MbedTLS library size by tailoring the config file
> > > and disabling all unnecessary features for EFI loader.
> > > From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1, sha=
256,
> > > sha512) are completely replaced when MbedTLS is enabled.
> > > From v3, the size-growth is slightly reduced by refactoring Hash
> > functions.
> > >
> > > Target(QEMU arm64) size-growth when enabling MbedTLS:
> > > v1: 6.03%
> > > v2: 4.66%
> > > v3 & v4: 4.55%
> > >
> > > Please see the latest output of bloat-o-meter for the reference of the
> > > size-growth on QEMU arm64 target [1].
> > >
> > > Tests done:
> > > -----------
> > >
> > > EFI Secure Boot test (EFI variables loading and verifying, EFI signed
> > image
> > > verifying and booting) via U-Boot console.
> > > EFI Secure Boot and Capsule sandbox test passed.
> > >
> > > Known issues:
> > > -------------
> > >
> > > None.
> > >
> > > [1]: bloat-o-meter output between disabling/enabling MbedTLS (QEMU ar=
m64)
> > > ```
> > > add/remove: 206/81 grow/shrink: 19/17 up/down: 55548/-17495 (38053)
> >
> > bloat-o-meter is a bit off then, since buildman shows:
> > u-boot: add: 243/-17, grow: 18/-17 bytes: 65723/-8480 (57243)
> >
> > (Please use buildman for the size comparisons in the future).
> >
>=20
> I have a problem with buildman.
> As I followed the buildman/README.rst and run below command, but cannot g=
et
> any
> output size summary. Is anything missing? I saw some artifacts of building
> each
> commit being generated in the upper dir though.
> ```
> ./tools/buildman/buildman -b <my_branch_name> --boards qemu_arm64 -sSdB
> ```
> I have set my branch upstream to upstream/next.

You have to tell it twice, once to build and a second to summarize
things. My wrapper looks like:
#!/bin/bash

# Initial and constant buildman args
ARGS=3D"-devl -PEWM"
ALL=3D0
KEEP=3D0

# Find our arguments
while test $# -ne 0; do
	if [ "$1" =3D=3D "--all" ]; then
		ALL=3D1
		shift 1
	elif [ "$1" =3D=3D "--branch" ]; then
		BRANCH=3D$2
		shift 2
	elif [ "$1" =3D=3D "--keep" ]; then
		KEEP=3D1
		ARGS=3D"$ARGS -k"
		shift 1
	elif [ "$1" =3D=3D "--board" ]; then
		MACHINE=3D"--board $2"
		OUTDIR=3D/tmp/$2
		shift 2
	else
		MACHINE=3D$1
		shift 1
	fi
done

OUTDIR=3D${OUTDIR:-/tmp/$MACHINE}

if [ -z "$MACHINE" ]; then
	echo Usage: $0 MACHINE [--all] [--keep] [--branch BRANCH]
	exit 1
fi

# If not all, then only first/last
if [ $ALL -ne 1 ]; then
	ARGS=3D"$ARGS --step 0"
fi

if [ ! -z $BRANCH ]; then
	ARGS=3D"$ARGS -b $BRANCH"
else
	ARGS=3D"$ARGS -b `git rev-parse --abbrev-ref HEAD`"
fi

mkdir -p ${OUTDIR}

export SOURCE_DATE_EPOCH=3D`date +%s`
=2E/tools/buildman/buildman -o ${OUTDIR} $ARGS -SBC $MACHINE
=2E/tools/buildman/buildman -o ${OUTDIR} $ARGS -SsB $MACHINE

[ $KEEP -eq 0 ] && rm -rf ${OUTDIR}

--=20
Tom

--xdar3rRqsuKKYDru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmagFkMACgkQFHw5/5Y0
tywtoAwAq5NYah5x22DGSV8iXRFvtW2sPfSifsWaAJdUPCaSyttKcegBEnc/wgEr
oKSH9SszRAYEWfnsaV5RHM9LWOh1C1zjdsMEYRzNwq71Cft7RMw6xSGcfAvq+SSA
aQZWP6lx74PBSDC2gBxIkIIADWPZhiIG5uj9H2v+UX4l4w3m0U56trqa7xveBw9R
d2z195rGnPJMOfNKUp50d+68t6hXjJRHmPLxnphLotjP7h8Q4rdFWCzCR21EaNLR
u4jGhUXxZX8r2BUqkR2dlHQSXfRmjluMkkR2WYk4KA4o5B5cRZaoQxVKM1vDB70E
qaScboZFq1oYOOc6Fx2WfxYreEjf/JDiCiBO8qlHewTON8oRKqbpTGLfrSzaBnmT
TAAsPEZFQgVQX9NkFedBWab9idFI0+A3wVQD7FCzlKxMNmsQ6YAsZnwrAjEUtBxd
eHpLwbAERMXhZo9jDB8gqveXVqUTppTmOBhCSvlsEQeVZOdq/tPUdRbiaJ6KqvzO
xPKM2zRz
=ChkB
-----END PGP SIGNATURE-----

--xdar3rRqsuKKYDru--
