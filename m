Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA898CAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 14:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A2D783071;
	Mon, 29 Sep 2025 16:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jm9EebXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB36A8329F; Mon, 29 Sep 2025 16:41:38 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23DFF82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 16:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-43f56048d2cso410804b6e.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759156895; x=1759761695; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TshDxjnH+37gjwKN/30L3CEgsVodOm9+3Em1EYqStH4=;
 b=jm9EebXExtNhbWWm1s+Swnv+svKLSG77fMNs0+rtJdirACNA8Y0Ea+WcwZV9PXcwKG
 EATKIWJ8hdZoWkm/USmvTH7OoIZPcvOu7oUV0TC4TXC1JGrOokbDpYIE6ir6VsS2DXN2
 Y8FHBCPmliBIH7L1oT5XpIW/QnFHXMG175kO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759156895; x=1759761695;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TshDxjnH+37gjwKN/30L3CEgsVodOm9+3Em1EYqStH4=;
 b=P0zR+dCaJeE6k88StAkZzAjcud7ZtBoo8plGVSWwVofDO16MFZ+DiW9v0dntaGRwLW
 UuLQgQM86TYHQWsuW4UhCIrTxDPigNaoNmA/wIO6iYf82cCJgpf6P2Gyeu7S8fytfKp6
 9x38QVUnhfgGX5B7m2mK/aipL5UPceAABuQqXhAzVqj3iKq8osrGoHDeYU7loNvzRlXc
 TiAQBz5w9eEMGXQY22tkhBnNbb2EGX/8cS8oWAkJ0+cRGK4Qd/8l7el4KBQwaJt2uAgy
 Whug7wVex3jpiYVZWEHs8774Ju+OMqooYGI6FApgfQVvGl9PYrWr2zksuPDTXM5580o7
 Qd4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4K4TkPrIW4/jplKq9x1IxSG8gndYcAdlqjnvPlI3V4+ShEcT7tchQXZv85u9vNGQQRiG09z8=@lists.denx.de
X-Gm-Message-State: AOJu0YzA7bV1HXwiCASVySsntZisXJCbAdXGCFNvAZb6xLyqgUzS1vI3
 14Yhc9kEbwQeA5wvURh52wUhT5BWTjfXavMdWdbvuUN+4H+zxu9MfrHbdJXtEQ7mjvU=
X-Gm-Gg: ASbGncvMKFSWDisehdoomO50lpR20EzA8PhyO2uLnzHvaBsQglL1UTRKc8owaIxVQ4H
 6Fe56ZsNXRv5X/xqAY9VGHaRJ9kIwOySUtgNZExutLdFb10lXgpN83BFtGUZblyEOjgyLDjM4EE
 5i7qCzmDycGPzn11/Y0NP2jRwSBuGq6+gDS1nc+XW1WNniMmJDZovXT+uimMcZI9LJMndS7PeLF
 4fiZxfJyDMnTDbUE7pn7+62BT20LHn4dOhtoI6+G+T8pagxADIxgYg00TmYGurMwDc9yzZdjLQs
 xDsc/SKm5GL/oVSqyTnLb07AXSJHcqNVvLQHBs9cWENEMQsGqW/3hUfchrxt2zIdj5ZvBG4e1kg
 UkM3jCgAXXsGV4dw5QxHm2gnJm1+Lch/5BIPZrxNn8f8petE+NgJy/3xCj2som+AAR6boz6zmOA
 WDnw==
X-Google-Smtp-Source: AGHT+IEwN3nAxfBWV1yhHSjqQo6huGAdMBbtlhMQcUw6Ka7A6BORBWLhdoE7pdmldIz6GeNbtc+EHA==
X-Received: by 2002:a05:6808:22a6:b0:438:1c76:d4f with SMTP id
 5614622812f47-43f4ccf0bfemr8959059b6e.1.1759156894674; 
 Mon, 29 Sep 2025 07:41:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43f5113190esm2158285b6e.14.2025.09.29.07.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:41:33 -0700 (PDT)
Date: Mon, 29 Sep 2025 08:41:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH 2/5] ci: add post-buildman script to build TF-A
Message-ID: <20250929144131.GF6093@bill-the-cat>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-3-raymond.mao@linaro.org>
 <20250916182742.GZ124814@bill-the-cat>
 <CAEfUkUL2t64-hz-_acWHf01WgLeddYu7S8dRudmNT3re0_hfnQ@mail.gmail.com>
 <20250917154926.GM124814@bill-the-cat>
 <CAEfUkUL59toQ4vFN74qhCRdOo1-umqLOKJviZHSedbBWf71tgw@mail.gmail.com>
 <20250922193357.GG124814@bill-the-cat>
 <CAFLszTiRVtc4g4S2eELsGK7ZEz34g8k8w4HZ-Opy0xGhJWpgzg@mail.gmail.com>
 <CAEfUkUKdGE1w1e5HvtD+wQRXHGbjVs-Hnh782uaiGxav_wq71A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ctb4zdBhFfMxdEsi"
