Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD32FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4863F84653;
	Mon,  4 May 2026 14:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YChS5hZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 784F88466E; Mon,  4 May 2026 14:40:05 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 019F88460C
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vxrke+sg+aUKeS+aaaSWX4AZtxTwxdOM/0bL5wU5T2RLlcmpYOsGiR6gU1wBGLRd4nIIR1ND9qpA0bwh4/mOEH/CnOjwuq69JFjJQJX7qol03DlFAByfFl5OnIdA4squF7L6Fqi/YzMVSBWc8FLx84DvIIKOoKP9pHB20/aPguQko6O84wnoLuqvv6vz4/JqImCz9+XIFocD+iYn7wiDXZKMSnQNWmAcfv+iCXRin8b6BGA6jG1V6z12A/xUWAPQ0+whspJ6iIwSjPb2h2dmgc/oXWaQjp/Pk0TcK/Q7T9TerNMkr4Y+caPk/78VIEcKWqtSNKt+CzWslSaDPeuc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cGGONiS7E3DyTnj+80SM0zC2uixfnMki858zhXMLkU=;
 b=xWMe74AH27ikhtCSAoNpsFpMhc5E954U1gyXao6GkV3ACsKq2bAg302veMF3Xz9Y9/sllPZX5AmJiyBmU9Zf3CTnX6NBs+jl1jGSnRKBbJiGr4iRTgiSAHHuFf6XzarfQlfJtd9xnVX+JcSJuhZ9+lOLNH5+h1Dag5SQzvkosJN0+BywS+AuHSUNCxULhzjOx8+oo3JitdXPdhY3HVdPyBn6hyY9q76vvh+SscVqnoHj7GrYjYw6ubxsLsK9kgCdhWPI4aiqqfpZPSfJ4ChAKqVFSSp/Vaa+XUMjezVROm3Lkw1+eDvxvwO/EX2+Y7CJHLIZXSeAmT5pnoFRz4JV6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cGGONiS7E3DyTnj+80SM0zC2uixfnMki858zhXMLkU=;
 b=YChS5hZMVo8EexK3+3iqht0HPgeYO8nkM/7CDtTLVDj85AoOXgFGEMLhkhcBdUj5gQCxgb18BRBGvUlpGWBHMesxzDeEI2+uOtY+OUbw7qwv4wL/sado7vsUTYVx38xxMzoG19fcqMz/oKNwCK+yNyJvz9TW7XP3vKakwe2Glu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Mon, 4 May
 2026 12:39:53 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 12:39:52 +0000
