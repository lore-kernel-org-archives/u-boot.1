Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE61C27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CDA7884A4;
	Mon, 10 Jun 2024 11:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Rftxy1M/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EAAA88506; Mon, 10 Jun 2024 11:11:13 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7870F884D2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0BEA441337
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718010671;
 bh=cFomrW89UuBtMviZc3ltFvZ4RpOzSh7bcNGGKFObC9w=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Rftxy1M/TMGJYzqg134yYUlZoGbAuvPUvibKyyeLDBK7XLGkgzYcdo/k3zelAHo7s
 4CwtYbY7OMxN61QhC+CxJ9eLbK9nTBPEcmeGAGi+fY9qAY638krMM9W0of08b0tPaS
 mcxjHvx06/hy7e6G0mdA6XJm2uksdXlu5J1FrHBFGNTc/ltfQjHaxmOXqlAyNp5pG/
 EqY4CJ3ZW/7I9E+XQBy7GjTiFCjItSsNV4F8kDPVb1ne+o4ASB5+/oPAf4EBN50ygh
 JuDi597ZRAyM0N8Jr9F3GjHSXlhbUCDb4OLIHbgvOZ27jfSD5qN4z1T7K5JMQ7QE9T
 TJLbzV3mzhDvw==
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ebea9b7822so3790781fa.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718010670; x=1718615470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFomrW89UuBtMviZc3ltFvZ4RpOzSh7bcNGGKFObC9w=;
 b=FfvYdYnAI0iBCYUDVp97X/loApJmjFWd1nmmdHk7TpO21+uDv+d80154NgMUqS6xrb
 6Bp7vt2h6ySC7wJm+mGhtvbOy3iZfghKZfRq+KAEILJxjwgpc1Yv7bvIvlFtyo7M7NjX
 0X7HnP2ETvm5DYXHQZCKlilac0yH0bHDK1OcriAxncLcTd5F0bZZZUv9SKnNZbZXCFUO
 2Ra4s2piCK6yi697ie91UIy6T8QYXvV9ideYJt8jPedetXWC43glBPbXszrwuRhJbMwU
 +fqKe4uuqvx5hh6tcCpmxWeoLZxl/GOc3icIng26viC3RjT6h+wEnGzV6Dac9T1iZcBm
 FJkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIzlFHYajhKBNKkRuQ5oyK8CbQOIfrenxRBvKfiydUsuIVQ9CMXMDbLxVd8hU79VC1M8ygbcV0ue8d8APmlCiyFQKn5A==
X-Gm-Message-State: AOJu0YwaKEv6FDfnMa+lV9WePLuzJZgzjKvUQSawqGaEjajRXrrA01GD
 huJ99qKXOLH9Df4zwsO0RjRC3Dp18bjS/paLACLieG7vDKoGCVd9ZzWusiuaUKMSSXwy/e7ZiM+
 +5ldxKOWtcqFz/OEZ6fUaKFbQftv4QCU50j2kv5UNev6u3hsd6OW2aOuVQ+meHPNc6M0=
X-Received: by 2002:a2e:7a06:0:b0:2eb:dba0:6772 with SMTP id
 38308e7fff4ca-2ebdba071a5mr29199131fa.37.1718010670233; 
 Mon, 10 Jun 2024 02:11:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3U+kD2L8D+wZEKiiTaWl7/69zMY8gsE5NDFujbAQ0XG3If72PQpMBmWwnkFIYbcCHIJkQ7Q==
X-Received: by 2002:a2e:7a06:0:b0:2eb:dba0:6772 with SMTP id
 38308e7fff4ca-2ebdba071a5mr29198921fa.37.1718010669801; 
 Mon, 10 Jun 2024 02:11:09 -0700 (PDT)
Received: from workstation5.. ([2a00:20:43:88b5:6b2b:e162:4c45:5c4c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42183c08f49sm41059465e9.6.2024.06.10.02.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:11:09 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 5/9] efi_loader: move distro_efi_get_fdt_name()
Date: Mon, 10 Jun 2024 11:10:53 +0200
Message-ID: <20240610091057.64463-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v3:
	No change
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

