Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808B5C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 12:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1C9C8872B;
	Wed, 24 Apr 2024 14:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qEcGzBHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 999F98872E; Wed, 24 Apr 2024 14:52:33 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0414A88700
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 14:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43OCqPSh030386;
 Wed, 24 Apr 2024 07:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713963145;
 bh=N8LE7EFGtzzAB4r2cvBA3RkQiW7AN2ZkBedLGBK/X/A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=qEcGzBHUGyB05/4VQegzdMP/QmGs8c7n0GbwcH4a2JuL/raj9C0k8f4QUojC87TsP
 0aV7ap8p4Ajs3CPNp1JYnYHCj+pUDKWkeJjlgKDulHZN71In2+hHAEMb75B5kPWdPg
 vp4hz3ci/sE7ItFKKoZGtrBaM3ZH3lXvKr5gSQRM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43OCqPZh022802
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Apr 2024 07:52:25 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 07:52:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 07:52:25 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43OCqMLS043656;
 Wed, 24 Apr 2024 07:52:22 -0500
Message-ID: <9257d4e3-38db-48de-86ee-e401d9cff349@ti.com>
Date: Wed, 24 Apr 2024 18:22:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] soc: ti: k3-navss-ringacc: Initialize base address
 of ring cfg registers
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <nm@ti.com>, <sjg@chromium.org>, <afd@ti.com>, <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-4-s-vadapalli@ti.com>
 <121dc2b7-0fc7-42ac-80cb-9c1af64a09eb@kernel.org>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <121dc2b7-0fc7-42ac-80cb-9c1af64a09eb@kernel.org>
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



On 16/01/24 17:13, Roger Quadros wrote:
> Hi,
> 
> On 12/01/2024 08:47, Siddharth Vadapalli wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Initialize base address of ring config registers required to natively
>> setup ring cfg registers in the absence of Device Manager (DM) services
>> at R5 SPL stage.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>   drivers/soc/ti/k3-navss-ringacc.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
>> index 7a2fbb0db6..31e9b372ee 100644
>> --- a/drivers/soc/ti/k3-navss-ringacc.c
>> +++ b/drivers/soc/ti/k3-navss-ringacc.c
>> @@ -1030,8 +1030,8 @@ static int k3_nav_ringacc_init(struct udevice *dev, struct k3_nav_ringacc *ringa
>>   struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
>>   						struct k3_ringacc_init_data *data)
>>   {
>> +	void __iomem *base_rt, *base_cfg;
>>   	struct k3_nav_ringacc *ringacc;
>> -	void __iomem *base_rt;
>>   	int i;
>>   
>>   	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
>> @@ -1049,6 +1049,10 @@ struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
>>   	if (!base_rt)
>>   		return ERR_PTR(-EINVAL);
>>   
>> +	base_cfg = dev_read_addr_name_ptr(dev, "cfg");
>> +	if (!base_cfg)
>> +		return ERR_PTR(-EINVAL);
>> +
> 
> Should this be restricted only for R5 SPL case? else we conflict with
> Device Manager services?
> 

I don't see any conflict in it, you can go through this:
https://github.com/u-boot/u-boot/commit/86e58800fd7cdba4fa9229aeee3a54a2ccece406

>>   	ringacc->rings = devm_kzalloc(dev,
>>   				      sizeof(*ringacc->rings) *
>>   				      ringacc->num_rings * 2,
>> @@ -1063,6 +1067,7 @@ struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
>>   	for (i = 0; i < ringacc->num_rings; i++) {
>>   		struct k3_nav_ring *ring = &ringacc->rings[i];
>>   
>> +		ring->cfg = base_cfg + KNAV_RINGACC_CFG_REGS_STEP * i;
>>   		ring->rt = base_rt + K3_DMARING_RING_RT_REGS_STEP * i;
>>   		ring->parent = ringacc;
>>   		ring->ring_id = i;
> 
