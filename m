Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47FBC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 09:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11BB984A5B;
	Mon, 29 Jun 2026 11:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YbHFbRdq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2301984A35; Mon, 29 Jun 2026 11:47:08 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 016FA84A12
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFsmHphSZ1Pjwup8APqPQwHqXFxEhddNZtzt3CboZCkLdjAxsT3PxFcNDYv7dAHvaIy+rBQ18nNTzcDEmPxFncvgBoHUf943ifvgAmblWpLGTMFKD3M+VZAZz2ybWG0bZkfzbBz+JLJRCxOuKmSMfp00Re9AIc1Y9yt1j/A5mbD6I/N9DmiVp281AvjLLZUmibC9WenaThWiuqFAKNTaAkYBkPKr/hK4oH+YzM3WosutNa5BbXyPbZvOf4q2DBvhG1CvN/UNRinwphMlWNa+hO/0/5Bkh8GQfoNEaDtULweGavOwd0glhJPh0wJjiFwOmHYmg0W3w5pUlunmUJbUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZEt+0XBQ0I462cagsJzp+6wDnfC9zuQiwXC8uUZU9I=;
 b=XUm29Cgw7nXYQM+EPan9eV7UKtU3lkvym/ZBrqQU8EbAj0h4i3nQJ0GvZPqixP0Y+Lj5BHRv72J0IXXMDGAcJ3aNGB/XsN7ShaLr3pTyZQBh8keZp/V1Fc9YFVeA+HYyd7efHqOutglxYGvYVg9ROLt/xEkGkOam26PCJ2Sg25vL/rhQR6Dn715ce6V0qnHqINEgH6ARWHP22gXRr1BMR9E6GdlLgYKNliu8p7yKLWL7R+uIQ/rUySoQXztdHyG3vu4HZ2vOULS5Hv4jGtJLu1ZLb5GCH90SP9WzFkqkWa+Sv9vo4jTiaUJ9dCnX6IoB6Aim9rQtCxpL7jX1uyZkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZEt+0XBQ0I462cagsJzp+6wDnfC9zuQiwXC8uUZU9I=;
 b=YbHFbRdqC5Y15o2wWQXi26Wb8rhH3E3C1giCUJmIjkFykPRhPhptCWQWRg6AJf62mdyvM+IQNG7ohtzxqygsuV10bRTYPle4+D6Jy+bZ6eVLq0gCcuKLtSDvWqmCyaeotpS88x/iDTkOYaE5WtNOK00F7yW0MqT1340JfAdrjn0=
Received: from CH0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:610:e4::35)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:47:02 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::8d) by CH0PR03CA0210.outlook.office365.com
 (2603:10b6:610:e4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 09:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 09:47:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:47:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:47:00 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 29 Jun 2026 04:47:00 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Rohit Visavalia <rohit.visavalia@amd.com>,
 Shaikh Mohammed Suhan <suhan.sm@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] arm: dts: zynqmp: Fix space indentation to use tabs
