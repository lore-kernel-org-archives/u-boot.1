Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC726C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0DAA82114;
	Fri,  2 May 2025 16:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Y/s4eXgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C1B582145; Fri,  2 May 2025 16:34:37 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::722])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A30FD81F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJ6ks8RCmtc01MIOUA4QbPtLQAi7plIMt+bGBkamOGGkQr0HQHyOaxAIzgeQH4SXtkCDYVZ3pl6X9pNmdoXE8Yt730mIr2+rfOolkTyjY/D+Jb2gYxF0/CGuAWNesJvz2dwBWaihzpji0QJCOS+iiULQeeRDK9ehleeDYimEsLNauq/pdDJwC48zQWn//9PQuH9hSGKmplAKk1vr7C146JZcNKe9iBGsJdBeRVSgj2gsPETxR0BsSKrorjfne3CZI4MpcYk+7Lvi1QFmWLGLHqjJ3C2hSl8BZNXYJQcAbmCOim5aoOIguf6JAC6Wms6gKixHaTYAONGgEY8xabYV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWp04PBAp6MCVtu7trhanc8vfuFHrMiRicnXHBXntS8=;
 b=SgS04bm8fXULxTmabYd2+AyoTgmzkqBxP1Pz5Yph/Oa0rfyc8rswq+06Hp6S6mhPSwIxIUw7t42qLCwerGx9ne5nO3+DOJq5IQYElHWsuXOA1/IGO+1QqgON+zANzakQPnrxoVMpPiuYE00RXz7UvZEueChtSqxoMFTFHKRnKlTG5iM3oOkaXsy5IPR7yNnhnuY00bv3xyV2MBNiI12pdB4qG3YCScyf6YXUXm8cIQRVr5Bb9YBQNuwV0sOjAVHnuP4M0V/D9DP0XFznOnMIK+cglX0Lb+HwuXRHDuFmLQg31hFnB6FDT0KwTyndQsmW1Tk47c01Ka3jFEH+nKHSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWp04PBAp6MCVtu7trhanc8vfuFHrMiRicnXHBXntS8=;
 b=Y/s4eXgfQZvUeOxU0gXb7ru4ST3v70WSf01QQENBur1k0apXV4MiZ4+Kns7HYJ0zZmNg8t6a7rQnUE1Jx4kun8OC053QPPObfYUu6s6LU+OGLdliV4IPMqIiPt1EX/lhYQ54a6f5CbYId4qNBjltOGFytuX90yr/0G0vt+HWljiCY3uOfF4bx0Nnfyi84wrsjbuynwe5kVbNtqk790um6kW7PPW+abUYfh8iPw2G2dhH1DzmSUFSHznnBCcxCmvKoFK/M23kV6dQ3Kyw4nz5Ise0bOUG5Y43VJLfs5GWJyMk35GlfwhZDjwPEQ+8+1SGXIdFVpBqCqjIbAGbuOzJNw==
Received: from DUZPR01CA0324.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::29) by PA2P195MB2534.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:403::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 2 May
 2025 14:34:29 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::de) by DUZPR01CA0324.outlook.office365.com
 (2603:10a6:10:4ba::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Fri,
 2 May 2025 14:34:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 14:34:29 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 2 May
 2025 16:34:28 +0200
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 2 May
 2025 16:34:26 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <trini@konsulko.com>, <d-gole@ti.com>, <bb@ti.com>, <vibhore@ti.com>,
 <kamlesh@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <afd@ti.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH] arm: dts: k3-am62a-*-binman: Update ti-dm blob
