Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF6FC27C43
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2306B883F6;
	Wed, 29 May 2024 16:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YmoPbIIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60C2188615; Wed, 29 May 2024 16:48:29 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52359885A9
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkDEMnxBHLi5mefNs/5z1xuuN88RxTClXqHfNkUaNObkLcIGqFeOJcjAvywfYWpLpoBhMppOuYnvs4ML3Dl/BXWG/+CV2LpuZ3t9VkXx++H7NeIxoJa4SqNVhDjec5ichnId9c1iVwBpXE41sM5M/s+uN5iE59UZzuCf1T2PWBwBkFBP9Et508zxStKvnndtzCpTcV7zuXnmmCdmlaW18mf+SU9b4t0vi7AdKlwpiKzncEiiPaqM8KnD26vB8pPpaW2rh2qpXkUTRs75tbh2LBGgAZZ6juaC8IOEtB1W06X2sKGyINOkA7dN6aE/shKD2R+8+1W+kG0Z4QmoHFyMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4Xg0dZwcKFLdiC3nMu6jnlXLh6CpMbo9X9CDGAYpsM=;
 b=kVmu4tZgfAz8MCL0V2aP8RRBnC1ReEnXPh3pyGJ/bMZdNdx8ZREZ3XoActfEPjYc+w6hrjOE0EE9vxVz+n8Y8Q4rmOt3U2zclm6+RTZyAm1rfautVCu2py1NY0Q1+grT7qY4PL3qEUxra6XjbVaIzDH2rpO06LEY38EoIC/WckmvbC5MR2It67SXos9hsLHKV1dKOiFE+qsykFr2ejsDrmMhBQG02rSPfv/tXsyWFCoKWLu8ZTd8Q+P0e+JrNOwT2LFY0epA7s7YqPgB0DFmuFMr8cqyz0gsgfLWWx6VzxGaQd3kDjV8haBJzOPgsdWP2qSm+uOa6FVj4fV7hi7VAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4Xg0dZwcKFLdiC3nMu6jnlXLh6CpMbo9X9CDGAYpsM=;
 b=YmoPbIIhGtVi0CaGwfLUJF+YhvK+nKpJ3HYaFCnXqonwSe3jWC/E9ksmS81fak0BmXfXIQiJJYb53Njnyg9BNa992AnS7/g7j9drb643Ha7Ny6wwSFYEBCAONTXdXsM+dAA03X5dwuOhIUSJqt1A6po/nqF1WPAMRfH1GCE9d1o=
Received: from BL0PR0102CA0017.prod.exchangelabs.com (2603:10b6:207:18::30) by
 CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 14:48:24 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::36) by BL0PR0102CA0017.outlook.office365.com
 (2603:10b6:207:18::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Wed, 29 May 2024 14:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 14:48:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 09:48:22 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, Peter Robinson
 <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 3/4] mmc: versal2: Update zynq_sdhci driver to support AMD
 Versal Gen 2
