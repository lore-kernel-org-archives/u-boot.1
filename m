Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D04C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D607D82B4A;
	Sun,  6 Apr 2025 17:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="G4JKvO3E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C27FA82B53; Sun,  6 Apr 2025 17:11:17 +0200 (CEST)
Received: from mail-m1973188.qiye.163.com (mail-m1973188.qiye.163.com
 [220.197.31.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DDF882B46
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d0205a1;
 Sun, 6 Apr 2025 23:11:11 +0800 (GMT+08:00)
Message-ID: <b2ae8385-764c-4a3b-967f-a6907964a5ba@rock-chips.com>
Date: Sun, 6 Apr 2025 23:11:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 1/3] rockchip: px30: enable RNG for all boards
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250129-px30-overlay-v1-0-4729b3fcb4c0@cherry.de>
 <20250129-px30-overlay-v1-1-4729b3fcb4c0@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250129-px30-overlay-v1-1-4729b3fcb4c0@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGExMVkkZSBkdH0NMTRkaHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960ba7d75c03afkunm10d0205a1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhQ6Pzo*CTJLNUlCCk9RMzcM
 PTZPCU5VSlVKTE9IQk5JSUxJS09NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFJSENCNwY+
DKIM-Signature: a=rsa-sha256;
 b=G4JKvO3EKomqaMcpGsG1o6uj1VKyyuh+5p4dA/ftQg+rejdy0x4/boSN6+IrzmlhbV5tILVY6S9cxe88tENtVdsxkFZGdo+oT0gJTJYZ8YLM1bh3snpjvya63ypNLJ6li8JSO0SVBVyORQMgT4s2EvG4o5EQBX/QWF15dEtj3hk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=HQnCf8wYIvB5IxXP4nAWrqp6l3OSWy4POyu50J4PLRQ=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/1/29 18:43, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> I don't see a reason why this should only be enabled on a per-board
> basis. The rng IP is inside the SoC and doesn't seem to rely on anything
> external to it, therefore let's enable it on the SoC DTSI and remove the
> now empty px30-evb-u-boot.dtsi.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/px30-evb-u-boot.dtsi | 10 ----------
>   arch/arm/dts/px30-u-boot.dtsi     |  1 -
>   2 files changed, 11 deletions(-)
>
> diff --git a/arch/arm/dts/px30-evb-u-boot.dtsi b/arch/arm/dts/px30-evb-u-boot.dtsi
> deleted file mode 100644
> index 61b1433af9192044a34ccf66763f2142a44288ab..0000000000000000000000000000000000000000
> --- a/arch/arm/dts/px30-evb-u-boot.dtsi
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * (C) Copyright 2020 Rockchip Electronics Co., Ltd
> - */
> -
> -#include "px30-u-boot.dtsi"
> -
> -&rng {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
> index abc6b49e6663ccfbc5659f0467c511934832da67..157d0ea6930c55cc067560bd795249a39c3249ab 100644
> --- a/arch/arm/dts/px30-u-boot.dtsi
> +++ b/arch/arm/dts/px30-u-boot.dtsi
> @@ -24,7 +24,6 @@
>   	rng: rng@ff0b0000 {
>   		compatible = "rockchip,cryptov2-rng";
>   		reg = <0x0 0xff0b0000 0x0 0x4000>;
> -		status = "disabled";
>   	};
>   };
>   
>
