Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A30D6B6B3
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 16:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F2F089206;
	Wed, 30 Oct 2024 17:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="I9v7CuZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A50289206; Wed, 30 Oct 2024 17:55:14 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5089488C05
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=704e=R3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1730307301;
 bh=jY5co4IiRhfdiXFaKN0qv7l9kykBgGOmTASE2e/jY18=;
 b=I9v7CuZSf/WD0TPDXu0LMUHY/FiDV6zKcuG/ciCQ9SYO+SpcFBTiX40Uvv2M7BhQgU9nPV6zr
 3zo0AWinkll78HqiQAbNHpVUIwtxHX3f0cfQ4T8PtbRKCLE8xD/6ijheJ/aN1Psg60MtyZn5wzR
 /7go4FVJHoG8Ge0On2YqQwgUmaz3u0x2TVtsX7ZZD/Y9joyV1C3KZLqSvC8Vx8+ndwuB6XfqmXC
 e7JwE7ez1LD/J8msQH65iIChS0dHMmDKzKduSKYoEyZc1pkjjKzrR8sl4m9+x0+iiCWiI1VH7Vt
 dI1Q2NvemgqGCOYnmdFi4BSmG1dT9A6IhzSp+Yc4Mmgw==
Message-ID: <837ed778-e6b6-4b2f-a196-016d3eb08bae@kwiboo.se>
Date: Wed, 30 Oct 2024 17:54:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk356x: Implement checkboard() to print SoC
 variant
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Dragan Simic <dsimic@manjaro.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20241018163423.1562287-1-jonas@kwiboo.se>
 <20241018163423.1562287-2-jonas@kwiboo.se>
 <424c80ea-3dbc-46eb-8558-ac20e7c34b85@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <424c80ea-3dbc-46eb-8558-ac20e7c34b85@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672264e3ccab48d3273111ae
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

Hi Kever,

On 2024-10-30 07:40, Kever Yang wrote:
> Hi Jonas,
> 
> 
> On 2024/10/19 00:34, Jonas Karlman wrote:
>> Implement checkboard() to print current SoC model, e.g. one of:
>>
>>    SoC:   RK3566 v1
>>    SoC:   RK3566 v2
>>    SoC:   RK3566T v2
>>    SoC:   RK3568 v2
>>    SoC:   RK3568B2 v2
>>    SoC:   RK3568J v2
> 
> Did you get these types from different board, or is  there a document 
> for this?

These are the unique prints running the checkboard() on different rk356x
boards I have.

> 
> I didn't see this kind of document :(

I did not find this information in any document, this was mostly based
on patterns in observed OTP values sampled from different boards.

Information for cpu-code (3566 or 3568) and cpu-version (0, 1 or 2) was
picked from vendor 4.19/5.10/6.1 DTs from the OTP nvmem cells.

The cpu-version also seem to correspond to the second letter of the lot
number, e.g. 0x0 = xAxxxxxx yyww, 0x1 = xBxxxxxx yyww etc.

Information about the B, J and S variant seem to be consistent for both
rk356x and rk3588. Vendor 5.10/6.1 kernel driver for cpufreq/gpu/opp use
specification_serial_number nvmem cell to detect rk3588 M (0xd) and
J (0xa) variants.

The value seemed to correspond to 0x1 = A, 0x2 = B, ..., 0xa = J,
0xd = M, 0x13 = S, i.e. '@' + <value> = variant char in ascii table.

Information about the B2 or S2 revision seemed to correspond to the
package_serial_number nvmem cells on rk3588. Similar bits also seemed to
exist for rk356x even if there was no ref to package_serial_number in
any vendor DT for rk356x. E.g. on boards with B2 or S2 soc variants had
package_serial_number = 0x2, rest of my boards had a value of 0x1.

The T-variant of rk3566 did not seem to follow above pattern and it
instead use specification_serial_number = 0x1. A commit "arm64: dts:
rockchip: rk3568: adjust opp-table for rk356x-t" [1] instead pointed to
a performance nvmem cell.

For all my RK3566T boards that performance byte in OTP was 0x51, and if
I play with that value: 0x51 >> 2 = 0x14 => 'T'-variant ;-)

If you have any details and/or can confirm if some of my assumptions
above are correct or not correct that would be nice :-)

[1] https://github.com/radxa/kernel/commit/2dfd51da472e7ebb5ef0d3db78f902454af826b8

> 
> 
>>
>> when U-Boot proper is started.
>>
>> Information about what SoC model, variant and version is read from OTP.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/dts/rk356x-u-boot.dtsi        |  4 ++
>>   arch/arm/mach-rockchip/rk3568/rk3568.c | 65 ++++++++++++++++++++++++++
>>   configs/generic-rk3568_defconfig       |  2 +-
> 
> Please split the driver change and config/dts change in different patch.

I will split in a v2 and look into reworking this as a sysinfo driver.

Regards,
Jonas

