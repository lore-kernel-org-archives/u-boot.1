Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F757C48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 14:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BEF887E71;
	Sat, 17 Feb 2024 15:16:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="NGzKoc0B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C27E787E0F; Sat, 17 Feb 2024 14:56:26 +0100 (CET)
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com
 [203.205.221.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA028792D
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 14:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1708178177; bh=PpAnQiA+efGNr6WGDT1qI6bfgcAiVmfx/nRX+GY06JA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NGzKoc0Bd1InSnmVHvpFVALGc/VUTwTCBfa5a+iH32KIibb7IpnOUmDJvSmJ1ymTo
 9IgcsyC74u3//l9y7HSVFju9Bdun0mVQY3hV6SGGRV1HTDzveN8Hst7IS/DlCI4hY6
 6tL89nVHFw3OufqoaLDwWqNGaJUUEwUsB1iSDx0M=
Received: from localhost.localdomain ([36.101.128.104])
 by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
 id DF099EEC; Sat, 17 Feb 2024 21:55:48 +0800
X-QQ-mid: xmsmtpt1708178150tzzvs9sfp
Message-ID: <tencent_B425E566FD3F5FC915C73AC086F1EB178406@qq.com>
X-QQ-XMAILINFO: NSahpW5IwUZOAK610uJmv+XzlezjRmilMgDmPtAnbrjd5gdNYaIrufeTVPV3ih
 AYsubDvuRZNIkwQS+yp4mPo4CZC92q+EKGvs8b5EjtbCU1bpy+7NBjn1Wzc8QLfTHIcwUF0DborZ
 GdH4h0dQzPDsJflVOykrQBgHkqDGWP3/iHX6lTYN2PKRwruwZD/AWOIPhdJDAJMAIlSw9c8cyXZA
 tja2UUthOszAdQbZKvzR5AT91KzM5VpL1wPV+Ma6CeHHvwTIzFLF45uKAZdRGWZJ02rYoNcr05IL
 gvUWi5/25ry/wsj3KNkf59nKI96jiHGITXZkb0y2ZLsmxOiJm+ZT/XUe0jrla/Npp3X0BIfZADRo
 3gMNzlLIYE5iXVPHg+g533v/xw7ZMQADVATm6WRem0upRKaFiLlYSfCmw8R1v7tDFt92/gE1gXue
 wc2cCig2L7i8lRgsTc7bAp4DdfVENB2sc8oXSmY67Opc5VkhriJlHQFwcvc//HAsemBCeMDtlJbX
 fI/cb7Ww6DW71reC7cyiGre2YfoUl0aNUM9WvL/hjEUc5cmSKWW6jFTysiZp54nUGdW2u5uGhZdC
 TlJYmB/PTNHCf5SzABNYaOKzK1ggHYpztvcnCRA6De8FXH6pqbQjqDR5DLgUNAG0TWthYnORViID
 z0hLMhgCOaVA2f+fxcwa8ur5r+a8ZxFgA0gW1DOiTH1ZT7Xy79THXBdImfqEv3c2Ejax7FT/T/6O
 aSXcSviI+ZQLBMpzeVTH8ZIMVSFTZ2uTwdJbZ2Si7yKiy2pcWOEbn6LAx4mnv12o4rWx419PycPr
 t8n2n3WUnY3yi50z2tMnvy5H5XtvaySHRTc7kGhCEkkaYyj2fq7hHbyfli7JrEEiAumiOL+aTtsD
 PGDC/f38Dd6gjl7/fan065cpJEHaNhRZ3wXD8cRhsawBjiFYlLnrhFx44X2faAn98/UbyJmNZrFP
 5xLWYeiU25TnmoBbFJQ+uIgIwBb1Ah01IHSVCnJxhYPkOTDggDSBwzWQyO9kxScSC8K0wPkHE=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Hanyuan Zhao <hanyuan-z@qq.com>
Subject: [PATCH 2/2] cli: allow users to determine history buffer allocation
 method
Date: Sat, 17 Feb 2024 21:54:45 +0800
X-OQ-MSGID: <20240217135443.16503-2-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217135443.16503-1-hanyuan-z@qq.com>
References: <20240217135443.16503-1-hanyuan-z@qq.com>
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

This commit allows users to choose the appropriate memory
allocation method between static allocated and dynamically
calloc. The previous static-array way will not obviously
contribute to the final binary size since it is uninitialized,
and might have better performance than the dynamical one.
Now we provide the users with both the two options.

Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>
---
 cmd/Kconfig           |  8 ++++++++
 common/cli_readline.c | 23 ++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index af4dbc95fc..d0140b6cbe 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -190,6 +190,14 @@ config CMD_HISTORY
 	  Show the command-line history, i.e. a list of commands that are in
 	  the history buffer.
 
+config CMD_HISTORY_USE_CALLOC
+	bool "dynamically allocate memory"
+	default y
+	depends on CMD_HISTORY
+	help
+	  Saying Y to this will use calloc to get the space for history
+	  storing. Or it will be compiled as a static array.
+
 config CMD_LICENSE
 	bool "license"
 	select BUILD_BIN2C
diff --git a/common/cli_readline.c b/common/cli_readline.c
index eec6d8b0a2..a945cbf7cf 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -87,26 +87,35 @@ static int hist_add_idx;
 static int hist_cur = -1;
 static unsigned hist_num;
 
+#ifndef CONFIG_CMD_HISTORY_USE_CALLOC
+static char hist_data[HIST_MAX][HIST_SIZE + 1];
+#endif
 static char *hist_list[HIST_MAX];
 
 #define add_idx_minus_one() ((hist_add_idx == 0) ? hist_max : hist_add_idx-1)
 
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
-- 
2.34.1

