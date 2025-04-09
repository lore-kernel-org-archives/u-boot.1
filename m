Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4CEC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 13:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D9E837EF;
	Wed,  9 Apr 2025 15:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="H/uh5Lu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E02A88381D; Wed,  9 Apr 2025 15:35:52 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 617A38297E
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 15:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqiOX5PvrU5I/C+V971V3RXzQk7bV415kZuiywAOSKtcNq9do22CFGfplRXnR8hroWvKEZ0c+j687QzWcK5YKxRVZLlwTpXuhnZ/SKndjXVV04DE+vVaxkHvL9woFHutKCZl2istrdmD1MTDuimnBU9NCIM+4GItQzeY9LFFnqwNK7KECJGhLhVWIgv5Ttff5CutZhXHeLEOmelFY6VWC1kK3vPOPDzaVhu2KuY9InT/a4sg7drFGv6jVlwecfRJuarFa+ZsAs1zZaXCAEsLzz2pK88HYdAAGPsHkfcwcHaNGaJCW1/6kTo9d8eN/wLrX5PMs1yO9mmK/E1MpJjdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBRb0eNmV8FM8aIkwbw2RtC0f69gt2VEf4VsCWODoEk=;
 b=jh+6D8eB1Og3MH28ojM2rwtg+Lk3/qsIgEuK72iTW+9tDlKUy/owRIdiF3iqPn6OJEnIpxfQel10UmLDrRkvCIfRS1D23RmyP03amrB9XDCIq0Z7bpVw5eu1hYX+nKArAMYfKsUVkN3eFyr+QSuhfj2UPbtQQJiH3pGstOs+d/JNWqPPIPopZUNuEFpgJ6jWEfn1rPXAzviZOHVDTan3rD7fx/sd8m2JT5P2CWUQK3JyMeX9p9REMpgfFUgUPjaRb2ywpb40r0X1rLfbLKgk+H7EmcSyGWI94uaYSqDJt+qpUKuBbJ7Z2FbRoGacZ0YwYk1qha0MXc99ArjKIh2XEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBRb0eNmV8FM8aIkwbw2RtC0f69gt2VEf4VsCWODoEk=;
 b=H/uh5Lu2VX2vEuRkatAyDrsxoNA3iiERUQzAyJsPNlLo9MuwVtiqkzipBoFHSNtNjJJm0ISNcfR4/rpZ6zTlbS/c7W9/gw393pBcXBVQYTSKgNHKMwRp8GC0MVQ0s9KnhFcoWhkY87aIxuygvOlACUKZHyAO5cWQ26SIegy6sd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU6PR04MB11157.eurprd04.prod.outlook.com (2603:10a6:10:5c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 13:35:47 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 13:35:47 +0000
Message-ID: <53f32547-6758-49a2-8246-72b9046cac03@cherry.de>
Date: Wed, 9 Apr 2025 15:35:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] rockchip: binman: Use the skip-at-start prop in
 simple-bin image
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-9-jonas@kwiboo.se>
 <01e8a4b3-a77c-42ca-a4de-e744755a2b89@cherry.de>
 <CAFLszTgSeGN_+adh6VviNxYmVCGR_iOQN_igBbdEaXxDqKsb_Q@mail.gmail.com>
 <e7ac70c7-676a-4df1-b1bf-5c4bbbc31a1c@cherry.de>
 <CAFLszTgGfXmBrTu4RnSo13WE82W+E-bVrCrif48BbHFxzx-TFA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgGfXmBrTu4RnSo13WE82W+E-bVrCrif48BbHFxzx-TFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU6PR04MB11157:EE_
