Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB043C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 11:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF6E488126;
	Fri,  1 Mar 2024 12:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BmxjqrKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA118812F; Fri,  1 Mar 2024 12:21:26 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E83B88121
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 12:21:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXur0J5+UW7tBKQWA8whS1l+/yDKuZxQlBsa7FMbilA9XkEKL52CCl4Mt1iFPaaJVHM4gsYWkPids5c4/qiT8qbfhd9AFao6yfQM+iDaf3Mnh7W6/2KGs+Oo4qxBbPopRyKUOWQm2hfcbXbehrFpB+acuD5fdT0ER6VdKN3XBHFQ606BdHlVe14d+taG0UZTCodAHO+AVdx0kawc2ZTFLnd2byFF13f/HWqyACjY62iAx++GA326C08967lz3PuBB+VSqQyjUUcImlmmVaXe8U0+Ia+zEv0aeB5YIV4F55hi7W6ge8BzZbzbDXnqtPdd6VrAJVIwaUEWODqyGHILyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/RGgenLeN6rO3qufdp/A5tMqqzW7zD0DJv1G1fHkl4=;
 b=Qn4IrfqAYFrYGIZHaVtPXVF/MGae/NKQvw8WVTLOw4XlH3+CFMkNpyq61xKM0G9tvkwMKu6zKgCV/QmDFsmTpEaESrAy9ecqdkf0GWB+iCt4CWV1JGWtLc3k3HSZUmJCYTuzLkdQTxlRV1Mgqe/boRlb2DocNyld0R3H/KE6maILOlqtxYgpCa8HyNceaSfFmAqoZ2wHdcrRoJsZM1LaWajXsNTmEQz00w2C8MP3p3BsY2mRqcCqYwe74ftv+XL/uo9JQJFLcmZ0XmZqBUSCCWg8sZQlp9MpFxqVp8Y58Zb9ZAMXJVIgw/4mjRuKBjGbBNUkds2Z8nL2zWUysmi+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/RGgenLeN6rO3qufdp/A5tMqqzW7zD0DJv1G1fHkl4=;
 b=BmxjqrKVibu5GqreTLpjFMxJqTBamDh037iO5mLDmjSW6xx6bHxfyCF4zTRDdT5r6hbj+bz92x8fP9IPh7pQcYuubtv+HjAKY35gMzxKWADB9ptgGP7GwWgzae96QgSn7YRRNhHhSAj5MyqJsV/weGEI08WvbhKqC/0ylUi6bT8=
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Fri, 1 Mar
 2024 11:21:19 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::1) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34 via Frontend
 Transport; Fri, 1 Mar 2024 11:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 1 Mar 2024 11:21:19 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 05:21:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 03:21:17 -0800
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Mar 2024 05:21:16 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] mtd: nand: arasan: Update the correct return codes
Date: Fri, 1 Mar 2024 16:51:09 +0530
Message-ID: <20240301112109.3618564-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e48bf15-be1b-45d6-05f9-08dc39e1b7c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zm7F1CblpXmpFggKUgjPdgDGvVP2nV2d6E2tvTj15VI9hnSfgFngJ15TR7jm2IZp/AP/TEq682EJutgXwAURxV+JLAfAgd+1WI+IAKIkIIUTsJCFW+lQseWAUFexBLVZUWboyvu9aWehXrzyIkEsMt9t/EYVNVDYhXMWqD8fSpx66Q9Ds27YIWFfqr3mg/nUkqH+Cq6TQWOLlJJgwXkKKc2m7+4xJ8JndzGlYxi7k5nA616kAkD9MISRuzM9xSbO+UxT6DmZ1X4urvyW/PgGjLM83UVxH/yFfsYeOjGQeAcPYlPcM878IIGQIaWlMRvlO+2/fNNw5Gnw5z2tuhaAuqq3LjwsFf1FzAdHe/vzAUXwvxf0mDBqat2wIzxI7CgSOmQXUtJyLHHDmER0LNhn0IG52fAPIOy95ZGDbTRDObn9LMQZpSUzCs/v3/V1DBQI4wZT/UCp0mSBho5qlunyjt15OeMoOWW0MaGWKvs+/Sy/DfgLx4/CVQHdEKpkReKfqEL5pUXyGJR0sB0/bQVvvqSXlQt9pHcEyzVqvgcKLpr88rkoFSri5bnJndhtF6yL+Vy/3SJ+aK8qSeXEt6n8TEsi7Dx+zRKYt+RJyaz0zv9ux7hxWNEdzZkWjXwulvcO4KiJvyMoSzKRoz6iUJzFOydOfmS+56sNJ/j6yrVhMgerWWYTqpbqMg620+T7N5zd16JBRHYm8jtTFQEJOlsDAT58RWe5tmt/peD3uALN+qKDltioPWLcCyWiG6gQ6r4m
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 11:21:19.1057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e48bf15-be1b-45d6-05f9-08dc39e1b7c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134
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

