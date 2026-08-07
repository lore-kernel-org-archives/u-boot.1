Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C064FC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 13:29:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF2D46090A;
	Fri,  7 Aug 2026 13:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FrnLRhIMJH5x; Fri,  7 Aug 2026 13:29:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EB76F607E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786109369;
	bh=0X16Mu8ft8OFrlruPc5OlaUjTEn3th+kuD/k4guLVgw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=av85QYVawpZe6iYujZ6YPcNvu+hDCyT+ZLD32QBkHhLsbkLl7VFi6fcfBd5/uhaq/
	 irNPRHsDnK8JgbNuTRWME4sCDd/rEF64fuiauQQME4pTSpQL0MlaRSu2rubvcRll5M
	 7ckdEWrQIVNP3lriKl1AuR2hvvbYOD1xwZ4vdHrQoKldqNBIcK+vQOHdOAoYnzZ6jI
	 MuTRUemoTz+uEvw2sPzYmCxtJG0yQOSFs5sAYbjis4oBfWXlOPsvcuQCfbm6+4Bvza
	 An5OZfVk1hZkt/XbRfzh4rIPAbEFaWaJFdih31eiLRWjXZ1ouBER/NSq9RKKHdLoUR
	 CV+zuspk1x3Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB76F607E0;
	Fri,  7 Aug 2026 13:29:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E62A5218
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E3E9E607E3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:29:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X00LWE9uAwd9 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 13:29:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 265D1607DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 265D1607DE
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 265D1607DE
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:29:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXPL1nT4iSpLfYvNlFcDU0GCgasl17N9UPF9o3NRtY0CqRAm8+CyoLJNGo8OV3UWcjzcaYhPbiWwyHcO+5/Jln8WbETtNzSMW6Hg3To4nOg/1LLnqBJUtBhvQk6yCilGzUHw1zLUGc3/Xeb3cjgII8FQW27lP5vC08MsNWFG9dTOKg+jcVz9pI/HBbmmiXCjgmHTGl9U6ONtTIhTMMwMcX3oVxdo1xmAaseq6V/bux7wskZBOUalJ3+zxxeD525NDtL02hm7erk/2j2aSxpR/qPRWJ5FHG3H8o4mG6KxvJYvWK+lvP9FG97ABmvjdDe+T07iIyjJcxAfECeLGHReyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X16Mu8ft8OFrlruPc5OlaUjTEn3th+kuD/k4guLVgw=;
 b=khJqmjtFFe8Mywk6SocNgcrEH0H2H/NYj2qxqhRxRn78W4pNrrVxi5IxvO0zQVykAnlgOS9z9im+bEYaERyKrNq40VkwaBn9OHZVtTrGXNlzVspXDv0Isb7fmiJsqAb8eWkPpYoQcTD6+S1riYDBLKsNhOMahztW1jKpSUk6K2uFecL4vOoS0BoYTgu8fD9F4n0TXngUeisuGdQTd7M+1CYhuqbLJtyhohyGX5pFI2IAeSEZmUYESdL+qLv1a5JE76XlgDMBRUffu5O3vpndSFrChkQtoYk1IowXHyZNxdS3UCnrfSQaUl5HhuOLjNz7nT5EzJjaANxCcjZT+Lc1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by MRWPR04MB11286.eurprd04.prod.outlook.com (2603:10a6:501:79::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 13:29:19 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 13:29:19 +0000
Message-ID: <ea45a145-5620-4796-b297-01315fd78bb9@cherry.de>
Date: Fri, 7 Aug 2026 15:29:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] clk: rockchip: pll: Always write the k param
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-4-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0105.eurprd09.prod.outlook.com
 (2603:10a6:803:78::28) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|MRWPR04MB11286:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd47559-1fcb-4ec2-cac8-08def487e23f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|6133799003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: YKVI4XphqvbcpSTNpNhizEEz8b5nspmp8PlM/hw0CIeiPGj2+TRWnZc4KPaIz4qWjwUJr0w/HoUrndp+T4P+ySSLlDilQJKqJ7CKvHgVI+nz6DMzgBjmoKU/5PxDjDZBxo2h/DhF2ARgp6IA5KObddUICzmH4WsV8tmRJVxWYvVpfQMfDkBkIw7fWHEGAXG4jffkWO5aGGOSjw540Xuz4KLbgfZ21qsmKv7tcEjQeJAR/Frm/s3Xaw5vt6vXLkNgitdMbLTYSwQbsdFmzIm/qYZIauik3kqjHsnqrqitGXTE4mxIJR91ENXrRzTAU8+58/3EhYDnNZlgEedWJDIfrtlTrhg3b4GmRJu/ZV9/aO9HMcJ2dsYx4cH4aR9s2c0qm514rWUiPGd2i2ctwVzrmJzAsNl9EK5PcOXnnuLG4yhr2CeeaDQOUFFRHCIKmxOL6dWtNpvyeUUXDpUOwxiehjYpxORjjyT8yu96FkmmObs6vD5xivhBFj3ZpgO9PX64jYdme2p90OjnAGnVuCJ3wmereqHHo0+mQ9ltzPsjDq4IF32enEbnCVsFwfTnSSiKVPRDlmo0CkENuNEOQlu64pH5aqUZwDUjclYCcHAMQJNyvaTrnDsLbvLslwXDLg82/1l720r96Dc63SCJ15qUYFWJ6xRn3W6RI9TePB1AdoU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmdrNXFHc09SREVxTFFYVUw3cmFYbnhVQkVUUVZhVDVidWp0T29SZmpVMjB6?=
 =?utf-8?B?emZXZTM3ZWtiR0Y1OTBvamJVWTRLV1BFdUdTRDdJVlNaNXdmMFVqSjl3cVFR?=
 =?utf-8?B?QU1QM2hUQ2NLaWtZUTI0aDVGLzhkSTFtRXA5YTFCTzVpREN0OWttdUVhOHBE?=
 =?utf-8?B?UWw4cSs0K2l5RnNwVHRIc3dPSnpIcndpVFJtUVlEaUthZDlFV2Z4UFFJREsr?=
 =?utf-8?B?emU0dFpqcWVpeTUxTVNNbWhqdmFPRTE3Q1ZLdHhVSFcvVEJZOThmU3Q3eDl4?=
 =?utf-8?B?Mk5GbmRLRXZramlEZnY4dUYxMENKZDRhd1FrRlFldWRXRnowRUhCUnVXQkZU?=
 =?utf-8?B?ZjI0N2hQZzFxb3YzZnZIMUYvUDB3bnZQVEl3V0p0R1BNai9ReGRsQ2FlTWt3?=
 =?utf-8?B?dUlWYklLVlAya0RDTWM2dU13SktxeTkyR0NzTy9xNGZtaVRHVGJqV3gxQTJC?=
 =?utf-8?B?ZVdWWFpxOFFJdHJSUzAzWXh0N1RtOGhoSmJmWkFzZXRwRmFFQVpXeXhsRVpn?=
 =?utf-8?B?YVNLY2dzTWZZUXZNOU5GVGFncG1mOW5lL2p2V3lmenlDUXRMVHlEUDQ4ZEg3?=
 =?utf-8?B?T2NXRDlLTkluNUQ3QkhBSnVMSkk1NDZKcGVid213dEtYN1M3eExkOUZ5bWJW?=
 =?utf-8?B?SHVsVjJTU1BaTEVYT1hyK1B6VEpIa090SnBHYUdUenkydUF1eVUzaUh3Y21y?=
 =?utf-8?B?ZTQ2R3ZkUG1ZcEFEYU56UVdGUXpnT1h2bEMzekxiNGhpTjdUTjdrVjZraEFE?=
 =?utf-8?B?YmZYUzdOajFjbi9XVHBtL0RwZkFlV2JkUHYrQmJ4a3BOMll1d2ZkOVMzZnFS?=
 =?utf-8?B?ZDk1SWFBMTNOYUZzUmxtTUNNbkZneTlGRkg3SENxc0p4UWVidjFtMDBCYk15?=
 =?utf-8?B?aXQ5cEVYa00rZ2Z6Y1pzb09QZ3JlQmF6ZEJpV1d1TWNiSURjSU9ZWGtBQ1kx?=
 =?utf-8?B?NFdPNm1acGl3aGY3NzJ2T29TanpMTWNJbzlRcHlka0dXMmZiZmhlekhjN3M5?=
 =?utf-8?B?MUlFZThaaDM0OVNQT2tYRnZJamNoVDRCWVdVb3pTZzF3MVNEK0hDK2lGMzh0?=
 =?utf-8?B?V21iZHFkZmNrTWF4THBydGdFUzRScUMzTmZJbStrM0hUbG5ueXZaUm92eVdC?=
 =?utf-8?B?KzB5c2RCd3FxWjdoYmlEZ1A3YVY1MHNsVSsydjZOUEVVYS9FNTY0Smk0MDkr?=
 =?utf-8?B?SlRIS0tWTjd4ckRjMFd3c3MwOWFOTkxXRndLa3J4bXlQTEpIL3JwTGRUd0Js?=
 =?utf-8?B?QUJlSGROVmp3RG1DY2owUnppdmsrVUVWQ1RJakZBa1A1RlZyeWY0S1RWV2Fh?=
 =?utf-8?B?NDNFZ3UwQURVMzkzWXJVSkhsOE9CRXpBdjVHdkxvQTJWNVRockYrOVU3MU1y?=
 =?utf-8?B?d0s1K2Q5LzBHVDNtVFR2WTFRQzR2aEs0UWxnMHQ3S0lYYTdQbFR4SUg2Zkhj?=
 =?utf-8?B?dTJuWmlJZDJ5SGdJRFNQOTlhN01vdU5pd2dyNlpLbXhaTDNOTU5JT1BiV1hn?=
 =?utf-8?B?V0dkNWdYUmpsOU4rUTF6Y3BVaVJ5VVp2Z3JLTHdjaGNITlJSb05JNGZRQ09P?=
 =?utf-8?B?dE82SzVydW00ajRldHF2MmpNNnNET0Flb1FKaDI1dmYrMDVVNnhqbGxPUE55?=
 =?utf-8?B?YnpuY3lla2VtTEhZeUtPUHVDQmR4VWZYMXp0djUwdkVaOXVlLzF0RXAzeVFm?=
 =?utf-8?B?b0d3VnV3RGVJT1pZajRCRGYveHJXZWZrcjUrVFREdklaRlZQR0J1V2syckNH?=
 =?utf-8?B?cTFYMGQxcWl6K2VkdXduL3pudSsxcE9tOWl1U2lwSTB5RnZuT3pCQWVmbEho?=
 =?utf-8?B?UkVVbW5GdzBJcG5TK1Q1N1ptR0hIQURqOGZVVmo0OGlRY2lmbEROTnFleC9H?=
 =?utf-8?B?dnIxZXNQQm1VQXEyNE1BV1BaQWVSenBmTjNHdTNZNkQrWG9PMXJSTHVtVUZJ?=
 =?utf-8?B?THQvQW1UbGVOVFhTbzRsZG8ybnNUdDBiZjZhcHlzTXR5c2xLWFM0ckh3YkZt?=
 =?utf-8?B?V1M3Ym4zaVVUWHpQYmJDdE1UM3B0eGNFT2J1cnplZ25yOGIyakR3MmdzclN1?=
 =?utf-8?B?R2VKaEpFRWw0QkE3QTY2UUFYTTVaVHRVMzNMUEhCb2xZWjdZM1dZdHZ3azNl?=
 =?utf-8?B?UEdaVWZCNUN0Qkpxa2JrdjhvT2pKbnI5SlNBbDZFMHFUUmt3VEpuRG5MLzdE?=
 =?utf-8?B?b0RvS25VZmRRVXBweWdQQ004QlBhUjdPTER6QjZmZG9LWWZUSlErTjRZdC8r?=
 =?utf-8?B?QUZwSU96N2dSdHNoNjZSOGZQSEtTdEhIdEZVTHpPUmp3WHRvRFY1OEJzS2pj?=
 =?utf-8?B?blcwREdoYmRnMXJaSXYzdENzQjlQRXpaMEo1a2lQd2RjTGgyVW9QMjZqOVdq?=
 =?utf-8?Q?vbsdPqeTW0VS+Dncd2ZPIou0n/0tjTObmM+w30wOForC4?=
