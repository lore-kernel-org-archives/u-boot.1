Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59D4CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 049C7846AE;
	Tue, 26 May 2026 08:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t/JjzOLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE6B846AA; Tue, 26 May 2026 08:08:37 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB6F8039B
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgpghEDwMG/djGmM+zjqM39y+50G/ijwcfaTLqWpRP3ctbGDlNj4RRvlp3CA2lnP+rj3FWB/MWe0RnrKUvzKLu+ZCVnZWevkaH6nFwJ9DPKwO8KEhJdMpSnaLy6XVRcf+QBcOUMCbbSDZiSsrwAeTMM1zEs0BhIpKiOSTyNRdVGn+YwyrLcwED86aMkI+TIEguNXEmf8CBt/vu6dmgSnd4Ht7Ghz4IyN+hSPbyo+0ANSr10xxHFYrJjxYfWKHvNIgx3Uj077+EomTQF8olQebslUdSgOTJ7v5VCc5m3junBjLpt96tlyd+HKZdnY3uYosjblfTHHwNq+sZNBDoeYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2R1EqK99QYQqeZmufluYCIWs9uRpvIuVGk1jMYIduo=;
 b=C1E2cAy0O9LC35ZmS4YXCtQym43/b+jQf5MlmZHtoUB6cht1AH/DFcK6dEVKvMr0p2DQvf3DCplNC3MP1qRdTff71+dBJBEiS+KogdfsoWc6gCb/ad9ajkw6X4d+z3suyYgFbNtAx53ArPY6R0NGZlOm9+YzVf1ZPGPU7oC2Qm2XAGUxYTlhPV8LwZ1IdE4q6m3PM+EqU/Aa2QIQx5z2fLltCXMYNqL5PMt/jBT709L/LTf1SX+1nHNRHNwFC8ufJhwEfYoaVG9ojGNzSvkqh9nEK7NcapWB3SqUddiHhYW9zdhk6mnvy6gj5UyYPRFuD8yydrCbBrdDg3T0V9Hu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2R1EqK99QYQqeZmufluYCIWs9uRpvIuVGk1jMYIduo=;
 b=t/JjzOLPSqirPpfAhNe6ebjarWtyCalLSZpHvWE+RbMeq5ZhYIw0tylBCk0EXPLAB3Vrc7P3gBroVYKsCNBY/tn4tNTWNVYRNimhtCFCIwLmaJCcChKsDnv0xnrMcXRCThCqCxiuRJsuz11A29vHj9YwniolgullzxUX96YKsypfjVd74PrAMCbw8It09PbH4HfgqFaIG35Why9C2vBCwX60VsIdM0AxMGFA54BppuY7V35z+g64g7Itfuy69dolMj2Xm+eQucInN04/INBzUqiXa/6+O29RUkAEr0JLrqSNY/lodC0A7JJSpI1PFY9xU5KSzZ/29ZyzdPcHncTcXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:08:33 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:08:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 15:25:11 +0800
