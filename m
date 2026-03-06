Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8975EFCC07D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 22:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 722F883FC6;
	Fri,  6 Mar 2026 23:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A/GR2B/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08A5783F1F; Fri,  6 Mar 2026 23:07:11 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88EF483F2D
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 23:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso6936908a34.0
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 14:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772834827; x=1773439627;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=If4B4LfS5jPAJonbzFJplEWLIjG9GNSSWPcs49IfzNw=;
 b=A/GR2B/Rq77hmvFTmKuGDev72MY6vbJd9+NoTOPd39u2EPdrsJKsE0ZjSyleeOJoKD
 S6bd3Lhxwq1/NQ2BTLLugkImNXC54PWYHEpvntQXDvijIMGh4XQZAIxmWJzBPiZ6AAWZ
 ft7719Sg0l5PD381/fLDckVvlEzWg0edsVNKs1vunTjyxdu9gD7sJ3ERYgw2iU1LSDTb
 bfQmLdjHQNFMxMqyMWbvYBjWpcmMH/PACBOmE3H0T6ucYhK1WYBygIKMrHp56uqSwxhQ
 kelpONqBXNgSStd9a1sftK7C3IE+F3t30MsHBgyWw1n5a1GxpR36fitg/gRifCkPmF2o
 JmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772834827; x=1773439627;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=If4B4LfS5jPAJonbzFJplEWLIjG9GNSSWPcs49IfzNw=;
 b=JtQxIsFcmNzMJ4GUORIGPaD25EiJqtqTpGgTkrPO+IBeImVRTv2AGCeY1NlVQIcbvV
 oGYVTanWT+I3ov7x2uVbH4bPbkG/lY27XMoUh42RLvPCW+D75b6d4b0b8d5jjGdCMPLl
 Ta6pqepv0GlMYYioPKVcWinTS+hJxLixjf0G5t+rlzfzWdlAIsk+gFMd6JRyDBKtyOkQ
 GP8MPhBTWrHjWAB0Binf0khK4BDARPHIvNooJyEc0LuZyFjdKdJNAzMaYW1W6obV9lYe
 P9Pll34lJId38wq6acK4iq2wK/evRnx7+gsUWgbZQd8n9eAgU9EjOrXv6a1SCSP6Sdmt
 jB1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXnf+X5vNzUYF57dLd96bqMk8KfpGN3Rw0HZUPWXq1cVxIPhrxD9VfiXGrsIZJoChZ3iJ0x/4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9/QDHY5iTLNr/ojB6sBqkDzQGi9lkDngta9juILeqs7YgB4Xh
 VwvzsnMOt0iGrqmCfpNyMo8Bc8Gs0rfQQRH89Xzon7SpXetghewMtMhENBTP+sAp2WA=
X-Gm-Gg: ATEYQzya0WFR0WLljT83CAGbR66qnPlqlbQ50iZwSU6lTBrPawjrw/f5pba47ZE6Q7c
 0g6pbpz+4UzuZXuhaFEbtwFVea9sFAMlSHeTWHwiaZ6G+jYZrYtqdctjS7Dvh76Bvo1L6oi/9qe
 euZAbCjgiNH3WICRYT01PkyOIblvsV5Jhk/hMiug53l1+N6SqmZ9jJ7Py2VIYKvKClgMd1v7osJ
 6n+A3b3zYs2K340BJc85SIWii+yJYbQFTKJQi/YKRxJOvP0zD5ruix5JfAAIpajS2qNn7MwDPGi
 DokpoWvqdMPS24YQJfg3ttGWE5jA1gUsUaRrQwPvra4TsHpJ7oKMUQOALO2M3x2oPCDD8eUWQYw
 1fNT6Mc6Y8/awEQE8/fMW63jwIGvXJVjikMc8bzJOvqnCM3j+WIIBVUmV1HhSHIuNRDRss0cFWV
 zP0EUhstaq769CFMqP8f2091DoLo2L
X-Received: by 2002:a05:6830:928:b0:7d1:9c68:8d9d with SMTP id
 46e09a7af769-7d727058a8fmr2767838a34.29.1772834827301; 
 Fri, 06 Mar 2026 14:07:07 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6d78:b98b:fc05:ddbe])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728c5b830sm1707548a34.1.2026.03.06.14.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 14:07:06 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Mar 2026 16:05:51 -0600
Subject: [PATCH v2 4/9] clk: mediatek: move common PARENT macros to header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-4-b253b49f17b2@baylibre.com>
References: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
In-Reply-To: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5261; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=1dsDGg5eGy2s1JzyFo1kwckyPwF/kWmI8VDBtl/zCOU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpq0/eMIbc72VEqFi4QMfCSC5TcJTEWGtv+4QLF
 sqWRjQPQqKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaatP3hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AxIMH/R9J5DeolwEH/2oZieIXTHYcCEdx5TqF8c2idMx
 C27q6nJ/6nncznHcVntiIIqXOYkV0E9R4VqVxOKDyGZqr0T7SflsY4pGhLb2o7PYHARmzythqpr
 wyo6vMRkU8TRJh5uSanq3G8p6ayoFmLY1Pz6X3VSEXdGLMkoouXrVWRxlA/JVYHLHGKab9xYygw
 2YOJPYmJVOoi4DLD7LXm22izjo95QCjiDgQ6NqplKOJz/reVd2/YQ6InCIq1zkCkWwqQrCwjxUq
 hhWeV8BEBw6u92y9jtqdRkQSKKq3Kxg8pThw+nDpZgVLmi8wccqzT3h4KoJ1jjqlyp3pjW1wueg
 kCzo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Move repeated *_PARENT() macros from chip-specific .c files to the
