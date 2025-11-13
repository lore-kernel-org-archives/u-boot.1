Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7021CD5BC2
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 10:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED07D83734;
	Thu, 13 Nov 2025 11:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZZyJTHUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7D1483DBD; Thu, 13 Nov 2025 11:58:43 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3B408004F
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxuMh7B0iucAHpxCaVkvT4aDnJ1tqDuEjit5Nmpgeb8qufFdnwWrLdEFi9IhqDNIcub1TwiNLxHhfsTBrRZyu1O+IJyPqa8JLEXN/XiG/j4OnYWdmK+zLz3ezFVP8waIuzb6mlI5/oP3o6RbrydjYQzrJzy71JMY0DHMNeJfNEFm5UPYgKhe/99071/5psnVhm/0JXXMrXeFJKZQzD03mjtYevUgUW3qkO6luPvrhYR5ybJxFqnFDRcE0+aPYpHKrI1gjZ4c69nDQ9QU35O2PgG2mOGUg+ccYXk1fknxmHEIvO5daJyDwXog6ZfRnr/geXAbZLLIBNczhlm8e4dpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVCqAsuyzzEX9Hv5psMBc+bQX8DWwqJQZ6UfEjmr8i4=;
 b=AZ7yxZGQVp4ysZYXoIq2y1C2dgJccVMu1qvkCgrBSQmwC0gwZqY4Qw6N5VDLHB409p3HOC7iwKbl6VUcuZLLkaUa8M2Mr5iw3uFjBZNsfWoP8b9xcZSniyozwKU2b0gc/hCI++uOQMhhNQYfDOOPkLXfEwVv6Ndxu4JkrAFUj52p0WVneB1BJ7bRluwxrXBL3rAc3wkxLXpCzr/pPCEAZT5rtBiVIA9Xqe1c4segVkwBSbl5dX6T43DpbzwyiC/X96/bh21rzPWr9Uwl3Isx1AlykMhwWeYMMYi8sBiN++hgia62CJ8w0SmfY+j4abZipDJXM6CHoW6aBfrR3R8V0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVCqAsuyzzEX9Hv5psMBc+bQX8DWwqJQZ6UfEjmr8i4=;
 b=ZZyJTHUi4mB6BEhHLxV8WAvfE6+YWY+fvJTbWoktn3TqJsOSe5FBbeXUeE7oxlxQDcTmsdzYNxX5CjGj+tt1nv7k5ldknZNUylGO2kS6dwtrpH81ipmw+UN9al6sBWOGcFrdw2Mni/IJftAXC02WS0H9jR0/4fqe8YNd674l0DY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB11040.eurprd04.prod.outlook.com (2603:10a6:150:206::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 10:58:37 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 10:58:25 +0000
Message-ID: <c10c2b6b-5daa-4128-aeae-977bb0f72be9@cherry.de>
Date: Thu, 13 Nov 2025 11:58:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] doc: cmd: document the led shell command
To: Quentin Schulz <foss+uboot@0leil.net>,
 Ziping Chen <techping.chan@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Klaus Goger <klaus.goger@cherry.de>, Eugen Hristev
 <eugen.hristev@linaro.org>,
 Durai Manickam KR <durai.manickamkr@microchip.com>, Stefan Roese
 <sr@denx.de>, Zixun LI <admin@hifiphile.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
 <20251112-led-old-dt-v1-3-2892d49517db@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251112-led-old-dt-v1-3-2892d49517db@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0012.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB11040:EE_