Date: Wed, 29 May 2024 16:48:00 +0200
Message-ID: <f07daded9704cbc393657b65a28933c34a8cec25.1716994063.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716994063.git.michal.simek@amd.com>
References: <cover.1716994063.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4320; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=hIScsbcze8D3gjhX0NtR73D4COr1vxPk2pkUfX8ggLE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrRwB9nYt3+Xpy/5/T3sq/njmPqFJU1fJdJW9fT+2VKZp
 nDV611hRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIZGGG+dVR93bu0P80Z/r+
 q5qfWna6x7YFTGZY0HDTOdK7Yo3L5iUvq/qC+3pnSBrMBwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6f7bf4-ef01-48c4-175f-08dc7fee6447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?50isSpmpvXbJTCBvo6LnSoyro4hpYHDRE/A2APD/vL57kh7PbBjSB2jkTLVv?=
 =?us-ascii?Q?LipT9rm7l8WoAepPD07Gz/so+36qTE5Etp5iINp1b5dUBsyzu05g/UQqK2Xd?=
 =?us-ascii?Q?Kl86GiRLh6UDTnD+ApYkxAr07wlP9kxS+ydVmXy/jR/o9JZDLptwTXJLkLgg?=
 =?us-ascii?Q?qERcXPbwnYGTGNK3Ufa2E7eC4VQ/G/ixmsfHxankF3MEshJvX1W2T190nDnN?=
 =?us-ascii?Q?iM4tYFC+deqDCQ2EYgU/fCQpmCwwJM32jKqQj8ABHnK91siUGkKZTv8YHMBr?=
 =?us-ascii?Q?BI4vYrDCdZ02rnTzu64zsKZcthA4DE3mK3wsJ3I2LiiVX7qYidm1FdK9WW9l?=
 =?us-ascii?Q?y7fbguJZRRQkaM7LovgWX2ZTcAdhbRK0K1fQ1mcYh6BnWdXAE7y3+hc+dOEg?=
 =?us-ascii?Q?ItofqQ98cPr6+dCOzRBEJi8PJdIyV9zrHuVxz+fXJxgbmUvDq1mg+5AJiuIB?=
 =?us-ascii?Q?d3SJhX4F9naOFzN6LPneEKh8sQUrRDDEZ4gzJBm3IsczSNmOWtArICdfDqds?=
 =?us-ascii?Q?etPr6gf77FXuGOfYxHs+MIZvgu/uW/MkQ9+gDQOoRfJlHxG9Ob+eJri0c5i8?=
 =?us-ascii?Q?m1zBLrs4f/DkuAL/aDmd6NBXdYs0p5fUTpVYC2j5ZQq6fooSiNG+ndUwaGPL?=
 =?us-ascii?Q?TjcADA+vvQcY8VGfH7V3cTAwuNCiPk5nX0aD7pWHlwzlLBVx5/u3P9Mjy3O3?=
 =?us-ascii?Q?PnruccieO49ESh8BBJDkIltoOnU+J1UHducpl7epmUnOPJSXEeshYvJTohUk?=
 =?us-ascii?Q?mpr8TSbzEYNnBAdRxhJfcmG5Yv/nEa+yjK5RcqxX7kgwo9kseigtuBYJ0bMR?=
 =?us-ascii?Q?5bUxwXY/kkaA+quHZtcuQ2cluw90G7yJdJ2ukgd3V/DIckb50Uzao5G7NvZV?=
 =?us-ascii?Q?v+uFo1zvGlr+dErgDtLpoirzseVWAwgD5WCgzbWO83X9/fR7Fg6cUC/XZh5f?=
 =?us-ascii?Q?S2LIXS22wK++5Z1IJf04/BT/E94pKPrM2mhgNC4dz2BUaNGH8r/Pdp/SRLJU?=
 =?us-ascii?Q?FiGq3annFUjKFgAmAegqgeivmssIPZuFokc+mmRKpSFNWz9YUGGmL9N68P/0?=
 =?us-ascii?Q?Ps94TZL5nPYUrp4JPz7IhYe5Dy1mAAk5NYLSBBQRv5/e90//bF3+6mbFcp1F?=
 =?us-ascii?Q?dz0kj1RjvvMAyMBEg4dODX08KDKhlLg2Uw7naZJMjVIAdIczB2HUodpn5uwV?=
 =?us-ascii?Q?QVxDJ7+Dw/ukU9S6HAbwJNesyYzYy+kKvrsSK1c8YonwwOQ9nYNxloIV1QZR?=
 =?us-ascii?Q?w3+iACwX8ATbIHXdysRcjU0uDMRXBz8zR9o/Hkrl/AjkGj4I+dMxWxpvg//q?=
 =?us-ascii?Q?blG2ZYFu//xeDg4MqpxvituDMvaNFe0FXZb5zpaUCSiUxv0vRo0EnNjQ9nQY?=
 =?us-ascii?Q?4t8NbutCvZv+FgqnrHXvJ4YAwqzX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 14:48:24.0623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6f7bf4-ef01-48c4-175f-08dc7fee6447
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550
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

Enable tap delay programming for new SoC and also enable it via defconfig.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig |  2 ++
 drivers/mmc/zynq_sdhci.c           | 22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 8ef86f1f3830..b74e69be28c4 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -87,6 +87,8 @@ CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ZYNQ=y
+CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index 8a83adef4342..28d2b456fbf6 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -122,7 +122,8 @@ __weak int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
 	return 1;
 }
 
-#if defined(CONFIG_ARCH_ZYNQMP) || defined(CONFIG_ARCH_VERSAL) || defined(CONFIG_ARCH_VERSAL_NET)
+#if defined(CONFIG_ARCH_ZYNQMP) || defined(CONFIG_ARCH_VERSAL) || \
+    defined(CONFIG_ARCH_VERSAL_NET) || defined(CONFIG_ARCH_VERSAL2)
 /* Default settings for ZynqMP Clock Phases */
 static const u32 zynqmp_iclk_phases[] = {0, 63, 63, 0, 63,  0,
 					 0, 183, 54,  0, 0};
