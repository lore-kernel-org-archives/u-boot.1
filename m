Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B922DC48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 11:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DAF5880D3;
	Thu, 22 Feb 2024 12:25:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kTd7zjUj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCEA58809C; Thu, 22 Feb 2024 10:37:21 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8597187E6F
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 10:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dc23bf7e5aaso7458694276.0
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 01:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708594632; x=1709199432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIv5ND2Plt0jo/md/FZNy91yYgdgPbXjXh3z/SWSsvE=;
 b=kTd7zjUj/LL+EDbKsvpGkCf4GhaViMLmaKv43Q936RtMrCsJP10o9pGqnp111rqPoE
 w6/3Yi2WL+EmWQMwuFaW+nR0XjotaRl2Peb9PHdLV0ZoLehlS98Tm4DqrdkI0DkVjTNH
 +VrIYAbxAgNLd4jUpab0BEKhQtwpTmfbR3Wx2/d1MeHqk7b0gpsJ2QlGYV8LLLr/LwZa
 uFRTe9LQGXP3RmiNt6chzdlYMu678y4Mw4qLYul3FBKDkcpK5D+t53SgBSgoLSs9yyUk
 QTO3sr2pX1WwyCEJ+3F2mLVo5NtNdv66efmvJcaEzoKcKR1nlqhko8Wetj5b9hL0tT0b
 TT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708594632; x=1709199432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YIv5ND2Plt0jo/md/FZNy91yYgdgPbXjXh3z/SWSsvE=;
 b=di9JtuWneqXhdjkZfE+YT8ZJBAUQToo3WONLVkswp2UaVJsqXUnoR+gROpO6HvW5ue
 IBdMOwGP8IhTI4re+YJNFo2M7DwAVJ6r7jao1/7NhTqXHh0EqeFe+BpAm2D5ujKktyWy
 2sV6U0yU9i9G4zj6ZmD3WJMl8Mnwj6Ve/bKbrZCLhE8YgVfC4CTgPgN9JTXyWa9k8fzT
 SHTlBFyrr0Q55Xuy+G4wpjmIsanVy6IJkcNdC7ZR61GHeBxxQnH4/efhTZFTx3EXMWBt
 CLdKELIGy9kj/sJR8hoIaOSPFgJ5KilzyzIYJ4z/NxpFoA/2AJE71mt4D6vimMHVKHw0
 +TgQ==
X-Gm-Message-State: AOJu0YwTlt2APa3nSycXgWZGUXv42OlBN1h523q4x1Jn8O4IstCXg62P
 E91ffnLa/yrXP6//sDXekBL4oi5Egm0U5AJeg+3rBEtDcoHiIEBtc6Z4ToqPlwzIrVGC+6HYC1l
 u
X-Google-Smtp-Source: AGHT+IEU6MHHLcScpRo9VYx0Lw1noneDbxqsC+FEuPpWBF1Y1h5m6n9504YEgITFhzD2CGj6i9RdhQ==
X-Received: by 2002:a05:6902:5:b0:dc6:ba11:6edd with SMTP id
 l5-20020a056902000500b00dc6ba116eddmr1907798ybh.8.1708594631731; 
 Thu, 22 Feb 2024 01:37:11 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115]) by smtp.gmail.com with ESMTPSA id
 u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 01:37:11 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com,
 andre.przywara@arm.com, ijc@hellion.org.uk, paul.barker.ct@bp.renesas.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 05/11] dts: Add alternative location for upstream DTB builds
Date: Thu, 22 Feb 2024 15:06:01 +0530
Message-Id: <20240222093607.3085545-6-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Feb 2024 12:24:08 +0100
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
directory into dts/upstream/src/$(ARCH) (special case for arm64). Then
build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dts
directory. Also add a new Makefile for arm64.

This will help easy migration for platforms which currently are compliant
with upstream Linux kernel devicetree files.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v6:
- None

Changes in v5:
- None

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.
- Added a note to OF_UPSTREAM Kconfig option.

Changes in v3:
- Minor commit message update

Changes in v2:
- s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/

 dts/Kconfig                     | 16 ++++++++++++++++
 dts/Makefile                    | 17 ++++++++++++++---
 dts/upstream/src/arm64/Makefile | 14 ++++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100644 dts/upstream/src/arm64/Makefile

diff --git a/dts/Kconfig b/dts/Kconfig
index 00c0aeff893b..09789d3e18b3 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -85,6 +85,22 @@ config OF_LIVE
 	  enables a live tree which is available after relocation,
 	  and can be adjusted as needed.
 
+config OF_UPSTREAM
+	bool "Enable use of devicetree imported from Linux kernel release"
+	help
+	  Traditionally, U-Boot platforms used to have their custom devicetree
+	  files or copy devicetree files from Linux kernel which are hard to
+	  maintain and can usually get out-of-sync from Linux kernel. This
+	  option enables platforms to migrate to devicetree-rebasing repo where
+	  a regular sync will be maintained every major Linux kernel release
+	  cycle. However, platforms can still have some custom u-boot specific
+	  bits maintained as part of *-u-boot.dtsi files.
+
+	  Note: This option should be set in Kconfig, for the SoC as a whole.
+	  However, newer boards whose devicetree source files haven't landed in
+	  the dts/upstream subtree, they can override this option to have the
+	  DT build from existing U-Boot tree location instead.
+
 choice
 	prompt "Provider of DTB for DT control"
 	depends on OF_CONTROL
diff --git a/dts/Makefile b/dts/Makefile
index 3437e54033db..d6c2c9daf31d 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
 DEVICE_TREE := unset
 endif
 
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
 ifneq ($(EXT_DTB),)
 DTB := $(EXT_DTB)
 else
-DTB := arch/$(ARCH)/dts/$(DEVICE_TREE).dtb
+DTB := $(dt_dir)/$(DEVICE_TREE).dtb
 endif
 
 $(obj)/dt-$(SPL_NAME).dtb: dts/dt.dtb $(objtree)/tools/fdtgrep FORCE
@@ -41,7 +51,7 @@ $(DTB): arch-dtbs
 
 PHONY += arch-dtbs
 arch-dtbs:
-	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts dtbs
+	$(Q)$(MAKE) $(build)=$(dt_dir) dtbs
 
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
@@ -65,4 +75,5 @@ clean-files := dt.dtb.S
 # Let clean descend into dts directories
 subdir- += ../arch/arc/dts ../arch/arm/dts ../arch/m68k/dts ../arch/microblaze/dts	\
 	   ../arch/mips/dts ../arch/nios2/dts ../arch/powerpc/dts ../arch/riscv/dts	\
-	   ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts
+	   ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts	\
+	   ./upstream/src/arm64 ./upstream/src/$(ARCH)
diff --git a/dts/upstream/src/arm64/Makefile b/dts/upstream/src/arm64/Makefile
new file mode 100644
index 000000000000..9a8f6aa35846
--- /dev/null
+++ b/dts/upstream/src/arm64/Makefile
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
+clean-files := */*.dtb */*.dtbo
-- 
2.34.1

