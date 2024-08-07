Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00211C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 10:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7187688A77;
	Wed,  7 Aug 2024 12:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="S0Ve7aQ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 675F288B1F; Wed,  7 Aug 2024 12:28:53 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD6A889D5
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 12:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNK5s3/MfMxdUH7Zp9m3/WrrshkM1up6Vve7N8uBWvD7Zn06PsuOtIh6DdaDZOdAWfWqTbqT26qbHQmxsDppBfhzojPiEYuaMWb7dpRPLnYE8Bo8mzwAVVEJjKcNgQ1Uc9T9jP5DBLBA+M4dazjfVaOTRnEKEuJ+SYYv5KH4ThBMjF/Evr8TTo54JNcR2CNMQ2m3MN4zFvihRdWCVIG/DywKSOVF8T/dLmr4k/CXDL49u9r0awysIov/e/5daWqI6V6ceMRLDWmrudDe8oQ3ZD/qKrForEWvp9DDUAqPSrj1t21IIzBTTmv4b54vKnXWhhaz0ejWX6gnPk+jDgul3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzLtF5Yl71qXe9Xv5m1DlTjsmWlm4qUgDNKuE3iTshY=;
 b=vBDjeDjKxRMeDtOP9pg3upI0tYVS3+nfo/FLYXt3yf7O7nmP8vmtsuZnb+a+3wc58Tfmmt2mY+WJpZSTSVK4wySPiGQ2+nkmt5P/VTAmmPcxI/0nizFy1Kne7KCiKLb1liGF/D2jfAK8I7ISkim9sBBPaS8FUEspuCqXeYRb4JtErueLcapomtRIJhmyFGpLuoU73pfry1dc4kkeKOhTZU0RGrLdsVEsMrS2DxyIhNwng/8zWpndZ49L5aqzW6+cbxNKtCeoRPlonUplRFMjfhPTdlfQCB4Snl2KnuYdfSQ7EACYDl//XWZYfxWnblcIbv98sesl7DLTfL9Nf6ByUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzLtF5Yl71qXe9Xv5m1DlTjsmWlm4qUgDNKuE3iTshY=;
 b=S0Ve7aQ13+JiotdDrPaBAKa/TGMvEirDzE4VsTWrJAGxmyKAF5k0zgfS+ginW6nC+7B7c/0zudukDnMB80wPQVVRnylB51tzswRJvczKUBdT4U/WZV7zAshiDVOopX1wr+W517fY04agI32nks0mx2p5qZe1sknNpHLybxv1ebM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 10:28:36 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 10:28:36 +0000