Date: Mon, 29 Jun 2026 11:46:36 +0200
Message-ID: <0dc7b65ebd48676719ace15a505ecec2f324822a.1782726386.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782726386.git.michal.simek@amd.com>
References: <cover.1782726386.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2618; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=pfJaFdzEQrFR9BcQpo/JBzQwFRZynblMrR7QrBTR5sc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ52f3/MPVA0jzjhke6dne3JniUWC6R3512ervbg6xb/
 w19T8vt6ihlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJvI1n+B+mOpcldvHuDbqm
 +i0Vgi8djpRdv9j66UWi+KEDzprma9gZ/hk5XfEoPfgzSyx8G4f/VRs/lz+W72alHqj7fu5wyxb
 xHUwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f5480f-5d49-4630-1f18-08ded5c35ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: tWbw9JfVKb4heDuwFMcpIczTvIwk7cmHO4ckJ+mhkhgQLpurNFGjjMfaKIW3a57TYmgT6+VMSG1hlX0SohqCA9jm3B8aHQyk34BXwUwk8qERCsR45rg2hd7/XpquweO7+e3M+k9PPY119OAGEM0v9dvLhVa2gPocdIU/hSncHKWuPG3TrWT6FKB8lLbb0PLRlnJnjGxrOrf4+50rxttANQnBpDpqpA5A4qkenwMebh6moCSRCsBUcoIVtnHf3LV/hUzSwbutnaZL5cMZr0adsGXq259BW9XwU/u9iraCIYNzY00vAchigYt1aZNahmHDrFEMpClv3h82OUWVG1+Xk9V0UrPyRXPbSC9EsFODxsxHPa91Jf11Mjqw51ZJiuFSLJdXgEhLGxh8kDoZAFucbv9AG9VMppErexB9i2XRFcp3Ub+XZzGvIhVx1nC2L/hY4s76kGJ2NY+d27dGlo+wVEaOHPXgHhUSoBOQ7YwBA//w6FROq8n8oX3+mAcML11P9Y2Hp2rlo+9b8gAZl2+oxe+CJJdlhcE0me/jvsYNsU6Et7zY2LtOQ23c5x9z8I/3mqtsz6YH/qIdDUK4cpeM6dZYY96nOsQxpRdtjV69dUzd5exb34HijooLXRwJjBed0t2vXJmom3Zz6EV6LBSY5NFa1/nLWWla6qpSvGF079BAqHjKdzX41+r4YLuAAp+Ld6Pw+Gkt9WNkrPwvbizwXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6yZYeYs1djil/s/yz0agpJe4Ftu7SONeDHkLcms4ZjHiXk7ijootRN9/xoNWRsY4hFHQhniYvAjfJv9qPbyZe4tha8AlvNqpR1fDrzxRhrrU7nC86wG93Kwsce+c5MNmrxHhjUcANaXuzfAReZnPlJcAHG22zv+WjhtIjzSuTrbr75qfmIoJ2QK+hYghWKxI+See0794K+ewnOwvyxTK7+YecdolV/9OFeIx1mA99/1zzb3ELC2vIo7RMA3GXj+OVkkXCxcCDtQEb3xNXaeO9WojasRtlL1OB1gMokSxrd2e1lqYJNySFTPal6BEjdRvBHzzPufQhSs6aIKqDwJsbIifunA7TUEXn1Ard8/d8tbOd6JNnUkecfzeVa69QL44S4uGoWQ+MxuRwZQpCpo9TLJJcXFTy3JC98Qmxkdwuqy0TTjUbAYuMytkO+24UZRY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:47:01.7895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f5480f-5d49-4630-1f18-08ded5c35ec4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
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

Fix indentation issues where spaces were used instead of tabs in several
ZynqMP device tree overlay files. Device tree files should use tabs for
indentation to maintain consistency with the kernel coding style.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso |  4 +-
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso        | 40 +++++++++----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso b/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso
index 8bb4dd6e3e7a..58be0e1c890a 100644
--- a/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP VM-P-M1369-00
  *
- * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ * Copyright (C) 2024-2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -409,7 +409,7 @@
 	};
 
 	/* connected via J425 connector
-	 ucd90320: power-sequencer@73 { // u16
+	ucd90320: power-sequencer@73 { // u16
 		compatible = "ti,ucd90320";
 		reg = <0x73>;
 	};*/
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index 3c551f303150..967548744d5e 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -246,23 +246,23 @@
 	status = "okay";
 
 	pinctrl_gpio0_default: gpio0-default {
-                conf {
-                        groups = "gpio0_38_grp";
-                        bias-pull-up;
-                        power-source = <IO_STANDARD_LVCMOS18>;
-                };
-
-                mux {
-                        groups = "gpio0_38_grp";
-                        function = "gpio0";
-                };
-
-                conf-tx {
-                        pins = "MIO38";
-                        bias-disable;
-                        output-enable;
-                };
-        };
+		conf {
+			groups = "gpio0_38_grp";
+			bias-pull-up;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux {
+			groups = "gpio0_38_grp";
+			function = "gpio0";
+		};
+
+		conf-tx {
+			pins = "MIO38";
+			bias-disable;
+			output-enable;
+		};
+	};
 
 	pinctrl_uart1_default: uart1-default {
 		conf {
@@ -421,9 +421,9 @@
 };
 
 &gpio {
-        status = "okay";
-        pinctrl-names = "default";
-        pinctrl-0 = <&pinctrl_gpio0_default>;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio0_default>;
 };
 
 &uart1 {
-- 
2.43.0

