Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1A2E68165
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE90C80325;
	Tue, 17 Feb 2026 12:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l9A8mjPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E05080325; Tue, 17 Feb 2026 12:22:18 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5783483D17
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYYnBvRjPjVy3Vm3UsASnGjaZEla4Q/FrRYfe2E51KW8UFwsVaOzrd/oWk2qcVbzDngy6baznRM+xB2I1RET7+r37/+JFT2dJFkrw9M7A5zBASsfDLsINEOWj/gO/B6YCCdsk/B8oXlcW/Fi7S43NQmlv1i8mE42IVFhXSWTqhN/M6Zh1fxQD0Zf4ILI7oEjVnrZcEFnPkYcTPyIQZh6IPay/lCAR2hE8kdbPwH9ZbE71ek5236o3tv2hqgF4CNFDf6d8JFi+oG6EBXS1C8hS7GvY41VWxgJg6bfY7V57f0JZUHtN+KtBRuTBR4tNZN/6DmxsfjeHRk7Kz5pU4kA8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9urJW97ivqwiVol805kqZxd+IGpirmzaprwwmrvwyE=;
 b=xQoKx1yHbDoQrHWIa2zLrEVR/SHSEE6nSGPGmSTLdOhP+MjHFa3bjb3Z6YrM2XHIs/KUlR7qYFfg1oxf+SUCGV+uI0I84dfkU/gk1+fJtiZJq5VnTIhPxaeFOA8iS6PmHQUTJNGOnqiYzXa+o2xPm1oPi1m1GTHYDNbGVgtQRmiRRgJTCmd0XE99ZMkO8u7YVRcXacnhe/k9g2z+U4S2X+i7SVUqo2jsa0gIldxZ5rLbm/5t2B4BjKy3pGkDvldECczVe33V2+BIUgi94krSdSj6+KYlwysacPXjurSletUWKhRNVQvaM7SGpHMWka03b4RE1Lt0/ryLZUkxpclqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9urJW97ivqwiVol805kqZxd+IGpirmzaprwwmrvwyE=;
 b=l9A8mjPbyZ281vMuB4XCHBWw9b9DGpOlXE9M6MrOBNUiNJRfVw51QUx19PtYvxRq8iaRNAmOpyCgYMRAp74BX/V+xurDCymh10eaUZZRCX9+iSd6adrqquK6j3MdRiXcQYQpIYEsU8OlKSf5h9VjGPzrTp/hdPdykq9Lc/aJ0Lk=
Received: from DM6PR07CA0065.namprd07.prod.outlook.com (2603:10b6:5:74::42) by
 BN0PR10MB5190.namprd10.prod.outlook.com (2603:10b6:408:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 11:22:13 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::d8) by DM6PR07CA0065.outlook.office365.com
 (2603:10b6:5:74::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 11:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 11:22:11 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:10 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:10 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 05:22:10 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.51.206] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61HBLutP3263329;
 Tue, 17 Feb 2026 05:22:07 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <jagan@amarulasolutions.com>, <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
 <gehariprasath@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 3/7] spl: mtd: Add bad block handling for SPL image loading
