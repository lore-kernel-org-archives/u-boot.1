Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2007AFB5179
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 06:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7FD483F98;
	Tue,  7 Apr 2026 08:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="jPYgfFW6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fkau1GMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A1184035; Tue,  7 Apr 2026 08:35:19 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1AE8352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 08:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregor.herburger@linutronix.de
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1775543716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmyDOHuu7eIJG79o+pRxJwW+mxjm9EK8C67aYkaihTM=;
 b=jPYgfFW6Ov0uDhGMtFHp7QhmmWlqLZHPrdw7EO261R4f1PTjaf75U9FdZ61C6QeUs9tgE5
 y0hXMHnanqE28eJ2jZye1e9xWhWuUaD/hG0QQySycjstcfvKXFnJddplVzOCMqyvFats3r
 RDiINgqVXOo2ZszAnqatlaljac8dEyWQxd5pWZJIJOiZmCpaCWHw+v+kXwrZevm+AduT/g
 pJsfDGSPwemhiqkZK0LKDLYuR5yEm7ZLtcI2Gr1rlwMeFaPpzZJ57TbwH1xu7QkR6p2gvb
 O6l3GDleT8VBmQehrS0GrYwbSlkSM411eGqoqdesVtNbW+R5cDvJwUQcPzdcZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1775543716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmyDOHuu7eIJG79o+pRxJwW+mxjm9EK8C67aYkaihTM=;
 b=fkau1GMYzGfYX4BB2gqRFttmZhTRrRZSch+GQ1S2+01TX/ZGRhcpkoSOxOnqawrzv2c1GZ
 wi9VR+c1btFWQQAA==
To: u-boot@lists.denx.de,
	Quentin Schulz <quentin.schulz@cherry.de>
Cc: Gregor Herburger <gregor.herburger@linutronix.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/2] cli: flush stdin before enabling cli
Date: Tue,  7 Apr 2026 08:33:11 +0200
Message-ID: <20260407063453.18679-2-gregor.herburger@linutronix.de>
In-Reply-To: <20260407063453.18679-1-gregor.herburger@linutronix.de>
References: <20260407063453.18679-1-gregor.herburger@linutronix.de>
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

---

Changes in v3:
- Update helptext

Changes in v2:
- add a common console_flush_stdin to console.c
- replace all caller of while(getchar()) with function call

 cmd/Kconfig  | 8 ++++++++
 common/cli.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 322ebe600c5..214b050e511 100644
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

base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7
branch: cmd-flush-stdin
