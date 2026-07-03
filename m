Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC964C44500
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 12:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E50984A35;
	Fri,  3 Jul 2026 14:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="k4fVuNih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77FF484A3A; Fri,  3 Jul 2026 14:46:22 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5065B849F6
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 14:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkPP3VAmSwT2HvnnEpe2ufY5i2TVwkHph7cZJ6aYXKUmLwGc3hSRLDxSf37NNRkHbXY9+h1d69ElfBfhIXU+W7zhWE7L7kYp6rJGX7pn0wOKAzTTfRWbHJdM6/8769ZhKBrtKtvA8PgtJ+HDwSlYpM7jLZX+XjDecrNMOMTTzghzfk+0wLhNJ54mpKgMcRWl7QXxNp9/Th57ytGD+5ZZGqZkJxdqixKOV1SJWucExEHMY4h/dXS4VoOS/HhzKjeS0TB2jmXkpICGhKRg6kT0l4LmgELeSh39Z0gyTbjU+F42sAu6+lKjjjBV2sjvwvJ8JRbjPGLKygdiTtxMnHNAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AWeIoTpCNL8dEnD28JjLzK5eqamvUS059TDACb33bM=;
 b=WVK3MYSx4tf/zUelu/H/BwOsHYqzK7pvU4E34lqfcbUBuXXs1ITbMo1HyZ7rfAcPZNWnP3tjw6QH6uoSJ3nWYZJjkP2nEY4eR/AHshNcRYSD/lEw0lhbHHhl0/6yiSjmcWJ2cwEiJx+XHuq8zdLa0moNGAeBw7+Re4K9BuoCDqYDj4/LxX5A8NsqiTaGQTEI9jG/tChI0/vW+a3AM5d9ArNsgSTSOSJi5vx4hHmQ+ATfJ40OOqHNwXZVJOVN2G529U3OOd3Xb/pP5n8udYWmK3Y0U8QJgUWrpm2bggF5oCNFLE1ud23GXIXIfKPY1Qwt1Yu+vnLjZGhvMmmhSDusKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=nabladev.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AWeIoTpCNL8dEnD28JjLzK5eqamvUS059TDACb33bM=;
 b=k4fVuNihrjgCc5Q54nQkwGAzB5FE1NaA40MYdVIB+FQO87QZiu/ChLNW6Oj7TETyHCmMQTUrTQtEj6Q0nAMBGLUjgFRq5iXv7mvaxw7+WGveItqphh4KE3Cvsy39jtzZqLfeP/BuoWLgXnEya2XbTrIOe7zZb/uBKOEMEKY1vcQivjujezOrQkZ7DQFgWTyOY/t3GRauGIPBLUy+z0A0p49+RZh2ZCAqGjiU78HR+JtWBpFtflEgIBH7sGjp1Ld6kpKCCCRXyZHK0Yw2Srt+ZadnrUKRN82OgpS3cSBRIvu1otZ2l2FYq7mqX5q1l1ieMPRRd3JQLiBCRzHKTOS9OA==
