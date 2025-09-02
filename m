Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F00CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9A283285;
	Tue,  2 Sep 2025 10:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qNwdENlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7D1182C7F; Tue,  2 Sep 2025 10:53:55 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5A483285
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0CKVsmJwSAhEhQyYlhDF4lDluR3ndMO1lKZzQ9LpEiU4hfoUSnOa4DWXdDFwOPOTxAiQ9VE2fJF+6VAEH4jp69lXRoko/0MH+xk3R7d4Abkaj/G1ZKNM1Wexu254f83FavrL8Ir2fs7q4TWmoHJf3dEU0e+PV3PkeRDJ4Om8udqWWPkwIvkiRxmPrz3lVtdMI/pFBD/jauIBmA2W7NMORMgJBurv/DrlVtIlymd9rEOYyOqiwZaMicxg63rTCbYGYx3q67FF243RjK2vvvDWjy3OuXx+QSW54KhLlbaG07FG0vJyBORY2+BLKiEMczmQRe2RaMV/vrLdnrOe8oRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9ZjEduZYXfjQV8Vrw2B+f+pAgaTR1Uy/jrwUIW+5KQ=;
 b=LI4S1ArrskYuV6tKD7NUjqzdSycO9VDK0lpIKfFnv1+tfQ+h1HPdVEjC9VHW7e+9jw0QI6Y4o8BdQ6jSeQ7tCY2/eVivkbkj5AKrN5D67MoOQpQ2g0QNoIODgzuvxvowgSaFb+qdjGlNAH0fyZtC0J4mKuCQct/7Rc7H9HRcn4+2kzhXGQnaIgWhADf+XKZgDzd/jcl4A6e5PLUIg4ARGj99f6tYZBWCGN4JFd7pNjAHm+h3O9j80sU2vVumgs64HFtnBTgHGpsSAEifyIOO+jKak0nu1U4084k5nAA4Bv/0+zv9dFNkIxgtG6aJrca01FvJ/n3UPH4/GQIsy0doyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9ZjEduZYXfjQV8Vrw2B+f+pAgaTR1Uy/jrwUIW+5KQ=;
 b=qNwdENlTvw+jfEt7uZBiYc8+ydH3PCMgU99RgRQy+AH6Om29JNVItRgrbdHOBbvjIdCQsoLMdr1B9hbqVQ+PUhewvtOU9c56WBNpuVr7ShFItTk00E50+84F+mpvoQEROzw46+B0nVaXFDsAJQHtUkHSjYjXSu5iHw/jourFsdc=
