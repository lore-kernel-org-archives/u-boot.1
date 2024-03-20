Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FC0C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 11:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C1A587D91;
	Wed, 20 Mar 2024 12:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rBpXHZx1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1222787E6D; Wed, 20 Mar 2024 12:18:46 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF1E786564
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 12:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRmO28c5oHbK+OKEWToQkMfhJ8Bv/Ng1kj4wx0QL/zcWRzjKIAC7A5wHIrLyjgT0+mVPYN/gTi8MWK05BYoU4HRdm2+n97WILqDCKEeDNlo+sWEMj+g56dlffNj5wan9aSuUFp4AcwGgrzVhqIPMIQmxHzWTYu2RXsESyexDJMIOudm43HSeQCfJmNBb93EP8RcE5KqDiTerygZMcRHhaK7Kd5EyQDJoZhkGm25KARc0nk0BOvHHiJQb7/lE2Ej51fFJ5NhZaGy6a3szDB+ucwXMak6EjWgLZwMyFP0yEQQ732lX3UQZOF9TC2wZBKro55HSmjPqxriMlH25VpTCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uhrv3oJWJkani4nPCG4R5jO8c1TXSkxSJpm09IGJpc8=;
 b=g6Fx0mZ0I43uaiV4ilN6+CpagqbsHlBMA0pdZuJ6rCtBfNqNcPeRLWlv5ZNgaRGHghfEzSd45Tbi3vAEwpXSpZpFVOWsDPGOcMh950HpTXLKk2pFh1c2avgLIOfsLNO4d27jt26B9/w06lpz7zcs2W6ff42yweAwz4V2Qu9uC/g2KXS/8vzHLyQWe1kwK+89h+nGJSF9kgT6KgVH/sTzSYk1V8ugNg4znPT+HFDAIV06F8TwTYdEy5UrwjjXOvtLXu/75Z/vpLf1OyA5NIslDsdZA9pUusy1chGiqQrC98v9doEpa8nVfcLOg1DfllAqa7ifc7x1tWlpqCCn7Ma5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uhrv3oJWJkani4nPCG4R5jO8c1TXSkxSJpm09IGJpc8=;
 b=rBpXHZx1+OT0xBWAMRuHordCQ6oTf+yeo1CYw14bwfDIVlacWd3fjWYhuXGdrXVUifMYNT6Hsny0x1JOliSEHXmY3zXu3ZOM0uF7XqwX+GyxfMvFIfdtoz/HMw+XWrC+Z+7b72d6HD+LBr2IBMLXbpgNJRrKqZ3voaj2/nqVteY=
Received: from BN0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:408:ec::7)
 by PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 11:18:39 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::5a) by BN0PR04CA0092.outlook.office365.com
 (2603:10b6:408:ec::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Wed, 20 Mar 2024 11:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 11:18:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 06:18:37 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Sean Anderson <sean.anderson@linux.dev>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Also support JTAG as alternative boot mode
Date: Wed, 20 Mar 2024 12:18:35 +0100
Message-ID: <ed51a9d51948ab939a53e0b9dc6c2d2546f97a4f.1710933505.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=KnZ2Nl5ebFziqPo/sej6kxB6eVX/Yy1pgJNkAMBbZmk=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtRfx5jmfZZhYy6SqfdPLPTtWXyDI7zm2SLxG21uUs6n8
 8q3fNrfEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACYSa8kwP3tKmF0ht9PqbK1J
 By9eWdSgxDjHgGF+ekLbjlxB548K0WnxvIyW7Oc/pFwHAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|PH8PR12MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: ce976370-e918-4f6e-b25b-08dc48cf7e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLplkyLdBz5QQKQB7IZVcubBUuV9M36iZHsK0bVhT+193zR0xChPC+vvIw8VNnzZy4O865KdiIJCcg5Z/t7Lbxl0OMi5BEFQ1P947tzRAMjn0iJcH2rjgRWcoM0fHy5/CHs65az5EqAM6JUsmHRMiUaoqo9tEdTAngEpZhkbLRQJvu7Ypyy38QLm0d45sjOfGHx/lPXthuV1zD9O4ZMxqqAdMYHcSK6FFVlV9zZagTPI/bJTaIJkrAkc0zRdtSIK5h/HS8VHRngSijtKWOFgPLNRMJoFeimyXd29Fw/3ZBkPeDqwPHxMgu2vX5ZrebgLwcg5zbU2VfbAcwGSOFlDgaXObNol1HWiUXHAMk/z0+BbEceRy3291/nhrtmQRN23cctM/ZJHpwyRiY84KoFLgokwiQG9DikoNV8vu+YIeGo9vnGljhTFZcAdnD4M8fgYaJ/K/j7ZKLtx5V2ohtwb4Lml1cdERy2PYxRWVHJ5Pd9UlRg85as5QxhJnn2d1EEYLGtClVZlkPk7aYKWgUsHgQNvtt2Eeqi3pk348YFZW38VZYkwL+oIv5VjNI4vVeBbXkYF9PgAUDQVKncDGJdO2O/zLgZ0RCuNMojhma9dOQzDT49/1inwR4a9BxuTUxEien2PH+hYAimkV5tkOCq7hicWvfIbYCfBlD9+ibLgCb3oHhluuFSRc2nwK8ce4hFSPJwkzPVZv6DMNuHddyDydcCVy7SKQqomB3rYo5ocRvcxxjJ3UuOJe4lkIuX//X7q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 11:18:38.9818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce976370-e918-4f6e-b25b-08dc48cf7e11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6748
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

if (reg >> BOOT_MODE_ALT_SHIFT) condition rules out alternative jtag boot
mode which is 0. When 0 was used origin(HW) boot mode was used instead.
That's why directly fill reg variable with requested boot mode and don't
let code to read value back. "else" part of code remain unchanged.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-zynqmp/spl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
index 5af735aa5cef..979ff3aef6c2 100644
--- a/arch/arm/mach-zynqmp/spl.c
+++ b/arch/arm/mach-zynqmp/spl.c
@@ -91,13 +91,14 @@ u32 spl_boot_device(void)
 
 #if defined(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED)
 	/* Change default boot mode at run-time */
+	reg = CONFIG_SPL_ZYNQMP_ALT_BOOTMODE;
 	writel(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE << BOOT_MODE_ALT_SHIFT,
 	       &crlapb_base->boot_mode);
-#endif
-
+#else
 	reg = readl(&crlapb_base->boot_mode);
 	if (reg >> BOOT_MODE_ALT_SHIFT)
 		reg >>= BOOT_MODE_ALT_SHIFT;
+#endif
 
 	bootmode = reg & BOOT_MODES_MASK;
 
-- 
2.36.1

