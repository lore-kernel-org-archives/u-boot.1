Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7481AE7DF0A
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 17:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EADB183F37;
	Mon,  2 Feb 2026 18:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="qUefDDTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD2A783D8A; Mon,  2 Feb 2026 18:05:36 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F7583F14
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 18:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkKO7Fja5bCqTwSW7aUjXRXySeslI3G2iA+OB1yGz7X9Nv5VZFcm6HmgPgeEyE3XC3g4V8UvH0NSwTWvAjyK4wVAAlPjjksxswYuJnVh8MoSYsSWNC3QnIQ0DKPATO7A693ce0qjPaZpGif9kKEvXswEEhzpmp8SlPd6AVb992E8GJUt7RajgtOB9swddxTjnE8rcUreIxYP8QfArDcMeo3H3IE1FzVxjVKyMVzaeax2ICB9ZlytpcA73DYLkjO8PIyXuMUNgwPxvTcntdjVv1dYFksEOG1xAoY/UF7CnWkXbr8Phy8lW2sCG2HKm/k9IiqAJb8hp49MNIP7o0PuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6u9yIaEqq75HgQJQMaHcsCPf1VD3Dno6DrjUpE7Xkk=;
 b=ew4Xl8gfcUD3WFYo+HCtd/bFii/mKPR7T3kaoV20tyY/cWXyogCiZJ1Dmin3k3wEbM1dQJQ1omH7Lb6dYaWmgScfactgwSOIQLGpLYjuoWe/YdLcByIlkyEXQcOtyRil3B6Y+C9eSMKPB7ZNZ1282qLG52F44LKKgDEYQM6WJgtg1oHtCexUFlsXoZqfQ/He/b1DLjeRqlPYrV5uWlsZeRAh6o0s4R3LmRd6IwUY5ZrIOB+tMoJ4FKn+BAjmc9kQoiGTP2zyhJ9w5WBwuLcZtrETdL1o3hC9Z02Jk3wID7kPYN5iAjd2gPJRIpoPc7Ip+FGw+k9u2pYV/eYC9EgaOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6u9yIaEqq75HgQJQMaHcsCPf1VD3Dno6DrjUpE7Xkk=;
 b=qUefDDTtEuCoTGfL0kIjXDjROLoG9H/P2c6IGrsY8Wu61wKRM6HlPALZ9SDWVhgBgm08830084HdoQxmobmHtNwgqIHtLbsEfRQrPbpMJZ08KVsqbxivCe7++HoHZPfq/4Jtvq4F85BSVVMarZgW6RX9Lu/GP22VsUR9mdhfSpBLHRpp9/sWKXkLF2TiDXhZio57uQ5R6YSrJ68yofsZ4IN6FzUllPuYqJtU2fHFtuuCJr5MuPJLkq7cctF+0yTs2MbGfSV5+d1idqvNHjO56n9VEwSMWDyo1qUXDa4Bt4a2BRKLtrzrMNBUz1y5UDnA8Nn5OFAAMZMOgK0Fd1oABQ==
Received: from MR1P264CA0202.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:57::19)
 by MRYP264MB6637.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:05:30 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57:cafe::47) by MR1P264CA0202.outlook.office365.com
 (2603:10a6:501:57::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 17:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Mon, 2 Feb 2026 17:05:30 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id A941020AA4;
 Mon,  2 Feb 2026 18:05:30 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi,
	jonny.green@keytechinc.com,
	raymondmaoca@gmail.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH 4/4] drivers: crypto: add software ecdsa support
