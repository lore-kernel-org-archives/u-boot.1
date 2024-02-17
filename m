Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962DBC48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 14:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BEC687E52;
	Sat, 17 Feb 2024 15:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="IpiGNYKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4D2787E21; Sat, 17 Feb 2024 14:56:04 +0100 (CET)
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com
 [162.62.57.210])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71F768792D
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 14:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1708178150; bh=I/x0567JHZNKfJGQEG8vJoyci6dC8VFOhfV25aWGucI=;
 h=From:To:Cc:Subject:Date;
 b=IpiGNYKEOkD2d8KegFKAnqqxpUHk+poDiHRUIsCSoJTvSCrHlhRPpa2EV5WEGUIMd
 yQnWQe6z/Bz/SLm6S/hQouZb/qTk0dRctiDmOkLIhQUnA5nLaxzoLZKiefAPQAEkyY
 heczLHu4T3SdDo51uxgAIFYyqxTEHz8Y/XQF7ZVo=
Received: from localhost.localdomain ([36.101.128.104])
 by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
 id DF099EEC; Sat, 17 Feb 2024 21:55:48 +0800
X-QQ-mid: xmsmtpt1708178148tdvy5n6kz
Message-ID: <tencent_411A9B7DA959D26CCAFCE7961870C400E80A@qq.com>
X-QQ-XMAILINFO: NnA3IMNPwBd+T5WxaW3m1/6qTcU3usHDxtggCV2BdiklV9QLyE074JnyGDT/Hz
 z3DKwvkZi9XbMvS793eIleBb0p7gg5dE9Q5MqByKIf0bCeZK5VDPPKM66YuEqe3J8iSvuGQF/A51
 n86B+73Sci4B1sW5Srwk8o1fbM5oacA+shgmszw7Lq6+iLxoz05X+5/8l+ONQG47Mp2Qk3zk49pA
 tUOXgVsoYti3z1TzLqMTrqiPUs37vwGmynYVshUTHkmMX6Gn0nXYeBKeYzIyJnt1ecqbyU3g3kJg
 RazEjF7YGjEIMw7qQ35gs/gcFobv8zRkxAEV+vX+wcWT8ewJqKxWYkS1ZcZijqFgTbeeYj4fxqGu
 y0VLyiy9s4oyiYTtLzhWC3aXyMKB9jw7HbV5hVmRcbjKLBdQSaicfaumehVpKYgludojdI81zsI6
 BAyoDDy2uFbVTk71w+s12Dyif+1s9W1btCH+Q36lXrNfEtKaWbA+M9z7d/LiP+grIAK5b+FnNWcM
 pz+cETv15ugmuqgWyEeDzkiLJAVZrqzjFXxN19zKzyjTwBQZpIDwJ2ROehOrntuwDMlkE2nPGY/4
 mVbaivkuYoaAo+a72090qxrX5xtn+f3Z9O93xjYFdBq586K3jaw9ogoyYde+MA3fzN+ET0XLGIJQ
 frK6kg5vnbo8C6zzPep60sJYI/zcGCHA0RQzqZKchFArNYkvSJzuvLw6QnHIpd+cqkOWz+V0VEu7
 B3SAQ5fs/4PnmJzo8u8pCj2O3MkALYseyI+9iafy7J8HOARI2kmqA2vb5Z3zefWSNmfTWFqhzNQj
 nQm9OdHX3MjPtXcL7zsB+8Hsjg3QJTnDhgYLnaHIBMOwiu8p7Ej3ZwiXj5a1U53KyYapGjm/sZ67
 qfv5x1xnHcxzPUoQb/aMUFdrynNxwZ2HOLbOV1W9cSTmi4gF8WKAQhGS/HNvDAilecH+air1zSQ0
 lJiDwhaFAZEeufq5RnI1SBFQ196rv9aVrTDzmIOGkFEZWDsWIq7LUxFsIVQvPR
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Hanyuan Zhao <hanyuan-z@qq.com>
Subject: [PATCH 1/2] cli: allow users to disable history if unused at all
Date: Sat, 17 Feb 2024 21:54:43 +0800
X-OQ-MSGID: <20240217135443.16503-1-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Feb 2024 15:16:43 +0100
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
in command-line. Previously the history data as uninitialized static
array would not directly take much space in binary file since it only
marks size in the binary. However now it asks to allocate space. By
connecting the original CMD_HISTORY flag in Kconfig, users could unset
the whole history function, and the memory usage could be eased, if the
history function is not used at all.

Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>
---
 cmd/Kconfig           |  1 +
 common/cli_readline.c | 44 ++++++++++++++++++++++++-------------------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a86b570517..af4dbc95fc 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -184,6 +184,7 @@ config CMD_FWU_METADATA
 
 config CMD_HISTORY
 	bool "history"
+	default y
 	depends on CMDLINE_EDITING
 	help
 	  Show the command-line history, i.e. a list of commands that are in
diff --git a/common/cli_readline.c b/common/cli_readline.c
index 2507be2295..eec6d8b0a2 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -67,12 +67,13 @@ static char *delete_char (char *buffer, char *p, int *colp, int *np, int plen)
 #define CTL_BACKSPACE		('\b')
 #define DEL			((char)255)
 #define DEL7			((char)127)
-#define CREAD_HIST_CHAR		('!')
 
 #define getcmd_putch(ch)	putc(ch)
 #define getcmd_getch()		getchar()
 #define getcmd_cbeep()		getcmd_putch('\a')
 
+#ifdef CONFIG_CMD_HISTORY
+#define CREAD_HIST_CHAR		('!')
 #ifdef CONFIG_SPL_BUILD
 #define HIST_MAX		3
 #define HIST_SIZE		32
@@ -90,14 +91,6 @@ static char *hist_list[HIST_MAX];
 
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
 	unsigned char *hist;
@@ -110,7 +103,7 @@ static int hist_init(void)
 
 	hist = calloc(HIST_MAX, HIST_SIZE + 1);
 	if (!hist)
-		return -ENOMEM;
+		panic("%s: calloc: out of memory!\n", __func__);
 
 	for (i = 0; i < HIST_MAX; i++)
 		hist_list[i] = hist + (i * (HIST_SIZE + 1));
@@ -192,6 +185,15 @@ void cread_print_hist_list(void)
 		i++;
 	}
 }
+#endif
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
@@ -365,6 +367,7 @@ int cread_line_process_ch(struct cli_line_state *cls, char ichar)
 			cls->eol_num--;
 		}
 		break;
+#ifdef CONFIG_CMD_HISTORY
 	case CTL_CH('p'):
 	case CTL_CH('n'):
 		if (cls->history) {
@@ -394,6 +397,7 @@ int cread_line_process_ch(struct cli_line_state *cls, char ichar)
 			break;
 		}
 		break;
+#endif
 	case '\t':
 		if (IS_ENABLED(CONFIG_AUTO_COMPLETE) && cls->cmd_complete) {
 			int num2, col;
@@ -490,19 +494,23 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
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
@@ -640,20 +648,18 @@ int cli_readline_into_buffer(const char *const prompt, char *buffer,
 	char *p = buffer;
 	uint len = CONFIG_SYS_CBSIZE;
 	int rc;
-	static int initted;
+#ifdef CONFIG_CMD_HISTORY
+	static int hist_initted;
+#endif
 
-	/*
-	 * History uses a global array which is not
-	 * writable until after relocation to RAM.
-	 * Revert to non-history version if still
-	 * running from flash.
-	 */
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

