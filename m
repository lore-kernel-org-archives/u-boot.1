Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4291C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D928744F;
	Tue,  7 Nov 2023 13:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iDH9lYPp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9430C8720A; Tue,  7 Nov 2023 13:43:10 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C33087257
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5401bab7525so9623051a12.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 04:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699360988; x=1699965788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2TfLtuHZJJKrHijD28FrbrWf26Q3hKejOxabUgL/S4=;
 b=iDH9lYPpn1gnfSkAkaYY+4DpaYnB+700BnusNVV8OY1mCqkeKdED4T+PowOaJILnjR
 a99VS/fFPp23XrJ6Zk7rf72CzMdkn4Epenftjoi3c3nh/B8AjUvG6Mbtn7rzjmoA+Y8F
 pDpYU7/rdJY5fdWfcSamaxDkKXnPu26x1FoByaRPEGBa5MgEqItPNNTU7LI6tfC6ifoY
 55yjnXTaRY7xYkeJ87UgWvLV1X3pswrHa5Wt3vzet7V5lVp09mzuLjiubNTIQ937g8DM
 y8pmyfUjYwOa0eWzO5N7zDduf6HqXyXi57Bu30i+DOG8NMYsW7bnPzdTMIDdxSKD07+q
 lHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699360988; x=1699965788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2TfLtuHZJJKrHijD28FrbrWf26Q3hKejOxabUgL/S4=;
 b=sa7sf/11HQsFrRu/3PviPbHvfN0gQO0iPZsZgNv7cYlEzM+FpjpY2adruSiFUzD50S
 Q0pfdzH86LpoMd/l3+87nIOfR5mYf0XaIVOgWGFt15CVF1wzm508hH8/KVINCuiCY1LQ
 RMz+hTIII8mZ5RlKw5V4t7uwAgpInVbLiNfS7rrHjTQF3cWRim9b4XTfQwuvbRghwENU
 wAlIN5TcRZVKgOWSuyV/azI6Il3QLmausm0njaRHY95QJXaSWS1cGcClLhZJ9aVmHkbd
 aoaUlNak4HXBPPDYmQUQ0lP6KMvjNrTo9bQMz1G4E7lZ8TGIhkSxJOYqsNp0Yua/uwkD
 PB6w==
X-Gm-Message-State: AOJu0YzBang1+qeyeddAXOQA500CUtOtsXFbwIYYqfeWR8Y13cXGWcG9
 o4GZzgHvbpp00VyHnqDXyaM=
X-Google-Smtp-Source: AGHT+IExtf/msD7Sj9L7XqpC3PVeJMnuVvl0eRA0o6yglLuQImDNljcQMdS6gLGqHFPtcfGdgUpIcw==
X-Received: by 2002:a50:9e87:0:b0:53d:a1c0:410f with SMTP id
 a7-20020a509e87000000b0053da1c0410fmr24341035edf.2.1699360988089; 
 Tue, 07 Nov 2023 04:43:08 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 u16-20020a509510000000b0053e89721d4esm5481831eda.68.2023.11.07.04.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 04:43:07 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/5] fastboot: add oem console command support
Date: Tue,  7 Nov 2023 14:42:41 +0200
Message-Id: <20231107124241.35432-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231107124241.35432-1-clamor95@gmail.com>
References: <20231107124241.35432-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

"oem console" serves to read console record buffer.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 doc/android/fastboot.rst      |  1 +
 drivers/fastboot/Kconfig      |  7 +++++++
 drivers/fastboot/fb_command.c | 39 +++++++++++++++++++++++++++++++++++
 include/fastboot.h            |  1 +
 4 files changed, 48 insertions(+)

diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 1ad8a897c8..05d8f77759 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -29,6 +29,7 @@ The following OEM commands are supported (if enabled):
   with <arg> = boot_ack boot_partition
 - ``oem bootbus``  - this executes ``mmc bootbus %x %s`` to configure eMMC
 - ``oem run`` - this executes an arbitrary U-Boot command
+- ``oem console`` - this dumps U-Boot console record buffer
 
 Support for both eMMC and NAND devices is included.
 
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 837c6f1180..58b08120a4 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -241,6 +241,13 @@ config FASTBOOT_OEM_RUN
 	  this feature if you are using verified boot, as it will allow an
 	  attacker to bypass any restrictions you have in place.
 
+config FASTBOOT_CMD_OEM_CONSOLE
+	bool "Enable the 'oem console' command"
+	depends on CONSOLE_RECORD
+	help
+	  Add support for the "oem console" command to input and read console
+	  record buffer.
+
 endif # FASTBOOT
 
 endmenu
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 6f621df074..acf5971108 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -41,6 +41,7 @@ static void reboot_recovery(char *, char *);
 static void oem_format(char *, char *);
 static void oem_partconf(char *, char *);
 static void oem_bootbus(char *, char *);
+static void oem_console(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
 
@@ -108,6 +109,10 @@ static const struct {
 		.command = "oem run",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_RUN, (run_ucmd), (NULL))
 	},
+	[FASTBOOT_COMMAND_OEM_CONSOLE] = {
+		.command = "oem console",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_CONSOLE, (oem_console), (NULL))
+	},
 	[FASTBOOT_COMMAND_UCMD] = {
 		.command = "UCmd",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
@@ -159,6 +164,23 @@ void fastboot_multiresponse(int cmd, char *response)
 	case FASTBOOT_COMMAND_GETVAR:
 		fastboot_getvar_all(response);
 		break;
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_CONSOLE)
+	case FASTBOOT_COMMAND_OEM_CONSOLE:
+		char buf[FASTBOOT_RESPONSE_LEN] = { 0 };
+
+		if (console_record_isempty()) {
+			console_record_reset();
+			fastboot_okay(NULL, response);
+		} else {
+			int ret = console_record_readline(buf, sizeof(buf) - 5);
+
+			if (ret < 0)
+				fastboot_fail("Error reading console", response);
+			else
+				fastboot_response("INFO", response, "%s", buf);
+		}
+		break;
+#endif
 	default:
 		fastboot_fail("Unknown multiresponse command", response);
 		break;
@@ -503,3 +525,20 @@ static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
 	else
 		fastboot_okay(NULL, response);
 }
+
+/**
+ * oem_console() - Execute the OEM console command
+ *
+ * @cmd_parameter: Pointer to command parameter
+ * @response: Pointer to fastboot response buffer
+ */
+static void __maybe_unused oem_console(char *cmd_parameter, char *response)
+{
+	if (cmd_parameter)
+		console_in_puts(cmd_parameter);
+
+	if (console_record_isempty())
+		fastboot_fail("Empty console", response);
+	else
+		fastboot_response("MORE", response, NULL);
+}
diff --git a/include/fastboot.h b/include/fastboot.h
index d1a2b74b2f..23d26fb4be 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -37,6 +37,7 @@ enum {
 	FASTBOOT_COMMAND_OEM_PARTCONF,
 	FASTBOOT_COMMAND_OEM_BOOTBUS,
 	FASTBOOT_COMMAND_OEM_RUN,
+	FASTBOOT_COMMAND_OEM_CONSOLE,
 	FASTBOOT_COMMAND_ACMD,
 	FASTBOOT_COMMAND_UCMD,
 	FASTBOOT_COMMAND_COUNT
-- 
2.40.1

