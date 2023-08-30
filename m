Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EA1C83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 767608666B;
	Wed, 30 Aug 2023 20:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hNiRavjt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A786B8654E; Wed, 30 Aug 2023 20:06:01 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A0248656B
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7926b7f8636so29719539f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418749; x=1694023549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U1JdfbjUOAU6oAxs85UkGVTsh+OlxixQf+LHt91pTYE=;
 b=hNiRavjtXbaAbYCkQo6aTKd4/nn8/v1ERsIq2TL1sio/VP2iSXv5AWS9A3hJHM8NLw
 BqivVMyLYdqkAPndJ+i9qzc/E4HAyZkyEJXhERiSWNJsYSzMGa0NgOB5zuuZt0Vr0PxL
 Ua7Omt22NhuSGXqsd2lbDT6YGjcBoap6lKfLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418749; x=1694023549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U1JdfbjUOAU6oAxs85UkGVTsh+OlxixQf+LHt91pTYE=;
 b=E0DVSyAYntRPo18DncyPLTILmL7GQrJa95+xReSg1WOG2EcmMGdPzEFXfpSb4fGkha
 0pOd4XAe7Y3vsxAj0IHjMeCxpQWOzF1qRrleteeVdJsUVThp0Nsed/InNFCugswvatL0
 B0aahIJNH15HAR+Rygc9MriauyL+UJTQKdlMDBNOnqL2cqKEaeR5IW5n4CG7Y2MVQRQP
 wxKBW1M5Akhwxuge1inJjNDJcNeNtJ3OLNUw1WrnvgtxxlEZl8Gh1zmRxuqL/bJPOM5O
 Ie3AARF3A+TW20ZLhVX/8BNhxNkTSzKifOwLF0ZuPTpuaWXYc1g+TQnQnM7hngD/r1dA
 pimQ==
X-Gm-Message-State: AOJu0YyqBaqQkktXmmipuIhOUdSMVOtnsAxSancRZ0ci17EmO1y/tAQX
 +nMm+ACMNkPbB9MPQY5tHkzvKQqKGggYbilDRu8=
X-Google-Smtp-Source: AGHT+IGBtnfDnqlGLxoxuMS/6oN3aJayBpR38SKQeQOkVDnJnf+qPF7i0igYLHKypgEyCtrNDce5hw==
X-Received: by 2002:a05:6602:4896:b0:794:c9a8:27eb with SMTP id
 ee22-20020a056602489600b00794c9a827ebmr326389iob.5.1693418749191; 
 Wed, 30 Aug 2023 11:05:49 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 13/32] spl: Use the correct FIT_..._PROP constants
Date: Wed, 30 Aug 2023 12:04:44 -0600
Message-ID: <20230830180524.315916-14-sjg@chromium.org>
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

Rather than open-coding the property names, use the existing constants
provided for this purpose. This better aligns the simple-FIT code with
the full FIT implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl_fit.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 5b5f6c62045..03ff9a5db9a 100644
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
2.42.0.rc2.253.gd59a3bf2b4-goog