Received: from DU6P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::16)
 by DB8PR10MB3814.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 12:46:18 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::5b) by DU6P191CA0015.outlook.office365.com
 (2603:10a6:10:540::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 12:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 12:46:17 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 3 Jul
 2026 14:50:35 +0200
Received: from [10.252.26.28] (10.252.26.28) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 3 Jul
 2026 14:46:16 +0200
Message-ID: <9a7a6227-228b-4528-96df-4d80946230ec@foss.st.com>
Date: Fri, 3 Jul 2026 14:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp1: use debug() for image entry point message
To: Marek Vasut <marex@nabladev.com>, Sean Nyekjaer <sean@geanix.com>, "Tom
 Rini" <trini@konsulko.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
References: <20260618092921.3702970-1-sean@geanix.com>
 <4e7b14fd-da00-42d5-9221-719313eecfab@foss.st.com>
 <bf804b49-55fd-4bfc-9898-2265dfad95d7@nabladev.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <bf804b49-55fd-4bfc-9898-2265dfad95d7@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.26.28]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|DB8PR10MB3814:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a52243-8437-46d1-4b31-08ded90113ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|4143699003|22082099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: V0giFxQhI6N6MAcsW1BYuchvQxdY41cJVjGV8fOf1qwqtF7vTevwrBk5V+rclYk5/qfIn7+AZG8qwGQbRDxF0Qd8bN1Ceu/sb3/17zD3TNLspHiyZ9VfRtvchOdGv/cBZ8H0z+aBIlR574Kdz9+2hUWOSMynXHyleUFrS6Z7N9udQfh5bSqTUBkVLkF7HeXnJBsMeEIkbmZPdcBTFDiYr0npOJFUO+/9QwQvvo4AVGTvOtKdSWlgxpY95OVYOSYQ2MVlM7kieYUgd6bav0wUCOaYmi8JSR+73b+FRG2Kk+NgmKYvcSJA/o1H0f7euj/mfWl8/Br5Nki5++rdC0FLjZYk1e3IktmDW/T5CSE7vyceyJItYa4Cmiqr+2rvMoYAEIVW/s/gVVUtvHy5so1475elg2Ie/xkcu/z6zpndyNSR1ilishUQoGqxuZZDRxPubFoAcu0g6m9lgYukRK8XjXi9b+91dH69HQR5q2Sqq6znOybo4RytGqj6rqsL/MinFKO0aPPXPekicZg0D0OEYtuwpNKAGNqrt2KBA5B+zs/Ys/OCjVcp2WF1Ap1dHhmArWX291GAsbf32xUvhe2p9u8yGplbTCBShH91qaMfSLA9dzW7B/QZG3EHxk1edcW0nbnoq8Cb3DqkADESz5NJ0wKkDGlVetWNhnt0ErsnuZHN0zYFgYf+yUNk2JJZTqRZdFIzfSo/ed7WOSJMCAOvsA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(4143699003)(22082099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +X6Pq0NJcr1HKmgSFkGnrUdYrkmuKh9NVEC3kdifCHKty844iLOV9G40xNA40m7bSRJ5gAuwkhhaRgh1b4l578aWDvX/YZNlRJI8710h+4ANqPNnu9lbseqDYhrnQcc8ukMFFkQ6Nqcg/l9oBuiwIqkCTxvils7UjB0XdU6nQjfwadIE4CYJ2dEOE/KjUP8uLtS86aj/inLNQOmScYcg28UQryO4nUWdIusx1T26hLfFuMcOaevbZ7QfdzzgehdnBFvvW1rzn4/a+00M9PWIija+WBhUAhzVmEvukLhbflAcGivRSx7gzT7mycj1VFdNF84JocGidh2sHgNcd0oJ6vNGUC4uKzhFa35byG0wsmvAjkYuuCheoe1gBAtSr6UrO2Pe8EU1ulhb9ipFB/MX1MqmwtN45YzN+eDBfZYJOtdwdvglVCbUTL2vXULDfTxT
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:46:17.9549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a52243-8437-46d1-4b31-08ded90113ad
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3814
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



On 6/25/26 14:33, Marek Vasut wrote:
> On 6/25/26 8:31 AM, Patrice CHOTARD wrote:
>>
>>
>> On 6/18/26 11:29, Sean Nyekjaer wrote:
>>> The stm32mp1 specific code prints the image entry point unconditionally
>>> before jumping to the next-stage image, unlike the generic SPL
>>> implementation in common/spl/spl.c.
>>>
>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>> ---
>>>   arch/arm/mach-stm32mp/stm32mp1/cpu.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>>> index 252aef1852e..ea5d8a648df 100644
>>> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>>> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>>> @@ -361,7 +361,7 @@ void __noreturn jump_to_image(struct spl_image_info *spl_image)
>>>       image_entry_stm32_t image_entry =
>>>           (image_entry_stm32_t)spl_image->entry_point;
>>>   -    printf("image entry point: 0x%lx\n", spl_image->entry_point);
>>> +    debug("image entry point: 0x%lx\n", spl_image->entry_point);
>>>       image_entry(romapi);
>>>   }
>>>   #endif
>>
>> + Marek, as he is the author of the path which brang jump_to_image()
>>
>> Personally i don't mind of usage either printk() or debug().
>> Marek, what do you prefer ?
> debug() is fine, thanks !

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
