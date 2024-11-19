Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5243FD4415D
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5C0D895C8;
	Tue, 19 Nov 2024 14:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CnBTZg8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2B78954F; Tue, 19 Nov 2024 14:19:25 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2218895B6
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a76df43746so7034665ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022361; x=1732627161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmCOKH4IHI0wPuB5igoy01CxyRIm25H6kwr336xo7yE=;
 b=CnBTZg8YrG9uAS/qfTzGnKAVWkUHtATjvBIWFCQMv5Y6fLDIk4CB3M0JI5oU95W2zT
 bEdFkHgCRcM72X0VlI3X4MR4iTh+W+8GeSQX0Ry0tq9g4l4pB3/wvx6q04KcJRUVkFAE
 sRKpZFVFC4m2sDcF9tskDDMVF5KjNfiFHDCoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022361; x=1732627161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmCOKH4IHI0wPuB5igoy01CxyRIm25H6kwr336xo7yE=;
 b=TH5o6tFNgJgKiJZDuj0CrVOWg2UoKLKUijEZgeITwFP7Ab1NgqGqHfx2MHbyPIlELS
 fbaQiTGaBHtp+k6tG0SItMqSdE1K49YUzz++viQAa+7FTM8EQNfBc71k69edmrDeEI9u
 GnMhOl+G+grNpZoofNvN0cYDrGP90x6WHQXf3g7JU2Ka21PqvQcXTgfYWCnjdZ9RqfrB
 UvjxlO51sPZrP5q6WZNxI8D/TS9SIcpR1ISNy4mNmd9HJADPIGYjYLUD9A6QcsTNA34m
 8onUOQoPgGETKUKtYrbqZDlEaT4S+u9ne6XsrpBMkv6nGUkXYmMVvObmt5+iyP0xyF9W
 njRg==
X-Gm-Message-State: AOJu0YxA7bWqRjlC4qvNgRZrBv3rkPAVFZe1CRSN2W6yNxk8R5QwKXKY
 fKA2zjgRXek7+8QfTA0roJtWEZuAtTB+aEXdJTrO3gu47G1i/r+aL0140s+gMaY6gsQ1fl2Wq2M
 =
X-Google-Smtp-Source: AGHT+IHuTAix3Y4RMeqP52fdi33QTlSWqx/oXry6jvlha51uPlbNyDAHOSlRyBnR5CH50WN/pNlqkg==
X-Received: by 2002:a05:6e02:1789:b0:3a7:6e59:33ad with SMTP id
 e9e14a558f8ab-3a76e5936dfmr53977645ab.17.1732022361608; 
 Tue, 19 Nov 2024 05:19:21 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 12/39] bootm: Allow building bootm.c without
 CONFIG_SYS_BOOTM_LEN
Date: Tue, 19 Nov 2024 06:18:17 -0700
Message-Id: <20241119131844.4078144-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

This code cannot be compiled by boards which don't have this option. Add
an accessor in the header file to avoid another #ifdef

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c    | 8 ++++----
 include/bootm.h | 8 ++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 16a43d519a8..0a1040ef923 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -633,11 +633,11 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	load_buf = map_sysmem(load, 0);
 	image_buf = map_sysmem(os.image_start, image_len);
 	err = image_decomp(os.comp, load, os.image_start, os.type,
-			   load_buf, image_buf, image_len,
-			   CONFIG_SYS_BOOTM_LEN, &load_end);
+			   load_buf, image_buf, image_len, bootm_len(),
+			   &load_end);
 	if (err) {
-		err = handle_decomp_error(os.comp, load_end - load,
-					  CONFIG_SYS_BOOTM_LEN, err);
+		err = handle_decomp_error(os.comp, load_end - load, bootm_len(),
+					  err);
 		bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
 		return err;
 	}
diff --git a/include/bootm.h b/include/bootm.h
index c471615b08c..d174f18ac18 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -89,6 +89,14 @@ struct bootm_info {
 #define bootm_x86_set(_bmi, _field, _val)
 #endif
 
+static inline ulong bootm_len(void)
+{
+#ifdef CONFIG_SYS_BOOTM_LEN
+	return CONFIG_SYS_BOOTM_LEN;
+#endif
+	return 0;
+}
+
 /**
  * bootm_init() - Set up a bootm_info struct with useful defaults
  *
-- 
2.34.1

