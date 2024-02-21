Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09352C5478A
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 19:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A8488066;
	Wed, 21 Feb 2024 20:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="DbcgWQbf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 116FA88063; Wed, 21 Feb 2024 20:06:22 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EA5188056
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 20:06:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b03d=J7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1708542365;
 bh=p3R2Zr1bqD8ra3skDVTKHSJIhkHlF9yRxOgeaS1vd1w=;
 b=DbcgWQbf9YcFxMdh49AjIIstxxR5x5U3A5MPcBlPIX60yaxlhW9PwgTgtjWwxSYoC0qGA//KN
 5DVJM/AQlKb0Zq6mnGUu/e/S115u8U9RKNULpwUlJg3UNMu0dae5TH87tQOjQSsiRuC4YBKXvTV
 RQNR/8tLwa3p75/5kbthHQcqVSPu+2Nc8bkL4cXCTZnRG+Ua4iRZMrRoEyE+pumaS9ijseWpV8M
 EDmASOMeifBpOKIyKqtghsBn+YAErUoYuoo2I/ugUtiudkFInxoTJ+C5BsIOhDM/lUSUd5eLUDb
 gVVqj1SL4AzOlo0cG5YF3BtLs2ZNzcANn5af4dV5++5A==
Message-ID: <5c6e6525-fc93-4a5a-b3bb-f5f6b5341ef3@kwiboo.se>
Date: Wed, 21 Feb 2024 20:05:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] rockchip: io-domain: Add support for RK3399
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-6-jonas@kwiboo.se>
 <f00195b3-b410-4e1b-ab56-c448e8f530cc@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <f00195b3-b410-4e1b-ab56-c448e8f530cc@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65d6499cddd890daa4e90311
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

On 2024-02-21 19:18, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 2/17/24 19:35, Jonas Karlman wrote:
>> Port the RK3399 part of the Rockchip IO-domain driver from linux.
>>
>> This differs from linux version in that pmu io iodomain bit is enabled
>> in the write ops instead of in an init ops as in linux, this way we can
>> avoid keeping a full state of all supply that have been configured.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Suggestions below, otherwise I only have one concern:
> 
> This actually postpones the moment the IO domain is properly set. 
> Before, we knew almost for sure when this was set, as it was pretty 
> early in the boot process (misc_init_r), I hope before any device was 
> actually probed. Now, because we're using the Device Model for that, we 
> may probe this IO domain device after another Device requires it? e.g. 
> for Puma, we need the IO domains set for PCIe to work. I assume if we 
> were to use PCIe in U-Boot on Puma, we may have this issue (we don't 
> right now use PCIe in U-Boot and I don't think we have any plan of doing 
> so).

Because this driver makes the following call in its bind ops, the
opposite is actually true and the IO domain is configured earlier than
it was previously done with misc_init_r.

With this the IO domain driver is probed directly after bind and
all regulators that is referenced by io-domain supply nodes will be
regulator_autoset() before the uV value is evaluated.

In rockchip_iodomain_bind():

  dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);

On the boards I can test on the GRF got configured exactly as before,
just a little bit earlier in the boot process.

Prior to the "rockchip: Port IO-domain driver for RK3568 from linux" [1]
series the rk8xx driver had some issues and incorrect voltage could be
read for some regulators.

[1] https://patchwork.ozlabs.org/cover/1823769/

> 
> This all reminds me of the attempts we've made in the Linux kernel to 
> make sure the IO domain devices are probed before the devices that 
> require them to be set up. Maybe we'll need something similar in U-Boot 
> as well.

The main thing missing compared to the linux counterpart is that changes
to regulator voltage is not tracked, so there will not be any changes
made the initial IO domain voltage configuration made by this driver.

