Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D3CF4369A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA2D2842F2;
	Fri, 17 Apr 2026 15:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="I/1llRHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 430E7842D7; Fri, 17 Apr 2026 15:02:15 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECC5584214
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfF9VLwWI46AnR4QlsNm2VHjitXiRFhbHYLvmjArC756WDn/2tepPGOeJ+brzRenxFajcSDNebi7K0OwFHsWjeg1apN8dK51/CIzSKuOb3XbJlH2MIM82vaOO6QyO/vUcJ5DsS/OkJkzj7JwRWjsxagu6YWjUGaokenrWJmDOMnHLQqOdPHaOQ1auqRlUCC8mHaAYJuAjMME9CSdOM/t1HN7YHCKxoFTUcFmfT/xrM+MrD4Szqcz2iMPmdHoESCQWRSx85zYjwgiVYn0h2hdpl1It9AmFbxgO4QMRFAVH6McalaVf4rFkizv091Doz5l2x9men6SJThPv8ZKrGB2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GX5iTqs/wXJ1D+XAfnqGHySosnr22QKsthIns53bN/s=;
 b=TTslNSVHVrF/7F3hf5HpTR1DV5c5vC9d8s5rqQkkhqiFp9gBmBruCFmMo/1VH9kBjx6dqInDeGIvVdWxe+IzEM1Wo8jATkP8gWdS5OMK//oZQogEOywwEJXVEQIXgzkXeesFXFMEiO96LS5Xikj9PVeqfLqXFYOanrTMpXQDPpMzYYKiZcRkwFypq21DDpKYbr8dRsklX+hqQlPPHb4Pksukc7aD9UdfgrLhWytmOaX+x8sI3s59LghVwtC6cxm8KOWsZkj0xpdCEchKsgbYer0AjXHGqPgWTKDIcRIoDJZ1M16yvujZwKb60jAFMpAe+58drqu12zpbwLDUlOHtSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX5iTqs/wXJ1D+XAfnqGHySosnr22QKsthIns53bN/s=;
 b=I/1llRHyo9BKTvwGnLdYyMb5FVexHHxVfx/bJWvouu2m2ccdAXQrIqiMQmdv8nTk5z8NPZU7yhtOLHUlWjjU0HTZTFRa2GnKF8HszU6XRMuWe9EQRPQShilbVlf3Wbz76kRoZKViHEexC6kQLgdgUJtITvbKtU4O5G48QF7GgaeekygHv8Brs1mz+uR3ItVHPFfaquUjHXNlYJvD+ccEU1yJumPtlUO4MFjQ+jmdTz8CjsCCh7520rMO9Eul44Ez5CfpcJXJJHF9MxteGKx3kill9zwwblpArRkUgIF9CzEdZW9N8fR4X6ySbPK5zbl9vDw5Ol+csl5CgwrO9/kdHA==
Received: from MR1P264CA0026.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2f::13)
 by MR0P264MB4730.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 13:02:10 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f:cafe::5d) by MR1P264CA0026.outlook.office365.com
 (2603:10a6:501:2f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 13:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 13:02:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id D6C4F20E61;
 Fri, 17 Apr 2026 15:02:09 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 04/14] drivers: crypto: add software ecdsa support
Date: Fri, 17 Apr 2026 15:01:54 +0200
Message-ID: <20260417130204.49896-5-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|MR0P264MB4730:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 01531271-3c87-407e-0c70-08de9c81895b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DLi3V/wvULvDBiNwkantdL7zRu5xrHXDPAqUFnPMy4WRWNNIEQ+yGjkb+NhmUctdheuxWVJqf6QFHxsxCoUdpg0nYLQo7NOs0LV14brujaF16ACyBtEgQMKqO+YYaneW+Kspoy98KfG0lSkIm7i6NFNkU0o+5b7CGKBW1vQORU2oi0GqffwBCP1uTnP961uHYo7RsUV9ragyUAPM7jfpOr2mHYDsTBLKNWpEWsSiTXNoEAI8zk9sx2AF9ltDNc1+XQl0fpV9B+AzyxunHtgpOcNUTz+lavvD0HAtYpEgoxapHlk+Ux5PyQISRF6qmhv6eooKwAbuIXBKrQ9vT3VRnEso6+hrIM5TvuuXcqgv4GGc/8y7uqOt1iOq8xDnH23DU2SuazE+XM6K8Z8nI+Nqu12HUPl9xjbKbG5US3loMnrTdUgecKh5Ugg1sZ7kLvV1xu4w2sDMhPHFjp3Z+Gj3mkvubJYlyAPq7Y63x2yezFmN8toenqPsMWAfqsG2BalCXXkojf/pgDmh5JgNN81gVLTlTxkO5NcVzBRj3+/pfE8yN0ERyH6dlmKvQEvdtlOjfdzS/k0rL3GMnK/d0nRre9EhMe61Zr1tLE1sghkK/TbisQ0U+HeGhwcGtJ189trqof/ROC9IVTDedEux9ks4VvSjlAlKPob6Qxcf4hw4ABFScvZ6NnVq1S3v0zRJMaamLYT1bN+BU9Ea/iTMqMkryx6tKYiSS4AtFnui3/JMcsg=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9NRep78yLK295uBgNRAxG8WOXp7IhXp1pnDEk8aVad6d050Xbv8zE4iCAulUf11jKM3HuODvyFz43ZtI8DFhQUyGyqhYlEFgzxDirYh6PauV6lnNHppRY2eaRTlASrH+wut1FmnEgzss/ZGOGzD4p1wzUCsS+1IS8699j0s16KsMWM7DxPgAncxL32yDPQx742YaA6RwR53JIyQzbbRQUyppgSCHWlf86uhEFS6AR2RvPfebEH4PxXgSI57TKiAYMw1h+yK7Jns6uCgFqYTseI+5hq2TBSqTFdg8we+oJcFJAMIvhDygIuOb0v0jZ6wLFLTgpBbVOxRNTOXr5W3UPG6Cbj0OeRCkDd/cCl1R6zk80tiJdKQ382uY4Nzj5fW7fxaMzoZ46gBXVwcTxoV+jU9f/F+p1L/T80NE6Mj383vfUhgxUzrJsVRv1rjn7kdx
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:02:10.1684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01531271-3c87-407e-0c70-08de9c81895b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4730
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

 drivers/crypto/Makefile         |  1 +
 drivers/crypto/ecdsa/Makefile   |  6 ++++++
 drivers/crypto/ecdsa/ecdsa-sw.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)
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
index 00000000000..53456d9cb4c
--- /dev/null
+++ b/drivers/crypto/ecdsa/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+#
+
+obj-$(CONFIG_ECDSA_MBEDTLS) += ecdsa-sw.o
diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecdsa-sw.c
new file mode 100644
index 00000000000..21dffeddf59
--- /dev/null
+++ b/drivers/crypto/ecdsa/ecdsa-sw.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+ */
+#include <crypto/ecdsa-uclass.h>
+#include <crypto/internal/ecdsa.h>
+#include <dm.h>
+#include <linux/types.h>
+#include <u-boot/ecdsa.h>
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

