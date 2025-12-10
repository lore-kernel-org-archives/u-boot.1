Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D5AD3C54A
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 13:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4828D8389A;
	Wed, 10 Dec 2025 14:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fbWXLnw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F35B580433; Wed, 10 Dec 2025 07:09:43 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED4C583A35
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 07:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3QL81wrXJDZebCDNT10mvUa+Aj2kC9fhcS5a2kyx2IiEq3m/QKgkwyPgYmtIFU1x++1YYhANbM1TCI/dZLA7HFP+XEAC5eYYnRHgaJZKnYJKLVw+chWkDnLhxf+cx10BnGG56k8QiAWjZ2aT4Q/Oz0S75rMJ0KTuzH3E0GR6pssOs36z0fAmivR9KNoRSIxnji0d87rXrbOuIx3uXrh17J99GE7wExbJmawufqFUK6p9rvNbcq0GhbDAC6KoRI1a0frkhWXbtKrGRLHBRhrq8v0DvgvO4ba5QJsHND/7/WL4KRjIrUg06GRT9JxfBfYRvb8DvdYHSes/q4b95ndCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPkGtvHVOKLOmmk1WFt5LfFqpv4+mk2sgzerXkV0T5o=;
 b=d7rXOjCvilGE1Y9rMuunw+FFF1UH4Q125HJppbvFeqogpRnZ3WVVaqEiPd9o2NL7YeucDinWHLqaBF9tL80igxVZLEfyZalJJlgYZiZVmmhLpKHrvd0vA9fN1cApKmWQQn7O4WPVxK7FFO4UUSUjT9Xam1/tEUVGTtb8mitKD8Ise6g+1uDjwlKs5cw1I5OvHhlyAftNqg5WmMxO+yoLoQyfwbKo1c72e5H/5BYTUgspWiwQtTqhtQt0k08iryNN5CYG0onvzdCz16f5fywsFRiHeeLmUv3ht0kniU68/I/1oMsfFvlZhdBLUAHW7Rh9O7Dvf1kdOSf66zX7KF2/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPkGtvHVOKLOmmk1WFt5LfFqpv4+mk2sgzerXkV0T5o=;
 b=fbWXLnw8fpHrYRiK7Vt84VM5K9AD9+8Ho3SD/Dp8Z4HyW42U4htJX7WPGe4VdchZIVHfWt1SfbQWjNMtFjCbae0qDHl8qtVqLMgB8OwSqZdUxbToVtonADPl/s77r0tYo6H7qUWo2mAviGEkla6/yEZlmF9cFwLuLmxc0e1BSafnW9RefDLcfLywmJHXgwhkSVCkJ5xDMqzDAG5UmhafnYoGZvptAA0Xkil5rDUY5th7zH1M7f4HvDhCaTeTXOftu6m8b4x4uEZLTiZNT97ivzIluZtzV4IMAI18QPCndv43rIRkyFidpS9JW72u1pxe0vzy45uQzIK9EFtyeFED1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com (2603:10a6:501:97::14)
 by PA1PR04MB10399.eurprd04.prod.outlook.com (2603:10a6:102:452::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 06:09:39 +0000
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43]) by MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 06:09:38 +0000
Message-ID: <ab525485-eda0-43c4-a305-99b8727d94aa@oss.nxp.com>
Date: Wed, 10 Dec 2025 14:09:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] imx: Support i.MX91 11x11 FRDM board
To: Francesco Valla <francesco@valla.it>, Joseph Guo <qijian.guo@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Mathieu Dubois-Briand
 <mathieu.dubois-briand@bootlin.com>, Jacky Bai <ping.bai@nxp.com>,
 Justin Jiang <justin.jiang@nxp.com>
References: <20251209-imx91_frdm-v3-0-02303eb0c1c3@nxp.com>
 <20251209-imx91_frdm-v3-2-02303eb0c1c3@nxp.com> <aTiWrz0RMo7umwbQ@bywater>
