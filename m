Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7368EE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 13:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51DC08971E;
	Sun,  8 Dec 2024 14:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81AB789515; Sun,  8 Dec 2024 10:21:23 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7776089502
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 10:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6TxLHHYmQ8mzf52iDTm+M/aOGqpVjJrVaphJQLaxjLdj/Myz/L7Re7bCK+n/Nt/V7nHio/BCGHXljpRxHS4AMQEOGb2moewH3Kk2/6m2jn0HxxyEyDTOLUjp8i6589oeCVRcyFpfQbwX3U93n0RnBb9evZvMo/UAfJbZMeu1CXn+aT/Klie2IR0krGc/Zm9PV53oLSmTNGVW0v6cobueTjZGR6TZCiQqez/IEYWklhesuYUE/uqtAhFsYfUdAKzkT0XFQ60g8dHBLmZMxqX/QvBI0g+2Zw2Ci/o371Bmvz1C3IgKVkHUljO7MBIJ7ezDAUmuqowTjIHA1gNKL1v7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agswTGsNWw/lFEda9W0e8bCFGQpen07619X6C0/7Npc=;
 b=HDBtVSjFrY9Kmi4s6QZvIhB7bkNdtoJBzAxXvop/+JoTlTcVN54IFp+MYnuoNHjGsrMOss61X8z3YWbX86Wf1wdk0wJWFfVu6YVNNr4GGD6vhdditE8ettrNtBttYzIzxCIloUD37XQUS+2nyuU3rDYEKAe5PmfeggYbophUZyjadvuwmokj4gteR5ZTC1GSZNrb/T2ttuZ6W7lO3QNkt3ieR+VZAfVdWQBBvgwOWm4y0Nvll2CEBAhSrH1DceYlSDmVHeGtGtARS+ym4Tu+MwTD7x6cnZDTeiu1lZvnPz0mm9aYC8aUMwDXPWT8qrTndEwyf89gd1Nn8bwa3B2JYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Sun, 8 Dec
 2024 09:21:41 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Sun, 8 Dec 2024
 09:21:41 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v8 07/12] board: starfive: spl: Drop the unneeded DT
 modification code
