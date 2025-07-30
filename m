Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD7AC83F26
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 15:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1A8982BA1;
	Wed, 30 Jul 2025 17:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="KoY6cMpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B502581E06; Wed, 30 Jul 2025 17:42:30 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7068B801BE
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 17:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgOjP7uoK03jyO3EzLd3YGVZE8KHZCStLCpgqLp0/n+Ab2FKWqAoR2ov8yDz95i1WorbM89Et5wkBMo+imODhZWn0yRsjhy9h/UBKM0TQ0b4r0+9pi/u8mO1i93MOLSX5TpLuJXW10tjqoxO1wnCltRh80/ely7+wz12+fzjcTMBJpvvecLHuMBp+V95aVUQBlfNfNlcSyGoWgaKHhPwyfHIC6A4IX8txSijTTJDwhZHL15ebYs4TYJOH71H2I3hodaxj3YYD6ZhDU0uFDF6WOEQf9Dua3/2RG0BGl2iPq1ONs38xHVmSRPcE9r3+Vd1TU4GFgQ+6hWvbdEURyvrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifY91rNTvJS/qdej0O+D5u3T78STI2C82JFgdXuONA8=;
 b=MmB2dgsXT30+d6+PvOEyrVyK2JNXb2UOg/2RuHqAXsNonNnY9icFmUIx0oUvrlhY4AcMhAYR24nPvDgZrlj29LQ9jWDXEqQtDqkPCPh//q3VoRJ1tZC3AO3wml1crSxyzB/XiRZ/TKwXllP/tuMUsEKvuAon8XomvCesmPV9Mk3dfGFXAGmM9ng7ZrC9uoNSseEUf4RjECGuAIbzYFvkrD5HhQYX0aQQCU4q/a1CWgHnDZJ3+n1V4Ibi1RVY2WVYKefHuG21xlEvOuJUT8hFylYKLsXQqqtkT4PwwvUJM0PcBGoKazq1L7Tqjqeevif0dxRmpSkkn/7hKCIvEs8rCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifY91rNTvJS/qdej0O+D5u3T78STI2C82JFgdXuONA8=;
 b=KoY6cMpkn8ea1h1iz5boN6e5UF+HB/bmLLrbMHieW8lq5Q0rOmkTMm7qFzWvuPEnhtqSTO12GDRB+xMB51JK9PQpJIGrmDfqjO/i+Kyohkjo4vqB2bNyKuYmprbxH3q2oCNFYcHqSdq4+xShjtKMQIaECqJWW6y78jYeiqHkgmB12GxZj0h5epeGiHxXy+jUHo05gCsoni8b2TBztFclB6QudAxTTqI09Bxv3+bjQ0BY3sm+MqhZZh5uqvhG9FJBKijxZFBzRdsiPAHipSK40OlFF/4UtPT5BZkSjfkj18DcBkMru3zglpJqjbv0YfurW02nR41GQmwlTWP1oz3tVg==
