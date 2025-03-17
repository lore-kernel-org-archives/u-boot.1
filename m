Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA33FC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 04:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28202810F4;
	Mon, 17 Mar 2025 05:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UHJ+2Rj/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FCF381100; Mon, 17 Mar 2025 05:25:23 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D033E80F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 05:25:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52H4PILj2228312
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Mar 2025 23:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742185519;
 bh=wqdd/PsbpM7cZboSNNyFviAbYkaQRyS5cFwUG7i72WE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=UHJ+2Rj/WKqoPQZ/Q/v7fX86m9ptxAauxlDmMnUjQr5NQuY1tfgOkKoLu1XVIAoWa
 7vpsljDYGCAgMXTk+M/KDgCn6nJFRA5uxv1dTwdsey+Pi1zgX472FSRsOoMMQI8tTK
 +/c5pNEg3tlJhlsdVKcBZwZST1xCUqcMmLqGj3eA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52H4PId9113327
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 16 Mar 2025 23:25:18 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 16
 Mar 2025 23:25:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 16 Mar 2025 23:25:18 -0500
Received: from [172.24.27.183] (lt5cd2489kgj.dhcp.ti.com [172.24.27.183])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52H4PD00031601;
 Sun, 16 Mar 2025 23:25:14 -0500
Message-ID: <99bef8ff-ba46-4597-b902-1ab283a538d1@ti.com>
Date: Mon, 17 Mar 2025 09:55:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: am68_sk_r5: Enable AVS config
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <m-chawdhry@ti.com>,
 <j-keerthy@ti.com>, <m-shah@ti.com>, <a-limaye@ti.com>
References: <20250314123824.2886341-1-u-kumar1@ti.com>
 <b8a97a67-7eab-452b-afda-6d70168b5502@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <b8a97a67-7eab-452b-afda-6d70168b5502@ti.com>
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


On 3/17/2025 9:25 AM, Neha Malcom Francis wrote:
> Hi Udit
>
> On 14/03/25 18:08, Udit Kumar wrote:
>> Enable AVS config
>>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>> Test logs
>> https://gist.github.com/uditkumarti/9b30461e66aa27e4a813a65f1c552e51#file-gistfile1-txt-L298
>>
>> Following print was added to see AVS voltage setting at
>> diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
>> index 0774e0a4c9e..ed1a5768147 100644
>> --- a/drivers/misc/k3_avs.c
>> +++ b/drivers/misc/k3_avs.c
>> @@ -142,7 +142,7 @@ static int k3_avs_program_voltage(struct k3_avs_privdata *priv,
>>
>>                  vd2->flags |= VD_FLAG_INIT_DONE;
>>          }
>> -
>> +       printf("Finally setting voltage \n");
> Was this printf intended to be in the patch?

My bad,

I thought of adding test code below tear line .. But eventually test 
code becoming part of patch.

will fix and send v2


>
>>          return regulator_set_value(vd->supply, volt);
>>   }
>>
>>
>>   configs/am68_sk_r5_defconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/configs/am68_sk_r5_defconfig b/configs/am68_sk_r5_defconfig
>> index 097bed62061..d6ef89c7b84 100644
>> --- a/configs/am68_sk_r5_defconfig
>> +++ b/configs/am68_sk_r5_defconfig
>> @@ -6,7 +6,6 @@ CONFIG_SOC_K3_J721S2=y
>>   CONFIG_TARGET_J721S2_R5_EVM=y
>>   
>>   CONFIG_ESM_K3=n
>> -CONFIG_K3_AVS0=n
>>   CONFIG_ESM_PMIC=n
>>   CONFIG_DM_REGULATOR_TPS65941=n
>>   CONFIG_PMIC_TPS65941=n
