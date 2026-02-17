Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15465E68165
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE5283CD3;
	Tue, 17 Feb 2026 12:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RSPDaXhg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1208483C72; Tue, 17 Feb 2026 12:22:17 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E52283CF2
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1nazLuKldg9H1MXTwJvt0HXtGJela1MaRC7rUJCAU5a2dC6yASpopb1LI58JfGXYnmLVuLjqYDKI9yzZpuzur/Vp8l6ZNxEIXg7iGufLZfYQluU+NQX6qlqaOpf6ybIupdmKJIi4LPvDDXfYZYDkUzJjU9lCmIL/vxdpsLpvRURYZ6y/jj/+3HmJGFh6n16QJoY2wsRJYM3OXjUmcXHOA0iQfxTy+pgvXRrrQZtsIuqkFiATdqFQxJxxWVo01S7aa+p0/3dzEmobn//xm5VAwUbhQmOi6/ObC5cBSQK9PL6JC+kd9kjrlOE8EVY0Sk6tV2nJ0HoeCJWK0ms9AUHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhJgB7eZ0Ye5TLImlPLW20Xr45hIpnqFPU0o7ndF7rU=;
 b=YXF08EToLUKcEiDsjNEYeZ35KCNDXapb6zdneOZEnEHg8N4iezfqf/Jk129adxegdiYkUDMTDVQdmQuv3vJjY4Iy8wJN7qk9R3H8MZ+xKRqx6+8UcBrJ80E2wS47o2NcDVKfpixmHUDA9mBpo6u6P29zT5W+BOVrKwFmAhFs+xjGiR0ZvONKnlJKKiKwBOHwcqoW10vBaDyoFtvJ1XUg9vyaewH8+grPefTn73NxRRjPOmur9avNvgYvy/+cpJoqZYFf4ayjkO1G1J626ZkiPa3Zx5TDe/tqggX/9XP2oDSRRCutGKrZZbdNwyMdgzWFHkzwRjQ+/34TgYNLIhLIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhJgB7eZ0Ye5TLImlPLW20Xr45hIpnqFPU0o7ndF7rU=;
 b=RSPDaXhgTLCRC8C01JY8H+H2xlkW758cpWiZp8z6/wdIfadogbQqf5gtNdaFjws5ZlvZb5IDxbl8Res6tDryiIYKtW+m+xOsK2GGGCV4ZlVlm3oicQ+f/6U0k/206pd3is626iTUtZprxEDYcLu35nqGYGIY4y7YP6LId7U9XEc=
Received: from PH8PR20CA0014.namprd20.prod.outlook.com (2603:10b6:510:23c::24)
 by DM6PR10MB4361.namprd10.prod.outlook.com (2603:10b6:5:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 11:22:08 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::2a) by PH8PR20CA0014.outlook.office365.com
 (2603:10b6:510:23c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Tue,
 17 Feb 2026 11:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 11:22:07 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:07 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:07 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 05:22:07 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.51.206] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61HBLutO3263329;
 Tue, 17 Feb 2026 05:22:04 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <jagan@amarulasolutions.com>, <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
 <gehariprasath@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 2/7] spl: mtd: Remove MTD device after loading images
