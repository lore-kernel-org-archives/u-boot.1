Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA3DCCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F5E683655;
	Thu, 23 Oct 2025 09:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wXVNpFk8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 817CC833AD; Thu, 23 Oct 2025 09:34:14 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD4828323A
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 09:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMWzFFnbvY8g+LqtQadjulUJ3auco1i+p68V0gvlwr5CgV6KWb0JHLgTZt8yeLS8Qx6YBof1JXBehSQ7PNs4NdLuvNHqHv4/dVEYr4odxftffeHZLIYVaJl62kbVpwLQUsgLMdQqnR0lEPSXOIutnMdZgFjVq+rZ2uYA0ZnHu1Hgir0kcqPTKAUDdJyKFxKHODwGGgsAkAoaqUN1zYbxJOCP0PjK2wUZSIwboZm4m28TqlPgATNuliD5J+PLmZadqLppkFqWuhBIvzmoepOff2pCwbgLg9bKZld6t9Gzway3uWpm1HUoaoabbdu8qwkLJCmkn0iRFAnW6tXo4iRRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TVVzPrkkGMdxrVRhD+W8wZNlhx8sxY6MpwRseAXcl4=;
 b=A1gjdoJQ6AdDJMQ4q+aWfqqtAJtlKTQ07xQHsKCaPZprj3assoRbdOkfJJHIPxLB7FJn0qqRVFc4gIdx+1QW26V7Dq55AK01V9al0aiG+JQdmAPBNp4xu4N9WITQnsTG/1g06HpMam9xmdBTsxA+nExwHfPAgGh4pjWWl16xJm0pM5Os1lVlkqwyi0NzZiDrZxlUEoy8WZjCExwXazOhyb+moH/r80gvOGB34CDYBdUTxB6piyaNcXCkbFqkb0lNIBPDs3vF1rthszRQorF5dUZy1smwglf/E/JjbldcKN0ngO18HklzJZ7udG3OL9peV8eYLjlICBMcoBK4HlaYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TVVzPrkkGMdxrVRhD+W8wZNlhx8sxY6MpwRseAXcl4=;
 b=wXVNpFk8ti+Q8pnEXWHfAULIcOn2q38QOleLo+z7XVj1nGuS1t0Z31kZM9d3ss+pTagsmW3170jOxUg1Ry+kSsRHHa4y0D3Rw/Tc5swSuRw1Q+jrFED6i6fyT6gxSuMiFcbfvPEFYPf9kZ4pSmdmNRIdH5Q+vFSPnnCRgYeq4hQmDf5Iu/ZOEVkwPZNCCFxb/pSfbvujc177MqPbOpgAG2KTYkCWX6Vn5mi75+wdfHObPpg3sUNGzvC4QrHdw7EDCeP054CuPwQouRqFFkivN/kV5y8aFxISY/2WIeroXdKJh8gFyqAgV/I6pEDuv5AjRxuY2zNu7dVN3ZQC+y9ksw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:34:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:34:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH 0/9] Support for Samsung Exynos 7870 DW-MMC device in
 driver