Content-Disposition: inline
In-Reply-To: <CAEfUkUKdGE1w1e5HvtD+wQRXHGbjVs-Hnh782uaiGxav_wq71A@mail.gmail.com>
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


--ctb4zdBhFfMxdEsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:31:36AM -0400, Raymond Mao wrote:
> Hi Simon,
>=20
> On Wed, 24 Sept 2025 at 12:28, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Mon, 22 Sept 2025 at 13:34, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Sep 22, 2025 at 03:07:49PM -0400, Raymond Mao wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 17 Sept 2025 at 11:49, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Sep 17, 2025 at 11:44:07AM -0400, Raymond Mao wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > >
> > > > > > > On Tue, Sep 16, 2025 at 09:14:18AM -0700, Raymond Mao wrote:
> > > > > > > > Add a script which is running after buildman to fetch TF-A =
(v2.13.0)
> > > > > > > > with MbedTLS (v3.6) and build 'flash.bin', linking built U-=
Boot as
> > > > > > > > BL33 and OP-TEE as BL32, with both Firmware Handoff and Mea=
sured Boot
> > > > > > > > enabled.
> > > > > > > >
> > > > > > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > > > > > ---
> > > > > > > >  .azure-pipelines.yml               |  1 +
> > > > > > > >  .gitlab-ci.yml                     |  1 +
> > > > > > > >  tools/post_build_tfa_fw_handoff.sh | 87 ++++++++++++++++++=
++++++++++++
> > > > > > > >  3 files changed, 89 insertions(+)
> > > > > > > >  create mode 100755 tools/post_build_tfa_fw_handoff.sh
> > > > > > > >
> > > > > > > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > > > > > > index 8209d2b329c..eb547606ddd 100644
> > > > > > > > --- a/.azure-pipelines.yml
> > > > > > > > +++ b/.azure-pipelines.yml
> > > > > > > > @@ -290,6 +290,7 @@ stages:
> > > > > > > >            cp /opt/grub/grubriscv64.efi \${UBOOT_TRAVIS_BUI=
LD_DIR}/grub_riscv64.efi
> > > > > > > >            cp /opt/grub/grubaa64.efi \${UBOOT_TRAVIS_BUILD_=
DIR}/grub_arm64.efi
> > > > > > > >            cp /opt/grub/grubarm.efi \${UBOOT_TRAVIS_BUILD_D=
IR}/grub_arm.efi
> > > > > > > > +          ./tools/post_build_tfa_fw_handoff.sh \${UBOOT_TR=
AVIS_BUILD_DIR} \${TEST_PY_BD} \${TEST_PY_ID}
> > > > > > > >            # create sdcard / spi-nor images for sifive unle=
ashed using genimage
> > > > > > > >            if [[ "\${TEST_PY_BD}" =3D=3D "sifive_unleashed"=
 ]]; then
> > > > > > > >                mkdir -p root;
> > > > > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > > > > index 85401d3e09b..61e4af96c9a 100644
> > > > > > > > --- a/.gitlab-ci.yml
> > > > > > > > +++ b/.gitlab-ci.yml
> > > > > > > > @@ -79,6 +79,7 @@ stages:
> > > > > > > >      - cp /opt/grub/grubriscv64.efi $UBOOT_TRAVIS_BUILD_DIR=
/grub_riscv64.efi
> > > > > > > >      - cp /opt/grub/grubaa64.efi $UBOOT_TRAVIS_BUILD_DIR/gr=
ub_arm64.efi
> > > > > > > >      - cp /opt/grub/grubarm.efi $UBOOT_TRAVIS_BUILD_DIR/gru=
b_arm.efi
> > > > > > > > +    - ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_=
BUILD_DIR} ${TEST_PY_BD} ${TEST_PY_ID}
> > > > > > > >      # create sdcard / spi-nor images for sifive unleashed =
using genimage
> > > > > > > >      - if [[ "${TEST_PY_BD}" =3D=3D "sifive_unleashed" ]]; =
then
> > > > > > > >          mkdir -p root;
> > > > > > > > diff --git a/tools/post_build_tfa_fw_handoff.sh b/tools/pos=
t_build_tfa_fw_handoff.sh
> > > > > > > > new file mode 100755
> > > > > > > > index 00000000000..f876db593ba
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/tools/post_build_tfa_fw_handoff.sh
> > > > > > >
> > > > > > > The "is this a valid board" check should be in the pipeline f=
ile (like
> > > > > > > where we do all the other board-specific things) instead of t=
he helper
> > > > > > > script.
> > > > > > >
> > > > > > > > @@ -0,0 +1,87 @@
> > > > > > > > +#!/bin/bash
> > > > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > > > +#
> > > > > > > > +# Copyright (c) 2025 Linaro Limited
> > > > > > > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > > > > > > > +#
> > > > > > > > +# CI Post-buildman script for building TF-A 'flash.bin' wi=
th Measured
> > > > > > > > +# Boot and Firmware Handoff enabled.
> > > > > > > > +#
> > > > > > > > +# Usage: from the top level U-Boot source tree, run:
> > > > > > > > +# $ ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BU=
ILD_DIR} \
> > > > > > > > +#     ${TEST_PY_BD} ${TEST_PY_ID}
> > > > > > > > +#
> > > > > > > > +# 'bl1.bin', 'fip.bin' and 'flash.bin' will be generated a=
nd copied
> > > > > > > > +# to /tmp.
> > > > > > > > +
> > > > > > > > +set -e
> > > > > > > > +
> > > > > > > > +BUILDMAN_OUT_DIR=3D$(realpath "$1")
> > > > > > > > +BOARD=3D$2
> > > > > > > > +ID=3D$4
> > > > > > > > +echo "Buildman Outdir: $BUILDMAN_OUT_DIR, Board: $BOARD, I=
D: $ID"
> > > > > > >
> > > > > > > Can we not use fiptool to update the contents of a file here?=
 And build
