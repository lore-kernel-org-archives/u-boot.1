Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7925C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 23:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DFD784CAF;
	Thu, 16 Jul 2026 01:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="S3XexwcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A7FE84C83; Thu, 16 Jul 2026 01:18:07 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DEF484C42
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 01:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Haller@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO2vPPi+Ew8ykELuP0k7PD9L2lY5Cvv6XY/9gfYKevu7qfPIFSptgqogZWPEBJkgJ+kJwQHtzzbmQTy+nXbHqLT4WLxjcPYDKeGnA8NnO9k3onESwC61/TkfHxYSvAlQcmj8xcELrsb9JLep4aDb+3K6zp9lb0R9BR/s6e4qsDwaCU1gfIh1GPiqURJQRghJO4IPfH3Rspd53DcJD6YRk80+JgslOL/gEU/gRoOigUyPFLo/lARtU0jIS63aO4EzUvp82XzCn9HhgxcsR9eJmCww5LMqH6m6oIpWYuamP/DiRoKo5fEWhkTstrlM+BkQO/Nbys7SZ5P6KUDsW1+Vlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23uCKoPN0TyO7XWC9nF6lQX4FQTHs04MvGzhZy/mc8s=;
 b=ABKbuoVr7bprimUGDbLTFNgJwEeP0uHiYHIJWfBAxVFQMZSUMnyz7HVmhbCrRIiO0o2ceHRrV/1qjWFW3XdYPFJmJaXm3+01fVs05GgctZYydz8/MBrvL+S+o2dAGm68C/q09duD1i6qoejAJUGIGAOhDnfvIjZVrNMgPwnIN94CZJJ8kFX7ozqGOtuis5kzS9Bf89SIh/OohclroKXB5GPZ/xAKMWzhzrEuh7z1y1uLDx7qHmTV6pIbUoFf/t4Cw/rWObR3x9gkjGI57uqLNKasyh7IntXjCMtKJ4LxyiAn41E05jdyjJj20OA9nIQTBvGecXBHp50daQovuhowFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23uCKoPN0TyO7XWC9nF6lQX4FQTHs04MvGzhZy/mc8s=;
 b=S3XexwcPKp41Z+CsUFxzSRz3clPNdwwYOvGh2+99nwMET8WtrgFqM8PFBzTPIm+xPWRtKl4iC7WffjZ7eSxJsWd213oNFQGKSqZ33D5u7VRdYJGUUCm1SAcKcUpDBwkYMoP+aaRhX5V0NUvNXY0+J//76oxBORp/bS4q/N0RG5TzVTGBi59AK7ZIovo9vn4YeIt4EVk/yNGgrEslF9mHgZlxCSJTIde/56NPeYUuBDMVobRUBIC20LkGxEpsMFnbZQcyKk+81VPXfSq4bNqWXWrLHnmt5oknnW41ZyV6ZnOGqxL2hwFIfmUFFG9ji1L3FY9Xl59RSU7dutQFFbvC4g==
