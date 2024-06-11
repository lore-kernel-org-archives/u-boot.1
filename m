Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7105DC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF30E886A6;
	Tue, 11 Jun 2024 15:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OjaK0Io4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB9AF886AB; Tue, 11 Jun 2024 15:43:54 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEFDE88685
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=323a=NO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1718113396;
 bh=ruNHfttvRUimvHnRTUAKAYQC5iv+MAtePpM/8pDFF0E=;
 b=OjaK0Io4Bg6OBSY1jzb6YVqSOb0fDgFECKG8A5OqC1MZ/+PN+PtvNzsa9zCdbqq8t4eC+otev
 uBpaNHy6IFUMmcjUyiSOyo9rJKB7xFEWAJm7fViOkJ+kesgoA0Nu9guUC/lGREUYllorEU5EAW5
 UldHeT7O6VCo1PMqKq7NIOS5lQgVIk2Tngsp49bFRxWK6FmYTYhRHXlSeINLnaP9C4cn3PAGouZ
 3y2ES4bBWQgRH5eY9+a2Hm8iAyA20niFY/pYhjSm0mLutD4F5qaURUmlB2+idaQBMxXu+K6MhGx
 lzLXtBgsxzcKpRuo37QYg5nib/Oi6ijCpAhu99xyix1g==
Message-ID: <844b0a8a-471c-4c6b-83f5-3884c8bcb77c@kwiboo.se>
Date: Tue, 11 Jun 2024 15:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] rockchip: Ensure memory size is available in
 RK3399 SPL
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 huang lin <hl@rock-chips.com>
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-8-sjg@chromium.org>
 <282d4379-2094-42ff-8ac1-6327655ca2d5@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <282d4379-2094-42ff-8ac1-6327655ca2d5@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6668546b20360a60b1f81695
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

Hi Simon and Quentin,

