Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48D8C48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 09:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1FE8878A1;
	Sat, 17 Feb 2024 10:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="s0OoL4fp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C07E879F0; Sat, 17 Feb 2024 10:23:37 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B8986DBD
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 10:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4c2a=J2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1708161799;
 bh=lcq6QdgnFeU7F3L8jIWJa6o7XYLKcVkC3ew590G5uBQ=;
 b=s0OoL4fpHbRg0imUoc7VZ7feNHtNqsAEPZZe5/e7FERUWr5tL18FaYuPfaB0To7C5kiXDlNjK
 2schccUPRdlOrj96NEUvC/qBmGGJ7bACNVtB8ihxKAMkH5F0S0qREimJIhvqPmVfMWRueITB3Ka
 qV191A+BVf7KukrBMF5Te5S3Vz8wj3CvGMEWoRj+It4flYz8NSWtIyMMekVAr2oyXJFYQSWufto
 s5Z0hMy0+M+VmwQTXZy5Srdxoc5EqDG1WrBrQskaW5KIOmbfWvpZfjV5+EPVtU1ViyJHKKLPQCH
 33AOxvAv61QF/G5SjQ8w1qsL9LvUOYx07pjtfWhhRvyg==
Message-ID: <513ed287-3fe1-4c66-8413-b5d9a40d3b78@kwiboo.se>
Date: Sat, 17 Feb 2024 10:23:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] rockchip: rk3328: Update defconfigs, DTs and
 enable boot from SPI
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de
References: <20240217002304.2141064-1-jonas@kwiboo.se>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240217002304.2141064-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65d07b0709594ddb01a58b8a
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

On 2024-02-17 01:22, Jonas Karlman wrote:
> This series contains miscellaneous updates to defconfigs, syncs latest
> device trees from linux, fixes an issue loading FIT from SD-card when
> running SPL from eMMC and enables building a bootable SPI image on
> RK3328 boards.
> 
> I am also adding myself as a reviewer for the three RK3328 boards I own.
> 
> Patch 1-7 updates boards to enable similar Kconfig options and use a
> common order for from where to try and load FIT.
> 
> Patch 8 fix loading FIT from SD-card when booting from eMMC by using
> pinctrl for emmc and sdmmc in SPL.
> 
> Patch 9-10 makes rockchip gpio and rng driver compatible with linux.
> 
> Patch 11 sync latest rk3328 device tree files from linux v6.8-rc1.
> 
> Patch 12 reverts an old commit that added duplicated code.
> 
> Patch 13-15 enables building u-boot-rockchip-spi.bin for boards with
> SPI flash.
> 
> Changes in v2:
> - Remove unused SPL drivers, I2C and PMIC
> - Add helpful CMD_GPIO and CMD_REGULATOR to boards
> - Add missing UART2 pinctrl nodes to soc u-boot.dtsi
> - Mark the pinctrl node to be included in U-Boot proper pre-reloc phase
> - Add SD-card IO-voltage related nodes to nanopi-r2 u-boot.dtsi
> - Fix an ethernet issue on orangepi-r1-plus-lts
> - Include SPI flash pinctrl nodes in SPL
> - Collect r-b tags

Forgot to mention that following has been tested with this series:
- Loading TPL/SPL and FIT from a combo of different sources, e.g. SPL in
  eMMC and FIT in SD-card or SPL in SD-card and FIT in eMMC etc.
- USB host e.g. usb start; usb tree; usb stop;
- Ethernet e.g. mdio list; mii info; net list; dhcp;
- No pinctrl issue is reported with CONFIG_LOGLEVEL=7, i.e. no print of
  "pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19"
- GPIO and regulator status using gpio status; regulator status;
- Manually inspect TPL and SPL device tree
  $ dtc -I dtb -O dts tpl/u-boot-tpl.dtb
  $ dtc -I dtb -O dts spl/u-boot-spl.dtb

On the following devices:
- Rock64 v2.0 and v3.0
- ROC-RK3328-CC v1.0 and v1.3
- ROCK Pi E v1.21
- Orange Pi R1 Plus LTS

Following devices have _not_ been tested:
- NanoPi R2C/R2C Plus/R2S
- Orange Pi R1 Plus

A USB host issue was discovered on Orange Pi R1 Plus LTS during testing
and I expect NanoPi R2* boards also have the same issue. A fix for this
will be sent separately. The issue relates to fdt address translation of
reg prop in usbdrd3 node.