Received: from BY3PR10CA0018.namprd10.prod.outlook.com (2603:10b6:a03:255::23)
 by SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:53:48 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::5f) by BY3PR10CA0018.outlook.office365.com
 (2603:10b6:a03:255::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 08:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:53:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:53:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 01:53:46 -0700
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 03:53:45 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Quanyang Wang <quanyang.wang@windriver.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/12] arm64: zynqmp: Disable coresight by default
Date: Tue, 2 Sep 2025 10:53:23 +0200
Message-ID: <1ea8e5bdb9bfdcc1fc6670bf4b4e13c40fbdc00c.1756803198.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756803198.git.michal.simek@amd.com>
References: <cover.1756803198.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=djuZrOP0Kmfxrd0QZt7cKrlDWedouo5ZjpqD16EGc8c=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRs29BW9yz0Xqu4/UnHnmfnt00/sthaYHfS5tDJTRHrB
 BYX38x81lHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATSS9kZNgmbHxhqWrRKpYD
 16Pvpj7/JthxecGp6E0fpsXX+23u//mHkWE5t4eL+JYfM8VudLlVzvhppaM+9Zlh1yfGqI0a3NZ
 bd7MCAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SJ0PR12MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da689d6-95dc-4f4e-3fc0-08dde9fe3b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ct1UcaeprYPIxwhjvCeb2UB5rGnKG+CDTuLbVM5RSi+1RBf8T3WElsAt6rxC?=
 =?us-ascii?Q?tewxwY2OSx/qL89jnDVyd3CAdQMnjlkSZqWCSiGqv8Hkf3Hn8gFZCWlicKDF?=
 =?us-ascii?Q?GYRRIwFlujRl3dcHxOy1Lge/Cjprg9wpDIcdA5VaYT+HcKONtGxuSca7v31s?=
 =?us-ascii?Q?w3+3TcO9zbowhoSUcB7bqUaiM99gkiAn1S+q/Jgkma3OK0qUIfh0CdhpRpwG?=
 =?us-ascii?Q?d4W8/hzi27T0X6+j60e4P6o8cBWHM6uz7HakbkFWbgxwzuf6NH8QZkElxA3A?=
 =?us-ascii?Q?uRpTX8XtkuOYPNPiCe4gH6BE8gnfjsLCzCWybUcM9EwOkpXufIp4H8AkYOIW?=
 =?us-ascii?Q?QR/r7njJn+5cTu6Ib1wc8PmbMSfWSbogaPz0t96knAP5SGTg2yC/MdjlSFUs?=
 =?us-ascii?Q?2FDKIPktU1waU8siLG+JY6BM0DbNqNsaTMOPzJZ04dWVw5ufHbbj8UHe09Jc?=
 =?us-ascii?Q?Y2OZAYVcluU/m6jDIf9cxkwBiGHx3lkmrqcaCPX/BlmehN7FT+zjvTB36pb7?=
 =?us-ascii?Q?zzk/ZqOBQ6RiuXMj2UdwQYEU2dZZkiZk6Hn1VKU65OvFlJdEsw5HOe0k3u0J?=
 =?us-ascii?Q?vaUFUecOhTHt1IahzdGzD9DzFwLARz32ymaKyNa+BG2tIRIDtyG/oQhSfth4?=
 =?us-ascii?Q?aK9aIY4jjdCKnBV9CKf6ZBEIgCgtVTMu+zlHXSGlh8ovcpEaIoX6HYTRWTVJ?=
 =?us-ascii?Q?fLga6dDT8tqxvG5R9rjhPv29zANqIg+4wOy2WRLluN04/2Hfdt/v6ORTJmQp?=
 =?us-ascii?Q?DmEL2iU0o2ADQMQept/GnP1G+/AANdEwy9ihEJNHMu5jxVFERYQ1M476XoyZ?=
 =?us-ascii?Q?eXZATdCYNSYlkXfdQfPgOKkLmCur5y/U3k95fjqkn1ZlszjQA962xuFbNRf1?=
 =?us-ascii?Q?j+szDtgSq4cuMUx3O91Crb4uBldu3eZgbAfVHarF/lEKoeFFCc0zQscO/xOb?=
 =?us-ascii?Q?c12lipl0CUrzG7aKca7OchcYX21esV6w/lXP42/1SHfpcxnJMd2yrWkq1RfN?=
 =?us-ascii?Q?LPCYn3Ul9n8SyIsMnfwlzPTzo4lbSR1Mp2e9nRCCqYBJ7MyykCnKtHtkwUkg?=
 =?us-ascii?Q?rcKUnO4dNQlRm4FusjsVevkZEZm2cQ3P5GSkM0cLFK6yFH6002AiM5SIATAr?=
 =?us-ascii?Q?NQ2lrPCng2nP/WkDeshRw411PVstGV6Jdz6AiPr3XcsN8vc1UMFSCy8sDcf4?=
 =?us-ascii?Q?jx4E+n/Y5RSQXdZJ3bFVpGP0iljcRJf6FUXMMrijstJgiKCuIvbhoOhA5hJM?=
 =?us-ascii?Q?961E+U3pzHFNh7ceeVEpf53ZNOcFSXShH/nCXgdJ9JYw9+GLjhN0RpuopVMW?=
 =?us-ascii?Q?/jHfrRpDhuVZgD1VHzO3StO4QPI1dUg24F4lfENEmH+LbW+Bb0PfMlA2sZBu?=
 =?us-ascii?Q?TCyrfr3b0ohUcUCXGg7zPhLeIkiIJzzX3/+D9tfNjiMLsPzBdIbIYEkxprj4?=
 =?us-ascii?Q?FTdbDKQtVUzhW9fsejs5tCOOadjRXfpxXy2Zbk8+rPx/E/hX0X9pNhfUEGhQ?=
 =?us-ascii?Q?5Vf60rWROPtBrozbHZm11ocCbj97NZOs0UMI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:53:47.9776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da689d6-95dc-4f4e-3fc0-08dde9fe3b3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065
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

From: Quanyang Wang <quanyang.wang@windriver.com>

When secure-boot mode of bootloader is enabled, the registers of
coresight are not permitted to access that's why disable it by default.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 0e0436ecce82..9f3404ee8b42 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -547,6 +547,7 @@
 			reg = <0x0 0xfec10000 0x0 0x1000>;
 			clock-names = "apb_pclk";
 			cpu = <&cpu0>;
+			status = "disabled";
 		};
 
 		cpu1_debug: debug@fed10000 {
@@ -554,6 +555,7 @@
 			reg = <0x0 0xfed10000 0x0 0x1000>;
 			clock-names = "apb_pclk";
 			cpu = <&cpu1>;
+			status = "disabled";
 		};
 
 		cpu2_debug: debug@fee10000 {
@@ -561,6 +563,7 @@
 			reg = <0x0 0xfee10000 0x0 0x1000>;
 			clock-names = "apb_pclk";
 			cpu = <&cpu2>;
+			status = "disabled";
 		};
 
 		cpu3_debug: debug@fef10000 {
@@ -568,6 +571,7 @@
 			reg = <0x0 0xfef10000 0x0 0x1000>;
 			clock-names = "apb_pclk";
 			cpu = <&cpu3>;
+			status = "disabled";
 		};
 
 		/* GDMA */
-- 
2.43.0

