Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919BECFD2F9
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 22:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7B5283AB8;
	Sat, 22 Nov 2025 23:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="HK9AoHdk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAF9D83B4B; Sat, 22 Nov 2025 23:52:15 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 889BB83A36
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 23:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1763851915;
 bh=buYLvEetyNMVHVQuHaD12mln2lC6C6iQ2185UT1O1fM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HK9AoHdku7xshljiN6i7Jh3HfpxR8a0wdcQzDxfUCFSD42bQwblqckqycQ8rckW/a
 xkHgmwoSruAQyMh+d3GpDxm1GqSkmw/ipS8xioPapqrkKpq9H22Xwg8Pt7GeePmbM7
 Cixf2CxrFldz0iQkRoZw6rY6PEm5J8/3CKpe4uPF1LlLh6DawFipoxzYZP7R5Eb90P
 vQxrRXizTI6kC4ydrqR992csftejgbD8z3YD7sI7b1KbBHGL9Ew+BVCbOUT7yqUgO5
 O/M9N6agegHSG0PwFM1CxtryLcd5qkxPmrDielQHmy+tV9FdXCaEgLSpTbieCrLktD
 rNDM8JQq9HWVw==
Received: from [192.168.2.54] (unknown [143.105.119.236])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 5BCB5B2205A8;
 Sat, 22 Nov 2025 23:51:53 +0100 (CET)
Message-ID: <a2b6b437-c4b3-4d3c-bf38-22b65b6b9d2b@freeshell.de>
Date: Sat, 22 Nov 2025 14:51:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: board: starfive: update jh7110 common description
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251117233603.15409-1-e@freeshell.de>
 <24B5D5B7-0D3F-4091-82B8-A5E2328DE59F@gmx.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <24B5D5B7-0D3F-4091-82B8-A5E2328DE59F@gmx.de>
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

Hello Heinrich thank you for the review,

On 11/17/25 23:08, Heinrich Schuchardt wrote:
> Am 18. November 2025 00:35:51 MEZ schrieb E Shattow <e@freeshell.de>:
>> Updates to the JH7110 common description:
>> - add detailed overview of JH-7110 SoC and boot process
>> - revise descriptions of deprecated StarFive loader modes
>> - refresh build directions grouped with SPL debug advice
>> - reduce usage instructions into common methods shared by supported boards
>> - cite starfive_visionfive2 board maintainer description of StarFive loader
>> - cite published datasheets for ambient operating temperature data
>>
>> Redundant/deprecated sections of each board doc are dropped accordingly:
>> - deepcomputing fml13v01
>> - milk-v mars
>> - pine64 star64 (also add inclusion of JH7110 common description)
>> - visionfive2
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>> Changes since v1:
>>
>> By popular request I have expanded on the topic of deprecated boot modes.
>> For those users that rely on this it is now more descriptive about
>> factors contributing to the feature deprecation and naming the U-Boot
>> release version when this change is in effect. Re-introducing these modes
>> is out of scope for this documentation series, however.
>>
>> - reST needs a space between numeric and the substitution
>> - add comment identifying where U-Boot SPL again reads state of [RGPIO1:RGPIO0]
>>  useful to refer to for boards with button+transistors instead of MSEL DIP
>> - cite reference to JH-7110 Boot User Guide BootROM description of StarFive loader
>> - expand on topic of supported and deprecated U-Boot SPL boot modes
>> - cite from published datasheets for ambient operating temperature data
>> - drop not-yet-published OpenSBI version recommendation
>> ---
>> doc/board/starfive/deepcomputing_fml13v01.rst |  32 -
>> doc/board/starfive/jh7110_common.rst          | 633 +++++++++++++++---
>> doc/board/starfive/milk-v_mars.rst            |  73 --
>> doc/board/starfive/pine64_star64.rst          |  77 +--
>> doc/board/starfive/visionfive2.rst            | 449 -------------
>> 5 files changed, 547 insertions(+), 717 deletions(-)
>>
>> diff --git a/doc/board/starfive/deepcomputing_fml13v01.rst b/doc/board/starfive/deepcomputing_fml13v01.rst
>> index 5d9612483b4..9777f4c6303 100644
>> --- a/doc/board/starfive/deepcomputing_fml13v01.rst
>> +++ b/doc/board/starfive/deepcomputing_fml13v01.rst
>> @@ -9,38 +9,6 @@ The DeepComputing Framework motherboard (FLM13V01) can be combined with a
>> U-Boot for the board uses the same binaries as the VisionFive 2 board.
>> Currently only serial console output is supported by mainline U-Boot.
>>
>> -Building
>> ---------
>> -
>> -Setup the cross compilation environment variable:
>> -
>> -.. code-block:: bash
>> -
>> -   export CROSS_COMPILE=riscv64-linux-gnu-
>> -
>> -The M-mode software OpenSBI provides the supervisor binary interface (SBI) and
>> -is responsible for the switch to S-Mode. It is a prerequisite for building
>> -U-Boot. Support for the JH7110 was introduced in OpenSBI 1.2. It is recommended
>> -to use a current release.
>> -
>> -.. code-block:: bash
>> -
>> -    git clone https://github.com/riscv/opensbi.git
>> -    cd opensbi
>> -    make PLATFORM=generic FW_TEXT_START=0x40000000 FW_OPTIONS=0
>> -    export OPENSBI="$(pwd)/build/platform/generic/firmware/fw_dynamic.bin"
>> -
>> -Now build U-Boot SPL and main U-Boot.
>> -
>> -.. code-block:: bash
>> -
>> -    cd <U-Boot-dir>
>> -    make starfive_visionfive2_defconfig
>> -    make
>> -
>> -This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
>> -as the FIT image (u-boot.itb) with OpenSBI, U-Boot, and device-trees.
>> -
>> Device-tree selection
>> ---------------------
>>
>> diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
>> index 4a8058ee5da..2f049b4c327 100644
>> --- a/doc/board/starfive/jh7110_common.rst
>> +++ b/doc/board/starfive/jh7110_common.rst
>> @@ -1,103 +1,560 @@
>> .. SPDX-License-Identifier: GPL-2.0-or-later
>> +.. |arrowin| unicode:: U+2190
>> +.. |arrowout| unicode:: U+2192
>> +.. |degreecelsius| unicode:: U+2103
>> +.. _U74-MC Core Complex: https://www.starfivetech.com/uploads/u74mc_core_complex_manual_21G1.pdf
>> +.. _JH-7110 Technical Reference Manual: https://doc-en.rvspace.org/JH7110/TRM/
>> +.. _JH-7110 Boot User Guide BootROM: https://doc-en.rvspace.org/VisionFive2/Boot_UG/JH7110_SDK/bootrom.html
>> +.. _JH-7110 Datasheet: https://doc-en.rvspace.org/JH7110/PDF/JH7110_DS.pdf
>> +.. _JH-7110I Datasheet: https://doc-en.rvspace.org/JH7110/PDF/JH7110I_DS.pdf
>> +.. _Description of StarFive loader: https://lore.kernel.org/u-boot/ZQ2PR01MB1307E9F46803F18B2B9D5394E6C22@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn/
>>
>> -Boot source selection
>> ----------------------
>> +StarFive JH-7110 RISC-V SoC
>> +---------------------------
>>
>> -The board provides DIP switches to select the device for loading the boot
>> -firmware.
>> +* JH-7110 working frequency 1.5GHz
>> +  ambient operating temperature range -20 |degreecelsius| to +85 |degreecelsius|
>> +  (`JH-7110 Datasheet`_)
>>
>> -=========== === ===
>> -Boot source SW1 SW2
>> -=========== === ===
>> -UART        OFF OFF
>> -SD-card     ON  OFF
>> -eMMC        OFF ON
>> -SPI flash   ON  ON
>> -=========== === ===
>> +* JH-7110I working frequency 1.5GHz
>> +  ambient operating temperature range -40 |degreecelsius| to +85 |degreecelsius|
>> +  (`JH-7110I Datasheet`_)
>>
>> -Flashing a new U-Boot version
>> ------------------------------
>> +* JH-7110S working frequency 1.25GHz
>>
>> -U-Boot SPL is provided as file spl/u-boot-spl.bin.normal.out. Main U-Boot is
>> -in file u-boot.itb.
>> +JH-7110 is a 4+1 core RISC-V System on Chip:
>>
>> -Assuming your new U-Boot version is on partition 1 of an SD-card you could
>> -install it to the SPI flash with:
>> +* `U74-MC Core Complex`_
>>
>> -.. code-block:: console
>> +  * S7 monitor core RV64IMAC
>> +
>> +    * Physical Memory Protection
>> +    * 16KB L1 Instruction cache
>> +    * 8KB Data Tightly-Integrated Memory
>> +
>> +  * U74 application core RV64GC (x4)
>> +
>> +    * Sv39 Memory Management Unit
>> +    * Floating Point Unit
>> +    * 32KB L1 Instruction cache
>> +    * 32KB L1 Data cache
>> +    * Physical Memory Protection
>> +
>> +  * Core-Local INTerruptor
>> +  * Platform-Level Interrupt Controller
>> +  * Debug
>> +  * Bus Matrix
>> +
>> +    * 2MB L2 cache
>> +
>> +      * Memory Port |arrowout| 128-bit AXI4
>> +
>> +    * System Port |arrowout| 64-bit AXI4
>> +    * Peripheral Port |arrowout| 64-bit AXI4
>> +    * Front Port |arrowin| 64-bit AXI4
>> +
>> +* Block
>> +
>> +  * RV32IMAFCB E24 co-processor
>> +
>> +    * 16KB Instruction cache
>> +    * 32KB Tightly-Integrated Memory "A"
>> +    * 32KB Tightly-Integrated Memory "B"
>> +
>> +  * Mailbox
>> +  * SGDMA
>> +
>> +* Network-on-Chip/AXI bus
>> +* Memory
>> +
>> +  * SRAM 256KB/BootROM 32KB
>> +  * LPDDR4/DDR4/LPDDR3/DDR3 32-bit 2800 Mbps (2133 Mbps supported working speed)
>> +  * QSPI Flash Controller
>> +
>> +* Interfaces
>> +
>> +  * PCIe2.0 1-lane x2
>> +  * Ethernet MAC 10/100/1000 Mbps x2
>> +  * USB 2.0 Host/Device
>> +  * SDIO3.0 x2
>> +  * CAN2.0B x2
>> +
>> +* Audio
>> +
>> +  * Cadence Tensilica HiFi-4 Audio DSP defined by U74MC or E24
>> +
>> +    * 4x 32x32-bit MACs
>> +    * some 72-bit accumulators
>> +    * limited support for 8x 32x16-bit MACs
>> +    * fourth VLIW slot
>> +    * two 64-bit loads per cycle
>> +    * optional floating point unit for four single-precision MACs per cycle
>> +
>> +  * I2S/PCM-TDM
>> +  * I2S/PCM
>> +  * PDM x4
>> +  * SPDIF
>> +
>> +* Graphics
>> +
>> +  * Epicsemi ISP
>> +  * IMG BXE-4-32 Integrated GPU with 3D Acceleration
>> +  * 12-bit DVP
>> +  * MIPI-CSI
>> +
>> +* Cryptographic function
>> +
>> +  * TRNG
>> +  * OTP
>> +  * Security HW Engine AES/DES/3DES/HASH/PKA
>> +
>> +* Block
>> +
>> +  * PAD_SHARE used for reset
>> +  * Power Management Unit Clock Reset Generator
>> +  * PLL x3
>> +  * JTAG
>> +  * RTC
>> +  * Temperature Sensor
>> +
>> +Supported SoC drivers:
>> +
>> +* ns16550 UART
>> +* StarFive JH-7110 clock
>> +* StarFive JH-7110 reset
>> +* Cadence QSPI controller
>> +* DesignWare MMC for eMMC/SD support
>> +* PLDA PCIe controller
>> +* Cadence USB2.0/3.0 controller
>> +
>> +Supported common peripherals:
>> +
>> +* AXP15060 Power Management Unit
>> +* LPDDR4 2GB / 4GB / 8GB DRAM memory
>> +* AT24C04F 4K bits (512 x 8) EEPROM
>> +* QSPI NOR Flash 16M or SoC ROM UART loader for boot (selectable by GPIO)
>> +
>> +Extra supported peripherals present on some boards:
>> +
>> +* Motorcomm YT8531C Gigabit Ethernet PHY
>> +* On-board VL805 PCIE-USB controller driver
>> +* Status LED RGPIO3
>> +
>> +Build U-Boot
>> +------------
>> +
>> +1.  Add a RISC-V toolchain to your PATH.
>> +2.  Set cross compilation environment variable if needed:
>> +
>> +    .. code-block:: none
>> +
>> +       export CROSS_COMPILE=<riscv64 toolchain prefix>
>> +
>> +3.  U-Boot for JH-7110 requires OpenSBI v1.5+ generic platform object
>> +    fw_dynamic.bin to be included in the Flattened Image Tree blob. OpenSBI may
>> +    first be built as below:
> 
> Please, describe that the JH7710S requires a patch that will be in OpenSBI v1.8 for reboot support.
> 
> 

