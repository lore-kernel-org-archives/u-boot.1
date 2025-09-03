Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168ADCA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 10:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10064833BF;
	Wed,  3 Sep 2025 12:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1756897060;
	bh=J/vrGi/myXhBZpCVncuFvcD6zK8VMhkeTJdMxo45vdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g6ANcYLcqgJDezG33FyB2QUXccO8vPNc/s9+tQiAa8SvAAkHu8Ez4A6X8LOCIOUU0
	 v3IkvbLa54k+fod4YYUYNEtLmqFPPTb1uVEWi6D/Ul3m4c0e6aGnmedGuD5/kil3Os
	 o7WpPP8MyvMSRg1EwzBXn3g7+GkamwEH7qxVALi8F4chAVxl4uMe5FblrrL2g1L2Bk
	 RVoDRkE17hVuZ5XegKPJVPWVpFilIeKv+hhuua5SQ/nK3RyOu6vKTnZyVB0yVqKhEj
	 Mwbsd28t57r4zBx9qXkVsitgd2RnzuLO+dH2mtXb+tKd2j1yr3ZbdJiKHoHqBPG1O8
	 0k9UFsWbemMsA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E132833BF; Wed,  3 Sep 2025 12:57:39 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19855835AA
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 12:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="DJ34Fr96"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 17EFC1026E17B; 
 Wed,  3 Sep 2025 12:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1756897056; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=J/vrGi/myXhBZpCVncuFvcD6zK8VMhkeTJdMxo45vdU=;
 b=DJ34Fr96a0b3VWTtXU2O2a7NzHvZI1wHWvYAQgLbJKfxdmi2b/NwMyfHh6DXGRgnYjQtLt
 HnA/gsDdCirkAkENxQ8xk/6I/4aftJ5TGNIJN+mUsI5jJxZybw/avft3w4fC6ZG/EUbaCH
 SSSEP8A0yCjQXWxb6hib72ve2D/7NXE4yeLOvRYf7BRYanmDiAUDE/K2qxipzcTxhboGH8
 /8fVkY0sutfkVHPfpMBzxGxkLHxeACQahcyKKRDKepWZDaPwm7CQykZrAdFkBXzQFKA/BH
 fVzou/M2RhGpbnW2Q9KevBhlCzshWsqpAGXnTEMGYxDWz4+wpECSXoD2I5FvZg==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 4/5] Image size checks: Deduplicate Makefile
Date: Wed,  3 Sep 2025 12:56:52 +0200
Message-Id: <20250903105653.335417-5-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250903105653.335417-1-pro@denx.de>
References: <20250903105653.335417-1-pro@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Deduplicate some redundancies within the SIZE_CHECK code in the toplevel
Makefile. No functional changes.

Note: To make this work for the special case of SPL, spl_size_limit.c
has to print an empty string "" instead of zero when there is no size
limit in place.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---
 Makefile               | 45 +++++++++++-------------------------------
 tools/spl_size_limit.c |  4 ++--
 2 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/Makefile b/Makefile
index a17d8b57196..b6f01591ee9 100644
--- a/Makefile
+++ b/Makefile
@@ -428,8 +428,9 @@ KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 # Check ths size of a binary:
 # Args:
 #   $1: File to check
-#   #2: Size limit in bytes (decimal or 0xhex)
+#   #2: Size limit in bytes (decimal or 0xhex), always return OK if undefined
 define size_check
+	test -z "$2" && exit 0; \
 	actual=$$( wc -c $1 | awk '{print $$1}'); \
 	limit=$$( printf "%d" $2 ); \
 	if test $$actual -gt $$limit; then \
@@ -1103,30 +1104,6 @@ LDPPFLAGS += \
 #########################################################################
 #########################################################################
 
-ifneq ($(CONFIG_BOARD_SIZE_LIMIT),)
-BOARD_SIZE_CHECK= @ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
-else
-BOARD_SIZE_CHECK =
-endif
-
-ifneq ($(CONFIG_SPL_SIZE_LIMIT),)
-SPL_SIZE_CHECK = @$(call size_check,$@,$$(tools/spl_size_limit))
-else
-SPL_SIZE_CHECK =
-endif
-
-ifneq ($(CONFIG_TPL_SIZE_LIMIT),)
-TPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_TPL_SIZE_LIMIT))
-else
-TPL_SIZE_CHECK =
-endif
-
-ifneq ($(CONFIG_VPL_SIZE_LIMIT),)
-VPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_VPL_SIZE_LIMIT))
-else
-VPL_SIZE_CHECK =
-endif
-
 # Statically apply RELA-style relocations (currently arm64 only)
 # This is useful for arm64 where static relocation needs to be performed on
 # the raw binary, but certain simulators only accept an ELF file (but don't