common mtk-clk.h file.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 2 --
 drivers/clk/mediatek/clk-mt7623.c | 3 ---
 drivers/clk/mediatek/clk-mt7981.c | 3 ---
 drivers/clk/mediatek/clk-mt7986.c | 5 -----
 drivers/clk/mediatek/clk-mt7987.c | 2 --
 drivers/clk/mediatek/clk-mt7988.c | 2 --
 drivers/clk/mediatek/clk-mt8189.c | 4 ----
 drivers/clk/mediatek/clk-mtk.h    | 7 +++++++
 8 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index a69136dbc94..9b62d964318 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -387,8 +387,6 @@ static const struct mtk_composite top_muxes[] = {
 };
 
 /* infracfg */
-#define APMIXED_PARENT(_id) PARENT(_id, CLK_PARENT_APMIXED)
-#define XTAL_PARENT(_id) PARENT(_id, CLK_PARENT_XTAL)
 
 static const struct mtk_parent infra_mux1_parents[] = {
 	XTAL_PARENT(CLK_XTAL),
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index d62b9651fa6..4d16610f4d0 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -866,9 +866,6 @@ static const int peri_id_offs_map[] = {
 	[CLK_PERI_FCI]				= 48,
 };
 
-#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
-#define XTAL_PARENT(_id) PARENT(_id, CLK_PARENT_XTAL)
-
 static const struct mtk_parent uart_ck_sel_parents[] = {
 	XTAL_PARENT(CLK_XTAL),
 	TOP_PARENT(CLK_TOP_UART_SEL),
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 09ed4d8a97f..40e8429521a 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -319,9 +319,6 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
 };
 
 /* INFRASYS MUX PARENTS */
-#define INFRA_PARENT(_id) PARENT(_id, CLK_PARENT_INFRASYS)
-#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
-#define VOID_PARENT PARENT(-1, 0)
 
 static const struct mtk_parent infra_uart0_parents[] = {
 	TOP_PARENT(CLK_TOP_F26M_SEL),
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 79efbf43bc4..c2c216fcdf4 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -18,11 +18,6 @@
 #define MT7986_CLK_PDN 0x250
 #define MT7986_CLK_PDN_EN_WRITE BIT(31)
 
-#define APMIXED_PARENT(_id) PARENT(_id, CLK_PARENT_APMIXED)
-#define INFRA_PARENT(_id) PARENT(_id, CLK_PARENT_INFRASYS)
-#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
-#define VOID_PARENT PARENT(-1, 0)
-
 #define FIXED_CLK0(_id, _rate)					\
 	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
 
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 959b1c9cff6..641881fcb28 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -111,8 +111,6 @@ static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
 };
 
 /* TOPCKGEN MUX PARENTS */
-#define APMIXED_PARENT(_id) PARENT(_id, CLK_PARENT_APMIXED)
-#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
 
 /* CLK_TOP_NETSYS_SEL (netsys_sel) in topckgen */
 static const struct mtk_parent netsys_parents[] = {
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index cd8726852d7..83f7c559e31 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -94,8 +94,6 @@ static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
 };
 
 /* TOPCKGEN MUX PARENTS */
-#define APMIXED_PARENT(_id) PARENT(_id, CLK_PARENT_APMIXED)
-#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
 
 static const struct mtk_parent netsys_parents[] = {
 	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET2PLL_D2),
diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 9e48d668db6..89453ff872d 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -425,10 +425,6 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_OSC_D20, CLK_PAD_ULPOSC, 1, 20),
 };
 
-#define EXT_PARENT(id) PARENT(id, CLK_PARENT_EXT)
-#define APMIXED_PARENT(id) PARENT(id, CLK_PARENT_APMIXED)
-#define TOP_PARENT(id) PARENT(id, CLK_PARENT_TOPCKGEN)
-
 static const struct mtk_parent axi_parents[] = {
 	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 5a48f2e002d..f81e214bf00 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -129,6 +129,13 @@ struct mtk_parent {
 		.flags = _flags,			\
 	}
 
+#define APMIXED_PARENT(id)	PARENT(id, CLK_PARENT_APMIXED)
+#define TOP_PARENT(id)		PARENT(id, CLK_PARENT_TOPCKGEN)
+#define INFRA_PARENT(id)	PARENT(id, CLK_PARENT_INFRASYS)
+#define XTAL_PARENT(id)		PARENT(id, CLK_PARENT_XTAL)
+#define EXT_PARENT(id)		PARENT(id, CLK_PARENT_EXT)
+#define VOID_PARENT		PARENT(-1, 0)
+
 /**
  * struct mtk_composite - aggregate clock of mux, divider and gate clocks
  *

-- 
2.43.0

