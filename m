Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EB2CF8868
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 01:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA98A88EFB;
	Sat,  5 Oct 2024 03:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728090818;
	bh=foZXNqsgAgZGFuDp5yAdEubcV+RvzHRlBDkOYlAy+qc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=r2ZQDIRcQ2vpSu2054Qk1t40sGpjt51BQwgqgdp7h8/dm75J/KDPSgbwbSz3MWtXo
	 keP+qGic1/29WehMDaA5pyNsY4+t1s6ZjAAVxX+yBqpufCSqRDXilHvpYfnSHvr9j7
	 nR3jVZl3gR8CAiLP0tsx0xqtixzz3c8ESyahw6kDDVd2E8jFCVlpysNNwr3QtBlUL0
	 r1lzR5keu4VIUXnWTqkTXM9u6UrvkJywigdgPAx+dFW1HGxvO3Af+x3rohTIsuZzzH
	 w2P6KSBXZPOyVdaE7n922p95tkPl1CNt1aWYZ1NLpQX3jyGrzsjwdCyA3y6P1pBl/P
	 PKMFyKHKOOztg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6172F88B0B;
 Sat,  5 Oct 2024 03:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728090817;
 bh=foZXNqsgAgZGFuDp5yAdEubcV+RvzHRlBDkOYlAy+qc=;
 h=From:To:Cc:Subject:Date:From;
 b=lyMEzvEnm/BVOKP5QYNthD3hHkEUbaIn1hRqyaq+H3WR+wkdU5HlEHU01wQFbS0gU
 65FXH/FaDjh4ilf1lNpLgaIUZzQz0+mZkNIPaAqm/pQi1SjChV8IQu3zj+C+adhKLz
 g3d54E4Wl8tHT8VSo0WtceThT8gx+5xDu2h0ECw5UY1VdWx/Qx/bTc+KclD/jlSZyM
 6UWwC2Fc2X27aYQDSlQ15nLXAy51UoauyKfcUVF0walVWzIQ5IRq7xgs9dHnLPsZw8
 ns90gCD99qHXG3zfGlN5cSIDsKBgGi6/5OSAUtFNosWbbK+JjjCyPERMihUYeC38Ts
 tKTaCS6GtK1rw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH v2 1/2] dts: Add ability to build fallback DTBOs from
 arch/$(ARCH)/dts
Date: Sat,  5 Oct 2024 03:12:46 +0200
Message-ID: <20241005011315.436233-1-marex@denx.de>
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

Currently the enablement of OF_UPSTREAM results on the build system
searching for DTs only in dts/upstream/ . There are platforms which
use U-Boot specific DTBOs applied on top of U-Boot control DT during
SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.

Add dedicated 'dtbos' target which builds only .dtbos and not .dtbs and
in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled, build
this target for arch/$(ARCH)/dtb to generate local U-Boot specific DTBOs.

Adjust top level Makefile so binman would search for .dtb and .dtbo in
both OF_UPSTREAM specific paths and arch/$(ARCH)/dtb for the .dtbo case
in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled.

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
V2: Gate this functionality behind CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS
---
NOTE: Depends on https://lore.kernel.org/u-boot/20241004001118.322531-1-marex@denx.de/
---
 Makefile             |  4 ++++
 dts/Kconfig          | 16 ++++++++++++++++
 dts/Makefile         | 14 +++++++++++++-
 scripts/Makefile.dts |  6 ++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index af24de4165e..a5258e8cb3f 100644
--- a/Makefile
+++ b/Makefile
@@ -1375,7 +1375,11 @@ of_list := "$(ext_dtb_list)"
 of_list_dirs := $(dir $(EXT_DTB))
 else
 of_list := $(CONFIG_OF_LIST)
+ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
+of_list_dirs := $(dt_dir) arch/$(ARCH)/dts
+else
 of_list_dirs := $(dt_dir)
+endif
 default_dt := $(if $(DEVICE_TREE),$(DEVICE_TREE),$(CONFIG_DEFAULT_DEVICE_TREE))
 endif
 
diff --git a/dts/Kconfig b/dts/Kconfig
index 569d4be338e..385058b429f 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -125,6 +125,22 @@ config OF_UPSTREAM_VENDOR
 	help
 	  Select the vendor to build all devicetree files for.
 
+config OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS
+	bool "Build local DTBOs as fallback for DTBOs missing upstream"
+	default n
+	depends on OF_UPSTREAM
+	help
+	  Enable building DTBOs from arch/$(ARCH)/dts as a fallback for
+	  DTBOs which are not part of Linux kernel upstream yet. This is
+	  a stopgap measure to expedite OF_UPSTREAM switch for platforms
+	  which already have main DT in Linux kernel upstream, but still
+	  have leftover DTBOs in U-Boot tree.
+
+	  Do not use this option, upstream your DTs and DTBOs instead.
+	  If the upstreaming is in progress, use with utmost caution.
+
+	  If unsure, say N.
+
 choice
 	prompt "Provider of DTB for DT control"
 	depends on OF_CONTROL
diff --git a/dts/Makefile b/dts/Makefile
index d6c2c9daf31..32c749a043a 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -11,12 +11,18 @@ DEVICE_TREE := unset
 endif
 
 ifeq ($(CONFIG_OF_UPSTREAM),y)
+ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
+local_dtbos := local-dtbos
+else
+local_dtbos :=
+endif
 ifeq ($(CONFIG_ARM64),y)
 dt_dir := dts/upstream/src/arm64
 else
 dt_dir := dts/upstream/src/$(ARCH)
 endif
 else
+local_dtbos :=
 dt_dir := arch/$(ARCH)/dts
 endif
 
@@ -40,7 +46,7 @@ endif
 
 targets += dt.dtb
 
-$(DTB): arch-dtbs
+$(DTB): arch-dtbs $(local_dtbos)
 	$(Q)test -e $@ || (						\
 	echo >&2;							\
 	echo >&2 "Device Tree Source ($@) is not correctly specified.";	\
@@ -53,6 +59,12 @@ PHONY += arch-dtbs
 arch-dtbs:
 	$(Q)$(MAKE) $(build)=$(dt_dir) dtbs
 
+ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
+PHONY += local-dtbos
+local-dtbos:
+	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts dtbos
+endif
+
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
 # support "out-of-tree" build for dtb-spl
diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 1fe142f2bbf..3ab67b3c247 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -21,4 +21,10 @@ PHONY += dtbs
 dtbs: $(addprefix $(obj)/, $(dtb-y))
 	@:
 
+ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
+PHONY += dtbos
+dtbos: $(addprefix $(obj)/, $(filter-out %.dtb,$(dtb-y)))
+	@:
+endif
+
 clean-files := *.dtb *.dtbo */*.dtb */*.dtbo *_HS
-- 
2.45.2

