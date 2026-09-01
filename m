Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E27C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 11:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04B9C80BAE;
	Tue,  1 Sep 2026 11:49:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hEowsrpEZu9w; Tue,  1 Sep 2026 11:49:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788263382;
	bh=XDfOLaHaUZ0G28gOtoKhv/z5t29bacnEZEZA/hDT9kE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O1OKdoEUzdMe9OoxFG9VW+1LW7Rbb4+d16IcPY7yDIKAr1ESoG2NcX7/hLEsgZKGv
	 D0zumXJHMDeqcom3O0aBo5tQ2IH/yo7x5QDD6VyjEC9XEV1x0RMSk3nThcFnIpCuht
	 ci5zoBOUGJ3lF+nfLW8pISbHjWpSU9GDsYWeo0awjf28Dyh3XAtu0o6YTsGb7a9cYx
	 2da14V3FRwTcjWIL709LiAglAnuHPHrpCBPM3oo6MsqGASEx2va4TenZHfrSMq0baA
	 krYB6hJ+zTQs/0LP5ZlsRtTjNj1rfa1aMfBmj4wyXn4xhZaEhHvv/keH9iA4deOdY+
	 Ws58NQWm7s01w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C76E80B5C;
	Tue,  1 Sep 2026 11:49:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B887377
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 11:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8181480B5C
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 11:49:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZtDvWxoo8iMv for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 11:49:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=Br/sfHqf
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE1D280B2E
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 11:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1azrwv/0EZckNjnUt6xagJ6zFD04+Qkf5UgK5cBE8ljXIBUTa9/8z6Zpu0yQK/fsFWYdqLc4EGVFo7D7RiXVsFdzy38u5NKiwExy/+FC1XFZ1yYOp6T9rfNsAEUB6OVeM8osS2T9MYyMf/o2WLSHHx6606rhRnMoB2UupCmrTiOKLwx6axYWrisnQUL/LfVvPfb2F+YOL6wctzLWr40Ebz5vhOwHM3+rtadPDZ2y6RHrM0KpYOOoVocZQumORmsuXV0JtaEzVHBruMiu2DOiCXQaHVR0pTE4glZwkolaaQFTMbVTEHYm/u6DrJ54CDgFnUaWOHdFb1SeziCjuhcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDfOLaHaUZ0G28gOtoKhv/z5t29bacnEZEZA/hDT9kE=;
 b=CVdj/otW51ZXTRrWAimyqw/r4yxNh3y/peqQtQw9dWm9SP+UZXwXsS5oQJUHd9x5vjwkbBnWBtOvZy0towyYgcEGU6XQp1Xq4z9J66KwwNMU3lSQFm6QcmRGosEiDAFhxWulxzgk7dWAb+aOgHLuUNyrzZFt4V4ysgkTz2M8dyqq1zgemmcIOARmw+V3eEJIZMwZn+vWV2xJ1Ywpna267lSlTPTZfSar/CSwVFAFfrZoGxQipsrZMMVdFZls6wzwEIDLUKFpgH59vlKzD2bLHq0MR6nKNwb/kOaArjGk+s+pOw7JrYtjAmeL/qF1aGso1u8SrhYV43DbnugMNkW+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.87) smtp.rcpttodomain=geanix.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDfOLaHaUZ0G28gOtoKhv/z5t29bacnEZEZA/hDT9kE=;
 b=Br/sfHqfZBwqIvR2cWuC2O4wT9CykibbNjkqVVr7LdMfjDlMY4Q+R8BK5zdf8cof/v+GWSCsqSLj1ukOUnY7QdCAmT+8T1cBZsW15hL/LpRCxllcVqKHaFHqbM5bj2z1qEjfhMUgx4Lf/DuL8wGQVmVsyJKJdcBWBK3HlTpVpI80f/k1muuKNkhABdtFNS1/7Fs/rSzNrWorkYCa96B6Gp+1ZVorUQtIXotAY3lUnOD8vCWqP9A65M7Odh5se555ur/knSL+KIWV5zB0BmQiV/Xz3qZoOR/9rtHp682MBp8GRFBEMRiueRoKP2dlRWzqWTj3hJiq8K9xlmUEMpA2/A==
