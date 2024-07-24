Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19794C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 14:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DED58888E;
	Wed, 24 Jul 2024 16:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V2/s/suw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7962A8891E; Wed, 24 Jul 2024 16:11:04 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1154988881
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 16:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7a92098ec97so344546a12.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721830255; x=1722435055; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3UUEWHp4npjDTAjDiJ9X+02KcNEQCvkkWlsbGM7eNi4=;
 b=V2/s/suwlMFL4daHHz+bfpYqPZq82xVhkClzsQ8uRHCL+eenok7sEaMA2JLSx+13Uk
 nvORxH0/JWdp2vY1sLRMw6dBwqqR+wGCj4Ay4+2wlzZ5bLwKRCKl5+zs2iy2tH7r2FV8
 XsiIZEFGJtP5lSTpEcs+JSP7qSQ6bFoGRa2u37yVu3iPTcpQCd9mjLSqTbaklE3yOXhL
 JF1qXzP6WSsfd/svX+jCxZEvbgv7K5MkFUhAN4yx3BmT3llZI34ag8IAnuTIprW5kUQL
 HeERA1wgxSWIBRq2eT0T1Mdh8EfbNLsmOL16HH6LRAsZjmWk/2pHEzjUZ1FdYCaFcHvV
 O7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721830255; x=1722435055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3UUEWHp4npjDTAjDiJ9X+02KcNEQCvkkWlsbGM7eNi4=;
 b=tNgZnIOKtN+QT5pp6HP80r31CnNl9RultiuxK3MTtBjpHZJA/UhOcAg/A1dWVomFNV
 KhAbnjtuqE41VfarM73yQ8rC4d+xtPaorQevJ81hFNfNPyErkZQMo1jgWd0OvoO7nb9J
 pl2a0VqDenS2xwA+ZG7UuOhHYEICIWgiktOV2KpoHpzfQuao+mC89x5A6WAMgplFBUl6
 Hy5wT7K1XcLweyAmvGCqAfL4rwNpTnAenf2Kq9LJ9Xp0uDyBkmPoEEReGaXz83UtKPF5
 5geylF64FfvEYfZwoeegK03WuA8erVDgbL3d+pVZb7TPCz8IHN90G85oLXeLIpJQWKP7
 BLDA==
X-Gm-Message-State: AOJu0YygwMeE0KyjaRr+hQ982EhyxJQrbNhf3hFV/La0uasgZrCGo27J
 me/Eoj22mh2M+R2HOr10hD8t4z31Q4fq4hs4fdPwkskY0SOr7FCmWRvz/1R7K0rysFQdyBguNlc
 cOfXfW3wdSMF3mt+QtxyT3CU2XLXwkhVWr/6ckA==
X-Google-Smtp-Source: AGHT+IGUhelnxGlCimhEF9tzwj28/OTW4t7VYgCLuPwIxGdHUGVytlvVWeGNPASGOYrquBh02dbikMFN2NZUH2usGXM=
X-Received: by 2002:a17:90a:ea07:b0:2c9:a56b:8db6 with SMTP id
 98e67ed59e1d1-2cdb51b3a1bmr2451168a91.37.1721830255342; Wed, 24 Jul 2024
 07:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240722193052.57592-1-raymond.mao@linaro.org>
 <CAFA6WYNm6roHW3KsENtq2nLfhmZV1xeUzak6CUyHj6oFy=yQqA@mail.gmail.com>
In-Reply-To: <CAFA6WYNm6roHW3KsENtq2nLfhmZV1xeUzak6CUyHj6oFy=yQqA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 24 Jul 2024 10:10:42 -0400
Message-ID: <CAEfUkUJtbo+GWCsf_CMUvA=t8ck6tjmhJzZQbsy3PYTfukTqDw@mail.gmail.com>
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

On Wed, 24 Jul 2024 at 03:08, Sumit Garg <sumit.garg@linaro.org> wrote:

