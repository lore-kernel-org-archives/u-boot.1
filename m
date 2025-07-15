Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E96C83F21
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 09:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACA8783087;
	Tue, 15 Jul 2025 11:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pPjzSj5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6709682F00; Tue, 15 Jul 2025 11:23:17 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65B3383043
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 11:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so3039955f8f.1
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752571395; x=1753176195; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EQrHPL/PEiZisgVdvYeS+g1xXYyUxlwznf6dFmGY+/k=;
 b=pPjzSj5MV2iz10aI1ByA/GqSk+oEXhHoo+tTz6V6UQ8HMDuqLNzyGZoERGQtNglrGe
 LETBysCsOnNy52QNUz5r8E9bhSA+3V9J9tSNPP2hrJA1o26ebLyyesuMz7YfIRf9OiOD
 pSxBb+aYaYBLbiVTBWEHSYkKHMTy7tDz8DFRHYRPIRcWmwO10rDh2+nC+sKIPnSA35Qr
 v5UMRM36HyVvjuTuWSfwWXKVZZReb8OADpl2cOHZ8R4ZHgEypVVfFU9D4rIaAihHX5yW
 zU8QbeaxKMK/IwK3PDrDKCVe7Hc8RxEtrYUj6xyfJK7uP9uGyccHSDT9/gAuc2y4+F8m
 OafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752571395; x=1753176195;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQrHPL/PEiZisgVdvYeS+g1xXYyUxlwznf6dFmGY+/k=;
 b=sIwsPLzuojNcG5/PZuSnv6WWMG6ktRqYW9MFqxvhqADqgjZ5K1wlJVAf17N+FK7MRl
 R/6dar6LwOqLzTIytAih69RITfv9y9Y4AdLdMH67TVjspbx+BoEADKQQ496gVeCYBbfL
 I/ViXZELOMe22PNmOx7M8PQ77TeGSBIXPO6aUXJn3kBNkXwa8XSdx6C4XgbBoyTiLemQ
 R7ETw1RIeVqbNQ4H3JmbpmumvsDXnSxgLAaGMNmEwSdOcpFxRsI2osJfXD39o/F8DwHZ
 Y9MzCAdB4+iZ2hLZZC6V7S4XDOn99EiADuC3GnABe3x9+ENm0/nKY/MMltiguf43TxhV
 iHLA==
X-Gm-Message-State: AOJu0YyJe2sdna58lp+0C8O+rNSOUdZm5n1wv41Lo1VHSzLzriUEY+8N
 mH6M5GCYVctBpUHPtrifmtqU4lkxHtbDC+iFPqLRicsOh3Bw55k7CbzSHVksWwZOhCNf1q2RURU
 if3yl
X-Gm-Gg: ASbGncudv376MFJs9GfoA3QivGuRsxoNMGp70pSJoYyGGlOZmKHfr4AMD3pM2A8tox3
 w4Yxgn4n6HqaEnZV/Yin2ZbVF6+Tv2F0tJL8uiUfuxpuhgSnLHsoot6DF/8W1w0A32btahgzXdk
 0V2FDWj8Z9IAPICE7IFQ6ej9PgXRPJ5dqDzO1Nu46EF/aQgryrvc2akp+370AgDmrY4Knry/PSw
 Hf8OQHvUIzk/KUjcWBk93sI4suFofO1N+g9nkmomLLv47t2xQdPWQN1ve3tEMhA+HTKC1gv8qbg
 Bt6DZMzqC2qp7b8xj/cmONF/moWucQ4ZFrOa8njw+TfZ6Q+VoMC6APcT0CYMw4xTVJfQp/lK5cH
 klrsSXrxk69vNn9TNqGzO45ysw5dc6d15gtCvmVvGlrgTctAkgRywHXg88na1
X-Google-Smtp-Source: AGHT+IFPr8R31JW91delp6r/6ysrRRFUtY9uxhgvrzEEjmMRPHDKIRW34SmksldygxGJVvIOt256aA==
X-Received: by 2002:a05:6000:4028:b0:3a4:ff01:218a with SMTP id
 ffacd0b85a97d-3b5f2e298ebmr10504544f8f.50.1752571394854; 
 Tue, 15 Jul 2025 02:23:14 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:c1bc:9f9a:fc67:a1d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d587sm14379588f8f.46.2025.07.15.02.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 02:23:14 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 15 Jul 2025 10:23:13 +0100
Subject: [PATCH v2 1/2] block: Remove unreachable code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-blk-uclass-v2-1-1bb1d2eee896@linaro.org>
References: <20250714-blk-uclass-v2-0-1bb1d2eee896@linaro.org>
In-Reply-To: <20250714-blk-uclass-v2-0-1bb1d2eee896@linaro.org>
To: Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@csgraf.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The two functions blk_find_first and blk_find_next use a for loop with
the content being a 'return 0' which means that the 'increment' code is
unreachable so remove it and also remove the variable ret which is
assigned to but its value is never used.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/block/blk-uclass.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index f3ac8db9464..b38c21ffbe2 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -613,11 +613,8 @@ static int blk_flags_check(struct udevice *dev, enum blk_flag_t req_flags)
 
 int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
 {
-	int ret;
-
-	for (ret = uclass_find_first_device(UCLASS_BLK, devp);
-	     *devp && !blk_flags_check(*devp, flags);
-	     ret = uclass_find_next_device(devp))
+	for (uclass_find_first_device(UCLASS_BLK, devp);
+	     *devp && !blk_flags_check(*devp, flags);)
 		return 0;
 
 	return -ENODEV;
@@ -625,11 +622,8 @@ int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
 
 int blk_find_next(enum blk_flag_t flags, struct udevice **devp)
 {
-	int ret;
-
-	for (ret = uclass_find_next_device(devp);
-	     *devp && !blk_flags_check(*devp, flags);
-	     ret = uclass_find_next_device(devp))
+	for (uclass_find_next_device(devp);
+	     *devp && !blk_flags_check(*devp, flags);)
 		return 0;
 
 	return -ENODEV;

-- 
2.39.5

