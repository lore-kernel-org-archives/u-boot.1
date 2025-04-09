Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079F3C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 16:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74314838D2;
	Wed,  9 Apr 2025 18:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="F9+ZgRYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85890838D5; Wed,  9 Apr 2025 18:11:55 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD515838AB
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 18:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/lsrhEmliKDn8X4kSxqZnERXPGP6fbzjQaB3lG5mIZ+fPkj14WaZ5bGnWOlEbIww9gp5IxYjVPydJQdOSU5V8L7XtozflSaK6DBzgWX9XGwPbIXuXJiZdtNRF9UL2QyKldHJa+QVTD/lcEFOqETdhTSFYGq0Gv4+OOOVZvl0QDXPGm5UEyy/jm9dWSJUSf4CjhEj+k8CPkLQFvejPloQJzzgRIuucCAqrdO31D9B+cVnOC7v42l3d1qRXCiV9vQnikSqhWmn1mMG4UF7eA7jOuT3c2Jqtxa5OFgEv9h410r4GT7isCEwr8MQXoKXqrLz7hPgt8jIjDYzqGj7DwIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nud3QfA4TIQpOqDAMZAtQSJR0oIBV6KLJxGGnZ9vqOA=;
 b=OxGKvZLn6uYVGshaGnO0++HFhY+6lZG9XQZW4KQq0cpI9fpzgl9qMPUy9KDukBE5tc4l3Wvr2RyGjQh7+7xbYMOoVMUO3LvarvPO19fyNgPAO3HBuQfYzoaV2UE46YEEOAgu9iplBSrAW34Rjb8yKKqv3qrk+zUG4ZHdAeZAHowaDIjqlRFBmsvpvjGjcyKHgANBcm40timYv2kJ8GWVIoGbTSMPCoo5GqT92agX4LUHdF/cQreuZ9C7N3tHMfLK2E90X53HC9h2gtE/lX7ZyHpiMPJqWHAdT3XyHDQqSJZsJ7CLxSXO0SbJsFJ8NTJ4yt2xgE2NPG895cBDzWCyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nud3QfA4TIQpOqDAMZAtQSJR0oIBV6KLJxGGnZ9vqOA=;
 b=F9+ZgRYPNnngsSG8Mw9IucnT4oiyudsShgw5MobYKglnxnMlVB5rN+AK/vd7X4bDizQEy62JWq2/5JKP8BvvNiwPqvAHtuMwEjsRQGKwgxCOZwTzgWOcqJA+BYgRJs95hQBU8CZvuzuHGhnFIyJOJBfpcBTfGZFMmKUyLgbKqwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8076.eurprd04.prod.outlook.com (2603:10a6:10:246::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 16:11:49 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 16:11:49 +0000
Message-ID: <887d7a5c-0ba7-4e62-bee2-8e5c159710c8@cherry.de>
Date: Wed, 9 Apr 2025 18:11:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] rockchip: binman: Support use of crc32 for
 SPL_FIT_SIGNATURE
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-10-jonas@kwiboo.se>
 <5d3c9e7f-336b-4b67-a7f4-a25a61b0908e@cherry.de>
 <ac68b883-021c-43ac-b834-bafa54e7182b@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ac68b883-021c-43ac-b834-bafa54e7182b@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a9135b-f7eb-4dcf-43fc-08dd77813bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEZaSkcxNXJYaENCUGFOTnlMZFo2ckVvUjErSU5VMk8rSEZwNVBSeUd4aFcw?=
 =?utf-8?B?Skx4a2ZLYnZkYnBWcDlmdUpYQy8vVHVqU3g1MmdiVHp5dHlUVjBrKzBGRldS?=
 =?utf-8?B?M2JKQ2s3eWRyY2VWWlk4aTZtbmVDTVNiSnJYMTVXbzZXT0YwRW9pZjh2T1BM?=
 =?utf-8?B?MldWbnA4OXM0bEgrQVNWRHFRcThmbXhnUjdXazRhUnY2M0lpTWdZZEFqRWNI?=
 =?utf-8?B?S3lWSlFEOHE2aE1hWjUxQ3MzaEpvcVUxU01STC9DRkRvQm53N3RBejF3NEUv?=
 =?utf-8?B?M3ZyT0xwTllMeXJQOHlVQlFDVzRPVkVQZkdSMUFIMlNFTE4yR1k3STljNFZH?=
 =?utf-8?B?dmhQQ2poRnYrOUNmTUxFUGlDOS9BaVRGdkFSSkY3alNiK3hIbC9SOFlOTXB2?=
 =?utf-8?B?YVNxUmxVZU52b0lXRDdEM2J0QURCbi8vZi85VW5WRTcwbnh5QUNuaVljMG5I?=
 =?utf-8?B?OWtGUzY3alp5VEZwYlIrb2ZhendIOFZNbVF5bGwrVHo1SDgzanlIcVVGYnJU?=
 =?utf-8?B?NGY5aGN6dTNyQTdlSWRoNVdHM1o3WnhLcXBMbnByMDM2WGZvOVNFSUlNZi9Z?=
 =?utf-8?B?ZVgyS29xcFV5a2JBWjRBdTFMUjE3U0tiTWdSQ2xESkpuc1k0VVhoMzI1THpN?=
 =?utf-8?B?Z1orbVRtVDhqem9ZR29ZRFlJN1NNYldqNnFYQTJ3MEpCSjFIMmVYVUd5OEt0?=
 =?utf-8?B?NVM0N2t4UFZ1VTlmRUN1SW03bW5vQ01nNCs1b3hkcHJsWm5mV3lrRnlnUGtM?=
 =?utf-8?B?Lyt1NVpMa2lvUUFXMnJOUG1UUHhvaXdYc3RzUjB5bzhBMHJzT05TSnFML0tw?=
 =?utf-8?B?b1lLUlJybEJ3bjVFWjQzQ2lwcFUyb2paWEtYVHZPMGJCbFJhUURha1djR1NZ?=
 =?utf-8?B?bkJ1RFRGOTVYNllSSW5wTTFBbXd5ckY0S013S3lDcmxGMGx3d2RCNlBXZFdl?=
 =?utf-8?B?Y3lIK09ZanhueCtINDlZUDNOem1NV1Q5QWxtUG5Bd0VNRksyb2NselFsdWRT?=
 =?utf-8?B?aVhPU1dNenNoN25OV25zMDVUK3VXcGxnNUhkZHhhODg4TGlETHprdFJqQnF4?=
 =?utf-8?B?SjJ5dDlpT1UvMnpDOHdSM0JsTlZBbmRhRUQ2VStJQWZxUkI5Z241UWIzRTEz?=
 =?utf-8?B?R3RBcjR0NVhXKzNSUFIvQnk2NmxzN2tDejkvZURpemlJc2ZsZ0lOZnJYcHVF?=
 =?utf-8?B?NTd5VjVyMkdVLzQrdG1rQ011Z21Pc050bUlxaEhSNFkweUlVWHRKSHo3WThM?=
 =?utf-8?B?bmFSM0Z0cExadG40RHdQcmhIa0IzOWVrL0JnUTlFSEt6MlZkdElORHFDQmE4?=
 =?utf-8?B?Q3NxS2dmWS9ZY25zaVloNkFhLzk3d0dYb3J1dDJIWWo5aGhQQjB4UHkxQXkr?=
 =?utf-8?B?UWJOdjdTU2lvR3NjZDJMdWVHUlEzRU1QSjJuOGxaQTdySFFrNUM5VkJmMDVE?=
 =?utf-8?B?bU9GNEZ3UjVYUVhVT2FtYnB2UVMrYkF5ZW4rdlNhbHlZa1VWemliQVhZODRR?=
 =?utf-8?B?RWRqQlRCRk1ROVZ5TzlvTUZaOGc5Mjdna0RaVXdEUGJtbTRabm11TnFKZzIx?=
 =?utf-8?B?dHhPbk1MYk9yT0lRSTVON0h1Wnh0WWN3WVQyY2kyZDJUMHBZR0thK2RKYmtF?=
 =?utf-8?B?RDVkZHNnK015QUxROWRqUDhkcmNoek5DaGpkMmtOL0VNV3ZGTlI0eFVBR0h0?=
 =?utf-8?B?enlyeENsSXE5NmpuQU5wMzVGMU42MHVMTkduVkNQZk0yWVBtbVRZODVYQ3NO?=
 =?utf-8?B?eTZMeU5JdXNFL29wUGJwMGpmdDlhMDRWVER4K3FyQkRrTzhaQmlsSGtONHhE?=
 =?utf-8?B?dEtyNklFOWl1ZmtEY3FHQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVMzV0tsR09oUHJBSE1Zd0pwQ0hEM01lV2FEOGgvSWxpMVQwMjZjL2RDdlpx?=
 =?utf-8?B?VkJGR0JQZHhmVWtWQWptYS9IYVhtb1ZzMEpLa1ZGaUV3ZFhORE9LKzB0VUQw?=
 =?utf-8?B?cDJtOTZycGlZV3Q2eDhjV2VuQndsOXlHcjd0WTFIK21kUmkwLytXTk1aSzZ1?=
 =?utf-8?B?WFoxd1dZeXp3RlkzaXU2eFYrSXcxVUkzTm4zTitDcVBYQlZYdjR6S3FFVVpi?=
 =?utf-8?B?TUd5c1h2OEdMVTZMaGQzSWdodjgxOGZ1YkQ3NGtoMnVTQXMzdXBTb05JWGlZ?=
 =?utf-8?B?SjRvaHM5SGxVTWxSNVovanA4WDlIYU9PTzlrMHEwU0Vtd3BtRWI2TTBLV3V0?=
 =?utf-8?B?Z1gzZUphSUxMR0NKcEZjRG1YY0NzeDdyYVJqRElDL25GM2pBSnhjcmFLMUlG?=
 =?utf-8?B?NUJUbCtSeHhoTEVaZWpNcWx4cjdmMVhmbDdUT0RTYjlnTUNpb1htUitaQXZP?=
 =?utf-8?B?bFF2aHA5WnRJanZ3TWIzOUpKNlMzZWcxYkZseXFCVWdyOTBldXNmUCtNY3o4?=
 =?utf-8?B?ZWRZcnFzUVhoblIxb243aHVNckFFcXpqd0wwOFhITGQ5b0NLdDdnQ09LV0ow?=
 =?utf-8?B?N1VRbVhaQXYwUS91MWcvMEtQcDZNU2F2aTVhUlZXcTg1Y0orMG1JUHBUSHR1?=
 =?utf-8?B?dGdvRTFlaGN1dGRCQlpROXdQMWVMdGptMGh6bHk2eUZ4cEQxMENKQ3IzMGpW?=
 =?utf-8?B?eXI3YmpHSWxsNzRUQlVqck80OGhOMStuNnFNZnUvUlc2U1pqaUtINkswRjRY?=
 =?utf-8?B?bmpHZlZTQmJtNk8zNUxldVJQQ290K1d2Nmdtc3NCbkE1WjFaS2lkeXAxOS94?=
 =?utf-8?B?NmhMNGMzejc3R1F2YXRlZTBmdEdtTHpoWFZlc3NiZWk5c0dmcExEOTVKeHI2?=
 =?utf-8?B?SlI3cDQwY3FzYk5nSlo4bm9Rb2ljcFYxSk5XL3VMVHdFbnZoM0V3SXduSVdX?=
 =?utf-8?B?S09CSFNreHJWRkMvSDZOc3BjS0R2ZXdhZkRZQzMrZWs5TjEwb0Q0anJSaURy?=
 =?utf-8?B?Y05YU3ZaOVQ0ZEpRTk5TeEMraDkrYU56WTdUa1JSVEt0TllIT3hya1JXT0Vz?=
 =?utf-8?B?MklFbjJLdHlnU1IxMDU0dXdEekVVNmRZMGxOb3JGSWJhSE9PVjRkKzN0Ymdt?=
 =?utf-8?B?eThuTnE4UDFQWjc0U2xVOFh3TC95akx6L2hkTnBpeDJyNDNGRUNLR3NhRjRw?=
 =?utf-8?B?emx1V1R0clBkVUxYR20vZVpBSE1TeXowWVlkTjZHNFB0RTlNTHZzUUY2V1Zl?=
 =?utf-8?B?Wlh0YkwvaEtJRmhXVXA0Ny9ZQkhVWjJmcUhIQlZ6ZGtWaTN6Vm5KZHpVRGZ4?=
 =?utf-8?B?OENDRnd1bmJHQWw3MFRrNGgzSHZJVHNiR05jbno3UzZiNk1UdDZHemgrcUtT?=
 =?utf-8?B?YVVzS2QwMmFtUTRPRzVzSFpNQXZzeHAreXRsYjlYOW5RNHdFQWFSVytlZDNR?=
 =?utf-8?B?c3B5UGpxM1JpcXZtY3d3T2l2K1lUZ0JLMFdIUStldWttNlZJNmlFVmo4aVZH?=
 =?utf-8?B?d0Jkdi9tQXJsdFRlK1ZHdGJKbmlDNThXd1RsOU5kUisvc1BTakpBb0E4aWxS?=
 =?utf-8?B?RmlSWXpUR0VZazdHUlhFWlkzbHJLbjJJeWFrY09TNnZwczVrUUR1TVhtamVQ?=
 =?utf-8?B?dzROVm43SHI2dFZyTDlXbTdWWEFPbHl2SzBqd0x1YXVUck5jNnVtMS8zdmlk?=
 =?utf-8?B?TTJPbEZEMEMzVWFkamlBWU5ud0dvMC9nYm1iUktjWmJQUVpCaWh1VVgrWm9M?=
 =?utf-8?B?bnh5WkxtWUhLV0NMeCtJZWFBcWZCVS9ucUlzVGtwVlpKckRKVVU4a0t6emU0?=
 =?utf-8?B?dXlSMkt3TW55d1ZDUTZlb04wak5CY0F3cW40Mll0Q2lXOGFHVXVyaVBXRXBj?=
 =?utf-8?B?MVlCcGdrSGh6T0tHbC9va2hlbm1nSHFFTCs3cmJ5Qk5DZEJkUnQ4WVlxc1pI?=
 =?utf-8?B?SFJDRlV2MzJHYmVvYXBmdkRxMjI3QnVLcll5Z0JlckQrc2FCK2pHbFBuSjFm?=
 =?utf-8?B?SU9JR2dzOHVwTVB4WFFaM1VVMGk0ZGJVRUJUSzRoWTJRR2ZlTm14WU1USnkx?=
 =?utf-8?B?K3RhTVh5bkVpdE5CZytqVVFNSkV0ZjZCKzNYS2dBNDRwRTdScitySkJPZDBI?=
 =?utf-8?B?RWRoaVAzQXpJTW1Ob0doRlRZR2YvekRYci9FTkkwYmdiZXkyQjZMT2VpbWlN?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a9135b-f7eb-4dcf-43fc-08dd77813bd4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 16:11:49.6225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fVfKz/JQW/YOeDXa/j3qkZdgHBIYjAaZKxHMoNF7Wc/s0Eu4f3vpErn53JM5uL3aTA8Ma8QnZ4av9Pf9iJL1FJIwCPlj4m43m+Ttcn8Gx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8076
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

