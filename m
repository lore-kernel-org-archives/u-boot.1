Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435D2C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 14:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C27A588634;
	Thu, 18 Apr 2024 16:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c5E7WZ1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8704F8863B; Thu, 18 Apr 2024 16:40:42 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46AB488553
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 16:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43IEecMP053400;
 Thu, 18 Apr 2024 09:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713451238;
 bh=RNXbqU/geJYt+EOdcpMPKkkaHR2a4UF1TuPO6LLrcIg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=c5E7WZ1qPOLDZAop/nmDi4WGEBX5Ly94bGKc1qir98Cwp26VxrTBKCtMxIuYwcqnS
 e7+2O+eZP7SOj0n6Yzxctmfyku68Nj5UOgeTeG69Y3v3HEPChlKhQYBca9ECfnkd3D
 Qgj0+hUnb0nw5TjapNql7YScAvzYm8EPPS6BeAzg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43IEec0q019598
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 18 Apr 2024 09:40:38 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 09:40:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 09:40:37 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43IEebcq090734;
 Thu, 18 Apr 2024 09:40:37 -0500
Message-ID: <1da704c5-c297-4f42-9e1a-cc1bb9f41b2c@ti.com>
Date: Thu, 18 Apr 2024 09:40:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mmc: am654_sdhci: Add itap_del_ena[] to store
 itapdlyena bit
To: Jaehoon Chung <jh80.chung@samsung.com>, "'Peng Fan'" <peng.fan@nxp.com>,
 "'Tom Rini'" <trini@konsulko.com>
CC: "'Nitin Yadav'" <n-yadav@ti.com>, "'Simon Glass'" <sjg@chromium.org>,
 <u-boot@lists.denx.de>
References: <20240415212747.2678974-1-jm@ti.com>
 <CGME20240415212756epcas1p1c70934056512b8c4186e6cdde3fbc376@epcas1p1.samsung.com>
 <20240415212747.2678974-4-jm@ti.com>
 <01fd01da90bb$28fc5300$7af4f900$@samsung.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <01fd01da90bb$28fc5300$7af4f900$@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 4/17/24 6:34 AM, Jaehoon Chung wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Judith Mendez <jm@ti.com>
>> Sent: Tuesday, April 16, 2024 6:28 AM
>> To: Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>
>> Cc: Nitin Yadav <n-yadav@ti.com>; Simon Glass <sjg@chromium.org>; u-boot@lists.denx.de
>> Subject: [PATCH 3/5] mmc: am654_sdhci: Add itap_del_ena[] to store itapdlyena bit
>>
>> Set itap_del_ena if ITAPDLY is found in DT or if the tuning
>> algorithm was executed and found the optimal ITAPDLY. Add the
>> functionality to save ITAPDLYENA that can be referenced later
>> by storing the bit in array itap_del_ena[].
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/mmc/am654_sdhci.c | 30 ++++++++++++++++++++----------
>>   1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
>> index 1dd032e1e36..38f1ad28ec4 100644
>> --- a/drivers/mmc/am654_sdhci.c
>> +++ b/drivers/mmc/am654_sdhci.c
>> @@ -92,6 +92,7 @@ struct am654_sdhci_plat {
>>   	bool non_removable;
>>   	u32 otap_del_sel[MMC_MODES_END];
>>   	u32 itap_del_sel[MMC_MODES_END];
>> +	u32 itap_del_ena[MMC_MODES_END];
>>   	u32 trm_icp;
>>   	u32 drv_strength;
>>   	u32 strb_sel;
>> @@ -223,8 +224,10 @@ static int am654_sdhci_setup_dll(struct am654_sdhci_plat *plat,
>>   }
>>
>>   static void am654_sdhci_write_itapdly(struct am654_sdhci_plat *plat,
>> -				      u32 itapdly)
>> +				      u32 itapdly, u32 enable)
>>   {
>> +	regmap_update_bits(plat->base, PHY_CTRL4, ITAPDLYENA_MASK,
>> +			   enable << ITAPDLYENA_SHIFT);
>>   	/* Set ITAPCHGWIN before writing to ITAPDLY */
>>   	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK,
>>   			   1 << ITAPCHGWIN_SHIFT);
>> @@ -242,7 +245,8 @@ static void am654_sdhci_setup_delay_chain(struct am654_sdhci_plat *plat,
>>   	mask = SELDLYTXCLK_MASK | SELDLYRXCLK_MASK;
>>   	regmap_update_bits(plat->base, PHY_CTRL5, mask, val);
>>
>> -	am654_sdhci_write_itapdly(plat, plat->itap_del_sel[mode]);
>> +	am654_sdhci_write_itapdly(plat, plat->itap_del_sel[mode],
>> +				  plat->itap_del_ena[mode]);
>>   }
>>
>>   static int am654_sdhci_set_ios_post(struct sdhci_host *host)
>> @@ -443,6 +447,7 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
>>   	struct udevice *dev = mmc->dev;
>>   	struct am654_sdhci_plat *plat = dev_get_plat(dev);
>>   	struct window fail_window[ITAPDLY_LENGTH];
>> +	int mode = mmc->selected_mode;
>>   	u8 curr_pass, itap;
>>   	u8 fail_index = 0;
>>   	u8 prev_pass = 1;
>> @@ -450,11 +455,10 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
>>   	memset(fail_window, 0, sizeof(fail_window));
>>
>>   	/* Enable ITAPDLY */
>> -	regmap_update_bits(plat->base, PHY_CTRL4, ITAPDLYENA_MASK,
>> -			   1 << ITAPDLYENA_SHIFT);
>> +	plat->itap_del_ena[mode] = 0x1;
> 
> 0x1 means "enable"? I want to use a macro with meaning.

