Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0675CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D387B848DF;
	Tue,  9 Jun 2026 09:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V5SIQxA6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3D938484C; Tue,  9 Jun 2026 09:49:15 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B66E8466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGG517t8+KS1YepNUQKBI08VO6uq4Sbni2FRu4FZ0PIR1D0JrG4tDte9t/JyW5vpczq+dQAsAVnjxALhuyqmTCCXfD02xGR8RVjNO44fiVWOKLZOBFrbKmWX1VzCUV5wt3qs8bai1SqizMraGdmFJsveP/S/WHjiWMt/Vrn9i58V1GQ2iwwsc9qn93nfnSGsHoS5+H4gDBrr0BEkxe51ZJ464R1wrJDXp9E58bYptoIEqlrhIjeUX0olSybFgaT+Z0q0i6XHBRLBJjm3pSEyGqxPtw/YffeXKOzHUjl7sxdBXScvCk7T2NgZU/WLLVYmTS1vPlIZbMT6oHy0sV8vVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln7lFcDH4w560hyJpbB6honoVc3tpZW4mAXuiL/wCcs=;
 b=ybDujgfNw43Rk5WY6sQU4bGWBzKrYOHfp9bnX49XorEMhwN8Jqe53ziUM9/KPpCYixEwjjl1jyjly1CTmX8rfC4+JZcv6ORBw3eTtCDIls1qqW86T1WRzBZxhMm0CVczKm4ZHCyIcVx8uJfwRZsSsXgeFCBDNrBu/8Laco9QzO0Mi2+ScK5DxJ10d201XkA/wXfmHKOQgGhQ5RCRqKgr0FHvQ+I1NqHJUqm/INnChK0gOa8bkg/LdWO/R9sq+XOrlLi5JOA1DcLgpSL+k6D5EIkbAfcxbeB1kOIflhhryCsEFCVTelhBavzy+CWNDw6ZtWoZIwCdOQeGVReEFdUIYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln7lFcDH4w560hyJpbB6honoVc3tpZW4mAXuiL/wCcs=;
 b=V5SIQxA6HTM5AwozODgrarhHpkuFBBJr26DbUeD1MDc6yb8JM5QD0IPfACdihUOja1bKMJ1hIT6LMpAJD65fKCSrdiu+pXojhDo/PbrZ1RcTQ1KewpGdSMm6AjK9hBmUrJib+OXa15AoAo1S2JkCVoyV0bwIPfrekdoeprVx0yI=
