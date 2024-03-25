Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646B4C54E58
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 09:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDBCB878ED;
	Mon, 25 Mar 2024 10:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EdJ+v/59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57D8687C9E; Mon, 25 Mar 2024 10:50:28 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 915F287837
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 10:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDIpd8bUswoMNPXfg7bNdXEDULQKcVUqUXbAuKzB1IwK0gL259Sw5kcJt/ynhszGF6DfBosLInZ5s0jK658h/CDJ2jpG+mQx6Z/k9FbUNn5vQwQNkcSeUYHY69wz6ZCEomhJj6mhaqP+HxRy8Fc7go+nn+zebJx6b6wHYXbez2oXgIjmNjERi6dos+/BGzi2aNkwZ5/hv/vIdPMh3euFZEDQmqfQZpmPNKCLDjgGstgKWMBJEpmtvhZ5NoCvKlVqrM9byMg0T0cXLu/1DzNcQG8I/yCoi9h73eCdqc/SzY/dj6pCHgcWtKSWc7kDXbaUbGRYeNHXMCdXC8r+4wyJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBigM1wsxMzx2GnGnSzIy2yONuQ443tWZ048LXir5iI=;
 b=aB0pwwiM4jjZtqfqDgn+pCAwWxWIyUw6r9yRWgyPZPTsVXOoZTJg+IIlc5FtLgv+2GC8Ham44XZmIsNFJKbJMU/xS2hWw1+t9pIxGk7dTmTgx0RmgKSoX0ADxgbEwjiOf7Dn0OcMZkRMnZjWOAeBz9VUywn2K0zZoU/Sy/R7Itod8VwF0UalKdSnRAY+6dfGa5GE3uhn+PzNtvuiSwkA5azT7LM1aTq8B1aBrCVNCeTKlvE1GG4TV4+911KBcGfwVX+eGXcmBuFE8a1gj4P1MKZycxSE2CqJXKwO5E8ZVPgqLoqEu3WD5UY8KzF+X5lIPexay9CCK3zINGdNBoLftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBigM1wsxMzx2GnGnSzIy2yONuQ443tWZ048LXir5iI=;
 b=EdJ+v/596yNMmizitb8ywN0717tVLMdzgViaMjIZusNBlCXYR7s1GQpz0i0oHxhftZ0+W46VwbdIYSRmK8L2KGn9n/fA+yxpdlSRFIlbI1ljvtHTm2xuxUs3HL6UpzUvITDzjduciZI1jpQttA2ZNr4CmARhF98IGNH5svj3g6w=
Received: from SJ0PR03CA0077.namprd03.prod.outlook.com (2603:10b6:a03:331::22)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 09:50:23 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::e4) by SJ0PR03CA0077.outlook.office365.com
 (2603:10b6:a03:331::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 09:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 09:50:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 04:50:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 04:50:21 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 25 Mar 2024 04:50:20 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] arm64: dts: zynqmp: make hw-ecc as the default ecc mode
Date: Mon, 25 Mar 2024 15:20:13 +0530
Message-ID: <20240325095013.29497-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: bec9b08e-3a8c-4c7e-244c-08dc4cb0fd59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4LbwUCq2j8GdbfVzVnX/wrVEysNY5GAYi9uB0N5EtR4iFw8FkMMpUhFcwZBt299/fzkXu6nsq3H/uKAjNN8CsH7fOhOsv9naBQbJEW59FsULBJxnQLZ+LjjfBv+H5NZYWVsHrroOK9roDWFLc1Na60+OHS+slWZzAZncAiKAFdX0OFSTMjZci+QC7lbvA3+89mtwOuwmZiFkSVXn613UpeSq2T+GBUUT2R+sAZKRwEpS7qaGgaaBgzfpFE/BpF4GbcSMiExiUgQq/ZyGvXOaBbZIEpBEjmJjmy8EYtRBGpjReTe4OUQZ8uctRFvae5mVJ/QJWIo4fm6ARWT3BK4zeIn7VkxvOQQ4/lgCt8omMthTpIoQ3yb2V48TUlJ1GgOR5ZxrMfXjVAlHSawXRnGyixNTokEECSHlANuCZ2xYQuq9ihipbC8ij+Z/AeLm4cMLtAMiB2BHbyRZMDKL2X2LUare1FOJMJlQEmjjQx7AiH9x/J9Xdt2QLP4C7uOX0OiayO1q0u3cgRymxf8ygLW+3s+lCyLJ7vEfjMkV2pxIXuaYl+DYyNo+HSyuRUk0EIiTjM4XXHCHysTmJGm1VgqLK6XoCew+X+6L1cxjgGh05M66JCclnDBaTwJ6aH6nfXkCeSYIegY1FJP6GrdaWJClrWqqqlfbrdJoYmcTxoxh2lqDhmMczi1Bxy3L342N+/N3PsrYd2PW1yEuQrBqmT9qy+6YJqiUQnj6RGA6WKH6UcdtgocHgj7hjj41ra3ZlsEH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 09:50:22.6794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec9b08e-3a8c-4c7e-244c-08dc4cb0fd59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848
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

Except for Linux no other component (i.e., u-boot, fsbl
or BootRom) of the software stack supports software ecc
engine. So, make hw-ecc as the default ecc mode.
Update the same for mini u-boot nand configuration as well.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 arch/arm/dts/zynqmp-mini-nand.dts        | 6 ++++++
 arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts | 6 ++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/zynqmp-mini-nand.dts b/arch/arm/dts/zynqmp-mini-nand.dts
index e0517cf460..5889d436ed 100644
--- a/arch/arm/dts/zynqmp-mini-nand.dts
+++ b/arch/arm/dts/zynqmp-mini-nand.dts
@@ -50,6 +50,12 @@
 			#size-cells = <1>;
 			arasan,has-mdma;
 			num-cs = <2>;
+			nand@0 {
+				reg = <0>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				nand-ecc-mode = "hw";
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
index b97f7ee8d4..48ab619472 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
@@ -136,8 +136,7 @@
 		reg = <0x0>;
 		#address-cells = <0x2>;
 		#size-cells = <0x1>;
-		nand-ecc-mode = "soft";
-		nand-ecc-algo = "bch";
+		nand-ecc-mode = "hw";
 		nand-rb = <0>;
 		label = "main-storage-0";
 		nand-ecc-step-size = <1024>;
@@ -173,8 +172,7 @@
 		reg = <0x1>;
 		#address-cells = <0x2>;
 		#size-cells = <0x1>;
-		nand-ecc-mode = "soft";
-		nand-ecc-algo = "bch";
+		nand-ecc-mode = "hw";
 		nand-rb = <0>;
 		label = "main-storage-1";
 		nand-ecc-step-size = <1024>;
-- 
2.17.1

