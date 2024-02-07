Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5D8C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 08:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C18187C7D;
	Wed,  7 Feb 2024 09:17:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MAfezHZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D929987CBF; Wed,  7 Feb 2024 09:17:34 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 312D187BAC
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 09:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4f0f=JQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707293841;
 bh=9t7nNzYn9KtQUu4oiBoVgNVGWGQITBJC2HFWSIjx+/A=;
 b=MAfezHZ0e3Y6xc+YRXPLOzvMIfMaigWxf86E8eUQ9NR2RgQmsjV2BcQF9KCdjx/gkmEDz9LfM
 Y0g8B0hIKGGda/sZfYAXFt4gXROI9lCqKBNdDFbnUqoZG2A2LYnmfHcjW03Ny/2DLRV69ZZVKL3
 rDkXQryWhePWDm5MVuLf/c+zsKm3V598H+MKRHuIlMc6AMYx8mwcaBOHcUzCTCB6wGa4HZhZE3/
 OruB4sukG8m38aJq0iJ/GO3OPRcVFHoDJrPiD5wF2JHk2qrG0P0QNW89LBwiuq04aeUn8NsOJbm
 NcktY4Icug/32JmCtdAJOoD8LAtvQSR9PQzMOk2jfKHQ==
Message-ID: <386e5968-265c-4c5d-809d-0e6b11123610@kwiboo.se>
Date: Wed, 7 Feb 2024 09:17:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] rockchip: rk3328-roc-cc: Update defconfig
To: wens@csie.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Loic Devulder <ldevulder@suse.com>, u-boot@lists.denx.de
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-5-jonas@kwiboo.se>
 <CAGb2v64MC4MOgPUcJpoqP6VuMnRaVMKLkVBErVk=DU-y3nMTcw@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAGb2v64MC4MOgPUcJpoqP6VuMnRaVMKLkVBErVk=DU-y3nMTcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c33c913d20fd1d3b220a3c
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

On 2024-02-07 06:52, Chen-Yu Tsai wrote:
> On Wed, Feb 7, 2024 at 8:04 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Update defconfig for rk3328-roc-cc with new defaults.
>>
>> Remove the SPL_DRIVERS_MISC=y option, no misc driver is used in SPL.
>>
>> Add CONFIG_SPL_FIT_SIGNATURE=y to let SPL verify an auto generated hash
>> of FIT images. This help indicate if there is an issue loading any of
>> the images to DRAM or SRAM. Also add LEGACY_IMAGE_FORMAT=y to keep
>> support for scripts.
>>
>> Add ROCKCHIP_EFUSE=y and remove NET_RANDOM_ETHADDR=y, ethaddr and
>> eth1addr is set based on cpuid read from eFUSE.
> 
> I wonder if it would make sense to enable ROCKCHIP_EFUSE or ROCKCHIP_OTP
> for the respective SoCs by default, either with "imply" under the SoC
> Kconfig options, or "default if XXX" under the driver Kconfig options?
> Not sure which is preferred.
> 
> Same goes for CONFIG_MISC_INIT_R for actually generating the serial number
> and MAC addresses from the efuse/OTP.
> 
> At least for RK3566 and RK3588 we are implying these options.

I agree that these and lots of other Kconfig options could and should be
implied, either at soc or arch level.

Maybe something for a follow up series?

Regards,
Jonas

> 
> 
> ChenYu
> 
>> Add SPL_DM_SEQ_ALIAS=y option to use alias sequence number in SPL.
>>
>> Add DM_ETH_PHY=y, PHY_MOTORCOMM=y and PHY_REALTEK=y to support common
>> ethernet PHYs.
>>
>> Add RNG_ROCKCHIP=y and DM_RNG=y options to support the onboard random
>> generator.
>>
>> Also add missing device tree file to MAINTAINERS and add myself as a
>> reviewer for this board.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  board/rockchip/evb_rk3328/MAINTAINERS | 2 ++
>>  configs/roc-cc-rk3328_defconfig       | 9 +++++++--
>>  doc/board/rockchip/rockchip.rst       | 2 +-
>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
>> index 419bc8ded375..09488eaf083f 100644
>> --- a/board/rockchip/evb_rk3328/MAINTAINERS
>> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
>> @@ -41,8 +41,10 @@ F:      arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
>>  ROC-RK3328-CC
>>  M:      Loic Devulder <ldevulder@suse.com>
>>  M:      Chen-Yu Tsai <wens@csie.org>
>> +R:      Jonas Karlman <jonas@kwiboo.se>
>>  S:      Maintained
>>  F:      configs/roc-cc-rk3328_defconfig
>> +F:      arch/arm/dts/rk3328-roc-cc.dts
>>  F:      arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
>>
>>  ROCK64-RK3328
>> diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
>> index 4ac3c9403b02..7d81a715ef25 100644
>> --- a/configs/roc-cc-rk3328_defconfig
>> +++ b/configs/roc-cc-rk3328_defconfig
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
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-roc-cc.dtb"
>>  # CONFIG_DISPLAY_CPUINFO is not set
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>> @@ -58,8 +59,8 @@ CONFIG_TPL_OF_PLATDATA=y
>>  CONFIG_ENV_IS_IN_MMC=y
>>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>  CONFIG_SYS_MMC_ENV_DEV=1
>> -CONFIG_NET_RANDOM_ETHADDR=y
>>  CONFIG_TPL_DM=y
>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>>  CONFIG_REGMAP=y
>>  CONFIG_SPL_REGMAP=y
>>  CONFIG_TPL_REGMAP=y
>> @@ -73,9 +74,11 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>>  CONFIG_ROCKCHIP_GPIO=y
>>  CONFIG_SYS_I2C_ROCKCHIP=y
>>  CONFIG_MISC=y
>> +CONFIG_ROCKCHIP_EFUSE=y
>>  CONFIG_MMC_DW=y
>>  CONFIG_MMC_DW_ROCKCHIP=y
>>  CONFIG_PHY_REALTEK=y
>> +CONFIG_DM_ETH_PHY=y
>>  CONFIG_PHY_GIGE=y
>>  CONFIG_ETH_DESIGNWARE=y
>>  CONFIG_GMAC_ROCKCHIP=y
>> @@ -95,6 +98,8 @@ CONFIG_PWM_ROCKCHIP=y
>>  CONFIG_RAM=y
>>  CONFIG_SPL_RAM=y
>>  CONFIG_TPL_RAM=y
>> +CONFIG_DM_RNG=y
>> +CONFIG_RNG_ROCKCHIP=y
>>  CONFIG_BAUDRATE=1500000
>>  CONFIG_DEBUG_UART_SHIFT=2
>>  CONFIG_SYS_NS16550_MEM32=y
>> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
>> index de2195deadca..99f48b6d6fa5 100644
>> --- a/doc/board/rockchip/rockchip.rst
>> +++ b/doc/board/rockchip/rockchip.rst
>> @@ -60,8 +60,8 @@ List of mainline supported Rockchip boards:
>>       - ODROID-GO Advance (odroid-go2)
>>  * rk3328
>>       - Rockchip Evb-RK3328 (evb-rk3328)
>> +     - Firefly ROC-RK3328-CC (roc-cc-rk3328)
>>       - Pine64 Rock64 (rock64-rk3328)
>> -     - Firefly-RK3328 (roc-cc-rk3328)
>>       - Radxa Rockpi E (rock-pi-e-rk3328)
>>  * rk3368
>>       - GeekBox (geekbox)
>> --
>> 2.43.0
>>