> 
>> ---
>>   drivers/misc/rockchip-io-domain.c | 79 +++++++++++++++++++++++++++++--
>>   1 file changed, 75 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-domain.c
>> index 3f6227f993f9..0ffea32ef07f 100644
>> --- a/drivers/misc/rockchip-io-domain.c
>> +++ b/drivers/misc/rockchip-io-domain.c
>> @@ -5,7 +5,6 @@
>>    * Ported from linux drivers/soc/rockchip/io-domain.c
>>    */
>>   
>> -#include <common.h>
>>   #include <dm.h>
>>   #include <dm/device_compat.h>
>>   #include <regmap.h>
>> @@ -28,6 +27,10 @@
>>   #define MAX_VOLTAGE_1_8		1980000
>>   #define MAX_VOLTAGE_3_3		3600000
>>   
>> +#define RK3399_PMUGRF_CON0		0x180
>> +#define RK3399_PMUGRF_CON0_VSEL		BIT(8)
>> +#define RK3399_PMUGRF_VSEL_SUPPLY_NUM	9
>> +
>>   #define RK3568_PMU_GRF_IO_VSEL0		0x0140
>>   #define RK3568_PMU_GRF_IO_VSEL1		0x0144
>>   #define RK3568_PMU_GRF_IO_VSEL2		0x0148
>> @@ -35,10 +38,10 @@
>>   struct rockchip_iodomain_soc_data {
>>   	int grf_offset;
>>   	const char *supply_names[MAX_SUPPLIES];
>> -	int (*write)(struct regmap *grf, int idx, int uV);
>> +	int (*write)(struct regmap *grf, uint offset, int idx, int uV);
>>   };
>>   
>> -static int rk3568_iodomain_write(struct regmap *grf, int idx, int uV)
>> +static int rk3568_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
>>   {
>>   	u32 is_3v3 = uV > MAX_VOLTAGE_1_8;
>>   	u32 val0, val1;
>> @@ -78,6 +81,64 @@ static int rk3568_iodomain_write(struct regmap *grf, int idx, int uV)
>>   	return 0;
>>   }
>>   
>> +static int rockchip_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
>> +{
>> +	u32 val;
>> +
>> +	/* set value bit */
>> +	val = (uV > MAX_VOLTAGE_1_8) ? 0 : 1;
>> +	val <<= idx;
>> +
>> +	/* apply hiword-mask */
>> +	val |= (BIT(idx) << 16);
>> +
>> +	return regmap_write(grf, offset, val);
> 
> You could use:
> 
> """
> if (uV > MAX_VOLTAGE_1_8) {
>      val = RK_CLRBITS(BIT(idx));
> } else {
>      val = RK_SETBITS(BIT(idx));
> }
> 
> return regmap_write(grf, offset, val);
> """
> 
> by including asm/rockchip/hardware.h.
> 
>> +}
>> +
>> +static int rk3399_pmu_iodomain_write(struct regmap *grf, uint offset, int idx, int uV)
>> +{
>> +	int ret = rockchip_iodomain_write(grf, offset, idx, uV);
>> +
>> +	if (!ret && idx == RK3399_PMUGRF_VSEL_SUPPLY_NUM) {
>> +		/*
>> +		 * set pmu io iodomain to also use this framework
>> +		 * instead of a special gpio.
>> +		 */
>> +		u32 val = RK3399_PMUGRF_CON0_VSEL | (RK3399_PMUGRF_CON0_VSEL << 16);
>> +		ret = regmap_write(grf, RK3399_PMUGRF_CON0, val);
> 
> Same here, but two options :)
> 
> """
> ret = regmap_write(grf, RK3399_PMUGRF_CON0, 
> RK_SETBITS(RK3399_PMUGRF_CON0_VSEL));
> """
> 
> or
> """
> ret = regmap_write(grf, RK3399_PMUGRF_CON0, 
> FIELD_PREP(RK3399_PMUGRF_CON0_VSEL, 1));
> """

Thanks for the suggestions, I have purposely tried to deviate as little
as possible from the linux driver, as I would like to port support for
more SoCs.

Will take a closer look if there is a need for a v2 or as part of a
future follow-up series.

> 
> Maybe the if check on the offset is actually a bit overkill? This 
> function can only be called for one IO domain since there's only one IO 
> domain in the PMUGRF in RK3399.
> 
> Therefore.... Maybe just hardcode everything?

Hehe, true, I first implemented in this way for RK3328 (patches not sent
yet), and just followed using the same pattern for RK3399 without
thinking too much :-)

Will change if there is a v2, or as part of a future follow-up series
that adds RK3328 and RK3308 support.

Regards,
Jonas

> 
> """
> static int rk3399_pmu_iodomain_write(struct regmap *grf, uint offset, 
> int idx, int uV)
> {
>      int ret = rockchip_iodomain_write(grf, offset, 9, uV);
>      if (ret)
>          return ret;
> 
>      return regmap_write(grf, RK3399_PMUGRF_CON0, 
> FIELD_PREP(RK3399_PMUGRF_CON0_VSEL, 1));
> }
> 
> static const struct rockchip_iodomain_soc_data soc_data_rk3399_pmu = {
> 	.grf_offset = 0x180,
> 	.supply_names = {
> 		"pmu1830-supply",	/* PMUIO2_VDD */
> 	},
> 	.write = rk3399_pmu_iodomain_write,
> };
> """
> 
> You can also keep the 8 NULL supplies before to not have to hardcode "9" 
> in rk3399_pmu_iodomain_write for example, and still not do the check, 
> adding a comment explaining why.
> 
> The code looks sound in any case, only issue I have is wrt device probe 
> ordering in U-Boot.
> 
> Cheers,
> Quentin

