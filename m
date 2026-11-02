Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D18606A335
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P+vwWMS5;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xh/uoll3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 915DF403BD;
	Mon,  2 Nov 2026 20:48:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 42IuGugDD3fc; Mon,  2 Nov 2026 20:48:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 99D9940564
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793652527;
	b=EWOAygWCYBzJIhe7SMl/WUoznVygC84vd3t4SvMETiCQDDXYV3M+QYNh4SJ2Y5kyJATQ
	 Wcn3P7JQMG0+XCNquTrNdOXedA4T1lZYrSgGQQmyiiRAnDcIjGZaQ3YE6LHqgYlBxLE3T
	 ScTyFduW1xkewkEBI/xDNM9AKBnyavmQf+VJZCRmU22cW5JhEWXe3E/c/4NeQ6Ll3/YrM
	 9b92oC5EE20q4/NJ9w8ypSS6++RzQD2n5d9Rgob1p//EH72BvqvKcFwLJuueLhuTBN2eC
	 jGIP3fZ5wzSEc11FyE2szAB2+klEnGx8+LA016vNgy9TTJWy0NFyVT8+hsmyD6jiPUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793652527;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K5l9vT03rg2zwRVNjaKcWOnNP3aaoLjj+zSwnzgoZiY=;
	b=k66soZizNxHVuR1HFFr/fUdCVkCjgHNQ45iTq1b7FLZLqwZaFagHuQvUEpnosm0ItLPo
	 JcNAoBC037jQxtJ8sMuZ3rTyZTJ+iU+V4ynSduKHiWkzsUkTSK6bPmRRdBfRYWFFf25iC
	 Crm/0NkBCZTqUexMSHDbetFiU4C55Sg7J8PhaVUaDAH5LrEWr4ZtMEIMwY6HMpixvoPpq
	 /mMvXtR1vBi5qi764xOiJBBuZS3m2/yhkShaPju7CHxgwz3m+5nGOdlmQcUVsINWn8apa
	 kD6taBWOGa8wzpFXSvFxLJ6QmG+LnkidN9sU9E/AqF+s2xMbHd3vlFLnlSLejKt52Jg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793652527;
	bh=K5l9vT03rg2zwRVNjaKcWOnNP3aaoLjj+zSwnzgoZiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P+vwWMS5buHvK7taYuTxZ6JVxqNtR/9X24OYIoYh4oE0MayGtjprpzALLmajG8m9O
	 9DNb/5xh730TaYflSzJBqsTkJ4Rn66LECFxmv0Lqdt6va0O06ocNAVZeS6L8O8uWMG
	 cBLgYaECsGcdJ4ulXx+7Zs5qeMGcIen7ZdNbVF6O8mY5Y9jlGDSCaNUzYPubZB8BQR
	 dkQuy6CIFgZI5B6x4pz89PYCNaukT0p9331UJhnGNzPPD08c5bMkyckDTHzmKkq4rO
	 7aCG4oFwxO+RqRzl+TJL8/MtMgtNJY9pbmva38HNc2S5NZldaEmD3JM7MBVIAE5UEb
	 9MfIRISOFt3hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99D9940564;
	Mon,  2 Nov 2026 20:48:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1A6F4BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 20:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C30B780906
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 20:48:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4MVZNlsOJjpV for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 20:48:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 653A680971
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::230"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793652526;
 b=b8EL5FrkU2jsGetA56T5+lxlzS4+/kKN3xcTAHULnmCrWhhb4lLu9qNJJwNW/RwdgVL/
 wFdIK5pbUopVxJzxr+am/R82QTJTPAPqqJdYWIeCDuL3ADerMGIdbrRZTe6NkqfChiWIx
 jB2+7rfZXZ9e2JXdqItJac6tZ36ue94WKGENF6oOm73PRNk3yQS4i7ifWGQ9fQvS7kl7T
 74JKStRNvm6SE0XJ8I2+1We+AGgXfjeIyeCLiYazyWLPvF0ESmkkQEYjB6noP85cFN5Hn
 VQWHx+zcWx+D4rqqJPR99at6nGcVSoFyLrqExrGPGv3fgvEyoHOiRXuyO5bjgTRMLHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793652526;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=K5l9vT03rg2zwRVNjaKcWOnNP3aaoLjj+zSwnzgoZiY=;
 b=GGl6HngFtvmWR4/gVgLbKHMfxdh1m5Ie29v+U3TPslFW01K66mT/CrfTGkT0Z3q1rtAK
 KLvGUptVHILGWV++fwThWle+HzKOGGoVoepxiioqvWW4SVYmRq16fjy/NOD+pOHnd1K6c
 DzpO/Z65ckwDRNPd+qmwSYQD49K6zntwnYn/70pK3Q7eKljML7oaCotVpU6CACM8Q7UcO
 r9lPMB8rb7hYFOGXhib5c+mANM4Y1Z8YP5+Qj+GF3XB2WHkskZQsAG2EUJSaCLmdMB7ay
 nrvqs59iuva4XtgBuFxwzbP/t2GmiKt0+NuYyFqK8Rk5p4C3lcK6EBo4Nt3hO0F5tHw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="xh/uoll3"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::230; helo=mail-lj1-x230.google.com;
 envelope-from=maxin.john@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=xh/uoll3
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 653A680971
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 20:48:44 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-3ab3dd966e1so31473661fa.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 12:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793652522; x=1794257322;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K5l9vT03rg2zwRVNjaKcWOnNP3aaoLjj+zSwnzgoZiY=;
 b=xh/uoll3weru8u6i7jaoUMjygwOgpqXisPCQQExUWGRwuUrj0SxV7FTGlfKx+ofBMy
 a0smbLuhOvP2NXqIUrcUWCqxftqZxa7MmVr1CZTWNFEj4J1pH2j6KENr663az8NkWMRj
 6+lxFt4z6PpbdhLpky/C+u6I4WAsDdqvtB8x4iy9UmmbkdcXcLALAnwgpDOhEQnU6jK7
 xk0JxkJ2dHrslk4I26ClpJzL05TavH/wgx+oDCF+tKTRsg5mcpsA4dyIM+400v6RvF4t
 AmRxbhS8PcPuehWka8tcGdQufKeIVYsfAiroOwLeHQWf+ikMt+6W+qSGJpSif3RZS3mG
 5aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793652522; x=1794257322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K5l9vT03rg2zwRVNjaKcWOnNP3aaoLjj+zSwnzgoZiY=;
 b=kXjV2Q6TQvb5pBbGFlXxmasuFBTl/h/8JfEAo1+5kzrxqhiKJSdNSmdy7Ayvb4w8rD
 9o+vEOlB92rDfCN4iorSGpRVs0gQiiK9lDL2f62+GSrF6nOftyVqdWCkPUlITObA8tdR
 MIx87Wt9Qqu8xZ2kFfxOVtSpxWujpBtLFpleg34qRlWgTnbyKLh0/QClXqFn0QcLfi63
 OWtEOHZQ81QFHE6HrKnKbqYL1f1I6ity9AVWW5r3I9HMzt65ytulr8LgOUVV2Ro1Tzyn
 QWCaUanznBCWDsBrGUiJf7L1tfTb57/4HUvQUtPwUcULQFVUaSvzkWsc/HyW59hiSQ8t
 H6Lw==
