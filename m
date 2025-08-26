Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB06CA0FED
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 21:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B66EA83145;
	Tue, 26 Aug 2025 23:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75EAE83164; Tue, 26 Aug 2025 23:47:50 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D6C48313F
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 23:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 11CCFB222758;
 Tue, 26 Aug 2025 23:47:46 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>,
 E Shattow <e@freeshell.de>
Subject: [PATCH v2] scripts/Makefile.lib: add CONFIG_SYS_CONFIG_NAME prefix to
 dtsi search
Date: Tue, 26 Aug 2025 14:47:00 -0700
Message-ID: <20250826214708.309271-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

Add ${CONFIG_SYS_CONFIG_NAME}-u-boot.dtsi into dtsi include search order:
orig filename, (SYS_CONFIG_NAME), SYS_SOC, SYS_CPU, SYS_VENDOR, no prefix

Signed-off-by: E Shattow <e@freeshell.de>
---
 doc/develop/devicetree/control.rst | 1 +
 scripts/Makefile.lib               | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 0233945f8b6..d946b432bf3 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -207,6 +207,7 @@ devicetree for your board, searching for them in `arch/<arch>/dts/` in this
 order::
 
    <orig_filename>-u-boot.dtsi
+   <CONFIG_SYS_CONFIG_NAME>-u-boot.dtsi
    <CONFIG_SYS_SOC>-u-boot.dtsi
    <CONFIG_SYS_CPU>-u-boot.dtsi
    <CONFIG_SYS_VENDOR>-u-boot.dtsi
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5db2fbc418a..5e7bd54a569 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -198,6 +198,7 @@ ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
 u_boot_dtsi_loc = $(srctree)/arch/$(ARCH)/dts/
 
 u_boot_dtsi_options = $(strip $(wildcard $(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi) \
+	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CONFIG_NAME))-u-boot.dtsi) \
 	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
 	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
 	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
@@ -205,6 +206,7 @@ u_boot_dtsi_options = $(strip $(wildcard $(u_boot_dtsi_loc)$(basename $(notdir $
 
 u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
 	$(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi \
+	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CONFIG_NAME))-u-boot.dtsi \
 	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
 	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
 	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \

base-commit: 3dc5e9a0108bb114175b6362f9cb22367402f624
-- 
2.50.0

