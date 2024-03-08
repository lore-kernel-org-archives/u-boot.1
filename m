Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617C7C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 08:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14B288044;
	Fri,  8 Mar 2024 09:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qee1uSnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77EED8806B; Fri,  8 Mar 2024 09:42:06 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6A188801E
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 09:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JofdqRtk09cyqv6+iZUonUhJrZMdq3LcVSTRMb+BS35hhzZUnK/F9LhHfM/IFyjuUWe77aZDcUiqgfWFDAA9KxFhbxgqAoeIapVOR/DxunsadlnwkYRKHLV0UaL6u1TOK67QdPeVirY1Aqo42PhQBWDn97p/wjOpcWz8s+tFujka7iDsJ+DIr6uIaB2bLKL4yeRjxHyAfAQFeyV/VXIV3YrKFGw0lZEiLEAiDysuGQQpvuILgN5a4QT2EQWk+N56qcO7vqrhnRofMR5pOSFs8HATv5jXcfQB6tnUFHqJWEo+F8u2v82EVQ90QAnWS6LnXtkTUoD3rpV+BzXnkirhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SAqNxcxtPEu5F1/p5oWJeIqmyoUVAxXiKpkTkAqiT8=;
 b=WmszSN+QirNh03V5T6LLxwkvZ4aNutO7h6jGesvW/OMMmUxvYqYSzqqMnfGj+gyruTZiGKcIov2Fd0JWlkWnusPrXuI6lb5cFGQP1oQMD5pBmyUY4FC+lE9SPUGn6waVJOGXaHOaNxyrqnEoDm57b6YEEWviUrFFMVkKQs3tFKJgjDY668icq33UQ/manKBg9674xZAloBXGU4OVHtFdKb+Lg3jheRa4GBTZlh6v2JFlaIVQVTt/I0JsZNSwT8yce2f9jNdErRpZK9phoyVBZtwnaatqhtmXsMSLvLxPmJnl/HAmrlGIBe54KUUZsG22K5qcXsx4dHzxU2Nc+40PPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SAqNxcxtPEu5F1/p5oWJeIqmyoUVAxXiKpkTkAqiT8=;
 b=Qee1uSnB0D/0/Mequ51PLLy3GWFcYjEU8x4kd+kZBjyu2opuO2xQAa6SAmq75rA5iRnFw9rjAiOCnvEXDFt7fyL8qvEVYd56X/kvo2038ZIHtz7ed0OCRmY0aN4RbtQr0f7xIMjgBAgeYnz3fB7aixxomVjzyVNy+ZDUWnd5sLI=
Received: from BN8PR04CA0011.namprd04.prod.outlook.com (2603:10b6:408:70::24)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 08:42:00 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:70:cafe::66) by BN8PR04CA0011.outlook.office365.com
 (2603:10b6:408:70::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 08:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 08:41:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Mar
 2024 02:41:58 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Describe USB wakeup interrupt
Date: Fri, 8 Mar 2024 09:41:55 +0100
Message-ID: <d8109a218f70c257e4fc52b5032b7df68fc00786.1709887312.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=JIhq+f0U33k3n80Af+h2XzLGsqhUHuBtncNIEwmgQmM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtRX5wMZOZb9Oyy5O0ou0KSuRl/Sb837efavQycv4L65u
 lYsppm1I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzE/xnD/HR1F9NNjcx6sbdy
 PmatkV6paqs3l2EOj4eQpMXJZb6vSs0CT+ukZAs0MD4CAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: ac79e439-fa9e-4dad-a5aa-08dc3f4b9eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvMX8jXmtdQvxtMJF7LpZIALkPSTjEW7ZxywH5vcfusS7CXQcIvJxWTjK0S+4LlLvY2GXXUuJ9yGvqDhAp6r/n4SKeMMExfdOj4dhGTOmo91mtgtBAgVLIXkEWCFFEnNJwaQEIZPPebwFOxN5HR5RChLQ6DOUsWnJMeaOTvspkIbJdm5IhCwKCY/LMIJcWfSp04ZFRb0q1hi6J6YcNa4aM2iUXNxfdAHpZkblUiuvNPKGsv/F3kO5K39JJdlTx+Q8YAXIpLLq8GPRMIxJtP4M5/4yoxz3vm26LfN2kpe3iqfvllJq4lQLOW3EkcHH5iLS8hTS+xW9AvMlK+JpxKT7kp08o8dYAVMEIpDcQU5XHnWEvuujze5VYngpJxnRKZ93RYyNFIWPacEgljqTRoySSqgqXL4HOGpe+vkf1V+9XARt2m+GQnB/XtPdl/cPTK1ofUqNSOAWusJKc/p/NXiW1nMaAyD3TaEQ1wANCtQyCJIe3Y7oqqa/EeC2odAgEMUi8dzOvUKSamDDGpx99HZIyOlEpQheyAFxyl+gCU3o8/zqYQ+t5fX3+Q0jzKKyYXeOXfbTA9LRQxDf3QuAf0qc2Z161a8oTPgAHQtFrLiEzrPnZD4mzN0wQBhPaBgS3bVfg0wWGoxWooiJAnmj4ZnAl1PKymo0bdzfMNCpp4UEhoGINATkhDtv2FxkGcrgiMUjmw6VOSJGZpxd+sQCUf2iONoH1F9WcffbSEdsUPYcZIY/4kwI/2UgzlfgjYYtpER
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:41:59.9525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac79e439-fa9e-4dad-a5aa-08dc3f4b9eda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
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

Describe usb wakeup interrupt.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index daae23c12b79..c19d86e5a0c4 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -1001,10 +1001,11 @@
 				status = "disabled";
 				reg = <0x0 0xfe200000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
-				interrupt-names = "host", "peripheral", "otg";
+				interrupt-names = "host", "peripheral", "otg", "wakeup";
 				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 				/* iommus = <&smmu 0x860>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
 				clock-names = "ref";
@@ -1032,10 +1033,11 @@
 				status = "disabled";
 				reg = <0x0 0xfe300000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
-				interrupt-names = "host", "peripheral", "otg";
+				interrupt-names = "host", "peripheral", "otg", "wakeup";
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 				/* iommus = <&smmu 0x861>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
 				clock-names = "ref";
-- 
2.36.1

