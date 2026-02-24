Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667EEF4BB77
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 18:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF9DA83642;
	Tue, 24 Feb 2026 19:57:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KyRQJ1Ma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4028F83981; Tue, 24 Feb 2026 19:56:59 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 341D382BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 19:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5iPX5KOps6v6/T+sBbjX+dUFcXVuPvAxrcXZpCZNDE5R7Clmmms5blPtf+E2Pke/wa1MsjPZhgkbsNNmxzyw1LwTUChB2GkX+TrppKUc6lm7IegmXqjd/m9RLdHmqhGANI2PIW8X4ZRopqbqdFttF/Bs/oTP4Zxx2g38cCGOHrUXRyEsPJOM2eWtQ4UtDQ+MdG5M12hhL2F7VSMJa1wPjhBRVP6LYVXi+gl3o/gyPlbr0brR165wXu6mZ/vnssynw0wqlGZiT5Qj6Vt5zUWVpjggUtfNFPlsZAa6wCYZahFpGllh64foAOUhKn55JjtyYRNiUZW1iqlUu+6JVGYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBzKdCns/D5A6srTZsc6Q8Puy45puwxx0NNUgDb04Cw=;
 b=ut3QrX/y5Kh1r7IUZi9TaE9krzpa8Sy5gYQKN2zuuhQN2LhqgAhj7zXXSWRxcgm5c4paUV144iXpzGwigPBgAPn6N3AmKr/6Uur/JIi7UD9OrafZAnRYgR/szziqCGX8bfvhvNiHmIQxaON/lsj255JbfZkBmgMSuzqJu4lOezwrAkauKWqTajC3gNs3cIwV4Vix/Av7IeBFhEfbrO25xGAmRiQt5xnSDFzc4i1HCXr7ntrBAJblEJrqgZeOKrf9t1oWwibpTmoT8O38Z4NEIdhJbAh0X4lNwgKWiJlbQHXvEBcTou2xoc0U93CTuYRV+WH2iCoogYNdeoUH9wC+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBzKdCns/D5A6srTZsc6Q8Puy45puwxx0NNUgDb04Cw=;
 b=KyRQJ1MaPHtiNk94kfSNXs5m47tP7PqpxCTCck4kWgepPxuvY9NeN6yb30/YA9AppPZQEGun+toGvpYfQHA5b+oUchVm+IPDcuJyY4QTD+QX6imJyjtzfCdN0dv6rWVD8H8G31RCwYIp224nX7cgjmDY7wpCAGf1tvPfdotmw4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 18:56:55 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 18:56:54 +0000
Message-ID: <af448b67-8c79-4f40-b1c4-c9a7a0b67bd8@cherry.de>
Date: Tue, 24 Feb 2026 19:56:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3576: Allow pmu sram access for
 non-secure masters
