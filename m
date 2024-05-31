Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D722C25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 13:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37466887CA;
	Fri, 31 May 2024 15:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jsk2tDCX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED8C1887DB; Fri, 31 May 2024 15:50:55 +0200 (CEST)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83F18887BC
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-5789733769dso3786701a12.1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717163453; x=1717768253; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hw2RXhrZpIRC1LLz/VAb9tB7axGYbKL0pn4Md9US95g=;
 b=jsk2tDCXHLCHw/1yoChk5umHzQ8YV9Ej9CmD5gR6s/krzLZGpVrXcj2kxNjvWDmQ+3
 RIvurs3QzNbL4JeUmSCYJKX7KWbNwewRVCTCltrXNxW0amKfh1ysZOOG0MmWiY0jmhWS
 0Ypqp2FNMy4uTgMVSnKklmjT/QggsoQz1eiFTBPwePFNRIrliC9owvCECRQ55yoFLZYU
 3z09HuBcFedRA2HCv1G5qNX3HmiejVH2KFA3HglwaY6Ho231851yXoOOakvC61oWnuZm
 B894lyru+hZhrmWvPq1OvDnxkQiNZ+aXSe/7lSaRDvaX+MW8BmpO74Wrzi1osHjBBt1y
 NPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717163453; x=1717768253;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hw2RXhrZpIRC1LLz/VAb9tB7axGYbKL0pn4Md9US95g=;
 b=nrvkPRRII/y4qr2QXdkpjrXqxHsOIIlxrKj68N2LMuyJWjESji7YzGt1a2q9uge/ps
 +pLmMhA502kWgqirlxc14AZaOVKY4RCL6IZI0nSixgdXdCVaWK4wqVm28X78GhbNsfM4
 CEDsFr6QfM+eayBGlr4NO/uwSMbhKIwk3ZJTwqMfwCFp89wrQO3C2MCC3HUI9r+7nIft
 6yVA0feJlwNs+vi/yxA3GWF462nYLozdpaDSLQy8foNSHhyi2S8sFjaxW14BxaSdBTp8
 jsQtrsvS1XnRUi9WEmIvm3Q9TT0HY7RqiV10tfcgdTsxznLk+XYkM1iJeR1POkGKL6nJ
 ai5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM/iUL35jAx5yuz7liA6Rk0W2/1mIUnYGPXgtZxBRZGPpJCs5JyLkSxuDU+F6H5xif5dk7+VT/ncQNKQ5n4Ob2DMXP4Q==
X-Gm-Message-State: AOJu0YwzTYiKCA5QvOR7zGU5n1RsX6wr5pmkTC30Lfk7kgC0y9MHHQ82
 y6zbrsJdaHTpWwpjcFrYWyiElqvAdayGFao1zkUSKt9fDPIKqvzT8x6NOK+IMj4=
X-Google-Smtp-Source: AGHT+IELM4qQKCGIwzoXEHOtq+5bYeIP5bYIetRS/K0pd1w9i+d7cCWOgRCL2fXSTP14vs8XZQgckw==
X-Received: by 2002:a17:906:4815:b0:a65:19da:df5f with SMTP id
 a640c23a62f3a-a65f093eafemr380061466b.10.1717163452840; 
 Fri, 31 May 2024 06:50:52 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eab84a99sm89442866b.143.2024.05.31.06.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 06:50:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 31 May 2024 15:50:40 +0200
Subject: [PATCH v3 6/7] tools: add genguid tool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-b4-dynamic-uuid-v3-6-ca4a4865db00@linaro.org>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
In-Reply-To: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8102;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=T1+DS2/Ax+hg2h4lWpp9orQiYTuwChFRlmhAPl0CPzg=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmWdW0Jcn7nGPfkZoH1etfRyFNcW8EoQAUzxBFt
 /nbukbUYKiJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlnVtAAKCRAFgzErGV9k
 tgFiD/9n8VW1ZMj97ox5D87w5kgx13jKh2WHUUDs5qjhbNUUsH5a41jvA9lhZJxjVky1BCX4PgY
 1qC5vPvXNs7JoNBx5qowdZNTjMG9vh9o2cDcThQC/rSSjsxarqNz7/yyvxbC5oWME89vZ2TgAL0
 oPJL6cLXO0SERHrGQyQXyzlt7Z4aLUDR4/ndpMZnL2KBCSbj3wMDwfjSpev4aM7X48FErpBCHWA
 TcBU6GNUOdwJ/JJXpDdb+8Q+FC0FWyyb7T27RT7eGwlbvoSZrwILVd8iRUbZusvR+AIcaq3NzA6
 pCqZTzlidQzJjeB6rkYGq5FWJDLFsX53aDMOxT/5L70sg0CiM9axg9pR2ZCh6+EJWMNUczVwM/s
 TFOmkV43+rg8/BZalogV4qfaZNG7oijURCSnfhzB7++AmqGN3qeylkHNSOgv7Aukp/EnQU2QmkV
 2DUWOT4f4KIAvlHFjUQ4QwnuarpOTCnP2dKLG697Y9lDcGIoFWYROifQ7WqhfGsCPEpq0M3yQMv
 t2FbljssflcC69bj4YkQyRLF8F3+ivkKBQ8CuO5iyPgBO+YlKe4ogwmTKlDBuXGXDAn2TZXfqB6
 lfoCbCNeybdVGwlFuf4no9HAM/XePafswjfUGDdqJRNWwz8iOEu/6BqFYYpwD/alo1CYBD2DrgB
 Pn8qq07N/GF1wdw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add a tool that can generate GUIDs that match those generated internally
