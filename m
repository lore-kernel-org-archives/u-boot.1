Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9F2E7E0D5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 19:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2B3805D7;
	Mon,  9 Feb 2026 20:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="h3H6tDD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8C348388D; Mon,  9 Feb 2026 20:11:36 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8130802C1
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 20:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1770664259;
 bh=8RStGtLwqy0Kq/J8UUsUPIgNuRHYW/h5smCB5HX2MLw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=h3H6tDD1VKTBQndl3sFoeQWbkOyJyF5C0hfTVoMHt6akuOqeWlORr5WCRtdLQuchL
 HudvefbhyQhCYTY6dzcOlZfkXbHL1xjrneWVhLSZxj2udihI/0EWrdXA5Mm473abLR
 Hv5fR+Uoy64Ov/lPl3ehHwDD2UZdiZ7MlPH+SkFa/2pfUisHzeAjBMsAfW/1RfheOM
 +ckmX2qUPYa6HwhGz33LBgMJu35jn6vBf+xw3L8Iy/daSf5GD/8ZN2v9jIAJaiw6HU
 ASn67sjX57XlB5gLRQeYIcgYmJ5+8y69jMvbQOj5G2KYXEfLZpjLdUOFNm19vX5O6a
 kt0jmo5qq9HQw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 84EC4B22024A;
 Mon,  9 Feb 2026 20:10:57 +0100 (CET)
Message-ID: <0e28b0a3-0c85-4690-8429-fe3cc514dded@freeshell.de>
Date: Mon, 9 Feb 2026 11:10:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] Add support for StarFive VisionFive 2 Lite board
To: Leo Liang <ycliang@andestech.com>, Hal Feng <hal.feng@starfivetech.com>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 u-boot@lists.denx.de
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
 <aYnDPqVzlesZqy2C@swlinux02>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <aYnDPqVzlesZqy2C@swlinux02>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Leo, Hal, Tom, and Heinrich, et.al

On 2/9/26 03:21, Leo Liang wrote:
> On Fri, Oct 24, 2025 at 04:59:23PM +0800, Hal Feng wrote:
>> VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S industrial
>> SoC which can run at -40~85 degrees centigrade and up to 1.25GHz.
>>
>> Board features:
>> - JH7110S SoC
>> - 4/8 GiB LPDDR4 DRAM
>> - AXP15060 PMIC
>> - 40 pin GPIO header
>> - 1x USB 3.0 host port
>> - 3x USB 2.0 host port
>> - 1x M.2 M-Key (size: 2242)
>> - 1x MicroSD slot (optional non-removable 64GiB eMMC)
>> - 1x QSPI Flash
>> - 1x I2C EEPROM
>> - 1x 1Gbps Ethernet port
>> - SDIO-based Wi-Fi & UART-based Bluetooth
>> - 1x HDMI port
>> - 1x 2-lane DSI
>> - 1x 2-lane CSI
>>
>> VisionFive 2 Lite schematics: https://doc-en.rvspace.org/VisionFive2Lite/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
>> VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/index.html
>> More documents: https://doc-en.rvspace.org/Doc_Center/visionfive_2_lite.html
>>
>> Note: Patch 1 and 2 are the kernel device tree picked from [1]. They are
>> just for test and please ignore them because dts/upstream should be synced
>> with devicetree-rebasing.
>>
>> [1] https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfivetech.com/
>>
>> Changes since RFC:
>> - Rebase on the latest mainline.
>> - Improve the commit messages.
>> - Drop patch 7.
>> patch 3, 4:
>> - Return 0 instead of 0xFF if read_eeprom() fails.
>> patch 5:
>> - Keep default FORMAT_VERSION 0x2.
>> - Change wifi_bt field to onboard_module field and use bit 0 to mark
>>   WIFI/BT.
>> - Drop all "no_eth0", "no_eth1" configuration.
>>
>> History:
>> RFC: https://lore.kernel.org/all/20250829060931.79940-1-hal.feng@starfivetech.com/
>>
>> Hal Feng (9):
>>   riscv: dts: starfive: jh7110-common: Move out some nodes to the board
>>     dts
>>   riscv: dts: starfive: Add VisionFive 2 Lite board device tree
>>   eeprom: starfive: Simplify get_ddr_size_from_eeprom()
>>   eeprom: starfive: Correct get_pcb_revision_from_eeprom()
>>   eeprom: starfive: Support eeprom data format v3
>>   pcie: starfive: Add a optional power gpio support
>>   configs: visionfive2: Add VisionFive 2 Lite DT to OF_LIST
>>   board: starfive: spl: Support VisionFive 2 Lite
>>   board: starfive: visionfive2: Add VisionFive 2 Lite fdt selection
>>
>>  arch/riscv/cpu/jh7110/spl.c                   |   2 +-
>>  arch/riscv/include/asm/arch-jh7110/eeprom.h   |  13 +-
>>  board/starfive/visionfive2/spl.c              |   3 +
>>  .../visionfive2/starfive_visionfive2.c        |   2 +
>>  .../visionfive2/visionfive2-i2c-eeprom.c      |  64 ++++---
>>  configs/starfive_visionfive2_defconfig        |   2 +-
>>  drivers/pci/pcie_starfive_jh7110.c            |   8 +
>>  .../src/riscv/starfive/jh7110-common.dtsi     |  22 ---
>>  .../jh7110-deepcomputing-fml13v01.dts         |  49 ++++++
>>  .../src/riscv/starfive/jh7110-milkv-mars.dts  |  49 ++++++
>>  .../riscv/starfive/jh7110-pine64-star64.dts   |  49 ++++++
>>  .../jh7110-starfive-visionfive-2.dtsi         |  46 +++++
>>  dts/upstream/src/riscv/starfive/jh7110.dtsi   |  16 --
>>  .../jh7110s-starfive-visionfive-2-lite.dts    | 159 ++++++++++++++++++
>>  14 files changed, 418 insertions(+), 66 deletions(-)
>>  create mode 100644 dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
> 
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

The series has errors as it is applied:

https://source.denx.de/u-boot/custodians/u-boot-riscv/-/commits/master?ref_type=HEADS

For example:

https://source.denx.de/u-boot/custodians/u-boot-riscv/-/commit/4ea3acc000a793d04bae90eabfdc47be31580b87

- CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01
starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc
starfive/jh7110-milkv-marscm-lite starfive/jh7110-pine64-star64
starfive/jh7110-starfive-visionfive-2-v1.2a
starfive/jh7110-starfive-visionfive-2-v1.3b"

+ CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01
starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc
starfive/jh7110-milkv-marscm-lite starfive/jh7110-pine64-star64
starfive/jh7110-starfive-visionfive-2-v1.2a
starfive/jh7110-starfive-visionfive-2-v1.3b
configs/starfive_visionfive2_defconfig"

The above does not agree with what I reviewed on the mailing list. I am
listed as having reviewed the content being applied. What was applied is
something completely different than what I reviewed!

My question:

Why are changes to the series being made when applying to the tree, who
is making those changes, and how can we get visibility into these
mistakes? My question is valid even if the errors are not intentional or
through action of some automated merge algorithm.

This is a serious problem to associate contributors with code they did
not write or review.

-E
