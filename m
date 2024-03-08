Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA56C54E5C
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 10:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47D1888091;
	Fri,  8 Mar 2024 11:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hucT1TMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A5088092; Fri,  8 Mar 2024 11:09:26 +0100 (CET)
Received: from mail-m15572.qiye.163.com (mail-m15572.qiye.163.com
 [101.71.155.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E329888091
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 11:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=hucT1TMH2ZkppKNg3YTeOVNQ6NgJi5/HQobu0GpOEzhMuH7BnXb8TrfUnOBRzOKDQZ7Y8kJeaLOAjirI7m6MHQLUmoUgamxLE5Cdhk5mBmBYu1bqEpkL0PL7QRssXJzNh7SmzJzzu+FrLPw6tgekwPK8qUIaPow0/4N1V1CIA5g=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=wJdzdZwWN4/LI66DLGCFO6nsOymnLS0IITdE3msyJ7c=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id B45F590035E;
 Fri,  8 Mar 2024 18:09:05 +0800 (CST)
Message-ID: <c4ba6dc4-1def-4266-8f8e-a77c82cc0ac8@rock-chips.com>
Date: Fri, 8 Mar 2024 18:09:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/20] rockchip: ringneck_px30: migrate README to
 doc/board in rST format
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240221-jaguar-v3-0-1f256a82201b@theobroma-systems.com>
 <20240221-jaguar-v3-19-1f256a82201b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240221-jaguar-v3-19-1f256a82201b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh8eGFZDHktNHk0aHhlPTEhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e1d89b32e03a9kunmb45f590035e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORw6PTo4TjMUFj4XDwEfNz4x
 QjpPFDBVSlVKTEtCQ0JJTk9MQktMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS05LSzcG
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


On 2024/2/21 18:37, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> This migrates the plaintext README in
> board/theobroma-systems/ringneck_px30 to doc/board/theobroma-systems and
> while doing so, update the instructions and rewrite it in rST.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/theobroma-systems/ringneck_px30/MAINTAINERS |  1 +
>   board/theobroma-systems/ringneck_px30/README      | 70 +----------------
>   doc/board/theobroma-systems/index.rst             |  1 +
>   doc/board/theobroma-systems/ringneck_px30.rst     | 95 +++++++++++++++++++++++
>   4 files changed, 98 insertions(+), 69 deletions(-)
>
> diff --git a/board/theobroma-systems/ringneck_px30/MAINTAINERS b/board/theobroma-systems/ringneck_px30/MAINTAINERS
> index 06e1beaab14..601830fe45b 100644
> --- a/board/theobroma-systems/ringneck_px30/MAINTAINERS
> +++ b/board/theobroma-systems/ringneck_px30/MAINTAINERS
> @@ -4,6 +4,7 @@ M:	Klaus Goger <klaus.goger@theobroma-systems.com>
>   S:	Maintained
>   F:	board/theobroma-systems/ringneck_px30
>   F:	board/theobroma-systems/common
> +F:	doc/board/theobroma-systems/
>   F:	include/configs/ringneck_px30.h
>   F:	arch/arm/dts/px30-ringneck*
>   F:	configs/ringneck-px30_defconfig
> diff --git a/board/theobroma-systems/ringneck_px30/README b/board/theobroma-systems/ringneck_px30/README
> index e756b3a8ffc..915baf4a9a0 100644
> --- a/board/theobroma-systems/ringneck_px30/README
> +++ b/board/theobroma-systems/ringneck_px30/README
> @@ -1,69 +1 @@
> -Introduction
> -============
> -
> -The PX30-uQ7 (Ringneck) SoM is a µQseven-compatible (40mmx70mm, MXM-230
> -connector) system-on-module from Theobroma Systems[1], featuring the
> -Rockchip PX30.
> -
> -It provides the following feature set:
> -  * up to 4GB DDR4
> -  * up to 128GB on-module eMMC (with 8-bit 1.8V interface)
> -  * SD card (on a baseboard) via edge connector
> -  * Fast Ethernet with on-module TI DP83825I PHY
> -  * MIPI-DSI/LVDS
> -  * MIPI-CSI
> -  * USB
> -    - 1x USB 2.0 dual-role
> -    - 3x USB 2.0 host
> -  * on-module companion controller (STM32 Cortex-M0 or ATtiny), implementing:
> -    - low-power RTC functionality (ISL1208 emulation)
> -    - fan controller (AMC6821 emulation)
> -    - USB<->CAN bridge controller (STM32 only)
> -  * on-module Espressif ESP32 for Bluetooth + 2.4GHz WiFi
> -  * on-module NXP SE05x Secure Element
> -
> -Here is the step-by-step to boot to U-Boot on px30.
> -
> -Get the Source and build ATF binary
> -===================================
> -
> -  > git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
> -
> -Compile the ATF
> -===============
> -
> -  > cd trusted-firmware-a
> -  > make CROSS_COMPILE=aarch64-linux-gnu- PLAT=px30 bl31
> -  > cp build/px30/release/bl31/bl31.elf ../u-boot/bl31.elf
> -
> -Compile the U-Boot
> -==================
> -
> -  > cd ../u-boot
> -  > make CROSS_COMPILE=aarch64-linux-gnu- ringneck-px30_defconfig all
> -
> -Flash the image
> -===============
> -
> -Copy u-boot-rockchip.bin to offset 32k for SD/eMMC.
> -
> -SD-Card
> --------
> -
> -  > dd if=u-boot-rockchip.bin of=/dev/sdb seek=64
> -
> -eMMC
> -----
> -
> -rkdeveloptool allows to flash the on-board eMMC via the USB OTG interface with
> -help of the Rockchip loader binary.
> -
> -  > git clone https://github.com/rockchip-linux/rkdeveloptool
> -  > cd rkdeveloptool
> -  > autoreconf -i && ./configure && make
> -  > git clone https://github.com/rockchip-linux/rkbin.git
> -  > cd rkbin
> -  > ./tools/boot_merger RKBOOT/PX30MINIALL.ini
> -  > cd ..
> -  > ./rkdeveloptool db rkbin/px30_loader_v1.16.131.bin
> -  > ./rkdeveloptool wl 64 ../u-boot-rockchip.bin
> +See doc/board/theobroma-systems/ringneck_px30.rst.
> diff --git a/doc/board/theobroma-systems/index.rst b/doc/board/theobroma-systems/index.rst
> index 0720128ad52..b4da2616c37 100644
> --- a/doc/board/theobroma-systems/index.rst
> +++ b/doc/board/theobroma-systems/index.rst
> @@ -8,3 +8,4 @@ Theobroma Systems
>   
>      jaguar_rk3588
>      puma_rk3399
> +   ringneck_px30
> diff --git a/doc/board/theobroma-systems/ringneck_px30.rst b/doc/board/theobroma-systems/ringneck_px30.rst
> new file mode 100644
> index 00000000000..c16b9ed17ed
> --- /dev/null
> +++ b/doc/board/theobroma-systems/ringneck_px30.rst
> @@ -0,0 +1,95 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +PX30-uQ7 Ringneck
> +=================
> +
> +The PX30-uQ7 (Ringneck) SoM is a µQseven-compatible (40mmx70mm, MXM-230
> +connector) system-on-module from Theobroma Systems, featuring the Rockchip PX30.
> +
> +It provides the following feature set:
> +
> +  * up to 4GB DDR4
> +  * up to 128GB on-module eMMC (with 8-bit 1.8V interface)
> +  * SD card (on a baseboard) via edge connector
> +  * Fast Ethernet with on-module TI DP83825I PHY
> +  * MIPI-DSI/LVDS
> +  * MIPI-CSI
> +  * USB
> +
> +    - 1x USB 2.0 dual-role
> +    - 3x USB 2.0 host
> +
> +  * on-module companion controller (STM32 Cortex-M0 or ATtiny), implementing:
> +
> +    - low-power RTC functionality (ISL1208 emulation)
> +    - fan controller (AMC6821 emulation)
> +    - USB<->CAN bridge controller (STM32 only)
> +
> +  * on-module Espressif ESP32 for Bluetooth + 2.4GHz WiFi
> +  * on-module NXP SE05x Secure Element
> +
> +Here is the step-by-step to boot to U-Boot on PX30-uQ7 Ringneck from Theobroma
> +Systems.
> +
> +Get the Source and build ATF binary
> +-----------------------------------
> +
> +.. prompt:: bash
> +
> +   git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
> +   cd trusted-firmware-a
> +   make CROSS_COMPILE=aarch64-linux-gnu- PLAT=px30 bl31
> +   export BL31=$PWD/build/px30/release/bl31/bl31.elf
> +
> +Compile the U-Boot
> +------------------
> +
> +.. prompt:: bash
> +
> +   cd ../u-boot
> +   make CROSS_COMPILE=aarch64-linux-gnu- ringneck-px30_defconfig all
> +
> +This will build ``u-boot-rockchip.bin`` which can be written to an MMC device
> +(eMMC or SD card).
> +
> +Flash the image
> +---------------
> +
> +Copy ``u-boot-rockchip.bin`` to offset 32k for SD/eMMC.
> +
> +SD-Card
> +~~~~~~~
> +
> +.. prompt:: bash
> +
> +   dd if=u-boot-rockchip.bin of=/dev/sdX seek=64
> +
> +.. note::
> +
> +   Replace ``/dev/sdX`` to match your SD card kernel device.
> +
> +eMMC
> +~~~~
> +
> +``rkdeveloptool`` allows to flash the on-board eMMC via the USB OTG interface
> +with help of the Rockchip loader binary.
> +
> +To enter the USB flashing mode on Haikou baseboard, remove any SD card, insert a
> +micro-USB cable in the ``Q7 USB P1`` connector (P8), move ``SW5`` switch into
> +``BIOS Disable`` mode, power cycle or reset the board and move ``SW5`` switch
> +back to ``Normal Boot`` mode. A new USB device should have appeared on your PC
> +(check with ``lsusb -d 2207:330d``).
> +
> +To flash U-Boot on the eMMC with ``rkdeveloptool``:
> +
> +.. prompt:: bash
> +
> +   git clone https://github.com/rockchip-linux/rkdeveloptool
> +   cd rkdeveloptool
> +   autoreconf -i && CPPFLAGS=-Wno-format-truncation ./configure && make
> +   git clone https://github.com/rockchip-linux/rkbin.git
> +   cd rkbin
> +   ./tools/boot_merger RKBOOT/PX30MINIALL.ini
> +   cd ..
> +   ./rkdeveloptool db rkbin/px30_loader_v2.08.135.bin
> +   ./rkdeveloptool wl 64 ../u-boot-rockchip.bin
>
