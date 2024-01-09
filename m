Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EA5C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 12:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F14D5878DF;
	Tue,  9 Jan 2024 13:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XC8CutQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F16CB8786F; Tue,  9 Jan 2024 13:26:19 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12E10878B8
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 13:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 793FB612DA;
 Tue,  9 Jan 2024 12:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B1FC433F1;
 Tue,  9 Jan 2024 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704803176;
 bh=6RKRZUen0TEJMGTXp70a3SNwZCPpFFPqGokZhY16cW0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XC8CutQVMMYxwDGuI8BCOiZ90YiDb2/+hN4gzcK+yFQPtTlIAIPz9nooxx4wlCx5O
 HfuoK2+0mjkR3MiXQMSAcMtRvvgUVEEj2MobgQvfc/bad7iuGhUQfDcEy0gww7qREK
 nPNW4DtnZRigrAtHwMN+lDkk/7472Yv14V2EciqHPeVqvf7VNoOdDSCnPvCPFRTrMI
 QMouUozQuOUl3EaDrCAjFv2suR+/qEKC3ioT5gHHL/JCE2pb7Zns3l4Z72tjxnjQGv
 r7xcBiMkZCtyquz7SRYw7E6usmHZiE/0Dxh0EWyHUBa/ejXnJakYc7SmQ0CZr7gF3r
 yS6nlDhHCuPSg==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com
Cc: nm@ti.com, afd@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 r-gunasekaran@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/4] memory: ti-gpmc: Fix build
Date: Tue,  9 Jan 2024 14:26:02 +0200
Message-Id: <20240109122605.51951-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109122605.51951-1-rogerq@kernel.org>
References: <20240109122605.51951-1-rogerq@kernel.org>
MIME-Version: 1.0
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

sys_proto.h no longer exists for K3 platform so drop it.
Include sizes.h to so SZ_16M is visible.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/memory/ti-gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/ti-gpmc.c b/drivers/memory/ti-gpmc.c
index 775e78c9a5..0b8674339e 100644
--- a/drivers/memory/ti-gpmc.c
+++ b/drivers/memory/ti-gpmc.c
@@ -6,7 +6,6 @@
  */
 
 #include <asm/io.h>
-#include <asm/arch/sys_proto.h>
 #include <clk.h>
 #include <common.h>
 #include <dm.h>
@@ -17,6 +16,7 @@
 #include <linux/mtd/omap_gpmc.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/sizes.h>
 #include "ti-gpmc.h"
 
 enum gpmc_clk_domain {
-- 
2.34.1

