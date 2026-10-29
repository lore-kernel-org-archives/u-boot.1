Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B4606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jvqmfrUD;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qDbY/Exl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C37C4810D8;
	Thu, 29 Oct 2026 17:42:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rz39BJeXk0t3; Thu, 29 Oct 2026 17:42:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A43CE810BA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295724;
	b=gCFwObUTwnKxzvrmKGEtYQqJcAYECHlkF9NNqoUb+DNitqLjRQFsnllWJgIyfMoJDwWV
	 E1xxXUZdKfeyuVuXTHfx1ccYLyBIocU5ihox5fdHTIk+f/7nmNF4x/KpmOoROT4lEhGZw
	 6FCsxPVDJxsPia4iAfRSeZA4EitA0CT+cafYJT2dcsE8ObG+E4GAtZ4dlJaDs1c5ju84Q
	 uX7dbZDgS0bV8bFrvC/Wv2wEEZ+d9lXVciSmuXAgoeW95LKvbKKGQCpzXIa2Rado3nORh
	 MgHOW2X/+XCULRXIESAttm9a7okEErWa/Fi+NH2OtGakUTL2gHMTDJaIVdQxYWHbMCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5vYiiZ4p8Gn6a49dOKEXl8uBY0pesCIv/K5dTUvfEFw=;
	b=imOyOwoS11381MSr1TL0/sClwt+GO6lPwDTXDE9IgtZpwfZG97LFYm0ckwhqfKyyq0n3
	 fC4cil8Tf01mxTpla8b6HyDHfuz0lt2nI02ntFCNGyxw0mN6T/kspmkPpcliJnbNeXJZ4
	 2p1h9BOoJP6CRj6UQXbRmUUfh3JCgO7qvoezyzmkftF2UjMSABMrox3TO5BOBLgH4u1ma
	 ubLicbpPPXUVGhGQnSg4rujpgC0mUMSPl0e/XvpakskLjfQwhvdrVmKbVaF9mbjL4Vhl1
	 g/aVlOpSxVEtoSeQRv4A2gSxKBDeTTJkwHcXKizvqtdwTYb6rmBnNs85WZTugGwcIHw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295723;
	bh=5vYiiZ4p8Gn6a49dOKEXl8uBY0pesCIv/K5dTUvfEFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jvqmfrUDR+VbibsOc/iogDloYE0DyoKv9OoajX5MzfsYGJv/qbZ6RQ/rqfu+bdw4o
	 5oALFM2mx69lrDn8+7Cl+ypuALYUED/FKWfzGVlpAIkFOZhHaMYvIoY89wO6CDc3va
	 QMzEPn0AUqVTSylnVlx8L4p75Fb9+Mylil5usmkwkCaD3NPBdLM3onxnheE6CLpBoD
	 28HzsNDG3nbJcntwuRaKo8Ay6PSftXeZax4eo4TIAgxDRSzaqD0UsmTesvs0O2zeFx
	 JrBRbUXB/he3HeHxsZ29906HjsZdFX12+2iCla489734vdb6w1huamNitDgnqM6PXk
	 bSSmQK5pvUwHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A43CE810BA;
	Thu, 29 Oct 2026 17:42:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D4242FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F44A60A70
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:34:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CzhmJnoSWN5O for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:34:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E15160710
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::235"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295296;
 b=jIJrxQmV4cCGpnc3Hm/5FTNs7IW2ny9GsKMTb4tVjIbjV3p6uY+KoUV9A4ebw70liy0s
 /mrLvsKWr8aleFrnjBfPjhrIfiGOfHHApLAngwAxhU4ceKvfzGQy5kNZE56qYv/TmQTtX
 l0585o6yhymsEdyiJaYwJuu1yz5S3xZtMXGks5Vu9Wnj79jgBEZ4E8aUJHJGbWA8aug+P
 V3cnqdeVgkeblyt8QmEr+lR+wJTm891ddAHHVNiHdOq/ciLhjIYmUH6FCy94akxIaGTAX
 Hzizb1My2EncyDfErPHidH74K9Xio9vzG3mgQlbn6n/tsPUYnTcQ3VFE7zTWPsAlp7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295296;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=5vYiiZ4p8Gn6a49dOKEXl8uBY0pesCIv/K5dTUvfEFw=;
 b=F+F/TEsXwyGvhC2CRJQlMBp9134mzxrWa2ufzhffnBrgNjeKCYOeiAqQQ41TLgR52qKd
 RvHNYitGFWZ9/upJFbJyq0/Afwvy47nTXoRpo1DVZpcOGMxvyrfLCfsAToSDe5561fpkY
 Pcrx9J3NyrgLrmPbR5V6Acbty/+RyzctvTbYJbZYyhsrLESJwE7NY/YJIji0634yqBWrK
 b83OdKEdQ9v1V5LVGVKHTK3TXA7fRomT65w51q64ajm/UtuY1A3vTQBkICPlsmWgIS14p
 dVm9ANx23uaXohNH7reOqA1BbfytXgOMrxQPcU7WmThqgTWmhrN6WcYRLJ1CGnV/SEg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="qDbY/Exl"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com;
 envelope-from=maxin.john@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=qDbY/Exl
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E15160710
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:34:55 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-3a595487d43so20366331fa.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793295293; x=1793900093;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5vYiiZ4p8Gn6a49dOKEXl8uBY0pesCIv/K5dTUvfEFw=;
 b=qDbY/ExlKX+xGs5GVX709XPbxnpaudMb8pI7jP/nZE+21gnRTJIdqt/UFOt3xYv+pp
 T2tMTYV12mUgpwwFq4qrZlUXZalzJWoO89c8AYmViVxelO9pxYkDwdcJHqyuKiQZxs+b
 fqokvUif9+TvqTfcRdy3NeL/qTOkt7OEPxVKRrCeSsXHbGUBg9OFrSua+8K6hJSd7p8y
 nWxjO6z4P52Y4Hu0/KlhceXoBME96n3CnjSxmeWx7lxuqLIURyifuoPt6xLlNxEhq+yM
 oFf7aXD4hH2i659jEeFd0zalFMoqIXPNxEocbU7hM43IB8pCTsLGtTzfamRaRYmuQjUu
 LuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295293; x=1793900093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5vYiiZ4p8Gn6a49dOKEXl8uBY0pesCIv/K5dTUvfEFw=;
 b=0c3Gdw1SSji7z1HmB+gqvw2nmRPIc/jbOC1XUYadOO33Oyv4R06otsRq8ScZ7yQh0B
 yvBH2C+5Ek5J12neBMqv8D/ChDd9BZx0xBsCxCYsw39WtHtuDM+7llYKQYyol5o5PMOh
 MaUjd472yG3IS/6JEzP05x8od/YCKrLwjfuBYw8CkDN5f2j+Dd3vtqEiy4T7o+oc98T/
 q/X0nDxAcAD0Jf0ZddV0Y+iV6WxFdyNGS5ooEDKxgmGLp0DAG5oI1aGH7SgZXNJfAJ3O
 S80KkuR/Co+uSVZS9ejKirdG9Z2yJz/OHk072JdWc5TVhv0qJf9NO9b31FgTv6z9GctA
 vZGA==
