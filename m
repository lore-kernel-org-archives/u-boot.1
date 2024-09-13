Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2728FA374B
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 12:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A518388D4D;
	Fri, 13 Sep 2024 14:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xBjA30A4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 652F4889B8; Fri, 13 Sep 2024 11:32:19 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB6988883
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4WLIyd4NYafjJ88INSF9pG98ONCBTp+5tJl/T/uCU5pgpKJ5iJ0V5XdP26LIgAUMvrI0OxE4FtQAk22I7ZhgxhQV3DtS46+oq1SA2GNkdU2hKjKzCiXOeUy5mMR1NVtHqjupS+R7Q7t95MHYvq2MIgqrTMMEau/2LVo5tc4YRTmv3GZVzv1fB+nPpRggj/g4Ow1GtYkdYDgT9Q2gnwTiAaf1JZ0LmNMrmu9jaV2BdqHOeujg0fuWAlc/QPlgTF9mum6gYD7Dvdo/6Hpg5wU6DFOem9vWreDmI8PG0JG6Tg3dxP8C5inKCIv4Q83V7VXI4DzRMktsL3fSScCRpqFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U26EjolZYunfiz2q9ELRmIh/KMscV2+0V1KOY3M0vyg=;
 b=OW5RcSc/Mtpol6UnMafpAOUBwhqGvxa0VeyePeOwA9LNQ72EBZdZh0qxNOAq0VLZPm3R5o0OVL9oeQWS/XBJR7PQvusbvhLcjZE6XOSdHbxeGGjeRuF5rU1XRhJ7co4vNxRZWl9+Ditv37LwTleuXNkLPEyaGBCsAQJ+5+SD3x4vyg9ku2pIA12PZKolcMAUcwl78eA7sO0JoARMeLVulQpL9uZRrt9NmpjMmcv7YrUp7WmNhlzdjGHdB0bIqd9Zxvd5PC87oH5ekOh8SDhs0dZjE0J8pUjtksdXnJnEEA6LG9CE4jQVelVEhNFL5On84PeS9rxyg6q3guZ5urxfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U26EjolZYunfiz2q9ELRmIh/KMscV2+0V1KOY3M0vyg=;
 b=xBjA30A49BwwaZfyIeE2Iywt3a1khVmhOS+THgqAXuxBGxKPTvQ+Tw5xRZOGkRimPIELnSugv6rL41KDdDeEWPSs9trXgcqb7Hwx6ebIQHW0ZMecF8BdMrQFrix4GMcLeLqTwN3k7bDXvYTqY0Rb2NaRspYYSBYhoNu3qcif2UM=
Received: from BN9PR03CA0901.namprd03.prod.outlook.com (2603:10b6:408:107::6)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 09:32:09 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::a7) by BN9PR03CA0901.outlook.office365.com
 (2603:10b6:408:107::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 13 Sep 2024 09:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Fri, 13 Sep 2024 09:32:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:32:06 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 04:32:04 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <git-dev@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH] mmc: zynq_sdhci: Remove device_is_compatible() function
