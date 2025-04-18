Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D79AC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 11:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DAE082E25;
	Fri, 18 Apr 2025 13:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fDi4iqxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A281683118; Fri, 18 Apr 2025 13:29:34 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F0D82A31
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 13:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjS9Gu6CJN1bT0kuk/8HbX4bpvJP5pFO710VRr9IQQVSkKhkv85JuYO1Kmt6AqR9GBtF+1AKM1+7985V3OQBw3UiDQqqEHPUMtmDKv6dBERD1Ef/fEw6aQOMCWsInEOOyaAYIskCYmXs7ikoTlEXHLJgpI3tJ3bGWbw9K8L2aHyGvmxVahyjZe3mWxgLLvMRDIp/bBU4sF4nqvjJhVqQgwHFFGu//aBruk4Vwy/wMgGPlQ/IvMNGH7kcxcBg4WPgj+LCmXpqIU4H4r82nNIQQtY0x9aZvEYway3jxsB8bAtZk/1nKcxHTsMBJW1rD5mn+aUkNN0SUIC16PkmBDOLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnApcmiHRUOnxGC6i5EUh9QPqRd4PHclqMXjrBbjVT4=;
 b=NTfES8oDhK1F0imIbPPxL5GMATy94AKd+F29eoeFE1939yX+p3M76AW1v+Rk4Xw4ht+K5g1K6x6pd1KUKZpDwFi68GHcd/6QaWxeeox1hkNS53FS4OXIhi2ChemZvSNjtVIFHXW5UvSp+rscqWV3zSaES/K6iaND5H5QTV3csIabkpu7b1YXKqrteNiWWTNYUgjKIKRR+fw7mUGsdRwkQb6TbLETvC77/fUUc7RT2jBjvcJfGRZPnfizHOqfBxYFhdA4fPge86VBFNbax/gQIk+cT+wx0QOXMQcDCTK05++MIha7QCcpWDSMD7P7ovrfBxdU2kodCNqWMVTkKY7JpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnApcmiHRUOnxGC6i5EUh9QPqRd4PHclqMXjrBbjVT4=;
 b=fDi4iqxPXk9RqT42fZDoCMot6qLhQOUDge35cTiQiMzpWzDjmxELNWEQm1gG9VSnyVHFTkknu8DKkAcxdZYV9XXrMaf1B2dcsMFAKYsPPra9+xIbINREu6U1nJzdQGl0iqFOdV0/52Rtpkx+QjYh1QFb45XCCJV7AjKBHO62z40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI0PR04MB10542.eurprd04.prod.outlook.com (2603:10a6:800:265::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 18 Apr
 2025 11:29:31 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 11:29:31 +0000
Message-ID: <62693ea8-37a5-48de-9677-067288a22dd8@cherry.de>
Date: Fri, 18 Apr 2025 13:29:26 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] clk: fixed-rate: Use "clock-output-names" to name fixed
 clocks
