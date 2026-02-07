Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4148EE20A9
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 09:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C023C83A64;
	Sat,  7 Feb 2026 10:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bLHB5sNa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C800B83AA7; Sat,  7 Feb 2026 10:51:43 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 251A283642
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 10:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMG2hM+UergGs9t4WcuUmnd9fbJuvcDbn1dkOwcEnMuGo2yE9cncQbPmC7evWmrNxy259qHbGrHmHJAeSOmQBuwOREbcti6RY1IhUd8Fc5MMB9r79zQ8fIIGkOeWRsqZrROXv212I5WpEkibkzVNl1WAU+siomzQ1UPXuKxhogHOTQDioiZNUacy9Ht5YYC27axfZpK2P/ol0ZMFd5NVllpwP5RC7h5rXCijZA35f0PvRhHfzJmQcOTqlU4Kv7ojzkwI1DWDxE10XMP8CTMsoM3Yhv/VJYcr9k0nBGVt2vIY3JTlF+nDOgTk/JRC0pHhROu9xitO5qFAj4JvIF6ABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1pvDRBs0Y9NV1vmXt22+4ZzHwwrvUqZo1BSIRfPM3s=;
 b=o2Sy8TfJyvVdKjGRBcDCxzmT5aklehXJ0kmk2G8rkZgQekeezLYjGVeehI7GANdIOt8B+ccdv9EWce6DkquIGcu6U7Dt3c3M0o0E59ygeqbGiWU1swUjovTqvMBlOKXHju4GhYJz0JXN6WycNW7wXqbEfFZqATRLHp/hfa/6v/Vlj+dfg0Bcolc63oywOTHl/8AWE4Po9h2XFj3R7A2xipEsuOU3xyieopj7wtoBbiDYbxfgV4ZI42H0TGyJxqx8QVFYCgjUNATJHV/4TEj9MnbBDGTRp1qcgHtwIs0P1GnDKr3XcqlRcoMiV3uZFpXc/dL2AKFRpYCJvDW3PxZKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1pvDRBs0Y9NV1vmXt22+4ZzHwwrvUqZo1BSIRfPM3s=;
 b=bLHB5sNaNC6LXT8fG6y2Gp4KBUDwsV4Pxg7joiA76vByhY8+FXflcTA63ESIQqGir876Wa975LOXbmzgdSrlthT1aQYtGbGN1Wf1nFH27E8IsWHeZCdHI9Xo/9sRCTshDgD/gXrAws6T1JfEFLGafUGE3RNnlqXQradpx5JeEz8=
Received: from BN9PR03CA0712.namprd03.prod.outlook.com (2603:10b6:408:ef::27)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Sat, 7 Feb
 2026 09:51:37 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::83) by BN9PR03CA0712.outlook.office365.com
 (2603:10b6:408:ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.17 via Frontend Transport; Sat,
 7 Feb 2026 09:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sat, 7 Feb 2026 09:51:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 7 Feb
 2026 03:51:37 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 7 Feb
 2026 03:51:36 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sat, 7 Feb 2026 03:51:34 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] mtd: spi-nor: Add support for flash reset
