Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD8DC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 16:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AACB881B6;
	Mon, 15 Apr 2024 18:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NyR8Cg4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0156387D43; Mon, 15 Apr 2024 18:31:02 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEFEF87D55
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 18:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A557C60EFC;
 Mon, 15 Apr 2024 16:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D8DC3277B;
 Mon, 15 Apr 2024 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713198657;
 bh=ISEG8S1/35F3/HPizQOt6iYIlzoPRkzJeklwuNdRoNY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NyR8Cg4FHyrD71ekRoEQD6hrsNoDVqqF1W4fQ/NR8kX3fzL1/wHczTPtKav/gURy0
 uZP8ae9yqxSKfxTUqaiZ35RgzhqFm+DXyvV8gejx4o8qxlPmzJDuTnhr9U+uBlAczR
 5gziLudKUvrvA9lEeTba5JfNL2B5OP+E369FOIaP28YVC7E9odAbD4UJHDW8gf0TT3
 5R0GbFJAK78JpXnyLjRyeKgZgdVmbpGlKdfv8oyFJtHCrGYNQt2ZlDfHDMImJOjhcS
 lJK80twd7NWaSTa9WTVdWOZkX3B/r4WsgYWHalcgyYEZsQhnvrVrETSwbWgtGF0Uis
 A3qIWl7mcuBcg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu 07/10] ddr: marvell: a38x: old: Fix some compiler
 warning of the old code
Date: Mon, 15 Apr 2024 18:30:40 +0200
Message-ID: <20240415163043.7482-8-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240415163043.7482-1-kabel@kernel.org>
References: <20240415163043.7482-1-kabel@kernel.org>
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
index c082122f25..32a14ca4c9 100644
--- a/drivers/ddr/marvell/a38x/old/ddr3_a38x.c
+++ b/drivers/ddr/marvell/a38x/old/ddr3_a38x.c
@@ -10,6 +10,7 @@
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
index e70ca4b425..572a69d45a 100644
--- a/drivers/ddr/marvell/a38x/old/ddr3_training.c
+++ b/drivers/ddr/marvell/a38x/old/ddr3_training.c
@@ -9,6 +9,7 @@
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
+#include <linux/delay.h>
 
 #include "ddr3_init.h"
 
diff --git a/drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.c b/drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.c
index 011824ab42..ee789f0993 100644
--- a/drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.c
+++ b/drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.c
@@ -9,6 +9,7 @@
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
+#include <linux/delay.h>
 
 #include "ddr3_init.h"
 
diff --git a/drivers/ddr/marvell/a38x/old/ddr3_training_leveling.c b/drivers/ddr/marvell/a38x/old/ddr3_training_leveling.c
index 3c40f198e7..c5043eefa3 100644
--- a/drivers/ddr/marvell/a38x/old/ddr3_training_leveling.c
+++ b/drivers/ddr/marvell/a38x/old/ddr3_training_leveling.c
@@ -9,6 +9,7 @@
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
+#include <linux/delay.h>
 
 #include "ddr3_init.h"
 
-- 
2.43.2

