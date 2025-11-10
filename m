Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85DCCCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 09:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C53E8839E2;
	Mon, 10 Nov 2025 10:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1762766025;
	bh=sPfSpi6BKj9TAZaFaxngNO1CZmJIHX0Px/6gmkCEBbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T+A3en3PGsUuTH+joUh1sN0ApVpwQv1A+MGbuGC/obLMROVekhX1eNlc3WKSHjfiw
	 wox0Fbv2tR9WNbwVg0vzuHGtv674XG1viTRLxvNQq6zi5rSmjj1vNfsFL/vmCEkuNN
	 260nC7QtgCMdoWCfnUgLDWbukfZbYRJRnnjL2XJFcYXTNyhK2Zfnt4sed4p5D8fMz0
	 bnOZ8WEe5QHWjYj5efwCU8Nm8THwPb5zqqoa02GwzEQUw76w1DSxb9RK0q4acCLAoN
	 G9/mecpmdFqlNoZ/JOoqwT61sB6TvD+aXI2LkOB7R51vQ1qEPPxJZsQhx/LT1UbLMv
	 M9cnLNeLIq+zA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C063839DE; Mon, 10 Nov 2025 10:13:44 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86D0A839E2
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 10:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="E1HC/Pz7"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0DA501003BD63; Mon, 10 Nov 2025 10:13:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1762766022; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=sPfSpi6BKj9TAZaFaxngNO1CZmJIHX0Px/6gmkCEBbc=;
 b=E1HC/Pz7EY+2wqS3V5YctxCBD+7G17yscQohbTyOfrrvbDrPHzzW/ZempzQRv/8BD5o9z8
 jtwMUHbpuBab5UHZP8GFmk90a+zYk3aJVnmzq1yxdG2RBOWVYWeFFiDtVoTFtAGzAbGpMY
 xb2bvjYBDQDALJhrE/UsJnfHO6uXD/rW879ltuTLRPKZYsQN9TPZlpyj+B9PrVFYfHFAtz
 4e41lpPTinLVh7fYHqB5vDu7WU5N4JWuQLmMmDeubbmKXZ75iweS+y1kslWvJm9DQ5le26
 3GLI1eEHaMWb/vUavr1yEs4wmg55ubTRosxFzhf/VAbZVrMi2aAU8/S4xMH+pA==
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
Subject: [PATCH v5 3/3] Makefile: Deduplicate image size checks
Date: Mon, 10 Nov 2025 10:12:56 +0100
Message-Id: <20251110091256.2422534-4-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251110091256.2422534-1-pro@denx.de>
References: <20251110091256.2422534-1-pro@denx.de>
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
    Changes in v5: Improve commit message

 Makefile | 48 +++++++++++++-----------------------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/Makefile b/Makefile
index 617106ad79e..423a86ff4e8 100644
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
@@ -1104,30 +1106,6 @@ LDPPFLAGS += \
 #########################################################################
 #########################################################################
 
-ifeq ($(CONFIG_HAS_BOARD_SIZE_LIMIT),y)
-BOARD_SIZE_CHECK= @ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
-else
-BOARD_SIZE_CHECK =
-endif
-
-ifeq ($(CONFIG_HAS_SPL_SIZE_LIMIT),y)
-SPL_SIZE_CHECK = @$(call size_check,$@,$$(tools/spl_size_limit))
-else
-SPL_SIZE_CHECK =
-endif
-
-ifeq ($(CONFIG_HAS_TPL_SIZE_LIMIT),y)
-TPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_TPL_SIZE_LIMIT))
-else
-TPL_SIZE_CHECK =
-endif
-
-ifeq ($(CONFIG_HAS_VPL_SIZE_LIMIT),y)
-VPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_VPL_SIZE_LIMIT))
-else
-VPL_SIZE_CHECK =
-endif
-
 # Statically apply RELA-style relocations (currently arm64 only)
 # This is useful for arm64 where static relocation needs to be performed on
 # the raw binary, but certain simulators only accept an ELF file (but don't
@@ -1471,7 +1449,7 @@ endif
 
 %.imx: $(IMX_DEPS) %.bin
 	$(Q)$(MAKE) $(build)=arch/arm/mach-imx $@
-	$(BOARD_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_HAS_BOARD_SIZE_LIMIT),$(CONFIG_BOARD_SIZE_LIMIT))
 
 %.vyb: %.imx
 	$(Q)$(MAKE) $(build)=arch/arm/cpu/armv7/vf610 $@
@@ -1572,11 +1550,11 @@ endif
 
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
@@ -1703,7 +1681,7 @@ u-boot-dtb.img u-boot.img u-boot.kwb u-boot.pbl u-boot-ivt.img: \
 			$(if $(CONFIG_OF_SEPARATE)$(CONFIG_OF_EMBED)$(CONFIG_SANDBOX),dts/dt.dtb) \
 		,$(UBOOT_BIN)) FORCE
 	$(call if_changed,mkimage)
-	$(BOARD_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_HAS_BOARD_SIZE_LIMIT),$(CONFIG_BOARD_SIZE_LIMIT))
 
 ifeq ($(CONFIG_SPL_LOAD_FIT_FULL),y)
 MKIMAGEFLAGS_u-boot.itb =
@@ -1718,12 +1696,12 @@ u-boot.itb: u-boot-nodtb.bin \
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
@@ -2347,7 +2325,7 @@ u-boot.lds: $(LDSCRIPT) prepare FORCE
 
 spl/u-boot-spl.bin: spl/u-boot-spl
 	@:
-	$(SPL_SIZE_CHECK)
+	@$(call size_check,$@,$(CONFIG_HAS_SPL_SIZE_LIMIT),$$(tools/spl_size_limit))
 
 spl/u-boot-spl-dtb.bin: spl/u-boot-spl
 	@:
@@ -2372,14 +2350,14 @@ spl/boot.bin: spl/u-boot-spl
 
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

