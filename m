Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E167C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2020A87F02;
	Mon, 11 Mar 2024 18:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j8L0bNaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50F7A87E6F; Mon, 11 Mar 2024 18:23:10 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3C1F8786A
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9Vx1M5ErM9Aql8rntwefZ8MPbBccSfRw8FntFF/5ijz+N+tytF7c2VOLlYuIWCKRPCRyYR1Lr7N7T0yRQLqs86vqMLYXRd26qP5gLmb4D30vmPvqr4cFcB1BlCdY9GGziyHAkoruM4ErXb5W9uhm9+Kvo9fbHDs2eWMWMbgRAg68NzhC48JjomYnKTnqpOEjuwvHpuAOFpq/ORY97VSkRZ/hzmKuN+1gcGmWiMOSbEJ7JCiLrssXXI9LFn50HWWDu5QjpJTypoDekwVKLdU1g8HfNk1R0yhj3pVEkz6R4djZ9wcQUjZs0utCkaD69WotUcRkriW3POQQcfhkj4UzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmOuvWlFz0PIQ5weOcXWn8nnfIJAKC5Za9kg37cPcAQ=;
 b=kNN2huDdSuLQPsp9/EB/wXv4Sa+RJkptuffd3rhrSpkz6K8ExCyobA9foH07FTmI6Ld9NDdWzZUjiQmafLV4Io+W9p0UbqWxd8InzjUfbeWjTappigQ4b9LcAU45Xp/F7PoF0/+OuM/JXU1fpf50hAnZQCUIPFQ3ObdXmf6xe6s5uhctU5+IcKeIhTznz+hKYsjHRXZYvLyIgnZiAXA+Jsnrus49Qlg6UArWFJW7hFDh9RNcbhEG+BmttlCVAcIIUuMDQTMK2v/csWgcQcdJlu3IgBgftkWUEb1WgwIUqcvKijFg++vA1zekA74QNTRb2dO4zU79ALb7qwO4Z/VZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmOuvWlFz0PIQ5weOcXWn8nnfIJAKC5Za9kg37cPcAQ=;
 b=j8L0bNaABXaKNbil/n3gy+1Qjzywpf8DoS50Wa1IMccGvHFuVyFl93pc1MCPiPmUZKSpioEgDUlAIRFAjg8/KkMomCAv5wpcweUNIKtI1xg4DGQ1V7xtZlEXxWHqGMe4Q3qqUK7oTG/c6DgrZKVA1Vg2qb3jpicMdXsl6d7ml/s=
Received: from CH0PR03CA0294.namprd03.prod.outlook.com (2603:10b6:610:e6::29)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:02 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::4) by CH0PR03CA0294.outlook.office365.com
 (2603:10b6:610:e6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:00 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:22:58 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>, T Karthik Reddy
 <t.karthik.reddy@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH 01/19] spi: cadence_qspi: Add support for DDR PHY mode
Date: Mon, 11 Mar 2024 22:52:31 +0530
Message-ID: <fc520c7b6ed4d84e28e2eb807f2e57b1847d3c93.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: tejas.arvind.bhumkar@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 433b76f7-4889-44ec-9fbb-08dc41efe803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCK5bj/HV/cKTikebgMmGXcXEpO1A9nKRDMVqdjY57cKuEU5DC58EV21CCXwVu8oa43PxB6jVVo1pNuqf2X5jzhQRLFJtFhwD2DeT7ivYew0MS06qo0t1vw9oddVOVTD1CuFN3Hs8ruQYIZAMbg8BE/KB7iUQhNQQ8YQsN31/l/0HYpq37W70dMiPsGTuyGKVlhnQdWQ1CdALRsHn2uoCWC3B8qFYpYJ2ilA51nr6upMY5NLykM/K6oezvCIGJzFEntqDTsC5VKSvokEY9FMwDadRsHeglDxhPuDjW54pEOoSYmoM6Uh7FB45npBUMOW5gvIZRzUt5ETtTnm1r8FX7aoDYzVz0MqWvWBDOnFzzW2qLIaXFNP4mDNchznUvJAuKbWyYgp6oCaoop4kSpyIm7X3QHhGXPCKD7vHaUyQpMXe6NgQ8TRRKAnZ1KR3+M52AKnyBOKEV5bCQW77vFFYb9U2i3Ak69HkQ7LHNB5UcHUJi86cS6qZxiIzkiekJxacT3saCoum49WkZCsXn8spYnm4oBq2PII+1FX2o/CPOUZQOMCmyaKh2PD0K/ytkWYdLAnmBMB+M8FTOf8oDnj8h6Ohm58Z+p7pdvScGU8wz7PmtooG0CxRghnzzlNyFTWSwCNdNh2Rw2Sk1KMnU33iVzmaDCkMLbsTVZCp+t4ZTI1nLEtaVbSHWN2+EoO7DOVph3/9WwP8ChnN21I0bl2Pw8DLxiefoejBdIkl/P9bLl33bDlBT5dAHVW2/1AE2hq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:02.4683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433b76f7-4889-44ec-9fbb-08dc41efe803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
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

