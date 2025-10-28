Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D2ECCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF19836D1;
	Tue, 28 Oct 2025 15:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gyQhJfLI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ut7Cyv6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87CB4836D1; Tue, 28 Oct 2025 15:23:50 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD6680422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 15:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cwt0M6tC3z9tT9;
 Tue, 28 Oct 2025 15:23:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761661428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3L6hHGyZlFU2MgAVe6TWJeBOfXlsPw+vvU86q7D1rV8=;
 b=gyQhJfLIC205SiUTd0IYW/JC4ShpXltj1M1xou5FdKQzaGy96rkvj/G78+W3FIgN8Ltg/B
 T52z0U0oNQQ7qbbFHT2q/yOQac2/jk2JtKjHTyUJfUds4N9q3z2E1xd4atsbGEIqaV86U7
 JgeGVoaGx3jrHOgBPCpQ0SfBZD3ZghogtXWGIi9c1dM6lpiMUxHM3OPYsOEPnNbd5a4ouK
 9cDLPEhnf1TeOhx58o/efQc4SMElP5wo2LwykpzSRiwqRKYLCs02qR5OEQcV5QmiILE7HQ
 IhkoVB4nO+Jybo9QA7ON/xSVdXjKxo8WwHxBHPWfp3HbcWn0HSxDCBnaFPVZtA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Ut7Cyv6m;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761661425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3L6hHGyZlFU2MgAVe6TWJeBOfXlsPw+vvU86q7D1rV8=;
 b=Ut7Cyv6mcTQ+0Y/2bMIl8b2A8q1QSY4l2vA6CVoMBx45bJ57dyjt3HqbnRIzB+WmaGmGir
 5feDMaNUw0GiPOEsy4qeu7J/HE/jygVJ5E9YUPWz4cK+gV/JRD6gMIgkCXrdxlUPBGcrNz
 GZQALAkwUhsMOY3WOeSAm6R/PvdtbOi4I7IbqG6YJrtny04N0cm1iDdqOJMRkEVj4LOFEj
 Av7kLgDAYwpuoIjzAjMKuK8tA9M97eQPcoaUhBvlIycDr9YzbtXkqTZ/5E1GdQ+UT+F/dG
 hEl0qTK8/ly+uXGPKYKbAqT2+9WuFrfbWsZ8coWFQY3r3wQrGxMPidcXUBQnPQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH v2 2/7] ufs: core: Fold ufs-uclass into ufs
Date: Tue, 28 Oct 2025 15:22:22 +0100
Message-ID: <20251028142335.18125-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251028142335.18125-1-marek.vasut+renesas@mailbox.org>
References: <20251028142335.18125-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xetyxzzfax6i6obr6ew4ep1jmoe5er9a
X-MBO-RS-ID: ed171bd5b9eba0fba29
X-Rspamd-Queue-Id: 4cwt0M6tC3z9tT9
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

Move the few lines of ufs-uclass.c into ufs.c and remove the
ufs-uclass.c . No functional change.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
V2: Add RB from Neil
---
 drivers/ufs/Makefile     |  2 +-
 drivers/ufs/ufs-uclass.c | 17 -----------------
 drivers/ufs/ufs.c        |  6 ++++++
 3 files changed, 7 insertions(+), 18 deletions(-)
 delete mode 100644 drivers/ufs/ufs-uclass.c

diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 548306fb99e..2ac410cf7c3 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
 #
 
-obj-$(CONFIG_UFS) += ufs.o ufs-uclass.o
+obj-$(CONFIG_UFS) += ufs.o
 obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
 obj-$(CONFIG_QCOM_UFS) += ufs-qcom.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
deleted file mode 100644
index 334bfcfa06a..00000000000
--- a/drivers/ufs/ufs-uclass.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/**
- * ufs-uclass.c - Universal Flash Storage (UFS) Uclass driver
- *
- * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
- */
-
-#define LOG_CATEGORY UCLASS_UFS
-
-#include "ufs.h"
-#include <dm.h>
-
-UCLASS_DRIVER(ufs) = {
-	.id	= UCLASS_UFS,
-	.name	= "ufs",
-	.per_device_auto	= sizeof(struct ufs_hba),
-};
diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 57e6e8c013b..c1f3301b37e 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -2091,3 +2091,9 @@ U_BOOT_DRIVER(ufs_scsi) = {
 	.name = "ufs_scsi",
 	.ops = &ufs_ops,
 };
+
+UCLASS_DRIVER(ufs) = {
+	.id			= UCLASS_UFS,
+	.name			= "ufs",
+	.per_device_auto	= sizeof(struct ufs_hba),
+};
-- 
2.51.0

