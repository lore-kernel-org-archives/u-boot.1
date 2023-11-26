Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BB1C4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 04:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8878870A0;
	Sun, 26 Nov 2023 05:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ABNTA98m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F4EB87186; Sun, 26 Nov 2023 05:27:12 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D649A87075
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 05:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephen.graf@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cfabcbda7bso9199905ad.0
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 20:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700972827; x=1701577627; darn=lists.denx.de;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNBHAakU8NtMeDctQTnZYnJagHCi6sAvsmDvD2OZ+ts=;
 b=ABNTA98m9MqYrxtfSzCnTQZlowm1W9vd+U9nPj4jIcXpiPbIZQx5qsE6D7F2J11eGb
 oy5yvOMDu3vaYciQWYS5+yVL9vSNT++gD/UoY9jvk5cCB9Bs4PE42XU6eTdBPEdLOCYh
 8XfsR5xdFnqH8bhpnktUwIJntzBYtKdKxLlvc61JKunsDbJiUT5F7Dz4iAXRGNVuM6pZ
 UfjIZMSYpbJQnj4BLROp0ytn+XYAp6ZK8ohNaOSgPmf6WzJwgNN7m1/fFQ7NDYPvEQiF
 l5gZpsR1W3xYkILgLO2U9RWWAuM5UzLa7NJKjYouuadr2QZ2bDslsTtd/zaLMUFMZC68
 O1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700972827; x=1701577627;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rNBHAakU8NtMeDctQTnZYnJagHCi6sAvsmDvD2OZ+ts=;
 b=WCjbklvwonrqvm3q+JcDltVTamV9sfdQ0FetEpcUlrQ4B5owr4FbMK2DV4LecbSdC4
 62bsgLHwNK6HPgdWv2yX377pVsIdYHzFBh0VTYeBEWrQu9OWm82B+aznZOMFgz2Rx9UI
 kKUUVDZRhqTRXO9LjKUHl8NM31ci7CKZjWEDQC2h9BIjnx/mJMlVJwRPidmmB1nUIfVp
 wOY/V3nNFGHlj++hgakdmfMQ4gTEH//T7+Aurcd+Ee4nHIz1aow7nnYE5Turpc//xGK+
 u/kGZt8c0Lrd1z88qhinegOeC//6fH8zQ7HAOEq8ibgXWbD8vd9BKxxcaonHNjTu3gUB
 advA==
X-Gm-Message-State: AOJu0YyEbLe6dRB5A3rqlz1Hz20gc00xGEl3tHuQrEFKNnkdSAHaazxv
 gOTkGfcu4ttPQNy+p6oHI7Y=
X-Google-Smtp-Source: AGHT+IH6Df7NKchyQyAgQ0Udno8My73Ic1Z5qwQ8iQuTzOYAIu2MKuLj85abHvWQWtPL8EUwy6oiXQ==
X-Received: by 2002:a17:902:ce90:b0:1cf:6a75:e980 with SMTP id
 f16-20020a170902ce9000b001cf6a75e980mr15636746plg.0.1700972827005; 
 Sat, 25 Nov 2023 20:27:07 -0800 (PST)
Received: from [192.168.1.3] (d23-16-72-139.bchsia.telus.net. [23.16.72.139])
 by smtp.gmail.com with ESMTPSA id
 e64-20020a636943000000b005b32d6b4f2fsm5432193pgc.81.2023.11.25.20.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Nov 2023 20:27:06 -0800 (PST)
Message-ID: <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
Date: Sat, 25 Nov 2023 20:27:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] sunxi: H616: Add OrangePi Zero 3 board support
To: Andre Przywara <andre.przywara@arm.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
 <20231126002349.55404e43@slackpad.lan>
Content-Language: en-CA
From: Stephen Graf <stephen.graf@gmail.com>
In-Reply-To: <20231126002349.55404e43@slackpad.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I built u-boot with the additional parameter for usb and it works, I think.  There was one message that might be of concern "
Card did not respond to voltage select! : -110". I am not sure of the details of the boot.cmd. The output below came from
the supplier image on an SD plugged into a USB card reader. The SD slot of the board was empty.

