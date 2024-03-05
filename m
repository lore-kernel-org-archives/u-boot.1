Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B9BC54E49
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 01:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 568F187FA7;
	Tue,  5 Mar 2024 02:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="SOWDqvtI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F3E4876E4; Tue,  5 Mar 2024 02:37:05 +0100 (CET)
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com
 [203.205.251.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D67D87FD7
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 02:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1709602611; bh=APCLTc4gVxqbRDcMg0QR4SKPESSapxLTkdIZ0CafSMY=;
 h=From:To:Cc:Subject:Date;
 b=SOWDqvtIIxYzB9aQ693m0mxZogEJXP/1sgRV3gAJX5U65KG9yM6uW9U9iS+Kjl5ax
 HO7sU4APISUSlqNGdwe/+TRANuQ7JHRHTO8QDPB14tc8sZVitwlKsk48F4sE+hw6n9
 +0dIAyerBiW1g5mVZ8Sk0U3yRJ25vFDN2YfsRsiQ=
Received: from localhost.localdomain ([183.172.219.254])
 by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
 id 931368EA; Tue, 05 Mar 2024 09:36:49 +0800
X-QQ-mid: xmsmtpt1709602609tfq8ivey3
Message-ID: <tencent_2B25AB1C3800ABC6775FA296079B84FF7D08@qq.com>
X-QQ-XMAILINFO: NI6TJc3opC6FrR0yjpz/oxGvsqRnpZWCalfDUq3OFlPi9LByvkvb8447Q5IMvA
 Ee6SkukwNciPjQJjfLBFEjf1doWuLsY6VDQN4iyzhhxEWCnmCdyek0wbbaqli5ttXNozMrdUDuwN
 AanestnoV51Jzk0Lrkh7SzHtfs7k1nCsbDrKCd1YKWyyk16ai7mJW5H42yhuwK2ipQcHZGhMdfgt
 IO2l3AJliKxn1jmKp6M1xG7qPd4xeQCfIpsgsYn/J6QAWZQglsTEYZoX9ZOBH+May8+Zi59/NhW+
 KW6HtBt72WN+q4IpLhtBBiKEMRyQLqHK75JpTe2AUC3d36FIGEgCUMGV9u90GgencQYbGDO8lmTg
 qCrg9ykFowcnBOadTmXPR26q1CDj/ZAPX4KdzmsfsgxRZck/Ga+273YsUEx9U4tPOpNZaZYS7I82
 54W9fHGfvi0W71NTELc/MRDVrBB1WMEC42Qmx3adB5+PnG6KZIgjiB5PuAz0Uqdfi6dHPV9l7rN8
 8+LIFn8NBaLv0fIEtm5woXFgU9WF7WNL3byrrT24+hIyD4UNiz/SwaokvQw51rnmUOynYNAqafpX
 raU7igUgqx2MHijFggzm653A+ec8YhirHEdobgZOBVNLTdDSQilzCBhjv4eymyX/FAnj1yjNzL5W
 DLT62Z80SROtlHcu6fH1E0OB/uHIovDLnIslr23zvz6hPZQ276Q9ItA4a6d471AMW9G9qB9ckDH9
 c/vvgVYrNrei0vJJ7DQJgfH8yv5bnjYunAvJ7T4FcCQT0PDoyCVGZPiowtXcu2zSpG+GvVz2+qxT
 pb1hDI/DxglzOQxONKfDlmYiHQcd10aXtTRta0uUKYno3uACKiOxCBeN+KdzXHeB3Qje0GbgpAjC
 zFEHQTXjkwL7ymJlQv+BJJ50mfF0lUUn0MMeoviufERXq+Pb7ZXtgqmdAuYk+rjfLuKBqvGTS8H2
 V6Bbrz/uxnj/2eYbDL9Ab1yzOfA7UF6FCeoEQ9jpvTOw9eLcSiVA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Hanyuan Zhao <hanyuan-z@qq.com>
Subject: [PATCH v2 1/1] cli: compile history code if and only if history
 config is selected
Date: Tue,  5 Mar 2024 09:35:47 +0800
X-OQ-MSGID: <20240305013546.8015-1-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.34.1
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

This commit allows user to determine whether to have history recording
in command-line. Previously to this commit, the CMD_HISTORY only sets
the compiling of cmd/history.c, and the history code in cli_readline.c
is always compiled and will take a lot of space to store history even if
we say N to CMD_HISTORY.


Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>
---
This is v2 of patch series cli: allow users to disable history if unused at all
---
Changes v1 -> v2:
  - Please ignore the inaccurate description about the history code compilations
in the previous v2 patch: cli: panic when failed.
  - This patch is seperated from the v1 version patch 0001 cli: allow users to
disable history if unused at all, and now be the third of the v2 patches.
  - Move the #ifdef CONFIG_CMD_HISTORY directives to this patch. These directives
are still necessary when users are not using the history.
---
 common/cli_readline.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index cf4339d0e5..9f71b33a01 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -67,12 +67,14 @@ static char *delete_char (char *buffer, char *p, int *colp, int *np, int plen)
 #define CTL_BACKSPACE		('\b')
 #define DEL			((char)255)
 #define DEL7			((char)127)
-#define CREAD_HIST_CHAR		('!')
 
 #define getcmd_putch(ch)	putc(ch)
 #define getcmd_getch()		getchar()
 #define getcmd_cbeep()		getcmd_putch('\a')
 
+#ifdef CONFIG_CMD_HISTORY
+
+#define CREAD_HIST_CHAR		('!')
 #ifdef CONFIG_SPL_BUILD
 #define HIST_MAX		3
 #define HIST_SIZE		32
@@ -93,14 +95,6 @@ static char *hist_list[HIST_MAX];
 
 #define add_idx_minus_one() ((hist_add_idx == 0) ? hist_max : hist_add_idx-1)
 
-static void getcmd_putchars(int count, int ch)
-{
-	int i;
-
-	for (i = 0; i < count; i++)
-		getcmd_putch(ch);
-}
-
 static int hist_init(void)
 {
 	int i;
@@ -201,6 +195,15 @@ void cread_print_hist_list(void)
 		i++;
 	}
 }
