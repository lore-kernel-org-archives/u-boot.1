Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A550C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 07:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C00EF8831F;
	Thu, 25 Jul 2024 09:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sTSAfTNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B86608841E; Thu, 25 Jul 2024 09:09:56 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39FD78818B
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 09:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a10835480bso725892a12.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 00:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721891393; x=1722496193; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zvmSzYYppq4jeZlFILuTzxr8Go3ZORPhGZi75yboJaw=;
 b=sTSAfTNzCX6v3vMi8BHuI256BCBiDc/hBZwPrkiqE6rl6Iauu8H50yzenDNiN5+AZ6
 J/ai8X/YE5jgE3FqCZBjRi1LAps/eVRsccpUxdm7oAA9GuQ7v+vxmQ2o+YiUWeO4sQaz
 DBn3FBWXQn4CbNzdXk2K4mcExgyq0Tb2BLG2BheTkbHJkmwNR+cHdsD3r+VPcdqcbDLE
 OM3OXNK8/NnI8wXZX1HadQzqzDKdrgdo8JKYnWn1WwfEAtdqO/IhLaHrUgn4E1wF6bbV
 ElWP0cnst2YP/cWx5BGQaDvCv6277cNKZ+hSoSVT/kseQ6ryogiJgHyKUvMkF4Lp5TSO
 Oujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721891393; x=1722496193;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zvmSzYYppq4jeZlFILuTzxr8Go3ZORPhGZi75yboJaw=;
 b=c9kLTJzbG54Ik22HcslvY5SVdKnguaKiGSoD4PQAxVgPAa0S6VIlEz0Nngt+NB/Mkp
 s0p8Vxde20rMSzdtcKMyznCTGDFoOKbzUIUr6u+xkQVQdYFIglDttZjCq9FMnetY8hOf
 VO5fQ8iAVkRytkc2lnEUvUDKKyHkG6QqjUV5/Li7Ffbm8QjVhkSstQuFF4roXRRZix9R
 Fbqsk+vNPCm4dAV4wacZLAP2ygmcOgeC5+PYxr0I8jJ1OLwejQ/MFoXIHKa1eSaRnGMB
 QhRTcpHrjaX/kVc8C7CezLWpZHr8St0CVNhBb/ZzhZOc63ZgH1wpBFxduha/Id3pjCBn
 3dlA==
X-Gm-Message-State: AOJu0YwrIKs8ywcyM898v+AiNAZND3DF/D1/t7Kva5Bpu1m+wl451lRG
 TbV2q6ZDN5ADGRxXfPpPXeCpRQv/KvYIR//o+89LpjRxkTNMwm5CGGKEbmGrbj0=
X-Google-Smtp-Source: AGHT+IHc5sUK9gQmIa+XWMJJqbEvoPGMZZAC/u7v8L2gwOvfAQD7k/+KWak+khkpLw80tXPx5g01ag==
X-Received: by 2002:a17:907:60d4:b0:a7a:ae85:f24d with SMTP id
 a640c23a62f3a-a7acb92ebbcmr77199366b.51.1721891393484; 
 Thu, 25 Jul 2024 00:09:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:bce:e4cc:b7c1:f518?
 ([2a01:e0a:3cb:7bb0:bce:e4cc:b7c1:f518])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad41027sm39758266b.122.2024.07.25.00.09.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 00:09:52 -0700 (PDT)
Message-ID: <e61989c3-cc38-42d8-8209-aa6e7f793e27@linaro.org>
Date: Thu, 25 Jul 2024 09:09:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: Add script to update git subtree projects
To: Sumit Garg <sumit.garg@linaro.org>, Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240722193052.57592-1-raymond.mao@linaro.org>
 <CAFA6WYNm6roHW3KsENtq2nLfhmZV1xeUzak6CUyHj6oFy=yQqA@mail.gmail.com>
 <CAEfUkUJtbo+GWCsf_CMUvA=t8ck6tjmhJzZQbsy3PYTfukTqDw@mail.gmail.com>
 <CAFA6WYODJOJnAhodMxEkyVTgeBEcvPO4WZezT4cVbXp6OnabEg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFA6WYODJOJnAhodMxEkyVTgeBEcvPO4WZezT4cVbXp6OnabEg@mail.gmail.com>
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



