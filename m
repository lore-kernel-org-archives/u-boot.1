Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C14EC61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 04:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D6C06072C;
	Fri, 28 Aug 2026 04:29:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6LwOowl6f1sD; Fri, 28 Aug 2026 04:29:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787891341;
	bh=nFwkN7KRt8fUtYnZOkrpBmHwJvJszCOTmu1aFCQ+0i0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VkxUYyab6N1E0emejKrtYeXGlWHAokg3+T8R8um6ISNc2eIYexAezFchWjH0XzfpH
	 gcg2cUUo5V2IO5BhffLMH5pU53ITZkx2Bikt3FV4n4EDE5k0vRzmOMASpQydaqDN8r
	 IYuveBUbKTL0TDB45nJ6L5YktC4Bn65UU/5r9CuZKS/2gyeMhzdBZW8NrxhbHTWPyS
	 WrlLEWCNopRKN/L7xvbo+Xcddcy7kLSREMPTyipi8RLtdK7YTca2mnUNhdP3AEYqso
	 00X4in74ATP1XPKJXvFR/LgwB+2GdG5JkTO77Q2/jfCgpIy06ldhg339SG+bJpHL6P
	 tk/MpzAl8xRLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A990606D6;
	Fri, 28 Aug 2026 04:29:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D0642386
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 04:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C210F80ECC
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 04:28:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nlRglhwLZp_W for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 04:28:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=XhnN/LnB
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 94D2080EC6
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 04:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHiUlwG2Vm0OPLkyj6RitR1DnLlMaaNNFZAE61ERp+TX6X7Ok+FN8i7YGetjFwGT6VgdWSRDiDUujQ+yBeBusmaajitzXItMXxn9SOEKP4MRsrUsn0+MGRfX9U52wKUxg7KHKyLZdXZ1X/H84WvsBE+5Hgozd0regyATEzKRQLy3rr8Bz+Z2/x8Gob9vJPoCal3691D+OqVpQ9I0zXMXvrIS5xGzVPprQT1y2RXvVcM54YxijGMrLRkFtFeOTpFIdXXE7euaahQvooOmmNn3W5guWPvbqL9EswZT0lIVxbPccZGaocZ+8wYjMVvSu5KshlEeYJsXWV2iNGUWG2lrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFwkN7KRt8fUtYnZOkrpBmHwJvJszCOTmu1aFCQ+0i0=;
 b=FPlzQgrMzrTlt1txSV3y5brOJXxoO8m90eV2ChCQFRf5wkHGrc324M3uKeRSdFYIyZ93/zEYNRnp6/ZaglSMhpzhXKUhW9BAHYUeAb02sqZv312uKubcCuv59WAKfIsFtQZwAxmh+qIZe4vzv8OGEL22rvBKGRyvwaICD8158qhJuLobhBglaeTM0kKq/JMFx/OPZ/attLh9IgSinbcwQtGIuolFYuPBMgRS0kEB4SEvzilx+1QRWhIBiEl9tMLt1b7T/0Mp7GiYLsAiPVBViMSVZhtDmr5a9X473sYImsUWD8mG8pnJnH+tILpa2hwJj+ibEvb+2AcPkEIG2poC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFwkN7KRt8fUtYnZOkrpBmHwJvJszCOTmu1aFCQ+0i0=;
 b=XhnN/LnBfc3T1+Qc01c8bDVlc8izEGaKBDZCQAfOLYl0rONAe15zvwJ3DkrWmXY978CA6niJY2CXglGbZLFZEYDhzbVKuFXRfJgBB1p+r63bgIJrq2qVOHje6Bi/55CO3qG7V5K823cvQc4uV9MLD+HUYNoa3q1fZTWz1NOdkog=
Received: from MW4PR04CA0357.namprd04.prod.outlook.com (2603:10b6:303:8a::32)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 04:28:49 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::b) by MW4PR04CA0357.outlook.office365.com
 (2603:10b6:303:8a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 04:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 04:28:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:28:47 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 27 Aug 2026 23:28:45 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] efi_loader: expand disk device names with drive details
