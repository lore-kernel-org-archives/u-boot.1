Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D063D5A6FC
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 245C689663;
	Tue, 26 Nov 2024 09:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732609598;
	bh=qdR6hgnU2uMbcpg27RxGZufhkbttE+FplHRg1wwt+TI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d1TMPyIj34WGBlEVf8BK0IiKETcGoFse8zK32HbhPorASO1tJ1P+PBWTeHT2U4O+B
	 4P/nz33jC9cd9wWHgu6WLNxUNAPSSoPEt5M1UawlPU1B8ptl0DCU4MjHoovm3gaCC9
	 HVyYC0J7A74Q6PnwPzHB8rcMx+t4TNBPNqc6txNM39Afa4SJ9AKtlLO5o2YhtcmCpp
	 mMsEOp9QqBQ6RtFrxPKyrNUzuB+X3DIhfYS9yWcLuHppVtuQtoxHB3sFsy8rH2nR3Z
	 0PSIXVOA8zjN2//bQGtn+0MLfDPfX1XVswnxW7oiTwv5BOmpySj+veO80lUUjYN6xY
	 P+8dYoOyepYcA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 819B289663; Tue, 26 Nov 2024 09:26:36 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F291888F55
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4XyFzD4W8mz9tMh;
 Tue, 26 Nov 2024 09:26:32 +0100 (CET)
Message-ID: <e26496e0-5a48-4fff-ac19-58d740b3219b@denx.de>
Date: Tue, 26 Nov 2024 09:26:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] arm: mvebu: Disable JFFS2 support for Kirkwood and Armada
 XP boards
To: Tony Dinh <mibodhi@gmail.com>
Cc: Dave Purdy <david.c.purdy@gmail.com>,
 Evgeni Dobrev <evgeni@studio-punkt.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Phil Sutter <phil@nwl.cc>,
 Siddarth Gore <gores@marvell.com>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241118193459.10687-1-mibodhi@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241118193459.10687-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XyFzD4W8mz9tMh
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