Content-Language: en-US
From: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
In-Reply-To: <aTiWrz0RMo7umwbQ@bywater>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To MRWPR04MB12117.eurprd04.prod.outlook.com
 (2603:10a6:501:97::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12117:EE_|PA1PR04MB10399:EE_
X-MS-Office365-Filtering-Correlation-Id: 188d857f-0f19-42e6-128a-08de37b2b358
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|366016|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVN0aEVRNE9ybEllWnAwNEg1cHlNc29pcE1jckdqUnZ0SGhoUkJuRUtJb2Mw?=
 =?utf-8?B?eEZPZEwzanRHSU5PRTAvWVVXR0xzb3Rqd1hvTjd2UU11dDM3dnE2RzgzbmRq?=
 =?utf-8?B?VUhYNWpWTUZZQzgyZE1GNERLMXVQVVNxYStSWmt3eUlPTThQSGdGVmZybG1m?=
 =?utf-8?B?YUhWem9KOTdKSFV4Z0NiTXY3SXh6alc5VHFPdFVldGU1RmdKR3IydURiVDBL?=
 =?utf-8?B?d3YvV0UrcG1SVStnMWV1cXNXTE43eDBUeXVXWWFFUlBwZU5QZTRlK3FRS1Iw?=
 =?utf-8?B?V3RMejJKVXJxeWw1ZWdtSW5vOTg4a1Z6VytaekwyS0hDb0NubFZnNWRwY2Yw?=
 =?utf-8?B?OEpDM0c1MnNwNi9yajl4R1hXUnhMSnpRU3RQRE1OdWlPME50SlduZlpuKzYw?=
 =?utf-8?B?SXVpMG16WjVzUFlQV1pvaDlENEZQZDlwWlRaaE5rWUYwaXFwMGtvY2ZuVTBw?=
 =?utf-8?B?SUNhNldvb0dXQ081aTJhTkZYMDltWXdYaUNSSGRUQW9zUDNxaEpaSStFdDJy?=
 =?utf-8?B?Ylo1YVNiVWhEUEdSOGxEaWN2OEFWNVdOU1lIWm1idEUyNW92dXdSZmFvVm5N?=
 =?utf-8?B?REZFYjhaZkxUUUdHT0RkNVdRRStFa0h5UDhiT2diNDk4K01kekVyc1kvUTAr?=
 =?utf-8?B?eDdGQk5hUVlwNVF0YVc2b0s2S0VzaThDUi9QbFEwLzB0Sm8vV2w2SWQwTnBz?=
 =?utf-8?B?dHVhQjcwb0ZScklabnczZkZaeHFrOVUrYko5bkpTU3Q0QkZwUkQyR0ozbFNJ?=
 =?utf-8?B?Yjdma3cxYnA5SXVTaWJ3QU1RQjlnN3ZudlFuVnllTENDRTlCOUp5RkxiZDN0?=
 =?utf-8?B?YXpwaUpoaFNhQXVqTExja2RZdTlJVzNPL0I5dEN6L0JwQjBMcXFra05QeW1i?=
 =?utf-8?B?RFc1azhzMCthbzRHc3dtZVNXMVBCTDRySHMyaWRrQ1pqNGFYc1lLc3YvY21B?=
 =?utf-8?B?czhMK2RpLzIxSS9Zc3YvWnZsczQ2ZHhVS0NZQW9Ic2ZJV1F6emxnMG5kaVRK?=
 =?utf-8?B?Wnc0Y2NrV1hqNFRzOTI3dXM4a2xMK0tiNDg4UlFPclZLU29Md2hLak1FWnBR?=
 =?utf-8?B?Q09BMC8wcW1JZHpIbXd3OFJxMnpkODl3ZEVPcDhjMTh3cWhzNFpLN24veTFM?=
 =?utf-8?B?RmlxQ2NsSXBwNHYwZDV2ellPQ0tjdHR4bVk1TTE4NGJaeHVBNG81ck1UcDJu?=
 =?utf-8?B?TVpzbGxEUDVVQWNtUittR1M4WlRpSGxGRmlCdCsrTmprVURWaENjYzdvUjNN?=
 =?utf-8?B?Q3Y4Y1BFaWN1Smg5cGpxY08wNVR1TGZJbE1WQmVpTHJtcHRDaER2bmZQRVZh?=
 =?utf-8?B?SC9xeG5obzI0a0d1eWNCZWgzdUJMM2pDV1ZBelhrVE9tamgwSVBzQjZsRUVB?=
 =?utf-8?B?cnhFalMxOHN4R1ExSmc3VUFjVERzR1F0NFlkdFRsMTVBR3JnTTFtOTYxdDlK?=
 =?utf-8?B?VjkxZkMzaGxmVGpHcHRnc3ZDZjNiR0trK2dDTHcvdGxzR3YvMmRRZ0lweGhs?=
 =?utf-8?B?R3NKbm90REpJVXRybER2azdUL0UrZHkvOHZ3S2FwZWdIeC9WeHBHd2xKUCtn?=
 =?utf-8?B?NXk3aHhGZ05wc0FkdXZoNTRNeHhIUWJqOTdxY0FNd3FXaHRjV1BoMHFqZFpi?=
 =?utf-8?B?NnVITEJ1OXU5K2VQSDNFd1RiM0cvV0ZOQUdocmplTEFsU284VjQySWVyOFJo?=
 =?utf-8?B?dDdMRU1mSHJWeE02Y3VDblZEenVlUGtMNEl5ZUxBSGZTb2U0MGs0ZkZHbWlv?=
 =?utf-8?B?SE51NXhTcThDdDcxVUdDTUQxU1I1L0RXUURjTzQ3VlpSemZlZHF1eDAyZTRq?=
 =?utf-8?B?ZkROSkVMSUFGSUdBcEo3UjhUM3JQVEFXdHhCbUZzTHlOVXYwQ1ZpWkJXTzV1?=
 =?utf-8?B?Z2VRQ09QcEtybTFHbWcxYjliUk1OcTVvVjZUVG9MUVlJb3pwN0lYQ2VsMmZQ?=
 =?utf-8?Q?0ElYEN0tFNvv6c1WCsl1AhC0dDSNxpRL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12117.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(366016)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkhTOS9iQnFWRnNOZG5wSnJ4dnhwb0NzRmNVaFp1dGM4cG93dlMxNDFDWXVD?=
 =?utf-8?B?VG5nN2hmM1FGUVNLNURuTHFSOVJuSTlqTklHRHAyRkFUbVkzQWdPWFIxYkIv?=
 =?utf-8?B?aDV6NmFoSU8xTWlBMVRRQ3EwNjNsYUtuUGUrUEVzamFmSk4wTzEwaGxaZXFm?=
 =?utf-8?B?cnNhbVlJS1U5WHpPVHd5TG00cFdqVzk2U1h2RmszckovQzNwUFBtelJKR2t5?=
 =?utf-8?B?VHFIbXJkR1BKV3l4N01JeXRMTEJvaXZjNmdwNkZMUytNazhWbzdNeXNyUVI4?=
 =?utf-8?B?VHRaQ2kxTnlxQVB6bjFFYmEwanRRMmd4bTlFM0kyS0U1Q1dZTUlPZUlVT2t5?=
 =?utf-8?B?cExqam9EUS9KMWtUNHV1VFIwb0ZMQUcvNDRYanA0VWVWK3o2SmZ1RzBIUkpF?=
 =?utf-8?B?YncvOXJrSnBnZ3A2QjB1eDAvcEpkMk9uMmoxaWxzUTBZdjlSeURKMmtXYjJX?=
 =?utf-8?B?K0QyNE56aEFpeWZveE9aanRJOHFJVzBlSUlOL3BqNFhkOTZRTGE3R0xsT1ND?=
 =?utf-8?B?WWQ3WTNnTUNncXp5ME5seElqNXpPYlRVeGlJcngzc2s1d3paRklFdTBsNDYx?=
 =?utf-8?B?UmlVcWJncHozdndQQVp4dXRWMkFvV1A1OVpwWUlUdHY5QmZTYzZXbWtyMXRT?=
 =?utf-8?B?eTQwU0lBQnZYNjhWQkxaUkhicWlOTmpldlJEVllGRmNMOTVMaWdES1pFNG5a?=
 =?utf-8?B?NDBIbkh2V2lWMGMzUHdsRzBHQkJKVXYvUDlMNXB5VzFNRkRkdDhtNzhUcWFp?=
 =?utf-8?B?a1BRbjZTN0tjY1F1QjlKRGJhYTJXcTJ1bTBjdDIrOEFoQ2RoaDdHQWpPRlZi?=
 =?utf-8?B?RUg3cCtlMXhJY2w4UFpRMjJsZG1zeHhxZkFxODdGNW1DaG1xSUQ3RDNRaXF2?=
 =?utf-8?B?dnY2T1B2K3M1YUlRZ3hCbEs2Z2VnMERxYjhHM3JTelZIWm1XV1dOQms3NGd0?=
 =?utf-8?B?cjR5d2hyOW95Z1I3RmpObW5oaCtkZjFIQldnekJFNVZDK2pxdHBlUzhKemhQ?=
 =?utf-8?B?SDFNemJkaFkrRXFiMm11ZzBlRG5QRHU0dURXK2R2eWg4aTFmWEtBUmFoUUV1?=
 =?utf-8?B?eXIrM1l0VHY0UisvcCtpbGpGSk1MRlY1WFpuWUJLTEJhU1c1aldzdjE3cTJ2?=
 =?utf-8?B?NWpEMm4raW9KUGtXMDB3MGxsemorN2M4c2UxK2ExNExUa3hWRzFwWS9DMUtw?=
 =?utf-8?B?TTRmcHlPVmNSa2kwa2F2R0xoeG54d0xWTzc2ME1wN0VlYkZIVWI2UEFuN3RL?=
 =?utf-8?B?bjdGRHMzS2cwejEyVFMzRE1LOHZpaW8wTUlCYU1WbjJWVURuUFV4azdhd1FB?=
 =?utf-8?B?WjFsam5tOHJWbTVoazBuQnZhVzkvMXd1TW5ZK0dvUFN4VEZVTU9UNUgxOEJ1?=
 =?utf-8?B?cm9mbW1Vb3ppei85elhta0gwRlhVMzhIQ2ZWNXBVUmJSQTNUSVhaUURjMUlG?=
 =?utf-8?B?MG1FdjV2bjFsRC9QdXdsV1pSQzh3L2tRSmEycXV4dTcrOThGd3UrZ3BjcXNz?=
 =?utf-8?B?M2ZGYkMvTU42ejJEakgrSnNrRXNNQmQ2OGhRSWozT3JPd3R5QzdnRE1YT01Z?=
 =?utf-8?B?cGhtUm5UK1d4dEgvSEsxNkR3dllXUENqS0YydEEvM0h1UGoyaW5WMDVnOCtH?=
 =?utf-8?B?M0g0di8vV3VKdWQ3Q1lHcytOUzdUblhYSUoyYjBaLzgxNUFhN25mbSt0Q3I1?=
 =?utf-8?B?NFdHVGhFNUsrbXhXZlFtcy85VnphMlhpd1c1T0d2NGdXRXZOYnU5VmVLelZs?=
 =?utf-8?B?OTBqV0NJOHhKWTNUZE9zamZoUDh4WVRPaHhsTDljaVlUbjYvcXFCaEZ6L2VS?=
 =?utf-8?B?YW1CNnEzc0tpT21OQXNtRFFpbUxQWXU1SWFzcDVvMFJoRVd6c2psLytzaWxZ?=
 =?utf-8?B?MEJNdUVkd1N0Z2tCa3ZuUUJNeHpYTFp4eUsyNFRnUitvcGFFWVVIQ01QVnd1?=
 =?utf-8?B?cEdtVGNYNDY5dU5UTUVUN1NuSGRYc09XMW9yUjBPNHN6eEFzZ3NPcTBLYXk4?=
 =?utf-8?B?QlB1OWdMYWs0b0NFejM0andLVkpxdkFYK1huUkhQQjhsVVBTZkw3cEsyZS9m?=
 =?utf-8?B?YlpBc01Rb1UzdGlsVWs4RlFUYXNmWnBNL2lGL3k1S1g3OVZndEVuc2VQeFFp?=
 =?utf-8?Q?tega6yBS2q/37tFbPlV1aY5WI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188d857f-0f19-42e6-128a-08de37b2b358
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12117.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 06:09:38.8717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TerxiLenO4RSqzeirjNx4DNE3ysnngvzgYH3J7guQIys3F8YOiS3aj2OFPPL2cgvVWYxVJWVK9qIEFAnnf0WPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10399
X-Mailman-Approved-At: Wed, 10 Dec 2025 14:13:29 +0100
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

Hi Francesco,

Thanks for your test on FRDM-IMX91 and great comments.

On 12/10/2025 5:37 AM, Francesco Valla wrote:
[snip]
>> +bsp_bootcmd=
>> +	echo Running BSP bootcmd ...;
>> +	mmc dev ${mmcdev};
>> +	if mmc rescan; then
>> +		if run loadbootscript; then
>> +			run bootscript;
>> +		else
> 
> Neither loadbootscript nor bootscript are defined; this leads to the
> following error on startup:
> 
>      ## Error: "loadbootscript" not defined
> 
> I saw that this is shared by several other i.MX boards, but maybe it's
> worth fixing.
> 

Yes, we missed 'loadbootscript'. I will add it back.

>> +			if test ${sec_boot} = yes; then
>> +				if run loadcntr; then
>> +					run mmcboot;
>> +				else
>> +					run netboot;
>> +				fi;
>> +			else
>> +				if run loadimage; then
>> +					run mmcboot;
>> +				else
>> +					run netboot;
>> +				fi;
>> +			fi;
>> +		fi;
>> +	fi;
>> +scriptaddr=0x83500000
> 
> 
> I also get on startup:
> 
>      Failed to update cpu-thermal trip(s)
> 
> But this is probably due to lack of thermal support at Linux kernel side
> and needs a fix there?
> 
On linux kernel side, 91 thermal driver is not upstream yet. And the ft 
update is a common feature for all i.MX9 series SoC. So the fix is to 
upstream the 91 thermal driver in kernel and add it into the kernel dts.

It is not related to this patchset though, I think there is no need to 
fix in this patchset. Do you agree with that?

Regards,
Joseph
> 
> Thank you
> 
> Regards,
> Francesco
> 

