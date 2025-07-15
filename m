Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B89C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 15:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B32E83010;
	Tue, 15 Jul 2025 17:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="m2RSRMWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB30683020; Tue, 15 Jul 2025 17:34:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E45A82E37
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 17:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5605=Z5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752593689;
 bh=9gOzOIgt5f4Xxo0Wunnuqpp9flXewxwjfeimNubDHXQ=;
 b=m2RSRMWEy1pc4FXReBRwHtsg/T8zjcG8yyGQ00VjwfGwlLmqbG8+iu3De+id8w6jjE56KuSXN
 Rr+CiujsdsGHepS4f5Acr/t+Ioa1tf9lcB5vEoWNohtfFyNSJV/wGl+78EDipYOx2xOJW8RWVxN
 o4PzJsHYyTt3hoBVV6wsREseYCEeTuBaq79ZNN5GqdfmD+G1jNcuPW0NTiMBwQmNBhrJJPqomIQ
 MyfPWGvPs5L2MAA1gxWrV7N/wvDmFEGJvTXBVnM2SiSks197N60Z2nGJsOv7Vhy2hXGMjMq7sD2
 wWK/yIZSo+0dRxXwLj2z1KdvXBFdlfjsWQFEyb7gd81g==
X-Forward-Email-ID: 687675164f06c51bcf0258b4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <bd6fc3a2-6b56-4f79-88b9-64e9a5c33a67@kwiboo.se>
Date: Tue, 15 Jul 2025 17:34:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] rockchip: odroid-go2: Use env from same storage FIT
 was loaded from
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-13-jonas@kwiboo.se>
 <ef7bc4a7-4195-42a6-a7a3-9d1afef39d7e@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <ef7bc4a7-4195-42a6-a7a3-9d1afef39d7e@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 7/15/2025 11:46 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/14/25 1:34 AM, Jonas Karlman wrote:
>> Change to dynamically select what storage media to use for the U-Boot
>> environment depending on from what storage media the FIT images was
>> loaded from, fall back to use env from nowhere.
>>
>>    U-Boot SPL 2025.07 (Jul 13 2025 - 10:07:16 +0000)
>>    Trying to boot from MMC1
>>    ...
>>    Loading Environment from MMC... Reading from MMC(0)...
>>
>> or
>>
>>    U-Boot SPL 2025.07 (Jul 13 2025 - 10:07:16 +0000)
>>    Trying to boot from SPI
>>    ...
>>    Loading Environment from SPIFlash...
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   board/hardkernel/odroid_go2/Kconfig |  1 +
>>   board/hardkernel/odroid_go2/go2.c   | 34 +++++++++++++++++++++++++++++
>>   configs/odroid-go2_defconfig        |  2 ++
>>   3 files changed, 37 insertions(+)
>>
>> diff --git a/board/hardkernel/odroid_go2/Kconfig b/board/hardkernel/odroid_go2/Kconfig
>> index dd6e366282e3..6487335972b8 100644
>> --- a/board/hardkernel/odroid_go2/Kconfig
>> +++ b/board/hardkernel/odroid_go2/Kconfig
>> @@ -13,6 +13,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>>   	def_bool y
>>   	select ADC
>>   	select BOARD_TYPES
>> +	select ENV_IS_NOWHERE
>>   	select SPL_ADC
>>   
>>   endif
>> diff --git a/board/hardkernel/odroid_go2/go2.c b/board/hardkernel/odroid_go2/go2.c
>> index 9d9f3cee36a5..ae32ea87af88 100644
>> --- a/board/hardkernel/odroid_go2/go2.c
>> +++ b/board/hardkernel/odroid_go2/go2.c
>> @@ -7,7 +7,9 @@
>>   #include <adc.h>
>>   #include <asm/io.h>
>>   #include <dm.h>
>> +#include <dm/uclass-internal.h>
>>   #include <env.h>
>> +#include <env_internal.h>
>>   #include <stdlib.h>
>>   
>>   DECLARE_GLOBAL_DATA_PTR;
>> @@ -129,3 +131,35 @@ int board_fit_config_name_match(const char *name)
>>   
>>   	return -EINVAL;
>>   }
>> +
>> +enum env_location env_get_location(enum env_operation op, int prio)
>> +{
>> +	const char *boot_device;
>> +	struct udevice *dev;
>> +	ofnode node;
>> +
>> +	if (prio)
>> +		return ENVL_UNKNOWN;
>> +
>> +	boot_device = ofnode_read_chosen_string("u-boot,spl-boot-device");
>> +	if (!boot_device) {
>> +		debug("%s: /chosen/u-boot,spl-boot-device not set\n", __func__);
>> +		return ENVL_NOWHERE;
>> +	}
>> +
>> +	debug("%s: booted from %s\n", __func__, boot_device);
>> +
>> +	node = ofnode_path(boot_device);
>> +	if (!ofnode_valid(node))
>> +		return ENVL_NOWHERE;
>> +
>> +	if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH) &&
>> +	    !uclass_find_device_by_ofnode(UCLASS_SPI_FLASH, node, &dev))
>> +		return ENVL_SPI_FLASH;
>> +
>> +	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) &&
>> +	    !uclass_find_device_by_ofnode(UCLASS_MMC, node, &dev))
>> +		return ENVL_MMC;
>> +
>> +	return ENVL_NOWHERE;
>> +}
> 
> This is virtually identical to the implementation in 
> board/theobroma-systems/common/common.c and I think it's quite a 
> reasonable approach (though I'm the one who implemented it so I may be 
> slightly biased :) ).

Hehe, your arch_env_get_location() and the common mmc_get_env_dev() has
been a huge inspiration to this ;-)

And I fully agree this to be a reasonable approach.

> 
> Should we somehow make it available in a header so it's easy/easier to 
> implement the same for other boards? E.g. env_get_location() could 
> simply call env_get_location_same_as_proper()? What do you think?

Fully agree to something like that, and/or adding a special Kconfig
option that enable a similar shared arch_env_get_location().

Something for a future series :-)

Regards,
Jonas

> 
> Not necessary for this patch to be merged though, so
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

