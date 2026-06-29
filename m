Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3BBC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 09:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF1D584A1D;
	Mon, 29 Jun 2026 11:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xlc75HTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ECC384A3E; Mon, 29 Jun 2026 11:47:05 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42FF784A1C
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1ewxxApw/UmmQAAKhydBwPy1uJNkp48Ge50pxCAsZxs+F5ssiQjvMx0pyk7g0ZPQJjsCBNTR3FilA/4Nmx3cMk6hLI4q8Yo3bwi9EO9tU6YKDSgpJHvzlYjQzfI1WOFBSC/aTAo5P6UGk+4FwHSWZ/revxuFi1wYqdpKPwZvXyR84J/qk7utgURmsbrJwq/DVnGgQnSv8fD5KW/31WCw8zkmr9H5x4+T6DfPIcMJV+4A5wetewNeMiK5tHxAThiuwjDp4Ndlz8Wezjqdev9Q4mzNrsh6RW1bH6nNSrtXm86JKKl+8x0teIDlHfPljGjYeBdljeJP+srPRN4DsfyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMyiqYonFfU9qiZUuBBIhNTnq8c5KkcIiQjkbBKuSpY=;
 b=isPydirsBlRdZjpz96uuNpjWLL14xPj53ieFrUk6g+4b8HN/rJMXGM47lg/s9WUQarn2CDl+zHcMyWMVcAuiuXbBJSS1nbsq8CimZsJTGUeW/mrxJhJKObflbFzysTpCxkS+q/V0F+Za1Ov3cnCRubUN6gD066lNrKtZDP+rq6ypPL40Ke0DPZ64cccJ9ZPBVcVBuybkMGXh7V48Df8VoF7lBWHBu4XRQ+YThuEoHyxxhCuWA8cuU7FdxohUlkIxHMVe7cQ9z7v0hRPw9emhKY/KJh7Tkpq1dFEjSGwb9KRhWgnI/nkSH9wvepnPJni58Em7BPoPfAWQ6Bxm1mtlww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMyiqYonFfU9qiZUuBBIhNTnq8c5KkcIiQjkbBKuSpY=;
 b=xlc75HTHOJrQLXii7aLSwN9oiNZBEmcKs+Fcy+qgccxKGu5NBmR+7JtbE3JbSnb0mSLOO3gVzDNC8u8354WnQMXd/l01tgyigzd9EpsORjwNVjJEXfCIxdGQrFF+n2FCSIXm+7s/jyXkXektI7H4j6bC4SlKIDcLeY07zeMS60k=
