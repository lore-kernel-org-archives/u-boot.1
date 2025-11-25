Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97AED0E6ED
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 14:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A3D98404D;
	Tue, 25 Nov 2025 15:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZODO+68b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B56508409B; Tue, 25 Nov 2025 15:20:22 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90F9283FFE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 15:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dG4bQ3nK6z9swN;
 Tue, 25 Nov 2025 15:20:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764080418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8EravAMm1yF8DdX2p1DaoMJx8q4Pm8q9mfGPZvNTvXQ=;
 b=ZODO+68bGQI+m0Lz8CMxNDa/B/Ii5OqXvop3ISnh3OTDdrRYfQ/azdimW5ROZVD24QRsiZ
 F3zcZNhJt7iY7B6sbgSLvkmVcpb/kC/kFHSFhbDh/sknyfXMbgFMDTsC1YvxjOXlI+UTuT
 udrc7mh0sQjCd83OGeky/oYDJ1CWCJ2S2XiwIrkWokV3r6UHZFppJu+pFvzHqHgJBO+11x
 4fT4xIUSLKg1TJfzmWU8Hz2kR2sGrzjfUbiUi42+zuhVttpnnoCG0DOj42rEY8uewA0cfO
 u/O68vsnEn0NcDhFP/GxFujMDyWheskTht07U/89Dprj/+9k+WernOAdIeM9dw==
Message-ID: <889f9772-a50f-47e2-a678-1316a8be296a@mailbox.org>
Date: Tue, 25 Nov 2025 15:20:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mkimage: Add support for bundling TEE in mkimage -f auto
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
References: <20251118232045.578034-1-marek.vasut@mailbox.org>
 <9e9ec219-3ae7-4ec8-8f85-5edb4bbbe53a@cherry.de>
 <7b21c476-ed12-48da-95f7-dd354e116a70@mailbox.org>
 <9bb15fc9-7434-4ba4-814b-d99cdcd7a4f8@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <9bb15fc9-7434-4ba4-814b-d99cdcd7a4f8@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 441a055c8759ae21df2
X-MBO-RS-META: s65je4m1keum1dobdpmcps4itwpub8j7
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

On 11/25/25 11:07 AM, Quentin Schulz wrote:

Hello Quentin,

>>>> Example invocation:
>>>> "
>>>> $ mkimage -E -A arm -C none -e 0xc0008000 -a 0xc0008000 -f auto \
>>>>            -d arch/arm/boot/zImage \
>>>>            -b arch/arm/boot/dts/st/stm32mp135f-dhcor-dhsbc.dtb \
>>>>            -z ../optee_os/out/arm-plat-stm32mp1/core/tee-raw.bin \
>>>>       -Z 0xde000000 \
>>>>            /path/to/output/fitImage
>>>> "
>>
>> ...
>>
>>> Which formats are supported for the --tee-file parameter? OP-TEE OS 
>>> itself has multiple versions for the binary header (v1 and v2?) and 
>>> we can pass either a binary (tee.bin) or an ELF (tee.elf) in binman, 
>>> c.f. tools/binman/etype/tee_os.py
>>
>> The raw binary only, see the example invocation above.
>>
> 
> Must be documented then please.

Where would you document this ? In the manpage ? Elsewhere ?

