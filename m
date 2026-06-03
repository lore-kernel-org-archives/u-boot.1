Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCB5CD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 05:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE44184857;
	Wed,  3 Jun 2026 07:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gZCMR6cc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAFE084878; Wed,  3 Jun 2026 07:49:56 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A93D84855
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 07:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9wU0/8OIfrY38T8o8VSm+MANGDOTH+n5kinyN1nYyjGUUYhz1JDXohQr8vQCbAG1D3+WJt1cZL8+Xoyip53yKCqyL3emcXJsplrYoRR1eEgle3ptkxb4WA6xhbcXkyRD0Xxsx7AwENu6XGj2owvjwDzQ87Jv+7pyJwmNMO8GjJ3rxLBFYxeuEYCfA9oyFGn6jnmhb3GNOlf6dV0wvfD2vQ7DujYhFk3w7UB5moVqpfKQvjAj8xub8Qssuj7tOAARLEhK+gsjcGZK9fMKrG1bsdAm4+Opy4SNBbCxVoDWEQeWsh1VSUb1kTHL9WP0Wqd3zPvzU6hpx6E8tXaiwIy7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQs3ysoHSQsuffki7eBxrYSNYX3vb5HoeMwQhPHY6eM=;
 b=HQEVmTUIuQUpI7qMVOk0jDPCFADfnYwxePlN5UbJsguoIjrkZTNusCz82Dz7xvWUnoEHjIVVNwzEk6LfcXZyrLRB4xEChVkHNvp8XDC5qyu9nDujpMf18iqhjXcL1DIQjYB8cQa4y1dNTdTdWx3xcmFrmRIxrOebpMBdPvLWob8kuc0SOJm5RhZFXeG5rCsR85ZXUA2N0IGG9d2vfWt4j8zVoAlXOhh/xcf+LaHjt7tzOUjY5gDqrFYjUTuLX7u5s+FBUmCqAek7JZUvCnHUMnXPC0GLQv05AC6KiR7x3H72so8wlL4qpozC0+8kqdKpgV/z3JLA6IsF5Zp002IGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQs3ysoHSQsuffki7eBxrYSNYX3vb5HoeMwQhPHY6eM=;
 b=gZCMR6ccA8QDxZcAWZOJmnE1ALCVPetpYtWkLrjmZ/WK6XVy9QxTIlHtp6dxVIlvm1g3hN1Bdpuh8qbxwj0lqXby1fZCw3RPbGhlI3bwvnkylz8fA6sTLGx07ITdp+srMrih69LhAkJ14oiwEstwnwAOQLwrAZ4nlSStvr4c7kapEN8FIXTF8D/allEYWxhTcWUJLcdPcu637H1NIS5XbRh2yYhPTXBr4U+VT0MxJKOxvAvEq5a9x1WpucmloZcJ3vjPc0o++qZe5WcUTCXngywEdfsJd67e+uSv4XQYDDVkdt1qvpvNetI5tPsL/CJRcAmEvHk9YWkECZaPoj5sWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com (2603:10a6:150:2d1::6)
 by DU4PR04MB10648.eurprd04.prod.outlook.com (2603:10a6:10:586::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 05:49:52 +0000
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6]) by GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 05:49:52 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH 2/4] imx9: scmi: Print CPU part number name
Date: Wed,  3 Jun 2026 13:51:57 +0800
Message-ID: <20260603055159.414338-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260603055159.414338-1-ye.li@nxp.com>
References: <20260603055159.414338-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0165.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::7) To GV2PR04MB11760.eurprd04.prod.outlook.com
 (2603:10a6:150:2d1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11760:EE_|DU4PR04MB10648:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8c3e4d-4d71-4f6a-16f1-08dec133eea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|19092799006|366016|52116014|376014|22082099003|18002099003|38350700014|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 9niQb/ut6HLbxf9IoqVsxEl4mLi2SZPJHod4ZF620k13Zzn+NUbJvcOIWUdYyFtDGEkqIdiR5NlBQ1ZTOL4IcgXRAfuCutxrS9VYth10wYx1JbiwND34UhHpHKqeBth4FfFNBzJXVuqwLhJmKNKz9E1gM2G2nO4FqQDzT8crNLKDXpD/l/kEkft9MxcbHYfI+wvdJvXoAfMLsokkuIbcMCs65dpobts9nkWyY2SVVSfDyUEf/y2ds6S8QxK5U/7aaHV9qj1EgmcImRBJ31jNsEzvJnAGAYed0JnZm1Lpi/q5TQkO5TRb1R3wTJezNlTEjsPOyKKeQ9F5kT7YUoCY8RY1ZY/P6UvsdaJy23P4/3VVwdYJq5iX+hc+U9cT1TuP2oGPJzgT/IiSEbaYt9JdUyWXhIx1IXYllasWK85C3Af16ESpFodFcIG6zI2fb55lTpWNjns9Y7jjX6oDJDJSxrXwGAIWYNmQaMgux2RIAGiEeuSpCIzZTnuLZM6srVS1qD1K50M8k4c5iyrfuP6C6VQ6j4mVygpPUpXHy4TXfpZQLnL1SUecoAUw4Q6d/kvTz/zojLYIF0aH7LfzeLYg2K771F0it2Eev8KSTwQhMV3hTm2zd2fhyG0b70bvEVTz5TMVm2HQHDL2um3RaOBYCQ6iIxx4jRBqQYBbny5/4SitcbVcm9ulfMjIYYqRKfRyIJZHMkAFxPDMkOAbSOU99dxev07cM+Bvx/9MYwF2QyZVs6+G+j6kLCJ2QEBveTbq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(19092799006)(366016)(52116014)(376014)(22082099003)(18002099003)(38350700014)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?51TsMekjd5cayomw2dvsE7TaKO2TOSwZ4MyO4IZQwvmYnNx9fgwiL/huQquL?=
 =?us-ascii?Q?lMMsmxMjh9x6fyV50KewtNjDttq/a5ysTqCDH+aB2oR3xfdOq2F6iMfZF+vt?=
 =?us-ascii?Q?FE+M6gcUWGOmOpiqHBy9hqKhOCjZ+5jXaLU+3WRb6Fvlaq24ptOlesbijQ4f?=
 =?us-ascii?Q?K9uyDblUHLgIcsMZGUUOSu4xVacKBf0X5yZnJB1skLMQo8y/44BNMOE5gwY/?=
 =?us-ascii?Q?1iuyXUwWHGWL2leDM2gu4XPiJU+YqbWZG1Hat8HckTxOU6Ia2rLmVLzN8ub6?=
 =?us-ascii?Q?xUvDLGu0KGFcY01dR+/n9mJCCqQuSdeLFvLhq16DviKYnO6mufaoibYGeude?=
 =?us-ascii?Q?Sqy93l3we8fYGxVwmt2/fguVDOZo2DwbWBfDLacgFIXzaUGwNBZRlt+VE1In?=
 =?us-ascii?Q?13r3ynXipe0/HwyHlLe7Bm6vRvurIj12S2oqVeTfJKm8Im6MTc2+fZEsoix/?=
 =?us-ascii?Q?HqoRuNdlXf+lDlT3HR4dU/XLZxvD2jDUeNEaINvxXk3TgqiYUeYNH7QVORr6?=
 =?us-ascii?Q?T1Q4JlIY6ly+LM+2lBPNaLTe05xzS3gwNnXOaYLkSJq0POQIsTUrFI6b4tg9?=
 =?us-ascii?Q?lsSDTnS951h3Cc6OCu0OJfzXBVM0vtGBy9UHXGr7EDHMKQEb1PvWipcH1QMs?=
 =?us-ascii?Q?crZHjuGaBtC/f30quzAdzYEpyKkaNHB1ZQPw6cRl6NtYXGdwaZnysiTxCBLE?=
 =?us-ascii?Q?D/IxybooO6D6h2FanUAYwmyLkMU9UGA9ny6tW2BA60Do/MJSFxKkKomX6D6L?=
 =?us-ascii?Q?pbjBkaYhJjEqWZdAJjvZmqTOnMLcXo2Rlk+HS7EAIo/ClpjJ258jwge3yQqr?=
 =?us-ascii?Q?+uAxdWoC+M+FMJV2jZ/6xqwbrEjxNJ2J81AFegFtIO1hxL4swb//gyMX/stW?=
 =?us-ascii?Q?gQZHwEXKCXOs9OwZazdoZg0NfLpKRtVb5T7LIBRdzn8F6yyINhR/NEHGPM7e?=
 =?us-ascii?Q?1V8pLhUmhl70KpH6cjopJboGso9zzqJ/Y6398eJfnZih0Gl81TpeOHCaLDKF?=
 =?us-ascii?Q?Me0hYrvdTGQW/MYqwqz4RawbV/m/BH1VD4X6z6ciCeqkWHpUDUxgHOeHTzlE?=
 =?us-ascii?Q?ScHKn7SlkXfeKs49Z2u8GHq4ulVSCvR+D81q5WmOiXIcRIBgkxlzOfwAH8U8?=
 =?us-ascii?Q?2ujJeXCq48Mm+EQ3M3aObZtEh+qZz+duJTAI8VnjNsDwqjeOb2TzVmPsfQwB?=
 =?us-ascii?Q?MruULoUeMpfR7sXJS1N69nqIgb6CgH392X/Xqm76B2BKhtSi2b+6cnnBNCTJ?=
 =?us-ascii?Q?0E+M1AY2B3V7OAAFVGYPDeKo/ZPCT1CD5L90JuvNIwS5XkKMxKcg3A/k0tHB?=
 =?us-ascii?Q?OQ0F3MC5xnBBqwmWp7YvaH4npzXqPLdVefq2xe2uyN8BryyGH5tl0otTEx7M?=
 =?us-ascii?Q?WEEhSNEya1jkEaY2kV9WXQMty5+lXeqLVakGMUuZiU7wl5Dc+er//w3V9eeW?=
 =?us-ascii?Q?Sgw3ti0jgrR5SgtDeuYJkJpp54ldkACkUW6quS0Wmc0NOESlQpKJle7iqhhd?=
 =?us-ascii?Q?66MZXkd5FSBnHidvT0mgzyO70wEq+ljM/iuPjwMB5uD0EWcCvm066G/0vxXM?=
 =?us-ascii?Q?fhJPC/jnaz0ZgxMfbg8ffptiFIAj1AZV5pLhfi3nHeOtTkTvilWf7Xro0CCm?=
 =?us-ascii?Q?/GZ0aMYL/F6a3+4H9JWdU+chN41nS/HGKTxWo5rSbshKeNeJg23f+vegnpaX?=
 =?us-ascii?Q?V+WfRPmWpGjs3VZarPZLtNBrvw3H+QB9mN7Ibc5kd0dJ/P1t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8c3e4d-4d71-4f6a-16f1-08dec133eea8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 05:49:52.6979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruDvn1OLlG59FsNm7s/ZGkOFtdolzigTnm1LRKmx2W2iwKX9OnSW8oHp177bDwUL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10648
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

Decode the CPU part number from PART_NUM fuse and print it in CPU name.

For iMX95 and iMX952 Part number fuse is defined as:
[7:6] : Package description
[5:2] : Segment
[1:0] : Number of A55 cores

For iMX94, the PART_NUM[7:0] fuse directly reflects the
part number value.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 88 ++++++++++++++++++++++++++++---
 drivers/cpu/imx8_cpu.c            | 12 ++++-
 2 files changed, 92 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 76b6870620b..aedaa0d4bca 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  *
  * Peng Fan <peng.fan@nxp.com>
  */
@@ -709,14 +709,88 @@ int get_reset_reason(bool sys, bool lm)
 	return 0;
 }
 
