Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B76CC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 12:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC8CB804CF;
	Mon, 10 Feb 2025 13:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGKWIO1k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37727805C2; Mon, 10 Feb 2025 13:28:46 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D418043C
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 13:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSdBExSo2G9/sVCx/W59DS33clhjbLTxyoTLZXjdt99fu/b8AYIzzzIl4GSPU3KQ0ZtYbywouLLNOZ3N/d8DGWaeameYQyTrfKSLyh64/Rb8HwH0zFnAFSIB/OVV59Ty4I/7CcoWWunKd2X5IL4tsT1V9HLNOpy0jbfkIFyGxLvShoDSby1wnBI2yNeiYiuDPNm/qHNgwkYpKKssEM7b/bFYBTV98JAnSGTOG8hzhRPPXo1ASAmDyusF4aWk66QSz5PZquJ2yKiOTM3zjXmRoK58yO9/QzHp1lDmqOgqY0Gx5pAfXEaV2g1pxzPdejo18mV2vDATnynJUy5Dj+v2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG6yB0bC7+ilNv7zYuXWNVy7z/y5zpxKyWszloY5zjA=;
 b=CpXrecQqoiWIAvalUMaXMRXyxXqNYG+LMy1OoqzA20eMFgaZ/bxOxnSBK3q7X4KRuw+T8Ko56WWwHw9uzm4MQa4NaASyUrQG4Exm0t4BAVeAEZHcglLPDaod09hq/GW0PyXtRwFT1Jz8pdZCwSb4aYk7y0JCeRXdUsY7csI85XK9S45jMMKzjrnsN6UfMS7mIdjWwM+aRn2QXwJMjQnMb6+lNzGecrRwxCyWRCI3ueDT9mu85PPC0gItd+luSUPcuoNeMozVYO5g3kpp/fu6q+f3uQk8VooBq+7MY0qCzVwasRZUosTn0nRP1i61th5nQO7ud4I1G9sTEWR2iAbFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG6yB0bC7+ilNv7zYuXWNVy7z/y5zpxKyWszloY5zjA=;
 b=ZGKWIO1kZw9jpaRnBo4wg6kq9ON1HK3BDlR2krpVy49HWbxrEJ/hrYpoihoowbH/wWoZZoL8i+19qzUByzZcNZQ3C4gvXrtyGfN0C7n71a8FiO1JD6jYYsYxMkoPk5vo+PHFvI9WtmcSoVgAWQV9sCw2LAHNFBHe9ZfKiqE5iCY=
