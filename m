Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06CFCA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 465D483AA9;
	Tue,  2 Sep 2025 10:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0qzRAfd4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3714783AA9; Tue,  2 Sep 2025 10:54:51 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AEA883AC5
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNrLSUYgfeHCq9Qr0O8/Xbyg7A/grb/D6cXJO3a2ziNc81YUJwJAF510kr6RkHcMdeADPrNz4wUsTGagdxC1xNCvNyguMa/U2OZPPmFKZlmYtRNHDsew+ej/qQcNyD7SfPQF97vc3mw9e4uinYwgEvbI35dBeAFYArEOyVzg/PD7HTnU5hWCOan4z97GrUegOYGmsoIDUrW7418hNcjULbeFejGh6wUU0bHFPHPXZiEpNbS0pqUTOqCb9gEzXoBB46LpcoaGrNfqu0R8legJfku+6XA6Z26HC3GIFZRuU18AOs5rVaj+fsy4bqKx4AD1DjLbYvgqyKL95YbeswolFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1Px2WjcFLXADyz3KqAvHEV5q/qU22igIydcilGewA0=;
 b=HgQQJ+OjfOTvbWFFcqd5l2rkUJjAcsvGX4tdB+7DKiZeN584Zq5vEDjpz9vKWS/UAu3cm7+VYuE7wtKoOITebKiuv5rlDNpJd8ko/57RG+5luPRDSCJJUhv8uK2SNul+P60lAR0NkX7nW9ITpt9u7eYz0FrY6cVddBEtCdYTKN0Cblv4LooWBuyHsEyXhMvueR3w+rM6N5rfZQ4dPrfatAH8ZOx5sYluFXCg42xmN5llrbR5dZFHgxu6sP5xkyi1LdvVkDa16EGXf5MSho7YyUYHbAh+chnPpTny4RnsuioUmxx8ob8+0HbtzsOhWHOgR0+4Ij6sEmEjTWXiHyTlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1Px2WjcFLXADyz3KqAvHEV5q/qU22igIydcilGewA0=;
 b=0qzRAfd4I7G9r64Jd6g8fMnDncGN93Cnep2x9hTjkdt78XzA4QKzjqEci7UOrVRof5ZVd4+ba+bjV5B0IOVttwo8n4d+rGdYDpEClFdmZbKNNlQQrNNdv1qb3cfhX+JGDVI8xqCA+1rgcBNX8Dx7RzIPSKb+/B6re3S75XxO6iw=