Date: Tue, 17 Feb 2026 16:51:52 +0530
Message-ID: <20260217112156.272154-4-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217112156.272154-1-a-dutta@ti.com>
References: <20260217112156.272154-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|BN0PR10MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: 839cd944-e4aa-481d-4779-08de6e16cb9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MAdhvrQ40x88VmekuzAwNFj0sWoDMs+leKaMLFqd0xKUnet557l5MTxxGT9q?=
 =?us-ascii?Q?hXWr/cMNDOwc9lStuLO+ZAQKehe+qZJk3bnbt/qG9WP8BmOzOPvXUvM667fd?=
 =?us-ascii?Q?WGGN5a5baNKNWl7cqsj9t/7/28GqtjMggY2JNtwrrSkKslFvCZpgfgHlC1dX?=
 =?us-ascii?Q?8PwHaHRzwEXQ6BZyvewc4dULstisFVIjQpqu082vVwwF/0PQUHeVZJ9w57YL?=
 =?us-ascii?Q?Nzic/PPCWDqZ1vJd3nChHGBYgYWf8ykCCo0PJYZThgubo1ZtDLIIYmLBqX26?=
 =?us-ascii?Q?GOek8U7YSXQHnf2uj4iN250XKCuRq4DgizKD5WrF/cLX77PRtSmBRYZRlC5y?=
 =?us-ascii?Q?zlXmgL97Mk0F4Lo4l8ujbpde1mZhBZn/5pOJgI3pmZvzvn0/PNnAu5hiJ07x?=
 =?us-ascii?Q?zqVBddLYtAeXQ7ZciRpWfM7fTO7McDzW3rzk+Ew31VouSNs2YG2RgQOhfp7F?=
 =?us-ascii?Q?QkZ2QzxZv2iwjiF9Xw/G8aLV0IXfTEOXmqevAPjoPqzkwy++WkEqra8ZmgSl?=
 =?us-ascii?Q?9JtGrJInKcgMTMJjR7xLkLwOI3GRddYXZFQpim/YkULk54nFRq8kM0zks6k1?=
 =?us-ascii?Q?obxkK9MweFgW0aMZLLgpTiI0j4COGgACo5JL2VeicR0tHlO81gPXleb4nafN?=
 =?us-ascii?Q?HJ7csA3zZ2CUrS6CQAyudBLvugG9wAtGx4MdGokUq3+t6/x8yJYfWIJkL4OA?=
 =?us-ascii?Q?osmNk6tDpkgFFWYFIfCGKQrQ9CDkg6tNRY4Pj+5P0lPAgyfxntC0JJ4WDelg?=
 =?us-ascii?Q?oRUPMUWxIpI83S56WQgDZMyoyDrQYIyY9qKJk9ENesRRWmIb0w5ohnXfEanf?=
 =?us-ascii?Q?FFODv7Gr2L3L8SPa620uAXNuvvYLMQH75oiJ8YHfxkOwhd2mbSV0J6Wcg1Cd?=
 =?us-ascii?Q?w4q/nmmPlyqnjrzbhkVSeZFJ0ofTE53+b03grgIjaFb79DJMHjZJwBo+dZK0?=
 =?us-ascii?Q?2fp290qVuGo9iDzZA0SrwaAhWkvAP0MConUYREWJIyVIJwZ0dhzeB9FIDa4v?=
 =?us-ascii?Q?Vjx5twMYC5cYyIL9z8iOvT4Bn+65Kk+RHHTNftZiWxrky809DT3lDv/V3mFq?=
 =?us-ascii?Q?fKY2lrc/+eSp8UJQd+kS3rUIb1Kv8FJRj0mfkxQ8N0xZoGLXauLEZWW1fdAb?=
 =?us-ascii?Q?g8eO0L2R1DvwVECXP17rvchrsr8RGPxQKHGNu51P+CW8YtbN7uA3cidwgNP3?=
 =?us-ascii?Q?uEd56QOLWij0G7fcSsodrH1ErjcKLdIaEIHJCmeAA8xbRJaBKYpH/Xfssfey?=
 =?us-ascii?Q?rc6OfG0mI75PEHRoA8R49KhNuqNYzumqbaqtlDkPKlvkJKW4FGgUypbz7/RP?=
 =?us-ascii?Q?Ljw+j10KUWXzF2PmQDjhNwTpM7Lc61lqu0ezC6eLVRanYyJpaOlEtYdddyAP?=
 =?us-ascii?Q?tVDhpJQOm6byCDBoao13OhqVks0PbNKaUTJSDlRpJpRznp5uBG0ILSXvVEEd?=
 =?us-ascii?Q?Yb3AhHmMz7Aeyu7ceTzDdVjllvqWhGc2EkNcpnrVhyAd+gOmecNu2ik6llvR?=
 =?us-ascii?Q?bckQ4yc/jqrgUfmHyGAjwfhspw7+MbNN32johrrV4nPo9EyfrGtItmxomtGU?=
 =?us-ascii?Q?gbFIbqWRRcuS6HhGGSpe8TfAJN3biDyxwNPQ/2wyeeuDfJtgRn2lExImwzpm?=
 =?us-ascii?Q?NV3zYOB5MJvMLIHQikgVfV6Zu5i+sIyEzQHPceksqKS3?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sOT6EKFIgbdu9/xQKDyY4nsuUb+nG2dsdCZ5FL7LjrOBZBugdJB//MlwKQonepH5S8Q722QMYdCaBZowABuLf4lX2x56O3DVp9ApSwd1bPuClcIvmlfJkqis/LhweGZoSMjYxa70NRppP9K5sQZGQgao698SC8N4gkFUsUueJUO4HdYWZps0qeUIaDUGZrVqe2+n9/FEB0YI8taflNkTEpLFTSegQWDNUM4i+VR8o8CDBlwDxwcI785HNbu1fBoSjnUlIzxjRc+VsXjjE81cZF3O+JSEubeMPhvMx8RJzMggpL6w2j+b5ym57NFlm5XTfADXQinUiXtf52Ys3UpFRKnhZXsiAE38L7DTn8K5VzPrGej10EsVxKBevLyTI98eSlkDDmOZJTLufZWTFMR7SMXihGHtrcYbMsoKSGh7HqOGmsYXLSQ/FuFzzX2jxuCI
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:22:11.6507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839cd944-e4aa-481d-4779-08de6e16cb9b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5190
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