by U-Boot for capsule update fw_images.

Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
with the board model, compatible, and fw_image name.

This tool accepts the same inputs and will produce the same GUID as
U-Boot would at runtime.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/genguid.1   |  52 +++++++++++++++++++
 tools/Kconfig   |   7 +++
 tools/Makefile  |   3 ++
 tools/genguid.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 216 insertions(+)

diff --git a/doc/genguid.1 b/doc/genguid.1
new file mode 100644
index 000000000000..4128055b3a9a
--- /dev/null
+++ b/doc/genguid.1
@@ -0,0 +1,52 @@
+.\" SPDX-License-Identifier: GPL-2.0+
+.\" Copyright (c) 2024, Linaro Limited
+.TH GENGUID 1 "May 2024"
+
+.SH NAME
+genguid \- Generate deterministic EFI capsule image GUIDs for a board
+
+.SH SYNOPSIS
+.B genguid
+.RI GUID " " [ -vj ] " " -c " " COMPAT " " NAME...
+
+.SH "DESCRIPTION"
+The
+.B genguid
+command is used to determine the update image GUIDs for a board using
+dynamic UUIDs. The command takes a namespace GUID (defined in the boards
+defconfig), the boards first compatible string, and the names of the
+firmware images. The command will output the GUIDs for each image.
+
+As the dynamic UUID mechanism generates GUIDs at runtime, it would be
+necessary to actually boot U-Boot on the board and enable debug logs
+to retrieve the generated GUIDs. This tools just simplifies that process.
+
+.SH "OPTIONS"
+
+.TP
+.BI GUID
+The namespace/salt GUID, same as CONFIG_EFI_CAPSULE_NAMESPACE_UUID.
+The format is:
+    xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
+
+.TP
+.BI "-v\fR,\fB --verbose "
+Print additional information to stderr.
+
+.TP
+.BI "-j\fR,\fB --json "
+Output the results in JSON format (array of object with name/uuid properties).
+
+.TP
+.BI "-c\fR,\fB --compat " COMPAT
+The first entry in the boards root compatible property.
+
+.TP
+.BI NAME...
+The names of the firmware images to generate GUIDs for (e.g. "SANDBOX-UBOOT-ENV").
+
+.SH AUTHORS
+Written by Caleb Connolly <caleb.connolly@linaro.org>
+
+.SH HOMEPAGE
+https://u-boot.org
diff --git a/tools/Kconfig b/tools/Kconfig
index 667807b33173..13201ff61fd4 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -103,8 +103,15 @@ config TOOLS_MKEFICAPSULE
 	  This command allows users to create a UEFI capsule file and,
 	  optionally sign that file. If you want to enable UEFI capsule
 	  update feature on your target, you certainly need this.
 
+config TOOLS_GENGUID
+	bool "Build genguid command"
+	default y if EFI_CAPSULE_DYNAMIC_UUIDS
+	help
+	  This command allows users to generate the GUIDs that a given
+	  board would use for UEFI capsule update feature.
+
 menuconfig FSPI_CONF_HEADER
 	bool "FlexSPI Header Configuration"
 	help
 	  FSPI Header Configuration
diff --git a/tools/Makefile b/tools/Makefile
index 6a4280e3668f..29e9a93b0f24 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -253,8 +253,11 @@ HOSTLDLIBS_mkeficapsule += \
 HOSTLDLIBS_mkeficapsule += \
 	$(shell pkg-config --libs uuid 2> /dev/null || echo "-luuid")
 hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
 
+genguid-objs := generated/lib/uuid.o generated/lib/sha1.o genguid.o
+hostprogs-$(CONFIG_TOOLS_GENGUID) += genguid
+
 mkfwumdata-objs := mkfwumdata.o generated/lib/crc32.o
 HOSTLDLIBS_mkfwumdata += -luuid
 hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) += mkfwumdata
 
