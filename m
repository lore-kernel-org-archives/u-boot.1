Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3C4C46CD2
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 00:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5815879AC;
	Wed,  3 Jan 2024 01:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A3D879CC; Wed,  3 Jan 2024 01:13:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id ECCC5879D1
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 01:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80BDA152B;
 Tue,  2 Jan 2024 16:14:25 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 958403F5A1;
 Tue,  2 Jan 2024 16:13:38 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: [PATCH 09/19] sunxi: compile clock.c for SPL only
Date: Wed,  3 Jan 2024 00:12:29 +0000
Message-Id: <20240103001239.17482-10-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240103001239.17482-1-andre.przywara@arm.com>
References: <20240103001239.17482-1-andre.przywara@arm.com>
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

With the clock_twi_onoff() function now being called only from the SPL,
the whole clock.c file in arch/arm/mach-sunxi is needed by SPL code
only.

Remove the redundant #ifdef from the clock_init() function, actually
this function was already only called from the SPL.
Then adjust the Makefile to compile clock.c only with CONFIG_SPL_BUILD
defined.

This avoids unnecessary code in U-Boot proper and allows further
refactoring and code-split between the SPL and U-Boot proper.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/Makefile | 2 +-
 arch/arm/mach-sunxi/clock.c  | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 1d4c70ec352..3f83c0280ef 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -7,7 +7,6 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 obj-y	+= board.o
-obj-y	+= clock.o
 obj-y	+= cpu_info.o
 obj-y	+= dram_helpers.o
 obj-$(CONFIG_SUN6I_PRCM)	+= prcm.o
@@ -31,6 +30,7 @@ obj-y	+= timer.o
 endif
 
 ifdef CONFIG_SPL_BUILD
+obj-y				+= clock.o
 obj-$(CONFIG_MACH_SUNIV)	+= dram_suniv.o
 obj-$(CONFIG_DRAM_SUN4I)	+= dram_sun4i.o
 obj-$(CONFIG_DRAM_SUN6I)	+= dram_sun6i.o
diff --git a/arch/arm/mach-sunxi/clock.c b/arch/arm/mach-sunxi/clock.c
index b6c68c94f67..5e9fa0d0748 100644
--- a/arch/arm/mach-sunxi/clock.c
+++ b/arch/arm/mach-sunxi/clock.c
@@ -23,10 +23,8 @@ __weak void gtbus_init(void)
 
 int clock_init(void)
 {
-#ifdef CONFIG_SPL_BUILD
 	clock_init_safe();
 	gtbus_init();
-#endif
 	clock_init_uart();
 	clock_init_sec();
 
-- 
2.35.8

