Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2AACCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9826B83956;
	Mon, 27 Oct 2025 18:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lvzHGxf7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PNjt+JxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC3583956; Mon, 27 Oct 2025 18:07:23 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE2CD8393D
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cwKgX3rvQz9tdq;
 Mon, 27 Oct 2025 18:07:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Q3aOwY7V9UNMh2hGbb55QoQP5vYibGLwq3OUK1c1uc=;
 b=lvzHGxf7dE8k1HeoWqkohVsIMGLYAg+y3v1gXLMTFom7e16X/3XUCAL3Xmyw4SjhvwdXS+
 lwpYpO+HMKL+/qQZkcILmxUciwYRtZ1iP+ZFpvzUkOaKz8yv4Vj1TDycnobc8tyVF4y8+l
 DpkPodpGyX8v+GumnuDOpU2dIkhNE9Xrn8fqwcdKXTkoLHMPNZvGMgkMJISA+XjuQzT4JW
 4eFNf79mYbz+e0eJRpP3UA7OIo7RyMhFLobDSqjAlsAQK8cYttFat+wgV7PvtaP+XC4+Ic
 CWhh7vN/D6PRA01wt5hE2J+dTtApaDXJ9gXSTnU3ggTAtoT58IwexP9Tm2p4dg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Q3aOwY7V9UNMh2hGbb55QoQP5vYibGLwq3OUK1c1uc=;
 b=PNjt+JxC1MEH4KAuOSC6CQNe5N6GYbOmeXUr2Of/4iLTNaTw0E7timuvyBnsKMBPmZtHr0
 5Osf7iHlf97Jizi0vm+tdEPWX5mCJwG4z804omPQNN6nX4cX3zCt+k3JKLc2UuHKIiZgDc
 mvxiwSLwemc9gPpk6hTB9WZ75NgPaZ71UdIZF41T3m0J4KWZdW6tNTvQeoRWT4epUAx3dL
 4VQEk6JNVIz60sRHz6by7GOzXgEEr9echyEdpn+CBtP7iD/U8sVwambyohzl9Op12tepSV
 A2rEdiHU9MYY91VTIMxin8EAqkr1tesdqYyrShVeo6me2rBlCHsKV25OX6/0NA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH 2/6] ufs: core: Fold ufs-uclass into ufs
Date: Mon, 27 Oct 2025 18:06:23 +0100
Message-ID: <20251027170706.29302-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
References: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5f749500f5e499c4dcb
X-MBO-RS-META: wd88jkgfhndpf4gn1aqs7qptqrnet14p
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

