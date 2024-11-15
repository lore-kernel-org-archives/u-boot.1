Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D614D6DDEC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 08:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC2D089197;
	Fri, 15 Nov 2024 09:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="klEhAKLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C850B8932F; Fri, 15 Nov 2024 09:39:11 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3183C88FFC
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 09:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vc9qhcrv3VxgxS0Hl7K6WpZ/J6Cc29ZTzrelpPISJdqVSKkxAP580mPJiWO4U1EkqzObViaSMoIGqLpJtziNxPqXAQucz0laWvL3MIMgSL3IDvo6Em9dSOo6xDuXgZia+0ELRWgZsAboW6U/RqaF9NG3DknBKWZD2U3gr3OPxa0pVPFsL0jYik6Q1+kGGw6CjDTLZVH/srSgNtelNWbFQb0UT8aJ/cZgDxCSaoKP7TG3TQ7TAD+K4q1UPI5v9ofoUbB1Ywel8jMdwbrgtTClHsq1497jwUiifDrFonVltbn5LzPvMfmjkcuAVX9ANGjWFjmN6siN1jifIXbD8crBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghKomBQEWFjtXiscjvGKmck9npoBDUfm3eUWQyBGyZc=;
 b=iduOb52G/MTkJkoH0NYQ5Gikrmrvtl2C9xFn6UcAlHf3H2RR99+wUgZKnACnBN8ddqU+D7gvau3c9ASJMENzQf8qL5/F478E+cpYUDlUylCIX/0x4W84tQkHXQ4mFhE0F5BXKgVLnF49jxHzHfwu/1lFiJndWdRaD4GKuEdh2LuT1lYuQHlAgC5/fsEM9+XmmFKoDAo+WFDrsFeUu6IUaPPiSVo/kYt+D39AV9n77O64b+NaRspM0gFAMs7DoxoXswIND3/ZfvwVA6CgEqGzamRWh6fxDS/wXSsDRvkmeUTmOTL1gkLxfyTSnWhT0CQ+201dH2e92i9yCPYCliFOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghKomBQEWFjtXiscjvGKmck9npoBDUfm3eUWQyBGyZc=;
 b=klEhAKLz72Uh3e8t3B3HYn88Y3TD1vE3T/Uphv8jHknK+Sn/JBtfVEKaEHD5r1D9glQYWcpuiFGF8h3F0Rj38S1l29KSCmBwvHKyFXZCMpQbcV998yCe9UA43/fk7VFODFgTLi49XSM6zu0WdheQ/8H/cYdWKTs8OD0cxb2J5kg=
Received: from SN7PR04CA0218.namprd04.prod.outlook.com (2603:10b6:806:127::13)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 08:39:05 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::64) by SN7PR04CA0218.outlook.office365.com
 (2603:10b6:806:127::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 08:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 08:39:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 02:39:02 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] microblaze: Disable JFFS2 support