Received: from DU2PR04CA0239.eurprd04.prod.outlook.com (2603:10a6:10:2b1::34)
 by PA3PR10MB9311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Tue, 1 Sep
 2026 11:49:34 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::4f) by DU2PR04CA0239.outlook.office365.com
 (2603:10a6:10:2b1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 11:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.87)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.87; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.87) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 1 Sep 2026 11:49:34 +0000
Received: from ENXDAG1NODE3.st.com (10.75.129.196) by smtpo365.st.com
 (10.250.44.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 1 Sep
 2026 13:51:31 +0200
Received: from [10.48.87.93] (10.48.87.93) by ENXDAG1NODE3.st.com
 (10.75.129.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 1 Sep
 2026 13:49:33 +0200
Message-ID: <39a8f709-412b-4788-bea2-0e4cadcf8a71@foss.st.com>
Date: Tue, 1 Sep 2026 13:49:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp1: spl: support loading U-Boot proper from eMMC
 hardware partitions
To: Sean Nyekjaer <sean@geanix.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>, "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20260618092855.3702905-1-sean@geanix.com>
 <a0c2d561-a2e3-4c66-a9a1-e810009f262b@foss.st.com>
 <04e0480a-2e4f-479a-801e-54699d854875@foss.st.com>
 <AVOkeKKkQAoWpdG0kyASXbfyu96CsaHLok9_DQCEG5xW6hVGSaAk3tb6g4UZXdDa_uByOjgb2qA8Wq6cIy63baubWNMpGb8i_pZahNST4jw=@geanix.com>
 <93ceb2ea-7e83-4b8d-8af2-5afae304da5d@foss.st.com>
 <Jzny_6oiskgk1COrRgIO9-7yU03pscZqE31eAaI6jzIgCELNkJrJSz40g48d4s1jIIP8wrk0dxa1l5qdO-xVXTGA5Mxcsch485FzWkid3TY=@geanix.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <Jzny_6oiskgk1COrRgIO9-7yU03pscZqE31eAaI6jzIgCELNkJrJSz40g48d4s1jIIP8wrk0dxa1l5qdO-xVXTGA5Mxcsch485FzWkid3TY=@geanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To ENXDAG1NODE3.st.com
 (10.75.129.196)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|PA3PR10MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c8647e-f84f-41dc-bd47-08df081f17a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|6133799003|22082099003|11063799006|56012099006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: ueeS1S3gSmD1J7EKEFqmbxUtfpaRyUmJQw/Y14hlA70lE0a6M6k1Ow5UH0HF7llteddSD9M7o+4kWzAQoqxU+my5FLK0+AH9tSyu2ybCHdJtKiaw2P84t3IFPsMPEqw0Uy8yo2QI+WbXHam5/X0DBSDU0/xrmjMfcLqXHZaqUH4IQN7CPJRJJNToNPb8H3IawBa5AVG4QJKz42YtQzPm1mNSWNAQTfV7nas5fxvPko78XVjNMSUXs+VV4vWuZay72cuPprn/BoSnRTMo5+ZfgI0wrGTjVcScuyXdVFOsPG3o1pzPunQs2IzwmZSo3aFBMU0Vqh2jZL9+W4lW+pf/OYRFOj9iuwTBX8KuJKY8dPkEyBxxk1ACa9H58FC6LU8gjhiiwQl3QJOIZEMa0ER8Ie1VQIXLRcib4ZRET7aBHSCwJ6MIKeOqW2ViPO0Ws1wLcU89vwqbbMcO1idR20m5X/tKb0Ml+GBPYWaFvjpNVaEH0WmusVMFJxTwF+g6mfEbAd3azp0ISdCS8gd/gRfcPNjMCRj8lE3/eyEOZLFPWZwZqpt0m85y4EAAzXvxx1fUmlHJI/G+UIYkuiz90bgyF80vUNNuT2Lil+PGAc7a59pfEfIuWW2DT53qhZ+EIWCwYAFpqFWlQFtMctb7gh4JgHrL6TAjQJNFhnS8mUtKnu9/jH+ibXydwDY/1FyW/gPtSYMAXhPY+rYuE9lbVOpOVw==
X-Forefront-Antispam-Report: CIP:164.130.1.87; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(6133799003)(22082099003)(11063799006)(56012099006)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5P5hgoYNtQFJ+9ZUaGUPsIdbnxMYDju+yueN2AiwdLrG0dA6p7YMddrEsGJyUfVrVV2tojmdJT/7ROqC9D3YDo+GOKZ7mIp9wKNJhLU2c5+ciAuUIp4/9Y5oMGRUFm2OgOMb6teZyLZALmUDX0lBa4q2nk0VQc5Y5PxKbO1L8y8Bl7MR7U/PVd0jZsYDvv/CWIJSkzRkfkiB+RDpIhzYjzoKanjdkifcUzmY7II2xlmAH0WdOMXHmzcbJWCQnCTnY2XMeNcGf6MA9L9aSEtxHtgKXk8PTk+LfktwBZxs9YgBP8iyOLIcWWE5xg/tlbqaU9PKeIuqGmtun9kRK7McOSrpq/reatC+pTwtzTtBwCNZHcTjz1mA/tZ4NjdZ3JYjYjnB8IpCG7khn7BPaoUcad5Znh6nmjRP3w6panVMm2YFKejPTTj25C7T8/tV7906
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:49:34.2400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c8647e-f84f-41dc-bd47-08df081f17a4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.87];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9311
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/5/26 07:50, Sean Nyekjaer wrote:
> Oh, I accidentality dropped the CC to the list :/
> 
> 
> 
> On Tuesday, 4 August 2026 at 15:28, Patrice CHOTARD <patrice.chotard@foss.st.com> wrote:
> 
>>
>>
>> On 7/15/26 12:57, Sean Nyekjaer wrote:
>>> Hi Patrice,
>>>
>>>
>>>
>>> On Monday, 29 June 2026 at 08:50, Patrice CHOTARD <patrice.chotard@foss.st.com> wrote:
>>>
>>>>
>>>>
>>>> On 6/25/26 08:14, Patrice CHOTARD wrote:
>>>>>
>>>>>
>>>>> On 6/18/26 11:28, Sean Nyekjaer wrote:
>>>>>> When CONFIG_SUPPORT_EMMC_BOOT is enabled, make spl_mmc_boot_mode()
>>>>>> return MMCSD_MODE_EMMCBOOT instead of MMCSD_MODE_RAW.
>>>>>>
>>>>>> This allows the SPL MMC loader to honor the standard configuration
>>>>>> options CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION and
>>>>>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR when locating U-Boot proper,
>>>>>> whether it is stored in a GPT partition or in an eMMC hardware boot
>>>>>> partition.
>>>>>>
>>>>>> As a result, both U-Boot SPL and U-Boot proper can be placed in the
>>>>>> eMMC hardware boot partitions.
>>>>>>
>>>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>>>>> ---
>>>>>>  arch/arm/mach-stm32mp/stm32mp1/spl.c | 5 -----
>>>>>>  1 file changed, 5 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
>>>>>> index d2e41b8e65f..d2af705a5d1 100644
>>>>>> --- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
>>>>>> +++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
>>>>>> @@ -56,11 +56,6 @@ u32 spl_boot_device(void)
>>>>>>  	return BOOT_DEVICE_MMC1;
>>>>>>  }
>>>>>>
>>>>>> -u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>>>>>> -{
>>>>>> -	return MMCSD_MODE_RAW;
>>>>>> -}
>>>>>> -
>>>>>>  #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>>>>>>  int spl_mmc_boot_partition(const u32 boot_device)
>>>>>>  {
>>>>>
>>>>> Hi Sean
>>>>>
>>>>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>
>>>>> Thanks
>>>>> Patrice
>>>>
>>>> Hi Sean
>>>>
>>>> After a discussion with Patrick, it should be safer to keep spl_mmc_boot_mode()
>>>> implemented as following:
>>>>
>>>> u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>>>> {
>>>> 	return IS_SD(mmc) ? MMCSD_MODE_RAW : MMCSD_MODE_EMMCBOOT;
>>>> }
>>>
>>
>> Hi Sean
>>
>>> So like the arch/arm/mach-mvebu/spl.c ?
>>
>> Yes
>>
>>> But it's still a compile time option to choose where the U-boot proper is located.
>>> When just removing the ST special here, we also gain support for loading U-boot proper from a filesystem.
>>
>> In our defconfig, we always got MMCSD_MODE_EMMCBOOT enabled, but we support boot from eMMC or SD-card.
>> It allows to distinguish the boot device at runtime.
>>
> 
> You will still need to have:
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
> or
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
> 
> So still a compile time option.
> 
> /Sean
Applied to u-boot-stm32/next

Thanks
Patrice