To: Alexey Charkov <alchark@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260108133234.4001390-1-jonas@kwiboo.se>
 <20260108133234.4001390-2-jonas@kwiboo.se>
 <CABjd4YzY3sQiVkH8ypZKuH=Yk-PPHnYgZ2V8Xa_x9TKFVGMPAA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CABjd4YzY3sQiVkH8ypZKuH=Yk-PPHnYgZ2V8Xa_x9TKFVGMPAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::20) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM8PR04MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3fdb72-2215-46f3-0464-08de73d67a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGRtems0OWNHbEl5NytvZU1ML3FLU0VyV2I4VGcveFBOUGpUSjRIRThlMnVn?=
 =?utf-8?B?SzBKcUJxV0pXVmpaVGNmNkRJRnVwT1o2dzBCK1FLQzJNajd5bGZEU3hXdmFH?=
 =?utf-8?B?SWdlVGsrUlhvSlZTZ2FvWFRlREhFV2JDUnBVNkE3ZDROVzlYYWdzcTRyR1JK?=
 =?utf-8?B?K0ZDYi9wZTE3SEE4WUp0M3FlaVpFVnBma2xoOUttWVh2endwS3BvOTFMVE1E?=
 =?utf-8?B?SStWQ21jTDdsaWFlb3pkQVUwcUxVTDl4T2xtakMwU1FqaS9ycmNJcVZhTlM3?=
 =?utf-8?B?OFo4VkJnY1R2U3poWUNYeTJDc1V4T3FjN3FKSytDUGRsckYvVkxSdnV4cVhG?=
 =?utf-8?B?RWdvMDNLakNDVk5yMVA0YVY5Um4vbUV3V3Y4UWlhMUZ2QSs4RWxGa1AwaXRU?=
 =?utf-8?B?M0NTczJEYlcvQ2FaVUQySDBpTy8ycmtvZzNhQXlrWUNJMi9KYldka2t3eStv?=
 =?utf-8?B?d1cxdVFoT2RXNGM3aG9TWGRsRWNqUGU2UGEvTVF2YWhoYnF3N1k1K2ZJVkJV?=
 =?utf-8?B?QjA1aURmTnpLK21WOHhyajVaMlA4NXZvMStVNERuamtNbWRUeWNGYzZBNnA3?=
 =?utf-8?B?OE5tM0k5ZkxQUzhjTHkycmx4VmVGRUxYdm10RVhkd0QxK0lUWU9YQnZSVGdJ?=
 =?utf-8?B?alVGOTd5dHUvSEZuSnlpT1pHYVBNTmpHTzMxdFFxaVBKRFpDcGJ6SGdDWm40?=
 =?utf-8?B?NFNkY1VrSEFQaDVkbmVxNE1NdWdaSmJsQjZvdFRQNGsrakR0Ym45NFdGQU9Y?=
 =?utf-8?B?OEg3WVIzYjVRVzM2SU90S0d5Nm5KWlFIaS9ZMVIzN056Nzkra2RLNXE2L2M1?=
 =?utf-8?B?SElCT2ZHUmlzd21QMHJKSi9CZmw2elpLZFNrdEQ5U1IyR2EyWU9tQ0dnM0tv?=
 =?utf-8?B?cURkZWpZL0x3ZHhHMlV4cy9HbysraWVoaElJZUJieDRBcjZpaTNKbXh6Y0t1?=
 =?utf-8?B?YTdOS1pHZmhVM2FpeTJiZlJRMnVjTUwybEtpSTI4ZUFUUERjVXExMVdaSHBZ?=
 =?utf-8?B?Y2p3NFdLWmJBUzlNUUtOeDlrU2VnbUZ4Uk1lU0RLTFgyZkZZeHFib1hjNDJW?=
 =?utf-8?B?eHhYc0JlTi9nbnBOTmtuOGNjeUY0RE9uQmxFS3prSHAzVkdCNHNZancxeG1k?=
 =?utf-8?B?K1BzckhGMGpnbXJoRWhTL1dwckRTbERvSEdQa2RCTGE2V0Z5SXBoeTNWczFB?=
 =?utf-8?B?ZU40TzNGa2tTYmx1ZE5OL0dtMjExMjdoU3plVTdTS21oUFNzcTJNZlVqM2pj?=
 =?utf-8?B?ZzFlOHdMbjB3WHpCWWJmajd0QWhvcTR5NE1pN1RleTQ3V1Eyak1YWVJ1eUJQ?=
 =?utf-8?B?SDZZYWdKMzBBRzZiZ1BRTmtrM3NSYy9WcUg5Wnk2SHlwSUdnYXh6TmZ2N2s3?=
 =?utf-8?B?MkY5TUxiMGRFYU94ODlBOFRTbUhOeEk4MUJmd21ZZ05DbUxkVW1XK0FMQWU3?=
 =?utf-8?B?eDRWNnZQQVVmbTlqSDBoMGlmRTdCbk4zV1oxdUJITEdoTmlEVGxKcTdRQ2NF?=
 =?utf-8?B?aXpxQjd4Ky9jd1JrZEtsUnErMUlYS25vY3JOMGh3Qjhmci9sZ3N5ZnJvSVZQ?=
 =?utf-8?B?VTlsNnR1bjVSMTNuZXFESEpRNXVxOU1KOFZuS2Z1VTNLYlN5UGQ4OWpzaVZz?=
 =?utf-8?B?THN2K3hnN21nS2d0SlZSWTJybWhqMFJCaTdiYjdXQ3l1a3htM1o2TVB1Rk1J?=
 =?utf-8?B?QURRSG15cjg1aTZaYVF4NEQ1UEtKd3MyUExmUDVqdzZXMzl4RzJHclkvNExp?=
 =?utf-8?B?a0s0aGtZdjdoODJFNE1PMlppRU84Rks2RDFNYXI2Y2ttL1MrM2lzNGs3UG14?=
 =?utf-8?B?cWJqOGZGT29EQXZqWTRBRkhkNmZmODNQam9RQUtjSmJFTVVQbWY2bkJsR3lK?=
 =?utf-8?B?T0ZWaEsrZXVwYnNSQm84b2duQnVNQ1NyYVNnUWh2ajRWUnlhSWZVd0tZbk9u?=
 =?utf-8?B?bVhSU3ROdWhnNG93ajA3QTgraUsya05Pck1KYzRRR01JZ29PaXNZLzJOZWlQ?=
 =?utf-8?B?MUIwK2J4Q3hZclVWWmowUkVjRk9pNFRVcHphWkFJNmNNTFAzZmx5dU9yRE1O?=
 =?utf-8?Q?bLysHN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0tKbXk1WVNDTVRvaWFaUXNTakZ1ZTNzdlhNaTRoaGU4U096cVJCL0hSQi8w?=
 =?utf-8?B?dnRrRVZTZ3NEcnhFbTR3U2ZhUHVuZ0o3RGkvUnp6YnRTcGszaDROb1pZSkdC?=
 =?utf-8?B?WnVXc1FCRnNoTzdMTlhKZmZXOWpid1FqZC81b3NkVDlEcldRZnoxZFFLVDBO?=
 =?utf-8?B?anVDbnNXbDdVTlA5cHF0cUdNcXhEa2ZwZnN1aXZIRkZIUWNXaUlUdU1wUzh2?=
 =?utf-8?B?MWFrVXAxNHJpNzNkYytQYmlTYStkNGNEdVoyMys3ak1KTk9vL3crbUE4L3Br?=
 =?utf-8?B?N1gvNldCT2JMS0RpYWxqZFZ1OWUxTUtJeW9Hazd1dTFoRGU3U2RRaEtQb0Nj?=
 =?utf-8?B?d0RhSE9RckgxYWdxNVRmVHFabGE2M0VaUzNUcHRwQVA3NjY5THZKWW5MSW4v?=
 =?utf-8?B?L29JbHZPQzNvbGYzOXBSeHYzT1JMSnBXcjQyRzNlcThWZmtXWTAybmtLUlp6?=
 =?utf-8?B?anpYaHQ3MFhZaWNtb1dwOGprbFdOSkR5UUtQREp2K3NxUzBqbElBVVNaQVVN?=
 =?utf-8?B?ZGZkNzF6dnlhTnR5SFpiajZDclpRSjFRdWZnNit1dkloYUtzWUhlWmE4V1BN?=
 =?utf-8?B?SE9ES0UyQ2dRczdndlJ3SDBNWG8zb055dUNudjUwMDEwQy9wclVqckdOc1pX?=
 =?utf-8?B?S3BaMm41TlJhOHA5ZHVHbDNuRHcrRzVhTW05dXpRbEZpVG5NRzQvSVVqS2lx?=
 =?utf-8?B?MTlhV0crdGwwSlJwYnJYaHAzOGt6SUN0THFmVzk3dm9seGt2R1ZDN256NlBH?=
 =?utf-8?B?R1l2Q1NvdExGaDNaL2hPczhtWHJpK0lwMzZub3BtdDNHRGcwamdrdXhoUTZh?=
 =?utf-8?B?R2lYZnZ2TmNKRGhmc1lsK0FKNi9RaUVVWEUrYTdyTEkrV1pTZ3J1bGVHOFRQ?=
 =?utf-8?B?MzJFK0xybUk4TEpFMFdLc0Nwdy9xTm1vTWpTRENTdjk5Rm9NVlhiZ2RNcTJE?=
 =?utf-8?B?elZiZ3Q1czFKRGpSRmw0L2JIdkhncXo3eC9SWUdLb0l0WTdYTGkzZlRUbzFR?=
 =?utf-8?B?eGt1VC9WUzJ0WklnWXVTQkpoNVdnTmhSZDZVMEprZGE3SG1mRnBSQWJhQkZl?=
 =?utf-8?B?THZ6eWRQNDI5K0NZdHNsOEQ1ekJwRjc0M2dQbUkvbDV4WTNocVRUOUxiS3Y3?=
 =?utf-8?B?VDJZS3A0RFA5VWZIZXY3VDg0b2k1dDN5clBuRC9ldXVmTHlFbExUcVBiRWV1?=
 =?utf-8?B?T0FHNTMramJ6VmFPZFAvQzNQKzhsVVhEODNNOUlZdkdDZWJwY2Y5cW1YS1Z2?=
 =?utf-8?B?RExwL3hNSGtsQ2k2ZXJLWWt1UU9wUEIzbjVINzFsaEVROVBrZGpLUFhsQlNS?=
 =?utf-8?B?bVFkUXZKSG83ZkdVY0xBVmtBQjNwZHpHcUx2STVyUXpvMUxGVDV0QWxxNUtk?=
 =?utf-8?B?aTYrL2tGUGlhODlJUDVZOUdEMmN2d09jeUYvNDYrV21oNXlwLzh5a2pQZ3FR?=
 =?utf-8?B?R05TRFc3bSsxeDg2M0lIREVpQkJyemJ2cy84T2RHZzB3NXlrV0txV3JkV0RN?=
 =?utf-8?B?NkRDY3hIbVZMWjZhUEpqb090Y0ZOd2k3YnBCcVlsVHV5Rm9IZWs0VW9uM0lS?=
 =?utf-8?B?cEJQaUJHdXlCOUI5bG4xYkM0d1FnMTVNcGI0anpKQk9LV1phTDdBS2VYUTZX?=
 =?utf-8?B?SlBkK1AybzZMUW9XMjNDTGZQV0VyaWhuMmd1ZmJ5cjNJWnN0T2NjbHNndFR1?=
 =?utf-8?B?NHc3V1dNTHNpRVRJNVplUVZ2bzkzVWdFR2llakpTQmcwankxYWJ1SUcwemRY?=
 =?utf-8?B?OHVLMC9FaGN3QXZtNDJTSGdnVjlWLzFYNEcvZEFRdGpPd3pIbDBhczUvc3FG?=
 =?utf-8?B?MU53V2gxUExGNHEydEpwWW44ZnFnYlE0N2xRUzI1azlyRjJ0Q0V1SUxEc0Y1?=
 =?utf-8?B?M1BRUStlclkzWnBxdnFjc20xN1htR2tURXh2MjBYMFhFTnlobGlxWHdOWEN1?=
 =?utf-8?B?aFRwYkJySVpHRzNZS0tFNndQL1Y5aUpPR3RJL0U3WlFEai9VUVF0RlBJUkRN?=
 =?utf-8?B?T2ZJZk1SSFRmbk9XYlZQNmtBMzB6cjVYTzZzUmJob0I1MU4xcEJqTzhlUFhu?=
 =?utf-8?B?eW5SUmFjWnpZY0hlaUxuMmhSZUt5cEh6MWJQSGRKek5FWFBTSUtBREZBZ2ZH?=
 =?utf-8?B?YVdKbTIyRzlhakszVklxYTRLU0s1QUszRDNneHRkRGZ1Smp1S1dxbTA3YWg0?=
 =?utf-8?B?ZUpmb3lWTlFhN0s1TVJIR3dPdVZXMnd3VEh6bzRpSzYvNlNUUFJmYmR2a2Uy?=
 =?utf-8?B?cHpoYmp0Z3RiUEhyZ25UYkUxVWRDWUFuNmpNSE5ENFlGVWdYYWZmMWpGWUlh?=
 =?utf-8?B?emU4WFZZZWRQVldmTm1OeC81VCtVeEJ1WDJoRWV4RXJMcndpaHNGUzhXeXpi?=
 =?utf-8?Q?v0cOdVYjQ36xq6yUlm9FFhPHyWv79O1WxnQK0?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3fdb72-2215-46f3-0464-08de73d67a7b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 18:56:54.9267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G843Z3+wi6tYZU+X67ABYZjjN3LPgfvTtwID9+CXI6RzCnwGBpPSJX2eXBY/+DCFIsyGTCSzvlMnVU3VkELQ/T1jRtw9VLC7Dn7QcST8GtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939
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

