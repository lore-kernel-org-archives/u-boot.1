Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DBDCF34D6
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 00:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A93CB88CB8;
	Fri,  4 Oct 2024 02:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728000693;
	bh=a68fXC63Ot66c4RegCu9ddStsqXg2mbhrsS9sFX1HWE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k3oNzB04h9lloT78Jclfyh0yqueFtjmuhv4YVt2lr3+w8zXhiLy/O5d/4lw03V82j
	 ijTyRnreMBSUJ5Y+dE2oDY1PKjY2OxGWuemMeHEq3++X1dL7eIyGfDfALlksOaUjUN
	 IkIwJcaC7M0AzH0pFoE1k2+f4DChQnAma5/xphWFf+crvx51MnC7aYoNzg+MiNIFA6
	 bZ0p+/gzm8t+YnUIPqYDbNxXuFyVvQUbzUKskaMu7DDKvVhj3fJiBVDmbQr+oAQIQV
	 jYUdQDA+SVloC8KiMpR8thKUZ1kE7qS3X/SBLWVsc2izjkK6qqS++DOYLqz8Dd+Hxh
	 IPvFgCg4opvbg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 997B28657F;
 Fri,  4 Oct 2024 02:11:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728000692;
 bh=a68fXC63Ot66c4RegCu9ddStsqXg2mbhrsS9sFX1HWE=;
 h=From:To:Cc:Subject:Date:From;
 b=s51+z+p/bvfH3qM/GNb+LNulFtDz1vmf3cOXWrGqkV57rSnlCACY/jw2+/oQmdD/k
 WJEXXV/M/xv0s5LZ01uSTU4srpIJA3EnSKxHfVXrQYGRbgXfnzoQH4OSAkBvJRtxo4
 sli4qD6bmCot7uQDX+cW4PI7CFvky+6CHPOVHVOn16+i7u4Br9BJ0cR1vGoSrnHG2c
 1i60p0OInZzaq742VxGdmLwqaGAq0q9FuBkBnIzuqw06S+VHLwi1drvzY356uak//t
 Ev1b2IR7P8Qoe2O00qJK0JbBWDebcBxcuRzRxDYUtEoGAwtPHXdnst0KYsMM9ka5i2
 iXtHIAleZYDhQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
Subject: [PATCH v2] dts: Deduplicate dtbs target
Date: Fri,  4 Oct 2024 02:10:42 +0200
Message-ID: <20241004001118.322531-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

The dtbs: target is almost identical in all architecture Makefiles.
All architecture Makefiles include scripts/Makefile.dts . Deduplicate
the dtbs: target into scripts/Makefile.dts . No functional change.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
V2: Add RB from Sumit
NOTE: I am sending this separately
---
 arch/arc/dts/Makefile            | 9 +--------
 arch/arm/dts/Makefile            | 8 --------
 arch/m68k/dts/Makefile           | 9 +--------
 arch/microblaze/dts/Makefile     | 9 +--------
 arch/mips/dts/Makefile           | 8 --------
 arch/nios2/dts/Makefile          | 9 +--------
 arch/powerpc/dts/Makefile        | 8 --------
 arch/riscv/dts/Makefile          | 9 +--------
 arch/sandbox/dts/Makefile        | 9 +--------
 arch/sh/dts/Makefile             | 8 --------
 arch/x86/dts/Makefile            | 8 --------
 arch/xtensa/dts/Makefile         | 8 --------
 dts/upstream/src/arm/Makefile    | 8 --------
 dts/upstream/src/arm64/Makefile  | 8 --------
 dts/upstream/src/xtensa/Makefile | 8 --------
 scripts/Makefile.dts             | 8 ++++++++
 16 files changed, 14 insertions(+), 120 deletions(-)