On 2024-06-11 13:27, Quentin Schulz wrote:
> Hi Simon,
> 
> On 6/10/24 4:59 PM, Simon Glass wrote:
>> At present gd->ram_size is 0 in SPL, meaning that it is not possible to
>> enable the cache. Correct this by always populating the RAM size
>> correctly.
>>
>> Part of the confusion here comes from the large blocks of code which
>> are #ifdefed out. Add a function phase_sdram_init() which returns
>> whether SDRAM init should happen in the current phase, using that as
>> needed to control the code flow.
>>
>> This increases code size by about 500 bytes in SPL when the cache is on,
>> since it must call the rather large rockchip_sdram_size() function.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>> Changes in v2:
>> - Add new patch to correct memory size in SPL
>>
>>   drivers/ram/rockchip/sdram_rk3399.c | 49 ++++++++++++++++-------------
>>   1 file changed, 27 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
>> index 02cc4a38cf0..2f37dd712e7 100644
>> --- a/drivers/ram/rockchip/sdram_rk3399.c
>> +++ b/drivers/ram/rockchip/sdram_rk3399.c
>> @@ -13,6 +13,7 @@
>>   #include <log.h>
>>   #include <ram.h>
>>   #include <regmap.h>
>> +#include <spl.h>
>>   #include <syscon.h>
>>   #include <asm/arch-rockchip/clock.h>
>>   #include <asm/arch-rockchip/cru.h>
>> @@ -63,8 +64,6 @@ struct chan_info {
>>   };
>>   
>>   struct dram_info {
>> -#if defined(CONFIG_TPL_BUILD) || \
>> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>>   	u32 pwrup_srefresh_exit[2];
>>   	struct chan_info chan[2];
>>   	struct clk ddr_clk;
>> @@ -75,7 +74,6 @@ struct dram_info {
>>   	struct rk3399_pmusgrf_regs *pmusgrf;
>>   	struct rk3399_ddr_cic_regs *cic;
>>   	const struct sdram_rk3399_ops *ops;
>> -#endif
>>   	struct ram_info info;
>>   	struct rk3399_pmugrf_regs *pmugrf;
>>   };
>> @@ -92,9 +90,6 @@ struct sdram_rk3399_ops {
>>   					struct rk3399_sdram_params *params);
>>   };
>>   
>> -#if defined(CONFIG_TPL_BUILD) || \
>> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>> -
>>   struct rockchip_dmc_plat {
>>   #if CONFIG_IS_ENABLED(OF_PLATDATA)
>>   	struct dtd_rockchip_rk3399_dmc dtplat;
>> @@ -191,6 +186,17 @@ struct io_setting {
>>   	},
>>   };
>>   
>> +/**
>> + * phase_sdram_init() - Check if this is the phase where SDRAM init happens
>> + *
>> + * Returns: true to do SDRAM init in this phase, false to not
>> + */
>> +static bool phase_sdram_init(void)
>> +{
>> +	return spl_phase() == PHASE_TPL ||
>> +	    (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());
>> +}
>> +
>>   static struct io_setting *
>>   lpddr4_get_io_settings(const struct rk3399_sdram_params *params, u32 mr5)
>>   {
>> @@ -3024,7 +3030,7 @@ static int rk3399_dmc_of_to_plat(struct udevice *dev)
>>   	struct rockchip_dmc_plat *plat = dev_get_plat(dev);
>>   	int ret;
>>   
>> -	if (!CONFIG_IS_ENABLED(OF_REAL))
>> +	if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
>>   		return 0;
>>   
>>   	ret = dev_read_u32_array(dev, "rockchip,sdram-params",
>> @@ -3138,23 +3144,25 @@ static int rk3399_dmc_init(struct udevice *dev)
>>   
>>   	return 0;
>>   }
>> -#endif
>>   
>>   static int rk3399_dmc_probe(struct udevice *dev)
>>   {
>> -#if defined(CONFIG_TPL_BUILD) || \
>> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>> -	if (rk3399_dmc_init(dev))
>> -		return 0;
>> -#else
>>   	struct dram_info *priv = dev_get_priv(dev);
>>   
>> -	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
>> -	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
>> -	priv->info.base = CFG_SYS_SDRAM_BASE;
>> -	priv->info.size =
>> -		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
>> -#endif
>> +	if (phase_sdram_init()) {
>> +		if (rk3399_dmc_init(dev))
>> +			return 0;
>> +	} else {
>> +		priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
>> +		debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
>> +	}
>> +
>> +	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
>> +		priv->info.base = CFG_SYS_SDRAM_BASE;
>> +		priv->info.size =
>> +			rockchip_sdram_size((ulong)&priv->pmugrf->os_reg2);
>> +	}
>> +
> 
> Isn't the whole change summarized to making sure that priv->info.base 
> and priv->info.size are set when DCACHE is enabled AND we're in the 
> first stage BL (TPL or SPL if no TPL)?
> 
> i.e., shouldn't the following code be enough:
> 
> """
> static int rk3399_dmc_probe(struct udevice *dev)
> {
> #if defined(CONFIG_TPL_BUILD) || \
> 	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> 	if (rk3399_dmc_init(dev))
> 		return 0;
> #else
> 	struct dram_info *priv = dev_get_priv(dev);
> 
> 	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> 	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> #endif
> 	priv->info.base = CFG_SYS_SDRAM_BASE;
> 	priv->info.size =
> 		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
> 
> 	return 0;
> }
> """
> ?
> 
> Then what's after the endif could be guarded by if 
> (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) { if we need to but it's not clear 
> to me why that is needed?

Agree, this look strange to me too and your diff much cleaner :-)

> 
> Basically, I'm not sure the migration from ifdefs to the 
> phase_sdram_init() function is necessary. I'm not against it, but it 
> makes the whole thing much harder to read and hides the actual changes.
> 
> Additionally, why was the cast to phys_addr_t changed to a ulong? The 
> function actually expects a phys_addr_t.
> 
> Finally, can you please explain why gd->ram_size being 0 is an issue for 
> the caches, where is this checked? I'm not too familiar with the caches 
> in general :)

My best guess is that enabling of caches in SPL cause issue for
bob/kevin because they only use SPL not TPL+SPL like (if I am not
mistaken) all other Rockchip arm64 targets.

Using SPL-only was not something I tested when caches was enabled in SPL.

Maybe bob/kevin can be changed to also use TPL+SPL similar to all other
RK3399 boards?

How U-Boot works on these chromebooks is still a mystery to me. If I
understand correctly SPL is only involved for bare metal boot, if this
is the case then using TPL + back-to-brom to load SPL should probably
work fine?, and would align all RK3399 boards to work in a similar way.

Regards,
Jonas

> 
> Cheers,
> Quentin

