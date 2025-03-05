Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3237C282D3
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 05:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C65981430;
	Wed,  5 Mar 2025 05:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="rRkDjIBm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D784D8141E; Wed,  5 Mar 2025 05:58:58 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::712])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC25880F56
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8O/wEj06h9O3fKUyQQm//gXLCf+X1hO8a9gjp975DGHJH3sM87uo6pBHNyzVVQKSwNZeosQs99UlKx7DUeZ56AGGUQAznoB0MUGYfRsdbZ8PyZ7ur2N2ANvCAB9VYFraFwfWy+qLLYN3MCHP7OpvMGyzXQ8hX7numK08idbBIF4Cg2vDS57LHqeXQsVqKkE+WfoLWyYpLv7oZyOQqjtmoP5SbrcuDxzqJXDAaPMuIoUwVyXsiPMALfAK/IXu9jvFZ9t8QHjOSBh4+2x6aSPaFEkBtwcEoNe+rUCyM0DYpuSgRRLGDC23GjtqYehEU3+xh6cXylqZ+w2I1I072X2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21+yRANpo4+DZcB/YqmOMgALCuN8poJ22l+RCpneoEk=;
 b=cFvC0mLalQXW+FNYYek8lJJqH+dphfVw0JyHtTcUFNJ314pIlKDFYI1HBfSZhR0zkEj2FhpBkaN4UwBIJtXqGN7bMz9KPbpETJ/9/q7GordvTqNoTtkKtqHDyxOjJL9WKeZ+VSbAxyCw16OQQ6nHbIPOexEj1Xfep2mg0fI+t65S0PYPz88HBsVODoqDnpMdODVrStTROPOH9e2Hv3XXKn8OeTJ+UJtH5SoIgEuhKHfLyRbK8E7riIgZi9fenNReRAMzh4cYmHTNY4zlkVW5HyGEAQ7qK8O+Z8YPUTjLOfkSehoqDX0r4DIGva3FSIPSdA6AsKkiqd/y4QgkEeFjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21+yRANpo4+DZcB/YqmOMgALCuN8poJ22l+RCpneoEk=;
 b=rRkDjIBmlMBHk5uUiX8PIz96e8+YNRD2vwiznGlDHomoWLuUIh8TNVZ8sbjOIT556CUlnsXcyFP4UUxvjFLB9EbFfcnUiKS8hbsChXZ5gYYc74nda8zPi1YMwgZwo2JkAVsVT/iIuv5AgGtAXF1hD3izGsINCUUCD8iapdTaGIvPjsAOWkLQmy7+ik7dvdopXoFxM5K6Er/HFcAiSk+605GVWigJ7A9yLoRMKle0gAA48kMBoF1fMqQ7ZxGdh83lmg8EHOeDA2z+jBmie+d/6bSGNl9REgbtkTl6vn5L7ocM9/9G1uLS+pTZLthYQZloKo7sdJseC49npTma+RUOYw==
Received: from CWLP265CA0271.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::19)
 by VI0P195MB2626.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:251::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 04:58:52 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::b4) by CWLP265CA0271.outlook.office365.com
 (2603:10a6:401:5c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 04:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:58:52 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:48 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:48 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 08/13] arch: arm: dts: k3-am62a7-phyboard-lyra: Add missing
 boot phase tag
