Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3774BCAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 15:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C2A08329F;
	Fri, 19 Sep 2025 17:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cn1Gw83m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C3F7832AD; Fri, 19 Sep 2025 17:26:46 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A38083285
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 17:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-30ccea8f43cso1854810fac.1
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758295602; x=1758900402; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xElfGqRuqH4rTDuHyIFeX+PcD45TMRIcgwk5kZxYFF4=;
 b=cn1Gw83mnhWz+l/8f3WY0UPbNbWZPzJ7dZKS4t4eIZpKE97sDx53hqIkDnP1i4tmfL
 IOwoA21yLgAfvFnPLhyxUiWgXrVRWLE4J8DPUKunIo9cgCZHijTJPMYZAtO6odoBbQbc
 QmRjPndhn3WJXQzlQChTRM467IE/YWOHybyPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758295602; x=1758900402;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xElfGqRuqH4rTDuHyIFeX+PcD45TMRIcgwk5kZxYFF4=;
 b=q7ftPol7J3zZhK+N/ABHvTwOSZ2bn9cM5G6fXArCecaVqy/is5mkAT/1h3GSmQ4VRA
 uKhcifyNRFXSGq+EPBJ6ddLwlAq75hh/M4MS9d+rpi2QyGMpJg4EaAB15DsWd8gQIv7f
 WMSLTFol/LweBxZSTeIHOixVhzUJCFA06UAi10IWW8LcEVqOqqh2t3Aetki+WB/ARuTk
 OvsQhR6ToO9O86ec0O1VrvV9sWxfz0+3n9sL2w9hq3wDwYPkR/GIZT/p/DEsp0u28HHr
 KfEFmvk8lWNSwgR9sEFbVCfNMPbAjUthikDUCvkZi2I4nsLu08QVsN5BaHVnwgteDz6a
 qa4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFGQsNS0c4X4SkedwFF+po5aQISQP0wcq3HX9cggkz+mkF1lEslSw2Fqf/v4kLr7GNm2SPBEo=@lists.denx.de
X-Gm-Message-State: AOJu0YwYYfS+muCqVWrGKTRFx+TwJqv65U9O6fUDGn4H07LM32mTCata
 2kAVUFZVdyLgXsuIxwde2xzNg653UsD2IwFn3HEVJv3/dRgU3T5R524EfwCckAbf/ZI=
X-Gm-Gg: ASbGncu8AYUzS8f5JEfbTHupH2gIOpZD2QpTcJlBVElb3SnJgLO44ABWrV/VyUkQHBN
 tA65CUOo+hpwQcKy+WWX1mJHIE/cRtp0kuu5w6yR4QhO5CyG6/hsuVDATyHf93dlMs8HMcvSfza
 HNdVeGtuAU6deUO2GaEtedL3mytpKGaEgcWBJlB6ItBryVFI/NxtrVY/tAzc+U5ETE6LuUfktiv
 TaayncVf9E3wmbViSHpe6yBd6UtzbadywCpG+OBGaNdT2jPyEe2VJl9sguwujUi7GFf5/lb7QlC
 OC+azisYfNp4ox6stWTeKRPO0yT7acd8hP/zeDE4ziZ8AOpLiNLbHLFG4/7akyFFLQFySA72AT0
 vv/eLljHfZL7AM9srDFHI9o4mBiOhFqBiVGCfOCbX9556PVxgmHn9vXsn
X-Google-Smtp-Source: AGHT+IHBNwxs2HiqxASITLwoX4qNbqO6wj0JDqt8u6sqeyb/8GH7+DOo7g9ZlgzRCERyzT1Mjw9elQ==
X-Received: by 2002:a05:6870:8805:b0:31a:70c0:d498 with SMTP id
 586e51a60fabf-336d0f36620mr2800160fac.2.1758295601903; 
 Fri, 19 Sep 2025 08:26:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-336e5a2b361sm3108207fac.16.2025.09.19.08.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 08:26:41 -0700 (PDT)
Date: Fri, 19 Sep 2025 09:26:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH 2/5] ci: add post-buildman script to build TF-A
Message-ID: <20250919152638.GW124814@bill-the-cat>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-3-raymond.mao@linaro.org>
 <20250916182742.GZ124814@bill-the-cat>
 <CAEfUkUL2t64-hz-_acWHf01WgLeddYu7S8dRudmNT3re0_hfnQ@mail.gmail.com>
 <20250917154926.GM124814@bill-the-cat>
 <CAFLszTjBPpgPcqTuAdzhV=HAR01mvzFKBTcNOrxxz4djZ-8h0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="adX4MRMEhxww9y/i"
Content-Disposition: inline
In-Reply-To: <CAFLszTjBPpgPcqTuAdzhV=HAR01mvzFKBTcNOrxxz4djZ-8h0A@mail.gmail.com>
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