Sure, can do for V2, thanks.
~ Judith

> 
>>
>>   	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
>> -		am654_sdhci_write_itapdly(plat, itap);
>> +		am654_sdhci_write_itapdly(plat, itap, plat->itap_del_ena[mode]);
>>
>>   		curr_pass = !mmc_send_tuning(mmc, opcode, NULL);
>>
>> @@ -478,7 +482,7 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
>>   	itap = am654_sdhci_calculate_itap(dev, fail_window, fail_index,
>>   					  plat->dll_enable);
>>
>> -	am654_sdhci_write_itapdly(plat, itap);
>> +	am654_sdhci_write_itapdly(plat, itap, plat->itap_del_ena[mode]);
>>
>>   	return 0;
>>   }
>> @@ -515,6 +519,7 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdhci_host *host)
>>   	struct am654_sdhci_plat *plat = dev_get_plat(dev);
>>   	int mode = host->mmc->selected_mode;
>>   	u32 otap_del_sel;
>> +	u32 itap_del_ena;
>>   	u32 itap_del_sel;
>>   	u32 mask, val;
>>
>> @@ -524,10 +529,11 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdhci_host *host)
>>   	val = (1 << OTAPDLYENA_SHIFT) |
>>   	      (otap_del_sel << OTAPDLYSEL_SHIFT);
>>
>> +	itap_del_ena = plat->itap_del_ena[mode];
>>   	itap_del_sel = plat->itap_del_sel[mode];
>>
>>   	mask |= ITAPDLYENA_MASK | ITAPDLYSEL_MASK;
>> -	val = (1 << ITAPDLYENA_SHIFT) |
>> +	val = (itap_del_ena << ITAPDLYENA_SHIFT) |
>>   	      (itap_del_sel << ITAPDLYSEL_SHIFT);
>>
>>   	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK,
>> @@ -599,9 +605,13 @@ static int sdhci_am654_get_otap_delay(struct udevice *dev,
>>   			cfg->host_caps &= ~td[i].capability;
>>   		}
>>
>> -		if (td[i].itap_binding)
>> -			dev_read_u32(dev, td[i].itap_binding,
>> -				     &plat->itap_del_sel[i]);
>> +		if (td[i].itap_binding) {
>> +			ret = dev_read_u32(dev, td[i].itap_binding,
>> +					   &plat->itap_del_sel[i]);
>> +
>> +			if (!ret)
>> +				plat->itap_del_ena[i] = 0x1;
> 
> Ditto.
> 
> Best Regards,
> Jaehoon Chung
> 
>> +		}
>>   	}
>>
>>   	return 0;
>> --
>> 2.43.2
> 
> 

