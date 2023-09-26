Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8040AE7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A51D486E2D;
	Tue, 26 Sep 2023 16:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bjYx6hng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7179186DF0; Tue, 26 Sep 2023 16:15:53 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D30F386DD6
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79545e141c7so243914839f.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737744; x=1696342544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9tZiQj2NquCsO5mXz4QBmjn0BYTvW6h3v7ktj7Srfo=;
 b=bjYx6hngSSHmOakwSef6SJJutFTNwP+dfPHgFiqOiD2y98K58Hnqj3rfE+5lzbAUCm
 IFbkssbhD5QalKzlJf1fw1wY2g+5A9E5kd8gXrjdcUHyJm+ojCmQUSzQ0TkDpte4LOYO
 IB7j1Q/hfDBF4jlY3UkDUHoPBJ37gb+mVj6sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737744; x=1696342544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9tZiQj2NquCsO5mXz4QBmjn0BYTvW6h3v7ktj7Srfo=;
 b=GpEt6sA8o2hFlyOxoQmd1XP3R29JM2X7bttvQwjk9Berltvs9BzmyKeu7O9q35L4Pe
 mv2c2Cqh6t+QsezZgLjXJzxG5HgXsYJXukktIrpmh+SE1QOZAH9echEPsVi75Ayb1fBf
 MfjePk46PecbSvkSV+H/CF/iLWKrLHM51gMR4CSUO6I34Ea1a+dcIQpQ37pgm8gJAo8f
 97BqHR0bbpAagXXcSMMJRf527YcD5KDvZDpu0NTAkS8mqTt+uAPB1SH8YAVEhIjXS12O
 wzyaykquXUaWkcFDjtqbDeTLQtqqO1vRlkgYydZD/s5LnQRmWYUgS9tZ8HYKjEbBoI7v
 CgOg==
X-Gm-Message-State: AOJu0YzBgwTR5FW2mJXve0DUT/0wy+R8kPEtCd4/deU7ipjvlc9PCKeS
 6pkHWsDVjJ8as0iDDIKGQCitTJvTfQXr083r9JE=
X-Google-Smtp-Source: AGHT+IFvjdBw4J9EMDdHDLJ49bVyiwjpNz3/IR6fxO0Qp4J3sa6U4LRjuUTRHkMWnSDgty8mpRo5GQ==
X-Received: by 2002:a05:6602:480f:b0:795:d33:861f with SMTP id
 ed15-20020a056602480f00b007950d33861fmr2480780iob.6.1695737744462; 
 Tue, 26 Sep 2023 07:15:44 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 21/44] spl: Use the correct FIT_..._PROP constants
Date: Tue, 26 Sep 2023 08:14:35 -0600
Message-ID: <20230926141514.2101787-22-sjg@chromium.org>
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

Rather than open-coding the property names, use the existing constants
provided for this purpose. This better aligns the simple-FIT code with
the full FIT implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl_fit.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 12bd00694ab8..762828544f6f 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -44,7 +44,7 @@ static int find_node_from_desc(const void *fit, int node, const char *str)
 	for (child = fdt_first_subnode(fit, node); child >= 0;
 	     child = fdt_next_subnode(fit, child)) {
 		int len;
-		const char *desc = fdt_getprop(fit, child, "description", &len);
+		const char *desc = fdt_getprop(fit, child, FIT_DESC_PROP, &len);
 
 		if (!desc)
 			continue;
@@ -476,10 +476,11 @@ static int spl_fit_record_loadable(const struct spl_fit_info *ctx, int index,
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

