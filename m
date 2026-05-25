Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015D1CD5BC0
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 06:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 693EF8405A;
	Mon, 25 May 2026 08:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kH5JZ2ty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F8288465D; Mon, 25 May 2026 08:27:25 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF1F8404D
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=46ba=DW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779690441;
 bh=2wq3A3S8WMZHZ6G46J4cg6i8bW1bu4D22WTAYd5bD1k=;
 b=kH5JZ2tytB8mme11FVGC4mSGsjZc2mQ//tkL3MdrjZmRZiJan9howagyQusDsM4hCwb6M3nqo
 xW0p+BAcsn0fde71I8jFSkskqgSnsGlvjnj5FqxH7q7r1RI01PHohaOUhT23qBgDko84ArcJrXv
 fgMDdF6gVE9bZowO2MBsjgNBHqXErk3YRdQpiRmLms4LLK2h6Zndg601sqahMwJTiBh2TdrnwfO
 owVqbh9EQr8n6zmcvVgQkAGaFg3RzE8a1ST8DkuhbuDzNqKiGZ9a+q0YqtkQIvMMfH46Jew2t9v
 McPkB7NnNPS1523CE8QCXERH4DomAYcXxnK6mVesQbIw==
X-Forward-Email-ID: 6a13ebc4a6231d5a56f50b0c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <32dd997a-38c1-4f36-9b90-9d27fb592db4@kwiboo.se>
Date: Mon, 25 May 2026 08:27:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/14] arm: rockchip: rk3576: BLOB-free TPL DRAM
 init
To: Johan Axelsson <johan.axelsson@proton.me>
Cc: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu
References: <20260525012824.121-1-johan.axelsson@proton.me>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Johan,

On 5/25/2026 3:28 AM, Johan Axelsson wrote:
> This series adds an open-source TPL DRAM initialisation driver for the
> Rockchip RK3576 SoC, replacing the proprietary DDR binary blob.
> 
> Hardware
> --------
> The RK3576 DDR subsystem consists of two independent channels, each
> containing one Synopsys uMCTL2 DDRCTL and one Synopsys LPDDR4/4X/5
> combo PHY.  Supported DRAM types: LPDDR4, LPDDR4X, LPDDR5.
> 
> The driver follows the TRM §7.6.2 (LPDDR4, 37 steps) and §7.6.3
> (LPDDR5, 42 steps) software initialisation procedures.
> 
> PHY training
> ------------
> The RK3576 combo PHY includes a hardware training engine controlled by
> SCHD_TRAIN_CON0[0] (phy_train_en) and SCHD_TRAIN_CON0[1]
> (phy_train_done).  No Synopsys PHY training firmware (.bin) is required.
> This was confirmed from the TRM and matches the approach used on RK3568.
> 
> Timing tables
> -------------
> Precalculated timing tables are provided as .inc files, one per DRAM
> type and speed grade.  The values in this RFC are TRM reset defaults
> (placeholders) and are NOT correct for actual hardware operation.
> Correct values require:
>   - JEDEC JESD209-5B (LPDDR5) / JESD209-4D (LPDDR4) timing parameters
>   - Synopsys uMCTL2 SRS field encoding rules
>   - The specific DRAM part number and its datasheet
> 
> Target board
> ------------
> Primary target: Flipper One (rk3576-flipper-one-rev-f0b0c1) with 8 GB
> LPDDR5.  This addresses the open task in
> flipperdevices/flipperone-linux-build-scripts#56.  The Flipper One DTS
> is not yet upstream; a Flipper One defconfig will follow once it lands.
> 
> The series also enables the driver for the ArmSoM Sige5
> (configs/sige5-rk3576_defconfig) as an immediately testable board.
> 
> Series structure
> ----------------
>  01/14  sysreset: guard sysreset_psci.o from XPL builds (prerequisite)
>  02/14  clk: rk3576: OF_PLATDATA support for TPL
>  03/14  clk: rk3576: use CONFIG_XPL_BUILD (fixes TPL size exclusion)
>  04/14  syscon: add DDR GRF region
>  05/14  sdram_common: LPDDR4X and LPDDR5 type support
>  06/14  new: sdram_pctl_rk3576.h — uMCTL2 register layout
>  07/14  new: sdram_rk3576.h     — platform structs and addresses
>  08/14  new: sdram_phy_rk3576.h — combo PHY register layout
>  09/14  new: sdram_rk3576.c     — controller + PHY driver
>  10/14  new: LPDDR4 timing table placeholder (1560 MHz CK)
>  11/14  new: LPDDR5 timing table placeholder (2133 MHz PHY 2x clock)
>  12/14  dts: DMC reg spaces and DDR GRF syscon node
>  13/14  serial: DM_DRIVER_ALIAS for RK3576 UART
>  14/14  Kconfig + defconfig: enable TPL for RK3576
> 
> Known limitations / TODO
> -------------------------
>  - Timing tables contain only TRM reset values.  Hardware bring-up
>    will fail until values are calculated from JEDEC specs + chip data.
>  - LPDDR5 MR1/MR2 encoding (initmr0) not yet calculated.
>  - PHY vref and ODT settings use PHY reset defaults (steps 27-28/31-32).
>  - Flipper One defconfig pending DTS upstream.
>  - Not compile-tested on real hardware yet (cross-compiler required).
> 
> Modelled on the RK3568 RFC series (20260517-rk3568-raminit-v1,
> Pavel Golikov).

