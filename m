Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09F7C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D2A182ABA;
	Sun,  6 Apr 2025 17:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="K2VPdiXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BD9682B4A; Sun,  6 Apr 2025 17:18:40 +0200 (CEST)
Received: from mail-m19731116.qiye.163.com (mail-m19731116.qiye.163.com
 [220.197.31.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A656B8004F
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d02066f;
 Sun, 6 Apr 2025 23:18:32 +0800 (GMT+08:00)
Message-ID: <2151dfb4-b71f-4e52-bb51-663ced49abc5@rock-chips.com>
Date: Sun, 6 Apr 2025 23:18:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] rockchip: binman: Add an fdtmap
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki
 <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250329150626.2879942-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTBhCVh1LS0pLQxgeSh1CH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960bae921b03afkunm10d02066f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6SQw6NjJWLUkuCkgSMx8D
 EEoaChlVSlVKTE9IQk5JTEpISUhJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFKQk1NNwY+
DKIM-Signature: a=rsa-sha256;
 b=K2VPdiXYlYaEE5abRsJFfNrd6zVSYFTdBkzMCj7LA1sMN7oiwBCIbmx2vKZ14mnM+9hYmYReULgl97/4/X3zCG6pDYikHTls2ud9T0YGCluLRmgYkZR4O6wHpAYHGfW+eLsuASYNmgdoIDJ3JBLUHEfsy7fU47t/MLftbbfEft0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=oI2HFa30076ECs3nDqj2B5SYz3JSphZ4KmeNx4LmxKg=;
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
> Add an fdtmap so it is possible to look at the image with 'binman ls'.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v4:
> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
>
> Changes in v3:
> - Add blank lines before the node
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 2b01dc660562..8aea2e6f5713 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -170,6 +170,9 @@
>   			offset = <CONFIG_SPL_PAD_TO>;
>   		};
>   #endif
> +
> +		fdtmap {
> +		};
>   	};
>   
>   #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> @@ -203,6 +206,9 @@
>   			/* Sync with u-boot,spl-payload-offset if present */
>   			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
>   		};
> +
> +		fdtmap {
> +		};
>   	};
>   #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
>   };
