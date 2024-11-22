Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523F0E65D10
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 01:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19510896FB;
	Fri, 22 Nov 2024 02:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732240757;
	bh=NEywNclSFpQecANzo1iSW1OA046Hhh7iw4iXnfmSoYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W05/Dn2wgD6pAlAe5b2+27PIaRx+OP44qWFvP0JjqDoz1EBihA/j7UuVTMr71lo1U
	 MfflWc3mYptdQTPqDxknWZS5q9Rv1QVLH1EOo3Yy+11UQ8+IDIqnEqvYGAL18yFRS8
	 +kTFXKwqGKmpA00Hfr5gvHZ56RHdf5cF4M01JFyjPuRUbh58V5yJzz7TO6X4qQeR3m
	 2krX8znnjp+8U8hC3zcsbpqJ3kJzZSyOAtreWbP0yuaxFbAGC6o28xfIcU2FP5mjve
	 0UZTZSqocHMqenoIl4tlcwmTTIMz2EuOeT7uo9/P4P3kNaW1Aw78j/IxIqt4Y4UU/j
	 8r2+nlsJrRGVw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3E3C588F7B;
 Fri, 22 Nov 2024 02:59:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732240755;
 bh=NEywNclSFpQecANzo1iSW1OA046Hhh7iw4iXnfmSoYE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XLahyFJLntTcP9NCS05PrgK/lFFOgvX24JhGOtYRtlCaFx7mIrf0EFFcLwRfQmx7z
 pQRDCiFca8+ah5QG99qo5D74ilWazSWwjbaADmDjriTUVvRAb7NmkPaGc3NVNdeH2G
 P+leDQkgoGnWQg1a4dv9MkQb281BrI7L3DVKqvnVi9JLT4Wwa4wa6kuvLghUg/d7NR
 kMHe6Y4YG+XoiW6cDSYcZ+bHhmAt77r1K1Vsy+aiUXKc2etaES2Jcr3KmzkkfKHdtD
 MITfjrxgF7IEKE8ihq6mHKmf33/9aEKTw1oSbE+jTMrAetW6O6sAJqcuVJg+sMbpRg
 ZSlh0w0gXA3Sg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Bryan Brattlof <bb@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] build: Respect CONFIG_SPL_BUILD in DT sources
Date: Fri, 22 Nov 2024 02:58:13 +0100
Message-ID: <20241122015858.557561-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122015858.557561-1-marex@denx.de>
References: <20241122015858.557561-1-marex@denx.de>
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

Currently the U-Boot SPL build uses the same DTBs that were generated
during U-Boot proper build, and calls 'fdtgrep' on those DTBs to filter
out uninteresting nodes and properties. Those U-Boot proper DTBs are
built from DTS which are first preprocessed by CPP, but that CPP is
invoked in U-Boot proper build context and effectively ignores the
CONFIG_SPL_BUILD macro. In case the CONFIG_SPL_BUILD macro is used
in any .dts file, the content of the macro is removed by CPP.

Fix this by building a separate set of DTBs for the SPL, which are
preprocessed by CPP with -DCONFIG_SPL_BUILD set. Use the same way
for the other PLs.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Bryan Brattlof <bb@ti.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Greg Malysa <greg.malysa@timesys.com>
Cc: Ian Roberts <ian.roberts@timesys.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
NOTE: For v2025.04
---
 dts/Makefile         |  5 ++++-
 scripts/Makefile.lib | 11 +++++++++++
 scripts/Makefile.xpl |  7 ++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/dts/Makefile b/dts/Makefile
index 86bf8dc2156..53cab9a37a4 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -32,7 +32,10 @@ else
 DTB := $(dt_dir)/$(DEVICE_TREE).dtb
 endif
 
-$(obj)/dt-$(SPL_NAME).dtb: dts/dt.dtb $(objtree)/tools/fdtgrep FORCE
+$(obj)/dt-$(SPL_NAME).tmp.dtb: $(patsubst %.dtb,%.dts,$(DTB)) FORCE
+	$(call if_changed,dtc)
+
+$(obj)/dt-$(SPL_NAME).dtb: $(obj)/dt-$(SPL_NAME).tmp.dtb $(objtree)/tools/fdtgrep FORCE
 	mkdir -p $(dir $@)
 	$(call if_changed,fdtgrep)
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 54403040f00..a42965edc6f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -202,6 +202,16 @@ endif
 dtsi_include_list = $(strip $(u_boot_dtsi_options_debug) \
 	$(notdir $(firstword $(u_boot_dtsi_options))))
 
+ifeq ($(CONFIG_SPL_BUILD),y)
+dtc_cpp_xpl_flags = -DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD
+else ifeq ($(CONFIG_TPL_BUILD),y)
+dtc_cpp_xpl_flags = -DCONFIG_XPL_BUILD -DCONFIG_TPL_BUILD
+else ifeq ($(CONFIG_VPL_BUILD),y)
+dtc_cpp_xpl_flags = -DCONFIG_XPL_BUILD -DCONFIG_VPL_BUILD
+else
+dtc_cpp_xpl_flags =
+endif
+
 # Modified for U-Boot
 upstream_dtsi_include = $(addprefix -I, $(srctree)/dts/upstream/src/ \
 	$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*))) \
@@ -214,6 +224,7 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 -I$(srctree)/arch/$(ARCH)/dts/include                   \
 		 -I$(srctree)/include                                    \
 		 $(upstream_dtsi_include)                                \
+		 $(dtc_cpp_xpl_flags)                                    \
 		 -D__ASSEMBLY__                                          \
 		 -undef -D__DTS__
 
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index dca5f4539d0..c0bd8dd7f97 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -590,11 +590,16 @@ endif
 
 SPL_OF_LIST_TARGETS = $(patsubst %,dts/%.dtb,$(subst ",,$(CONFIG_SPL_OF_LIST)))
 SHRUNK_ARCH_DTB = $(addprefix $(obj)/,$(SPL_OF_LIST_TARGETS))
+SPL_TMP_OF_LIST_TARGETS = $(patsubst %,dts/%.spl.dtb,$(subst ",,$(CONFIG_SPL_OF_LIST)))
+SHRUNK_ARCH_TMP_DTB = $(addprefix $(obj)/,$(SPL_TMP_OF_LIST_TARGETS))
 $(sort $(dir $(SHRUNK_ARCH_DTB))):
 	$(shell [ -d $@ ] || mkdir -p $@)
 
 .SECONDEXPANSION:
-$(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, $(dt_dir)/%, $$@) $(dir $(SHRUNK_ARCH_DTB))
+$(SHRUNK_ARCH_TMP_DTB): $$(patsubst %.spl.dtb,%.dts,$$(patsubst $(obj)/dts/%, $(dt_dir)/%, $$@)) $(dir $(SHRUNK_ARCH_TMP_DTB))
+	$(call if_changed,dtc)
+
+$(SHRUNK_ARCH_DTB): $$(patsubst %.dtb,%.spl.dtb,$$@)  $(dir $(SHRUNK_ARCH_DTB))
 	$(call if_changed,fdtgrep)
 
 targets += $(SPL_OF_LIST_TARGETS)
-- 
2.45.2

