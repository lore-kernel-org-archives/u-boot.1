Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7EDC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF733870E6;
	Sun, 12 Nov 2023 01:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="On5W9IDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07C4486F6C; Sun, 12 Nov 2023 01:10:35 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC358708A
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7ad501cb1f9so126453039f.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747791; x=1700352591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GErQbzyfcxNeUXwJQ719AyuQ0MiV+I/Xvla7C6vzAF0=;
 b=On5W9IDuwa34A6N57FYig9iYhfunFVtrUHmq+SRaWvAR6Y5RJUrEvAApYTi1HDBQWE
 opuEi0Q25joRpL3sQuwEcYqmKEg8jf0nku6gl83LA6cdPK4k7wQPZ8r4e+OQ2N0o8Zyi
 ieD/n7QZzyvujwRA0kK9g2LiSNxuKkE6AHNaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747791; x=1700352591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GErQbzyfcxNeUXwJQ719AyuQ0MiV+I/Xvla7C6vzAF0=;
 b=pznIGGO8KkkXzJg1+OOms1IhX5IMBUcYG4OfoBP98pnkT+HQ0pe706gPDQbuyFhQCA
 UhMOv2rxLkeOph/vgnslTzfgypiqDbio8hq+Rwc0TVKn9m9qekF6xDJeZ+CmXNY84TCn
 ng/1GNWsh5/BqKKswBHsIGwx8Q2gtIUYHWd3v++AHoGO8gmZZShvtQ9vd7/jrreVEazz
 JQw0q0EL4sq8POZPHIepeZ9Tc+LHaozS2jeB1fZNREN89IcpwFqVYnnZ7cd84j3iUbjU
 WkZ1HdWIldac4RuhkNtW5uUrpSK3DMiVXPmRQG0ZOti5H3hk+QfAN11p1LfJyiPPkFpL
 iUVA==
X-Gm-Message-State: AOJu0YwAcM1esXycufF4zmAQ+3bmvcxfUVRLssaiA+jDwzSRtlgRl8M5
 fbZOhmnw2USZJu1qESkH481RyZr1+zgor9JfFPAG9A==
X-Google-Smtp-Source: AGHT+IGfX65tvjcKYgMDRgXXMgbKOd1WiPdNoOgLBwZesIDeIbAw02RAQO5eZMoyYRUilrt8jSwZEg==
X-Received: by 2002:a05:6e02:15c7:b0:359:b517:9fc5 with SMTP id
 q7-20020a056e0215c700b00359b5179fc5mr4572963ilu.1.1699747791346; 
 Sat, 11 Nov 2023 16:09:51 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 23/29] bootm: Reduce arguments to boot_get_loadables()
Date: Sat, 11 Nov 2023 17:09:08 -0700
Message-ID: <20231112000923.73568-24-sjg@chromium.org>
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

This function only uses two arguments. The 'arch' always has a constant
value, so drop it. This simplifies the function call.

Tidy up the function comment while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c       |  3 +--
 boot/image-board.c |  6 +++---
 include/image.h    | 24 +++++++++---------------
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4bfa28f4377a..c71368431c48 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -562,8 +562,7 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
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
2.42.0.869.gea05f2083d-goog

