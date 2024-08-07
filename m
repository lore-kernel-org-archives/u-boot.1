Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E357C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 08:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF4A871C9;
	Wed,  7 Aug 2024 10:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RPexaJ+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E5ED889BE; Wed,  7 Aug 2024 10:42:04 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6C3280805
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 10:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4778frHg078471;
 Wed, 7 Aug 2024 03:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723020113;
 bh=1CZN4SxtKlA4jPHoKJoVofLDFpd3/R7MiFdDKeybx5U=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=RPexaJ+Ji46291y0QEiNIxchf80G3Af525KShqLqm/dHcJaiSAZmQVBs1EVsh9CgL
 z9DW2tfYbqVxluEJ6vVujDSk7gbdXtc3BH1kKq/7YhnkvLMv463NBmw0yDNMA5Ldht
 zsxWQ95Zzi+fgzGy6dd15ehEFm5FxlbaicgihWmI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4778frsw085443
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 Aug 2024 03:41:53 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 03:41:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 03:41:52 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4778fnCF083710;
 Wed, 7 Aug 2024 03:41:50 -0500
Message-ID: <5e916060-444e-40c8-b88e-f22df851d1f9@ti.com>
Date: Wed, 7 Aug 2024 14:11:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: uclass: Modify uc_pdata->name to use
 combination of device name and device's parent name
To: Roger Quadros <rogerq@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>
References: <20240719085908.3564171-1-danishanwar@ti.com>
 <c7195d30-2789-4d31-81ca-5f285cae40e7@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <c7195d30-2789-4d31-81ca-5f285cae40e7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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



On 05/08/24 12:08 pm, Roger Quadros wrote:
> 
> 
> On 19/07/2024 11:59, MD Danish Anwar wrote:
>> uc_pdata->name is populated from device tree property "remoteproc-name".
>> For those devcices that don't set "remoteproc-name", uc_pdata->name
>> falls back to dev->name.
>>
>> If two devices have same name, this will result into uc_pdata->name not
>> being unique and rproc_init() will fail.
>>
>> Fix this by using combination of dev->name and dev->parent->name instead
>> of using just the dev->name to populate uc_pdata->name.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>> Cc: Andrew Davis <afd@ti.com>
>>
>> Failure Example:
>> In k3-am64-main.dtsi, both pru0_0 [1] and pru1_0 [2] will have
>> dev->name as "pru@34000" although their parent name is different.
>>
>> pru0_0 has dev->name as "pru@34000" and parent name as "icssg@30000000"
>> pru1_0 has dev->name as "pru@34000" and parent name as "icssg@30080000"
>>
>> rproc_init() fails for pru1_0 as the the uc_pdata->name becomes same as the pru0_0.
>> More details on this issue can be found here [3]. It was suggested to use a
>> different combination if `dev->name` is not unique by Andrew Davis <afd@ti.com> [4]
>>
>> Failure Logs:
>> 	rproc_pre_probe: 'pru@34000': using fdt
>> 	rproc_pre_probe: 'pru@34000': using fdt
>> 	rproc_pre_probe: pru@34000 duplicate name 'pru@34000'
>> 	_rproc_probe_dev: pru@34000: Failed to initialize - -22
>> 	rproc_boot: rproc_init() failed: -22
>>
>> To fix it, this commit uses combination of dev and dev's parent name.
>>
>> After this commit,
>> pru0_0 uc->pdata->name = "pru@34000:icssg@30000000"
>> pru1_0 uc->pdata->name = "pru@34000:icssg@30080000"
>>
>> Both the names are unique, thus rproc_init() succeeds.
>>
>> [1] https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1276
>> [2] https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1417
>> [3] https://lore.kernel.org/all/5cda289f-1d14-41f6-84e3-ff1d1034be13@ti.com/
>> [4] https://lore.kernel.org/all/e48f5818-182c-47ab-b384-379659830d38@ti.com/
>>
>>  drivers/remoteproc/rproc-uclass.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
>> index 3ba2b40dca..e550292dda 100644
>> --- a/drivers/remoteproc/rproc-uclass.c
>> +++ b/drivers/remoteproc/rproc-uclass.c
>> @@ -158,9 +158,15 @@ static int rproc_pre_probe(struct udevice *dev)
>>  		uc_pdata->driver_plat_data = pdata->driver_plat_data;
>>  	}
>>  
>> -	/* Else try using device Name */
>> -	if (!uc_pdata->name)
>> -		uc_pdata->name = dev->name;
>> +	/* Else try using a combination of device Name and devices's parent's name */
>> +	if (!uc_pdata->name) {
>> +		int rproc_name_size = 256;
> 
> Instead of hardcoding 256 why not use
> 		buf = malloc(strlen(dev->name) + strlen(dev->parent->name) + 2);	// 1 for null and one for '-'
> 
>> +		char *buf;
>> +
>> +		buf = malloc(rproc_name_size);
> 
> need to check/error out for malloc failure.

Sure Roger, I will make these changes and update the patch. Thanks for
the review.

> 
>> +		snprintf(buf, rproc_name_size, "%s-%s", dev->name, dev->parent->name);
>> +		uc_pdata->name = buf;
>> +	}
>>  	if (!uc_pdata->name) {
>>  		debug("Unnamed device!");
>>  		return -EINVAL;
> 

-- 
Thanks and Regards,
Danish
