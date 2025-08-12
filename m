Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486D7C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 07:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ACA7831E1;
	Tue, 12 Aug 2025 09:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="W5pBWnaI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C2483211; Tue, 12 Aug 2025 09:53:49 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 544C48319C
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 09:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlZvCKpORla2LXUFI6+HpsIfzKGy2qtCLZI01CD3tgJS9xq7IoSAhHGSyrA43DZkimxbDEPxlM7cKeimOQDE1lUooPKLUaqSXKmBVCaHv7fl3+1RfzRR174C8RTl8B/aJO97BRivFxTz629VGFy1L72gK/SqiYDASry3PMaPydxy7rfmkdR2YYl+aqadKKKvlU/+2NLLW94xnpmNq0fTkMRkJTMEUw6QtXdzXiHJlk8s5GAlzn5jq//Q16Yg5tnnxic+YHX2nHuXWSbzJLC8QD/XYUcvbQqPAwiL0cTqc8cx0bz9H+JWb6dLWZJG/VUz5zcgI69YThYz8unOger/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWvVB67FmpBPDdS5rmUpnpJn2QzfG3ueJcMCFIZc96A=;
 b=q+dri7A7lg4QGZCye83mkwI37p6nprnngOhAZbr2AR8dvGoNZZdJCuRzIixOVnYRVQ4YPQgSw81xPeZVwWlZHcHl4H4PmiOGEZA2xd7q3dg3ytnQjTwsHiWJ2z7GNoKn15ABTr1OflDXIYLcU4OVAPyAVEAMNjaDCd7STzyJ6RUF7hNisSZ0XfFCOB6Sa3nGnpi5MqwDrSgjmW58jkImrXutz0CoUk3SEDNM7qQv6dlWbgL5SqK/H48KpnFc/8xBPtLUWXv0dMcR/fH5CR6hXwhCeNXkLC52D60SiX3+FHo7agjiFSY7za6C7rOjPY1trLlerkqETAVdMYEdtFI7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWvVB67FmpBPDdS5rmUpnpJn2QzfG3ueJcMCFIZc96A=;
 b=W5pBWnaIfEKDylyl7nI1cRCZO0Wsa0oF9BmpUQvVvrMEkNuEc0nd3T3azc49kUv8bfFjnWqrND5KJ43XzwotENNZ1MdrkUegeMjGF9Edjcbjjxm/PjYunXRxTlyWv32uucm4n7Z3V1AJrGk5mYPcYR5COCidjes7jE0WawsU/oA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7945.eurprd04.prod.outlook.com (2603:10a6:10:1f3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 07:53:45 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 07:53:45 +0000
Message-ID: <681994c6-2b95-459c-b06a-ff1fd6093eca@cherry.de>
Date: Tue, 12 Aug 2025 09:53:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rockchip: rock5b-rk3588: Add support for ROCK 5B+
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250801170933.2530191-1-jonas@kwiboo.se>
 <20250801170933.2530191-3-jonas@kwiboo.se>
 <d236a958-8605-4ad7-85f5-6cc03048f8b0@cherry.de>
 <8dfbfa29-839b-4067-b4ba-62ee3ce60f78@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <8dfbfa29-839b-4067-b4ba-62ee3ce60f78@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d36d99-e147-4876-d51b-08ddd9755cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWtsMmszNXMxYldBSzhYTGsyOStoR0t2MTVMMFo3QU5yNFUxbnhNU3Zkb1Vr?=
 =?utf-8?B?MU9uUDRxQkFrNFc4UVM1TWFMSXo0VFVVSFpkOTh0bWR3b0hnMW54MnF2bUtx?=
 =?utf-8?B?UjZTRzVTR2ZqZ1lJaWpiM2p3SGJQbDg1bUtEcStlU2pVT2VvQkJTTFcwSnRo?=
 =?utf-8?B?UEpBUnlXanUzbWhTbGdlNDhkZ0xGK0ZBU0lTNzlPQUJhdXhTWTZuTTNlMWZE?=
 =?utf-8?B?bCtiQXBnVHJ5aHNjVndVRVpxTUZNc2wrckJkTnY0RFpsdU9xczFhM2QwTDZ5?=
 =?utf-8?B?ZUtUeVlGd3UySFk4OGNhdDJlNi9CSEhyUjBpZ0xZditHV2lsWUpRMlFmS2la?=
 =?utf-8?B?MVUxL3daS0s0SloxaWFtSTR3Sm43Y3NyMG5SZytHbkpGUXhzaUhrNWZXSUYv?=
 =?utf-8?B?Wm5pUVZ1c2F2VEdENkVTdlk3S1RPSEREakl3bGFDZzc4RHNEMmlmaUVLaTYy?=
 =?utf-8?B?dDlUaXVkL1FCcG4yclZ6aHlvYndabGxkNUZHY1QxclBtcUtJdnVxd2V0ckd0?=
 =?utf-8?B?Y21BeENsYTd1THVnWFV2aXNyZVovM3FaYkJzWVVldVV2N2JKQThtSVo5Yjd6?=
 =?utf-8?B?R0haOWNPVG5jdnE4RHBJVlB3eEJUK3AxWGN2Y3pUN0ZnWTBZbmpRZGtud3VM?=
 =?utf-8?B?dWUvQ0VwZ2hBVmgvMnJSSmhheEZkK1FvYkV3N0pRYU5sQjVFcU1WY0dUUUM2?=
 =?utf-8?B?WVZuWkJnRnVzWTlpOTRPbTdJNTNOWGZqM2pHdEhScTBNeSs5KzY2TERlNWxQ?=
 =?utf-8?B?UThWV2hvWGZmaWJRaS9DQkZEV1dTbnRYU0RJcFhBeTkzWTh6L0tveEtmZjNG?=
 =?utf-8?B?ejI4Zzk0UDRBeGxNUTVJajZsREhNRDdRUi9KcFZBQ3dubHJCQ3RzWGpFNEpM?=
 =?utf-8?B?YXNFZHV5dnZldzc0eEYyQVpXMXRaL2RqcDdSRGJIUHozZXF2YnlvYWM1U0x0?=
 =?utf-8?B?d2pFK09ZcXNWa3pQZWl6UXhLTHNQOWNLMjg5SXBUSVdiWXVEaXhpeWtVTExi?=
 =?utf-8?B?NExLbitKbnY5Ti9hTTIybEFwdkF2OXMxMWIzWGRGeGVoRUJPN1p0N2dQemhz?=
 =?utf-8?B?RCtISEdkUzhvaFovT29FSW85Yk1yY1ZGMWVLVVJmVXhGU0VPQVpFMndKSXpS?=
 =?utf-8?B?L0kvTVhuL2d0U2JJZWZxMDg0K2psWHc5UlZWTGVDZUh5STIydzFWdU1sSFRI?=
 =?utf-8?B?VitGeU5mVnZxcTl3WEpVS2poRTV1Y0ZJTE5NSGRvNFlSd3cvSXpKZmpTNDYx?=
 =?utf-8?B?Tmg2REFobDZ0THRUL3BJRHkvZ3V0NWdjVnZESkxITXZ0RmRsdFV1bzA2aytr?=
 =?utf-8?B?OWQzWVVTbVczbmRaUmZXeU1qOUdYQXZ5NXcrU25xaTlyd1hYVlREQ3BUMnlT?=
 =?utf-8?B?MTlndFNCN2h3cGdyRzlBUHBxS0xCV2pVT2tDbHJTNHBaRGFCYm9OVlZrTUhS?=
 =?utf-8?B?S2lGRmlhMStxd0hDVXZub1VsVFkzVHhlc1l6M1JLaTl3TVgwUDhMMzdhRyty?=
 =?utf-8?B?WExFZSsrSU5JZU1nWklLUXpNaVZMRUFRWG5Cdjdad0xyKzJpZ3k1Wmdma3VE?=
 =?utf-8?B?K2RTVzAvTjlGSURzSHdWUG95bnA1MDZ4RVhiOTdFWXpDeEZlWkdvQ0RZd3ZD?=
 =?utf-8?B?SFpyUkg5dWVmMGovSTYwcmNDUm9qVm82aXhDQTBvVXo5eFhWSzdzdlNhenVU?=
 =?utf-8?B?QUU1RFZzZDhYYVZ0VWVrNktiNGxIbWxjaEJSK2J2UGxWS3U0WHhFbElianRn?=
 =?utf-8?B?YWJJVVVWTGZ3c2p6amg3SHlHNWoxL1VQaTNheVM1WEJMUURqc1VlaG1kNk9Z?=
 =?utf-8?Q?Oli4mAcuC8nXXlwMJcy+SlfP2sVlF9nqJlCD0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlpvY1ZUZ3hxa0pTR0RaVTB4WlFFOVJ5c2Q5dno5NGFCWGdxR2dMUUhBeUl4?=
 =?utf-8?B?UVJseDk5WWZtcXhRQ0dMZ0hmWEdwWGFtK2JxcHdxQmdsWWZISUZVYkdBQzYx?=
 =?utf-8?B?YmgzaXhrWk1peTl1d09qbjFZNzJYVUxBV3dMV09jWlBuZTNIbENYaXdPMFdL?=
 =?utf-8?B?YTZEWnBLMFNYVGl2SEtyQVRZSjZhbUZObTh5VnB2Y1JsSzNTcE5XWUFoazg5?=
 =?utf-8?B?MjFpc0J4NkcrUEFrWk5kT3V3SVNXZFl5RjlvZHE3ZHdoaHE2Q3lycEloRjlj?=
 =?utf-8?B?Ympqc3kwOXZYQ0VjNlpMUUlacHhZQ0E0dG9RbVg2OTY3UE5FVTdKUnBKVWV4?=
 =?utf-8?B?L3hrdU9DM0tIcFB5enYyQVRjOVd2d0tpNXgraldHUGdyVndwUTFJZFdyUVp6?=
 =?utf-8?B?YytLMDVlS3dpdWNtaytxOVNmQUNhWTh0bytqYjB2TkJQcWZSL2VYMzliQTU1?=
 =?utf-8?B?blFoM1U1OUZRVWI2UjkzbVhjWTdYZWFHQ0NsRzBNdnUyV0c4N1dmYzJ3R1Zx?=
 =?utf-8?B?dHFBU1Y2ajlwanZGV0VtcjYybzA5SjZGZ3BaZVYyeW1Wejd2cmVKWkZTUTY3?=
 =?utf-8?B?aFBpb2ZVVFVqRTJHb0VSZkwyTFBFR2lVcncvcWhqa1hRTDdtWStJYnJpV2pR?=
 =?utf-8?B?QjMwbDM1elB4ck5hR3d1VTJXL3UwcWY2NGh5Qk1UbHBlTXVTb1lHbFhRTXJU?=
 =?utf-8?B?cExlWkh4cXluTjdncmRmZFlIWVpZNnk0L01yQmswbzNHNEtjUXQ2ZmM5blQ0?=
 =?utf-8?B?WXdMM0FCeEdsNkhYMWFVd2tvMDlQQW1DSnN3T01EbEZNSnZMM0RlT3BlRHJN?=
 =?utf-8?B?WGJ2ZWV2ZzE5TENBaWk0V080VlFpOTZrWWRKcnQzL0Q5L0pnVUp2bjVNZ25V?=
 =?utf-8?B?WnRuNGlTVzdFYWdvTUlJM09DNVNlS1ptTkdaM1hBcTB5N29meEhCSGVJYk02?=
 =?utf-8?B?d2o1M2VlcjgrWDhJZ2pJaEQ1WndKcGJCcHVsY1BVWUJqMEdHRk5UTmNhcHRl?=
 =?utf-8?B?M2FUNWgzTHVVOEtIL2JvSnYvVXNwZ1hLZnpiK1g3NlRMZHNGamRxQ1pUbVgy?=
 =?utf-8?B?eHYxUW0xc1Eya1hPSzJmb2FHUnhnZVErZjE5SzJBOGZLS0s3OUNONklXYXp1?=
 =?utf-8?B?QjZKcytwVllCSDIwUy85d2xJdUcyMkJ2NnoreXFIMlFCRlV3YlIrQ202SjVQ?=
 =?utf-8?B?eHFSRHlPcVNFN205dFoybVlKeFBYZGl3YldpSXFxa2xLU043eGVOVG9mc2Qv?=
 =?utf-8?B?bW1jamtYYVBwUTBqOGIzellHQWh5a3poeDdNS05aUFZuYmVVVksxbU1VN3ZI?=
 =?utf-8?B?Q3R5N291UmZ1OHRMbXdMaHZKR3VTVTlnZTRMRUZXY2JDbmdSWGozN1NmcU9X?=
 =?utf-8?B?NWhhQWpoNnpuaGZ6MDRQN01qT2JYMmxJam11dm14cWxqem90c1U2WXFwOG80?=
 =?utf-8?B?elJyM2JvQjlZSGo0VDZMRFNXeUV5czVBY0c0Uk05UkJqaFZ2enQ4eUkzMi9q?=
 =?utf-8?B?Y2JUUHJ2MjNybW4wMmpBVFpXRWZQRzB4c1gxWHZSRUlVcEY1YmhYQUhTYTNs?=
 =?utf-8?B?ZWFreDlWY2x3UXpBSTVYZy9zMTVMbkVMRk9ka3hWbGRidnppUyttQUxhbHN5?=
 =?utf-8?B?VWhKTkxvTHphcXBqTjhzTDV4UE9CaVk2ZU9venliUzFuVnBxYlFGZUQreVJD?=
 =?utf-8?B?eFZtQkIrNUcwNEtFSUZPN2VsL29raXBTcTFKRHNrbHRlUjd1cHJIRUduN3pP?=
 =?utf-8?B?T05QbUtBYVNpVStBY1J2VVZhN1ZpeG1GSEpPclhvbXNRSVZyRjFUeUxsU0Fo?=
 =?utf-8?B?aE43bEhSbXpEckxGNzZOYU8yMFYxb2IzOUJNU1JFTGYwRDk5WGVFTlFtazRr?=
 =?utf-8?B?Q3lCcmgwR2t5ZG4wUmlwSmxVSTNMWERIdkxJNDJUSXhEQkRwMFRac2ROVUxs?=
 =?utf-8?B?L29LSGF3NHVlTGFEVHQ0YjZ6dkpCb1JtdXpoaytPUUF2Z0JmQ0pCVjR5NFpr?=
 =?utf-8?B?VkV3aUlycEpaVkhJZGp2US9KSkpQVHRJSHkwNkpXSHdWQklnRGRmdHIxRnZs?=
 =?utf-8?B?elRObTVmemNKbW44OEVvQlV4cUNKU045emVGdGdacDE4azZwK004Sk9YWitp?=
 =?utf-8?B?dUw4bmpNSkdsbzVSZ0laaUY4ckY5YzBERGo4bFF0TnhXaUU0aWJuY2p5cGQv?=
 =?utf-8?B?QW1kR2w5N2MrcmlYTVBVR1IwaFZZL2pCdDBoaHEzVGRSeG5Va2lmUXpIYW1j?=
 =?utf-8?B?WHl0SEY1T3dMbmxqU2tWZmFEU0lnPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d36d99-e147-4876-d51b-08ddd9755cdd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 07:53:45.0493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaumpXgNFEgqfaAWf7qdIB4Zxll9rgX4gRYXFpEuVUAqN5swCXH2Hm7c9mvjsE1goHYhhMJDya+W1ZsUee/BR413hgXOPfINb7gzPCYkhNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7945
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

On 8/11/25 11:17 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 8/11/2025 11:24 AM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/1/25 7:09 PM, Jonas Karlman wrote:
[...]
>>> +#define PMU1GRF_BASE		0xfd58a000
>>> +#define OS_REG2_REG		0x208
>>> +
>>
>> I assume the register address and meaning is stable across all RK3588,
>> so maybe we should abstract that somewhere in the SoC file
>> (arch/arm/mach-rockchip/rk3588) so that the caller doesn't need to
>> specify them?
> 
> Correct, these are stable for the SoC and could be defined in soc
> related header and is something I have very slowly been working on in my
> optimize branch at [1] for a future series.
> 
> Right now we have some code using syscon_get_first_range() to get a base
> addr from DT, and newer code that instead use a define. See e.g.
> sdram_rk3588.c vs sdram_rk3576.c, getting the base from DT adds several
> ms delay and something that seem pointless when we know the stable addr
> at compile time.
> 

We could do something more akin to:

u8 _rockchip_sdram_type(phys_addr_t reg)
{
	u32 dram_type, version;
	u32 sys_reg2 = readl(reg);
	u32 sys_reg3 = readl(reg + 4);

	dram_type = (sys_reg2 >> SYS_REG_DDRTYPE_SHIFT) & SYS_REG_DDRTYPE_MASK;
	version = (sys_reg3 >> SYS_REG_VERSION_SHIFT) & SYS_REG_VERSION_MASK;
	if (version >= 3)
		dram_type |= ((sys_reg3 >> SYS_REG_EXTEND_DDRTYPE_SHIFT) &
			      SYS_REG_EXTEND_DDRTYPE_MASK) << 3;

	return dram_type;
}

u8 __weak rockchip_dram_type_reg(void)
{
     return 0;
}

u8 rockchip_sdram_type(void)
{
	phys_addr_t reg = rockchip_dram_type_reg();
	if (!reg)
		return UNUSED;

	return _rockchip_sdram_type(reg);
}

and define

u8 rockchip_dram_type_reg(void)
{
	return PMU1GRF_BASE + OS_REG2_REG;
}

in drivers/ram/rockchip/sdram_rk3588.c for example.

That's what I had in mind rather than going for a syscon.

> So for now I just kept this here with the expectation that this should
> be changed in a future series.
> 
> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/3a11ab7fba8db133374e60edf8ab2b46195cf684
> 
>>
>>> +#define HW_ID_CHANNEL		5
>>> +
>>> +struct board_model {
>>> +	unsigned int dram;
>>> +	unsigned int low;
>>> +	unsigned int high;
>>> +	const char *fdtfile;
>>> +};
>>> +
>>> +static const struct board_model board_models[] = {
>>> +	{ LPDDR5, 4005, 4185, "rockchip/rk3588-rock-5b-plus.dtb" },
>>> +};
>>> +
>>> +static const struct board_model *get_board_model(void)
>>> +{
>>> +	unsigned int val, dram_type;
>>> +	int i, ret;
>>
>> i could be an unsigned number type as well. (and it should since we're
>> using it to access items in an array)
> 
> Sure, will change in v3.
> 
>>
>>> +
>>> +	dram_type = rockchip_sdram_type(PMU1GRF_BASE + OS_REG2_REG);
>>> +
>>> +	ret = adc_channel_single_shot("adc@fec10000", HW_ID_CHANNEL, &val);
>>> +	if (ret)
>>> +		return NULL;
>>> +
>>
>> While checking whether adc_channel_single_shot() is the right function
>> to call, I stumbled upon the call in arch/arm/mach-rockchip/boot_mode.c
>> which i believe wouldn't work for Rockchip SoCs whose DTSI uses adc@ as
>> node name instead of saradc@. That would be rk3328, rk3588, rk3576,
>> rk3528 and rv1126.
> 
> Correct, the saradc@ in boot_mode.c is typically used for "recovery" or
> "maskrom" detection. However, this uses a hardcoded saradc channel that
> may not necessarily be used for that purpose, especially on newer SoCs.
> 
> I suggest we do not try to change that to cover more SoCs without first
> adding a way to define what channel to use for the button detection,
> possible in a /config or a Kconfig option.
> 
>>
>> I guess there are different ways to fix this. We could have each SoC
>> define a constant string with the node name of the SARADC or have an
>> additional entry in /aliases for saradc in the DT? Maybe some other way
>> could be used as well, just throwing ideas :)
>>
>> Unrelated to this patch though, so feel free to ignore.
> 
> As noted above, I think it is something to fix/consider but it may have
> unintended consequences to blindly try and fix boot_mode.c for all RK
> SoCs without having some sort of board option to specify when and how
> the feature should be used.
> 

Agreed.

Cheers,
Quentin