X-Gm-Message-State: AFq9FYK8sDN9YdRp0ov9JUTPLt1hkMx0ZlmdO+Jry8MhpOLrHFGgflaE
 1f7Z2MZK3VB9c60X9o6isBlZRShJK8DYyO7INwleY3r+pOR8b19Hvwpz3/Rne8PM
X-Gm-Gg: AYBFou2/Hv8pUE9tGexJrgu+CWtg5tE+f2dRYZ2UxsL+8rQa5O9RD4va4BtLqfELylR
 Vkv8DAT4xjNgzmFCwYzYgNbC7cHVx5axmwaKUG8b8kV6Fyv/v7dG/uY2tLXz00/RTwxRZO4v+23
 HHo4CB04I/EKfhelw1L5mM3LGKUCV5Q1rRtU6VWXlqD//7eKva6kPkNS1EGNZUBmmKzqclcO8U7
 yYKfVSb4wXRiJghC8IHkEpoZ02h4e1Sdg3iX+pGkLYQAxkv4fD2bEyqMa1VjByrLHBxeKWuDAxj
 lhEsSp3MZZxtPM2Phn4Qy2We18k3/UJeTJ7xnILAM+hlG9m4zbfyHDOc3WGrobDFZV8USbODB0w
 T/b1k1CG3E/fu7EeEiDkZOsvsetQfKZe/wtJkRa1qvbrhZn2Qa5sLoQIf9GjCpR8Hd5taLioEDL
 JEUDnD5FtXRe9t2jmPWToRUpQW29yUHjShlOxNH1SY0BB8DsTwVh+mWy89HvyvHNg8YzmneEP+V
 pIfBubbhJ3TGw9eoD6q4HxcBM1Z71to4BzSQ0hNmcFGzow1kawRCz25ZECs6kddNzwvB6p5c6k7
 Og9gvyMDlFMZOyWN4vGu4QOzpCMG4iGs4VDE4/s6GKyEEdR7OI9OeYnde5Bw7rTfAQhi5M1xaj4
 wx0m4bltQ/mO6QBv3cOJq0uw=
