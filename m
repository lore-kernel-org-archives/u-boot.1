Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C9EC47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 13:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8813687CE3;
	Fri,  2 Feb 2024 14:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zd+0mAcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2C887CC2; Fri,  2 Feb 2024 14:06:46 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AD0C87CDB
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 14:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d953fa3286so12635145ad.2
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 05:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706879202; x=1707484002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+qDjnivRKsvwROoQdnvXoqkuqFStziPIQgGfS9OTLn8=;
 b=Zd+0mAcUro47orIoehtSkqa5SrAa5Igg1qTZZ+4JziAPB9Ke4BR4qes24fsFqEgLbu
 UHjW1RSn4tq0u+sJnl1rFHb82iugOupDg/rSWoYgLdbaaVHFaJOBnB5krsTcWYaabafB
 dpR+WY43+ERe2ZHATpTg0oMC1bhlNPmsvsgz+YyAOgCPYYMG7zO+jX5OHZSiV8phev1I
 jfNkYsjg0qOueCHu9TfrUuKBjH/BOLxInPS8vLmWQEy89sbAn9X1jlCxLXqgYz9ZBbeG
 LUl3BI24MP3hVibznMRxooBJKsAjf1wmEJxPZXG/FmVE6MJuWgkHBXhZnM2y4hfCntKL
 20GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706879202; x=1707484002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+qDjnivRKsvwROoQdnvXoqkuqFStziPIQgGfS9OTLn8=;
 b=rgqALYZw9gm8h4V7xxCdmcME6DzhaVEKlgFjUT9MAiE86uYxOfJCXUpdsBI3OWFvTh
 OFTeYROoZPGoeQ0wgFBEo2I/sWA6gMHgUUPkDcRQS0dOnOJJWNbhj/dVykSLXUrpHslQ
 tEjIBvIxEz7/hpT8gHjRKagFk7hN3szWv3MgnqB8A7NXpyAEMk3JMCnWdMFgiLgVhV4S
 4SPpDsETEeyFxv7TqprbId8MTVXDsb8CU9wHAubXZrmTpygjJ1fEJsHDCBvRi3ZQufWP
 kDLc6WYofKW0vN+6G6w/NnEF3H+sd7qBKYP99qQ/EocOS8gFOpZlF1XRBCmI81pR62jR
 /qgw==
X-Gm-Message-State: AOJu0Yz/fceZmEoIqrhaKA+MaRHGzeWHn2QzkDd5Yz/odUhA8ryOb4wC
 vtLcPOtR47U5LcMEEli9JkKaVsMMLllQzlPmM68hSn1F18dV4OmJGD5Nx7P3jB8MWXnIzBOU/nM
 kkVI=
X-Google-Smtp-Source: AGHT+IE38wglxcJVRzbPZcTqxmMr4X4cfjEm89WDP3DgsTATw9dmYm5vOoZ4vas5LhG8fIrwvHE7xw==
X-Received: by 2002:a17:902:6b8a:b0:1d8:e4b8:95dc with SMTP id
 p10-20020a1709026b8a00b001d8e4b895dcmr3939566plk.41.1706879202358; 
 Fri, 02 Feb 2024 05:06:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVhnbO/rYc72GUn/ukejTU+MFVRZQu1uAcNBgMxZa0ew1k/IA03LYq7PAJiWgFC6ZfjehveubYmL2vYN9EEB9hXb279cIPnaY0Uv3w9TbNUC1Gd15qhuJkGwBgoXqTBwNtMdhhYLKWRSCikK7v8IGS+Jxadr2At2NBQFcigsjRgpzdw+x5B8ZTI76byXZ2PsdxFywkzUKW3G24nuo4ej6UkUSVjqimPNJWn5ubRiiUlGQJ+tTXSTuTmkgaPKSYBJGJ5F6oslMi7HTVaiPGsKPBpicXYDEufcIJwycMay72QVzAqmXWZ2NG/5+OI5qqccsbsyBuAxTUHVKPTvvtCw3k1fQQz/VPVgLPjxhjuP04sHYrtD+dZCZ35GKXpzoGx+M8Rays+zuAuLrN27ptQ9CwRIBs81RNO2orFSvBAdB/MqqQAN8R/wszJAZjFUCno5dJ72QMKaf0uJXFjrkPn1dbBN1pKbAcj41RnWZH6GqKvIkVGwg57R2wdgiKnGxTdUPZ+igiFZQqNfJM+dBVaZsDDOWp70Emw/1Z984MKUjhI6MIvGiz1DnZ0bIQtSzk8nBAVfnG/EbS3r4gicq/7JQS0IM9hry7TS7d2fN/m44VOPdzMIcCMczI/4wzlMpXbf8LHqtpPSbM17+4ZRa9vGGR3A090o5OK9qFwEWtV/k2Z3Omehqy3Lkf3S+/1ku7KLJAd2y1rV21uxZm8htZsdpabzX5HXr9FKaRovCMCI4P4PjFZZ9oEBqY+RX0WvGA3GOyETQiMncnTyU7i0eQ6imjqvOCDCYdqUoXSy7DLyPDrTjbaMzxUudOM9WfAofSoK99gW2i/CZJ6e0yXpA7yqjcpB3Qvns0j7FV0H3mgfwdstIm3w8L5S2chD5Z/wqZwhbg6JVvAM5J9QkACvGbZtcVqG/rXw85SuUh2
Received: from sumit-X1.. ([223.178.213.44]) by smtp.gmail.com with ESMTPSA id
 q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 05:06:42 -0800 (PST)
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
 andre.przywara@arm.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 05/11] dts: Add alternative location for upstream DTB builds
Date: Fri,  2 Feb 2024 18:35:28 +0530
Message-Id: <20240202130534.1051438-6-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
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
directory into dts/upstream/src/$(ARCH) (special case for arm64). Then
build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/dts
directory. Also add a new Makefile for arm64.

This will help easy migration for platforms which currently are compliant
with upstream Linux kernel devicetree files.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

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

