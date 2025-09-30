Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC01CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 13:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EDEA83071;
	Tue, 30 Sep 2025 15:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q+8fDL77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 309A2832AD; Tue, 30 Sep 2025 15:28:57 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 208BC802C1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 15:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnX4FTgHRtqFRGzNUw3xg24bUm+ZQX93zefBR4wAc+EVFaulY4qJgiddk8YyiHM3B8RTLYAQg4TOSwPvXZQvZoK5xCLo4RMJa2ZgpRLOhtKlC4lHOzlmNJs7vXl+UTOA/1bSgYMTYWmOfGm4C+QidZM0CfGQGu/ozzXOdo8lrWmoAV7s8p9Laa5m90cCcp/QEv668kiftUw0xDEWJcYfLAGIrg1gvlNs9xnamvvD2CY9CBFcwFEeU7lpTPI2x2huQxLTEQw0PjJjKdtezpC8V5E+m6xtSRJxugWFTcNvzBOm4eC2zJ4H90akINdvDe5TCjay5wpnfU4rDAxhqwLSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlDvWavENYXJgzY6S2GYP0ZYQmQuHhtTpWoygjGw/3E=;
 b=BDhZ6IaWKbsWpzNDZrjBihK7aOmxYBjuihpbAQvGck9GZuAGCLzMWpb/oPD8zP88xP/mJfAP2jNcJLBef0vFGKMMugUsYGHZM65HDdNirsUC1X+LbPJBHZysRIgK7CMeqK7OoOKElbzJ6iG9lBcsGfcC+6pffhO1QzKmDbiNjggZwf+TJsXMs9E8feUYwSeR9PkKyxvHJgwjNmE96AeHcJKKYeSYDXaVvZJVVn9Xnfa1smnAiCCyTVyzKPXcTqaZQJ/IqOMLspm81nixh5APa4V3Ig19QTIHm1hbaxOsxvfuKGglEOs3Ggol8N4dWzO9QdQ6UQOqtKOF694mgfabAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlDvWavENYXJgzY6S2GYP0ZYQmQuHhtTpWoygjGw/3E=;
 b=q+8fDL77qJCu2iX2JXfyhm0fBOcxjbQojNOTef275tNUQSFPp7OVFAiBXJill2ECqiDJYq3vcZsWicCTSHYgNQN0T1nWmRGrAZpRfTxToQZGBSOE/jI8vc0+lEIM4K9fR7wGpmJ01OoKdcXRMBf0fqlD+ejK+gp7tm/Ku2RV79g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 13:28:51 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Tue, 30 Sep 2025
 13:28:50 +0000
