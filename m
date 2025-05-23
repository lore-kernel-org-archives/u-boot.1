Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20F9C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 523A4832A4;
	Fri, 23 May 2025 15:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nIjun1k6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B086283236; Fri, 23 May 2025 15:08:02 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A58B283285
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a375888297so564796f8f.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748005679; x=1748610479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6o4E3jNXkQa29/NDXM8umJGqTLTyNKlCj1RvLjADnk=;
 b=nIjun1k6IzKcVKrMZ2HMFgfaQyx3ufVG+htNDu4/ZoWVFbihAgG8rxzGvP6389cHJb
 C7zKSdUkRkytz4O/BkV6JlTqMEayw7yvjJk7t+dghegokCI8WsKYx1g3YSDHFgJa5gcH
 /OZihQKOUr0Oi0hB6cVsCQS6ml01pU9Xfra64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748005679; x=1748610479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6o4E3jNXkQa29/NDXM8umJGqTLTyNKlCj1RvLjADnk=;
 b=CEF/0ZMR82RZcGreJjb4dV42SzYvPh5BvVvAy9Qeh3XvPoxokUrJ0G6HjJFQHgZm1r
 B7VIRy+s5z1DFRRXbJwNSGwlf8j4kX0XbzU4Q5vosCcLQP7ZdYEgtFhDLKLZCzj/dXic
 Rx9bK4uwuYhLuTfAbiBq8gOJtoHms+JobnHo5YcbsAIWMHpiDp14AH6u7X8BkAxVsG9A
 7J2qhPE9GG46rWK2kir02+RbMy7V7cTQ8eM6cZ0+6V4DllxH+lsHty/hbKJ0vKNAdKDO
 C2aJhkJtaIe12kJ6Fnga29LnpAKUpahhmAbldysLJmCIs2uVzNi7pV2h4T3UAretC2R0
 yQNw==
X-Gm-Message-State: AOJu0YwlvVdU8RZ82dLJQg4upgyIRSBrnPMmQSjw4fyhAIEmCRhYtrk5
 OtSRAU6zJwEczwlufAtJPqHLJJqKgB31pkdcZpFlVjoDUdDQA2JTKW4qH6D3d37Em6BlSkLnRbJ
 rnqY1Fwx7
X-Gm-Gg: ASbGnct33EHB5rO6r2jAJixaycYGxEIMigjokeOtO3i0RRb32UZsJnKYrndsI+Ho1UQ
 NXBcyKRGitZ2c9i2V7EA2Ed+MW1NVbyLJEac6qaqYZ9I0cq/JNqleVM/g1RiAFIrSRaOjSYk20q
 4wHD4MPltO8CmJ5fRC5ibYWvoVDS2fbAJ25AeWbkclOcVWrVsmqUkqUCevghCArkeAwOauXTc0s
 3bx9pSat1oDmSw8Qdh6ZgERTQfCXl+Rq5BuwArl8cIXvdk/yBohjZF/ZiyOxNqPyyvUJ0oQ+7Fs
 9bXJ063RDINlhKoVP8m2NnJdfRA14CH9VlknM5eArfuWgAcz2pzT2GS/1nDne4Yut0VR0qE=
X-Google-Smtp-Source: AGHT+IGPRAif1uEVV/PPzonL7NGyeloeXjF0FY36lHyeUOMLeyoVqPTZnvHrEwAcA2iLnOltraweYQ==
X-Received: by 2002:a5d:64c6:0:b0:3a4:c71a:8119 with SMTP id
 ffacd0b85a97d-3a4c71a81f3mr845782f8f.25.1748005679307; 
 Fri, 23 May 2025 06:07:59 -0700 (PDT)
Received: from chromium.org (82-132-216-100.dab.02.net. [82.132.216.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm12109241f8f.100.2025.05.23.06.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 06:07:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/10] efi: Move FDT-filename discovery into lib/efi
Date: Fri, 23 May 2025 14:06:45 +0100
Message-ID: <20250523130651.1329593-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523130651.1329593-1-sjg@chromium.org>
References: <20250523130651.1329593-1-sjg@chromium.org>
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

Move efi_get_distro_fdt_name() into lib/efi so it can be used from the
app.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---

 lib/efi/basename.c       | 62 +++++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_fdt.c | 63 ----------------------------------------
 2 files changed, 62 insertions(+), 63 deletions(-)

diff --git a/lib/efi/basename.c b/lib/efi/basename.c
index a01cdf1f5fa..b747dffad1d 100644
--- a/lib/efi/basename.c
+++ b/lib/efi/basename.c
@@ -89,3 +89,65 @@ int efi_get_pxe_arch(void)
 
 	return -EINVAL;
 }
+
+/**
+ * efi_get_distro_fdt_name() - get the filename for reading the .dtb file
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
+	case 3:
+		prefix = "/dtbs";
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
diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
index bfaa9cfc207..bd7cf454471 100644
--- a/lib/efi_loader/efi_fdt.c
+++ b/lib/efi_loader/efi_fdt.c
@@ -11,73 +11,10 @@
 #include <efi_device_path.h>
 #include <efi_loader.h>
 #include <env.h>
-#include <errno.h>
 #include <log.h>
 #include <string.h>
 #include <vsprintf.h>
 
-/**
- * efi_get_distro_fdt_name() - get the filename for reading the .dtb file
- *
- * @fname:	buffer for filename
- * @size:	buffer size
- * @seq:	sequence number, to cycle through options (0=first)
- *
- * Returns:
- * 0 on success,
- * -ENOENT if the "fdtfile" env var does not exist,
- * -EINVAL if there are no more options,
- * -EALREADY if the control FDT should be used
- */
-int efi_get_distro_fdt_name(char *fname, int size, int seq)
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
-	case 3:
-		prefix = "/dtbs";
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
 /**
  * efi_load_distro_fdt() - load distro device-tree
  *
-- 
2.43.0

