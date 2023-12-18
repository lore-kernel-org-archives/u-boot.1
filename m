Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAFFC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 09:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A644087DC2;
	Mon, 18 Dec 2023 10:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z78qqLeZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2782D87DDB; Mon, 18 Dec 2023 10:40:53 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2446987D5D
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BI9eX7m029660;
 Mon, 18 Dec 2023 03:40:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702892433;
 bh=UsbFMlPO/z9rjEiz6jGSYqDIPEeFRUdmGD1BjYHTtCU=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=Z78qqLeZqElKwE1dnY99HT04xtHFnsgjDjXSU5x2naCJx+e6mU40HxnCN7mGhULjG
 U3178FmlbBEnuUxouOBoeZe8xgD3+dj/hNiksEY/97rHgKNzVESchbyAxdfbjo5qFU
 wJ5yBBvsSzFXXJdRoaAYoFSXIMry5/ziymhMOM6g=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BI9eXTx016929
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Dec 2023 03:40:33 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Dec 2023 03:40:32 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Dec 2023 03:40:32 -0600
Received: from [10.249.128.104] ([10.249.128.104])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BI9eMK9098702;
 Mon, 18 Dec 2023 03:40:23 -0600
Message-ID: <4cc59965-e7bc-4138-a73a-260036bc3523@ti.com>
Date: Mon, 18 Dec 2023 15:10:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
Content-Language: en-US
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "jh80.chung@samsung.com"
 <jh80.chung@samsung.com>, "ralph.siemsen@linaro.org"
 <ralph.siemsen@linaro.org>, "nm@ti.com" <nm@ti.com>, "u-kumar1@ti.com"
 <u-kumar1@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "n-francis@ti.com" <n-francis@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "afd@ti.com" <afd@ti.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "lukma@denx.de" <lukma@denx.de>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>, "m-chawdhry@ti.com"
 <m-chawdhry@ti.com>, "j-choudhary@ti.com" <j-choudhary@ti.com>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "sinthu.raja@mistralsolutions.com" <sinthu.raja@mistralsolutions.com>,
 "sabiya.d@ti.com" <sabiya.d@ti.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "bb@ti.com" <bb@ti.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>
References: <20231206123753.1486031-1-a-nandan@ti.com>
 <51eeab25314144926eaefaa2e83353ffec9309fe.camel@toradex.com>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <51eeab25314144926eaefaa2e83353ffec9309fe.camel@toradex.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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


