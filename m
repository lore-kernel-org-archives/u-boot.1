Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9BCC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 09:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 925A8808B6;
	Tue, 25 Mar 2025 10:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GBe4VGw6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C55380F70; Tue, 25 Mar 2025 10:48:48 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CEDB808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 10:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jv+0Ybz2q0hXLjwlOfaoSaMtTN8a8+KhDYkEHGbwvH39aUQbKGmwAa9Qw2qaxEvGpME5bQc7V2NstR1M/Lo+HhZwY5L5wuO6fjtgzDMhRdmolrLqnnf+mhODB5hcN1twKJCz+gjuKzD+/4V32S3YHu+GMK+Ta4Zhw2UvJ5vf68GowPUQpYIvFSIHDwP8oDZVEh0wldSGW+0Z16dMIwnzm05GXmVoY1NK4O4ippJD3P8sMBJhUySXzrG7m7b9wpGCihDLJjteThIrO6D4UGS0GFdUMWZmTDwYEGbIFxZcktoZ5A9PIcpnCoF0J9D0TB0BQlKD8YhBkurbg6cB6JxwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eByxw6GjFW+bAjNbzJs4GECK9S5kZ/7hKU4gs6WbU+Y=;
 b=mR3J0I1OfmTqSXV8DCUCuBjx/M8K9D0hrcbXbMLs+TnHmi+MkV2U58Ns9RdgTfSHlT41BpvQtaKwjT2Zz1PPVndqlD2ceYn+QvazoHwSuiQsc17ivrJy4Fe61/nkACf0gQqr7eEE7QE5qwkb1xNCKkn8ORQ3+zYAZyHB8EsZvO3t4gtMPavIbQmfT5IYNKDhWMQE2u9MBUNnMZog6otf45VZs8MQR7+pa6c5/qPTVqtqp8SdEx+3SqAIGm2XP4arUrgBVTvKp6TW0Vz+GhlZbqc4nKTG2j/fkNJD0AYcCqcrYefpoEqwoIHkwD98hdF7CpjopJf5WzgYZdvkcBPQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eByxw6GjFW+bAjNbzJs4GECK9S5kZ/7hKU4gs6WbU+Y=;
 b=GBe4VGw6f5SLDaGeq0tLrxoR8gcAiqPBYCht9RiaAoQT0cr+kckjXespcYQh758wnnIJNOv//iuyzjmWhPPBWowWai2roG3u91hlo2ldSPIn/64N9C/M+EsUasM7esRPYdoTGwjN9qWFZtVxCpNg7gtBYkxqEybs6Lrr879N+Ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB7124.eurprd04.prod.outlook.com (2603:10a6:208:1a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 09:48:45 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 09:48:45 +0000
