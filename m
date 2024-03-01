Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C498CC5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 11:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D60B187E11;
	Fri,  1 Mar 2024 12:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zqtdzYtn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECBFB87F73; Fri,  1 Mar 2024 12:13:15 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0990D87E02
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 12:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJUUDeJ2ut1SoO3BtM6+6xe8tMAc6BHQRpGhWvUVw/xo81DtDB8vebAqiiAYrCLo2Wl2VPFqVCub6FJIdV9PTW2Irv1IRwbuw4/TG6rFhERKbMHQGXvYwRnXIB69uIdtgYsDma7abHnbJas0ApGGEv11CrA6myuLThSnxa3amSSsiksz6A8RMvDDzVJdBalhHT/LWiooSLUe+YtapJR1aQ7ASjH+R+D4+ptnhGgz/Zeho8ZIi1RaNdcNeiEntmDzungtDHi4cZ1waBwLlJe7rR/FOujj6E8R5aJi9b2VDS3qajaeC/nAnDGlPHOKHmWluxcB5LSIA+KiFYMLCLAs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40hG9anWQ35gwoNs3zA6fxhm9dHa7hDl5qRBmJOKjyg=;
 b=HzEcJNVro2UtKP7PLVwTo6sFLBaUNLdyWOvX1au7Fg/WSM2OLe+9RFwm16WriNdMr9zQ56EvK4msFqk9tVaiwyVD6+EwWDYlPSTaqAXiA2Kku8YfHEI+lMu2BUBJ9yw2f+X7HemYSbybV/ygsdSALOGvncEaCMlGzImcbQ4vvt/sG0D4M7JS1/k5EOwwVixyCfTarqxy6JzMY3XJtxoEAsAtB6qjadmD7M+6oz9QGQSmgP8+nKwc9K1U4aqEuH5r4VAm7wUKWF/nXZuwb0Zj+WAiTPmDfwVPb94Ky28xtXUvX1mVkIGQyeQWyDJjBxGtSOtH2e3lI0F77jyufi17aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40hG9anWQ35gwoNs3zA6fxhm9dHa7hDl5qRBmJOKjyg=;
 b=zqtdzYtnnKqmPuOtZxvLRke1GJJzhKqS7xupsShmP/hKtyjEMwmjukvu8nyP9O8S5TiUkuxU2pRED2RjHBXvYFGo+RGOEUfEyiw5SZM7SR05EZUy+hmLRAfacE3JGAH5rQTpisFy6+IllpuCEK4JX43CvFX/ou7420ssRgq7C+w=
Received: from MW2PR16CA0055.namprd16.prod.outlook.com (2603:10b6:907:1::32)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 11:13:06 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::d3) by MW2PR16CA0055.outlook.office365.com
 (2603:10b6:907:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34 via Frontend
 Transport; Fri, 1 Mar 2024 11:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 1 Mar 2024 11:13:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 05:13:02 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Mar 2024 05:13:01 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <michal.simek@amd.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [UBOOT PATCH v3] mtd: nand: arasan: Print warning for unsupported ecc
 modes
Date: Fri, 1 Mar 2024 16:42:54 +0530
Message-ID: <20240301111254.3588162-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: d5739c5b-aa96-4036-69a3-08dc39e0916a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TS5lE+SycCNN565Q2WurIXHALQtzkt+rDgR8G4FD2qXd9Wl7zoIVraSxmmJCM9Dp3LPfesGDxfLXLL4Es7fz+l04iTvMWkb/8FAcHef1coUIzJny2yxs+flZETLVmpgVGF1PL5A2CEXDIEbVme6a+IXEKrX2VNTYMaQ3YORnOvtNA4I0AugcGAWxg1dmhpFTvscWR4xf/iLJkhrMYHvFRm7qFitgjsnfpxq9fIE7H3tBcJFKOA61LPGCW/qWX+slMUI5K1BtynG/UfnVNuU97eK/NR+MD7L/1xGIe1GAHdLXcYpmKQBDopNTGLM4bZku3JhVc+omNWotpfnk9Z3As6PS2GDFC14B17K576ZZBRf3iLBXQmR2tuUkBZYcA+nvlWLlvc8joyGs1bjLucNNg8iwjhhXrVhPMD5CgvxtxXAYb3KiWji/uydd/fJ/JZ+uYQqVQIibGgHGENi+5aKimQ3LUdRxoH1ePPrBRr5VaxM2y8g9TXCDvgtNEDl568HdZ/dYNfouAShg4HgDzxEPN2Fhuz/LF9oOpbE3tp3csZBQhGFwkVIP/1KYWC2tW187sK1tb6VK4/ZoHBnWUHvswOUmM9P/w3TRVpOhIjXc/L64oZLoRu7H3BF5l3xciRh0aNfpCTYu5mldq2gt+FnpLIEB3my2apdebWy/MBtAOYp+hI/hpHRwNq/MHgWRK1a2obI3X3bUH5uxk7qgo0YqYByfIy1QpavsWzIQGmBFBnNkw6AtgrUDBzDdxtDAnGuz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 11:13:05.2239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5739c5b-aa96-4036-69a3-08dc39e0916a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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
given in DT, it simply ignores and switches to hw ecc. So better print
what is being done.

Revert this patch once soft ecc support is fixed in future.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Added the ecc mode check in the arasan driver itself.
Changes in v3:
- Skip the driver probe when sw-ecc mode is present in the device tree.
---
 drivers/mtd/nand/raw/arasan_nfc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/raw/arasan_nfc.c b/drivers/mtd/nand/raw/arasan_nfc.c
index 14766401bf..426160c384 100644
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
+	if (strcmp(str, "hw")) {
+		printf("%s ecc is not supported, switch to hw ecc\n", str);
+		return -EINVAL;
+	}
+
 	nand_chip->ecc.mode = NAND_ECC_HW;
 	nand_chip->ecc.hwctl = NULL;
 	nand_chip->ecc.read_page = arasan_nand_read_page_hwecc;
-- 
2.25.1

