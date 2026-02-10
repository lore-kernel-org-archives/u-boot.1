Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8807AE9463A
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 03:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD628341A;
	Tue, 10 Feb 2026 04:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cvyfHk9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2A9A83C65; Tue, 10 Feb 2026 04:56:51 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5A5E8309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 04:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSZmMDsEwE5y8waIiLRZGbSR9ljJeAbQsaKOqoRq7AmZHVBsKdc/RHDjn2Ue47p9ICay62MgzkgfR5eDJx6fQ1fnPMPrCoO+joNs74j2lerj02+DgBLzgL8NyZHTJtKSbupBplZs/pEXZZgsXdGCqmqv/JQ8Ia7QmkNzrKUhujRu24lwITMoVxPlfaNhxrAueF0MoiTdSpQa+kBRrJ9iKYaiHHYcQBhMj4wuoxhumC/hHSaNODN/1t7lAzTVq7N/RPSgfRkiFd5ffCMRpHTeUm4Xl7k3Sn0XQE3JyNorBEV0hKAOIxqwW3F8BwN4t2sfDZBMH8yX9nOUzprsQZDTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f2RSDLzoH5kQfpY61oppK2yhmq7A6SFvv2GVYY4EYA=;
 b=calqWbKndUXNIYC/tyA6MwTT/FxJmxIOxRPCvDAkVZ15ElqhoLAhO8lXg3/Z2XfBC0q7fi3HGyEw7sQyIZ6O2vlZp/3k/zh1GgjzL2Ai5LmZqCrNhJIM0VMLJBRs6nIR64Wqlr77YqpgYcyee3Z5M/D2Px7y3yMV2oJj1q1J/ChMAcRqR9iRYS6Av//qzAuyteKwiXuq6AuS7DtqrelxuV6dh2QK/1RfpviA+eVAeMlEphraGQsG6drVf98kqyu42NHvE1H1VfwlPUiE8U/yJjZ9+SbJ7B5vEQMNarApaa9bVqAHDgzuYPUCpRNDaARIpcS+4ley3hY3SDI/7UceNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f2RSDLzoH5kQfpY61oppK2yhmq7A6SFvv2GVYY4EYA=;
 b=cvyfHk9Tn4A7IHBOikoqN4jLBUobJ37MwFDFoiPFiAbrpDd6ZUm/72878R0l2e4dTWZziMGVRLXMvypk+QNtcpNjREk/ghdc2daM3JESr1w4wjNf9l1uMoed/ryIioW3rm1eOl0T+NMgHb9/XAwgQ/U/H8/NBSkdpfaTGy8nFMqTBmhEVHBOBR377e94wqBYvJP2JbJNKFEA8ZmecBxSz7nRis8DjnSbbVhMCk3Nnupeqq+fhbgL7BCtPWBdGFrkkjqo93qmbmNrRfkhoTK5nmqNc1Os2MEOap+yzXAxLmTYXilRq4F5EqyqUUN5mndFz+ypnRLqR2sglqBWgBUwkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA3PR03MB8349.namprd03.prod.outlook.com (2603:10b6:806:460::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 03:56:47 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 03:56:47 +0000
Message-ID: <70f1c176-c197-408a-880c-015664e2ebae@altera.com>
Date: Tue, 10 Feb 2026 11:56:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm: agilex5: Enable eMMC HS200 and HS400 mode
 support
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com
References: <20260201151343.27560-1-tanmay.kathpalia@altera.com>
 <20260201151343.27560-4-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260201151343.27560-4-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA3PR03MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb62364-1e41-49c2-2377-08de685869a1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnJhZ2VoRkZjVlErUlcybytwWjEzMWUxckE2ZmZLY2pMK2tGNGtNazhqN3FV?=
 =?utf-8?B?dENzTVVhTjdtRVQ4QVNXMkdYUW9aNFNDT3B6V0tCNnFldU9NQnFtczNKc296?=
 =?utf-8?B?d2Y0RnJXcjcvd1Y3bjV5bTVQWW5HdSt1OGNSWXo1OHFFenlpcE53djJPYkk5?=
 =?utf-8?B?SjhkZkVkWElkRVNTdUpFNmNPWWxRTnhBTXNlM3hpK1JhTWdVbmhSNHkySkVK?=
 =?utf-8?B?VVFLQ2FLdVVMM1lUMmVHdUluS2piVzVsd0ZVV1M4TVE1UlB2cVk0SlQrR2xF?=
 =?utf-8?B?V3Z4dkYzOVZWelJvVEx1emRIdVFYUXA5THcwMEoxeTIvNHBzRGFUYkRGamwv?=
 =?utf-8?B?YlhHeWJPNU9TZFgzZWJjd2Y2bkVEZXRoUzgyOVdQcUUyREp4emo5K1pLNmFN?=
 =?utf-8?B?UDRiOUl2bHNCanBsNktqWmRieStsdDlOTVQ1OUwyNTVWNU1lcStOd0lnTUpi?=
 =?utf-8?B?S0FTVzVaUk5DZ0V4ek1mWXRveXVSS21UaEFSVGJoOUZ2L0l5SEtBSlJRbm9p?=
 =?utf-8?B?U2ttT28zeng3alRKRmlZNjRQYmtlM2x1bmU1UnBSTVRVQ2NFbU9NWllYZy9j?=
 =?utf-8?B?MFYvQXBUN3BzMjl0ajR4VHJJcWlNdzV3ZmROUk9lNmpyVEgwUUxsdkdwWHcv?=
 =?utf-8?B?VGlndjlrekxSSGI2T2haSFQrUnNTczNZOGoxeGFyZ0NDWkxEMmpyNktQQiti?=
 =?utf-8?B?bTBKcHpITGN4TWIrM3BtQVYrSiszU2plNkxoSGVobXVSeCtxMnhRWmNZOWJq?=
 =?utf-8?B?T0xiNk1BZmdYUVRUOFpIWnpuVyt2S080SlFpSEIwRE40VUtmY3NOK1piK2VY?=
 =?utf-8?B?RVRPcjRUSE56ZThYWlcwRGVKNmNuN0hzN1hna2tHcGV2UHJUaHprclJPaFVp?=
 =?utf-8?B?eFJsTlNvVms1OFN3WFNMOHJCN2ppeGdWOUFVSDJ6ZFovYVh2b0ZtakpEMmcv?=
 =?utf-8?B?UkMrV2s3cDhqdHBNREVwM3RYSlZMZ2VuM3Y2TG9VWThFSy9WYUl2cDhoVi9D?=
 =?utf-8?B?YWtZS2pTNERBUlRGOGFvODFvQkNOTFBrQ2xOUXhxQ3FmNG1hWm9qSlh1Zzk3?=
 =?utf-8?B?aDZ0eWNZRW50V2VKOUxEMFVwZzF2QTlVOTVlcjI1VHFpUVpCTWNIUzBzNnQw?=
 =?utf-8?B?NjFvL0hjejBBOEFZdGxyV200YTA0cWF3ZjcrdlpGRnVBWFI5QktJbHhtbTBJ?=
 =?utf-8?B?NnZPWUNqNGxRQ3cwQVRPWjRkSHkreDVabzZRMjBMcVlYNU5uT3JRWXVIWXJX?=
 =?utf-8?B?K3BCOXBoVHNTS1FCM1JIUHpzcG5QUFhLOGJ3enBzdjFRS0ZLaHZtVndDNHF4?=
 =?utf-8?B?aEpiTVRSNkZnK1hJSXZpSjBSMnZiNkZyRWNybm9PbThMRCtqcngyYzBld1Q0?=
 =?utf-8?B?NHlEbE44UFlHLzBjZFJtMit5dWxRczNnS2xLYzBwTTJsNnNxb2JMWkJJK1Zn?=
 =?utf-8?B?M2xUWHFOR1FHOS9nV0ZWZG5nWEw3Njhoa3RzNzRqOHI4TXBDTXYrbXcrVlYw?=
 =?utf-8?B?SVBBb05PczcwejFyVmMvdjdnMlVkaE12TDdUOTlQbGMwNUgzc28xR3EzZFJE?=
 =?utf-8?B?Wml6OGdMZ05KeGNjSmt1Y3hINHovK3A2V0ZYb3pNZUtoeFREWno1NWp4Mmw4?=
 =?utf-8?B?TGMxT1Q4b2hmYkhza3J3NERDaEExTHBrSUVBTE1rZ3NROW12bVltNXR0Z1RK?=
 =?utf-8?B?QmRJQXdQNjBvRExBaytZU01qYTRLV3hqanBqRmo5Rml2ZVF0WWt1WDNXRzFn?=
 =?utf-8?B?U1lyV1B6OHljNDdsNHplWStydFFGT0NyUjJCMEJCUk9yMEFxWFA4R2tuL0Fi?=
 =?utf-8?B?K2RHVkozQ1FZNHByK2NpVmlzNTh1R2NZTUJzWnhFT1FndGRlY1RFL3RjUThQ?=
 =?utf-8?B?dDBlVmlyNUtkblI0SmFYOFNINEtONGNIZnFhMkxVT1FIK1p2NlBkNGRKOFJF?=
 =?utf-8?B?bUVHVzBGQlBOeEUzMUFtZUlrdGRmTmJ6OTZmZTl5N0xwRjljc1dwemIzRXRS?=
 =?utf-8?B?aklCVXh3R2Q5amFDRU94cHdqWFU5a3hLRHYwNEc0MHQrcTNIaHVwSVljU2FB?=
 =?utf-8?B?cHVpNTJjRCtzVTkwUjZLQVpua3V6Zm5UM2tnUDAzNFVKYVlmdHlsOXlhWGNR?=
 =?utf-8?Q?YKyA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTA3ZS9TLy9MejJpUVVqamdBUkUzRHp6VTJHaTVvOS9MZ1A4N3AvWTNxWW4z?=
 =?utf-8?B?L2VaeWdhbURBYzk2SDd4VlJLamVTazllWDRJYTNYTTVkL3VKamdDWG9IL1Fw?=
 =?utf-8?B?SlE3bUlRaGR0SWo2aDFMSGFpTEJTVG1rQnc3MU0rNFYrR2lJeHlQK0VvTmZB?=
 =?utf-8?B?MkxOT0RLTTJlbCtxQWtJOWNvbERiaHpydFZPeE54WjRxZ1FYalB2TzFKQzEy?=
 =?utf-8?B?ZzM5ak9kalVsa1V3RnRSaTkwWmd1ampRblFDVVlNbmVXOWZIUnAzS3MxR1VR?=
 =?utf-8?B?djQrWjhDRHpoMWxqdXBObW12WVd4cmMxdURTZDJQbXJiRnIyVEpDMlRjRjQ3?=
 =?utf-8?B?cmtqSURQZW43aWVkWU94enBTUnVoSFQ1YUVTZWRUK3V2c00zOTZtMGtBd0lG?=
 =?utf-8?B?Tzg1akt2U0FIWUJjMVRieG1nRlB4V016YXZya0U1d0xQRVpNSi9LZmpsaGwy?=
 =?utf-8?B?YlRPVDhtNkVBK2krb29JUXY5MzEzYThNaFpDdGRRZTh4Y0RYNEZyZkRzRnNa?=
 =?utf-8?B?SDhDdis3Y1ZJVlJGdzU5Y212c0gwSXJORlZCdTQyUHJNQmYybGt4Rm5IbkJ5?=
 =?utf-8?B?aUFVSit2dUNzK2J3Z2Z0RGVhL3I4bkxaSDhaK01Lc3oxS2hSb2t1NkFYMHk1?=
 =?utf-8?B?OUk5TlM4T0Y4dUs1aUR4amI1b0kvRmxnaXoycUQybm92MHRYdE92NUVlcVdK?=
 =?utf-8?B?cW1FQ1FuTWtTUXFtbkozNWY3dW52VU9hWUQvY0diNXdWd1BHdzd4VkVpRHRM?=
 =?utf-8?B?enBCekhoYUJrSHh3aGN0eXZxV3NSVHRIUjRiZFJFV1pFMXlYSnJBdGVzOVg0?=
 =?utf-8?B?NjJlSDhiWlZ3eGJmYUZpeEdoUngvdHYwWm5GbWJhNEFXaVk2Lzg1NDM5NEc0?=
 =?utf-8?B?OWxUaFlYK0FDNXl3L1ZNbjlNcnVmR3Nxd3c1Ny9GZy9jRVllN2FJalpQWDFM?=
 =?utf-8?B?NEoyUmxXSEpvRUQ1dzQ5SmM3dWtYWXgwakEwbkpER2VSVWc4KytreE0zZjJv?=
 =?utf-8?B?SENjS25iVFVwM1J0dzdoS1p3MVBveXhRSTdLK25aZ3BLSXNTYjdvV2VyM2hy?=
 =?utf-8?B?NGt3UEtxcDFvTHZkOWgxZHVoSDQxWDlYNng1WVZYVnJHY0xwanBVR0dUSlNN?=
 =?utf-8?B?YVJ4MDJOcHFZZzRMdG1oN0hhaXZoY1lTZVpiRlNTYktQL1QwVkFKcTdxSFNy?=
 =?utf-8?B?bHV1MzdTc0lPaUJjYWh6UWM2TFdjaWpvanpXUU1OWUt6d1Y5emFzM1ZpOUUz?=
 =?utf-8?B?bk5DN3hyUlNUUStKV3gwMjFURm5KQ2tmL2d6eXVLT3NNN29XZnVOTTRiYU01?=
 =?utf-8?B?ZmRlUXloMWo3NXliU2VnMWh4WkZSMXRzeWRxTXF6OHlOclZXYWlwWTQxU09l?=
 =?utf-8?B?ek9KL0l2SUtzQVdmcU1MOGR3Vi9hMEltdVphQmtWc3Y2YU9qQWZuZUpmUUpw?=
 =?utf-8?B?TVBpY1ViOHJzVTJnL1VrTmx6cDJudVE4eUtxK0RocHJrN3RzUWpjTHlMWnBB?=
 =?utf-8?B?TXV4blBZbDR6NVJsTmlvaWxCa2RTUGtLdlYwSk9xL0lFNkxpdDlOR3lJTHRH?=
 =?utf-8?B?d1BiQUNiY2lDTm5POGZ6ejV4RHU5SXZaMkwyTjZXdC9qY2pGbitjOU15KzVa?=
 =?utf-8?B?U3BTN2dxeE9Fa3M0Mi9kRUV3d2tnenh4Vk5ZNjRtVlhUU1RrTTRQVmM1NG1x?=
 =?utf-8?B?d3k2M0Fjb0RUdHFzSFdjNG9lVy9WbE5TM210S2dJV29VQXpSTU1RMlZ3dEVr?=
 =?utf-8?B?R1R0RU5EaCtVSTY5emVuVWVQUHJFcE5YM3lVOXVWdUcwNS9VUVhzbWFqTG1I?=
 =?utf-8?B?Q0M1M1lpb3JyU1daLzF5SWhwQTJmTDBIZzMxNUlCTEhWRllQSmUrUDlQWXlK?=
 =?utf-8?B?WFd1a0hEbW9Xa1hPWTVZQXVseThCcDNhZ1U3bnpnNW9SM01hYnI1VWZSdmJ0?=
 =?utf-8?B?VCtNaWIreGo1M1VwMTdBT1V1OHNxcEl6Zy9lZHdKSVhuNGdIamdoeGNNbnF5?=
 =?utf-8?B?VEVOT01kWm1YZXN4WEY4andIcVZOVWVrOXgyUlhaNXQ5V3h3dHBtN3VRUDRM?=
 =?utf-8?B?U1FKOUwzSEFkbkIyU0l6T25QUzBLM0xNSzhONVZkQ0NzSWtRR3p4NEhlelZT?=
 =?utf-8?B?cXhKUE4vcGd3b3p3RHRTQWNqcThpdkRQTlRxZUhiMTFEQUdWVXVBY1N5dGRD?=
 =?utf-8?B?ME54clVTMWh0S01sTHBYNzJ5dTQxUGtpTXBmYjZUNXFlVmttZmJ0QWpyM1kr?=
 =?utf-8?B?UXZNYjFONkw0SE1HVTlrdUNGM3d1MVhKb1haOFB2OERpREhQYUl0bElzRlJx?=
 =?utf-8?B?MVIwZ2RaQ005MlgzRGlOeThXTDZoZ3ljNzJkeWdGZnNSR2xJYW9GYVRNZjJ5?=
 =?utf-8?Q?kpomSC3z/mw2U6h0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb62364-1e41-49c2-2377-08de685869a1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 03:56:47.5209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfp9UzliQYENtyTYlnvO6eE5wAhOMzsE6jr9Gj4SC4cHVucTyY5SjdBIV02UzqMnrLHGCyBimDjfCMVUzM2RqicM7XHmiawOhkvPvPALSDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8349
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


On 1/2/2026 11:13 pm, Tanmay Kathpalia wrote:
> Enable high-speed eMMC modes on Agilex5 SoC development kit for
> improved storage performance.
>
> Defconfig changes:
> - Enable CONFIG_MMC_HS400_SUPPORT and CONFIG_SPL_MMC_HS400_SUPPORT
>
> Device tree changes:
> - Add mmc-hs200-1_8v and mmc-hs400-1_8v capabilities
> - Add sdhci-caps-mask to mask SDHCI_CLOCK_V3_BASE_MASK bits
> - Add sdhci-caps to set 200MHz base clock and 8-bit bus width
> - Add PHY and controller timing configuration for HS200 mode
> - Add PHY and controller timing configuration for HS400 mode
>
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>   arch/arm/dts/socfpga_agilex5_socdk_emmc.dts | 27 ++++++++++++++++++++-
>   configs/socfpga_agilex5_emmc_defconfig      |  2 ++
>   2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> index f6848c373cd..c06781064ca 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> +++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> @@ -25,11 +25,14 @@
>   	disable-wp;
>   	non-removable;
>   	cap-mmc-highspeed;
> -
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
>   	bus-width = <8>;
>   	vmmc-supply = <&sd_emmc_power>;
>   	vqmmc-supply = <&emmc_io_1v8_reg>;
>   	max-frequency = <200000000>;
> +	sdhci-caps = <0x00000000 0x0004c800>;	/* SDHCI_CAN_DO_8BIT */
> +	sdhci-caps-mask = <0x00000000 0x0000ff00>;
>   
>   	/* eMMC legacy mode timing configuration */
>   	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
> @@ -46,4 +49,26 @@
>   	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x30000>;
>   	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
>   	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0xA0001>;
> +
> +	/* eMMC HS200 mode timing configuration */
> +	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
> +	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
> +	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
> +	cdns,phy-dq-timing-delay-emmc-hs200 = <0x10000001>;
> +	cdns,phy-dll-master-ctrl-emmc-hs200 = <0x4>;
> +	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
> +	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
> +	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
> +	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
> +
> +	/* eMMC HS400 mode timing configuration */
> +	cdns,phy-dqs-timing-delay-emmc-hs400 = <0x680004>;
> +	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400 = <0x81a40040>;
> +	cdns,phy-dll-slave-ctrl-emmc-hs400 = <0x4d4b40>;
> +	cdns,phy-dq-timing-delay-emmc-hs400 = <0x10000001>;
> +	cdns,phy-dll-master-ctrl-emmc-hs400 = <0x4>;
> +	cdns,ctrl-hrs09-timing-delay-emmc-hs400 = <0xf1c18000>;
> +	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs400 = <0x80000>;
> +	cdns,ctrl-hrs16-slave-ctrl-emmc-hs400 = <0x11000001>;
> +	cdns,ctrl-hrs07-timing-delay-emmc-hs400 = <0x90001>;
>   };
> diff --git a/configs/socfpga_agilex5_emmc_defconfig b/configs/socfpga_agilex5_emmc_defconfig
> index 9254ab92e0c..47d345be97c 100644
> --- a/configs/socfpga_agilex5_emmc_defconfig
> +++ b/configs/socfpga_agilex5_emmc_defconfig
> @@ -4,3 +4,5 @@ CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_emmc"
>   # CONFIG_SPL_DM_REGULATOR_GPIO is not set
>   # CONFIG_DM_REGULATOR_GPIO is not set
>   # CONFIG_SPL_DWAPB_GPIO is not set
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_SUPPORT=y

Acked-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong


