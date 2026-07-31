Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A680EC55165
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 00:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E6F9607BE;
	Fri, 31 Jul 2026 00:15:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mnqs6ksnmPzp; Fri, 31 Jul 2026 00:15:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9479C6073E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785456947;
	bh=+4eAgIZJzW3L9DVGnZsJADZV+OZvK71Iq3DVgUHjST4=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xV4/IaN6TNRF0WppSEiqxS1he6Q/hpVGfcyd+89XeYNWia6MF9tnk4S35KciBV94N
	 lgNBt9Vm/KGTrkDxppITqWrh8nI524k6Sww7xnhg9+oVQA4d+meeAiFxl7aMNvmS2T
	 2KHU2TG8FW3VKLoeP6GQBSyYwmuai46z7Tk96JQr/oWIpoTkx9BFGQ4C8trDFxBGgB
	 hsChrre2wvJ5bIBh/8HPMZJuUN7o2cZP2LZxJYRcjVivEF23E1lJJptS/92mJxzVE1
	 hqLQEWSfm2k4ehZC8BB0FW+HDwwb5hffdF7UKJ4m/mTwkJ0ojl69Zq4vxZbyQB/pRC
	 5XjZJtXhoTKXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9479C6073E;
	Fri, 31 Jul 2026 00:15:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E05C26C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7EFDB400B9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YqyZrSeWrzGs for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 00:14:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DC90E4007B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DC90E4007B
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC90E4007B
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:50 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F9E784A0A; Fri, 31 Jul 2026 02:14:49 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D14C4849BC
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 02:14:46 +0200 (CEST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 931CE3F9AA
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 00:14:46 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb74d5db64eso397857a12.2
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 17:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456885; x=1786061685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+4eAgIZJzW3L9DVGnZsJADZV+OZvK71Iq3DVgUHjST4=;
 b=Fq+CLjlQUnt1iW0tp4qLTBmd2KnEN/RbNCi0J72sycr7jveTCcyjxb8KzpC3+h/xjb
 eD7zLGrDSWIISSYypp57cclvPBo/jsmt9Q/O0WcbA6q5w7EDafRhrDepCUtB+8+uaPD5
 A9bsDSSnfs4qKvkZNAPKFgsoZFegdWIdCa3O0hUB47F/mUS5UI23oq3dMUS0IKN8cN2M
 4fZwigXEUYFr9k2oDOdiOgd0ACosfPfRWOm24oKkG4TXu05TuaTCMJdNOoADknsFUQT1
 Ou0JkcA7pUHdEquE4Fx7pDBczaWf4En9KB+DUGzTaAIkf2FOUnnhuOxrxcDJACT5Uu3T
 Iw1Q==
X-Gm-Message-State: AOJu0Yw8lW2P86PNzSIJeb08MF5SiVt0LT94IxKqbAjphU9ZvAoxGosp
 F3+dtt2vn9PWW9G6TedaZXa6zHy9k8KSIEb/KjUGoP7u2LugLLs06uDZYu42BuozKAQmjWF6gPu
 1IyAiYhe7sFmKvmfctJmq81x5u2R1uMcd5sfZO+ffW+/zrp3vv2PmHSEZi3Cl6Unxlt5Hon88I1
 v9cAfG+MBU
X-Gm-Gg: AR+sD11k0Wp34c7G1+ly/AHsKp3MvNKJHEDNfShmDpLSnnc83qFMiUmiUBXbCC2Pdw3
 iq+lAicKG0cqtcZthuFz/lrRNIza9X9WcUqFXvrwMhnyEd31oLX34to/9IMaNs65svMlH9fpxwR
 BDm8XR+G2e2qrjWWZJnja1Rs7jwWV25RAAFZJT68jlKSQDfg5LttW86bdng5DhzIGZz8Lga+/46
 kHgeIvudUPRmjIm0yaFWxFAS1PxLRfXBLhDtHJqTkb9X/QxOHW4lB8IdHFCUmA/752GwT30wfGh
 RnGPi2Tuxc9ml2QD6REem8sEwzwfbcrsLcsnAdVz/Ad7TIhkr8Sq/vU9BrUWjz/vF9ShkA4nN/o
 mumrcmrED/Miwe/0xaR5MEpTO4P5yrVXNxtFaFuVRCFlE9fZSI+eBQK0wop3rJGdcVRFmIw==
X-Received: by 2002:a05:6a00:18a2:b0:847:77e9:acbb with SMTP id
 d2e1a72fcca58-84ebc1f57bbmr4046598b3a.13.1785456885131; 
 Thu, 30 Jul 2026 17:14:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:18a2:b0:847:77e9:acbb with SMTP id
 d2e1a72fcca58-84ebc1f57bbmr4046575b3a.13.1785456884684; 
 Thu, 30 Jul 2026 17:14:44 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea02f8461sm3695718b3a.28.2026.07.30.17.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:14:44 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org,
 nm@ti.com, bb@ti.com, n-francis@ti.com, d-gole@ti.com, e@freeshell.de,
 jonas@kwiboo.se, Aristo Chen <aristo.chen@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 3/7] binman: Fix FIT image overlap issues for
 testFitSplitElf
