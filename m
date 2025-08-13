Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED28DCA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 08:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B9F683253;
	Wed, 13 Aug 2025 10:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="apkIzub1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3738A8329C; Wed, 13 Aug 2025 10:57:07 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74DB983236
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 10:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0320aa2bcc=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D83APm016638;
 Wed, 13 Aug 2025 10:56:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 mPCBt2SzHXgZMjm4eBad70RLxjHbtcfceuHpK3M8rUU=; b=apkIzub1GKU0tWvd
 GqVc3Dzz3Z78031RmIRteaMfziBqGKCf5MUCC50H8a9ojJV3yvQdBz85EVgKmvOr
 S3MJD0bike/grgNbmvGm1zPn65LzZrPnxfjLEdI4/6HADtuA3lgMjfaEsYMmkaWi
 DR8cLqmh9SWBP9/DtvWeupIHY2MyT/Q+qizqZxGx+o9X5ILqFuXcvMxoKxLOAp5n
 RsorWibPqVZjRG0uwZOvStXoxYW8JZXuogwHpa7+9rk0v4xxaF6wSB1kY+uiyu3u
 /6DaSgXECU4sXn7hiLAcO3RH/cxvGOp8hN2SyzK3S2iwbLWKR+/4G6yquZCDU2ep
 JuDMhg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48duf8x29h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 10:56:44 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C29F540047;
 Wed, 13 Aug 2025 10:54:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7FA6B724AC8;
 Wed, 13 Aug 2025 10:53:27 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 10:53:26 +0200
Message-ID: <9c805dc1-fc95-4d01-99cf-306264fd4b2b@foss.st.com>
Date: Wed, 13 Aug 2025 10:53:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] stm32mp2: Add SPI flashes support
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>,
 Alexander Dahl <ada@thorsis.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, Cheick Traore
 <cheick.traore@foss.st.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Jagan Teki
 <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 John Watts <contact@jookia.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, Simon Glass
 <sjg@chromium.org>, Stefan Roese <sr@denx.de>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, Utsav Agarwal
 <utsav.agarwal@analog.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>
References: <20250808151154.472860-1-patrice.chotard@foss.st.com>
 <827b1b5e-ac74-4710-8424-5bf0390441f6@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <827b1b5e-ac74-4710-8424-5bf0390441f6@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
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



On 8/8/25 17:24, Marek Vasut wrote:
> On 8/8/25 5:11 PM, Patrice Chotard wrote:
>> This series introduces 2 new drivers:
>>    _ STM32 Octo Memory Manager driver
>>    _ STM32 OSPI driver
>>
>> It adds resource check helpers which are used by OMM driver.
>> It adds and enables OMM and OSPI driver support for stm32mp257f-ev1 board
> Can I test this with mainline TFA and mainline OpTee-OS ?

Hi Marek

Currently, it misses regulator support in OPTEE.
But you can enable "manually" VDDIO3 and VDDIO4 in U-Boot console 
by using the following mw command: 

mw 44210000 300

There is also a dependency with this series https://patchwork.ozlabs.org/project/uboot/list/?series=468436
you must applied first.

Here is a boot log on stm32mp257f-ev1 board : 