> 
> 
> Thanks,
> - Kever
>>   3 files changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
>> index 0a0943b462a9..24a976cf7e21 100644
>> --- a/arch/arm/dts/rk356x-u-boot.dtsi
>> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
>> @@ -87,6 +87,10 @@
>>   	bootph-all;
>>   };
>>   
>> +&otp {
>> +	bootph-some-ram;
>> +};
>> +
>>   &pcfg_pull_none {
>>   	bootph-all;
>>   };
>> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
>> index 768a37393290..fc4c140ab970 100644
>> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
>> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
>> @@ -4,6 +4,7 @@
>>    */
>>   
>>   #include <dm.h>
>> +#include <misc.h>
>>   #include <asm/armv8/mmu.h>
>>   #include <asm/arch-rockchip/bootrom.h>
>>   #include <asm/arch-rockchip/grf_rk3568.h>
>> @@ -133,3 +134,67 @@ int arch_cpu_init(void)
>>   #endif
>>   	return 0;
>>   }
>> +
>> +#define RK3568_OTP_CPU_CODE_OFFSET		0x02
>> +#define RK3568_OTP_SPECIFICATION_OFFSET		0x07
>> +#define RK3568_OTP_CPU_VERSION_OFFSET		0x08
>> +#define RK3568_OTP_PERFORMANCE_OFFSET		0x22
>> +
>> +int checkboard(void)
>> +{
>> +	u8 cpu_code[2], specification, package, cpu_version, performance;
>> +	struct udevice *dev;
>> +	char suffix[3];
>> +	int ret;
>> +
>> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
>> +					  DM_DRIVER_GET(rockchip_otp), &dev);
>> +	if (ret) {
>> +		debug("%s: could not find otp device, ret=%d\n", __func__, ret);
>> +		return 0;
>> +	}
>> +
>> +	/* cpu-code: SoC model, 0x35 0x66 or 0x35 0x68 */
>> +	ret = misc_read(dev, RK3568_OTP_CPU_CODE_OFFSET, cpu_code, 2);
>> +	if (ret < 0) {
>> +		debug("%s: could not read cpu-code, ret=%d\n", __func__, ret);
>> +		return 0;
>> +	}
>> +
>> +	/* specification: SoC variant, 0x2 for RK3568B2 and 0xA for RK3568J */
>> +	ret = misc_read(dev, RK3568_OTP_SPECIFICATION_OFFSET, &specification, 1);
>> +	if (ret < 0) {
>> +		debug("%s: could not read specification, ret=%d\n", __func__, ret);
>> +		return 0;
>> +	}
>> +	/* package: likely SoC variant revision, 0x2 for RK3568B2 */
>> +	package = specification >> 5;
>> +	specification &= 0x1f;
>> +
>> +	/* cpu-version: chip version, e.g. second letter of lot number */
>> +	ret = misc_read(dev, RK3568_OTP_CPU_VERSION_OFFSET, &cpu_version, 1);
>> +	if (ret < 0) {
>> +		debug("%s: could not read cpu-version, ret=%d\n", __func__, ret);
>> +		return 0;
>> +	}
>> +	cpu_version >>= 3;
>> +	cpu_version &= 0x7;
>> +
>> +	/* performance: used to identify RK3566T SoC variant */
>> +	ret = misc_read(dev, RK3568_OTP_PERFORMANCE_OFFSET, &performance, 1);
>> +	if (ret < 0) {
>> +		debug("%s: could not read performance, ret=%d\n", __func__, ret);
>> +		return 0;
>> +	}
>> +	if (performance & 0x0f)
>> +		specification = 0x14; /* T-variant */
>> +
>> +	suffix[0] = specification > 1 ? '@' + specification : 0;
>> +	suffix[1] = package > 1 ? '0' + package : 0;
>> +	suffix[2] = 0;
>> +
>> +	printf("SoC:   RK%02x%02x%s v%u\n",
>> +	       cpu_code[0], cpu_code[1], suffix, cpu_version);
>> +
>> +	return 0;
>> +}
>> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
>> index 1d06f3411fe0..f79f0e84400b 100644
>> --- a/configs/generic-rk3568_defconfig
>> +++ b/configs/generic-rk3568_defconfig
>> @@ -22,7 +22,6 @@ CONFIG_SPL_LOAD_FIT=y
>>   CONFIG_LEGACY_IMAGE_FORMAT=y
>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
>>   # CONFIG_DISPLAY_CPUINFO is not set
>> -CONFIG_DISPLAY_BOARDINFO_LATE=y
>>   CONFIG_SPL_MAX_SIZE=0x40000
>>   CONFIG_SPL_PAD_TO=0x7f8000
>>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> @@ -31,6 +30,7 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>>   CONFIG_SPL_ATF=y
>>   CONFIG_CMD_GPIO=y
>>   CONFIG_CMD_GPT=y
>> +CONFIG_CMD_MISC=y
>>   CONFIG_CMD_MMC=y
>>   CONFIG_CMD_ROCKUSB=y
>>   CONFIG_CMD_USB_MASS_STORAGE=y

