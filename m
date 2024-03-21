Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743D4C54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 15:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC8F287D9C;
	Thu, 21 Mar 2024 16:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YMaKOrlL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A5687D08; Thu, 21 Mar 2024 16:55:15 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5EEF880D2
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 16:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAn6migB8ajmhvugGrI8nPFsHRakPkGMY3fIeaa2GW2p4rjxh0UpZaO1nM+IPOIBYNOY/SiwxNrUWIxfUveLT0W6Grf9vn5JL7AYsh9IbtfWg8jyYVX13gwMpefjvG1RSwvaMDn7SmcXwc6m5PugUZkke50S1P1UksvAZO9VSJBv1phIoDE1LWT0bg0qyw3J/EjfwVBxTXYkaujnp769c2PcVDvAUf6lQ2fTb8ijiqxWI2l5SRyrEBuK3R6CEln9Qx76u3mFCciC6PmwTxsvA4pcF9eHpKdYRVE4q2c/H9UefE6nB7Vh8z0kNeYXyhAL+lQX7qN3M+LAS0Kgk6C7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r//mplilx0HPEyHPQO7JCa5Y+cs7ZS8j+IngV2JXA6Y=;
 b=adk/bxwG/q86bAu/YE6E9nksJPxBFaIhmT/aGu0HC3AqKyouibiRfkaFoiRosIYtbnDfaWRIcgvbu0s3Hj4WcEAzz7Ov+T8bQxDYRIetKLt2tt2ED0CyQK5Qzi2Bq1ue+3U5z8lecUxS6BmbsTCI0IflXvjHgMDoVQHa7DtyzC5/O9D8Af+cMnwed5sBpZjH4fLV8jw3Elvux1DNLLQWiaB/aeFaVoe6MwdonnJyfqSLWjQaMYLAqNyT0gV3LDLzgsYWmoDRCoGk0WP+bu1CWZdDIgaI91WQ6lpuMe+VnitkgLS4/LLIIvjuDeU4HfGpMII+KEaZgLnlM91VuNyNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r//mplilx0HPEyHPQO7JCa5Y+cs7ZS8j+IngV2JXA6Y=;
 b=YMaKOrlLXvjdWFo+fSZ7/BAmCE9hiIU0TNDxzMr9VgPT4hFheiYgNyXld/CljWqKers3od+TNW00w8C5m4jOZqHqgxYuok3asi8RzrV9wXZ96OgIRZEJmjVqOmUdMYIfQmEC7LPjKuDv+49RBPI+P4C5nEhZQUcwXd9tRxEBShE=
Received: from BN9P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::32)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 15:55:06 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::9b) by BN9P220CA0027.outlook.office365.com
 (2603:10b6:408:13e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Thu, 21 Mar 2024 15:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7430.0 via Frontend Transport; Thu, 21 Mar 2024 15:55:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 10:55:04 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Vishal Sagar <vishal.sagar@amd.com>, Harini Katakam
 <harini.katakam@amd.com>, Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>, Neal Frager <neal.frager@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Describe DisplayPort connector for Kria
Date: Thu, 21 Mar 2024 16:54:56 +0100
Message-ID: <c8738cb9951c73c6c00a4ce8d0025fb372372346.1711036494.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2196; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=2Ugr0bk2S+TT7wf+2j7xW9l47fgV8rsnVfaVbib2Pc0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ/EYEXZN46yj7cHXbJNnr/u7tJOs/9o/7tmVf7eiGDA
 FtR2Z09HbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiPnMY5tfd+5y4MLM0qPZz
 C1+PWcDBczWNZgzzbHI5TZauTiu1W6H1jv1zW3v9npbbAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: feb0128b-9dcf-492f-80ef-08dc49bf4746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsG3y505KvOUSGpgNJ1Y6k74CX29htFtECG6I8cLJ0EMjcRsurvtsLflRUHShDchBTaFle+RBXx1RZIjv+bhgTv6CfqqK5CZR0rbG5GL2/Qw+XCCNI3wO2AopRqZe3epJOqMHUBJmmJZ8tt+RgR0mDWtsJyGT5g5NLrb9VdIpY+B57ZxCTKQHv5WbhFKvmzTQZgm/SXq18M9vurdXW8sDKiIsK684S+fT7p+aUlROPz0t8si3LH4ca+1926vsV5KyzhiBjfCSa34Od8/B9TgC+cE2A8nyCBc2bFjY4CqCsooIKn6vHn62kKM+31HPkheHWg/Jak/WnKdqjm2n3NEzRFLCmjxSzcK+OcL6JsS5nOdDDplURPTpokdNdNs5tp1KpuRrz4bsAwRBtjW/l4ZGCMPaV+WDCQRT73MZRfkvONTVWdA7COpuN5ASwhbMj0xsUMjgHjx7JkwERWEzIRk2H5JhNUKz9dLdmbgUIQrZmdPMe53Voi12O485PhKdoHqphhvljP5dwe/7THuS1ZSZVwLFMQyKm4H4t/+xV4u6voskqH4xsl6nz+dsXG2Ul1LSniUzm4MLndu+OTn+BNWW5o/tEpFazhpcv03V1OLnpMpsgmMxilVS27jqZvmkFPwcQIj4s4k19Q7I2CiKY5E/hrT0PHyOGys8cBhXzeQ4+7K/IBX2GeDF/tQL/odEbyFAT5dPTtt5ndGDD9b/2rKnYDwgnwK9IdSqNtUzDH+lCq3A8WZT/aIhq0RBLGa+HyY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 15:55:06.2214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb0128b-9dcf-492f-80ef-08dc49bf4746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
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

From: Vishal Sagar <vishal.sagar@amd.com>

Add a device tree node to describe the DisplayPort connector, and
connect it to the DPSUB output.

The patch was tested on kv260-revB/rev2 and also kr260-revB.

Signed-off-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 20 ++++++++++++++++++++
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index 6c29f6574134..0a0cbd2b69ae 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -66,6 +66,18 @@
 		#clock-cells = <0>;
 		clock-frequency = <74250000>;
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
 
 &i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */
@@ -130,6 +142,14 @@
 	phy-names = "dp-phy0";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 1>;
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
+
+	ports {
+		port@5 {
+			dpsub_dp_out: endpoint {
+				remote-endpoint = <&dpcon_in>;
+			};
+		};
+	};
 };
 
 &zynqmp_dpdma {
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index a4b4465d2038..a449c1161b1e 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -63,6 +63,18 @@
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
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
 
 &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
@@ -97,6 +109,14 @@
 	phy-names = "dp-phy0", "dp-phy1";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
+
+	ports {
+		port@5 {
+			dpsub_dp_out: endpoint {
+				remote-endpoint = <&dpcon_in>;
+			};
+		};
+	};
 };
 
 &zynqmp_dpdma {
-- 
2.44.0