Date: Wed, 5 Mar 2025 05:58:33 +0100
Message-ID: <20250305045838.3614661-9-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305045838.3614661-1-w.egorov@phytec.de>
References: <20250305045838.3614661-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|VI0P195MB2626:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd2585d-6beb-4755-a467-08dd5ba26cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ARBzixhcxqqvJq0YvVGUIZitwn4Ok9UQltGCPj/2U9zMKwCNXVgbXk/b80BD?=
 =?us-ascii?Q?GbVOZtpfn91iETrKI7UmNYbOFP/nKINgUuQKJJjmRMqb6PoDxHYUz/pKcSSh?=
 =?us-ascii?Q?Z5nTuq/6zPE62+Ghxx5cSu7pjCwupVbIFIqvHlQlfMlZMUjx1GKwxxrWgSI5?=
 =?us-ascii?Q?saqj3JF/XhZkRyb77L6flTwe0ihs9vDuI8eW4S0racptU4NKjfWpm9i8J4ys?=
 =?us-ascii?Q?0MuLumzLqvzdiQvwSlhGeeMiNvetkQCjs1qeThPMGCb4zdgWuQU4QgmLSdgO?=
 =?us-ascii?Q?wIfLFN131sbcQpqmhD7QGo/Hzv3fQ4ITB7gdqpbQuznYmO9iYiVkbZ930MTo?=
 =?us-ascii?Q?IL97qHl6DQUK1OfmnAl+VDFv7yr4NTv0Z/7irPu+NB8TwbBwaFy7yGbLBzXC?=
 =?us-ascii?Q?yWckB2dTsKRIB8SlXno75kN6DlTGxMk8p8Cfump/UmuF0dSKJuTBxyQ8LC3k?=
 =?us-ascii?Q?FMv2PjXKqg23BHPOhF4vTkHzKbEvELVPa57Hi7Cq7HmjM+Q9YlcfR0bB7rAg?=
 =?us-ascii?Q?b/zp4prbSQLwOYo4OfTOTM/wHW82KrEc0HEeeEtbDQt+QTq4JaoqJv6NyKmt?=
 =?us-ascii?Q?W+SFmt6XDsNcEVZqnnJUg4bIxXKg3+eRbjWM47cOceokwvmjT9ep1AqE048g?=
 =?us-ascii?Q?Ndd2HiJ6F9QoBexHHCkU6pUiU34LQTsHfb2rBS4BhCSKJd1LlPiUXizh759u?=
 =?us-ascii?Q?4J5ZP8nkQkQ70o8m6HUK3GNg8M6BGH3diHYgwBvNKtd9FYA+U9FjV/c5r+YJ?=
 =?us-ascii?Q?ZphKdy7Q0X6NSjc2SxQTaDPLnjqtjYi4LlsArSeXHqDYG82ZH8x5HgtVFtM1?=
 =?us-ascii?Q?36WOsYv4IKTJBn3qG8qAv9N9j/iCwK64NyZBZfR19NoeFaOH0YH+xqKPKvdv?=
 =?us-ascii?Q?t0EzmS5M5AaSbRavm9VvQKPLZzpc4TQnggZ3BdlN48DBPXsbuAe06tarTPTm?=
 =?us-ascii?Q?Sve3wVdoTyh+X2HqPLijlXrO3wg4o6nWa7Dt/HObq89hmB2sas6CrDwKfQ39?=
 =?us-ascii?Q?ZP+aHtbWVgCYF5S4JNQMkMQM5hzyrUZ3+nFXjTnwv+3VxUrjqLwNn/bnkKmx?=
 =?us-ascii?Q?i9Cwq6r3ng6oRsmTCHeVUStmVBfan3hL9gGRNoRzGX2++gUbNK11D/aBIV0C?=
 =?us-ascii?Q?g+LAsq3Coe0ra/gEEPcizazI0jrAqY4U7sONw/zYwMaDuMi2M39AoDtyzS25?=
 =?us-ascii?Q?fHrKwYUB/4/XK7JinvgExi9NOnVAlfYgKB5T1OBFrrngv7UCpupJSYh/qYTH?=
 =?us-ascii?Q?DdGjYjZEPPMzy2jnWRLiddu72t5rWayI0MPB5w8Bz3Bs7ikn4YZC5z2VINIT?=
 =?us-ascii?Q?Ty2zNnzBgn8l0UVSBLloWybpzS85k0qljh8fDVcSKCiMPJXpasvIiSL1MQ5I?=
 =?us-ascii?Q?Db95VzKm7/gvsGiYrXUFMAbzCcABM5nrvvsLRb/Avh29CdCE5ZhYGlIc7NwP?=
 =?us-ascii?Q?ojgBdioGDEcWteoW/XLNEqwzgFJB2dfKAJUV5T5HUPlJOOELFF9G7niMhj1n?=
 =?us-ascii?Q?YfJsSaW65mQ2Fy8=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:58:52.3600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd2585d-6beb-4755-a467-08dd5ba26cc3
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2626
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

Add the bootph-all tag to usb0_phy_ctrl node to ensure it is
properly initialized during the boot process. This fixes the
following issue:

  dwc3-am62 dwc3-usb@f900000: unable to get ti,syscon-phy-pll-refclk regmap

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
index 41692c8f670..5a52f3d19c0 100644
--- a/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
@@ -239,6 +239,10 @@
 	bootph-all;
 };
 
+&usb0_phy_ctrl {
+	bootph-all;
+};
+
 &vcc_3v3_mmc {
 	bootph-all;
 };
-- 
2.34.1

