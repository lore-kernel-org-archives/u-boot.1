Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43719E6C5F5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EF968964A;
	Tue,  3 Dec 2024 04:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B78DF89617; Tue,  3 Dec 2024 04:06:07 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 770DC895FC
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVit7nfSK+xW74UJaMkjBdvFbL+wVvQhz18u4irtuFKBVyY+To0qHoIIAnnwS7NHL2LOReq/nstboyaev/oZgsdXO1fCPfP0D35eIcW8akGL+DWJR6+2HY9CsuYxQFWdQpDDoMdj/nhV30dklRMzKUm0XdgEAhL04lB4dsCclukeUu5uMd8L1aLGeKa3xL9GtooW6jDhtq3iSFtHpYUz84qsrToF9yoxz8DdxtD5CnWXr8BUajGFtqdUshC6NxCtbvaU6oGmrvaAbIcSz5AqKOpAttKzrRH+qDeBnQphiGf+Az6QrGV/0MEK4Ft9KNHUq42ugl5mtQAXPnE5Nvi6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agswTGsNWw/lFEda9W0e8bCFGQpen07619X6C0/7Npc=;
 b=DuWXre7MzHIDhyPpaCiz0OWSJuB/1VBjQVHCLrfdOSJ1creggg+9AzQOkeX6K+IzHbB+q8abzLyrJjQPTBxI3ZfP+C8Ueto9YKHe0YeZiLF+b4iFWozR+LgnB0CbBlErV+VgPJSk8ixR9lp5GcQXYJIboTt9P510Btvz05PiG0cYYCbN9sXTY1mSKYH80tfcQnE0fzcpNTVQnCa01fuJbW7CDh1vwejxAsiRsFrU62ofgvHNXLb7nfQT9apuvYczSHSW06E1eFrbRNjneiZzkZFcd4u5S0EZv1z26o0Umw1OKr9YU7jyE0Z14qAwRdAol1y6py6Db193UJpaKtGOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1180.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 3 Dec
 2024 03:06:26 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 03:06:26 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v7 07/12] board: starfive: spl: Drop the unneeded DT
 modification code
