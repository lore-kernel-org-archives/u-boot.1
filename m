Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E6FCAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 19:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F48832F9;
	Mon, 22 Sep 2025 21:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="poJccad4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5575833ED; Mon, 22 Sep 2025 21:08:05 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3ED583211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 21:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2445805aa2eso49077535ad.1
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758568081; x=1759172881; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sjTM3C1ZmwZUx5ua18EyabAIgJCo17Xg49u2d4lRyA4=;
 b=poJccad4fVn2QIlaMqlwDwNm0JqxHojTD9I/iLqqo9Ph6ZaieeQZ3amVMWjHdynNOH
 5WKuoTxj1LwZxNHXH2W5QpvNR8201G2dfe+F4PasoPX25Q1lpZJSlxnNewt3qMn52B96
 tOTteJdOeAbXNzkH3NkjBfS0mrjUbC6TsfOD/rCAIcH7H0DpyJQ6I9VQLN8Odh2cKpdC
 p/7QXYNGQxPQXJNCw+he9MHevPH0xagILzNpJbMpsj7RtceZWy4vYXO1pRY7BZvOhAOL
 flrChCAm5hv3Lca7wCgBz4DK+BIp3BoATxudW7EoFaODNEueE76HLcxDywg3qI5wXIf5
 8ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758568081; x=1759172881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sjTM3C1ZmwZUx5ua18EyabAIgJCo17Xg49u2d4lRyA4=;
 b=glZhqDJUklUH2u5TREv3No66JN57rCFY9Wsvi06phmZSViJSJ/nUlomLryyiU/uAjh
 YVUT+Q+C7sprjjrfw/vniHqed5DhwXOT639/oimn6jPwoFeN9aP/pqS/DjAB2MDtj9ms
 ieB7pPQXMYz/cbDwDfbG6wDvk7KBIth6aJLx8kv9lBxFnwd1BfP9G9fyd8Y00RWyNY/q
 aFb5M6k2ft6Ojgn8D2lDghi0B7QB5iqftzDskBiUbNc9eCr5rc04bvCe12n6Qym3MsCY
 RLFXTZXX4H0PCPMjLJTlh7NZJR0vIVLIe3OxjRLo0IVMjk48q8+eEvSmkZvTlCcLE7Vv
 tviw==
X-Gm-Message-State: AOJu0Yzg2OBAPvnbKuSnaTbXiACLWJVV3asEace4r3KZNlHRE2pTT9Ph
 x1HKwrfEqLCDma9/fsSaE4LJK2jk8lUHe6QreRYxvK2JcjGZft7CozQ05o1haXqNRpQLLVDK7MU
 rZcHQ2GffNjq5ul18Wiic3dEncXZ9AAlpgcHnEj8BogGA+VKTJ5bAv5A=
X-Gm-Gg: ASbGncurfrj7kyznSPji28p9TBCR41LbRIsdR4SuKtq9kB4fpN314A8AR66M9bFAanf
 kBukwRoVFh8G7pkaq2uBDkim8OGwJVhNxDM0PG/M5FkpNNfbp0rIxNYkZY6eUPr/N+wVZRsWY0o
 a+5cPI5yUwdubYPBqzpxAvBKLgDg8GU1Wk7EbXx4pefs/5N70ByMzwj5e0C2rRTinEJo1TjVuR4
 VbBxXNanw==
X-Google-Smtp-Source: AGHT+IERZeLh3k145HnJkBA+W1TSSK4QP8ULCziPNzyF0E9/gPYejK4OaJghDOJfUnp5O/tgPVZ4YxHvI4Pray/iyMI=
X-Received: by 2002:a17:902:e88f:b0:26e:e6ab:66fe with SMTP id
 d9443c01a7336-26ee6ab6903mr151737445ad.5.1758568080790; Mon, 22 Sep 2025
 12:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-3-raymond.mao@linaro.org>
 <20250916182742.GZ124814@bill-the-cat>
 <CAEfUkUL2t64-hz-_acWHf01WgLeddYu7S8dRudmNT3re0_hfnQ@mail.gmail.com>
 <20250917154926.GM124814@bill-the-cat>
In-Reply-To: <20250917154926.GM124814@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 22 Sep 2025 15:07:49 -0400
X-Gm-Features: AS18NWA669zTAYWxjNBq9LtALSu87WBdNciJrspN2yKKCkGaDCsFO27-XkIGkUw
Message-ID: <CAEfUkUL59toQ4vFN74qhCRdOo1-umqLOKJviZHSedbBWf71tgw@mail.gmail.com>
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

After looking deeper into this, I think we have to pass BL33 when TF-A
is being built, instead of appending the fip via fiptool later, since
in the added pytest we are going to test eventlog handoff that
enabling MEASURED_BOOT is required.
But when MEASURED_BOOT=1 (as well as TRUSTED_BOARD_BOOT=1 and
GENERATE_COT=1), the TF-A build system performs firmware measurement,
signing, and trust chain generation at build time, based on the actual
contents of each firmware image, including BL33.

If a post-buildman script here is not acceptable we have to find
another way, but first of all we cannot build TF-A in the dockerfile
missing specifying the BL33.

Regards,
Raymond


> --
> Tom
