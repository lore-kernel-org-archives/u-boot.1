Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C158D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A325A83C19;
	Fri, 28 Nov 2025 23:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="26IEasTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D55D83B63; Fri, 28 Nov 2025 21:22:50 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA5F683B8B
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 21:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47790b080e4so10326055e9.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764361367; x=1764966167;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0GLthAwtFIQORRqx9EDwptQkIZf1iTm4IHJL5aHlKLw=;
 b=26IEasTiJSUriIt9liV87X4GLADF3IYmun7L+VCNXlNhzPcIN7L037gabjwE7SG9vu
 P4hbPQBPeU3luro0gvFfw58jZThsSwBTqNL9fMWOw5puuI7y6OtY9XUqC5ylqqy3DWqI
 Trxwb224QWLImDC6tDPaWU3mc5ODSKwPS/N1pXAVJf8MDJIQ3CSEvdbtp4ofVbrVg2wh
 cNF6AfFNHd25x1Tn/e64HG4yJWATz2xo2TDpiGeHz+LZXFsInMd9qNtDy8/PG7iZvI47
 uWY8D62CATHza4aDVoDFXY66X/4jRjACwQnIBX0vRrdIGnTVdhq9hgn0JZ+xA/Lf+S95
 1UzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764361367; x=1764966167;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0GLthAwtFIQORRqx9EDwptQkIZf1iTm4IHJL5aHlKLw=;
 b=wR0MVsnUmTVXyI7mhJk1IitV4JW+CAjPBMtoPSr53ig7afj/B+4PIePmpiSpMczhrP
 guWrkZ8eBMSXFS74prCC4A7ZR71oHq947HW4Ck7B0UnAxs/kzFx8X95YI5tmYEIQ0S/5
 Gm+z0iA55HsoE9629qHvwQz2WEZq/ve345uWGvrl7QsTPtbeKHLSoiErxInX4+cnbtq+
 ykH+fdjrxp9ZUHag6w/yyY0idCQPEzTuhQ5eDC7zaapz1W+VbBxdO7Zqy8io2jkXVzpt
 oD/SuTReb+KAH8kYpxQrK3QMfMKCV2gbFv9hpngsJevSS5SeISAAtnIpLYM2aoQySRAX
 fNyw==
X-Gm-Message-State: AOJu0YyMOvR/J1gLRonsMIqENeflIyJSjCzPzRix6Y3txtmYH+tQlM7p
 OEFT1LucYX7P6RjrOZhWy9b/5DpaZiQwwB5hPLXYfhiKKve6tKEnwyjEdyBYpOdhBEM=
X-Gm-Gg: ASbGncu9Jh2QkKzYN/iIPEmXH/YmcQJHb1o+lIP4CJXfjqrN1WVuuP6ZLUut2hBcKUe
 janAF+MV/iy9lK3XezffYtdtqE+9mSi3MXZoj+UTxWUqKHi1WECs0pNC6ACLf3n2FnIGve9DYvE
 rA150DbFdVDCkhH+0+mnoCz+LlR8U5Jy3Dd2RGanSqXK/Ui9AxioU/87vrol/bxaVY5eZNnJ7Zu
 vlhhohFGn2z5mIZDb5AkYiZX2VZysd9RhUyue2dSClc3BCBLdu+rzH4uEaIV+Ylb51aDX/UzXcl
 L/+pftOsa76ufrnNUWO63RziKg2M56nbEQnypV94YcbPr1xpvQA1L/9O2Wr0VGKoP9avwQXPpOS
 yShaEfjfaVOVh9pA6awWaygNJWOHxZUCN51JL9Yo/Z3n3ynEpjsqRuKJsxobw0HxfwNGk3n2D3o
 gpwhxuk0CeOZmSTXc/Yw==
