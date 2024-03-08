Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A91CC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 10:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D4C88084;
	Fri,  8 Mar 2024 11:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="S6FE8S7l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C1188084; Fri,  8 Mar 2024 11:08:57 +0100 (CET)
Received: from mail-m127228.xmail.ntesmail.com
 (mail-m127228.xmail.ntesmail.com [115.236.127.228])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F11C186564
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 11:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=S6FE8S7l2/7jE058W76fS6JftNLXPYRLl4B0FQ+UMoXZwJfHy28DniYDVBHC35ljos3qUdmBEPIejAAgw06c19FEXcMTp+mou/6cY0WGVxt4I5pNxT2SYVjAmJa9DuSwU1lKppL7fBnBsgNazJV+0v1jwJYsaZ2nP9rocX+IAhU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=z5O+/cQuMFLTGp4IPH3LvKj9KwjrhPpokyCqIKmcSsI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 613C6900105;
 Fri,  8 Mar 2024 18:08:45 +0800 (CST)
Message-ID: <6be8ddc3-184c-4d91-8076-caff001065a3@rock-chips.com>
Date: Fri, 8 Mar 2024 18:08:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/20] rockchip: rk3399-puma: migrate README to
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
 <20240221-jaguar-v3-18-1f256a82201b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240221-jaguar-v3-18-1f256a82201b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5DQlYdTBkYGB5KGENIHk9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e1d8964b903a9kunm613c6900105
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mjo6SCo5MDMSSz4PHwwJNz0u
 HxUaFE5VSlVKTEtCQ0JJTklMTEtCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSUlPSDcG
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
> board/theobroma-systems/puma_rk3399 to doc/board/theobroma-systems and
> while doing so, update the instructions and rewrite it in rST.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/theobroma-systems/puma_rk3399/MAINTAINERS |   1 +
>   board/theobroma-systems/puma_rk3399/README      |  90 +----------------
>   doc/board/theobroma-systems/index.rst           |   1 +
>   doc/board/theobroma-systems/puma_rk3399.rst     | 126 ++++++++++++++++++++++++
>   4 files changed, 129 insertions(+), 89 deletions(-)
>
> diff --git a/board/theobroma-systems/puma_rk3399/MAINTAINERS b/board/theobroma-systems/puma_rk3399/MAINTAINERS
> index 23701b3f0ed..7e84a5be262 100644
> --- a/board/theobroma-systems/puma_rk3399/MAINTAINERS
> +++ b/board/theobroma-systems/puma_rk3399/MAINTAINERS
> @@ -4,6 +4,7 @@ M:	Klaus Goger <klaus.goger@theobroma-systems.com>
>   S:	Maintained
>   F:	board/theobroma-systems/puma_rk3399
>   F:	board/theobroma-systems/common
> +F:	doc/board/theobroma-systems
>   F:	include/configs/puma_rk3399.h
>   F:	arch/arm/dts/rk3399-puma*
>   F:	configs/puma-rk3399_defconfig
> diff --git a/board/theobroma-systems/puma_rk3399/README b/board/theobroma-systems/puma_rk3399/README
> index 649aa3c543d..39c9d618866 100644
> --- a/board/theobroma-systems/puma_rk3399/README
> +++ b/board/theobroma-systems/puma_rk3399/README
> @@ -1,89 +1 @@
> -Introduction
> -============
> -
> -The RK3399-Q7 (Puma) is a system-on-module featuring the Rockchip
> -RK3399 in a Qseven-compatible form-factor.
> -
> -RK3399-Q7 features:
> -	* CPU: ARMv8 64bit Big-Little architecture,
> -		* Big: dual-core Cortex-A72
> -		* Little: quad-core Cortex-A53
> -		* IRAM: 200KB
> -	* DRAM: 4GB-128MB dual-channel
> -	* eMMC: onboard eMMC
> -	* SD/MMC
> -	* GbE (onboard Micrel KSZ9031) Gigabit ethernet PHY
> -	* USB:
> -		* USB3.0 dual role port
> -		* 2x USB3.0 host, 1x USB2.0 host via onboard USB3.0 hub
> -	* Display: HDMI/eDP/MIPI
> -	* Camera: 2x CSI (one on the edge connector, one on the Q7 specified CSI ZIF)
> -	* NOR Flash: onboard SPI NOR
> -	* Companion Controller: onboard additional Cortex-M0 microcontroller
> -		* RTC
> -		* fan controller
> -		* CAN
> -
> -Here is the step-by-step to boot to U-Boot on rk3399.
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
> -  > make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3399 bl31
> -  > cp build/rk3399/release/bl31/bl31.elf ../u-boot/bl31.elf
> -
> -Compile the U-Boot
> -==================
> -
> -  > cd ../u-boot
> -  > make CROSS_COMPILE=aarch64-linux-gnu- puma-rk3399_defconfig all
> -
> -Flash the image
> -===============
> -
> -Copy u-boot-rockchip.bin to offset 32k for SD/eMMC.
> -Copy u-boot-rockchip-spi.bin to offset 0 for NOR-flash.
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
> -  > ./tools/boot_merger RKBOOT/RK3399MINIALL.ini
> -  > cd ..
> -  > ./rkdeveloptool db rkbin/rk3399_loader_v1.25.126.bin
> -  > ./rkdeveloptool wl 64 ../u-boot-rockchip.bin
> -
> -NOR-Flash
> ----------
> -
> -rkdeveloptool allows to flash the on-board SPI via the USB OTG interface with
> -help of the Rockchip loader binary.
> -
> -  > git clone https://github.com/rockchip-linux/rkdeveloptool
> -  > cd rkdeveloptool
> -  > autoreconf -i && ./configure && make
> -  > git clone https://github.com/rockchip-linux/rkbin.git
> -  > cd rkbin
> -  > ./tools/boot_merger RKBOOT/RK3399MINIALL_SPINOR.ini
> -  > cd ..
> -  > ./rkdeveloptool db rkbin/rk3399_loader_spinor_v1.25.114.bin
> -  > ./rkdeveloptool ef
> -  > ./rkdeveloptool wl 0 ../u-boot-rockchip-spi.bin
> +See doc/board/theobroma-systems/puma_rk3399.rst.
> diff --git a/doc/board/theobroma-systems/index.rst b/doc/board/theobroma-systems/index.rst
> index 945f7a2f976..0720128ad52 100644
> --- a/doc/board/theobroma-systems/index.rst
> +++ b/doc/board/theobroma-systems/index.rst
> @@ -7,3 +7,4 @@ Theobroma Systems
>      :maxdepth: 2
>   
>      jaguar_rk3588
> +   puma_rk3399
> diff --git a/doc/board/theobroma-systems/puma_rk3399.rst b/doc/board/theobroma-systems/puma_rk3399.rst
> new file mode 100644
> index 00000000000..5bc6385e451
> --- /dev/null
> +++ b/doc/board/theobroma-systems/puma_rk3399.rst
> @@ -0,0 +1,126 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +RK3399-Q7 Puma
> +==============
> +
> +The RK3399-Q7 (Puma) is a system-on-module featuring the Rockchip
> +RK3399 in a Qseven-compatible form-factor.
> +
> +RK3399-Q7 features:
> +
> + * CPU: ARMv8 64bit Big-Little architecture,
> +
> +   * Big: dual-core Cortex-A72
> +   * Little: quad-core Cortex-A53
> +   * IRAM: 200KB
> +   * DRAM: 4GB-128MB dual-channel
> +
> + * eMMC: onboard eMMC
> + * SD/MMC
> + * GbE (onboard Micrel KSZ9031) Gigabit ethernet PHY
> + * USB:
> +
> +   * USB3.0 dual role port
> +   * 2x USB3.0 host, 1x USB2.0 host via onboard USB3.0 hub
> +
> + * Display: HDMI/eDP/MIPI
> + * Camera: 2x CSI (one on the edge connector, one on the Q7 specified CSI ZIF)
> + * NOR Flash: onboard SPI NOR
> + * Companion Controller: onboard additional Cortex-M0 microcontroller
> +   * RTC
> +   * fan controller
> +   * CAN
> +
> +Here is the step-by-step to boot to U-Boot on RK3399-Q7 from Theobroma Systems.
> +
> +Get the Source and build ATF binary
> +-----------------------------------
> +
> +.. prompt:: bash
> +
> +   git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
> +   cd trusted-firmware-a
> +   make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3399 bl31
> +   export BL31=$PWD/build/rk3399/release/bl31/bl31.elf
> +
> +Compile the U-Boot
> +------------------
> +
> +.. prompt:: bash
> +
> +   cd ../u-boot
> +   make CROSS_COMPILE=aarch64-linux-gnu- puma-rk3399_defconfig all
> +
> +This will build ``u-boot-rockchip.bin`` which can be written to an MMC device
> +(eMMC or SD card), and ``u-boot-rockchip-spi.bin`` which can be written to the
> +SPI-NOR flash.
> +
> +Flash the image
> +---------------
> +
> +Copy ``u-boot-rockchip.bin`` to offset 32k for SD/eMMC.
> +Copy ``u-boot-rockchip-spi.bin`` to offset 0 for NOR-flash.
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
> +(check with ``lsusb -d 2207:330c``).
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
> +   ./tools/boot_merger RKBOOT/RK3399MINIALL.ini
> +   cd ..
> +   ./rkdeveloptool db rkbin/rk3399_loader_v1.30.130.bin
> +   ./rkdeveloptool wl 64 ../u-boot-rockchip.bin
> +
> +NOR-Flash
> +~~~~~~~~~
> +
> +``rkdeveloptool`` allows to flash the on-board SPI via the USB OTG interface with
> +help of the Rockchip loader binary.
> +
> +To enter the USB flashing mode on Haikou baseboard, remove any SD card, insert a
> +micro-USB cable in the ``Q7 USB P1`` connector (P8), move ``SW5`` switch into
> +``BIOS Disable`` mode, power cycle or reset the board and move ``SW5`` switch
> +back to ``Normal Boot`` mode. A new USB device should have appeared on your PC
> +(check with ``lsusb -d 2207:330c``).
> +
> +To flash U-Boot on the SPI with ``rkdeveloptool``:
> +
> +.. prompt:: bash
> +
> +   git clone https://github.com/rockchip-linux/rkdeveloptool
> +   cd rkdeveloptool
> +   autoreconf -i && CPPFLAGS=-Wno-format-truncation ./configure && make
> +   git clone https://github.com/rockchip-linux/rkbin.git
> +   cd rkbin
> +   ./tools/boot_merger RKBOOT/RK3399MINIALL_SPINOR.ini
> +   cd ..
> +   ./rkdeveloptool db rkbin/rk3399_loader_spinor_v1.30.114.bin
> +   ./rkdeveloptool ef
> +   ./rkdeveloptool wl 0 ../u-boot-rockchip-spi.bin
>