Date: Fri, 28 Aug 2026 09:57:58 +0530
Message-ID: <20260828042828.3421664-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828042828.3421664-1-padmarao.begari@amd.com>
References: <20260828042828.3421664-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: c0382ad8-3599-4388-3238-08df04bcdb23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iBJxDDdA4ZeJZ5njIm+m+7nbtaNogk2HKa682FIUt13riSaVidoG1+uCNotQ35oAugbud5f7TZEwTFWf1of9pCDqVqkgw1gxJ2k66Kbjh8d0dSZmA2HN6DflRJpwkqHLKc+6vk/GhlsYlW1Iv4h6N/VohYrN6p/ycg0FliWyHSQc0dum/eC9S6GrIGB4myjnH233wC44pQEDng7jW/DFnwhkLkBGdsH86aKWIX1bkBstVq/MGJCKW76oW24wDnkjH/KEXnVmmk5tWNA6Z3LZ+2R/UpIwwZ0nUWcql/kps5VUJmo0K7F34HZgKalLD7mCICROxs8TGd/UhIMIXK1kFIINpocgK+E28TvxGcUWeGPxZSbDSoAJe/Idbc9FXLNFrPTPWs5u+yi7aD/5mVeKy2YV7w7xHJgJT5q21L4yKWK29OruaaDBI9/hiCCPnIZu9fGH9sfaY+UMj4GIj1g1OwhSkZ0kEPY0XV2kmPW0Fsx/XDD/UT4wNEM8WHqUHjIx3HrieZoPoVZolwkTwkmPAMGzz3tugqwBi4JYWA9TUrhmFYv51Oy5XL5BqMhDLtiA+HIdlRg4tnZiv6RUSXXyU1E30JCZVVZHS+CgRd6wdP4nS56PLVOhHpPBKFNhdc+bmG89wngiof+8z6qADJL18LpeivEvo+5qhV31tLkBo+aRKXIzgAunFCcBsrrwBT+v2vVjG3qFuBPPq0mlTjUVmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FHyykuYzzU36PzhFbJHzRZH3VVX9x2zW7caEm/Y1dq9lPbrHqWu4kUm2cLxNVUsRswk2yzD4dkj3mzP3V6vI+EEPJcgRJ3rdyLOpjM5aHX2XTDsOQMZIA30Bd2wRWC4hO5qT08yNg0hfB4GoO4yd+pHyIFxJ4zHWrqSW2YYY2c08FyoXh9gQi4OWPAjmB2Xni1g6aG/BSOsCmbkxuCj+wJNzPQpzv/GLXdMKkd1cVp+vUlKS/yJy9q3AzsYcAaqNIO36QHnH3lsFhZtP9Gblg+eMPX/LHwJuk2r3MZZfZX+9fyPGxO9s7iEoiIPq9uEt7MM/EmQhRZJjKASzOY/Qwt/BswMCD/2ggwMMb5pHFnmv2B/3t8HzhGw1cW/0te9ThAipwSbeoMExFMJ28yBOB1R9mJj1p2SzmxDNn8x295PGKgCFt6ZNZEY1WNXAK1pp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:28:48.5394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0382ad8-3599-4388-3238-08df04bcdb23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Increase the boot menu device name buffer so that extra metadata can
be appended. Append the disk capacity and trimmed vendor/product
strings to the device name so users can differentiate drives in the
EFI boot menu. Also pull in linux/string.h for the strl* helpers.

For example, the U-Boot boot menu now shows entries such as:

    usb 0 (29.7 GiB, Generic Ultra HS-COMBO)
    usb 1 (28.6 GiB, USB SanDisk 3.2Gen1)
    scsi 0 (1 GiB, MICRON MT064GBCAV1U31AA)

The menus are drawn with absolute cursor positioning starting at
column 7, see bootmenu_print_entry() and eficonfig_print_entry(), and
the titles are not truncated. A title which does not fit into a line
would wrap and thereby corrupt the menu layout. The name is therefore
limited to 64 characters, which leaves the longest description above
at 46 columns. Should the identification strings not fit, the
capacity is shown alone rather than a string cut in the middle:

    usb 0 (1023.9 GiB)

Note the limitation of this approach: the description is built from
what struct blk_desc carries, so devices reporting the same capacity
and the same identification strings still get the same description.
Two identical USB sticks, several namespaces of one NVMe drive, or
several sandbox host devices remain indistinguishable:

    nvme 0 (953.9 GiB, SKHynix_HFS001TEM4X169N)
    nvme 1 (953.9 GiB, SKHynix_HFS001TEM4X169N)

    host 0 (64 MiB, U-Boot hostfile)
    host 1 (64 MiB, U-Boot hostfile)

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- Reuse the print_size() formatting through the new snprint_size()
  helper instead of open-coding the unit selection.
- Build the suffix with a single snprintf() instead of a chain of
  strlcat() calls into an intermediate buffer.
- Limit the device name to 64 instead of 128 characters and fall back to
  the capacity alone when the identification strings do not fit, so that
  the entries stay within an 80 column terminal.
