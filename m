Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DA9E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 369418928C;
	Sat,  2 Nov 2024 20:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T5Q0Lm+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244D18926F; Sat,  2 Nov 2024 20:37:45 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F23892DE
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4609c96b2e5so20121391cf.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576261; x=1731181061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MrJDEDXESp2Ef7r7jD6wO3d6XPZZrjsDm/viB5uzzV8=;
 b=T5Q0Lm+pZL+IgwVol7CdhJxDVZRWLxBamsqcQ0YheaJtwXs1RALrUsHvQnplt1VtRv
 SgyLLD5EPZ8cC2zzBU2ainN/0irapfx5zWRxchy7gMGkBqGuYme95q2Da01VXd5h3dN3
 r1jkbSQAujJImeL8xGpvJRcuJmy8WFc4w5jto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576261; x=1731181061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MrJDEDXESp2Ef7r7jD6wO3d6XPZZrjsDm/viB5uzzV8=;
 b=FX/9uQqjiUwlEqTzSptHm+LooJ/olMHMvuzruvOw6zSc+HZRxkZP5R504igjhbRWxZ
 cHTzpKMYtoEA1erJ8/0Jl8VYqnvDboh8Pu9PJqner0PXuyH9obw6Umik4+8FjSRaadxX
 U4ySyEhFVqsWy4Kql8T6tsD+Xmg8go5Qm9CBiWjQsDtWp6NLFDSP98hBS9hmNm5rXrW1
 E7LeL9BUeP1t7FxNq24/m9rcRtB8D1EKgkC7BoLuBFlO1xaoIfCYmQ8PsFlz0f4fK9xv
 QU61slQ8Qo0MWIC8/wgyQM7oeMFyFF0AlBobm7fZZ4ASQOKb08VNtXz/V33NMoa82oJp
 00qw==
X-Gm-Message-State: AOJu0YypHpXgWimIerY8eX8iKS1JFtwMLSOv4sKm01nBq9Hquw6hm7Dy
 c7PMBOuuAGV2U6ZCu1uYABFOb7NhMJT+1yLguEdM3X5Ey3tRGmhS7qMtiZfT5kKCgugOw4kYk3K
 yFrHA
X-Google-Smtp-Source: AGHT+IGQJS7lz1/CZipcanby5UO40QivkKAzo/vM8vu8Xo6eHjXb3oz/ZsC3hTmKgB/Hw0WDzho5aA==
X-Received: by 2002:a05:6214:2dca:b0:6cb:ef34:9c00 with SMTP id
 6a1803df08f44-6d18568f24fmr413548466d6.12.1730576261206; 
 Sat, 02 Nov 2024 12:37:41 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/20] test: Update command test to use unit-test functions
Date: Sat,  2 Nov 2024 13:36:53 -0600
Message-ID: <20241102193715.432529-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

(no changes since v1)

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