Message-ID: <c07b5908-cb2c-441e-aa16-5ef180c24c11@cherry.de>
Date: Wed, 7 Aug 2024 12:28:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] rockchip: gpio: Add gpio-ranges props
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Johan Jonker <jbx6244@gmail.com>
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-10-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240802225705.2640999-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::18) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AS8PR04MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd390f3-d1c7-42f4-8568-08dcb6cbb1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWgzN0x5RkJCcEMyL3NLeHcvaGJzY0ZZWG9WMyswbDEweVBNZWlqSXQvY2c2?=
 =?utf-8?B?SitSSzM1OVlaRG9SaVREWWphdFp5T3l0bmt3aDQyTWN2Z1VkcHN2ZG5yMWth?=
 =?utf-8?B?d2YrUWEydTVmWGRUTFFWVFkzdXBTQkdTT1gybHMrUmh1Mlcyd240SWtpcjlI?=
 =?utf-8?B?TnRZczV3V1A5WGVuMW1iWk93K2tZcVpGbzBRd2RxL3N2Tk96VVBMdkNoM3A3?=
 =?utf-8?B?VXJYTlR5SW8raG4wZnpPcnBYQzBuU3ZvYXY5eGl0a1BFVU1ycms1N2c3Qkxm?=
 =?utf-8?B?Z0JDVFZPbVliaXhHNFAxWEZmdFAyNGc0YU9qc0c2SEtURTJUb0JDTXpoTEor?=
 =?utf-8?B?RzVTUWVJdElmS1lKaEVaRlY3TVNITkxMQlJQVk8xNlFSdjBCS21PSmZBRjQy?=
 =?utf-8?B?NmE0MmYwdUpwUk4xeEE1ZktCNjVCeFQ3L29vdkNiUkRjcjM2aWhNSTJDWWI0?=
 =?utf-8?B?dnRlZXY4ZXFmeWoraWxYRDJMbXNZQ2c0K1BsSUdPMzlrUzB4bUFvYTBPMFdX?=
 =?utf-8?B?OCtOU09iaDRVVjdkeXRwOGkwQ0UzeTVpQlkrbWRlcXpycURUbk5RUTdJRkp5?=
 =?utf-8?B?ekkxZzZ6U1Q1UkJYY3htVzZaamh3djU0c1dlN01iWDM4Z0FTN1RaN0llTUlK?=
 =?utf-8?B?VnA0blA1ZnMvL2FKRC9jMVJZZ0tqRU4vUmc3d0swVVFyQVR6RDYvWUpwT01H?=
 =?utf-8?B?ZThMU25ZaTY0a0dHUlZ4cWpQL01JNldBZEk3OURsR2Y1alFqdDZHTlFCblhr?=
 =?utf-8?B?Sm51eEpRL3BIdDJhdTB0WVNZMGFTTXA3bzlWOVdWa3gvN21rd3UrWXhsRTNX?=
 =?utf-8?B?ZElmN3doNDRhaUY0THJzbkVyWTh2aUNzWDdydFBLNXI2cEdmN0lZM1B6OWI3?=
 =?utf-8?B?WW5kQit4ekVkaHFxdmFNWlRpVm5iZm0rK0xGNVhQVHZ1MGFCMzVkZUtjWWxH?=
 =?utf-8?B?UEtFb3o5M2FUT1lFWERPQ0ZzRStSM3JJNURxTTZ5c0V2T1p6UG1sV2x2eGJa?=
 =?utf-8?B?Zk1aVDZKREczaW5OV0laNnJwRVFjSUgyZDgxbmZPaDNURWF6VkpxV2xQTCtU?=
 =?utf-8?B?K25hZFhCZjE2blZwNlhJaWJBQlZVVTg2NWVXOXJPL0Y5MGhhVXlmNlo0RXlx?=
 =?utf-8?B?MHRpTHE1dHc5WnJFSkJvTzNtdEVJa1BocVh6Yi91b0s1TnhrNFJsZHFCTnBJ?=
 =?utf-8?B?cGVmdThsRGVUWmRNaUVjZmxMekNUNUJvSDBEYk1FamtHV1BZWjNQcjd0YWdo?=
 =?utf-8?B?OFN3dEVuNjRhbWtscTBzaGFnU2t2dDlxQXF4TmNrM0pRODF5clRxL3c1bUpI?=
 =?utf-8?B?aHgvNkE1aE9BTG9pcUpKRFdtajNKNWtFR09GSXZJYkdqV2U4cCtOckNvQVR2?=
 =?utf-8?B?UjNqMytLMTZzajJ0K0tOODZkSUxKTEV4YVI2anBCTzNTVjc4Smx2N3FaMkx5?=
 =?utf-8?B?YkEwYWJjbnUyZGpUTG9DaURjQjVHOENSN3Zod0l2TnA5Uk90UzJRTWd5eGVE?=
 =?utf-8?B?aHZZUzZneERoWnRMby9ULytrWVh2T0lCUFR6c1o4TStZU1ZET2tmRzlzWnli?=
 =?utf-8?B?ZXlPdG1Ua3pUWi9nanFIcXQ4OFp2ZWM0RUpKUDNhU0Z2TjB2azZjTFNXMnVC?=
 =?utf-8?B?aTgyakRnRnVKOGdneHBERFpEbXIvYy9PNXQ1QmZ5RHdSK3k2Rk54UDZ2dG84?=
 =?utf-8?B?NGdyem5KaFRZWDNEMnJZa1dMclVlWUMzNnlxaVJLRlVxcnlKcTVBSjZSQ3Zi?=
 =?utf-8?Q?zU4H7SL/MP8jWVGzkI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGhlZEZ0dThmV3lmZGtSM2pEY3VKT21SNEtaK0FyNVBKcDhOUUhvN2JGTEJm?=
 =?utf-8?B?L1FvbC94M21vKzByd1Bkamp2STFXR2pReUdIN1BPbllWZ25sRGFvZjV4dWlO?=
 =?utf-8?B?YUprTWU1RG9Id202b3ZtdUxxaGxrUHBobXIxeWtZSnplaEpJUVNHUnNYTlJL?=
 =?utf-8?B?WHJpcDdudGx1QXVQZExOdElvTHB5djNXaWMwa2xTRWxPV3J6YmpBSDAwM29o?=
 =?utf-8?B?QUVTV1BKOEE5Ymt0d2lpMU0rcmhPaFZpbUlLQVdMdnE0NHV4T3g5WEE3RWVm?=
 =?utf-8?B?MXovaHlPSjVqS25LT0NLZ21lOFFIOGRSSDJBNm82VmZVb2dOdzBWV3VuR1lh?=
 =?utf-8?B?NHJzdFVMVWhlWHpLYjZOMmh0UmZlcFR3VEhjUDUreTFsTFBKU0RIK0lEcjAv?=
 =?utf-8?B?SENLb29ZbUVkaHJwYXhRSlZxNG1zZ2RLNmszVHIwaThoRTJVQlZ2ZWZ0Qk5G?=
 =?utf-8?B?MUVONVRvRmp1cnZEdllyeXMrWEFteFlYbjZTWjNXTVpRVEI2OG1DWkxMWVp3?=
 =?utf-8?B?LzFkdDY4b0cvcGo4Qm1CS0pDVXBwVnhYUENMYTdxMnZBVW5FYXE0c2xmWHRq?=
 =?utf-8?B?dnBMU25zcmJoMVRuUHNMYVd0c05kakFBVlM3bE51c3FEdFg1ZHpDMVVHU25U?=
 =?utf-8?B?S2hKSkQxRGFpNXBvWlprbWRORzc2MjZidWtvdEFGTmR3aklpZTJHUXJYVmQ1?=
 =?utf-8?B?QVQrNkd6dktCRWlWUnhacW1QaTlTTmlkcFhMb1N2Wkk3MDhlWmdlUzJvM2Z0?=
 =?utf-8?B?SzBzbzM4blpmN2lpK0sremRjK0crRWZ5RGxZbHdFTHR5elppM1JKQ0JLM0pL?=
 =?utf-8?B?ZnM2WTYrNTVOZ2RyKzFUakdINzVSTUY2dnFSNmxSS0FTeStmUXZTWENTcHp6?=
 =?utf-8?B?REM1YjIvYTRRRE9oRk5OcXhSSUxleDZXZ3JoVXZncFhmUUFxMXhMeEJyM2JG?=
 =?utf-8?B?czZwd2lwdmhzaXAvVmZsbDNCTFo5aUxJVldHT01JV1JvR09xd3pQSGZhanZw?=
 =?utf-8?B?a0w5V0dvS2N6MDNUSWV3elBtNzhzeFZlRlZVUWxJSXdmNFFmV3pIdzZINFlM?=
 =?utf-8?B?VnN5ZnY4eE96Mm0vOHk0MGgxbVRGRTNtelVYV2lzSHV0VGJYdldQNWZTcHBr?=
 =?utf-8?B?Nnh5TkNuaU56cU53bGtxMko2dUpBRlNmMVQ5Y2hTdUdVdVo0ME5adUorWWcx?=
 =?utf-8?B?RUltUi9jcDZKT1ovalVXdkl2eks0RWY3NEQrNkMxL2hMbXRpQml2RjJjNG40?=
 =?utf-8?B?V1FEc3BjbEVFODZtY3U2dFlEc0oxV0dObjVWOTI1dDJNRkZVL2JRbzdaQjhr?=
 =?utf-8?B?d1hwNVF1Wm5MYVl3SXZtcTZ2Q1B2T1VMLzF2T1hpdFBHL1dYN0VMak5RWmp0?=
 =?utf-8?B?a0poM2F0b05Hb2R3REZwVFlzeW4reURJVFV1L3cycTJqTmZPSGY0eU1RRGtn?=
 =?utf-8?B?OWQwRHRCbHZjdE9oZ3dxRUxnaE9sZVpaZ3BEMnZ1Mm0zVVFVM1VSek1URVpm?=
 =?utf-8?B?c2pDVVBzcHo3aFF3M1ErY2EvU2hHUjdrWDZQUzRQVkFRVllTT3RjbVdiT3ZG?=
 =?utf-8?B?TVM0L2hlZm1qbU9RYVNjUWpMZTJ3Z1VGVDB1b280Qk9ZS3ErbDM4cHA2ZjIy?=
 =?utf-8?B?YzNZWUx5QWI5dzJudHByWEQxWTdsaVN3MGE3Q3RzbVRDbC95dDJsdDd1UG94?=
 =?utf-8?B?bUZZRzRkVVg3WUtOT1BIeVk5VWd5dDJpVmRGek1QTVF6R3lUMUhJbFNhdXlU?=
 =?utf-8?B?enAva0dSYmpiQ2JmRm1QRHc4SU9pdTFEYXN1ZzM3UjUwUGtLQnNoNDI5bWdz?=
 =?utf-8?B?blR0bjU3NFVuQW5OMG1yKzBJWXhnTUM1MkpTNjVTWkJlZXo4RmZsUElOZW9B?=
 =?utf-8?B?dUY1bkp1TnpYYkx6Q2x2elUwaWJvcDcvdFRDQnQrakIxcUdGazVGanZENXVS?=
 =?utf-8?B?NGt2RE00VnUyVWJpMG9NcUFDOXZTZTlhdU80bkNVQlB4a1Z4ZFBuTWFQWkxY?=
 =?utf-8?B?UkptVHFMMzFpSEwvckEvRkE3bmpoSjJsUHBDT1JZTWlpZlM4NU02UmZmWjJG?=
 =?utf-8?B?QjlFc2Q1RVAwWkpva3IwZTBwUnA3ckFMRDJzZGhhK2xETGI1QjY3UVdrMlM2?=
 =?utf-8?B?dUJRdzZtQUxLWlkzUmVTMDNLVjFsQUhqTTV3NCtKQjY2cHRNZWpBb2NhMVdK?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd390f3-d1c7-42f4-8568-08dcb6cbb1e6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 10:28:36.0266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPSPiCp+vcPPlxF6bFIJsF2DVS4lCfX6EykXk58RJPWFMM0mG6iZQof+RFIrxr2HNcyHITKdS2EW4UqHOWIkJNHH766Lg4PyloisVMM4x8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8660
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

