Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3894ACD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 01:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD85083DA6;
	Mon, 25 May 2026 03:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T41s/UIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C7CA83DA6; Mon, 25 May 2026 03:53:02 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 364A28039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcnQdjRB7YI3sazhifscQu5aWKBoLIcbSHN8VXVMG5H+Y5qye0HvJAnp3c8aSrjOvj6lwvANtGp9RPzeKaUUJNA6qGmT3LfoUMkbET5yyOqUZQ51w3E4PLZd9HhEdQkTtwQ6yrvIyyCa2ZVHaF4HVm0maXXB46y+RwFdG9A1pfgob2kOPxy7Uqy/Emt4+PVWLkpxJVImFuN072sg7ljwbE0mN0q2HYoVxl9BtsCv84d8dXqIfpHAW0G7IEqgwbCn3NE7O91spk2nOvT+7BOhB/4TnH32fZG1i3spLSFI1KWv+jwTscLpEJV1E4r+QHuHOo1iSQAq4/0d9bWxGKngvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr1JJv6eoO9eu2Eq1qm9BdnrSLxA/LrFIuVQ56vXSoE=;
 b=LIqM/fuPmsJljYP4N78vS+o0724fPaQn76DlUWYoxPsnRN0F6E6/dglQk50WV7uREuy9m49DrFhVYpTnaMv6vDSO7wIOU3NyY0pMQCwLNkKFhOdPIk06+SOJQ+zAKCT5UCL8G+hQjRNfTS0QlKfs/iS5MqYUmDiQY8HVSQ1RAjOvbiYDJNewATKJRrOtjeFiVx9VRvzMXfPEg56NowAXyI3Za4If7jx0yFT7q4GeyAATaVmAui2v+Bcb8K+ulJkklRSxti2QKYdf6p3CFCJgUkM9Q7q3TJapbd+kPT/j1C+mf4VCorZ1kn3r3ISN9gWgSH+6WZW8UzDntesgW3MDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr1JJv6eoO9eu2Eq1qm9BdnrSLxA/LrFIuVQ56vXSoE=;
 b=T41s/UImPHxnK0R50ZAn40FhEPyoRgkFZq4XVFcKeCkjChOpL5Ux7iU1ObWQvyU1zs5m/tNin7ceOrtOt5aJDnoBCMw7ogpniP68qOdEbkjAM28Q/CJeWZYX7DAzpRPzCYH1HYvUoOfidYZvtyvc9f7eLm5WmINOlKxcvVuB11fM8AAZFNd1j55gHilX8fJG1IPrU0a7igW634orylThaSsvm8S5/kanzq5zwcaSp3Voz6X9sv40dNvvIZbjsQDdNr1rwjxdT7Luee18gv+E7wrJRNvqIySH12jTRhAgo1OLfVo/FPQ0OTy41Lsv6V2C1l6bl+n0pp1+ZL0OJ+UjFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10466.eurprd04.prod.outlook.com (2603:10a6:102:450::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 01:52:56 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 01:52:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 25 May 2026 11:09:39 +0800
Subject: [PATCH] dm: core: use DT region size when mapping device addresses
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-core-v1-1-18ed41193b4f@nxp.com>
X-B4-Tracking: v=1; b=H4sIAHK9E2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNT3eT8olRdC0tzI0NjQ0MLI5NEJaDSgqLUtMwKsDHRsbW1AA/7xFV
 WAAAA
X-Change-ID: 20260525-core-89721311824a
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0254.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::19) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10466:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f93c9b-b6b3-42a4-3dbc-08deba00578a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|18002099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: OcagYuhy2PKdla5B0PAVCojUlt3/TVbav/8U65tNn29GA+CV2/zDJOfWsH0yzCwP5CPfUeEs9NCjPb6S5b6CB8d7a1W74xZFOIBPGTJNLWzJ0lOP9Lc3lxUvuPWR6sovqb5mngx7/cEAqDtF/qdTeDCmgGDTthPyGLigql2nNdgKn9n6cmNe1W4zB/RGd+Qu6r37DBBY1oa2PWcMvQ0hTiOSTOv1Ia66Qz2UwG1BVJfsQvHeh8DSb467rAEzLZMzZ7neuWoRdm7+0hiLZStF11WLchW2ZahXjbuHGkvuQXhol2PuPoU3s7L2YBLKDx+WVeISbzAlqkycqpRBbIThrasjdpXXtChJi+1HEdl7rdWPwuqsPBKMfqCyGl3VKv4uUDAgDQTUOeJ9MMUfozMIRkp9oGJep+38PsQIDtyvH/seXJk1CNE7sropGJI51EzRG0DgEx4P49jn9Pn63oNFk8nPSeoL0D8VjLUiLQQ3d/+yE6iL77kc9pRBKXyc7dUi5dWMeUYKpouG6Oh27tGD4ZqlrA+89T2z5cGU6JK4v9/TmEHsGmEPI21zOB1r+R2TuwQiT0pShJmsmI7Tiau/6D9eJqoFOdkJG3FkWchm8E1er7bYnKx2g8bkpL341ZTm5Tl/r8N6TjUDwAsDnW26TsLg1lgqTi3AN5RFPVFLfR9LPttlPL7gXVR+xU21iBKuYdsOUqTydx7T1RB7bDDNhKz3WeMfhX3Gc8YQU4J03zX7VTsr0kw2chVUgOfDO4PM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(18002099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGl4U1kvV0Y5cWdTL0kwMUVZb0NVOEkwdFZlSzk4V0N2eWpEalUwb0F0dThw?=
 =?utf-8?B?Tzd4OTNvYmlxNlcxbnlqR2xES1daWk1UODBTekYrL2pLeWtRd0tXR0ZuMVkz?=
 =?utf-8?B?VkVmbkcrdVE4Z3hIR1lGUnBBNm9Oamo5c1hOeEFmZVA3SVRKN1lnQXFyQmZC?=
 =?utf-8?B?OWhwNFVOSzg3MVF2K2U3UUhLb1FPVE4rSmg0WW1kNk9ZTDJrVmhMUmVpWm9S?=
 =?utf-8?B?Q1gvRzlFTEFmRXlkcXk1MVZCN2FQenYzT1VQQkdJdklvYnU1aVQvOEo1ckY5?=
 =?utf-8?B?K2NXTWU2YVNWRGFjVEtYR0o0OEI0Z2FBcHFtZmxzTTNqZ2hjYS9xNjNqa0RK?=
 =?utf-8?B?RGtxYVdHemd0bnRjdlRRQ2NQWG1aN0R5UTZDVWtOUDFpancvaGx3TkFQMTFo?=
 =?utf-8?B?djZPV0lqT3FxWVB0N1lUTWU1R3BGTFBVUFZ3b1paWXN6QTB1ekNyOHNjWThk?=
 =?utf-8?B?QUlKQlBWaEZxMFBPSktIemw3cXI3Mzl4dGZBNEE5YnRSZXd3YVZZT2Y5ZVk0?=
 =?utf-8?B?ZStIYU1DOVFKaGRzMEw3SmppcC9Xbm94UW1KdDRvU3Z1a3NkVVlzNnNHdXla?=
 =?utf-8?B?bWR5T0IzNmxtUUs4cDVxMmJwaUd6ajhNUDA5MGdQdmgwV2FNcmJ1QXh0OERR?=
 =?utf-8?B?R3I2VFgyOVdZRFpHbjM3cmVmOXdYV0NGYkdLTklJK1hkUFdscDR3emdwS1du?=
 =?utf-8?B?UXFDd1FpcnpKYk11MlczSUprQ0NvZm5CcHh4d1JDWjlkSzhqa0hGVmNUZFVm?=
 =?utf-8?B?dWlqSTM2czRVbU1rZ1l2VWFDL2tnY0EwNDVQY1JIRWdlb0hUTDZZMDJ2QlB1?=
 =?utf-8?B?ZUp5Qkg0N2VSZFdBWXZHSHpYV0hOcHhoZHJrYURjd0drUCsyMVpUUXUxZ1dY?=
 =?utf-8?B?WUw3SGdmQmtMTURpV0NGaEd0Tkt3K0tEemYrbTR1MHVKUXhMQjVCNW5hQ0sw?=
 =?utf-8?B?c2RGR2h2TkZIMDNrMVBuUWdHM1FHZDlVY3RyZzFPa2Z0NnJlNFJRVFhjRTBJ?=
 =?utf-8?B?MjRtLzBYdUpWWVlzYzFqcXlPbGJjOXFveDdURlhvV1Z3QzA0bUUxUXZPU1Nn?=
 =?utf-8?B?Vm55MGVBdk9FcUlnTmtPWDZ4allvUU1WdncwaVl2Y1JlT3pDeDVSZ0lpN0gv?=
 =?utf-8?B?ODV4azI0K0ZtVTVGVExoa09pOHNKbk51SUtzV0FvQTdWeXRSSFo2MHJTTEVS?=
 =?utf-8?B?ZUNLV3l5NWdOYmRIM3NOVmVNbzA4QkdTSVAzbGd1WXpxZC9jL1dWaXFTZ2V3?=
 =?utf-8?B?eVZtTHR2Q3dOUm1HM25hV0VoaUV5ejdUa3kzMVN2SXJXVDJQTGFVSlBad0Ja?=
 =?utf-8?B?SGl6dnUxZisrYTdxajI0ZkxFbWI5MmN1VFRnaG1VSUoxdk9CR3JjbEJ6Zkdu?=
 =?utf-8?B?R05SVExqYTR3RjlSbDc1aWVZbHZHdXhOdTdjb3hlS2pLRkFMU3ptVnpVdmQz?=
 =?utf-8?B?aDBqK21kTWgwS0JmeWxEWmtxYkcrd1MzQmN4YTdHZkNxZ0cxT0hsZHIySWU4?=
 =?utf-8?B?N3puL0EvdXJPdVBldHBTRUE1OXJNOVdQQ1kvUVJadWpteEN5SWZXeVRTcXNI?=
 =?utf-8?B?aDRNcU14NzRDSFJaVUJBeWlaNmpjMVZiUHY0RG5vb1JSNGQ5QUdXR0NyNFFJ?=
 =?utf-8?B?cnh0dkc5SXllNHovUzZFNlBGNzlmV0Zwc3poeTRoYmdFQlRhTXdqMkRwZk1j?=
 =?utf-8?B?c3MzZWFEdXBtZGw4anN6WWtpMnhqZUEwRndMTGR0Sno4eENqWm13ZUhMRjR3?=
 =?utf-8?B?c3B1dUZHNmRldzJuNjNqV21TeXhZRU5CQ3AxdWUvUGVDNEFYdG1hbTVzR1lP?=
 =?utf-8?B?WEFNZE5IbEFlUFV1SGlSYmJiaS84bHEvZWNOalVzQllnOVZPbWl3cEFoRnhF?=
 =?utf-8?B?MmNJa044YUxqbFlMZTBOODJndHlydFc4cFdwckFPSFJyUFhTdGJ4NXREY3JT?=
 =?utf-8?B?aU1mVXc4KzdFTWw0R3Bwd3pqZ1ZRVlVNaitQb0txcktoa3J3Q2ZEeUl3S2R0?=
 =?utf-8?B?NW01RHJEL1VaRjNpWGZRRHhSVG96ZVp4ZzBKYmNjWWpPUllEWEtaR0l4U0ll?=
 =?utf-8?B?UmhFd2NRUlhwU2xOSmRDR1VDdCtQaWxwN2p3ZlFlVTJ0dUl4eWNxWmxYZ3U5?=
 =?utf-8?B?dzcxczVhQmZrSndpbzRndm1yRkpvTHhUa2JMNTh2bWVVZVJXTkV0TXhXZFNV?=
 =?utf-8?B?QWdQa0xsOGk3bVlMSjJGakNCWmhYdkNuOUg3Rnh4M3dZZC9WZ3Z2bWh3R21q?=
 =?utf-8?B?NDVOUzJ5Z0lndmRISy8wNEZFUHo2cTZ1WGwvTXkrS2VSbUw0eitJSzBHSGxr?=
 =?utf-8?B?T3p5ZVpHM3hNNkVJR09EUGVsRzE5clNES0hCb0l6MEZhNXVtVFpNZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f93c9b-b6b3-42a4-3dbc-08deba00578a
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 01:52:56.5561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLnu5IQvn9fJ+mOs/EWgkRvo77Q+VOa1w5qyfqjwtU6cDQDHz/CLsxROwlPlw27VCPOnsCMvUvX7Rt6U+aPggQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10466
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

Update dev_read_addr_*_ptr() and dev_remap_addr_*() helpers to use
dev_read_addr_size_*() and pass the DT-provided region size to
map_sysmem() / map_physmem() instead of 0.

Ensure mappings are consistent with the size defined in the device tree
and avoids implicit or unbounded mappings. When the DT does not provide
a size, the behavior remains unchanged since size is initialized to 0.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/core/read.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/core/read.c b/drivers/core/read.c
index c0d7a969db2..ba48862f44b 100644
--- a/drivers/core/read.c
+++ b/drivers/core/read.c
@@ -132,12 +132,14 @@ fdt_addr_t dev_read_addr_index(const struct udevice *dev, int index)
 
 void *dev_read_addr_index_ptr(const struct udevice *dev, int index)
 {
-	fdt_addr_t addr = dev_read_addr_index(dev, index);
+	fdt_addr_t addr;
+	fdt_size_t size = 0;
 
+	addr = dev_read_addr_size_index(dev, index, &size);
 	if (addr == FDT_ADDR_T_NONE)
 		return NULL;
 
-	return map_sysmem(addr, 0);
+	return map_sysmem(addr, size);
 }
 
 fdt_addr_t dev_read_addr_size_index(const struct udevice *dev, int index,
@@ -157,17 +159,19 @@ void *dev_read_addr_size_index_ptr(const struct udevice *dev, int index,
 	if (addr == FDT_ADDR_T_NONE)
 		return NULL;
 
-	return map_sysmem(addr, 0);
+	return map_sysmem(addr, *size);
 }
 
 void *dev_remap_addr_index(const struct udevice *dev, int index)
 {
-	fdt_addr_t addr = dev_read_addr_index(dev, index);
+	fdt_addr_t addr;
+	fdt_size_t size = 0;
 
+	addr = dev_read_addr_size_index(dev, index, &size);
 	if (addr == FDT_ADDR_T_NONE)
 		return NULL;
 
-	return map_physmem(addr, 0, MAP_NOCACHE);
+	return map_physmem(addr, size, MAP_NOCACHE);
 }
 
 fdt_addr_t dev_read_addr_name(const struct udevice *dev, const char *name)
@@ -182,12 +186,14 @@ fdt_addr_t dev_read_addr_name(const struct udevice *dev, const char *name)
 
 void *dev_read_addr_name_ptr(const struct udevice *dev, const char *name)
 {
-	fdt_addr_t addr = dev_read_addr_name(dev, name);
+	fdt_addr_t addr;
+	fdt_size_t size = 0;
 
+	addr = dev_read_addr_size_name(dev, name, &size);
 	if (addr == FDT_ADDR_T_NONE)
 		return NULL;
 
-	return map_sysmem(addr, 0);
+	return map_sysmem(addr, size);
 }
 
 fdt_addr_t dev_read_addr_size_name(const struct udevice *dev, const char *name,
@@ -209,17 +215,19 @@ void *dev_read_addr_size_name_ptr(const struct udevice *dev, const char *name,
 	if (addr == FDT_ADDR_T_NONE)
 		return NULL;
 
-	return map_sysmem(addr, 0);
+	return map_sysmem(addr, *size);
 }
 
 void *dev_remap_addr_name(const struct udevice *dev, const char *name)
 {
-	fdt_addr_t addr = dev_read_addr_name(dev, name);
+	fdt_addr_t addr;
+	fdt_size_t size = 0;
 
+	addr = dev_read_addr_size_name(dev, name, &size);
 	if (addr == FDT_ADDR_T_NONE)
 		return NULL;
 
-	return map_physmem(addr, 0, MAP_NOCACHE);
+	return map_physmem(addr, size, MAP_NOCACHE);
 }
 
 fdt_addr_t dev_read_addr(const struct udevice *dev)
@@ -229,12 +237,14 @@ fdt_addr_t dev_read_addr(const struct udevice *dev)
 
 void *dev_read_addr_ptr(const struct udevice *dev)
 {
-	fdt_addr_t addr = dev_read_addr(dev);
+	fdt_addr_t addr;
+	fdt_size_t size = 0;
 
+	addr = dev_read_addr_size(dev, &size);
 	if (addr == FDT_ADDR_T_NONE)
 		return NULL;
 
-	return map_sysmem(addr, 0);
+	return map_sysmem(addr, size);
 }
 
 void *dev_remap_addr(const struct udevice *dev)

---
base-commit: bb354d04459f5425318aeb8a70bae995ee573f1d
change-id: 20260525-core-89721311824a

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