Date: Thu, 23 Oct 2025 16:46:04 +0800
Message-Id: <176120893102.2124.14176243261248416795.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6ec284-78d0-490b-d795-08de12068cf6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFJtK3VNZGJKZnNBY1dvM3pSRTVnZytRK20wTUZwR0JvYVQ3YUhYM2lhY0pi?=
 =?utf-8?B?SnJFOVRrVTRRN1hWMXg2ZHRvUFZabFR2VlErQkpVSDVpeE9ieTgvaFRVNHdO?=
 =?utf-8?B?UWpxRXBSTkduZXJZYnowV1EzZTNGS1NQOTNhV21ybmdVK2s0UnRxTjAzcWpj?=
 =?utf-8?B?aTNJVFNiaFBmM1lOWGRyVG9QRjF1RTdKZVMwSmQvMFVXL0t4Sk1XUXRtR2Ru?=
 =?utf-8?B?ckt2NCtRMlhTeHNDcVYveHdnWjI3b3pXYzNHK0R3MjlBVXM0aVFjNGdJUkhJ?=
 =?utf-8?B?eEhIUFRUc2E4TVFSR2pzOGpNaWdPVGxpT0xFOUJEVXlGbU5hMDJCZjQ2ek9N?=
 =?utf-8?B?UU51V0dDcG1wSGZHQnJadCtRalJlY1RYY1Y3RE16WUh1N0NFWXVxTkdlK29I?=
 =?utf-8?B?aEpSM21kNVk3U2lUYXV6eHRqMFNVOElWUytCN0FwNnJ6NXY5KytNWjNXT1ht?=
 =?utf-8?B?MmpaRDZ4elZoZmZCcTdBSjFNOEJUd0VSNTA1bXBzSE1tVG5BL2RETEgyVkNq?=
 =?utf-8?B?dlBuQUZBZkpOUUMxQWFlKzlnTCtxMzZPbmJEUlkyMVB2ZVNiMXVzanF4L2RZ?=
 =?utf-8?B?RVl2YjRVN3d0YldFU2xGSCtwM25YazRybERZZ2lBWm1NNnFtYjVTMks3MGQv?=
 =?utf-8?B?N0YvSmVicEdPU1ZZVXc4OFZuVThybWVVa1gwcFRRS3p5RWdtUWtVWVFSKzZw?=
 =?utf-8?B?bGh1RWRSU2xndzVxTHFPQkpjRHU0bVR0eks5b2JlU201ck9SQURzNnJLZFVk?=
 =?utf-8?B?N0gydU55di9LY2pGbVpPbzczaWpBQm4zMU9KQTdiZVBQZDJnRG8xSTFRcUZQ?=
 =?utf-8?B?MzBCTi9aV2wyN3RiUnRVK2lONWJvY3ZPemNMdVdZdW9vSHVZaU1EZ0krMUlx?=
 =?utf-8?B?Y0QrcE9zcGl3T214Q1BPTEsyT2pvakd1djJjK2JQUWdDV2N4OVVTRWJjc3R5?=
 =?utf-8?B?RmxCTG5pRGlMV2NMSGNEbkdxYkd1ajNEYXFPRjNLK29jejlqbWRBZVNpUzlP?=
 =?utf-8?B?c0lKbkpHMEpscWlDbXhXa3l1NXFuNTZaSkU1NjFSTGFqV1lxN1hMMWtJd2Ji?=
 =?utf-8?B?QmgvT2lSdTZUZENaUDI3bTNDTkM4cnFFRGpPQjI0MGRzNE8wNGN6U0lYQThI?=
 =?utf-8?B?NWJES3p4a0k3ZjdWODdNWEltalNQUUg2WlBwSGplQithV0o2ZlNHRG5NSWlG?=
 =?utf-8?B?T0VFVFlmcFM0RmVzV3ZaNGhMaGZFYWh2bUJ5UGlDR01KcVFuUSt3S1ZXamNG?=
 =?utf-8?B?VWpYM2c1b1IyaVR2K0hxSzlRMmRvUUxNVHFaOGpRckJobm82WFdCY0VaSG1m?=
 =?utf-8?B?KzF0OW9GYnFuckk2MGU1eE1EME4wZjdQbVlENVVWMmxxYWtmZnY2VkhSbnlN?=
 =?utf-8?B?ekp1SmJYRXdmME5INFpKZlFodFFRbjJ3RFlZN3pDdGNORGFMV3V3SVNyS2dQ?=
 =?utf-8?B?eVV1UDJPQVJCdGhGZ3QrdGI2ZHlJNW9zbC9LUEU1d2s5L2MyWFo5L1dTdkc5?=
 =?utf-8?B?TjRKeEx1aHNOc1BGQWRBV0Y1Rmo1RUphRG94MThkWDhwQmlvdUtDZDY5TklD?=
 =?utf-8?B?QUQ3a3h5RE9NSDRzelBhWGxKbFBNY0h1QzRwcU9oT2FIWldxZWFxVEdDMm5u?=
 =?utf-8?B?Z1hyQ1VKNFE0WVhtQ3k2QjZBMEZvbStRV0ZJY3dieVc2Q3BNc21CWEJvTSs0?=
 =?utf-8?B?bEhvSkRYNk5BeTMxN0RFNWN6ejE0VUk0aGkwSGtieXA3V3JCWWEybkN3SVFC?=
 =?utf-8?B?Qlp3czZVQlpMVDI1QXc2TWphbVBtcGpiaEVMbCt6MDRTck1lZzByT002UzNF?=
 =?utf-8?B?TjlNWDVpMG9CN0NVTW5kWlV6UjBjMEtlRS9wWmZRUkVwbmd2Q2JwYVBOQVQ0?=
 =?utf-8?B?bms3QTY2VXNHRGhQbEh5bkFsWE4yOFNjb3dEa1hOL1cxTkZ2dGNXOWJtVFNZ?=
 =?utf-8?B?a2Qva1NzeW1HVk9nTTU2dzRDVnllNHVQZlR6dFkxck5xZG9TdnZUcnd3NjNz?=
 =?utf-8?B?MHl6UE1QZVJMRFJPcEo1T2ZCTllFb3RGUVp3VFBCVlNtdmRITnpnUSt2MzBR?=
 =?utf-8?Q?f+wlYU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(7416014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnZWMm1ORHBYSjRORjdMekpwUWRnWjBZSmtSYnVBYmE3KzJBWWtYU0ZNZ2U4?=
 =?utf-8?B?Q3l2Q280SWNRNUwvY2RSRkp5U3pBaVJOUVVDL3Z1Vlh3K0U4aEJpSVBLUXlI?=
 =?utf-8?B?SldkQWV6SXlsTUpxWmFsdDBwZzcvRzdtckpxa0RxNmZsVExTbTVrcnUrNDFK?=
 =?utf-8?B?UTB1OWF6dXFEU3FOREozbllyYXRMZ1U1RzFjMjN1SEY0TWNaMDN0Wno1MFBP?=
 =?utf-8?B?Z3Y4TG5qeWVuYnZiaTNtamwwbk1ZUmQ4eXZaRXBRMDgwNFZPeWgzOThlWHI4?=
 =?utf-8?B?dFZMc0J6YVM5R09nbzB6MzhDaDh5eUIxeGpLVXloMCsxM1lKbVROMTA1NER3?=
 =?utf-8?B?ZFdIY3FITitMUVBiaGhQUmpiaUtXM2lLVFFLSEZkbEJzVXdsTVJkclpwMFQr?=
 =?utf-8?B?ck50TmIxUHQ1RUp3WkNxSitvcm53VWJnRHRiN1NtT1ExY3NOSm93aTNoa3kr?=
 =?utf-8?B?TmxtR0tlbDlqUE1KdllUaDBPTkh2QitTVjhMUldBYXRiRkdJK0IreVpYdjA0?=
 =?utf-8?B?L2FpRlcyUnNMOVpKMzdBSXkzZDN6bXR1OFJSclIydUk5aDdzMnJpdmlSMnR0?=
 =?utf-8?B?aUduN1VLOFhDK3h5Nm1LZ2JJLzUrYWdXY1hjNGlNeWdFMDE4TW1PRmJseVpE?=
 =?utf-8?B?RWJmbW0rZ0ZEeE55U0FQajVqQUI2YzNjUFRVYjJEYkF1cG1ZL2M3azhCcXo1?=
 =?utf-8?B?STJ0cFMrakpDbjFEZC9ZaEIxd3pwckgvTDhQMnRLR1pxNytqMUk5bUg4TzRJ?=
 =?utf-8?B?WE0yeUZTaGcyYlRFMGVHT2tHbUszSTBMR2xxTTZ3QlI3YndpT1BhVHQrV0Mz?=
 =?utf-8?B?ZFpOU0RtbG1TQ3BIcFVleUlFLzhJanVxMTJLMVduRkNkSmhKL2ZxeTdmeUM4?=
 =?utf-8?B?RGdJUnFGSFEzK2pXRXR1L25MaThpTDVXMDkvODQzbG5RYW05TlROQVI4VVpR?=
 =?utf-8?B?R1hjMkN1TDZUL25Id3RrQk9jTlA2UkUwbG43Q25Rak92ZTBWYzBxb0VVaFFS?=
 =?utf-8?B?N3VRQ1daWGZjMjFwaWU0Ri9zRU9vSmc0NTdQZnNHYjMzSXZBT3U4aGNEaW5u?=
 =?utf-8?B?VHRsRUQ3Z0hJVnRSc1lpaloxT0tReExNRVVPSVVPU0VkZVRLazJxNzdhYW8v?=
 =?utf-8?B?TzFPL2ptb3V4dUhGSlhnR3pGNXViQXNEdXNBNTVHTEhwZmpTVDA3ZHhQcG5n?=
 =?utf-8?B?cEZadFVSc1VIcmlDaTJVdTRRdGZTdGdaREVLSVlXaDJrWmtWR3N2LzFFQlVq?=
 =?utf-8?B?VmdiZ1lQNHFDNXFqMnBhOHNOa0dVU0o5V1JDTVY3UVluOXM0VzJLeS9UUFp2?=
 =?utf-8?B?M0hKQmZPSDNZMmZQVXRZUHZPOHRCMFVUSTI3VnJ4N2ZldG9MNlRCNmx1WGdY?=
 =?utf-8?B?ZkdPMXN5cTFOdFpOOTIvbWJwOFdTREZrWHZ4OVRUL1ozYlFpblM4QVNRSFpZ?=
 =?utf-8?B?V21VbnhxSEdTcURFOTVpUU5oakJBSlJybjlzVndPeDJtT0ZTZi9YWnZ6RUcx?=
 =?utf-8?B?djZwY2ZEajl4ak5aSzRqUzNRejA0SThXZGFuaUNpVVdxTXFTVEhtWmd6c05n?=
 =?utf-8?B?bGR0bUVVNkZ6SFk2cnZqd0FpODZYK1JwYXdjUWhpSHhLYnJKUkVQL1VHNVMv?=
 =?utf-8?B?MzcwaWNOR2ZqaEl6UnY5cHhyc2RJK2hZK3d4c2VGcVBMR1VGbHYyaEhFQlpD?=
 =?utf-8?B?eDArZzd4dnFtNDRsK0Y2RGxIYUd1ZUJ6Y1cwYWRQQVhnbHNyWGNzRkxWSU1V?=
 =?utf-8?B?b2xMWFQ0bXVUeUVacjNieVYzUU11N0tvU0V1dWlGbExVUDJJb2ZMcUZRbGdU?=
 =?utf-8?B?TnVqT3dRT2lJTGZYbFREZ0I0QUhmSTlpMEpiTUQ1VVhiSGpOdHNPd2JlVVU3?=
 =?utf-8?B?MlIxdUdoTThZSG9tWC9tKzBKRzZHV2RoMGlxMTdRYmk0Q1FJekhROE9Lbzc3?=
 =?utf-8?B?WW16SVkvckt1MVpiNzBDbXVSS2tWN25ualAzRFJSbmJYNWdOeXpwYU92VFQy?=
 =?utf-8?B?V0Z4Q1ZJWjFES21xS3c0TTRnaWl2VFVoZk1Ob3E1b1FoclJNTzlMY3VXQjRt?=
 =?utf-8?B?cnBUd1YyZTI1MzFqWjNNZ04rdkVpZzdnR1N1b3FzZlBSSStEeGhXaGVzeG53?=
 =?utf-8?Q?bZRlPsC5pnZ47Lm+Z+QR3LEuY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6ec284-78d0-490b-d795-08de12068cf6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:34:08.0464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrK2OUbHJ+1SRcZkA/mhCqD7B2VasNlVMVWgtQkUrydXNUS9TVV0hLi4pudTCXygGN9KDm4uld6p+9fkMUgT2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7737
X-Mailman-Approved-At: Thu, 23 Oct 2025 09:57:06 +0200
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


On Fri, 17 Oct 2025 20:54:05 +0530, Kaustabh Chakraborty wrote:
> This patch series aims to add support for eMMC and SD-Card in Exynos
> 7870 devices. This brings changes to the core DW-MMC code, and the
> Exynos-specific driver as well, introducing HS and UHS mode support,
> and changes in SD init sequences.
> 
> 

Applied to mmc/next, thanks!

[1/9] mmc: dw_mmc: export dwmci_send_cmd() and dwmci_set_ios()
      commit: ef3b16bb8e731c93bb6d50c57c6d315486936d91
[2/9] mmc: dw_mmc: do not skip dwmci_setup_bus() for same non-zero clock frequency
      commit: 4a0f11d4bd9b01aef6244e234b0ac4f9cb39acc0
[3/9] mmc: dw_mmc: properly address command completion in dwmci_control_clken()
      commit: 8153127fac1ddafebdaf58f14a76b3ee9362bc22
[4/9] mmc: dw_mmc: add voltage switch command flag
      commit: 1e5db3b82828d1a32d247f339c9aa1d09d52d35e
[5/9] mmc: dw_mmc: return error for invalid voltage setting
      commit: 8acf595bcd8e411936da0b12461d281c8d26805c
[6/9] mmc: enable/disable VQMMC regulator only during MMC power cycle
      commit: 5f0d548db8a600c095ae8b19f4b9920dc18a3442
[7/9] mmc: exynos_dw_mmc: add support for MMC HS200 and HS400 modes
      commit: eda4bd29929c892706627937c88676972f992471
[8/9] mmc: exynos_dw_mmc: add support for SD UHS mode
      commit: d9020897f6d06191f3c126b1988316ad479eb98a
[9/9] mmc: exynos_dw_mmc: add compatible for exynos7870-dw-mshc-smu
      commit: 3cbc9f0e0af744db339375d7a103d366ea70cb20

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
