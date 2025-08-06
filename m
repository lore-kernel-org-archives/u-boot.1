Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAB7C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 15:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FAA8842F7;
	Wed,  6 Aug 2025 17:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NBBmr3aS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A668432F; Wed,  6 Aug 2025 17:45:34 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C9DC842EE
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 17:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 576FjUC3155768;
 Wed, 6 Aug 2025 10:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754495130;
 bh=fIIVj/fhdF4sjN0WZkefWIeG5Gt3GnAUo2Y1+b/AU04=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=NBBmr3aSUC1v9yKjmgCW9NClBJRJpDS8UnSuSd+UJqz+s9uaMRxdw7nTMjSunjDVH
 mqRUkT68WqPmcclV//ESeGVo8TgiSNfn78BLLG4gCbPyQ2fasSfwVtaxQCEsX1Z42Q
 /Ln4uBNGZopi/qhwja6SMEFUv+2pfbtZnegECdTk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 576FjUZ5133725
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 6 Aug 2025 10:45:30 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 6
 Aug 2025 10:45:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 6 Aug 2025 10:45:29 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 576FjTSB3767977;
 Wed, 6 Aug 2025 10:45:29 -0500
Message-ID: <bd800d84-9a3e-45bd-ab5f-788110181dc6@ti.com>
Date: Wed, 6 Aug 2025 10:45:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] soc: soc_ti_k3: Add support for AM62P variants
To: Tom Rini <trini@konsulko.com>
CC: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Bryan
 Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
References: <20250805161419.1781935-1-jm@ti.com>
 <20250805161419.1781935-2-jm@ti.com> <20250805223947.GL124814@bill-the-cat>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250805223947.GL124814@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Tom,

On 8/5/25 5:39 PM, Tom Rini wrote:
> On Tue, Aug 05, 2025 at 11:14:18AM -0500, Judith Mendez wrote:
>> This adds a support for detecting AM62P SR1.0, SR1.1, SR1.2.
>>
>> On AM62P, silicon revision is discovered with GP_SW1 register instead
>> of JTAGID register, so introduce GP_SW register range to determine SoC
>> revision for AM62P.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/soc/soc_ti_k3.c | 70 ++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 65 insertions(+), 5 deletions(-)
> [snip]
>> @@ -130,17 +184,23 @@ static const struct soc_ops soc_ti_k3_ops = {
>>   int soc_ti_k3_probe(struct udevice *dev)
>>   {
>>   	struct soc_ti_k3_plat *plat = dev_get_plat(dev);
>> -	u32 idreg;
>> +	u32 gp_sw1_val = 0;
>>   	void *idreg_addr;
>> +	u32 idreg;
>>   
>> -	idreg_addr = dev_read_addr_ptr(dev);
>> +	idreg_addr = dev_read_addr_index_ptr(dev, 0);
>>   	if (!idreg_addr)
>>   		return -EINVAL;
>>   
>>   	idreg = readl(idreg_addr);
>>   
>> +#if IS_ENABLED(CONFIG_SOC_K3_AM62P5)
>> +	if (soc_ti_k3_variant_in_gp_sw(idreg))
>> +		gp_sw1_val = soc_ti_k3_get_variant_alternate(dev, idreg);
>> +#endif /* CONFIG_SOC_K3_AM62P5 */
> 
> This isn't quite what I meant, as it will generate warnings about unused
> variables for the tables, on other platforms, yes? What I was thinking
> was:
> if (IS_ENABLED(CONFIG_SOC_K3_AM62P5) && soc_ti_k3_variant_in_gp_sw(idreg))
> 	gp_sw1_val = soc_ti_k3_get_variant_alternate(dev, idreg);
> which shouldn't. And then can we check the other platforms similarly to
> save space or no? Or am I unclear with what I'm thinking (or it's not
> possible, I didn't dig at the rest of the code much)? Thanks.
> 

It is not very clear, but let me clarify:soc_ti_k3_get_variant_alternate
should only get called for AM62P and get_rev_string should get called
for all SoCs.

So it only makes sense to do this then:

if (IS_ENABLED(CONFIG_SOC_K3_AM62P5) && soc_ti_k3_variant_in_gp_sw(idreg))
	gp_sw1_val = soc_ti_k3_get_variant_alternate(dev, idreg);

plat->revision = get_rev_string(idreg, gp_sw1_val);



~ Judith