Message-ID: <ef788298-5bcd-4345-834a-3940fa4c8993@amd.com>
Date: Mon, 4 May 2026 14:39:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] spi: cadence: Use reset_reset_bulk() for proper reset
 cycling
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@amd.com
References: <cover.1777551598.git.michal.simek@amd.com>
 <0880332fd0d61e2f4d497da8dd7fd10c9d65dd9a.1777551598.git.michal.simek@amd.com>
 <CAFLszTiA6Xv_i2AOnsei-tosq7D_aSD_D=mBicFCV=vLRqS4jw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAFLszTiA6Xv_i2AOnsei-tosq7D_aSD_D=mBicFCV=vLRqS4jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0189.namprd05.prod.outlook.com
 (2603:10b6:a03:330::14) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SN7PR12MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: aa573e30-ed23-48f6-8a19-08dea9da3d19
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: KYf/ov6jVXsKIQfHT6z4lZHHdO2brO3XLvPYRDygQA05D8sOGzpZdDytXK1nJbBpn5GtPhU2qvyM26Opq16Somr6zLNqGKrfH+KYVYCaU2KUT9LLT4mpya96/WOorlp6KhYjtYOXSz5FpM8JEM3aygidbblHqhYjCMiKeK2ZySB49Kr3iWuUI812VmIU5OCAYEbEgAMyd8+Xy2XHjHLf12AEpOw7XJxf22XqhnWr4btU/fxLADHQVPMJfmW3rhhJWpkJnylPpq30KNmcilFQ7WCSEAt3F2hc5j/eb9di3zCtCCTL9JKT1iyiHYvlgoRLFN7wWk7RfDn4hEBUhzhW569IRElY6KYmYK0lQlW41JUeMvMZ4oZCpbnjBr98NkCznAe4fStI6hFuPCrrjS0Vk0hbZEnEN1YHgxz3wkeczpJCwupPtI8qBcTwRFaCzgH9fgW1a2tcT6ZzIJW2rnRed595kz9gbSiSFYygue7LOhSLaVFXkZjiNIqszD9rARfEbsux3IhdHwVg9Rr/buA6bnjJyD+cFMWS18/vk77CgqFwOhMUQE9iSqepmzoA6+xY6qPWv3y8kxnxwhQMV6BFf3hSzuUBNe4XYuay/mLq4hIr4KdJDGoqrM6AJIubkHSof4QsdIH0V1kVLFXzEoVZG0QTs61sle1vKPhW4ZIQfGkgrvUoBz/biuiHk94tnerk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVJRZ1pld2I3ZVRSOU9WQVRHRE5aQlZVcGtwYlBEeENRZFVTS3A4WEpGU2V0?=
 =?utf-8?B?Q29pKzBwUE4zSm13eExiKzVMZG5Wc082SmErZ3RaN1dnbW9VQUJBMEw0anlv?=
 =?utf-8?B?b0RYM0dNenVVRHAyLzlDb0VWazdWT2lDaVJjZW04dUlnRXYwUDFiL2Q4QkNq?=
 =?utf-8?B?WmtsMVNtaVh0VmJIM3plellacERmN0VRZG12bS9LOGx6WEkvakRUaU5FblNo?=
 =?utf-8?B?OWpYZTdQYmpOYzZleFBUWm5iUklqR0QyM0RwVEVYYjNkelU3cURkclVPaCtI?=
 =?utf-8?B?YkEvL0M4VFgrUlJtaThqYWlRejZVMzBkcUNQYUZya2lTVEV2NVdBZ0F5UGZu?=
 =?utf-8?B?cDcycFBTbmVUbExrRE1DblVPYWVEWGFSQWowMlJoU25WYmg2UStzNk0vd2lO?=
 =?utf-8?B?cUFPQ1VRTGNsMDhXWEtVUlQ0bktlRGtEdEZHR0w1aDlRQlBHV004ZmJybG5Q?=
 =?utf-8?B?Q2ZwYUllOHcxOHRaa0MzTVpiN0JNQkZjcTVLdW8wbjErYkN3WTRWL2JxY0pj?=
 =?utf-8?B?K2R1Z3Mwem5pOHJpdHZyYjMwT1h1Tk5jMEZDZnlCcGt1MGh5Q2FhL3NhZ1ZD?=
 =?utf-8?B?YzJ3djZJaWhnYkpod05OZ2h0TFhLeDh3aDAvZ1ZxNzI1Y1BUWG96OXZnd3lI?=
 =?utf-8?B?S2ZMbW1Bb21WWW5Ya2I2TWcvZmZ4Z2FVWEMvR20zd0NyeEN2aWszUzErSkNx?=
 =?utf-8?B?OWhlWjZHNkx5NWIyYnI1dUU4NnFqWEY1b0V2NVFaNVVnQkI5STEvT0Z3VkVW?=
 =?utf-8?B?TUpNY0NybisvdTBFRWdhMEVaeURoRWNPVkVJVm80b3daOEMyN2pYMmQ2QWpH?=
 =?utf-8?B?YXdDOFdRd1o2bUtyMEx2d1NwOVhPdWEwbmlId2dlb1FyVWJDU3RubWlxNXNP?=
 =?utf-8?B?ZW83OGE4dEdBM1k5NVhMV01wTlp3NG1pV3NOakt0eXRPaUNCZW1HNklMZGdM?=
 =?utf-8?B?d3k3RWo1ZkdYS2t2THJHQ3hySWJQU05yOFpabEhZbGNaS1U4elZVaWY4cnpZ?=
 =?utf-8?B?ZjhmOG5zSCtGODVyS1Fnd0ZzcmJwTU1yWDJMcDY0MjlvbE5Va2FUOXVnTVVu?=
 =?utf-8?B?TG8vaVAyWS8weHVCbmpLRTdyUGp5V0tHbXpTdk9zSnYzaU82OXY2Mzh1R21L?=
 =?utf-8?B?aXhIVms1UTg3R1UwMTlYTjJkVUhOZno4dVlES0ZsMG5FUzhoZFFHWUtjd2xU?=
 =?utf-8?B?aGlwNXdEbnV6aGZIaW56UkFHT05DbmxVMTZLSjRTVS9HYldvRUVqUEFRR1R6?=
 =?utf-8?B?VDltOGFzL2hrR0tGYVdHdHN2TzVpRjI3Z1hpbkJIeUQ1M0tBNEdab2NNWkox?=
 =?utf-8?B?Q1ZFSlhrTFRyQ1JUb3hUMFNBTXJld0FZQXFWa1FRT3k1QXdxS1NiNkJiTHpz?=
 =?utf-8?B?cHJDdmJwUERGOTR1R1gxOHdlZnV6NWc3Sk1weGlzdStZQkluVW15V21mc3dV?=
 =?utf-8?B?OVJjeEtNY3piMTRlWVJPUlNmQ1ZhYXQyZ2I4bHRQdlNRcDMySEFENzhFMDFy?=
 =?utf-8?B?Y0IrdHRESS93YTJRa05OaFdrTGhGU09xOUlMNVRVRjhMNkZQMlhIcEV3TE1I?=
 =?utf-8?B?dC9MUTFFZXB0Lzl1VWh4T0VjT01HYXRoa1kvYkpWMVB4OWk1OEFkckdrWEF4?=
 =?utf-8?B?RWxORW9EVDVXOHdxaHJrcEQ3dWJaem51bGxYNXhwazdvclp0OG5zQUFxUU95?=
 =?utf-8?B?SDM0K2pXN2xjS0N0dnlLYVB3N1VXbm9FZVZ4bERtd1hUM3V3aHRIdVh4MDB0?=
 =?utf-8?B?ZExYM2ZiMmVlWWJyNEpvc2NnS2thekFTN1UvRll3VDlNRDBPcmxPM3RhelNC?=
 =?utf-8?B?WlhOOFRIT2NCbnErVjJsZHBsTmlaWW4yYkxPdHNSR3BPSVZKRXJDNGMraUVj?=
 =?utf-8?B?MWgvbzVJR0pxWmdFUXNZRi9VazZWcGpiL2p2V21MOUJySjhGNnAzV1dvREZQ?=
 =?utf-8?B?UnpTbVlkb0p3c2VxVXBzUlUxZzd3aFdMaWU4RE1PSHVXc05LRmI0OHJMNXR0?=
 =?utf-8?B?OTVSMERtcDlSckxkS3BvY1czMkdHaWdNcFZxQ2xKWWJPUGloN2pUYXRhT0xv?=
 =?utf-8?B?dG1XNzdHcXRhUUdYVGxzM2pZNWVhZkpxV1R2RWIxZllMdlg5S0drRHZlbTc4?=
 =?utf-8?B?cmFESXRQZmlMMWRlMVFvMUFYb1EyQVU5T3NRRzdUa0t5cEE5VTJ0OHNCNWlW?=
 =?utf-8?B?ZTVqOGJtdVVFQ3hsZVNMakRCWFNkV0EwR2QrRjd5eFFoeXpRZkk0QUVjR1VK?=
 =?utf-8?B?U2lLVkxvSW5ieDZVbmhIS2dodDF3SEVCT3d3eXI1T3A3THFNN01oMVYzYjE1?=
 =?utf-8?B?dTBLWXVSRGZqR3E2WlVwbWFMaUNNODkzM1Yxb0Y3ZHYvOERBNDZ4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa573e30-ed23-48f6-8a19-08dea9da3d19
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 12:39:52.6982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uvWrNJc9CB+e2ulriefVoh8aOmhrLuRlT3JbiVAxHX92Gi/c0YmRx0I4x8YiJkd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057
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



