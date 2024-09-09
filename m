Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3E8ECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 11:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5DD288D9B;
	Mon,  9 Sep 2024 13:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UqHMvLMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD06988CE4; Mon,  9 Sep 2024 13:24:23 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA33188C7F
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 13:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kv7rL+aCter2q1eKAeDeaNc52Kwd2KmuHQkTHIoeIJu+5z2udwFjNzRiUPxC450DK1L2zRR9S7dI8/0RyQr6UGyxfgchUS+51mAMfrwKCCX+HbdlfTeVrqJSUWOKt3pPWqxtE0DCeF7Lg78n+SdvuS2kK4nbr8OSnfAC2aWJQ/Cfc9dlTyKcGsblMShhFje1J6E9KpBqoUecDdGC/f4/eRSdOMFNO4LGOeJthG0fnk1WRBI5PZ/tp5TmbKHew3SBB8hgKP24MpzUIb4QZU16LVlChyjvizCv7MwColbjyxCGdP73Z/MEQZchr9j4rQzbtsUhNoWd3IVUvCLS1qog4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byYzimHrKjQxnALZ5iA4dgbupcFUwOTRwpTcTnWBlJM=;
 b=kV7/gdo7E4ILn7XdGd2YFwUNK7vVKjZz8fwoEeCKo7zwq5Z9Ny8I/RCN2y0UNU2AqTAKze/6Pq8CyBg8NlGd7Id8Fq84+okh7EGfcZfN0ZpjnUqlwwYDajF6StWsW5YAK4EpQ47ji84yRNivppDtHKqLBdOOh65/tIKeU/OU2Xb9OuVgvEdropeQGU08hhLomL8SzegHamlGTEUH9GLPxZ4wOvHPvwIlJhszjS9MngCuEolTIaO3H1lfErzlMRNads8Z4gNPsHY9AI49QeZBZi50NIWgV4C4wd4Egtr5/ZkfjR0G8XnT+RQrgDJq2o+aMHBm5whrkr049teb80IqTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byYzimHrKjQxnALZ5iA4dgbupcFUwOTRwpTcTnWBlJM=;
 b=UqHMvLMb2dDcNkdHsJ3XotNOVBAdc8SnJesGMOKY3qtL1fqsZvNnGgIZs/sJZ4KI/GsWcJ56wB+k4WzZE751xZHBCY5I3cjRcwIQ0wA94sm3jNWpng6PN1bcUrcPpDjtkXjyh/YRbnZqejzkIvM2iclr0JRM2Qw0ayMH/e/u1PM=