On 18.11.24 20:34, Tony Dinh wrote:
> These boards don't use JFFS2 file system for booting so remove it.
> 
> Ref: https://lore.kernel.org/u-boot/20241114233005.GN3600562@bill-the-cat/T/#t
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   configs/dns325_defconfig     | 1 -
>   configs/dockstar_defconfig   | 1 -
>   configs/ds414_defconfig      | 1 -
>   configs/goflexhome_defconfig | 1 -
>   configs/guruplug_defconfig   | 1 -
>   configs/iconnect_defconfig   | 1 -
>   configs/nas220_defconfig     | 3 ---
>   configs/nsa310s_defconfig    | 1 -
>   configs/nsa325_defconfig     | 3 ---
>   configs/pogo_e02_defconfig   | 1 -
>   configs/pogo_v4_defconfig    | 3 ---
>   11 files changed, 17 deletions(-)
> 
> diff --git a/configs/dns325_defconfig b/configs/dns325_defconfig
> index 323e2f5d4c..1ba02e0595 100644
> --- a/configs/dns325_defconfig
> +++ b/configs/dns325_defconfig
> @@ -33,7 +33,6 @@ CONFIG_CMD_MII=y
>   CONFIG_CMD_PING=y
>   CONFIG_CMD_EXT2=y
>   CONFIG_CMD_FAT=y
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:896k(u-boot),128k(u-boot-env),5m(kernel),-(rootfs)"
> diff --git a/configs/dockstar_defconfig b/configs/dockstar_defconfig
> index e35ca165d0..941156750a 100644
> --- a/configs/dockstar_defconfig
> +++ b/configs/dockstar_defconfig
> @@ -33,7 +33,6 @@ CONFIG_CMD_MII=y
>   CONFIG_CMD_PING=y
>   CONFIG_CMD_EXT2=y
>   CONFIG_CMD_FAT=y
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:1m(uboot),-(root)"
> diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
> index 25e5be3ba7..44e9b17682 100644
> --- a/configs/ds414_defconfig
> +++ b/configs/ds414_defconfig
> @@ -49,7 +49,6 @@ CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_TFTPPUT=y
>   CONFIG_CMD_TIME=y
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_CMD_UBI=y
>   CONFIG_ENV_OVERWRITE=y
> diff --git a/configs/goflexhome_defconfig b/configs/goflexhome_defconfig
> index af758fcc43..add4a24a31 100644
> --- a/configs/goflexhome_defconfig
> +++ b/configs/goflexhome_defconfig
> @@ -35,7 +35,6 @@ CONFIG_CMD_PING=y
>   CONFIG_CMD_EXT2=y
>   CONFIG_CMD_EXT4=y
>   CONFIG_CMD_FAT=y
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:1m(uboot),6M(uImage),-(root)"
> diff --git a/configs/guruplug_defconfig b/configs/guruplug_defconfig
> index 0fab4c38e0..540b9184b3 100644
> --- a/configs/guruplug_defconfig
> +++ b/configs/guruplug_defconfig
> @@ -35,7 +35,6 @@ CONFIG_CMD_PING=y
>   CONFIG_CMD_EXT2=y
>   CONFIG_CMD_EXT4=y
>   CONFIG_CMD_FAT=y
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:896K(uboot),128K(uboot_env),-@1M(root)"
> diff --git a/configs/iconnect_defconfig b/configs/iconnect_defconfig
> index 9d195e1cf2..6ee40e380b 100644
> --- a/configs/iconnect_defconfig
> +++ b/configs/iconnect_defconfig
> @@ -35,7 +35,6 @@ CONFIG_CMD_MII=y
>   CONFIG_CMD_PING=y
>   CONFIG_CMD_EXT2=y
>   CONFIG_CMD_FAT=y
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:0x80000@0x0(uboot),0x20000@0x80000(uboot_env),-@0xa0000(rootfs)"
> diff --git a/configs/nas220_defconfig b/configs/nas220_defconfig
> index 783879d4ee..ca70ee9637 100644
> --- a/configs/nas220_defconfig
> +++ b/configs/nas220_defconfig
> @@ -34,7 +34,6 @@ CONFIG_CMD_PING=y
>   CONFIG_CMD_EXT2=y
>   CONFIG_CMD_EXT4=y
>   CONFIG_CMD_FAT=y
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:0xa0000@0x0(uboot),0x010000@0xa0000(env),0x500000@0xc0000(uimage),0x1a40000@0x5c0000(rootfs)"
> @@ -66,5 +65,3 @@ CONFIG_SYS_NS16550_REG_SIZE=-4
>   CONFIG_USB=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_STORAGE=y
> -CONFIG_JFFS2_LZO=y
> -CONFIG_JFFS2_NAND=y
> diff --git a/configs/nsa310s_defconfig b/configs/nsa310s_defconfig
> index f6718350d5..9a42c39155 100644
> --- a/configs/nsa310s_defconfig
> +++ b/configs/nsa310s_defconfig
> @@ -30,7 +30,6 @@ CONFIG_CMD_NAND=y
>   CONFIG_CMD_SATA=y
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:0xe0000@0x0(uboot),0x20000@0xe0000(uboot_env),0x100000@0x100000(second_stage_uboot),-@0x200000(root)"
> diff --git a/configs/nsa325_defconfig b/configs/nsa325_defconfig
> index c4235eecfb..ab9316340d 100644
> --- a/configs/nsa325_defconfig
> +++ b/configs/nsa325_defconfig
> @@ -42,7 +42,6 @@ CONFIG_CMD_USB=y
>   CONFIG_CMD_SNTP=y
>   CONFIG_CMD_DNS=y
>   # CONFIG_CMD_BLOCK_CACHE is not set
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:0x100000(uboot),0x80000(stock_uboot_env),0x80000(key_store),0x80000(info),0xA00000(etc),0xA00000(kernel_1),0x2FC0000(rootfs1),0xA00000(kernel_2),0x2FC0000(rootfs2)"
> @@ -73,6 +72,4 @@ CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_XHCI_PCI=y
>   CONFIG_USB_EHCI_HCD=y
> -CONFIG_JFFS2_LZO=y
> -CONFIG_JFFS2_NAND=y
>   CONFIG_UBIFS_SILENCE_MSG=y
> diff --git a/configs/pogo_e02_defconfig b/configs/pogo_e02_defconfig
> index 50103f375a..50c9292550 100644
> --- a/configs/pogo_e02_defconfig
> +++ b/configs/pogo_e02_defconfig
> @@ -32,7 +32,6 @@ CONFIG_CMD_MII=y
>   CONFIG_CMD_PING=y
>   CONFIG_CMD_EXT2=y
>   CONFIG_CMD_FAT=y
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:1M(u-boot),4M(uImage),32M(rootfs),-(data)"
> diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
> index fb8036a75e..03b4fd9b2f 100644
> --- a/configs/pogo_v4_defconfig
> +++ b/configs/pogo_v4_defconfig
> @@ -41,7 +41,6 @@ CONFIG_CMD_USB=y
>   CONFIG_CMD_SNTP=y
>   CONFIG_CMD_DNS=y
>   # CONFIG_CMD_BLOCK_CACHE is not set
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:2M(u-boot),3M(uImage),3M(uImage2),8M(failsafe),112M(root)"
> @@ -73,6 +72,4 @@ CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_XHCI_PCI=y
>   CONFIG_USB_EHCI_HCD=y
> -CONFIG_JFFS2_LZO=y
> -CONFIG_JFFS2_NAND=y
>   CONFIG_UBIFS_SILENCE_MSG=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

