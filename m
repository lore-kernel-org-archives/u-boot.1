Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B14D3C92E
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 22:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 460A689018;
	Sun, 20 Oct 2024 00:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="v4nZB8ZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98CC4890CC; Sun, 20 Oct 2024 00:24:38 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2644788B55
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 00:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2637=RQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1729376666;
 bh=IpWXKgceGmblafu3SAxKKkWimeK9jKM/2aTlgdb0yus=;
 b=v4nZB8ZQbS/F68RCePZkjD2T8oS4j6DpAQn/3YOf1n7QfE4fT8wJlIyr10GpWqFJ6XT8MFwxH
 fweP/bkoNt2JtDBX0nDOWhOPP29Xk85+SUHwMZ48be6paQa92ZzdPn67VEtswndfQTy6MsjrB5N
 OQo/iE4sGAoEgj0KrKFGQJBL4jhbRrQT1p662W5bTghvDEIdt3lr9BFGvwkq4Wf80Yih/eSdvFm
 VwFBpUhiSJDIxQezbCmsagWMMYX+2DVKKfli0z3TaVQ4SeYXDQY262eS+IMrrJVBQNDuFeeIIzG
 vA9y3Fs8U0niLxNmJa/6wg2fuJj1nIGE1t3ZFpLPu2Dw==
Message-ID: <4484bfde-12f6-4b0d-9e91-d2ba58e551ca@kwiboo.se>
Date: Sun, 20 Oct 2024 00:24:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk356x: Implement checkboard() to print SoC
 variant
To: Simon Glass <sjg@chromium.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Dragan Simic <dsimic@manjaro.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20241018163423.1562287-1-jonas@kwiboo.se>
 <20241018163423.1562287-2-jonas@kwiboo.se>
 <CAFLszTig2pF8pMhUCjjcfcJ6K4KQK2oWahsO7L5Bn9cwq2LEPA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTig2pF8pMhUCjjcfcJ6K4KQK2oWahsO7L5Bn9cwq2LEPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6714319932204f6a707fc84e
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

Hi Simon,

On 2024-10-19 04:00, Simon Glass wrote:
> Hi Jonas,
> 
> On Fri, 18 Oct 2024 at 10:34, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Implement checkboard() to print current SoC model, e.g. one of:
>>
>>   SoC:   RK3566 v1
>>   SoC:   RK3566 v2
>>   SoC:   RK3566T v2
>>   SoC:   RK3568 v2
>>   SoC:   RK3568B2 v2
>>   SoC:   RK3568J v2
>>
>> when U-Boot proper is started.
>>
>> Information about what SoC model, variant and version is read from OTP.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  arch/arm/dts/rk356x-u-boot.dtsi        |  4 ++
>>  arch/arm/mach-rockchip/rk3568/rk3568.c | 65 ++++++++++++++++++++++++++
>>  configs/generic-rk3568_defconfig       |  2 +-
>>  3 files changed, 70 insertions(+), 1 deletion(-)
>>
> 
> Instead of this, can you use add a CPU driver? Then it should happen
> automatically - see print_cpuinfo().

Unfortunately the CPU driver seem to be more related to the /cpus nodes,
e.g. the arm cores included in these SoCs and not really related to the
overall SoC used by the board.

This instead depend on the DISPLAY_BOARDINFO and its checkboard() as the
type of SoC seem more related to the board soc target.

Regards,
Jonas

