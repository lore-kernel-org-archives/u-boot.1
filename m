Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02762E81DE9
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 11:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD6086EB7;
	Fri,  6 Oct 2023 13:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QccVO+24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF60386EB8; Fri,  6 Oct 2023 13:45:25 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC8B3869C4
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 13:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cx05aS5VJdJ2HtCxAwiMZCPTIelA4YQeK/QIVBW0pRRpYXI4uPi3omJMEY+eVV8B+yapcLDWZCOHg3W6kIykozxgFTmgqbN52CNS+tv57w8Ko+7+2H4LFci89L93wG9egBdkR6L3C4M8alGk8vI8z6meJZiAcOfn+d7dg2Qm1FV7gcoH55uYeuWeCQsMQoPhhxiQPtOie3j1kt9+TiIjTWBA48EtEynTMw/pw+w7ol2JYyHaaLLfqfJ7g2lzXWGSKqIZajNyvA5EkFGVF+PKF6FGDXlpEWZewqRSyZeX9oBZigUrBdLXm0M2z+P2GaQEP2OW/c98e8miViYSKJVS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EoiBbyxYkjKUz0MXLNObWPcNcLll9MGdn68iHt1kE0=;
 b=GvXB/NNDuBzG+BimKhguytmT863hAJWB4LZDXlWQzoWloZKboSY0zvApRIAYao9DR59fAQldioETyCMJ7r80wqzwJut5Gq3rJS0h3RThGtGwpR8Ni0Kn5vETOXTmjts3DWhU6Vr9bd+ULqdEHcQU56fm7nvOpzvoX+r4WnhvP+lOPA9oG/x+qgn8nh0qiYhPuIhl08WsQVzX1svAttunPZe3qCcWioBl6MJsISM6Ei/FgLZiaCb68A6yxw3PwVURCnlUdSgwsdzS/b7NOq/5/u/26itLQ2Z1K3CaGSapA2o+eupiF0bSP6TcQjdVsaZFiUtZb+FRqNu9m/PKFCFRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EoiBbyxYkjKUz0MXLNObWPcNcLll9MGdn68iHt1kE0=;
 b=QccVO+24hfRPQ6KgvHYmZMKbhYmqWBk6nMfrg4VuhXCzp+OdTSZ5/PaRXgTN1ffOZPFx4/VwJByJC8WlOI+lCZXpT5uCqMutEYn6uDQ4470kwXLFS5E2+FHbJzxnac7Kw1ufptoNrtiHWhZwefLB4D30wmUP4+UFQ2S5RWDSotk=
Received: from MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::9)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Fri, 6 Oct
 2023 11:45:14 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::f) by MW4P222CA0004.outlook.office365.com
 (2603:10b6:303:114::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.31 via Frontend
 Transport; Fri, 6 Oct 2023 11:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Fri, 6 Oct 2023 11:45:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 06:45:12 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] xilinx: Enable DNS/WGET and BLKMAP for http boot
Date: Fri, 6 Oct 2023 13:45:10 +0200
Message-ID: <4fa9b425459947e6424c8ce27376fdc7a14bf839.1696592702.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2456; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=prl/jXf5tR7VHQlPD8DrXNJKLSea2bsqIEiGiwcJ1yY=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlT5z3ZSpcEZKns9/DUzl+0Jyl8cU2LXXR8WpBmnK8D9T
 KXb17kjloVBkIlBVkyRRdrmypm9lTOmCF88LAczh5UJZAgDF6cATOT8aYZ56vt7y74+Wi3yvvic
 85n2NeayHafWMswvsN0tYVLUayi2822tWFepgiV7YxEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e72ace-24af-4c57-8512-08dbc661b3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIsjTNahm9RQ+OZBZHMGwEO+6Ul4Ab20DjU32ZtlzV56knbsH0+ClQ77w5YwCtCozI9Hejog31N9mKAwcatoCnRYqHhjsa1PiduvW2Ag82ECkYGdL/Nqwgb5Fq+OdaBXoOr5MShuwhwieWItOdXWZlN5XXplmmsqS+8orvhTxR+Y12Ph75gHDhczcOSvQpB8+yFtWTBIpk4dNRJ9mC5sb9BUbQELwPtUgVOax0ncgA9wPg3bf29AUUM+TLlTrtf4Ov5mPXNAplTOhJmqH6YDDj48Aaj4bY/WEGzkMK7PzrzVarPmWDTQBEl5kUoa2K+VyFsBJGOtTCLFLFRp/eWYqH6EavMolRfnssuBdZ25qj5gRSHsZ3yziUauGLWeyxsZ29Xeabc8YZjCD2r2nHq6zgFSSCHkDXi4ixVjyLzLJndA0M6l7pNxWWY3LAI5qmFSkUjYshSpFjiNsyA1ZqjRCNkvkjyjnfwjpYoYHzdty1eQ63nrty/h6BE5LxHsW2/yxeXFhSefcDkR1/SQh+cT8SpD0mpASqHTf1MozJpLuI2ZtNUvF4RYyvEwCEik4/HSdx4PxNsrik0CzE5MbzocdKV/j3xu4lv2yBMM9h5ZYuKHWUkLpVoh7h/oGr3EM/mXGb7u40dP5TuszWWNxFsz8h/i2EfKjrnlxk27NdLus4ujhtelntRHIaErZ7lh4ldwiDiIokKCes4cb7cmAsj7gLXedUSq65ql0zXBt0LAfostsBjfz++kv+AjX6XpC4yS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(44832011)(70206006)(70586007)(5660300002)(110136005)(83380400001)(8936002)(8676002)(316002)(41300700001)(966005)(81166007)(40480700001)(478600001)(426003)(36756003)(2906002)(47076005)(356005)(82740400003)(336012)(2616005)(26005)(16526019)(86362001)(36860700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 11:45:13.4637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e72ace-24af-4c57-8512-08dbc661b3f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
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

Enable DNS/WGET and BLKMAP to be able to download images over HTTP and map
them.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Can be applied on v5 version of this when this is fixed
https://lore.kernel.org/all/cc0cff36-359a-4c3b-9ba6-bce0834358bf@amd.com/
---
 configs/xilinx_versal_net_virt_defconfig | 3 +++
 configs/xilinx_versal_virt_defconfig     | 3 +++
 configs/xilinx_zynqmp_virt_defconfig     | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 62322af458d6..c190bf532705 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -46,6 +46,8 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_WGET=y
+CONFIG_CMD_DNS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
@@ -69,6 +71,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_TFTP_BLOCKSIZE=4096
+CONFIG_BLKMAP=y
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_RAM=y
 CONFIG_ZYNQ_GPIO=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 89566c7d52c0..5ee694a4ff73 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -47,6 +47,8 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_WGET=y
+CONFIG_CMD_DNS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
@@ -71,6 +73,7 @@ CONFIG_NETCONSOLE=y
 CONFIG_IP_DEFRAG=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_TFTP_BLOCKSIZE=4096
+CONFIG_BLKMAP=y
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_RAM=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 30e420951dad..d1bdea09ebab 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -82,6 +82,8 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_WGET=y
+CONFIG_CMD_DNS=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -119,6 +121,8 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SATA=y
 CONFIG_SCSI_AHCI=y
 CONFIG_SATA_CEVA=y
+# CONFIG_SPL_BLK is not set
+CONFIG_BLKMAP=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_GPIO=y
 CONFIG_CLK_ZYNQMP=y
-- 
2.36.1