Consider the review feedback you provide ("The changes in OpenSBI and
the cpu frequency driver could have been avoided by using..." at LKML
discussion for VisionFive 2 Lite series v2)

https://lore.kernel.org/lkml/1f96a267-f5c6-498e-a2c4-7a47a73ea7e7@canonical.com/

That is correct or not? OpenSBI release v1.5+ is enough, OpenSBI v1.8 is
not required?

>> +
>> +    .. code-block:: console
>> +
>> +       # clone and/or update OpenSBI sources
>> +       git clone https://github.com/riscv/opensbi.git opensbi.git
>> +       git -C opensbi.git checkout v1.7
>> +       # always clean build directory when building OpenSBI due to incomplete
>> +       # dependency tracking
>> +       make -C opensbi.git -O opensbi clean
>> +       make -C opensbi.git -O opensbi PLATFORM=generic
>> +
>> +4.  Now build the First Stage BootLoader (U-Boot Secondary Program Loader) and
>> +    Second Boot Loader (OpenSBI + U-Boot Main):
>> +
>> +    .. code-block:: console
>> +
>> +       git clone https://source.denx.de/u-boot/u-boot.git u-boot.git
>> +       make -C u-boot.git -O u-boot starfive_visionfive2_defconfig
>> +       export OPENSBI=opensbi/build/platform/generic/firmware/fw_dynamic.bin
>> +       make -C u-boot.git -O u-boot
> 
> Why make it that complicated? Neither -O nor -C is needed if you are in the U-Boot directory.
> 

Directory name references are consistent throughout the document by
having clear separatation of source directories from build directories
and to avoid changing the state of the current working directory.

The build commands are longer this way with more text but they remain
less than 80col and consistent, which is fine for readability.

> -j(nproc) is helpful.
> 

Optimization for faster compilation is outside the scope of this
document. We may place a ref link to another U-Boot doc if you would
like to make a suggestion for where to find this `-j$(nproc)` faster
compilation advice?

>> +
>> +    This will generate the U-Boot SPL image object post-processed with StarFive
>> +    SPL headers (u-boot/spl/u-boot-spl.bin.normal.out) as well as the FIT image
>> +    (u-boot/u-boot.itb) of OpenSBI and U-Boot Main.
>> +
>> +    Note: Debug UART is not available from U-Boot SPL when U-Boot Main uses the
>> +    SBI interface for this. Add the following configuration changes above to
> 
> Please, mention that the SBI based debug UART is enabled by default.
> 
> 
> 

"SBI-based debug UART" appears to be a contradiction. SBI provides a
console UART, and U-Boot Main uses the SBI console UART for debug
output. "Debug UART" has a very specific meaning in the U-Boot code and
Kconfig symbol selection. What Kconfig symbol(s) is it you refer to?

Do I misunderstand this? How exactly should this be explained here?

>> +    enable early debug UART in U-Boot SPL::
>> +
>> +        u-boot.git/scripts/config --file u-boot/.config \
>> +         --set-val DEBUG_UART_BASE 0x10000000 \
>> +         --set-val DEBUG_UART_CLOCK 24000000 \
>> +         --enable DEBUG_UART_NS16550 \
>> +         --disable DEBUG_SBI_CONSOLE \
>> +         --set-val SPL_DEBUG_UART_BASE 0x10000000 \
>> +         --set-val DEBUG_UART_SHIFT 2
>> +
>> +        make -C u-boot.git -O u-boot olddefconfig
> 
> Just mention the Kconfig values. `make menuconfig` is the sane way to edit the configuration.
> 

No, thank you. There is a problem of compability with my terminal.
Escape and backspace keycodes are dead-end navigation and each time
starting again `make menuconfig`. That is not sane for me. Anyone else
can add the description of menuconfig usage or it can be inferred from
what I have collected here anyway.

>> +
>> +Boot description
>> +----------------
>> +
>> +JH-7110 reset vectors (one 36-bit address per each of four U7 cores) are located
>> +split into four pairs of SYS SYSCON registers. The default value for all four
> 
> What does SYS SYSCON allude to?
> 

"SYS SYSCON" phrase is a direct quote from the technical reference
manual. I will add the ref link.

>> +reset vectors is 2a000000.
> 
> Which registers?
> 

I prefer "registers" said as a broad topic here. For your reference it
is the low 36-bits of offset ranges [0x6c:0x68] [0x74:0x70] [0x7c:0x78]
[0x84:0x80]. The address length, content, and relationship to U7 cores
is relevant but the locations where stored are meaningless for the
general boot description.

It may be approriate when possible to ref link the StarFive loader
source code that consumes this content (leading to the following section
description).

