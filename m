Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B6DE7E0C7
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 11:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E8C283C5E;
	Mon,  9 Feb 2026 12:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53F5983C61; Mon,  9 Feb 2026 12:22:15 +0100 (CET)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 966E98341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 12:22:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 619BLcar048530;
 Mon, 9 Feb 2026 19:21:38 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Feb
 2026 19:21:38 +0800
Date: Mon, 9 Feb 2026 19:21:34 +0800
From: Leo Liang <ycliang@andestech.com>
To: Hal Feng <hal.feng@starfivetech.com>
CC: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Sumit Garg
 <sumit.garg@kernel.org>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 0/9] Add support for StarFive VisionFive 2 Lite board
Message-ID: <aYnDPqVzlesZqy2C@swlinux02>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251024085932.83596-1-hal.feng@starfivetech.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 619BLcar048530
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

On Fri, Oct 24, 2025 at 04:59:23PM +0800, Hal Feng wrote:
> VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S industrial
> SoC which can run at -40~85 degrees centigrade and up to 1.25GHz.
> 
> Board features:
> - JH7110S SoC
> - 4/8 GiB LPDDR4 DRAM
> - AXP15060 PMIC
> - 40 pin GPIO header
> - 1x USB 3.0 host port
> - 3x USB 2.0 host port
> - 1x M.2 M-Key (size: 2242)
> - 1x MicroSD slot (optional non-removable 64GiB eMMC)
> - 1x QSPI Flash
> - 1x I2C EEPROM
> - 1x 1Gbps Ethernet port
> - SDIO-based Wi-Fi & UART-based Bluetooth
> - 1x HDMI port
> - 1x 2-lane DSI
> - 1x 2-lane CSI
> 
> VisionFive 2 Lite schematics: https://doc-en.rvspace.org/VisionFive2Lite/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
> VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/index.html
> More documents: https://doc-en.rvspace.org/Doc_Center/visionfive_2_lite.html
> 
> Note: Patch 1 and 2 are the kernel device tree picked from [1]. They are
> just for test and please ignore them because dts/upstream should be synced
> with devicetree-rebasing.
> 
> [1] https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfivetech.com/
> 
> Changes since RFC:
> - Rebase on the latest mainline.
> - Improve the commit messages.
> - Drop patch 7.
> patch 3, 4:
> - Return 0 instead of 0xFF if read_eeprom() fails.
> patch 5:
> - Keep default FORMAT_VERSION 0x2.
> - Change wifi_bt field to onboard_module field and use bit 0 to mark
>   WIFI/BT.
> - Drop all "no_eth0", "no_eth1" configuration.
> 
> History:
> RFC: https://lore.kernel.org/all/20250829060931.79940-1-hal.feng@starfivetech.com/
> 
> Hal Feng (9):
>   riscv: dts: starfive: jh7110-common: Move out some nodes to the board
>     dts
>   riscv: dts: starfive: Add VisionFive 2 Lite board device tree
>   eeprom: starfive: Simplify get_ddr_size_from_eeprom()
>   eeprom: starfive: Correct get_pcb_revision_from_eeprom()
>   eeprom: starfive: Support eeprom data format v3
>   pcie: starfive: Add a optional power gpio support
>   configs: visionfive2: Add VisionFive 2 Lite DT to OF_LIST
>   board: starfive: spl: Support VisionFive 2 Lite
>   board: starfive: visionfive2: Add VisionFive 2 Lite fdt selection
> 
>  arch/riscv/cpu/jh7110/spl.c                   |   2 +-
>  arch/riscv/include/asm/arch-jh7110/eeprom.h   |  13 +-
>  board/starfive/visionfive2/spl.c              |   3 +
>  .../visionfive2/starfive_visionfive2.c        |   2 +
>  .../visionfive2/visionfive2-i2c-eeprom.c      |  64 ++++---
>  configs/starfive_visionfive2_defconfig        |   2 +-
>  drivers/pci/pcie_starfive_jh7110.c            |   8 +
>  .../src/riscv/starfive/jh7110-common.dtsi     |  22 ---
>  .../jh7110-deepcomputing-fml13v01.dts         |  49 ++++++
>  .../src/riscv/starfive/jh7110-milkv-mars.dts  |  49 ++++++
>  .../riscv/starfive/jh7110-pine64-star64.dts   |  49 ++++++
>  .../jh7110-starfive-visionfive-2.dtsi         |  46 +++++
>  dts/upstream/src/riscv/starfive/jh7110.dtsi   |  16 --
>  .../jh7110s-starfive-visionfive-2-lite.dts    | 159 ++++++++++++++++++
>  14 files changed, 418 insertions(+), 66 deletions(-)
>  create mode 100644 dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
