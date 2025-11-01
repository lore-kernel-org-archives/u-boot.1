Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49079CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 04:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98D5F83A05;
	Sat,  1 Nov 2025 05:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zk4UwJM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81C9183A1B; Sat,  1 Nov 2025 05:20:19 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C96839E8
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 05:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIBYcuEPsnkh4tYguoaQ3XFrb7hiD3FZlTPu09B/g+6Hhpb/fq7bVIgpWdHIMfMP4lWApTdE4N733tfczl1DPiQYcaUITOJ/3f8HAzuH75oPDFr+AlwKhUmXJ+C/+r3A9L5v7xYYk1uk27mN9BFiszZ1p6Ac/9ixbu2a3suCB3XUI/E332hCqJyiESQY6vxWjqcMxToVXv3ATs8q+8289j/ItuGrU0/nv6H6z48eQ+J4azKg9yhYN3FiYs+J/zf/VBwsP32yMjpt1k71Jov1bSL8bkwRWTnapLxEn7/PbVM52piNhFNI+oQEO4tk8kr3qWXK6fHoImGkGWYfPM6kvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9d2XK23DtmCp1LcZpJ62K39gV3EDHFZOzd+nOZ22Ng=;
 b=YLyMzGpa4llj2cWJoDY5G1w8BcaXg292kqRo2BO40wf1X17cPTC3pWmJv6VR2KyIDwM8s5OmsacntAsk3/u9g6A3yPCt0KoqIc6JilW+AtBXg5R51OHvpuALmn3kNeRTiusal4UitkoIHn0cNPJTKfXyR9QkOePARoF+8BtXzlMUGAZwx1FiBKr7jjxh2VEWl7JtPgXFzLpkCQ8KJCeoiVzcUOIDmrGhVutpgL8GExi/VvsT9k5+mRXOqJsv7Rl5fuoCkrox0O7NBREt43nJIwVxK7qANdlEhjWJHSVtcOjumD5aN1GOzzOqntkzV3j/uBmcXsa5R+sTGq0C+XfwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9d2XK23DtmCp1LcZpJ62K39gV3EDHFZOzd+nOZ22Ng=;
 b=zk4UwJM/qaslc/cuhi6OwdduPp9e3ALLhIZREFQYdD93QuUDI7xgRKFQMh8UTEAjt7fft10SDzdGg0gSb3wGQTmDJPueCvr4xxseTSfsPxlckocv9BQoZNPGNtrG/pMnv1+5FDJYJZ5guzct0knIdD4GsaQIr0PKM/7UwrWKLjOMXkZAXC8v4O0Yfkc6As7PoM1xA1RamL6SFvrYnr3EB0MHOdQ0jxkce9QHVnqxDO/K3jrAqwqcMYJGIueTjUuoEa1xc0f/awgQ7jhXFv/xtOz5MtOx+I4XbuwnaxL4YdVV5RWNNgmH97wFab+x3+U6LMxcVkEvC0aUTd+qmfocxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB8323.eurprd08.prod.outlook.com (2603:10a6:10:40c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 04:20:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 04:20:12 +0000
Message-ID: <37d46274-8b4c-4794-bc83-4b6ce5a4714b@iopsys.eu>
Date: Sat, 1 Nov 2025 07:20:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spinand: add support for FudanMicro FM25S01A
To: Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: u-boot@lists.denx.de
References: <20251030190710.18848-1-cnsztl@gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20251030190710.18848-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 36effc11-ecda-496c-5b1d-08de18fdf33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGx5Q245NW1LTFpqOXBKYkxtWDl6VTNJSXYwQlNUWCtweU1vNFdGNDIrQTNG?=
 =?utf-8?B?bUJaMzl5TlJDbVNpbHlaQXpWanNMM2FTVUNaQjBSeFRSRXNNQjZseitBUWxm?=
 =?utf-8?B?SnJkckovenh1T0x2clJzdXV6clN2RGE0QXdIcFFlMVNJelNtQjVsMHFoN3hH?=
 =?utf-8?B?YmNCbUovUURSWjlLV25GRWE1WDBxZnNvNnprV2hENHVwM3M0dnhERlJJZDVQ?=
 =?utf-8?B?cll6K3VpWTNBeEo0OXpORzdjOEZvV0NvUllMWTI3Uk1UUFJNVzVOVHFWN1Mx?=
 =?utf-8?B?WEdYN0pKaXJPdk1NTHlBanBTNitrQVdmOXB0cXpJNHQrS1pTQ3EzbTZVUEdM?=
 =?utf-8?B?MzZGZENZS0l5MWdoemI3NUxENS9KVHc3RGx3cHQ5WFJRSTBhTzJLMTJLbTls?=
 =?utf-8?B?cks5Y0x4NU45S1l2SThRNmNUNGYzRWxZeWVlYVJCTG5Mak14aGRpdnZzUVZy?=
 =?utf-8?B?Y1BvbmNFRUtjUUoyNDVrTUtTMllrRGJxT2tqSTBIL0ZxbkdCenVSTGpMU0gy?=
 =?utf-8?B?dEJBQzcxdzk0cTNBNVdwMUVwM1NxR2RMajlNdHl1b3I4V1FJS1Bra3kvWGo2?=
 =?utf-8?B?dXFqQ0FWMjFTTWx6TFJTQjllbDJxNnVIMEs4VlRmUDRPZmRpZFVFeVYvYzd1?=
 =?utf-8?B?cXhOd3d0VDc1ZytWSGdoNVgyNi85dy9IdlRtSzFSTy9mVXV5eFdlcVpKUkQ1?=
 =?utf-8?B?Z3JDYjMxNDhiN2wwdjdvNFE4SUgxVnBjK1V6M2o3aGFueXpLc29TUDUyRURa?=
 =?utf-8?B?OVpVazI2M2gzSllHa2d3NUhENWNWOHZ0RnFOTlVBOUN5TmdXLzFVYXJMNWZk?=
 =?utf-8?B?VGdDTzZmSWswZHpnSFRiQ3dILzZEL2NPNG9NcWRFRFNHNmpoNU5iYTZsQnZk?=
 =?utf-8?B?UDdNNCtGN01KekRCVTBWTldlK0kwTDQyVCtSZkpnVzNuSXZQcEorOWd3M0VT?=
 =?utf-8?B?bHF2Um1RbVJtdDhvcjc1WUYwZDJWNnpqMEhtb042SUtYNW9mMnl6VVNaY3Uv?=
 =?utf-8?B?UFR2ZXk3emVteWNCOHdXRjNvTnNJdjh4MUFXYm5wd0Z3am5zU2h5bXQySHVv?=
 =?utf-8?B?QUJTclo5NmtmUzRKQU4xZHFjZ05MVlgvdjN2bFQwOVZSR2JPc0tNTzAyNWUz?=
 =?utf-8?B?UVo1VWRBV2MyVzBwdVNLU0J5YUFscWE5Sk43c0dpOWJ5UjZpb1h2a0xtMDVj?=
 =?utf-8?B?cFlxdDlWbGJtK25KbHo0SzZRMG95OUpHdWRINEU4YzVkK0hvOFVpUEUwN0U0?=
 =?utf-8?B?bXI2SThwNkdkek9STjIyQ0pyallCT1pQdlRnQm1nNXIxbjBPWm5MdVZubEZW?=
 =?utf-8?B?K0EydmNDd0Jzcm1IMXdTZUhPRkc5NU1oSTFZQUttQWtSVVl1RnltaFhZUUxw?=
 =?utf-8?B?VStidE1SMXNhQTRTYVdOYWNWaGJFMm9YUHV4TkZkLzNScVpaTTN4VkRrV3g0?=
 =?utf-8?B?VXFDeWkvS01ZS3JOKzVnMXoxUmlPUk9HREgwaW4rMGY4NEdkZzdFSHRpa2hH?=
 =?utf-8?B?eFV4OWxZWUpWRXA4Y3k4ZkJVQ3FIMUVHTlFSVjZPT0ZEYW14MlM4RDlNbjUz?=
 =?utf-8?B?K0V2eE5NME8vNmtGRDdVVm9ybjVMT044Tm56V2R3aElFZ1lPTVJVdE84UFNn?=
 =?utf-8?B?dXd1QXo1bmNkWkptcVRXdjh3ZDZobEI4a1ZIZ0UwU3BpL21veWFmS3YvTUpZ?=
 =?utf-8?B?RkU4bHNkL2xrOUxCbHNXUXdmT1Q4c1hKajJPVHF3L0d1cWNaQkNjT3lFdTB2?=
 =?utf-8?B?ejBrdUVOYlZZLy83TDlBeDhSWkVidzYrZUM5Wm10SjZxeHRqL2NWTnZuRzF4?=
 =?utf-8?B?UDRwVUE3Mmw3MGpGcU1MZi9aclI2ZWVtait6UWVnUGUySXEyMGFhL0hQOGpu?=
 =?utf-8?B?UUI2RURZMEExRVB5ZzIyRUFLVVNyNGxiN3Y4OXZJeEMxWml6bW5Vc3laeXBS?=
 =?utf-8?B?VUJXWm5sUEEvMWtSUGRUblBrUXNmeXhjWEIvZkowdm1lbU1VWE5JVWJrTFFm?=
 =?utf-8?B?Vmo3SnpBckt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJTK0dFZk9kcFlFZEVNb3Q2MHNRUVN0WXF4dHd2d0tjU05xTjFpalVZYTN5?=
 =?utf-8?B?cFRaaURZOExxa1h2a01EVTVHMXJEVXd1OHRFRXU1UGhRUjdXaTRxaHl2SVlu?=
 =?utf-8?B?Yk95cUtsaU1ZTllkTUNNSXRQTVF4R0lpTVpaRHJsYlZrcHhZVkllQXhNRzNI?=
 =?utf-8?B?RVlqeDRRdEVNRldLNUtNLzdrbnE1RXZOK093NmlLSnFBOVdpUlZyQjd3cTFo?=
 =?utf-8?B?UkdmSGhMYzhHQzZ0Rk55b3NnUnY5Q3ZWMzVtNUZsRHI1cnJrOWxNU1p6enk1?=
 =?utf-8?B?QjJVUThyMlJESmpjUW1ON0NUNXlPV2tLc2tseitjRm0raTh2alF6eG41a1J1?=
 =?utf-8?B?RitjdWUrcE9oSWdkdlVseHVVakRBNU9pQ1NFTXYzdE1zMXhZWk82WnMzWVJE?=
 =?utf-8?B?NUZMeXBaSitIR1VIbDgyMDFEQUVDSlBBNDYwODZBOEhXeUFlUm9jWjhwZFNi?=
 =?utf-8?B?ekFUbE4xWmpZTlBFeEpmaE9WcitmN3VudXNQWk15aUlFeHJKWTZpQnl0REVt?=
 =?utf-8?B?TzVadksvd0xvZjV6QUhRQktDclRMd3I1NnpuK2NhbnhEemNCS2ZwQkhNODZ0?=
 =?utf-8?B?ekl5aXcyWnNBMHQzZVBPYUgvT2VsWnVzWU9UczQ1UzNCUFJYYWVqNms0RVlU?=
 =?utf-8?B?cjJma25KejZFZC91cmVMRTNoWEhsMXRPV3BOWnRrU3BRUFZIemFMTG1DM2F2?=
 =?utf-8?B?bld6K2Z0Zlh3QVVYYU9pU09hLy93YWJWRG15MTJMLzQxM3lVbGcxS3o1eExx?=
 =?utf-8?B?NXZLVGtCUmF0K3dQSSt4NlJ0RUcwVkdtcGFxYmd2d0FpenQ0Yk5tckhpdDJo?=
 =?utf-8?B?MWQ1ZWpGcjlwb0RheUhTOHhaelRwbjdGQWpObkd3bStLRDRaU3VEMU1TT0p2?=
 =?utf-8?B?THkwUFQxaHMrS0Q3T3lUbXZaVTVWek9JR3dPc1JNdVN3K0cyTUtwRVVQTmJK?=
 =?utf-8?B?eW9ydHNWaVlkaFE2bTdoVTJhZGRhd3R2ei9XQ0pyNkNBNldIRHRZT2ozWGJz?=
 =?utf-8?B?ZjJRbXR1c29UeENTOXFwQmZZZ2RWS1lUN29wUWN2bEtUNWNueXlzVm5YYmJQ?=
 =?utf-8?B?SGJkTjZhMXcrQzFiNG1KYnJNVmp4Rm5CQmJnQ1NkaElmQ3FOYXhjbWVwTVpn?=
 =?utf-8?B?aHgvL09XWTNIaVBMWTY4Y3EzZllNS3NIczlCUW1QVVh4UDNCTEhydkpRM0No?=
 =?utf-8?B?MFdoMW5hWFpKUmx3dExUakNoYWxZd2swOW1xalFpWHlPRmJnVlZ0Q20vZWZz?=
 =?utf-8?B?bjhDZk9kM2lXSlZHeDh0elJoblhZdXJzM3I3VGh6SlhxTDc1Y0NEeGlob2RV?=
 =?utf-8?B?U1ZDVzBCMlJxQnFjRE44V2NUcVpMU2lRblFZMU9YVVRpZjVtLzZoRkxzbXVF?=
 =?utf-8?B?K0J5bWhzVUUxcEhycGFObjcyZXhlcDdIS0JlNFlQUzJScHZSTENUZHI3K2x5?=
 =?utf-8?B?WUlDR21ycUVtWkdQYzkvNUo1Y3ZVdzc1dTRwMnhSVXhjRkR1YVo4OHhuakNP?=
 =?utf-8?B?QlJqcEJOZFB3NlFTSys0WDVGY2JXMlRmaTlEVkNmbkNYdWRBWTAzVkVWKzZq?=
 =?utf-8?B?UXZiMmpNRlI4ZVZnYzlDWEdhSEFpQW1LRjFmTFh5YkVHdTJHRHpaN1FuaGli?=
 =?utf-8?B?dEh5ditQMW04NVlva3lyYzlESWRkUjBrazFzdFdKL1Y2QTZIMnJuY0hzOE96?=
 =?utf-8?B?RFZEbzU3TkpxdlJkemRVUys1V0c3NW9yWmlSU0cwRHJVL1YxbkNwbDQ2UFNu?=
 =?utf-8?B?eERuLzBZL0lETTBYUTBnMjdCNUpJTVZjRE1NZTM3YmQ2VDg1YXRqUDVQbm84?=
 =?utf-8?B?QnJqblg1TUdaR2JtTW43clNHVkRqMzlkSTA4TmxnT2VYQnNVUU85ZEZWQkhB?=
 =?utf-8?B?UlBmZEpOT1FhRnRKRXp5SXBnYjdKUzdFV3R4dCt2OVIwS2xLZTN0dVBDN0lC?=
 =?utf-8?B?RnIraDZMN2wrcGpEUFQxd0FPTnRJYng0NStBYnNOSGxxN29YWG5ZSy92bkZL?=
 =?utf-8?B?SWlMbWFYbFdjMjR2M1IzVlI3T0JlanNTSVNQeDVnQjI5ejFaNHZBdnRCS3Vu?=
 =?utf-8?B?Z2FlejdHckMzaVI5b25vcHV2UVl0NnlLNDVPNjh5NCtxWWg0aTFSNkVERkVR?=
 =?utf-8?B?OFBpY2htMWs5RHRrenk1NWRVemgvSVRoYVpKV3k0aU9pMjY4anJIaFFmWGdo?=
 =?utf-8?Q?d7XEeWl611PA4IbUaAk/iDw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 36effc11-ecda-496c-5b1d-08de18fdf33b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 04:20:12.4064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xi+6m8OSQtbAhJ9lH4EX9ekLQ+SKgejPKvrCplCgAEFUgrJACyFAtoMxIdFLcqwvfcdcZXIbMKBlO/lDL02A+jIWGxxWzroK/EHQDGx6qok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8323
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

Hello Tianling, You forget to add fmsh manufacturer to
drivers/mtd/nand/spi/core.c and include/linux/mtd/spinand.h files.
Without these changes your code should not be used. Regards, Mikhail
Kshevetskiy

On 10/30/25 22:07, Tianling Shen wrote:
> [You don't often get email from cnsztl@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Add support for FudanMicro FM25S01A SPI NAND.
>
> This driver is ported from linux v6.18 and tested on a MT7981 board.
>
> Link: https://lore.kernel.org/linux-mtd/20250824170013.3328777-1-cnsztl@gmail.com/
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  drivers/mtd/nand/spi/Makefile |  2 +-
>  drivers/mtd/nand/spi/fmsh.c   | 76 +++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/fmsh.c
>
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 152aa1a3783c..a7a0b2cb4b9e 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  spinand-objs := core.o otp.o
> -spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
> +spinand-objs += alliancememory.o ato.o esmt.o fmsh.o foresee.o gigadevice.o macronix.o
>  spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
> diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
> new file mode 100644
> index 000000000000..84a567919ebb
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/fmsh.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020-2021 Rockchip Electronics Co., Ltd.
> + *
> + * Author: Dingqiang Lin <jon.lin@rock-chips.com>
> + */
> +
> +#ifndef __UBOOT__
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#endif
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_FMSH               0xA1
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +               SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +               SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +               SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +               SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +               SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
> +
> +static int fm25s01a_ooblayout_ecc(struct mtd_info *mtd, int section,
> +                                 struct mtd_oob_region *region)
> +{
> +       return -ERANGE;
> +}
> +
> +static int fm25s01a_ooblayout_free(struct mtd_info *mtd, int section,
> +                                  struct mtd_oob_region *region)
> +{
> +       if (section)
> +               return -ERANGE;
> +
> +       region->offset = 2;
> +       region->length = 62;
> +
> +       return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops fm25s01a_ooblayout = {
> +       .ecc = fm25s01a_ooblayout_ecc,
> +       .rfree = fm25s01a_ooblayout_free,
> +};
> +
> +static const struct spinand_info fmsh_spinand_table[] = {
> +       SPINAND_INFO("FM25S01A",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE4),
> +                    NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +                    NAND_ECCREQ(1, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    SPINAND_HAS_QE_BIT,
> +                    SPINAND_ECCINFO(&fm25s01a_ooblayout, NULL)),
> +};
> +
> +static const struct spinand_manufacturer_ops fmsh_spinand_manuf_ops = {
> +};
> +
> +const struct spinand_manufacturer fmsh_spinand_manufacturer = {
> +       .id = SPINAND_MFR_FMSH,
> +       .name = "Fudan Micro",
> +       .chips = fmsh_spinand_table,
> +       .nchips = ARRAY_SIZE(fmsh_spinand_table),
> +       .ops = &fmsh_spinand_manuf_ops,
> +};
> --
> 2.51.1
>
