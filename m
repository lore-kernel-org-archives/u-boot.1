Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC545C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F48B8809D;
	Wed, 28 Feb 2024 12:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SjkfwG/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA0288091; Wed, 28 Feb 2024 12:30:16 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B682B88081
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 12:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41SBTgSU063518;
 Wed, 28 Feb 2024 05:29:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709119782;
 bh=qEe47XSVfU3WGMgKRGtzgUC9wI8Soq/YINfphkBsjvM=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=SjkfwG/uLDVmtWi6JFlQNKxJcT6iSDwrvbRV6W6AirYze7hWOdc031J99ugjX8568
 n8t9u/B611hN37/Go/rKEngo2ZeDGww74MQyfmjGRdC651iWIGcM5pfG9ZF5ZEnEXi
 GpO2VahZ8MaaQLRVumlNEpsXZplsGwIa5WB7vhPk=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41SBTgcO119155
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Feb 2024 05:29:42 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 05:29:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 05:29:41 -0600
Received: from [10.24.68.115] (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41SBTTSg108463; 
 Wed, 28 Feb 2024 05:29:30 -0600
Message-ID: <52792992-332d-455f-a5c4-abbb3f358073@ti.com>
Date: Wed, 28 Feb 2024 16:59:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/15] Introduce initial TI's J784S4 and AM69 support
Content-Language: en-US
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "seanga2@gmail.com"
 <seanga2@gmail.com>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "afd@ti.com" <afd@ti.com>,
 "christianshewitt@gmail.com" <christianshewitt@gmail.com>,
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>,
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>,
 "vigneshr@ti.com" <vigneshr@ti.com>,
 "j-choudhary@ti.com" <j-choudhary@ti.com>, "sumit.garg@linaro.org"
 <sumit.garg@linaro.org>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>,
 "naoki@radxa.com" <naoki@radxa.com>, "bb@ti.com" <bb@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "andre.przywara@arm.com" <andre.przywara@arm.com>,
 "clamor95@gmail.com" <clamor95@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>,
 "n-jain1@ti.com" <n-jain1@ti.com>, "b-kapoor@ti.com" <b-kapoor@ti.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>, "kever.yang@rock-chips.com"
 <kever.yang@rock-chips.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "n-francis@ti.com" <n-francis@ti.com>, "christian.gmeiner@gmail.com"
 <christian.gmeiner@gmail.com>, "mr.bossman075@gmail.com"
 <mr.bossman075@gmail.com>, "marex@denx.de" <marex@denx.de>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "lukma@denx.de" <lukma@denx.de>,
 "michal.simek@amd.com" <michal.simek@amd.com>, "sabiya.d@ti.com"
 <sabiya.d@ti.com>, "nm@ti.com" <nm@ti.com>, "j-humphreys@ti.com"
 <j-humphreys@ti.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "trini@konsulko.com" <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, "u-kumar1@ti.com"
 <u-kumar1@ti.com>, "hai.pham.ud@renesas.com" <hai.pham.ud@renesas.com>,
 "jonas@kwiboo.se" <jonas@kwiboo.se>, "cnsztl@gmail.com" <cnsztl@gmail.com>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>
References: <20240223202153.3756094-1-a-nandan@ti.com>
 <4f418aa56f55f984a3c096732eb02124545b79eb.camel@toradex.com>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <4f418aa56f55f984a3c096732eb02124545b79eb.camel@toradex.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 28 Feb 2024 12:49:49 +0100
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

Hi Marcel,

On 27/02/24 21:45, Marcel Ziswiler wrote:
> Hi Apurva
>
> On Sat, 2024-02-24 at 01:51 +0530, Apurva Nandan wrote:
>> Hello Everyone!
>>
>> This series will introduce basic support (SD and UART) support for Texas
>> Instruments J784S4 EVM.
>>
>> The J784S4 SoC device tree patches are taken from kernel patch submissions
>> and will be updated as they are accepted and merged to the kernel tree.


Sorry about that. I didn't update that part of the cover letter. So now, 
we will be using
Linux dts as a git subtree inside U-Boot. And hence, this series doesn't 
has a Linux DTS sync/copy patch.

You can get all details in this series:
https://lore.kernel.org/all/20240222093607.3085545-1-sumit.garg@linaro.org/#r

