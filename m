Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66808C5AD4E
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 08:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2795D40569;
	Mon, 10 Aug 2026 08:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8OYMuC3DTU0p; Mon, 10 Aug 2026 08:56:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5683A40577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786352175;
	bh=GsOyXtz7vybv0Vcyhp7XmETQsoVwRyNV/c/ftWj+/n8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p131iJ6gt+s9paNNiiD/Pkc717mFJaUebhjag+jVW69vaRTBt9PYe/xGq8O/BuZtm
	 ZofaXQvG77ExgMkyILzWAPXeCrXmIA16BiYQ0V8vYsT/j0ji4IkCPzKUP5RlivprD+
	 Jrre60O+zIdXqFM2yzrBAaOpCcIq82lU6Nae9mShNDsX/7izTeZRcvvIkkpZABiDMU
	 /h8bMUDSWrmkUVLrefJc6zDjdi8rkWizGVDOfd1FKXngL1elzb/KLNIGe/gHPB1O7s
	 OeEOLOh8A6h+flQcEKkC2L4hgRwPuBmJbGiKBNgGD8bqOWNh+/I4fcsr3Zak7acCp1
	 4skgIabsepZfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5683A40577;
	Mon, 10 Aug 2026 08:56:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD1D8282
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 08:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2F9F40578
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 08:56:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ksl2xsFBkkst for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 08:56:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C7ADA40569
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7ADA40569
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7ADA40569
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 08:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA4ZTOFjNrwhsW1SJPsVplrs5Q6w+g1MDYYbnkBslVKaWGBlxVbCOrpNqfd7j819pR0el4azwweeYBTOtW1lvQgYk6Fx5wh9dVwN/2b7kOsbuEIQ9WetvAf3z5vz1L5u58Cj2rHPTodklhQrbqI6CjQ1XpQanQB6EapasagNcMoY8NFnAkIh+/p63aw2tPvs22guxk+je+BcR+ODk8PJ2qZj5+veyDy2m/NQDmNzBnxZ2djbUU6RhEIHvJLlqqc3rzmJIyoPqS4vJvpg9TSmmJUry1/RPUYswRZxrMbT5BZW9kZoO4G6OuNHL4P1U85aV74JQyDZrygKdJY23Q/NCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsOyXtz7vybv0Vcyhp7XmETQsoVwRyNV/c/ftWj+/n8=;
 b=lG4NzX+W4FscVZIPYOX3xfTQJ5uwXmBI6cvirngcU4eky/gmEs1vU0bPXeLiKJWpG0aslhvviwXtnWm2fY2ccxInOcyWVCMboN0017RN6bRF8sjX19WE/1HEWzLOC2oldy5q3aT/zXLoxR40oQvj5Hb1x78AZXbIdeg+BFwS7GpmLCPodsWej4Se6En2+cLGclEkYHLD4v4+eUkejdHogEu9PFTevNJb5L6KCTdfxbGodtr3K/fclmERxJV68QiyylJ4udTW5kOaRKbe5cQD6evn47EhAR395UGXYuXe22njXxzAtvCaxAFfbJG9GyXfyUZYumnMqYaZAmCto3O/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBSPR01MB0009.eurprd04.prod.outlook.com (2603:10a6:10:200::5)
 by AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:56:06 +0000
