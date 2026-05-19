Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14713CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E648D84924;
	Tue, 19 May 2026 18:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="CsxNaJwz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B04984922; Tue, 19 May 2026 18:32:02 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CDE284912
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yann.gautier@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhxxqTafw809OBzu6CvvF7IhEnUAv+rE3nA3J7eJOoO5p3KxGJaJ4XKA6LRN/GPYIB2LUOiMtRM0QanDmPL6SBgDEkFwAVrMNdag10bO8pYzbeJAMMh3ln5KIwY95L8Q+fBJAtKF4jlPJPsuxZ8htlDz3eK/Fl5Vzv1m3aixtzAtgFdV6KJAT0nPC8sd/AtJscmbaEF4fuC9OhiMIR+CCZynQjGoptV1WPjWp31v55+mZWIKsAaF01LaKmIvyHJHNcV2tpfPMU4K8d2iNirLB4FdcHPDy8VzATC8ebPvRw3ydvCrF+2bYVb/DIRwYPK0nRajIGsjZnktENmeNNULwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLa4Hqkx5RFoEjhRE6jicTyC5ZxIz1G5cU7rFghlygY=;
 b=CUHmHKC8/ueK//Iusm/C3fXJ8J646IMaG44axZVjSOVxJLla9kxK9p1daddC4ySdRW04EwB+la6DlVQjsbrWzNhk5m/AIroWa+m0NtV8CWu4rsqBgyU7m11hgNa0Nr6wcDcBnCVkoQmAdrK1jBgexdi1oy1YKChmPnrxOynEtjPR66WngyY0P/MAjVigowGsBB3ufSI1Z00hgCDDG/dTX9S0oLX3vcVX7dfi+9/K/c+zhM/RifKS7wxHtqFZvk4jbTqvtJpECpH6OUZrz1agH540Yry8nopg9lBMRWu2sgWdjeNPeyoefpwXMBdn/WNDBOJT0krCDipQKltKSpHyGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLa4Hqkx5RFoEjhRE6jicTyC5ZxIz1G5cU7rFghlygY=;
 b=CsxNaJwzLgKtk2lTxev9As4F2vJkK5IjDwvzZ3Gf/xr1mZI7/uKeBlXSOIxiUT+4EIJpwboJiq8v1ClLE8mqVPWtAyXPSiu2nJ0FUoA7vV9Hst6WHSM7zlSA9t2Kqf1s6M43az0PXntTk1diRczoKSJsUi1XqXPvWKycDyoHG5+WzRYuIguS8qWTHz7QoTrtieJRyT/H7M/UlU7yZzejEbrIlZRKIl+7/3nsMbvIPn/7uJ9Exhc9IlN4L/oiVlvWqPJm0AcB/LWPlaqmpdoU/D0hyklsyTkhKidTAhmWc4fbefEGLk+WbyN2e3wFv69TQfEM+8QOFYcGlE2fueVudQ==
Received: from DU2PR04CA0180.eurprd04.prod.outlook.com (2603:10a6:10:2b0::35)
 by VI0PR10MB9660.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:311::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 16:31:56 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::4d) by DU2PR04CA0180.outlook.office365.com
 (2603:10a6:10:2b0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 16:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 16:31:56 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 18:35:25 +0200
Received: from localhost (10.252.30.192) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 18:31:55 +0200
From: Yann Gautier <yann.gautier@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Yann Gautier
 <yann.gautier@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Christophe KERELLO <christophe.kerello@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2 3/3] ARM: dts: stm32: enable SMC watchdog for STM32MP15
 SCMI config
