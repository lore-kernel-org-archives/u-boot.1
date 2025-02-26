Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991F6C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 20:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2804C81196;
	Wed, 26 Feb 2025 21:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PsHFUj+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C260F811BB; Wed, 26 Feb 2025 21:31:38 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0B7D810F6
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 21:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7c0892e4b19so21538585a.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740601895; x=1741206695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xo4BpIfNiWVxcUslvkwQjbrqym/WDnLFGP7KA+z0Lpg=;
 b=PsHFUj+o5XksWb0QRGHPQR6OQkMNkcBvo/JMmOdBI/wnaF7oBKYhZDxzNikLaKP5eQ
 MwxSK1fS6tln6PClBF+s0uW2w6LHvUCjOVyrQOe5JBBNJTIJA52Mgjz2VC/M4owSuwA9
 p/Rq8aDP5zqFRGwkBxESDMq8/FW6o1+LeH5Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740601895; x=1741206695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xo4BpIfNiWVxcUslvkwQjbrqym/WDnLFGP7KA+z0Lpg=;
 b=qmY/rsebfGaiOoEt0Y4svKxAwoOywY8vy8fqAy0WuggBJOdtBGNKPv0+g/JBpvx02L
 KeQyGBt2jx+jllRVLyYSZh6Ch4VlHTe3C0cNX+GjywFRMfG00CPDVLxjIRp8nWFDUdzg
 BCQnjsUXEnpCND2EnGXOqqTrxnplBxJQHsLYOE5l2qN6TR0KTFSEu5+P30TsHxfr47qR
 mMPKcMt89z0pHBOalztQU9AgsEi9bfHoLUQKiFBjNKuRhck7hHDg55vs5eNwf43eU/vq
 csstxS4x5ADeChwoZ+rGVDFUB1SNQJ8tv7w2xwzyai5N7j5NBh2Yr4YoV9ALNwNQtFOw
 wDLw==
X-Gm-Message-State: AOJu0Yx04uBNq4vJfxQYYoGrWyw/GpwbTFpCmuyNOatH0nEKSbOvOy7i
 FhTd6erum04yT609INJ8L4RniuFQLNnomumKnL/iMF+GNxfC6NDlFUM4jlc9HQDF/nuNmEte7eC
 Q
X-Gm-Gg: ASbGncvT2k0Om9xFLloP3FETBiH2Gd7FT6S3bw1P3unVI0Ih8G6N3071NORN1LHB3HV
 cS4liMJbYAvEezFplE1TUnsYqzdLKksy6GoaHr1f+1dK73aVEZ2EEF9iUqpgq4UUDpKZa8Y+Hl6
 ecosK+EyNosp60399ycJoUKe0tD1RwT+h5vvxbyrlQzm6WcvEe7VpM0Zh5msE6aLrM1XI+QwqxZ
 Wg7QWKx10SczB0I6+l/WD2DPUKkgTHcwwiKbD5pCXjLDIF/vJY1mUNazrBNNXxIGeV+sbju+IQd
 wGtCdNgc8SnXFEIg94rZVvxvu6w=
X-Google-Smtp-Source: AGHT+IHWOgza2MD2oATt4QKdHLclyOWZUMNrMYZrgGolGNC5jq8LlfxqgZwF11oECP8pMvcztY8xXw==
X-Received: by 2002:a05:620a:319f:b0:7c0:abe0:ce42 with SMTP id
 af79cd13be357-7c247f42957mr583187085a.26.1740601895573; 
 Wed, 26 Feb 2025 12:31:35 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c36fef5b38sm726985a.34.2025.02.26.12.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 12:31:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH] gpio: x86: Correct usage of IS_ENABLED() macro in
 intel_pinctrl_defs.h
Date: Wed, 26 Feb 2025 14:31:32 -0600
Message-ID: <20250226203132.3832001-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This file was using IS_ENABLED() to test for CONFIG flags but omitted
the CONFIG_ prefix and so did not work as expected.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 arch/x86/include/asm/intel_pinctrl_defs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel_pinctrl_defs.h b/arch/x86/include/asm/intel_pinctrl_defs.h
index 5d83d24bae2d..f45c06076f57 100644
--- a/arch/x86/include/asm/intel_pinctrl_defs.h
+++ b/arch/x86/include/asm/intel_pinctrl_defs.h
@@ -133,7 +133,7 @@
 #define PAD_CFG2_DEBOUNCE_MASK		0x1f
 
 /* voltage tolerance  0=3.3V default 1=1.8V tolerant */
-#if IS_ENABLED(INTEL_PINCTRL_IOSTANDBY)
+#if IS_ENABLED(CONFIG_INTEL_PINCTRL_IOSTANDBY)
 #define PAD_CFG1_TOL_MASK		(0x1 << 25)
 #define  PAD_CFG1_TOL_1V8		(0x1 << 25)
 #endif
@@ -150,7 +150,7 @@
 				PAD_CFG0_TRIG_##trig | \
 				PAD_CFG0_RX_POL_##inv)
 
-#if IS_ENABLED(INTEL_PINCTRL_DUAL_ROUTE_SUPPORT)
+#if IS_ENABLED(CONFIG_INTEL_PINCTRL_DUAL_ROUTE_SUPPORT)
 #define PAD_IRQ_CFG_DUAL_ROUTE(route1, route2, trig, inv)  \
 				(PAD_CFG0_ROUTE_##route1 | \
 				PAD_CFG0_ROUTE_##route2 | \
@@ -354,7 +354,7 @@
 		PAD_IRQ_CFG(NMI, trig, inv), PAD_PULL(pull) | \
 		PAD_IOSSTATE(TXD_RXE))
 
-#if IS_ENABLED(INTEL_PINCTRL_DUAL_ROUTE_SUPPORT)
+#if IS_ENABLED(CONFIG_INTEL_PINCTRL_DUAL_ROUTE_SUPPORT)
 /* GPI, GPIO Driver, SCI interrupt */
 #define PAD_CFG_GPI_GPIO_DRIVER_SCI(pad, pull, rst, trig, inv)	\
 	_PAD_CFG_STRUCT(pad,		\
-- 
2.43.0

