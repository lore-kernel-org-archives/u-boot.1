Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60A0109C045
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D3483FEC;
	Wed, 25 Mar 2026 17:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j08XqQgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CEF883F60; Wed, 25 Mar 2026 17:55:47 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E9D383FC5
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-46726528f1cso12793b6e.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457743; x=1775062543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQO7SfvIzGzetk/xnfpE5Y/k6hx9hH32lsuldyisw5g=;
 b=j08XqQgwhRORHoteV9HmmGEIah1ZnPfDBknKSGMEmWd63fo9+pl0Mm9hzd8TPzCQ1m
 bXgCteb98gT8rdUlofDUEpWDY1cqRuWmr04WfIV1/MZdYzPFUHMHSDhF7dnR+vvJiQAj
 OZV7QOPkhnz5ItEuvTTmpV+Mi/su4nWPj4RLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457743; x=1775062543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KQO7SfvIzGzetk/xnfpE5Y/k6hx9hH32lsuldyisw5g=;
 b=nqYRe8zgND0aZrA20p8R2HY5JjOln1j86HqIDYL6u3OlcGPTaazGJ56EaXO2LIiU0w
 9HKPDdHiMt7Ye89wXVf2pYWxWWK62uDFPFudXXbyVVG0NC3r8wlywbC1iI5s/AkOnTm9
 F9sY8lM/A4PkHl1IerFWBmdUmV7jtA9h7AVrjBkEsaoLWZy/ou6122wEmkNmompx5gOi
 89gkUY0dnvP1lfO4ysUImbEYWgzgLwfoN26ge/Dj3jaJSmb/tMQdqts9pIa7BXDzQ8E7
 fwfPHaRg62q26UyVPRjwkS5CWxvjXM2iVAeJb/Izt3WlNV5bUXq7xja/AbbJttcnUSJj
 S9Pg==
X-Gm-Message-State: AOJu0YyLO7eB+KqG8ysgA8W8Eo8tVSZrpNiD4QoeW6EJ2EyDdv3eD2iY
 hUPa9IRQylHouZYf4wBw69OJMee4B2YjiDmSYsv1jgZUgTV3X0UGqSiFHLWemndqgibpWRtgvNk
 aw9YcyA==
X-Gm-Gg: ATEYQzzvV5ZRQgeP+gbS1c+N9YNsmtgaZbdaxq1HN7cZPrvuIYRLNSIjDmkIVet8eId
 YR2u4yHI79H1cul8YsgVye9mk5zF7libIhsOJcu/VvHrYNAzw04msBXPsZgnsyj6UPGjDC4qrH1
 rPos3nvWHsGQZm3/JSm7wViRFuiqpS5OfZq6SSvCsdYwlEjwm6wjMqyh8K7zmutlmp6G6t/PcBd
 CRthfbTS9BqOO3ON+47zVHV9jkuLH822Hh+dylzQ72FLJA1C0eTZuSnwlECcsJIQvo2qKB0/924
 jCJbXxNpTiYPqV3hIUFOtMx2+NlVdcKJ/t+vsztNGVu7gpc2zwVUhu1v9tcOMnOwdR5N8jvvotD
 WMu/4aXvtZb7W2Cis2a3MW4OrFZXtzIjEvxc9iuPljRNcobCebWGniPqmw/SnCiYq2I3ZvNDtjR
 zciSp4Mz+P1sx8GCaixQ==
X-Received: by 2002:a05:6808:1185:b0:455:d3f2:4bf9 with SMTP id
 5614622812f47-46a5c79e201mr2015662b6e.30.1774457743278; 
 Wed, 25 Mar 2026 09:55:43 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/13] boot: Move obtaining data from a FIT image into a
 function
Date: Wed, 25 Mar 2026 10:54:15 -0600
Message-ID: <20260325165431.1027591-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325165431.1027591-1-sjg@chromium.org>
References: <20260325165431.1027591-1-sjg@chromium.org>
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

