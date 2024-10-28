Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58761D10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CFA789103;
	Mon, 28 Oct 2024 13:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CkIUk6xC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55C538910C; Mon, 28 Oct 2024 13:41:54 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C12890D5
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso598621966b.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119311; x=1730724111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpJwt9ww3Y1ABI7p95Xfoo0ZPNxw+dxkXXb9NnCw/7s=;
 b=CkIUk6xCHNN6u5hs9MyFyWxiKX1Lgds69Jb3URK0SoxjJnhh8clrFRMJ4wB6H+qcyU
 za4/59sQKhDtkf/Yunvc8mb49nMyM6d2GX7BlrmosDd4BTt9WqVT9LMYjW6Nx6tMLBmh
 GLbdZYTOgbPGacDL1Z6Sb+gZH0yAq28NT7VmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119311; x=1730724111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wpJwt9ww3Y1ABI7p95Xfoo0ZPNxw+dxkXXb9NnCw/7s=;
 b=qgfaZj97zykLfvIEfO9pdi94q5qnrDhPytViQAPCf7B2LYzRqH6G4mMtXjaCXlCaok
 v9jmDkOhvt2T4WXhX/ysNod7HlpGYXeQao3SGt5o0PPAsEvXXwIepSgcgXHcjGMYmS2L
 xCZvkomWs0V1l7fL1VOfQQ2aYJh5zcp4Bbb6V+VdMNxT8DUUl2k8QGo9oxBE2FO4/A8B
 vbbFifoNbZa2h+tJfzTfxKJHdiJaI4Sl0mn8TtQ+UizogwrfOunjP/Jyz/twiAQ6yc+z
 dsD5mzBThlvji4ji0GEYaMjj8mgcCiOnwEZ4EV3ctUwH6le0ZsVLicCZd/tmUugA4NaL
 C7jg==
X-Gm-Message-State: AOJu0YyNoQgTFoTApANOKf6o/uvC5NlDQuo+B5/EREQUZmTEIUO0kI0w
 Uyu88RL7QzUbS/Mn/DF1K6M91qSCX4yquuuHl08hUQhg0NkIaOr5tHQ/Jf/oPpy+fh3Qqs2YMVL
 Uvg==
X-Google-Smtp-Source: AGHT+IFt5+rODpP8E5NSye6VMRJVElnwcTgOjO5ektiuk5xg0+ICdvQpfJowbKWZTk+b+UI/cUq76A==
X-Received: by 2002:a17:907:8694:b0:a99:43e5:ac37 with SMTP id
 a640c23a62f3a-a9de5ecc0c8mr683083466b.15.1730119310631; 
 Mon, 28 Oct 2024 05:41:50 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/21] test: Update command test to use unit-test functions
Date: Mon, 28 Oct 2024 13:41:14 +0100
Message-ID: <20241028124130.32072-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

Rather than enabled DEBUG and using assert(), use the unit-test
functions now provided.

Drop a check that causes pytest to fail.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd/command.c | 63 +++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/test/cmd/command.c b/test/cmd/command.c
index 77800687ec3..5ec93d490ba 100644
--- a/test/cmd/command.c
+++ b/test/cmd/command.c
@@ -26,16 +26,16 @@ static int command_test(struct unit_test_state *uts)
 
 	/* commands separated by \n */
 	run_command_list("setenv list 1\n setenv list ${list}1", -1, 0);
-	assert(!strcmp("11", env_get("list")));
+	ut_assert(!strcmp("11", env_get("list")));
 
 	/* command followed by \n and nothing else */
 	run_command_list("setenv list 1${list}\n", -1, 0);
-	assert(!strcmp("111", env_get("list")));
+	ut_assert(!strcmp("111", env_get("list")));
 
 	/* a command string with \0 in it. Stuff after \0 should be ignored */
 	run_command("setenv list", 0);
 	run_command_list(test_cmd, sizeof(test_cmd), 0);
-	assert(!strcmp("123", env_get("list")));
+	ut_assert(!strcmp("123", env_get("list")));
 
 	/*
 	 * a command list where we limit execution to only the first command
@@ -43,60 +43,61 @@ static int command_test(struct unit_test_state *uts)
 	 */
 	run_command_list("setenv list 1\n setenv list ${list}2; "
 		"setenv list ${list}3", strlen("setenv list 1"), 0);
