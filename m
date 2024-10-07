Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AAECFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B04688B39;
	Mon,  7 Oct 2024 14:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728302419;
	bh=7IivElfrQxQHOGkV6MEJnaKNurO0xyRg/zWJieejlMg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kupNzSWbKjCkonULJYJceJIWkI/3mWxe77YSIxe7O1hZCBV4P5gbZH188UE3guNj/
	 27L6pY/dOXzi1VVr2ivlEKdydpmLxGO5iNOWJIEL1mKcqsNvGB+aYa1Y81NyGKHVZB
	 OKdahuOxfvt8zoWLppXv//xxo5G1yWFXaLDzRqXlUyRv1iLsBzeHXWc4+WKup82OWI
	 Pje2SAZElmh/UUmZurwQm0F9hVrlB8P4r7j+vJ7pG9+1Lwtd1c7k7s2g5l0Tx4J753
	 qhdCV5eBKfOCXBNNpTIBNISasAqYUlVuP93cFDk/AL6ZabjR7S0NBMpfsp5xunYZqv
	 Knf7wtwptt9Zw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 50F84889AA;
 Mon,  7 Oct 2024 14:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728302418;
 bh=7IivElfrQxQHOGkV6MEJnaKNurO0xyRg/zWJieejlMg=;
 h=From:To:Cc:Subject:Date:From;
 b=tunujfauYIIELNgk/+T1g5Iw6JhByLKqVqryWGkDgNdFQIftPP0CN2qt6aJFaD6zC
 jpyHopWwE4rGODLmRCjWrCHfsiXvWLbdjwBWBHLAiDIoK88Nk/zrYChxjgQLFto2OT
 8RwMLE17+BEMX0dmrQdjBtAxajWjqh5zH8xbUTmAce/UQzeMVK+paBexE6/rpIWg5I
 aF31IBe43i17iVua+iFIdshxBzgglTBvvAqX60imAI9yJ06Y+93NbcQ837pOl1zwl5
 vUVSPmxgrW/mMF/VCdeYZmDX0GfcroGqMpebx515Fh5GAxXUIQz7nKhGaUFXBdyeLM
 WWhgZU13eVF/A==
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
Subject: [PATCH v3 1/2] dts: Add ability to build fallback DTBOs from
 arch/$(ARCH)/dts
Date: Mon,  7 Oct 2024 13:59:26 +0200
Message-ID: <20241007120002.25690-1-marex@denx.de>
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
V2: Gate this functionality behind CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS
V3: - Unnest CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS
    - Add RB from from Sumit
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
index d6c2c9daf31..a879fb4e9e9 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -20,6 +20,12 @@ else
 dt_dir := arch/$(ARCH)/dts
 endif
 
+ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
+local_dtbos := local-dtbos
+else
+local_dtbos :=
+endif
+
 ifneq ($(EXT_DTB),)
 DTB := $(EXT_DTB)
 else
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