To: Fabio Estevam <festevam@gmail.com>, trini@konsulko.com
Cc: lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 francesco.dolcini@toradex.com, aford173@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20250417123156.2526548-1-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20250417123156.2526548-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::10) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI0PR04MB10542:EE_
X-MS-Office365-Filtering-Correlation-Id: 6630b09d-ab91-484c-23f9-08dd7e6c4983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aG54MVpCUGVDcFZvWUl4T3dPT3BCd1NjYzlwOWRZOWpoWE9GMTNxbmpuM1B6?=
 =?utf-8?B?akFNZmZLNDNFUFhmY3FXQkMyQmFiMjBiVEFzTkpWMUhkekJxd3VvS1M2TzJX?=
 =?utf-8?B?VlNzS3ArVEI3OVlaOXRxR2NUSWsxc2RmYjRxQmhvS3pZYWxWV2I2Q1BtSHVV?=
 =?utf-8?B?aG1rRTB5aFhteWM2aE81T0R6cFFmOFFRVFJ1K2tQU0d5a2N2d1ByUEJuc1U3?=
 =?utf-8?B?SklMYVlYWnJwQmlHQXc2QzRjVVA4cHRMZURWUmY0MldLT1hDOUs1S0I1aUZk?=
 =?utf-8?B?YjFGcHZKaldRTjBrTW5oRnVmazVHVG00czVCQ0o5VUxNcWxGUi81dlhnR3NV?=
 =?utf-8?B?Tm5XZWtNQmlWSk9BNmN2MFVyZVZxUW05OUwxTEtzRXJyTjFLaEI4dGh6cVBx?=
 =?utf-8?B?T1pNZE1NbExQRFE1V09HWXNhS0RoOFV2WWRwQXJqOG9BR3lPZmJaZUE1MEla?=
 =?utf-8?B?cWNNVDR1T0MxZUlIYTYwRU42OHJnamdCQldxb2JNRHJsNHg0dVY3SnNOclRR?=
 =?utf-8?B?WWtSTGJ3SDJIZ1BjOWVUSWM0aEJ2YmpTWGNhaitKN0N1eWFmcHVxa0dEMnhw?=
 =?utf-8?B?RWRSL3JpWHRzblVpUFZtTnc0Qit1QXRGSFFQaXIzWldRajRxRjdYZUlxSENX?=
 =?utf-8?B?ZlR6NWxPSjZCY0UycTBwY0RlOW9XYU9BOHY2c3BDdnZ0VGpzdDNrUjAyeHBt?=
 =?utf-8?B?NWxtZXUyRGFzOXlidVZhVW9EeUVwb2ZaNkNFQnNUU1JBOUNPc0JVVE9Vd0lF?=
 =?utf-8?B?NWRHdytLcVlyRS9iRC9tNXRKNCtaUmV4TkNxQnlQVTh0c2VWcFV3OWFPQnVL?=
 =?utf-8?B?QVhMa0pvNGpCbmFoUG5RVFVpb2xBbXY5ZmpXdDdxcy9TTVIvNHM1MVRjS0sx?=
 =?utf-8?B?QU90cUJQYTJPeUhISjRRU1N6MlFyQ2wvK2xFR0hhVmNwQTUxdjlhTWNHYml1?=
 =?utf-8?B?OXBaaDRxZXNFRUpTNVBVNDcrUzB1TTdFVXFkVFF3eUpyV0lrY0MvcnNuQkRj?=
 =?utf-8?B?WFR3ZVB4K1E0YnhlV004ZFZwTTBYSXNHa1hwR1Z2cjZpKzBjUnd3WTAwaThY?=
 =?utf-8?B?ak1WaitqTGJRb283MzMxY2FlWWgvTmEzd2pjNHA2RjJxcDlHbXNhMGhnUTh4?=
 =?utf-8?B?OFgvVS9kak5CeUZEQ0pXanBWTThrUlliUGNocXhEZE5nR1lMN255U1o2SWRa?=
 =?utf-8?B?WWhMMFdTcU5CazJscGlpbmtJZUNDU21LeEt0NnprTytpcWpWZGU5eE9UOFlI?=
 =?utf-8?B?K21mdjJ3dldYWlUvNjB6bFZ1ckFOY2IweGFmenA1TVRhZXhWcDhlV1lHdDdK?=
 =?utf-8?B?ays0NDFFT2Z1SWdibkI0ZVI2ZmdWTzIzOFRuUjhteXd6MjZ3Z3BMcUpMNjR0?=
 =?utf-8?B?b0ZIRG90dERqR3JOTnlNbFdhRHVXVXByNjVzOFpCdlkzVlFteVJyZ2JOSzUr?=
 =?utf-8?B?WURkZzJCVWJ0bGFVZ3pLVEhXRDNGQm1VNzg2TWJtWm5uYWpJZFdORWF3U29q?=
 =?utf-8?B?YmQ4QVc4VjBoYXY1K2RDVDZhT1c5KzRUeEhidURjNm9MdkZZVktqZ3B1RXpv?=
 =?utf-8?B?TzlGQ2ozWWNZTStxa2xFazVNcUtFc1A2N0VQTktDSG94M3NnRytIbExjVlE4?=
 =?utf-8?B?Nkw3eFNGUENjczlhZEs1RFJwTDlMOEMxVk8zNk81cVlRd3J0aThBQ09WOGNY?=
 =?utf-8?B?TUM5Q1VndU1IR3FlRHVrbVFXaWRaUG0wY0oyUEpKa09kOEFBK2FOUWxzblZJ?=
 =?utf-8?B?cVZVcDJBb0hjc3ZiU0FYUGtGcHh2RTRURGRPdXJRL29LeGgyTFJOV1oxSEtT?=
 =?utf-8?B?Sks4NGwrMUNOVEQrZkhjK2lnazBpZ3VvNzB1eTM1QzNzU09CbVRxM2EydXY1?=
 =?utf-8?B?YmNEMUJkbHNFM3RFYi91bzY1c3RNL1QzbXlTNDdSSFNJRHpoL1JmQSthNVN3?=
 =?utf-8?Q?My0Eh8jRsXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFhDdkhNdlZoM3dFMm9rUllMT3lnYzU5QmxRUmlyUUhhM3R3U0JyOE1hRW9D?=
 =?utf-8?B?RmJLUVB3OTVIRzBsVnYxdGk5aXl4SHdXSXZBODRYem85dFArT1FYaGxxQjEw?=
 =?utf-8?B?MlpkWFphaW1iaTBSczBkR2p1dmZNalpGMHJaU0VjRGo3N1hCc3UxalJQQ205?=
 =?utf-8?B?MTJCN0Uycnh3aFJtaHBnd3g2M05UNHNnbUc2UXZmcklIejJGWG91eExSSFY3?=
 =?utf-8?B?QVlReTBMaExZc3JURzNPcThtbVJHZm8zOC9tS0NPM1NpbTd5R1N2S2haa2do?=
 =?utf-8?B?MUpsL045RGRnelc3eFFoUUo3ODd5Q3dKOUlmVDY1SVlIZzJPRmplZXBvWEtt?=
 =?utf-8?B?clF5SXBRbFZKU1hBVk5JcmRzSXc0ZEpacy8rUlcvanViQWVOVWlCdVJ4eWdN?=
 =?utf-8?B?Yjh0ZFB5VktRRDEzRWZjd3g3UTNlMUMyenBmdlpJWHlOWE1pT2x4THVBRnNa?=
 =?utf-8?B?Uys3Q0FQbnV5YWNiNVRsVjM3dnk2V0pYbTN4eGVudll5VkVYQ2xoYms3bklo?=
 =?utf-8?B?T0ZRV2Z2RkhqVDRUVktpY2p2QnZXZU4rRG8zUHJYWklJNkRvWnBWMEU3Ym43?=
 =?utf-8?B?Z0VmYWVtdlVpRy92QzRkZDlsTmp1N3JPK3BZdFUvOU5GdjZuVkI0dHk2MHlz?=
 =?utf-8?B?M0R0Ym9QRzFuZUpQM21naFZEdGsxLytUZVJna1Z6b1Q0QVpWNkVOMkNYZ1FC?=
 =?utf-8?B?Q25iRithUGFNbnJTa29QQUg1NnEzTVkyUkpKdk9rSXBqc0VPU05YbHI0d1RO?=
 =?utf-8?B?RjZuMjNNaktjQ3h5Zk1sSmxheEIxRDRHZWhHM2hEK3AwM1VPeUtyT0NjSGJ1?=
 =?utf-8?B?R0tTbFl3NEk1TVMveWt1dHorazFIYmFOTTRrOGpZZTNxRklyc1FqSkFibWdr?=
 =?utf-8?B?SXVzT3B0K2JDNXRGKzV5SFJHT3JEODRwYUgwZWVTLzZha0tMODE3WExiRkZQ?=
 =?utf-8?B?VzBmS3I0MEh3d1lKWUJTOUVQdnBzNFBJaUEzWmcvYi9VWnpyWS91T25MWFI0?=
 =?utf-8?B?NmVZMjFrZitCQXRySGErTFFKczB3dEg1d2RlTEhJWDNmY0tGZHFaeGlqQ0M5?=
 =?utf-8?B?RGVuSUQvN3BJV1ZXVlE4SVA3eGYrWGRQRVVXS2ZOeTRCbWwvQlduM2pONUd2?=
 =?utf-8?B?cU1HdFFBeWUzblM0VzVQMGkwM0FOQkJJQXFnM09ia1REYXQ3ZFdMNkJ2K09J?=
 =?utf-8?B?UTVjM3VDQ2dTU3BLSDhjZFlTLzF3M2w0TE9Kc012QXYwYzRnOHVIS0VBcElM?=
 =?utf-8?B?UjhhMG1SQXo1K0V1WEFWK29uOEtYWW5tdGt2MVgzNTFqYy9pTThHODVSTkV3?=
 =?utf-8?B?VVlRZmx6VG5lZDhIZEVGVFNWdk4rTXNkK3RiOXZsSFZuM3dCb2RiZXkxVkwr?=
 =?utf-8?B?R2E1cUoyaTVqNEd0dzVFZmdiQjNDL1ltK0pENmh1aXhEdkh3dUxRaUEwc3JG?=
 =?utf-8?B?cWVZYnk5d0FKbWRoRzcxYTA2ak9XUFFtaWY4a05BWURnSDRCalMrV3E0dklL?=
 =?utf-8?B?WjNIZ1RCL0RFWDlPb2haQ1Rrb21sS2M4SlhqRlJDZjAxQmlmWnNoRTZXeTFK?=
 =?utf-8?B?cU5BUExIV2c1OExzemJaV1hPY25IQSt5RHRqSmUxdTE0b1MvbUdsT0UvUWda?=
 =?utf-8?B?azB6aWtmZm1MdEZpbjBYS2FEajg1WG5xblFaaVMxWXpwb2F6dDdRaXlXalRa?=
 =?utf-8?B?RmVNeUplcVVTa0k4a2FkRHpSdVZOMzcxZHdrcHhvNUdKLzh3YmJDdis3NTdX?=
 =?utf-8?B?cytYUU9WdDVzRmo4K3k4MUdzaU1LOXFJMDNxbUl3MitJcGVJWFM4TGdObHdV?=
 =?utf-8?B?dG5LSkp0d3hiTlVWWkJWdzNUYWVlVEZReHRMN3pWTkl0VzkxZDZBYUlONVcv?=
 =?utf-8?B?bFB1VURCRXlLSEN0OWtIZlFEQW84T1BMWld5cFcxei9DOGVaekN2VldYWStq?=
 =?utf-8?B?VkVmQkVrdDJqSEtEUUp5Y0tpRFZLS3I3WXV1dCtlWUxCTGVxTTVhdFp6dTZF?=
 =?utf-8?B?emxwZzZ0R0VKTkpselkzQlBsU1NweUdXN0IxT1BKWGI5SmkvcDQ0STFFZ0ox?=
 =?utf-8?B?c2REbDFGdzVyMzF5Z05uN2JmQXMzdVV6Yy9RWUNwMUJPYkw0MDBIY04xUnNR?=
 =?utf-8?B?MGdndEVxeVZZZTBoVEFxanZRSTlyOHdTZWJYbXBzQytqTGFlYitNSi9ZYWR6?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6630b09d-ab91-484c-23f9-08dd7e6c4983
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 11:29:31.2579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqPqBSInNyk42ATsUBslpPuVDoxhpSMLapOANzD2UfcK1pReyXJqXV68vG/M88cKhEQwuxDoVQpp41Kx8Kv0IehkUYRvBiSKShZdBi2I+nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10542
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

