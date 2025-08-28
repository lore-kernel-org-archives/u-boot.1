Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2218DCA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 06:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D119831B4;
	Thu, 28 Aug 2025 08:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1861831D3; Thu, 28 Aug 2025 08:53:02 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 604F883192
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 08:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 24256B22108E;
 Thu, 28 Aug 2025 08:52:58 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v1] [v1] scripts/Makefile.lib: increase detail for dtsi debug
 output
Date: Wed, 27 Aug 2025 23:51:51 -0700
Message-ID: <20250828065159.486850-1-e@freeshell.de>
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

Detailed dtsi automatic selection debug output when DEVICE_TREE_DEBUG=1
  - Indicate when key is undefined and skip undefined search pattern
  - Indicate when search pattern is found or not found, and the pattern
  - Show values of defined keys

Signed-off-by: E Shattow <e@freeshell.de>
---
 scripts/Makefile.lib | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5db2fbc418a..3cbb20e6b9d 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -203,13 +203,36 @@ u_boot_dtsi_options = $(strip $(wildcard $(u_boot_dtsi_loc)$(basename $(notdir $
 	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
 	$(wildcard $(u_boot_dtsi_loc)u-boot.dtsi))
 
-u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
+u_boot_dtsi_options_raw = $(warning Automatic inclusion \
+	$(or $(u_boot_dtsi_options),(undefined)) from search order: \
+	$$<=$(if \
+	$(<),$(<) $(if $(wildcard \
 	$(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi \
+	),,not) found @ \
+	$(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi \
+	,(undefined)) || \
+	$$CONFIG_SYS_SOC=$(if \
+	$(CONFIG_SYS_SOC),$(CONFIG_SYS_SOC) $(if $(wildcard \
+	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
+	),,not) found @ \
 	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
+	,(undefined)) || \
+	$$CONFIG_SYS_CPU=$(if \
+	$(CONFIG_SYS_CPU),$(CONFIG_SYS_CPU) $(if $(wildcard \
 	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
+	),,not) found @ \
+	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
+	,(undefined)) || \
+	$$CONFIG_SYS_VENDOR=$(if \
+	$(CONFIG_SYS_VENDOR),$(CONFIG_SYS_VENDOR) $(if $(wildcard \
+	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
+	),,not) found @ \
 	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
-	$(u_boot_dtsi_loc)u-boot.dtsi ... \
-	found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
+	,(undefined)) || \
+	"u-boot.dtsi" $(if $(wildcard \
+	$(u_boot_dtsi_loc)u-boot.dtsi \
+	),,not) found @ \
+	$(u_boot_dtsi_loc)u-boot.dtsi)
 
 # Uncomment for debugging
 # This shows all the files that were considered and the one that we chose.

base-commit: 3dc5e9a0108bb114175b6362f9cb22367402f624
-- 
2.50.0

