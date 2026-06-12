Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8586CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 17:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 496D0839A8;
	Fri, 12 Jun 2026 19:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="IoQs5mir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5861A83FEC; Fri, 12 Jun 2026 19:06:27 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38DCE8056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 19:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1781283982;
 bh=8Bu9CRkfkMqWjqI3ikyZDQXwADcAAPhWxpjGmg1LZUs=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=IoQs5mirdi7vOhy8cQ6dP+r0G5Yc74dpANm35MdP95IZMfWkieilX31yz3Vz5r9FC
 Lef+jMQiVmFS992roXMc83bSbTdqkjpTE7Ghdmmwh6N32ytDe4KCHKzgtX+o4WGO/f
 79Cf3fQZdlLh87hjIP0DCUPYebA+Y6rpJofz8RyXGJ5uCtNnB9PE6vwBann+vfYdNq
 GhmrGDOhotq8hv33QCf4c2jLICADNWMsIW6ljhvK3gzH37nSICKfBkjFqAQGzuvL5K
 /FR4fuEQN8yqg/O+ThhT/Rv17Cpq5/UPztQzzBFCiQYetyf6PnHhNJ+n8DCFV3lyio
 jUM7xbLd/UYcQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 01C5BB221939;
 Fri, 12 Jun 2026 19:06:21 +0200 (CEST)
Message-ID: <bdc0532a-0b03-4eb2-82b9-60b54818be7b@freeshell.de>
Date: Fri, 12 Jun 2026 10:06:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: E Shattow <e@freeshell.de>
Subject: Re: [PATCH 1/2] feat(created-dts-for-pinetab-v): Created template for
 pinetab-v
To: anoduck@protonmail.com, u-boot@lists.denx.de
Cc: anoduck <9925396+anoduck@users.noreply.github.com>
References: <20260612003330.220595-1-anoduck@protonmail.com>
Content-Language: en-US
In-Reply-To: <20260612003330.220595-1-anoduck@protonmail.com>
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

Hi anoduck,

On 6/11/26 17:33, anoduck@protonmail.com wrote:
> From: anoduck <9925396+anoduck@users.noreply.github.com>
> 
> ---
>  ...jh7110-starfive-visionfive-2-pinetab-v.dts | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-pinetab-v.dts

Okay, we don't touch dts/ that is a git remote of devicetree-rebasing,
only maintainers will make changes there during a merge. If you need to
stub out something just create an empty file with no code and prefix
your series as RFC;  changes can be brought in with the automatic
inclusion strategy of the U-Boot build system in i.e.
arch/riscv/dts/${soc}-${target}-u-boot.dtsi for example I would guess
arch/riscv/dts/jh7110-pine64-pinetabv.dtsi matching the target in
CONFIG_OF_LIST of configs/starfive_visionfive2_defconfig

Aside, you may think of configs/starfive_visionfive2_defconfig as
"configs/starfive_jh7110_defconfig" it is a multi-board build config for
all jh7110 boards supported by U-Boot.

If for some reason you are making modifications to dts/ in your series
necessary for code review and feedback it should be prefixed "RFC" in
the git format-patch command, and for multiple patches in a series then
generate and edit a cover letter (patch "00") explaining what the
purpose of the series is. I would suggest that anything destined for
upstreaming first undergo review at the Linux kernel mailing list, and
then can be referenced in U-Boot. When there is acceptance upstream then
the following Linux release candidate would appear in the
devicetree-rebasing tree and then eventually U-Boot as the git remote
dts/ which can be cleanly cherry-pick'ed.

> 
> diff --git a/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-pinetab-v.dts b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-pinetab-v.dts
> new file mode 100644
> index 00000000000..d7ef053a83a
> --- /dev/null
> +++ b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-pinetab-v.dts
> @@ -0,0 +1,23 @@

The filename "jh7110-starfive-visionfive-2-pinetab-v.dts" is not
consistent with the existing file layout. Did you instead intend for
"jh7110-pine64-pinetabv.dts" ?

> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2026 T Anoduck <anoduck@protonmail.com>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-starfive-visionfive-2.dtsi"
> +

Do not include dtsi from unrelated boards. You may include
"jh7110-common.dtsi" or "jh7110.dtsi" and if there are many variations
of your board that have nodes in common not well represented by
"jh7110-common.dtsi" then creating your own dts include for the variations.

> +/ {
> +	model = "Pine64 Pinetab-V";
> +	compatible = "pine64,pinetab-v", "starfive,jh7110";
> +};

Okay. I would suggest "pine64,pinetabv" but it is just a matter of style
and preference. This needs a binding and to be submitted upstream
however you will author it.

> +
> +// &sd-vcc {
> +//         compatible = "regulator-fixed";
> +//         regulator-name = "sd_vcc";
> +//         regulator-min-microvolt = <3300000>;
> +//         regulator-max-microvolt = <3300000>;
> +//         gpio = <&sysgpio 35 GPIO_ACTIVE_LOW>;
> +//         enable-active-low;
> +//         regulator-boot-on;
> +//         regulator-always-on;
> +// };

Unclear what is the purpose of commented code?

Best regards,

- E Shattow
