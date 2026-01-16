Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9313D4660C
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 09:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169438389A;
	Fri, 16 Jan 2026 10:59:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VA7UHeGx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 803EA838A5; Fri, 16 Jan 2026 10:59:56 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3085A83015
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVDqMq+ako2sis0dKUUlzdK6DIE2PunXnMrn++mrl0h6A/l2OIsh1LLIVxH5HbX2itLpiTUQ/WL+XpP0IHNJsCuloNo5POXs9koaWfAMiKbFM03ZhePOrH5fSlJ8fW3uED3VHVTrxR+nd9ozl8FPCo4/w8AGSxe5ad+pTEa2Kpdu0/ouAruYqIjdYRWGU9nGQfdSVZufE+QQudLZydT1pO4Oyz/jY4qrnS8HjmvY56PEMd55VB7oPzHZ2ZeGobe0b+rAJBDOKlY6dmynrjLJWeayv+/S9I9p/kxbmV0GbsWnVmmY9vlToaJ1aqTZ97T4inYZ/AE/UZAWrt55PoCLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYlQICihRbdKhpyCZl8vLa6dCaKRlofToga6i6EGQ/w=;
 b=DtjkjI7kRE+IlQmMvjOr5zCP2bdH2XARKV9TYg5h5swE/7QaXnvRLRphoWrpqHPbnu3aqhDICYr7zd6fnIkPw89xc1TUXEJ78iA3qARsHLcMdrGCyCCMl1Ne5H86cuBiGzsjRMnheGVWc+EXOVWGxx6lxJH+nCyvb+J8WAJ9mT/fD9i5eVppTNOdzguMYZoTlSU8Gfn3Yx22+O0p2T410Uuc6QPWSTeRScN/NRzNv+7Q9kxuzsZWTbchkVfHbHlj0lGxqCmFWnDGJ4jq+LMC3lHtPnikEqDUtjbLPi+RUZA6DkHMw+PiQEVaMOgBHNBuXVCFxoRD3laMySkLCFXdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYlQICihRbdKhpyCZl8vLa6dCaKRlofToga6i6EGQ/w=;
 b=VA7UHeGxuZc+MGcJoqRIybkT7Nw7Qc1PuKXidhiN1JUxbNvpD7ZpCud/9pWl04i7qh8x9qGi1qJQpsjWZGg5icQUAeI+gCKX3srgmlBw+CYFX73cDNB8CvGhOZrtHuMQsge/cHYRKwiryv8Ef34pQpYl9/gd63EuJOYfVDerC4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.7; Fri, 16 Jan
 2026 09:59:50 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 09:59:50 +0000
