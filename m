Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE17DC87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05BC983858;
	Thu, 31 Jul 2025 13:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1753962070;
	bh=Uq+rBTIO8xrV72rvfUDaHQ/pWFDy8K4eYMAU8WbQqso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lFTqBMWhiV81/wv4dQLnE/B6A6++fDztPb1iBeVUOfoOdB/lJGGxLBBWJ1uhV7gaD
	 4J0KIsHHQwoMbDAyB/EIEjr+RJdD+dKT2CuyOLaqlo21PeROsvUVXtoqrcIkoPE80r
	 6R2ZeNvlknP5FdJx0K0eFceeDwuR7GY7IXXa96w/+C97aZQksrUX/dTssoU6bXqAwW
	 aNCyf0CZYyvaHY48Ywe0B/aL13PGBJl9MBKRTWAyyNaYo1rjWVCdhZmyGkAdqUxNcx
	 HNy3nDlOsqhtk9P4/V2sS/Rwh9FyOCvZ3/pYyORAYXRi0jTtNewg6i5D+xw9cgg19h
	 bReFE7IH7SwNA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0165383816; Thu, 31 Jul 2025 13:41:09 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 791CE83858
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ekaDuC0V"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 312201038C128; 
 Thu, 31 Jul 2025 13:41:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1753962065; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Uq+rBTIO8xrV72rvfUDaHQ/pWFDy8K4eYMAU8WbQqso=;
 b=ekaDuC0V5uMvkk11rwEP3tLh+6efIOTXfdpkdPU+ZdUZfSh6i/3hvL5S3fvYLQBv2G3Ux7
 amj4eHYvS/ph4DFhGedlC7Hlu2tw41wtENPPmHA8yPfoReDpkgrS0qoXzmEjGu6LBnqsJO
 Yjw3ffqPZTS9kUrrM1Yn3hUz72cCI+pcqOQtsLBUujkjRQRAWac3HQql0q5nFl/ww37d4w
 87nQsPSbE604EjPkEwx8TDqrS02vGj1jT7+DFJlG6ufWjgBOqGP3ox6HrLUBhA5T0fR/zW
 4wKw3ybPatZLX/MfQGfjijRNg2CcWQZhLoFahEiRO6bsBJjK3f/u93VQu7nOnA==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Gary Bisson <bisson.gary@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: [RFC PATCH v1 1/3] Image size checks: Simplify Makefile rules
Date: Thu, 31 Jul 2025 13:40:42 +0200
Message-Id: <20250731114044.264745-2-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731114044.264745-1-pro@denx.de>
References: <20250731114044.264745-1-pro@denx.de>
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

Deduplicate some of the size check code within the toplevel Makefile.
No functional changes.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---
 Makefile               | 44 ++++++++++--------------------------------
 tools/spl_size_limit.c |  2 +-
 2 files changed, 11 insertions(+), 35 deletions(-)

diff --git a/Makefile b/Makefile
index c31bf7ecea9..aefa44c327f 100644
--- a/Makefile
+++ b/Makefile
@@ -432,7 +432,7 @@ KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 define size_check
 	actual=$$( wc -c $1 | awk '{print $$1}'); \
 	limit=$$( printf "%d" $2 ); \
-	if test $$actual -gt $$limit; then \
+	if test $$limit -gt 0 && test $$actual -gt $$limit; then \
 		echo "$1 exceeds file size limit:" >&2; \
 		echo "  limit:  $$(printf %#x $$limit) bytes" >&2; \
 		echo "  actual: $$(printf %#x $$actual) bytes" >&2; \
@@ -1103,30 +1103,6 @@ LDPPFLAGS += \
 #########################################################################
 #########################################################################
 
