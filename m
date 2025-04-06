Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626DAC36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 736E582B4A;
	Sun,  6 Apr 2025 17:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IIvUCP79";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E0FC82B53; Sun,  6 Apr 2025 17:10:11 +0200 (CEST)
Received: from mail-m3274.qiye.163.com (mail-m3274.qiye.163.com
 [220.197.32.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B056682B46
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d02055a;
 Sun, 6 Apr 2025 23:09:59 +0800 (GMT+08:00)
Message-ID: <1580874a-e1b8-4c0b-a897-2f672e96b248@rock-chips.com>
Date: Sun, 6 Apr 2025 23:09:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] Support for the RK3576
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
References: <20241121142731.1202209-1-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241121142731.1202209-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEpMVklOGRlLTElPHUtJGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960ba6bf5f03afkunm10d02055a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzI6Mzo5ITJNNUlOMA4wFBAo
 DhwwCTNVSlVKTE9IQk5JSUtLTk9OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFMTkJCNwY+
DKIM-Signature: a=rsa-sha256;
 b=IIvUCP79y1WaGAxVMLeW00yrUN1UJHCnuZJRYDh9vKtLFRAkFbfgvY6X1GmmM9e9p06rOU5sANFiymPHzKuptunxIJOLGSJFz/dVfMTVpWX2YC0jeMAq7xN4/WnCG5PEQWmCuaOMjJKJlROx654gJiyAN1l+3PXZcJJYk6oQHqs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=FknuKRxo3i0oAYUezjll9+tBhRR8PLnhXzJirIG4I4s=;
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

Hi Heiko,

     Do you have new version for this patch set?


Thanks,

- Kever

On 2024/11/21 22:27, Heiko Stuebner wrote:
> This adds support for the RK3576 SoC from Rockchip.
>
> Currently supported (and tested) features are accessing and reading from
> sdhci and sdmmc devices as well as pxe-booting via the network interface.
>
> As can be seen by the DONOTMERGE labels, this needs to wait a bit still.
>
> The core RK3576 devicetrees will be part of 6.13-rc1, but the Firefly
> board I only submitted last week, so this would only appear in 6.14-rc1 .
>
> If someone from Collabora could provide a board patch for the ArmSom
> board they are working with, this would speed things up a bit ;-) .
>
> Checkpatch seems mostly happy too.
>
>
> Detlev Casanova (3):
>    dt-bindings: clock, reset: Add support for rk3576
>    DONOTMERGE: arm64: dts: rockchip: Add rk3576 SoC base DT
>    arm: rockchip: add RK3576-specific syscon ids
>
> Elaine Zhang (2):
>    clk: rockchip: Add rk3576 clk support
>    reset: rockchip: implement rk3576 lookup table
>
> Finley Xiao (1):
>    dt-bindings: power: Add support for RK3576 SoC
>
> Heiko Stuebner (11):
>    dt-bindings: clock, reset: fix top-comment indentation rk3576 headers
>    DONOTMERGE: arm64: dts: rockchip: add rk3576 otp node
>    DONOTMERGE: dt-bindings: arm: rockchip: Add Firefly ROC-RK3576-PC
>      binding
>    DONOTMERGE: arm64: dts: rockchip: Add devicetree for the ROC-RK3576-PC
>    rockchip: sdram: honor CFG_SYS_SDRAM_BASE when defining ram regions
>    ram: rockchip: Add rk3576 ddr driver support
>    rockchip: otp: Add support for RK3576
>    mmc: rockchip_sdhci: Add support for RK3576
>    mmc: rockchip_dw_mmc: Add support for rk3576
>    net: dwc_eth_qos_rockchip: Add support for RK3576
>    rockchip: rk3576: Add support for ROC-RK3576-PC board
>
> Steven Liu (1):
>    pinctrl: rockchip: support rk3576 pinctrl
>
> Xuhui Lin (2):
>    rockchip: mkimage: Add rk3576 support
>    arm: rockchip: Add RK3576 arch core support
>
>   arch/arm/dts/rk3576-roc-pc-u-boot.dtsi        |   12 +
>   arch/arm/dts/rk3576-u-boot.dtsi               |  119 +
>   arch/arm/include/asm/arch-rk3576/boot0.h      |   11 +
>   arch/arm/include/asm/arch-rk3576/gpio.h       |   11 +
>   arch/arm/include/asm/arch-rockchip/clock.h    |   12 +
>   .../include/asm/arch-rockchip/cru_rk3576.h    |  486 ++
>   .../include/asm/arch-rockchip/grf_rk3576.h    |  225 +
>   .../include/asm/arch-rockchip/ioc_rk3576.h    |  244 +
>   arch/arm/mach-rockchip/Kconfig                |   46 +-
>   arch/arm/mach-rockchip/Makefile               |    1 +
>   arch/arm/mach-rockchip/rk3576/Kconfig         |   57 +
>   arch/arm/mach-rockchip/rk3576/Makefile        |    9 +
>   arch/arm/mach-rockchip/rk3576/clk_rk3576.c    |   32 +
>   arch/arm/mach-rockchip/rk3576/rk3576.c        |  169 +
>   arch/arm/mach-rockchip/rk3576/syscon_rk3576.c |   26 +
>   arch/arm/mach-rockchip/sdram.c                |   11 +-
>   board/firefly/roc-pc-rk3576/Kconfig           |   12 +
>   board/firefly/roc-pc-rk3576/MAINTAINERS       |    7 +
>   configs/roc-pc-rk3576_defconfig               |   77 +
>   doc/board/rockchip/rockchip.rst               |   12 +
>   drivers/clk/rockchip/Makefile                 |    1 +
>   drivers/clk/rockchip/clk_rk3576.c             | 2517 +++++++
>   drivers/misc/rockchip-otp.c                   |   11 +
>   drivers/mmc/rockchip_dw_mmc.c                 |    1 +
>   drivers/mmc/rockchip_sdhci.c                  |   12 +
>   drivers/net/dwc_eth_qos.c                     |    4 +
>   drivers/net/dwc_eth_qos_rockchip.c            |  141 +-
>   drivers/pinctrl/rockchip/Makefile             |    1 +
>   drivers/pinctrl/rockchip/pinctrl-rk3576.c     |  287 +
>   drivers/pinctrl/rockchip/pinctrl-rockchip.h   |    3 +
>   drivers/ram/rockchip/Makefile                 |    1 +
>   drivers/ram/rockchip/sdram_rk3576.c           |   65 +
>   drivers/reset/Makefile                        |    2 +-
>   drivers/reset/rst-rk3576.c                    |  647 ++
>   dts/upstream/Bindings/arm/rockchip.yaml       |    5 +
>   .../Bindings/clock/rockchip,rk3576-cru.yaml   |   56 +
>   .../power/rockchip,power-controller.yaml      |    1 +
>   .../dt-bindings/clock/rockchip,rk3576-cru.h   |  592 ++
>   .../dt-bindings/power/rockchip,rk3576-power.h |   30 +
>   .../dt-bindings/reset/rockchip,rk3576-cru.h   |  564 ++
>   .../src/arm64/rockchip/rk3576-pinctrl.dtsi    | 5775 +++++++++++++++++
>   .../src/arm64/rockchip/rk3576-roc-pc.dts      |  736 +++
>   dts/upstream/src/arm64/rockchip/rk3576.dtsi   | 1717 +++++
>   include/configs/rk3576_common.h               |   42 +
>   include/configs/roc-pc-rk3576.h               |   15 +
>   tools/rkcommon.c                              |    1 +
>   46 files changed, 14798 insertions(+), 8 deletions(-)
>   create mode 100644 arch/arm/dts/rk3576-roc-pc-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3576-u-boot.dtsi
>   create mode 100644 arch/arm/include/asm/arch-rk3576/boot0.h
>   create mode 100644 arch/arm/include/asm/arch-rk3576/gpio.h
>   create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rk3576.h
>   create mode 100644 arch/arm/include/asm/arch-rockchip/grf_rk3576.h
>   create mode 100644 arch/arm/include/asm/arch-rockchip/ioc_rk3576.h
>   create mode 100644 arch/arm/mach-rockchip/rk3576/Kconfig
>   create mode 100644 arch/arm/mach-rockchip/rk3576/Makefile
>   create mode 100644 arch/arm/mach-rockchip/rk3576/clk_rk3576.c
>   create mode 100644 arch/arm/mach-rockchip/rk3576/rk3576.c
>   create mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
>   create mode 100644 board/firefly/roc-pc-rk3576/Kconfig
>   create mode 100644 board/firefly/roc-pc-rk3576/MAINTAINERS
>   create mode 100644 configs/roc-pc-rk3576_defconfig
>   create mode 100644 drivers/clk/rockchip/clk_rk3576.c
>   create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3576.c
>   create mode 100644 drivers/ram/rockchip/sdram_rk3576.c
>   create mode 100644 drivers/reset/rst-rk3576.c
>   create mode 100644 dts/upstream/Bindings/clock/rockchip,rk3576-cru.yaml
>   create mode 100644 dts/upstream/include/dt-bindings/clock/rockchip,rk3576-cru.h
>   create mode 100644 dts/upstream/include/dt-bindings/power/rockchip,rk3576-power.h
>   create mode 100644 dts/upstream/include/dt-bindings/reset/rockchip,rk3576-cru.h
>   create mode 100644 dts/upstream/src/arm64/rockchip/rk3576-pinctrl.dtsi
>   create mode 100644 dts/upstream/src/arm64/rockchip/rk3576-roc-pc.dts
>   create mode 100644 dts/upstream/src/arm64/rockchip/rk3576.dtsi
>   create mode 100644 include/configs/rk3576_common.h
>   create mode 100644 include/configs/roc-pc-rk3576.h
>
