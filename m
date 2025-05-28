Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50676C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 23:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38459833C7;
	Thu, 29 May 2025 01:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q8FxM5UM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80EA883404; Thu, 29 May 2025 01:31:00 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE058833C7
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 01:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72bc3987a05so248729a34.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748475056; x=1749079856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+DgjYHg78BUiqqAEJGJpgEnyKm8kJ/eSxzxfgtF4qM=;
 b=q8FxM5UMe5uxeUClX+PE1ucjUs8TnXj9AGl+kx/1278RvSfpXJiYwwhepk4gNnOIFA
 tnSlPixptS/0miRNl8DkfHOXf/20Sm/QjMFeVlTxeHbOU+DUudeH5gYUGFfcZA4VcLk9
 qG9B9IjFTDmVN8eOYIHxx+9ICU2HEN/Is65v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748475056; x=1749079856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P+DgjYHg78BUiqqAEJGJpgEnyKm8kJ/eSxzxfgtF4qM=;
 b=eScshcoHHDewgVAcbs8bCS+4vGaYlzxBTtIlbKDPK7qiHp3ckgI6xHtsPO6NENpZnN
 XisZ3+x7ezQaREqIBdHTpab/2Fq2NTDH3bZuIZeURLNj8dFn49SncSove43bvKpA7uAr
 W99urjF30SFxvTlLCx20ICenAzRwLFs+nCiFDPb+c+W7B2mXPmI3EWyQkYOg/c4g0Hzt
 gYp4fArd8Qzben5D+sadXCgrbodrp/97SNNnt5urgWlXf6Z0B4L0++4htLsK+/LY2V8a
 LnXU2IUr+uvumUuvtoVRx+12h9xRc3+NByp1eudSq+I1vv9qHuvaEThMPOh/GrW7MIcn
 kccQ==
X-Gm-Message-State: AOJu0YwjnqU+195w3VqKrP1tlaz1xBdAD0UQbXMj8gp9vCZ3N4JCAy1R
 xhjCSgWFT1xc0JoNyMDYUaYrYDUwCrSspJ/UiTo0fbU1loNnxnVjojjdU/wV6hS7NeDdzymq6Rq
 rbm5pcUQ=
X-Gm-Gg: ASbGncvtsNzt3/gJtworbqcTMDDNyhqdfn3qJDfhPZ5jQ1mz/5TizncNV/abaksa9ho
 spXSo+PAZtjaVIqNkvZ2mDzjAFRzE4T4NSTuAkIsp0ad/XOWl74dxhUE4Z2s613DtmlsSU0qjTu
 CsNZMTDxhrdBhR7CyWIsDkSX8yS4pzuyER+H2E0zfdQuQxrM3gpZQbyo92Sr4uyUHQjZdgTQTw8
 WTC9Qn32IJ1AoI8KElCcvLnU1kPZdRCeMAv3CnRaf4kXueigJrRNMCtk9KBGPCXHx9DzjC51vs+
 K9fGR5nB6B63Fre//HxQD6maonaSe40oA8NPjSmRbkrxdo8M7nhX1B7+vpqOB5eoZxcIuzwz8mH
 b59S2FfUsT31a1iE=
X-Google-Smtp-Source: AGHT+IGnw8XRn8SUs8IfioLbFdT0j4sWsS/jPdhFyKHG7e7Al6AT7WeW3itYFEkBwYhjdRRVx6FOrw==
X-Received: by 2002:a05:6830:3884:b0:727:3587:fd1 with SMTP id
 46e09a7af769-735acebb033mr1061708a34.3.1748475056495; 
 Wed, 28 May 2025 16:30:56 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af9bc741sm58239a34.44.2025.05.28.16.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 16:30:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH 2/7] arch/arm/dts: Remove unused header
Date: Wed, 28 May 2025 17:27:05 -0600
Message-ID: <20250528233050.3820722-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528233050.3820722-1-trini@konsulko.com>
References: <20250528233050.3820722-1-trini@konsulko.com>
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

As part of moving to using OF_UPSTREAM and so the upstream DT related
header files we have a header that is under the arch/arm/dts directory
and now unused. We can remove this now to prevent any future conflicts.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/dts/exynos-pinctrl.h | 79 -----------------------------------
 1 file changed, 79 deletions(-)
 delete mode 100644 arch/arm/dts/exynos-pinctrl.h