Received: from MW4PR04CA0159.namprd04.prod.outlook.com (2603:10b6:303:85::14)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:49:02 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::7b) by MW4PR04CA0159.outlook.office365.com
 (2603:10b6:303:85::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 07:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:49:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:48:59 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 02:48:59 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Rohit Visavalia <rohit.visavalia@amd.com>,
 "Tom Rini" <trini@konsulko.com>
Subject: [PATCH 5/9] arm64: zynqmp: Add CMA reserved-memory for runtime FPGA
 loading
Date: Tue, 9 Jun 2026 09:48:19 +0200
Message-ID: <837e21582e886f1be9f95901109745ac5a8b2a25.1780991287.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780991287.git.michal.simek@amd.com>
References: <cover.1780991287.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19903; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=qAb89SVDU7TzkCqqoDADx7svEwabCuxMyNttFPjUj7U=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSpH3U7kqS7oJ57R1yQS+ex4J6gjIkJp/8ZCGRL5Hqct
 z2Ylj6lo5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACYSrcXIsDm3+/GGCqsXbls4
 N/JNsr1wOD2IoXLlv99Fxh7vTae87mJkOGOYwjrDY4/QPOECVt8ZuRJPMxrXvHIsdbkjuPOl57H
 //AA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: e67c3552-d860-486a-dc7b-08dec5fb92c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099006|3023799007|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: sPnD2ftD1J+bpflhOwQqkrEK5h8+7bBzMtbzsTTEwS4v2S6vuCX+kl4loBsuv+lqmJW1wg4qFWNnxmar3wCRGui89KsKWCUcj8kXyZ0X4uJBk4zLY8cuFjRKcwZFEko0n+UpGRtFiR/J8Mpc7RPKOmkCqu2mI7WJRZkwx43FWzNni3rY+G/M8lucvPj4V7Mjm/eQ1T9g5ci5WaEK3pt3VfSZgxInkOH+Lvzw5Xqatmes3cJN4vxA0PDWivSmFv2rdgmSG9A4TgeqUarhWgiHAEGT/HzDPMdEwphctRZyH/3LU0Bpt6AVpBEGyGd0DipN4DFra39/C5eTnR3yvcZqPNW8UGLyEzeL1kEZC48c/27j2rdB54rgZ31QrPSv1WBnA9qmy9Q7h3bFkfsJMFIbFN/AmyENGAopA3nBN+E3F219qDRP7aQ75osQz86+pCauYmAiF1eyTT/oNDlXZNzOod2NxyixCu467pip9+nd5jMJuqlrRsBP+gQb1nCj8ZsunNuUK740KZFZ1HKukGW6xJAcQKpOz9fNBLGCtOegqTksgZzByh1Y+q1W87RtkEJNk+iZYej2y00YZg6T2jGSVgiIPR94qrmFVqrlYnsesi2EzJsaLcIAZStDyNS7JM8I1/VN6aiLlbBPbnoXbkRv98CgqVlUg0gjLd8kn3a8NmRdSEh3/t34jDA4guZEMY9xjTaYNQfgM+IyNKxdUkv4pu4nxZsb/Z6Z6aj+ZcTress=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rg+DhOl8ga9UQJlhrjGAh9UMr28eG0XqWydX41xKEoE72ulC0sI/h/l5yTjIp7mXa92KgjjSXXMbKLIqQot6ciUd7kLdMUz53wQGWkCsTSgar1QhV9K8Z3bax6M0ucNnRtgggEXev+Di6ulLv6HbHeammUX1hTgHNyXwzSTaS4NwWRBRcG89ZF2BH2QVQFBisDByh8jJZLi7JfQzgOBEbZpcD2hkxugBLK2Lcatu6TBLQM5CsXijcSNU1zQyTmUGGVxDV2PUBmTWS/uTUn8OuFY19NcUPLjwMBlkyGgZ/ByD7OjS22pBmxf7fh0PzLAp8NeHZDCtq7SbuSbr/dYZHq8YKI/ttr8AfugZ4i9ns3cftN2F6UXCraKWrzq1NGtFH+jdTpCVWQuf4aFEAGincrGpwlcOKpV6I8IwddIhGkBBmMX1Wqu4LUrt88GJNhxT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:49:02.2194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e67c3552-d860-486a-dc7b-08dec5fb92c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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

Add CMA (Contiguous Memory Allocator) reserved-memory regions to all
Xilinx arm64 board device trees to support runtime FPGA programming.

The CMA pool uses dynamic allocation constrained to the low 2 GB DDR region
via alloc-ranges so that the kernel places it within the 32-bit addressable
space.

CMA sizes are chosen per silicon family to accommodate the maximum PL
bitstream/PDI size:
  - Kria K24 SOM:                           64 MB
  - ZynqMP boards:                         128 MB

For Kria K24 SOM the CMA inherited from K26 is overridden to 64 MB.
For Kria SOMs, the CMA node is added to the SOM DTS only, not to
carrier board overlays.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sm-k24-revA.dts      |  7 ++++++-
 arch/arm/dts/zynqmp-sm-k26-revA.dts      | 11 ++++++++++-
 arch/arm/dts/zynqmp-zc1232-revA.dts      | 15 +++++++++++++++
 arch/arm/dts/zynqmp-zc1254-revA.dts      | 15 +++++++++++++++
 arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts | 17 ++++++++++++++++-
 arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts | 17 ++++++++++++++++-
 arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts | 15 +++++++++++++++
 arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts | 15 +++++++++++++++
 arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts | 15 +++++++++++++++
 arch/arm/dts/zynqmp-zcu100-revC.dts      | 17 ++++++++++++++++-
 arch/arm/dts/zynqmp-zcu102-revA.dts      | 17 ++++++++++++++++-
 arch/arm/dts/zynqmp-zcu104-revA.dts      | 17 ++++++++++++++++-
 arch/arm/dts/zynqmp-zcu104-revC.dts      | 17 ++++++++++++++++-
 arch/arm/dts/zynqmp-zcu106-revA.dts      | 17 ++++++++++++++++-
 arch/arm/dts/zynqmp-zcu111-revA.dts      | 17 ++++++++++++++++-
 arch/arm/dts/zynqmp-zcu1275-revA.dts     | 15 +++++++++++++++
 arch/arm/dts/zynqmp-zcu1275-revB.dts     | 15 +++++++++++++++
 arch/arm/dts/zynqmp-zcu1285-revA.dts     | 15 +++++++++++++++
 arch/arm/dts/zynqmp-zcu208-revA.dts      | 15 +++++++++++++++
 arch/arm/dts/zynqmp-zcu216-revA.dts      | 15 +++++++++++++++
 arch/arm/dts/zynqmp-zcu670-revA.dts      | 17 ++++++++++++++++-
 arch/arm/dts/zynqmp-zcu670-revB.dts      | 17 ++++++++++++++++-
 22 files changed, 326 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sm-k24-revA.dts b/arch/arm/dts/zynqmp-sm-k24-revA.dts
index 653bd9362264..34ee6af801de 100644
--- a/arch/arm/dts/zynqmp-sm-k24-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k24-revA.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP SM-K24 RevA
  *
  * (C) Copyright 2020 - 2021, Xilinx, Inc.
- * (C) Copyright 2022, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022-2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -21,3 +21,8 @@
 		reg = <0 0 0 0x80000000>;
 	};
 };
