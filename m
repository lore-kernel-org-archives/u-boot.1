Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEFECCD18E
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 01:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CF28833F6;
	Wed, 15 Oct 2025 03:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1760491428;
	bh=ANfmvhFAIdgGwRnQv46NNl/6hN1MZutcIfKlkftgw10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WtEGYQToy1Nu0vQe4R4n3cwSvncu32SL8K1zcNHMWRolbXG8Tnd71zLTDvyd8Z038
	 w2wIRUiiMNyCBrxY9mBTHTJeDSFG6AMuqiF59KYWRYMh7Q3IsNKG5Cmp4K15TwuGHY
	 Wur2jFlvv/oAfc84Hc0isAdFi8CHZIOx4XSKJOolV4vFfyJK0qao7lCqbHCm1C4VHC
	 Qztw1wWeJDncQQUanABGwYtb1L8f3BdNglv4EaGDjzDUdnbrTgeM22aHoCvnbZ1WKz
	 VCt2osdARxWs7CcPWrxxlL1QPiF+7uqFC+5kgJbj8Cm5r40w9AfjqYWf2tnvnrncwb
	 lBvQRO7Dzf+Fw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92118800D7; Wed, 15 Oct 2025 03:23:47 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C05F835B0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 03:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BGbUAa39"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EE74E101CFA0F; 
 Wed, 15 Oct 2025 03:23:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1760491424; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ANfmvhFAIdgGwRnQv46NNl/6hN1MZutcIfKlkftgw10=;
 b=BGbUAa39uYSJ2Agi+yYdBr9dFGjl42Ls+jREePOd1TmpzmHFjRidgxRo2MHonUYg71l0NR
 0oPhxVx+umIziR/LV3hBvlVdvxMGdIDbvqvFjO1IT3MAkjw1LWt3RVrJC/z3vXt7qRK61u
 JhuyfoIgV98d/ge2vwmZ8x7x0h4r29zXR5ow1UxVfBwQMWa8lt0MBgw88bE+oIQ9o/VmdZ
 AIaNoQ13CdzRbJmRUr1zyLiPE4W8KuPRqm7GKHjl4cl25Z0kF5f11T5qCUHY+pC5Q0kus4
 xfixF2YGJOa9qDY+B6l8lBjESD3bxMbOUSVPk7PCJpqwMOiaK47UwlPs7U5R4w==
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
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v4 3/3] Image size checks: Deduplicate Makefile
Date: Wed, 15 Oct 2025 03:23:20 +0200
Message-Id: <20251015012320.2331007-4-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251015012320.2331007-1-pro@denx.de>
References: <20251015012320.2331007-1-pro@denx.de>
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

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---

Notes:
    Changes in v4:
    	- Pass CONFIG_HAS_XXX_SIZE_LIMIT as an argument to size_check()

 Makefile | 48 +++++++++++++-----------------------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/Makefile b/Makefile
index e68dce2c1d5..7b19610335f 100644
--- a/Makefile
+++ b/Makefile
@@ -428,10 +428,12 @@ KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 # Check ths size of a binary:
 # Args:
 #   $1: File to check
-#   #2: Size limit in bytes (decimal or 0xhex)
+#   $2: Always return OK if this is not "y".
+#   $3: Size limit in bytes (decimal or 0xhex)
 define size_check
+	test "$2" = "y" || exit 0; \
 	actual=$$( wc -c $1 | awk '{print $$1}'); \
-	limit=$$( printf "%d" $2 ); \
+	limit=$$( printf "%d" $3 ); \
 	if test $$actual -gt $$limit; then \
 		echo "$1 exceeds file size limit:" >&2; \
 		echo "  limit:  $$(printf %#x $$limit) bytes" >&2; \
@@ -1103,30 +1105,6 @@ LDPPFLAGS += \
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
@@ -1470,7 +1448,7 @@ endif
 
 %.imx: $(IMX_DEPS) %.bin
 	$(Q)$(MAKE) $(build)=arch/arm/mach-imx $@
