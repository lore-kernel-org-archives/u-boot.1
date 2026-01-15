Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C88D4116C
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 11:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 670BD83015;
	Thu, 15 Jan 2026 12:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="eRtlRsB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC278389A; Thu, 15 Jan 2026 12:26:52 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE4180325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 12:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xleUF/HmcKTctvGWgeYc8zqIijXSbM4LDp2soa45NweZuGbNzKEErlI6JiMBM15TnDXYKf+jhBhcCd6kqy0ErvJ6IO1W7o4NlINVmP5Kw4xju76fUxnILVM8AW9OWWYTxBqE2uZnKivLvduS96P/Z4IBFNJkNDPlLgiCu7Tr5Y/Eefra4I1xolyZECQYjrtsK+c7S3WzcOJZ1M70odkd3mkPurhEf7u4yMVrLX79s1fwPmplWagU2tMzABrpfl0owK04PRZhA+ro7oJbG/LKAVtbWOR2O1cZWcicLX92sK/+TA0SBTXnQJBHsn9WsQwWFvb+P/vSrf5dITX/s02ucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ftOTVmA8xrvM8ZYwVtoYAGpwcsAtCQ1i2RU4wb9Gp4=;
 b=YHtAqou+9b3RGbQYhcU1lYJOLtdNKMzsnBrEONwFbV/VO4TH82Wff8i/tICsYmoJtHM9TxUaga6jjy50H9j+gYGO1BUwy5suTo5veISUP8/n5ni7pRyKzrKDxRp7hofBUUnVkE9KsqFfFIN/pyaB+ZJ8cU4q2IwVPJHgHOly15PTEKTfqkhD+glvfOHjKG0rAO7SaiB8bpgOkXz/1DUT9GReHPArIbi0VOx4DkI+LWITSCXzIhep/H9Uqyvj28IONclzgHXkZ1D0i00lQN/Bmrk3ZVAyP0qLu7YpDPVS8bxJb9U8ybRGXxUsRntPG4jDEaevCdpNu3nKQUHICG8QTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ftOTVmA8xrvM8ZYwVtoYAGpwcsAtCQ1i2RU4wb9Gp4=;
 b=eRtlRsB+tHwFPmpKQajTHqU28Qnxe8TvnYgAdFSrhC87xXNQssuOMY7LXfQVj7KdKTUfyqiFBiN/H/L7ymkntWJjNttuGsQhyj9yJVWhrEIxznSHmPYp7n/1NIRnbRs74xdtozOxhNyG323kKydDWCs+NmxfQaWNZlKg/fo7f+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB10541.eurprd04.prod.outlook.com (2603:10a6:800:26a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 11:26:46 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 11:26:46 +0000
Message-ID: <e286ab86-2253-400a-9717-acc87b7523df@cherry.de>
Date: Thu, 15 Jan 2026 12:26:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] rockchip: rk3588s-rock-5c: Add support for ROCK 5C
 Lite variant
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de
References: <20260107230747.3552391-1-jonas@kwiboo.se>
 <20260107230747.3552391-4-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260107230747.3552391-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB10541:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee4fb90-ae2b-49da-bedf-08de5428f7a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ym51eHZXWmF1NWFra1p6aUw1K2VpOFU2aU44eHFCcXB6YWVNNUYzL2Q0QWxW?=
 =?utf-8?B?dC9rTUFVYytPOE04aDIrZVQ5V3BXRERYT2E0c2ZaeXYvazFUT0VzY3N6VnZt?=
 =?utf-8?B?TGZ4blpGNERha3duTEx2S2FBRFUxbk1NL2pnMWFZNHc3VmpFTVFia2RPZU8v?=
 =?utf-8?B?NlNocXRseGFtRU1mdGUwT3dXZGlBQW52RSt2K1YvTTJSOTdWRklrUklNbGRv?=
 =?utf-8?B?d1lkU2xLTWxqdkpkVnhoQll2cTlkYlpNZVh6MHovZEJpQUhIaE5ua3FrMU5k?=
 =?utf-8?B?UmhhdWkzK2pRVGRRN1AzcVFtZFdDZlY3cGZTSWptdXg4OGVPeEVaRzRYOGhF?=
 =?utf-8?B?RFNpZ2VoM0Y1SmVGcmdQaEJXbkNJZWh4amFzbDVLMjFBOW5abGdFREx0VDZT?=
 =?utf-8?B?a21iN3pxaVF1ak5zbkJzU1l0U0xKWUxYYXZqK08rTEZRN2dvWU1EbkNQRnkv?=
 =?utf-8?B?MWFDSEkzeEowN0Q1K0FSMWp2TTFyODRKNmtjMmNmYXZmSVgxSXRrcEtKSE82?=
 =?utf-8?B?NEpkL0l4b0VJaTc3TGI2Uk1vRjdjaU1DNE8rUjZGaXpUYXdWaFNad0pxVzQ0?=
 =?utf-8?B?ZzdpRUpqZ0tYalpqczRsWnhTU3MzMWg3V2YxbHhuc21KUDlMWnhQME1tRDIv?=
 =?utf-8?B?b1JYQ0RDZ0pabXZ5OUZrOVVtNlBORVN6bzkvcWxjOWM4aHJTdFBNOEVpL2Jt?=
 =?utf-8?B?c0pWbGRJbnl4dkViTG1iMHJocGdEcy9MTFFCUEwwMGFOU1E4c3VEUFhkM1pH?=
 =?utf-8?B?eWxQRjYxRHdqcFNhTUgwaEg0QWlyWG56OGx4Q1B2UXRWZmw0MENYWUM1eURM?=
 =?utf-8?B?dU9QdW5tMkFrc2FuYndwYTRuRmlTUWtIYnpQeUdURHJYNmJrb2ZNbGFncm5H?=
 =?utf-8?B?Q3R2ZHpKaURvQmdleFpWVXpXdEZlWVZQOEVZV1d2TFpaS2RVQWNjb2h0Q0lN?=
 =?utf-8?B?TldjcW1ib2lRY3NWaEtUejlVK0hZTmRPaHdCbVZ1a2RMRHVGT2YxTnVPbURn?=
 =?utf-8?B?TlFKMmwvaWZNZmRtTnBlcE9rcXJZZUJWdWtQbFc2ZnVtbVJvdEN6ODN0SDFq?=
 =?utf-8?B?SFhBelRQQ3dhR0IwWk9LQ1VNb2dWdDJBbUlvZFd3WlRuS2xFZGpNZTVmNksy?=
 =?utf-8?B?dk1hYzdoTHNVemdEa1UwUERNTng1VE80UjZMT3VWbXJGbXJBWm1CbWp6MFFO?=
 =?utf-8?B?YnljemZHWHpBSXJ4dDdCZzI5T2JacFVaQktuR1U4T1R1UUt0YnNjeVpZTlVi?=
 =?utf-8?B?cHZocWVFTURpQTI1cm9zc0EySXEwNXNjVUU5YWhibXRobDQ0TkVXekovSjZs?=
 =?utf-8?B?RTBja2hZUHcyVWFzRzlheXN2azZVWnQzd1Qzcy91MWJKR3RtVk4vMlpHY0lF?=
 =?utf-8?B?NXYvSkRNcHBrVkR4NGx1U2tYUkNZSU5LWEV0VzNTWm40R0c2VzlrL213ZFE5?=
 =?utf-8?B?N0l1R08vYXhmd2k5QmhIUzlNM2c0bXliYW4zOXhmUlZxekxoR2RzaWw4am14?=
 =?utf-8?B?cFl2cXVOQ1RLRjI0djBKWGRaOHNoNE93cGlDMHpBV2Y5MjlFS1BhaUdKN05U?=
 =?utf-8?B?N3cxdFJEbG9INk9USVZ4UktFTlVNY0ZIUjFxd0trM0NXZnVZb2hkWHFlYVF4?=
 =?utf-8?B?cUlxcXNxOWp6bDQxQ2xTRFk1TE9XVFU2SnRncHRVNUhuVmNmcm4zNWtzVkdn?=
 =?utf-8?B?OXlINWJIM3oyNGoxQzA1STlzelVsc0FzRzVWaW9wZHQzMmIvcHl4VW4xQUFr?=
 =?utf-8?B?cERqMWRCSStDSnlBU2E0TVM0czRTd0FqZ3NKZ05jb3BUaytxenc1a0VLdks0?=
 =?utf-8?B?SWFKV1dFTFVoeFVjbkY1M2NZaG5iamVhWFBINXgzSUhNT1RwUVVOb2UvZU5H?=
 =?utf-8?B?Um5wcGwzb2p1OG55M2VLT0o1dGloNkJHYnM5WWJoSVZuYlVNZWZDQmkxRUdt?=
 =?utf-8?B?ODAxdFNwQTE1bUZuNTV6WWdjZWVkdnJzU3ZIcWI0V0FnUlNuK05IOEdOVFV4?=
 =?utf-8?B?NW5DeXNyY1IvL2xBQytRZ2o5NUdKRHEzcUNWNUJpRlNTUEY0citORGxqT1Fy?=
 =?utf-8?B?amJFRTRndTBCMUVQWXJCTGkwTnZTclpSUkZmWTVnRjM5bFZOaWtmNnYvNnlZ?=
 =?utf-8?Q?/KvA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0JCZDdsak9mb0FOMndTeEE3S0NvajhQQzI4S2trc2hrK3MvQTFLSU5EUUVS?=
 =?utf-8?B?T1FoZFhBcGpvNWJWVGM4a05LdTBYZWduSlBQUnJYOGtxRk92OGtkUmh1U2V1?=
 =?utf-8?B?R1lCaGhPQVpxOVpuSm5yOGhHaWlQWnJvdDJ4d2VxSjZBckt1TlVXU3NFbjZC?=
 =?utf-8?B?MUtsc3V6UzFuTENyS3prWnZ0aFBpWWlSU2RZckVnNDJ0aFdsRUUzaVNMZGVw?=
 =?utf-8?B?MUZoUUJqTU9YUXp1WFRxSDFpQkd3SVNQcktVNDV3NFZCMmxGYzQvV0VuV2xv?=
 =?utf-8?B?UVgzeExDZEl3N2dKZmxFV2VnTUpSdWdUNFBQL2pqNGZFcDdXaVA3MklyUFkz?=
 =?utf-8?B?K2tLUmRvaWZGeWpGdS9mTDk3cTlMdmtLQnNydHJ3L2srb3FqaXBmU3NGVk1X?=
 =?utf-8?B?WXpuQzhaZ1F2NjhVWm1vSTZ2RkpoUkdQQ0s5dFIxcUNhdUkwVlcvSG5xWXEz?=
 =?utf-8?B?dFRDditpNGQ0bVkzdlJnYzhYRXJYdzVDcVVQYys4SWNkRjNac0c1T21Gb0Fp?=
 =?utf-8?B?N1dxUkFvUVFNN1d3YWkrYk8xVXU5cWtHZzUvVDhKejBpMW9CVEQ5T0I5U1No?=
 =?utf-8?B?bXNWeURpaFFVU1lycFZMcERqQlhOWEx1OXhBRkU2dUhiTEJxVklPVnE1WnFG?=
 =?utf-8?B?empNNEw5OGFKTEFiMGl1N0JhMjljQ0ZaaWZIUXJFMXloeGViK1hQOVc5NWNR?=
 =?utf-8?B?NysyZHV3NFZmaGZrdERSMVBGcS9rYTFGc0kvQlBMZVN1TEZRdWtiUU1RUGpK?=
 =?utf-8?B?UCtZdmwzZ1N6ek5OZjlaL2tSSnI2Tm5WOGlxbWxPSXhZNSs5WnhZN1l0d1hM?=
 =?utf-8?B?ODlORjROMDNyTXBna1F5S3dOWTVqaVpqTm5zYUZZY04rcXY4OTBXbFB2MTRY?=
 =?utf-8?B?WCs2OGFXR3AxSFZ6VEl6Qld5ejA4S3JqdlNQcWdrTkR5MTlNQmNCc0paTzBI?=
 =?utf-8?B?Y0d6eGtWSEVPNThNRHhjQ0ZmY0h5Zmg1NCtMMWE3b1VUZHk2MkREcG5IUWlK?=
 =?utf-8?B?TUt4eDQ3MmpialR1VndEaUJZUkFZdGthaWpkZmxscjZQVStEQ0gxaU5KZUdz?=
 =?utf-8?B?N3djVTZIcHpkVVpUWmRNWEhreVh2bm9aSS9PMDlweUlSbS9uOWRFY0doOFhG?=
 =?utf-8?B?cFVpZXk1TEdFSG9rNnNVa2FySmVBNnlGM2wyci8xeFZxcWV5Zk1lR2tER0lV?=
 =?utf-8?B?c3RoTE1VRlNqN0IwNVBwc2VqY3BqUHFsd0Y1WUcrck9lbTJBenJZcXdaMVBO?=
 =?utf-8?B?RmZ0YktsVUl6TjZObk5DLzZodzJidWRVTjlNMm1maHRGTFg4QkpoQzdsWklZ?=
 =?utf-8?B?VnZSbmhzdjBKd2k5b2ltd1pIK0tTbGoxOW1Uajk0cXBmUkIvVHlkL3drTTlT?=
 =?utf-8?B?ZTNTbFhFNmVja1hyQTNWNEtmeStDcVhkOW5CK2ZkcytVOG5RNVdJUlBrdHVX?=
 =?utf-8?B?NEN2NUFCM1g2OFpISW96Ly9GVk1qcFdFNmlaZTIwL045dW5ENFdKTHJsNjRP?=
 =?utf-8?B?UXFzN2FPU2FiUWd4bldFdkRkUXl4VG4rMVhaQjBQUjdpRlVRZlE3OFlnOHp5?=
 =?utf-8?B?MUJsWHl5SFRkek8vVDM4Q25GeGZrZlN6VlQzY1pjTGZRRGZ3Wi9CckpsWSs1?=
 =?utf-8?B?aWpuanJDajRkODB0bjhUN2lxNmZ6RzFJUXRrT2dmWWZzMEljRVlyT2wxcUVs?=
 =?utf-8?B?Wmt6c0NsMm01WS9UK0xtc1Fqa3J2Z1NqQ0RMTVZOaGhyNkV0YVEzaGxsQ0VZ?=
 =?utf-8?B?UjVWV3lBV3B0eERnbnRhVVo3R1ZJTmxOREZhT0FZZ2VvMUc4MGdZVHJKNlJL?=
 =?utf-8?B?MVVhRkIwcWlCcEVqcUVleDNZZWV4VDZNdVMrdlhGSU9BQWIyNFN1a0hZcEdF?=
 =?utf-8?B?d0M3bXR4NmN1YnRBSWtBdFpQY0JTWEdHOFBuRFlsalpZMitMM3RPWW1uQW9V?=
 =?utf-8?B?SGxvcFdFeUg5aFB0NS95Q28wRWJQMTRZd2RBU2J4REZHbUcrd3Y5M0pwdmdZ?=
 =?utf-8?B?NlltSEF4R1BBZXN4cjgyS2FDd2k2dFp2VFdiQzM4UlpLcjF2MHNBQ1N6dVVi?=
 =?utf-8?B?VHBKVUhkckpqSjdLUTUzaUNvS0ZLM1hNSGF5UDVTTE1xa0F3bTlpRVdtRURT?=
 =?utf-8?B?UEd6OFBwdStDZFJscktiUjYva01QTVJNN0VsdTJKM3BYVnVPY1c4VkRJZ1hX?=
 =?utf-8?B?QkFMczdQZWdaZHpsSGZPbUQ5WnczQitLVy9KOWttUklGNE5PNjlPc2U5NkMw?=
 =?utf-8?B?YWhvNi9wd2o2MFR3aW9zZTkrTUxpR3lRVEZlV04zL3F5b0EwOGVGZFhObzFk?=
 =?utf-8?B?NTR3R254enY2N0pXR1R5SXVwWC8xeW1ycE5FL2kwUDBDQUJaSENsZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee4fb90-ae2b-49da-bedf-08de5428f7a6
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 11:26:46.4626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdXvxlN1gKlUZ/d7vXklTwnEAMAVs3VIy7A3hT6mYeOixmk0JsyNkpHqGetrx7S7Ws20D4oAEiQK+msDqFgPpHmR5f9+MrppUYHmOEwu7pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10541
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

