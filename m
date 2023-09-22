Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE9CCD4F57
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7202586B89;
	Fri, 22 Sep 2023 12:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f1hdlVxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2BC086B89; Fri, 22 Sep 2023 12:37:47 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 915C486B69
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRYhhrdBeEXM10WgW4caX7Pkpxdvxvd3NT+U4BaA92KSdKpX+vvIQtCqZb6dasA3BW0uG7X45rBBIbSfQ5oXRBX6pwnONUVfI8IiGpvEGapUFzwXdV64sup7v4EtHbJAbs/rfuAPbTAM7y5JeaEDo4SpBDQFDsaCy0qNtNB1bb8GnZARtf2Ou3+zxaR6tRXS604aBwTEprFGJZ9BtgeMUQy/293nJJyL76UT7FUTW3eoSfY7qtCTafmb/t56mzTo8DZSxt87tK+1MvGz9frtsHl3JkKFD4hSb3KhjC1t/Rx7RVhrKJ4OLHLsV5aNl8BqXKFtx49ostdZeqvYHlBPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmFWwc6Bobcwh4s/DOLU+rgh+zNAT+ks5WSOmDQtZPQ=;
 b=AjdAaC1fBbeWQu8h8KQZvAJSPJK7ekLM42yjwezl/lhpwtQgg9+F+tV/iWKzoIcAKyf7h2e1FFC7823ui4snqcD95wNA6nWN/o98+zJeIKU5YIjx5Pi31CBN3ze3CeiK/D6/QFAq0DHejiX6C8fuGSw2Xm5/JCv/gm0j0rsplcjwjkS4ihDBn+PtM/++iRYU2vkTrnLy8sdvtaevreUvzeZJRlwcbNi7s+Bxm8bpWKNAB3vDf6hSjsjtUptiKWmX6c8xHe+SUtRMqnZWEtAR6tPpU0wfPOR1kHiwQJT88xwWqpDqWeMAJ0SO0vJzz4GumOGVCA6+amvqZ7dWL+8ulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmFWwc6Bobcwh4s/DOLU+rgh+zNAT+ks5WSOmDQtZPQ=;
 b=f1hdlVxf+dgLO53JPTGzN2JsT5UlW8jP6XJzbH1UE6G7C9bW9145bTFOqJTtsZHgE3hVNZeqG6npvDZojHJvaW8Lfd7J+4w88zxAftMIVM0h9qoCHJkjic9yBUaWnZw9yLl12A122Y/7pTEnJ+OGw3hFYpAqTTlU8Rrs47ASeB8=
Received: from DM6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:333::25)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 10:37:40 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::7d) by DM6PR03CA0092.outlook.office365.com
 (2603:10b6:5:333::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34 via Frontend
 Transport; Fri, 22 Sep 2023 10:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 22 Sep 2023 10:37:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:36:59 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 14/14] arm64: zynqmp: Aligned QSPI configuration with latest
 spec