I was able to install u-boot to the SPI flash memory and there is a warning message from that also: "
Loading Environment from SPIFlash... jedec_spi_nor flash@0: unrecognized JEDEC id bytes: 5e, 40, 18
*** Warning - spi_flash_probe_bus_cs() failed, using default environment"

Thank you for your advice on getting something to boot. None of the Debian installer images were suitable.  Even SID was at 6.1.
I built the latest Linux 6.6.2 and wrestled with the rootfs before I got it running. I built the tested u-boot with this system,
as a test of system stability.

defconfig used + emac patches

CONFIG_ARM=y
CONFIG_ARCH_SUNXI=y
CONFIG_DEFAULT_DEVICE_TREE="sun50i-h618-orangepi-zero3"
CONFIG_SPL=y
CONFIG_DRAM_SUN50I_H616_DX_ODT=0x07070707
CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
CONFIG_DRAM_SUN50I_H616_ODT_EN=0xaaaaeeee
CONFIG_DRAM_SUN50I_H616_TPR6=0x44000000
CONFIG_DRAM_SUN50I_H616_TPR10=0x402f6663
CONFIG_DRAM_SUN50I_H616_TPR11=0x24242624
CONFIG_DRAM_SUN50I_H616_TPR12=0x0f0f100f
CONFIG_MACH_SUN50I_H616=y
CONFIG_SUNXI_DRAM_H616_LPDDR4=y
#
CONFIG_DRAM_CLK=792
CONFIG_USB1_VBUS_PIN="PC16"
#
CONFIG_R_I2C_ENABLE=y
CONFIG_SPL_SPI_SUNXI=y
# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
CONFIG_SPL_I2C=y
CONFIG_SPL_SYS_I2C_LEGACY=y
CONFIG_SYS_I2C_MVTWSI=y
CONFIG_SYS_I2C_SLAVE=0x7f
CONFIG_SYS_I2C_SPEED=400000
CONFIG_SPI_FLASH_ZBIT=y
CONFIG_PHY_MOTORCOMM=y
CONFIG_SUN8I_EMAC=y
CONFIG_AXP313_POWER=y
CONFIG_SPI=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_MUSB_GADGET=y


Console Output:

U-Boot 2024.01-rc3-00009-g9e53e45292-dirty (Nov 25 2023 - 18:32:16 -0800) Allwinner Technology

CPU:   Allwinner H616 (SUN50I)
Model: OrangePi Zero3
DRAM:  1 GiB
Core:  57 devices, 25 uclasses, devicetree: separate
WDT:   Not starting watchdog@30090a0
MMC:   mmc@4020000: 0
Loading Environment from SPIFlash... jedec_spi_nor flash@0: unrecognized JEDEC id bytes: 5e, 40, 18
*** Warning - spi_flash_probe_bus_cs() failed, using default environment

Loading Environment from FAT... Card did not respond to voltage select! : -110
** Bad device specification mmc 0 **
In:    serial@5000000
Out:   serial@5000000
Err:   serial@5000000
Allwinner mUSB OTG (Peripheral)
Net:   eth0: ethernet@5020000using musb-hdrc, OUT ep1out IN ep1in STATUS ep2in
MAC de:ad:be:ef:00:01
HOST MAC de:ad:be:ef:00:00
RNDIS ready
, eth1: usb_ether
starting USB...
Bus usb@5200000: USB EHCI 1.00
Bus usb@5200400: USB OHCI 1.0
scanning bus usb@5200000 for devices... Device NOT ready
    Request Sense returned 02 3A 00
Device NOT ready
    Request Sense returned 02 3A 00
Device NOT ready
    Request Sense returned 02 3A 00
2 USB Device(s) found
scanning bus usb@5200400 for devices... 1 USB Device(s) found
        scanning usb for storage devices... 1 Storage Device(s) found
Hit any key to stop autoboot:  0
Card did not respond to voltage select! : -110

Device 0: Vendor: Generic- Rev: 1.00 Prod: SD/MMC
             Type: Removable Hard Disk
             Capacity: 15193.5 MB = 14.8 GB (31116288 x 512)
