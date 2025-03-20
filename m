Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1206FC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 09:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 555EA809D4;
	Thu, 20 Mar 2025 10:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zcehqbn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEF42810F2; Thu, 20 Mar 2025 10:05:14 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A85A8001F
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 10:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=na+FTyUb1cP4gNKCXkQGHDnXzRl0kK+zeHzteYc4FCEL2w3aPhYNRR10/TmtXz63LFdpFB+ySwYco79rnsdl+8Vdd1JGmOiiawvjDDEeaW5bvFpfpmZQWpBC/HwLTT05RGD30u1l9bg6O7eMPxwV9OvzapQw0OVy8poGU3ViP3kLmZCeN+r0mlS1YzdLqz+fxIWcSZONWhGnWVAkOoKO2HcJBu4TyQBLJEzwCxml7oKCnyPCV6Po3bSjcjuTtXHJ8d3imWbiVVYmL3GUreS+nveM+hhw3uFsmTl33LQRMO1KsHYKE+Fb4OhODbDzu1Rr40mi7yRdkakmaYL4yeOi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fn5RE81CMSjERgycG5z58qt7Kje8adUII2/SpMHVb14=;
 b=VdQIRyxYN5WqmBNRqaerwgZC3JxNyNAdWM4OsUMw9qCINyzNDFTkDpLcpfy6Qrx3lhUd2O/bexXQ6yQajnWEtCLUSbRLvjQ8I2yD7TnCcMulmZGathSCunFlG0mCVE/K8cli0DmGXAYAkpAavcckqzPP+KF5x3ppKzE1OpgLMg6gnJu1F2DYJ1XPW1Mb/aQuhfnfVcTu8+I+lZY8c8KxdR4SUHLntUh2Nqu6mjnCBZiXXnHnPkoajL76Vs58yhNweLEM+xfaaCIMaXh+y7oatD19RLDL/CALrxDkW1JwrzFKNu21CbdhgiAFovfmI1588SCERUN3P3QqqVoQPLFT+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fn5RE81CMSjERgycG5z58qt7Kje8adUII2/SpMHVb14=;
 b=Zcehqbn8Ev/pkt/fsjuC6SvQ6eMS9PJQ5JeaxsH8diNUajQebJXKUqiBwtq1EvEd2j+WO+53QrIIb4+XXB7hzcIDu7Uwootks3v9iln/fPreSXzrTffG5zlXf2NqHMBotkhfL1DgKtuMxq74umC4jv2rukdQSecG7Rt2laY7ed0=
Received: from BN9PR03CA0368.namprd03.prod.outlook.com (2603:10b6:408:f7::13)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 09:05:08 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::c7) by BN9PR03CA0368.outlook.office365.com
 (2603:10b6:408:f7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 09:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 09:05:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 04:05:04 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] arm64: versal2: Update the text base and dtb address
