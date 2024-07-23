Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC41C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 06:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 618A688354;
	Tue, 23 Jul 2024 08:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fz8c0WWj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3074C87E0D; Tue, 23 Jul 2024 08:45:56 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E19886FD
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 08:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cb50bcabd1so2746519a91.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 23:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721717145; x=1722321945; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SuNWJZEkogLFL+HySkOKXamrRI6olNhrJFOBJyfCUzw=;
 b=fz8c0WWjqws5iGk16N3QChuhtf81sE+mW+nSLPicITmisAn8o4+557r9Y/1IdGd7QX
 0yU7jA3SBtxmnJdct90UnmJ0hn6vuGHO2QAQGpGfLIMI2mlQQvwU7Lt1rT/J/BRf04i7
 lDRU7upTw6UqOYCFa9oJvT2ErYEBlrABnYFnK70I+RKUlJ7CFRAn4bs0LYU8mm3U4KX2
 UMljnP6Gp3NAep5eepKb1fAZeci5A6slzY60oM0CP8QuE564Ka0MIjHKT9VwnoBg1SSG
 W9x3fL8htbhzITWfzWzyv4sbWVEQ3J8vuxF/mJB9TNQccmCZDoioO1A23HhLIUy4CpYa
 EZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721717145; x=1722321945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SuNWJZEkogLFL+HySkOKXamrRI6olNhrJFOBJyfCUzw=;
 b=vtuhoaEcQ0Pq9Xwsq3nxq6o1FqbqXndk7ZX8UclZHU2XypMEcpTf0rOUQ1UAx87Bx7
 hf7OMFz2SKsD4k4CHsPUokVQVHmVstY87SyNXEO5KKFIefFKVkFg+zVhF6rw2JJKFR4K
 VWJMhUo9vw+y+hthgyUbG75loZXBpZmjHGzyyw6EZdtICkwdE40gT4mCd7kAuiAYrvqo
 0NVjU2GWgSJpVnvD5QhC1lW/VwoapyvVvnY37JTaNWtFhfQmtMousnk8YeIpTjlGmRIe
 hHuAUa03Z0d4nY0eCNlI7Sy0Oyt3ilvk76hwuSKcwKwuli2zCEPRdJq5TTmr1MwXVsd3
 mhGQ==
X-Gm-Message-State: AOJu0YzU6Cz6SQ2fYu7YIb1xOfuWh2EB+JvKW1XBLRxR4rx5vDVKO4hN
 PuVss/zCfFrKBmKjGVSnl6wyuRySZoTgA2fMrxqtqnhEFilEmTmXynKhzth2F7b+dURfK/oUJ4f
 xRBcVvFpq61EK3qxtqopqpZtCMN+zggi/Z9IWTg==
X-Google-Smtp-Source: AGHT+IE+812uMlNEgsc6UFJXMWHtqgmAMkGkj0LlbEnHqKVlEq+4ODVlZjzvMUZpyEtseWeDdMMDemSafQktbl2JH6k=
X-Received: by 2002:a17:90a:db82:b0:2cd:2f63:a447 with SMTP id
 98e67ed59e1d1-2cd2f63bd04mr5183281a91.36.1721717145181; Mon, 22 Jul 2024
 23:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240722193052.57592-1-raymond.mao@linaro.org>
In-Reply-To: <20240722193052.57592-1-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jul 2024 09:45:09 +0300
Message-ID: <CAC_iWjJ=t358fgnw=Ec_ARcvrh5V=rX66AUGsOeJ2g0JDpy9pQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools: Add script to update git subtree projects
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sumit.garg@linaro.org, jerome.forissier@linaro.org, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 22 Jul 2024 at 22:31, Raymond Mao <raymond.mao@linaro.org> wrote:
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


Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
