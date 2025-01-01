Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C38EE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A818031D;
	Wed,  1 Jan 2025 23:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dLr0zcEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8474C80352; Wed,  1 Jan 2025 23:12:12 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A9A80317
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21680814d42so126276465ad.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769527; x=1736374327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAWZ5iuX+YZxh+v6pMWT33BtwStQQ2/lSDcpHU6MNoE=;
 b=dLr0zcEjUgYRXpz8CGRAZXpcRtqzd5TFKleI93IEyzERD8mtE/K6RDjcRZtfeZ7TDF
 gH24uOZlEubxqWQx3xcMIa/LbRbYwtFv0p4n3x3Sz173XjNzR2z6Xpvp9jh+Xax3LPTY
 doWnUv/TzuXlfql6yeeR8XoBiNs/wihOchjBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769527; x=1736374327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAWZ5iuX+YZxh+v6pMWT33BtwStQQ2/lSDcpHU6MNoE=;
 b=S6hR2IWrhRutCi2Iwr/Y6VWKEEs7/JYVBBzxKA+KxcpuIeZkx+TO8EU1qQ1H2Lurux
 BbWre5HhcPx06ju/jSXbwd/92wp37dsoC1z1Ipn9Cw9vHrejLpkvVn4uvJIQTBS1Xe/2
 C69Dl4ceHcZ+z+6n2RooB7SiHHxfvIYzcTeDX/PzY4d6+96f5Qm9vpbvrgFstuBY4B7/
 Yu4aBNyuci1McQyQQrj4fPiVczeM+XqCt/g/btXVBVcpbKkfxiIzl39FqoBBDHSbwYTb
 AOiphpb5FMUEw6WyeZ3S4d3mefQcsM74DgRnA20pBrm4XwXuWYvnI85P3i/bNk1NjUVH
 9Dbw==
X-Gm-Message-State: AOJu0Yy0glrO1xLFZmp2+D0YQxcOIXWpUx0f1gm0pJPLBrh56wBW3gBd
 Y0prJg9iBsyLsTNQdelMO3Qnm1xVQvv+fLUzGLSMa425shg8cPfXcdemmkfp7VVccJ6gTNFmZxk
 =
X-Gm-Gg: ASbGncuUv6K23GDKFmpkLwOFKR11AgNHV0uCwg8dWMelUVL84yJ9GUxo0h+7ULsTbjO
 CkD4k5B/r6V/RUAOJgwU1MHEojWiXD7fGHCJ8x6Splnkc7ePhQ4+a3bXxPU/ZFPUQMt5FNOcRWD
 Hd/ZRc6hTSmcV1USfCMZRFyZAqmqPKX9O8Q/J9EcbtoeQQXk7Xw0DP4m1qQQYTqqXtBMyfk5nla
 TWIsJsBEIm1sme6MogNAVfM3ilp98BraYwmHyhv7dgAKYXubZoBU7E=
X-Google-Smtp-Source: AGHT+IECd9Is9wHOTqI0eILq1n3ca7uA88tuNvg4mm8URcYT2x8NqXSHRtkITgPHJ/g8jAOftrYV2Q==
X-Received: by 2002:a05:6a00:4ac6:b0:725:e015:9090 with SMTP id
 d2e1a72fcca58-72abdea0803mr52835163b3a.9.1735769527547; 
 Wed, 01 Jan 2025 14:12:07 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:12:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Dmitry Gerasimov <di.gerasimov@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/67] boot: Rename fit_image_get_data_and_size()
Date: Thu,  2 Jan 2025 11:09:00 +1300
Message-ID: <20250101221003.1944600-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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
2.43.0