> This patch set does not include any such, right?
>
> Anyway, for my tests I took them from linux-next on kernel.org.
>
> However, I could not get the SD card working apart from it booting U-Boot off of it:
>
> U-Boot SPL 2024.04-rc3-00015-g7186697f1ff (Feb 27 2024 - 14:27:29 +0100)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.9--v09.01.09 (Kool Koala)')
> Initialized 4 DRAM controllers
> SPL initial stack usage: 13416 bytes
> Trying to boot from MMC2
> Authentication passed
> Authentication passed
> Authentication passed
> Loading Environment from nowhere... OK
> Authentication passed
> Authentication passed
> Starting ATF on ARM64 core...
>     
> NOTICE:  BL31: v2.10.0(release):v2.10.0-412-g885e93f90
> NOTICE:  BL31: Built : 09:48:15, Feb 27 2024
> I/TC:
> I/TC: OP-TEE version: 4.1.0-140-g4078bcde9 (gcc version 13.2.1 20231009 (Arm GNU
>   Toolchain 13.2.rel1 (Build arm-13.7))) #1 Tue Feb 27 08:54:24 UTC 2024 aarch64
> I/TC: WARNING: This OP-TEE configuration might be insecure!
> I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/
> porting_guidelines.html
> I/TC: Primary CPU initializing
> I/TC: GIC redistributor base address not provided
> I/TC: Assuming default GIC group status and modifier
> I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.9--v09.01.09 (Kool Koala)')
> I/TC: HUK Initialized
> I/TC: Activated SA2UL device
> I/TC: Enabled firewalls for SA2UL TRNG device
> I/TC: SA2UL TRNG initialized
> I/TC: SA2UL Drivers initialized
> I/TC: Primary CPU switching to normal world boot
>     
> U-Boot SPL 2024.04-rc3-00015-g7186697f1ff-dirty (Feb 27 2024 - 16:40:07 +0100)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.9--v09.01.09 (Kool Koala)')
> Trying to boot from MMC2
> Authentication passed
> Authentication passed
>
>
> U-Boot 2024.04-rc3-00015-g7186697f1ff-dirty (Feb 27 2024 - 16:40:07 +0100)
>
> SoC:   J784S4 SR1.0 HS-FS
> Model: Texas Instruments J784S4 EVM
> DRAM:  2 GiB (effective 32 GiB)
> Core:  87 devices, 30 uclasses, devicetree: separate
> Flash: 0 Bytes
> MMC:   mmc@4f80000: 0, mmc@4fb0000: 1
> Loading Environment from nowhere... OK
> In:    serial@2880000
> Out:   serial@2880000
> Err:   serial@2880000
> am65_cpsw_nuss ethernet@46000000: K3 CPSW: nuss_ver: 0x6BA02102 cpsw_ver: 0x6BA82102 ale_ver: 0x00293904
> Ports:1 mdio_freq:1000000
> Net:   eth0: ethernet@46000000port@1
> Hit any key to stop autoboot:  0
> => mmc dev 0
> switch to partitions #0, OK
> mmc0(part 0) is current device
> => mmc info
> Device: mmc@4f80000
> Manufacturer ID: 13
> OEM: 4e
> Name: G1M15L
> Bus Speed: 200000000
> Mode: HS400 (200MHz)
> Rd Block Len: 512
> MMC version 5.1
> High Capacity: Yes
> Capacity: 29.6 GiB
> Bus Width: 8-bit DDR
> Erase Group Size: 512 KiB
> HC WP Group Size: 8 MiB
> User Capacity: 29.6 GiB WRREL
> Boot Capacity: 31.5 MiB ENH
> RPMB Capacity: 4 MiB ENH
> Boot area 0 is not write protected
> Boot area 1 is not write protected
> => mmc dev 1
> i2c_write: error waiting for data ACK (status=0x116)
> pca953x gpio@22: Error reading output register
> Card did not respond to voltage select! : -110
> mmc_init: -95, time 114
> =>
>
> Not sure what the issue may be.


Which platform are you testing this on? J784S4 EVM or AM69-SK?