--adX4MRMEhxww9y/i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 09:09:26AM -0600, Simon Glass wrote:
> Hi Raymond,
>=20
> On Wed, 17 Sept 2025 at 09:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Sep 17, 2025 at 11:44:07AM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 09:14:18AM -0700, Raymond Mao wrote:
> > > > > Add a script which is running after buildman to fetch TF-A (v2.13=
=2E0)
> > > > > with MbedTLS (v3.6) and build 'flash.bin', linking built U-Boot as
> > > > > BL33 and OP-TEE as BL32, with both Firmware Handoff and Measured =
Boot
> > > > > enabled.
> > > > >
> > > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > > ---
> > > > >  .azure-pipelines.yml               |  1 +
> > > > >  .gitlab-ci.yml                     |  1 +
> > > > >  tools/post_build_tfa_fw_handoff.sh | 87 ++++++++++++++++++++++++=
++++++
> > > > >  3 files changed, 89 insertions(+)
> > > > >  create mode 100755 tools/post_build_tfa_fw_handoff.sh
> > > > >
> > > > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > > > index 8209d2b329c..eb547606ddd 100644
> > > > > --- a/.azure-pipelines.yml
> > > > > +++ b/.azure-pipelines.yml
> > > > > @@ -290,6 +290,7 @@ stages:
> > > > >            cp /opt/grub/grubriscv64.efi \${UBOOT_TRAVIS_BUILD_DIR=
}/grub_riscv64.efi
> > > > >            cp /opt/grub/grubaa64.efi \${UBOOT_TRAVIS_BUILD_DIR}/g=
rub_arm64.efi
> > > > >            cp /opt/grub/grubarm.efi \${UBOOT_TRAVIS_BUILD_DIR}/gr=
ub_arm.efi
> > > > > +          ./tools/post_build_tfa_fw_handoff.sh \${UBOOT_TRAVIS_B=
UILD_DIR} \${TEST_PY_BD} \${TEST_PY_ID}
> > > > >            # create sdcard / spi-nor images for sifive unleashed =
using genimage
> > > > >            if [[ "\${TEST_PY_BD}" =3D=3D "sifive_unleashed" ]]; t=
hen
> > > > >                mkdir -p root;
> > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > index 85401d3e09b..61e4af96c9a 100644
> > > > > --- a/.gitlab-ci.yml
> > > > > +++ b/.gitlab-ci.yml
> > > > > @@ -79,6 +79,7 @@ stages:
> > > > >      - cp /opt/grub/grubriscv64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_=
riscv64.efi
> > > > >      - cp /opt/grub/grubaa64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm=
64.efi
> > > > >      - cp /opt/grub/grubarm.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm.=
efi
> > > > > +    - ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_=
DIR} ${TEST_PY_BD} ${TEST_PY_ID}
> > > > >      # create sdcard / spi-nor images for sifive unleashed using =
genimage
> > > > >      - if [[ "${TEST_PY_BD}" =3D=3D "sifive_unleashed" ]]; then
> > > > >          mkdir -p root;
> > > > > diff --git a/tools/post_build_tfa_fw_handoff.sh b/tools/post_buil=
d_tfa_fw_handoff.sh
> > > > > new file mode 100755
> > > > > index 00000000000..f876db593ba
> > > > > --- /dev/null
> > > > > +++ b/tools/post_build_tfa_fw_handoff.sh
> > > >
> > > > The "is this a valid board" check should be in the pipeline file (l=
ike
> > > > where we do all the other board-specific things) instead of the hel=
per
> > > > script.
> > > >
> > > > > @@ -0,0 +1,87 @@
> > > > > +#!/bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > +#
> > > > > +# Copyright (c) 2025 Linaro Limited
> > > > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > > > > +#
> > > > > +# CI Post-buildman script for building TF-A 'flash.bin' with Mea=
sured
> > > > > +# Boot and Firmware Handoff enabled.
> > > > > +#
> > > > > +# Usage: from the top level U-Boot source tree, run:
> > > > > +# $ ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DI=
R} \
> > > > > +#     ${TEST_PY_BD} ${TEST_PY_ID}
> > > > > +#
> > > > > +# 'bl1.bin', 'fip.bin' and 'flash.bin' will be generated and cop=
ied
> > > > > +# to /tmp.
> > > > > +
> > > > > +set -e
> > > > > +
> > > > > +BUILDMAN_OUT_DIR=3D$(realpath "$1")
> > > > > +BOARD=3D$2
> > > > > +ID=3D$4
> > > > > +echo "Buildman Outdir: $BUILDMAN_OUT_DIR, Board: $BOARD, ID: $ID"
> > > >
> > > > Can we not use fiptool to update the contents of a file here? And b=
uild
> > > > as much as possible in the Dockerfile, like we do for vexpress?
> > > >
> > > Sorry I am not quite clear about how it was done for fvp, maybe I
> > > missed some context, do you mean to build TF-A with OP-TEE at
> > > Dokerfile and generate a fip.bin without BL33? But then who will
> > > assemble BL1+fip+u-boot? by test hooks?
> >
> > So for FVP, in the Dockerfile we say BL33=3D/dev/null and this gets
> > packaged correctly. Then in u-boot-test-hooks we have bin/flash.fiptool
> > which will update "fip" with the just-built u-boot.bin. The logic:
> >     # If we have TF-A binaries, we need to use them.
> >     - if [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
> >         cp /opt/tf-a/"${TEST_PY_BD}"/fip.bin /opt/tf-a/"${TEST_PY_BD}"/=
bl1.bin /tmp/;
> >         export fip=3D/tmp/fip.bin;
> >         export bl1=3D/tmp/bl1.bin;
> >         export PATH=3D/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:$=
{PATH};
> >       fi
> >
> > Is how we know what bl1.bin and fip.bin to use as the base.
> >
> > --
> > Tom
>=20
> This should actually use binman.  We don't want any shell scripts for
> building :-) We finally got rid of the FIT generator script after some
> years.
>=20
> Build mbedtls and TFA should be in dockerfile, like we have for
> coreboot, for example. I suspect they will be useful in other tests
> too.

There's nothing to do here for binman, it already supports fiptool. It
just doesn't make much sense to add the complexity in this case however.

--=20
Tom

--adX4MRMEhxww9y/i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaM12KgAKCRAr4qD1Cr/k
Cu7lAP9cs5/aMekbLJXIm/DwJzGFws65eB+/esZHDaRmv/+EQAEAvOLZ0jR014/0
JWoIqVkaJMVExc2EsIejKBIAy/LTQA0=
=DURd
-----END PGP SIGNATURE-----

--adX4MRMEhxww9y/i--
