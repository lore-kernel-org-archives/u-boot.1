Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582C5C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C56AA88874;
	Mon, 15 Jul 2024 16:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GLaEylo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24EAD88874; Mon, 15 Jul 2024 16:25:46 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A98E08881C
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2L6tBocFUbNSqWK+I3oZx4sigMBk9QfZw1T0qD6vMGVkMyW4McvcsE9+ZzxtgC7u43WLSv4hGh8Nlx+CfvHdRYIzPutb4z1UvfHKoaoWkloVLewd/ZFf4zdmgTsYmtuUWX1XzcG1stWtpsoCFp3J/BNu15LPYrj7Nli7H0xs3yoJ99R+8RJ4XbN1mMb1EXauibMVovtjza+89acNL6StPPVM7ylKK7b0V5RxumdZCbsyFRubvFswwxWSNttdnnRXPh7br4Vjo5AdTI+Pr6vKfZAxoCV3vVnoj4Rqzd3vtaia1nUj9IHBVBPkWyVwNDyYRKPG4jO6aXR8TMzh/Fpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5Lp5Q8b3qW0A1nEsWowXdSAEVF5D26buSDuKZWRVbc=;
 b=bmCIO/Qp6+eiZI3fwymwUIzeHbsndDAuRXrGjyO/bKIhvFRi5Egkc6FoUItdrRHJf5FP8atdRkaqIewH/qEnOwsXuWRoLn0/OZqSP7e57tsHnLt3qYV0n6njw2vtFVw462REKpsCMJauvOGWwnL6NkGpOKtjmN5/Hwu+94lcCTdQcc+eCK7y7NsnO53SSwmtaITbIw8H2I6lVkHNAuMotkSbv54eTXdQDCYgkl25isTY7YGwe7yT7gAsPhouDQEgBuFZKhOfUocKRXJylAz5OdiwnwYfhkE6A3nGbg4+/aPxhy+GCgeDpTJ2t77z4Rj412xV+g76RlKe2gi7IRcdQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5Lp5Q8b3qW0A1nEsWowXdSAEVF5D26buSDuKZWRVbc=;
 b=GLaEylo9LktV5nWrbOg9+t8xLJRufmnuotbCdH6j/AA8itXUUTQpVxqYRVZjVgkKfVOff+h8I3vGmenUZym+PXc4RgIecm30jxASBqktlCPlK0cJxsIfAOrZFxYJ+ZFhW/zMhg4omV/E1VCNEgwtUWlGzOZvDQkQNq3Ojq66IzI=