Date: Fri, 2 May 2025 07:34:14 -0700
Message-ID: <20250502143414.2841260-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B95:EE_|PA2P195MB2534:EE_
X-MS-Office365-Filtering-Correlation-Id: d94b9d0b-ca37-43e6-f982-08dd8986726c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lBQjrZZS3/OzspaY8oFPuDtUVZFbpVqH90nPHS1qNuBz8aonYVXwE044JSXL?=
 =?us-ascii?Q?5d6czk3mpzAIekuP+QoRx5WUQdvPG++eAdP2zE7WpANu8aYK1ebWFGbBnNaq?=
 =?us-ascii?Q?ddYOabBn+twlN3o4KHEanNR8w2r/2FEQy+y5WqdoQVfAtlNfx+FEFNT1Fqtz?=
 =?us-ascii?Q?d3bz+7ZNO7Xksm5QFGAHr+lLFkjCy5mCeSLAfxiWrX52Gj9eH+HUzEnMaecp?=
 =?us-ascii?Q?iTue8fC/zOcc/Sx5w2fFaFtsOTf/ao1UFlTpu0aodnq7+YXEj1N2j0iCafIm?=
 =?us-ascii?Q?JFMW/beUZVcQLZrbn4i250U8ttNeM5RnQDmd5ibhMwRepKj2xfh9hC1Lk5JK?=
 =?us-ascii?Q?YRI56Syr7sTAhBv72qXv05H5ewCSzmq4wI9H/fC+AQk/GjHhZRPOn4hmttQl?=
 =?us-ascii?Q?vTYsc3Z91BldSzNpbtN0V4slTOEuasyraywgtSdEB7TJ/2UoMCw7fYQ8e78H?=
 =?us-ascii?Q?xf3F8Y9BG7PbAXCNesjrUCXO6GFN0QL7ykLtXj860YF4lB6vGWG/Q/21zrrg?=
 =?us-ascii?Q?+8FQuYdEFZsXONmegAws6RN5j7rxE1NmAhTbClVrBFkVcvyiyoiQEVuhdTXx?=
 =?us-ascii?Q?6Zv2/UmLtOXr80l4kxMaYbS1RnVkHWbZQnOK2qnod7aBFd2ot6606DRftdQk?=
 =?us-ascii?Q?PFKA4oI3zJVfmdAJ4IN792Vd1EDxeDZW2Aagk3Vn2+dop7Jiv9ALQoj5ECvL?=
 =?us-ascii?Q?fbuqq0t+/9zXymS5tB4qnmwJFIBsKoNvRsYFe0JX6u04DBd8QpXbLQF/I3BL?=
 =?us-ascii?Q?H7zGRxmQSH/ASU23jD+aXvMWSU38jKfIKCqVEZm8ewxkcoalsJaqePvbtzBR?=
 =?us-ascii?Q?UWqLTVgobT5WkV0gsxcUZvNY774GPX4J0lCKQH8kKQEe8Ptt4KNxKP3US65X?=
 =?us-ascii?Q?tFQbV/rexMxsPk70JxzbTi4EwGCmr/25KHpHfDJNYXD3h4DXZzkHihyoscjQ?=
 =?us-ascii?Q?Y72KjtVfdFqKn9meitkE8mqEM+YIAzgI5ALYOWDc+O+AtxizvWpLNiDKG+m7?=
 =?us-ascii?Q?zYGORujqpBdXbM7yHot4c7WaRKu9XjFYbVLvAK9s8bf7SPObfD7U2R9vBbzp?=
 =?us-ascii?Q?IRoAvuRJykEfqIIWtVOZih7QRdbLD1ckC3PzYGJLtfRHRqXD0brPDl7FO3e+?=
 =?us-ascii?Q?L13bI5yHfjJ1i8hV0Xs1u1T5PG0q1u223JlmRCw6yls9kgCQzkd1bvgmRvwO?=
 =?us-ascii?Q?TTOv2F42Qs6ppR3daO6AbAwiKv4U/ROBqFo7I3Srw7gzXosqAdiqKGRBv5Yr?=
 =?us-ascii?Q?1mknrGq6gC9kLi3fXlPw+Eo2OovT71BJfoZRvRqEsvfdIrMiN9oXTtlIE9LF?=
 =?us-ascii?Q?8G2SLzxSQRlO2ThtI0vR/5RyJeoXskngwro2LGveYu8RR57/OCpFEJPs5mOd?=
 =?us-ascii?Q?GvlZlsClQtIRnbQbtN5LFs0Y9/cDMoXmORftowCEqYvcAvZyQf9pEJQLCCzn?=
 =?us-ascii?Q?9uZd5nUKjX/apz5oX8luGt1DoDS9YH5eH+NEhkKnRPPdqzwPFBHv56ZqGefF?=
 =?us-ascii?Q?rlX7Z08r4rrJ1XAwlf0VGEm7Zs1ZYxlsORCa?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 14:34:29.4156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d94b9d0b-ca37-43e6-f982-08dd8986726c
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P195MB2534
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

With [1], TI changed the Device Manager for the AM62Ax to an EdgeAI
based firmware. Update all binman device-tree files to match the
latest firmware name.

1: https://git.ti.com/cgit/arago-project/meta-ti/commit/?h=scarthgap&id=430bab80d46ed921e4d4dc8ecaad8a4903b514c3

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 2 +-
 arch/arm/dts/k3-am62a-sk-binman.dtsi          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
index 325702ed6e0..aa4caaeae33 100644
--- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -167,7 +167,7 @@
 	ti-dm {
 		filename = "ti-dm.bin";
 		blob-ext {
-			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+			filename = "ti-dm/am62axx/dm_edgeai_mcu1_0_release_strip.out";
 			optional;
 		};
 	};
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index 2a8c260387b..dc6e8523172 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -151,7 +151,7 @@
 	ti-dm {
 		filename = "ti-dm.bin";
 		blob-ext {
-			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+			filename = "ti-dm/am62axx/dm_edgeai_mcu1_0_release_strip.out";
 			optional;
 		};
 	};
-- 
2.25.1

