Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F5AC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 23:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48CFD8343F;
	Thu, 29 May 2025 01:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ffWAzI/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 549BA83429; Thu, 29 May 2025 01:31:05 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31A783487
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 01:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72ecb4d9a10so347487a34.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748475061; x=1749079861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGyxp4AmHYR3jELHJzWu/0KbmCt2SBdWLg/pD+8d268=;
 b=ffWAzI/ipeWxv+3SHrwiynXE4DTKsNnSB6Ewm/v9m1/765NPJc+Nb7zsaGonf2B/X3
 QEneLrPmhEJPXUqW7yLvecGeQ/qaoriPQGfsq6DwLMBKUT3TXpkhcpv+cU5V9WaFj6Vz
 2LZv8H0nA+svH4ShlnICK9UDeCzYdJObUx8Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748475061; x=1749079861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGyxp4AmHYR3jELHJzWu/0KbmCt2SBdWLg/pD+8d268=;
 b=rxBiev8Xmx1iJ6rj+wU6jsO4BYR7Uy18khFAl+ITted8AoO/viprzjmrFcXo03olb9
 NdKT8DtNBy2NI6NaMjiFq3GPChck6YLLtvX/Z4HOzfFG7jAbJ7i8CI2RGqhsLxkFgNwX
 XR+TqYFsWKJpBYjJ8xK9jUfCz3U0EHQztWmiMbuGeQgEow/6bqzRELCtSC/8OqCi28De
 /TT+qhxQ2+t277wDHtl/lZ9cgyoSN8vzxB0usUnY631oOafMh58tZtRHliNlUIHTo6gL
 MvhihM5CO3Y1xuYO2LkTKPXNEUSnEVoJ6gY4l1H43qrwhQ1rs6o5viRvWMFPtafVtDyC
 4UzA==
X-Gm-Message-State: AOJu0YykWc9SEwyFxIuJHQnYeG7RKbI05P5zffbkbXvHWpPifDv3FaYy
 9UD7H7Ayc0a+kS/JXDuYf95G5BjxExNJaa3egVOatqnpn9WWxWcdS/dYR9+QMJ/RZ/zyzsJBF3j
 bWTNhB/0=
X-Gm-Gg: ASbGncv03zVuvJo5MmyZTbASeHciH+8JsghkVaqnZcRiBds2SRlNuLfigqYKForhezs
 ZWr/lzwOdkTyxhYNB/MiqwRb6dsuV3ZV/Ce3nWvGAJht3HVHPps+tPWKGJMtJwfZuQbaiz0tUbb
 Fm2znsvVj/WAWe6PpGYGMtrrzVE+nP2xlINc4TDV/B5U0ssihE2CVkdATKw9CMMvYpgqryzEQdg
 STQ4L+vyHPi1jDq6Dm0iRUIXUASswsfAZA9BkprFHKcUhFfGa27Td/OeptnjUc88l6nTUVDL1tJ
 NkEU0PKQ/thtOXAgJeedD6UysMS91/Q3GiwDoin3OhdZgFJZz6PGW3kErN5M5tl2myiBRMOy0hT
 wE6w+i0zKkRQ5ElM=
X-Google-Smtp-Source: AGHT+IE40TtnPhG03xn7BgIa1MMekd25CSsW+Eh7DZTBo3EiLu2H0tDexvG1GPGEUukXcn8Sllv35A==
X-Received: by 2002:a05:6830:6f43:b0:72a:10ec:3637 with SMTP id
 46e09a7af769-7355d0c276amr13064030a34.15.1748475061411; 
 Wed, 28 May 2025 16:31:01 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af9bc741sm58239a34.44.2025.05.28.16.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 16:31:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH 5/7] arch/arm/dts: Remove strict subset header
Date: Wed, 28 May 2025 17:27:08 -0600
Message-ID: <20250528233050.3820722-6-trini@konsulko.com>
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
and differ in being a strict subset of what is found upstream. We can
remove this now to prevent future conflicts.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/dts/k3-pinctrl.h | 65 ---------------------------------------
 1 file changed, 65 deletions(-)
 delete mode 100644 arch/arm/dts/k3-pinctrl.h

diff --git a/arch/arm/dts/k3-pinctrl.h b/arch/arm/dts/k3-pinctrl.h
deleted file mode 100644
index 2a4e0e084d69..000000000000
--- a/arch/arm/dts/k3-pinctrl.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for pinctrl bindings for TI's K3 SoC
- * family.
- *
- * Copyright (C) 2018-2023 Texas Instruments Incorporated - https://www.ti.com/
- */
-#ifndef DTS_ARM64_TI_K3_PINCTRL_H
-#define DTS_ARM64_TI_K3_PINCTRL_H
-
-#define PULLUDEN_SHIFT		(16)
-#define PULLTYPESEL_SHIFT	(17)
-#define RXACTIVE_SHIFT		(18)
-#define DEBOUNCE_SHIFT		(11)
-
-#define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
-#define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
-
-#define PULL_UP			(1 << PULLTYPESEL_SHIFT | PULL_ENABLE)
-#define PULL_DOWN		(0 << PULLTYPESEL_SHIFT | PULL_ENABLE)
-
-#define INPUT_EN		(1 << RXACTIVE_SHIFT)
-#define INPUT_DISABLE		(0 << RXACTIVE_SHIFT)
-
-/* Only these macros are expected be used directly in device tree files */
-#define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
-#define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
-#define PIN_OUTPUT_PULLDOWN	(INPUT_DISABLE | PULL_DOWN)
-#define PIN_INPUT		(INPUT_EN | PULL_DISABLE)
-#define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
-#define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)
-
-#define PIN_DEBOUNCE_DISABLE	(0 << DEBOUNCE_SHIFT)
-#define PIN_DEBOUNCE_CONF1	(1 << DEBOUNCE_SHIFT)
-#define PIN_DEBOUNCE_CONF2	(2 << DEBOUNCE_SHIFT)
-#define PIN_DEBOUNCE_CONF3	(3 << DEBOUNCE_SHIFT)
-#define PIN_DEBOUNCE_CONF4	(4 << DEBOUNCE_SHIFT)
-#define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
-#define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
-
-#define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define AM62PX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM62PX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define AM62X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM62X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define AM64X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM64X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define AM65X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM65X_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define J721E_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define J721E_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define J721S2_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define J721S2_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#define J784S4_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define J784S4_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
-#endif
-- 
2.43.0

