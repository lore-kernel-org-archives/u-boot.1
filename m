Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AE6CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 19:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E808E832F9;
	Mon, 22 Sep 2025 21:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r7o2lg7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBFDD833ED; Mon, 22 Sep 2025 21:34:04 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 734B483211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 21:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-77b334ff27fso1783730a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758569641; x=1759174441; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iKkbBXs2ynKJJvfgMSSBixUySJ2UmsXPbzLsPmLhBGI=;
 b=r7o2lg7hLiwOeVT+oog23PJgc+EjjxMOeyAXii/rvACQFDEch18PqmSYSTdcAq02mf
 aoA6UF90I5VABdvLO4Scg5KVkvo0vF0WrYiPb7F3Cj83at9o5tExYh7oXjDjM8ivJd80
 N2Yk79VC/PaScwZDzgMNfYsumsypmmybGVD4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758569641; x=1759174441;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKkbBXs2ynKJJvfgMSSBixUySJ2UmsXPbzLsPmLhBGI=;
 b=dKVnMXPlD91a+iU9QhViBP1fzTZrZUy7Gs0o8IMz9Hhct3m9ijvuyxh8TxQ48ZMg2q
 mDD+KZ/MSKs21MT6S2n/aA6UbT6GiaWsrDnbNrHNWePlqyJtdstDcByEt0uxGP+vh5J3
 zHo1dsqyoJWI721UPGJeNP9X7ic65mAkvMwhe/kbB8nXfMym0+Y4UwHuiCcKdMhbmqju
 eV/v2YCLywMfzpfl9xdqhBMShiUZbCGaPNJdrAXyMzCqOtN2bUak4rS3FvdG9G6Wk9ey
 Xct6vZOzYt5AwHsGmmK5heJRzzKY3nwLG+/vBkiGOPGSJAix9q9YEaIvqa1g2qu/xTyg
 R2ow==
X-Gm-Message-State: AOJu0YytmCqSXR3J6Z0vxAGnT5LJdlRCEX30UWyL2KjuHGcsjl+FZEb9
 8AQHr4c2PtXwLUU+x0Y76Kwk1nJWT+6qi25W2YHOPo4k4KRtSZI/8x896hzXpL+YGOA=
X-Gm-Gg: ASbGncuTixsLIaTaQjjJ8N0rMLHsMLo/pK2KZV55t1wpGbQa0v1yfsCNp3kM1uy5Akb
 09y/8jzjd6NUB/frzDBa1aOqDWza3X0cCsDBpbjK7cT9OhtIl6Z2B75mZTSfmXYrIu9EhyuB9Eq
 iysn4LW0HJ860wsEM6owQroEMy4ytkLH7cRkk5i4IAKT4cFU0KaJzitlvgZK+UJhn/P7ZsJm14U
 Ao5wHaVohqoOmBEwMTnID/rUmojWvB38XLQ9ohEWf78eEXcAKR/MHsra0CVEF18iOtHC2vWQiGT
 f328tyLdeVAyc9o6JSVEjjr6DRzyq38qQm+1XSUugRu4Zkwsx7mtURnDArr7psRD6IfnaYHokEc
 IAaF1YmpPUW4698kpWAU9h/jpSZ8DwMhPVSfU0CrNQMh65y1jR+yFAYze
X-Google-Smtp-Source: AGHT+IFZs/29Kt04EvmwyqM64TKmYLSHr+fPxgMOAGshkQsrnCqoopZ/AxsRRrCNAhL62VOgJ/PEgA==
X-Received: by 2002:a05:6808:1998:b0:434:10d3:703f with SMTP id
 5614622812f47-43d6c1ad9b5mr7524589b6e.13.1758569640587; 
 Mon, 22 Sep 2025 12:34:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43d5c67cc7dsm5156539b6e.5.2025.09.22.12.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 12:33:59 -0700 (PDT)
Date: Mon, 22 Sep 2025 13:33:57 -0600
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
Message-ID: <20250922193357.GG124814@bill-the-cat>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-3-raymond.mao@linaro.org>
 <20250916182742.GZ124814@bill-the-cat>
 <CAEfUkUL2t64-hz-_acWHf01WgLeddYu7S8dRudmNT3re0_hfnQ@mail.gmail.com>
 <20250917154926.GM124814@bill-the-cat>
 <CAEfUkUL59toQ4vFN74qhCRdOo1-umqLOKJviZHSedbBWf71tgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rDra/ESYgXvEn4uH"
Content-Disposition: inline
In-Reply-To: <CAEfUkUL59toQ4vFN74qhCRdOo1-umqLOKJviZHSedbBWf71tgw@mail.gmail.com>
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


--rDra/ESYgXvEn4uH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 03:07:49PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Wed, 17 Sept 2025 at 11:49, Tom Rini <trini@konsulko.com> wrote:
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
>=20
> After looking deeper into this, I think we have to pass BL33 when TF-A
> is being built, instead of appending the fip via fiptool later, since
> in the added pytest we are going to test eventlog handoff that
> enabling MEASURED_BOOT is required.
> But when MEASURED_BOOT=3D1 (as well as TRUSTED_BOARD_BOOT=3D1 and
> GENERATE_COT=3D1), the TF-A build system performs firmware measurement,
> signing, and trust chain generation at build time, based on the actual
> contents of each firmware image, including BL33.
>=20
> If a post-buildman script here is not acceptable we have to find
> another way, but first of all we cannot build TF-A in the dockerfile
> missing specifying the BL33.

Interesting. So TF-A doesn't have tooling for replacing and
re-measuring, and instead you have to re-run make?

--=20
Tom

--rDra/ESYgXvEn4uH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNGkoQAKCRAr4qD1Cr/k
CvqvAP4/A7Hz73vXxsV7g8Qs/4fmqr+WQhJUv2/O1ZQnE6eRfgEA9VL8d6aRKG1q
TWi7QbOkIP4nrN0HRYHwVAGLligzGw0=
=Cxdd
-----END PGP SIGNATURE-----

--rDra/ESYgXvEn4uH--