Message-ID: <421afd11-7a50-415d-b43b-9db62e416dd9@cherry.de>
Date: Tue, 25 Mar 2025 10:48:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Use CONFIG_SPL_FS_LOAD_PAYLOAD_NAME in
 binman
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
References: <022449eaa99ce8b96bd1c0af9bece2241180be6d.1742389724.git.michal.simek@amd.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <022449eaa99ce8b96bd1c0af9bece2241180be6d.1742389724.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: a970c78b-ad93-4e95-39f1-08dd6b823bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVYwY3UyM1NMOFhPL3V0Qks0Q1o4WnRrU1pvZjFhaGtNdld2bENXTXBCRjFi?=
 =?utf-8?B?d1pCUHZZY3gxbUhMR0RzcGhBSlI3Y0ovRk90aU9oeG9RL0c0T1JRdnNvT3Jy?=
 =?utf-8?B?dU5iTHBqemtNVW1sMFVyeDhuNDBLa0tUVHBmRHRHalhheDRhMHVOVlFnUDI4?=
 =?utf-8?B?NXVMb1IyTi9mVjk1dXNtNVh6VjZvZGFmRkx3OHRocUFwOHU5UjlJdHhhR29i?=
 =?utf-8?B?L0hrd3pxNmk1OXFPcm1MZ0dHR1crVU1XV1hxZUJjTWF2ZFMyMW8xSWZsQXMv?=
 =?utf-8?B?eDlEaU83djgweE5jVUNtNm1YRDVWN3FsRU9wMnNoZEsxUXp0cklta3hJOHl3?=
 =?utf-8?B?Q0N5M0h4NlhGdmVJNDNTeGNKSzZ1V25PU25Ecm94U1A4eWhwSVdnN2wyejlL?=
 =?utf-8?B?OHJVaWtJaitqQ0ltSTAwUXFUUFJOV3hhV1RkbkJ5YzJEZVA5TU42R0hxRzFr?=
 =?utf-8?B?RlAxWDhiMEFIVXArazZLc2Z6Y0szQ09HQjRPM1NMOWpqSWhjZlR3QUVMTG4w?=
 =?utf-8?B?alJ5MGY5YnVIQ2lwSkxSb2ZMYkIwa3lrNkdvODdGaXRHcVNHQUc4WVRLM1ox?=
 =?utf-8?B?QXVMSkRiaTBoakJ4bCt1cGlMYnEvelF2dmhsSHBCMW9LTzVtSjdmaFloOEZR?=
 =?utf-8?B?NER2SDJZZE5ndmVEUEJkYlFXZklDTlpSNlVrSWpSS3ROQXNhSUFRVWxCb0c5?=
 =?utf-8?B?RWZxM2R5U1VJRU5aK0hHUEJwYm90TTN3YmRJVTUzd3hqdGthVkZkVXNiN2ZJ?=
 =?utf-8?B?NG1YWlc1TmlpZzM4N21qTk5MemRaYitKN2t4OW5iS2VJODdvVFRsOFBuV1Jo?=
 =?utf-8?B?TlJhcFdYai9nUllzbmdtKzhva2Y3ODZVOVdPalZselEzSSt3M3ZKN3pvUFJZ?=
 =?utf-8?B?YkVMbGlVcTV3elB5cVREcXNEOHZWOHhYK3M2UWo2ei9uUG0rWGdQOEhiQy9S?=
 =?utf-8?B?VTEwRFN3U042QUtKclhjVVN5b3JVc0sreU1oQkZFTkJNVG9ld1RsNUF0bWZQ?=
 =?utf-8?B?T1ZkMlR2b21uUFhmakMzQmJoYkF3Ny9na0VqalI1a0d6dUJ3MkJxa01nTlc3?=
 =?utf-8?B?eHNZdUtYMzI1VG9xQzYrOEdweHNwSmN6T3BFcHJIVzVwd1lwWDBybFJjVUxN?=
 =?utf-8?B?OTdtMWw4Wnk3cm8ySWdLRmZ1c2ZQUllVMlY3RUR0RDdEZGhRUGFRWEZLY2hk?=
 =?utf-8?B?RFRBVHl3a0gzV3h6UmNoNzJ5R3EzT0t2WldyS3VnRU1MOTNlWFNKZ2M2Yjln?=
 =?utf-8?B?Tm9DcVEyTkNnUlUyVG1sV1M3UXpCYUxMNWZuODUwdnlvV09PenNqeXhOTk1V?=
 =?utf-8?B?cDNyMFErQlVXUk5UWjUzcjlQYktEdlVwVnVrMUpKT2l3dEl2TGZXck1OQ1c5?=
 =?utf-8?B?RW9vT3NqWGtvNUEzSDhCK1Q1U0pXWkQxN3g5MzdoRnNsRjlKUDZCd0FGNVVT?=
 =?utf-8?B?QVZoa0lmelZQOEpnOCtnekpMdVZNQS9BM2tBNVdxUDBwOUtqREN0bURONW5n?=
 =?utf-8?B?cmJjK1N3b0IydTNnNkh3TS9rdzRqRWplYXE4WERjUHdDTnkxQ3NsQXBJSjgz?=
 =?utf-8?B?QW9TS3FoT2dHSktaS0gvcmdsa0dUWVZmUEc0R2ZTWm93eXlLU01aTXVxa1ZQ?=
 =?utf-8?B?SitaQjlaOXZFY1lTTHEwOUphODdjalZrN0RhZEExN2hna1VKaVI0aVB5Y3Az?=
 =?utf-8?B?cXdwL3plUjJSM0RUcnFoQUZ6c1VLa3YzNFRKckg1QUk4ZERXaGtPMjR5dFJH?=
 =?utf-8?B?dEYvQ01SOEs4elpGVnRvSUNjaldqcjZRT1IyVVBrbW1wOHRSQVBEYm1GMHFE?=
 =?utf-8?B?TzdqTlhPVHlSUUtuUTRiWkNyejhTRmpNaXZCbDV0Ly91Zy9yV3B6YTFna0F1?=
 =?utf-8?Q?EIPGF9hIb+JpR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmJ3R1RWUmtLUC9tU3RmQS9mSnJYZHFKZDNERWpNd0NiL21CQ0pNV3N5SE1p?=
 =?utf-8?B?dWdMRWx5ZllzVVRvS2Y2b2VjVDJ4MDNRVEF6ZUcvVVhoWU5HREY2QVRLdTZv?=
 =?utf-8?B?c2twVnhaUDU0Z1VVajNNMXg5Q2U2QURMVVJaS3NNWEQ3K1didGhJbHNhWElW?=
 =?utf-8?B?SURuN093aWFDL3ZyYzFOZTlmUEkrNlhoTjl6ZnQ2N1Y1NEk0S0ppcTBSQU9L?=
 =?utf-8?B?Z3d2QnBNWnlQekRIeHFCbjBCUlBGUTJTZ2JJOFcycG9adXl0L3RuT1JHN0k2?=
 =?utf-8?B?WFZudVlHcUZaQzBlRy9FZDVYNDJLTnNpd09xSzZhV0VQZzFmOWFrZlJGd2Vl?=
 =?utf-8?B?M2ZVUFlVTnBId3Z2QVNDY2UvbXlOR2JjZ1A0TGdnbDN0SzhZSmZXQ3U0YzZI?=
 =?utf-8?B?RDh0c0NNcWgwZkFMZ3g5NlErbnBtYm1uWnhob2U1cGNzeGJzYmhwZlpWOCtu?=
 =?utf-8?B?OGhhUkN2QWtVenF0dy8zM0hqdVh3NmF6cmpSTlBUYStEMFZhL0lHY0hrM0k2?=
 =?utf-8?B?UStMTVJXcitiajk3SXMySmZzbU5aL0F6N1NnQktlQ0V5WUI2Nkd0WDhuVW5O?=
 =?utf-8?B?dmhhaFVHcU1FMk5HSVhlOFhzV1d5R3VyeG02dGJKV0R4aEZjNlpFaGphZlNU?=
 =?utf-8?B?bUozc1I1cmtGSzBXaWJOem5NSzZlUndpZmlMTStKQld5Nk52YUg0ZW5MK2NQ?=
 =?utf-8?B?R3BjRjdjRGhqTnR2TG94TnZPYUZmaGl3NTVaWnhNa3VGSGswY1JPVktseU96?=
 =?utf-8?B?cU9hOUI4enNuaEtxTm4vdnB3bFFXY3JtMUd1TGFPQkpzeVk5NDBVOTFjRHdC?=
 =?utf-8?B?aUx6VGdQSm1wREFDczg5YWNia0U3T0lDMXZnOXI0ZDB3NmNiSGVKT29MWWtU?=
 =?utf-8?B?QzkzZnRPaUMybHNBd3hWcEtZZ3c4cUQ0TVE3NElLZ2JIalpabWVFV21CUUcv?=
 =?utf-8?B?eHM1YUR1N2hmVkZUTmN3MVVlbG1VOElEYUJ0WWtNbmMxNW96ZXpOUjRGWGpk?=
 =?utf-8?B?dkV2SzNUeTZXdWtSMzF0T3RPd3hkamZMMDIvSWQ5NVM5YjYvYWx0dFVxWkZi?=
 =?utf-8?B?Slgxb1FNaC9BK2I4cURZM0psR2dBdklNWDNBd0Z4SjYvSGtWQlczOVNYTFhG?=
 =?utf-8?B?Ym9ubFQ2QVkzUkJMbkMvSXMxeFVDdkxVektiL3dsbzNaaUVaNFE5MUpuc0I5?=
 =?utf-8?B?VTJhS29xWW9uZzkwcjBuckUyVnZ0SDNTZ2xyQmd2R2I5UE01bTROTFNrRUlX?=
 =?utf-8?B?Q0NYYW5KL1NkQlY5Q0hWU1pGMlA1R1hUcUpmQ3VhbURZbXpwZXRKcVBHMGQy?=
 =?utf-8?B?Nzh5ZjdLT1B4SVVseDIxd3ZPVE9VejVJTUVlYXE3SW80ZU1hVkZ4dEdMQXNH?=
 =?utf-8?B?d1Y5RmFDejcyZm1sWU15dHo2bkx1L2l6bnFUYnVJYWRBcFlRZTBNWjJ3bVpT?=
 =?utf-8?B?aklBWFZZNlBRMG1SdGVqRFgwMDFGYWRBNjM2OWxXejJQQTd4Z05BNzBHZTZ3?=
 =?utf-8?B?YWNDZ3ZvWG9wa3g4bzNvQmZySWw1Zkc5OHhZSUhzT2xiVkx3M0hJMlFpMWdJ?=
 =?utf-8?B?YU1GOGdvb0tYeTNYL3QrMFZFNjRzSmNzd0RzRHM5NzZmRjFuU2ZQQTc5K2tL?=
 =?utf-8?B?N3hxUUJBTTBwT3lET3B0Q2srUlpBLzF1V0NnZ0x2Rm1ERkk1b1ZuSUlHUnhy?=
 =?utf-8?B?NTZaLy9ZdzZNdGltUlptQ0VNZHRac09sYXRaVEZHN1ZOYTBQbkc4QnRRTWxm?=
 =?utf-8?B?bCtJYnBlNkJwMXFhWndGa25ZWjZFczlkRjlaSlh1ckJqMHJZZ0NhY2dacjln?=
 =?utf-8?B?S2VLVHl5ZFk5bFZvVzFuUGd4MjAxUHNCVWtWZkFsbmRISVFlZEtPdjV4RzQ4?=
 =?utf-8?B?M0IyeWhoTkJxTVhWVXUwM0Vsc2tpcWs3Y3ZFdlB5MWpUVGovR1NXbmFxZlpD?=
 =?utf-8?B?YXFmNG9qMURCRlFlb2ZIMFNrVGxXMlJqQjZwVlp1Z1NPMHFTbnpWa1JzQ1pq?=
 =?utf-8?B?U2NHQTdGTjF3bHV0TTkxbFBoNmNTeDllSDlSaFQ3aDBlNnFrbWNlcmxmcEhX?=
 =?utf-8?B?Wkd6VkdnT1R4dXFTdHFGTTVmUkxLV1dEUzhYeWxJZWJ4bEd5blpIQjBhL1VJ?=
 =?utf-8?B?NTVTV20wb3doNVhzb3JaVXNZdGx5LzlCQ25qT1B2UU5sRXJKT2RiSEZzNVdC?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a970c78b-ad93-4e95-39f1-08dd6b823bb2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 09:48:44.9358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Vb2lMb3gZke/6uggGwBfMJkjToJLxBLewjmHsxkeQyWkodHteFBf3v5SNEV0TvN/d3xPa8WR03IsEmOYaQGsNpDGxK1ubBu37TUIB5vkQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7124
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

Hi Michal,

On 3/19/25 2:08 PM, Michal Simek wrote:
> u-boot.itb name is coming via CONFIG_SPL_FS_LOAD_PAYLOAD_NAME and it's

They are unrelated as far as I can tell?

Isn't CONFIG_SPL_FS_LOAD_PAYLOAD_NAME the name of the U-Boot FIT that 
the SPL is going to load from some filesystem?

u-boot.itb in the binman nodes below is the name of the generated U-Boot 
FIT on your disk.

Your disk FS != SPL FS, no?

I can get behind wanting the same name for the file on both FS, but the 
issue I have is the additional CONFIG_SPL_FS_LOAD_PAYLOAD_NAME #ifdef 
will prevent the generation of this U-Boot FIT image if the symbol isn't 
defined anymore (which is possible if SPL has no support for FS (ext4, 
fat, squashfs, semihosting)). U-Boot likely work just fine by trying to 
load u-boot.itb from another source no? (No experience with AMD, 
typically only Aarch64 for me, where u-boot.itb is usually loaded from a 
specific offset in the storage medium, outside of any FS).

Basically, do we really need to NOT build U-Boot FIT if 
SPL_FS_LOAD_PAYLOAD_NAME is not defined?

Cheers,
Quentin