X-Gm-Message-State: APuU4Z9kXwsyegjl4bD0hcSb+6QzrG8SZyvYlPJt5F2CWSna62dk5vDt
 Fzc6Vgo9H1XhK4s+1liGyfBtQRqiLQQuzgzSTJ+oPjdxE0n3DuNXG8C3
X-Gm-Gg: AYBFou0TD7nK7FLsUKRUn9fM+dpQoJ6TiFe3ePS7eyk2EGL4XsW+MyC3z6mdQaCg0bV
 JG6kw7G6BnPakbBPabpJwjuN6x55Gto8JglpbMr6WQ9Q7GnaB6f71AlppOvZJv3r7lZJwfwg/Tv
 eFl6cCPhn6IiC3l38TJLZ1BJEE7NcMB2DMLIN9jD5AtKTwMBX1jE4Ourb/72buHJ+nOnEfO7Vdf
 f5rQJFywMW+4FzdyIIRUhQyljkr/YsjOATtccE6+z99fV5XbfARkTwiMOxgAK+4h4fIAykOk57i
 FieX+ePs5EsF41pWPcebXS2GWsFwPQgIt7CozYNmJdpR9G5tYrZz6KpGreDqcyHF7ejsCZi5rea
 HJQl1sHMTnc+mkSuMoI1HNAvwn/xcCimS/ltjz3j6YqakUSMIHQOAgZqiVIxxFkq4hTvBE5ArVP
 LnVz3rBUGfYb1XiQv4O8hhkws3mmKDm5Kvd2XME0DZ43+lJ1krIqsMEEJ6acnlSrOnUu/kXBA2J
 fMGgh5fVs2fgEzIDl3BXnBJ36hz9lWG43FmOkzKDZpqVeadao567eYkaTJv4UOqwb/KLNN6DB/l
 IPJ8P0UMtwCEbrNK6qY+L9l7bCNcLBgd4LFqDd5K/2q9rg1ojN/GGaG7i/C0vlsXVhBRh2q7Pg8
 BeQ==