X-MS-Office365-Filtering-Correlation-Id: b9124b08-7f80-48f5-9a4b-08de22a3916b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkVGam1CL1ZaQnZ5NVM4WE9YRVdxeEc4V1NKTGZzbTRic1U5b28veElXT2RV?=
 =?utf-8?B?VVdOK09HZjdNcVJSQ2VsOUxaL2tKZUR1UDMwV1hmZjIwaDl6WndzcHRnazcw?=
 =?utf-8?B?N1BST0FWMEtWMWFqSUlTTGZxOUZqM2g1UG10TTlpdnBaWENnMmwzOWxiQ09o?=
 =?utf-8?B?TEYwSThnTXh2NHJFWjdoa3labkp4NERXeUUxb0NKNEQ5Sk9vRzdQc2pmMlox?=
 =?utf-8?B?OHZOWTZnc1FOU0w0YUhPcHJnajRTekJSVmdpSmhYUTkrL29RM0dIZUN3Z0Ux?=
 =?utf-8?B?cGVxa0JZMUQyU0ZFNUNmRFVZWTVIN3d0d1BqSDhtWldoMjNXTkYvY1ZXbThi?=
 =?utf-8?B?a3A4Qjc0eVJNYWptTUw0Tzhkeko1dWZNYWErdzhRSko5WGp2a0tYQjczbXBY?=
 =?utf-8?B?a1RreVYwbjltZ0ZCVUpjNnVESThEclFSM09XRCs3N3lVZlZVcE5WejVvWDk2?=
 =?utf-8?B?NVo3RHBzVEFOK0xCYXJ4SnVCT250b0lma1Urc2NZMGx3c2xLU3BTUTNlVy9U?=
 =?utf-8?B?dmhHQWNpbk0zVEo5NTVVQlhtU2hVUXcvR3pHUXg1QWxpajEzNGJabFNmU0lR?=
 =?utf-8?B?VnVUME5JSGhSNFRiMTBHMis4QTR2ZjE4ZzhQSTRqaVU1eTlQOERiU2JaaFhH?=
 =?utf-8?B?enR5cDVYY0RRRzNjRjJxR05lN21VZ0tURFdFRzlCZEtJL2NuV2VkVkRxQlRG?=
 =?utf-8?B?OXVPVVNMZ1VHVStiU09TMGZwNlVYblFlN1FQY1FrUnV4NmhYWWZrZWdDOXlC?=
 =?utf-8?B?aHVDSlNSMDF4SVVjdE1BSGZYNVhHRERTRVJ4RlQwYnBXUTh0WkN5RmdDbEt1?=
 =?utf-8?B?K2JmT1JZQ0pKMFVydDhoa0tIekYrSGRCMlphWmNOZUppckZKbzBDZVNQWEJ4?=
 =?utf-8?B?bUc3ZkdSM3VRTGNKVzNmOElrVzg5a3hZVEVOTHVueG5waTVvdDFudE1LWm1u?=
 =?utf-8?B?am9kL0FBSTJFaDFGcVh6RDlBTEgwZXYwUXEwcXkvbk1tSHIzQXVlWm5iZnRk?=
 =?utf-8?B?MUZZLzVGRUQ4akZUb3NiNEYxMElZWWdvQU1kc0N2Nml1b2VxRVZMdDVENnFj?=
 =?utf-8?B?cWI1Ujg5WUFIRkx6czJPcENyZ2FrV2Z6SkNJVXA4VzJQMndTbjRzK29RZWxE?=
 =?utf-8?B?TnVnZ0EwaUQ4M1BUZmdDTmZMVXhNM0tLMDYzakVaUzY5UksxaElTaEgvMEN6?=
 =?utf-8?B?UU83WXhQYmxUS29PaFBDb0p1RWJaWWdwMFV3aEUxcTA5WFp1TTgwUXBPZTgz?=
 =?utf-8?B?Wk14SkFoemI3aDVFNzBNcVZYazV4NklhTk16b01uZVdJb3paMjZaNVlMTkM1?=
 =?utf-8?B?QzZSTzlIelhrck53UjFjRXJHcFZGdzY2UVpDdCtXdDhZQXVGTVFIcStlTmRK?=
 =?utf-8?B?d1VmNGpKT0R4ZzB0eWxCRXZKWnpmd1FzSERON0FlNFMzRlR4Vi9yd0pZQ1do?=
 =?utf-8?B?UUh2Q21pYUZDUVN0bDdnMVo2MFZKZVJBczdibUxidHRtQWlYZjR3TW9MNks0?=
 =?utf-8?B?VnFkWXV2K1BNKzRTeTFoN0JUOTY3L3pqejZvMG9Zc21pVmlrT1dleFg2ZnRN?=
 =?utf-8?B?SzVzbUI4TzB5VGE5Y0FLZERrbDRiRS9lRkdCdGZNOWNHTkptalBiN2dvV2Fy?=
 =?utf-8?B?ZE55NnJ5L1VnRmxDM2k3eTh5VnpqK1pMaVRXSUw5a2dScWlpanlTZnUyV0Mx?=
 =?utf-8?B?SWQxZ3c4TXZOcStRSHphdVFSRmJJOHVFbVdSbXdMbzREbEQrVTdnK0EyUXRy?=
 =?utf-8?B?djZjM01TK0Z4Nmd3Umhlc3NMWklKcXUvZFFoSkUvc0dEY2ZHVk5QUzhFRWt0?=
 =?utf-8?B?U3hTZFBDMTRiOSs4R1FhL3BOcnZNL28rWnFJSlFESCt4WDV0eXJFQUpOUktI?=
 =?utf-8?B?aE9qVWlkcS9vaDhKczJpVEkrdTFoS3ZpVFpwTmNaNXJoYURaZjcrRU9vMnpJ?=
 =?utf-8?Q?BgN+D0BbLVFe0pHUj8EhX1QqW/ve7CZg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2ZaMW9VRnNDZjhCYnI4cktBV0RYU2VWUzBCZ1hud0FYTkFMR2FpRUFCSHhk?=
 =?utf-8?B?SHFkR3R2Z3hzcjJTcEpJMGdRVzd4R1VFcGw2RnhTd1JlRXJuU2o1dGQ1ZnB4?=
 =?utf-8?B?bHMrcTJ4MWt1VE8zWUZ1U0dMcDNtRjBCWlBDbUd2d256ZGwzeTI5MnJEZzhI?=
 =?utf-8?B?YW84ZjU3Q1liaXZCSWwvcHNtQ3dYalhhN01kajJVVkRWU3R3MWUzRFl1MmJV?=
 =?utf-8?B?OCszc2lEdytOYUpUcVNqT3lJeS9mbzZEV0Q4c0UxTU5pcmhsektjZ09DTm9L?=
 =?utf-8?B?NTBmK1VmVUxUelJCOWRER0lHM085QkZOdnM1d1VqZ3R0ZkxPZlc0ZGxlbytX?=
 =?utf-8?B?ZnJqaUVGREJycGVva3VESlNPY2k5dzB4NUVUNFVkdmdXSkNIMWR1cHBNbTJ5?=
 =?utf-8?B?OC81T1Blbk15N1hwaGRIbEhFb3BXamFrOENQMm9zR0cvT3BwWDc3S20raXRw?=
 =?utf-8?B?YlNvazNEVHh2SUR2MVVOVHVSMzZmcmpDb1VGbnlCRmhqZ25Zc2x4STVMMHVu?=
 =?utf-8?B?anQzNmtVN0JRcmZyS1cyb2htZUdKMm9CczlaU09OczIwenBLN2JhRTA4RWw0?=
 =?utf-8?B?b1h5RUlnUi95Y2JwUlY1dm9ZQWQ2eGFJRE1xYUFmZUVIUGZzZkdhS0VDMk4z?=
 =?utf-8?B?Yk9YT0UxeDY2VHVsMmJjeW1qRkZKY0FXeHREdWpEYm9zUGdob1FJdVRNanI0?=
 =?utf-8?B?aC9NK1M1SUJtdHdlb01oalpqdVBzSytVSnluanF5MUJqa01aTnJFWFlNTlBM?=
 =?utf-8?B?NjJyaEgzY2tYMkY2N291cUpPRUJpbnpudEdlUlZqVUhqYytjYkk0Nk5YV0lF?=
 =?utf-8?B?YUNUVjFQZnhLZFRtUWJmVE1BYzJzaDJmZHlOeUo0NjFqNW1mcGEwSGxvWkhM?=
 =?utf-8?B?R3NlNnNRaDJQanREWDRiSllwN3RyeGg4WVZTOXIrMzh1M0dSWkt2VmkxRTZx?=
 =?utf-8?B?dmNzSWlnOC9DMjZucE1uYUE4MTI3REp0OEZmZmxROGlXZ1R1Q0xBbUFVR3RI?=
 =?utf-8?B?djhDajhub0ZLTW4xL1pKQ3M2T0xKNnNSWFNsSjlaTE05bHBpeTNzd05PMEY0?=
 =?utf-8?B?YnNzK0o3UHpZbmI3UXNkY2R3K3NYc05Ld1JWS252ZEhiNzEweWxocyswQUl4?=
 =?utf-8?B?ZWIvNWFuTEdvbzRvUUR1bTF2RlM5UkVxVDRLM003OGhPQUhPWHRDSkpTQ1NU?=
 =?utf-8?B?Ym80YnRyeGo2WDBHVzJaMFZvQXQ2cXArZVUwTW5teTNXbjE2UDI4N203MGxH?=
 =?utf-8?B?QlFtcEllNGpXWnYrZlB6ekFmeVJFaEsrTkNUaFZKQzM1OVJFaXY3eHRiS3h6?=
 =?utf-8?B?WERKaUlvbHUvQ1kzUFRFbVVER2JUSHhHUUwwVGtYUy9ERHhnSGVQK085V3Ey?=
 =?utf-8?B?dG52SGFWYWZ6K2QwWWFLa2VTUVhqZDhMWFduei9La2s0K20xb2szU2FQVkJT?=
 =?utf-8?B?U25haXR3RVE3aVk5Q212ZVZWby9FR0MwRFQvcW9oMXJwRUphS2d5bng2Umxv?=
 =?utf-8?B?cmpBREtSWmNzaGw3cXpQYnk2a01MN2pjcXUzczREZXgzRGwyeHdyWEtYcEdu?=
 =?utf-8?B?d0VEdGNva0xleXExNXNKV0ZrTGxNU25LMndGMEFWS0JhcWNpQkRBa1pNbEJD?=
 =?utf-8?B?cDg5SmpmdjJ5T1FQbitpQzVTWmJaRHlocGdzc3Y1TkgrTFZkNENZY2JDZ1gz?=
 =?utf-8?B?T2ZWRkM4TW0xQzcvMHphMHFjVTBjdVdMeGdkalBvQWdYTUlPUExEZFp3RXli?=
 =?utf-8?B?NFZQQTI4UlBEclRtczJ4V0hNUjF4ZUdDWnZLMVFjOTAyM2c2L3MvTzA4RW1i?=
 =?utf-8?B?UGxtMjFqQW5nWkV5dXBLd3NObzZ3TkNja3VDSFQwSjJqdFJtUzF6VXc1aHI2?=
 =?utf-8?B?TjdHblVibmVHRWdTNGZGM1Q0WVg4TFZHdVJCQmE5cXNuaXlzRGYzbURLZUxx?=
 =?utf-8?B?elhlK3lQb2VtZkxqZmRwcHUrR3hsbGJzUGt1TVlNRnBLV3V6ckU5SUJHMTA2?=
 =?utf-8?B?OGppdnpINjNPRllvNGpHNDM0b0lEUVhJUGpDT29UMHplcWhISlJWeWxoejky?=
 =?utf-8?B?cDFNR3lCcXRuamc5OEIrL3hLelU4QlE0RmVxZnhmQVBqaGYrM3dBcEMvMUZM?=
 =?utf-8?B?cmlZNTNab2ZxS045UUlxajNsZ3pDQ3FGQzZsWE1TQ1FYbUs5ZEE2OU1rVzFF?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b9124b08-7f80-48f5-9a4b-08de22a3916b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:58:25.0012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TV1VWFA+kgQMW17o4N4AK5uNfHXt+3YYIxbbtyg87bu72M6aHnIxFH8xjTE8YbBb881sUAVWLjsl9YUkn48bPVnF6T9ZJ59XW1taV2YlnH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11040
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

