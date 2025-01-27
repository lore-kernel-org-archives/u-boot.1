Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C880DC0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 07:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2827F80FC4;
	Mon, 27 Jan 2025 08:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y1tEasMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2460480FF7; Mon, 27 Jan 2025 08:18:56 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC36980F9E
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 08:18:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 288BB3FB5C; 
 Mon, 27 Jan 2025 07:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737962331;
 bh=eGXOR8P0KzVa8do0D8WXrCDzUOIuG7hEg37Mu/TWd00=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Y1tEasMqDTdVq5dpHEoHTUUQ21NNf+5VTCI531FEQt/U8knIneOA9KnmEfXf7WI6n
 Z5yf7fb64gZdjnp82PUvKl1BmpMLodtG173GMSmB3xVH0ZijCA4SrKOdpRVdNGZh76
 2vThmwbO0fwCzrf6xBS4j/eEVNSiHYZpO5n/FrKmsXhF3qqADqA8C1H8QNF2q7aO3e
 Fp1Xos0LWeFPfMTuhwR5qLypjqwyg6YJGw5/WnRUkzCgjC0JYHU9tGyoqhalUU8AKc
 eTtpuIrUYjrgvoY2k5lD2zBM8nmrnNkb20kT51scYorao0TknYICIqkiq36BsZl/t2
 S/CL56GbevmYw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] examples: eliminate CONFIG_STANDALONE_LOAD_ADDR
Date: Mon, 27 Jan 2025 08:18:46 +0100
Message-ID: <20250127071846.54946-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

CONFIG_STANDALONE_LOAD_ADDR has been used for examples/standalone
but not for examples/api.

The suitability of an address to load an ELF binary and run it does
not only depend on the architecture but also on the memory layout of
the board which is not reflected in the default value of
CONFIG_STANDALONE_LOAD_ADDR.

Commit 32b7e39db4d3 ("Convert CONFIG_STANDALONE_LOAD_ADDR to Kconfig")
set the default on RISC-V to 0x0 though most boards used 0x80200000
before the patch.

On most boards we can assume 8 MiB of memory available above $loadaddr.
So we can safely use $loadaddr + 4 MiB as load address for the standalone
example and eliminate CONFIG_STANDALONE_LOAD_ADDR altogether.

Fixes: 32b7e39db4d3 ("Convert CONFIG_STANDALONE_LOAD_ADDR to Kconfig")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 api/Kconfig                  | 20 --------------------
 config.mk                    |  1 -
 examples/standalone/Makefile |  6 +++++-
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/api/Kconfig b/api/Kconfig
index b5a7399d7f3..8cfd98ad6a6 100644
--- a/api/Kconfig
+++ b/api/Kconfig
@@ -19,24 +19,4 @@ config EXAMPLES
 	  U-Boot provides an API for standalone applications. Examples are
 	  provided in directory examples/.
 
-config STANDALONE_LOAD_ADDR
-	depends on EXAMPLES
-	hex "Address in memory to link standalone applications to"
-	default 0xffffffff80200000 if MIPS && 64BIT
-	default 0x8c000000 if SH
-	default 0x82000000 if ARC
-	default 0x80f00000 if MICROBLAZE
-	default 0x80300000 if ARCH_OMAP2PLUS || FSL_LSCH2 || FSL_LSCH3
-	default 0x80200000 if MIPS && 32BIT
-	default 0x0c100000 if ARM
-	default 0x02000000 if NIOS2
-	default 0x00040000 if PPC || X86
-	default 0x00020000 if M68K
-	default 0x0 if RISCV
-	default SYS_LOAD_ADDR
-	help
-	  This option defines a board specific value for the address where
-	  standalone program gets loaded, thus overwriting the architecture
-	  dependent default settings.
-
 endmenu
diff --git a/config.mk b/config.mk
index e294be2a4c4..abed9cb65c6 100644
--- a/config.mk
+++ b/config.mk
@@ -76,4 +76,3 @@ export PLATFORM_CPPFLAGS
 export RELFLAGS
 export LDFLAGS_FINAL
 export LDFLAGS_STANDALONE
-export CONFIG_STANDALONE_LOAD_ADDR
diff --git a/examples/standalone/Makefile b/examples/standalone/Makefile
index 559170dd5c9..9b57f1c0c66 100644
--- a/examples/standalone/Makefile
+++ b/examples/standalone/Makefile
@@ -7,6 +7,10 @@ extra-y        := hello_world
 extra-$(CONFIG_SPI_FLASH_ATMEL)    += atmel_df_pow2
 extra-$(CONFIG_PPC)                += sched
 
+# Environment variable loadaddr is set from CONFIG_SYS_LOAD_ADDR.
+# Run the examples 4 MiB above this address.
+LOAD_ADDR:=${shell printf 0x%X $$(( $(CONFIG_SYS_LOAD_ADDR) + 0x400000 ))}
+
 #
 # Some versions of make do not handle trailing white spaces properly;
 # leading to build failures. The problem was found with GNU Make 3.80.
@@ -46,7 +50,7 @@ endif
 # source file.
 ccflags-y += $(call cc-option,-fno-toplevel-reorder)
 
-LDFLAGS_STANDALONE	+= -Ttext $(CONFIG_STANDALONE_LOAD_ADDR)
+LDFLAGS_STANDALONE	+= -Ttext $(LOAD_ADDR)
 
 #########################################################################
 
-- 
2.47.1

