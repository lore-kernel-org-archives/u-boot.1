Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DF0C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD60988702;
	Fri,  9 Aug 2024 11:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2iXdsr6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231AC88BB6; Fri,  9 Aug 2024 11:38:58 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9480E88581
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uc/u+Az90XOuSvJd6CP5tDazwRXfCMBWjZymCvYs9WVYdaGwUPzSjU8O+I4AUaZxq0wOWRdkCFdW5CQWqVt26YpfFmAcp22/PvnP9goKqA876RdHFGDcOD1HstjbLi3TqtsWuIo1bRlG7p4jM9mof/sf/7YpMpS7W28wT+J+WniHe5R1gx44oHJB/6trBkGFOywuECFbM4qWId5R5WHBaPlORFV6YqIwpslq0aTuL7YaVIBdeRvaCjfpGmRGwTSymMtwSeA2COWX2TMngGe4bnHoqQFJeiT8eGlqXsQ1ZHDs4nRK/VDc5QAdE/nhs4xrqKP8SY1zJsBf5Tr/eRJ1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cGqUbJVKdr5g3PVeBcqmFZAHEoMIJ29MuMf5/SNPig=;
 b=oWr2myWn7YDCjAzP/TGQqjvUTHO6v4g3mpQ1lfAxwpCHXnOsZ/MTEx8o1wQmn4PzqNGC9RZ9ZoDRHJnH8fXj+ys4h/CK7CHMTQGcVLJaXazswZU4v1sRhhqCuQkIYIbQBxwxHo9gEW+VRQG0agTNLcYSvje95nFLSzBM7w5CgQy5ioJHUR+njOWxznY5/TdjiwlrCxuYFK678HsBnHzSUb8LEQ1HWIudnYPW82+2RhdQjTDQUnIMOQMCmAJOT4Hyc7nIcQYl/eyp9flqIBNAaGeLEDHB42V6BNVNuGdmyCTkz+SjSYJ/H+oPJPH604vrvpmvvqf5xl4le/ioP59MgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cGqUbJVKdr5g3PVeBcqmFZAHEoMIJ29MuMf5/SNPig=;
 b=2iXdsr6h2eMk//IJyjuPaZXlsfgQYiqUe4ZtXZ4mgp/JAMZQ2iH+2j6wp0Pa0dsL6oVBqKp2xdq5jt5nZidSgD7jULGjV6TyPTUnXyL6vnAt0hsVuHXc/CK4zVPE2mCsXnL3mph4VMRaaNZ4XUwzgLS/BTwFHfuuecxGZcidEAw=
