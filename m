Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9B8C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08DE4839DF;
	Thu, 22 Jan 2026 00:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="whGGyc4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C0E883B7E; Thu, 22 Jan 2026 00:51:46 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B6A183B63
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZVuuJsG9b3Mg1X4UXyBDlDWTvokBlDHLxajH5Wl3yU/KlO78g5eKkD4VJpvwzzHL9o7N3S2hxx2jsohy8y0uQegjTJWlNegbuXSZuR+D8vonHtzljJYY7hG+GT0Xv6rGJjD3zrlol32zmagAn0x/rcAvgxOzz69YfaEhlhLw5zSvY+0jc/HgDQJTqSdPy3wFgJq6PGzmCUnrHGkSsmglX7KI2fkN9aqKQ0yLrDl2gwUFs04gfQgVgSRLG8zVZhpKWuWS+8GvA6w4qKV1wb/BNv7bDiLkORQaXd3qJs7TdmpHYUQz0UPEoIsK/yzrF0NMXJtaYkGOOlxLlXVkKPZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrwShjI+sD9dmN1xZWwed83qZv4IGMFGHYqq9Ks7RC8=;
 b=s1udNavt8WZ36IIUi3r9pTRJK9C99GnxkH0nxurAPUzLc8vdGyl69BEcrjFoL/YadQZmUuB1LKp4tGDb7ocgbkyEmhqftIbk/kAB6rJnNKaPiupa/yWkFpdTIQNK/ijYpzmYjPesH3v5jEh1FpMX1UFeWEKto8rwmG+CfJoQ/iON1NQ4039rSKhWh5ZtiJKoJ1/A99cx0HvqRPDvORXkEo4hZXY8zQxnMTRSrpBKjD11ezBGV4qgi+x9fIs039/3bIWNTaVLsTWyu60JyH/9U84SEZ9TS3/XwusT7g5rC9PI7RZMGOCm8D/7LgwROY/JzxxksI57Xn1jBOzmtsiJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrwShjI+sD9dmN1xZWwed83qZv4IGMFGHYqq9Ks7RC8=;
 b=whGGyc4JTcKpJAc3Zr0tkOq8ws1keXtEV5QJygkBfheJPiAokqHUD1oArY9XB9LJovGosc3Hvk2LK1ruRxiDokcmw0+bB1eAd7TXronMVwJ0tZ5ZyRmaSEZPnBonnlIRnREpiIWq2W8X6KqQKDE5lDNQNkKoga68F+NabR9FUmXZTnYhFZ9MtT6rtZorkuwpbilkOp4jQnedrQbeUjh3UMCW0xWtPP+64odS27YMtKPN5zTRNYmr6QA9NI5Mx5cxzgAZV5ahtWZDpOzJ19f4J4OSD0bH+rg8sJ5omNmySrh/bs/xs/Ls51uds/Tip3hcNQehCKpCTw0PeZCFpi0fvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:51:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 23:51:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 22 Jan 2026 09:05:49 +0800
