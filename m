Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D0FC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F54583249;
	Fri, 18 Apr 2025 15:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PtsUktoL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEF4D83249; Fri, 18 Apr 2025 15:52:16 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E04B9810EA
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDvl+iOFxYQ0okC3x6GfkkfoGddM8Sgr8kCbxsnH0yRuta3oyH3ZUxBIJAp23TL3zjlwCIG3j83Ix8jXNj+Mac2ija7yBsP1n+3u/g3lqvu0dg/41hu/5GbigVmwt6zcWJKpfOS6D8zkiacK6SzoJwKixz1y2BVUIyNodbKgJ99yvl8X6wtbO84iSTpxfyk269t78zTmrVcxEso55U4AwgqamCy7k8YgKvRjlL1YGhuM3U3uXWlHVMPkChr1qZbb+/X2PJnUtuA+DhdcSkclKCsx2SxyHbjL0ce6TPDENGDkKueoXGhgZG512csBolJOS8ro1DVuQFs8GJNIqOp2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5qokaX6XlMpL9nvoIbYs7sr1SA4vJ5S3CHGsi6c79I=;
 b=ZteGXE2mXnFfUArpT0wo9dFQc++QWbt4GS9PhjvskKO8l/GxgHqXiI4Ekxkr4LtbovwDFOac4z3WFDSPaUgTAPJSS6uOfnrPC0Io1euthwFXZe/wQ8N0NpVdO+IKbGVQeNe+y+ysBcJnhmvYIswUg4n+On7gT4UmhCke5w3VxPNHPzr/6rT831/MV0mjkNyjN5rjRr7mEhM93gf1K6XcCTgY9PqpnX6SG1ZNmomeSW53gutddmHk4NtvB1LxErrw84ew45rpefWIcRxhvVaUR0ZDFoLPIuNyA1YP1ulluw6binNnGIJCy4trStY+IOqfKdzgkma4+heUK9582ifK6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5qokaX6XlMpL9nvoIbYs7sr1SA4vJ5S3CHGsi6c79I=;
 b=PtsUktoLcKCvDI2u5bWpJ1vK8VLQ+ZEhqJbWtYSgn3hyt6Ca3umSl1hvxcmZFVwVgCXwJFWZchOlkrdnqiIZJLZ5ZycFeLmHGVtaNvHNQOh4Luxr27c9eE/SjSLWY6TxTqx7qdqqrJhUaILmsDFLd8jKSwotD4buPqsqbHvNRAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA1PR04MB10359.eurprd04.prod.outlook.com (2603:10a6:102:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 13:52:13 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 13:52:12 +0000
Message-ID: <f71f4dc9-fc85-40ae-8adb-d20264909d7c@cherry.de>
Date: Fri, 18 Apr 2025 15:52:10 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] tools: image-host: Fix potential memory leak
To: ant.v.moryakov@gmail.com, u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
References: <20250418081958.12818-1-ant.v.moryakov@gmail.com>
 <20250418081958.12818-4-ant.v.moryakov@gmail.com>