On 7/25/24 07:45, Sumit Garg wrote:
> On Wed, 24 Jul 2024 at 19:40, Raymond Mao <raymond.mao@linaro.org> wrote:
>>
>> Hi Sumit,
>>
>> On Wed, 24 Jul 2024 at 03:08, Sumit Garg <sumit.garg@linaro.org> wrote:
>>>
>>> Hi Raymond,
>>>
>>> Thanks for doing this.
>>>
>>> On Tue, 23 Jul 2024 at 01:01, Raymond Mao <raymond.mao@linaro.org> wrote:
>>>>
>>>> Recently we are introducing multiple git subtree projects and
>>>> it is the right time to have a universal script to update
>>>> various subtrees and replace the dts/update-dts-subtree.sh.
>>>>
>>>> update-subtree.sh is a wrapper of git subtree commands.
>>>>
>>>> Usage: From U-Boot top directory,
>>>> run
>>>> $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
>>>> for pulling a tag from the upstream.
>>>> Or run
>>>> $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
>>>> for cherry-pick a commit from the upstream.
>>>>
>>>> Currently <subtree-name> supports dts, mbedtls and lwip.
>>>>
>>>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>>>> ---
>>>> Changes in v2
>>>> - Refactored the script.
>>>> - Update the control doc.
>>>>
>>>>  doc/develop/devicetree/control.rst |  8 +--
>>>>  dts/update-dts-subtree.sh          | 48 -----------------
>>>>  tools/update-subtree.sh            | 86 ++++++++++++++++++++++++++++++
>>>>  3 files changed, 90 insertions(+), 52 deletions(-)
>>>>  delete mode 100755 dts/update-dts-subtree.sh
>>>>  create mode 100755 tools/update-subtree.sh
>>>>
>>>> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
>>>> index ca4fb0b5b10..211f7e4909c 100644
>>>> --- a/doc/develop/devicetree/control.rst
>>>> +++ b/doc/develop/devicetree/control.rst
>>>> @@ -96,12 +96,12 @@ sync the `dts/upstream/` subtree from the devicetree-rebasing repo whenever
>>>>  the next branch opens (refer: :doc:`../release_cycle`) with the latest mainline
>>>>  Linux kernel release. To sync the `dts/upstream/` subtree, run::
>>>>
>>>> -    ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>
>>>> +    ./tools/update-subtree.sh pull dts <devicetree-rebasing-release-tag>
>>>>
>>>>  If required it is also possible to cherry-pick fixes from the
>>>>  devicetree-rebasing repository prior to next sync, usage::
>>>>
>>>> -    ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
>>>> +    ./tools/update-subtree.sh pick dts <devicetree-rebasing-commit-id>
>>>>
>>>>
>>>>  Configuration
>>>> @@ -116,8 +116,8 @@ However, if `dts/upstream/` hasn't yet received devicetree source file for your
>>>>  newly added board support then one option is that you can add the corresponding
>>>>  devicetree source file as `arch/<arch>/dts/<name>.dts`. To select that add `#
>>>>  CONFIG_OF_UPSTREAM is not set` and set `DEFAULT_DEVICE_TREE=<name>` when
>>>> -prompted by Kconfig. Another option is that you can use use the "pick" option of
>>>> -`dts/update-dts-subtree.sh` mentioned above to bring in the commits that you
>>>> +prompted by Kconfig. Another option is that you can use the "pick" option of
>>>> +`tools/update-subtree.sh` mentioned above to bring in the commits that you
>>>>  need.
>>>>
>>>>  This should include your CPU or SoC's devicetree file. On top of that any U-Boot
>>>> diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
>>>> deleted file mode 100755
>>>> index a57b78a41d3..00000000000
>>>> --- a/dts/update-dts-subtree.sh
>>>> +++ /dev/null
>>>> @@ -1,48 +0,0 @@
>>>> -#!/bin/sh
>>>> -# SPDX-License-Identifier: GPL-2.0+
>>>> -#
>>>> -# Copyright 2024 Linaro Ltd.
>>>> -#
>>>> -# Usage: from the top level U-Boot source tree, run:
>>>> -# $ ./dts/update-dts-subtree.sh pull <release-tag>
>>>> -# $ ./dts/update-dts-subtree.sh pick <commit-id>
>>>> -#
>>>> -# The script will pull changes from devicetree-rebasing repo into U-Boot
>>>> -# as a subtree located as <U-Boot>/dts/upstream sub-directory. It will
>>>> -# automatically create a squash/merge commit listing the commits imported.
>>>> -
>>>> -set -e
>>>> -
>>>> -merge_commit_msg=$(cat << EOF
>>>> -Subtree merge tag '$2' of devicetree-rebasing repo [1] into dts/upstream
>>>> -
>>>> -[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
>>>> -EOF
>>>> -)
>>>> -
>>>> -remote_add_and_fetch() {
>>>> -    if ! git remote get-url devicetree-rebasing 2>/dev/null
>>>> -    then
>>>> -        echo "Warning: Script automatically adds new git remote via:"
>>>> -        echo "    git remote add devicetree-rebasing \\"
>>>> -        echo "        https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git"
>>>> -        git remote add devicetree-rebasing \
>>>> -            https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
>>>> -    fi
>>>> -    git fetch devicetree-rebasing master
>>>> -}
>>>> -
>>>> -if [ "$1" = "pull" ]
>>>> -then
>>>> -    remote_add_and_fetch
>>>> -    git subtree pull --prefix dts/upstream devicetree-rebasing \
>>>> -        "$2" --squash -m "${merge_commit_msg}"
>>>> -elif [ "$1" = "pick" ]
>>>> -then
>>>> -    remote_add_and_fetch
>>>> -    git cherry-pick -x --strategy=subtree -Xsubtree=dts/upstream/ "$2"
>>>> -else
>>>> -    echo "usage: $0 <op> <ref>"
>>>> -    echo "  <op>     pull or pick"
>>>> -    echo "  <ref>    release tag [pull] or commit id [pick]"
>>>> -fi
>>>> diff --git a/tools/update-subtree.sh b/tools/update-subtree.sh
>>>> new file mode 100755
>>>> index 00000000000..5946aa1a9e2
>>>> --- /dev/null
>>>> +++ b/tools/update-subtree.sh
>>>> @@ -0,0 +1,86 @@
>>>> +#!/bin/sh
>>>> +# SPDX-License-Identifier: GPL-2.0+
>>>> +#
>>>> +# Copyright (c) 2024 Linaro Limited
>>>> +# Author: Raymond Mao <raymond.mao@linaro.org>
> 
> Something I forgot earlier, if you are going to add explicit
> authorship then you should retain the prior author too from where this
> script is derived.
> 
>>>> +#
>>>> +# Usage: from the top level U-Boot source tree, run:
>>>> +# $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
>>>> +# Or:
>>>> +# $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
>>>> +#
>>>> +# The script will pull changes from subtree repo into U-Boot.
>>>> +# It will automatically create a squash/merge commit listing the commits
>>>> +# imported.
>>>> +
>>>> +set -e
>>>> +
>>>> +print_usage() {
>>>> +    echo "usage: $0 <op> <subtree-name> <ref>"
>>>> +    echo "  <op>           pull or pick"
>>>> +    echo "  <subtree-name> mbedtls or dts or lwip"
>>>> +    echo "  <ref>          release tag [pull] or commit id [pick]"
>>>> +}
>>>> +
>>>> +if [ $# -ne 3 ]; then
>>>> +    print_usage
>>>> +    exit 1
>>>> +fi
>>>> +
>>>> +op=$1
>>>> +subtree_name=$2
>>>> +ref=$3
>>>> +
>>>> +set_params() {
>>>> +    case "$subtree_name" in
>>>> +        mbedtls)
>>>> +            path=lib/mbedtls/external/mbedtls
>>>
>>> Although I am in favour of making this script generic, this subdir
>>> path doesn't exist yet. Wouldn't it make more sense to add mbedtls
>>> here alongside the corresponding patch-set? Otherwise the script will
>>> just fail.
>>>
>> Actually this patch is split from the MbedTLS series which is under review.
>> I think this should be fine before merging the MbedTLS/LWIP series, since
>> it is supposed to be run by maintainers only.
> 
> Developers also use this script to cherry-pick DTS patches from
> upstream to enable certain features in U-Boot.
> 
>> And the failing message explains
>> that the sub-project dir does not exist which should be sufficient at the moment.
> 
> Sure, I am only afraid that if this patch lands in a prior U-Boot
> release than the actual MbedTLS/LWIP series then we are just giving
> users a somewhat broken tool. If your worry is about merge conflicts
> then I suppose that should be taken care off while merging
> corresponding patch series.

I can certainly take care of adding the lwIP chunk in the lwIP series
if that helps.

Thanks,
-- 
Jerome

> 
> -Sumit
> 
>>
>> Regards,
>> Raymond
