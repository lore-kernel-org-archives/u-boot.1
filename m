Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87971CD98F2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 10:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D989C84866;
	Mon, 22 Jun 2026 12:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Qp1RD0UJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10E9184931; Mon, 22 Jun 2026 12:41:52 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDE2E84832
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 12:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NW8QcT+FNxrQ2IurdtnGJiX3lf1PUArmfsUMZbwyfIIZrb6oVMtpVin1NHb+kF2haQ+aLXM7hsxjMWPJU3urxdAG0sDl4IuGAGGeH+UlYTlw5izCIw7qcjmQQWxci+uedrPCBPo3LXEY6EgIwQn41ORLHri2uq/mLpIMBo0fbMQiJxqfKiJrUzWj+dSlCzQBdnIWC8X53asD9lDYrqhfIAbKiLWoLY/OQVuJcIU2AY1wH3EgmzpkMZhiGTHmhltn+F1n00nABLk+RO0S+xmWTicHtIPGAHFis8zxf8qRWnTZAFpCEh2TtCAt/qT1xRmWbAnxYTcA3qaBBRMAXlHD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt6Bjiv15UVIQnjoZ9EY16tSkDRjBzDQa4rcpzaF4eU=;
 b=iZB4qSwzRRpHOSbO9Qy0QPGvthoaw7NXWzGcV+RjGl+Efh2czrUfrEkZ+32pAqaPOASjCqJRLSjtOlx2b2k2YomV6jEwdykckvWHklWmGnVDoP1Cui3vqzfHoToy4z4V9py6llOCsK/zmBgzXmClkVkas4aWGjn6R5YvcyzM8pkIp1mKQbAoclLTMuDAHsZwm03WWf8xG3In4vTWzcsWqqFY/NIVtuX9Mqnp0OejoSUEIVs7/t61Aj91XExh7FPzdl7QnX+p6gCQ9xjREZJg7x8D8ZRMs4v6fAlPMLPevd56L5ea7YhI4Ppqz1FRb1g7q/08/V7FMMyiwHG9Vl2xHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt6Bjiv15UVIQnjoZ9EY16tSkDRjBzDQa4rcpzaF4eU=;
 b=Qp1RD0UJfBQAy8B0ecopkN3q/IqD6Hwfpy/o/nWCeNKpcjBzgzUVp8P0/98e5Qx0oVA3YDk8nn7uTAEu2cJz+XJDrpevCok7Z1R3w2CKXLp9YNoT66hK28GWMqbVWlMdfiBCcgT36CgxpaTYcRAbJ4wVbhGH851rwasrhkU7INjGzSGagWlKzZlHGBy3hf/VQYX0Y6EkSsFok1LzCRyn1orR9My98ZIuBD1WaPIsgAPG7X1uE0+qzxJwlh23bB+oOhpFwPE5skAKmDNLd41NA35Z7oQXc+FoLfoKrC+LKvp9Ui0Pyeu5irDL6zSotzf5FqmlcBq8gjfbQVD8haNyNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SJ0PR03MB5455.namprd03.prod.outlook.com (2603:10b6:a03:27b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 10:41:46 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 10:41:45 +0000
Message-ID: <4db1a58a-c1d8-4e17-a685-4202902a041d@altera.com>
Date: Mon, 22 Jun 2026 18:41:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] i2c: designware_i2c: Remove clk disabled codes
To: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Wojciech Szamocki
 <wojciech.szamocki@nokia.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>
