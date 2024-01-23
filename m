Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8B5C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 14:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 077DD87DA8;
	Tue, 23 Jan 2024 15:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1FBA87D93; Tue, 23 Jan 2024 15:50:22 +0100 (CET)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5255987D6D
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 15:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TK93w39xGzMrL9J;
 Tue, 23 Jan 2024 15:50:04 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TK93v0szRzY1s; Tue, 23 Jan 2024 15:50:03 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>,
 Andy Yan <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>
Cc: heiko@sntech.de, Quentin Schulz <foss+uboot@0leil.net>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 12/18] rockchip: transform rockchip_capsule_update_board_setup
 into a weak function symbol
Date: Tue, 23 Jan 2024 15:49:20 +0100
Message-ID: <20240123-jaguar-v1-12-1eec1c34953c@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
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

There's only one user of rockchip_capsule_update_board_setup, which is
in board.c, and only one board defines it, so instead of having a header
only for one function symbol, let's just use a weak symbol instead.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/include/asm/arch-rockchip/misc.h | 9 ---------
 arch/arm/mach-rockchip/board.c            | 5 ++++-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/misc.h b/arch/arm/include/asm/arch-rockchip/misc.h
deleted file mode 100644
index ef37ff1661a..00000000000
--- a/arch/arm/include/asm/arch-rockchip/misc.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * RK3399: Architecture common definitions
- *
- * Copyright (C) 2019 Collabora Inc - https://www.collabora.com/
- *      Rohan Garg <rohan.garg@collabora.com>
- */
-
-void rockchip_capsule_update_board_setup(void);
diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 80b4514852f..4f666aee706 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -32,7 +32,6 @@
 #include <asm/arch-rockchip/boot_mode.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/periph.h>
-#include <asm/arch-rockchip/misc.h>
 #include <power/regulator.h>
 
 #if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
@@ -148,6 +147,10 @@ void set_dfu_alt_info(char *interface, char *devstr)
 	env_set("dfu_alt_info", buf);
 }
 
+__weak void rockchip_capsule_update_board_setup(void)
+{
+}
+
 static void gpt_capsule_update_setup(void)
 {
 	int p, i, ret;

-- 
2.43.0