Received: from BLAPR03CA0099.namprd03.prod.outlook.com (2603:10b6:208:32a::14)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 12:28:38 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::10) by BLAPR03CA0099.outlook.office365.com
 (2603:10b6:208:32a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 12:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 12:28:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 06:28:34 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <j-humphreys@ti.com>
CC: Kory Maincent <kory.maincent@bootlin.com>, Lukas Funke
 <lukas.funke@weidmueller.com>, Sean Anderson <sean.anderson@linux.dev>,
 "Simon Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [RFC PATCH] xilinx: dfu: Fill directly update_info.dfu_string
Date: Mon, 10 Feb 2025 13:28:25 +0100
Message-ID: <c8378bd1bbc7a96ecd802897ca72e26a02bf5a2b.1739190503.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5615; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Av20pFgbJ69vDUeL7n/fdjZRAc0RmB2fppgyceprlpo=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvSVH17/+VXv/czu/I+UVc8M4g4HHCpLW7fpY2R74YvlT
 ia/6zc3dsSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJOPAyzPc7d6Dh9pIdOXM4
 u+bI2/MIKcSUeDDMUw2+MPl2x5bdfeW3fk/y9l17xvzlYgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d593223-237d-4e71-658f-08dd49ce7208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jcx/tiPJibecpw+XsaeBFio9xoVoQTd2EnwqbxY+Qiur6emZAPQ8akrFHETz?=
 =?us-ascii?Q?MijleEI76tcsVify9ShsWgEWDQU0NTqaB5lCAuCVeMHabzWugYWFmCCDm6nQ?=
 =?us-ascii?Q?pwno3fMdon4SQA3yITjqg4LhC1ETJtDLpCyo47FGglnTSVvAvFmxnSy2Szng?=
 =?us-ascii?Q?R4n2rXblibF9via1yAhFV+86xqpHXEmT2XUJzWSTNw2ItTnPr2/RYadBCcP7?=
 =?us-ascii?Q?JdKFwoo3HzR1HPBPIR/YE6kOsNlaejobyIrJ9qD/Wv8aOL+mHC0vToayhXmR?=
 =?us-ascii?Q?VwC8HUrH5e8XW8gqTHUJJCTmvIEL5sbnTXqclkhGCyEV25LNiT+sDj/HjkEZ?=
 =?us-ascii?Q?m/Ti1YgiNn/nmhN8lsOByaKwtF68que1AOsUIosdNdeUTMZLUJp4zykA+MpT?=
 =?us-ascii?Q?1wnZc6A1Tn4/qnV5Tbgk3JtLQ4UBa2FqA0jNyZA2UEWF0/gdfTKTUCpiG+nn?=
 =?us-ascii?Q?jWUuH3JZC7V8qQ4NXD49ALaECyunOlOPDWKRvlvW8ioq9EmiIdOswUG6ZxqO?=
 =?us-ascii?Q?qQksOf4zW/5zRIVX2ibcZ570Qkh75lutI+vxoAEsEjx2Br89OpNWXkAhu9zd?=
 =?us-ascii?Q?722eQNw/Aj/0sBOfCmum3K905LHMTeBU7tekfqwBs3332mH5ntgH9ojQzfiD?=
 =?us-ascii?Q?LVdZaxE3v3OooXW5F4ujmL95wksh4uDeCYcM8nPZORO/kFwHTNYmGR54Hgh/?=
 =?us-ascii?Q?cMxx7iQcSD+fiNm3N5U1gr1qydDdHF62AmjsOGhBdODejaV6IFpt7v2rZjp4?=
 =?us-ascii?Q?M122DyYBoLdElm8rTNNHBX0KrUVPZ7g/BN/jn29NFvGfq4oFHCvlcqyX2vqj?=
 =?us-ascii?Q?N46qXWsLZr0MyWikxn9mSTEbnE+CjvxtJeZo3dGOzFX/F88UDjlMFJXE60h6?=
 =?us-ascii?Q?BXP3odipMcrJlUVopzkMKoz5XFLir5XqwNsuvkhYZ1t+rk3j9kCxfgweRZKI?=
 =?us-ascii?Q?XYKVr0FusmbXMposqCnqEbEbQUtOHERFhzpFmBp4OPB4UyTL8IhsNs3TrHOL?=
 =?us-ascii?Q?I8VCINpsJM1PsEfJnuXqJxB1SqZ6RT/RP1hLKUAxujGg0tuNM0N7e0P4H0BX?=
 =?us-ascii?Q?GrYPgj79aW63ZAtipw7sMyN1m1LejBROYqpmCBfIlccri/fTshHNMVcdJPXN?=
 =?us-ascii?Q?cFiE1N3nt+D3sqv6Ad+a/4lAIPeoOUZ25oY0zUcGnPNm0kjoLaIHJ8RyLZJS?=
 =?us-ascii?Q?JZIGPtIQVR6ph8G11uwXlzknfrnJzRpD/qPGsADEbA/14q+qardFb6ASXEtB?=
 =?us-ascii?Q?xST+Bovi41mNkoLZuEX6R8Hy7187+AmTykq5seU0sTDAzeZD8TugEPEOhq9n?=
 =?us-ascii?Q?ZcJzoZOVgVx2j9kFH9Es9I+HxwmtFmyXq8Gw//y5C6OWz1oZr+yZ9odyspVJ?=
 =?us-ascii?Q?9A4QcTtEFrAPDc4IyA1wHNet7COp1qL4NP4lcyeJRskoXySNUeL3aqDbyVxc?=
 =?us-ascii?Q?Nev1UcB+H4Cqmyb6UbXu1yHsLpGXshva0+Ooz0dTDvZaFozAj2Hi+qG6s6Ge?=
 =?us-ascii?Q?hyrgLZJvM7nb+kw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 12:28:38.1097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d593223-237d-4e71-658f-08dd49ce7208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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

Do not generate dfu_alt_info string for capsule update but directly fill
value to update_info.dfu_string based on origin logic.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Hi Jon,

can you please include this to your series
"EFI Capsule update explicitly sets dfu_alt_info"
or you will break all our boards.

Thanks,
Michal

---
 board/xilinx/common/board.h  |  3 +++
 board/xilinx/versal/board.c  | 15 ++++++++-------
 board/xilinx/zynq/board.c    | 15 ++++++++-------
 board/xilinx/zynqmp/zynqmp.c | 15 ++++++++-------
 4 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/board/xilinx/common/board.h b/board/xilinx/common/board.h
index 64d657673e92..cb86c4c5b91b 100644
--- a/board/xilinx/common/board.h
+++ b/board/xilinx/common/board.h
@@ -18,4 +18,7 @@ bool board_detection(void);
 char *soc_name_decode(void);
 
 bool soc_detection(void);
+
+void configure_capsule_updates(void);
+
 #endif /* BOARD_XILINX_COMMON_BOARD_H */
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index b4483d00ad15..789eb81824f6 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -8,6 +8,7 @@
 #include <cpu_func.h>
 #include <dfu.h>
 #include <env.h>
+#include <efi_loader.h>
 #include <fdtdec.h>
 #include <init.h>
 #include <env_internal.h>
@@ -280,6 +281,9 @@ int board_late_init(void)
 {
 	int ret;
 
+	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
+		configure_capsule_updates();
+
 	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
 		debug("Saved variables - Skipping\n");
 		return 0;
@@ -356,7 +360,7 @@ enum env_location env_get_location(enum env_operation op, int prio)
 }
 #endif
 
-#if defined(CONFIG_SET_DFU_ALT_INFO)
+#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 
 #define DFU_ALT_BUF_LEN		SZ_1K
 
@@ -385,7 +389,7 @@ static void mtd_found_part(u32 *base, u32 *size)
 	}
 }
 
