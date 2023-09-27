Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA8FE810AD
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B31A986DC5;
	Wed, 27 Sep 2023 11:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c42i0dY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CFEC86DB9; Wed, 27 Sep 2023 11:53:54 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E4D86DD2
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaHpAVA+pvR901VBkGf2rg2/GarzUPb8qUI9H/uJ8aQ7BZsXI4Om37gmiPFi9dshS5DhTE84ItRux0x1u4eWlbxC/mhE16l70lsfqtoBcR+JWdvbk6Ux6B7Be4H0Xzloa8pHu7wpqlog+1olhM0IlYnCnIx7wPA9NxXGo201g2haJPBGITMlnHUvziSnSbF0+AxgDDdqPte+NITDwc4duTVpDBiu9L2gwCNFcwVVFfgkLUjjmf8evM8Kg3imnmfhfm/8pd6WLpm4d/eCBjHZ/ic0ke+EJeiUcQw5M8SuaTsm+8L7jcgT9xtsUo8dBoYXXd3rlhL9WHZhGPc5VI748w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P90tDxqPaLQHbHBI/V/JdyJMAxs5CCh/SXB1wlD+JgM=;
 b=IBz/aufL4xfW/dYTiIezHfLlVkF4Q/4LJJS3584JfPRe+3TZ7dwm5Nn5krgzLlN4i8fEPGgceNYDv/laNIN/M3hEK2c3e9Neo7wuuZFACrB+zexgThEdFKS2ITlp642ghUVuszswMUSkZghR1TLLeYMnMMmGS6lCRlAS+wMJOVH0x6PpVSJojwfhI9yW9L0KIPAID+KeQfwP8DRI+pMyhFdTdi545AYgHFxpX5/2kbwvu2UBUecJTeSWoOyoUz/0jkkAJdvUN4wdV9GYXDvRaLlMoAWi4g10UZwGL9bDaO8DnD5MSrhcZ8fJN7OVyKEZfGCiyNFMCtwnRQSzleW/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P90tDxqPaLQHbHBI/V/JdyJMAxs5CCh/SXB1wlD+JgM=;
 b=c42i0dY80y534tGYTiWSZMJ0ti1CklNGurOpnhRCV/7sLNb6FduWdxzeK/l9SfRRJtn3GDacis09qC39Ai5rYJBJ/5GsFSqfK4wi9EgxtE2APzYLI99VgR6GYOrJsCkb72PXePrSezuWQn6Z1MSZg219aJaZ7DzN1GOrqgoqRH8=
Received: from BL1PR13CA0069.namprd13.prod.outlook.com (2603:10b6:208:2b8::14)
 by DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 09:53:48 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::f2) by BL1PR13CA0069.outlook.office365.com
 (2603:10b6:208:2b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.20 via Frontend
 Transport; Wed, 27 Sep 2023 09:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:53:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 04:53:46 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 03/11] arm64: zynqmp: Add support for vck190 revB system
 controller
Date: Wed, 27 Sep 2023 11:53:29 +0200
Message-ID: <461cfe5b2b882365413f90d19efd8abcd6be56ed.1695808407.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695808407.git.michal.simek@amd.com>
References: <cover.1695808407.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4043; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=k+Gu7v6YNu9gT3TMIKBBCMge5X8VcpqSBFAskQ6MgMY=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTh33O7/ghGtpX/0Vj4LvUIp4PEVObpAoERpg4JmpW/X
 wQdnjG1I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzE1oVhft32xnoByQbDOTo/
 djW+/fM0u0L4IcP8oN/fP2i7HnjGvl0ivUHV5rD8gs+mAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM8PR12MB5478:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee8f584-df5d-4a81-ad70-08dbbf3fa54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+5FZKFrKX3o9dmF1onRLHIKVjR2wXjNZD6bICQELatGevBS5uyv/xaRdgax44wTIWYdeGWHm4E7t+VxBzR5v7uU1psSgdq3byyV5zsMEA3+dUFFzN/MU7Rc/GTkxg3Nao7zgk5y2hPsF5PmWDNw2PQvXM5/oOweqKoAoRrSmpJy34/DWSKcGmee7SJesb9o/xGK8rgDcBgIPMH21B97f1Qb3tNLE7IyPHaKOboq42EJ0Aw5RnXMMRf0tKbPJ5HXrnW8jAbURrd/zKaTWhDJdGtQhp1T3DRPCnFDm7uTH7PlBC6jpoQsKKXeTR/gveWYEcgntvbggK7HB6PQJENu//lBP9iULMSKaQB2b4Z3mNUg5/7p9Pf8T+jHEFNx6/3rjQivP6t8FK0CVMm0J/CdWtRhBrUt1c/oUcv+sva0udFPGOTglcBC74TZUKOoNwD8UDOwj2zjujEuDb7FKt96bnh4XJmglP+IChqcTF7vhgLXSZ/5Qf9jx0ruDOEobm8KFCvn9qmQoKQqPMSzjR0Jhwsg2BA7GCbTjKjy194Mms5mvc/MRKUTZSIi+tf42ZbT3IqwD/B+x7QoSZJNZRIrYKVE7ywmvgVYauyVfOTIJ/l2gUbwZzWWJk4rlB3lHyviRbJLgav7QWcDPX8LynKNc8LLQYVZeQ8UAePuRtBnfl5aZPFfBOEgIZUDe0krpa9ecm3jmZX2LqtVy/0y+aIZDgaJ2zc/mNl+v8a94ssb01f4A5ifY387cd0urT1uTG6PFQXvvTabL8mbeeAa+dy2BQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(26005)(336012)(426003)(16526019)(6666004)(2616005)(36860700001)(83380400001)(47076005)(44832011)(8936002)(5660300002)(8676002)(2906002)(478600001)(41300700001)(316002)(110136005)(70586007)(70206006)(356005)(81166007)(82740400003)(86362001)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:53:47.9764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee8f584-df5d-4a81-ad70-08dbbf3fa54d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5478
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

