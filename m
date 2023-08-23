Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112CCEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 10:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21EF7864B8;
	Wed, 23 Aug 2023 12:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lutrLk+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1840864B9; Wed, 23 Aug 2023 12:15:22 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE8C864B3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 12:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37NAFHes073068;
 Wed, 23 Aug 2023 05:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692785717;
 bh=dHTRJtQv1cs/wfwm0iXbnfyjcv5zAbDxUZHzn+oeb+U=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=lutrLk+WwS3laQ0gmcYHsVQHP7Y05g1MsgOfOrJujzrS48NoNKE6kZ4KDRyRGXoWv
 TSM0GjT9HOVNIdqN3M0knjSWYIKpspoAjax1SlTTMQI94/3+77Q0AOElrLc8Ui/vBR
 PbFDMjqyqQsbAnX1sXNLu6CXAeqIA+rI7YAefWhI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37NAFHxV102239
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 05:15:17 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 05:15:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 05:15:16 -0500
Received: from [10.24.69.29] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37NAFC4F028667;
 Wed, 23 Aug 2023 05:15:13 -0500
Message-ID: <9ffa96cd-df18-d298-41c2-080a187b7410@ti.com>
Date: Wed, 23 Aug 2023 15:45:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V4 4/8] drivers: mmc: am654_sdhci: Update OTAP/ITAP delay
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nishanth Menon
 <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Jan Kiszka <jan.kiszka@siemens.com>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-5-nm@ti.com> <87r0nufaik.fsf@baylibre.com>
From: Nitin Yadav <n-yadav@ti.com>
In-Reply-To: <87r0nufaik.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Mattijs,

On 23/08/23 13:36, Mattijs Korpershoek wrote:
> On mar., août 22, 2023 at 13:41, Nishanth Menon <nm@ti.com> wrote:
> 
>> From: Nitin Yadav <n-yadav@ti.com>
>>
>> U-Boot is fail to boot class U1 UHS SD cards (such as microcenter)
>> due to incorrect OTAP and ITAP delay select values. Update OTAP and
>> ITAP delay select values based on recommeded RIOT values to fix boot
>> issue.
> 
> nitpick: recommeded -> recommended
> 
>>
>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> Picked up from TI u-boot
>> New patch in the series
>>
>>   drivers/mmc/am654_sdhci.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
>> index fd667aeafdaa..d0b51c0707d4 100644
>> --- a/drivers/mmc/am654_sdhci.c
>> +++ b/drivers/mmc/am654_sdhci.c
>> @@ -442,12 +442,18 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdhci_host *host)
>>   {
>>   	struct udevice *dev = host->mmc->dev;
>>   	struct am654_sdhci_plat *plat = dev_get_plat(dev);
>> -	u32 otap_del_sel, mask, val;
>> +	u32 otap_del_sel, itap_del_sel, mask, val;
>>   
>>   	otap_del_sel = plat->otap_del_sel[host->mmc->selected_mode];
>> -	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
>> -	val = (1 << OTAPDLYENA_SHIFT) | (otap_del_sel << OTAPDLYSEL_SHIFT);
>> +	itap_del_sel = plat->itap_del_sel[host->mmc->selected_mode];
>> +	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK | ITAPDLYSEL_MASK |
>> +		ITAPDLYENA_MASK;
>> +	val = (1 << OTAPDLYENA_SHIFT) | (otap_del_sel << OTAPDLYSEL_SHIFT) |
>> +		(1 << ITAPDLYENA_SHIFT) | (itap_del_sel << ITAPDLYSEL_SHIFT);
>> +	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK,
>> +			   1 << ITAPCHGWIN_SHIFT);
>>   	regmap_update_bits(plat->base, PHY_CTRL4, mask, val);
>> +	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
>>   
>>   	regmap_update_bits(plat->base, PHY_CTRL5, CLKBUFSEL_MASK,
>>   			   plat->clkbuf_sel);
>> @@ -501,7 +507,7 @@ static int sdhci_am654_get_otap_delay(struct udevice *dev,
>>   	 * Remove the corresponding capability if an otap-del-sel
>>   	 * value is not found
>>   	 */
>> -	for (i = MMC_HS; i <= MMC_HS_400; i++) {
>> +	for (i = MMC_LEGACY; i <= MMC_HS_400; i++) {
> 
> I'm not super familiar with mmc drivers in general, but it feels like
> this bit does not really belong in this patch. >
> Is this another bugfix for removing otap-del-sel for MMC_LEGACY devices
> or does U1 UHS SD cards are considered to be of MMC_LEGACY type ?
yes, its two different fix. Internally I posted two patches for them. 
can be referred in below links:

https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-6.1.y-cicd&id=b5a2f7972fd142df03a15ba58829aa068c891abf

https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-6.1.y-cicd&id=527095165281cbc60a1b42995c1e55e6756cbe93

> 
>>   		ret = dev_read_u32(dev, td[i].otap_binding,
>>   				   &plat->otap_del_sel[i]);
>>   		if (ret) {
>> -- 
>> 2.40.0

-- 
Regards,
Nitin
