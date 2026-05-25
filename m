Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DAACD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7111C84884;
	Mon, 25 May 2026 15:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="swfTkgPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02162846F1; Mon, 25 May 2026 15:52:57 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BAE284825
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzaeWTama23u1r7yuPJydkoaZnrQE4jERAME0qN/4UyOnywQUhmiFrYlsF5Pc8geGyqbDojOqBQqfV8ypssP+M/QpWQ4ND5ctE+b/bfPfltWhIDNUWp41GTLMwoHR6Zkh7F1pYPIkeeuOY0695Nu/rdpoKMEVD+d52Vw1PgrxLm3L/VrBiXskYqwp40aoYkAr2JlFTqHrIN6kWs24QTbLW8uDXZ1dvbl6TO4lYmcSznWHEVdUEvOWjE4oXUFYReDsYtrlZCfhRFKeu9NwKj9sT4YZonkNmsfl/Aea4rLoHBeBxhq43X6enFoa9+BL7n2MF3wo5cRaxrmLR0YM2ZdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MT55ebE1DyUTj5Nhq0ck/HHp4FMXkPpA9Psjq668nY=;
 b=kCjXE/5gBfR8hXBKQ3jDOSyqjgXru2Sf4GijD7jjWW9ABrJjRGhIzgcDrvsPKNVsukcNayY+KSzzeHEDLyUA6POq2uEDSa1QURb4YPiGPxa1/Yl5PpLP4BfsTiGUDjvLbC5t6SZ1a9YkLJ/YinN8gBdUZ+U2KRYFCUhjI4GBbNl7wInMdoWS2bxiZwTZT8IXI0Y6gfCIBhMQqfj69quAM5esCUU7XBtqP1YpFo9eMWXiLUzQWVjZbELaXUPrT7UAXkrTSFM2Qerz42nMDYv6EHoCS8yNdJPwQnzcKK9HwixqWiREc7Ea5X9C+hibFwx//t9cRUaKxJntrofiqQ6nag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MT55ebE1DyUTj5Nhq0ck/HHp4FMXkPpA9Psjq668nY=;
 b=swfTkgPPsv0qGK3wNEwKP5JSlf6k8dHuV4g/x4yzGkJbTnDZ5NTUkmaL9tIJEAYgD+9uhZ2hAGmPTlhIR9+vm+Tz3crcPprLsmd46IU3/xc1t7DObotDng1sbltTQZYhkp2YVRgcemovHCI8lQgF0RbrHzWt2qjPWxI5gqpaiV/IOKV5oaSKQ2XcSouX4lBjQCUOfYA66H2TqRvNkVtkep2EgRQC73WKwJzAiDVeLBuXaRcMgLc/2GKmbGm9JORQLTXFDQ+mJVB8CIhXBm8KiiCYn+D5I+mcEXt9/uRUtqjc1cioR1JzN2Y0k9lCzP23RrbD+GwH6zf6L5e/lwmnZA==
Received: from MR1P264CA0063.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3e::30)
 by MR1PPF71A645A99.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::2ad) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:52:46 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e:cafe::3a) by MR1P264CA0063.outlook.office365.com
 (2603:10a6:501:3e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Mon, 25
 May 2026 13:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Mon, 25 May 2026 13:52:45 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 49A7B20931;
 Mon, 25 May 2026 15:52:45 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 05/15] drivers: crypto: add software ecdsa support
Date: Mon, 25 May 2026 15:52:31 +0200
Message-ID: <20260525135241.88348-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525135241.88348-1-philippe.reynes@softathome.com>
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|MR1PPF71A645A99:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 66063f24-32bb-4af9-6c2b-08deba64e66b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|30052699003|36860700016|18002099003|22082099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info: 5PefSSTCG9UU7wPZ2CDs/O0u4nhMHLCM+jVCdmwhYcDfKM0CPNhnihxOxUxdGt6RTmRFVvJFoDtndCYpJA6RSqTJtOyrPTtOjfqURLtitKarAVWxwUSrLaf6h4noMik6wOIG0db9TARlSXfD5o7TVREiFu1hQVFfK9knlaK3VKbE32DxzQMd+hFIel9KalssV4ZxSdamaP72gpwQOX8QVbz2Tdwa7oC4KSQQow8Gkmwj2hLLETwhku/plc9lPsssPkhQIAHBdhpi4txfinComjaCWTaaq3DzeDfOnIwLQqRW875zsQSooH+ZtpfhsB81bSl+eSnB9qN33iSh5MH/Jf6489b7PO+Hjy02n3M59qxHB3Vvcf9j2tdYGiXx+8aJGcxlqffjVAjDPUQOa75iPLFFcKpLlnK8g9BaeVnu2QPSZ73gSxJ1/e7IPS7Vb92/q5orNXQkEyoWO/jis66OmicwA4WVPLkhXS4JupMz95Ilx/0EmtbQEBOOx9ADmnlWH1mfKLYxJWWzrpFZxD6xy8U8fjj2VjKohlKIvQeYXLGQ3BHq+44+LA/qvrRXjkxmPG931bBia/qz+EAYJHnyigjvQMWElNdBtmzd/YZe9eAGsbGZPv3PTM2Vjb3NraOpHSD4YmuIE6VMJfkpHQxokhtci13BLZRV+AomfGXlgaT3dvcRiPG6E+b7WUsBT5uq
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(30052699003)(36860700016)(18002099003)(22082099003)(56012099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FEZg/GI5V6rWbjmAqwpZ98H9Mkp990CSOEI1AOxby9cpH4aGQYockNnras0OstwhrZQgmSMAHDJXNPjMM4LXqX4V/ejZwCcKoovWc5qpd9nmqw5alJadOoZVNQBT6trphQGvoOo0aMt7rxaPdPi6jer3sPTg/U0rtImN+KROLmsS/sE/iS+KbT8jlKo6vlm0ulpPLWt18MXPx1HtQ5OJUl3kBBKRVUPGwWLxaQrr7ib04HIa4GnXcne8XrGe8F/oZAxwmOvjuDnMpQ0rcWKbjL9MxPsWKykqhAm6FoKplklyU26wAk/SNNM8USj9aDeH7Rb5CUs9gDShgx0EJmfBq+PdiEj1NXTU4QoyHyP0nDCL2gZO3J7YfirFLSAs2uMRXAaFOLQz/RIs8OInJkDqS953acbgO2KkO4PnoLExZgOhiUB7oHiE9UsjrsxzUHSW
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:52:45.7729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66063f24-32bb-4af9-6c2b-08deba64e66b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPF71A645A99
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

