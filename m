Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ABFCD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 518AE86D9D;
	Thu, 21 Sep 2023 03:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nsV3WJpF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E51A686D2E; Thu, 21 Sep 2023 03:58:01 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E47F586D43
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-792717ef3c9so19958339f.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261474; x=1695866274; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgkogzhiEXdlbV8juENoI1pWnElzsXS/La849mQTrJo=;
 b=nsV3WJpFRcrLo5HPgQLlpJ4U1GeNLnts7WoJaE+uGOCtMpbPQaoTrKAaE4scYAM+1F
 aIosdtuEH+Ol8DDgArUcXQTdKSp6XUlO2xyggM5Wq0EYIe5kghC6bW6qeG9Jl9KASo58
 rRCe2q664/qZ2T4djjXjFSroGPlNAgj95eELE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261474; x=1695866274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgkogzhiEXdlbV8juENoI1pWnElzsXS/La849mQTrJo=;
 b=PjQNQn3EBZ8/wEhs5X3RwK0a8l9XQ/n8pHRmtQQnzkCgN4Y3I27fFVCEWSIz2i7JnV
 jrtrAEkqUYDjo2aGDC/CxSdGFzoCOXRnON/PcrXbS09Nl5KQ/WiZPDbwwRaAkLjE27or
 kdZyTXI65sQtdIBUX/A6y+8cabsF27V+mCFSpXzIM4Fj+fjpunet/0Ss/55+9bG5Ov6j
 UPtm0Dbk27lCe8eTazRe/7IphvdLJSNR9TjHy/qbGHPxW1EEuy/H3gwbjdRgOkkpHsy8
 x/SIOE4Z5lKU6nmM0wKl1guPdUrrHDzSSZv3QXAIOWwCzqXPDdJ5lL3+WeBYp9+88/y/
 YYYw==
X-Gm-Message-State: AOJu0YyiHy74E+IUxBfE4ZkWwJIGuoQFuVybcFcLAhy0sq5Fu3D/tL9T
 2ZIMsgmJcQQDqhsLE/CC732rfQGLld/3t0R67a0=
X-Google-Smtp-Source: AGHT+IESMtX055h1Bwc6VwhhAb70KcsxvNjNPH+6if4AMQP/lBoqv9q9uxOAn94Nd7IewjkJhXUXXA==
X-Received: by 2002:a5d:9404:0:b0:792:9416:9c7f with SMTP id
 v4-20020a5d9404000000b0079294169c7fmr4700336ion.9.1695261474592; 
 Wed, 20 Sep 2023 18:57:54 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 11/32] spl: Rename spl_load_fit_image() to load_simple_fit()
Date: Wed, 20 Sep 2023 19:57:00 -0600
Message-ID: <20230921015730.1511373-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

