Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648A9C4167D
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 11:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6966A8769B;
	Wed,  1 Nov 2023 12:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YXSVWprj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57AFF876A2; Wed,  1 Nov 2023 12:22:35 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DECE87679
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJDwSlrIaPb8WtHzhoAVFwxLwZj7qHUoYWP8950yHs8oAhHDHc4PUmPVvUfhbhELjBDPGYh49mAGBmCe/iuKYvMMsHQ6gwGHI2lbYVqskg6OYJQfhH9+fozxTWUx04UJPSP2uLHnUnUM7iIA5Etlmu8yciGRFe6Ldt7LpQdokvRvWIFWZvg9OPua8upDVk9+xg91qkiAW3sbzr2diF4/v2q2pfJKkwWKTLb/t2RPquJqKDZFNgbdlLctQlvNsOs/IbL+oxcIACKoWVpFswWucKQOvz3fX7Rr715pY+SC+TTxVnYU5SVVDiOH8lJJKoJS7eon5wmxM9gdy01vKWMlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UnqjaRA+syM0MYV7mCaDq1iyL5nQ8bYFfNY92H01c0=;
 b=UPLpbTsmrM+4sy6r1Gn2q8UqJlRdpE6vbODHtPTZEDkavJdgjYR7QjzKAbIwjbgqR8Xj1igVQNKLB83r7GLcgxe51zOOEROa6gQA0ePaZbrg3GsLn8aZ2U5dyY55SXiTq1eitD4o4l+jOfXoT7tBlnB6gkWE6f6sKZywzZF9pmflOQg/NEzdGG9cVsbT4y8KrlUMDWWhgit8bI8VU59vwMAZXjgl8eiQdKHEaNlEoWV5nCY1eMfvR3omFC+XLzlJgO9AdA0KrMKg9DeqO4phFw6wkHHMg6Hk95PagkoQZSOgs1jOD8Om0UmUuIae4PPAv/dC/ZcOv6KhElDOnej8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UnqjaRA+syM0MYV7mCaDq1iyL5nQ8bYFfNY92H01c0=;
 b=YXSVWprjTFY9moQk9nRG4Oh5kJPbBhQSgtRZhkuegp74QBLLIX9ANg4Z5ONmqL/HJFJ7bkFJX3TbGwOfs8bwgnYQvmC9Dqs9HUD6ON2ojZD1GYyxExn3ygbAkjeU997T+O7470obYUB6K/hQZxWaj6+0J4aGYtS2rVq+tF96wRE=
Received: from DM6PR07CA0079.namprd07.prod.outlook.com (2603:10b6:5:337::12)
 by DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 11:22:24 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::ee) by DM6PR07CA0079.outlook.office365.com
 (2603:10b6:5:337::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 11:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 11:22:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 06:22:22 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 1/2] xilinx: Enable SPI_FLASH_MTD by default
Date: Wed, 1 Nov 2023 12:22:13 +0100
Message-ID: <b3c4a3eddb71aab9535b034380d0dbae770828d4.1698837725.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=666; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=mDmeAfS/CLtUVhkRydc0G5sYgazYKDlFHZAgJt27jaU=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQnk3ufelh9Jzve+tkWPsfprfLyF3YRLaFHT/V6rmP4Y
 uknr5DVEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACYi+4dhfjaj+A3dOeFP33o8
 svWKtTqoLHFTkmEOj8Wy8LanRd8a435P09nx8fW5PvONAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DM4PR12MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cff2ac1-618d-46da-6dc5-08dbdaccd267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFMzDUhhIppewtmOW/1DWPamFKjyURFhwGeG83nMTbrTpL9sVoGNmowP3pkXAYypqhAstWAww4S6f7x7cUufFbOxopbuZ98LX4X9sUsNa2OJ/496+ZChiBACScmd2lbKXtYdr9F1Qz6Zj6m/rh45pF6yACooCTlFUks8nBO8dAMcCB76LL7Lzn1FHWhG3F2Q1Grf2dvP3tRKERv2FHhWxD0BEl0WGgPXsHeu+1qNofNJMDv3KOHAFU5dymSoFWBxQuAduLpDxlY6u2W1qigVCM/0Fz5FVwyUCQC6+RhTP0EkfjMlM89NQhnvth3qp6H7clUgKuCr/O4R/9vVyU7Ap8NoaqDAzSn1OLTigl5dXrIvfUF2jL1mTVq31EAodq8BtFe5se0LZM6Xva+xU7Ep7yUg44L7TlvdFjSNQDP+7K8V99n4pABwi1smnLlSMTL6b9NLKEcleI9/O5xHmAwg4Pa1ShlT1U1xIsa96EiN5/7FTV2zfqilc4Jua26/jSj9XtLrGQbFDV6Kg3MIOhygp2oh4UyWDkGTgydE2xAXz0woXm8CqdmmANp02wNyqO57g13wx3asepPxSKyeIN4n0JFe+5Oyl0b68WKwt8vks5QVSafaomNVJD2gLt+ZCEZQKuc0UOIzsLp/AVKBbz0uk7rshm4QDh1A4yOOSe8Z50IVPgjArsoKHr52MhcTc0B230GgMe4f3ie30SVc8Qc5h8XuyOShBP6OXq5n10YMatOJ2qQlhr9S3Zj1EhkMkeZnt/VxzG8QfKX5eioWmbLFMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(40470700004)(36840700001)(46966006)(40480700001)(26005)(16526019)(2616005)(40460700003)(36756003)(86362001)(81166007)(82740400003)(356005)(336012)(426003)(4744005)(2906002)(83380400001)(5660300002)(478600001)(36860700001)(6666004)(47076005)(8676002)(8936002)(70206006)(70586007)(316002)(44832011)(41300700001)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 11:22:24.0296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cff2ac1-618d-46da-6dc5-08dbdaccd267
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
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

Provide access to qspi flash layout via mtd command.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_zynq_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 6145af62b511..c3ee9beaef25 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -127,6 +127,7 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_SST=y
 CONFIG_SPI_FLASH_WINBOND=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
-- 
2.36.1

