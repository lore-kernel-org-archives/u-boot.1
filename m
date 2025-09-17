Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F815CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 15:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0567783653;
	Wed, 17 Sep 2025 17:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="siucH3y6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EBC68366F; Wed, 17 Sep 2025 17:49:33 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FF3883622
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 17:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-62192ee029dso6245eaf.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758124170; x=1758728970; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ptvBl7z8zn8uCg7BJDk3scapj4dFcWj3PjUzyOqlCvA=;
 b=siucH3y64LzFYYRImB9EO9FlEhQvkwDY68HNmecbWcOGAugB19b4S29vGAszR782gT
 fg5s9oIuH2PijA+verW+Ad1gY27x6OA+kicX2JqupwORdrWamX2XfMTxDZ2ZLV/YzVS8
 tqJSc9l9m7f263cPjoPFcWV4lme7Teq3PUn2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758124170; x=1758728970;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptvBl7z8zn8uCg7BJDk3scapj4dFcWj3PjUzyOqlCvA=;
 b=FEy6fWrEYxU8qVzsD6nSob7qGsYEiO4FxUEqyDUbHRvoGkUOZxPvngdGWYhg3gl+NU
 Vh2u7A+0M3rqjDnFGTUUI4vgdu7hO3iEdFTBHtsE5Urq96WQ/ohDhYaVuLVAbwQ0G2/E
 vot0qC3XpveAlMKs51xgG3jUhUi/SQvIKOlvSIK8k3JdEz7IyJ8Zqf7vvJIR943+75og
 5iMFX3lqmmlNfqhLK4wn1Wc7CgqBK5Sc9+qQBs/6e9y7kHqkcmJAVSTSIlYlyvLGW9Sj
 W/ZTmkFLNgJqRL3+uU/4TmQYAS3TB6lCJXDNboy1w5P/Ht5O0BC9gRoC+x4VqpcYTTFt
 NqeQ==
X-Gm-Message-State: AOJu0Yy9vj+/DediOOkFpTdUJ3rBqkkwEUl/LUEqLj9QMuR/r3yOREKS
 kLWNr4ud5dN5BgYmmNPB/Ob9SGmZdlMd84YyAn93thQhJMVrcy3fm4UFqpK/zhqG0J0=
X-Gm-Gg: ASbGnctZ1FkJRGmscJ1RSHXT5Z2SlB2OuSZBQsN+Jm19NoDX2dEnX2Om9ykkFd19ZeK
 WSAHrtWS33FbMwDgW3J3wqLTR6M5GM0jTbawiuVGdIJNQ8uF/KiK1XBQJUP6+YjX8srZu4pcmNc
 rdisTZAdYwDLG19FESvkgK4/FPRMP/DolngS+mVfiLXvCcFSlDP/sweRmc1uj65t35xBgc8Pism
 W5RI9J8ZUJ2lhYZUOA6JvCxCQOgToGzwZ1DEk6AwJXshpHA8fOIXe7ySZ7g1aGjCLYqOPjt/use
 1LuqIaDJkg6IiSxw+DaK4TizIRcmUyRafRcroydBBSo7DDHKBpA/M7MYr3bDpa8i7T+qjyYkf6h
 R2kbXPibfmxS6XzFYz37xRy6YCucTEjSVhG+cf/DjO4G5LGH9r8asDEOXu7dxWhKGL/4=
X-Google-Smtp-Source: AGHT+IGlI+wMGo5DvdmlltiVVJR7c/GPF6eT3ZCWcafSqLapwD5QZuKLaBj5T7hMEYOZiA877mPJfw==
X-Received: by 2002:a05:6808:1886:b0:439:27db:51cb with SMTP id
 5614622812f47-43d508a9d9dmr1243983b6e.0.1758124169671; 
 Wed, 17 Sep 2025 08:49:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d3537ec82sm6329571fac.16.2025.09.17.08.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 08:49:28 -0700 (PDT)
Date: Wed, 17 Sep 2025 09:49:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH 2/5] ci: add post-buildman script to build TF-A
Message-ID: <20250917154926.GM124814@bill-the-cat>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-3-raymond.mao@linaro.org>
 <20250916182742.GZ124814@bill-the-cat>
 <CAEfUkUL2t64-hz-_acWHf01WgLeddYu7S8dRudmNT3re0_hfnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S+RZGTbr4QCWmG6/"
Content-Disposition: inline
In-Reply-To: <CAEfUkUL2t64-hz-_acWHf01WgLeddYu7S8dRudmNT3re0_hfnQ@mail.gmail.com>
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