X-MS-Office365-Filtering-Correlation-Id: 248a4c69-7503-481d-f67b-08dd776b6f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0pGaisvbTJwWGF6RVFmazloRW8rOHBmNEpSNThYc0tpQlNJYzlYb3hKZEkz?=
 =?utf-8?B?R3pyQVRmaFQwcXptTmY5enE2YTl6SG9aT2dOdndRL2pueVhyLzR0U0ZpdHhL?=
 =?utf-8?B?VmNVYURqSVZ5QUR4SVQvd1BaaDM1ZW5XaUdGTndnZGRBQ2xYcHZHcTJSOFBN?=
 =?utf-8?B?UU8vVlNQT25qemplQnVILzdocXM3NUlrclBReW1pbVZpanR3anJwc0w3RzYx?=
 =?utf-8?B?SnRDbFY3YWVXSXV3OGNnQ2VQMURNTUIxTjZacGpmOEpkRWdZL1E3NUF2ejVs?=
 =?utf-8?B?SmxkQXhScHZkbTRYaGxBQmtVUUZFeTRZMlJmMXQwTFFXUmkrN1d2cmRoSzRy?=
 =?utf-8?B?YlB5WUUyTXVnT1FDdmhjckZsaVY4K3JidXhGTHkrMFNUVnRNU20xTGN6K0t1?=
 =?utf-8?B?ZkJvR2xOMDVyZUptbTlLMUNSSG93K0hTNHRtak16N09iUGVXN3NXT1puaUIr?=
 =?utf-8?B?L2xHaGl4NFp3Z244TWk2NnpLQ0xFYi9SUHVCUWpFcStPalFubWR1TGttZnhr?=
 =?utf-8?B?QXF0SnBFaFRMRTZZUVZlOXlHdHZOVTYzWFpJWXJnRXBtblVHMWlHcFk3Z0dz?=
 =?utf-8?B?TnZ5bUZpYlRIUHBHc1o5YlNhTWlldVdXdVVBVnI4MFpTeGJ0eDJhdVZFeCtM?=
 =?utf-8?B?WFJEQjd5dExYeG4xSjJBaStUTDZHVk9hbEgxTWNvZEVOMDQ4Z2ZxSFVYRU1B?=
 =?utf-8?B?N3duZ0dIbDc4Y2hlNVRiVmlyMUxJM1ZvQXgwaGVYUWRrdVE3OWx2OEw0dWZx?=
 =?utf-8?B?TnJ3RGNVdmF1UEFHaGhlK3RPMmhUak0vQ1A4WGhhNUJrSEtaWFIzK2hXUXNE?=
 =?utf-8?B?N3FGUEtVK2RaR0JhSURCWU9KOXFZdm5hcXVuN3pHOU9SVXN6SytwSU14Ykpy?=
 =?utf-8?B?S0FsWHFyL2ZXMGdoRk1XQWZXbktJamRlMm14dS9jL05TR0RGdUFOV0NzYXdK?=
 =?utf-8?B?cHB4M3FIaDQzM1Y0bm5zVFhaM3F1cXB0Vy9GZFk4RTVyblBvQUlGcXRnWGF1?=
 =?utf-8?B?UGRYQytPbGoxdnJnVGc4ZXQ0OGtXUGUyRytBUmIyYml5dGdlbGVqcGRBRmRt?=
 =?utf-8?B?NEUxQlFGcm9YbXYvNXg4dGFtczRjZGJsN1lpUWx6ZExkbDgvTlo1SWxpY0tm?=
 =?utf-8?B?dlVvaGpEekU5ZWt0SW5QS01QYzlORGQwTjBsM0oxVzQ3RS9yYlFJSUh5cTNx?=
 =?utf-8?B?Y2NmUVFnZXB2RXVSRmhqK1VOYkFoZ1FmR0s3QmRLN3lNVVFyK2hmdEE5RStQ?=
 =?utf-8?B?U3JMZGVtNEhVU05TTXJkNGV1blFrN1lNemJmR0FnS3QvanVvTEZCY1ZjTzZX?=
 =?utf-8?B?L1R5MnhWTDhaNC9oSXp5STVIL1BlVXZya0RkdTlxb2dOUUErY3l5T0tSZ2Zt?=
 =?utf-8?B?OWtsYTlLYWExdUF1ZThMajlKSWpWbS92UVNRZksyM3lBcDlEN1Y2bGsvd0hQ?=
 =?utf-8?B?NlNuc25rQjVvTjB1b2QyWkoxUFVYYTl3alFnMmV2L0lLUFkzK0JZTkFlSnJH?=
 =?utf-8?B?aWRscWZHNzZtWWt6c1cyUHVCdVkwdUVJazYvNEttWEt0bm1FRzQ1N0dHQjUy?=
 =?utf-8?B?NWwzRDU3d252ajFXOUNtVWd4Sy9NZmtPTXhKUTlkTnFKM2FPU0Jub1pHekZs?=
 =?utf-8?B?dXh1R3A2S0dndk9tZmJXTlJQc3NlWFlVajhPek5wU1kxSDlVckgyLzFoMnZx?=
 =?utf-8?B?b1ZEWlJRdUhHRSs4NXNReGNOQXkrd2JFOXVoSVQ4TDk1WUhDaDZBell2eFc1?=
 =?utf-8?B?cE9BNFVNR3QyaS94NkNzT3ovZUQ1ZkNSZjRwdVcyQjdEUWN4T0ZoZzN2ellD?=
 =?utf-8?B?amNxM1BJaEhHVnFuT0FxOUFRVnNzUi8rcmRObHJvR1l1UlJCWlZBa1ZDZUsr?=
 =?utf-8?B?M2c2SGR0MTJKYlljLys0NkRXdkpqVGxET2ZVSnJUUTU0K21IRDdTcFpJSlR2?=
 =?utf-8?Q?GTOuWjGKj6g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXpHNGptT2VueW80SHVVcGtIQ1FwTFlTZDgzSEY3d3piSFEyenlsUWxLaXV6?=
 =?utf-8?B?L3RYWTFpRW84UzJ1Vnp6bXZHbURQMWtGTk1oMXlVcENpWStyOHpGb1NNaG9p?=
 =?utf-8?B?K2pQY0h3ZGhZamJsc0VSUVIzSFhNTzlXd2pvMXlTVWxMbVQ3NGwxSWpUVnBr?=
 =?utf-8?B?UXZVRFoxNWJqQzVGZVZjQkRCKytlSFhyWStzSjdFVkc4c2hwYVRQWjNWcHo4?=
 =?utf-8?B?NTZtQ3V1c1h2dVlvZUJJLzlaMnlIMGxIeXpTRnFPbzI4M0tCRWZ6UWpoUUxP?=
 =?utf-8?B?RmZDMG5TcmE0ZU9hN2o1NnJFRGNPZUY5dlVhdklaby91THRkLzBjN0lvbStU?=
 =?utf-8?B?cUdiRTRCaFFFUnRmOFQ3R1lDN0laU1M4T3BRUnozUFVwOERXU0hnTjR0OUVp?=
 =?utf-8?B?alFSV0REN3p5OENsQ25rdDlRbFdTV1luRjlqWlo0TEliejd2cC9XTXJJNWkz?=
 =?utf-8?B?NU0rVUhKOXJpaHd0b2kxZ0I5ZGJkaXAvVmZwbFNvZ2U4RTVkeC9tTmtqK1lC?=
 =?utf-8?B?ZDY2ZGRNU2RhQWR1N0hacC9MaTg4aTRaNU9oR3kvM2ZTMHFsYmZrNkFscURL?=
 =?utf-8?B?UVFhSzFMU0xObFpRUEhtdE1uanFITm51SHhCaG83S21uQVlYWEdUT0lHNnND?=
 =?utf-8?B?R1A0UkMrbVNpbFFtdFB6cTdSdnNyeWIzQVVHa2l6cnRsVDA3UFprcHQ4bisx?=
 =?utf-8?B?bkJ0K08wTzNEOTdzQ1d5amdJYzJGNGNvUEVWSXFGNnhuVFVtUkI4VHBsVklT?=
 =?utf-8?B?SnlDaFRrSFAzYitMQnZ5N21mdm9EemFGT0xCOFpqdnhrbHkwQ1E1WDkzVk51?=
 =?utf-8?B?U0F3UXNCc0Uvb3VjT3Z0bHZVR2FkSUVLc0t0VkdMS1lRRG9vbHpDOEJkMnRi?=
 =?utf-8?B?RExtdW11ZWtoTjloZGN4M2pDWWFWZ2FuR3VvbjNGNkE3M2dFTEY1eWc4ZEU2?=
 =?utf-8?B?WlE2V2FYbWRhaHUxS24vWTd0V3ZOd1YxRzBmNDNwVjdKZmM5N3QrK21Qa01a?=
 =?utf-8?B?UFVUbnpFYUcrbFNJa0wwbUloMmdydVppc3ROZjNHOCs2RWtGNDREblRzR3Fs?=
 =?utf-8?B?ZkpzYzhWd1RSTjhBNXNJMlpnV2V4dWFWSHUyVTNqeEJ6VDBWdVlGV1p6azBu?=
 =?utf-8?B?S0hyempHNHlGS2YwNWlmakQ1SHBLT2d4aGNEMXQ2Yll5ak9CZE9RajE1eFRy?=
 =?utf-8?B?U09BTm41NHc1SEJRTDVSMVlNdXdEZUZuU1ROdy9rOVNpazFnODFvSS9KTDFF?=
 =?utf-8?B?UERuS2NXTDlzQmt5NVRnQTFOMmtQMDR5Uzk0eFNJVi9wOXFwbUxmMExiclhR?=
 =?utf-8?B?Y3FTU20vdmE2ajBISC9laXJMdm5YdTF2bUl1TkorbW5qWmxJVUdNQzUzY3dp?=
 =?utf-8?B?UnZtSW9tRnBFMlNOTzhGbUxyWnZTbzI2N0NYNXk4c1RsNXdnKzRyR05MeTlK?=
 =?utf-8?B?bTRMK0VMUjFYUTZCL2p5ZHJWenUrbUZ6MW51Mjg5QUIzVHBFWlZxYVdjRkRo?=
 =?utf-8?B?ODhZeDIzT0RQOEFMaUdQUWFxb0o3RUNyWmdFSDNGQks1d1FlaEZRZGJLUFhL?=
 =?utf-8?B?MXgybUxpbi95bEJpZ2tyN2EzSDhFSGg0c3NrWGJ2MEdmRTVYNWpJVFBiQlY4?=
 =?utf-8?B?RjU3eFc1YlB5akpzQmMvYVA2WHBzZ21wWUFKdkdsc2JkSXF1WEJSejB4RTY4?=
 =?utf-8?B?Z0doaHNtdHVjdnIxcmNpcWpGN0NFbE1ISWQzMy9IdUFlb0RwY3luT1BtY2dm?=
 =?utf-8?B?aDhJdjc5NWU2N2QvTkxvTXV2U25iT2l3dWxVWEtkeVVxNEJVb1B6SkxlQ1JJ?=
 =?utf-8?B?YTBydWdIWjR5cE5KenphWFJuN0tYbXpiUmYxd0dEalhCeHRQTmZQSmtwUmJ5?=
 =?utf-8?B?M2FpV2tUV1JNbWdFc0lLWGF6WG5xSjFVTlNpOWFhUmZXeE9JZ0crS21vUEdk?=
 =?utf-8?B?M2FjRkplR1ByYU9pRTVOejJQd0R6NmJzbGJITjBWSTlTSWlFSWtuV3NHUDZP?=
 =?utf-8?B?cVpOSmVCclIwYUpGOC9aL3N1WHovOWROZVpaeTJqSW1meW9mWDRxVEJxcWg4?=
 =?utf-8?B?TDA2NWRpT1dpVVhsemM0L0FraE5PV0swcFhuUE9OVWdUcUsrS1pneDdSays0?=
 =?utf-8?B?SmFvNXJJY3NmK01lOXI5S2U1QVdNNHFNQmJjL2FNQmVVRkh1ZDhSZDFWZStj?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 248a4c69-7503-481d-f67b-08dd776b6f4a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:35:47.0837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bItRFXMS1NOfOlHnFLfGSPlFrHJDNmTVgn5WGmK6ogHS//0KLVyYsuTHDUErXBrDvbLTu1jN9p8KljGAtAyQ6EUxUGU+i97aKZ4IihA3He0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11157
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

