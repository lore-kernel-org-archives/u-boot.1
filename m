Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2D9C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7B878856C;
	Tue, 28 May 2024 16:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y6dImVrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955F18856C; Tue, 28 May 2024 16:43:55 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97DE3884D1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AC5E240071
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1716907405;
 bh=MurfGrnRmo1/UdAv+LNp7yPes5fu0QaC4/ADBSlDX+8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Y6dImVrGm6Dq0Us6oJ1CBDuz/HaXynqYLIiaGqT6qCpLdqasRUn/Vpsfuleo+/A7l
 yhpZE7+nJ5Ys+nhxWfcOIzW84X+lGsP68v7Qu2FPShey2PKhP0VrydJo1hrzZv+ocb
 fv3qBb62iDisE5SJtXOx5Pr0KJE4qnB+jzlwjzD5mrS2KZ0SptFTSl1gq+O2AInuj6
 +BibmXsGFqhGjGqlykI2eICu/90ynzTH7OaKRHxrQOp2+wKD20M/HL8coURGriurWE
 U07THD12hrOYDV3O2in/E4E8FoNNuLz9f/UcmUAH5KN98O7atXKlbSNxBS7BotIguq
 7pYkTyZiwQUSQ==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6266c774faso22405866b.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716907390; x=1717512190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MurfGrnRmo1/UdAv+LNp7yPes5fu0QaC4/ADBSlDX+8=;
 b=e3u1lsmCa9b+C+CCcyOW6LQ9mPgK82m3iHggLqjIBYjPwxBuo7yh54M0KdrZ7AQ9mJ
 LdTinVZLlvwCVp7vix1smlZ3c6pM7BD65JFKAuZGgyVjDxwsSqvvs4cN7q0DYJf+Qegv
 MtW44gYGuDBv+HTx9D646E2xoXoJUCbtTrToOsAtcexDJA2v7d8EyprLA8RTiRsTxnUL
 ALTrfWemIw4dazpq7+3WUKojPTD5LK2Kt3Z+ZsnuG3HmlLpTDpLt1540sW3GTLqLSlID
 lR3e9nmQm0rTr5ksSZnev7xWJsTa/xiAnxz5ESFp5jgDGGIGnVTTF48iKGd2qPmgkwJg
 P9vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxLismhWjcGxN4daPMRiFpu6NPE/mLwBoXYvhRpBEyCJNaKFbHzw/I4eWhruEahlq5vEKOxcJ22yNWnPvw6kaxVfersw==
X-Gm-Message-State: AOJu0YxiquCeSL9IqCrQFDw6lKP2HYhgPQT0pTpxFKnl8qOUlZJJJzgU
 SidvcFBkjPLvACX7VuCBkHbeB/y5Z+t/31N092fEpNyeigUJ21ASI+jB6Q4MPu+jVazZveHVorJ
 Rp6MAdA/gwXqRevtgKmB/BsVVjm+VUgroIaILcJrNbMbfPArnBNi9vwjKOZ6HboZU1135atuYRx
 g=
X-Received: by 2002:a50:9b1c:0:b0:572:3f41:25aa with SMTP id
 4fb4d7f45d1cf-5785194da8fmr10730341a12.11.1716907389966; 
 Tue, 28 May 2024 07:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ6vDFe/EhK6ECDOpxCDP+0DRVbpwhkDMn8KawliR4nND5vgOnf+ZSE7pQvcHPFpfnXYPtCw==
X-Received: by 2002:a50:9b1c:0:b0:572:3f41:25aa with SMTP id
 4fb4d7f45d1cf-5785194da8fmr10730316a12.11.1716907389669; 
 Tue, 28 May 2024 07:43:09 -0700 (PDT)
Received: from workstation5.. ([2a00:20:d00b:f75d:fdbe:9c2a:66b:5f2b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578f47126f0sm4914986a12.91.2024.05.28.07.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:43:09 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 5/8] efi_loader: move distro_efi_get_fdt_name()
Date: Tue, 28 May 2024 16:42:49 +0200
Message-ID: <20240528144252.179247-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
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

Move distro_efi_get_fdt_name() to a separate C module
and rename it to efi_get_distro_fdt_name().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	rebase patch
---
 boot/bootmeth_efi.c      | 60 ++-------------------------------
 include/efi_loader.h     |  2 ++
 lib/efi_loader/Makefile  |  1 +
 lib/efi_loader/efi_fdt.c | 73 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 58 deletions(-)
 create mode 100644 lib/efi_loader/efi_fdt.c

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index aebc5207fc0..40da77c497b 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -144,62 +144,6 @@ static int distro_efi_check(struct udevice *dev, struct bootflow_iter *iter)
 	return 0;
 }
 