Hi Jonas,

On 8/3/24 12:56 AM, Jonas Karlman wrote:
> Add gpio-ranges props to supported SoCs based on the following Linux
> patches:
> 
> ARM: dts: rockchip: add gpio-ranges property to gpio nodes
> https://lore.kernel.org/all/26007385-81dc-9961-05d5-8b9a0969d0b6@gmail.com/
> 
> arm64: dts: rockchip: add gpio-ranges property to gpio nodes
> https://lore.kernel.org/all/18c8c89a-9962-40f0-814f-81e2c420c957@gmail.com/
> 
> For RK3066 and RK3288 the gpio-ranges props is adjusted to match
> https://lore.kernel.org/all/541b7633-af3b-4392-ac29-7ee1f2c6f943@kwiboo.se/
> 
> Re-enable gpio6 on RK3066 now that the pinctrl pin offset is used with
> get_gpio_mux().
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> v2: Collect r-b tag
> 
> Cc: Johan Jonker <jbx6244@gmail.com>
> ---
>   arch/arm/dts/rk3036-u-boot.dtsi  | 12 ++++++++++++
>   arch/arm/dts/rk3066a-u-boot.dtsi |  3 +--
>   arch/arm/dts/rk3128-u-boot.dtsi  | 16 ++++++++++++++++
>   arch/arm/dts/rk322x-u-boot.dtsi  | 16 ++++++++++++++++
>   arch/arm/dts/rk3288-u-boot.dtsi  | 33 ++++++++++++++++++++++++++++++++
>   arch/arm/dts/rk3308-u-boot.dtsi  | 20 +++++++++++++++++++
>   arch/arm/dts/rk3328-u-boot.dtsi  | 13 +++++++++++++
>   arch/arm/dts/rk3368-u-boot.dtsi  | 16 ++++++++++++++++
>   arch/arm/dts/rk3399-u-boot.dtsi  | 20 +++++++++++++++++++
>   arch/arm/dts/rv1108-u-boot.dtsi  | 16 ++++++++++++++++
>   arch/arm/dts/rv1126-u-boot.dtsi  | 14 ++++++++++++++
>   11 files changed, 177 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3036-u-boot.dtsi b/arch/arm/dts/rk3036-u-boot.dtsi
> index 41ac054b81e8..3e788187f630 100644
> --- a/arch/arm/dts/rk3036-u-boot.dtsi
> +++ b/arch/arm/dts/rk3036-u-boot.dtsi
> @@ -4,3 +4,15 @@
>    */
>   
>   #include "rockchip-u-boot.dtsi"
> +
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> diff --git a/arch/arm/dts/rk3066a-u-boot.dtsi b/arch/arm/dts/rk3066a-u-boot.dtsi
> index 06f405ca2c5e..35b52d6fb7f3 100644
> --- a/arch/arm/dts/rk3066a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3066a-u-boot.dtsi
> @@ -24,6 +24,5 @@
>   };
>   
>   &gpio6 {
> -	status = "disabled";
> +	gpio-ranges = <&pinctrl 0 160 16>;
>   };
> -
> diff --git a/arch/arm/dts/rk3128-u-boot.dtsi b/arch/arm/dts/rk3128-u-boot.dtsi
> index 6d1965e6b520..dd1208e7cf40 100644
> --- a/arch/arm/dts/rk3128-u-boot.dtsi
> +++ b/arch/arm/dts/rk3128-u-boot.dtsi
> @@ -14,6 +14,22 @@
>   	bootph-all;
>   };
>   
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;
> +};
> +
>   &grf {
>   	bootph-all;
>   };
> diff --git a/arch/arm/dts/rk322x-u-boot.dtsi b/arch/arm/dts/rk322x-u-boot.dtsi
> index aea917544b1c..f0e2a1f95aa0 100644
> --- a/arch/arm/dts/rk322x-u-boot.dtsi
> +++ b/arch/arm/dts/rk322x-u-boot.dtsi
> @@ -47,6 +47,22 @@
>   	max-frequency = <150000000>;
>   };
>   
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;
> +};
> +
>   &grf {
>   	bootph-all;
>   };
> diff --git a/arch/arm/dts/rk3288-u-boot.dtsi b/arch/arm/dts/rk3288-u-boot.dtsi
> index a43d320ade7b..0f8053a8b690 100644
> --- a/arch/arm/dts/rk3288-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-u-boot.dtsi
> @@ -95,8 +95,41 @@
>   	clock-names = "clk_edp", "clk_edp_24m", "pclk_edp";
>   };
>   
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 24>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 24 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 56 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 88 32>;
> +};
> +
> +&gpio4 {
> +	gpio-ranges = <&pinctrl 0 120 32>;
> +};
> +
> +&gpio5 {
> +	gpio-ranges = <&pinctrl 0 152 32>;
> +};
> +
> +&gpio6 {
> +	gpio-ranges = <&pinctrl 0 184 32>;
> +};
> +
>   &gpio7 {
>   	bootph-all;
> +	gpio-ranges = <&pinctrl 0 216 32>;
> +};
> +
> +&gpio8 {
> +	gpio-ranges = <&pinctrl 0 248 16>;
>   };
>   
>   &grf {
> diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
> index b7964e2756f3..c2d56b532f80 100644
> --- a/arch/arm/dts/rk3308-u-boot.dtsi
> +++ b/arch/arm/dts/rk3308-u-boot.dtsi
> @@ -54,6 +54,26 @@
>   	bootph-some-ram;
>   };
>   
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;
> +};
> +
> +&gpio4 {
> +	gpio-ranges = <&pinctrl 0 128 32>;
> +};
> +
>   &grf {
>   	bootph-all;
>   };
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
> index 0135bc08d491..3bc776146a82 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -57,6 +57,19 @@
>   
>   &gpio0 {
>   	bootph-pre-ram;
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;
>   };
>   
>   &grf {
> diff --git a/arch/arm/dts/rk3368-u-boot.dtsi b/arch/arm/dts/rk3368-u-boot.dtsi
> index 811d59ac346e..be2ebda83529 100644
> --- a/arch/arm/dts/rk3368-u-boot.dtsi
> +++ b/arch/arm/dts/rk3368-u-boot.dtsi
> @@ -26,3 +26,19 @@
>   		reg = <0x0 0xff740000 0x0 0x1000>;
>   	};
>   };
> +
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;
> +};
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index c4c8bb1401ea..cead23ea7c20 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -91,6 +91,26 @@
>   	bootph-some-ram;
>   };
>   
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 32>;

Only 15 available here... /me sobs

TRM part 1:
GPIO0_A[7:0]
GPIO0_B[6:0]

no GPIO0_C or D it seems (though the TRM somehow mentions GPIO0_C but 
nothing to configure it and the Linux kernel driver says bank0 is 16 
pins (which is also incorrect as there's no GPIO0_B7)...

> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;

This also is incorrect, GPIO1_D only has one pin.

> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;

This also is incorrect...

GPIO2_B stops at pin4, no 5,6,7.

Same for GPIO2_D.

> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;

This also is incorrect..........

GPIO3_C stops at pin1.
GPIO3_D stops at pin

> +};
> +
> +&gpio4 {
> +	gpio-ranges = <&pinctrl 0 128 32>;

This also is incorrect.................. (the number of dots matches the 
number of tears rolling down my face).

GPIO4_B stops at pin5.
GPIO4_D stops at pin1.

I only checked for the SoC I personally care (RK3399).

Quentin
