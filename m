Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EB6FD9E29
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 01:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E639283AA9;
	Fri, 27 Feb 2026 02:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="AwrvVTHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5491F83642; Fri, 27 Feb 2026 02:42:36 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3546C83642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 02:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Haller@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Med+vm4gWZ8xgG35cDMW1gBMrguhWIymiGeRlZXbDwlFqjBf+ftsLw9e8p00lwIcJOfaGBPb89RQS8hsrqMmtDETNRUesNqIIWOl59cw2Cc06od1EptFkKqfVf9lHk+Y0c2E7/U5KBpJh1hIMuUYBB6batea7XMjvz69nawy1sdwyoW/goYdhFAUqyaYif3MHntGZWf3EXkdWBgGgVDMPq9p2Nye9e7alVlh1xTjUeIgZ6Ww6wyYow/lofPmCoMFTge4iYeg3zWqS7tD1tgjRmLWY6qo1ypzQOSDY7u0dhtDCNoWDImPZb5kCVz0Jtb4VOUYutc0xRay3GCU78xz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qph3IHWZgjXlIL5Cq6bZuHbavAD/SAEi+tWigpxItKc=;
 b=b/tBWXT9LExhS4EWKr4L6fC9DVo8+wSUh+44OlDidNILAzLF5h8GiKa+Iv+LtDZTc6BSJRERu7zr5f3XNYCJS0lzgjx5v33q223ksg9zk5yEW7AHmDAfc8q6rBd5h9XdVZ4wmqSxbGBxncPD1T0GvcY1ZVMgN5ew8jJPn7vzAz0aokjuN+JBc0jJgs/NB8ij6j7pbTLNHx2YXH5tfTbogcjjeu3J/49nhB7/1GSvndW3YskJLqI4Gj5/Fa1zq4vOMDRPwkKpzr6WY+jk/SOKycmSEmLTTA4KzuXDAgrWEw7J5y53s+K1G+u4xcm6JjMDnT6idOqeMgTIwjQSK6c0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qph3IHWZgjXlIL5Cq6bZuHbavAD/SAEi+tWigpxItKc=;
 b=AwrvVTHnRQgtmMQ5TFva88ZuCesA8vllcUlBNUx9nZPgDJgwDOVjNAZUHWgVr3bmth33LrdElfC+9Ia0jpH27zLarr4yKtss1jn5HnE84/VXQzB+U5N9MlIbgigRjNRt2I0aD5yFqa5WcfHif922kiwLZBuzmPpHpQG18DfJsvLdwE3OI3QvBh+BZZ/iwjWKGWolyuXLzPOT1SnqQeD9z40THeJQY45UQ7C1nxDh5Xl6V80c8QHokqL6ov/xASXC6ny64dsUBoWGmKdCgWv7v2iI/OX1sYXeD3fg3VJ61Rerc/UmGY3+AT5zMRlt2Kmu6PLyMXKBUjTKGoqr15utLA==
