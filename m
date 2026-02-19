Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C94E9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F10E83E36;
	Thu, 19 Feb 2026 14:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="UYXWybwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A9B83D5D; Thu, 19 Feb 2026 14:26:17 +0100 (CET)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B51C83DBF
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOda8II2MzTrBByvIAkdXxGY9UTgjwfRHlk94CN0TSso+YGM1pHR6iUFNP04C2oq0scweChQVDOZtUOrvvDd37RijOgADVCeWFTM57XwjDnS4KUXQvL7f9BjRpjbwPxXQMdjiy+iWlx6iZ9dOc2k881+FGP+h269bWKbbPXnjCwY59XWftd+HBRbticb4CLWmxI76CkVeRXCO9FCxOip8b1/ip73vwIQO1+YcWpGIwlULJUjkXKQfHZ6QVUTevurx46Lqs0hIbASGEOcsRQ5DIsR1S86GYLn4hwQPjGLlqj5ZRP0OAsliZ+A9keffhNXeTiJ6njSuPS2Lj/begbKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBL8E57k7FsFTGOKsaBK7BrNVeyh9zIF+XiQgKy2AAg=;
 b=W4hFdzqEeOBsPz2viiru/TmeGZ6jl43IpEqEyHwOG0EEUm2Z86LcwGQgbuxGRYTo/h+kHQXkbj8Li5xse/zuX/JT2qU3ebSGYmzO7mYiL1dGCfuNvm7VOXLT83wCKO17OmT9+qNCLgM5vJdceytBmMPEO3DgqXdfp0L31Y2QddsiDHy+U0mcY/EMJl73BAYco+5oGfkb0Bq5efcwQHZHwo92mOiwO2k6uiz7dibaDTwfu2ZIPqVkg4vvXWuraKD+DpxaYd1gCVaC2Su4ytTb9NCMxFMhkaTstGlxKCCrIdcR6oX4oG1h8tQeXVAj4pFSFJAByMX3jYD8nnXvWhO4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBL8E57k7FsFTGOKsaBK7BrNVeyh9zIF+XiQgKy2AAg=;
 b=UYXWybwp4ltBqSHaZbC79ym7Oqsr+53yzW596IsnPqnvEXa/u41NaBqfUwrOU1qIyxR35afQVjvhQfWRjtsn4uoadCEPgj3DpxxXMmEFxx/SEEIKCevdJZ2v2RY6F7v+pch7ScEYTL1EoCrO64wo/Yrhk4WRUbkEJK9WBllm3VcdBx2KuVdwrvyyaS/zVqMgJgG3uCNVCJEZ+Cx5E6Tw83T9tfnD8XZqQxoDMN4Yb/5MTvs89PDc7WqK6ZEz4znAF2IAUiYLY+BJpLyG6BtNiXZpVM2hmiIg8Js9lvauHh2Gd0DTc2isM9ole74wzQj4nuELkOB8xM3csJQuGkQKpQ==
Received: from PA7P264CA0349.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37c::13)
 by PARP264MB6078.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Thu, 19 Feb
 2026 13:26:10 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c:cafe::73) by PA7P264CA0349.outlook.office365.com
 (2603:10a6:102:37c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 13:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 13:26:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id DD555202BF;
 Thu, 19 Feb 2026 14:26:09 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH v2 4/9] drivers: crypto: add software ecdsa support
