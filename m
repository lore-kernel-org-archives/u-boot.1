Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D13C282E3
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 11:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B92280FDD;
	Wed,  5 Mar 2025 12:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UB9HL8mB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024518003E; Wed,  5 Mar 2025 12:12:32 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E929D80F56
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 12:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30bd473770bso12615941fa.3
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 03:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741173149; x=1741777949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o10jHHZYN7q5KkY3DOQGNZt0AFV7965z5i08QWnoSHI=;
 b=UB9HL8mBIoNVeEzyFGXiaPmym4t4mrEBAAIK24dIrhdrolQGbC28/sWPKtr76fAjNt
 h/YFTJ0wxx+ulvAEXLpr1bEhh+AANrC9Egm5+Who11kZC/9hJDezPUvSndEG61kOG8aJ
 GY0pr2jy6bNcDu6FTy6ajV69ouA1hiRnGdoVMWosfABP6bA2JakbI5ZT8AjqwWX1yi88
 /rvseomEjVrDCOuad1KOJWQSWifbWZmD8M+zLox9pYh8rdKrMI3WHC8EmxWLxISLXsei
 XIVRC2dED5X+W/wH9k5rYGbhi0z7YCECZOXAbCvvUnFpmaGAv/gN3tTkQWok16zHDpiU
 BXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741173149; x=1741777949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o10jHHZYN7q5KkY3DOQGNZt0AFV7965z5i08QWnoSHI=;
 b=ZE8fEPDtrzb8FxfAI+FHLZWMzF4/EiEMAvHI4UeX8I3aAECyhopW/X3D7geQiZgg6i
 zI0gRkAPCSPVmbQ6g/voZ1pzQIS6cpBvfWSs7feOa7hOF9sBKmqOuB742lbjXwSMCalB
 p4/nfI6B8kupt2x5FbnLbomLZsBfaNcj74M9oArxnq72V2TTGsc+RP9MH218BEmfFSks
 OJPYuiMLuCgp3wAKNuqBujxeot4hSfXBZKR0ml7Dw8zNpYvs4OLcY+ju/Vv51opuhnXA
 jB/aAjaIhp9HyfzSuYTgv/UIU37ZIYM5ycUXZOqSiX8dagtTMBtgw8YLs5/YM6ubfTR8
 aKcQ==
X-Gm-Message-State: AOJu0YzTV/gOulOo/yJqnOHKFykK0hrWYzmouYj6jZ6ZLF6vab0nXN+/
 2C1qq6tO856gWefUkHUF5GQm1+spSqpJ0yjMGU3e8nt2SRzzUzud
X-Gm-Gg: ASbGncst99nZMAZl/ai7xRjEVgIDWc0kaudAvbR2P1UWdSrYF03bB4d6Uu5hb2dVTMA
 L3Zzgv4anGC2Dyry1dg2eNvebgzI+voc2taxY9TjMSmCEF5J4Z7Ro5mpKRCs7C7pPSzY3j836BI
 /Xfy+ffILfBZ8a2VqWWN5D/goJDaGsz1OXW/vGhXIwC+Co5qYM5QihZuXh7lkpqIA7LYHWMr1rs
 H01DGVYYaFBoT9SrBYkZgUxOKyscpABRdscKRny9zthiHGJZQqm40agcUpFcSxT5+Rx1dd7iEWh
 9zjsdSynx1zLmEvNuGGx4aSV6NBOAbyDeiZk
X-Google-Smtp-Source: AGHT+IEzvE6OA0d2NLR+zIiWa/L5rG+AR69Evlhu/ylLkmpqI4Ngkh3OXkXzTLkHsjlHSp4GwkJ0tw==
X-Received: by 2002:a05:651c:508:b0:309:20b4:b6d5 with SMTP id
 38308e7fff4ca-30bd7ae59d5mr11003611fa.28.1741173148893; 
 Wed, 05 Mar 2025 03:12:28 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30babec1731sm12490791fa.62.2025.03.05.03.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 03:12:28 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/2] ARM: tegra: clock: fix PLLD/PLLD2 related clock
 calculations
Date: Wed,  5 Mar 2025 13:12:12 +0200
Message-ID: <20250305111213.163428-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305111213.163428-1-clamor95@gmail.com>
References: <20250305111213.163428-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

While PLLD/D2 is the nominal parent clock, all derived clocks are generated
from its single output, plld_out0, which is PLLD/D2 divided by two. Direct
use of PLLD/D2 is absent in peripheral clock configurations. Therefore,
clock derivation formulas must take in account this division.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/clock.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
index 157e6c4911a..a375693481e 100644
--- a/arch/arm/mach-tegra/clock.c
+++ b/arch/arm/mach-tegra/clock.c
@@ -358,6 +358,13 @@ unsigned long clock_get_periph_rate(enum periph_id periph_id,
 		break;
 	}
 
+	/*
+	 * PLLD/PLLD2 raw clock rate is never used, instead plld_out0 is used
+	 * that is PLLD/PLLD2 halved.
+	 */
+	if (parent == CLOCK_ID_DISPLAY || parent == CLOCK_ID_DISPLAY2)
+		parent_rate /= 2;
+
 	return get_rate_from_divider(parent_rate, div);
 }
 
@@ -449,6 +456,7 @@ unsigned clock_adjust_periph_pll_div(enum periph_id periph_id,
 		enum clock_id parent, unsigned rate, int *extra_div)
 {
 	unsigned effective_rate;
+	unsigned int parent_rate;
 	int mux_bits, divider_bits, source;
 	int divider;
 	int xdiv = 0;
@@ -457,7 +465,17 @@ unsigned clock_adjust_periph_pll_div(enum periph_id periph_id,
 	source = get_periph_clock_source(periph_id, parent, &mux_bits,
 					 &divider_bits);
 
-	divider = find_best_divider(divider_bits, pll_rate[parent],
+	/*
+	 * Clocks derived from PLLD/D2 are actually sourced from its halved
+	 * output, plld_out0/plld2_out0. No peripheral clocks use the raw
+	 * PLLD/D2 frequency. This halving must be accounted for in derived
+	 * clock calculations.
+	 */
+	parent_rate = pll_rate[parent];
+	if (parent == CLOCK_ID_DISPLAY || parent == CLOCK_ID_DISPLAY2)
+		parent_rate /= 2;
+
+	divider = find_best_divider(divider_bits, parent_rate,
 				    rate, &xdiv);
 	if (extra_div)
 		*extra_div = xdiv;
@@ -685,6 +703,16 @@ int clock_set_rate(enum clock_id clkid, u32 n, u32 m, u32 p, u32 cpcon)
 	else
 		writel(base_reg, &simple_pll->pll_base);
 
+	/*
+	 * Changing clocks was never intended in the U-Boot for Tegra.
+	 * If a clock is changed after clock_init() the parent rate is wrong.
+	 * Usually there is no reason to change peripheral clocks, but Display
+	 * PLLs which needs to generate a precise pixelclock might be adjusted.
+	 * Especially in the case of HDMI display with changing and prior
+	 * unknown resolution.
+	 */
+	pll_rate[clkid] = clock_get_rate(clkid);
+
 	return 0;
 }
 
-- 
2.43.0

