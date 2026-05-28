Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930F0CD5BD1
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A60980087;
	Thu, 28 May 2026 10:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Iuhi5fes";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6038484869; Thu, 28 May 2026 10:19:29 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7392D846D1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyqPpeiq1CAOdS4/yHoQZLMgHm47sT9oq9VZhBcITu5WfTsPRIU7HELOpjWNamtLPpG5040M2edChFcJdKbUtcAEMbAPBdQq9kbGwLbQmFE8Bma6DFjZYrCjjZTGnjv68kUy3HN94ZOCP+7eyieyXaqHzSX7Kmu6oJW/Bl1EA6Abq71lGlKi6gtnDHKi5q4NEiyp8AZ8ZeUmh9pCDs1JqFd/Yy6WJWx0XREhomdpaAJyM4RLwZ8yxzI3lKMNCV7RObVadgeoFVR2f/fXWjAvd3ZGNp8cfBQvY3QdPEFrgkKQ94qpYb/lFL5gcxTPILhi4lp+n6R055eJxaaY/9LHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwvCZuKSn3NoUf81fZJoQYO0EaNyz6d8c6rCz5NRmb4=;
 b=HWNqGzGmejJJDq5SQgz3NhWl0eTeBwV/vS4YrN5IEVoE4BjgRxpX6UuTDJmipZatZQnt7E9LPPwIMj6eSj9f86MgiWWFuZZdB/cu/vxGrJ9xQHchBYhiyLYOYTMPun9Reextc7T7PE6wZoxtOIaBZ1uv8fWFOQBSOQLEbiOletzPFn22ZGjY6Dbzl0/A9gQMXpK6YHZwBPhE/tmbriDRBn+EOuW9F/n/OnzWtkU7oUi/nGWUDUq4sPc1IUv0KNkwzwd8Vkz7WmiS8CgUyCeGQTFevIeP82zIs/MZrYQxDlFMAACXNMcgjJOHvCusOSHT8RLCddDbeo+OEGvtF9kjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwvCZuKSn3NoUf81fZJoQYO0EaNyz6d8c6rCz5NRmb4=;
 b=Iuhi5fesUSk04Uz9l6yTfpOQk+aWQTmIAlVRzJ9ViA77+sIcQm2XfaTz3KNRtusIcnQkEBweATb4uGwhj7/9YfM0oPfpibEWRMJeP4THD4P0LWaAQEDG7uF+AKlLmxcUP8k42MjP2575TzCwmIJAeN6GvQfXfkLlLpt0mRfYYv3mqC+KNlYpBlsBeiNuRL1yUEC8bvoKvfizVLtIdkW1iWFhUUBQZn8Y29Jm1yp/re7k2k4o8hGP9dD4jVM849tp83myLocspepe01qRGkrer17UkQ9owrCBHM7XWW3FvmREo3xE+EkUBL66mv1ku4wW7gOHkjfBFKwrO4qX3+uvpg==
Received: from PA7P264CA0028.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2df::7)
 by PARP264MB4941.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:19:20 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df:cafe::25) by PA7P264CA0028.outlook.office365.com
 (2603:10a6:102:2df::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 08:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:19:19 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id E27E420C30;
 Thu, 28 May 2026 10:19:18 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 05/15] drivers: crypto: add software ecdsa support