Received: from CH5PR02CA0009.namprd02.prod.outlook.com (2603:10b6:610:1ed::10)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:46:55 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::71) by CH5PR02CA0009.outlook.office365.com
 (2603:10b6:610:1ed::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 09:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 09:46:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:46:53 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 29 Jun 2026 04:46:53 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Rohit Visavalia <rohit.visavalia@amd.com>,
 "Tom Rini" <trini@konsulko.com>
Subject: [PATCH 2/4] arm64: zynqmp: Disable ina226 iio-hwmon nodes
Date: Mon, 29 Jun 2026 11:46:34 +0200
Message-ID: <deb2e92d5030a31dbb91b36fa77de3ad2de38a71.1782726386.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782726386.git.michal.simek@amd.com>
References: <cover.1782726386.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=33485; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=4eKbFfPjXEIKnJ6dSkq+3EYmNYrsfbOcEnyno7gXU+A=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ52f21X8a+7mtTgQD3mk8hD1wWfk96GlV4bU5S+AT+x
 mdXf1oXdJSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBENqxi+O+ukbfno+MLTz8u
 v3SD1PXnpqzYF3ex+hLXgTppDi3l0y4M/1328yYlSlqxZFa5+6lxhHg+d/jt6eG794nF6SKjmzk
 JjAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f07658d-83f3-472a-b03c-08ded5c35b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FKmbGAP98bIeXY0rWtxAnx6jR2EQOljPQ5fszE/1NDYYIcS2MYmQ2qJ2D/yMhEQ+lHI/OK0euiKmHlrUu1kh2y0QHhnAtKGVUNG2+mOFUiHkIJAei1CM6TfHE3UZgVPsI1UpTaNaDzJpNutd+0TauuGBSzQWrgLAVM6GkeRFKrEzTTqfaGQseqj58aUwJ1vvq+GlbLZA6x55G1me89Y/Ludb/btXPLWLOIGFa6RzXTzJhFsGm1ho1JoBK3wYM6nOcoGRBrur5dgZz5NcsLb/j3U2P2wZVq/4R80Us71nOxQBHP6tx18wYz6FmzdJAEGInbMoQWCgPtSp92AP8K1d5Pvet86jOn0xgW72QTPT/kNKjNjbwW91RWKbDcM0VzHT9TmhO/ugv+96Hzm/cpmSikfA6dhCgX6DuYeMUfCjw+IVduCQk6RCMnlfBo8dLiR283WhD1Y/KG4UBhgzuxzqhVHZiih920M7+RkFO2/kdQXyFHwVpbZQasTloQxUoJIHb65jxmBKNv0v5KJuSDeWEfqzs2BynAv9yial9A8T2EfMXsDoNQwHeRLYomcLi2xLpbPA0m0bPl7ovGVX+vtqVqRgW/LLcLE4dZmsvHRDikGA0GHuSroAm0QzmFYQWSnIy8uDImQWyq3+UEWqU25D0xi096+hpn1VjSYxTWbcBM1nbLQCmSqMNht2v7XOJvOt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MkHrTsLzBjuqpAdVVaJoGvsTnXEfE3/cq2smYJUl6kiMiRTzzqGtWAoPS8dNEcr6n5gsNdfkvOyPpSceOS18IXojhrCDjONNguOrhZHJUv0+q2I974hB+UsnWHlpd+rJVFYxG/izQbqpFjwNNKxKCLKIYjlqi/Om6HV4NyLoWW8vb5b5VJlDtM0ysibKQM5OWxpKcQWSmlPl7Fqh5+lpijSsjsZeC3zvWl/TBPwTt5oZUsB8qqO2sX8MICVx/79hMSt5FH6bwCfZReG+HxX0ArplKePmQm8c6MLbCKtDl7gcYDsc32vB1qmVBZ4bzNTjV7xS/BQxaQohYwPGzUf0ffrLD8zi8wrYSTzMU+sxG/wdWurVSe1qc8Xp/6yAGPDV0bUQnhI9JzDFvGR38DRoi+F8zbs3sZSxMoE+HJP4mSipZKacdSZQkroOgnsAtXjp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:46:55.6342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f07658d-83f3-472a-b03c-08ded5c35b1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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

ina226 IIO driver doesn't need to be enabled by default in Linux that's why
disable iio-hwmon nodes to avoid warnings about it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-e-a2197-00-revA.dts       | 20 +++++++++++++++++++
 arch/arm/dts/zynqmp-g-a2197-00-revA.dts       |  6 ++++++
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts       |  6 ++++++
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts       |  5 +++++
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts       |  5 +++++
 .../arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso | 16 +++++++++++++++
 .../arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 16 +++++++++++++++
 arch/arm/dts/zynqmp-zcu100-revC.dts           |  2 ++
 arch/arm/dts/zynqmp-zcu102-revA.dts           | 18 +++++++++++++++++
 arch/arm/dts/zynqmp-zcu104-revC.dts           |  1 +
 arch/arm/dts/zynqmp-zcu106-revA.dts           | 18 +++++++++++++++++
 arch/arm/dts/zynqmp-zcu111-revA.dts           | 14 +++++++++++++
 arch/arm/dts/zynqmp-zcu208-revA.dts           | 14 +++++++++++++
 arch/arm/dts/zynqmp-zcu216-revA.dts           | 14 +++++++++++++
 arch/arm/dts/zynqmp-zcu670-revA.dts           | 14 +++++++++++++
 arch/arm/dts/zynqmp-zcu670-revB.dts           | 14 +++++++++++++
 16 files changed, 183 insertions(+)

diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
index aebceb207369..824d189d2462 100644
--- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
@@ -51,83 +51,103 @@
 
 	ina226-vccint {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccint 0>, <&vccint 1>, <&vccint 2>, <&vccint 3>;
 	};
 	ina226-vcc-soc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_soc 0>, <&vcc_soc 1>, <&vcc_soc 2>, <&vcc_soc 3>;
 	};
 	ina226-vcc-pmc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_pmc 0>, <&vcc_pmc 1>, <&vcc_pmc 2>, <&vcc_pmc 3>;
 	};
 	ina226-vcc-ram {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_ram 0>, <&vcc_ram 1>, <&vcc_ram 2>, <&vcc_ram 3>;
 	};
 	ina226-vcc-pslp {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_pslp 0>, <&vcc_pslp 1>, <&vcc_pslp 2>, <&vcc_pslp 3>;
 	};
 	ina226-vcc-psfp {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_psfp 0>, <&vcc_psfp 1>, <&vcc_psfp 2>, <&vcc_psfp 3>;
 	};
 	ina226-vccaux {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccaux 0>, <&vccaux 1>, <&vccaux 2>, <&vccaux 3>;
 	};
 	ina226-vccaux-pmc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccaux_pmc 0>, <&vccaux_pmc 1>, <&vccaux_pmc 2>, <&vccaux_pmc 3>;
 	};
 	ina226-vcco-500 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_500 0>, <&vcco_500 1>, <&vcco_500 2>, <&vcco_500 3>;
 	};
 	ina226-vcco-501 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_501 0>, <&vcco_501 1>, <&vcco_501 2>, <&vcco_501 3>;
 	};
 	ina226-vcco-502 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_502 0>, <&vcco_502 1>, <&vcco_502 2>, <&vcco_502 3>;
 	};
 	ina226-vcco-503 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_503 0>, <&vcco_503 1>, <&vcco_503 2>, <&vcco_503 3>;
 	};
 	ina226-vcc-1v8 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_1v8 0>, <&vcc_1v8 1>, <&vcc_1v8 2>, <&vcc_1v8 3>;
 	};
 	ina226-vcc-3v3 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_3v3 0>, <&vcc_3v3 1>, <&vcc_3v3 2>, <&vcc_3v3 3>;
 	};
 	ina226-vcc-1v2-ddr4 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_1v2_ddr4 0>, <&vcc_1v2_ddr4 1>, <&vcc_1v2_ddr4 2>,
 			      <&vcc_1v2_ddr4 3>;
 	};
 	ina226-vcc-1v1-lp4 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v1_lp4 0>, <&vcc1v1_lp4 1>, <&vcc1v1_lp4 2>, <&vcc1v1_lp4 3>;
 	};
 	ina226-vadj-fmc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vadj_fmc 0>, <&vadj_fmc 1>, <&vadj_fmc 2>, <&vadj_fmc 3>;
 	};
 	ina226-mgtyavcc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgtyavcc 0>, <&mgtyavcc 1>, <&mgtyavcc 2>, <&mgtyavcc 3>;
 	};
 	ina226-mgtyavtt {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgtyavtt 0>, <&mgtyavtt 1>, <&mgtyavtt 2>, <&mgtyavtt 3>;
 	};
 	ina226-mgtyvccaux {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgtyvccaux 0>, <&mgtyvccaux 1>, <&mgtyvccaux 2>, <&mgtyvccaux 3>;
 	};
 };
