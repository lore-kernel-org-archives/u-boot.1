Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A4DC4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 08:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5560687CCB;
	Wed,  7 Feb 2024 09:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="l5LKRdty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF4CD87CD2; Wed,  7 Feb 2024 09:34:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6787E87CB5
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 09:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4f0f=JQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707294861;
 bh=tvintl29eaUMT7c3NWg+rkuBkzPYvGqoPXuBTG8ZqzY=;
 b=l5LKRdtyY7AtJPJCue6OcO5vJeVtBXlgV3Nb7UbDu1oYWtEXC0dp/PWwT/Un7+sOeb7L9yVmD
 giG9EabNZH12JQvSSAyZGWsEfAXs/N571D4dDiYLD349P4o/D/hUtOfPvIcWVPL29QYuUyOmY+K
 w/dNNZh1LVwY0nL6Rp25F1CYyNa6H00imH6oZ1Wq+i+2wjez4TnHvQCtpemgagTIJBHnuVuTZlz
 DrvlRPOE/+i0xY+INyeYSmcNdHLZ/E5b6OgQx0J/DJilFw+hr4bJ27n3hFVGHgufqbZr34RW4iO
 snbaOySXVQG9MmmxUw5TJ4/pBSJ4SxeQJnfRKqoNGNiA==
Message-ID: <efab8cb7-ea17-4ce6-988e-5e0231f11851@kwiboo.se>
Date: Wed, 7 Feb 2024 09:34:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] rockchip: rk3328-rock64: Update defconfig
Content-Language: en-US
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-4-jonas@kwiboo.se>
 <CAJs94Eat5OcLjTuyAMLkBRWJwBEQ0+vJnnqLT7+krGd1zPrV-A@mail.gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAJs94Eat5OcLjTuyAMLkBRWJwBEQ0+vJnnqLT7+krGd1zPrV-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c3408d3d20fd1d3b220b9b
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

On 2024-02-07 08:53, Matwey V. Kornilov wrote:
> ср, 7 февр. 2024 г. в 03:14, Jonas Karlman <jonas@kwiboo.se>:
>>
>> Update defconfig for rk3328-rock64 with new defaults.
>>
>> Remove the SPL_DRIVERS_MISC=y option, no misc driver is used in SPL.
> 
> What is abould rockchip-efuse?

The efuse driver is only used in U-Boot proper to read cpuid for serial#
and ethaddr use, there is nothing trying to access efuse in TPL or SPL.

Beside the initialization of efuse block done after commit 5708e8eeae53
("rockchip: rk3328: Set efuse auto mode and timing control"). But that
happens outside the efuse driver, in arch_cpu_init() at SPL.

So it is safe to skip DRIVERS_MISC for TPL/SPL and current intended use
of efuse still continues to work.

Regards,
Jonas

> 
>>
>> Add CONFIG_SPL_FIT_SIGNATURE=y to let SPL verify an auto generated hash
>> of FIT images. This help indicate if there is an issue loading any of
>> the images to DRAM or SRAM. Also add LEGACY_IMAGE_FORMAT=y to keep
>> support for scripts.
>>
>> Remove the NET_RANDOM_ETHADDR=y option, ethaddr and eth1addr is set
>> based on cpuid read from eFUSE.
>>
>> Add SPL_DM_SEQ_ALIAS=y option to use alias sequence number in SPL.
>>
>> Add DM_ETH_PHY=y and PHY_REALTEK=y to support onboard ethernet PHY.
>>
>> Also add missing device tree file to MAINTAINERS and add myself as a
>> reviewer for this board.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  board/rockchip/evb_rk3328/MAINTAINERS | 2 ++
>>  configs/rock64-rk3328_defconfig       | 7 +++++--
>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
>> index dc750bd69426..419bc8ded375 100644
>> --- a/board/rockchip/evb_rk3328/MAINTAINERS
>> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
>> @@ -47,8 +47,10 @@ F:      arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
>>
>>  ROCK64-RK3328
>>  M:      Matwey V. Kornilov <matwey.kornilov@gmail.com>
>> +R:      Jonas Karlman <jonas@kwiboo.se>
>>  S:      Maintained
>>  F:      configs/rock64-rk3328_defconfig
>> +F:      arch/arm/dts/rk3328-rock64.dts
>>  F:      arch/arm/dts/rk3328-rock64-u-boot.dtsi
>>
>>  ROCKPIE-RK3328
>> diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
>> index 0297d098761e..0157a1efe374 100644
>> --- a/configs/rock64-rk3328_defconfig
>> +++ b/configs/rock64-rk3328_defconfig
>> @@ -15,7 +15,6 @@ CONFIG_ROCKCHIP_RK3328=y
>>  CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
>>  CONFIG_TPL_LIBCOMMON_SUPPORT=y
>>  CONFIG_TPL_LIBGENERIC_SUPPORT=y
>> -CONFIG_SPL_DRIVERS_MISC=y
>>  CONFIG_SPL_STACK_R_ADDR=0x600000
>>  CONFIG_SPL_STACK=0x400000
>>  CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
>> @@ -26,7 +25,9 @@ CONFIG_DEBUG_UART=y
>>  # CONFIG_ANDROID_BOOT_IMAGE is not set
>>  CONFIG_FIT=y
>>  CONFIG_FIT_VERBOSE=y
>> +CONFIG_SPL_FIT_SIGNATURE=y
>>  CONFIG_SPL_LOAD_FIT=y
>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock64.dtb"
>>  # CONFIG_DISPLAY_CPUINFO is not set
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>> @@ -57,8 +58,8 @@ CONFIG_TPL_OF_PLATDATA=y
>>  CONFIG_ENV_IS_IN_MMC=y
>>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>  CONFIG_SYS_MMC_ENV_DEV=1
>> -CONFIG_NET_RANDOM_ETHADDR=y
>>  CONFIG_TPL_DM=y
>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>>  CONFIG_REGMAP=y
>>  CONFIG_SPL_REGMAP=y
>>  CONFIG_TPL_REGMAP=y
>> @@ -76,6 +77,8 @@ CONFIG_ROCKCHIP_EFUSE=y
>>  CONFIG_MMC_DW=y
>>  CONFIG_MMC_DW_ROCKCHIP=y
>>  CONFIG_SPI_FLASH_GIGADEVICE=y
>> +CONFIG_PHY_REALTEK=y
>> +CONFIG_DM_ETH_PHY=y
>>  CONFIG_ETH_DESIGNWARE=y
>>  CONFIG_GMAC_ROCKCHIP=y
>>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>> --
>> 2.43.0
>>
> 
> 

