Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED40CC27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB8F881D3;
	Thu,  6 Jun 2024 16:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jt86uJxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 932B788395; Thu,  6 Jun 2024 16:36:03 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 832658806C
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqwUusSdrBKZeyrjf6CjKsOyJjOh/X2UxCuPYkFM3XRm68HIVuOrpH+dMDGzkyIdyc1WUcPrH7XlfugH4XTxleDAD8QWYY96ROOISrSyXIH7dvc2lz8ARBbOzYZzE91BCL7Ga2awH4m5XGlvGgyhsGyXHE0uuwpjlngEbHK7HDbXi6oGzsQXwiDhFjPrVIKb48y4190VU4BguzYa4LxsmcsjLPTCfm9+ktTn+M5AZwLQRCvsOc03Af7CMJDXZEH9Wq/Bv6xnTxMHn0CpVE2AyIyhrAQHGUg88LPbq1TbrBNEomhezAXt6RfNreTmoi+GHNMaOhueC/AZIFkiZc8c2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1WDSpK2ZjUPiIGVpzoVTKrC6NPIOglzyBPSdnr/JW4=;
 b=YpsBhMJMI0NUcyf2R+L9IWVGQXic0gkwDcJkdwJFvSQQmhoSX+pz9KYrI7Qb4QSqgA/5Fp78Jug1nilvsMTLb9Qx649HEpz2VFTcEqU2saLQVYkn8Q5+N0TYmVL/pzFnMozk0Grpi/SG5dxYOdeuwNv9hxrLDkO+e+9sWdYBPEnkBmmAE5VwKVuSoksCo0tZH7LYoX9yOTFcCsExdjpk/OoRUkPdpm9IHyshNeZLFfp3lBc8W7ovUAsswg4z3njTaAludAjXkDqpyC99uBL/Iu7F5YSYtEk8tJsQhYTSRL9y9E2a8UEwmS2Hzsxupq2hG4wG+6Bua4JGf8VQrP/v0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1WDSpK2ZjUPiIGVpzoVTKrC6NPIOglzyBPSdnr/JW4=;
 b=Jt86uJxaibxDSDyQBssUjuVj0vMqAQBWLvlNqUWARcjFQFGASEUrCHh5tQczBSV+875YQCssARbR36IhIn4DYAuDu6lcB6ukQwdZGdOW3ZcwnCcruqYWNa2YMq2ZrcGdQ9z1EpTuBxkfYwOXGD67z8ZZV0RbhTac5a4kcuYLXAo=
