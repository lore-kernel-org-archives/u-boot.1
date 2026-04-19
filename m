Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8346EA719C
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 14:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA79842BF;
	Sun, 19 Apr 2026 16:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GilJITye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE0C842CD; Sun, 19 Apr 2026 16:33:06 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87FF883B99
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 16:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so54975e9.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776609184; x=1777213984;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3edTpCbQLoF2GLZoQuCSJDpFP7hzTahHYvj6ql2yGM=;
 b=GilJITyeno+gTalnQSXFH5LMgL/+K8tBP3yNCpAsnT5LbxH+yF92r12loK/XD1Gt39
 ISXYa38lBjyVUQX9v67l9Oe48+VpUCg37XWx19rEjftpkNcuS2CUiHJr3Bjw2aZKsPn9
 2BZKqsBtfIpDOXk3MorCqvPOzIvLXElnUTdpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776609184; x=1777213984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V3edTpCbQLoF2GLZoQuCSJDpFP7hzTahHYvj6ql2yGM=;
 b=TIdLtn5SkevysNJYt3AAJEGRw7axQ0i80qgQuRhEUZEKIdulHew7aS6vVhm8coK88+
 d6TxwAhkpw/JJ/7+F13zjlKhlf3bMJug1Gq+W3W9vndBumBTzBQ5HUdmoPFt7vkzaDzv
 aO18aIzfskw/i+mBwyZbBVLg7q5JhjTJ1zPyFz1J717U2M0Axq5Vvvw6e2E5Pl7fGyRB
 GYM25qs9rKJxaxkZbSIM4R76YNz5KYTxjlit25AMH5nmN2ZxnGc2SukIcs7MBIp2jhWA
 +L8FZ45wk5cFT6vFCwMGeY6/W4bpd293JxNl3vzuliddMZA9nt+rNmqHLJM4xVZ67ezB
 e7lA==
X-Gm-Message-State: AOJu0Yy+FQqXcyR4PhaTt0FmjIeYrJeSMEgDmcgAqQLkgI1zII6J3+p7
 3Av3TuLJXwyV+oQE7tP3N1vudF56dCspu50nZtgFgBrSiNqR7yY+XDntCA4ywQ80LQpvS2vjklq
 BHEn6
X-Gm-Gg: AeBDieu1nYhz+umu25gVLAnQ6P1VqlDcB7NiWwJyOi5z6w8ES0k7FueM68kLUnXhTy1
 pkDT9UwVkZ9+haeHeZADGA0HwLgT+HRXaBeG9uJLNciWLzNvL8CXlX4U8QjkMnZPZqGZj0IVzFv
 aWpkaV4lgwj2BsmZYirHPmYyAjsOSq7XCMxJJncfgC7wujWwTsa9bGg52OQS16+4JslTYsB1AJo
 KDzI0D3TwLgK8nwpzqQtoFozchPOSKoekTbgsvIwA0aOuipeLvkntMvY1W5rpXq4trNxuWSIz77
 IogTGJChnKXCDEIkyUC6IDVx6HhmGOFPzaFL3m3pRQGl1RExSYfGKYestL00W7Nj4rMOB4n2dC4
 SGa/yoa0OKDTf3VrLbrHPoRyXD7meDfIEL/aIAZxfuAXNSvvhCmsuEx5Cy4NVFGlxHLPi2suYI6
 k0YLanRy0/URUR9JLCyHew93f37BeemPemWs/6KhuOLPcJlrzCH7795sfCudMHxZKwt+07OAj5b
 NzPmqU9LcYG0ThOI/iF3WWSIcjOvdMMgd0W1OeS793X7C1jkHKhtV4c/YJIfE81YTC5k1Gou37H
 56dj/fk5IuRAH5I/P/gCuksYxhfCMdP6WRD3NpRA6gA=