Date: Sun,  8 Dec 2024 17:19:37 +0800
Message-ID: <20241208091942.47298-8-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241208091942.47298-1-hal.feng@starfivetech.com>
References: <20241208091942.47298-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1226:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf878eb-babf-44cd-cba7-08dd1769b9c9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: ZEgNdH0jb7Uv89F6S1GWVtQHCYvXInkiid3TZNWH/vaVzAjkNerJX6j+uYOUMJu7Tt6YrAJ5IhduvTs+C2PHsh8X1tpKnaxn2B9pISnZtpo/rGNbE+jOB3ApwQJyqPP17ug1RE2S0aniDCkNBLHjvw1vccsCJCfIGaC9WzE2eHvvvP+PxlSz8tkW3JK1PWJ8+oqk1Zs1U5lMtP441Gg1DoNdlq92MtsIRZXyxWbdoJgAGRkGlJ5+eysdGsYzyBA02C0QsFDhNlmSO8wgMf4R5E9llghqTgIWtCAa7JvArxCYIO8WeVzsSH+wF1Y0whT52KVDoZO7ylod2IS6ZVd0I+qIbqep9wRYn+aodSgufILq0S7ODzkrcyXAgDCc6k3sOcnVa91QCZoIr7/m5MQzmgJNfTzXZJ8I+J3+Tx4Nq8P3ibP54jv+ifT1RpHkzZakcexfjsUqwmwMpxQ3XzN62Z+aHf67i8Q/0m6NUUV/AWxA36bwJPapLZLjvn9Fb9j8cEZ1ht+zr6le9TS653Zmn/5qllRZ3osCSg6YkLQOjbw1UDbXbEAOOKRd3GuIfwhwgfGZgIFBgHpJ/enzkksGW/xE2bT7NSmhpH7LLhol+ESKwsNNi4vlsX3bwNGZohak83Q4OV2R8no3dWfj2oDwWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8161ciazkkQIW5ddTUyKMCRo4B4VM/WI37IzHktRYkPAEObTUiSn1dCorRDz?=
 =?us-ascii?Q?xmO9IDLdRX4lxnOYiTnsaXzbdF+hlTjC/eVJZ2rOHDKny64sHgB2i0cpt2+4?=
 =?us-ascii?Q?yFQSzr/3LvptB5vZK6fWZ1ZLs53X/Q3SE0twmUZy1ad4Vd0pFqhV+d2cfFSD?=
 =?us-ascii?Q?zgpwjQ9O+fLa07LujhLjmziNgtgMOUq5G/g46D3REYA3v9owyde5XNZo3dV1?=
 =?us-ascii?Q?txRrcJzDWAVqAa1MfYK+8/Cm4pXK99Y0vziIcv+XS6XkywJoMPOisdDQ5o/x?=
 =?us-ascii?Q?So02gVNkGWMgufp6lsBzAXk0ogH09pqkhC4NhrRo6M5kJFRDOQJv/va6Ho7a?=
 =?us-ascii?Q?Hxt1izAmG5uHnx1ltLUKfjokCR1wrE5sIeLR1/Qj8uUaHraY4F6aeDN52q8y?=
 =?us-ascii?Q?CyJ8trx14878g/P6rvLz+rcApDovFSpHEdcTbWTjfhloqloO8W7DKFtHAspH?=
 =?us-ascii?Q?8mLb7LdjmlekYriHdfSd5in25E0/sPU/zO5/bUSxTxfRwLMLCVL+Oqka9c6j?=
 =?us-ascii?Q?t6SGffEYJMsPfYMmiiyqAe9ATzftivqRumMZdYVBLHfWEnXXudbYdUEEwjVl?=
 =?us-ascii?Q?4RuIytiobdHn/KyVVt7RtIbKMgfnGqxLs6kcuoBLVQ//L4sFTn7hO1cU7jX7?=
 =?us-ascii?Q?rTrzVtanrRq0o8iblK8Iyu3VBbLOAYnTo/5cJ9+kDWzIlQZAbciycpcKRwNK?=
 =?us-ascii?Q?Z0ntckAQEq8UIUnZ1w+YJYmt+7/LAh4f+VYu4v7dlPmQqqzd1NSpd4qSh3EQ?=
 =?us-ascii?Q?fzrLDJuuBt6NEI9+F0KMpmBPnJLncr0W2WN0EwX2u/Kld1qlhsv1AeuOD1oz?=
 =?us-ascii?Q?jZkWNLgOZdlPsVRwR0EvbIuCf7DRY9uIDSxVMpqIgOPU71Sk9i6EjToYLUgO?=
 =?us-ascii?Q?3klaYImKnlAmdylHg57vwzEzd3mhhK+bYH5/FUmNR1p+ZkVjzWznomVccExd?=
 =?us-ascii?Q?JZZ/ppC88iHZBZ8NzNYRZIv5aYfd1exAvMK/YAsZrvbLq8rqdgtfTTS5XEM7?=
 =?us-ascii?Q?1EQfj0WkxjVGVsOUda+5AX4bjcyUucYAHDhuW5yadWZoiOEJPotbTYOCm4cF?=
 =?us-ascii?Q?QsoZKKpJy3a7GuaYZ9vRsGqcmHXbRvdjHXJwWnSKv/yHbeRICitTfBXApOvQ?=
 =?us-ascii?Q?YQcvg5Tg4B4XvKfwAMZ3ZMfPnyGTmqx4N2l9uCBrhTtVsqS2kFHAlKbK1C9P?=
 =?us-ascii?Q?/ue9wYvj//9Ro63F2Qj3Vm2uWDnHTZCOLaZ7NBtlV6CmkH4Tkb1cEZQUqTEN?=
 =?us-ascii?Q?byefOVGg+Tu5JEucxYPqVq1NBXJlcRYlJKjad2KTqcG1yRITVcRYiR4JmE8z?=
 =?us-ascii?Q?zlAlpLqnZQUT7vY8IoTg/rZjBQM7WZ5hQdCP0VQfbbVWLjKN/mWTrZy8xanE?=
 =?us-ascii?Q?2NOsTaNHdG9CmpJs0cl0Wnpus+Jqo5Bd3AOD654JryWf99Mj4UYVba0Jbuki?=
 =?us-ascii?Q?UcjEfo3vIp96TPk6pHdiIWbw+z1Z20ishM76Lbu766ni6rjL0wapKL4GjpjB?=
 =?us-ascii?Q?13ixqAm7NyTsfzZRpS91l4RChzmGS6beDIFIf5l6lv60GYeqQn+sOzxBz/0N?=
 =?us-ascii?Q?mQys61copQLVrOTVkB6FmUKEM1+94KVnE0pG7XMPFObSpTYi9eiq2Na8ebqB?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf878eb-babf-44cd-cba7-08dd1769b9c9
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:21:41.3597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TX75UMH8BXBj9bf4M5Xlc72PEL2tIYy/xMQnMx7na6k5ZhKMsO4U19V/dT6MNIu24U4BvO3i8uKLlzpelKJIBambFkKqnN0XN6LohSrWqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1226
X-Mailman-Approved-At: Sun, 08 Dec 2024 14:25:45 +0100
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

