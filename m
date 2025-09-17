Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99B1CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 15:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FAF283678;
	Wed, 17 Sep 2025 17:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wozwXK+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4850883692; Wed, 17 Sep 2025 17:58:27 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E48AD83677
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 17:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-244580523a0so68941055ad.1
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758124703; x=1758729503; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BdzCYJoqmvB6+FZ86pUZG/hPm1bqVF1iWrWMNewkY3w=;
 b=wozwXK+iA5FWHfASEVtqco5j0N7nCB789G59is3i1rnMp6f+cZWZC2a7esZQcnXF/7
 Y8mbUan5uDOeZQtDRL2qt2whDo8551OHoMCfQolgvwkfm2lutWlH+D08UjpyXIY2unJC
 8q/fu/PZ+v41xsD+cHHK/3HMBIkprRPNb6aaVhDtr0tw5g686ES1r0SlJEVVLRakCxwe
 6oHB0h94EXnICyGUiZVJHefsTCO04YPryfW4yf39FXXcuALlZOcEi3sapV48gOVJnlck
 x4L4gVfXecr8Jfk7+gI75SRq3bwxvqSi2LgViPh+T4Bdi7Got/UndL5UA5bk9sytTxOi
 o1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758124703; x=1758729503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BdzCYJoqmvB6+FZ86pUZG/hPm1bqVF1iWrWMNewkY3w=;
 b=tlQonzzunrEDZF6cdWl8JXnm+JhXjYTVxjooWEHfJA0N/2cgz2woZZ5JAqumyyZygx
 71Z3p/hg4+/0kb03pYI7H0OV6WGIxm8SA5IBcsJDI8PTRC8wbFM+YCdHnDey0d9vJygb
 jKiBQvYC+K5Bz3hoo+388Kbcr/MAEuvGDfl/ujNKwG3KU2lP9PqH3Y/A92MiC/l97WF0
 aHmW1ehOGPRJj7IloCOTlymmcvduf8NO1ChlXZ9K7k5GL/B9koUSado2cUOXt9szpYLo
 khlSX5tDYtMatE/kzmb5b9RywLWMWvLetiWhHd+ogXAVeRbJEuPLfPzH8K0JKxZDLrdl
 oyBA==
X-Gm-Message-State: AOJu0YwUuUV09NKVreXjQGZIDOkaqcaltSb22sQvXeuCulp5NHsBk+Hl
 Lht/39OhUbICL9wIzHYdW4xPy2QymZAySD5G7hR0U9hidpiuACxIXo8QjIgMLZJ+pPT43pqQkDT
 CjWbNo9IQDZHw5czc5/PsyHn0aM3L2ccajJm0VyWXGA==
X-Gm-Gg: ASbGnctRsq/6z1EBPaXVCaebVWOiqHjFoDWRWOBywJG8slTK1NJhctErkXFbIPeewC3
 ivwXkwZZAsF+o+gaIvRAMErSF31QVMt1A2Wcim9Wy24H+x2gs43yPRv6fz5J4gXf3yG/s/nPCB3
 BaXVq6bXVDItwjGhXVWQCVrVvcY/WD7LgoB1Sevkw7fS1gF35K3AxER5LCwXKR9TnABCIQAtdgG
 p5uIQFiYQ==
X-Google-Smtp-Source: AGHT+IEGtDGcP7rEafQyWNnlO0P3+3+DgZeLtqmbNOscED2M3OdIuTJjb/frThnJ0XXRka7hnV73Kov4Y27E7XOr+aw=
X-Received: by 2002:a17:902:fc4b:b0:24f:fb79:e25f with SMTP id
 d9443c01a7336-26813bf3dfemr31353375ad.46.1758124703329; Wed, 17 Sep 2025
 08:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-3-raymond.mao@linaro.org>
 <20250916182742.GZ124814@bill-the-cat>
 <CAEfUkUL2t64-hz-_acWHf01WgLeddYu7S8dRudmNT3re0_hfnQ@mail.gmail.com>
 <20250917154926.GM124814@bill-the-cat>
In-Reply-To: <20250917154926.GM124814@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 17 Sep 2025 11:58:12 -0400
X-Gm-Features: AS18NWBTT04dHOdk7Hv6DHvEjIjCoX749S3n_QHdSzYY9lMZAxJWGJLaWcAatl4
Message-ID: <CAEfUkUKuZiuwty-acTCwmLhLW8nJGg3Y+ok5NfRG39PL6ZPHvA@mail.gmail.com>
Subject: Re: [PATCH 2/5] ci: add post-buildman script to build TF-A
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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

