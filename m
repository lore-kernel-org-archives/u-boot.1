Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A771BCE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 15:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C3B839D6;
	Mon, 17 Nov 2025 16:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FWtmdvHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FA8883AEF; Mon, 17 Nov 2025 16:57:06 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A1D8399B
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 16:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPHFHx00H0RM7SDb4lH40ycby2hP2GVdS7sguczXCYoQAVEvz8/iV7z+WWUMxqFz1G3t1IYjQp9awWfIXrBwQfEexM/Beg/UC0CshLg/fGo3j5kD+tin6CIVhl8I6eFAE26q6VUQYf+dwgNIzqqTZEkJx23K8SeacMp4sxSZ02U77Lx3Zv9a4Zcx2o/qgTHmtKmbxJIulwQFYswCV65Rpi8d+tAULsfvCnz+fgFE88ahH8i0HdJU4i0iHRdQgqX0JvIvifEIKxPXdgqYJByhyh4VLEnR16fGYW7TqMdl7czMRm7yZJ40n55NFCmDMpfDltbDeOftSn8HxJ+xMyoAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iAhnRare2KSuz9mpY6U66tTgKmizwrniActniFM1ig=;
 b=sHmJr+XTmLw3lnMNne7LPwAk0u2kpIJY2qg2087VApWch029WaeLiu16Cq/1P2hT5iZjAon7FS/G5FzinrT2spSQXI4qRhbj1TezWllkErVsQqkru/xeqAjypw8+hJm6SnHXS3GvczIChdbw/rG6rORxiVJl5jcTJEUlA89y6JBdOdyEDqOUubboWTBYejgM0fmzuAqBcREUwyIPnHJ/WXom2HEpOqtXx2gxG+2sE9GMGUALbGFWL2WKV3P0eh02LEFnrgVT16GczYbGn9/k2i30pR4oKV9VRpjd/SA4xkTIdjvOM868verMOcq3qxvuhiVi7wnrDy0trFS1twjrkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iAhnRare2KSuz9mpY6U66tTgKmizwrniActniFM1ig=;
 b=FWtmdvHVrLO8xu1y+t1rGdup6bcecwS1Zm5XuEV/WbsbAlJV4DpjBsep3Lj7ioPGuGh0nqInG0Xdqj0/VWhAsyNfHC+JDh3JxyFayGbHUuoVlFcEzXvAtF2MSvq4dzV28ZB/dnFGU3AU6rg0KexHYlmgCSD2spcpb3eP5JLPARw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AMBPR04MB11812.eurprd04.prod.outlook.com (2603:10a6:20b:6f6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Mon, 17 Nov
 2025 15:57:01 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 15:57:01 +0000
Message-ID: <c2b48b27-9d4e-4be8-b94a-4aac7ef922a8@cherry.de>
Date: Mon, 17 Nov 2025 16:56:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add support for OpenSSL Provider API
To: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl
Cc: u-boot@lists.denx.de
References: <20251027195834.71109-1-ekovsky@redhat.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251027195834.71109-1-ekovsky@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AMBPR04MB11812:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cee11a-918c-4d22-648b-08de25f1f1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tnl5ajhQdzVKQUExKzNLeUxQajlHMkRIN0xYSjAyRnRjVkFkU3ZyWEdpazhH?=
 =?utf-8?B?UG1DU01nRVN0Ym8vZ2hOMDFHekZ3UmNzb1JkRldGaTdYeGVuNlQyeUsxNTBT?=
 =?utf-8?B?Z2ZWVW4wY3lUS05mY1FGTU0rVlhGV1RSeERvWFNvUWN4aXRwTnpFSXJkaG9l?=
 =?utf-8?B?QTNmdVgwZkxpQURqV0VLSmd0WTVKUUhTbUMzMTBXbkJaM05CNFhGc0VpTWF4?=
 =?utf-8?B?RWMzOGFacU1RbW1Makd5OU4wekRwbFpZQU9MeEFlbFdwRlIxU0UzMWdUZlZ2?=
 =?utf-8?B?cEVyM25XRm1WTFFHWk5BUENXM25hM2psSEU3L1N1SjhXdWhuUlZaYkxjL0VX?=
 =?utf-8?B?MEdoUTk3K3gvSWF3Zkhxd01VTmxKT0R4b01uVk1pdVlJUnkzREUxaVlhWGkz?=
 =?utf-8?B?UG1WVzdsREFPbU03b3ZLS1dGN2w0R283aGVFT3BFTis0MVNrNU1TdlRqcUVP?=
 =?utf-8?B?ekgxam9OTVU1SlVacjk5blI4UVJnTHJXZnA5ekIzaTgzRTh3dXpxUnBsS3NZ?=
 =?utf-8?B?MHZBMVFSY214d2IrOFlOWlBuenNiQ0FSRjVEMWF1MlpSbXBkQXVWYlpRaHBk?=
 =?utf-8?B?MW9ZWnkxOWhVMEJqN3BkL0ZvQzFlZmdjdzhOQ2dCeFBrM0pwaExqMDlub1Zo?=
 =?utf-8?B?c3M1RVdRT2xhYmYrRnRWMDJNMWJIUzhVUTJkaEpZWTUxb0dOREVBekwzNktZ?=
 =?utf-8?B?ajFhbW8xVWpiOUZSTG9wb1ZCbFpBT05KSlVPYTNFbDJpMTZzWEFVVHpJY1Np?=
 =?utf-8?B?NzF6WFRxcHYydFo0NlI1UlBMTXkxMFBOTCsraUQxeUxOZ2hmUkY2TGQ4R3Q4?=
 =?utf-8?B?YThTL3Zja3ZWV1duR2N1VGdvNUh3VGRGVnZiaDBpUm01dGE4ZElMZTk3cjRE?=
 =?utf-8?B?dUE3YSttdkUwVzVIVUI4R0RYeWM2ZGxLRnZ5azViY1Q0U05icXU3bitDY0ZW?=
 =?utf-8?B?alNXcncyb1F2bC96b3hKaExEdnJ0YlNDZVk4OERUQWR2TGJXNjEvNE9yNFZO?=
 =?utf-8?B?aGZpWWowKytsdXRjempleEFDWXFYU1dBdmlBT0s2WlRaNGxZNmo3cE9oYmhN?=
 =?utf-8?B?UFdydHZQTTY4MGJ1Tk16UW5Lc2ZrMnR4Y3plR0V4ZCtwOUVqdWJoZnJwbUMy?=
 =?utf-8?B?Wjkvd2NteGE5RkRLUjJQT0Z2TWpvMHVrVjIwZ0J4RWRTLzdoc2QwdTZuZHJn?=
 =?utf-8?B?QU1aZzcwMit3YTRuTWRrY1ZkVTREc2F1dVpPMUxkaE1uVEk0MWRsZ2pQMERH?=
 =?utf-8?B?VWVKeS9yTlVqV2srNVUyTCtWV0tmVHlKODJUc2srbERKbVhoL2VOSnpLRGV0?=
 =?utf-8?B?ZjNiNUxXSk9Gby9HVTdYeURLQTFIb3BySzZsY0tCTzhLdjdUTTErT2ZiV1Jv?=
 =?utf-8?B?Vml6UHlCem56blp1NU4zOVhhN3JUd2tVZE5GWnBMbXI2SzlybU5TWC85d21G?=
 =?utf-8?B?OXJQR0g5WmY5dW44bHhLQ0d2VzM5L21QajQza01UN0tTWUlEZ1lZd011QVo4?=
 =?utf-8?B?OURVRHFhNmV0S3g3MXgyVGM3T3o0Vy8zWklIclVBT2tQVXVUb3lzVUQ3Nm9L?=
 =?utf-8?B?VWZMSWlSYUhtZnA2V3lpV2JDRG9WZ2NaL1dSN3g5RnZyUXN2TlZLVEJGNGNt?=
 =?utf-8?B?TytFRlM2TWxjV2ZZdmRyZDZxUEo4VG51OVdmUHhmQStuMjJFVDdFZ1MxYkZZ?=
 =?utf-8?B?NTR0ZElJdnB2dzZUYWljOEVGZ0hJWUlIY05jR0llNzVYWVVZemFzdmVGNU16?=
 =?utf-8?B?bk5PdnJXdUhvT1czM1kycFlCS3RFeEh0WXM2bzZQT1Q0RmVtT3dWeEwzR3Bp?=
 =?utf-8?B?R0lkMndwUDUvWHB1WHl5U1JrbmtUTitlRWdjbjg2VkViM3ZiMXJWTWc0em5s?=
 =?utf-8?B?WXoyTXkvZitmeXc3Yzc2TkFIbDhzTVJIYjFocHBFdHpTWnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDFLWjBEdy9iTXlMc2hpWnQvYURWUDg3MXlKVVF2Y2Rqd2M1YjFtc29aMllH?=
 =?utf-8?B?NzJLUGl6ZVFUcnFkZ3FBWDdRSlFnb2wzN2Q1cGVIeXp0OTJtQkVXbXAyZnNR?=
 =?utf-8?B?ZjEzZC9ZdWF0VkNpMFQrSWZUaWxXbVNyd0ZINzd2eGdjUTJBbUFicEVjT1F5?=
 =?utf-8?B?d2RQbWRQWGk5R2R0aUtIUzRjRVcrRnRaZ1ZrK01vc3dJMXQrRDNUdC9Ib1Nr?=
 =?utf-8?B?Qld1QWZQa1VJS0M0eEJPa0l0SmM2QXp2K3N3eFIyR2t4eU1uVnZCZFE2L3ZG?=
 =?utf-8?B?SzlPRGZXNy9nTkpMWWl5MlkwYWdSSC9aNkcwWHNYMmpycWpUdG9hekN6WVNL?=
 =?utf-8?B?NkUwb1psOXAvVWhFN3JycHhQeTQvKzhHUGNKbzE5SE9QSG1ZUDA2UXhxK3hY?=
 =?utf-8?B?OHpUWHR6Q01MZjJOOFUwMG1scWFEVXByMlpYb3BaK3FuUWdRcXlsazhCa2RJ?=
 =?utf-8?B?ZGhaK1ZkZ282c3NRS3g5RjdzS3BUWTRpQWRRdUZ2eUptYk4wcjhTTzEwRHpC?=
 =?utf-8?B?RHoraW9QclhDdHEwR1NIdjF5WXhHZzdLY0JwbUlYMlFOTVJJUVl6a1p5Wm04?=
 =?utf-8?B?ckV2djR3Z04raUZRSmJIVGtuQkg4N0tuTkMzRHYvUDFIa2gyYTBLOGczSjBK?=
 =?utf-8?B?R29xdFFVanNVTXlHQ0s1TGNPUGJBNStiZ2RHRWZEUjNMbmpTYlhubFArWGxS?=
 =?utf-8?B?M1Vyc2cyZWpaUTlpN2dsSVowOEMzZEZUUVhRUEx2KytiV2ZnU0FDdVkxN2NW?=
 =?utf-8?B?dnF2aGlqQXlQYnM5Y01GZVNpUFdCNHdnRVRvbENERCsyWmFFbktFYm56d2lP?=
 =?utf-8?B?YWNxWGhLemJjbU5ZWGVPajJEYnhoNUxjd2JKYzBZSCtsdGJreWJNKzM2NXNE?=
 =?utf-8?B?NU9aK2FzeUhpeWl1OFVVQ1p4VXc3RkVoUlVpTzIrbEV0bVJQK3g0NG5OUGxY?=
 =?utf-8?B?djBFZmZodHdjUVJrMnRCY0ZuMVRQRlhJOU5CVXFpdXRpNHN1SjJDSXpZeFc4?=
 =?utf-8?B?ZXhQL0toZ2NCdXJVeUJnUWxvVzdMTTdScnlRU21jcWNHK2RqVGNPNjB3V2JZ?=
 =?utf-8?B?NW44ZGZmVVYwbHVWdUQxdHg0bjYrbEJpRk5wS0RBcEVJTlZjdTJhTHJhbjJu?=
 =?utf-8?B?bGVRNm1QWlBEaGxDM3ZTZkZaMk9Ndll1WnBCU1ZXTVc0Q2Y0TXN1eTl0TEVn?=
 =?utf-8?B?Z21JbGQ3ei9VM0M1QVNhVWZJbHdZUGpJeVRaMGJCNW0zNXpIT1FURk1sbnlN?=
 =?utf-8?B?WThkWXhNVFBhZ1VRVzhSMGFVNklDOFYyaWpYRUhlVHIyUExkSkVmakcyNm1p?=
 =?utf-8?B?MEJKeW1neTNXdVh3UGNoc1QwWWVSSnV0dlpvSGJNZUN6RVBtU0M0QzFGV2Vx?=
 =?utf-8?B?Vjc2cENucHlLaG1QWXUyU0EzMDFNY2wxV2gvdEYvOHp0bWZXUjVZNDJRMmM4?=
 =?utf-8?B?T1ViSjNGM1RoTFlHdDh0RzRqTGY5VVErUWdTZWVuUnQxbC84dkdqNG9VVC9U?=
 =?utf-8?B?R3BVVktWYUw2Mko4NVE5WjRyc09FWmFYU0RQbjBPZjZWdmszUGQvWnNPT1Fs?=
 =?utf-8?B?QzB4eTVqdFc1TnVBajlEVjFQb1Bvb29FUWEzSDI5cjZyZDBRRC9SRVJhVWZ4?=
 =?utf-8?B?eEhPbUNReXJsWFVHSjJhT1BQRkxUcDUzY0F1Q1lhb2NsdERJaHRFcFJ6M0hS?=
 =?utf-8?B?MytONEZVNy9SSE9UR05CaXpPekdGYS9NZW5HQ20rMWxHVEp6dlhXeEk4L21y?=
 =?utf-8?B?RDhMSEZZaFo0MGlBeW4yMnhJOVJxeFlERHNJY2lpYXdCVGVmb3dwQkNvOW03?=
 =?utf-8?B?MHJIQVNweUpDUHhCSllrV3loWXJXcFBUWFlXa0lXVmFGbzhjY213SDJJeFEz?=
 =?utf-8?B?Um1jeW9Jd1dhMEFvOTVLaWE2WDhUQUdUY0xNckduK1Y1L2Z6SWE5ZjVBdHdh?=
 =?utf-8?B?VCtHaFJEL3d3Yzh5NGlNbnNrR1JSTnA0NHVrZnkvY3JDV2xHamVXVW5CY0ZX?=
 =?utf-8?B?WHF6aXROSGNRYWpXL3NHOVMycTc2NWNNeUNBWlIxRzVSeGJtWFBrWTE5YW0z?=
 =?utf-8?B?dXFxcVA3cUY4MGFNYWpTc09CMXN2dFVwZll3NjNsWTdYczRWSnEvUzZhR0t3?=
 =?utf-8?B?MkgrSDFtMUtLZDZSNlFWVGlxelpHZE9PM1pmVW85QnJlOGpNWkN0clVBcFRt?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cee11a-918c-4d22-648b-08de25f1f1d9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:57:01.1167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmBWtboV7WcqpHQA4psG1uThm1Sv9x70wMSHqckzE0YVrcFW/+kWGj/gjJXG4x9jzmGyrTpjqyMHwwh/sZ0emx+grEmFymd86r2lPROcN40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11812
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

Hi Eddie,

On 10/27/25 8:58 PM, Eddie Kovsky wrote:
> [You don't often get email from ekovsky@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The Engine API has been deprecated since the release of OpenSSL 3.0. End
> users have been advised to migrate to the new Provider interface.
> Several distributions have already removed support for engines, which is
> preventing U-Boot from being compiled in those environments.
> 

Which ones? How do I reproduce?

> The Kconfig option OPENSSL_NO_DEPRECATED introduces support for the

Please consider renaming this, OpenSSL itself uses OPENSSL_NO_DEPRECATED 
constants for many things. I would recommend simply renaming to 
OPENSSL_NO_ENGINE which is also the symbol OpenSSL is using. If there 
comes a time we have more OPENSSL_NO_ options, we can always have a 
"virtual" symbol called OPENSSL_NO_DEPRECATED which would select them 
all if one wanted for example.

> Provider API while continuing to use the existing Engine API on distros
> shipping older releases of OpenSSL.
> 

One can use org.openssl.engine: as prefix for provider arguments when 
one wants to use an engine still.

> This is based on similar work contributed by Jan Stancek updating Linux
> to use the Provider interface.
> 
>      commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
>      Author: Jan Stancek <jstancek@redhat.com>
>      Date:   Fri Sep 20 19:52:48 2024 +0300
> 
>          sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> 
> The changes have been tested with the FIT signature verification vboot
> tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
> Engine library installed and with the Provider API.
> 

Are there actually tests using an OpenSSL engine? Because otherwise it's 
simply checking that local keys are still working... which isn't that 
much different from what we currently have with engines when not using 
engines.

I'm implementing FIT images signing with OpenSSL engines, and it'd be 
nice if we could have something that doesn't require changes to support 
providers (or if it does, not in a confusing manner for example).

https://lore.kernel.org/u-boot/20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de/T/#t 
for the v1, I'll soon (next hours or tomorrow) post a v2 and Cc you if 
you don't mind.

[...]

> diff --git a/lib/rsa/Kconfig b/lib/rsa/Kconfig
> index 9033384e60a3..1bf0ac96d598 100644
> --- a/lib/rsa/Kconfig
> +++ b/lib/rsa/Kconfig
> @@ -20,6 +20,13 @@ config SPL_RSA
>          bool "Use RSA Library within SPL"
>          depends on SPL
> 
> +config OPENSSL_NO_DEPRECATED
> +       bool "Build U-Boot without support for OpenSSL Engine"
> +       help
> +         Add support for the OpenSSL Provider API, which is the officially
> +         supported mechanism in OpenSSL 3.x and later releases for accessing
> +         hardware and software cryptography.
> +

mmmm Cannot we use providers for something else than RSA? In which case 
it's a bit odd to have it in lib/rsa/Kconfig (but I have no better 
suggestion).

>   config SPL_RSA_VERIFY
>          bool
>          depends on SPL_RSA

[...]

> @@ -207,6 +247,37 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>                  return -ENOENT;
>          }
> 
> +#ifdef CONFIG_OPENSSL_NO_DEPRECATED
> +       EVP_PKEY *private_key = NULL;
> +       OSSL_STORE_CTX *store;
> +
> +       if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> +               ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> +       if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> +               ERR(1, "OSSL_PROVIDER_try_load(default)");
> +
> +       store = OSSL_STORE_open(path, NULL, NULL, NULL, NULL);
> +       ERR(!store, "OSSL_STORE_open");
> +
> +       while (!OSSL_STORE_eof(store)) {
> +               OSSL_STORE_INFO *info = OSSL_STORE_load(store);
> +
> +               if (!info) {
> +                       drain_openssl_errors(__LINE__, 0);
> +                       continue;
> +               }
> +               if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
> +                       private_key = OSSL_STORE_INFO_get1_PKEY(info);
> +                       ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
> +               }
> +               OSSL_STORE_INFO_free(info);
> +               if (private_key)
> +                       break;
> +       }
> +       OSSL_STORE_close(store);
> +
> +       *evpp = private_key;
> +#else

Wondering if it really makes sense to have the provider API implemented 
as an #ifdef to save like 10 common lines between key-based and 
provider-based implems.

On another topic, my first reading of the code makes me a bit worried by 
the fact that there's seemingly no way to select whether we want to use 
a local key or a provider key. Also, I see "pkcs11" and "default" here, 
but how do I select which provider I want to use (e.g. my custom one). 
If I somehow manage to have a key named the same locally and in one or 
more providers, how do I make sure the proper one is selected? I'm 
wondering whether we should be reusing the engine parameter to select a 
provider?

I have 0 security or crypto background, don't hesitate to be verbose in 
your answer.

Cheers,
Quentin
