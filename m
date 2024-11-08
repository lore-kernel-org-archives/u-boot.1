Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ED5D5E147
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 08:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C24FE8900E;
	Fri,  8 Nov 2024 09:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="H73wyLhn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31FB18901D; Fri,  8 Nov 2024 09:54:45 +0100 (CET)
Received: from mail-m15598.qiye.163.com (mail-m15598.qiye.163.com
 [101.71.155.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9DFD88F4A
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 09:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2317db5a;
 Fri, 8 Nov 2024 16:54:36 +0800 (GMT+08:00)
Message-ID: <1cd194df-32a3-4f28-a02f-8d07b77486f3@rock-chips.com>
Date: Fri, 8 Nov 2024 16:54:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] rockchip: rk3288-tinker: Set cpuid and serial env
 var
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20241105160054.1373319-1-jonas@kwiboo.se>
 <20241105160054.1373319-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105160054.1373319-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0MfVh9IT0xKQ0hDHkJMGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a930afb871603afkunm2317db5a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxQ6Kgw4TDIYSyoiDgMcFzhJ
 PgkKC0JVSlVKTEhKS05NS0xDSE9KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlNQ0k3Bg++
DKIM-Signature: a=rsa-sha256;
 b=H73wyLhnxQDYrQcWWzuJwuoZsNq1YykRI5NxZKWYGzTddCIpzxx41vbdJlR8gCGPotAdYRHWRIb+RVJ4hmOOkPtFTjaGb2XombrjTee7ozst81tMEGWlKb5RaZ6LbZwq9Veze+/ZrEIMBUa5bcPNik/e2ly/S/12eu3QkB6k0o8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=vEe5oLWSZTxdS2egijB2Ex8cx2S9TWH28GFS3D77HuU=;
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


On 2024/11/6 00:00, Jonas Karlman wrote:
> Enable MISC_INIT_R and ROCKCHIP_EFUSE to read cpuid from efuse and set
> the cpuid# and serial# env vars.
>
> Change to read mac address from eeprom in rockchip_early_misc_init_r()
> to ensure the ethaddr env var is set before rockchip_setup_macaddr() try
> to set ethaddr based on cpuid.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/rockchip/tinker_rk3288/tinker-rk3288.c | 2 +-
>   configs/tinker-rk3288_defconfig              | 2 ++
>   configs/tinker-s-rk3288_defconfig            | 2 ++
>   3 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/board/rockchip/tinker_rk3288/tinker-rk3288.c b/board/rockchip/tinker_rk3288/tinker-rk3288.c
> index e966e9f201ab..dfd553d1aa5f 100644
> --- a/board/rockchip/tinker_rk3288/tinker-rk3288.c
> +++ b/board/rockchip/tinker_rk3288/tinker-rk3288.c
> @@ -22,7 +22,7 @@ static int get_ethaddr_from_eeprom(u8 *addr)
>   	return i2c_eeprom_read(dev, 0, addr, 6);
>   }
>   
> -int rk3288_board_late_init(void)
> +int rockchip_early_misc_init_r(void)
>   {
>   	u8 ethaddr[6];
>   
> diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
> index aff820ebfdda..851c312d4db5 100644
> --- a/configs/tinker-rk3288_defconfig
> +++ b/configs/tinker-rk3288_defconfig
> @@ -29,6 +29,7 @@ CONFIG_USE_PREBOOT=y
>   CONFIG_DEFAULT_FDT_FILE="rk3288-tinker.dtb"
>   CONFIG_SILENT_CONSOLE=y
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_SPL_NO_BSS_LIMIT=y
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> @@ -63,6 +64,7 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
> +CONFIG_ROCKCHIP_EFUSE=y
>   CONFIG_I2C_EEPROM=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
> index 6aef775a5717..2269d04ee644 100644
> --- a/configs/tinker-s-rk3288_defconfig
> +++ b/configs/tinker-s-rk3288_defconfig
> @@ -29,6 +29,7 @@ CONFIG_USE_PREBOOT=y
>   CONFIG_DEFAULT_FDT_FILE="rk3288-tinker-s.dtb"
>   CONFIG_SILENT_CONSOLE=y
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_SPL_NO_BSS_LIMIT=y
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> @@ -64,6 +65,7 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
> +CONFIG_ROCKCHIP_EFUSE=y
>   CONFIG_I2C_EEPROM=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