From: T Karthik Reddy <t.karthik.reddy@xilinx.com>

Support has been added for DDR PHY mode in both DLL bypass
mode and master DLL mode.

To switch the OSPI controller from SDR to DDR mode, Rx DLL
tuning involves adjusting the TX delay, incrementing the
RX delay, and verifying correct flash IDs by reading from
the flash.

Moreover, support has been extended to enable DDR mode for
Micron flash. In the spi_nor_micron_octal_dtr_enable function,
the cmd->buf is utilized to read the flash ID during
RX DLL tuning.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Co-developed-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c    |  50 +++--
 drivers/spi/cadence_ospi_versal.c |  25 +++
 drivers/spi/cadence_qspi.c        | 300 ++++++++++++++++++++++++++++++
 drivers/spi/cadence_qspi.h        |  50 +++++
 drivers/spi/cadence_qspi_apb.c    |  33 +++-
 include/spi.h                     |   3 +
 6 files changed, 436 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index faf02c7778..5895b5de09 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1511,8 +1511,10 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 	info = spi_nor_ids;
 	for (; info->name; info++) {
 		if (info->id_len) {
-			if (!memcmp(info->id, id, info->id_len))
+			if ((!memcmp(info->id, id, info->id_len)) &&
+			    memcpy(nor->spi->device_id, id, SPI_NOR_MAX_ID_LEN)) {
 				return info;
+			}
 		}
 	}
 
@@ -3944,7 +3946,7 @@ static struct spi_nor_fixups s28hx_t_fixups = {
 static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor)
 {
 	struct spi_mem_op op;
-	u8 buf;
+	u8 *buf = nor->cmd_buf;
 	u8 addr_width = 3;
 	int ret;
 
@@ -3953,12 +3955,12 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
-	buf = 20;
+	*buf = 20;
 	op = (struct spi_mem_op)
 		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
 			   SPI_MEM_OP_ADDR(addr_width, SPINOR_REG_MT_CFR1V, 1),
 			   SPI_MEM_OP_NO_DUMMY,
-			   SPI_MEM_OP_DATA_OUT(1, &buf, 1));
+			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
 	ret = spi_mem_exec_op(nor->spi, &op);
 	if (ret)
 		return ret;
@@ -3973,18 +3975,33 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
-	buf = SPINOR_MT_OCT_DTR;
+	*buf = SPINOR_MT_OCT_DTR;
 	op = (struct spi_mem_op)
 		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
 			   SPI_MEM_OP_ADDR(addr_width, SPINOR_REG_MT_CFR0V, 1),
 			   SPI_MEM_OP_NO_DUMMY,
-			   SPI_MEM_OP_DATA_OUT(1, &buf, 1));
+			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
 	ret = spi_mem_exec_op(nor->spi, &op);
 	if (ret) {
 		dev_err(nor->dev, "Failed to enable octal DTR mode\n");
 		return ret;
 	}
 
+	/* Read flash ID to make sure the switch was successful. */
+	op = (struct spi_mem_op)
+	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 0),
+		   SPI_MEM_OP_ADDR(0, 0, 0),
+		   SPI_MEM_OP_DUMMY(8, 0),
+		   SPI_MEM_OP_DATA_IN(SPI_NOR_MAX_ID_LEN, buf, 0));
+
+	spi_nor_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+
+	ret = spi_mem_exec_op(nor->spi, &op);
+	if (ret)
+		return ret;
+
+	nor->reg_proto = SNOR_PROTO_8_8_8_DTR;
+
 	return 0;
 }
 
