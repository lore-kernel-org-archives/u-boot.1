Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEF0C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 07:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EF5F88896;
	Wed, 24 Jul 2024 09:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iCosFJoV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DEB5888A7; Wed, 24 Jul 2024 09:09:02 +0200 (CEST)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DDC488847
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 09:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-8100ff1cec5so1943601241.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 00:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721804937; x=1722409737; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cnImAU6c+OjygjKAgCkoW8mZOOi4zG5gnsjfnv5FROo=;
 b=iCosFJoVlNGssnBGedQ7TlDF4TllPAAp88uMdS40Tr/CIbg6M36UFsgywIZtIVGfHm
 ZfaxcVGMU2UMB+tJqiflY4P476o2ri6XQJ1FUWKuhq8sf1qXA0M0z5oTHvZicCB22LFY
 jcgqrfIA4hYeEW2ATG8Bct2l5/4/67eJa2m5nfIRuGNCi//6JBf7HSt8uFtTZYqLnFuT
 dWN435oUtbaSvhj0dq25QbBUGx5NzHc/VEl6g+0I+PyiRLaj5nfLwdf/Rkn5ccKl4f4a
 zH1F030qKyH4eopI0UKve1cU3xOWaisr03EubfIE+qocF1YRxkEDZhYlr2LVKWDsB1aL
 rdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721804937; x=1722409737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cnImAU6c+OjygjKAgCkoW8mZOOi4zG5gnsjfnv5FROo=;
 b=DGJjdj4G5oCeLoQNyok6fyoDchdjbTQ98wnAbeopw/QPBCHz+58Q4sYEx8ySuPDTrn
 WWHiDx+65/c7sTfHYTJ9SUfid/rQ/gynMfYA4j+HQojqUEWyiPkPwcBR/Jz/48bYgrRB
 7s3NX1X81W2M/YRzmVKAoxVkGJqT+N6p9p4MTVLtK1NQ/5gt9wCdWWsZZuNP3LFvj3Zh
 2PZjnqalUGu6GCTza5o/PUIi8UToZ1boxPBCuzmBY5wqHaF9jKQzCUHtnTdIzRR+CLb8
 hW915cEvec++/5aJBjz9iOm6drfg7TQU3aCSYFfGZ8q3EYQW/KMPc2CCmXnlf6sQuxzv
 60mQ==
X-Gm-Message-State: AOJu0Yw4wWsMyqfEUNMAtskDHvngx9rg6vc2I5N1IL1q1JbnkbkRwxGu
 f4ndROslcoIG942HAoQ8d95qA+wlL0tkgBsMVwQdYGp7mb+IEuXjfVnvdTeQHBhsyD0y58nxmjE
 LaVRDx9vwlE99p2r+MZvbaFONU7iHqFHkLT5ypA==
X-Google-Smtp-Source: AGHT+IFW6xu/7wLMwSM53o6v2zrL+9LPaaDklp3GLYylZqO8g6A37ih2KhDnE7ZGfIWP+z0SBuIVofEVMmC7PxR4KwY=
X-Received: by 2002:a05:6102:3310:b0:492:9dbe:1741 with SMTP id
 ada2fe7eead31-493c1ac3b84mr1882481137.27.1721804937196; Wed, 24 Jul 2024
 00:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240722193052.57592-1-raymond.mao@linaro.org>
In-Reply-To: <20240722193052.57592-1-raymond.mao@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 24 Jul 2024 12:38:46 +0530
Message-ID: <CAFA6WYNm6roHW3KsENtq2nLfhmZV1xeUzak6CUyHj6oFy=yQqA@mail.gmail.com>
Subject: Re: [PATCH v2] tools: Add script to update git subtree projects
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Thanks for doing this.

