Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4936C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 09:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F18D82FC8;
	Thu, 22 May 2025 11:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kCccCrC1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE978301F; Thu, 22 May 2025 11:03:48 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE72682F67
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 11:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTxqnSudKZXQrle73hM12Lk/6fxdR+AkTNLUHXLDx6YsBiDVgeSfbgqTSlDP8DpLNIRjm0si0kKecOjp+PY5LavMSTp37S7OALY4fMu36+1scQA9P5JT4sboiwNIrUGpLwttSAVQyu1Rrbt064xoHdFNBjAkKM7eJGiDak54beOQqdilVjl6i6rKe0SzE5yS+GZL9DQfY3l3ABA2WFfoaPXqp5CnWddv7bvEBFUJVAD3PfsgaXLp3DCgT3C6Ixf1l10nHmO7wfjrew2BLGQ4JAPLqq5+FrdjIZWDOMK43Q07qyjmiEuf5ohO+ewguwsYtrsobgb4CwLr2DNeVaDb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nU7SuvPtdf8VuJ572GZ7V5JdKZX6rKBbOnyG4jn5JkQ=;
 b=e9tB9bYS/9hkn5ZHUqCq8RBmdEYcSOV/NlSXkpVGWHqIrFgE/+PHjyROzNFpNJeQZREiO8idz/qQ81qIkSk/42O3vvxbg7YAkv0Z/FeIjCxkZ75h5181YUxP93w+M8muYOhCRHuF2nxHBkOKDlTUjL9Xu+pdiUdPRZFeUcd7zTvm14fVV+sDV6Ou9YQLIRSMZZU5j9tXZ9ntCf/Sf2VoFjddFx3WwAEaKL8G9mfU2sdJus3B58+7UiFXL+iNaFKhGv/kfIF/jMleZw9n5/uVag5j6G0UTMmWBKCsrfu/HDH53qwyCyYeHqC0MMvC+QWYC2dpvAtbS6AEzTX6vjfacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nU7SuvPtdf8VuJ572GZ7V5JdKZX6rKBbOnyG4jn5JkQ=;
 b=kCccCrC1DS4dOolFfDSxABtvVlBr+BWoA3pxwAwB9alCwdyuGwBNZnksusyIDHruQb4hBdlD7DkIlAVdUOkiVDLFTruzDG3TiuEKxCtdFsbsldtl+KAt3zU9wkjJv/SPivwiofP+0C7m1DTL4SFnk5Zntm29x6bSypR+8cmc8X4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 09:03:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 09:03:42 +0000