Date: Tue,  3 Dec 2024 11:04:25 +0800
Message-ID: <20241203030430.26089-8-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241203030430.26089-1-hal.feng@starfivetech.com>
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::8) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1180:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e486c3a-f8a8-48fe-cd15-08dd1347798b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|41320700013|921020|38350700014;
X-Microsoft-Antispam-Message-Info: e44Lm9a578k/aLzFkGowxZfZ62D+/EBt6HKQmMlwC13IVtH/xUGJ2C+LEd3HKmgedp9mBr13Ir+3UC4VTlECe4qWlvUj9PtF+5kEQq+WYi6ZcjQvFLQZMIYGvNaPxDCHT0O/sDeWCRC1ZRooi7CK5gB93JLEMN53tgdoXNEe0xZNMopcVoaBe9sqA3VLFr03mNbdrc/F4/OIlfi+8qEMYVm+p1zfxRkJqtwwrokU9mcItE8/JnXYB2+bVaa9IQsxhGGiIxGjVBuFEFeyJ5BU/sjp71E1pRSdhWtje7+rApWLCghjX7BPoBRoxIU0gGxlSliqu/w5URLzX6db9HwZAtWQD9wlPpcHEDurJoQmFmRgipPpzDNUwHmDi2bK9Fhdfv0LPJ/wA8RBdTw+bEt2Ruv/dPCajc5J4gdQDbseDPbOAj5RP/7DMu8kDYN/eFXVbKSAoW9uYpQAmvi0IaCpfWUdUHM5yHAK5EhTtIqeauGS/AoQYd36TwleHtdGBGTPoKqA4QQHVVqdzYHfqIMbAFEoUfafDxBSmPrD2XxHX9qHXIgUZCwwVpD4XhO7XAL9LZRlMQo0NWJ9zcNbx89KjL90mK0RtzctssgIVAlIX2kw4YakzQx2RNxaFGNTFv4kiR6dOUpZ96wb8eX1lLwDZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(41320700013)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?55ixOC0F7FP2y5oWlISKqT3RMiMaNH7NtrAB2pLxFT7PW1sJtxCC2/2FYptD?=
 =?us-ascii?Q?RRJPGqk1igIlFrNiFIoD8nMJq6j1nSgr5njnUE67ubbdvgd+DrQK6ni+MQkX?=
 =?us-ascii?Q?I1ULefcuiO5ZmPoyL3O9Sx6H8CVAVm5a7ioj4YUmeJEx3Sutye/yRA1V13Lf?=
 =?us-ascii?Q?IKDqhDVIE/uxlflz7ekGLBbOKguY34JaQmI5eeCgjUpccpX0SwQ545G12ppM?=
 =?us-ascii?Q?dG4gNKFvBGMdVyT86ULsJd+fttOGvC0/zXTurUD2kqEqXW6fS7PjAhLvupkZ?=
 =?us-ascii?Q?w4f6Ed5pdp2FJ0I+IuVXreMKUAX7jxahAwDBomF3ur1UjMw/CN3qJwoGifJ6?=
 =?us-ascii?Q?HscB7nq+FVim5Ecat9nDXVGtWdIsVrASeU57CT3j557r8GKHL0QfSoo3w0XR?=
 =?us-ascii?Q?0frcgbdKwzvFze7l1rxSYcW7B/htmVgyiSa/V08g6iqmGWI68uz4OLJMbGsl?=
 =?us-ascii?Q?fGgX8UqbwUc+ziYdYDbRaoqUGlZpXpK5QKbOZyRtdEUHUBLWx+P79LsGchhe?=
 =?us-ascii?Q?hxEvx9yO3+UCFd1yAS9/yCGLFYSpOYjzR8JM5ZqvLqngJNf0B4L++pEBJXdy?=
 =?us-ascii?Q?1PvJrcNplOCQEprVHlj/Xz91g4+8aQ5l9emx3c8NdJZnvS23k7pJvIpN4Utg?=
 =?us-ascii?Q?9j3YBar/cSGD/tSoYulFiCxEGHj+PyIXlIB43OxympCKlouZ51OaIbd1TRdI?=
 =?us-ascii?Q?ORUxZCk1auWNECmXZ5KXWldIPJ2g4a8q/MwQCSwn3Ro7ROCQUUtDc6W1I3ze?=
 =?us-ascii?Q?GO5a8NQfAGWHmG2gUKfLmLce5aCUFs0Ya8Le547rlGt6z6F5oQ4cUqjYZpHT?=
 =?us-ascii?Q?v6K/x9rY/OjPsOUNEzFXYtourIgwQe7cHX7HlawSyd38pF7ExQO79hEZsxOU?=
 =?us-ascii?Q?3EYQNfeQstYNuwHOvdKuKKx153picWezF6mgg7+BuzvEchWdHM3qnCL8EKJ4?=
 =?us-ascii?Q?orwHbWrSbiqIg02rdBfd35/l+5XYSsydV5U/GX5SdpEml1T2ZVp/CqLBEfXU?=
 =?us-ascii?Q?3CR0H/qCD6xpV1OAWcYN/4NFpQ7o+miosr/VXXAOUVQa7MUexDuCVWsBppts?=
 =?us-ascii?Q?vN/vf6K7CWdsm5dr5x5wHpHJrUYf8XzEMafAN17DU1xnT3D7EypuOUgy2DLM?=
 =?us-ascii?Q?MYqfqq9/Xek/S7s8VTv3gKV/rRFhWpYosWFtMhrM4cviqQhCSV4E179ZcL6t?=
 =?us-ascii?Q?9cWPmKwJJ/1lCRMZmuNVshFcoIsUWC4KUMeXlI4AmJNui8sLo6j8Lwy0hvXu?=
 =?us-ascii?Q?1qWKbR9G+oW4aHnbBwPvbIbwS/bOpm3nBZQfUJnbBUnYZRKBde9y6YvmjXFQ?=
 =?us-ascii?Q?9TcLc18bVXSerKY6W+phb5YLaYcFVTy1NkZEcfnRnlYRBawq/m2VXaMh8Tfk?=
 =?us-ascii?Q?yrrzyWIb0bFiKbvbL/jIh0a3zVBmcOUGoDU4HsPkL6rq3nujwyBW5vf5Ty1K?=
 =?us-ascii?Q?/kfdt1Ptsp5kjnrYfQZrVuEpxyrdTMqY87R3eDGaKPpTeslkMIbBQTMLyJrx?=
 =?us-ascii?Q?kS1ypKEweyWNB8syuoBBfHj7QtMY/6dWhDF1jPP3graqAui5oMNc+Kwhi52j?=
 =?us-ascii?Q?GoK5PaZuenI8Ngkqh8kXJ0CKk1S2KfzMkJpKqmwBdOstGn3ysF+rjHBCZY+a?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e486c3a-f8a8-48fe-cd15-08dd1347798b
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:06:26.0565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JclsM94uJVNOgDIhV6ZWUDgGLyYvFUd/2Ou61reX6I0tRO/yegzfVvmZf8XRqnFZLkkWmYcCJ72jX1Q7oYmhDZprAdCMIhU9c0uclaOzJJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1180
X-Mailman-Approved-At: Tue, 03 Dec 2024 04:11:50 +0100
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

