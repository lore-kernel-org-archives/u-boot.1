Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EADDCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B726E86F69;
	Tue, 17 Oct 2023 00:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rp9AYBS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 873C186F18; Tue, 17 Oct 2023 00:32:39 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E54486E11
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-77386822cfbso344937985a.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495531; x=1698100331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOq8SXNiZCWBDjayfzBeVgI/EjBzAAqCfUSBkPgPNsU=;
 b=Rp9AYBS9kPxjwS6kwy5AHG4/7HdQVV5IAxvMzWsgz98HzBex8k+QJiJkTPQlVgpsio
 YmSxQKYmelXH35zxGetvsEC5TQPu4vK3+TCOJp8aPFc34xwTVBRVR9OQRO+h05E/j3Qt
 FRBpFkdCOqgD0Grynt5hiTKqDzOyCJsegm9Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495531; x=1698100331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOq8SXNiZCWBDjayfzBeVgI/EjBzAAqCfUSBkPgPNsU=;
 b=VW2LG6YG3Gfazh+n+V8RXP+2s5cS/SfzzkEH+O5HbPGKxgTU6XCpP+lJkazGVnZGHf
 1YjQalxlWJ0a+TQE2NSd2STpNcvR5FUAIk1rP9b79A1sRri9n97wAsaLjoa/PMzm+Izx
 RmL2Uy0Wb5qAlLWkpdjQbaj2zuYtceoVzocoD23XuRnR2LBw8geVdB46+XT5IaDT4OQ0
 eMDxblocl+55lAsqt3aDGaNvwZGsAsGtCJc6fMHrujQlhbHSuNxdfx3W232gA94ynwV/
 1FRSAcgBvWcXZEzEXZZu1EkiVnfJUuCufxfx6R1u2Nb1OLkMDgCVIXfUs0Qk8bVCRMfX
 Taig==
X-Gm-Message-State: AOJu0YwUM57HA5IO3SdgjUWaw3sbMG7yjmZSe+O33nz8SCYmcsa+WlSH
 b/dy8rTF0UYgNioLC+Isr2F6AGwuBp8rk3o+JiIZUA==
X-Google-Smtp-Source: AGHT+IED3C6c34scjz3d6OeBw8qwA75rkN0bPZ06BH8EJYaZO789h3WaULjmG9hlXH/c+DPy4JWJdg==
X-Received: by 2002:a05:620a:190a:b0:775:937b:c594 with SMTP id
 bj10-20020a05620a190a00b00775937bc594mr570282qkb.58.1697495530949; 
 Mon, 16 Oct 2023 15:32:10 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:32:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 23/32] cli: Split command-line-editing into its own file
Date: Mon, 16 Oct 2023 16:28:14 -0600
Message-ID: <20231016222835.596572-24-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

This features has buffers and code which is behind an #ifdef at
present. Move it into its own file, exporting functions as needed.

Drop add_idx_minus_one() since it is not used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig          |   3 +-
 common/Makefile       |   7 +-
 common/cli_cread.c    | 403 ++++++++++++++++++++++++++++++++++++++++++
 common/cli_readline.c | 384 +---------------------------------------
 include/cli.h         |  30 ++++
 5 files changed, 441 insertions(+), 386 deletions(-)
 create mode 100644 common/cli_cread.c

diff --git a/boot/Kconfig b/boot/Kconfig
index 6461f7ebd040..2fbe70245ec9 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -349,7 +349,8 @@ config PXE_UTILS
 
 config BOOT_DEFAULTS
 	bool  # Common defaults for standard boot and distroboot
-	imply USE_BOOTCOMMAND
+	depends on CMDLINE
+	imply USE_BOOTCOMMAND if !SANDBOX
 	select CMD_ENV_EXISTS
 	select CMD_EXT2
 	select CMD_EXT4
diff --git a/common/Makefile b/common/Makefile
index 637066ae6682..e22ced0c507f 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_SPLASH_SOURCE) += splash_source.o
 obj-$(CONFIG_MENU) += menu.o
 obj-$(CONFIG_UPDATE_COMMON) += update.o
 obj-$(CONFIG_USB_KEYBOARD) += usb_kbd.o
