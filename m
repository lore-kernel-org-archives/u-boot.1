Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84207C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 13:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F250886DBD;
	Mon, 22 Jul 2024 15:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CE+w9slw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703F187C86; Mon, 22 Jul 2024 15:22:35 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05F498304A
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 15:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5a10bb7bcd0so3919573a12.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721654552; x=1722259352; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zjuYZTiMpVgmM/Lp8BAnPINbfYCrQjJXmkw8AwJPQc8=;
 b=CE+w9slw8uwH465u5g80dzhki5+FJncrhNlDWS5uH5atLt26LR1x8VAeoRJk6E4chb
 SfNbaYjKCb7oPfwb4O77Yi8LNySDZAB14tONceG2AM5DCXAIw/JSnPSkjg9qldZ6VRxp
 ZeDb3MZGdsga3BEp/Fh0uhP0Bgm+Lb2lydftiyYD92qPM3ORr35BNOM/JNfN0I0gV4wN
 mughB5ixduyeR500QPn70y2Su5Nze6AsBF9LGPaNrNTros7tY29GtVgSqqwasVtHtiVr
 y/7BbeDZWddqEyNboFtbbngZwZuBbDNr0IuvQi4Wx9uvvPtyFXtE3+/nMe3NpbZuVVT5
 rDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721654552; x=1722259352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zjuYZTiMpVgmM/Lp8BAnPINbfYCrQjJXmkw8AwJPQc8=;
 b=t82cvvmA5XGzx7wmXE5vz08MbIskRLxD8+5cN5N3GAQ3F/faEP8sDxvmf1Lkl+wMki
 wodfUQThfWtRGnpmFsu3Vmiseqw6thsbO0zULVhNrZCKho2PCKkUpLocB7JADrOIR4g7
 8oCmsGcploPkdMtcsOY45VlUKrVIKyrtWXsyUEX+sxlcmV2JxUY8bCp4KwWQqALHYdHf
 JTAULMrE0We5AwYOMTUEkBuSzjWLZ4otXud0eWtOy+16Qyaam17Tat6/rD4MzjVPmNS3
 Au6CAlaTtSWcSoNQCOxL+lCksu1BOPR/Fi2YkgOatkdyu9FaMZxA+2jUCpHQOtroQxfQ
 sFCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAPH3YYF9Ei2RU/2oAUHn/A0BW7OMZgyJm9sVb8F2VBom3vQFKDsdn0e000HPCH+A+SEC9gVyVXYLg24lfWyNKy5mtTA==
X-Gm-Message-State: AOJu0Yz6uts2NtzNo+jgDxhmVn25B1mYAV64pxBhxsJKKGEhQiTYmiWK
 r644dftm8NNUA6AJ/6hfKb+Q7fiaNJvP/c/1H0rGvSx9N8wsKL5hpJqtNGH9CJQ=
X-Google-Smtp-Source: AGHT+IF4dly26+UvKitXIXrRr3FB8C1XFVuYko4cSI8k08Jj60NLeH4dl9GvnkzKnAQX4tf8veqUFg==
X-Received: by 2002:a17:907:97c4:b0:a79:8149:967a with SMTP id
 a640c23a62f3a-a7a4c0100c6mr484417766b.16.1721654552280; 
 Mon, 22 Jul 2024 06:22:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:364e:69c1:558c:15f4?
 ([2a01:e0a:3cb:7bb0:364e:69c1:558c:15f4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a856c9fffsm738466b.163.2024.07.22.06.22.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 06:22:31 -0700 (PDT)
Message-ID: <7cb33dec-5a54-4dc4-9516-a761245279eb@linaro.org>
Date: Mon, 22 Jul 2024 15:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: Add script to update git subtree projects
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: sumit.garg@linaro.org, Tom Rini <trini@konsulko.com>
References: <20240719141245.49186-1-raymond.mao@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240719141245.49186-1-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 7/19/24 16:12, Raymond Mao wrote:
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
>  dts/update-dts-subtree.sh | 48 ----------------------
>  tools/update-subtree.sh   | 86 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 48 deletions(-)
>  delete mode 100755 dts/update-dts-subtree.sh
>  create mode 100755 tools/update-subtree.sh
> 
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
> index 00000000000..bf41a31de2b
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
> +repo_url_mbedtls="https://github.com/Mbed-TLS/mbedtls.git"
> +repo_url_dts="https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git"
> +repo_url_lwip="https://git.savannah.gnu.org/git/lwip.git"
> +
> +path_mbedtls="lib/mbedtls/external/mbedtls"
> +path_dts="dts/upstream"
> +path_lwlip="lib/lwip/lwip"
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
> +if [ "$subtree_name" = "mbedtls" ]; then
> +    repo_url=$repo_url_mbedtls
> +    remote_name="mbedtls_upstream"
> +    path=$path_mbedtls
> +elif [ "$subtree_name" = "dts" ]; then
> +    repo_url=$repo_url_dts
> +    remote_name="devicetree-rebasing"
> +    path=$path_dts
> +elif [ "$subtree_name" = "lwip" ]; then
> +    repo_url=$repo_url_lwip
> +    remote_name="lwip_upstream"
> +    path=$path_lwip
> +else
> +    echo "Invalid subtree name: $subtree_name"
> +    print_usage
> +    exit 1
> +fi

Suggestion: this and the repo_url_* / path_* values could be moved into
a function like so:

set_params() {
    case "$1" in
        mbedtls)
            path=lib/mbedtls/external/mbedtls
            repo_url=https://github.com/Mbed-TLS/mbedtls.git
            ;;
        ... other cases here ...
        *)
            echo "Invalid subtree name: $subtree_name"
            print_usage
            exit 1
    esac
}

set_params $1

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

Overall LGTM. FWIW:

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