On 11/12/25 6:48 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> This adds documentation on how to use the led shell command.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/usage/cmd/led.rst | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
> 
> diff --git a/doc/usage/cmd/led.rst b/doc/usage/cmd/led.rst
> new file mode 100644
> index 00000000000..b5623895c7e
> --- /dev/null
> +++ b/doc/usage/cmd/led.rst
> @@ -0,0 +1,95 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +.. index::
> +   single: led (command)
> +
> +led command
> +===========
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    led <led_label> <on|off|toggle>
> +    led <led_label> blink <blink-freq in ms>
> +    led <led_label>
> +    led list
> +
> +led <led_label>
> +---------------
> +
> +Get state of the LED whose label is the one passed as ``<led_label>`` argument.
> +
> +Provided ``<led_label>`` is *module_led*, the possible outputs for this command
> +are::
> +
> +    LED 'module_led': off
> +    LED 'module_led': on
> +    LED 'module_led': blink
> +
> +led <led_label> on|off|toggle
> +-----------------------------
> +
> +Turn on, off or toggle state of the LED whose label is the one passed as
> +``<led_label>`` argument.
> +
> +led <led_label> blink <blink-freq in ms>
> +----------------------------------------
> +
> +Make the LED whose label is the one passed as ``<led_label>`` argument blink at
> +a frequency specified by the argument ``<blink-freq in ms>``.
> +
> +The frequency is parsed as a decimal number and its unit is milliseconds. The
> +duty cycle is 50%. Example::
> +
> +    led blue blink 1000
> +
> +will make the *blue*-labeled LED blink with a state (on or off) kept for 500ms
> +before switching to the other state (respectively off or on) for 500ms,
> +looping endlessly.
> +
> +led list
> +--------
> +
> +List all available LEDs by their label and provide their known state, which can
> +be either *off*, *on* or *blink*.
> +
> +If a LED has not been probed yet, its state will be shown as *<inactive>* in the
> +list.
> +
> +Examples
> +--------
> +
> +::
> +
> +    => led list
> +    module_led      on
> +    sd_card_led     <inactive>
> +    => led module_led
> +    LED 'module_led': on
> +    => led module_led off
> +    => led module_led
> +    LED 'module_led': off
> +    => led module_led toggle
> +    => led module_led
> +    LED 'module_led': on
> +    => led module_led toggle
> +    => led module_led
> +    LED 'module_led': off
> +    => led module_led blink 1000
> +    => led module_led
> +    LED 'module_led': blink
> +    => led sd_card_led
> +    LED 'sd_card_led': off
> +    => led list
> +    module_led      blink
> +    sd_card_led     off
> +
> +Configuration
> +-------------
> +
> +The *led* commands are only available if ``CONFIG_CMD_LED=y``.
> +
> +The *led <led_label> blink* command is only available if ``CONFIG_CMD_LED=y``
> +and either ``CONFIG_LED_BLINK=y`` or ``CONFIG_LED_SW_BLINK=y``.
> 

