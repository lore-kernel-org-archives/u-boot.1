Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F63AF0182B
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 12:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD769838BB;
	Fri,  6 Mar 2026 13:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uYbOE56Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72959839A8; Fri,  6 Mar 2026 13:02:47 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A165A836D3
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 13:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofS8BHMp1EnLWhIPGpisLHKYy+QsL48CKLAeTfPTZOCgZF2x0ykZ+WvXTTj8byOi4m3SH0DD8+N59BwQKUvIX8y8d6NDi3bCnRwUTL06jpZFeJ4zxx2tpZBXion4zpFK1ggdmJNMy/OdhhtmgqPatSLSLEJim/SnKK3ykmaIUDYCyreBoIfv75/cARUFofz0rwcRtzEz6I9IRLeQt+vra2vE9YOmnSxbXRX2MWsgZzlsuj+yS4xZDHmjMvgDpDn6MWJNf7Snj4tQy6jk91nalofZVkYN5pDUTut7unkAZQeo0DDN5Ql5jQy8mSoDdvJ1pQUrTxYNoIDgUFkkAbJixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Aktkd2TMWpuJxExyQ8I4ab0VOmUhYOJ1GwNvBKRkVU=;
 b=h9sgJAO0LfRrsNFLdWxGH922yPcC3gkv632YYdWUO435nXqDOcnIGRyRB+uZyDnXncMj38K4dhi4y0ZanRR1PX/Ne9sn0go7trVjku46j6BNG+890Ng9XTWZU2EZihJ2/RhqFXxAlvudOjBq6qlg3FPQtlI6fBd2kt79v37J6ur0SmfVuU9QOG7nE68kV5HoeRJfy34b9jOr/iuTrhpIwM/GFsTqQPSypXyo7WE9M1+TT76lBVFk7U+LKPEmU/Z2ySvt3BVvHqniEOVN9nxm7zBiaipsGzXGt+60ueTCTeD4wmtm+KAfocDI71aMZ45KDL56wUbwmLxEBXjdUxpPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Aktkd2TMWpuJxExyQ8I4ab0VOmUhYOJ1GwNvBKRkVU=;
 b=uYbOE56YxlhPmSWJYs9pe7u02ds7WqfCmWLk7Wvr3pky9oKNtObg9jWDmhhOxshD6RC9tqdyyknfcNctXTNAq/2r57v5CQtN0gmsabNX+IEuWHoJK86GJ/GB2dpxu8zDnDUPSln/Fj6IVyp9fx4lSJ6f/Ze0UJ6Rm99wb9Xn/qI=