--S+RZGTbr4QCWmG6/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:44:07AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 09:14:18AM -0700, Raymond Mao wrote:
> > > Add a script which is running after buildman to fetch TF-A (v2.13.0)
> > > with MbedTLS (v3.6) and build 'flash.bin', linking built U-Boot as
> > > BL33 and OP-TEE as BL32, with both Firmware Handoff and Measured Boot
> > > enabled.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > >  .azure-pipelines.yml               |  1 +
> > >  .gitlab-ci.yml                     |  1 +
> > >  tools/post_build_tfa_fw_handoff.sh | 87 ++++++++++++++++++++++++++++=
++
> > >  3 files changed, 89 insertions(+)
> > >  create mode 100755 tools/post_build_tfa_fw_handoff.sh
> > >
> > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > index 8209d2b329c..eb547606ddd 100644
> > > --- a/.azure-pipelines.yml
> > > +++ b/.azure-pipelines.yml
> > > @@ -290,6 +290,7 @@ stages:
> > >            cp /opt/grub/grubriscv64.efi \${UBOOT_TRAVIS_BUILD_DIR}/gr=
ub_riscv64.efi
> > >            cp /opt/grub/grubaa64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_=
arm64.efi
> > >            cp /opt/grub/grubarm.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_a=
rm.efi
> > > +          ./tools/post_build_tfa_fw_handoff.sh \${UBOOT_TRAVIS_BUILD=
_DIR} \${TEST_PY_BD} \${TEST_PY_ID}
> > >            # create sdcard / spi-nor images for sifive unleashed usin=
g genimage
> > >            if [[ "\${TEST_PY_BD}" =3D=3D "sifive_unleashed" ]]; then
> > >                mkdir -p root;
> > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > index 85401d3e09b..61e4af96c9a 100644
> > > --- a/.gitlab-ci.yml
> > > +++ b/.gitlab-ci.yml
> > > @@ -79,6 +79,7 @@ stages:
> > >      - cp /opt/grub/grubriscv64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_risc=
v64.efi
> > >      - cp /opt/grub/grubaa64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm64.e=
fi
> > >      - cp /opt/grub/grubarm.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm.efi
> > > +    - ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR}=
 ${TEST_PY_BD} ${TEST_PY_ID}
> > >      # create sdcard / spi-nor images for sifive unleashed using geni=
mage
> > >      - if [[ "${TEST_PY_BD}" =3D=3D "sifive_unleashed" ]]; then
> > >          mkdir -p root;
> > > diff --git a/tools/post_build_tfa_fw_handoff.sh b/tools/post_build_tf=
a_fw_handoff.sh
> > > new file mode 100755
> > > index 00000000000..f876db593ba
> > > --- /dev/null
> > > +++ b/tools/post_build_tfa_fw_handoff.sh
> >
> > The "is this a valid board" check should be in the pipeline file (like
> > where we do all the other board-specific things) instead of the helper
> > script.
> >
> > > @@ -0,0 +1,87 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0+
> > > +#
> > > +# Copyright (c) 2025 Linaro Limited
> > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > > +#
> > > +# CI Post-buildman script for building TF-A 'flash.bin' with Measured
> > > +# Boot and Firmware Handoff enabled.
> > > +#
> > > +# Usage: from the top level U-Boot source tree, run:
> > > +# $ ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR} \
> > > +#     ${TEST_PY_BD} ${TEST_PY_ID}
> > > +#
> > > +# 'bl1.bin', 'fip.bin' and 'flash.bin' will be generated and copied
> > > +# to /tmp.
> > > +
> > > +set -e
> > > +
> > > +BUILDMAN_OUT_DIR=3D$(realpath "$1")
> > > +BOARD=3D$2
> > > +ID=3D$4
> > > +echo "Buildman Outdir: $BUILDMAN_OUT_DIR, Board: $BOARD, ID: $ID"
> >
> > Can we not use fiptool to update the contents of a file here? And build
> > as much as possible in the Dockerfile, like we do for vexpress?
> >
> Sorry I am not quite clear about how it was done for fvp, maybe I
> missed some context, do you mean to build TF-A with OP-TEE at
> Dokerfile and generate a fip.bin without BL33? But then who will
> assemble BL1+fip+u-boot? by test hooks?

So for FVP, in the Dockerfile we say BL33=3D/dev/null and this gets
packaged correctly. Then in u-boot-test-hooks we have bin/flash.fiptool
which will update "fip" with the just-built u-boot.bin. The logic:
    # If we have TF-A binaries, we need to use them.
    - if [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
        cp /opt/tf-a/"${TEST_PY_BD}"/fip.bin /opt/tf-a/"${TEST_PY_BD}"/bl1.=
bin /tmp/;
        export fip=3D/tmp/fip.bin;
        export bl1=3D/tmp/bl1.bin;
        export PATH=3D/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:${PAT=
H};
      fi

Is how we know what bl1.bin and fip.bin to use as the base.

--=20
Tom

--S+RZGTbr4QCWmG6/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMrYhgAKCRAr4qD1Cr/k
CpGiAQD9+sjvs/ac+/Q0rssF6DDNL4ECfQAmtrE8lI9jRw3RfQEA9bp2VgqiC0st
JSXcVqGXLb06T/xAvxtJHx+izDl2uwo=
=yf+j
-----END PGP SIGNATURE-----

--S+RZGTbr4QCWmG6/--