On 4/9/25 5:38 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2025-04-09 13:06, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>>> Use of SHA256 checksum validation on ARMv7 SoCs can be very time
>>> consuming compared to ARMv8 SoCs with Crypto Extensions.
>>>
>>> Add support for use of the crc32 hash algo when SHA256 is not supported.
>>> Also use a HAS_HASH to simplify the ifdefs when no known hash algo is
>>> compiled.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>
>> I don't know enough about general security but this very much looks like
>> a bad idea to me.
>>
>> https://web.archive.org/web/20170210173741/http://www.derkeiler.com/Newsgroups/sci.crypt/2003-07/1451.html
>>
>> """
>> While properly designed CRC's are good at detecting random errors in
>> the data (due to e.g. line noise), the CRC is useless as a secure
>> indicator of intentional manipulation of the data. And this is
>> because it's not hard at all to modify the data to produce any CRC
>> you desire (e.g. the same CRC as the original data, to try to
>> disguise your data manipulation).
>> """
>>
>> (yes I took the "first" link my web search engine returned me, thanks
>> confirmation bias!).
> 
> I am fully aware, and the fallback to use crc32, and current primarily
> use of sha256, should not be considered a security feature. It is
> intended purely for a checksum validation of the binary blob after it
> has been loaded into memory and before U-Boot otherwise unconditionally
> jumps to and execute the loaded blob of binary code.
> 
>>
>> I don't want to give people a false sense of security. If it really
>> comes down to it, I'd rather have an explicit Kconfig symbol to set this
>> value (maybe have a `choice` even) and be very clear about security
>> implications.
> 
> Prior to the addition of the hash { algo=sha256 }, there was no checksum
> test and U-Boot SPL would unconditionally jump to the loaded data, even
> if it had been corrupted, was only halfway written or otherwise
> overwritten.
> 
> The addition of crc32 instead of sha256 is just to allow older board
> variants with weaker SoCs to at least have some sort of checksum
> validation in use without affecting the boot time too much.
> 
> On my rk3228 board, validation using sha256 could take a few seconds,
> and with crc32 it could be measured in ms.
> 
> To me, having at least some default checksum validation is preferred
> over none at all.
> 

Except if this confuses people into thinking they have a secure system 
except they use CRC32 instead of something more appropriate like SHA256.

It seems like the "hash" node presence doesn't mean a FIT conf or image 
node is signed. I also don't see many device trees with a signature 
node... which is kinda odd. Looking a bit into the signature node in the 
spec and binman tests, it's not clear to me if the hash node is reused 
by the signature node if if exists and if their algo should match and 
what exactly is checked by the signature node (like signing the hash 
string contained in the hash node(s) listed in sign-images property, or 
(re-)generating a hash of those and signing it at build time?

If
a) it is not possible to have a hash node's algo differ from a signature 
node's algo, then I'm fine with this as crc32 won't be allowed
b) the signature node regenerates a hash regardless of the hash in the 
hash node, meaning the signature will be "appropriately secure" 
regardless of the algorithm listed in the hash node, then I'm fine with 
it too,
c) it is possible to sign a crc32 hash, don't want it :)

@Simon, do you have some hints about this?

Cheers,
Quentin
