Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB91C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8970D87B7A;
	Thu, 18 Jan 2024 08:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="e2HDRbTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C64DA87B7F; Thu, 18 Jan 2024 08:04:19 +0100 (CET)
Received: from mail-m608.netease.com (mail-m608.netease.com [210.79.60.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83332877FE
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=e2HDRbTuv8TWy70Mq2YtEgHw+XuPfaDvTV4fT1AOlJ1+ZWB3xvtLJdzhnw/yyZw/4R0pmby+/j3IrwY6ITl5aD+aJBJSeiniFjxcX+ViL+mc/GsYuzwAPvumLmH2wLT3pU6jo8n0wDL03/7/T61WiOy/LsqW3OQ1inW8z1fH5Ik=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=5yxu7ZNUZnsZc29gnrxX2N7OV7TbITXUJNUAzq4OEvE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 3DA32900177;
 Thu, 18 Jan 2024 15:04:14 +0800 (CST)
Message-ID: <b059c7de-fe38-4252-b4cf-0cc2225c632f@rock-chips.com>
Date: Thu, 18 Jan 2024 15:04:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] rockchip: rk3588-orangepi-5-plus: Build SPI image
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: John Clark <inindev@gmail.com>, Slawomir Stepien <sst@poczta.fm>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20231117232442.1430276-1-jonas@kwiboo.se>
 <20231117232442.1430276-4-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231117232442.1430276-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwaQlZLSx5KTk1MHRgeTUxVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1b6277f22eafkusn3da32900177
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006Egw4MTwoDBAuIyguGE0U
 OhYKC01VSlVKTEtOTk1KT05OSUpPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUpINwY+
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


On 2023/11/18 07:24, Jonas Karlman wrote:
> From: Slawomir Stepien <sst@poczta.fm>
>
> Enable building of the SPI image, u-boot-rockchip-spi.bin, now that we
> know what bootsource id values BootRom use for SPI flash on RK3588.
>
> Fixes: b51cf8bb09b6 ("board: rockchip: Add Xunlong Orange Pi 5 Plus")
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - No change
>
>   configs/orangepi-5-plus-rk3588_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
> index 04736996217e..e1cd753a6d18 100644
> --- a/configs/orangepi-5-plus-rk3588_defconfig
> +++ b/configs/orangepi-5-plus-rk3588_defconfig
> @@ -14,6 +14,7 @@ CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588-orangepi-5-plus"
>   CONFIG_ROCKCHIP_RK3588=y
>   CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_SPL_SERIAL=y
>   CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_TARGET_EVB_RK3588=y
