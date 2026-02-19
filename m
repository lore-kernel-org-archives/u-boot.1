Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53BBE9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 10:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1316883A47;
	Thu, 19 Feb 2026 11:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VWJgtCkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70A1383AA9; Thu, 19 Feb 2026 11:27:44 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6429083936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 11:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAVtkIZiY57RNlzk7+NilfazF9hMDyKgmUxcmYHeO/z61nX+0tfiQbpObwzaD/PFRVQO2hao20upfT/Z9VpjY6tGU4M0BoqfQ4zMdJIaSkEc40Qu+HLtY5SLtmmUOzlpQNWGqA/SNod3hDJFKr98MeZZ6Y/fSBTlxzNyNE6GDYXJ548siV/gGvF0J51laJyiwxZejuNitYqBeQ5HvOzhQ2qBC6jmo0eTPj9zQ/HgfaWOGaEU/qS70/Ccb6+A7p/hfoLOR2qOYIOMZavY8YrjfjfumeUDWxCQTLfLMVIoQe2dGt6xYUpSygn0z7RrvweHHmdyNuArkRo+9gm6EGsrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gksb83PRgGvh4uuKeHZEL8JjoWydyfC76TjdBiBQg5o=;
 b=Cx5LSRG9vvn3zGhzklGLpJxBWZUKAEgWSeYSc5zpqe1NfIXbwk+9wY32CLaO5s1BqQycpeApU431cKNIg9u9ze1iv+Agxmybb8wOtwLkZneBuw70q06iICBZPvD/tLsHFnanBGPP4Am7P+tnAfnvcT2hrgspxMDyDP4y8u88qP+1VfI5IrOq9MfIfezxTESQbSU4LvlMM2pNxY7e31UNmGtBk0RRTg/zx9VoGC4IA1qkDKZCkNvJ99Lfm60TJPS1z2OCT+hRbsuEpY5UAd0Jk1oD3Jo2gTKBu+4ddf+1Ho0mXy7iiztmQDCVdeb8Pdvu7x02cV5WG9mXElxH4MCcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gksb83PRgGvh4uuKeHZEL8JjoWydyfC76TjdBiBQg5o=;
 b=VWJgtCkItaXEahn/iG/ekaamwVyyL5iVF8z06mO+TTXCrQwt5BYH7qf8PD+GKmjGD96otayhSCe7AhkZKQltqTvhOs1oZJhAKYxxPdwfwI7kfLs+l5/SjQoRFwmNjNYWGoRun8VedD6+xgfTbrvjde6Oo/xBU6NdNNQUV/fo1S+r5Ivm2sKEH6RogxDQxKY/FTAe4xsNAEPvUCZnu5sekUVokGlWFZfUccJJ1NYbDJURvGd+o9NfI9p9OlHiRppVVI517dtRd/wK28zNLxc0an4k/JKuWCd5lLHy2gFa5FbRH4VwsEsBntqIdMYlmQSq+0zoMLtccR/oXrXgNYmRKQ==
Received: from DU2P250CA0024.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::29)
 by PAVP195MB2210.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:2fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 10:27:39 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::e4) by DU2P250CA0024.outlook.office365.com
 (2603:10a6:10:231::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 10:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 10:27:39 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 19 Feb
 2026 11:27:38 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <anshuld@ti.com>, <m-chawdhry@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH] arch: arm: dts: k3-r5: Drop a53_0 clock overrides in board
 files
