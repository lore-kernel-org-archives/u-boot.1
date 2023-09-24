Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A43CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC3286BE1;
	Sun, 24 Sep 2023 21:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pm20R6Vo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD2AE86B34; Sun, 24 Sep 2023 21:26:17 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB42D86B34
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79f95cd15dfso158108139f.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583566; x=1696188366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sM51kDu9E3jeyr/KNGV0RRsyMMy9BHZZ4VYramK76O0=;
 b=Pm20R6VohBEqBXiWJmeKJGLK9sqZEDYKCb7s4GrzLChUbyB2YKLZBMpVCQd8tn20k6
 BO0Ki955n6lViTG08fzUDAk4L31Pcfv6JbYNFOzSNYUkBW9M2jNeCmlGTb8zp4NUG0TL
 QY8KujM/HbNVJhSG55Q/+Qwfwo/QBzOSlth/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583566; x=1696188366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sM51kDu9E3jeyr/KNGV0RRsyMMy9BHZZ4VYramK76O0=;
 b=n4eh9Gx2bnS4S8ViIy4mQoOBP8c4CGceYBEeiF3Vv75/hlIky/zqP3NSvr4G0QBz+O
 2ZRFKtayIOk46jzXU1eKJOZol7J42cIBZSHRFotUWJJvyzUJ1ZUkxk0YE1gRVO0BIyFi
 KBHJLynJTWOxlULGajdCCEzSK6+U05DUULSDmnMc8Swsz9JsI9Tx54hhXS+4obVcBn4b
 PnfIei07qcAxN7wjrjpME+nYQ9RD9v4w4muwTnd4XlLLYwR/btAszBR2Nfb82tO0P7F0
 14+/P32F03b/0W8i0kgbDfQPAiO/zEiYiLAd5xmlRuSl9U/VV2mnPyUgQo10Y70MWn/k
 I0dQ==
X-Gm-Message-State: AOJu0YxvIYBVKhPuLjx1F3lMGrzdGlbGivilFMYsY6WQLCKxnywRsyND
 jR+81aakVDiFLivz2QOQg/W/dzXp0bmEhEjYdL8=
X-Google-Smtp-Source: AGHT+IGX2cdfGLXxlNAEX8U6LvqZX9Ng+xuSRF5XSSTokTePyFRqwIVU8S48RWGJMA5mFRyl42YKiQ==
X-Received: by 2002:a05:6e02:20c5:b0:34f:cff6:5e2f with SMTP id
 5-20020a056e0220c500b0034fcff65e2fmr6646805ilq.30.1695583566383; 
 Sun, 24 Sep 2023 12:26:06 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v3 19/38] spl: Use the correct FIT_..._PROP constants
Date: Sun, 24 Sep 2023 13:25:04 -0600
Message-ID: <20230924192536.1812799-20-sjg@chromium.org>
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

Rather than open-coding the property names, use the existing constants
provided for this purpose. This better aligns the simple-FIT code with
the full FIT implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl_fit.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 5b5f6c620457..03ff9a5db9a8 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -43,7 +43,7 @@ static int find_node_from_desc(const void *fit, int node, const char *str)
 	for (child = fdt_first_subnode(fit, node); child >= 0;
 	     child = fdt_next_subnode(fit, child)) {
 		int len;
-		const char *desc = fdt_getprop(fit, child, "description", &len);
+		const char *desc = fdt_getprop(fit, child, FIT_DESC_PROP, &len);
 
 		if (!desc)
 			continue;
@@ -475,10 +475,11 @@ static int spl_fit_record_loadable(const struct spl_fit_info *ctx, int index,
 	node = spl_fit_get_image_node(ctx, "loadables", index);
 
 	ret = fdt_record_loadable(blob, index, name, image->load_addr,
-				  image->size, image->entry_point,
-				  fdt_getprop(ctx->fit, node, "type", NULL),
-				  fdt_getprop(ctx->fit, node, "os", NULL),
-				  fdt_getprop(ctx->fit, node, "arch", NULL));
+			image->size, image->entry_point,
+			fdt_getprop(ctx->fit, node, FIT_TYPE_PROP, NULL),
+			fdt_getprop(ctx->fit, node, FIT_OS_PROP, NULL),
+			fdt_getprop(ctx->fit, node, FIT_ARCH_PROP, NULL));
+
 	return ret;
 }
 
-- 
2.42.0.515.g380fc7ccd1-goog