- Document the limitation of the approach in the commit message.
---
 include/efi_loader.h      | 12 +++++--
 lib/efi_loader/efi_disk.c | 66 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3a4d502631c..2bf48d2e169 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -289,8 +289,16 @@ const char *__efi_nesting_dec(void);
 #define EFI_CACHELINE_SIZE 128
 #endif
 
-/* max bootmenu title size for volume selection */
-#define BOOTMENU_DEVICE_NAME_MAX 16
+/*
+ * Max bootmenu title size for volume selection.
+ *
+ * The menu entries are drawn with absolute cursor positioning starting at
+ * column 7, see bootmenu_print_entry() and eficonfig_print_entry(), and are
+ * not truncated. A title which does not fit into a line wraps and thereby
+ * corrupts the menu layout, so keep it short enough for a terminal with
+ * 80 columns.
+ */
+#define BOOTMENU_DEVICE_NAME_MAX 64
 
 /* Key identifying current memory map */
 extern efi_uintn_t efi_memory_map_key;
diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 4a3ace3a304..a9913ad33c4 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -8,6 +8,7 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <blk.h>
+#include <display_options.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/tag.h>
@@ -20,6 +21,8 @@
 #include <part.h>
 #include <malloc.h>
 
+#include <linux/string.h>
+
 struct efi_system_partition efi_system_partition = {
 	.uclass_id = UCLASS_INVALID,
 };
@@ -814,9 +817,68 @@ int efi_disk_remove(void *ctx, struct event *event)
 
 }
 
+/**
+ * efi_disk_append_detail() - append capacity and vendor info to a device label
+ *
+ * Appends a " (size, vendor product)" suffix to @buf when the block
+ * descriptor carries readable capacity or identification strings.
+ *
+ * @desc:	block device descriptor
+ * @buf:	label buffer to append to (already contains base name)
+ * @size:	total size of @buf in bytes
+ */
+static void efi_disk_append_detail(const struct blk_desc *desc,
+				   char *buf, int size)
+{
+	u64 capacity = (u64)desc->lba * desc->blksz;
+	char capacity_str[SIZE_STR_LEN];
+	char vendor_buf[BLK_VEN_SIZE + 1];
+	char product_buf[BLK_PRD_SIZE + 1];
+	char *vendor, *product;
+	int len = strlen(buf);
+	int ret;
+
+	capacity_str[0] = '\0';
+
+	if (capacity)
+		snprint_size(capacity_str, sizeof(capacity_str), capacity);
+
+	/*
+	 * Some drivers, e.g. usb_storage and nvme, do not strip the blanks the
+	 * identification strings are padded with. Use copies as strim()
+	 * modifies the string.
+	 */
+	strlcpy(vendor_buf, desc->vendor, sizeof(vendor_buf));
+	strlcpy(product_buf, desc->product, sizeof(product_buf));
+	vendor = strim(vendor_buf);
+	product = strim(product_buf);
+
+	if (!capacity_str[0] && !vendor[0] && !product[0])
+		return;
+
+	ret = snprintf(buf + len, size - len, " (%s%s%s%s%s)", capacity_str,
+		       capacity_str[0] && (vendor[0] || product[0]) ? ", " : "",
+		       vendor, vendor[0] && product[0] ? " " : "",
+		       product);
+	if (ret >= size - len) {
+		/*
+		 * The identification strings are too long to be shown in a
+		 * menu entry. Fall back to the capacity instead of displaying
+		 * a string cut in the middle.
+		 */
+		buf[len] = '\0';
+		if (capacity_str[0])
+			snprintf(buf + len, size - len, " (%s)", capacity_str);
+	}
+}
+
 /**
  * efi_disk_get_device_name() - get U-Boot device name associated with EFI handle
  *
+ * Fills @buf with a human-readable label such as "mmc 0 (7.5 GiB, SanDisk
+ * AJTD4R)". Capacity and trimmed vendor/product strings are appended when
+ * available.
+ *
  * @handle:	pointer to the EFI handle
  * @buf:	pointer to the buffer to store the string
  * @size:	size of buffer
@@ -834,7 +896,7 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
 	bool is_partition = false;
 	struct disk_part *part_data;
 
-	if (!handle || !buf || !size)
+	if (!handle || !buf || size <= 0)
 		return EFI_INVALID_PARAMETER;
 
 	dev = handle->dev;
@@ -862,6 +924,8 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
 	if (count < 0 || (count + 1) > size)
 		return EFI_INVALID_PARAMETER;
 
+	efi_disk_append_detail(desc, buf, size);
+
 	return EFI_SUCCESS;
 }
 
-- 
2.34.1