Hi Fabio,

On 4/17/25 2:31 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Currently, fixed-rate clocks in U-Boot are named based on their devicetree
> node names. For example, given the following node:
> 
> osc_24m: clock-osc-24m {
> 	compatible = "fixed-clock";
> 	#clock-cells = <0>;
> 	clock-frequency = <24000000>;
> 	clock-output-names = "osc_24m";
> };
> 
> U-Boot registers the clock as "clock-osc-24m", derived from the node name,
> ignoring the clock-output-names property.
> 
> This differs from Linux, which uses the clock-output-names property when
> assigning clock names. As a result, clock consumers expecting names
> like "osc_24m" (as defined in the property) may fail to resolve clocks
> correctly in U-Boot.
> 
> Update the fixed-rate clock driver to check for the clock-output-names
> property and use it as the clock name if present. If not, the fallback
> remains the node name. This makes U-Boot behavior consistent with Linux.
> 
> One concrete impact is on i.MX8MP, where USB clock lookup failed following
> commit b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*").
> 
> With this change applied, fixed-clocks are correctly registered with their
> expected names:
> 
> u-boot=> clk dump
>   Rate               Usecnt      Name
> ------------------------------------------
>   32768                0        |-- osc_32k
>   24000000             5        |-- osc_24m
> 
> This change restores i.MX8MP USB functionality by ensuring the proper clock
> names are used.
> 
> Fixes: b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*")
> Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>   drivers/clk/clk_fixed_rate.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/clk_fixed_rate.c
> index d1da05cc18a5..7b89f9c80e95 100644
> --- a/drivers/clk/clk_fixed_rate.c
> +++ b/drivers/clk/clk_fixed_rate.c
> @@ -35,6 +35,8 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev,
>   				    struct clk_fixed_rate *plat)
>   {
>   	struct clk *clk = &plat->clk;
> +	const char *clk_name;
> +
>   	if (CONFIG_IS_ENABLED(OF_REAL))
>   		plat->fixed_rate = dev_read_u32_default(dev, "clock-frequency",
>   							0);
> @@ -45,6 +47,16 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev,
>   
>   	clk->dev = dev;
>   	clk->enable_count = 0;
> +
> +	/*
> +	 * If the "clock-output-names" property is present, use it
> +	 * as the clock name, like it is done in Linux.
> +	 * Otherwise, the original behavior will be preserved: the fixed clock
> +	 * name will be its node name.
> +	 *
> +	 */
> +	if (!(dev_read_string_index(dev, "clock-output-names", 0, &clk_name)))
> +		dev->name = clk_name;

What about

dev_read_string_index(dev, "clock-output-names", 0, &dev->name);

so you don't need to store the return value in a temporary variable?

Cheers,
Quentin
