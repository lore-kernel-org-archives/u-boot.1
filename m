Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30089C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 08:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B1B486308;
	Thu, 25 Jan 2024 09:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eQhEUWKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F05A8644E; Thu, 25 Jan 2024 09:08:09 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 588908078B
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 09:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/UVUc1RNs7x258tpqPGA4N/w58GkoveP6NenxXGkVhB+27sw+xhZXSqOVvZZ5VTVne4QSVii4YAXNh7Fl1MGTpTnyxWmQbwEq9UB1dP+bMAJ5Nhe33QTTPfD+lfsy4LnC58wk6xJNglL78N7GJUo5hrIUVgAjFVyqUQWcQoqlhp3Re33MblVlQ0sG4lNsOZjic1XvEjB+wtosJ/IHxJjeF1SPPVq0j/LkNFwxqwmx9z3lIjAz7wL72B5638hPkfOFL+zceY5/m273K5lxlR5wZlPdkwzYL1lrQEC1gaBeEzn6DqtTox9eri51gGmgj6AKLFpHBHDl355Ya+qSd+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQWisZNSZtbE1u3bSO+POD/ZZGwNNDQmEzd74lWn624=;
 b=gYN9NuxhWMgpF0aoUagrN+ViOz3f4j5Hqk4mBzHshOh9PMTPPmq+s/pEuroJytZr1SJIdVzZHdTZb+ryWX+nPdyVOOBwhZZYCfWGIbXK204s2pdxuyEDqJQ6IgAz81KPq1pQIcharOnkSDe5Y7rUWkpVDTlU3krwIZr9KYn/I3bywAB/Gk80jT1Fh+s+t1O7A5o65gsawoHgHJDV4uv7WnDVuQneCe5UuTJOiBlC/Uh7PilPglA9GUKtNs8EVuaDTbuSNMPdJ7Ww7i5+tIKB6eZW7S6lBZpBugBobsZb9eFBj4ZxRxCWJ6BOrww9CjwzBRIc3yvLXoJJ/ICth5DVbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQWisZNSZtbE1u3bSO+POD/ZZGwNNDQmEzd74lWn624=;
 b=eQhEUWKH1QybxR3A5v+eudHHrVK5lgJG/e3vfA2WiK2aw0/swzcElOeeIM3GpHsYD2eJ9YW6qqJqlSAjS7LXcwXHbwoA+3eaqQd44WHWFofuQ1R2Q844pUUZd82Z/zFBiBtUlz+aSCy7mdvJMMO6hMwinJfwIiRgsxNejgPjxtM=
