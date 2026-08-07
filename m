Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30540C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 15:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11A9981342;
	Fri,  7 Aug 2026 15:20:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XpgSyBElCEMz; Fri,  7 Aug 2026 15:20:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8AEFF8133C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786116048;
	bh=VjhuCkXuNvdIQSEWwdQzOJfLdUu0SNN9ui6f+oIukYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sxHdCpptbIzLjbG3+bzrz3KRz9Y6F8dWOCU7rTgUG/nVEoKzHjjEgN6Ur8zHfbI13
	 22Z4ALidgCB7xbk0yz6cbmtdxx5ld2wPDsxMqLmmcokgilLp+4pnU3eSySi2EtN9eA
	 elMxw5aT2ekSG4tiy8HkynUM2vlkowLDyEahpQybRf6k64G73+bGEyJJBqMVJwGzGL
	 CTxBN4+rrt2NlOOW9uJ+cSd/LCbtpqPzJCXlWcdrBhDwLN+lDE9mxyI5uq46oQ+Gzt
	 h4qpC386rqWgcvAiHWM3SRuQQYF7IEx5xCxiHAUScUN+7wL3zgdG6UIXIAICtlzkD2
	 S97k75k2e7kPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AEFF8133C;
	Fri,  7 Aug 2026 15:20:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 756642F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4FC3E40278
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AP72U9c41dEu for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 15:20:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7B99240084
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B99240084
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B99240084
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FB4orbx4P6k+S/0QzcOxftxRlMPS4Us5eKfEKEVuGVx218hbP3ti73/6Xauin+nlhiQWbkHDUHdE2azlyZzE+AY2MDt9OVodQLPUz4DqJdH9dMOzr55PbHfW00IV3M/rqtZTjyUpbFG6Oy7ib3Fukuy3LUu5/0htqEvQWHaNS4pSFnoMVUg20bGoXqPcPFYNoDMQKPDjO3HbIw6VwO1DOQcVF7yj7wVT7a/Cdh4IpsU7wpMqTXWf4AN+vaRmZ3CCaqqjwrdZQSHh2WY1PK9L0ChH62EcpOzMdB4LF8N7GTj9OS4L59hZFZJPggcEdhQgljpLLsa6GIGCzzrId+p1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjhuCkXuNvdIQSEWwdQzOJfLdUu0SNN9ui6f+oIukYU=;
 b=uK3jTsij826XmgrWd65p7gwza2zPek96JkG741IUZUmZTUlKDyyFxDymZdLnRCJK0Y4FZ/z2bBQrfcxQIsTTFZ/BIRLEvZUg4iypmJdmtVjD6vPzcbos4iEdYGeEQ/SRgJDZvQ68VsDuj+7uAyPZMo0unsG2eof8jAhYnmABVaD6IlCyElbcWlrBK1dw0JV1wwLvrCqykhcEyWKcV8LxrMrrDeApy7AcH598BnJMffxHhOO7THGarOAQSf1mGbcdVeCK8AfCbL0UTMNYpOCv8MNcoDoXw0S4mJrt105Afbq9gT7a3LSSH5MyslyWa6+ArwV0ksjdEEcZQpEeercKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM7PR04MB7159.eurprd04.prod.outlook.com (2603:10a6:20b:111::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 15:20:40 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 15:20:40 +0000
Message-ID: <9a33f421-a269-411e-96f0-0f3851fe50f9@cherry.de>
Date: Fri, 7 Aug 2026 17:20:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] clk: rockchip: rk3588: Fix possible divide by zero
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-9-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::31) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM7PR04MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7cd3a6-b821-4d02-48d7-08def4977092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10070799003|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qRxN5+6B4DvHecHBUCPpfJ739k3/DJP0H29mZk9hGW3QDgTfCDErECVaXsb+hc8rs1bWR+C8fo18ABQ9eFjQYWSUmycNpbbyuMZzBtvEZVUzzHSF11iMs5BiLnei89laSAL2EsVk5F0NLCfVgiKDJie9ubzDE6KxT3LcB+VVpqDsQi078HT4yTiGQMWsp7nTlmzsCZ5bZndgnTBZr9xzBjm+BfgINAAQBceGJ1R/IowcvAdZcB+P5GSFWWhIHmX86jdZJW8WVh9TdFOcthb/idbCmwMPC3a/50GdDGNaQu7RRsyGlJz87RAE99zOghxkM3wESToaWmeUR1Lo55BIJ/1pHaFDkgy9xmZou7PImdtiTncnCj6UX8//xHhm7eMS6aVLisr6sKruoVz4G9kqGgeaxUiGvykEAWSjQRcOHi+kP/o24h0N4bKWcoRiEols9NsghCrVj2hM/Fk6pJ/OVsXjLMpttBjP7YiNbVMT5Gc6K377V1E54OHmVsiVYezDNi80GgNgR/4e63mY55kMqIGpnSZUlgbZYP/WWJbWgXWBa8nSvGsmQCzE4qKo1oZAy1dxA24GfOlRk4oGvzcONbanu+N+pg/IufB4+W/Oi9kDhHajdGR0tZwILawqDlQRgxV5lXMMa+8sUUEjCEVA0SZNEGiRa8+XeARLeLphe4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10070799003)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFVqN1ZoblE0eWUzNEYwSEFiVnMvZUxROXZYd3dtNllJY1U1c0phcEgxVFQv?=
 =?utf-8?B?ODF5SDQ0TW92VnhmYnhnTXVjTEFoSlF4WTBCOGI2ZElITWpwWVN4a3VaOUdr?=
 =?utf-8?B?UjBVZlVHVVN0MjRTSUluNFVEOCtKQXZZaW5NVSt0OVAwSnJ3cVlVbzZaWFlT?=
 =?utf-8?B?R2w5dkZLcXF3YWFJa2g3d09xRkVNM3NuN3ZKN3RhSDVvQVVwTC80eWxDTkVQ?=
 =?utf-8?B?TnBleFVqS1VYRFByclRPb1U5Ykt4MWRjZCtZaHNpSHBqOU1KMnRhMUo4Wi9C?=
 =?utf-8?B?OUpoUGs3cGoxL0dCczhuM2czNkQrb3lKcHFLNituYWtxa2tPQnFFLzZVRHp0?=
 =?utf-8?B?TUEzMW1NS2grVFV1emZ4WExTTWtsTENVcUdpOHcwSHJ0WjNkYWl3SGQ1K2J2?=
 =?utf-8?B?eVdMS1hoS2xkZWtuay9IaFNKSStDT2QwMnlaNUZRT1ZhOVBvaXBSZHcyWEd1?=
 =?utf-8?B?WlNybyt1UjBvdjd1bm9Id0RzcGp4bm43ZFhyZitjZDNpcTVJVUc5RlNzM0pm?=
 =?utf-8?B?c0E3cVJNK2FZMzNDQmlvR1JkcWtzeXRNdnMzWUo2NW95alhmakc5TUpMNnBl?=
 =?utf-8?B?eFpnYklzWnpCZDNpb0E4V3JmcHRnMng4eklXSXJtK2w1aExmNUhWSEtldnk5?=
 =?utf-8?B?czVKcGROZm9XWDlRTEhEY1dTdXF6c0EwUkxjNTk1L3BHREVvVEFIK2lTaXNT?=
 =?utf-8?B?bXlUd3ZXUG5BQURNSUhlUllaZ0lWMWYrazZ5eHYyZW9PaGVtU0M4ZlJRMjRq?=
 =?utf-8?B?YWJITUQwYzVzZFIrckdyQ3NqRzEyTjYraEZ1VDRuYUxWeDhnSjlWdUdIU09S?=
 =?utf-8?B?bktWL09KZTI0ZlEzSWwveTdSQnBLaHJ1UUF0d09rZUZ5YjQ2cWJJWTNzM3p5?=
 =?utf-8?B?blUyOUlJbDMxb2toTnpwQmF3TTQ0REhSUks4cmlUMGw1OE5rQkVFWDJLclA3?=
 =?utf-8?B?b0o0Z0ZmQjJ4Ky9PTXpNdHRQZnBGSXJuRUVZcmN0NHArZ2FQU28vc2JENzBJ?=
 =?utf-8?B?UWdaMkRlUEdnTG8zN2JSeUNvVXF3YmcyZzhVMVJaY2xKaUZCZDQydVpmd203?=
 =?utf-8?B?SHJnK21RVVN0VW5wa29rWW85ZUxpOEdCODRFOERzbERObkVBQmdueEZFcU5S?=
 =?utf-8?B?OWNUeEFhRzVNcC9RUDF5aHNOSUFLbS9wc1lGWkpTQTJBaXluU1lBS01Bamtr?=
 =?utf-8?B?SGg0cHlJMkhQR2dqVXFqeEdNbVpaNmtkbkE5Vm53NERINnhJL2RxYkJUcmJM?=
 =?utf-8?B?SDdYKzBGd3RyY2pKOUxaOERpTmdmVnBJVkxqWmVIZWozcTljREJnSnFwWkVu?=
 =?utf-8?B?ekRJMk4zR3F3bStHTmlPUFc1ZEw5UElhNlBIa2FtemswR2tCbkZYNnVVYUdH?=
 =?utf-8?B?MmlJbVd4V0RrSHE1czZUN1FlYy9CczVWTlFxWUt3bHFUeU9uMVhFWHdYVjBN?=
 =?utf-8?B?NWFYOWFHd3JveU1ONFlMd1BTSkRrcFhkVW16aGRZaWx6a2E3TWlpb1dreVVr?=
 =?utf-8?B?U2pncnNDZGRHZ09NQ2tmdFJwTUVTRzJmSEJiNmlQMDByMTZVVERrUEc1L1lh?=
 =?utf-8?B?V2pyUHZoc29SNFlkOEJYOVhOcGZpTmJraEh3MTBlY0FVS2dRTFNuM1VPdGFv?=
 =?utf-8?B?Mit3UTBGTHpsOE1uWmJCV2s4TERUcXAxNVZncGJNVnQ5ZlBMTzBhSEZSTXJl?=
 =?utf-8?B?ODlzMDZKdXdDZy80OEYwNUs2ZlJRd1NuVWFUaml3Q3J1TEtRSlNxVlkzTHdo?=
 =?utf-8?B?MTNFVDFBdytlaDdBZEhiZUJWOUdBZm4wM0xQT1E5eUNDdFZlVjZ0b3Vzd2lL?=
 =?utf-8?B?dGI5OEZVb1gwbTFCeTQ1VlhaVDRtV1pOSGF2K3NxTnlMOU9ad0dPY3cwYmQy?=
 =?utf-8?B?eHV3b1dRZkozdWFXMXQ3UEQwclllaVJXZlRra2lXaEJ3WkE2T254bVhmNFBW?=
 =?utf-8?B?eUgxdm5nNC8xSENpZXRyYlM2ZXNaZFFNamNNNkZGSVZtREE5Z01oejZSUDVs?=
 =?utf-8?B?WkIxc05BQnZNZ0xUc3pDNjVMSGdZbVhIVUtOMzlmeENmS2FhQnZRRUtpNFUr?=
 =?utf-8?B?SDhBWlVyeGJzZGZUNUhpTlYwbERnT0d6cllPY253THBDZUpHaFRRSlRuNFc3?=
 =?utf-8?B?VThPU21MVWdQclcxamtPZkd1a1M0WEF6YXlOckZhTFNWbWViaHJKZWUwK2l2?=
 =?utf-8?B?VzV6Y2daQVZmK1BKQnJJdDREWVBPL1RBdFAveWxqTklmdVJ3blJWUUxkUlBZ?=
 =?utf-8?B?VXdJTUkwQTB1STNXYm8zV1cvcktWb2FIQWJMUkRuUFRNY3NsTmRKY3dJOU05?=
 =?utf-8?B?S0VTMzhNcE00UFlkbFFlRE8rbWY3M0dxWVpFVVcxK1pnalQ4MmoyVkZjaFo5?=
 =?utf-8?Q?wBmM1BHEJwgOdLnwp4ygvcN7dysAHESrl/xWvB8lPpYfa?=