Subject: [PATCH 2/6] net: qe: dm_qe_uec: Use dev_read_addr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-net-v1-2-be3597b85b5e@nxp.com>
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
In-Reply-To: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5P287CA0049.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ef3eb2-f401-44ab-0ee8-08debaed3773
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|52116014|7416014|18002099003|56012099003|22082099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: RRVfRlQe11Ra8sI8gCoiZrRVSrgeNEpW5NOurMAbwL0tB6zHdffnLOLdUuOvJBkOBYPGq8ZnZCXVYNKiAdpDYZvyxHcMOI2N8IWmgSnRWE7hOhk0iF5Il5yS15FwkO9ufz522BgI0HHkhgDutuCeOqiUjPHBHw0PNE09CZWBQs9AqdiDzRiFGGpsXZkU9KZqTvhZhZSVV6y4BOuhEdcWdenyF05AodPrTDNcTyk5riieLI3eFZSLDPIYrJtF1ARBaB4V8YqSWPBvz/99Igl95nFkO9HwYRYXQc7NIRu1UJYv3VU97ZC6/aFIZEJcuJY/iFDMSOvvVeL2M9pdm/ijiX74Skqbm05RQXjdwpU8/p32+mLBa3n4mNX07XeP6gtnAOmGD1ZOz4gV+rgPtSBRTmdalpyly2qu1tzrNj/UX+IiU0G/yYTIRC7qtuemX6RAETbHuehoRxibVE0R/Ohwio1uN+39mCSuCmp2XKsnAYwx7fEEUIF5x/9CGcFx3JRgoFFZ/NojQA7jTjRDcig6560N5FzONmAFTPkSBxfWa5A2w/n30hLqAgoXi0sriM+4QkUOMz+nad8tePINIk8+qafTCA4laGVHbKyRlT0wwYpmE6XgWFx1GZ45J2NNDxgfe4u5tOInmKMCntAtN2qe8VQFC1RaWPc98gD1e6lpcNIrpgb1NfG1mDoNt676HMUdfs0k8cEsLUPtLO5wsaZOEFy0fMi1SolLO/OPAmvJ83sWhvTiOnCHEwNRgKWCt602
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(52116014)(7416014)(18002099003)(56012099003)(22082099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDNyTlNTM1FDaGdVSFRybFFpc3BLenRDdllaRXp6LzZYTWVLcU1SekVlTkox?=
 =?utf-8?B?eDRYSTQxVUVjRllJZ2R1RGMyMHdMQnRES200VVhlV0tqcnVsZDlXMlNFSVV2?=
 =?utf-8?B?M0k0eTVqYjMvTkRnam1EK0JQNUVhd1FRNEp0MjhHdW9rL0NIMVE4WE9INDBu?=
 =?utf-8?B?dDhGL3JuUGRPMmRqa3BMUWc4M1BNUkNoZVpjRzhhYk1hR01zRjJ4dTVxUnkw?=
 =?utf-8?B?NGV0MXF6QzhWeTFKb3h4MXV6WC9HczN5NUZ3dWlvUmg0Sy9BUjA2MEZnNlVV?=
 =?utf-8?B?QnMxMFIxTnlUdGpLS1NZVnVjdlNHU3pPMUQyUVVDLzhXamJ6d0NpR2IzNWVa?=
 =?utf-8?B?WC9wN3BYSzE5OVcwRjQ2OER1V05JbzgrTDFmOEc4QmREMkY4T25JSVd4ajRX?=
 =?utf-8?B?U3BMb1JWQWVTMlZ4Y010djFWUmxLeU1NMUhiUGp5bnBsQUt1QjZlRDY4ZlIw?=
 =?utf-8?B?ZjhRcFpvT25WSzBPREorOTBvZXhaRHNFQkFyOXJGSG1OTkpYRTlqWXhCZ241?=
 =?utf-8?B?eHFQSGFYWEQvQ25Sc09pU1BDck1LQjUrUHlOSjRQY1FJQWpuY1phcDI0RllU?=
 =?utf-8?B?M2s2Y0JZU3o4RStWaGdXU3VzdjV2Ym5uMUlmKzZiUlY3V3VNeHVUZnZyMmd4?=
 =?utf-8?B?eXdPRFBaUlhiTnljaUlIUVJPL2VYY1MvVU05SDd6alprT0cyd2JnWnYxRUN4?=
 =?utf-8?B?blFsQUZJb3ZUS2J6WmVNQVd5WGlZeTU4QXJudHA4WVphVnNsMVBIZGdKOUx0?=
 =?utf-8?B?Rk9NdHdYVGlkVDUrMTVLSDhPaDVITTZUVjdLU0dzYkgraEVUbU11M2pjbmNj?=
 =?utf-8?B?R2pvak9xNzRjem9hUXdTRE1XNUplV1RGZm9aMkR5U3ZKMElaU3UrS3RmTDlY?=
 =?utf-8?B?MDhCekdoOXYrL24vZ3Jtb3lWMFpRc3FIb1VPb09ZcWhibk55NUtmZUhmZlp1?=
 =?utf-8?B?TDFQWEQ2TTZzaVRwOThFMWF2YTlpOTB5WHY4OGcxSCt5VStjUjYvZkhZYTVE?=
 =?utf-8?B?UkpwMlRsTWJEUzhIekdUR0FXUzc1RzhLRlEzeC9EVXR3NGNzczIrdnp3aGRx?=
 =?utf-8?B?VGpvZlhybHNBb1E3Y20veDFXaHI0OEE0TmlEeHJ4ciswSTMyWXk3RWI2S1VY?=
 =?utf-8?B?emthYzVBN1I2Mmp2VVdLNFhvMlNEckJTUnJkNGtoRVc4UGR2R3VIZkJpenBr?=
 =?utf-8?B?Z0tCaXg1UFF4SU5GclFUeHpQTXlFMDBwODgwM2g0NG5xZ05jNEpCK2ZnQjZa?=
 =?utf-8?B?QlFQSGpzR01jaDgyQWlvVzAySVAwZk44RG8wWGI1ZFVSeEdock1sQ0tCS2l0?=
 =?utf-8?B?dXFWVTgzbTNpTDF1Y3lBWG5rVVJYUTZid0xFTi92czBLTlNCRlk3TmdFZDVI?=
 =?utf-8?B?WTZndXNzOTVPcEgvMHlmL0M2REFBb2xObURwOTlVRDNFaUhJMWdJOUVCVFI1?=
 =?utf-8?B?aGxvWVhiR0ExNEdzNWM4Q2Fnam1vbHJadFV3aFpRSFV3bDZqM3llRG1NTElw?=
 =?utf-8?B?UDAzMEQwVm1veFpoYzVJdk5lUm9QbWtKci9iQk9sUzFhNzMwOXBETm92YWtB?=
 =?utf-8?B?cmdQdzZXKzBrcUdwU2FYQ3NxSC9SeWNvakRGUXhCUHhLdGZDZFZJem9ZTyti?=
 =?utf-8?B?Um9odTVvYmpoSjVaY3NiKzE5OFhQWDZPdXRvejd6bVZYRjFVTkZSR1dNM25B?=
 =?utf-8?B?OFhsUVhTbnIyL2F2Z1FIbWdJYlhvYjlsZzNkd01XQzQ0cyt0QnFQUHc0REVS?=
 =?utf-8?B?NEZNakNKMnRVSkF6L2FnR3hkbWFnVGYydjFFQWRxUE54NFlOdkpLdXlUbHFH?=
 =?utf-8?B?YUEwUncyYUt2R09CVEQwNzRwOUFqUW5HV3Y1R2lncGpFTjZTNkFHakJRZURQ?=
 =?utf-8?B?K1M0OS9RQ3pmZ0JlTWlXTVJjTWFyMXRucTFZR1M4V1djS041dEdMeFNPSWNl?=
 =?utf-8?B?TUxSUGtIa2JIakVkWEoyUGZZUlVLL0ZReStTSHJlT1hkUENuVi9Xc0VxRmh3?=
 =?utf-8?B?cUxialFRZkMxT054VGJLMURndHMrZE1iZitveVNSYXpFdEVpOG0zVk9oQ0F5?=
 =?utf-8?B?TFNIL1Iza0xWVTlKeHBJUTRRcXhNZkVtSk0xZFFCVEtYQjFpeUVlNExCbTBy?=
 =?utf-8?B?Q2hSNHZIdWM5T01uU0docGorbEo3ZXkvMThQTmw2d0Z5YWVwYmg0SFhwbXpO?=
 =?utf-8?B?YTEvVlg5ejM3bWZiTHBLV05RamNSTUZTQjJETndxbWZVZUJXaXlIUUZTbnZp?=
 =?utf-8?B?azVrZ0RuSG5lRU1EZnNxcllIUnpIZDErMTgvUnZBL3hvUWxZdzEybkVIK05v?=
 =?utf-8?B?RnhldWdJVWtuMWQrUVpoaGo4ZElDZ3gxcTQzbFRpQUtaS3NydTkvQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ef3eb2-f401-44ab-0ee8-08debaed3773
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:08:33.4801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yzjuXmNTUK2zli8UhE5nIhmMflOo6Qd1fK9p82hbEH3fE9szvMr0N5zyzewxf/ppQZr1vIwSoiaV84m34HO/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
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

Use dev_read_addr() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/qe/dm_qe_uec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/qe/dm_qe_uec.c b/drivers/net/qe/dm_qe_uec.c
index ac3aedd8b49..f9bc5d49c8f 100644
--- a/drivers/net/qe/dm_qe_uec.c
+++ b/drivers/net/qe/dm_qe_uec.c
@@ -1133,7 +1133,7 @@ static int qe_uec_of_to_plat(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 
-	pdata->iobase = (phys_addr_t)devfdt_get_addr(dev);
+	pdata->iobase = (phys_addr_t)dev_read_addr(dev);
 
 	pdata->phy_interface = dev_read_phy_mode(dev);
 	if (pdata->phy_interface == PHY_INTERFACE_MODE_NA)

-- 
2.51.0

