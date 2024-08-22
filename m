Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96D7C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CC2388CC9;
	Thu, 22 Aug 2024 15:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EAMoHAMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C824D88C4F; Thu, 22 Aug 2024 15:58:36 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46EF9886F3
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39d2f638050so2955515ab.3
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335112; x=1724939912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5Nfm/yE1jTNcIgiw/Qw6ZAbJappMmnqcYM2yHbBw7s=;
 b=EAMoHAMd5Lwlfdsi0aQfAusFw13CnQ9DL1lswgk6TOgIOlKek3EBtYB11Y1Fi116B/
 zaXT6rBylPTUsh9OQBtI1NG1R2j9yvpc8ijqaNi/3DqIB2K7gNyuZ80mMEHN8p0zJfhw
 sXQIxdzWifZXjeNoRZOcGMXtO3btg9EX/KS24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335112; x=1724939912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5Nfm/yE1jTNcIgiw/Qw6ZAbJappMmnqcYM2yHbBw7s=;
 b=DS+2fhs9uAx/cAZP9Dl1HguNOJLjcFOyM1M33JjBuUVC6BCA/GCDXhnJGMuubxGWrK
 VGrgZnwNSowdDLGJx38ddQLjg6yzmNdl/pEqCav09AD+UrhiWS3RwpMcxAP3yJX26rjt
 2YbJt6ELrTYCxEMOEvmPlnftH6xhxMgUNYKDNgudliekkHDTifIDo2kl3RM+JImrPiYp
 hiyA7ISaiYug9oPFYS6aN5dg4R32c1qvLHfAxdzKBwY5C6TOMEVPLGCQvhM2X1zU9VLy
 fNGA33Fq3epnFZLGd8MjiDzqSUuaWDpyC7itea7xWBaAH4uqND1cT2PzKU7XXauHs/cb
 4Rew==
X-Gm-Message-State: AOJu0YyUs45Olp3i9qBV2q0c0jbXb2tek+lOc1tX99xGBZBvNqDIgjX5
 nN++qAu9CNNgfAN3IkI3h/rgTpPoWOKnlj/ae1V5XFi5j7S3Tuc3TiqqyJFJrPCrcAPVKCbBc9o
 =
X-Google-Smtp-Source: AGHT+IEgYBpY/pxsG+92Ie7RxYLmeP6U8XAIWn3ILnh6aPn+gAZ2HqillQ0PtgLkBLqzdG70yYnhXw==
X-Received: by 2002:a05:6e02:1887:b0:375:9e3f:5f6 with SMTP id
 e9e14a558f8ab-39d74b5582amr27484685ab.6.1724335111392; 
 Thu, 22 Aug 2024 06:58:31 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 18/19] test: Tidy up checking for console end
Date: Thu, 22 Aug 2024 07:58:03 -0600
Message-Id: <20240822135804.2375959-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135804.2375959-1-sjg@chromium.org>
References: <20240822135804.2375959-1-sjg@chromium.org>
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

Use the ut_assert_console_end() function provided, rather than doing it
separately.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/bdinfo.c       |   8 +-
 test/cmd/exit.c         |  24 +++---
 test/cmd/fdt.c          | 178 ++++++++++++++++++++--------------------
 test/cmd/font.c         |   8 +-
 test/cmd/mbr.c          |  12 +--
 test/cmd/test_echo.c    |   2 +-
 test/cmd/test_pause.c   |   4 +-
 test/cmd/wget.c         |   2 +-
 test/lib/test_print.c   |   4 +-
 test/log/cont_test.c    |   6 +-
 test/log/nolog_ndebug.c |   2 +-
 test/log/nolog_test.c   |  16 ++--
 test/log/pr_cont_test.c |   2 +-
 13 files changed, 134 insertions(+), 134 deletions(-)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 810174fe8d1..199b461be2c 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -239,7 +239,7 @@ static int bdinfo_test_full(struct unit_test_state *uts)
 	ut_assertok(bdinfo_test_all(uts));
 	ut_assertok(run_commandf("bdinfo -a"));
 	ut_assertok(bdinfo_test_all(uts));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -259,7 +259,7 @@ static int bdinfo_test_help(struct unit_test_state *uts)
 		ut_assert_nextlinen("Usage:");
 		ut_assert_nextlinen("bdinfo");
 	}
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -273,7 +273,7 @@ static int bdinfo_test_memory(struct unit_test_state *uts)
 		ut_assertok(bdinfo_test_all(uts));
 	else
 		ut_assertok(bdinfo_check_mem(uts));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -287,7 +287,7 @@ static int bdinfo_test_eth(struct unit_test_state *uts)
 		ut_assertok(bdinfo_test_all(uts));
 	else if (IS_ENABLED(CONFIG_CMD_NET))
 		ut_assertok(test_eth(uts));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
diff --git a/test/cmd/exit.c b/test/cmd/exit.c
index 093f51b4dfc..af58a57fca7 100644
--- a/test/cmd/exit.c
+++ b/test/cmd/exit.c
@@ -36,14 +36,14 @@ static int cmd_exit_test(struct unit_test_state *uts)
 		ut_assertok(run_commandf("setenv foo 'echo bar ; exit %d ; echo baz' ; run foo ; echo $?", i));
 		ut_assert_nextline("bar");
 		ut_assert_nextline("%d", i > 0 ? i : 0);
