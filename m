Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5FFC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 15:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD61483045;
	Wed, 30 Jul 2025 17:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="T8mOaxVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C07E9805D7; Wed, 30 Jul 2025 17:42:32 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C47ED801BE
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 17:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGT7JYfaEceiMxfoSVZ/YjC10kUqqoZ384tXuw094/zgOiyJmBfXb1L70lYTQgbgHGKBEs4QnJ5NnlGtQ0a/umuXiop3sFj3EZ1mq5E/MzDxJghAiY2LpdkBk2THSePNbotGbfaWMHcQutyyIzBZV1RVAMc2M9jsw8wZAhQfNixSofU38AWw/1FIQRWkpORHbcKqvtF9+tzzRO4vGcZY6jRsuUmEMOUB9qjZX2xKtfH2FKUydcXDdOIPTkCXrFnNH5pWmhJC3ZaI71Goq/Srq9iKTiQWQj88zIle+KQUBnyFwymrDAXp+cGXwHbg5AKWYsH0IUJ2yKHCTC5C/F6BYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=az92odhuhMDM2A/VKStmLSImbFkuLtCBx3Qz+Y5HD8I=;
 b=dJmDTk2Jq/0XmOaQGNbRBA3VDFjBoFM6sKW2wCtLKVbq46QOlSmspPximGGoIlujtn9UnmZBujVw9HqfvO+wv1IEjeJ6E16fbA4ZQBzos0QArtdm8J68CnJ97kwfHwJ1D/3a6Sre8zXr/zgPAOU2mLuGa0PtKAIo2Fv+dGmwPTL/TJu2ie5Gm2VVDcQS+CboQIB6axmu8b3+eb+HWHq55XqfxXNG2m82qQc15V/qlC1oSvySKVcGXlo25ftDZ0fvxmT4l04CqxHJcv8bd+o9D/w0CL4npl5wo2xLfRLG7PKObTRkcAh01gZ3QdZH44w3+O02dgQUPJhjwN1h5114iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az92odhuhMDM2A/VKStmLSImbFkuLtCBx3Qz+Y5HD8I=;
 b=T8mOaxVnmiaWpWS4vy2zTj7F9ZOxyWyhMn+T2eFgIvgwHLghokHQrnR3++S+W+jivOxDFUBBJ4b3KnfupQw2/iES/RkhFDUBNOmWxT00Rs2jF3DmxtmRx3BsyM0F3rBqXgbcyAmkpXn+2abgJhvpFRHBaBcmaiPg2VhrGYxXSdfeCs3EpeMwuHUF8rejL7V09NeyhvrzyB6EFxMV5L7qhqR45273qaq1+3ZjHjG4e2o/LBENMMQmZOOiP+AjbcjZVlVR57Jce24uy9xcQ9Z6usuAL0ZTJLHAJWgXFqQMAUEyN+z6VwNc7JxikwYUpxUAyQuUyIAfj1jiazBQNA+n9w==