X-MS-Exchange-AntiSpam-MessageData-1: Ru7nv2StRG5OeDXDl8o4QKbBh0LskRynwO0=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7cd3a6-b821-4d02-48d7-08def4977092
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 15:20:40.2101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSy9MlSrXE/ZHtwmSWvC9/Z/S2IELVkehhqvHcoawaoYO4w+bedijTUar/cov0YUTmil89Sh/rkuQs6JCy7JNsC/kg1RGCBEEScMvoTjORE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7159
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjhuCkXuNvdIQSEWwdQzOJfLdUu0SNN9ui6f+oIukYU=;
 b=NTjgJmanZNjM8SMMBKRT+lWv75cK0QLMlzi/gGF8W1LoA3z5+B7smtwgUf+Vj/YDWcgEJgA7VJh0NlgCbtyrjxpFvov9LacRumrHbAfl/r9RIGxhlCVnrjD5HICAsRtzC79rm9cvpRn0udQxRNGbv5Jpnfz8TGJQYKESL/jzEEQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=NTjgJman
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/30/26 4:12 PM, Jonas Karlman wrote:
> The best rate handling of rk3588_dclk_vop_set_clk() may unintentionally
> trigger a divide by zero when V0PLL is tested as parent. Instead, fully
> skip rate calculation when testing using V0PLL as parent to avoid a
> divide by zero error.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
