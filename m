Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4534C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 12:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6CA4868D1;
	Wed,  1 Nov 2023 13:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h2yoRBJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4B4187700; Wed,  1 Nov 2023 13:06:33 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F958767F
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 13:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N88Ese6xktkHFdO8Z49ovPZaNmg3x/BG2GJPuZOqDPe+wMpuEApF43xhaDGGISbzqGFCIfFXI8ez25EAh5Gs2I3cK/VXNLsblPbY+rQICLNJe0Hnwjp2mx4K5HN9vSkejYKONlGrTGTUkaC8gOlb7J9VzttOGgzVLMQ/mix/u6DzvYhZTK4tHiUEDU+Dk8FEP+Qnn/qhK/jnwRihp32F6VkmlZBUieYL5ng1i6xRRKwH7XFeISHq3wtxaqPJ6E5fWetwJZ9rMoVxkd5pZfg0gVa82GXrH715SV+SOrQYdeONVyRewz4/cCjPrNwwMymTuY0WzhdvlFsl48DL4PkFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDiOiX0I5gGeKJlDEqq0DZA2e66OSAOpHYee7xnEn/I=;
 b=nlvOkGCp6jS7p8onXETR5Q1pfOzNAhJ++GMluvEq79oAFUsi3U7piLiwnCPuxNc1+rUek07ZNNKF4F/9/x6DgA5Omb1CkqZcr9FiakM0Kso7O54yuOsLCYWoRyDA5OYQrX3ttFpv0tdeYVCWolwA3URyXaeSacsbpHdrjpOitMWJHrzLApVAm7r3c9jCkDMfq2QOXsjAgFepgVBEalC17HrD9zeDN9KVajSNXoeuKtv4sySbpFM9optzQR8fUmk/iFv961+TsKk/Skdkz+ARHJJM5OXdkb0X8MlNkikzMM34S/XIsSohctw2eUri/G5urwEYjv6Z5s1g0EiwNO+4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDiOiX0I5gGeKJlDEqq0DZA2e66OSAOpHYee7xnEn/I=;
 b=h2yoRBJCXik2gOU9g6ZbQEHmwBQkxfpeTOPKoPSLU4ITBdYW8bQUMY25Oc7FcxVplRmzGK4MYCJHy0UG4RkTWqbJFPFvImDcVfntKgSIcTUVgikuGfaLL7ekAqXZX1p33+5zvO1N93hHes47FvrCdj8Vdv13lkuXy9n04MxCJto=
Received: from MW4PR03CA0304.namprd03.prod.outlook.com (2603:10b6:303:dd::9)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 12:06:22 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::22) by MW4PR03CA0304.outlook.office365.com
 (2603:10b6:303:dd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 12:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.0 via Frontend Transport; Wed, 1 Nov 2023 12:06:21 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 07:06:18 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH] arm64: zynqmp: Add description for nvmem efuse layout