-		ut_assertok(ut_check_console_end(uts));
+		ut_assert_console_end();
 
 		ut_assertok(run_commandf("setenv foo 'echo bar ; exit %d ; echo baz' ; run foo && echo quux ; echo $?", i));
 		ut_assert_nextline("bar");
 		if (i <= 0)
 			ut_assert_nextline("quux");
 		ut_assert_nextline("%d", i > 0 ? i : 0);
-		ut_assertok(ut_check_console_end(uts));
+		ut_assert_console_end();
 
 		ut_assertok(run_commandf("setenv foo 'echo bar ; exit %d ; echo baz' ; run foo || echo quux ; echo $?", i));
 		ut_assert_nextline("bar");
@@ -51,61 +51,61 @@ static int cmd_exit_test(struct unit_test_state *uts)
 			ut_assert_nextline("quux");
 		/* Either 'exit' returns 0, or 'echo quux' returns 0 */
 		ut_assert_nextline("0");
-		ut_assertok(ut_check_console_end(uts));
+		ut_assert_console_end();
 	}
 
 	/* Validate that 'exit' behaves the same way as 'exit 0' */
 	ut_assertok(run_commandf("setenv foo 'echo bar ; exit ; echo baz' ; run foo ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("0");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	ut_assertok(run_commandf("setenv foo 'echo bar ; exit ; echo baz' ; run foo && echo quux ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("quux");
 	ut_assert_nextline("0");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	ut_assertok(run_commandf("setenv foo 'echo bar ; exit ; echo baz' ; run foo || echo quux ; echo $?"));
 	ut_assert_nextline("bar");
 	/* Either 'exit' returns 0, or 'echo quux' returns 0 */
 	ut_assert_nextline("0");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Validate that return value still propagates from 'run' command */
 	ut_assertok(run_commandf("setenv foo 'echo bar ; true' ; run foo ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("0");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	ut_assertok(run_commandf("setenv foo 'echo bar ; true' ; run foo && echo quux ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("quux");
 	ut_assert_nextline("0");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	ut_assertok(run_commandf("setenv foo 'echo bar ; true' ; run foo || echo quux ; echo $?"));
 	ut_assert_nextline("bar");
 	/* The 'true' returns 0 */
 	ut_assert_nextline("0");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	ut_assertok(run_commandf("setenv foo 'echo bar ; false' ; run foo ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("1");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	ut_assertok(run_commandf("setenv foo 'echo bar ; false' ; run foo && echo quux ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("1");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	ut_assertok(run_commandf("setenv foo 'echo bar ; false' ; run foo || echo quux ; echo $?"));
 	ut_assert_nextline("bar");
 	ut_assert_nextline("quux");
 	/* The 'echo quux' returns 0 */
 	ut_assert_nextline("0");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index ac0d6f06150..e64785101cd 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -171,7 +171,7 @@ static int fdt_test_addr(struct unit_test_state *uts)
 	ut_assertok(run_command("fdt addr -c", 0));
 	ut_assert_nextline("Control fdt: %08lx",
 			   (ulong)map_to_sysmem(gd->fdt_blob));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* The working fdt is not set, so this should fail */
 	set_working_fdt_addr(0);
@@ -184,13 +184,13 @@ static int fdt_test_addr(struct unit_test_state *uts)
 	 */
 	if (IS_ENABLED(CONFIG_SANDBOX))
 		ut_assert_nextline("libfdt fdt_check_header(): FDT_ERR_BADMAGIC");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Set up a working FDT and try again */
 	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
 	ut_assertok(run_command("fdt addr", 0));
 	ut_assert_nextline("Working fdt: %08lx", (ulong)map_to_sysmem(fdt));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Set the working FDT */
 	set_working_fdt_addr(0);
@@ -198,7 +198,7 @@ static int fdt_test_addr(struct unit_test_state *uts)
 	ut_assertok(run_commandf("fdt addr %08lx", addr));
 	ut_assert_nextline("Working FDT set to %lx", addr);
 	ut_asserteq(addr, map_to_sysmem(working_fdt));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	set_working_fdt_addr(0);
 	ut_assert_nextline("Working FDT set to 0");
 
@@ -210,13 +210,13 @@ static int fdt_test_addr(struct unit_test_state *uts)
 	gd->fdt_blob = fdt_blob;
 	ut_assertok(ret);
 	ut_asserteq(addr, map_to_sysmem(new_fdt));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test setting an invalid FDT */
 	fdt[0] = 123;
 	ut_asserteq(1, run_commandf("fdt addr %08lx", addr));
 	ut_assert_nextline("libfdt fdt_check_header(): FDT_ERR_BADMAGIC");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test detecting an invalid FDT */
 	fdt[0] = 123;
@@ -224,7 +224,7 @@ static int fdt_test_addr(struct unit_test_state *uts)
 	ut_assert_nextline("Working FDT set to %lx", addr);
 	ut_asserteq(1, run_commandf("fdt addr"));
 	ut_assert_nextline("libfdt fdt_check_header(): FDT_ERR_BADMAGIC");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -242,18 +242,18 @@ static int fdt_test_addr_resize(struct unit_test_state *uts)
 	/* Test setting and resizing the working FDT to a larger size */
 	ut_assertok(run_commandf("fdt addr %08lx %x", addr, newsize));
 	ut_assert_nextline("Working FDT set to %lx", addr);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Try shrinking it */
 	ut_assertok(run_commandf("fdt addr %08lx %zx", addr, sizeof(fdt) / 4));
 	ut_assert_nextline("Working FDT set to %lx", addr);
 	ut_assert_nextline("New length %d < existing length %d, ignoring",
 			   (int)sizeof(fdt) / 4, newsize);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* ...quietly */
 	ut_assertok(run_commandf("fdt addr -q %08lx %zx", addr, sizeof(fdt) / 4));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* We cannot easily provoke errors in fdt_open_into(), so ignore that */
 
@@ -280,12 +280,12 @@ static int fdt_test_move(struct unit_test_state *uts)
 	/* Test moving the working FDT to a new location */
 	ut_assertok(run_commandf("fdt move %08lx %08lx %x", addr, newaddr, ts));
 	ut_assert_nextline("Working FDT set to %lx", newaddr);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Compare the source and destination DTs */
 	ut_assertok(run_commandf("cmp.b %08lx %08lx %x", addr, newaddr, ts));
 	ut_assert_nextline("Total of %d byte(s) were the same", ts);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -306,7 +306,7 @@ static int fdt_test_resize(struct unit_test_state *uts)
 	/* Test resizing the working FDT and verify the new space was added */
 	ut_assertok(run_commandf("fdt resize %x", newsize));
 	ut_asserteq(ts + newsize, fdt_totalsize(fdt));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -325,7 +325,7 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	ut_assert_nextline("\t#size-cells = <0x00000000>;");
 	ut_assert_nextline("\tcompatible = \"u-boot,fdt-subnode-test-device\";");
 	ut_assert_nextline("};");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/*
 	 * Test printing/listing the working FDT
@@ -333,7 +333,7 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	 */
 	ut_assertok(run_commandf("fdt %s / model", opc));
 	ut_assert_nextline("model = \"U-Boot FDT test\"");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/*
 	 * Test printing/listing the working FDT
@@ -341,7 +341,7 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	 */
 	ut_assertok(run_commandf("fdt %s %s compatible", opc, node));
 	ut_assert_nextline("compatible = \"u-boot,fdt-test-device1\"");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/*
 	 * Test printing/listing the working FDT
@@ -349,7 +349,7 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	 */
 	ut_assertok(run_commandf("fdt %s %s clock-names", opc, node));
 	ut_assert_nextline("clock-names = \"fixed\", \"i2c\", \"spi\", \"uart2\", \"uart1\"");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/*
 	 * Test printing/listing the working FDT
@@ -357,7 +357,7 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	 */
 	ut_assertok(run_commandf("fdt %s %s clock-frequency", opc, node));
 	ut_assert_nextline("clock-frequency = <0x00fde800>");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/*
 	 * Test printing/listing the working FDT
@@ -370,7 +370,7 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	 * since the beginning of the command 'fdt', keep it.
 	 */
 	ut_assert_nextline("%s u-boot,empty-property", node);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/*
 	 * Test printing/listing the working FDT
@@ -378,7 +378,7 @@ static int fdt_test_print_list_common(struct unit_test_state *uts,
 	 */
 	ut_assertok(run_commandf("fdt %s %s regs", opc, node));
 	ut_assert_nextline("regs = <0x00001234 0x00001000>");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -424,7 +424,7 @@ static int fdt_test_print_list(struct unit_test_state *uts, bool print)
 	}
 	ut_assert_nextline("\t};");
 	ut_assert_nextline("};");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	ret = fdt_test_print_list_common(uts, opc, "/test-node@1234");
 	if (!ret)
@@ -457,7 +457,7 @@ static int fdt_test_get_value_string(struct unit_test_state *uts,
 		ut_asserteq_str(strres, env_get("var"));
 	else
 		ut_asserteq(intres, env_get_hex("var", 0x1234));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -501,16 +501,16 @@ static int fdt_test_get_value_common(struct unit_test_state *uts,
 
 	/* Test missing 10th element of $node node clock-names property */
 	ut_asserteq(1, run_commandf("fdt get value ften %s clock-names 10", node));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test missing 10th element of $node node regs property */
 	ut_asserteq(1, run_commandf("fdt get value ften %s regs 10", node));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting default element of $node node nonexistent property */
 	ut_asserteq(1, run_commandf("fdt get value fnone %s nonexistent", node));
 	ut_assert_nextline("libfdt fdt_getprop(): FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -528,17 +528,17 @@ static int fdt_test_get_value(struct unit_test_state *uts)
 	/* Test getting default element of /nonexistent node */
 	ut_asserteq(1, run_command("fdt get value fnode /nonexistent nonexistent", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting default element of bad alias */
 	ut_asserteq(1, run_command("fdt get value vbadalias badalias nonexistent", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting default element of nonexistent alias */
 	ut_asserteq(1, run_command("fdt get value vnoalias noalias nonexistent", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -554,58 +554,58 @@ static int fdt_test_get_name(struct unit_test_state *uts)
 	/* Test getting name of node 0 in /, which is /aliases node */
 	ut_assertok(run_command("fdt get name nzero / 0", 0));
 	ut_asserteq_str("aliases", env_get("nzero"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting name of node 1 in /, which is /test-node@1234 node */
 	ut_assertok(run_command("fdt get name none / 1", 0));
 	ut_asserteq_str("test-node@1234", env_get("none"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting name of node -1 in /, which is /aliases node, same as 0 */
 	ut_assertok(run_command("fdt get name nmone / -1", 0));
 	ut_asserteq_str("aliases", env_get("nmone"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting name of node 2 in /, which does not exist */
 	ut_asserteq(1, run_command("fdt get name ntwo / 2", 1));
 	ut_assert_nextline("libfdt node not found");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting name of node 0 in /test-node@1234, which is /subnode node */
 	ut_assertok(run_command("fdt get name snzero /test-node@1234 0", 0));
 	ut_asserteq_str("subnode", env_get("snzero"));
 	ut_assertok(run_command("fdt get name asnzero testnodealias 0", 0));
 	ut_asserteq_str("subnode", env_get("asnzero"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting name of node 1 in /test-node@1234, which does not exist */
 	ut_asserteq(1, run_command("fdt get name snone /test-node@1234 1", 1));
 	ut_assert_nextline("libfdt node not found");
 	ut_asserteq(1, run_command("fdt get name asnone testnodealias 1", 1));
 	ut_assert_nextline("libfdt node not found");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting name of node -1 in /test-node@1234, which is /subnode node, same as 0 */
 	ut_assertok(run_command("fdt get name snmone /test-node@1234 -1", 0));
 	ut_asserteq_str("subnode", env_get("snmone"));
 	ut_assertok(run_command("fdt get name asnmone testnodealias -1", 0));
 	ut_asserteq_str("subnode", env_get("asnmone"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting name of nonexistent node */
 	ut_asserteq(1, run_command("fdt get name nonode /nonexistent 0", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting name of bad alias */
 	ut_asserteq(1, run_command("fdt get name vbadalias badalias 0", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting name of nonexistent alias */
 	ut_asserteq(1, run_command("fdt get name vnoalias noalias 0", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -628,7 +628,7 @@ static int fdt_test_get_addr_common(struct unit_test_state *uts, char *fdt,
 	ut_assertok(run_commandf("fdt get addr pstr %s %s", path, prop));
 	ut_asserteq((ulong)map_sysmem(env_get_hex("fdtaddr", 0x1234), 0),
 		    (ulong)(map_sysmem(env_get_hex("pstr", 0x1234), 0) - offset));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -670,12 +670,12 @@ static int fdt_test_get_addr(struct unit_test_state *uts)
 	/* Test getting address of node /test-node@1234/subnode non-existent property "noprop" */
 	ut_asserteq(1, run_command("fdt get addr pnoprop /test-node@1234/subnode noprop", 1));
 	ut_assert_nextline("libfdt fdt_getprop(): FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting address of non-existent node /test-node@1234/nonode@1 property "noprop" */
 	ut_asserteq(1, run_command("fdt get addr pnonode /test-node@1234/nonode@1 noprop", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -691,7 +691,7 @@ static int fdt_test_get_size_common(struct unit_test_state *uts,
 		ut_assertok(run_commandf("fdt get size sstr %s", path));
 	}
 	ut_asserteq(val, env_get_hex("sstr", 0x1234));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -742,27 +742,27 @@ static int fdt_test_get_size(struct unit_test_state *uts)
 	ut_assert_nextline("libfdt fdt_getprop(): FDT_ERR_NOTFOUND");
 	ut_asserteq(1, run_command("fdt get size pnoprop subnodealias noprop", 1));
 	ut_assert_nextline("libfdt fdt_getprop(): FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting size of non-existent node /test-node@1234/nonode@1 property "noprop" */
 	ut_asserteq(1, run_command("fdt get size pnonode /test-node@1234/nonode@1 noprop", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting node count of non-existent node /test-node@1234/nonode@1 */
 	ut_asserteq(1, run_command("fdt get size pnonode /test-node@1234/nonode@1", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting node count of bad alias badalias */
 	ut_asserteq(1, run_command("fdt get size pnonode badalias noprop", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting node count of non-existent alias noalias */
 	ut_asserteq(1, run_command("fdt get size pnonode noalias", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -793,7 +793,7 @@ static int fdt_test_set_single(struct unit_test_state *uts,
 		ut_asserteq(ival, env_get_hex("svar", 0x1234));
 	else
 		ut_assertnull(env_get("svar"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -842,7 +842,7 @@ static int fdt_test_set_multi(struct unit_test_state *uts,
 		ut_asserteq(ival2, env_get_hex("svar2", 0x1234));
 		ut_assertnull(env_get("svarn"));
 	}
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -889,17 +889,17 @@ static int fdt_test_set(struct unit_test_state *uts)
 	/* Test setting property of non-existent node */
 	ut_asserteq(1, run_command("fdt set /no-node noprop", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test setting property of non-existent alias */
 	ut_asserteq(1, run_command("fdt set noalias noprop", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test setting property of bad alias */
 	ut_asserteq(1, run_command("fdt set badalias noprop", 1));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -918,46 +918,46 @@ static int fdt_test_mknode(struct unit_test_state *uts)
 	ut_assertok(run_commandf("fdt list /newnode"));
 	ut_assert_nextline("newnode {");
 	ut_assert_nextline("};");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test creation of new node in /test-node@1234 */
 	ut_assertok(run_commandf("fdt mknode /test-node@1234 newsubnode"));
 	ut_assertok(run_commandf("fdt list /test-node@1234/newsubnode"));
 	ut_assert_nextline("newsubnode {");
 	ut_assert_nextline("};");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test creation of new node in /test-node@1234 by alias */
 	ut_assertok(run_commandf("fdt mknode testnodealias newersubnode"));
 	ut_assertok(run_commandf("fdt list testnodealias/newersubnode"));
 	ut_assert_nextline("newersubnode {");
 	ut_assert_nextline("};");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test creation of new node in /test-node@1234 over existing node */
 	ut_asserteq(1, run_commandf("fdt mknode testnodealias newsubnode"));
 	ut_assert_nextline("libfdt fdt_add_subnode(): FDT_ERR_EXISTS");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test creation of new node in /test-node@1234 by alias over existing node */
 	ut_asserteq(1, run_commandf("fdt mknode testnodealias newersubnode"));
 	ut_assert_nextline("libfdt fdt_add_subnode(): FDT_ERR_EXISTS");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test creation of new node in non-existent node */
 	ut_asserteq(1, run_commandf("fdt mknode /no-node newnosubnode"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test creation of new node in non-existent alias */
 	ut_asserteq(1, run_commandf("fdt mknode noalias newfailsubnode"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test creation of new node in bad alias */
 	ut_asserteq(1, run_commandf("fdt mknode badalias newbadsubnode"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -976,7 +976,7 @@ static int fdt_test_rm(struct unit_test_state *uts)
 	ut_assertok(run_commandf("fdt rm / compatible"));
 	ut_asserteq(1, run_commandf("fdt print / compatible"));
 	ut_assert_nextline("libfdt fdt_getprop(): FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test removal of property clock-names in subnode /test-node@1234 */
 	ut_assertok(run_commandf("fdt print /test-node@1234 clock-names"));
@@ -984,7 +984,7 @@ static int fdt_test_rm(struct unit_test_state *uts)
 	ut_assertok(run_commandf("fdt rm /test-node@1234 clock-names"));
 	ut_asserteq(1, run_commandf("fdt print /test-node@1234 clock-names"));
 	ut_assert_nextline("libfdt fdt_getprop(): FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test removal of property u-boot,empty-property in subnode /test-node@1234 by alias */
 	ut_assertok(run_commandf("fdt print testnodealias u-boot,empty-property"));
@@ -992,44 +992,44 @@ static int fdt_test_rm(struct unit_test_state *uts)
 	ut_assertok(run_commandf("fdt rm testnodealias u-boot,empty-property"));
 	ut_asserteq(1, run_commandf("fdt print testnodealias u-boot,empty-property"));
 	ut_assert_nextline("libfdt fdt_getprop(): FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test removal of non-existent property noprop in subnode /test-node@1234 */
 	ut_asserteq(1, run_commandf("fdt rm /test-node@1234 noprop"));
 	ut_assert_nextline("libfdt fdt_delprop(): FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test removal of non-existent node /no-node@5678 */
 	ut_asserteq(1, run_commandf("fdt rm /no-node@5678"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test removal of subnode /test-node@1234/subnode by alias */
 	ut_assertok(run_commandf("fdt rm subnodealias"));
 	ut_asserteq(1, run_commandf("fdt print /test-node@1234/subnode"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test removal of node by non-existent alias */
 	ut_asserteq(1, run_commandf("fdt rm noalias"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test removal of node by bad alias */
 	ut_asserteq(1, run_commandf("fdt rm noalias"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_BADPATH");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test removal of node /test-node@1234 */
 	ut_assertok(run_commandf("fdt rm /test-node@1234"));
 	ut_asserteq(1, run_commandf("fdt print /test-node@1234"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test removal of node / */
 	ut_assertok(run_commandf("fdt rm /"));
 	ut_asserteq(1, run_commandf("fdt print /"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -1046,17 +1046,17 @@ static int fdt_test_bootcpu(struct unit_test_state *uts)
 	/* Test getting default bootcpu entry */
 	ut_assertok(run_commandf("fdt header get bootcpu boot_cpuid_phys"));
 	ut_asserteq(0, env_get_ulong("bootcpu", 10, 0x1234));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test setting and getting new bootcpu entry, twice, to test overwrite */
 	for (i = 42; i <= 43; i++) {
 		ut_assertok(run_commandf("fdt bootcpu %d", i));
-		ut_assertok(ut_check_console_end(uts));
+		ut_assert_console_end();
 
 		/* Test getting new bootcpu entry */
 		ut_assertok(run_commandf("fdt header get bootcpu boot_cpuid_phys"));
 		ut_asserteq(i, env_get_ulong("bootcpu", 10, 0x1234));
-		ut_assertok(ut_check_console_end(uts));
+		ut_assert_console_end();
 	}
 
 	return 0;
@@ -1069,11 +1069,11 @@ static int fdt_test_header_get(struct unit_test_state *uts,
 	/* Test getting valid header entry */
 	ut_assertok(run_commandf("fdt header get fvar %s", field));
 	ut_asserteq(val, env_get_hex("fvar", 0x1234));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test getting malformed header entry */
 	ut_asserteq(1, run_commandf("fdt header get fvar typo%stypo", field));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -1099,7 +1099,7 @@ static int fdt_test_header(struct unit_test_state *uts)
 	ut_assert_nextline("size_dt_struct:\t\t0x%x", fdt_size_dt_struct(fdt));
 	ut_assert_nextline("number mem_rsv:\t\t0x%x", fdt_num_mem_rsv(fdt));
 	ut_assert_nextline_empty();
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test header get */
 	ut_assertok(fdt_test_header_get(uts, "magic", fdt_magic(fdt)));
@@ -1175,7 +1175,7 @@ static int fdt_test_memory_cells(struct unit_test_state *uts,
 	ut_assert_nextline("\tdevice_type = \"memory\";");
 	ut_assert_nextline("\treg = <%s %s>;", pada, pads);
 	ut_assert_nextline("};");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	free(sets);
 	free(seta);
@@ -1223,7 +1223,7 @@ static int fdt_test_rsvmem(struct unit_test_state *uts)
 	ut_assert_nextline("------------------------------------------------");
 	ut_assert_nextline("    %x\t%016x\t%016x", 0, 0x42, 0x1701);
 	ut_assert_nextline("    %x\t%016x\t%016x", 1, 0x74656, 0x9);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test add new reserved memory node */
 	ut_assertok(run_commandf("fdt rsvmem add 0x1234 0x5678"));
@@ -1233,7 +1233,7 @@ static int fdt_test_rsvmem(struct unit_test_state *uts)
 	ut_assert_nextline("    %x\t%016x\t%016x", 0, 0x42, 0x1701);
 	ut_assert_nextline("    %x\t%016x\t%016x", 1, 0x74656, 0x9);
 	ut_assert_nextline("    %x\t%016x\t%016x", 2, 0x1234, 0x5678);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test delete reserved memory node */
 	ut_assertok(run_commandf("fdt rsvmem delete 0"));
@@ -1242,7 +1242,7 @@ static int fdt_test_rsvmem(struct unit_test_state *uts)
 	ut_assert_nextline("------------------------------------------------");
 	ut_assert_nextline("    %x\t%016x\t%016x", 0, 0x74656, 0x9);
 	ut_assert_nextline("    %x\t%016x\t%016x", 1, 0x1234, 0x5678);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test re-add new reserved memory node */
 	ut_assertok(run_commandf("fdt rsvmem add 0x42 0x1701"));
@@ -1252,12 +1252,12 @@ static int fdt_test_rsvmem(struct unit_test_state *uts)
 	ut_assert_nextline("    %x\t%016x\t%016x", 0, 0x74656, 0x9);
 	ut_assert_nextline("    %x\t%016x\t%016x", 1, 0x1234, 0x5678);
 	ut_assert_nextline("    %x\t%016x\t%016x", 2, 0x42, 0x1701);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test delete nonexistent reserved memory node */
 	ut_asserteq(1, run_commandf("fdt rsvmem delete 10"));
 	ut_assert_nextline("libfdt fdt_del_mem_rsv(): FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -1275,7 +1275,7 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	/* Test default chosen node presence, fail as there is no /chosen node */
 	ut_asserteq(1, run_commandf("fdt print /chosen"));
 	ut_assert_nextline("libfdt fdt_path_offset() returned FDT_ERR_NOTFOUND");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test add new chosen node without initrd */
 	ut_assertok(run_commandf("fdt chosen"));
@@ -1289,7 +1289,7 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	    !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
 		ut_assert_nextlinen("\tkaslr-seed = ");
 	ut_assert_nextline("};");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test add new chosen node with initrd */
 	ut_assertok(run_commandf("fdt chosen 0x1234 0x5678"));
@@ -1308,7 +1308,7 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	    !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
 		ut_assert_nextlinen("\tkaslr-seed = ");
 	ut_assert_nextline("};");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -1351,7 +1351,7 @@ static int fdt_test_apply(struct unit_test_state *uts)
 	ut_assert_nextline("\t__symbols__ {");
 	ut_assert_nextline("\t};");
 	ut_assert_nextline("};");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test simple DTO application */
 	ut_assertok(run_commandf("fdt apply 0x%08lx", addro));
@@ -1361,7 +1361,7 @@ static int fdt_test_apply(struct unit_test_state *uts)
 	ut_assert_nextline("\t__symbols__ {");
 	ut_assert_nextline("\t};");
 	ut_assert_nextline("};");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/*
 	 * Create complex DTO which:
@@ -1414,7 +1414,7 @@ static int fdt_test_apply(struct unit_test_state *uts)
 	ut_assert_nextline("\t\tsubnodephandle = \"/subnode\";");
 	ut_assert_nextline("\t};");
 	ut_assert_nextline("};");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/*
 	 * Create complex DTO which:
@@ -1457,7 +1457,7 @@ static int fdt_test_apply(struct unit_test_state *uts)
 	ut_assert_nextline("\t\tsubnodephandle = \"/subnode\";");
 	ut_assert_nextline("\t};");
 	ut_assert_nextline("};");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
diff --git a/test/cmd/font.c b/test/cmd/font.c
index 6f4e54e7f3f..25d365dedd2 100644
--- a/test/cmd/font.c
+++ b/test/cmd/font.c
@@ -30,7 +30,7 @@ static int font_test_base(struct unit_test_state *uts)
 	ut_assert_nextline("nimbus_sans_l_regular");
 	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_CANTORAONE))
 		ut_assert_nextline("cantoraone_regular");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	ut_assertok(vidconsole_get_font_size(dev, &name, &size));
 	ut_asserteq_str("nimbus_sans_l_regular", name);
@@ -48,19 +48,19 @@ static int font_test_base(struct unit_test_state *uts)
 	if (max_metrics < 2) {
 		ut_asserteq(1, ret);
 		ut_assert_nextline("Failed (error -7)");
-		ut_assertok(ut_check_console_end(uts));
+		ut_assert_console_end();
 		return 0;
 	}
 
 	ut_assertok(ret);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	ut_assertok(vidconsole_get_font_size(dev, &name, &size));
 	ut_asserteq_str("cantoraone_regular", name);
 	ut_asserteq(40, size);
 
 	ut_assertok(run_command("font size 30", 0));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	ut_assertok(vidconsole_get_font_size(dev, &name, &size));
 	ut_asserteq_str("cantoraone_regular", name);
diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 8c9d01130a3..e1a9cdffb04 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -264,7 +264,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("mmc dev 6"));
 	ut_assert_nextline("switch to partitions #0, OK");
 	ut_assert_nextline("mmc6 is current device");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Make sure mmc6 is 12+ MiB in size */
 	ut_assertok(run_commandf("mmc read 0x%lx 0x%lx 1", ra, (ulong)0xBFFE00 / 0x200));
@@ -289,7 +289,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
 	000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 00  |...%$..@........|
@@ -324,7 +324,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
 	000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 25  |...%$..@.......%|
@@ -359,7 +359,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
 	000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 25  |...%$..@.......%|
@@ -394,7 +394,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
 	000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 25  |...%$..@.......%|
@@ -426,7 +426,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: write success!");
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
 	000001c0  05 01 0e 25 24 01 00 40  00 00 00 08 00 00 00 25  |...%$..@.......%|
diff --git a/test/cmd/test_echo.c b/test/cmd/test_echo.c
index b829f71c591..8b306cc907f 100644
--- a/test/cmd/test_echo.c
+++ b/test/cmd/test_echo.c
@@ -49,7 +49,7 @@ static int lib_test_hush_echo(struct unit_test_state *uts)
 		console_record_readline(uts->actual_str,
 					sizeof(uts->actual_str));
 		ut_asserteq_str(echo_data[i].expected, uts->actual_str);
-		ut_assertok(ut_check_console_end(uts));
+		ut_assert_console_end();
 	}
 	return 0;
 }
diff --git a/test/cmd/test_pause.c b/test/cmd/test_pause.c
index 927fe174d74..174c31a3852 100644
--- a/test/cmd/test_pause.c
+++ b/test/cmd/test_pause.c
@@ -19,7 +19,7 @@ static int lib_test_hush_pause(struct unit_test_state *uts)
 	ut_assertok(run_command("pause", 0));
 	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
 	ut_asserteq_str("Press any key to continue...", uts->actual_str);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test provided message */
 	/* Cook a newline when the command is expected to pause */
@@ -27,7 +27,7 @@ static int lib_test_hush_pause(struct unit_test_state *uts)
 	ut_assertok(run_command("pause 'Prompt for pause...'", 0));
 	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
 	ut_asserteq_str("Prompt for pause...", uts->actual_str);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Test providing more than one params */
 	/* No newline cooked here since the command is expected to fail */
diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index 1660d2bdcb0..fe26fee54c9 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -221,7 +221,7 @@ static int net_test_wget(struct unit_test_state *uts)
 
 	run_command("md5sum ${loadaddr} ${filesize}", 0);
 	ut_assert_nextline("md5 for 00020000 ... 0002001f ==> 234af48e94b0085060249ecb5942ab57");
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
diff --git a/test/lib/test_print.c b/test/lib/test_print.c
index 55e3ea1ed59..cd7f3f85769 100644
--- a/test/lib/test_print.c
+++ b/test/lib/test_print.c
@@ -20,7 +20,7 @@ static int test_print_freq(struct unit_test_state *uts,
 	print_freq(freq, ";\n");
 	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
 	ut_asserteq_str(expected, uts->actual_str);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
@@ -46,7 +46,7 @@ static int test_print_size(struct unit_test_state *uts,
 	print_size(freq, ";\n");
 	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
 	ut_asserteq_str(expected, uts->actual_str);
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
diff --git a/test/log/cont_test.c b/test/log/cont_test.c
index 395a6587fa2..32b1c792367 100644
--- a/test/log/cont_test.c
+++ b/test/log/cont_test.c
@@ -32,7 +32,7 @@ static int log_test_cont(struct unit_test_state *uts)
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "ERR.arch, ea1"));
 	ut_assertok(ut_check_console_line(uts, "ERR.arch, cc2"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Write a third message which is not a continuation */
 	gd->log_fmt = (1 << LOGF_CAT) | (1 << LOGF_LEVEL) | (1 << LOGF_MSG);
@@ -43,7 +43,7 @@ static int log_test_cont(struct unit_test_state *uts)
 	gd->log_fmt = log_fmt;
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "INFO.efi, ie3"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	/* Write two messages without a newline between them */
 	gd->log_fmt = (1 << LOGF_CAT) | (1 << LOGF_LEVEL) | (1 << LOGF_MSG);
@@ -55,7 +55,7 @@ static int log_test_cont(struct unit_test_state *uts)
 	gd->log_fmt = log_fmt;
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "ERR.arch, ea1 cc2"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
diff --git a/test/log/nolog_ndebug.c b/test/log/nolog_ndebug.c
index d33359d59b7..4dc0f2d3a33 100644
--- a/test/log/nolog_ndebug.c
+++ b/test/log/nolog_ndebug.c
@@ -30,7 +30,7 @@ static int log_test_log_disabled_ndebug(struct unit_test_state *uts)
 	/* Since DEBUG is not defined, we expect to not get debug output */
 	for (i = LOGL_EMERG; i < LOGL_DEBUG; i++)
 		ut_assertok(ut_check_console_line(uts, "testing level %d", i));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
diff --git a/test/log/nolog_test.c b/test/log/nolog_test.c
index e9cfea99026..341dbfc9310 100644
--- a/test/log/nolog_test.c
+++ b/test/log/nolog_test.c
@@ -28,7 +28,7 @@ static int log_test_nolog_err(struct unit_test_state *uts)
 	log_err("testing %s\n", "log_err");
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "testing log_err"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	return 0;
 }
 LOG_TEST(log_test_nolog_err);
@@ -41,7 +41,7 @@ static int log_test_nolog_warning(struct unit_test_state *uts)
 	log_warning("testing %s\n", "log_warning");
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "testing log_warning"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	return 0;
 }
 LOG_TEST(log_test_nolog_warning);
@@ -54,7 +54,7 @@ static int log_test_nolog_notice(struct unit_test_state *uts)
 	log_notice("testing %s\n", "log_notice");
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "testing log_notice"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	return 0;
 }
 LOG_TEST(log_test_nolog_notice);
@@ -67,7 +67,7 @@ static int log_test_nolog_info(struct unit_test_state *uts)
 	log_err("testing %s\n", "log_info");
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "testing log_info"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	return 0;
 }
 LOG_TEST(log_test_nolog_info);
@@ -81,7 +81,7 @@ static int nolog_test_nodebug(struct unit_test_state *uts)
 	memset(buf, 0, BUFFSIZE);
 	debug("testing %s\n", "debug");
 	gd->flags &= ~GD_FLG_RECORD;
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	return 0;
 }
 LOG_TEST(nolog_test_nodebug);
@@ -94,7 +94,7 @@ static int log_test_nolog_nodebug(struct unit_test_state *uts)
 	log_debug("testing %s\n", "log_debug");
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assert(!strcmp(buf, ""));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	return 0;
 }
 LOG_TEST(log_test_nolog_nodebug);
@@ -109,7 +109,7 @@ static int nolog_test_debug(struct unit_test_state *uts)
 	debug("testing %s\n", "debug");
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "testing debug"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	return 0;
 }
 LOG_TEST(nolog_test_debug);
@@ -124,7 +124,7 @@ static int log_test_nolog_debug(struct unit_test_state *uts)
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "testing log_debug"));
 	ut_assertok(ut_check_console_line(uts, "more log_debug"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 	return 0;
 }
 LOG_TEST(log_test_nolog_debug);
diff --git a/test/log/pr_cont_test.c b/test/log/pr_cont_test.c
index 467ecf28601..7734e927f98 100644
--- a/test/log/pr_cont_test.c
+++ b/test/log/pr_cont_test.c
@@ -34,7 +34,7 @@ static int log_test_pr_cont(struct unit_test_state *uts)
 	gd->log_fmt = log_fmt;
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "ea1 cc2"));
-	ut_assertok(ut_check_console_end(uts));
+	ut_assert_console_end();
 
 	return 0;
 }
-- 
2.34.1