@@ -3996,18 +4013,19 @@ static void mt35xu512aba_default_init(struct spi_nor *nor)
 static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor,
 					 struct spi_nor_flash_parameter *params)
 {
-	/* Set the Fast Read settings. */
-	params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
-	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
-				  0, 20, SPINOR_OP_MT_DTR_RD,
-				  SNOR_PROTO_8_8_8_DTR);
-
-	params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;
+	if (params->hwcaps.mask & SNOR_HWCAPS_READ_8_8_8_DTR) {
+		/* Set the Fast Read settings. */
+		params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
+		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
+					  0, 20, SPINOR_OP_MT_DTR_RD,
+					  SNOR_PROTO_8_8_8_DTR);
 
-	nor->cmd_ext_type = SPI_NOR_EXT_REPEAT;
-	params->rdsr_dummy = 8;
-	params->rdsr_addr_nbytes = 0;
+		params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;
 
+		nor->cmd_ext_type = SPI_NOR_EXT_REPEAT;
+		params->rdsr_dummy = 8;
+		params->rdsr_addr_nbytes = 0;
+	}
 	/*
 	 * The BFPT quad enable field is set to a reserved value so the quad
 	 * enable function is ignored by spi_nor_parse_bfpt(). Make sure we
diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index c2be307f1d..70682490e6 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -15,6 +15,7 @@
 #include <cpu_func.h>
 #include <zynqmp_firmware.h>
 #include <asm/arch/hardware.h>
+#include <soc.h>
 #include "cadence_qspi.h"
 #include <dt-bindings/power/xlnx-versal-power.h>
 
@@ -126,6 +127,30 @@ int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv)
 	return 0;
 }
 
+static const struct soc_attr matches[] = {
+	{ .family = "Versal", .revision = "v2" },
+	{ }
+};
+
+/*
+ * cadence_qspi_versal_set_dll_mode checks for silicon version
+ * and set the DLL mode.
+ * Returns 0 in case of success, -ENOTSUPP in case of failure.
+ */
+int cadence_qspi_versal_set_dll_mode(struct udevice *dev)
+{
+	struct cadence_spi_priv *priv = dev_get_priv(dev);
+	const struct soc_attr *attr;
+
+	attr = soc_device_match(matches);
+	if (attr) {
+		priv->dll_mode = CQSPI_DLL_MODE_MASTER;
+		return 0;
+	}
+
+	return -ENOTSUPP;
+}
+
 #if defined(CONFIG_DM_GPIO)
 int cadence_qspi_versal_flash_reset(struct udevice *dev)
 {
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index f4593c47b8..0a1257352a 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -194,6 +194,20 @@ static int cadence_spi_set_speed(struct udevice *bus, uint hz)
 	return 0;
 }
 
+static int cadence_spi_child_pre_probe(struct udevice *bus)
+{
+	struct spi_slave *slave = dev_get_parent_priv(bus);
+
+	slave->bytemode = SPI_4BYTE_MODE;
+
+	return 0;
+}
+
+__weak int cadence_qspi_versal_set_dll_mode(struct udevice *dev)
+{
+	return -ENOTSUPP;
+}
+
 static int cadence_spi_probe(struct udevice *bus)
 {
 	struct cadence_spi_plat *plat = dev_get_plat(bus);
@@ -250,6 +264,14 @@ static int cadence_spi_probe(struct udevice *bus)
 		priv->qspi_is_init = 1;
 	}
 
+	priv->edge_mode = CQSPI_EDGE_MODE_SDR;
+	priv->dll_mode = CQSPI_DLL_MODE_BYPASS;
+
+	/* Select dll mode */
+	ret = cadence_qspi_versal_set_dll_mode(bus);
+	if (ret == -ENOTSUPP)
+		debug("DLL mode set to bypass mode : %x\n", ret);
+
 	priv->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC, priv->ref_clk_hz);
 
 	/* Versal and Versal-NET use spi calibration to set read delay */