Message-ID: <9f92f0c3-a690-4f14-b3b0-b75df8132a02@amd.com>
Date: Fri, 16 Jan 2026 10:59:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] microblaze: Update linker scripts to ensure
 appended device tree is aligned
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-5-trini@konsulko.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260115222828.3931345-5-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::8) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 804e3812-ddb2-427a-2e93-08de54e5fd27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTl5Y0p4SmozeXV5YjlnMjRrVVFPSS91Qk12cm0zV1ZXOVRwNzNQakQyMkJS?=
 =?utf-8?B?bG5Mc1cvc1ZQSit2bFVQWFdJTy9oQ0NFRS9OOHZUUHNJcUx1VHV1YzJhdEdP?=
 =?utf-8?B?a3djeWV0ekVxdG1YdGpZZ2Ryb3RxVWI0TkUvSDRTVDhObk1IM1hraGh1YW8w?=
 =?utf-8?B?eXloNkJpTVVOeEc3OE55QnUxa2Z5V0NzTVdnUi9SS3RSUUZ3WkVLUENVSWpm?=
 =?utf-8?B?Q0VSOXNnaUdBUTR2dTlHWmJleWswNzVSNStOc3NRelhwcGpPUFNTUkVoL0FH?=
 =?utf-8?B?WXFnTmNTbVc0d2xiei9wa2Q2M1hqNGpGbHBFUlg5WVhXVDYvY3M1L2lFM1Nj?=
 =?utf-8?B?akx3WlZzNEs0RXNJdDJ2REljbEhpUlNyL2gySFBHSko5ODMxSTNLNVM5eVlU?=
 =?utf-8?B?Q0taTXoySTdadllsakJZNE5IOUwvQks3dHpsa3hTSC9MLytjSkFRMW5maUl4?=
 =?utf-8?B?ZDFXcUVuS2Y3a3I5VlVUNFRDbTBlSFdvVVlHS3BmWWdYc0JmQ2wyK3NtK1JL?=
 =?utf-8?B?OWxuWXhrT3FJa3JlbzRaVVY2SWl2U1E1bTArZnJuSVJyb3k4aEgwY2dQV2Yv?=
 =?utf-8?B?ZlVldjYwV1ZSbVlFMGwvQTVLQTZoT3VKNTRGd2VKRzRkU01nTmRsb3hXTFU1?=
 =?utf-8?B?amRHYnc2dXVoWjhTRVVuT1cxNURDak5DWEM1VHFZSng3Uk1lZW42ZXEzY2x1?=
 =?utf-8?B?L09mSlhsdVZ4QmhRSS9obUFCdjY5OEJ3OGN2Mjc4eC9PYWs2S012VlZNZE8x?=
 =?utf-8?B?NVBlOU9ZUXpWZk9Ka0Z2TEJiM3ArSVc3dklvVzFHZi9zSXRVMEg4N21DN0dJ?=
 =?utf-8?B?cWRuODczc3pHb0d4bWdYNUMrUzVpSHR6Ni9HYUNoWjNXcVlBQ05NMUNNNDRD?=
 =?utf-8?B?bmNaTWRuVzRhNzdTL1BzcVFLOE1LMzRWL3dQMkJzK0FpMjZxalQ3N2kyd3ly?=
 =?utf-8?B?NS9xOWZrZWU1TTFTYVlRYTJBQ2taTi9nYTR4eTY1RzFQSWtHSGdsck55Nngy?=
 =?utf-8?B?c3JPbXA1MHowaEg1cjBhcWlVTVJXMjF0aVdzTDdEOUQyTW53NXlRSmRuNllT?=
 =?utf-8?B?ZmRPQjd5bkRqdTdFQU1oRFN0MmdLaU1HS1J3WkdacndydTdhZXZnemM3Z095?=
 =?utf-8?B?U0ZneThMZDNpbGFIZEpSNUF6djJieWkwckFPc1QrekVCQzh5VHRveUozL0hV?=
 =?utf-8?B?TUhLVmJwQk9BWGdnb2s1Q2w2d1dNc0VTd2tzN3JjUGYzSDE4c21VSXFISkt4?=
 =?utf-8?B?eU1YT0p4ZncveWxJWUxoNVd1ODh1VnF1ZS9tSUhHdjV3cWVYZFlYelZEVUk5?=
 =?utf-8?B?UnJmQkRsRktXZFZXKzE5dUN2QWRVcFJaeTlzZThYRThoUVdZRHUxYUlNYnFC?=
 =?utf-8?B?aE5seUpYR3RhNTF3cFQ4WjJjNU1teEsxb3V1bEl0ay9hTWZmS3ZST3lkMCta?=
 =?utf-8?B?VnUwelpUWmpDWlhmWm5WSzR4SHFYVU81NnQ3K1gyVzhHckRDbU5JMVhZektl?=
 =?utf-8?B?dmlRWXFrUmdEMTlLcDlKR1c5Qko5TEdzcEhWc1BhWDdVL0JKUlFtcDJtai9G?=
 =?utf-8?B?MU9FWWRNTmM0ZTRqcndTUlBLT3BRSDFnMHJiWkJNK1c4SEIyZHZoMjNrMXNS?=
 =?utf-8?B?RGJTbU00TXRMZFptTUt2U3ZseDIwaFNwRmdJZmFYVWxtZ29rUjN3V3hoT1Uz?=
 =?utf-8?B?cWpoTnVCUWtGb2IrVjVVRDlwZHJNeHR4RUp3K2VFeXJXemlMUHpSS3hkWWNz?=
 =?utf-8?B?aTQ4UXRuVk1IZEUxZ1pGVzFtU2p2VUd1OFdKZ3VpQWp4OWNmc3Y1M08za1hY?=
 =?utf-8?B?TXBPR1ZFQjU0RWc5RnBSeEdGUlQ4VUNFNWRJVURxaUdnb0JOVmpvSkkyVXV3?=
 =?utf-8?B?bzBHMjJUcVJscnpXZkI5WE9NUmFxdzVRUzU5SmV2VVNtQkFnMm1seGFQQlRr?=
 =?utf-8?B?M2NXeC9sN2FvSW5EQVFtcWxUNGo4QnAvdmk3NlpCRFZxaUQ0ckZVa0QxSSsy?=
 =?utf-8?B?ckpnU25neUpGdDFLYlFsN1hUL2lseFZ6NnNuN2dGU0lON2xxbXRwRkhPT0ZC?=
 =?utf-8?B?MWo0Q004ZHdmM3pXYXlaK0pMS25DS05NTVV4bGFUdElBMUxBRUxQMU9VUktJ?=
 =?utf-8?Q?rR+Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amtRYVhJaElaUHp3emg0UklQeDZCd3F3UDZKU1JZOGdsWmNCNy9ZV2orNlA0?=
 =?utf-8?B?WTdKdGhSNlNPL0pYQVNYTmVaSkg0TSs0RHBVZTdRYVQvaVdLWjRBRVVpck9l?=
 =?utf-8?B?MWU3Snk0TEtobkpvRGtyY3FMWlkraEY3cS9lUFZteVlpcXU2cXR3VFdDT3N5?=
 =?utf-8?B?TGMyZnNvMkllNXZQWkcweHR5ZGZpL0NRKytiVEhvRCt4dDJHUE5ZZWYvVzBj?=
 =?utf-8?B?aXMvZERjRXNqcnFKSktPNFJZR3NMUE1tMFJVa05zTldtK2VkWnR2WEVMTFRy?=
 =?utf-8?B?M2lhZlZ0U1hUL0dDVU5Fcm5qWEh6VmY4TFdjNHU1Vm5Ld1QwNlI2SExNbkNs?=
 =?utf-8?B?dzZrQ0F4TlF1eTBuMS94YjFIc083OGF5WnBlZkY1OFJOdFpQQ2o0a3EyK3Rm?=
 =?utf-8?B?b3hNNzVNaFZiWnFXRVMwQjZ1RmFMeC9OT1VpbFdhV2g2Z2xXNFV5V0Y0ajlI?=
 =?utf-8?B?cnhNR241MEx6alRpK2ZSQTJJZThOMnlESGdPbm1WVzRCNzdJanZKM1NUeGNJ?=
 =?utf-8?B?ZS9qaWkrNzhaekFXVGRGNEw1eFVxSjE3Mll4dE81eFpKV3oyc1l4b05aa0xO?=
 =?utf-8?B?TzQ4cjdxN0Ruek1MZUtTM1owdVppaVRwSGoxdHRCNk95d0MzQXJlNXNBYXhv?=
 =?utf-8?B?TkR1L05ORXE5eVZMbGVFYmFIUXRZMUg2VEZxTmIwczlsQlRKVFJ1QXBoNUtm?=
 =?utf-8?B?WHBKeURodG91L1Y4Q3VMeXlReGl5OHZoTVI4aVRCUjluVmJpOTZpbHF4Rnl0?=
 =?utf-8?B?MWNYeE5pUW9kemN3VFJyZ2s5cjNIZGVPN01sTnhHTS91c1FIbTBmWERVc0Yv?=
 =?utf-8?B?RkNjcndWblBxWFlxNjNpazZsUDBpRlUxdXNWK2Myb2s3RGNzd3BONUkwTldl?=
 =?utf-8?B?S1dMVUZ6bEVTWVdWZklkMElIVVppZ0NDZXN5YmpZRmM3VUZENUdBSXFUV1NK?=
 =?utf-8?B?ZkVWOGVBMlIvVHU0dEU5d3N0VWlOZzRDYm90a3hhTWhhcDk3NWhzYkUyVW5x?=
 =?utf-8?B?K1k0QlkxN1hDZXNQRnlCekJMWUtTcG5hMk96aUwwSTEvbEExbFVoQ0pkSXZD?=
 =?utf-8?B?T0loMk11cWg5WTFFeWdwbGFudjZSc1d5NGp0YmRGY0w2SFBvVEE1cnVBWHUz?=
 =?utf-8?B?aDVyWTZRYkdOaDBhd2RGeEdHNm9RSE9ueFU4aCtsNUdXTFMxUjNpdmFUMTU5?=
 =?utf-8?B?VTJBdWR1L0ZLdTBOdkNsMjRLTGhGZC8xOTRSTlB6d2FCcHdMNkxLMSttVks4?=
 =?utf-8?B?Uy9DSlRpRU8zMHdlcTJ1bEdLTnNNUFYySVNHa3dzdWhHTGViM28yM2YxdHVJ?=
 =?utf-8?B?R2VXUFVEendCSWZCTVB6ODdUeUhSL1ltYUh0WjRSS1h6UXJ0eXA3OHoxK3M1?=
 =?utf-8?B?L1FJTVlvRFpCb3FTVjFienZGSjdTSFlnUFdMcjFLaS9sQUlzMkxwaEp4RTRy?=
 =?utf-8?B?ZFloUFNLenJLZG5DZVk2OE4rTzQySzlWK240YTZWUTZST0VaRDYzTjYvVUNI?=
 =?utf-8?B?YjViMTAvaGN4dmN5SFloY3AvQjgrbVNOdldDWUxZK2lPN2pjVkxIcEJQSU9N?=
 =?utf-8?B?aVJXMHVjVkdTbkw1Yjd1dURCQ2N4dEwyOEtDYjNCNUFUblpzZ2NrVjJMT1Ba?=
 =?utf-8?B?a3FVcEhPVldyWTVKSGI1YlNpbUFJL1IyOS9wdEk0UjhCbVhJK29Eam5tNTkr?=
 =?utf-8?B?eitocmswNTJqYkpYYXpVcGRYaDJnRTl0SExVNzYzUWlqUCtva0t0aG51bkQ0?=
 =?utf-8?B?QVFBbXEwV01hdXJHZUMxTGw3YW9VdHF2OVVqUFlMckVvRG83RTNJWXVUb0JP?=
 =?utf-8?B?ZllOZS9rN0cxU29jWndZRHlnZ2JPMi9RUTIzcnR0Ti9pSkYvSUUzelpObmNW?=
 =?utf-8?B?V3pRWnk1ejFUYUh5RUJMRldhQy8xVmxDM09OQzBMczkrTWZ5emJXenJUUzgv?=
 =?utf-8?B?Z2ZoN0dOcWxZeXU0dTI4c0x5MWh2eXd3akYxL29JWEt4U3o5SW0zNExyODVB?=
 =?utf-8?B?L0hpOG0vVW9JejBYRm9mZXRDWEZqYXVZQ3FwOEdML3JKdmdSTjBIL3JiNW52?=
 =?utf-8?B?THdvbTQ4OG1obEh5UVAySVloeiszZEM4bzRsK3Z1dXd0OVA4N0ttNzVXNWRG?=
 =?utf-8?B?S1A3a0FxN1JoY2JQUys5REQ4SnowdEk1aGlaaEl2OHJORHZrMWZKeE05VGxE?=
 =?utf-8?B?WkFXOXhKRUd5ZEJMdGx2VTJ2b3daUVNkR0pqWDFRcmJMN2xqYW1UNXp5VWJF?=
 =?utf-8?B?UmhBTDRSTWs4eFRWVXNIMzVOMkVZdzcwVWJhdGZqQU9iNGluS3ZscFpoelB4?=
 =?utf-8?B?d3E3MWRzeVhhcFIySVIyT1Z0Q05lTmp0RE56V0l2eTdEcUZxR0ZLQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804e3812-ddb2-427a-2e93-08de54e5fd27
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:59:50.7673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jooik1SUF6uWgmEz1uP2nYRWXzXbFwIWLQXmpRu9e3+bQ0KXCT1RXNJb63Zdbpgb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
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