As OF_UPSTREAM is implemented, these code are redundant.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 356 -------------------------------
 1 file changed, 356 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 3fd535e7cf..38132ecccd 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -20,364 +20,8 @@ DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_CLK_CPU_ROOT_SHIFT		24
 #define JH7110_CLK_CPU_ROOT_MASK		GENMASK(29, 24)
 
-struct starfive_vf2_pro {
-	const char *path;
-	const char *name;
-	const char *value;
-};
-
-static const struct starfive_vf2_pro milk_v_mars[] = {
-	{"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
-	{"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
-
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-1000-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-clk-drv-microamp", "3970"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"rx-internal-delay-ps", "1500"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"tx-internal-delay-ps", "1500"},
-};
-
-static const struct starfive_vf2_pro starfive_vera[] = {
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0", "rx-internal-delay-ps",
-		"1900"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0", "tx-internal-delay-ps",
-		"1350"}
-};
-
-static const struct starfive_vf2_pro starfive_verb[] = {
-	{"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
-	{"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
-
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-1000-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-clk-drv-microamp", "3970"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"rx-internal-delay-ps", "1500"},
-
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{ "/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,rx-clk-drv-microamp", "3970"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"rx-internal-delay-ps", "0"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"tx-internal-delay-ps", "0"},
-};
-
-static const struct starfive_vf2_pro star64_pine64[] = {
-	{"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
-	{"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
-
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-10-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-1000-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-clk-drv-microamp", "2910"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"rx-internal-delay-ps", "1900"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"tx-internal-delay-ps", "1500"},
-
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-10-inverted", NULL},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,rx-clk-drv-microamp", "2910"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"rx-internal-delay-ps", "0"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"tx-internal-delay-ps", "300"},
-};
-
-void spl_fdt_fixup_mars(void *fdt)
-{
-	static const char compat[] = "milkv,mars\0starfive,jh7110";
-	u32 phandle;
-	u8 i;
-	int offset;
-	int ret;
-
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
-			   "Milk-V Mars");
-
-	/* gmac0 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@17000000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16030000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_GMAC0_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_AONCLK_GMAC0_RMII_RTX);
-
-	/* gmac1 */
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/soc/ethernet@16040000"),
-			   "status", "disabled");
-
-	for (i = 0; i < ARRAY_SIZE(milk_v_mars); i++) {
-		offset = fdt_path_offset(fdt, milk_v_mars[i].path);
-
-		if (milk_v_mars[i].value)
-			ret = fdt_setprop_u32(fdt, offset, milk_v_mars[i].name,
-					      dectoul(milk_v_mars[i].value, NULL));
-		else
-			ret = fdt_setprop_empty(fdt, offset, milk_v_mars[i].name);
-
-		if (ret) {
-			pr_err("%s set prop %s fail.\n", __func__, milk_v_mars[i].name);
-				break;
-		}
-	}
-}
-
-void spl_fdt_fixup_mars_cm(void *fdt)
-{
-	const char *compat;
-	const char *model;
-	int compat_size;
-
-	spl_fdt_fixup_mars(fdt);
-
-	if (!get_mmc_size_from_eeprom()) {
-		int offset;
-		static const char
-		compat_cm_lite[] = "milkv,mars-cm-lite\0starfive,jh7110";
-
-		model = "Milk-V Mars CM Lite";
-		compat = compat_cm_lite;
-		compat_size = sizeof(compat_cm_lite);
-
-		offset = fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
-		/* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_NONE) */
-		fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
-	} else {
-		static const char
-		compat_cm[] = "milkv,mars-cm\0starfive,jh7110";
-
-		model = "Milk-V Mars CM";
-		compat = compat_cm;
-		compat_size = sizeof(compat_cm);
-	}
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"),
-		    "compatible", compat, compat_size);
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model);
-}
-
-void spl_fdt_fixup_version_a(void *fdt)
-{
-	static const char compat[] = "starfive,visionfive-2-v1.2a\0starfive,jh7110";
-	u32 phandle;
-	u8 i;
-	int offset;
-	int ret;
-
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
-			   "StarFive VisionFive 2 v1.2A");
-
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@13020000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16040000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_GMAC1_TX);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_GMAC1_RX);
-
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_SYSCLK_GMAC1_RMII_RTX);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_SYSCLK_GMAC1_RMII_RTX);
-
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/soc/ethernet@16040000"),
-			   "phy-mode", "rmii");
-
-	for (i = 0; i < ARRAY_SIZE(starfive_vera); i++) {
-		offset = fdt_path_offset(fdt, starfive_vera[i].path);
-
-		if (starfive_vera[i].value)
-			ret = fdt_setprop_u32(fdt, offset,  starfive_vera[i].name,
-					      dectoul(starfive_vera[i].value, NULL));
-		else
-			ret = fdt_setprop_empty(fdt, offset, starfive_vera[i].name);
-
-		if (ret) {
-			pr_err("%s set prop %s fail.\n", __func__, starfive_vera[i].name);
-				break;
-		}
-	}
-}
-
-void spl_fdt_fixup_version_b(void *fdt)
-{
-	static const char compat[] = "starfive,visionfive-2-v1.3b\0starfive,jh7110";
-	u32 phandle;
-	u8 i;
-	int offset;
-	int ret;
-
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
-			   "StarFive VisionFive 2 v1.3B");
-
-	/* gmac0 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@17000000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16030000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_GMAC0_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_AONCLK_GMAC0_RMII_RTX);
-
-	/* gmac1 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@13020000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16040000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_GMAC1_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_SYSCLK_GMAC1_RMII_RTX);
-
-	for (i = 0; i < ARRAY_SIZE(starfive_verb); i++) {
-		offset = fdt_path_offset(fdt, starfive_verb[i].path);
-
-		if (starfive_verb[i].value)
-			ret = fdt_setprop_u32(fdt, offset,  starfive_verb[i].name,
-					      dectoul(starfive_verb[i].value, NULL));
-		else
-			ret = fdt_setprop_empty(fdt, offset, starfive_verb[i].name);
-
-		if (ret) {
-			pr_err("%s set prop %s fail.\n", __func__, starfive_verb[i].name);
-				break;
-		}
-	}
-}
-
-void spl_fdt_fixup_star64(void *fdt)
-{
-	static const char compat[] = "pine64,star64\0starfive,jh7110";
-	u32 phandle;
-	u8 i;
-	int offset;
-	int ret;
-
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
-			   "Pine64 Star64");
-
-	/* gmac0 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@17000000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16030000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_GMAC0_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_AONCLK_GMAC0_RMII_RTX);
-
-	/* gmac1 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@13020000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16040000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_GMAC1_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_SYSCLK_GMAC1_RMII_RTX);
-
-	for (i = 0; i < ARRAY_SIZE(star64_pine64); i++) {
-		offset = fdt_path_offset(fdt, star64_pine64[i].path);
-
-		if (star64_pine64[i].value)
-			ret = fdt_setprop_u32(fdt, offset,  star64_pine64[i].name,
-					      dectoul(star64_pine64[i].value, NULL));
-		else
-			ret = fdt_setprop_empty(fdt, offset, star64_pine64[i].name);
-
-		if (ret) {
-			pr_err("%s set prop %s fail.\n", __func__, star64_pine64[i].name);
-				break;
-		}
-	}
-}
-
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
-	u8 version;
-	const char *product_id;
-
-	product_id = get_product_id_from_eeprom();
-	if (!product_id) {
-		pr_err("Can't read EEPROM\n");
-		return;
-	}
-	if (!strncmp(product_id, "MARC", 4)) {
-		spl_fdt_fixup_mars_cm(spl_image->fdt_addr);
-	} else if (!strncmp(product_id, "MARS", 4)) {
-		spl_fdt_fixup_mars(spl_image->fdt_addr);
-	} else if (!strncmp(product_id, "VF7110", 6)) {
-		version = get_pcb_revision_from_eeprom();
-		switch (version) {
-		case 'a':
-		case 'A':
-			spl_fdt_fixup_version_a(spl_image->fdt_addr);
-			break;
-
-		case 'b':
-		case 'B':
-		default:
-			spl_fdt_fixup_version_b(spl_image->fdt_addr);
-		break;
-		};
-	} else if (!strncmp(product_id, "STAR64", 6)) {
-		spl_fdt_fixup_star64(spl_image->fdt_addr);
-	} else {
-		pr_err("Unknown product %s\n", product_id);
-	};
-
 	/* Update the memory size which read from eeprom or DT */
 	fdt_fixup_memory(spl_image->fdt_addr, 0x40000000, gd->ram_size);
 }
-- 
2.43.2