+obj-$(CONFIG_CMDLINE_EDITING) += cli_cread.o
 obj-$(CONFIG_CMDLINE) += cli_readline.o cli_simple.o
 
 endif # !CONFIG_SPL_BUILD
@@ -90,8 +91,10 @@ obj-y += eeprom/eeprom_field.o eeprom/eeprom_layout.o
 endif
 
 obj-y += cli.o
-obj-$(CONFIG_FSL_DDR_INTERACTIVE) += cli_getch.o cli_simple.o cli_readline.o
-obj-$(CONFIG_STM32MP1_DDR_INTERACTIVE) += cli_getch.o cli_simple.o cli_readline.o
+obj-$(CONFIG_FSL_DDR_INTERACTIVE) += cli_getch.o cli_simple.o cli_readline.o \
+	cli_cread.o
+obj-$(CONFIG_STM32MP1_DDR_INTERACTIVE) += cli_getch.o cli_simple.o \
+	cli_readline.o cli_cread.o
 obj-$(CONFIG_DFU_OVER_USB) += dfu.o
 obj-y += command.o
 obj-$(CONFIG_$(SPL_TPL_)LOG) += log.o
diff --git a/common/cli_cread.c b/common/cli_cread.c
new file mode 100644
index 000000000000..19af27303cfc
--- /dev/null
+++ b/common/cli_cread.c
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2000
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ *
+ * Add to readline cmdline-editing by
+ * (C) Copyright 2005
+ * JinHua Luo, GuangDong Linux Center, <luo.jinhua@gd-linux.com>
+ */
+
+#include <common.h>
+#include <bootretry.h>
+#include <cli.h>
+#include <command.h>
+#include <time.h>
+#include <watchdog.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/*
+ * cmdline-editing related codes from vivi.
+ * Author: Janghoon Lyu <nandy@mizi.com>
+ */
+
+#define putnstr(str, n)	printf("%.*s", (int)n, str)
+
+#define CTL_BACKSPACE		('\b')
+#define DEL			((char)255)
+#define DEL7			((char)127)
+#define CREAD_HIST_CHAR		('!')
+
+#define getcmd_putch(ch)	putc(ch)
+#define getcmd_cbeep()		getcmd_putch('\a')
+
+#ifdef CONFIG_SPL_BUILD
+#define HIST_MAX		3
+#define HIST_SIZE		32
+#else
+#define HIST_MAX		20
+#define HIST_SIZE		CONFIG_SYS_CBSIZE
+#endif
+
+static int hist_max;
+static int hist_add_idx;
+static int hist_cur = -1;
+static uint hist_num;
+
+static char *hist_list[HIST_MAX];
+static char hist_lines[HIST_MAX][HIST_SIZE + 1];	/* Save room for NULL */
+
+static void getcmd_putchars(int count, int ch)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		getcmd_putch(ch);
+}
+
+void hist_init(void)
+{
+	int i;
+
+	hist_max = 0;
+	hist_add_idx = 0;
+	hist_cur = -1;
+	hist_num = 0;
+
+	for (i = 0; i < HIST_MAX; i++) {
+		hist_list[i] = hist_lines[i];
+		hist_list[i][0] = '\0';
+	}
+}
+
+void cread_add_to_hist(char *line)
+{
+	if (line[0] && line[0] != CREAD_HIST_CHAR) {
+		strcpy(hist_list[hist_add_idx], line);
+
+		if (++hist_add_idx >= HIST_MAX)
+			hist_add_idx = 0;
+
+		if (hist_add_idx > hist_max)
+			hist_max = hist_add_idx;
+
+		hist_num++;
+	}
+
+	hist_cur = hist_add_idx;
+}
+
+char *hist_prev(void)
+{
+	char *ret;
+	int old_cur;
+
+	if (hist_cur < 0)
+		return NULL;
+
+	old_cur = hist_cur;
+	if (--hist_cur < 0)
+		hist_cur = hist_max;
+
+	if (hist_cur == hist_add_idx) {
+		hist_cur = old_cur;
+		ret = NULL;
+	} else {
+		ret = hist_list[hist_cur];
+	}
+
+	return ret;
+}
+
+char *hist_next(void)
+{
+	char *ret;
+
+	if (hist_cur < 0)
+		return NULL;
+
+	if (hist_cur == hist_add_idx)
+		return NULL;
+
+	if (++hist_cur > hist_max)
+		hist_cur = 0;
+
+	if (hist_cur == hist_add_idx)
+		ret = "";
+	else
+		ret = hist_list[hist_cur];
+
+	return ret;
+}
+
+void cread_print_hist_list(void)
+{
+	int i;
+	uint n;
+
+	n = hist_num - hist_max;
+
+	i = hist_add_idx + 1;
+	while (1) {
+		if (i > hist_max)
+			i = 0;
+		if (i == hist_add_idx)
+			break;
+		printf("%s\n", hist_list[i]);
+		n++;
+		i++;
+	}
+}
+
+#define BEGINNING_OF_LINE() {			\
+	while (cls->num) {			\
+		getcmd_putch(CTL_BACKSPACE);	\
+		cls->num--;			\
+	}					\
+}
+
+#define ERASE_TO_EOL() {				\
+	if (cls->num < cls->eol_num) {		\
+		printf("%*s", (int)(cls->eol_num - cls->num), ""); \
+		do {					\
+			getcmd_putch(CTL_BACKSPACE);	\
+		} while (--cls->eol_num > cls->num);	\
+	}						\
+}
+
+#define REFRESH_TO_EOL() {				\
+	if (cls->num < cls->eol_num) {			\
+		uint wlen = cls->eol_num - cls->num;	\
+		putnstr(buf + cls->num, wlen);		\
+		cls->num = cls->eol_num;		\
+	}						\
+}
+
+static void cread_add_char(char ichar, int insert, uint *num,
+			   uint *eol_num, char *buf, uint len)
+{
+	uint wlen;
+
+	/* room ??? */
+	if (insert || *num == *eol_num) {
+		if (*eol_num > len - 1) {
+			getcmd_cbeep();
+			return;
+		}
+		(*eol_num)++;
+	}
+
+	if (insert) {
+		wlen = *eol_num - *num;
+		if (wlen > 1)
+			memmove(&buf[*num + 1], &buf[*num], wlen - 1);
+
+		buf[*num] = ichar;
+		putnstr(buf + *num, wlen);
+		(*num)++;
+		while (--wlen)
+			getcmd_putch(CTL_BACKSPACE);
+	} else {
+		/* echo the character */
+		wlen = 1;
+		buf[*num] = ichar;
+		putnstr(buf + *num, wlen);
+		(*num)++;
+	}
+}
+
+static void cread_add_str(char *str, int strsize, int insert,
+			  uint *num, uint *eol_num, char *buf, uint len)
+{
+	while (strsize--) {
+		cread_add_char(*str, insert, num, eol_num, buf, len);
+		str++;
+	}
+}
+
+int cread_line_process_ch(struct cli_line_state *cls, char ichar)
+{
+	char *buf = cls->buf;
+
+	/* ichar=0x0 when error occurs in U-Boot getc */
+	if (!ichar)
+		return -EAGAIN;
+
+	if (ichar == '\n') {
+		putc('\n');
+		buf[cls->eol_num] = '\0';	/* terminate the string */
+		return 0;
+	}
+
+	switch (ichar) {
+	case CTL_CH('a'):
+		BEGINNING_OF_LINE();
+		break;
+	case CTL_CH('c'):	/* ^C - break */
+		*buf = '\0';	/* discard input */
+		return -EINTR;
+	case CTL_CH('f'):
+		if (cls->num < cls->eol_num) {
+			getcmd_putch(buf[cls->num]);
+			cls->num++;
+		}
+		break;
+	case CTL_CH('b'):
+		if (cls->num) {
+			getcmd_putch(CTL_BACKSPACE);
+			cls->num--;
+		}
+		break;
+	case CTL_CH('d'):
+		if (cls->num < cls->eol_num) {
+			uint wlen;
+
+			wlen = cls->eol_num - cls->num - 1;
+			if (wlen) {
+				memmove(&buf[cls->num], &buf[cls->num + 1],
+					wlen);
+				putnstr(buf + cls->num, wlen);
+			}
+
+			getcmd_putch(' ');
+			do {
+				getcmd_putch(CTL_BACKSPACE);
+			} while (wlen--);
+			cls->eol_num--;
+		}
+		break;
+	case CTL_CH('k'):
+		ERASE_TO_EOL();
+		break;
+	case CTL_CH('e'):
+		REFRESH_TO_EOL();
+		break;
+	case CTL_CH('o'):
+		cls->insert = !cls->insert;
+		break;
+	case CTL_CH('w'):
+		if (cls->num) {
+			uint base, wlen;
+
+			for (base = cls->num - 1;
+			     base >= 0 && buf[base] == ' ';)
+				base--;
+			for (; base > 0 && buf[base - 1] != ' ';)
+				base--;
+
+			/* now delete chars from base to cls->num */
+			wlen = cls->num - base;
+			cls->eol_num -= wlen;
+			memmove(&buf[base], &buf[cls->num],
+				cls->eol_num - base + 1);
+			cls->num = base;
+			getcmd_putchars(wlen, CTL_BACKSPACE);
+			puts(buf + base);
+			getcmd_putchars(wlen, ' ');
+			getcmd_putchars(wlen + cls->eol_num - cls->num,
+					CTL_BACKSPACE);
+		}
+		break;
+	case CTL_CH('x'):
+	case CTL_CH('u'):
+		BEGINNING_OF_LINE();
+		ERASE_TO_EOL();
+		break;
+	case DEL:
+	case DEL7:
+	case 8:
+		if (cls->num) {
+			uint wlen;
+
+			wlen = cls->eol_num - cls->num;
+			cls->num--;
+			memmove(&buf[cls->num], &buf[cls->num + 1], wlen);
+			getcmd_putch(CTL_BACKSPACE);
+			putnstr(buf + cls->num, wlen);
+			getcmd_putch(' ');
+			do {
+				getcmd_putch(CTL_BACKSPACE);
+			} while (wlen--);
+			cls->eol_num--;
+		}
+		break;
+	case CTL_CH('p'):
+	case CTL_CH('n'):
+		if (cls->history) {
+			char *hline;
+
+			if (ichar == CTL_CH('p'))
+				hline = hist_prev();
+			else
+				hline = hist_next();
+
+			if (!hline) {
+				getcmd_cbeep();
+				break;
+			}
+
+			/* nuke the current line */
+			/* first, go home */
+			BEGINNING_OF_LINE();
+
+			/* erase to end of line */
+			ERASE_TO_EOL();
+
+			/* copy new line into place and display */
+			strcpy(buf, hline);
+			cls->eol_num = strlen(buf);
+			REFRESH_TO_EOL();
+			break;
+		}
+		break;
+	case '\t':
+		if (IS_ENABLED(CONFIG_AUTO_COMPLETE) && cls->cmd_complete) {
+			int num2, col;
+
+			/* do not autocomplete when in the middle */
+			if (cls->num < cls->eol_num) {
+				getcmd_cbeep();
+				break;
+			}
+
+			buf[cls->num] = '\0';
+			col = strlen(cls->prompt) + cls->eol_num;
+			num2 = cls->num;
+			if (cmd_auto_complete(cls->prompt, buf, &num2, &col)) {
+				col = num2 - cls->num;
+				cls->num += col;
+				cls->eol_num += col;
+			}
+			break;
+		}
+		fallthrough;
+	default:
+		cread_add_char(ichar, cls->insert, &cls->num, &cls->eol_num,
+			       buf, cls->len);
+		break;
+	}
+
+	/*
+	 * keep the string terminated...if we added a char at the end then we
+	 * want a \0 after it
+	 */
+	buf[cls->eol_num] = '\0';
+
+	return -EAGAIN;
+}
+
+void cli_cread_init(struct cli_line_state *cls, char *buf, uint buf_size)
+{
+	int init_len = strlen(buf);
+
+	memset(cls, '\0', sizeof(struct cli_line_state));
+	cls->insert = true;
+	cls->buf = buf;
+	cls->len = buf_size;
+
+	if (init_len)
+		cread_add_str(buf, init_len, 0, &cls->num, &cls->eol_num, buf,
+			      buf_size);
+}
diff --git a/common/cli_readline.c b/common/cli_readline.c
index 06b8d4650447..ebbc979af6a9 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -60,383 +60,7 @@ static char *delete_char (char *buffer, char *p, int *colp, int *np, int plen)
  * Author: Janghoon Lyu <nandy@mizi.com>
  */
 
