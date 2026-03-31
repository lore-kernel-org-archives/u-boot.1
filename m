Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E335AFF60FF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF6D48406D;
	Tue, 31 Mar 2026 12:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="ojeVbFIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF1BD840D8; Tue, 31 Mar 2026 12:01:00 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF8583F5B
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvsC1mgxdvDSIcJALXnZB7A+5LVA2WZ9bK9AU6s1LLZ7Dwh7WVK7YzYsolUNm/ABWm1v6gfqpWI0V2Pl71dw7/H/9wZ8Fm6X9cf733J3FbM7RL5ltN+pkukkac430zxGrJwCF4wZw1Z8M2qDVu3ZeAcO40Gsw+dowG5LRJ+D8cZf97TuPbZybHg5kYFxROI1j3MLAu2fujNW2WWce4mBDPaA5PeoUoZd3QYtVubc7P5GFS8gaTipBBKrktI1HPZQrV2nkwI3y/XHsW1E+1y81FkgUATAo0ktgbGf0yGQ8wXZcq2kgX0LlnHKWQGUoTbdoAumZ4XHrGcSG60o37p5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPSLmx1Bisqa2SmJ7Yq5dRiy+BWoM7nx9IYnSOVWeLM=;
 b=I0q4gSzwt0/JVqWq90UhGzWDbdRB9hUn1HD52GWl2NqyqAWCeSXUbyiVIvvRKm8TQvUM6lMQzpYVJAyywQu5eQ3wQY7yfhs2YUzSqQci2Fe0wbFciHIaSaNeeA0Gbj3egDAwsaDUcENS+2pZWMckAhOKh6mmK+YnM31mA9gjLnSoGFZSttvTIFEDp5+8P1HM7UPBFKipSfSLP59otly4VT3SpsUtaXVRA50gB6IU/n9E/FfFfHzVkwANmoTl3cu4t3z5+ClEJV6oYl1zx7HmNV6pnz56dv7xEzhhGfOhKGhTFJIoLla4Hl5hH/DMbdmb3TSwR2u+iUbecIhlspOPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPSLmx1Bisqa2SmJ7Yq5dRiy+BWoM7nx9IYnSOVWeLM=;
 b=ojeVbFIEN2yNCJnz29xyZYUXuHN8iF1Polm5IazxRbhqrhaZz9xjgDVe9WQHXj0aFTCPGnW2xlgerwd4Oga2gKLPuyIm+WeR+zaRmwow6s8EIAUh1hSsQ06n1MtVskjm41d73pZEXqM/zcfQESf5MhzHVg5sy0KzSuVSRAMZeK1Rsbmj1PNo+5jXcrlYZlbVv4ob5af6Y3+9SkoMvyV/PyQSrghdvyrV6lYfx5FblS68F94/APlP3qkoeufXmYKdixdaifzz32CJfTv7luKIoNxRpQhyYjuCMDmzxPvBpG+JRbxyRlU1N/ZtRPhPGEpKa0JZx0FCKBGUQDtEEqnsnQ==
Received: from PR3P192CA0015.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::20)
 by MR0P264MB4652.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:62::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:00:52 +0000
Received: from PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:56:cafe::d4) by PR3P192CA0015.outlook.office365.com
 (2603:10a6:102:56::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019232.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:52 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id AD6882092F;
 Tue, 31 Mar 2026 12:00:52 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 04/15] drivers: crypto: add software ecdsa support