@@ -156,7 +157,7 @@ static const u8 mode2timing[] = {
 	[MMC_HS_400] = MMC_TIMING_MMC_HS400,
 };
 
-#if defined(CONFIG_ARCH_VERSAL_NET)
+#if defined(CONFIG_ARCH_VERSAL_NET) || defined(CONFIG_ARCH_VERSAL2)
 /**
  * arasan_phy_set_delaychain - Set eMMC delay chain based Input/Output clock
  *
@@ -866,7 +867,8 @@ static int arasan_sdhci_set_tapdelay(struct sdhci_host *host)
 		if (ret)
 			return ret;
 	} else if ((IS_ENABLED(CONFIG_ARCH_VERSAL) ||
-		    IS_ENABLED(CONFIG_ARCH_VERSAL_NET)) &&
+		    IS_ENABLED(CONFIG_ARCH_VERSAL_NET) ||
+		    IS_ENABLED(CONFIG_ARCH_VERSAL2)) &&
 		   device_is_compatible(dev, "xlnx,versal-8.9a")) {
 		ret = sdhci_versal_sampleclk_set_phase(host, iclk_phase);
 		if (ret)
@@ -875,7 +877,8 @@ static int arasan_sdhci_set_tapdelay(struct sdhci_host *host)
 		ret = sdhci_versal_sdcardclk_set_phase(host, oclk_phase);
 		if (ret)
 			return ret;
-	} else if (IS_ENABLED(CONFIG_ARCH_VERSAL_NET) &&
+	} else if ((IS_ENABLED(CONFIG_ARCH_VERSAL_NET) ||
+		    IS_ENABLED(CONFIG_ARCH_VERSAL2)) &&
 		   device_is_compatible(dev, "xlnx,versal-net-emmc")) {
 		if (mmc->clock >= MIN_PHY_CLK_HZ)
 			if (iclk_phase == VERSAL_NET_EMMC_ICLK_PHASE_DDR52_DLY_CHAIN)
@@ -943,7 +946,8 @@ static void arasan_dt_parse_clk_phases(struct udevice *dev)
 	}
 
 	if ((IS_ENABLED(CONFIG_ARCH_VERSAL) ||
-	     IS_ENABLED(CONFIG_ARCH_VERSAL_NET)) &&
+	     IS_ENABLED(CONFIG_ARCH_VERSAL_NET) ||
+	     IS_ENABLED(CONFIG_ARCH_VERSAL2)) &&
 	    device_is_compatible(dev, "xlnx,versal-8.9a")) {
 		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
 			clk_data->clk_phase_in[i] = versal_iclk_phases[i];
@@ -951,7 +955,8 @@ static void arasan_dt_parse_clk_phases(struct udevice *dev)
 		}
 	}
 
-	if (IS_ENABLED(CONFIG_ARCH_VERSAL_NET) &&
+	if ((IS_ENABLED(CONFIG_ARCH_VERSAL_NET) ||
+	     IS_ENABLED(CONFIG_ARCH_VERSAL2)) &&
 	    device_is_compatible(dev, "xlnx,versal-net-emmc")) {
 		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
 			clk_data->clk_phase_in[i] = versal_net_emmc_iclk_phases[i];
@@ -987,7 +992,7 @@ static const struct sdhci_ops arasan_ops = {
 	.platform_execute_tuning	= &arasan_sdhci_execute_tuning,
 	.set_delay = &arasan_sdhci_set_tapdelay,
 	.set_control_reg = &sdhci_set_control_reg,
-#if defined(CONFIG_ARCH_VERSAL_NET)
+#if defined(CONFIG_ARCH_VERSAL_NET) || defined(CONFIG_ARCH_VERSAL2)
 	.config_dll = &arasan_sdhci_config_dll,
 #endif
 };
@@ -1195,7 +1200,8 @@ static int arasan_sdhci_of_to_plat(struct udevice *dev)
 
 	priv->host->name = dev->name;
 
-#if defined(CONFIG_ARCH_ZYNQMP) || defined(CONFIG_ARCH_VERSAL) || defined(CONFIG_ARCH_VERSAL_NET)
+#if defined(CONFIG_ARCH_ZYNQMP) || defined(CONFIG_ARCH_VERSAL) || defined(CONFIG_ARCH_VERSAL_NET) || \
+    defined(CONFIG_ARCH_VERSAL2)
 	priv->host->ops = &arasan_ops;
 	arasan_dt_parse_clk_phases(dev);
 #endif
-- 
2.40.1

