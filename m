Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14B4C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 03:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2754870DE;
	Mon, 13 Nov 2023 04:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XrbQC95v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA8E8869CA; Mon, 13 Nov 2023 04:00:17 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28A3A86DCE
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 04:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35749078a59so15133185ab.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699844412; x=1700449212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkAWaWVFcSL9sMY8FKfQOiVQhU82ds4toI3Pqe1Fds8=;
 b=XrbQC95v0xjqnU4iyWgbIVnyqahGy95liE5pcuL38pDUGrc7MxbNmHPxQzkFbQm1J3
 LUQP+WBVyBMVi8+LG+15N9GtiTzVADZ/JSZi/arn1tAtSBxe91lsIrlnSo68fqi1hCI5
 8OgJ/tbo1jwyAuMl7dqrE7ezl5zPF1WbTZLxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699844412; x=1700449212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IkAWaWVFcSL9sMY8FKfQOiVQhU82ds4toI3Pqe1Fds8=;
 b=e6BhawtJwK9FIGOvUmBSoijqrYBh63/XQbxN1DZC2cS/JcFpU1aQ3ibDlDE0VpGHx7
 yvrFLZwWG6wdRSh6gvcZvn0vDsseNlwQQagCl7CgV8NJQ17Yl7n0Lo9j9JKk3Dqax5mG
 /JdD2NlbqDH8b94nZYI/7kh6SVK8YxSEJvVYqNpcEnDxn7zB4gKYYwQSaXBfnaidcw16
 BhSN0yEaZGKKK5WN8GtBnAtjT/roT1/yovj/ZQtG0hKIEecglUZ/mffzzY8BUigHO/uq
 bfqGTxJhDNhh24kdqvuiUfXz91srgxtYhtHObrXMb0yZDLzNe4ShHl4SltuB4QlGpVw/
 6N4A==
X-Gm-Message-State: AOJu0YwWN73Z4929APOi+ItwAQmENCMOeKUn62AiMs8jGXeMdyvl+xj0
 XJQp/aQuBz9MlN0MqE9wedyYiW1gArz0LQmQH7NtUg==
X-Google-Smtp-Source: AGHT+IGGs3lCP+jlxeRvkRYqUQfxn7zniRUCcVvR63mcqMxe+zXRqMDFkW/Kw6gPJnrhqaaaH93PtQ==
X-Received: by 2002:a05:6e02:17cd:b0:35a:b184:74fb with SMTP id
 z13-20020a056e0217cd00b0035ab18474fbmr6927365ilu.9.1699844412615; 
 Sun, 12 Nov 2023 19:00:12 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a92cf50000000b0035134215863sm1350914ilr.55.2023.11.12.19.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 19:00:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 8/9] sysinfo: Allow displaying more info on startup
Date: Sun, 12 Nov 2023 19:58:28 -0700
Message-ID: <20231113030001.240020-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231113030001.240020-1-sjg@chromium.org>
References: <20231113030001.240020-1-sjg@chromium.org>
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

At present only the model name is shown on start. Some boards want to
display more information. Add some more options to allow display of the
manufacturer as well as the version and date of any prior-stage
firmware.

This is useful for coreboot, at least. If other boards have more
information to display, it is easy to add it, now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_info.c     | 72 +++++++++++++++++++++++++++++------------
 drivers/sysinfo/Kconfig |  7 ++++
 include/sysinfo.h       |  3 ++
 3 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/common/board_info.c b/common/board_info.c
index a62c04794b90..f4c385add90c 100644
--- a/common/board_info.c
+++ b/common/board_info.c
@@ -15,35 +15,65 @@ int __weak checkboard(void)
 	return 0;
 }
 
+static const struct to_show {
+	const char *name;
+	enum sysinfo_id id;
+} to_show[] = {
+	{ "Manufacturer", SYSINFO_ID_BOARD_MANUFACTURER},
+	{ "Prior-stage version", SYSINFO_ID_PRIOR_STAGE_VERSION },
+	{ "Prior-stage date", SYSINFO_ID_PRIOR_STAGE_DATE },
+	{ /* sentinel */ }
+};
+
+static int try_sysinfo(void)
+{
+	struct udevice *dev;
+	char str[80];
+	int ret;
+
+	/* This might provide more detail */
+	ret = sysinfo_get(&dev);
+	if (ret)
+		return ret;
+
+	ret = sysinfo_detect(dev);
+	if (ret)
+		return ret;
+
+	ret = sysinfo_get_str(dev, SYSINFO_ID_BOARD_MODEL, sizeof(str), str);
+	if (ret)
+		return ret;
+	printf("Model: %s\n", str);
+
+	if (IS_ENABLED(CONFIG_SYSINFO_EXTRA)) {
+		const struct to_show *item;
+
+		for (item = to_show; item->id; item++) {
+			ret = sysinfo_get_str(dev, item->id, sizeof(str), str);
+			if (!ret)
+				printf("%s: %s\n", item->name, str);
+		}
+	}
+
+	return 0;
+}
+
 int show_board_info(void)
 {
 	if (IS_ENABLED(CONFIG_OF_CONTROL)) {
-		struct udevice *dev;
-		const char *model;
-		char str[80];
 		int ret = -ENOSYS;
 
-		if (IS_ENABLED(CONFIG_SYSINFO)) {
-			/* This might provide more detail */
-			ret = sysinfo_get(&dev);
-			if (!ret) {
-				ret = sysinfo_detect(dev);
-				if (!ret) {
-					ret = sysinfo_get_str(dev,
-						      SYSINFO_ID_BOARD_MODEL,
-						      sizeof(str), str);
-				}
-			}
-		}
+		if (IS_ENABLED(CONFIG_SYSINFO))
+			ret = try_sysinfo();
 
 		/* Fail back to the main 'model' if available */
-		if (ret)
-			model = fdt_getprop(gd->fdt_blob, 0, "model", NULL);
-		else
-			model = str;
+		if (ret) {
+			const char *model;
 
-		if (model)
-			printf("Model: %s\n", model);
+			model = fdt_getprop(gd->fdt_blob, 0, "model", NULL);
+			if (model)
+				printf("Model: %s\n", model);
+		}
 	}
 
 	return checkboard();
diff --git a/drivers/sysinfo/Kconfig b/drivers/sysinfo/Kconfig
index e35f7cb17914..2030e4babc9f 100644
--- a/drivers/sysinfo/Kconfig
+++ b/drivers/sysinfo/Kconfig
@@ -8,6 +8,13 @@ menuconfig SYSINFO
 
 if SYSINFO
 
+config SYSINFO_EXTRA
+	bool "Show extra information on startup"
+	help
+	  Enable this to see extra information on startup. Normally only the
+	  model is shown, but with this option the vendor and any prior-stage
+	  firmware's version and date are shown as well.
+
 config SPL_SYSINFO
 	depends on SPL_DM
 	bool "Enable board driver support in SPL"
diff --git a/include/sysinfo.h b/include/sysinfo.h
index b140d742e93d..f2c1aa29d18e 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -46,6 +46,9 @@ enum sysinfo_id {
 
 	/* For show_board_info() */
 	SYSINFO_ID_BOARD_MODEL,
+	SYSINFO_ID_BOARD_MANUFACTURER,
+	SYSINFO_ID_PRIOR_STAGE_VERSION,
+	SYSINFO_ID_PRIOR_STAGE_DATE,
 
 	/* First value available for downstream/board used */
 	SYSINFO_ID_USER = 0x1000,
-- 
2.42.0.869.gea05f2083d-goog

