Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78564C4167D
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 14:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BACF1871A2;
	Fri,  3 Nov 2023 15:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D46Y1fbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 332FC87142; Fri,  3 Nov 2023 15:34:36 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605AA87142
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 15:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=loic.poulain@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40839807e82so13561965e9.0
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 07:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699022072; x=1699626872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i8AT4yHLx7myQHaXQEVevfvoarPJSKGzHdi2ADx9GYQ=;
 b=D46Y1fbuV9j8PfnVmtukz1Xy7UAvX7ZsGIefOhzrp1hD0Kpfmy6KUVLJ98GCC7t83+
 u8zVOA1X7BQyNIT1omc/Y+R6fcIfYFb8SZ54Db68fGTWlbp8rT570SML/nDrpWuGfetI
 G8Dy09hPZbVlpPplkdW8kWCAMpRPuxJy1csRYEePv7dkdK1W30opb2StYmXbHV8GLmEx
 FE0SeIajeZsaORIk54pHXvunFtW3Pc8DXhJqRKx3eY/jLhhuYYNYg93sJpWO9gHlaGVi
 MZ4DWMfJq5P0WKnX58iShQEVmv5J+n7LV4OSu63ZwvLs5pN2/cKhNmgtA+apRUAJqTK4
 +/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699022072; x=1699626872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i8AT4yHLx7myQHaXQEVevfvoarPJSKGzHdi2ADx9GYQ=;
 b=ZuKdVHXKAvnBJVz5GDXl4kExPu4ilVf7SWE8yGsg94DW+T2jquGvsq45Kru0M/dQdv
 zW9yr0z5mpTjZ9honDtJ/vl8v39fZaKtDztK3jXKiVEvcAMurgsPC5oTUfkAZJDabqXb
 PJ/5Ylc7IhBrS2EeaPgqMEg0WqKPxYQEfVVcq53c0tA/iHSWmmhShc4xuEKB5eTgp5do
 /Cucq3btMqG1I70S7gG0oRz0TzGbOlylhoJTzKDC1K3RPD76V9SaCy1mQys8kq3Em9Ad
 T1ex1PHFG+Je/5urb22v6HDAMaoPvoc1fACV6Mr5tmLIsT9CK//IfPpCnS7B9PLxSGYF
 cGjQ==
X-Gm-Message-State: AOJu0Yzr5+ZxKbxgawFfzv+uJMCtTbZdQBP8OSIm2aL0cwPiJ5oQWrP8
 hdoT6ASSc9y5sjBwNSpYGtRGpQ==
X-Google-Smtp-Source: AGHT+IFwjBFQrL7/0bi7dHCxJss4kdWwzI5xO3zoS5GVlFUtX+rWel/frtrgfy7/fmf9h1hXmRiGsw==
X-Received: by 2002:a05:600c:21cf:b0:401:b92f:eec5 with SMTP id
 x15-20020a05600c21cf00b00401b92feec5mr3047168wmj.9.1699022071745; 
 Fri, 03 Nov 2023 07:34:31 -0700 (PDT)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:bd3f:e301:dcee:2fff])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b004063ea92492sm2683598wmi.22.2023.11.03.07.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 07:34:30 -0700 (PDT)
From: Loic Poulain <loic.poulain@linaro.org>
To: sjg@chromium.org,
	marex@denx.de
Cc: u-boot@lists.denx.de, abbaraju.manojsai@amarulasolutions.com,
 seanga2@gmail.com, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 1/3] spl: fit: Discard decompression if not supported
Date: Fri,  3 Nov 2023 15:34:24 +0100
Message-Id: <20231103143426.3643712-1-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
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

And simplify further decompression testing.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 common/spl/spl_fit.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 70d8d5942d..1d42cb1d10 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -208,6 +208,20 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
 	return (data_size + info->bl_len - 1) / info->bl_len;
 }
 
+static inline bool spl_fit_decompression_supported(uint8_t comp)
+{
+	switch (comp) {
+	case IH_COMP_GZIP:
+		return IS_ENABLED(CONFIG_SPL_GZIP);
+	case IH_COMP_LZMA:
+		return IS_ENABLED(CONFIG_SPL_LZMA);
+	case IH_COMP_NONE:
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * load_simple_fit(): load the image described in a certain FIT node
  * @info:	points to information about the device to load data from
@@ -235,7 +249,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
 	void *src;
 	ulong overhead;
 	int nr_sectors;
-	uint8_t image_comp = -1, type = -1;
+	uint8_t image_comp, type = -1;
 	const void *data;
 	const void *fit = ctx->fit;
 	bool external_data = false;
@@ -248,9 +262,11 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
 			debug("%s ", genimg_get_type_name(type));
 	}
 
-	if (spl_decompression_enabled()) {
-		fit_image_get_comp(fit, node, &image_comp);
-		debug("%s ", genimg_get_comp_name(image_comp));
+	fit_image_get_comp(fit, node, &image_comp);
+	if (!spl_fit_decompression_supported(image_comp)) {
+		debug("Discard unsupported compression %s ",
+		      genimg_get_comp_name(image_comp));
+		image_comp = IH_COMP_NONE;
 	}
 
 	if (fit_image_get_load(fit, node, &load_addr)) {
@@ -283,8 +299,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
 			return 0;
 		}
 
-		if (spl_decompression_enabled() &&
-		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
+		if (image_comp != IH_COMP_NONE)
 			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
 		else
 			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
-- 
2.34.1

