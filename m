Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4454BCAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 16:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91D8D832AD;
	Mon, 29 Sep 2025 18:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FBdPJzEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE8A832DA; Mon, 29 Sep 2025 18:53:15 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC44682A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 18:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e3ea0445fso18081005e9.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759164792; x=1759769592; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T2NVRUncmMcTdoGCgChZKmtCY5IQrMfFmcWgNFDWJ8w=;
 b=FBdPJzEiRtwvX9sZ7BbDwEguNWCH+veghfaC442Q+ajCIZL7qk1mYJ15fOvo4sEKY3
 ti99kxsG2i+5xbdBg4maWae7lx9xEiG5ZlrTW+5teAwUM/bbC4LrRzFwyitNsbqVKg9O
 alQFF1zdQGEndpW1S4T+RniWjE4bGMJDw4MLeGE4/anuvjk35nxaaudfdAQs2ECMumOP
 uk+ymdnIA6wL5gjWN2T/ys3Pp5cfyi8vl/pSAfKz8ytTNTdCcYz1xdgOKiW84wz5MRY5
 q62YB53SJLCoESqTVdFecpX6tshhKbVIX4MVpKXznKBfwXRyq/0RUgJbPBJOwfOq5urZ
 dOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759164792; x=1759769592;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T2NVRUncmMcTdoGCgChZKmtCY5IQrMfFmcWgNFDWJ8w=;
 b=vTvvOuPxrqj/kViiFfeVT4iEHGfiKo8/GBEZWqDVps6nj/sAKa64FWJ5WDIOTGIrPM
 9X6LfG2YfyyBHKVGV3Q2vbP3y2vp4Bk/+UyrU7DA4dqnp31RyVtI/Xrrq/ktnlr2qF38
 DF1eTNDWEaEtGH5mi1RefXY/s4eZugF9xbLtddocQD9JPsCReL9rlQcMjDsntRwL9h8P
 qBLXGaEVlvoh+3yWrLUGaldQO8dYiMd4H2eRZK0M/L5pW6vY6pSg691uWvnCkBuNj2A9
 8w2gAqTSi1Y7JRtClScqKbUSM6+//RuE6a4t5GyncNFOSb3T8Jk2Y3lzYRuxPbi1BAb0
 E8Xw==
X-Gm-Message-State: AOJu0YwZTtZKOEnEy5eseerSBcezPHhCpKCVN1Yv2b0AzWhB6B4Db7eE
 ktomkrdFqK6j6tROwZp6x7jUZoAzCrRAcQiRRGhdLRmVLABsWj0pfoKv3F4wxMxTirU=
X-Gm-Gg: ASbGncvRW39z7w1zflIJE70JvSCfZgwezdJO1WvBBccFB4v8/ANU7l3uZSj1WDbrVEU
 6oFx8hh8hF6mueXxU6k1/TVQ7w4agMg837W/N6js/lyct10ViLUoQFkp5XavzKIbjGRx2RxAKyl
 7S0eXuty8G15HpXt39JCieX+cBVVFYkkK+TElfFyKZREULd+3IVCwtxmiSD+LT3tIQ1BWkQMEsN
 kweLHULAfWK3FjBcwR0oY01i3tFU/UcLhRNa7kVARqKe1KVwsUlMgI2133MGgmgh/kV9ZdU2jDP
 f/y7+Wa44GU6/mwivHYEvRsuNRBdJEBcDrYHVQu0+zLgJWlSRsUGepk15xT/zs+JiLPaJeii1gG
 exCs87UgiDuwO92tByFVSfiwI05LKNXUDr44uz299I29X7x4OePxJIyY4+XVA
X-Google-Smtp-Source: AGHT+IE9JLsUJcZvDbY8fZ0rdvT64fjHnCaAQ/jHMA5LEm0OD1aIyXhTr/XyOgRx27SLgIIW+vLLew==
X-Received: by 2002:a05:600c:4743:b0:459:d451:3364 with SMTP id
 5b1f17b1804b1-46e329eb11cmr165270315e9.24.1759164792137; 
 Mon, 29 Sep 2025 09:53:12 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:4bc3:3107:fbfe:562])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f53802sm20501625e9.9.2025.09.29.09.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 09:53:11 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 29 Sep 2025 17:53:11 +0100
Subject: [PATCH] usb: ehci: exynos: variable node should be signed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-ehci_exynos-v1-1-ca365752de84@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHa52mgC/x3MQQqAIBBA0avIrBPUKLGrRETolLPRUAhDvHvS8
 i3+r5AxEWZYWIWED2WKoUMODKw/woWcXDcooSZhlOHoLe1Y3hAzt1qMctbusEpCL+6EJ5X/tm6
 tfc6UJXddAAAA
X-Change-ID: 20250929-ehci_exynos-c703167dac21
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

THe variable node is assigned to the return value of a function that
returns an int. It is tested for being negative and then passed as an
argument to a function that takes an int. So 'node' should not be
declared as unsigned. Correct it.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/usb/host/ehci-exynos.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 1e4a5a0b6f6ce3ff7e14ec16a5250eddb5a13139..e1fc04efd2e986f11eb2e3add74da84dce74f208 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -47,8 +47,7 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
 {
 	struct exynos_ehci_plat *plat = dev_get_plat(dev);
 	const void *blob = gd->fdt_blob;
-	unsigned int node;
-	int depth;
+	int node, depth;
 
 	/*
 	 * Get the base address for XHCI controller from the device node

---
base-commit: 9710d98e8942151fc0c62d54100d9d27e8263d04
change-id: 20250929-ehci_exynos-c703167dac21

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

