Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4309CD493D
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10EAA86DB5;
	Thu, 21 Sep 2023 03:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fXWlB7kf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9FF686DAE; Thu, 21 Sep 2023 03:58:03 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A30086D7A
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79d1a920137so21128539f.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261477; x=1695866277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sM51kDu9E3jeyr/KNGV0RRsyMMy9BHZZ4VYramK76O0=;
 b=fXWlB7kfjIWFJHvh+Nkg+9CF9Xok75GnLbR75xuPv2syw9veH0Co0qgkpf9wMU7zuD
 UVcMraPR3bqifUyLly1hVq9YMGJsmiDzEZgPtbm+lbS/lwAAnPHI3dpV1zHbfoJLRun1
 rBXvCEP8UWIDgB6KfL1VRs52CWCNeBc3dLC6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261477; x=1695866277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sM51kDu9E3jeyr/KNGV0RRsyMMy9BHZZ4VYramK76O0=;
 b=je3C62XhWO+I77D4L8TmcpJbacxk6JpdCE13p8sY6lL54aU2qg5UohiveOLje2M+F6
 WxxWYAjBQsIFnDMLJ9nanbACFUC3eHrcakYTmsnrJjd00t31+CgSBNZxsWsnxPrDaR0y
 fU+bkRdajtwQrHHwHdjTMiu9R6LN4mgzFwa4KVgNSNbfNvQCnnYE9uAgrEZX/A2IU2gb
 PfRPxMT2NeWrKOY+XsXUPMrceoJiLXob05R8x4J47Ougru0tk9MidD/Zekf1Iw+JUzxD
 TR4P2viJfUScf607oxrqwhEZrZB2ck5nsOANchHbU7gnV0950b1z877C1dzDES1IvuiT
 USVw==
X-Gm-Message-State: AOJu0YyrTI0EDmXELlo5sDLA2lJX/LfRAsS6DxhU06UqhCBa1SMFFIUT
 0FS3WE6wDxdDTTKlkBhd0w8yC/4sKIfZyLH1o+E=
X-Google-Smtp-Source: AGHT+IHn+btA9oLZpcUwAiXbTxJU2SvaQarKtjmP11e5wSmX2eYAyrWrys553n/sGSn0wggNpGRplg==
X-Received: by 2002:a5d:8b54:0:b0:786:f4a0:d37e with SMTP id
 c20-20020a5d8b54000000b00786f4a0d37emr5319290iot.4.1695261476784; 
 Wed, 20 Sep 2023 18:57:56 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 13/32] spl: Use the correct FIT_..._PROP constants
Date: Wed, 20 Sep 2023 19:57:02 -0600
Message-ID: <20230921015730.1511373-14-sjg@chromium.org>
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

