Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5688AC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEEEE806FB;
	Fri, 17 Jan 2025 02:42:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="DqKZe/tW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87BCF80726; Fri, 17 Jan 2025 02:42:55 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::725])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9166C80312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDKkL2daoZRoeYSyMISKVKbCwJeWXT/BFkDH+RFPB26Nali0J1ZdMv1bRPgcY7WJql+tfbFW9urkcIFrTxA9X9gnUiSMk1V86A2X0skiMWBeA9SmTlRBSbza7YvC+XLlKILGBa5oTPisAnkOH8kjckLlZWJsi4xqUAk6/2rsauqceUhkr4U7QxWTdQvm8+Ip+BMUaasdMxg3TeGhdCUhQcjoaIF/FkLNm+fkR1qsSjFwfwc+dkrfL7cyFABVZYvSBb6my4L4fpcAzBSI88uyuk1UaGt5kc/13EbrnqzNPQQ4+NA8sHVmoLkDGIlbyJC9sOCb4vvjKwKsd5hS+PAiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZZy+XbuDHVlYp1JEtgCnjPhfoJr2Okc+X0pWl5hJgM=;
 b=CNJFQjdecSR9nWdXTQIPdQJeEpaEwgtXdU3KX4wvFSkS8s/Zkat7rE8Mt9G/rvTgQF3Z5yJ6hCNPvlXDF04eB477Hzs6ttN0jrdkHhOFFMbrACU/Z0v2SbGJF0kGSDVbaWViqt62sEql3BgM+uMQFLnBIAKElS0wqd/x9jvxZNg9WQG4Wfd6xd3EgUolF6/8QSLBo0eNNYV37id+8tQWonEiRXo3v+GQJ2JvqnpqWjoVMVxNfsrY451er5TeJr7/xA5Aa8m7/9nj1QovGGqOYxkF1X5J3negc9ueSIR9mnKnU2fxv8dG5UNMjCIcGqIBBTWgtnqp7pfVvjtZDTHM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZZy+XbuDHVlYp1JEtgCnjPhfoJr2Okc+X0pWl5hJgM=;
 b=DqKZe/tW+TdWWEQ7Uz6Vu7QYNYsmEmqOhVawnLnbjuHHXC64EQHZCLWsxT0Aq5rhtMkslQVaKtNzwvdiyWZjpFChMT6PnIfgbY8U0Wi388jcz1Pi5P337dQ1Mbd6yk0G8gh3CtoEyunAwkdN1PHiieLyYepsPFbo40qC0a86q2jIEkkb8on6KUSV13S7QWFHY7PnUL4WU+lrEPEUd1UEqgxVOG0oKU6aimd1LD+ITvtiS3hQfBBp03hTikdLwXf0e2wQ5eeoO3wV39GyKGWjoSVjL8jKZhyH4HlvG0mcEfPyqYpZYR7G+WYKnvA3RWYoZMHqBAdsPNBQiFkVSukMkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GV1P195MB1809.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:5c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Fri, 17 Jan
 2025 01:42:52 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 01:42:52 +0000
Message-ID: <2bd741db-b91a-43d8-90aa-5114f3e6fb7b@phytec.de>
Date: Fri, 17 Jan 2025 08:42:46 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] configs: phycore_am64x_a53_defconfig: Enable GPIO
 command
To: Daniel Schultz <d.schultz@phytec.de>, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: d-gole@ti.com, n-francis@ti.com, mkorpershoek@baylibre.com,
 upstream@lists.phytec.de
References: <20250116112932.1983801-1-d.schultz@phytec.de>
 <20250116112932.1983801-3-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250116112932.1983801-3-d.schultz@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:820:c::11) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GV1P195MB1809:EE_
