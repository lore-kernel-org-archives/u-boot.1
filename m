Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7283BCCF9E5
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0963E83826;
	Thu, 30 Oct 2025 06:20:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AeQ5rNWj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15AC283887; Thu, 30 Oct 2025 06:20:03 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6961D8393C
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:19:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8zvZRKu3HB0/rZiYyXnBlfK87q3Qryzag6FoaBFZonX40gYPsZoHAAZCZspJmiC2x/CCCJy7FtuDs37Qqm2fN4mB9I9V0JluafsmguxQoUn/Xa0f/wb1Dnc5e85Xn9W4UvH6DnbhS362dJxXse+TvNlpSRf1Czqu+hYevKoJfo52AeB4bO0Wy/sjunP5n+OIBMLtNlxf2fnM2sSGNWFYgMi+Gb3vbXK8jPUXsgIX9vyj7EZHQFG74xoC3oPdB4D5v2d+Wsj7ZrMLjLP/glbUrL/Bhqo7mvu1WuCXBe7sAGQqODO05phZsAvt7eVneCTTNiNQsDp2967vpOhupYKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAYvLmYDfqyBIDxRH9VCDBiFlfGCKRfrjHnKtcu+ufU=;
 b=NGpL0oyrbMd6k7Xf86OUliIXKGkxn6G8DMds1F6S6yXzimWASQSrzWPCVAN5S9KiZ6FqCQm5BIsp84zYEUQ3/P6cQBLLqCghUyFDo6UBb0hJfB8ZrZrJML3Ys3OmWDfqRAWFCECd6K5MRayefZjrGU1uS0wSCOqhZhrkRYl+3MhCU6dzEStW2YfUivx/l56dCugZTIAinlOttHvieKKOKJzZpFzXw6FpzEfwHg+Ieh7etXkVRwsLK4NtRQAj2EonxxM2jMJEO4nxVJmjWFQxAuFswRESJyb43uzR4quA5u8dNzj7NAzqweh04ErNRhNjJQ2Zvg4lXr1KO6M4N748QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAYvLmYDfqyBIDxRH9VCDBiFlfGCKRfrjHnKtcu+ufU=;
 b=AeQ5rNWjQZ6umETi5a+VjG3ING+aUg9LiFq1bsR8sLBgJ7US6x1o0lC0XEbQGennBwRe3EulgInb0CU7WvaW5XLSgZsv/27AH8SmVwZ5aQKdwDdIKO25y6DeQuYuPMVi9DeZrM8hNf7Y2rWwMWm1u+TP/IVOtBLSo2/V59OLNBU=
Received: from PH8PR02CA0007.namprd02.prod.outlook.com (2603:10b6:510:2d0::18)
 by PH8PR10MB6646.namprd10.prod.outlook.com (2603:10b6:510:222::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Thu, 30 Oct
 2025 05:19:54 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::b6) by PH8PR02CA0007.outlook.office365.com
 (2603:10b6:510:2d0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 05:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 05:19:52 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:42 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 00:19:42 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59U5Jfnm1446097;
 Thu, 30 Oct 2025 00:19:41 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v9 1/8] arch: arm: k3-binman: add fit for falcon boot