On 14/12/23 23:13, Marcel Ziswiler wrote:
> Hi Apurva
>
> Thanks!
>
> On Wed, 2023-12-06 at 18:07 +0530, Apurva Nandan wrote:
>> Hello Everyone!
>>
>> This series will introduce basic support (SD and UART) support for Texas
>> Instruments J784S4 EVM.
> For the whole series:
>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> However, one thing I noticed is that with upstream TF-A I do get the following errors:
>
> NOTICE:  BL31: v2.10.0  (release):v2.10.0-76-g02091541d
> NOTICE:  BL31: Built : 18:13:08, Dec 14 2023
> ERROR:   Failed to get response (-19)
> ERROR:   Transfer send failed (-19)
> ERROR:   Unable to query firmware capabilities (-19)
>
> While with latest TF-A from downstream TI BSP (both 9.0 and 9.1 use the same versin) I do not get any errors:
>
> NOTICE:  BL31: v2.9(release):v2.9.0-614-gd7a7135d3
> NOTICE:  BL31: Built : 18:40:38, Dec 14 2023
>
> Any idea?
>
> Cheers
>
> Marcel
thanks for pointing it out, I am looking into the bug, and will be fixed 
in next re-roll.
>> The J784S4 SoC device tree patches are taken from kernel patch submissions
>> and will be updated as they are accepted and merged to the kernel tree.
>> All other patches are specific to SPL and u-boot and do not have
>> dependency on other trees. Appreciate a review for acceptance to u-boot
>> tree.
>>
>> Here are some of the salient features of the J784S4 automotive grade
>> application processor:
>>
>> The J784S4 SoC belongs to the K3 Multicore SoC architecture
>> platform, providing advanced system integration in automotive,
>> ADAS and industrial applications requiring AI at the network edge.
>> This SoC extends the K3 Jacinto 7 family of SoCs with focus on
>> raising performance and integration while providing interfaces,
>> memory architecture and compute performance for multi-sensor, high
>> concurrency applications.
>>
>> Some highlights of this SoC are:
>> * Up to 8 Cortex-A72s, four clusters of lockstep capable dual Cortex-R5F MCUs,
>>    4 C7x floating point vector DSPs with Matrix Multiply Accelerator(MMA) for
>>    deep learning and CNN.
>> * 3D GPU: Automotive grade IMG BXS-4-64 MC1
>> * Vision Processing Accelerator (VPAC) with image signal processor and Depth
>>    and Motion Processing Accelerator (DMPAC)
>> * Three CSI2.0 4L RX plus two CSI2.0 4L TX, two DSI Tx, one eDP/DP and one
>>    DPI interface.
>> * Integrated gigabit ethernet switch, up to 8 ports (TDA4VH), two ports
>>    support 10Gb USXGMII; Two 4 lane PCIe-GEN3 controllers, USB3.0 Dual-role
>>    device subsystems, Up to 20 MCANs, among other peripherals.
>>
>> See J784S4 Technical Reference Manual (SPRUJ52 - JUNE 2022)
>> for further details: http://www.ti.com/lit/zip/spruj52
>>
>> In addtion, the J784S4 EVM board is designed for TI J784S4 SoC. It
>> supports the following interfaces:
>> * 32 GB DDR4 RAM
>> * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
>> * x1 Input Audio Jack, x1 Output Audio Jack
>> * x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
>> * x2 4L PCIe connector
>> * x1 UHS-1 capable micro-SD card slot
>> * 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
>>    UFS flash.
>> * x6 UART through UART-USB bridge
>> * XDS110 for onboard JTAG debug using USB
>> * Temperature sensors, user push buttons and LEDs
>> * 40-pin User Expansion Connector
>> * x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
>> * x1 15-pin CSI header
>> * x6 MCAN instances
>>
>> Schematics: https://www.ti.com/lit/zip/sprr458
>>
>> eMMC UDA moode bootlog:
>> https://gist.githubusercontent.com/apurvanandan1997/3cffada252d50a8aa0c00a91f1f2f856/raw/
>>
>> Changes in v6:
>> 1) Move bootph-all of memory node to u-boot.dtsi
>> 2) Used a while loop for DRAM controller init, instead of hard-coding for 4 DRAM
>> 3) Fixed build error by adding board/ti/j784s4/Kconfig
>> 4) Trimmed out j784s4_evm.h
>> 5) Fixed checkpatch warnings
>>
>> Link to v5:
>> https://patchwork.ozlabs.org/project/uboot/cover/20231130115552.3580995-1-a-nandan@ti.com/
>>
>> Changes in v5:
>> 1) Incorporated Andrew Davis' "Move R5 specific code into new r5/ directory" and
>>     "Move board selection to mach-k3" series changes.
>> 2) Incorporated Neha Francis' "Move to using templated FITs" series changes.
>> 3) Synced device tree files with Linux v6.7-rc1
>> 4) Changed ti_mmc to mmc1 target from bootstd
>> 5) Updated doc based on review comments
>> 6) Removed remoteproc support from the series
>> 7) Splitted board files patch into smaller patches
>> 8) Trimmed j784s4.env to necessary variables
>> 9) Used fdtdec_setup_mem_size_base fdtdec_setup_memory_banksize in evm.c
>> 10) Trimmed down evm.c to essential header files.
>> 11) Switched to multi-dtb fit compilation with config fragments
>>
>> Link to v4:
>> https://lore.kernel.org/u-boot/20231001165545.494212-1-a-nandan@ti.com/
>>
>> Changes in v4:
>> 1) Cleaned up Copyright and SPDX identifiers
>> 2) Synced the device trees to Linux v6.6-rc1 tag
>> 3) Added cleanup patch for sorting SoC JTAG ID entries
>> 4) Removed EEPROM board detect from evm.c and added am69 config fragments
>> 5) Updated MAINTAINERS files and commit messages
>> 6) Removed struct renaming in ti_k3_r5f_rproc driver
>>
>> Link to v3:
>> https://lore.kernel.org/u-boot/20230908110551.861575-1-a-nandan@ti.com/
>>
>> Changes in v3:
>> 1) Added AM69 SK support in the series
>> 2) Switched from distroboot to bootstd support
>> 3) Added remoteproc support for J784S4
>> 4) Added documentation for both SoCs
>> 5) Added binman support
>> 6) Removed unnecessarry nodes from r5-evm.dts and evm-u-boot.dtsi
>> 7) Added HS device support
>> 8) Added env file for environement variables
>> 9) Removed ti-serdes-mux bindings
>> 10) Cleaned up all files and synced with latest
>> 11) Addressed all previous review comments
>>
>> Note: The base dts files have been sync from next-20230905 linux tag as per review comment received
>> on previous re-roll:
>> https://lore.kernel.org/u-boot/20230321155227.GV8135@bill-the-cat/
>>
>> Link to v2:
>> https://lore.kernel.org/u-boot/20230321141028.24456-1-hnagalla@ti.com/
>>
>> Changes in v2:
>> - Refactored environement scripts to 'j784s4.env' and removed scripts not
>>    needed for basic board bootup.
>> - Imported the J7874S4 basic device tree files from v6.2 linux kernel.
>> - Moved j784s4 clock definitions and clock data into one patch/commit.
>> - coalesce board commits into one commit.
>>
>> Apurva Nandan (14):
>>    arm: dts: Introduce j784s4 dts from linux kernel
>>    arm: mach-k3: Add basic support for J784S4 SoC definition
>>    arm: mach-k3: Sort SoC JTAG_ID entries
>>    soc: ti: k3-socinfo: Add entry for J784S4 SoC
>>    arm: mach-k3: j784s4: Add clk and power support
>>    drivers: dma: Add support for J784S4 SoC
>>    board: ti: j784s4: Add board support for J784S4 EVM
>>    board: ti: j748s4: Add board config yaml files
>>    board: ti: j784s4: Add boot environment variables
>>    arm: dts: Introduce j784s4 u-boot dts files
>>    arm: dts: Add bootph-all for memory node
>>    configs: j784s4_evm: Add defconfig for j784s4 evm board
>>    doc: board: ti: k3: Add J784S4 EVM and AM69 SK documentation
>>    board: ti: j784s4: Add MAINTAINERS file
>>
>> Dasnavis Sabiya (3):
>>    arm: dts: Introduce am69-sk dts from linux kernel
>>    arm: dts: Introduce am69-sk u-boot dts files
>>    configs: Add am69_sk_* defconfig fragments
>>
>>   arch/arm/dts/Makefile                         |    4 +
>>   arch/arm/dts/k3-am69-r5-sk.dts                |  105 +
>>   arch/arm/dts/k3-am69-sk-u-boot.dtsi           |   31 +
>>   arch/arm/dts/k3-am69-sk.dts                   |  900 ++
>>   arch/arm/dts/k3-j784s4-binman.dtsi            |  435 +
>>   arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi  | 8757 ++++++++++++++++
>>   arch/arm/dts/k3-j784s4-ddr.dtsi               | 8858 +++++++++++++++++
>>   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |   31 +
>>   arch/arm/dts/k3-j784s4-evm.dts                |  981 ++
>>   arch/arm/dts/k3-j784s4-main.dtsi              | 2068 ++++
>>   arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi        |  743 ++
>>   arch/arm/dts/k3-j784s4-r5-evm.dts             |  105 +
>>   arch/arm/dts/k3-j784s4-thermal.dtsi           |  101 +
>>   arch/arm/dts/k3-j784s4.dtsi                   |  294 +
>>   arch/arm/mach-k3/Kconfig                      |   17 +-
>>   arch/arm/mach-k3/Makefile                     |    2 +
>>   arch/arm/mach-k3/arm64-mmu.c                  |   52 +
>>   arch/arm/mach-k3/include/mach/hardware.h      |   13 +-
>>   .../mach-k3/include/mach/j784s4_hardware.h    |   60 +
>>   arch/arm/mach-k3/include/mach/j784s4_spl.h    |   47 +
>>   arch/arm/mach-k3/include/mach/spl.h           |    4 +
>>   arch/arm/mach-k3/j784s4/Kconfig               |   35 +
>>   arch/arm/mach-k3/j784s4_fdt.c                 |   15 +
>>   arch/arm/mach-k3/j784s4_init.c                |  335 +
>>   arch/arm/mach-k3/r5/Makefile                  |    1 +
>>   arch/arm/mach-k3/r5/j784s4/Makefile           |    7 +
>>   arch/arm/mach-k3/r5/j784s4/clk-data.c         |  428 +
>>   arch/arm/mach-k3/r5/j784s4/dev-data.c         |   98 +
>>   board/ti/j784s4/Kconfig                       |   37 +
>>   board/ti/j784s4/MAINTAINERS                   |   25 +
>>   board/ti/j784s4/Makefile                      |    7 +
>>   board/ti/j784s4/board-cfg.yaml                |   37 +
>>   board/ti/j784s4/evm.c                         |   38 +
>>   board/ti/j784s4/j784s4.env                    |   18 +
>>   board/ti/j784s4/pm-cfg.yaml                   |   13 +
>>   board/ti/j784s4/rm-cfg.yaml                   | 3058 ++++++
>>   board/ti/j784s4/sec-cfg.yaml                  |  380 +
>>   board/ti/j784s4/tifs-rm-cfg.yaml              | 2656 +++++
>>   configs/am69_sk_a72.config                    |    3 +
>>   configs/am69_sk_r5.config                     |    3 +
>>   configs/j784s4_evm_a72_defconfig              |  180 +
>>   configs/j784s4_evm_r5_defconfig               |  163 +
>>   doc/board/ti/j784s4_evm.rst                   |  303 +
>>   doc/board/ti/k3.rst                           |    1 +
>>   drivers/clk/ti/clk-k3.c                       |    6 +
>>   drivers/dma/ti/Makefile                       |    1 +
>>   drivers/dma/ti/k3-psil-j784s4.c               |  166 +
>>   drivers/dma/ti/k3-psil-priv.h                 |    1 +
>>   drivers/dma/ti/k3-psil.c                      |    2 +
>>   drivers/firmware/ti_sci_static_data.h         |   34 +
>>   drivers/power/domain/ti-power-domain.c        |    6 +
>>   drivers/ram/Kconfig                           |    2 +-
>>   drivers/soc/soc_ti_k3.c                       |    3 +
>>   include/configs/j784s4_evm.h                  |   15 +
>>   include/k3-clk.h                              |    1 +
>>   include/k3-dev.h                              |    1 +
>>   56 files changed, 31675 insertions(+), 12 deletions(-)
>>   create mode 100644 arch/arm/dts/k3-am69-r5-sk.dts
>>   create mode 100644 arch/arm/dts/k3-am69-sk-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/k3-am69-sk.dts
>>   create mode 100644 arch/arm/dts/k3-j784s4-binman.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-ddr.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-evm.dts
>>   create mode 100644 arch/arm/dts/k3-j784s4-main.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-r5-evm.dts
>>   create mode 100644 arch/arm/dts/k3-j784s4-thermal.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4.dtsi
>>   create mode 100644 arch/arm/mach-k3/include/mach/j784s4_hardware.h
>>   create mode 100644 arch/arm/mach-k3/include/mach/j784s4_spl.h
>>   create mode 100644 arch/arm/mach-k3/j784s4/Kconfig
>>   create mode 100644 arch/arm/mach-k3/j784s4_fdt.c
>>   create mode 100644 arch/arm/mach-k3/j784s4_init.c
>>   create mode 100644 arch/arm/mach-k3/r5/j784s4/Makefile
>>   create mode 100644 arch/arm/mach-k3/r5/j784s4/clk-data.c
>>   create mode 100644 arch/arm/mach-k3/r5/j784s4/dev-data.c
>>   create mode 100644 board/ti/j784s4/Kconfig
>>   create mode 100644 board/ti/j784s4/MAINTAINERS
>>   create mode 100644 board/ti/j784s4/Makefile
>>   create mode 100644 board/ti/j784s4/board-cfg.yaml
>>   create mode 100644 board/ti/j784s4/evm.c
>>   create mode 100644 board/ti/j784s4/j784s4.env
>>   create mode 100644 board/ti/j784s4/pm-cfg.yaml
>>   create mode 100644 board/ti/j784s4/rm-cfg.yaml
>>   create mode 100644 board/ti/j784s4/sec-cfg.yaml
>>   create mode 100644 board/ti/j784s4/tifs-rm-cfg.yaml
>>   create mode 100644 configs/am69_sk_a72.config
>>   create mode 100644 configs/am69_sk_r5.config
>>   create mode 100644 configs/j784s4_evm_a72_defconfig
>>   create mode 100644 configs/j784s4_evm_r5_defconfig
>>   create mode 100644 doc/board/ti/j784s4_evm.rst
>>   create mode 100644 drivers/dma/ti/k3-psil-j784s4.c
>>   create mode 100644 include/configs/j784s4_evm.h

-- 
Thanks and regards,
Apurva Nandan,
Texas Instruments India.

