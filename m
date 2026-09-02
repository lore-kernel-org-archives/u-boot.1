Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DD4C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 15:29:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7419460726;
	Wed,  2 Sep 2026 15:29:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WvN1hinTBXuC; Wed,  2 Sep 2026 15:29:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788362951;
	bh=zsX7vXqJsFUdg71euiOke1p9/5jlYayqQKa5ULc2WFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y5G7aPyrffiBt7MH6nFi36eALuNe3+IKXLBYqNOGP9VQVnB5fXqS7dMlzrvkhJvYf
	 hqDzyqJsA2sp940zbb4/tEa+kLmz//F69P1lTnewCaw6WTKiR0uJf34efRA+8X3h6e
	 TgEbo/DauTh5Cd1EqxV1qyKoPstnZbuSICcEPVrHeE08DC99Npce983q6q7oBgfzN/
	 lhJq5YqSMf5ZzMBSjYL2JGqRnbIE+OGcA5kUTpKOslk6Z5tHGzfnYcOk+P5dcKQOab
	 iNKqF5HWmG55z8LxmsYqITW2OW2JRA+z8AgTYCdJ1B1kOJPDr8jeey+JVLk8fIHVUW
	 w7lye6Ln3PLNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2F94606B4;
	Wed,  2 Sep 2026 15:29:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C1244498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7675406FA
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:29:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n8ENcZLz2XfQ for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 15:29:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1224=g3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=OeBsqCl/
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F34640794
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1788362943;
 bh=zsX7vXqJsFUdg71euiOke1p9/5jlYayqQKa5ULc2WFU=;
 b=OeBsqCl/zenKpuMrt7SxwaOZlH7f3ezJ8F0BwumxXFmeGBanRDs0hXLmam7rENWiepJZ1xvK5
 tJT+JuYMNmjklt9tWHs+13rbFZ6W1G/gSGLn6D44pUvz7Iy0+h7xjoBg0avr597eB2FuLZn4Zj8
 dtfX3c+wZVpLbfULFEDmXKtrhSkderAEjKDaWj6WgnZ5hTrKebOPq/uOWQw1eGgTOJsPdlcD4qM
 /hDMuU9xt1l3EjhesCP+fnpHdak0z0uqC/+A0sy4GFkE91d1bFsgxM3FOEmyUj0J4Z1YTl/FBpv
 hSfoCAQXRxC41aA6TGmDSoRaCMG0hQF/YHtTKPxigofw==
X-Forward-Email-ID: 6a9840b77cd29b6aebcdafaa
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.14.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3c2bcbaa-689b-42e3-8df1-0caed73c2505@kwiboo.se>
Date: Wed, 2 Sep 2026 17:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: rockchip: add HINLINK H28K
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20260902100101.2001026-1-amadeus@jmu.edu.cn>
 <20260902100101.2001026-2-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260902100101.2001026-2-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Chukun,

On 9/2/2026 12:01 PM, Chukun Pan wrote:
> The HINLINK H28K is a single board computer based on the
> RK3528 SoC. Add support for the HINLINK H28K board.
> 
> Features tested on HINLINK H28K:
> - SD-card boot
> - eMMC boot
> - Ethernet
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi | 11 ++++
>  arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  6 ++
>  configs/hinlink-h28k-rk3528_defconfig        | 64 ++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst              |  1 +
>  4 files changed, 82 insertions(+)
>  create mode 100644 arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi
>  create mode 100644 configs/hinlink-h28k-rk3528_defconfig

[snip]

> diff --git a/configs/hinlink-h28k-rk3528_defconfig b/configs/hinlink-h28k-rk3528_defconfig
> new file mode 100644
> index 000000000000..bcd87bc02381
> --- /dev/null
> +++ b/configs/hinlink-h28k-rk3528_defconfig
> @@ -0,0 +1,64 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-hinlink-h28k"
> +CONFIG_ROCKCHIP_RK3528=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFF9F0000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-hinlink-h28k.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_BOARD_RNG_SEED=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MISC=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y

USB OTG port is not enabled in DT, so CMD_ROCKUSB and CMD_USB_MASS_STORAGE
may not be needed unless there is pending DT updates that will enable
use of USB OTG port.

> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"

clock-names is not included in this lists for new boards, please drop
clock-names form the list of properties to be removed from SPL.

> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_ADC=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y

The combphy seems to be used for PCIe in the DT, maybe we should enable
following Kconfig options:

CONFIG_PCI=y
CONFIG_PCIE_DW_ROCKCHIP=y
CONFIG_CMD_PCI=y

along with correct PCIe Ethernet driver.

> +CONFIG_REGULATOR_PWM=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y

The DWC3 node is not enabled in DT, is this something that will follow
in a future DT update?

> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y

The DWC3 node is not enabled in DT, so USB_XHCI_HCD, USB_DWC3 and 
USB_DWC3_GENERIC may not be needed unless there is pending DT updates
that will enable use of the OTG port.

> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y

Only the USB HOST port is enabled in DT, do we need these USB gadget
related Kconfig options?

Regards,
Jonas

> +CONFIG_ERRNO_STR=y

[snip]
