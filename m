Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C307C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B057487E10;
	Tue, 30 Jan 2024 15:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Goc0cP8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A59CD87E1E; Tue, 30 Jan 2024 15:51:15 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E6028309D
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW/GRdAI4MXAHZzcoHfxfrL3LBYFkKb1nLfDeL0j4E+ExvX+EF+/rqdImPEOcWE+zND4rJW1gWcGZblXdGUO84yLGm9zEQYGOC5c+Kcs+5rCccduhvbRzWKjxu/RVHRsECgvef1gfAA8iFo8sm67kmyXcKZmG4FDq1eAqV0IoVzIXM0xmbtU9mBn5DzPcFZrYD+oVPx8wm4NuoyELrlDXRlgrf9yU0dMDi/5OUOWqOgQzn+yAFxaJzDf5HR3O8UsrpxOll54FJ30RrGEyKUEyvcaXQmGSgk88Jwhoqil/LhRAhIGkvFsxJEuEoRib9pbYXc2e3Vfa/TM51CygvimzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UU8hyXaAE2TDGdnO+cSdqoNAdNnjiC3j7RcCHwECqS0=;
 b=YyRrMLwEFICu8EneBTsRLrdIoEaIjVY7VEvVn1p+P5lu6t14tMETeKyGWc6nOL8rH8Qw8r3DyzrMsa9fD3D9ivUHwGcSVKZSGbz+ovIUEEQCWmIOExpLgVsFTq6gzGTfJOv7ci+KsAUp85KLRY7l6EkexpINKcJeTD+fdsfKEe5n7ZFuy36Hnlw5VKreAsxEarO88Nxci4PxUvuKW/j0u05N3/HeWF2CpIlBem9hHEFPBOEBteJ5mj6Z/SfbsDAsSi4JBdUGuiQb8rZceBWRblBARyyeb2lAAEYFlM4ZvG9MUyqDaRT6zsJHuqQV1f0rC9PgcbyGSXtMK88pXLDAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UU8hyXaAE2TDGdnO+cSdqoNAdNnjiC3j7RcCHwECqS0=;
 b=Goc0cP8v5lS7n8m18fc88VL53FpUku8O6KO3KCWmFYBdMZJDMgY0cq2gUN8fz/IRU9qiUvucDVvMcIHkjzOhqAkc3svMzmvDzvpJWcjvq41lcbFwfYajNKE2opRbD48hJm8I85mzOkrFOlIDYvMHjPKKsanptIxCLOiB6hLEzSc=
Received: from BN8PR07CA0029.namprd07.prod.outlook.com (2603:10b6:408:ac::42)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 14:51:10 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::6a) by BN8PR07CA0029.outlook.office365.com
 (2603:10b6:408:ac::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 14:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 14:51:10 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 08:51:08 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Harini Katakam <harini.katakam@amd.com>, Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>, Neal Frager <neal.frager@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Fix kr260 clock wiring
Date: Tue, 30 Jan 2024 15:51:06 +0100
Message-ID: <e87ae94979c6efc909740bb1a569505042e4f876.1706626255.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=QWYwUMaPWBzS5osFzLObqf89DiTj9W7Q8Y0q4LG3zBc=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSdPBeWVc3rnNDrXOq+z/RUlta8OPlvqz1//vtsxi3mW
 SL5ppinI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExkvQfDPAV+/kmFEU133+Vv
 SdPsacm0L81cxDBX7lQJQ+eka4zcdX5fgpsmmkgUmbgDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 60510682-e532-41a8-b8e6-08dc21a2e5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lVg2yb84LjQBp5Mpzaei7V/43KCJe1uPXl9iXBcV9lazsPx0Cv6lsB3SNS5Ysu747jfPrKIAoUTdyMa6DDN10fBAd1KAj42xPyB1dhntjO+/xxb6GJNzyxRSsBLGKJv4J8YUM+rykEV8B8jIgezIjLpaenChkCNnaH5ULAbhImpUMuP3MZB2aroPPDb4ydohyyC8gr+BczRTolEqOliFlVBLPMeCzTvK/Ll/GzJdLPc11+GLuaFuU4eziCPRGJwNNsCNFM7XLLXdCf4MPI3nIfkSGp8Dj6DTBMxUjUI5Mqx1J66Z94YClpuNfRrkfq4wXwpN0LcLaws/IG3su9KWt079/DyZCvC4SNj+7YgjB+UVAU2Jq8p19HLMX6Vx9iRK4mzcoh6dM/cCeFUAlMxp+q6Jo5PcOFDH22gB4Shs1Z/BYG78IraoAXfSOLp+y3ahSE38RhqV6dmN9RD8P+WuvabOd8qI+NNRo/DTcnEOdIV/2HeJ/rhD7fIhz6y2YnVE49qqYzPoMIlg0Nh00kuknMVFl0koRZnUDzuYU+JPf9A2JEzGDkT2CmmNzZGPu7WbsYR+zItpatRRfRGJMfqKK3oZ6M+on7GFIrFp995zcS/9ZmzFS1P+SogRnt9cm7PASkfCaqn2GB9EvKhs9tZQKroAtYAv54rTGopHBduMxY7uAbj5ls0xzk89cx49qfld/UyR6AV2uqcxitudhPIPk6WClRi1E3pSqcrHcqgV2Lla63UBQsNVbRzGuTNXREigaRTwSPqOzHKUkeIzMBTHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(336012)(426003)(16526019)(26005)(2616005)(40480700001)(40460700003)(83380400001)(47076005)(54906003)(70206006)(70586007)(316002)(356005)(86362001)(5660300002)(44832011)(2906002)(81166007)(41300700001)(8676002)(36756003)(8936002)(110136005)(4326008)(82740400003)(478600001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 14:51:10.1569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60510682-e532-41a8-b8e6-08dc21a2e5b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
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

kr260 revA/revA01 is using discrete oscilator for DP (27MHz) and si5332 for
other clocks but clocks are different compare to kv260 that's why fix it to
aligned with the latest schematics.

On the other handle kr260 revB/revA03 also contains 74.25 MHz discrete
clock chip for SLVC-EC output which is not defined.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 14 ++++++++++----
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso |  6 ++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 39ca98a9d47f..afcf8a8ee6ba 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -25,16 +25,22 @@
 		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
 	};
 
+	clk_27: clock0 { /* u86 - DP */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+	};
+
 	clk_125: si5332-0 { /* u17 - GEM0/1 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
 
-	clk_27: si5332-1 { /* u17 - DP */
+	clk_74: si5332-5 { /* u17 - SLVC-EC */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <27000000>;
+		clock-frequency = <74250000>;
 	};
 
 	clk_26: si5332-2 { /* u17 - USB */
@@ -49,13 +55,13 @@
 		clock-frequency = <156250000>;
 	};
 
-	clk_25_0: si5332-4 { /* u17 - GEM2 */
+	clk_25_0: si5332-1 { /* u17 - GEM2 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
 
-	clk_25_1: si5332-5 { /* u17 - GEM3 */
+	clk_25_1: si5332-4 { /* u17 - GEM3 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index 21187396326b..24be5dd84e19 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -60,6 +60,12 @@
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
+
+	clk_74: clock6 { /* u88 - SLVC-EC */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <74250000>;
+	};
 };
 
 &i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */
-- 
2.36.1