Please read and address all of my initial review points on that series,
a few quick notes:
- Keep it simple, only target for TPL, there is no need for complex
  scenarios in an initial implementation
- Only use OF_PLATDATA if you have real size constraint issues
- Clock driver is likely not fully needed in TPL
- Device Tree should not need to have the added information, unless you
  also plan on adding upstream dt-bindings
- Reviewing two similar series will consume time, please await Pavel's
  series if you are going to base this on that series
- Please use pre-existing code and comment style
- You are replacing pre-existing copyright notices

Regards,
Jonas

> Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
> 
> Johan Axelsson (14):
>   sysreset: psci: exclude from XPL builds
>   clk: rockchip: rk3576: add OF_PLATDATA support for TPL
>   clk: rockchip: rk3576: use CONFIG_XPL_BUILD instead of
>     CONFIG_SPL_BUILD
>   arm: rockchip: rk3576: add DDR GRF syscon region
>   ram: rockchip: sdram_common: add LPDDR4X and LPDDR5 support
>   ram: rockchip: add RK3576 DDRCTL register definitions
>   ram: rockchip: add RK3576 DRAM platform header
>   ram: rockchip: add RK3576 DDRPHY register definitions
>   ram: rockchip: rk3576: add DRAM controller and PHY driver
>   ram: rockchip: rk3576: add LPDDR4 timing table placeholder (1560 MHz)
>   ram: rockchip: rk3576: add LPDDR5 timing table placeholder (2133 MHz)
>   arm: dts: rk3576: add DMC reg spaces and DDR GRF syscon node
>   serial: rockchip: add DM_DRIVER_ALIAS for RK3576 UART
>   arm: rockchip: rk3576: enable TPL DRAM init in Kconfig and defconfig
> 
>  arch/arm/dts/rk3576-u-boot.dtsi               |  15 +-
>  arch/arm/include/asm/arch-rockchip/clock.h    |   1 +
>  .../asm/arch-rockchip/sdram_pctl_rk3576.h     | 303 ++++++++
>  .../asm/arch-rockchip/sdram_phy_rk3576.h      | 363 ++++++++++
>  .../include/asm/arch-rockchip/sdram_rk3576.h  | 235 +++++++
>  arch/arm/mach-rockchip/Kconfig                |  11 +
>  arch/arm/mach-rockchip/rk3576/Kconfig         |   3 +
>  arch/arm/mach-rockchip/rk3576/syscon_rk3576.c |   4 +-
>  configs/sige5-rk3576_defconfig                |   3 +
>  drivers/clk/rockchip/clk_rk3576.c             |  24 +-
>  drivers/ram/rockchip/Kconfig                  |   7 +
>  .../sdram-rk3576-lpddr4-detect-1560.inc       | 170 +++++
>  .../sdram-rk3576-lpddr5-detect-2133.inc       | 174 +++++
>  drivers/ram/rockchip/sdram_common.c           |  11 +-
>  drivers/ram/rockchip/sdram_rk3576.c           | 655 +++++++++++++++++-
>  drivers/serial/serial_rockchip.c              |   1 +
>  drivers/sysreset/Makefile                     |   2 +
>  17 files changed, 1963 insertions(+), 19 deletions(-)
>  create mode 100644 arch/arm/include/asm/arch-rockchip/sdram_pctl_rk3576.h
>  create mode 100644 arch/arm/include/asm/arch-rockchip/sdram_phy_rk3576.h
>  create mode 100644 arch/arm/include/asm/arch-rockchip/sdram_rk3576.h
>  create mode 100644 drivers/ram/rockchip/sdram-rk3576-lpddr4-detect-1560.inc
>  create mode 100644 drivers/ram/rockchip/sdram-rk3576-lpddr5-detect-2133.inc
> 