Received: from CYXPR02CA0067.namprd02.prod.outlook.com (2603:10b6:930:cd::18)
 by CY8PR10MB7244.namprd10.prod.outlook.com (2603:10b6:930:6c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 12:02:41 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:cd:cafe::e9) by CYXPR02CA0067.outlook.office365.com
 (2603:10b6:930:cd::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 12:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 12:02:40 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 06:02:40 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 06:02:40 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Mar 2026 06:02:40 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 626C2d5P3766414;
 Fri, 6 Mar 2026 06:02:39 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Fri, 6 Mar 2026 17:32:37 +0530
Subject: [PATCH next] include: env: ti: move board specific scripts out of
 ti_common
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260306-board_init_env_introduce-v1-1-22220dddfa47@ti.com>
X-B4-Tracking: v=1; b=H4sIAFzCqmkC/x2MwQrCMBAFf6Xs2UDaSAV/RaSs2afuZSObWAql/
 27wNnOY2anCFZWuw06OVasW6zKeBspvtheCSnea4jTHFOfwKOyyqGlbYGuH5kW+GSEJX5DPPLI
 k6vnH8dTtv76RYWt0P44ftcl3sXAAAAA=
X-Change-ID: 20260306-board_init_env_introduce-3da7ec4a1ad3
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, "Beleswar
 Padhi" <b-padhi@ti.com>, Bryan Brattlof <bb@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772798558; l=2782;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=X1P92T+0AeHPUpn+F6Rk412KYWHmxrw8CARQnt6cdJs=;
 b=oLK0r1eFRAPSTMmlqCDOhuGtotCMY8TyZEJXpHZ/6Y509g2ZPnLl2D0vfbNjAKMrcxYFN5K5y
 9iFXPe1IbKYDhg8sngInRjJMv1bwi7wozMFcE521WJ1M/r0311l7s6H
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|CY8PR10MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 344472c0-da31-4a9e-f2d9-08de7b78447f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|82310400026|36860700016|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: 2aOYy9i900xYy/x2lYzfndoPBL51oKzWFYmaDIm4ZcmoXoQ6XVQ215NUtF7ft+dzZsk6p0N3VWJ/lA/EutTJfBnX7rb2lWOskkXFsmRM5b6Fi1bwIkzIBLqRc2p7BjkRZV/h127aiQWnh5i0zdVHSep5ArqWexlImPPrkfUCvK9fHw3NKSczmM/+kAtwMvuVynixD6UuH2FTDE7a+9dV9u2YxrNz5PoT6NCbN49BK1ha6IqOY2aOYRrncOaBBYOXFD4xkayjBRDYedMqGJq69qzHzapZEYd+rIoWoIJ8q1Y0rLYoGghUPIjgPPlLLTl35WlPh9WmKHuUQACJwpABLe2yu8qBp8xM38CJP2mK+CKjNPt3exaCA715CagdjZupu/WIYVP7hMYDCZFuXdx/l2SL2xM+V88IpZG26wEnxwKhPEGn80ZLicv7fnV8vbDeVuyFJyAjJLzx7de4OmaC6I0pheG5EPfOCwF3H9snC3J+D9K7u+Td91hgOMiqfLeKhSN9HTYadvY2Xl0JXmMasgNddl+9fHr6PMxk0ueICjLMTTvLNAG0CLdVb9yrPywhuzPta7UJw96QSywQAhB2KTLx/cR5djzbpjxIv6iDCXdGwQvlrPddz68a9ba+WxKanL+v81R+QhTTOtMOZBRXntMcX5XsxbjQnY6nbIkBwmzYAQ/THXLxop8U8phGit3TE8OT/nz0P/QH7aEKBvQsUYCQhBZHGyTx1OgDmEJsHAo+Tu2yHOJ37Njgyf0jlygXqX4THj3cmVkvhcB0aW6aeQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(34020700016)(82310400026)(36860700016)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lVilbhVbZmjQidTXGduf2oYFLWxNbp6RpzzgfDTDAZsKFu7AqAdD2pMpMmV2aTYYgstEgTFVCJ0hTfA7eUuyNzHkKR7zr+m/fXvWyB/jSs5+A4YDYvEneQuGNLb7X1akzmfWXoSCKl20FZISJ/eei5HjDRiV2M0zRl59zwPcBWZMAg3AX/rgE6H6G9P5euN+dxDfLSoXn7vqJCnYgWr/e+Z8LQFqdZNiwXl0SIyF6DYtBxYZW9uvG+5rX2Mx5SDTQdlIN0lFeA5rnV7t+PKY2RKlI5rMP3F7EIga6B/Y6qfs9tGjXiL7hxy0ED38FGxAmmKBVOl9cCChgW2LjW+YPQnv51WTsbK5MnUnn7Hh/Ihs22zbnKf0D/dgfgfQ25tjU1ffYQkTmxdL5ri0P3q+nkdyB4hMjd25BbDNxjNHnUHrV5+oBWqEWtXcZIT08qQx
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 12:02:40.7922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 344472c0-da31-4a9e-f2d9-08de7b78447f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7244
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

bootcmd_ti_mmc had cpsw0_qsgmii_phyinit related scripts even though this
was only relevant for the j721e/j7200 SoCs. This patch instead factors
out those scripts into a generic 'board_init' which is called as part of
bootcmd_ti_mmc.

This allows boards to more easily add custom behaviour to the ti_mmc
bootflow instead of having to modify the ti_common.env file.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 board/ti/j7200/j7200.env     | 8 ++++++++
 board/ti/j721e/j721e.env     | 8 ++++++++
 include/env/ti/ti_common.env | 8 +++-----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/board/ti/j7200/j7200.env b/board/ti/j7200/j7200.env
index e22a954d8db..7bb63825c52 100644
--- a/board/ti/j7200/j7200.env
+++ b/board/ti/j7200/j7200.env
@@ -37,3 +37,11 @@ main_cpsw0_qsgmii_phyinit=
 #if CONFIG_TARGET_J7200_A72_EVM
 rproc_fw_binaries= 1 /lib/firmware/j7200-mcu-r5f0_1-fw 2 /lib/firmware/j7200-main-r5f0_0-fw 3 /lib/firmware/j7200-main-r5f0_1-fw
 #endif
+
+#if CONFIG_CMD_REMOTEPROC
+board_init=
+	if env exists do_main_cpsw0_qsgmii_phyinit;
+		then run main_cpsw0_qsgmii_phyinit;
+	fi;
+	run boot_rprocs;
+#endif
diff --git a/board/ti/j721e/j721e.env b/board/ti/j721e/j721e.env
index 34f5f63d60a..9ecf7bfabde 100644
--- a/board/ti/j721e/j721e.env
+++ b/board/ti/j721e/j721e.env
@@ -37,3 +37,11 @@ main_cpsw0_qsgmii_phyinit=
 #if CONFIG_TARGET_J721E_A72_EVM
 rproc_fw_binaries= 1 /lib/firmware/j7-mcu-r5f0_1-fw 2 /lib/firmware/j7-main-r5f0_0-fw 3 /lib/firmware/j7-main-r5f0_1-fw 4 /lib/firmware/j7-main-r5f1_0-fw 5 /lib/firmware/j7-main-r5f1_1-fw 6 /lib/firmware/j7-c66_0-fw 7 /lib/firmware/j7-c66_1-fw 8 /lib/firmware/j7-c71_0-fw
 #endif
+
+#if CONFIG_CMD_REMOTEPROC
+board_init=
+	if env exists do_main_cpsw0_qsgmii_phyinit;
+		then run main_cpsw0_qsgmii_phyinit;
+	fi;
+	run boot_rprocs;
+#endif
diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index a0ed83f52ac..62b93eb25c4 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -24,12 +24,10 @@ get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
 run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
 bootcmd_ti_mmc=
 	run init_${boot};
-#if CONFIG_CMD_REMOTEPROC
-	if env exists do_main_cpsw0_qsgmii_phyinit;
-		then run main_cpsw0_qsgmii_phyinit;
+	if test -n ${board_init}; then
+		echo Running board_init ...;
+		run board_init;
 	fi;
-	run boot_rprocs;
-#endif
 	if test ${boot_fit} -eq 1;
 		then run get_fit_${boot}; run get_fit_overlaystring; run run_fit;
 	else;

---
base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
change-id: 20260306-board_init_env_introduce-3da7ec4a1ad3

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