diff --git a/arch/arc/dts/Makefile b/arch/arc/dts/Makefile
index 532a8131c59..fe6ad7b849a 100644
--- a/arch/arc/dts/Makefile
+++ b/arch/arc/dts/Makefile
@@ -10,12 +10,5 @@ dtb-$(CONFIG_TARGET_IOT_DEVKIT) +=  iot_devkit.dtb
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
+# Add any required device tree compiler flags here
 DTC_FLAGS += -R 4 -p 0x1000
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := *.dtb
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d69b53ce8f7..e1cf4a43c23 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1305,16 +1305,8 @@ dtb-$(CONFIG_TARGET_CORSTONE1000) += corstone1000-mps3.dtb \
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
 # Add any required device tree compiler flags here
 DTC_FLAGS += -a 0x8
 
 DTC_FLAGS_imx8mp-dhcom-som-overlay-rev100 += -Wno-avoid_default_addr_size -Wno-reg_format
 DTC_FLAGS_imx8mp-dhcom-pdk3-overlay-rev100 += -Wno-avoid_default_addr_size -Wno-reg_format
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := *.dtb *.dtbo *_HS
diff --git a/arch/m68k/dts/Makefile b/arch/m68k/dts/Makefile
index 7988522eb98..8b354b9c570 100644
--- a/arch/m68k/dts/Makefile
+++ b/arch/m68k/dts/Makefile
@@ -20,12 +20,5 @@ dtb-$(CONFIG_TARGET_STMARK2) += stmark2.dtb
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
+# Add any required device tree compiler flags here
 DTC_FLAGS += -R 4 -p 0x1000
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := *.dtb
diff --git a/arch/microblaze/dts/Makefile b/arch/microblaze/dts/Makefile
index 427a8f9aaca..9be902d3bb1 100644
--- a/arch/microblaze/dts/Makefile
+++ b/arch/microblaze/dts/Makefile
@@ -4,12 +4,5 @@ dtb-y += $(shell echo $(CONFIG_DEFAULT_DEVICE_TREE)).dtb
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
+# Add any required device tree compiler flags here
 DTC_FLAGS += -R 4 -p 0x1000
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := *.dtb
diff --git a/arch/mips/dts/Makefile b/arch/mips/dts/Makefile
index 14fbce597b9..752e771514f 100644
--- a/arch/mips/dts/Makefile
+++ b/arch/mips/dts/Makefile
@@ -39,13 +39,5 @@ dtb-$(CONFIG_SOC_SERVAL) += serval_pcb105.dtb serval_pcb106.dtb
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
 # Add any required device tree compiler flags here
 DTC_FLAGS +=
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := *.dtb
diff --git a/arch/nios2/dts/Makefile b/arch/nios2/dts/Makefile
index 2b29fa90f6c..d77db9762a1 100644
--- a/arch/nios2/dts/Makefile
+++ b/arch/nios2/dts/Makefile
@@ -4,12 +4,5 @@ dtb-y += $(CONFIG_DEFAULT_DEVICE_TREE:"%"=%).dtb
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
+# Add any required device tree compiler flags here
 DTC_FLAGS += -R 4 -p 0x1000
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := *.dtb
diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
index 321c644804e..766b0c05951 100644
--- a/arch/powerpc/dts/Makefile
+++ b/arch/powerpc/dts/Makefile
@@ -35,13 +35,5 @@ dtb-$(CONFIG_TARGET_CMPCPRO) += cmpcpro.dtb
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
 # Add any required device tree compiler flags here
 DTC_FLAGS +=
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := *.dtb
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index c4c44057bad..f3dfd751cb4 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -15,12 +15,5 @@ dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) += ast2700-ibex.dtb
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
+# Add any required device tree compiler flags here
 DTC_FLAGS += -R 4 -p 0x1000
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := *.dtb
diff --git a/arch/sandbox/dts/Makefile b/arch/sandbox/dts/Makefile
index f810b4752f5..1c9fb4a4566 100644
--- a/arch/sandbox/dts/Makefile
+++ b/arch/sandbox/dts/Makefile
@@ -10,12 +10,5 @@ dtb-$(CONFIG_CMD_EXTENSION) += overlay0.dtbo overlay1.dtbo
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
+# Add any required device tree compiler flags here
 DTC_FLAGS += -R 4 -p 0x1000
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := *.dtb *.dtbo
diff --git a/arch/sh/dts/Makefile b/arch/sh/dts/Makefile
index 144fd3e7d22..e9153e42534 100644
--- a/arch/sh/dts/Makefile
+++ b/arch/sh/dts/Makefile
@@ -2,13 +2,5 @@ dtb-y += sh7751-r2dplus.dtb
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
 # Add any required device tree compiler flags here
 DTC_FLAGS +=
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := *.dtb *_HS
diff --git a/arch/x86/dts/Makefile b/arch/x86/dts/Makefile
index cd77f4c4e81..9a46726e026 100644
--- a/arch/x86/dts/Makefile
+++ b/arch/x86/dts/Makefile
@@ -24,12 +24,4 @@ dtb-y += bayleybay.dtb \
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
 DTC_FLAGS += -R 4 -p $(if $(CONFIG_EFI_APP),0x8000,0x1000)
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := *.dtb
diff --git a/arch/xtensa/dts/Makefile b/arch/xtensa/dts/Makefile
index c22c50ac4e5..aa582b85e5c 100644
--- a/arch/xtensa/dts/Makefile
+++ b/arch/xtensa/dts/Makefile
@@ -4,12 +4,4 @@ dtb-$(CONFIG_XTENSA) += ml605.dtb ml605_nommu.dtb kc705.dtb kc705_nommu.dtb
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
 DTC_FLAGS +=
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := *.dtb
diff --git a/dts/upstream/src/arm/Makefile b/dts/upstream/src/arm/Makefile
index 9a8f6aa3584..c86a2be5d85 100644
--- a/dts/upstream/src/arm/Makefile
+++ b/dts/upstream/src/arm/Makefile
@@ -2,13 +2,5 @@
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
 # Add any required device tree compiler flags here
 DTC_FLAGS += -a 0x8
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := */*.dtb */*.dtbo
diff --git a/dts/upstream/src/arm64/Makefile b/dts/upstream/src/arm64/Makefile
index 26a83d3d29d..b6db0dc6b26 100644
--- a/dts/upstream/src/arm64/Makefile
+++ b/dts/upstream/src/arm64/Makefile
@@ -2,17 +2,9 @@
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
 # Add any required device tree compiler flags here
 DTC_FLAGS += -a 0x8
 
 ifdef CONFIG_RCAR_64
 DTC_FLAGS += -R 4 -p 0x1000
 endif
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := */*.dtb */*.dtbo
diff --git a/dts/upstream/src/xtensa/Makefile b/dts/upstream/src/xtensa/Makefile
index 2a81acb32bc..c86a2be5d85 100644
--- a/dts/upstream/src/xtensa/Makefile
+++ b/dts/upstream/src/xtensa/Makefile
@@ -2,13 +2,5 @@
 
 include $(srctree)/scripts/Makefile.dts
 
-targets += $(dtb-y)
-
 # Add any required device tree compiler flags here
 DTC_FLAGS += -a 0x8
-
-PHONY += dtbs
-dtbs: $(addprefix $(obj)/, $(dtb-y))
-	@:
-
-clean-files := *.dtb *.dtbo */*.dtb */*.dtbo
diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 790f3c508f1..1fe142f2bbf 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -14,3 +14,11 @@ dtb-vendor_dts := $(patsubst %.dts,%.dtb,$(wildcard $(dt_dir)/$(subst ",,$(CONFI
 dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
 
 endif
+
+targets += $(dtb-y)
+
+PHONY += dtbs
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+	@:
+
+clean-files := *.dtb *.dtbo */*.dtb */*.dtbo *_HS
-- 
2.45.2