References: <cover.1777439293.git.dinesh.maniyam@altera.com>
 <2e5bd18743849a8be91ad4690075a545fa56177c.1777439293.git.dinesh.maniyam@altera.com>
 <df8f5a31-8ea8-b1cb-6807-4b1bb78cdf03@nabladev.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <df8f5a31-8ea8-b1cb-6807-4b1bb78cdf03@nabladev.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SJ0PR03MB5455:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4240a6-757b-4430-2a37-08ded04adacb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|4143699003|56012099006|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: v41fpokTtJAenYrosdtRcG3XY6pFRm84Hc9+Vaf3yqyQrQQObBweo0QBl1GqViVoZPPIBx5B3W6y0ZPbPeSbdxPgjZtFOdVp650ekM53DgWebm9LbELf92S+BGgE4Deelb6OAnKwLs4lbyXB2bsnBUJE8ilzZ6scqZGAbT6ocb/jnSuzPlbIzVMY2zVjTVjXISPiL5Shq7itu7/hIKpffgEYQ59X/mwCWeXAQ+MSPM0eHMkzIh17A5Pyb1hUt54JiempCALOnWZ+pRr5/K1AFFjNFVLndNXQd17arYC8OXRpaTKgKYSNI1kgEw3E4QM6nPnO7XGAw7Z1VYmYNp9bbjoCV7yBotiY2cuG0ifAu3e3mfcTohcvowPtS1WGkygQpXotdWXXDmASk/c+nD/KAzAbVM2ApOM14uPB0SqXJ87QWwD76/E4MaBh5gmunKrh2InD3u2AMaP7OBydZQaCSw3dhIyKUxwUcU1ROuljrY8MstbGxw27tfJm6Vu5VTlwU4jFcAnak8pl/gaMIdhVWNCSab0oCwZhyhVPB4X5YIbGWZmy+LSq3EuUPn+2b/Eft8D5P/waJxhzLk2ce+B8YG4jjJKSTe8VhS+T+SGjKaSn7oiUkPuH8CyA25o2tpc/8+TKBVXZHbhaWLjl2oDnXFkwKvOdyt/KXnEmbuaYUMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnBtNXp2em80Vm9BdlJpQ2pseGVZdDF5RC91akJ2QnFsVEdpZ2xjdHVrQ2VU?=
 =?utf-8?B?b21nOTdaV3p2bmZuOWVYaTBHL1lCOHFRakZ3OVM0bkI5ZmVENjAwVnE0Q1hC?=
 =?utf-8?B?cjJzV0FydlZiWXRYajNkbExPbFJlZFhUTFJ5UG1iZVorMSs3T0hLYm9OWmx6?=
 =?utf-8?B?ZXJQeE9MNzZ1Z3N3NVNnYXRCT29BRzMvTGtCV0hWSExSRWRmMlpHVjd5aHI4?=
 =?utf-8?B?OEtLT2YrcVJuUVhNS1YyM2lBL3drem51TmRpU2JQVGxFa2tqK2VDZlI4dEoy?=
 =?utf-8?B?cExRWEdVZ0xoRFpKajR0eUZPbHJPMEZjSkRyTlRKajRzcGdmaDJKNUx2aUJy?=
 =?utf-8?B?RWcycnJkVVpiSWh0RTNudG1xcU1FZDMyZld3RGxMbnhPZTdVbHQ5aEJRSzVo?=
 =?utf-8?B?c2tFczN1RnE0dVljSFM3SGRwUHU1MXBDYWxubXNmRVFsWHZWNDg4NEF0UGpy?=
 =?utf-8?B?Q2l4VTVDOFhNdEhUdnNkd0ZMc25FR3BNbDZITTF2SDgvclhYVmdhaXJDcEpJ?=
 =?utf-8?B?am5SZHpVVE1TcUMvejg2aU1sWnkwTFNONG4rM0NiN0wwa1ZSTExBSlBZR3Zz?=
 =?utf-8?B?aFpoU3kvQlBlL2JsNjh5MFpjMVR6anM4TnpFZTZmWk5VOGxSZjFMRnBPbnR4?=
 =?utf-8?B?SFY1UWQ5K09vblF6UGRqY1pQbDRFVjRPYzBnK2NBMzE0amt3RXp6K2tHTmIr?=
 =?utf-8?B?MHJYdUdIQ3JRdHlROHEraWdPUms2cHd4aTk3R2lwRWxvWCtGVUJFcUFjM08v?=
 =?utf-8?B?VHI4c1FDc242MFdsRWo2R3JuT2M1Zzg1MFB4RXdyT0tkbmRwajhhQ2JVWmhl?=
 =?utf-8?B?SmtVMVIxK2laWVpwMmMwQWRDVkFXdXFNcmsreGgwY0RPNnpDTmFGQzRUL0dF?=
 =?utf-8?B?MUtEZ3A5d0pGSDBvUktWYzVGQzYva3Q0bmw0MGFORDRBcXc2MHRiTVl0M2M2?=
 =?utf-8?B?amVwVXM5bU1WRjBLb0w2SVc2dlc3MCtwN2pSUkllZXpWOGNLTllNUlo1SjNQ?=
 =?utf-8?B?RDhuVGdHeWRQSDhGQzFQVnJOU1VnbHQ4OEdxTXZrZzREU2xMay8rR0JGNjQ1?=
 =?utf-8?B?ZW4rNjdVVzQzMHNqRlc3WU9VSC9PemlQakZlWEZlRURtUkZtbkMzR2poamlW?=
 =?utf-8?B?OUpoUEpkSkRLVDF3ZzJVYmFzTUVPMVhtOS9kMFhmK1ZzdFBKUENoczFxSWg1?=
 =?utf-8?B?RWJPZXloa0MyYVJWaDh2VmZqbUxjVVhFRTNoMmdTMHYwckNUb2JXVmhOWDh4?=
 =?utf-8?B?aExwTHB4VTIwZmUwUEF4ejFOUkRxQVBncG5EN0Vub1hrWVRTaXdIYi9BTUNn?=
 =?utf-8?B?bTRob0Rnd2x2YkxVdDl6ak5taXlJa0xXdk5HcGQ5OXQxRDIxZHo0MWlMd2F6?=
 =?utf-8?B?RTlZWFpZMlF3RzZrUkJkS0hlUGU0R2taTm41V2hQZ0x6Qk9XdW1Ed0VOTFFB?=
 =?utf-8?B?UDdqbUtZMkc4Uk1rM3VKV2hnaTh3OHFjdHFDMW9VYlJNS3hyQUM2dy93UnU1?=
 =?utf-8?B?SW8zbXZqcUY1NkpyZ3VSY1NiZEVDYlZZZzZCMlpMSDVDMW0wNmtSendkRWtG?=
 =?utf-8?B?djVlTi9hRTYxM240V01aM0F5Uzk3c0w2eXJueEhTT2pLZUVYMGRDZGFlRWhx?=
 =?utf-8?B?cTNQampIYUh5TFVVRlpKOHdVcVRyV3pqcEd0ZzN2a1d5SXlsbWR1OUgzcTgz?=
 =?utf-8?B?Z0VXTlM4SE1FV3dNcjdHVXBUaHkzeGtFbC9JWGVVVnBpOUY4dXdSa2RxMDdM?=
 =?utf-8?B?WTJwSTVvS2p2aVpJZzl2elVmRlhwQ2ppamE1NzhmczJBKzFJbjRXdVZ6VGoz?=
 =?utf-8?B?Wmh4VXJsMzE2T2JCTmJHb3F1eFNSbk9zMnUyQnNweHJQMVhuNExVOXNDRms0?=
 =?utf-8?B?Mnd1K3RRREtTcWl2dXFuSTVUdlFMMDJWenJJL2ZiT2svVGtZNE1BbkpodTND?=
 =?utf-8?B?Mm9qTk9zcHlnSXRZWm9IektFLzFvVWU3bk1GbmlObmJIdlhEYXhnSWpiZ25R?=
 =?utf-8?B?eWRYL1BZZ2hSK1NjMWZ0djhpRUtEUnJOWEszR25CdFFSOWJwR1oxcjVtYjJm?=
 =?utf-8?B?YnhzRzN5VVI0aVpaS2hpR3lYd1hhQVdBNk12b0R6d1llNmhFTThXUEhPZ3p6?=
 =?utf-8?B?aFFoYzJmdzdrNmlvbWlrTTZzTFBoK2JoWVRjWjZOU29NcnAySXcycFVoSWVU?=
 =?utf-8?B?SGMvbHdRUGh0QWtzVk51d1FZUkVEdTl2MzRtQWQ4cWFpZmZ0Mmc5NzhGY0xV?=
 =?utf-8?B?OFlYamFaZkFUWk8rV1ZNSThPQmFiNDhEUjBKRHRmU2ZlUm5UWGlWUDhlWFFN?=
 =?utf-8?B?WmFCZHpiWGNXc2lRSlUzdzlqNHpxK3hjOCtVaE1YOHVTMVhIYmRBWlJJanY1?=
 =?utf-8?Q?OfEjZouSHdvG+A0w=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4240a6-757b-4430-2a37-08ded04adacb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:41:45.4473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cWmSUAU2i/g45baRUGKpTwuUmG2vVKI/xr78Zv9vgnB1NtW/L/DtEvpe9ZhzDz2mJtGjLHhL0y+Nntq79zybL1led313eRmhnmpfKH+KiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5455
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

