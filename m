Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B85C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 16:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC3828036F;
	Fri, 17 Jan 2025 17:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kRdkVC0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB37C8069D; Fri, 17 Jan 2025 17:18:25 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D667380312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 17:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKgkdthjsokpuJXqN1Z74IDN5ESKpesD8RWxF7UkK81dKH/Af6HzbYSDOdVHz2WcPDIw7z1n5XdZabXyXFItDg7zw8mOuep3YvhcUKwPGekkWCsyhfK6ij0kfniWIEUi7CUp+Hv1fRLS7KgR5y7QVFEB5vi7mXZkRvpNHodloI9uuoJJOZ5z6uB64RlSDk48FmgCm+2QAtP6fRPkgGBWion7WpY49yEs2aWmf6FlrF1oXYQA1UBLXEBZ9rs5C0BkKtQxSXF6xzb97ula08mOfywcLeNb8ssjSpHt7OyscQ3l2vvYHcv9YzLHZ8WAeazRMRjUDjl2ulO2qnlZ3i64rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvURmSq3fB4wcMFva0aeWrSZUYZ9vKiAOPIUaJ9RVVU=;
 b=UlSfEF5XRjxN3rc9AQxRcL7nyp2+5aeQF8TqrJJhLQIigd2Z7kNqrOzx4+vpuem3BivRYIRF/PDvVkzrQjd0vWl8lbbW2VO23oALSw/zv1lRUo2KujBp5KyrV6DtR/9QAcJ0hVAaVqQCeW5uf9dvZCCXLuHq53oeH6RnKu07eMpATj8eDuoy44j2KFaOZBL60XhgujHefaX5gKFxhzRDC7bGLgUWRZTPS1BxiGEFjtpDzDDdI2oEZXng5wuVltVZanaWsGkgyxtQSqnIaIaTwhu6ywZD2QEtGr9N3rgq+1G6gOLhfg9RZYB4cMKSEXnswOxh6idbOrt8WN64BXYWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvURmSq3fB4wcMFva0aeWrSZUYZ9vKiAOPIUaJ9RVVU=;
 b=kRdkVC0noXvh+xWhA71p1tth0f//E7AvJ/KwDMBbgoCWS7QlgPgI2jGf0Zy5O3Mj26bWZW2rG79vKoia8pPdoak+B4HmAt2nZnlPYHDaAeWUnpDJw0TL2NEf3TQ5GMAJol1/sZD29WQodMj0I/Cku2fIzrD26fcQankalSKvCaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8798.eurprd04.prod.outlook.com (2603:10a6:102:20d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 16:18:20 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Fri, 17 Jan 2025
 16:18:20 +0000