> > > > > > > as much as possible in the Dockerfile, like we do for vexpres=
s?
> > > > > > >
> > > > > > Sorry I am not quite clear about how it was done for fvp, maybe=
 I
> > > > > > missed some context, do you mean to build TF-A with OP-TEE at
> > > > > > Dokerfile and generate a fip.bin without BL33? But then who will
> > > > > > assemble BL1+fip+u-boot? by test hooks?
> > > > >
> > > > > So for FVP, in the Dockerfile we say BL33=3D/dev/null and this ge=
ts
> > > > > packaged correctly. Then in u-boot-test-hooks we have bin/flash.f=
iptool
> > > > > which will update "fip" with the just-built u-boot.bin. The logic:
> > > > >     # If we have TF-A binaries, we need to use them.
> > > > >     - if [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
> > > > >         cp /opt/tf-a/"${TEST_PY_BD}"/fip.bin /opt/tf-a/"${TEST_PY=
_BD}"/bl1.bin /tmp/;
> > > > >         export fip=3D/tmp/fip.bin;
> > > > >         export bl1=3D/tmp/bl1.bin;
> > > > >         export PATH=3D/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC=
-9.3:${PATH};
> > > > >       fi
> > > > >
> > > > > Is how we know what bl1.bin and fip.bin to use as the base.
> > > > >
> > > >
> > > > After looking deeper into this, I think we have to pass BL33 when T=
F-A
> > > > is being built, instead of appending the fip via fiptool later, sin=
ce
> > > > in the added pytest we are going to test eventlog handoff that
> > > > enabling MEASURED_BOOT is required.
> > > > But when MEASURED_BOOT=3D1 (as well as TRUSTED_BOARD_BOOT=3D1 and
> > > > GENERATE_COT=3D1), the TF-A build system performs firmware measurem=
ent,
> > > > signing, and trust chain generation at build time, based on the act=
ual
> > > > contents of each firmware image, including BL33.
> > > >
> > > > If a post-buildman script here is not acceptable we have to find
> > > > another way, but first of all we cannot build TF-A in the dockerfile
> > > > missing specifying the BL33.
> > >
> > > Interesting. So TF-A doesn't have tooling for replacing and
> > > re-measuring, and instead you have to re-run make?
> >
> > Sorry to keep banging on about Binman, but it could provide a
> > post-build way to re-measure things and poke the updated measurements
> > into the image? It does some vaguely similar things with ELF symbols.
> >
>=20
> I am still trying to see if I can use the pre-built Measured Boot
> enabled TF-A with injecting BL33 via test-hooks, and will look back to
> Binman if post-build is proved as a must.

Part of the important question is, what does TF-A support itself here?
To some extent "just patch the binary" also means "only useful in
limited circumstances for security".

--=20
Tom

--ctb4zdBhFfMxdEsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNqalgAKCRAr4qD1Cr/k
Cm+VAP9aaCWwhYRfO7OZ6aKheY0YHGQwFruPjwNFFOZXcqo6tAEA3MSdtVdFex1a
W7czxJ6E9EhXEKBDDxeZe1AQBygEIg8=
=gpNM
-----END PGP SIGNATURE-----

--ctb4zdBhFfMxdEsi--