On Wed, 17 Sept 2025 at 11:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 17, 2025 at 11:44:07AM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 09:14:18AM -0700, Raymond Mao wrote:
> > > > Add a script which is running after buildman to fetch TF-A (v2.13.0)
> > > > with MbedTLS (v3.6) and build 'flash.bin', linking built U-Boot as
> > > > BL33 and OP-TEE as BL32, with both Firmware Handoff and Measured Boot
> > > > enabled.
> > > >
> > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > ---
> > > >  .azure-pipelines.yml               |  1 +
> > > >  .gitlab-ci.yml                     |  1 +
> > > >  tools/post_build_tfa_fw_handoff.sh | 87 ++++++++++++++++++++++++++++++
> > > >  3 files changed, 89 insertions(+)
> > > >  create mode 100755 tools/post_build_tfa_fw_handoff.sh
> > > >
> > > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > > index 8209d2b329c..eb547606ddd 100644
> > > > --- a/.azure-pipelines.yml
> > > > +++ b/.azure-pipelines.yml
> > > > @@ -290,6 +290,7 @@ stages:
> > > >            cp /opt/grub/grubriscv64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_riscv64.efi
> > > >            cp /opt/grub/grubaa64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm64.efi
> > > >            cp /opt/grub/grubarm.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm.efi
> > > > +          ./tools/post_build_tfa_fw_handoff.sh \${UBOOT_TRAVIS_BUILD_DIR} \${TEST_PY_BD} \${TEST_PY_ID}
> > > >            # create sdcard / spi-nor images for sifive unleashed using genimage
> > > >            if [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]]; then
> > > >                mkdir -p root;
> > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > index 85401d3e09b..61e4af96c9a 100644
> > > > --- a/.gitlab-ci.yml
> > > > +++ b/.gitlab-ci.yml
> > > > @@ -79,6 +79,7 @@ stages:
> > > >      - cp /opt/grub/grubriscv64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_riscv64.efi
> > > >      - cp /opt/grub/grubaa64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm64.efi
> > > >      - cp /opt/grub/grubarm.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm.efi
> > > > +    - ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR} ${TEST_PY_BD} ${TEST_PY_ID}
> > > >      # create sdcard / spi-nor images for sifive unleashed using genimage
> > > >      - if [[ "${TEST_PY_BD}" == "sifive_unleashed" ]]; then
> > > >          mkdir -p root;
> > > > diff --git a/tools/post_build_tfa_fw_handoff.sh b/tools/post_build_tfa_fw_handoff.sh
> > > > new file mode 100755
> > > > index 00000000000..f876db593ba
> > > > --- /dev/null
> > > > +++ b/tools/post_build_tfa_fw_handoff.sh
> > >
> > > The "is this a valid board" check should be in the pipeline file (like
> > > where we do all the other board-specific things) instead of the helper
> > > script.
> > >
> > > > @@ -0,0 +1,87 @@
> > > > +#!/bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > +#
> > > > +# Copyright (c) 2025 Linaro Limited
> > > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > > > +#
> > > > +# CI Post-buildman script for building TF-A 'flash.bin' with Measured
> > > > +# Boot and Firmware Handoff enabled.
> > > > +#
> > > > +# Usage: from the top level U-Boot source tree, run:
> > > > +# $ ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR} \
> > > > +#     ${TEST_PY_BD} ${TEST_PY_ID}
> > > > +#
> > > > +# 'bl1.bin', 'fip.bin' and 'flash.bin' will be generated and copied
> > > > +# to /tmp.
> > > > +
> > > > +set -e
> > > > +
> > > > +BUILDMAN_OUT_DIR=$(realpath "$1")
> > > > +BOARD=$2
> > > > +ID=$4
> > > > +echo "Buildman Outdir: $BUILDMAN_OUT_DIR, Board: $BOARD, ID: $ID"
> > >
> > > Can we not use fiptool to update the contents of a file here? And build
> > > as much as possible in the Dockerfile, like we do for vexpress?
> > >
> > Sorry I am not quite clear about how it was done for fvp, maybe I
> > missed some context, do you mean to build TF-A with OP-TEE at
> > Dokerfile and generate a fip.bin without BL33? But then who will
> > assemble BL1+fip+u-boot? by test hooks?
>
> So for FVP, in the Dockerfile we say BL33=/dev/null and this gets
> packaged correctly. Then in u-boot-test-hooks we have bin/flash.fiptool
> which will update "fip" with the just-built u-boot.bin. The logic:
>     # If we have TF-A binaries, we need to use them.
>     - if [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
>         cp /opt/tf-a/"${TEST_PY_BD}"/fip.bin /opt/tf-a/"${TEST_PY_BD}"/bl1.bin /tmp/;
>         export fip=/tmp/fip.bin;
>         export bl1=/tmp/bl1.bin;
>         export PATH=/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:${PATH};
>       fi
>
> Is how we know what bl1.bin and fip.bin to use as the base.
>

Great to know this, and yes, I think it is good to follow the same way
we have instead of the post-buildman script.
Thanks!

Raymond


> --
> Tom
