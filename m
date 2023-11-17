Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE18C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 04:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E631886F84;
	Fri, 17 Nov 2023 05:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zFEnXMY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30B1E86F5E; Fri, 17 Nov 2023 05:03:19 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E07686F84
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AH42sR1112920;
 Thu, 16 Nov 2023 22:02:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700193774;
 bh=gAe7h1gZMNahqzVoxkWM5fpUZQP8C883lDKj4pMMgOI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=zFEnXMY5t2Ei0RQkPNVo7O2ICqZrKGlUKSgwMbIWjki+SHL1/x2Fxz8RQTeGcwAGX
 FHMy8rAdSUdItfMjGc5cnrEoGeF2gB//U1EvQSjZQ3Q1C++Zyh2Atwjo3/S1JNTmJx
 IEyqcmx9p+iZT7f9oBIEz72TG0Yzqe/R1GCE8M/c=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AH42sj8077215
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 16 Nov 2023 22:02:54 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 Nov 2023 22:02:53 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 Nov 2023 22:02:53 -0600
Received: from [172.24.20.156] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AH42kf5079526;
 Thu, 16 Nov 2023 22:02:46 -0600
Message-ID: <719afeb3-7106-43e8-926f-4aa54d373055@ti.com>
Date: Fri, 17 Nov 2023 09:32:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] Introduce initial TI's J784S4 and AM69 support
To: Enric Balletbo i Serra <eballetb@redhat.com>, Maxime Ripard
 <mripard@redhat.com>
CC: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>
References: <20231001165545.494212-1-a-nandan@ti.com>
 <lusvfc2to2akeccammsslooai53i4tflvcv4k2iofz3yqco3u6@uvn5flsjhxv3>
 <CALE0LRsTUFdSKYEoWDhPZRQEZbwv3-CMV5931KRbPvWmvWTSQA@mail.gmail.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <CALE0LRsTUFdSKYEoWDhPZRQEZbwv3-CMV5931KRbPvWmvWTSQA@mail.gmail.com>
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


