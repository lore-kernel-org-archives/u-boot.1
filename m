Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7731C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 09:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2301848F3;
	Fri,  3 Jul 2026 11:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nMuD50Ef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD794847C8; Fri,  3 Jul 2026 11:12:53 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8306F848BF
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 11:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+PX4cvyoHuHAtgPJuwrz+dBxf5nRgOa0deCoXhSKBuUsfvvFR6suY6Aq6Lt9pfbQk3s0N/vyUlhca/e+sbAqePnMGfCTJx/rsKtAeYVkMN+DPKMuLq1cQVcyl6h2Ns4BIj3qkX0hVSS9cjbsy+3UdYGHBmqkKgdF74P7UCbogUiK2XEfXvbtg7DgxpjD1OsPuHhIOVUT0fKyYx7nj3w4cbBXaA4UcaMeoqvLSgg/FLDL280RmgSjbNZ8sbDKt4kBS8YRvF7oNteUBBZOXQBEM2qVrVNJJzInakNcll51QHH+C/KRZtiUPw0qHhJbc4wE9DeqlCLMSwig1Y3/VEKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SiFsiHxtQCpt7yLG+ZkELqIgcZ/Db4XWdAPgXpHgt0=;
 b=OMpi84QBV6X6fJcwIRQSKjDVZ5gQICKKtdn/RtygONFP6OE3fVtg4/gA9IortwLNt5gT98OkrjCj7b35JGt9RHjO+kBHvt0cK69zAe6wPgGK+VUe0rKb+FJz2oLrhNPdD7J4E7MwJ9vbck/dcNPLp8lD6Fayjb1mVVSynw1ZsCh3WacuB1gbZx8sQ+7R2NpbAekzYPeWk4CO4zLrgUYDOYp0vEE25Dm7jxfGMJoa5dBrL7VV5zh4eHIzgtTtq3lDwSAIeilsduw6Fj3ClVj2/johvUSieeFEi3uXwtCqrQ8g9SGIWOVx2+aA7H+EEM0nj1vilUGR/w8hnRM1av/Gxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SiFsiHxtQCpt7yLG+ZkELqIgcZ/Db4XWdAPgXpHgt0=;
 b=nMuD50EfFQc3zAjXC6KSo2vx+xi4iZyKC8JdipzNI5DESgmVgMW8TdjCM/Fsi0DJvnFelxjR4/WbNn+feGptkY75SzUMWYTrPcpidytYyNXUUjuJfpxVvdboa85jnP6eLxqyTt5e/u7IqG181ZOFfU+GptoyeyfxKG0woKVXzYPSgSzuKLHDldTPEbjOvXlgqFDq+8ePwMUnlibVF7ZLacfL3J3r6FmwhXNFa8f/whzUMnysCN85NQ7xteNcQU+GgY8wiwPcs5TBWP8BV63pZNeFjkQPcB+00u4qC6G0pZW8uOeZF6ZIGl2Z2ermw/rGf5o4PlpGp0kDh2v3qiTXvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB11579.eurprd04.prod.outlook.com (2603:10a6:10:60c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:12:48 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 09:12:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jul 2026 17:11:25 +0800
Subject: [PATCH 2/4] dm: core: fix wrong strlen check in of_add_subnode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-dm-core-v1-2-076d395bded4@nxp.com>
References: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
In-Reply-To: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB11579:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f1fb94-65a6-4042-81b1-08ded8e34036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|19092799006|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7Gj7SdpEgnF5z9U5LHTmjHCqL1rTjv4csrsiyGkwkGKCyGCY0i/U7Os4sDilNdfzHKQSfx8ZqcutJbtfYpljQCt7xmISHZK/RnkimqEBidu+THbKGW11NjVL4KPaAQMaShPPfgjKh4x4sINBIQDmk6ZeDWRoyr1RJJ38aBBTcXIKWyzdFydIDwJCD+lWzjsG1GgayYoTT61fdePPSx/hRqmWo5hAF/Tr2J9d1Ys6EDjJgb2DIQWaHFHTFZH518lOCA4EHMd5mRhQjUsm19yAq4aryqmcOieb89kUrTaRSWuaWTNdRpel8tLkNNWyzCVGYD+wm0SqHncIU42bp+V4CZ7QJ45QasI9dSRO8IbfmleNdkbP/zvpYAVD7gl4pZKANaE4SvySA4x45E/3A1RnMT+MJSkDMDY/CyBjLJaYap7gutKqGquMcCU3FOoNpEZikJV5r5RempCUS+rNNH4i6iiqzqd8utZ3lgJ9M1T/QFT1ZMD/A1MEqkfeHG5tLPIQ95ZOyWMBuW3fIXXDMS4UDB038USo3xkWR1/t/nQubTX4hAhzEtam3Qqsi8XsGx8KNnVDE87VvpqN9rMMzwBcSiCxUIhXeZ+MRtNrgEvz7iZ8ulNDc4yRAUkUUQSPXLs2Ap4qeGIYTb702hjyt38/Kok9ukxl76xw6VVnaN62vCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(19092799006)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG9UWFZXRTdVL3FOcDNuckNsQlgvak9aeDV6VkdpS1RMNnFoVlF2SzJEa1FW?=
 =?utf-8?B?UmpQYWhZTmNWZk0vSzlrZVhCUk9aNE50RGxmbmtHK3lFcUExM09QKzZuY1FH?=
 =?utf-8?B?b0RSalk0ZlhjdEJSR090UmpObnpmZGx1eUFPR1FZem5rTHEzc3BxbWZtM3Iz?=
 =?utf-8?B?dXhsQmozZEg3OHk2aVNXd1ZpcVp0VEdBNXkyN3o0MVRmcFo0R0JGZWYvRUk1?=
 =?utf-8?B?Rk9icndNeGhyYjRPbFNDTmY1N0lmR0ZlMiszOFN1U0FUa0FrZXVIRU5sMkRM?=
 =?utf-8?B?cnhPTktOcElTVDMxUkVKeUh2a1hsVnBLQTNkRTZJeHFYbFBpcnZMSlhXR3RR?=
 =?utf-8?B?ZGd1MDZZMU5jQWxPYkJkOXlGTEJFL3lzVVdSUm54QmIzZngxT2VSVVAwN0p5?=
 =?utf-8?B?bFowUjFVN3ZNdGRFNm5aRkQvUzgwVyt6K09RMVR3aTA0NVZVY3RqOEtxM0pC?=
 =?utf-8?B?Z09FNlJFYTNoMkRUWTh5QzlZTWlXenlYSFFycHdYN0U5ZzNjVXhlb2ZnQ0J0?=
 =?utf-8?B?NzBaSk13c2xFOVZ2NFBsME9wSWZXekgvZ2ozSEVGZlEwdEJLK3VuOUVsd2Fq?=
 =?utf-8?B?Y2RDb3EvSU8wdFFtRjFKZmdlUnBVazRxUEFYTzJIZldSNElxUmJVVmI1Vk5N?=
 =?utf-8?B?SlRNWm9ORWlBK3VzdWt4UGhmbmtnajRnSUp5TEJRSFU3SEZ2UFZwYUZZMEFw?=
 =?utf-8?B?dXZZdE5na2Vxby9hdHBRdTZxNTQ2RXA1RkFWOUJhQ0hIQkdYaHFXT3NBU1hh?=
 =?utf-8?B?K1NNa21hbTZOZ01KaUtxT2phOGxDVHNMWk96VXJXQmR6TlEyY0dVbE9OL1Fv?=
 =?utf-8?B?ZHU2Q3dPUnFIbW5DU0w3V3FkK0VZU21KeVY1NnVBUUFZaW81bEZUYWZYL2E1?=
 =?utf-8?B?azYvOHZndWlQNU8xNmxKbS8yL2JUTTZaWk55M1lkY2VhRFZpclI5NHpUK2ZM?=
 =?utf-8?B?eFZYbHRaSHBGMG1UYTB3MXlodi9tVDUweEkwNEliOWVaSHZFVDNBTlpCQ3Ro?=
 =?utf-8?B?M2dRTGE1dXF5L3VmbDJKandtc2cvT1ZybVhhVnR6eFltYzlMNkhNeGg4WTB0?=
 =?utf-8?B?UjhycEE5MFBmWnBSdklFNUl2TmVrbHhSeGFSOEk4dExYQ1Q0UTU4N09XUC9K?=
 =?utf-8?B?Q25qc1NGdHZaVEk1dSt4bDh3eDBZSXZCenk5bkhqcnhVV3lHUzcrSVVBSzBv?=
 =?utf-8?B?R0Qwc2hrSm5HcXBCVVZaRUpwL3VwcFRpYlE5YTRPemdTWlZEU2JwY1JSb3N2?=
 =?utf-8?B?WUprTkRtRXBCam53SGJkc2dwVVJZd09yYXpSWkhiUjJLQ3lRUS9EMGJzQUla?=
 =?utf-8?B?N2FMU1dzVU53RGdERW91ZUxlWnRlQW9WZE5va21pSjNaV2s3bWZXdHN4bzc1?=
 =?utf-8?B?QTM4eXByMXZBUTA4L2dNVmJNaHJhTWMrc1Qxc0Y1ZWpHRDZFT08xWTlYYXc4?=
 =?utf-8?B?MzR2Rkhoa0RSdFc4cTFkcEpQQ05KZkJ1RmN1eGFTWXRSZUtIM2JaSkxmMzIx?=
 =?utf-8?B?WW5UTjRyUHJwRU9xTGczb0ZCOHM2T2ZFUTMwT0RBN2J1eVVtc0ZBZTU5NWh5?=
 =?utf-8?B?UUlZUVZib1ViUUxxaDIrMnFpV05ucUZicmc1dnE4cnVaaml3RGl2dXd1R3N6?=
 =?utf-8?B?em5IZjdrZTJaamJnS3lRMGZsZHIyazFXZUtKbE1VOUxCVVVrV05nUTV1cHZs?=
 =?utf-8?B?WndkY2VoNEYyWHN0c1BxY1lvUldNSlYxNGFPejVBeU9QSjZUeHdOSkUvVEdG?=
 =?utf-8?B?WUlpM1VLNUJMNUE3a2QvYllHTHF2b2FDOG5TQVJDMEhCK1R1VE5EaXVwQWdD?=
 =?utf-8?B?Q0VGdWtCbWlORStoRCsyV1BHK2dnVjZTeDdiTFdTeDBMN1hoa0pVVlZKY21o?=
 =?utf-8?B?NjkzUlI2bHBXSjh1K0hTUEhibzNQNHJHeVZxUGhRR3FrVjVTcG1IemxLY3N0?=
 =?utf-8?B?Uk1oUzl2VTY0ekphZktpV2NBSUtacDFXbmo5NDVLUzRKdDh4MEkwR1ZWME84?=
 =?utf-8?B?Q1NFMm1ONlplQStLVGZiSWFneml2bFBEMHdVbnlVemo4ejRqdWVhWjNrT2Fk?=
 =?utf-8?B?SytuMkZTVEFtYW1RcTRMUExuZVBBanNHVE9HcDkxeDlsa1ZHWnpiSkRRejU3?=
 =?utf-8?B?UEo1WnhHajlnRitwMVVxTUU0T2RvaVVJdDA5L3BDSklsVkpDY3NjbjJOYkJG?=
 =?utf-8?B?MTZpdXRNS2tBWlNBaHF2Ym5zajZGbFpFUmQ2bVdEendNOWlIQTErdkdweTE0?=
 =?utf-8?B?M3ZTZDZwWW0yTE12L2dBVGIvVE9TRDBPQ1ZKaTVlaWFuSkdLNExEMXZ4azB5?=
 =?utf-8?B?cFRkRTJDVThrT1ZkcnBUQU12VEdVNnBibVFZbjlDNGszRDFPbmNHT0RZUHZF?=
 =?utf-8?Q?E95n88P7FZ379nYkxnEu0mjohnPCjO+V2TXEF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f1fb94-65a6-4042-81b1-08ded8e34036
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:12:48.2733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emhJ4+BpN1xHxiQvxO0MJG4Rdae4wpYuSFbIG3KzsC87+XaCRAMJj+8WjWm/H3b6nH+7aiuSMOaBzq8vr3iK/Hq5c62W/vuolVRdjdYx6SXo+2ftS3F7li22ZRShLID5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11579
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

The duplicate-name check uses strlen on the search name instead of the
child name, so a child named "trevor" would falsely match a search
for "trev". Fix by checking strlen of child->name.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/core/of_access.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
index 969492aae37..f910cc9a31b 100644
--- a/drivers/core/of_access.c
+++ b/drivers/core/of_access.c
@@ -1071,7 +1071,7 @@ int of_add_subnode(struct device_node *parent, const char *name, int len,
 		 * make sure we don't use a child called "trevor" when we are
 		 * searching for "trev".
 		 */
-		if (!strncmp(child->name, name, len) && strlen(name) == len) {
+		if (!strncmp(child->name, name, len) && strlen(child->name) == len) {
 			*childp = child;
 			return -EEXIST;
 		}

-- 
2.51.0

