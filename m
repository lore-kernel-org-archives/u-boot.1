Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532F1C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 13:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B535B84A67;
	Tue, 30 Jun 2026 15:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ENsvz0xQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D3784A6F; Tue, 30 Jun 2026 15:03:26 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0998C84A52
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 15:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYmxnzSoXRnSauYoJfbVFkI4UuoIIJE36ZcJ1H3Ykchn8dIB3yVeLEjf/77cUHSiBr5PThphkfapSIoo6iuhW3ZmHqPQ3vIB/sw0Mi2UsU80A0+LPiDiHFXYN3/dV3NB+zaUTBNKcUyoAH3CQ3KJ6VpWXplsKbPJz6CRvLMLYfp6KTUtv5MtFxOddYKl6rp83xbo2BJ+NAhx/JlrchcUvEsNHNs+L/Pero57HapIoKdAuNzuFYYLfvM/lTtT0FIcPmjBuHkzGBUkJc80b74a/kY9/yn6TQMPkXksjn6z0WVFQSVSP7dO+TR6i1GahCp+DwNy+FsRDDpaC6Mb5wyr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJYFa6NxIOYZUGo19P2PHstehnMLz3DwH81dHZqbjV0=;
 b=RW3rvhFGfCGDpuvGqI19/bjdZzPeqeAwqraRB7DqE0/jIcUMBL1jSxbczZYEfRa7ZiPhBW3OSnQopMWvjv+Ej7MT67yej2z59DGTz13JpbYHxee4w4cMwvkz8he7WKW9UDCjEiJOs+4/5LLDzf5H+v4/KOap2LN2GD1VBmz1S56KDmWquQVJXdMeHv9SJMH7gxTf/dhZZLUEFRJxjG6k75AnG8Agk/LvSQbhiyndel0zqxXxOA+5w6AZYtiLgouyocXHVDK9FeDGvnkydfo4mOrnhgEUJFy1oFB72pCovM1l1/uvZmGD8kpqjdZlq3dGpii7H3nPN4G9vPpTRkr2rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJYFa6NxIOYZUGo19P2PHstehnMLz3DwH81dHZqbjV0=;
 b=ENsvz0xQL3e8zMo80qaOtfThPDP35ms3KyW3tHHhjaA+h4biHdY6+iVRcZbLDrAk9eRbQchdbLXcX52WCt7WdZHQdLwGSVfDwl1bYfcoEkzrbFgmYITzNKjoHAxTn1gbf0UGasXOIRkpoMcsslHNy0Bq06Fv83avFMmQulwhJnw=
