Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBE6CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 15:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A43B183623;
	Wed, 17 Sep 2025 17:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bSDdj5EO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C330083622; Wed, 17 Sep 2025 17:44:22 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E03F83622
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 17:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b54a74f9150so4925473a12.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758123858; x=1758728658; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tinDZkNIAuXuN5t8ldoguY82bFsH3OcQV/WttOI9Uxo=;
 b=bSDdj5EOktqVCzEFwQ77dVGSojYKAjIwl6e9C/VNgb9IpVlHksEdf200VrU8j1kdFD
 mTpG9YReddqrO4sdS8j1WcaWWZh3xLd/NFqpH9ir+OOuRFjeuSCk9IQmFswS6FYwPF3e
 FwQo8QnV+p0nfgi58G3S9ow4Ha9FgRH4/dtJjGNHZtx8GWtFSAOhwj8m+isiPy1A8twy
 HO0YWIumd5m7qr1MPzjfQzQ60dWkwirCTnWylcgkGnDv5urEYP3nhu7zBTWGZ3JBzwCJ
 Z9dZQM51xaXZGuOlrlUWnadJD9BWAseEHcU5kxJzp4fEl/88aldIP5xaIUgWvhhomhMN
 hatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758123858; x=1758728658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tinDZkNIAuXuN5t8ldoguY82bFsH3OcQV/WttOI9Uxo=;
 b=miGgjuUr1rqmNbPCLVsdD62rrtm79fcTyZo5n4nkPoYa9qMMaXdLi+jjkAaxZezDJC
 PVWLgjxAl4QKgZrTIzvtGaMM9UCRb4jcGT+fNHH17AqVC8kcs5TjJgdCIh93y6gGEuXC
 h1IPnxSsIxTItube1EgvgJzpWkpu2fno9TnNI13Rj0MuIwMOrbpFoi+eNa/PQ5UHVmDT
 VO406Kp0IvT3tAEdC0rbK3A5vAh72GEjBQfYgc4M/oZkM9RtJaKZtdtyZU4gwUw76t8L
 OjxepsOzhahRJ3VPdj0nMeBK+WG/wM/zkWG6XEIRSDH2yv5tAYLFqv92zQAicw8xGnRJ
 0QqA==
X-Gm-Message-State: AOJu0YxRw+k9PqaL7VRnbODwE1mbxI40/8NTFlQHgW+8DK7JX5O7IZpx
 E6PbOSwFz1FdaPxbvjC2XW3wZha/Tueb1D5s74LzrLrAVmEKyhztkGyOKuzQ6wFZ7CXe1UDx/1H
 t1B1tUijTz8vLfaJbsRivBkyhSg6aNQZmGkjRLbhPmg==
X-Gm-Gg: ASbGncujLMWJnb3Csyfz8k1i+W4NLHxcf7BPzRYQWIFoD7n4teNxWEYfbuji6iO/Z4b
 2mMmHagaSw+KkrljikE/u9Yv+E0vQexvMYRXRwZIoot6LZ0zThDk1B7y5oV3aDwig3yWxHec2bZ
 IktIMaIdgelm2rsEsCyiaIsKPnjC0ZaPJnF3F1iV1+6Ju0g8i95OpJoVvHyhQwpQq+bj0AUSqA8
 AFjFgfQpQ==
X-Google-Smtp-Source: AGHT+IGZ21oWk/X53qFwo2WlEIbaZz4A22xDxaynDSuHnddKIdpDDfnogefiBhkmtoVYp8z4y0Xn07I+1n+hwjRCi3E=
X-Received: by 2002:a17:902:d2ca:b0:268:1034:ac8b with SMTP id
 d9443c01a7336-26812189d01mr32232055ad.26.1758123858251; Wed, 17 Sep 2025
 08:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-3-raymond.mao@linaro.org>
 <20250916182742.GZ124814@bill-the-cat>
