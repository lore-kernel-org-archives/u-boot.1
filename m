Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB768C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F7EF883DA;
	Tue, 18 Jun 2024 17:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qzW/UOMa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58F34884C5; Tue, 18 Jun 2024 17:35:08 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9448840C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 3E45ACE1B72;
 Tue, 18 Jun 2024 15:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8B1C4AF1D;
 Tue, 18 Jun 2024 15:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718724902;
 bh=dCLeM8VZkRnx+De+xhHx+iRoeroBWSeOxg38WKQpLsk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qzW/UOMaNLLIlA7LEMrki58ue1zR72Ocew90JVtmkKraBORTW42pXTgzLgr7HDjhw
 FjNaSnfVB+eR4YfQRnIrLTQ9Lfu/0ZS3gOUdcsrK94hEeSksAk3Vzhr/lQcPAowDWn
 ryNwRfVA0TNqqhanPxljSrQEjttEhoaFHUKOsU1jIabXajqOTq5lh0749scKwh/nby
 DMx7RdyVxNFN8v1rq9sKd+6til6hE8hMAXLezshWKQBHHFgkfUbvTplaCyojaF+z1F
 ZRsyEg960mTx5i6lXdO4pFbrPaZ9cng1+x2M6LZ2YgcFYk17DX1Wqr/KenfSGrVcI7
 Yi8rDygilNPcQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 13/16] ddr: marvell: a38x: old: Fix some
 compiler warning of the old code
Date: Tue, 18 Jun 2024 17:34:36 +0200
Message-ID: <20240618153439.9518-14-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240618153439.9518-1-kabel@kernel.org>
References: <20240618153439.9518-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Fix some compilation warning in the old DDR training code.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/ddr/marvell/a38x/old/ddr3_a38x.c               | 1 +
 drivers/ddr/marvell/a38x/old/ddr3_init.h               | 2 ++
 drivers/ddr/marvell/a38x/old/ddr3_training.c           | 1 +
 drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.c | 1 +
 drivers/ddr/marvell/a38x/old/ddr3_training_leveling.c  | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/ddr/marvell/a38x/old/ddr3_a38x.c b/drivers/ddr/marvell/a38x/old/ddr3_a38x.c
index cc2e498d50..8504b9b40c 100644
--- a/drivers/ddr/marvell/a38x/old/ddr3_a38x.c
+++ b/drivers/ddr/marvell/a38x/old/ddr3_a38x.c
@@ -9,6 +9,7 @@
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
+#include <linux/delay.h>
 
 #include "ddr3_init.h"
 
diff --git a/drivers/ddr/marvell/a38x/old/ddr3_init.h b/drivers/ddr/marvell/a38x/old/ddr3_init.h
index 8cb08864c2..ad95cc9ef8 100644
--- a/drivers/ddr/marvell/a38x/old/ddr3_init.h
+++ b/drivers/ddr/marvell/a38x/old/ddr3_init.h
@@ -291,7 +291,9 @@ extern struct cl_val_per_freq cas_latency_table[];
 extern u32 target_freq;
 extern struct hws_tip_config_func_db config_func_info[HWS_MAX_DEVICE_NUM];
 extern u32 clamp_tbl[];
+#if 0
 extern u32 init_freq;
+#endif
 /* list of allowed frequency listed in order of enum hws_ddr_freq */
 extern u32 freq_val[];
 extern u8 debug_training_static;
diff --git a/drivers/ddr/marvell/a38x/old/ddr3_training.c b/drivers/ddr/marvell/a38x/old/ddr3_training.c
index c5ebd7c16d..29b31a059a 100644
--- a/drivers/ddr/marvell/a38x/old/ddr3_training.c
+++ b/drivers/ddr/marvell/a38x/old/ddr3_training.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
+#include <linux/delay.h>
 
 #include "ddr3_init.h"
 
diff --git a/drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.c b/drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.c
index 7ac23aedc6..869f397b7f 100644
--- a/drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.c
+++ b/drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
+#include <linux/delay.h>
 
 #include "ddr3_init.h"
 
diff --git a/drivers/ddr/marvell/a38x/old/ddr3_training_leveling.c b/drivers/ddr/marvell/a38x/old/ddr3_training_leveling.c
index 8073c2baaf..d41845a4f4 100644
--- a/drivers/ddr/marvell/a38x/old/ddr3_training_leveling.c
+++ b/drivers/ddr/marvell/a38x/old/ddr3_training_leveling.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
+#include <linux/delay.h>
 
 #include "ddr3_init.h"
 
-- 
2.44.2

