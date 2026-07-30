Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21479C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 16:06:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D002440AD5;
	Thu, 30 Jul 2026 16:06:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A7RNbqvTnQ0E; Thu, 30 Jul 2026 16:06:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BF6440AD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785427579;
	bh=adf5F1I2HpdARPc5WECP/uh/sb4mowY+OAyt9XHQKJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lc80oYf+N6XuRFy/aGEuN4jFavCRplPteCLT1CnN1qMibNQLjCm1w1H4KrZZKQSAy
	 U0B18KO29BV74RTpgmQqUaeXbmW4WjBPFh1Un2F+iz16LNNQ5TwwHMO5Nxo+lZuQH3
	 Ybzuuki/VYpl8abgISWXVh1FUZLKhgxpcK6k4rJG4WpKqxPg7Wx3cAZLlNtSURxqvS
	 l3RgqTAU4F7PY4xXIt3TM2AA9nVn9dyvUkTXeijeXM6Ct9MNqNX4JCnejKzgsjIDjC
	 jtggCMzS8FbzeI0PyaxLd5afbxkeOHBJQqu0ZXwS4i66jSZ7lxBkzmrlrDzSaHj9bn
	 L+amNZuBZe9aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BF6440AD6;
	Thu, 30 Jul 2026 16:06:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31F1B26C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 237A0409CE
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:51:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NlszGvgsADbA for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 15:51:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 077CF409C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 077CF409C9
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 077CF409C9
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:51:24 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so597335f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785426683; x=1786031483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=adf5F1I2HpdARPc5WECP/uh/sb4mowY+OAyt9XHQKJA=;
 b=JTa7X3sKwOyK7CH8SyADqSEinmRrXmK83hbtpZPXj4rbXmrU7MNBWo73DGkpOlLZtE
 ZtZqpM9E4OHObMiqJjM5w+miu+DdN8IsWIl/Jtblyazq03TKtztgpklTpvS4fHUogvau
 SsW9XedkTGHjmmy9qsGb1utW6oY7Jso8nhDnG0sjuNVtqsTpabFaXLgIQC29OAskZd67
 dAMMfpAB4w7mzxDKBq01JYibXnb/QwXI5Aci2SDU/Bj0IiehRA+ZEGFHhDqJQ12pordH
 582BJeZ5S2IbmVxqHcodl3Dm9cURPvEX9il7oAz/3EFhwm2Nv7YQt4JS4Rx9ydncYF5E
 Ws+Q==
X-Gm-Message-State: AOJu0YyJHLMydsON+IzfgAUGjDKA7mYcL4PzWuiXhEsGeB9+ov50OQ9g
 PrVSxXrlEdHwmqAAegDGhSy6KO2Wmqy5ZUYoYmlgLXySIzcodQ/huVLS/tsAnA==
X-Gm-Gg: AR+sD13hl3JQyYNrWgEYHSk+cwVgn7WzcPxTwf6DGo8l7jy11+h4VLpiZdWkuojXee0
 fnr8eCzS2nDnmBblg5kvHZfM9KRVOSy0n2uA+CSXZP2nNMtXpIQX0QwcV4CgBrBJ3s2DmRH8wtq
 T2TOwc2Ts/1p/vRD6WZ0Npm93hb6kSdw5CUoZZtJUQoiP+p0af8xF3RcFoQ8SstxmocPusu2vRg
 oKjM7puhJ4m3dqJkAVqX3jDUMGAeMhDyMHaf2pW1B9Dym6pV8OPooCzZtAUhv2fUokBpxmsGZEN
 /Rk4IDA8Jmk59mlGkOdqYvH4zr/06SPEjRITd84fYPdV2nL6gF63sust89UsyA/5PPQ7WBx57aM
 c/VX+BdwudrXEfCTieGkTpHeqgIjg6bKix9kypiNGAmqMaDbQXixKTFpJEgf6Rk1cIOsq04CzfD
 5p7l7ALCQM1pUCD6zhVhjwuAsih499YAFYfDDdwEZygrXb//7+aM3upBuk1iTuO2/XlMA=
X-Received: by 2002:a05:600c:5744:b0:497:ff5a:38b9 with SMTP id
 5b1f17b1804b1-49804cfbe75mr8682135e9.9.1785426682675; 
 Thu, 30 Jul 2026 08:51:22 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496e8e06f7csm146871545e9.0.2026.07.30.08.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 08:51:21 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 1/2] cmd: allow bootd without bootm
Date: Thu, 30 Jul 2026 17:51:18 +0200
Message-ID: <20260730155119.3328020-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730155119.3328020-1-mehmet.fide@gmail.com>
References: <20260730155119.3328020-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Jul 2026 16:06:15 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785426683; x=1786031483;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=adf5F1I2HpdARPc5WECP/uh/sb4mowY+OAyt9XHQKJA=;
 b=fXEyL8Xy008t6UI/MO1PTJ5/fNMVlehTvaYHpnkLCL0irlRbKhJbzL4VSvC9+K4qc0
 qon3ue2IGJkifJiRLhoirbTgUi+pdFGvnDWdZTGkDRHbg7dfIPgWTh4B3MbjRWySku5m
 3Jl6omlEz7m0AZg8Xmis5vIntcinylSuGEC29ePhAYDNm6SASIcHOSL4AtnVuOeKcT6k
 Ec9QxpG9QWJflKfjXkBIqYBzs5G7D1nsB1QFSiCWl7RBzV5TaXSW7QyxMFldvLUUWgh3
 G6G2oWB8sWQtgQkgLcxxqic5B+Lgbv6QEpnOw7Bv/tUXgzDl6+kEO11lOu0Zi6V2PTiE
 BRAw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fXEyL8Xy
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

