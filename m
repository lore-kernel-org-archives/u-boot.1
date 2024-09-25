Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE39BC369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B6788D4A;
	Wed, 25 Sep 2024 14:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eWWu+KLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B9588D38; Wed, 25 Sep 2024 14:58:13 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92DA988363
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8d0d82e76aso689010766b.3
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269091; x=1727873891; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3G95XjMYDkw5lYDWoK8P1mbMpSX44rLcDMhfAoS3ZQ=;
 b=eWWu+KLTQTDBtInmMAVcdLuBmkawXd/sLzQECkG6J6i+WT18qm9TjSieN7gzMmgvgf
 3XFTn+YpusJxXdSM1CEtovBEE+ugWXzrSbv0TH9QvR6nRBXrDW25G3XJM7Q/vPsRwCrG
 5Ek/SCVAbOQIkoplbkHQdy1BdrFbtB04Gv7qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269091; x=1727873891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3G95XjMYDkw5lYDWoK8P1mbMpSX44rLcDMhfAoS3ZQ=;
 b=AchwJvMUs7HB/bq6baS8C3UPK7WI/+QFsbQQQPh8NuXooMVDHNaBLn7loByRlgt3DC
 WxUJ1tYuPMpf8WgLorQ5V/9rDHd/STd1zOAg+Blg14ru3xFWw7oJRGHmShzYbCLuC39I
 qlCeIs0KH/zi6JFWbVfWP4GjynF87MJkXGMKDCPefN8PydiGPzoafGtNwLXqit8OoQ0J
 kfgrqrHmnlzFMnrch3yZxgaS+G2VUdNkJu7IPyrdjxtJvSFCFDBuPBm8xrQXJEfbE9so
 nM5OmwVdJuQt0EVUMRMxYp0B8VctGtiO82B6Gw5zeeltj9XmvlXqn20ImWm69cgWh/eR
 /5Vw==
X-Gm-Message-State: AOJu0Yw4E403uUUXM6YWr4lg4SZahacB/4C5lTsl+pWEsC5L6GHiCR5K
 d0SO3JhUVqBmEEoqJynTz3ALfnq58PrLgXZU4BMdhm8RJfPt4sl8JNjKxKitlG3kl9eqDBbNrmL
 xiQ==
X-Google-Smtp-Source: AGHT+IGxMPAg8sj7X5u4BINGGAFuZCVZQaJMljsFlb3pfvU45iF+Zk6dnAkQ/G9oa7EWggZ0JXwHFA==
X-Received: by 2002:a17:906:6a03:b0:a86:820e:2ac6 with SMTP id
 a640c23a62f3a-a93a037e463mr319986166b.22.1727269090855; 
 Wed, 25 Sep 2024 05:58:10 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:58:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 13/19] spl: Show how to fill in the size of the next image
Date: Wed, 25 Sep 2024 14:55:39 +0200
Message-ID: <20240925125622.197915-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

Binman provides the exact size of the SPL image being loaded, so show
how to fill this in. The code is not used, since it does provide a size
increase.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 2466b98f5a8..878036210c4 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -275,6 +275,7 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
 		/* Binman does not support separated entry addresses */
 		spl_image->entry_point = spl_get_image_text_base();
 		spl_image->load_addr = spl_get_image_text_base();
+		/* if needed: spl_image->size = spl_get_image_size(); */
 	} else {
 		spl_image->entry_point = CONFIG_SYS_UBOOT_START;
 		spl_image->load_addr = CONFIG_TEXT_BASE;
-- 
2.43.0