Hi Simon,

On 4/9/25 3:33 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Wed, 9 Apr 2025 at 07:32, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 4/9/25 3:22 PM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Wed, 9 Apr 2025 at 04:57, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Jonas, Simon,
>>>>
>>>> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>>>>> From: Simon Glass <sjg@chromium.org>
>>>>>
>>>>> The simple-bin image is normally written to MMC media at block 64, which
>>>>> is a 32K offset from start of storage media.
>>>>>
>>>>> Set the skip-at-start property to 0x8000 (32 KiB) so that fdtmap and
>>>>> other embedded binman symbols in the output binary is referencing image
>>>>> offsets correctly.
>>>>>
>>>>
>>>> Shouldn't we have this commit BEFORE we add the `fdtmap` node since we
>>>> know it's wrong before this commit?
>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>> ---
>>>>> Changes in v4:
>>>>> - Drop defconfig changes
>>>>> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
>>>>>
>>>>> Changes in v2:
>>>>> - Move this patch to the end of the series
>>>>> - Drop 0x8000 offset for SPI
>>>>> ---
>>>>>     arch/arm/dts/rockchip-u-boot.dtsi | 3 ++-
>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>>>>> index fb38b7b80c43..65b81bf58626 100644
>>>>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>>>>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>>>>> @@ -154,6 +154,7 @@
>>>>>         simple-bin {
>>>>>                 filename = "u-boot-rockchip.bin";
>>>>>                 pad-byte = <0xff>;
>>>>> +             skip-at-start = <0x8000>;
>>>>>
>>>>>                 mkimage {
>>>>>                         filename = "idbloader.img";
>>>>> @@ -178,7 +179,7 @@
>>>>>     #else
>>>>>                 u-boot-img {
>>>>>     #endif
>>>>> -                     offset = <CONFIG_SPL_PAD_TO>;
>>>>> +                     offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
>>>>
>>>> This is confusing. The documentation states:
>>>>
>>>> """
>>>> offset:
>>>>        This sets the offset of an entry within the image or section containing
>>>>        it.
>>>> """
>>>>
>>>> My understanding is that it should be relative to the beginning of the
>>>> image but this now needs the knowledge of where it will be stored on the
>>>> MMC device (via the value in skip-at-start).
>>>>
>>>> Why is skip-at-start automatically deducted from offset?
>>>
>>> This is how binman works[1]. We are trying to use the feature designs
>>
>> Why is it deducted?
> 
> Are you asking why skip-at-start is deducted from the offset?
> 

Yes

> Regards,
> Simon

