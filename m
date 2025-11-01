Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A049CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9618A83B82;
	Sat,  1 Nov 2025 01:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="bIGIU5vs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B8AA83B64; Sat,  1 Nov 2025 01:45:23 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CF3383B82
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cp92QIqOBJmKd/FrRl7oY8KV/EjwLRRFGIgqP5TrWVqJ9l9eDL3wMFof4res53FW4+0t9VPsdL+SSHTtfLI3cv5dF2nK9iT1kOrEAHcGkJXu5jtKyziAqt6+bFNAhlzOOHTKFQmzug/3pv1xTW5Io8AIFTGx/MHQj9n9lC/wNnOoF8u+rslHkpp9SdTfYFupbJ2vyxLDGEK8Wy4k49QksPAsCI6WwQcPfV6kXcucwRAXFExdq16j7UswxjWnoBbvX+vQ7HZS2Yg+aUiDEQtHa6KI1q0O+VK5Ta2cr5yYVXv7uGZU5YltbGO52a0cNdaORUzYmZ3MhM7hw2hRY3+3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5pvAGWamzhLHUhS2gjuZyc+1xAxKMneLf2VVce+Ofs=;
 b=sFQ/ZQqZTZ7Ii1g9dULssaSVb0Yr9z/fa1uRkSOORaS70AtsrtH85glv1U0pIJDJhGLUzT+9p1wvrFvV7YM+c7lf43g0h4zI+a5FU4ZctGZvWrny7XcZeISIXqmkawV8A5uuHz6sFEsxYsSWebj2usxgDre2KBP8NUzAyqNhnrFmDV6k9Lg7RxjLxUKO3CZV4tFm1obNh8RDQB/yWYQJefuK2ZCErr8882nD2mQS9oD+DANS2+jGXNc2UDWCBi5xf7x0BAA7m1hL73YiHjEq/+vbCTYxqSEo9popwGb/j7fpvBGf5qQZMi5on0Ij2s7daGHPXSkRKK+XY7nla6jkvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5pvAGWamzhLHUhS2gjuZyc+1xAxKMneLf2VVce+Ofs=;
 b=bIGIU5vspEsPJhvZ7hF2Yr32nrq/qMzm4DW8C1ID7JJJDECOhOSvT/sVh51+aQ/ffxUc1f6PgvgEacnr5lWOCVSe+oEaHXOzARF7KrRwt6/hDV985abD4980+9akMCdb5AX+TPIR+QGG+LsR10lnRFu+E+FgfFbakH2PvJNgVE2PqS7Lbucw3hshEys36AYmtvT0d+8fEpSUf1eahaOnYoXOeYMeHwIE1MNvsUbsRMdakgZBjx0hONOVl/F1Ik6q1EJYXZ0VrfgJe4TJLK49zxpKIRoeXPaXZ7VHaup+oh5B6XxCSoF5gBPhvfqDBkcYD7w14ceaMI6/rHuxBPGN+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9258.eurprd08.prod.outlook.com (2603:10a6:102:308::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 06/19] clk: airoha: add support for airoha en7523 SoC family
