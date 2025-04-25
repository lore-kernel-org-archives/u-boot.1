Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E37C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 13:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D9818210D;
	Fri, 25 Apr 2025 15:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KTx9y9ea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF0282114; Fri, 25 Apr 2025 15:52:31 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 167FD820F6
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 15:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-30820167b47so2364407a91.0
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745589147; x=1746193947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=APYlV4gqdTWYKnkRishN0She9xezpDgHqGOiB/MIAdM=;
 b=KTx9y9eaj8w5D/0wAu7XmiNmwWoGgP9LUcPTherMlQya5O27Gc26/lcsGvvb1UAili
 gIzOjocRcSG+RtiDF6GxmGAzbkPHAhQVIJydsc11NU8ACTaw4CZBpR4XX3zst3jJrs3J
 CAkGs27ejz9Qshk53GBmhcPjGUdgkJFRkv6Kx7dCSUXlRscR07fclZepZH3gtJMxrSEz
 gqFnXQBS+Rvdg1/ok1yD4Rb7SHnxUba7Vz53irnx1KrTB0+ZfA6Myn8oCf3pBqcfscB7
 PWt35us5DjIbCqIUayA0+TqwYlN9smBgMfcc9pqbISjldhhYPX4NhtrT/LZ/25xeHxcK
 OPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745589147; x=1746193947;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=APYlV4gqdTWYKnkRishN0She9xezpDgHqGOiB/MIAdM=;
 b=PlbefTsG8PFwSdR/F21MxgNh1x+9IOUpo5l10LW2ClzdV2HLwuV3d6afyQ/pvJHz6G
 /IsM1h2/hLMN9meLWJhJr+MwONjM4M6fkuY77KT/IqsmwQVAokEwxoHFLbb3fkqPsEFG
 lUxPv+tc4s/mEO30DWGFXabaQ0GIr3Oesdtbnuhgb1xYABdHGYwUsACeQVshr+07OJmJ
 IuC0c92lbosLVUbCRGzXNhGXe1gbfEhLARjcJzQUBpg/a8g2ft/BOAVwmPCwBNsZzl3O
 N03U/qyAF0RbrSDVX0xQXgjuNrOr85nLxboEHCO0KVaAmVxQOyeSgxKVWfRdgbcbe1qL
 q+cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPlvnrZs0S3wSJDADtG62fEtoZJdMnZzuCwQAak/DCqHGDlXkXzw4z0iLIQFECEDaDp+cro6Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0P2WwBkPKFe9a43N1Sz/TbFe/D2/FcuohCYxSHxxPKtMp1YeO
 jtqhb+IJ4ZvmtDYyXiK52YnYoZwAVGp/tzBJRa3DndRUdbUq/zqL
X-Gm-Gg: ASbGncs1DAapy+coWinoNYMdRT9YURAaRQoqlqQpe8fbjjmLzKubFOZzBggvhQlZ4m0
 eaA49W3jJwayfkc2hSBRSgG1c9QajyL8yk8X2QtvgT7b9h8Ed5i9AgVkrcrz4I3kSn4QCDpviIE
 hovFtPYI8D9ec0Aixif6ZLTLHFU16LFyDhpZ/wSvUpyqnr9pZCKI+w5gpS5tQzgvF98n9+QZHaG
 7jUIy2unIqp5kQzLptrbn4nTpc7iw3AyozR2Z5OW5kbVQBPWTrnkurkqY2GQtA6mt1shKnrq9e8
 /DPaxKmqKEDhR4NonvILbaDiRn5CV8W+7mBWrJn17a4yC7/nbPvFEqg=
X-Google-Smtp-Source: AGHT+IECy5hz37bpxVa/MkxLdbJtckUXU46g23zMmiOa7mcWkdqJz3+DR3aWValPfOjO9+LdZbdDYA==
X-Received: by 2002:a17:90b:264d:b0:2fa:562c:c1cf with SMTP id
 98e67ed59e1d1-309ee367dbcmr9906726a91.1.1745589147292; 
 Fri, 25 Apr 2025 06:52:27 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:6fb9:f343:690b:2e7d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f77371d1sm1619864a91.2.2025.04.25.06.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 06:52:26 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: trini@konsulko.com, aford173@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/4] build: Respect CONFIG_SPL_BUILD in DT sources
Date: Fri, 25 Apr 2025 10:52:17 -0300
Message-Id: <20250425135220.1929510-1-festevam@gmail.com>
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

From: Marek Vasut <marex@denx.de>

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
Signed-off-by: Fabio Estevam <festevam@denx.de>
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
index 83fd5ff6c31..8d6f67caee2 100644
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
index 43f27874f9f..ff19cb22f94 100644
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
2.34.1