-	$(BOARD_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_HAS_BOARD_SIZE_LIMIT),$(CONFIG_BOARD_SIZE_LIMIT))
 
 %.vyb: %.imx
 	$(Q)$(MAKE) $(build)=arch/arm/cpu/armv7/vf610 $@
@@ -1571,11 +1549,11 @@ endif
 
 u-boot-nodtb.bin: u-boot FORCE
 	$(call if_changed,objcopy_uboot)
-	$(BOARD_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_HAS_BOARD_SIZE_LIMIT),$(CONFIG_BOARD_SIZE_LIMIT))
 
 u-boot.ldr:	u-boot
 		$(LDR) -T $(CONFIG_LDR_CPU) -c $@ $< $(LDR_FLAGS)
-		$(BOARD_SIZE_CHECK)
+		@$(call size_check,$@,$(CONFIG_HAS_BOARD_SIZE_LIMIT),$(CONFIG_BOARD_SIZE_LIMIT))
 
 # binman
 # ---------------------------------------------------------------------------
@@ -1702,7 +1680,7 @@ u-boot-dtb.img u-boot.img u-boot.kwb u-boot.pbl u-boot-ivt.img: \
 			$(if $(CONFIG_OF_SEPARATE)$(CONFIG_OF_EMBED)$(CONFIG_SANDBOX),dts/dt.dtb) \
 		,$(UBOOT_BIN)) FORCE
 	$(call if_changed,mkimage)
-	$(BOARD_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_HAS_BOARD_SIZE_LIMIT),$(CONFIG_BOARD_SIZE_LIMIT))
 
 ifeq ($(CONFIG_SPL_LOAD_FIT_FULL),y)
 MKIMAGEFLAGS_u-boot.itb =
@@ -1717,12 +1695,12 @@ u-boot.itb: u-boot-nodtb.bin \
 		$(if $(CONFIG_MULTI_DTB_FIT),$(FINAL_DTB_CONTAINER)) \
 		$(U_BOOT_ITS) FORCE
 	$(call if_changed,mkfitimage)
-	$(BOARD_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_HAS_BOARD_SIZE_LIMIT),$(CONFIG_BOARD_SIZE_LIMIT))
 endif
 
 u-boot-with-spl.kwb: u-boot.bin spl/u-boot-spl.bin FORCE
 	$(call if_changed,mkimage)
-	$(BOARD_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_HAS_BOARD_SIZE_LIMIT),$(CONFIG_BOARD_SIZE_LIMIT))
 
 u-boot.dis:	u-boot
 		$(OBJDUMP) -d $< > $@
@@ -2346,7 +2324,7 @@ u-boot.lds: $(LDSCRIPT) prepare FORCE
 
 spl/u-boot-spl.bin: spl/u-boot-spl
 	@:
-	$(SPL_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_HAS_SPL_SIZE_LIMIT),$$(tools/spl_size_limit))
 
 spl/u-boot-spl-dtb.bin: spl/u-boot-spl
 	@:
@@ -2371,14 +2349,14 @@ spl/boot.bin: spl/u-boot-spl
 
 tpl/u-boot-tpl.bin: tpl/u-boot-tpl
 	@:
-	$(TPL_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_HAS_TPL_SIZE_LIMIT),$(CONFIG_TPL_SIZE_LIMIT))
 
 tpl/u-boot-tpl: tools prepare $(if $(CONFIG_TPL_OF_CONTROL),dts/dt.dtb)
 	$(Q)$(MAKE) obj=tpl -f $(srctree)/scripts/Makefile.xpl all
 
 vpl/u-boot-vpl.bin: vpl/u-boot-vpl
 	@:
-	$(VPL_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_HAS_VPL_SIZE_LIMIT),$(CONFIG_VPL_SIZE_LIMIT))
 
 vpl/u-boot-vpl: tools prepare $(if $(CONFIG_TPL_OF_CONTROL),dts/dt.dtb)
 	$(Q)$(MAKE) obj=vpl -f $(srctree)/scripts/Makefile.xpl all
-- 
2.39.5

