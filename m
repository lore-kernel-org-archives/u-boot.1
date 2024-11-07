Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065F0D43367
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 14:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60B12892CD;
	Thu,  7 Nov 2024 15:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="B8XKaDGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4381892DA; Thu,  7 Nov 2024 15:29:52 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF8988DFA
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 15:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d7e1=SD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1730989779;
 bh=GiRxwuTbDJj3qcCTmOE2pWzKkWghue0sSXUMlAH+Wqg=;
 b=B8XKaDGbci8Vt3nLS+y+31PdaTz9H1x6Vj1ot5lWUlTGBao0EaoG/p2uW6TnaQ7YkiPpILrhv
 9vIkrZnzbDoFEzpsU7nTkLvMfDuH8SqfRRpywiuTziXXy6CxjLeYq1LsikpWfY0tV+2IyG4Q7nS
 WSWSek9Il4Rh5gFy5o88y80wE+CbvymxTyq3J3JSp9u5dTLfawXFWUyiPxRVP8mg+l4+hiBv7H8
 IBWN2WtnmTQDkYXo++MWZefb2YhpTxymfdSq19gAvVs3ynep9aFxUZLxZ8M4i1iY7Mgb2Z4kNP9
 dXcGV3E/HbRlkIcEhtWrAR7LBvH3+ih0ve90zITiwtgA==
Message-ID: <cef9b291-5c27-454c-a24a-565d4510add5@kwiboo.se>
Date: Thu, 7 Nov 2024 15:29:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: rk3588: Implement checkboard() to print
 SoC variant
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20241102203746.3631481-1-jonas@kwiboo.se>
 <20241102203746.3631481-3-jonas@kwiboo.se>
 <f4f66f6c-3b96-4529-a90c-cd3a0b900a56@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <f4f66f6c-3b96-4529-a90c-cd3a0b900a56@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672cced15b0439d06bdefeeb
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

Hi Quentin,

On 2024-11-07 13:01, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 11/2/24 9:37 PM, Jonas Karlman wrote:
>> Implement checkboard() to print current SoC model used by a board,
>> e.g. one of:
>>
>>    SoC:   RK3582 v1
>>    SoC:   RK3588 v0
>>    SoC:   RK3588 v1
>>    SoC:   RK3588S v0
>>    SoC:   RK3588S v1
>>    SoC:   RK3588S2 v1
>>
>> when U-Boot proper is running.
>>
>>    U-Boot 2025.01-rc1 (Nov 02 2024 - 20:19:01 +0000)
>>
>>    Model: Generic RK3588S/RK3588
>>    SoC:   RK3588S2 v1
>>    DRAM:  8 GiB
>>
>> Information about the SoC model, variant and version is read from OTP.
>>
>> Also update rk3588s-u-boot.dtsi to include OTP in U-Boot pre-reloc phase,
>> where checkboard() is called.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2:
>> - Update commit message
>> - Update code comments
>> - Drop generic-rk3588_defconfig change
>> ---
>>   arch/arm/dts/rk3588s-u-boot.dtsi       |  4 ++
>>   arch/arm/mach-rockchip/rk3588/rk3588.c | 58 ++++++++++++++++++++++++++
>>   2 files changed, 62 insertions(+)
>>
>> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
>> index 09d8b311cec5..8880d162b11c 100644
>> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
>> @@ -69,6 +69,10 @@
>>   	bootph-all;
>>   };
>>   
>> +&otp {
>> +	bootph-some-ram;
>> +};
>> +
>>   &pcfg_pull_down {
>>   	bootph-all;
>>   };
>> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
>> index e2dac2a5b806..f9da7a6f1477 100644
>> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
>> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
>> @@ -4,6 +4,8 @@
>>    * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
>>    */
>>   
>> +#include <dm.h>
>> +#include <misc.h>
>>   #include <spl.h>
>>   #include <asm/armv8/mmu.h>
>>   #include <asm/arch-rockchip/bootrom.h>
>> @@ -178,3 +180,59 @@ int arch_cpu_init(void)
>>   	return 0;
>>   }
>>   #endif
>> +
>> +#define RK3588_OTP_CPU_CODE_OFFSET		0x02
>> +#define RK3588_OTP_SPECIFICATION_OFFSET		0x06
>> +#define RK3588_OTP_CPU_VERSION_OFFSET		0x1c
>> +
>> +int checkboard(void)
>> +{
>> +	u8 cpu_code[2], specification, package, cpu_version;
>> +	struct udevice *dev;
>> +	char suffix[3];
>> +	int ret;
>> +
>> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
>> +					  DM_DRIVER_GET(rockchip_otp), &dev);
>> +	if (ret) {
>> +		debug("%s: could not find otp device, ret=%d\n", __func__, ret);
> 
> We should probably start using log_debug instead?

I guess we should?, not sure why there is two different and what the
difference is. Have typically only ever used debug() or printf(), so I
just went with what was used in the code copied from board.c.

> 
> I guess with #define LOG_CATEGORY LOGC_ARCH
> 
> at the top?

I can give it a try, what/how is the log category used for?

My simple debug workflow is just to add a '#define LOG_DEBUG' at top of
a file when I want some more debug info.

> 
>> +		return 0;
>> +	}
>> +
>> +	/* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
>> +	ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
> 
> This will fail if CONFIG_MISC=n which is neither selected nor implied 
> for RK3588.

Good catch, did not test that scenario, will fix in a v3.

> 
> I tested on multiple RK3588 Jaguar, and the commercial (RK3588) grade 
> ones all showed RK3588 v0.
> 
> The one industrial grade (RK3588J) showed RK3588J v1.

Thanks for confirming this works on a J-variant.

> 
> I'm really not sure what this version number is for. If even Kever 
> doesn't know what it means, I am not sure it makes sense to print it?

For rk356x there is some special handling for cpu-version <> 0 in vendor
code, and DT describe a cpu-version nvmem cell, so thought it could be
useful debug information. However it may just cause more confusion since
there is no clear information on what the different cpu-version mean.

Will drop the cpu-version information in a v3.

> 
> FWIW, the Linux kernel now exposes different nvmem devices for each cell 
> and since we have a cell defined for the three OTP ranges you're using 
> here, maybe it'd make sense to use that instead of hardcoding the 
> offsets and size in here? Not a blocker for this though as I don't think 
> it brings THAT much value to those fixed NVMEM layouts.

Took a quick peek at nvmem cell support in U-Boot and look like 'bits' prop
is not supported and nvmem-cells/nvmem-cell-names may have to be used.

Probably easier to use that in a future series that also converts this
into a possible sysinfo driver using a DT node similar to:

  sysinfo {
	compatible = "rockchip,rk3588-sysinfo";
	bootph-some-ram;
	nvmem-cells = <&cpu_code>, <&otp_id>, ...;
	nvmem-cell-names = "soc", "id", ...;
  };

Something for the future :-)

Regards,
Jonas

> 
> Cheers,
> Quentin

