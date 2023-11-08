Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D578CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 07:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22502876DF;
	Wed,  8 Nov 2023 08:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UI++V+IB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F0087585; Wed,  8 Nov 2023 08:37:04 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D122B87588
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 08:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJChuPPe2S/N/M8+A5h1PkCaN/2yExn4NzIvnN+8/EWdpM/5vNbWC4bg/iIg/+heV7qHUZADELfcXiliEKKYQ+En/jxkEsedyKvbNN9QFmBsdnpq4zuur8Gck40ylLBcv0eczxDNXPVfy3Pl2n+/1c3K01tYAsxs9GA4CQq7VbdpT8KUJvelXXkUnYo4MW6LeE6eqxtgA5OIisaIHw7bsckfBnh9kIiiNXSD0J1ZjWCuWPnfvsjiCmWsLXb9ftk/nhBDms3AuAG47cgNXmGXY7A6Q9EP+QdLqtGTXr5dAqb2Lt3z167X3fiLQzy+EkLSQdqniuGPqgheZwLTGS0//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjjO5tWr5zDAZW3m1PTXl8JTrOlDlfoLaYIW67l0M4A=;
 b=jqpOa92o6btwBqcSmnYUrYIJnW2FATQAOgS+e1R/awzb0mNJ2BfEjMB1P9qWBu77N378evChdRcseOBxktPeFDA56NR+UASdLd8G1vQ/oznKGOADMvhP7Uq6pciQ87SnVRNkgVGx4smHx3p5Vd4zz9ZMX0NRH5EZ/j04XcxV8Ai9ZHsAyoMjfLOhb0FD66M89Cu91qDcbdMY4FNNRiR/9frQkF+6gaE56EV76+8qZ4P4bVQZlf9OlYWIx2qLBGd3Q+i7ZBEdW1CENbz9BTQhOSIsxbACbCRRx9siO5nQKWdveQOYuPPLH3NYfyhMX4dNhbRJCusysP2fapx8yG7OsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjjO5tWr5zDAZW3m1PTXl8JTrOlDlfoLaYIW67l0M4A=;
 b=UI++V+IBbPOAtRAnKXGXVREugMUErJq3pW4fADt112Q9j1LAOHI7+HEjyw2KASC3G0WnwESog/4xInjBMdz5om+yLplPH4un4fjp41sNjz1Br36L3vrzoXiGPSbcWLFsSdpbvq9htjY2eW27MFK1qTA1Y9AI43OGMOb42HmB3cM=
Received: from MW2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:907::48) by
 SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.18; Wed, 8 Nov 2023 07:36:57 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::2f) by MW2PR16CA0035.outlook.office365.com
 (2603:10b6:907::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 07:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 07:36:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 01:36:52 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] arm64: zynqmp: Remove description for 8T49N240