X-Received: by 2002:a2e:a986:0:b0:3a9:7711:1cd7 with SMTP id
 38308e7fff4ca-3ac9cfae41fmr15658721fa.23.1793295293217; 
 Thu, 29 Oct 2026 10:34:53 -0700 (PDT)
Received: from Thor.lan (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi.
 [2001:99a:a58:9b00:9119:221d:45f0:de83])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acb5d264ccsm32531fa.21.2026.10.29.10.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:34:52 -0700 (PDT)
From: "Maxin B. John" <maxin.john@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 2/2] test: cmd: add tests for the binop command
Date: Thu, 29 Oct 2026 19:34:39 +0200
Message-ID: <20261029173443.1495866-3-maxin.john@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029173443.1495866-1-maxin.john@gmail.com>
References: <20261029173443.1495866-1-maxin.john@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 17:41:58 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

binop has had no tests so far. Add some, so that bugs like the heap
overrun are caught in CI.

Each operation (xor, or, and) is run on hex strings, env vars or
memory, with the result going to an env var, memory or the console.

The tests also check that:
- short inputs are zero-padded
- console output wraps after 16 bytes
- bad counts, operators, addresses or hex strings are rejected
  without touching the destination

There is also a test for the heap overrun.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
 test/cmd/Makefile |   1 +
 test/cmd/binop.c  | 192 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+)
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
index 000000000000..4cea19607103
--- /dev/null
+++ b/test/cmd/binop.c
@@ -0,0 +1,192 @@
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
+	return 0;
+}
+
+CMD_TEST(cmd_test_binop_print, UTF_CONSOLE);
+
+static int cmd_test_binop_invalid(struct unit_test_state *uts)
+{
+	/* Failed operations must not change binop_out */
+	ut_assertok(env_set("binop_out", "deadbeef"));
+
+	/* Literal hex string: too long, odd length, not hex */
+	ut_asserteq(1, run_command("binop xor 2 010203 01 binop_out", 0));
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_asserteq(1, run_command("binop xor 2 010 01 binop_out", 0));
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_asserteq(1, run_command("binop xor 2 zz 01 binop_out", 0));
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	/* Env var value: not hex (but fits the count), too long, odd length */
+	ut_assertok(env_set("binop_bad", "zzzz"));
+	ut_asserteq(1, run_command("binop xor 2 binop_bad 01 binop_out", 0));
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_assertok(env_set("binop_big", "0102030405"));
+	ut_asserteq(1, run_command("binop xor 2 binop_big 01 binop_out", 0));
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_assertok(env_set("binop_odd", "010"));
+	ut_asserteq(1, run_command("binop xor 2 binop_odd 01 binop_out", 0));
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	/* Invalid count and operator */
+	ut_asserteq(1, run_command("binop xor 0 01 02 binop_out", 0));
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_asserteq(1, run_command("binop xor x 01 02 binop_out", 0));
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_asserteq(1, run_command("binop nope 2 0102 0304 binop_out", 0));
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	/* Invalid source and destination addresses */
+	ut_asserteq(1, run_command("binop xor 2 *nope 01 binop_out", 0));
+	ut_asserteq_str("deadbeef", env_get("binop_out"));
+
+	ut_asserteq(1, run_command("binop xor 2 0102 0304 *nope", 0));
+
+	env_set("binop_bad", NULL);
+	env_set("binop_big", NULL);
+	env_set("binop_odd", NULL);
+	env_set("binop_out", NULL);
+
+	return 0;
+}
+
+CMD_TEST(cmd_test_binop_invalid, 0);
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
+
+	env_set("binop_first", NULL);
+	env_set("binop_second", NULL);
+
+	return 0;
+}
+
+CMD_TEST(cmd_test_binop_overrun, 0);
-- 
2.47.3

