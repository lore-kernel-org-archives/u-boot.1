Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1B0CF649D
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 10:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3283088DE8;
	Mon, 30 Sep 2024 12:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="Y93cAlQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 448B788DDF; Mon, 30 Sep 2024 12:20:42 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 187D488DE8
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 12:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NW+jp+vxgUKiHrjjR9KdqK7fDmXSqIIfr0UuJ+kwKNx7mXh0BvaxPdndaZMcleRWseh/RpxP7eNcFEFFX/8TMEND7Esj+XZ/vJHz63I6AeHWBQ1pI0Gxa/gUACEkEH+7LWIdSruXCvny9GpUZ8cidP5vNCCEAyRsc914aMGXNSKN6yDf/5ZaRK2T8YaN1sv5o0bCwO9tJBYFVYDICKWr5Opz8oy3bBC//LUrEr4/RzpfgM6m96Kc1LwIdZaVNVLMxbS5QHtrhc6xWrjAQXef37Hb6v986+Qlp6ZW3MkA1RkWJrWUIkj6j9yrCe6AgcpJidBZLfS3zkIKjU1co0Nrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DUzYzLs09KvNM0cHxS+OrSFFXj6N5aXLOJXzc1rLGg=;
 b=gw3JRcaJYJJ8fEXzT9ZExyj0TNpVuYMcnQFKKmpO9sk3QKUuny83wqSbJwKMIIg1h/5l9zyLILcvynBWceTSx3v2uE5u7z8ftEK6HdqnhgkwflypsTN8ultrBEv2shQAcmlh9jHyKxe2FGmLfjUuMIwUL/yWALadmM1qpPZe/YvKfZT4NQaQRzUSciox1YCfOwfAB41Cxvv7MWrLYktNabdEUEY6xcOLVwd/6i1xyJ7LU+1svlFSrymxry/1yXMs+/u9VYi197ccnyB1+Ik0iAqAwZzxo0h4quxdcoh6jo4HBdeGN0Nc8pkAXQyjyrIG/6MjL6QUk2CKgFrzknZeXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DUzYzLs09KvNM0cHxS+OrSFFXj6N5aXLOJXzc1rLGg=;
 b=Y93cAlQa3YDjq9s/AC+JY1AEn/Yu4AmHzOirUsgte80Xm8MnSTIzMCA8kkdBOeaWKlna5Lre9TjsAUsK0RTkn+yCXHgpOXlj0tbaoEZVieAEvIbqy69pKTRjNk6DAJh9gFSR4D9paSFnvPTjqkMKG3/rcn1VsfbD3fK2f9C5GWtakdXiVFZMmfGSH3YqzmOIyLyHXOyWyF2VbMqhm1oQwH14tIDIVPCLtfx84zJtWDJAuvxeE/ZKWglTv+gFW/i0MZGKEkpDDMVPkL1+uG0thgK+b6nA4n8URB6bB7Mgk/teCpfXX3RfppDCzPrFRxfld2DKdnPl1VuBN6Jrv3KMsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9002.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:445::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 10:20:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 10:20:38 +0000