The below exception observed on QEMU, as it doesn't support
NAND controller.

"Synchronous Abort" handler, esr 0x96000005, far 0x17acfc878
elr: 000000000803ad40 lr : 000000000805f438 (reloc)
elr: 000000007fcb4d40 lr : 000000007fcd9438
x0 : 000000007bbfc880 x1 : 00000000ff100000
x2 : 000000007fcf059c x3 : 000000007bbfc870
x4 : 000000007fd9a388 x5 : 000000017acfc870
x6 : 0000000000000000 x7 : 000000007bbfd0e0
x8 : 0000000000003dd4 x9 : 000000007bbeec0c
x10: 0000000000000001 x11: 0000000000003f8c
x12: 000000007bbeecfc x13: 000000007bbeeeb0
x14: 000000007bbeeeb0 x15: 000000007bbee474
x16: 000000007fcef18c x17: 0000000000000000
x18: 000000007bbf9d70 x19: 000000007bbfc888
x20: 000000007bbfc870 x21: 000000007fd68ddb
x22: 00000000ffffffed x23: 000000007bbfc878
x24: 0000000000000000 x25: 0000000000000000
x26: 0000000000000000 x27: 0000000000000000
x28: 0000000000000000 x29: 000000007bbeed10

Code: 927ff8c1 924000c6 8b010065 f9400887 (f94004a2)
Resetting CPU ...

Updating the correct return codes rather than hardcoding, remove the
free as there is no memory allocated using malloc.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/nand/raw/arasan_nfc.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/arasan_nfc.c b/drivers/mtd/nand/raw/arasan_nfc.c
index 426160c384..d78e9ada82 100644
--- a/drivers/mtd/nand/raw/arasan_nfc.c
+++ b/drivers/mtd/nand/raw/arasan_nfc.c
@@ -1232,7 +1232,7 @@ static int arasan_probe(struct udevice *dev)
 	struct nand_config *nand = &info->config;
 	struct mtd_info *mtd;
 	ofnode child;
-	int err = -1;
+	int ret;
 	const char *str;
 
 	info->reg = dev_read_addr_ptr(dev);
@@ -1259,9 +1259,10 @@ static int arasan_probe(struct udevice *dev)
 	writel(0x0, &info->reg->pgm_reg);
 
 	/* first scan to find the device and get the page size */
-	if (nand_scan_ident(mtd, CONFIG_SYS_NAND_MAX_CHIPS, NULL)) {
+	ret = nand_scan_ident(mtd, CONFIG_SYS_NAND_MAX_CHIPS, NULL);
+	if (ret) {
 		printf("%s: nand_scan_ident failed\n", __func__);
-		goto fail;
+		return ret;
 	}
 
 	str = ofnode_read_string(nand_chip->flash_node, "nand-ecc-mode");
@@ -1289,26 +1290,26 @@ static int arasan_probe(struct udevice *dev)
 		nand_chip->ecc.bytes = 0;
 		nand_chip->ecc.layout = &ondie_nand_oob_64;
 	} else {
-		if (arasan_nand_ecc_init(mtd)) {
+		ret = arasan_nand_ecc_init(mtd);
+		if (ret) {
 			printf("%s: nand_ecc_init failed\n", __func__);
-			goto fail;
+			return ret;
 		}
 	}
 
-	if (nand_scan_tail(mtd)) {
+	ret = nand_scan_tail(mtd);
+	if (ret) {
 		printf("%s: nand_scan_tail failed\n", __func__);
-		goto fail;
+		return ret;
 	}
 
-	if (nand_register(0, mtd)) {
+	ret = nand_register(0, mtd);
+	if (ret) {
 		printf("Nand Register Fail\n");
-		goto fail;
+		return ret;
 	}
 
-	return 0;
-fail:
-	free(nand);
-	return err;
+	return ret;
 }
 
 static const struct udevice_id arasan_nand_dt_ids[] = {
-- 
2.25.1

