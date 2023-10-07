Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C72E95A6B
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD0B286E03;
	Sat,  7 Oct 2023 23:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="C4t1TNU6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Wo/2Heuu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D8D186D3C; Sat,  7 Oct 2023 23:41:27 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E218657B
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S2zJG2y2Sz9sks;
 Sat,  7 Oct 2023 23:41:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Nr+JVIkANeBIGJtyT/cUpyvF2kN51vGH8b9R5pGuufY=;
 b=C4t1TNU6sKLyeFQ3OYbZ+hdj6orIbRElct0zld8Lh0+3RWw0ZoegzYNLglVYyh9wMbZ4UM
 o2JDqJu/NrdW8D+Sdqrky3NAZCY6wWv2ncNbZdTS2Kinq7fNK2nA6srQZuMvJ08O9gjnu3
 nBRbRNqipwSy3XzB7F8pofrs4QzqeSKItsGgBRVmME8UABVsIlzvdaCLR24KICq/N2mz9H
 Vvqfn/0M0yL7784C0DC7dMs3CTsLjc6EffR1BTgqBfw82xSrBatkoMGv8WxAIP44Wjwqgg
 HHYo6BZTCRDh2fvIi8I0qMgxmtm8Stsdtke7LkQuQU/4eMqVDVXs0iO3mY0SLw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Nr+JVIkANeBIGJtyT/cUpyvF2kN51vGH8b9R5pGuufY=;
 b=Wo/2HeuuOLAKVk6XOMHG7d24maGnzLVG4JeahApFgFKGwR0yv/8orSXG4ppWzXlCSaASuz
 YrmBtahaLZe4qPYzwegzy7v3VuZjdzHPbUyJ9kptQB/Vgh0htLxiLG12s8J4qyfdFei0Ha
 B8pHhHXuuVsWiVQCJy0VtyL9MwAeItZucDW4DcecjHCdHjUphzNhgxWk2L6mNW/3GOYw8M
 iQNVqHrQOygc43QIAMMX7oqu0++yZZOWV+M9q1PZFRfOK8BTH7GymaIK+jT8pQ6kcU2dK7
 DNAifgnrefIrq1KcobJpVXrM4lE6XSJJEp8foBIa6c3Z4Dvd/y1Kq9FRSM/NnQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v2 1/9] cmd: bdinfo: Optionally use getopt and implement
 bdinfo -a
Date: Sat,  7 Oct 2023 23:40:58 +0200
Message-Id: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: frm8kssgpep33zi69ga66ut9ejtj6kw1
X-MBO-RS-ID: 4616e257be35f690f18
X-Rspamd-Queue-Id: 4S2zJG2y2Sz9sks
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: Add RB from Simon
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