From: Santhosh Kumar K <s-k6@ti.com>

Implement bad block skipping functionality in SPL MTD loader to ensure
reliable boot from flash devices with bad blocks. Without this, the
SPL would fail to load images if bad blocks were encountered.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 common/spl/spl_mtd.c | 78 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/common/spl/spl_mtd.c b/common/spl/spl_mtd.c
index 95c0c8ce8cd..d635aa2b476 100644
--- a/common/spl/spl_mtd.c
+++ b/common/spl/spl_mtd.c
@@ -17,15 +17,64 @@ uint32_t __weak spl_mtd_get_uboot_offs(void)
 	return CONFIG_SYS_MTD_U_BOOT_OFFS;
 }
 
+static ulong spl_mtd_read_skip_bad(struct mtd_info *mtd, loff_t offs,
+				   size_t size, void *dst)
+{
+	size_t remaining = size;
+	size_t ret_len;
+	loff_t current_offs = offs;
+	loff_t block_aligned_offs, next_block;
+	u_char *buf = (u_char *)dst;
+	int err;
+
+	while (remaining > 0) {
+		size_t read_size;
+		size_t block_remaining;
+
+		block_aligned_offs = current_offs & ~(mtd->erasesize - 1);
+
+		if (mtd_block_isbad(mtd, block_aligned_offs)) {
+			debug("SPL: Skipping bad block at 0x%llx, jumping to 0x%llx\n",
+			      block_aligned_offs, next_block);
+
+			next_block = block_aligned_offs + mtd->erasesize;
+			current_offs = next_block;
+			continue;
+		}
+
+		block_remaining = mtd->erasesize -
+				  (current_offs & (mtd->erasesize - 1));
+		read_size = remaining < block_remaining ? remaining : block_remaining;
+
+		err = mtd_read(mtd, current_offs, read_size, &ret_len, buf);
+		if (err) {
+			printf("SPL: Read error at offset 0x%llx: %d\n",
+			       current_offs, err);
+			return size - remaining;
+		}
+
+		buf += ret_len;
+		current_offs += ret_len;
+		remaining -= ret_len;
+
+		if (current_offs >= mtd->size) {
+			printf("SPL: Reached end of device, read %zu/%zu bytes\n",
+			       size - remaining, size);
+			break;
+		}
+	}
+
+	return size - remaining;
+}
+
 static ulong spl_mtd_fit_read(struct spl_load_info *load, ulong offs,
 			      ulong size, void *dst)
 {
 	struct mtd_info *mtd = load->priv;
-	int err;
 	size_t ret_len;
 
-	err = mtd_read(mtd, offs, size, &ret_len, dst);
-	if (!err)
+	ret_len = spl_mtd_read_skip_bad(mtd, offs, size, dst);
+	if (ret_len > 0)
 		return ret_len;
 
 	return 0;
@@ -52,17 +101,19 @@ struct mtd_info *spl_prepare_mtd(uint boot_device)
 int spl_mtd_load(struct spl_image_info *spl_image,
 		 struct mtd_info *mtd, struct spl_boot_device *bootdev)
 {
-	int err;
+	int err = 0;
 	struct legacy_img_hdr *header;
 	__maybe_unused struct spl_load_info load;
 	size_t ret_len;
 
 	header = spl_get_load_buffer(0, sizeof(*header));
-
-	err = mtd_read(mtd, spl_mtd_get_uboot_offs(), sizeof(*header),
-		       &ret_len, (void *)header);
-	if (err)
+	ret_len = spl_mtd_read_skip_bad(mtd, spl_mtd_get_uboot_offs(),
+					sizeof(*header), (void *)header);
+	if (ret_len != sizeof(*header)) {
+		printf("SPL: Failed to read image header\n");
+		err = -EIO;
 		goto out_err;
+	}
 
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
 	    image_get_magic(header) == FDT_MAGIC) {
@@ -82,8 +133,15 @@ int spl_mtd_load(struct spl_image_info *spl_image,
 		err = spl_parse_image_header(spl_image, bootdev, header);
 		if (err)
 			goto out_err;
-		err = mtd_read(mtd, spl_mtd_get_uboot_offs(), spl_image->size,
-			       &ret_len, (void *)(ulong)spl_image->load_addr);
+
+		ret_len = spl_mtd_read_skip_bad(mtd, spl_mtd_get_uboot_offs(),
+						spl_image->size,
+						(void *)(ulong)spl_image->load_addr);
+		if (ret_len != spl_image->size) {
+			printf("SPL: Failed to read full image: %zu/%u bytes\n",
+			       ret_len, spl_image->size);
+			err = -EIO;
+		}
 	}
 
 out_err:
-- 
2.34.1