Subject: [PATCH 06/12] imx8mn_evk: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-imx-clean-v1-v1-6-a52a94b7e173@nxp.com>
References: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
In-Reply-To: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PAWSPRMB0023.eurprd04.prod.outlook.com
 (2603:10a6:102:37e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 9890094b-1842-46d0-86f9-08de594806bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGgxcExoU3E2ZkJUdVFuY1E2b0NOekJzUDJNblZ1WlZoWU5pQjFnc3ZHWjVv?=
 =?utf-8?B?Mzg5QzI1WU9UbFI3eEtWcEF5dGdzZjVDVGM4ZmlKVy9RQTg3UVdUOU9DUzJV?=
 =?utf-8?B?MGlpaUI3bFJUOWl6cEVUZ2tpcTlJek5kTFpjenhxeGtVZnBETjdkQTI0bHVa?=
 =?utf-8?B?T0hrVzIwdkFaMUdLNjY0QngyS0Nlc1I5dWxMa3pyRHY3eDVvMHJMdmt6VnNz?=
 =?utf-8?B?Zk5WSFM2TFlTbFZ1YTNXZVRmZ0IvR3plQzVNaUJkTlRHZnVsQm5udmtqZHJ0?=
 =?utf-8?B?cTFXeWtzK1F2YTloNjltU0IvaE1lWWhUbmpSU3RrZWltZlRUSE9sVFV6MGFT?=
 =?utf-8?B?TTcvKzlLaG5ibVZ3QVlCYUR2Uzk5NG8vUlNnZmI3RXR1UmljSnVMT2N5ZStY?=
 =?utf-8?B?UG9uQVlqOUR6Q0JxUERSeVFZbXFxc1FUVlo5bDE4YVJqL3VLS2ZwTGY0QnBa?=
 =?utf-8?B?V1piZk96YnB5NmFYejBiQVUyeXFtUW5yQXZ4U2hTZHJMYTdLUitzeWJ6TDlF?=
 =?utf-8?B?N3N5KzEycXJ3aEpQcmJnblBvSE9GVE5qcDBtSkdTeCtESWd1d0JKZnA1ZzBZ?=
 =?utf-8?B?Sys1WVdSRm9LRUpmdUZ0TnFySS9JRXpNREMzVnhwamJXMitXbS9aYUdITXht?=
 =?utf-8?B?N2V5VFRHZE9yUGttak1DV1N4Sk02YlMwYlFQYjdRMmtiWlI5SktzdytmNFo4?=
 =?utf-8?B?WUFwcmFNWktpUXN0dzl1UUhYbkJCM003OUVXYWRCalc3ay93TVRMQjVBUDZ1?=
 =?utf-8?B?YmNTejRjSTJLcE9xRTZlT1ByUVZDY3BYbHNkS3UzQk9XWGJ2bkwrVys4SUI0?=
 =?utf-8?B?ZXNLVUhqS1lSaW1xVzZRK0JEOHlTNlozVnkrUEhrREJ5NXVQSCtWWkdzQWE1?=
 =?utf-8?B?YXM5WGVzeXlPZ2NBU0kyaUVBQ1llY1hyQWQ2WW02ZkRoWDZjeVdpeEJNM2x5?=
 =?utf-8?B?VXFieU9mNnVDS0lROTNxUUdaeW9Dd3lHZzJQbVVzRjNTdXVOalROM2hKbW5O?=
 =?utf-8?B?NVJlVjFTSFZNQkh0bEQ3VEZJaDh1QmpiK1BrOUlOMHNJV0oxeW81dEp4K3F1?=
 =?utf-8?B?NkdDL1ZVdXFLR0xpMTVCYXRybmYyQlByNWpzZlpWUHgxRCs4Y1AyOFZEU1hN?=
 =?utf-8?B?d3ltV1Z4elBSSXJ2SHpmNko1OHhOSitmWmJFQy9ORjNLZHNlNUYvNURMSlRs?=
 =?utf-8?B?c3ZURmFhbXplV0xTOXBsZTZCVGNsaGR3QU9Wc0xxMzBhR0lNVFA1eGEwdEY3?=
 =?utf-8?B?YzdyazRFVDNaTldEYUVHL0orN2JBNElOOUV6Qk5ISWRNUThETFlEMkNGTmJE?=
 =?utf-8?B?aUd3WW1RTXV0ZGsyRjJWbDBxYzVGdXZTdUs1ZzVOTEttUU9VcjQ3aE5YYjFW?=
 =?utf-8?B?YmZWS1RSOWhGV1B1eDkyZkE1ZVkrVEFtYXE1S0R3aXlJK2tVU2o3cWJNTHEw?=
 =?utf-8?B?a0RvbXF1dW1nVVBPcGlMVWVvaWxPUDg4VWIyWURQQmsycE5IL1JNTTMzQnd4?=
 =?utf-8?B?Rm1NVHMzTHZPTU1Fb0J6TnNsbHhxN3c1blpiLytreFZBbWlNY3lLMHk3MjF4?=
 =?utf-8?B?UFRVNUtsTzgxZ2d0ZC83VHhIOU5RWkRrRTRobXlpMXA5cWxvK2hGRTlXci9W?=
 =?utf-8?B?ZXJZNS9NTHRPcDdiNnBFQmxsZEZjTG1HWkdhM0EyOXpYd1J1MWJaZk1NcEIx?=
 =?utf-8?B?eFJ0RG9MNUF5T0QxT3F1TWFIMzRPYjhlTWlhRUVJWTlqSWtCd2tuRDdYNnJR?=
 =?utf-8?B?bXllemlpYUZPY1ZRUm1DUUo1clNzRndSNXZLOFBuOVBGOG5IVU9FVVJSNCtn?=
 =?utf-8?B?eWswc2pZZ2Y2VmUyUVM0Y2RtbVJNcysySXBheEZSOW5UNDdaYUQxNXhNUlg4?=
 =?utf-8?B?aHFTbEF4S0tOd2wwNWdmYWV0TzlLcFgydWxoaHNwM0tmRVZ4QkJmTGk0M2R1?=
 =?utf-8?B?a3ZKYi85aXl2WldScS94NG92M2RQR1RsS1JRTjFDVnVyZlNjL0dZenpMV1Y3?=
 =?utf-8?B?UnFFT1QvQmRxU1pwWGh6eDUyZnZCelhLenNaUEhkSmM4TkZQZmgxV0s1RDA3?=
 =?utf-8?B?aGxDTGRyVlIxamgrYTdqOXZOM1d2TWxZcGlKRVg0ekpNZlZVUkxtczQrKzRl?=
 =?utf-8?B?aUw4TEJiOGxVdU9TT081OGRDOHc0SFdWSWJER1FTTTNQY005WVBQcDV2QU5T?=
 =?utf-8?Q?nvg8Y8ZONCSxOWLFMNnS4ew=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkdON1IwSkduVmFMYnBOQ0ZGcm1Fa0NWMlhva256Q0YyQmxkOWttamIzNmti?=
 =?utf-8?B?Yzd0bXlGd2w4c0YveTNWV2JLOEl0VVB2aDVjYWRlK25HQjlneEZGU3RMeGJT?=
 =?utf-8?B?K1RYdHppbnhiRXpPUnlmVWhtWmZNODV6a0IvWU1ReGFZMkVJMC9FN0VIZjBC?=
 =?utf-8?B?VzExWjYrWFdVMVhKSUF4NzJsRWhPN3JMTTlxc2F3LzQyRXU0aDBmM2JMMTVa?=
 =?utf-8?B?SUhxMk1mS2FnY0hnMHJiTWVsSSsvRWRHdU5SV1J2YmxNejBlcnBCeUpwaUpB?=
 =?utf-8?B?dXp2RmxSL2t1VlJBcWpqeGVqeldkYXd0RUY1RHpIOXExRlk2Q0t6S3laNEE3?=
 =?utf-8?B?eCtwU2pJbW4rb04wb09LSlk5dzFtbkhBam52cGFLZDF3SjBlL0pXaW5RanY2?=
 =?utf-8?B?SWZmVUlML0prTUxieGxzOStlS2sxRnhwUEVWRTlOeGN1SWluQ3prb0xaeWdj?=
 =?utf-8?B?dk5BVUI4SThaM0JjUS9SMFVFYU9pMXdMcDNoSWdCN1YzMUtUcFNxMGFoYjIw?=
 =?utf-8?B?d0djU3RqSUhsVldBYW5rSVU4UXhDSEdaOVVBbkw4R2VDSkJ0eVhjc2Zrb2xB?=
 =?utf-8?B?S0NZekh3QmJCRXZOb1luY1ZtZEYvWHNrb3N4Mlc4WEZSbjZ6REdvSXFTK0tY?=
 =?utf-8?B?aTJ1aWczNnFWKzZGMmFUekJRa3hrYjRxbTRJMnE0cTVhOCt2bnNTSm5XMEhD?=
 =?utf-8?B?aVhUV2t0aEsyN2dZYUJJdkN1NjE5NkpTSnNnSlpIZnNkYWEzM0pHYjBjN1cz?=
 =?utf-8?B?ZTJRNGkwbVVxSmlzc1o4Z2k1M1NTbksrbnZudStTRVpNRUZ4b2RqSWdRRUxZ?=
 =?utf-8?B?U3dmK0tUNnlpcGljQmRQUDFJTFRxRlJDMFhtbGVDMmVmTitZUDA2OWQrdjd6?=
 =?utf-8?B?V1Q1eEV0TEV0a3NlRUJ1OGhpbUMvNkxSWEoyTUtsc2lrY1U3cktnT1UzRnFj?=
 =?utf-8?B?RkhETHFOZlpNVi9iSTIwM2g3c3RIVnlyVVlmb25XY2hMK2FJN29xa0Z6V2lW?=
 =?utf-8?B?SFBCdEgvNloyZkp3enY5Z01wZ1g0YnN3V1U4Y2llbEtsUHQ0M1kxcGZCMkMv?=
 =?utf-8?B?Um05UnhIVS95M3U5QmN4MTZ4L2VJMEh3OHJKZ1N1THBPakQ1ckt3VXFCNUwv?=
 =?utf-8?B?SlRFNFpxRnFwd0J3YWpidUE1Z1JUc2JORjFGMGF0czFBb0xBMlJYSXJQMUdI?=
 =?utf-8?B?SVZjcUtaVjJSa2tiYVZOK0VyWFdqTERvOWVJTUQyZWZVcEl1a28xV05nK2VI?=
 =?utf-8?B?TWZ5WmRza0R6bm4xSkZ2ZGk3WHFXNXRsejFiL2lLUWFqWFF1T0hxNWFFV2wz?=
 =?utf-8?B?U09sS2hIeHhrdUJsSWwrbk8vQ2FBUlhITlNxeHZheVVOalZWTE1wU1dQRS9o?=
 =?utf-8?B?VDd3MHpjbURuSFlRNWVXSy8xU013dVFYMGl5UThXSzJ0U2VkSDZRaWZxSlI5?=
 =?utf-8?B?RkxVdVZwN1lEc1U2a1dDUHVDZzl1UllvTVA3N1RZOWZ5Z254dnVwcnVyVHVP?=
 =?utf-8?B?QmNvT2dlT0N6eEY3WEJsN2VTNlFSYjI4T0tMZHlpZzZOS0lCQUtoTWxzM2wz?=
 =?utf-8?B?M2lRcmY5OTFlSURpWXNEcDhxTGpqZjNhbFFrSUdyaVBPbUI3RnRGZHNtZk41?=
 =?utf-8?B?aEl4dFVCUUNRNjArOVREWWMwaFVrdFBFcFQ5YjJWWjRrK3hkVjJCdVZTeXFS?=
 =?utf-8?B?eHUxSGhPUy9GbExTMEwzTjF2YUl0Y0xBcVo2N0tOeHFiMzZjMEJUeWhIRGRB?=
 =?utf-8?B?cWJsSEFYSHVhOXRjOHFScVUyeUE2Q3Z4Y2RMckg3TDZvZzR2bjI0dEN5eGdw?=
 =?utf-8?B?MHhnVWRBZzNVOTJtOGVJbENFS2lKbGU3V3dvaDBrOXFPYkFyMzc2K016akFl?=
 =?utf-8?B?T1pJQVBteTh2RzZPVGZDSjZkOHV5b3oydFZFWE9TS2JiUUZ1U3dkSXY2Ulo4?=
 =?utf-8?B?TGlhTUorRFFHRmhCK2hFRlZXcHRYSVh4SGc4YnZ3dDZBaXZERTE0b3V5dEFS?=
 =?utf-8?B?UzhGSXdNR3BVV1V2UGVIY1lDUk5XSGtIYnE0ZkNLQlR2a3JhN0lLNVhTSGh1?=
 =?utf-8?B?U1V0UWhEUjFXUmxhdmdQTGtUZHdXcFBlNmtDQkJkS2l6SlBxSDRmRWFtNFFs?=
 =?utf-8?B?cXhNaENkSkk3WEFkQnBBTzU3ZVlEOEMxTGMyMDVMSm9Tc3VNNldhYUdVZFli?=
 =?utf-8?B?c3FMVTluWUYvNWl1cHdOM3NYVENHeGYyblltWlVCb1ZqdVNSUW4vYTgzZHNV?=
 =?utf-8?B?T2hhekszdU9XYVFkM1RieDlnaEdoNEFoWHhuSUsyS3dDUlNGODF2NGtWRVU3?=
 =?utf-8?B?cmNpaTFYNG5sMXFReVlTcFcrS0tibFo0c2JHV1BJVkE3L2UraVc2dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9890094b-1842-46d0-86f9-08de594806bf
X-MS-Exchange-CrossTenant-AuthSource: PAWSPRMB0023.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:51:42.8882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzU5khOk2EJCwcvr92NlxJwpZpaFCOjxs3yP45Jf23qckVvk98gM7KdGKxJYKiHfwL3J0l+NljtO1CQg0qG9uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
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

From: Peng Fan <peng.fan@nxp.com>

Drop unused headers and sort them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mn_evk/imx8mn_evk.c |  4 ++--
 board/freescale/imx8mn_evk/spl.c        | 19 ++++---------------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.c b/board/freescale/imx8mn_evk/imx8mn_evk.c
index 9d3f29f2253..e13b35c116a 100644
--- a/board/freescale/imx8mn_evk/imx8mn_evk.c
+++ b/board/freescale/imx8mn_evk/imx8mn_evk.c
@@ -3,12 +3,12 @@
  * Copyright 2019 NXP
  */
 
-#include <asm/arch/sys_proto.h>
-#include <asm/io.h>
 #include <config.h>
 #include <efi_loader.h>
 #include <env.h>
 #include <init.h>
+#include <asm/io.h>
+#include <asm/arch/sys_proto.h>
 
 #if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
diff --git a/board/freescale/imx8mn_evk/spl.c b/board/freescale/imx8mn_evk/spl.c
index 6554d445a59..f07443e5c15 100644
--- a/board/freescale/imx8mn_evk/spl.c
+++ b/board/freescale/imx8mn_evk/spl.c
@@ -4,32 +4,21 @@
  *
  */
 
-#include <command.h>
-#include <cpu_func.h>
 #include <hang.h>
 #include <image.h>
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/io.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/imx8mn_pins.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/boot_mode.h>
-#include <asm/arch/ddr.h>
-#include <asm/sections.h>
-
 #include <dm/uclass.h>
 #include <dm/device.h>
 #include <dm/uclass-internal.h>
 #include <dm/device-internal.h>
 #include <power/pmic.h>
 #include <power/pca9450.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/mxc_i2c.h>
-#include <fsl_esdhc_imx.h>
-#include <mmc.h>
+#include <asm/sections.h>
+#include <asm/arch/ddr.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
 
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {

-- 
2.51.0