Date: Tue, 31 Mar 2026 12:00:36 +0200
Message-ID: <20260331100047.34618-5-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019232:EE_|MR0P264MB4652:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4aea3a8f-0099-465f-5987-08de8f0c64ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: CU+8ldVyNAA0C1xWVxB04VhIHwsj5/funm3FxND5e0oZL7TgtgZo64OqFXZqeZs7iG8hW9bTDktfxUnaQglR5GDUVUyjUJgCNmHR1kroS3CX4YsTZlT2VzUuOuHl0IfCGKqU3qQQgZiXErQs58H1RJqNQuQV9q17X5nllIAokfUD9vCnzWQaB6qXwk99/UfVd6L2TRuZB6oYqFTy2KoHK2k+mZHoIQAyt6iD0nhRGtiO/Denx5gJcNcDFAOfbP2bORP7vZdMmYuTQJdIwI7/Qop3INzVvaUqCTGtqp0nu73AFaNc9Qm36Gb311WfsEdDZTBBAb5odS06bVV6rNQTBh4tiAj3rp/omoTf8+igQUBCbzBbCTz3ojAwVFszJZA3hQu0HiibRQehCO7Ix+lYq9iYo8T/EBXu8Y5sREezZZ6XcOuT25Hcy4O7HaACICTbhOQDYkI2lqdta+nkcP1pLS+Op2ZX/GTtrQQH4CwSo9sFALrIKvwkIdfnouynsMEpfbi8Spb8Wwvede14YsqV8EI7fIYQNHIBv53uQbkV+YCgKuRq1nD0Q45i1CPXHcIQI7YsqxlCRjr8J70Dy9e/GhNpA1Jh6WYLn+Fq04Qu2N7BC6ccz+eJFKAbc3L4nUt0r7N8NBICN38RbXF67KpEkh4HAKRa503qPpNsuNejmudhnjVkJqdIOkMEnbAZZuyfDsONHmq2H1dzcjZBEuz/SdCA9EsL0lSuYYtV2aZ+iQU=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SGVRdIocNAmo3NuwTOADvY6F/Rtz1z+KMJWfWPrZTL94amGuKQnvpf1FqzPPh2tqtXu3YKqHTFOy2XPFVEeLyb319Sixa1MipbXSu1p4vRPByi2kyTdHpfVTOeQrXMunmKpvf2yD5ar9cYubXZPLTrNyUa2/kM4UJWOv1UG2VCM9zHlackjyXQpZyO/Q28HSxJd85NDn1kuzMbL3E84faHDRWEH8vSF9iL+O+Jb64PSqZILEaii4RmVezm64DKZs02jYW4gRubfliL6XO7x1LkKH+3fsS9aAHg/wGYKt1LmSaFDs6EouEB9D1hkUVgZNeA63HpnlgjwygLIY/2iiY0HOv15+p7tWWIiL88TNYyxB4+j5tm6Pd3dQIepI8pAiSvqg/FD7FrjoxaDEUy3xH1eM8W7YMffTfjDpY0QJ0yWtpohNjvP2vPJMl0fkyj3e
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:52.8421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aea3a8f-0099-465f-5987-08de8f0c64ee
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4652
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
v3:
- add depends on ECDSA_VERIFY to ECDSA_SW
- change sw_ecdsa_verify to ecdsa_hash_verify

 drivers/crypto/Kconfig          |  2 ++
 drivers/crypto/Makefile         |  1 +
 drivers/crypto/ecdsa/Kconfig    |  8 ++++++++
 drivers/crypto/ecdsa/Makefile   |  6 ++++++
 drivers/crypto/ecdsa/ecdsa-sw.c | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 50 insertions(+)
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
index 00000000000..50b65a904ce
--- /dev/null
+++ b/drivers/crypto/ecdsa/Kconfig
@@ -0,0 +1,8 @@
+config ECDSA_SW
+	bool "Enable driver for ECDSA in software"
+	depends on ECDSA_MBEDTLS
+	depends on ECDSA_VERIFY
+	default y if SANDBOX
+	help
+	  Enable driver for ECDSA operations in software. Currently
+	  it supports multiple ECDSA algorithm.
\ No newline at end of file
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
index 00000000000..89ce5a3b888
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
+#include <crypto/internal/ecdsa.h>
+
+static int ops_sw_ecdsa_verify(__always_unused struct udevice *dev,
+			       const struct ecdsa_public_key *pubkey,
+			       const void *hash, size_t hash_len,
+			       const void *signature, size_t sig_len)
+{
+	return ecdsa_hash_verify(pubkey, hash, hash_len, signature, sig_len);
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