do_bootd() runs the "bootcmd" environment variable through run_command()
and does nothing else. It uses no bootm functionality, and neither does
the "bootd" recursion guard in cmd_process(). doc/usage/cmd/bootd.rst
documents it that way, with an example that sets bootcmd to
"echo Hello World".

Commit 1fd04cf46baf ("cmd: Correct dependencies for CMD_BOOTD") made
CMD_BOOTD depend on CMD_BOOTM because the build fails otherwise:
common/command.c is compiled unconditionally and references do_bootd(),
whose definition sits in cmd/bootm.c, which is only compiled when
CMD_BOOTM=y. The dependency therefore describes where the code lives
rather than what it needs, and the boards that disable CMD_BOOTM
(colibri_vf, iot_devkit, mx6memcal and r8a78000_ironhide_cm33) cannot
offer "boot" or "bootd" at all, although the implementation would work
there.

Move do_bootd() and its two command registrations into cmd/bootd.c,
compiled from CMD_BOOTD, and drop the artificial dependency. To leave
every board in tree unchanged, CMD_BOOTD now defaults to y only when
CMD_BOOTM is enabled, which is precisely the set of boards that have it
today. Boards without bootm can enable it deliberately.

Tested on sandbox: bootd, the "boot" alias, the return value taken from
a failing bootcmd and the recursion guard all behave as before. Also
tested on a Colibri VF50 (vf610) board built with CMD_BOOTM=n and
CMD_BOOTD=y, a combination that could not be selected before: "boot" and
"bootd" run bootcmd and bring up the OS, and a bootcmd of "false"
returns 1. A colibri_vf_defconfig build with CMD_BOOTD left off is byte
identical to the previous one apart from the version string; enabling
CMD_BOOTD costs 272 bytes.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    checkpatch reports two things on this patch that I left as they are:
    - "does MAINTAINERS need updating?": no MAINTAINERS entry covers cmd/bootm.c,
      so the new cmd/bootd.c does not need one either.
    - "Lines should not end with a '('": that is the U_BOOT_CMD idiom, and both
      registrations are moved verbatim.

 cmd/Kconfig  |  3 +--
 cmd/Makefile |  1 +
 cmd/bootd.c  | 30 ++++++++++++++++++++++++++++++
 cmd/bootm.c  | 24 ------------------------
 4 files changed, 32 insertions(+), 26 deletions(-)
 create mode 100644 cmd/bootd.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 35ce42f8397..f8eed5a5bdf 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -300,8 +300,7 @@ menu "Boot commands"
 
 config CMD_BOOTD
 	bool "bootd"
-	depends on CMD_BOOTM
-	default y
+	default y if CMD_BOOTM
 	help
 	  Run the command stored in the environment "bootcmd", i.e.
 	  "bootd" does the same thing as "run bootcmd".
diff --git a/cmd/Makefile b/cmd/Makefile
index ce772e5555b..7c3db81e524 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -6,6 +6,7 @@
 ifndef CONFIG_XPL_BUILD
 # core command
 obj-y += boot.o
+obj-$(CONFIG_CMD_BOOTD) += bootd.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_HELP) += help.o
 obj-y += panic.o
diff --git a/cmd/bootd.c b/cmd/bootd.c
new file mode 100644
index 00000000000..d39b1bfe888
--- /dev/null
+++ b/cmd/bootd.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2000-2009
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ */
+
+/*
+ * bootd - boot default, i.e. run the command in the "bootcmd" environment
+ * variable
+ */
+#include <command.h>
+#include <env.h>
+
+int do_bootd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	return run_command(env_get("bootcmd"), flag);
+}
+
+U_BOOT_CMD(
+	boot,	1,	1,	do_bootd,
+	"boot default, i.e., run 'bootcmd'",
+	""
+);
+
+/* keep old command name "bootd" for backward compatibility */
+U_BOOT_CMD(
+	bootd, 1,	1,	do_bootd,
+	"boot default, i.e., run 'bootcmd'",
+	""
+);
diff --git a/cmd/bootm.c b/cmd/bootm.c
index ca7cec91fad..07fd995ebed 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -229,30 +229,6 @@ U_BOOT_CMD(
 	"boot application image from memory", bootm_help_text
 );
 
-/*******************************************************************/
-/* bootd - boot default image */
-/*******************************************************************/
-#if defined(CONFIG_CMD_BOOTD)
-int do_bootd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	return run_command(env_get("bootcmd"), flag);
-}
-
-U_BOOT_CMD(
-	boot,	1,	1,	do_bootd,
-	"boot default, i.e., run 'bootcmd'",
-	""
-);
-
-/* keep old command name "bootd" for backward compatibility */
-U_BOOT_CMD(
-	bootd, 1,	1,	do_bootd,
-	"boot default, i.e., run 'bootcmd'",
-	""
-);
-
-#endif
-
 /*******************************************************************/
 /* iminfo - print header info for a requested image */
 /*******************************************************************/
-- 
2.54.0

