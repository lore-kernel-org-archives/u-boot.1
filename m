Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53855E7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 551F886DC7;
	Tue, 26 Sep 2023 16:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UO7i0s80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5754786DB5; Tue, 26 Sep 2023 16:15:51 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0974786DAF
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34fe6722847so27282295ab.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737742; x=1696342542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/ytOaQf4s4EdvBGbOXpdIJt9UFqM4TEIwptVWQ+z0U=;
 b=UO7i0s80G8jgBO5E75Bw0Ievp7nG0ot/fhme1DQjcfKuabU2rwwAuQCqTVEcEsXuly
 u/d39A/Kkbd6IvayaQa47psr5TLeq0d5mKktqkEvffjbuqPIx7bqOcqtcihtoxEA7Cm1
 GtS2Qm/dIGm8oDRkpJdToYHVRh4Wh2MygXGxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737742; x=1696342542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/ytOaQf4s4EdvBGbOXpdIJt9UFqM4TEIwptVWQ+z0U=;
 b=u/+jFHWNFVoMJqExJhVD7fPuEcBMMD+DMMQfC0+H20WTGMso1OJ6pCAONtkcsKK3h2
 wvBcIIc4o6z2aFyWmYliNiCCGP2I6H1zYBj9Mi7oysUXRqrn4aRCKnrIzAjwvNhtjNnU
 k+LRcTaBvuqiHEF2iqkgk1ggvxC78megRHnN1HBtMeq5+XWlJ3y10ymYQQIBp15f87bK
 8GDK/aCuf2NYyMqegc9KV3q8oAkqZfXRzNwnXHq5qAbVBUkPq1I1qQYrT7ZHW8shO/QB
 w5vudp9pYIxH03qkIrTmazTl8YTDjHLxjaMkJVp7wbPftBtiJ2UejHZr2pCTq6gE9Lp1
 BEsw==
X-Gm-Message-State: AOJu0Yy3gXlJ8JD6LaRiloHX/sMgqxfpIFQQtHfCFJHpxRDeQCnO1IKn
 csy8MHb3OwoCjHjcuc6Tbh9laZdJFkeqHH/jwv0=
X-Google-Smtp-Source: AGHT+IEwEb67d9vCn1ZTTnv9dOQLsvaRorcGxYZwpHLcZgq5NDA5gHXBPncukuh/GnbDrz7RFLC1ng==
X-Received: by 2002:a05:6e02:970:b0:351:59f1:5277 with SMTP id
 q16-20020a056e02097000b0035159f15277mr626516ilt.4.1695737742604; 
 Tue, 26 Sep 2023 07:15:42 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 19/44] spl: Rename spl_load_fit_image() to load_simple_fit()
Date: Tue, 26 Sep 2023 08:14:33 -0600
Message-ID: <20230926141514.2101787-20-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

We have two functions called spl_load_fit_image(), one in spl.c and one in
spl_fit.c

Rename the second one, to indicate that it relates to simple FIT parsing,
rather than the full version.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl_fit.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 1fb17217dc3a..48bc4d77411a 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -208,7 +208,7 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
 }
 
 /**
- * spl_load_fit_image(): load the image described in a certain FIT node
+ * load_simple_fit(): load the image described in a certain FIT node
  * @info:	points to information about the device to load data from
  * @sector:	the start sector of the FIT image on the device
  * @ctx:	points to the FIT context structure
@@ -221,9 +221,9 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
  *
  * Return:	0 on success or a negative error number.
  */
-static int spl_load_fit_image(struct spl_load_info *info, ulong sector,
-			      const struct spl_fit_info *ctx, int node,
-			      struct spl_image_info *image_info)
+static int load_simple_fit(struct spl_load_info *info, ulong sector,
+			   const struct spl_fit_info *ctx, int node,
+			   struct spl_image_info *image_info)
 {
 	int offset;
 	size_t length;
@@ -386,8 +386,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 		else
 			return node;
 	} else {
-		ret = spl_load_fit_image(info, sector, ctx, node,
-					 &image_info);
+		ret = load_simple_fit(info, sector, ctx, node, &image_info);
 		if (ret < 0)
 			return ret;
 	}
@@ -426,8 +425,8 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 					      __func__);
 			}
 			image_info.load_addr = (ulong)tmpbuffer;
-			ret = spl_load_fit_image(info, sector, ctx,
-						 node, &image_info);
+			ret = load_simple_fit(info, sector, ctx, node,
+					      &image_info);
 			if (ret < 0)
 				break;
 
@@ -617,7 +616,7 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
 	warn_deprecated("'fpga' property in config node. Use 'loadables'");
 
 	/* Load the image and set up the fpga_image structure */
-	ret = spl_load_fit_image(info, sector, ctx, node, &fpga_image);
+	ret = load_simple_fit(info, sector, ctx, node, &fpga_image);
 	if (ret) {
 		printf("%s: Cannot load the FPGA: %i\n", __func__, ret);
 		return ret;
@@ -742,7 +741,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	}
 
 	/* Load the image and set up the spl_image structure */
-	ret = spl_load_fit_image(info, sector, &ctx, node, spl_image);
+	ret = load_simple_fit(info, sector, &ctx, node, spl_image);
 	if (ret)
 		return ret;
 
@@ -783,7 +782,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 			continue;
 
 		image_info.load_addr = 0;
-		ret = spl_load_fit_image(info, sector, &ctx, node, &image_info);
+		ret = load_simple_fit(info, sector, &ctx, node, &image_info);
 		if (ret < 0) {
 			printf("%s: can't load image loadables index %d (ret = %d)\n",
 			       __func__, index, ret);
-- 
2.42.0.515.g380fc7ccd1-goog

