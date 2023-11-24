Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6C0C61DF4
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 13:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A105E8760E;
	Fri, 24 Nov 2023 14:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TQlW4AZx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C79E86E7E; Fri, 24 Nov 2023 14:17:03 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4886886F64
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 14:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO/mZ6xPygOFgNDE9VRvEtqXeycRY3HNrr7Or/w2TmRV9aHdTwS1aLd70AZAiohrIv3SE3ErKU09v/WxMqxG86KNivzyOTU026eX+mWGBgHJ09fXj+aPMzrEHj4UqZxFkHjB5D+FwHzGFUgIXgH9Y2sDRzTcMEApuT8zA16zYBf/rnli7IEQ2+b3y2z4GXBdZYU65s0+2V0EtFwuhYN4dT1M87Sr0iYS9MbvdkXwDgZQjfrtDnUcuK0C35RSYSJkzoC8O1OU57IVYw8lEAZ/knbBJmCqsRnI9l0HKyXg7miVAH0wii4y0luqxGsNpijMwhziqiB/4slnLGp98dETng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7gkwwuJmnwh0Mw+lpMdEkfw4YPdZLO01UHPKD5NKHQ=;
 b=YBMwfYL3qddum0+dFwRl8o7bzT/ZM1+kX4CfCsDRJVGwg/x734D26KWbM7AwJBxmhyw+6V5NAI7j2CXLnPQz8KaNHvms9dgoBpcuF4lgj2yrZpHv/hIuRCpCijuHin/0PhrOQLBrYbvFZVoDpq1fmuHExArm3wp4eK4hZsck3Od20dzXrGe3jJVGZRzWhE+vQF38OR4Sy8a0X5Q3WP8LyAyFknhhk9rMcQ5TaWStgjx3NZSLBVeH//2Em7KwLLKevPor9DvDEX+/c78in7F+9yUQLB2x0/jNzV0Ayk0pyoOZCZZlHWbXm6wU/GQvIhk/Luea/NnE1ZV4SbRus/WVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7gkwwuJmnwh0Mw+lpMdEkfw4YPdZLO01UHPKD5NKHQ=;
 b=TQlW4AZx/Eyz5suOss09TbuYR0hHP0OG3UeHi2UBm7w2IUXTMRCHCqzparaPzMcKieYJk7NZVElVjrDR7WUJDQfr+Qx05ROn0a3kSbPrsIfHR9yCavKvQ6Il658Qz5TbVbPpkRwIw3/8iNMXh2v2yX5D2YGsTNEjI6On9UC5WiU=
Received: from DS7P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::32) by
 DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.21; Fri, 24 Nov 2023 13:16:54 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::b0) by DS7P222CA0026.outlook.office365.com
 (2603:10b6:8:2e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20 via Frontend
 Transport; Fri, 24 Nov 2023 13:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 24 Nov 2023 13:16:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 24 Nov
 2023 07:16:51 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] ARM: zynq: Remove deprecated device_type property
Date: Fri, 24 Nov 2023 14:16:49 +0100
Message-ID: <70201ca4ad49ace6f7c27015af9df58a335d2a1f.1700831800.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=aQOxU6v2FtCDG3wOH03c8HWQzYJpwEHq0VLWKxx+RX4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSERZbnegwnfJaNsDLT76mu9Zxw/3LRLYWf1SvTv4eon
 a1VVZ/REcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACaSzc4wz+b3n5yD1QHt25KX
 sJffk/g2Q2udHcM8g8+H2laL7bJb/prVw9v1j5ds9z8tAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: b7612045-3400-4f83-96f5-08dbecef9ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thCoGuYS33UR5b3zEqGborQ6CbOwsqGt/YlyOscvM5331bXMyZLHdxIkMzeDJ8vuisZ7BgHAyPk8c2c+T5TYoc8pbCl8IhPbiG+YyKbXmFJx+ADApPwohcl+l754bv1hA5gnxWHvqIGuukvM4Z0+aaRS3zGlj3dqujpPGY9W5pD6o+ryb4G4YBSl62DJEdXqXbrca+8IMN3j1uK7orIqrF3/lVb0WgnFwoPwgErJkdHpSnn9sgcEdhRpQZg3ubYUqRa+aXPc0bKJzmrMDBnWyhpKgGZ3rTyskf2C1ifPCiixRxgYJRpwxAByN3cuwxy7ZmD3rfYOXJqJgYXGR0vPea7wxkZjYtI4lKD6ibc6NjRKoDxc33HdiD0oY5uJBryI4rBfZBafV0pwpnDQ1UDbIa2Djzkrx1PMVUs9vGk+KkXmxBql4Skx7ImisG3yACgjTGYslNxU//e3fEKF6+EbsDsTjhr5tzolu4rSnPYug0C9yZ25UjDoCdopkw4rKASUpxhYcmF/AsqUe0EKIguo3RZaSlX+QUb+STLKQ1xI/KCODXUC4dnF36mtd5oc3nBcwsQkINT3vhhs2+z7WLx9iWaTUYeOrMMXYEFTZk5fwIuBiDd8pOGGE8PIY/KihZosgTQ27Y12f90YZYcTOZiyvJeaujA8w5Nt03q+sn3qfQ+nkPE9aKyTeKg9wOqfbgFGZRlJf8OO0jqo89Mwoz3eE9f4S3wo2ZqkN5N/RuaqwKjjTBRPH8nwObY4nMNPTrw4c9zUkmzfYK13RVfYygwGGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(82740400003)(26005)(47076005)(356005)(81166007)(110136005)(316002)(70206006)(70586007)(8676002)(36860700001)(336012)(426003)(16526019)(2616005)(83380400001)(478600001)(8936002)(44832011)(86362001)(2906002)(5660300002)(41300700001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 13:16:52.6803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7612045-3400-4f83-96f5-08dbecef9ff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
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

