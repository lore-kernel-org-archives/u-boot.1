Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BED0CF6495
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 05:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B68588B23;
	Sun, 29 Sep 2024 07:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="fJx7lrYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A98C688CCF; Sun, 29 Sep 2024 03:56:20 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F6888BE4
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 03:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSI7kCKhm5Abtf/K+Mm/QV6dC7OueRNKZehsHJcxXxb57qIKz4phdCExfoHmRhfs4C3IWjxR3SlFQMCRXGALLFy2vncH+QG7YexygcwlFowxzWzN6ShCD5BbkFEfsPdUtJ6x5GXTbLxEMgVIyA6oMCZJF8OOvCWqD5DWfBimECxVivvz8IGNGhx8UMlZcCCeyKnSV/coDroWbtgex+inziuZ9BjhCfojKHxs4kkSBbCrjTUhDi3oAaVrb1O7NvhmPcVFFUY9a9I6RCgULOmEz8y6XgAbY9rhK+2vYS+WFqXllHqJpPVAMRtmV5d/k3XTGd+Y7XVl9bPdKGOaClV0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AV9zp3ufNeWIltdd+CB4plYUbJh+pSvUwdW3P3mJJI0=;
 b=qOsh9uiPE0e0W0gshtBJNyEmxG5Jap8r/hhq0h894Lflbn533nU+X8GtMwfgH8Gi4uRmtKul5kjIPlgA59EF0eGqE8l6UeQ4djM30eaVZNZWvTpBhGnv8Pm1DomkIL7wsmockLmL8zlWMgK3UiLwF+XGZdyKJQpLaC/Cil1e/X2YQO5jTzmeswIr1LxMG4UmN1Vwoyhe0vTGaVkjnttp42YP2zedibx8IveEHbQRnjbB6uyykJAsp0VMJqNwPvBV69uxHZiYLNI7hri1nFEWcxLum0y1CkkXAt2BjkkebSMgMPHSmfXcffR1HhjFrfN3mZU+VI8h+VV+ws/0Q6IKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV9zp3ufNeWIltdd+CB4plYUbJh+pSvUwdW3P3mJJI0=;
 b=fJx7lrYLUjH4OvToUoRgFmGlCHDdzcDflZXW5mnK95MXk0VvZzSJVnxTNc1OzM1NRJsENAu4fVaX0n3J4MfuCAr6pCA8/OVLTfWvs9dUt37AesOZV+80H5kLHHTAJqJR1paML5rrvOs2Sby3hDsG852yy1i8tImrCA2CG2lOtHaC2mVDobYtvFqrCZssAk9CoSsHoQjZlEWwuY9eOcKopBE1MkMyZjs4+wNVhbf0/sURmMEC37bjVUvGt+v/N2pKecnXpm0z3+qenvfVaEkuujpFhrwNbS2/Lnt9W5YO15KuR+S0/+PbEyE6g+Koz2DSGvIFVEdJ3C5UeqTiAKNzyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB9PR04MB9775.eurprd04.prod.outlook.com (2603:10a6:10:4ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sun, 29 Sep
 2024 01:56:15 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 01:56:15 +0000
From: Alice Guo <alice.guo@nxp.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, peng.fan@nxp.com, viorel.suman@nxp.com,
 michal.simek@amd.com, ye.li@nxp.com, Alice Guo <alice.guo@nxp.com>
Subject: [PATCH v1] mailbox: add i.MX MU driver
Date: Sun, 29 Sep 2024 09:55:24 +0800
Message-Id: <20240929015524.2753279-1-alice.guo@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB9PR04MB9775:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b72087b-71e2-4112-5ee0-08dce029e6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6gcT7DN1GcIuGNvQl6CpyVgqw29F9DLBq4gwB2MxO9FK6aCa9ClRpaQvXeYw?=
 =?us-ascii?Q?nIuRVEM7Pm/EGOb9E0GCUUVdJBT1TwXoIodsbHPKIHkZGirgNt6fGLzLyCED?=
 =?us-ascii?Q?/1ZjuzYYFZzaz382Vkrja0NjBLvTA5+BkSSzngsggZhbGTY2bB6sxid9aqxn?=
 =?us-ascii?Q?5nJMvmGEH6h54f8uj7umYEyLaHiTvsyEX7CC4BfUyUmGDbW27Yol+EwxBPn6?=
 =?us-ascii?Q?t8fRKfFATSeG2X8wU71BXYcsIdonwlNmL3jqJPOw9GDToNe7+n9TuY7mVafr?=
 =?us-ascii?Q?6Kbr0ym6piieUzy0+k3CMWSJ6FWjirJQq2DidAKRL2rWC6gfw6XWGIzB3P+I?=
 =?us-ascii?Q?iRbQtgDkgqVZFxVLaSKB64ObnzclVDgKYXeOQk4C+EB57K3PrnpmXtF19dua?=
 =?us-ascii?Q?AOUBxbB8N7EXPBykXzqTzaiADiCZwGt/NJr9rhttK3aRZBisvBnE8IkNnxH6?=
 =?us-ascii?Q?oIkBebYXsVhoKaVbhCYtj8i0ny2ieps1dPwxmTXL0aaUz9wqxVys4ol2XgM3?=
 =?us-ascii?Q?tWlNG3cpO8r2T8y1+QspUqP3hgz6EBAhue3xE1X+VMy+R//peixWr30RbcfY?=
 =?us-ascii?Q?XUrwdHCMhxil48uVB8yK07EK+80q7jao8LdzC7x7LTU4vPabl6RMg6JL52tb?=
 =?us-ascii?Q?xuIZIqK6b+qzPxjIwdekH+e0TiU2oDvKZPsRg1MQfF8lx6DH7U3JBBVIQDRm?=
 =?us-ascii?Q?USFFfC6kgzorSDPeX7fa54ARb/d/yZdaQTF0fLKZXBGpU7iC23IWF915dwuv?=
 =?us-ascii?Q?lpLBXokyYY6p8PENtDaxUmYTzSSSuRSrCjRcpfntGIyPa5FJKJsg4XWGzUvw?=
 =?us-ascii?Q?XiLpGwshlinpEXyWdVRzotSatZ3sMvTMjWd+NTCy7IoDpKjKGMnrxok4c/2w?=
 =?us-ascii?Q?7MsQD6qd5XpYkEtxiRy8wu/sUvEL0RVtXFLC0Gi4vS7lxSs+L6z0BtbYVxra?=
 =?us-ascii?Q?1uoyo/qS6Z1/IkinloSk1v53q9pqQzPirV54YH7dEQnjaYDPTjyuVjIPHvTL?=
 =?us-ascii?Q?1YwrYLnoPw2lWuzQZvTNOdLdu+ry5HXcAcSCerzWRM8FnzLUvVPBIxFCfp7L?=
 =?us-ascii?Q?5JfCIreAM9SkEpK8WQdYS/RqZhzDJIqsrIU9r7kXf5hDviSkHRs98rD/iR1A?=
 =?us-ascii?Q?IBxIi4jZVG4nnqP4zTh0hzDCk1ILGIU1+rW73DzLa5qyOlE5kdrpx7wjDABk?=
 =?us-ascii?Q?dQwf7pIVfT9M8TPdFJHwz7L48t2iFp0mRlxqHtmEx9fVZNReTibti2yL0tkf?=
 =?us-ascii?Q?c9AD2gnGAd+MG5F2l+MEcjaG1bbXiED+NMRjcdEO/+lTwWicd3xOrrGwimWW?=
 =?us-ascii?Q?mpMgui9L3XzKREthBhee+uD6+gJP+hWsDYmrBYfi30d1LKqaQXvEoz39sxSi?=
 =?us-ascii?Q?QkhPGBUq/RIYsopoFnz5Xe8h7NDLoESBCEjUSVGF8J5ULHQWNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VuGQZcIArdHa0LAvqtpRCi4+yOtXyXivapABdQDs/oaWUvfLXvHA8eC8FnuC?=
 =?us-ascii?Q?hwDa2Q2OpdzwKONEndyzcQftwCjOlS0ig5QFioOD05qaq/QH5cjx06PcBJur?=
 =?us-ascii?Q?7C9Ac7yrt3YyOSLbZXuMjO4PecZyTICrVayDdugNaXGe+CtBhAWuzxJPDE6Y?=
 =?us-ascii?Q?sr2etKZvZyc4bjx4r46SSKHwxoYsYV3Xw6ehQPKeOKzCX4qzOppmJDVSVkhS?=
 =?us-ascii?Q?xlmUeQq3DCCvG/0kD599sTWgfAqWb5Sy+FlwGYSERnMFyuq935Lz/Q6BCUwU?=
 =?us-ascii?Q?dusUuqlzXIyFWOEQT1tLgKnfMLquEEdbWXkM1RyvmmvenGVSx6r1Q2zDiliy?=
 =?us-ascii?Q?ZKLVhFuYDiYUbBa6/7edMA1P4cmpFymhedUUv+E7BhdTpLkZpQH9sMqpjMtO?=
 =?us-ascii?Q?lPjLgsnjHM4B6X9qHrsrvnseAqRqIJn7w4jgHmJ4VUMnvbA29zDqJIm5TSQt?=
 =?us-ascii?Q?uSBbmJCExalbo1OdJ9Mly+zvPoUf+fZoceRDeBrEr48uRUiiwi1eqgWcRDqs?=
 =?us-ascii?Q?dLGwV09JPFwJ8U1f/TG/WQqZw2yQUWHPzokTZTMMP2xtnn4Z0SNp/HyKrFdM?=
 =?us-ascii?Q?Q2UsG/rfDaEheoxzi9E+y+BpJrrBjGfz1D7S2WXLUfd3f8J7rPHjBVO1nmEp?=
 =?us-ascii?Q?XVzURajEfxaRnC0VVb9mGw4y7RZNXg9EGyd9XZ8FfJGA+bBhc+NCRI9V4c+p?=
 =?us-ascii?Q?DUNnYW96mhwD0OsDDGLCQ9HpNFr2Wo5xgXkzE57pGBXUly31zN+ZhH2RpP+F?=
 =?us-ascii?Q?CaeQaS4/bKlH9umi3/C8cL2cKUIsgXUVuBnLCeva0G/QMv496JXecVBQKp55?=
 =?us-ascii?Q?ZdcNoBOFbJwrhsS5sF/tT8FrAy4z39o0+1nsYJ+B+7QuqdPKSCQ+j7br1unP?=
 =?us-ascii?Q?QOkT6frTItLeDo84oeDH8JeENnWkD+naJFQOmi8SqicWM3070UBOs7xFey0Y?=
 =?us-ascii?Q?AKle78CzLIuaacm/G0mUHp9ehF5RB+DAETWSy+uTxsSmPkkWnDxPACsM02ey?=
 =?us-ascii?Q?MLTn2GkuExWTek8ZdkcTb9pnX0DIDqvnfuJs7uh99/yKE7WBCJQv8v7y0aH2?=
 =?us-ascii?Q?p95M0w74QuGH0g9ivu+kUWP3S4ueSEfCur0s0LS6FDDzjhkgv6vWwFZkcHKK?=
 =?us-ascii?Q?KFrG44EhiVca62GyC4HPQ6OSmFMbQITyLwMwYPrWWRdb8YlRqPEr+MrIUJ4d?=
 =?us-ascii?Q?SgRtPhik0mneFMzyybdx3G+wla1Ru1CuLBdvPrMrY/BYvcpUTpyMvyLxPVcM?=
 =?us-ascii?Q?mI9O8vjz1GGjAZoQwYwIrI21DWN9GoLpd6ssYzQAVBf+qq5k1Twn9DBpdyF/?=
 =?us-ascii?Q?cMA7PyDXLJf6GDG4YOAOHxtCzfA/WMcnvCMcTJohFKpzciR1UGj6tZ71CLbL?=
 =?us-ascii?Q?p6f5k5HXUrBw10sSWKjpx1L5IOWNcqgIEPFWKq5Avv5VdDc6xRdByUfzZoQ4?=
 =?us-ascii?Q?sydoErm/vLr1eo88BNfAl2oWTOzWFsWlgIgREyF7aOAP6lRebSoKnL6QGJJ/?=
 =?us-ascii?Q?Ps5+yWcdAS2+bLxm5lwrVPmTRMz2a/QNkSZCWdTB4StvuFTQ/6zQMFtn4TR2?=
 =?us-ascii?Q?nmTtwsJ9BXBC02a4Rw3FqWG3Rj58WAnA9wJu83dR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b72087b-71e2-4112-5ee0-08dce029e6f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 01:56:15.4930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDYKfvo80lftsbS8jzbJtB/n0kWSttd2D7WIepduTGtV31nnW7DBsJ5B4mroCj3KhST3QtEpn63RorPUAFRHZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9775
X-Mailman-Approved-At: Sun, 29 Sep 2024 07:37:06 +0200
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

Add i.MX MU based mailbox driver.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/mailbox/Kconfig       |   7 +
 drivers/mailbox/Makefile      |   1 +
 drivers/mailbox/imx-mailbox.c | 417 ++++++++++++++++++++++++++++++++++
 3 files changed, 425 insertions(+)
 create mode 100644 drivers/mailbox/imx-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 67d5ac1a74..4d9f004eba 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -21,6 +21,13 @@ config APPLE_MBOX
 	  such as the System Management Controller (SMC) and NVMe and this
 	  driver is required to get that functionality up and running.
 
+config IMX_MU_MBOX
+	bool "Enable i.MX MU MBOX support"
+	depends on DM_MAILBOX
+	help
+	  Enable support for i.MX Messaging Unit for communication with other
+	  processors on the SoC using mailbox interface
+
 config SANDBOX_MBOX
 	bool "Enable the sandbox mailbox test driver"
 	depends on DM_MAILBOX && SANDBOX
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 59e8d0de93..96a6adb709 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(SPL_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
+obj-$(CONFIG_IMX_MU_MBOX) += imx-mailbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
 obj-$(CONFIG_STM32_IPCC) += stm32-ipcc.o
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
new file mode 100644
index 0000000000..584950b20d
--- /dev/null
+++ b/drivers/mailbox/imx-mailbox.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2017-2023 NXP
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <mailbox-uclass.h>
+#include <linux/bitfield.h>
+#include <linux/bug.h>
+#include <linux/iopoll.h>
+#include <linux/compat.h>
+
+/* This driver only exposes the status bits to keep with the
+ * polling methodology of u-boot.
+ */
+DECLARE_GLOBAL_DATA_PTR;
+
+#define IMX_MU_CHANS		24
+
+#define IMX_MU_V2_PAR_OFF	0x4
+#define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
+#define IMX_MU_V2_RR_MASK	GENMASK(15, 8)
+
+enum imx_mu_chan_type {
+	IMX_MU_TYPE_TX          = 0, /* Tx */
+	IMX_MU_TYPE_RX          = 1, /* Rx */
+	IMX_MU_TYPE_TXDB        = 2, /* Tx doorbell */
+	IMX_MU_TYPE_RXDB        = 3, /* Rx doorbell */
+	IMX_MU_TYPE_RST         = 4, /* Reset */
+	IMX_MU_TYPE_TXDB_V2     = 5, /* Tx doorbell with S/W ACK */
+};
+
+enum imx_mu_xcr {
+	IMX_MU_CR,
+	IMX_MU_GIER,
+	IMX_MU_GCR,
+	IMX_MU_TCR,
+	IMX_MU_RCR,
+	IMX_MU_xCR_MAX,
+};
+
+enum imx_mu_xsr {
+	IMX_MU_SR,
+	IMX_MU_GSR,
+	IMX_MU_TSR,
+	IMX_MU_RSR,
+	IMX_MU_xSR_MAX,
+};
+
+struct imx_mu_con_priv {
+	unsigned int		idx;
+	enum imx_mu_chan_type	type;
+	struct mbox_chan	*chan;
+};
+
+enum imx_mu_type {
+	IMX_MU_V1,
+	IMX_MU_V2 = BIT(1),
+	IMX_MU_V2_S4 = BIT(15),
+	IMX_MU_V2_IRQ = BIT(16),
+};
+
+struct imx_mu {
+	void __iomem *base;
+	const struct imx_mu_dcfg *dcfg;
+	u32 num_tr;
+	u32 num_rr;
+	/* use pointers to channel as a way to reserve channels */
+	struct mbox_chan *channels[IMX_MU_CHANS];
+	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
+};
+
+struct imx_mu_dcfg {
+	int (*tx)(struct imx_mu *plat, struct imx_mu_con_priv *cp, const void *data);
+	int (*rx)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*rxdb)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*init)(struct imx_mu *plat);
+	int (*of_xlate)(struct mbox_chan *chan, struct ofnode_phandle_args *args);
+	enum imx_mu_type type;
+	u32	xTR;			/* Transmit Register0 */
+	u32	xRR;			/* Receive Register0 */
+	u32	xSR[IMX_MU_xSR_MAX];	/* Status Registers */
+	u32	xCR[IMX_MU_xCR_MAX];	/* Control Registers */
+};
+
+#define IMX_MU_xSR_GIPn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xSR_TEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+
+/* General Purpose Interrupt Enable */
+#define IMX_MU_xCR_GIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+/* Transmit Interrupt Enable */
+#define IMX_MU_xCR_TIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+/* General Purpose Interrupt Request */
+#define IMX_MU_xCR_GIRn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
+/* MU reset */
+#define IMX_MU_xCR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(5))
+#define IMX_MU_xSR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(7))
+
+static void imx_mu_write(struct imx_mu *plat, u32 val, u32 offs)
+{
+	iowrite32(val, plat->base + offs);
+}
+
+static u32 imx_mu_read(struct imx_mu *plat, u32 offs)
+{
+	return ioread32(plat->base + offs);
+}
+
+static u32 imx_mu_xcr_rmw(struct imx_mu *plat, enum imx_mu_xcr type, u32 set, u32 clr)
+{
+	u32 val;
+
+	val = imx_mu_read(plat, plat->dcfg->xCR[type]);
+	val &= ~clr;
+	val |= set;
+	imx_mu_write(plat, val, plat->dcfg->xCR[type]);
+
+	return val;
+}
+
+/* check that the channel is open or owned by caller */
+static int imx_mu_check_channel(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	if (plat->channels[chan->id] != NULL) {
+		/* if reserved check that caller owns */
+		if (plat->channels[chan->id] == chan)
+			return 1; /* caller owns the channel */
+
+		return -EACCES;
+	}
+
+	return 0; /* channel empty */
+}
+
+static int imx_mu_chan_request(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp;
+	enum imx_mu_chan_type type;
+	int idx;
+
+	type = chan->id / 4;
+	idx = chan->id % 4;
+
+	if (imx_mu_check_channel(chan) < 0) /* check if channel already in use */
+		return -EPERM;
+
+	plat->channels[chan->id] = chan;
+	chan->con_priv = kcalloc(1, sizeof(struct imx_mu_con_priv), 0);
+	if (!chan->con_priv)
+		return -ENOMEM;
+	cp = chan->con_priv;
+	cp->idx = idx;
+	cp->type = type;
+	cp->chan = chan;
+
+	switch (type) {
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, IMX_MU_xCR_RIEn(plat->dcfg->type, idx), 0);
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, IMX_MU_xCR_GIEn(plat->dcfg->type, idx), 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int imx_mu_chan_free(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) <= 0) /* check that the channel is also not empty */
+		return -EINVAL;
+
+	/* if you own channel and  channel is NOT empty */
+	plat->channels[chan->id] = NULL;
+	switch (cp->type) {
+	case IMX_MU_TYPE_TX:
+		imx_mu_xcr_rmw(plat, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, 0, IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		break;
+	}
+
+	kfree(cp);
+
+	return 0;
+}
+
+static int imx_mu_send(struct mbox_chan *chan, const void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	return plat->dcfg->tx(plat, cp, data);
+}
+
+static int imx_mu_recv(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+	u32 ctrl, val;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_RXDB:
+		/* check if GSR[GIRn] bit is set */
+		if (readx_poll_timeout(ioread32, plat->base + plat->dcfg->xSR[IMX_MU_GSR],
+		    val, val & BIT(cp->idx), 1000000) < 0)
+			return -EBUSY;
+
+		ctrl = imx_mu_read(plat, plat->dcfg->xCR[IMX_MU_GIER]);
+		val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+		val &= IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx) &
+			(ctrl & IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		dev_warn(chan->dev, "Unhandled channel type %d\n", cp->type);
+		return -EOPNOTSUPP;
+	};
+
+	if (val == IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx))
+		plat->dcfg->rxdb(plat, cp);
+
+	return 0;
+}
+
+static int imx_mu_of_to_plat(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -ENODEV;
+
+	plat->base = (struct mu_type *)addr;
+
+	return 0;
+}
+
+static int imx_mu_init_generic(struct imx_mu *plat)
+{
+	unsigned int i;
+	unsigned int val;
+
+	if (plat->num_rr > 4 || plat->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	/* Set default MU configuration */
+	for (i = 0; i < IMX_MU_xCR_MAX; i++)
+		imx_mu_write(plat, 0, plat->dcfg->xCR[i]);
+
+	/* Clear any pending GIP */
+	val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+	imx_mu_write(plat, val, plat->dcfg->xSR[IMX_MU_GSR]);
+
+	/* Clear any pending RSR */
+	for (i = 0; i < plat->num_rr; i++)
+		imx_mu_read(plat, plat->dcfg->xRR + i * 4);
+
+	return 0;
+}
+
+static int imx_mu_generic_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	enum imx_mu_chan_type type;
+	int idx, cid;
+
+	if (args->args_count != 2) {
+		dev_err(chan->dev, "Invalid argument count %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	type = args->args[0]; /* channel type */
+	idx = args->args[1]; /* index */
+
+	cid = type * 4 + idx;
+	if (cid >= IMX_MU_CHANS) {
+		dev_err(chan->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n",
+			cid, type, idx);
+		return -EINVAL;
+	}
+
+	chan->id = cid;
+
+	return 0;
+}
+
+static int imx_mu_generic_tx(struct imx_mu *plat, struct imx_mu_con_priv *cp,
+			     const void *data)
+{
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+		imx_mu_xcr_rmw(plat, IMX_MU_GCR, IMX_MU_xCR_GIRn(plat->dcfg->type, cp->idx), 0);
+		break;
+	default:
+		dev_warn(cp->chan->dev, "Send data on wrong channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx_mu_generic_rxdb(struct imx_mu *plat, struct imx_mu_con_priv *cp)
+{
+	imx_mu_write(plat, IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx),
+		     plat->dcfg->xSR[IMX_MU_GSR]);
+
+	return 0;
+}
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx95 = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V2,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
+};
+
+static const struct udevice_id ids[] = {
+	{ .compatible = "fsl,imx95-mu", .data = (ulong)&imx_mu_cfg_imx95 },
+	{ }
+};
+
+int imx_mu_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	return plat->dcfg->of_xlate(chan, args);
+}
+
+struct mbox_ops imx_mu_ops = {
+	.of_xlate = imx_mu_of_xlate,
+	.request  = imx_mu_chan_request,
+	.rfree    = imx_mu_chan_free,
+	.send     = imx_mu_send,
+	.recv     = imx_mu_recv,
+};
+
+static void imx_mu_get_tr_rr(struct imx_mu *plat)
+{
+	u32 val;
+
+	if (plat->dcfg->type & IMX_MU_V2) {
+		val = imx_mu_read(plat, IMX_MU_V2_PAR_OFF);
+		plat->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
+		plat->num_rr = FIELD_GET(IMX_MU_V2_RR_MASK, val);
+	} else {
+		plat->num_tr = 4;
+		plat->num_rr = 4;
+	}
+}
+
+static int imx_mu_probe(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	int ret;
+
+	debug("%s(dev=%p)\n", __func__, dev);
+
+	plat->dcfg = (void *)dev_get_driver_data(dev);
+
+	imx_mu_get_tr_rr(plat);
+
+	ret = plat->dcfg->init(plat);
+	if (ret) {
+		dev_err(dev, "Failed to init MU\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(imx_mu) = {
+	.name = "imx-mu",
+	.id = UCLASS_MAILBOX,
+	.of_match = ids,
+	.of_to_plat = imx_mu_of_to_plat,
+	.plat_auto = sizeof(struct imx_mu),
+	.probe = imx_mu_probe,
+	.ops = &imx_mu_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.34.1

