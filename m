Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56286C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87C0D88EBB;
	Fri, 26 Apr 2024 16:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="r37cnPP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AFFE89094; Fri, 26 Apr 2024 16:14:07 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D52B885AE
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 86B4F3FAEB
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140838;
 bh=c7mCI5wQqo2GV8J9ZxNjeFoJ2PUZYvK6nJBiIMGgItg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=r37cnPP60QxRLqKg6URTK9dIkmE8yPxw4G+3WUn136MrZz4hGnP+wgDYTl899Qt1d
 QLWL/JGdYtdk+lOBb7V2S2LhobGxj0r/GDx7/jc/F8cU0cpc71yzGPdv/si7Pc3xi4
 3XiPOIp0cpXATBjRL7MeJxLqMPBTa9o+p2igjcKLO/mw4QAnS9xgDdh8TqUyTIAvtg
 wgaearspnP0f3es+j8A8k8Pq8trFsuwtJMqch2/HSBN8rfF00qIbbBxgtohOx2w8L7
 ar4j0cbuz/OPyR97skrK3GYTjnMaubp2Mw9VxZh1GMpBAmTS69/M5Rv1zTYETshQ+T
 OX9Z6BHsI8Gtw==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34a49f5a6baso1867591f8f.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140837; x=1714745637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7mCI5wQqo2GV8J9ZxNjeFoJ2PUZYvK6nJBiIMGgItg=;
 b=Jm3o1LKzDs3A6lrgqfS/87lEPf7o/shMPEHz2lZJ0fWSHeZRLWYsfD91R6z4Pym18E
 WyrjILAe3CtQjknJaRIEjpPfcR5fcTccGovBe/A2PjpEE5wiR1FUGaTVaYFM0PKV8PpX
 KR0O5eFgJ12R1kIhw8OYulqBkz7oYmVVZMyOTXKT8X/UZ6Y6SepN8w8Z3ud088oQpOw3
 SQBFDW7O5cpA5rI+o1E7YOM9s6AfN7nWVRwmwmwkqTv3IvyANZrEKilBjZ0VTdL8LEgQ
 1mH8B1dfym2zi0XEV/Db6xBKqiaATGvGwuBwGyjeucTAwtxk6pAhflJPO7/3wyjrEbCR
 hI9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtF03G2MBWnsAcOkZIZyjDOdhO/oY8I01MilPrkgS+xHCZKBhAS4pqTqamNheRKuvoNkooaG9bKgvPP/H3gukOweIUqw==
X-Gm-Message-State: AOJu0YwQKNcqcxVwv3VYDLk3T4TLVHmBFBsW39csWfswsDYL7UFCldVi
 ihR48kxX6QN9tJXEIFWHTTv9UhhVzJ8CKFapGNQhnWEIy9/X3G7egvfOJ8MSD1bnxJVTkDpj4S2
 e3FTjbSCiYPK1c9AQk5okRdbyHElvWsUK1Mh/9SMoFkDCOA415WwGCzA0emnXyNO68Mc=
X-Received: by 2002:a5d:6d8c:0:b0:343:a337:f380 with SMTP id
 l12-20020a5d6d8c000000b00343a337f380mr2955669wrs.19.1714140837131; 
 Fri, 26 Apr 2024 07:13:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDHp/vqVi/w/t9t3OONiyRa4K2UsWJ3YXiStDurKNYSSrS2DLaNEbFENxzBe3Da3Wc9P5s3w==
X-Received: by 2002:a5d:6d8c:0:b0:343:a337:f380 with SMTP id
 l12-20020a5d6d8c000000b00343a337f380mr2955634wrs.19.1714140836606; 
 Fri, 26 Apr 2024 07:13:56 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:56 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 11/14] efi_loader: move distro_efi_get_fdt_name()
Date: Fri, 26 Apr 2024 16:13:18 +0200
Message-ID: <20240426141321.232236-12-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
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
index 0ac04990b8e..ed2b517b130 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1187,4 +1187,6 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
  */
 void efi_add_known_memory(void);
 
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