X-Received: by 2002:a2e:a991:0:b0:3ac:48a0:e253 with SMTP id
 38308e7fff4ca-3acb7b46ed2mr26502931fa.23.1793652522003; 
 Mon, 02 Nov 2026 12:48:42 -0800 (PST)
Received: from Thor.lan (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi.
 [2001:99a:a58:9b00:9119:221d:45f0:de83])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe0721784sm1963460e87.22.2026.11.02.12.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 12:48:40 -0800 (PST)
From: "Maxin B. John" <maxin.john@gmail.com>
To: sjg@chromium.org
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 dario.binacchi@amarulasolutions.com, rv@rasmusvillemoes.dk,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v2] test: cmd: add tests for the binop command
Date: Mon,  2 Nov 2026 22:48:39 +0200
Message-ID: <20261102204839.2249418-1-maxin.john@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFLszTjZ1XXUYvNoUrBo4ny+dFKP=0=q_xcOobs3D0Lsqdi0AA@mail.gmail.com>
References: <CAFLszTjZ1XXUYvNoUrBo4ny+dFKP=0=q_xcOobs3D0Lsqdi0AA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

binop has had no tests so far. Add some, so that bugs like the heap
overrun fixed in the previous commit are caught in CI.

Each operation (xor, or, and) is run on hex strings, env vars or
memory, with the result going to an env var, memory or the console.

The tests also check that:
- short inputs are zero-padded
- console output wraps after 16 bytes, with no blank line when the
  count is exactly 16
- bad counts, operators, addresses or hex strings are rejected with
  the expected error message or usage text, without touching the
  destination

There is also a test for the heap overrun, which checks that the
over-long value is rejected for its length.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
Changes in v2:
- Add a console test with a count of exactly 16
- Check the error message or usage text after each failing command, so
  the tests show which check rejected the input
---
 test/cmd/Makefile |   1 +
 test/cmd/binop.c  | 237 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 238 insertions(+)
 create mode 100644 test/cmd/binop.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index e734933d5f73..79cbb291250b 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -13,6 +13,7 @@ endif
 obj-$(CONFIG_HUSH_PARSER) += exit.o
 obj-$(CONFIG_X86) += cpuid.o msr.o
 obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
+obj-$(CONFIG_CMD_BINOP) += binop.o
 ifdef CONFIG_CONSOLE_RECORD
 obj-$(CONFIG_CMD_ACPI) += acpi.o
 endif
