Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F79C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 08:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6764487ABE;
	Thu, 18 Jan 2024 09:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="d4jr4Cww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C716987B7C; Thu, 18 Jan 2024 09:32:19 +0100 (CET)
Received: from mail-m12778.qiye.163.com (mail-m12778.qiye.163.com
 [115.236.127.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1FD587835
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 09:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=d4jr4Cww16kw7hTI7DaUjOfWGf/cvieCql9S48roHSBxbg3TjPce0Wg0lwG4UqBRzDFQAj5h3SsiuCiN1nhiYbUbKo3sNcEwioN8+QRu+p2OxFU6yJW5rz0I0SaLL9UakUJtX4/VZr1qouGMB/jQqyXtKbX/HYeywYB/tFvnY5Y=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=aCOt+o2Uw5c8BXs2n+vWUejKryim9YmjlVadaMwTF1U=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 53E9A90053D;
 Thu, 18 Jan 2024 16:30:54 +0800 (CST)
Message-ID: <467b577c-10b2-45cd-9cce-b6526e8af31a@rock-chips.com>
Date: Thu, 18 Jan 2024 16:30:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] configs: rockchip: Use dwc3-generic driver on
 RK3328 and RK3399
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Xiaobo Tian <peterwillcn@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Levin Du
 <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Akash Gajjar <akash@openedev.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
References: <20231112174904.1581187-1-jonas@kwiboo.se>
 <20231112174904.1581187-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231112174904.1581187-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJLSlZPH0MeSEkeS0tCTh1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1bb1d1b72eafkusn53e9a90053d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MSo6Sgw*HjwiCBA3HyMPChID
 AgxPCxZVSlVKTEtOTk1NTU5OT05IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTkpPTDcG
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


On 2023/11/13 01:48, Jonas Karlman wrote:
> Complete the transition away from xhci-dwc3 and dwc3-of-simple drivers
> and change to use the dwc3-generic driver on remaining RK3328 and RK3399
> boards.
>
> MISC, USB_DWC3 and USB_DWC3_GENERIC is enabled on boards that used to
> enable USB_XHCI_DWC3. USB_XHCI_DWC3 is dropped from updated boards along
> with the default y of USB_XHCI_DWC3_OF_SIMPLE.
>
> There is no intended change in functionality with this changes, USB 3.0
> is expected to continue same as before this change.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Update commit message
> - Drop CONFIG_DM_USB_GADGET changes
>
>   configs/chromebook_bob_defconfig              | 2 +-
>   configs/chromebook_kevin_defconfig            | 2 +-
>   configs/eaidk-610-rk3399_defconfig            | 4 +++-
>   configs/evb-rk3399_defconfig                  | 1 -
>   configs/firefly-rk3399_defconfig              | 1 -
>   configs/khadas-edge-captain-rk3399_defconfig  | 4 +++-
>   configs/khadas-edge-rk3399_defconfig          | 4 +++-
>   configs/khadas-edge-v-rk3399_defconfig        | 4 +++-
>   configs/leez-rk3399_defconfig                 | 4 +++-
>   configs/nanopc-t4-rk3399_defconfig            | 3 ++-
>   configs/nanopi-m4-2gb-rk3399_defconfig        | 4 +++-
>   configs/nanopi-m4-rk3399_defconfig            | 4 +++-
>   configs/nanopi-m4b-rk3399_defconfig           | 4 +++-
>   configs/nanopi-neo4-rk3399_defconfig          | 4 +++-
>   configs/nanopi-r4s-rk3399_defconfig           | 3 ++-
>   configs/orangepi-r1-plus-lts-rk3328_defconfig | 3 ++-
>   configs/orangepi-r1-plus-rk3328_defconfig     | 3 ++-
>   configs/orangepi-rk3399_defconfig             | 4 +++-
>   configs/pinebook-pro-rk3399_defconfig         | 1 -
>   configs/pinephone-pro-rk3399_defconfig        | 1 -
>   configs/puma-rk3399_defconfig                 | 1 -
>   configs/roc-pc-mezzanine-rk3399_defconfig     | 1 -
>   configs/roc-pc-rk3399_defconfig               | 1 -
>   configs/rock-4c-plus-rk3399_defconfig         | 1 -
>   configs/rock-4se-rk3399_defconfig             | 1 -
>   configs/rock-pi-4-rk3399_defconfig            | 1 -
>   configs/rock-pi-4c-rk3399_defconfig           | 1 -
>   configs/rock-pi-n10-rk3399pro_defconfig       | 1 -
>   configs/rock960-rk3399_defconfig              | 3 ++-
>   configs/rockpro64-rk3399_defconfig            | 1 -
>   drivers/usb/host/Kconfig                      | 1 -
>   31 files changed, 42 insertions(+), 31 deletions(-)
>
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index 1807e838223a..b5a5ae737e52 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -98,12 +98,12 @@ CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_KEYBOARD=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index 638beee2c6d3..20913d2cf0fe 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -99,12 +99,12 @@ CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_KEYBOARD=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
> diff --git a/configs/eaidk-610-rk3399_defconfig b/configs/eaidk-610-rk3399_defconfig
> index 77edbdbf9597..22ad98b95ad3 100644
> --- a/configs/eaidk-610-rk3399_defconfig
> +++ b/configs/eaidk-610-rk3399_defconfig
> @@ -40,6 +40,7 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -56,8 +57,9 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
> diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
> index 5740ffc38f6c..d6140527b752 100644
> --- a/configs/evb-rk3399_defconfig
> +++ b/configs/evb-rk3399_defconfig
> @@ -66,7 +66,6 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
> index b4660a051dfd..b7c8e95b7b89 100644
> --- a/configs/firefly-rk3399_defconfig
> +++ b/configs/firefly-rk3399_defconfig
> @@ -66,7 +66,6 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khadas-edge-captain-rk3399_defconfig
> index ed06fe7846e6..8b6935d86730 100644
> --- a/configs/khadas-edge-captain-rk3399_defconfig
> +++ b/configs/khadas-edge-captain-rk3399_defconfig
> @@ -43,6 +43,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -61,11 +62,12 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
>   CONFIG_USB_ETHER_ASIX88179=y
> diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-rk3399_defconfig
> index 9df945e6c0fe..070f0ea48c40 100644
> --- a/configs/khadas-edge-rk3399_defconfig
> +++ b/configs/khadas-edge-rk3399_defconfig
> @@ -42,6 +42,7 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -60,11 +61,12 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
>   CONFIG_USB_ETHER_ASIX88179=y
> diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge-v-rk3399_defconfig
> index e216c0e86f7f..5344ecd1f20f 100644
> --- a/configs/khadas-edge-v-rk3399_defconfig
> +++ b/configs/khadas-edge-v-rk3399_defconfig
> @@ -43,6 +43,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -61,11 +62,12 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
>   CONFIG_USB_ETHER_ASIX88179=y
> diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
> index fa936609e9b1..76dd91911c7c 100644
> --- a/configs/leez-rk3399_defconfig
> +++ b/configs/leez-rk3399_defconfig
> @@ -39,6 +39,7 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -56,9 +57,10 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
>   CONFIG_USB_ETHER_ASIX88179=y
> diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
> index 82e86ca07026..c18e7b1bd169 100644
> --- a/configs/nanopc-t4-rk3399_defconfig
> +++ b/configs/nanopc-t4-rk3399_defconfig
> @@ -43,6 +43,7 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -60,10 +61,10 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_KEYBOARD=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
> diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
> index dd715517d5a1..e3bdbccccbec 100644
> --- a/configs/nanopi-m4-2gb-rk3399_defconfig
> +++ b/configs/nanopi-m4-2gb-rk3399_defconfig
> @@ -40,6 +40,7 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -56,9 +57,10 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_KEYBOARD=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
> diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
> index 3da93db06da3..e51e51c8cf5c 100644
> --- a/configs/nanopi-m4-rk3399_defconfig
> +++ b/configs/nanopi-m4-rk3399_defconfig
> @@ -40,6 +40,7 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -56,9 +57,10 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_KEYBOARD=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
> diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
> index 701dde15f3e2..ca57c7f81a51 100644
> --- a/configs/nanopi-m4b-rk3399_defconfig
> +++ b/configs/nanopi-m4b-rk3399_defconfig
> @@ -40,6 +40,7 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -56,9 +57,10 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_KEYBOARD=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
> diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
> index 3f9d0340c81e..02e7f4e2ecb7 100644
> --- a/configs/nanopi-neo4-rk3399_defconfig
> +++ b/configs/nanopi-neo4-rk3399_defconfig
> @@ -40,6 +40,7 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -56,9 +57,10 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_KEYBOARD=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
> diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
> index 4f4363cb0f90..cacaab14d21f 100644
> --- a/configs/nanopi-r4s-rk3399_defconfig
> +++ b/configs/nanopi-r4s-rk3399_defconfig
> @@ -63,9 +63,10 @@ CONFIG_SYSINFO_SMBIOS=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_KEYBOARD=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
> diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> index 0ea45df33338..d3d9417509e9 100644
> --- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> @@ -71,6 +71,7 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
> @@ -99,7 +100,6 @@ CONFIG_SYSRESET=y
>   # CONFIG_TPL_SYSRESET is not set
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
> @@ -107,6 +107,7 @@ CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC2=y
>   CONFIG_USB_DWC3=y
>   # CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_SPL_TINY_MEMSET=y
> diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
> index e3d7f0b8aeb0..9356e87132e7 100644
> --- a/configs/orangepi-r1-plus-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-rk3328_defconfig
> @@ -71,6 +71,7 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
>   CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
> @@ -99,7 +100,6 @@ CONFIG_SYSRESET=y
>   # CONFIG_TPL_SYSRESET is not set
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
> @@ -107,6 +107,7 @@ CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC2=y
>   CONFIG_USB_DWC3=y
>   # CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_SPL_TINY_MEMSET=y
> diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
> index ba6d91e877d6..27add8a29b92 100644
> --- a/configs/orangepi-rk3399_defconfig
> +++ b/configs/orangepi-rk3399_defconfig
> @@ -40,6 +40,7 @@ CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -56,9 +57,10 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
>   CONFIG_USB_ETHER_ASIX88179=y
> diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
> index ae3211bbe9c4..de357415fbe4 100644
> --- a/configs/pinebook-pro-rk3399_defconfig
> +++ b/configs/pinebook-pro-rk3399_defconfig
> @@ -96,7 +96,6 @@ CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
> diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
> index 11243bc5c193..d08224fe536b 100644
> --- a/configs/pinephone-pro-rk3399_defconfig
> +++ b/configs/pinephone-pro-rk3399_defconfig
> @@ -85,7 +85,6 @@ CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index b632fa3dcf34..c2aa02ec74bd 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -97,7 +97,6 @@ CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
> index 06d97c3e1a2d..de6539bedf48 100644
> --- a/configs/roc-pc-mezzanine-rk3399_defconfig
> +++ b/configs/roc-pc-mezzanine-rk3399_defconfig
> @@ -81,7 +81,6 @@ CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
> index c53e8622431e..7123a7a07299 100644
> --- a/configs/roc-pc-rk3399_defconfig
> +++ b/configs/roc-pc-rk3399_defconfig
> @@ -82,7 +82,6 @@ CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
> diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
> index 3028a86705ca..18525c8bf504 100644
> --- a/configs/rock-4c-plus-rk3399_defconfig
> +++ b/configs/rock-4c-plus-rk3399_defconfig
> @@ -74,7 +74,6 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
> index 9abe8bf85354..171de23ec8f6 100644
> --- a/configs/rock-4se-rk3399_defconfig
> +++ b/configs/rock-4se-rk3399_defconfig
> @@ -76,7 +76,6 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
> index 84e0dcf02827..83fc4ad7dabc 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -77,7 +77,6 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
> index 5c9fb14787d8..089344097e0c 100644
> --- a/configs/rock-pi-4c-rk3399_defconfig
> +++ b/configs/rock-pi-4c-rk3399_defconfig
> @@ -74,7 +74,6 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
> index 1978fd525b8f..dc4b3b40380a 100644
> --- a/configs/rock-pi-n10-rk3399pro_defconfig
> +++ b/configs/rock-pi-n10-rk3399pro_defconfig
> @@ -68,7 +68,6 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
> index fee10c471946..f74864b6eb90 100644
> --- a/configs/rock960-rk3399_defconfig
> +++ b/configs/rock960-rk3399_defconfig
> @@ -50,6 +50,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_SYS_MMC_ENV_DEV=1
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> @@ -70,12 +71,12 @@ CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_KEYBOARD=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index 4cd6b76665bd..44171aac06a6 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -93,7 +93,6 @@ CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index b501ea514bca..d92d87af52ef 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -39,7 +39,6 @@ config USB_XHCI_DWC3
>   config USB_XHCI_DWC3_OF_SIMPLE
>   	bool "DesignWare USB3 DRD Generic OF Simple Glue Layer"
>   	depends on DM_USB
> -	default y if ARCH_ROCKCHIP
>   	default y if DRA7XX
>   	help
>   	  Support USB2/3 functionality in simple SoC integrations with
