Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18F2C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 22:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE2B984A92;
	Thu,  9 Jul 2026 00:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QzSNol17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11D8684A3A; Thu,  9 Jul 2026 00:05:56 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 861F084A63
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=747f=FD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783548350; bh=LvMM9uNWWN1QrQByhRnq7Fz9KrvralxE8FK0dOZHTX4=;
 b=QzSNol17wScxxDhuE/qouiTHuxfJXTrtFndPJySYnqjj796dsuJgNRzllEnakr3hmkpT8DUqE
 6CdzadOIBZryBWdtGyfda6iSa6DBmBZHT5BkY/gLBjRQjX+ZinywcNrL7c2wUZykh7Cv7H5ztl8
 MIdH9X5t13kZebGoUl2B74nbvVeGdPbgaTM0WuWNYPNxuj7PR121i78xZqehZCGHSxF9i/w1392
 O23iXqaEbVEnFYwou1v94iOvz6c1wvn/TR6nMbqXQ2rZRz8RloMJu6bQqVdazIPtzc0Y5JaVnaj
 wy/eeIH//m1xvJexzmVAYInDfmAhNWuEomtMsI3ISUrA==
X-Forward-Email-ID: 6a4ec9bc2402b3ca75f90400
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 01/11] Makefile: Drop redundant CONFIG_TPL_BUILD checks
Date: Wed,  8 Jul 2026 22:05:27 +0000
Message-ID: <20260708220540.3368825-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708220540.3368825-1-jonas@kwiboo.se>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
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

The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
are therefore redundant.

Drop the redundant TPL_BUILD symbol check from conditional guards that
also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
symbol rename.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Makefile | 2 +-
 drivers/Makefile                | 2 +-
 drivers/bus/Makefile            | 2 +-
 drivers/mtd/Makefile            | 2 +-
 drivers/mtd/nand/Makefile       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index d3bc0689f893..8148816c48c8 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -15,7 +15,7 @@ obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o spl_common.o
 
 obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o spl_common.o
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 
 # Always include boot_mode.o, as we bypass it (i.e. turn it off)
 # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba332818..76d6d45d40e1 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -85,7 +85,7 @@ obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) += ddr/fsl/
 
 endif
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 
 obj-y += ata/
 obj-$(CONFIG_DM_DEMO) += demo/
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 2d242bc2886b..239d9a35fe49 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the bus drivers.
 #
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 obj-$(CONFIG_TI_PWMSS)	+= ti-pwmss.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS) += uniphier-system-bus.o
 endif
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index ce05e206073d..e204f19ff8be 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -16,7 +16,7 @@ mtd-$(CONFIG_RENESAS_RPC_HF) += renesas_rpc_hf.o
 mtd-$(CONFIG_HBMC_AM654) += hbmc-am654.o
 
 # U-Boot build
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 
 ifneq ($(mtd-y),)
 obj-y += mtd.o
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index c8169cf73902..cf53c5f601ea 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 nandcore-objs := core.o bbt.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/
-- 
2.54.0