Date: Sat, 7 Feb 2026 15:20:51 +0530
Message-ID: <20260207095121.407468-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0d8d12-3568-4d97-9990-08de662e7c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vl2kjZ+pCT/rl+cP7IZY6uaRJo3t+CN3uZT7T2cg//f1VEbShMevWtBIHM29?=
 =?us-ascii?Q?L9ilbp1BTXZmXMWU8k1G3Hsb+2jbHj/dUbe+87P9EFeiLNgbrWo+s58wNdR0?=
 =?us-ascii?Q?umB+xrW22KrTGgN17ENnc+hLxGYfwILADIAEidgM9fu3kPGrbtDzUalutwcF?=
 =?us-ascii?Q?IwBfCCXuXRj0xzwvNErhHpIlwFVcbmFSNTcTPI9iooRUEBfyX0QKbnWu/xxe?=
 =?us-ascii?Q?TYJuFnc8hP2kWmunpVpn5jBxIUGOxBhdx1bYATamxnHgl/xqOi2qTew4/EVF?=
 =?us-ascii?Q?H+PYKVoWZl5JiFDFqRCYx1Feut7DGYzMoZaZG5Y676qbMYeByeFmI8vOSDIk?=
 =?us-ascii?Q?lhSdiz0bj/NjFU5Pd5jlR78/mcw+oxUZl+e0nX6D+W7VCvhX5FvSzksFAFcO?=
 =?us-ascii?Q?TuTRmy4jcoPwuX4JnL4JlgVL3H79yeswvNmRESQRmAQaVyoz6hPd8REnbzPb?=
 =?us-ascii?Q?RvhjH0/PnmgKKdVWIZikV0+YAaIx3FG0slir3N0uGyxdQDQSls2teWwr2YOp?=
 =?us-ascii?Q?VYRAmVBPi/3EihJkctSsm8+SxwWoU2NDiMSkVt8hB+PQi6jtB7ZWd1/CFKWl?=
 =?us-ascii?Q?QWs8rDiGENghQylyDO3+VxVu/hs1+Au5+SiHSuawX/x+WtrlXwDQnbt8fsbq?=
 =?us-ascii?Q?jQ1h0Bk8s+EEhZM72yxmW4EfuK/9VsSb3relSsM6N7PmuJfAaHteyu6F4stp?=
 =?us-ascii?Q?weQwVuQqTOtr7XG6NHZ92Rs7peqetxOEaHpgsLdBG3v0q5TXS6D/xGiIx9AE?=
 =?us-ascii?Q?MuvIccRsH9w/lPNR0sBgRlNnoWR7HcFtjjfuOdkC0brOtV4zSTNGbQDyRYu4?=
 =?us-ascii?Q?V6Nf2Siy6TPgf2iFcMIB/E3+pAWnef2GjV/a/t/4O+M8sPeisrGM4/B1wl+F?=
 =?us-ascii?Q?otPsasbLJctb1Q6QDpCT+FgLXyF+zwvRiw18JFGYqptDrEb3E2vtXwdL5n4C?=
 =?us-ascii?Q?XaNGcMwwOdA9NGAzhO/55B3/2UTPvAtXkFizQefly7qxTYH4TJW17FakhzVT?=
 =?us-ascii?Q?P9jAo51BdJ4t0l8wFAAibKWikgyjFW98okP63nlUajrYcm22lvFBxNKWGRRO?=
 =?us-ascii?Q?N32KSmQvYsCjel/PelyFkhKxTnYpURjpMYoMRG1tcsBDoe4axEb+QFGxvLwu?=
 =?us-ascii?Q?hjYTHA+WEEXG6R/jqmoXRCMjltvtnpRfcH2WvuORVYqnRbXdtU2DLhqkl7SI?=
 =?us-ascii?Q?ENS1PfpOJsGyq5fR939MfR3MDsgh7PjdooCa8sDq3vieX8KAzh1kawHO8wST?=
 =?us-ascii?Q?7V6QgWX2prVMIhzXndRral67kf2uOsHHqmvRN+MhowVl24E4br3zccRJEi0M?=
 =?us-ascii?Q?eg07lXKBeoRAbE8rzk3xqqvDeIXaWFCNBdBy3nHs8RPqlG6FKFrh3lip9xsq?=
 =?us-ascii?Q?PqtieDKxDJLw6eBQ56fzH9usST3s6hcyPT/UltbBGKJqLMbMsSUDUzAi/mRz?=
 =?us-ascii?Q?it9mPFHKMO/WQuYFJgQhYE19KjluiePeeEvyTQmnHtLEK9oWN3aHAi0Wpyfk?=
 =?us-ascii?Q?AQd8W8xn2is7sqQHe3jRQ+yfdcAHNvDAY5vSRjywVDS+rwkd62ro3fFAa2kO?=
 =?us-ascii?Q?kteE/GeeY2c27Q03tlbawP1D6PyTio1jREzbriWIFLf32TT/hPCvC3RmpMtA?=
 =?us-ascii?Q?sdG4c41w7/8r+o0tSj9Mweoh1s0Cnrucs9GIzYB5vCIJxls9XXmI46r1Leui?=
 =?us-ascii?Q?o1PrIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xs8o8Fqfi1OtOaGxoZKiFpiMcSYDCE1kw/esHN0jhVaYLCWQnCU3XBJYCr8oK01c5BCMNMgH2zFdJTymK6PtoRmW633JBr+heuwVYSz/1C0rZ1nUGiNeJQRpwql2dPPlZxCiBD33Viwv1d/gqZnwX4VimFOGpzHMl9+6wGvWTLQCm3ozyhM58lOznFPesP93fO8bmHfv/hezksJE1SDdWvqYGuXJ7C7Iec0Ldf5zcK0gDNIOHZvO/O4SE+9D9CtpGgn/lJcRBdt+qhZVx84UVBbauhvkEqLGZdd6n2dKLRBbH2TcSVOvdkQD1CknAKu0H/StxUnCOyHWen8qkUqLFZFUi10YvjvVUxpP6O4mFkpirIu7+86fGjJFbqX6FTjsZY+RB6bqcJiNMlK/AwMaRv90J87UMQC0uqPOEnr3JmQOZSigZF0RXgMZpQa00Rli
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 09:51:37.3333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0d8d12-3568-4d97-9990-08de662e7c56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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