diff --git a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
index 7c9764c31f7a..bf4ea35067c2 100644
--- a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
@@ -40,26 +40,32 @@
 
 	ina226-u74 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u74 0>, <&u74 1>, <&u74 2>, <&u74 3>;
 	};
 	ina226-u75 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u75 0>, <&u75 1>, <&u75 2>, <&u75 3>;
 	};
 	ina226-u78 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u78 0>, <&u78 1>, <&u78 2>, <&u78 3>;
 	};
 	ina226-u79 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u79 0>, <&u79 1>, <&u79 2>, <&u79 3>;
 	};
 	ina226-u82 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u82 0>, <&u82 1>, <&u82 2>, <&u82 3>;
 	};
 	ina226-u84 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u84 0>, <&u84 1>, <&u84 2>, <&u84 3>;
 	};
 };
diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index f9d7528ff2ed..2bf6af9c0659 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -45,27 +45,33 @@
 
 	ina226-vcc-aux {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_aux 0>, <&vcc_aux 1>, <&vcc_aux 2>, <&vcc_aux 3>;
 	};
 	ina226-vcc-ram {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_ram 0>, <&vcc_ram 1>, <&vcc_ram 2>, <&vcc_ram 3>;
 	};
 	ina226-vcc1v1-lp4 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v1_lp4 0>, <&vcc1v1_lp4 1>, <&vcc1v1_lp4 2>, <&vcc1v1_lp4 3>;
 	};
 	ina226-vcc1v2-lp4 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v2_lp4 0>, <&vcc1v2_lp4 1>, <&vcc1v2_lp4 2>, <&vcc1v2_lp4 3>;
 	};
 	ina226-vdd1-1v8-lp4 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vdd1_1v8_lp4 0>, <&vdd1_1v8_lp4 1>, <&vdd1_1v8_lp4 2>,
 			      <&vdd1_1v8_lp4 3>;
 	};
 	ina226-vcc0v6-lp4 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc0v6_lp4 0>, <&vcc0v6_lp4 1>, <&vcc0v6_lp4 2>, <&vcc0v6_lp4 3>;
 	};
 };
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index b4da0d341c39..fbeae394c620 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -45,22 +45,27 @@
 
 	ina226-vcc-aux {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_aux 0>, <&vcc_aux 1>, <&vcc_aux 2>, <&vcc_aux 3>;
 	};
 	ina226-vcc-ram {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_ram 0>, <&vcc_ram 1>, <&vcc_ram 2>, <&vcc_ram 3>;
 	};
 	ina226-vcc1v1-lp4 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v1_lp4 0>, <&vcc1v1_lp4 1>, <&vcc1v1_lp4 2>, <&vcc1v1_lp4 3>;
 	};
 	ina226-vcc1v2-lp4 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v2_lp4 0>, <&vcc1v2_lp4 1>, <&vcc1v2_lp4 2>, <&vcc1v2_lp4 3>;
 	};
 	ina226-vdd1-1v8-lp4 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vdd1_1v8_lp4 0>, <&vdd1_1v8_lp4 1>, <&vdd1_1v8_lp4 2>,
 			      <&vdd1_1v8_lp4 3>;
 	};
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index 729efd4098cb..33a86fad6047 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -45,22 +45,27 @@
 
 	ina226-vcc-aux {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_aux 0>, <&vcc_aux 1>, <&vcc_aux 2>, <&vcc_aux 3>;
 	};
 	ina226-vcc-ram {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_ram 0>, <&vcc_ram 1>, <&vcc_ram 2>, <&vcc_ram 3>;
 	};
 	ina226-vcc1v1-lp4 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v1_lp4 0>, <&vcc1v1_lp4 1>, <&vcc1v1_lp4 2>, <&vcc1v1_lp4 3>;
 	};
 	ina226-vcc1v2-lp4 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v2_lp4 0>, <&vcc1v2_lp4 1>, <&vcc1v2_lp4 2>, <&vcc1v2_lp4 3>;
 	};
 	ina226-vdd1-1v8-lp4 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vdd1_1v8_lp4 0>, <&vdd1_1v8_lp4 1>, <&vdd1_1v8_lp4 2>,
 			      <&vdd1_1v8_lp4 3>;
 	};
