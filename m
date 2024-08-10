Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4F5C3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 20:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A32FD889C3;
	Sat, 10 Aug 2024 22:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IsRL0N2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EADE588709; Sat, 10 Aug 2024 22:52:40 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC7678890D
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81f94ce2272so121551339f.2
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323152; x=1723927952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CM1xwYayrIT8T1MX3HFybzlIHBSymDo60/2zwcNXqSQ=;
 b=IsRL0N2kTYXkuRicIec4FmU3HzwEbMDErEwpfGDcn8Qv3wOpHHRBKyusbxCAkbGmBu
 MiXNrUIDVPji4tKN8Bga6tG0qAukSOFLDbp/e8x4y+xqAcJGJjyrjVucfNaHroe3cD1t
 IiSfTBcKTGGBWI8/sJ7IvmNJW2G5fDy1zDdEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323152; x=1723927952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CM1xwYayrIT8T1MX3HFybzlIHBSymDo60/2zwcNXqSQ=;
 b=ZISPziry10Gb6kxGWwuPiZKDoOj3CrdjVn7yL0t1VScqgnarUbzDRsgEhaeeSClDnY
 F7uLYk6wMNeMvA7ytFf1Zn+X62e1yChv+DyUj7G2p1C+axbereq++Ici4sgZ/WXfADgi
 EUvd77H6Nb1tvC0xky5Llft3tgyc/FCSfWPTJYFsOr0I2FJurB7AaBsoA9Zz7d6BxC1C
 k4S6mzzAaI+E7qH76qP+Ingt3jm6B9O5cqIY73b68dYb3GlHJpAHykHhKDTF4BusTApx
 OE0+9TVpUr204po55reO+66FjCPR6EddfnJXhLSgYwf14AZNYL+RZbQPoNM7fhs6n2ax
 apkA==
X-Gm-Message-State: AOJu0YwLh0NOPpzRoVi7STMv7g2fPaRYsB55ONcarNgd6a1lUaj+LFON
 gFABgFfnNFteMHsbTov1sLFawK/ls0JVdrVZMwf2NlVKn2BVvC9xs1o+tPJHU2xQ6jtGyNwuCSs
 =
X-Google-Smtp-Source: AGHT+IGEwZ9GWe/UXCUSGUQTLkA2Bm7axtJDh2xhwAlceBvlLBeTk+h4eOSYNWayn0n9jbaMDiPy5w==
X-Received: by 2002:a05:6602:6207:b0:822:6d2a:e52d with SMTP id
 ca18e2360f4ac-8226d2ae6ffmr238151239f.1.1723323152241; 
 Sat, 10 Aug 2024 13:52:32 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 13/21] test: fdt: Move common code into the setup functions
Date: Sat, 10 Aug 2024 14:51:57 -0600
Message-Id: <20240810205205.3403177-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
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

Quite a lot of tests have the same two lines of code at the start. Move
this into the two setup functions to reduce redundancy.

Add a line to check the output from set_working_fdt_addr() since this is
always emitted.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd/fdt.c | 92 +++++++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 53 deletions(-)

diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index 35d9e84c3d1..d7b96bc5725 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -28,35 +28,49 @@ DECLARE_GLOBAL_DATA_PTR;
 /**
  * make_test_fdt() - Create an FDT with just a root node
  *
- * The size is set to the minimum needed
+ * The size is set to the minimum needed. This also sets the working FDT and
+ * checks that the expected output is received from doing so.
  *
  * @uts: Test state
  * @fdt: Place to write FDT
  * @size: Maximum size of space for fdt
+ * @addrp: Returns address of the devicetree
  */
-static int make_test_fdt(struct unit_test_state *uts, void *fdt, int size)
+static int make_test_fdt(struct unit_test_state *uts, void *fdt, int size,
+			 ulong *addrp)
 {
+	ulong addr;
+
 	ut_assertok(fdt_create(fdt, size));
 	ut_assertok(fdt_finish_reservemap(fdt));
 	ut_assert(fdt_begin_node(fdt, "") >= 0);
 	ut_assertok(fdt_end_node(fdt));
 	ut_assertok(fdt_finish(fdt));
 
+	addr = map_to_sysmem(fdt);
+	set_working_fdt_addr(addr);
+	ut_assert_nextline("Working FDT set to %lx", addr);
+	*addrp = addr;
+
 	return 0;
 }
 
 /**
  * make_fuller_fdt() - Create an FDT with root node and properties
  *
- * The size is set to the minimum needed
+ * The size is set to the minimum needed. This also sets the working FDT and
+ * checks that the expected output is received from doing so.
  *
  * @uts: Test state
  * @fdt: Place to write FDT
  * @size: Maximum size of space for fdt
+ * @addrp: Returns address of the devicetree
  */
-static int make_fuller_fdt(struct unit_test_state *uts, void *fdt, int size)
+static int make_fuller_fdt(struct unit_test_state *uts, void *fdt, int size,
+			   ulong *addrp)
 {
 	fdt32_t regs[2] = { cpu_to_fdt32(0x1234), cpu_to_fdt32(0x1000) };
+	ulong addr;
 
 	/*
 	 * Assemble the following DT for test purposes:
@@ -138,6 +152,11 @@ static int make_fuller_fdt(struct unit_test_state *uts, void *fdt, int size)
 	ut_assertok(fdt_end_node(fdt));
 	ut_assertok(fdt_finish(fdt));
 
+	addr = map_to_sysmem(fdt);
+	set_working_fdt_addr(addr);
+	ut_assert_nextline("Working FDT set to %lx", addr);
+	*addrp = addr;
+
 	return 0;
 }
 
@@ -169,10 +188,7 @@ static int fdt_test_addr(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Set up a working FDT and try again */
-	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt)));
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
-	ut_assert_nextline("Working FDT set to %lx", addr);
+	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
 	ut_assertok(run_command("fdt addr", 0));
 	ut_assert_nextline("Working fdt: %08lx", (ulong)map_to_sysmem(fdt));
 	ut_assertok(ut_check_console_end(uts));