-#define putnstr(str, n)	printf("%.*s", (int)n, str)
-
-#define CTL_BACKSPACE		('\b')
-#define DEL			((char)255)
-#define DEL7			((char)127)
-#define CREAD_HIST_CHAR		('!')
-
-#define getcmd_putch(ch)	putc(ch)
 #define getcmd_getch()		getchar()
-#define getcmd_cbeep()		getcmd_putch('\a')
-
-#ifdef CONFIG_SPL_BUILD
-#define HIST_MAX		3
-#define HIST_SIZE		32
-#else
-#define HIST_MAX		20
-#define HIST_SIZE		CONFIG_SYS_CBSIZE
-#endif
-
-static int hist_max;
-static int hist_add_idx;
-static int hist_cur = -1;
-static unsigned hist_num;
-
-static char *hist_list[HIST_MAX];
-static char hist_lines[HIST_MAX][HIST_SIZE + 1];	/* Save room for NULL */
-
-#define add_idx_minus_one() ((hist_add_idx == 0) ? hist_max : hist_add_idx-1)
-
-static void getcmd_putchars(int count, int ch)
-{
-	int i;
-
-	for (i = 0; i < count; i++)
-		getcmd_putch(ch);
-}
-
-static void hist_init(void)
-{
-	int i;
-
-	hist_max = 0;
-	hist_add_idx = 0;
-	hist_cur = -1;
-	hist_num = 0;
-
-	for (i = 0; i < HIST_MAX; i++) {
-		hist_list[i] = hist_lines[i];
-		hist_list[i][0] = '\0';
-	}
-}
-
-static void cread_add_to_hist(char *line)
-{
-	strcpy(hist_list[hist_add_idx], line);
-
-	if (++hist_add_idx >= HIST_MAX)
-		hist_add_idx = 0;
-
-	if (hist_add_idx > hist_max)
-		hist_max = hist_add_idx;
-
-	hist_num++;
-}
-
-static char *hist_prev(void)
-{
-	char *ret;
-	int old_cur;
-
-	if (hist_cur < 0)
-		return NULL;
-
-	old_cur = hist_cur;
-	if (--hist_cur < 0)
-		hist_cur = hist_max;
-
-	if (hist_cur == hist_add_idx) {
-		hist_cur = old_cur;
-		ret = NULL;
-	} else {
-		ret = hist_list[hist_cur];
-	}
-
-	return ret;
-}
-
-static char *hist_next(void)
-{
-	char *ret;
-
-	if (hist_cur < 0)
-		return NULL;
-
-	if (hist_cur == hist_add_idx)
-		return NULL;
-
-	if (++hist_cur > hist_max)
-		hist_cur = 0;
-
-	if (hist_cur == hist_add_idx)
-		ret = "";
-	else
-		ret = hist_list[hist_cur];
-
-	return ret;
-}
-
-void cread_print_hist_list(void)
-{
-	int i;
-	uint n;
-
-	n = hist_num - hist_max;
-
-	i = hist_add_idx + 1;
-	while (1) {
-		if (i > hist_max)
-			i = 0;
-		if (i == hist_add_idx)
-			break;
-		printf("%s\n", hist_list[i]);
-		n++;
-		i++;
-	}
-}
-
-#define BEGINNING_OF_LINE() {			\
-	while (cls->num) {			\
-		getcmd_putch(CTL_BACKSPACE);	\
-		cls->num--;			\
-	}					\
-}
-
-#define ERASE_TO_EOL() {				\
-	if (cls->num < cls->eol_num) {		\
-		printf("%*s", (int)(cls->eol_num - cls->num), ""); \
-		do {					\
-			getcmd_putch(CTL_BACKSPACE);	\
-		} while (--cls->eol_num > cls->num);	\
-	}						\
-}
-
-#define REFRESH_TO_EOL() {				\
-	if (cls->num < cls->eol_num) {			\
-		uint wlen = cls->eol_num - cls->num;	\
-		putnstr(buf + cls->num, wlen);		\
-		cls->num = cls->eol_num;		\
-	}						\
-}
-
-static void cread_add_char(char ichar, int insert, uint *num,
-			   uint *eol_num, char *buf, uint len)
-{
-	uint wlen;
-
-	/* room ??? */
-	if (insert || *num == *eol_num) {
-		if (*eol_num > len - 1) {
-			getcmd_cbeep();
-			return;
-		}
-		(*eol_num)++;
-	}
-
-	if (insert) {
-		wlen = *eol_num - *num;
-		if (wlen > 1)
-			memmove(&buf[*num+1], &buf[*num], wlen-1);
-
-		buf[*num] = ichar;
-		putnstr(buf + *num, wlen);
-		(*num)++;
-		while (--wlen)
-			getcmd_putch(CTL_BACKSPACE);
-	} else {
-		/* echo the character */
-		wlen = 1;
-		buf[*num] = ichar;
-		putnstr(buf + *num, wlen);
-		(*num)++;
-	}
-}
-
-static void cread_add_str(char *str, int strsize, int insert,
-			  uint *num, uint *eol_num, char *buf, uint len)
-{
-	while (strsize--) {
-		cread_add_char(*str, insert, num, eol_num, buf, len);
-		str++;
-	}
-}
-
-int cread_line_process_ch(struct cli_line_state *cls, char ichar)
-{
-	char *buf = cls->buf;
-
-	/* ichar=0x0 when error occurs in U-Boot getc */
-	if (!ichar)
-		return -EAGAIN;
-
-	if (ichar == '\n') {
-		putc('\n');
-		buf[cls->eol_num] = '\0';	/* terminate the string */
-		return 0;
-	}
-
-	switch (ichar) {
-	case CTL_CH('a'):
-		BEGINNING_OF_LINE();
-		break;
-	case CTL_CH('c'):	/* ^C - break */
-		*buf = '\0';	/* discard input */
-		return -EINTR;
-	case CTL_CH('f'):
-		if (cls->num < cls->eol_num) {
-			getcmd_putch(buf[cls->num]);
-			cls->num++;
-		}
-		break;
-	case CTL_CH('b'):
-		if (cls->num) {
-			getcmd_putch(CTL_BACKSPACE);
-			cls->num--;
-		}
-		break;
-	case CTL_CH('d'):
-		if (cls->num < cls->eol_num) {
-			uint wlen;
-
-			wlen = cls->eol_num - cls->num - 1;
-			if (wlen) {
-				memmove(&buf[cls->num], &buf[cls->num + 1],
-					wlen);
-				putnstr(buf + cls->num, wlen);
-			}
-
-			getcmd_putch(' ');
-			do {
-				getcmd_putch(CTL_BACKSPACE);
-			} while (wlen--);
-			cls->eol_num--;
-		}
-		break;
-	case CTL_CH('k'):
-		ERASE_TO_EOL();
-		break;
-	case CTL_CH('e'):
-		REFRESH_TO_EOL();
-		break;
-	case CTL_CH('o'):
-		cls->insert = !cls->insert;
-		break;
-	case CTL_CH('w'):
-		if (cls->num) {
-			uint base, wlen;
-
-			for (base = cls->num - 1;
-			     base >= 0 && buf[base] == ' ';)
-				base--;
-			for (; base > 0 && buf[base - 1] != ' ';)
-				base--;
-
-			/* now delete chars from base to cls->num */
-			wlen = cls->num - base;
-			cls->eol_num -= wlen;
-			memmove(&buf[base], &buf[cls->num],
-				cls->eol_num - base + 1);
-			cls->num = base;
-			getcmd_putchars(wlen, CTL_BACKSPACE);
-			puts(buf + base);
-			getcmd_putchars(wlen, ' ');
-			getcmd_putchars(wlen + cls->eol_num - cls->num,
-					CTL_BACKSPACE);
-		}
-		break;
-	case CTL_CH('x'):
-	case CTL_CH('u'):
-		BEGINNING_OF_LINE();
-		ERASE_TO_EOL();
-		break;
-	case DEL:
-	case DEL7:
-	case 8:
-		if (cls->num) {
-			uint wlen;
-
-			wlen = cls->eol_num - cls->num;
-			cls->num--;
-			memmove(&buf[cls->num], &buf[cls->num + 1], wlen);
-			getcmd_putch(CTL_BACKSPACE);
-			putnstr(buf + cls->num, wlen);
-			getcmd_putch(' ');
-			do {
-				getcmd_putch(CTL_BACKSPACE);
-			} while (wlen--);
-			cls->eol_num--;
-		}
-		break;
-	case CTL_CH('p'):
-	case CTL_CH('n'):
-		if (cls->history) {
-			char *hline;
-
-			if (ichar == CTL_CH('p'))
-				hline = hist_prev();
-			else
-				hline = hist_next();
-
-			if (!hline) {
-				getcmd_cbeep();
-				break;
-			}
-
-			/* nuke the current line */
-			/* first, go home */
-			BEGINNING_OF_LINE();
-
-			/* erase to end of line */
-			ERASE_TO_EOL();
-
-			/* copy new line into place and display */
-			strcpy(buf, hline);
-			cls->eol_num = strlen(buf);
-			REFRESH_TO_EOL();
-			break;
-		}
-		break;
-	case '\t':
-		if (IS_ENABLED(CONFIG_AUTO_COMPLETE) && cls->cmd_complete) {
-			int num2, col;
-
-			/* do not autocomplete when in the middle */
-			if (cls->num < cls->eol_num) {
-				getcmd_cbeep();
-				break;
-			}
-
-			buf[cls->num] = '\0';
-			col = strlen(cls->prompt) + cls->eol_num;
-			num2 = cls->num;
-			if (cmd_auto_complete(cls->prompt, buf, &num2, &col)) {
-				col = num2 - cls->num;
-				cls->num += col;
-				cls->eol_num += col;
-			}
-			break;
-		}
-		fallthrough;
-	default:
-		cread_add_char(ichar, cls->insert, &cls->num, &cls->eol_num,
-			       buf, cls->len);
-		break;
-	}
-
-	/*
-	 * keep the string terminated...if we added a char at the end then we
-	 * want a \0 after it
-	 */
-	buf[cls->eol_num] = '\0';
-
-	return -EAGAIN;
-}
-
-void cli_cread_init(struct cli_line_state *cls, char *buf, uint buf_size)
-{
-	int init_len = strlen(buf);
-
-	memset(cls, '\0', sizeof(struct cli_line_state));
-	cls->insert = true;
-	cls->buf = buf;
-	cls->len = buf_size;
-
-	if (init_len)
-		cread_add_str(buf, init_len, 0, &cls->num, &cls->eol_num, buf,
-			      buf_size);
-}
 
 static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 		      int timeout)
