Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB79C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 03:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1AC88728;
	Tue,  7 May 2024 05:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JpLFuenE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2E8B88727; Tue,  7 May 2024 05:29:03 +0200 (CEST)
Received: from mail-m19731108.qiye.163.com (mail-m19731108.qiye.163.com
 [220.197.31.108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A37B88651
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 05:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=JpLFuenE1V57igQTlEQK0HKPlLRkXibyjwdkZp9smBD6hWF8wR/eF+WXGCr5QIKvm6i7qGQdcFQoBI2d9DSQheZtr/pR83Wf7P55ycSy5qUgCpkcxv39xEX/ACIsX+UOBv9KeIZXlZ1qE1Ly6sWoU/btMVQANprybQGPJwjzZeQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=VTQZJlYNVtAmLLwc5Gsq8ShL9pzpkb7yaiCBrxi4nRE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 8C3AF900267;
 Tue,  7 May 2024 11:28:46 +0800 (CST)
Message-ID: <2e223c89-7ea9-4444-b4ee-9f30541dff67@rock-chips.com>
Date: Tue, 7 May 2024 11:28:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] configs: rk3588-turing-rk1: disable SPI flash by
 default
To: Sam Edwards <cfsworks@gmail.com>, Joshua Riek <jjriek@verizon.net>,
 Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de,
 Florian Klink <flokli@flokli.de>
References: <20240502200729.77955-1-CFSworks@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240502200729.77955-1-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkZGFZNQx0ZT0kZTUkfSB5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f5118bd7903a9kunm8c3af900267
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQg6Ahw6PTMMLhQCFRZLGQML
 GjgKFFZVSlVKTEpOS05JTklMTkhKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPT05JNwY+
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


On 2024/5/3 04:07, Sam Edwards wrote:
> While the Turing RK1 board has a pad on the PCB for SPI flash, it is
> not populated at the factory: supporting SPI flash boot is a user
> modification, not an out-of-the-box feature. The defconfig for this
> board should therefore not be enabling the SPI flash image nor SPI
> support in the SPL, as it causes confusion among downstream users as to
> whether the SPI image needs to be distributed.
>
> Fixes: 153ac950a599 ("board: rockchip: Add the Turing RK1 SoM")
> Suggested-by: Florian Klink <flokli@flokli.de>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> Acked-by: Joshua Riek <jjriek@verizon.net>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> Changes v1->v2 (both requested by Jonas):
> - Added back (i.e. made unremoved by patch) CONFIG_USB_GADGET_PRODUCT_NUM value
>    previously automatically removed by savedefconfig.
> - Also disable SPI/SFC driver entirely until SPI/SFC lands in the DT (if ever).
>
> Changes v2->v3:
> - Rebased onto latest master for clean apply
>
> ---
>   configs/turing-rk1-rk3588_defconfig | 14 +-------------
>   1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
> index 038b14769e..39ef05477a 100644
> --- a/configs/turing-rk1-rk3588_defconfig
> +++ b/configs/turing-rk1-rk3588_defconfig
> @@ -3,17 +3,12 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_SF_DEFAULT_SPEED=24000000
> -CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588-turing-rk1"
>   CONFIG_ROCKCHIP_RK3588=y
> -CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_SPL_SERIAL=y
>   CONFIG_TARGET_TURINGRK1_RK3588=y
>   CONFIG_DEBUG_UART_BASE=0xFEBC0000
>   CONFIG_DEBUG_UART_CLOCK=24000000
> -CONFIG_SPL_SPI_FLASH_SUPPORT=y
> -CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0xc00800
>   CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
> @@ -29,8 +24,6 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -CONFIG_SPL_SPI_LOAD=y
> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> @@ -64,11 +57,7 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> -CONFIG_SF_DEFAULT_BUS=5
> -CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> -CONFIG_SPI_FLASH_MACRONIX=y
> -CONFIG_SPI_FLASH_XMC=y
> -CONFIG_SPI_FLASH_XTX=y
> +# CONFIG_SPI_FLASH is not set
>   CONFIG_PHY_REALTEK=y
>   CONFIG_DWC_ETH_QOS=y
>   CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> @@ -84,7 +73,6 @@ CONFIG_SPL_RAM=y
>   CONFIG_SCSI=y
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> -CONFIG_ROCKCHIP_SFC=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
