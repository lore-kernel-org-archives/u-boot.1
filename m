Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55842C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2312560659;
	Mon, 24 Aug 2026 08:33:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SbY60rwdb-zz; Mon, 24 Aug 2026 08:33:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787560416;
	bh=zt/DyT9YiE5RZJ3eZgwCDUjXIYobOsN5rAhnWiJoK0o=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T0YSmSKs6VRYzntjwrbUXRzw/vMe51Wvzz3TtlXTVgaXiCjRunmF5PtMEaZlXeBaP
	 37H2tq6Dw/YsleuwC/elhVzKBGIULphP2HkUTmrydgNlDrNLtKKw04bdg5Xje3Noc7
	 tI7ZIFlc/3xYu67VLC1cjyvrSIrgaPcOcQRBrQPzqn0+KuVbjxhXzcW+v1sKvRagHb
	 Hw2T0K09n6EUkvi7q0YMoZfElmhk9CH7lsiqdn/sb1Huisr+mTppHg9Jm87RKjNfNm
	 faOzc/S7hYW1Gg/iOkcOBjWbou3tqnIJsXyiHII5YWvhpXaRyjQ9/hYVhugfIBpK3s
	 FfqG4gN3bvyZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B6A060608;
	Mon, 24 Aug 2026 08:33:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 413A13AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27D9D40640
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id du9ha3oSx6-l for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:33:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=iOAFLCqH
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 148AF40611
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9F7p9sXVnhw+Vh+faJ7h8BseZtiiXemUgbknTW9hMrvHspb/EP+c4FoKe3qkrBjbZ1tig7lIE8ErDObdoLfoxk/w51stBQFx9+vgP/hpa+fBr6vW7rCzhNuH1eLrnQBvfAq5cSWtwHg6aoRkKXaknPNNYiv0LvN3mknQlDU7BW947CEDCE78jmdhx+YMSalIyonxR+clU02/RUAwo3zJBij6TG7+8HBQRgkzRG6mResDXqjmgQlsz9jOfvRtI9iekP+T6vgNGXfZU0M6HODOMsKAkx4h5+k7hZ0JpxbjdR4NL+4e2X+xyNR+wcbpCq90XAHknNDLj1S3vA890o0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zt/DyT9YiE5RZJ3eZgwCDUjXIYobOsN5rAhnWiJoK0o=;
 b=ydvF67sxK+vweQfoxieUjz2Rgr0QGVxSPGZ9JXZe2HkvAajDUuWVo2IGmAynidsXDFs6ZaOo4kM/Cw1vyV74lhnCbFyky3do6xXm5Cqpc4uSW4HYauiyWavL6ZSNiE2SEhvZl3k7NKS7ubc+m32+zRVLnC0lV+90m5po6Dqx4U3x+JfwkGJGu6Bo0snGdJMmUkvMB9hGn9e+eeOoZuxcWt5gDwamjEE/lE3MAuZYHXPnDeWZsYr1IcA/BAwMRUgKDywxC+TwesDGZGUhvqZoBGfpNSOO7MbbMCxYYwKSRoR8ExSUz358yaFWVD+nEcxg2yqYEsDnIJoHRLFmMT/YdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zt/DyT9YiE5RZJ3eZgwCDUjXIYobOsN5rAhnWiJoK0o=;
 b=iOAFLCqHjRlmHdTmma00G1YumUk5vowa+Hvl0IpdrfeYmo9vM/2l1gH3r6oemKyoOjkf8UwnREcpjiwBYO7q5SGSCNZgVu6jYXBhJ3SiL/6AljB/VmP59866HXU8G8Jb6+P4PvgNEuQF+F49n+CGN/LFqA8jim0UooSDCOpu+zg=
Received: from BY3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:254::33)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:33:26 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::98) by BY3PR05CA0028.outlook.office365.com
 (2603:10b6:a03:254::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 08:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 08:33:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 03:33:05 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 03:33:05 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 1/2] MAINTAINERS: Use proper Orphan status marking
Date: Mon, 24 Aug 2026 10:32:51 +0200
Message-ID: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=O3YyRB1lJO761EYEjYw54jsJeh0c0ILFp7cLtwwyAaQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT1MO61ChHNmj19+8b1k9g2CWntVLqyUv/QNsepHBwnv
 qYwNC7c1FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATmeLOyHDqRlmg9ztPrgsz
 bT+G7BBRP96gMK12pmjWyz2Z9x95bZNn+J8tNOkVk+dn2UtlK5YvXbnyKmvn3LfmXmH/+6w2ZM5
 VnssNAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5de006-a196-47b5-cdeb-08df01ba5d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|13003099007|6133799003|10067099003|56012099006|11063799006|17002099007|18002099003;
