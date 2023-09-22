Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B22CD4F57
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC1886B29;
	Fri, 22 Sep 2023 12:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sJMuWdNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE1086B38; Fri, 22 Sep 2023 12:36:53 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 580DC86B3B
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJzWwKUq46FTH5vu3zzBcjDCI7AxONJqpAcDt3uQU3EB1InFa/DhpNEi01U8XkjHpGCvVXVSU2aqc+KAn+KKyRX9e2EAZMSscPiZ+9PNZJEbl9j8w2c9wi1NIilzg5N/zzEk6IBsg24EaH7mb3kpUelYeXCQ+sOWQgq6DLRb+cJ1AJOK9incH2lBrCr5GhEZWLCGMcMIugFh3fyuJyAtuszA21FRNiZylaOlWoL/EXPBUlOpwcgXm7Ityxx+KY+IY1pZDFqGoBGTtoYjGtqWQWp0Tc9Mifpg9CXxSU1vhhZ8fo9sWf1OaTetfUlr9gR31SoXQ9CTwUIcKUDJMIWBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Jr1EXFyFwRaxiRVF0DOPHCwo7vKnor647iYCwfimRg=;
 b=goe3wc5zPCqKaQbm7EWf264jrWBP1+LjiedFI2s6Q/6lO3ZsEZutmaVR6DYO0jvEzE9h+ry6kk0K0cjWHkueDQFx0nBGDQqSs5heXJU9eQs468gzUak6z2vpfmylvO5J7XTeEg48+cmu2OUm8oZ5Z9/c1XGsCuUd0gcV8hqWdD4qMhD6DyvXKr64LhINQ7ntnPVz8Z5f28MOAYrmbA7g7rWGtZFGD7lx9s+63xkKDN5JPAPejwdxFtPyCsOENHplgclirJNVpQS3dPDoq/jus4n4i0QaNQzaBR48XQi+xC1/r+VfqIK/kwhXB2uZVRtjAaElRUbXnnipz71PaeHA3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Jr1EXFyFwRaxiRVF0DOPHCwo7vKnor647iYCwfimRg=;
 b=sJMuWdNRw0HtDGk6MNN4q11oPSlpVzjpRKLDneEQuc22EFQaowSGvj+ROLeB26vJKiaILd/k/KCYDkheWiYIC8nlMExEoaf7GKWE0vMxY3wpDDoxhKbLpgYcDOoXnCLxRTj0k+9DcyhkSqlqkloUb3DqcSa/UfjJ+UJV8mHfMyg=
Received: from DS7PR03CA0027.namprd03.prod.outlook.com (2603:10b6:5:3b8::32)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 10:36:48 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::8e) by DS7PR03CA0027.outlook.office365.com
 (2603:10b6:5:3b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 10:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:36:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:36:46 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 09/14] arm64: dts: zynqmp: zcu106a: Describe DisplayPort
 connector
Date: Fri, 22 Sep 2023 12:35:38 +0200
Message-ID: <fe037c93ed41bc5ca97887964037520d449ca98c.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=CBWryUM5YLKbqRTa/hcBQ63WDvnkbtySlRhOmymAoP0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3GmuKrtOXGq2vsLtKSLrEpP+crZOVtIB+/e/EhfmL
 Uu79Ce1I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzkXzrDXGH7e+vD5p9pPnGf
 ydenNV3r6u8WZYZ5OosNpgdIdUg0Z7/IEJugxPbQ88xdAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: c694cd68-29e2-4310-3316-08dbbb57d2e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQs15yAky76o6wVtdMtvL2VM3q/y8oW5s1Lmgq2x93FJ/5cy2oySsIQPfOae38F6vYYmiNFBSF3avraQzV/DkKUMPd2VUheoZtUieVRCK78CK3bXTOnPH9MDG9Siz9bOHYKRzD73W3QGSTTLQYuVfgmFZAX7WkqXKMd1RKZslzFjLbBz662dJ3dWtaIfbpUKVj20UymqN2S6JAHN6l9KF+04xDNwJdUmGe0LeV2zehsCe/ru4C2k8P1yyJyjSSdIJvlIpMGriyKe9IY5Q3tf/C1CpaxFXDMvtVwS4E69N/q4riHDXRJgWUJjPmU660a0cxJ1O5UgGGi75sTKqXaYRv2WwPiLQ3upB6wbVbU4rzQOzFVutWvx+Dam+hFMt7jLu1s+PvxAPbih5wmewiFe4QGfmeyQlq4onUqz2XGlZwDsAY7iwZd2d9mzsP/LRzDZ9tc8/wZdbcZd9/CpKNaou57pdv4T28k9TD7V0jz93QcD56hpkWGhSxjZzOCikLotMolzN1m2XDyTVv5XVbFrQG/YFUB8C5mNo+QFtuJ8/eyoBKkL/mVpPzf9mNZi6j8ujbs3xxSbhxsJc6Zl52WC79Vdm2j9yJQJNEgZZ+GAH4DRh0efjQAH2eNFz4ZQ/EAO/hdyr5eCn4YHBjP/OnkUzeZejn+a8AvxZDHG+UEWfONuq4ynV1H8CUj4nQ+GQHo6LTK8qrVyanRlkBTaXnBGZqMv1t2fmGcHWMbyevZw9GCGLDNQGdaFDcp3DfTOYT6ylzTmLHMOhultaIkROmb9RahVic+8qACN7b14iExilejb79weZfnwmtSDOdbHcmHq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(186009)(230921699003)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(6666004)(478600001)(26005)(2616005)(47076005)(16526019)(2906002)(83380400001)(336012)(4326008)(70586007)(8676002)(70206006)(8936002)(41300700001)(110136005)(44832011)(5660300002)(316002)(40460700003)(36756003)(36860700001)(426003)(356005)(82740400003)(81166007)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:36:47.7192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c694cd68-29e2-4310-3316-08dbbb57d2e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070
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

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Add a device tree node to describe the DisplayPort connector, and
connect it to the DPSUB output.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-zcu106-revA.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index f8019c592a7f..4b8c69407ff6 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -150,6 +150,18 @@
 		#clock-cells = <0>;
 		clock-frequency = <114285000>;
 	};
+
+	dpcon {
+		compatible = "dp-connector";
+		label = "P11";
+		type = "full-size";
+
+		port {
+			dpcon_in: endpoint {
+				remote-endpoint = <&dpsub_dp_out>;
+			};
+		};
+	};
 };
 
 &can1 {
@@ -1065,4 +1077,12 @@
 	phy-names = "dp-phy0", "dp-phy1";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
 	       <&psgtr 0 PHY_TYPE_DP 1 3>;
+
+	ports {
+		port@5 {
+			dpsub_dp_out: endpoint {
+				remote-endpoint = <&dpcon_in>;
+			};
+		};
+	};
 };
-- 
2.36.1