@@ -222,9 +238,7 @@ static int fdt_test_addr_resize(struct unit_test_state *uts)
 	const int newsize = sizeof(fdt) / 2;
 	ulong addr;
 
-	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt)));
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
+	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test setting and resizing the working FDT to a larger size */
 	ut_assertok(console_record_reset_enable());
@@ -258,10 +272,8 @@ static int fdt_test_move(struct unit_test_state *uts)
 	void *buf;
 
 	/* Original source DT */
-	ut_assertok(make_test_fdt(uts, fdt, size));
+	ut_assertok(make_test_fdt(uts, fdt, size, &addr));
 	ts = fdt_totalsize(fdt);
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
 
 	/* Moved target DT location */
 	buf = map_sysmem(newaddr, size);
@@ -291,11 +303,9 @@ static int fdt_test_resize(struct unit_test_state *uts)
 	ulong addr;
 
 	/* Original source DT */
-	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt)));
+	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
 	fdt_shrink_to_minimum(fdt, 0);	/* Resize with 0 extra bytes */
 	ts = fdt_totalsize(fdt);
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
 
 	/* Test resizing the working FDT and verify the new space was added */
 	ut_assertok(console_record_reset_enable());
@@ -393,9 +403,7 @@ static int fdt_test_print_list(struct unit_test_state *uts, bool print)
 	int ret;
 
 	/* Original source DT */
-	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt)));
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
+	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test printing/listing the working FDT -- node / */
 	ut_assertok(console_record_reset_enable());
@@ -529,9 +537,7 @@ static int fdt_test_get_value(struct unit_test_state *uts)
 	char fdt[4096];
 	ulong addr;
 
-	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt)));
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
+	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	ut_assertok(fdt_test_get_value_common(uts, "/test-node@1234"));
 	ut_assertok(fdt_test_get_value_common(uts, "testnodealias"));
@@ -563,9 +569,7 @@ static int fdt_test_get_name(struct unit_test_state *uts)
 	char fdt[4096];
 	ulong addr;
 
-	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt)));
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
+	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test getting name of node 0 in /, which is /aliases node */
 	ut_assertok(console_record_reset_enable());
@@ -665,9 +669,7 @@ static int fdt_test_get_addr(struct unit_test_state *uts)
 	char fdt[4096];
 	ulong addr;
 
-	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt)));
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
+	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test getting address of root node / string property "compatible" */
 	ut_assertok(fdt_test_get_addr_common(uts, fdt, "/", "compatible"));
@@ -733,9 +735,7 @@ static int fdt_test_get_size(struct unit_test_state *uts)
 	char fdt[4096];
 	ulong addr;
 
-	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt)));
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
+	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test getting size of root node / string property "compatible" */
 	ut_assertok(fdt_test_get_size_common(uts, "/", "compatible", 16));
@@ -908,10 +908,8 @@ static int fdt_test_set(struct unit_test_state *uts)
 	char fdt[8192];
 	ulong addr;
 
-	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt)));
+	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt), &addr));
 	fdt_shrink_to_minimum(fdt, 4096);	/* Resize with 4096 extra bytes */
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
 
 	/* Test setting of root node / existing property "compatible" */
 	ut_assertok(fdt_test_set_node(uts, "/", "compatible"));
@@ -956,10 +954,8 @@ static int fdt_test_mknode(struct unit_test_state *uts)
 	char fdt[8192];
 	ulong addr;
 
-	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt)));
+	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt), &addr));
 	fdt_shrink_to_minimum(fdt, 4096);	/* Resize with 4096 extra bytes */
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
 
 	/* Test creation of new node in / */
 	ut_assertok(console_record_reset_enable());
@@ -1024,9 +1020,7 @@ static int fdt_test_rm(struct unit_test_state *uts)
 	char fdt[4096];
 	ulong addr;
 
-	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt)));
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
+	ut_assertok(make_fuller_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test removal of property in root node / */
 	ut_assertok(console_record_reset_enable());
@@ -1109,9 +1103,7 @@ static int fdt_test_bootcpu(struct unit_test_state *uts)
 	ulong addr;
 	int i;
 
-	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt)));
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
+	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test getting default bootcpu entry */
 	ut_assertok(console_record_reset_enable());
@@ -1158,9 +1150,7 @@ static int fdt_test_header(struct unit_test_state *uts)
 	char fdt[256];
 	ulong addr;
 
-	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt)));
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
+	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
 
 	/* Test header print */
 	ut_assertok(console_record_reset_enable());
@@ -1290,12 +1280,10 @@ static int fdt_test_rsvmem(struct unit_test_state *uts)
 	char fdt[8192];
 	ulong addr;
 
-	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt)));
+	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
 	fdt_shrink_to_minimum(fdt, 4096);	/* Resize with 4096 extra bytes */
 	fdt_add_mem_rsv(fdt, 0x42, 0x1701);
 	fdt_add_mem_rsv(fdt, 0x74656, 0x9);
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
 
 	/* Test default reserved memory node presence */
 	ut_assertok(console_record_reset_enable());
@@ -1354,10 +1342,8 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	char fdt[8192];
 	ulong addr;
 
-	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt)));
+	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
 	fdt_shrink_to_minimum(fdt, 4096);	/* Resize with 4096 extra bytes */
-	addr = map_to_sysmem(fdt);
-	set_working_fdt_addr(addr);
 
 	/* Test default chosen node presence, fail as there is no /chosen node */
 	ut_assertok(console_record_reset_enable());
-- 
2.34.1

