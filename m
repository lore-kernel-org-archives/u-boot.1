Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF47C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A26C86435;
	Wed, 23 Aug 2023 22:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B943C86432; Wed, 23 Aug 2023 22:38:44 +0200 (CEST)
Received: from fx.arvanta.net (unknown [109.72.52.77])
 by phobos.denx.de (Postfix) with ESMTP id DC84A86456
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 22:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1 (ab.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id 4E19874DE;
 Wed, 23 Aug 2023 22:38:40 +0200 (CEST)
Date: Wed, 23 Aug 2023 22:38:38 +0200
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: xypron.glpk@gmx.de, chanho61.park@samsung.com, ycliang@andestech.com,
 yanhong.wang@starfivetech.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/2] configs: starfive: Enable PCIE auto enum and
 NVME/USB stuff for Starfive Visionfive 2
Message-ID: <20230823203838.GA21828@m1>
References: <20230822143357.2818-1-wiagn233@outlook.com>
 <TY3P286MB2611C9AD6E5BB3756A959E89981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY3P286MB2611C9AD6E5BB3756A959E89981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
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

On Tue, 2023-08-22 at 22:33, Shengyu Qu wrote:
> Although PCIE driver already exists, board defconfig isn't configured to
> enable PCIE enum on boot, thus USB storage device and NVME drive are not
> supported by default. So modify defconfig to enable PCIE auto enum, then
> start USB subsystem and scan nvme drive on boot.
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Tested-by: Milan P. Stanić <mps@arvanta.net>

> ---
>  configs/starfive_visionfive2_defconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
> index e9b63e5b84..3002c96f0e 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -30,6 +30,7 @@ CONFIG_SPL_SPI=y
>  CONFIG_SYS_LOAD_ADDR=0x82000000
>  CONFIG_SYS_PCI_64BIT=y
>  CONFIG_PCI=y
> +CONFIG_PCI_INIT_R=y
>  CONFIG_TARGET_STARFIVE_VISIONFIVE2=y
>  CONFIG_SPL_OPENSBI_LOAD_ADDR=0x40000000
>  CONFIG_ARCH_RV64I=y
> @@ -43,7 +44,7 @@ CONFIG_SD_BOOT=y
>  CONFIG_USE_BOOTARGS=y
>  CONFIG_BOOTARGS="console=ttyS0,115200 debug rootwait earlycon=sbi"
>  CONFIG_USE_PREBOOT=y
> -CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr};fdt addr ${fdtcontroladdr};"
> +CONFIG_PREBOOT="nvme scan; usb start; setenv fdt_addr ${fdtcontroladdr}; fdt addr ${fdtcontroladdr};"
>  CONFIG_DEFAULT_FDT_FILE="starfive/jh7110-starfive-visionfive-2.dtb"
>  CONFIG_DISPLAY_CPUINFO=y
>  CONFIG_DISPLAY_BOARDINFO=y
> @@ -124,4 +125,9 @@ CONFIG_TIMER_EARLY=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_PCI=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_PCI=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_PCI=y
> +CONFIG_USB_STORAGE=y
>  CONFIG_USB_KEYBOARD=y
> -- 
> 2.42.0
> 