@@ -293,6 +315,280 @@ static int cadence_spi_set_mode(struct udevice *bus, uint mode)
 	return 0;
 }
 
+static int cadence_qspi_rx_dll_tuning(struct spi_slave *spi, const struct spi_mem_op *op,
+				      u32 txtap, u8 extra_dummy)
+{
+	struct udevice *bus = spi->dev->parent;
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	void *regbase = priv->regbase;
+	int ret, i, j;
+	u8 *id = op->data.buf.in;
+	u8 min_rxtap = 0, max_rxtap = 0, avg_rxtap,
+	max_tap, windowsize, dummy_flag = 0, max_index = 0, min_index = 0;
+	unsigned int reg;
+	s8 max_windowsize = -1;
+	bool id_matched, rxtapfound = false;
+
+	/* Return if octal-spi disabled */
+	reg = readl(regbase + CQSPI_REG_CONFIG);
+	reg &= CQSPI_REG_CONFIG_ENABLE;
+	if (!reg)
+		return 0;
+
+	max_tap = CQSPI_MAX_DLL_TAPS;
+	/*
+	 * Rx dll tuning is done by setting tx delay and increment rx
+	 * delay and check for correct flash id's by reading from flash.
+	 */
+	for (i = 0; i <= max_tap; i++) {
+		/* Set DLL reset bit */
+		writel((txtap | i | CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK),
+		       regbase + CQSPI_REG_PHY_CONFIG);
+		/*
+		 * Re-synchronisation delay lines to update them
+		 * with values from TX DLL Delay and RX DLL Delay fields
+		 */
+		writel((CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK | txtap | i |
+		       CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK),
+		       regbase + CQSPI_REG_PHY_CONFIG);
+		/* Check lock of loopback */
+		if (priv->dll_mode == CQSPI_DLL_MODE_MASTER) {
+			ret = wait_for_bit_le32
+				(regbase + CQSPI_REG_DLL_LOWER,
+				 CQSPI_REG_DLL_LOWER_LPBK_LOCK_MASK, 1,
+				 CQSPI_TIMEOUT_MS, 0);
+			if (ret) {
+				printf("LOWER_DLL_LOCK bit err: %i\n", ret);
+				return ret;
+			}
+		}
+
+		ret = cadence_qspi_apb_command_read_setup(priv, op);
+		if (!ret) {
+			ret = cadence_qspi_apb_command_read(priv, op);
+			if (ret < 0) {
+				printf("error %d reading JEDEC ID\n", ret);
+				return ret;
+			}
+		}
+
+		id_matched = true;
+		for (j = 0; j < op->data.nbytes; j++) {
+			if (spi->device_id[j] != id[j]) {
+				id_matched = false;
+				break;
+			}
+		}
+
+		if (id_matched && !rxtapfound) {
+			if (priv->dll_mode == CQSPI_DLL_MODE_MASTER) {
+				min_rxtap =
+				readl(regbase + CQSPI_REG_DLL_OBSVBLE_UPPER) &
+				      CQSPI_REG_DLL_UPPER_RX_FLD_MASK;
+				max_rxtap = min_rxtap;
+				max_index = i;
+				min_index = i;
+			} else {
+				min_rxtap = i;
+				max_rxtap = i;
+			}
+			rxtapfound = true;
+		}
+
+		if (id_matched && rxtapfound) {
+			if (priv->dll_mode == CQSPI_DLL_MODE_MASTER) {
+				max_rxtap =
+					readl(regbase +
+					      CQSPI_REG_DLL_OBSVBLE_UPPER) &
+					      CQSPI_REG_DLL_UPPER_RX_FLD_MASK;
+				max_index = i;
+			} else {
+				max_rxtap = i;
+			}
+		}
+
+		if ((!id_matched || i == max_tap) && rxtapfound) {
+			windowsize = max_rxtap - min_rxtap + 1;
+			if (windowsize > max_windowsize) {
+				dummy_flag = extra_dummy;
+				max_windowsize = windowsize;
+				if (priv->dll_mode == CQSPI_DLL_MODE_MASTER)
+					avg_rxtap = (max_index + min_index);
+				else
+					avg_rxtap = (max_rxtap + min_rxtap);
+				avg_rxtap /= 2;
+			}
+
+			if (windowsize >= 3)
+				i = max_tap;
+
+			rxtapfound = false;
+		}
+	}
+
+	if (!extra_dummy) {
+		rxtapfound = false;
+		min_rxtap = 0;
+		max_rxtap = 0;
+	}
+
+	if (!dummy_flag)
+		priv->extra_dummy = false;
+
+	if (max_windowsize < 3)
+		return -EINVAL;
+
+	return avg_rxtap;
+}
+
+static int cadence_spi_setdlldelay(struct spi_slave *spi, const struct spi_mem_op *op)
+{
+	struct udevice *bus = spi->dev->parent;
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	void *regbase = priv->regbase;
+	u32 txtap;
+	int ret, rxtap;
+	u8 extra_dummy;
+
+	ret = wait_for_bit_le32(regbase + CQSPI_REG_CONFIG,
+				1 << CQSPI_REG_CONFIG_IDLE_LSB,
+				1, CQSPI_TIMEOUT_MS, 0);
+	if (ret) {
+		printf("spi_wait_idle error : 0x%x\n", ret);
+		return ret;
+	}
+
+	if (priv->dll_mode == CQSPI_DLL_MODE_MASTER) {
+		/* Drive DLL reset bit to low */
+		writel(0, regbase + CQSPI_REG_PHY_CONFIG);
+
+		/* Set initial delay value */
+		writel(CQSPI_REG_PHY_INITIAL_DLY,
+		       regbase + CQSPI_REG_PHY_MASTER_CTRL);
+		/* Set DLL reset bit */
+		writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK,
+		       regbase + CQSPI_REG_PHY_CONFIG);
+
+		/* Check for loopback lock */
+		ret = wait_for_bit_le32(regbase + CQSPI_REG_DLL_LOWER,
+					CQSPI_REG_DLL_LOWER_LPBK_LOCK_MASK,
+					1, CQSPI_TIMEOUT_MS, 0);
+		if (ret) {
+			printf("Loopback lock bit error (%i)\n", ret);
+			return ret;
+		}
+
+		/* Re-synchronize slave DLLs */
+		writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK,
+		       regbase + CQSPI_REG_PHY_CONFIG);
+		writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK |
+		       CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK,
+		       regbase + CQSPI_REG_PHY_CONFIG);
+
+		txtap = CQSPI_TX_TAP_MASTER <<
+			CQSPI_REG_PHY_CONFIG_TX_DLL_DLY_LSB;
+	}
+
+	priv->extra_dummy = false;
+	for (extra_dummy = 0; extra_dummy <= 1; extra_dummy++) {
+		if (extra_dummy)
+			priv->extra_dummy = true;
+
+		rxtap = cadence_qspi_rx_dll_tuning(spi, op, txtap, extra_dummy);
+		if (extra_dummy && rxtap < 0) {
+			printf("Failed RX dll tuning\n");
+			return rxtap;
+		}
+	}
+	debug("RXTAP: %d\n", rxtap);
+
+	writel((txtap | rxtap | CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK),
+	       regbase + CQSPI_REG_PHY_CONFIG);
+	writel((CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK | txtap | rxtap |
+	       CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK),
+	       regbase + CQSPI_REG_PHY_CONFIG);
+
+	if (priv->dll_mode == CQSPI_DLL_MODE_MASTER) {
+		ret = wait_for_bit_le32(regbase + CQSPI_REG_DLL_LOWER,
+					CQSPI_REG_DLL_LOWER_LPBK_LOCK_MASK,
+					1, CQSPI_TIMEOUT_MS, 0);
+		if (ret) {
+			printf("LOWER_DLL_LOCK bit err: %i\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int priv_setup_ddrmode(struct udevice *bus)
+{
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	void *regbase = priv->regbase;
+	int ret;
+
+	ret = wait_for_bit_le32(regbase + CQSPI_REG_CONFIG,
+				1 << CQSPI_REG_CONFIG_IDLE_LSB,
+				1, CQSPI_TIMEOUT_MS, 0);
+	if (ret) {
+		printf("spi_wait_idle error : 0x%x\n", ret);
+		return ret;
+	}
+
+	/* Disable QSPI */
+	cadence_qspi_apb_controller_disable(regbase);
+
+	/* Disable DAC mode */
+	if (priv->use_dac_mode) {
+		clrbits_le32(regbase + CQSPI_REG_CONFIG,
+			     CQSPI_REG_CONFIG_DIRECT);
+		priv->use_dac_mode = false;
+	}
+
+	setbits_le32(regbase + CQSPI_REG_CONFIG,
+		     CQSPI_REG_CONFIG_PHY_ENABLE_MASK);
+
+	/* Program POLL_CNT */
+	clrsetbits_le32(regbase + CQSPI_REG_WRCOMPLETION,
+			CQSPI_REG_WRCOMPLETION_POLLCNT_MASK,
+			CQSPI_REG_WRCOMPLETION_POLLCNT <<
+			CQSPI_REG_WRCOMPLETION_POLLCNY_LSB);
+
+	setbits_le32(regbase + CQSPI_REG_CONFIG,
+		     CQSPI_REG_CONFIG_DTR_PROT_EN_MASK);
+
+	clrsetbits_le32(regbase + CQSPI_REG_RD_DATA_CAPTURE,
+			(CQSPI_REG_RD_DATA_CAPTURE_DELAY_MASK <<
+			 CQSPI_REG_RD_DATA_CAPTURE_DELAY_LSB),
+			CQSPI_REG_READCAPTURE_DQS_ENABLE);
+
+	/* Enable QSPI */
+	cadence_qspi_apb_controller_enable(regbase);
+
+	return 0;
+}
+
+static int cadence_spi_setup_ddrmode(struct spi_slave *spi, const struct spi_mem_op *op)
+{
+	struct udevice *bus = spi->dev->parent;
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	int ret;
+
+	ret = priv_setup_ddrmode(bus);
+	if (ret)
+		return ret;
+
+	priv->edge_mode = CQSPI_EDGE_MODE_DDR;
+	ret = cadence_spi_setdlldelay(spi, op);
+	if (ret) {
+		printf("DDR tuning failed with error %d\n", ret);
+		return ret;
+	}
+	priv->ddr_init = 1;
+
+	return 0;
+}
+
 static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 				   const struct spi_mem_op *op)
 {
@@ -353,6 +649,9 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 		break;
 	}
 
+	if (op->cmd.dtr)
+		err = cadence_spi_setup_ddrmode(spi, op);
+
 	return err;
 }
 
@@ -469,6 +768,7 @@ U_BOOT_DRIVER(cadence_spi) = {
 	.plat_auto	= sizeof(struct cadence_spi_plat),
 	.priv_auto	= sizeof(struct cadence_spi_priv),
 	.probe = cadence_spi_probe,
+	.child_pre_probe = cadence_spi_child_pre_probe,
 	.remove = cadence_spi_remove,
 	.flags = DM_FLAG_OS_PREPARE,
 };
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 693474a287..6d7e31da50 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -10,6 +10,7 @@
 #include <reset.h>
 #include <linux/mtd/spi-nor.h>
 #include <spi-mem.h>
+#include <wait_bit.h>
 
 #define CQSPI_IS_ADDR(cmd_len)		(cmd_len > 1 ? 1 : 0)
 
@@ -21,6 +22,8 @@
 #define CQSPI_REG_RETRY                         10000
 #define CQSPI_POLL_IDLE_RETRY                   3
 
+#define CQSPI_TIMEOUT_MS			1000
+
 /* Transfer mode */
 #define CQSPI_INST_TYPE_SINGLE                  0
 #define CQSPI_INST_TYPE_DUAL                    1
@@ -37,6 +40,22 @@
 #define CMD_4BYTE_OCTAL_READ			0x7c
 #define CMD_4BYTE_READ				0x13
 
+#define CQSPI_TX_TAP_MASTER			0x1E
+#define CQSPI_MAX_DLL_TAPS			127
+
+#define CQSPI_DLL_MODE_MASTER			0
+#define CQSPI_DLL_MODE_BYPASS			1
+
+#define CQSPI_EDGE_MODE_SDR			0
+#define CQSPI_EDGE_MODE_DDR			1
+
+#define SILICON_VER_MASK			0xFF
+#define SILICON_VER_1				0x10
+
+#define CQSPI_READ_ID				0x9F
+#define CQSPI_READID_LOOP_MAX			10
+#define TERA_MACRO				1000000000000l
+
 /****************************************************************************
  * Controller's configuration and status register (offset from QSPI_BASE)
  ****************************************************************************/
@@ -69,6 +88,7 @@
 #define CQSPI_REG_RD_INSTR_TYPE_ADDR_MASK       0x3
 #define CQSPI_REG_RD_INSTR_TYPE_DATA_MASK       0x3
 #define CQSPI_REG_RD_INSTR_DUMMY_MASK           0x1F
+#define CQSPI_REG_RD_INSTR_DDR_ENABLE		BIT(10)
 
 #define CQSPI_REG_WR_INSTR                      0x08
 #define CQSPI_REG_WR_INSTR_OPCODE_LSB           0
@@ -113,9 +133,14 @@
 
 #define CQSPI_REG_WR_COMPLETION_CTRL		0x38
 #define CQSPI_REG_WR_DISABLE_AUTO_POLL		BIT(14)
+#define CQSPI_REG_WRCOMPLETION			0x38
+#define CQSPI_REG_WRCOMPLETION_POLLCNT_MASK	0xFF0000
+#define CQSPI_REG_WRCOMPLETION_POLLCNY_LSB	16
+#define CQSPI_REG_WRCOMPLETION_POLLCNT		3
 
 #define CQSPI_REG_IRQSTATUS                     0x40
 #define CQSPI_REG_IRQMASK                       0x44
+#define CQSPI_REG_ECO				0x48
 
 #define CQSPI_REG_INDIRECTRD                    0x60
 #define CQSPI_REG_INDIRECTRD_START              BIT(0)
@@ -166,7 +191,31 @@
 #define CQSPI_REG_OP_EXT_STIG_LSB               0
 
 #define CQSPI_REG_PHY_CONFIG                    0xB4
+#define CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK	0x80000000
 #define CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK     0x40000000
+#define CQSPI_REG_PHY_CONFIG_TX_DLL_DLY_LSB	16
+
+#define CQSPI_REG_PHY_MASTER_CTRL              0xB8
+#define CQSPI_REG_PHY_INITIAL_DLY              0x4
+#define CQSPI_REG_DLL_LOWER                    0xBC
+#define CQSPI_REG_DLL_LOWER_LPBK_LOCK_MASK     0x8000
+#define CQSPI_REG_DLL_LOWER_DLL_LOCK_MASK      0x1
+
+#define CQSPI_REG_DLL_OBSVBLE_UPPER		0xC0
+#define CQSPI_REG_DLL_UPPER_RX_FLD_MASK		0x7F
+
+#define CQSPI_REG_EXT_OP_LOWER			0xE0
+#define CQSPI_REG_EXT_STIG_OP_MASK		0xFF
+#define CQSPI_REG_EXT_READ_OP_MASK		0xFF000000
+#define CQSPI_REG_EXT_READ_OP_SHIFT		24
+#define CQSPI_REG_EXT_WRITE_OP_MASK		0xFF0000
+#define CQSPI_REG_EXT_WRITE_OP_SHIFT		16
+#define CQSPI_REG_DMA_SRC_ADDR			0x1000
+#define CQSPI_REG_DMA_DST_ADDR			0x1800
+#define CQSPI_REG_DMA_DST_SIZE			0x1804
+#define CQSPI_REG_DMA_DST_STS			0x1808
+#define CQSPI_REG_DMA_DST_CTRL			0x180C
+#define CQSPI_REG_DMA_DST_CTRL_VAL		0xF43FFA00
 
 #define CQSPI_DMA_DST_ADDR_REG                  0x1800
 #define CQSPI_DMA_DST_SIZE_REG                  0x1804
@@ -309,6 +358,7 @@ int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv);
 int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
 int cadence_qspi_versal_flash_reset(struct udevice *dev);
 ofnode cadence_qspi_get_subnode(struct udevice *dev);