X-MS-Exchange-AntiSpam-MessageData-1: D2XfxDtcabuLlQ==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd47559-1fcb-4ec2-cac8-08def487e23f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 13:29:18.9428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1cXQcE0viAakQMnSnAoZ8swuXs4kLuxQNwlvOaex+VtgTzmnM4H4vgQsZCQumER+S7A6S+NqESvnHZrXM3weF/7C52x24UDkpGu85bmsqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11286
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X16Mu8ft8OFrlruPc5OlaUjTEn3th+kuD/k4guLVgw=;
 b=JnhL7DiA1WWIxAylU4vqKp20oCg2guDrNQHUATH5LVXuLY6/gjVq14V0hDZF1cGT4lcaAHoFoiUJkC0HyAE7nVc6H2SG+klhYM6DcTvT3P43NDDkHJPJcWL0xmyyT4i0B8F/a949DkPWtSpG5XTZYxyzAZMrpJDKmRfOsD+6Cco=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=JnhL7DiA
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
> The k param help determine when a rk3588_pll fracpll should enable or
> bypass use of fractal mode.
> 
> Change to always write the value of the k param to reg to allow fractal
> re-configuration and closer match how Linux behaves.
> 

There's just one worry that we're writing to undocumented registers when 
this is called on an integer PLL for which PLLCON2 is not defined in the 
TRM (from the discussion we had with Alexey some weeks ago). However, 
the kernel does this already so I guess it's fine.

Fixes: b851c006a150 ("clk: rockchip: pll: Add pll_rk3588 type for rk3588")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
