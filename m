Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1D9CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 15:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8570B83965;
	Mon,  1 Sep 2025 17:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bMrIfBvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DA2383965; Mon,  1 Sep 2025 17:00:50 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEC53831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 17:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b8b25296fso9606325e9.2
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756738847; x=1757343647; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8F1M2FYqltndt0oGNjGtUBlIVrsE9C76wG23tgfYo6k=;
 b=bMrIfBvH/lAivThfUKBKU92Wr4as8zCntP7GFNqhCw8L+YZOugELeNg98ok+lpTAg1
 nzxwctLapx5xnUH7HqFYk+kJEJAZYBnxGfdPelRMndJH+VWEV3TwgUmEIxzYyFbYdUuX
 3UilM0z4WhoUGGaAwkhxS95vArwlQkMpdfp5rlqrbxHAI4ENtUIo1OO2L7ZNApHbEK6i
 JSFJ1SkEaEsBJOWvsX/Sk1vl6YJ9NKINFA5OqRRg8bPVhXy0Kt+z8QgbdN+/6XkIfkgS
 f5k/kzLkpaCYJHsshemje8tp3som5j4XgcUbENPoarWDLUbXkiarF33gRNZyTUdb++Zx
 vvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756738847; x=1757343647;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8F1M2FYqltndt0oGNjGtUBlIVrsE9C76wG23tgfYo6k=;
 b=hu/MlhRpWqqS5YswClgLWNrlU90DbsnfErmdznmqTDXBPufburqH0aaK5wY0qLsmDe
 cBQC1Bp/EiccXX/a6PXBoJXCOdjdmaPw1/ygNcxGrDZQE7961vUgKla52PYPWcWu/JBK
 gGZy9fPIa17YCUgHUWy3OkV4qbg1uzheu7DngSdCDfw2HwWjDHC5taWsllo6zzI6p3cl
 EM/G4kxKL6cR4TNSFO+QW6qhduBw2ebUe4EN7ZBylPfLAFkIJcQZzJgL/PLOovkZjE9Y
 CJE2EyGkIl0VFcmLJ/74Dr5/6Fgl35emQ7AUgGP40vPBLZUa2EKunIbPVeU2hR3KZpLi
 fxDQ==
X-Gm-Message-State: AOJu0YzNESOZB7ZEBwTkBFN357DblluoN99vjyFGzg+trmuA4WMs1iy0
 GXg61MfJw6oN4tpE2hAsxwldCMIoQD6Ho4TImanD5UIN7xdL32r41uWkFzniukdhVjZPVFzEmO3
 /xQss
X-Gm-Gg: ASbGncuBFIl1IOjrs07CFfZrwH1qLwEUSXQpDA/rUVUVnte5KbGO6Uwkrlxs/l2gLKZ
 rxyXKec6iEBI29OT5ylRz1BqkWO1c+mFqd1lRUbzp+ckwH5txfem8qpjlzp0yuoO/jSmFMUiUhA
 nJNJ7ykOa9jWyq+/6q4T8mS7KnMpWmeeqQqbSWJ2Eoem5t+bMkrLQf5VLZ1kvSaPIpcxSgNpW8/
 My2cvVnKkzAdgB0x6t90pooY29EcL/4wMEg8fZnA1jckFNmHJmtT5auqIqmrDiR9HUxEf6zN41n
 VZI4DefgSuqMad8gKZEw5gzkdSarPxI9Oi+m5EwCGywXM0qkAW0o9JFA8WEYpKOx33RyxUnlkLd
 5rQSAsWvr46R1n8DWo9ZlOLsIT2smiC0ghwAnU1mRx7swA/Rq9P8NaNPV/Ddw2w==
X-Google-Smtp-Source: AGHT+IGeZ7zLW+647gZhNoO7i1ro/yO3tDUmjwoNxd7yJvI3IdNoKp0TNLf6pKRuhv0wUJ01qjEA0g==
X-Received: by 2002:a05:6000:3105:b0:3cf:fcb6:ca0b with SMTP id
 ffacd0b85a97d-3d1dddf3a55mr6311728f8f.15.1756738847297; 
 Mon, 01 Sep 2025 08:00:47 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:d654:76cd:40eb:b986])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d64ba4ff83sm5261027f8f.4.2025.09.01.08.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 08:00:46 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 01 Sep 2025 16:00:46 +0100
Subject: [PATCH v2] power: regulator: Fix incorrect use of binary and
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-regulator_uclass_fix-v2-1-5ce6f258f5f9@linaro.org>
X-B4-Tracking: v=1; b=H4sIAB21tWgC/4WNQQ6CMBBFr0K6tqagpOLKexhCpmUKTbA1M0A0p
 He3cAGXb/78/zbBSB5Z3ItNEK6efQwZqlMh7AhhQOn7zKJSVa20ukjCYZlgjtQtdgLmzvmP7Jt
 rrdE57bARuWqAURqCYMe9/AKekfbgTZj/D9+zzTx6zlPfQ7+W+/WPaS1lKW/GYqOMRqXhMfkAF
 M+RBtGmlH5JWGBc0gAAAA==
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
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

In regulator_list_autoset there is a test for ret being non-zero and
error being zero but it uses the binary '&' instead of the logical '&&'
which could well lead to unexpected results. Correct this to use the
logical '&&' instead.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Ignore -EALREADY errors from autoset
- Link to v1: https://lore.kernel.org/r/20250703-regulator_uclass_fix-v1-1-8bce90b7e07a@linaro.org
---
 drivers/power/regulator/regulator-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 09567eb9dbb..7aa47c918ad 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -389,7 +389,7 @@ int regulator_list_autoset(const char *list_platname[],
 		ret = regulator_autoset_by_name(list_platname[i], &dev);
 		if (ret != -EMEDIUMTYPE && verbose)
 			regulator_show(dev, ret);
-		if (ret & !error)
+		if (ret && ret != -EALREADY && !error)
 			error = ret;
 
 		if (list_devp)

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250703-regulator_uclass_fix-d9457eff7fe9

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