It seems like there's another led shell command that you can build with 
CONFIG_LED_STATUS_CMD=y that uses the legacy LED API... Should it be 
mentioned/have its own documentation page?

Maybe we should spend time porting the 5 defconfigs that make use of 
this legacy API to the new one and entirely retire the legacy LED API. 
However, there seems to be some discrepancies between the LED_BOOT 
behavior and that of CONFIG_LED_STATUS_BOOT. The former blinks for a 
brief period of time and then is solid on once reaching U-Boot's main 
loop. The latter is blinking sometime after relocation and then turned 
off on first BOOTP packet.

Out of the 5 defconfigs, 3 are using GPIO LEDs with 
CONFIG_LED_STATUS_GPIO=y so it shouldn't be too difficult to migrate to 
the new API just to get the LEDs working (I am not talking about keeping 
the same behavior). The other two are configs/eb_cpu5282_defconfig and 
configs/eb_cpu5282_internal_defconfig which I assume are for the same 
product, but it has not seen actual updates (aside from tree-wide 
migrations) in the last 13 years. From what I could tell, this is also 
GPIO leds, but controlled by writing directly to the GPIO registers 
instead of using a driver. Maybe we can issue a deprecation notice and 
tell the maintainers/users of that board they have X releases to migrate 
else it gets support for the LEDs removed.
For the other boards, we probably need to check how to use the DT for 
the LEDs that are currently configured via the legacy API.

This is at the end of my todo list though.

Cheers,
Quentin