> Hi Raymond,
>
> Thanks for doing this.
>
> On Tue, 23 Jul 2024 at 01:01, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Recently we are introducing multiple git subtree projects and
> > it is the right time to have a universal script to update
> > various subtrees and replace the dts/update-dts-subtree.sh.
> >
> > update-subtree.sh is a wrapper of git subtree commands.
> >
> > Usage: From U-Boot top directory,
> > run
> > $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
> > for pulling a tag from the upstream.
> > Or run
> > $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
> > for cherry-pick a commit from the upstream.
> >
> > Currently <subtree-name> supports dts, mbedtls and lwip.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Refactored the script.
> > - Update the control doc.
> >
> >  doc/develop/devicetree/control.rst |  8 +--
> >  dts/update-dts-subtree.sh          | 48 -----------------
> >  tools/update-subtree.sh            | 86 ++++++++++++++++++++++++++++++
> >  3 files changed, 90 insertions(+), 52 deletions(-)
> >  delete mode 100755 dts/update-dts-subtree.sh
> >  create mode 100755 tools/update-subtree.sh
> >
> > diff --git a/doc/develop/devicetree/control.rst
> b/doc/develop/devicetree/control.rst
> > index ca4fb0b5b10..211f7e4909c 100644
> > --- a/doc/develop/devicetree/control.rst
> > +++ b/doc/develop/devicetree/control.rst
> > @@ -96,12 +96,12 @@ sync the `dts/upstream/` subtree from the
> devicetree-rebasing repo whenever
> >  the next branch opens (refer: :doc:`../release_cycle`) with the latest
> mainline
> >  Linux kernel release. To sync the `dts/upstream/` subtree, run::
> >
> > -    ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>
> > +    ./tools/update-subtree.sh pull dts <devicetree-rebasing-release-tag>
> >
> >  If required it is also possible to cherry-pick fixes from the
> >  devicetree-rebasing repository prior to next sync, usage::
> >
> > -    ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
> > +    ./tools/update-subtree.sh pick dts <devicetree-rebasing-commit-id>
> >
> >
> >  Configuration
> > @@ -116,8 +116,8 @@ However, if `dts/upstream/` hasn't yet received
> devicetree source file for your
> >  newly added board support then one option is that you can add the
> corresponding
> >  devicetree source file as `arch/<arch>/dts/<name>.dts`. To select that
> add `#
> >  CONFIG_OF_UPSTREAM is not set` and set `DEFAULT_DEVICE_TREE=<name>` when
> > -prompted by Kconfig. Another option is that you can use use the "pick"
> option of
> > -`dts/update-dts-subtree.sh` mentioned above to bring in the commits
> that you
> > +prompted by Kconfig. Another option is that you can use the "pick"
> option of
> > +`tools/update-subtree.sh` mentioned above to bring in the commits that
> you
> >  need.
> >
> >  This should include your CPU or SoC's devicetree file. On top of that
> any U-Boot
> > diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
> > deleted file mode 100755
> > index a57b78a41d3..00000000000
> > --- a/dts/update-dts-subtree.sh
> > +++ /dev/null
> > @@ -1,48 +0,0 @@
> > -#!/bin/sh
> > -# SPDX-License-Identifier: GPL-2.0+
> > -#
> > -# Copyright 2024 Linaro Ltd.
> > -#
> > -# Usage: from the top level U-Boot source tree, run:
> > -# $ ./dts/update-dts-subtree.sh pull <release-tag>
> > -# $ ./dts/update-dts-subtree.sh pick <commit-id>
> > -#
> > -# The script will pull changes from devicetree-rebasing repo into U-Boot
> > -# as a subtree located as <U-Boot>/dts/upstream sub-directory. It will
> > -# automatically create a squash/merge commit listing the commits
> imported.
> > -
> > -set -e
> > -
> > -merge_commit_msg=$(cat << EOF
> > -Subtree merge tag '$2' of devicetree-rebasing repo [1] into dts/upstream
> > -
> > -[1]
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> > -EOF
> > -)
> > -
> > -remote_add_and_fetch() {
> > -    if ! git remote get-url devicetree-rebasing 2>/dev/null
> > -    then
> > -        echo "Warning: Script automatically adds new git remote via:"
> > -        echo "    git remote add devicetree-rebasing \\"
> > -        echo "
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> "
> > -        git remote add devicetree-rebasing \
> > -
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> > -    fi
> > -    git fetch devicetree-rebasing master
> > -}
> > -
> > -if [ "$1" = "pull" ]
> > -then
> > -    remote_add_and_fetch
> > -    git subtree pull --prefix dts/upstream devicetree-rebasing \
> > -        "$2" --squash -m "${merge_commit_msg}"
> > -elif [ "$1" = "pick" ]
> > -then
> > -    remote_add_and_fetch
> > -    git cherry-pick -x --strategy=subtree -Xsubtree=dts/upstream/ "$2"
> > -else
> > -    echo "usage: $0 <op> <ref>"
> > -    echo "  <op>     pull or pick"
> > -    echo "  <ref>    release tag [pull] or commit id [pick]"
> > -fi
> > diff --git a/tools/update-subtree.sh b/tools/update-subtree.sh
> > new file mode 100755
> > index 00000000000..5946aa1a9e2
> > --- /dev/null
> > +++ b/tools/update-subtree.sh
> > @@ -0,0 +1,86 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Copyright (c) 2024 Linaro Limited
> > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > +#
> > +# Usage: from the top level U-Boot source tree, run:
> > +# $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
> > +# Or:
> > +# $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
> > +#
> > +# The script will pull changes from subtree repo into U-Boot.
> > +# It will automatically create a squash/merge commit listing the commits
> > +# imported.
> > +
> > +set -e
> > +
> > +print_usage() {
> > +    echo "usage: $0 <op> <subtree-name> <ref>"
> > +    echo "  <op>           pull or pick"
> > +    echo "  <subtree-name> mbedtls or dts or lwip"
> > +    echo "  <ref>          release tag [pull] or commit id [pick]"
> > +}
> > +
> > +if [ $# -ne 3 ]; then
> > +    print_usage
> > +    exit 1
> > +fi
> > +
> > +op=$1
> > +subtree_name=$2
> > +ref=$3
> > +
> > +set_params() {
> > +    case "$subtree_name" in
> > +        mbedtls)
> > +            path=lib/mbedtls/external/mbedtls
>
> Although I am in favour of making this script generic, this subdir
> path doesn't exist yet. Wouldn't it make more sense to add mbedtls
> here alongside the corresponding patch-set? Otherwise the script will
> just fail.
>
> Actually this patch is split from the MbedTLS series which is under review.
I think this should be fine before merging the MbedTLS/LWIP series, since
it is supposed to be run by maintainers only. And the failing message
explains
that the sub-project dir does not exist which should be sufficient at the
moment.

Regards,
Raymond