diff --git a/tools/genguid.c b/tools/genguid.c
new file mode 100644
index 000000000000..e71bc1d48f95
--- /dev/null
+++ b/tools/genguid.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 Linaro Ltd.
+ *   Author: Caleb Connolly
+ */
+
+#include <getopt.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/types.h>
+
+#include <uuid.h>
+
+static struct option options[] = {
+	{"dtb", required_argument, NULL, 'd'},
+	{"compat", required_argument, NULL, 'c'},
+	{"help", no_argument, NULL, 'h'},
+	{"verbose", no_argument, NULL, 'v'},
+	{"json", no_argument, NULL, 'j'},
+	{NULL, 0, NULL, 0},
+};
+
+static void usage(const char *progname)
+{
+	fprintf(stderr, "Usage: %s GUID [-v] -c COMPAT NAME...\n", progname);
+	fprintf(stderr,
+		"Generate a v5 GUID for one of more U-Boot fw_images the same way U-Boot does at runtime.\n");
+	fprintf(stderr,
+		"\nOptions:\n"
+		"  GUID                     namespace/salt GUID in 8-4-4-4-12 format\n"
+		"  -h, --help               display this help and exit\n"
+		"  -c, --compat=COMPAT      first compatible property in the board devicetree\n"
+		"  -v, --verbose            print debug messages\n"
+		"  -j, --json               output in JSON format\n"
+		"  NAME...                  one or more names of fw_images to generate GUIDs for\n"
+	);
+	fprintf(stderr, "\nExample:\n");
+	fprintf(stderr, "  %s 2a5aa852-b856-4d97-baa9-5c5f4421551f \\\n"
+			"\t-c \"qcom,qrb4210-rb2\" \\\n"
+			"\tQUALCOMM-UBOOT\n", progname);
+}
+
+static size_t u16_strsize(const uint16_t *in)
+{
+	size_t i = 0, count = UINT16_MAX;
+
+	while (count-- && in[i])
+		i++;
+
+	return (i + 1) * sizeof(uint16_t);
+}
+
+int main(int argc, char **argv)
+{
+	struct uuid namespace;
+	char *namespace_str;
+	char uuid_str[37];
+	char **image_uuids;
+	char *compatible = NULL;
+	uint16_t **images_u16;
+	char **images;
+	int c, n_images;
+	bool debug = false, json = false;
+
+	if (argc < 2) {
+		usage(argv[0]);
+		return 1;
+	}
+
+	namespace_str = argv[1];
+
+	/* The first arg is the GUID so skip it */
+	while ((c = getopt_long(argc, argv, "c:hvj", options, NULL)) != -1) {
+		switch (c) {
+		case 'c':
+			compatible = strdup(optarg);
+			break;
+		case 'h':
+			usage(argv[0]);
+			return 0;
+		case 'v':
+			debug = true;
+			break;
+		case 'j':
+			json = true;
+			break;
+		default:
+			usage(argv[0]);
+			return 1;
+		}
+	}
+
+	if (!compatible) {
+		fprintf(stderr, "ERROR: Please specify the compatible property.\n\n");
+		usage(argv[0]);
+		return 1;
+	}
+
+	if (uuid_str_to_bin(namespace_str, (unsigned char *)&namespace, UUID_STR_FORMAT_GUID)) {
+		fprintf(stderr, "ERROR: Check that your UUID is formatted correctly.\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/* This is probably not the best way to convert a string to a "u16" string */
+	n_images = argc - optind - 1;
+	images = argv + optind + 1;
+	images_u16 = calloc(n_images, sizeof(char *));
+	for (int i = 0; i < n_images; i++) {
+		images_u16[i] = calloc(1, strlen(images[i]) * 2 + 2);
+		for (int j = 0; j < strlen(images[i]); j++)
+			images_u16[i][j] = (uint16_t)images[i][j];
+	}
+
+	if (debug) {
+		fprintf(stderr, "GUID:         ");
+		uuid_bin_to_str((uint8_t *)&namespace, uuid_str, UUID_STR_FORMAT_GUID);
+		fprintf(stderr, "%s\n", uuid_str);
+		fprintf(stderr, "Compatible:  \"%s\"\n", compatible);
+		fprintf(stderr, "Images:      ");
+		for (int i = 0; i < n_images; i++)
+			fprintf(stderr, "\"%s\"%s", argv[optind + i + 1],
+				i == n_images - 1 ? "\n" : ", ");
+	}
+
+	image_uuids = calloc(n_images, sizeof(char *));
+	for (int i = 0; i < n_images; i++) {
+		struct uuid image_type_id;
+
+		gen_uuid_v5(&namespace, &image_type_id,
+			    compatible, strlen(compatible),
+			    images_u16[i], u16_strsize(images_u16[i]) - sizeof(uint16_t),
+			    NULL);
+
+		uuid_bin_to_str((uint8_t *)&image_type_id, uuid_str, UUID_STR_FORMAT_GUID);
+		image_uuids[i] = strdup(uuid_str);
+	}
+
+	if (json) {
+		printf("[\n");
+		for (int i = 0; i < n_images; i++)
+			printf("\t{\"name\": \"%s\", \"uuid\": \"%s\"}%s\n", images[i], image_uuids[i],
+			       i == n_images - 1 ? "" : ",");
+		printf("]\n");
+	} else {
+		for (int i = 0; i < n_images; i++)
+			printf("%-24s| %s\n", images[i], image_uuids[i]);
+	}
+
+	return 0;
+}
+

-- 
2.45.0

