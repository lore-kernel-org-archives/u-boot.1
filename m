Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AF1C3ABC5
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 23:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6C98283E;
	Fri,  9 May 2025 01:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98B68828BC; Fri,  9 May 2025 01:24:28 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98C018269F
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 01:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: zesmtpip3t1746746611tac2f06de
X-QQ-Originating-IP: R898cUrjIWn88keca4olHn1CKTOmv5GC3zL1sTQlaNo=
Received: from [IPV6:240f:10b:7440:1:a1e5:ffb0 ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 May 2025 07:23:26 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10782299689739338221
Message-ID: <C119E01C6AE7689F+c4d7884d-d5a1-4e0f-919c-ae505e48d1db@radxa.com>
Date: Fri, 9 May 2025 08:23:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] rockchip: Add support for RAM boot from maskrom
 mode
To: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Arnaud Patard <arnaud.patard@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20250405153832.1427549-1-jonas@kwiboo.se>
 <20250405153832.1427549-3-jonas@kwiboo.se>
 <5da254a9-b86d-4ce7-a14e-5a8226c47890@rock-chips.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <5da254a9-b86d-4ce7-a14e-5a8226c47890@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MB5+LsFw85NoSH87gJCqOdcZasGB4kjQVuFrQgiFY9L1CvGQC8PowHT5
 9IHLxBEVZsVjDypkSCM2NBwBkl84tNnKYpmY1a+Q7xABJTVJie4llwu1BMgTULL4+1p3ofI
 JZbrJfrV9BzIm5oG/DunBPf297F+4r1FDQaJt6mVP5mXgihrWpqJA0f7KqkY0CIZwWFUXO+
 aQX2KZQGKGRcuEHbNTIQmnub9LPZCv0YltiTTsXXH9ZyhX+3j+u+wkMtJjwoo7KxYg8ZBow
 YPWIuB6+kuwuEeAepQfqqEbxTTJNeQ/SMzsQFGHI5xaEeJKSTRxl3Ju8kFiJH11ygSI2tzQ
 9EmKlCSEVB/7R1H3Q02heGHIAKazY4Ur2nAOiK+4caYwqHIMRTHnYOkwiJAkCvqQMWyVK2L
 eXAM4ksnkymzObJQL33nwXHHvo459QNJ3XW2CDrTygJDy1ROuSbIQRQts9vjPDTxKDntoIh
 fAtOLkr2abK7nq//DUzwxG+2jmmh967GJ7etOcjW6XxZ4fGMxtZcp5O2Um9LAlnFIn67zwV
 9TWf/CkLbY/21QbudqxBJybalZEwrAvI3PA4wRrBN0wO1PABBRHl66EEJQbRyMrGZ4mfb/Q
 CmFAZtCCJyTOG/1K5cq10721CFE/YsIDbI7rctquEfMbMDXTeoWXrSPZpgB49zxgV96b9Fr
 qIdn8nWNhbOmm4aBs31Vvv3NudAvIZL9RFmxGSzdgMtvRR6Pno4rwQndho1JK3HcAeDSMIU
 rddFQLDqZ2t/G+ZpcWx20KUkUwESRgG2zAEa64CEB5vynriveo1nVOGfdcrB3dNFIMPWVkR
 6O+tXaSOqq/o9e3S3oqTmpwe2Ayeb+v6WGOLVTYVSmbEBN8cifymhjTn3HydZoFW0wGuVpj
 /xoFvUjwQTrf4olGBS0U//b/lQA2DEwfMox8w3N64AB1wKlT/HHaUUIIs7OlEQiK9oI3vMA
 6jv2TecG/wWxrWvzrDwZVHTsqhEef371vwD301EJC7q25APKuutMrE+XK
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
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

Hi Kever Yang,