Received: from SJ0PR13CA0146.namprd13.prod.outlook.com (2603:10b6:a03:2c6::31)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:03:13 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::39) by SJ0PR13CA0146.outlook.office365.com
 (2603:10b6:a03:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 13:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 13:03:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 08:03:07 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 30 Jun 2026 08:03:07 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Francois Berder <fberder@outlook.fr>, Padmarao Begari
 <padmarao.begari@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>, "Pranav
 Tilak" <pranav.vinaytilak@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] board: xilinx: Fold FWU dfu_alt_info into
 configure_capsule_updates()
Date: Tue, 30 Jun 2026 15:02:48 +0200
Message-ID: <ea62096437b39ff9038f7169e461bfe7863ee85a.1782824566.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6297; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=4zwdr+FgdfJ6t6Z+kyn28NBzmY3bwbwiWvvNStQFjfw=;
 b=kA0DAAgWqwf+8E71EfUByyZiAGpDvnuj2muuDAKXtR5kOxRA+AlENTylDAo3HAJ+Ap/9QqmQZ
 Ih1BAAWCAAdFiEElwIsQKz21qUWp1lvqwf+8E71EfUFAmpDvnsACgkQqwf+8E71EfUITwD+M/+c
 s6MmOpAsFPrNAE4y8MpfwtRIj5jxrjLACE9Bsi0BAI/eDI8aIhkkeNVBYRvw2pb7oEWLt3nEQVf
 w265tgZEO
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: 1baa2f46-da7a-4c3b-fc2e-08ded6a7f162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|32650700020|1800799024|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: JMw1TzsgHB8R1X31fU9/nh1CHmTTCIU1cB1JBmOMIvzfp7dNDoqY34w1PcOWk/inJa1hYFxgag7XgIdriUr6jX5hnOD76THEJyZDt/mAuhvogXqNOYCNfuBVDQDktM2WBtOKCYf0yyI0vHrJtCbslHax3eBZD/GlwFyA9lU8/gf9KzFZoz8CmrFVjWfyjSeiZS6I3zPBqAvM43EYH4WtetTi4DpPUlPJ6Mo1KJZYnfvhPxaVFFzfUPf0RVAUJtQPvKGBXgSgHyn50LYfPwFwyv4zQqRkZ2jEqKJAYTxmQ+OogglfKR5DEKl5iDgTc89bE7sX3JFWrRIk/7g2b7mufEubcuT/HsgCMwgWzo3HZpSv6CJk8AkZ9NmmMEdu78cE4Wk66ieJ3FchBxMf08bIazhMv1p5eKQuK5jW8X3HpyCvZJ5ka0T0CEZj0dgpfVYTUaFlV1b0O+G0+tq7Xzm1RDwHhW8KwvUzqSfLu1xwrnhW749jnTQHmt1vgnNiYW2IAA2IXI+Je+ucwL6qZEjnSvTPhYepXSxqSXp99sH/4Fyyy7oARutbe6gmL5/HsWr97HT6kNCFsKAJqFXKkCON0ll4yrhnf43P/bEV19H75YMDEcFL+EEbo+X+uCm4XRzinSt0MRWSRZkNMVJ94tRuaU12sd0dXdlGdQ8yU0WVkdPpYPBBsdk8tyFBfGYiY1mzxbkZn+rNDZwpLO/psEh1qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(32650700020)(1800799024)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X2WUWU+fQCzF3GEd/4CV/LVscH9ClwDBL3xUzAeqz9VU1rZaEFy1VxadIzqkr7EYKA+UpnwZgH+oobOKzZ6QHTpovWSAu8iej9GzH2esLUoc2fzyy/xIYQbC/+t+rmeG6l8B2iaJCUDTghgdVHPG/rgEY8988itqVXFn5+6Z5IaFO3q7VWaY+lZQK1e8tFTMnlmmFFi/UPCc0QFtQIu22nhShcH1aDrZNMHlSI6wqOx/NRA42OuOqFrIVi52W1w+MIpiZo8inzZwRpEzgGFegNm6r4gg3NoZeGZ4GZYW4z8lvWugCysf3WITNALdxdk+mjlYSHzMJYejtIBB5APN5eXFZSndlndgH4aFs4fvAz9CvFZHkL8cW+TPa1/gwc8mMWZB1ZUVGBUp0Vb+r+z+CweF2zINf3UmiAn/J8X/64R33sh5Pt1hd9AnNf2k+IJ2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:03:12.9878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baa2f46-da7a-4c3b-fc2e-08ded6a7f162
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870
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

Commit 371a6c1744f3 ("board: xilinx: Add capsule and FWU support") and
commit 818c06faa119 ("board: amd: Add capsule and FWU support")
introduced a separate set_dfu_alt_info() for the FWU multi-bank case
(Versal and Versal Gen 2 respectively) which set the dfu_alt_info
environment variable directly, while configure_capsule_updates() handled
the non-FWU case by filling update_info.dfu_string. Having two functions
generating the DFU description is redundant now that capsule update sets
the dfu_alt_info variable on its own from update_info.dfu_string.

Fold the FWU multi-bank generation (fwu_gen_alt_info_from_mtd() over the
nor0 MTD partitions) into configure_capsule_updates() and drop the
standalone set_dfu_alt_info(). The function now selects the source of the
DFU string at run time via IS_ENABLED(): the MTD partitions when FWU
multi-bank update is enabled, otherwise the boot-mode based layout. Both
paths end up filling update_info.dfu_string.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/amd/versal2/board.c   | 63 ++++++++++++++----------------------
 board/xilinx/versal/board.c | 64 ++++++++++++++-----------------------
 2 files changed, 48 insertions(+), 79 deletions(-)

diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 2afd283b8ddd..6e09e408875d 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -227,8 +227,7 @@ int board_late_init(void)
 	int ret;
 	u32 multiboot;
 
-	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
-	    !IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
+	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
 		configure_capsule_updates();
 
 	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
@@ -362,8 +361,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
 
 #define DFU_ALT_BUF_LEN		SZ_1K
 
-#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && \
-	!defined(CONFIG_FWU_MULTI_BANK_UPDATE)
 static void mtd_found_part(u32 *base, u32 *size)
 {
 	struct mtd_info *part, *mtd;
@@ -399,6 +396,29 @@ void configure_capsule_updates(void)
 
 	memset(buf, 0, DFU_ALT_BUF_LEN);
 
+	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+		struct mtd_info *mtd;
+		int ret;
+
+		mtd_probe_devices();
+
+		mtd = get_mtd_device_nm("nor0");
+		if (IS_ERR_OR_NULL(mtd))
+			return;
+
+		ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
+		if (ret < 0) {
+			log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
+			return;
+		}
+		log_debug("Make dfu_alt_info: '%s'\n", buf);
+
+		update_info.dfu_string = strdup(buf);
+		debug("Capsule DFU: %s\n", update_info.dfu_string);
+
+		return;
+	}
+
 	multiboot = env_get_hex("multiboot", multiboot);
 
 	switch (bootmode) {
@@ -442,41 +462,6 @@ void configure_capsule_updates(void)
 }
 #endif
 
-#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
-
-/* Generate dfu_alt_info from partitions */
-void set_dfu_alt_info(char *interface, char *devstr)
-{
-	int ret;
-	struct mtd_info *mtd;
-
-	/*
-	 * It is called multiple times for every image
-	 * per bank that's why enough to set it up once.
-	 */
-	if (env_get("dfu_alt_info"))
-		return;
-
-	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
-	memset(buf, 0, DFU_ALT_BUF_LEN);
-
-	mtd_probe_devices();
-
-	mtd = get_mtd_device_nm("nor0");
-	if (IS_ERR_OR_NULL(mtd))
-		return;
-
-	ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
-	if (ret < 0) {
-		log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
-		return;
-	}
-	log_debug("Make dfu_alt_info: '%s'\n", buf);
-
-	env_set("dfu_alt_info", buf);
-}
-#endif
-
 int spi_get_env_dev(void)
 {
 	struct udevice *dev;
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 0537517b1b2e..f06d3c59d055 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -232,8 +232,7 @@ int board_late_init(void)
 {
 	int ret;
 
-	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
-	    !IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
+	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
 		configure_capsule_updates();
 
 	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
@@ -314,8 +313,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
 
 #define DFU_ALT_BUF_LEN		SZ_1K
 
-#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && \
-	!defined(CONFIG_FWU_MULTI_BANK_UPDATE)
 static void mtd_found_part(u32 *base, u32 *size)
 {
 	struct mtd_info *part, *mtd;
@@ -351,6 +348,29 @@ void configure_capsule_updates(void)
 
 	memset(buf, 0, DFU_ALT_BUF_LEN);
 
+	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+		struct mtd_info *mtd;
+		int ret;
+
+		mtd_probe_devices();
+
+		mtd = get_mtd_device_nm("nor0");
+		if (IS_ERR_OR_NULL(mtd))
+			return;
+
+		ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
+		if (ret < 0) {
+			log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
+			return;
+		}
+		log_debug("Make dfu_alt_info: '%s'\n", buf);
+
+		update_info.dfu_string = strdup(buf);
+		debug("Capsule DFU: %s\n", update_info.dfu_string);
+
+		return;
+	}
+
 	multiboot = env_get_hex("multiboot", multiboot);
 
 	switch (bootmode) {
@@ -392,39 +412,3 @@ void configure_capsule_updates(void)
 	update_info.dfu_string = strdup(buf);
 	debug("Capsule DFU: %s\n", update_info.dfu_string);
 }
-#endif
-
-#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
-
-/* Generate dfu_alt_info from partitions */
-void set_dfu_alt_info(char *interface, char *devstr)
-{
-	int ret;
-	struct mtd_info *mtd;
-
-	/*
-	 * It is called multiple times for every image
-	 * per bank that's why enough to set it up once.
-	 */
-	if (env_get("dfu_alt_info"))
-		return;
-
-	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
-	memset(buf, 0, DFU_ALT_BUF_LEN);
-
-	mtd_probe_devices();
-
-	mtd = get_mtd_device_nm("nor0");
-	if (IS_ERR_OR_NULL(mtd))
-		return;
-
-	ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
-	if (ret < 0) {
-		log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
-		return;
-	}
-	log_debug("Make dfu_alt_info: '%s'\n", buf);
-
-	env_set("dfu_alt_info", buf);
-}
-#endif
---
base-commit: 8f4ec2a116ee7ff6d19e6baa60833586df985de7

-- 
2.43.0