Date: Fri, 31 Jul 2026 00:13:37 +0000
Message-ID: <20260731001347.35624-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731001347.35624-1-aristo.chen@canonical.com>
References: <20260731001347.35624-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 31 Jul 2026 00:15:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785456886;
 bh=+4eAgIZJzW3L9DVGnZsJADZV+OZvK71Iq3DVgUHjST4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=PkjY/MsPoa+CrkaMV+a0lJGXRoDuw/jY7zUQBdayQtwDJNE+JN4B5yT2tyYq4tQX7
 Ep57VqUOXkNiHnvmQx6nKB2f17nX/MKOzoZc4ErzVH0kaG9D7Yo2wQvEKO1m+ABq4Z
 4qFSoKKpDSHLgazQB/GWumCjSWBthw+YfulnUUDlzOSG9+stUXwKyWMP4ly+Gb74Zp
 SjIFakCVWXwa6hGUm2+J1s6w58AChCo8BTul6e6c8fxZXhuqB+IcDlaOoUor8Io7V9
 imz4+1eljG30yRCvG+N6oStWZq9EZJ1btt5ANbyhEWIxN80OFS5+c6ym+LRPrxTm8g
 tp6t4VjFSWR7KjrP5a+KtefYEeVmXnBAQ/N31lOrb9sEUlpEg1l46g5BgTRGbd6poy
 o6Ry9uMfYJLc6t9avNJwPrQmfwJM+mYpco+pcXhciL67eYrtdX3lwQ4xIt33YGkuqm
 87O/4zRolb6gyYeC6h8iLMUsc7M2I5mxWCIjqtH2MCCftomAzSzqf7t5MaJcCHyaR9
 tGdvFTIyZ+/pLewQlpsNzVzW15CNHxEifkN5csgaDykAKXK1k92jwZp5Ly/AK1juBY
 r8uBuGIAShtWr4BqQB25C7onaw9YRl9PMU3Wag7Kkpmf2Ug/K+uUxOm9xLi0sy9twA
 cZaTG8vZWkGYQkETIgwCfk7c=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org; spf=fail
 smtp.mailfrom=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=PkjY/MsP
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=aristo.chen@canonical.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (4096-bit key;
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.b="PkjY/MsP"; 
 dkim-atps=neutral
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

testFitSplitElf builds both the ATF and TEE test images from the same
elf_sections binary, so the split-elf nodes generated for the two
images end up with identical load addresses and overlap in memory. An
upcoming commit teaches mkimage to validate whether the memory
regions referenced by a configuration overlap, which makes this test
fail.

Update the test to use a non-overlapping memory layout so the two
images no longer collide:

1. Add elf_sections_tee.lds, which mirrors elf_sections.lds with the
   section addresses shifted up by 0x100000 for the TEE image.
2. Build an elf_sections_tee binary from it in the test Makefile.
3. Update ftest.py to use the separate ELF file for the TEE component
   in split-elf operations.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/binman/ftest.py                  |  2 +-
 tools/binman/test/Makefile             |  8 ++++--
 tools/binman/test/elf_sections_tee.c   |  1 +
 tools/binman/test/elf_sections_tee.lds | 35 ++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 3 deletions(-)
 create mode 120000 tools/binman/test/elf_sections_tee.c
 create mode 100644 tools/binman/test/elf_sections_tee.lds

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index b5e56707c83..3c391361a6a 100644
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
index 00000000000..6074b45a1f9
--- /dev/null
+++ b/tools/binman/test/elf_sections_tee.lds
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2016 Google, Inc
+ * Copyright (c) 2026 Canonical Ltd.
+ *
+ * Mirrors elf_sections.lds with the addresses shifted up by 0x100000 so
+ * the TEE image does not overlap the ATF image; keep the two in sync.
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

