Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73777C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 860F082E52;
	Wed, 30 Jul 2025 07:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WxkyWJb9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30E0D82BCD; Tue, 29 Jul 2025 14:51:10 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3548082063
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 14:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ae0b2ead33cso166881166b.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 05:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753793467; x=1754398267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+CiaD+gmgT5RLVgL5AwCsT7QGKSBTn68CVd5G1GN13c=;
 b=WxkyWJb9WWoEMKsugxbnH8ndjfS7FmLMpwNL2iD2Y9MF1roaRxESze0Dtc9tjkBMoy
 DyM3/3lN6nBTyXeoFISSJH7uoLy9NWYiEVp97KBItBXwGJMEAyJQnwL0DZGSNsiy6gnq
 +fZRk3S+wxw1GPrsC9UVPzU+mAoONKHwrCqEmUvmmTnRrCgVK07a/YdzBYlE0o5ZkxXg
 r2bhcd/r6dO8UONWWhSzKSqczN6GVXeZJBnk9mjbj+qXpB/sqFfAm9qD7RYz0if11TJS
 GeJpC2HC5M9FVea7h13Zpu7LAcsfURKfcnHCpreO6MIGmlsP+jIdAROhcbrCeoyOljvP
 Gxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753793467; x=1754398267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+CiaD+gmgT5RLVgL5AwCsT7QGKSBTn68CVd5G1GN13c=;
 b=aJ0dgZRYfRltvl8njSSqhy5vJZtEFbxGVw7vOKiwwhYU+BweAS8WVWthRAOor3TNc2
 NK0AcCoy4epTuYRSztRqIjAGC6S4xw9RnnVYe3dyc0c+a7b0XjYRWYg84DEtqtSivDb9
 5ro62W69Q40MD1SgdGcXlC7e4EYLDe8XDChFgUM7Y4KNWDNnIelTVWG/qZVrTR9f7MD+
 9xzoWJkOs6AzbiUJKe//wNcAqLV0s9eqQVMeHZbUfPhNur0V7doOQST4Q0+DVlBwpdl0
 Z6+jOVr0tr34B5uKqCC3O1OnX7Y26F61G9RdSt6NC4/oaThbZ3uR2RJIf2T6Yr0UmX8/
 VY6w==
X-Gm-Message-State: AOJu0YzrohOs2FFnt1c1MPuuRrvEv5TTJ16gbEW54dMX+ep+F/FaBF60
 35M9lOYtnH2mIM1uQd/w47bxEzAiK/acU6hemtfFXMf4NsLv3c8PyKH79egyg8Ox
X-Gm-Gg: ASbGncuFXtCpUiXN7bf6XrwZ+sjN4lVLdKueU+Pd3A8dL0736byGMhYHy43Mv0OHj+3
 AzrXXcJDFdqlppGZjiuYRqbSkHaWSrk4rMhhoHK2eHVERDTcsJ2fX5xKr7pAojU4H6PAgatZGnq
 l0UY7YSk8P8F/Un3PeIL0kGWR/3N8U2neywNebkvFbgA6m22TJ9KEJGpgabtk8aGh2e6zFztx8h
 fQ8h6dd8Q4XYCZUvQGu4358TB44d3v9kAqR8KIy98Sjj0h/Vj9rWzGQced6Hx40sNNqpYxwt0oY
 Ob/mfuUyM7rU7o/cHR3wFFnJAoUDLX9T1iAz0aEvy/E1B6NfNayA49TvTx7jZe8W3m1X5LOPnU+
 qTSMauesCvDv0NfJfwPlLVbrXVHlQzmBK2ST+wBMjTbPqtvTGZ556I/FJZhaqs198kM74UzA=
X-Google-Smtp-Source: AGHT+IH0xEEs6XvJYDvWEgrN4MUbQWJsN/bU8oCNogTrtrPknhQE6UIs7BAX2GDtTf8Vh6RPUmlT8A==
X-Received: by 2002:a17:907:868b:b0:ae3:6038:ad6f with SMTP id
 a640c23a62f3a-af7ab56a4ccmr406858566b.3.1753793467316; 
 Tue, 29 Jul 2025 05:51:07 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635acc99esm572223366b.115.2025.07.29.05.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 05:51:06 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 2/5] binman: Fix FIT image overlap issues for
 testFitSplitElf
Date: Tue, 29 Jul 2025 12:48:53 +0000
Message-ID: <20250729125022.4220-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729125022.4220-1-aristo.chen@canonical.com>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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