>> +
>> +Execute-in-place BootROM code located at 2a000000 is not published by StarFive
>> +however may be generally described as deciding based on [RGPIO2:RGPIO0] state
>> +where to transfer SPL data from, verify headers and CRC, and then jump to code
>> +execution in L2 LIM.
>> +
>> +Zero Stage Program Loader
>> +^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +====== =========== =============
>> +RGPIO2 Boot Vector ZSPL function
>> +====== =========== =============
>> +0      0x2A00_0000 On-chip 32KB BootROM
>> +1      0x2100_0000 QSPI XIP Flash (256mb)
>> +====== =========== =============
>> +
>> +JH-7110 ZSPL functionally consists of the selection of reset vector register
>> +defaults at chip-design time in concert with BootROM code at 2a000000. `JH-7110
>> +Technical Reference Manual`_ says "if XIP flash is disabled in OTP
>> +configuration, system cannot boot from XIP flash". Presumably there is some OTP
>> +configuration involved but there is no documentation available with which to
>> +expand on that topic.
>> +
>> +Zero Stage BootLoader
>> +^^^^^^^^^^^^^^^^^^^^^
>> +
>> +JH-7110 ZSBL is typically StarFive loader code in BootROM selected by RGPIO2
>> +pull-down.
>> +
>> +====== ====== ======================================
>> +RGPIO1 RGPIO0 StarFive loader function @ 0x2A00_0000
>> +====== ====== ======================================
>> +0      0      1-bit QSPI Flash offset 0x0
>> +0      1      SDIO3.0 *(deprecated)*
> 
> SD-card would be better comprehensible.
> 

"SD-card" has no results in the technical reference manual and will be a
wrong description here for several boards where this is not an SD card.
Additional context should be written in per-board documentation about
the expected function, for example many boards do not physically have
this as a possible mode because of a "boot button" with associated
transistor logic.

>> +1      0      eMMC5.0 *(deprecated)*

"eMMC5.0" as written in a two-years-more-recent product literature datasheet

https://doc-en.rvspace.org/JH7110/PDF/JH7110_DS.pdf

is not present in the technical reference manual, but "eMMC5.1" is
present at the older boot process document:

https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/boot_process.html

I will update this terminology here to list both "eMMC5.0 or eMMC5.1". I
don't know how to verify this in the StarFive loader if it is eMMC5.0 or
eMMC5.1 so I have to trust it is maybe one or the other as in
documentation that is published.

>> +1      1      UART Serial XMODEM loader

