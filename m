Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB772C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 09:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A059884C6;
	Tue, 18 Jun 2024 11:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lotkYLZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFD9D801BA; Tue, 18 Jun 2024 11:46:26 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80159831A2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 11:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LheISPg2aX/fR2FckH+PO3Lg19LqEj0U/5lgeseJrSe18fC3/dOxQMGD7FdRj1HUeLJ8mqwiP75RDm9Kk05cj9PcNu0w2uAOU5jCracu1MTjUovxBAtNzh9+dK7BsdsjeggIblSNKiumOKzT5m4OkzgZf66epbOSVWlpBy3wLPOO8hGkcv4svPqkyzZDs1fkx834po/bMMRH8bPxXFee0+DvG4YoU/Rd8g8CHoyIKWFYiARUw648bK0TRam4Byw49XWmFFEZhuBQklfQ3GAneL5QeM0oB9+GgqJvEAc4yWU0BnXrKnrct3Jey1oXO6FmGXp1LTZpK6Q6HhdXuwX/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vpb1a74AyODoyqcYH6sg6zsuMBo4JaVkT8ACNbqvMI=;
 b=VUvrslt1s3/pMHKph3ZLH8sm/PSrPvnlxBDtWsS5GG7ofVYzwmLEpvKzx6SJ0oHUZnAcJz6Cyb04bCP9M+nXotHWx2o8uaeTNEgS3oDoFcEeGCTL6FbnGeDiFLQx1+CNAyktxBOrzolB3/euIvlVpexmy1AZvQqVwFy7k2qRcf+qjCSZHDuqIGVqU+ndySV/HuIkPoo3zcW6FX4xKDidVKRmN3IL+3lhHrTXhmeNbK/bkZoVk4bjZzLFBagbOVGJzYAPvwHZ07ePvOjcPIqUhS+q/0sbMHN1OQCDwyTlZjPfmooAkaPixLkKvzXrsE4VKRtQz/XPg40z5r5pQxL+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vpb1a74AyODoyqcYH6sg6zsuMBo4JaVkT8ACNbqvMI=;
 b=lotkYLZCJiKrX2Yks8iqrT8Zo16h9uMsgd7+s/qXRznTkvq7LD0U34t9ji+HMg4QA/wPHIrSfXaJ1oncFRZhOrBYMK1kjs2DEbXdvuJU12/dmXbjkbXHKUt8i6QbxkWCdI0Fwhk7Kk+Cew7kb9dmsWPDKqtvpC8el9wJib7yedQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM7PR04MB7191.eurprd04.prod.outlook.com (2603:10a6:20b:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Tue, 18 Jun
 2024 09:46:21 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 09:46:21 +0000
Message-ID: <bded3033-bf2a-4130-a002-f73f6569998a@cherry.de>
Date: Tue, 18 Jun 2024 11:46:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] power: rk8xx: fix display name for RK808
To: Dragan Simic <dsimic@manjaro.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20240617-rk808-show-variant-v1-1-62143a89bafb@cherry.de>
 <9134de0e83da76ac2ceb047074e69155@manjaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <9134de0e83da76ac2ceb047074e69155@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM7PR04MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c23a82-ab79-40df-8c8c-08dc8f7b8281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjlaOWphek1kNUo2NGhQY2JyaHgyWG9UbTBWdCtTYjNEUTFsaXljTGlZanE1?=
 =?utf-8?B?cDhqcCtYeDdMb0NpcE5hYzkwclpIRUk2V0hBTkZjdWNWY0pRREZLczgvQ0Yx?=
 =?utf-8?B?aHJ0K3p0MG1zVmdNZFo0K2tlb1ZteDArS3U0SDV0R0tSdUlQSlZXM1RyYVg2?=
 =?utf-8?B?NTdrZG5iYnZrRmIyM0tmKzlBdWZTemFTL1FTY0EwVGJDZG4vR1Z4OTk4QUVY?=
 =?utf-8?B?MDFyOW1kdENxeFN5Y2VoQXljZGtzWXRmRGttVjc1UVVPTllyYnJSVGNWMVp4?=
 =?utf-8?B?M0kxeVlucVB3SS9XZ3B3V29LQ2JRd3FqaXNtbkhuc05TZGxBTGcxZHNid09O?=
 =?utf-8?B?YnJOV09yVTQ5dW5CRDF5Tll1d0I3ZG93b1dSeHNVeFQ1MElTZFErZ0xaU0J0?=
 =?utf-8?B?K3BJQ3gxMGNTZE5iaFVIUHkxbFBLb2kvMEdVYjJvWGdZTlhhUWZnbVNWV1FK?=
 =?utf-8?B?VFU2N0IveHZxT3dSUDYrRmp0eFJBalVRMWRUM3ppT3Y1UlFoMFVsWExHbEZY?=
 =?utf-8?B?UHBWeDcxUDNWampEaW9od3ppZ3hKY3F6NmVvckVkbVYyREJqZnZCenMxeUF0?=
 =?utf-8?B?ZExRd3RPQjNMY2h0OWNOc1hYQk9LUG5pc25RMmxSa3ZsWXdoUmxFc0tNWWRL?=
 =?utf-8?B?S2RZNDMxanhCSjR0cU95QXcrcFk5NCtBVmttMWxzWHBkUDlIQUhkcXljWVZR?=
 =?utf-8?B?bFF6THArdldTdFBUV081WjNZZzN0SEt0Y3JUMkNSMzJXejVteHFRd2lxYkdi?=
 =?utf-8?B?em10MUxkQ0dWblUxZWM3MjhuVjQ1WkVaYjhkMUdvamhzK2VhdlpINXhMWXUw?=
 =?utf-8?B?YWE2STBRTWFGQ1FjOW1EbEdmalZsUU4zcU5reFo0Um5PNUdtRmpoM1dCem5G?=
 =?utf-8?B?MUZXRVZCbkh3dExEcEYxdm9Wd0owUW9LQU1DckhYMHZxT0tjNDRkVmJJWGRC?=
 =?utf-8?B?d3A3bUEyWkJaOXJJczNENUVkZFNkUGhQOFcyZmJ3L3pIYi9HMXB3VUs2M0U4?=
 =?utf-8?B?RmsrWXdpRm1ndVdDQytSbDRoZWtCV0JYVit4QXVqbG01dVErNEQ1Zm1LYmZT?=
 =?utf-8?B?clI3c2RUblVhSDNHQ2p1NEpQT0IwL3FON0RmSDUrVGtMTjMzT3JCeGxJamZ5?=
 =?utf-8?B?aWpCVW9McnZibFpyODM4RXNkUXN2Z0RLK2FYVEdRL0VYalFWd3VVN0ozNno5?=
 =?utf-8?B?U2dIMXhKa2hSUEc5MlprUG1EaE1iRmJRTGl2QngweFlVZ1FBNEZqTyt3TUJi?=
 =?utf-8?B?SjRGbjRYV2Z5VXhZd2Z5bkFENStqeXM3SE5uZWtsR3d1VlhJTU9aaisrdHNy?=
 =?utf-8?B?OXdDVUdvVXhCZjgxZUljZTN2a1kzdGhJL3R1a1F6ZUZ1dDNJMjVPYW9zQWx2?=
 =?utf-8?B?NkVxMk4ybHphelZZTGp5ekZucDNqTmt4TmpENUE2V1VRa1pIbnRsNGlDekdk?=
 =?utf-8?B?TlVGVmtCWjd5WkZkenZIbzJQNytMVU5LV1JLa04yY2wrV1RNT0tMT1c5TG1G?=
 =?utf-8?B?L2VxeThpdGRSSDd4K1hQNS9nWDNuRkhLQ25hTVhQQ24zMEJCNDVPWTlxaW03?=
 =?utf-8?B?ZWo3ZWFhaHlJb3VDNDRySHB2dmludTB6R0NnYktFeitHK2NacVlldGs3SXFJ?=
 =?utf-8?B?S2paTWkrOTVWZkpvcmFvZTVWN3RIdWF3RTNQbUxoYytNalRyOTNxaFcyWkpR?=
 =?utf-8?Q?xsMxUyTrE8eNtouipAkK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG8rcHVUdkhOVzFvNWRaZHZ4a0pBYUs4TDQ3bkl5bzIvNTd4eFdtVVpDK09F?=
 =?utf-8?B?azZYT1EwaGc0Qi8wSmRrM0h4RldoODFIUEhqTSt1MnNGdEhjSkhLS3d3dmh1?=
 =?utf-8?B?WWV0TkJ0NW1PNzNrK1hNWllndEVKYktDZFMxRk83S2pWazN5Zkc5VGlnL2FY?=
 =?utf-8?B?bElFR0JTRnNRejViQkpUck9FU29RMGRvU3ozZFc4eDFtSFFvV29kd0pWYVRE?=
 =?utf-8?B?RS83UDJJaVhqZUxxWGVTYW1FVVR0d2FaOUhEL0VrTEo3NVA5V1IrWSsrVnZ1?=
 =?utf-8?B?OG9jbXZJdSs5bGw3VzkvTTNBRExmRk5tOXpEdlBWYUlmRnV3NDB5SkNGYkV4?=
 =?utf-8?B?UHM5bkdicFIzQUlFdFVIaEV2WGtVUHdTQkh3d3BqWDk1YlFvV0NmMWFEYytq?=
 =?utf-8?B?Y1AycHhlOTZEWml5U3FaMVE4WkhlMDBJek9CbGt3RUczaE1CYk9TWmU0aVZm?=
 =?utf-8?B?WjN2M0hQaG1FdnU1WE5OU3ZLQUd4OUdaL1JwVHRKb3VPK1pLbzRUZ1hMZmdo?=
 =?utf-8?B?UFZmMXpCemg0U3pUMnN0N0pTZUxPcHl0c3JKMW84c0cvSTVBWmRKaVRPakgz?=
 =?utf-8?B?c2JJcy9XRVpweUpiWFB0N0N1MjZoK29vWU9PajFrQWpuemcvNk5qL1RZbTk4?=
 =?utf-8?B?RGZ6T0ZPZGdqa2RTbkFld0RHQjFGdUU5QU1qSHZVVHFMQWxTZ1BCOGVaeUph?=
 =?utf-8?B?TXVEVzBzSnJWdVlLQWY1WklIQm0wRjNNb1oyYmU0MGNpYkxSL0xjQk10MVkx?=
 =?utf-8?B?Vmk2dlBDMkIraEx0MEV4b2JONmtwZlBiWWtaa2JncGc3ZDhuMXlhM01TV1Vh?=
 =?utf-8?B?ZGtnUmxmVC9TT0VydXNDZTh4V3dYazdpMUlXak03aTVtUnAzbldqcGlFckg0?=
 =?utf-8?B?K0V5c0dHNVM0d3g4UGNxcVJWLzlNdThXS1J4cGpIZk5LVThsWTlNRkY0aE16?=
 =?utf-8?B?elM3bTlXclp0RGhGVGdPc0pVakZPVVBNbnJNQVJRcmZuSERJZ0JCZXM5WE1D?=
 =?utf-8?B?Y2dJVXVpcWlKR0VubUI4RFVEdUtXamFOY2JVS05NaGJ1V3hxbTVKYlNBcmFn?=
 =?utf-8?B?MElZdVFKdThVbkV2TDJZN2VUeGNmZGtWdzltRmNFYTN1NzMrK1NEYzFEYjE2?=
 =?utf-8?B?RTdxNUxHZ1RNSHRvRndsUDNvWHk2NEhrZGpVSnFPelVMRnNSR3dJNmk0RWo3?=
 =?utf-8?B?TDlZamtGZzNTRVFGWkpzS2w5bDNwaC9CeHBJZ1AydG41MVFCUCtRVUtFdGRS?=
 =?utf-8?B?K2Rib0xyM1hSRlhpNVFqQUp6NmdNZXdaY3NlT0xaaTN5c2hmTTdERzZVeGIy?=
 =?utf-8?B?SVNsbm0yNkViTmN6S3BuMjFRS0EvKzM5aXlwL25FazVDL0Q1V0loS2pEN1gw?=
 =?utf-8?B?VFZFL1pzbzYwNW9sS1FsOEpCdnFLdVFKaTFEaFFlbS92K2V2KzFGYVBNeG9j?=
 =?utf-8?B?VVJ1WjRZRVpMSitDNkhoTFcybGZTWDlWOUU1R2hKaHJRbHM4K2RvVjZoUlhY?=
 =?utf-8?B?QXZUQjRxOUN6aGUvclFEQjl1eFo5S2c0K0RhYUpwckJIamlHVFFVRzcrYWJD?=
 =?utf-8?B?aVVzcmZpcUM2QlAyNGNqb1M5QWRHQ1NkdDFoeTBjVC9VVXdMUGtJQnFtR2JX?=
 =?utf-8?B?ZnR5d2p0SmlQd2VNVU9pQnBJbmEvcVR2aXdEZlVOMDd0SHdlMDFNMU5TL0Ry?=
 =?utf-8?B?UzFCamdFYWVPekIxQWNRVFF0MS9hQmhWK3Mxb2J1dE1UNEtwRGN5MExBU1VJ?=
 =?utf-8?B?NHE5R01JcGhCeDhSbDAxYTNRVXNRbHpoVnhVYmJreXdaMEQzNnR5MHNEZk4y?=
 =?utf-8?B?Z1Q4TEdNc2YwTnF4cG1UV2UvWDBMcHpQN1paMXdmOWhNa0EzWFFzbFBmOXRp?=
 =?utf-8?B?cW5uZ1lxTzVoWE9EVlFrWmtaOUw0dkhmVEdtTjdSRUNkaEM5MjRxSTM5YUJw?=
 =?utf-8?B?ekdEQ0VsMnNXU2gwVCtlUFJleWhPaFJjeTQxSitYRGlLUWpYK1c2emU4Sjlu?=
 =?utf-8?B?OXNSY1FqaUdHa1hOWSt3MHZtY3hjcjlra2RPdkhrWGNOM1psS2ZxWkJXSHJZ?=
 =?utf-8?B?SUxaRWVOaUtPZEk3cDN6c1VmOTdWRHpxSGNZeTNpN0lSMVVyd1BtbkpxQ1Bo?=
 =?utf-8?B?d0Z5bEdLNDN5ZThnS0xuR1hWR0dwVHlSRmNIRHhreEV1T2xOYVp5dWNoc21p?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c23a82-ab79-40df-8c8c-08dc8f7b8281
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 09:46:21.4149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hU7JjoEt1sBPNAaOpqbdqUVigJjolzbp22LxMITDln3Qt2W2uS9AnAH0TGQFGhKLLpwxy/kG0n1PFe+GdZG1p1I7RMl2KCMlgEchIwt1QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7191
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

Hi Dragan,

On 6/17/24 7:57 PM, Dragan Simic wrote:
> On 2024-06-17 18:48, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Commit 2ce40542e0eb ("power: rk8xx: properly print all supported PMICs
>> name") fixed all PMICs name that were broken but broke the only one that
>> was not broken already: RK808. This one is a special case because the ID
>> registers are marked as reserved and always return 0, so the variant
>> cannot be derived the same way it is done for other PMICs from Rockchip.
>>
>> Fixes: 2ce40542e0eb ("power: rk8xx: properly print all supported PMICs 
>> name")
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Looking good to me, but I'd still suggest [1] that reading the MSB/LSB ID
> registers (i.e. 0x17 and 0x18) is skipped on the RK808 altogether, because
> the RK808 datasheet lists those two registers as reserved and provides no
> methods for determining the chip name.
> 

Rockchip themselves do this, c.f.:

https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/power/pmic/rk8xx.c#L587

I won't send a patch for this, but feel free to send one if you feel 
like this is really important.

> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 

Thanks!

Quentin
