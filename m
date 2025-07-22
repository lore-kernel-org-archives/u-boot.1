Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC58C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 14:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ED8083321;
	Tue, 22 Jul 2025 16:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jhYHedDh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB6F9805D7; Tue, 22 Jul 2025 16:06:17 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B652483339
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 16:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4560d176f97so59836065e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 07:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753193175; x=1753797975; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G6ucfMS5OU9pYnnuYLa0fyLbsUIqQnH7ZgjPHwbEhBg=;
 b=jhYHedDhsOASR5Szjqo+bGLo+647xbWB26nSc3LC04uXZFfiEXAzy81atq982NhaIi
 Ck4L8B3yH/Lr71kCOK0ZNk8dhW/X/uqefFwQ2/aoTQkybW+jWfC0k20NKZhVzzTktoj7
 jKQOF6baV8YfEJUxrdvWel+uRchwN17aiCn7DTZHIV7yKFHtXY83TeCvcz3hJeYsjrNZ
 LToR/AXrFLdzw+LWPBrkGPuHljVCLkYt/M0Xr9IExJcE8kFigEC5I3qbtyZmpMRGx1lP
 32kacCMv2zY6psM1icPzf0FxKNVCvOz2luqzsedNsPWSUWX7qGMfg3KqGZNv5nJpq9wi
 hkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753193175; x=1753797975;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G6ucfMS5OU9pYnnuYLa0fyLbsUIqQnH7ZgjPHwbEhBg=;
 b=pX6DgJmwrivXabRm9TdqYw3tdps7K5FjFq1p4H66XITLdeu6AA/V76IVk2wd/uG07w
 UUkEw3Po0wToszHcYEeikwvfpDqUTbK+xh5s+zgOhOIzFxmM9iR0/massNbaMFSg1a+V
 o0PnubzEZSAHHSE5J341O7lH9n+Qwnv4PZUREvdSdJgzuI8Qrh5IqY7wWdiWD54lQaXS
 ETaOMTjVWJZGoYknzpUjMZ08v4SW3lqpc4pGRjnAUCXNclAwLp13BOyrFkt6eWVys8q7
 +qZWGm1LXBBGC40rtCGJsXHPnzslBB8QyckSeOOxP0RAzj9DwtKBG/GIEhhaeJqCO812
 NkYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQREZaJf42T06KJE9jgQuKD1fgAt59I1dHgAPXaiK7YEQEDrTB+aouh6cdQRBp94hPjetM14s=@lists.denx.de
X-Gm-Message-State: AOJu0YwafHebxUbzErRs+OT+rgaYakaELRcomaPnGWD8AOx955fiLwWQ
 2BixNp/JkjVqhB5scY5WeSjdQk080MEgmPCg5081duDrQFdwj2L9W09A8/A5B0EA5w1MskYfDmS
 rP5HX
X-Gm-Gg: ASbGncuLGIXsZeG8Kv0DZx3vXY9A6cx7gTlN3cMaee4YkMVkj4C2CJ4Ie1mxcU2z0au
 a9ZNd67dIJunzfj7Q7Yc8HGrjbL5M10mjtQwdG8qWXLyGNAc93dZFpAD+OCxkB1caB2P6BGcprG
 yuZzTV1yIERwd7PUV9XYMP+03G72MIjSws5hutdSIT5BRAWE5S075I7Sj2O1PGu/ysnJV9je3G1
 mO5e6brV5fLdxoIgoqLoG35/Y+rG32E71nxN97P5s1bi+qMzRWvmZau47OJgmvHEvQGvZ9MeTAm
 WQs1tEMko+e5gpbcy44nOD7W+O8xaqlHVOcLM3SP++1sL/Hrm0qnrZNvbOhISzbT3VH3tCP2k3e
 8ApfPwujRxMwVSS7K4VWxg2Xy4LUvpmR7IeLN0Y3KWNU3qpK8JNs=
X-Google-Smtp-Source: AGHT+IESmEyV9d3QVuAb7fm9m/hjTGtBqPoydbnRv/ZsM333S5FcON/gg8kCHdoG2ik+ABTEUmNVRg==
X-Received: by 2002:a05:600c:468b:b0:456:2419:dc05 with SMTP id
 5b1f17b1804b1-4562e33db7fmr260061875e9.12.1753193174889; 
 Tue, 22 Jul 2025 07:06:14 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:2943:d0d1:b3a5:d7fb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca319cbsm13790157f8f.38.2025.07.22.07.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 07:06:14 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 22 Jul 2025 15:06:14 +0100
Subject: [PATCH] adc: meson-saradc: uint cannot be less than zero
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-meson_saradc-v1-1-1ab45d53da9d@linaro.org>
X-B4-Tracking: v=1; b=H4sIANWaf2gC/x2NQQqDMBAAvyJ7bkATxdavlCKbZNU9GGW3iCD+3
 ehxGIY5QEmYFLriAKGNlZeUoXoVECZMIxmOmcGWtilba81MuqReUTAGU3uPnxiqt3MOcuJRyXj
 BFKY7mlH/JLdYhQben8/3d54X6TFThXcAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

timeout is declared as a uint but then tested for being less than zero
which must always fail. Change the while loop for a pre-decrement on
timeout and test timeout for being zero.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/adc/meson-saradc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
index 60e348968fb..0144ff828c5 100644
--- a/drivers/adc/meson-saradc.c
+++ b/drivers/adc/meson-saradc.c
@@ -205,9 +205,9 @@ static int meson_saradc_lock(struct meson_saradc_priv *priv)
 	do {
 		udelay(1);
 		regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
-	} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
+	} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && --timeout);
 
-	if (timeout < 0) {
+	if (!timeout) {
 		printf("Timeout while waiting for BL30 unlock\n");
 		return -ETIMEDOUT;
 	}
@@ -256,9 +256,9 @@ static int meson_saradc_wait_busy_clear(struct meson_saradc_priv *priv)
 	do {
 		udelay(1);
 		regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
-	} while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && timeout--);
+	} while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && --timeout);
 
-	if (timeout < 0)
+	if (!timeout)
 		return -ETIMEDOUT;
 
 	return 0;

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250722-meson_saradc-4bba9dc18333

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