@@ -484,19 +108,13 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 	}
 	*len = cls->eol_num;
 
-	if (buf[0] && buf[0] != CREAD_HIST_CHAR)
-		cread_add_to_hist(buf);
-	hist_cur = hist_add_idx;
+	cread_add_to_hist(buf);
 
 	return 0;
 }
 
 #else /* !CONFIG_CMDLINE_EDITING */
 
-static inline void hist_init(void)
-{
-}
-
 static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 		      int timeout)
 {
diff --git a/include/cli.h b/include/cli.h
index e183d5613697..bca24c8c565f 100644
--- a/include/cli.h
+++ b/include/cli.h
@@ -280,4 +280,34 @@ void cli_cread_init(struct cli_line_state *cls, char *buf, uint buf_size);
 /** cread_print_hist_list() - Print the command-line history list */
 void cread_print_hist_list(void);
 
+/**
+ * hist_prev() - Get the previous line of history
+ *
+ * Returns: Previous history line, or NULL if none
+ */
+char *hist_prev(void);
+
+/**
+ * hist_next() - Get the next line of history
+ *
+ * Returns: Next history line, or NULL if none
+ */
+char *hist_next(void);
+
+/**
+ * cread_add_to_hist() - Add a line to the history buffer
+ *
+ * The line is added if it is non-empty and doesn't start with CREAD_HIST_CHAR
+ * This also sets hist_cur to hist_add_idx whether or not anything was added
+ *
+ * @line: Line to add
+ */
+void cread_add_to_hist(char *line);
+
+#ifdef CONFIG_CMDLINE_EDITING
+void hist_init(void);
+#else
+static inline void hist_init(void) {}
+#endif
+
 #endif
-- 
2.42.0.655.g421f12c284-goog

