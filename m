Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4FDC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 12:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AB6B87EB0;
	Mon,  4 Mar 2024 13:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rpoPLlrD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 807AE87F71; Mon,  4 Mar 2024 13:13:11 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB8987873
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 13:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dbd32cff0bso36145825ad.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 04:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709554387; x=1710159187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XN4l/w/zAVZBUcv/Ol5tjSMiOmwTzSRb1A30ND9fI5A=;
 b=rpoPLlrDsqb8nevBNtYMSs0jWJbksucXLD+rWXaWz7F8jF/lGZlBkufI4IhiO0TVlO
 fwyfzGKWgwUaJvaI0Msc72rPl0vM1QjJMZskpMS4tLB2qSbqQmCyythzzSceRp8vcLAS
 8RbMR3ZeTXWwly9Vm6y+77Qr3QwTqYnfpw85Zt5oEReYlMAKZlY4fwUWw8Gn1eb1NH/8
 DPMUb5Ttah6kUsc4QQwAzRTlNSE4qcBz2HRzQhHGix3PlbLeDs/B/BVMAbX2Tle0FDxK
 MxLFU9493i2MLNbRT45g/fRAIHWnrmQdu1KOasFWHxElLFyL86F/ZWm4Zo7sYLuHouF3
 FOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709554387; x=1710159187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XN4l/w/zAVZBUcv/Ol5tjSMiOmwTzSRb1A30ND9fI5A=;
 b=lZCwDw/nSTecKpGxvTNWgjXLUWezqwQXcgCBAmBlabnyIxrYJJEHt+2BoPagmu6oha
 dwbmhUETdgea6DmqqTGlAZaS0N2tXoIHdBCWZhZobe9JHd0immnVnLpEx9Za28ZjUWbU
 dRxR04uesYJN+Uw9IB1zc63WLUIBBcfDq0EqZosRCprpoRIusv0Nzj9SnMbzslEucaZE
 T0LoHokujfqO8C/W2wPS4vhO/lrxv7mB6/y557EJQyRYg6pTnNyRTaVJSw42rcTCSBPr
 B97PHdRhTAw5QwJLzdt0q3LUkRFSAcPgJGTuUP3hpvwYySZLoTOE7kKGun/5PlRVKE4w
 uyWA==
X-Gm-Message-State: AOJu0YxwAA+O6aCw10zZPCymoWzp3pIOBmakRCzw7QvcstVKZZFABThO
 7NISNnV2Kqa7QEFp62H2aVxfNlqEsnytELLGgtuq1yv3JhLoPnJ64qpJiMuRn1aJV/+WLD6XXfW
 q
X-Google-Smtp-Source: AGHT+IHttVdvUTV8/eLjwq4i3sCsghyiGVLhexr5Ig7n+Vkl7uSAZYpu3t9MxczUBXPXyWZX26H1ZA==
X-Received: by 2002:a17:902:d2d2:b0:1db:f6b0:92d with SMTP id
 n18-20020a170902d2d200b001dbf6b0092dmr10918621plc.6.1709554386861; 
 Mon, 04 Mar 2024 04:13:06 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.98]) by smtp.gmail.com with ESMTPSA id
 b8-20020a170903228800b001db81640315sm8330490plh.91.2024.03.04.04.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 04:13:06 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, bb@ti.com, nm@ti.com,
 festevam@gmail.com, n-francis@ti.com, a-nandan@ti.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4] Makefile: remove hardcoded device tree source directory
Date: Mon,  4 Mar 2024 17:42:57 +0530
Message-Id: <20240304121257.3551104-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
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

From: Bryan Brattlof <bb@ti.com>

