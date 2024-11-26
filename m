Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1277D5A6ED
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 07:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBFD888A0A;
	Tue, 26 Nov 2024 08:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0BNceUWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D332988D14; Tue, 26 Nov 2024 08:56:42 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B014887E30
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuS0bHRaJrfQdkPaA8vCOAdQBgg6VRKoR3l+I5sJytl2HzTByBiLUDSH8DP3n5qa+a1TH4LtXMt3+UukG1wgJ4V8cSFbQ35TzoMvC9LE9AR88AztSOoeGqiIySCiI+fPkAuDfGUPeqqL0s7jkbGGTo0jNgU3aCcby7TkVZ9EU6hpx8E39dVzKactiK9q0b3sShjbngLZ6nzJRdYe9lMeKSqcF39QEVV72pM8I8/qJO1HgCOg9OTMIMeqaUweyCa5bMzWadgDgF/zDut+cgeXR9CXX9wVnkA2uoZBI6unZvjPD1emKmwS1kpdvJuoRHKMrN//YZuNIokUsTpNUKLgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UwStfpuK9eSKOVUmvUqM8vt6BBfxh8M9hsZJ2YzVfU=;
 b=MXmP/7EMdQgC9yhYn1UQ1NfnCb/O/no+A8zZCdxdll68IsJwSQ2YIUIv3+p5eCq6e9ux2l9Lpp4r1C8nLkupZEXSNmIx6kA4IWWJHpKlskttyl9HUi5UWpt7iQfD0k12d+/wo5oUdxBKtYYi08o5/tRjwGuJZhN/iJtVBnxWmFaQYyynxmBoWkR1hUDBST+vpNO4PotbkssAQLSL0u9YTxfEAndnek2532ZwSwYcrYwUaWyKTaC50yZO/xxG7tWlNH+6J7B81o1se1VE8wCkl4bSlJMAPpR8w228WkI7nL8q4zJNKD1xpLxZVfQvbeS2mt+P2ipnjiDzVo1sB7bLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UwStfpuK9eSKOVUmvUqM8vt6BBfxh8M9hsZJ2YzVfU=;
 b=0BNceUWy9Cmlxpk0dbHKdLftoVVJwfro6x54dojutmEsdIQ4V2rMfeJVBlAwM3ioxq8sTS9nm2vmnh3Op1UQ+A/LbyvO7usMFzSNhsTALYlvykRGk2jLnqKoODdC+iuIV3rF2l+X1C0EVh/XDzMrTwkgJTydgEDprBa5dmiAjL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 26 Nov
 2024 07:56:36 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 07:56:36 +0000
