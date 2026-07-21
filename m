Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F381C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F351880E73;
	Tue, 21 Jul 2026 15:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OmPLiASo8G37; Tue, 21 Jul 2026 15:55:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27E9780E47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784649340;
	bh=Y/cx4YTCqHMwe3+a/538Wa390X18k2iBZn2BTSk1igI=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pcqad75aqGBDM3pFpd8BHR+yVYdm+TRwjWXMlFj5CPOy3k0zw/7yzRXBUr/2ljiHb
	 33dIujNu5fvr+q4d4YKyIL5l//kbvrksXeYPQD0mmSyWcs+CrSPNVk8j489gE5FMOJ
	 rInbI968fdUnsQ4LgtqzyYkRcCzoFbn0iIm8484KMRhOXmAZ3lfUMx7daRcICWIJpe
	 8tS9yicm2SVU1kh5zp7x3/lXavMK5TV/DXguSohih5P6PIT6Nc0NlPv96iEsEZpZ19
	 UIenvDBR6os+hhKSldE3cGCprOPX5WApd1GESQRPcTOlp/LQjlRg2ear1SGT6Locek
	 wZ0ply6yJps/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27E9780E47;
	Tue, 21 Jul 2026 15:55:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 71420109F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 636F280E94
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fhd8KbUcPHjR for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:28:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9BCD380D09
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9BCD380D09
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9BCD380D09
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:43 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CCFFD3FC01
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:32 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ce7dfd33ffso141803755ad.0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647291; x=1785252091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y/cx4YTCqHMwe3+a/538Wa390X18k2iBZn2BTSk1igI=;
 b=s5t0qeJzCPGEUgnsfAnkyUYG0av9izughcbyEnig4RLpjRDzsUyNbOyo9FTqMNGVtK
 R7jKnPxOn59tjT2JrHk4TncjNSg7+DgYYSI/utwmNfXaaikBZljZXRSgF/WTt8VErc4w
 6l+Gi5xvLHRxGo/B2hNXnI+JDklaJf6hyy45CWPibUwpr/tmjh83xukfrfy5/ZO0Wabk
 DwR5fWbFpvKRmhnPqWR6YzHEuAOR507hYu0fGumQQIUF+Pw7J+MGhsGD8/cC10Eh0/tD
 Yjwn3dyyQdsCuuL/19Qx+DXe5rOpQ5wg0Vbz0NHDdHw7vsxbaRdS5DarcVnp0vk2ugYE
 5ZUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtpP2ywCHO6JbWmeLzOyMIqrh9P39peEWdWs2hVpP9GNx/38B8Vr+70I5KwreW+/1rhKgvq/c=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzt/Wqvr+5T1EAizB21bbT2V5nvgaspgqkQg1VEDVLs4L+kOIVQ
 XzXAv6xeNT+d8PsEEISVKqI5JptjWr827D0L5UMIdubAzprBXpasdeHHL4DPVJso9Fk84jeu6gC
 VshSzOl6DmyhnyBKRfExQrHRknWT4qDCXChrrH9gom8zxi7ZlZbExq5VUmdnCDPpBHd9HfmHA9R
 aZKD/bouPwvXyze9KqKw==
X-Gm-Gg: AR+sD123NpbfeTD2YxFHLIajPw7JKm7QJAfjuauO4VVKxoEBQJpgedi/PAV33Mo1TEO
 CA184TI2yd/zxeMIhws5U8m8atSjHssrIH3q/Q2sCxpvzLYzYvvtFsLQqz6IpWi2isJ/wGA4X7M
 qcMh/Kkft/Sl8uN7w6v6JBKM7+x9InDE/3UZjzSYIn4Qi0hAmVYhpXVIIq17mCof4gLR7KJBLjt
 Mi34znIrnnHVuJurDp5ASLHcrRGwYRXDzZESpZJDS9jTgw12us8JuUE5c8cjdLxY/pOhlgJRQtO
 totuSguJJXgK8Djj6JSSXYhY8Q4vu+BTyobvdeFfp0D6CZ5XC4gH4A2ddvaezUdHyQ+xl9dKGF7
 +C1ZuciwwXKKeLF8B1pMO7xJ4kOwegYOPBHK3hiPovLinb0n01Wgj5c4VuSAziqpja6Q=
X-Received: by 2002:a17:903:37c6:b0:2ca:bb5b:3c92 with SMTP id
 d9443c01a7336-2cf349a4f5dmr203503875ad.35.1784647291347; 
 Tue, 21 Jul 2026 08:21:31 -0700 (PDT)
X-Received: by 2002:a17:903:37c6:b0:2ca:bb5b:3c92 with SMTP id
 d9443c01a7336-2cf349a4f5dmr203503565ad.35.1784647290929; 
 Tue, 21 Jul 2026 08:21:30 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf347119dfsm77733775ad.56.2026.07.21.08.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:21:30 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v3 3/7] binman: Fix FIT image overlap issues for
 testFitSplitElf
