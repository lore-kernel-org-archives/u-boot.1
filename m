Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19B9C47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 14:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0117087D6C;
	Wed, 31 Jan 2024 15:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l9GMosDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44A387C13; Wed, 31 Jan 2024 15:14:52 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0CA087D58
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 15:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-295efc0b337so293250a91.3
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706710489; x=1707315289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LerXxWm6BeZsqPxtIYv9MKySaKGCH1Bknwa4+se9+fk=;
 b=l9GMosDFmC9LCqBOGq31hYyZiixDYfG7F7YzhYU5FCL+Y/5kAQ0sGCNrGaTKunR5y+
 5rGTbZKsAOjPhzfPlqJY0dLr2vyF7ycTcf/8XAIgUBFIVegOOERxCaZckYSOishCs4h6
 vU1krADmhA5oX/eUTmuNXc52o8FQihbIQ8mSF4+BWTwdQxSw7TSrgS8AdIddnRziEL2W
 ODgfdbvqFQbVzScE2xuSuO2VdJLLSOi+DNz9RYyupm4Bn25dxjAyBbCdm9Z0ErQnKKl4
 b6kpDrEs1kwOFesrhu90tF/AaWA7V+QAlfI9i5GoleRFEg7b0k6TYqeZz1NwQpmwT7fv
 xuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706710489; x=1707315289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LerXxWm6BeZsqPxtIYv9MKySaKGCH1Bknwa4+se9+fk=;
 b=fEOIvzlkUNe3g7Qil0KK9MIDK/mjHKhMgmN3UImh8W5J7/QW9qqyPHarAxy5VnaRu8
 gZ2NbNZzp+WXQDjzBKr/YTJqTGT9u1i4IK7RvDL4+UrdngC9Z8oKmoyEJtqUKm6XAaPE
 eK5pfN8Xzr2T4lEKLITljZGZO/HMFm6YW9DWF68iODzh+NMg/Yvl1LZEu+fptqJFNqTc
 60xYPPZaBovTJ6iNe58LMvhifYdCvJqoHE+GhN8AbXFEncxeX1IiHDJU1QG8/DfJz8AU
 rHIUxsGIebYSx71NVx/L7TDBwBp2M4Cp7qac/MNZLkz150tvN4viD+v2IDChd8Vjx3VZ
 L/FA==
X-Gm-Message-State: AOJu0Yyifq6dcFzRaU946k1dUHYHsRsJaemCd58c/gLVh5k4uhVDLLb0
 bOlOiKacIGd6nhv7ul+pF9/YhNMoNpHKEm4HE7PIWBiU+mRCuinl
X-Google-Smtp-Source: AGHT+IHvPB/XwMC8uPaJRuQi+VZW5OkqlmxaGEb467SAnrS1IoC5bxh1LC5jPKvwSmoKqh4rNOItng==
X-Received: by 2002:a17:90a:bb96:b0:294:9d68:228 with SMTP id
 v22-20020a17090abb9600b002949d680228mr1730560pjr.1.1706710488441; 
 Wed, 31 Jan 2024 06:14:48 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXzgHg10v/lRkvFoJ/P7DlnbhiSemy2AfsUb2t9CjhlYzYkd0hw+z/SIoQc9bychNGaXk1Fad0XJtTcw+JBS5hSSVi7jLDBT7EXLIBUzjHvFFJ1qu7ugLV99SucJfwZmxe6UigSkSGJLi/lS9S1wl9hNt0c7Np01D0Li9fDCKd8kpLYeiJOW18AG0+yXUDkXw3Btlog+AaUzpVESjJV7TKAET4LciC+BERSoyEXMOKRiGqSrPANeUL2oOMUp9VN9DcIYQrhHsTlTiYEO23FMpwonL3ZXhL+ceAr0sCT/chBYi1lWcP4np1S6eQnYmlIz4hq9tcsCHARBkMbjOcgO3hV3IGursbhpzE/uWJWyvNJ6OHXN8XH7MSQiA==
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 mm3-20020a17090b358300b00295bafadb4fsm1534954pjb.57.2024.01.31.06.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 06:14:48 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v3 2/3] driver: rng: Fix SMCCC TRNG crash
Date: Wed, 31 Jan 2024 14:14:25 +0000
Message-Id: <20240131141426.34926-3-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131141426.34926-1-o451686892@gmail.com>
References: <20240131141426.34926-1-o451686892@gmail.com>
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

Fix a SMCCC TRNG null pointer crash due to a failed smccc feature
binding.

Fixes: 53355bb86c25 ("drivers: rng: add smccc trng driver")
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
v3: add Fixes tag
---
 drivers/rng/smccc_trng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rng/smccc_trng.c b/drivers/rng/smccc_trng.c
index 3a4bb33941..3087cb991a 100644
--- a/drivers/rng/smccc_trng.c
+++ b/drivers/rng/smccc_trng.c
@@ -166,7 +166,7 @@ static int smccc_trng_probe(struct udevice *dev)
 	struct smccc_trng_priv *priv = dev_get_priv(dev);
 	struct arm_smccc_res res;
 
-	if (!(smccc_trng_is_supported(smccc->invoke_fn)))
+	if (!smccc || !(smccc_trng_is_supported(smccc->invoke_fn)))
 		return -ENODEV;
 
 	/* At least one of 64bit and 32bit interfaces is available */
-- 
2.39.2

