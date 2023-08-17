Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B01AC3065A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 15:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4761B86B2E;
	Thu, 17 Aug 2023 17:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="Xip0lEFF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08DC986B2F; Thu, 17 Aug 2023 17:36:30 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A319786B2D
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4fe389d6f19so12232795e87.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692286585; x=1692891385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SfX48LBDXEbc/he6CLPaSfNCuNLsbSUTNVz18WcpuEw=;
 b=Xip0lEFFdOdmzhzjM+nCAaHWfGox8YFzmFdy8ghYRdNdNjY1X0zn3vXDifaXLjPnZa
 xJ3W+USkZeBUUpmA1pfLjQw+COL6U9tJSmkCPNDf6CSgz5MJbh1QRT4LKAHPhI7hvWFI
 KYMOBXsA9ODnZhFmTv4Qncr6uxS95FJ6dvNmO7ic0dlA+Yz3ZJy9gpbtGSCGKXyqe5/V
 LWuII3ZlEwk76dI8+o5IRg/iYPAITJAPq0jiK2NTpXNZerVER74gBIbWVVN5keNIl92m
 liodYUwobEMH6DMyY3wN9PMgwGGwDEOBDqyPuN1D6wmwk2eOoZn/z45Mk4NmygJYhWFD
 OwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692286585; x=1692891385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SfX48LBDXEbc/he6CLPaSfNCuNLsbSUTNVz18WcpuEw=;
 b=Xrqc8MBfKaPycQ0kgqHQapGmFcYmssmhH10mbTMT1tE9d10NeiOLMZTzDBKO9IWWSq
 WVbkxBHww06ImysLvv6xVTV/h8dH68QXvhecJNz1Prw0tSXfcKxt0pUgN3J0+RiENrqf
 F3KKcj1sp+ygRNGCBrlVmVq3OzyZn5ocfhT1Jm9DfbPONZf1S9l3VzDtJlIv7nIOh5xw
 mqYF07EsAwajrcBl8U3JJeVJ9OUTg3Hi61++fOm/hf6MzVmMkOUec21Nz/yLenTlXIV1
 rTJVKi30KNg+g5oX/do6okfGAUYlSCAdBbL09VLo9/aMRl6i4alH2c73qHEpGda1W4oe
 FLYA==
X-Gm-Message-State: AOJu0YzWxSwJF2e2snm0hu8f0SMzJOF8AH69WjqVME1TtND0KTAv3G6l
 kfdMHAQwSmdMlumpp3blwY2cDhviphel8bEVjLw=
X-Google-Smtp-Source: AGHT+IH9/Wk9iTvv+w91ZkWnOqYwfCrXqo/gV6F1mlwoF/9Djplo2gfRWegRBXlcC2wMfgsrqiVLnw==
X-Received: by 2002:a05:6512:b14:b0:4ff:7004:545e with SMTP id
 w20-20020a0565120b1400b004ff7004545emr4313948lfu.4.1692286585316; 
 Thu, 17 Aug 2023 08:36:25 -0700 (PDT)
Received: from localhost.localdomain ([194.104.22.162])
 by smtp.gmail.com with ESMTPSA id
 m4-20020aa7c2c4000000b0051e0be09297sm9991126edp.53.2023.08.17.08.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 08:36:24 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>, Simon Glass <sjg@chromium.org>,
 Steven Lawrance <steven.lawrance@softathome.com>
Subject: [PATCH] tools: image-host: print error messages to stderr
Date: Thu, 17 Aug 2023 18:36:10 +0300
Message-ID: <20230817153612.30544-1-oleksandr.suvorov@foundries.io>
X-Mailer: git-send-email 2.41.0
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

