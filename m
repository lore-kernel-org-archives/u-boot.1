Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A64FCC9A5
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 01:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34BDA83CF3;
	Tue, 10 Mar 2026 02:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DwHjKEzY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B40483F8A; Tue, 10 Mar 2026 02:03:32 +0100 (CET)
Received: from mail-m10239.netease.com (mail-m10239.netease.com
 [154.81.10.239])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEA8E80050
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 02:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [110.83.51.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3652d4ca9;
 Tue, 10 Mar 2026 09:03:24 +0800 (GMT+08:00)
Message-ID: <31bef0c7-cbeb-42f6-8d68-42c44276df36@rock-chips.com>
Date: Tue, 10 Mar 2026 09:03:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] rockchip: Add initial support for RK3506
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de
References: <20260310005326.606079-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260310005326.606079-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cd545255d03afkunmaec6c79d171176e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQhofVkJIGk1LGExDTBhOGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
DKIM-Signature: a=rsa-sha256;
 b=DwHjKEzYRsgbhxKdxdLv7EgZEWlzhG4YFoRy2POu4kZnTmRJ8eiJVmmnSo48uVAO6sBjtBLIhZSLmTLRGilE75xsVG2k/Hnlw1DVjU4M3xr7fa9EMCpbB2Clhy0pNrEoaJTsfZm0UKWC08iHNPom+tTuu5mLvU2sqIVh9LDiT1I=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=m+nqg8Ieci8jFJ+STjocw8laSaaltZKZvroqpLfWdHg=;
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

Hi Jonas,

     This patch set V2 has been landed, please send the fix/new patches 
instead if needed.


