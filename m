Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3957C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 14:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D888006D;
	Fri, 16 May 2025 16:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="LFyzC2Vz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57BA880107; Fri, 16 May 2025 16:03:30 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5789B80050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 16:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILkMq5riE8/jexxUrf6qp3RDEaLSnDDo6deK9CHD62Gir50LV0pJ3YSHuNAuSQgyCyfMcX+J6a6Ka0eAp5cJZYtW+EkZN85LoZi9srmSo1JpO7gXbtiFR0hUzjfyZeYtkgFKZrj+SFOTkXL5kqAMuhSxAVLXXKKRQAYC22in9Cq5EOdXN1D1wGdfkPNRr9DC1861yeBdrsx2DORWKweYUwcRn9Ka5FkO2OVBapUMOgOcHDhmqKeFJpBxN4LiovTVWmR2kw6/C+yzarSAD8r5byNCCltPsBb3k37Z75q7lQw6XVyKeIXQRY1EOmD7C6twXmuYa3qpV9L25jtrlnmTww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=renB3SrgEvVDSMFtxbvzoeHdjCHRw4tkbqnRghryf9M=;
 b=MqynffVeL6JRrVwIgNJCJLigi11dCW5RUUMvRk3zHYN61hNRUkzOmaYcLHBkSHIhhkLnV0gO0UC3wZZvF63/tlaC8vTd0/fctp4sIAm0jIbPl1dimMEbTBEo/MvpYfpWGo5Tv6VemZcuUGvsCJJQgEs5w2/6BSBoLdf6Na3r5C8v6bkJia3zN82QzKlkVIV9OK+sopH62nduEjgl2Ycoo6bI87Ai12XRR1+m2rYYvr9Oc0xaebDuPZ/cTuFDYIoX5v24rIoKayI7WxdSUPJiCcIQSYo16Y39T8vJozBEGMaVbsz42V9iCURrvU6JGXMhSsI0hUivRlv07SKqtvCh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=renB3SrgEvVDSMFtxbvzoeHdjCHRw4tkbqnRghryf9M=;
 b=LFyzC2VzRN7UlgVMgZuBO2OjiifNYkWPr/JIS5E2Z9gEajq6DP5bmcSCUoz/WEwlWawceRoxOE51bjkKaOlUnklLAM2AKzRSb6j3RXlVJ/Uwz0gFMS7vOmHBqx1ZF8Ac7Sn4FlXC6ARW6B/RCDzWSN1x0aaM1RW7t8BPleKe4Ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10099.eurprd04.prod.outlook.com (2603:10a6:102:45d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 14:03:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 14:03:26 +0000
Message-ID: <8a95a200-0fe4-48d4-b536-ca2a266caf42@cherry.de>
Date: Fri, 16 May 2025 16:03:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] fit: print conf node compatibles + use property
 string constants
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
References: <20250409-fit-compat-v1-0-56df89ef486a@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250409-fit-compat-v1-0-56df89ef486a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0033.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10099:EE_
X-MS-Office365-Filtering-Correlation-Id: a161e762-8bfc-4ae2-19fa-08dd94826d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zng4VW5lS1BqWGpOYVBKY2E1WFZST0hBczY0SkhUZEZORmlnRWRyT3EvTzVD?=
 =?utf-8?B?Y2V6L3BxQTB5dE9FTzVrKzJ1WEp3OWtMVGszdVhrcG14bGUzQnRibUkzUXVa?=
 =?utf-8?B?WTc4S2trd3lzYVczU0xGaE9XekdhTktuTktEaFVPdzI1aEVTMkRpc2dRSUdC?=
 =?utf-8?B?WEVGK2YvaHZCbXBUK3FvZUV3MWJORkV5SC9JeC9NYU9sQ2FybjA3OXFqR0hm?=
 =?utf-8?B?MEl0b1gvMmtscGJhQjg5UVg0MG9MQ2VOSi9hcTRPMTY2ZnFDdmJoSU15ZFlW?=
 =?utf-8?B?WWNkZmJaYWpJZXppNFdYRzVQb3VpWVVMbjZ0N1ZBUVhoeHZKMjgwcGloRENJ?=
 =?utf-8?B?cXBrVFNDNVNLbVdOWURFcVhPVkR3LzNvQ0xQcGplMng2dU05MGVmT21ERlJw?=
 =?utf-8?B?V2pnZkxPZWg5Qkl0czRZT3BpOHUxQTNOUy9lVDNRYUw1cjV2RFZPdmVZMGZo?=
 =?utf-8?B?anVZWXREZnl1bW5yT1NCb3haUHd1NTRkWDJBOG9zQTZwZCtNNUJlV1BwcG5J?=
 =?utf-8?B?bEN3NThOTE9OQmJ1TWFKZ1E3dDhRODJsdDloNks2a0RGVlpsWGdFUkQwUlBa?=
 =?utf-8?B?WHRKTmszc04rOFQxT0ZneXp3aUk4S0RsSnVmQUNxYmthOTRDUzQybWVFNDcx?=
 =?utf-8?B?VU9TcmNHSTlpOVlEU2VWV2dhNUhxdDRCTHNLMW1uNGREcVhBVk5XRGRjclN2?=
 =?utf-8?B?WkxvYnIyMzNFUHZpV2I1QWhzMmpBOGM2RlRnYktQek50c0FjdnF2dGxoZHc4?=
 =?utf-8?B?emdycmVzbm1pNmlDbkM1bmkxSEFRNmFTUVVuNjNnRWgxajFaNW52V1V4V3hW?=
 =?utf-8?B?NG1qdkxFODk3NVpTYTJOaDk5YnJTaHJpVmprbmxvaStITi9aLzRaT2NzVzdl?=
 =?utf-8?B?Q0drTzZocU9GMElvYnFhOVAySGVvanpNRE9iTGFMTGpHWVFFcW9sQ2FibEpU?=
 =?utf-8?B?TEdDNzF4T292K05ic2lLdDB3dXJ1OWhmTmZSQUZJYkZzbVJ1bUZNeWVEemph?=
 =?utf-8?B?OVU3anIwcWx2RDVKeGZGZjBWRGloQzVEMmgwQ0N1Qk91a2ovZm9iREpqRSt5?=
 =?utf-8?B?Q3BNbVlnNDR3NS92SjNGbVZsM0IyUGxNMVE2cVp5MVFvRno5c1F2RFcySTZ4?=
 =?utf-8?B?WlVJRU9CUno0UFdFaVg3Qk50ZVRIaERiL2lyYXFFNGh5QzhPcnl2VVVwakNO?=
 =?utf-8?B?ZFNhZzdHWS94UDVBWkxLMXc2SzJwVVA2QUNXNjVYZ3M4VklHMU1hQ3pUNnFy?=
 =?utf-8?B?OHFDbnFOaU9WL0FXbll1TUM4R2Q4dlBJaUtnVE1KZzZKQVhnb2F0ZHNUYm5r?=
 =?utf-8?B?K2gyUlRBaHlQclk5TVpnREJiby82RmFDV0NDWHFxc2pWK1BNZzNzclovWTRu?=
 =?utf-8?B?SkVFblZ3bSt5R09FVUR5dnBLMXJIOXBqdDNwckFmaGl6cUs2MEtFNXJPelBM?=
 =?utf-8?B?bzFlUTlSbVgyRk94TldKNUZzUWZucy9tL3JpTm90ZEUvOUhBeUgrNk5VUlgx?=
 =?utf-8?B?a1JEOHN6eWRWaWlMamNJMW92cDd2UGNLVFdOT0p4TWplVWJJbUZNQzE5c2FN?=
 =?utf-8?B?TGdpVDBQUnlYUUU5NkJ0TDI0ZFllK2RGVDJZbFRwelRZeTVIeXo4UnFGOHNJ?=
 =?utf-8?B?bmRQdFZEYWIxNDdOaDhZK2VSOTJ4NVo0QnFGVWt3Y01rcDVsU0l0cVV4ejVP?=
 =?utf-8?B?TzEwUmQvZFZtdmhINVNCVFIyYllUSnR4ZktxS3dQWFIwVExLdXNKNjIrM3Vi?=
 =?utf-8?B?OEZicUpvaENLaGpFcFNKejdwSmlROGNmc1FkTFdtTWx3OGt2OS9BR1pST2tC?=
 =?utf-8?B?SXBkWlkwOURnZkQ2YVdwT3BPcXVUM1oyN3diT3ZUaHhxQ1NyK0FDOG9neDNY?=
 =?utf-8?B?TkRRTFZkWnRMcHFQeUNaMGFKNmRES0Jwc3g3RWlQOWU4R0hQMzZjdlRrOXVz?=
 =?utf-8?Q?w8U1KYc5Q9w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU5FbUUxKzhVSU1Fd0g3cGoyRkFjK3phN2d0S0dNRzVkS0h6WXFtUTdWS05z?=
 =?utf-8?B?RVVscGFTS0s3dzB6YzcyNVV4OThaMnpJSDNreU5mVDNIUENKYlYvWElNN0hR?=
 =?utf-8?B?YW9zUVVyQ213WFRFVHBjUWNncGZLUFlrMlZ5aDNqTXVOTlNOMGJJWTN2cTV2?=
 =?utf-8?B?OENQTEZrZ1pFb3V6S1lYcHJjSi9sS0ZSdUp6M0tGRGU4U293V2ZRdlJFTmdu?=
 =?utf-8?B?enNPbSs2QlZ5cWZnYWxjSkh3c1NPUUdJcmhtNUhLeXVuRE01U1lnWCtCNTVz?=
 =?utf-8?B?TW9ibHorRkNHYTZKZGlKbnIwWG82T1Bzd1drOFAyUEk3S1c1OHB0ODQ4L3F4?=
 =?utf-8?B?d0gvZHY4U0hTZ25OZGc5MUltSTZHSktaU01namdGa1Z0Tzl3K2xNOFpwcWQ4?=
 =?utf-8?B?SmlQMFJhMHBXbVl6aGNid25UbE85ZnBPVk43Yi82Wlc4YU42SFBTSnpwOVpM?=
 =?utf-8?B?MWdQaVliQkNGVFpQS2lOVzU2VVBsVkdDbGlFN1NrdFgxbWlGNnd0akU5akU3?=
 =?utf-8?B?OEtkb2cvdmxYZjNRRk1NOXI4Q1B3eHo5SHRiZ3R4Q2duL09BUzRQWXRNRWpx?=
 =?utf-8?B?bTRuS2JRNjlJMG81NEYwOTYxQkYxVkZnZHpVM1pLbkFweGJRVSs5ejZpTTF1?=
 =?utf-8?B?NDh2MkNCRGRNTVdiUFFJbVJ1cHFBWnYyVFl6THgvQSsvYTM2RW5sT29takJY?=
 =?utf-8?B?UXBDdllkU2hwaDV5UHYwS05DVkI0RG92SG91VVNOUUlwVHhkaW9QaE43R05D?=
 =?utf-8?B?ZlpFY0VnSmdaVXlhdGdHRWRTK0hpMmhqazdTa1FrMXZ2aS8yRG1KWUhkNzUr?=
 =?utf-8?B?M2QxQzl3Z1lRdUJKdFVaT1lvNEVmV0JtcVI0ODdkZ1N5aTU2aTdodkwwdTVR?=
 =?utf-8?B?SmtYNXU1eVpWU1loQnRVVks5d00zY3pKYlZ0d3JhNkF0azkyZzBTeW4raXNY?=
 =?utf-8?B?OUZ1Wi9rcDJTNzBhdWYvZ3p0M3l2ZkE0NkNZMTRVdWw0QlZyOElrd3A4R09C?=
 =?utf-8?B?dDZCcnNWaUJrY3RIVDJJZzNtWTR0N1ZlUUFHY1VPaytjZzgwSEFCMUhiRStG?=
 =?utf-8?B?elRmdEY2VlpRS3lrSE5pNmc2NUVBV1VyYlBDYm9DN1dIMitRb2dwYmQzTTQy?=
 =?utf-8?B?ZmNxZFZqNGRQdGJHdTlXZWhNUXV1aVFnNGh1RVJHbUFjeUdNV212MmRQdEFp?=
 =?utf-8?B?aTMvd3Roeks4cE84OC9wck1sY1Zha0hTaWZsSGdvV1g1L0o3WVNKOW1JWnhG?=
 =?utf-8?B?NnFmTG1tYXpuREZvSU85Z1Y2TVMrTFl5Wk1WbVJtdmxacUNuSi9lbzN3TUZQ?=
 =?utf-8?B?ckxiMzFWUHpFT1hZK2kyMEx0aFpxci9nSXBXSHRaSS9hQXhQV2ZqKzlxWXlq?=
 =?utf-8?B?bW54TXVZaTdwZE41a1NKelVYUTcrVDMvZzBJUXdBUDN6cVVBMXpkMXp4VkRN?=
 =?utf-8?B?NTd6Q1oyYTNPVExJeVdTZXRSNkpWdk5ETXdBWTA1VjFSL3hmNTN1T3VIclpO?=
 =?utf-8?B?bzUvQXdsa2ZGZnpxZzB4M3dhNElpWVI4U3plbEJZM1RqMnV5a3pEam1yTmNB?=
 =?utf-8?B?WFQ4bk9qd1J2K3liWi9mTnJaWElBaThwc1NRZVFReDhtbGZLWXU2Z1o5Zng0?=
 =?utf-8?B?eUx4WDExTENsbCs5aDFidWZ4WFljWTM4ODMwVW9uZGluR3RCYk1VcDNCNk8w?=
 =?utf-8?B?MG54ZUx2czAvaysxTmR4UHMweUZsMjVwbTVGbHBxRVVta282dHFuMWtEYWtN?=
 =?utf-8?B?WkRlWjlYKytQSXhjbWFDNk15bVV6cVhJM2RzZm41bUpkN2pPc0t1d1UwOWFZ?=
 =?utf-8?B?aVVJQ2ZhcUZBMSs5M0Rmb3YyRnlGOWNOdzVoVmo0T1E1YmUyU1ljVllmb2ps?=
 =?utf-8?B?ZEYwRjJhZExaV0ZwWGJ4c29jY05tQS9VUDhxb3dDV05LYWEySnlQSXRuZnFr?=
 =?utf-8?B?VUVCRUQ4OW5jU0NTRzZLejlIU3pqQndmeGlvVm9zdURGcVlZancxMktlRXZK?=
 =?utf-8?B?MXBvbjVzQ200QmNadDM2RVpVaHZoTEhIbTFSb2lEQUFwZzkwZDZTdnVzTUox?=
 =?utf-8?B?NEZUMlAxckJKUVc5dm1nSFNtNXB1cms4dktBUStRVDRtdzd6K3MvWGs3NHpp?=
 =?utf-8?B?YVRQS2VlZ3Zpcmt0OUlsditma2R2c1g4TTRIMDB0dWRvRkV5ZFBhek42WWZx?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a161e762-8bfc-4ae2-19fa-08dd94826d6e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 14:03:26.2353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJL9Y7SVIIgZXsC3RTLxv7C7o95pUXYbP1DnNtRvM1f5SQtWYP8fyV+Sd++vqrDL1GDLeMCopW0TFlabWL7c/uFyVLuG6ISA8eozTnptYVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10099
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

Hi all,

On 4/9/25 5:10 PM, Quentin Schulz wrote:
> This does a bit of "cleanup" by reusing constants for some FIT
> properties instead of having the same string in multiple places.
> 
> Additionally, this adds a new constant for the compatible property in
> FIT configuration nodes[1] which is useful for FIT images with multiple
> FIT configuration nodes to support multiple devices in the same blob.
> U-Boot will try to figure out which node to select based on that
> compatible[2].
> 
> However, if this property is missing (and the first blob in the fdt
> property of the configuration node is uncompressed), the compatible from
> the root node of the associated kernel FDT will be used for the
> autoselection mechanism. For now, I only print the property if it
> exists, but maybe it'd make sense to expose the fallback one if it's
> missing, hence the RFC state for this series.
> 

Gentle ping. Any feedback on the series?

Cheers,
Quentin