X-MS-Office365-Filtering-Correlation-Id: 75934f1c-e04b-42d8-d743-08dd3698418b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0lpRDBOMFZqU05QL3U2MlBEdG5FYWdYRHovb3JMc2hDTU5xQ0tJQ05BSXZD?=
 =?utf-8?B?ZEkwTzZVaXBpTEJTZUhIWEx4dXVLZTlZOEhUNDk2dGFqZlFWOE5Bemx5SWpu?=
 =?utf-8?B?MVJVQVpwcVQ5bVd2SzJWSGQrWE42RnFXRlQ3SzdBTEM1TkpFZDQ1MDF5NUYy?=
 =?utf-8?B?UGpOZTF4cEJvV2FPbldNQzRqckVvc2s5UGZpOW9iNlh5b1FIUUVsbzZCSUhS?=
 =?utf-8?B?TDAyejc0eGFUaGFjSSt3T3V1NGtKdDJBTllZTlhEU0dORktPTmxIb3g5LzJ6?=
 =?utf-8?B?dVY3SkNzMUxCdGFBcjhVSjJZLzBDWldYSnhqVFBpV2JObTVBNG0yY3FXQnZ0?=
 =?utf-8?B?THg2MWpGTTl1bzRXYVlGbko0bExHWXBhMjQvSC9nVlhxNkY4UCs0UlZHMmJP?=
 =?utf-8?B?WWk4TUQzakNBVVVHcDIvMUMwdEZQTUNHdW5sSlVWOTJoRXRWNW9BMzNFL1JL?=
 =?utf-8?B?MTdIM2ZUR0Y5cWV1cHNvaWl6WXpVOXA4TWtvQ0VHd0x2TFA4andJM1FFWSsr?=
 =?utf-8?B?N1ZTcU1NTzlIQ2xENTFQMlMrQ0VTWkpzdHBXMFkyVkRPQ3RFNS81OXlDSEE3?=
 =?utf-8?B?SGhoR1dma1J4RER5bzBGUnN5bTc5VTQxOEUzQkNPbTdVc3Q5WTVIbEJnL28r?=
 =?utf-8?B?Y2dWMVJtcFM3VCtQV0t0YXhJOERqQmgwd1kvb2xKRDNUNUZKSUR3S3FCejJZ?=
 =?utf-8?B?SHZJdFRFVjFnWGlDQXVvZlI3ZG5yMldRSlY0ZVBDT3lYZVdSeUFjM3p3L2c1?=
 =?utf-8?B?WUF6blB6ZktIcEFlN1lHT3I4cWhHUDFlelpPZUY1S1dVT3NJVzJuRE80d2hp?=
 =?utf-8?B?VS9Kak16R0FVTVpLRE9KME44V3NnOGMvd3dWaGF4cG56Z202MExsK1A3WFht?=
 =?utf-8?B?NHpZL3BzWWh4R1VONGpDc0U1cGVQRmZRWlgxZmtPckdtdldtaGtaaloxVXZo?=
 =?utf-8?B?YVBQR2NqZHBZL0gyaUZvRGU2Wlg4YjlHdXZ0OGhJMWJoQnNuTHhSbVBVQjF3?=
 =?utf-8?B?d1ZaVlg0RU1PRURsYzRCSnk2aFVPN3A0M1lDQXJCeS9yczVRSExIbnFibUhK?=
 =?utf-8?B?QU5HcTlzRmFUd3EvalFSLyszU0Mzc1JGV2hDN3VyWHBQcFZPUWtSbEI1OFhG?=
 =?utf-8?B?MzhkVXdnblZJbkhzYnBBd1I4N2ZQdURmSVNDUk5OZUR4NnBXSkF0RFF6UStr?=
 =?utf-8?B?ZnV0eVp2aDhSTU4vbVphQVp5NUlsSjZjQ1E3UTE0WFBSbXVrTUMxTFZPcU5T?=
 =?utf-8?B?ZXhTZ0ZadGFkLzJZWndwN3RqdWZ6N1kxbjIxMG5VNHRReC8zY080Y2p1M0xJ?=
 =?utf-8?B?eGNHRzlCR2ZVUlhUcEljQ0w0bzh2VGtNRU8wcjB2TjBWYVA1T2laZnlKYURC?=
 =?utf-8?B?Q0xUU2lCbnFSUmtiSkFQc2NtY0IzZXM1eDI2Sk9FdVB3Vm1OTTVBb2h0NVZs?=
 =?utf-8?B?bjQzWEovOHN5ZGZ3UEFBdDhhQXZsWUVjbmRyMU95alZJYjl5WTRyREdrajd6?=
 =?utf-8?B?SkpZUWJXekdHNS9NclowVTJTeUZIOGI2RGF1SStSYWJyeDRXR0poTG4vUUxk?=
 =?utf-8?B?eVgwUnNLWjgwZnlPZGNabW5DaHdCNjJsZy9DaXFSTGtYeTRubllkd0JYdWF6?=
 =?utf-8?B?SFUvVUhlUC84Mi9NQ2p5Ums1dzBvcGdlbGdkUEVjclFoWnZHVFZvcEtzaHJh?=
 =?utf-8?B?K1pGWmx2VU9tcUNURGdwaGgrOHJGbzMrL3U5MzQrM2gvTlF4djZPTU91RTNj?=
 =?utf-8?B?a0RPMGoyd1dvUGVDSVJqTzd2cVc0RjR6dC9CUi9Tb2NjVEVMT09tMkZwZXZF?=
 =?utf-8?B?Mm9ndytQdlRKOVhtRHdZTG53VW1waEFkOWdLWFBMU3BGcFN4ZEdjOVVFMlZz?=
 =?utf-8?Q?NqejhqLuNVrGo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qmh3ZzVFVExXaUdoT2VEK3lRNVZhK0x4TnJ0c1NXSWZFMHhOVDJVUU1LaVEv?=
 =?utf-8?B?SUJENlBrYjBaTnMyY2E1VWM3WER1QTNVcDFwQWN1TDhvbnh1V01jeCs0YTMy?=
 =?utf-8?B?VXpOMlNsYmsrOTU0L1NwQ3Y2aVpjT1IxOW1FZGZiU0xENmRrQ1NhQjNqdzhU?=
 =?utf-8?B?dTdZWWtFelU0Y1dJbE5HanRLSEt1WS9vZWxrSSsxL1QzVWZGVS94c1JiWHlI?=
 =?utf-8?B?bkorL1VBTzB2b3Rvc0lGNFdFdDQwUjFFNWZEclJYNk1qUnNiM2ZCNmVvUjBZ?=
 =?utf-8?B?cHJWVk5RMkpVbjk1aENLWUozVjNtMHo1UDFYSncrUnRFdGVzajVwNWduMW4x?=
 =?utf-8?B?Tzd4bG9yRTdKY3BoUU1pQ21YajZqbHhIVGY4RU5yMDFmWGswZk1PdUpkSTYv?=
 =?utf-8?B?V3licGFXbFEyTC9Bd3RiZ2x0bGFHT1R0L2lzT0RXcjJkMXpaY05JUHBydnc3?=
 =?utf-8?B?L2RFcjRRQ2dYekVCNTUreVdmK0lET2o4TGJSS3pwTHQ4Yk1reUJaOHhDWXBi?=
 =?utf-8?B?ZXlMOEhEeG5uS3ROTWlTME12N3hSY2VHYXQrV1ZTclNKUDZpeFpjUWNlNmlv?=
 =?utf-8?B?NE1ibWhrWHZQSDVrZytyenN2d1VvMDZEUVZ6K3l5Z0RiUGRVNHdEM3NYamY0?=
 =?utf-8?B?M3pyYkF2dzZRUU9nTEhjbVlMSjQ4OFNPeDRBNVdiWmNiR1Z1YmpXZ0JnTHRp?=
 =?utf-8?B?am9TcXNVSWhMdksrWmQ2QkxLa2VzRklPbjJRekF3S0tNNGdONnhGT2YycjRj?=
 =?utf-8?B?L3BPTGpsTFhuR1hFZUpMeG9mNW1kUFpRTm56QTlUT0x6dk1CZGdjUUx1Y3Vw?=
 =?utf-8?B?N2U4OTJUZWtZM2hvY0t3Q0hKenFJaTduTzRMZFkxRXNoNGI0TlBjbXFTRERz?=
 =?utf-8?B?cVN5RUJoSnhxZG1kOHZVZ2p2eFR2K3c5bmNSZFYxYkZQcWJGWUREWkpYdFpl?=
 =?utf-8?B?TzJlcC8vSGh0Q1hxdFU1S2tyQyt4SmVNZm5uWmVoZ3FYZ2pEUjlnWTVqcTY5?=
 =?utf-8?B?enV6ZUE5cFROcS9ibE02VjVmWkJmRFRHcXRFSDJRWWQyK3FoZ1AzNDZhaVhL?=
 =?utf-8?B?a2F5V1JGZkVpOHJ3bXBQb2pNQ2p5WjRKOHhSR28ybUxkaXdYR2tndmZzV2dJ?=
 =?utf-8?B?cSs4RDRqbDRkT0pvcm5lSkRmTFFFS1JEY2ZNZWVZeC9BTW1RSHJsTHQ4UVZm?=
 =?utf-8?B?QzIvREI0RVlkNXRPUktTNDhiRVh5TGFnTmYwOVNpM3BZblZZVzRpSW5Zcm9z?=
 =?utf-8?B?dW1MZDB0R3hwbUZDL3ZpbUxBbGd2REhGcGVLNEVtN2FHYkVZSkVBN2lRZlVZ?=
 =?utf-8?B?K1BZVzNEamVjTnM0Z29QSmp4TzJrSFA5RCt3cmJYZW9YWURpNFU3TUI5NHdC?=
 =?utf-8?B?UXRaVUdlN2xWMFRIdTdhc1VUVWdwY3FiWGwwc1RNTDNzalVUNHEzUVV6bzBR?=
 =?utf-8?B?eEtybTNHUWkzSytIdDhtSWNBL1daK1BCSU9vM0g3ZnVkL0Exa2JPVWdmdmtl?=
 =?utf-8?B?UHo4TmVKYTc5aW1ZUDZscVBvNVpLUm83d21XUjBkYURHWUxCOGRUaUN0eDJW?=
 =?utf-8?B?cGFtNEVpcXVHTWltTUMyUkZ1azBvRXlCNWNFTUVha05DRDlJZ0JVN3RpYi9v?=
 =?utf-8?B?SmsxcnM2UjhId1dsK2xVS3ZuRTU1c24wa3hraHNlbE1DSzdoODN5amVxUlhL?=
 =?utf-8?B?UHFmOWNCcDNRRTRCdXBUdGx5MXFmSDg4WlYyTFV4QWFLUkxuS2R6dUJzMTdG?=
 =?utf-8?B?VWdIVWliK3lId0JnTW9rLzAvMGxaZ1ROODhlYVFlYnc0d1pRNFFJN2wyNmFw?=
 =?utf-8?B?b2ZMeDhBQUlpUWVjVE40L3BaWjloNGFVL3B4eS9rMzFxdTMzZVRlY2hzZExM?=
 =?utf-8?B?QXpuNGhoS2FwbnFjbWIrWWMxY0RvSTdmOGU2UXRSSVE4U0hXT3FJcjZQZE0w?=
 =?utf-8?B?bFJsaGp3Y0JZeG9vMWp3VllmQ1hpa3hiVGZiUDc0bktvdjlYYzNYT2w2K2lj?=
 =?utf-8?B?aS9uMmRaSGpSdmZNd1pXczBka3lMWStNYVNhUDZzcU5ZUEdhZlFjWmU5SHZI?=
 =?utf-8?B?TTVvSGhCZ2RrdkNMRExwSkxUNE1jcERQRGN3V05lbzN5alN1anEvVm1VZ29E?=
 =?utf-8?Q?X+jo2AAOJnPZz4FXONhfU0j3+?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 75934f1c-e04b-42d8-d743-08dd3698418b
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 01:42:52.1513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0bflMs0lx+Vc77tuNOa6CEnyFRUQA4UpuH/28o0DKcGUpW4s94GOFB+A2IVcEJhewJhLzWF7EMRkbk79tYLQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1809
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

Am 16.01.25 um 18:29 schrieb Daniel Schultz:
> Enable the GPIO command to allow access to the GPIO pins.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   configs/phycore_am64x_a53_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
> index 4b9dcceda45..4a91b72e700 100644
> --- a/configs/phycore_am64x_a53_defconfig
> +++ b/configs/phycore_am64x_a53_defconfig
> @@ -72,6 +72,7 @@ CONFIG_CMD_BOOTEFI_SELFTEST=y
>   CONFIG_CMD_ASKENV=y
>   CONFIG_CMD_NVEDIT_EFI=y
>   CONFIG_CMD_DFU=y
> +CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y