Hi Heiko,

Thanks for the review.

On 29/4/2026 2:10 pm, Heiko Schocher wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> Hello Dinesh,
> 
> On 29.04.26 07:11, dinesh.maniyam@altera.com wrote:
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>
>> l4_sp_clk is disabled when i2c device is removed, this would
>> causing unexpected failing behavior for other peripherals which
>> are still running with l4_sp_clk. The patch removes the codes
>> implementation for disabling the lp_spl_clk.
>>
>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> ---
>>   drivers/i2c/designware_i2c.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
>> index 8ad716f410e..40153c72545 100644
>> --- a/drivers/i2c/designware_i2c.c
>> +++ b/drivers/i2c/designware_i2c.c
>> @@ -807,10 +807,6 @@ int designware_i2c_remove(struct udevice *dev)
>>   {
>>       struct dw_i2c *priv = dev_get_priv(dev);
>>
>> -#if CONFIG_IS_ENABLED(CLK)
>> -     clk_disable(&priv->clk);
>> -#endif
> 
> Hmm... clock framework should have a counter how many times clock
> is enabled... with your patch, clock never gets disabled...
> 
> bye,
> Heiko


You're right -- this patch is at the wrong layer. designware_i2c is a
generic driver and disabling clk_disable() globally affects every
SoCFPGA / x86 / RISC-V user of it. The asymmetry vs. clk_enable() in
designware_i2c_of_to_plat() is also a refcount leak by construction.

I'll send v2 for this patch series with the fix.

Regards,
Dinesh
>> -
>>       return reset_release_bulk(&priv->resets);
>>   }
>>
>>
> 
> --
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Geschäftsführer : Stefano Babic