Received: from DU2P250CA0015.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::20)
 by AS8P195MB1143.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 15:42:25 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::fc) by DU2P250CA0015.outlook.office365.com
 (2603:10a6:10:231::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 15:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 15:42:25 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 30 Jul
 2025 17:42:24 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 30 Jul
 2025 17:42:24 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <ggiordano@phytec.com>, <bb@ti.com>, <d.schultz@phytec.de>,
 <nmorrisson@phytec.com>, <joe.hershberger@ni.com>
Subject: [PATCH 1/7] arch: arm: dts: k3-am625-phyboard-lyra: Disable unused
 watchdogs in U-Boot
Date: Wed, 30 Jul 2025 17:42:11 +0200
Message-ID: <20250730154217.1116751-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|AS8P195MB1143:EE_
X-MS-Office365-Filtering-Correlation-Id: 06723e28-d5bc-45c4-5916-08ddcf7faeb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RxrrHEaDeGMiD+6tJFZPPrRpVGmVbTroM0aqRpcpf0x+Y8QaoVZqpRUbvwnO?=
 =?us-ascii?Q?xXqWD1bKxyl0qyir8ylWtnsaTw0YHAwtVI+uc0WSjVXvjuMAsvtpDoc9G6JJ?=
 =?us-ascii?Q?8MWNKFIHNnzObrbni5+s8Uy3UFPdjMO1z+i3JrNtMjL2Z6AOxP1kXJaVQ+F8?=
 =?us-ascii?Q?FFQOWgFP7aCodZczoVtUB89XTgr++5Er5vUL6vVt2PnfHz9+o8c81i4619xL?=
 =?us-ascii?Q?qtV7uFpUyn/9NJXHf8KGYctiE8j4nN7q0cq4m5swHa174uM0MUK5Ev73BG3u?=
 =?us-ascii?Q?gryzpDTwkrFe/G1H8JT3aMwlUw6k0U5/Uqjyz9Fzxsr6wxhIpz9VW5QV85+V?=
 =?us-ascii?Q?umOK2RdsNQL51Jig/hIYSv3i/0dtF7dkn4b8vK9c+6Cqws5FMTaZXYoaYPoc?=
 =?us-ascii?Q?coAdWuLIr1slxNeKCaKtlVSJXUgRkzq0LO1CJWqCzFg8tIQbAfKNx27fgGbP?=
 =?us-ascii?Q?rWQgr9uoQK5m0J4A5QlZJKpa+gjNJpYc9Y72vGrGzLEy6lFvXSYHbeuf85Jr?=
 =?us-ascii?Q?kgkfCYSkcY7lLTxKcDbMknE6Mx9QsEvTCezh63q3XXbnfDxsFyQTAqHmXwCh?=
 =?us-ascii?Q?N2+K4+yZUqn9o/H5PAVLwrbEs1gKlQr7BaMQCc0SUCr1GUeGYpodZAekUZvV?=
 =?us-ascii?Q?riFxuqkZAh0TyaEFVUhJAKNAlAt0IqFAxznhvXClHIa0pgev98A4n798GTnR?=
 =?us-ascii?Q?BTxoDmH3yXxCnvlaiJhSlCVzDj3ZtMyvxmTHY7/9T3yyiiZ3wPsokcJfn7Lq?=
 =?us-ascii?Q?M9eWgVfXrvk2LAfWx6FGXeUVmSWu46kZVASnI74SnB+aH9z5Rhjcgk9IQWSb?=
 =?us-ascii?Q?EDzye15Zsh32xFM3EDSGHD4XvURJtH6iugeLvcV9FROWpD3zXBR2BRbv4T3O?=
 =?us-ascii?Q?UGpFp1p2dWrNfhFjMsM7iryfZf12aVwF9vdH5+6X46z/YAeL7hv1D5OjsDDU?=
 =?us-ascii?Q?2Upf7jceA1TmZaVPaL/WiaopyajuSRlVm8ARHUdpnRX++GtTIOhBlLnfN9gG?=
 =?us-ascii?Q?V6Tw6dxaIn1YCmSpr7amCKbBAJ8/mSJxGeODaFb+B6cacMqWHPHPSvtqFTRf?=
 =?us-ascii?Q?eUuggpAAtpxre9avMP27sZ5fJ51tLSx8GkFZYow+CDwVsphfsFvqVTmZGya6?=
 =?us-ascii?Q?BuppGJi5phECTc2Ytx3JXNxixQoO92Vyn/KOxoJVK9CL+02gpWIOJp8TKmMG?=
 =?us-ascii?Q?jQ6oL8PA/K7bGCF/Kj58sUDzj/zwtExIxISfQ8EBonQlhOtCBRB3SYxfogc6?=
 =?us-ascii?Q?kBmFsXwkDLQVvAHjTltd910ksZ6uzxRhLRK4A1PORB4NHSKq48yl5SJFgffQ?=
 =?us-ascii?Q?9K4WS0SGQIdcK6kmY4gEprhlHH1oZNFvK/aEAt5fOIKnEvlX+oMDfq4gu+gX?=
 =?us-ascii?Q?XMsYqbFSE4Zc9ZEaw6CpoolhnJk+yNI5gWSa5fZd7iRf/N7MgrN9UqfQedUv?=
 =?us-ascii?Q?vf6HXTGRmXlpi5a+wwkhQ4Qn/zcZcUlcY8EqRFnHveecxE9wNr8IbCI0J26A?=
 =?us-ascii?Q?K0NllF4n69mdEsHJQCZuR+Q4Au6An+JEoIdZ?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:42:25.4549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06723e28-d5bc-45c4-5916-08ddcf7faeb3
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1143
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
 .../dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
index ee273563e83..3a1a8b06dc6 100644
--- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
@@ -95,6 +95,22 @@
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
+&main_rti15 {
+	status = "disabled";
+};
+
 &main_uart0 {
 	bootph-all;
 };
-- 
2.48.1