Received: from BN9PR03CA0367.namprd03.prod.outlook.com (2603:10b6:408:f7::12)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Fri, 9 Aug
 2024 09:38:50 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::c9) by BN9PR03CA0367.outlook.office365.com
 (2603:10b6:408:f7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Fri, 9 Aug 2024 09:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 09:38:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 04:38:49 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 9 Aug 2024 04:38:47 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@amd.com>
Subject: [PATCH] sf: Add lock info option to sf command list
Date: Fri, 9 Aug 2024 15:08:41 +0530
Message-ID: <20240809093841.1304-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e5c12a-1713-4613-3788-08dcb8571309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S02Yv/D+X+HGFrRnStVlzb6cWRos8GTKgbT9HN5m2pXOMByEt7wR+NuyLbO1?=
 =?us-ascii?Q?ta0BtWbOP1ZHE0Tmwv5we8IFLLm6CqIxZaZvK3Vndoa48YpkEO09Kk2rOETf?=
 =?us-ascii?Q?GItRMr6nX9VhpO9atxaCJfQJ9BD5h5S3b7ACVdyu1WEhB4JGudX6hC2vnQ3e?=
 =?us-ascii?Q?47KIIln6oxXWPFqTDWDWkJHZd6Fey0xMwgM2ZrpQX7gvM0rVGGkdezCKekqH?=
 =?us-ascii?Q?9aPRdSIYkg/GZXC8VjVbrdy06YGeG8zlz/zNhIGp0PbpAJ0vUnPIJ5TdRpI1?=
 =?us-ascii?Q?YqwDbXdyWdBtJSHl1dShTgKpEcxBDkMTRScpEypSoZUQT375zXaUIqCeoRjZ?=
 =?us-ascii?Q?xPjH+qvtl02hJX0/g8U5sjd2xkZ8VGrZ6vm+bWLr9ufgrnyGLDbRKrAa8Gx7?=
 =?us-ascii?Q?8NGnIGa/Wx9AbUZJF48OhUBB8LUqFddtWmJnXJ+eQrpxhvrEXwmPiycxhH+X?=
 =?us-ascii?Q?v/7Tu71YDGFZQCYn+3l8JCPO595AwYljvEuQaikK856xtsnEIyPe9ygW6iRI?=
 =?us-ascii?Q?rIL6JZFjjBbp1fCAEkeQnzbXfbOdDSGZCbsf3MkuM8bUBGLq0Up7tJia3Qtj?=
 =?us-ascii?Q?YHB3/PD0JOLW1XPG6p5td2Mgxk5HTqHiqVip2eSBFzo+RXyiDAAd7douNSZ6?=
 =?us-ascii?Q?paaZylJ8RTfbVfUv1VIATwDk0e6ue63JeedUS5zK9URdj54nkkQZHTVAS7Nh?=
 =?us-ascii?Q?AGtPOJf2Y3x7qHN72HdFzaAffvTzRI/7drwKn1vf9KuW945VbbgkMB6EKi+e?=
 =?us-ascii?Q?lQPiQVW8Yzt+pD7FDmen1EC2e4GJqdYLYgkIIubzfDPGCzQszxSKanCaGFhz?=
 =?us-ascii?Q?qXyqnJ+A+ijlwTG4EzUa5uwwWOBqPB4kUIhW4F1eJS3/DQIokdVUT++C116U?=
 =?us-ascii?Q?JLJnCsz7QNtbOxNL6ELMjS9d3Tdmk3KwPMnZgJrL2RXqdy1tAVcGFnf/3CYZ?=
 =?us-ascii?Q?fkMl3i99YXWfecyeOF2ATRLyPPHJVyBiVBwj9wHcPNMidhS3BPZW2aVPutuS?=
 =?us-ascii?Q?qGTNwD9Df0Dr1OGm62N2vHD4gGBX6CuCQREtKK7M7i7nJMPl2pGct+f7hX34?=
 =?us-ascii?Q?vT3VePa5odhScM+lYbSmPe2VFZLELQUQoE6sRpAFhr7qQXkub5t7wjdcd51E?=
 =?us-ascii?Q?e2DdvwiSvw6kf9D5P6Ooaf7ELiT9d2m0KwJNMHKsR8+l3ZFO47j8IsvL0K8J?=
 =?us-ascii?Q?YfL7sBJlfmpd3u0NZYcwiV5iQlra5IYZbecgypF7beEyDsZfKf3Nsk87jWm/?=
 =?us-ascii?Q?fhJiQnE2rWCuTce7kK1gEZ/kTgHznm8p1mhRlwjDhZnFog0Rj34GnnAUN9ni?=
 =?us-ascii?Q?Z3fJc3a29k+Jrt0DsszibVQVhWGaWjEqjxUUvvHLdcm3cPzYrXVpoRQYLKq4?=
 =?us-ascii?Q?pNndNBbbiG9k8gqbox72xNS9MiRim/N29ZRWnVKpDzxZ8xyiouzPKo0z5Itu?=
 =?us-ascii?Q?JBnTJn1xW7k54i2RI+FxRf69Ooj8uql7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:38:50.0023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e5c12a-1713-4613-3788-08dcb8571309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
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

Many SPI flashes have status/OTP bit for TOP or BOTTOM selection
in the status register that can protect selected regions of
the SPI NOR.

Take this bit into consideration while locking the region.
The command "sf lockinfo" shows whether the flash is TOP or
BOTTOM protected, based on this info the "offset" is provided to
the "sf protect lock" command.

Versal> sf erase 0 100000
SF: 1048576 bytes @ 0x0 Erased: OK
Versal>sf lockinfo
Flash is BOTTOM protected
Versal> sf protect lock 0 20000
Versal> sf erase 0 20000
ERROR: flash area is locked
Versal> sf protect unlock 0 20000
Versal> sf erase 0 20000
SF: 131072 bytes @ 0x0 Erased: OK

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 cmd/sf.c                       | 30 +++++++++++++++++++++++++++++-
 drivers/mtd/spi/spi-nor-core.c | 16 ++++++++++++++++
 include/linux/mtd/spi-nor.h    |  1 +
 include/spi.h                  |  3 +++
 include/spi_flash.h            |  8 ++++++++
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/cmd/sf.c b/cmd/sf.c
index f43a2e08b3..62afa91057 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -413,6 +413,30 @@ static int do_spi_protect(int argc, char *const argv[])
 	return ret == 0 ? 0 : 1;
 }
 