Add support for spi-nor flash reset via GPIO controller
by reading the reset-gpios property.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 40 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |  1 +
 2 files changed, 41 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 76c33b24368..0c132a39190 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4466,6 +4466,40 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif /* SPI_FLASH_MACRONIX */
 }
 
+static int spi_nor_hw_reset(struct spi_nor *nor)
+{
+#if CONFIG_IS_ENABLED(DM_GPIO)
+	struct udevice *dev = nor->spi->dev;
+	int rc;
+
+	nor->flash_gpio_reset = devm_gpiod_get_optional(dev, "reset",
+							GPIOD_IS_OUT |
+							GPIOD_ACTIVE_LOW);
+
+	if (nor->flash_gpio_reset) {
+		/*
+		 * Experimental delay values by looking at different flash device
+		 * vendors datasheets.
+		 */
+		udelay(5);
+
+		/* Toggle gpio to reset the flash device. */
+		rc = dm_gpio_set_value(nor->flash_gpio_reset, 1);
+		if (rc)
+			return rc;
+
+		udelay(150);
+
+		rc = dm_gpio_set_value(nor->flash_gpio_reset, 0);
+		if (rc)
+			return rc;
+
+		udelay(1200);
+	}
+#endif
+	return 0;
+}
+
 int spi_nor_scan(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter params;
@@ -4491,6 +4525,12 @@ int spi_nor_scan(struct spi_nor *nor)
 
 	nor->setup = spi_nor_default_setup;
 
+	if (CONFIG_IS_ENABLED(DM_GPIO)) {
+		ret = spi_nor_hw_reset(nor);
+		if (ret)
+			return ret;
+	}
+
 #ifdef CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT
 	/*
 	 * When the flash is handed to us in a stateful mode like 8D-8D-8D, it
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4eef4ab0488..8017d0dd9db 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -583,6 +583,7 @@ struct spi_nor {
 	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
 	enum spi_nor_cmd_ext	cmd_ext_type;
 	struct spi_nor_fixups	*fixups;
+	struct gpio_desc	*flash_gpio_reset;
 
 	int (*setup)(struct spi_nor *nor, const struct flash_info *info,
 		     const struct spi_nor_flash_parameter *params);
-- 
2.34.1

