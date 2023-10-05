Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37370E92704
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 14:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5174F86CFE;
	Thu,  5 Oct 2023 16:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RLnDWKii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 444A386C20; Thu,  5 Oct 2023 16:21:28 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA67F86C2A
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 16:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395ELKFp013639;
 Thu, 5 Oct 2023 09:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696515680;
 bh=/9iuGsW/kw44OxCkEuVBW5B78s0Ods/0plHGlbSDoa4=;
 h=From:To:CC:Subject:Date;
 b=RLnDWKiifq/nM+zI/EvZEqUYBVKUEOac/eZ2+9EfD7Ik03cg3TX8R+1l6+ytihdYM
 tCxtUULDu/LAS2SQ+GBEfywwkGezhbOlA7A08eQQWXIY93/h21vG4k4Q4FNN4YoqPB
 NPz0d76TFAVClVOrkNm8VVt8HdOjWCvJfG/YxuXM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395ELJQA073251
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 09:21:19 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 09:21:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 09:21:19 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395ELJCa129317;
 Thu, 5 Oct 2023 09:21:19 -0500
From: Andrew Davis <afd@ti.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: Andrew Davis <afd@ti.com>
Subject: [PATCH] arm: mach-k3: Remove secure device makefile
Date: Thu, 5 Oct 2023 09:21:17 -0500
Message-ID: <20231005142117.18671-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

This is now done using binman but this file was leftover and is now
unused, remove it.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 MAINTAINERS                       |  1 -
 arch/arm/mach-k3/config_secure.mk | 44 -------------------------------
 2 files changed, 45 deletions(-)
 delete mode 100644 arch/arm/mach-k3/config_secure.mk

diff --git a/MAINTAINERS b/MAINTAINERS
index 4df79254dfe..de4711721b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1548,7 +1548,6 @@ F:	arch/arm/mach-omap2/omap5/sec_entry_cpu1.S
 F:	arch/arm/mach-omap2/sec-common.c
 F:	arch/arm/mach-omap2/config_secure.mk
 F:	arch/arm/mach-k3/security.c
-F:	arch/arm/mach-k3/config_secure.mk
 F:	configs/am335x_hs_evm_defconfig
 F:	configs/am335x_hs_evm_uart_defconfig
 F:	configs/am43xx_hs_evm_defconfig
diff --git a/arch/arm/mach-k3/config_secure.mk b/arch/arm/mach-k3/config_secure.mk
deleted file mode 100644
index 9cc1f9eb24f..00000000000
--- a/arch/arm/mach-k3/config_secure.mk
+++ /dev/null
@@ -1,44 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Copyright (C) 2018 Texas Instruments, Incorporated - http://www.ti.com/
-#	Andrew F. Davis <afd@ti.com>
-
-quiet_cmd_k3secureimg = SECURE  $@
-ifneq ($(TI_SECURE_DEV_PKG),)
-ifneq ($(wildcard $(TI_SECURE_DEV_PKG)/scripts/secure-binary-image.sh),)
-cmd_k3secureimg = $(TI_SECURE_DEV_PKG)/scripts/secure-binary-image.sh \
-	$< $@ \
-	$(if $(KBUILD_VERBOSE:1=), >/dev/null)
-else
-cmd_k3secureimg = echo "WARNING:" \
-	"$(TI_SECURE_DEV_PKG)/scripts/secure-binary-image.sh not found." \
-	"$@ was NOT secured!"; cp $< $@
-endif
-else
-cmd_k3secureimg = echo "WARNING: TI_SECURE_DEV_PKG environment" \
-	"variable must be defined for TI secure devices." \
-	"$@ was NOT secured!"; cp $< $@
-endif
-
-%.dtb_HS: %.dtb FORCE
-	$(call if_changed,k3secureimg)
-
-$(obj)/u-boot-spl-nodtb.bin_HS: $(obj)/u-boot-spl-nodtb.bin FORCE
-	$(call if_changed,k3secureimg)
-
-tispl.bin_HS: $(obj)/u-boot-spl-nodtb.bin_HS $(patsubst %,$(obj)/dts/%.dtb_HS,$(subst ",,$(CONFIG_SPL_OF_LIST))) $(SPL_ITS) FORCE
-	$(call if_changed,mkfitimage)
-
-MKIMAGEFLAGS_u-boot.img_HS = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
-	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
-	-n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
-	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb_HS,$(subst ",,$(CONFIG_OF_LIST)))
-
-OF_LIST_TARGETS = $(patsubst %,arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST)))
-$(OF_LIST_TARGETS): dtbs
-
-u-boot-nodtb.bin_HS: u-boot-nodtb.bin FORCE
-	$(call if_changed,k3secureimg)
-
-u-boot.img_HS: u-boot-nodtb.bin_HS u-boot.img $(patsubst %.dtb,%.dtb_HS,$(OF_LIST_TARGETS)) FORCE
-	$(call if_changed,mkimage)
-- 
2.39.2