Message-ID: <e26f73b1-6f39-4b47-bfab-a69a247cf68a@amd.com>
Date: Tue, 26 Nov 2024 08:56:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
 <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
 <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
 <9a90a05e-1e93-49c7-a72a-523ef345e7fc@canonical.com>
 <30c3072c-8446-412d-a534-61d9c8e0b03e@amd.com>
 <CAM=mAOkbPngqXopm1cLJ97WLUnD6y4q_2ha8_982=TvQsv_6NQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAM=mAOkbPngqXopm1cLJ97WLUnD6y4q_2ha8_982=TvQsv_6NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0086.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::27) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 630941c6-c484-4e69-2770-08dd0defd9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnhWT1M0V2xINFhvQTArL0pwWE1YVXNyWGZidHl3eHo3a3YyV2lIQ1dqUkxB?=
 =?utf-8?B?OXMwL1FScThoN3ZyL3pUS1o2eEhjNW55bWZhM2hPV1UreFRuSUdXSlQzQmhq?=
 =?utf-8?B?VGRjNUVMTHdPa0IvSjVlTng1NWlZeWhCUjZ5dVZISURRcFpRZnJXaFhDMmNP?=
 =?utf-8?B?alJKSXIycEJkVzlsS0RwdklIWmQxdi92YVVkRmd1aUJjVVZ2alN6YkV0b3BB?=
 =?utf-8?B?bTZjMklCZldMalVXcUZsQ1I4VmhaYmJIL05neGZ4M2VkVmppMC82S2lid2ZM?=
 =?utf-8?B?TUNmWFNtdmY0MWxzMDZnbFFGN0ZJRGtZcWlKd3VNVnZRS2lxTnZYdXFzRDlW?=
 =?utf-8?B?b3pDVTduNFlvU1MzbkZrU2VpcW9hMkJPc3pLcnVRWEJuNzRCVmRXN2FTemhr?=
 =?utf-8?B?RWxqTVdXNlZNdnFMeVVBNGUzSTNhV0JXMy8vTzMxaWt5aTdhNTNsRjIzbTBM?=
 =?utf-8?B?Ui8zaDFaQWNUZGpYM2FJZVArM2toSVJkeDdQWHdmNC96MkFzWU9BOHZ3THh6?=
 =?utf-8?B?dWdJdGR4Uk1Sczg5eXJVbVJ0R1VEa2V5VFlZcHFjRU55ZzdQTktkalNsOEww?=
 =?utf-8?B?L01RMmd6UnZJdXFMZjFGcHowU2V1ZGI4ODZ1emZoR3RHaHA0cXFMNnZLc0p6?=
 =?utf-8?B?anRGVjE0dmZpMC9ETlo4WWRXL092aExmUlhpMUIvUFdWWHRxOVNOM1NsblFR?=
 =?utf-8?B?TldlaUdCcE1jWjdBWUl2blZNekFCbGM3WGNQMVVUYmRXY0gwd2ExYjk5V1dW?=
 =?utf-8?B?ZHBaVnBOcVF2My9NWnYxVG9CTWtXbk9jOXhSajNxNjZvam1qeHlHdjRCeXlp?=
 =?utf-8?B?RnZsZXZTNmVXeElDT0FXUGlEWDZqR0gwbmQ3ZzlhdGNBNnU2Qmc1WDhUQUgz?=
 =?utf-8?B?MWJmcHhVbDRvc3ZQNUYxWnEzUTRTNGJ3REZpUEFUSHNWdWVQY2NNK0FGSk05?=
 =?utf-8?B?akp3ampwTGxoelRQQk1hejZheUs5SHVTUTg5R1lyQURIMXVReFJadWh4NmlR?=
 =?utf-8?B?WFBDMFl5Nm9HWlM0NjhGY0poOExzd0ZQbEozTjdXRnIrekhHVXA2RUtWTjVM?=
 =?utf-8?B?M09WMzAvOHlHUUtaeC9Oa0xtbUt0NXExdlpvWFhrWVBmTEpWT2FTaVVWMzVW?=
 =?utf-8?B?L2VQSUVieXJ4VmluNVVsVVM2T2x0Y2VZN2IvV2ljd25odW5rVGtIVDhTcklN?=
 =?utf-8?B?Y3E0cFlHWS9EcG5mTk1ObWlNSmt1MCs4cU5YZUhyYURsN0NLK2UrQTh4MDRy?=
 =?utf-8?B?T3Y0YlcxdTlXN0JCSldmSDBWYnJBcXBLYlByTGZUaDk1bEVRR2QrZXIwZGxG?=
 =?utf-8?B?N21ZdFhzRTMxV25jTmhNb3FYd3VoRk1Bc0RQK1V5R09UVTRqMzFHbHc0bFJC?=
 =?utf-8?B?Qk5pOXNxaVlJYmRJQ2MyRnl1ZGV6SS84UFJQbnpFdTR5MnFsT3Jwb0ZpZmZj?=
 =?utf-8?B?WDRrK2JvWnhXMlh0cHZkRTIzM29VWUNYT1BqalVvZnFjTXpSNno4K0tNbEdq?=
 =?utf-8?B?OXhZU04wT1g1NngxSHk4ZkwvMTRKZE5OVlFLMm1EMFd4TlJkSFE3eU40L0tR?=
 =?utf-8?B?L01sS2MwaXdEU28rTkc1V1NRQVNkTUx2Rkk5T3paK1hDa3NkTStvNVN5MzRI?=
 =?utf-8?B?bUdPeXZLMnpKd1h6UDdyakJiZTd5Yy9nT3FyTndzQ2EwTkFyNE83WWkzbElY?=
 =?utf-8?B?ZVVJeFlBQ2Q0UUpQaTRIY1VlNDJBQzZscjNLYWJnVW03UzBqUzJjVXFiTFBr?=
 =?utf-8?Q?C14mDkRFulUu88m/q4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZNUThrekI3bGtJNnRzR2FDdjFRWjNNY2RCWUpsc2tETVpGNmJGUzBRb0xR?=
 =?utf-8?B?cWczbXhUUjBnYkZNbjBCYlpZQUphbWpjMTRrZGJKMThCYTJUK3Q1N2NPakFZ?=
 =?utf-8?B?clFOdFpWMXZMRXpLc0s0cFY4N0lTZWd3RU1GcVdBQkEzU09iSnluY1kvV2tv?=
 =?utf-8?B?VktzWitsb3ZkazJYSGxHMG9VdnVBSE9CNS9DVzlOdGlQc1QrSTJDY0pBVFNt?=
 =?utf-8?B?NDhXd0NQQ2M2c3ZoSFZYQTh0RzRkRGhmL3NMZmVoN0ZVdHpPSE5ndjlFcGR1?=
 =?utf-8?B?cDVwZmlLaXJnejZiRERLSWNaTzUzb0huQ29TWk44b3dxUGJ6V0QrVVd1YnVr?=
 =?utf-8?B?b3h2OEU3NktUNFB0QkpyQ0Z3SUZpUWViRDY0VnorSFlobkViV2xlOTkrdGh4?=
 =?utf-8?B?TTZpRHZjZG5QaHpGNDh3aDdvWDk2L1BCSWl5c1pkenRoaEVreHFVK1g1Tmor?=
 =?utf-8?B?eDJ3cUhJWmZiYzI3ZWRsTVE5b2wrSTRteXdsM0JaVHZmY2dUS1FId05yQ1R6?=
 =?utf-8?B?YWlYeGdoSWNMUFRibURSalJieFQvWVlSejVDQ0NxR0Zaa3dEN2lHYkc5TTRQ?=
 =?utf-8?B?VDM0VHhydnZubGJ4azB3cit6NFdONjJMSzQyTFlqMzJLMU5lZENTQTJGbnhW?=
 =?utf-8?B?VGIxUDNiOW9pOHZlOWhnMG5TNGg4UGNFYUdWQVNaN1hQb3lLOW05RlBjVzYv?=
 =?utf-8?B?Sk9tZVBCQk4vZkhsSDUzRnpDZ1BqNlBVRmt0S1ozanorVEM3aEZ0MGFyMnln?=
 =?utf-8?B?MU1yRGNuUWVVam1HZTVzYkVWaExrREpxYURvYmNMVEtnTFdESU9VYlAxUmhl?=
 =?utf-8?B?bGkrUWx0ZHpsdkZKWCtPdXJHY3pmUDhHTDZjSHgwN0o3cDFXOGpqVnZtQXVV?=
 =?utf-8?B?QTRtZkQzRVRCNmdOa3NBNlhNbFVUajIramZuNnpDYjlPWWZDdnpXejV6eW83?=
 =?utf-8?B?OEc4aTBVSjcrUVNuYzNpQ2RSTjErVm5Cd3JDOWJjTTNldlk3ZElnbFhMMklu?=
 =?utf-8?B?N2NXRTNRYTczb3IzSmlRTUpjUFRETnRBcHdUR3MvdytLMlN5V0R4WGFCcEYv?=
 =?utf-8?B?YXh5Uk1WV3BTeG1pU0E1ODhJanFCdVZRR1krVFZlNnNRRGpLYnRUTEZNQW1K?=
 =?utf-8?B?WXU4SjJBR2R5bFh0cjlKSmlqRG1Cb0tkbmI3cDd1L2U2cDZhR000L3pDT3JG?=
 =?utf-8?B?QzNaWGlFcnJ0RmZENDh1TFA5YWV2ak5SdlBtWDBqT0pQdUZPc2Q4U3Nsc0FV?=
 =?utf-8?B?UVFzZEZuNTg4UXYyUzR5aEwxdUpieUFvMGQvOGlkUE5YMHEvYWtkT2M3dGpP?=
 =?utf-8?B?aEI2NFFhTHVEZE9PQzlhU0RUTTVTUnFvVlNjSEltbDB6c2Q1VHJHOFNJZzJo?=
 =?utf-8?B?L0x4YVg5bFFOc2pKTG85U29qOHlkVnFYaHNUMmJLRm9Yd2ExZFVpU0tCTEFK?=
 =?utf-8?B?RDRHQjhSbU9IdGh0bk1NTkk3bFh4KzZvUDJiUXRpMFJrZFljMnU5UStQN0Q0?=
 =?utf-8?B?REhERm80UlhwMTBBc0ErU3ZxdDdGZitPYTJ0eDlvYUtQWW9rUjRYbE8rUU9a?=
 =?utf-8?B?aVBZTHVkcXVYVVVkdDFVeFQ0VDJWaXMrNm1rVUhaZXhTTG8rblBES2k5UHRX?=
 =?utf-8?B?enpHS1R4NnFUUThIQS9IUkxCcGFIc2pDK2xMNGtyVDB1anB3UmFjRkNraHJC?=
 =?utf-8?B?RlRoVkgweExsSTBxelE4ZWR5K202Mk1OWllqdm56UWtTOXVlcjNBZStTdkg1?=
 =?utf-8?B?QVhubFZLaUd2ZXI0ZHI2Q2xsdmFSTmJTSDFzTUo3aTB6NWxVay9oTk9laE1U?=
 =?utf-8?B?YWFSYWd6dGd0VEkwS3ZKaHNtNWJpSDQvYTRPMmlKM1NEMVBrRjF6dkJRYmhY?=
 =?utf-8?B?WE9GWUNhLzRoL0lRa1Q2VTFLTTlKWjlwUU03eW1IMjVxQVdNdVhobkhEeUJW?=
 =?utf-8?B?dUh6d1ZtNW5OZ3plUFZvbVpiZXc1STlMT0YxWFF4TnhBUHBIdGt0ME5BMHFj?=
 =?utf-8?B?d0JpMytkWEQ5bnluQlgzM2dQajk1T24yRGl5MGU2TEJLbkVJNzFqYy9zdC94?=
 =?utf-8?B?NHZBQ1Q0SHMvYzhRUkc1THJXNjJtZWpnZmtFQTU4RUo4aEVTcWFLbllBaTZB?=
 =?utf-8?Q?RSwsW72oj5wtUUG4nj/mdBiIF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630941c6-c484-4e69-2770-08dd0defd9c8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:56:35.9676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubiCZHzVW3w+qaQ+4MRPRkPbvOfQI+ZrbSsbKpsP9BCoomukZ5ZA3kVkwtppKvzz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
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