Some boards that choose to utilize the OF_UPSTREAM directory for their
device tree files will need to specify that directory instead of the
traditional arch/$(ARCH)/dts/* path.

Include the correct path to the board's dtbs depending on if OF_UPSTREAM
is selected or not.

Signed-off-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Split out as a seperate patch from [1] since it's a dependency for
  other platforms to switch to OF_UPSTREAM.
- Removed further hardcoded arch/$(ARCH)/dts/* path.

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=396742

 Makefile             | 22 ++++++++++++++++------
 scripts/Makefile.spl | 17 +++++++++++++----
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 2643d1839b63..ff742ea3a8b8 100644
--- a/Makefile
+++ b/Makefile
@@ -1184,6 +1184,16 @@ dt_binding_check: scripts_dtc
 quiet_cmd_copy = COPY    $@
       cmd_copy = cp $< $@
 
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+ifeq ($(CONFIG_ARM64),y)
+dt_dir := dts/upstream/src/arm64
+else
+dt_dir := dts/upstream/src/$(ARCH)
+endif
+else
+dt_dir := arch/$(ARCH)/dts
+endif
+
 ifeq ($(CONFIG_MULTI_DTB_FIT),y)
 
 ifeq ($(CONFIG_MULTI_DTB_FIT_LZO),y)
@@ -1209,7 +1219,7 @@ endif
 
 MKIMAGEFLAGS_fit-dtb.blob = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
 	-a 0 -e 0 -E \
-	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) -d /dev/null
+	$(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) -d /dev/null
 
 MKIMAGEFLAGS_fit-dtb.blob += -B 0x8
 
@@ -1362,7 +1372,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		build -u -d u-boot.dtb -O . -m \
 		--allow-missing $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
 		-I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
-		-I arch/$(ARCH)/dts -a of-list=$(CONFIG_OF_LIST) \
+		-I $(dt_dir) -a of-list=$(CONFIG_OF_LIST) \
 		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
 		-a atf-bl31-path=${BL31} \
 		-a tee-os-path=${TEE} \
@@ -1398,7 +1408,7 @@ ifneq ($(CONFIG_USE_SPL_FIT_GENERATOR),)
 U_BOOT_ITS := u-boot.its
 $(U_BOOT_ITS): $(U_BOOT_ITS_DEPS) FORCE
 	$(srctree)/$(CONFIG_SPL_FIT_GENERATOR) \
-	$(patsubst %,arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) > $@
+	$(patsubst %,$(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) > $@
 endif
 endif
 
@@ -1407,9 +1417,9 @@ MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
 	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
 	-p $(CONFIG_FIT_EXTERNAL_OFFSET) \
 	-n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
-	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(DEVICE_TREE))) \
-	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) \
-	$(patsubst %,-b arch/$(ARCH)/dts/%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
+	$(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(DEVICE_TREE))) \
+	$(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) \
+	$(patsubst %,-b $(dt_dir)/%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
 else
 MKIMAGEFLAGS_u-boot.img = -A $(ARCH) -T firmware -C none -O u-boot \
 	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
diff --git a/scripts/Makefile.spl b/scripts/Makefile.spl
index 407fc52376a5..d074ba235006 100644
--- a/scripts/Makefile.spl
+++ b/scripts/Makefile.spl
@@ -559,9 +559,15 @@ FORCE:
 $(obj)/dts/dt-$(SPL_NAME).dtb: dts/dt.dtb
 	$(Q)$(MAKE) $(build)=$(obj)/dts spl_dtbs
 
-PHONY += dts_dir
-dts_dir:
-	$(shell [ -d $(obj)/dts ] || mkdir -p $(obj)/dts)
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+ifeq ($(CONFIG_ARM64),y)
+dt_dir := dts/upstream/src/arm64
+else
+dt_dir := dts/upstream/src/$(ARCH)
+endif
+else
+dt_dir := arch/$(ARCH)/dts
+endif
 
 # Declare the contents of the .PHONY variable as phony.  We keep that
 # information in a variable so we can use it in if_changed and friends.
@@ -569,8 +575,11 @@ dts_dir:
 
 SPL_OF_LIST_TARGETS = $(patsubst %,dts/%.dtb,$(subst ",,$(CONFIG_SPL_OF_LIST)))
 SHRUNK_ARCH_DTB = $(addprefix $(obj)/,$(SPL_OF_LIST_TARGETS))
+$(dir $(SHRUNK_ARCH_DTB)):
+	$(shell [ -d $@ ] || mkdir -p $@)
+
 .SECONDEXPANSION:
-$(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, arch/$(ARCH)/dts/%, $$@) dts_dir
+$(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, $(dt_dir)/%, $$@) $(dir $(SHRUNK_ARCH_DTB))
 	$(call if_changed,fdtgrep)
 
 targets += $(SPL_OF_LIST_TARGETS)
-- 
2.34.1

