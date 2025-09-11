Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0531CAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 812B38340A;
	Thu, 11 Sep 2025 14:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="PPQ3zI0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB96783327; Thu, 11 Sep 2025 11:59:15 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 418F283323
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 11:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUxmiHPpa2SUfxyaXyguCaoKB4D1o93HSX4tLDAQwhwQWbfUyvYc6XmZ7tM9pBqIwHxbkv2U/3ISXt6Lff89uzfnk3By17ohnuE25vOtuxrx/9QU7KJoRfG3Jj27wxv7ZGJ2SR5V6wsCEaO1Fcu493xHCeTNceVGYSW4IxNT3QDzb5AKAeVBETRLT0O6p0LF6geawAKMPp/sylZe4REnbDulyXNqDE6YGJ7sBTSQ8S2LynPAr+8Gqe6pPzXKZifXWfmRgBz03JnMtMFebZDOhD39F1yWfcFUFs18sjOxPFgg63O1r3u8Fk/SzUpZ04xMby4j1195mm/0TGCyOnhOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCH5/0TYMBgDn3zPAOYgb33BaNJUHxNmjjgywVG7iBs=;
 b=JqMohVPVpFTFGPbDy/59k2XYh2PuKoi9nfLHk83Dz+9euwemxEoX2pYCFjJgm1nsKUc21B5dhycw3LUCaqosU1EZ6RAk7P2DYGPQn7yOkQh5CFEoVENwh993/qKZ+4NRqbhR7wbxpG7f18KV2VsVgs+T4Fv6W+BK2j6ZQJbwK94cE2v7jXE749tacHCFLGyRBffWzW/x0+djv7BFuhN0BM1BEgylz1cIOU5HBWAei+5qnhjYwdKnRiUwTcDUslEHCfZKEity61pDAoSGXgx1UouYB4mN1G1K+WgN8yWQ85ISBMG9JD01zDL9/D2V6tpT+Dy4KnmlF2MJIYYXZ4M3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCH5/0TYMBgDn3zPAOYgb33BaNJUHxNmjjgywVG7iBs=;
 b=PPQ3zI0a9nJb3X9U25jXVXcUpeXa36ZLwCRc06xfeUb0itpHxSFs43+8bH1yWU+SzfhHW4WjQENxJx/AArGBz7SdN65WY2MOtIYxzrxzIl20YIOsxGkojPkI7VWblE7RGqFV0xx0WCi2ynnxbaxb1H4lNLOQl3gWybNML7R6+7Z+lyBqCW+xZkpuKBxpf3yzPRGa8Cjo8HCh686yg79nwhbL12bEvYS+Pieh80teB34I12bcIBAa+9VzrQDEdSPtPXKTcTGu00F5o1E32AUpDT5hyAArmOGbMOu17F0JITmY8K1YxZQspGy/T7tZW4ZC7wznMvGn6sMhQLoQP1Pdjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DBAPR04MB7464.eurprd04.prod.outlook.com (2603:10a6:10:1a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 09:59:10 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 09:59:10 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com, sumit.garg@linaro.org
Subject: [PATCH 2/8] pci: pcie_dw_imx: Add iMX9 support to the driver
Date: Thu, 11 Sep 2025 17:58:35 +0800
Message-Id: <20250911095841.3659022-3-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911095841.3659022-1-ye.li@nxp.com>
References: <20250911095841.3659022-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DBAPR04MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: ce639fff-211e-4032-4e28-08ddf119da75
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|42112799006|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UoFvBJKoc6r8Qikdi+6k36eEkg+fIboPdL+BWi3ags0YxPMcGVXIX44sBYJ+?=
 =?us-ascii?Q?kJt6jKGkKZoUktEy+Aa/hyHgE7jAr7/QwWZ4FKNTzs7ZQiPYN6AjS8tZ472a?=
 =?us-ascii?Q?k7y5ulZaRLSbLNkFbRv7OWO5/5hQKUDIxhz29YybxvTZk/vbq+zI2etyGpeT?=
 =?us-ascii?Q?G7pUeqxWdjcMyV7+gXccBHpafQ3Dr9jDpqZRdl7/Za+a1q6QEltrxjxfgISS?=
 =?us-ascii?Q?FPqKDr5s+pRjB7tXP2zSHIR1b8mjKEcztzLXAZNb9S/dXHp1Vgwn5gMjoeAv?=
 =?us-ascii?Q?kcwhKBvf7FYkH2hPwghC6Mnw/MlMFAWEty1pHXN6um+xXlAxPrtRS821M0c7?=
 =?us-ascii?Q?W1pzV6Flca3eZhU1HdhkUTOEeXiWCO6A1A+v+eySH8Pq9Ee2Eea/EL3GONFX?=
 =?us-ascii?Q?7J1cgdBeB5f9Iy3rywFsggDNqEKMLeE9GdzPvRqPUHaRByjEfi2z2+KW5sMA?=
 =?us-ascii?Q?mWlwavQzhzPFHxmErlRPQX18+ZjpBvkeV8lj8lxBeIzI2ItiERf3AQaZ0YoU?=
 =?us-ascii?Q?WthFKH75CSo16cjtheimGapmBvREoiFSql5TBjidtVUdnbh+NM0Z+moIHAf7?=
 =?us-ascii?Q?M1gQloBbjNcBxMpWGo0L/kYkQIahUetJK3v8+sTmlBsVfn8OB0FyX/wqiWoE?=
 =?us-ascii?Q?HpcD6qe60QFYN31CyOj2bEHs+elrXcCXDpAURSTUjC5RbMw35FutpV7cFlrj?=
 =?us-ascii?Q?QwkF4gEPL9axTpYRF6Ejy0/s9WaMQvtpD+NVjyaOF5JMpRMrYTXdrpBLZAj3?=
 =?us-ascii?Q?VEbs9x3K8wWuib5OqqCbIJmVnd2nVVVn21q8qfrTYArszXvNuRJIKWA0aNFh?=
 =?us-ascii?Q?ODtDwOjZQA0pp5oEB/l/Mfs5jqVFRxKwSV7C88yM7gRCL4XRKssQ+g+PzNgZ?=
 =?us-ascii?Q?PhnTOZpAWaLGR6Vb9yT98DqaB1zrtQUgNHG23jJLkkBRITK+KHaeW1j7hYMG?=
 =?us-ascii?Q?lWZyIdA++y9n1tS1pckRsQJ091s6VpIShoS32ELQ+k7902PIqf5di9TNQ4fY?=
 =?us-ascii?Q?sQegnh6EMjzTOBYzwCP7dBnv+4p6MKrNPzc325XJINFnFMWeIn4Rhrm0Y4DC?=
 =?us-ascii?Q?vIIU//iq8uqo2+eGNvqOs3TChBElP3F0X0KG56wm4ErFSvOFrCYJMt3M9Ge6?=
 =?us-ascii?Q?8ilmDGj0hc519HOGR3h6/iVBZilWQecObY3WA/3OZvydLIXgSFr4+CoVDOei?=
 =?us-ascii?Q?EgROy2KvohFgjQ7TDTYRAFyTS2Q6IEzSH3FzlUMclfY+hK1/toFsOSonWB1l?=
 =?us-ascii?Q?tQt2RVxka0yL7tAOqNuJKBVLwUSz0ntwWURn81UPP12rGRzfkpfhN4VpBoXv?=
 =?us-ascii?Q?18Sl+RoNofolb9RM3xI2xPbOBxiNFKQ3g7wNrUWVcTH0Pofex8q0WgJWIcRJ?=
 =?us-ascii?Q?sZfDIiA+Ut/OkA3fqiEVu20OZk7yKqVH0+VZc8rCQXhFU2UG3cgx7YwqVJG1?=
 =?us-ascii?Q?WcyTeSGUn/oeYNw+BQVI4sENlLos0QeeMhyhkIgVHyeo9J0dVAM7I5ajirSV?=
 =?us-ascii?Q?Quk3YstRIEu2C7Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(42112799006)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UMtg9Uk//CuQIcxadJrKHCt2J0BZvhLyNJXq1fIx0taCWtOyYxDLYBUfCwTD?=
 =?us-ascii?Q?HNTRC0meCeJaI2gQCYCB3qwSppEL42inqmfk1sAExpnbVOIbWFBttb3bwV8t?=
 =?us-ascii?Q?otFXiChqgdjqvsaQXJ3ISFe0rLYwHR6esuxhdwI6sAoZHIGDpm/0PUeN2TKT?=
 =?us-ascii?Q?KMu0OUMJehzNDagO2XoGTz7Z8wQ+UUhP5jsdU3mesE2Fi4j6cBuVwcy/ut3y?=
 =?us-ascii?Q?ev9xA+GG+as0YspVuNwAvyaVaeZv7LeLdxaCZdmiVX6DyrLEg8dJSRdin9YX?=
 =?us-ascii?Q?reAIY18lWQhMv3kOyzeisPiztVCQ4lZ52P5CkBDOiDYEZsgqZKDKU5KaVxRA?=
 =?us-ascii?Q?Kq1LFE9/x1uDo1HA4VxD7hKD4HPMyH8xsMW7zc0Oy0PptI5SEawthhsaPdtr?=
 =?us-ascii?Q?UmNvsmbKXxCby1V3jR4jdqJcxOjPAKMHeoNi3T8sqFI8IT8dMc+C+ziNeVId?=
 =?us-ascii?Q?KLJ/lrJqdf6vuf8n3QK37RIKUp0v2z42fwajyK/Gts5ctG0j2Yl0zjXdAWJ3?=
 =?us-ascii?Q?ZIeIx+edR8dvTsLy8QLHLcC0koi2E0kQ9H5xSGlUbioDefTxN9In8QvLxF5E?=
 =?us-ascii?Q?sTxI9StxmO/zl0I229WoDyQW+BbwDfxvPmGfpwFgwPrlirL97WgZqwScP04C?=
 =?us-ascii?Q?jLzf/y3EcxdDOy3GqU9v1lMR709NoFAmTntUC4L7+c1fiNCezZKCjIiVLD6c?=
 =?us-ascii?Q?5WYwCCz0ZZ5AGe8gZy3Y/SlAvwX1o4BDJxLouSPrrIYeCmO3WuR9VZ6Bbhv+?=
 =?us-ascii?Q?MaXBHF+IT8hR8Kfjp1PYuz7HmkSYBNZSimErAtgv+HBPmr3xZPQvXrtg52jI?=
 =?us-ascii?Q?ZoGchL8QQ7MvzjO9TDi01NH7UpyF/1KjAK1B2yS9kVYr/PiITNFc6vTEt8yL?=
 =?us-ascii?Q?Fu4dsTd1+/TASxQg+noM4RUxrFMulXZM7J1hs964KSLX98fRVSpcpxsqxrcI?=
 =?us-ascii?Q?HAKCYNwxgct6UjbVEUpihMklebZ09RUD0i4hdlJzN4KFQjqcjqAw0i18Vshe?=
 =?us-ascii?Q?xoNCkSriN2hAjbwml6QYvKHRs2kXfbfcNfIT5ww5uZZApAVfbdaxc4jsaYsO?=
 =?us-ascii?Q?eFaJTM1hzMq3I7i+5pbo8aV6SfnnPPAXUq46nLeVL+4iBBcdzvM+k8L39Lu8?=
 =?us-ascii?Q?CLtbNri0sji3MnDGhJs/wDKMKquyx0Xqpp05Xp27zd6uIVyLJGHo78t6lFbD?=
 =?us-ascii?Q?qwDb6VO6yuMQW+b+6JboS/d6aznukkIjgrmVZYmMS38woMMMKD8KICHxjCX1?=
 =?us-ascii?Q?G2y2+SpM3H4FsSPjjzwrGkORHCuSYN6YC5mWPrpO/a0P2ljXD+m5ayAT4Pb1?=
 =?us-ascii?Q?ckXgboVXZErJThrEPi6HS6SqtqdQkNIj/aCKNEBenIWlfnPhRxrpD8AZCHHt?=
 =?us-ascii?Q?OnXUxfc4J1B7/Z6QHUkvXBp47rMCmgpogd82WSwAVJAE6KeGZN95tJmcQ0Cf?=
 =?us-ascii?Q?/326UTPIZu6p6C6pe0ruq909n1nAU25mxkwd36BkbOry7c0OYaqn9a1L4EPx?=
 =?us-ascii?Q?PzQED5Ak1u73it9zk7C0wnl6+NIlqq2DGNZoiv+6FqXkZTiJnCMWofYlhQw9?=
 =?us-ascii?Q?JuffWLtOZ/JB4iP6xXY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce639fff-211e-4032-4e28-08ddf119da75
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:59:10.2167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVSKpp+jBhP6cNXnuM0nMOVk8voi1SA7f2lcm1Kf2nVxnOHJDmmWLnMqAKIJg9Vz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7464
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

Adding iMX95/iMX94 support to the dw driver. Follow kernel driver
stype to use flags to distinguish the characteristic of different
platforms.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/pci/Kconfig       |   2 +-
 drivers/pci/pcie_dw_imx.c | 420 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 377 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 8ffd88c722d9..9ec3ed856bfb 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -456,7 +456,7 @@ config PCIE_STARFIVE_JH7110
 
 config PCIE_DW_IMX
 	bool "i.MX DW PCIe controller support"
-	depends on ARCH_IMX8M
+	depends on ARCH_IMX8M || ARCH_IMX9
 	select PCIE_DW_COMMON
 	select DM_REGULATOR
 	select REGMAP
diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_imx.c
index fdb463710ba1..f84c7180560a 100644
--- a/drivers/pci/pcie_dw_imx.c
+++ b/drivers/pci/pcie_dw_imx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2024 Linaro Ltd.
+ * Copyright 2025 NXP
  *
  * Author: Sumit Garg <sumit.garg@linaro.org>
  */
@@ -45,6 +46,47 @@
 #define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN	BIT(10)
 #define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE		BIT(11)
 
+#define IMX95_PCIE_PHY_GEN_CTRL			0x0
+#define IMX95_PCIE_REF_USE_PAD			BIT(17)
+
+#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
+#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)
+
+#define IMX95_PCIE_SS_RW_REG_0			0xf0
+#define IMX95_PCIE_REF_CLKEN			BIT(23)
+#define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
+#define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
+#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
+#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
+
+#define IMX95_PE0_GEN_CTRL_1			0x1050
+#define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
+
+#define IMX95_PE0_GEN_CTRL_3			0x1058
+#define IMX95_PCIE_LTSSM_EN			BIT(0)
+
+#define IMX95_PCIE_RST_CTRL			0x3010
+#define IMX95_PCIE_COLD_RST			BIT(0)
+
+#define GEN3_RELATED_OFF			0x890
+#define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
+#define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS	BIT(13)
+#define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
+#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
+#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
+#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT	0x1
+
+#define IMX_PCIE_FLAG_HAS_PHYDRV        BIT(3)
+#define IMX_PCIE_FLAG_HAS_APP_RESET     BIT(4)
+#define IMX_PCIE_FLAG_HAS_SERDES        BIT(6)
+
+#define IMX_PCIE_MAX_INSTANCES	2
+
+/* Parameters for the waiting for PCIe PHY PLL to lock s*/
+#define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
+#define PHY_PLL_LOCK_WAIT_TIMEOUT	(2000 * PHY_PLL_LOCK_WAIT_USLEEP_MAX / 1000)
+
 struct pcie_dw_imx {
 	/* Must be first member of the struct */
 	struct pcie_dw			dw;
@@ -54,20 +96,203 @@ struct pcie_dw_imx {
 	struct reset_ctl		apps_reset;
 	struct phy			phy;
 	struct udevice			*vpcie;
+	void				*info;
+	u32				max_link_speed;
+	bool				enable_ext_refclk;
+	bool				supports_clkreq;
 };
 
 struct pcie_chip_info {
+	u32 flags;
+	const u32 ltssm_off;
+	const u32 ltssm_mask;
+	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
+	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const char *gpr;
+	void (*init_phy)(struct pcie_dw_imx *priv);
+	int (*enable_ref_clk)(struct pcie_dw_imx *priv, bool enable);
+	int (*core_reset)(struct pcie_dw_imx *priv, bool assert);
+	int (*wait_pll_lock)(struct pcie_dw_imx *priv);
+	void (*post_config)(struct pcie_dw_imx *priv);
 };
 
+static void imx95_pcie_init_phy(struct pcie_dw_imx *priv)
+{
+/*
+ * Workaround for ERR051624: The Controller Without Vaux Cannot
+ * Exit L23 Ready Through Beacon or PERST# De-assertion
+ *
+ * When the auxiliary power is not available the controller
+ * cannot exit from L23 Ready with beacon or PERST# de-assertion
+ * when main power is not removed.
+ *
+ * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
+ */
+	regmap_update_bits(priv->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+		IMX95_PCIE_SYS_AUX_PWR_DET, IMX95_PCIE_SYS_AUX_PWR_DET);
+
+	regmap_update_bits(priv->iomuxc_gpr,
+		IMX95_PCIE_SS_RW_REG_0,
+		IMX95_PCIE_PHY_CR_PARA_SEL,
+		IMX95_PCIE_PHY_CR_PARA_SEL);
+
+	if (priv->enable_ext_refclk) {
+		/* External clock is used as reference clock */
+		regmap_update_bits(priv->iomuxc_gpr,
+			IMX95_PCIE_PHY_GEN_CTRL,
+			IMX95_PCIE_REF_USE_PAD,
+			IMX95_PCIE_REF_USE_PAD);
+		regmap_update_bits(priv->iomuxc_gpr,
+			IMX95_PCIE_SS_RW_REG_0,
+			IMX95_PCIE_REF_CLKEN, 0);
+	} else {
+		regmap_update_bits(priv->iomuxc_gpr,
+			IMX95_PCIE_PHY_GEN_CTRL,
+			IMX95_PCIE_REF_USE_PAD, 0);
+
+		regmap_update_bits(priv->iomuxc_gpr,
+			IMX95_PCIE_SS_RW_REG_0,
+			IMX95_PCIE_REF_CLKEN,
+			IMX95_PCIE_REF_CLKEN);
+	}
+
+	/* Force CLKREQ# low by override */
+	if (!priv->supports_clkreq)
+		regmap_update_bits(priv->iomuxc_gpr,
+				   IMX95_PCIE_SS_RW_REG_1,
+				   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
+				   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
+				   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
+				   IMX95_PCIE_CLKREQ_OVERRIDE_VAL);
+}
+
+static int imx95_pcie_wait_for_phy_pll_lock(struct pcie_dw_imx *priv)
+{
+	u32 val;
+
+	if (regmap_read_poll_timeout(priv->iomuxc_gpr,
+				     IMX95_PCIE_PHY_MPLLA_CTRL, val,
+				     val & IMX95_PCIE_PHY_MPLL_STATE,
+				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
+				     PHY_PLL_LOCK_WAIT_TIMEOUT)) {
+		printf("PCIe PLL lock timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int imx95_pcie_core_reset(struct pcie_dw_imx *priv, bool assert)
+{
+	u32 val;
+
+	if (assert) {
+		/*
+		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
+		 * should be complete after power-up by the following sequence.
+		 *                 > 10us(at power-up)
+		 *                 > 10ns(warm reset)
+		 *               |<------------>|
+		 *                ______________
+		 * phy_reset ____/              \________________
+		 *                                   ____________
+		 * ref_clk_en_______________________/
+		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
+		 */
+		regmap_update_bits(priv->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				   IMX95_PCIE_COLD_RST, IMX95_PCIE_COLD_RST);
+		/*
+		 * Make sure the write to IMX95_PCIE_RST_CTRL is flushed to the
+		 * hardware by doing a read. Otherwise, there is no guarantee
+		 * that the write has reached the hardware before udelay().
+		 */
+		regmap_read(priv->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				     &val);
+		udelay(15);
+		regmap_update_bits(priv->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				  IMX95_PCIE_COLD_RST, 0);
+		regmap_read(priv->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				     &val);
+		udelay(10);
+	}
+
+	return 0;
+}
+
+static void imx95_pcie_post_config(struct pcie_dw_imx *priv)
+{
+	u32 val;
+
+	/*
+	 * Workaround for ERR051586: Compliance with 8GT/s Receiver
+	 * Impedance ECN
+	 *
+	 * The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is
+	 * 1 which makes receiver non-compliant with the ZRX-DC
+	 * parameter for 2.5 GT/s when operating at 8 GT/s or higher. It
+	 * causes unnecessary timeout in L1.
+	 *
+	 * Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.
+	 */
+	dw_pcie_dbi_write_enable(&priv->dw, true);
+	val = readl(priv->dw.dbi_base + GEN3_RELATED_OFF);
+	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+	writel(val, priv->dw.dbi_base + GEN3_RELATED_OFF);
+	dw_pcie_dbi_write_enable(&priv->dw, false);
+}
+
+static int imx8mm_pcie_enable_ref_clk(struct pcie_dw_imx *priv, bool enable)
+{
+	regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
+			   IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE,
+			   enable ? 0 : IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE);
+	regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
+			   IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+			   enable ? IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
+	return 0;
+}
+
 static const struct pcie_chip_info imx8mm_chip_info = {
+	.flags = IMX_PCIE_FLAG_HAS_APP_RESET | IMX_PCIE_FLAG_HAS_PHYDRV,
 	.gpr = "fsl,imx8mm-iomuxc-gpr",
+	.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 };
 
 static const struct pcie_chip_info imx8mp_chip_info = {
+	.flags = IMX_PCIE_FLAG_HAS_APP_RESET | IMX_PCIE_FLAG_HAS_PHYDRV,
 	.gpr = "fsl,imx8mp-iomuxc-gpr",
+	.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+};
+
+static const struct pcie_chip_info imx95_chip_info = {
+	.flags = IMX_PCIE_FLAG_HAS_SERDES,
+	.ltssm_off = IMX95_PE0_GEN_CTRL_3,
+	.ltssm_mask = IMX95_PCIE_LTSSM_EN,
+	.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
+	.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+	.init_phy = imx95_pcie_init_phy,
+	.core_reset = imx95_pcie_core_reset,
+	.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
+	.post_config = imx95_pcie_post_config,
 };
 
+static void imx_pcie_configure_type(struct pcie_dw_imx *priv)
+{
+	struct pcie_chip_info *info = (struct pcie_chip_info *)(priv->info);
+	unsigned int mask, val, mode;
+
+	mode = PCI_EXP_TYPE_ROOT_PORT;
+
+	/* If mode_mask is 0, then generic PHY driver is used to set the mode */
+	if (!info->mode_mask[0])
+		return;
+
+	mask = info->mode_mask[0];
+	val = mode << (ffs(mask) - 1);
+
+	regmap_update_bits(priv->iomuxc_gpr, info->mode_off[0], mask, val);
+}
+
 static void pcie_dw_configure(struct pcie_dw_imx *priv, u32 cap_speed)
 {
 	dw_pcie_dbi_write_enable(&priv->dw, true);
@@ -75,17 +300,34 @@ static void pcie_dw_configure(struct pcie_dw_imx *priv, u32 cap_speed)
 	clrsetbits_le32(priv->dw.dbi_base + PCIE_LINK_CAPABILITY,
 			TARGET_LINK_SPEED_MASK, cap_speed);
 
+	clrsetbits_le32(priv->dw.dbi_base + PCIE_LINK_CTL_2,
+			TARGET_LINK_SPEED_MASK, cap_speed);
+
 	dw_pcie_dbi_write_enable(&priv->dw, false);
 }
 
 static void imx_pcie_ltssm_enable(struct pcie_dw_imx *priv)
 {
-	reset_deassert(&priv->apps_reset);
+	struct pcie_chip_info *info = (struct pcie_chip_info *)(priv->info);
+
+	if (info->ltssm_mask)
+		regmap_update_bits(priv->iomuxc_gpr, info->ltssm_off, info->ltssm_mask,
+				   info->ltssm_mask);
+
+	if (info->flags & IMX_PCIE_FLAG_HAS_APP_RESET)
+		reset_deassert(&priv->apps_reset);
 }
 
 static void imx_pcie_ltssm_disable(struct pcie_dw_imx *priv)
 {
-	reset_assert(&priv->apps_reset);
+	struct pcie_chip_info *info = (struct pcie_chip_info *)(priv->info);
+
+	if (info->ltssm_mask)
+		regmap_update_bits(priv->iomuxc_gpr, info->ltssm_off,
+				   info->ltssm_mask, 0);
+
+	if (info->flags & IMX_PCIE_FLAG_HAS_APP_RESET)
+		reset_assert(&priv->apps_reset);
 }
 
 static bool is_link_up(u32 val)
@@ -122,6 +364,11 @@ static int pcie_link_up(struct pcie_dw_imx *priv, u32 cap_speed)
 
 static int imx_pcie_assert_core_reset(struct pcie_dw_imx *priv)
 {
+	struct pcie_chip_info *info = (struct pcie_chip_info *)(priv->info);
+
+	if (info->core_reset)
+		info->core_reset(priv, true);
+
 	if (dm_gpio_is_valid(&priv->reset_gpio)) {
 		dm_gpio_set_value(&priv->reset_gpio, 1);
 		mdelay(20);
@@ -133,6 +380,7 @@ static int imx_pcie_assert_core_reset(struct pcie_dw_imx *priv)
 static int imx_pcie_clk_enable(struct pcie_dw_imx *priv)
 {
 	int ret;
+	struct pcie_chip_info *info = (struct pcie_chip_info *)(priv->info);
 
 	ret = clk_enable_bulk(&priv->clks);
 	if (ret)
@@ -142,11 +390,8 @@ static int imx_pcie_clk_enable(struct pcie_dw_imx *priv)
 	 * Set the over ride low and enabled make sure that
 	 * REF_CLK is turned on.
 	 */
-	regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
-			   IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE, 0);
-	regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
-			   IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
-			   IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
+	if (info->enable_ref_clk)
+		info->enable_ref_clk(priv, true);
 
 	/* allow the clocks to stabilize */
 	udelay(500);
@@ -156,6 +401,11 @@ static int imx_pcie_clk_enable(struct pcie_dw_imx *priv)
 
 static void imx_pcie_deassert_core_reset(struct pcie_dw_imx *priv)
 {
+	struct pcie_chip_info *info = (struct pcie_chip_info *)(priv->info);
+
+	if (info->core_reset)
+		info->core_reset(priv, false);
+
 	if (!dm_gpio_is_valid(&priv->reset_gpio))
 		return;
 
@@ -170,10 +420,11 @@ static int pcie_dw_imx_probe(struct udevice *dev)
 	struct pcie_dw_imx *priv = dev_get_priv(dev);
 	struct udevice *ctlr = pci_get_controller(dev);
 	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
+	struct pcie_chip_info *info = (void *)dev_get_driver_data(dev);
 	int ret;
 
 	if (priv->vpcie) {
-		ret = regulator_set_enable(priv->vpcie, true);
+		ret = regulator_set_enable_if_allowed(priv->vpcie, true);
 		if (ret) {
 			dev_err(dev, "failed to enable vpcie regulator\n");
 			return ret;
@@ -186,31 +437,49 @@ static int pcie_dw_imx_probe(struct udevice *dev)
 		return ret;
 	}
 
+	if (info->init_phy)
+		info->init_phy(priv);
+
+	imx_pcie_configure_type(priv);
+
 	ret = imx_pcie_clk_enable(priv);
 	if (ret) {
 		dev_err(dev, "failed to enable clocks\n");
 		goto err_clk;
 	}
 
-	ret = generic_phy_init(&priv->phy);
-	if (ret) {
-		dev_err(dev, "failed to initialize PHY\n");
-		goto err_phy_init;
-	}
+	if (info->flags & IMX_PCIE_FLAG_HAS_PHYDRV) {
+		ret = generic_phy_init(&priv->phy);
+		if (ret) {
+			dev_err(dev, "failed to initialize PHY\n");
+			goto err_phy_init;
+		}
 
-	ret = generic_phy_power_on(&priv->phy);
-	if (ret) {
-		dev_err(dev, "failed to power on PHY\n");
-		goto err_phy_power;
+		ret = generic_phy_power_on(&priv->phy);
+		if (ret) {
+			dev_err(dev, "failed to power on PHY\n");
+			goto err_phy_power;
+		}
 	}
 
 	imx_pcie_deassert_core_reset(priv);
 
+	if (info->wait_pll_lock) {
+		ret = info->wait_pll_lock(priv);
+		if (ret) {
+			dev_err(dev, "failed to wait pll lock\n");
+			goto err_link;
+		}
+	}
+
+	if (info->post_config)
+		info->post_config(priv);
+
 	priv->dw.first_busno = dev_seq(dev);
 	priv->dw.dev = dev;
 	pcie_dw_setup_host(&priv->dw);
 
-	if (pcie_link_up(priv, LINK_SPEED_GEN_1)) {
+	if (pcie_link_up(priv, priv->max_link_speed)) {
 		printf("PCIE-%d: Link down\n", dev_seq(dev));
 		ret = -ENODEV;
 		goto err_link;
@@ -229,26 +498,41 @@ static int pcie_dw_imx_probe(struct udevice *dev)
 	return 0;
 
 err_link:
-	generic_shutdown_phy(&priv->phy);
+	if (info->flags & IMX_PCIE_FLAG_HAS_PHYDRV)
+		generic_shutdown_phy(&priv->phy);
 err_phy_power:
-	generic_phy_exit(&priv->phy);
+	if (info->flags & IMX_PCIE_FLAG_HAS_PHYDRV)
+		generic_phy_exit(&priv->phy);
 err_phy_init:
-	clk_disable_bulk(&priv->clks);
+	clk_release_bulk(&priv->clks);
 err_clk:
 	imx_pcie_deassert_core_reset(priv);
 
+	dm_gpio_free(dev, &priv->reset_gpio);
+
+	if (priv->vpcie)
+		regulator_set_enable_if_allowed(priv->vpcie, false);
+
 	return ret;
 }
 
 static int pcie_dw_imx_remove(struct udevice *dev)
 {
 	struct pcie_dw_imx *priv = dev_get_priv(dev);
+	struct pcie_chip_info *info = (void *)dev_get_driver_data(dev);
+
+	if (info->flags & IMX_PCIE_FLAG_HAS_PHYDRV)
+		generic_shutdown_phy(&priv->phy);
 
-	generic_shutdown_phy(&priv->phy);
 	dm_gpio_free(dev, &priv->reset_gpio);
-	reset_free(&priv->apps_reset);
+	if (info->flags & IMX_PCIE_FLAG_HAS_APP_RESET)
+		reset_free(&priv->apps_reset);
+
 	clk_release_bulk(&priv->clks);
 
+	if (priv->vpcie)
+		regulator_set_enable_if_allowed(priv->vpcie, false);
+
 	return 0;
 }
 
@@ -257,7 +541,9 @@ static int pcie_dw_imx_of_to_plat(struct udevice *dev)
 	struct pcie_chip_info *info = (void *)dev_get_driver_data(dev);
 	struct pcie_dw_imx *priv = dev_get_priv(dev);
 	ofnode gpr;
-	int ret;
+	int ret, index;
+
+	priv->info = info;
 
 	/* Get the controller base address */
 	priv->dw.dbi_base = (void *)dev_read_addr_name(dev, "dbi");
@@ -274,17 +560,29 @@ static int pcie_dw_imx_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	}
 
+	priv->dw.atu_base = (void *)dev_read_addr_name_ptr(dev, "atu");
+	if (!priv->dw.atu_base)
+		dev_dbg(dev, "failed to get atu address from dtb\n");
+
 	ret = clk_get_bulk(dev, &priv->clks);
 	if (ret) {
 		dev_err(dev, "failed to get PCIe clks\n");
 		return ret;
 	}
 
-	ret = reset_get_by_name(dev, "apps", &priv->apps_reset);
-	if (ret) {
-		dev_err(dev,
-			"Failed to get PCIe apps reset control\n");
-		goto err_reset;
+	index = ofnode_stringlist_search(dev_ofnode(dev), "clock-names", "ext-ref");
+	if (index < 0)
+		priv->enable_ext_refclk = false;
+	else
+		priv->enable_ext_refclk = true;
+
+	if (info->flags & IMX_PCIE_FLAG_HAS_APP_RESET) {
+		ret = reset_get_by_name(dev, "apps", &priv->apps_reset);
+		if (ret) {
+			dev_err(dev,
+				"Failed to get PCIe apps reset control\n");
+			goto err_reset;
+		}
 	}
 
 	ret = gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
@@ -294,26 +592,58 @@ static int pcie_dw_imx_of_to_plat(struct udevice *dev)
 		goto err_gpio;
 	}
 
-	ret = generic_phy_get_by_name(dev, "pcie-phy", &priv->phy);
-	if (ret) {
-		dev_err(dev, "failed to get pcie phy\n");
-		goto err_phy;
+	if (info->flags & IMX_PCIE_FLAG_HAS_PHYDRV) {
+		ret = generic_phy_get_by_name(dev, "pcie-phy", &priv->phy);
+		if (ret) {
+			dev_err(dev, "failed to get pcie phy\n");
+			goto err_phy;
+		}
 	}
 
-	gpr = ofnode_by_compatible(ofnode_null(), info->gpr);
-	if (ofnode_equal(gpr, ofnode_null())) {
-		dev_err(dev, "unable to find GPR node\n");
-		ret = -ENODEV;
-		goto err_phy;
+	if (info->flags & IMX_PCIE_FLAG_HAS_SERDES) {
+		void __iomem *app_base;
+		fdt_size_t app_size;
+		struct regmap_config config;
+
+		app_base = (void *)dev_read_addr_size_name(dev, "app", &app_size);
+		if ((fdt_addr_t)app_base == FDT_ADDR_T_NONE) {
+			dev_err(dev, "failed to get app_base address\n");
+			return -EINVAL;
+		}
+
+		config.r_start = (ulong)app_base;
+		config.r_size = (ulong)app_size;
+		config.reg_offset_shift = 0;
+		config.width = REGMAP_SIZE_32;
+
+		priv->iomuxc_gpr = devm_regmap_init(dev, NULL, NULL, &config);
+		if (IS_ERR(priv->iomuxc_gpr)) {
+			dev_err(dev, "unable to remap gpr\n");
+			ret = PTR_ERR(priv->iomuxc_gpr);
+			goto err_phy;
+		}
 	}
 
-	priv->iomuxc_gpr = syscon_node_to_regmap(gpr);
-	if (IS_ERR(priv->iomuxc_gpr)) {
-		dev_err(dev, "unable to find iomuxc registers\n");
-		ret = PTR_ERR(priv->iomuxc_gpr);
-		goto err_phy;
+	if (info->gpr) {
+		gpr = ofnode_by_compatible(ofnode_null(), info->gpr);
+		if (ofnode_equal(gpr, ofnode_null())) {
+			dev_err(dev, "unable to find GPR node\n");
+			ret = -ENODEV;
+			goto err_phy;
+		}
+
+		priv->iomuxc_gpr = syscon_node_to_regmap(gpr);
+		if (IS_ERR(priv->iomuxc_gpr)) {
+			dev_err(dev, "unable to find iomuxc registers\n");
+			ret = PTR_ERR(priv->iomuxc_gpr);
+			goto err_phy;
+		}
 	}
 
+	priv->max_link_speed = dev_read_u32_default(dev, "fsl,max-link-speed", LINK_SPEED_GEN_1);
+
+	priv->supports_clkreq = dev_read_bool(dev, "supports-clkreq");
+
 	/* vpcie-supply regulator is optional */
 	device_get_supply_regulator(dev, "vpcie-supply", &priv->vpcie);
 
@@ -322,7 +652,8 @@ static int pcie_dw_imx_of_to_plat(struct udevice *dev)
 err_phy:
 	dm_gpio_free(dev, &priv->reset_gpio);
 err_gpio:
-	reset_free(&priv->apps_reset);
+	if (info->flags & IMX_PCIE_FLAG_HAS_APP_RESET)
+		reset_free(&priv->apps_reset);
 err_reset:
 	clk_release_bulk(&priv->clks);
 
@@ -337,6 +668,7 @@ static const struct dm_pci_ops pcie_dw_imx_ops = {
 static const struct udevice_id pcie_dw_imx_ids[] = {
 	{ .compatible = "fsl,imx8mm-pcie", .data = (ulong)&imx8mm_chip_info, },
 	{ .compatible = "fsl,imx8mp-pcie", .data = (ulong)&imx8mp_chip_info, },
+	{ .compatible = "fsl,imx95-pcie", .data = (ulong)&imx95_chip_info, },
 	{ }
 };
 
-- 
2.7.4