Received: from DBBSPR01MB0009.eurprd04.prod.outlook.com
 ([fe80::882e:c2d6:872e:9974]) by DBBSPR01MB0009.eurprd04.prod.outlook.com
 ([fe80::882e:c2d6:872e:9974%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:56:05 +0000
Message-ID: <a138eb67-da6a-4707-a07f-8adad205f63c@cherry.de>
Date: Mon, 10 Aug 2026 10:56:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] pinctrl: mediatek: simplify Kconfig
To: David Lechner <dlechner@baylibre.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>,
 David Woodhouse <dwmw2@infradead.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Julien Masson
 <jmasson@baylibre.com>, Mingming lee <mingming.lee@mediatek.com>,
 Fabien Parent <fparent@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
References: <20260807-mtk-pinctrl-kconfig-cleanup-v2-0-509a8f833181@baylibre.com>
 <20260807-mtk-pinctrl-kconfig-cleanup-v2-3-509a8f833181@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260807-mtk-pinctrl-kconfig-cleanup-v2-3-509a8f833181@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0012.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::16) To DBBSPR01MB0009.eurprd04.prod.outlook.com
 (2603:10a6:10:200::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBSPR01MB0009:EE_|AM7PR04MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: d05b9753-29fb-491d-b276-08def6bd3681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|10070799003|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: qifP3oTOjMGDvjCxACPcNNUA5IdGn0TweEVdXg9RAwUDVxBd8pp2JrAR9zPV5ugWDKHcZsUfyWAh45nozWp/NPRMVevSL/uN/p/kg16JU03bTx9G9o67ceLxnKuh8TX3axYZ/d6NZFOpq0vi691iQpkPphYS63mSbRUrgrm3y8VR/47YpuCHevslb2G/pp+gGsNRKoaMzcqffqnK7oNfKd1kcU/bwT+k3I/mtp/geJjUTAwxCQBW4JGXaucytnf8Y62znScRC1WKwZG8/Wt1P0vzZ0NqMbrP30FD9SOwKo06EPUt3K/XcSS67mzffGngjCpg6lvgUCszrHG3Flr99G+MiT+sO7PycOqlhjOuJcqGTmg6b4T8MKh/HcMjGgiyyiyHNgzBXboAjnSXKYA7PKMSQVhVy2Q2MzFsI2KazqDKSJg4ZIqsxBGGjb153ATbmWu3BbC1egwWwNdb5J5yYPwqdx5+Exugkv09G6bLpdyiNpaLe7w8WnrycIYbtnrQZ3qg2OAxFxahceu2rmopo2rN0d3TvMQFL6ITC76syRt6IaWe4zM3OstIuuRDZJUKr3j7pAnEx0IXyezDsntGO7xksSqjCUSfrynr0F2p/tz0XZy68PKJwBsEBVcOoMZIqFLsYwLgi8jkI+SQadyWB+nro0mbimyait+dVPjGhbh+PiGlXsvQUcy52k1vQn79O/GuiorKALlV47b7HUHZFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBSPR01MB0009.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1JNdXo1ZExiN3NBeXhoNUVxeWFwUEIxd3NLRVlWT2RDZytBcVJqL0RjL3VU?=
 =?utf-8?B?K1lPL3dpNW5vQ21RZUFldXJxZUs1UUt2NVVzZXNDdUZYQXJDSkdyZUZGUWN3?=
 =?utf-8?B?WUk1UllpMjJEVXhJbk5XN1VNb2pjSXhoTUNRNm54SHFSSG1laURlV3BsbzY3?=
 =?utf-8?B?RnNIQ01sc2dWVlZucTYwT2FkSUZBb1dpWW5oU2YveUwvWm5CZWhTR0g5YTJo?=
 =?utf-8?B?QUJ3cHF3MlNxNGswRk14bStUaEhMSkdxazlsUjJTbUpTSTR5RS9XWVp5OERL?=
 =?utf-8?B?NDF0L1Rjc1VSSzk4eU93M3BnTytjSWJYRkZjeGU1TXcvRlNWdFRBU3FrM2c4?=
 =?utf-8?B?LzhQY2NPakJvL085UlIxQjdBWUhsa2dnei9ubndBYkhPaWJNL0ZBcXdpVyt6?=
 =?utf-8?B?RndHT0cvbm1mRGhTMjdYQ01OV2MrTTJCdS9FVnVscU9lWWo2NUg2YVpXc1RN?=
 =?utf-8?B?cm13MnJwZ0VLaVkrQzIwbUM1TENPMEtjUVptQ0hDQUFKVEpBemY4T21pNW5W?=
 =?utf-8?B?LzZrY2ozOUZiZnNxNXpoQTBXNnBsMXBySFgybWRWM25OSUxLNGZOeFc0ejd0?=
 =?utf-8?B?YUEvNStPZU1ORG1PQ2VucW1hTXlmbVVLbWVzUGZ0Tmp5M29FMzZuemdndUd3?=
 =?utf-8?B?OS9mVnJESUs2ZkRLSUQ1NjRPejM3RktkbTRkRlhFeTRzVjRNUGlSL1haS2Fx?=
 =?utf-8?B?STlIeE41VWJ6UFBVVEFxTGx0azZpbUxtdGp6dTBEUDdHckw0VFo1U2huVGVG?=
 =?utf-8?B?S1IyZXB0VVM1Q2VKYWZZSkNKcXhuMjlrbmhJMndjaTVSWEV0UFcxMG9nYTJS?=
 =?utf-8?B?YlJ4Sk9rU0thQWVpVko4bGFFUmh4Mk1SWGtTd1paWFJpbjNuMzVLV2JFQkxn?=
 =?utf-8?B?REU2V2lyMFpyUFVNSHlreHF1ZllOczRKZWx6L2diYnlSZkg4dWVFbUFOUU9Q?=
 =?utf-8?B?aHArdFJQNy9PN2lBY0tDclJhUnZkeDVGQTZOWWw5bHE1RTJYT0gyaE1Ldko2?=
 =?utf-8?B?QnFVN05qbThxL0d5V29WMXE1bDBPc1pDMFFqdkFUZy9lbHI2QlhVRnQ4cnBx?=
 =?utf-8?B?WkFvOGhNZ2VRR1JBRjBCRk9DdHFhTm9kWFFOSkRabEJoNGt6eFdIUWZFdWdS?=
 =?utf-8?B?VEVZcnVtUkxZNzNzak8wZWwveXhweUR3WFhILy93alY1NkJtS2t0bUV3WUda?=
 =?utf-8?B?eHJ3UDdVODBwaWUreXhBOWZLVURCcXJtOEdpN1d2c2o2L3kxYkI3dTRLQldD?=
 =?utf-8?B?R29RTVRyWnFsMW1oZUN5UkFtTElBYkw5TTQ2akdWU041N0VGRm5jVlpTZTJK?=
 =?utf-8?B?Vi94TS9YcW8xVE51dDFqUlhDY3lvZXFiU21RbTJ0WmlXZW55aTc2bktwYyt0?=
 =?utf-8?B?eWo5NFhMMGtrekhkd1pmSldHS2Q2UnlIUnVMMTJYR2JRT2lnS2ozQlNvU0Vu?=
 =?utf-8?B?UGVkd3poRXdpTytGR0Q1MktQOTZyY2RGZmUzRFN5UkNRYURsdVUwbjBFN0cv?=
 =?utf-8?B?SXZ2cDY1SDl3NnBPaDdWbm5HU2dlTkdyQklWL1hJNU13SEgvblNHdDhjN1Va?=
 =?utf-8?B?UjNUMnNLcG9qS0ZkZ2xabDdrdldObG96TTg0RWNab1VUMXVkSnMxNjdXdDU4?=
 =?utf-8?B?LzVIcDR2eDBnaTd3MHhoV2Y0MlNaMERqVUlnSmdzTUcvcUVLVTJ5ZHUzSzJS?=
 =?utf-8?B?U2VNS3hUMW1PTVc2Ty81dGczRVVXUzY4ZGVxelh2Wm1qTkswTnRRbm1IQlRj?=
 =?utf-8?B?eUUwb1ZjOU0xR1hxZE42RkVyanZJcGNUdkJ3dGhJbVZJMWIyRGJRQTQrTzgv?=
 =?utf-8?B?ZlE0OTdtd0tMR1FDK2J2ZHBlVnphN0dXQStSL3BvTTJVSHF5UTlEL0ttbVhS?=
 =?utf-8?B?Rm55TzltK0x1SE9nYi9hbEo2M0pSYlZMbjhvVFR0T0NBSllycjVoZDRUdWdI?=
 =?utf-8?B?ZXQ2M2YydXBUYWZWU1R0YVZscmVlZnRQRWU5YnVIcVVGWWgvNC9rWXBCb3ph?=
 =?utf-8?B?Q2dIdittWW9ENlo2dzhYbDVaR3VnRklVMUdyd3BYbjlkU3BQdGRpTzdsMksy?=
 =?utf-8?B?cWpON2hSdlJLRlJ0QStEWDFGck9ETEZzWXNvYVVOMUNkM29qYVRHQ3pzOEhw?=
 =?utf-8?B?eDczcldpZ3hqd3FpRkpJdnJZRGJnMmVoSUttMTdOcEFKYVl0L2hiNHY2VzEv?=
 =?utf-8?B?dlRnZnBFa0NxOUdMb1JqVHF1c1JmakxqNTNqMXpJekpqV1E0M3BXK2ZWdkpB?=
 =?utf-8?B?RkRhWGc4Ym1JOVNIYTJuS3NFMDZHNEdEL2tGSXpITEMzc29kM0lxbFNDWWFE?=
 =?utf-8?B?MUlaR1Ira0R4WlBUU3d1SGJQN0FWbiszdkhETlgvTkVqMC90cHc4WkR4UjhL?=
 =?utf-8?Q?FwYJSCWfEapW6gfKfi45jcUAfa4ga4kYdPruSM/IQ3dC8?=
X-MS-Exchange-AntiSpam-MessageData-1: aM9w2BElhXk2WQ==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d05b9753-29fb-491d-b276-08def6bd3681
X-MS-Exchange-CrossTenant-AuthSource: DBBSPR01MB0009.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:56:05.8968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1RPBQcOsJdLqwX0PU4BKUY0yVcTgT4o8+azLaZGzSC5pjpeqKbg9GCluk1zBQ6XkPfGxWvu3NckcbajXQQq6yclj4KTaZO2bW/1lMIxado=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7046
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsOyXtz7vybv0Vcyhp7XmETQsoVwRyNV/c/ftWj+/n8=;
 b=m0hdoLIfxb/PhowIaTuYuFaCroz00r/568ApWhABx0UhUTLkhcxbboJwhZ1VFmWXMRq8wOCfhkghmFUax046UfCfewyzPUvIkLLfp9ZaYCSYInORWFpNkvQSR8pn1b86EY3HZ1P1Z0l+cCLOfUG748bmpJeHUvKNAlykm3ORflk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=m0hdoLIf
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

Hi David,

On 8/7/26 9:16 PM, David Lechner wrote:
> Change the MediaTek pinctrl Kconfig to just have a single option for
> all targets. This will simplify adding new targets and SPL support in
> the future.
> 
> There is only one MediaTek target that does not have a pinctrl driver.
> All other targets enable it by default so the configs don't have to
> explicitly set it in addition to just enabling PINCTRL.
> 

Wondering if we shouldn't simply disable it in MT8183 defconfigs now 
that the symbol can be disabled? I'm assuming the day we have a driver 
for the MT8183 pinctrl controller we will switch this back to default y 
for this SoC as well. The issue would be that the day we do that, all 
MT8183 defconfigs enable the pinctrl driver by default which may not be 
wanted. By disabling it in the defconfigs, it means it needs to be a 
conscious choice to enable the driver once it's supported. What do you 
think?

> In the Makefile, we can use the target config symbol to automatically
> select the correct driver. And the config selector on the common file
> was redundant since we already have the same in the parent Makefile,
> so it is dropped. Targets are also sorted while we are touching this.
> 

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
