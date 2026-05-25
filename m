Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369DDCD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 01:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1CF683DA6;
	Mon, 25 May 2026 03:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S1GSpCQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B268039B; Mon, 25 May 2026 03:53:53 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2D58846A7
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCrHBnX+f3jKWtfX4m9CS4V4pxE/9DCzBsbK1CywKTCbpIJD+va0eUo60QgoJHfcsINbRXWZotjKqzHeUT/uRD5jWQiCeasUcDds8QU9b9lWU/weIR0Ikhn+79xIrwgriOlgG2XAj1PIh0px9P8pJLirE3m5dB4RrkwVPixHKp0/VwOJfFHlXag8VEZF/zA9EUTzaINmCryLyNP00vlkMNgW42XNP5xEqBLyJ3k4Jsc+oNFE/tn15VAEpn1zXROsOJ/i7X6f2kZVSwVTYQ2g/koqtljf/obkiEh+AETMUY5Wh/FFen6kHAnMDqVpLQk1xjkuaYTf/OfHmAcrc83oZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm1Tn52bRsh2TUux3hjeCFhXGodiRxs1GtdHDFlI8mU=;
 b=RbquH9AUatXyirM74BZlg9hCymQDSWW1MaSlJ4y28oXqKtB5XzHyrLZbKG+xGM9bfTD04rJauV5+dH9UKukoksXEPo8/BRkAFGUQp2k83vorZ339gz/89ruNY1/jw3Hclh3ILP8lH6taBoctDuqlV4uRHyc/DM2bF4mpMQEo7U/QWCdomvHoPCiPy64Qd64O9WSbThABkDsvvPHhD7NjbHRnTxXt0/Sk+t5K2xtRh0rd1sGwDq6gOAFGrvxSRasgH8XtZyTEsac1z14/lxFRgOgJ2+/mgzfgfE4yXNB6wT6hExhDUJgsaYzJO8Inww/Itkv753OkvjxLPbi1yIChWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm1Tn52bRsh2TUux3hjeCFhXGodiRxs1GtdHDFlI8mU=;
 b=S1GSpCQiPW89QwFTwJeIX+60eDPO7o9cxDrePYHH8l072I5+m++crirQPvi2HEPLUgPNiK6X8B/wto6J1oSvIGfroTb3y7T+jKqbqtyiYaUxKn8LMD/ga5JUEgSRpKsdnYVkp7lKOanlcRx6KFjofAiTqcJSoY+zceOvs/wTKwLWphabw67CviQPIE38TbY0f8vC82Suk1gx6nm5AHxJbivHIAvudkdX57/R4NoIFCRG+4OzDboD9E3PI+kQTVd3yGNWnZo5+ilXvzZyHNQNyQkBh3NOK+v7vNIrC4UdJI+8lXm+RYOSJyipuBIU3PAq7alyKV4+sqP6tTqGjD2eRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB12323.eurprd04.prod.outlook.com (2603:10a6:800:320::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 01:53:49 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 01:53:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 25 May 2026 11:10:19 +0800
Subject: [PATCH 2/5] clk: altera: Use dev_read_addr_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-devfdt-clk-v1-2-f0dee4083e82@nxp.com>
References: <20260525-devfdt-clk-v1-0-f0dee4083e82@nxp.com>
In-Reply-To: <20260525-devfdt-clk-v1-0-f0dee4083e82@nxp.com>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, uboot-snps-arc@synopsys.com
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Romain Sioen <romain.sioen@microchip.com>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB12323:EE_
X-MS-Office365-Filtering-Correlation-Id: edf4a329-d49b-45e0-2937-08deba00771e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|1800799024|7416014|376014|38350700014|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: OevfTtQjAE47wVRedgdsZOSK5rUn4SuNATCL0ceAr7lSrTYF3ETfIzkFvyWw5X1hq4ixr+yfw0aR0XfqcZ5Zto0RlJzzICffIdloMaXkBf0wTBgTBFmWHrYpgNb7crxnZSJWTbwhjqMxqEI28HtfZ3L5h+zqkHgsmeiR8MMToVONLJjt8FYEBxPVayn6/lwp770ISoV80gq9qkSlFCvsflBvFss3NhAkiiTneFrjZfJea9cLxFIQp/t6g7x7wgSvsGwBYidMhIr+CEetwTD4Y+awKsytlmu16ZqH8dkTLummaMK0KXDu6HAJ2nWFd5reWBYhFyg584IEpV8kqYqa65IGCZN1gf0vxy9eX9YfRxEXd4R+VdzYnIzxcY/l3uVlO93r5S3pZRy9xz4+uwWJno09vTyz+wN7ulJnaLE3XOveqyWpK/PvyYozbbe6O6pYx0AcRj0ooK3LnKCVgFWdnBwfgjqb+HMgb4fWaST6D850yPf7swDeKVysBuUZsXXkXLUI67t3QcYBGcpFPboyoRMyq0oSOhzSpWFX+8TWJ/5u+OfjeDSCRKCpw1Pv/5BFPPIgdBv8jjzZlIeS6isu4GzD/MamWjU4PWCEWiTHrkw4COK+SZTjR8u96VH3HFMaBpfjJC1URkHD5ea3eRElDTmzpdueD6oHPo9OWqrLtE64Gl89/9WJwdVHcTC/EI5PaR8NjAyLsjM3OWHU+kaFhdVOZQAdHHzu80r6Q574UuZwvM6LnallupwhBu0hkaWi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjdBcXdhNTMxNXRhUjN5bDBXRXVmSG82MHQ1WDhTbXdwQlRtalBUNTZkTWV2?=
 =?utf-8?B?TmNrZzc2S2dRTkwydE1ySnd2R2htQTlqSEpSMGFZNG9Vb1R5SllMOTBGU2JZ?=
 =?utf-8?B?WGZmZ21SYjVqdmJWQ1dUcTFkVVROTTNQbG9RQmtxVUxpSHJ1S2Y0c0pJZlZO?=
 =?utf-8?B?cXNLM2dNNlFwclJ1cnB2TGZ5V2szb0txa3hkbWRCVDBGaGhNYVMyL1A3alVy?=
 =?utf-8?B?TjBybGlvUTlrblN2NC9tb3NTK1lBTTZIVkg4SXhYc0E4b2lzUG1HcVZibGRK?=
 =?utf-8?B?Mll6TFB2SGQ0YVZSemtPbEFRYkw5ekh4RDd2NmhMMWp2ZjRINzA4aHRuVFl5?=
 =?utf-8?B?ZkttVC9aaHdlMFhYR2FKZGYzcDV5UmcwdGl4NVdySFlUM25XZzU0bVcvaEVr?=
 =?utf-8?B?dGtVMFlGWS9reUNPZjVxNldVYmFJNmIzOThhQk02YTRJamR5L3cxdmtvYWR4?=
 =?utf-8?B?MWQ1eEQ4cnRoaEVMUklTczhGMmx4NGNiaEw3dUd0eG9teFdxQkhtWWh6K2Y2?=
 =?utf-8?B?VzkydkxwcDlwV2srTDZFRVpzYitKVG5BbllBTWcrUlN0MkIyUlUwSVlJNnkv?=
 =?utf-8?B?SndBazlPNmFZd1hld2hpMEFqeWxXVE5Xd050TWtGeCtOazJLd004VkNuTjNK?=
 =?utf-8?B?NTlDam9GSG95bnRNNm9welp2c1U2ZkZjZElOcHVGRjJzanl3M2hISURIZkdy?=
 =?utf-8?B?WFdrNGhVTS8xdk5aN1UrZ21PdXhSUkQ1NTh5Q3paRTBHa1VlRGtINkl0Z3Nm?=
 =?utf-8?B?Vk9XWlhuRzUyZHhEeTJxMXZNK2lpWXNQc0xpd0dBUVF5Z0xPazBvV1ZzY2Vw?=
 =?utf-8?B?MURnY3JsM1FSSFBuZm0ra1RDczgza21jM3BMMGIyVGpva3FiRituVytFeGRi?=
 =?utf-8?B?YTZYMHQ0T2VITVQ4dnVEMHFHUUcrMGNqQndoMjlZY1QxMWNzanZCcmExd25J?=
 =?utf-8?B?elZmb0E5WkZuU0hqMWtnMUUzdkw3V3RGSWp1ZGRtYXhSd3A2c2RmaVFXVUJr?=
 =?utf-8?B?NUYzcmVGc1JVZ0JoZWRVZ2VHdVBiTS9rb0hyM3hvZDdQcmxtL3NiQndmYWdI?=
 =?utf-8?B?TlRuRDVTU1RUUFliUlMwQmlXWFpOaEd0Uy9xQWFyR2ZJaXVuRlRIL2RFQjY3?=
 =?utf-8?B?SlowL2pPR3pTTVVZbkJOR2V1TEFTaDVubGR0VU1EM3VrNjBMc1pnU1draEVk?=
 =?utf-8?B?QmJocUdEQTdzMkIrN3NxUVh4TitCUXgzMVV5VFpCSGExMG1yVW5rYzJjTHYv?=
 =?utf-8?B?andNRUdNMHdYWGVNY2thOGhCQ2lNZzNUWEd4a1BBdktJOEc5djlobDR5UHl6?=
 =?utf-8?B?eDJhU3Q0Y25LNytPK1dwUDk4WXVHalh4VUdxSXdKL3VmaG12dVNnVkVUV2Yr?=
 =?utf-8?B?ejNZbWxLNkpUY0RkZHJUaDhkdnp6Ylp4dHJRankwellKMUk2S2pYM2tjdktz?=
 =?utf-8?B?M1IyVlUxRHZLRW1TdW1sZGo0NWVPY0pkR1IyYW9qUnNNdklxSEdsNStFYlYr?=
 =?utf-8?B?VlVhSzhwMlVRMmhCdEVOR0NQWjgzZ3g1aUt4c2JxU0t3L3hGWE9MOXJHRTJt?=
 =?utf-8?B?bHBrOU5oWHhtbm5vM2lkcE9TdUVsOHh3aWlyc2tGNEdTOFY0ZHQ1ZWlBQklT?=
 =?utf-8?B?R0dEb3daVkhsQ2NsZThLVjFDR2d5M1FBRjZDUWk3S0czWHIyUm5KY3JhSHND?=
 =?utf-8?B?VnZjRk5Tc0hyOGJiSU55SzFiUmE2YUNRemtJTVFzY0VHSFNSRTBiOTVwcUpT?=
 =?utf-8?B?bS8rMWlVR2ZFWUdzem1LKzkzR044a042akQwQXVxWUdoQ3ROSkRYNWoxVTc3?=
 =?utf-8?B?U1RLMmRMZ1RNRnZGaTJWWnJ6MGdvWk41OTdBbFdwNWNXbysvcm1DWC83OFI2?=
 =?utf-8?B?UXV0b3hlTjdzdk1PV3dhQUprQ1kxUGQ5KzVxTGV4OFpDd1NQU0QwZEprVkQ1?=
 =?utf-8?B?SzRheE5hM25rUTEvd0M4Tm8zbzdaZ2VMb3ozTlo0R3N0RFNGb29QbGRPdmFW?=
 =?utf-8?B?TFgxOXFiMzNZWGlBcGIzS095ZC9RaE9xRGZCenFTdnlmTm5icnlNb2l0QVlP?=
 =?utf-8?B?TjBIYUhjUEp3UWlXSDI4SnB5R0N4K2hsOFZrWkV4ajQyVkxGYmlBb1lGbHd2?=
 =?utf-8?B?TmM5aytCb0k4MmxDc0J5N0JOK0MzTzgwU3NFdHpYYnBlYUJ5N3NxMFRQcnN2?=
 =?utf-8?B?VkU3Zk9idHBrVG01ckJGaG43eXN5R0lKcTlZS1l5TyttY2NWRitkZFExS3lo?=
 =?utf-8?B?dDFwaFUxY2dVZDBGL3lyYldxYlR4Q3JCMitRY2tHaWlwQmROYmJmRW5NcFlK?=
 =?utf-8?B?MDF2cHdQRXhjU2QzWml4Wm5vTnRNK1pWdWlGN3pzM2I0U1I3NlZPdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf4a329-d49b-45e0-2937-08deba00771e
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 01:53:49.6201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9jEZ+Xdr0jWkz5Rzx7ekT1+cBoGDKE8NhPEnniTE4aUsoGdBIcj6XdDdj+Eeo4M4cKPudsBkMlZ+Lb4uAGH+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12323
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

Replace devfdt_get_addr_ptr() with dev_read_addr_ptr() when retrieving the
register base address.

dev_read_addr_ptr() supports both live device tree and flat DT backends,
avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/altera/clk-mem-n5x.c | 9 +++++----
 drivers/clk/altera/clk-n5x.c     | 8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/altera/clk-mem-n5x.c b/drivers/clk/altera/clk-mem-n5x.c
index ac59571a853..149e3016dd3 100644
--- a/drivers/clk/altera/clk-mem-n5x.c
+++ b/drivers/clk/altera/clk-mem-n5x.c
@@ -103,12 +103,13 @@ static int socfpga_mem_clk_enable(struct clk *clk)
 static int socfpga_mem_clk_of_to_plat(struct udevice *dev)
 {
 	struct socfpga_mem_clk_plat *plat = dev_get_plat(dev);
-	fdt_addr_t addr;
+	void __iomem *addr;
 
-	addr = devfdt_get_addr(dev);
-	if (addr == FDT_ADDR_T_NONE)
+	addr = dev_read_addr_ptr(dev);
+	if (!addr)
 		return -EINVAL;
-	plat->regs = (void __iomem *)addr;
+
+	plat->regs = addr;
 
 	return 0;
 }
diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index 185c9028a78..0a3bae38589 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -454,12 +454,12 @@ static int socfpga_clk_probe(struct udevice *dev)
 static int socfpga_clk_of_to_plat(struct udevice *dev)
 {
 	struct socfpga_clk_plat *plat = dev_get_plat(dev);
-	fdt_addr_t addr;
+	void __iomem *addr;
 
-	addr = devfdt_get_addr(dev);
-	if (addr == FDT_ADDR_T_NONE)
+	addr = dev_read_addr_ptr(dev);
+	if (!addr)
 		return -EINVAL;
-	plat->regs = (void __iomem *)addr;
+	plat->regs = addr;
 
 	return 0;
 }

-- 
2.51.0