Hi Alexey,

On 2/11/26 9:22 AM, Alexey Charkov wrote:
> Hi Jonas,
> 
> On Thu, Jan 8, 2026 at 5:36 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> The firewall block access to pmu sram for non-secure masters by default
>> after reset (0xffffbfff).
>>
>> Change the pmu lookup configuration to match the default lookup config
>> for ddr and system sram (0xffff3fff) to allow loading TF-A using DMA.
>>
>> Mainline TF-A will re-configure the firewall to use an even less
>> restrictive lookup (0xbffe3ff0), so this change is not expected to have
>> any real security implication.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/rk3576/rk3576.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
> 
> As mentioned earlier in the other thread, this also helps fully load
> ATF and U-boot from UFS storage without resorting to bounce buffers or
> anything like that, so thanks a lot!
> 
> Tested-by: Alexey Charkov <alchark@gmail.com> # UFS
> 
> I wonder what's the fate of this series going forward? It would be
> lovely to have it merged, but it hasn't made it to any of the
> custodian trees from what I can see.
> 

There are three maintainers for Rockchip architecture officially listed 
in MAINTAINERS. Philipp barely sends any mail to the ML anymore (max a 
handful per year the last 3-4 years according to lore.kernel.org/u-boot) 
and I'm not sure he has been involved in maintainership for years. Kever 
reviews much less often for the last half a year at the very least, as 
far as I've been told (not by him) his work responsibilities have 
drastically changed last year, so I am not sure if the situation will 
improve (soon or ever). His last mail is dated Dec. 14, 2025, date of 
his last pull request. As for Simon, I'm assuming he left these 
maintainership responsibilities to Kever since he was quite active for a 
long time. I assume it was important for his work at Google 
(Chromebooks?) but since he's not working there anymore, I don't know if 
there's still interest (or time, he's maintainer of many things already 
:) ). So in short... I think there's nobody left to merge anything at 
the moment, let alone review with their maintainer hat on.

I'm trying to review Rockchip stuff when I have time and some knowledge 
(or opinion) to hopefully have patches ready whenever there's going to 
be some maintainership activity resuming. But I also have only a handful 
of platforms (RK3399, PX30 and RK3588) so makes it difficult to test things.

Cheers,
Quentin