X-Microsoft-Antispam-Message-Info: KerbJmRFZd8/xe60JG/6NW6uX4mvZIMECr1ga6DQHYD6ut+JFWvpIT631OcxjJIjeUhXnndoMrZA68N7PmTrIFfmVc+c7syYWzl0u6Tk+d55yDZiu89wW/UNgwER/yPK4uar5hm96oz3Cbm2CfkcF/Px4EIDUHfYf5yRe5hIHZvE+Lj0J1X8LMIFiv0S0haKSLcUltTGRBlugtAcSJdihgEbEUnkOQxal4PFEyz0ytZqGMBT34IVvUBWxz9GPG45awCQQmkffqZqZKwE3LIXIIHSwx8uNoK5wd7F/2u+V5M5e6TzU+l0LWHJUUB12+0+XsmFAXfeY1/0dttKZNg4S2Tva1HaCSY/fffxhVjGBVcCCuGrYM81A/6BVlqgR4cJAGNlscNgxyvLD4uyfzCyjUvnNfangnMaCQPO3in/7t04q3Pg5XLXwwSwHeQ9mWd1h3czoR/d+OHjXkcGT3YahUuuvjscUhrEvk87GG1mH7izxlOp0mXM0eP416fBDw4ZIXwtIiSwNizcWYXrX3iVg5ZTkSBxELtHEgXRo6XSEGgveZf6N5nd4/PLgaEuiyZ1+Fo14vRSHRLx60PV1BFMpCBsLq+e39W10G3fmrBa+osas0hfK05JHYw2BI0Pa+SIKKzIRMMehISK8IWPVL3AolSVhK/xjaHCRhmEsTSy7pM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(17002099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bWlJGeCSglfCsLGjBkM51ks6RX/0qqNd10WbCCHji3Lv8oI63rqF2N4pkTRf9foV0bW1gDcE7evgaVGxPGVzSwJsnDMH0bRYce/A8Lcg469+p1V6lRfzJmUuQLVE+Aaw7ZK1FDUKt0bSeBLtBXrGP2JkDQve5aTDIC7mbbQ5JKWjY9JMsH+ew6VEvrqyElNrD7LPL8UN+/APqwnMilA480dW4fLnJFZH4XWcj+3Fg51o36hwhE+h6ytXfMS7jN6eYfENZQ+k7cuuTR+xXHtpe8l6hcJ9mtO/iw768fBIF5t8IdDZlUOfD0f84ThY/KyB9g/lcLO+OUbONr5xeHM6GXbAAvEUROAPSYmhvzYtcGrcqdVgOV0HtuWVQqW3sbBDj3J7pOes73YV0lWHlVVcyIGTIYuYvucThG+r+k118lv7oUh8IWKexH/4alqHpK9H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:33:25.1704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5de006-a196-47b5-cdeb-08df01ba5d6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Orphaned is not correct status based on description.
s/Orphaned/Orphan/g

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 MAINTAINERS                 | 10 +++++-----
 tools/buildman/board.py     |  2 +-
 tools/buildman/func_test.py |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3fdf17f74250..e655790433ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1028,7 +1028,7 @@ F:	tools/file2include.c
 F:	tools/mkeficapsule.c
 
 ENVIRONMENT
-S:	Orphaned
+S:	Orphan
 F:	env/
 F:	include/env/
 F:	include/env*
@@ -1401,7 +1401,7 @@ F:	drivers/net/phy/nxp-c45-tja11xx.c
 
 ONENAND
 #M:	Lukasz Majewski <l.majewski@majess.pl>
-S:	Orphaned (Since 2017-01)
+S:	Orphan (Since 2017-01)
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-onenand.git
 F:	drivers/mtd/onenand/
 
@@ -1439,7 +1439,7 @@ F:	drivers/pci/pcie_dw_imx.c
 F:	drivers/phy/phy-imx8m-pcie.c
 
 PCI Endpoint
-S:	Orphaned
+S:	Orphan
 F:	drivers/pci_endpoint/
 F:  include/pci_ep.h
 
@@ -1608,7 +1608,7 @@ F:	test/cmd/seama.c
 
 SEMIHOSTING
 R:	Sean Anderson <sean.anderson@linux.dev>
-S:	Orphaned
+S:	Orphan
 N:	semihosting
 
 SETEXPR
@@ -1659,7 +1659,7 @@ S:	Maintained
 F:	drivers/rng/smccc_trng.c
 
 SPI
-S:	Orphaned
+S:	Orphan
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-spi.git
 F:	drivers/spi/
 F:	include/spi*
diff --git a/tools/buildman/board.py b/tools/buildman/board.py
index 248d8bfff188..231454dc8cd8 100644
--- a/tools/buildman/board.py
+++ b/tools/buildman/board.py
@@ -10,7 +10,7 @@ class Board:
         """Create a new board type.
 
         Args:
-            status: define whether the board is 'Active' or 'Orphaned'
+            status: define whether the board is 'Active' or 'Orphan'
             arch: Architecture name (e.g. arm)
             cpu: Cpu name (e.g. arm1136)
             soc: Name of SOC, or '' if none (e.g. mx31)
diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index 51c6855420ea..fce615ba8b83 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -951,7 +951,7 @@ Active  aarch64     armv8 - armltd total_compute board2
         self.assertEqual(["WARNING: no maintainers for 'board0'"], warnings)
 
         # Mark a board as orphaned - this should give a warning
-        lines = ['S: Orphaned' if line.startswith('S') else line
+        lines = ['S: Orphan' if line.startswith('S') else line
                  for line in orig_data.splitlines(keepends=True)]
         tools.write_file(main, ''.join(lines), binary=False)
         params_list, warnings = self._boards.build_board_list(config_dir, src)
---
base-commit: c8c1345985d4b1a566e1297b62cf6159d0803a68
branch: xnext/maintainers-all

-- 
2.43.0

