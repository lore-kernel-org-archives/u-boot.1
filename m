Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13377CD4F49
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 013A386996;
	Fri, 22 Sep 2023 12:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oI+bzctL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01CA386784; Fri, 22 Sep 2023 12:35:58 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13443864AA
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1rOd8eceh/vJJLqeZRipjp84qQ7+YIXoFgJj9Oo/tsOeCz8Lzsn3zuk2CBXu8T8+4z1M7maJLhMBPNAP5N+hK6ooTvkcPLiT4rCZtNSDDYa+tqk4r7qXDZ32etg1H+BOVwqguUokhESQPh+VPVgFdVs6ZdHH7MIMGZM0BnI3QIaHB/piXHF4+3f5X0eVlzWOVX4hfyNO7GCRCsdfIXwUVxw7wDcO4ZVjefjcKC0zbJnIhfYzEtIWYoHx5UPsnxPWEFWHtYSGeF/2SadkyCY/y0GeXxCz0hdfrmVeIWrTp8SdG1uuVAAxzRAmb7Rt+tdozWdT9OdBWvqATHNQLRM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL3zrXWW4qG0tb0BVT5adVdOCnkNKrmgOOUBqGVIVfI=;
 b=hzeNsNt+T7EAkvAC8rklBg72K8aWMWfTwkRoKDJbbNxZ2XRcBKT6tJgCUCe+xkRwOxReB+6gL/ZdAg8MGQoAdx8Z55b8xsr/HlFc37/gkaiauBI5vLdRfaOVV9wDk8vG79e7qZHfz+bQ5Qs2jt+N1K8q6m3cVugW3NW2kzyHqHu5dGLbtzvd+jVKNqRmSGPsJceGrAKuvMUWM0C8lFtPJet9Rvdlj05L5kk4UE4ZI3EqK9dZd+c1sf7mswbbIa738t0e4PEchACRAKwcoBaPY5GJAYcaMFPcyVAMWJh1KA9Q0UAfUPeP6gkkvoDYWzwzCSqSj1Z900llXNMHNyJ4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL3zrXWW4qG0tb0BVT5adVdOCnkNKrmgOOUBqGVIVfI=;
 b=oI+bzctLrwJHGor4BGOY+lNzv3VvXsyjOAI9K4wcAtxKK5FS3CkpsoMyRP2dfT6h3zoZANEYed4Ll9MOvRAxqOY5mCoQswnsThB+po+GM002LMOXQgkbAb0AkFZF4P1tzMEN52Cs/zgnbl+X/zjQaeEMHfeO6Pj9oFpquUHA2RM=
Received: from DM6PR08CA0046.namprd08.prod.outlook.com (2603:10b6:5:1e0::20)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 10:35:53 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::34) by DM6PR08CA0046.outlook.office365.com
 (2603:10b6:5:1e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Fri, 22 Sep 2023 10:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:35:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:35:50 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tanmay Shah <tanmay.shah@amd.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Robert Hancock <robert.hancock@calian.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 02/14] arm64: dts: xilinx: zynqmp: Add RPU subsystem device
 node