Received: from BL0PR02CA0063.namprd02.prod.outlook.com (2603:10b6:207:3d::40)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 9 Sep
 2024 11:24:17 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::b8) by BL0PR02CA0063.outlook.office365.com
 (2603:10b6:207:3d::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 11:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 11:24:16 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 06:24:14 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Add missing vc7_xin fixed clock to
 sc-vpk180-revA
Date: Mon, 9 Sep 2024 13:24:09 +0200
Message-ID: <4904f5e0aab8a0b0c2fcc1912be493d4185e6173.1725881047.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=758; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=TKPIxsloEohce1X5lWqHwrNBxwQkyu7b66FmS+yJIiA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrR7t27ZrFzHvKojM7r25IEnxysfrJx0MLo57vri01wna
 mZtvpTv1BHLwiDIxCArpsgibXPlzN7KGVOELx6Wg5nDygQyhIGLUwAmcmYTwzyNvnunKo7sC34u
 W3P7yF4FKd8VDToM88sa6su3ubkzKnG6Zh95G6e/7unxqQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 320562e4-ab19-4622-6f10-08dcd0c1f0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?53abWpr/GljRG9BHBItCUVkt+x4Sze0cuW6X61mFB84oejAPMIMMtLt6WmC5?=
 =?us-ascii?Q?EhGVan9fQCHL9LNyCWflx0RBD90zopesgeJTLVxeRw2B3EJ+BZV/9ipNF+LZ?=
 =?us-ascii?Q?X2I7BZtgvtzAkrxzHDOcDyP61Yf7lZjnlAGbVofxrUnjb/s6gPIBH+2vr3kN?=
 =?us-ascii?Q?xeYirKRuYX9fxeAqxLkDlnA8CEjDd0pb+HKB9I0VNycI521g1MAND9McV3hM?=
 =?us-ascii?Q?NZHM3U3R7ZW1kJha1+NiSFwUiPOobQIZLQgk0fiTd/edCIidWuRtUUQ5hTGl?=
 =?us-ascii?Q?3iWycRls5D1YOlk9EBRVNiBA3H4zPesCkV53PHbf7iNIcmBeK/SEMA38t7zM?=
 =?us-ascii?Q?JoIMJUkH2XAMIEufmTHTEgQZbKLC7Hshox2kuGyutWnAKB9zCrzUGZBVtszO?=
 =?us-ascii?Q?zf6HgUoYG3lCI9JX0aR0CE+GSlQYTXzSwUmQbFXhHUyfG0W4WGbEfk0I5lo/?=
 =?us-ascii?Q?5LluaeN7AdL/PTFc4XFnFzawHQi4qsq0PMZuMPIRgJHXOMI1ICjtW7wCfNIY?=
 =?us-ascii?Q?LqjPO7vVG953EPxCc1Yrzlxea04oh0AflNqT61cUzTnkG69GQEC+7yc6huRm?=
 =?us-ascii?Q?OpNyDDl0pt5qGu60XkkUcpoKRMKZshXY1JI27guczocInKD3CuwrVIzmZkuW?=
 =?us-ascii?Q?TZoZO3lABnDmbQosRz8J+8/kMguxk2kfxg3Esfe3920UCg22XXBRekOk4EWu?=
 =?us-ascii?Q?8Yp1tFZtfqbFWRvXiE/05Qrlgofshx8brFH6r4Ie/MFsvbC2arO9NlkqJmfF?=
 =?us-ascii?Q?w300DkPUO4LR9D64xWQCn0b5BciJzfjWoF9lm6EUcCce+6qXRaVVgy7vMhjM?=
 =?us-ascii?Q?D62OKZ/dXPWV0/Z3JFikb4hBHTyN2JwjRctioAHXkQRi2whIaajdFzeNhVuM?=
 =?us-ascii?Q?9T8+H8gkejrLCXaUr8/9HT/eIu6EDQ3/dCH6fmU3OyZ4F5FvWd5h4UAKKPab?=
 =?us-ascii?Q?6UYxuG2wwaeL6d1FKjlzGbeqrYFUth8LpOKz7v7QMFo4XDyv5bsTLn9tkolT?=
 =?us-ascii?Q?x8engVhr8ayQmrYujiG+9PkTBJ1P95C9vNL1Ye4qnHmt76TTz7laTtUPnqqc?=
 =?us-ascii?Q?IVHsL96kOP8tbrAcAgdZRjIvcOcvRTskrbRpCb+xmKX1NprZofABC90Wrzod?=
 =?us-ascii?Q?DHG3rpauSdY2LA+0vy4+4XCvs/ebtrruiGib7B/s8CBgDlsfjLFJKSt+PbLR?=
 =?us-ascii?Q?Mh62TnuyL7MAmeubJThUYlWqYfPQ6JjU4RUV3286j6CC6Tnu9t3qMflMNimW?=
 =?us-ascii?Q?vgu++93lwmV9iIxGEAVLs8Y4wqhQAM43Rgy9WzIFAQYcdf8SnGsGgCaG/om8?=
 =?us-ascii?Q?NANlmHPtSFnHF3ERBPst1GTHomLui9SOHyljUIwKSoGdCd+1fUEF6EAZlPud?=
 =?us-ascii?Q?izH4ZYkFUNBOUCFGkEmM3ysb/lULeKxXFJbmthUGpMhjzHuJByxktGd2m+sJ?=
 =?us-ascii?Q?BlcnJqjp8QwVk4Q8aBgSxTYgF3Li9L4f?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 11:24:16.3666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 320562e4-ab19-4622-6f10-08dcd0c1f0a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794
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

Add missing vc7_xin fixed clock as clock input for some clock generators.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sc-vpk180-revA.dtso | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
index 18625933ad3d..ba5484573c99 100644
--- a/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
@@ -16,6 +16,12 @@
 &{/} {
 	compatible = "xlnx,zynqmp-sc-vpk180-revA", "xlnx,zynqmp-vpk180-revA",
 		     "xlnx,zynqmp-vpk180", "xlnx,zynqmp";
+
+	vc7_xin: vc7-xin {
+		compatible = "fixed-clock";
+		#clock-cells = <0x0>;
+		clock-frequency = <50000000>;
+	};
 };
 
 &i2c0 {
-- 
2.43.0