Date: Thu, 20 Mar 2025 10:05:00 +0100
Message-ID: <3ffb6f1f7ff418f01ccc2eccf8a834441f9f0b74.1742461498.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=830; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=FZreSyOGKjOE36kQOSYEeKlW1XTalt1pncUOLCrpSW8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTbt2yzvwlLce450GiquPcPI/+KkH1zLTX5+ELeG+0u1
 lcT3ZnTEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACbycC3DfM+vLNdW3ercVdgc
 No+t+tHzLxpTVzDMs1/ANUl3wgzNrR77z+88XdcosqoiDQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 575ca612-d2de-4b33-b8b4-08dd678e4fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?InmcZz2DtiAROaf48fVcXpE10NP9Z8cg7GSiRtWNVtthOM7a6mrNFNjvJQ7K?=
 =?us-ascii?Q?yChCRZ/CrrF+qGooPZd6EH+L4F54Wwyr4MD+yUppzw6/yFxqnqfTqmj9ywY9?=
 =?us-ascii?Q?6IcpnPV6/UytWWrP/Mwsu/ogKWtWAMDRsB6d2aT3WsneZGwFSRLZPAig0Ef2?=
 =?us-ascii?Q?DTe7x8W/B7rQk1aJ0JeiqVdqVc3mVB9xW2JmnviGHUzob9WSzzRRo/mVqTbF?=
 =?us-ascii?Q?OPmTUWx/q5kAXY1Lmo/IN6GTElc+q8Zpl0+EXAaVl4JT6XBNL6eILBQ2u7TB?=
 =?us-ascii?Q?C6jm8oipC0DzVaXu0thnQzpQR9cmYryWSC3gca1NCbuUMq42OHvo2hVClUvY?=
 =?us-ascii?Q?XYtwe4wKYpwoi7I9/13cDZhJ71uP3NPeBibAHSu4Nw6wnoebVZ27nj7NQdL1?=
 =?us-ascii?Q?zaUd1LME+Te7GfwYjH5LqG/ulSvhUtvTSbO6KjYkKLOP4ePRAOXv36u7QOlS?=
 =?us-ascii?Q?maIQcC61lj4citHHjn0+ZZbdCXJ+mlIxTb7JcWU4y5Iim/SBeCigQm0e/l3O?=
 =?us-ascii?Q?/Ao1HltGCZWJD4KOZI6AJzwQirZLQegQatzOx9bkr0Hz7YufIzJYFi2pmMiw?=
 =?us-ascii?Q?XaWrZMBBH/5HCRyxkX/pO94aIrpygExawMXOtZBg3nbYeIdpIamGpCwwjiq4?=
 =?us-ascii?Q?IQ3a9TzJgi439bkNStaqQzQMApLifLRKLD0HDGxssBG+b+sYznaMziUKyRbL?=
 =?us-ascii?Q?ISSMbjogbpD9MHKLST3/VUpuA20IVIdM4r1my85N98SVVz/hz8r6R8chB31v?=
 =?us-ascii?Q?k9qHiIzpB+udCZ5u5KWlnzk3focSBrkDsy7XabdHsjCzK8ZPViYgOQyxfqhO?=
 =?us-ascii?Q?k0xoGrfm3VtwbxKOKQGcM66gia8irLU0gflBBtGxW8U0PzSIKyUgqeUEZvFg?=
 =?us-ascii?Q?jCdiBB3akAciFrVmfJOUlCaLVlxyHzeoZBfK11tlVTaCfA2+c6gFImQb6RCE?=
 =?us-ascii?Q?LRsgMK11CpCEXNyz4ME56ibBD35SvBGz/JebaOR+jDeSkyvvhQ5xvHp0JkER?=
 =?us-ascii?Q?YhKRUnsT+lGE/ngWCS31RDINZXOujKgdibEFMVXkIUR4hZNguwXoJhVDeLi6?=
 =?us-ascii?Q?llgCw5b6LBA1X/DTVD09pe6m3+5uHAzPXkMI3gRCbdIBBX9lwFg9w3PqjB5X?=
 =?us-ascii?Q?TvZyeTx3fWGIXsciSaqzzWNSXAyWXJqdLjxigxIdw4vAiiU/D7osl4caw5XD?=
 =?us-ascii?Q?5loZGJUdLkYRbSvBJzd8/wCXlscpmYmt/xHl0QUpUlal+dODpkjmu5eaudwY?=
 =?us-ascii?Q?lO+M9igb+R8wMkJcCjytL4l4+/py5Mwe1QMZ/rDoDMKUMkHZmAEcBnaU684g?=
 =?us-ascii?Q?avl7dhYtcomHN04BvFIeOTqY5pgzQ0oW4U3W7gj1RQLkwFWUh4omzCBQKUk6?=
 =?us-ascii?Q?MsGZAu5aD35tgljNs2PNftDXZo+FNTe93Fm6pyuPf2K/3qbqMqV5La5L5xXb?=
 =?us-ascii?Q?xC1zetYtEL1ph41l+M3gvHzNNICuPRQD75DgixW/h9OTTKfVbmpq0QnD9kkc?=
 =?us-ascii?Q?etjhH+mG0AtE7nM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 09:05:07.9179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 575ca612-d2de-4b33-b8b4-08dd678e4fde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
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

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Update the TEXT_BASE and DTB address as per the new memory map.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 59bda4c71fb0..087c7f047335 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -3,7 +3,7 @@ CONFIG_COUNTER_FREQUENCY=375000
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_VERSAL2=y
-CONFIG_TEXT_BASE=0x8000000
+CONFIG_TEXT_BASE=0x40000000
 CONFIG_SYS_MALLOC_F_LEN=0x100000
 CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-virt"
 CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.43.0