Date: Wed, 8 Nov 2023 08:36:40 +0100
Message-ID: <52aec21f121713160d5953b0a41a10cb196482b3.1699428990.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2320; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=DwgE6Pgv3FMHcBrcJ4A9b0jFRnOqkzj6Bxc3IgNoZGI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlRvq3r/U7OmHH1tdqjx5nvpr1PWG9VfqDS3EFm31oSLU
 yleuWlNRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIB22Geaa7Dpj2G/Fqy5pw
 +W48laI9mWV1MMN8N0Zmb/NfaRcDqmqEdn971Phq3wEHAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: ee70936e-356f-4f86-5ef2-08dbe02d7c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EE8DlNlUgpGmGosMR8W+q3urXochCoCQkYD4xFdG9TE1rhLkJ8bi8IU0MkUIhCmFXSeDTVewYi6PNkrpwHMaafXxSSdSkHgujl07P3oqZD0pcelpcO+AD4ne6D9Eng/MYxu8zIqdWWlsQctoaz6ve6f/GjjaTIL0WUJmv6aX0rkhR7XfuhwnQc9hau2UiI+A2mKrk+UYUYGkvnTenkIvDnydCRCE4yGnHXN5iw/5iC+bpWcoksT4ofhHUXan6LwKqC0eH7mVeVbP2NIqUSu85g2t80Vrihq+GwItCq7lDDmwbcmC9MRPExHF9HiKEFNxzFRnFiUit1zD19ouQOcr1tloT1XERnFLnlKbTZNnuKigtQ5dDQxER+pydDHwmLcsMopFts9S2ajoYRRf3YAWtL6u0lkqmC5MFY6Mwwg9GhHBODYoIu19y1xaDAVDZwOGPDPBqY7zEB5CWrB4YqL7KM2xxJvzItw8kmqMoz3nlduD/59sOLTg5DfoAwkE9PDVEpOBY5lakM5qlS4E7PmWRzd08pKbBDbqlmWyLc22vIT5anvZxMccp+Z5/hJcMAk5BpJr//I7k+uMFKDjGxhQv7RDVMqxYT/HU9fYMV/iJQql8NzcwwxRDhk/9K0paRL5tioS6gF0v+6BqP8UR87OflV2IADdd8+Bu/1SG3noWM3hTpBlAZZyJqhoEd0DO7PJjV7BylG3pBat+dJB9k7edeemDP7tnJuoYrucL295dq0aRYq3uG7lXHy05m+7Dg2bW36VbWFout2o4nV4icds1h2mH3vbV/trZtXmlU4medVOpM/m4JOifTlVE80GPWiD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(426003)(336012)(5660300002)(2616005)(40480700001)(26005)(40460700003)(16526019)(36860700001)(356005)(47076005)(81166007)(36756003)(82740400003)(86362001)(83380400001)(4326008)(8676002)(8936002)(316002)(478600001)(70586007)(70206006)(6666004)(110136005)(41300700001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 07:36:56.6073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee70936e-356f-4f86-5ef2-08dbe02d7c5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
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

8T49N240 driver was never upstreamed by IDT and there is no user of this
driver that's why remove description for this chip with also remove this
driver.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---

 arch/arm/dts/zynqmp-e-a2197-00-revA.dts |  8 +-------
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts | 10 +---------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
index bf7569c6dda5..cc57c2a1b0be 100644
--- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
@@ -311,13 +311,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
-			clock_8t49n287: clock-generator@6c { /* u39 8T49N240 */
-				#clock-cells = <1>; /* author David Cater <david.cater@idt.com>*/
-				compatible = "idt,8t49n240", "idt,8t49n241"; /* FIXME no driver for 240 */
-				reg = <0x6c>;
-				/* Documentation/devicetree/bindings/clock/idt,idt8t49n24x.txt */
-				/* FIXME there input via J241 Samtec CLK1 and CLK0 from U38 - selection PIN */
-			};
+			/* u39 8T49N240 */
 		};
 		i2c@3 { /* PMBUS2_INA226 */
 			#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
index c456c375ac80..9acccad40e77 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
@@ -532,15 +532,7 @@
 			/* u36 0xd8 or 0xde - pcie clk buf - 9ZML1241EKILF PCIe GEN 4 CLOCK BUFFER FIXME - no driver */
 			/* u37 0xd0 DNP - pcie clocking 1 - 9FGV1006BQ505LTGI - PCIe GEN 4 CLOCK GENERATOR FIXME - no linux driver */
 			/* u38 0xca - pcie clocking 2 - 9ZML1241EKILF PCIe GEN 4 CLOCK BUFFER FIXME - no driver */
-			clock_8t49n287: clock-generator@60 { /* u39 8T49N240 - pcie clocking 3 */
-				#clock-cells = <1>; /* author David Cater <david.cater@idt.com>*/
-				compatible = "idt,8t49n240", "idt,8t49n241"; /* FIXME no driver for 240 */
-				reg = <0x60>;
-				/* Documentation/devicetree/bindings/clock/idt,idt8t49n24x.txt */
-				/* FIXME there input via J241 Samtec CLK1 and CLK0 from U38 - selection PIN */
-
-			};
-
+			/* u39 8T49N240 - pcie clocking 3 */
 		};
 	};
 };
-- 
2.36.1