X-Google-Smtp-Source: AGHT+IF0ldU7vokEaSzwCmE7XjAl0PGnZzsADLOaOllsEr2SVrmgGwXdPfuL7YG4+NT60gYA4Sv0Mw==
X-Received: by 2002:a05:600c:4685:b0:477:7768:8da4 with SMTP id
 5b1f17b1804b1-477c10c84eamr284933415e9.7.1764361367114; 
 Fri, 28 Nov 2025 12:22:47 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42e1caae37esm11492112f8f.40.2025.11.28.12.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 12:22:46 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 21:22:19 +0100
Subject: [PATCH v2 2/2] clk: ti: omap4-cm: Add Kconfig symbol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-am33-clk-regmap-dep-v2026-01-v2-2-451b4f4e7e85@baylibre.com>
References: <20251128-topic-am33-clk-regmap-dep-v2026-01-v2-0-451b4f4e7e85@baylibre.com>
In-Reply-To: <20251128-topic-am33-clk-regmap-dep-v2026-01-v2-0-451b4f4e7e85@baylibre.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yegor Yefremov <yegorslists@googlemail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1818; i=msp@baylibre.com;
 h=from:subject:message-id; bh=BtHwVkyPmUxyqNMoZc8rl2GSyusaRG9XLDo27voVBI0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwtlh4fti+2/fHhSy/NK/709696lvxfeZGYi5qfk+TDd
 neskxPuKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIm0OjD895tsy1aRGfzQp8jp
 +dbXJo9uabcpzddJs5CWW2qj5fVCkZHhimPWl9kXbztzivKuqjV8Ln1vSZyR3LWd0Uv3/e95t4G
 BEwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 23:32:55 +0100
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

Add a Kconfig symbol for this stub driver to avoid clock dependencies on
an architecture symbol. Enable it by default.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/clk/ti/Kconfig  | 7 +++++++
 drivers/clk/ti/Makefile | 3 +--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
index 7b8da69712e4fa61c15f3fb0cbdc9f3fd8de31bb..9517363ebb38f5b2c207f25879858c77f4c7f3d5 100644
--- a/drivers/clk/ti/Kconfig
+++ b/drivers/clk/ti/Kconfig
@@ -10,6 +10,13 @@ config CLK_TI_OMAP2PLUS
 	help
 	  Common clock functions used in some TI clock drivers.
 
+config CLK_TI_OMAP4_CM
+	bool "TI OMAP4 clock manager driver"
+	depends on CLK && ARCH_OMAP2PLUS
+	default y
+	help
+	  This enables the OMAP4 clock manager (CM) stub driver.
+
 config CLK_TI_AM3_DPLL
 	bool "TI AM33XX Digital Phase-Locked Loop (DPLL) clock drivers"
 	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 329fae67889b11a9ef3c646b166243abcb956144..74e4329a3430d66c11a3c034f1938c0804f4c918 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -3,14 +3,13 @@
 # Copyright (C) 2020 Dario Binacchi <dariobin@libero.it>
 #
 
-obj-$(CONFIG_ARCH_OMAP2PLUS) += omap4-cm.o
-
 obj-$(CONFIG_CLK_TI_AM3_DPLL) += clk-am3-dpll.o clk-am3-dpll-x2.o
 obj-$(CONFIG_CLK_TI_CTRL) += clk-ctrl.o
 obj-$(CONFIG_CLK_TI_DIVIDER) += clk-divider.o
 obj-$(CONFIG_CLK_TI_GATE) += clk-gate.o
 obj-$(CONFIG_CLK_TI_MUX) += clk-mux.o
 obj-$(CONFIG_CLK_TI_OMAP2PLUS) += clk.o
+obj-$(CONFIG_CLK_TI_OMAP4_CM) += omap4-cm.o
 obj-$(CONFIG_CLK_TI_SCI) += clk-sci.o
 obj-$(CONFIG_$(PHASE_)CLK_K3_PLL) += clk-k3-pll.o
 obj-$(CONFIG_$(PHASE_)CLK_K3) += clk-k3.o

-- 
2.51.0

