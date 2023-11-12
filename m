Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F82C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B0686FBD;
	Sun, 12 Nov 2023 01:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FX3ehxPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 349C786EB5; Sun, 12 Nov 2023 01:09:59 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916938700D
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-359045af665so13195985ab.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747779; x=1700352579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMtKGGueJZdEtlM511HL/G80ql6fcUvtR0o2DzyQn6c=;
 b=FX3ehxPkpYD4KkNg2y4lcVMOm5ZW5ex7damueZY7yETPN37euQzv7uJCl2h3rzJ/X3
 6zsKN8Kmr8Q+lPMVOVzj3qEK5mUlpzuamS19+D8OgzUn8TiyQlgYkxNzmxAhKl427QFo
 Erfk4kQtOS0kJsKsjFFNMu6GJxHbWWGUHKYhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747779; x=1700352579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GMtKGGueJZdEtlM511HL/G80ql6fcUvtR0o2DzyQn6c=;
 b=c844+1Grs89idgrUW0wKvTsLFKZl+dBZq9nWtmYkd0CMbvJ6rEe6JcPMh6lNGbRpVn
 zqkVdu+z1xsYNi5aItu0wVlqwKqm8vYaJYIf3pk7cDwlSGSfmSn818U6e/aI8LQqBvR8
 UKfMkTo3YXxW+vz7Pp3YoYZPuXsjOliVs/Wz56PUtUnn7VkGTnxb0PUbWDVtr0GLIu/S
 Dqg60qYOQnQQBim8DJHqamEFQmuQ6j9dPcKhnW4ZTOxL3pn5U7i+dtLLU8+RJdO4NXM0
 RO0wqfd1j9D0r5UPi24mZwzf9kdsDuFegKacXWWYQMlcv/QqEjQsl0eKgP4ObroCP9DQ
 HrKQ==
X-Gm-Message-State: AOJu0YzYadHQbeUhxUOpgSbpOzlW4FxqeuaUE8fNXTzvyT3QgRBQ8tfg
 EINQPpcOWxZSFPJ2Qsw7JMWufv6DME4lbuagEHqSPg==
X-Google-Smtp-Source: AGHT+IFF3HzACY9YdgpfubbXKlhAe+SUrDHSychq0m620vFGBuK07AgYGNKLB+T9yLW3JNoRaRTW/w==
X-Received: by 2002:a05:6e02:1b02:b0:359:cc15:b0b3 with SMTP id
 i2-20020a056e021b0200b00359cc15b0b3mr4940290ilv.25.1699747779081; 
 Sat, 11 Nov 2023 16:09:39 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 09/29] image: Tidy up genimg_get_kernel_addr_fit()
Date: Sat, 11 Nov 2023 17:08:54 -0700
Message-ID: <20231112000923.73568-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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
---

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
2.42.0.869.gea05f2083d-goog

