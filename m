Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575CAF99C79
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 11:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C548425F;
	Sat, 18 Apr 2026 13:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Lliy7FYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5F784214; Sat, 18 Apr 2026 13:21:11 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A1F83B99
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 13:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xozyFKnyxvOKKiBWbA8xIiT1rkmf5F2nmOfUjHQZeo/RguGX6Os/C6TXwUbA1B/wh6M3TcW/lHJt7Y7fbhxg16+eTOX+rRCbRikZjlDMXk7vcUy44Od1sd7WBQHWIH4KH2j1c2qNdonKY5Ybeda+O506wjAVvmCyu+R1wFA4F3UkmIKZ5sO3TDJsqRv/5KMXcVW4CDFmgvV5Lgu75yLkcvHDN6Bitj2udV5MZz/OY8+vsOObibn7GX/jFMK5W60CX8EGW9amSpHN14UA3MmNQTU42HvBhAFCyfAn0XvFX6b4aMe72+WwfIeA+8fi9PbdQMgit0agAJcXWbbxLv7SSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZxa+JPk7oHy8U0ItCEP/dpP/kDrrJRjn+3RWZdJGuE=;
 b=nngFjicg+o3fGlLMHuJrRH7SzEAalReA83VbyEPOtoW+rSR5e2Zo/1IapDyLqLOu15Suol1BwfVuVy+v556MnFcMhNjQlHxHv+sy9/kugp0Q7IJMCv0rqGsuSvDczdjRWEMNSpwoe9kVICyUPb+qEjsjNS1F9HWEDbhkkBIk4XSEcZoEwijkHOvzex5+b9EJXL8P/zO/rtPW+ZDDnwJflL/WHkznGHbjdnSWfBkZGX/Efznjw1dHNECqAuUBcmpaN4oCdYQTtf2st16dOgxXmuJpavRaHUCJb7xBOeZ2vrVt6duQX9RBKYEdmvRyUA3UNx1Bf5zOIEwUROgS1otiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZxa+JPk7oHy8U0ItCEP/dpP/kDrrJRjn+3RWZdJGuE=;
 b=Lliy7FYdQ1lV5PQH3vJxa8EW8mipujPTtn5JJ2KaJOfWSBtvyiCunqHuqgL3gth/efa5HB8ERKe+lmrs6T8QEtQY67FyhrEBWxM9D70k+2R2grW2a1+SwHlh5mUOz5zR5Zw4jf78l2tAL/Rc0WaXxXG7ij2J9nZ0ePmnbpIeCYX1Roi0UudmJuoqQgBh7RAf2OfmngucUmau4hsgTggo6zzV0/G+8DWH+LwJF6MPOOAQ8L3ccapcud6j9oIUpMxMFyRiM7It/6j0s2Lz0xnl4ZCxzmZlffExaUloQJq1kiZ/OXUhvc3zReRT2YCNdyKNe8U3SyKAXjWdsdc76nx4yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10756.eurprd04.prod.outlook.com (2603:10a6:150:226::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Sat, 18 Apr
 2026 11:21:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.023; Sat, 18 Apr 2026
 11:21:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/4] power: regulator: various fix for pfuze100
Date: Sat, 18 Apr 2026 20:37:31 +0800
Message-Id: <20260418-pfuze100-v1-0-80d2a96dd927@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAt742kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0ML3YK00qpUQwMD3RQDgxTDtDQzCwtzMyWg8oKi1LTMCrBR0bG1tQB
 MB5YpWgAAAA==