diff --git a/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso b/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso
index 4d0f10e13c38..8bb4dd6e3e7a 100644
--- a/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso
@@ -18,66 +18,82 @@
 
 	ina226-u19 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_soc_ina 0>, <&vcc_soc_ina 1>, <&vcc_soc_ina 2>;
 	};
 	ina226-u287 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_ram_ina 0>, <&vcc_ram_ina 1>, <&vcc_ram_ina 2>;
 	};
 	ina226-u288 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_pslp_ina 0>, <&vcc_pslp_ina 1>, <&vcc_pslp_ina 2>;
 	};
 	ina226-u289 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccaux_ina 0>, <&vccaux_ina 1>, <&vccaux_ina 2>;
 	};
 	ina226-u290 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccaux_pmc_ina 0>, <&vccaux_pmc_ina 1>, <&vccaux_pmc_ina 2>;
 	};
 	ina226-u291 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_500_ina 0>, <&vcco_500_ina 1>, <&vcco_500_ina 2>;
 	};
 	ina226-u292 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_501_ina 0>, <&vcco_501_ina 1>, <&vcco_501_ina 2>;
 	};
 	ina226-u293 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_502_ina 0>, <&vcco_502_ina 1>, <&vcco_502_ina 2>;
 	};
 	ina226-u294 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_503_ina 0>, <&vcco_503_ina 1>, <&vcco_503_ina 2>;
 	};
 	ina226-u295 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_ddr5_rdimm_ina 0>, <&vcc_ddr5_rdimm_ina 1>, <&vcc_ddr5_rdimm_ina 2>;
 	};
 	ina226-u298 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&lp5_1v0_ina 0>, <&lp5_1v0_ina 1>, <&lp5_1v0_ina 2>;
 	};
 	ina226-u296 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_fmc_ina 0>, <&vcc_fmc_ina 1>, <&vcc_fmc_ina 2>;
 	};
 	ina226-u299 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&gtm_avcc_ina 0>, <&gtm_avcc_ina 1>, <&gtm_avcc_ina 2>;
 	};
 	ina226-u300 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&gtm_avtt_ina 0>, <&gtm_avtt_ina 1>, <&gtm_avtt_ina 2>;
 	};
 	ina226-u301 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&gtm_avccaux_ina 0>, <&gtm_avccaux_ina 1>, <&gtm_avccaux_ina 2>;
 	};
 	ina226-u297 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_mipi_ina 0>, <&vcc_mipi_ina 1>, <&vcc_mipi_ina 2>;
 	};
 };