Received: from SJ0PR03CA0157.namprd03.prod.outlook.com (2603:10b6:a03:338::12)
 by MN2PR12MB4551.namprd12.prod.outlook.com (2603:10b6:208:263::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 08:08:03 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::61) by SJ0PR03CA0157.outlook.office365.com
 (2603:10b6:a03:338::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 08:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 08:08:02 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 02:08:01 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Saeed Nowshadi <saeed.nowshadi@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Add 'silabs,
 skip-recall' to all si570 clk nodes
Date: Thu, 25 Jan 2024 09:07:58 +0100
Message-ID: <bbb2322c94503f0e6b369c60312b7546500fad95.1706170068.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ARjlu6GoLz/TEBmxqWRtJ4f1xybfWsSIdCeVCZhdxOY=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtRNYleFY2/2fBbtlNddd6DpntufvwsnJCw8wRbvwnJt+
 coQI+ttHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiM+oZ5qkK+Sw4N3fdjygm
 7q1dmWtulhxpZ2WYwz+VYUHdpgX+od6fGn/s3+up/+nRHQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|MN2PR12MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 59101678-3602-41dd-96f8-08dc1d7cc100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jgWXN8H4qHpEfzMUpmSWT1i2d0B47Mhx2h9peV1IzGoD7VQfiVkaqhhp0+41bIprRqodcm3Pda87+iIH2Ki3Yqtgdf9RlVowRToz+nZXn2sw44uzxa9Eg03bZdkt0NMdOVvNRVHOKEkxIBxq1smWEaQodekKI4It+HQzgHdfOlhwU7zaMFoTvgrSC27y0K3j0N2GTB/Oz8UjPCpiA3Pl/RIGJmhLlq7dO7HYr81LoM+uFZdFZz3/Tg1cFpbmSLpUqRr2gbiiZZ2V/xci41xAH6nBfuIx0BYkQeGaaKfhDjeT3bDJ01rlnh72zP+Z3QmRrQGWwduwoyQPf0/2TcVAREWG43S1UFptcko3UMb6wn89IUDCFxK4JizkLyc/rumjybjjl2tFIe0x4dzl4bn54wVrnnAFghWTE9iTvC8rKixSzh4MpZ3jPIRREiHCHg9zoxmaLYigjBwvS3EZSzc/0tJL9Q6Ex510RQsE69VoSp4Ohme5nyhwunIkz5KgVVeisi2F4a924ufKjM0UkqRKFmCbxOsTclzKfbmCvNiH3+QjCaoUEJY1foMgm4+gKQWwsgo6oZE5J3mYElf9EBdhZE+VzpaW6Kb9JOmnNqhQniWxl8mYC9HltzJAfI8ucSMqdTN3dT8G/EGNlPxBYUvXDOP0QftBRrMgGk8e1PLgC4FKqWvpvrQX56ErXX+Qfi33hZMDrduEy+r0MyIs3L9ExTUqbSNswnzJuMHqXgOaI+iS4nIBqyTTS53gEzUtAHeCP0UuFGMLEw2CHhIYgUQVxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(336012)(426003)(40460700003)(6666004)(478600001)(36860700001)(2616005)(16526019)(26005)(47076005)(82740400003)(83380400001)(110136005)(356005)(86362001)(36756003)(2906002)(70206006)(54906003)(316002)(41300700001)(70586007)(8936002)(81166007)(8676002)(4326008)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 08:08:02.9553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59101678-3602-41dd-96f8-08dc1d7cc100
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4551
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

From: Saeed Nowshadi <saeed.nowshadi@amd.com>

Without 'silabs,skip-recall' property, the driver on System Controller
re-calibrates the output clock frequency at probe() time based on the NVRAM
setting.  This re-calibration causes a glitch on the output clock.  At
power-on, Versal is also booting and expecting a glitch-free clock for
its correct operation.  System Controller should skip the re-calibration
step to prevent any clock instability for Versal.

Signed-off-by: Saeed Nowshadi <saeed.nowshadi@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-e-a2197-00-revA.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
index f1b0a4aa65dd..0b97fa3f28ac 100644
--- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
@@ -449,6 +449,7 @@
 				factory-fout = <156250000>;
 				clock-frequency = <156250000>;
 				clock-output-names = "si570_zsfp_clk";
+				silabs,skip-recall;
 			};
 		};
 		i2c@6 { /* USER_SI570_1 */
@@ -463,6 +464,7 @@
 				factory-fout = <100000000>;
 				clock-frequency = <100000000>;
 				clock-output-names = "si570_user1";
+				silabs,skip-recall;
 			};
 
 		};
@@ -560,6 +562,7 @@
 				factory-fout = <200000000>;
 				clock-frequency = <200000000>;
 				clock-output-names = "si570_lpddr4_clk2";
+				silabs,skip-recall;
 			};
 		};
 		i2c@5 { /* LPDDR4_SI570_CLK1 */
@@ -574,6 +577,7 @@
 				factory-fout = <200000000>;
 				clock-frequency = <200000000>;
 				clock-output-names = "si570_lpddr4_clk1";
+				silabs,skip-recall;
 			};
 		};
 		i2c@6 { /* HSDP_SI570 */
@@ -588,6 +592,7 @@
 				factory-fout = <156250000>;
 				clock-frequency = <156250000>;
 				clock-output-names = "si570_hsdp_clk";
+				silabs,skip-recall;
 			};
 		};
 		i2c@7 { /* 8A34001 - U219B and J310 connector */
-- 
2.36.1

