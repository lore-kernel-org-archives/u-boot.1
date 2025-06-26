Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A85DC7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 12:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 471ED82977;
	Thu, 26 Jun 2025 14:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BI7cgb1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B3FA82063; Thu, 26 Jun 2025 14:05:40 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CC5282063
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 14:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55QC5WVh1730356;
 Thu, 26 Jun 2025 07:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750939533;
 bh=cvfpXzLVTYuU1JOWkeWhI8IBOL7fgZyf+o6MLc/PUFE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=BI7cgb1K1wf7mJqmAj5M1DuiUbQ2mPW6T4QxU42h3NyjGGN3OYX58S+S326aiZxHS
 Je3oDycIoMea0Vs4ZJu8NWaBCThtH2xWkRaDhVIB5Z/rG/ICNnGzJNUkCE/1bDhuxw
 YWM9lcVqHDvhaPRunMDPjrSRvHqeG5OraQJBZ1Us=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55QC5Wnq3603883
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 26 Jun 2025 07:05:32 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 07:05:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 07:05:32 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55QC5VRT1229244;
 Thu, 26 Jun 2025 07:05:32 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <nm@ti.com>, <bb@ti.com>
Subject: [RFC PATCH v1 3/4] spl: Kconfig: disallow loading args in falcon mode
Date: Thu, 26 Jun 2025 17:34:41 +0530
Message-ID: <20250626120443.1405409-4-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626120443.1405409-1-anshuld@ti.com>
References: <20250626120443.1405409-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The current falcon boot requires loading of an args file (usually the
DTB) and a kernel image file to boot. But with secure boot, the dtb is
expected to be packaged inside the fitImage that kernel image (path set
by SPL_FS_LOAD_KERNEL_NAME) points to making loading the args file
unnecessary.

Secondly the args file causes security issues since it can not be
authenticated unlike a fitImage.

Furthermore current falcon boot flow provides added flexibility that
might not be desired in the interest of security, in the current flow
SPL first looks for files pointed to by the environment variables
'falcon_args_file' and 'falcon_image_file'. This could be compromised by
modifying the env data.

Therefore this patch introduces a new boolean config symbol
SPL_FALCON_LOAD_ARGS that simplifies the boot flow to only load the
kernel image file set by SPL_FS_LOAD_KERNEL_NAME if disabled.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig   | 10 ++++++++++
 common/spl/spl_ext.c |  5 +++++
 common/spl/spl_fat.c |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index d5d3a41ce61..b2dbe2eea65 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1213,6 +1213,16 @@ config SPL_FALCON_ALLOW_FALLBACK
 	  When enabled, u-boot will to load SPL_FS_LOAD_PAYLOAD_NAME from MMC
 	  if loading SPL_FS_LOAD_KERNEL_NAME fails.
 
+config SPL_FALCON_LOAD_ARGS
+	bool "Allow loading of args file in falcon mode"
+	depends on SPL_OS_BOOT && SYS_MMCSD_FS_BOOT && !SPL_SECURE_OS_BOOT
+	default y
+	help
+	  Say y to enable loading of SPL_FS_LOAD_ARGS_NAME which is used as
+	  the OS kernel argument from the filesystem (typically the DTB).
+	  This could be disabled if the falcon payload itself contains the
+	  argument (or DTB) like in a FIT container.
+
 config SPL_PAYLOAD_ARGS_ADDR
 	hex "Address in memory to load 'args' file for Falcon Mode to"
 	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index 7e0274a3058..f299587d73e 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -82,6 +82,11 @@ int spl_load_image_ext_os(struct spl_image_info *spl_image,
 	struct disk_partition part_info = {};
 	__maybe_unused char *file;
 
+	if (!CONFIG_IS_ENABLED(FALCON_LOAD_ARGS))
+		return spl_load_image_ext(spl_image, bootdev, block_dev,
+					  partition,
+					  CONFIG_SPL_FS_LOAD_KERNEL_NAME);
+
 	if (part_get_info(block_dev, partition, &part_info)) {
 		printf("spl: no partition table found\n");
 		return -1;
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 8b7cafa7291..f3d8a88a8a4 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -115,6 +115,11 @@ int spl_load_image_fat_os(struct spl_image_info *spl_image,
 	int err;
 	__maybe_unused char *file;
 
+	if (!CONFIG_IS_ENABLED(FALCON_LOAD_ARGS))
+		return spl_load_image_fat(spl_image, bootdev, block_dev,
+					  partition,
+					  CONFIG_SPL_FS_LOAD_KERNEL_NAME);
+
 	err = spl_register_fat_device(block_dev, partition);
 	if (err)
 		return err;
-- 
2.49.0