-void set_dfu_alt_info(char *interface, char *devstr)
+void configure_capsule_updates(void)
 {
 	int bootseq = 0, len = 0;
 	u32 multiboot = versal_multi_boot();
@@ -393,9 +397,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
 
 	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
 
-	if (env_get("dfu_alt_info"))
-		return;
-
 	memset(buf, 0, sizeof(buf));
 
 	multiboot = env_get_hex("multiboot", multiboot);
@@ -436,7 +437,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
 		return;
 	}
 
-	env_set("dfu_alt_info", buf);
-	puts("DFU alt info setting: done\n");
+	update_info.dfu_string = strdup(buf);
+	debug("Capsule DFU: %s\n", update_info.dfu_string);
 }
 #endif
diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index 8dbfa5604231..c4a15e1657a9 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -7,6 +7,7 @@
 #include <config.h>
 #include <debug_uart.h>
 #include <dfu.h>
+#include <efi_loader.h>
 #include <init.h>
 #include <log.h>
 #include <dm/uclass.h>
@@ -52,6 +53,9 @@ int board_late_init(void)
 	char *new_targets;
 	char *env_targets;
 
+	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
+		configure_capsule_updates();
+
 	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
 		debug("Saved variables - Skipping\n");
 		return 0;
@@ -165,17 +169,14 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	}
 }
 
-#if defined(CONFIG_SET_DFU_ALT_INFO)
+#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 
 #define DFU_ALT_BUF_LEN                SZ_1K
 
-void set_dfu_alt_info(char *interface, char *devstr)
+void configure_capsule_updates(void)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
 
-	if (env_get("dfu_alt_info"))
-		return;
-
 	memset(buf, 0, sizeof(buf));
 
 	switch ((zynq_slcr_get_boot_mode()) & ZYNQ_BM_MASK) {
@@ -199,7 +200,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
 		return;
 	}
 
-	env_set("dfu_alt_info", buf);
-	puts("DFU alt info setting: done\n");
+	update_info.dfu_string = strdup(buf);
+	debug("Capsule DFU: %s\n", update_info.dfu_string);
 }
 #endif
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 820fb252a3f3..1d7626e9f39d 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -11,6 +11,7 @@
 #include <dfu.h>
 #include <env.h>
 #include <env_internal.h>
+#include <efi_loader.h>
 #include <init.h>
 #include <log.h>
 #include <net.h>
@@ -526,6 +527,9 @@ int board_late_init(void)
 	usb_ether_init();
 #endif
 
+	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
+		configure_capsule_updates();
+
 	multiboot = multi_boot();
 	if (multiboot >= 0)
 		env_set_hex("multiboot", multiboot);
@@ -631,7 +635,7 @@ enum env_location env_get_location(enum env_operation op, int prio)
 }
 #endif
 
-#if defined(CONFIG_SET_DFU_ALT_INFO)
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 
 #define DFU_ALT_BUF_LEN		SZ_1K
 
@@ -660,15 +664,12 @@ static void mtd_found_part(u32 *base, u32 *size)
 	}
 }
 
-void set_dfu_alt_info(char *interface, char *devstr)
+void configure_capsule_updates(void)
 {
 	int multiboot, bootseq = 0, len = 0;
 
 	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
 
-	if (env_get("dfu_alt_info"))
-		return;
-
 	memset(buf, 0, sizeof(buf));
 
 	multiboot = multi_boot();
@@ -732,8 +733,8 @@ void set_dfu_alt_info(char *interface, char *devstr)
 		return;
 	}
 
-	env_set("dfu_alt_info", buf);
-	puts("DFU alt info setting: done\n");
+	update_info.dfu_string = strdup(buf);
+	debug("Capsule DFU: %s\n", update_info.dfu_string);
 }
 #endif
 
-- 
2.43.0

