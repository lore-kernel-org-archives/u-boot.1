Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26900C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 14:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 809B9887FA;
	Tue, 23 Jul 2024 16:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JTZe0a6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19A1288800; Tue, 23 Jul 2024 16:05:37 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1147A887E7
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 16:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2cb09dc1dafso2842804a91.2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 07:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721743526; x=1722348326; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yjmijZJz8MQCbwZkr6a1aaLFm4wBQ/LZRvwH911o9no=;
 b=JTZe0a6QWg4Nzq18diwWggUO+lM3yH/I7Nq3t8PpJCm5xGb2vI97SQLI4hJqBd7umN
 1N99hpl3QEzPOqoVTQAQFiQ+BUjv5Ydr+skGv/EjOhZ2VPQJuU+1nCqYz0LvCcyF9W7u
 EgaNNRrkFbbbr6R37y8AulJ7+Otw0lCZWb6u4UXJgyb3iQDRd1O4AVRJ2U8+Owwh96a2
 TGTIn58k8zbuBXyxSm4x6LnsKWDWAIkCt7hLvSIThHI64m2W+PHooO1PAxwPKg3g7yIy
 0yOM0U5KsjAZ+wzv5ev3sbV/d7q/IYvJSotXa1k5f1H8G2gY8/+LRtyio96wME2bY4ot
 Le8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721743526; x=1722348326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yjmijZJz8MQCbwZkr6a1aaLFm4wBQ/LZRvwH911o9no=;
 b=sIxAGGSitLcWxTuV02Ux1s/+HQCL3O1B0zATIThwYCaol/6SEvzixhuhytgZQUiT9S
 qrA/QMiF2l49k+nJgfyxvORfR8XiJlVl1N7JeJaD0kciACnDGjq15MO/cX6gzBQjURMM
 tUMLKNCDdIL9NvtyK3nSAufxPw5Y3aQCmxcO5FsajCkyvP2ipr+987v6Eg7OgiWG7g6W
 Uk1BYO1L11bAtrqHu8WzgtplpXKW/UZCP7gCbKu4PnI8PLHlLd2lm0JCkAgXZQCNkl8P
 6fdmj8Tmj0W7XgWKLIhApdvpnATPS8a5vbd9t0q/gl+cGfZFSQNF3D2ObKe/IixQr/kQ
 znLw==
X-Gm-Message-State: AOJu0Yzr3AYclTjKKiVoPlsKHLX54xy9Vb669Yw1S2rAGSmJ9czA5Atl
 MneFmP4BqIWI+qcqiPoxi+0yTchjuB9gxG3J7t1eiFRBmGC1M3/BJiCcHFfbAg8Hq3Yur6iuC/q
 1xy/r1xHOACikTD5gsdc64kHbpl02yJpUGy5eVw==
X-Google-Smtp-Source: AGHT+IFdIJHp/12bVBq0GM+0OKLfn1hGP9TboBiQ6kkPXXrQS/lLdIR5UALKMfLLAokVOIQHbb15rz87AjRcZWViQHE=
X-Received: by 2002:a17:90a:6081:b0:2cd:2c4d:9345 with SMTP id
 98e67ed59e1d1-2cd85c25254mr3016163a91.6.1721743526216; Tue, 23 Jul 2024
 07:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240722193052.57592-1-raymond.mao@linaro.org>
 <c68ab077-063c-49f0-b345-dffe4db28bb2@cherry.de>
In-Reply-To: <c68ab077-063c-49f0-b345-dffe4db28bb2@cherry.de>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 23 Jul 2024 10:05:14 -0400
Message-ID: <CAEfUkUJrDi2MTBbB8hLn6jBv7uXs5__0m=-28J+ZfjGkPDmChw@mail.gmail.com>
Subject: Re: [PATCH v2] tools: Add script to update git subtree projects
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, sumit.garg@linaro.org, jerome.forissier@linaro.org, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
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

Hi Quentin,

On Tue, 23 Jul 2024 at 03:16, Quentin Schulz <quentin.schulz@cherry.de>
wrote:

