Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AF1C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DF62874F6;
	Sat, 18 Nov 2023 22:06:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J9iejJoZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 120878713D; Sat, 18 Nov 2023 22:06:16 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CDA78716D
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7a94c550cc8so109837939f.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341563; x=1700946363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrF7Q8TCMDKRnOL5LGk+Cx5POu6ADwXwQcYQzbEq7uE=;
 b=J9iejJoZRREMt1dsEBfuwAIobq7sjFK3F2nyGNyMaxNT7frM0mO/ZR209yo66okppo
 +xy40ce0CLP01m9RDBFHgXC9hriO1rowF8vkBsS1k44l+4+TaGpU0l+MVksDGOImkuRG
 W0Ai/BE77r1edHa1IqJggNWa0IGrbD576zG2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341563; x=1700946363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrF7Q8TCMDKRnOL5LGk+Cx5POu6ADwXwQcYQzbEq7uE=;
 b=dIa1if1CnC8qWDcmOh1SvTQUPCfb16oJTv3v35C6iIR3+MFjFTn/5/8iVhF7ZQ/jBc
 5LUrvje2rJ8y4qTc74yhuiUmGZFMYfZrSes6V9Gzdd9a/taMKhwNwdwF0h0o029TT/wv
 058ZAbQImQMHfkpLfAjeP2bHkkzmNyg4pkTqdjnJ7UWj9oBptY4k9zmrQvpm4O66ZPBw
 Y0oEDX21fME3fqHsi9vXbYgJKkThn7XGJIEooR3OsGzKMa19woYh0qSudEYaPzvbVhYf
 14aO2Y6PrHZyQil3kb/toMhvsBLc5eG1MCXsT9iOXNKPgZ1hRLwNwpqgmyY4k44UBwAp
 byqQ==
X-Gm-Message-State: AOJu0YyXs7XeUNp+/8melF3HcIhgpl4X98qjh8j655YjVDtfYXtszobj
 HFZuy01w64bOhO8wEUyD3y0/9Jr5V5Cnv2sF3iJCzA==
X-Google-Smtp-Source: AGHT+IGq+H8jEB8qq8wEE/UyQhgwRalxdnlQ2XLZu/PHguaZV4IZSLb9UZHkp+zrAZc02GZEthiZZA==
X-Received: by 2002:a05:6602:b8b:b0:7a9:61fa:9605 with SMTP id
 fm11-20020a0566020b8b00b007a961fa9605mr4170103iob.5.1700341563650; 
 Sat, 18 Nov 2023 13:06:03 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v3 09/32] image: Tidy up genimg_get_kernel_addr_fit()
Date: Sat, 18 Nov 2023 14:04:57 -0700
Message-ID: <20231118210547.577026-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

This function does not modify its first argument, so mark it const. Also
move the comments to the header file and expand them to provide more
useful information.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c       |  3 +--
 boot/image-board.c | 17 +----------------
 include/image.h    | 29 ++++++++++++++++++++++++++---
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 598f880d86dd..e323c8b758e9 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -122,8 +122,7 @@ static const void *boot_get_kernel(struct cmd_tbl *cmdtp, int flag, int argc,
 #endif
 	ulong		img_addr;
 	const void *buf;
-	const char	*fit_uname_config = NULL;
-	const char	*fit_uname_kernel = NULL;
+	const char *fit_uname_config = NULL, *fit_uname_kernel = NULL;
 #if CONFIG_IS_ENABLED(FIT)
 	int		os_noffset;
 #endif
diff --git a/boot/image-board.c b/boot/image-board.c
index d500da1b4b91..062c76badecc 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -198,22 +198,7 @@ void memmove_wd(void *to, void *from, size_t len, ulong chunksz)
 	}
 }
 
-/**
- * genimg_get_kernel_addr_fit - get the real kernel address and return 2
- *                              FIT strings
- * @img_addr: a string might contain real image address
- * @fit_uname_config: double pointer to a char, will hold pointer to a
- *                    configuration unit name
- * @fit_uname_kernel: double pointer to a char, will hold pointer to a subimage
- *                    name
- *
- * genimg_get_kernel_addr_fit get the real kernel start address from a string
- * which is normally the first argv of bootm/bootz
- *
- * returns:
- *     kernel start address
- */
-ulong genimg_get_kernel_addr_fit(char * const img_addr,
+ulong genimg_get_kernel_addr_fit(const char *const img_addr,
 				 const char **fit_uname_config,
 				 const char **fit_uname_kernel)
 {
diff --git a/include/image.h b/include/image.h
index 2e3cf839ee36..798c5f9c16e4 100644
--- a/include/image.h
+++ b/include/image.h
@@ -612,9 +612,32 @@ int boot_get_setup(struct bootm_headers *images, uint8_t arch, ulong *setup_star
 #define IMAGE_FORMAT_FIT	0x02	/* new, libfdt based format */
 #define IMAGE_FORMAT_ANDROID	0x03	/* Android boot image */
 
-ulong genimg_get_kernel_addr_fit(char * const img_addr,
-			         const char **fit_uname_config,
-			         const char **fit_uname_kernel);
+/**
+ * genimg_get_kernel_addr_fit() - Parse FIT specifier
+ *
+ * Get the real kernel start address from a string which is normally the first
+ * argv of bootm/bootz
+ *
+ * These cases are dealt with, based on the value of @img_addr:
+ *    NULL: Returns image_load_addr, does not set last two args
+ *    "<addr>": Returns address
+ *
+ * For FIT:
+ *    "[<addr>]#<conf>": Returns address (or image_load_addr),
+ *	sets fit_uname_config to config name
+ *    "[<addr>]:<subimage>": Returns address (or image_load_addr) and sets
+ *	fit_uname_kernel to the subimage name
+ *
+ * @img_addr: a string might contain real image address (or NULL)
+ * @fit_uname_config: Returns configuration unit name
+ * @fit_uname_kernel: Returns subimage name
+ *
+ * Returns: kernel start address
+ */
+ulong genimg_get_kernel_addr_fit(const char *const img_addr,
+				 const char **fit_uname_config,
+				 const char **fit_uname_kernel);
+
 ulong genimg_get_kernel_addr(char * const img_addr);
 int genimg_get_format(const void *img_addr);
 int genimg_has_config(struct bootm_headers *images);
-- 
2.43.0.rc0.421.g78406f8d94-goog