On 1/15/26 23:19, Tom Rini wrote:
> With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> that we must have ALIGN(x) statements inside of a section to ensure that
> padding is included and not simply that the linker address counter is
> incremented. To that end, this patch:
> - Aligns the final section before _end (for U-Boot) or _image_binary_end
>    (for xPL phases) by 8-bytes by adjusting the ALIGN(4) statement to be
>    ALIGN(8) in the final section before the symbol.
> - Ensure that we do have alignment by adding an ASSERT so that when not
>    aligned we fail to link (and explain why).
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> ---
>   arch/microblaze/cpu/u-boot-spl.lds | 5 ++++-
>   arch/microblaze/cpu/u-boot.lds     | 4 +++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/microblaze/cpu/u-boot-spl.lds b/arch/microblaze/cpu/u-boot-spl.lds
> index 09abbea84d06..620ef2c96dbd 100644
> --- a/arch/microblaze/cpu/u-boot-spl.lds
> +++ b/arch/microblaze/cpu/u-boot-spl.lds
> @@ -50,7 +50,7 @@ SECTIONS
>   		*(.bss)
>   		*(.bss.*)
>   		*(COMMON)
> -		. = ALIGN(4);
> +		. = ALIGN(8);
>   		__bss_end = .;
>   	}
>   	_end = . ;
> @@ -61,3 +61,6 @@ SECTIONS
>   ASSERT(_end - _start <= (CONFIG_SPL_MAX_FOOTPRINT), \
>           "SPL image plus BSS too big");
>   #endif
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/microblaze/cpu/u-boot.lds b/arch/microblaze/cpu/u-boot.lds
> index a2c8fb2e21c0..70fa49c31712 100644
> --- a/arch/microblaze/cpu/u-boot.lds
> +++ b/arch/microblaze/cpu/u-boot.lds
> @@ -67,8 +67,10 @@ SECTIONS
>   		*(.scommon)
>   		*(.bss*)
>   		*(COMMON)
> -		. = ALIGN(4);
> +		. = ALIGN(8);
>   		__bss_end = .;
>   	}
>   	_end = . ;
>   }
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