+int cadence_qspi_versal_set_dll_mode(struct udevice *dev);
 void cadence_qspi_apb_enable_linear_mode(bool enable);
 
 #endif /* __CADENCE_QSPI_H__ */
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index fb90532217..4404b0ba07 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -464,6 +464,9 @@ int cadence_qspi_apb_command_read(struct cadence_spi_priv *priv,
 	unsigned int dummy_clk;
 	u8 opcode;
 
+	if (priv->dtr)
+		rxlen = ((rxlen % 2) != 0) ? (rxlen + 1) : rxlen;
+
 	if (priv->dtr)
 		opcode = op->cmd.opcode >> 8;
 	else
@@ -479,6 +482,9 @@ int cadence_qspi_apb_command_read(struct cadence_spi_priv *priv,
 	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 		return -ENOTSUPP;
 
+	if (priv->extra_dummy)
+		dummy_clk++;
+
 	if (dummy_clk)
 		reg |= (dummy_clk & CQSPI_REG_CMDCTRL_DUMMY_MASK)
 		     << CQSPI_REG_CMDCTRL_DUMMY_LSB;
@@ -555,6 +561,9 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
 	void *reg_base = priv->regbase;
 	u8 opcode;
 
+	if (priv->dtr)
+		txlen = ((txlen % 2) != 0) ? (txlen + 1) : txlen;
+
 	if (priv->dtr)
 		opcode = op->cmd.opcode >> 8;
 	else
@@ -611,7 +620,6 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
 int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 				const struct spi_mem_op *op)
 {
-	unsigned int reg;
 	unsigned int rd_reg;
 	unsigned int dummy_clk;
 	unsigned int dummy_bytes = op->dummy.nbytes;
@@ -649,6 +657,9 @@ int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 		if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 			return -ENOTSUPP;
 
+		if (priv->extra_dummy)
+			dummy_clk++;
+
 		if (dummy_clk)
 			rd_reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
 				<< CQSPI_REG_RD_INSTR_DUMMY_LSB;
@@ -657,10 +668,10 @@ int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 	writel(rd_reg, priv->regbase + CQSPI_REG_RD_INSTR);
 
 	/* set device size */
-	reg = readl(priv->regbase + CQSPI_REG_SIZE);
-	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
-	reg |= (op->addr.nbytes - 1);
-	writel(reg, priv->regbase + CQSPI_REG_SIZE);
+	clrsetbits_le32(priv->regbase + CQSPI_REG_SIZE,
+			CQSPI_REG_SIZE_ADDRESS_MASK,
+			op->addr.nbytes - 1);
+
 	return 0;
 }
 
@@ -830,10 +841,10 @@ int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 		writel(reg, priv->regbase + CQSPI_REG_WR_COMPLETION_CTRL);
 	}
 
