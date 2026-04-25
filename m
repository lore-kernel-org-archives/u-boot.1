Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EBAFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50E7584394;
	Sat, 25 Apr 2026 18:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SPc32PAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D91F7843A4; Sat, 25 Apr 2026 18:08:31 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8031843E3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11)
 by SA1PR10MB7593.namprd10.prod.outlook.com (2603:10b6:806:385::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 14:38:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8kpdtR8pL8uSHmRbIaST6yZRnLQzRKSBcM5vU10+jqzzxj1O4LSETLeopJ/K1ovKwqXPZTMwbtaeA5sH2rlVhK2wbyUL3nhc+zGUoOBV3nY+wmdFzou6Z2+HqgQRXAbz/q+160tz1Oan9vCHPmNWXPNWa3Nlh2fZ1Aye25K3mYb/iVvtWLPZ4555VF31TMWEujFXJLopxeUGsUH4CblhIMOu2MUQo8YBwRCSHmuNk0z3+kBP/GigUMh/IjkwEoLpNzO3uO5+mLRuXpseuPx5UgoiChCEsicFvvBAyOvmfWf5h+vAxAAHJy9lA8TDOAN+SNNA+QDDU53HndWp+Lhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTV5RYKdfDnSdd3cVj6ABGVPvTUi3uAi6Yz3po/5vvo=;
 b=cvgObqn+M4PoIzfPsgKEHjzk5iwHO+XTi5G9QkcPpxtFtlmGkTVGzmvY2qqx7+YogT+ijOXkR6tYkGTyoCRfltdSZNNmz+WBp0yzHS584eZZOB50iocOwD6ZOP+hXoaBL83HcfTFLNd9SiYHSP8yB4/Se4LZffFIMZfA8hj+MF5+/mP5XGFPkLjpgbMKeNLHbKMeZFP609SCnrB7GpUVO95rK4Y6P34TqhLJuk5nTA+yAGDWY9XxEcgE6aQlzGlFRCYz0ern9zDt4SgDWxzkKqibOJ/mZR/r3ZVUZ3BcEgsX+BdJArBMzLd38ug7LtPIsHZrq+JF0j5a5FVmuBPPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTV5RYKdfDnSdd3cVj6ABGVPvTUi3uAi6Yz3po/5vvo=;
 b=SPc32PAy4WAT1w3TyvboQRx1OjRL2u/YV27bwN3bxjBC/Wln5OuquM9dWGIi24rmbEnSfHmmZ0zD0fuPAF5NWO3mHGmLb5blxq324f8knwMkesKh1l+Nut0bc9A8Fng8dVCKq2reXwbDPqCEBmh6fzwuozT9Pu3qm7EVnUANEkU=
Received: from SN7PR04CA0215.namprd04.prod.outlook.com (2603:10b6:806:127::10)
 by BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Sat, 25 Apr
 2026 03:38:11 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::a0) by SN7PR04CA0215.outlook.office365.com
 (2603:10b6:806:127::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 03:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 03:38:11 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:11 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 22:38:10 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 63P3bk842903263; Fri, 24 Apr 2026 22:38:07 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v4 05/11] arm: dts: k3-binman: Add template for packing HSM
 firmware