Thanks,
- Kever
On 2026/3/10 08:52, Jonas Karlman wrote:
> This series add initial support for the Rockchip RK3506 SoC.
>
> Clk and pinctrl drivers have been imported from vendor U-Boot with
> some adjustments and fixes.
>
> Upstream DT is currently not existing for RK3506, so this series does
> not add support for any new boards, it only add initial arch support.
>
> Please see my U-Boot rk3506 branch at [1] for a few more commits that
> add DTs and defconfig for e.g. Luckfox Lyra variants and ArmSoM Forge1.
>
> With this series, board DTs and defconfigs it should be possible to boot
> into U-Boot proper (without OP-TEE) and still have support for MMC,
> Ethernet, OTP, RNG, LEDs, buttons and USB gadget/host.
>
> Changes in v3:
> - Add parentheses to mod checks to be consistent in clk driver
> - Remove and add blank lines in pinctrl driver
> - Remove unneeded rockchip_get_clk()
> - Remove unneeded syscon_rk3506.c
> - Add BOOTSOURCE_SPINOR mapping
> - Update emmc/sdmmc comment
> - Collect r-b tags
>
> Changes in v2:
> - Use common handling of USB bootsource_id 0x81
> - Re-sort the spl_infos list alphanumerically
> - Drop use of struct rk3506_cru and of_to_plat() ops
> - Define LOG_CATEGORY and use log_debug() in clk driver
> - Extract rk3506_clk_init_xpl() from clk bind() ops
> - Enable SPL_ARMV7_SET_CORTEX_SMPEN
> - Fix mac1 and otg1 access to ddr memory
> - Collect a-b and t-b tags (where applicable)
>
> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3506
>
> Finley Xiao (2):
>    dt-bindings: clock: rockchip: Add RK3506 clock and reset unit
>    clk: rockchip: Add support for RK3506
>
> Jonas Karlman (8):
>    rockchip: spl: Add common handling of USB bootsource_id 0x81
>    rockchip: mkimage: Re-sort the spl_infos list alphanumerically
>    ram: rockchip: Add basic support for RK3506
>    pinctrl: rockchip: Use syscon_regmap_lookup_by_phandle()
>    rockchip: otp: Add support for RK3506
>    phy: rockchip-inno-usb2: Add support for RK3506
>    net: dwc_eth_qos_rockchip: Add support for RK3506
>    arch: arm: rockchip: Add initial support for RK3506
>
> Xuhui Lin (1):
>    rockchip: mkimage: Add support for RK3506
>
> Ye Zhang (1):
>    pinctrl: rockchip: Add support for RK3506
>
>   arch/arm/include/asm/arch-rk3506/boot0.h      |    9 +
>   arch/arm/include/asm/arch-rk3506/gpio.h       |    9 +
>   arch/arm/include/asm/arch-rockchip/clock.h    |   10 +
>   .../include/asm/arch-rockchip/cru_rk3506.h    |  181 +++
>   arch/arm/mach-rockchip/Kconfig                |   44 +
>   arch/arm/mach-rockchip/Makefile               |    1 +
>   arch/arm/mach-rockchip/rk3506/Kconfig         |   15 +
>   arch/arm/mach-rockchip/rk3506/Makefile        |    4 +
>   arch/arm/mach-rockchip/rk3506/clk_rk3506.c    |    9 +
>   arch/arm/mach-rockchip/rk3506/rk3506.c        |  126 ++
>   arch/arm/mach-rockchip/rk3528/rk3528.c        |   15 -
>   arch/arm/mach-rockchip/spl.c                  |   12 +-
>   drivers/clk/rockchip/Makefile                 |    1 +
>   drivers/clk/rockchip/clk_rk3506.c             | 1166 +++++++++++++++++
>   drivers/misc/rockchip-otp.c                   |    4 +
>   drivers/net/dwc_eth_qos.c                     |    4 +
>   drivers/net/dwc_eth_qos_rockchip.c            |   86 ++
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c |   20 +
>   drivers/pinctrl/rockchip/Makefile             |    1 +
>   drivers/pinctrl/rockchip/pinctrl-rk3506.c     |  462 +++++++
>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  |   46 +-
>   drivers/pinctrl/rockchip/pinctrl-rockchip.h   |    1 +
>   drivers/ram/rockchip/Makefile                 |    1 +
>   drivers/ram/rockchip/sdram_rk3506.c           |   33 +
>   drivers/reset/Makefile                        |    2 +-
>   drivers/reset/rst-rk3506.c                    |  222 ++++
>   drivers/usb/gadget/Kconfig                    |    1 +
>   .../Bindings/clock/rockchip,rk3506-cru.yaml   |   55 +
>   .../dt-bindings/clock/rockchip,rk3506-cru.h   |  285 ++++
>   .../dt-bindings/reset/rockchip,rk3506-cru.h   |  211 +++
>   include/configs/rk3506_common.h               |   38 +
>   tools/rkcommon.c                              |    5 +-
>   32 files changed, 3034 insertions(+), 45 deletions(-)
>   create mode 100644 arch/arm/include/asm/arch-rk3506/boot0.h
>   create mode 100644 arch/arm/include/asm/arch-rk3506/gpio.h
>   create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>   create mode 100644 arch/arm/mach-rockchip/rk3506/Kconfig
>   create mode 100644 arch/arm/mach-rockchip/rk3506/Makefile
>   create mode 100644 arch/arm/mach-rockchip/rk3506/clk_rk3506.c
>   create mode 100644 arch/arm/mach-rockchip/rk3506/rk3506.c
>   create mode 100644 drivers/clk/rockchip/clk_rk3506.c
>   create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3506.c
>   create mode 100644 drivers/ram/rockchip/sdram_rk3506.c
>   create mode 100644 drivers/reset/rst-rk3506.c
>   create mode 100644 dts/upstream/Bindings/clock/rockchip,rk3506-cru.yaml
>   create mode 100644 dts/upstream/include/dt-bindings/clock/rockchip,rk3506-cru.h
>   create mode 100644 dts/upstream/include/dt-bindings/reset/rockchip,rk3506-cru.h
>   create mode 100644 include/configs/rk3506_common.h
>