Date: Thu, 19 Feb 2026 14:25:47 +0100
Message-ID: <20260219132552.1499698-5-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219132552.1499698-1-philippe.reynes@softathome.com>
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|PARP264MB6078:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ab13756b-b79b-4ad2-e34d-08de6fba7205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|30052699003|7142099003|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l5qLlUJHHsAKWj9lFALaPm4/qTs0CCWq+FQD/qjZBvCS6Pfg4Zms7VPNbB1k?=
 =?us-ascii?Q?y0UqeCb9ToA4K4yL2crKTmALdmJvK+5WcuOO+VRg28bGjJn2FAXd221+sK6o?=
 =?us-ascii?Q?9KDbr+cvPmW0qQxTcHfZmIsFkhRh56ddiHrQh/9yt6gD6b2lcB2dQz8cCrHD?=
 =?us-ascii?Q?tIU6jTR/ALpPoVfuOxUetVZv+RUs4rnMT4rfv8RI5uUhwl7RKAwyElyH/eG6?=
 =?us-ascii?Q?Jizbq0H6N07Kqn2sFBDoQU/h4jWskm+DtLfv6ohd7HU0z8ANn1kNn7GD6zpC?=
 =?us-ascii?Q?T9A3/Vr3VFrGN0OT5buPNPWXvlEMdASrFovISRMxseC74RrmPFV/P7I642bD?=
 =?us-ascii?Q?wVctBvhc5UzqkpqCL1/cNrjbR/aelpU/J4BoZxFpvwFnr/U7SL2zrswaOQ7z?=
 =?us-ascii?Q?LfGGtmxQCMKAIZ1Oh4cR1HUCrUFOyRa4kbkTYYnrAO1HnqhtMs+8Ps6JFL9X?=
 =?us-ascii?Q?XjEQ//vhNu+U0WJx1RnDCSuq1XJjf1/FLPa02bEwjIU0KzLGE+lJ3pnY8W5a?=
 =?us-ascii?Q?nIOdjaAHq6foKUbkAK1m9oj1e0NvQx1R+vnAPmyoPXHB3RlxCM0KWf/+lpfH?=
 =?us-ascii?Q?rj9EFAgYyJuo72dCcTaWtF4DWxx5c3XRuvVfP5VbgwJJdLxv//Q4aFoBmjxw?=
 =?us-ascii?Q?GmbpN/SpCbCxPZgRR55UEM9o2mvEySISbZx6gAzvj1jKoJh3pAw1YZz0lyGL?=
 =?us-ascii?Q?O3gpMilv600PPUn3Elo2VxiYqB88+cq0fAdAM/H68Lx67qxjVw1+neLS03M8?=
 =?us-ascii?Q?mOe2Qu8UHQmZuPmXFcmL08+DI32BikJY5gkwIdWoFA7O4s+wUrb+zXMRGmSG?=
 =?us-ascii?Q?ObCTnNFqTcbVxFDqM9nNECUj6vreZ08Hzn9yn4AFhJaCWgtlgqtFarbzD/7G?=
 =?us-ascii?Q?ijsXM4Mk2SW5ibS28hGZtY66Ktz9mbSSycMSgPFdAtSlPNYlv5aT0XL9F8xK?=
 =?us-ascii?Q?FLNbkU/BC1743xeb3mvH/6vwngzvkhK27Iyk6EM4lg3Pjno+1u8GfW+fv47O?=
 =?us-ascii?Q?8i423CNxLQYrgdAZzWL94aHvzj54Nk7L6fB3f2CbKf9k1TXySscQOQLQnsdZ?=
 =?us-ascii?Q?yqHs9j/zhJIVqkIctWRdU4aUnBP9RsFsLrPp9R5elgI8+G0MXrwqxWqVp9ot?=
 =?us-ascii?Q?Ra98bygr5dWbXAFOgfNd+lYez3FCI6Uo4ndO/WJn5j/zJy0v13pe6hUYU1HX?=
 =?us-ascii?Q?C0w7Gy9O9hEOfqAbIaAB9E6Lo5iBTQW/aosrI74ThBPXrJk8oMYPWC2bM0N1?=
 =?us-ascii?Q?eTdXLDjPs+40dJnt0psmjimcxBueKOpZmYQ7ySVCFZBAJ75n74Ik9t6WISEb?=
 =?us-ascii?Q?5NN/1HTXsyAn8GqH58mKJR/QzCdYZVeYFSx3N4oWn6cAqAoMsCdQvsFyVMbQ?=
 =?us-ascii?Q?w++EQklz/ZTIiAdnk5OBFC7E2XeVXP3ZdZ0NmbvJdauB4f+aea3oq4Z5PZ/u?=
 =?us-ascii?Q?I+o5Y+NiHK5AuhpBhB1dEvabm/g8hFN3G2W4/mfog3ddHetsZnqdBHGwHOGD?=
 =?us-ascii?Q?GLKI0Wz6FFMqOoL0iSzHeLK8kZ18DmfXg2kg3C2nSYdkSdVug/HSNNlr0x8n?=
 =?us-ascii?Q?52BlLG0h1sgZR0wxhhSCBAd1+wKhEerWqD5VCgfhoP55/VoQmZPBUpLy52j9?=
 =?us-ascii?Q?OA=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(30052699003)(7142099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AugNlmINpnkBb1UbvFquESIDkIb6BKQBicEptVWpVfEP4p3H2ZN2XVxWizEk1Mff7H3Hs8qlAqtpNmPPPWkWgCmbo+GifF0CFld/+PDqe4ecSSwE7Sld6V7rk7A+LMmGyHvbO8Gi1eSeJoxjAT9sDwbzG5g5VutqqboPLrG4YvKJn9dMGWr58amvOZ7+noW7+Nf8qj1UmY+RTmu3hXi/HWcjlLToRWGI7E2SmLZzOZtYNuRSAFaMBL9E48mhpSIRUrIlhNrOIKJhicH0XPuxc8tTurT61/DibPH09uqDsWzLRjlgJL14bdAZli15zn0CQ171LCd1DoUPYmIbsK7n/pU5cWe7ULTr0s5SdIofRCnHVZoiKqF0WHF0IjzBttpvdKpllnOLVXTPDB02vt4zighEO3W6yZCItIpTn4zkYARLJIJe7cYnRb41PqhNecW3
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:26:10.0314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab13756b-b79b-4ad2-e34d-08de6fba7205
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB6078
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

Add an software ecdsa driver so it is
now possible to use ecdsa signature on
board without ecdsa hardware support.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- no change

 drivers/crypto/Kconfig          |  2 ++
 drivers/crypto/Makefile         |  1 +
 drivers/crypto/ecdsa/Kconfig    |  6 ++++++
 drivers/crypto/ecdsa/Makefile   |  6 ++++++
 drivers/crypto/ecdsa/ecdsa-sw.c | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 48 insertions(+)
 create mode 100644 drivers/crypto/ecdsa/Kconfig
 create mode 100644 drivers/crypto/ecdsa/Makefile
 create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 0d58e3910fe..cf49e5c0f7e 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -12,4 +12,6 @@ source "drivers/crypto/nuvoton/Kconfig"
 
 source "drivers/crypto/tegra/Kconfig"
 
+source "drivers/crypto/ecdsa/Kconfig"
+
 endmenu
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index e4a4482b7f3..8170e4cae9c 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -4,6 +4,7 @@
 #	http://www.samsung.com
 
 obj-$(CONFIG_EXYNOS_ACE_SHA)	+= ace_sha.o
+obj-$(CONFIG_ECDSA) += ecdsa/
 obj-y += aes/
 obj-y += rsa_mod_exp/
 obj-y += fsl/
diff --git a/drivers/crypto/ecdsa/Kconfig b/drivers/crypto/ecdsa/Kconfig
new file mode 100644
index 00000000000..308824d8421
--- /dev/null
+++ b/drivers/crypto/ecdsa/Kconfig
@@ -0,0 +1,6 @@
+config ECDSA_SW
+	bool "Enable driver for ECDSA in software"
+	depends on ECDSA_MBEDTLS
+	help
+	  Enable driver for ECDSA operations in software. Currently
+	  it supports multiple ECDSA algorithm.
diff --git a/drivers/crypto/ecdsa/Makefile b/drivers/crypto/ecdsa/Makefile
new file mode 100644
index 00000000000..8f9e5a767f8
--- /dev/null
+++ b/drivers/crypto/ecdsa/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+#
+
+obj-$(CONFIG_ECDSA_SW) += ecdsa-sw.o
diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecdsa-sw.c
new file mode 100644
index 00000000000..0d526371ecb
--- /dev/null
+++ b/drivers/crypto/ecdsa/ecdsa-sw.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+ */
+#include <dm/device.h>
+#include <linux/types.h>
+#include <u-boot/ecdsa.h>
+#include <crypto/ecdsa-uclass.h>
+#include <dm/platdata.h>
+#include <crypto/internal/sw_ecdsa.h>
+
+static int ops_sw_ecdsa_verify(__always_unused struct udevice *dev,
+			       const struct ecdsa_public_key *pubkey,
+			       const void *hash, size_t hash_len,
+			       const void *signature, size_t sig_len)
+{
+	return sw_ecdsa_verify(pubkey, hash, hash_len, signature, sig_len);
+}
+
+static const struct ecdsa_ops sw_ecdsa_ops = {
+	.verify = ops_sw_ecdsa_verify,
+};
+
+U_BOOT_DRIVER(sw_ecdsa) = {
+	.name	= "sw_ecdsa",
+	.id	= UCLASS_ECDSA,
+	.ops	= &sw_ecdsa_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+U_BOOT_DRVINFO(sw_ecdsa) = {
+	.name = "sw_ecdsa",
+};
-- 
2.43.0

