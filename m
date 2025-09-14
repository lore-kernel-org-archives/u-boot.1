Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A0DCAC587
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 13:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC7E8359F;
	Sun, 14 Sep 2025 15:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lSjK+cU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3134281E13; Sun, 14 Sep 2025 13:01:12 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B698280B9B
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 13:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-31d6e39817fso5075837fac.3
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757847668; x=1758452468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wsidjg/rd7T/fT2WLydnghkow96ELQkgEgujd7trXEs=;
 b=lSjK+cU4x8xKBmN4S7ARl/MMnxrZroX8cpiIhfSuFW5yK2hsxNpjp2SlFPg3GLW++f
 O+sGXoVptX9f92X/ZjC17nhmsCzFEA9lPuzKToKWZfvxlEq35ql3WQpi6D0x53MiSP6s
 0I6UeWIbZwSdptgsZytJf11RtTLA2HXMRF+604L1V+nPJ3OQfI8CwMQdYr2CmQc6nQar
 G6slTRKDI8Ec8QbcW5SQbYBlBMyHkERz/drctHHzgnlJpZvcJ3oQ90okYRXDqgNoCyFp
 xMZt3WFjfUrCMfo3J9fqpxW4vCPTGK/HVZmxBDoMBnb5fD4xlZcWQxlPk0ThCfe2xoEl
 shAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757847668; x=1758452468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wsidjg/rd7T/fT2WLydnghkow96ELQkgEgujd7trXEs=;
 b=pj2FMm/rDP38KuAu8nbrImPQ9knpQZhzsT9kQKXVj9/+RW3U4Djy6qVyoBGTiEd9xT
 wtkCEZnRpGCs+AwsOmfvenuZktaM1K+clFK7ya1YCG9YwieCyyiQOGQAG4ytYJ9nYJ/2
 jE9itRrfhaT+c6qzNxQo18iAVQSgMqgz/kgCpGUzRPcbZYM6/gQwKNPd+8DJAuWDM3gh
 HAnl9JCKEb3/iZYJFMFExse3DIRlfHL2DlaMiqVDG5HT8ZNlc+06jzHg/hKw0CbxHEYr
 DtdX2u/yVQjdxbj3Yl7og40p+yuIhL3/O2jtaGzx5we8MBWc64hjCFQmM42lrMLeKjeA
 JY5g==
X-Gm-Message-State: AOJu0Yx5lycs99TkeCBlVrFI6SQGfWEasCNAELz5X4nqGqLvtg6P0dGQ
 Dfd6e3YzPzkVrQX76cUrgUAujLK/zpfiirhPYhUIrPHPQ9PNN0Vka6PuSH1w/VLD
X-Gm-Gg: ASbGncvIaxQD1oPTmvpjMLD+O8dXgSkkjoWlJj2rdbou3G/CfxsOKEzqSADqvZLjig2
 PGWZPg5BaTih7809rJw2dxDUvv0SJMadWZJFRBk/baRQYIaN84+s0NHZssVP1nbwFGZXxTKt0Nq
 aT7A7ED+Wne9TxTgJdsJB7bR0D2FXsvBhjiM3W6oKCuk9mcRh6o9KmSIOVxztVTT7qF9YYGgPRJ
 ZPXmIDHbMr6O12vuR70DlFZHbDL2Bs6mGJdRka03RraHqH/fh2ZUUOuhqJNKznJ0lI6/PCDjwaT
 1WThbbdtcfATHwPZj4xd6Cs59unooaVI1CyggsI3RJjbVI/WrskmwBaYIvU10YcRPCvkhYMpP0Q
 Tq1LlaGLcjvv3o4taITCaParPkzYKfEkZr3waBOWedbXq182h5mCyX7etxKWaMmZo17AaUSU=
X-Google-Smtp-Source: AGHT+IEASL/1RqBosjKtoSQeXjiPTage27XfYG/Jwi0yGI9RrJu0NmeIQL10rkg9zGLkXKoPDX9xIQ==
X-Received: by 2002:a05:6870:f683:b0:321:2772:dd9 with SMTP id
 586e51a60fabf-32e567c3bd5mr3852593fac.12.1757847668245; 
 Sun, 14 Sep 2025 04:01:08 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d32d56557sm2612720fac.1.2025.09.14.04.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Sep 2025 04:01:07 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 quentin.schulz@cherry.de, alice.guo@nxp.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 3/7] binman: Fix FIT image overlap issues for
 testFitSplitElf
Date: Sun, 14 Sep 2025 10:59:28 +0000
Message-ID: <20250914110021.4103-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914110021.4103-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Sep 2025 15:13:36 +0200
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
 tools/binman/test/elf_sections_tee.lds | 32 ++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 2 deletions(-)
 create mode 120000 tools/binman/test/elf_sections_tee.c
 create mode 100644 tools/binman/test/elf_sections_tee.lds

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 6ed8b8637cd..0252b175242 100644
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
index 00000000000..97e5e5f5d94
--- /dev/null
+++ b/tools/binman/test/elf_sections_tee.lds
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2016 Google, Inc
+ * Copyright (c) 2025 Canonical Ltd.
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