Date: Sat,  1 Nov 2025 03:44:50 +0300
Message-ID: <20251101004503.2379529-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: af5506fd-a80b-468a-a296-08de18dfee2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O/Z27E20M19QGy8gmZPkVs7W09Q3hckKEsVbykh/+zoedjXhvkNhmwsjS7qr?=
 =?us-ascii?Q?+L953jgHPU88sOR/k3j09hx/ndb18eRoGS7YiFGArIixYuvBdflmjH08kght?=
 =?us-ascii?Q?P8JlPJISQTmfrKzHe2/DwgR/Tn/R8605S90ZOwHTfpvGOqOgCXFrsktLPVBg?=
 =?us-ascii?Q?FGoi0gCq+LS604MhnOKJLnJfsF16T7Q4dIPzOXyeEVgjPAi+zJ1NGbBSlxJU?=
 =?us-ascii?Q?PLqYF8LCMYI18DYDP0/MwU2AWnSqRDmOdILZAm1qpcF9h2drK8ON0ucAU199?=
 =?us-ascii?Q?S5f6udRm0xRuyIt93baZWD0dt9aygX/jYwFfMcalCQzCoJQFMCfp1WwQ3ncf?=
 =?us-ascii?Q?bKQ5r8n28ZIO91tqkmNqk/dm3JxdNkPGQcisU/B4WYnZmrYyRfFeYq304OXf?=
 =?us-ascii?Q?DFSr/Qpc6gU0uiMYamCet4R4aprpJfiMNR/GGEIqW3WaAlB8UTxRR1jE3sh+?=
 =?us-ascii?Q?5o7AZwgWN8sz/SLTjIV5QfGe9W7VOMyJwNu3Szo8zv9KgJNRZEMMckwt07je?=
 =?us-ascii?Q?KbwAZLzKpk4fGxF0wtlZJKUVZ2JOj7ACuwHB7HQbRhNNeJ56AVxpkY8dP/S/?=
 =?us-ascii?Q?qV0GfGnS0afQq6TFbtfaKC/7uWTCY60yqKL1yWyyAL1oZy3ZxxWtRojbVUnC?=
 =?us-ascii?Q?SFK0MPArc/Vi9VXdeHJGD75oZjFADJBao/6fK66POKuqkSIrW6T2kEgPPsil?=
 =?us-ascii?Q?iulh2MIrrVVwZBDRzUQdyRB+BNAdP4OXOnBiAkHd7SH4areH2L6D4erghyZV?=
 =?us-ascii?Q?XlpqfAYpZkVExP3N8KhxeP41v1x9OTV3XeTiWs+ktdbImX6vdc2QZfip11Li?=
 =?us-ascii?Q?dA1pM7aISD+AEynXoDniVWBje1X7hwd529XQL5yMsGolzp2XyHNUKJl27fVJ?=
 =?us-ascii?Q?XB3bjI7y0pHH8FNoLiiJk5nlwrBnMOW+cf4sD0G5x2g/wCFuyUTy4wLRbQcO?=
 =?us-ascii?Q?cdE4DjCVFQBRfLa+DeWjLQ23oPfK3TItmu0J/u4Soz22rRbgavydFxb70ieS?=
 =?us-ascii?Q?rSMhf/9am7iL+Gni8goCz+7rictI5ATPJdUV5iENLWShqCJz8kL5Tc6qUjLb?=
 =?us-ascii?Q?I4yUJUffJzC10pobmZx+KZEHVY3mUmddIiAwxdMO6UY0vNOH90b9/Jq8biib?=
 =?us-ascii?Q?yf85oZsMH0KZ9FWbTtk4sSyhvcE4KvH0voNN2LmzDuzO+AsQGtnhaD4Zqw4j?=
 =?us-ascii?Q?h5skaSLIV1Dg4OBBkFUojLXebzA/0hGAh6ra7gnd3U4k03k76rKZdJobd8wj?=
 =?us-ascii?Q?QlyrL53dX8kS/YN8+cYnA+GrZnRCPUvrzkHAU/iwe+Oy0/IH6q7xml+XbJ38?=
 =?us-ascii?Q?pDWumtt1jHpg8xTJLlYlSzmtxdbr7viPBJii1XZmxJhvFv4LSiuB5oPa/hEz?=
 =?us-ascii?Q?9dJlzPJ9iDDR0tRX8fOa4HlCruXFl7uHlur4Iym8ovoTz+4lrEgBT90KqKdq?=
 =?us-ascii?Q?44CKwndO5kdB029LsITmpvIYmmOKHUW8YkGh5KjNEK+6lgc3It3O2TRsoGjc?=
 =?us-ascii?Q?p1I/fDi2EA9w+Rxt0+yRPqzcOKDQQpwkBv5U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AJkGtIKWA+vxQI7gLi8SX0gw4v0BqzZz+xhavU/DlON/gYCfIMzGAYPWMcBR?=
 =?us-ascii?Q?oPlgaPk1eQXgh4AYIDA/VInU1NPerbHiKMOYtEvoc6jLfztA5kyo+u9p3Lmi?=
 =?us-ascii?Q?otqYtZem+c0voSuBejUPLZB1sXfXUQkI/rYjTkW6hMnEb0OIErnGMtKad9fz?=
 =?us-ascii?Q?BOmfIVKWr16mDsIIPzSg81UBvgwsJ4gPHzawJsHbcSc8UIxsC89nk0IZQUae?=
 =?us-ascii?Q?4EBBMwnNLjdMZX7mk0vviFExqoE7AfaCjTXGLjIqXxnDJhmuo7XmEVZOcmDq?=
 =?us-ascii?Q?MKgo3bXbp/8gfJEzf+wCvNA+q38q3o9Vok5Z+YRir99V7JoSiXMMOG7M7rBX?=
 =?us-ascii?Q?3P7Np9jrkRCEL+dAyh+jV/ozOoZWQTx6V66xkiE7Mr5sa1ppQa1qNFkkarDl?=
 =?us-ascii?Q?CHWPNgaqakgquY9uuC8JaIbeSzTrCnKFuCe2vqVWT7pi8ENBMZhtFsc+k5Pw?=
 =?us-ascii?Q?GnTPZQkheLnPloUsKp0FjwX9tkCn2GzOePXTIwIcmwLpdQQx+BFqQy448sXn?=
 =?us-ascii?Q?qZ/OezkpIk40csV++ybOSG8zWDzihEIdWX9DeA126rgm2wFxWJ7C20laaXpG?=
 =?us-ascii?Q?pMyBWw11J3G0XPvsfpoekBTfY8FCIgPou1/C/gs1wLdoIZygYWYVK7yE/VVT?=
 =?us-ascii?Q?lWdXtpEEoWpNHktVYoF0t/IOQ9As1vnM6PuFs4D+C+bwlJDVwWuR6b8sAYEA?=
 =?us-ascii?Q?4epux7axpfK4B8ZdMshweXTGEHtT5neq6dLL/+v5HS02CuD26mUn64EZlrND?=
 =?us-ascii?Q?ZL6EBQWUFu0YcHV37w+uQNi1PwRskaK4O//OlD3TBJXPodYCbPCPqoBUc1G9?=
 =?us-ascii?Q?oQak1qYFs3T7F2amLtt9Q6vQXzjr26c4xIQKxd9lukGn4TjXo1/qjeYLQDvU?=
 =?us-ascii?Q?OrwjkZ5LK7K4JB1vT5XOFi/9EAuKUb/goNytQfpv3K7E0d+BDeK8gwqTgzoD?=
 =?us-ascii?Q?kkQSW3KOafn2lWtAdSjBCee/f7nfRvrm/M4IciV1IsEEtu4qYsXv+uSe7KqW?=
 =?us-ascii?Q?kdjSLN+1nGoxolmazSdLuGs107YUJ98/aUzfpS7xHck9kEJvDekazMKOdxJF?=
 =?us-ascii?Q?SKIQiL1yFuoHq7wuzEHtZD4VE0YUqekP5lIcsFesOofELVtwCMQHdYZu6CGj?=
 =?us-ascii?Q?cNUG5Oi54ZDYZjFq2W5SYzYDC3GPpy6yKtOFChweNJlt9qnaRA63l4P0GFGL?=
 =?us-ascii?Q?Lh9Swmgy/jGzL9IgBlC/uETuG7Gpir2vV2HgYXKy3eA5V+i1vd/cqe+7aJKm?=
 =?us-ascii?Q?pRK1vwknTK/2oqgXZytVTF0jE3wJBo77PIeiP5Nr26rmFzLPE7eGlxytP0Il?=
 =?us-ascii?Q?mn4WdI8s9jOxhc6azxXxrpYY0Z4bqI6VNsGNh2x/N26mT3K3DxIFovNyOKB7?=
 =?us-ascii?Q?vBDt5BWYqOMKLqZlwBafcq6pL8o9WyyJp4LUasciEEAU7PZWdTUaBAUaGzZB?=
 =?us-ascii?Q?ZD7aaeH1kRCmPGoBApfeU8i5Rc1/PmBUT1JEVxljIoZczmStTOL8bkarc19i?=
 =?us-ascii?Q?URr9e7gsqyCBiCmeMlGBdxIpn0wsxPP79EE77vYtrV8LHVurleAbBJLgH4mM?=
 =?us-ascii?Q?naJCCEtlbduWWbxuvhd7vIpopVKSJRdXCOyJMXRXPAecoXJoYkNi2nOhc2Ev?=
 =?us-ascii?Q?uFDokNdA+bQROPxHw113xVM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: af5506fd-a80b-468a-a296-08de18dfee2a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:18.7428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzbYBUb0CW+Z4dkQNx4w3xDkRYt0guEhkXIvxfRSFMs8WWDcJccNHXO6C3kuLakkJWJKGkhNCXyQpgTcz+Yihp3cX00Zh8laZejKXpmdVFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9258
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

