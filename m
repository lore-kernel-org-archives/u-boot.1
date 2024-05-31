Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3052C27C44
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 06:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4885C874D4;
	Fri, 31 May 2024 08:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FwJpnsSQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0454D8875B; Fri, 31 May 2024 08:33:19 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B48E809A8
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 08:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d1dbd01529so988175b6e.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 23:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717137195; x=1717741995; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RRcAdM3cjc4mn0QI+u3N8Mn/Jeh2bG/8iG2Gc7eoTtw=;
 b=FwJpnsSQRRaw+ynxUd0f+Tb4Onb80iOpf4ByfVcqajJp+dQ7j/cre5c/JzGqO3AsLr
 Y+WctN4xWFr6RE8Tvsoub7mSN+/NHWR2o/Gx0MHTOOXHBY02r/MrGVDfDgGKdGkyG6JL
 UBa6P48WZR/C2kPAMmTbe54KZkE1vK0d7+Q7tfn7MACRu3Smock6PkiOK9GhMf137Nrd
 AXKjDtKwP6GRLBrnDxsyh4Ly6kLzb3WyUMYMfaHal4e7M2HA033zCyzY0OKbK1Oeho63
 ul4fJPQbZHzFW9j5uK3BWbXoPOIdbqegQ5jdnedQ6jqTy8SsBh+8oDXqQ04mCRLLA7Ac
 BOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717137195; x=1717741995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RRcAdM3cjc4mn0QI+u3N8Mn/Jeh2bG/8iG2Gc7eoTtw=;
 b=Y4HiTGpyJeVBc4Qfjof5aINF6/DQuC/rB0rLvyJzRvf0mGAOcjt4lGpP48vhYdkAQj
 a7bNDkYhqDLdSjJ9IB1uQPgIQ58+ppTdJqaP7XsO+xQBYqUDC2Jo4BHau5Hcxm83m+pP
 pIBs8i4h+RRXuuU//znVkppEIONp6fFqsPeTkA/CVCPGB3tx7a1i8z6wExb9EyFNomwO
 xf4HZM0gfXsVpmjSHWHyF+ZIgEGXwT25JzdDNvEraEEOobf5eqajHVUoRfU1B0TNOTU9
 uAJ8sEdjHt1qaA+EcqmfTMbSwWetJMj/e9Pw2K8b1w9SO9DrKXWz90XcNX+iVoSbBLUS
 N4Mw==
X-Gm-Message-State: AOJu0YyZzL27eeOHH5sCli3nbKI4nJqOsc8VWUd1QNz58wddY7Mlc+3/
 CYXGZPRzi6zByvPvvh62ZnPHxt5uPsqk/ZPtPtOudW9tHaNRfXcoa3RwAqG0uytFU8HMCBFDwdL
 lStzWJEmzRexA4DxwIwrata1/1Civetab8yhk2w==
X-Google-Smtp-Source: AGHT+IGhMOSob043f9ar4zFGz8pO1ZN2OZXTOy0GhrXUBQiMdDsgi92Jrk4MeNi7i8BBBHtsR9fsHEovfr8NlKOEUJg=
X-Received: by 2002:a05:6808:1a13:b0:3c9:93f1:c787 with SMTP id
 5614622812f47-3d1e34858f3mr1230315b6e.3.1717137195089; Thu, 30 May 2024
 23:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-3-raymond.mao@linaro.org>
In-Reply-To: <20240528140955.1960172-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 May 2024 09:32:38 +0300
Message-ID: <CAC_iWjLhKEcFzNpAAms66+BYFOT_Q3AA2LBdOupFU=cXSVRXBQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/25] mbedtls: Add script to update MbedTLS subtree
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Michal Simek <michal.simek@amd.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

On Tue, 28 May 2024 at 17:10, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> lib/mbedtls/update-mbedtls-subtree.sh is a wrapper of git subtree
> commands.
> Usage from U-Boot top directory, run:
>
> $ ./lib/mbedtls/update-mbedtls-subtree.sh pull <release-tag>
> $ ./lib/mbedtls/update-mbedtls-subtree.sh pick <commit-id>
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
> Changes in v3
> - None.
>
>  lib/mbedtls/update-mbedtls-subtree.sh | 50 +++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100755 lib/mbedtls/update-mbedtls-subtree.sh
>
> diff --git a/lib/mbedtls/update-mbedtls-subtree.sh b/lib/mbedtls/update-mbedtls-subtree.sh
> new file mode 100755
> index 00000000000..f208e54a5af
> --- /dev/null
> +++ b/lib/mbedtls/update-mbedtls-subtree.sh
> @@ -0,0 +1,50 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright 2024 Linaro Ltd.
> +#
> +# Usage: from the top level U-Boot source tree, run:
> +# $ ./lib/mbedtls/update-mbedtls-subtree.sh pull <release-tag>
> +# $ ./lib/mbedtls/update-mbedtls-subtree.sh pick <commit-id>

LWIP will add similar machinery, we want to merge these in a single script.
So, please move this to tools/ and adjust it accordingly as a first step

> +#
> +# The script will pull changes from MbedTLS repo into U-Boot
> +# as a subtree located as <U-Boot>/lib/mbedtls/external/mbedtls sub-directory.
> +# It will automatically create a squash/merge commit listing the commits
> +# imported.
> +
> +set -e
> +
> +merge_commit_msg=$(cat << EOF
> +Subtree merge tag '$2' of MbedTLS repo [1] into lib/mbedtls/external/mbedtls
> +
> +[1] https://github.com/Mbed-TLS/mbedtls.git
> +EOF
> +)
> +
> +remote_add_and_fetch() {
> +    if ! git remote get-url mbedtls_upstream 2>/dev/null

if [ -z "$(git remote get-url rigin 2>/dev/null)" ]; then

> +    then
> +        echo "Warning: Script automatically adds new git remote via:"
> +        echo "    git remote add mbedtls_upstream \\"
> +        echo "        https://github.com/Mbed-TLS/mbedtls.git"
> +        git remote add mbedtls_upstream \
> +            https://github.com/Mbed-TLS/mbedtls.git
> +    fi
> +    git fetch mbedtls_upstream master
> +}
> +
> +if [ "$1" = "pull" ]

"$1" == 'pull'
Also on string literals, you don't need "", 'pull' is enough

> +then
> +    remote_add_and_fetch
> +    git subtree pull --prefix lib/mbedtls/external/mbedtls mbedtls_upstream \
> +        "$2" --squash -m "${merge_commit_msg}"
> +elif [ "$1" = "pick" ]
move then 'then' one line up and add a ;
 == 'pick'

> +then
> +    remote_add_and_fetch
> +    git cherry-pick -x --strategy=subtree \
> +        -Xsubtree=lib/mbedtls/external/mbedtls/ "$2"
> +else
> +    echo "usage: $0 <op> <ref>"
> +    echo "  <op>     pull or pick"
> +    echo "  <ref>    release tag [pull] or commit id [pick]"
> +fi
> --
> 2.25.1
>

Cheers
/Ilias
