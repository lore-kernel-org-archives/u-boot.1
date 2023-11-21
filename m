Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA19C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 18:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C9287625;
	Tue, 21 Nov 2023 19:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TVrzctQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0DCE875A9; Tue, 21 Nov 2023 19:35:42 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8D58761C
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 19:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5079f3f3d7aso8318045e87.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 10:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700591740; x=1701196540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D5OpGccGDk4G9w//TcyZ+0Hv7+AwqRi/8rkPNklvjE4=;
 b=TVrzctQnyVUU7NN7q+T3ZpLWeEQCv0Hhpzsuj7O6S+P4J8OlFd+fLbecBsczVE5zsv
 lxHfElKTg/XlUn6GjaYG/ibLrK1YTDxY0M+yL6vRjFY4gc9u+Gy3L+arV/8KRUgAwGVA
 T/Dv7XqzcbN5AyqyBDzKRfIBp+U+H0IQzUhVEvG06jaH4VS4buHcqo1ZyYaA3L5lxr61
 PtW2Fb//Ppxsx5x3cRHLd7/fPypYfrC7wMio4alCgO3ZjXlZBHIiIYrpmjeXja/uqQTA
 lk1/PYDg57J/bhvmA8rMZHiNowo3W6T0f7AQ82mr4nCHasmL5fxwsWi79f6pFv+sznY0
 dn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700591740; x=1701196540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5OpGccGDk4G9w//TcyZ+0Hv7+AwqRi/8rkPNklvjE4=;
 b=N1GkPUzJw3Ql3FRgMhmt8sSRyjnnuNzKh0NrPjKN2HyVGCTNXe7mt5+wgPL4bpMS36
 UCCdgTtsswvlkVEwRYaUdiXUihtWBAGUZFwtcwqmW/vnC0tYiWoDHusHb3eeEXwouTOx
 HkMpwUdoeAXWcItDiZ5ZkD79oZqHlYbRkgd87cz8hohctETs8ygLi21J47fAeT8+uSKH
 Gjvl06PZdA6DfiUEAI8JmVuRYwQpLjNk5FmV28E4hMWiH5DzJA7dld8AV3e0wAqxu96j
 0DVTvSoXRpL37NOzBumUqKHltEUzT9LfElnoud7rNqnoelL0LVRG8c2wFwVTReVDsWR6
 V8rg==
X-Gm-Message-State: AOJu0YyA+9jdEA/ise6y4HXzKL1BWU/gY4/MbGoio4mSOP9L7Ai/nUPK
 Mn6rBfKlN4fcpiC1AMgVoxE=
X-Google-Smtp-Source: AGHT+IEEU02Yf67/0ea/vV0aYtel3OJFFb6mywhcyqKuL3AL+qHD3Q7pxeTF+OJfnoGYBOiLoawH8Q==
X-Received: by 2002:a05:6512:e94:b0:50a:a6e2:ae73 with SMTP id
 bi20-20020a0565120e9400b0050aa6e2ae73mr57577lfb.44.1700591739429; 
 Tue, 21 Nov 2023 10:35:39 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 a22-20020ac25e76000000b0050089b26ea1sm1592862lfr.276.2023.11.21.10.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 10:35:39 -0800 (PST)
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
Subject: [PATCH v3 5/5] fastboot: add oem console command support
Date: Tue, 21 Nov 2023 20:35:10 +0200
Message-Id: <20231121183510.6451-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121183510.6451-1-clamor95@gmail.com>
References: <20231121183510.6451-1-clamor95@gmail.com>
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
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
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
index 6f621df074..f95f4e4ae1 100644
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
+	case FASTBOOT_COMMAND_OEM_CONSOLE:
+		if (CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_CONSOLE)) {
+			char buf[FASTBOOT_RESPONSE_LEN] = { 0 };
+
+			if (console_record_isempty()) {
+				console_record_reset();
+				fastboot_okay(NULL, response);
+			} else {
+				int ret = console_record_readline(buf, sizeof(buf) - 5);
+
+				if (ret < 0)
+					fastboot_fail("Error reading console", response);
+				else
+					fastboot_response("INFO", response, "%s", buf);
+			}
+			break;
+		}
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
+		fastboot_response(FASTBOOT_MULTIRESPONSE_START, response, NULL);
+}
diff --git a/include/fastboot.h b/include/fastboot.h
index 59cbea61ec..1e7920eb91 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -47,6 +47,7 @@ enum {
 	FASTBOOT_COMMAND_OEM_PARTCONF,
 	FASTBOOT_COMMAND_OEM_BOOTBUS,
 	FASTBOOT_COMMAND_OEM_RUN,
+	FASTBOOT_COMMAND_OEM_CONSOLE,
 	FASTBOOT_COMMAND_ACMD,
 	FASTBOOT_COMMAND_UCMD,
 	FASTBOOT_COMMAND_COUNT
-- 
2.40.1

