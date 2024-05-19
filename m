Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCC9C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E6BF8865B;
	Sun, 19 May 2024 14:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="cmOHYdQQ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1ranMTJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE3F88291; Sun, 19 May 2024 14:57:19 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C83886A4
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.west.internal (Postfix) with ESMTP id 9B91F1800092;
 Sun, 19 May 2024 08:57:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sun, 19 May 2024 08:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716123434;
 x=1716209834; bh=Gj16HCoZBlsLLSRsnWJQxyM2f+Py+ETmQQYk0aiNp7Y=; b=
 cmOHYdQQqpnMKFRpAXNnQzDp1fQMrFpi9zsVNQQBaEuLuqZU4UBzyURdI8bGyrG0
 QQsb80hf1y+BbaLtrjRhQ9iP1h15ouptX6S93VuMwxKy606Ei7cIhisT5ye8LqGw
 They5egVl18B9eh8VLc1DCyO/bWXpIl2/TvyLMbC2qAla1AmJQ8T+2Ih9FlIUG/J
 JZJ1cWIAYGYuMh2T5CtdaVTa8qVlQ4hlDnQ2JU8YCAxq1ezRo5UiBNJPMUg5Upgl
 gO4iZ+qHhLqJ6iST5Aj1EtuKGkGUHzkjuu5P2LNNFdZbTbgPOsfcN528cJGg8Jik
 kPt0kU9DHr0rX0F7TD8CJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716123434; x=
 1716209834; bh=Gj16HCoZBlsLLSRsnWJQxyM2f+Py+ETmQQYk0aiNp7Y=; b=F
 1ranMTJ9/Wn0lniqqKhEJUPy7xXvoNE3WPVCoB+omoF6yEJwuQgEeAqrieawntsP
 V7BfkIjtS5QRxOay5N7s6HVkGB1PFtLDG0qka7bLG6cpkb2P77IpPgvEhYZNceoI
 PClaQHaKwL4e85Fr//PDnkujhjuLng5cHukYpduI5RfGywYJComPCyYOaKPGZXBc
 JmcmyQIbeja1Tmomg01DPN6r9LJ3VjsqJ1Uu43YpNFQYySragFJ+zAmbzUIP9H1V
 UVHyp+RLP2lL1h01GPaxL9MKCIaiVrAC18D7CugozJqqoQ5b72Elu5jM8x4EDUyC
 4aE+k4X+KFZlLyAQALomg==
X-ME-Sender: <xms:KvdJZq2qr4pn9yVHJ9rAwrpew5vBx2pHTh1f0q2m2ZPkPPwF8DJyxw>
 <xme:KvdJZtE1lYXQoTzUQnZI9WFOZXEPUqS0_E_y4jbTUx0xX5Td5IQXj3w2ucq5ACmlx
 V8VifGCF_YdLRqp3sQ>
X-ME-Received: <xmr:KvdJZi4I7sCUewEphe4lky5y_xNjqO0XWr1KMN6zSPmk8xhdEuyFcMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:KvdJZr07_rMdSVNJ2mmlnLoVJJ83LflEYl4TsWnfl8GXW-fAoDWWzg>
 <xmx:KvdJZtEBa0FtR9Ld2u1ytCxONDGDhs4RvRLM0LbQO9wGqwT1Uu-Xgg>
 <xmx:KvdJZk8oxGnJbGUSnOH3NsAYmrsTwQLIUkq75PSMvGNCaFns8Wj-Pg>
 <xmx:KvdJZim1LWLkGS91yrccQWfx-jIK9FQAEmSNaF2dMe1m8gwov8aWXQ>
 <xmx:KvdJZmIZG2UQc-oTpTS_8Ox4vcqq-vOoT2I6mvPWemItINoG34vp8cGw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 08:57:12 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 13:56:51 +0100
Subject: [PATCH 06/13] armv8: Big Endian enablement for compiler and linker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-aarch64-be-v1-6-75cc328eddfa@flygoat.com>
References: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
In-Reply-To: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
To: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3817;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=1yX4Bpbs4csyjeuSnIyyjZStqNeO6jot901hzxvg0YA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTP7/wRD0qT9oTHMteKTn3On9oe3b8/uCdG8NKnxe8+7
 NGs51DsKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgImo/GNkOPy9tmWNgXX7oX17
 yzf2eK81YFqi1b/+JdtOtrme5w/8NmZkWH+qUjJtVy9H3+Zjn3YEzHLv2frss2Tpzx3WAl4/Uq5
 MZQcA
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

