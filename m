Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7764C5478C
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 07:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BAAA87FE0;
	Tue,  5 Mar 2024 08:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="TVx8yA6z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BE087FE7; Tue,  5 Mar 2024 08:40:04 +0100 (CET)
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com
 [203.205.221.210])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0CCC87BA8
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 08:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1709624396; bh=11hXqpPKi3UDPdJN86+GdPo8tIqYoNVqbp8sYfnIkvQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TVx8yA6zytr7E5Wt9hgkweezga2sUGycxC0SWJhhYPqnZr9O3bhS0gHv0DoaXg6B2
 B/PVsrA69GQFuiKNzndY6qkYm7YBPsLwQDGTXC7NfyQR2OLj7BUUmslCBFTB087JyL
 wlCV50METCYQsyj/fwSV41rLwLGYrkpX2MaxgPH8=
Received: from localhost.localdomain ([183.172.219.254])
 by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
 id 9BB85255; Tue, 05 Mar 2024 15:38:59 +0800
X-QQ-mid: xmsmtpt1709624366t0fb8aigo
Message-ID: <tencent_82A5BF202DB7378FFE714B6E38F401448C09@qq.com>
X-QQ-XMAILINFO: OUMxvQDaATieRaNn7cxJUYLafRk/ZLe0nfgyJlAYfX/8AQjXz9NrWPlTrH71Sx
 QpabiIT2stCO+TM8cLEsX88swF308KoKGkTFbADa3oMC4QxYLoa37hh+3PGRUryoXwr4HjInhydu
 J+5SXDI+Ohjzs2QeTK3vRx88RghG8XlObFaOi5VkZL+zykcJRGoBCE8kQYayEjrbNttQZ8SNm78h
 bAIk+UJXubQW99CIavesjZHlWpY2sMgZrmyh4xU3fYaYVcPnC9ienA+hnRhDQNsdHoHS4OkMxsjp
 9HOAup0GoT+20i4C6Y595H6A8SanmQXXe8t16G5m32u5c/Zb/iJNslN7fg79DoI+YNEg2TflLLf6
 OfcoWAvpILcRo7cR5lK7K09Qbvdgy+TBZlNqX1irIrEkgC8m8wdyRGFj8z6Pan9unQ/8GDqE02Vr
 V7+fdtXBSeCDc1htHE3jYFhZ6VhZ/wpFfkjWFuV379M9k/rlcBv2bKtOd95Bn//R7yxPiQhqem8g
 aascohRpuYSS9OFqDTNHEo4DKPq+qieu+MgNxQlX7Ut25WIAL31Zq4KnjUoA+HAGfl1sT99JABgQ
 Pw3dwcjwRCRumA4pLsLVEUK83n2zWE1aHPbNDgZOUIz90dYCb8VAbK59pj+NBVHuDBQJ5LmOUIIy
 gLZbjVoXln8KlJNqZM+Brt8R6PswbPCx0jnil06HbJptvmwlpp6WT3NNmdrgbywi3k7YnVFjjNhJ
 alZsokLPbS/dMMka5ehOlJDPj1Elk1wW9t5r/A1RRGbzEBUtolpdNjZdUy3ATbfAYaEF+W/JE3Rz
 z0m5FdpQ2w7GOIvABpushiZ1ebHUOUK0W+xPZgg0aCHw2QFbn/jTGvpFjV5QhiaAsWgrPTAfKJ3K
 QDwu5udt3Ssa4zWXEziDpaIeiIMIRJ1SLDNxrLE/KqxOLgEtIkSnAqUxLpE3suN1JPwCv+Qd4xi/
 65qfMWPDuzj1TxWxJwh350EMTMrwEW+uj1jgFtM9g4odVa6TdBgg878tecPSJMp9JqAlspl70=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Hanyuan Zhao <hanyuan-z@qq.com>
Subject: [PATCH v3 3/3] cli: compile history code if and only if history
 config is selected
Date: Tue,  5 Mar 2024 15:37:37 +0800
X-OQ-MSGID: <20240305073734.14483-3-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305073734.14483-1-hanyuan-z@qq.com>
References: <20240305073734.14483-1-hanyuan-z@qq.com>
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
This is v3 of patch series cli: allow users to disable history
if unused at all. Please ignore the v2 version.
---
Changes v1 -> v3:
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