... is now current device
Scanning usb 0:1...
Found U-Boot script /boot/boot.scr
3636 bytes read in 1 ms (3.5 MiB/s)
## Executing script at 4fc00000
U-boot loaded from SD
Boot script loaded from usb
205 bytes read in 1 ms (200.2 KiB/s)
Failed to load '/boot/dtb/allwinner/sun50i-h618-orangepi-zero3.dtb'
libfdt fdt_check_header(): FDT_ERR_BADMAGIC
No FDT memory address configured. Please configure
the FDT address via "fdt addr <address>" command.
Aborting!
4203 bytes read in 4 ms (1 MiB/s)
Applying kernel provided DT fixup script (sun50i-h616-fixup.scr)
## Executing script at 45000000
7088139 bytes read in 325 ms (20.8 MiB/s)
9419107 bytes read in 430 ms (20.9 MiB/s)
    Uncompressing Kernel Image
Moving Image from 0x40080000 to 0x40200000, end=41800000
## Loading init Ramdisk from Legacy Image at 4ff00000 ...
    Image Name:   uInitrd
    Image Type:   AArch64 Linux RAMDisk Image (gzip compressed)
    Data Size:    7088075 Bytes = 6.8 MiB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
ERROR: Did not find a cmdline Flattened Device Tree