-/**
- * distro_efi_get_fdt_name() - Get the filename for reading the .dtb file
- *
- * @fname: Place to put filename
- * @size: Max size of filename
- * @seq: Sequence number, to cycle through options (0=first)
- * Returns: 0 on success, -ENOENT if the "fdtfile" env var does not exist,
- * -EINVAL if there are no more options, -EALREADY if the control FDT should be
- * used
- */
-static int distro_efi_get_fdt_name(char *fname, int size, int seq)
-{
-	const char *fdt_fname;
-	const char *prefix;
-
-	/* select the prefix */
-	switch (seq) {
-	case 0:
-		/* this is the default */
-		prefix = "/dtb";
-		break;
-	case 1:
-		prefix = "";
-		break;
-	case 2:
-		prefix = "/dtb/current";
-		break;
-	default:
-		return log_msg_ret("pref", -EINVAL);
-	}
-
-	fdt_fname = env_get("fdtfile");
-	if (fdt_fname) {
-		snprintf(fname, size, "%s/%s", prefix, fdt_fname);
-		log_debug("Using device tree: %s\n", fname);
-	} else if (IS_ENABLED(CONFIG_OF_HAS_PRIOR_STAGE)) {
-		strcpy(fname, "<prior>");
-		return log_msg_ret("pref", -EALREADY);
-	/* Use this fallback only for 32-bit ARM */
-	} else if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)) {
-		const char *soc = env_get("soc");
-		const char *board = env_get("board");
-		const char *boardver = env_get("boardver");
-
-		/* cf the code in label_boot() which seems very complex */
-		snprintf(fname, size, "%s/%s%s%s%s.dtb", prefix,
-			 soc ? soc : "", soc ? "-" : "", board ? board : "",
-			 boardver ? boardver : "");
-		log_debug("Using default device tree: %s\n", fname);
-	} else {
-		return log_msg_ret("env", -ENOENT);
-	}
-
-	return 0;
-}
-
 /*
  * distro_efi_try_bootflow_files() - Check that files are present
  *
@@ -241,7 +185,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 	ret = -ENOENT;
 	*fname = '\0';
 	for (seq = 0; ret == -ENOENT; seq++) {
-		ret = distro_efi_get_fdt_name(fname, sizeof(fname), seq);
+		ret = efi_get_distro_fdt_name(fname, sizeof(fname), seq);
 		if (ret == -EALREADY)
 			bflow->flags = BOOTFLOWF_USE_PRIOR_FDT;
 		if (!ret) {
@@ -340,7 +284,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	sprintf(file_addr, "%lx", fdt_addr);
 
 	/* We only allow the first prefix with PXE */
-	ret = distro_efi_get_fdt_name(fname, sizeof(fname), 0);
+	ret = efi_get_distro_fdt_name(fname, sizeof(fname), 0);
 	if (ret)
 		return log_msg_ret("nam", ret);
 
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 1236eecff0f..1b4bc987a23 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1199,4 +1199,6 @@ efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
 				     struct efi_device_path *initrd_dp,
 				     struct efi_device_path *fdt_dp);
 
+int efi_get_distro_fdt_name(char *fname, int size, int seq);
+
 #endif /* _EFI_LOADER_H */
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 034e366967f..2af6f2066b5 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -59,6 +59,7 @@ obj-y += efi_device_path.o
 obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_device_path_to_text.o
 obj-$(CONFIG_EFI_DEVICE_PATH_UTIL) += efi_device_path_utilities.o
 obj-y += efi_dt_fixup.o
+obj-y += efi_fdt.o
 obj-y += efi_file.o
 obj-$(CONFIG_EFI_LOADER_HII) += efi_hii.o
 obj-y += efi_image_loader.o
diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
new file mode 100644
index 00000000000..0edf0c1e2fc
--- /dev/null
+++ b/lib/efi_loader/efi_fdt.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Bootmethod for distro boot via EFI
+ *
+ * Copyright 2021 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <efi_loader.h>
+#include <env.h>
+#include <errno.h>
+#include <log.h>
+#include <string.h>
+#include <vsprintf.h>
+
+/**
+ * distro_efi_get_fdt_name() - get the filename for reading the .dtb file
+ *
+ * @fname:	buffer for filename
+ * @size:	buffer size
+ * @seq:	sequence number, to cycle through options (0=first)
+ *
+ * Returns:
+ * 0 on success,
+ * -ENOENT if the "fdtfile" env var does not exist,
+ * -EINVAL if there are no more options,
+ * -EALREADY if the control FDT should be used
+ */
+int efi_get_distro_fdt_name(char *fname, int size, int seq)
+{
+	const char *fdt_fname;
+	const char *prefix;
+
+	/* select the prefix */
+	switch (seq) {
+	case 0:
+		/* this is the default */
+		prefix = "/dtb";
+		break;
+	case 1:
+		prefix = "";
+		break;
+	case 2:
+		prefix = "/dtb/current";
+		break;
+	default:
+		return log_msg_ret("pref", -EINVAL);
+	}
+
+	fdt_fname = env_get("fdtfile");
+	if (fdt_fname) {
+		snprintf(fname, size, "%s/%s", prefix, fdt_fname);
+		log_debug("Using device tree: %s\n", fname);
+	} else if (IS_ENABLED(CONFIG_OF_HAS_PRIOR_STAGE)) {
+		strcpy(fname, "<prior>");
+		return log_msg_ret("pref", -EALREADY);
+	/* Use this fallback only for 32-bit ARM */
+	} else if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)) {
+		const char *soc = env_get("soc");
+		const char *board = env_get("board");
+		const char *boardver = env_get("boardver");
+
+		/* cf the code in label_boot() which seems very complex */
+		snprintf(fname, size, "%s/%s%s%s%s.dtb", prefix,
+			 soc ? soc : "", soc ? "-" : "", board ? board : "",
+			 boardver ? boardver : "");
+		log_debug("Using default device tree: %s\n", fname);
+	} else {
+		return log_msg_ret("env", -ENOENT);
+	}
+
+	return 0;
+}
-- 
2.43.0