On 11/25/24 21:09, Heinrich Schuchardt wrote:
> 
> 
> Michal Simek <michal.simek@amd.com <mailto:michal.simek@amd.com>> schrieb am 
> Mo., 25. Nov. 2024, 19:04:
> 
> 
> 
>     On 11/25/24 11:35, Heinrich Schuchardt wrote:
>      > On 25.11.24 11:02, Michal Simek wrote:
>      >>
>      >>
>      >> On 11/25/24 10:21, Heinrich Schuchardt wrote:
>      >>> On 11/25/24 09:32, Michal Simek wrote:
>      >>>>
>      >>>>
>      >>>> On 11/23/24 22:45, Heinrich Schuchardt wrote:
>      >>>>> The CI uses the following command to launch xilinx_versal_virt_defconfig:
>      >>>>>
>      >>>>>      qemu-system-aarch64 -M xlnx-versal-virt \
>      >>>>>      -display none -m 4G -serial mon:stdio \
>      >>>>>      -device loader,file=u-boot,cpu-num=0
>      >>>>>
>      >>>>> 'usb start' or invoking eth_bootdev_hunt leads to a crash when function
>      >>>>> dwc3_core_init() tries to access a register at offset 0xc704 (DWC3_DCTL)
>      >>>>> relative to the register start address 0xfe20c100.
>      >>>>>
>      >>>>> Disable CONFIG_USB_DWC3 until the driver problem is fixed.
>      >>>>>
>      >>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>
>      >>>>> ---
>      >>>>> v2:
>      >>>>>     new patch
>      >>>>> ---
>      >>>>>   configs/xilinx_versal_virt_defconfig | 2 --
>      >>>>>   1 file changed, 2 deletions(-)
>      >>>>>
>      >>>>> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/
>      >>>>> xilinx_versal_virt_defconfig
>      >>>>> index c8f166c1221..06a240173ba 100644
>      >>>>> --- a/configs/xilinx_versal_virt_defconfig
>      >>>>> +++ b/configs/xilinx_versal_virt_defconfig
>      >>>>> @@ -153,8 +153,6 @@ CONFIG_USB=y
>      >>>>>   CONFIG_DM_USB_GADGET=y
>      >>>>>   CONFIG_USB_XHCI_HCD=y
>      >>>>>   CONFIG_USB_XHCI_DWC3=y
>      >>>>> -CONFIG_USB_DWC3=y
>      >>>>> -CONFIG_USB_DWC3_GENERIC=y
>      >>>>>   CONFIG_USB_ULPI_VIEWPORT=y
>      >>>>>   CONFIG_USB_ULPI=y
>      >>>>>   CONFIG_USB_GADGET=y
>      >>>>
>      >>>> NACK. That's not the way to go. If one test is failing in CI disable that
>      >>>> test not really support which is for HW too.
>      >>>>
>      >>>> Thanks,
>      >>>> Michal
>      >>>
>      >>> Hello Michal,
>      >>>
>      >>> It is not that a single test fails. USB is completely unusable on the
>     board.
>      >>> 'usb start' leads to an immediate crash.
>      >>
>      >> I am not applying any patches on SOM with HEAD and usb is partially working.
>      >
>      > Don't you see a crash when executing 'usb start'?
>      > What QEMU are you using?
>      >
>      >> I can agree that it is not super stable with upstream only patches but
>     that's
>      >> different story.
>      >>
>      >>>
>      >>> The problem already existed in v2021.01.
>      >>
>      >> Any log?
>      >
>      > $ git reset --hard origin/master
>      > $ make xilinx_versal_virt_defconfig
>      > $ CROSS_COMPILE=aarch64-linux-gnu- make -j$(nproc)
>      > $ qemu-system-riscv64 --version
>      > QEMU emulator version 9.0.2 (Debian 1:9.0.2+ds-4ubuntu7)
>      > $ qemu-system-aarch64 -M xlnx-versal-virt \
>      >  > -display none -m 4G -serial mon:stdio \
>      >  > -device loader,file=u-boot,cpu-num=0
>      >
>      >
>      > U-Boot 2025.01-rc2-00172-g880fcc49eb40 (Nov 25 2024 - 11:18:35 +0100)
>      >
>      > CPU:   UNKNOWN
>      > Model: Xilinx Versal Virtual development board
>      > DRAM:  2 GiB (effective 4 GiB)
>      > EL Level:       EL3
>      > Core:  32 devices, 13 uclasses, devicetree: board
>      > Warning: Device tree includes old 'u-boot,dm-' tags: please fix by 2023.07!
>      > MMC:   sdhci@f1040000: 0, sdhci@f1050000: 1
>      > Loading Environment from nowhere... OK
>      > In:    uart@ff000000
>      > Out:   uart@ff000000
>      > Err:   uart@ff000000
>      > Bootmode: JTAG_MODE
>      > Net:
>      > ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 0, interface rgmii-id
>      >
>      > Warning: ethernet@ff0c0000 (eth0) using random MAC address -
>     5e:f6:37:a3:68:24
>      > eth0: ethernet@ff0c0000
>      > ZYNQ GEM: ff0d0000, mdio bus ff0d0000, phyaddr 0, interface rgmii-id
>      >
>      > Warning: ethernet@ff0d0000 (eth1) using random MAC address -
>     5e:8a:ec:a9:d7:e8
>      > , eth1: ethernet@ff0d0000
>      > MMC: no card present
>      > MMC: no card present
>      > Cannot persist EFI variables without system partition
>      > Missing TPMv2 device for EFI_TCG_PROTOCOL
>      > Missing RNG device for EFI_RNG_PROTOCOL
>      > Hit any key to stop autoboot:  0
>      > Versal> usb start
>      > starting USB...
>      > Bus dwc3@fe200000: "Synchronous Abort" handler, esr 0x96000050
>      > elr: 0000000008068fd8 lr : 0000000008069940 (reloc)
>      > elr: 000000007ff17fd8 lr : 000000007ff18940
>      > x0 : 00000000fe20c100 x1 : 0000000040000000
>      > x2 : 0000000033310000 x3 : 000000000000003f
>      > x4 : 000000007ffa74b0 x5 : 000000007c112880
>      > x6 : 000000007ffa74c0 x7 : 000000007c300000
>      > x8 : 0000000000000684 x9 : 000000007bda668c
>      > x10: 0000000000000003 x11: 0000000000000188
>      > x12: 0000000000000000 x13: 000000007bda6be0
>      > x14: 0000000000000000 x15: 000000007bda6224
>      > x16: 000000007fee9244 x17: 0000000000000000
>      > x18: 000000007bea6be0 x19: 000000007c111b48
>      > x20: 000000007c111240 x21: 0000000047822004
>      > x22: 000000007ff998b2 x23: 000000007ff998e8
>      > x24: 000000007ffd4514 x25: 0000000000000000
>      > x26: 0000000000000000 x27: 000000007c111130
>      > x28: 000000007c1110d0 x29: 000000007bda67b0
>      >
>      > Code: b9030660 f9416e60 d5033fbf 52a80001 (b9060401)
>      > Resetting CPU ...
>      >
>      > resetting ...
>      >
>      > $ cat u-boot.map
>      >   .text.dwc3_core_init
>      >                  0x0000000008068f24      0x6a0 drivers/usb/dwc3/core.o
>      >   .text.dwc3_of_parse
>      >                  0x00000000080695c4      0x310 drivers/usb/dwc3/core.o
>      >                  0x00000000080695c4                dwc3_of_parse
>      >
>      >>
>      >>> Do you know of any QEMU/U-Boot combination where USB ever worked on the
>     board?
>      >>
>      >> Why was this visible in CI in past and why this pops up now?
>      >> What has changed? I don't think there was any change in QEMu regarding
>     USB but
>      >> I can double check.
>      >
>      > We never started USB in the CI.
>      > With patch 6/6 of the series usb_bootdev_hunter() is invoked which starts
>     USB.
> 
>     Did you push this to gitlab CI? Which test/py is failing there?
> 
>     M
> 
> 
> 
> 
> 
> 
> This is the failed job.
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/955501 <https:// 
> source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/955501>
> 
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/ 
> commit/636a4f4793d4d5098afdd46b00205c7bb245570c <https://source.denx.de/u-boot/ 
> custodians/u-boot-efi/-/commit/636a4f4793d4d5098afdd46b00205c7bb245570c>
> 

I can't see any issue when I apply this series on the top of rc3

https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines/23565

Thanks,
Michal