There are some changes between revA and revB boards. u39 8T49N240 was
removed and also three ina226 at 42/43/44 addresses (u178/u180/u182).

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/Makefile                   |  1 +
 arch/arm/dts/zynqmp-e-a2197-00-revB.dts | 34 +++++++++++++++++++++++++
 configs/xilinx_zynqmp_virt_defconfig    |  2 +-
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/zynqmp-e-a2197-00-revB.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index e42261233758..e060081cdea5 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -395,6 +395,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-a2197-revA.dtb			\
 	zynqmp-dlc21-revA.dtb			\
 	zynqmp-e-a2197-00-revA.dtb		\
+	zynqmp-e-a2197-00-revB.dtb		\
 	zynqmp-g-a2197-00-revA.dtb		\
 	zynqmp-m-a2197-01-revA.dtb		\
 	zynqmp-m-a2197-02-revA.dtb		\
diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revB.dts b/arch/arm/dts/zynqmp-e-a2197-00-revB.dts
new file mode 100644
index 000000000000..8310df9ed369
--- /dev/null
+++ b/arch/arm/dts/zynqmp-e-a2197-00-revB.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx Versal a2197 RevB System Controller
+ *
+ * (C) Copyright 2019 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include "zynqmp-e-a2197-00-revA.dts"
+
+/ {
+	model = "Versal System Controller on a2197 Eval board RevB"; /* VCK190/VMK180 */
+	compatible = "xlnx,zynqmp-e-a2197-00-revB", "xlnx,zynqmp-a2197-revB",
+		     "xlnx,zynqmp-a2197", "xlnx,zynqmp";
+
+	/delete-node/ ina226-vcco-500;
+	/delete-node/ ina226-vcco-501;
+	/delete-node/ ina226-vcco-502;
+};
+
+&i2c0 {
+	i2c-mux@74 { /* u33 */
+		i2c@2 { /* PCIE_CLK */
+			/delete-node/ clock-generator@6c;
+		};
+		i2c@3 { /* PMBUS2_INA226 */
+			/delete-node/ ina226@42;
+			/delete-node/ ina226@43;
+			/delete-node/ ina226@44;
+		};
+	};
+};
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 30e420951dad..d72fac40a516 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -103,7 +103,7 @@ CONFIG_CMD_UBI=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_BOARD=y
-CONFIG_OF_LIST="avnet-ultra96-rev1 zynqmp-a2197-revA zynqmp-e-a2197-00-revA zynqmp-g-a2197-00-revA zynqmp-m-a2197-01-revA zynqmp-m-a2197-02-revA zynqmp-m-a2197-03-revA zynqmp-p-a2197-00-revA zynqmp-zc1232-revA zynqmp-zc1254-revA zynqmp-zc1751-xm015-dc1 zynqmp-zc1751-xm016-dc2 zynqmp-zc1751-xm017-dc3 zynqmp-zc1751-xm018-dc4 zynqmp-zc1751-xm019-dc5 zynqmp-zcu100-revC zynqmp-zcu102-rev1.1 zynqmp-zcu102-rev1.0 zynqmp-zcu102-revA zynqmp-zcu102-revB zynqmp-zcu104-revA zynqmp-zcu104-revC zynqmp-zcu106-revA zynqmp-zcu106-rev1.0 zynqmp-zcu111-revA zynqmp-zcu1275-revA zynqmp-zcu1275-revB zynqmp-zcu1285-revA zynqmp-zcu208-revA zynqmp-zcu216-revA zynqmp-topic-miamimp-xilinx-xdp-v1r1 zynqmp-sm-k26-revA zynqmp-smk-k26-revA zynqmp-dlc21-revA"
+CONFIG_OF_LIST="avnet-ultra96-rev1 zynqmp-a2197-revA zynqmp-e-a2197-00-revA zynqmp-e-a2197-00-revB zynqmp-g-a2197-00-revA zynqmp-m-a2197-01-revA zynqmp-m-a2197-02-revA zynqmp-m-a2197-03-revA zynqmp-p-a2197-00-revA zynqmp-zc1232-revA zynqmp-zc1254-revA zynqmp-zc1751-xm015-dc1 zynqmp-zc1751-xm016-dc2 zynqmp-zc1751-xm017-dc3 zynqmp-zc1751-xm018-dc4 zynqmp-zc1751-xm019-dc5 zynqmp-zcu100-revC zynqmp-zcu102-rev1.1 zynqmp-zcu102-rev1.0 zynqmp-zcu102-revA zynqmp-zcu102-revB zynqmp-zcu104-revA zynqmp-zcu104-revC zynqmp-zcu106-revA zynqmp-zcu106-rev1.0 zynqmp-zcu111-revA zynqmp-zcu1275-revA zynqmp-zcu1275-revB zynqmp-zcu1285-revA zynqmp-zcu208-revA zynqmp-zcu216-revA zynqmp-topic-miamimp-xilinx-xdp-v1r1 zynqmp-sm-k26-revA zynqmp-smk-k26-revA zynqmp-dlc21-revA"
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent interrupts iommus power-domains"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
-- 
2.36.1

