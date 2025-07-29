Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A188BC87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 12:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A077A82ADA;
	Tue, 29 Jul 2025 14:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1753792078;
	bh=TyAdY2TwumFIVEdIjD1y3KNFq0sngQuy6rX+e80oIfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m8UTzFJIjhlZ7NfdMf9ULWDf0yZV6cxlY9o9O1iUY2u7YakdBsBdjV5bCtuhyx0ii
	 gwf4gCyodnsCMQPHw7QF7pBo4w6IEREGjTe1SKsLt3tXX170uWjmX2jDt0oh65+F3v
	 muDW3cRD99G1HBuw3CaOIH1ZdstrDrHql5yppMf1zl6PihtRLUR7C3ixAbNNo0RcUo
	 qLwDcRXLPok+lOErMv9MfFIao4yvEdIS3ajY1gz4tnZkJT+3uPblY8wmqSjF3vtPLq
	 PCdOW0oNEiL5eXKYZSfGoaJYKVGjHPltZFXtVzQS0BJ27MLzFMgQzK1C01L+ipZKBI
	 kj9J7qltxsFeg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACBF182B07; Tue, 29 Jul 2025 14:27:57 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EA2A800C1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 14:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VpzVLvK2"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DFFBF1038C126; 
 Tue, 29 Jul 2025 14:27:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1753792073; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=TyAdY2TwumFIVEdIjD1y3KNFq0sngQuy6rX+e80oIfw=;
 b=VpzVLvK2AYaHCNpAFdlrPEFA7ta0zFgGNWmnUEZ1/VpgpLW42i98/umrfSB0HRSj5dGTk1
 D97/69KskTInJQx2qp09bXCzEdCSVYsJhkn0l1kk3Ur7x6EZF+ZpWsNXcZfFkPgTrcVrF3
 S8gU2ElOxLm+2vmDC5Xh6FCuUrWbALoF1A8iI8A/fY4p8XVB3gqRH/Sdqefe1zDJmWxjUc
 XrfH7KwyYocACQn105RGLOwL0aB8q/6ejJUOVmV9sieF20zAdjYXumoGQPMwAtM0zontes
 E9AhvghpTNN+ievadsQiazZ42xAX+qA/XP++vUAj5uiZcLFWvEvWtI/CoMiw/Q==
Date: Tue, 29 Jul 2025 14:27:49 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v4 1/3] Makefile: Add size check for u-boot-with-spl.bin
Message-ID: <aIi-Rb3C_1i_IQDr@antares>
References: <20250708103959.26129-1-pro@denx.de>
 <20250708103959.26129-2-pro@denx.de>
 <20250728222531.GA1754718@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728222531.GA1754718@bill-the-cat>
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

Hi Tom,

On Mon, Jul 28, 2025 at 04:25:31PM -0600, Tom Rini wrote:
> On Tue, Jul 08, 2025 at 12:39:57PM +0200, Philip Oberfichtner wrote:
> 
> > Like other images, u-boot-with-spl.bin may be subject to size
> > restrictions. Extend CONFIG_SPL_SIZE_LIMIT to handle this case.
> > 
> > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > ---
> > 
> > Notes:
> >     Changes in v4: none
> >     
> >     Changes in v3:
> >     	Reuse existing SPL_SIZE_LIMIT instead of implementing a new option
> >     
> >     Changes in v2: none
> > 
> >  Makefile           | 1 +
> >  common/spl/Kconfig | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> This is not quite right enough, sorry. This causes a number of boards
> (evb-ast2600 ibm-sbp1 stm32746g-eval_spl stm32f746-disco_spl
> stm32f769-disco_spl) which have size checks and are fine to now fail
> their size checks, presumably because they're checking the "wrong" file
> now or similar.

Thanks for pointing that out. To sum it up: If those boards use
SPL_SIZE_LIMIT to restrict the size of an SPL-only image, then
u-boot-with-spl.bin, of course, can be too large and the build fails.

Plus in our previous discussion, we figured out why using
BOARD_SIZE_LIMIT also isn't suitable:
https://lore.kernel.org/u-boot/aD2EflR9DRYG-MY5@antares/

So from here I really don't see any better way than introducing yet
another CONFIG_*SIZE_LIMIT option.


But maybe we can however simplify and deduplicate some of the code. What
do you think about something like that (I have not yet tested it, just
a rough idea so far):


diff --git a/Makefile b/Makefile
index 32c036d531d..6f75b371e11 100644
--- a/Makefile
+++ b/Makefile
@@ -372,7 +372,7 @@ endif
 define size_check
 	actual=$$( wc -c $1 | awk '{print $$1}'); \
 	limit=$$( printf "%d" $2 ); \
-	if test $$actual -gt $$limit; then \
+	if test $$limit -gt 0 && test $$actual -gt $$limit; then \
 		echo "$1 exceeds file size limit:" >&2; \
 		echo "  limit:  $$(printf %#x $$limit) bytes" >&2; \
 		echo "  actual: $$(printf %#x $$actual) bytes" >&2; \
@@ -939,30 +939,6 @@ LDPPFLAGS += \
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
@@ -1266,7 +1242,7 @@ endif
 
 %.imx: $(IMX_DEPS) %.bin
 	$(Q)$(MAKE) $(build)=arch/arm/mach-imx $@
-	$(BOARD_SIZE_CHECK)
+	@ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 
 %.vyb: %.imx
 	$(Q)$(MAKE) $(build)=arch/arm/cpu/armv7/vf610 $@
@@ -1367,12 +1343,12 @@ endif
 
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
@@ -1498,7 +1474,7 @@ u-boot-dtb.img u-boot.img u-boot.kwb u-boot.pbl u-boot-ivt.img: \
 			$(if $(CONFIG_OF_SEPARATE)$(CONFIG_OF_EMBED)$(CONFIG_SANDBOX),dts/dt.dtb) \
 		,$(UBOOT_BIN)) FORCE
 	$(call if_changed,mkimage)
-	$(BOARD_SIZE_CHECK)
+	@ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
 
 ifeq ($(CONFIG_SPL_LOAD_FIT_FULL),y)
 MKIMAGEFLAGS_u-boot.itb =
@@ -1513,12 +1489,12 @@ u-boot.itb: u-boot-nodtb.bin \
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
@@ -1535,7 +1511,7 @@ OBJCOPYFLAGS_u-boot-with-spl.bin = -I binary -O binary \
 				   --pad-to=$(CONFIG_SPL_PAD_TO)
 u-boot-with-spl.bin: $(SPL_IMAGE) $(SPL_PAYLOAD) FORCE
 	$(call if_changed,pad_cat)
-	$(SPL_SIZE_CHECK)
+	@$(call size_check,$@,$$(tools/spl_size_limit))
 
 ifeq ($(CONFIG_ARCH_LPC32XX)$(CONFIG_SPL),yy)
 MKIMAGEFLAGS_lpc32xx-spl.img = -T lpc32xximage -a $(CONFIG_SPL_TEXT_BASE)
@@ -2108,7 +2084,7 @@ u-boot.lds: $(LDSCRIPT) prepare FORCE
 
 spl/u-boot-spl.bin: spl/u-boot-spl
 	@:
-	$(SPL_SIZE_CHECK)
+	@$(call size_check,$@,$$(tools/spl_size_limit))
 
 spl/u-boot-spl-dtb.bin: spl/u-boot-spl
 	@:
@@ -2133,14 +2109,14 @@ spl/boot.bin: spl/u-boot-spl
 
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

