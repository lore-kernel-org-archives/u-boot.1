Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D49FC47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 11:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9872F87BAE;
	Thu, 18 Jan 2024 12:41:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B970387B85; Thu, 18 Jan 2024 12:41:39 +0100 (CET)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85C5D879E5
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 12:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TG16m0lk2zMpyrh;
 Thu, 18 Jan 2024 11:41:36 +0000 (UTC)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TG16l44Hsz1Zm; Thu, 18 Jan 2024 12:41:35 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, Quentin Schulz <foss+uboot@0leil.net>,
 u-boot@lists.denx.de, jonas@kwiboo.se,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v4 6/6] rockchip: rk3128: remove noop file
Date: Thu, 18 Jan 2024 12:41:19 +0100
Message-ID: <20240118-rk3588-spl-boot-dev-v4-6-23a97c82c77c@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118-rk3588-spl-boot-dev-v4-0-23a97c82c77c@theobroma-systems.com>
References: <20240118-rk3588-spl-boot-dev-v4-0-23a97c82c77c@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

arch_cpu_init is already returning 0 in its weak definition in
common/board_f.c so let's just remove the file entirely since nothing
else is done in it.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/mach-rockchip/rk3128/Makefile |  1 -
 arch/arm/mach-rockchip/rk3128/rk3128.c | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3128/Makefile b/arch/arm/mach-rockchip/rk3128/Makefile
index 50e11175423..8df1a60a348 100644
--- a/arch/arm/mach-rockchip/rk3128/Makefile
+++ b/arch/arm/mach-rockchip/rk3128/Makefile
@@ -4,6 +4,5 @@
 # SPDX-License-Identifier:     GPL-2.0+
 #
 
-obj-y += rk3128.o
 obj-y += syscon_rk3128.o
 obj-y += clk_rk3128.o
diff --git a/arch/arm/mach-rockchip/rk3128/rk3128.c b/arch/arm/mach-rockchip/rk3128/rk3128.c
deleted file mode 100644
index 8f8f4951bae..00000000000
--- a/arch/arm/mach-rockchip/rk3128/rk3128.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2017 Rockchip Electronics Co., Ltd
- */
-#include <common.h>
-#include <init.h>
-
-int arch_cpu_init(void)
-{
-	/* We do some SoC one time setting here. */
-
-	return 0;
-}

-- 
2.43.0

