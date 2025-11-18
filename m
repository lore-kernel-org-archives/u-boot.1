Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66278CCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 04:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5411D83C98;
	Tue, 18 Nov 2025 05:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="XIQeM/NA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 715A483C16; Tue, 18 Nov 2025 05:31:28 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81EEB83C93
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 05:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EB225109C86; Tue, 18 Nov 2025 05:31:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763440286; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Gsrf2l1z3Dfr9eUlONohYsHaVi15kIwmgnEdzJy69j8=;
 b=XIQeM/NAAq5KZmYlORs0+DFeFPBJWmjvbPpX3a6nucxr1U55PcUbhxjPJyUw+yObN9Vws2
 4WDKmz1i6HoMU+hNJOjLjXQUXh/XcDljocrUV1K/wybNogQiRG36vIvJto+wdtjfW9uV7Z
 m1W2NiajBQ6+StYDPmdd8w1V3bR/eo7eAqenOTToRpt2yR6aHvGM0XaocTXAJ2vYToNYuQ
 Md5U0nc5zaGqA2uDoFBuMvkGzclz0AeI4/3wJOEjZ3bKvmQxJN2cTRkTT3atIcBLKxlgC/
 uRkB+STRZ/c/HuKiNIMT/SjEp0OTVm5P60W+1P1HNvqhF1ZtB/uvdwtlDsim2Q==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/6] test: cmd: hash: add unit test for sm3_256
Date: Tue, 18 Nov 2025 05:30:40 +0100
Message-Id: <20251118043042.27726-5-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251118043042.27726-1-hs@nabladev.com>
References: <20251118043042.27726-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

add simple test for sm3 256 hash

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
I wonder why this tests are under DM and not under CMD
Should we move them to CMD ?

Ignored checkpatch warnings for too long lines.
ignore checkpatch warning:
test/cmd/hash.c:152: check: Please use a blank line after function/struct/union/enum declarations

as this is in the last line, and no new lines at the end
allowed.

Changes in v3:
use CMD_TEST instead of DM_TEST, as Heinrich confirmed

 test/cmd/hash.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/test/cmd/hash.c b/test/cmd/hash.c
index bb96380c351..ced18319f34 100644
--- a/test/cmd/hash.c
+++ b/test/cmd/hash.c
@@ -9,6 +9,7 @@
 #include <env.h>
 #include <dm.h>
 #include <dm/test.h>
+#include <test/cmd.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -103,3 +104,49 @@ static int dm_test_cmd_hash_sha256(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_cmd_hash_sha256, UTF_CONSOLE);
+
+static int cmd_test_hash_sm3_256(struct unit_test_state *uts)
+{
+	const char *sum = "1ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed035eb5082aa2b";
+
+	if (!CONFIG_IS_ENABLED(SM3)) {
+		ut_assert(run_command("hash sm3_256 $loadaddr 0", 0));
+
+		return 0;
+	}
+
+	ut_assertok(run_command("hash sm3_256 $loadaddr 0", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_asserteq_ptr(uts->actual_str,
+			strstr(uts->actual_str, "sm3_256 for "));
+	ut_assert(strstr(uts->actual_str, sum));
+	ut_assert_console_end();
+
+	ut_assertok(run_command("hash sm3_256 $loadaddr 0 foo; echo $foo", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_asserteq_ptr(uts->actual_str,
+			strstr(uts->actual_str, "sm3_256 for "));
+	ut_assert(strstr(uts->actual_str, sum));
+	ut_assertok(ut_check_console_line(uts, sum));
+
+	if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
+		ut_assert(run_command("hash -v sm3_256 $loadaddr 0 foo", 0));
+		ut_assertok(ut_check_console_line(uts,
+						  "hash - compute hash message digest"));
+
+		return 0;
+	}
+
+	ut_assertok(run_command("hash -v sm3_256 $loadaddr 0 foo", 0));
+	ut_assert_console_end();
+
+	env_set("foo",
+		"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
+	ut_assert(run_command("hash -v sm3_256 $loadaddr 0 foo", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_assert(strstr(uts->actual_str, "!="));
+	ut_assert_console_end();
+
+	return 0;
+}
+CMD_TEST(cmd_test_hash_sm3_256, UTF_CONSOLE);
-- 
2.20.1