NOTICE:  CPU: STM32MP257FAI Rev.Y
NOTICE:  Model: STMicroelectronics STM32MP257F-EV1 Evaluation Board
NOTICE:  Board: MB1936 Var1.0 Rev.D-01
INFO:    Reset reason: System reset (SYSRST) (0x2074)
INFO:    PMIC2 version = 0x11
INFO:    PMIC2 product ID = 0x20
INFO:    FCONF: Reading TB_FW firmware configuration file from: 0xe011000
INFO:    FCONF: Reading firmware configuration information for: stm32mp_io
INFO:    Using SDMMC
INFO:      Instance 1
INFO:    Boot used partition fsbl1
NOTICE:  BL2: v2.13.0(debug):v2.13.0-304-g000fe221b8
NOTICE:  BL2: Built : 15:57:18, Jul 11 2025
INFO:    BL2: Loading image id 26
INFO:    Loading image id=26 at address 0xe040000
INFO:    Image id=26 loaded: 0xe040000 - 0xe047524
INFO:    BL2: Doing platform setup
INFO:    RAM: DDR4 2x16Gbits 2x16bits 1200MHz
INFO:    Memory size = 0x100000000 (4096 MB)
INFO:    BL2: Loading image id 1
INFO:    Loading image id=1 at address 0xe000000
INFO:    Image id=1 loaded: 0xe000000 - 0xe00020c
INFO:    FCONF: Reading FW_CONFIG firmware configuration file from: 0xe000000
INFO:    FCONF: Reading firmware configuration information for: dyn_cfg
INFO:    BL2: Loading image id 3
INFO:    Loading image id=3 at address 0xe000000
INFO:    Image id=3 loaded: 0xe000000 - 0xe00f44e
INFO:    BL2: Loading image id 19
INFO:    Loading image id=19 at address 0x81ff0000
INFO:    Image id=19 loaded: 0x81ff0000 - 0x81ff2fb9
INFO:    BL2: Loading image id 4
INFO:    Loading image id=4 at address 0x82000000
INFO:    Image id=4 loaded: 0x82000000 - 0x8200001c
INFO:    OPTEE ep=0x82000000
INFO:    OPTEE header info:
INFO:          magic=0x4554504f
INFO:          version=0x2
INFO:          arch=0x1
INFO:          flags=0x0
INFO:          nb_images=0x1
INFO:    BL2: Loading image id 8
INFO:    Loading image id=8 at address 0x82000000
INFO:    Image id=8 loaded: 0x82000000 - 0x82095980
INFO:    BL2: Loading image id 2
INFO:    Loading image id=2 at address 0x84400000
INFO:    Image id=2 loaded: 0x84400000 - 0x8440cef8
INFO:    BL2: Loading image id 5
INFO:    Loading image id=5 at address 0x84000000
INFO:    Image id=5 loaded: 0x84000000 - 0x840faa48
NOTICE:  BL2: Booting BL31
INFO:    Entry point address = 0xe000000
INFO:    SPSR = 0x3cd
INFO:    ARM GICv2 driver initialized
NOTICE:  BL31: v2.13.0(debug):v2.13.0-304-g000fe221b8
NOTICE:  BL31: Built : 15:57:18, Jul 11 2025
INFO:    BL31: Initializing runtime services
INFO:    BL31: Initializing BL32
I/TC: Early console on UART#2
I/TC: 
I/TC: Embedded DTB found
I/TC: OP-TEE version: 4.7.0-26-g847ee2932 (gcc version 14.3.0 (GCC)) #1 Fri Jul 18 13:59:24 UTC 2025 aarch64
I/TC: WARNING: This OP-TEE configuration might be insecure!
I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
I/TC: Primary CPU initializing
I/TC: Platform stm32mp2: flavor 257F_EV1 - DT stm32mp257f-ev1.dts
I/TC: DTB enables console
[    0.000000] SCP-firmware v2.16.0-95-gea048ebd
[    0.000000] 
[    0.000000] [FWK] Module initialization complete!
I/TC: Primary CPU switching to normal world boot
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x84000000
INFO:    SPSR = 0x3c5
I/TC: Reserved shared memory is disabled
I/TC: Dynamic shared memory is enabled
I/TC: Normal World virtualization support is disabled
I/TC: Asynchronous notifications are enabled


U-Boot 2025.10-rc2-00007-g488461f36e40 (Aug 13 2025 - 10:47:54 +0200)

