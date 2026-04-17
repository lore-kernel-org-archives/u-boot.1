Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B19F436AE
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 14:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C77F38427F;
	Fri, 17 Apr 2026 16:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="niAG9wTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10D3B842A4; Fri, 17 Apr 2026 16:12:41 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0677B84258
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 16:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhlPwQh2rf0yMAayfEU2LlUL/Zopga3Uk4Lcs4+5cmv9mIrIbP8Qqp8hX6BAhGkIpyHOzDnBAKFPihBgUzjV5LYj4fCE8fu8vThfQ34QqFoPlPYahPYPwBQzWxfb/oVKVTZ4V2LASEkLGPX7zcnIeoLD8vHLFrXSQuEr38AXeLOPIvJoj35bx5t6vW/rt01zXGokeUCUjgmer16fLD5aj+pgn2MiNH9U3emsqYKc/A7wbVGptCy80eNig/RNuEmR+6HuQbTSC24k5tnpPUPWFKHBfm0cGbJl6RSyhRHsdbKuFnd9P7r4u9YptIWEyIYGbLbwYBTlr0n/Zs7uPyUjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lM42xPl8SfjnTDRl5GpJfpy1v5BYmNsE+WdK5H9zWd0=;
 b=I6tlevs3DpItIJwqoYg14VhKuVCiJFO9J146Fwwz4dOr00h1eHWt1cOHf3K+f6L9C7X6W8cblzAW9dmnXd24ptVOPIheAv3HJYC1ZShs4Hc+RHMt+HZzDWRL+17Bj5HXdAV0lpqwN4i5nVewlC5y3HsHpjY7e+BFE7tPT+p4zcQte1jNHNEHqVLvmqCBHchiJJrOjgmZfXhLBdqhj8JAqiaXH81g+gz7KWeR1eSGHgWBKBPwFlJze3iMTK+A/pbBr41Wz+mnvlsQu5ssUgEEovP//omElDdETvbzsFdFqCrOQF/CMz7oFmyzBxZ1NQx+lK8N6wRFUvzA4Xf5IRGk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM42xPl8SfjnTDRl5GpJfpy1v5BYmNsE+WdK5H9zWd0=;
 b=niAG9wTITbHmfaxRY4FSyDv8PUFXKDoYQy5vn0wz9dWDNHJ90a/1ERy/Hl8+pm0Yi0OfHx0uG6cE19YuNyc2yVnkiEx5UwXb0oLnaKawKoHCcdQ11raEV32eXzphIuFgVOt5BHY0hifxRCCf5+0iwUYExI+pgmtU4ZSCAQ4W2jsawwRx/FVQtk218pfuUS28Mk3WKdCejN4mX4a8KRMHhPpWmdJcuxb3iy/LBjO/B222JLtFbSdszHsaW5wxnpB042XN79u4AU5NmKsa/FnwBo1K02bKgHpnemaEkF1Vd2zq0pNDL7db8LaBxZFyip43mtcM3+YRJf3moEkR/VSOhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GVXPR04MB12128.eurprd04.prod.outlook.com (2603:10a6:150:312::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:12:36 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:12:36 +0000
From: Ye Li <ye.li@nxp.com>
To: peng.fan@nxp.com,
	peng.fan@oss.nxp.com,
	u-boot@lists.denx.de
Cc: ye.li@oss.nxp.com,
	uboot-imx@nxp.com
Subject: [PATCH 1/4] arm: dts: fsl-ls1088a-qds: Fix missed -u-boot.dtsi
Date: Fri, 17 Apr 2026 22:14:36 +0800
Message-Id: <20260417141437.1490591-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::13) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GVXPR04MB12128:EE_
X-MS-Office365-Filtering-Correlation-Id: afe0be52-bf10-44b0-7d93-08de9c8b6013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|19092799006|1800799024|42112799006|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 4S/IKJycFHnFMCnQ/JZBKRI/RRklmYZ165VMyD/Ux0vmZQMJT8n4Pb6NJXaltpZ9Ncgrcs+AZMseh1EI7FWTbZrFXLTXYIjayXMCSBc2RXJE3I8YTovN/BUleKqnmGuDN3r0EuIdM3oUr202QiJsSRqyoFoNU4s43N3BZ9KqWaJ+10TbE2CeU/lQRcQK9usQYJQx/+23c7t3/K0OxbqJKBdmryttLwylyK9gax53flV8P0doYdMownHuDMIfjFgml2AUJfK+GxJ+sB1ezmlIlRNt9Dr8MMxbStB9bSF58MpyNF9KY8HDCE+3A+VXAViu4b99O0ccrvdOZ+JhRcjN5UjaDXisw51wsGrrf6dhR2ixXp9Qf4HUZkbxkHm1NSq5yIJIH3D3/E6rRjNfYFyOwRFAPlEEX19HQJ03qMx9ogIJy9drcrwQt9SvNMFp0i6BOvYSKQw1bDWlj74M8nx6Gdib5x5w31n0yO/bN0gakbDa5cjVSxbRM2s+ay9fpD2CWCZub3WCN53yTdqw+AmaMByMrHbZq1gIEzEddlbfk2WJo+NVGjQ7IhR6kWbrDsDS7wZfL1BzcSk+3KodLkOaw4PmLfEf4Kvb+u1J6BGvDwiKyma2wNUNYymnjfAqQ1TtZH1RwCeIG8oY7MPVtY28ER6KF3uuV+tkLQbrmg4iIGvUjN8v+5VH2lskqn/x9PvkB+whBIea0U6W3h5M7f1R0ONesFBX1uH+rx2+wq6Y5xj3VD1KQ+wx9d7/QsbEgHUfb9D9DDoWi7T2xM6AbWeISsJh5Z5rUvTO2rifIcjGNvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(42112799006)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6zJlz3EpzW8VqpDbFEDqoj+XZiHO4JaqOVfvSeNPVO1nZ+Phyh+oKfoVMbDf?=
 =?us-ascii?Q?FHmsPmLU6MK7X/R1GNwIx4WGFdclJ7bPCiGjc+GdvyvoyB0mIZsVWC8AE8VB?=
 =?us-ascii?Q?CJ0KmIINIZZsWBhYQ7B8jieTESqT8v2z5LK+rXlEs6whgBP0lw86k7EMFefb?=
 =?us-ascii?Q?xZD41WpnKDZ6wloZKm0WWUXAOUJYye9Ieh5sr3C5zL3O7N5+eYpb/U4uMJ3W?=
 =?us-ascii?Q?by+UaRlDaNEWJHjdMlCEVztElqcnPTeBe6w+WyL5F9wFum4RIAf92nWhACpm?=
 =?us-ascii?Q?fFZpj892G7e8Btyse/+sI4rdgrvsyweaoPpWyfiSIy7s5d7MvNNMXkoSsXlL?=
 =?us-ascii?Q?LSfwTh/objVMflRooCpua3x2++ZrKKPVeOzlNeQSeTwvw6JrTMuRQWaQPMzZ?=
 =?us-ascii?Q?dDDMcKSpAyPbuIto4osru7DJjSKvfWiEpxjPfyPVGrKnIIL/NpX0JBnb8oj3?=
 =?us-ascii?Q?ocyx8L5/caX+RR9OCodHhPEjOGCMN3NKLtcJ0xMzFc264uIRac93hOf4NYQR?=
 =?us-ascii?Q?wYxON9QfPRvjRa6A2FAvtpkuRo6v1MZJGKLqIrNVP8IP/iRPAGz5yq/YcEnD?=
 =?us-ascii?Q?w/UXlnD27B4AwDNLN3qdSj4x1VtHXZf+k/r+TDWBSKPv6fUfyy6w9u4ewpc9?=
 =?us-ascii?Q?ubLUdyaheSWuzOiFHVqnMb9mj3zYINBGXyVZ2NLkZqFpHR/ft39T3YbX3rLm?=
 =?us-ascii?Q?yNj462Lt0zpBIBs82XFLzw2PMfOvego0rkiYekuEcZjw0AodvtfFaH5oj30s?=
 =?us-ascii?Q?qxHpU1bkwwvOffszaFzg0Pg0jXQD9+HE47omC+EIUCsh8VPwpOtHfPo0E+uD?=
 =?us-ascii?Q?3ykShKvCDfndXEl9CtZLn8pg/agpaP9xqji2d0nE2OdtGEaMlpA5ItaiPqj/?=
 =?us-ascii?Q?gQvmbatRNTBquJPHZwDwcri+rDamz+kIrDAo30zoKDYQN2hXd9dDCLKiTxXc?=
 =?us-ascii?Q?OYMTQc49XGxawRsdMsM5rWVXpsS2awU6wU+cnHcXtnMmhAQCMccYf3pJH8Eu?=
 =?us-ascii?Q?mgTJo5fZO6pYHQRHd1lmyGU/2yV8la59eUeV8QQ/VzbiH8Uj8x00aKhlbUPN?=
 =?us-ascii?Q?DSGGDYfSK/kg4kiZZzodefCrcuNlrFqE1bTxIK1ZMaP4dGlHyw+zkuRZCi2p?=
 =?us-ascii?Q?knOHG6pGKhBqCFJYblMgYBmTlkYyU9VQLDQlbq6hncUoy3ZbdCKMBYHD08NF?=
 =?us-ascii?Q?/5ghpLKycdt1xUsN+2xuJNxGHcTyGpC6FsYGLSm6jIHHSt6MWKTGsWb5RGiu?=
 =?us-ascii?Q?AX8Tq6Z45mANBvwYdxCpq2nj9JUWuQaO1U4AGkRX4uuA74aJftNZXdw1gH+9?=
 =?us-ascii?Q?IjlouYjtzgwFMLEcEbHtczbfqEHsubJUQrbhWQtq05WKwhemXSe2AEAZXRs2?=
 =?us-ascii?Q?w7ByQIiRUDfMoho/zJZdvVNHnjr+Bf0sEbDM2/vfSvnkiGMcRY0FG14qY7Px?=
 =?us-ascii?Q?MqzTDSNqYm9kXm/vqhSj5uwwt4nuCNSXUx+zVHeQg+8Xp0F5cHqZjPDx/a9L?=
 =?us-ascii?Q?9NLmTh6WshDSHm7N5DiPwDwmQI/bjHoEwJ1BmcfvULDBwSmbilzj2qCSNaZg?=
 =?us-ascii?Q?Ntx0jPSTwj9KLLunl+C6f8dppKKGkAtDisKDHadSQ8xwERruN7IvoajQfWK0?=
 =?us-ascii?Q?QGtmnkoOih/0bKNraY8EcgcuB8yxJ9F3kSY7e4j6YPja8GWeBEroElNtpFEM?=
 =?us-ascii?Q?uYIcYnwJiAZs/2K/FN0e+9qFGer1Nunj2Dr4Yl0+YKPlCHK+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe0be52-bf10-44b0-7d93-08de9c8b6013
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 14:12:36.1743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpuOqZ/QKmoUaR4Hm8Lw85dDSSPcHWwTx1Oe+AJnH335k7i2Rhk8utmrGgBW6WMM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12128
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

