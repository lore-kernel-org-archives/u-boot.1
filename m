Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D12C3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500EC82B6C;
	Sun,  6 Apr 2025 17:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Eez95NAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C568A82BF2; Sun,  6 Apr 2025 17:33:48 +0200 (CEST)
Received: from mail-m1973198.qiye.163.com (mail-m1973198.qiye.163.com
 [220.197.31.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 354AA82BE3
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d0680d5;
 Sun, 6 Apr 2025 23:33:40 +0800 (GMT+08:00)
Message-ID: <52eb719f-6e5b-41ce-bb6d-dc671ed3438e@rock-chips.com>
Date: Sun, 6 Apr 2025 23:33:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] rockchip: binman: Include a compatible string in
 each configuration
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki
 <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-8-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250329150626.2879942-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ0lMVk9KSUlIH0JCHh0eT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960bbc6eed03afkunm10d0680d5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORw6ASo5LjIDH0kxCT0MPA4Z
 DiIaCh5VSlVKTE9IQk5ITUlKTUtMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFKTE9PNwY+
DKIM-Signature: a=rsa-sha256;
 b=Eez95NAWf7mk3+GfjEQj6CexSzAlBdLkwYtBWlDVG8jfEqYDnya+eavPOSHvKBHw9dfZUREozYqBUtARcv8VLJ1eN6Ase34Wg4vKSMUj2iiKtxVJcni9b8Ub8ihlcBsljgQe22wO6wAO2iwC5S84IjycU5axZIgMBCVPUGmzFqY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=mdmrrCfg8bKXzdhb1Q84SxSa71FndH0VmLheHriBOP8=;
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


On 2025/3/29 23:06, Jonas Karlman wrote:
> From: Simon Glass <sjg@chromium.org>
>
> Provide a compatible string in the config nodes that U-Boot can use to
> help decide which configuration to use.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v4:
> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 73149b2d8bdd..fb38b7b80c43 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -145,6 +145,7 @@
>   				fit,firmware = "op-tee", "u-boot";
>   #endif
>   				fit,loadables;
> +				fit,compatible;
>   			};
>   		};
>   	};
