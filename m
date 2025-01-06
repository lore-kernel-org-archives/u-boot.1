Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE100E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28DA806DC;
	Mon,  6 Jan 2025 15:33:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U52zi9BA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C55BE8069D; Mon,  6 Jan 2025 15:33:26 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F0FB805E9
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a9cb8460f7so108708425ab.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174003; x=1736778803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xq6oVi3bObcGeDhlnmb2B4kBymgHmI6dBa9ZoCXfAmM=;
 b=U52zi9BAiby5YwEsycOzvBmn9IX7wCRbGpNM59hHBkebsXR0TD7N5kmpOuBdMR3vbJ
 iuk0MgjJ30m65nRiwEqvr5I0J+8xJafyQkgec9xXRTjdLmHd0sDuDotsNgSESuWO1X9c
 orfVYu8WV9SERVGVCwB/ksdzScYvurohWm8fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174003; x=1736778803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xq6oVi3bObcGeDhlnmb2B4kBymgHmI6dBa9ZoCXfAmM=;
 b=sC84mZNKDByjzZqU00TDSLktFcQQY051f+WYw3pkVeqll8KxFZ7yg1CNQFjEadW0w2
 TFdEUUtRuD7xFgKdQ5X17M1lXv7JfaENIkN7sDaht2vjvNpv38znws9NUt5CRPGkHIaF
 nI2G3mX5RiFLi7gV7DxqKMzAauGf42MLtF3Fefgtw06z1kUyjbZTwdBgjzWUnHr/9WzF
 6HBc44PzJegIKVz6abrZmQjK7pfhGaBmMmmUBwdl1eInfsIT4QAuk5Qno7LBLpiOLGVY
 vmqRUoMjAfdVj3IuWf+vvd54Zyg7bih4c76HG5rJcFQXcMx6S972WIiNWBMP8o1g+R5z
 6/KA==
X-Gm-Message-State: AOJu0YyXKK4r/A+eZybb0pZi57EmJ1Zcbm8h9Pz4659VxZK03LJMKFaL
 X4/mf3coyuN7yaU6c51GYcOKwsL2YHtT3Mdrb9N+Qxky1+qCTbYG2VUwzCXPhk6q46DYUpGe3lM
 =
X-Gm-Gg: ASbGncsYhkHsY0tQbaZZnhq5vHF/uA8fpsO7HZOhGZgzyb72A1mQtHyfUO5HUybYiQ6
 dhcaLJxttWHnR66lcClIcL4zXBxTmjFwv1qkQeeIjDneGM7uVR4mnaE/tES4B27M32prmo54vpL
 lSL2iALGL05tR46fO8lwl1AxaRtgZPBsfTk0CAVXktY2AYldyiWNfc2Dgt8pyGCOUEYSE5WVyMZ
 oPkFa+HVRDmboKaIxP9OgxjLzpGJEjmjGvmoVMDA7q1rF7n512wIWuRu/nH0RPTL27nBzM0Nqm8
 d13v+MkvcOPkmdXAfA==
X-Google-Smtp-Source: AGHT+IEUZ4hzSha48TdPeLsOLzIuWeCYdEZvyot/Q7PDZUpejHqaMzfc8jqjQD39R0zCGMO4ViCziA==
X-Received: by 2002:a05:6e02:3497:b0:3a7:e528:6f1e with SMTP id
 e9e14a558f8ab-3c2d278364cmr77862105ab.11.1736174002681; 
 Mon, 06 Jan 2025 06:33:22 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Dmitry Gerasimov <di.gerasimov@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 16/33] boot: Rename fit_image_get_data_and_size()
Date: Mon,  6 Jan 2025 07:32:12 -0700
Message-Id: <20250106143229.3023771-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

This function is really just getting the data. The size comes along for
the ride. In fact this function is only reliable way to obtain the data
for an image in a FIT, since the FIT may use external data.

Rename it to fit_image_get_data()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/image-board.c |  4 ++--
 boot/image-fit.c   | 20 +++++++++-----------
 cmd/ximg.c         |  3 +--
 include/image.h    |  4 ++--
 tools/fit_image.c  |  2 +-
 5 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index d018d790a49..8e6b2974dcf 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -1087,8 +1087,8 @@ fallback:
 			}
 
 			/* get script subimage data address and length */
