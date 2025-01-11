Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909D1E7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0014801B0;
	Sat, 11 Jan 2025 01:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HuiAL8d5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE14D8070D; Sat, 11 Jan 2025 01:01:22 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ABDE801B0
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a8160382d4so6920365ab.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553678; x=1737158478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C9COGhnawuQGY2Qc4IAic0hrmnOzz60vamUjleRXnI4=;
 b=HuiAL8d59fokQQM+zxUpp91sPJxZAPtQdK0SdFhGchVx3Y7wgDwV61kLsXkv1nwQlC
 QpH/sngdDN9gtmS6PGkfsdPFNdDF4iZYKZu7d9OqLjdT5vZNk2Vo91irtIRsYPwSFq3B
 RLojvTQtKXfppDkRWkG5JzTGTlycARvB69Hgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553678; x=1737158478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C9COGhnawuQGY2Qc4IAic0hrmnOzz60vamUjleRXnI4=;
 b=AqCXaFWAZ9SSiqbjPhC5TLhjWb9SpRPdhbFly4DNCvYxsLh1yu1tftTSCi251LrEF9
 JtXR7oQTFNNOz9LeDlrKXJXcnGz0RTb6uBsnibfAEfFZ+8Ia/ANLcghJaolXOq4qUG87
 yhwnJEXApuPpQ3uUggkHVw62YgE9Nl72bH6aSu2Tocuvclal6SGNKRtrlKclmRGfOcGk
 6Di3H+668Jcu9llsvK3Zi5blB6EF7bnZu+Yjj4h2qlghCCaNM/87RYGRj5O9ZUXGw1yH
 gOKGPkojMWGCGTqtbOXOV6bPmuK1GcHWvOWsBGzd3fwPM/Umbmg9p8rqvQDuoIsRDzKt
 ffTA==
X-Gm-Message-State: AOJu0YxCMGbINu0Re2e/u4/cmxeAZuDDi1y2TWqFPeVC8Fv72afYKX+u
 /YcxICO8gnhby//D0RSH2c3/C2JC8DhvTO0f8nPO2gujrz/kXKVvY12PgbN8lbk3hXUpVlJ7CYI
 =
X-Gm-Gg: ASbGncsXFu+QQ9/sTMKtS2dU19D/koQ0sbmcPlDzSM6iippW5tx3XNCWbiCnJt/woGU
 deojhvN47WvQyt0UcZ9QdZNsL9l1f9upSWwCA3oC/i4o79exR6yt0t09ei37FiP/jZEtO4QqMRn
 AfzxTERSW78KzL1OTQu5IzKaRruj+qljAtRVgfO64qSN6zdKDZgX4herja4seu/Jd42Ls/ZiGVK
 QCYCTV2MGPD6RbmR5WNFcRAAzf6HdNHCCtIV2Fi4vsQSoMQAxM2UszJP+OP4bRrXKiXQ3NOrl3C
 dUSPQH4mVTrnBYDNYA==
X-Google-Smtp-Source: AGHT+IFIwf0g+I4jS7AUBD4AbPryLxxcKvj8KKI6V1mmQxoIIKIHHNfZFsqi14793kknqZ+MwqH7mw==
X-Received: by 2002:a05:6e02:23c8:b0:3a7:a3a4:2d4b with SMTP id
 e9e14a558f8ab-3ce3a9d07fdmr94942635ab.14.1736553678598; 
 Fri, 10 Jan 2025 16:01:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:17 -0800 (PST)
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
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 14/30] boot: Rename fit_image_get_data_and_size()
Date: Fri, 10 Jan 2025 17:00:13 -0700
Message-Id: <20250111000029.245022-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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
index 7ad6e51d8ed..70080d1a6c0 100644
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
@@ -2198,8 +2197,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
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
index d09851eb9f0..bebc2a16035 100644
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
  * fit_image_get_phase() - Get the phase from a FIT image
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