>> [...]
>>
>>> OK so... On Rockchip we have TF-A and OP-TEE OS split in multiple 
>>> entries with different load addresses (see @atf-seq and @tee-seq in 
>>> arch/arm/dts/rockchip-u-boot.dtsi). I guess this means we wouldn't be 
>>> able to use this auto FIT?
>>
>> Are those multiple "versions" of these binaries or are those really 
>> separate parts of a single binary ? The later seems a bit odd. Do you 
>> have an example of such configuration?
>>
> 
> Same binary split.
> 
> Rk3399, PX30 and RK3588 (the three Rockchip SoCs we use on our product 
> line) have this.
> 
> - For PX30:
> 
> Checkout trusted-firmware-a repo and build with
> 
> make CROSS_COMPILE=aarch64-linux-gnu- PLAT=px30 -j`nproc`
> 
> Compile U-Boot:
> 
> export BL31=/path/to/trusted-firmware-a/build/px30/release/bl31/bl31.elf
> 
> make CROSS_COMPILE=aarch64-linux-gnu- O=build/ringneck ringneck- 
> px30_defconfig -j`nproc`
> 
> - For RK3399:
> 
> Checkout trusted-firmware-a repo and build with
> 
> make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3399 -j`nproc`
> 
> Compile U-Boot:
> 
> export BL31=/path/to/trusted-firmware-a/build/rk3399/release/bl31/bl31.elf
> 
> make CROSS_COMPILE=aarch64-linux-gnu- O=build/puma puma-rk3399_defconfig 
> -j`nproc`
> 
> For PX30:
> 
> $ mkimage -l build/ringneck/u-boot.itb
> FIT description: FIT image for U-Boot with bl31 (TF-A)
> Created:         Tue Nov 25 10:52:42 2025
>   Image 0 (u-boot)
>    Description:  U-Boot
>    Created:      Tue Nov 25 10:52:42 2025
>    Type:         Standalone Program
>    Compression:  uncompressed
>    Data Size:    659944 Bytes = 644.48 KiB = 0.63 MiB
>    Architecture: AArch64
>    Load Address: 0x00200000
>    Entry Point:  0x00200000
>    Hash algo:    sha256
>    Hash value: 
> 2f6a1658befcd8330843ed5d61ee5b539000f3dca5f2b35311be064596fc94f7
>   Image 1 (atf-1)
>    Description:  ARM Trusted Firmware
>    Created:      Tue Nov 25 10:52:42 2025
>    Type:         Firmware
>    Compression:  uncompressed
>    Data Size:    106496 Bytes = 104.00 KiB = 0.10 MiB
>    Architecture: AArch64
>    OS:           ARM Trusted Firmware
>    Load Address: 0x00040000
>    Hash algo:    sha256
>    Hash value: 
> e6d48a0c4a47d8132d8185b58a1f5e44c025eed6eb9c4328a40feec85446281e
>   Image 2 (atf-2)
>    Description:  ARM Trusted Firmware
>    Created:      Tue Nov 25 10:52:42 2025
>    Type:         Firmware
>    Compression:  uncompressed
>    Data Size:    129 Bytes = 0.13 KiB = 0.00 MiB
>    Architecture: AArch64
>    OS:           ARM Trusted Firmware
>    Load Address: 0x0005a000
>    Hash algo:    sha256
>    Hash value: 
> 3125317584ab4860216e817612321962a0a904f14c830fd64961eaf12c15215a
>   Image 3 (atf-3)
>    Description:  ARM Trusted Firmware
>    Created:      Tue Nov 25 10:52:42 2025
>    Type:         Firmware
>    Compression:  uncompressed
>    Data Size:    112 Bytes = 0.11 KiB = 0.00 MiB
>    Architecture: AArch64
>    OS:           ARM Trusted Firmware
>    Load Address: 0xff020000
>    Hash algo:    sha256
>    Hash value: 
> d856721b954d3b7d74bca14ae49a3ce52b17acde932bb2218f927af73c422b9b
>   Image 4 (fdt-1)
>    Description:  fdt-rockchip/px30-ringneck-haikou
>    Created:      Tue Nov 25 10:52:42 2025
>    Type:         Flat Device Tree
>    Compression:  uncompressed
>    Data Size:    72912 Bytes = 71.20 KiB = 0.07 MiB
>    Architecture: Unknown Architecture
>    Hash algo:    sha256
>    Hash value: 
> 0d8d2d650a311a7085ccb883409e680daec58df83a27b76724de60465342777e
>   Default Configuration: 'config-1'
>   Configuration 0 (config-1)
>    Description:  rockchip/px30-ringneck-haikou.dtb
>    Kernel:       unavailable
>    Firmware:     atf-1
>    FDT:          fdt-1
>    Loadables:    u-boot
>                  atf-2
>                  atf-3
> 
> According to datasheet:
> 
> 0x00040000 = DRAM
> 0x0005a000 = DRAM
> 0xff020000 = PMU_MEM (SRAM?)
> 
> $ mkimage -l build/puma/u-boot.itb
> FIT description: FIT image for U-Boot with bl31 (TF-A)
> Created:         Tue Nov 25 10:53:47 2025
>   Image 0 (u-boot)
>    Description:  U-Boot
>    Created:      Tue Nov 25 10:53:47 2025
>    Type:         Standalone Program
>    Compression:  uncompressed
>    Data Size:    897112 Bytes = 876.09 KiB = 0.86 MiB
>    Architecture: AArch64
>    Load Address: 0x00200000
>    Entry Point:  0x00200000
>    Hash algo:    sha256
>    Hash value: 
> 5da93c500366e99d5fe3acb84b32b5757a90d8ef32fe73052bc20f6ca17f0b89
>   Image 1 (atf-1)
>    Description:  ARM Trusted Firmware
>    Created:      Tue Nov 25 10:53:47 2025
>    Type:         Firmware
>    Compression:  uncompressed
>    Data Size:    143360 Bytes = 140.00 KiB = 0.14 MiB
>    Architecture: AArch64
>    OS:           ARM Trusted Firmware
>    Load Address: 0x00040000
>    Hash algo:    sha256
>    Hash value: 
> 30e187d1b9c029657b1a9e029e5f7ad34fbfd5f9ca4a44cb1cb48750a92cf09b
>   Image 2 (atf-2)
>    Description:  ARM Trusted Firmware
>    Created:      Tue Nov 25 10:53:47 2025
>    Type:         Firmware
>    Compression:  uncompressed
>    Data Size:    81 Bytes = 0.08 KiB = 0.00 MiB
>    Architecture: AArch64
>    OS:           ARM Trusted Firmware
>    Load Address: 0x00063000
>    Hash algo:    sha256
>    Hash value: 
> 7380684a38dedb22d648d835934ef573c3e32a15e4b81cbc4ec158d17cb707ea
>   Image 3 (atf-3)
>    Description:  ARM Trusted Firmware
>    Created:      Tue Nov 25 10:53:47 2025
>    Type:         Firmware
>    Compression:  uncompressed
>    Data Size:    8024 Bytes = 7.84 KiB = 0.01 MiB
>    Architecture: AArch64
>    OS:           ARM Trusted Firmware
>    Load Address: 0xff3b0000
>    Hash algo:    sha256
>    Hash value: 
> a887bbaec347403739e27430cc512922178b694ebe001e22c2cb4774254d67e6
>   Image 4 (atf-4)
>    Description:  ARM Trusted Firmware
>    Created:      Tue Nov 25 10:53:47 2025
>    Type:         Firmware
>    Compression:  uncompressed
>    Data Size:    8192 Bytes = 8.00 KiB = 0.01 MiB
>    Architecture: AArch64
>    OS:           ARM Trusted Firmware
>    Load Address: 0xff8c0000
>    Hash algo:    sha256
>    Hash value: 
> 67bf4dd100c6c99dbbf76c0b19072e6e9756383925795d94ced000c2a7cf3b9e
>   Image 5 (atf-5)
>    Description:  ARM Trusted Firmware
>    Created:      Tue Nov 25 10:53:47 2025
>    Type:         Firmware
>    Compression:  uncompressed
>    Data Size:    0 Bytes = 0.00 KiB = 0.00 MiB
>    Architecture: AArch64
>    OS:           ARM Trusted Firmware
>    Load Address: 0xff8c2000
>    Hash algo:    sha256
>    Hash value: 
> e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
>   Image 6 (fdt-1)
>    Description:  fdt-rockchip/rk3399-puma-haikou
>    Created:      Tue Nov 25 10:53:47 2025
>    Type:         Flat Device Tree
>    Compression:  uncompressed
>    Data Size:    97832 Bytes = 95.54 KiB = 0.09 MiB
>    Architecture: Unknown Architecture
>    Hash algo:    sha256
>    Hash value: 
> 5439f6f77ab01fa191a6a69a8691165669497fe74fc909f13a6d448b1004d629
>   Default Configuration: 'config-1'
>   Configuration 0 (config-1)
>    Description:  rockchip/rk3399-puma-haikou.dtb
>    Kernel:       unavailable
>    Firmware:     atf-1
>    FDT:          fdt-1
>    Loadables:    u-boot
>                  atf-2
>                  atf-3
>                  atf-4
>                  atf-5
> 
> According to the datasheet:
> 
> 0x00040000 = RAM
> 0x00063000 = RAM
> 0xff3b0000 = INTMEM1 (SRAM)
> 0xff8c0000 = INTMEM0 (SRAM)
> 0xff8c2000 = INTMEM0 (SRAM)
> 
> RK3399 is a special case because TF-A is running both on A and M cores.

Neither of the binaries listed above is TEE ?

I can imagine you can have tee header and something else bundled in the 
fitImage, but for such more complex case, better use .its file to 
describe it.
