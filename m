Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1692CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 08:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD99482C84;
	Mon, 20 Oct 2025 10:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dSqQD+oY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A3682E34; Mon, 20 Oct 2025 10:45:05 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F2F6802C1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 10:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGF+TFyBy0bLfAjh2hMqre4/VPldICzVqBRZtpSmA7ENp65z8R/04K4qsMtC19oTtdT4YSjM18ZULZtxfsjMP5EhekkFDCM66J3f4pJHdTz+1kW6Ga/EH1jLCO4jr2OY0aH2i4ZxLASN1Wktiuf6o1nbCT1ovZAJQKPhpxGvcD+wLohxAVjGzYAEwP5QDQxJ1lFC3+XYMwbkLA4VGylz+Hk7AXhdQT3rZ/vfHTKeCSxHI6UInUhtuPHi3gU8Onyj4Ni8xY3UHreO5w0RIaqT3fA7kh/l9EZ/MU0nogYcUCvl/fJTaCSBzBQUCprtNVzgpX5+TpTBwf+6aqbJHfX4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb+w3ZGDd1pcsgZ/5336s3eTF/4LYxZj6b3ojSc+DU8=;
 b=jMHfQ/O57w/cjSow8t3oCjctRYyUUofBLqaHOaCMuLs63P5SaUIV4Rz3S+6zj0DxzYzEw3VFmfiqFAn6JT41jWL5Xw9cnUUyf2PcQOm0a1iHcQqFwyKnJX796NeqlLXnXI6m2OdA1R/nvoO9iKQItTz74JsL9HohFLrv2na1WI3dTVyM3Vi08m+jCHULX7ctGcZ3DQm5rri3idIL+xZ+tMOxBwzjtHgzebDwR6O30w2WoOzVhXNAkWJWG0hvCRnlkStAcDrR5QLLoMJSJINrfd6TRoFcjFquuDL/39W0szYkY9WNbUW5n00cu8soPpBhz+oaLvaWQNaedQFOtYNRSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb+w3ZGDd1pcsgZ/5336s3eTF/4LYxZj6b3ojSc+DU8=;
 b=dSqQD+oYzUX7XmJg3KtJ5QJZLXjwl8HC4VaQtpav+WlrFkH5b8ht94BhvMYhHhF0XEpTggLggPlYXXU6KJgs9vDjiQE44WhY/mGSTzvN1EXQpNx7VodS2oPpHy6+6hN2OcGCsFruqPFSY7O9bgXfkva5N/hwbFoJ5nX/l7PIcuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB11385.eurprd04.prod.outlook.com (2603:10a6:10:5d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 08:45:01 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 08:45:01 +0000
Message-ID: <c21de88c-034e-4746-bef0-e393ad930510@cherry.de>
Date: Mon, 20 Oct 2025 10:44:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3528-radxa-e20c: Drop eMMC HS200 prop from
 board u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251019111357.723242-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251019111357.723242-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB11385:EE_
X-MS-Office365-Filtering-Correlation-Id: 124ede6b-1bdf-464b-2247-08de0fb4f4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nks1aTkwMVUyL0YxOUlnLzJFb25IODhHNXdvMU9sRjE1dk5VSkw1bUlUNXU4?=
 =?utf-8?B?Qlp5K0FiclM2V295L1gxUG5Ebi9xbXFMWE8xSmJicDZQSjQvWnFRWFcrYVMy?=
 =?utf-8?B?d042NmhJcnZ1SzN4YXViL2EvWVJqWlZZb0plcUI0Y2xyWVNXMldOUzlSVTFn?=
 =?utf-8?B?RzI2VVpUTEUvYkJOKzhkTTI4YWt3ZGM3Uk44dEx3L3hCcGlLcGxKTFRsMTRU?=
 =?utf-8?B?d1pDNi9XMjJuMHkwOEozamRqWmxnUEg2b3VnSEJCYkEyaFI4UTk5Z1ByS2Nt?=
 =?utf-8?B?TkJvakRWSmdZMDZlSWN4QUR1K1M0d09TVzhFcFlhZjc4MUNQWnk4SnoyMWQ2?=
 =?utf-8?B?RmJUanE5S3dka0RqZk1zdFRXWEpYUkw3L0FBMi91b3FYV3JhNUpRaW1XckFo?=
 =?utf-8?B?ZjBuVzZOZUJIcTlaRGpldFNvOVdlNjY5TnFUMjhaVkE4WnpldEJJR3orMVVN?=
 =?utf-8?B?NHdJbXhBMk1OQkg2N2RPaHdBbWNpSmptTjRsZ2dUL2o4cGhVOWsrNUZjTzdK?=
 =?utf-8?B?dzVNYzNrYUpEYnpqeEJkQURJbFVBdFJ2TzFqS2YxRC94OEZPSnVJZXRnaWZj?=
 =?utf-8?B?L0lwMkNlVlkxZVBNaTUvWkhMMDdINkxhcEJ5anY0Zm9VTGVEYzFhdXJ1ZnpR?=
 =?utf-8?B?QXl1bU1lcU04b0lDNnFSQWNEeDcwaHRPckkxRkN5SVBHdW16d1FmOTB2K2ZX?=
 =?utf-8?B?U2U1aEZwZmF4akliaERhdTgvN3pqNGhxRWtKaW5OV3pPaElGSklxSk5KSG54?=
 =?utf-8?B?eDVJVUxHTWc5dVRWT0duUVM2eExFOTZEallVTUltRDE0S2ZHY1JaaUhEOSti?=
 =?utf-8?B?cjdzbGZOUDFkR3NqNGpIZXZVbUN0dk5ZQW9HYkdVOFZUbUh1Q1NNTXJvT290?=
 =?utf-8?B?Qkhsb0lSTUU3RXdod252REJDUWprM25ZSjZRZ05Fempld1oxUUwwL3dKU1E2?=
 =?utf-8?B?VDMxZEE4bkdFSVg4dWx0Zm1ZUVpYMUhJZG8wRUJYZTVzYzB6c1doY3R4SlU2?=
 =?utf-8?B?SFlkR1dRVjNqRlV6aVdzMHZRZFdqakxwenE0emZHSjM0U1didUxEbmVtTUNM?=
 =?utf-8?B?d0kwd0phbFNidkFoVkJKN1paK3l0eEpva0pLRUQyL01OMUhpcTdHNFE3YlNJ?=
 =?utf-8?B?VHBlelcwNjhLLzJQbEM1N2xET0toZEx6UGs0T1paTndZL2JLMC9aMXd6eEQy?=
 =?utf-8?B?SVM3S1piK08rL0RCZlc0cjdTL2lpaHNac3pScGxMejRaSmhjam9yWnJMSEZ6?=
 =?utf-8?B?cVZPbTlTaThVcTladDgydDU2S1pPTlN4SUt2Wko5ZVpsZ0FXN01aN09ZTFRT?=
 =?utf-8?B?N052dDBTMGRRUXFZSFpaWFgzQ3FqalZMM1Yzb0F1c2JlWFZSVjU1VEZlNGs2?=
 =?utf-8?B?YitydjQyMThPSCs1dXVKVzhUNE1lb3lGajhnalpiSVlRTTN4SVpna1c1Q21R?=
 =?utf-8?B?UkcvbDhIZFJVd2YvaUZYNmxuMHhjN0h0V0VZNlRTYXl3bHdiU05EYzgzYzIv?=
 =?utf-8?B?dWdzTUk5UThKQi9xK3hDQUpjdHJ5UDlzNXhpbzhkcU1oNlNOb1c5eDBSTWth?=
 =?utf-8?B?ZTAvbGk3U091bmlEbFU4RGVsUnlPUG45MVBQM1ZwZnBrLzhmcGw2ZXhCdkRT?=
 =?utf-8?B?d1FjMW5jN3ZaUHQ5US9XTEdteXBpQkNydzM4MnpORmNuMmFjcE90aVZ5MTFh?=
 =?utf-8?B?UUZ3WDhVQnFxY04zMm5nV3IzckRqRnR2Ums2bVc5WGJKcW9Jc01FcitnWTRO?=
 =?utf-8?B?a3ZDNldiQm8zWkltc2FuZWtUc2s2ZGhBUCs0MHR0M293Qk9jalIxR1hpWlFE?=
 =?utf-8?B?NXp2VGlHeWw0K1VpWDVkVkthcVJPZ0pXeXNTY2FaM00zbytjQXhhajh1a2Q0?=
 =?utf-8?B?MjJFVU1Gbzg2dldKYThvMFc3VWhwZFRyTEZEbk54OStTajJHU04rc2h6eHB2?=
 =?utf-8?Q?ic2BaqntEk/w0ucdFwAed2iarNyd/3Bt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGtEbmsyWjZTR3V3RE5la1FlOVNnWWtIUlJDZU04SENsSGhBeUs5eGhNM1ZF?=
 =?utf-8?B?TnFFbXozY1VsMVFwUXkxd1JpODhFUW91ZU1wR2xvTER1blNRSnhyTXZnTjkr?=
 =?utf-8?B?bFpFQ25URG0yL3dzUHNwZ1l0L3RVOXI3enZxSlRFS3hhMm44V3JZbU9lM0JY?=
 =?utf-8?B?VVZvaE5KVDFubnlZaVZBTkhXQk0xU3lxNXcxVC9OUUN2MVhlNUxoZkNlTlVK?=
 =?utf-8?B?TUNzWmN5cDBEbDkzL1RIWGVrUjRUYVhZRmFZQkF1K0JuSU1JZ3o1d0ovSHJ3?=
 =?utf-8?B?eVYvZ1VRWloySU9aTFNMNmpLMHM5ZFUrSFlMTHVMN2ZkUlVXSzNMZDFxcXV5?=
 =?utf-8?B?NzRKSUI4MGVlZTEwWGRaeGVKYkd4cFFuSzlOSHdUNnhnc0ZjL1dnd1lSYkha?=
 =?utf-8?B?S0Z1aUVER2gxL1VodGM0NWIvUUFxaUhJQzdQNnptdE9maEJUWVVKVFNTeFZ4?=
 =?utf-8?B?bFBSamJaT2lPUVgxOU5ENmswbk5VUFdnNEpFcFR1aXhseDJUeEd4ZHBydUZu?=
 =?utf-8?B?a0V3aHVaMno5cTlOeTd4VWNmMldpUjRVS0EzdE5CVmRXalhub0NTb1RnYXlF?=
 =?utf-8?B?NFc4TWx2b1NwZUdiTS95RWFyZmkyQkdlbUkrcWFvQVRSbWtaRkVvTHRCZysy?=
 =?utf-8?B?MzVSeFp2dEY2d2ZEUUxZTXNIeFpvWlRPdFZIZ3RkNm5yR0M4QytMSXI5Smw2?=
 =?utf-8?B?cVJEU1YvRkRnMDlWOHZOd1lKYlJXTXh4YTRPbzkwN0FpK1N2b1ZQdHJOdDZB?=
 =?utf-8?B?Q1U2Ry9xaHpCQTJFWUlVOEpOb2t5UXdmTEJUR2NjYnVoMXdXa0VabndOQnI2?=
 =?utf-8?B?MUlVOFhBVmRnbnRBZzdhWmo4aGNmSi9sa0NuOGxnWm9wWXJNUWwxVDZueTJi?=
 =?utf-8?B?c0kzYjE5NWRqeUg0eXRwYjFNcEtCRitEaVpzYXVjRVhFZ2VOMWV3N0pJd1p0?=
 =?utf-8?B?RnFkUTIva3ZpbDZZR2lMbW85VWY3aG5lYitwUXYrT2xlSnhuR0tWVnV3Wk9T?=
 =?utf-8?B?VnVPeUJ2OXFOL1BPZUlsRUUxa1h4WkFnTHZmMHdSQ3R6Rko1RGw5amxWWkRt?=
 =?utf-8?B?WVBnL0RPUmhkdGM5WTBvbjlZNE5zd3VzUGNtY201SDk0c01uUkljQnBndWxl?=
 =?utf-8?B?QWdoYjVScFdOVlRkbUxiNmwydU42SzI0ZEl6V3d5V0h4VmgzRmF2QXduRkFy?=
 =?utf-8?B?akUxdHlXYUZlemR3VkU0cGFZM0JyY1FPN1lTaGFXemllb2xNWXlDSXBTeHNL?=
 =?utf-8?B?L2pDOUE4OTlzb2xEc0szTFl0bFFvbm4zSi9BWTBMbVBFNE5WRmFFd0p3OGtk?=
 =?utf-8?B?QnM0c2tDUjRNRVJ6Q3JWUHowYkJzM0pWUDZIS3gvdSs3eHVjWndTWkNIQ2pZ?=
 =?utf-8?B?QzJaYVBzOVJZNnE0SXNEbm0wTTVFM01tNUZrUHVQRW81UUJ5LzhUZ1diOVZq?=
 =?utf-8?B?YmwrMnpWVWw4WWwrdEFTRk95SzVEYVhNZVA0dkk4R2V4ZmwzTEJXdWZDZy9h?=
 =?utf-8?B?S3Fmd1NIYXcvRVE5RFNrL3J1WlBWeUlwNTBqTVN5M09qdW40c3pGc0xLK3pO?=
 =?utf-8?B?TUNuaEV1YlErbWUzSUxpbnM1MGhOcTlmeWNJNy9vWk5EWnl2eUt4dHh5bjZK?=
 =?utf-8?B?TnRTd0MySU1IdFc0TTZnNEtUUmEyQkFwSnJyQ05qV2R6ejRYRytzb2dqZnJa?=
 =?utf-8?B?Ty8wWDk5QzlJa2p2SVJib2Z5RERoRDBpaThLRkdjcytubnpkZkRSUU84Zyt5?=
 =?utf-8?B?TUI0eEljZ3cyNkcweWoxSVZ0RkJHeGJVY3FRN2tpTVZIVjFqNzJpeldOWGxL?=
 =?utf-8?B?enF1WVo0aEMzdzVWNXBMZVdLZDh4eWpzdzJMSVZRM3V5WVpPRkZOSDFhdElj?=
 =?utf-8?B?TmNUVWVNbTVPRzFOa2JFWmRON2pDdnQ5ckZkTjBoMEkyNXYxNkJaQWJCOUVU?=
 =?utf-8?B?TkJLbjdoRmtxYml0dm4ySzFVQitTU1JCSG1haHhwRUI4NzdIUndHRWhQM3d3?=
 =?utf-8?B?UVcrd29pSitIN0N4dzVMUWFqUU1UYzRXRkdqaEFpRGdTck1pdDZxeVNzQWFl?=
 =?utf-8?B?c2dBa3N2UVpPbFppUklsc3kybmFyaVpybkY0OW0wb211OE91M3k0ZU4vQVRP?=
 =?utf-8?B?c2JuQVlIRWNSWEk3ODRjVjhzYlhyUFlpYXhObkpBaDJaRm15M2JrZFR6QU02?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 124ede6b-1bdf-464b-2247-08de0fb4f4d5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 08:45:01.1668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqjfyVsK2TrjZ5FtBHvQlN6pAO7OOcUJK04eEkYmxzf8tb8U9LNxDU2wenN/zAYnIeGBgx/PU0qMVs5faIul7o1wmf+2uYbX+B1px+leijg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11385
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

On 10/19/25 1:13 PM, Jonas Karlman wrote:
> The commit f8cb3fde935e ("arm: dts: rockchip: Fix eMMC write on RK3528")
> added a missing mmc-hs200-1_8v prop to boart u-boot.dtsi.
> 
> Remove this boart u-boot.dtsi mmc-hs200-1_8v prop now that the board dt
> from dts/upstream after the v6.17-dts sync includes this prop.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