On Tue, 23 Jul 2024 at 01:01, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Recently we are introducing multiple git subtree projects and
> it is the right time to have a universal script to update
> various subtrees and replace the dts/update-dts-subtree.sh.
>
> update-subtree.sh is a wrapper of git subtree commands.
>
> Usage: From U-Boot top directory,
> run
> $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
> for pulling a tag from the upstream.
> Or run
> $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
> for cherry-pick a commit from the upstream.
>
> Currently <subtree-name> supports dts, mbedtls and lwip.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Refactored the script.
> - Update the control doc.
>
>  doc/develop/devicetree/control.rst |  8 +--
>  dts/update-dts-subtree.sh          | 48 -----------------
>  tools/update-subtree.sh            | 86 ++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+), 52 deletions(-)
>  delete mode 100755 dts/update-dts-subtree.sh
>  create mode 100755 tools/update-subtree.sh
>
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> index ca4fb0b5b10..211f7e4909c 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -96,12 +96,12 @@ sync the `dts/upstream/` subtree from the devicetree-rebasing repo whenever
>  the next branch opens (refer: :doc:`../release_cycle`) with the latest mainline
>  Linux kernel release. To sync the `dts/upstream/` subtree, run::
>
> -    ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>
> +    ./tools/update-subtree.sh pull dts <devicetree-rebasing-release-tag>
>
>  If required it is also possible to cherry-pick fixes from the
>  devicetree-rebasing repository prior to next sync, usage::
>
> -    ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
> +    ./tools/update-subtree.sh pick dts <devicetree-rebasing-commit-id>
>
>
>  Configuration
> @@ -116,8 +116,8 @@ However, if `dts/upstream/` hasn't yet received devicetree source file for your
>  newly added board support then one option is that you can add the corresponding
>  devicetree source file as `arch/<arch>/dts/<name>.dts`. To select that add `#
>  CONFIG_OF_UPSTREAM is not set` and set `DEFAULT_DEVICE_TREE=<name>` when
> -prompted by Kconfig. Another option is that you can use use the "pick" option of
> -`dts/update-dts-subtree.sh` mentioned above to bring in the commits that you
> +prompted by Kconfig. Another option is that you can use the "pick" option of
> +`tools/update-subtree.sh` mentioned above to bring in the commits that you
>  need.
>
>  This should include your CPU or SoC's devicetree file. On top of that any U-Boot
> diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
> deleted file mode 100755
> index a57b78a41d3..00000000000
> --- a/dts/update-dts-subtree.sh
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -# Copyright 2024 Linaro Ltd.
> -#
> -# Usage: from the top level U-Boot source tree, run:
> -# $ ./dts/update-dts-subtree.sh pull <release-tag>
> -# $ ./dts/update-dts-subtree.sh pick <commit-id>
> -#
> -# The script will pull changes from devicetree-rebasing repo into U-Boot
> -# as a subtree located as <U-Boot>/dts/upstream sub-directory. It will
> -# automatically create a squash/merge commit listing the commits imported.
> -
> -set -e
> -
> -merge_commit_msg=$(cat << EOF
> -Subtree merge tag '$2' of devicetree-rebasing repo [1] into dts/upstream
> -
> -[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> -EOF
> -)
> -
> -remote_add_and_fetch() {
> -    if ! git remote get-url devicetree-rebasing 2>/dev/null
> -    then
> -        echo "Warning: Script automatically adds new git remote via:"
> -        echo "    git remote add devicetree-rebasing \\"
> -        echo "        https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git"
> -        git remote add devicetree-rebasing \
> -            https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> -    fi
> -    git fetch devicetree-rebasing master
> -}
> -
> -if [ "$1" = "pull" ]
> -then
> -    remote_add_and_fetch
> -    git subtree pull --prefix dts/upstream devicetree-rebasing \
> -        "$2" --squash -m "${merge_commit_msg}"
> -elif [ "$1" = "pick" ]
> -then
> -    remote_add_and_fetch
> -    git cherry-pick -x --strategy=subtree -Xsubtree=dts/upstream/ "$2"
> -else
> -    echo "usage: $0 <op> <ref>"
> -    echo "  <op>     pull or pick"
> -    echo "  <ref>    release tag [pull] or commit id [pick]"
> -fi
> diff --git a/tools/update-subtree.sh b/tools/update-subtree.sh
> new file mode 100755
> index 00000000000..5946aa1a9e2
> --- /dev/null
> +++ b/tools/update-subtree.sh
> @@ -0,0 +1,86 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2024 Linaro Limited
> +# Author: Raymond Mao <raymond.mao@linaro.org>
> +#
> +# Usage: from the top level U-Boot source tree, run:
> +# $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
> +# Or:
> +# $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
> +#
> +# The script will pull changes from subtree repo into U-Boot.
> +# It will automatically create a squash/merge commit listing the commits
> +# imported.
> +
> +set -e
> +
> +print_usage() {
> +    echo "usage: $0 <op> <subtree-name> <ref>"
> +    echo "  <op>           pull or pick"
> +    echo "  <subtree-name> mbedtls or dts or lwip"
> +    echo "  <ref>          release tag [pull] or commit id [pick]"
> +}
> +
> +if [ $# -ne 3 ]; then
> +    print_usage
> +    exit 1
> +fi
> +
> +op=$1
> +subtree_name=$2
> +ref=$3
> +
> +set_params() {
> +    case "$subtree_name" in
> +        mbedtls)
> +            path=lib/mbedtls/external/mbedtls

Although I am in favour of making this script generic, this subdir
path doesn't exist yet. Wouldn't it make more sense to add mbedtls
here alongside the corresponding patch-set? Otherwise the script will
just fail.

> +            repo_url=https://github.com/Mbed-TLS/mbedtls.git
> +            remote_name="mbedtls_upstream"
> +            ;;
> +        dts)
> +            path=dts/upstream
> +            repo_url=https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> +            remote_name="devicetree-rebasing"
> +            ;;
> +        lwip)
> +            path=lib/lwip/lwip

Ditto here.

-Sumit

> +            repo_url=https://git.savannah.gnu.org/git/lwip.git
> +            remote_name="lwip_upstream"
> +            ;;
> +        *)
> +            echo "Invalid subtree name: $subtree_name"
> +            print_usage
> +            exit 1
> +    esac
> +}
> +
> +set_params
> +
> +merge_commit_msg=$(cat << EOF
> +Subtree merge tag '$ref' of $subtree_name repo [1] into $path
> +
> +[1] $repo_url
> +EOF
> +)
> +
> +remote_add_and_fetch() {
> +    if [ -z "$(git remote get-url $remote_name 2>/dev/null)" ]; then
> +        echo "Warning: Script automatically adds new git remote via:"
> +        echo "    git remote add $remote_name \\"
> +        echo "        $repo_url"
> +        git remote add $remote_name $repo_url
> +    fi
> +    git fetch $remote_name master
> +}
> +
> +if [ "$op" = "pull" ]; then
> +    remote_add_and_fetch
> +    git subtree pull --prefix $path $remote_name "$ref" --squash -m "$merge_commit_msg"
> +elif [ "$op" = "pick" ]; then
> +    remote_add_and_fetch
> +    git cherry-pick -x --strategy=subtree -Xsubtree=$path/ "$ref"
> +else
> +    print_usage
> +    exit 1
> +fi
> --
> 2.25.1
>