Received: from AS9PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::13) by AM9P195MB1236.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:389::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 23:18:02 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:20b:540:cafe::7) by AS9PR01CA0004.outlook.office365.com
 (2603:10a6:20b:540::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 23:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 23:18:02 +0000
Received: from lws-haller-privat.phytec.de (172.25.39.212) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 16 Jul
 2026 01:18:00 +0200
From: Dominik Haller <d.haller@phytec.de>
To: Dominik Haller <d.haller@phytec.de>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>
Subject: [PATCH 1/2] arm: dts: k3-am68-phyboard-izar-u-boot: Add mcu_i2c0
Date: Wed, 15 Jul 2026 16:17:39 -0700
Message-ID: <20260715231742.56105-1-d.haller@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.212]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DF:EE_|AM9P195MB1236:EE_
X-MS-Office365-Filtering-Correlation-Id: d52d93f1-f6d7-47b7-1025-08dee2c7516d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 9kOoJAIq5Ra0GwOLKa6i32TG+kBaTb2jzCSZmhAn0aJ1UX4kpuEq+6yH7WHfM41MjTX7VaE2W3NeW+GKxwgb/j0qO31jUYXu60HOHeQUKXrU832d8ZADFW00oLFpOBSVFfoKrLZr4TmPTK8WB2P5bUJuulARJhkhc0ihi+YgONMrTfOVs7jTL+/ZmxEzV1xLAO2y1/INgAgFJueJgIUyrb+DLMr9k5k3wvPYmvjCiVtd+DIXCBh/8xdGpI96g0rxIP8+1PshUoj/OoULf05k+TIWJW7mf4eFG0PYn1LsmcHi2wZDDus4a1mmAH5ahK2cYIK2uNKuBYrJStUhm0SDqzRE4TBhPVS6Qod4zsODZcKzjyO+nk28X3ftK3Uzw9+VY9ftLfPBGwKMjyaI0VAOPGXCLzSKYWOooKyLzcP99cSqbuNq4/EB6OJa0BIYk9Qf8BNud7ngZ5MpRHJtXWYLegCY8OIzMiMfq28Qcsu2yQc5LKVsXTYkvXFI0hpUwOaCaCCvWoRmX7VoEDxm0LlrnP/3D75i/rz8v55S1lhnFCthSN4kOWueJ4+wRc1UO2yCMV0Mh2hmoaDpolKdP6wMfoCvqf6l+NvzttKMgS+SiiRGlweW+hFxlQ3OIgKioNlNOHgJhvbK5ez0+W7vQerPHFZF5A7nbca0I+fGjS+Ct6nRhMsUnnV7nnAUXWi+2jMF
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WNso+PZGxDLCXvRm8OEeWLCgOjQZOpP5cdEnP3S7aCyphzAEDiWvm12wmOmmjd5U4/5dp1XrnsrptfmdpWzcuRFdLKB+8ws4EArJPohfnzHDIO4eURqAQYgIJFMW7op/Yu3Y7Ujk16maHzLZ1eCq5xbMGdhezgogdt+t80k1O36xQWQnZX0wgx8dgdPgut47zhEkQ+Vle/PeRLhWHNjJwtL3Z6iug3HwUGOhMlOafx7uVSorDyQf1F3CbgLp+VxzwwfN2DFQH1+hDye8RGK3etG0YhnwQWfUFo4i1pk8avvJjpEI/oKJsRRBFLAkqlXOQvkVgM1nb7nAchFhDrnbNRiEanJ67KVazJEYOn3AUQ/FTdsu1qRYh2r5t5iHLa0kk5Qvt+usy9PnSA0izN/zfZQa35jbTpdWkvoYTc3wno7hp3SI2HJYv+Lz2GhUDNi2
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 23:18:02.5233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d52d93f1-f6d7-47b7-1025-08dee2c7516d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1236
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

Add mcu_i2c0 to access the pmic watchdog control registers.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
---
 arch/arm/dts/k3-am68-phyboard-izar-u-boot.dtsi | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am68-phyboard-izar-u-boot.dtsi b/arch/arm/dts/k3-am68-phyboard-izar-u-boot.dtsi
index cd40506d3ac6..503ed69d123f 100644
--- a/arch/arm/dts/k3-am68-phyboard-izar-u-boot.dtsi
+++ b/arch/arm/dts/k3-am68-phyboard-izar-u-boot.dtsi
@@ -8,14 +8,27 @@
 
 #include "k3-am68-phycore-som-binman.dtsi"
 
+&wkup_pmx2 {
+	mcu_i2c0_pins_default: mcu-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x0a0, PIN_INPUT, 0) /* (G24) MCU_I2C0_SCL */
+			J721S2_WKUP_IOPAD(0x0a4, PIN_INPUT, 0) /* (J25) MCU_I2C0_SDA */
+		>;
+	};
+};
+
 &cbass_main {
 	bootph-all;
 };
 
-&watchdog1 {
-	status = "disabled";
+&mcu_i2c0 {
+	status = "okay";
 };
 
 &mcu_uart0 {
 	bootph-all;
 };
+
+&watchdog1 {
+	status = "disabled";
+};
-- 
2.43.0

