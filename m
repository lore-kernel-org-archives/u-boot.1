Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669AFCAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 14:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB68832C8;
	Mon, 29 Sep 2025 16:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s+aM4Cty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51495832DA; Mon, 29 Sep 2025 16:57:00 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B985C83071
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 16:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b54dd647edcso4119928a12.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759157816; x=1759762616; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c9uPuNN9knCBXdQ8PpvuBLVYODI37uuFieU+pVJqV+s=;
 b=s+aM4CtywhQKZfwLHDIiQKL6UZ9tJG0I6ZuCtZNWwstwN8UeHLcjaBHpxhDnO7EIN9
 MxiqRlABa7XS52JEIZah/CREYWi8iKRQNO3Y3elN4hwB/GXDMo5JsPzhls9zvYUG4v3N
 iEjYYzDEMpBdCm6+yrpuXzQRiL0OCjHM+OnG4SkWX2sUPAncQG53R0uuqMit+6RLKoou
 kmxtIgRHQKdmUjAxnxyyQTPSq1AvCMQLQT8cZA0gyx75g7cC3iGJ6zhgfOttN1GGgo57
 MbwrbpH/izjipFb5e4Kk5yRGHtqH3i7DbW+WlPH812u7/9cjGu9M4lkL2INS+X6bBdis
 8YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759157816; x=1759762616;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c9uPuNN9knCBXdQ8PpvuBLVYODI37uuFieU+pVJqV+s=;
 b=HV6vL+yLoAE8cWROHHE2b/hXLato4cJWvaFHQ2vhTIPEF2iaELkx8In1xiciwcAHe7
 TK34OgX+Y9V/bSn8i1ZAHeqF/NTdz/uQxFxvvlLkbsCXjGvSLOfJWJIU6h2KpJzr3xHu
 HHS7mvSsc9tqXaURFobE9ugP0cWiEh4DPZ1f43U3HQxLJM6iHgdIGlVKH8sWFFdbpYY8
 9rOebORV0wGLGzv5lYi7mnAmGdLFu3L80cPqNWDWcj5X6xuTV9Wq3+hgp9AD2rn6dzxg
 vSX8lbjPInMC6O3ckUw5N6uhqyPFKl5wpj9OHxG9O4Fy1+H27l1hvpzt4wg2WCK09CbS
 9COQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8RExvk9/feXnjr0UjdRspKldYXh955/ndwmQwHn1/QqK12v2QDX5dt9nh8u8x1Ab88kZ+UPM=@lists.denx.de
X-Gm-Message-State: AOJu0YypCsDBA79V1hrqOho64QapP1unm8CTlnLEdUOU9hoOR1uosX/d
 y+GrStaekgDc+jA2iUvNKe8RwsF21eyxuqoWEWo133JEZqC+RcXmFhb+TMx8snEYYhWpCCb0vpz
 WDvUtZrOEGlEb+DEil2ajEabzReRxJAPA9eD0rufX3Q==
X-Gm-Gg: ASbGncsNNtGRJwHZftMLDavqY6wtN8doOdcs5FbjMlk1EP4Wu8wVC98W5EUBIuUuLfm
 iRhi9KaClJmg6vQkNU3npQGrx6xKLtqus6avR4tx/F2Ln4kVDj9SdliDt5hdTGP3oqX1aV1pOsd
 Kt3jDUwCQmurEg6tSv8OR819IidAA8fQ35q0kHLajQYPpGPLkm5DbqIaysvoSmaM7mwEvIev2Zz
 IlFdmrQ
X-Google-Smtp-Source: AGHT+IEKFnrUC7yBINJxgDtrgsYwm57Wa7BvFMPCH2d/466jYgZAROjt9sp/530az5LgvS+hOrTHNeLVSB01PRUaa70=
X-Received: by 2002:a17:903:584:b0:270:8ae3:a6f1 with SMTP id
 d9443c01a7336-27ed4a56d02mr138339965ad.46.1759157815709; Mon, 29 Sep 2025
 07:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-3-raymond.mao@linaro.org>
 <20250916182742.GZ124814@bill-the-cat>
 <CAEfUkUL2t64-hz-_acWHf01WgLeddYu7S8dRudmNT3re0_hfnQ@mail.gmail.com>
 <20250917154926.GM124814@bill-the-cat>
 <CAEfUkUL59toQ4vFN74qhCRdOo1-umqLOKJviZHSedbBWf71tgw@mail.gmail.com>
 <20250922193357.GG124814@bill-the-cat>
 <CAFLszTiRVtc4g4S2eELsGK7ZEz34g8k8w4HZ-Opy0xGhJWpgzg@mail.gmail.com>
 <CAEfUkUKdGE1w1e5HvtD+wQRXHGbjVs-Hnh782uaiGxav_wq71A@mail.gmail.com>
 <20250929144131.GF6093@bill-the-cat>
