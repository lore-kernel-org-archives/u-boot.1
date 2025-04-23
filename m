Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD603C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 548C380944;
	Wed, 23 Apr 2025 16:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Koyq09nY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9065480F9C; Wed, 23 Apr 2025 16:15:19 +0200 (CEST)
Received: from mail-m15578.qiye.163.com (mail-m15578.qiye.163.com
 [101.71.155.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8590803CC
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 16:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12e1fe969;
 Wed, 23 Apr 2025 22:15:09 +0800 (GMT+08:00)
Message-ID: <0655f93c-d3eb-4131-91ff-77dada5e3821@rock-chips.com>
Date: Wed, 23 Apr 2025 22:15:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request: u-boot-rockchip-20250422
To: Jonas Karlman <jonas@kwiboo.se>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20250422162945.26797-1-kever.yang@rock-chips.com>
 <35fcf81a-34d3-41b1-8e73-3243654b4e17@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <35fcf81a-34d3-41b1-8e73-3243654b4e17@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQxodVh5PGkoaThpOQhoZGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NJVUpLS1
 VLWQY+
X-HM-Tid: 0a966300a99603afkunm12e1fe969
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSo6ASo6KjJMHk0NHTEVSyE2
 GhkaFBJVSlVKTE9OT0pMTEpLTUNPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUxMQ0w3Bg++
DKIM-Signature: a=rsa-sha256;
 b=Koyq09nYaPoGyDtroZoyX2L1LvMHuCAa8bH++Ixa4V+XL8+N8mTpl17lru/IpB4SOgyjI21kMqt6meBKCpc9t5HluBPXyaNh2kz6DIucObZD3AARcIr7yAeZl5btfWmy/NbmopnN136JctLDj8SANpwyZJnjYqzZ1m9EiQREEGM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=U4GENGRxGFMOx+SaWDjUR0SAi4/derY6gbARirgzIEE=;
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

On 2025/4/23 01:34, Jonas Karlman wrote:
> Hi Kever,
>
> This is missing "[v2,25/30] rng: rockchip: Add support for rkrng variant"
> from the RK3528 series, should apply after you picked up the rng patches.

Yes, this patch is not able to apply when the first time I applied 
without the rng patches,

and after rng patches picked up, it should able to apply now.

> https://patchwork.ozlabs.org/project/uboot/patch/20250407224743.2423921-26-jonas@kwiboo.se/
>
> Also please drop "rockchip: avoid rebuilding most binaries for
> u-boot-rockchip-spi.bin" and pick up "[v6,0/7] rockchip: binman: Use a
> template for FIT and other improvements" in its place.

I think I applied that patch two weeks ago, and  yes it's better to use 
use your patches instead directly, will do it.


Thanks,

- Kever

> Or should I rebase this series and include an indirect revert (all
> changes in that patch is replaced with use of a fit template).
>
> https://patchwork.ozlabs.org/project/uboot/cover/20250413195949.432730-1-jonas@kwiboo.se/
>
> On 2025-04-22 18:29, Kever Yang wrote:
>> Hi Tom,
>>
>> Please pull the updates for rockchip platform:
>> - New SoC support: RK3528, RK3576
>> - New Board support: rk3528 Radxa E20C, rk3576 Firefly ROC-RK3576-PC;
>> - Add generic board for rk3288 and rk3399;
> Commits for the generic boards are also missing ;-)
>
> Regards,
> Jonas
>
>> - rng driver binding update;
>> - misc updates on board level or header files;
>>
>>
>> CI:
>> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/25886
>>
>> Thanks,
>> - Kever
>>
>>
>> The following changes since commit 185fdf5e94731df05748b1c576effb52ff7a3ec5:
>>
>>    fs/squashfs: avoid illegal free() in sqfs_opendir() (2025-04-21 11:08:03 -0600)
>>
>> are available in the Git repository at:
>>
>>    https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20250422
>>
>> for you to fetch changes up to 30ac31ab1f167f55bb1206e3ec95048b6fc88371:
>>
>>    rng: rockchip_rng: Update compatible for RK3588 (2025-04-22 23:31:02 +0800)
>>
>> ----------------------------------------------------------------
>> Chukun Pan (2):
>>        arm64: dts: rockchip: Add rk3528 QoS register node
>>        arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
>>
>> Elaine Zhang (2):
>>        clk: rockchip: Add rk3576 clk support
>>        reset: rockchip: implement rk3576 lookup table
>>
>> Heiko Stuebner (10):
>>        rockchip: sdram: honor CFG_SYS_SDRAM_BASE when defining ram regions
>>        ram: rockchip: Add rk3576 ddr driver support
>>        rockchip: otp: Add support for RK3576
>>        mmc: rockchip_sdhci: Add support for RK3576
>>        mmc: rockchip_dw_mmc: Add support for rk3576
>>        net: dwc_eth_qos_rockchip: Add support for RK3576
>>        arm64: dts: rockchip: add rk3576 otp node
>>        dt-bindings: arm: rockchip: Add Firefly ROC-RK3576-PC binding
>>        arm64: dts: rockchip: Add devicetree for the ROC-RK3576-PC
>>        rockchip: rk3576: Add support for ROC-RK3576-PC board
>>
>> Jonas Karlman (42):
>>        rockchip: rk3308: Drop unused rk_board_init()
>>        rockchip: Move imply TPL_ROCKCHIP_COMMON_BOARD under SoC Kconfig symbol
>>        rockchip: Make ROCKCHIP_COMMON_STACK_ADDR depend on TPL
>>        rockchip: Improve ARMv7 support for ROCKCHIP_COMMON_STACK_ADDR
>>        rockchip: Move imply ROCKCHIP_COMMON_STACK_ADDR under SoC Kconfig symbol
>>        rockchip: Move imply ROCKCHIP_EXTERNAL_TPL under SoC Kconfig symbol
>>        rockchip: Add RK3576 support for ROCKCHIP_COMMON_STACK_ADDR
>>        rockchip: rk3588: Use hptimer reg names in rockchip_stimer_init
>>        rockchip: Remove partitions env variable for RK356x
>>        rockchip: Remove partitions env variable for RK3588
>>        rockchip: Ensure device settings is defined before rk3568_common.h
>>        rockchip: Ensure device settings is defined before rk3588_common.h
>>        rockchip: Use rk3568_common.h by default for RK356x boards
>>        rockchip: Use rk3588_common.h by default for RK3588 boards
>>        rockchip: rk3568: Drop BOARD_LATE_INIT from target config
>>        rockchip: rk3588: Drop BOARD_LATE_INIT from target config
>>        rockchip: Enable meminfo and rng commands for Generic RK3566/RK3568
>>        rockchip: Enable meminfo and rng commands for Generic RK3588
>>        arm64: dts: rockchip: Add pinctrl and gpio nodes for RK3528
>>        arm64: dts: rockchip: Add SARADC node for RK3528
>>        arm64: dts: rockchip: Add SDHCI controller for RK3528
>>        arm64: dts: rockchip: Add uart0 pinctrl to Radxa E20C
>>        arm64: dts: rockchip: Add leds node to Radxa E20C
>>        arm64: dts: rockchip: Add user button to Radxa E20C
>>        arm64: dts: rockchip: Add maskrom button to Radxa E20C
>>        arm64: dts: rockchip: Enable onboard eMMC on Radxa E20C
>>        ram: rockchip: Add basic support for RK3528
>>        arm: dts: rockchip: Add rk3528-u-boot.dtsi
>>        arch: arm: rockchip: Add initial support for RK3528
>>        mmc: rockchip_sdhci: Extend variant configuration
>>        mmc: rockchip_sdhci: Add initial support for RK3528
>>        mmc: rockchip_sdhci: Gate clock for glitch free phase switching
>>        rockchip: otp: Add support for RK3528
>>        adc: rockchip-saradc: Add support for RK3528
>>        phy: rockchip-inno-usb2: Add support for clkout_ctl_phy
>>        phy: rockchip-inno-usb2: Add support for RK3528
>>        net: dwc_eth_qos_rockchip: Add support for RK3528
>>        board: rockchip: Add minimal generic RK3528 board
>>        board: rockchip: Add Radxa E20C
>>        rng: rockchip_rng: Add compatible for RK3568
>>        rockchip: rk356x: Remove rng node from u-boot.dtsi
>>        rng: rockchip_rng: Update compatible for RK3588
>>
>> Joseph Chen (1):
>>        clk: rockchip: Add support for RK3528
>>
>> Nicolas Frattaroli (1):
>>        arm64: dts: rockchip: Add rng node to RK3588
>>
>> Quentin Schulz (7):
>>        rockchip: theobroma-systems: use HAVE_VENDOR_COMMON_LIB to simplify Makefile
>>        rockchip: px30: enable RNG for all boards
>>        rockchip: px30: add fdtoverlay_addr_r default value to support FDTO
>>        rockchip: ringneck-px30: enable DT overlay support
>>        rockchip: rk3399: do not generate u-boot.rom anymore
>>        rockchip: rk3288: do not generate u-boot.rom anymore
>>        rockchip: avoid rebuilding most binaries for u-boot-rockchip-spi.bin
>>
>> Steven Liu (2):
>>        pinctrl: rockchip: Add support for RK3528
>>        pinctrl: rockchip: support rk3576 pinctrl
>>
>> Xuhui Lin (2):
>>        rockchip: mkimage: Add rk3576 support
>>        arm: rockchip: Add RK3576 arch core support
>>
>> Yao Zi (3):
>>        dt-bindings: clock: Document clock and reset unit of RK3528
>>        arm64: dts: rockchip: Add clock generators for RK3528 SoC
>>        arm64: dts: rockchip: Add UART clocks for RK3528 SoC
>>
>> Yifeng Zhao (1):
>>        rockchip: mkimage: Add support for RK3528
> [snip]
>
>