Date: Thu, 30 Oct 2025 10:49:25 +0530
Message-ID: <20251030051937.3659010-2-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030051937.3659010-1-anshuld@ti.com>
References: <20251030051937.3659010-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|PH8PR10MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f50cf5-a069-4314-d89c-08de1773f48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|34020700016|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gDqdCldDMDro5tBYEzDPbgMNFWmam/bKXKEvalymNMBMA7KXLHcffoXzitvI?=
 =?us-ascii?Q?4sYs+/8A0HcyeTFB2dia1Da1x3L6JHJ/JQuXOTdg4GxVWPTKWlroSnnlU4JM?=
 =?us-ascii?Q?sBy3h2BkPHkNYBCEz1XT4zXpvx+s+InmcAmxfKTWX9nO2DlBaCt2p3bjWZi1?=
 =?us-ascii?Q?MFo+b5TgmmLKwlkct5oNHWpGqUBEzuMu4BEOB58XoAkxSedL07sNYVO9pQ4/?=
 =?us-ascii?Q?LTKXcYtlkzy3e0m+QzGP9/IkHsVnku7yaXHYvfFdXCufa+/XP9X+XT+JHw63?=
 =?us-ascii?Q?0Q0EiDFJ2IkflrW58ZZSeejDBjXJzQKR4tg2FIK3NAm9JJLXXAcpqyTpkXNa?=
 =?us-ascii?Q?gfwvHWaiJ4h2Hw8W0MRNSpsOTXi3VSsWlSQ3H9Mw4z7OVQJ+2MjQwBVz0jws?=
 =?us-ascii?Q?wwpobzU2+ujIL/As33MmzLntiRsOOoDo6PgKrxSIPeHOe2C27CWbH2+KbRu/?=
 =?us-ascii?Q?2FH4a0AsB601oS2yN4htQM04Z9Z5nkpsEvsx4OquFGlXKSCE2dZFlQWf6BwR?=
 =?us-ascii?Q?HkimIhZ0s4MhKUkYfzu1qHA+1U4438PrCC3FpeCWK/PIJpi2AF01SRoBgCbo?=
 =?us-ascii?Q?Yb2xSFzd0QyE1XYznkqflE75uSyr/GwT2CeY/Q6MfjN8vro3RRUXPz0MCko/?=
 =?us-ascii?Q?oJeh+3hJSLeb5FuIZbvKzwuaH5GZOJxKHHO5i10UMT6AKfXX0WAHExpb6XPW?=
 =?us-ascii?Q?ySdn6pAedOAGKcgW+wderXlLAPl3hIGseTBSqmcdCCuLG2k6PBNAZdFpKlFV?=
 =?us-ascii?Q?gpjNhWASuK1SvJNGWjM6pRdcf9SXs0JxL7XAO7aDLI5/DPjO6y7GK1Jl2rZ1?=
 =?us-ascii?Q?24HXVGq10B9VXunPCxibLnCPUczkSIKDB37mlgzuM7+IVCPRupFBgytSBYTw?=
 =?us-ascii?Q?LoVEcoHlEO2FIUYrukBOC0Lw+yyir4N5OD45UgjexAv+H1UNWy+SQ4or8gFW?=
 =?us-ascii?Q?aWymO9vBXfkPWgUa3hCIcaxLEbA/jIYr0APHa2osds1Z+O5GVZXcVwqaAE7s?=
 =?us-ascii?Q?CL1BuaGx5Z2B5MqC9MCHSS9Wk3ArHIn4bPz1SrWSH4rbDeCsYXubttLRbNB/?=
 =?us-ascii?Q?6lxIPST0I3GZyp4Wo7i1IyjiAyoTTbdzXJJC/gNm6rkxkpyj2Z9DLUnWpCdB?=
 =?us-ascii?Q?povMRwB9/8RrasioMB/eXpehp6w584auevv7JWdUJBmbCAMtd5vNRbXZRTZR?=
 =?us-ascii?Q?DVP8viIbBV47sCddp5mg29Tycc+mnkpBLGEWwYcMtVvBxHTV/gx9fFS/K9mf?=
 =?us-ascii?Q?v1KgRp+7e2LXpkGU6rqmuRAkIl+JHXOApJ1AlWo70ilVHgpGXnSio9fx1O+r?=
 =?us-ascii?Q?Juy3Ha9itdaM+XGRCe9fVWzDRoSMboF85jO2ZTJxFPlmwCa7zcTRV7X7gsG2?=
 =?us-ascii?Q?JQKk1aYgW3+1oBOx1ZT7PGRueOZ14DJweqVXfrIBhTSi3LLlhh+Fwg8e2a93?=
 =?us-ascii?Q?NDjQpaQflRALllYtS0WsA6guvg83gKfk5hCvxGGJUQ0GFNK6aFc06LXmvdDs?=
 =?us-ascii?Q?DlM+7fDd7oEOVbt/lLENHVz36xgeS10zMde3rkn7RHWHhGb1vpAIQFRNOMlN?=
 =?us-ascii?Q?FqMEIhVUGf0LTrMmIUA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(34020700016)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 05:19:52.4038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f50cf5-a069-4314-d89c-08de1773f48a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6646
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

