Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A90CA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 09:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D29068399C;
	Mon,  1 Sep 2025 11:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95BD38399C; Mon,  1 Sep 2025 11:48:40 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BE6D83965
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 11:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 3D462B22024B;
 Mon,  1 Sep 2025 11:48:37 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v2] scripts/Makefile.lib: increase detail for dtsi debug output
Date: Mon,  1 Sep 2025 02:44:58 -0700
Message-ID: <20250901094506.647427-1-e@freeshell.de>
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

Skip automatic dtsi selection if ARCH is not defined and introduce
u_boot_dtsi_search for use with foreach method to implement the automatic
dtsi inclusion. Increase code re-use and detail for debug output.

Detailed dtsi automatic selection debug output when DEVICE_TREE_DEBUG=1
  - Indicate when key is undefined and skip undefined search pattern
  - Indicate when search pattern is found or not found, and the pattern
  - Show values of defined keys

Signed-off-by: E Shattow <e@freeshell.de>
---
 scripts/Makefile.lib | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5db2fbc418a..0d70868a339 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -195,21 +195,33 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
 ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
 
 # Try these files in order to find the U-Boot-specific .dtsi include file
+ifneq ($(strip $(ARCH)),)
+
 u_boot_dtsi_loc = $(srctree)/arch/$(ARCH)/dts/
 
-u_boot_dtsi_options = $(strip $(wildcard $(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi) \
-	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
-	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
-	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
+u_boot_dtsi_search = $(<) \
+	$(CONFIG_SYS_SOC) $(CONFIG_SYS_CPU) $(CONFIG_SYS_VENDOR)
+
+u_boot_dtsi_pattern = $(eval x=$$(patsubst "%",%,$(i)))$(strip \
+	$(and $(x),$(wildcard \
+	$(u_boot_dtsi_loc)$(basename $(notdir $(x)))-u-boot.dtsi)))
+
+u_boot_dtsi_options = $(strip \
+	$(foreach i,$(value u_boot_dtsi_search),$(u_boot_dtsi_pattern)) \
 	$(wildcard $(u_boot_dtsi_loc)u-boot.dtsi))
 
-u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
-	$(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi \
-	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
-	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
-	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
-	$(u_boot_dtsi_loc)u-boot.dtsi ... \
-	found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
+u_boot_dtsi_pattern_raw = $(eval x=$$(patsubst "%",%,$(i))) \
+	$(i)=$(if $(x),$(and $(x),$(x) $(if $(u_boot_dtsi_pattern),,not) \
+	found @ $(u_boot_dtsi_loc)$(basename $(notdir $(x)))-u-boot.dtsi),(undefined)) ||
+
+u_boot_dtsi_options_raw = $(strip \
+	Automatic inclusion \
+	$(or $(u_boot_dtsi_options),(undefined)) from search: \
+	$(foreach i,$(value u_boot_dtsi_search),$(u_boot_dtsi_pattern_raw)) \
+	u-boot.dtsi $(if $(wildcard $(u_boot_dtsi_loc)u-boot.dtsi),,not) \
+	found @ $(u_boot_dtsi_loc)u-boot.dtsi)
+
+endif
 
 # Uncomment for debugging
 # This shows all the files that were considered and the one that we chose.

base-commit: e4c8b32d03d7ecffd586b7d33336603ad639d7c0
-- 
2.50.0