+static int do_spi_lock_info(int argc, char *const argv[])
+{
+	int ret;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	ret = spi_flash_lock_info(flash);
+	if (ret < 0) {
+		printf("Flash info is not set\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (ret == BOTTOM_PROTECT) {
+		printf("Flash is BOTTOM protected\n");
+		return CMD_RET_SUCCESS;
+	} else if (ret == TOP_PROTECT) {
+		printf("Flash is TOP protected\n");
+		return CMD_RET_SUCCESS;
+	}
+
+	return CMD_RET_FAILURE;
+}
+
 enum {
 	STAGE_ERASE,
 	STAGE_CHECK,
@@ -607,6 +631,8 @@ static int do_spi_flash(struct cmd_tbl *cmdtp, int flag, int argc,
 		ret = do_spi_flash_erase(argc, argv);
 	else if (IS_ENABLED(CONFIG_SPI_FLASH_LOCK) && strcmp(cmd, "protect") == 0)
 		ret = do_spi_protect(argc, argv);
+	else if (IS_ENABLED(CONFIG_SPI_FLASH_LOCK) && strcmp(cmd, "lockinfo") == 0)
+		ret = do_spi_lock_info(argc, argv);
 	else if (IS_ENABLED(CONFIG_CMD_SF_TEST) && !strcmp(cmd, "test"))
 		ret = do_spi_flash_test(argc, argv);
 	else
@@ -632,7 +658,9 @@ U_BOOT_LONGHELP(sf,
 	"					  or to start of mtd `partition'\n"
 #ifdef CONFIG_SPI_FLASH_LOCK
 	"sf protect lock/unlock sector len	- protect/unprotect 'len' bytes starting\n"
-	"					  at address 'sector'"
+	"					  at address 'sector'\n"
+	"sf lockinfo				- shows whether the flash locking is top or bottom\n"
+	"					  protected\n"
 #endif
 #ifdef CONFIG_CMD_SF_TEST
 	"\nsf test offset len		- run a very basic destructive test"
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index aea611fef5..2114be1e61 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1410,6 +1410,21 @@ static int stm_is_unlocked(struct spi_nor *nor, loff_t ofs, uint64_t len)
 
 	return stm_is_unlocked_sr(nor, ofs, len, status);
 }
+
+static bool stm_lock_info(struct spi_nor *nor)
+{
+	int status;
+
+	status = read_sr(nor);
+	if (status < 0)
+		return status;
+
+	if (status & SR_TB)
+		return BOTTOM_PROTECT;
+
+	return TOP_PROTECT;
+}
+
 #endif /* CONFIG_SPI_FLASH_STMICRO */
 #endif
 
@@ -4145,6 +4160,7 @@ int spi_nor_scan(struct spi_nor *nor)
 		nor->flash_lock = stm_lock;
 		nor->flash_unlock = stm_unlock;
 		nor->flash_is_unlocked = stm_is_unlocked;
+		nor->flash_lock_info = stm_lock_info;
 	}
 #endif
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d1dbf3eadb..48d39a7052 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -580,6 +580,7 @@ struct spi_nor {
 	int (*quad_enable)(struct spi_nor *nor);
 	int (*octal_dtr_enable)(struct spi_nor *nor);
 	int (*ready)(struct spi_nor *nor);
+	bool (*flash_lock_info)(struct spi_nor *nor);
 
 	struct {
 		struct spi_mem_dirmap_desc *rdesc;
diff --git a/include/spi.h b/include/spi.h
index 7e38cc2a2a..46d27f7564 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -38,6 +38,9 @@
 
 #define SPI_DEFAULT_WORDLEN	8
 
+#define BOTTOM_PROTECT		1
+#define TOP_PROTECT		0
+
 /**
  * struct dm_spi_bus - SPI bus info
  *
diff --git a/include/spi_flash.h b/include/spi_flash.h
index 10d19fd4b1..b8a6456fe4 100644
--- a/include/spi_flash.h
+++ b/include/spi_flash.h
@@ -202,4 +202,12 @@ static inline int spi_flash_protect(struct spi_flash *flash, u32 ofs, u32 len,
 		return flash->flash_unlock(flash, ofs, len);
 }
 
+static inline int spi_flash_lock_info(struct spi_flash *flash)
+{
+	if (!flash->flash_lock_info)
+		return -EOPNOTSUPP;
+
+	return flash->flash_lock_info(flash);
+}
+
 #endif /* _SPI_FLASH_H_ */
-- 
2.17.1