Date: Tue, 17 Feb 2026 16:51:51 +0530
Message-ID: <20260217112156.272154-3-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217112156.272154-1-a-dutta@ti.com>
References: <20260217112156.272154-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DM6PR10MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: b955f866-f401-4ce1-c488-08de6e16c94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HrYXr4NhwprQNY8JeEO7chEKZlqzXrIfhwpvMvHxcOpIg4c3SOCGZu3KDmFy?=
 =?us-ascii?Q?pj0VrjS0nPtdLLEG6Aeq2LHHq+oBw69cpGPmHalyvz5EjGKm29TGRcjGU53x?=
 =?us-ascii?Q?1uIJL7NqQ4pF5FVvpMMuVq+T4dA+j2w5it4GvWsBCn4PCG/NrHFZa9IEFHC/?=
 =?us-ascii?Q?2NGUQi/FfdAu+G6pKh/r01UeOh5KGE8+8S/ioUJl6DxitD2HMBLWNm2e01TO?=
 =?us-ascii?Q?7Cj+ocurCNzPdJABUX3UREivYRS89DzVmH/Fdw4BtdO39Tmv6FFw5zNGDXNS?=
 =?us-ascii?Q?OXhN+X2v8QJxmEWJpPWPMUtenfIUmHvAlJNHah02NEi+quN5Ruj7HoAaCWjA?=
 =?us-ascii?Q?q18xlXkdzB/aJamXFuSwhdkuoTf6slWUDpx7PMQc1SMTwurDwC732eafia2Z?=
 =?us-ascii?Q?8DEfjq1hEf13MKVnc0OsdfRE5jlaeW1G2tJWIdaSjLwB71alwi6Wpvx7/yhk?=
 =?us-ascii?Q?720uPz6UMqNVLDoIRBIcltvNfoFCxEG6bfM7R0WWxSDADJvAOGTjfdkT13v8?=
 =?us-ascii?Q?lx7KxLAGwAqtG9ja2qJWk8MEqXjZRb6iOAHi1Xl2o784pUxlw3QXtQi9cTlg?=
 =?us-ascii?Q?Gc55+JwbEp4I8WjGC0pXvYh6kiUe8SFjLjxcu/bFkxCSK677F7vLsz+/Fd4w?=
 =?us-ascii?Q?W869sqvjCEyeELHTGVByUEnNRSBeTc0dsm3kSejHvOQwGiWT8Xmo3OM+VYS9?=
 =?us-ascii?Q?dnjAo0W/cxL5o5Z+k0iNyIxH/NAa8gMf35MJygMNAgp1grQzix3kD3Nnx9T6?=
 =?us-ascii?Q?hjENIHndCjEuKuZZGSkEFKEtjfz8kVrit33xuuJTH7JFnkTb8iOc6z0VhNI5?=
 =?us-ascii?Q?xsVZ4wEayEGQiyqhK5ba5O7QDLPwu/eS4esPKane6q903zGdimqES1YCogp4?=
 =?us-ascii?Q?gIOwr6vNhOgbDAwQ+6GuztjwcM3GhINesclanqjCzluYQHWaISroMVd/Nn9b?=
 =?us-ascii?Q?R19ijPsrSMmwyfGbPO6FKR+NLIj2v4EjNEf5D9PbczLtO0rNNlLQD48P9FHZ?=
 =?us-ascii?Q?CgJMDcx/UqhPd4RlS2zMsGqjW6toMklhhVXkyElQ449zm2Yy0YtMYwL7ivpv?=
 =?us-ascii?Q?RJH0cT103l4YH8U4VIyI4iJ1TEq7zJfi2Seaw2a16zpm/0RLCgCny1XEGx+6?=
 =?us-ascii?Q?k3imQG5jlPWKK/g5sYDhjDOgJQcn0pOtmJ5+YgWwguDfj/APUpWqNDgxOsv0?=
 =?us-ascii?Q?lYxrWuF9tP2nbgVYaP5y4WMru6KCjAmshcAJ28VfWhd7F+JN/hldLJtwBNNP?=
 =?us-ascii?Q?PpFYAMdHZw7ItIdtG8gD2aaCcom29qWmmDqRCcXqgyibvK6NtbIXzWCMfJ8W?=
 =?us-ascii?Q?x8p8RE9hr5/Fad2COi1QGqAzBc77n7oSPC/sv/8/u8GUYHaNb8FTS+8We2fS?=
 =?us-ascii?Q?CwJNoDkSE8cNrAJ+QUNbxQKipMis90yo1ITOSnNz9vsRftPEJzzbpF9AzidS?=
 =?us-ascii?Q?T7Rq8UpWId77eoZVksy/9XJuyU7OivXkP9DMq5qghVW3OgOyHuF2DnBlOBSp?=
 =?us-ascii?Q?8WEDhOvgW5yMO+Jlx4OlkIFwCTqVbkPDZjpeeYQ+8Y7v2ED4fcDeVp/HixtC?=
 =?us-ascii?Q?tYGxtOOSORJlh80mEJNUPbq6Qj/iIeEPp7dLTKie/pYqwaKSsCV8ZXyq1g/N?=
 =?us-ascii?Q?B3nMVyCH26zmlcTYWvZW5ylJl5nQIlbhmuZTE4iF0beF?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mRE5NIBB5+uu/EoWZEPLif8Lh4hT6dfRrfrGxP9xA3Y4mkN6SMJGKz070KPA41p2sjguNQfbkNGTlvTuNf4D43CV0jnaoHCbAFuhlijJlsY20AztPDJNMR+al+JL6JmSmN8FJqlHhDcq2lsh4vRJ51CEtb3twL5ZJKqMjraGvNMKIqp/sNcW839sshPuc1XlWGuSMj6veNSyf7wgk8K3E8MKu9oQkMQTWMxaRNT1sAY31VPYp1TeABWWAl67VmpX6eq/GVviRmxl+gM81EkRWfhnIo22iiq5CowSdggu+L5gS4DPUUqd/iEv1/tMB4mAaE83ho8EEYMCQ6gYyHNl9GEPQ8StfCdYpn9+sb++XlImOLc1vXISH/z142UJg6cx1PSy0HjgmjwV81TTSoXISnc1UiTeQ3YJ2N9fN6TsJ0TiEflAEMCnHN9dXEtWVTOK
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:22:07.8352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b955f866-f401-4ce1-c488-08de6e16c94f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4361
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