Content-Language: en-US
In-Reply-To: <20250418081958.12818-4-ant.v.moryakov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA1PR04MB10359:EE_
X-MS-Office365-Filtering-Correlation-Id: 37aeeb9e-7e8c-4f25-b6ec-08dd7e80381f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDZVaWliWWZhTTYvSWhGb1RCU1I0czlXbWRJRWc3K2ZCcmIrUWxLaGVTaXpp?=
 =?utf-8?B?RGlIVEhnRHBRVlA5K3crYm94WS96QVhPNFNCQ0IzcmExSXdKTG0rb0J4R20x?=
 =?utf-8?B?eGFsVzNDUXJOUU9KbXVGOTV1Z1BITjZqbHhheWJ6T2IvaU5LRkljQ3dMbTNT?=
 =?utf-8?B?a0NER1FIbWJRV1JheGNtU1RyMGpOTnc2bW9xSG5ucURrYXZ6OEZyWjRiOHpD?=
 =?utf-8?B?N251VzN3TFZZVWx3MGNNNVdheENTY1laTnRBNFlOeHpIRWZhSjRMam51RllV?=
 =?utf-8?B?ekpnbTBnNjZ5cWRQOTd4aGRwc3RpNmdzUjR2ZkQ4NElsQXdmbElyK05iQnhD?=
 =?utf-8?B?OHVwUWFaQnlCTzV2Znd5em9wZlVZZkp0YmJqL1FSTmY0aFl2QTdwd2hjaWhK?=
 =?utf-8?B?bUpUSUpITDROaWdSY0M4RVlrMlRDWWR0Qk16bUQxOFlwd2tzL2ZtN1UwTkd4?=
 =?utf-8?B?bjk0cldqd05FSUNqSTV3R3UwZlJadHdYbTdwbTZ5L0JHS2tSYnFQYThXSnhZ?=
 =?utf-8?B?VUhZUjBMOHBnZ0NuVGtUM2lET3l2TEt3Y2RuL2hQRDlqaFByTm5kaVNhMVcv?=
 =?utf-8?B?UDJ2NVlsaENpdUthUkdnRlpDcWcxcittOW1RbCtlYnFVcVRoQ3RHSGIrN3E2?=
 =?utf-8?B?dmdRUUM3alppbGEyOHBxdE95alZQTFZiZzFoMXpkYVZZMjFLQlo3cXpJZmR3?=
 =?utf-8?B?M3M3VTVJbXdRYnFxZm9tNWlnTW5uR1hrbU1yOTVVejBxek5RTEJPMWs0TVcr?=
 =?utf-8?B?OCt0RE5oZ2llZUg2eitoaGVpbnpQVXBGb2lMOU9HNmYzVVNDQ0xSZ1lXSWYr?=
 =?utf-8?B?K0hPOVpKVWpiY08wVmdrNkpSZ2ZUSDRwL3J2Y2dIV0tWRUI5UkVpNllHZkgy?=
 =?utf-8?B?MWNtTld0N04ybW9DUVM1UTVyY0dOTU05TTZ3VHl6cHR0OGZVMlFIVForSTBu?=
 =?utf-8?B?aWo2Q1laUUVFZDg4dFhFR0YySVZTNUNlNFJKYTN6anpPbTRLeVlweXlhSFhK?=
 =?utf-8?B?WXVPQkJiQWRGWllaNENWKzdzaHdsYWJCaU9QSGwwemtuWE5Nc0tOb1pDdnFZ?=
 =?utf-8?B?VmtTaFVCOFNnanBoQjhaWnM3Z0RXWEdldENyS0pVM01qVXE3VHhkSXBZa09w?=
 =?utf-8?B?aGlBQWVVblZKNXhTQ0pPZHFkRmg3a2oveDhMUzZyZVBlQlowMnBOdlRscE9E?=
 =?utf-8?B?b2tLb2xxQnhtWTc1czZudURnZzY2M21RVzNIbUViVWlSNEV1K1QzOXNVZ3Br?=
 =?utf-8?B?UEtuQW00RDBJYlNtNzlycVorMktaQ29LZWRuVWFIM0RUTzhaaUhhMlhEaDFr?=
 =?utf-8?B?TWRLSUNBSnBlRU16Tk95WktmV0wzUms5Z2FQVzVreHkrMW5ZL2x4SEhwVm5m?=
 =?utf-8?B?aW9rNG5RdVFxZVpGOGFPOEE1MnhoNFRFUjRlK01mRmlpN1d0eklXQ1ZSeHZL?=
 =?utf-8?B?NDJ1eE9tT1Jja1o5eG81N0dwSDFPTkVnSC8rY3U0Zk1xbk9PcHlLV0Z5RWpI?=
 =?utf-8?B?aUVXemdGWEcvb1g1MU5TWmFZTXhoK1N6S2VQYXVpMytmV2IySStuQXFkNVht?=
 =?utf-8?B?K08yREJyNVhES3dGbUxVWitXOHFNYndmS09NU1lQaGl1Y0FmK25hck4zMjUz?=
 =?utf-8?B?NjVvRXBVQWJaYnlmNEJxL3NiSFRBaHkyRXlmcTRERDJpYVJ3V3RVMlVTdDZz?=
 =?utf-8?B?QnZBd21qWk1DaERHZ2VCc3A3UmtieEpzWFJTeWt1bFpxMXhkU1JGM1JUYnpq?=
 =?utf-8?B?Y0lWbE9FejRJY0o3K0szV3QzaXUraHhJTG5SYUswUVNJRFlRdVd5Tkx5NnJ1?=
 =?utf-8?B?OHZKd1p5dHE1Qjh6WjZ5VXdad0d2YXd3cVlLQ2VzdWFTOVpuS1ZtVDQ3VjVU?=
 =?utf-8?B?VklOWEhqQUhoQmRWdHZRMWNpbk92Q1ZYUm5WdlhWODQxelVGWmJoVXZxNm5T?=
 =?utf-8?Q?j3WnD6hC5Yc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUJ1TTdENklLL2xnTTUydmh0TGVldjNLV09ycFdpakhzam0wUDl3OU1RSVo2?=
 =?utf-8?B?NlhmeVVGeU4zQitYNEZRUi9VT2ZsVjRCdUFRQkttZFhFYXorLzVKcVIzdGdX?=
 =?utf-8?B?WTJvVTdZcVR2NncweW1xVWJMYmxBU0xyUSszd3YvRmJVMnBwdlNwNFlTLzhp?=
 =?utf-8?B?c2Y4ZGRWa2tlK29OTEI4TGFVMjVQK0xnc0RxMFF0bDNnWGVKT2pncURXLy9E?=
 =?utf-8?B?S3gxKzRNRTdUNWQxb0dpMGtBT21NWHFuT2dvNU1XeGR4SHZNUzViMjRPMUJE?=
 =?utf-8?B?T0E0Y3k2a3YrU3NEM2Eyalo4eDVCVS9EQ29YK1Frc2plYk1aSjEwY2ZhcVVF?=
 =?utf-8?B?RXVHZGZiUWIwSmhvbHVYWUZMQlp3UVN4MTZUUmFNR1Y4RC83T04wUmZkN3Y4?=
 =?utf-8?B?VHVoalcrRGpWYkp4K2NpK3NZb0ZIazRGZUd0dU5tNEdwUGt0MUhkb094NGU1?=
 =?utf-8?B?V2hpT0NENk9QMnBRNHlPeGpyaTlDeSt1SlZxTjdwNGJIbVFaZkZwQi9Tcy9s?=
 =?utf-8?B?S2N6b3BwSHV4WFlRNjJVNXIyS1hyWit0clA0QVBGNXZyRHJIR0tTSmxOdStN?=
 =?utf-8?B?WDIzajRWZitpd3doV3QyY1lGVW1xMmluZngwYkxuMjlVVXljelZGVWRMeEl6?=
 =?utf-8?B?RWJmYm1xbTY3aCs3VHdwd1JadGp4WUpXelZKdHg0N3lleUx0Zml2UG03YnhJ?=
 =?utf-8?B?YjJpR1FXRGZVeTZPekZYSHl5RlhidVUwcVdGenhMUEFpM0J3bzRETWs1V2hC?=
 =?utf-8?B?bEZxeVM1TUxSR2dJMit0L1NUUjB0eGtFRS9tMTFyMURua0NaWDYxNDVUNGFP?=
 =?utf-8?B?M05JRHVuYzRGeGhTNmlOTHlPMkJSUmh0azF3cTVHWlR2YXRYTlpVS3orVDdv?=
 =?utf-8?B?bllRUHZZOTAwdlFzZXVWTFRNSHJjUzVBSllwNzE4RUZyTGcvNzZSL0xvWWY0?=
 =?utf-8?B?QmFYZGk5V2N4Rm9oRkQ3dmg3VDJsNUx4YXpZd0Z1UWR6RHlpbmNHRURHTzZY?=
 =?utf-8?B?UkgzZzRPT3pIMXUyTVZYbE8rVVJ1bzdiU0libmhIK0V2akt0TTEyaURRMkxI?=
 =?utf-8?B?dTUreFRBM0YvTTdWWlpOWWoxQWozVDlLRUV5T2FPZUUwNmNBVXF5eWJJTTFy?=
 =?utf-8?B?NkhvMW0ycjRTMXFBckJhVnk0WndTTHdvZTBKNWlmKzJPeTRUMjdmM2ZpWUlr?=
 =?utf-8?B?SHEyWGNsRGhDSkJENkZNamVadURDMDIwSExyL3pQMC9XV3h1ZjNVaEE5cXEw?=
 =?utf-8?B?OEd1Wk4vUW53VXRuelNNay90ZVpqbFZMMEVMb0htT2ZPMXhuVVppeUYzOTdX?=
 =?utf-8?B?Vjd5M09lNzN6M0oyVHcyeUs0c29mRUJiR3NZNzdlN3NRbTJMQy9jZThYN0E0?=
 =?utf-8?B?ZFVkQVFqS201VE11R2hnMkJNWU13UFhON3VoVCt2UC9KWUpMalVhaUdRNmZQ?=
 =?utf-8?B?bDlPK1ZIdCtGRnA5bVJNdlRaMmZvVVVoWlNoREFuOGdMdDBpb1hKVUxIRW0r?=
 =?utf-8?B?VGcxR0NFWnlwQUNDV3RMTkYvSjhLeGJodWtLK3FsaXE5ZXBSZ1RQQjRxWmVx?=
 =?utf-8?B?MnZRWGJUNUJoMmtkYzFCSkRUdjZ2UUdCeFZvOFZ0YldsYVVLQmV4R0hsR0Y2?=
 =?utf-8?B?TG1oWHJ1V01JcFBwdVlsTTVRUDBqeGFULzVxQUJQZVdUNSs5WXFDZ3ljZks4?=
 =?utf-8?B?Y1czUzhNQzk1VkFsVHpTc1k1WmNRMWNmVmtjcTFDbVF6ZmcySzBNREIwMWdn?=
 =?utf-8?B?SGMrSnh6dEx6bFlMeXFpOXkrTGRwSVpud29PbVdwR00vM0ZHbk5aZVUyQjhr?=
 =?utf-8?B?K2Q1V3VQaGJxSkxrakVPNm9jMENjRzNGc3Rad2FNUVNkOGIxMWUyWXpSY2hp?=
 =?utf-8?B?TkZ6TkFXd2l2aEc2dCszUDc2ckNvL2FHYjNReE9xaDkwNWp3eDB2Qm5qNW5L?=
 =?utf-8?B?dFR2Q2pabkV0Q0JoYlZmOUZLOXBXSy91dHYzSjZDbWF3dE9zcDMyQjFSaU9H?=
 =?utf-8?B?UlFzZkpVZWhJbVdwcEdYU2EzalhnNnJWVHBna2hhcHRTWlFkVDRtcTBSVGtx?=
 =?utf-8?B?STBhc294V3JWbmpETEprRytRVHlIRHJ4ME4rcHV4bW1mS2F6S3JzdUhFT21x?=
 =?utf-8?B?Uk1kbDZ6UlJPcWtScXZaSUpHZ1JJM0dwUjVYekhrRUNUWS8yeVF3akRhcHQr?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aeeb9e-7e8c-4f25-b6ec-08dd7e80381f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 13:52:12.0013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zitoezzZcEKmlPFkACwXB1Avt3JcvJGq5zxUnchcScpMJl506EM99h4UA/1lA9onXCapzJp/Q9AzrdHTfiybY39gZt5oaxU/YsyV6uvhuhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10359
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

