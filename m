Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628DBC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 18:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C61787B28;
	Thu, 28 Dec 2023 19:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="naSTqkVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A61D879D8; Thu, 28 Dec 2023 19:02:25 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62FDA87A75
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 19:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50e835800adso2345451e87.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 10:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703786543; x=1704391343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nEO2kmexBaXs5lLihPLZiWHXXxGh6G9CrMdnSCsgTg=;
 b=naSTqkVE1TanYX2+6ez/D38qUNC84un9bhoRgXL0uZp6sHy/huuQvc+dIfV4wN0FFm
 yrVRh17wvYfFZ9J/FEAhv5NF5yVdea0QSkk27arrmKFkl+6o3Zp7dLqGA9AQh+4D/vsO
 7GEWjz/wBjoWZNPMzFln3k66LvJMwSxvyiMXebWn+PNnevu6eZlDkE51jbvwT80Tkn9c
 Wc78T7BOSGc+6cehXxYfoU3Mq/AiljLkKnOsmQtjIwdfYdn6o4dOnn3J5n8uKmJFjAqF
 0UX2B87+cfC9u48jaCFgdsiiNlxs+FSwi3fLqK7GXQjZ7xCAUhJ5kJG8CbkKF5foQQul
 LHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703786543; x=1704391343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5nEO2kmexBaXs5lLihPLZiWHXXxGh6G9CrMdnSCsgTg=;
 b=bK0x1aRZXAXUic6t8QWwSeF2B3xOlfHi34u0FOhe+7VHaxmN+FKFTJhCU9GrHF4UMS
 5jRihDUkYu9uHddbOnLLJDVLeYy8gJ6UI6YB/ErAWYlNwRVbiTS3oh3HuMI6yxvJoH7e
 CBNUXtd6/rumYb/E0E6RPOG7eNZD2fMW4XiiJrA566ZAVB+VQ7ENh94ixdbBRMn4iYiO
 YJNeeNlod2nESqObbHYTR9VFkepRnhIC/etJk3roaTMYbhigVhsf4S7igw/TdkdjVzUh
 J0x+OedTzFSmLXRENM2MezZFKRXy0ju/KZxXS3iQebNEy4PKgf3pAJAEolYHoxJm9jP+
 xrAQ==
X-Gm-Message-State: AOJu0YxjSpMF9UJeV8g+/FsbfRV1EkwBILLAqnjOAb0e2f/6OBQ2rgBO
 uu/1pjnjRO8lvOQ3FNtzj3g=
X-Google-Smtp-Source: AGHT+IFmbUaoI10T0/+zp8VCujsHoJdR3uLdhvFDJ288WHmkwAX3oWuOfsypWN7T0AZCFkYw3U8xeg==
X-Received: by 2002:ac2:4e4c:0:b0:50d:f824:959a with SMTP id
 f12-20020ac24e4c000000b0050df824959amr2556726lfr.206.1703786542400; 
 Thu, 28 Dec 2023 10:02:22 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 s4-20020a056512314400b0050e6b04a5b2sm1955101lfi.251.2023.12.28.10.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 10:02:22 -0800 (PST)
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
Subject: [PATCH v6 6/6] fastboot: add oem console command support
Date: Thu, 28 Dec 2023 20:01:54 +0200
Message-Id: <20231228180154.50473-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228180154.50473-1-clamor95@gmail.com>
References: <20231228180154.50473-1-clamor95@gmail.com>
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
index 11fc0fe1c8..5e5855a76c 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -242,6 +242,13 @@ config FASTBOOT_OEM_RUN
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