> Hi Raymond,
>
> On 7/22/24 9:30 PM, Raymond Mao wrote:
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
> >   doc/develop/devicetree/control.rst |  8 +--
> >   dts/update-dts-subtree.sh          | 48 -----------------
> >   tools/update-subtree.sh            | 86 ++++++++++++++++++++++++++++++
> >   3 files changed, 90 insertions(+), 52 deletions(-)
> >   delete mode 100755 dts/update-dts-subtree.sh
> >   create mode 100755 tools/update-subtree.sh
> >
> > diff --git a/doc/develop/devicetree/control.rst
> b/doc/develop/devicetree/control.rst
> > index ca4fb0b5b10..211f7e4909c 100644
> > --- a/doc/develop/devicetree/control.rst
> > +++ b/doc/develop/devicetree/control.rst
> > @@ -96,12 +96,12 @@ sync the `dts/upstream/` subtree from the
> devicetree-rebasing repo whenever
> >   the next branch opens (refer: :doc:`../release_cycle`) with the latest
> mainline
> >   Linux kernel release. To sync the `dts/upstream/` subtree, run::
> >
> > -    ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>
> > +    ./tools/update-subtree.sh pull dts <devicetree-rebasing-release-tag>
> >
> >   If required it is also possible to cherry-pick fixes from the
> >   devicetree-rebasing repository prior to next sync, usage::
> >
> > -    ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
> > +    ./tools/update-subtree.sh pick dts <devicetree-rebasing-commit-id>
> >
> >
> >   Configuration
> > @@ -116,8 +116,8 @@ However, if `dts/upstream/` hasn't yet received
> devicetree source file for your
> >   newly added board support then one option is that you can add the
> corresponding
> >   devicetree source file as `arch/<arch>/dts/<name>.dts`. To select that
> add `#
> >   CONFIG_OF_UPSTREAM is not set` and set `DEFAULT_DEVICE_TREE=<name>`
> when
> > -prompted by Kconfig. Another option is that you can use use the "pick"
> option of
> > -`dts/update-dts-subtree.sh` mentioned above to bring in the commits
> that you
> > +prompted by Kconfig. Another option is that you can use the "pick"
> option of
> > +`tools/update-subtree.sh` mentioned above to bring in the commits that
> you
> >   need.
> >
> >   This should include your CPU or SoC's devicetree file. On top of that
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
>
> We have scripts/ and tools/ directories, this being a shell script I
> would have intuitively added it to scripts/. So my question is, what's
> the difference between those two directories :) ?
>
> Good question. Personally I think 'scripts' are for those scripts needed
by other components and 'tools' are for the general purpose utilities
(not limited to scripts). That is the reason I prefer 'tools'.

> @@ -0,0 +1,86 @@
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
>
> I think pulls are supposed to be done and sent to the ML by maintainers
> only? At least that's what we're supposed to do for the dts/upstream/
> directory AFAIR. Is it the same for mbedtls and lwip? If so, maybe
> explicit this in the usage that only maintainers are supposed to run
> this script with that option? And if you need to do it, ask the
> maintainers to do it for you? Does this make sense?
>
> The rules of running this script are the same as the original one
'dts/update-dts-subtree.sh'. We have the documentation for dts now,
and will have similar ones for MbedTLS and LWIP soon.
I didn't add this part yet since both MbedTLS and LWIP patch series
are still under review.


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
> > +            repo_url=https://github.com/Mbed-TLS/mbedtls.git
> > +            remote_name="mbedtls_upstream"
> > +            ;;
> > +        dts)
> > +            path=dts/upstream
> > +            repo_url=
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> > +            remote_name="devicetree-rebasing"
> > +            ;;
> > +        lwip)
> > +            path=lib/lwip/lwip
> > +            repo_url=https://git.savannah.gnu.org/git/lwip.git
> > +            remote_name="lwip_upstream"
> > +            ;;
> > +        *)
> > +            echo "Invalid subtree name: $subtree_name"
> > +            print_usage
> > +            exit 1
> > +    esac
> > +}
> > +
> > +set_params
> > +
> > +merge_commit_msg=$(cat << EOF
> > +Subtree merge tag '$ref' of $subtree_name repo [1] into $path
> > +
>
> I would recommend adding at the very least the path of the tools used to
> generate this merge commit (so ./tools/update-subtree.sh or maybe just
> $0?) or maybe even the full command line that was used to do this merge?
>
> Sorry but in any case would we need this commit message only without
knowing
the variables?


> > +[1] $repo_url
> > +EOF
> > +)
> > +
> > +remote_add_and_fetch() {
> > +    if [ -z "$(git remote get-url $remote_name 2>/dev/null)" ]; then
> > +        echo "Warning: Script automatically adds new git remote via:"
> > +        echo "    git remote add $remote_name \\"
> > +        echo "        $repo_url"
> > +        git remote add $remote_name $repo_url
> > +    fi
> > +    git fetch $remote_name master
> > +}
> > +
> > +if [ "$op" = "pull" ]; then
> > +    remote_add_and_fetch
> > +    git subtree pull --prefix $path $remote_name "$ref" --squash -m
> "$merge_commit_msg"
> > +elif [ "$op" = "pick" ]; then
> > +    remote_add_and_fetch
> > +    git cherry-pick -x --strategy=subtree -Xsubtree=$path/ "$ref"
>
> Should we add -s there too? (or --signoff)
>
> As I search for all 'merge' commits in history, they have not
signed-off tags.
This patch is to extend the original script to support more git upstream
repos.
So I intended to keep the commit message format as the original one unless
we have reasons to improve it.

Regards,
Raymond
