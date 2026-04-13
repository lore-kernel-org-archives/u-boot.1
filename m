Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45210F34C5E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 15:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C02C4841BE;
	Mon, 13 Apr 2026 17:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="VImv68iF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9VpB7Gnd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9470484198; Mon, 13 Apr 2026 17:25:57 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F9E841CD
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 17:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregor.herburger@linutronix.de
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1776093954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3XnIE6ZKWle+h529DSwEdbUCC7FPfDs4YbGL/zetfQ=;
 b=VImv68iFcQsjO0Y4kPdIM2Dpsi0DOohQ9+zfmQQ8L15hr0T06Adll5n/kjvcb49ZO6Vw3i
 2Tw+jrs9xIU+5Tskcw5xmcmB16n6Pl1HtN8nwm96KuWW2iS9SWXodxMYl20GBpJN6qKDLg
 gdkj5UooiQdL86zx43gViRrfT2Ztj/edPpazo2GVP8y8lQPEKrYHX3vR+R8QpWNx045iJa
 EmOnFqpwSWL37yir1JlfXAOJpJp4fMzmb9ZDnEGbGtx1zmDykFaoEPPkW43AkUNDoT8r1n
 zmNSYn8ZWwja+ddr+Swr4txnaUKWNLKLmQAE5i9r5VNiK302BkpmLLgAklpL2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1776093954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3XnIE6ZKWle+h529DSwEdbUCC7FPfDs4YbGL/zetfQ=;
 b=9VpB7GndZbyKyhTfWCZcmy2ClK6D8HEmEXbyiRME77py3F7cspMj5PyFBVqm9O+ei34Pvd
 PQ/Yq3TmrlIdc8CQ==
To: u-boot@lists.denx.de,
	Quentin Schulz <quentin.schulz@cherry.de>
Cc: Gregor Herburger <gregor.herburger@linutronix.de>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/2] cli: flush stdin before enabling cli
Date: Mon, 13 Apr 2026 17:24:54 +0200
Message-ID: <20260413152526.153605-2-gregor.herburger@linutronix.de>
In-Reply-To: <20260413152526.153605-1-gregor.herburger@linutronix.de>
References: <20260413152526.153605-1-gregor.herburger@linutronix.de>
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

Currently there is no possibility to flush stdin after autocommands are
executed. If in the bootcmd the stdin is changed, e.g. from nulldev to
serial, it could happen that junk characters sit in the fifo and appear
on the cli.

Add a option to clear stdin before starting the CLI.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

Changes in v4:
- Collect tags

Changes in v3:
- Update helptext

Changes in v2:
- add a common console_flush_stdin to console.c
- replace all caller of while(getchar()) with function call

 cmd/Kconfig  | 8 ++++++++
 common/cli.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 7bbeaad04ff..33a7952c9b8 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -47,6 +47,14 @@ config HUSH_SELECTABLE
 	default y if HUSH_OLD_PARSER && HUSH_MODERN_PARSER
 endmenu
 
+config CMDLINE_FLUSH_STDIN
+	bool "Enable flushing input before starting cli"
+	help
+	  When this option is enabled the stdin buffer will be flushed before
+	  starting the CLI. This is useful when stdin is changed during boot
+	  (e.g. from nulldev to serial) and junk characters may be pending
+	  in the buffer.
+
 config CMDLINE_EDITING
 	bool "Enable command line editing"
 	default y
diff --git a/common/cli.c b/common/cli.c
index 4694a35cd0e..bcc7264d51a 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -295,6 +295,10 @@ err:
 void cli_loop(void)
 {
 	bootstage_mark(BOOTSTAGE_ID_ENTER_CLI_LOOP);
+
+	if (IS_ENABLED(CONFIG_CMDLINE_FLUSH_STDIN))
+		console_flush_stdin();
+
 #if CONFIG_IS_ENABLED(HUSH_PARSER)
 	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER)
 		parse_and_run_file();
-- 
2.47.3

base-commit: e2fa3e570f83ab0f9ce667ddaec9dc738bcf05b9
branch: cmd-flush-stdin4
