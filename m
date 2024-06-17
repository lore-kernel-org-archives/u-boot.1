Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FBFC2BA18
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B446882CE;
	Mon, 17 Jun 2024 15:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fnjdsEfe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03649882D6; Mon, 17 Jun 2024 15:27:24 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 394A48829B
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YByAv+aE1ZiIBszf1PCZPHCrg6zwDdUHOLV3RDEFLn+LNqrl1NfEhHSr73doNaMnhfKHwoGiJU9ousiL4BHl0vvNvkppnxSSy2uGPIabAkz1d55oUegoESEO8u5VZ4IQuYf5Au3D1Qfnwjvr/062RkpntM2ExylLGLs+aMuBtUlnw3oTmkwN8/MdhhbJN+8eChFTUpVPuLcR/zIA1uI8UsTnt2lTsimNq0sDPXJGpktoA+9aBRKahTWHMUEByMl4JoWe470/zD8OGUta8luBVOi0FMJfm26ASQ1Ubtl5ORWFD+az2C1k2Xor4ZLw55Hs/8VcEqeDq4n8sEctkiu/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEImdL6MeLbHgEF3GiI8ntDWEXgJ9kzjYa5vdIrQ6XA=;
 b=OCBq6yBiuzZgADgTDKN4emiuTyUJBW3fOnPaaoeNzR9154a3VfqFEdNgM8uWx/RbBmuGCBzCFE6z9ANp6Pl5R/c3Dq7bvPcgbF1I8izmkUoj5XB6slhVhgv7ydxxmHnw7Ri/PmBUamJFxQZ44qqbBWfrXwkGsZIqJfZk0D0uaTsTak/9PE/kBk37riv219DvnESlF1dO00QZOpVgiDcCfRuG6huiDwQ/m0H47VBp+giwY4woxjh2Z3I0ReQGzMYIeXrnc54eejCWxdWjCynHuCwLQF6M00M3nwZX0uYJ6oG/9lFgzADYOiGacUSqLsGHfOCFm6QLWVlS5KvDh2yEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEImdL6MeLbHgEF3GiI8ntDWEXgJ9kzjYa5vdIrQ6XA=;
 b=fnjdsEfetKU86/wMGca7l58NrR53jzxThdCRriaIBh8/6sT/4QNXzKIOUgfcSweKdvEykRF0xHznd9Z/IhOZwgVjxPahe6cnJ4PI2XQVcsAZN1U3QPIXw+D4bVs0fAbalkxqEh/AqOJEehkUA9DNLpGLjaTMfl1CNDGSN6NUxqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 13:27:17 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 13:27:17 +0000
