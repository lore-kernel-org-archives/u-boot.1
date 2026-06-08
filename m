Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D597CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF97883EEF;
	Mon,  8 Jun 2026 15:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hi7m8Nse";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B1C98405A; Mon,  8 Jun 2026 15:28:46 +0200 (CEST)
Received: from mail-m12827.netease.com (mail-m12827.netease.com
 [103.209.128.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D43ED80087
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [59.56.83.5])
 by smtp.qiye.163.com (Hmail) with ESMTP id 41874f15a;
 Mon, 8 Jun 2026 21:28:39 +0800 (GMT+08:00)
Message-ID: <767ba086-99a4-4060-8d99-de0fa3ccf9ea@rock-chips.com>
Date: Mon, 8 Jun 2026 21:28:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] rockchip: rk3576-rock-4d: Enable UFS support
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen
 <chenjh@rock-chips.com>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Dhruva Gole <d-gole@ti.com>, Anshul Dalal <anshuld@ti.com>
References: <20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net>
 <20260311-rk3576-ufs-v6-5-c7c353739242@flipper.net>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260311-rk3576-ufs-v6-5-c7c353739242@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9ea76bc77009cckunm9da3344b34db12
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSkMYVhlDT09MGUpKT0oZGVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlOQlVOTVVDSFVOWVdZFhoPEhUdFFlBWU9LSFVKS0lPT0
 9IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=hi7m8Nse08M1MN7tx3NUSKJuZzG0/YvKb7ribZU+hmtH5/R+Ew64Afx0h5aHeoHZpz45wxlANUJfeCV/J0jIIGyx3MyROqGtrXAdfTCCAE4u+z/7EuPHqsj6Y6WMUvokDtJKRvujOA6lD1K5bIBerjkXezA3uOOxZjLJ5OCw2fI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=2TQZqEINiaAOme5o+ifnQhvdM7TZcC+8Lv3dhvpDAoY=;
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


On 2026/3/11 21:31, Alexey Charkov wrote:
> From: Jonas Karlman <jonas@kwiboo.se>
>
> The Radxa ROCK 4D has a eMMC 5.1 / UFS 2.0 module connector.
>
> Enable UFS related Kconfig options to support booting from UFS storage
> on ROCK 4D.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/rock-4d-rk3576_defconfig | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/configs/rock-4d-rk3576_defconfig b/configs/rock-4d-rk3576_defconfig
> index 140a3e0ccd84..4c0827764d11 100644
> --- a/configs/rock-4d-rk3576_defconfig
> +++ b/configs/rock-4d-rk3576_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
>   CONFIG_SF_DEFAULT_SPEED=50000000
>   CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-rock-4d"
> @@ -19,8 +20,10 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-rock-4d.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_SPL_MAX_SIZE=0x40000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_DM_RESET=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> +CONFIG_SPL_UFS_SUPPORT=y
>   CONFIG_CMD_MEMINFO=y
>   CONFIG_CMD_MEMINFO_MAP=y
>   CONFIG_CMD_ADC=y
> @@ -30,6 +33,7 @@ CONFIG_CMD_I2C=y
>   CONFIG_CMD_MISC=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_PCI=y
> +CONFIG_CMD_UFS=y
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_CMD_RNG=y
> @@ -56,6 +60,7 @@ CONFIG_PHY_ROCKCHIP_USBDP=y
>   CONFIG_DM_PMIC=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SCSI=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> @@ -65,4 +70,6 @@ CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_UFS=y
> +CONFIG_UFS_ROCKCHIP=y
>   CONFIG_ERRNO_STR=y
>
