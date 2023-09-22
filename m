Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D53CD4F57
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2B7F86B49;
	Fri, 22 Sep 2023 12:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1J+z/J+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3309D86B08; Fri, 22 Sep 2023 12:36:57 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE0B086B49
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fL2onOOQFmc4dnchJGsw/I9SQ5abmuoBl+SOnWvzHW7BiBzgde3y4ku8CQ/Z42lvQkhCWlE3NJd88H2WtDMjFTCOMYxWIcejLzbQo6uuU/g+lAPqG/VU0edIvQD0ParE0NVlb8fyaw2xoE39TtmG9yHQrHn1EZAgTrPxxYayTlzn/FlBUzLqIidpPws+LmSvmJ8Wb1y8CXA5XD5awemBzpumGM40js+bmnD/Y1wKH0lozdcyereJ5X4nQIBsppvsXR2JpnrbPoqsZi5ttvPvvxB1RHuwZWQLOS3Mm6XuufMs9mX9b9uLPbVLzdIYkTB8MW/grR3dhBlpp6c7n7B+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IChuz7Z8dBoK00HP6XGwawYfPukiq0ktMDoSffcKIus=;
 b=EYxYoz7wnWc1a/+62h06CmbvzG+zsKHicJsXQX3OliUQTe/A3bFF4HW9x3mNiHSUPPq4V6H2LABh34/nKJO+oDbEOqAx0JScLH8uJKMiSR6DM9qfMbbCqEmVc1qnhTg0cKeFdnILTLy7XuoNAJM6RHAZtmkpcJPX7M+FLj5rqxp/W/plw1PRANKUXyhIWoMjDOEsqernXBeOOFLf9IMkf3L7OUsftgYq74uJu/BU3YLdgT+W+42WEx1nudVsX0Rpj9Ax+gF2V5Xxl/ZQKzunlLRmiJACA8Adsyepd28im+R+ZbDFB492FdFThA347noky5kqO78Z0WDffoKWqk3kLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IChuz7Z8dBoK00HP6XGwawYfPukiq0ktMDoSffcKIus=;
 b=1J+z/J+kM/VA+vbrWHPk+uE4wkdoKnAWfy8lu2I0dzpu9zAbN8HGEyV+CboThVIpx5cFRaQqJDZqrqYEDYuzRd+44IiR4+F3kfqAU02+NZaRtNX5JKyvq2iEtMoZE88mYcHMekR0wLSwx8SeVhO7qdt0M/AOvEkUM/3Nee7/oj0=
Received: from CH0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:610:32::14)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 10:36:50 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::e9) by CH0PR07CA0009.outlook.office365.com
 (2603:10b6:610:32::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34 via Frontend
 Transport; Fri, 22 Sep 2023 10:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 22 Sep 2023 10:36:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:36:48 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Robert Hancock <robert.hancock@calian.com>, 
 Simon Glass <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 10/14] arm64: dts: zynqmp: Add ports for the DisplayPort
 subsystem
Date: Fri, 22 Sep 2023 12:35:39 +0200
Message-ID: <1c91420e90bc823d7529834c33438216857c7161.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=SpWg5V/pMZULubhDRZxPBtuo3HZ7Jv6bmTHsjlLX8Zg=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3OlOTXM0ej4V7p92tIfV9GNt2WkHO+HGxQaX24PtY
 jrbT/l1xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIm0ljIsmKZvlMCWnzHD+1Ps
 jTt2T3enelhkMcyvLn7G09OzbEZwSKTuU07vCNEpUh4A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: b12e7a26-188b-4315-f2d5-08dbbb57d465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Wx5muL/kP3AoKQrC3GgvJag25yFlY3aMj6fSikyp4BpxKRrCDk2/fT1LmePjOrIjhQzHhsvaMJevW7NnqWofB6r20HUXk66InWgbxxUApDZM3y1wQ01KDQa+1aVKGwlrb4jkrQ/cw6iXDpYyefjHA8SCv61EXg1eDyFaGFH13jh1LxjY8j8GDmyBnwEfDulCkSBZlehEkvEeapNeNJ4+J0xA+fGtVfxcqG/XNJwGaFu7wYIgWWT3pPSSC6Un9AIbFYpPQp2c9uJuhrRgM0jm4oZFHLlU5W4eCnClNhQJuzbCVpxa1u2Xq8vkU1ww3rlFKNN57+sP8q1JSe8CjOXaRN/ogg9Pelv3at1RmmQ3f9YzFIMT+DbEvUmecpjHp+M6rhI7vt6f440HfAQsv+3s2np9oA0Kg1AprRCP4+ULCNMWvNQ/tYXN/mJCoLiDl27B7CLafzpdz9q6fy906nEhQlanX27ZF140OiW0J3+WewnOZbLG/l/15rHxgc2BBeylFE+mCHDi2CVRvA4H2NTO8VEsd7GpIubCuuMl6hviz0l2NIF04+OB1oTyqf8ox9dbvLrl5+AJVYJW67lDBGvz1vosqbBTQW6OhgsT661xzMwck4kwp50OniG1BWKwMFzXQVhKUpl0tfyddMn0slmQlA9V/vEMhmwn3PeMCPonoK68ewH8pWiHennmDAiIsnjt+lC9F3wd5VLuVjnvfUH5/sMOsnGUV+jDqW5ijDtWznLC8Dx3QWdaGtutIVLGCtLMVUjNgNashEuuYiZPfEB6Yh/BZfRKpCIwO3SlpkY0TE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(82310400011)(1800799009)(186009)(451199024)(230921699003)(46966006)(40470700004)(36840700001)(6666004)(82740400003)(40480700001)(356005)(86362001)(40460700003)(81166007)(2616005)(16526019)(26005)(36756003)(336012)(426003)(110136005)(44832011)(316002)(70206006)(54906003)(70586007)(2906002)(47076005)(36860700001)(8936002)(8676002)(4326008)(41300700001)(478600001)(5660300002)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:36:50.2275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b12e7a26-188b-4315-f2d5-08dbbb57d465
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
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

The DPSUB DT bindings now specify ports to model the connections with
the programmable logic and the DisplayPort output. Add them to the
device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Link: https://lore.kernel.org/r/1f367ee9554af5d67c86f206e1d6889cc99f6f45.1695049771.git.michal.simek@amd.com
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 20a954e69db0..f03c201caee9 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -1075,6 +1075,30 @@
 			       <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO1>,
 			       <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO2>,
 			       <&zynqmp_dpdma ZYNQMP_DPDMA_GRAPHICS>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+				};
+				port@1 {
+					reg = <1>;
+				};
+				port@2 {
+					reg = <2>;
+				};
+				port@3 {
+					reg = <3>;
+				};
+				port@4 {
+					reg = <4>;
+				};
+				port@5 {
+					reg = <5>;
+				};
+			};
 		};
 	};
 };
-- 
2.36.1

