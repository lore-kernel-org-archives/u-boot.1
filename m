Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F948CAC5A5
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 16:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 867D28004F;
	Sat, 20 Sep 2025 18:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DHAjsZ9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1979682B07; Sat, 20 Sep 2025 18:13:49 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD3128003E
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 18:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b07c081660aso555209466b.0
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758384826; x=1758989626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a4dzVbiNey4GozIO+owG1eCwqUxduJKglWGq47xgEVg=;
 b=DHAjsZ9uiN0PMZyL/8+ulSfk8mbhGawoKSNU4v1MuLTAalVoAuDHsfEE4y3Q63Cuew
 z9Upirw5wVK9g49qwX6xWUofwu3z20cu9jvpmdgjGR5whWSAj9w4m0ku0NMukedoPEQU
 Wx5ABeXYKrIDUYqcR3tViKTczgwO2FMJonlto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758384826; x=1758989626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a4dzVbiNey4GozIO+owG1eCwqUxduJKglWGq47xgEVg=;
 b=BXv2XrDyPG7JLa3qrHFvCH/wqyeb4lngAswaZwXYIGwMe4w/rSxUTlfXPPY4Z4Z0Zo
 K/dcTbi4RNxu9yJt690GSKyxRGgPqnBmfEUX04qPHEXpvTgSt16wUFVyi0AOeSdCVAiC
 jq3usCCTXDuuKufhd0sv2DLMiTmia63NMm+7m+KWYa7RuAGAVrS26oekcNxO7OXs87Gg
 OPrR15yJlsPrHGHSBFjDJgvw55vMPEWEFumTirdni5JrHg4ufzWd/P1H+xQqDIZLcwqO
 RmhaOi07TVrTjoezrwSqgX/DihFlhC0iLp/R6ViadVy0eZB3gct/R/kC/r4M91Q19bnb
 eO4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXjc3AJ/L7zILgxsNEI54sVTv6z+Hi5d2L0X+7siXmOM/GkhwYWqmDYB0/jKQJ7OP57CNuTIA=@lists.denx.de
X-Gm-Message-State: AOJu0YygCG4grabTf2VYzx3RMWi/lqYEbkUNrSQGcsDUAfFp7DgRBIr3
 AORTGyhWWotwvLm/t7LFZ4bog7iuVtevmm223LfCO1kmYuw7zNcinowFX0vs3hLYJf9Hzi4BVHT
 upV7Z05iS1LrXBie+pT64/0HnxWu/Y+rjORUZpQpr
X-Gm-Gg: ASbGncvDtaTM5GYgt0bPYIPfWTLp+UCMDKbMf6hvzRvesn/xgcdzaZsStG3qKJGwjZm
 Bz7ksBBErBSGA+YSsDbILok+a1CwtU15BSfDarYyL49THbBJ3W4ZSpnPgE+qQcPoH3RdZnO8q8Y
 lvsJ8X6v/KdJVwsVQctRrmd5LPBnsMaXFCs/fedUSOtv/vZx5WcgQcYXQ50n9W4Lw47nX9szBkV
 I+QBR8CA25pSvDd
X-Google-Smtp-Source: AGHT+IFWI6l3sRcvgY9/0oilXSr7utuYUR7u5Eln74UytT6MUUC+PxwQ4R6xG1UdX1FvF555feu96nz+Pu/TdOC5xQk=
X-Received: by 2002:a17:907:9722:b0:b29:b4ac:d2a5 with SMTP id
 a640c23a62f3a-b29b4acd84amr117037366b.16.1758384826256; Sat, 20 Sep 2025
 09:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-3-raymond.mao@linaro.org>
 <20250916182742.GZ124814@bill-the-cat>
 <CAEfUkUL2t64-hz-_acWHf01WgLeddYu7S8dRudmNT3re0_hfnQ@mail.gmail.com>
 <20250917154926.GM124814@bill-the-cat>
 <CAFLszTjBPpgPcqTuAdzhV=HAR01mvzFKBTcNOrxxz4djZ-8h0A@mail.gmail.com>
 <20250919152638.GW124814@bill-the-cat>
In-Reply-To: <20250919152638.GW124814@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 20 Sep 2025 10:13:34 -0600
X-Gm-Features: AS18NWD39EoEEPGqDyLt3zbVQekVwcpt6hRoHhO0GiETnnZjMMF27bRoodwmyto
Message-ID: <CAFLszTgvGT56_r6R8QGpu1kV8PcNUk3diVAguadZeBfKfh6vjw@mail.gmail.com>
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

Hi Tom,

On Fri, 19 Sept 2025 at 09:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 19, 2025 at 09:09:26AM -0600, Simon Glass wrote:
> > Hi Raymond,
> >
> > On Wed, 17 Sept 2025 at 09:49, Tom Rini <trini@konsulko.com> wrote:
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
> > > --
> > > Tom
> >
> > This should actually use binman.  We don't want any shell scripts for
> > building :-) We finally got rid of the FIT generator script after some
> > years.
> >
> > Build mbedtls and TFA should be in dockerfile, like we have for
> > coreboot, for example. I suspect they will be useful in other tests
> > too.
>
> There's nothing to do here for binman, it already supports fiptool. It
> just doesn't make much sense to add the complexity in this case however.

Write a binman description so it creates an image as part of the build
for this board.

It could be a good example if other people want to use TF-A, etc. with U-Boot.

Regards,
Simon