diff --git a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
index 5a4e5f092506..39be25be8f6d 100644
--- a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
@@ -22,66 +22,82 @@
 
 	ina226-u1700 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_ram_ina 0>, <&vcc_ram_ina 1>, <&vcc_ram_ina 2>;
 	};
 	ina226-u1732 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc_lpd_ina 0>, <&vcc_lpd_ina 1>, <&vcc_lpd_ina 2>;
 	};
 	ina226-u1733 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccaux_ina 0>, <&vccaux_ina 1>, <&vccaux_ina 2>;
 	};
 	ina226-u1736 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccaux_lpd_ina 0>, <&vccaux_lpd_ina 1>, <&vccaux_lpd_ina 2>;
 	};
 	ina226-u1737 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_500_ina 0>, <&vcco_500_ina 1>, <&vcco_500_ina 2>;
 	};
 	ina226-u1739 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_501_ina 0>, <&vcco_501_ina 1>, <&vcco_501_ina 2>;
 	};
 	ina226-u1741 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_502_ina 0>, <&vcco_502_ina 1>, <&vcco_502_ina 2>;
 	};
 	ina226-u1743 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_503_ina 0>, <&vcco_503_ina 1>, <&vcco_503_ina 2>;
 	};
 	ina226-u1745 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_700_ina 0>, <&vcco_700_ina 1>, <&vcco_700_ina 2>;
 	};
 	ina226-u1747 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcco_706_ina 0>, <&vcco_706_ina 1>, <&vcco_706_ina 2>;
 	};
 	ina226-u1750 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&gtyp_avcc_ina 0>, <&gtyp_avcc_ina 1>, <&gtyp_avcc_ina 2>;
 	};
 	ina226-u1752 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&gtyp_avtt_ina 0>, <&gtyp_avtt_ina 1>, <&gtyp_avtt_ina 2>;
 	};
 	ina226-u1754 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&gtyp_avccaux_ina 0>, <&gtyp_avccaux_ina 1>, <&gtyp_avccaux_ina 2>;
 	};
 	ina226-u1756 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&gtm_avcc_ina 0>, <&gtm_avcc_ina 1>, <&gtm_avcc_ina 2>;
 	};
 	ina226-u1758 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&gtm_avtt_ina 0>, <&gtm_avtt_ina 1>, <&gtm_avtt_ina 2>;
 	};
 	ina226-u1760 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&gtm_avccaux_ina 0>, <&gtm_avccaux_ina 1>, <&gtm_avccaux_ina 2>;
 	};
 
diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zcu100-revC.dts
index 62f94da334db..81353b60b38b 100644
--- a/arch/arm/dts/zynqmp-zcu100-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
@@ -76,6 +76,7 @@
 
 	iio-hwmon {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&xilinx_ams 0>, <&xilinx_ams 1>, <&xilinx_ams 2>,
 			      <&xilinx_ams 3>, <&xilinx_ams 4>, <&xilinx_ams 5>,
 			      <&xilinx_ams 6>, <&xilinx_ams 7>, <&xilinx_ams 8>,
@@ -135,6 +136,7 @@
 
 	ina226 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
 	};
 
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index a0ef866a259a..4d5f4754171f 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -83,74 +83,92 @@
 
 	ina226-u76 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u76 0>, <&u76 1>, <&u76 2>, <&u76 3>;
 	};
 	ina226-u77 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u77 0>, <&u77 1>, <&u77 2>, <&u77 3>;
 	};
 	ina226-u78 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u78 0>, <&u78 1>, <&u78 2>, <&u78 3>;
 	};
 	ina226-u87 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u87 0>, <&u87 1>, <&u87 2>, <&u87 3>;
 	};
 	ina226-u85 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u85 0>, <&u85 1>, <&u85 2>, <&u85 3>;
 	};
 	ina226-u86 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u86 0>, <&u86 1>, <&u86 2>, <&u86 3>;
 	};
 	ina226-u93 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u93 0>, <&u93 1>, <&u93 2>, <&u93 3>;
 	};
 	ina226-u88 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u88 0>, <&u88 1>, <&u88 2>, <&u88 3>;
 	};
 	ina226-u15 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u15 0>, <&u15 1>, <&u15 2>, <&u15 3>;
 	};
 	ina226-u92 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u92 0>, <&u92 1>, <&u92 2>, <&u92 3>;
 	};
 	ina226-u79 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u79 0>, <&u79 1>, <&u79 2>, <&u79 3>;
 	};
 	ina226-u81 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u81 0>, <&u81 1>, <&u81 2>, <&u81 3>;
 	};
 	ina226-u80 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u80 0>, <&u80 1>, <&u80 2>, <&u80 3>;
 	};
 	ina226-u84 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u84 0>, <&u84 1>, <&u84 2>, <&u84 3>;
 	};
 	ina226-u16 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u16 0>, <&u16 1>, <&u16 2>, <&u16 3>;
 	};
 	ina226-u65 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u65 0>, <&u65 1>, <&u65 2>, <&u65 3>;
 	};
 	ina226-u74 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u74 0>, <&u74 1>, <&u74 2>, <&u74 3>;
 	};
 	ina226-u75 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u75 0>, <&u75 1>, <&u75 2>, <&u75 3>;
 	};
 
diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zcu104-revC.dts
index 0caedc40a519..0f1b1fd92a70 100644
--- a/arch/arm/dts/zynqmp-zcu104-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
@@ -60,6 +60,7 @@
 
 	ina226 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u183 0>, <&u183 1>, <&u183 2>, <&u183 3>;
 	};
 
diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index c0bc46faee4e..ad76159084ef 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -83,74 +83,92 @@
 
 	ina226-u76 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u76 0>, <&u76 1>, <&u76 2>, <&u76 3>;
 	};
 	ina226-u77 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u77 0>, <&u77 1>, <&u77 2>, <&u77 3>;
 	};
 	ina226-u78 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u78 0>, <&u78 1>, <&u78 2>, <&u78 3>;
 	};
 	ina226-u87 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u87 0>, <&u87 1>, <&u87 2>, <&u87 3>;
 	};
 	ina226-u85 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u85 0>, <&u85 1>, <&u85 2>, <&u85 3>;
 	};
 	ina226-u86 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u86 0>, <&u86 1>, <&u86 2>, <&u86 3>;
 	};
 	ina226-u93 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u93 0>, <&u93 1>, <&u93 2>, <&u93 3>;
 	};
 	ina226-u88 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u88 0>, <&u88 1>, <&u88 2>, <&u88 3>;
 	};
 	ina226-u15 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u15 0>, <&u15 1>, <&u15 2>, <&u15 3>;
 	};
 	ina226-u92 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u92 0>, <&u92 1>, <&u92 2>, <&u92 3>;
 	};
 	ina226-u79 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u79 0>, <&u79 1>, <&u79 2>, <&u79 3>;
 	};
 	ina226-u81 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u81 0>, <&u81 1>, <&u81 2>, <&u81 3>;
 	};
 	ina226-u80 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u80 0>, <&u80 1>, <&u80 2>, <&u80 3>;
 	};
 	ina226-u84 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u84 0>, <&u84 1>, <&u84 2>, <&u84 3>;
 	};
 	ina226-u16 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u16 0>, <&u16 1>, <&u16 2>, <&u16 3>;
 	};
 	ina226-u65 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u65 0>, <&u65 1>, <&u65 2>, <&u65 3>;
 	};
 	ina226-u74 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u74 0>, <&u74 1>, <&u74 2>, <&u74 3>;
 	};
 	ina226-u75 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u75 0>, <&u75 1>, <&u75 2>, <&u75 3>;
 	};
 
diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
index f38edd6145f5..a9a473602374 100644
--- a/arch/arm/dts/zynqmp-zcu111-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
@@ -83,58 +83,72 @@
 
 	ina226-u67 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u67 0>, <&u67 1>, <&u67 2>, <&u67 3>;
 	};
 	ina226-u59 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u59 0>, <&u59 1>, <&u59 2>, <&u59 3>;
 	};
 	ina226-u61 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u61 0>, <&u61 1>, <&u61 2>, <&u61 3>;
 	};
 	ina226-u60 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u60 0>, <&u60 1>, <&u60 2>, <&u60 3>;
 	};
 	ina226-u64 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u64 0>, <&u64 1>, <&u64 2>, <&u64 3>;
 	};
 	ina226-u69 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u69 0>, <&u69 1>, <&u69 2>, <&u69 3>;
 	};
 	ina226-u66 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u66 0>, <&u66 1>, <&u66 2>, <&u66 3>;
 	};
 	ina226-u65 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u65 0>, <&u65 1>, <&u65 2>, <&u65 3>;
 	};
 	ina226-u63 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u63 0>, <&u63 1>, <&u63 2>, <&u63 3>;
 	};
 	ina226-u3 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u3 0>, <&u3 1>, <&u3 2>, <&u3 3>;
 	};
 	ina226-u71 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u71 0>, <&u71 1>, <&u71 2>, <&u71 3>;
 	};
 	ina226-u77 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u77 0>, <&u77 1>, <&u77 2>, <&u77 3>;
 	};
 	ina226-u73 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u73 0>, <&u73 1>, <&u73 2>, <&u73 3>;
 	};
 	ina226-u79 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&u79 0>, <&u79 1>, <&u79 2>, <&u79 3>;
 	};
 
diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
index 3c3c94dcadfc..60231d7d3a2d 100644
--- a/arch/arm/dts/zynqmp-zcu208-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
@@ -81,61 +81,75 @@
 
 	ina226-vccint {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccint 0>, <&vccint 1>, <&vccint 2>, <&vccint 3>;
 	};
 	ina226-vccint-io-bram {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>,
 			      <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
 	};
 	ina226-vcc1v8 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v8 0>, <&vcc1v8 1>, <&vcc1v8 2>, <&vcc1v8 3>;
 	};
 	ina226-vcc1v2 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v2 0>, <&vcc1v2 1>, <&vcc1v2 2>, <&vcc1v2 3>;
 	};
 	ina226-vadj-fmc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vadj_fmc 0>, <&vadj_fmc 1>, <&vadj_fmc 2>, <&vadj_fmc 3>;
 	};
 	ina226-mgtavcc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgtavcc 0>, <&mgtavcc 1>, <&mgtavcc 2>, <&mgtavcc 3>;
 	};
 	ina226-mgt1v2 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgt1v2 0>, <&mgt1v2 1>, <&mgt1v2 2>, <&mgt1v2 3>;
 	};
 	ina226-mgt1v8 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgt1v8 0>, <&mgt1v8 1>, <&mgt1v8 2>, <&mgt1v8 3>;
 	};
 	ina226-vccint-ams {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccint_ams 0>, <&vccint_ams 1>, <&vccint_ams 2>, <&vccint_ams 3>;
 	};
 	ina226-dac-avtt {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&dac_avtt 0>, <&dac_avtt 1>, <&dac_avtt 2>, <&dac_avtt 3>;
 	};
 	ina226-dac-avccaux {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&dac_avccaux 0>, <&dac_avccaux 1>, <&dac_avccaux 2>,
 			      <&dac_avccaux 3>;
 	};
 	ina226-adc-avcc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&adc_avcc 0>, <&adc_avcc 1>, <&adc_avcc 2>, <&adc_avcc 3>;
 	};
 	ina226-adc-avccaux {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&adc_avccaux 0>, <&adc_avccaux 1>, <&adc_avccaux 2>,
 			      <&adc_avccaux 3>;
 	};
 	ina226-dac-avcc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&dac_avcc 0>, <&dac_avcc 1>, <&dac_avcc 2>, <&dac_avcc 3>;
 	};
 
diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
index b0f0a74f711e..bfe6f97a760a 100644
--- a/arch/arm/dts/zynqmp-zcu216-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
@@ -81,61 +81,75 @@
 
 	ina226-vccint {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccint 0>, <&vccint 1>, <&vccint 2>, <&vccint 3>;
 	};
 	ina226-vccint-io-bram {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>,
 			      <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
 	};
 	ina226-vcc1v8 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v8 0>, <&vcc1v8 1>, <&vcc1v8 2>, <&vcc1v8 3>;
 	};
 	ina226-vcc1v2 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v2 0>, <&vcc1v2 1>, <&vcc1v2 2>, <&vcc1v2 3>;
 	};
 	ina226-vadj-fmc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vadj_fmc 0>, <&vadj_fmc 1>, <&vadj_fmc 2>, <&vadj_fmc 3>;
 	};
 	ina226-mgtavcc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgtavcc 0>, <&mgtavcc 1>, <&mgtavcc 2>, <&mgtavcc 3>;
 	};
 	ina226-mgt1v2 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgt1v2 0>, <&mgt1v2 1>, <&mgt1v2 2>, <&mgt1v2 3>;
 	};
 	ina226-mgt1v8 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgt1v8 0>, <&mgt1v8 1>, <&mgt1v8 2>, <&mgt1v8 3>;
 	};
 	ina226-vccint-ams {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccint_ams 0>, <&vccint_ams 1>, <&vccint_ams 2>, <&vccint_ams 3>;
 	};
 	ina226-dac-avtt {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&dac_avtt 0>, <&dac_avtt 1>, <&dac_avtt 2>, <&dac_avtt 3>;
 	};
 	ina226-dac-avccaux {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&dac_avccaux 0>, <&dac_avccaux 1>, <&dac_avccaux 2>,
 			      <&dac_avccaux 3>;
 	};
 	ina226-adc-avcc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&adc_avcc 0>, <&adc_avcc 1>, <&adc_avcc 2>, <&adc_avcc 3>;
 	};
 	ina226-adc-avccaux {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&adc_avccaux 0>, <&adc_avccaux 1>, <&adc_avccaux 2>,
 			      <&adc_avccaux 3>;
 	};
 	ina226-dac-avcc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&dac_avcc 0>, <&dac_avcc 1>, <&dac_avcc 2>, <&dac_avcc 3>;
 	};
 
