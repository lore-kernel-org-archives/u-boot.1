Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A2FC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B419874AA;
	Thu, 16 Nov 2023 05:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HsyE2uhB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC588749B; Thu, 16 Nov 2023 05:11:31 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A7487498
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-35937f2fadeso1578245ab.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107887; x=1700712687; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrF7Q8TCMDKRnOL5LGk+Cx5POu6ADwXwQcYQzbEq7uE=;
 b=HsyE2uhBhIkf59EsHfHFSlVsFQpxTABXSX7ZBXdMLkADPL9JKKOL+Ns9rGBMhsE3lP
 qUxmT4GKH4ERjEh2RabK1Zi4i/7b118c0T778EbESW9X0XpAyKe0o1yknqdgqMCbsw+Y
 axQfNAyPi8g8wnWm0cOAvB+TIr7ZxSjLBb88E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107887; x=1700712687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrF7Q8TCMDKRnOL5LGk+Cx5POu6ADwXwQcYQzbEq7uE=;
 b=Wj8V4Pxc71mlbPAiv1aONxMP6ujrUQVApDcKuTIT+PSonYhhaG5+rmU7SeDvoruK+C
 LH8EJD+Brmeqy2Jgu0+N9y+aQFOwZgata+b81vBI5XlxansrBkdy9M9xnADwqTSLnAWe
 g4vToP0KtwYwqJiF0Ifzl3IVCBPg1H4RSMyK0DMvIOKd5cYKTTJiSWKrhVyKOoK8R1k9
 s9ZKDMhKmLyuptl4s0KrLY7lHACV4kdpDmj/FUmY1W742FG1jZqQ8YQxRHGiC/lZg1KX
 UexKJk+W5S5BGmn/W17Qh9xsfJl23mSiXyYpffjQn0EQfPStz2FFc9LccD7O2gauhRBi
 +t7Q==
X-Gm-Message-State: AOJu0Yzm3NijKZIv3JYgHQtYILzNjVdyj8pAf1DD9Whdd5KyEuURQOIi
 RBlQfULp7gp5F4Msogkim7rsufAtOaTkE7ds+/oRZw==
X-Google-Smtp-Source: AGHT+IEkVWBBnvDc9ThA+foN8QpouyfADo5NYgDqy72orRAyZwehAUbvtfwHYtTr3TaXstsQWdBpXg==
X-Received: by 2002:a05:6e02:178f:b0:359:5d4b:ea2d with SMTP id
 y15-20020a056e02178f00b003595d4bea2dmr18752729ilu.16.1700107887794; 
 Wed, 15 Nov 2023 20:11:27 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v2 10/32] image: Tidy up genimg_get_kernel_addr_fit()
Date: Wed, 15 Nov 2023 21:10:10 -0700
Message-ID: <20231116041043.362055-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

