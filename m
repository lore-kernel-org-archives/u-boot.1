Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252F5C5B56A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 13:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB3F860A6F;
	Wed, 12 Aug 2026 13:34:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CFdaskH2oM26; Wed, 12 Aug 2026 13:34:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0BB4460A67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786541657;
	bh=VHsey6X8N3QMUzWUdfrLlGK6535F/7qSg6nUi4sj7Hs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VEyU3KmoSqCZ/VzmM3/k2SxFcPYKFTNXFk9G/m0HDpimLqJpaxa/nEDpnzeZTXpXd
	 e5/jos77D+dub9o0Qxc67ce6C4Sw/F3OJO3hLL1uFYU4jQ2YaSOenrfOJJEi8LGlU8
	 bO8Ei6QKVPnG4fD2s7+P6OvbzvWdYxwyrjUTgDWe+uYXwZz/QnC0xKQpaa21TwTAu2
	 U3yHzu8wLUMOcBYbyebigBy4946LdPZ+2C2wDfXlWju0+g1GpS67q+ETjbhmeV4kLn
	 unc7quqIIhawkgwmc/EhqcpJgoBbCrzEFiI2+VNRqGI/vXC1hpiX4zArdNEJHX2ted
	 To8KpNN5uKlMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BB4460A67;
	Wed, 12 Aug 2026 13:34:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AAEE649B
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9CD4360A67
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:34:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7hVvav0QIBXY for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 13:34:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BDEFE60A63
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BDEFE60A63
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BDEFE60A63
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emG2Jrec84wiCJHPA17Cm1Wxsf8JrvvQSkzPRmpaNm4UVRMobsmiZYTGs+kNMpqoHy9HieZ7YAL09CjJWH586awa4xxwz2ly976blfj1ywmfUK/I2xrgbYDNdwl8rZDMXFMqo6FkiXkE+2zufXYCKiprvFUn0Ggov+o+xJTB3waFdNu4K9t0T95drUx8hO/E2b0F7F1pYgT98NGi1PoqhDjMLdBYeUOm1h/15rZ+tzrwraKuyHP+6tpgMCSzUT46kMs9uI8+WZWqewh2LxscEyAOpP/W5coLcCRMLFwq01ZD1BsugOGRkn2Vrb1cXxJPgXy7iq9Vvl0yNNnE1K7mmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHsey6X8N3QMUzWUdfrLlGK6535F/7qSg6nUi4sj7Hs=;
 b=pbyVnl88xrKKk++gH2kb4ccAyZ3xA+ta2DxsoCQniFCW7wMSYM2PadNZ3DA5y5JKE0YtIPV7cEvLponMc1vo5QAeQcK6GYyyDHfvpddH/oyY3yAzZCTRTmKHwjqBVFKPuD9+nrFTgY5tLcDKFTzQbQDLF4hE7OxKnHsNdco1F/YbvGxdvUTSN43WpRUk0AGpYq57dEFhoIKAiFhvrGvVOqVwz03vdo6DCYsClayRbc1FT47Ah3K5d1AZpvX6h9dCOt5/YbXmXX/V2PUDBh1RVwhj5sZXxyGXhrnY4slrDG6XjTvGEydqT2/dvC6LlqP+MKPfTPuFT2hHi66PXBlfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 13:34:06 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 13:34:05 +0000