Date: Sat, 25 Apr 2026 09:07:36 +0530
Message-ID: <20260425033742.1519298-6-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425033742.1519298-1-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|BY5PR10MB4369:EE_|SA1PR10MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 03719d11-b037-47e3-8213-08dea27c1324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2HlH/y0VKQqRTebBVcZFlM+haibKo4k5vaZfxk6kmq94hU1E4KkrjZ+WyMiWM6l5/Bd3BOUF4GEUZQpNYnPX+s++t1EIuDlNJeQndgtH/SMjFSs+alLtJhjb+O6FxlZhb4tpdyHjkOwUu2TrKryQNq6pMTzsbzqFeu/8Y6ey1p4zJHn17MkC3CbtoGkRfEL5e0Zgiv1BJHCP7Dc9i1FvMt4M+sVAsK8Kr0T7oXEmpbiUNjherH+SolsX168Tma40/3r2B8fyVwj8+Qo/b/JeFDl+S9xeP2/whcVJ4GRYJCf1ztoTw8bEI1kTUIzVX9EnqMZs2RZhdU0lBcmNetmIGCLVNGST5fb5xYW+QpuXgds8gfI4zhwl17B4dwBbsVNiwTRfHOqOBkhWCiPgRF3t9rWdehECmvuB6jiUsGdUOoAVkc9NMYECP5mxNpjLrvO1E1ka+w0FDGEsxNwiJV5Videlzwdak8rCvpypPaACsiUNzwWYC7BJCGqFBtQFTKiXkD/PZu5AXq2rbO/jhuUbC31+udECMNCkhC0B4ZivAWRBRwwyoPXJ2UEhLLRQzrWDYquqQMxOxqVgpBFWhWQfs3Phm4odqYaGGsrdP3anPbUHHF0olyamNMcVYgdiJDwJn+vK2+jLUCXtml5OQQHbuH3bR/KFVKFOrfHZJJpBNdHXyBMoNpDVzAWKIhb5Q7hKcSE98iQR1nsctY2gAqtE2BC2vQLFiKCm9bGlwHInLPo/ST7zCSfVkupqCyxtp8XzAhyZQG482afsmwK6lNVbNufg8Xmh6Z2EczaQlHs5Kc0=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zb1hzm1r2ku0378MQLvGKjSkL1XjpCnxNOdTCNz0HNhGlXzdcQ0cx4QgWetNZ5yBI5M7N9d2qB2q8vIQAIoZgaTvYnF9aN79OmOXcCj5du8vZOuee5aTh+bywxbVE8edRWne7lSyTPQ1W4EaDtSM17+6BUjDOMKZHJ8HGI52ElXd9iPIm1XEf+VkscGBe+uiuiWERwDsCDPfhX3rH1jqZAPsSKr0zRYkaex6/jeHLADkrSQd79UOxUtjoMRbgAbao59xyUXO1c/1a8OdkYhJ0SkIhC3Qxw1YbWOXhpn5y11a9xta8Lv3GNP59WVtJSvklYrXMElf1nQdGMuDomjwsEMpHWNcRjShm/0bQunD/rWI6jDLZs+YYAYHnA8lOusGsQ3K1/BfuiKnxmVPMu+83TCltpybqJtN4x+qFRiyGTPWAbAZTwZl4BzR+ea/pJ8Z
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 03:38:11.3213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03719d11-b037-47e3-8213-08dea27c1324
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
X-OriginatorOrg: ti.com
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

The HSM M4 core needs to be booted at R5 SPL stage so that it can be
used for further Authentication and security services. Therefore, the
firmware for the HSM core needs to be packed in tispl.bin fit image so
that it can be used by R5 SPL to boot the HSM core.

Add a template for packing the HSM firmware in tispl.bin. The template
also contains necessary fields which will be populated in the boot
extension and load extension in the x509 certificate for HSM firmware.
This is required as the HSM firmware needs to be signed before invoking
TIFS to authenticate and load the blob to HSM core.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v4: Changelog:
1. Changed phandle from hsm to hsm_fw in 'content' field to match with
   node label.

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-6-b-padhi@ti.com/

v3: Changelog:
1. Added ti-secure node for signing hsm firmware image in U-Boot.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-4-b-padhi@ti.com/

v2: Changelog:
1. Got rid of 'load' and 'entry' properties. Rely on U-Boot to set it.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-3-b-padhi@ti.com/

 arch/arm/dts/k3-binman.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index ad127663d03..e6bb05a0bb8 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -297,6 +297,26 @@
 					};
 				};
 
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					description = "HSM binary";
+					type = "standalone";
+					compression = "none";
+					os = "hsm";
+
+					ti-secure {
+						content = <&hsm_fw>;
+						keyfile = "custMpk.pem";
+						proc_id = <0x80>;
+						flags_set = <0x04>;
+						flags_clr = <0x00>;
+						reset_vector = <0x00>;
+						dest_addr = <0x43C00000>;
+						auth_type = <0xFD00>;
+					};
+				};
+#endif
+
 				dm {
 					description = "DM binary";
 					type = "firmware";
-- 
2.34.1

