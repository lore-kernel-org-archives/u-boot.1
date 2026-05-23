Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413B6CD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 787D384911;
	Sat, 23 May 2026 14:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s3MwqdJF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B949284881; Sat, 23 May 2026 14:23:27 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE34D848E3
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGkMMFNwLLZo0v74KiVXA23Dw4E5KZmOxdoVPPXBfva9MKMjz7qvzVjRp2SKDBcVoMNQeArrZM51iQ5/5+etC0tsKHGyUgmhAY0zR1j/flXJwnZ9QPQdqJ+DP91XBKzL72Wp2BhyNf+v0tqsjR6+D+UFrD0/8x45jNnwfBuQQ0uz70uHXqRrUhJ7/Wjjsto7qdiZ6HqWu1vYlPO1+ctf60Qm5riqe9mBloAq5nbBUIg/oeYijUbP+zUuEzTIlAOruxQaEfyio5/ykLSosKyttbwr/yi6V6Xy8KjTz3Xcm0D3R8d4WSAMM7SjUzS4UUm6n4ZVyFejj69LseVl2ZhS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGVlSv6QlyQkrdP4bFcTRama9WgjrhInOsBhZygcx5c=;
 b=O1znmjjCKXHQgNmC248B0kut23olM3A4J2HAxw0boSHUkDG/o5Be2jA+0MgS2HvsuK3m6UOe91cPvZm4OuGrJJHP/xlOPkwvbUvZb+EO+2NJAM0BjMlCzKTwYwuOgl0wY8/xrGXIcrCJQpARJApYbWQQpuxZsYCzsghFboZkVqrvbHQC4iwG1lSSvHiQHz96qZjc9uenmauF+g2QtOYB8GRRF03gA8No04a6eqC5jO+xSNB/G7LMGnR79St0e1ukgD8imwc3MUtISJ4vknFr+NQ/lZZ3rCoJOiCwOBagSh2D0259rQraipHBEsPSt3c5idnM5Acsr7VbcNRlkkm7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGVlSv6QlyQkrdP4bFcTRama9WgjrhInOsBhZygcx5c=;
 b=s3MwqdJF+Sj30j19WqikPNiAJ/QZBsyU5V0jn9mlQhuFZKgG8wgJBsUbymz/P7Hnhdg8lWdLvtli2CNw5ME+hJ9gquNH5NOSuXxZlVR4v0f4z8bijD/Sl3k/IXzWmzNaaFFaarF3/AT9W0IMzYlCKGUdJMwACHqUGtauVMexahKOxFGnDCpXSEj3LKvh/Uu61rrs4s+sphLO2EoAUkBsygUIjDs3ep0mF6JYwA89C2wOduap3iGq/Dz5YDBREj3I/VOOG+NTgjKKOc97u4vafcc3ofkwgj7XCloglNnEUrR/THBOBooUfs93T/u+2uKDI075nNq5o9/HmbGDezsAJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GVXPR04MB10851.eurprd04.prod.outlook.com (2603:10a6:150:21e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:19 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 May 2026 21:39:51 +0800
Subject: [PATCH 08/13] serial: lpuart: Use livetree API for fdt access
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-imx-misc-v1-8-2898c9eca9f8@nxp.com>
References: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
In-Reply-To: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GVXPR04MB10851:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d9e39c-ec5d-4657-b70b-08deb8c612f9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: sfqSXXHqj9DtTKR/W9vaUU+Q9v9L5DLfMqPvllI32rKQBVPUWzWgubB1+bmWbM1mR8FQ3NH0h+6ww+YdFb+26YsLiTIQwSd29a90pzQEbh/2EWTJiNFjM/PMeMgbWuLQ7xBmg7ZNN2/lcS3Byr8v4AG9+PuPW/kooY0+p8ZyFgjA62BqjgMCTe/5I9oE7QVw3G6lfvCPFcNvV8w2D+BM9JN12hhiP+sZxIlL3z4y4iZn/3sEUsYepGy+GQBdMr7uIuixjm5fyZEB1JRN0jx46poEADFUIQQDWN2jsO0kqnYYrU7LLnKF8XxqMQTBvaCN3zBWWty10AqaCFt0+3nhWhKtxujO4aYIBDG48WZWX1TxajsIzDInDV2wa7X7ijdz7vCZuFsDKe30rAH3E3CchIZus9jGCU7+4E64jmsr1RKeh5wS/bsDvkk47k9vHqJ7c1pHkXfGWPE/HDfYT0hH9lu/aiyeG9loidj5FfkzCUJ0zLvmXIVvVYNR3g+YI8WL53Voj4QvITg9rBKnSeLolPzXSpkb2+c/xUKz87t3wh+pAET/w5dUoJDdeCVAtLdsmqvcSNaFE6+ML6hrTwDAylqCHO5fPjrYuzHvKpeWicblEN7x7C1TJqwRX3Wc2jmA8R8tqchjLmPcMu7rLc6AaOVole8fqQTG9a9hyTMiGTn6L/9YI/5mH04K+7zaTmbOL+wHRefyHSc4aZFa4eLMsw8Mtl/lloPA/Tw2lMCegfqYNPvNE/kGxLI4MoO16MDh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c28ybnNwVm1VdkpDMUVHVnQ2NWlRVjNuSXR6Ty9JTDJqRFpEaEhNV3RHeUZO?=
 =?utf-8?B?MlNsZ085QUlwblEyWVRsMURCSW9XQkZFY2FqNEV5K0oxWjZkWjVtWFdzeUtG?=
 =?utf-8?B?bWhKelQwUm4wenVVNnArNnd1TCtTdjJ4czd3cmdjcmF3WXdqTnpCYzRyeE1J?=
 =?utf-8?B?VHZ3MXJRaUJyczRJbnk4ZEtmUzFUV2hiRlJaRFA1cS9SOWo4UEU3Y3paL2NM?=
 =?utf-8?B?VWZsMHlZcDU3SjJ6Q21jSnZFeDUrdDAvbFNjMXhKdzRVbmJ3ZXhYZXo2blQr?=
 =?utf-8?B?dU5kakRjRkc0OTAvUmJUNy9lVU9KR1BxbW5JYkEzZ1d5eG5HTDNyVHlaM1lm?=
 =?utf-8?B?NHR2TFdZK01nNlR5RnZjNzlkWndiSDAveVl1endvS3MyNGZCSnhMMGlWcXY2?=
 =?utf-8?B?Wk1idlNBZGt2aEJYR1UzVjFLVDlvbUxDK2labmhsRWRkM1B5b1gwOHp5OEM3?=
 =?utf-8?B?azBpWDFMZUdyWFU5U1crNXRqTFRQQWtQcVpvSS80VmJ1UTBTRG9KY2lPNW9S?=
 =?utf-8?B?LzRQMks2V0lBeVNwTTdiRTdrYXFNZW9aSVQ1VmFUV0R1c0NSc1REZ2tYV1B0?=
 =?utf-8?B?aEFkZWY0MW0yc0lPcTVVTkF4U2pKRXpCR0hVOVhTc2I0NmFwNm5adGpUWEZl?=
 =?utf-8?B?VlhrU3V5MGN0SWFvVldlT0YrWi9kOEhBMUZ4YzAzWUVPaXl4bUhKWFlRZHRR?=
 =?utf-8?B?NlB2TXdTYzIzVVl2MXIxT29lMmtOUzFiQ0gyMW9wcmlNdzBMYVhtaGRUb0J2?=
 =?utf-8?B?bDFDcEw4R3dWQUJqMllYTW1NbkFEeVNSb1JTTEtOc3dmSUordGtTbkROWm93?=
 =?utf-8?B?VzBSNk4yOGlqSFVUTTYvK2FkcHZmRjYvckJ2TUhYWmR2RFBsblUzTDFvL3hY?=
 =?utf-8?B?aFBiT3Bvbmd0T0Uya0E4VitPdEdBSXp4cmFLdFNnWXVGWDhldVNKVjRlWEpT?=
 =?utf-8?B?SEEzVFBGdTlCRXI5VlIzdVdZK0toeGFpSDhkUGZQbmtQdDJSOXREeHZHZGxR?=
 =?utf-8?B?bXp5K0VTSjVQVXk4SUREa0JZV3ArRDNhR1UwdzZzV3lqdm0rUnJabUJtYTcx?=
 =?utf-8?B?NUxyc2czd0UyR1JYNVA5WC9VUmxJMDlLZlV4T2FhZ0pHTmpBc0VpZHFJVzgr?=
 =?utf-8?B?VkhLTlFPRisrdjNPbkxLVUtoUFVHK2xDM2lZUTF4eS9EU2tMVEt1YXV3azZj?=
 =?utf-8?B?ZXN6ZzlEbHlLRVJjeGl3N2J4NStvQlFrUEtONVhpamFYTmNaZVpoclZqUXlK?=
 =?utf-8?B?a0FlMXc2OXJiL0JYNTRkU3VtMHliTDBTalhBbXlHeHdiNUZYcTlqdXBqN2Ir?=
 =?utf-8?B?bnMzS2x6WTJYdlBqMkN0UTF0M1dXd1BqUkZNdksxM2pxTXdjKzNtenFhcnpN?=
 =?utf-8?B?Y1MwTFVQWDlNeGt5akp0dWp2L05Kc29ReWJBOEJhZ0VoaEpkbmNFaFlXdGJC?=
 =?utf-8?B?NmNtRmF5TlVCSzUyMVNPdFpTcCswbm4xZFNPN2RKdmhVRElGRE9HUlp0UFhU?=
 =?utf-8?B?OE9hajVjM095L3c1ancyZmx3ZFFjYzJEZGNzM3NNK1RvM1NSSTNZTFN5cURG?=
 =?utf-8?B?aFpXV2Y0bWE1NHBCb1NPZDNwLzlydnNXR1puUEszOHVaMEFsN2JObHNEd1Z0?=
 =?utf-8?B?QVVCRlBOdVg2UTYrYlIvUDhYb2EzSTZ5bTFEekFZdm9KUGlPQ2lSVmpkbllM?=
 =?utf-8?B?Ykt3R3lwZUovcitZR2t5bDNUYzdBeDBqeXF4a3RqM2RhdXV1dGNSR1FLT1pB?=
 =?utf-8?B?U3g3M1haR25wZ0hvWllPd3RwdkFVVUlleTlxQlhLcXcwVEJtejBXck5CUmNU?=
 =?utf-8?B?M3ZWNUlmN3RDR1dWMmY2aHVmWnB0S1htVzZRSVJUR2FJTm1kNDAvZVFvOG82?=
 =?utf-8?B?OVI1RmJqenlMM21sc0luZVA3OHpJUTVHSWRWNUQvZ2hWVTVYeVJJZkNZM3RK?=
 =?utf-8?B?MTZUaThScHErZkRJN0FDNHNsNTlrbFhnMGxnT2NpYU9FUktTT1pIU0VNbE9K?=
 =?utf-8?B?bVZzc05md09XWHA4MGJYMWU4NDFsQ3MyZ0VCYk04WlZZWkhaRW9nWG5xWUJq?=
 =?utf-8?B?U2VNWk83TFN5UkxKV1JTRGowWGFYSUlmQldESWZkNWtyNDdWQXlZQkVubjFy?=
 =?utf-8?B?VlMvenBTTXZTZEwzM1d2U1dhb1lZd3hhdXZVK2sxMXE3Yjd3RGNmY3diMWpC?=
 =?utf-8?B?VWM0ekFEcUVZb2lQSUNtZXYvb1lLVGFCclVOSFo1cWN5ZUJWTk1KbmxXRERy?=
 =?utf-8?B?Tk9iMDRpdzVEd3dXa3dPNjQrWG1idUJUV2Z2Q0FITU9Bc2M2OTJ0V1RiUWFE?=
 =?utf-8?B?dCtGWTNBRXR6NTVsaU1LYzd3K0h6dFd0Q2duWEQ5aFB3aCt1U1lQdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d9e39c-ec5d-4657-b70b-08deb8c612f9
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:19.5169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyjBIw0hit3lAkcClF3WpzsifP+IAXOx7bUrbNEM5uGbR1OTqIHEXJN19D7hfrntXQNIWuqoFnmPzl1Ot1GiZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10851
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

Use livetree API, otherwise driver will fail to read properties
from the device tree when OF_LIVE is enabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/serial/serial_lpuart.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index 9fdb6503085..e96e344fe12 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -523,8 +523,7 @@ static int lpuart_serial_probe(struct udevice *dev)
 static int lpuart_serial_of_to_plat(struct udevice *dev)
 {
 	struct lpuart_serial_plat *plat = dev_get_plat(dev);
-	const void *blob = gd->fdt_blob;
-	int node = dev_of_offset(dev);
+	ofnode node = dev_ofnode(dev);
 	fdt_addr_t addr;
 
 	addr = dev_read_addr(dev);
@@ -534,18 +533,18 @@ static int lpuart_serial_of_to_plat(struct udevice *dev)
 	plat->reg = (void *)addr;
 	plat->flags = dev_get_driver_data(dev);
 
-	if (fdtdec_get_bool(blob, node, "little-endian"))
+	if (ofnode_read_bool(node, "little-endian"))
 		plat->flags &= ~LPUART_FLAG_REGMAP_ENDIAN_BIG;
 
-	if (!fdt_node_check_compatible(blob, node, "fsl,ls1021a-lpuart"))
+	if (ofnode_device_is_compatible(node, "fsl,ls1021a-lpuart"))
 		plat->devtype = DEV_LS1021A;
-	else if (!fdt_node_check_compatible(blob, node, "fsl,imx7ulp-lpuart"))
+	else if (ofnode_device_is_compatible(node, "fsl,imx7ulp-lpuart"))
 		plat->devtype = DEV_MX7ULP;
-	else if (!fdt_node_check_compatible(blob, node, "fsl,vf610-lpuart"))
+	else if (ofnode_device_is_compatible(node, "fsl,vf610-lpuart"))
 		plat->devtype = DEV_VF610;
-	else if (!fdt_node_check_compatible(blob, node, "fsl,imx8qm-lpuart"))
+	else if (ofnode_device_is_compatible(node, "fsl,imx8qm-lpuart"))
 		plat->devtype = DEV_IMX8;
-	else if (!fdt_node_check_compatible(blob, node, "fsl,imxrt-lpuart"))
+	else if (ofnode_device_is_compatible(node, "fsl,imxrt-lpuart"))
 		plat->devtype = DEV_IMXRT;
 
 	return 0;

-- 
2.51.0