-	reg = readl(priv->regbase + CQSPI_REG_SIZE);
-	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
-	reg |= (op->addr.nbytes - 1);
-	writel(reg, priv->regbase + CQSPI_REG_SIZE);
+	clrsetbits_le32(priv->regbase + CQSPI_REG_SIZE,
+			CQSPI_REG_SIZE_ADDRESS_MASK,
+			op->addr.nbytes - 1);
+
 	return 0;
 }
 
@@ -848,6 +859,10 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 	unsigned int write_bytes;
 	int ret;
 
+	if (priv->edge_mode == CQSPI_EDGE_MODE_DDR && (n_tx % 2) != 0)
+		n_tx++;
+	remaining = n_tx;
+
 	/*
 	 * Use bounce buffer for non 32 bit aligned txbuf to avoid data
 	 * aborts
diff --git a/include/spi.h b/include/spi.h
index ee0f86fd3d..ab51c8428b 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -50,6 +50,8 @@
 /* Max no. of CS supported per spi device */
 #define SPI_CS_CNT_MAX	2
 
+#define SPI_MEM_DEV_MAX_ID_LEN 6
+
 /**
  * struct dm_spi_bus - SPI bus info
  *
@@ -157,6 +159,7 @@ struct spi_slave {
 	unsigned int bus;
 	unsigned int cs;
 #endif
+	u8 device_id[SPI_MEM_DEV_MAX_ID_LEN];
 	uint mode;
 	unsigned int wordlen;
 	unsigned int max_read_size;
-- 
2.27.0