In-Reply-To: <20250916182742.GZ124814@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 17 Sep 2025 11:44:07 -0400
X-Gm-Features: AS18NWDihjQnrDM3R7cGB-TU9DqxcN2XPenPbOThw5lL7X4hqDDYpX_8oTnBgFw
Message-ID: <CAEfUkUL2t64-hz-_acWHf01WgLeddYu7S8dRudmNT3re0_hfnQ@mail.gmail.com>
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

On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Sep 16, 2025 at 09:14:18AM -0700, Raymond Mao wrote:
> > Add a script which is running after buildman to fetch TF-A (v2.13.0)
> > with MbedTLS (v3.6) and build 'flash.bin', linking built U-Boot as
> > BL33 and OP-TEE as BL32, with both Firmware Handoff and Measured Boot
> > enabled.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  .azure-pipelines.yml               |  1 +
> >  .gitlab-ci.yml                     |  1 +
> >  tools/post_build_tfa_fw_handoff.sh | 87 ++++++++++++++++++++++++++++++
> >  3 files changed, 89 insertions(+)
> >  create mode 100755 tools/post_build_tfa_fw_handoff.sh
> >
> > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > index 8209d2b329c..eb547606ddd 100644
> > --- a/.azure-pipelines.yml
> > +++ b/.azure-pipelines.yml
> > @@ -290,6 +290,7 @@ stages:
> >            cp /opt/grub/grubriscv64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_riscv64.efi
> >            cp /opt/grub/grubaa64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm64.efi
> >            cp /opt/grub/grubarm.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm.efi
> > +          ./tools/post_build_tfa_fw_handoff.sh \${UBOOT_TRAVIS_BUILD_DIR} \${TEST_PY_BD} \${TEST_PY_ID}
> >            # create sdcard / spi-nor images for sifive unleashed using genimage
> >            if [[ "\${TEST_PY_BD}" == "sifive_unleashed" ]]; then
> >                mkdir -p root;
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 85401d3e09b..61e4af96c9a 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -79,6 +79,7 @@ stages:
> >      - cp /opt/grub/grubriscv64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_riscv64.efi
> >      - cp /opt/grub/grubaa64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm64.efi
> >      - cp /opt/grub/grubarm.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm.efi
> > +    - ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR} ${TEST_PY_BD} ${TEST_PY_ID}
> >      # create sdcard / spi-nor images for sifive unleashed using genimage
> >      - if [[ "${TEST_PY_BD}" == "sifive_unleashed" ]]; then
> >          mkdir -p root;
> > diff --git a/tools/post_build_tfa_fw_handoff.sh b/tools/post_build_tfa_fw_handoff.sh
> > new file mode 100755
> > index 00000000000..f876db593ba
> > --- /dev/null
> > +++ b/tools/post_build_tfa_fw_handoff.sh
>
> The "is this a valid board" check should be in the pipeline file (like
> where we do all the other board-specific things) instead of the helper
> script.
>
> > @@ -0,0 +1,87 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Copyright (c) 2025 Linaro Limited
> > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > +#
> > +# CI Post-buildman script for building TF-A 'flash.bin' with Measured
> > +# Boot and Firmware Handoff enabled.
> > +#
> > +# Usage: from the top level U-Boot source tree, run:
> > +# $ ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR} \
> > +#     ${TEST_PY_BD} ${TEST_PY_ID}
> > +#
> > +# 'bl1.bin', 'fip.bin' and 'flash.bin' will be generated and copied
> > +# to /tmp.
> > +
> > +set -e
> > +
> > +BUILDMAN_OUT_DIR=$(realpath "$1")
> > +BOARD=$2
> > +ID=$4
> > +echo "Buildman Outdir: $BUILDMAN_OUT_DIR, Board: $BOARD, ID: $ID"
>
> Can we not use fiptool to update the contents of a file here? And build
> as much as possible in the Dockerfile, like we do for vexpress?
>
Sorry I am not quite clear about how it was done for fvp, maybe I
missed some context, do you mean to build TF-A with OP-TEE at
Dokerfile and generate a fip.bin without BL33? But then who will
assemble BL1+fip+u-boot? by test hooks?

Raymond

> --
> Tom
