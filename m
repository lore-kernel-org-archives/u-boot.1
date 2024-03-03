Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4D1C48BF6
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 14:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D8A287F1F;
	Sun,  3 Mar 2024 15:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="AweK1FTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E020187F23; Sun,  3 Mar 2024 15:38:10 +0100 (CET)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E45E87F1C
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 15:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1709476678; bh=nPUSqXkBhkZEvU9Y6UpChrbZfWltWqpJoez04Ae+ij4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AweK1FTOfoS8t1HUd/xbeb7WHhlZQGC4T9HhH+hcHd4TT+FUxFUJegpd5BnzpZFlO
 u/jVvUNYbQouwi++EaEHpysRG0NqZszfuUg34wlLN8uos8QyKQnbnJRN+tv0mrODG9
 6kuVDlm5Kb5Kw3urn5aLgZZBkmb2wFe07eqp8wEE=
Received: from localhost.localdomain ([183.172.216.136])
 by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
 id 95A9DA66; Sun, 03 Mar 2024 22:37:26 +0800
X-QQ-mid: xmsmtpt1709476648taq8dclhq
Message-ID: <tencent_618C93BE082CED360DFEC94BF63834004209@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85Nom61B1JsF63Fg84UOkmNY2mYNQGHG1ZXy7kUcFPWcPBuqFH/wDz
 qzIWI1OYnUZELnW5KPFJCOyBzs5+ndxG/TPqHFG/95EpXqpTBqmBngePrfvUtlZ8Bh31Lhp1PgYX
 801c2sOwA6YvFN/b/YNdP93eH4bQkaLQMpamu6YnO8uVhdllkyt48UUKiFalSjbTt2odPk13NQpj
 9MyOPgssg2IUYuMmgrnkwuJz8MZ/eqannwmrWxUHRXIA/4StRSJoQssZZlvMI1BnNVGuwyHdSkeW
 hVm+oWfG7M8RabQl2PwU7H/YGHtHgDysqlJWYzHQCxKdS4dptiT28IfwkcWrnAk3W3jXvmOcIR3Z
 sLfQ4mlLzlfhagF/o444pFhNJHHPmqTunzLBUOIiDv5P82WEa4G/trPYejVfAB5f8XwEZvdpChvM
 m7RgxsOt/YJwnYfkxO5m4pt/SycvxzNqKAuSad2ZbZ/A8kce4LLrZ1dwW7kKOxUo6k+GY69nXy87
 r0kkzyva/3FcfAOgqSRcKJggjPS/hbE/1OvEbnOce9rkzOz03IzcaMT/Fy8kPb9uKTAe0NpsYARd
 Sz+7J35L1UodQoiCVgUD3XmQTTxg8DHfXCz+yG5nHeJOVv/8BUzPn9C554m7Iv1S8XR2a2jSqPI2
 LaMId0LSUV9/VYbLNJGrpCTBMWHTDWocBwAJdFBn3a4SJYmuHU313b41LsODowG/OT/ELN1aoAw9
 B9FY4Iz9HvVueQ41jVgQjeHSgpv+PQrh/FCvmaiot92xwL+FYJeVCOjy+DS/Vc08dl1wTpNlz90A
 8Uu8UdB2K9CdEhDs44AR1MU5ewbXNHuXmPvnXkJBzj0XA0ezQJJ9GwD7xTE80cC9oXc9KLbswXgE
 tbmZ5+hQtH8hUDptwN3R2YiRAq19VOn/ZNJ7hzYt0RZ1/E1foP5pYZcpMkZgvnPkrbateKDuroSl
 0a5okFvT+QdAhy36eetBOmaAj0MUPJsmGLgaxdIFTy9YmPsOVFZNozNk46Xa8vQOciDZaLoMw=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Hanyuan Zhao <hanyuan-z@qq.com>
Subject: [PATCH v2 2/2] cli: allow users to determine history buffer
 allocation method
Date: Sun,  3 Mar 2024 22:34:47 +0800
X-OQ-MSGID: <20240303143445.7030-2-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240303143445.7030-1-hanyuan-z@qq.com>
References: <20240303143445.7030-1-hanyuan-z@qq.com>
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

