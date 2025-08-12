Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4176CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 19:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 382C2830A0;
	Tue, 12 Aug 2025 21:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.b="kHvh5Za1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1DA28312A; Tue, 12 Aug 2025 20:56:17 +0200 (CEST)
Received: from send240.i.mail.ru (send240.i.mail.ru [95.163.59.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45DF1830A0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 20:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fido_max@inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
 s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
 :Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive:X-Cloud-Ids:Disposition-Notification-To;
 bh=Ba8jsx6wmks4Jl8Mrc+cv01ZnR0fhYNb1LQEVyLR/qU=; t=1755024975; x=1755114975; 
 b=kHvh5Za1K2MJmuYGDCRRrJJGX5JYzAWk9lW+tQFoW8Im12Nx8Rczi4YhO30bP0saShqPy8Wz74L
 GFHC8InW/hOzAFx2RQiO1bpvLTFeSaDlI2LV5rVHwso0SofOnEOACxkVAXDaP7gOZaInqx/X0SPas
 XA9Ph2XZRULake7bOfsv0loWT71TJOqucx2QE/ZomYm/jy4AMVRAdU07dDyKJmZkliTtHemGT5x00
 49igOLgIR1B2FErgxBFmDnhxCmwwttZffknWhZEZbsfe2BjNY2gycTX++b8/YrHrer7OjMEu32GFO
 rmkiVZXpjDN51aQrPBF9uRCi2/VY38sMHFuA==;
Received: by exim-smtp-657df4cdbd-6lqhr with esmtpa (envelope-from
 <fido_max@inbox.ru>)
 id 1uluAP-00000000LSk-274p; Tue, 12 Aug 2025 21:56:14 +0300
Message-ID: <9294dcae-42fa-45c2-962b-691fdaada13a@inbox.ru>
Date: Tue, 12 Aug 2025 21:56:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] clk: introduce of_clk_detect_critical helper
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: u-boot@lists.denx.de, quentin.schulz@cherry.de, jonas@kwiboo.se,
 marex@denx.de, semen.protsenko@linaro.org, miquel.raynal@bootlin.com,
 patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com, sjg@chromium.org,
 trini@konsulko.com, seanga2@gmail.com, lukma@denx.de
References: <20250812162946.892728-1-fido_max@inbox.ru>
 <689b6eb9.050a0220.d7261.4aab@mx.google.com>
Content-Language: en-US
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <689b6eb9.050a0220.d7261.4aab@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: exim-smtp-657df4cdbd-6lqhr;
 auth=pass smtp.auth=fido_max@inbox.ru
 smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9C53E288BA7BF03061562304242DC1DBDC2F78164DCED4E4C00894C459B0CD1B9636E5EDC46D03554460A1D3C0470A96D69E04806EEB58F05FDF874762BC5A246EDD16E8EE75FCBE4
X-7FA49CB5: 4BFC5D8501E51E47CA8F6BE7C18995EBF17A87A28845877638471299500719A2A6333920E0F9D84FF01C4FAB541DE28FCE208E8FC270FF883B56EE1CD41719AD6EEED3D1F8F94EF624AD3460B7163A6507627EB66F572D0C63D3EDE7CE9F49F504D6AF0AB02B6E8A0BD82CCAF9CC6664E537E12F68611B83C47E3B7CE6D2E883A99006929014511A3ACB880A4D218A94D06846632FBE334206AB96975ABF485581DA2A2DF6E06EB9C0F7AC48229FE00DAC7943500F4AA200B2D76FFBEB4135451A495265874E50823A509FAFE750B9BFE47C9C07E8DDB84581DA2A2DF6E06EB9961C42723899017F08BD49AA745F4EB947D288F8AA3B935C386B6D831821CFCFE47C9C07E8DDB845C2F20794B249F36DCA8F6BE7C18995EBAA484E9BD3D4964B9E5F4869DB6CD4C2953E0C1C45D6C2334B13DB96BB93DED2A3C43680391634B289ECC0B28F30D08BB30857F2626D88CBE117F2D40454C7D4D535C393DDB9A574
X-C1DE0DAB: B30BEEBCB9DAB3F0B6B691E933463DE1478DEAD3877DCF164B047A768301ACBDEA2DBE28EDD98AB9BCC2DF43DD22AB26DB841BC0FD54B826F8DB205C223665D42290FBF13227320B
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFB2DE471CEB449FC4F8CA6299C8FAAB7E98E4ECB0E5B35FE6A85DFF047FD17670A54F2CFF063EE8C0852ABD534936F63186DBBAF023832A85C1D46AB69B1799AD0BBAAD9DCB1AE4BEE4FDFA4A036B0C3902C26D483E81D6BEEB84411BD425175970A7FB4ED9620804ADE12199CE9660BE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVUcWHxAuDCnG+0nXBAtgZ24=
X-Mailru-Sender: 689FA8AB762F7393FE9E42A757851DB667691964590DC4277E72B3C874DCD9F3FB02E9567810733890DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Tue, 12 Aug 2025 21:02:40 +0200
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

12.08.2025 19:41, Christian Marangi wrote:
> On Tue, Aug 12, 2025 at 07:29:46PM +0300, Maxim Kochetkov wrote:
>> This helper find clock-critiacl property in dts and assign
> 
> clock-critiacl -> typo


Thanks. Will fix it in v2

> 
>> CLK_IS_CRITICAL flag to the clock.
>>
>> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
>> ---
>>   drivers/clk/clk-uclass.c | 17 +++++++++++++++++
>>   drivers/core/of_access.c | 22 ++++++++++++++++++++++
>>   include/clk.h            | 28 ++++++++++++++++++++++++++++
>>   include/dm/of_access.h   | 17 +++++++++++++++++
>>   4 files changed, 84 insertions(+)
>>
>> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
>> index 7262e89b512..4f35b90382f 100644
>> --- a/drivers/clk/clk-uclass.c
>> +++ b/drivers/clk/clk-uclass.c
>> @@ -835,6 +835,23 @@ struct clk *devm_clk_get(struct udevice *dev, const char *id)
>>   	return clk;
>>   }
>>   
>> +int of_clk_detect_critical(struct device_node *np, int index,
>> +			   unsigned long *flags)
>> +{
>> +	struct property *prop;
>> +	const __be32 *cur;
>> +	uint32_t idx;
>> +
>> +	if (!np || !flags)
>> +		return -EINVAL;
>> +
>> +	of_property_for_each_u32(np, "clock-critical", prop, cur, idx)
>> +		if (index == idx)
>> +			*flags |= CLK_IS_CRITICAL;
>> +
>> +	return 0;
>> +}
>> +
>>   int clk_uclass_post_probe(struct udevice *dev)
>>   {
>>   	/*
>> diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
>> index b11e36202c1..59dda3ae152 100644
>> --- a/drivers/core/of_access.c
>> +++ b/drivers/core/of_access.c
>> @@ -666,6 +666,28 @@ int of_property_read_string_helper(const struct device_node *np,
>>   	return i <= 0 ? -ENODATA : i;
>>   }
>>   
>> +const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
>> +			       u32 *pu)
>> +{
>> +	const void *curv = cur;
>> +
>> +	if (!prop)
>> +		return NULL;
>> +
>> +	if (!cur) {
>> +		curv = prop->value;
>> +		goto out_val;
>> +	}
>> +
>> +	curv += sizeof(*cur);
>> +	if (curv >= prop->value + prop->length)
>> +		return NULL;
>> +
>> +out_val:
>> +	*pu = be32_to_cpup(curv);
>> +	return curv;
>> +}
>> +
>>   static int __of_root_parse_phandle_with_args(struct device_node *root,
>>   					     const struct device_node *np,
>>   					     const char *list_name,
>> diff --git a/include/clk.h b/include/clk.h
>> index f94135ff778..ea708f54fd5 100644
>> --- a/include/clk.h
>> +++ b/include/clk.h
>> @@ -589,6 +589,27 @@ bool clk_dev_binded(struct clk *clk);
>>    */
>>   ulong clk_get_id(const struct clk *clk);
>>   
>> +/**
>> + * of_clk_detect_critical() - set CLK_IS_CRITICAL flag from Device Tree
>> + * @np: Device node pointer associated with clock provider
>> + * @index: clock index
>> + * @flags: pointer to top-level framework flags
>> + *
>> + * Detects if the clock-critical property exists and, if so, sets the
>> + * corresponding CLK_IS_CRITICAL flag.
>> + *
>> + * Do not use this function. It exists only for legacy Device Tree
>> + * bindings, such as the one-clock-per-node style that are outdated.
>> + * Those bindings typically put all clock data into .dts and the Linux
>> + * driver has no clock data, thus making it impossible to set this flag
>> + * correctly from the driver. Only those drivers may call
>> + * of_clk_detect_critical from their setup functions.
>> + *
>> + * Return: error code or zero on success
>> + */
>> +int of_clk_detect_critical(struct device_node *np, int index,
>> +			   unsigned long *flags);
>> +
>>   #else /* CONFIG_IS_ENABLED(CLK) */
>>   
>>   static inline int clk_request(struct udevice *dev, struct clk *clk)
>> @@ -665,6 +686,13 @@ static inline ulong clk_get_id(const struct clk *clk)
>>   {
>>   	return 0;
>>   }
>> +
>> +int of_clk_detect_critical(struct device_node *np, int index,
>> +			   unsigned long *flags)
>> +{
>> +	return 0;
>> +}
>> +
>>   #endif /* CONFIG_IS_ENABLED(CLK) */
>>   
>>   /**
>> diff --git a/include/dm/of_access.h b/include/dm/of_access.h
>> index 44143a5a391..dba725498f5 100644
>> --- a/include/dm/of_access.h
>> +++ b/include/dm/of_access.h
>> @@ -405,6 +405,17 @@ int of_property_read_string_helper(const struct device_node *np,
>>   				   const char *propname, const char **out_strs,
>>   				   size_t sz, int index);
>>   
>> +/*
>> + * struct property *prop;
>> + * const __be32 *p;
>> + * u32 u;
>> + *
>> + * of_property_for_each_u32(np, "propname", prop, p, u)
>> + *         printk("U32 value: %x\n", u);
>> + */
>> +const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
>> +			       u32 *pu);
>> +
>>   /**
>>    * of_property_read_string_index() - Find and read a string from a multiple
>>    * strings property.
>> @@ -701,4 +712,10 @@ int of_remove_property(struct device_node *np, struct property *prop);
>>    */
>>   int of_remove_node(struct device_node *to_remove);
>>   
>> +#define of_property_for_each_u32(np, propname, prop, p, u)	\
>> +	for (prop = of_find_property(np, propname, NULL),	\
>> +		p = of_prop_next_u32(prop, NULL, &u);		\
>> +		p;						\
>> +		p = of_prop_next_u32(prop, p, &u))
>> +
>>   #endif
>> -- 
> 
> I would split these of additional function to a separate commit also
> where they come from? They are ported from Linux Kernel?

Ok, I will split it.
Yes these function are ported from Linux Kernel.

> 
> Also would be ideal to have some scenario where it's needed to declare a
> clock in DT that is critical. Isn't that handled directly by the clock
> driver internally?
> 

Yes. Now we can use this property from DT by custom drivers to mark 
critical clocks.