Date: Fri, 22 Sep 2023 12:35:31 +0200
Message-ID: <dde364939b4fbe3f7be7b6f5dff42e7d8b2f5c46.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=HiT2QSLW3xZSW8XgXD0JQgFj37PnuBCcoxuRkO0KDKI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3CnSWQwXnFpKJ5z/r91sLJvxe8/zIxkL1kxUZ9puJ
 BFUHyfaEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACZi6M4w33/9f/kNOvuSIt/N
 L98Ykiy348rKfQzztBc2a+8P+5l27bDZsTa5nqOt+vUSAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df2ccbc-e648-4b63-5bcf-08dbbb57b1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FF0Ax5mrY/7/gvjsi11Iv77Q/U5lMBdtQTOHLMFC23DEA3G4OCgS6y8qCwNd+IVZdIa22174mn4wBe1z1xxeIEUTjzJT23QaQsk8RU0Jy3gE3Nz3T9Kxyr7V7mOqhUqcK8aU4ckx7WyfrvSrhOCYcZOSWUdM4v5GH9o0w0j1qPfcrEymKbSwIbgnPVM+HcOx/A3cjJx4zARkx1WV2P5tXY4eDsHwIy5gVl4s/lYyv1i5A1L3taXhyOnWTqiunKkN6HMkWqK6+pZkG78OJXZmEn0D/l++6bj+CvOtpN61709ANinVqc79Ptuti2TyNLh4ZWoOxXuyDI6ZzUNkODRJ3Q5lYQGiXaU886ym39e7wxZxb63SC3jOBqssdAdsen6+FhwgJNSKsHMbNI5aWIf/OABstV4q8ez6TIUJ7LlcKh67AvNbPtEVB9KxL7uvBXEBJbg3QEM0EGTg2xhcgAiAAKgPOmQL2RlA0LxoLLomKWR4cPD7LGePJR+0Ut+OA0e0qL9SEuJkzNYnjR9SRx50RYgmFnxxvbkA3DL/E1krRJaYs6ojLhv9dV87LU7qeR1IwioESWPsz6oUoBLRnrQ2Og/PUotMamZv1qc3pPd+QxLyVBmNwKiyjbZz7WmR3ivewIoeqSeSgqOKasELODoWRZO1W5xBK43rbmzeW45AOJ87GJXH3CyoNTVQFZ9EokFTR6TavNNtfAmgWzNxlVvjBmciQeW8ih4Hd7diieAxpBDjMrhSHFWSY5oyESIWyxWJC+zQQBTP1aAElh2EKGcyNj9F3WkfcTwFjufGQhkpcJfSWyJJd/G/7qUnamQZRpat
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230921699003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(26005)(16526019)(4326008)(8676002)(8936002)(2616005)(83380400001)(2906002)(47076005)(5660300002)(40480700001)(44832011)(36756003)(426003)(336012)(36860700001)(81166007)(356005)(6666004)(86362001)(82740400003)(478600001)(316002)(110136005)(54906003)(70586007)(41300700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:35:51.9491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df2ccbc-e648-4b63-5bcf-08dbbb57b1a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565
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

From: Tanmay Shah <tanmay.shah@amd.com>

RPU subsystem can be configured in cluster-mode or split mode.
Also each r5 core has separate power domains.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 951f3f795e97..5c67c6f602f2 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -120,6 +120,22 @@
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		rproc_0_fw_image: memory@3ed00000 {
+			no-map;
+			reg = <0x0 0x3ed00000 0x0 0x40000>;
+		};
+
+		rproc_1_fw_image: memory@3ef00000 {
+			no-map;
+			reg = <0x0 0x3ef00000 0x0 0x40000>;
+		};
+	};
+
 	zynqmp_ipi: zynqmp-ipi {
 		bootph-all;
 		compatible = "xlnx,zynqmp-ipi-mailbox";
@@ -248,6 +264,23 @@
 		power-domains = <&zynqmp_firmware PD_PL>;
 	};
 
+	remoteproc {
+		compatible = "xlnx,zynqmp-r5fss";
+		xlnx,cluster-mode = <1>;
+
+		r5f-0 {
+			compatible = "xlnx,zynqmp-r5f";
+			power-domains = <&zynqmp_firmware PD_RPU_0>;
+			memory-region = <&rproc_0_fw_image>;
+		};
+
+		r5f-1 {
+			compatible = "xlnx,zynqmp-r5f";
+			power-domains = <&zynqmp_firmware PD_RPU_1>;
+			memory-region = <&rproc_1_fw_image>;
+		};
+	};
+
 	amba: axi {
 		compatible = "simple-bus";
 		bootph-all;
-- 
2.36.1

