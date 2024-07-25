Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59132C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1AED87919;
	Thu, 25 Jul 2024 15:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fo1PdA7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2591F87C38; Thu, 25 Jul 2024 15:39:26 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 368478641C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fd6ed7688cso8140915ad.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721914762; x=1722519562; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bmrtAC5MnNHRTd01U2ftySSlwZF3LZzG9WfeD+3eRUk=;
 b=Fo1PdA7SkvEzf9vFoia4ca7ecnY/cmCwc7LN2zJJfiXUerWrrPDB9isDd5Z1UmKt7q
 uQxZoYiueqkNLPEY2P1CGStyifGpnYqAZKPbW5K6vCNEwN+VMw3AoL3o3dKwhlgbqYAK
 EAcfEvDmrFvSlCs2fsDkoak/Io1OnNJNffmFvyAmfFWhY6I6j31emw8/ud1N526C7DYg
 NOephyW5wo+3WN6i4hSaA33ST/ckmYInYKqkuRMPaacjqYjecnBrl3SlbPRJ4voXafcE
 LlT1Tzxe3HDuwCb16cPoRBKsgxl3xKi8j1+sFV0B3HHg0tVdT0ky+hD8ieZy4jAr7ZCh
 mWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721914762; x=1722519562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bmrtAC5MnNHRTd01U2ftySSlwZF3LZzG9WfeD+3eRUk=;
 b=Wl64tvth33dpeUtO12L/Nl2F7LYZLco0PDPjiWflsKOyM/P8ka0JqWni0Ypan2UXJK
 PZjbdioJy6MVf3QzTnSUCxyB9xHnYaGJQ0TDWUIFafYBenYJCWF6GyX+3Sr+Ye7O+I3p
 tpuFrDTiXrkvxYzH78J/5LtxU5MAFW938cVxa8e2OoiD7DeXnPHSb2uc0rtAwho55RYe
 RI/tecSXbjvOJhc7ebVNaHlC+u/F1gRLxb5iZFYRsYgyK9//jsG2MwgP4hND2sQAGH9y
 bT0gGQR+7I+YoYwuMyFeWz6kxtaGBWR1p2z/w/O4L8KFwPGwObXNDTyJziw/JVQLDh26
 7g0g==
X-Gm-Message-State: AOJu0YylYFRtPu2eM0prSUOPcJloHV4wCNyGIPSC9FFI4udgtSFxieSm
 LUT89YV4Pbr88FEMf4Bj0nfvEl4mihQ+tHj4gLnnq95VlCURwg7kDRY0bG1p5UjbMai5BzHoHYh
 7fteZ3B0/S4XMJpq3egMtiVBFm+NjF7z650GvLg==
X-Google-Smtp-Source: AGHT+IG3y8NedClnvBWuuVzR9JEo7U+wKueOWKY2qU+ziheo9nIaqX18Yz0n00KCM4B3sarDjO3usrNSogYt4xaElw4=
X-Received: by 2002:a17:90a:6345:b0:2c9:7cc8:8e33 with SMTP id
 98e67ed59e1d1-2cf237b7e93mr3562116a91.13.1721914761528; Thu, 25 Jul 2024
 06:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240722193052.57592-1-raymond.mao@linaro.org>
 <CAFA6WYNm6roHW3KsENtq2nLfhmZV1xeUzak6CUyHj6oFy=yQqA@mail.gmail.com>
 <CAEfUkUJtbo+GWCsf_CMUvA=t8ck6tjmhJzZQbsy3PYTfukTqDw@mail.gmail.com>
 <CAFA6WYODJOJnAhodMxEkyVTgeBEcvPO4WZezT4cVbXp6OnabEg@mail.gmail.com>
In-Reply-To: <CAFA6WYODJOJnAhodMxEkyVTgeBEcvPO4WZezT4cVbXp6OnabEg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 25 Jul 2024 09:39:09 -0400
Message-ID: <CAEfUkUKLj8eLgDHLK6ZNLYPduqHFaWGoi7k5fT+gup6Z1U+K7w@mail.gmail.com>
Subject: Re: [PATCH v2] tools: Add script to update git subtree projects
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Sumit,

On Thu, 25 Jul 2024 at 01:46, Sumit Garg <sumit.garg@linaro.org> wrote:

