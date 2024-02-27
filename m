Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC949C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78F3688033;
	Tue, 27 Feb 2024 17:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="poig2AiW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EbUhue/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5058800E; Tue, 27 Feb 2024 17:10:13 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB0F88012
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TkjBC0nX8z9stK;
 Tue, 27 Feb 2024 17:10:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lhvfJgqYVSF5Btmx1BDwEifoDhVIWGQI9hsiwrNOuEE=;
 b=poig2AiW+JYcLwtsCbDwULeH/juXnFV0Z4qnt/QjAOSUMCy/Ej1Cmv21CXxcnxVv+he6Ge
 Lq9IQRP7lYyFMVRRnQPs25vTrDCFdLD5t+Uaofuks681CfScV80Q98FHg7xUaaQdi4Nbze
 GxLuEve74ufXWnHfIT84FKfxQ+BWhIHU4hBVpiKmmow72Y7PJ/iJ2KHfjkz2Htc6XMU4aH
 3igqOl1PNd8n+QeENwYIrGySuieE/J+KvzA9vP2LISpV3TmTJwGeli9+Y6bMpM9u8dgAn1
 uwcirgdvUO0AEhCBugw0ORxaC5fu6Gp7SVbuwlwZkYOHq+KxdCddhFrgATSmKw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lhvfJgqYVSF5Btmx1BDwEifoDhVIWGQI9hsiwrNOuEE=;
 b=EbUhue/6J7eRuJf/ZIb9m0zkJH9qpf8VSGUyw59ZY+L4J2uqtadUw0aZqhrPbXs3AdE3Mw
 xHEMaTWyb58NwMoiGdmrRQpe56nWq5TN+Cas++Ve23+W79bM0xdZ9l+SWcvW2quR8EXvEt
 Uoid3oQe5rRB3cf4QYQtPHnkTsjKIRoGbO0pTLK/DcJGfUEI1nPE/laOaiShpVlPBoes1W
 vc3nBGolKra/tSfQ7EB5Xh8Hgr6DFA0PRYRRZHVMpbwHR4EOGzZwuZUp3KmhNqayf41mHE
 oH3Dh+tDZjyvkYdAgJkDYn3niLje6L43jkiZJ7mZ0hr+8J+SDpgHlEnysFRcjw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/19] ARM: renesas: Drop unused pfc-r8a7790.h
Date: Tue, 27 Feb 2024 17:05:44 +0100
Message-ID: <20240227160912.412181-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yo6pt4gg9ik74ocbh83wxryi5jrt9r4m
X-MBO-RS-ID: dab1100da3223c40327
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

This file is no longer used, the PFC pin controller driver is
superseded by drivers/pinctrl/renesas/pfc-r8a7790.c which
includes all the details of the hardware. Remove this file.
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rmobile/pfc-r8a7790.h | 139 ----------------------------
 1 file changed, 139 deletions(-)
 delete mode 100644 arch/arm/mach-rmobile/pfc-r8a7790.h