Received: from AS4P192CA0043.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::9)
 by VI2P195MB3053.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:42:31 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:20b:658:cafe::70) by AS4P192CA0043.outlook.office365.com
 (2603:10a6:20b:658::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 01:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 01:42:30 +0000
Received: from lws-haller-privat.attlocal.net (172.25.39.212) by
 Postix.phytec.de (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 27 Feb
 2026 02:42:29 +0100
From: Dominik Haller <d.haller@phytec.de>
To: Dominik Haller <d.haller@phytec.de>, Tom Rini <trini@konsulko.com>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>
Subject: [PATCH 1/2] arm: dts: k3-am68-r5-phycore-som: Add PMIC ESM node
Date: Thu, 26 Feb 2026 17:41:59 -0800
Message-ID: <20260227014202.332157-1-d.haller@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.212]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AF:EE_|VI2P195MB3053:EE_
X-MS-Office365-Filtering-Correlation-Id: 02045eae-3654-4380-cae9-08de75a178b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: Hfe2SApROaIGDCfdFaAHJX2be50zZl2uczS45djMYl6n04dl5dAAtoFfLIliBfbQw0onxLn5YfIUbDuaDMO/t9ZKtFXhL36wKGwVLS7QFlmOBuWFJWtBVotPM7DVGeDrlxmNIJrJ4G6Ik/55t3MqmYiSq3952jxisrP7d0LWz7IiGf7r3AF/zrLXN+91kL2Z8Lp/nY6Upu+Nareq/F2KWuml6JDqqEqTzFNQfx6HQ8Bp++QNrz6TDKA3Wm7hzOeaY02mHEnTWh5EzCm6U3QVhZaG88mcemGRAKxAAH9UcmMxKwaoIsNgUiILsnK77PV+lXT4SSQdutzGhbl+isWUe1+db3UxBnKgdUvH2PQ4i3/SIQtgfsg+hPKhI8lQxsF9xmB6l4uuXnRtI1ZL+sJpCuxF5UnPmfjror9/4E6Mod5QsWiNEmvvPud8S2ldHDnUSnZkDCOzvlS+4SM829kHBQLytXR9Y1tiAxc753AgqA3mQQvv9Rxs9re7MzYIZ7tUJdCDmMuSkKgjk1hJgy+OasgVaGVkcsnfesxVWcs+jRyjSnebRwyBonhbx4emDwgrVE8HuB9w57Ls0afFKzy1kKxRQPXUud7OWRCCsXZtQNVUmsKqLhi/ZUR7MI4X9zRDsFLsmmc9CHlxcuzeSY9KOrXXXo4NL7UEyFtfSiUsBkFuiBCBTvfMNWJKy0ko1jFopH/kQI+mpR5nVAFrI4+jtc6Fv8zRFsfyt753GxbeR5FjShNmHVlAKVjW/3DsioS2RXjLqwVH1FrIdkMDiSUszEN2iktvGfxSHiG7mEYCm+yUvdNDdjV0XKqDeTJrqDTIFtg1NZmzplPAQ+8gZEL9Ww==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rlDtXrHBV+Oavu/dR4fGu+s2+4D7HUE/pmp8NFXexFhmAdVitHETgBb61Y6zQGBixTUHZ7ymIO/Q0465OC40U7wuHTsfnA7RWGDL9BZ05dzXyoOsYw3jFfdFRI035UgricB0Y0sW1VEdcFUMo8TtkMjkcVehm5Zj178/svSJ4YZd5yUk1JQd8ktDvHBPrp5cPhfYGkmWtiAD0Jg/bTf32PO/AMgsx6Hwa5HxFYjQHSVBVBj6xyiwr6NQZadzN3YS/RR9lh/z2qcCJ54qkEOtLbkl/rs8II7oatlD+RM1fHAz7w3ZW//UWCrdnbcfle9fXYMSrt/KItOsshOfF5gW0WbtDkoOMYkhcZqtlfiGiNkGEAUyk+jyOu67giz2qX7aOWuRmg6UqeRsjwfkhti50K5zLB/XizXtY+cbzRIACSurH6kdh1yj+Fg89ee5u7yL
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:42:30.8324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02045eae-3654-4380-cae9-08de75a178b8
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P195MB3053
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

Add the PMIC ESM node which is responsible for triggering the PMIC
reset.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
---
 arch/arm/dts/k3-am68-r5-phycore-som-4gb.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/k3-am68-r5-phycore-som-4gb.dts b/arch/arm/dts/k3-am68-r5-phycore-som-4gb.dts
index a2674a3e1f8a..c641a2b59d69 100644
--- a/arch/arm/dts/k3-am68-r5-phycore-som-4gb.dts
+++ b/arch/arm/dts/k3-am68-r5-phycore-som-4gb.dts
@@ -14,6 +14,15 @@
 #include "k3-am68-phyboard-izar-u-boot.dtsi"
 #include "k3-j721s2-r5.dtsi"
 
+&pmic {
+	bootph-pre-ram;
+
+	esm: esm {
+		compatible = "ti,tps659413-esm";
+		bootph-pre-ram;
+	};
+};
+
 &wkup_vtm0 {
 	bootph-pre-ram;
 	vdd-supply-2 = <&vdd_cpu_avs>;
-- 
2.43.0

