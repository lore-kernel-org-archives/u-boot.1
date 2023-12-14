Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30914C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 13:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D887187A8A;
	Thu, 14 Dec 2023 14:52:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ufeWsX2U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD1FA87A8B; Thu, 14 Dec 2023 14:52:12 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8570187A8E
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 14:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2888c80994bso4726684a91.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 05:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702561927; x=1703166727; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TnzdH67t338vIUJxhhWpafn7v8Et2UIYp9pfQ6QVcw=;
 b=ufeWsX2UkeLIMWzKiOB+uyTbR/Z4XMAOVJhOTkONE1XuQb0G1BIYkWsBRjq16semVI
 aKmuh2tNcVJ+IRdxnQjsLIz24Ng7V5iK2RyQeNVKkD6F0q2HXaKTpgu+QVJfVyklgxCf
 Jox2x70sHkIugk3JooGDiRP5AIRJ0kZjZSuDOucYicoiMwF4lJMxe97pYjc0/B1rIBdw
 ii+TKLzsEJnBHj8roWi8KR34kXG42Kl1OXs7D0Cz8gecKUYskUM86UR8Tmxj4Ij6H2s/
 0EXqGl1pPKk2gH1NawuE/wMNAbIPC7mJ2NSP9bdT79pQgr3Sg8p6Lst2cxUv3dpYX+jW
 5TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702561927; x=1703166727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1TnzdH67t338vIUJxhhWpafn7v8Et2UIYp9pfQ6QVcw=;
 b=V5QG0jrk0mZ/Ee0iU1naQ6i/kUXd8V3zlgAYgq+xPKrc4pES4JXwfV4XOYbkCTwfmv
 j8W4HNiq7PPAOfLBwyYC25u5nAnWPeqJ9i/Aa3+U2VZ9Ws8b1XhXg0W3b6zVFqIoCOVh
 1jVqD0uUzZsazh+2fE0xZw99SK7lKzP+f4ncs/gKi5S5wAHD13MVLSDHDG80SnfxWfMm
 Ur7zqiVunoKu0zUX7ZAC2YPdBMht3fAuomyhkafTVYiew295pTAUdq5Ii88/Q0yhqVEG
 t6W+Vo3eVjSgxAev4TnpbIvi3l4WGRqgnrvOD7kAVbI3OTl/+LBxahxpWBhM64dDJQzM
 PDUg==
X-Gm-Message-State: AOJu0YySk6JQv3dreS06M2dmcrMGefdjeLpX5Tw624Li+bzcKUo35N+n
 DlSBsBzJp2biVCkk+s+A43uvIPjdvhFsuEyc8nIL4g==
X-Google-Smtp-Source: AGHT+IEp1+U5D/9ja566fAuIiB5r0f1xEv86WfXVgdQsd5FTHsuFlzaiJqitblDdHWHkcgOdkC9f9w==
X-Received: by 2002:a17:902:bb16:b0:1d3:51d3:f8c7 with SMTP id
 im22-20020a170902bb1600b001d351d3f8c7mr1148141plb.3.1702561927575; 
 Thu, 14 Dec 2023 05:52:07 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 05:52:07 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 4/8] dts: Add alternative location for upstream DTB builds
Date: Thu, 14 Dec 2023 19:20:59 +0530
Message-Id: <20231214135103.1606605-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
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

Allow platform owners to mirror devicetree files from devitree-rebasing
directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). Then
build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dts
directory.

This will help easy migration for platforms which currently are compliant
with upstream Linux kernel devicetree files.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 dts/Kconfig             | 11 +++++++++++
 dts/Makefile            | 17 ++++++++++++++---
 dts/arch/arm64/Makefile | 14 ++++++++++++++
 3 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 dts/arch/arm64/Makefile

diff --git a/dts/Kconfig b/dts/Kconfig
index 00c0aeff893..96396f12b67 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -85,6 +85,17 @@ config OF_LIVE
 	  enables a live tree which is available after relocation,
 	  and can be adjusted as needed.
 
+config OF_UPSTREAM
+	bool "Enable use of devicetree imported from Linux kernel release"
+	help
+	  Traditionally, U-boot platforms used to have their custom devicetree
+	  files or copy devicetree files from Linux kernel which are hard to
+	  maintain and can usually get out-of-sync from Linux kernel. This
+	  option enables platforms to migrate to devicetree-rebasing repo where
+	  a regular sync will be maintained every major Linux kernel release
+	  cycle. However, platforms can still have some custom u-boot specific
+	  bits maintained as part of *-u-boot.dtsi files.
+
 choice
 	prompt "Provider of DTB for DT control"
 	depends on OF_CONTROL
diff --git a/dts/Makefile b/dts/Makefile
index 3437e54033d..8098bf8191a 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
 DEVICE_TREE := unset
 endif
 
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+ifeq ($(CONFIG_ARM64),y)
+DEVICE_TREE_LOC := dts/arch/arm64
+else
+DEVICE_TREE_LOC := dts/arch/$(ARCH)
+endif
+else
+DEVICE_TREE_LOC := arch/$(ARCH)/dts
+endif
+
 ifneq ($(EXT_DTB),)
 DTB := $(EXT_DTB)
 else
-DTB := arch/$(ARCH)/dts/$(DEVICE_TREE).dtb
+DTB := $(DEVICE_TREE_LOC)/$(DEVICE_TREE).dtb
 endif
 
 $(obj)/dt-$(SPL_NAME).dtb: dts/dt.dtb $(objtree)/tools/fdtgrep FORCE
@@ -41,7 +51,7 @@ $(DTB): arch-dtbs
 
 PHONY += arch-dtbs
 arch-dtbs:
-	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts dtbs
+	$(Q)$(MAKE) $(build)=$(DEVICE_TREE_LOC) dtbs
 
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
@@ -65,4 +75,5 @@ clean-files := dt.dtb.S
 # Let clean descend into dts directories
 subdir- += ../arch/arc/dts ../arch/arm/dts ../arch/m68k/dts ../arch/microblaze/dts	\
 	   ../arch/mips/dts ../arch/nios2/dts ../arch/powerpc/dts ../arch/riscv/dts	\
-	   ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts
+	   ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts	\
+	   ./arch/arm64 ./arch/$(ARCH)
diff --git a/dts/arch/arm64/Makefile b/dts/arch/arm64/Makefile
new file mode 100644
index 00000000000..16e9fea622d
--- /dev/null
+++ b/dts/arch/arm64/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+include $(srctree)/scripts/Makefile.dts
+
+targets += $(dtb-y)
+
+# Add any required device tree compiler flags here
+DTC_FLAGS += -a 0x8
+
+PHONY += dtbs
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+	@:
+
+clean-files := */*.dtb */*.dtbo */*_HS
-- 
2.34.1

