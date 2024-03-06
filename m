Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13CAC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 03:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2CF879BB;
	Wed,  6 Mar 2024 04:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ym3xFbOi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47846879A0; Wed,  6 Mar 2024 04:27:20 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8239787BD6
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 04:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ6UBitdvOAI5Kff9RGzWb3xBC3/74icsAHOy8P9odGHaTaAuCGq6xMY/DFIxIhN3vTP7qiCuDL4lcIp2ghyhi2eDbGb+6x78/zw4PYfJhP9T4BtMbdFxXrTjE3cJEJcKj0ntjSWllJLAoIg6Z0FUeEJOmEx0iLM1XeniwSbqv9j/erZpuo8RTjpc0GKSpvjoeZLvDEhhoL6Tas3AMGqtSUnLQ15FvqGERkki9XJ1pnCj2C8oL2M3UbSHS0ySH1kEMVouQJdV+6cP5KX4g0l280EWwgMXDNtYLK+gKaVs366EK4J3QPBqPZrA7B6/Fewnrcc+IIsgkjyKT8gTEKe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tha7jsm1BDlh/tYos54GwqP3gUSFKO224zGRbSoTNJk=;
 b=hAHbNnN1p+3nALPvrHgHoy0KvwLKrwSpdciRGljEYPY/mqapdUNOE3poUr7TD0lLO8qa/ZpOsbzD92vVWxzLbEr4q0mBTk3QlnO0piYjKAcU3ob60Rt/5G5esfdqRdVAo7cN2+7Qa8j+DLkW36NM63nTR0iAM18SUdO1Yeg89MiVCuK5oQwub8S3oIZMJdevYFLZHeQl1/W2YLQI6XpryWufS1xc9+1eFJzfAiJghSXFM5++zYRmKzjnCEjkN+G1s/DyFetst+2RaO6ZL/XLLihw530xY0fahMck1jAgGb+LYis8LlmyVcsj5h5dV6Lvfb0OaPjEWC93pnl1oIDmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tha7jsm1BDlh/tYos54GwqP3gUSFKO224zGRbSoTNJk=;
 b=ym3xFbOiyIvE6K0yRToT2UVcShD4qT+s0sslHiUZ9mZ9Wxx3aLL6xV6I2ZdgrgdjTMjPqU8YJmrchE2aizYZQfIwaed8pWtWpoMSebeySn3TsJaU3Q9AwxXFmoK3typeJ4EOji3E15BjbpJtu52D89APN4MVGLYJ6Dlekc4teHs=
Received: from MN2PR22CA0007.namprd22.prod.outlook.com (2603:10b6:208:238::12)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 03:27:14 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:238:cafe::ec) by MN2PR22CA0007.outlook.office365.com
 (2603:10b6:208:238::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Wed, 6 Mar 2024 03:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 03:27:14 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 21:27:13 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 19:27:12 -0800
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 5 Mar 2024 21:27:10 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <michal.simek@amd.com>, <dan.carpenter@linaro.org>, <git@amd.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH v4] mtd: nand: arasan: Print warning for unsupported ecc modes
Date: Wed, 6 Mar 2024 08:57:03 +0530
Message-ID: <20240306032703.17508-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf2ea72-dbc5-4a20-20ec-08dc3d8d5123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USaQGiKeOSGxeZrICfZf2At8pWKj0jKpeG2nHIx0jNEkNJJbxqz6JyZX5Pg0S+IqLsOSNY/eXtnmVAmcbGyGwMzLC8VBB56M7GEDlgdqCEYSUn5Zp0MmPiCahWZsz2U1SW1CxBRwpkClweGtAgQf9WuYHbunmIVu5F1ldLTEsH6L3n9QZROmxKBRwnUvZsfO2I0qABoEr2BBK9OxxIw8uhUu2a/c/F65tCKCsccWWEse0slFBIlnl/fKjuw3AebPehxA5BYLKpj4aG8Dvv+1K8Pw2u+j0/EGM1nwnNWWV3Lus8w6NWLHKD4HX4BoTNlUonW6YQXcgIwlj2DuMgFXsib8awRA+nHHgH7i58QIVzCNBUX9etwSOZy6ums0YWu9/U98F+Ufyz1oG4L8EDZaAMCbPgEbhASqh6mlz3k3ALQ9apFBZhEtJ6+1J9gVzdiw4LBZSWlxkJr0V1JigtjTaaeol+iqb4Pi7rLqJuGMqM4bj1xevVkT46AzaFTDukVJcXXyNPqxFxnHUGpUeZCnJyKhnYaxjn+t7h/m0nz13QLcq4/QUNguGWCdSU7j5fDjfMMHWmWBFwRTMOMzTT0wSKFjjqR6dBVfAPeiIEwwGyUcHa9w28g6BRBa5ADIlCO8VR6sKU3QVaElr5jf2K4EEauzpvnS9QPNYbS28/td9JWc/3U+2W/fuEHKguwo8YQrltCAAbeBelHfCbQFXjQPMSG1ll3NKUDEtS5mlhi3qC9h9n8IHF7mLvyDPjFS7FCT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 03:27:14.0238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf2ea72-dbc5-4a20-20ec-08dc3d8d5123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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

Currently only hw ecc is supported in U-Boot. If any other ecc mode is
given in DT, it simply through an error. So better print
what is being done.

Revert this patch once soft ecc support is fixed in future.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Added the ecc mode check in the arasan driver itself.
Changes in v3:
- Skip the driver probe when sw-ecc mode is present in the device tree.
Changes in v4:
- Updated the commit description to through an error if other
than hw ecc mentioned in the DT.
- Added the NULL check.
---
 drivers/mtd/nand/raw/arasan_nfc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/raw/arasan_nfc.c b/drivers/mtd/nand/raw/arasan_nfc.c
index 14766401bf..0b1b91f771 100644
--- a/drivers/mtd/nand/raw/arasan_nfc.c
+++ b/drivers/mtd/nand/raw/arasan_nfc.c
@@ -1233,6 +1233,7 @@ static int arasan_probe(struct udevice *dev)
 	struct mtd_info *mtd;
 	ofnode child;
 	int err = -1;
+	const char *str;
 
 	info->reg = dev_read_addr_ptr(dev);
 	mtd = nand_to_mtd(nand_chip);
@@ -1263,6 +1264,12 @@ static int arasan_probe(struct udevice *dev)
 		goto fail;
 	}
 
+	str = ofnode_read_string(nand_chip->flash_node, "nand-ecc-mode");
+	if (!str || strcmp(str, "hw") != 0) {
+		printf("%s ecc mode is not supported\n", str);
+		return -EINVAL;
+	}
+
 	nand_chip->ecc.mode = NAND_ECC_HW;
 	nand_chip->ecc.hwctl = NULL;
 	nand_chip->ecc.read_page = arasan_nand_read_page_hwecc;
-- 
2.17.1

