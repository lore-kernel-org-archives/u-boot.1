Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA67C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 11:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 229BB87A13;
	Thu, 28 Dec 2023 12:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZY48fx4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BF7D87A15; Thu, 28 Dec 2023 12:59:11 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D47987A14
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 12:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d3cfb1568eso48918365ad.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 03:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703764739; x=1704369539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDY4LuoQYDY5N67u0lAxETqq9+/+EJV+L03/SvHFfXg=;
 b=ZY48fx4TW7Db8kD7p8l9m7CY1VqtsYqce40d72tTCUiU+JWv8AY14CqBpYFzSIun7Z
 ota9L2ch+/gA2ZKbzd761RpS2H7NR2+HtuNdBOOJzPA7R7CBHxfkUo8HDzXaIDy8Ulb5
 U6EVneP8s33nJ595uF4tUZ4TnAE+jzWxcnN00S5Ta6/2M3Rqq35rut4hGNUeaAkPhYEW
 urXJVTch74eKYmE3jdeJmyFRvTZfqgb98SMwE02nEovbp5vxm6h/DgSVvPNwJwgr/B6Q
 N8S6f5GlU41OjU/OiPwSFRVToX0XHn5wUjg8ms0aG0luDN8Y1OWumH+nQLCIK8XDhLnX
 nvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703764739; x=1704369539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDY4LuoQYDY5N67u0lAxETqq9+/+EJV+L03/SvHFfXg=;
 b=Cpm8z6FEZ9fZEUP1KVjExGvuuWZsBMPkWiVVJ97OKmIUTOQXJ8WTmzO9mdnlSHuXEk
 uKZXvxSBjYVqw0xubuqZOvRYCkyzcH5hbVD2XtBmWClTIIhW8kqyjzCT/Z4nAj+pyaG0
 8TGzX7iC5j9wr7FIIPSeuONZaxNNup7iXKmPcn3gB8SoX+/xyYdo5lEMY4E8cU88BSFs
 G6RA1tPcKz09K94lTZA+y02A9V58VyYvWjFGHLv9jSt/gKdZPZLxnQbTkP/V1f4zuhaZ
 zeeqzuijKEi3z2H/ftv6NHoPtIOt+PtQhJuX7S/l/0ZHv55xKwz5CpnOUid1FJcyUprz
 LknQ==
X-Gm-Message-State: AOJu0YzS9HIBqLnqtcF6fSV8Y0N5XT+ZfZpD1WB1hfzDh7L8i9w8LRtH
 aStL1AUdryyORUfIxsulNYIcLfJYDdYGqcX6fVc/VdNFOVTymw==
X-Google-Smtp-Source: AGHT+IEsbjJaFAIUXLFFmQoH5Dxurq/NSEyK2fddLKJ4sXkhSOVPvpPsHKF+r3IbisCnm2Pmqy1q+w==
X-Received: by 2002:a17:902:e750:b0:1d4:59ab:36b0 with SMTP id
 p16-20020a170902e75000b001d459ab36b0mr5095698plf.75.1703764739371; 
 Thu, 28 Dec 2023 03:58:59 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.202]) by smtp.gmail.com with ESMTPSA id
 r4-20020a170902ea4400b001d3f285157dsm13700579plg.124.2023.12.28.03.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 03:58:59 -0800 (PST)
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
 mibodhi@gmail.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
Date: Thu, 28 Dec 2023 17:28:00 +0530
Message-Id: <20231228115804.3626579-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228115804.3626579-1-sumit.garg@linaro.org>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
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
directory. Also add a new Makefile for arm64.

This will help easy migration for platforms which currently are compliant
with upstream Linux kernel devicetree files.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v3:
--------------
- Minor commit message update

Changes in v2:
--------------
- s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/

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