-ifneq ($(CONFIG_BOARD_SIZE_LIMIT),)
-BOARD_SIZE_CHECK= @ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
-else
-BOARD_SIZE_CHECK =
-endif
-
-ifneq ($(CONFIG_SPL_SIZE_LIMIT),0x0)
-SPL_SIZE_CHECK = @$(call size_check,$@,$$(tools/spl_size_limit))
-else
-SPL_SIZE_CHECK =
-endif
-
-ifneq ($(CONFIG_TPL_SIZE_LIMIT),0x0)
-TPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_TPL_SIZE_LIMIT))
-else
-TPL_SIZE_CHECK =
-endif
-
-ifneq ($(CONFIG_VPL_SIZE_LIMIT),0x0)
-VPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_VPL_SIZE_LIMIT))
-else
-VPL_SIZE_CHECK =
-endif
-
 # Statically apply RELA-style relocations (currently arm64 only)
 # This is useful for arm64 where static relocation needs to be performed on
 # the raw binary, but certain simulators only accept an ELF file (but don't
@@ -1470,7 +1446,7 @@ endif
 
 %.imx: $(IMX_DEPS) %.bin
 	$(Q)$(MAKE) $(build)=arch/arm/mach-imx $@
-	$(BOARD_SIZE_CHECK)
+	@ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 
 %.vyb: %.imx
 	$(Q)$(MAKE) $(build)=arch/arm/cpu/armv7/vf610 $@
@@ -1571,12 +1547,12 @@ endif
 
 u-boot-nodtb.bin: u-boot FORCE
 	$(call if_changed,objcopy_uboot)
-	$(BOARD_SIZE_CHECK)
+	@ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 
 u-boot.ldr:	u-boot
 		$(CREATE_LDR_ENV)
 		$(LDR) -T $(CONFIG_LDR_CPU) -c $@ $< $(LDR_FLAGS)
-		$(BOARD_SIZE_CHECK)
+		@ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 
 # binman
 # ---------------------------------------------------------------------------
@@ -1703,7 +1679,7 @@ u-boot-dtb.img u-boot.img u-boot.kwb u-boot.pbl u-boot-ivt.img: \
 			$(if $(CONFIG_OF_SEPARATE)$(CONFIG_OF_EMBED)$(CONFIG_SANDBOX),dts/dt.dtb) \
 		,$(UBOOT_BIN)) FORCE
 	$(call if_changed,mkimage)
-	$(BOARD_SIZE_CHECK)
+	@ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 
 ifeq ($(CONFIG_SPL_LOAD_FIT_FULL),y)
 MKIMAGEFLAGS_u-boot.itb =
@@ -1718,12 +1694,12 @@ u-boot.itb: u-boot-nodtb.bin \
 		$(if $(CONFIG_MULTI_DTB_FIT),$(FINAL_DTB_CONTAINER)) \
 		$(U_BOOT_ITS) FORCE
 	$(call if_changed,mkfitimage)
-	$(BOARD_SIZE_CHECK)
+	@ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 endif
 
 u-boot-with-spl.kwb: u-boot.bin spl/u-boot-spl.bin FORCE
 	$(call if_changed,mkimage)
-	$(BOARD_SIZE_CHECK)
+	@ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 
 u-boot.dis:	u-boot
 		$(OBJDUMP) -d $< > $@
@@ -2342,7 +2318,7 @@ u-boot.lds: $(LDSCRIPT) prepare FORCE
 
 spl/u-boot-spl.bin: spl/u-boot-spl
 	@:
-	$(SPL_SIZE_CHECK)
+	@$(call size_check,$@,$$(tools/spl_size_limit))
 
 spl/u-boot-spl-dtb.bin: spl/u-boot-spl
 	@:
@@ -2367,14 +2343,14 @@ spl/boot.bin: spl/u-boot-spl
 
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
index c6c139e834f..137f0fca898 100644
--- a/tools/spl_size_limit.c
+++ b/tools/spl_size_limit.c
@@ -28,6 +28,6 @@ int main(int argc, char *argv[])
 #endif
 #endif
 
-	printf("%d", spl_size_limit);
+	printf("%d", spl_size_limit > 0 ? spl_size_limit : 0);
 	return 0;
 }
-- 
2.39.5

