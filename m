Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9ECD11182
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 17:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 623BA88E41;
	Sun,  3 Nov 2024 18:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="J7G3bh4M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3998288E96; Sun,  3 Nov 2024 18:54:15 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34BCA88D70
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 18:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 06DF83FC13; 
 Sun,  3 Nov 2024 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730656452;
 bh=OqbyYhd7AYFY5EFbTh1cUKvLPGHFAL4BKfOPZgu2jlU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=J7G3bh4M8Rk8+D3qCdIXLS0757MuxLyozZrMX1OUsHrRUz2qKszClieVHCmIIagWd
 fWKTB3auEzImAwnQPRxZ6b4fSi+m/ahkWnI6OBYMiUE87OnJj43kfcI0niJb4s5evJ
 KsY2t478CPZ71AWFj1b7CSFUq+sIKTzxHLxXFXljsCpmXKj7GATJsIVAKuvKp8Z3kr
 rPm753yZFkfvfhTOdXQG3sprRyvfujIbLNcn6fGydX77n73FjIDAXLsNXSneJcsyL8
 4stt5II4ZcR7MpOPT8ewsK5TIEuaAMrMK0CapHFITHqI8wBJasMtUgupEo5HoVQ31b
 sDKLYjRZ2+s/Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: run longjmp() test only on supported architectures
Date: Sun,  3 Nov 2024 18:54:00 +0100
Message-ID: <20241103175400.155790-1-heinrich.schuchardt@canonical.com>
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

We have only implemented longjmp() on the EFI architectures.

Define a symbol CONFIG_HAVE_SETJMP and have it selected by the relevant
architectures.

Use CONFIG_HAVE_SETJMP to decide if the longjmp test shall be built.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/Kconfig      | 9 +++++++++
 test/lib/Makefile | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8f1f4667012..674c68bff09 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -8,6 +8,11 @@ config CREATE_ARCH_SYMLINK
 config HAVE_ARCH_IOREMAP
 	bool
 
+config HAVE_SETJMP
+	bool
+	help
+	 The architecture supports setjmp() and longjmp().
+
 config SUPPORT_BIG_ENDIAN
 	bool
 
@@ -73,6 +78,7 @@ config ARC
 
 config ARM
 	bool "ARM architecture"
+	select HAVE_SETJMP
 	select ARCH_SUPPORTS_LTO
 	select CREATE_ARCH_SYMLINK
 	select HAVE_PRIVATE_LIBGCC if !ARM64
@@ -129,6 +135,7 @@ config PPC
 config RISCV
 	bool "RISC-V architecture"
 	select CREATE_ARCH_SYMLINK
+	select HAVE_SETJMP
 	select SUPPORT_ACPI
 	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_OF_CONTROL
@@ -154,6 +161,7 @@ config RISCV
 
 config SANDBOX
 	bool "Sandbox"
+	select HAVE_SETJMP
 	select ARCH_SUPPORTS_LTO
 	select BOARD_LATE_INIT
 	select BZIP2
@@ -248,6 +256,7 @@ config SH
 
 config X86
 	bool "x86 architecture"
+	select HAVE_SETJMP
 	select SUPPORT_SPL
 	select SUPPORT_TPL
 	select SUPPORT_LITTLE_ENDIAN
diff --git a/test/lib/Makefile b/test/lib/Makefile
index a54387a058e..7146ffa1b1f 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
 obj-y += hexdump.o
 obj-$(CONFIG_SANDBOX) += kconfig.o
 obj-y += lmb.o
-obj-y += longjmp.o
+obj-$(CONFIG_HAVE_SETJMP) += longjmp.o
 obj-$(CONFIG_CONSOLE_RECORD) += test_print.o
 obj-$(CONFIG_SSCANF) += sscanf.o
 obj-y += string.o
-- 
2.45.2