diff --git a/arch/arm/dts/zynqmp-zcu670-revA.dts b/arch/arm/dts/zynqmp-zcu670-revA.dts
index c5b70972ef52..08e887454776 100644
--- a/arch/arm/dts/zynqmp-zcu670-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revA.dts
@@ -84,61 +84,75 @@
 
 	ina226-vccint {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccint 0>, <&vccint 1>, <&vccint 2>, <&vccint 3>;
 	};
 	ina226-vccint-io-bram {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>,
 			      <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
 	};
 	ina226-vcc1v8 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v8 0>, <&vcc1v8 1>, <&vcc1v8 2>, <&vcc1v8 3>;
 	};
 	ina226-vcc1v2 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v2 0>, <&vcc1v2 1>, <&vcc1v2 2>, <&vcc1v2 3>;
 	};
 	ina226-vadj-fmc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vadj_fmc 0>, <&vadj_fmc 1>, <&vadj_fmc 2>, <&vadj_fmc 3>;
 	};
 	ina226-mgtavcc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgtavcc 0>, <&mgtavcc 1>, <&mgtavcc 2>, <&mgtavcc 3>;
 	};
 	ina226-mgt1v2 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgt1v2 0>, <&mgt1v2 1>, <&mgt1v2 2>, <&mgt1v2 3>;
 	};
 	ina226-mgt1v8 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgt1v8 0>, <&mgt1v8 1>, <&mgt1v8 2>, <&mgt1v8 3>;
 	};
 	ina226-vccint-ams {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccint_ams 0>, <&vccint_ams 1>, <&vccint_ams 2>, <&vccint_ams 3>;
 	};
 	ina226-dac-avtt {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&dac_avtt 0>, <&dac_avtt 1>, <&dac_avtt 2>, <&dac_avtt 3>;
 	};
 	ina226-dac-avccaux {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&dac_avccaux 0>, <&dac_avccaux 1>, <&dac_avccaux 2>,
 			      <&dac_avccaux 3>;
 	};
 	ina226-adc-avcc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&adc_avcc 0>, <&adc_avcc 1>, <&adc_avcc 2>, <&adc_avcc 3>;
 	};
 	ina226-adc-avccaux {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&adc_avccaux 0>, <&adc_avccaux 1>, <&adc_avccaux 2>,
 			      <&adc_avccaux 3>;
 	};
 	ina226-dac-avcc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&dac_avcc 0>, <&dac_avcc 1>, <&dac_avcc 2>, <&dac_avcc 3>;
 	};
 
diff --git a/arch/arm/dts/zynqmp-zcu670-revB.dts b/arch/arm/dts/zynqmp-zcu670-revB.dts
index cd96a7a0d136..5c9195239f1d 100644
--- a/arch/arm/dts/zynqmp-zcu670-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revB.dts
@@ -84,61 +84,75 @@
 
 	ina226-vccint {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccint 0>, <&vccint 1>, <&vccint 2>, <&vccint 3>;
 	};
 	ina226-vccint-io-bram {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>,
 			      <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
 	};
 	ina226-vcc1v8 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v8 0>, <&vcc1v8 1>, <&vcc1v8 2>, <&vcc1v8 3>;
 	};
 	ina226-vcc1v2 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vcc1v2 0>, <&vcc1v2 1>, <&vcc1v2 2>, <&vcc1v2 3>;
 	};
 	ina226-vadj-fmc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vadj_fmc 0>, <&vadj_fmc 1>, <&vadj_fmc 2>, <&vadj_fmc 3>;
 	};
 	ina226-mgtavcc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgtavcc 0>, <&mgtavcc 1>, <&mgtavcc 2>, <&mgtavcc 3>;
 	};
 	ina226-mgt1v2 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgt1v2 0>, <&mgt1v2 1>, <&mgt1v2 2>, <&mgt1v2 3>;
 	};
 	ina226-mgt1v8 {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&mgt1v8 0>, <&mgt1v8 1>, <&mgt1v8 2>, <&mgt1v8 3>;
 	};
 	ina226-vccint-ams {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&vccint_ams 0>, <&vccint_ams 1>, <&vccint_ams 2>, <&vccint_ams 3>;
 	};
 	ina226-dac-avtt {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&dac_avtt 0>, <&dac_avtt 1>, <&dac_avtt 2>, <&dac_avtt 3>;
 	};
 	ina226-dac-avccaux {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&dac_avccaux 0>, <&dac_avccaux 1>, <&dac_avccaux 2>,
 			      <&dac_avccaux 3>;
 	};
 	ina226-adc-avcc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&adc_avcc 0>, <&adc_avcc 1>, <&adc_avcc 2>, <&adc_avcc 3>;
 	};
 	ina226-adc-avccaux {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&adc_avccaux 0>, <&adc_avccaux 1>, <&adc_avccaux 2>,
 			      <&adc_avccaux 3>;
 	};
 	ina226-dac-avcc {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&dac_avcc 0>, <&dac_avcc 1>, <&dac_avcc 2>, <&dac_avcc 3>;
 	};
 
-- 
2.43.0