I/TC: WARNING (insecure configuration): Failed to get monotonic counter for REE FS, using 0
E/LD:  init_elf:493 sys_open_ta_bin(94cf71ad-80e6-40b5-a7c6-3dc501eb2803)
E/TC:? 0 ldelf_init_with_ldelf:152 ldelf failed with res: 0xffff0009
E/LD:  init_elf:493 sys_open_ta_bin(94cf71ad-80e6-40b5-a7c6-3dc501eb2803)
E/TC:? 0 ldelf_init_with_ldelf:152 ldelf failed with res: 0xffff0009
optee optee: PTA_BSEC invoke failed TEE err: ffff0006, err:0
E/LD:  init_elf:493 sys_open_ta_bin(94cf71ad-80e6-40b5-a7c6-3dc501eb2803)
E/TC:? 0 ldelf_init_with_ldelf:152 ldelf failed with res: 0xffff0009
optee optee: PTA_BSEC invoke failed TEE err: ffff0006, err:0
E/LD:  init_elf:493 sys_open_ta_bin(94cf71ad-80e6-40b5-a7c6-3dc501eb2803)
E/TC:? 0 ldelf_init_with_ldelf:152 ldelf failed with res: 0xffff0009
optee optee: PTA_BSEC invoke failed TEE err: ffff0006, err:0
CPU: STM32MP25??XX Rev.?
Model: STMicroelectronics STM32MP257F-EV1 Evaluation Board
Board: stm32mp2 (st,stm32mp257f-ev1)
E/LD:  init_elf:493 sys_open_ta_bin(94cf71ad-80e6-40b5-a7c6-3dc501eb2803)
E/TC:? 0 ldelf_init_with_ldelf:152 ldelf failed with res: 0xffff0009
optee optee: PTA_BSEC invoke failed TEE err: ffff0006, err:0
DRAM:  4 GiB
optee optee: OP-TEE: revision 4.7 (847ee2932c85f07e)
I/TC: Reserved shared memory is disabled
I/TC: Dynamic shared memory is enabled
I/TC: Normal World virtualization support is disabled
I/TC: Asynchronous notifications are enabled
Core:  330 devices, 27 uclasses, devicetree: board
smcwd watchdog: Init failed -5
MMC:   STM32 SD/MMC: 0
Loading Environment from MMC... Reading from MMC(0)... OK
In:    serial@400e0000
Out:   serial@400e0000
Err:   serial@400e0000
E/LD:  init_elf:493 sys_open_ta_bin(94cf71ad-80e6-40b5-a7c6-3dc501eb2803)
E/TC:? 0 ldelf_init_with_ldelf:152 ldelf failed with res: 0xffff0009
E/LD:  init_elf:493 sys_open_ta_bin(94cf71ad-80e6-40b5-a7c6-3dc501eb2803)
E/TC:? 0 ldelf_init_with_ldelf:152 ldelf failed with res: 0xffff0009
optee optee: PTA_BSEC invoke failed TEE err: ffff0006, err:0
Hit any key to stop autoboot: 0
STM32MP> 
STM32MP> 
STM32MP> 
STM32MP> 
STM32MP> 
STM32MP> mw 44210000 300
STM32MP> mtd list
SF: Detected mx66l51235l with page size 256 Bytes, erase size 64 KiB, total 64 MiB
List of MTD devices:
* nor0
  - device: flash@0
  - parent: spi@0
  - driver: jedec_spi_nor
  - path: /soc@0/ommanager@40500000/spi@0/flash@0
  - type: NOR flash
  - block size: 0x10000 bytes
  - min I/O: 0x1 bytes
  - 0x000000000000-0x000004000000 : "nor0"
          - 0x000000000000-0x000000040000 : "fsbla1"
          - 0x000000040000-0x000000080000 : "fsbla2"
          - 0x000000080000-0x0000000c0000 : "metadata1"
          - 0x0000000c0000-0x000000100000 : "metadata2"
          - 0x000000100000-0x000000500000 : "fip-a"
          - 0x000000500000-0x000000900000 : "fip-b"
          - 0x000000900000-0x000000980000 : "u-boot-env"
          - 0x000000980000-0x000004000000 : "nor-user"
STM32MP> 


Patrice