-			if (fit_image_get_data_and_size(fit_hdr, noffset,
-							&fit_data, &fit_len)) {
+			if (fit_image_get_data(fit_hdr, noffset, &fit_data,
+					       &fit_len)) {
 				puts("Could not find script subimage data\n");
 				return 1;
 			}
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 4b116ba5891..e9653452eae 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -509,7 +509,7 @@ void fit_image_print(const void *fit, int image_noffset, const char *p)
 	fit_image_get_comp(fit, image_noffset, &comp);
 	printf("%s  Compression:  %s\n", p, genimg_get_comp_name(comp));
 
-	ret = fit_image_get_data_and_size(fit, image_noffset, &data, &size);
+	ret = fit_image_get_data(fit, image_noffset, &data, &size);
 
 	if (!tools_build()) {
 		printf("%s  Data Start:   ", p);
@@ -1031,14 +1031,14 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 }
 
 /**
- * fit_image_get_data_and_size - get data and its size including
+ * fit_image_get_data - get data and its size including
  *				 both embedded and external data
  * @fit: pointer to the FIT format image header
  * @noffset: component image node offset
  * @data: double pointer to void, will hold data property's data address
  * @size: pointer to size_t, will hold data property's data size
  *
- * fit_image_get_data_and_size() finds data and its size including
+ * fit_image_get_data() finds data and its size including
  * both embedded and external data. If the property is found
  * its data start address and size are returned to the caller.
  *
@@ -1046,8 +1046,8 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
  *     0, on success
  *     otherwise, on failure
  */
-int fit_image_get_data_and_size(const void *fit, int noffset,
-				const void **data, size_t *size)
+int fit_image_get_data(const void *fit, int noffset, const void **data,
+		       size_t *size)
 {
 	bool external_data = false;
 	int offset;
@@ -1432,7 +1432,7 @@ int fit_image_verify(const void *fit, int image_noffset)
 		goto err;
 	}
 	/* Get image data and data length */
-	if (fit_image_get_data_and_size(fit, image_noffset, &data, &size)) {
+	if (fit_image_get_data(fit, image_noffset, &data, &size)) {
 		err_msg = "Can't get image data/size";
 		goto err;
 	}
@@ -1781,8 +1781,7 @@ int fit_conf_find_compat(const void *fit, const void *fdt)
 			}
 
 			/* search in this config's kernel FDT */
-			if (fit_image_get_data_and_size(fit, kfdt_noffset,
-							&fdt, &sz)) {
+			if (fit_image_get_data(fit, kfdt_noffset, &fdt, &sz)) {
 				debug("Failed to get fdt \"%s\".\n", kfdt_name);
 				continue;
 			}
@@ -1941,7 +1940,7 @@ static int fit_get_data_tail(const void *fit, int noffset,
 	if (!fit_image_verify(fit, noffset))
 		return -EINVAL;
 
-	if (fit_image_get_data_and_size(fit, noffset, data, size))
+	if (fit_image_get_data(fit, noffset, data, size))
 		return -ENOENT;
 
 	if (!fit_get_desc(fit, noffset, &desc))
@@ -2197,8 +2196,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ALL_OK);
 
 	/* get image data address and length */
-	if (fit_image_get_data_and_size(fit, noffset,
-					(const void **)&buf, &size)) {
+	if (fit_image_get_data(fit, noffset, (const void **)&buf, &size)) {
 		printf("Could not find %s subimage data!\n", prop_name);
 		bootstage_error(bootstage_id + BOOTSTAGE_SUB_GET_DATA);
 		return -ENOENT;
diff --git a/cmd/ximg.c b/cmd/ximg.c
index 1c96f5a0a1f..29d7c3279b3 100644
--- a/cmd/ximg.c
+++ b/cmd/ximg.c
@@ -161,8 +161,7 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 
 		/* get subimage/external data address and length */
-		if (fit_image_get_data_and_size(fit_hdr, noffset,
-					       &fit_data, &fit_len)) {
+		if (fit_image_get_data(fit_hdr, noffset, &fit_data, &fit_len)) {
 			puts("Could not find script subimage data\n");
 			return 1;
 		}
diff --git a/include/image.h b/include/image.h
index e5241648b5e..12f52919812 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1204,8 +1204,8 @@ int fit_image_get_data_position(const void *fit, int noffset,
 int fit_image_get_data_size(const void *fit, int noffset, int *data_size);
 int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 				       size_t *data_size);
-int fit_image_get_data_and_size(const void *fit, int noffset,
-				const void **data, size_t *size);
+int fit_image_get_data(const void *fit, int noffset, const void **data,
+		       size_t *size);
 
 /**
  * fit_get_data_node() - Get verified image data for an image
diff --git a/tools/fit_image.c b/tools/fit_image.c
index 0fccfbb4ebd..caed8d5f901 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -876,7 +876,7 @@ static int fit_image_extract(
 	int ret;
 
 	/* get the data address and size of component at offset "image_noffset" */
-	ret = fit_image_get_data_and_size(fit, image_noffset, &file_data, &file_size);
+	ret = fit_image_get_data(fit, image_noffset, &file_data, &file_size);
 	if (ret) {
 		fprintf(stderr, "Could not get component information\n");
 		return ret;
-- 
2.34.1