Message-ID: <18ca247a-980a-4d6a-906a-bb5719482626@amd.com>
Date: Mon, 17 Jun 2024 15:26:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: ids: Add IS25LP01GG flash support
To: Dhruva Gole <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Cc: u-boot@lists.denx.de, venkatesh.abbarapu@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com
References: <20240617041841.1336632-1-prasad.kummari@amd.com>
 <20240617062822.474khxwuq4yxs5ra@dhruva>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240617062822.474khxwuq4yxs5ra@dhruva>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:803:104::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0c283e-a718-4ec2-ed8d-08dc8ed1352a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFdiUXNQbTZocHVtM0JvVHV0YjhIRUN2WXZHT0NFM1ZPTnJnTEJmZGxaSitl?=
 =?utf-8?B?NkdBK2lGVEF5MFJpanJIWEVERnNTL3B6UXM0TVNxWElJWTFWUVA0aXduZGl0?=
 =?utf-8?B?ZmFkcENCQjYvdTJaWTZuMDNxRW5HN3lZQXVSWHVvVFRFb3lzT1Q0TWsvZEV3?=
 =?utf-8?B?V3NNZ1ZWbmErYTErOURWbFo5ckIyd3pjay9kLzNQVjJSTjFSVzZ1Y1N3Q2Y5?=
 =?utf-8?B?ZmNFcEhVck1MOS9EVXMvZGtZUGpZUlFyY1JOUkI3Z1l5VkFuM0E2UjBLQkFG?=
 =?utf-8?B?TjRFamJCeVYvYktWb015bExDMEtlVFB6WUpxY3Z2UjVmWEIzemJWaE4xdzlR?=
 =?utf-8?B?UEx0Zkl1MXRWOElxc3NQVm9VUkdRSThrcmpPV3l5TkVlTk9qUXNFai9YYUhO?=
 =?utf-8?B?Zm5NUGNZREczWjNBaTJhZkhTbm5adHhYU0l3Vmp3a29MOXhxaGtFTjN6SFRv?=
 =?utf-8?B?anhnOWRvV00zejJXcXRCL3R5V3RmQ1ZMSmVkSzdsUWlkU0J6WDhJZVRxL2NK?=
 =?utf-8?B?Z1poVkJoZ05ZOUFrcDFtWW41MmtoQnZNeUF2NVlXamhRMkszQTdGbkRKZGxX?=
 =?utf-8?B?MmREQ3MwUm1Bclp0enVrWHpIaU1IdElvd2wxb2xzeklVWXdYRjFOc3d3aGRa?=
 =?utf-8?B?Q1RFOEpNVEJ1NkRYNG0yeHEzSlpBdnV3UU1OTXBrcTRIK3dxRkI2clBLdk9V?=
 =?utf-8?B?RGQzMDBabkxENzlIazFRMTM5MWt0ZmE4NlBFUUpJUitwZHRETUFVUHJTM0tY?=
 =?utf-8?B?YjR1b0ljRzBsa2xnMUpJUktxK1k0ODEvSFM1cGl3N2o1a2QzQWRLU0pVVWQ1?=
 =?utf-8?B?TUJ5UERFNEU5cFp5MzZsVjIwU0RjdENWSzlJMUIvYk1zNE81UHN1cTdvQjJI?=
 =?utf-8?B?a2NWMkpPQ3JMVGVnTkE2T0tVN2tuNHZsMlltUjhWVkZhMUdxKzhnU2huMFZW?=
 =?utf-8?B?UEJRRmFUTE5ZMVJnWXhEZ1pYb3M5R05QK2tjL0RmbFh3RlRGWDBRZUZWcU45?=
 =?utf-8?B?bCt4SkptNEVSSnFIWkV4SXBRWWZBTitkQUprRG9JV2dac00yN2kra0hpOVRp?=
 =?utf-8?B?Q0hxZ1lBNS9YMS9HYWhMaVl6OFg4dnNZN1cxaEFLdVZxVzdDRWc3ZWloNHI1?=
 =?utf-8?B?bVpuVjFBRzRQMVJPbUhoRzBwYUY4UU0yTC9FVkE1U2VzSUU4NkhTeVo4ZTZs?=
 =?utf-8?B?UEt4TVViK1dsMlRKTGt4L3JCeUJpRzBWSFVkUzltK1pYdnNwMGVxUWtsUGdD?=
 =?utf-8?B?MVcrTCtVTWpzN0FibjNWK0pKNEF0cE9EcFRrV0ppbWZ3NVhLeDVxU0hraDdl?=
 =?utf-8?B?WlJCbUxCRUpOM2ZqdlV6VXZCdU9IeHBWdDV2aTkwb1pwRktOQklLQlNhd2oz?=
 =?utf-8?B?WWxyNzhLNlJyRVJDT1dPVi9wSlFYUXhoems2MGtOTWg2MUpGc3VtV053UnRO?=
 =?utf-8?B?V1FtOHlMK2FYWnI1aHRNRmJ2RzNLNzFWV0FYc202bGd0bzRjTUhhZnFXOVN1?=
 =?utf-8?B?MWdQNlM3QkJ2d2hwY2QxOVZEMWRXZDM3TzN0N1NsY21zekxNdzUrV09oYnBs?=
 =?utf-8?B?ZzA2Z1ZBV3BwaStYb3MvUHBhaTQrb1Q1SjU3d21Bc3daRll4TGFITUI1UjU2?=
 =?utf-8?B?cGkyMWVoOW1oOVVlTjdOVG1vejNPN0d3bUQzQXo3STVTYndzcFpVMFNtRXJL?=
 =?utf-8?Q?hyMpJr/caqKzn2GBg/gI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWRKemh1TmlRaFI4eWx0RFpIZ0VMMFprU3pjNEdmaXBJN0U2c29OQ3Q1S051?=
 =?utf-8?B?RUxpUFdSREpaVGkyL0xFUHU0Umc5aUZkb005UGlPUVNKSFFjelZld09jUXdw?=
 =?utf-8?B?a2NBRUZlbWZobFhBK0pLZjBaZi9oOW9kUUlma0tzMFQvOWVkSFgxOXpNandU?=
 =?utf-8?B?U2E1NWFNT1VKK0U1T21YQllWcHlKZkw1RTFLSkFoOU0rSXV6bUNhYmVteHpI?=
 =?utf-8?B?S0pTQ1RmYW1ZY2NKK1dDOGpLQnpNdDFDV2ZMRXV3YWdndEVLdUJBczFKTDIv?=
 =?utf-8?B?eTJvcE1OM3U4MVB1SWpUaEc1a1dSd2pNd09tMDh2QlMvM2d0UEpkMUFCWFZk?=
 =?utf-8?B?WmpLWFlQQVA2V3d2UzJYekRiaFNxTzZFRkw5Njh2MXZjUDkycTY5SUxIMklr?=
 =?utf-8?B?ZWNWZUJjL1JpVWFwb3lHYnJPcUJXWXNtOUY5b1daNkNIdVQ3QjJsb0lscHo3?=
 =?utf-8?B?ZG9HVHk5WXhZbXZRN1FPa29ubEt3UXkyTVF6NmlsOUxSWjRVQTFUZFdzdWlV?=
 =?utf-8?B?NjRWdHI2ZHFBRlhpMEFNZ2FYN3ZpMG84OGVhc1kzWGZWVS96MEt5dHNtTDY5?=
 =?utf-8?B?VVlLOHg3K1ZFRkpiTG42eXRCOGFaSFJUeVVGanlNNEU0YnZsd3ZMMkt1eEYz?=
 =?utf-8?B?bWxjVld0ZktIb2h3SkUzdFdFQ2NNcHV4Vi9vTk96SisvOWtXdHhaLzJXYXgx?=
 =?utf-8?B?WGM4MVNHODNxa1hiUXFvUjdrTEgrR2VBSUNKeTAxVkEzejJxVWpEMTJEaG11?=
 =?utf-8?B?VnJaU002QVZNc3BJeW1NdVB1VjRJTm90NTN5NXZZUWR0Q1d3YWg1bG9nc3Rh?=
 =?utf-8?B?aEEzb2VoSFdRaXphMVQzK0tzZzQ4MDZPa0pYUEtUUkNmV0Rabm1rbTNsY3VK?=
 =?utf-8?B?SmhsUjVKWmFnaW1jTG1TaU9ST2lLa3lDcnZ5RVJxSVpEVnoybzRIZi9LMEw5?=
 =?utf-8?B?UjhXQjBYYmhiVkJkTVdTdVZ5N2o0STZISUhDR2hKL0JXVjJKbVprQzgrZ2dP?=
 =?utf-8?B?M09xcG9jZUwzWmVid3oyU052UFUwaURudGVEYXNXZFVOc1pRZm5Hd0JTeDl1?=
 =?utf-8?B?WFBFUHBNdnIyTDVyMUp4L29Ha0tZYXNNTzF5dThUK3REbDF6d0NHK1YzZ0Vv?=
 =?utf-8?B?NWsrS0FIUk5RN0RpY2F6MTBkcFErYVBCMEcxZ0ExVXV4bUJoMStRWUJWZUJK?=
 =?utf-8?B?NHhDNTEveEtLOFhKTUU0OE5YcmxCNmkrK1lXZTI2emJGbnZxL1NmeEkxNW1N?=
 =?utf-8?B?NzVyMmwzZ3V6QXRPcFArRDdhZzBHQTFIWXFiU3ZETTFNUVdOTjZEY0lXakc2?=
 =?utf-8?B?NGNPb0p3S00rSjlFbmJXU0NHMnlSOVI2OG9OT2ZpWWoxZFlRVnV1VzA3Z1h2?=
 =?utf-8?B?TUxwWFlDcUpsM0k4VUVFQ0tBTXJidE92OVUveEdjRmVtOU9BcElRNU05d2tZ?=
 =?utf-8?B?MTNrbUVkTEw4TFF6cUdmZW5aZVJxVllKRytUS0d5cXRZNXhkRFl0MVNRekl5?=
 =?utf-8?B?ZkNtNUtCSmdkYnVqSXFYQlNyUm5Fa2lzN2pRc3BlcnpkSGUxK0dobWUxUmx6?=
 =?utf-8?B?R3B1bUd4a0padTlLTnN0QVlEbFN2ek1QMWsxendzZTFrdnhtdmNtZnJMdWlh?=
 =?utf-8?B?VEJWY0duYS84T2RteUxFclFaWW90ZTd2bGZJNHZxQ1gyWWRCZ3Ira0VRUUc2?=
 =?utf-8?B?dGI1WGdabTlQVjBncHZUbnZYSEo4SFdUdjdhWUo0RXdwaUZEdUZySzN0UWZn?=
 =?utf-8?B?RFBzNWl1NjJQZC9zcEFOZW9OVjNuTEZ4K1BXS0owK09jdXhqR0JUWWJuZmhq?=
 =?utf-8?B?L3lRREo1SllSdEwxQWE1TW9adUgxRmhBUWF5Ym9vemI1OTJPckc5TW5odWNx?=
 =?utf-8?B?MjJSdGh1RkFEdTQrWjcrT1U3blZZUUpaQmRqMnVVUnMwUzhjZVdrYTNDR2FF?=
 =?utf-8?B?SnJzMDd1NythNHBNT3ZnK1ZlT1FCdmpqNFo4T1pkTlk0MDdnK2RhVkViQUhG?=
 =?utf-8?B?WlJrMlpNWmtPN2ZUY3pCdnZHQUx3ZmxMaHNQV1UvR0VTN1RGcnIvTDJQRTJW?=
 =?utf-8?B?WUpmMzZIbVI2bXZ3eUd6cmFYbnNERGFXV3ljSGV6U1NVY28wWllubzZlbUo4?=
 =?utf-8?Q?m44Dqx4DOmglPUL7emtvzTDQ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0c283e-a718-4ec2-ed8d-08dc8ed1352a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 13:27:17.3735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5mOB51DQnzqlHSo1nFjw+Iv0KsYLvCD71NCWreVxYFmzaCnNzaLSe1qfVGG9CrB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
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



