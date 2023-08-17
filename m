Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4E5C27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 05:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA5386A5F;
	Thu, 17 Aug 2023 07:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD43086A5D; Thu, 17 Aug 2023 07:49:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 21E6586979
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 07:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53C97D75;
 Wed, 16 Aug 2023 22:49:54 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2837E3F762;
 Wed, 16 Aug 2023 22:49:10 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 1/6] scripts/Makefile.lib: Collate all dtsi files for
 inclusion
Date: Thu, 17 Aug 2023 11:18:51 +0530
Message-Id: <20230817054856.2019253-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817054856.2019253-1-sughosh.ganu@linaro.org>
References: <20230817054856.2019253-1-sughosh.ganu@linaro.org>
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

At the time of building a device-tree file, all the *u-boot.dtsi files
are looked for, in a particular order, and the first file found is
included. Then, the list of files specified in the
CONFIG_DEVICE_TREE_INCLUDES symbol are included.

Combine these files that are to be included into a variable, and then
include all these files in one go.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes since V1: None

 scripts/Makefile.lib | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f5ab7af0f4..368b5a3e28 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -179,10 +179,13 @@ ifdef DEVICE_TREE_DEBUG
 u_boot_dtsi_options_debug = $(warning $(u_boot_dtsi_options_raw))
 endif
 
-# We use the first match
-u_boot_dtsi = $(strip $(u_boot_dtsi_options_debug) \
+# We use the first match to be included
+dtsi_include_list = $(strip $(u_boot_dtsi_options_debug) \
 	$(notdir $(firstword $(u_boot_dtsi_options))))
 
+# The CONFIG_DEVICE_TREE_INCLUDES also need to be included
+dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
+
 # Modified for U-Boot
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 $(UBOOTINCLUDE)                                         \
@@ -320,8 +323,8 @@ quiet_cmd_dtc = DTC     $@
 # Bring in any U-Boot-specific include at the end of the file
 # And finally any custom .dtsi fragments specified with CONFIG_DEVICE_TREE_INCLUDES
 cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
-	(cat $<; $(if $(u_boot_dtsi),echo '$(pound)include "$(u_boot_dtsi)"')) > $(pre-tmp); \
-	$(foreach f,$(subst $(quote),,$(CONFIG_DEVICE_TREE_INCLUDES)), \
+	(cat $< > $(pre-tmp)); \
+	$(foreach f,$(subst $(quote),,$(dtsi_include_list)), \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
 	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
-- 
2.34.1