Received: from MW2PR16CA0037.namprd16.prod.outlook.com (2603:10b6:907:1::14)
 by CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 14:35:58 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:907:1:cafe::4c) by MW2PR16CA0037.outlook.office365.com
 (2603:10b6:907:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.19 via Frontend
 Transport; Thu, 6 Jun 2024 14:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Thu, 6 Jun 2024 14:35:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 09:35:56 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Align #address/size-cells with node
Date: Thu, 6 Jun 2024 16:35:50 +0200
Message-ID: <3916fde2e896b8be8863505305118903e0644ab0.1717684544.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=723; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=KMBl6XeyUChK3SUiTIA6UzspEB3x8JjTGec27jxgRBU=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTEk46PnZPtJmbKek7Yo7RnH+ehjZNjW1fcn1vjs5D9e
 JHLlDCJjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRlv0MC1qPfD4/Vcbyi6fe
 oo8Sv1j9Fq3WesgwPyV+RovSk6zzE+Jmdd/bFCvIcyOxGAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb0b959-b485-4082-76b9-08dc8635fb57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vTy4Uv7zmkYIRMJt3sBWQNZAVSC6XzC7dpQLynRobj3C6i+z642CgNrke3xw?=
 =?us-ascii?Q?oeLRzxMFAwVZQvL947ux2HpagweagyEe6fWp0S5Qbnw6Z0DXRzH+tgf8wCDd?=
 =?us-ascii?Q?KwDiveju6jQq6FPTPrmPw7wM+1EYiN4Q/KFVDDL4JG9VNSk40DVymhhUJrA3?=
 =?us-ascii?Q?5pUNeaQueV+9g4DxmHgFbbQmty2ohteV65Ab1WTH6+09Xu2/vTwO9+EZYz6T?=
 =?us-ascii?Q?bo5P8bh5CBcT5poLscSuToRI4+TX6q5IDuH0jA/a7TR/suFrvdWbfM0TahZA?=
 =?us-ascii?Q?5/+cwEppy2e7rExMja2ec57l6poJjhMY07uw5aaSe8hTxa8NEUr+V8lfjbSK?=
 =?us-ascii?Q?MFyGDPloPEEA4F9F+3g89C3bN5xiAlw+CndXwlCFuG9RoLulYW7Qav8l+tZi?=
 =?us-ascii?Q?HrSHSZXsk0oCIoPC21pouwgjqF2eLSx4GPjNANlJYQzyS1q9b5MCwL1EKmbV?=
 =?us-ascii?Q?C+TbZyhfLBS03w17/niQ7+nIBHUm4/hyk4haKM+MVYZANjjfae4yId+sIG5/?=
 =?us-ascii?Q?grG5kJ8Azv2p0T4ePWi0oDGFFWQq09Bi+Zb0RB4+z6l6/L5cU+eS9mGstCiN?=
 =?us-ascii?Q?RRmhz08aSSttSOTIsUYzM27Pc7b5nD3+zoVjU2fxxrlgz0xz1x448piTnxdI?=
 =?us-ascii?Q?z/yfThkKqJ2p1f7xz6YaQK0w/igvNmesz/Qm0nazk3OzDryUrkQp+Q9qUoFe?=
 =?us-ascii?Q?z+24Cd6R6FzIeffFhZfF768p4AMEoMQZ91FwyKfbBBeixubgiKZ2uB58TGNw?=
 =?us-ascii?Q?TzQ3zR39shyTfK7I7Wa8J743ozdw4Sf/tIRIFsQAy39kLtfX2YB1APkRb9bW?=
 =?us-ascii?Q?OsFjCkIwYrtuZX6qIGP8EQoYSS6pyScf6xy8q7Moxb3Za6Ba7uUG4XENdGQL?=
 =?us-ascii?Q?DIY6SqrsMEBxSch+R8oKkgTK2aDTD+brlVAZlDdLN5j5ymhxAM2ujUDOGBno?=
 =?us-ascii?Q?b3nLYpAM5q9xleB7dTgyp2V/Kshb9hIJv0PSoeHkoiSmttDDjufkNB6Rdq4G?=
 =?us-ascii?Q?GpSw+fOoG9jUQWixsc5zPBXNZmS/3JwwkZcr+BRncfcHMcG98jO5Sv/Z7szM?=
 =?us-ascii?Q?UVVv8adpPDBgkdfCQqSJ5g+SCT/j6H950jNMSBKPhf4TSG+KbBRAKrmRV4XX?=
 =?us-ascii?Q?ESRaa/FGp8g0vv92m8+yshuR3OEwiaaC2U5U3tKn5PSFVDPyZPZ0bKwfEnEu?=
 =?us-ascii?Q?eQqWK0bKnXdfXjL0+n37l19WmPSlLCxcLzFHBKOK/GSk+OpBTZieiuplPtCh?=
 =?us-ascii?Q?Xdz1viWG/cdWx+PrltY6cWOvoHsoMD+oLJ12B0cUs4XGx3w0thdWkbZvBCWm?=
 =?us-ascii?Q?KbGlKl7nvvLKFNjtwIWH7TuhVOMlEWpCYD5fwJz0Fb+H5JEBeSu8Ip2NnaOV?=
 =?us-ascii?Q?dbPfKvlW8x/HSCC7T1mlBVg7AC/lGtUk1iX2kW8KiKK1IZz/ew=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:35:58.6250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb0b959-b485-4082-76b9-08dc8635fb57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991
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

zynqmp-mini-nand wasn't aligned with dt binding that's why fix it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-mini-nand.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp-mini-nand.dts b/arch/arm/dts/zynqmp-mini-nand.dts
index 5889d436edb8..e08a7840d8e1 100644
--- a/arch/arm/dts/zynqmp-mini-nand.dts
+++ b/arch/arm/dts/zynqmp-mini-nand.dts
@@ -46,8 +46,8 @@
 			status = "okay";
 			reg = <0x0 0xff100000 0x1000>;
 			clock-names = "clk_sys", "clk_flash";
-			#address-cells = <2>;
-			#size-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			arasan,has-mdma;
 			num-cs = <2>;
 			nand@0 {
-- 
2.40.1