On 5/8/25 12:06, Kever Yang wrote:
> Hi Jonas,
> 
> 
>      Thanks for your patch, and the ramboot with usb download do help 
> bootloader developers.
> 
> On 2025/4/5 23:38, Jonas Karlman wrote:
>> The BootROM in Rockchip SoCs will enter maskrom mode when boot firmware
>> cannot be found in nand/spi/mmc storage.
>>
>> In maskrom mode the USB OTG port can accept one of two custom commands.
>>
>> Initially a 0x471 command to load TPL into SRAM. After TPL has been
>> executed and it has returned back-to-BROM, a 0x472 command to load SPL
>> into start of DRAM.
>>
>> Add two binman images that can be used to RAM boot from maskrom mode:
>> - u-boot-rockchip-usb471.bin that contains TPL to init DRAM.
>> - u-boot-rockchip-usb472.bin that contains SPL and the normal FIT
>>    payload with i.e. U-Boot proper, TF-A and FDT.
> 
> This makes things quite complicated, needs so many new binaries and 
> tools which
> 
> lead to confuse to users.
> 
> Let's make it simple for RAM boot with usb download so that user can use 
> it easily:
> 
> use rkdeveloptool to download the loader and boot from RAM, and that's all.

It requires boot_merger which is not included in U-Boot, right?

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Thanks,
> - Kever
>> These images can be used with rkbin tools/boot_merger to create a loader
>> image to be used with rkdeveloptool or rockusb tools, e.g.:
>>
>>    Create loader image:
>>      $ ../rkbin/tools/boot_merger ./RK3588MINIALL.ini
>>
>>    Boot from maskrom:
>>      $ rkdeveloptool db u-boot-rockchip-rk3588-loader.bin
>>     or
>>      $ rockusb download-boot u-boot-rockchip-rk3588-loader.bin
>>
>> Or directly with tools such as rkflashtool or rkusbboot:
>>
>>    $ rkflashtool l < u-boot-rockchip-usb471.bin
>>    $ rkflashtool L < u-boot-rockchip-usb472.bin
>>   or
>>    $ rkusbboot u-boot-rockchip-usb471.bin u-boot-rockchip-usb472.bin
>>
>> Signed-off-by: Jonas Karlman<jonas@kwiboo.se>
>> Tested-by: Arnaud Patard<arnaud.patard@collabora.com>
>> ---
>> v2: Use fit_template instead of common_part
>> v2: Collect t-b tag
>> ---
>>   arch/arm/dts/rockchip-u-boot.dtsi       | 33 +++++++++++++++++++++++++
>>   arch/arm/mach-rockchip/Kconfig          |  8 ++++++
>>   arch/arm/mach-rockchip/spl-boot-order.c | 15 ++++++++---
>>   boot/Kconfig                            |  3 +++
>>   4 files changed, 56 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>> index 0dfd45bb9bed..dafae297d0cf 100644
>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>> @@ -231,5 +231,38 @@
>>   		};
>>   	};
>>   #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
>> +
>> +#ifdef CONFIG_ROCKCHIP_MASKROM_IMAGE
>> +	simple-bin-usb471 {
>> +		filename = "u-boot-rockchip-usb471.bin";
>> +
>> +#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
>> +		rockchip-tpl {
>> +		};
>> +#elif defined(CONFIG_TPL)
>> +		u-boot-tpl {
>> +			no-write-symbols;
>> +		};
>> +#endif
>> +	};
>> +
>> +	simple-bin-usb472 {
>> +		filename = "u-boot-rockchip-usb472.bin";
>> +		pad-byte = <0x00>;
>> +
>> +		u-boot-spl {
>> +			no-write-symbols;
>> +		};
>> +
>> +#ifdef HAS_FIT
>> +		fit {
>> +			insert-template = <&fit_template>;
>> +#else
>> +		u-boot-img {
>> +#endif
>> +			offset = <(CONFIG_SPL_LOAD_FIT_ADDRESS - CFG_SYS_SDRAM_BASE)>;
>> +		};
>> +	};
>> +#endif /* CONFIG_ROCKCHIP_MASKROM_IMAGE */
>>   };
>>   #endif /* CONFIG_SPL */
>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>> index c9d8f9105083..e817bf46e565 100644
>> --- a/arch/arm/mach-rockchip/Kconfig
>> +++ b/arch/arm/mach-rockchip/Kconfig
>> @@ -607,6 +607,14 @@ config ROCKCHIP_SPI_IMAGE
>>   	  option to produce a SPI-flash image containing U-Boot. The image
>>   	  is built by binman. U-Boot sits near the start of the image.
>>   
>> +config ROCKCHIP_MASKROM_IMAGE
>> +	bool "Build a maskrom mode image for Rockchip"
>> +	depends on TPL || ROCKCHIP_EXTERNAL_TPL
>> +	select SPL_RAM_DEVICE
>> +	help
>> +	  Rockchip SoCs support maskrom mode boot over USB. Enable this
>> +	  option to produce maskrom mode boot images containing U-Boot.
>> +
>>   config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>>   	default TEXT_BASE
>>   
>> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
>> index 3dce9b30898d..20cbee8c9ff4 100644
>> --- a/arch/arm/mach-rockchip/spl-boot-order.c
>> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
>> @@ -8,7 +8,9 @@
>>   #include <log.h>
>>   #include <mmc.h>
>>   #include <spl.h>
>> +#include <asm/arch-rockchip/bootrom.h>
>>   #include <asm/global_data.h>
>> +#include <asm/io.h>
>>   #include <dm/uclass-internal.h>
>>   
>>   #if CONFIG_IS_ENABLED(OF_LIBFDT)
>> @@ -98,15 +100,22 @@ __weak const char *board_spl_was_booted_from(void)
>>   
>>   void board_boot_order(u32 *spl_boot_list)
>>   {
>> +	int idx = 0;
>> +
>> +	/* Add RAM boot for maskrom mode boot over USB */
>> +	if (BROM_BOOTSOURCE_ID_ADDR && CONFIG_IS_ENABLED(RAM_DEVICE) &&
>> +	    readl(BROM_BOOTSOURCE_ID_ADDR) == BROM_BOOTSOURCE_USB) {
>> +		spl_boot_list[idx++] = BOOT_DEVICE_RAM;
>> +	}
>> +
>>   	/* In case of no fdt (or only plat), use spl_boot_device() */
>>   	if (!CONFIG_IS_ENABLED(OF_CONTROL) || CONFIG_IS_ENABLED(OF_PLATDATA)) {
>> -		spl_boot_list[0] = spl_boot_device();
>> +		spl_boot_list[idx++] = spl_boot_device();
>>   		return;
>>   	}
>>   
>>   	const void *blob = gd->fdt_blob;
>>   	int chosen_node = fdt_path_offset(blob, "/chosen");
>> -	int idx = 0;
>>   	int elem;
>>   	int boot_device;
>>   	int node;
>> @@ -115,7 +124,7 @@ void board_boot_order(u32 *spl_boot_list)
>>   	if (chosen_node < 0) {
>>   		debug("%s: /chosen not found, using spl_boot_device()\n",
>>   		      __func__);
>> -		spl_boot_list[0] = spl_boot_device();
>> +		spl_boot_list[idx++] = spl_boot_device();
>>   		return;
>>   	}
>>   
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index f101200ba7a5..abfc9eaf325f 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -246,6 +246,9 @@ config SPL_LOAD_FIT_ADDRESS
>>   	hex "load address of fit image"
>>   	depends on SPL_LOAD_FIT
>>   	default 0x44000000 if ARCH_IMX8M
>> +	default 0x60080000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x60000000
>> +	default 0x40200000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x40000000
>> +	default 0x00200000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x00000000
>>   	default 0x0
>>   	help
>>   	  Specify the load address of the fit image that will be loaded