Message-ID: <51a9d783-6002-48b8-8565-b4e7fac8dc51@cherry.de>
Date: Fri, 17 Jan 2025 17:18:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
 <20240918130155.299353-2-lukasz.czechowski@thaumatec.com>
 <d63d53bd-3f63-430d-b0bc-2379b7bded81@rock-chips.com>
 <CABd623t3-U+TF9VD0O2dtNZzpZPBM9LcOQ_a4mDpv6ierbLuCQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CABd623t3-U+TF9VD0O2dtNZzpZPBM9LcOQ_a4mDpv6ierbLuCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 4972d8df-2de1-44d9-b0bf-08dd37128f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2tvNndFSzVodnM2M1FPelo3Q2YyRStSS1Nqb21TRTUxNGppVHRtcmZpazZw?=
 =?utf-8?B?K05scVJqZTZsTUlFczkwdEwxZ3ZnaU4ralYvaEVWMlhscXNVSXJEejJjL0ht?=
 =?utf-8?B?ZzlXRmpUZ0JTUzA3eitGMktILzMzcTVNd3BkMHp5RWhvRjdOdFdYWndPWmJa?=
 =?utf-8?B?WG1jTnZMRWVrV3hRVlZiaXF2VTFPWVQwQmllajBOditwV1ZYdXlpMERWN2hl?=
 =?utf-8?B?V3RLR2xkeVpaRU5iL0tLY3c0c3E0MnF6RG4xcURla05xSWc0Rm5MSlRDY25L?=
 =?utf-8?B?ZkgyZG82VVN6dytMQVgxMEM2K1NHeTZCNksxZmcrejNxWWpYTjVhdkRMaUp6?=
 =?utf-8?B?azRtSkJqRHluVGFIZThLMnNqeElhRytrL0xyWHBONStvWmNadkZUdERXMlBD?=
 =?utf-8?B?TVlBZmR4N2Z1d3BtUnpYT0twbmVIcXR3TFlnaGRrd1BZdUdUS0hobkcxRjhy?=
 =?utf-8?B?V2RPcG8yaWFWYTJSeHVxVlhSMnhEb1g4ZjRhcTlENlJLZHQ5QkZEaWJqck5m?=
 =?utf-8?B?M3FsQ0orV0VkSlNyTTMzQ2c0WVA3T2gwWUlRdG5Fdi9oZ2s5QVF3ZXRWSngv?=
 =?utf-8?B?YytRNWVrM2lCWlpUUEVrNnFzSGJOWGxyMnRUUVV1UHkramFaazVGZDlVWTlF?=
 =?utf-8?B?OXNvZlo5RnVyaDY4TTZzZ2h1Z2l5OE9lRHkvUnEvMnFRVHpzc1N0TEl2TFJu?=
 =?utf-8?B?ZkdJUUJUZm4yNERlUTc1VzdwaSt2bXgvVTdScEwzRGdoSzF2TFNub1R6ZzF3?=
 =?utf-8?B?Q3VHeHBNRHFybXMxK3NjV1lxS3JRMStEOHV5bXhBb3dVVXNYMk1NTHNFeklI?=
 =?utf-8?B?N29kSFBFeW9BSjhXcUdWWlVWLzNybzRYVXpCTUlmenlSN2I1c2JTK21pSFJO?=
 =?utf-8?B?aVUwT0xtSG8wbFZUOFJGSjU2N2pKZ1l6NUZQaW1qOXhuRFdETWRGeWpES1lD?=
 =?utf-8?B?cmliSHR6U05TaFdxTE5kU1grc2RtNzBFeFcwdkJCNVlQNTFiNzhTWGNLbW9U?=
 =?utf-8?B?aCt3d3BLd05tRm9NQVZiN05POC9LRjdHR250YVVTWm1wSElRREFYbmp6V1d1?=
 =?utf-8?B?ejR4SURnMVBpTmlNNFBPdnVoRStiMGlmNm5yejhYdmlIMHVQcVZjRXN6YXUv?=
 =?utf-8?B?V0xUM1NuRlc4ZUVKR0wySURmY0FjdnAxYkd4b29ja3BPQlJQUlZGdGprazd6?=
 =?utf-8?B?cjVrcXRDM041b0owS1ltN0ZvOEhGd2lpTGRwd3ZnQjZ2bDkrZ1Z6enVaK1Zt?=
 =?utf-8?B?Y1VOM0xKREo2V0xJK2U5ZnlwTUczYmVWNFByZ01zb29ZcVFrQXJndkw5V1h0?=
 =?utf-8?B?QktiQVJvWFU4VEFSbFdRemdTMzRibi9GcVVFNS9mbHBEZ2loYnd2M1A2eXlo?=
 =?utf-8?B?bVllekRoSk9SdmxYVUVVRmg0TWFJV1ZzQ0c3NWpYaGhLcXg4ZEp5TnpMK1Zo?=
 =?utf-8?B?QXVkTVU0eVUrNEo1dG4zQ0JueFRERFVCSFR1TnM4REJ5ajRqWU9TSjhyUVpE?=
 =?utf-8?B?N2lnYjhSNUJDZ1lWNDQ1OHZmK2dtWGZ6aXFoSnZneHhjQWI0MlRRL1J0ZEFy?=
 =?utf-8?B?alNqMVJCcmU5cmMrSldoQnIwMFQvMWdNQnA0VlhQSG1ybFcxRlp3V0NPaDJo?=
 =?utf-8?B?WUU4L0NDSDN3YWNEVy9KZnZWQlJMUzMvS3o5OG13UGxJM0NPa09XSGJyK3Z0?=
 =?utf-8?B?N2NMbTNncjNQM1pOZTNSUFJsVWdBUnZrNUUyUkRCNnBYRWVwdnh4S2JzeEsv?=
 =?utf-8?B?MnZ6T0xKalQxQWNwL3Jod0pvSXVPTkkrWnNsZFozSzlGYTJNNkMwZ1REMERK?=
 =?utf-8?B?WVlzcjZBZ3ptVlZNT2hBemZqbk5SYU1EdWkrSlJXR3ZkRCtaSEFTL0dhZ094?=
 =?utf-8?Q?8Wknp3QOcA5Xx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzExNTR0RTIwc2JDUGpSNnRMeVlVaDl6UHllZ1RjY2pOUThIVUVSaURyb05z?=
 =?utf-8?B?aVZiUldMd0pWdm9WNkJXdUVIdktmMlJXekhzaDAzOElsK1MydzVCVnBmVE94?=
 =?utf-8?B?M2tmdFBha2wrVnAyOTNJaWY5WUc1bFBkdWY4cGNyZGhaQ0xyeXhDeElheTMw?=
 =?utf-8?B?dUc4OGNHbWwvcExuWElMaHdXOFpBUXF6MEtRWSt5bHQza2tRYjkyQmZJZDVQ?=
 =?utf-8?B?NEdBblRtK2w5bUxWajNPc2s3MDFQUjgyYVhmUVlPNHBJeEU1aFRIWVNqL0dm?=
 =?utf-8?B?dEIxQ2JKTllMSlF1czVYd3lxSFBOTEpnWEMwSVkycjIwa3IzRjEyN2ZXRENm?=
 =?utf-8?B?NUJkdGtsNHBiTmF2QVZxaGJoZC9kK0tyRE1NM3V3Z3BJN2hRb1FyUTV3SllG?=
 =?utf-8?B?c2ZITkxQUW11THdjTXQ1YjlvdXpXQ1VCeVFqRnR3d2FLNkdlRlk2cnc1Y25a?=
 =?utf-8?B?d3NFTXo4aEcyMUY5ZUVQVTJpeityNk03NUpmWjgzNDBtL2ZNQmpYZXlVck8x?=
 =?utf-8?B?ZE1WdjQ2UG5TWnorYTk2bjNjV2crblJPVG5kV0pjcnVBOFdqb1JFMjk0a0Qx?=
 =?utf-8?B?K1laNDZtZEVDTWV4TjN2WjEweW5nTzFXTGh4eVEvRUtnNWVyK2tiM2J5dlUr?=
 =?utf-8?B?UW9Kc0hGNnlvZklPblRhaGtvbnBCL0tmUmY4YnlvTThxUm1PQ3RrSXlQMFpD?=
 =?utf-8?B?cHJSUEdqOG4wckFON0hOL2V5OVNFNXVETzFGZ051NVNXR0ZZdFhUVHpzMk51?=
 =?utf-8?B?TWExa0c1NElOeEV4L2c2ZTVxcUk4bzhlK0ZhMXk4MTZtc3pXRVd1S3pWdjh2?=
 =?utf-8?B?emNDZ001UVVNd2tqZFZ3aGZnUU5tN3lTRENYTDZJWml5ZzVidVhWUmEzWnJ1?=
 =?utf-8?B?ME9ZWDJ6L2Izb1pNc3lDUHM3MlcvcWpsazRjaU9OWUpjUk5UbW9zQ1hUZS9P?=
 =?utf-8?B?WFZ3ZEh2VVpEcTFsaWN2VnBBMWNrYThVQ1NpYjhkdVQxOU92TnJ6OVJvbUxx?=
 =?utf-8?B?Tm9DRDN4VU9LbUQzYlFjc09jdkJhRTRaVnNRWVJXckZ2ZUlzY0o4MUFWckRy?=
 =?utf-8?B?enBTaGZ6Rlk4V1pFVlNRaWJGU25FcmM1YlpTNWhDMW9Qc0lEbTdqZnRVcm4r?=
 =?utf-8?B?NEdNQ0g2MlJkTWVQTzMyWTgzVGVadlQrbVVDbFo0YVVZYkQ4WmJ4Nm5HNjBm?=
 =?utf-8?B?d0RqNTNqNlM1ZkRrMkk2bjBZMmRLMTRBeGFKSks5WWZmUmptTVh0UDlOc2xH?=
 =?utf-8?B?RzBOL0FqU21nYnZxUWlWTkplZno0UUh4dExOdDFtUld4eE9TTFBUcTdlc0Fq?=
 =?utf-8?B?dWY2ZStqbWpybnZHZ3FRNzRia09wV0Y3OFp3cnVpRnE1SitMOUxNeUZ0clJr?=
 =?utf-8?B?dXp4clRLS01remNKTVpHZ3p0ZlhTVTBmMkk5V0Y2T3VjeDliY0RJUkhJYW9H?=
 =?utf-8?B?MXg4V1pqeFJIOHBjTldOYnRqbHVEYURHYnlodzBPOWlEalVNSUYrZXBCMFN1?=
 =?utf-8?B?K0dJOVBxay9kQWhyUlk4dmZWV3lDL0d5ODZmQWw0WkRZZVgxbkZvUjFkaUti?=
 =?utf-8?B?RmVXUXliVS9DZFl2Y1dseFlNQWZyVjNXdjNuOWlVK1dqT1h1ZmlaYTZJZEpO?=
 =?utf-8?B?TDkvUDh4ZzJIZ2ZUY3JRQkllUjBQREpvRGwxREZOcEQzOFk4QzY0VkJ5eWha?=
 =?utf-8?B?THRFWFFWUXpKck5mRy8wSWZudXQzZjA3YnlEMlFyRGxSWXlrRDM1VERGck1C?=
 =?utf-8?B?NWcvYnFlV0xrRlJWMjE5ZFdrVzcyUTg1UmpyVlNWR0FPSWhIWmRPRmhMcDJN?=
 =?utf-8?B?T3RtUlRrWk5zUzg5YVZZTlAzTU9wZkQ4cmg0YU9tNS9YMHdWT0JYM2dHVjJV?=
 =?utf-8?B?Rkd1STYrbWU4RmdmUXBwWUJldzdKSWVhbFBHZUZVWXNoUmpDUURhcERxTjNw?=
 =?utf-8?B?MTJFcVZON2dtRXFLT2xDTlI1NG0zVUFSN2dubWpkUS81ckhFaVp0UUU2Vk1D?=
 =?utf-8?B?dElNQjBWM01OSGd4OXFuYllNb3kyVnNOSHdNQ2NqZTJEbU15dGxOSXRISjdT?=
 =?utf-8?B?cUJiK3FmYzJVdGtYMDlqY3JDMTBITmJKeVp6amFmWjZlWnJ5clIrZ3MyQ2l0?=
 =?utf-8?B?RVgwenp3TVFKYTFFOTNQbHNHM2l3ay9kam5oYnZrZlV0c2I4RTk3UGEwcklw?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4972d8df-2de1-44d9-b0bf-08dd37128f16
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 16:18:20.7027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGe3kWwscBYk8JZrueaKu5u1UfDgfPcxgWuURGsSMGmBtocifSfUnFHXrqjAjB0PaaeYc9yzKAybws9oh10cSOo8tNAF3AvBH05+kMWhx1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8798
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

