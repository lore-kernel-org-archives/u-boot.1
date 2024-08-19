Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5156DC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 17:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBF41883A4;
	Mon, 19 Aug 2024 19:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64EB088CF1; Mon, 19 Aug 2024 19:21:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C772F882F0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 19:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27BD6339;
 Mon, 19 Aug 2024 10:21:41 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45EB33F58B;
 Mon, 19 Aug 2024 10:21:13 -0700 (PDT)
Date: Mon, 19 Aug 2024 18:21:10 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jernej.skrabec@gmail.com,
 neil.armstrong@linaro.org, hdegoede@redhat.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 9/9] sunxi: Add support for Anbernic RG35XX-2024
Message-ID: <20240819182110.5867a5ec@donnerap.manchester.arm.com>
In-Reply-To: <20240819145938.503221-10-macroalpha82@gmail.com>
References: <20240819145938.503221-1-macroalpha82@gmail.com>
 <20240819145938.503221-10-macroalpha82@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 19 Aug 2024 09:59:38 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

Hi Chris,

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> The Anbernic RG35XX series of devices are based around an Allwinner
> H700 SoC with 1GB of RAM, 2 SD cards, and multiple input buttons.
> 
> This bootloader has been tested on the Anbernic RG35XX-2024 and
> RG35XX-H, but should be suitable for the entire lineup of H700 based
> devices.
> 
> A future series of updates will add board selection logic to identify
> and load the correct device tree automatically.

So diverging from the rest of sunxi, you are switching to OF_UPSTREAM and
bootstd here, just for that board. Please don't do this. Both methods are
board agnostic, and just depend on generic platform code to work.
I have a patch to switch all H616 boards over to OF_UPSTREAM, so this
wouldn't be needed to be done here. If you want to patch the DT, you could
do this in arch/arm/dts as well.
For bootstd Simon had a series to enable that on sunxi, on which I
commented:
https://lore.kernel.org/u-boot/20240807205032.3745680-1-sjg@chromium.org/

So please keep this board in line with the rest of the sunxi boards, and
we will automatically upgrade it to both OF_UPSTREAM and bootstd as soon
as that's ready.

Also the defconfig looks quite elaborate, are those options really all
needed? The idea of defconfig is just to provide a, well, default. On
sunxi we also try to keep that minimal.

Thanks,
Andre

> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  board/sunxi/MAINTAINERS                |  5 +++
>  configs/anbernic_rg35xx_h700_defconfig | 52 ++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>  create mode 100644 configs/anbernic_rg35xx_h700_defconfig
> 
> diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
> index 4ad77c75f5..84799879e8 100644
> --- a/board/sunxi/MAINTAINERS
> +++ b/board/sunxi/MAINTAINERS
> @@ -132,6 +132,11 @@ M:	Paul Kocialkowski <contact@paulk.fr>
>  S:	Maintained
>  F:	configs/Ampe_A76_defconfig
>  
> +ANBERNIC RG35XX-2024
> +M:	Chris Morgan <macromorgan@hotmail.com>
> +S:	Maintained
> +F:	configs/anbernic_rg35xx_h700_defconfig
> +
>  BANANAPI M1 PLUS
>  M:	Jagan Teki <jagan@amarulasolutions.com>
>  S:	Maintained
> diff --git a/configs/anbernic_rg35xx_h700_defconfig b/configs/anbernic_rg35xx_h700_defconfig
> new file mode 100644
> index 0000000000..6ea2f45d2f
> --- /dev/null
> +++ b/configs/anbernic_rg35xx_h700_defconfig
> @@ -0,0 +1,52 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_SUNXI=y
> +CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h700-anbernic-rg35xx-2024"
> +CONFIG_SPL=y
> +CONFIG_DRAM_SUN50I_H616_DX_ODT=0x08080808
> +CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
> +CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
> +CONFIG_DRAM_SUN50I_H616_ODT_EN=0x7887bbbb
> +CONFIG_DRAM_SUN50I_H616_TPR2=0x1
> +CONFIG_DRAM_SUN50I_H616_TPR6=0x40808080
> +CONFIG_DRAM_SUN50I_H616_TPR10=0x402f6633
> +CONFIG_DRAM_SUN50I_H616_TPR11=0x1b1f1e1c
> +CONFIG_DRAM_SUN50I_H616_TPR12=0x06060606
> +CONFIG_MACH_SUN50I_H616=y
> +CONFIG_RESERVE_ALLWINNER_BOOT0_HEADER=y
> +CONFIG_SUNXI_DRAM_H616_LPDDR4=y
> +CONFIG_DRAM_CLK=672
> +CONFIG_R_I2C_ENABLE=y
> +CONFIG_DEFAULT_FDT_FILE="sun50i-h700-anbernic-rg35xx-2024.dtb"
> +CONFIG_LAST_STAGE_INIT=y
> +CONFIG_SPL_I2C=y
> +CONFIG_CMD_BDINFO_EXTRA=y
> +CONFIG_CMD_BOOTDEV=y
> +CONFIG_CMD_BOOTMETH=y
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_BOOTM_OPENRTOS=y
> +CONFIG_BOOTM_OSE=y
> +CONFIG_CMD_ADTIMG=y
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_CLK=y
> +# CONFIG_CMD_LOADB is not set
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_BKOPS_ENABLE=y
> +CONFIG_CMD_MMC_REG=y
> +CONFIG_CMD_MMC_SWRITE=y
> +CONFIG_CMD_SDRAM=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_OF_UPSTREAM=y
> +# CONFIG_NET is not set
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_GPIO=y
> +CONFIG_SPL_SYS_I2C_LEGACY=y
> +CONFIG_SYS_I2C_MVTWSI=y
> +CONFIG_SYS_I2C_SLAVE=0x7f
> +CONFIG_SYS_I2C_SPEED=400000
> +CONFIG_REGULATOR_AXP=y
> +CONFIG_AXP717_POWER=y
> +CONFIG_AXP_DCDC2_VOLT=940
> +CONFIG_AXP_DCDC3_VOLT=1100
> +CONFIG_REGEX=y
> +# CONFIG_EFI_LOADER is not set