Message-ID: <a54b501a-9a98-426c-a5ca-faf547411a30@siemens.com>
Date: Mon, 30 Sep 2024 12:20:36 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] Extend usage for OF_OVERLAY_LIST beyond SPL
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Marek Vasut <marex@denx.de>,
 Frank Wunderlich <frank-w@public-files.de>, Jonas Karlman <jonas@kwiboo.se>,
 Nishanth Menon <nm@ti.com>,
 "Li, Hua Qian (DI FA CTR IPC CN PRC4)" <huaqian.li@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed3ae48-fa02-4637-e2b7-08dce139878d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk1GQ3ZGVkgybUtmQ0w2dVlnaWJYdkxSRndPeW9UZHFMaDNTWHpLZllScE1B?=
 =?utf-8?B?NkFqOGlRT2piM2Y5V1YxUmhaUEhobWQyL2Z3dk9CRGJWWThlb0hDOE40UTR2?=
 =?utf-8?B?YjA0SUxsamR3c1pKdHRnVWk0T2FhQ1g4bGNhK0MxaGorbDhCVm9Mb05Rc2xN?=
 =?utf-8?B?aFVDUERKMGN1eDErbERkUnBmTExkbm9yZmZsL3Q4SDFtci93WklBSmYxTFN3?=
 =?utf-8?B?M3U2akFpNXNWdkF5dzYwYWlUVVJXNmhqWVlCNVhHWlE4S2xHRTFQZm5qZzBU?=
 =?utf-8?B?TjdoSDRsZFhvb2NVRHpuM1FONW9TM1NnbnEzYnRXTGtsc1ZNSnpYK2lxZUxj?=
 =?utf-8?B?Q2dFT1pVYldXMURiT0x5SW1aZlVWM1pQT1VpQVI5cnJnYnJqRzdWRHBDcHIv?=
 =?utf-8?B?L29NaTI4UE1xNy8yRjFTNFFnOVRPcUI0Zkp3RHZKc1RQQ0VCdjF2TDBCeTB6?=
 =?utf-8?B?VFRGM0RidVVUcTVOTlZ5VDlDRVdjNzFCejFQSXI5cTZvZGhrNHVWUTlHK3Nt?=
 =?utf-8?B?KytkelM3Zkk3TnZBbXJjdGxrV2gxd25CV25XbTZSaVVTbGY3dzh2bSt2ZVIv?=
 =?utf-8?B?ckpYZndBYkhNMG51VXkyd2RJdXR0Z2hpYzh5WCtxQzFlb1FNRmoyYm9HQ1l3?=
 =?utf-8?B?Y0VhaE92Z3FLc0xRQnpFNkRSa21iSkNLZ2JhVUlWbC9MWlhpNmhPNGZTNUQv?=
 =?utf-8?B?cUlZR0pwYjkyb0daYVM1N0xqTWVxTWIxWkNxVjJ1NWFFQUk3Ymp6QVZ3eWxI?=
 =?utf-8?B?aHBiUFFVTm8zK2V5R3Mvd3F1Y2FJZWZXc0VocUozL3RidWRFUGE3U1hiZW56?=
 =?utf-8?B?c3lINnJ5c3NrUGRMek5hK3pWQmZXTHhrV1orcHJrdDZIM0hXZ1Q0SytmbEJT?=
 =?utf-8?B?elAxdkpNbzVIOFpjUVR4a2JDUTR1RGRCYTJ6L1FiNi9nQUJQZ09tYkZ4bmVM?=
 =?utf-8?B?WTF1WXhpTUxOcWxlY1hpd25iRk5YSFVnOUx5aXpJTGJxcWRQcllQTHFkTWRT?=
 =?utf-8?B?clFUZUovQ1FFYmVMNzVSVlpNQ3EzcHVyOFZzdTM5M1hNQVhjTWRsSHExaHNt?=
 =?utf-8?B?ZjZUSEw1UWlxZFhsVUtIbWtVNVVnM1d3SjhzdDU3aFVhdjRWRzFSUXhKcC8w?=
 =?utf-8?B?R0x0UHM0VE90SytzNld5OVd5QTdOSkVndzNKNnJuK3pxYnJRR2ZKWkxVUmh1?=
 =?utf-8?B?eTJyUEJxYmxIK0luRHNsTzhZV1lHM0dQd20wK0x2dGxXWHdISEljck9nZ0Zx?=
 =?utf-8?B?eFNiSm1lMThiU1UyTGJHRjNmVXNsSlRDK0w1NFZkTUwrZG4vUWdPOWZ2ZVpw?=
 =?utf-8?B?WThWZGw5MmZxS1Y5bDJZRVVzejUza0tlNWxPWGhLS3A2MHQ2N2tycm50Rndy?=
 =?utf-8?B?OWxvZ0V1YmRTZWM2THhTQkdIYm5USS9hekwvNnYrbE4vOUQ2bUQ2byt6SmVM?=
 =?utf-8?B?ZGs0bzlIeHgvTGhRb3FBZm15Y3IvenRRbmx2ZTdYNjlEa1N2aEgxeHhoTktB?=
 =?utf-8?B?RlByY2EvQ0w3ZDJPWERYOWh1MjJXb3NlV2cra0FBQTYzYUNxazVBZW52dUN6?=
 =?utf-8?B?cjY2UERoeHA5RnRYaHlJWDBzOUpia3U3LytHdG5GT292OW54Nm5kL2tpeGM0?=
 =?utf-8?B?TnR1anBXdTFKMVQ2eEJ0RzhIMUFLL3o3ckdOODJncTdWeWJrMzRPYUlJQWRQ?=
 =?utf-8?B?V3ZYS0orZGh3WDVjWnB6d1crRzVrb1RDUDJlZkVNNmdNMGQyb2JCZkR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkxWb2prYlZqTEwwR0MyOGlIbDV2anZwaVNPOW9vN2N2bm1GYWxyOGpwaHZS?=
 =?utf-8?B?L3Z2eThKRE9tRUpXWHQ2a3NBd2hCWjhVMHYxdUM0Nnd2Umx6dGVzbVpFNUtH?=
 =?utf-8?B?cXdzVzlNN3g5dmZ3N25vS2U3YW8wVElkM2IvRzNCNXNkUSs1QWlaaHRwRzRW?=
 =?utf-8?B?bVo0Ukhyb2kyVG9DYVBKcWV3QnVySVpWb29lR0RkMzVJQ0M0MlNOVE43Uy83?=
 =?utf-8?B?R1hqMlVDNElpam9JWTFmaGNCMVF5clZrZkpQT3pwZGc1Z0VpQnZTbW51cG1J?=
 =?utf-8?B?cms0K3FVRklCWjdQZUlka2tYdDI0MHk5aE00Qm9DMmVIYndsWTNUWHY0WDdF?=
 =?utf-8?B?L3NUZ1Nyc290T002a25QeldwRVNrc2YydHF1b0ZuRlV2Z2ZvZm1QaE9yT0RE?=
 =?utf-8?B?SFkzQk9nMWFRY1IxYXJBMk5udlRrZVg1SXo2K2FTdkttRDIxNkw3RjhNMlZh?=
 =?utf-8?B?b0t1RTJrVVp1SUNxS2NNNFJmNkgzZHFPUzZPdll2SmRaRkx6NHRNSG92Y1Qy?=
 =?utf-8?B?Z1BuUU5hSFVjMENPb2dlamdTMEtRMS9nbjVhSW94TE5lbFQyK1cxcHJVSlJr?=
 =?utf-8?B?NU1RYmlubG5hcy8zOEltYzIvaC9zZEt1emdZb0hwZzlBVU5QZVlzYXZLeHUv?=
 =?utf-8?B?em5zZnRUNEpNYjgwd1g5MHJ6V3NqRS8vMmNFMEl1cVA5SWQ1WkgvQk4xNWl5?=
 =?utf-8?B?ZHN0Rm9QeDU3YkgzRm5EdkptSmVlSDJKZ0dFUGpYQU5FaHhRMGhudVhldG03?=
 =?utf-8?B?b0FVWXdLQ1RaSkFzeG56d0RDNDBIU2VnQWM0ZkVIdzFqSHJJWE50a3ZORnZv?=
 =?utf-8?B?K0xtQkphZEt1bFNRbGhPamptMkh6ZXJ2RWd3bGs0Y1J0NUdUc3QwTTExRWpX?=
 =?utf-8?B?Mk92SVdtOXg1K1c5NHBXcFl0Q1RaU0JZWUIvb2xOOU1YRWpQYzVMa1dsLytp?=
 =?utf-8?B?djVhSUFIanVVaURvNDUzeFliUDZQNG9qV0gvZzVYRkkyWk1pd0pEMkpaN2Y3?=
 =?utf-8?B?RnN5NVNiS3hyV2R3KzYrYnhidHdmcnk3dTAwZWd1RDFTMUhpeUpKRG5uczBM?=
 =?utf-8?B?VmVLWUt5blg4RWxjR1Arck9iSkJGTlZhSXZUTWoxM0U4T3JwbjAxL3VXTlVp?=
 =?utf-8?B?dHEwdEhqTG05MHYvUnpTSnlycTdYTWxta0tKV1p4WTFNSWs3WmpCM1pmQ1Uw?=
 =?utf-8?B?NlB2eUJJdmEyTFY5WjcvYzg2cU5OY0FpS2wzdUxlZktESE90dHdSanJWdUZV?=
 =?utf-8?B?Z1VEQlNBUklRcjVEeXVkUnpLYzZJc3IvYkVUREJORnQ3K3pLd3VpQ0s2WVV6?=
 =?utf-8?B?QU5lSWE0M1RBTUx1UG1jVGVNb2ZjNmxVSXN5QVBOdmpnRkRTREZaNGtzNjhB?=
 =?utf-8?B?cVlIakNOVERSV0M5TVd5bUl4Umkrai9Xcm9DS2JLYmVUbVJTNHZmQUVXOWZ5?=
 =?utf-8?B?b3dQdEdyeGM0ejNOQzZENzJTUlZQd0hWUXljRVRMckhzNTYwNy9jTkM2ZDRM?=
 =?utf-8?B?WDFUTG44Zk40Y093RmVQb0lxRHhzUzFwY3E5QUYyQ0t0djgwTndzc0xDR2lu?=
 =?utf-8?B?dUJQWWVVdmJaVG4wMTlZY3pVSlcvYVlrSktRSnZxS3MzWmV2SThOYllId0VI?=
 =?utf-8?B?c1RjT0Z3S3E5UTZWeFFrRU93MEpVRllzbmszZ2ttOVRqZjRXckliKzMrTjZq?=
 =?utf-8?B?S2V5U21oK281NUVjakhxQXJ1bFZaZGJuOG5NRlRQS0lIY01yZHd3WnBCZ1JW?=
 =?utf-8?B?SFBMcXR3eTZiL1kxRWRMQXUwbjJoc3Z6MTY1Rk1GbUsvb05EUythYm5FVEph?=
 =?utf-8?B?YXQyU3ArbGlFYitySFUzMGc4YkFlcnQ3TmZvS3BpVExKWWZUVHBaYVV2YUpx?=
 =?utf-8?B?YWV3bVlkNVVWbGRyc1d3Z2lZeHFuTU5NY0ZON1dOb2VNT1RVOW0zQ2NxN3FO?=
 =?utf-8?B?dDFIMm9OaDB5V01DZHd3U1Y5VzZaTFdVbTdWY0d5TVlqdlkybHJrcTFLZWFq?=
 =?utf-8?B?Z1ZGQmRKbHorZUpGRm1YbUs5R2JHNHp6Z2pTMENnT0JaYkZNNXFPeEpsNk0v?=
 =?utf-8?B?dDMyaUJXT1FSVnNQWEx3SkN2bm91SGcranBiZnVCYmZXcnVoZjV1bmxySHhZ?=
 =?utf-8?Q?jgzMT2reHc56n2X0t9KvS5pLR?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed3ae48-fa02-4637-e2b7-08dce139878d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 10:20:38.4205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu0sxU+fB6hZ+dPHyUi2no7q5ft+qWoG/raGyjSR/ZUvQH8ibG1sa6ihYbhJRnjFj+bhQkXRGJ9bIz8EGToO2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9002
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Allow to use OF_OVERLAY_LIST also for the case that the overlays just
need be built, e.g. when they will be picked up by binman as artifacts
of the final U-Boot image. The IOT2050 boards have such a need when
switching to OF_UPSTREAM.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

While waiting for the merge of v6.12-rc1-dts and while seeing related 
but different attempts to address the overlay topic. See the patch
in use here:

https://github.com/siemens/u-boot/commits/jan/iot2050

 dts/Kconfig          | 4 ++--
 scripts/Makefile.dts | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index 569d4be338e..7ea4fd5a79b 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -226,11 +226,11 @@ config OF_LIST
 
 config OF_OVERLAY_LIST
 	string "List of device tree overlays to include for DT control"
-	depends on SPL_LOAD_FIT_APPLY_OVERLAY
 	help
 	  This option specifies a list of device tree overlays to use for DT
 	  control. This option can then be used by a FIT generator to include
-	  the overlays in the FIT image.
+	  the overlays in the FIT image or by binman when assembling an image
+	  that uses overlays during DT fixup.
 
 choice
 	prompt "OF LIST compression"
diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 790f3c508f1..dc181240a21 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
+dtb-y += $(patsubst %,%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
 
 ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
 ifeq ($(CONFIG_ARM64),y)
-- 
2.43.0
