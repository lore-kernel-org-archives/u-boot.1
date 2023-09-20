Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773D0CD4935
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 22:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75BAC86C31;
	Thu, 21 Sep 2023 00:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Z3kPFR3K";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="l6PZtrHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B1F586C2A; Thu, 21 Sep 2023 00:58:38 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB62786BC8
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 00:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RrYqJ22Frz9sqL;
 Thu, 21 Sep 2023 00:58:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xK98x52dPUQfWZ/oRcSMongtKRyWSugIKmDMD5uP74Q=;
 b=Z3kPFR3KKr2e4Cvq9L2appaIYUW6Fr6vgshfGcFLQqBMei02fhgEVvmA4kIv53JyQz81dP
 XHIVbsu+Zj2hOoGARW5d+PcluZOAnLmYl8IcHbkx+uHntOqaJ8fQpANjUxWTbKEnkRw8CI
 MxjafDfpkgXhXAaLBLqQ9LgM7bVujxAe5cwZhIbI9XETVaFq8OmVeO69LX6/Hibaqc+YQV
 LN4FWek/vcBMohoVk8/OoZpNqvPU6C3uV8vPpJax2T4P4jJHh3pqXljx6x5UZfLwfwExGG
 xft4MPz6pB9kLOQPZgbOYektCvCzjZshVWi0gwiaQ5zRcXOS8a+0Zash0VMjaQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xK98x52dPUQfWZ/oRcSMongtKRyWSugIKmDMD5uP74Q=;
 b=l6PZtrHpy1iJUi6jxwle+kwqPyAml7cjjWCqLKA+RSpJXeBvNvDSacomBFSBIgUduXd+Mm
 lBOoJI2RqLxRqAcvdUYM1AaPiS837LqsvE5k0rGBYOT0xeLbtgBbvCDZ49du0X7C1+nRwM
 4HM7yVh98Bb1RHrmxRALBJh5vZ8tSnvsy4Gb5yWLQRCn95KA3DvE6zJc8/AEDpGteg5EaN
 qbFRN7UOyQEoQZX2pLqiwb+fm/PDItBhPxWV49t+phbKYfL+VYJReOjRxhiQvrGc8u9bSA
 6WSeGgvi0RxqbJPw9QhCTUNLbs/Wzpyo5V004iQ5dNJLA16RO6Bxa+dzMyP+dg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Nikhil M Jain <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/9] cmd: bdinfo: Optionally use getopt and implement bdinfo -a
Date: Thu, 21 Sep 2023 00:58:03 +0200
Message-Id: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j8r1h9aahjm66smj1q1r4uetxmrfdk88
X-MBO-RS-ID: e28be4b033b0dde3c16
X-Rspamd-Queue-Id: 4RrYqJ22Frz9sqL
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

Add optional support for getopt() and in case this is enabled via
GETOPT configuration option, implement support for 'bdinfo -a'.
The 'bdinfo -a' behaves exactly like bdinfo and prints 'all' the
bdinfo information. This is implemented in preparation for other
more fine-grained options.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
 cmd/bdinfo.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 1fe13ca13a0..2c0d5e9c01b 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -10,6 +10,7 @@
 #include <command.h>
 #include <dm.h>
 #include <env.h>
+#include <getopt.h>
 #include <lmb.h>
 #include <mapmem.h>
 #include <net.h>
@@ -133,10 +134,8 @@ static void print_serial(struct udevice *dev)
 	bdinfo_print_num_l(" clock", info.clock);
 }
 
-int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+static int bdinfo_print_all(struct bd_info *bd)
 {
-	struct bd_info *bd = gd->bd;
-
 #ifdef DEBUG
 	bdinfo_print_num_l("bd address", (ulong)bd);
 #endif
@@ -184,8 +183,30 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return 0;
 }
 
+int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct bd_info *bd = gd->bd;
+	struct getopt_state gs;
+	int opt;
+
+	if (!CONFIG_IS_ENABLED(GETOPT) || argc == 1)
+		return bdinfo_print_all(bd);
+
+	getopt_init_state(&gs);
+	while ((opt = getopt(&gs, argc, argv, "a")) > 0) {
+		switch (opt) {
+		case 'a':
+			return bdinfo_print_all(bd);
+		default:
+			return CMD_RET_USAGE;
+		}
+	}
+
+	return CMD_RET_USAGE;
+}
+
 U_BOOT_CMD(
-	bdinfo,	1,	1,	do_bdinfo,
+	bdinfo,	2,	1,	do_bdinfo,
 	"print Board Info structure",
 	""
 );
-- 
2.40.1