Hi Łukasz, Kever,

On 11/27/24 11:21 PM, Łukasz Czechowski wrote:
> Hi Kever,
> 
> On 2024/11/27 03:42 Kever Yang <kever.yang@rock-chips.com> wrote:
>>
>> Hi Lukasz,
>>
>>       I got a new error base on patch [1], see full log here [2].
> 
> Looking at the file efi_stub.c that is used in the failing
> configuration it looks to me
> that some functions from debug_uart.h are used here for convenience
> (i.e. printhex),
> even though the DEBUG_UART is not used. This is contrary to my assumption that
> DEBUG_UART_FUNCS macro should not be used if DEBUG UART is not available.
> In order to apply the patch then, either the efi_stub code must be
> updated to not
> use debug functions or the assumption must be relaxed - I'm not yet
> sure what shall be
> the correct approach.
> 

"""
diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
index 40fc29d9adf..5172cd78a7c 100644
--- a/lib/efi/efi_stub.c
+++ b/lib/efi/efi_stub.c
@@ -83,12 +83,14 @@ void puts(const char *str)
  		putc(*str++);
  }

+#ifdef CONFIG_DEBUG_UART
  static void _debug_uart_putc(int ch)
  {
  	putc(ch);
  }

  DEBUG_UART_FUNCS
+#endif

  void *memcpy(void *dest, const void *src, size_t size)
  {
"""

Fixes it. It builds fine with and without CONFIG_DEBUG_UART set. Not 
sure if it's proper but I guess that's fine?

While reading the patch again, I think we made a small oversight.

#define printhex8(value) do{}while(0);

is an issue because ch may actually have side effects.

Take for example an interrupt register where reading is acknowledging, 
if one does:

printhex8(readl(INT_REG))

will read the register when CONFIG_DEBUG_UART is set, but not when it's not.

I am not sure if and how we can handle that so that things are executed 
but only print is not called. Is this something we should care about?

Cheers,
Quentin