This commit allows users to choose the appropriate memory
allocation method between static allocated and dynamically
calloc. The previous static-array way will not obviously
contribute to the final binary size since it is uninitialized,
and might have better performance than the dynamical one.
Now we provide the users with both the two options.

Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>
---
Changes v1 -> v2:
  - Add more detailed information about the CMD_HISTORY_USE_CALLOC
option both in the Kconfig and the code.
  - Update the comments on global history array and flash running
problems.
---
 cmd/Kconfig           | 11 +++++++++++
 common/cli_readline.c | 36 +++++++++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a86b570517..7d2c050e08 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -189,6 +189,17 @@ config CMD_HISTORY
 	  Show the command-line history, i.e. a list of commands that are in
 	  the history buffer.
 
+config CMD_HISTORY_USE_CALLOC
+	bool "dynamically allocate memory"
+	default y
+	depends on CMD_HISTORY
+	help
+	  Saying Y to this will use calloc to get the space for history
+	  storing. Otherwise the history buffer will be an uninitialized
+	  static array directly, without the memory allocation, and it is
+	  writable after relocation to RAM. If u-boot is running from ROM
+	  all the time or unsure, say Y to this.
+
 config CMD_LICENSE
 	bool "license"
 	select BUILD_BIN2C
diff --git a/common/cli_readline.c b/common/cli_readline.c
index 99e7efdfe5..cf4339d0e5 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -86,6 +86,9 @@ static int hist_add_idx;
 static int hist_cur = -1;
 static unsigned hist_num;
 
+#ifndef CONFIG_CMD_HISTORY_USE_CALLOC
+static char hist_data[HIST_MAX][HIST_SIZE + 1];
+#endif
 static char *hist_list[HIST_MAX];
 
 #define add_idx_minus_one() ((hist_add_idx == 0) ? hist_max : hist_add_idx-1)
@@ -100,20 +103,26 @@ static void getcmd_putchars(int count, int ch)
 
 static int hist_init(void)
 {
-	unsigned char *hist;
 	int i;
 
-	hist_max = 0;
-	hist_add_idx = 0;
-	hist_cur = -1;
-	hist_num = 0;
-
-	hist = calloc(HIST_MAX, HIST_SIZE + 1);
+#ifndef CONFIG_CMD_HISTORY_USE_CALLOC
+	for (i = 0; i < HIST_MAX; i++) {
+		hist_list[i] = hist_data[i];
+		hist_list[i][0] = '\0';
+	}
+#else
+	unsigned char *hist = calloc(HIST_MAX, HIST_SIZE + 1);
 	if (!hist)
 		panic("%s: calloc: out of memory!\n", __func__);
 
 	for (i = 0; i < HIST_MAX; i++)
 		hist_list[i] = hist + (i * (HIST_SIZE + 1));
+#endif
+
+	hist_max = 0;
+	hist_add_idx = 0;
+	hist_cur = -1;
+	hist_num = 0;
 
 	return 0;
 }
@@ -643,10 +652,15 @@ int cli_readline_into_buffer(const char *const prompt, char *buffer,
 	static int initted;
 
 	/*
-	 * History uses a global array which is not
-	 * writable until after relocation to RAM.
-	 * Revert to non-history version if still
-	 * running from flash.
+	 * Say N to CMD_HISTORY_USE_CALLOC will skip runtime
+	 * allocation for the history buffer and directly
+	 * use an uninitialized static array as the buffer.
+	 * Doing this might have better performance and not
+	 * increase the binary file's size, as it only marks
+	 * the size. However, the array is only writable after
+	 * relocation to RAM. If u-boot is running from ROM
+	 * all the time, consider say Y to CMD_HISTORY_USE_CALLOC
+	 * or disable CMD_HISTORY.
 	 */
 	if (IS_ENABLED(CONFIG_CMDLINE_EDITING) && (gd->flags & GD_FLG_RELOC)) {
 		if (!initted) {
-- 
2.34.1

