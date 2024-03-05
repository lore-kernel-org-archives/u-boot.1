Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84771C5478C
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 07:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC0FC87FC8;
	Tue,  5 Mar 2024 08:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="QSJY/1kS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37D5787FCC; Tue,  5 Mar 2024 08:39:36 +0100 (CET)
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com
 [203.205.221.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6C487FE7
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 08:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1709624367; bh=ll/J+AfiLLxIqLSUz5411VkCwK7e3fgH8Mg5rfhxkvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QSJY/1kSnEfZNfnoBG2NSfSPRxk5Y8r5UOVAp0UFdxKXQPxvOTduHmpKetLTuDh8G
 Ivv/ye7qvnPUz9w5DawfOycbi3yPlx89IYpCV5j1Cl6/GE/B7yoBm78yMcM/bM4xjH
 PR/hSgHrppx9u4DzW+otW6fYrJmpvKksm6ZnMgzo=
Received: from localhost.localdomain ([183.172.219.254])
 by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
 id 9BB85255; Tue, 05 Mar 2024 15:38:59 +0800
X-QQ-mid: xmsmtpt1709624341t3ebe9jp8
Message-ID: <tencent_D787FFDC25291C1400FDC6EB5F8396029B08@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwNzPIPQ+tPLjr91YjZdZys0M8guvtukQh6xWmJzCLZJ7DCIqnRY
 FSgegguoejiwMQmCdXWA5MXu1Tm3TOi6LluqvzGf7v2oOJvH7KBY0bLbG62i9CBnKNtvmcp2EkPN
 AdPyOXUjSxB9ZjFEQGjPl4SUclSdF25kudBhnH0ZN+rkhPHcczBlRUOzpqkiXC/f21Zv3D3vOajE
 veI4Ol+HHUVdYRpCuoYdEnaessDS4bjTL2Fmtz4s582URcMIBmuVSs9K8s7QHFANdG1Xy+/csoE1
 EH3AN1UNZ3HQtVmIn53NRjA98H0kzY0urA0YIB8yn52FNNEnLJP2txFhOGtD+00FExFJgXx2Oo7u
 Zew6lqGayGqHn5JFGaWXmsnCAn+HFfJkBbRg21fb7xD9GfEUx2ZLfrV0d0DrTQGLYM54gtKVP6z/
 q6f7/kwFzqVEQmU5tDRR9WCMA2Kw/5Ew1/cIqnKSjJzbSeOq0ZpGjLxhBC3Vs+aU1WhjD+Sf0jji
 KbPwXYfqS8mbymCrcgNcgyUYmIYpz3wTa6qkzPkny4fmal03S3WTc2+pCNKHkE5I9g1kRYUJtnWm
 037t9V2278WH7ndxMeGsoFst9pH5DSXL4hpXifaStiFVn6M63YUGQDvXUD7ts3Opy3hspAA/XBIu
 Ge9qDcxqvmv72CYL1RfREkav1ofcemxlFY7H6kW1U57ZNH7K7FqL1DMaIzAixkKjJgKYlqKg5cUf
 uMW+foE989Yl/bGZgR1C3nudXgNq8dqve30C1pDCPoN///oSFDlYq/5uyR1IxDXHhHM0JnHbQH8z
 ZEVpSS8jjvIlDHnfruiLFaxWUvunNxlCBwmF2aDNvzhJh8xMnCmSIfbIncim5xVkwQ2UzoA1TVMk
 p9mJokmah0TZ9IdiKXsKc8V0JCebnvH8takbIENFj4aOtCyWLAOVLBg4jOiI48mQgvEqpXdYZ+eA
 Sm0wy59lXm5x7RlO3UfRcoODvicSkEPh1BPXKcwTZBN5SchMFMn2WfcI1BM2V1zj7uxJd6T+Y=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Hanyuan Zhao <hanyuan-z@qq.com>
Subject: [PATCH v3 2/3] cli: allow users to determine history buffer
 allocation method
Date: Tue,  5 Mar 2024 15:37:35 +0800
X-OQ-MSGID: <20240305073734.14483-2-hanyuan-z@qq.com>
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

This commit allows users to choose the appropriate memory
allocation method between static allocated and dynamically
calloc. The previous static-array way will not obviously
contribute to the final binary size since it is uninitialized,
and might have better performance than the dynamical one.
Now we provide the users with both the two options.

Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>
---
This is v3 of patch series cli: allow users to disable history
if unused at all. Please ignore the v2 version.
---
Changes v1 -> v3:
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