Date: Tue, 21 Jul 2026 15:21:02 +0000
Message-ID: <20260721152110.283998-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721152110.283998-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 15:55:37 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1784647292;
 bh=Y/cx4YTCqHMwe3+a/538Wa390X18k2iBZn2BTSk1igI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=dVlVfodO2/MsdxlFvMuZPG8fPB0aopv3i5VAu5y1+rUFtGLTYU2Fgm43UqExydnqe
 awRRNyCC0J6f5QdG9UBXBWaXbnuNyi99YRWD+IAaUcj2U9D+uc+uQ/DITlhYHie3LW
 FzlC21IyxlCdrCzHsR588zKerzgth/pkWNR5aKT63x4Jnkg3AVmltA+8b7flqNDIE8
 0ONQkGdv0BqxTGXRLZN8PzOF0BnOh5U2eNFjwNtp11I7eP1NQgyWVwRU7lseLVzJo6
 nG9UsZwqyaFizHuagKHFwgmb4C46WSB4gYNkph4exYBHtj7ynFN5xOGBXlZOo4XHiS
 oUvhBpm8CtoACcrCWakS6dJ0Aa3SrdMw9dvQuNmuyrNUig31xmXdjUPf31YA/kilRP
 XUL2g9Tc98MxxbCeDd2BT6pXQ8OOUUqXpyc7owuCg6ZqaNxX+PrmdfLmGnjdG76OqX
 qnpYzV6pYd4xNAbrY4lLfEDa9imqS14jpNjHXlm6AL+LX3YTLZ5eQOP+oOQGkskiE2
 Ee808ddHVumZzIr4FNWKbQ9rS8gcdauaZfdzLrzWvYsQAhbZMbSNNsYFCkQU7bZJhf
 sO8A4SkRYMnLe7l6tL4VJHvpY1RkyeZcM5SqeUfvQgPJ+AuY+DVwE9mJELcLTNfkK4
 UOmJ6L1IWcxIL0smNYqW0+5c=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=dVlVfodO
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Fix one binman test that has memory region overlap issue, the test case
needed to be updated to use non-overlapping memory layouts.

* Tests fixed:
  - testFitSplitElf

* Changes made:
  1. ELF section layouts: added elf_sections_tee.lds with different
     address for TEE to avoid overlap with ATF address defined in
     elf_sections.lds
  2. Makefile to properly build elf_sections_tee binary
  3. Update ftest.py to use separate ELF files for TEE vs ATF components
     in split-elf operations.

An upcoming commit will validate if the memory region is overlapped

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/binman/ftest.py                  |  2 +-
 tools/binman/test/Makefile             |  8 +++++--
 tools/binman/test/elf_sections_tee.c   |  1 +
 tools/binman/test/elf_sections_tee.lds | 32 ++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)
 create mode 120000 tools/binman/test/elf_sections_tee.c
 create mode 100644 tools/binman/test/elf_sections_tee.lds

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 82db2950ec2..5c6c48a807a 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -253,7 +253,7 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('bl31.elf',
             tools.read_file(cls.ElfTestFile('elf_sections')))
         TestFunctional.tee_elf_path = TestFunctional._MakeInputFile('tee.elf',
-            tools.read_file(cls.ElfTestFile('elf_sections')))
+            tools.read_file(cls.ElfTestFile('elf_sections_tee')))
 
         # Newer OP_TEE file in v1 binary format
         cls.make_tee_bin('tee.bin')
diff --git a/tools/binman/test/Makefile b/tools/binman/test/Makefile
index 6b42db6559f..783bb4f62cd 100644
--- a/tools/binman/test/Makefile
+++ b/tools/binman/test/Makefile
@@ -30,13 +30,14 @@ LDS_BINMAN_BAD := -T $(SRC)u_boot_binman_syms_bad.lds
 LDS_BINMAN_X86 := -T $(SRC)u_boot_binman_syms_x86.lds
 LDS_BINMAN_EMBED := -T $(SRC)u_boot_binman_embed.lds
 LDS_EFL_SECTIONS := -T $(SRC)elf_sections.lds
+LDS_EFL_SECTIONS_TEE := -T $(SRC)elf_sections_tee.lds
 LDS_BLOB := -T $(SRC)blob_syms.lds
 
 TARGETS = u_boot_ucode_ptr u_boot_no_ucode_ptr bss_data bss_data_zero \
 	u_boot_binman_syms u_boot_binman_syms.bin u_boot_binman_syms_bad \
 	u_boot_binman_syms_size u_boot_binman_syms_x86 embed_data \
-	u_boot_binman_embed u_boot_binman_embed_sm elf_sections blob_syms.bin \
-	dummy-rsa-engine.so
+	u_boot_binman_embed u_boot_binman_embed_sm elf_sections \
+	elf_sections_tee blob_syms.bin dummy-rsa-engine.so
 
 all: $(TARGETS)
 
@@ -85,6 +86,9 @@ blob_syms: blob_syms.c
 elf_sections: CFLAGS += $(LDS_EFL_SECTIONS)
 elf_sections: elf_sections.c
 
+elf_sections_tee: CFLAGS += $(LDS_EFL_SECTIONS_TEE)
+elf_sections_tee: elf_sections_tee.c
+
 dummy-rsa-engine.so: $(SRC)fit/dummy-rsa-engine.c
 	$(CC) -fPIC -shared -lcrypto -lssl -o $@ $<
 
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
index 00000000000..84a4123ccfe
--- /dev/null
+++ b/tools/binman/test/elf_sections_tee.lds
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2016 Google, Inc
+ * Copyright (c) 2026 Canonical Ltd.
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

