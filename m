Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB76FD376C
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8276883F4C;
	Wed, 25 Feb 2026 14:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tfNBNB0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E36783F2A; Wed, 25 Feb 2026 14:28:41 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 498F883F7F
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nV12gb7Cdpk6AA0ImYp3tNEqtnwXxM32IVzPKa4gpnphDpZEatF2WTdU+ZABz00YEypVXBzE9Zc6PCwhMDQNvVAN41q3Qyb6+YCpAw6kl9gAdaEqmpkjfMCFnh5/dWhjC6gBVzARdVYwoDIW5TwLvdsrG4ubJ/GwbI4uoeZPvj7GEvMvhJNVNkYJunEebZI21jYGXjFPcewb3hoSfLtZbl9+R3y5ez6UokAvSxOweJAyoIqGFUzmDy3LceR0sRc8+DfGeqZBxF0bH+h1c/8hSvo1FbEcJLuJllsJfyReXaqNe0cWw5RrYeU9yDiPA2+J0JO8QTo1hmKnzKtsneZVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qk4L+UvOLLhBHu0Rat/qBH3em+kVsCqJ/31igziagw=;
 b=zR8v5GE47wr4u7OKt40xP4J8ESiNN+ZPDnnR2fkXleqIsXWAU6ZP+lEyQsSpgUdPSsSXvgXZGWILD+MfWRrklQdOdtoosmXM0pRCzHAMxyMt9RFcDnJPRoEFLVyVS97iJPcAt6Y1XBEbhUCgYuloH6g45qLOYwvUTDHEDMSHlF2GYINNLcYNYVZwwrt8OuG+nfLEiAdxFcrcsORxqRZrURiRW5G3sGvNwDC0LP6+8rWwNoH+YaO79txjn8X5bQPUpxillsYv/0QXxWpl+5ekHSTpHNz6Qu9LWb3gWUTggUneS2+xQeegxek1NkikjDKJqLCv9v4R0jHlg3ioz3QZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qk4L+UvOLLhBHu0Rat/qBH3em+kVsCqJ/31igziagw=;
 b=tfNBNB0KfAmRmb4Esvrbktk0ZIU00kbUp0p9HoF1psFpz7bj3somWbbC3owTHVSJtNJ4X/C4JJaNjfvKL3ypzwI7uIWi6BiVWpGzzx3u3zitm0/EK1pSH8AWRqjOl+PSawndFAnWzUk9lhEzYhDhc8h2fcVqh0mnxazDTb7tjgA=