@@ -1470,7 +1447,7 @@ endif
 
 %.imx: $(IMX_DEPS) %.bin
 	$(Q)$(MAKE) $(build)=arch/arm/mach-imx $@
-	$(BOARD_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 
 %.vyb: %.imx
 	$(Q)$(MAKE) $(build)=arch/arm/cpu/armv7/vf610 $@
@@ -1571,11 +1548,11 @@ endif
 
 u-boot-nodtb.bin: u-boot FORCE
 	$(call if_changed,objcopy_uboot)
-	$(BOARD_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 
 u-boot.ldr:	u-boot
 		$(LDR) -T $(CONFIG_LDR_CPU) -c $@ $< $(LDR_FLAGS)
-		$(BOARD_SIZE_CHECK)
+		@$(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 
 # binman
 # ---------------------------------------------------------------------------
@@ -1702,7 +1679,7 @@ u-boot-dtb.img u-boot.img u-boot.kwb u-boot.pbl u-boot-ivt.img: \
 			$(if $(CONFIG_OF_SEPARATE)$(CONFIG_OF_EMBED)$(CONFIG_SANDBOX),dts/dt.dtb) \
 		,$(UBOOT_BIN)) FORCE
 	$(call if_changed,mkimage)
-	$(BOARD_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 
 ifeq ($(CONFIG_SPL_LOAD_FIT_FULL),y)
 MKIMAGEFLAGS_u-boot.itb =
@@ -1717,12 +1694,12 @@ u-boot.itb: u-boot-nodtb.bin \
 		$(if $(CONFIG_MULTI_DTB_FIT),$(FINAL_DTB_CONTAINER)) \
 		$(U_BOOT_ITS) FORCE
 	$(call if_changed,mkfitimage)
-	$(BOARD_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 endif
 
 u-boot-with-spl.kwb: u-boot.bin spl/u-boot-spl.bin FORCE
 	$(call if_changed,mkimage)
-	$(BOARD_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 
 u-boot.dis:	u-boot
 		$(OBJDUMP) -d $< > $@
@@ -2346,7 +2323,7 @@ u-boot.lds: $(LDSCRIPT) prepare FORCE
 
 spl/u-boot-spl.bin: spl/u-boot-spl
 	@:
-	$(SPL_SIZE_CHECK)
+	@$(call size_check,$@,$$(tools/spl_size_limit))
 
 spl/u-boot-spl-dtb.bin: spl/u-boot-spl
 	@:
@@ -2371,14 +2348,14 @@ spl/boot.bin: spl/u-boot-spl
 
 tpl/u-boot-tpl.bin: tpl/u-boot-tpl
 	@:
-	$(TPL_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_TPL_SIZE_LIMIT))
 
 tpl/u-boot-tpl: tools prepare $(if $(CONFIG_TPL_OF_CONTROL),dts/dt.dtb)
 	$(Q)$(MAKE) obj=tpl -f $(srctree)/scripts/Makefile.xpl all
 
 vpl/u-boot-vpl.bin: vpl/u-boot-vpl
 	@:
-	$(VPL_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_VPL_SIZE_LIMIT))
 
 vpl/u-boot-vpl: tools prepare $(if $(CONFIG_TPL_OF_CONTROL),dts/dt.dtb)
 	$(Q)$(MAKE) obj=vpl -f $(srctree)/scripts/Makefile.xpl all
diff --git a/tools/spl_size_limit.c b/tools/spl_size_limit.c
index c6c139e834f..c956a0e2624 100644
--- a/tools/spl_size_limit.c
+++ b/tools/spl_size_limit.c
@@ -10,9 +10,9 @@
 
 int main(int argc, char *argv[])
 {
+#ifdef CONFIG_SPL_SIZE_LIMIT
 	int spl_size_limit = 0;
 
-#ifdef CONFIG_SPL_SIZE_LIMIT
 	spl_size_limit = CONFIG_SPL_SIZE_LIMIT;
 #if defined(CONFIG_IMX_HAB) && defined(CONFIG_CSF_SIZE)
 	spl_size_limit -= CONFIG_CSF_SIZE;
@@ -25,9 +25,9 @@ int main(int argc, char *argv[])
 #endif
 #ifdef CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK
 	spl_size_limit -= CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK;
-#endif
 #endif
 
 	printf("%d", spl_size_limit);
+#endif
 	return 0;
 }
-- 
2.39.5

