Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8363CF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 06:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6161D88363;
	Tue, 24 Sep 2024 08:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DxwJVZJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1FBA88703; Tue, 24 Sep 2024 08:07:53 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F2EE88363
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 08:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cqnzqc0eFeFxT3wz1cWerCLgDYSS73aQxxsjXMzr/nrXFgpuHX6NXS028cM3E5UQ+ZJzDz9aerzIpx5IuV/4FGqmWPqPAKZgai2pO6i/ixF7l69C5S3eMg+pNwGtgFigOUQOaTGC7quBctQhNd3enbYBGtHp1fvs42DV35qJRM86LXyS4GGwSKlTx/p1UJS9Z6S6jGFDKWY8hPH6ltio3jviY6mDU6150g1riyz6SQveNKxGeTI8oMgrdYVPM7LaXZcmbhkf3fQB/bRu2IulPIxwo1KezmcTbLB7BWLUwMdQkNePuIhxgyJ1x152YlkQjvDp/jyeuunQ3ESmUj/nAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWRisN1vpiGLUdhei5d1yt+WOp9zNpiL8X3kaZpfH1A=;
 b=eo2G5s/VvT6CaeuuoTdyZhUVLQENQWoe3uC7gd96/Phg2lowClqHTQg69ICHfQONVmgFocFZjyJrW16DVOFvjxttgS1o1F6PVGXP7Rf0SRU4xY80j3ruT+5JOK9FERYJvvHuab3nVVRZVwIZVs87FtpJXWQNJVw0UsNGaSL0DeBCs0Z5cKYKoOtYrKRxZH9NED1vHRkyPXYoftRpMQusjbvM4aqqHGuzrbRHYChmeLpdVfpf5oE3n44/esf1jZZu5pmv+6Uoac2TixQv9ZvniVjdA4C9Y7uCpi4U8GfxzKEqAyKXeVlvglrTdg6zTRL5fEOHxTKgHc1bZ/v/2iVgrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWRisN1vpiGLUdhei5d1yt+WOp9zNpiL8X3kaZpfH1A=;
 b=DxwJVZJZaurj4An9TP9kmDnvX5DhVA8yGUoBos+MXaiKSPeoHT0rF+S/R6cxHvVBbf025lav1Qxbf7AuOMAs/98VdyXvIAeerD21/0Kk1FpKpfgou/3NS0FXg2/KC1nm07g6solrBxxmhVywYA14YFo4vKN3Qug4aEcSnK/maW1ilowf814L2CaCtyXeyeON6XJKE8rF5THQARjvqgt/gupSkZyBoPlffTWfx/TSPrLdctll1SthFt0iYobpWPUmZM3+sdX0+6bxYQorYhi2ZMlR1oGOpGAYmEoKddcKoLT4toyXt3hrMEhyyYm+qUuw6rgqrxIJoUl+S4w0oEkFBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DU4PR04MB10435.eurprd04.prod.outlook.com (2603:10a6:10:568::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 06:07:45 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 06:07:45 +0000
Message-ID: <eaeda982-4219-4e6e-8449-3bf81c230419@oss.nxp.com>
Date: Tue, 24 Sep 2024 14:07:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
To: Peng Fan <peng.fan@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "sbabic@denx.de"
 <sbabic@denx.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: dl-uboot-imx <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20240923131439.28572-1-peng.fan@oss.nxp.com>
 <b77e571d-e782-4e7b-a9d2-1ca92df5c512@norik.com>
 <PAXPR04MB84597A12EC1885A64E34E04188682@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <PAXPR04MB84597A12EC1885A64E34E04188682@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DU4PR04MB10435:EE_
X-MS-Office365-Filtering-Correlation-Id: d25cc87f-5a4c-4499-cb8f-08dcdc5f3520
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2o4QmU4WE1QVFVJOE9kalIra2NSMjk5NlN3Sy9yS05CWDRaSU9YY1UxTTd0?=
 =?utf-8?B?UDgvSlpNYXYxK3l3Nlg3NW5zVDZraVZrRDZwQ1ZoM24yN2ZPVm5YdktNT1Ft?=
 =?utf-8?B?aEZiT3YwV09hOXppQWJObXVJaGpzcWFiY0FSOVNnTTJZSWU1K2lmY2owMm1x?=
 =?utf-8?B?NDhOOUpMRWt3OUtWUGwxWmdCTEMzT0tKTS9qaGRYWkpJWEpZRG9MdS9TQVJk?=
 =?utf-8?B?bU5aNDV1L1k2SWpqN3pwQzF5a1NvaDBReXh5ZXlIWHRlakwwbTBDcE1kYkF0?=
 =?utf-8?B?aEVqUUZPV1BQa1NxTXJrOHQxaU9KNmZIbGhtbWtPZThhdHpuRFIrV2tGeFo1?=
 =?utf-8?B?azI0SUtXMktwWkZuWXhlWlVOWDFVdHFkS3JST3ZRVmU0cGx5SmhzZGxMTWJK?=
 =?utf-8?B?bk8yWmJMT0ZsTmYrUFFGRmRoaEZVZVFzR2VMYStTOURicGsxeHBPaFh6L25v?=
 =?utf-8?B?NkR1WXArazA0R1FPSGhHRzF6UWJGQTZQZ05VNGY5U2VQVEh6YjREMG9Qakth?=
 =?utf-8?B?c0w5ZldRcHBVZ3FVaHR2UXVkSFZ4ZHlnTmFDbjhQL1h3cFR0NHhkbzY5cU9K?=
 =?utf-8?B?T2h1MEJOSm9xMDZNbVg3ZGFRWUduN2NVNm1IMUdKTXJkdFpGNlpmeUFDKzJm?=
 =?utf-8?B?WWN3SnMwbDc5UStQYzJoK3J3QkNOQVZoK0Y0NmoycENFM3Z6alZLWmNkQTND?=
 =?utf-8?B?WlVONFYvQWt2TnhSNDBIMjFLZlRuZUFHZEVQdDRMVUNpSkhYSmNEaG9qMFcw?=
 =?utf-8?B?WUV5eVEzRytKYUEyNnBYMk4yNlNhSnlXa3VVSHJSSEdDS0todDRrc1JCUHBS?=
 =?utf-8?B?eTF0UlZ5cFZ0OHJ5TmR6bWY4TDdMZHo1MVFUakZmYTdRS2twZkZkeFM0YW1p?=
 =?utf-8?B?SC9zRW9aaDJ0U2FDanB2Zk1HV0VNR2pab01hR1ZveVJPTENVSUFtU3FyWmRa?=
 =?utf-8?B?SFBGL1ovN1NOYlY4Wlc1d01hQ08wUG5FVXdwdUNHQmxaVnN1V1Mxb01LOTli?=
 =?utf-8?B?WkNrUkZBZlZ3Z3g0a1pRN1dMSTNDMEhEVHFRTktRMnVrdFZKZmkwcnVGaWJQ?=
 =?utf-8?B?WkU4MUIzbUVkOFFMUE5YNTNmQVpFcmRRRmZZcnd1TitjMjVvcTBudXBGWlh6?=
 =?utf-8?B?SXdYb2dJMTdXUUVJZy9GeUNRbWxpTGxTbjRDSURmTFlIUk5VM0JRRWpzLzNm?=
 =?utf-8?B?d041N1BzWXdHTlpWMzc5RWxTZGJYckF6WnJvY0FEdFlGRTl2ay92U1paNzJs?=
 =?utf-8?B?RW9FeW1ac2paWFQ4SjJ4SHR6NDR5K3ZiT29uTlVJTy95NVEyWmVzS2NYbWdF?=
 =?utf-8?B?cno2a3FldFVTZE10QlNFZXNhc0sxYmhNQXAzeUhaUVZLTms4UHllTEp4TFpk?=
 =?utf-8?B?NVJmN29DNGFGZHArTTB0SXA0NzNqZXJMOUFLUDFOdTNCWS9iNHNRREJSN0hK?=
 =?utf-8?B?QUd2V21EWXJ6S1hONnd6dlpvUHh5Sm9CaHFMWDZnUGtJSjk2U0NSc0RWODkz?=
 =?utf-8?B?R1RPN2hWRjFsbE5IYUxIWVZTUm02aS9yL1FMRHZIenl1V3dHYTlkQy9qcm4v?=
 =?utf-8?B?ckI1Q3cxVkxPQ1ZRKytaMms1TDQrYjloWUozTjA1TGpjRUM2c0tPYTNlVmFV?=
 =?utf-8?B?Nm11SjhmQzBvUm9VTHhFSW1zbEJPNElLakVVbnk0TzVnVEUvVkZtOW5PNDYy?=
 =?utf-8?B?KzEyS1FLSWpOVHI5L1VpMDdqZDR2MjNZdkJBdndQVFRqS1RBT2FMaTZKaG5F?=
 =?utf-8?Q?/8qiRf6XDmyhy02a4A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXRuelYxN3hITTU2ejZWUVZ2K3dvUjlROW01NHFzcUxteDJwOWdvWS9vKzl1?=
 =?utf-8?B?WDB6dGpwSUJhdkZpSVFTWjBPZ3R5VFlZOVdmQzdJYS9ieXBLbHNFNk5ISmxp?=
 =?utf-8?B?UENRejUwd0VTOVJsZEo0NzR5N1dzd1ZwSWVzdlFmalpzK3g3cTJXZ3k3L0RB?=
 =?utf-8?B?TTJLSWROcStDaG5ISGNiQjlENVo4ODJxNVU5YmlVWDJEQUc1cVdVeGtCOERF?=
 =?utf-8?B?TGZwS2FBMmcxd3Q3bXBDRUFWRHd0K21kdEh6bFROdW9LaFd2TVdOaTB5U1py?=
 =?utf-8?B?dnR4dFdvWUQreUtBTXI0OWtVV2RndzRrN214V0ZaYlRCUkNrQUQ0ZFJoeFh2?=
 =?utf-8?B?SlRmbWhjeXpRYzY4WVpxcitLb3BDTmYzc2FpUUYwZUg2eUlrekQ1Nlo5b1BF?=
 =?utf-8?B?dDdpM2tpZGVYNHJxR0E2cG8xeXBnU0tPcU5sd0ZNM2NEMG1vQnlwVUhnVmxU?=
 =?utf-8?B?VUIyMlBvSVdkanFmK2ExTHd1ZlBoUE1rd1FwWnNUb3Z5bllhYXBEYlhtdFNz?=
 =?utf-8?B?YndLTFp4TUNtZVZEYnlHL3ZxcXplYnh4cDFobmhYUW1NMWFvWU1mK2M1Y0tn?=
 =?utf-8?B?emxDelhIZkdWd290blJuOXdDQi83eGVXb2IwbVhvUVF6a29mclF2alkzemZk?=
 =?utf-8?B?ZDhiVnJMZXQzSzBpSUlQZ21BVEQ2aU9kaGFFUTFOM3pnWDVGT0VlbnU2Wnk5?=
 =?utf-8?B?bjkzU1NyTWxYRFF3QVVoVmUwNkhQNUszNCtEaEJYdjdEbm5RMklrTDgyL2t6?=
 =?utf-8?B?RTVrTWZqTlBEc1dJazVVa1ByVzVKN0lpK2RESC9QTVI0L3JtamxTcVhpd0Q4?=
 =?utf-8?B?bW1Hd1RVMWxrYXdRMWNYelQxMWNOSUk0eGdiQjQ4TVdqMjNGWnVaNUJpU3Zh?=
 =?utf-8?B?cGo5ZExNQXpYcnczQkNYRlJHZ01WN2s3K1Rid0x0WFJPK211azhyWTJCSm10?=
 =?utf-8?B?SGswRytNSzZqSExscWZsVUZaQTZORHRaVDlKMlZibUFtdFlrSCtTaWFjeW5H?=
 =?utf-8?B?aVdKeE9RanBsd0NWY0FabXJDSnFpeHFoK1hjUVplNkZxcWNQWmJ2ZmFEbFB0?=
 =?utf-8?B?MEtoclhVMDV0LzcxL3k1Ymt6MExPM1FHeCtvSzBuUnNnMVp1dVJTaVRVR24z?=
 =?utf-8?B?SC8ySzhuYjVHWXA2TzBIREJzd1RXN1F1QWUrdjRFemlDbThQRFh6U1RnMFEv?=
 =?utf-8?B?VkZxVGVBU0h0VDhLSm9ZWEkxMncyZFVlM2h5QXJJandsaDZ3TWNyaFlFMjBP?=
 =?utf-8?B?ejY3dndDVXNRWW9SUTg2QW9QOVM2UlZJcW0vODRYY0RKY3pVbmVpaTRKUkRB?=
 =?utf-8?B?VFh5c284NVQxdlUxMDJvekJvSy9UQVFNemEwaDZ4QUtFKzdOWGRKaENOSXVE?=
 =?utf-8?B?MkdBak56UWRPbE9mOGJjQnZERVFNcENSc3FFWmdKZy9UTUFpd3FEdElteHN4?=
 =?utf-8?B?NWFaMGIvc1dpclBacG42UTNWUGdpVjB3VldZZERRL0taMmVMa1FTdFJxU0J1?=
 =?utf-8?B?NFNrb3lyc0x6ZzVZSE9JNkpVekxBYXByeVVLMHQ4ZUthL0pmL1VLS3V6QkpM?=
 =?utf-8?B?WUJ6czljbVFFby9UeE5rOTlqY01RZ0s5YWk5cnNBTDBBemQ4Q25pajNiUFpR?=
 =?utf-8?B?dGZVV2JiNU5jelFiaURkUFFBTTM3NE1mbUh3T1NNRzIrTmFIZVBWZ29kcFZP?=
 =?utf-8?B?dGZGS1hzRlRQWmFibjh4KzJWR3Q2T3pNQkNUU3NKSGQ1UDg0TjgrWnQ1WXpF?=
 =?utf-8?B?MWxyTTY2VTZKa0tIVkJRbkd2Z0hxUkQxUnVtK1NIMmdYZ2d1ZGNqendoQUo1?=
 =?utf-8?B?aXhUVzNTY0owQVpWVGNPVHVkY0ViWlFHUFRRM2pOaDVCK3doUG9xbGRTSTBy?=
 =?utf-8?B?MEozelhOc0g0QzFhbDQwTm1CM3N3L0s5bmZ6Mmk0YjVXZ0xJUDNIbEdORGxi?=
 =?utf-8?B?aUNZS0hYbnJoU3N2NVF2MUt3cWt5Z0JaeTVqeUZRcVF4R2I4VXhwZG9YMmlw?=
 =?utf-8?B?aHgwYnpKNS9yRjFnZEw2TENmejVLOHZvUkx0T3p0SFVtOHNsWDYwOVZpajlz?=
 =?utf-8?B?MGpCeitTYnRaVGEyZllSZGdsNFd5WlRyaXpORlN4eVJraUN5QXNGOFV1Y2xw?=
 =?utf-8?Q?vdxMuK4WBhAIDrpwdt4hb6JJ/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25cc87f-5a4c-4499-cb8f-08dcdc5f3520
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:07:45.4589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXDXumut7Y1M8lwOiHNSlJWZfP5fOZ6jCnkXUA4SUyFwHIFrqUSGOk8aMLnEoBFs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10435
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

Hi Fabio, Primoz, Peng,


On 9/24/2024 10:56 AM, Peng Fan wrote:
>> Subject: Re: [PATCH 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
>>
>> Hi,
>>
>> On 23. 09. 24 15:14, Peng Fan (OSS) wrote:
>>> From: Ye Li <ye.li@nxp.com>
>>>
>>> Because iMX93 has a internal 1/2 divider before clock input to
>> network
>>> controller, so have to set twice frequency rate
>>>
>>> Fixes: 09de565f76b ("net: fec_mxc: support i.MX93")
>>> Signed-off-by: Ye Li <ye.li@nxp.com>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>   drivers/net/fec_mxc.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c index
>>> 0a0d92bc2cd..e5d7f0f3e1e 100644
>>> --- a/drivers/net/fec_mxc.c
>>> +++ b/drivers/net/fec_mxc.c
>>> @@ -1215,6 +1215,9 @@ static int fecmxc_set_ref_clk(struct clk
>> *clk_ref, phy_interface_t interface)
>>>   	else
>>>   		return -EINVAL;
>>>
>>> +	if (is_imx93())
>>> +		freq = freq << 1;
>> Humm, but how did it work so far?
>>
>> On phyboard-segin-imx93, this change breaks fec ethernet.
>>
>> I had to revert this already in NXP downstream u-boot.
> Ah. If you set enet_ref_clk to 250M, then you no need
> this change. Otherwise you need this change.
>
> Regards,
> Peng.

Just check phyboard-segin-imx93, this board uses RMII not RGMII. It 
outputs CCM clk_enet_ref on pin ENET1_TX_CLK to external phy for 
reference clock and loop back it on pad to FEC as RMII clock. So this 
usage has bypassed the 1/2 divider since the 1/2 divider is inside 
wakeupmix not on path CCM clk_enet_ref to pad.  We need to change the 
patch to limit the 1/2 divider only for RGMII on iMX93.

In kernel, clk_enet_ref is assigned by dts, I don't see its rate changed 
by driver like u-boot.


Best regards,

Ye Li

>> BR,
>> Primoz
>>
>>
>>> +
>>>   	ret = clk_set_rate(clk_ref, freq);
>>>   	if (ret < 0)
>>>   		return ret;
>> --
>> Primoz Fiser                    | phone: +386-41-390-545
>> <tel:+386-41-390-545> |
>> ---------------------------------------------------------|
>> Norik systems d.o.o.            |
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
>> www.norik.com%2F&data=05%7C02%7Cpeng.fan%40nxp.com%7C482
>> 464a6990d46e9668808dcdbd135d9%7C686ea1d3bc2b4c6fa92cd99c
>> 5c301635%7C0%7C0%7C638626938825379940%7CUnknown%7CTW
>> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
>> wiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=kkO%2FnCs8%2FjpZ4ez
>> JYDHo5T57jmUVPdp%2Fs34CnpwrsGM%3D&reserved=0
>> <https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2
>> Fwww.norik.com%2F&data=05%7C02%7Cpeng.fan%40nxp.com%7C48
>> 2464a6990d46e9668808dcdbd135d9%7C686ea1d3bc2b4c6fa92cd99
>> c5c301635%7C0%7C0%7C638626938825421127%7CUnknown%7CT
>> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
>> WwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=0YIItswvK9V9zEcn83I
>> h0IRjyzNGvqkM7vq4bXnajRI%3D&reserved=0>  | Your embedded
>> software partner  | email: info@norik.com <mailto:info@norik.com> |
>> Slovenia, EU                    | phone: +386-41-540-545
>> <tel:+386-41-540-545> |