> On Wed, 24 Jul 2024 at 19:40, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Sumit,
> >
> > On Wed, 24 Jul 2024 at 03:08, Sumit Garg <sumit.garg@linaro.org> wrote:
> >>
> >> Hi Raymond,
> >>
> >> Thanks for doing this.
> >>
> >> On Tue, 23 Jul 2024 at 01:01, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> >> >
> >> > Recently we are introducing multiple git subtree projects and
> >> > it is the right time to have a universal script to update
> >> > various subtrees and replace the dts/update-dts-subtree.sh.
> >> >
> >> > update-subtree.sh is a wrapper of git subtree commands.
> >> >
> >> > Usage: From U-Boot top directory,
> >> > run
> >> > $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
> >> > for pulling a tag from the upstream.
> >> > Or run
> >> > $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
> >> > for cherry-pick a commit from the upstream.
> >> >
> >> > Currently <subtree-name> supports dts, mbedtls and lwip.
> >> >
> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> > ---
> >> > Changes in v2
> >> > - Refactored the script.
> >> > - Update the control doc.
> >> >
> >> >  doc/develop/devicetree/control.rst |  8 +--
> >> >  dts/update-dts-subtree.sh          | 48 -----------------
> >> >  tools/update-subtree.sh            | 86
> ++++++++++++++++++++++++++++++
> >> >  3 files changed, 90 insertions(+), 52 deletions(-)
> >> >  delete mode 100755 dts/update-dts-subtree.sh
> >> >  create mode 100755 tools/update-subtree.sh
> >> >
> >> > diff --git a/doc/develop/devicetree/control.rst
> b/doc/develop/devicetree/control.rst
> >> > index ca4fb0b5b10..211f7e4909c 100644
> >> > --- a/doc/develop/devicetree/control.rst
> >> > +++ b/doc/develop/devicetree/control.rst
> >> > @@ -96,12 +96,12 @@ sync the `dts/upstream/` subtree from the
> devicetree-rebasing repo whenever
> >> >  the next branch opens (refer: :doc:`../release_cycle`) with the
> latest mainline
> >> >  Linux kernel release. To sync the `dts/upstream/` subtree, run::
> >> >
> >> > -    ./dts/update-dts-subtree.sh pull
> <devicetree-rebasing-release-tag>
> >> > +    ./tools/update-subtree.sh pull dts
> <devicetree-rebasing-release-tag>
> >> >
> >> >  If required it is also possible to cherry-pick fixes from the
> >> >  devicetree-rebasing repository prior to next sync, usage::
> >> >
> >> > -    ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
> >> > +    ./tools/update-subtree.sh pick dts
> <devicetree-rebasing-commit-id>
> >> >
> >> >
> >> >  Configuration
> >> > @@ -116,8 +116,8 @@ However, if `dts/upstream/` hasn't yet received
> devicetree source file for your
> >> >  newly added board support then one option is that you can add the
> corresponding
> >> >  devicetree source file as `arch/<arch>/dts/<name>.dts`. To select
> that add `#
> >> >  CONFIG_OF_UPSTREAM is not set` and set `DEFAULT_DEVICE_TREE=<name>`
> when
> >> > -prompted by Kconfig. Another option is that you can use use the
> "pick" option of
> >> > -`dts/update-dts-subtree.sh` mentioned above to bring in the commits
> that you
> >> > +prompted by Kconfig. Another option is that you can use the "pick"
> option of
> >> > +`tools/update-subtree.sh` mentioned above to bring in the commits
> that you
> >> >  need.
> >> >
> >> >  This should include your CPU or SoC's devicetree file. On top of
> that any U-Boot
> >> > diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
> >> > deleted file mode 100755
> >> > index a57b78a41d3..00000000000
> >> > --- a/dts/update-dts-subtree.sh
> >> > +++ /dev/null
> >> > @@ -1,48 +0,0 @@
> >> > -#!/bin/sh
> >> > -# SPDX-License-Identifier: GPL-2.0+
> >> > -#
> >> > -# Copyright 2024 Linaro Ltd.
> >> > -#
> >> > -# Usage: from the top level U-Boot source tree, run:
> >> > -# $ ./dts/update-dts-subtree.sh pull <release-tag>
> >> > -# $ ./dts/update-dts-subtree.sh pick <commit-id>
> >> > -#
> >> > -# The script will pull changes from devicetree-rebasing repo into
> U-Boot
> >> > -# as a subtree located as <U-Boot>/dts/upstream sub-directory. It
> will
> >> > -# automatically create a squash/merge commit listing the commits
> imported.
> >> > -
> >> > -set -e
> >> > -
> >> > -merge_commit_msg=$(cat << EOF
> >> > -Subtree merge tag '$2' of devicetree-rebasing repo [1] into
> dts/upstream
> >> > -
> >> > -[1]
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> >> > -EOF
> >> > -)
> >> > -
> >> > -remote_add_and_fetch() {
> >> > -    if ! git remote get-url devicetree-rebasing 2>/dev/null
> >> > -    then
> >> > -        echo "Warning: Script automatically adds new git remote via:"
> >> > -        echo "    git remote add devicetree-rebasing \\"
> >> > -        echo "
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> "
> >> > -        git remote add devicetree-rebasing \
> >> > -
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> >> > -    fi
> >> > -    git fetch devicetree-rebasing master
> >> > -}
> >> > -
> >> > -if [ "$1" = "pull" ]
> >> > -then
> >> > -    remote_add_and_fetch
> >> > -    git subtree pull --prefix dts/upstream devicetree-rebasing \
> >> > -        "$2" --squash -m "${merge_commit_msg}"
> >> > -elif [ "$1" = "pick" ]
> >> > -then
> >> > -    remote_add_and_fetch
> >> > -    git cherry-pick -x --strategy=subtree -Xsubtree=dts/upstream/
> "$2"
> >> > -else
> >> > -    echo "usage: $0 <op> <ref>"
> >> > -    echo "  <op>     pull or pick"
> >> > -    echo "  <ref>    release tag [pull] or commit id [pick]"
> >> > -fi
> >> > diff --git a/tools/update-subtree.sh b/tools/update-subtree.sh
> >> > new file mode 100755
> >> > index 00000000000..5946aa1a9e2
> >> > --- /dev/null
> >> > +++ b/tools/update-subtree.sh
> >> > @@ -0,0 +1,86 @@
> >> > +#!/bin/sh
> >> > +# SPDX-License-Identifier: GPL-2.0+
> >> > +#
> >> > +# Copyright (c) 2024 Linaro Limited
> >> > +# Author: Raymond Mao <raymond.mao@linaro.org>
>
> Something I forgot earlier, if you are going to add explicit
> authorship then you should retain the prior author too from where this
> script is derived.
>
> Sorry about it, I will update the file header.

Raymond
