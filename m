Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270E4C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 09:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC96486B4E;
	Mon, 13 Nov 2023 10:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nl4GHNgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E0A886C72; Mon, 13 Nov 2023 10:05:41 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A1686B0A
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW08kcUuxRIuYTbrSHnDptO7Jlpk7AjQMVgY6KNJfgCHrfHgawzH3EhZoqeOL29wXUNCMDZgkJM6wis3deeUAV7i4vMVBkOzEHiPQrEXbtZ5QQst/KkYME1OZb2uakcvnWEzlxn3aABs9tMsH9ytkegDo9ATEh1SQFi0Z+JtuBY8Q0NgAxs63twj2XYqd2i6LsrqOYjYI/Mxhf6jnB+bZ1Yo0cdmuQ8naV/F8cjGXmHWnXrbjZ6GxeUW+XUPlu3yUx9PjOI0AtHNjX+dUaeweSGUhcLPxZRCnQrvKMBjvpKHn91Hugtg03sBGhoFs9Cg/sDklb5bhrUcokOVr3+/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIRv15iYC72bInT3lQiev1CKQTYoX1+CHUByrI/dBp8=;
 b=dZUlZysopZFV6HHahOBubKdv7XrY7Hf7WG43JzHFJ1RsxrIfx8vlrDArALD8mfMcW09Pf6gT+nWUT4KDBPLZbTdb32tptQYQN2UkX1/y4wsy/Nkplo5mcrvUH7r37fWuB4fOYz9YHefhIy9676UGDelTItcaNoQHjvMvzUqDLfC+REP/Jttcn+LYjGlqZ6ioRs3v3qiQMFnNP1w2w37zBek2IWDh8FkjXP67445NU2HIRueVDNhWfEO9WWBkYh3ImwAkZL1wCl32ndoZ7Pah4HPUOsXOhzownSjY/Flt/HbOItowLGzcL2knfjyu3ByXe8z7mQFRrrj7HFaHx21G3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIRv15iYC72bInT3lQiev1CKQTYoX1+CHUByrI/dBp8=;
 b=nl4GHNgGADulUM4cwxnFBAa40PwIMSvnzIFGu6UP3p2Xl/j3C5Jhq68zDifTQxa6E6FduAi5yntcSh5wmrxJhT4P8KSh7PRcdIKflztDZmtuKmbs/NT3er5an+5AEmc20qPJUkATc89Dwt5gZxs+YxQ9i0YgFUPOTLLKLQep3Jo=
Received: from DM5PR07CA0110.namprd07.prod.outlook.com (2603:10b6:4:ae::39) by
 MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 09:05:32 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::11) by DM5PR07CA0110.outlook.office365.com
 (2603:10b6:4:ae::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Mon, 13 Nov 2023 09:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Mon, 13 Nov 2023 09:05:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 03:05:30 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 1/2] xilinx: zynq: Generate dfu for SPI only when enabled
Date: Mon, 13 Nov 2023 10:05:27 +0100
Message-ID: <3ea0572dbda8f21270c00a77528eb6ec954c7c40.1699866313.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=989; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=tbPGwuudPKXHHgSqQgpmZ02IyRg2XRRoUvTPXpmZ1vY=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTAZydbIvv/detsZtCv37b0orHb5kaze6YH2/5UC4Y0T
 Rd72pDZEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACZS0c0wm/2m2+aXS83ZV5lI
 vJpimG0d2hHhwjA/YGe2963cHkuZ/U0b11e3VoQ+7gsHAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 88faea55-b5fc-4999-5359-08dbe427b07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBAcnOQRCyN6abWwwiOInoF58LP/DUizbF3gbXWP2IqGJ1lXhgitsaUJnTuKU8YnzvbW9sSR1UlJpuTxprdCuu4EHH1as8SY+vbAr45je2yQy+/4ZK218O0onRSu7NRd5n1kk+mRKI90S2EO0xeGWoDVeLg1mfDxWchWcAcQmbCVRo0V+jLaA/h/UvXdneQklVOVQlq95m5L078lbQYC5Yn7kTb2OsRQIzI+/uaL+RD4RK7vyxd+nmxqzM6YDl9sCO12uGz8FmTAZYdIp4FwmJt2uYZBhrfe5E2vNQW/t4tqgmLKJDrgJgXN1e7aeCcXmIHWBbHj4Vi8OQ1qj5INIgMICzvQlTQUP2rejbcSe2yL/9zotATgl4tfdqvMo5xtfZRnKm3oRrAbI9Dyv/jB7zZmABPA+nYwT+MVSKv0V1/SdcaFv6me3kI/Q0EhsCZc4y/G+qHjxwkSLFdYky09lBJppTZxaQqB98tp0Wl2vB3abSV6PopXjcGEOYtVZ/XLwGc8Py2bzOqP+ZNidyA52HHavzAistV/InORDnLNbecxAXXL3O2muOtzxQFLC+/72yHwHwx+4z5DKxYcT9gjqBxUTt4UxyIemStBI7bub57vAhOCXpcgb/Xj30+VlmyMZ/bm1JJguHDLBpmqv4mKS6ggatKedmbWYm/ZCFA738AjcIX63DuftzjwzOJ1RtQSvIdRFL1lz7H2cpoc2dH8k2ehgZqF6Zepto8tQSKZqlfAwP68sf5BNXquyvHkSjT5BQCCW+/g7tCQ0XKgyIFqgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(47076005)(336012)(2906002)(426003)(4744005)(40480700001)(40460700003)(83380400001)(81166007)(86362001)(36756003)(82740400003)(36860700001)(356005)(8676002)(8936002)(6666004)(478600001)(44832011)(41300700001)(110136005)(316002)(70206006)(70586007)(2616005)(5660300002)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 09:05:31.7889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88faea55-b5fc-4999-5359-08dbe427b07e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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

Bitmain S9 board is not enabling SPI that's why CONFIG_SYS_SPI_U_BOOT_OFFS
symbol is not present which ends in build failure when EFI/DFU
infrastructure is enabled.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynq/board.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index 3b6581e30462..6c365910011d 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -184,6 +184,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
 			 "mmc 0=boot.bin fat 0 1;"
 			 "%s fat 0 1", CONFIG_SPL_FS_LOAD_PAYLOAD_NAME);
 		break;
+#if defined(CONFIG_SPL_SPI_LOAD)
 	case ZYNQ_BM_QSPI:
 		snprintf(buf, DFU_ALT_BUF_LEN,
 			 "sf 0:0=boot.bin raw 0 0x1500000;"
@@ -191,6 +192,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
 			 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
 			 CONFIG_SYS_SPI_U_BOOT_OFFS);
 		break;
+#endif
 	default:
 		return;
 	}
-- 
2.36.1

