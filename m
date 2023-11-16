Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E18C54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3050587500;
	Thu, 16 Nov 2023 05:11:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HlQ/SDRm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF5487478; Thu, 16 Nov 2023 05:11:45 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D745F87478
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7ad501764f4so13898539f.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107901; x=1700712701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0Z7mlm4vcEPfvpi0dGWMzI0ktVwlVx/+GXWMHFVrs0=;
 b=HlQ/SDRm4uQR7TyU2ZRwrjpV2WrBosWP/w+0hLNVx8EcEWxNS2ju52KcVZxFTX9Myq
 Tu37Phn638q6l9/MtgXdfe1YtAxWSo8ee2R2vYxEkyt0T2fRQDDWSiLWOeiwmHnRjKlh
 TeP6vQV0Y74bE9N5db7M2WSzc6meB2IkU0nzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107901; x=1700712701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0Z7mlm4vcEPfvpi0dGWMzI0ktVwlVx/+GXWMHFVrs0=;
 b=moDKVAHzoS8VWZiAg3QWrjKMvXzItQxnB9kYeV+fulYaYlHL2Ooq4GCicpLQuvl2Pt
 2sh7fOJ44y5lKiAriyIbVUoRZGbYQcZwgINeFfhZU4TsKw7/qKG7ST+omvMvt8hDDa2w
 gcan2mAcaDPEqaKWu5kw7ZsvAjjR78tJ+K8v5eLdesZnJ5eYD66ZBFRC/1L/0S3u39n+
 2xNgoPVoMGLpbvB9qhV5yhTKsvljXQK0E7VnKD8uMmvLSmOF0qVYwMEWR/gUj0YPxoPF
 PdzNx+YPxOUtXd2zgHBbGFpRZSoo5H+VvG6/DtADRUJyHAFY3y1wRHG7eRv0Jvz9juOB
 uT8w==
X-Gm-Message-State: AOJu0YzZM9XwOSYVOdYIArSj86nXdVIIxNBG2+H95IVGGKNmqG+ZolmB
 vGZRE9Q3tNOwS+8idBofoKWKhbIUjOR62BuxZg6MNQ==
X-Google-Smtp-Source: AGHT+IExmqVK5RKjbYENfSeTuWpJjm18SS/V/THoC5o9Y/31TJohnLwmQNuk0MRW1QSurtCVFkluyQ==
X-Received: by 2002:a05:6602:150e:b0:787:8cf:fd08 with SMTP id
 g14-20020a056602150e00b0078708cffd08mr23356784iow.17.1700107901419; 
 Wed, 15 Nov 2023 20:11:41 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v2 25/32] bootm: Reduce arguments to boot_get_loadables()
Date: Wed, 15 Nov 2023 21:10:25 -0700
Message-ID: <20231116041043.362055-26-sjg@chromium.org>
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

