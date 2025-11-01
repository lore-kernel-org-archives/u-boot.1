Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD3ECCF9F0
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 06:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E3A683AA4;
	Sat,  1 Nov 2025 07:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="hRzKwY8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 915CD83ABF; Sat,  1 Nov 2025 07:49:28 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B7483A27
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 07:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 18FC5109803; Sat,  1 Nov 2025 07:49:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761979766; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=eRMr/rG5zgG7cFYoWpOkFpFPfR69euybeP6Qf8iR6cE=;
 b=hRzKwY8ZHcXwZMLX+co6W7r1S1bgirUhGfs7EXZGHRVCTWiU/vIYbKjJGn94WrPqMUI+tx
 uDAFRCIjfqdrIbLmihr6MmdaXdYRqDTO1TQSbh6nhj0xUeJ8A/WammDmTodpZQENj8dYyr
 dsgjBYImI+ubplQzxgORL+0UToxYzY+JOwpnsG6ePA1/FmbEJXYC0xG3Q/DK+LBxCaPC5y
 sWtSLgf3UO9sZEao1iWwV4WNNpWWW7TAzrNvDBj/Cx4n0HY1eAflRRKgKF7kIcUf5QxPYD
 K1D5fRU6nPyQJgsaaR/S0voCzZcex90GO2Y2AqwJthyP4X21741lYyTPMWPmdg==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 3/5] test: cmd: add unit test for sm3 hash
Date: Sat,  1 Nov 2025 07:49:05 +0100
Message-Id: <20251101064907.5037-4-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251101064907.5037-1-hs@nabladev.com>
References: <20251101064907.5037-1-hs@nabladev.com>
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

 test/cmd/hash.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/test/cmd/hash.c b/test/cmd/hash.c
index bb96380c351..3f7f64d27d3 100644
--- a/test/cmd/hash.c
+++ b/test/cmd/hash.c
@@ -103,3 +103,49 @@ static int dm_test_cmd_hash_sha256(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_cmd_hash_sha256, UTF_CONSOLE);
+
+static int dm_test_cmd_hash_sm3_256(struct unit_test_state *uts)
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
+DM_TEST(dm_test_cmd_hash_sm3_256, UTF_CONSOLE);
-- 
2.20.1