-	assert(!strcmp("1", env_get("list")));
+	ut_assert(!strcmp("1", env_get("list")));
 
-	assert(run_command("false", 0) == 1);
-	assert(run_command("echo", 0) == 0);
-	assert(run_command_list("false", -1, 0) == 1);
-	assert(run_command_list("echo", -1, 0) == 0);
+	ut_asserteq(1, run_command("false", 0));
+	ut_assertok(run_command("echo", 0));
+	ut_asserteq(1, run_command_list("false", -1, 0));
+	ut_assertok(run_command_list("echo", -1, 0));
 
 #ifdef CONFIG_HUSH_PARSER
 	run_command("setenv foo 'setenv black 1\nsetenv adder 2'", 0);
 	run_command("run foo", 0);
-	assert(env_get("black") != NULL);
-	assert(!strcmp("1", env_get("black")));
-	assert(env_get("adder") != NULL);
-	assert(!strcmp("2", env_get("adder")));
+	ut_assertnonnull(env_get("black"));
+	ut_asserteq(0, strcmp("1", env_get("black")));
+	ut_assertnonnull(env_get("adder"));
+	ut_asserteq(0, strcmp("2", env_get("adder")));
 #endif
 
-	assert(run_command("", 0) == 0);
-	assert(run_command(" ", 0) == 0);
+	ut_assertok(run_command("", 0));
+	ut_assertok(run_command(" ", 0));
 
-	assert(run_command("'", 0) == 1);
+	ut_asserteq(1, run_command("'", 0));
 
 	/* Variadic function test-cases */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wformat-zero-length"
-	assert(run_commandf("") == 0);
+	ut_assertok(run_commandf(""));
 #pragma GCC diagnostic pop
-	assert(run_commandf(" ") == 0);
-	assert(run_commandf("'") == 1);
+	ut_assertok(run_commandf(" "));
+	ut_asserteq(1, run_commandf("'"));
 
-	assert(run_commandf("env %s %s", "delete -f", "list") == 0);
+	ut_assertok(run_commandf("env %s %s", "delete -f", "list"));
 	/*
 	 * Expected: "## Error: "list" not defined"
 	 * (disabled to avoid pytest bailing out)
 	 *
-	 * assert(run_commandf("printenv list") == 1);
+	 * ut_asserteq(1, run_commandf("printenv list"));
 	 */
 
 	memset(long_str, 'x', sizeof(long_str));
-	assert(run_commandf("Truncation case: %s", long_str) == -ENOSPC);
+	ut_asserteq(-ENOSPC, run_commandf("Truncation case: %s", long_str));
 
 	if (IS_ENABLED(CONFIG_HUSH_PARSER)) {
-		assert(run_commandf("env %s %s %s %s", "delete -f", "adder",
-				    "black", "foo") == 0);
-		assert(run_commandf("setenv foo 'setenv %s 1\nsetenv %s 2'",
-				    "black", "adder") == 0);
-		run_command("run foo", 0);
-		assert(env_get("black"));
-		assert(!strcmp("1", env_get("black")));
-		assert(env_get("adder"));
-		assert(!strcmp("2", env_get("adder")));
+		ut_assertok(run_commandf("env %s %s %s %s", "delete -f",
+					 "adder", "black", "foo"));
+		ut_assertok(run_commandf(
+			"setenv foo 'setenv %s 1\nsetenv %s 2'",
+			"black", "adder"));
+		ut_assertok(run_command("run foo", 0));
+		ut_assertnonnull(env_get("black"));
+		ut_asserteq(0, strcmp("1", env_get("black")));
+		ut_assertnonnull(env_get("adder"));
+		ut_asserteq(0, strcmp("2", env_get("adder")));
 	}
 
 	/* Clean up before exit */
-	run_command("env default -f -a", 0);
+	ut_assertok(run_command("env default -f -a", 0));
 
 	/* put back the FDT environment */
 	ut_assertok(env_set("from_fdt", "yes"));
-- 
2.43.0

