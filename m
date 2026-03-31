Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A41A109B464
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 13:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AD1384020;
	Tue, 31 Mar 2026 15:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="HqGXkK6A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IYz8MbqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191DB83DBF; Tue, 31 Mar 2026 13:04:59 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AC0483A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 13:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregor.herburger@linutronix.de
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1774955096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aaeGZgSHihZSGH4wKrAaj0NnBm7C9YK+n6VWCqgMJZs=;
 b=HqGXkK6A41JMGjCTbjxJfciXLtrR0xpNqBsSVp6hSO5lwc8lm688gf2DzrSxGNp3hRUYhU
 Z1T7fsRy4p7r7M4WVp2qN5u6re7BS+BLIqC7FC74e0fqboK0Ul/6bm/JOD9wsEmD7XhpFy
 4RSPSb/Sw1ZcjTvdbwHXd1lM59isR2pLCiaSfOD5p9Lf+5A1034oykJamAq21EutOToKvQ
 CQxR09Z5DdMYL2lfrEooY1DF6/KzGYJd5cGqwCU7Ou/s2UEYk20dwKsXzk5mK70JICg95y
 WZnONXV5Hv+Ka/+gmc4AiAcVsEPc83xeHHqpL4v84qo7srNo9akR/K2M8RESjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1774955096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aaeGZgSHihZSGH4wKrAaj0NnBm7C9YK+n6VWCqgMJZs=;
 b=IYz8MbqEHBYpTIWxQxdE7YeFTfSGywWc/hzDTC0qvw5CJA1F8KMg2HcVg8VbvadUcp+TM3
 BAptWL7wG0zoO3BA==
To: u-boot@lists.denx.de
Cc: Gregor Herburger <gregor.herburger@linutronix.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cli: flush stdin before enabling cli
Date: Tue, 31 Mar 2026 13:03:08 +0200
Message-ID: <20260331110413.1040527-1-gregor.herburger@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 31 Mar 2026 15:08:26 +0200
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

Currently there is no possibility to flush stdin after autocommands are
executed. If in the bootcmd the stdin is changed, e.g. from nulldev to
serial, it could happen that junk characters sit in the fifo and appear
on the cli.

Add a option to clear stdin before starting the CLI.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>

---

 cmd/Kconfig  | 7 +++++++
 common/cli.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 322ebe600c5..e08fbf27358 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -47,6 +47,13 @@ config HUSH_SELECTABLE
 	default y if HUSH_OLD_PARSER && HUSH_MODERN_PARSER
 endmenu
 
+config CMDLINE_FLUSH_STDIN
+	bool "Enable flushing input before starting cli"
+	default n
+	help
+	  When this option is enabled the stdin buffer will be flushed before
+	  starting the CLI.
+
 config CMDLINE_EDITING
 	bool "Enable command line editing"
 	default y
diff --git a/common/cli.c b/common/cli.c
index 4694a35cd0e..42d27ed87e7 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -295,6 +295,12 @@ err:
 void cli_loop(void)
 {
 	bootstage_mark(BOOTSTAGE_ID_ENTER_CLI_LOOP);
+
+	if (IS_ENABLED(CONFIG_CMDLINE_FLUSH_STDIN)) {
+		while (tstc())
+			(void)getchar();
+	}
+
 #if CONFIG_IS_ENABLED(HUSH_PARSER)
 	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER)
 		parse_and_run_file();
-- 
2.47.3

base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7
branch: cmd-flush-stdin
