Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E72CC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 001108756E;
	Sat, 18 Nov 2023 22:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZEThSaQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B456187090; Sat, 18 Nov 2023 22:06:46 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC2458716D
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7b017766ac8so109222239f.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341577; x=1700946377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0Z7mlm4vcEPfvpi0dGWMzI0ktVwlVx/+GXWMHFVrs0=;
 b=ZEThSaQ/H97qfO1zHE2C4txPV2HjVNuySi/yPi+pqFmfARfDGdiEIGmW2bfN3E5mTL
 APA9wtp3rfAxOt5bSwRlMkHoi8KRM06ZY/+miHXwEl4wFV/8FrpX+wQghFky1bjUdMee
 q6J7dzuWgEm87ULqLPah7kWQ3DqSu7zn4vspA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341577; x=1700946377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0Z7mlm4vcEPfvpi0dGWMzI0ktVwlVx/+GXWMHFVrs0=;
 b=vw5fx20uBaXAe8RaHRmDPL2UkDl8/O5HWfvtdXEt7BNDQFBcgUweueLIy261Lt+lXl
 nNQWETzC0nICg/rfevDJox6x7M5AyyiMWm5BE8tcVbir4MsPZOOU8kr20t3R/IF0vzgu
 lqazTGog+Qo8/eB+X7n5a6WVOjr4Mh57Jd3MK3VSB4YKmZapyiVNlsHc9b/8rfpZlXfN
 9KpusU0g9DUIYjMREuSQxvw+ge7GAlb0M0cx92jcJvDV/lwLtobXTc6A9BgNhS1qr/7Q
 dJ25dddrP+1cIEQ1tyQeMA0wwGzBvD8aO7NMYthPyvBci5/XLehOUrJ6EQvgnFhZVK+o
 CjdA==
X-Gm-Message-State: AOJu0YxAgzmYqPXS0S7U0dDo0Gce+YMUXx8vvvlsKASsi/3AiwoBZbfW
 Kv8XiwwQkl5W/TwAykm4Re0qMoc8/RKDhWeCd37ZeQ==
X-Google-Smtp-Source: AGHT+IHmroA6hs0P+fXxR2IeNFiewuq8GRINZ7dp0dFm5qjpYHLT7ReOh3RqBd2u+grfFH1Kn0wZ6A==
X-Received: by 2002:a6b:d211:0:b0:7b0:aea8:2644 with SMTP id
 q17-20020a6bd211000000b007b0aea82644mr849177iob.8.1700341577363; 
 Sat, 18 Nov 2023 13:06:17 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v3 24/32] bootm: Reduce arguments to boot_get_loadables()
Date: Sat, 18 Nov 2023 14:05:12 -0700
Message-ID: <20231118210547.577026-25-sjg@chromium.org>
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

This function only uses two arguments. The 'arch' always has a constant
value, so drop it. This simplifies the function call.

Tidy up the function comment while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c       |  3 +--
 boot/image-board.c |  6 +++---
 include/image.h    | 24 +++++++++---------------
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index ae3fceb392da..aae097df0c7f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -563,8 +563,7 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 	}
 
 	/* find all of the loadables */
-	ret = boot_get_loadable(argc, argv, &images, IH_ARCH_DEFAULT,
-			       NULL, NULL);
+	ret = boot_get_loadable(&images);
 	if (ret) {
 		printf("Loadable(s) is corrupt or invalid\n");
 		return 1;
diff --git a/boot/image-board.c b/boot/image-board.c
index b926275ec917..bb0ca9d7f22f 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -718,8 +718,7 @@ static void fit_loadable_process(u8 img_type,
 			fit_loadable_handler->handler(img_data, img_len);
 }
 
-int boot_get_loadable(int argc, char *const argv[], struct bootm_headers *images,
-		      u8 arch, const ulong *ld_start, ulong * const ld_len)
+int boot_get_loadable(struct bootm_headers *images)
 {
 	/*
 	 * These variables are used to hold the current image location
@@ -765,7 +764,8 @@ int boot_get_loadable(int argc, char *const argv[], struct bootm_headers *images
 			fit_img_result = fit_image_load(images, tmp_img_addr,
 							&uname,
 							&images->fit_uname_cfg,
-							arch, IH_TYPE_LOADABLE,
+							IH_ARCH_DEFAULT,
+							IH_TYPE_LOADABLE,
 							BOOTSTAGE_ID_FIT_LOADABLE_START,
 							FIT_LOAD_OPTIONAL_NON_ZERO,
 							&img_data, &img_len);
diff --git a/include/image.h b/include/image.h
index 63f2bd3b3713..b89912a50f98 100644
--- a/include/image.h
+++ b/include/image.h
@@ -676,28 +676,22 @@ int boot_get_ramdisk(char const *select, struct bootm_headers *images,
 		     uint arch, ulong *rd_start, ulong *rd_end);
 
 /**
- * boot_get_loadable - routine to load a list of binaries to memory
- * @argc: Ignored Argument
- * @argv: Ignored Argument
+ * boot_get_loadable() - load a list of binaries to memory
+ *
  * @images: pointer to the bootm images structure
- * @arch: expected architecture for the image
- * @ld_start: Ignored Argument
- * @ld_len: Ignored Argument
  *
- * boot_get_loadable() will take the given FIT configuration, and look
- * for a field named "loadables".  Loadables, is a list of elements in
- * the FIT given as strings.  exe:
+ * Takes the given FIT configuration, then looks for a field named
+ * "loadables", a list of elements in the FIT given as strings, e.g.:
  *   loadables = "linux_kernel", "fdt-2";
- * this function will attempt to parse each string, and load the
- * corresponding element from the FIT into memory.  Once placed,
- * no aditional actions are taken.
  *
- * @return:
+ * Each string is parsed, loading the corresponding element from the FIT into
+ * memory.  Once placed, no additional actions are taken.
+ *
+ * Return:
  *     0, if only valid images or no images are found
  *     error code, if an error occurs during fit_image_load
  */
-int boot_get_loadable(int argc, char *const argv[], struct bootm_headers *images,
-		      uint8_t arch, const ulong *ld_start, ulong *const ld_len);
+int boot_get_loadable(struct bootm_headers *images);
 
 int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
 		       ulong *setup_start, ulong *setup_len);
-- 
2.43.0.rc0.421.g78406f8d94-goog