This adds clock driver for airoha en7523/en7529/en7562 SoCs. The code
is based on corresponding linux driver.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/clk/airoha/clk-airoha.c | 117 +++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/airoha/clk-airoha.c b/drivers/clk/airoha/clk-airoha.c
index 8e2f2c08923..49dbca82135 100644
--- a/drivers/clk/airoha/clk-airoha.c
+++ b/drivers/clk/airoha/clk-airoha.c
@@ -26,6 +26,7 @@
 #define REG_SPI_CLK_DIV_SEL		0x1c4
 #define REG_SPI_CLK_FREQ_SEL		0x1c8
 #define REG_NPU_CLK_DIV_SEL		0x1fc
+#define REG_CRYPTO_CLKSRC		0x200
 
 #define REG_NP_SCU_PCIC			0x88
 #define REG_NP_SCU_SSTR			0x9c
@@ -33,6 +34,7 @@
 #define REG_PCIE_XSI1_SEL_MASK		GENMASK(12, 11)
 #define REG_CRYPTO_CLKSRC2		0x20c
 
+#define EN7523_MAX_CLKS			8
 #define EN7581_MAX_CLKS			9
 
 struct airoha_clk_desc {
@@ -66,14 +68,119 @@ struct airoha_clk_soc_data {
 };
 
 static const u32 gsw_base[] = { 400000000, 500000000 };
+static const u32 emi_base[] = { 333000000, 400000000 };
+static const u32 bus_base[] = { 500000000, 540000000 };
 static const u32 slic_base[] = { 100000000, 3125000 };
-
+static const u32 npu_base[] = { 333000000, 400000000, 500000000 };
+/* EN7581 */
 static const u32 emi7581_base[] = { 540000000, 480000000, 400000000, 300000000 };
 static const u32 bus7581_base[] = { 600000000, 540000000 };
 static const u32 npu7581_base[] = { 800000000, 750000000, 720000000, 600000000 };
 static const u32 crypto_base[] = { 540000000, 480000000 };
 static const u32 emmc7581_base[] = { 200000000, 150000000 };
 
+static const struct airoha_clk_desc en7523_base_clks[EN7523_MAX_CLKS] = {
+	[EN7523_CLK_GSW] = {
+		.id = EN7523_CLK_GSW,
+		.name = "gsw",
+
+		.base_reg = REG_GSW_CLK_DIV_SEL,
+		.base_bits = 1,
+		.base_shift = 8,
+		.base_values = gsw_base,
+		.n_base_values = ARRAY_SIZE(gsw_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_EMI] = {
+		.id = EN7523_CLK_EMI,
+		.name = "emi",
+
+		.base_reg = REG_EMI_CLK_DIV_SEL,
+		.base_bits = 1,
+		.base_shift = 8,
+		.base_values = emi_base,
+		.n_base_values = ARRAY_SIZE(emi_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_BUS] = {
+		.id = EN7523_CLK_BUS,
+		.name = "bus",
+
+		.base_reg = REG_BUS_CLK_DIV_SEL,
+		.base_bits = 1,
+		.base_shift = 8,
+		.base_values = bus_base,
+		.n_base_values = ARRAY_SIZE(bus_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_SLIC] = {
+		.id = EN7523_CLK_SLIC,
+		.name = "slic",
+
+		.base_reg = REG_SPI_CLK_FREQ_SEL,
+		.base_bits = 1,
+		.base_shift = 0,
+		.base_values = slic_base,
+		.n_base_values = ARRAY_SIZE(slic_base),
+
+		.div_reg = REG_SPI_CLK_DIV_SEL,
+		.div_bits = 5,
+		.div_shift = 24,
+		.div_val0 = 20,
+		.div_step = 2,
+	},
+	[EN7523_CLK_SPI] = {
+		.id = EN7523_CLK_SPI,
+		.name = "spi",
+
+		.base_reg = REG_SPI_CLK_DIV_SEL,
+
+		.base_value = 400000000,
+
+		.div_bits = 5,
+		.div_shift = 8,
+		.div_val0 = 40,
+		.div_step = 2,
+	},
+	[EN7523_CLK_NPU] = {
+		.id = EN7523_CLK_NPU,
+		.name = "npu",
+
+		.base_reg = REG_NPU_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 8,
+		.base_values = npu_base,
+		.n_base_values = ARRAY_SIZE(npu_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_CRYPTO] = {
+		.id = EN7523_CLK_CRYPTO,
+		.name = "crypto",
+
+		.base_reg = REG_CRYPTO_CLKSRC,
+		.base_bits = 1,
+		.base_shift = 0,
+		.base_values = emi_base,
+		.n_base_values = ARRAY_SIZE(emi_base),
+	}
+};
+
 static const struct airoha_clk_desc en7581_base_clks[EN7581_MAX_CLKS] = {
 	[EN7523_CLK_GSW] = {
 		.id = EN7523_CLK_GSW,
@@ -425,12 +532,20 @@ static int airoha_clk_bind(struct udevice *dev)
 	return ret;
 }
 
+static const struct airoha_clk_soc_data en7523_data = {
+	.num_clocks = ARRAY_SIZE(en7523_base_clks),
+	.descs = en7523_base_clks,
+};
+
 static const struct airoha_clk_soc_data en7581_data = {
 	.num_clocks = ARRAY_SIZE(en7581_base_clks),
 	.descs = en7581_base_clks,
 };
 
 static const struct udevice_id airoha_clk_ids[] = {
+	{ .compatible = "airoha,en7523-scu",
+	  .data = (ulong)&en7523_data,
+	},
 	{ .compatible = "airoha,en7581-scu",
 	  .data = (ulong)&en7581_data,
 	},
-- 
2.51.0