Received: from BN9PR03CA0543.namprd03.prod.outlook.com (2603:10b6:408:138::8)
 by DS4PPF20A8CDC0B.namprd10.prod.outlook.com (2603:10b6:f:fc00::d10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 13:24:54 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::4f) by BN9PR03CA0543.outlook.office365.com
 (2603:10b6:408:138::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 13:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 13:24:51 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:24:46 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:24:45 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 07:24:45 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PDORGs011150;
 Wed, 25 Feb 2026 07:24:42 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <bb@ti.com>
CC: <afd@ti.com>, <n-francis@ti.com>, <vishalm@ti.com>,
 <sebin.francis@ti.com>, <d-gole@ti.com>, <a-kaur@ti.com>, Sparsh Kumar
 <sparsh-kumar@ti.com>
Subject: [PATCH V2 4/4] arm: dts: k3: am62x/am62px: Enable tifs-rm-cfg in
 binman
Date: Wed, 25 Feb 2026 18:54:20 +0530
Message-ID: <20260225132425.3096103-5-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225132425.3096103-1-sparsh-kumar@ti.com>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DS4PPF20A8CDC0B:EE_
X-MS-Office365-Filtering-Correlation-Id: 98947b9b-2c74-44bf-b163-08de747141ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|34070700014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: /eB81fTI78oZXaX7aZ9vbTzHz6nx6EEmzP9uW6L8JrD77fdWvpWvFTK9XK5qdGO//4ma/310yeOYlI2kuZXTa8MVsO6BK+5j1bQ6oqEuboQrFp0bwd2swsgqtd498Ld1c3HBcsqISIuk4iSxA00JZjJn2si/fDFp5T6zdVHRN1K763nin44AYopsS63878GBBrRlvPP5aUlk5ff6po3IAtPCf7S6Ocgl1I2vDbggfz1kNF967OvL6rMwlUCaxv05QTlqNQrB6HfKp6aNKsjX9ZlkjvOfhknCQN9psfLJhE+zLKe8oT3KlKzrZB10JA3LGv6HNVe2B/lOKfROT0i6g3qrQ2kKVhdyz40Cy/TRaWvQCsvhQxaojQQjyithOhiwhWQlUaUvh7MEJA49puZ7y6M7SbEUeWLhc0uBdLBRCwR/GNacRUtRjC0Q3jLP6xCzpSqNxc7RISm/oVv+r+XOq7NULtP4WCb7ZwgKx6uXS7Yu7goSBGa75iJEMfrgETRKZqOiQIx+DI1nZZrLqkvUbvhFx0Y0/lNQ+TMJezSxYmfDgyALD2ud0Wg0NcDEggGLYO0/JOK18hlkzTp1CCzNiEkloLwkygTZu1GneNRlqehakjLcmTboYj3gwCLmUDn56FK9I2/rQ3JoNSx+Ryk+z5NLb1cTpf7dzUl5Jw90kO9xm0yPK+XXRb+IzF0AMco5FmfIMP00l5XBA88oNm4LJhD5NjCRSx7bymWhsAzQhzVOKm2IrJau3MMFlkTZiqDF1ZmX6r6HSm9Jptd/YPchObvSjwQWc4Hv/a+W4o/myIybXeKsuTkzE9G+CLvNH4Ekq3NWT2WqlmbgEvh5ai7kfA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(34070700014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wqd60VreYAl2apfSxFrI8vB6bGB07omk/fYlOwb8UU0Vqq2KQUr8tww4xHvKORkmpJuLxQO2h1HK+jdRZV6xgluGCpfOwsWgAL7FY/u7V+iWBNOF+McE74BvApyYwAa6t8yCtykRdNSQOGA2CGNvh58um+5Ye9txjzmr/vhKi0zPkSYpy0x8rQFZO7eXKdSEw8N8mgG61efz41pS9ogUbxXm/TXI4lKW3Ym1COIHvzvD7jmVWt2a8lGD5hVVVtG4TSaVOrsQY9nub57DE4mpw0pb4I7foNnhNODbGsPHtCwGPGbKuWAa1xMDaLTKw3cewHHoj7PPato00hJLhJ8SGU8rLuECsqzVSDKG7aj6yj+nIsaPbFIIKXN0Udni7JAuv1kzepiyhAQTsyppwiV2VHLnLsUlViaYwiP2gvDR3h9vP7bDDnFRfDQ3RK4zP5m2
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:24:51.4956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98947b9b-2c74-44bf-b163-08de747141ba
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF20A8CDC0B
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:33:08 +0100
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

Add rcfg_yaml_tifs node override to use tifs-rm-cfg.yaml instead of
the default rm-cfg.yaml for am625-sk and am62p-sk platforms.

This enables binman to include the tifs-rm-cfg.yaml configuration
when building tiboot3 images, bringing these platforms in line with
other K3 devices like am62a-sk that already use tifs-rm-cfg.yaml.

This builds on the tifs-rm-cfg files added/updated earlier in this series.

Signed-off-by: Sparsh Kumar <sparsh-kumar@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi | 4 ++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 8d6015e44a9..ba29a047406 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -7,6 +7,10 @@
 
 #ifdef CONFIG_TARGET_AM625_R5_EVM
 
+&rcfg_yaml_tifs {
+	config = "tifs-rm-cfg.yaml";
+};
+
 &binman {
 	tiboot3-am62x-hs-evm.bin {
 		filename = "tiboot3-am62x-hs-evm.bin";
diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index 603487341d2..cca56b76d69 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -7,6 +7,10 @@
 
 #if IS_ENABLED(CONFIG_TARGET_AM62P5_R5_EVM)
 
+&rcfg_yaml_tifs {
+	config = "tifs-rm-cfg.yaml";
+};
+
 &binman {
 	tiboot3-am62px-hs-fs-evm.bin {
 		filename = "tiboot3-am62px-hs-fs-evm.bin";
-- 
2.34.1