As per comments on v8, I have moved from config fragments to having 
#include in defconfig files.
So, to build for AM69-SK, you need to use am69_sk_r5_defconfig and 
am69_sk_a72_defconfig .
And for the J784S4 EVM, the defconfigs will stay same: 
j784s4_evm_r5_defconfig and j784s4_evm_a72_defconfig .


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
>> AM69 SD mode bootlog:
>> https://gist.githubusercontent.com/apurvanandan1997/1b2c55d0204ff0f5a47ebbc196a97e99/raw/
>> J784S4 SD mode bootlog:
>> https://gist.githubusercontent.com/apurvanandan1997/5e2ef85ee4322798d22b57a60dc917db/raw/
>> eMMC UDA moode bootlog:
>> https://gist.githubusercontent.com/apurvanandan1997/3cffada252d50a8aa0c00a91f1f2f856/raw/
>>
>> Note: This series is dependent on the following series for OF_UPSTREAM support
>> https://lore.kernel.org/all/20240222093607.3085545-1-sumit.garg@linaro.org/
>>
>> And, '[PATCH 01/15] Makefile: remove hardcoded device tree source directory' has been
>> cherry-picked from PATCH 11 of https://lore.kernel.org/all/20240201030634.1120963-16-bb@ti.com/ by Bryan
>> Brattlof
>>
>> Changes in v10:
>> 1) Fixed build failure due to missing OF_UPSTREAM in a72 defconfigs
>> 2) Updated paths of board dtbs in binman.dtsi, CONFIG_OF_LIST and CONFIG_DEFAULT_DEVICE_TREE
>>
>> Changes in v9:
>> 1) Added support for OF_UPSTREAM and removed Linux dts copy/sync patches
>> 2) Fixed DRAM enumeration algorithm in j784s4_init.c by adding max no. of controllers
>> 3) Squashed bootph-all property of memory node into appropriate patch
>> 4) Moved DDR changes out of the DMA patch
>> 5) Fixed commit messages, MAINTAINERS file, and removed unnecessary C headers
>> 6) Added comment for WKUP_UART0
>> 7) Used #include for defconfig for AM69-SK platform instead of config fragments
>> 8) Fixed J784S4 EVM boot switch nameing in doc
>>
>> Link to v8:
>> https://lore.kernel.org/u-boot/20240119175043.3904751-1-a-nandan@ti.com/
>>
>> Changes in v8:
>> 1) Squashed Linux am69-sk and j784s4-evm dts patches into one
>> 2) Sorted config addition of SoC in arm/mach-K3/Kconfig
>> 3) Updated commit messages according to the reviews
>> 4) Removed #inlcude <config.h>
>> 5) Removed k3_mmc_stop_clock and k3_mmc_restart_clock
>> 6) Moved board_init_f logic to separate smaller functions
>> 7) Removed J784S4 EVM specific Kconfig options in j784s4_int.c
>> 8) Cleaned up emmc boot flow based on commit 66459346463439c72f84cfd1f985496b8a6142d8
>> 9) Removed the dependency of findfdt and updated to ti_set_fdt_env
>> 10) Updated copyright messages
>> 11) Did cleanup/formatting of yaml files, removing linting errors
>> 12) Removed k3-am69-sk specific things from k3-j784s4-binman.dtsi
>> 13) Changed OF_LIST to a single dtb
>> 14) Added bootph-all tag in EVM and SK dts instead of u-boot.dtsi
>> 15) Trimmed the defconfig files to minimal
>> 16) Merged the MAINTAINER file in right patches
>> 17) Updated OpenOCD tag in U-Boot doc
>> 18) And fixed other formatting mistakes.
>>
>> Link to v7:
>> https://lore.kernel.org/u-boot/20231219191537.4039361-1-a-nandan@ti.com/
>>
>> Changes in v7:
>> 1) Moved to unified memory map in arm64-mmu.c based on
>>     https://lore.kernel.org/all/20231128170528.407707-1-afd@ti.com/
>> 2) Used ARRAY_SIZE in clk-data.c and dev-data.c
>> 3) Removed I2C board detect from j784s4_init.c
>> 4) Rebased to latest next
>>
>> Link to v6:
>> https://lore.kernel.org/all/20231206123753.1486031-1-a-nandan@ti.com/
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
>> Apurva Nandan (12):
>>    arm: mach-k3: Kconfig: Sort SOC_K3 config entries
>>    arm: mach-k3: Add basic support for J784S4 SoC definition
>>    arm: mach-k3: Sort SoC JTAG_ID entries
>>    soc: ti: k3-socinfo: Add entry for J784S4 SoC
>>    arm: mach-k3: j784s4: Add clk and power support
>>    drivers: dma: Add support for J784S4 SoC
>>    board: ti: j784s4: Add board support for J784S4 EVM
>>    board: ti: j748s4: Add board config yaml files
>>    board: ti: j784s4: Add boot environment variables
>>    arm: dts: Introduce j784s4 u-boot dts files
>>    configs: j784s4_evm: Add defconfig for J784S4 EVM board
>>    doc: board: ti: k3: Add J784S4 EVM and AM69 SK documentation
>>
>> Bryan Brattlof (1):
>>    Makefile: remove hardcoded device tree source directory
>>
>> Dasnavis Sabiya (2):
>>    arm: dts: Introduce am69-sk u-boot dts files
>>    configs: am69_sk: Add defconfig for AM69 SK board
>>
>>   Makefile                                      |   18 +-
>>   arch/arm/dts/Makefile                         |    4 +
>>   arch/arm/dts/k3-am69-r5-sk.dts                |  106 +
>>   arch/arm/dts/k3-am69-sk-u-boot.dtsi           |   54 +
>>   arch/arm/dts/k3-j784s4-binman.dtsi            |  345 +
>>   arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi  | 8757 ++++++++++++++++
>>   arch/arm/dts/k3-j784s4-ddr.dtsi               | 8858 +++++++++++++++++
>>   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |   31 +
>>   arch/arm/dts/k3-j784s4-r5-evm.dts             |  106 +
>>   arch/arm/mach-k3/Kconfig                      |   33 +-
>>   arch/arm/mach-k3/Makefile                     |    2 +
>>   arch/arm/mach-k3/include/mach/hardware.h      |   13 +-
>>   .../mach-k3/include/mach/j784s4_hardware.h    |   59 +
>>   arch/arm/mach-k3/include/mach/j784s4_spl.h    |   47 +
>>   arch/arm/mach-k3/include/mach/spl.h           |    4 +
>>   arch/arm/mach-k3/j784s4/Kconfig               |   34 +
>>   arch/arm/mach-k3/j784s4_fdt.c                 |   15 +
>>   arch/arm/mach-k3/j784s4_init.c                |  310 +
>>   arch/arm/mach-k3/r5/Makefile                  |    1 +
>>   arch/arm/mach-k3/r5/j784s4/Makefile           |    7 +
>>   arch/arm/mach-k3/r5/j784s4/clk-data.c         |  428 +
>>   arch/arm/mach-k3/r5/j784s4/dev-data.c         |   98 +
>>   board/ti/j784s4/Kconfig                       |   37 +
>>   board/ti/j784s4/MAINTAINERS                   |   21 +
>>   board/ti/j784s4/Makefile                      |    7 +
>>   board/ti/j784s4/board-cfg.yaml                |   37 +
>>   board/ti/j784s4/evm.c                         |   41 +
>>   board/ti/j784s4/j784s4.env                    |   17 +
>>   board/ti/j784s4/pm-cfg.yaml                   |   13 +
>>   board/ti/j784s4/rm-cfg.yaml                   | 3058 ++++++
>>   board/ti/j784s4/sec-cfg.yaml                  |  380 +
>>   board/ti/j784s4/tifs-rm-cfg.yaml              | 2656 +++++
>>   configs/am69_sk_a72_defconfig                 |    9 +
>>   configs/am69_sk_r5_defconfig                  |   10 +
>>   configs/j784s4_evm_a72_defconfig              |  159 +
>>   configs/j784s4_evm_r5_defconfig               |  153 +
>>   doc/board/ti/j784s4_evm.rst                   |  299 +
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
>>   scripts/Makefile.spl                          |   17 +-
>>   51 files changed, 26455 insertions(+), 28 deletions(-)
>>   create mode 100644 arch/arm/dts/k3-am69-r5-sk.dts
>>   create mode 100644 arch/arm/dts/k3-am69-sk-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-binman.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-ddr.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/k3-j784s4-r5-evm.dts
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
>>   create mode 100644 configs/am69_sk_a72_defconfig
>>   create mode 100644 configs/am69_sk_r5_defconfig
>>   create mode 100644 configs/j784s4_evm_a72_defconfig
>>   create mode 100644 configs/j784s4_evm_r5_defconfig
>>   create mode 100644 doc/board/ti/j784s4_evm.rst
>>   create mode 100644 drivers/dma/ti/k3-psil-j784s4.c
>>   create mode 100644 include/configs/j784s4_evm.h
> Cheers
>
> Marcel

-- 
Regards,
Apurva Nandan,
Texas Instruments.

