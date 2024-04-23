Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BF8C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D9DA8850B;
	Tue, 23 Apr 2024 13:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="erMNxkYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58468852B; Tue, 23 Apr 2024 13:28:00 +0200 (CEST)
Received: from mail-m1973196.qiye.163.com (mail-m1973196.qiye.163.com
 [220.197.31.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65AB288503
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=erMNxkYsktHdYT/0sKCKesulfChM3AYqV5Zj6rR8lu5hS1MW61hrr/mjsG6EkkQba2q2CCP03QtfGyb0jQsyF1A33I0548L4Sd/sZyYcg8R8upwYCIJwvNHSPrONSWELo4nPGU14yhs8iUJFssu0S4+h3q8SeOv/ZD6o3mhBwp0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=DzSssjyLky3Ho4Iaitio1aaz3xMuNGsiKs9mtMAAguc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 6C6F390032D;
 Tue, 23 Apr 2024 19:27:46 +0800 (CST)
Message-ID: <cbd1e26f-8ff1-430b-b7d2-5d07cf01d9d0@rock-chips.com>
Date: Tue, 23 Apr 2024 19:27:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/31] rockchip: rk3399: Sync DT with linux v6.8 and
 update defconfigs
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5JTFZDGUNMTEtNGR0YT0JVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0ab63e0703a9kunm6c6f390032d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Okk6Ayo5NjNKGD00KA09Qh4p
 PQMwCQhVSlVKTEpIQ0xKTU1MSUhKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCTENONwY+
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


On 2024/4/1 04:28, Jonas Karlman wrote:
> This series adds support for new clocks used in linux v6.8 device trees,
> enables use of FIT signature check for checksum validation and fixes
> loading FIT from SD-card when loading FIT from eMMC fails.
>
> After this series it should be possible to move RK3399 boards to use
> OF_UPSTREAM in a future patch once dts/upstream move to a v6.8+ tag.
>
> I have runtime tested this series on following devices:
> - 96boards Rock960
> - Khadas Edge Captain
> - Pine64 PineBook Pro
> - Pine64 RockPro64
> - Radxa ROCK 4C+
> - Radxa ROCK 4SE
> - Radxa ROCK Pi 4A
> - Radxa ROCK Pi 4B+
>
> This series depends on the following series:
> - Enable booting from SPI flash on ROCK Pi 4 [1]
> - rockchip: spl: Cache boot source id for later use [2]

     This patch set not able to apply after this dependent patchset 
update to v2,

please help to send a new version.


Thanks,

- Kever

>
> A copy of this series and all its depends can be found at [3]
>
> [1] https://patchwork.ozlabs.org/cover/1912469/
> [2] https://patchwork.ozlabs.org/cover/1915071/
> [3] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3399-dt-sync-v1
>
> Jonas Karlman (31):
>    rockchip: rk3399-gru: Fix max SPL size on bob and kevin
>    rockchip: rk3399-ficus: Enable TPL and use common bss and stack addr
>    rockchip: rk3399: Sort imply statements alphabetically
>    rockchip: rk3399: Enable ARMv8 crypto and FIT checksum validation
>    rockchip: rk3399: Enable random generator on all boards
>    rockchip: rk3399: Imply support for GbE PHY
>    rockchip: rk3399: Enable DT overlay support on all boards
>    rockchip: rk3399: Remove use of xPL_MISC_DRIVERS options
>    rockchip: rk3399: Add a default spl-boot-order prop
>    rockchip: rk3399: Fix loading FIT from SD-card when booting from eMMC
>    clk: rockchip: rk3399: Rename SCLK_DDRCLK to SCLK_DDRC
>    clk: rockchip: rk3399: Add dummy support for ACLK_VDU clock
>    clk: rockchip: rk3399: Add dummy support for SCLK_PCIEPHY_REF clock
>    clk: rockchip: rk3399: Add SCLK_USB3OTGx_REF support
>    rockchip: rk3399: Sync soc device tree from linux v6.8
>    rockchip: rk3399-gru: Sync device tree from linux v6.8
>    rockchip: rk3399-puma: Sync DT from linux v6.8
>    rockchip: rk3399-rock-pi-n10: Sync device tree from linux v6.8
>    rockchip: rk3399-eaidk-610: Sync device tree from linux v6.8
>    rockchip: rk3399-leez: Sync device tree from linux v6.8
>    rockchip: rk3399-evb: Sync device tree from linux v6.8
>    rockchip: rk3399-firefly: Sync device tree from linux v6.8
>    rockchip: rk3399-orangepi: Sync device tree from linux v6.8
>    rockchip: rk3399-roc-pc: Sync device tree from linux v6.8
>    rockchip: rk3399-nanopi-4: Sync device tree from linux v6.8
>    rockchip: rk3399-rock960: Sync device tree from linux v6.8
>    rockchip: rk3399-khadas: Sync device tree from linux v6.8
>    rockchip: rk3399-rock-pi-4: Sync device tree from linux v6.8
>    rockchip: rk3399-rockpro64: Sync device tree from linux v6.8
>    rockchip: rk3399-pinebook-pro: Sync device tree from linux v6.8
>    rockchip: rk3399-pinephone-pro: Sync device tree from linux v6.8
>
>   arch/arm/dts/rk3288-vmarc-som.dtsi            |  48 +++
>   arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi     |   1 -
>   arch/arm/dts/rk3399-eaidk-610.dts             |   3 +-
>   arch/arm/dts/rk3399-evb-u-boot.dtsi           |  13 +-
>   arch/arm/dts/rk3399-evb.dts                   |   3 +-
>   arch/arm/dts/rk3399-ficus-u-boot.dtsi         |  10 +-
>   arch/arm/dts/rk3399-ficus.dts                 |   4 +
>   arch/arm/dts/rk3399-firefly-u-boot.dtsi       |   6 -
>   arch/arm/dts/rk3399-firefly.dts               |  17 +-
>   arch/arm/dts/rk3399-gru-bob.dts               |   8 +-
>   arch/arm/dts/rk3399-gru-chromebook.dtsi       | 200 +++++++++++-
>   arch/arm/dts/rk3399-gru-kevin.dts             |   3 +-
>   arch/arm/dts/rk3399-gru-u-boot.dtsi           |  34 ++-
>   arch/arm/dts/rk3399-gru.dtsi                  |  52 +++-
>   arch/arm/dts/rk3399-khadas-edge-captain.dts   |   4 +
>   arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi   |   7 +-
>   arch/arm/dts/rk3399-khadas-edge-v.dts         |   4 +
>   arch/arm/dts/rk3399-khadas-edge.dtsi          |  10 +-
>   arch/arm/dts/rk3399-leez-p710-u-boot.dtsi     |   6 -
>   arch/arm/dts/rk3399-leez-p710.dts             |   8 +-
>   arch/arm/dts/rk3399-nanopc-t4.dts             |   2 +-
>   arch/arm/dts/rk3399-nanopi-m4-2gb.dts         |  55 +---
>   arch/arm/dts/rk3399-nanopi-m4b.dts            |   2 +-
>   arch/arm/dts/rk3399-nanopi-r4s.dts            |   4 +-
>   arch/arm/dts/rk3399-nanopi4-u-boot.dtsi       |  18 +-
>   arch/arm/dts/rk3399-nanopi4.dtsi              |   7 +-
>   arch/arm/dts/rk3399-op1-opp.dtsi              |  31 +-
>   arch/arm/dts/rk3399-opp.dtsi                  |   6 +-
>   arch/arm/dts/rk3399-orangepi-u-boot.dtsi      |  12 +
>   arch/arm/dts/rk3399-orangepi.dts              |  12 +-
>   arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi  |  23 +-
>   arch/arm/dts/rk3399-pinebook-pro.dts          |  24 +-
>   arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi |  24 +-
>   arch/arm/dts/rk3399-pinephone-pro.dts         | 147 +++++++++
>   arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi   |  27 +-
>   arch/arm/dts/rk3399-puma-haikou.dts           |  42 ++-
>   arch/arm/dts/rk3399-puma.dtsi                 |  17 +-
>   arch/arm/dts/rk3399-roc-pc-u-boot.dtsi        |  45 +--
>   arch/arm/dts/rk3399-roc-pc.dtsi               |  15 +-
>   arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi  |  20 ++
>   arch/arm/dts/rk3399-rock-4c-plus.dts          |   1 +
>   arch/arm/dts/rk3399-rock-4se-u-boot.dtsi      |  12 +
>   arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi     |   6 -
>   arch/arm/dts/rk3399-rock-pi-4.dtsi            |   4 +-
>   arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi    |   7 +
>   arch/arm/dts/rk3399-rock-pi-4c.dts            |  10 +
>   arch/arm/dts/rk3399-rock960-u-boot.dtsi       |  11 +-
>   arch/arm/dts/rk3399-rock960.dtsi              |   5 +-
>   arch/arm/dts/rk3399-rockpro64-u-boot.dtsi     |  22 +-
>   arch/arm/dts/rk3399-rockpro64.dtsi            |  98 +++++-
>   arch/arm/dts/rk3399-u-boot.dtsi               | 129 +++++---
>   arch/arm/dts/rk3399.dtsi                      | 289 ++++++++++++++++--
>   .../arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi |   6 -
>   arch/arm/dts/rk3399pro-vmarc-som.dtsi         |  20 +-
>   .../dts/rockchip-radxa-dalang-carrier.dtsi    |  21 ++
>   arch/arm/mach-rockchip/Kconfig                |  38 ++-
>   configs/chromebook_bob_defconfig              |   6 +-
>   configs/chromebook_kevin_defconfig            |   6 +-
>   configs/eaidk-610-rk3399_defconfig            |  13 +-
>   configs/evb-rk3399_defconfig                  |  10 +-
>   configs/ficus-rk3399_defconfig                |  38 +--
>   configs/firefly-rk3399_defconfig              |  17 +-
>   configs/khadas-edge-captain-rk3399_defconfig  |  35 ++-
>   configs/khadas-edge-rk3399_defconfig          |  29 +-
>   configs/khadas-edge-v-rk3399_defconfig        |  35 ++-
>   configs/leez-rk3399_defconfig                 |  13 +-
>   configs/nanopc-t4-rk3399_defconfig            |  18 +-
>   configs/nanopi-m4-2gb-rk3399_defconfig        |  22 +-
>   configs/nanopi-m4-rk3399_defconfig            |  22 +-
>   configs/nanopi-m4b-rk3399_defconfig           |  22 +-
>   configs/nanopi-neo4-rk3399_defconfig          |  22 +-
>   configs/nanopi-r4s-rk3399_defconfig           |  16 +-
>   configs/orangepi-rk3399_defconfig             |  14 +-
>   configs/pinebook-pro-rk3399_defconfig         |  13 +-
>   configs/pinephone-pro-rk3399_defconfig        |  13 +-
>   configs/puma-rk3399_defconfig                 |   5 +-
>   configs/roc-pc-mezzanine-rk3399_defconfig     |  15 +-
>   configs/roc-pc-rk3399_defconfig               |  13 +-
>   configs/rock-4c-plus-rk3399_defconfig         |  27 +-
>   configs/rock-4se-rk3399_defconfig             |  28 +-
>   configs/rock-pi-4-rk3399_defconfig            |  13 +-
>   configs/rock-pi-4c-rk3399_defconfig           |  27 +-
>   configs/rock-pi-n10-rk3399pro_defconfig       |  10 +-
>   configs/rock960-rk3399_defconfig              |  18 +-
>   configs/rockpro64-rk3399_defconfig            |  16 +-
>   drivers/clk/rockchip/clk_rk3399.c             |  12 +-
>   include/dt-bindings/clock/rk3399-cru.h        |  30 +-
>   87 files changed, 1700 insertions(+), 531 deletions(-)
>