In-Reply-To: <20250929144131.GF6093@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 29 Sep 2025 10:56:44 -0400
X-Gm-Features: AS18NWDLXBaJLcxFILn6v8z81xGhW0W2bUueer17Ge7hb7bgVMUTTnO1BmtaoJI
Message-ID: <CAEfUkU+g0kphtxbF3aKanCbB6XwhxNJ_ecvMcG3dhoCXYULvXg@mail.gmail.com>
Subject: Re: [PATCH 2/5] ci: add post-buildman script to build TF-A
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Mon, 29 Sept 2025 at 10:41, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Sep 29, 2025 at 10:31:36AM -0400, Raymond Mao wrote:
> > Hi Simon,
> >
> > On Wed, 24 Sept 2025 at 12:28, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, 22 Sept 2025 at 13:34, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Sep 22, 2025 at 03:07:49PM -0400, Raymond Mao wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 17 Sept 2025 at 11:49, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 17, 2025 at 11:44:07AM -0400, Raymond Mao wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Sep 16, 2025 at 09:14:18AM -0700, Raymond Mao wrote:
> > > > > > > > > Add a script which is running after buildman to fetch TF-A (v2.13.0)
> > > > > > > > > with MbedTLS (v3.6) and build 'flash.bin', linking built U-Boot as
> > > > > > > > > BL33 and OP-TEE as BL32, with both Firmware Handoff and Measured Boot
> > > > > > > > > enabled.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > > > > > > ---
> > > > > > > > >  .azure-pipelines.yml               |  1 +
> > > > > > > > >  .gitlab-ci.yml                     |  1 +
> > > > > > > > >  tools/post_build_tfa_fw_handoff.sh | 87 ++++++++++++++++++++++++++++++
> > > > > > > > >  3 files changed, 89 insertions(+)
> > > > > > > > >  create mode 100755 tools/post_build_tfa_fw_handoff.sh
> > > > > > > > >
> > > > > > > > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > > > > > > > index 8209d2b329c..eb547606ddd 100644
> > > > > > > > > --- a/.azure-pipelines.yml
> > > > > > > > > +++ b/.azure-pipelines.yml
> > > > > > > > > @@ -290,6 +290,7 @@ stages:
> > > > > > > > >            cp /opt/grub/grubriscv64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_riscv64.efi
> > > > > > > > >            cp /opt/grub/grubaa64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm64.efi
> > > > > > > > >            cp /opt/grub/grubarm.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm.efi
> > > > > > > > > +          ./tools/post_build_tfa_fw_handoff.sh \${UBOOT_TRAVIS_BUILD_DIR} \${TEST_PY_BD} \${TEST_PY_ID}
> > > > > > > > >            # create sdcard / spi-nor images for sifive unleashed using genimage
> > > > > > > > >            if [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]]; then
> > > > > > > > >                mkdir -p root;
> > > > > > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > > > > > index 85401d3e09b..61e4af96c9a 100644
> > > > > > > > > --- a/.gitlab-ci.yml
> > > > > > > > > +++ b/.gitlab-ci.yml
> > > > > > > > > @@ -79,6 +79,7 @@ stages:
> > > > > > > > >      - cp /opt/grub/grubriscv64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_riscv64.efi
> > > > > > > > >      - cp /opt/grub/grubaa64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm64.efi
> > > > > > > > >      - cp /opt/grub/grubarm.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm.efi
> > > > > > > > > +    - ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR} ${TEST_PY_BD} ${TEST_PY_ID}
> > > > > > > > >      # create sdcard / spi-nor images for sifive unleashed using genimage
> > > > > > > > >      - if [[ "${TEST_PY_BD}" == "sifive_unleashed" ]]; then
> > > > > > > > >          mkdir -p root;
> > > > > > > > > diff --git a/tools/post_build_tfa_fw_handoff.sh b/tools/post_build_tfa_fw_handoff.sh
> > > > > > > > > new file mode 100755
> > > > > > > > > index 00000000000..f876db593ba
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/tools/post_build_tfa_fw_handoff.sh
> > > > > > > >
> > > > > > > > The "is this a valid board" check should be in the pipeline file (like
> > > > > > > > where we do all the other board-specific things) instead of the helper
> > > > > > > > script.
> > > > > > > >
> > > > > > > > > @@ -0,0 +1,87 @@
> > > > > > > > > +#!/bin/bash
> > > > > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > > > > +#
> > > > > > > > > +# Copyright (c) 2025 Linaro Limited
> > > > > > > > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > > > > > > > > +#
> > > > > > > > > +# CI Post-buildman script for building TF-A 'flash.bin' with Measured
> > > > > > > > > +# Boot and Firmware Handoff enabled.
> > > > > > > > > +#
> > > > > > > > > +# Usage: from the top level U-Boot source tree, run:
> > > > > > > > > +# $ ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR} \
> > > > > > > > > +#     ${TEST_PY_BD} ${TEST_PY_ID}
> > > > > > > > > +#
> > > > > > > > > +# 'bl1.bin', 'fip.bin' and 'flash.bin' will be generated and copied
> > > > > > > > > +# to /tmp.
> > > > > > > > > +
> > > > > > > > > +set -e
> > > > > > > > > +
> > > > > > > > > +BUILDMAN_OUT_DIR=$(realpath "$1")
> > > > > > > > > +BOARD=$2
> > > > > > > > > +ID=$4
> > > > > > > > > +echo "Buildman Outdir: $BUILDMAN_OUT_DIR, Board: $BOARD, ID: $ID"
> > > > > > > >
> > > > > > > > Can we not use fiptool to update the contents of a file here? And build
> > > > > > > > as much as possible in the Dockerfile, like we do for vexpress?
> > > > > > > >
> > > > > > > Sorry I am not quite clear about how it was done for fvp, maybe I
> > > > > > > missed some context, do you mean to build TF-A with OP-TEE at
> > > > > > > Dokerfile and generate a fip.bin without BL33? But then who will
> > > > > > > assemble BL1+fip+u-boot? by test hooks?
> > > > > >
> > > > > > So for FVP, in the Dockerfile we say BL33=/dev/null and this gets
> > > > > > packaged correctly. Then in u-boot-test-hooks we have bin/flash.fiptool
> > > > > > which will update "fip" with the just-built u-boot.bin. The logic:
> > > > > >     # If we have TF-A binaries, we need to use them.
> > > > > >     - if [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
> > > > > >         cp /opt/tf-a/"${TEST_PY_BD}"/fip.bin /opt/tf-a/"${TEST_PY_BD}"/bl1.bin /tmp/;
> > > > > >         export fip=/tmp/fip.bin;
> > > > > >         export bl1=/tmp/bl1.bin;
> > > > > >         export PATH=/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:${PATH};
> > > > > >       fi
> > > > > >
> > > > > > Is how we know what bl1.bin and fip.bin to use as the base.
> > > > > >
> > > > >
> > > > > After looking deeper into this, I think we have to pass BL33 when TF-A
> > > > > is being built, instead of appending the fip via fiptool later, since
> > > > > in the added pytest we are going to test eventlog handoff that
> > > > > enabling MEASURED_BOOT is required.
> > > > > But when MEASURED_BOOT=1 (as well as TRUSTED_BOARD_BOOT=1 and
> > > > > GENERATE_COT=1), the TF-A build system performs firmware measurement,
> > > > > signing, and trust chain generation at build time, based on the actual
> > > > > contents of each firmware image, including BL33.
> > > > >
> > > > > If a post-buildman script here is not acceptable we have to find
> > > > > another way, but first of all we cannot build TF-A in the dockerfile
> > > > > missing specifying the BL33.
> > > >
> > > > Interesting. So TF-A doesn't have tooling for replacing and
> > > > re-measuring, and instead you have to re-run make?
> > >
> > > Sorry to keep banging on about Binman, but it could provide a
> > > post-build way to re-measure things and poke the updated measurements
> > > into the image? It does some vaguely similar things with ELF symbols.
> > >
> >
> > I am still trying to see if I can use the pre-built Measured Boot
> > enabled TF-A with injecting BL33 via test-hooks, and will look back to
> > Binman if post-build is proved as a must.
>
> Part of the important question is, what does TF-A support itself here?
> To some extent "just patch the binary" also means "only useful in
> limited circumstances for security".
>

The TF-A prompts "BL2 image not found" after injecting BL33 which
looks weird, I need to check what exactly is different in the logic
before loading the image when with or w/o those build options.
Generally it might be impacted by other options since measurements are
done during run-time, so therorily injecting BL33 should be fine. I
will find more clues before returning to you.

Raymond

> --
> Tom