On 2023-11-25 4:23 p.m., Andre Przywara wrote:
> On Sat, 25 Nov 2023 20:43:12 +0300
> Mikhail Kalashnikov<iuncuim@gmail.com>  wrote:
>
> Hi Mikhail,
>
>> Hi Andre!
>> Thanks for your patches. I started checking and noticed that USB storage
>> was not working:
>>
>> => usb reset
>> resetting USB...
>> Bus usb@5200000: USB EHCI 1.00
>> Bus usb@5200400: USB OHCI 1.0
>> scanning bus usb@5200000 for devices... 1 USB Device(s) found
>> scanning bus usb@5200400 for devices... 1 USB Device(s) found
>>         scanning usb for storage devices... 0 Storage Device(s) found
>> => usb storage
>> No storage devices, perhaps not 'usb start'ed..?
> Ah, thanks for the report, seems I didn't even test this!
> So digging around I figured it's working in Linux, and it's the right
> USB port, but we are missing the VBUS power switch, which is a GPIO
> controlled regulator. There are pending patches to pick this from the
> devicetree[1], but we are not there yet, so we need:
> CONFIG_USB1_VBUS_PIN="PC16"
> in the defconfig, for now. I will update the file. The same is
> actually missing from the OrangePi Zero2 defconfig, I will send a patch
> ASAP.
>   
>> Otherwise my OpiZero3 (4GB) board looks working.
>> Ethernet works with my 10 Mbps usb-dongle.
>>
>> sf probe detect spi nor flash:
>> => sf probe
>> SF: Detected zb25vq128 with page size 256 Bytes, erase size 4 KiB, total
>> 16 MiB
>>
>> Loading the kernel and running the operating system (from microsd) also
>> without problems.
>>
>> Tested-by: Mikhail Kalashnikov<iuncuim@gmail.com>
> Great, thanks for the tag!
>
> Cheers,
> Andre
>
>> On 14.11.2023 04:31, Andre Przywara wrote:
>>> The OrangePi Zero 3 is a small development board featuring the Allwinner
>>> H618 SoC, shipping with up to 4GB of DRAM, Gigabit Ethernet, a micro-HDMI
>>> connector and two USB sockets.
>>> The board uses LPDDR4 DRAM and an X-Powers AXP313a PMIC, support for
>>> which was recently added to U-Boot.
>>>
>>> Add a defconfig file selecting the right drivers and DRAM options.
>>> Since the .dts file was synced from the Linux kernel repo already, we
>>> just need to add one line to the Makefile to actually build the .dtb.
>>>
>>> The DRAM parameters were derived from the values found in the BSP DRAM
>>> drivers on the SPI NOR flash.
>>>
>>> Signed-off-by: Andre Przywara<andre.przywara@arm.com>
>>> ---
>>>    arch/arm/dts/Makefile            |  1 +
>>>    board/sunxi/MAINTAINERS          |  5 +++++
>>>    configs/orangepi_zero3_defconfig | 30 ++++++++++++++++++++++++++++++
>>>    3 files changed, 36 insertions(+)
>>>    create mode 100644 configs/orangepi_zero3_defconfig
>>>
>>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>>> index 1be08c5fdc2..5fc888680b3 100644
>>> --- a/arch/arm/dts/Makefile
>>> +++ b/arch/arm/dts/Makefile
>>> @@ -835,6 +835,7 @@ dtb-$(CONFIG_MACH_SUN50I_H6) += \
>>>    	sun50i-h6-tanix-tx6-mini.dtb
>>>    dtb-$(CONFIG_MACH_SUN50I_H616) += \
>>>    	sun50i-h616-orangepi-zero2.dtb \
>>> +	sun50i-h618-orangepi-zero3.dtb \
>>>    	sun50i-h616-x96-mate.dtb
>>>    dtb-$(CONFIG_MACH_SUN50I) += \
>>>    	sun50i-a64-amarula-relic.dtb \
>>> diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
>>> index 00614372119..f556857a391 100644
>>> --- a/board/sunxi/MAINTAINERS
>>> +++ b/board/sunxi/MAINTAINERS
>>> @@ -455,6 +455,11 @@ M:	Jernej Skrabec<jernej.skrabec@siol.net>
>>>    S:	Maintained
>>>    F:	configs/orangepi_zero2_defconfig
>>>    
>>> +ORANGEPI ZERO 3 BOARD
>>> +M:	Andre Przywara<andre.przywara@arm.com>
>>> +S:	Maintained
>>> +F:	configs/orangepi_zero3_defconfig
>>> +
>>>    ORANGEPI PC 2 BOARD
>>>    M:	Andre Przywara<andre.przywara@arm.com>
>>>    S:	Maintained
>>> diff --git a/configs/orangepi_zero3_defconfig b/configs/orangepi_zero3_defconfig
>>> new file mode 100644
>>> index 00000000000..e59044f6639
>>> --- /dev/null
>>> +++ b/configs/orangepi_zero3_defconfig
>>> @@ -0,0 +1,30 @@
>>> +CONFIG_ARM=y
>>> +CONFIG_ARCH_SUNXI=y
>>> +CONFIG_DEFAULT_DEVICE_TREE="sun50i-h618-orangepi-zero3"
>>> +CONFIG_SPL=y
>>> +CONFIG_DRAM_SUN50I_H616_DX_ODT=0x07070707
>>> +CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
>>> +CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
>>> +CONFIG_DRAM_SUN50I_H616_ODT_EN=0xaaaaeeee
>>> +CONFIG_DRAM_SUN50I_H616_TPR6=0x44000000
>>> +CONFIG_DRAM_SUN50I_H616_TPR10=0x402f6663
>>> +CONFIG_DRAM_SUN50I_H616_TPR11=0x24242624
>>> +CONFIG_DRAM_SUN50I_H616_TPR12=0x0f0f100f
>>> +CONFIG_MACH_SUN50I_H616=y
>>> +CONFIG_SUNXI_DRAM_H616_LPDDR4=y
>>> +CONFIG_R_I2C_ENABLE=y
>>> +CONFIG_SPL_SPI_SUNXI=y
>>> +# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>>> +CONFIG_SPL_I2C=y
>>> +CONFIG_SPL_SYS_I2C_LEGACY=y
>>> +CONFIG_SYS_I2C_MVTWSI=y
>>> +CONFIG_SYS_I2C_SLAVE=0x7f
>>> +CONFIG_SYS_I2C_SPEED=400000
>>> +CONFIG_SPI_FLASH_ZBIT=y
>>> +CONFIG_PHY_MOTORCOMM=y
>>> +CONFIG_SUN8I_EMAC=y
>>> +CONFIG_AXP313_POWER=y
>>> +CONFIG_SPI=y
>>> +CONFIG_USB_EHCI_HCD=y
>>> +CONFIG_USB_OHCI_HCD=y
>>> +CONFIG_USB_MUSB_GADGET=y