Date: Thu, 28 May 2026 10:19:06 +0200
Message-ID: <20260528081916.11355-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528081916.11355-1-philippe.reynes@softathome.com>
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|PARP264MB4941:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3e104c4a-ad8c-440d-ef75-08debc91d0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|30052699003|56012099006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: +AksFsXzJsbOu/XATZwmFHS9Sn1H8KsNTFTB/7/8MnNqb71KIJc6Tpn3MhPgPwOcZlzf4cs87qdPf6OU8L5rO7VXLOjymjdLmv0dfN5f9cWc7AsFsiiA1++BvtcY0h9YpHfajZPVAzW5S/DPeXFENun5BV9YkQjJ7HtRDreySA4K0lcIUDxpXV/X4qnTmB2+z3fUTSAIs+pW8FpyzBOLrmf2JZi5BcEkRTFCERS1geIDoO5I00U/J12rRqA/pCaDcJiUIHs8bHTgg2USeQpknw7lSQeU6dM/SESLLBgk/6L+VJ8Wla3G6htnzxJhh5RQXnPMdHEAYFxwhrPzagxydtrzqV2y1V310750elWiK88riVHhI/q0ZSTuFILVRsj0P5smU76PIr+x8zW2ua6Dw11PkxmelIU2IpqxKCtB2JKtCd+ZNljAVsKDlog21cE52hvz863tx6d7SNuj4C8dYI5WtTgFLbt/qUrR8BK1pX710CJgSLY3t1teTdSC2mOsiVhIaM1JiGK+qeLlEdcAAiF4AA5drhIt8Je71SBL6YEwZgqTZGi8Xg3QNVnDdFCm25TxWZMxCnE7dzF22/nbr3e4vOWqmoA58beZ35MfRnpXIVL6GDPDneLszeE8agymglIpHHDiiIKkNiusEPapW8ySFWn1XpXZW0Amg7B0BACuCPAMQMskNj7WQ/vY6HrN
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(30052699003)(56012099006)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K838amHRzUvafckSc9vv0kWD7VBuAlG13H3/guMP4yHyjoU9wDmwHYYJAYfxcfix9GR2eg8W5qm+HXmxgY/J/XpLtbtsHWOyBnTwKXhk2QfI7VD17GZr7r8jvDRVI63c/gKbXVNkLnG0oQ5gLXqQHAyMXMS293F2jKqoDI0eQnf0UMKYDL2/F5YkDIWyONXpvsKZliw2/pP0Mq0NiXaG7Y3Ppkqh94BVerzU6RBsz3dxd0vusNJdYsDYJuS5PXfF+bgfdV3F9aZpPziU2aPjqW3lm/o5rYZ9ZrOdzt+FgLXUtMWmXE7YoUC1y+zoo19xHSW2TZ1p56xd8tmfyUsAyaIrzETGDFB6TmwriIEY+vgf+zrthuISsGfvjalkiNLtzazj0y2mniTZTmzS3hpqwiJ/yuEpita00FFahlmKQulMhpHOT+nnqkoIE37BmrYH
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:19:19.2202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e104c4a-ad8c-440d-ef75-08debc91d0ce
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4941
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

Add a software ecdsa driver so it is
now possible to use ecdsa signature on
board without ecdsa hardware support.

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- no change
v3:
- add depends on ECDSA_VERIFY to ECDSA_SW
- change sw_ecdsa_verify to ecdsa_hash_verify
- v4
- use ECDSA_MBEDTLS to build the driver
- clean include (change order)
v5:
- use $(PHASE_) in the Makefile for the driver
v6:
- remove include u-boot/ecdsa.h from ecdsa-sw.c
v7:
- no change

 drivers/crypto/Makefile         |  1 +
 drivers/crypto/ecdsa/Makefile   |  6 ++++++
 drivers/crypto/ecdsa/ecdsa-sw.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)
 create mode 100644 drivers/crypto/ecdsa/Makefile
 create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c

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
diff --git a/drivers/crypto/ecdsa/Makefile b/drivers/crypto/ecdsa/Makefile
new file mode 100644
index 00000000000..89be50824cb
--- /dev/null
+++ b/drivers/crypto/ecdsa/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+#
+
+obj-$(CONFIG_$(PHASE_)ECDSA_VERIFY_MBEDTLS) += ecdsa-sw.o
diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecdsa-sw.c
new file mode 100644
index 00000000000..2af1405f73b
--- /dev/null
+++ b/drivers/crypto/ecdsa/ecdsa-sw.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+ */
+#include <crypto/ecdsa-uclass.h>
+#include <crypto/internal/ecdsa.h>
+#include <dm.h>
+#include <linux/types.h>
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
+
-- 
2.43.0