Date: Tue, 19 May 2026 18:31:44 +0200
Message-ID: <20260519163145.221668-4-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519163145.221668-1-yann.gautier@foss.st.com>
References: <20260519163145.221668-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.30.192]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8E:EE_|VI0PR10MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1f523e-c9f0-4c5b-cba6-08deb5c42490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: T3WZnO6wDm4mc0sWzWJkAuYDU/tPPPaoXDK1zElzppTybXIobrC0cGJbEXxmvQ+LM+qrwEKgzhdFMGAiZEs1NFmDdf3fE6HxUwtX/qbEnO0nPKJOiwsVcXnQuiuSj7iN6Kt3hSPAYjYRyFYOZwcyzCOBtJN1xv95eEZdxcAnksHo6LcuDJnMsQ1WaMsoePq2nYQUQk5NLJRLTt4CrOfppWnjAh+7XJa1M2rBzrQYK/Lopxn1ctNrAeE0rS7xTSkCRyBERQfnB7TgmNoxaZkQla4snx6GXc34AKaa2Sm0tSmX7eOxZUHeTiUeXl/9XjvOM8OjGiQHdIl9MqaJXh9w65damv4LRO46sTUZ4Nlk6RfrN5FY1muE+7UO6huZu4deDqnX7zGFHR3X1VzjUIAt2t6RoXyWSOh1/2jVJf17GU+dwqnOLSEN4PeDiv9po2wIGK9F5Dias5jqIrOcCg9ReylKMCv5Hy8vbYvDdE/4MjWOrH0pwwq3LLUl+S3OSK/NlGArjVCBinMlGWg3r6Y/iPdiYoZmMdx2Ag/zK+pCNmYOFAlb6pHEekHGDDFUSfEqKs9ZqBH4QpIAetpaw1sikHQWv26MdMKS2XrNbETMy5uGguhqejn1wGEaEtfYAn2kR1+XqTHrK/saOit5zEjjqeEN6NcNnUK6gxxofsch/YT7EvfMVpFw1wxCZM6v5KemJDcB25SBLD9cBR/KkWntQi5J6mWFPLs9Qh1gnh1552Q=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZQiR5U7m0/hQfSFLcfGA87VgswJWw/IYFM88JrTMZRVesU0+XhMSWW1OfQCcfETrlZOy3xAY1ax9EdjiRqPc83hpAAP9+ezQ4hO6fu9+u+OWjKM8+M4Sq7LxOrQYaMc/wftybD3kuGMoYda8smZPPaKquTpE5AytzRGNeMh/VnskxOIkjt3qtddoVB9phJ7O5F6Yfu0K5WAA5AirgRVVi3CpyfPUiVu9Xbl6qZSlITKgKyPQlPHSnNtLc6Jgp+AWNJUpoJneRdEjiwdnP94UuaqYSMhzCNFYTtP3Czqe1yq7HlIF+U8tyTlIOr/uWW7L/Ru0cBBWCp5iuP+/+udFKpOoY8lHshPxEEkQ1TxMSYNXrp++BB6qw/dSNY2jrGbOF7COHtriTyIvrvHHapm/iakkLRq9INIpdjYghI3QNtw33Ej6/j3wC/jGquX0MflS
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:31:56.3788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1f523e-c9f0-4c5b-cba6-08deb5c42490
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9660
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

For this configuration, the watchdog (iwdg1) is secured and managed by
OP-TEE. Add an watchdog node with arm,smc-wdt compatible, and disable
iwdg2 node which is then no more used.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

(no changes since v1)

 arch/arm/dts/stm32mp15-scmi-u-boot.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/stm32mp15-scmi-u-boot.dtsi b/arch/arm/dts/stm32mp15-scmi-u-boot.dtsi
index 79494ecad90a..600316205fcc 100644
--- a/arch/arm/dts/stm32mp15-scmi-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp15-scmi-u-boot.dtsi
@@ -21,6 +21,13 @@
 		pinctrl1 = &pinctrl_z;
 	};
 
+	arm_wdt: watchdog {
+		compatible = "arm,smc-wdt";
+		arm,smc-id = <0xbc000000>;
+		timeout-sec = <32>;
+		status = "okay";
+	};
+
 	binman: binman {
 		multiple-images;
 	};
@@ -103,7 +110,7 @@
 };
 
 &iwdg2 {
-	bootph-all;
+	status = "disabled";
 };
 
 /* pre-reloc probe = reserve video frame buffer in video_reserve() */
-- 
2.34.1