From: Apurva Nandan <a-nandan@ti.com>

Releasing the flash into proper state, after the loading completes,
is important for the next stage bootloader/kernel to be able to use
the MTD device. This would enable to reset the device for fresh
use by next boot stage.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 common/spl/spl_mtd.c        | 19 ++++++++++---------
 common/spl/spl_mtd_nand.c   | 10 +++++++---
 drivers/mtd/mtd-uclass.c    | 12 ++++++++++++
 drivers/mtd/nand/spi/core.c | 12 ++++++++----
 include/mtd.h               |  2 +-
 5 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/common/spl/spl_mtd.c b/common/spl/spl_mtd.c
index 341e1a73392..95c0c8ce8cd 100644
--- a/common/spl/spl_mtd.c
+++ b/common/spl/spl_mtd.c
@@ -62,7 +62,7 @@ int spl_mtd_load(struct spl_image_info *spl_image,
 	err = mtd_read(mtd, spl_mtd_get_uboot_offs(), sizeof(*header),
 		       &ret_len, (void *)header);
 	if (err)
-		return err;
+		goto out_err;
 
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
 	    image_get_magic(header) == FDT_MAGIC) {
@@ -70,21 +70,22 @@ int spl_mtd_load(struct spl_image_info *spl_image,
 		load.priv = mtd;
 		load.bl_len = 1;
 		load.read = spl_mtd_fit_read;
-		return spl_load_simple_fit(spl_image, &load,
-					   spl_mtd_get_uboot_offs(), header);
+		err = spl_load_simple_fit(spl_image, &load,
+					  spl_mtd_get_uboot_offs(), header);
 	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
 		load.priv = mtd;
 		load.bl_len = 1;
 		load.read = spl_mtd_fit_read;
-		return spl_load_imx_container(spl_image, &load,
-					      spl_mtd_get_uboot_offs());
+		err = spl_load_imx_container(spl_image, &load,
+					     spl_mtd_get_uboot_offs());
 	} else {
 		err = spl_parse_image_header(spl_image, bootdev, header);
 		if (err)
-			return err;
-		return mtd_read(mtd, spl_mtd_get_uboot_offs(), spl_image->size,
-				&ret_len, (void *)(ulong)spl_image->load_addr);
+			goto out_err;
+		err = mtd_read(mtd, spl_mtd_get_uboot_offs(), spl_image->size,
+			       &ret_len, (void *)(ulong)spl_image->load_addr);
 	}
 
-	return -EINVAL;
+out_err:
+	return err;
 }