Date: Thu, 19 Feb 2026 11:27:20 +0100
Message-ID: <20260219102721.102254-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009527:EE_|PAVP195MB2210:EE_
X-MS-Office365-Filtering-Correlation-Id: afdb73a4-b91f-4a37-d8fa-08de6fa18202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X65pL6ITklHsfd8APcJt5M1vDaZsgjoukDNUaRmG4lj7ZYL0TpdcMYVAjvpN?=
 =?us-ascii?Q?TObO0Ma2S++9xRley5U8xitLXStYQx9iEDEfFAYWrbTgqAjcIW8Aix7Wm8+E?=
 =?us-ascii?Q?pff9m0ZrL6D5rkVK0Ny25ftuSbZoKfSkI0gQb8EpUFW4KxksFqLG+cJ0U5/o?=
 =?us-ascii?Q?87B3JhX6lVHDj0cftky2haaXvFHL/75TxEcNnhD410ZBSD2AY4tun0udT2Co?=
 =?us-ascii?Q?Rb85TDCVc7hje/JiXIPI4HNh5rmYL/3l6JFZ111jQx0OSNtTW4S+AqGlTuv3?=
 =?us-ascii?Q?s5pw0uXPIumbbKEfAbWGstoBAw+iKACKPmcmEFU0bOeF4Q+tLCCuwG6OZY3G?=
 =?us-ascii?Q?is0E3Onjfzlufp/usxXclELJbUNNy5oY4E6GDFnc1gW1sPrfV4ILLBYDPZ7U?=
 =?us-ascii?Q?rd2RakRtRtoEd1YQGN7zGVDHaySc26f90VGT2Ihh3rmMWjTnc7Cdc/2eqfH8?=
 =?us-ascii?Q?9NVyHI9giiGz7wH2fL2HwNnBAfR5rIhm3jwc9UcAsq7l+ThisQSf5fP2eAI1?=
 =?us-ascii?Q?t8yPeKoUrbRtAHo2Sy15wuKOjHsXiDXHJHoHjGnV4T1pIaEHBhgaOPdaRNS1?=
 =?us-ascii?Q?0FEx3U2wkMctRC2SXcr1fZddQujTiEN1xPI/5Pv5y6fdAL47IUDOWdhiGhRZ?=
 =?us-ascii?Q?yzxQtHg9PziOxhh35pF1RhBJ4q00+leXVFXQZIBNNHIXwMN/3kGJkzO1GEMZ?=
 =?us-ascii?Q?vVA4Txgjr/dJMLDcpeuUi0gwTC9qb0zDGL1dZXatRmudWiNLBokzF94Eph+g?=
 =?us-ascii?Q?PkbVLsXwiAhICTmS0W6nIQClTSuLPtMPcsM9RTHcqs2UXVWdhhhzhhtKZ9Nh?=
 =?us-ascii?Q?9U/KLc0Umss9bEd/P15n3lV3WN9PVqVg1vqZZQxW5h3FGBD7rRs6WaJTb1rc?=
 =?us-ascii?Q?nwPHyg81y+Nie+BxXCsl+oA9L0a+EBZloRLOtg0c7wUV7P58+6rm0WIBYyTO?=
 =?us-ascii?Q?lTiHSSRY/V6GwbtbopMgr/mCUsDCCQDIkcsTgqBlP2qom22kGnI8Mr9jXg9C?=
 =?us-ascii?Q?tO3DImp+VFkSGcRTfV5hcUi9HhnDofXHqt3ZYIpJhyri/rSEwvIKRCDdjRYi?=
 =?us-ascii?Q?MlcVVj2LXxqPAkm3Irr9xT45cilXuQij3McD/MQZDmoDLDvpT6AX5Urjx7nt?=
 =?us-ascii?Q?8I7JvheYZZcZB8crAjbwdXxH8FfU0LJ5LEzUdfMYPOPG2sBBIY0UcHtZeK64?=
 =?us-ascii?Q?2Pg+fLLjxIOFwfoKYqYTH07mYdiKNwjL8+BcLxxKe15rb1gdSKGa5r0ExCJH?=
 =?us-ascii?Q?e5oVUCpVK801iIyPYaLG+Hud0XU4QAmXFNe/lnAoOeXIF6FuqdHIaa/CUDG9?=
 =?us-ascii?Q?a10LIzY5V1CVPY2Wgoi80adsW8QwEUmBU4opDuB4qWwGWqYme0yMOZ1glV0z?=
 =?us-ascii?Q?E8RGHAGgO5rJYdzPJoItq3G+OXIGlZbByDLS2qHLlWBq5WVy3dBhJPOmeHQn?=
 =?us-ascii?Q?Ta9DC5/2fG7eaJ4pdJbZJE5ZHZ/JpDnrDMJsabFaVh9OcQznSFBBg7ZCMlKE?=
 =?us-ascii?Q?F9aYV7+VJDpAMFjURNVYa41enMyR4vYp25OIWXmK4OL9Mt2Nks47lAkxnTni?=
 =?us-ascii?Q?Yh6cpIc3ZtyJlwLNEct+bH5MlWvsdIluToieABBOvrtF0WGfGNwdEaUdmqNW?=
 =?us-ascii?Q?U8zJvmOn7+jmA3YBQSH4wH9lf3oCd62hd1+PTXVzyHl3vn1z8IETTGNGjyvk?=
 =?us-ascii?Q?SILI/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cGoecYAjWNtSpyJ/aZ67/46y9hpDDLHllA3DUm8yl3cvE10bjA1ugEb/I/CvBqauYkc0J6d9NP04xikrzrjcun+UwqdtyLH7h6g+SncS/miXRMEgQfXSi5/QnfLu6QyRpcw+oYFbmak+FAt/28IH6iuYMMWj2A34YJAT6uyIqfkG1rlPgeHyOVfZBwqqThQfgCu2IPV/GA07ixmJoIdtKICbORHiz5HXXyQ1HfdPJNn2Wuxp8daMJjHLDJjOcY5/O/qkaB7EJMUpKvuSQCSJmywEHwiRvFoQRa7LZHSoMPAP+pvdDpDlF23Z+UWKl06T3zcZZZUAH5wi93N3pCiT2e7NaPCF/xe4GQea38BtCJxeEgNFnq39jqTxk++/B6qxyYJBwlpJD2J9HVdpDXth/ZU76QnvN3UbFxkBOEJBVP9LIeU3q/V8hvRuT8M6xHCf
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 10:27:39.4149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afdb73a4-b91f-4a37-d8fa-08de6fa18202
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP195MB2210
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