Message-ID: <fb1cc6f0-ee3e-4aeb-8fac-23b7e43d6a31@amd.com>
Date: Thu, 22 May 2025 11:03:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: zynqmp: Fix sgmii clk ctrl GTR lane bit shift
To: Rutherther <rutherther@ditigal.xyz>, u-boot@lists.denx.de
References: <20250521181620.8175-1-rutherther@ditigal.xyz>
 <7d8ba8c8-49f6-43a3-af45-8a17d106af55@amd.com> <87msb5hxeg.fsf@ditigal.xyz>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <87msb5hxeg.fsf@ditigal.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: 0365e135-4a5c-40c9-8a14-08dd990f8cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TW1pVTlDRnNWMGQ5V3hod1ZUc0xEZHVYQnVYUUhvQ1BOVG9NYzcxTytTM2FI?=
 =?utf-8?B?UXdkK0YraFJuU0taek1oZzVUSkIxV2JtbTAwTjRkZ05FdEQvdDVRbm0xWTFH?=
 =?utf-8?B?U09aUEgrMWF4ODBuZVJkUVBsVUJ1TFdoa2hGcHJpdCtHM0tVM2lIMXc5YmVK?=
 =?utf-8?B?VXdxTmRHclJyaWx0bTBYMkY3Mm1NWnhJRGRrMUZLYkZlU1ZhcCtpSDUzZWpF?=
 =?utf-8?B?dW9nNXlwbXRVQ055UU5FMzhwVWtiV042ZFJ3UFVscnZFbzM1RkVQNUJ2a2I1?=
 =?utf-8?B?U0NrZklBdFBKRHo3L3d4NHkvZUJOTjRlZmN3d28wYkEvSklvWTY2V054VFg1?=
 =?utf-8?B?b2pmUzhybnR4d1pKY2Z5eVRSWUVQc1ZlUEliazZsSnB0ekVEbXB5a2t2QnZE?=
 =?utf-8?B?cjdCdFpIQ29VZHhrQW9RcmQzK05FU2loaVBlK3EzNDRDcWxMTXJJZzVYWTlK?=
 =?utf-8?B?eDNCdVRsOTYvOFR3aVVQVWkwYmtyTTlJV0xuY0tFUjZFY0dIUVZ1d2QzSDhY?=
 =?utf-8?B?RndmUGpLSXVpTVZyWnhtWHNCWFBXQTNLY2JHTjd2Ulh0RUFiaEc5NHlpeVRk?=
 =?utf-8?B?amtRY3FId0N5bVV5bitOVXJaWVZkNnRhOTBEWGJlNVVUVTdKS1o2bmNhem15?=
 =?utf-8?B?WU44TkhmSDNhZFpqOTlBaUlZcXljY0lyTi9hdUt1bTFVRFVCSlI5S3dIemI0?=
 =?utf-8?B?TTIvcXF1VEVtUm9icTBadHliTklidHlBWno1MTBPdllGY1JPR2themdMOTZy?=
 =?utf-8?B?N0l5bEtySVlpTUpTM2VrcVdlbm1YUnpHK0I0Vjh5dWppcndNNkluejBpWGdQ?=
 =?utf-8?B?K04zbEpUcHVHR2JVOC9wZXZFcW5VblRsYmRtTUNtMGROZkZZSDdrRmgvMVpC?=
 =?utf-8?B?ZVloVkFPcEdUVTZySEFkZTlwdnJzdDd5WVRtQzMwQmswc3RyZnIrbVhjNlRw?=
 =?utf-8?B?TlJydFh4SlVJQU9WelZyMkhQT2s1Njd0anA1RnBpdndONG1WS1ZKMWV2eHkx?=
 =?utf-8?B?WEZNTFljY1I1RStBaHNjTDBvbmNWUjk5WUdMT1BFYnhYZmpmdEdvbDFqdEdE?=
 =?utf-8?B?cWhRT21GWnd1WFk4enNWY1d3QjkzbHhzb0VOVk5iaGZsaEViYUZZUTNvVi9N?=
 =?utf-8?B?cTBGcmhKbW5jYmNmUEhGcTZUc3Nhb3puRThTRWFqM2FQRDRodTZ6c0luZ3JR?=
 =?utf-8?B?Q3dSbmVyZFpCK3M1VktTREFiUG1yMlVvRjM3akxhSWdoUXpEc09LMVVmRmQz?=
 =?utf-8?B?czNjUzhuRitHblkyUko1RWJjK24vRHNQT3NmV1hVcFQzYy9oaENLNWcrYkRj?=
 =?utf-8?B?V1ZicU5vdE5DcG1tUGhCQWNZVzJnZnBXTFUxWlpJL05aWC9ER1cvQWtkWTNL?=
 =?utf-8?B?enFrVjFnandqZ2x5UXQ4WExXVXRsWGtmWFpSRlpINmVzeEE0c3drMm5HdjdR?=
 =?utf-8?B?ckhZbmNVSEF0RFZ0ME9HMnVvbHJ3Nkx3VXAzYmkyTUt4b3F3TDduMkV4cEsx?=
 =?utf-8?B?M0ZQYVljUnY5MzVVam5wcG9pNVRtY1UwSjR4dFdaa3Zta2RPMjlMVUROYXRN?=
 =?utf-8?B?MjRhUk1YU1MwblMrdjNDMWF5TXBwR3ZNNUhPWUllamVOOHozT2tkeFZvVmYy?=
 =?utf-8?B?ODhUU3VVTVlIS0hiZVRmSWtCMHFUREJReFhlaWFKbE96R2JZdm5mU0tualNB?=
 =?utf-8?B?ZGU5UDZpa0s2UHc2UldhTjloTHplVy9pOTVGbHBqNmNPYW9EVVZBZHl0Znl3?=
 =?utf-8?B?czYvczdqZzVxTDhFRWw3MW5rMTJYZmVFeVRMYnpreStXR2VsTWVzb01CdkZF?=
 =?utf-8?Q?ggQ1RC3gn+iPAUfLGGc6g25G1ZjM2TvgTKMKA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjhyT1dmL016c1pRM2lSbHMrUmpROHJBb0hQOXc5MUtFVXR5ZXlrNWhDbVVW?=
 =?utf-8?B?bmpISFFtMVR2WmZtYnd1WjZwOWxWNnZ3Y214czFVWWtkK1dQc2dpS1dlb0RR?=
 =?utf-8?B?bmhodU00SHBSZDZkTWRCbEo0cjgrYnFjRlVyUzZidXZYbjJrZjhtaUVYUWhX?=
 =?utf-8?B?T2xkMitKSHFLQ0lVcEkvZGgwWkNKV0Vsdm9TSFdVUEdpQVdXdThnNVdtYVd4?=
 =?utf-8?B?bkNYZG10WEQ3RUNoS0p0UzJaTi9sRE10Qjd3VCt0c3huQUZKay9oWWx1Y29n?=
 =?utf-8?B?b3JVdUdLdy9LMUVVTkNjTkN1SUdxQWpMQk1LK0tNZ1I0RXpkcmszeUV4elVE?=
 =?utf-8?B?N2k5WC9aTU1aWm9BTC9FNWxTU1hyVFkyUit3T3dPV3RkekQzcjFMWUw3cUhq?=
 =?utf-8?B?bHp0bXQwaUNPdTBXUEdBVSt0ZkpRTlR1TW1EN0U1MDI1dFdFSThFVlFBQjBG?=
 =?utf-8?B?ZkRZUmRKU2pZTXpvMGRjelBPNmpyd203UHFidno2SWZDamR3bmxvaGF5dkxy?=
 =?utf-8?B?b1dnZ0pIcG85bUM0UVNMZS9TNWc3ZUJ4cVhUVU1kamFuZjVUR3BLVFM4YmNR?=
 =?utf-8?B?K0x1YkFJaW1qamRYMG01MlZjczJXTzE0MXBiVVkwVFVyUGQ5MGdKN0ovdXRG?=
 =?utf-8?B?Y3gzRXY4ejEwaXUxdkRucTAzK2MzaHBkdzhGbHZzUm1SbEZ0c2k3a1pLbEZx?=
 =?utf-8?B?YlNBUnFSai80NnR4SkxtUzNGWXE0Y2hHWHZxMTlnYm9TZnRQV1RVdkRnK3BR?=
 =?utf-8?B?LzdMN2pEZndKMytYMWYxM1lUMDZNVUZldUxrTTlqdkJjcG9oa21tbTFxRkg4?=
 =?utf-8?B?SGJhQ0pGM01VVXpES1VMdmtCQ2dXNzR2WmRrVUN2Y1p0OXc4N003WFBLMFJr?=
 =?utf-8?B?eHY5SGx5bVZzZjdsV2V3K2o3SVR6L01jY01LSTVEWWJyQm8vNkc1bERHMjZR?=
 =?utf-8?B?RmFaUlRpc09nbUJzcGdWRzZSaVB2czFXSnlLQmNweFpJdFU5cVNxSmhicnZS?=
 =?utf-8?B?cTdIN0tpMDJzTGpvMW9OUTE0UWRRRlp3SGZFNVZKeHVIR2tEMEhvcWlXSTVT?=
 =?utf-8?B?TTlqYWxZMUtmSzg3NmJvQ2F1NUsrbXVjS1FUNHROU0dMeGdFOGI3V2RNRkcv?=
 =?utf-8?B?RVhQQmdXYm1kbUhGVjM5bU5VRURSV21OYVRBaXo1THZKc2NxalZQbFBDdEJI?=
 =?utf-8?B?V3d2U1A4b0h0MWhNWUUyUHRXbFpacHRrZEY3aG9GV21wd2x4ekdVVzZReDBV?=
 =?utf-8?B?TlFxb1NWd3RJUUZaM1dIUGtQU3JhTEwwMENTU1FENmg4UEFhWFBQQ1VoNk9W?=
 =?utf-8?B?YVdETjJsRW9Xc09UOUhzWnd2RXAwZXh1YnZlZVJOenkrWDIwWDRUQ3YzMGtH?=
 =?utf-8?B?L3FKMmZ2UE9Rc2swUld3SC83K2h5Zmhvd2lYa0dUQWZHbGVITm8xSWZYclFQ?=
 =?utf-8?B?cEZzOW9tcHA0cDBUVzBYSTVCWFIxQVdzU3cwMW5VNXp4bFJqWi94cHlWcFVw?=
 =?utf-8?B?TkRyeUc2TlpybkZRQS9mZjRQUUtuM05iYkY0Qk1mWjFLcnZSbGVQRE1pR2VP?=
 =?utf-8?B?MlhtN29iQlYwWVlHcHFaQWJMVGlPUjQ2dFlKRTl3UzA4QllBdWx6SnlBZlcz?=
 =?utf-8?B?TTFnY3RKZE1QdXZGL3lrbm8wN3ZwNEU2c01hM0dYTmZOdEJ6M0xlbmxMdHVR?=
 =?utf-8?B?WjB4VXFpaEQ3Uk5vcytJSTdQWUQvVVRaaDNlSE91YU1LNWZmcXVIa2U0eS81?=
 =?utf-8?B?bFNnU1lEY3BkTzNnb0VyazNUeDFpK29YNkhmUVRwZDNCZlRjZmdZbjlZVHhl?=
 =?utf-8?B?bjBIRTdPZjRMc2k1S09XOThjT1g1T2o5WHNPd3UxUHc3RUtaYkRqeHhtMUlh?=
 =?utf-8?B?dkQxcHg5QmdlcWhrK3Jod29jVFIwSzBpNkNwOXE2Sk5LRFZBKzNGNVFtcU96?=
 =?utf-8?B?b3RmZjYzdWczbHAwSGNOQ09sOTlkWmhGYTVoK0NjRHZ3dVlmVlRYV3VCcWhn?=
 =?utf-8?B?NkVOVWxQYlVaVTlNQmE1SC8xV3ZCN2dkU1lpTFRNWThMa1FPRWI5Mzl0ZlI4?=
 =?utf-8?B?cXVUK0FoR2ZGaHdmNWlpTnZNeDB4UEpUWmp5UE00SlFKV0NUVTBUb0dJWTI2?=
 =?utf-8?Q?XHQzKndt57d4X6BBc1IgqeyW/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0365e135-4a5c-40c9-8a14-08dd990f8cd2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 09:03:42.3625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr1viCb5nrbV3rBFfRr5dr9H0vDwRIrHYzt68DmZWlhI24uLhy7WjuzV+FNiwZzm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259
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



