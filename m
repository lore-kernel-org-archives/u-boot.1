Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397B8C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 19:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D2A387BBA;
	Wed, 14 Feb 2024 20:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MQWvIMFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 375DF87BF4; Wed, 14 Feb 2024 20:06:21 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48F20879E0
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 20:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3B8A53F6E2; 
 Wed, 14 Feb 2024 19:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707937574;
 bh=NgoR8D90x8VHKpU54dtFpFHc9hftpFALI4QHCPL2tS8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=MQWvIMFawDhZ62whP4TYxv8wPVUZt3KDHMGeGcP8Z9R+wTdndsJLXnFhcpdyuIrQ1
 Sjy+k6vUvsox1h78tVKdC9wNVechnq6hGf39vGnq4EqRnAwVaDlrDwvrPNJdEDcGmS
 M8M8wliolJLZY0t0OuLGeMpMUKQMmHay0hZdfJnqHCbQi5hzIbgap/D6U0pLTWFi/P
 4maxyP6GhYE2CJhKdVH00zL7nDsFWypGOi1Twdyfz4viKuvV3LH10SIYdCwfvh2ywa
 DOYvsYd7+Zxz4Y62YDCHZpBi4WvA6dD+DtHhIL9oZo/43HmyUQyx87GDoQ/fdCA2tJ
 bOfSmHX7+jcbA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] arm: separate .data and .text sections of EFI binaries
Date: Wed, 14 Feb 2024 20:06:25 +0100
Message-ID: <20240214190625.13764-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

EFI binaries should not contain sections that are both writable and
executable. Separate the RX .text section from the RW .data section.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/lib/crt0_arm_efi.S  | 35 +++++++++++++++++++++++++++--------
 arch/arm/lib/elf_arm_efi.lds | 33 ++++++++++++++++++++++-----------
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
index f6deca9a14..ba9fada500 100644
--- a/arch/arm/lib/crt0_arm_efi.S
+++ b/arch/arm/lib/crt0_arm_efi.S
@@ -23,7 +23,7 @@ pe_header:
 	.long	IMAGE_NT_SIGNATURE		/* 'PE' */
 coff_header:
 	.short	IMAGE_FILE_MACHINE_THUMB	/* Mixed ARM/Thumb */
-	.short	2				/* nr_sections */
+	.short	3				/* nr_sections */
 	.long	0				/* TimeDateStamp */
 	.long	0				/* PointerToSymbolTable */
 	.long	0				/* NumberOfSymbols */
@@ -107,16 +107,35 @@ section_table:
 	.byte	0
 	.byte	0
 	.byte	0			/* end of 0 padding of section name */
-	.long	_edata - _start		/* VirtualSize */
+	.long	_etext - _start		/* VirtualSize */
 	.long	_start - image_base	/* VirtualAddress */
-	.long	_edata - _start		/* SizeOfRawData */
+	.long	_etext - _start		/* SizeOfRawData */
 	.long	_start - image_base	/* PointerToRawData */
+	.long	0			/* PointerToRelocations */
+	.long	0			/* PointerToLineNumbers */
+	.short	0			/* NumberOfRelocations */
+	.short	0			/* NumberOfLineNumbers */
+	/* Characteristics (section flags) */
+	.long	(IMAGE_SCN_MEM_READ | \
+		 IMAGE_SCN_MEM_EXECUTE | \
+		 IMAGE_SCN_CNT_CODE)
 
-	.long	0		/* PointerToRelocations (0 for executables) */
-	.long	0		/* PointerToLineNumbers (0 for executables) */
-	.short	0		/* NumberOfRelocations  (0 for executables) */
-	.short	0		/* NumberOfLineNumbers  (0 for executables) */
-	.long	0xe0500020	/* Characteristics (section flags) */
+	.ascii	".data"
+	.byte	0
+	.byte	0
+	.byte	0			/* end of 0 padding of section name */
+	.long	_data_size		/* VirtualSize */
+	.long	_data - image_base	/* VirtualAddress */
+	.long	_data_size		/* SizeOfRawData */
+	.long	_data - image_base	/* PointerToRawData */
+	.long	0			/* PointerToRelocations */
+	.long	0			/* PointerToLineNumbers */
+	.short	0			/* NumberOfRelocations */
+	.short	0			/* NumberOfLineNumbers */
+	/* Characteristics (section flags) */
+	.long	(IMAGE_SCN_MEM_WRITE | \
+		 IMAGE_SCN_MEM_READ | \
+		 IMAGE_SCN_CNT_INITIALIZED_DATA)
 
 	.align		12
 _start:
diff --git a/arch/arm/lib/elf_arm_efi.lds b/arch/arm/lib/elf_arm_efi.lds
index 767ebda635..75341df5dd 100644
--- a/arch/arm/lib/elf_arm_efi.lds
+++ b/arch/arm/lib/elf_arm_efi.lds
@@ -7,6 +7,12 @@
 
 OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
 OUTPUT_ARCH(arm)
+
+PHDRS
+{
+	data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
+}
+
 ENTRY(_start)
 SECTIONS
 {
@@ -18,11 +24,17 @@ SECTIONS
 		*(.gnu.linkonce.t.*)
 		*(.srodata)
 		*(.rodata*)
+		. = ALIGN(16);
+		*(.dynamic);
 		. = ALIGN(512);
 	}
+	.rela.dyn : { *(.rela.dyn) }
+	.rela.plt : { *(.rela.plt) }
+	.rela.got : { *(.rela.got) }
+	.rela.data : { *(.rela.data) *(.rela.data*) }
 	_etext = .;
 	_text_size = . - _text;
-	.dynamic  : { *(.dynamic) }
+	. = ALIGN(4096);
 	.data : {
 		_data = .;
 		*(.sdata)
@@ -47,20 +59,19 @@ SECTIONS
 		. = ALIGN(512);
 		_bss_end = .;
 		_edata = .;
-	}
-	.rel.dyn : { *(.rel.dyn) }
-	.rel.plt : { *(.rel.plt) }
-	.rel.got : { *(.rel.got) }
-	.rel.data : { *(.rel.data) *(.rel.data*) }
-	_data_size = . - _etext;
+	} :data
+	_data_size = _edata - _data;
 
+	. = ALIGN(4096);
+	.dynsym   : { *(.dynsym) }
+	. = ALIGN(4096);
+	.dynstr   : { *(.dynstr) }
+	. = ALIGN(4096);
+	.note.gnu.build-id : { *(.note.gnu.build-id) }
 	/DISCARD/ : {
 		*(.rel.reloc)
 		*(.eh_frame)
 		*(.note.GNU-stack)
-		*(.dynsym)
-		*(.dynstr)
-		*(.note.gnu.build-id)
-		*(.comment)
 	}
+	.comment 0 : { *(.comment) }
 }
-- 
2.43.0

