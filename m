Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88361C47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 07:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868CC87B1D;
	Mon, 29 Jan 2024 08:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fnwwc6AT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E107387CAD; Mon, 29 Jan 2024 08:46:55 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 960E287AEC
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 08:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3yOHC8F662Wf52SrRH7nlx3h2BmCHtsgk4flSn3Euf8XzTtZjdZ6XICo6sZqnzvveN+xAvmXKpNCUYeIBvcAUjF9CumWJNSaTS/RvnGG6VjdVgvg4scSWVDGCRXUIsNs5oLYyGIlMUsfY9SKbcIOcPI6XPtjji3Uusihit6vcpl98cdOd3rQZdT8+m6msHnBrUjrsbbGjicrEElsVz8SLADooh+toiYtsGlA/TvWsAlhw3+beAclzx8pEXAEIjSmcd995QobigZe3RuKtTTp44YXvcri7GLA5v/wWYBzrUQ+xrJDQPMGpdvqMGuf4p+FRMRSscS5w8cGBXz5damFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsspJr+GuDzqHeAiNLWDtM+TRH+q0AfdTfP44jKveNc=;
 b=n1PaorzME+AYIQu0z1h0JYTZpNX248mgZtC05fPNvsetaWUKGo1yzzTfC7789jeXE14U5U0RbbAKbyDVMBD62cf8gnX+a6VvP/k0T7iA9TXTEX/OheGnkY+ivPCgeXJ8DHEQCJPxQM46IhEKSwc2TA3qhgBZ5QYXYiyPjw5BAcRWXZ/BIJ/R8dp1JBzQkls4/FGhJHBHsZgM5Hsdyb06JvrD2U2nz73Jw4my0ZxgWewgT+6zYzdnxIshJRmWPSbOemysjoT+RyaetxbzlqBDAYLwNECaCZRkslalEAHq+mAP2n9X0LhhWpkQMN613JffYr+wIMEiBlySsBBZdiV3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsspJr+GuDzqHeAiNLWDtM+TRH+q0AfdTfP44jKveNc=;
 b=Fnwwc6ATOIuRoddos0KhFSQkglaZtGMFF3LDG+Aki1deglJFjqlHSnsHpMJCuj7jSvktW6px8CLCN01sNZkYnR1nZytZpNrA1XL93rWec0Kkc2zuV48jeQ9ruNk5trVrzXzLz/CoeeSmtqwFdncg19QceKgo26AL6JRfgDn3A2w=
Received: from BN0PR04CA0027.namprd04.prod.outlook.com (2603:10b6:408:ee::32)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 07:46:48 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::57) by BN0PR04CA0027.outlook.office365.com
 (2603:10b6:408:ee::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33 via Frontend
 Transport; Mon, 29 Jan 2024 07:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 07:46:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 01:46:46 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Harini Katakam <harini.katakam@amd.com>, Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>, Neal Frager <neal.frager@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Describe 25MHz fixed clock for PL GEMs
Date: Mon, 29 Jan 2024 08:46:43 +0100
Message-ID: <c430aeacaa76d9f61ed3f874f721a33049f45eb9.1706514396.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=2apgEA6u5aZkRXv8Us3lqljsmCkS1p9on0g3DRRplqo=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTt4fearZJXtP/9xdl7PCc/TVLtoeqq5RnTqvs/l/f0i
 859Omt1RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIknsM8/SS7397FzS5/pP2
 LS1OL7Paa3o6TxjmO7BHN3Se+r565SOlKS9Z9au4/HO3AgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fae7a0-8584-4cce-49cb-08dc209e7269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMla7QyioSfZ8kyannKBHkLGgGIFiepX9uNL4eOoA8KwyuJWUaH55S+lCKr4xERISUWFgyIhIbRP7wf//BFIBHJ6suRrQUYbhqZeSCK8+7LxLZL8pUaxz63t+4dVYCJ+NmTra+y9E4eODA7aQ/EEv3YWqTmFGn27oQ9E/poGQca2jPW++297UrKeMYgPppAlmtKAmm3drtsgtn9rA3jictA4w6vpHsImNdEyAPAzQWU1wAAB6xH5jt/WMuTx1uJf2JnN44qpYgo1ocFefzZRJru9lDgsR9BCNygRWMldOWXLUkh8rDQagpD4G350Qbk7sjF29UdlkorNTJzu5lmhzB92V1tqcDgsgzcz6g6fhQ3N+LEftJXzCW9PlLJzb25HKTIPOHT/j28/FnQkWimtEnGJw4zG40GGoMuOibeBmyLEG//xM012bx+K7adRP9Q7xedP9vY9Phgk9v5grGsPNuciEiSHFN68Oi2Ny8lrJrXfhecXGKvI70P4I3a7+OxP7OXl0UN1/deg+qpOIs4Egp4cuHK5Kioep3hMJxHmX2rg7L5iKp4qNsGqeMciVaWaeRLE4Qopj0u3QPzsbv2JqrudSpk/JRXispGmc/09gfs7LB6zU1teTb3yaOOqMfKnXeUw+IYn4nPdoXPB01anrYNlQtou419YAyQFp6pPUFOcf++HadBzcRQtpMk94D+xqyB3rkEDstxA+giCJTi4y3aaYJXk8r8Mms+Y57ODiTuMxJt6RaHS5QbgpNGb3QHm31aSWfp62srBNJoOvugIzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(83380400001)(47076005)(6666004)(40460700003)(40480700001)(44832011)(36860700001)(5660300002)(356005)(336012)(2616005)(426003)(478600001)(26005)(16526019)(82740400003)(81166007)(8676002)(4326008)(8936002)(41300700001)(36756003)(86362001)(2906002)(70586007)(70206006)(316002)(110136005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 07:46:47.5723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fae7a0-8584-4cce-49cb-08dc209e7269
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
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

Describe 25Mhz fixed oscilator which is providing clock for PL based
ethernet IPs. Physicially it is one chip but it is described as 2 fixed
clock to be aligned with other SOM versions which were using integrated
clock generators where clocks could be adjusted via i2c (si5332 chips).

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index 766f78303eee..b3fc17cbd577 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -32,6 +32,18 @@
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 	};
+
+	clk_25_0: clock4 { /* u92/u91 - GEM2 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	clk_25_1: clock5 { /* u92/u91 - GEM3 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
 };
 
 &can0 {
-- 
2.36.1

