Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99084C25B77
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 22:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA7EF885E9;
	Sat, 18 May 2024 00:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="L2qOTx/P";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QfibnVHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 484B087DEA; Sat, 18 May 2024 00:09:37 +0200 (CEST)
Received: from fhigh1-smtp.messagingengine.com
 (fhigh1-smtp.messagingengine.com [103.168.172.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE1A87DEA
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 00:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 1C0131140091;
 Fri, 17 May 2024 18:09:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Fri, 17 May 2024 18:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715983774;
 x=1716070174; bh=t8l/7y4mhZg6+xdS8K6hKjbj9GufHDzDVYvDwzl2qC8=; b=
 L2qOTx/PlxTuqQxE236lpv++gjYvf6bIuja8TanYmM/1EAcoLsgtU7J2LsJdtgig
 gEltnC1v86a5mU3Y9Vrz8R2QBRJKgR5F/Y0klt/w4aV6nvjhHGRirLMLy+6MZw5v
 9eB6hTfZe8++14TRHUVrflNbz9Gos7av4VaXQdKpEvaiML+SMc1P3dSmxYInkr5Z
 5kBDPc2PH1TgnVVCsUp0rTfWZ/28qVzZ1VL/37KNidxbjNJCWBILTydLXcEEkXow
 IpzjCAQgxgURmzXTWOi8tq2/Pt8Lr95Phg6QRV+jqEdS2ybJ3l5KBSzofH2sWazY
 ccaYVjuLZu0WkXzzcXAFKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715983774; x=
 1716070174; bh=t8l/7y4mhZg6+xdS8K6hKjbj9GufHDzDVYvDwzl2qC8=; b=Q
 fibnVHCljjG4hxOKkdP7bnsxlOCmn1XEfRvG4UMabE0KxAHmDUezMhTO2mA9gzUa
 AAmcUSVnunCNGI7dAqiPsyTYOlOBI+83SXfSVTXV8sXeWiTIyaIZTCHHZbFxTqdn
 YUo9w0EjCSyHD4BeP0ErX0tj1z5ti4O8lkJmgWfF6ahut2PYYN3cAUJQECXpd0Nh
 bX+lShlBDw4MBSXBeHFIoGy5ANtEjhI1MUv7yyrSqrGeOFCzvMzpiJY7yYL4XFRU
 4AUKy0b00ZcVMaib41pYqF1ESQpQmSI5LBJhRuefBlVUSmsvOosiR76Nu3gVIFiy
 rnQhFIp1IqG47MT7Yr8SA==
X-ME-Sender: <xms:ndVHZvpDDb6rZymaQ6-jmX99IHN2AajSpXY6pS2j6t1loNQgoWrGbg>
 <xme:ndVHZpqpJpW2pWiPM5_NHTZ8a4pqD4eKkPAMHXMO9KGAADYzz2l9t90apM3N3xvSH
 md30yAnZpy_9K25ZUY>
X-ME-Received: <xmr:ndVHZsPqLhsUGo2-qMXcgHBHouNPJWEAYoXFcDYpNI2dkd-PUI12LMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehhedgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:ndVHZi6TjIRnEODV1A4QhhK9p3T3OZ3eLJRFna83KT1Lqz4i6A8GXQ>
 <xmx:ndVHZu7CwYrZcdv7fXiOoksd6kif0rrhqF68Rgf6T_t34x5IZZPr6A>
 <xmx:ndVHZqhv8MG0EbNPHQKypXRXenc4K8OLrYjTyJFebDnTocfb5zy2JA>
 <xmx:ndVHZg4MLqkvhKunMHFJj8pJ3kN-6hamrut_gYwLzcJ5bcdgeqYa5Q>
 <xmx:ntVHZrubm5QMQL5xUUXQBMLQ-JBtw05A3O_XUhHr42tmZIaM-FN5qWXa>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 18:09:33 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 23:09:29 +0100
Subject: [PATCH 3/3] sandbox: Use pkg-config to detect and config sdl2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-sandbox-hostarch-kconfig-v1-3-716c146635c9@flygoat.com>
References: <20240517-sandbox-hostarch-kconfig-v1-0-716c146635c9@flygoat.com>
In-Reply-To: <20240517-sandbox-hostarch-kconfig-v1-0-716c146635c9@flygoat.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3337;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=ZrV0I6ONEy/uVoeFco/sTMAFFoRNqDYU80b/rQwKFlk=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3q7P03HxaHRcYnYzwW2Oy1bpasSv4y/LPyX3/hJ2OC
 P5/MedrRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEyEQYbhf3Z+zMqLZaffP+pf
 uW5W3KuSZlOx1sOtj1/odP478GyCjzsjw/ppJxNWyN8w25bcGMP5p1bZ+N5OtuSjX5c+13Lllpl
 VxAEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

sdl2-config is not cross compile friendly, it can only detect
and config stuff from build host.

Use pkg-config instead, which is a generic way to config libraries
on any sane system & cross toolchain should have it ready.

The output of pkg-config practically have no difference with
sdl2-config.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 Makefile                     | 3 ++-
 arch/sandbox/Kconfig         | 2 +-
 arch/sandbox/config.mk       | 5 ++---
 doc/arch/sandbox/sandbox.rst | 6 ------
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 596f6458e6b2..5e397e107a80 100644
--- a/Makefile
+++ b/Makefile
@@ -383,6 +383,7 @@ LDR		= $(CROSS_COMPILE)ldr
 STRIP		= $(CROSS_COMPILE)strip
 OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump
+PKG_CONFIG	= $(CROSS_COMPILE)pkg-config
 LEX		= flex
 YACC		= bison
 AWK		= awk
@@ -439,7 +440,7 @@ UBOOTVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SU
 
 export VERSION PATCHLEVEL SUBLEVEL UBOOTRELEASE UBOOTVERSION
 export ARCH CPU BOARD VENDOR SOC CPUDIR BOARDDIR
-export CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
+export CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC PKG_CONFIG
 export CPP AR NM LDR STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
 export MAKE LEX YACC AWK PERL PYTHON PYTHON2 PYTHON3
 export HOSTCXX KBUILD_HOSTCXXFLAGS CHECK CHECKFLAGS DTC DTC_FLAGS
diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index c3954e33aceb..5af074e3e700 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -71,7 +71,7 @@ config HOST_ARCH_UNKNOWN
 		 !HOST_ARCH_RISCV32 && !HOST_ARCH_RISCV64
 
 config HOST_HAS_SDL
-	def_bool $(success,sdl2-config --version)
+	def_bool $(success,$(PKG_CONFIG) sdl2)
 
 config SANDBOX_SDL
 	bool "Enable SDL2 support in sandbox"
diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
index 6b1da993ba4e..94c11fd78918 100644
--- a/arch/sandbox/config.mk
+++ b/arch/sandbox/config.mk
@@ -4,13 +4,12 @@
 PLATFORM_CPPFLAGS += -D__SANDBOX__ -U_FORTIFY_SOURCE
 PLATFORM_CPPFLAGS += -fPIC -ffunction-sections -fdata-sections
 PLATFORM_LIBS += -lrt
-SDL_CONFIG ?= sdl2-config
 
 # Define this to avoid linking with SDL, which requires SDL libraries
 # This can solve 'sdl-config: Command not found' errors
 ifeq ($(CONFIG_SANDBOX_SDL),y)
-PLATFORM_LIBS += $(shell $(SDL_CONFIG) --libs)
-PLATFORM_CPPFLAGS += $(shell $(SDL_CONFIG) --cflags)
+PLATFORM_LIBS += $(shell $(PKG_CONFIG) sdl2 --libs)
+PLATFORM_CPPFLAGS += $(shell $(PKG_CONFIG) sdl2 --cflags)
 endif
 
 SANITIZERS :=
diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index 5f8db126657f..9ad1b654989c 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -526,12 +526,6 @@ For debugging with GDB or LLDB, it is preferable to reduce the compiler
 optimization level (CONFIG_CC_OPTIMIZE_FOR_DEBUG=y) and to disable Link Time
 Optimization (CONFIG_LTO=n).
 
-SDL_CONFIG
-----------
-
-If sdl-config is on a different path from the default, set the SDL_CONFIG
-environment variable to the correct pathname before building U-Boot.
-
 
 Using valgrind / memcheck
 -------------------------

-- 
2.34.1

