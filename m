Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30276CAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 15:09:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA65583314;
	Fri, 19 Sep 2025 17:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KSJaTH+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E2628331F; Fri, 19 Sep 2025 17:09:41 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C81E48329F
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 17:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b0418f6fc27so384404466b.3
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758294578; x=1758899378; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NxsSmyp+I/su0XHD9feH2YcbDf5n/EXnKMY85eMvgQs=;
 b=KSJaTH+kmzkmmQH1yRU7jhyjCC1n4GgpjyW2Hha/EWClG5xYCgPdDPokRZx793CKdl
 ByNsaPDFEccxVFjy54YU0ZCH0x7dpKvM2U0PPXy9+BYKNGwSxXOmbYcZzqNVJAZzU6Cu
 /5BCy7cRYWp3nl8fHWYPbC0G9VcosczlV5MD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758294578; x=1758899378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NxsSmyp+I/su0XHD9feH2YcbDf5n/EXnKMY85eMvgQs=;
 b=a2eeCmfmBJOCG2KgTJVUQSZnQ1jxeltv6v3/yLbT++lzRI4l5DOURT3+DO9ikSeKTc
 1LepMfgFT2zJdMMTTt6u3m8tT1vRQbbWoBAf7cD7bRZwFGmczpZI2xsjLmckB3b5pEy+
 uOay8shf4JRcD7i6rsPlY8pJ9iajWh97dUqnmpGgi0Xl7JA8OFV7PxZ30ygGF/fZ6For
 zT/l5CwnSnnBsv/apdp+M4LdP6DE1gdHxPGqVZUPJqzaiy33OTnx0hiO9jZE1iK0kYeF
 0XFrrr+U9jsiOzWFlxJzYuBCD/p/HZcsnMX6Y8OP/oCHVgBSQMcxSI0Sr6Q37WPbgldD
 LVow==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3Q1Z6SUMzgtGuClS5UBcR/ZgKL16nBZksgwmxHCMlpDz13xvCVqzR837SWQinRMcX9sB27JE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2MNOgSZWvmUsiyhjSG3X6nvsaogYOj6q3cWvyjecnlTKwO8P5
 VNDf/asKQLQ0vF1KlssL7NBS6/AEBxkQ1GMB+AkaG7bTEpPcNqbL07Kj37RTKfh6lFWQGylVF/t
 MnPefNXieKFqgAfkvecvD3J+Q92gWkET5x6TS+KR4UyWyoOZBKTI=
X-Gm-Gg: ASbGncvhGg/ottWMkl1Wew3/77r0MEIXtZo8UqhUdIwHV5lWnvkJ44alLpVz2WJuW0y
 ZKz8PG1mROXDIzamoQDAAq+8OjKj63u/gWbrBDNlmym6r/RWFGeXH/ZcC49WFgmbIyKpB1oUo/u
 Zg2fyoPzCRXqEpyHvKc8l1M2fphmbkIJOMVe6KvNFbmOo+QY8pxEmtYw9nO6E7TPuL6Bo3+ZDvP
 xn+XQ==
X-Google-Smtp-Source: AGHT+IG1pyiSt643BrjO0qSwEaPaQpvsTbeyilLLA1Sa1Qk8Jw5IrWybQ+7wLqWfMfoi771bpj3Z+gjSGRxWcoZeTbo=
X-Received: by 2002:a17:906:fe01:b0:afe:f92d:9178 with SMTP id
 a640c23a62f3a-b24f602ba4cmr368492366b.60.1758294578188; Fri, 19 Sep 2025
 08:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-3-raymond.mao@linaro.org>
 <20250916182742.GZ124814@bill-the-cat>
 <CAEfUkUL2t64-hz-_acWHf01WgLeddYu7S8dRudmNT3re0_hfnQ@mail.gmail.com>
 <20250917154926.GM124814@bill-the-cat>
In-Reply-To: <20250917154926.GM124814@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Sep 2025 09:09:26 -0600
X-Gm-Features: AS18NWBdaIFITfzihZyO9EPYpsRHQo08BrXSSOb8n9uyrX_R1PUBtq82RGTGMPA
Message-ID: <CAFLszTjBPpgPcqTuAdzhV=HAR01mvzFKBTcNOrxxz4djZ-8h0A@mail.gmail.com>
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

Hi Raymond,

On Wed, 17 Sept 2025 at 09:49, Tom Rini <trini@konsulko.com> wrote:
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
> --
> Tom

This should actually use binman.  We don't want any shell scripts for
building :-) We finally got rid of the FIT generator script after some
years.

Build mbedtls and TFA should be in dockerfile, like we have for
coreboot, for example. I suspect they will be useful in other tests
too.

Regards,
Simon