This patch adds creation of tifalcon.bin for the AM62a, 62p and 62x.

The contents are the same as the existing tispl.bin but A53's SPL and
the FDT have been removed as they are not needed in falcon boot.

This reduces boot time since the payload size is smaller compared to the
regular tispl binary.

tispl.bin    = TFA + TEE + TIFS-STUB + A53 SPL + FDT
tifalcon.bin = TFA + TEE + TIFS-STUB

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi | 64 ++++++++++++++++++++++++++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi | 51 ++++++++++++++++++++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 51 ++++++++++++++++++++++
 arch/arm/dts/k3-binman.dtsi          | 54 +++++++++++++++++++++++
 4 files changed, 220 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index f743c4353b4..42edb35fa7b 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -206,6 +206,70 @@
 		};
 	};
 
+	ti-falcon {
+		insert-template = <&ti_falcon_template>;
+
+		fit {
+			images {
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+				tifsstub-gp {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-gp";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_gp";
+					};
+				};
+				dm {
+					ti-secure {
+						content = <&dm_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					dm_falcon: ti-dm {
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+				conf-0 {
+					description = "k3-am625-sk-falcon";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
+					"tifsstub-gp", "dm";
+				};
+			};
+		};
+	};
+
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index e3a2d155d51..cb9a56b8c37 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -144,6 +144,57 @@
 
 	};
 
+	ti-falcon {
+		insert-template = <&ti_falcon_template>;
+
+		fit {
+			images {
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+				dm {
+					ti-secure {
+						content = <&dm_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					dm_falcon: ti-dm {
+						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+				conf-0 {
+					description = "k3-am62a7-sk-falcon";
+					firmware = "atf";
+					loadables = "tee", "dm", "tifsstub-hs", "tifsstub-fs";
+				};
+			};
+		};
+	};
+
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index feb59edcd83..e1443d6226b 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -161,6 +161,57 @@
 
 	};
 
+	ti-falcon {
+		insert-template = <&ti_falcon_template>;
+
+		fit {
+			images {
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+				dm {
+					ti-secure {
+						content = <&dm_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					dm_falcon: ti-dm {
+						filename = "ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+				conf-0 {
+					description = "k3-am62p5-sk-falcon";
+					firmware = "atf";
+					loadables = "tee", "dm", "tifsstub-hs", "tifsstub-fs";
+				};
+			};
+		};
+	};
+
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 5163161b94d..761b1730464 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -489,6 +489,60 @@
 		end_address = <0x0 0x9fffffff>;
 	};
 
+	ti_falcon_template: template-9 {
+		filename = "tifalcon.bin";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "Configuration for falcon boot";
+			#address-cells = <1>;
+
+			images {
+				atf {
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					os = "arm-trusted-firmware";
+					load = <CONFIG_K3_ATF_LOAD_ADDR>;
+					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
+					ti-secure {
+						content = <&atf_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					atf_falcon: atf-bl31 {
+					};
+				};
+				tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = "arm64";
+					compression = "none";
+					os = "tee";
+					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					ti-secure {
+						content = <&tee_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					tee_falcon: tee-os {
+						optional;
+					};
+				};
+				dm {
+					description = "DM binary";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "DM";
+					load = <0x89000000>;
+					entry = <0x89000000>;
+				};
+
+			};
+		};
+	};
+
 };
 
 #endif
-- 
2.51.0

