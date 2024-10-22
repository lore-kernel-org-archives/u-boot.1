Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C967D2C54A
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D9F88F4D;
	Tue, 22 Oct 2024 14:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wjvrZVTZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EEC988EBA; Tue, 22 Oct 2024 14:55:28 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92DDD80245
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49MCtNRG008226;
 Tue, 22 Oct 2024 07:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729601723;
 bh=XnJ7Gwlr/ALS6jz94H5GyOtOEfamTF/1AvipQ50l7C0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wjvrZVTZy/w6A6NXS5a93nIV7Nb3lknU19j2mbUIzOHqT4PYvnjqi1UDqgom5t00C
 tEFE0bhz1sQSEPTIrIQbM3unypF2+rw9iY7J9LYKlgrQX2IYq8i/NsoapQzI0ns1yd
 kE2k0xp1YaKELJU0zy2d0n0ss2Ya6T8gv7VRiTs0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49MCtNEQ055968;
 Tue, 22 Oct 2024 07:55:23 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Oct 2024 07:55:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Oct 2024 07:55:22 -0500
Received: from [10.249.132.3] ([10.249.132.3])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49MCtJox084123;
 Tue, 22 Oct 2024 07:55:20 -0500
Message-ID: <8ef0f46b-1d3f-4c33-9348-82a626e8de42@ti.com>
Date: Tue, 22 Oct 2024 18:25:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] misc: k3_avs: Add k3_check_opp function
To: Neha Malcom Francis <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>
References: <20241017062911.2241167-1-a-limaye@ti.com>
 <20241017062911.2241167-4-a-limaye@ti.com>
 <cdcc56d6-6ad6-43f9-b2a7-0abd350e319c@ti.com>
Content-Language: en-US
From: "Limaye, Aniket" <a-limaye@ti.com>
In-Reply-To: <cdcc56d6-6ad6-43f9-b2a7-0abd350e319c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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



On 10/17/2024 4:06 PM, Neha Malcom Francis wrote:
> Hi Aniket
> 
> On 17/10/24 11:59, Aniket Limaye wrote:
>> From: Reid Tonking <reidt@ti.com>
>>
>> Useful when trying to check if an opp efuse is burned in or not.
>>
>> k3_avs driver checks opp_ids when probing and overwrites the voltage
>> values in vd_data for the respective board. This can be called to check
>> that data and returns 0 if valid.
>>
>> Signed-off-by: Reid Tonking <reidt@ti.com>
>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>> ---
>>   drivers/misc/k3_avs.c | 25 +++++++++++++++++++++++++
>>   include/k3-avs.h      |  1 +
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
>> index 9d950d034a5..90cd9dfe7f9 100644
>> --- a/drivers/misc/k3_avs.c
>> +++ b/drivers/misc/k3_avs.c
>> @@ -192,6 +192,31 @@ static int match_opp(struct vd_data *vd, u32 freq)
>>       return -EINVAL;
>>   }
>> +/**
>> + * k3_check_opp: Check for presence of opp efuse
>> + * @opp_id: opp id to check if voltage is present
>> + *
>> + * Checks to see if an opp has voltage. k3_avs probe will populate
>> + * votlage data if efuse is present. Returns 0 if data is valid.
>> + */
>> +int k3_check_opp(struct udevice *dev, int vdd_id, int opp_id)
> 
> Can this be a static function?

It is being used in the board file (j721e-init.c) in the following 
commit... to check if efuse was read correctly, before attempting to set 
an OPP.

> 
>> +{
>> +    struct k3_avs_privdata *priv = dev_get_priv(dev);
>> +    struct vd_data *vd;
>> +    int volt;
>> +
>> +    vd = get_vd(priv, vdd_id);
>> +    if (!vd)
>> +        return -EINVAL;
>> +
>> +    volt = vd->opps[opp_id].volt;
>> +    if (volt)
>> +        return 0;
>> +
>> +    printf("No efuse found for opp_%d\n", opp_id);
>> +    return -EINVAL;
>> +}
>> +
>>   /**
>>    * k3_avs_notify_freq: Notify clock rate change towards AVS subsystem
>>    * @dev_id: Device ID for the clock to be changed
>> diff --git a/include/k3-avs.h b/include/k3-avs.h
>> index f6f1031c9cc..41a1da36356 100644
>> --- a/include/k3-avs.h
>> +++ b/include/k3-avs.h
>> @@ -27,5 +27,6 @@
>>   int k3_avs_set_opp(struct udevice *dev, int vdd_id, int opp_id);
>>   int k3_avs_notify_freq(int dev_id, int clk_id, u32 freq);
>> +int k3_check_opp(struct udevice *dev, int vdd_id, int opp_id);
>>   #endif
> 