diff --git a/arch/arm/dts/exynos-pinctrl.h b/arch/arm/dts/exynos-pinctrl.h
deleted file mode 100644
index 7dd94a9b3652..000000000000
--- a/arch/arm/dts/exynos-pinctrl.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Samsung Exynos DTS pinctrl constants
- *
- * Copyright (c) 2016 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- * Copyright (c) 2022 Linaro Ltd
- * Author: Krzysztof Kozlowski <krzk@kernel.org>
- */
-
-#ifndef __DTS_ARM64_SAMSUNG_EXYNOS_PINCTRL_H__
-#define __DTS_ARM64_SAMSUNG_EXYNOS_PINCTRL_H__
-
-#define EXYNOS_PIN_PULL_NONE		0
-#define EXYNOS_PIN_PULL_DOWN		1
-#define EXYNOS_PIN_PULL_UP		3
-
-/* Pin function in power down mode */
-#define EXYNOS_PIN_PDN_OUT0		0
-#define EXYNOS_PIN_PDN_OUT1		1
-#define EXYNOS_PIN_PDN_INPUT		2
-#define EXYNOS_PIN_PDN_PREV		3
-
-/*
- * Drive strengths for Exynos5410, Exynos542x, Exynos5800, Exynos7885, Exynos850
- * (except GPIO_HSI block), ExynosAutov9 (FSI0, PERIC1)
- */
-#define EXYNOS5420_PIN_DRV_LV1		0
-#define EXYNOS5420_PIN_DRV_LV2		1
-#define EXYNOS5420_PIN_DRV_LV3		2
-#define EXYNOS5420_PIN_DRV_LV4		3
-
-/* Drive strengths for Exynos5433 */
-#define EXYNOS5433_PIN_DRV_FAST_SR1	0
-#define EXYNOS5433_PIN_DRV_FAST_SR2	1
-#define EXYNOS5433_PIN_DRV_FAST_SR3	2
-#define EXYNOS5433_PIN_DRV_FAST_SR4	3
-#define EXYNOS5433_PIN_DRV_FAST_SR5	4
-#define EXYNOS5433_PIN_DRV_FAST_SR6	5
-#define EXYNOS5433_PIN_DRV_SLOW_SR1	8
-#define EXYNOS5433_PIN_DRV_SLOW_SR2	9
-#define EXYNOS5433_PIN_DRV_SLOW_SR3	0xa
-#define EXYNOS5433_PIN_DRV_SLOW_SR4	0xb
-#define EXYNOS5433_PIN_DRV_SLOW_SR5	0xc
-#define EXYNOS5433_PIN_DRV_SLOW_SR6	0xf
-
-/* Drive strengths for Exynos7 (except FSYS1) */
-#define EXYNOS7_PIN_DRV_LV1		0
-#define EXYNOS7_PIN_DRV_LV2		2
-#define EXYNOS7_PIN_DRV_LV3		1
-#define EXYNOS7_PIN_DRV_LV4		3
-
-/* Drive strengths for Exynos7 FSYS1 block */
-#define EXYNOS7_FSYS1_PIN_DRV_LV1	0
-#define EXYNOS7_FSYS1_PIN_DRV_LV2	4
-#define EXYNOS7_FSYS1_PIN_DRV_LV3	2
-#define EXYNOS7_FSYS1_PIN_DRV_LV4	6
-#define EXYNOS7_FSYS1_PIN_DRV_LV5	1
-#define EXYNOS7_FSYS1_PIN_DRV_LV6	5
-
-/* Drive strengths for Exynos850 GPIO_HSI block */
-#define EXYNOS850_HSI_PIN_DRV_LV1	0	/* 1x   */
-#define EXYNOS850_HSI_PIN_DRV_LV1_5	1	/* 1.5x */
-#define EXYNOS850_HSI_PIN_DRV_LV2	2	/* 2x   */
-#define EXYNOS850_HSI_PIN_DRV_LV2_5	3	/* 2.5x */
-#define EXYNOS850_HSI_PIN_DRV_LV3	4	/* 3x   */
-#define EXYNOS850_HSI_PIN_DRV_LV4	5	/* 4x   */
-
-#define EXYNOS_PIN_FUNC_INPUT		0
-#define EXYNOS_PIN_FUNC_OUTPUT		1
-#define EXYNOS_PIN_FUNC_2		2
-#define EXYNOS_PIN_FUNC_3		3
-#define EXYNOS_PIN_FUNC_4		4
-#define EXYNOS_PIN_FUNC_5		5
-#define EXYNOS_PIN_FUNC_6		6
-#define EXYNOS_PIN_FUNC_EINT		0xf
-#define EXYNOS_PIN_FUNC_F		EXYNOS_PIN_FUNC_EINT
-
-#endif /* __DTS_ARM64_SAMSUNG_EXYNOS_PINCTRL_H__ */
-- 
2.43.0

