Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0A2CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB62886ACC;
	Sun, 24 Sep 2023 21:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="drjJZ8pJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CBAD86B9A; Sun, 24 Sep 2023 21:26:16 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CECEF86A88
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-351365e47f6so3571275ab.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583564; x=1696188364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgkogzhiEXdlbV8juENoI1pWnElzsXS/La849mQTrJo=;
 b=drjJZ8pJgI/jvq6eQnzdtHHRFklSxw+LkCL0ObltJ1//rE7MOYu6oVbzQANKkWoaCK
 CvejgVagYZ5bhsxTpCaGIGFC4vL30EvaOGtBVfX/hUuF4jpamjfVKv73Q46uWuOwocMZ
 DFq4+7V1O0IxxTNPmnRTyqbw9w4Zxj/5kZgbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583564; x=1696188364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgkogzhiEXdlbV8juENoI1pWnElzsXS/La849mQTrJo=;
 b=psczQVMagLkY3FayirdP/Vf2h3mVfKXyk/xJ8FtyvnO4j5BVn3z9/VtMkMXE3oR2u0
 QBEX366X5a3IIyTtDKkXaDQW6Sc7B2OkPWkLIvKbTyWZD/Yzmly/ptTbhLG6jw+HJQ9B
 eVzIhZgvcKXK5LPkaU21vhcGXvi8agsTCA3pMyPxVNalgEw9Bx+oiQ0+alLQWhCnBXfb
 7vOY0EYw+8mz0QhEtt+SBlzeG6Qqsb5M2kcQFQUgLVYvYgOhaHmeGX1B4GtZZ6XJrW1U
 oyhg5qkMhZn934pfhuiA1v2N4F8/aw+P9SsrK58GGKmHoNF0z5ZuD0n9YOWM+etIBoYU
 BTyQ==
X-Gm-Message-State: AOJu0YyG4Gs7GZBf/zXVQ3httzPFdsJsLZ+TDwck07phOzfS6FJKbwqO
 1rBw8vRVxI6pyJGNIw426Tiii/uFW5uCIqUQJFw=
X-Google-Smtp-Source: AGHT+IE+Mq/NRev4xMEuxHLKvyzOkAtY/20OfBeVIy/l9Fwqyznqftz02HJI8nj6iegRmKDbQmMBlA==
X-Received: by 2002:a05:6e02:2166:b0:34f:c9b4:5f9c with SMTP id
 s6-20020a056e02216600b0034fc9b45f9cmr7226674ilv.31.1695583564454; 
 Sun, 24 Sep 2023 12:26:04 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v3 17/38] spl: Rename spl_load_fit_image() to load_simple_fit()
Date: Sun, 24 Sep 2023 13:25:02 -0600
Message-ID: <20230924192536.1812799-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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
index 1bfdc0af4969..8e7d033dd1a4 100644
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
2.42.0.515.g380fc7ccd1-goog