Received: from PH1PEPF000132F7.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::3c)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:54:45 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH1PEPF000132F7.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 08:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 2 Sep 2025 08:54:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:54:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:54:40 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 03:54:40 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Paul Alvin <alvin.paulp@amd.com>, Srinivas Goud <srinivas.goud@amd.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/12] arm64: zynqmp: Add pmw_fan label to k26
Date: Tue, 2 Sep 2025 10:53:34 +0200
Message-ID: <7a392d79685e5b122528e8fe7617475c4f6fabab.1756803198.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756803198.git.michal.simek@amd.com>
References: <cover.1756803198.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=689; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=dItEQme4QaTi9ts4bvl3d0wB7GDj6O9YaVU1PBj78L0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRs29CfLza1Qi/twj1BrfO9FzT2BPqutl7hxLjmwL+VP
 wptrtj3d5SyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEPpxn+Ct0f8FHT9us3/8j
 7IT0qqLe7uFss3uqd3blXn+jdzdZg6IZ/vDrPV4ZfMGw8fXEXbuuJoa9KkyoLzE7E/bAj3ebVYJ
 BJRMA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 062196ee-991e-49e2-cc57-08dde9fe5c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?16/lb/zlZOVyfRL7bm0r6jgVReLYa+gC+7ck99aQvY6cCxSwywfXej1LlR53?=
 =?us-ascii?Q?PVYDtxOi9FrbVn4fuylB8gDvjp8EmGCXxlGv3t+DXeAKJaEL1dWqMKFM0qno?=
 =?us-ascii?Q?v+Vo5ePUJY+q44AeGNMa00O0DYXSIHtZGAUPxjahkxpXseqCTVRYNIaGfmLT?=
 =?us-ascii?Q?MXCSPHbI/H2hxsf6tMGz88Bf3fSHWJ6doTl3Et/sfXx4c6WjkUD5SaV/ph23?=
 =?us-ascii?Q?D7KfZgxeluoSqflX+nIvvtXt5/vY9IhIQc1OnypQBXMmWs1t+1WMO+GCbaik?=
 =?us-ascii?Q?MFcQs1kcCzQgIUenW1jJSEM2L7ccNBgfm66nZFEJSbYmJ0ngZIov+I+A7t+P?=
 =?us-ascii?Q?jgBE+91g8QASVK4MycoBlBX3FEM9S/JH5iBUetg+ls1bGJklqe+miQTB+LL1?=
 =?us-ascii?Q?6Qb3f9vSh2eUIsEzHqBd7WGRiSF/sLKmHh1W3oF7lUlJy5lFB8icWEp6Hzz2?=
 =?us-ascii?Q?XRJhxhkP4ihtMxJdOsfMB4imH5fNTrglha1Ue25OmtWJ3vCxw1T6GHSXIzUM?=
 =?us-ascii?Q?vJ2hQtBgO4NopEIEnpdEQ+V+XM/TxcxCoJjr8SarlCCm3SWhygisEwKAB5Tj?=
 =?us-ascii?Q?gd0LEQam4B9//wPgEg5FGi30Mt8QFjoJd3Y4VUdl20YuhhySVPsxWNSsPvL/?=
 =?us-ascii?Q?78qwjFctP7Pn+ImIpRjdkKGf8HZTRx1xih6rQaonvquPLg6GfJi0MtqAWdew?=
 =?us-ascii?Q?2fgpbp9KZyQYaBdBhzc5hf53a+URJ0Oe7N73wO07UaNA4WlEitkI1LI+97Rq?=
 =?us-ascii?Q?BailqqShS/B+t+6kPquNIpc0c/ielzbJdJ728eFVBNje5LeUrUVP7njiL+E4?=
 =?us-ascii?Q?OmU76+9WQRr+fYXsG6SWNPdCQVNn2tU0Dggg7b4+StxcK/c1HUwWYOJJVod9?=
 =?us-ascii?Q?Zay1Uf9eAIQxuu5n0+XQ0d1vAuTC8GIz25rMDmw0dfs1dQg1Vkev9p6/SvXs?=
 =?us-ascii?Q?zS5l2pb3RCljr1wn+Et6cGe6qHeBKBPmsuegul63B32T0AsPCqYaZBAtY5ZD?=
 =?us-ascii?Q?DjTfXqu3nBt9CdANvwEhxuABdoOVAIHJBZWkHA6kPtVZgqX7f0cX4PXlhGno?=
 =?us-ascii?Q?NkcwTFxDqIi+LMZwziwznNeE6SEP+6D9StRrHucYKQSUi1qMM+/XBy0JmCjW?=
 =?us-ascii?Q?52rr2pKo+Iy8EjDEic3gh+RngyKkiXs0qV54zU/3NuODE84fGYlm+VJ7Ds+j?=
 =?us-ascii?Q?/3Q9wpuYeGCqmymF/c90rHOhpCqFepclSJNQihRicLQ2+IgnHOi4jI7VwsFb?=
 =?us-ascii?Q?wDScHfx/Xy/cVDCj//q8T4kPMAnGOtDCfsT6vFeYi3ngFGWNkKan1Hsqm/kl?=
 =?us-ascii?Q?WFsoNc4Kzg1Qkdk/U76wDFThUqSZx8dDkuvqydnfce2gcBeCrW0FAiGeZjI2?=
 =?us-ascii?Q?kW0jBjh/oXyBzMVNXs3so9cIct1p80FgiAoLdTko+pB/UOQ/J1NeY/4lUzzx?=
 =?us-ascii?Q?wrlZPBp+wL2kKhN9fkjY3wsxTkv+pWRN/UkdzUPnIVhvojC0uL1tLYFax1Vp?=
 =?us-ascii?Q?vF2i8jNWrSfOnkCBINb1bAoeHeHgI5GskRKf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:54:43.5296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 062196ee-991e-49e2-cc57-08dde9fe5c4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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

Some boards/designs with System Controller which are using SOMs need to
change PWM signal polarity that's why create label to be able to reference
them.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sm-k26-revA.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index a614d835b518..0abec77b3f3a 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -90,7 +90,7 @@
 		};
 	};
 
-	pwm-fan {
+	pwm_fan: pwm-fan {
 		compatible = "pwm-fan";
 		status = "okay";
 		pwms = <&ttc0 2 40000 1>;
-- 
2.43.0