Message-ID: <2e6c0670-0ecf-47b8-ab86-5fa31ae3605b@amd.com>
Date: Tue, 30 Sep 2025 15:28:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] env: spi: Fix gd->env_valid for the first write
To: E Shattow <e@freeshell.de>, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.denx.de, git@xilinx.com, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
References: <7a6ffee423f45507af680c63a86cc50fb9e3a5df.1757489188.git.michal.simek@amd.com>
 <1684bd0d-b831-43e6-8713-95a2675957db@mailbox.org>
 <39f7c9df-9a8a-447d-8689-4f99676fb1e8@amd.com>
 <48de987c-1255-4c90-8477-964d153809d3@amd.com>
 <401851f4-36e7-4e11-9d2e-e85753d916bf@mailbox.org>
 <e436dd80-3693-472b-b9f6-5d27a8310397@freeshell.de>
 <49902e34-a01d-422b-bd60-e97aef7d859e@amd.com>
 <88692c72-1c86-45d3-bf2b-1a21debc5785@freeshell.de>
 <a69aecba-186e-4ce4-ba8f-2c72b1d94267@amd.com>
 <b5d83815-a4cc-43d1-a770-4553c3431e9e@freeshell.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <b5d83815-a4cc-43d1-a770-4553c3431e9e@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR03CA0049.eurprd03.prod.outlook.com
 (2603:10a6:803:50::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a0099e-d17c-44a6-312d-08de00254ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVkxMDdqWmJiSHFmRFlyY29JKzNtMnRrVG5TRkNoaitHdk44OGVCSFl1Wm5C?=
 =?utf-8?B?ellRTlFVV1JWZkFIWVZyNmxLdU9wY0JNbDJHK1BJcmIxU3ZhTWlBclpFWHBq?=
 =?utf-8?B?Y0w5cktDTFRBdDhZOHZJNUE5QWRIQm5Pa0pETGFxT1dzNXo5SXRUaWQ2ZktW?=
 =?utf-8?B?U2Z5NnF0ME9hcjR6QUxTRnBWbmlVQnR1dGYvRWxzdVhtanFLYzNwWUpyZ3R0?=
 =?utf-8?B?RGFMZ3lDQTRQaVRTbG1IekJuNFhCSktXWnozWlZwMm4vc3RncGxybUpWM0RH?=
 =?utf-8?B?RzRtUlJETjNXTytncTlsV1dIci9SZExtbUNiU21jSC96Y2xjMW5HKzhZWE9B?=
 =?utf-8?B?QkJoR2N1VkxtVjhEd3YvN0NiT29hSkdpd1V6SzdyUUkwVUd2OXVycEdPaUR0?=
 =?utf-8?B?TjBQWS94aHViWjlqU3VzbjFFMDdPTm9FUkIrMERlODFLcGZVYVhZZU92TEtq?=
 =?utf-8?B?QmM0dHhKN3g3VVBDc3VwTHowa21aM2dBbDBLRFFucEsyRVBxSDdsaWxOamtY?=
 =?utf-8?B?SnFoS3ZhN2tnU1N3SEY3OTBxV29iT1FVT2NWMnQzNk1PQmFaS2M5SXc3SWhq?=
 =?utf-8?B?VE5JUy9SQ3k1VEJJbDF0TXNnaW04WlpJMzJHOHkvUTFsVzlsRXlFS0FzTFdi?=
 =?utf-8?B?ek1pZzVyc1RtUmRSUWxiMDBKcktOZXgraFNHMEp0WVFENlRQbDZGQStXNzU3?=
 =?utf-8?B?VlJMbVNDVDNhMmxBT3RrMHNvWGk2aUt0UlczTGU0Y2RKVVJpYlV2dzNZNGhH?=
 =?utf-8?B?NDFtM1g0WGlxVHNHckIzRmdHYXNEb2toVDJKQXdEVitodVVQWHluTzlMSERj?=
 =?utf-8?B?UzNSVDdmSGVmd0xGb2VrY0RNK3Z0dGtFSlB6ei9pcjMzajVQVkhLbXZsakpl?=
 =?utf-8?B?NnRWd2w0RlN6dVdiNUw0L2ZSaGRXYlZpQjhHRzAwMjc4SDlmRTN0ZE51RjRD?=
 =?utf-8?B?S2pHZ2NYdUVGWXROOEpOU0ZkYzlpZXlrSThBTmoxUGhOWWpEWnphQWZRVis5?=
 =?utf-8?B?anY1RklKVTM5ZDdYWkJnMllzVXdXVWU1OW9BYzVsUnBNWXBpWFU0cW5sZjFF?=
 =?utf-8?B?NUthU3d2QW9zZjUxenBZem5VckprcTEzWUhCd2ppMW5SWkNUUGdadVpFK0Nl?=
 =?utf-8?B?RzFqcG85Vmo2R0VrUGhqczQrZ0dGalRQdzRCdVVFNWRCSjlySm5IWjVNM01X?=
 =?utf-8?B?QlZNS0s1WEk2NG9PSittTG9rMWttd01GRHR2RVc1NkNOdE9NZ3o5dHZFOTgy?=
 =?utf-8?B?WEdueElkYmd2UGtvbTFhSUZOeFZkWFJQeXJYczNDY3lYcUVWTklnVU9SeXhE?=
 =?utf-8?B?NXVVcFVSeVlxNFd1elYyYlBUeHpHNVdJZzNORmIvZFZKQ1o2REdsOEdCcnNR?=
 =?utf-8?B?RkE4NU5wT2ZIdkt3MldudWh5NUg3dFMvZzdLOVNqUG5MaXJaMXdMOU9XbFpz?=
 =?utf-8?B?MnFQc0lUdE4zQ0RwaGlFOUFWTC91OHJabUdUZjgrUVovT0trNlJacVNQR1dK?=
 =?utf-8?B?dHkzY0tYNEZUa2lqRUxlcTRJNGgwWHNjdW4wdG9qVWJQbmVRYWJrZDJYWC9R?=
 =?utf-8?B?eURUSkpxdjVBWW9YMktXeTd2VkJRNGV2Ti81VDRBZUVueE1YZEV4YWovcUdJ?=
 =?utf-8?B?WUY5clkwV3dUTThHNE83d1FESy9rZ2JEWUdFTU1ocjQ1V1ZLbkZqZDVFaFRG?=
 =?utf-8?B?b3U4d2hsTHRqV2x0bTh2ZmJCbUlISGllQ2tYTUcwZlE2eVZTNWpxRmxrTG9y?=
 =?utf-8?B?NnlWeE0wdWQ0Vk85OVcvM1d6VHlhaFQvcXRDRkdFejhMRnZCUHh4TTVsT0J6?=
 =?utf-8?B?SEM0SW5PUS82WFNHb1Y3eEVUQ1AxSDZ3Mjd1d2VaT2ZGK0lzUEFrMFluMjZm?=
 =?utf-8?B?VUFwUmR1RnJLUUFEYlBzV2lXVnc1ck0xdmo5Nm92OFFhTFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVhJN05KUElMK3pNcUpWb1V2M3Irei9XcysxaXd1ZnpjTDhwYlh2cENKOGN3?=
 =?utf-8?B?VXk4eENBNkhqMTV4RUF6ZmNYN3MxODg1L01Lc2g5TlVXbXR0VlZlUmVBc0oz?=
 =?utf-8?B?dlJ1Rmd0NkRvTEZSSXU2cGN0aW1EOGxCSVJCY2FxbHBvYk5pbk5vOEpLWnIv?=
 =?utf-8?B?bi8rVkt3TlYwUFI2TVpyQU5obHcwdXNteGJoeDg5WUFoWGRPTXhKM0RML0s5?=
 =?utf-8?B?S3RRUURNYkZPWldUMlhReDFzcmJ5VTl1WDFaZ1lvK21lVFNEcWxxd3FkYlcx?=
 =?utf-8?B?SFZaK2JhMk96SlF1ZUtKajR5RXRYa0FZeWpoZXl2a1ZOV2IzUUhOU0RVVm0v?=
 =?utf-8?B?UkloOWJNa3N4N2NXYjhjdzJjS051U2x0V055bVN6WklyajA2TXRNNEp5d3Yx?=
 =?utf-8?B?Um9NNkpWN3pBcXdkekQ2aFFIWUFkTzZpQ3VoVUxIeWs4K25EeXJPMDFkNlVC?=
 =?utf-8?B?U2ZFYXM1SDZ2U09UbVpKUTBWZWNtbnp6NHoxV2g4U3Vjc0UrTW9MZkIrWlBo?=
 =?utf-8?B?bktoLzlGYmxmL2Y2eS9DUWVGVkE0ZE5CZnJvTWwxdkZTUTM5bFpDTkIxQzRS?=
 =?utf-8?B?d3Jqc0xpRmNiSmh4cDdqN2pBUkZPR2lWMUJOMmNMWlhNRUxKSjdGZW9kY2t4?=
 =?utf-8?B?c0dnZ3pLN1Zlb2d1TVBjYnJrZW1raEM5YmIraTFZQ2xWZGFBWENESlNZbmNF?=
 =?utf-8?B?NEhhd2VaSi9RZGZzY1JlYitSQ1JrOHo5UEx2QXhHM2NnZXJkTmR0bXp3Unk4?=
 =?utf-8?B?QlFTVXY1alhGWmp5aXVoa3YwaHpsUWMzemhJRTZya3hkaEJwMG9vTk05SFJm?=
 =?utf-8?B?bXlvN2gvQitUWEFhZE54NWJyNXZhNEpqY2tPZGJZeGJRa0tRSXpEa21jQTJ1?=
 =?utf-8?B?aUR3UU91dVhVa0NzQ1FwVEJrN1ZtQmk2SWQ0SHdUOG9vdHRnaHhpamkwZjJE?=
 =?utf-8?B?d0pyVFpZbE1hQ0JEU2d6MWt2b0RjTElDRDQ4TVF6U0l1MlZxUHIvNUZkVWVv?=
 =?utf-8?B?MnBuT0M3bEt1cGhHblYrZ2RiZmdiYTlicVQveDcvaE5NRXV4b2xpWEE2bFlF?=
 =?utf-8?B?QUtzaGpOb08wRWNJUUxaUWIvak93RXZmb01DRmZYV2h0QmloL1FZQ2NpZGlo?=
 =?utf-8?B?UEErMmZkSDRvQ0lRSXhUcVZmU1hxSk5rNVhXT0JHMDRpNEwzRi82WHZCbnh6?=
 =?utf-8?B?YTdwTTZBNDZQNnc3Yis0MHk1NktHalpISnViRDBzNlIyUDhQdGNqUWNXYTVo?=
 =?utf-8?B?S1AyMStkekpheFlIZ1ZVY2ZoUHlQM3JOeGViQVZseFMzN1U2bytwRU1kYjM2?=
 =?utf-8?B?bVdHZW9tWDc1N1FVSUo0TkJwa0laTFUxcnF6THkrVGROSmFkUXZRRDY3eWRO?=
 =?utf-8?B?V3k2eWJJNExQK2thT3B6NXF6NXh3SDd6alp0TDVZYU1WUnhXSVhhVXJnMWti?=
 =?utf-8?B?NTNKYzA1WnIwUUpqY1drQkF1VGxROU1QTmVLREhKQ0VkQktzOFpoeHZzWnFO?=
 =?utf-8?B?OXVQWTFpQUxBSjRKM0FxU3M0dW1LUUgreUJ2and1aVlTUnp1aUJ6Vi9kOVhi?=
 =?utf-8?B?UVBKcTNuZkVtVWhaK01ERDgrSWhXN0w3aUthaXMxLzVtZ2Y4eVUwZ0x6YXNu?=
 =?utf-8?B?WCsxZGhpbExzZXNBQWgycitkeVN2MGN1dGtTR1lTd05BT3hycjJ4dzNkTVJE?=
 =?utf-8?B?cmhCaFpFRFBub1duS1FLbm9XaXA4Z1liYVpxbk4wQVRiMVMwUTM0Ny96bi9y?=
 =?utf-8?B?ZkM4djJxaWVFaDhSa0pTK0J1OFJwN0h3ejBETmIzaVFHckNzS2VIQ0l1ZDNh?=
 =?utf-8?B?Q0VGWTU3aUR5QmNqOFhyMkhhQkhPckxjbng3OHdQR2xrVytQMVpqVUdFQmc2?=
 =?utf-8?B?VlpWTmVzQXNGQ1lxNzlyZ0lOYVZOQ09WTm12UFl1ZXVxN2Nvb29rZE1sVVND?=
 =?utf-8?B?UlBIMUViTmxQQWY2VU1xa2U4MC9aSnViUXhBN2gwK3QzRDN4WmprNmpxTEp2?=
 =?utf-8?B?bkhIdCtYb0dTcW82UUErSE1JRFRqZVM0UjlTLzE1NzlWUnRZKzZTbFlsR2Y2?=
 =?utf-8?B?Zit0K0pCNVl4aHVpZHlKSjNMK2QvRE96RVl4OVR3amF6OGhTM3R4VXB0c01x?=
 =?utf-8?Q?6HgNpO94L5xMX5xoeOvBCgSTD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a0099e-d17c-44a6-312d-08de00254ada
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 13:28:50.5699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUolNGoUaLXvObAL8INbc/SuofochY8lIQ03ZsiB21vgc1asAbSa6pNZLnJXUpRf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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



On 9/30/25 02:32, E Shattow wrote:
> 
> 
> On 9/29/25 05:36, Michal Simek wrote:
>>
>>
>> On 9/29/25 11:49, E Shattow wrote:
>>> Hi Michal,
>>>
>>> On 9/29/25 00:08, Michal Simek wrote:
>>>>
>>>>
>>>> On 9/23/25 23:18, E Shattow wrote:
>>>>>
>>>>>
>>>>> On 9/22/25 07:51, Marek Vasut wrote:
>>>>>> On 9/22/25 4:02 PM, Michal Simek wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 9/11/25 07:40, Michal Simek wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/11/25 05:28, Marek Vasut wrote:
>>>>>>>>> On 9/10/25 9:26 AM, Michal Simek wrote:
>>>>>>>>>> In case of ENV_INVALID (uninitialized variables) the first env
>>>>>>>>>> location
>>>>>>>>>> should be used for storing variables.
>>>>>>>>>> That's why change the logic how env_valid is setup to be aligned
>>>>>>>>>> with
>>>>>>>>>> offset calculation.
>>>>>>>>>> This will also fix the print about Valid environment is showing
>>>>>>>>>> proper
>>>>>>>>>> location where variables are saved for the first time.
>>>>>>>>>> And also fixes behavior where the first two writes were going
>>>>>>>>>> to the
>>>>>>>>>> first location instead of the first to the first location and
>>>>>>>>>> second to
>>>>>>>>>> second location.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> Changes in v2:
>>>>>>>>>> - Simplify commit message
>>>>>>>>>>
>>>>>>>>>> Origin commit message with more technical details.
>>>>>>>>>>
>>>>>>>>>> When both location for variables are not valid (or empty) gd-
>>>>>>>>>>> env_valid is
>>>>>>>>>> 0 (ENV_INVALID) which is setup by
>>>>>>>>>> env_sf_load()/env_import_redund()/env_check_redund() calls.
>>>>>>>>>>
>>>>>>>>>> When saveenv is called in case of SPI env_sf_save() is called
>>>>>>>>>> which
>>>>>>>>>> contains logic which describes new/old variable locations.
>>>>>>>>>>
>>>>>>>>>> if (gd->env_valid == ENV_VALID) {
>>>>>>>>>>             env_new_offset = CONFIG_ENV_OFFSET_REDUND;
>>>>>>>>>>             env_offset = CONFIG_ENV_OFFSET;
>>>>>>>>>> } else {
>>>>>>>>>>             env_new_offset = CONFIG_ENV_OFFSET;
>>>>>>>>>>             env_offset = CONFIG_ENV_OFFSET_REDUND;
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> In case of ENV_INVALID option the first location is used (else
>>>>>>>>>> part)
>>>>>>>>>> and variables are saved with ENV_REDUND_ACTIVE flag.
>>>>>>>>>> The second location flag is rewritten to ENV_REDUND_OBSOLETE.
>>>>>>>>>>
>>>>>>>>>> And
>>>>>>>>>> gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID :
>>>>>>>>>> ENV_REDUND;
>>>>>>>>>> is executed. env_valid is ENV_INVALID that's why ENV_REDUND is
>>>>>>>>>> setup
>>>>>>>>>> but that's not correct because the first location has been written
>>>>>>>>>> and not
>>>>>>>>>> the second one.
>>>>>>>>>> That is confirmed by
>>>>>>>>>> printf("Valid environment: %d\n", (int)gd->env_valid);
>>>>>>>>>> which is showing number 2 (ENV_REDUND).
>>>>>>>>>>
>>>>>>>>>> That's why change the logic how env_valid is setup to be aligned
>>>>>>>>>> with
>>>>>>>>>> offset calculation which also cover the case where initial
>>>>>>>>>> state is
>>>>>>>>>> ENV_INVALID.
>>>>>>>>>> Then print about Valid environment is showing proper location
>>>>>>>>>> where
>>>>>>>>>> variables are saved for the first time.
>>>>>>>>>> But also it is fixing behavior where the first two writes are
>>>>>>>>>> going
>>>>>>>>>> to the
>>>>>>>>>> first location instead of the first to the first location and
>>>>>>>>>> second to
>>>>>>>>>> second location. Alternation is happening after it.
>>>>>>>>>>
>>>>>>>>>> v1: https://lore.kernel.org/
>>>>>>>>>> r/03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com
>>>>>>>>> Sorry for not being clear, the original commit message structure
>>>>>>>>> and
>>>>>>>>> technical details were fine, it only needed slight rephrasing, in
>>>>>>>>> the original form it was very hard to understand. Can you please
>>>>>>>>> reinstate the original commit message and only clean it up
>>>>>>>>> slightly ?
>>>>>>>>
>>>>>>>> Can you exactly point me to part which wasn't clear? It has a lot of
>>>>>>>> details about flow and obviously it makes sense to me that's why I
>>>>>>>> would like you to point me to exact part which should be improved.
>>>>>>>
>>>>>>> What about this?
>>>>>>>
>>>>>
>>>>>>> When both SPI environment locations are invalid (gd->env_valid ==
>>>>>>> ENV_INVALID), the first call to saveenv writes to the primary
>>>>>>> location
>>>>>>> and sets the active flag. However, the logic for updating gd-
>>>>>>>> env_valid incorrectly sets it to ENV_REDUND, which does not match
>>>>>>>> the
>>>>>>> actual location written. This causes the first two writes to target
>>>>>>> the same location, and alternation only begins after the second
>>>>>>> write.
>>>>>
>>>>> nit, the use of word "alternation" here reads as splitting (no
>>>>> duplication) the data one-by-one into multiple targets. I would give
>>>>> the
>>>>> game analogy of 52 playing cards and alternating to deal the cards to
>>>>> players, each player gets one card in a sequence of alternation; if
>>>>> there is more than one player in the game then no player will get all
>>>>> the cards from the action of dealing the cards.
>>>>
>>>> tbh before this patch I though that both copies are the same but that's
>>>> not how it is implemented.
>>>> It is switching from Location A to B and then to A, etc.
>>>>
>>>
>>> Okay. That is also surprising for me.
>>>
>>>>>
>>>>>>>
>>>>>>> Update the logic to alternate gd->env_valid based on whether the last
>>>>>>> write was to the primary or redundant location, ensuring the first
>>>>>>> write sets ENV_VALID and subsequent writes alternate as expected.
>>>>>>> This
>>>>>>> aligns env_valid with the actual storage location and fixes the
>>>>>>> alternation sequence from the first write.
>>>>>>>
>>>>>>> With this change, the "Valid environment" printout correctly reflects
>>>>>>> the active location after each save, and the alternation between
>>>>>>> primary and redundant locations works as intended from the start.
>>>>>> Yes, perfect.
>>>>>
>>>>> I do not understand what this description is saying because alternation
>>>>> of write operations to multiple targets would not be redundant.
>>>>> Alternation with the meaning of "fail-over" is similarly not redundant.
>>>>
>>>> How the code is written is that you have location A and B.
>>>> And when you call saveenv variables are written to A.
>>>> And next saveenv variables are written to B.
>>>> Next to A, etc.
>>>>
>>>> It means unless you call saveenv twice you never get data in A and B
>>>> equal.
>>>>
>>>> It means it is not alternation of write operations to multiple targets.
>>>> It is alternation of location where one complete write is done.
>>>>
>>>>>
>>>>> An alternative method has the meaning of "do something else, do not do
>>>>> this". In the common use, an alternative may have the meaning of "do
>>>>> something else if needed as fail-over from what is first being
>>>>> attempted". Do you intend for the meaning of "fail-over" and
>>>>> "duplicate"
>>>>> or "duplication" where you have written "alternate" and "alternation"?
>>>> I am not a native speaker but the word alternation between A/B sounds
>>>> the best for me.
>>>> Feel free to suggest how to describe it better.
>>>>
>>>> Thanks,
>>>> Michal
>>>>
>>>
>>> This is not easy to describe with a small quantity of words. The common
>>> phrases are "taking turns" and/or "round-robin".
>>>
>>> It is clearer to say what this is not, as:
>>>
>>> "... results in alternation of saveenv location with each invocation.
>>> Data is not duplicated or striped between locations for any single
>>> saveenv invocation."
>>>
>>> I like your explanations, you understand the functionality and can
>>> describe the problem clearly. I just do not expect that functionality
>>> would be useful so without additional context and full explanation it
>>> seems unlikely to be what you say it is. Thank you for expanding on the
>>> meaning.
>>
>> What about this full description?
>> M
>>
>> When both SPI environment locations are invalid (gd->env_valid ==
>> ENV_INVALID),
>> the first call to saveenv writes to the primary location and sets the
>> active flag. However, the logic for updating gd->env_valid incorrectly
>> sets it to ENV_REDUND, which does not match the actual location written.
>> This causes the first two writes to target the same location, and round-
>> robin switching only begins after the second write.
>>
>> Be aware that data is not duplicated or striped between locations
>> for any single saveenv invocation.
>>
>> Update the logic to perform round-robin selection of the environment
>> location
>> based on whether the last write was to the primary or redundant location,
>> ensuring the first write sets ENV_VALID and subsequent writes follow the
>> round-robin pattern as expected. This keeps gd->env_valid consistent with
>> the actual storage location and fixes the sequence from the very first
>> write.
>>
>> With this change, the "Valid environment" printout correctly reflects the
>> active location after each save, and round-robin switching between primary
>> and redundant locations works as intended from the start.
>>
> 
> Michal, great and we can condense that to terms of location (and not so
> much write operations that are now the most confusing word use)?
> 
> My edit is as following:
> 
> START
> 
> Update the environment location selection logic to perform
> {alternating,round-robin} selection of the environment location based on
> whether the last write from a call to saveenv was to the primary or
> redundant location. Ensure the {first,initial} {write,call to saveenv}
> correctly sets ENV_VALID so the subsequent calls to saveenv follow the
> {alternating,round-robin} pattern as expected. This keeps gd->env_valid
> consistent with the actual storage location and fixes the sequence from
> the very first write.
> 
> Prior to this fix the {alternating,round-robin}
> {switching,change,assignment,selection} of locations would begin only
> after the second call to saveenv.
> 
> With this change, the "Valid environment" printout correctly reflects
> the active location after each save, and round-robin switching between
> primary and redundant locations works as intended from the start.
> 
> {in absense of a cover letter then insert triple-hyphen here so git will
> ignore the remainder with more technical details not intended for the
> commit message}

Commit message is IMHO location where technical information should go.
I can't see any reason to skp them.

> 
> This corrects the existing behavior that when both SPI environment
> locations are invalid (gd->env_valid == ENV_INVALID), updating
> gd->env_valid is incorrectly {selected as,set to,assigned as} ENV_REDUND
> and allowed the following call to saveenv to target the same location as
> the first call.
> 
> Note that data write operations are not duplicated or striped between
> locations for any single call to saveenv. The location switching is
> being done between completed saveenv operations.
> 
> END
> 
> Here also are my notes and advice about word selection as might be
> suggested from the above:
> 
> "following" may have a double meaning of both being a sequence and being
> a copy of or adjoined to.
> 
> "subsequent" is more precise than "following" but not as common for easy
> understanding.
> 
> "alternate" if you want the meaning of A-B-A-B for two locations, and
> possibly A-B-A-C-A-B-A-C-A-B-A-C (alternating, non-circular order) for
> more than two locations.
> 
> "round-robin" if you want the meaning of "A-B-C-D-A-B-C-D-A-B-C-D", in
> that there will always be one-or-more locations taking turns in circular
> order.
> 
> "the last write" can have the double meaning of "the previous write" and
> also not the most recent write operation, but I figure this out from
> context these two concepts are equivalent here.
> 
> With this I have focused my attention to give possibly too much
> information :-)   Does that make more sense or is it less clear?

M