On 6/17/24 08:28, Dhruva Gole wrote:
> On Jun 17, 2024 at 09:48:42 +0530, Prasad Kummari wrote:
>> Add support for ISSI 128MB flash IS25LP01GG. This part
> 
> Can we have the datasheet link for this part?
> I am assuming it's this?
> https://www.issi.com/WW/pdf/25LP-WP01GG.pdf

Problem with links is that they will disappear when company decide to change 
infrastructure or is acquired by different one.

> 
> Better to add it to the commit message.

Not sure what's U-Boot policy on this but placing it below --- should be enough
or what you have done as reply to this email that it can be found via b4.

Thanks,
Michal

> 
>> supports 4byte opcodes. It also supports dual and quad
>> read.
>>
>> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
>> ---
>>   drivers/mtd/spi/spi-nor-ids.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
>> index 4e83b8c94c..8cad764237 100644
>> --- a/drivers/mtd/spi/spi-nor-ids.c
>> +++ b/drivers/mtd/spi/spi-nor-ids.c
>> @@ -242,6 +242,8 @@ const struct flash_info spi_nor_ids[] = {
>>   			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
>>   	{ INFO("is25lx512",  0x9d5a1a, 0, 64 * 1024, 1024,
>>   			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB) },
>> +	{ INFO("is25lp01gg",  0x9d6021, 0, 64 * 1024, 2048,
>> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
> 
> Otherwise looks good to me,
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> 
> 
