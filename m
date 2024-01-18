Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3196C47077
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1932D87B57;
	Thu, 18 Jan 2024 08:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JiHziRdt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C13887A00; Thu, 18 Jan 2024 08:03:52 +0100 (CET)
Received: from mail-m24121.xmail.ntesmail.com (mail-m24121.xmail.ntesmail.com
 [45.195.24.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AFE8877FE
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=JiHziRdtildUkIBdxZuK64h3wMyJ1T3t5LH44hsPm6r1BcyPQPUEhoQGK97RNova61xSF6xSQAGeXayfuWujhzA0cQDaRBacrv1dYwB9biUWQM50nZztQPkPo/H+jpeQhloespOMFMPQc1AffTNzxW/aFpy+BmFv07T1WkwJoUI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=0UXViGIXoB5TcZFWnRyzvHOxbnPCEhgBaeP2tbW28AQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 9AB2C9001B9;
 Thu, 18 Jan 2024 15:03:44 +0800 (CST)
Message-ID: <70bf61f1-5884-4d41-9422-ee1e5010a851@rock-chips.com>
Date: Thu, 18 Jan 2024 15:03:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] rockchip: rk3588: Fix boot from SPI flash
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: John Clark <inindev@gmail.com>, Slawomir Stepien <sst@poczta.fm>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20231117232442.1430276-1-jonas@kwiboo.se>
 <20231117232442.1430276-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231117232442.1430276-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhpNQ1ZDHkIaGElIGR9DT0xVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1b6203e02eafkusn9ab2c9001b9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBA6ATo*HTwqURAoSig0GCwW
 IzUwCxZVSlVKTEtOTk1KT0lOT0hMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPT0xMNwY+
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
> The commit fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI
> NOR flash") added a new BROM_BOOTSOURCE_SPINOR_RK3588 with value 6.
>
> At the time the reason for this new bootsource id value 6 was unknown.
>
> We now know that the BootRom on RK3588 use different bootsource id
> values depending on the iomux used by the flash spi controller, and not
> by the type of spi nor or spi nand flash used.
>
> Add the following enum values and use them for RK3588 boot_devices.
>
> - BROM_BOOTSOURCE_FSPI_M0 = 3
> - BROM_BOOTSOURCE_FSPI_M1 = 4
> - BROM_BOOTSOURCE_FSPI_M2 = 6
>
> Fixes: fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI NOR flash")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Slawomir Stepien <sst@poczta.fm>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Move FSPI M0/M1/M2 enum values from bootrom.h to rk3588.c
> - Add t-b tag
>
>   arch/arm/include/asm/arch-rockchip/bootrom.h |  1 -
>   arch/arm/mach-rockchip/rk3588/rk3588.c       | 16 ++++++++++++++--
>   2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
> index 7dab18fbc3fb..4276a0f6811a 100644
> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> @@ -48,7 +48,6 @@ enum {
>   	BROM_BOOTSOURCE_SPINOR = 3,
>   	BROM_BOOTSOURCE_SPINAND = 4,
>   	BROM_BOOTSOURCE_SD = 5,
> -	BROM_BOOTSOURCE_SPINOR_RK3588 = 6,
>   	BROM_BOOTSOURCE_USB = 10,
>   	BROM_LAST_BOOTSOURCE = BROM_BOOTSOURCE_USB
>   };
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index b1f535fad505..7b0349ec2577 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -37,11 +37,23 @@ DECLARE_GLOBAL_DATA_PTR;
>   #define BUS_IOC_GPIO2D_IOMUX_SEL_H	0x5c
>   #define BUS_IOC_GPIO3A_IOMUX_SEL_L	0x60
>   
> +/**
> + * Boot-device identifiers used by the BROM on RK3588 when device is booted
> + * from SPI flash. IOMUX used for SPI flash affect the value used by the BROM
> + * and not the type of SPI flash used.
> + */
> +enum {
> +	BROM_BOOTSOURCE_FSPI_M0 = 3,
> +	BROM_BOOTSOURCE_FSPI_M1 = 4,
> +	BROM_BOOTSOURCE_FSPI_M2 = 6,
> +};
> +
>   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe2e0000",
> -	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
> +	[BROM_BOOTSOURCE_FSPI_M0] = "/spi@fe2b0000/flash@0",
> +	[BROM_BOOTSOURCE_FSPI_M1] = "/spi@fe2b0000/flash@0",
> +	[BROM_BOOTSOURCE_FSPI_M2] = "/spi@fe2b0000/flash@0",
>   	[BROM_BOOTSOURCE_SD] = "/mmc@fe2c0000",
> -	[BROM_BOOTSOURCE_SPINOR_RK3588] = "/spi@fe2b0000/flash@0",
>   };
>   
>   static struct mm_region rk3588_mem_map[] = {