Received: from DU2P250CA0018.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::23)
 by VI1P195MB0622.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 15:42:26 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::fd) by DU2P250CA0018.outlook.office365.com
 (2603:10a6:10:231::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 15:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 15:42:26 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 30 Jul
 2025 17:42:25 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 30 Jul
 2025 17:42:24 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <ggiordano@phytec.com>, <bb@ti.com>, <d.schultz@phytec.de>,
 <nmorrisson@phytec.com>, <joe.hershberger@ni.com>
Subject: [PATCH 2/7] arch: arm: dts: k3-am62a7-phyboard-lyra: Disable unused
 watchdogs in U-Boot
Date: Wed, 30 Jul 2025 17:42:12 +0200
Message-ID: <20250730154217.1116751-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250730154217.1116751-1-w.egorov@phytec.de>
References: <20250730154217.1116751-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|VI1P195MB0622:EE_
X-MS-Office365-Filtering-Correlation-Id: dcabedb5-6ff7-48ea-adc8-08ddcf7faf19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a/+Pf/ZCRqjmCtyeoBjwJlh5BYs6p7snbwv+tQ2LWHUZhjdb6fxQhFtptssk?=
 =?us-ascii?Q?+INs8e6JgeBY3MpDBABkmdCzMxuqxaxjjmDHL88IbTD8UP54IacZJORzlbjC?=
 =?us-ascii?Q?GrSKd6WvZmUiE4rPq4fRyQYsnRavSUDlv2AIjQpENP/BZ23fdXlFxT7XbVwu?=
 =?us-ascii?Q?UjRXgF3K1vuh6K3gB+q57Kcw+adB4L3zb10jqcIDBXPVtHNDeZm62Z0sh6Z7?=
 =?us-ascii?Q?prOIlfVGHQHN3rBYBKNmWOEGgdi2QKvi7zWq06N25K97C0/CnAteZ3Aa9m+J?=
 =?us-ascii?Q?q3GjK4OIeNOEG93Emws8GyhoRuaI9QbaXyzvn0AinkUpjRcul2dPQTfF+EM3?=
 =?us-ascii?Q?49j0+U35gRqkIigc3Lf4VNIIyxkP5KKAAYV/mqojqlNTxQ8j76JR55LfJJRH?=
 =?us-ascii?Q?F0Do9fsjAyjf/zDua/1/a/U4tfzIFznCV5u3wbjQwnbHyhUR9v4LBCCIMvEy?=
 =?us-ascii?Q?h9V64jmkcYxHX29PHBFjB3r5kTOhfANv8eS3Szyyx3qEsQfTGKH/p/K0TAex?=
 =?us-ascii?Q?8F7U21SKkao/c7fohYpcpgxBbBuK7aKDqUHV2Ay1w2yf8Gu3wI7Qo33flfcL?=
 =?us-ascii?Q?qznBo0ZfYX/4JNwT/dvb8+0D9lEE/7t/+r6o3Xwrr86vZTeGl1jCgxBVoP44?=
 =?us-ascii?Q?B2bk0UI91PAadzcXVac71M71vm3kG8sCG5RaflsgGV3xNCT1OlPGuOxS//hN?=
 =?us-ascii?Q?bH1K357++YZkdRONXCQmI5CY1uZnNU1mlyEqfKCyf9xfBOzjsuT92UH5+wTC?=
 =?us-ascii?Q?qTEYVa+u1kNFyHou42LR35G1NaCEdijCVux4SKICUb3t83dCJ3Si8xsPGtqt?=
 =?us-ascii?Q?uCd5RVrUNjfWyAhhgm4e2U1d3i3soQWCzHt7brUR7vBvReFbOiF5IposRXPw?=
 =?us-ascii?Q?j/TCI5ixvHidN67PyvgXROSlV0bZOqEw68SOgbKn1pP4pT8s/rlT1uAVpf4L?=
 =?us-ascii?Q?4mX/esyA8qLfZcCWR1DNgEpXvwCSZurrd71SYQ9PvL09a73EzzIwz3jEIzfq?=
 =?us-ascii?Q?lqPT5lsyBmdoAtgVAEAVO7KoZB0zIjetQFrvVE2kqD8x2mKkCuKqAHfKZo7X?=
 =?us-ascii?Q?UrqwctyL+JKFmt+S+gGFKPPw9/aI6vhGaY/XPyKLUhrUm57w+gmPH6y7T5Zb?=
 =?us-ascii?Q?1TLXeL7tV5AkVvDHsZgDwZlElMk5TVP/bLlMh/4Cnb1p0nro4dIjvkbnAwRK?=
 =?us-ascii?Q?BaNapPRz8uZI+cFxgdd46zYsHb37nywVUBPIZ4ae43yCBPVns+RLpqypGWKx?=
 =?us-ascii?Q?UyDKSgw7bCLKuptVThGBK2Wp0z3L4f7damCGDEKm8B2oua8+UAehYiVT5tHi?=
 =?us-ascii?Q?Gy/4J9zchP/L6WV1LgtzA3SIJer5NZNnszJcDx+87Xua+iNcQsF8If9A6CSt?=
 =?us-ascii?Q?vT2tuS2vA2yIKLhQtkZere3bRgC6zuciS4kKIAe+cUtVNMYxxX/OlrGPj7kb?=
 =?us-ascii?Q?wD7zQRPVx7i2+ikSS6aGrsxr9KN2WHo0YvbIOml/33wiGmh9xeS/ZQf0hbx/?=
 =?us-ascii?Q?TRAMqyHj2mI2MoFDQC1/aBPGVlgztvSdBUkq?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:42:26.1252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcabedb5-6ff7-48ea-adc8-08ddcf7faf19
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0622
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

The watchdog driver probes all available watchdog devices.
This causes SMP boot errors when bringing up secondary CPUs.
In our setup, only a single watchdog is needed to monitor the
boot process until userspace or the OS takes over. Disable all
unnecessary watchdog devices in U-Boot to avoid conflicts
during CPU bring-up.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 .../dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
index 73255a18e9b..8afd844460a 100644
--- a/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
@@ -156,6 +156,22 @@
 	bootph-all;
 };
 
+&main_rti1 {
+	status = "disabled";
+};
+
+&main_rti2 {
+	status = "disabled";
+};
+
+&main_rti3 {
+	status = "disabled";
+};
+
+&main_rti4 {
+	status = "disabled";
+};
+
 &main_uart0 {
 	bootph-all;
 };
-- 
2.48.1