Received: from BL1PR13CA0090.namprd13.prod.outlook.com (2603:10b6:208:2b8::35)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:25:40 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::d7) by BL1PR13CA0090.outlook.office365.com
 (2603:10b6:208:2b8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Mon, 15 Jul 2024 14:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 14:25:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 09:25:37 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Tanmay Shah
 <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Add resets property for UART nodes
Date: Mon, 15 Jul 2024 16:23:43 +0200
Message-ID: <81c602417a5d28dfbce122b2e5a63ff7ddb74594.1721053421.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=JgdfW0vUAKGX6YdvIr6mPGPem9i1MMNaFc7QP45EEAI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSphp7bAkrTT9XMecWVl8T/6CmzknLKGbG+oOYfiuzfW
 jf6muh2xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgImI6TPMzw1SeKNkU/bswnup
 vVKcc24pO7a/ZljQ1dgt8lvm5JRHyq1La3tl/Zc7zYwHAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 4228aea4-a478-40fd-fd45-08dca4da006c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M/1/lwPPoA5pN9u55BvSVLTz5uBonmNGmXPjDI/R4Wtaq1GGR7qgH4+xO2ER?=
 =?us-ascii?Q?UG/Aeg8DTObPA8FCQfrleVcudziE7bhOv/n+Q9Zrfa1ZyzVrqXxSsADT8Rz1?=
 =?us-ascii?Q?8UW17F13aLXAbqG6rkMd+30M/Dlxg7wHsPU8G2QVB4qYk3aZgZs1iVrEV5AP?=
 =?us-ascii?Q?tjPfXyScLgYOf2qRur7YJq1epQLWAAKhFk6SoNTUXTXTEJmaTqIjiYTWsf5K?=
 =?us-ascii?Q?hY7QnvhxXLLeRWX/d3dYfhJx6icZjmCE3v2CGLABNX+5LQMtAlVrLgojLWHD?=
 =?us-ascii?Q?9shIYj5jeMRWZ0p9liFCvxSAsqZxIC+2Ex5sclK0e06+tfSmh78jYTFOieBY?=
 =?us-ascii?Q?wNzI8LpVkj5V66hig6yia+2vgLsK0pl+zp3QLUocKCww2FzyIfVUfPMjsFtq?=
 =?us-ascii?Q?jQtYGo5JB7708Z6PZaIg1tuccscUOYl0VcY/86HY/xuqdVaguPIA63rsrA1h?=
 =?us-ascii?Q?fy0wuomU9STYOiQCHxNFKZ01gY1bP1Ajr0Q74IFczIUHLPf09nvRgspGiki4?=
 =?us-ascii?Q?OmE5ErspGwrup78Yv7hFqjvmAFaNVTdKqCVl39mmjqYmyN2dLBZ7NFrBDGoG?=
 =?us-ascii?Q?huC0RQOsSb9nWAjqZXHtHnx9sZvgujvqShWbfEo9TNsTwXsfs/J/Z2vd4Lw4?=
 =?us-ascii?Q?WdbsBTTfLslH4m5106AY7C+1kG+ob7NxYT6EoRY6MU7vAkAzPHKoPXlrwMAZ?=
 =?us-ascii?Q?X3Yw2HUqQO2aqiHRbsH5rwaC2BAEiecXuZU5lyrlKLid0IlOMTcK60igrndk?=
 =?us-ascii?Q?TuuQ9ngAlNkXf6GQjgdAYGQkDbrIUDgHuYgq6V5MXkoVKXLRl6zF+7gR9gO2?=
 =?us-ascii?Q?cc+0bEHQUMuPIKAxQZbY+eMZoyirRxBYAOT+hPsNd2upL+Dgmio6Honk/tci?=
 =?us-ascii?Q?BTNpm7TYtpHTfd8dkKUGexrH4v/IORdY0tbctKb4OEe1/rdX4NlBJLT6WG/V?=
 =?us-ascii?Q?f2sXtycBeRZ8TV1hBiyWOq0DvAFXjcT0tXPAfKIqnr4xO9+S13wHKmU32ymT?=
 =?us-ascii?Q?Kk0uSvCSafYzYgbNkyanJo2Kdz7zBcZUijDaImncbxG/DYQJb+E9bGkk4yZk?=
 =?us-ascii?Q?YcowyYhobhVf0o52emJ/uXDRvnOxUkWqSR2keely2mjNmO5AfgZBo1W55nik?=
 =?us-ascii?Q?hoPYndx7wjKuiEhMNKxc4uXmVOMBszBKs75tX9AR3N+ZC22MczukPCL6MSsA?=
 =?us-ascii?Q?9iuPMKwfjngHrcsd9qx1t079vSEdkHsySnXZungJi0MFzS3F4qXL/g23A1nV?=
 =?us-ascii?Q?E0o/G+oN5jrgI7jw7cj9MYCpDOg3O3jR3tPsv+xMSytHR4lUMTXhZ6Eja1CA?=
 =?us-ascii?Q?eU6BJcpSrQqsS5ayMLCD/jTgZys7jF08C30XxP1XRVEkaDkWb5v0DFeU2akM?=
 =?us-ascii?Q?k4D7lvPys61nDBzRn+LxFc5tWJXVhcCnxUi9pXmvz2LMh83qGvwJ0B9YvDEc?=
 =?us-ascii?Q?M8MbtHO8+81Qyjw/zaPk2PedVMf7cXHv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:25:39.5955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4228aea4-a478-40fd-fd45-08dca4da006c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
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

From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>

Add resets property for UART0 and UART1 nodes

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 34f592c1a85f..6a29f6101534 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -1025,6 +1025,7 @@
 			reg = <0x0 0xff000000 0x0 0x1000>;
 			clock-names = "uart_clk", "pclk";
 			power-domains = <&zynqmp_firmware PD_UART_0>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_UART0>;
 		};
 
 		uart1: serial@ff010000 {
@@ -1036,6 +1037,7 @@
 			reg = <0x0 0xff010000 0x0 0x1000>;
 			clock-names = "uart_clk", "pclk";
 			power-domains = <&zynqmp_firmware PD_UART_1>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_UART1>;
 		};
 
 		usb0: usb@ff9d0000 {
-- 
2.43.0