The make by default cuts off the stdout output from external tools,
so all error messages from the image-host are not shown in a make
output. Besides that, it is a common approach to use stderr stream
for error messages.
Use stderr for all error messages in image-host.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

 tools/image-host.c | 202 ++++++++++++++++++++++++---------------------
 1 file changed, 107 insertions(+), 95 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 4a24dee8153..ca4950312f9 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -38,9 +38,9 @@ static int fit_set_hash_value(void *fit, int noffset, uint8_t *value,
 
 	ret = fdt_setprop(fit, noffset, FIT_VALUE_PROP, value, value_len);
 	if (ret) {
-		printf("Can't set hash '%s' property for '%s' node(%s)\n",
-		       FIT_VALUE_PROP, fit_get_name(fit, noffset, NULL),
-		       fdt_strerror(ret));
+		fprintf(stderr, "Can't set hash '%s' property for '%s' node(%s)\n",
+			FIT_VALUE_PROP, fit_get_name(fit, noffset, NULL),
+			fdt_strerror(ret));
 		return ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EIO;
 	}
 
@@ -72,21 +72,23 @@ static int fit_image_process_hash(void *fit, const char *image_name,
 	node_name = fit_get_name(fit, noffset, NULL);
 
 	if (fit_image_hash_get_algo(fit, noffset, &algo)) {
-		printf("Can't get hash algo property for '%s' hash node in '%s' image node\n",
-		       node_name, image_name);
+		fprintf(stderr,
+			"Can't get hash algo property for '%s' hash node in '%s' image node\n",
+			node_name, image_name);
 		return -ENOENT;
 	}
 
 	if (calculate_hash(data, size, algo, value, &value_len)) {
-		printf("Unsupported hash algorithm (%s) for '%s' hash node in '%s' image node\n",
-		       algo, node_name, image_name);
+		fprintf(stderr,
+			"Unsupported hash algorithm (%s) for '%s' hash node in '%s' image node\n",
+			algo, node_name, image_name);
 		return -EPROTONOSUPPORT;
 	}
 
 	ret = fit_set_hash_value(fit, noffset, value, value_len);
 	if (ret) {
-		printf("Can't set hash value for '%s' hash node in '%s' image node\n",
-		       node_name, image_name);
+		fprintf(stderr, "Can't set hash value for '%s' hash node in '%s' image node\n",
+			node_name, image_name);
 		return ret;
 	}
 
@@ -170,8 +172,9 @@ static int fit_image_setup_sig(struct image_sign_info *info,
 	node_name = fit_get_name(fit, noffset, NULL);
 	if (!algo_name) {
 		if (fit_image_hash_get_algo(fit, noffset, &algo_name)) {
-			printf("Can't get algo property for '%s' signature node in '%s' image node\n",
-			       node_name, image_name);
+			fprintf(stderr,
+				"Can't get algo property for '%s' signature node in '%s' image node\n",
+				node_name, image_name);
 			return -1;
 		}
 	}
@@ -191,8 +194,9 @@ static int fit_image_setup_sig(struct image_sign_info *info,
 	info->require_keys = require_keys;
 	info->engine_id = engine_id;
 	if (!info->checksum || !info->crypto) {
-		printf("Unsupported signature algorithm (%s) for '%s' signature node in '%s' image node\n",
-		       algo_name, node_name, image_name);
+		fprintf(stderr,
+			"Unsupported signature algorithm (%s) for '%s' signature node in '%s' image node\n",
+			algo_name, node_name, image_name);
 		return -1;
 	}
 
@@ -241,8 +245,8 @@ static int fit_image_process_sig(const char *keydir, const char *keyfile,
 	region.size = size;
 	ret = info.crypto->sign(&info, &region, 1, &value, &value_len);
 	if (ret) {
-		printf("Failed to sign '%s' signature node in '%s' image node: %d\n",
-		       node_name, image_name, ret);
+		fprintf(stderr, "Failed to sign '%s' signature node in '%s' image node: %d\n",
+			node_name, image_name, ret);
 
 		/* We allow keys to be missing */
 		if (ret == -ENOENT)
@@ -255,8 +259,9 @@ static int fit_image_process_sig(const char *keydir, const char *keyfile,
 	if (ret) {
 		if (ret == -FDT_ERR_NOSPACE)
 			return -ENOSPC;
-		printf("Can't write signature for '%s' signature node in '%s' conf node: %s\n",
-		       node_name, image_name, fdt_strerror(ret));
+		fprintf(stderr,
+			"Can't write signature for '%s' signature node in '%s' conf node: %s\n",
+			node_name, image_name, fdt_strerror(ret));
 		return -1;
 	}
 	free(value);
@@ -272,8 +277,9 @@ static int fit_image_process_sig(const char *keydir, const char *keyfile,
 	if (keydest) {
 		ret = info.crypto->add_verify_data(&info, keydest);
 		if (ret < 0) {
-			printf("Failed to add verification data for '%s' signature node in '%s' image node\n",
-			       node_name, image_name);
+			fprintf(stderr,
+				"Failed to add verification data for '%s' signature node in '%s' image node\n",
+				node_name, image_name);
 			return ret;
 		}
 		/* Return the node that was written to */
@@ -293,37 +299,37 @@ static int fit_image_read_data(char *filename, unsigned char *data,
 	/* Open file */
 	fd = open(filename, O_RDONLY | O_BINARY);
 	if (fd < 0) {
-		printf("Can't open file %s (err=%d => %s)\n",
-		       filename, errno, strerror(errno));
+		fprintf(stderr, "Can't open file %s (err=%d => %s)\n",
+			filename, errno, strerror(errno));
 		return -1;
 	}
 
 	/* Compute file size */
 	if (fstat(fd, &sbuf) < 0) {
-		printf("Can't fstat file %s (err=%d => %s)\n",
-		       filename, errno, strerror(errno));
+		fprintf(stderr, "Can't fstat file %s (err=%d => %s)\n",
+			filename, errno, strerror(errno));
 		goto err;
 	}
 
 	/* Check file size */
 	if (sbuf.st_size != expected_size) {
-		printf("File %s don't have the expected size (size=%lld, expected=%d)\n",
-		       filename, (long long)sbuf.st_size, expected_size);
+		fprintf(stderr, "File %s don't have the expected size (size=%lld, expected=%d)\n",
+			filename, (long long)sbuf.st_size, expected_size);
 		goto err;
 	}
 
 	/* Read data */
 	n = read(fd, data, sbuf.st_size);
 	if (n < 0) {
-		printf("Can't read file %s (err=%d => %s)\n",
-		       filename, errno, strerror(errno));
+		fprintf(stderr, "Can't read file %s (err=%d => %s)\n",
+			filename, errno, strerror(errno));
 		goto err;
 	}
 
 	/* Check that we have read all the file */
 	if (n != sbuf.st_size) {
-		printf("Can't read all file %s (read %zd bytes, expected %lld)\n",
-		       filename, n, (long long)sbuf.st_size);
+		fprintf(stderr, "Can't read all file %s (read %zd bytes, expected %lld)\n",
+			filename, n, (long long)sbuf.st_size);
 		goto err;
 	}
 
@@ -341,15 +347,15 @@ static int get_random_data(void *data, int size)
 	int i, ret;
 
 	if (!tmp) {
-		printf("%s: pointer data is NULL\n", __func__);
+		fprintf(stderr, "%s: pointer data is NULL\n", __func__);
 		ret = -1;
 		goto out;
 	}
 
 	ret = clock_gettime(CLOCK_MONOTONIC, &date);
 	if (ret) {
-		printf("%s: clock_gettime has failed (%s)\n", __func__,
-		       strerror(errno));
+		fprintf(stderr, "%s: clock_gettime has failed (%s)\n", __func__,
+			strerror(errno));
 		goto out;
 	}
 
@@ -374,8 +380,8 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 	int ret = -1;
 
 	if (fit_image_cipher_get_algo(fit, noffset, &algo_name)) {
-		printf("Can't get algo name for cipher in image '%s'\n",
-		       image_name);
+		fprintf(stderr, "Can't get algo name for cipher in image '%s'\n",
+			image_name);
 		goto out;
 	}
 
@@ -384,8 +390,8 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 	/* Read the key name */
 	info->keyname = fdt_getprop(fit, noffset, FIT_KEY_HINT, NULL);
 	if (!info->keyname) {
-		printf("Can't get key name for cipher in image '%s'\n",
-		       image_name);
+		fprintf(stderr, "Can't get key name for cipher in image '%s'\n",
+			image_name);
 		goto out;
 	}
 
@@ -403,7 +409,7 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 
 	info->cipher = image_get_cipher_algo(algo_name);
 	if (!info->cipher) {
-		printf("Can't get algo for cipher '%s'\n", image_name);
+		fprintf(stderr, "Can't get algo for cipher '%s'\n", image_name);
 		goto out;
 	}
 
@@ -412,7 +418,7 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 		 info->keydir, info->keyname, ".bin");
 	info->key = malloc(info->cipher->key_len);
 	if (!info->key) {
-		printf("Can't allocate memory for key\n");
+		fprintf(stderr, "Can't allocate memory for key\n");
 		ret = -1;
 		goto out;
 	}
@@ -423,7 +429,7 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 
 	info->iv = malloc(info->cipher->iv_len);
 	if (!info->iv) {
-		printf("Can't allocate memory for iv\n");
+		fprintf(stderr, "Can't allocate memory for iv\n");
 		ret = -1;
 		goto out;
 	}
@@ -457,7 +463,7 @@ int fit_image_write_cipher(void *fit, int image_noffset, int noffset,
 		goto out;
 	}
 	if (ret) {
-		printf("Can't replace data with ciphered data (err = %d)\n", ret);
+		fprintf(stderr, "Can't replace data with ciphered data (err = %d)\n", ret);
 		goto out;
 	}
 
@@ -468,7 +474,7 @@ int fit_image_write_cipher(void *fit, int image_noffset, int noffset,
 		goto out;
 	}
 	if (ret) {
-		printf("Can't add unciphered data size (err = %d)\n", ret);
+		fprintf(stderr, "Can't add unciphered data size (err = %d)\n", ret);
 		goto out;
 	}
 
@@ -508,8 +514,9 @@ fit_image_process_cipher(const char *keydir, void *keydest, void *fit,
 	if (keydest) {
 		ret = info.cipher->add_cipher_data(&info, keydest, fit, node_noffset);
 		if (ret) {
-			printf("Failed to add verification data for cipher '%s' in image '%s'\n",
-			       info.keyname, image_name);
+			fprintf(stderr,
+				"Failed to add verification data for cipher '%s' in image '%s'\n",
+				info.keyname, image_name);
 			goto out;
 		}
 	}
@@ -538,13 +545,13 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
 	/* Get image name */
 	image_name = fit_get_name(fit, image_noffset, NULL);
 	if (!image_name) {
-		printf("Can't get image name\n");
+		fprintf(stderr, "Can't get image name\n");
 		return -1;
 	}
 
 	/* Get image data and data length */
 	if (fit_image_get_data(fit, image_noffset, &data, &size)) {
-		printf("Can't get image data/size\n");
+		fprintf(stderr, "Can't get image data/size\n");
 		return -1;
 	}
 
@@ -558,7 +565,7 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
 	if (fdt_getprop(fit, image_noffset, "data-size-unciphered", &len))
 		return 0;
 	if (len != -FDT_ERR_NOTFOUND) {
-		printf("Failure testing for data-size-unciphered\n");
+		fprintf(stderr, "Failure testing for data-size-unciphered\n");
 		return -1;
 	}
 
@@ -568,7 +575,7 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
 	if (cipher_node_offset == -FDT_ERR_NOTFOUND)
 		return 0;
 	if (cipher_node_offset < 0) {
-		printf("Failure getting cipher node\n");
+		fprintf(stderr, "Failure getting cipher node\n");
 		return -1;
 	}
 	if (!IMAGE_ENABLE_ENCRYPT || !keydir)
@@ -624,7 +631,7 @@ int fit_image_add_verification_data(const char *keydir, const char *keyfile,
 
 	/* Get image data and data length */
 	if (fit_image_get_data(fit, image_noffset, &data, &size)) {
-		printf("Can't get image data/size\n");
+		fprintf(stderr, "Can't get image data/size\n");
 		return -1;
 	}
 
@@ -765,8 +772,9 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 	}
 
 	if (!hash_count) {
-		printf("Failed to find any hash nodes in configuration '%s/%s' image '%s' - without these it is not possible to verify this image\n",
-		       conf_name, sig_name, iname);
+		fprintf(stderr,
+			"Failed to find any hash nodes in configuration '%s/%s' image '%s' - without these it is not possible to verify this image\n",
+			conf_name, sig_name, iname);
 		return -ENOMSG;
 	}
 
@@ -775,9 +783,10 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 				     FIT_CIPHER_NODENAME);
 	if (noffset != -FDT_ERR_NOTFOUND) {
 		if (noffset < 0) {
-			printf("Failed to get cipher node in configuration '%s/%s' image '%s': %s\n",
-			       conf_name, sig_name, iname,
-			       fdt_strerror(noffset));
+			fprintf(stderr,
+				"Failed to get cipher node in configuration '%s/%s' image '%s': %s\n",
+				conf_name, sig_name, iname,
+				fdt_strerror(noffset));
 			return -EIO;
 		}
 		ret = fdt_get_path(fit, noffset, path, sizeof(path));
@@ -790,13 +799,13 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 	return 0;
 
 err_mem:
-	printf("Out of memory processing configuration '%s/%s'\n", conf_name,
-	       sig_name);
+	fprintf(stderr, "Out of memory processing configuration '%s/%s'\n", conf_name,
+		sig_name);
 	return -ENOMEM;
 
 err_path:
-	printf("Failed to get path for image '%s' in configuration '%s/%s': %s\n",
-	       iname, conf_name, sig_name, fdt_strerror(ret));
+	fprintf(stderr, "Failed to get path for image '%s' in configuration '%s/%s': %s\n",
+		iname, conf_name, sig_name, fdt_strerror(ret));
 	return -ENOENT;
 }
 
@@ -857,8 +866,9 @@ static int fit_config_get_hash_list(const void *fit, int conf_noffset,
 								     iname, index);
 
 			if (image_noffset < 0) {
-				printf("Failed to find image '%s' in  configuration '%s/%s'\n",
-				       iname, conf_name, sig_name);
+				fprintf(stderr,
+					"Failed to find image '%s' in  configuration '%s/%s'\n",
+					iname, conf_name, sig_name);
 				if (allow_missing)
 					continue;
 
@@ -875,16 +885,16 @@ static int fit_config_get_hash_list(const void *fit, int conf_noffset,
 	}
 
 	if (!image_count) {
-		printf("Failed to find any images for configuration '%s/%s'\n",
-		       conf_name, sig_name);
+		fprintf(stderr, "Failed to find any images for configuration '%s/%s'\n",
+			conf_name, sig_name);
 		return -ENOMSG;
 	}
 
 	return 0;
 
 err_mem:
-	printf("Out of memory processing configuration '%s/%s'\n", conf_name,
-	       sig_name);
+	fprintf(stderr, "Out of memory processing configuration '%s/%s'\n", conf_name,
+		sig_name);
 	return -ENOMEM;
 }
 
@@ -946,21 +956,21 @@ static int fit_config_get_regions(const void *fit, int conf_noffset,
 			fdt_regions, ARRAY_SIZE(fdt_regions),
 			path, sizeof(path), 1);
 	if (count < 0) {
-		printf("Failed to hash configuration '%s/%s': %s\n", conf_name,
-		       sig_name, fdt_strerror(ret));
+		fprintf(stderr, "Failed to hash configuration '%s/%s': %s\n", conf_name,
+			sig_name, fdt_strerror(ret));
 		return -EIO;
 	}
 	if (count == 0) {
-		printf("No data to hash for configuration '%s/%s': %s\n",
-		       conf_name, sig_name, fdt_strerror(ret));
+		fprintf(stderr, "No data to hash for configuration '%s/%s': %s\n",
+			conf_name, sig_name, fdt_strerror(ret));
 		return -EINVAL;
 	}
 
 	/* Build our list of data blocks */
 	region = fit_region_make_list(fit, fdt_regions, count, NULL);
 	if (!region) {
-		printf("Out of memory hashing configuration '%s/%s'\n",
-		       conf_name, sig_name);
+		fprintf(stderr, "Out of memory hashing configuration '%s/%s'\n",
+			conf_name, sig_name);
 		return -ENOMEM;
 	}
 
@@ -972,8 +982,8 @@ static int fit_config_get_regions(const void *fit, int conf_noffset,
 	}
 	region_prop = malloc(len);
 	if (!region_prop) {
-		printf("Out of memory setting up regions for configuration '%s/%s'\n",
-		       conf_name, sig_name);
+		fprintf(stderr, "Out of memory setting up regions for configuration '%s/%s'\n",
+			conf_name, sig_name);
 		return -ENOMEM;
 	}
 	for (i = len = 0; i < node_inc.count;
@@ -1038,8 +1048,8 @@ static int fit_config_process_sig(const char *keydir, const char *keyfile,
 				&value_len);
 	free(region);
 	if (ret) {
-		printf("Failed to sign '%s' signature node in '%s' conf node\n",
-		       node_name, conf_name);
+		fprintf(stderr, "Failed to sign '%s' signature node in '%s' conf node\n",
+			node_name, conf_name);
 
 		/* We allow keys to be missing */
 		if (ret == -ENOENT)
@@ -1053,8 +1063,9 @@ static int fit_config_process_sig(const char *keydir, const char *keyfile,
 	if (ret) {
 		if (ret == -FDT_ERR_NOSPACE)
 			return -ENOSPC;
-		printf("Can't write signature for '%s' signature node in '%s' conf node: %s\n",
-		       node_name, conf_name, fdt_strerror(ret));
+		fprintf(stderr,
+			"Can't write signature for '%s' signature node in '%s' conf node: %s\n",
+			node_name, conf_name, fdt_strerror(ret));
 		return -1;
 	}
 	free(value);
@@ -1067,8 +1078,9 @@ static int fit_config_process_sig(const char *keydir, const char *keyfile,
 	if (keydest) {
 		ret = info.crypto->add_verify_data(&info, keydest);
 		if (ret < 0) {
-			printf("Failed to add verification data for '%s' signature node in '%s' configuration node\n",
-			       node_name, conf_name);
+			fprintf(stderr,
+				"Failed to add verification data for '%s' signature node in '%s' configuration node\n",
+				node_name, conf_name);
 		}
 		return ret;
 	}
@@ -1148,7 +1160,7 @@ static int read_pub_key(const char *keydir, const void *name,
 	/* Read the certificate */
 	cert = NULL;
 	if (!PEM_read_X509(f, &cert, NULL, NULL)) {
-		printf("Couldn't read certificate");
+		fprintf(stderr, "Couldn't read certificate");
 		ret = -EINVAL;
 		goto err_cert;
 	}
@@ -1156,7 +1168,7 @@ static int read_pub_key(const char *keydir, const void *name,
 	/* Get the public key from the certificate. */
 	key = X509_get_pubkey(cert);
 	if (!key) {
-		printf("Couldn't read public key\n");
+		fprintf(stderr, "Couldn't read public key\n");
 		ret = -EINVAL;
 		goto err_pubkey;
 	}
@@ -1164,7 +1176,7 @@ static int read_pub_key(const char *keydir, const void *name,
 	/* Get DER form */
 	ret = i2d_PublicKey(key, pubkey);
 	if (ret < 0) {
-		printf("Couldn't get DER form\n");
+		fprintf(stderr, "Couldn't get DER form\n");
 		ret = -EINVAL;
 		goto err_pubkey;
 	}
@@ -1203,11 +1215,11 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 	/* Check that all mandatory properties are present */
 	if (!algo_name || !key_name) {
 		if (!algo_name)
-			printf("The property algo-name is missing in the node %s\n",
-			       IMAGE_PRE_LOAD_PATH);
+			fprintf(stderr, "The property algo-name is missing in the node %s\n",
+				IMAGE_PRE_LOAD_PATH);
 		if (!key_name)
-			printf("The property key-name is missing in the node %s\n",
-			       IMAGE_PRE_LOAD_PATH);
+			fprintf(stderr, "The property key-name is missing in the node %s\n",
+				IMAGE_PRE_LOAD_PATH);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1221,8 +1233,8 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 	ret = fdt_setprop(keydest, pre_load_noffset, "public-key",
 			  pubkey, pubkey_len);
 	if (ret)
-		printf("Can't set public-key in node %s (ret = %d)\n",
-		       IMAGE_PRE_LOAD_PATH, ret);
+		fprintf(stderr, "Can't set public-key in node %s (ret = %d)\n",
+			IMAGE_PRE_LOAD_PATH, ret);
 
  out:
 	return ret;
@@ -1239,8 +1251,8 @@ int fit_cipher_data(const char *keydir, void *keydest, void *fit,
 	/* Find images parent node offset */
 	images_noffset = fdt_path_offset(fit, FIT_IMAGES_PATH);
 	if (images_noffset < 0) {
-		printf("Can't find images parent node '%s' (%s)\n",
-		       FIT_IMAGES_PATH, fdt_strerror(images_noffset));
+		fprintf(stderr, "Can't find images parent node '%s' (%s)\n",
+			FIT_IMAGES_PATH, fdt_strerror(images_noffset));
 		return images_noffset;
 	}
 
@@ -1276,8 +1288,8 @@ int fit_add_verification_data(const char *keydir, const char *keyfile,
 	/* Find images parent node offset */
 	images_noffset = fdt_path_offset(fit, FIT_IMAGES_PATH);
 	if (images_noffset < 0) {
-		printf("Can't find images parent node '%s' (%s)\n",
-		       FIT_IMAGES_PATH, fdt_strerror(images_noffset));
+		fprintf(stderr, "Can't find images parent node '%s' (%s)\n",
+			FIT_IMAGES_PATH, fdt_strerror(images_noffset));
 		return images_noffset;
 	}
 
@@ -1293,9 +1305,9 @@ int fit_add_verification_data(const char *keydir, const char *keyfile,
 				fit, noffset, comment, require_keys, engine_id,
 				cmdname, algo_name);
 		if (ret) {
-			printf("Can't add verification data for node '%s' (%s)\n",
-			       fdt_get_name(fit, noffset, NULL),
-			       fdt_strerror(ret));
+			fprintf(stderr, "Can't add verification data for node '%s' (%s)\n",
+				fdt_get_name(fit, noffset, NULL),
+				fdt_strerror(ret));
 			return ret;
 		}
 	}
@@ -1307,8 +1319,8 @@ int fit_add_verification_data(const char *keydir, const char *keyfile,
 	/* Find configurations parent node offset */
 	confs_noffset = fdt_path_offset(fit, FIT_CONFS_PATH);
 	if (confs_noffset < 0) {
-		printf("Can't find images parent node '%s' (%s)\n",
-		       FIT_CONFS_PATH, fdt_strerror(confs_noffset));
+		fprintf(stderr, "Can't find images parent node '%s' (%s)\n",
+			FIT_CONFS_PATH, fdt_strerror(confs_noffset));
 		return -ENOENT;
 	}
 
-- 
2.41.0