X-Received: by 2002:a05:600c:899:b0:489:1a63:509c with SMTP id
 5b1f17b1804b1-4891a635125mr11945795e9.0.1776609183696; 
 Sun, 19 Apr 2026 07:33:03 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-20-97-39.retail.telecomitalia.it. [79.20.97.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb755938sm86864245e9.3.2026.04.19.07.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 07:33:03 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 5/8] test: cmd: part: add UUID lookup tests
Date: Sun, 19 Apr 2026 16:31:45 +0200
Message-ID: <20260419143247.437733-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419143247.437733-1-dario.binacchi@amarulasolutions.com>
References: <20260419143247.437733-1-dario.binacchi@amarulasolutions.com>
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

Extend the 'part' command unit tests to include partition lookup via
UUID.

This ensures that the 'number', 'start', and 'size' subcommands
consistently handle UUIDs as partition identifiers, maintaining
parity with the name-based lookup functionality.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v3)

Changes in v3:
- Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
- Add Reviewed-by tag of Simon Glass

 test/cmd/part.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/test/cmd/part.c b/test/cmd/part.c
index 5751dd315dd8..0069fe5bfea7 100644
--- a/test/cmd/part.c
+++ b/test/cmd/part.c
@@ -80,6 +80,20 @@ static int cmd_test_part_number(struct unit_test_state *uts)
 				    mmc_dev_num));
 	ut_assertnull(env_get("partnum"));
 
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partnum", NULL);
+		ut_assertok(run_commandf("part number mmc %u %s partnum",
+					 mmc_dev_num, gpt_parts[i].uuid));
+		snprintf(expected, sizeof(expected), "0x%x", i + 1);
+		ut_asserteq_str(expected, env_get("partnum"));
+	}
+
+	env_set("partnum", NULL);
+	ut_asserteq(1, run_commandf("part number mmc %u %s partnum",
+				    mmc_dev_num,
+				    "00000000-0000-0000-0000-000000000000"));
+	ut_assertnull(env_get("partnum"));
+
 	return 0;
 }
 CMD_TEST(cmd_test_part_number, UTF_CONSOLE);
@@ -120,6 +134,21 @@ static int cmd_test_part_start(struct unit_test_state *uts)
 				    mmc_dev_num));
 	ut_assertnull(env_get("partstart"));
 
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partstart", NULL);
+		ut_assertok(run_commandf("part start mmc %u %s partstart",
+					 mmc_dev_num, gpt_parts[i].uuid));
+		snprintf(expected, sizeof(expected), "%lx",
+			 (unsigned long)gpt_parts[i].start);
+		ut_asserteq_str(expected, env_get("partstart"));
+	}
+
+	env_set("partstart", NULL);
+	ut_asserteq(1, run_commandf("part start mmc %u %s partstart",
+				    mmc_dev_num,
+				    "00000000-0000-0000-0000-000000000000"));
+	ut_assertnull(env_get("partstart"));
+
 	return 0;
 }
 CMD_TEST(cmd_test_part_start, UTF_CONSOLE);
@@ -160,6 +189,21 @@ static int cmd_test_part_size(struct unit_test_state *uts)
 				    mmc_dev_num));
 	ut_assertnull(env_get("partsize"));
 
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partsize", NULL);
+		ut_assertok(run_commandf("part size mmc %u %s partsize",
+					 mmc_dev_num, gpt_parts[i].uuid));
+		snprintf(expected, sizeof(expected), "%lx",
+			 (unsigned long)gpt_parts[i].size);
+		ut_asserteq_str(expected, env_get("partsize"));
+	}
+
+	env_set("partsize", NULL);
+	ut_asserteq(1, run_commandf("part size mmc %u %s partsize",
+				    mmc_dev_num,
+				    "00000000-0000-0000-0000-000000000000"));
+	ut_assertnull(env_get("partsize"));
+
 	return 0;
 }
 CMD_TEST(cmd_test_part_size, UTF_CONSOLE);
-- 
2.43.0