+#endif /* CONFIG_CMD_HISTORY */
+
+static void getcmd_putchars(int count, int ch)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		getcmd_putch(ch);
+}
 
 #define BEGINNING_OF_LINE() {			\
 	while (cls->num) {			\
@@ -374,6 +377,7 @@ int cread_line_process_ch(struct cli_line_state *cls, char ichar)
 			cls->eol_num--;
 		}
 		break;
+#ifdef CONFIG_CMD_HISTORY
 	case CTL_CH('p'):
 	case CTL_CH('n'):
 		if (cls->history) {
@@ -403,6 +407,7 @@ int cread_line_process_ch(struct cli_line_state *cls, char ichar)
 			break;
 		}
 		break;
+#endif
 	case '\t':
 		if (IS_ENABLED(CONFIG_AUTO_COMPLETE) && cls->cmd_complete) {
 			int num2, col;
@@ -499,19 +504,23 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 	}
 	*len = cls->eol_num;
 
+#ifdef CONFIG_CMD_HISTORY
 	if (buf[0] && buf[0] != CREAD_HIST_CHAR)
 		cread_add_to_hist(buf);
 	hist_cur = hist_add_idx;
+#endif
 
 	return 0;
 }
 
 #else /* !CONFIG_CMDLINE_EDITING */
 
+#ifdef CONFIG_CMD_HISTORY
 static inline int hist_init(void)
 {
 	return 0;
 }
+#endif
 
 static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 		      int timeout)
@@ -649,7 +658,9 @@ int cli_readline_into_buffer(const char *const prompt, char *buffer,
 	char *p = buffer;
 	uint len = CONFIG_SYS_CBSIZE;
 	int rc;
-	static int initted;
+#ifdef CONFIG_CMD_HISTORY
+	static int hist_initted;
+#endif
 
 	/*
 	 * Say N to CMD_HISTORY_USE_CALLOC will skip runtime
@@ -663,11 +674,13 @@ int cli_readline_into_buffer(const char *const prompt, char *buffer,
 	 * or disable CMD_HISTORY.
 	 */
 	if (IS_ENABLED(CONFIG_CMDLINE_EDITING) && (gd->flags & GD_FLG_RELOC)) {
-		if (!initted) {
+#ifdef CONFIG_CMD_HISTORY
+		if (!hist_initted) {
 			rc = hist_init();
 			if (rc == 0)
-				initted = 1;
+				hist_initted = 1;
 		}
+#endif
 
 		if (prompt)
 			puts(prompt);
-- 
2.34.1