Based on DT specification device_type property is deprecated and should be
used only for cpu and memory nodes. That's why remove other usage. In this
case ethernet-phy.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynq-cc108.dts       | 1 -
 arch/arm/dts/zynq-syzygy-hub.dts  | 1 -
 arch/arm/dts/zynq-zc702.dts       | 1 -
 arch/arm/dts/zynq-zc706.dts       | 1 -
 arch/arm/dts/zynq-zc770-xm010.dts | 1 -
 arch/arm/dts/zynq-zc770-xm013.dts | 1 -
 arch/arm/dts/zynq-zed.dts         | 1 -
 arch/arm/dts/zynq-zybo-z7.dts     | 1 -
 arch/arm/dts/zynq-zybo.dts        | 1 -
 9 files changed, 9 deletions(-)

diff --git a/arch/arm/dts/zynq-cc108.dts b/arch/arm/dts/zynq-cc108.dts
index 593ca4a49cf5..ec39aad1c0c1 100644
--- a/arch/arm/dts/zynq-cc108.dts
+++ b/arch/arm/dts/zynq-cc108.dts
@@ -49,7 +49,6 @@
 
 	ethernet_phy: ethernet-phy@1 {
 		reg = <1>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/dts/zynq-syzygy-hub.dts b/arch/arm/dts/zynq-syzygy-hub.dts
index 99f248d4e5fd..1b3eddc667db 100644
--- a/arch/arm/dts/zynq-syzygy-hub.dts
+++ b/arch/arm/dts/zynq-syzygy-hub.dts
@@ -48,7 +48,6 @@
 
 	ethernet_phy: ethernet-phy@0 {
 		reg = <0>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/dts/zynq-zc702.dts b/arch/arm/dts/zynq-zc702.dts
index 0106d7bb1778..6083f99dc8d4 100644
--- a/arch/arm/dts/zynq-zc702.dts
+++ b/arch/arm/dts/zynq-zc702.dts
@@ -88,7 +88,6 @@
 
 	ethernet_phy: ethernet-phy@7 {
 		reg = <7>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/dts/zynq-zc706.dts b/arch/arm/dts/zynq-zc706.dts
index ceea982546e8..bbdbf99aee99 100644
--- a/arch/arm/dts/zynq-zc706.dts
+++ b/arch/arm/dts/zynq-zc706.dts
@@ -49,7 +49,6 @@
 
 	ethernet_phy: ethernet-phy@7 {
 		reg = <7>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/dts/zynq-zc770-xm010.dts b/arch/arm/dts/zynq-zc770-xm010.dts
index 199384bec967..ff475f868249 100644
--- a/arch/arm/dts/zynq-zc770-xm010.dts
+++ b/arch/arm/dts/zynq-zc770-xm010.dts
@@ -46,7 +46,6 @@
 
 	ethernet_phy: ethernet-phy@7 {
 		reg = <7>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/dts/zynq-zc770-xm013.dts b/arch/arm/dts/zynq-zc770-xm013.dts
index add75999f47a..02298b981631 100644
--- a/arch/arm/dts/zynq-zc770-xm013.dts
+++ b/arch/arm/dts/zynq-zc770-xm013.dts
@@ -41,7 +41,6 @@
 
 	ethernet_phy: ethernet-phy@7 {
 		reg = <7>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/dts/zynq-zed.dts b/arch/arm/dts/zynq-zed.dts
index 70bc41822e36..1d967bd1a285 100644
--- a/arch/arm/dts/zynq-zed.dts
+++ b/arch/arm/dts/zynq-zed.dts
@@ -44,7 +44,6 @@
 
 	ethernet_phy: ethernet-phy@0 {
 		reg = <0>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/dts/zynq-zybo-z7.dts b/arch/arm/dts/zynq-zybo-z7.dts
index 83b841309798..b621860705c8 100644
--- a/arch/arm/dts/zynq-zybo-z7.dts
+++ b/arch/arm/dts/zynq-zybo-z7.dts
@@ -55,7 +55,6 @@
 
 	ethernet_phy: ethernet-phy@0 {
 		reg = <0>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/dts/zynq-zybo.dts b/arch/arm/dts/zynq-zybo.dts
index 0ce5238c9a8c..c3d97858d7f3 100644
--- a/arch/arm/dts/zynq-zybo.dts
+++ b/arch/arm/dts/zynq-zybo.dts
@@ -45,7 +45,6 @@
 
 	ethernet_phy: ethernet-phy@0 {
 		reg = <0>;
-		device_type = "ethernet-phy";
 	};
 };
 
-- 
2.36.1

