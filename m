Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7581C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 20:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3883F8785F;
	Sat,  2 Dec 2023 21:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZKFga87P";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nA2foI+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8556876FC; Sat,  2 Dec 2023 21:53:18 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 142D4876A2
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 21:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SjMZz42yNz9sZ7;
 Sat,  2 Dec 2023 21:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701550395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zNTYXWGH8yP6gOTH3bFXjq2BARIh/cQScsL8NaZVIF0=;
 b=ZKFga87PSr+onQ65Ctbkg3Jyqin3JvFkN9E5xBWSdGZSZVvyJAPoG3F3y6V/T+CqqXL3KA
 J2aHfK1J6xqHnoLKIpyx0A+TnMjxKjmS1QuJaH02FTguiA0zy6chRzBvB0Q6ayg69TnKsz
 P1bQu5iF2AIDBVaKEueCeWojddEt4o966vv8G/vhrmVyQfpQ3W14D29avrO3Jbvx3k9p8O
 a6ZTPScmu40Qy2ua871ApTXTw/TbOL5dlGToEaQ3PskFsB2DzkVF0iSxtrZlR3mDWsKh7E
 ZdD+WsTzHbClngBrd0epjMILoJCh2cqfMSmli89LN3fa0IrHGDS9RHLVwErLTQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701550393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zNTYXWGH8yP6gOTH3bFXjq2BARIh/cQScsL8NaZVIF0=;
 b=nA2foI+P57Lm8SYHuah2szFN9D4npjbA9fBfaME09uLrK2CMWjXXEvFkTyAHSEksEn0fjy
 5AMTR1aSdtQBSU3WWZleKs6D/H74IwHVAK+yI7uKHyQ7v7Z1+7D0vzMEFH+TZb89m2LHgN
 sj39/wCK98z3TmqT6MAZ+O/rQhBLs/c/tfWb+3DABwv3ceUeUmM0LgjNNduTfuErk8ARKP
 rogdIRoNsu4M6NAztNFr4bBF8C4+j6PU3b0zXBznmrxGoQcnWFrG88d7d7XN87PiEMiDtm
 URuyD0bnABq9+5BfP8J2B8j0Tn6/yoE7BK+BXrEtay5yI2vAOlj1cJUyaxGxZQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/2] command: Allocate history buffer using calloc()
Date: Sat,  2 Dec 2023 21:52:30 +0100
Message-ID: <20231202205255.169670-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 40c6c4c209e0ae50861
X-MBO-RS-META: qp7p4897gco9cm3ibt31k7xbo96zs74e
X-Rspamd-Queue-Id: 4SjMZz42yNz9sZ7
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

The history buffer is currently a static array which can be some
10-40 kiB depending on configuration, and so adds considerably to
the U-Boot binary size. Allocate it dynamically instead to reduce
the U-Boot binary size.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
---
 common/cli_readline.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 06b8d465044..85453beed76 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -12,6 +12,8 @@
 #include <bootretry.h>
 #include <cli.h>
 #include <command.h>
+#include <hang.h>
+#include <malloc.h>
 #include <time.h>
 #include <watchdog.h>
 #include <asm/global_data.h>
@@ -85,7 +87,6 @@ static int hist_cur = -1;
 static unsigned hist_num;
 
 static char *hist_list[HIST_MAX];
-static char hist_lines[HIST_MAX][HIST_SIZE + 1];	/* Save room for NULL */
 
 #define add_idx_minus_one() ((hist_add_idx == 0) ? hist_max : hist_add_idx-1)
 
@@ -97,8 +98,9 @@ static void getcmd_putchars(int count, int ch)
 		getcmd_putch(ch);
 }
 
-static void hist_init(void)
+static int hist_init(void)
 {
+	unsigned char *hist;
 	int i;
 
 	hist_max = 0;
@@ -106,10 +108,14 @@ static void hist_init(void)
 	hist_cur = -1;
 	hist_num = 0;
 
-	for (i = 0; i < HIST_MAX; i++) {
-		hist_list[i] = hist_lines[i];
-		hist_list[i][0] = '\0';
-	}
+	hist = calloc(HIST_MAX, HIST_SIZE + 1);
+	if (!hist)
+		return -ENOMEM;
+
+	for (i = 0; i < HIST_MAX; i++)
+		hist_list[i] = hist + (i * (HIST_SIZE + 1));
+
+	return 0;
 }
 
 static void cread_add_to_hist(char *line)
@@ -493,8 +499,9 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 
 #else /* !CONFIG_CMDLINE_EDITING */
 
-static inline void hist_init(void)
+static inline int hist_init(void)
 {
+	return 0;
 }
 
 static int cread_line(const char *const prompt, char *buf, unsigned int *len,
@@ -643,8 +650,9 @@ int cli_readline_into_buffer(const char *const prompt, char *buffer,
 	 */
 	if (IS_ENABLED(CONFIG_CMDLINE_EDITING) && (gd->flags & GD_FLG_RELOC)) {
 		if (!initted) {
-			hist_init();
-			initted = 1;
+			rc = hist_init();
+			if (rc == 0)
+				initted = 1;
 		}
 
 		if (prompt)
-- 
2.42.0

