Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1EACD0402
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 21:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA98B83E48;
	Mon,  5 Jan 2026 22:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="beSKaOUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B213783A24; Mon,  5 Jan 2026 21:47:50 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7367083936
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 21:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-65d1f0a9f54so93478eaf.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 12:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767646057; x=1768250857;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1ygLvWqskVBEVU8wly+gu4bVYJF46nN9Ow66mudZJqA=;
 b=beSKaOUcgQD/nr1wS4wGifY1kexaxJne8VcQw7G+UI+eXcv4Mn1q/6qYvWMzjaUaMf
 rojX11o+k91GXibzIh23lOy5NRm4IxcWb1wvaVd31CgjaEo25H3X1Oa/YL9awsi7DiMW
 fyofPv+T/mxPvSKf0Mj9hqjitdfNcKOSkQc6iLzQHa3nGpUgW1UfE+7aUS7maVNlMWCZ
 j0O5BQC4c6mQfagqqn70WwmG+ibol4iUekpmnP+aeffEZh3fYoK5Mogp+bA+U71VlziU
 SwQMI/Cn6TowvevC7dwFk/a+FMOhFtMv/LMgKs7WxmIUfz4POMudgAJWhqLzleTzHWxB
 WBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767646057; x=1768250857;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ygLvWqskVBEVU8wly+gu4bVYJF46nN9Ow66mudZJqA=;
 b=IHrl7giI2zpUBEgcR1L0suDLbjnV/x0UwC4HM4bFE/BsBoU9pewxtvN8jmGweIyC1C
 tSpAnRmpooKSRSW0ixz0KBUnRwsKES3dB7fz6Pw/Pv1vjwo3s38CoyuXHCmKnBsifWo2
 aE5u6Vg+rM8oIuMUVb0NNevnLkne7/7ld0EDfijefKtX9gBQs70FOHvip5F0o5cAC+k3
 4y+zt6vfjdSAGUliWoKPHtepxmbkzP6D/5sG3fK7FjmnJc3fT75X75UK9fTkmM2R++YT
 7ZQ71LF0/FFsQSyuZDFbqrwzOJePTMAEsfcQ2gdMcK7BWy8FSEhn2+AyaN1oe/owLtbH
 sisA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLUGCZ9vNI5hJNYn+pSt5HIPgbBSigV3uvjXz9Fd4fJWg+z6vucxTeEz3eSEff2GS+JWC+CGI=@lists.denx.de
X-Gm-Message-State: AOJu0YzE3NBZ7GBeH8UtYgX6W4bCC9zieMRMsXPspHjBtp3SXqn7efC4
 7mWp0SbpAMg8ZyIHA3YH/tPSCY+goB66jF9aGvPcVmIvjGlckchkuGWvVqTOiabGWL7P3b1eScO
 ZOIR0
X-Gm-Gg: AY/fxX75zASAeoac6SwyXZxQFq03SxcUBV7KvgObgq7GfHuM+P+wlxNDdlxIxqugBlS
 YdFZxDU+HOZWIdYgnMBmHImZyat0cRkjP5ZXSrwj8PnLSqfkG5aA2+VCTswu8Vx5xX9URLn5dWk
 wNvtOEtp5343Ximt2XWf7uFwVJr7sX2U8Tq5jYorMvxbHw0fts1t716VoqpvozJkFyFUfUlWmzX
 ZhlXyHvyS7enalVjtLK3gP+CXRzpaHVy5MnMnMUlBey/WH7h1MLCswbjWQAz6bhvXa9CvRkAMA3
 EOk9HyIMHVYDNQcYlOXlAA59CbF3C8b5QVWKBr4fS4KZ/3sJca067Z4fuLYvGDwkBcfY4EVAUJw
 13rLpYbvtV9gjCC4iP6NyR4AznqWRQq4aQ31KedD83TUoLKiwUEOaqaCQRMwqyK4TMewizpJ6sQ
 4yLuWp8GxqH6Z0PQ==
X-Google-Smtp-Source: AGHT+IGBu5uFN65sTlKyh+OXxKG17CvRKQpm1QJA+0Wfehz2oZqHkLFvQ3vgLuMM2U58I/fbr7AlGQ==
X-Received: by 2002:a05:6820:2282:b0:659:9a49:8df9 with SMTP id
 006d021491bc7-65f47a5e5bfmr406797eaf.59.1767646057145; 
 Mon, 05 Jan 2026 12:47:37 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:df5e:737c:7b32:e5d])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48cb1444sm81199eaf.11.2026.01.05.12.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 12:47:36 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Jan 2026 14:47:21 -0600
Subject: [PATCH] arm: mediatek: remove extra gpio header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-mtk-remove-empty-gpio-header-v1-1-01dc6c70eccd@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrDsQNemiVyldmOZXhxITJiIW8
 e4Glx883kEFKij0ag5SbFIkLRXto6HvPCwTWEI1daZ7mtY4juuPFTFtYMS8/nnKknjGEKDsa+R
 sb42Ho7rIilH2e//+nOcFBBqYz24AAAA=
X-Change-ID: 20260105-mtk-remove-empty-gpio-header-b26054340be5
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=SOz7haH3EtvmLoySUVq3QqDdpmvmPy9E9hz6oPHbXew=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXCNh90wCqs4QPVbZ8Hbp/kXeTZLOfJXPzfeAI
 lFl8i+gq5GJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaVwjYRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AU1gH/1SSTF9TUR/D3lfe40Ccf/ym90RXCBDPPTCfr9a
 Cq+6OHwvCnslJRBlqtarTlRA8zeAS5WRWoo1agY2Cg/Bv58zQvo+HnZqSU/ffVcG4zeUQc7rerA
 qfgoZsnLQkfSgXKOpMSqiBLZl5VynUj1CJdu5FOK1tBkkPeCNqOjA7W3X8Tdi2O5CLJM+bgQHi3
 k0rsvtDtxORevkV7tp1x30HmW9Qgl0bAaMPWxWe/qg8/tNWA+R8DoBi+OqwwLBs5pKof1Hv0EIk
 Vw3S1iJBVoLgNQWFrnmicvh3C1isD9ulfgPqNKaaIHsH6g35u8SiXwvpgWykzydh6SI8j9wt4BA
 735o=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 05 Jan 2026 22:15:13 +0100
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

Remove empty gpio.h header file and CONFIG_GPIO_EXTRA_HEADER on
ARCH_MEDIATEK. There is no reason to have these since the header
doesn't contain anything.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/Kconfig                          | 1 -
 arch/arm/include/asm/arch-mediatek/gpio.h | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0485fe78e10..1a6b77cb2b5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -865,7 +865,6 @@ config ARCH_MESON
 config ARCH_MEDIATEK
 	bool "MediaTek SoCs"
 	select DM
-	select GPIO_EXTRA_HEADER
 	select OF_CONTROL
 	select SPL_DM if SPL
 	select SPL_LIBCOMMON_SUPPORT if SPL
diff --git a/arch/arm/include/asm/arch-mediatek/gpio.h b/arch/arm/include/asm/arch-mediatek/gpio.h
deleted file mode 100644
index 4ea1020634e..00000000000
--- a/arch/arm/include/asm/arch-mediatek/gpio.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2018 MediaTek Inc.
- */
-
-#ifndef __MEDIATEK_GPIO_H
-#define __MEDIATEK_GPIO_H
-
-#endif	/* __MEDIATEK_GPIO_H */

---
base-commit: c457e4b5f47ba854721b7c1ece501eb324b032ee
change-id: 20260105-mtk-remove-empty-gpio-header-b26054340be5

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