Regards,
Jonas

> 
> This series depends on the "rockchip: Update stack and bss addresses on
> RK3328 and RK3399" series at [1] being applied _after_ this series.
> Some boards may go over the simple malloc limit without that series also
> applied.
> 
> See [2] for a branch with the dependent series applied.
> 
> [1] https://patchwork.ozlabs.org/cover/1887729/
> [2] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3328-update-v2
> 
> Jonas Karlman (15):
>   rockchip: rk3328: Update default u-boot,spl-boot-order prop
>   rockchip: rk3328-evb: Update defconfig
>   rockchip: rk3328-rock64: Update defconfig
>   rockchip: rk3328-roc-cc: Update defconfig
>   rockchip: rk3328-rock-pi-e: Update defconfig
>   rockchip: rk3328-nanopi-r2: Update defconfig
>   rockchip: rk3328-orangepi-r1-plus: Update defconfig
>   rockchip: rk3328: Fix loading FIT from SD-card when booting from eMMC
>   gpio: rockchip: Use gpio alias id as gpio bank id
>   rng: rockchip: Use same compatible as linux
>   rockchip: rk3328: Sync device tree from linux v6.8-rc1
>   Revert "rockchip: Allow booting from SPI"
>   rockchip: rk3328: Add support to build bootable SPI image
>   rockchip: rk3328-rock64: Enable boot from SPI NOR flash
>   rockchip: rk3328-orangepi-r1-plus: Enable boot from SPI NOR flash
> 
>  arch/arm/dts/rk3328-evb-u-boot.dtsi           |   4 +
>  arch/arm/dts/rk3328-evb.dts                   |   1 +
>  .../dts/rk3328-nanopi-r2c-plus-u-boot.dtsi    |   6 -
>  arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi    |  24 +---
>  arch/arm/dts/rk3328-nanopi-r2s.dts            |   3 +-
>  .../rk3328-orangepi-r1-plus-lts-u-boot.dtsi   |  32 ++----
>  arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts  |   4 +-
>  .../dts/rk3328-orangepi-r1-plus-u-boot.dtsi   |  32 ++----
>  arch/arm/dts/rk3328-orangepi-r1-plus.dts      |   1 +
>  arch/arm/dts/rk3328-roc-cc-u-boot.dtsi        |  22 +---
>  arch/arm/dts/rk3328-roc-cc.dts                |   3 +-
>  arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi     |  17 ---
>  arch/arm/dts/rk3328-rock-pi-e.dts             |  55 +++++++++
>  arch/arm/dts/rk3328-rock64-u-boot.dtsi        |  28 ++---
>  arch/arm/dts/rk3328-rock64.dts                |   1 +
>  arch/arm/dts/rk3328-u-boot.dtsi               | 108 +++++++++++++++---
>  arch/arm/dts/rk3328.dtsi                      |  64 ++++++++---
>  arch/arm/dts/rk3399-u-boot.dtsi               |   2 +-
>  arch/arm/mach-rockchip/rk3328/rk3328.c        |   1 +
>  arch/arm/mach-rockchip/spl-boot-order.c       |   3 -
>  board/rockchip/evb_rk3328/MAINTAINERS         |  11 ++
>  board/rockchip/evb_rk3328/README              |  70 ------------
>  configs/evb-rk3328_defconfig                  |  22 +++-
>  configs/nanopi-r2c-plus-rk3328_defconfig      |  20 +++-
>  configs/nanopi-r2c-rk3328_defconfig           |  20 +++-
>  configs/nanopi-r2s-rk3328_defconfig           |  20 +++-
>  configs/orangepi-r1-plus-lts-rk3328_defconfig |  29 ++++-
>  configs/orangepi-r1-plus-rk3328_defconfig     |  29 ++++-
>  configs/roc-cc-rk3328_defconfig               |  15 ++-
>  configs/rock-pi-e-rk3328_defconfig            |  17 +--
>  configs/rock64-rk3328_defconfig               |  23 +++-
>  doc/board/rockchip/rockchip.rst               |   9 +-
>  drivers/gpio/rk_gpio.c                        |   7 +-
>  drivers/rng/rockchip_rng.c                    |  10 +-
>  34 files changed, 432 insertions(+), 281 deletions(-)
>  delete mode 100644 board/rockchip/evb_rk3328/README
> 