Date: Wed, 1 Nov 2023 13:06:15 +0100
Message-ID: <af81299cafc2bd13ed30dcd69bdf6efb5fbb7f68.1698840373.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=8YBIptOQgxdbpkYUFxiyjSQgA5lDqzXFxsWXiSeyTlk=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQne1NesdD/0mpaEoYnXl46d+lq858un8au8u63T/R0q
 o3l78zriGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABNJLWeY78xlWLhcLk/65/27
 BvfUAq2Dd/9NY5gfyNl4JFV2ldoiw8XsV175/RF4OZ0XAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f9cffa-803d-4b5a-ad1e-08dbdad2f6c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8H89KbKOOZuLvkPYqCtdR7WYGjQ4RnoO4Zn/CPF63BbGTKA0BwddSdGC/BmPUOm0r/pbpyX/kYHeMIOZYlzeTDU9mMzCEI9y5n7mTONzYIsBvl8f2tSoGDd/0dc/pUUCIUciOq7f9ICPhA23ZszFnH9V6jwZAl53we8V4+P51qTAIGzHFPo8wDS5bkLZSW8vXbjBT4m13sXJMrUpPEKhXIL6Rpf4C+/1Zlhq+QmCiSUPAFyqHq1/xr5Kr/0Ccwaisu360FLGU+QFexRYcNbTpiMAhxhnqoAA2QdEQ0ETVgJaQqPaNTz+ykkwP7K65ZvhzaePv5eNiH3aHpNRKscjECkDTQip3zCvSW62i72IQwm0BLjoc5kHWMb+RrFXVCR6GQsORXax5A8c3646rpNJ//5GzaWGGwS+94QSCU6aySJWU56Y3IVFHVmLvZ2DQNqKP5Cm0/FW+tvwAExdgbKKtJXqiJDLIavjsCQMetB8sLXRA8YgB8+S9HXgAi5/l6bMAuoCNNLu2k6tAEi794Smb2vrvaAzaVcZoeYhYtP0rHqsXkErPu0UVaiphW1VwQN02r+IjDFvLc5XEgwAYkzaM63fYVMG3/A9wAFW2YFi9tz4P5HpLAh8Bk1yIlzlMazdK+qcqUNDa4OLH71Zm+aMJb/ImIjmnhVl8CmO/iznGXj+AflvLuP/GlvCKlBRjbjedQu8frpUSvhFuV327BgsmRMioSeXH0PGl9vKTPP3mp7abKrJMqbHTMriDBbmPC/vF1+rJ4q6Gz4Pqk1PM6chmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(356005)(81166007)(40480700001)(82740400003)(2616005)(36756003)(86362001)(47076005)(26005)(426003)(336012)(478600001)(6666004)(16526019)(36860700001)(83380400001)(8676002)(110136005)(8936002)(316002)(54906003)(966005)(70206006)(70586007)(41300700001)(2906002)(5660300002)(4326008)(44832011)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 12:06:21.9672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f9cffa-803d-4b5a-ad1e-08dbdad2f6c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017
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

Based on discussion with DT folks at link below there is not going to be
any name restrictions for child names. That's why add description for
current nvmem layout.

Link: https://lore.kernel.org/lkml/20231013101450.573-3-praveen.teja.kundanala@amd.com/
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 2253e773d386..735543513f02 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -214,6 +214,55 @@
 				soc_revision: soc-revision@0 {
 					reg = <0x0 0x4>;
 				};
+				/* efuse access */
+				efuse_dna: efuse-dna@c {
+					reg = <0xc 0xc>;
+				};
+				efuse_usr0: efuse-usr0@20 {
+					reg = <0x20 0x4>;
+				};
+				efuse_usr1: efuse-usr1@24 {
+					reg = <0x24 0x4>;
+				};
+				efuse_usr2: efuse-usr2@28 {
+					reg = <0x28 0x4>;
+				};
+				efuse_usr3: efuse-usr3@2c {
+					reg = <0x2c 0x4>;
+				};
+				efuse_usr4: efuse-usr4@30 {
+					reg = <0x30 0x4>;
+				};
+				efuse_usr5: efuse-usr5@34 {
+					reg = <0x34 0x4>;
+				};
+				efuse_usr6: efuse-usr6@38 {
+					reg = <0x38 0x4>;
+				};
+				efuse_usr7: efuse-usr7@3c {
+					reg = <0x3c 0x4>;
+				};
+				efuse_miscusr: efuse-miscusr@40 {
+					reg = <0x40 0x4>;
+				};
+				efuse_chash: efuse-chash@50 {
+					reg = <0x50 0x4>;
+				};
+				efuse_pufmisc: efuse-pufmisc@54 {
+					reg = <0x54 0x4>;
+				};
+				efuse_sec: efuse-sec@58 {
+					reg = <0x58 0x4>;
+				};
+				efuse_spkid: efuse-spkid@5c {
+					reg = <0x5c 0x4>;
+				};
+				efuse_ppk0hash: efuse-ppk0hash@a0 {
+					reg = <0xa0 0x30>;
+				};
+				efuse_ppk1hash: efuse-ppk1hash@d0 {
+					reg = <0xd0 0x30>;
+				};
 			};
 
 			zynqmp_pcap: pcap {
-- 
2.36.1