Pass flags to compilers and linkers, also modify linker
scripts to set correct output format.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/arm/config.mk                | 14 ++++++++++++++
 arch/arm/cpu/armv8/u-boot-spl.lds |  6 ++++++
 arch/arm/cpu/armv8/u-boot.lds     |  4 ++++
 arch/arm/lib/elf_aarch64_efi.lds  |  7 +++++++
 scripts/Makefile.lib              |  3 ++-
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index 5530d02b66c4..b3f70c1fe9db 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -34,11 +34,25 @@ PLATFORM_RELFLAGS	+= $(LLVM_RELFLAGS)
 PLATFORM_CPPFLAGS += -D__ARM__
 
 ifdef CONFIG_ARM64
+ifdef CONFIG_SYS_BIG_ENDIAN
+PLATFORM_ELFFLAGS += -B aarch64 -O elf64-bigaarch64
+else
 PLATFORM_ELFFLAGS += -B aarch64 -O elf64-littleaarch64
+endif
 else
 PLATFORM_ELFFLAGS += -B arm -O elf32-littlearm
 endif
 
+ifdef CONFIG_SYS_LITTLE_ENDIAN
+KBUILD_LDFLAGS += -EL
+PLATFORM_CPPFLAGS += -mlittle-endian
+endif
+
+ifdef CONFIG_SYS_BIG_ENDIAN
+KBUILD_LDFLAGS += -EB
+PLATFORM_CPPFLAGS += -mbig-endian
+endif
+
 # Choose between ARM/Thumb instruction sets
 ifeq ($(CONFIG_$(SPL_)SYS_THUMB_BUILD),y)
 AFLAGS_IMPLICIT_IT	:= $(call as-option,-Wa$(comma)-mimplicit-it=always)
diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index ef8af67e11c3..1848c501c234 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -11,12 +11,18 @@
  *	Aneesh V <aneesh@ti.com>
  */
 
+#include <config.h>
+
 MEMORY { .sram : ORIGIN = IMAGE_TEXT_BASE,
 		LENGTH = IMAGE_MAX_SIZE }
 MEMORY { .sdram : ORIGIN = CONFIG_SPL_BSS_START_ADDR,
 		LENGTH = CONFIG_SPL_BSS_MAX_SIZE }
 
+#if CONFIG_IS_ENABLED(SYS_BIG_ENDIAN)
+OUTPUT_FORMAT("elf64-bigaarch64", "elf64-bigaarch64", "elf64-bigaarch64")
+#else
 OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
+#endif
 OUTPUT_ARCH(aarch64)
 ENTRY(_start)
 SECTIONS
diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index 857f44412e07..f357e5468e27 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -10,7 +10,11 @@
 #include <config.h>
 #include <asm/psci.h>
 
+#if CONFIG_IS_ENABLED(SYS_BIG_ENDIAN)
+OUTPUT_FORMAT("elf64-bigaarch64", "elf64-bigaarch64", "elf64-bigaarch64")
+#else
 OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
+#endif
 OUTPUT_ARCH(aarch64)
 ENTRY(_start)
 SECTIONS
diff --git a/arch/arm/lib/elf_aarch64_efi.lds b/arch/arm/lib/elf_aarch64_efi.lds
index 5dd98091698c..4bba305bab35 100644
--- a/arch/arm/lib/elf_aarch64_efi.lds
+++ b/arch/arm/lib/elf_aarch64_efi.lds
@@ -5,7 +5,14 @@
  * Modified from elf_aarch64_efi.lds in gnu-efi
  */
 
+#include <config.h>
+
+#if CONFIG_IS_ENABLED(SYS_BIG_ENDIAN)
+OUTPUT_FORMAT("elf64-bigaarch64", "elf64-bigaarch64", "elf64-bigaarch64")
+#else
 OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
+#endif
+
 OUTPUT_ARCH(aarch64)
 
 PHDRS
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 62f87517c09c..ff88cc3e55cd 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -475,7 +475,8 @@ cmd_efi_objcopy = $(OBJCOPY) -j .header -j .text -j .sdata -j .data -j \
 $(obj)/%.efi: $(obj)/%_efi.so
 	$(call cmd,efi_objcopy)
 
-KBUILD_EFILDFLAGS = -nostdlib -zexecstack -znocombreloc -znorelro
+KBUILD_EFILDFLAGS += $(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL)
+KBUILD_EFILDFLAGS += -nostdlib -zexecstack -znocombreloc -znorelro
 KBUILD_EFILDFLAGS += $(call ld-option,--no-warn-rwx-segments)
 quiet_cmd_efi_ld = LD      $@
 cmd_efi_ld = $(LD) $(KBUILD_EFILDFLAGS) -T $(EFI_LDS_PATH) \

-- 
2.43.0

