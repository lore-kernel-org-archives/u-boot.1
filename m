Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F50CD6E57
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617DB8490A;
	Mon,  1 Jun 2026 15:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="pdfXOzxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A85B84915; Mon,  1 Jun 2026 15:43:20 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3150848D7
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dm77dfAVW4duWOxTHrbvUzyivhtmsPoFyOUyyC0sEC8xowYrf1iHf1CxCOOEl3sx7IwMrfHzCcYuld9YQ4TK4veuQrvFPOihdWerJ5nMa/0j3J+ExcPlCuiotxU4UlQXMlLRl8rCphi1gli+KNzvwuBlc2VJ5XHIFXEZGfi4JT2uD4lZpz6UEbssbZHqjdL0UrJnBVQROkt3vAZnDxRCDVjzEWN0XLat6W6dei+fYlYzuV3HKkQLVbf+OF0qA6WrbCzhl5nbSE4f3g4U/ZZVr9bJEeCfkgn4S1/iHVxltsqxbKTjDLIfaRiAk6S+6k/BStiPT8bs1kO5MQRqYKobvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VegncvUyS5iWnldahz35UYnASyCg/OAIjlG6mSNArhU=;
 b=uk2u1ZkTBLL8Sja3dmlHBOm3k6Qlbhb4F4CU3Yw56r3sWakYBFhrrw5VV1cwLxFLungSbYF41CHFw0bdeqsBCAyx19Q7kDDQ3K8ljCA53xgy8kB+nBMbgzFx1hppe+cqYE3E5Zhm38GlGryPlkd5bncKrPpEDLQ8ZvQ6lFG7QWwSE5TN512LGd7eOOi0lizw5MGPg3sXNalpYDHj1Acj5dcg/pBercc9O1Yk31NUfg48Vg74PjDQLYHOJmcyzoQL0ke0U7jH6NkcN4/GO6b4J3ZKwFcLj7Vi8bMmpUhl9ACSXernfgf+Wbm8ROxxwVOHqop8XbtPaYwYUHss7awfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VegncvUyS5iWnldahz35UYnASyCg/OAIjlG6mSNArhU=;
 b=pdfXOzxKN9wd/g0NPZhcOMzIlYsCVRLEtvlqyTlXYWi4UYkgAObcFblsIo+CMJHfXbZbJxVDxpZIFhZh3TbMzRs2H4kXgm3yy9sFsTuT+HHeZP4csY9rO1umQQx0GRQ/3Ewxb5iiof1vU2BNSEW9XZ1auep6vpisVAcQG0MOYKaehY+MFxQpXaNU9VcuoTkHoNtpNOtt99iQ01eDfY45G4D6I3UzVXJmBLpGqHFYMDMDZCUSXFyt75MmJ3Blvt8RGsQkYy1SVa5563ND+yOD5m2HE9NqUdYmcoO8MD5rHPzpJZR9CzgBZKX8k8XbCQNPsbRDjTgOVWjKU5+6xN4upQ==
Received: from MR1P264CA0163.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:55::10)
 by PAPP264MB7614.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:552::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:43:16 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55:cafe::6c) by MR1P264CA0163.outlook.office365.com
 (2603:10a6:501:55::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 13:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Mon, 1 Jun 2026 13:43:15 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 73016213CF;
 Mon,  1 Jun 2026 15:43:15 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 05/15] drivers: crypto: add software ecdsa support
Date: Mon,  1 Jun 2026 15:43:00 +0200
Message-ID: <20260601134310.2452454-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601134310.2452454-1-philippe.reynes@softathome.com>
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PAPP264MB7614:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bf454d9c-b82f-4707-d0bb-08debfe3bbad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: QZg2fcMEQIqxfnXYo6juuGwgw2lTWL4Ktvz/wZPwGoZ6s+eiWofpW1D6VLmaBDsgFpss3ovvt+kuJATeDG9mfFlUjF/1tlDPbqfYFwu9NXqA4ik0z8JBN1XpkmPS1Zd4rG9vSB3CNuNQKn1jSLh7qdNaFmLlWPPYdIljUfjp2l7vfUX1AInBtDEugcbXhFvTlHuQRnvPhAscInuC8SD9FZPG3CdP7Qz2pN2hrFi6vQM0SQgGHywMmA6Q+iFHhC79+3pRfB2JeE6W+bslAmoOXNd4X4KAc3u1vQcBcxuEXct2FS2P1yqOgsZbjRaGl/TCH+GdGPZn9yVxitSvXjRtR7xOvtfuSQAQ1jLfDCmWsz7q9GAXypnpiteVu2JDGQ/r2wjg5zkLpkkpn6WT8MFFHi6u8RhWVcPiOG/ET+XiqIBGRyXaJ5KYWG/72pWBLkNE/xtqosK2lTZRRXH1cC8dQ+hzeiC4wwMt8UPQBXnYN1MOGtItnLWPDyLKgv66zRU40kdGyKlxJGtTXmqNBb61bEJE/2cIcJAZmPDqZKXhUmGFuOgTnHNxwRlugGN9qd1qtK7d/BV4EgEGFNk/HnqzfwbbAyKSyWFkl6zF4GmNk41qAXe2wOoY9uv0tJRKWpBteZJY3P1AADt1RDHHDkAx3YYDhnULmzwxM1add+/BrwG7g76Gs4koEFQodaxqX2pi
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JaOlzOQnY/maFQOAB8AL51MT5KMKloh5yJ3QHCEmnZRw9McuAgs2BjKR7ilZGzR0HnaSO3YYQJwyupEXDEKNx8W2586fNtDB2xu67rjt6yiM/nNaHl7MV3Q2b6ccS6lLDvDB8k4F59vMY9jbZd/0IxRYdO+qewsR6P1m4wUinZa9zxPEEck3V73SrBWcnyqskmmBKuFmGqQgr1cUxkTZSbUVpFeCTwcS0aJfDOVukyFkW02TgbPSylFKLD2kEa3at8b52Lv4zTEtlNRhvVCu7zJYsmPbfZo8PUZFPjr0ixM0o/bjDpyJW4hLye9J++7gE4F80Bdda2rKrXYPUCEkFhXGrRbmMGChD/GXNvhpb5F6+d0t6ZHYjJxsRG67LyK5AVtRu+yFBQML1nhpxcx4GbRo0pB93igWbqSalyEODD2UO/ebtc1KWW0bsesUgIKy
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:43:15.9713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf454d9c-b82f-4707-d0bb-08debfe3bbad
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAPP264MB7614
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
v8:
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