On 1/8/26 12:07 AM, Jonas Karlman wrote:
> Add Kconfig option OF_SYSTEM_SETUP=y to support booting ROCK 5C Lite
> boards with a RK3582 SoC. CPU and GPU cores are failed based on ip-state
> and policy.
> 
> Tested on a ROCK 5C Lite v1.1:
> 
>    cpu-code: 35 82
>    ip-state: 00 80 00 (otp)
>    ip-state: c0 9e 04 (policy)
>    remove cpu-map cluster2
>    fail gpu
>    fail rkvdec1
>    fail rkvenc1
>    fail cpu cpu@600
>    fail cpu cpu@700
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v4: Update commit message to reflect updated policy
> v3: Update commit message to reflect updated policy
> v2: New patch
> ---
>   arch/arm/mach-rockchip/rk3588/Kconfig | 9 +++++----
>   configs/rock-5c-rk3588s_defconfig     | 1 +
>   doc/board/rockchip/rockchip.rst       | 2 +-
>   3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index 60c16d2f32d2..675f13ab66d7 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -286,14 +286,15 @@ config TARGET_ROCK_5_ITX_RK3588
>   	  Powered by either 12V, ATX power-supply or PoE
>   
>   config TARGET_ROCK_5C_RK3588S
> -	bool "Radxa ROCK 5C RK3588S2 board"
> +	bool "Radxa ROCK 5C/5C Lite"
>   	help
> -	  Radxa ROCK 5C is a Rockchip RK3588S2 based single board computer.
> +	  Radxa ROCK 5C/5C Lite is a Rockchip RK3588S2/RK3582 based SBC (Single
> +	  Board Computer) by Radxa.
>   
>   	  Specification:
>   
> -	  Quad A76 and Quad A55 CPU
> -	  6 TOPS NPU
> +	  Quad/Dual A76 and Quad A55 CPU

Considering the code seems to handle removal of little cores too as well 
as all big cores, is this something we should be mentioning?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