diff --git a/common/spl/spl_mtd_nand.c b/common/spl/spl_mtd_nand.c
index 9bc6ff86ee8..2eb7458e599 100644
--- a/common/spl/spl_mtd_nand.c
+++ b/common/spl/spl_mtd_nand.c
@@ -16,16 +16,20 @@ static int spl_mtd_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
 	struct mtd_info *mtd;
-	int ret;
+	int err;
 
 	mtd = spl_prepare_mtd(BOOT_DEVICE_SPINAND);
 	if (IS_ERR_OR_NULL(mtd)) {
 		printf("MTD device %s not found, ret %ld\n", "spi-nand",
 		       PTR_ERR(mtd));
-		return -EINVAL;
+		err = PTR_ERR(mtd);
+		goto remove_mtd_device;
 	}
 
-	return spl_mtd_load(spl_image, mtd, bootdev);
+	err = spl_mtd_load(spl_image, mtd, bootdev);
+remove_mtd_device:
+	mtd_remove(mtd);
+	return err;
 }
 
 SPL_LOAD_IMAGE_METHOD("SPINAND", 0, BOOT_DEVICE_SPINAND, spl_mtd_load_image);
diff --git a/drivers/mtd/mtd-uclass.c b/drivers/mtd/mtd-uclass.c
index 720bd824c4d..598eedae6a5 100644
--- a/drivers/mtd/mtd-uclass.c
+++ b/drivers/mtd/mtd-uclass.c
@@ -10,6 +10,18 @@
 #include <errno.h>
 #include <mtd.h>
 
+/**
+ * mtd_remove - Remove the device @dev
+ *
+ * @dev: U-Boot device to probe
+ *
+ * @return 0 on success, an error otherwise.
+ */
+int mtd_remove(struct mtd_info *mtd)
+{
+	return device_remove(mtd->dev, DM_REMOVE_NORMAL);
+}
+
 /*
  * Implement a MTD uclass which should include most flash drivers.
  * The uclass private is pointed to mtd_info.
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 14af4264612..9bd8cce58f2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1718,26 +1718,28 @@ err_spinand_cleanup:
 	return ret;
 }
 
-#ifndef __UBOOT__
 static int spinand_remove(struct udevice *slave)
 {
 	struct spinand_device *spinand;
 	struct mtd_info *mtd;
-	int ret;
+	int ret = 0;
 
-	spinand = spi_mem_get_drvdata(slave);
+	spinand = dev_get_priv(slave);
 	mtd = spinand_to_mtd(spinand);
 	free(mtd->name);
 
+#ifndef __UBOOT__
 	ret = mtd_device_unregister(mtd);
 	if (ret)
 		return ret;
 
+#endif
 	spinand_cleanup(spinand);
 
-	return 0;
+	return ret;
 }
 
+#ifndef __UBOOT__
 static const struct spi_device_id spinand_ids[] = {
 	{ .name = "spi-nand" },
 	{ /* sentinel */ },
@@ -1783,4 +1785,6 @@ U_BOOT_DRIVER(spinand) = {
 	.probe = spinand_probe,
 	.bind = spinand_bind,
 	.plat_auto = sizeof(struct spinand_plat),
+	.remove = spinand_remove,
+	.flags = DM_FLAG_OS_PREPARE,
 };
diff --git a/include/mtd.h b/include/mtd.h
index f9e5082446a..740f1bb76db 100644
--- a/include/mtd.h
+++ b/include/mtd.h
@@ -11,7 +11,7 @@
 #include <linux/mtd/mtd.h>
 
 int mtd_probe_devices(void);
-
+int mtd_remove(struct mtd_info *mtd);
 void board_mtdparts_default(const char **mtdids, const char **mtdparts);
 
 /* compute the max size for the string associated to a dev type */
-- 
2.34.1