On 11/17/2023 4:26 AM, Enric Balletbo i Serra wrote:
> Hi Maxime
>
>
> On Wed, Nov 15, 2023 at 2:54 PM Maxime Ripard <mripard@redhat.com> wrote:
>> Hi,
>>
>> On Sun, Oct 01, 2023 at 10:25:29PM +0530, Apurva Nandan wrote:
>>> This series will introduce basic support (SD and UART) support for Texas
>>> Instruments J784S4 EVM.
>>>
>>> The J784S4 SoC device tree patches are taken from kernel patch submissions
>>> and will be updated as they are accepted and merged to the kernel tree.
>>> All other patches are specific to SPL and u-boot and do not have
>>> dependency on other trees. Appreciate a review for acceptance to u-boot
>>> tree.
>>>
>>> Here are some of the salient features of the J784S4 automotive grade
>>> application processor:
>>>
>>> The J784S4 SoC belongs to the K3 Multicore SoC architecture
>>> platform, providing advanced system integration in automotive,
>>> ADAS and industrial applications requiring AI at the network edge.
>>> This SoC extends the K3 Jacinto 7 family of SoCs with focus on
>>> raising performance and integration while providing interfaces,
>>> memory architecture and compute performance for multi-sensor, high
>>> concurrency applications.
>>>
>>> Some highlights of this SoC are:
>>> * Up to 8 Cortex-A72s, four clusters of lockstep capable dual Cortex-R5F MCUs,
>>>    4 C7x floating point vector DSPs with Matrix Multiply Accelerator(MMA) for
>>>    deep learning and CNN.
>>> * 3D GPU: Automotive grade IMG BXS-4-64 MC1
>>> * Vision Processing Accelerator (VPAC) with image signal processor and Depth
>>>    and Motion Processing Accelerator (DMPAC)
>>> * Three CSI2.0 4L RX plus two CSI2.0 4L TX, two DSI Tx, one eDP/DP and one
>>>    DPI interface.
>>> * Integrated gigabit ethernet switch, up to 8 ports (TDA4VH), two ports
>>>    support 10Gb USXGMII; Two 4 lane PCIe-GEN3 controllers, USB3.0 Dual-role
>>>    device subsystems, Up to 20 MCANs, among other peripherals.
>>>
>>> See J784S4 Technical Reference Manual (SPRUJ52 - JUNE 2022)
>>> for further details: http://www.ti.com/lit/zip/spruj52
>>>
>>> In addtion, the J784S4 EVM board is designed for TI J784S4 SoC. It
>>> supports the following interfaces:
>>> * 32 GB DDR4 RAM
>>> * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
>>> * x1 Input Audio Jack, x1 Output Audio Jack
>>> * x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
>>> * x2 4L PCIe connector
>>> * x1 UHS-1 capable micro-SD card slot
>>> * 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
>>>    UFS flash.
>>> * x6 UART through UART-USB bridge
>>> * XDS110 for onboard JTAG debug using USB
>>> * Temperature sensors, user push buttons and LEDs
>>> * 40-pin User Expansion Connector
>>> * x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
>>> * x1 15-pin CSI header
>>> * x6 MCAN instances
>> I've tested this series on top of 2024.01-rc2, and while it worked fine
>> before, the (external) MMC is now broken:
>>
>> U-Boot SPL 2024.01-rc2-00021-g8e3ced8fbad8 (Nov 15 2023 - 12:07:18 +0100)
>> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.2--v09.01.02 (Kool Koala)')
>> SPL initial stack usage: 13416 bytes
>> Trying to boot from MMC2
>> Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
>> Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
>> Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
>> Loading Environment from nowhere... OK
>> Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
>> Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
>> Starting ATF on ARM64 core...
>>
>> NOTICE:  BL31: v2.9(release):v2.9.0
>> NOTICE:  BL31: Built : 12:07:09, Nov 15 2023
>> I/TC:
>> I/TC: OP-TEE version: 4.0.0 (gcc version 13.2.1 20230728 (Red Hat Cross 13.2.1-1) (GCC)) #1 Wed Nov 15 11:07:14 UTC 2023 aarch64
>> I/TC: WARNING: This OP-TEE configuration might be insecure!
>> I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
>> I/TC: Primary CPU initializing
>> I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.2--v09.01.02 (Kool Koala)')
>> I/TC: HUK Initialized
>> I/TC: Activated SA2UL device
>> I/TC: Enabled firewalls for SA2UL TRNG device
>> I/TC: SA2UL TRNG initialized
>> I/TC: SA2UL Drivers initialized
>> I/TC: Primary CPU switching to normal world boot
>>
>> U-Boot SPL 2024.01-rc2-00021-g8e3ced8fbad8 (Nov 15 2023 - 12:07:30 +0100)
>> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.2--v09.01.02 (Kool Koala)')
>> Trying to boot from MMC2
>> Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
>> Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
>>
>>
>> U-Boot 2024.01-rc2-00021-g8e3ced8fbad8 (Nov 15 2023 - 12:07:30 +0100)
>>
>> SoC:   J784S4 SR1.0 HS-FS
>> Model: Texas Instruments J784S4 EVM
> Maybe something changed but I'm surprised about it reporting an EVM
> board. I was expecting something like
>
> Model: Texas Instruments AM69 SK
> Board: AM69-SK rev E2
>
> Did you use the am69_sk_a72/r5  defconfigs?

Please apply AM69 config fragment

https://lore.kernel.org/all/20231001165545.494212-16-a-nandan@ti.com/

make ARCH=arm j784s4_evm_a72_defconfig am69_sk_a72.config
make ARCH=arm

OR

make ARCH=arm j784s4_evm_r5_defconfig am69_sk_r5.config
make ARCH=arm

>
>> DRAM:  32 GiB
>> Core:  90 devices, 31 uclasses, devicetree: separate
>> Flash: 0 Bytes
>> MMC:   mmc@4f80000: 0, mmc@4fb0000: 1
>> Loading Environment from nowhere... OK
>> In:    serial@2880000
>> Out:   serial@2880000
>> Err:   serial@2880000
>> am65_cpsw_nuss ethernet@46000000: K3 CPSW: nuss_ver: 0x6BA02102 cpsw_ver: 0x6BA82102 ale_ver: 0x00293904 Ports:1 mdio_freq:1000000
>> Net:   eth0: ethernet@46000000port@1
>> Hit any key to stop autoboot:  0
>> => boot
>> i2c_write: error waiting for data ACK (status=0x116)
>> pca953x gpio@22: Error reading output register
>> Card did not respond to voltage select! : -110
>> mmc_init: -95, time 114
>>
>> Maxime
