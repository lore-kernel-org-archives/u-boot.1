Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A844EE14D4
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 04:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0442385FD3;
	Thu,  7 Sep 2023 06:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n4HWCHNT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8710C8620C; Thu,  7 Sep 2023 06:31:13 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D415B85F9F
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 06:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3874V61f114483;
 Wed, 6 Sep 2023 23:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694061066;
 bh=po0L4ZKYZWs9XsYTl3h5F60sEZk0+Py6yGCQ0USshR0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=n4HWCHNT0KWMSyZCnkqhAW77ijS3VMyPQZTl/CgxvmKJ7W8FaFtEe/KqY8E3V1tSX
 uPakdhAVWAT3tj0CBNjdtydQOe8TFfo9qeHrbtND7Jbm5KTTFbkKhgkLetz5SRW1Ng
 6mu1Ap3F4NmJKX05b1vfsz8zbBv6wxr0YQYt8dJU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3874V6Fc074698
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Sep 2023 23:31:06 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Sep 2023 23:31:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Sep 2023 23:31:06 -0500
Received: from [172.24.25.97] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3874V3Xm022638;
 Wed, 6 Sep 2023 23:31:03 -0500
Message-ID: <52a7c0b2-7a87-c74e-e63f-d07821ffc1f8@ti.com>
Date: Thu, 7 Sep 2023 10:01:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] drivers: misc: k3_avs: Add Linux compatible to enable
 avs in u-boot
To: reidt <reidt@ti.com>, Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>,
 <afd@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
References: <20230905181309.61666-1-reidt@ti.com>
 <20230905181309.61666-2-reidt@ti.com>
 <20230906180631.6cn5dva5ie3xm74w@slinky>
 <20230906192834.54weltwklcmgclto@reidt-HP-Z2>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230906192834.54weltwklcmgclto@reidt-HP-Z2>
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


On 9/7/2023 12:58 AM, reidt wrote:
> On 13:06-20230906, Nishanth Menon wrote:
>> On 13:13-20230905, Reid Tonking wrote:
>>> The ti,j7200-vtm compatible is used for voltage and thermal monitoring
>>> (VTM) by (drivers/thermal/k3_j72xx_bandgap.c) in Linux, but the same
>>> hardware is used for adaptive voltage scaling (AVS) in u-boot, This brings
>>> both drivers in line with the same compatible. Since the j7200 uses the
>>> config as the j721e, the data is inherited from j721e vs creating a
>>> duplicate in all but name.
>>>
>>> Signed-off-by: Reid Tonking <reidt@ti.com>
>>> ---
>>>   drivers/misc/k3_avs.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
>>> index 840148d090..f7936017ba 100644
>>> --- a/drivers/misc/k3_avs.c
>>> +++ b/drivers/misc/k3_avs.c
>>> @@ -382,7 +382,7 @@ static struct vd_config am654_vd_config = {
>>>   static const struct udevice_id k3_avs_ids[] = {
>>>   	{ .compatible = "ti,am654-avs", .data = (ulong)&am654_vd_config },
>>>   	{ .compatible = "ti,j721e-avs", .data = (ulong)&j721e_vd_config },
>>> -	{}
>>> +	{ .compatible = "ti,j7200-vtm", .data = (ulong)&j721e_vd_config }
>> you don't need the null terminator?
>>
> Ah, I wasn't aware of its purpose until now, but searched it up.
> I'll add it back in for v3.
>
>>>   };
>>>   
>>>   U_BOOT_DRIVER(k3_avs) = {
>>> -- 
>>> 2.34.1
>>>
>> https://lore.kernel.org/all/1fed9388-dfc4-0b9c-4502-b5020b2aed1a@ti.com/
>>
>> Will let Udit and you sort this out.
> Udit and I talked a bit about this yesterday. It's something to explore
> implementing down the road, after this sync - nothing immediate

Integration of TSHUT or porting of bandgap driver into this driver is 
incremental work.

So change of name is compatible for this series is ok.

Thanks


>> -- 
>> Regards,
>> Nishanth Menon
>> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
> Thanks,
> Reid Tonking