The XMODEM loader in StarFive loader is under-documented as well, but
there's very little progress I have made on inspecting the StarFive
loader for this so I just don't have anything to expand on. We
collectively understand that its XMODEM implementation is different than
the published specification, and I recall that some analysis was posted
in an "Internet forum" (not sure where, I don't remember that?) to
explain this but I have not been able to find this information again or
(as I said now) to verify this against the StarFive loader in the
BootROM. That seems rather important to include when possible.

>> +====== ====== ======================================
>> +
>> +According to `JH-7110 Boot User Guide BootROM`_ the StarFive loader code reads
>> +content to SRAM @ 0x0800_0000 from different media selected by [RGPIO1,RGPIO0].
>> +
>> +`Description of StarFive loader`_ by the StarFive VisionFive2 board maintainer:
>> +
>> +    The SD card boot mode is supported but the mmc driver of BootROM is not
> 
> of the
> 

This...

>> +    compatible with a few SD cards. If you can't boot from a SD card, you can
>> +    change another card for a try.
>> +
>> +    The eMMC boot mode loads SPL from sector 0, while the SD card boot mode
>> +    loads GPT header from sector 1 and then finds the partition whose GUID is
> 
> loads the
> 

...and that...

>> +    2E54B353-1271-4842-806F-E436D6AF6985 to load SPL. So if we try to use GPT
>> +    partition in eMMC, it will fail to boot and report CRC (stored at 0x290)
>> +    failure. The workaround is using the backup load address. After the CRC
>> +    failure happens, it will try to load the SPL from the backup address
>> +    (stored at 0x4~0x7). That is why we write 0x00100000 to 0x4~0x7. But this
> 
> This value is not fixed. The backup location can be freely chosen.
> 
> 

...and up to here are a direct cited quotation. I do not modify the
source material because it is not my writing.

>> +    workaround is not a standard process and may destroy the partition
>> +    information stored in sector 0.
>> +
>> +There are additional unexplained GUID references in the JH-7110 MaskROM so the
>> +description given is not complete. Attribution and modifications to the GPL2.0+
>> +source code used in StarFive loader have not been published as of this writing.
>> +Due to the lack of verifiable documentation the upstream Linux devicetree does
>> +not contain hints for mmc0 and mmc1 interfaces to be included in U-Boot SPL. As
>> +of U-Boot release v2025.10 and newer the U-Boot specific devicetree override of
>> +hints for mmc0 and mmc1 interfaces that are required for the deprecated modes
>> +have been dropped marking the deprecation of these boot modes in U-Boot.
> 
> Do you mean upstream  U-Boot will fail to boot from SD-card, which is the Ubuntu default?
> 
> This would need to be fixed urgently. 
> 

Yes, Ubuntu may remove bundled U-Boot SPL on the SD-card image, as
consistent with the latest revision of JH-7110 technical reference
manual, datasheet, and boot guide. Many of the JH-7110 boards in
production are physically unable to boot U-Boot SPL from SD-card (or
eMMC) anyways, so it is quite important to fix this problem with any
vendor SD-card image that does so.

>> +
>> +Supported modes in U-Boot SPL are QSPI Flash and UART Serial XMODEM loader as
>> +accepted by upstream Linux Kernel for StarFive JH-7110 common devicetree.
>> +
>> +First Stage BootLoader
>> +^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +JH-7110 FSBL is typically U-Boot SPL or any vendor flash programming tool.
>> +
>> +====== ====== ===================
>> +RGPIO1 RGPIO0 U-Boot SPL function
>> +====== ====== ===================
>> +0      0      BOOT_DEVICE_SPI @ offset 0x100000 (CONFIG_ENV_OFFSET + CONFIG_ENV_SIZE)
>> +0      1      BOOT_DEVICE_MMC2 @ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
>> +1      0      BOOT_DEVICE_MMC1 @ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
>> +1      1      BOOT_DEVICE_UART @ YMODEM
>> +====== ====== ===================
>> +
>> +U-Boot SPL initializes DRAM and configures PLLs needed by CPU and peripherals.
>> +U-Boot SPL function is selected by configuration of [RGPIO1:RGPIO0] then copies
>> +data to the start of DRAM and executes.
>> +
>> +=========== ===========
>> +Address     Description
>> +=========== ===========
>> +0x040000000 start of DRAM
>> +0x240000000 uncached alias of DRAM
>> +=========== ===========
>> +
>> +Note: The largest DRAM size with JH7110 is 8GB because the uncached alias of
>> +DRAM begins at +8GB following the start of DRAM.
>> +
>> +Second Stage BootLoader (OpenSBI fw_dynamic.bin + U-Boot Main)
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +U-Boot Main is supported in S-mode and depends on prior stage M-mode SBI runtime
>> +services provided by OpenSBI FW_DYNAMIC firmware.
>> +
>> +Loading U-Boot
>> +--------------
>> +
>> +Vendored versions of U-Boot (as pre-installed on supported boards) are generally
>> +capable in U-Boot console of UART data transfer and updating QSPI Flash.
>> +Additionally there may be a vendor Board Support Package using the deprecated
>> +SDIO3.0 / eMMC5.0 boot modes. It is not documented here how to update U-Boot in
>> +vendor BSP data images, nor use of the deprecated boot modes. The recommended
>> +upgrade path is to update QSPI Flash in U-Boot console or from GNU/Linux OS.
>> +
>> +============ ============================ ===========
>> +Flash offset Length                       Data source
>> +============ ============================ ===========
>> +0x000000     0x0f0000 (CONFIG_ENV_OFFSET) u-boot/spl/u-boot-spl.bin.normal.out
>> +0x0f0000     0x010000 (CONFIG_ENV_SIZE)   runtime generated defaults if bad CRC
>> +0x100000     0xf00000                     u-boot/u-boot.itb
>> +============ ============================ ===========
>> +
>> +Recovery U-Boot console
>> +^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +With UART serial USB adapter and tio serial terminal::
> 
> The description below makes no sense to me.
> 
> For recovery you would just use U-Boot. There is no need for any recovery binary.
> 

This is intended to be a general description for reference by the
per-board documentation, split into two parts.

The first part is recovery (or temporary U-Boot) with U-Boot SPL as a
recovery binary and paired with U-Boot Main.


The second part what you describe with a valid working U-Boot Main is
repeatable because of the first part. Otherwise (for the general
description) it is not repeatable because we don't know what we are
describing; hopefully it is some U-Boot version that was similar enough
so the advice given makes sense. The place to describe these per-board
differences is in per-board documentation.


Future improvement here may ref link to the HTTPS wget and fastboot
command descriptions which would first need to be enabled in
starfive_visionfive2_defconfig and reach a major release;  I think all
production boards have USB and serial UART connectivity exposed, and
many (not all) boards on the market (not necessarily yet upstream in
Linux or U-Boot) have network exposed so it would be appropriate to
describe in the general section here when enabled. I did send a patch
for enable of unverified HTTPS wget. I am not as confident to submit for
fastboot enable in starfive_visionfive2_defconfig because I don't have
the range of boards to test and document properly.

> Best regards 
> 
> Heinrich
> 
>> +
>> +    tio /dev/ttyUSB0 -o 1
>> +        tio 3.9
>> +        Press ctrl-t q to quit
>> +        Connected to /dev/ttyUSB0
>> +
>> +    # Power on the board with [RGPIO1:RGPI0]=3
>> +        (C)StarFive
>> +        CC
>> +        (C)StarFive
>> +        CCC
>> +
>> +    (Control-t-x)
>> +        Please enter which X modem protocol to use:
>> +         (0) XMODEM-1K send
>> +         (1) XMODEM-CRC send
>> +         (2) XMODEM-CRC receive
>> +
>> +    0
>> +        Send file with XMODEM-1K
>> +        Enter file name:
>> +
>> +    u-boot/spl/u-boot-spl.bin.normal.out
>> +        Sending file 'u-boot/spl/u-boot-spl.bin.normal.out'
>> +        Press any key to abort transfer
>> +        ...|
>> +        Done
>> +
>> +    # U-Boot SPL on the board with [RGPIO1:RGPI0]=3
>> +        U-Boot SPL 2025.10 (Oct 23 2025 - 17:01:49 -0700)
>> +        DDR version: dc2e84f0.
>> +        Trying to boot from UART
>> +        CCC
>> +
>> +    (Control-t-y)
>> +        Send file with YMODEM
>> +        Enter file name:
>> +
>> +    u-boot/u-boot.itb
>> +        Sending file 'u-boot/u-boot.itb'
>> +        Press any key to abort transfer
>> +        ...|
>> +        Done
>> +        Loaded 3122637 bytes
>> +
>> +        OpenSBI v1.7
>> +           ____                    _____ ____ _____
>> +          / __ \                  / ____|  _ \_   _|
>> +         | |  | |_ __   ___ _ __ | (___ | |_) || |
>> +         | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
>> +         | |__| | |_) |  __/ | | |____) | |_) || |_
>> +          \____/| .__/ \___|_| |_|_____/|____/_____|
>> +                | |
>> +                |_|
>> +
>> +        Platform Name               : Pine64 Star64
>> +        Platform Features           : medeleg
>> +        Platform HART Count         : 4
>> +        Platform IPI Device         : aclint-mswi
>> +        Platform Timer Device       : aclint-mtimer @ 4000000Hz
>> +        Platform Console Device     : uart8250
>> +        Platform HSM Device         : ---
>> +        Platform PMU Device         : ---
>> +        Platform Reboot Device      : pm-reset
>> +        Platform Shutdown Device    : pm-reset
>> +        Platform Suspend Device     : ---
>> +        Platform CPPC Device        : ---
>> +        Firmware Base               : 0x40000000
>> +        Firmware Size               : 353 KB
>> +        Firmware RW Offset          : 0x40000
>> +        Firmware RW Size            : 97 KB
>> +        Firmware Heap Offset        : 0x4c000
>> +        Firmware Heap Size          : 49 KB (total), 3 KB (reserved), 12 KB (used), 33 KB (free)
>> +        Firmware Scratch Size       : 4096 B (total), 400 B (used), 3696 B (free)
>> +        Runtime SBI Version         : 3.0
>> +        Standard SBI Extensions     : time,rfnc,ipi,base,hsm,srst,pmu,dbcn,fwft,legacy,dbtr,sse
>> +        Experimental SBI Extensions : none
>> +
>> +        Domain0 Name                : root
>> +        Domain0 Boot HART           : 4
>> +        Domain0 HARTs               : 1*,2*,3*,4*
>> +        Domain0 Region00            : 0x0000000010000000-0x0000000010000fff M: (I,R,W) S/U: (R,W)
>> +        Domain0 Region01            : 0x0000000002000000-0x000000000200ffff M: (I,R,W) S/U: ()
>> +        Domain0 Region02            : 0x0000000040040000-0x000000004005ffff M: (R,W) S/U: ()
>> +        Domain0 Region03            : 0x0000000040000000-0x000000004003ffff M: (R,X) S/U: ()
>> +        Domain0 Region04            : 0x000000000c000000-0x000000000fffffff M: (I,R,W) S/U: (R,W)
>> +        Domain0 Region05            : 0x0000000000000000-0xffffffffffffffff M: () S/U: (R,W,X)
>> +        Domain0 Next Address        : 0x0000000040200000
>> +        Domain0 Next Arg1           : 0x0000000042200000
>> +        Domain0 Next Mode           : S-mode
>> +        Domain0 SysReset            : yes
>> +        Domain0 SysSuspend          : yes
>> +
>> +        Boot HART ID                : 4
>> +        Boot HART Domain            : root
>> +        Boot HART Priv Version      : v1.11
>> +        Boot HART Base ISA          : rv64imafdcbx
>> +        Boot HART ISA Extensions    : zihpm,sdtrig
>> +        Boot HART PMP Count         : 8
>> +        Boot HART PMP Granularity   : 12 bits
>> +        Boot HART PMP Address Bits  : 34
>> +        Boot HART MHPM Info         : 2 (0x00000018)
>> +        Boot HART Debug Triggers    : 8 triggers
>> +        Boot HART MIDELEG           : 0x0000000000000222
>> +        Boot HART MEDELEG           : 0x000000000000b109
>> +
>> +
>> +        U-Boot 2025.10 (Oct 23 2025 - 17:01:49 -0700)
>> +
>> +        CPU:   sifive,u74-mc
>> +        Model: Pine64 Star64
>> +        DRAM:  4 GiB
>> +        Core:  160 devices, 29 uclasses, devicetree: board
>> +        WDT:   Not starting watchdog@13070000
>> +        MMC:   mmc@16010000: 0, mmc@16020000: 1
>> +        Loading Environment from SPIFlash...
>> +        SF: Detected gd25lq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
>> +        *** Warning - bad CRC, using default environment
>> +
>> +        StarFive EEPROM format v2
>> +
>> +        --------EEPROM INFO--------
>> +        Vendor : PINE64
>> +        Product full SN: STAR64V1-2310-D004E000-0000xxxx
>> +        data version: 0x2
>> +        PCB revision: 0xc1
>> +        BOM revision: A
>> +        Ethernet MAC0 address: 6c:cf:39:00:xx:xx
>> +        Ethernet MAC1 address: 6c:cf:39:00:xx:xx
>> +        --------EEPROM INFO--------
>> +
>> +        starfive_7110_pcie pcie@9c0000000: Starfive PCIe bus probed.
>> +        In:    serial@10000000
>> +        Out:   serial@10000000
>> +        Err:   serial@10000000
>> +        Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
>> +        starting USB...
>> +        Register 2000820 NbrPorts 2
>> +        Starting the controller
>> +        USB XHCI 1.00
>> +        Bus usb@0: 4 USB Device(s) found
>> +               scanning usb for storage devices... 0 Storage Device(s) found
>> +        Working FDT set to ff717fe0
>> +        Hit any key to stop autoboot: 2 1 0
>> +
>> +    (enter)
>> +        StarFive #
>> +
>> +Update QSPI Flash using U-Boot console
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +With UART serial USB adapter and tio serial terminal::
>> +
>> +    tio /dev/ttyUSB0 -o 1
>> +        tio 3.9
>> +        Press ctrl-t q to quit
>> +        Connected to /dev/ttyUSB0
>> +
>> +    (enter)
>> +        StarFive #
>>
>>     sf probe
>> -    load mmc 1:1 $kernel_addr_r u-boot-spl.bin.normal.out
>> -    sf update $kernel_addr_r 0 $filesize
>> -    load mmc 1:1 $kernel_addr_r u-boot.itb
>> -    sf update $kernel_addr_r 0x100000 $filesize
>> +        StarFive # sf probe
>> +        SF: Detected gd25lq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
>>
>> -For loading the files from a TFTP server refer to the dhcp and tftpboot
>> -commands.
>> +    loady && sf update $loadaddr 0 $filesize
>> +        StarFive # loady && sf update $loadaddr 0 $filesize
>> +        ## Ready for binary (ymodem) download to 0x82000000 at 115200 bps...
>> +        CCC
>>
>> -After updating U-Boot you may want to erase a saved environment and reboot.
>> +    (Control-t-y)
>> +        Send file with YMODEM
>> +        Enter file name:
>>
>> -.. code-block:: console
>> +    u-boot/spl/u-boot-spl.bin.normal.out
>> +        Sending file 'u-boot/spl/u-boot-spl.bin.normal.out'
>> +        Press any key to abort transfer
>> +        ...|
>> +        Done
>> +        ## Total Size      = 0x00024eb7 = 151223 Bytes
>> +        ## Start Addr      = 0x82000000
>> +        device 0 offset 0x0, size 0x24eb7
>> +        151223 bytes written, 0 bytes skipped in 0.634s, speed 243096 B/s
>> +        StarFive #
>>
>>     env erase
>> -    reset
>> -
>> -Booting from SD-Card
>> ---------------------
>> -
>> -The device boot ROM loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
>> -partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are free
>> -to choose any partition number.
>> -
>> -With the default configuration U-Boot SPL loads the U-Boot FIT image
>> -(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
>> -When formatting it is recommended to use GUID
>> -BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
>> -
>> -Booting from eMMC
>> ------------------
>> -
>> -The device boot ROM tries to load U-Boot SPL (u-boot-spl.bin.normal.out) from
>> -sector 0 of the eMMC's main hardware partition. But this conflicts with GPT
>> -partitioning. Fortunately eMMC can alternatively load U-Boot SPL from a backup
>> -position.
>> -
>> -For U-Boot SPL (u-boot-spl.bin.normal.out) starting at sector 2048 (position
>> -0x100000) write the following bytes to the eMMC device after GPT partitioning:
>> -
>> -======= ========================
>> -Address Bytes
>> -======= ========================
>> -0x0000  40 02 00 00  00 00 10 00
>> -0x0290  40 02 00 00  00 00 10 00
>> -======= ========================
>> -
>> -With the default configuration U-Boot SPL loads the U-Boot FIT image
>> -(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
>> -When formatting it is recommended to use GUID
>> -BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
>> -
>> -Booting from UART
>> ------------------
>> -
>> -The boot ROM supports the X-modem protocol to upload
>> -spl/u-boot-spl.bin.normal.out. U-Boot SPL support loading the FIT image
>> -u-boot.itb via the Y-modem protocol.
>> -
>> -Due to restrictions of the boot ROM not all X-modem implementations are
>> -compatible. The package tio (https://github.com/tio/tio) has been found to be
>> -usable.
>> -
>> -Debug UART
>> -----------
>> -
>> -By default the SBI interface is used for the debug UART. But this only works
>> -in main U-Boot. To enable the debug UART in SPL, too, use the following
>> -settings::
>> -
>> -    CONFIG_DEBUG_UART=y
>> -    CONFIG_DEBUG_UART_NS16550=y
>> -    CONFIG_DEBUG_UART_BASE=0x10000000
>> -    CONFIG_SPL_DEBUG_UART_BASE=0x10000000
>> -    CONFIG_DEBUG_UART_CLOCK=24000000
>> -    CONFIG_DEBUG_UART_SHIFT=2
>> +        StarFive # env erase
>> +        Erasing Environment on SPIFlash... OK
>> +        StarFive #
>> +
>> +    loady && sf update $loadaddr 100000 $filesize
>> +        StarFive # loady $loadaddr && sf update $loadaddr 100000 $filesize
>> +        ## Ready for binary (ymodem) download to 0x82000000 at 115200 bps...
>> +        CCC
>> +
>> +    (Control-t-y)
>> +        Send file with YMODEM
>> +        Enter file name:
>> +
>> +    u-boot/u-boot.itb
>> +        Sending file 'u-boot/u-boot.itb'
>> +        Press any key to abort transfer
>> +        ...|
>> +        Done
>> +        ## Total Size      = 0x002fa5cd = 3122637 Bytes
>> +        ## Start Addr      = 0x82000000
>> +        device 0 offset 0x100000, size 0x2fa5cd
>> +        3122637 bytes written, 0 bytes skipped in 18.137s, speed 176272 B/s
>> +        StarFive #
>> +
>> +Update QSPI Flash from GNU/Linux OS
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +With mtd-utils::
>> +
>> +    cat /proc/mtd
>> +        dev:    size   erasesize  name
>> +        mtd0: 000f0000 00001000 "spl"
>> +        mtd1: 00010000 00001000 "uboot-env"
>> +        mtd2: 00f00000 00001000 "uboot"
>> +
>> +    flashcp --verbose u-boot/spl/u-boot-spl.bin.normal.out /dev/mtd0
>> +        Erasing blocks: 37/37 (100%)
>> +        Writing data: 147k/147k (100%)
>> +        Verifying data: 147k/147k (100%)
>> +
>> +    flashcp --verbose --erase-all /dev/zero /dev/mtd1
>> +        Erasing blocks: 16/16 (100%)
>> +        Writing data: 0k/0k (100%)
>> +        Verifying data: 0k/0k (100%)
>> +
>> +    flashcp --verbose u-boot/u-boot.itb /dev/mtd2
>> +        Erasing blocks: 763/763 (100%)
>> +        Writing data: 3049k/3049k (100%)
>> +        Verifying data: 3049k/3049k (100%)
>> diff --git a/doc/board/starfive/milk-v_mars.rst b/doc/board/starfive/milk-v_mars.rst
>> index ce4539a46f1..0dbc500b734 100644
>> --- a/doc/board/starfive/milk-v_mars.rst
>> +++ b/doc/board/starfive/milk-v_mars.rst
>> @@ -7,38 +7,6 @@ U-Boot for the Milk-V Mars uses the same U-Boot binaries as the VisionFive 2
>> board. In U-Boot SPL the actual board is detected and the device-tree patched
>> accordingly.
>>
>> -Building
>> ---------
>> -
>> -1. Add the RISC-V toolchain to your PATH.
>> -2. Setup ARCH & cross compilation environment variable:
>> -
>> -.. code-block:: none
>> -
>> -   export CROSS_COMPILE=<riscv64 toolchain prefix>
>> -
>> -The M-mode software OpenSBI provides the supervisor binary interface (SBI) and
>> -is responsible for the switch to S-Mode. It is a prerequisite to build U-Boot.
>> -Support for the JH7110 was introduced in OpenSBI 1.2. It is recommended to use
>> -a current release.
>> -
>> -.. code-block:: console
>> -
>> -	git clone https://github.com/riscv/opensbi.git
>> -	cd opensbi
>> -	make PLATFORM=generic FW_TEXT_START=0x40000000 FW_OPTIONS=0
>> -
>> -Now build the U-Boot SPL and U-Boot proper.
>> -
>> -.. code-block:: console
>> -
>> -	cd <U-Boot-dir>
>> -	make starfive_visionfive2_defconfig
>> -	make OPENSBI=$(opensbi_dir)/build/platform/generic/firmware/fw_dynamic.bin
>> -
>> -This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
>> -as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
>> -
>> Device-tree selection
>> ---------------------
>>
>> @@ -57,45 +25,4 @@ environment
>> or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
>> provide a default value.
>>
>> -Preparing the SD-Card
>> ----------------------
>> -
>> -The device firmware loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
>> -partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are free
>> -to choose any partition number.
>> -
>> -With the default configuration U-Boot SPL loads the U-Boot FIT image
>> -(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
>> -When formatting it is recommended to use GUID
>> -BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
>> -
>> -The FIT image (u-boot.itb) is a combination of OpenSBI's fw_dynamic.bin,
>> -u-boot-nodtb.bin and the device tree blob.
>> -
>> -Format the SD card (make sure the disk has GPT, otherwise use gdisk to switch)
>> -
>> -.. code-block:: bash
>> -
>> -	sudo sgdisk --clear \
>> -	  --set-alignment=2 \
>> -	  --new=1:4096:8191 --change-name=1:spl --typecode=1:2E54B353-1271-4842-806F-E436D6AF6985\
>> -	  --new=2:8192:16383 --change-name=2:uboot --typecode=2:BC13C2FF-59E6-4262-A352-B275FD6F7172  \
>> -	  --new=3:16384:1654784 --change-name=3:system --typecode=3:EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 \
>> -	  /dev/sdb
>> -
>> -Copy U-Boot to the SD card
>> -
>> -.. code-block:: bash
>> -
>> -	sudo dd if=u-boot-spl.bin.normal.out of=/dev/sdb1
>> -	sudo dd if=u-boot.itb of=/dev/sdb2
>> -
>> -	sudo mount /dev/sdb3 /mnt/
>> -	sudo cp u-boot-spl.bin.normal.out /mnt/
>> -	sudo cp u-boot.itb /mnt/
>> -	sudo cp Image.gz /mnt/
>> -	sudo cp initramfs.cpio.gz /mnt/
>> -	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
>> -	sudo umount /mnt
>> -
>> .. include:: jh7110_common.rst
>> diff --git a/doc/board/starfive/pine64_star64.rst b/doc/board/starfive/pine64_star64.rst
>> index d1752c452da..78a330be455 100644
>> --- a/doc/board/starfive/pine64_star64.rst
>> +++ b/doc/board/starfive/pine64_star64.rst
>> @@ -7,38 +7,6 @@ U-Boot for the Star64 uses the same U-Boot binaries as the VisionFive 2 board.
>> In U-Boot SPL the actual board is detected and the device-tree patched
>> accordingly.
>>
>> -Building
>> ---------
>> -
>> -1. Add the RISC-V toolchain to your PATH.
>> -2. Setup ARCH & cross compilation environment variable:
>> -
>> -.. code-block:: none
>> -
>> -   export CROSS_COMPILE=<riscv64 toolchain prefix>
>> -
>> -The M-mode software OpenSBI provides the supervisor binary interface (SBI) and
>> -is responsible for the switch to S-Mode. It is a prerequisite to build U-Boot.
>> -Support for the JH7110 was introduced in OpenSBI 1.2. It is recommended to use
>> -a current release.
>> -
>> -.. code-block:: console
>> -
>> -	git clone https://github.com/riscv/opensbi.git
>> -	cd opensbi
>> -	make PLATFORM=generic FW_TEXT_START=0x40000000
>> -
>> -Now build the U-Boot SPL and U-Boot proper.
>> -
>> -.. code-block:: console
>> -
>> -	cd <U-Boot-dir>
>> -	make starfive_visionfive2_defconfig
>> -	make OPENSBI=$(opensbi_dir)/build/platform/generic/firmware/fw_dynamic.bin
>> -
>> -This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
>> -as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
>> -
>> Device-tree selection
>> ---------------------
>>
>> @@ -55,49 +23,6 @@ environment
>> or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
>> provide a default value.
>>
>> -Preparing the SD-Card
>> ----------------------
>> -
>> -The device firmware loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
>> -partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are free
>> -to choose any partition number.
>> -
>> -With the default configuration U-Boot SPL loads the U-Boot FIT image
>> -(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
>> -When formatting it is recommended to use GUID
>> -BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
>> -
>> -The FIT image (u-boot.itb) is a combination of OpenSBI's fw_dynamic.bin,
>> -u-boot-nodtb.bin and the device tree blob.
>> -
>> -Format the SD card (make sure the disk has GPT, otherwise use gdisk to switch)
>> -
>> -.. code-block:: bash
>> -
>> -	sudo sgdisk --clear \
>> -	  --set-alignment=2 \
>> -	  --new=1:4096:8191 --change-name=1:spl --typecode=1:2E54B353-1271-4842-806F-E436D6AF6985\
>> -	  --new=2:8192:16383 --change-name=2:uboot --typecode=2:BC13C2FF-59E6-4262-A352-B275FD6F7172  \
>> -	  --new=3:16384:1654784 --change-name=3:system --typecode=3:EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 \
>> -	  /dev/sdb
>> -
>> -Copy U-Boot to the SD card
>> -
>> -.. code-block:: bash
>> -
>> -	sudo dd if=u-boot-spl.bin.normal.out of=/dev/sdb1
>> -	sudo dd if=u-boot.itb of=/dev/sdb2
>> -
>> -	sudo mount /dev/sdb3 /mnt/
>> -	sudo cp u-boot-spl.bin.normal.out /mnt/
>> -	sudo cp u-boot.itb /mnt/
>> -	sudo cp Image.gz /mnt/
>> -	sudo cp initramfs.cpio.gz /mnt/
>> -	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
>> -	sudo umount /mnt
>> -
>> -.. include:: jh7110_common.rst
>> -
>> Serial Number and MAC address issues
>> ------------------------------------
>>
>> @@ -183,3 +108,5 @@ The MAC addresses may be "set" as follows by writing as a custom config to SPI
>> 	env set eth1addr 6c:cf:39:ce:64:5a
>> 	env save
>> 	reset
>> +
>> +.. include:: jh7110_common.rst
>> diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
>> index 11121a1751a..c92ea16f91b 100644
>> --- a/doc/board/starfive/visionfive2.rst
>> +++ b/doc/board/starfive/visionfive2.rst
>> @@ -3,74 +3,9 @@
>> StarFive VisionFive2
>> ====================
>>
>> -JH7110 RISC-V SoC
>> ------------------
>> -
>> -The JH7110 is 4+1 64-bit RISC-V SoC from StarFive.
>> -
>> The StarFive VisionFive2 development platform is based on JH7110 and capable
>> of running Linux.
>>
>> -Mainline support
>> -----------------
>> -
>> -The support for following drivers are already enabled:
>> -
>> -1. ns16550 UART Driver.
>> -2. StarFive JH7110 clock Driver.
>> -3. StarFive JH7110 reset Driver.
>> -4. Cadence QSPI controller Driver.
>> -5. MMC SPI Driver for MMC/SD support.
>> -6. PLDA PCIE controller driver.
>> -7. On-board VL805 PCIE-USB controller driver.
>> -
>> -Booting from MMC using U-Boot SPL
>> ----------------------------------
>> -
>> -The current U-Boot port is supported in S-mode only and loaded from DRAM.
>> -
>> -A prior stage M-mode firmware/bootloader (e.g OpenSBI) is required to
>> -boot the u-boot.itb in S-mode and provide M-mode runtime services.
>> -
>> -Currently, the u-boot.itb is used as a dynamic of the OpenSBI FW_DYNAMIC
>> -firmware with the latest.
>> -
>> -Building
>> ---------
>> -
>> -1. Add the RISC-V toolchain to your PATH.
>> -2. Setup ARCH & cross compilation environment variable:
>> -
>> -.. code-block:: none
>> -
>> -   export CROSS_COMPILE=<riscv64 toolchain prefix>
>> -
>> -Before building U-Boot SPL, OpenSBI must be built first. OpenSBI can be
>> -cloned and built for JH7110 as below:
>> -
>> -.. code-block:: console
>> -
>> -	git clone https://github.com/riscv/opensbi.git
>> -	cd opensbi
>> -	make PLATFORM=generic FW_TEXT_START=0x40000000 FW_OPTIONS=0
>> -
>> -The VisionFive 2 support for OpenSBI was introduced after the v1.2 release.
>> -
>> -More detailed description of steps required to build FW_DYNAMIC firmware
>> -is beyond the scope of this document. Please refer OpenSBI documenation.
>> -(Note: OpenSBI git repo is at https://github.com/riscv/opensbi.git)
>> -
>> -Now build the U-Boot SPL and U-Boot proper
>> -
>> -.. code-block:: console
>> -
>> -	cd <U-Boot-dir>
>> -	make starfive_visionfive2_defconfig
>> -	make OPENSBI=$(opensbi_dir)/opensbi/build/platform/generic/firmware/fw_dynamic.bin
>> -
>> -This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
>> -as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
>> -
>> Device-tree selection
>> ---------------------
>>
>> @@ -89,388 +24,4 @@ environment
>> or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to provide
>> a default value.
>>
>> -Flashing
>> ---------
>> -
>> -The device firmware loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
>> -partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are free
>> -to choose any partition number.
>> -
>> -With the default configuration U-Boot SPL loads the U-Boot FIT image
>> -(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
>> -When formatting it is recommended to use GUID
>> -BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
>> -
>> -The FIT image (u-boot.itb) is a combination of OpenSBI's fw_dynamic.bin,
>> -u-boot-nodtb.bin and the device tree blob
>> -(jh7110-starfive-visionfive-2-v1.3b.dtb or
>> -jh7110-starfive-visionfive-2-v1.2a.dtb).
>> -
>> -Format the SD card (make sure the disk has GPT, otherwise use gdisk to switch)
>> -
>> -.. code-block:: bash
>> -
>> -	sudo sgdisk --clear \
>> -	  --set-alignment=2 \
>> -	  --new=1:4096:8191 --change-name=1:spl --typecode=1:2E54B353-1271-4842-806F-E436D6AF6985\
>> -	  --new=2:8192:16383 --change-name=2:uboot --typecode=2:BC13C2FF-59E6-4262-A352-B275FD6F7172  \
>> -	  --new=3:16384:1654784 --change-name=3:system --typecode=3:EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 \
>> -	  /dev/sdb
>> -	sudo mkfs.vfat -F32 /dev/sdb3
>> -
>> -Program the SD card
>> -
>> -.. code-block:: bash
>> -
>> -	sudo dd if=u-boot-spl.bin.normal.out of=/dev/sdb1
>> -	sudo dd if=u-boot.itb of=/dev/sdb2
>> -
>> -	sudo mount /dev/sdb3 /mnt/
>> -	sudo cp u-boot-spl.bin.normal.out /mnt/
>> -	sudo cp u-boot.itb /mnt/
>> -	sudo cp Image.gz /mnt/
>> -	sudo cp initramfs.cpio.gz /mnt/
>> -	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
>> -	sudo umount /mnt
>> -
>> .. include:: jh7110_common.rst
>> -
>> -Sample boot log from StarFive VisionFive2 board
>> ------------------------------------------------
>> -
>> -.. code-block:: none
>> -
>> -
>> -	U-Boot SPL 2023.04-rc2-00055-gfc43b9c51a-dirty (Mar 02 2023 - 10:51:39 +0800)
>> -	DDR version: dc2e84f0.
>> -	Trying to boot from MMC2
>> -
>> -	OpenSBI v1.2-80-g4b28afc
>> -	  ____                    _____ ____ _____
>> -	 / __ \                  / ____|  _ \_   _|
>> -	| |  | |_ __   ___ _ __ | (___ | |_) || |
>> -	| |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
>> -	| |__| | |_) |  __/ | | |____) | |_) || |_
>> -	 \____/| .__/ \___|_| |_|_____/|____/_____|
>> -	       | |
>> -	       |_|
>> -
>> -	Platform Name             : StarFive VisionFive 2 v1.3B
>> -	Platform Features         : medeleg
>> -	Platform HART Count       : 5
>> -	Platform IPI Device       : aclint-mswi
>> -	Platform Timer Device     : aclint-mtimer @ 4000000Hz
>> -	Platform Console Device   : uart8250
>> -	Platform HSM Device       : ---
>> -	Platform PMU Device       : ---
>> -	Platform Reboot Device    : ---
>> -	Platform Shutdown Device  : ---
>> -	Platform Suspend Device   : ---
>> -	Firmware Base             : 0x40000000
>> -	Firmware Size             : 264 KB
>> -	Firmware RW Offset        : 0x20000
>> -	Runtime SBI Version       : 1.0
>> -
>> -	Domain0 Name              : root
>> -	Domain0 Boot HART         : 2
>> -	Domain0 HARTs             : 0*,1*,2*,3*,4*
>> -	Domain0 Region00          : 0x0000000002000000-0x000000000200ffff M: (I,R,W) S/U: ()
>> -	Domain0 Region01          : 0x0000000040000000-0x000000004001ffff M: (R,X) S/U: ()
>> -	Domain0 Region02          : 0x0000000040000000-0x000000004007ffff M: (R,W) S/U: ()
>> -	Domain0 Region03          : 0x0000000000000000-0xffffffffffffffff M: (R,W,X) S/U: (R,W,X)
>> -	Domain0 Next Address      : 0x0000000040200000
>> -	Domain0 Next Arg1         : 0x0000000040287970
>> -	Domain0 Next Mode         : S-mode
>> -	Domain0 SysReset          : yes
>> -	Domain0 SysSuspend        : yes
>> -
>> -	Boot HART ID              : 2
>> -	Boot HART Domain          : root
>> -	Boot HART Priv Version    : v1.11
>> -	Boot HART Base ISA        : rv64imafdcbx
>> -	Boot HART ISA Extensions  : none
>> -	Boot HART PMP Count       : 8
>> -	Boot HART PMP Granularity : 4096
>> -	Boot HART PMP Address Bits: 34
>> -	Boot HART MHPM Count      : 2
>> -	Boot HART MIDELEG         : 0x0000000000000222
>> -	Boot HART MEDELEG         : 0x000000000000b109
>> -
>> -
>> -	U-Boot 2023.04-rc2-00055-gfc43b9c51a-dirty (Mar 02 2023 - 10:51:39 +0800)
>> -
>> -	CPU:   rv64imac_zba_zbb
>> -	Model: StarFive VisionFive 2 v1.3B
>> -	DRAM:  8 GiB
>> -	Core:  107 devices, 18 uclasses, devicetree: separate
>> -	MMC:   mmc@16010000: 0, mmc@16020000: 1
>> -	Loading Environment from nowhere... OK
>> -	In:    serial@10000000
>> -	Out:   serial@10000000
>> -	Err:   serial@10000000
>> -	Net:   No ethernet found.
>> -	Working FDT set to ff74a340
>> -	Hit any key to stop autoboot:  0
>> -	StarFive #
>> -	StarFive # version
>> -	U-Boot 2023.04-rc2-00055-gfc43b9c51a-dirty (Mar 02 2023 - 10:51:39 +0800)
>> -
>> -	riscv64-buildroot-linux-gnu-gcc.br_real (Buildroot VF2_515_v1.0.0_rc4) 10.3.0
>> -	GNU ld (GNU Binutils) 2.36.1
>> -	StarFive #
>> -	StarFive # mmc dev 1
>> -	switch to partitions #0, OK
>> -	mmc1 is current device
>> -	StarFive # mmc info
>> -	Device: mmc@16020000
>> -	Manufacturer ID: 9f
>> -	OEM: 5449
>> -	Name: SD64G
>> -	Bus Speed: 50000000
>> -	Mode: SD High Speed (50MHz)
>> -	Rd Block Len: 512
>> -	SD version 3.0
>> -	High Capacity: Yes
>> -	Capacity: 58.3 GiB
>> -	Bus Width: 4-bit
>> -	Erase Group Size: 512 Bytes
>> -	StarFive #
>> -	StarFive # mmc part
>> -
>> -	Partition Map for MMC device 1  --   Partition Type: EFI
>> -
>> -	Part    Start LBA       End LBA         Name
>> -			Attributes
>> -			Type GUID
>> -			Partition GUID
>> -	1     0x00001000      0x00001fff      "spl"
>> -			attrs:  0x0000000000000000
>> -			type:   2e54b353-1271-4842-806f-e436d6af6985
>> -					(2e54b353-1271-4842-806f-e436d6af6985)
>> -			guid:   d5ee2056-3020-475b-9a33-25b4257c9f12
>> -	2     0x00002000      0x00003fff      "uboot"
>> -			attrs:  0x0000000000000000
>> -			type:   bc13c2ff-59e6-4262-a352-b275fd6f7172
>> -					(bc13c2ff-59e6-4262-a352-b275fd6f7172)
>> -			guid:   379ab7fe-fd0c-4149-b758-960c1cbfc0cc
>> -	3     0x00004000      0x00194000      "system"
>> -			attrs:  0x0000000000000000
>> -			type:   ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
>> -					(data)
>> -			guid:   539a6df9-4655-4953-8541-733ca36eb1db
>> -	StarFive #
>> -	StarFive # fatls mmc 1:3
>> -	6429424   Image.gz
>> -	717705   u-boot.itb
>> -	125437   u-boot-spl.bin.normal.out
>> -	152848495   initramfs.cpio.gz
>> -		11285   jh7110-starfive-visionfive-2-v1.3b.dtb
>> -
>> -	5 file(s), 0 dir(s)
>> -
>> -	StarFive # fatload mmc 1:3 ${kernel_addr_r} Image.gz
>> -	6429424 bytes read in 394 ms (15.6 MiB/s)
>> -	StarFive # fatload mmc 1:3 ${fdt_addr_r} jh7110-starfive-visionfive-2.dtb
>> -	11285 bytes read in 5 ms (2.2 MiB/s)
>> -	StarFive # fatload mmc 1:3 ${ramdisk_addr_r} initramfs.cpio.gz
>> -	152848495 bytes read in 9271 ms (15.7 MiB/s)
>> -	StarFive # booti ${kernel_addr_r} ${ramdisk_addr_r}:${filesize} ${fdt_addr_r}
>> -	Uncompressing Kernel Image
>> -	## Flattened Device Tree blob at 46000000
>> -	Booting using the fdt blob at 0x46000000
>> -	Working FDT set to 46000000
>> -	Loading Ramdisk to f5579000, end fe73d86f ... OK
>> -	Loading Device Tree to 00000000f5573000, end 00000000f5578c14 ... OK
>> -	Working FDT set to f5573000
>> -
>> -	Starting kernel ...
>> -
>> -
>> -	] Linux version 6.2.0-starfive-00026-g11934a315b67 (wyh@wyh-VirtualBox) (riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, GNU ld (GNU Binutils for Ubuntu) 2.30) #1 SMP Thu Mar  2 14:51:36 CST 2023
>> -	[    0.000000] OF: fdt: Ignoring memory range 0x40000000 - 0x40200000
>> -	[    0.000000] Machine model: StarFive VisionFive 2 v1.3B
>> -	[    0.000000] efi: UEFI not found.
>> -	[    0.000000] Zone ranges:
>> -	[    0.000000]   DMA32    [mem 0x0000000040200000-0x00000000ffffffff]
>> -	[    0.000000]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
>> -	[    0.000000] Movable zone start for each node
>> -	[    0.000000] Early memory node ranges
>> -	[    0.000000]   node   0: [mem 0x0000000040200000-0x000000013fffffff]
>> -	[    0.000000] Initmem setup node 0 [mem 0x0000000040200000-0x000000013fffffff]
>> -	[    0.000000] On node 0, zone DMA32: 512 pages in unavailable ranges
>> -	[    0.000000] SBI specification v1.0 detected
>> -	[    0.000000] SBI implementation ID=0x1 Version=0x10002
>> -	[    0.000000] SBI TIME extension detected
>> -	[    0.000000] SBI IPI extension detected
>> -	[    0.000000] SBI RFENCE extension detected
>> -	[    0.000000] SBI HSM extension detected
>> -	[    0.000000] CPU with hartid=0 is not available
>> -	[    0.000000] CPU with hartid=0 is not available
>> -	[    0.000000] CPU with hartid=0 is not available
>> -	[    0.000000] riscv: base ISA extensions acdfim
>> -	[    0.000000] riscv: ELF capabilities acdfim
>> -	[    0.000000] percpu: Embedded 18 pages/cpu s35960 r8192 d29576 u73728
>> -	[    0.000000] pcpu-alloc: s35960 r8192 d29576 u73728 alloc=18*4096
>> -	[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
>> -	[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1031688
>> -	[    0.000000] Kernel command line: console=ttyS0,115200 debug rootwait earlycon=sbi
>> -	[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
>> -	[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
>> -	[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
>> -	[    0.000000] software IO TLB: area num 4.
>> -	[    0.000000] software IO TLB: mapped [mem 0x00000000f1573000-0x00000000f5573000] (64MB)
>> -	[    0.000000] Virtual kernel memory layout:
>> -	[    0.000000]       fixmap : 0xffffffc6fee00000 - 0xffffffc6ff000000   (2048 kB)
>> -	[    0.000000]       pci io : 0xffffffc6ff000000 - 0xffffffc700000000   (  16 MB)
>> -	[    0.000000]      vmemmap : 0xffffffc700000000 - 0xffffffc800000000   (4096 MB)
>> -	[    0.000000]      vmalloc : 0xffffffc800000000 - 0xffffffd800000000   (  64 GB)
>> -	[    0.000000]      modules : 0xffffffff0136a000 - 0xffffffff80000000   (2028 MB)
>> -	[    0.000000]       lowmem : 0xffffffd800000000 - 0xffffffd8ffe00000   (4094 MB)
>> -	[    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (2047 MB)
>> -	[    0.000000] Memory: 3867604K/4192256K available (8012K kernel code, 4919K rwdata, 4096K rodata, 2190K init, 476K bss, 324652K reserved, 0K cma-reserved)
>> -	[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
>> -	[    0.000000] rcu: Hierarchical RCU implementation.
>> -	[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
>> -	[    0.000000] rcu:     RCU debug extended QS entry/exit.
>> -	[    0.000000]  Tracing variant of Tasks RCU enabled.
>> -	[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
>> -	[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
>> -	[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>> -	[    0.000000] CPU with hartid=0 is not available
>> -	[    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/interrupt-controller
>> -	[    0.000000] riscv-intc: 64 local interrupts mapped
>> -	[    0.000000] plic: interrupt-controller@c000000: mapped 136 interrupts with 4 handlers for 9 contexts.
>> -	[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
>> -	[    0.000000] riscv-timer: riscv_timer_init_dt: Registering clocksource cpuid [0] hartid [4]
>> -	[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0x1d854df40, max_idle_ns: 881590404240 ns
>> -	[    0.000003] sched_clock: 64 bits at 4MHz, resolution 250ns, wraps every 2199023255500ns
>> -	[    0.000437] Console: colour dummy device 80x25
>> -	[    0.000568] Calibrating delay loop (skipped), value calculated using timer frequency.. 8.00 BogoMIPS (lpj=16000)
>> -	[    0.000602] pid_max: default: 32768 minimum: 301
>> -	[    0.000752] LSM: initializing lsm=capability,integrity
>> -	[    0.001071] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
>> -	[    0.001189] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
>> -	[    0.004201] CPU node for /cpus/cpu@0 exist but the possible cpu range is :0-3
>> -	[    0.007426] cblist_init_generic: Setting adjustable number of callback queues.
>> -	[    0.007457] cblist_init_generic: Setting shift to 2 and lim to 1.
>> -	[    0.007875] riscv: ELF compat mode unsupported
>> -	[    0.007902] ASID allocator disabled (0 bits)
>> -	[    0.008405] rcu: Hierarchical SRCU implementation.
>> -	[    0.008426] rcu:     Max phase no-delay instances is 1000.
>> -	[    0.009247] EFI services will not be available.
>> -	[    0.010738] smp: Bringing up secondary CPUs ...
>> -	[    0.018358] smp: Brought up 1 node, 4 CPUs
>> -	[    0.021776] devtmpfs: initialized
>> -	[    0.027337] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
>> -	[    0.027389] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
>> -	[    0.027888] pinctrl core: initialized pinctrl subsystem
>> -	[    0.029881] NET: Registered PF_NETLINK/PF_ROUTE protocol family
>> -	[    0.030401] audit: initializing netlink subsys (disabled)
>> -	[    0.031041] audit: type=2000 audit(0.028:1): state=initialized audit_enabled=0 res=1
>> -	[    0.031943] cpuidle: using governor menu
>> -	[    0.043011] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
>> -	[    0.043033] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
>> -	[    0.044943] iommu: Default domain type: Translated
>> -	[    0.044965] iommu: DMA domain TLB invalidation policy: strict mode
>> -	[    0.046089] SCSI subsystem initialized
>> -	[    0.046733] libata version 3.00 loaded.
>> -	[    0.047231] usbcore: registered new interface driver usbfs
>> -	[    0.047315] usbcore: registered new interface driver hub
>> -	[    0.047420] usbcore: registered new device driver usb
>> -	[    0.049770] vgaarb: loaded
>> -	[    0.050277] clocksource: Switched to clocksource riscv_clocksource
>> -	[    0.084690] NET: Registered PF_INET protocol family
>> -	[    0.085561] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
>> -	[    0.093010] tcp_listen_portaddr_hash hash table entries: 2048 (order: 4, 65536 bytes, linear)
>> -	[    0.093152] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
>> -	[    0.093224] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
>> -	[    0.093821] TCP bind hash table entries: 32768 (order: 9, 2097152 bytes, linear)
>> -	[    0.117880] TCP: Hash tables configured (established 32768 bind 32768)
>> -	[    0.118500] UDP hash table entries: 2048 (order: 5, 196608 bytes, linear)
>> -	[    0.118881] UDP-Lite hash table entries: 2048 (order: 5, 196608 bytes, linear)
>> -	[    0.119675] NET: Registered PF_UNIX/PF_LOCAL protocol family
>> -	[    0.121749] RPC: Registered named UNIX socket transport module.
>> -	[    0.121776] RPC: Registered udp transport module.
>> -	[    0.121784] RPC: Registered tcp transport module.
>> -	[    0.121791] RPC: Registered tcp NFSv4.1 backchannel transport module.
>> -	[    0.121816] PCI: CLS 0 bytes, default 64
>> -	[    0.124101] Unpacking initramfs...
>> -	[    0.125468] workingset: timestamp_bits=46 max_order=20 bucket_order=0
>> -	[    0.128372] NFS: Registering the id_resolver key type
>> -	[    0.128498] Key type id_resolver registered
>> -	[    0.128525] Key type id_legacy registered
>> -	[    0.128625] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
>> -	[    0.128649] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
>> -	[    0.129358] 9p: Installing v9fs 9p2000 file system support
>> -	[    0.130179] NET: Registered PF_ALG protocol family
>> -	[    0.130499] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
>> -	[    0.130544] io scheduler mq-deadline registered
>> -	[    0.130556] io scheduler kyber registered
>> -	[    0.416754] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>> -	[    0.420857] SuperH (H)SCI(F) driver initialized
>> -	[    0.443735] loop: module loaded
>> -	[    0.448605] e1000e: Intel(R) PRO/1000 Network Driver
>> -	[    0.448627] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
>> -	[    0.450716] usbcore: registered new interface driver uas
>> -	[    0.450832] usbcore: registered new interface driver usb-storage
>> -	[    0.451638] mousedev: PS/2 mouse device common for all mice
>> -	[    0.453465] sdhci: Secure Digital Host Controller Interface driver
>> -	[    0.453487] sdhci: Copyright(c) Pierre Ossman
>> -	[    0.453584] sdhci-pltfm: SDHCI platform and OF driver helper
>> -	[    0.454140] usbcore: registered new interface driver usbhid
>> -	[    0.454174] usbhid: USB HID core driver
>> -	[    0.454833] riscv-pmu-sbi: SBI PMU extension is available
>> -	[    0.454920] riscv-pmu-sbi: 16 firmware and 4 hardware counters
>> -	[    0.454942] riscv-pmu-sbi: Perf sampling/filtering is not supported as sscof extension is not available
>> -	[    0.457071] NET: Registered PF_INET6 protocol family
>> -	[    0.460627] Segment Routing with IPv6
>> -	[    0.460821] In-situ OAM (IOAM) with IPv6
>> -	[    0.461005] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
>> -	[    0.462712] NET: Registered PF_PACKET protocol family
>> -	[    0.462933] 9pnet: Installing 9P2000 support
>> -	[    0.463141] Key type dns_resolver registered
>> -	[    0.463168] start plist test
>> -	[    0.469261] end plist test
>> -	[    0.506774] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
>> -	[    0.553683] gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
>> -	[    0.554741] starfive-jh7110-sys-pinctrl 13040000.pinctrl: StarFive GPIO chip registered 64 GPIOs
>> -	[    0.555900] gpio gpiochip1: Static allocation of GPIO base is deprecated, use dynamic allocation.
>> -	[    0.556772] starfive-jh7110-aon-pinctrl 17020000.pinctrl: StarFive GPIO chip registered 4 GPIOs
>> -	[    0.559454] printk: console [ttyS0] disabled
>> -	[    0.579948] 10000000.serial: ttyS0 at MMIO 0x10000000 (irq = 3, base_baud = 1500000) is a 16550A
>> -	[    0.580082] printk: console [ttyS0] enabled
>> -	[   13.642680] Freeing initrd memory: 149264K
>> -	[   13.651051] Freeing unused kernel image (initmem) memory: 2188K
>> -	[   13.666431] Run /init as init process
>> -	[   13.670116]   with arguments:
>> -	[   13.673168]     /init
>> -	[   13.675488]   with environment:
>> -	[   13.678668]     HOME=/
>> -	[   13.681038]     TERM=linux
>> -	Starting syslogd: OK
>> -	Starting klogd: OK
>> -	Running sysctl: OK
>> -	Populating /dev using udev: [   14.145944] udevd[93]: starting version 3.2.10
>> -	[   15.214287] random: crng init done
>> -	[   15.240816] udevd[94]: starting eudev-3.2.10
>> -	done
>> -	Saving random seed: OK
>> -	Starting system message bus: dbus[122]: Unknown username "pulse" in message bus configuration file
>> -	done
>> -	Starting rpcbind: OK
>> -	Starting iptables: OK
>> -	Starting bluetoothd: OK
>> -	Starting network: Waiting for interface eth0 to appear............... timeout!
>> -	run-parts: /etc/network/if-pre-up.d/wait_iface: exit status 1
>> -	FAIL
>> -	Starting dropbear sshd: OK
>> -	Starting NFS statd: OK
>> -	Starting NFS services: OK
>> -	Starting NFS daemon: rpc.nfsd: Unable to access /proc/fs/nfsd errno 2 (No such file or directory).
>> -	Please try, as root, 'mount -t nfsd nfsd /proc/fs/nfsd' and then restart rpc.nfsd to correct the problem
>> -	FAIL
>> -	Starting NFS mountd: OK
>> -	Starting DHCP server: FAIL
>> -
>> -	Welcome to Buildroot
>> -	buildroot login:
>>
>> base-commit: 69cc92d6869b8ff4591e5b8850872da34934bab9
> 

-E