Date: Mon,  2 Feb 2026 18:03:07 +0100
Message-ID: <20260202170307.217200-5-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202170307.217200-1-philippe.reynes@softathome.com>
References: <20260202170307.217200-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|MRYP264MB6637:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: af17c1cf-244a-4689-2651-08de627d4582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KvbTq2WremCc+mP5SKC7h+YTc4rIEm0u17pJu5APnuTBt/01CYZbfX8IZbKB?=
 =?us-ascii?Q?zJuYYVyIxvgALjcwu+xFTBykOPMPzOXF0dUe4bbk7MvamOiqrvHpZyjjtsfp?=
 =?us-ascii?Q?7J4dBZS5Nasisrg7tk3SmuiI4NxmPwkLgTvaGtYa/+9pC8rA2PPGE+oVwW5b?=
 =?us-ascii?Q?rNYZKJgL3dnLKRrSVvjdzJF09HN+/FKwnzfNSfuC7e4knQzvKNnTBwCUKOfW?=
 =?us-ascii?Q?KifH7oVOYPbkVNWXTbVyCUoRQbRXKDGjFv2VFuKzzGuhLmkhKGrVp7SJ/q/q?=
 =?us-ascii?Q?/FuncmDBdlHVyE7UnVV3Z/PgANlsqoOCkpmd5hrJYKQgKaHAsWBQQn/S2C02?=
 =?us-ascii?Q?la4OvMMHsXedj5C9sa8PJ25YfEXgWE8Xg38ZghbD1WesE6HiBHRBz9HTqu3t?=
 =?us-ascii?Q?Hr1VbssbFRBkTzlKpmr5yefT9BzlHflfXNsLUOd7SJcswHr5g8gGRrGPs7lc?=
 =?us-ascii?Q?OnFBqD3IYM/t6lsDP31IEhUIYisajtpZ6lyS6uRx0rFC1qLnlvYjzSyDouou?=
 =?us-ascii?Q?/klX3mLYYFs+eHnKuNGW0FEDbpVtEAr02OnmU4Bd3mvjO2FlzIrZJyqvxpPH?=
 =?us-ascii?Q?dzFPKxHzBvoB/cASWrpuek0f1eAze1sm743LgaGbfQ9ccTGTwc1gJ8D8h3hq?=
 =?us-ascii?Q?xmbCIF26Z7HqEunW7TPe4a+IBqDAE8Hw2nYdOixwbL0abvhcyVXdcqcuFGJD?=
 =?us-ascii?Q?kbA9NNWshcY+Aw6UKN6ccTcKsVT9aoLWN8bxi8CwYSxsXANWxk202jJEm8uk?=
 =?us-ascii?Q?YSqfRy86gOBhtgXu9Rtd8Zpt5coOHULAG98yD3Ze31cXYpENKD34wV1educQ?=
 =?us-ascii?Q?w4ty3LGrcDkMbfA0zE4LZo1Zfe3Cmea45u2PH6dJKnGTtdW3NUxO+uLp7DY9?=
 =?us-ascii?Q?021tk4rKh//FTSbmx6jjuPUls4fncvkpYaMbPf7Jf33qYaNV1+bfXsO01emP?=
 =?us-ascii?Q?ibFanh3KByItkcvfv6JmO1cCTF5fi9Zp/hmhD9If9md9+jsoOj6Fds+1Sloe?=
 =?us-ascii?Q?1VzH8va9byjFJ6JXRn5Ygv3QFLW530VBDqH/e8MznfAS3eLjPZQAPlmy0rWX?=
 =?us-ascii?Q?ke0hWVkFweu315wuM838tMlEVMV67W/qLm8LzRyssp/2+AnB7zLRT8/nYIL+?=
 =?us-ascii?Q?kolvkcPeRXHBmf/M9fft+q4KwAwN9ADUWRt17AanWB/0o+3Fmta4pAevvkYp?=
 =?us-ascii?Q?w5c5YzqiSmSoJM8YCtDfynezwyiJOaiNVPMpHP//TtPkPvDz04snJHzS2RyW?=
 =?us-ascii?Q?dSeBSN14L6UewU/rQOEDEZTbyWWp209QN5XqMJtnSZ7dxzDNjGLFIctt+jP+?=
 =?us-ascii?Q?If1sXLLJbX5Ird1Pp45MninY/wJm2NyT6deCRxDJ36K7iftgRV0erldmwG9o?=
 =?us-ascii?Q?jzHqYpvxlHpMJueTFuNZLQwUYaqVykZy9ErHbXTwHLwkmplzQMJ3+65Z8C8+?=
 =?us-ascii?Q?XjQ6V+vL9ToJVF5o3Dx50jC54B7wW2hBkU5yoR8FJIVHcXTlMaik6ZOUIaBe?=
 =?us-ascii?Q?HzY8m7PQWoB/Qg/1x8QquxmAaivsO0HkYYBWNUQgG9pY4Tj5dUin1xNIy6Db?=
 =?us-ascii?Q?VoJzOQ/VviMaiCjYiYOPXUrof5d2uksxM3iB+G3KA76p9k3eWQWcC2XwIZae?=
 =?us-ascii?Q?1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yVK+4JecGJ1/JQPwez4Pm2ewWu/OSwcx3eQCRUpLR9LZC9hgVJ2YjxlCj/U3AoAb2Q0VimHFt1Lmdaz31U+QjDaLxNoQF4ZJ5yob3olxNMJXK+OcAVYsMP5k8wC+K5i/58gptTJfNbyq28yABo4YEpBUJIZ66Hvsw4n6NHmLcq0Wm1QzV7X+fvRhcRJH2xg9D1X7V5L74HObff2w0vgSbHKPlggckDtgiJ7aC616gzpbUwwyb4hykxuHdEbGBwTr352kelLNvF1wqczUZZ7Ytdv/+L82aBVcAJPMXQ4xPRoKyAeedUBi6yq3dbPDmht2QEfmZTmEvL2QYq1/daSeDy2Kb8lOtGjyc5enkkDNkuEaZibKufrevKwEUIaUs0mO0SmJlyRBfhr61knQdtHskp8fe0XRb1VPIRpFHlEU0CddzODmArI7eC6FhsoXO2Vm
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:05:30.9094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af17c1cf-244a-4689-2651-08de627d4582
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRYP264MB6637
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