+
+&cma {
+	size = <0x0 0x4000000>;
+	alignment = <0x0 0x4000000>;
+};
diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index 0abec77b3f3a..c7fe253244f6 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP SM-K26 rev2/1/B/A
  *
  * (C) Copyright 2020 - 2021, Xilinx, Inc.
- * (C) Copyright 2023 - 2024, Advanced Micro Devices, Inc.
+ * (C) Copyright 2023 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -61,6 +61,15 @@
 			reg = <0x0 0x7ff00000 0x0 0x100000>;
 			no-map;
 		};
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
 	};
 
 	gpio-keys {
diff --git a/arch/arm/dts/zynqmp-zc1232-revA.dts b/arch/arm/dts/zynqmp-zc1232-revA.dts
index 34e5b6edab10..f0e2a0b4588f 100644
--- a/arch/arm/dts/zynqmp-zc1232-revA.dts
+++ b/arch/arm/dts/zynqmp-zc1232-revA.dts
@@ -31,6 +31,21 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
 };
 
 &dcc {
diff --git a/arch/arm/dts/zynqmp-zc1254-revA.dts b/arch/arm/dts/zynqmp-zc1254-revA.dts
index 827143377b96..e92caefd3aa2 100644
--- a/arch/arm/dts/zynqmp-zc1254-revA.dts
+++ b/arch/arm/dts/zynqmp-zc1254-revA.dts
@@ -32,6 +32,21 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
 };
 
 &dcc {
diff --git a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
index 33efdbf0e25e..2897c423f82e 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP zc1751-xm015-dc1
  *
  * (C) Copyright 2015 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -41,6 +41,21 @@
 		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
+
 	clock_si5338_0: clk27 {	/* u55 SI5338-GM */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
diff --git a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
index 13c304520a60..0b1185d862cd 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP zc1751-xm016-dc2
  *
  * (C) Copyright 2015 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -39,6 +39,21 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
 };
 
 &can0 {
diff --git a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
index 796669fc92c0..bfcc92cedfad 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
@@ -39,6 +39,21 @@
 		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
+
 	clock_si5338_2: clk26 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
diff --git a/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts b/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
index cd80aed9a388..9b59952993f1 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
@@ -38,6 +38,21 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
 };
 
 &can0 {
diff --git a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts b/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
index 53aa3dca1dca..722b2e833b44 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
@@ -37,6 +37,21 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
 };
 
 &fpd_dma_chan1 {
diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zcu100-revC.dts
index 4ec8a400494e..62f94da334db 100644
--- a/arch/arm/dts/zynqmp-zcu100-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP ZCU100 revC
  *
  * (C) Copyright 2016 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  * Nathalie Chan King Choy
@@ -47,6 +47,21 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index 9590dd1cd92a..a0ef866a259a 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP ZCU102 RevA
  *
  * (C) Copyright 2015 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -45,6 +45,21 @@
 		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
diff --git a/arch/arm/dts/zynqmp-zcu104-revA.dts b/arch/arm/dts/zynqmp-zcu104-revA.dts
index 3fe7cb410bcf..4479ff735145 100644
--- a/arch/arm/dts/zynqmp-zcu104-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revA.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP ZCU104
  *
  * (C) Copyright 2017 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -43,6 +43,21 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
+
 	clock_8t49n287_5: clk125 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zcu104-revC.dts
index 21ce50e1da93..0caedc40a519 100644
--- a/arch/arm/dts/zynqmp-zcu104-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP ZCU104
  *
  * (C) Copyright 2017 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -43,6 +43,21 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
+
 	ina226 {
 		compatible = "iio-hwmon";
 		io-channels = <&u183 0>, <&u183 1>, <&u183 2>, <&u183 3>;
diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index 0ac1472c55dd..c0bc46faee4e 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP ZCU106
  *
  * (C) Copyright 2016 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -45,6 +45,21 @@
 		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
index 7894daeca943..f38edd6145f5 100644
--- a/arch/arm/dts/zynqmp-zcu111-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP ZCU111
  *
  * (C) Copyright 2017 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -45,6 +45,21 @@
 		/* Another 4GB connected to PL */
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
diff --git a/arch/arm/dts/zynqmp-zcu1275-revA.dts b/arch/arm/dts/zynqmp-zcu1275-revA.dts
index b9d51fadc2ab..1a49ae3ba4e4 100644
--- a/arch/arm/dts/zynqmp-zcu1275-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu1275-revA.dts
@@ -32,6 +32,21 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
 };
 
 &dcc {
diff --git a/arch/arm/dts/zynqmp-zcu1275-revB.dts b/arch/arm/dts/zynqmp-zcu1275-revB.dts
index f26d9843243b..1b6f7a605d6f 100644
--- a/arch/arm/dts/zynqmp-zcu1275-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu1275-revB.dts
@@ -35,6 +35,21 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
 };
 
 &dcc {
diff --git a/arch/arm/dts/zynqmp-zcu1285-revA.dts b/arch/arm/dts/zynqmp-zcu1285-revA.dts
index 86a3217f9ab6..b2d71f0f4556 100644
--- a/arch/arm/dts/zynqmp-zcu1285-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu1285-revA.dts
@@ -36,6 +36,21 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
 };
 
 &dcc {
diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
index 70b1e81e304c..3c3c94dcadfc 100644
--- a/arch/arm/dts/zynqmp-zcu208-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
@@ -43,6 +43,21 @@
 		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
index bc0ca24ff050..b0f0a74f711e 100644
--- a/arch/arm/dts/zynqmp-zcu216-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
@@ -43,6 +43,21 @@
 		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
diff --git a/arch/arm/dts/zynqmp-zcu670-revA.dts b/arch/arm/dts/zynqmp-zcu670-revA.dts
index 1215babe2146..c5b70972ef52 100644
--- a/arch/arm/dts/zynqmp-zcu670-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revA.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP ZCU670 (67DR)
  *
  * (C) Copyright 2017 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -46,6 +46,21 @@
 		/* Another 4GB connected to PL */
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
diff --git a/arch/arm/dts/zynqmp-zcu670-revB.dts b/arch/arm/dts/zynqmp-zcu670-revB.dts
index e91f280e4576..cd96a7a0d136 100644
--- a/arch/arm/dts/zynqmp-zcu670-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revB.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP ZCU670 (67DR) revB
  *
  * (C) Copyright 2017 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -46,6 +46,21 @@
 		/* Another 4GB connected to PL */
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x8000000>;
+			alignment = <0x0 0x8000000>;
+			alloc-ranges = <0x0 0x0 0x0 0x80000000>;
+			linux,cma-default;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-- 
2.43.0