Date: Fri, 13 Sep 2024 15:01:57 +0530
Message-ID: <20240913093157.2343476-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 424af2ee-c1a5-4185-8f36-08dcd3d6f034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vPp+gkZlKLjfqrknVx2W0zoz7tmywLLFDeW94ynWXedIGeNXxJkhGaZPXDON?=
 =?us-ascii?Q?cJALIPFYtPLrRNPn6UXcu7DLKmVzEOQUr+KUKLq5wOIkOPFJ5Gg/G8kuj7Fr?=
 =?us-ascii?Q?bnK5ZWlDh/GQag1NLVJkZdNyC0KCoMBiBL74muGL22Af4YKdKlTTqdCMWx8x?=
 =?us-ascii?Q?3XxEIyPaPwMlY4QU4MMxet3Xf7CTCT47W/4yGVnw7nHeB3eOiA2EMkhQ8v3V?=
 =?us-ascii?Q?lRbGYIHyFdUjeOioc5+cF/sA5tyIIjhpxkOIEc65bxeW9tNUKbSUoviMV5dL?=
 =?us-ascii?Q?8LjMBy67SQ4Y+/58GV6qQd10KLHJJXO2hXIiXsj3M8WwJFN/+DZQ8t0T8PBU?=
 =?us-ascii?Q?/HIqnFMa1UxkseRyqReOoMl0kplai3JQYzd3keiFxjxQEyEP96aHgsCKWWLS?=
 =?us-ascii?Q?LxfY99LONPrgU09+7/3/YpPD/wQmxtodsMciHftjv6iz9gaAr8J24Zv0XxTj?=
 =?us-ascii?Q?W63pCkyRXZbxK52IjxPQE3at0EtDxKiZ6c0ULpJLa+wQSxEpWk0czpG9J40X?=
 =?us-ascii?Q?/2vdBW3RypzuE/cU82YTL5FoLl5HSUVyvuVrmW+/qFtLKoqZvKxjdZ3Hz6tx?=
 =?us-ascii?Q?gLHCejbXUc/chX4gQbipVOr4ZdQgxOWgJK90yzS+M4g1Y7DOkTZqMNJuFC00?=
 =?us-ascii?Q?C/a2ZGLz/+nKaEdTMeRtEZ2CTUXLY1n71EgFwG/eAtlXmQSrDwQ+ywOA5ImS?=
 =?us-ascii?Q?iS/RL+oQuzVeLRyi0T9tSxS3mUgJVfThJxW3jEpCAKUJzkxsuvDUnFa1UXM+?=
 =?us-ascii?Q?0cNPY+ph+QlHdtHSpFfFjPym0tLGgvf8JeY6X/hwhrh5tEfIPLcU/7cxsL+N?=
 =?us-ascii?Q?gqVbrB7hVMC3OqjWi8bqoeEKO6x4TIR2lsZej3UWBnv18RtA3ZYk2RUq5qIa?=
 =?us-ascii?Q?5r+as97thwMRDGkn2AIH1dznm1jit6aqhRr18XE9XRNCaa/zJnyCM3MmDq7S?=
 =?us-ascii?Q?sfS5G+BKRpGh2BrMSTPebZ7I2tno3XDOVGyhZ+MmcsEOCo9ey6vK9jQ8vtln?=
 =?us-ascii?Q?W/kP6HQlht9AlO2EE2PXdCFNZygqm4wTBR4KhGnWljEePQ4LW5Elo36pkskX?=
 =?us-ascii?Q?zKUWFAuJXMYSoRRuIJP+EJxncsunaOd4yOnhBXIABqed8CKSzHCTmdWMCqhR?=
 =?us-ascii?Q?sa7MLjhrWBsekFC4lMM+6hy335x6hq5wRZewdmTG1CT1eidkxjd1yLSgVqtm?=
 =?us-ascii?Q?/RMtrWEg829aO8XDY7ipK7BhmCYydFG1Db+5H0iJ+1qEUKL6/OxWWKlsFuX6?=
 =?us-ascii?Q?GqdjRtqBZRrmaD7qUAquwagRivZPnfDzZpGsIQPGMKp/xPSnecFASj9jTSqq?=
 =?us-ascii?Q?NpLvKnJcg85bRikcxx2LFxP/vNwuZWuPY0X5fzKv73bmGbSWKp5APyqvlz4i?=
 =?us-ascii?Q?2BMb6wkMw2XaOWycbvzsSBuE3axruhaJGbQatu05oSPVM4EZCnQW4Y8lSNrN?=
 =?us-ascii?Q?7PZZ+FM+afe81OGJAOx8kDMSNuj65ssJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:32:08.5581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424af2ee-c1a5-4185-8f36-08dcd3d6f034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
X-Mailman-Approved-At: Fri, 13 Sep 2024 14:37:34 +0200
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