> 
>> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
>> index 0a0943b462a9..24a976cf7e21 100644
>> --- a/arch/arm/dts/rk356x-u-boot.dtsi
>> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
>> @@ -87,6 +87,10 @@
>>         bootph-all;
>>  };
>>
>> +&otp {
>> +       bootph-some-ram;
>> +};
>> +
>>  &pcfg_pull_none {
>>         bootph-all;
>>  };
>> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
>> index 768a37393290..fc4c140ab970 100644
>> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
>> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
>> @@ -4,6 +4,7 @@
>>   */
>>
>>  #include <dm.h>
>> +#include <misc.h>
>>  #include <asm/armv8/mmu.h>
>>  #include <asm/arch-rockchip/bootrom.h>
>>  #include <asm/arch-rockchip/grf_rk3568.h>
>> @@ -133,3 +134,67 @@ int arch_cpu_init(void)
>>  #endif
>>         return 0;
>>  }
>> +
>> +#define RK3568_OTP_CPU_CODE_OFFSET             0x02
>> +#define RK3568_OTP_SPECIFICATION_OFFSET                0x07
>> +#define RK3568_OTP_CPU_VERSION_OFFSET          0x08
>> +#define RK3568_OTP_PERFORMANCE_OFFSET          0x22
>> +
>> +int checkboard(void)
>> +{
>> +       u8 cpu_code[2], specification, package, cpu_version, performance;
>> +       struct udevice *dev;
>> +       char suffix[3];
>> +       int ret;
>> +
>> +       ret = uclass_get_device_by_driver(UCLASS_MISC,
>> +                                         DM_DRIVER_GET(rockchip_otp), &dev);
>> +       if (ret) {
>> +               debug("%s: could not find otp device, ret=%d\n", __func__, ret);
>> +               return 0;
>> +       }
>> +
>> +       /* cpu-code: SoC model, 0x35 0x66 or 0x35 0x68 */
>> +       ret = misc_read(dev, RK3568_OTP_CPU_CODE_OFFSET, cpu_code, 2);
>> +       if (ret < 0) {
>> +               debug("%s: could not read cpu-code, ret=%d\n", __func__, ret);
>> +               return 0;
>> +       }
>> +
>> +       /* specification: SoC variant, 0x2 for RK3568B2 and 0xA for RK3568J */
>> +       ret = misc_read(dev, RK3568_OTP_SPECIFICATION_OFFSET, &specification, 1);
>> +       if (ret < 0) {
>> +               debug("%s: could not read specification, ret=%d\n", __func__, ret);
>> +               return 0;
>> +       }
>> +       /* package: likely SoC variant revision, 0x2 for RK3568B2 */
>> +       package = specification >> 5;
>> +       specification &= 0x1f;
>> +
>> +       /* cpu-version: chip version, e.g. second letter of lot number */
>> +       ret = misc_read(dev, RK3568_OTP_CPU_VERSION_OFFSET, &cpu_version, 1);
>> +       if (ret < 0) {
>> +               debug("%s: could not read cpu-version, ret=%d\n", __func__, ret);
>> +               return 0;
>> +       }
>> +       cpu_version >>= 3;
>> +       cpu_version &= 0x7;
>> +
>> +       /* performance: used to identify RK3566T SoC variant */
>> +       ret = misc_read(dev, RK3568_OTP_PERFORMANCE_OFFSET, &performance, 1);
>> +       if (ret < 0) {
>> +               debug("%s: could not read performance, ret=%d\n", __func__, ret);
>> +               return 0;
>> +       }
>> +       if (performance & 0x0f)
>> +               specification = 0x14; /* T-variant */
>> +
>> +       suffix[0] = specification > 1 ? '@' + specification : 0;
>> +       suffix[1] = package > 1 ? '0' + package : 0;
>> +       suffix[2] = 0;
>> +
>> +       printf("SoC:   RK%02x%02x%s v%u\n",
>> +              cpu_code[0], cpu_code[1], suffix, cpu_version);
>> +
>> +       return 0;
>> +}
>> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
>> index 1d06f3411fe0..f79f0e84400b 100644
>> --- a/configs/generic-rk3568_defconfig
>> +++ b/configs/generic-rk3568_defconfig
>> @@ -22,7 +22,6 @@ CONFIG_SPL_LOAD_FIT=y
>>  CONFIG_LEGACY_IMAGE_FORMAT=y
>>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
>>  # CONFIG_DISPLAY_CPUINFO is not set
>> -CONFIG_DISPLAY_BOARDINFO_LATE=y
>>  CONFIG_SPL_MAX_SIZE=0x40000
>>  CONFIG_SPL_PAD_TO=0x7f8000
>>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> @@ -31,6 +30,7 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>>  CONFIG_SPL_ATF=y
>>  CONFIG_CMD_GPIO=y
>>  CONFIG_CMD_GPT=y
>> +CONFIG_CMD_MISC=y
>>  CONFIG_CMD_MMC=y
>>  CONFIG_CMD_ROCKUSB=y
>>  CONFIG_CMD_USB_MASS_STORAGE=y
>> --
>> 2.46.2
>>
> 
> Regards,
> Simon