-const char *get_imx_type(u32 imxtype)
+const char *get_cpu_variant_type_name(u32 type)
 {
-	switch (imxtype) {
-	case SCMI_CPU:
-		return IMX_PLAT_STR;
-	default:
-		return "??";
+	u32 val, core_num, part_num;
+	int ret;
+
+	ret = fuse_read(2, 1, &val);
+	if (ret)
+		return NULL;
+
+	/* Get part num */
+	part_num = (val >> 4) & 0xff;
+	if (!part_num)
+		return NULL;
+
+	if (type == MXC_CPU_IMX95 || type == MXC_CPU_IMX952) {
+		u32 segment;
+		static char name[8] = "95294";
+		char pn[2];
+
+		core_num = part_num & 0x3;
+		segment = (part_num >> 2) & 0xf;
+
+		switch (segment) {
+		case 0xa:
+			pn[0] = 'T';
+			break;
+		case 0xb:
+			pn[0] = 'V';
+			break;
+		case 0xc:
+			pn[0] = 'C';
+			break;
+		case 0xd:
+			pn[0] = 'G';
+			break;
+		case 0xe:
+			pn[0] = 'I';
+			break;
+		case 0xf:
+			pn[0] = 'N';
+			break;
+		default:
+			pn[0] = segment + '0';
+			break;
+		}
+
+		pn[1] = core_num * 2 + '0';
+
+		if (type == MXC_CPU_IMX95)
+			sprintf(name, "95%c%c", pn[0], pn[1]);
+		else
+			sprintf(name, "952%c%c", pn[0], pn[1]);
+
+		return name;
+	} else if (type == MXC_CPU_IMX94) {
+		static char *name = "94398";
+
+		core_num = 8;
+
+		ret = fuse_read(2, 2, &val);
+		if (ret)
+			return NULL;
+
+		if (part_num > 30) { /* 943 */
+			/* A55 2 & 3 disabled */
+			if ((val & 0x18) == 0x18)
+				core_num = 6;
+		} else if (part_num > 20) { /* 942 */
+			core_num = 5;
+
+			/* m7_0 disabled */
+			if ((val & 0x200) == 0x200)
+				core_num = 4;
+		} else if (part_num > 10) { /* 941 */
+			core_num = 5;
+		}
+		sprintf(name, "94%u%u", part_num, core_num);
+
+		return name;
 	}
+
+	return NULL;
 }
 
 void build_info(void)
diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 2bd76ffa739..7bb7b420176 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2019, 2024 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 
 #include <cpu.h>
@@ -28,8 +28,18 @@ struct cpu_imx_plat {
 	u32 mpidr;
 };
 
+__weak const char *get_cpu_variant_type_name(u32 type)
+{
+	return NULL;
+}
+
 static const char *get_imx_type_str(u32 imxtype)
 {
+	const char *name = get_cpu_variant_type_name(imxtype);
+
+	if (name)
+		return name;
+
 	switch (imxtype) {
 	case MXC_CPU_IMX8MM:
 		return "8MMQ";	/* Quad-core version of the imx8mm */
-- 
2.50.1

