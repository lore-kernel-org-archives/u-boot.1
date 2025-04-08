Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7677AC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 534BF831C2;
	Tue,  8 Apr 2025 05:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KPe64ZXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DA3B82CE7; Tue,  8 Apr 2025 05:19:48 +0200 (CEST)
Received: from mail-m49247.qiye.163.com (mail-m49247.qiye.163.com
 [45.254.49.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43FBE83291
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1101e8a6b;
 Tue, 8 Apr 2025 11:19:41 +0800 (GMT+08:00)
Message-ID: <fe9214db-1bb5-48e4-9356-bec477dd009f@rock-chips.com>
Date: Tue, 8 Apr 2025 11:19:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] rockchip: Use rk3588_common.h by default for RK3588
 boards
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250406002447.1555596-1-jonas@kwiboo.se>
 <20250406002447.1555596-8-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250406002447.1555596-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhPQ1ZLH0pPSExPSEpISx5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9613692a8f03afkunm1101e8a6b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBA6Nio*DDIMD0IqLyI*Lwk9
 DS0aCg9VSlVKTE9PS0NJSENJT09NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSEtNNwY+
DKIM-Signature: a=rsa-sha256;
 b=KPe64ZXVFnKIl3XJb5Kv+XKT42EKuvnv83/Q6fM34fvUdeCZ2w6NvimU8Tes1+5ocr4ag5benV+EKmM3Fj57cUJiIOm9o3SiIcz4EntJMadbDogktIuQ1SJP4/2xdgfmq4xpAYrpJTGEUtIUCnu+yyrBZUiyqZIVaJEt5WJS+Xs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=goGDFdvPVvc7Ri2nmooWNd8RUeALQ9bOywnMq7pVDa4=;
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


On 2025/4/6 08:24, Jonas Karlman wrote:
> Ensure rk3588_common.h can be used by boards directly by defining a
> blank ROCKCHIP_DEVICE_SETTINGS unless it already is defined.
>
> Add a default SYS_CONFIG_NAME to include rk3588_common.h unless a board
> target overrides it in its board Kconfig.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3588/Kconfig | 3 +++
>   include/configs/rk3588_common.h       | 4 ++++
>   2 files changed, 7 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index 1c6a85d07394..8acb6618718f 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -441,4 +441,7 @@ source "board/rockchip/toybrick_rk3588/Kconfig"
>   source "board/theobroma-systems/jaguar_rk3588/Kconfig"
>   source "board/theobroma-systems/tiger_rk3588/Kconfig"
>   
> +config SYS_CONFIG_NAME
> +	default "rk3588_common"
> +
>   endif
> diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
> index 7b02560971ad..2f0d40deb640 100644
> --- a/include/configs/rk3588_common.h
> +++ b/include/configs/rk3588_common.h
> @@ -14,6 +14,10 @@
>   #define CFG_SYS_SDRAM_BASE		0
>   #define SDRAM_MAX_SIZE			0xf0000000
>   
> +#ifndef ROCKCHIP_DEVICE_SETTINGS
> +#define ROCKCHIP_DEVICE_SETTINGS
> +#endif
> +
>   #define ENV_MEM_LAYOUT_SETTINGS		\
>   	"scriptaddr=0x00c00000\0"	\
>   	"script_offset_f=0xffe000\0"	\