There are lot of device_is_compatible() present in the driver.
Remove them and replace with a variables "SDHCI_COMPATIBLE_SDHCI_89A"
and "SDHCI_COMPATIBLE_VERSAL_NET_EMMC" with match data.
This change saves the space and reduce the execution time.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/mmc/zynq_sdhci.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index 28d2b456fb..24d0556cd3 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -105,6 +105,19 @@ struct arasan_sdhci_priv {
 	struct reset_ctl_bulk resets;
 };
 
+enum arasan_sdhci_compatible {
+	SDHCI_COMPATIBLE_SDHCI_89A,
+	SDHCI_COMPATIBLE_VERSAL_NET_EMMC,
+};
+
+static bool arasan_sdhci_is_compatible(struct udevice *dev,
+				       enum arasan_sdhci_compatible family)
+{
+	enum arasan_sdhci_compatible compat = dev_get_driver_data(dev);
+
+	return compat == family;
+}
+
 /* For Versal platforms zynqmp_mmio_write() won't be available */
 __weak int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value)
 {
@@ -422,7 +435,7 @@ static int arasan_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 
 	mdelay(1);
 
-	if (device_is_compatible(mmc->dev, "xlnx,zynqmp-8.9a"))
+	if (arasan_sdhci_is_compatible(mmc->dev, SDHCI_COMPATIBLE_SDHCI_89A))
 		arasan_zynqmp_dll_reset(host, priv->node_id);
 
 	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
@@ -470,7 +483,7 @@ static int arasan_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 
 	udelay(1);
 
-	if (device_is_compatible(mmc->dev, "xlnx,zynqmp-8.9a"))
+	if (arasan_sdhci_is_compatible(mmc->dev, SDHCI_COMPATIBLE_SDHCI_89A))
 		arasan_zynqmp_dll_reset(host, priv->node_id);
 
 	/* Enable only interrupts served by the SD controller */
@@ -858,7 +871,7 @@ static int arasan_sdhci_set_tapdelay(struct sdhci_host *host)
 	dev_dbg(dev, "%s, host:%s, mode:%d\n", __func__, host->name, timing);
 
 	if (IS_ENABLED(CONFIG_ARCH_ZYNQMP) &&
-	    device_is_compatible(dev, "xlnx,zynqmp-8.9a")) {
+	    arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_SDHCI_89A)) {
 		ret = sdhci_zynqmp_sampleclk_set_phase(host, iclk_phase);
 		if (ret)
 			return ret;
@@ -869,7 +882,7 @@ static int arasan_sdhci_set_tapdelay(struct sdhci_host *host)
 	} else if ((IS_ENABLED(CONFIG_ARCH_VERSAL) ||
 		    IS_ENABLED(CONFIG_ARCH_VERSAL_NET) ||
 		    IS_ENABLED(CONFIG_ARCH_VERSAL2)) &&
-		   device_is_compatible(dev, "xlnx,versal-8.9a")) {
+		   arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_SDHCI_89A)) {
 		ret = sdhci_versal_sampleclk_set_phase(host, iclk_phase);
 		if (ret)
 			return ret;
@@ -879,7 +892,7 @@ static int arasan_sdhci_set_tapdelay(struct sdhci_host *host)
 			return ret;
 	} else if ((IS_ENABLED(CONFIG_ARCH_VERSAL_NET) ||
 		    IS_ENABLED(CONFIG_ARCH_VERSAL2)) &&
-		   device_is_compatible(dev, "xlnx,versal-net-emmc")) {
+		   arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_VERSAL_NET_EMMC)) {
 		if (mmc->clock >= MIN_PHY_CLK_HZ)
 			if (iclk_phase == VERSAL_NET_EMMC_ICLK_PHASE_DDR52_DLY_CHAIN)
 				iclk_phase = VERSAL_NET_EMMC_ICLK_PHASE_DDR52_DLL;
@@ -933,7 +946,7 @@ static void arasan_dt_parse_clk_phases(struct udevice *dev)
 	int i;
 
 	if (IS_ENABLED(CONFIG_ARCH_ZYNQMP) &&
-	    device_is_compatible(dev, "xlnx,zynqmp-8.9a")) {
+	    arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_SDHCI_89A)) {
 		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
 			clk_data->clk_phase_in[i] = zynqmp_iclk_phases[i];
 			clk_data->clk_phase_out[i] = zynqmp_oclk_phases[i];
@@ -948,7 +961,7 @@ static void arasan_dt_parse_clk_phases(struct udevice *dev)
 	if ((IS_ENABLED(CONFIG_ARCH_VERSAL) ||
 	     IS_ENABLED(CONFIG_ARCH_VERSAL_NET) ||
 	     IS_ENABLED(CONFIG_ARCH_VERSAL2)) &&
-	    device_is_compatible(dev, "xlnx,versal-8.9a")) {
+	    arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_SDHCI_89A)) {
 		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
 			clk_data->clk_phase_in[i] = versal_iclk_phases[i];
 			clk_data->clk_phase_out[i] = versal_oclk_phases[i];
@@ -957,7 +970,7 @@ static void arasan_dt_parse_clk_phases(struct udevice *dev)
 
 	if ((IS_ENABLED(CONFIG_ARCH_VERSAL_NET) ||
 	     IS_ENABLED(CONFIG_ARCH_VERSAL2)) &&
-	    device_is_compatible(dev, "xlnx,versal-net-emmc")) {
+	    arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_VERSAL_NET_EMMC)) {
 		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
 			clk_data->clk_phase_in[i] = versal_net_emmc_iclk_phases[i];
 			clk_data->clk_phase_out[i] = versal_net_emmc_oclk_phases[i];
@@ -1101,7 +1114,7 @@ static int arasan_sdhci_probe(struct udevice *dev)
 	host = priv->host;
 
 #if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_ZYNQMP_FIRMWARE)
-	if (device_is_compatible(dev, "xlnx,zynqmp-8.9a")) {
+	if (arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_SDHCI_89A)) {
 		ret = zynqmp_pm_is_function_supported(PM_IOCTL,
 						      IOCTL_SET_SD_CONFIG);
 		if (!ret) {
@@ -1111,7 +1124,7 @@ static int arasan_sdhci_probe(struct udevice *dev)
 		}
 	}
 #endif
-	if (device_is_compatible(dev, "xlnx,versal-net-emmc"))
+	if (arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_VERSAL_NET_EMMC))
 		priv->internal_phy_reg = true;
 
 	ret = clk_get_by_index(dev, 0, &clk);
@@ -1145,7 +1158,7 @@ static int arasan_sdhci_probe(struct udevice *dev)
 		host->quirks |= SDHCI_QUIRK_NO_1_8_V;
 
 	if (CONFIG_IS_ENABLED(ARCH_VERSAL_NET) &&
-	    device_is_compatible(dev, "xlnx,versal-net-emmc"))
+	    arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_VERSAL_NET_EMMC))
 		host->quirks |= SDHCI_QUIRK_CAPS_BIT63_FOR_HS400;
 
 	plat->cfg.f_max = CONFIG_ZYNQ_SDHCI_MAX_FREQ;
@@ -1228,8 +1241,8 @@ static int arasan_sdhci_bind(struct udevice *dev)
 }
 
 static const struct udevice_id arasan_sdhci_ids[] = {
-	{ .compatible = "arasan,sdhci-8.9a" },
-	{ .compatible = "xlnx,versal-net-emmc" },
+	{ .compatible = "arasan,sdhci-8.9a", .data = SDHCI_COMPATIBLE_SDHCI_89A },
+	{ .compatible = "xlnx,versal-net-emmc", .data = SDHCI_COMPATIBLE_VERSAL_NET_EMMC },
 	{ }
 };
 
-- 
2.25.1