Message-ID: <44f1970c-aee2-49a4-b532-80abd7547e12@cherry.de>
Date: Wed, 12 Aug 2026 15:34:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] rockchip: doc: remove TODO
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
 <61027ad5-678f-4598-8aa1-cba5e90c4e2f@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <61027ad5-678f-4598-8aa1-cba5e90c4e2f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::34) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PAXPR04MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 8316dfba-7196-4012-2cb7-08def8766147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10070799003|11063799006|56012099006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: 0rkziH+YnqZqlN03s0CZpys9/6pGqY1tKeshjYhEEzKaS0XHGifNOVMBCEBpvTXVjxuOqBzZX0Sb8CutsYAavFnKTa0puHa+Me+K1XsgAwEAUTW+EAQ6nP3H5kkoTjNCC65iv9cWIT6RXjLkm4lfmeS+t37uIvTw0wKWU/bhssmN1QV7/1aE0VtYC1zohAwSEec1ld0Br26mWWrLHpJgsWq4alaykenxRxFpCZ8obfd+fOyFXa+F2peE08cABwNc3EBRSPJbOZJC7cata+wGYd3PWSoVeKk5zsDdG8PSAoKchgjkE87/9fuM0EBN7NT1b0YryK1YECt9fCd8q0LyacN/pY33q0rF6OYaWh3kRRivuBSp8jiCGcsDR7LOX97LAS95rJ8YsOi4RklB6JM3HpMBj/Nf7zmuonCQv8l0/Ob5wenIbyU8hZfzlhcRi2O54rKWXGuPIpcme7zsLAHADiKdKQ/SgtAlbN7BGiWNQHb0DsF0VqYjhCWU0EMTFs5aGEumP1b3BswHPiRnuOPc5jJBe5pYgd17gbXPiHGHxsURaxCgZEnd05SitmzQ1KGBoyfTNqwuB0DGrOANAgEPEhCNLcTu//GKFexkpDgpdGBdY0mw8epeYvDjw4Gb+de4ZEw5swfONz9K9oJl43l1A3WOJiNVM09+D/4RaeJ7oY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10070799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUtKY09WbG9UNjBWNWVwK3ZOT3RvS1FzeDdMMVI2WmhqNDZmWlhFM3E1anBD?=
 =?utf-8?B?dnRGbFVKVXIyQmlJSitLaDJNd2VaSWVKVzNBcFMwMWRBbUR6bzBabkpEOW1P?=
 =?utf-8?B?UGtydko1ZlpzYlY0Yms5MTdpaGFXWWtwYXF1VGZBUXlpT1o1d3ZyR3FxUjBa?=
 =?utf-8?B?NThTMXNWY1ZTWUNBMjJjcVN1WDQvWGZ2cHp1SURGTGt4TWNtWmc4WEk4TjdF?=
 =?utf-8?B?UDlmSEZxRmRTQWdzazNiQ2x1d21DQ2hLQzVJMFQrR2krV1dHR1U3b3B0SFFZ?=
 =?utf-8?B?eXZERlhjK2pXK3VNUjM3cVVyQ2dJMkZLVmd2ZC9KVWw4MmZBMFFMRlM2aWx0?=
 =?utf-8?B?VXNoMXFKMzVqbUVuTkh2RlNkSEJZUHlTT0ZwdGtZV29FSitWb3NsZTVxY1Vu?=
 =?utf-8?B?NVFEdGpkdEd0amVBb1dWcDFlK00yTXkxdWFIckwrM2ZJYm54bHFXZUZiM2Zz?=
 =?utf-8?B?R1JlZUZOR1NFU2lvMXUrMGtTbTRhNGtGTmd2K2kwMXFROHBrTG9vcEJtZW9Y?=
 =?utf-8?B?djM4U3hWM2lDbTZmZFJiVmJMVlkydG50d0Joc3dtdHBMMVQvY3hYaG41UXJH?=
 =?utf-8?B?NWxpcm5LT25vcjQrZndTWjhRc09DMnJXUldhUFZadm1hUGlZZEhtbEtzd0tF?=
 =?utf-8?B?NlV5UlNxNXVjaHQwMUo0MWhzV2lLTjh6YXRYTTZzM3ptNWlQVHBXVHhMemFq?=
 =?utf-8?B?Z2dndkd5eUZGaUFFNlpnMzlpRk9ndmJCd0FHd0M0b3NqaUtFcFhpcUl1QTk3?=
 =?utf-8?B?YUcvMmJhRnd6TnZqS1V3L0haKzRad1AwMWRwK3FCc0NZM2dHUFcrSFcrMTlW?=
 =?utf-8?B?Y3gyUzdLVGt2SXdrUzQycS8yY2NiMnNDM0xxUjBRc0Z0N0hzZFk4YjZFaTFO?=
 =?utf-8?B?N2UwT0hHVDd4NGZyMmE3ekozVlFhT1kvVzN5QWdLamJSUlNpYWxOKzdTMUtu?=
 =?utf-8?B?aXRoMnpMQkc5QzNzb3FJdWRPVkxLS2JkdHhmOHJ3U2NDSC95d1FzbmtyNmlm?=
 =?utf-8?B?UVBodEphUXd6UmxqZVpsT1pmS085Ui9ZR1FoamxlZC9QdkU3NkpTa2drUEY0?=
 =?utf-8?B?UzM4Y0w5cWtnbzBZQTRkK3l0Q1ZFaXFoM1JBYUVFbTlpUHQ2ZWl1WGVXL01X?=
 =?utf-8?B?QzN4Tlc0M0FiSWxvaTNMVysvMlRKTDJXRi9Janc2ZzZybmMyRm45bWtEeTR6?=
 =?utf-8?B?aVhPZmRJMGxEUEJWcjdhNXpaSlhDVnJnaEt4YXhNRkJNQm8rdnU3bDR6QUti?=
 =?utf-8?B?YndndWwyUGh0UDBsMEJSc2x4N3NiRjVMZWd5eDN0ZG5DV2tOc3JpcG1udEJx?=
 =?utf-8?B?UitVcVpLME1meGMyY0lyRlJ0ZXgzN0VSVm82UHhHejN6a3UrbHY0K3ZwQUFr?=
 =?utf-8?B?Y2FLR1kzaGwweEpLU3owaEFiTUdubTgyb0pObVYyam8rVG5PU1ZlcW56WXRs?=
 =?utf-8?B?YlM1MlZzUHVIZjdYUERUT0xPOGtHSUhPb2FobmYrOXJEb3I2NFRFYXl3SGhu?=
 =?utf-8?B?SFpoSWJFRi9NdFN0UGlwcUZZMDc2R2hPbkxDa3BNemUwUWh1Si80TTZubWpR?=
 =?utf-8?B?djd6UEd2OW1ZbFR1dW9FMkUyUFF3emNwaHBWVHJqZStqRU42dU9vbWFsZk1m?=
 =?utf-8?B?ZGlPbGlJWnZoalFReHpVeGhzU21PVVlKaE95aUYxcXFTZ0laaXlsQmVpYzNm?=
 =?utf-8?B?bzEzTTBuQThCTDBmcE9qbkJJcE4zUVNnRGlObGxiUDZkTExxSzJibzVJWXll?=
 =?utf-8?B?Y0JjRjZiNFU2bTZzaTNraUxWMkZPQmdEbjBYUDEyNGp0dG13UStXRDVqQ3Ba?=
 =?utf-8?B?eHhUVXJCVmRwa2tRcDk4VEhRd1BXakdqZldGamVKN1J1cUgvUDFYcUZzdW5z?=
 =?utf-8?B?VHhWV3RiUm4zZXJiL3QwajhjRGJqakpLWFoxRUVHZmdqTDJFdVVMcG1talN2?=
 =?utf-8?B?UmV0YkdvQlN2QkxacXlkNUR6ZVAyVG9RQ041NjkwQjB1cnNYMHdPVWxXZE1h?=
 =?utf-8?B?eFJOMTYyczRvaVVaYk1wRkljSmF1TklKNHlCY0FwYU54YWVMVVVUMUhkSldm?=
 =?utf-8?B?ZWQyd0lsMEtzRGM1ekFDMmI3cy8rbDRQcktINXhsTUlzWnFya01sN2VXV1Jt?=
 =?utf-8?B?SmQ2RkFNMkpaZ0V5RFFlNjhPaHhwWE1FMEsxb1haVlRRRzMxaXlObTRST2Zt?=
 =?utf-8?B?VmF1SDdhRGt0V0syTnRKci9rbzRSMUtvYXlYYTkvc0RlNGpQblVrejNvcXJi?=
 =?utf-8?B?elNrajJrbDJlU2tlZVA2T2t4NW5LUG5DaXcvMHRBZUFFTk9hZCtzWXErVTBB?=
 =?utf-8?B?YWZWWHR0bEdQUW1ra2NxbUF1c3VXbE5oN1BrTVZ6bWZUcGx4SmdTNXhyR0du?=
 =?utf-8?Q?nVOing6ydBp0Idc0mTGA3xSHqLNdys2eqN1HLsePYI0gv?=
X-MS-Exchange-AntiSpam-MessageData-1: 6NDWNgtySGc+cA==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8316dfba-7196-4012-2cb7-08def8766147
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 13:34:05.7219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0Bmm+8TfQB59AUdZNexbY6zHBKOo3oHUMW1cfCi3q371drRcXT2Pg+ky/dPHsNbiFgpzGv06KDkvwYhZLClo48PCTnKm8ZvAsOKVkew9qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHsey6X8N3QMUzWUdfrLlGK6535F/7qSg6nUi4sj7Hs=;
 b=kbZFkK1WcpUEaA8dT4hDpzzdYWOb5+4hpxiFbCFaSorXpiPTq7ZnEsfuT7QIsANlhVKOVbn+9/yTmKQgf1sFUjsXTM6cE99iONL8VSXvSZzQshZwLacs4+1BM9c3qhkpyjVrNhTIKu2Ev3e+M3zn/FEoMyv12x7JvPktrjAzRsk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=kbZFkK1W
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

Hi Johan,

On 8/6/26 1:11 PM, Johan Jonker wrote:
> Don't try to guess the future consensus. And don't add
> a TODO if you don't have the intent to send an immediate
> follow up. Remove the TODO in a constantly changing document.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