Hi,

On 4/18/25 10:19 AM, ant.v.moryakov@gmail.com wrote:
> From: Maks Mishin <maks.mishinFZ@gmail.com>
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>   tools/image-host.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 4a24dee8..6b17b810 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -1024,10 +1024,13 @@ static int fit_config_process_sig(const char *keydir, const char *keyfile,
>   	int ret;
>   
>   	node_name = fit_get_name(fit, noffset, NULL);
> -	if (fit_config_get_regions(fit, conf_noffset, noffset, &region,
> +	ret = fit_config_get_regions(fit, conf_noffset, noffset, &region,
>   				   &region_count, &region_prop,
> -				   &region_proplen))
> +				   &region_proplen);
> +	if (ret) {
> +		free(region_prop);

We have a handful of other error code paths after that that would need 
to free region_prop as well.

value is likely not freed "enough" as well, please check.

Same for region.

I would suggest possibly something like:

diff --git a/tools/image-host.c b/tools/image-host.c
index a9b86902763..f97af2109ad 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1076,51 +1076,54 @@ static int fit_config_process_sig(const char 
*keydir, const char *keyfile,
  {
  	struct image_sign_info info;
  	const char *node_name;
-	struct image_region *region;
-	char *region_prop;
+	struct image_region *region = NULL;
+	char *region_prop = NULL;
  	int region_proplen;
  	int region_count;
-	uint8_t *value;
+	uint8_t *value = NULL;
  	uint value_len;
  	int ret;

  	node_name = fit_get_name(fit, noffset, NULL);
  	if (fit_config_get_regions(fit, conf_noffset, noffset, &region,
  				   &region_count, &region_prop,
-				   &region_proplen))
-		return -1;
+				   &region_proplen)) {
+		ret = -1;
+		goto out;
+	}

  	if (fit_image_setup_sig(&info, keydir, keyfile, fit, conf_name, noffset,
  				require_keys ? "conf" : NULL, engine_id,
-				algo_name))
-		return -1;
+				algo_name)) {
+		ret = -1;
+		goto out;
+	}

  	ret = info.crypto->sign(&info, region, region_count, &value,
  				&value_len);
