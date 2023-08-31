Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4273C83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69BBD865A0;
	Thu, 31 Aug 2023 16:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j+yqYqZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3250865A2; Thu, 31 Aug 2023 16:28:05 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B6C88659B
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 16:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOGIVHZszjMzV1nrHXhUBPE7OdXNw92wiugNunv1sGihrYn8f2GUPjB+D9oo4N8HDlvB2IsYSTIUjUYoFDonFxmns7XDPMUqM+Hym3T4k1uPD1UBuet4gw066JlrBT66jTCReFznHdGzeD/J8lKrJyh3NrjuxivEhjhhw/j533xcW4B01WZqkocMcXzeKjP6m6UZv5lpWzNipZ+6wn0gC6r0eYmz6zEiCRPeOtf9rBnLETROsVEZo+ZxoaXW7EAOqxDVfuKeZnbCK4iGSAkasHd6guhvaxUT8jgIbCWOhBi+MyR6lJ7b2JngK+RALckmE8tX+sxkA8Z+qbFO2PU4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGA1XPT2He+DSfHC1DYXD5lJZa4PZai1b8Gm4/HPg+U=;
 b=dF3SEFKXPvM/nixAh3qwIWmfcx6X/9dBgzVKOIud0q5Y06Tk3qe/6K1MumtVrT9s6zzPziQurY0HI6TT7KHWL1Xtku5vl+nIqPm4ptr1lX7gCqohW16jRZSVwQBB9iTODwGMfUn2JJbBABa2z5Xtfh3ryRBLLP+tnMzOY1gdBPk50tCq/bqARcs8i0wKFQa9TJEmPdR36Cde+7kABCIF6YUdGFplHgZzf3OArMGXJMEOJwbpncxkUFApR/1D+nGC+2Dv+HhloNglCfJUKk2A8GYWSFTRmtNW30llMel+OOhQ7oved3jUaal3zs0P2Pzhk0oMTbbz+jiNiStVHQ3/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGA1XPT2He+DSfHC1DYXD5lJZa4PZai1b8Gm4/HPg+U=;
 b=j+yqYqZcOfK+MOR/TUTit9HFJNIhyOQFN1Bh9sPsuFbN+wqOcDPWqIkdR+9I4jyECgyf6/ExZp510v2d1bjs9dJadAA088iR4ZCv1PKSHTH5gWq7oaF0iI5Wv4KIlJJLC9E15IaAttH8L5yUrICsRSKEiEBdxDhzH5OH/aN9Q0Y=