On 5/22/25 10:17, Rutherther wrote:
> Michal Simek <michal.simek@amd.com> writes:
> 
>> On 5/21/25 20:16, Rutherther wrote:
>>> The bitshift in GEM_CLK_CTRL register is five bits, not two. There are
>>> four bits for each GEM, and one bit reserved in between.
>>>
>>> This has caused that using more than one GEM is impossible,
>>> additionally corrupting the GEM0's configuration, leaving GEM0
>>> unusable as well (ie. if GEM0 and GEM1 are used, GEM1 configuration is
>>> going to write to GEM0's registers wrong value, leaving GEM0 unusable)
>>>
>>> Signed-off-by: Frantisek Bohacek <rutherther@ditigal.xyz>
>>
>> You still have the problem that address which you are using for sending is not
>> matching your SOB line.
>> Author:     Rutherther <rutherther@ditigal.xyz>
>> Signed-off-by: Frantisek Bohacek <rutherther@ditigal.xyz>
> 
> Sorry about that, I forgot I configured my smtp client to replace name
> in the From header. Should be fine in v3 I sent few hours ago, I hope.

But your v3 is not in lore.

$ b4 am 20250522060703.4863-1-rutherther@ditigal.xyz
Grabbing thread from 
lore.kernel.org/all/20250522060703.4863-1-rutherther@ditigal.xyz/t.mbox.gz
That message-id is not known.

> 
> Is full name a requirement to contribute to u-boot?

It is generic rule to fully identify yourself in any open source project.

Thanks,
Michal


