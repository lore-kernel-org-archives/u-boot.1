Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA629C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 03:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD8787BAF;
	Wed,  6 Mar 2024 04:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0uhsxeI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC8B87CBA; Wed,  6 Mar 2024 04:34:33 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62038879A0
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 04:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsHX4ZPBLl3ev9TImv7KVOrSLdMQSPvru7PQYkxmmx0WRYshA+3pw8Wl/tA6Y5NkKNhk94Y+3NspUfQTAKsUGYrpyKUE/w3lw8LrLFqljY3nGcSS7lLFnEHmIcrYADzIUOS1M+JoRa7/Pa8agIrnpqENZvEOl85l8LTMuujx4z5zpN5HzAXpR/6ROJZD5JYuoBIX9UvXJqgi4hT+AwE0GmIhuzCEuXbh59wMwL2wledUSmTElSQmgNPuI5KqqYzkwu1bWS4QjwUI0i+ltOv6TbDkwAneKHZwGh9bjvHOpVk3X5gFP0+K5FB3SulEFcc61INPMkGZu7SiJBU2R8cQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGiAm7UXlzn+20Q8VUNsTx6bapzpTeu11xTchs1ozyE=;
 b=m4rQsMENv6iN26WBFKaU4/zlN8ThpBY5pdeV42TtqK3aYEMyBXvWACDFwTSvE84sIuZzo3RE+g6XTZtKgmcaBhQGmJtmTOOKxwp0ydIsxDFFqSt0I5FzQnU5vEVQPqx2HePmR0jwX+rqW0DXCHvOAWF1xX+0VZyGmTgY/GXczj/JHwCWuxk3ju9hoLvVNbAYfpELtIkxZecy4z4jKLuzudUiaUYtqZbuWKO+BtY5Pf35JPoBj9kNhzfBfDU76Pw/6oJNiS7qm8avMNnLqXHGKrcaDoa3J6X0TISpYOiilCXIPdJEj44Yv8UWpq+tVtkvfOjOhgClTq2+RLsj8LHhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGiAm7UXlzn+20Q8VUNsTx6bapzpTeu11xTchs1ozyE=;
 b=0uhsxeI+mQDSfVUs+T3cjXjpw0zaDd5qztor1flsX6jW/BolwwQnn8+OxjizA84NfHo6kYgGUH6BNGMsAlIN+vCvtPjn2swgUx2qa/DzSGewqIfCRDBJNugDTvQZ3KYI4vvMqvIbMNJp256tKpB/3reYc9bEd7+fzbTB0iOZ8VQ=
Received: from MN2PR22CA0019.namprd22.prod.outlook.com (2603:10b6:208:238::24)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Wed, 6 Mar
 2024 03:34:28 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::4d) by MN2PR22CA0019.outlook.office365.com
 (2603:10b6:208:238::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Wed, 6 Mar 2024 03:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 03:34:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 21:34:27 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 21:34:13 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 5 Mar 2024 21:34:12 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <michal.simek@amd.com>, <dan.carpenter@linaro.org>, <git@amd.com>
Subject: [PATCH v2] mtd: nand: arasan: Fix the crash caused by use after free
Date: Wed, 6 Mar 2024 09:04:04 +0530
Message-ID: <20240306033404.18537-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2aaeb3-d775-4012-2b59-08dc3d8e53b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEJiqoxHD34pqKDbSXwIlaMB60VcEkkraTnzofCficDGsL6R6qIdZkO6CPVSsi9kCSkcfRsQTntRy2U3geduo8iy8vsQEjElw1frdmrXQwymwCGvS7K9J/Gh8RR4oMoFLA26aSeKi13iq8w568UZGxwmatwKuoLdcKb4Y/aNp7HizwMDszL1rgvsxYYOEzLkT3EnILGsJDav1wLqfTbzKSUt9MzPEUXPoLXbNHJpNjqXrIT2Y10XAtoWVg2zgHyoi4lYMGg1SV9AKc453poFsDLlQXznSf0/hmpds7fKhUK8wJ/O0D71Q0S1CLYUOD68S3drlwTSJHfeR5v9N3vkRBM7ttGwAEbOpS0Qg98IBz5U20lH33ZsxEaVuZ9xQmmb/tZflH/B0Vz/w4jeC1xyqc6jKS0JrkgXOTK5sgBzXyPeDH9GrWMm3gGyITin4/nRawBNxBCnLBuhx9l6/QXDHgiIFKbjbCvx9JyT6E7qQvvbk7w40/vT8X3PDa6RstXWbTyGnsC3IqVakNWPX4Ukm3Js/uSgOClb2DCV3U5ma/nJMZ4Z05eOQSKejiVWLjZSYYNoyL/S3TzS4RqZPt4d3ICF4+3ZCyQhEh2lC35GzfvJU+sc9wyAG9adrF8JqkuVJa4IOX215H7zl2w/iNb1lJSt5LbgfmJ2P07v7aPkbJ91PU/8n2ChQt5gyodmvS5v9pvy2C6MH0phHrf+aPWK+S1FR8FFrB1mUmAQedW5xSRHX377pR8wSPoWK8wcKJbk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 03:34:27.8265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2aaeb3-d775-4012-2b59-08dc3d8e53b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035
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

The crash is caused by the use after free.
Updating the correct return codes rather than hardcoding.
Fixes: 3dd0f8cccd6d ("mtd: nand: Remove hardcoded base address of nand")

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Updated the commit description.
---
 drivers/mtd/nand/raw/arasan_nfc.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/arasan_nfc.c b/drivers/mtd/nand/raw/arasan_nfc.c
index 0b1b91f771..ffcd963b3d 100644
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
2.17.1