Received: from SJ2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:a03:505::26)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 14:27:58 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::3a) by SJ2PR07CA0003.outlook.office365.com
 (2603:10b6:a03:505::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 14:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 14:27:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 09:27:54 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Neal Frager <neal.frager@amd.com>
Subject: [PATCH v2] arm64: zynqmp: Add output-enable pins to SOMs
Date: Thu, 31 Aug 2023 16:27:53 +0200
Message-ID: <7ecd98b2a302c5c6628e0234482f23c38e721fd6.1693492064.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5674; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=404z5ciKtdeuTCVy2dCTTIjWP6iUSrhRfqaBvqW5unk=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpQPixOfZfQkSaWcXvli2v3CqnrhTYdUy459XlbWlHFXN
 2/PW7XNHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAipd8Y5oeKbN583FlUTLlY
 YbrazrfKXlGRXxgWdMjGLF8h3OLwKufpLXmnZ2IJas8sAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b5296a-49b7-4e8f-2dfb-08dbaa2e78dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZ7TsQFSoYU0rU6cQ0pn+boFdgmomwtvrKxA5shxVQ8A6603Nb02XqdY30zWixsFp8Zc4/+hG2tGTaU97yVMWtes/o8V5YXRgyk2yx4xCuWTV2rW5J5/jdImJPjvmKzzG99of2KE5VCKkI5ZvD+YLiH0U7ByMZWBf4/Z3FN3TnlCVd3qce5+4ww+It74ZiOV+5b5bn3dR4x8/MtmE+OmMGQksDNnAJ3Qx9B/7D8Oz7N0qRXJz9i4/TymbTgzOe2XuGR24Hv1zJuK3jL5OqK5HDbK80Evh/WGLskepirbaTmFXUFn4Ma/ve6Nuv6B2Tp1Q9UJ2FinUPGstJmMheB8mE4KriOYp52Hrl1bP9aO+h2IjRx8O0cTxfr5r9IrAFTAAVtK3xAXOnKrHmqG5SMhEs1AfdLjCYWGCm8C76RxsKTurbllOQnBeDvsgfq35yLJqcYTHDxtGOYtZMwUMJKoLq3/rHdeAIsWhAWljJwdRpZRUF1XAe6mCPkvYt4sOu9clGW6ZvDl4t4EGjiIgQyL2YjKbmkdD97pWXjSmVohztZc9oKdkxRssaMmc4fjat1mhzw8ariJwIx0976mFWYFxT2EqzfuiQU8UHj/gioUJHnkzqhIDTxKcsxIrV1yIaNCE3wsen3/XZStAN7GweR2Q/7L3Wt/e2l0cVV0zleLg4Of4DxGY3g9mSenD2wCHzpuQ8zbP3YvXJwR7THZAKXHKkyEwMR7aftNZf3dA1CYpIfgvlL24ndhR/N1VRhCdeD7jQtyT1uVbEJd7UwPQWD4+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(82310400011)(451199024)(186009)(1800799009)(40470700004)(46966006)(36840700001)(36860700001)(82740400003)(356005)(81166007)(40480700001)(83380400001)(110136005)(478600001)(47076005)(316002)(41300700001)(70206006)(70586007)(86362001)(40460700003)(2906002)(336012)(5660300002)(426003)(36756003)(2616005)(44832011)(16526019)(26005)(8676002)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 14:27:57.4629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b5296a-49b7-4e8f-2dfb-08dbaa2e78dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

From: Neal Frager <neal.frager@amd.com>

Now that the zynqmp pinctrl driver supports the tri-state registers, make
sure that the pins requiring output-enable are configured appropriately for
SOMs.

Without it, all tristate setting for MIOs, which are not related to SOM
itself, are using default configuration which is not correct setting.
It means SDs, USBs, ethernet, etc. are not working properly.

In past it was fixed through calling tristate configuration via bootcmd:
usb_init=mw 0xFF180208 2020
kv260_gem3=mw 0xFF18020C 0xFC0 && gpio toggle gpio@ff0a000038 && \
  gpio toggle gpio@ff0a000038

Signed-off-by: Neal Frager <neal.frager@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- update commit message
- add also fixes for kr260-revB and kv260-revA/B

 arch/arm/dts/zynqmp-sck-kr-g-revA.dts | 6 ++++++
 arch/arm/dts/zynqmp-sck-kr-g-revB.dts | 6 ++++++
 arch/arm/dts/zynqmp-sck-kv-g-revA.dts | 5 +++++
 arch/arm/dts/zynqmp-sck-kv-g-revB.dts | 5 +++++
 4 files changed, 22 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dts b/arch/arm/dts/zynqmp-sck-kr-g-revA.dts
index d318773bd9d6..30a0230d4767 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dts
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dts
@@ -250,6 +250,7 @@
 		conf-tx {
 			pins = "MIO36";
 			bias-disable;
+			output-enable;
 		};
 
 		mux {
@@ -301,6 +302,7 @@
 		conf-bootstrap {
 			pins = "MIO45", "MIO47", "MIO49";
 			bias-disable;
+			output-enable;
 			low-power-disable;
 		};
 
@@ -308,6 +310,7 @@
 			pins = "MIO38", "MIO39", "MIO40",
 				"MIO41", "MIO42", "MIO43";
 			bias-disable;
+			output-enable;
 			low-power-enable;
 		};
 
@@ -316,6 +319,7 @@
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		mux-mdio {
@@ -346,6 +350,7 @@
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			"MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
@@ -373,6 +378,7 @@
 			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
 			"MIO72", "MIO73", "MIO74", "MIO75";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dts b/arch/arm/dts/zynqmp-sck-kr-g-revB.dts
index 69dba0761b37..8f4c52d6d643 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dts
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dts
@@ -250,6 +250,7 @@
 		conf-tx {
 			pins = "MIO36";
 			bias-disable;
+			output-enable;
 		};
 
 		mux {
@@ -301,6 +302,7 @@
 		conf-bootstrap {
 			pins = "MIO45", "MIO47", "MIO49";
 			bias-disable;
+			output-enable;
 			low-power-disable;
 		};
 
@@ -308,6 +310,7 @@
 			pins = "MIO38", "MIO39", "MIO40",
 				"MIO41", "MIO42", "MIO43";
 			bias-disable;
+			output-enable;
 			low-power-enable;
 		};
 
@@ -316,6 +319,7 @@
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		mux-mdio {
@@ -346,6 +350,7 @@
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			"MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
@@ -373,6 +378,7 @@
 			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
 			"MIO72", "MIO73", "MIO74", "MIO75";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dts b/arch/arm/dts/zynqmp-sck-kv-g-revA.dts
index a81b3f6f51ad..55bef1df75d0 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dts
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dts
@@ -205,6 +205,7 @@
 		conf-tx {
 			pins = "MIO36";
 			bias-disable;
+			output-enable;
 		};
 
 		mux {
@@ -256,6 +257,7 @@
 		conf-bootstrap {
 			pins = "MIO71", "MIO73", "MIO75";
 			bias-disable;
+			output-enable;
 			low-power-disable;
 		};
 
@@ -263,6 +265,7 @@
 			pins = "MIO64", "MIO65", "MIO66",
 				"MIO67", "MIO68", "MIO69";
 			bias-disable;
+			output-enable;
 			low-power-enable;
 		};
 
@@ -271,6 +274,7 @@
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		mux-mdio {
@@ -301,6 +305,7 @@
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			"MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dts b/arch/arm/dts/zynqmp-sck-kv-g-revB.dts
index f935f25c887f..1b1d9e772f55 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dts
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dts
@@ -193,6 +193,7 @@
 		conf-tx {
 			pins = "MIO36";
 			bias-disable;
+			output-enable;
 		};
 
 		mux {
@@ -244,6 +245,7 @@
 		conf-bootstrap {
 			pins = "MIO71", "MIO73", "MIO75";
 			bias-disable;
+			output-enable;
 			low-power-disable;
 		};
 
@@ -251,6 +253,7 @@
 			pins = "MIO64", "MIO65", "MIO66",
 				"MIO67", "MIO68", "MIO69";
 			bias-disable;
+			output-enable;
 			low-power-enable;
 		};
 
@@ -259,6 +262,7 @@
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		mux-mdio {
@@ -289,6 +293,7 @@
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			"MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
-- 
2.36.1