LS1088AQDS u-boot contains multiple DTB files:
fsl-ls1088a-qds-21-x.dtb and fsl-ls1088a-qds-29-x.dtb.
It does not use default device tree fsl-ls1088a-qds.dtb

However, the nodes updated in fsl-ls1088a-qds-u-boot.dtsi are not
included for fsl-ls1088a-qds-21-x.dts and fsl-ls1088a-qds-29-x.dts,
so fail to get any output from serial.

Signed-off-by: Ye Li <ye.li@nxp.com>
Tested-by: Wei Lu <w.lu@nxp.com>
---
 arch/arm/dts/fsl-ls1088a-qds-21-x-u-boot.dtsi | 9 +++++++++
 arch/arm/dts/fsl-ls1088a-qds-29-x-u-boot.dtsi | 9 +++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm/dts/fsl-ls1088a-qds-21-x-u-boot.dtsi
 create mode 100644 arch/arm/dts/fsl-ls1088a-qds-29-x-u-boot.dtsi

diff --git a/arch/arm/dts/fsl-ls1088a-qds-21-x-u-boot.dtsi b/arch/arm/dts/fsl-ls1088a-qds-21-x-u-boot.dtsi
new file mode 100644
index 00000000000..1d58f1c593b
--- /dev/null
+++ b/arch/arm/dts/fsl-ls1088a-qds-21-x-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *
+ */
+
+#include <config.h>
+
+#include "fsl-ls1088a-qds-u-boot.dtsi"
diff --git a/arch/arm/dts/fsl-ls1088a-qds-29-x-u-boot.dtsi b/arch/arm/dts/fsl-ls1088a-qds-29-x-u-boot.dtsi
new file mode 100644
index 00000000000..1d58f1c593b
--- /dev/null
+++ b/arch/arm/dts/fsl-ls1088a-qds-29-x-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *
+ */
+
+#include <config.h>
+
+#include "fsl-ls1088a-qds-u-boot.dtsi"
-- 
2.37.1