diff --git a/arch/arm/mach-rmobile/pfc-r8a7790.h b/arch/arm/mach-rmobile/pfc-r8a7790.h
deleted file mode 100644
index 3b36548aec9..00000000000
--- a/arch/arm/mach-rmobile/pfc-r8a7790.h
+++ /dev/null
@@ -1,139 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * arch/arm/cpu/armv7/rmobile/pfc-r8a7790.h
- *
- * Copyright (C) 2013 Renesas Electronics Corporation
- */
-
-#ifndef __PFC_R8A7790_H__
-#define __PFC_R8A7790_H__
-
-#include <sh_pfc.h>
-#include <asm/gpio.h>
-
-#define CPU_32_PORT(fn, pfx, sfx)				\
-	PORT_10(fn, pfx, sfx), PORT_10(fn, pfx##1, sfx),	\
-	PORT_10(fn, pfx##2, sfx), PORT_1(fn, pfx##30, sfx),	\
-	PORT_1(fn, pfx##31, sfx)
-
-#define CPU_32_PORT2(fn, pfx, sfx)				\
-	PORT_10(fn, pfx, sfx), PORT_10(fn, pfx##1, sfx),	\
-	PORT_10(fn, pfx##2, sfx)
-
-#if defined(CONFIG_R8A7790)
-#define CPU_32_PORT1(fn, pfx, sfx)				\
-	PORT_10(fn, pfx, sfx), PORT_10(fn, pfx##1, sfx),	\
-	PORT_10(fn, pfx##2, sfx)				\
-/* GP_0_0_DATA -> GP_5_31_DATA (except for GP1[30],GP1[31],GP2[30],GP2[31]) */
-#define CPU_ALL_PORT(fn, pfx, sfx)				\
-	CPU_32_PORT(fn, pfx##_0_, sfx),				\
-	CPU_32_PORT1(fn, pfx##_1_, sfx),			\
-	CPU_32_PORT2(fn, pfx##_2_, sfx),			\
-	CPU_32_PORT(fn, pfx##_3_, sfx),				\
-	CPU_32_PORT(fn, pfx##_4_, sfx),				\
-	CPU_32_PORT(fn, pfx##_5_, sfx)
-
-#elif defined(CONFIG_R8A7791)
-#define CPU_32_PORT1(fn, pfx, sfx)				\
-	PORT_10(fn, pfx, sfx), PORT_10(fn, pfx##1, sfx),	\
-	PORT_1(fn, pfx##20, sfx), PORT_1(fn, pfx##21, sfx),	\
-	PORT_1(fn, pfx##22, sfx), PORT_1(fn, pfx##23, sfx),	\
-	PORT_1(fn, pfx##24, sfx), PORT_1(fn, pfx##25, sfx)
-
-/*
- * GP_0_0_DATA -> GP_7_25_DATA
- * (except for GP1[26],GP1[27],GP1[28],GP1[29]),GP1[30]),GP1[31]
- *  GP7[26],GP7[27],GP7[28],GP7[29]),GP7[30]),GP7[31])
- */
-#define CPU_ALL_PORT(fn, pfx, sfx)				\
-	CPU_32_PORT(fn, pfx##_0_, sfx),				\
-	CPU_32_PORT1(fn, pfx##_1_, sfx),			\
-	CPU_32_PORT(fn, pfx##_2_, sfx),				\
-	CPU_32_PORT(fn, pfx##_3_, sfx),				\
-	CPU_32_PORT(fn, pfx##_4_, sfx),				\
-	CPU_32_PORT(fn, pfx##_5_, sfx),				\
-	CPU_32_PORT(fn, pfx##_6_, sfx),				\
-	CPU_32_PORT1(fn, pfx##_7_, sfx)
-
-#elif defined(CONFIG_R8A7792)
-/*
- * GP_0_0_DATA -> GP_11_29_DATA
- * (except for GP0[29..31],GP1[23..31],GP3[28..31],GP4[17..31],GP5[17..31]
- *  GP6[17..31],GP7[17..31],GP8[17..31],GP9[17..31],GP11[30..31])
- */
-#define CPU_32_PORT0_28(fn, pfx, sfx)				\
-	PORT_10(fn, pfx, sfx), PORT_10(fn, pfx##1, sfx),	\
-	PORT_1(fn, pfx##20, sfx), PORT_1(fn, pfx##21, sfx),	\
-	PORT_1(fn, pfx##22, sfx), PORT_1(fn, pfx##23, sfx),	\
-	PORT_1(fn, pfx##24, sfx), PORT_1(fn, pfx##25, sfx),	\
-	PORT_1(fn, pfx##26, sfx), PORT_1(fn, pfx##27, sfx),	\
-	PORT_1(fn, pfx##28, sfx)
-
-#define CPU_32_PORT0_22(fn, pfx, sfx)				\
-	PORT_10(fn, pfx, sfx), PORT_10(fn, pfx##1, sfx),	\
-	PORT_1(fn, pfx##20, sfx), PORT_1(fn, pfx##21, sfx),	\
-	PORT_1(fn, pfx##22, sfx)
-
-#define CPU_32_PORT0_27(fn, pfx, sfx)				\
-	PORT_10(fn, pfx, sfx), PORT_10(fn, pfx##1, sfx),	\
-	PORT_1(fn, pfx##20, sfx), PORT_1(fn, pfx##21, sfx),	\
-	PORT_1(fn, pfx##22, sfx), PORT_1(fn, pfx##23, sfx),	\
-	PORT_1(fn, pfx##24, sfx), PORT_1(fn, pfx##25, sfx),	\
-	PORT_1(fn, pfx##26, sfx), PORT_1(fn, pfx##27, sfx)
-
-#define CPU_32_PORT0_16(fn, pfx, sfx)				\
-	PORT_10(fn, pfx, sfx),					\
-	PORT_1(fn, pfx##10, sfx),PORT_1(fn, pfx##11, sfx),	\
-	PORT_1(fn, pfx##12, sfx), PORT_1(fn, pfx##13, sfx),	\
-	PORT_1(fn, pfx##14, sfx), PORT_1(fn, pfx##15, sfx),	\
-	PORT_1(fn, pfx##16, sfx)
-
-#define CPU_ALL_PORT(fn, pfx, sfx)				\
-	CPU_32_PORT0_28(fn, pfx##_0_, sfx),			\
-	CPU_32_PORT0_22(fn, pfx##_1_, sfx),			\
-	CPU_32_PORT(fn, pfx##_2_, sfx),				\
-	CPU_32_PORT0_27(fn, pfx##_3_, sfx),			\
-	CPU_32_PORT0_16(fn, pfx##_4_, sfx),			\
-	CPU_32_PORT0_16(fn, pfx##_5_, sfx),			\
-	CPU_32_PORT0_16(fn, pfx##_6_, sfx),			\
-	CPU_32_PORT0_16(fn, pfx##_7_, sfx),			\
-	CPU_32_PORT0_16(fn, pfx##_8_, sfx),			\
-	CPU_32_PORT0_16(fn, pfx##_9_, sfx),			\
-	CPU_32_PORT(fn, pfx##_10_, sfx),			\
-	CPU_32_PORT2(fn, pfx##_11_, sfx)
-
-#else
-#error "NO support"
-#endif
-
-#define _GP_GPIO(pfx, sfx) PINMUX_GPIO(GPIO_GP##pfx, GP##pfx##_DATA)
-#define _GP_DATA(pfx, sfx) PINMUX_DATA(GP##pfx##_DATA, GP##pfx##_FN,	\
-				       GP##pfx##_IN, GP##pfx##_OUT)
-
-#define _GP_INOUTSEL(pfx, sfx) GP##pfx##_IN, GP##pfx##_OUT
-#define _GP_INDT(pfx, sfx) GP##pfx##_DATA
-
-#define GP_ALL(str)	CPU_ALL_PORT(_PORT_ALL, GP, str)
-#define PINMUX_GPIO_GP_ALL()	CPU_ALL_PORT(_GP_GPIO, , unused)
-#define PINMUX_DATA_GP_ALL()	CPU_ALL_PORT(_GP_DATA, , unused)
-
-#define PORT_10_REV(fn, pfx, sfx)				\
-	PORT_1(fn, pfx##9, sfx), PORT_1(fn, pfx##8, sfx),	\
-	PORT_1(fn, pfx##7, sfx), PORT_1(fn, pfx##6, sfx),	\
-	PORT_1(fn, pfx##5, sfx), PORT_1(fn, pfx##4, sfx),	\
-	PORT_1(fn, pfx##3, sfx), PORT_1(fn, pfx##2, sfx),	\
-	PORT_1(fn, pfx##1, sfx), PORT_1(fn, pfx##0, sfx)
-
-#define CPU_32_PORT_REV(fn, pfx, sfx)					\
-	PORT_1(fn, pfx##31, sfx), PORT_1(fn, pfx##30, sfx),		\
-	PORT_10_REV(fn, pfx##2, sfx), PORT_10_REV(fn, pfx##1, sfx),	\
-	PORT_10_REV(fn, pfx, sfx)
-
-#define GP_INOUTSEL(bank) CPU_32_PORT_REV(_GP_INOUTSEL, _##bank##_, unused)
-#define GP_INDT(bank) CPU_32_PORT_REV(_GP_INDT, _##bank##_, unused)
-
-#define PINMUX_IPSR_DATA(ipsr, fn) PINMUX_DATA(fn##_MARK, FN_##ipsr, FN_##fn)
-#define PINMUX_IPSR_MODSEL_DATA(ipsr, fn, ms) PINMUX_DATA(fn##_MARK, FN_##ms, \
-							  FN_##ipsr, FN_##fn)
-
-#endif /* __PFC_R8A7790_H__ */
-- 
2.43.0

