Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC445C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4066865FB;
	Wed, 30 Aug 2023 20:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WU7LLkYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04260865AB; Wed, 30 Aug 2023 20:06:01 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E3386563
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-794e0e8b588so2109339f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418747; x=1694023547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FmworSfNtol1OAAwjhg9Ul6/XqpFHGDgN4uuYkuvt6A=;
 b=WU7LLkYSm1sGd/Gr2oc45p87rZOrKBS+Qk3MZBu9kWod4OsEQ0IePg8g5zieDBBTea
 iaf90dfiFJXo+mcz7WGlCRVbm3viPXKRK0tgwWE9uVP8lpsO0tn0trQLEYlVavBqgc66
 OXPGODy7BMwZU/3Jhp1T6qEH421PUfy1rXlvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418747; x=1694023547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FmworSfNtol1OAAwjhg9Ul6/XqpFHGDgN4uuYkuvt6A=;
 b=eecbqke+yrrIr3DdiBzIw/RWmCAjpTqRFXG3vDOi9IMAAVHEsiA7iKiEQsLi5eVkOF
 jr7FmwPZKkD5X9mOhNbOo8YJywhtz6d3p9rOOvb6tOtgul5C8BjdzfL0u/S6mX8hu90D
 g0n8Mpj4OJ53aZtJFXzBrtnr2g2ITVkOqnZjPz2rNXv6R/dMhRAobivDwHgXKROspSyB
 Bp73/HwVr9/zQqS3q+eC3n+QOKXd7gn+9uQgq2sGgZfnMJqTH6uPUpS0N3SvyjoOPRU7
 JQhIOCU9rho+hy0P9r36Sc8kd++MFqZZACNGaefD1kENrOThRPJ1ZKOY4xZfWNJ5Wr1C
 2iLw==
X-Gm-Message-State: AOJu0YyiWr6emrgJHfRYr4DceK6N3c5Uy1ffbexjKopCbX7axpnNNSLI
 JahLVyWKiJstjSnX4FuuCQlFt1OC1pL94Ytr1BQ=
X-Google-Smtp-Source: AGHT+IEFtdTl5la1SWQ7TB6Jc9uewAK4IBPmyxiX/loY060yOwtWlH9HmW76IhPFku1qxM2QOygYTQ==
X-Received: by 2002:a6b:e317:0:b0:790:9f0c:3069 with SMTP id
 u23-20020a6be317000000b007909f0c3069mr3310307ioc.9.1693418747341; 
 Wed, 30 Aug 2023 11:05:47 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 11/32] spl: Rename spl_load_fit_image() to load_simple_fit()
Date: Wed, 30 Aug 2023 12:04:42 -0600
Message-ID: <20230830180524.315916-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

 common/spl/spl_fit.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 1bfdc0af496..8e7d033dd1a 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -207,7 +207,7 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
 }
 
 /**
- * spl_load_fit_image(): load the image described in a certain FIT node
+ * load_simple_fit(): load the image described in a certain FIT node
  * @info:	points to information about the device to load data from
  * @sector:	the start sector of the FIT image on the device
  * @ctx:	points to the FIT context structure
@@ -220,9 +220,9 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
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
@@ -385,8 +385,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 		else
 			return node;
 	} else {
-		ret = spl_load_fit_image(info, sector, ctx, node,
-					 &image_info);
+		ret = load_simple_fit(info, sector, ctx, node, &image_info);
 		if (ret < 0)
 			return ret;
 	}
@@ -425,8 +424,8 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 					      __func__);
 			}
 			image_info.load_addr = (ulong)tmpbuffer;
-			ret = spl_load_fit_image(info, sector, ctx,
-						 node, &image_info);
+			ret = load_simple_fit(info, sector, ctx, node,
+					      &image_info);
 			if (ret < 0)
 				break;
 
@@ -616,7 +615,7 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
 	warn_deprecated("'fpga' property in config node. Use 'loadables'");
 
 	/* Load the image and set up the fpga_image structure */
-	ret = spl_load_fit_image(info, sector, ctx, node, &fpga_image);
+	ret = load_simple_fit(info, sector, ctx, node, &fpga_image);
 	if (ret) {
 		printf("%s: Cannot load the FPGA: %i\n", __func__, ret);
 		return ret;
@@ -741,7 +740,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	}
 
 	/* Load the image and set up the spl_image structure */
-	ret = spl_load_fit_image(info, sector, &ctx, node, spl_image);
+	ret = load_simple_fit(info, sector, &ctx, node, spl_image);
 	if (ret)
 		return ret;
 
@@ -782,7 +781,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 			continue;
 
 		image_info.load_addr = 0;
-		ret = spl_load_fit_image(info, sector, &ctx, node, &image_info);
+		ret = load_simple_fit(info, sector, &ctx, node, &image_info);
 		if (ret < 0) {
 			printf("%s: can't load image loadables index %d (ret = %d)\n",
 			       __func__, index, ret);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

