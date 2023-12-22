Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D5AC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 06:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC1687801;
	Fri, 22 Dec 2023 07:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kbxlhOjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCB248780C; Fri, 22 Dec 2023 07:13:03 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 053E287837
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d4bef65786so1413966b3a.2
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703225578; x=1703830378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67reddoWyrVbqDX3B/b1zeD5qmhzQrkt4dlItSvlqXo=;
 b=kbxlhOjq9yc4+AsRfrP+udg2FSfRT6yVDJfQF7Au9OMpSPDnydFEDrupOmHSfVT8Gu
 CuA/LeLmVZkbGR9qwOOMd+XvJjNUMdwOL8rPoeBNUpm2zRHpoaBRLZI+UUxRwlpZydbv
 MJRCFmRq+26mFVKzA3NbjIKq08bzmfDStSG4+uwD1MFO6dA/ptbtGQIkUMcWbzjdc+YF
 Q2GSWg0mn2PkmE7hJwk2vIcL6LZBkzovzPhz6WWVttWlTzh3zvhnMmQhmUpMge/EymHA
 17VRBP6w+Sz16jaj/BcqrDs4DW4QQ5Y+1SHcsvUzdjKcC539LXT32QVTKuGGGqzP2iPl
 Svlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703225578; x=1703830378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=67reddoWyrVbqDX3B/b1zeD5qmhzQrkt4dlItSvlqXo=;
 b=TaNbEvrUzbfaDyt8X+XTY/GyTGkFDAbAOl7g9xQ1VjSwANOFSIJx/30WEIPuSiuRoB
 40t4NOmEJyMopshEtsP3FZqMIAdWuNT9P3zx0DIURBBmpV5kMFeWMW7O76lvC4yoGEGa
 Nb6ocKLrMUypp0ht0sLovG2LXsTuOkFmEv/Ns0Vfwz2oCz9cdrxcKG4KmJXhaO5nLd6k
 19GzIygGr9MDIegJRANj7u12HTR24bTUpP49b/5exLUktXx+JZIHynPAqRzDYH+CkF0m
 mRXDfn3+c08pSkXLqbV3xAlaFEtLYbKo6i1npWp9eszrPHzb2nfNg5pR9v6gjdB/+8e/
 MNSg==
X-Gm-Message-State: AOJu0Yy/R2mGoMFUTnfYPaRWSsMpqfy65AySZNp73dWbVeaQhcY/To/v
 dFtVElDN1eim5kTJcS7gwSwQQnnmBMQfp3LuWNhzC3opm3fWqw==
X-Google-Smtp-Source: AGHT+IGU/auHCN6i4zkz0EwI8Qfh5Gyc6blhomGEKUHxIm4CCREyh4CjzESXyagp6CXozn03p9NX1Q==
X-Received: by 2002:a05:6a00:80e3:b0:6ce:f6a1:72aa with SMTP id
 ei35-20020a056a0080e300b006cef6a172aamr796782pfb.4.1703225577899; 
 Thu, 21 Dec 2023 22:12:57 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.219]) by smtp.gmail.com with ESMTPSA id
 h6-20020aa79f46000000b006ce835b77d9sm2602883pfr.20.2023.12.21.22.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 22:12:57 -0800 (PST)
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
Subject: [PATCH v2 4/8] dts: Add alternative location for upstream DTB builds
Date: Fri, 22 Dec 2023 11:42:04 +0530
Message-Id: <20231222061208.3009970-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222061208.3009970-1-sumit.garg@linaro.org>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
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
index 00c0aeff893..e58c1c6f2ab 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -85,6 +85,17 @@ config OF_LIVE
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
 choice
 	prompt "Provider of DTB for DT control"
 	depends on OF_CONTROL
diff --git a/dts/Makefile b/dts/Makefile
index 3437e54033d..68daaf45ec7 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -10,10 +10,20 @@ ifeq ($(DEVICE_TREE),)
 DEVICE_TREE := unset
 endif
 
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+ifeq ($(CONFIG_ARM64),y)
+dt_dir := dts/arch/arm64
+else
+dt_dir := dts/arch/$(ARCH)
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