X-Change-ID: 20260418-pfuze100-d00d1ff68876
To: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10756:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ad7105-c714-4cc6-44c3-08de9d3c944d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: aqiK603AIrAlNMXS4EwlNilzafEKHYOIFDc9eaUp2U7Z5bP1cEuSGGg4efR/4tIqDI+/HnpkB5OyFO3Yuliw0qsDHEeJ8S3lTnfCB+lVuBX6hvYW0ZlxZzfjpalY2nxleKNaFH6bn/BjacEMo6R3JzfKb1XBLpG8UyVQghXCsMcuQPVXLtjCriVOlhU4q7XEkcBQ3J9yLllJWX88sJm+pk3Fb7adQsXyMX0rEa5cBq5opE6pkgeRnz84vHKPPajDUBRqccEexTYCUolisjY4auHMNTMYPETt3twvD2eIYBdM/gVM3KU7v0h9XfDfVjjyhaiCYqgDyrW2VeFk8Sjtt+ZZK3H5fcyV1pr8pupnj3JXH2Bq3O0Rhg8b0UhxY0Lkjb2AwIRMW1GW/LltskblIcTH5l4ZGgoM98LJGlovBMJQzMedQyR9wrPTuv7BDt9QNKYx3Qb6eJZMmXOZyFyeyLGkIxy15p76fqZGlieg6nhADPleNatcVIWnaIwZYMRoqdp3QA3nEAJ4deWGYKg2HLumWEu6qPPqVwZOsNexB/YAaok7pd+DoH3KjjYgSqrmSkuAg8+znXfjx1jX9qMOVhNZwjLQPyhPRK2kDKftjjpwZccMGLESUQcDX4mxOJHBNpwxrVFmxcizfy9C+BJWlsElfn/14ECl/RPvbz761s4v7ixUypk7Mu86ldIZUO9j+VUKzTtWaz/6DpeSFmnS+wylppOZiZbE4QEBk/cLANasnbIvVVnsrdI56m54rRZU5D1fBzSMaydeQOkubdcANWJklKRTY1UF4oa+jv2hSbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTNJL2s1a3Q5N1NmSkFWL3BienRVei95NTdvYmVwQjhmbDNwbk5pVUdQYThq?=
 =?utf-8?B?U1Yva1k0WG5RVnUvd1JFbWtRR05ydjNNbXBqYUNLcnZiajNrcVA3cW00aTl1?=
 =?utf-8?B?dnJJdGxrRnZpajZMZkhkUzFlYWlGUjRFMVRSb3JpUWkzT0N3MTg4aGxmTS9H?=
 =?utf-8?B?N1hNRThCa0hTaGtxL0hUOHR3UnJpWWFodExmcU41TXRmcXVSMER4K3BMU1RQ?=
 =?utf-8?B?eHI2VXBSblNHaVNTWmUrMkZ5N3ZwdXUra25iWUNHcHNCR3k0Z2wwL3A2elRN?=
 =?utf-8?B?Z0JxUVU2RmNrUmJkVFJ2aTdTRmJydGk2NFNRV3U2QTNHd3AraDlUNEhYQ1JU?=
 =?utf-8?B?bHlDVkVEOVU3b0lDemZKNWhIRG5hS3FRSWNuMThGdll3V3VheDMyVEhmNlhq?=
 =?utf-8?B?ZnNldjkrSUpCM0NJNWxJUzZSU3NnMXFZWE9MZVpNbTBIcmU5OGloMGlaNVlL?=
 =?utf-8?B?cmJiYUZqbTAxQ3crVytDVElTUHNOSEJyOUlDa1FORXFQTlVTN0lIdDBCMWYw?=
 =?utf-8?B?QkNzb1BqSlpXcCszdDFEbWIzR3JZZmZnaUNGN1VvZ2pDVHUzeHB6djdpR1Ry?=
 =?utf-8?B?RlJ5Mkg0Q2kydVNwV1A1ZlV0ZCs2MnF3Z01YbkNveFFKRTN5dEV5TjVWMDFS?=
 =?utf-8?B?MHRrTzVOTWFYY2ZJcU9YRUIxdTBtMkt4RWF1a2kvc05YWjdtMTI2WVVSeTlu?=
 =?utf-8?B?N3RqeFdhYUVzcjZ1NmdFbllPOTZPeXJtMnFvQTcyazBvT2UyaGJyZm5sSDFB?=
 =?utf-8?B?MFMvQ3k1STNzU1hXYml4Ukh6THRQUlAwOVZ2Nkg0MU9Tc3VSZ1k2dW10R3JD?=
 =?utf-8?B?Q0xlbHBwbzZnVzRqRkFwSVNQMnZxN1dCN1A4d29pTG51QmZNdysyOXJNNnpZ?=
 =?utf-8?B?ZWx3NFFidFJjaHlkZEVaMUNUblkxVVpMMllOSlYyQUZGT0t4cXJrTWpndTVp?=
 =?utf-8?B?aVlQMDd6SVVKelQ3ai84OXZyeGhsNnNCNVdXRG16bnJWTDhrMFNKTktGRU5C?=
 =?utf-8?B?WjJUQ1RJZWJLN0JtOVlrZDM3cDdReDVvUXhhNC9jbVRyNXhsNEZJSTF1RXZt?=
 =?utf-8?B?Qms4NUczTWdoT0Y2QVptSmFyWWQyVkdmdXJ3cGF4QTgrRkFSbWk4NGVvSE16?=
 =?utf-8?B?d2VWMWNlL29lSmFpbEpySkkzb2F0bEVkY25FMXRRdE5RbkdPNVBwNUdqZFEv?=
 =?utf-8?B?VHBkeDZ2a0VpZHJYakUybngycDMvdVBKZ2tReGZ0ak9ndEhEMVRlTGFId2Za?=
 =?utf-8?B?SWFJMWUrV09OajN4SDJDUEx5R3FYaExkcVg0Q2IzU1lZM2d6TGtJNkZVTCtm?=
 =?utf-8?B?Z3RDSEVDYW9nandvTk9lcSs2RjArazBoTWxRNW9PbHd3YmZzMXByNlpiR0l4?=
 =?utf-8?B?SXlMUXRnZEZuWDNybGVPUjYvNFowZ1dYOTNxSWRETzFCZm8wdSs5bHIwbGxE?=
 =?utf-8?B?VWUyNEhhSlFPNjROYUtMK3ZzN2pHQnFnZWMvRnF5TjQ0VGU1Yk15THZEcGl6?=
 =?utf-8?B?MEY1VjVHZGVGeWlZUHh6N2FxRFZicTZjSkp0VCtSTlYzSnN5L2NEblprZjR0?=
 =?utf-8?B?bDliSGd2dlNLYnRmdzBnY2d2WEJqTXhRSFY1enB5MEE0ZVdsdnpmci9OaTRz?=
 =?utf-8?B?WVFwSWJrbTFuaG5SWWM4QzM3U252dXB5cEVVNUNtRzNxVUZ6QnZmZENBMS9K?=
 =?utf-8?B?RVV2elVwTjNKZkhGenBlTk9uUSttcnFIVWpWZW5zTjR4VFZ5bW85Rm9UdGRL?=
 =?utf-8?B?OXZpN3pGVGg1UFdtMjBYa1pzb0FmTm9JeVNHUGRlL00zVnpaMTZLVklsTXcy?=
 =?utf-8?B?eU1XNGM5aWNVL3pkQUJ4VVB0dXhZTHR6bTJoZmlramYwM3lWajB4bmlDMXRO?=
 =?utf-8?B?Ny8vOHhVcW9QM0JVM0o5eG9PU1RmekRMSHlLV0VHbnFBUEkreUZyODBLTTZs?=
 =?utf-8?B?RWJSeDZoZEt2SUY5NUVjZHgvM1h3S0dkdm5wdmJ2eFNyZFNCMU56VXMzVnpG?=
 =?utf-8?B?WXg2SFFKUlcycmNLSnBoVUg2Z2g2bTUvbUFWbUdtdW1laVV0clhmWks2dHlY?=
 =?utf-8?B?TEtOY3lEbDcyM2xnVkd4SzNoVDd4dVY2QVlBOXhqNGRac3dSaU1YWG92OStT?=
 =?utf-8?B?RU8rM0U0UXdXODhGSGhDdnl1UDNyQmpJYnBsNUhTamxnbkNOc0E4T1ZCa2NX?=
 =?utf-8?B?MWl6SWh0S0tOY0VWWkRnekNnKzU4bzdDeFJtWlVtb2p2cGIwSkk4WTM0V2ZQ?=
 =?utf-8?B?NHozQmMySTB6eTZPZXpUNEwrK0xHajRDWG9PKzluRGpyZG1qZTRoN3d1Nlh5?=
 =?utf-8?B?YUl4TlI2MnRUNEhtTlVzY3l4a20rWnM4cnBYMEdRdmdOL0VNYUtkdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ad7105-c714-4cc6-44c3-08de9d3c944d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 11:21:04.7041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/t3V+MuLXK0yiwEMrrdsfOYwKvR20IEogiE3PPPQ3GZErVYvno76VLCm5wpIo38GmmgiB53XRKwNTW+P2iLBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10756
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

The min_uV usage of pfuze100 is wrong, it should not take the min
voltage from dts as base for the calculation.
pfuze100 supports high voltage mode, but current driver not support it,
add it.
pfuze100 supports single/dual phase mode, but current driver not support
it, add it.
Correct the Makefile for the driver, there is one Kconfig entry for it,
but never been used.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (4):
      power: regulator: pfuze100: Fix min_uV usage
      power: regulator: pfuze100: support high output voltage mode
      power: regulator: pfuze100: support non-independent mode
      power: regulator: Correct Kconfig for PFUZE100

 drivers/power/regulator/Kconfig    |  10 +++
 drivers/power/regulator/Makefile   |   2 +-
 drivers/power/regulator/pfuze100.c | 164 +++++++++++++++++++++++++++----------
 3 files changed, 133 insertions(+), 43 deletions(-)
---
base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
change-id: 20260418-pfuze100-d00d1ff68876

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