The a53_0 clock properties are already set correctly in their
common k3-<soc>-r5.dtsi includes. Stop overriding them in
the r5 board device trees.

Fixes the following error message:
  Failed to set clock rates for '/a53@0': -61

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts  | 5 -----
 arch/arm/dts/k3-am625-verdin-r5.dts           | 1 -
 arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts | 5 -----
 arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts  | 5 -----
 4 files changed, 16 deletions(-)

diff --git a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
index 46b621242b5..ac6f1022a55 100644
--- a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
+++ b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
@@ -21,11 +21,6 @@
 	};
 };
 
-&a53_0 {
-	clock-names = "gtc";
-	clocks = <&k3_clks 61 0>;
-};
-
 &main_pktdma {
 	ti,sci = <&dm_tifs>;
 };
diff --git a/arch/arm/dts/k3-am625-verdin-r5.dts b/arch/arm/dts/k3-am625-verdin-r5.dts
index dfd960aaf3c..971bb752052 100644
--- a/arch/arm/dts/k3-am625-verdin-r5.dts
+++ b/arch/arm/dts/k3-am625-verdin-r5.dts
@@ -24,7 +24,6 @@
 };
 
 &a53_0 {
-	clocks = <&k3_clks 61 0>;
 	/*
 	 * FIXME: Currently only the SPL running on the R5 has a clock
 	 * driver. As a workaround therefore move the assigned-clock
diff --git a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
index b54cd9d48a4..c949485017e 100644
--- a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
+++ b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
@@ -22,11 +22,6 @@
 	};
 };
 
-&a53_0 {
-	clocks = <&k3_clks 61 0>;
-	clock-names = "gtc";
-};
-
 &cbass_main {
 	bootph-pre-ram;
 	sa3_secproxy: secproxy@44880000 {
diff --git a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
index 4b7a63db4ce..6f3a2628353 100644
--- a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
+++ b/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
@@ -21,8 +21,3 @@
 		ethernet0 = &cpsw3g;
 	};
 };
-
-&a53_0 {
-	clock-names = "gtc";
-	clocks = <&k3_clks 61 0>;
-};
-- 
2.48.1