-	free(region);
  	if (ret) {
  		fprintf(stderr, "Failed to sign '%s' signature node in '%s' conf 
node\n",
  			node_name, conf_name);

  		/* We allow keys to be missing */
-		if (ret == -ENOENT)
-			return 0;
-		return -1;
+		ret = (ret == -ENOENT) ? 0 : -1;
+		goto out;
  	}

  	ret = fit_image_write_sig(fit, noffset, value, value_len, comment,
  				  region_prop, region_proplen, cmdname,
  				  algo_name);
  	if (ret) {
-		if (ret == -FDT_ERR_NOSPACE)
-			return -ENOSPC;
+		if (ret == -FDT_ERR_NOSPACE) {
+			ret = -ENOSPC;
+			goto out;
+		}
  		fprintf(stderr,
  			"Can't write signature for '%s' signature node in '%s' conf node: 
%s\n",
  			node_name, conf_name, fdt_strerror(ret));
-		return -1;
+		ret = -1;
+		goto out;
  	}
-	free(value);
-	free(region_prop);

  	/* Get keyname again, as FDT has changed and invalidated our pointer */
  	info.keyname = fdt_getprop(fit, noffset, FIT_KEY_HINT, NULL);
@@ -1133,10 +1136,14 @@ static int fit_config_process_sig(const char 
*keydir, const char *keyfile,
  				"Failed to add verification data for '%s' signature node in '%s' 
configuration node\n",
  				node_name, conf_name);
  		}
-		return ret;
  	}

-	return 0;
+out:
+	free(value);
+	free(region_prop);
+	free(region);
+
+	return ret;
  }

  static int fit_config_add_verification_data(const char *keydir,


NOT TESTED!

Cheers,
Quentin
