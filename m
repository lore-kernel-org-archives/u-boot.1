Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74024CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 16:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63BE08323A;
	Wed, 24 Sep 2025 18:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M2o5AT+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37F02835A2; Wed, 24 Sep 2025 18:28:22 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE74E83071
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 18:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-62fa0653cd1so8429626a12.0
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758731299; x=1759336099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=enOmbs89ZWPgkkT+XWEZR8BH5Pr6AQktoEax4kENiC8=;
 b=M2o5AT+xqbhuUadUJdTnaVRMIj1Jg26JFpvlheqDuvarITJB71PTjKoAflZgxZZ6Yk
 6VLYqjvNLpapSTWq2xeZ5G5xBzhy7k2xZ+xGQ3sFhLRrdlFU0QRR2J8OyN0g/qUhVUOQ
 EUjWan4C+69KQCJGFtA+YdsqmYh7ZoF63b3+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758731299; x=1759336099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=enOmbs89ZWPgkkT+XWEZR8BH5Pr6AQktoEax4kENiC8=;
 b=PfDnUihPdiCka3PEVvwx9UpMBR0NoHKF+/LoUKGvoBOlaATIReex/rAkYSeATJ5yeB
 GxNDoCsut3xS31JdFDNRhd54LuxCy963/Yw+xkx9tImVcjVvMMZ+y7vt2Zt4iSbh4olk
 ZH6rPWZQMpwfEtW9KuUkZtmLhwh+yX0jcVgiVY/EolXyEi4WMs9j9BQ2PvSkJuL8EO6B
 +yyzFPOPEYXDQtomeUzb7ZcyIaIGqCBuEyLo1h17rKPEx5aOsRpCXvZkpI3V5oc72+Xx
 8+XEzG3p6wTKJXL6xoXk7xDYcxCxGPdPbnkyHZe4Ti7I8wf9bdlh8cqV1qfqAFvc7Gzt
 bTqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLgpJVe1I5zxLRmUbNq2Y63cAYBpw3YnWdsjUn3hCdxVPBxbtygtewazETiwVgOARazgitbME=@lists.denx.de
X-Gm-Message-State: AOJu0YzlvtVXf4srHFdIwZa10+jWbM6WupNg7V1714I4bT4huCsl0y8K
 f6OiWcgIzzWAgZfWm517GTR2CXrHeD4SalUPnyXnXeSrrup4FTdRsBxRDtbLLb227ebicVHBU5R
 W8TIW10TYxk1tQAj8bftym11QGTsNtj8NSOngbGNl
X-Gm-Gg: ASbGnctrfVTM+sPOOpLfFMWE0R5k38hCpyNOtR/uWFm70BRWlNSBRHteOyXCTVG14ax
 cWsNu4E1kpz+jeTZGgb45lbw4PU6P7oDJHqwZIen7c/ObWvfaDKw29uQBOYBV39GpOxswzrZIR1
 hjeqiF46aLGN0q7EosRqxjH1Eumrhu5Q0c+UnxOCBkrOh1njgKuVACi0SiKHQsnqDDUsXjshJQG
 yg31g==
X-Google-Smtp-Source: AGHT+IGrebLLOQOlGlLGxT8XWBmE+Uz1WGXkwx1vRS3vzxk94b1EAtTHfJljSxeox01BfcKNZXMgKZKNwZoW+bQ3gpw=
X-Received: by 2002:a17:907:7f8a:b0:b0b:20e5:89ea with SMTP id
 a640c23a62f3a-b34bd93b328mr42106666b.63.1758731299103; Wed, 24 Sep 2025
 09:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-3-raymond.mao@linaro.org>
 <20250916182742.GZ124814@bill-the-cat>
 <CAEfUkUL2t64-hz-_acWHf01WgLeddYu7S8dRudmNT3re0_hfnQ@mail.gmail.com>
 <20250917154926.GM124814@bill-the-cat>
 <CAEfUkUL59toQ4vFN74qhCRdOo1-umqLOKJviZHSedbBWf71tgw@mail.gmail.com>
 <20250922193357.GG124814@bill-the-cat>
In-Reply-To: <20250922193357.GG124814@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Sep 2025 10:28:06 -0600
X-Gm-Features: AS18NWDcbGs-QlfslZzZttAqHDNHoQUSO4YH1BovpnaI1RNFsHTrhRNjayoWGOY
Message-ID: <CAFLszTiRVtc4g4S2eELsGK7ZEz34g8k8w4HZ-Opy0xGhJWpgzg@mail.gmail.com>
Subject: Re: [PATCH 2/5] ci: add post-buildman script to build TF-A
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de, 
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

Hi,