Fix one binman test that has memory region overlap issue, the test case
needed to be updated to use non-overlapping memory layouts.

* Tests fixed:
  - testFitSplitElf

* Changes made:
  1. ELF section layouts: added elf_sections_tee.lds with different
     address for TEE to avoid overlap with ATF address defined in
     elf_sections.lds
  2. Makefile to properly build elf_sections_tee binary
  3. Updat ftest.py to use separate ELF files for TEE vs ATF components
     in split-elf operations.

An upcoming commit will validate if the memory region is overlapped

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/binman/ftest.py                  |  2 +-
 tools/binman/test/Makefile             |  6 ++++-
 tools/binman/test/elf_sections_tee.c   |  1 +
 tools/binman/test/elf_sections_tee.lds | 31 ++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 2 deletions(-)
 create mode 120000 tools/binman/test/elf_sections_tee.c
 create mode 100644 tools/binman/test/elf_sections_tee.lds

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a90db3c9351..f0c0487300d 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -252,7 +252,7 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('bl31.elf',
             tools.read_file(cls.ElfTestFile('elf_sections')))
         TestFunctional.tee_elf_path = TestFunctional._MakeInputFile('tee.elf',
-            tools.read_file(cls.ElfTestFile('elf_sections')))
+            tools.read_file(cls.ElfTestFile('elf_sections_tee')))
 
         # Newer OP_TEE file in v1 binary format
         cls.make_tee_bin('tee.bin')
diff --git a/tools/binman/test/Makefile b/tools/binman/test/Makefile
index 4d152eee9c0..66279e0e207 100644
--- a/tools/binman/test/Makefile
+++ b/tools/binman/test/Makefile
@@ -30,12 +30,13 @@ LDS_BINMAN_BAD := -T $(SRC)u_boot_binman_syms_bad.lds
 LDS_BINMAN_X86 := -T $(SRC)u_boot_binman_syms_x86.lds
 LDS_BINMAN_EMBED := -T $(SRC)u_boot_binman_embed.lds
 LDS_EFL_SECTIONS := -T $(SRC)elf_sections.lds
+LDS_EFL_SECTIONS_TEE := -T $(SRC)elf_sections_tee.lds
 LDS_BLOB := -T $(SRC)blob_syms.lds
 
 TARGETS = u_boot_ucode_ptr u_boot_no_ucode_ptr bss_data bss_data_zero \
 	u_boot_binman_syms u_boot_binman_syms.bin u_boot_binman_syms_bad \
 	u_boot_binman_syms_size u_boot_binman_syms_x86 embed_data \
-	u_boot_binman_embed u_boot_binman_embed_sm elf_sections blob_syms.bin
+	u_boot_binman_embed u_boot_binman_embed_sm elf_sections elf_sections_tee blob_syms.bin
 
 all: $(TARGETS)
 
@@ -84,6 +85,9 @@ blob_syms: blob_syms.c
 elf_sections: CFLAGS += $(LDS_EFL_SECTIONS)
 elf_sections: elf_sections.c
 
+elf_sections_tee: CFLAGS += $(LDS_EFL_SECTIONS_TEE)
+elf_sections_tee: elf_sections_tee.c
+
 clean:
 	rm -f $(TARGETS)
 
diff --git a/tools/binman/test/elf_sections_tee.c b/tools/binman/test/elf_sections_tee.c
new file mode 120000
index 00000000000..01b200a365e
--- /dev/null
+++ b/tools/binman/test/elf_sections_tee.c
@@ -0,0 +1 @@
+elf_sections.c
\ No newline at end of file
diff --git a/tools/binman/test/elf_sections_tee.lds b/tools/binman/test/elf_sections_tee.lds
new file mode 100644
index 00000000000..501d85a1f68
--- /dev/null
+++ b/tools/binman/test/elf_sections_tee.lds
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2016 Google, Inc
+ */
+
+OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_ARCH(i386)
+ENTRY(_start)
+
+SECTIONS
+{
+	. = 0x00100010;
+	_start = .;
+
+	. = ALIGN(4);
+	.text :
+	{
+		*(.text*)
+	}
+
+	. = 0x00101000;
+	.sram :
+	{
+		*(.sram*)
+	}
+
+	/DISCARD/ : {
+		*(.comment)
+		*(.dyn*)
+	}
+}
-- 
2.43.0