On 5/4/26 14:18, Simon Glass wrote:
> Hi Michal,
> 
> On 2026-04-30T12:20:00, Michal Simek <michal.simek@amd.com> wrote:
>> spi: cadence: Use reset_reset_bulk() for proper reset cycling
>>
>> Use the new reset_reset_bulk() API to properly cycle reset signals
>> during probe instead of just deasserting them. This ensures the
>> controller is properly reset before initialization.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>
>> drivers/spi/cadence_qspi.c | 19 ++-----------------
>>   1 file changed, 2 insertions(+), 17 deletions(-)
> 
>> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
>> @@ -255,23 +255,8 @@ static int cadence_spi_probe(struct udevice *bus)
>> -             udelay(10);
>> -
>> -             /* Deassert all OSPI reset lines */
>> -             ret = reset_deassert_bulk(priv->resets);
>> -             if (ret) {
>> -                     dev_err(bus, "Failed to deassert OSPI reset: %d\n", ret);
>> -                     return ret;
>> -             }
>> -     }
>> +     if (priv->resets)
>> +             reset_reset_bulk(priv->resets);
> 
> This silently drops the 10us delay that commit 834d589b8f1 ('spi:
> cadence_qspi: pulse controller reset at probe') deliberately added
> between assert and deassert. Is that intended?
> 
>> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
>> @@ -255,23 +255,8 @@ static int cadence_spi_probe(struct udevice *bus)
>> +     if (priv->resets)
>> +             reset_reset_bulk(priv->resets);
> 
> The return value is now discarded - is that intended?

Not really. It should be also checked.

M