Date: Fri, 22 Sep 2023 12:35:43 +0200
Message-ID: <2912091c231f5e945ee44601c285fe16263448da.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4803; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=QhyZ6NbAotWEjqyORdvJr1hCdZYJPctfyUMKJY9P/dE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3BmsbxoCfL6JvWPbFJbJVj4jt21dyIn7DWdy2Et2R
 K76WaTVEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACaSI8Ewz67xfMftd38mSXnf
 sE34Mee+992qAoZ5+l8fmzOYX6my4Rd49lDz8GR3ZlUfAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9dd27a-f789-4f14-054c-08dbbb57f213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSflii9xvm1SFoWmipIKNRZL0SQvm0mWwAmZhhiwrSgps1Gjx/WrIxY9hKWlbkX/2XlEvvUqjCDZwtbhyUAJt7xi76rtMpIzzqve5Rlpd6LFh/nirue5+RLLccSVZKTdyhMBkdPrQOAs1XOe6fdzWzDZmvg2W3TX2pv6zIBegIVJM6kKXqGr95TSVC8pCno5rxUY00oQNHwpeQkBrMmfLnxG8d0O5ia0gdPYMq71T/vhr8Erbk77tTWZYDEJgm3bBUuG2Axfv4lJyPQjO8/F2CZE/8Bz1PojXNQxMpggynFVk4A2wonJF8QRYJs75ZL2ArNs8XpYP4ly6J8yTtC0a5GENO7JgbcAoCvRoy6b+LyTs64GtBdZ1Qd/RpK8v5/YqmSZVc5BO9u9zij8l7htJRtYG4HxELWnyNhgMnUhp5OsSdTUig0gB4X05ukWGSy2JkJDiPpHdkfRYKhT2T8cz4qDQ3Q5zmPBo8ZYxUW1n3Oh1MGwnHG8R+Mb6g6vZYdz5OlKIPm47K0OjM+mHYrBrM1OeLDceiWHtCnYSTI0nIptlnjtN5afRHPJJ3LCl0q/uGiNMBJgFd8QT7TkT346sXMkshzPR8mir6Yw7sWUs9MVPCRNzC4Tts7cPvdgkZZ2+UD9xLlr7lCXO9Lv+MepzvSX99FZO4jPGPCJ3K5mViKL0wT0OqDB8PrJte+qn2N+Fsun8agSM8fzadMRbwq4VDliIdAbHPdZ7cpG8oiFzHX38FRWfJFy3ZPPpAl0/0gpSEWCVvdVwOXj/qbAIiFX6SdgJfxoWUTrt5C2UjL1RU8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(82310400011)(1800799009)(186009)(451199024)(230921699003)(46966006)(40470700004)(36840700001)(6666004)(82740400003)(40480700001)(356005)(86362001)(40460700003)(81166007)(2616005)(16526019)(26005)(36756003)(336012)(426003)(83380400001)(110136005)(44832011)(316002)(70206006)(70586007)(2906002)(47076005)(36860700001)(8936002)(8676002)(41300700001)(478600001)(5660300002)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:37:40.0157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9dd27a-f789-4f14-054c-08dbbb57f213
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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

Official DT binding description for dual stacked/paralllel configurations
have been merged that's why switch to it.

Link: https://lore.kernel.org/r/20220126112608.955728-3-miquel.raynal@bootlin.com
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts | 4 +++-
 arch/arm/dts/zynqmp-zcu102-revA.dts      | 4 +++-
 arch/arm/dts/zynqmp-zcu106-revA.dts      | 4 +++-
 arch/arm/dts/zynqmp-zcu111-revA.dts      | 4 +++-
 arch/arm/dts/zynqmp-zcu208-revA.dts      | 4 +++-
 arch/arm/dts/zynqmp-zcu216-revA.dts      | 4 +++-
 6 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
index 4fcb46605537..e72ed50b1cb2 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
@@ -354,11 +354,13 @@
 
 &qspi {
 	status = "okay";
+	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* Micron MT25QU512ABB8ESF */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x0>;
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x4000000 0x4000000>; /* 64MB */
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index 025e6519ea6a..be75ca6443d8 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -972,11 +972,13 @@
 &qspi {
 	status = "okay";
 	is-dual = <1>;
+	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x0>;
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x4000000 0x4000000>; /* 64MB */
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index 776373d517b3..6cae681dc29f 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -979,11 +979,13 @@
 &qspi {
 	status = "okay";
 	is-dual = <1>;
+	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x0>;
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x4000000 0x4000000>; /* 64MB */
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
index 62a8be9a537f..d08865203ecf 100644
--- a/arch/arm/dts/zynqmp-zcu111-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
@@ -790,11 +790,13 @@
 &qspi {
 	status = "okay";
 	is-dual = <1>;
+	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x0>;
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x10000000 0x10000000>; /* 256MB */
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
index 01fc3d47f81e..ab3ec80a55f6 100644
--- a/arch/arm/dts/zynqmp-zcu208-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
@@ -644,11 +644,13 @@
 &qspi {
 	status = "okay";
 	is-dual = <1>;
+	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* U11 and U12 MT25QU02GCBBE12 1Gb */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0>;
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x10000000 0x10000000>; /* 256MB */
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
index 2973e939b0ed..5e076faa254b 100644
--- a/arch/arm/dts/zynqmp-zcu216-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
@@ -654,11 +654,13 @@
 &qspi {
 	status = "okay";
 	is-dual = <1>;
+	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* U11 and U12 MT25QU02GCBBE12 1Gb */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x0>;
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x10000000 0x10000000>; /* 256MB */
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
 		spi-max-frequency = <108000000>; /* Based on DC1 spec */
-- 
2.36.1