diff --git a/test/cmd/binop.c b/test/cmd/binop.c
new file mode 100644
index 000000000000..bd9a0764abda
--- /dev/null
+++ b/test/cmd/binop.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for the binop command
+ */
+
+#include <command.h>
+#include <env.h>
+#include <mapmem.h>
+#include <test/cmd.h>
+#include <test/ut.h>
+
+#define MEM_ADDR	((ulong)CONFIG_SYS_LOAD_ADDR + 0x1000)
+
+/* Error messages for a bad hex string, given directly or in an env var */
+#define HEX_ERR		"Error: '%s' is not an env var or hex string of up to %d bytes"
+#define ENV_ERR		"Error: env var '%s' value '%s' is not a hex string of up to %d bytes"
+
+static int cmd_test_binop_ops(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("binop xor 4 01020304 ffffffff binop_out", 0));
+	ut_asserteq_str("fefdfcfb", env_get("binop_out"));
+
+	ut_assertok(run_command("binop or 4 01020304 00000000 binop_out", 0));
+	ut_asserteq_str("01020304", env_get("binop_out"));
+
+	ut_assertok(run_command("binop and 4 0f0f0f0f 00ff00ff binop_out", 0));
+	ut_asserteq_str("000f000f", env_get("binop_out"));
+
+	ut_assertok(run_command("binop xor 2 AABB CCDD binop_out", 0));
+	ut_asserteq_str("6666", env_get("binop_out"));
+
+	env_set("binop_out", NULL);
+
+	return 0;
+}
+
+CMD_TEST(cmd_test_binop_ops, 0);
+
+static int cmd_test_binop_env(struct unit_test_state *uts)
+{
+	ut_assertok(env_set("binop_a", "aabbccdd"));
+	ut_assertok(env_set("binop_b", "11223344"));
+
+	ut_assertok(run_command("binop xor 4 binop_a binop_b binop_out", 0));
+	ut_asserteq_str("bb99ff99", env_get("binop_out"));
+
+	/* Short env var is zero-padded */
+	ut_assertok(env_set("binop_a", "01"));
+	ut_assertok(run_command("binop xor 4 binop_a binop_b binop_out", 0));
+	ut_asserteq_str("10223344", env_get("binop_out"));
+
+	env_set("binop_a", NULL);
+	env_set("binop_b", NULL);
+	env_set("binop_out", NULL);
+
+	return 0;
+}
+
+CMD_TEST(cmd_test_binop_env, 0);
+
+static int cmd_test_binop_mem(struct unit_test_state *uts)
+{
+	const u8 expect[] = { 0x0e, 0x0d, 0x0c, 0x0b };
+	u8 *buf;
+
+	buf = map_sysmem(MEM_ADDR, 8);
+	memset(buf, 0, 8);
+	buf[0] = 0x01;
+	buf[1] = 0x02;
+	buf[2] = 0x03;
+	buf[3] = 0x04;
+
+	ut_assertok(run_commandf("binop xor 4 *0x%lx 01010101 binop_out",
+				 MEM_ADDR));
+	ut_asserteq_str("00030205", env_get("binop_out"));
+
+	ut_assertok(run_commandf("binop xor 4 *0x%lx 0f0f0f0f *0x%lx",
+				 MEM_ADDR, MEM_ADDR + 4));
+	ut_asserteq_mem(expect, buf + 4, sizeof(expect));
+
+	unmap_sysmem(buf);
+	env_set("binop_out", NULL);
+
+	return 0;
+}
+
+CMD_TEST(cmd_test_binop_mem, 0);
+
+static int cmd_test_binop_short(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("binop xor 4 01 02 binop_out", 0));
+	ut_asserteq_str("03000000", env_get("binop_out"));
+
+	ut_assertok(env_set("binop_a", "0102"));
+	ut_assertok(run_command("binop or 4 binop_a 03 binop_out", 0));
+	ut_asserteq_str("03020000", env_get("binop_out"));
+
+	env_set("binop_a", NULL);
+	env_set("binop_out", NULL);
+
+	return 0;
+}
+
+CMD_TEST(cmd_test_binop_short, 0);
+
+static int cmd_test_binop_print(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("binop xor 2 0102 0304", 0));
+	ut_assert_nextline("02 06 ");
+	ut_assert_console_end();
+
+	/* Output wraps after 16 bytes */
+	ut_assertok(run_command("binop xor 17 000102030405060708090a0b0c0d0e0f10 00",
+				0));
+	ut_assert_nextline("00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f ");
+	ut_assert_nextline("10 ");
+	ut_assert_console_end();
+
+	/* Exactly 16 bytes fill one line, with no blank line after it */
+	ut_assertok(run_command("binop xor 16 000102030405060708090a0b0c0d0e0f 00",
+				0));
+	ut_assert_nextline("00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f ");
+	ut_assert_console_end();
+
+	return 0;
+}
+
+CMD_TEST(cmd_test_binop_print, UTF_CONSOLE);
+
+/* Check that the command printed its usage text and nothing else */
+static int check_usage(struct unit_test_state *uts)
+{
+	ut_assert_nextline("binop - compute binary operation");
+	ut_assert_nextline_empty();
+	if (IS_ENABLED(CONFIG_SYS_LONGHELP)) {
+		ut_assert_nextline("Usage:");
+		ut_assert_skip_to_line("      xor, or, and.");
+	}
+	ut_assert_console_end();
+
+	return 0;
+}
+
+static int cmd_test_binop_invalid(struct unit_test_state *uts)
+{
+	/* Failed operations must not change binop_out */
+	ut_assertok(env_set("binop_out", "deadbeef"));
+
+	/* Literal hex string: too long, odd length, not hex */
+	ut_asserteq(1, run_command("binop xor 2 010203 01 binop_out", 0));
+	ut_assert_nextline(HEX_ERR, "010203", 2);
+	ut_assert_console_end();
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_asserteq(1, run_command("binop xor 2 010 01 binop_out", 0));
+	ut_assert_nextline(HEX_ERR, "010", 2);
+	ut_assert_console_end();
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_asserteq(1, run_command("binop xor 2 zz 01 binop_out", 0));
+	ut_assert_nextline(HEX_ERR, "zz", 2);
+	ut_assert_console_end();
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	/* Env var value: not hex (but fits the count), too long, odd length */
+	ut_assertok(env_set("binop_bad", "zzzz"));
+	ut_asserteq(1, run_command("binop xor 2 binop_bad 01 binop_out", 0));
+	ut_assert_nextline(ENV_ERR, "binop_bad", "zzzz", 2);
+	ut_assert_console_end();
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_assertok(env_set("binop_big", "0102030405"));
+	ut_asserteq(1, run_command("binop xor 2 binop_big 01 binop_out", 0));
+	ut_assert_nextline(ENV_ERR, "binop_big", "0102030405", 2);
+	ut_assert_console_end();
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_assertok(env_set("binop_odd", "010"));
+	ut_asserteq(1, run_command("binop xor 2 binop_odd 01 binop_out", 0));
+	ut_assert_nextline(ENV_ERR, "binop_odd", "010", 2);
+	ut_assert_console_end();
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	/* Invalid count and operator */
+	ut_asserteq(1, run_command("binop xor 0 01 02 binop_out", 0));
+	ut_assertok(check_usage(uts));
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_asserteq(1, run_command("binop xor x 01 02 binop_out", 0));
+	ut_assertok(check_usage(uts));
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_asserteq(1, run_command("binop nope 2 0102 0304 binop_out", 0));
+	ut_assertok(check_usage(uts));
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	/* Invalid source and destination addresses */
+	ut_asserteq(1, run_command("binop xor 2 *nope 01 binop_out", 0));
+	ut_assert_nextline("Error: invalid address 'nope'");
+	ut_assert_console_end();
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_asserteq(1, run_command("binop xor 2 0102 0304 *nope", 0));
+	ut_assert_nextline("Error: invalid address 'nope'");
+	ut_assert_console_end();
+
+	env_set("binop_bad", NULL);
+	env_set("binop_big", NULL);
+	env_set("binop_odd", NULL);
+	env_set("binop_out", NULL);
+
+	return 0;
+}
+
+CMD_TEST(cmd_test_binop_invalid, UTF_CONSOLE);
+
+static int cmd_test_binop_overrun(struct unit_test_state *uts)
+{
+	/*
+	 * A 25-byte value with a 4-byte count used to overrun the 4-byte
+	 * heap buffer. The command must now reject it.
+	 */
+	ut_assertok(env_set("binop_first", "01020304"));
+	ut_assertok(env_set("binop_second",
+			    "12334545434543534543534535456456456543534543534534"));
+
+	ut_asserteq(1, run_command("binop xor 4 binop_first binop_second", 0));
+	ut_assert_nextline(ENV_ERR, "binop_second", env_get("binop_second"), 4);
+	ut_assert_console_end();
+
+	env_set("binop_first", NULL);
+	env_set("binop_second", NULL);
+
+	return 0;
+}
+
+CMD_TEST(cmd_test_binop_overrun, UTF_CONSOLE);
-- 
2.47.3

