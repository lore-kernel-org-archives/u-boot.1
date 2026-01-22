Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359D5D6CFAB
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 23:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F3AA83B63;
	Fri, 23 Jan 2026 00:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDD1839DF; Fri, 23 Jan 2026 00:53:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5D72483946
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 00:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2D7A1476;
 Thu, 22 Jan 2026 15:53:03 -0800 (PST)
Received: from [192.168.13.211] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 9CC1B3F694; Thu, 22 Jan 2026 15:53:07 -0800 (PST)
Message-ID: <03086904-df06-488c-9e8d-5ad5dab9255a@arm.com>
Date: Thu, 22 Jan 2026 23:53:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v3] board: sunxi: Add X96Q support
To: j.ne@posteo.net, u-boot@lists.denx.de
Cc: linux-sunxi <linux-sunxi@lists.linux.dev>, Tom Rini <trini@konsulko.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Peter Geis <pgwipeout@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Chen-Yu Tsai <wens@kernel.org>,
 Lukas Schmid <lukas.schmid@netcube.li>
References: <20260120-x96q-v3-1-1419ee399fa1@posteo.net>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260120-x96q-v3-1-1419ee399fa1@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,

thanks, that looks very good now. Just one tiny thing:

On 20/01/2026 15:20, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> output, and infrared input.
> 
>    https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
> 
> This commit adds a defconfig and some documentation. The devicetree is
> already in dts/upstream.
> 
> The CONFIG_DRAM_SUNXI_* settings are chosen such that the register
> values in the DRAM PHY's MMIO space are as close as possible to those
> observed when booting with the preinstalled vendor U-Boot. The DRAM
> clock frequency of 600 MHz was reported in the vendor U-Boot's output.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> Changes in v3:
> - Remove CONFIG_FIT_BEST_MATCH, CONFIG_CMD_UFETCH/CAT, CONFIG_SYS_I2C_SLAVE
>    and CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT from defconfig
> - Add board/sunxi/MAINTAINERS entry
> - Remove board-specific documentation
> - Link to v2: https://lore.kernel.org/r/20260110-x96q-v2-1-1d6a725eb825@posteo.net
> 
> Changes in v2:
> - Add missing Signed-off-by
> - Re-generate x96q_defconfig with 'make savedefconfig'
> - Move DRAM frequency comment to commit message
> - Use GPL-2.0-or-later instead of deprecated GPL-2.0+
> - Link to v1: https://lore.kernel.org/r/20251231-x96q-v1-1-316d703b8f03@posteo.net
> ---
>   board/sunxi/MAINTAINERS |  5 +++++
>   configs/x96q_defconfig  | 26 ++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
> index c52e8a34c85..775d0f7ae83 100644
> --- a/board/sunxi/MAINTAINERS
> +++ b/board/sunxi/MAINTAINERS
> @@ -611,6 +611,11 @@ M:	Andre Przywara <andre.przywara@arm.com>
>   S:	Maintained
>   F:	configs/x96_mate_defconfig
>   
> +X96Q TV BOX
> +M:	J. Neuschäfer <j.ne@posteo.net>
> +S:	Maintained
> +F:	configs/x96q_defconfig
> +
>   X96Q PRO+ TV BOX
>   M:	Andre Przywara <andre.przywara@arm.com>
>   S:	Maintained
> diff --git a/configs/x96q_defconfig b/configs/x96q_defconfig
> new file mode 100644
> index 00000000000..24c214b4c63
> --- /dev/null
> +++ b/configs/x96q_defconfig
> @@ -0,0 +1,26 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_SUNXI=y
> +CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h313-x96q"
> +CONFIG_DRAM_CLK=600
> +CONFIG_SPL=y
> +CONFIG_DRAM_SUNXI_DX_ODT=0x03030303
> +CONFIG_DRAM_SUNXI_DX_DRI=0x0e0e0e0e
> +CONFIG_DRAM_SUNXI_CA_DRI=0x1f12
> +CONFIG_DRAM_SUNXI_TPR0=0xc0001002
> +CONFIG_DRAM_SUNXI_TPR2=0x00000100
> +CONFIG_DRAM_SUNXI_TPR10=0x002f0107
> +CONFIG_DRAM_SUNXI_TPR11=0xddddcccc
> +CONFIG_DRAM_SUNXI_TPR12=0xeddc7665
> +CONFIG_MACH_SUN50I_H616=y
> +CONFIG_SUNXI_DRAM_H616_DDR3_1333=y

This misses -CONFIG_MMC_SUNXI_SLOT_EXTRA=2 here, was this deliberate? 
The DT mentions the eMMC, and you have CONFIG_SUPPORT_EMMC_BOOT below, 
so is this just on omission? Or did the eMMC not work?

If you can confirm, I can just add this while committing.

Cheers,
Andre

> +CONFIG_R_I2C_ENABLE=y
> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_SYS_I2C_LEGACY=y
> +CONFIG_SYS_I2C_MVTWSI=y
> +CONFIG_SYS_I2C_SPEED=400000
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_SUN8I_EMAC=y
> +CONFIG_AXP305_POWER=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_OHCI_HCD=y
> 
> ---
> base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
> change-id: 20251231-x96q-998c1376ebbf
> 
> Best regards,

