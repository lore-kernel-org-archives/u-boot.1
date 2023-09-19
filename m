Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A966CD549D
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BBD886ABC;
	Tue, 19 Sep 2023 09:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GsrZFOLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E32686ABC; Tue, 19 Sep 2023 09:58:23 +0200 (CEST)
Received: from mail-m49206.qiye.163.com (mail-m49206.qiye.163.com
 [45.254.49.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E3986AFA
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GsrZFOLMvaHY/kMiv4ycYn5/uIdaXdWjczrGu6hUep+R1b0oZP8ymovtEV15HaNz0SUVFZghp9RAYm33X+saYWQoqB7cyGCo65OV7NTDeonfZwri01M2gMNkTpND8hzz5jkbR2JBh9yfFiPSVuMp3T7wmickF8JJ3b+f3OvrD4s=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=25sqHkdZhDzp63XyeqbVze9EejI77upySSu9Mw8se5g=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by mail-m12740.qiye.163.com (Hmail) with ESMTPA id 330FD7E07B6;
 Tue, 19 Sep 2023 15:58:09 +0800 (CST)
Message-ID: <d01a561d-a1eb-aa66-7854-e0e960a22e15@rock-chips.com>
Date: Tue, 19 Sep 2023 15:58:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 2/2] doc: rockchip: Update and improve info on rk3308, 
 TPL and TF-A
Content-Language: en-US
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 FUKAUMI Naoki <naoki@radxa.com>, Johan Jonker <jbx6244@gmail.com>
References: <20230909093333.11976-1-massimo.pegorer+oss@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230909093333.11976-1-massimo.pegorer+oss@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSh5KVkJNHkkfSRoaSh5LQlUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8aac725bf8b213kuuu330fd7e07b6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBA6Fxw6ST1CGU9IIjkwSj8v
 MhIwFChVSlVKTUJOSkpLSUJKSUtIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUxLQ0k3Bg++
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


On 2023/9/9 17:33, Massimo Pegorer wrote:
> Update and improve documentation about build steps for SoCs that
> require using TF-A and TPL binaries provided by Rockchip, such as
> rk3308. Add rk3308 boards case to rST document. Add ROCK Pi S in
> the list of supported boards. Minor page format improvements.
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   doc/README.rockchip             | 10 +-------
>   doc/board/rockchip/rockchip.rst | 43 +++++++++++++++++++++++++++------
>   2 files changed, 36 insertions(+), 17 deletions(-)
>
> diff --git a/doc/README.rockchip b/doc/README.rockchip
> index 52b5140eca..84caff8a24 100644
> --- a/doc/README.rockchip
> +++ b/doc/README.rockchip
> @@ -38,16 +38,8 @@ Building
>       (or you can use another cross compiler if you prefer)
>   
>   2. To build RK3308 board:
> -   - Get the rkbin
> -     => git clone https://github.com/rockchip-linux/rkbin.git
>   
> -   - Compile U-Boot
> -     => cd /path/to/u-boot
> -     => export BL31=/path/to/rkbin/bin/rk33/rk3308_bl31_v2.22.elf
> -     => make roc-cc-rk3308_defconfig
> -     => make CROSS_COMPILE=aarch64-linux-gnu- all
> -     => ./tools/mkimage -n rk3308 -T rksd -d /path/to/rkbin/bin/rk33/rk3308_ddr_589MHz_uart2_m0_v1.26.bin idbloader.img
> -     => cat spl/u-boot-spl.bin  >> idbloader.img
> +   See doc/board/rockchip/rockchip.rst
>   
>   3. To build RK3399 board:
>   
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index de9fe8e642..d0fa7a9c8f 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -53,6 +53,7 @@ List of mainline supported Rockchip boards:
>        - Google Speedy (chromebook_speedy)
>        - Amarula Vyasa-RK3288 (vyasa-rk3288)
>   * rk3308
> +     - Radxa ROCK Pi S (rock-pi-s-rk3308)
>        - Rockchip Evb-RK3308 (evb-rk3308)
>        - Roc-cc-RK3308 (roc-cc-rk3308)
>   * rk3326
> @@ -142,6 +143,19 @@ To build TF-A:
>   
>   Specify the PLAT= with desired Rockchip platform to build TF-A for.
>   
> +For SoCs whose TF-A code is not available as open source, use BL31 binary provided by Rockchip:
> +
> +.. code-block:: bash
> +
> +        git clone --depth 1 https://github.com/rockchip-linux/rkbin
> +
> +TPL
> +^^^
> +
> +For some SoCs U-Boot sources lack of support to inizialize DRAM.
> +In these cases, to get a fully functional image following :ref:`PackageWithTPLandSPL`, use DDR binary provided by Rockchip rkbin repository as ROCKCHIP_TPL when building U-Boot.
> +Otherwise, follow :ref:`PackageWithRockchipMiniloader`.
> +
>   U-Boot
>   ^^^^^^
>   
> @@ -172,6 +186,15 @@ To build rk3288 boards:
>           make evb-rk3288_defconfig
>           make CROSS_COMPILE=arm-linux-gnueabihf-
>   
> +To build rk3308 boards:
> +
> +.. code-block:: bash
> +
> +        export BL31=../rkbin/bin/rk33/rk3308_bl31_v2.26.elf
> +        export ROCKCHIP_TPL=../rkbin/bin/rk33/rk3308_ddr_589MHz_uartX_mY_v2.07.bin
> +        make evb-rk3308_defconfig
> +        make CROSS_COMPILE=aarch64-linux-gnu-
> +
>   To build rk3328 boards:
>   
>   .. code-block:: bash
> @@ -218,11 +241,13 @@ To build rk3588 boards:
>   Flashing
>   --------
>   
> +.. _`PackageWithTPLandSPL`:
> +
>   1. Package the image with U-Boot TPL/SPL
> ------------------------------------------
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   
>   SD Card
> -^^^^^^^
> +"""""""
>   
>   All Rockchip platforms (except rk3128 which doesn't use SPL) are now
>   supporting a single boot image using binman.
> @@ -235,7 +260,7 @@ To write an image that boots from a SD card (assumed to be /dev/sda):
>           sync
>   
>   eMMC
> -^^^^
> +""""
>   
>   eMMC flash would probe on mmc0 in most of the Rockchip platforms.
>   
> @@ -274,7 +299,7 @@ For Rockchip 32-bit platforms the U-Boot proper image
>   is u-boot-dtb.img
>   
>   SPI
> -^^^
> +"""
>   
>   Write u-boot-rockchip-spi.bin to offset 0 of SPI flash.
>   
> @@ -286,8 +311,10 @@ Copy u-boot-rockchip-spi.bin into SD card and boot from SD:
>           load mmc 1:1 $kernel_addr_r u-boot-rockchip-spi.bin
>           sf update $fileaddr 0 $filesize
>   
> +.. _`PackageWithRockchipMiniloader`:
> +
>   2. Package the image with Rockchip miniloader
> ----------------------------------------------
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   
>   Image package with Rockchip miniloader requires rkbin [1].
>   
> @@ -327,14 +354,14 @@ Note:
>   2. 0x200000 is a load address and is an option for some platforms.
>   
>   3. Package the RK3066 image with U-Boot TPL/SPL on NAND
> --------------------------------------------------------
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   
>   Unlike later SoC models the rk3066 BootROM doesn't have SDMMC support.
>   If all other boot options fail then it enters into a BootROM mode on the USB OTG port.
>   This method loads TPL/SPL on NAND with U-Boot and kernel on SD card.
>   
>   SD Card
> -^^^^^^^
> +"""""""
>   
>   U-Boot expects a GPT partition map and a boot directory structure with files on the SD card.
>   
> @@ -369,7 +396,7 @@ To write a U-Boot image to the SD card (assumed to be /dev/sda):
>           sync
>   
>   NAND
> -^^^^
> +""""
>   
>   Bring device in BootROM mode:
>   
