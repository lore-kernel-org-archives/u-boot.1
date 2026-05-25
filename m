Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90053CD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 01:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF6FA846F4;
	Mon, 25 May 2026 03:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jG45xv5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C24D9846F4; Mon, 25 May 2026 03:54:12 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE987846E2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8X164jpLJxbyIU1L1pZbWkB7VebAL7+YYvIEXfmZPgCqH3xOI9V2qOXdGHiQHuv29MDnt7V02a3pFsd7QN2ns53/CQkvhMjuKjg2iJNGnM73oa5UCEmeMtlJvGtkznaDCDaaoh1iIbHuexf/AQT2VyTKyjdyhtfC+mvQbOQJC5P7h2HScYYhFrjTPonitAOiD0YovMf7Fal11sTu3rZMWYTwH5nlHn/TI8idt+nfmE/t2qInU3Jxx9fkCWpsxeC/8wr43OKSrn5tvQwl5BOG2xwdYlhRLd2DCS+XLRE0IXg728e3UOT233756VVoeAHKpm0GKTPBu8+EajGmCpIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vm6+ifBl1hj/3v/vuAt4RHWgb6FPfLLSzfvqfzpm/HI=;
 b=Xmi/8fFYFpNW3CynjmTBi7aIuWpWiJo9Cv/vYYzv4pslEmtyYmpnqSGNQedtENOfi0R32qAaYhCkihK+qDr0gcWJ4ojnPqKMl10bSIZfwFJqBnvhWH8YuhIHxPu8p/h/4j5MhXuFe0xT1jqbrf6NVLgf0GLPWqEPTGxBrSqdhrZAFMHflr3AsJ8WN9/Irf7jGH5V4ZaizaBsNITwWPPaOmIJjAggNh/sli6nHGCfNjgbwIpz3XfLxDpDuokegBziSDNzzCyhzHCJKGALoUOSsE10r9BDwUndkhDF8TBRxiuVQV9j8fjHFcJmsE7wPABjzqsmTn0OebIR5bwZPqUo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm6+ifBl1hj/3v/vuAt4RHWgb6FPfLLSzfvqfzpm/HI=;
 b=jG45xv5X+FYSqBN7AjUWVo+zqKwDpjFRs1XcUAVgw50f6fC9+5JfHVMwcZJ8QySeLpISmOBzWp0JJYqxyMsCAodwWbpvPmWe93xnELxa7/8DWx+B+OK/a4x77rIf1is3FrsL4DKSx0/oywyhKlnZihGwTKhYieylvDp1uKTh62kTXUEiMjW+vJqsjd7FSjwfdkXzeWkXPb2sfQAEP1yAED8gxNzxD0PIj1fjZGeHscIGYzN5SaAQJPfJ3529M0wSm8tDSNCvvlnMwxL7D8pX6L5yUef5gfs9iZ84T3Mz0W5adLKiLK4mLImYoV29f6ZxxAelIGOUGMv8VBaDJq3iIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10466.eurprd04.prod.outlook.com (2603:10a6:102:450::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 01:54:09 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 01:54:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 25 May 2026 11:10:22 +0800
Subject: [PATCH 5/5] clk: sophgo: Use dev_read_addr_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-devfdt-clk-v1-5-f0dee4083e82@nxp.com>
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10466:EE_
X-MS-Office365-Filtering-Correlation-Id: ebcddd7c-f00d-4396-68d3-08deba0081ff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|18002099003|22082099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: mmir7mCJX4WruxdfYzznZ+as1cHT1OIBM1vtqtRu6ceylpiI49pyOcGEaRfZnPgU316VZIJJhliLpBZgC1UESbX+KSBQM/wyH8RXov9K1Am1ruuJuUVY+LCcZzQ3acFI83JDlZbDTozErOAIFMAt308hNsqwJ/Ad3aYf48AFw8Grr75OseLyWMcsD2/3iiVQOcgRexBmiYmZjNoq7wgGMA4rLfvipUJwgPlRNm+/ZbfPY9rX9Z+QJEpKeBOkzRCwlMqU117uY4wTRhlBFs8OJ8zVqLC7kvlNyIukyc8EqlKAv+HeH1DDQftjGAviiNT4ujKrS2LVrx+sPRwfn2vrYrXpO3advBbJ3b3TW5EDWoJKYkSqvk2mI/tlzxHskdFzV8ytpEnNIMZ3fcdy7RhkMaba3rIzAfLsdLrFZjhWRgPlexvZCSZ+pS5fV/plgu+rDJTsDgfbBNx9c+7gPSdOsCoTP0Ftay0GCM9L2kOshm8P8anhaI8Vj6hzd2bcfHKmlzPjFuctXG7vwcMhbFseb09Q7ukD1O6Enaq33Lj42AVg5QDePHUSEQ5gd7sAJ+ZJGWbIQ0A/mg9MY/eDJW6n82vXL40+L2s91ls8kQCnHnTsM2l8db0LRv2uPj2HcZrnKAy0Dxzk+DuGaY24C9rl9WmhbPDLmKabZs7QI643KZjCeZflgCicwfebtHq/2Xuy28jq0rFaxFA/us0mVbcEUNy4RqvdxG+sNB1N8dFRRwUeJqbZDAz+RigAm+Cmv9Bl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(18002099003)(22082099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djdqYzA1UUowQnlJb25taCtRb2ovSVB2SzI0bzZaQ3VIdjVsSSswRnk3ZUZo?=
 =?utf-8?B?ZUU2aGxCY0VOeGNyb0x6S1ZLQkorejJQUStXQ2VISzVWbEhkalBUZ0doYzVt?=
 =?utf-8?B?bmkwNUxzR21MeUFHZ1MvUG5vTWcrZlp4dG1XMHNpM3ZyeTkvRzNFNlp4c01v?=
 =?utf-8?B?UXNTdVlhV3NRR0JtN0tQTTB1T09TYjkxNGcxMUZPelZEcGJ1bW5oREVwNjFi?=
 =?utf-8?B?VXFzUXZYYWhHOWhHVEZ4TC9oK0RDU20rMnRnYTFvZ2dLMVNBSnFveTgzMERV?=
 =?utf-8?B?VlpDbitqUVl4bytQVWxsS2dyKzlpRzdibHprSEpGMzBkZlJGam4rUDJhQjQ2?=
 =?utf-8?B?Q1p5d3BBWWw5N3cyWWFTbVZZMnNrUXNieXdaYkFFeHplWUdiTFBlb0d4cko3?=
 =?utf-8?B?UTMvWWlEZ2tvaHZieURkYTJIbHJ5OTJhV1ZzZVI0amxIYkNmSEtGV1drdGRU?=
 =?utf-8?B?cjhYS0pWUEhkVFhHT2pGT3RVMUFmazZDd1dvOWdMbDAxR0NibUxBdHRteDBv?=
 =?utf-8?B?Wkl6c1pyeFNORXE5RFFnT0pFS0NMajBwMm9TQzFFMFNYV3UvY3hzUGpMUE54?=
 =?utf-8?B?b2JUYmRQakt3Z1pZYkpMQTRqazE3RHdma1h2MFRTSmI1YXVXVlNkaDE4ZExm?=
 =?utf-8?B?ekZxTW5neFpycWVQSHlTaGNGSlBqa3dHOXhOWlFNUFZDbmpxdG9MOEplMDRq?=
 =?utf-8?B?aUVaREFDOWlUS2MyWURRU1dMS1k3Ni9vc3FQNEo3MFZqZWdGTXNxcVhFV2pt?=
 =?utf-8?B?L1pRQXBoTnFxRmJZQkdvMGFXeFpjMFFjZ2ZFTHNWQXc5eG1NeG5jZlp3bnVL?=
 =?utf-8?B?aE10aU55VlAxdDlzWmszY0E5VEhSdHRpWSs0WFRUeDNGcVpaVllJckw1VHFJ?=
 =?utf-8?B?V2JpcjlXcHlFc2NLYkZ2ZFBqWi9SaHFRVEgrcGFDSmc2QnYvL0g2MzdPNlk0?=
 =?utf-8?B?aS9qTWNyV2FrbE5iUGNSTHByd1BpcXZjTDVEV2trT3ZuZ3pFM1B2QzF6T0xj?=
 =?utf-8?B?T2YrSlM5VFJyU3UwYWlkMWt2MzlWODFMTDRwSkV0aTZiUmNGR2pRVUpGVktr?=
 =?utf-8?B?algwMnN6aDNpU0lqRmdyaWhtbU5TTFhQNWZ1cXd6U1Yyd2FUSkxINldnK090?=
 =?utf-8?B?MEJCdzYvenpya2pTbzJZWVRRdVExaTZYK3RnbXdBY0VycUQ5UWJKRXJsTG02?=
 =?utf-8?B?dktVU0RueUdEYWtlWGg4UEhybTZ3OUpoOG1rRnVhTXljK25HbldOcTNMYkoz?=
 =?utf-8?B?dnVpd1RVd3RpTklVMmFsc3RRUWR2UUdrcTBaTDh6aEFTU2dPMFRDZDdmelVs?=
 =?utf-8?B?T0p2eVFFeTRIbjNreFBjL29pdjFZUzVYVHJjYWRiWjc4NFlreHJ5eFRxck0r?=
 =?utf-8?B?d1JibFMrUDkxZitWcVVwdTVBOVZMUDhrVXRNYXNYQnNMN1N2Y3B4R1MzMjlQ?=
 =?utf-8?B?c3FnY2sxaWpjb1VLYjRDZ0ZoMVVQZW9oVGpka0JubERIbmU5OTVhcFZyZDhi?=
 =?utf-8?B?M09Ja3pOY1lTMEVUSmlSMlFWZmg0N05LNjlLSE85RldaSElyT3BCaExxMjhq?=
 =?utf-8?B?Uk5mVHVrbUNpY3B5TTg3Ukw0SDBlMTBBRXZHQi9NZkJocGJXaEIrM1RjdGVu?=
 =?utf-8?B?dDBKOWJTd3hwS0pqNG5EVWE0TGdGZ3BmZDZlRnB4azN6OTUwbVdMK3Z3ZjRW?=
 =?utf-8?B?eWRBaDNQbWxpVEpQT2ZaeDUybm4zdHk3MzE0eTJaR2VmeHh5Yk0xTXVITjFj?=
 =?utf-8?B?MENEMUJyV0hPYXRNRkJUbXQrQyt4dDhkaHZqd2NjL0cxa2N5dlhEUlg2dVhj?=
 =?utf-8?B?VFhzV25zOGFrMnE4VmwreHpKcUhDVXNvajY3eDFrS3RwSk5nZ2txUHFDUEFn?=
 =?utf-8?B?RlFDZ0djYkxpRVUyYUVjRDlkYm1MdXpCRjhBaGFWQlUwL09mcE1FYVlENURm?=
 =?utf-8?B?clVITWxaY0xjVmI3ZzhQOHdDMmdHdDBGMUErYjM2aXNrYmdoUjRYYlIwZ0RF?=
 =?utf-8?B?Tk1WbndwckpVUkRyMkg5UjM2TWt1cTJGd3Y1b3M1TzBGSTd2bDlFTWIwQTgy?=
 =?utf-8?B?RG1lZlpSNnNmaWQwUEl2N1VTNTBabzkrWEFBcnBBMnVMNmxSaVdSSWtJMllX?=
 =?utf-8?B?UTBWekttMXhCN2Y2cUV1a0w4a0ZHZ1gwbElTTi9OT0x1SCtMeUM4RmhyOCtN?=
 =?utf-8?B?OWM3NVNDQ0xwV280RGxkMmJVcFkxaHJudXlPZTFicGhodWV0b1N4aTJyY0NT?=
 =?utf-8?B?SGNMTURwL21yVHhZTjFyN1ZVcVJZT1RSZ1VFR2g4N2hGTDlHei93S2ovSDB5?=
 =?utf-8?B?T1dWaDBYL2xvbXNpaFJydTFMMlN3bTU1WG1keGZudGlqb0lYeXhNZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcddd7c-f00d-4396-68d3-08deba0081ff
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 01:54:07.7653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfPyYaOSY6Moix6bp537BzFjOiDnt+NosSCAPg9jL3C7xaFGVF9ONRnBE8nljxCgfVBmfVJd36ilrtScrGfFcQ==
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

Replace devfdt_get_addr_ptr() with dev_read_addr_ptr() when retrieving the
register base address.

dev_read_addr_ptr() supports both live device tree and flat DT backends,
avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/sophgo/clk-cv1800b.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
index d946ea57a46..248a69321fc 100644
--- a/drivers/clk/sophgo/clk-cv1800b.c
+++ b/drivers/clk/sophgo/clk-cv1800b.c
@@ -500,9 +500,12 @@ static int cv1800b_register_clk(struct udevice *dev)
 {
 	struct clk osc;
 	ulong osc_rate;
-	void *base = devfdt_get_addr_ptr(dev);
+	void __iomem *base = dev_read_addr_ptr(dev);
 	int i, ret;
 
+	if (!base)
+		return -EINVAL;
+
 	ret = clk_get_by_index(dev, 0, &osc);
 	if (ret) {
 		pr_err("Failed to get clock\n");

-- 
2.51.0