Date: Fri, 15 Nov 2024 09:38:55 +0100
Message-ID: <a8239acee8886229fdbff66142c46d522e3fe851.1731659933.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ksk0qD0U+sDiSYfFGMJ/iwNeDReRVKCD9p4GDnURNbc=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnRzjgVFjbedKnoOHzN5bLz3XrXsp9urvCq7Zp572Dv5h
 v1i6wmZHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAi8scZ5sowR2/6d//8owKG
 3yziIV3/nkqHCTDMFdeSOuUeU3HQUL1a6d49+8XbPNnfAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1bdc7c-4259-4848-6119-08dd0550f6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s8jEKFMu2JgOI7+p+RJodNhpdMHy+DFu2Aq7NfNvXWdwg2kwQ6UAOVe8P/s8?=
 =?us-ascii?Q?3eXsAsQZDnVXD8Mnfnmr8tD4aYHWjrz18O7vrU68cHCqEweWnuc0PlLr8+C3?=
 =?us-ascii?Q?fKtjM7ex24GrnpwGaH8r3/Jr5TNSe8HWB3QykNWYDoqlbn7ZkTotOEau21Ct?=
 =?us-ascii?Q?2Ywd70txwsyOymwPnkE92+XfmsNpCYoMQgUqlnPXm/refw/trP3SoGH/KikQ?=
 =?us-ascii?Q?jCaJwO5QR3DzvkKrOIYQjyxXAf6J6csWHZPOaWcwzgj8Zxh/Hklt1eng0PKA?=
 =?us-ascii?Q?lVAY4IYy+mWVGZFv+K0baVV0nclv5yXGUOv0ohmzUSI+7D8/JIUDVoP1WT3L?=
 =?us-ascii?Q?R/3nAEyHnlBUCiFzUDkZp/Z4V5BTOZdbqYUuLjqjAni+qhGM7T9OPKKSj21l?=
 =?us-ascii?Q?v7z3svxEAjB8HQYmSlfr5gwtVqNoLBDEbtWYf86eX/YfiNhZVwF8oqF8WBs8?=
 =?us-ascii?Q?K7Jnh7IDNRTs5wiqAKeXtscyKfzeBnee5x6u6m6pklauOju4clffy08joGb4?=
 =?us-ascii?Q?YZzixVzIFv1gc1QIOG1EKVN+Vt4XRur1dsvRy+GCLPpj6XcyMJD+y7tN65zm?=
 =?us-ascii?Q?niU9tR6IFJjv56Hu0wqwHFqDlmNlkyboETiEyvFRAZY6OTpJG5Iy0JI7BgtV?=
 =?us-ascii?Q?Fz3h9ukWpu62kHrJozrgcz6hltm21Y21Bl2POFD3zlD73yDfSNjS6CFjb0kB?=
 =?us-ascii?Q?EBDqKksws7W55Bjrj8i/CQQwPJ5AHZQKVv3r4bNL1O1TIpxDfE3qMQgGNgNm?=
 =?us-ascii?Q?94+PYQekDTGDWQUcysj68y8go3vHm0TlX4QP4dF50yyOsKR/zWKrnoZEZ4v2?=
 =?us-ascii?Q?CHZ67THMTk+bwsBMfeCaPefpaImEA5TR34BvzwK/UiqmPENm4T4wqS3JHj7+?=
 =?us-ascii?Q?H53yD9wyQ11dl3982qQf6SFhtKnZYTTj9/xGl2Uxnnox68+2Uflrn52VsMt0?=
 =?us-ascii?Q?hXWedXO7772kaMfbKK2l1ak8OieTYgNRDe92CY2raJ0gKPsXr/mSfsxWXGNB?=
 =?us-ascii?Q?Bqk7H4u8alvrT0p1BpcJWv7i2argGQFE0lNGD9fCpu05PhKkpSGZ77IKm0Ca?=
 =?us-ascii?Q?nyhfP79j3aRM/GEzNnG6ticIxRq7ORWONq+AWCbln0bwIo2ZxcbgRiDF/oOO?=
 =?us-ascii?Q?QIeGwCMo4G0HNz9Qxc3pry+hPk0RdQiSTH/MbO1xBRjA3XsBBtT98DgUgG/+?=
 =?us-ascii?Q?l+L7Oi1gCcFU6sTH38QRGZbVplcC5tFFN174zXNlRlfHjtlV+vWQFLvTL+bK?=
 =?us-ascii?Q?mqsCLe39craiwGJWBLnTW1TRkx2GP+Im9pz69IWrpW2YNT4XEaHKKQO+RJG7?=
 =?us-ascii?Q?EiAc+kmz3oXC4zvYji5c4yzaWAbGhv8x9H6xP1RAEJi2NwWvqfKxzAT1Ay3P?=
 =?us-ascii?Q?BlpNfB6xcUWpASMlGH3v9BLd5kZAxt56cvxGP4HwHxq+t/xqoA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 08:39:05.4208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1bdc7c-4259-4848-6119-08dd0550f6f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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

JFFS2 is not maintained for quite a long time and none should be using it.
Please use other filesystems for flashes like UBIFS instead.

Also remove jffs to MTD map but MTD map is for example that's why it won't
affect anything.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/microblaze-generic_defconfig | 1 -
 include/configs/microblaze-generic.h | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-generic_defconfig
index ca78b32846ae..7b3adecabb61 100644
--- a/configs/microblaze-generic_defconfig
+++ b/configs/microblaze-generic_defconfig
@@ -47,7 +47,6 @@ CONFIG_CMD_SAVES=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_JFFS2=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
diff --git a/include/configs/microblaze-generic.h b/include/configs/microblaze-generic.h
index 6740ab2be3e2..3bcc4c48dc80 100644
--- a/include/configs/microblaze-generic.h
+++ b/include/configs/microblaze-generic.h
@@ -82,7 +82,7 @@
 	"nor0=flash-0\0"\
 	"mtdparts=mtdparts=flash-0:"\
 	"256k(u-boot),256k(env),3m(kernel),"\
-	"1m(romfs),1m(cramfs),-(jffs2)\0"\
+	"1m(romfs),1m(cramfs),-(fs)\0"\
 	"nc=setenv stdout nc;"\
 	"setenv stdin nc\0" \
 	"serial=setenv stdout serial;"\
-- 
2.43.0