Move this code into a separate function, to help further slim down
fit_image_load().

Move the bootstage_mark() call in there too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 75 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index c5067b63682..5e90cd2cf50 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2232,6 +2232,53 @@ static int check_allowed(const void *fit, int noffset,
 	return 0;
 }
 
+/**
+ * obtain_data() - Obtain the data from the FIT
+ *
+ * Get the location of the data in the FIT and see if it needs to be deciphered
+ * or processed in some grubby board-specific way.
+ *
+ * @fit: FIT to check
+ * @noffset: Node offset of the image being loaded
+ * @prop_name: Property name (in the configuration node) indicating the image
+ * that was loaded
+ * @bootstage_id: ID of starting bootstage to use for progress updates
+ * @bufp: Returns a pointer to the data
+ * @sizep: Returns the size of the data
+ * Return: 0 if OK, -ve on error
+ */
+static int obtain_data(const void *fit, int noffset, const char *prop_name,
+		       int bootstage_id, void **bufp, ulong *sizep)
+{
+	size_t size;
+
+	/* get image data address and length */
+	if (fit_image_get_data(fit, noffset, (const void **)bufp, &size)) {
+		printf("Could not find %s subimage data!\n", prop_name);
+		bootstage_error(bootstage_id + BOOTSTAGE_SUB_GET_DATA);
+		return -ENOENT;
+	}
+
+	/* Decrypt data before uncompress/move */
+	if (IS_ENABLED(CONFIG_FIT_CIPHER) && IMAGE_ENABLE_DECRYPT) {
+		puts("   Decrypting Data ... ");
+		if (fit_image_uncipher(fit, noffset, bufp, &size)) {
+			puts("Error\n");
+			return -EACCES;
+		}
+		puts("OK\n");
+	}
+
+	/* perform any post-processing on the image data */
+	if (!tools_build() && IS_ENABLED(CONFIG_FIT_IMAGE_POST_PROCESS))
+		board_fit_image_post_process(fit, noffset, bufp, &size);
+
+	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_GET_DATA_OK);
+	*sizep = size;
+
+	return 0;
+}
+
 /**
  * handle_load_op() - Handle the load operation
  *
@@ -2314,7 +2361,6 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	const void *fit;
 	void *buf;
 	void *loadbuf;
-	size_t size;
 	ulong load, load_end, data, len;
 	uint8_t comp, os_arch;
 	const char *prop_name;
@@ -2349,30 +2395,9 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	if (ret)
 		return ret;
 
-	/* get image data address and length */
-	if (fit_image_get_data(fit, noffset, (const void **)&buf, &size)) {
-		printf("Could not find %s subimage data!\n", prop_name);
-		bootstage_error(bootstage_id + BOOTSTAGE_SUB_GET_DATA);
-		return -ENOENT;
-	}
-
-	/* Decrypt data before uncompress/move */
-	if (IS_ENABLED(CONFIG_FIT_CIPHER) && IMAGE_ENABLE_DECRYPT) {
-		puts("   Decrypting Data ... ");
-		if (fit_image_uncipher(fit, noffset, &buf, &size)) {
-			puts("Error\n");
-			return -EACCES;
-		}
-		puts("OK\n");
-	}
-
-	/* perform any post-processing on the image data */
-	if (!tools_build() && IS_ENABLED(CONFIG_FIT_IMAGE_POST_PROCESS))
-		board_fit_image_post_process(fit, noffset, &buf, &size);
-
-	len = (ulong)size;
-
-	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_GET_DATA_OK);
+	ret = obtain_data(fit, noffset, prop_name, bootstage_id, &buf, &len);
+	if (ret)
+		return ret;
 
 	ret = handle_load_op(fit, noffset, prop_name, buf, len, image_type,
 			     load_op, bootstage_id, &data, &load, &load_end);
-- 
2.43.0