On Mon, 22 Sept 2025 at 13:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Sep 22, 2025 at 03:07:49PM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Wed, 17 Sept 2025 at 11:49, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Sep 17, 2025 at 11:44:07AM -0400, Raymond Mao wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Sep 16, 2025 at 09:14:18AM -0700, Raymond Mao wrote:
> > > > > > Add a script which is running after buildman to fetch TF-A (v2.13.0)
> > > > > > with MbedTLS (v3.6) and build 'flash.bin', linking built U-Boot as
> > > > > > BL33 and OP-TEE as BL32, with both Firmware Handoff and Measured Boot
> > > > > > enabled.
> > > > > >
> > > > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > > > ---
> > > > > >  .azure-pipelines.yml               |  1 +
> > > > > >  .gitlab-ci.yml                     |  1 +
> > > > > >  tools/post_build_tfa_fw_handoff.sh | 87 ++++++++++++++++++++++++++++++
> > > > > >  3 files changed, 89 insertions(+)
> > > > > >  create mode 100755 tools/post_build_tfa_fw_handoff.sh
> > > > > >
> > > > > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > > > > index 8209d2b329c..eb547606ddd 100644
> > > > > > --- a/.azure-pipelines.yml
> > > > > > +++ b/.azure-pipelines.yml
> > > > > > @@ -290,6 +290,7 @@ stages:
> > > > > >            cp /opt/grub/grubriscv64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_riscv64.efi
> > > > > >            cp /opt/grub/grubaa64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm64.efi
> > > > > >            cp /opt/grub/grubarm.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm.efi
> > > > > > +          ./tools/post_build_tfa_fw_handoff.sh \${UBOOT_TRAVIS_BUILD_DIR} \${TEST_PY_BD} \${TEST_PY_ID}
> > > > > >            # create sdcard / spi-nor images for sifive unleashed using genimage
> > > > > >            if [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]]; then
> > > > > >                mkdir -p root;
> > > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > > index 85401d3e09b..61e4af96c9a 100644
> > > > > > --- a/.gitlab-ci.yml
> > > > > > +++ b/.gitlab-ci.yml
> > > > > > @@ -79,6 +79,7 @@ stages:
> > > > > >      - cp /opt/grub/grubriscv64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_riscv64.efi
> > > > > >      - cp /opt/grub/grubaa64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm64.efi
> > > > > >      - cp /opt/grub/grubarm.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm.efi
> > > > > > +    - ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR} ${TEST_PY_BD} ${TEST_PY_ID}
> > > > > >      # create sdcard / spi-nor images for sifive unleashed using genimage
> > > > > >      - if [[ "${TEST_PY_BD}" == "sifive_unleashed" ]]; then
> > > > > >          mkdir -p root;
> > > > > > diff --git a/tools/post_build_tfa_fw_handoff.sh b/tools/post_build_tfa_fw_handoff.sh
> > > > > > new file mode 100755
> > > > > > index 00000000000..f876db593ba
> > > > > > --- /dev/null
> > > > > > +++ b/tools/post_build_tfa_fw_handoff.sh
> > > > >
> > > > > The "is this a valid board" check should be in the pipeline file (like
> > > > > where we do all the other board-specific things) instead of the helper
> > > > > script.
> > > > >
> > > > > > @@ -0,0 +1,87 @@
> > > > > > +#!/bin/bash
> > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > +#
> > > > > > +# Copyright (c) 2025 Linaro Limited
> > > > > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > > > > > +#
> > > > > > +# CI Post-buildman script for building TF-A 'flash.bin' with Measured
> > > > > > +# Boot and Firmware Handoff enabled.
> > > > > > +#
> > > > > > +# Usage: from the top level U-Boot source tree, run:
> > > > > > +# $ ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR} \
> > > > > > +#     ${TEST_PY_BD} ${TEST_PY_ID}
> > > > > > +#
> > > > > > +# 'bl1.bin', 'fip.bin' and 'flash.bin' will be generated and copied
> > > > > > +# to /tmp.
> > > > > > +
> > > > > > +set -e
> > > > > > +
> > > > > > +BUILDMAN_OUT_DIR=$(realpath "$1")
> > > > > > +BOARD=$2
> > > > > > +ID=$4
> > > > > > +echo "Buildman Outdir: $BUILDMAN_OUT_DIR, Board: $BOARD, ID: $ID"
> > > > >
> > > > > Can we not use fiptool to update the contents of a file here? And build
> > > > > as much as possible in the Dockerfile, like we do for vexpress?
> > > > >
> > > > Sorry I am not quite clear about how it was done for fvp, maybe I
> > > > missed some context, do you mean to build TF-A with OP-TEE at
> > > > Dokerfile and generate a fip.bin without BL33? But then who will
> > > > assemble BL1+fip+u-boot? by test hooks?
> > >
> > > So for FVP, in the Dockerfile we say BL33=/dev/null and this gets
> > > packaged correctly. Then in u-boot-test-hooks we have bin/flash.fiptool
> > > which will update "fip" with the just-built u-boot.bin. The logic:
> > >     # If we have TF-A binaries, we need to use them.
> > >     - if [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
> > >         cp /opt/tf-a/"${TEST_PY_BD}"/fip.bin /opt/tf-a/"${TEST_PY_BD}"/bl1.bin /tmp/;
> > >         export fip=/tmp/fip.bin;
> > >         export bl1=/tmp/bl1.bin;
> > >         export PATH=/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:${PATH};
> > >       fi
> > >
> > > Is how we know what bl1.bin and fip.bin to use as the base.
> > >
> >
> > After looking deeper into this, I think we have to pass BL33 when TF-A
> > is being built, instead of appending the fip via fiptool later, since
> > in the added pytest we are going to test eventlog handoff that
> > enabling MEASURED_BOOT is required.
> > But when MEASURED_BOOT=1 (as well as TRUSTED_BOARD_BOOT=1 and
> > GENERATE_COT=1), the TF-A build system performs firmware measurement,
> > signing, and trust chain generation at build time, based on the actual
> > contents of each firmware image, including BL33.
> >
> > If a post-buildman script here is not acceptable we have to find
> > another way, but first of all we cannot build TF-A in the dockerfile
> > missing specifying the BL33.
>
> Interesting. So TF-A doesn't have tooling for replacing and
> re-measuring, and instead you have to re-run make?

Sorry to keep banging on about Binman, but it could provide a
post-build way to re-measure things and poke the updated measurements
into the image? It does some vaguely similar things with ELF symbols.

Regards,
Simon
