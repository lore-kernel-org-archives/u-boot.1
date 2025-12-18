Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D380AD711D4
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10D8E83984;
	Fri, 19 Dec 2025 00:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HeF0zVXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D017283869; Fri, 19 Dec 2025 00:24:43 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE34835FD
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-44fe903c1d6so334014b6e.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766100280; x=1766705080;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D4dj3n2uHPvRCA7mcqwZIA5AY41GqzjUxr9NaCwPia4=;
 b=HeF0zVXCFth4PUOt01MU/78F89zKqbT5gZ5ocLeOxoTFaCiawBQrng4+tuMIDBN9xr
 iKOBIEKNGqgvfHIYtCdAWf5hJAhANGIvlxqaRIqGwv+A7UkZoxEm+/Tb47+d4VcAiirR
 KkdxoEoGdl5HnjSpZzvQvkiIH7mPumLmW88Awq1Cdsyi97Mvnr/98elGTqiDj7HzZNjp
 essh6r/he4d+S17F9y1qhact1D8Ddx4KTw7BMPLM+n2SaIGNTx6NtyErWsl/nRUiDZh7
 I9vhMVqBdrvbmbBpuT3ngUZjXj9a4Y+RBuEAbzUHfazU6U1++tuEXGM2a+g0/S9WHyh4
 QK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100280; x=1766705080;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D4dj3n2uHPvRCA7mcqwZIA5AY41GqzjUxr9NaCwPia4=;
 b=K5O+PlC6VcnGCNIbodTzXh01Io8huLQplJQZ8R1zBEG9yJeFGF4QHzEot2O2QQlIxp
 3ph6u+lnVULk+G5/sLRHKCzk1IOc7VVUAYyMO8jWD5+iU/eZxWMq49V6bBsFd4UIohnZ
 kZ8g8/eBU/vssfOdZmMokQ4iof5HNIbMl540u3aoCqf5OZqMUgNXPtcqqS2eNIHhYnPo
 Onh/8JbetMh3MeNnI6TzVdrpFlgmshLk/OUwTZli3sNQDHk7+1kcBjJdCv/Ll3U4MVFR
 cAiNQWt1D1FD7F68h/f5PNbgVy40/rNA+aw+uKyA4Sxpnquay8G70VKbjEIRQDWPabGw
 vlNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcrA/DEKkhyHAcH3ThudRmQEUsmki00j7Ovt7dUpOyqgaKXAQk00D3qudVei1NM65wK4kSYLg=@lists.denx.de
X-Gm-Message-State: AOJu0YywCFPiRiNv56CwJdhPlE2G3q6XeXgy0Jsr1r8/GKXtzZwfOeW4
 O4bV8kklbF0zIaRAxn2JGB/VeesiTe56cOi7lpHf9bHV7BEcZZcnBcD1v/fveAMuUh8=
X-Gm-Gg: AY/fxX5oHGrvNu9RQV/aD9nWT9w/w6G9IXL97faVG4mmNO5NeNY+MS4m8uD1ssl9Wj2
 I5oybwvPNdwdvt/TWj+hIufloO7lQcD/Vhe7MhKA18NcclIXEuD8795U1UA6FUlDFsUAKrjl8kN
 mVOG/DogqyCaB0t7WZLdyYj82fmWtxP11jPKl/Zry7fCWvLfvNX3vvDT8guNug2WdG68D9lCuYC
 35HD39YUEInuUgrNBZTUjnXxJm3XipRNmAcUWtOBpNIvaNl+IAOj9ouCgkMNNJucom3wZewRKPa
 PXdA11DP2Sl9LPYAxf+WFCSWYNSP9tmiY0e63zEZlStny+EbGV4npdkEXKGg++Nanu42YksSC8y
 rn0NcCLrmx6qhsLXW1/WUqZGt0vMIDoAK+A0AU9msOCSQrgluXViRChSaop10A5DI2WhS6S3Rm3
 u3ugjQ+YS+agEr8nGggxoaLhgRbA==
X-Google-Smtp-Source: AGHT+IHoLJF/EQD4/UBdJk+Np03BF9ybfxpQiA5XUN509RzQoZwAIxzRR7veOM4GrWMkFvzSRMepNA==
X-Received: by 2002:a05:6808:1a01:b0:453:ee6:12b3 with SMTP id
 5614622812f47-457b21e1efemr758966b6e.58.1766100279674; 
 Thu, 18 Dec 2025 15:24:39 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:67e5:27b0:56a0:f05d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3be228asm300334b6e.9.2025.12.18.15.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:24:39 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 17:23:24 -0600
Subject: [PATCH 4/9] clk: mediatek: fix fixed clock parents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-mt8365-fixes-v1-4-4f8ff0de3268@baylibre.com>
References: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
In-Reply-To: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=20704;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=/bcUzz/7NAu7Yk73oo4msd8wobevFF9LY9P9X5SGS1M=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRI0IIBrdubX3B516gc6WyOXS0RMWVJR0sxK2c
 +KLFZQSTJyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUSNCBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AhJ8H/RUyTDn/++gJ9gZD6OvbtAJqx2lVzEfGbO0YbSe
 FXW5J2neW1DDmQ6d2LY9BslmBJjm+DaN3pJZNEvubYSrwhP+ozwcGaR3fqdm2kqVu7eVv2G6Mkb
 xOyo3M8E6lX2y1LJ/Y5b0vuwNfwdirTvOYTd5voiaLMeECGtd9TbYghMPxYgMMbXNfyOyAlJz85
 64/rqNRnluNnbE1fC5My2zNC/kD0IN5jcTHuCr/rEVfiJZiGNnNNyiDzyiYpbnSKK4JVEYfLlgK
 yFEe9FVAofvmA7epdDAZCUSV716nO+EBn/MhI6kCw1uH/mNC0/lv3UgQRkbzK8TeDQ4QF69HYmx
 PHaQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 19 Dec 2025 00:28:35 +0100
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

Add a flags field to struct mtk_fixed_clk to allow properly resolving
the parent clock. All chip-specific clocks are updated to populate this
field correctly.

The parent is currently only used for printing debug information, so
there are no functional bugs being fixed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 23 +++++++++++++----------
 drivers/clk/mediatek/clk-mt7623.c | 33 ++++++++++++++++++---------------
 drivers/clk/mediatek/clk-mt7629.c | 23 +++++++++++++----------
 drivers/clk/mediatek/clk-mt7981.c | 21 ++++++++++++---------
 drivers/clk/mediatek/clk-mt7986.c | 21 ++++++++++++---------
 drivers/clk/mediatek/clk-mt7987.c | 19 +++++++++++--------
 drivers/clk/mediatek/clk-mt7988.c | 29 ++++++++++++++++-------------
 drivers/clk/mediatek/clk-mt8183.c | 12 +++++++++---
 drivers/clk/mediatek/clk-mt8365.c | 16 +++++++++++-----
 drivers/clk/mediatek/clk-mt8512.c |  7 +++++--
 drivers/clk/mediatek/clk-mt8516.c | 12 +++++++++---
 drivers/clk/mediatek/clk-mt8518.c | 14 ++++++++++----
 drivers/clk/mediatek/clk-mtk.c    |  3 +--
 drivers/clk/mediatek/clk-mtk.h    |  4 +++-
 14 files changed, 143 insertions(+), 94 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 9621d5efe11..93e87ee399d 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -85,6 +85,9 @@ static const struct mtk_gate apmixed_cgs[] = {
 };
 
 /* topckgen */
+#define FIXED_CLK0(_id, _rate)					\
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL _rate)
+
 #define FACTOR0(_id, _parent, _mult, _div)			\
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
 
@@ -95,16 +98,16 @@ static const struct mtk_gate apmixed_cgs[] = {
 	FACTOR(_id, _parent, _mult, _div, 0)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK(CLK_TOP_TO_U2_PHY, CLK_XTAL, 31250000),
-	FIXED_CLK(CLK_TOP_TO_U2_PHY_1P, CLK_XTAL, 31250000),
-	FIXED_CLK(CLK_TOP_PCIE0_PIPE_EN, CLK_XTAL, 125000000),
-	FIXED_CLK(CLK_TOP_PCIE1_PIPE_EN, CLK_XTAL, 125000000),
-	FIXED_CLK(CLK_TOP_SSUSB_TX250M, CLK_XTAL, 250000000),
-	FIXED_CLK(CLK_TOP_SSUSB_EQ_RX250M, CLK_XTAL, 250000000),
-	FIXED_CLK(CLK_TOP_SSUSB_CDR_REF, CLK_XTAL, 33333333),
-	FIXED_CLK(CLK_TOP_SSUSB_CDR_FB, CLK_XTAL, 50000000),
-	FIXED_CLK(CLK_TOP_SATA_ASIC, CLK_XTAL, 50000000),
-	FIXED_CLK(CLK_TOP_SATA_RBC, CLK_XTAL, 50000000),
+	FIXED_CLK0(CLK_TOP_TO_U2_PHY, 31250000),
+	FIXED_CLK0(CLK_TOP_TO_U2_PHY_1P, 31250000),
+	FIXED_CLK0(CLK_TOP_PCIE0_PIPE_EN, 125000000),
+	FIXED_CLK0(CLK_TOP_PCIE1_PIPE_EN, 125000000),
+	FIXED_CLK0(CLK_TOP_SSUSB_TX250M, 250000000),
+	FIXED_CLK0(CLK_TOP_SSUSB_EQ_RX250M, 250000000),
+	FIXED_CLK0(CLK_TOP_SSUSB_CDR_REF, 33333333),
+	FIXED_CLK0(CLK_TOP_SSUSB_CDR_FB, 50000000),
+	FIXED_CLK0(CLK_TOP_SATA_ASIC, 50000000),
+	FIXED_CLK0(CLK_TOP_SATA_RBC, 50000000),
 };
 
 static const struct mtk_fixed_factor top_fixed_divs[] = {
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 3509ea67e7d..093577c4ee4 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -259,6 +259,9 @@ static const int top_id_offs_map[CLK_TOP_NR + 1] = {
 	[CLK_TOP_AUD_I2S6_MCLK]			= 158,
 };
 
+#define FIXED_CLK0(_id, _rate)					\
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL _rate)
+
 #define FACTOR0(_id, _parent, _mult, _div)			\
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
 
@@ -269,21 +272,21 @@ static const int top_id_offs_map[CLK_TOP_NR + 1] = {
 	FACTOR(_id, _parent, _mult, _div, 0)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK(CLK_TOP_DPI, CLK_XTAL, 108 * MHZ),
-	FIXED_CLK(CLK_TOP_DMPLL, CLK_XTAL, 400 * MHZ),
-	FIXED_CLK(CLK_TOP_VENCPLL, CLK_XTAL, 295.75 * MHZ),
-	FIXED_CLK(CLK_TOP_HDMI_0_PIX340M, CLK_XTAL, 340 * MHZ),
-	FIXED_CLK(CLK_TOP_HDMI_0_DEEP340M, CLK_XTAL, 340 * MHZ),
-	FIXED_CLK(CLK_TOP_HDMI_0_PLL340M, CLK_XTAL, 340 * MHZ),
-	FIXED_CLK(CLK_TOP_HADDS2_FB, CLK_XTAL, 27 * MHZ),
-	FIXED_CLK(CLK_TOP_WBG_DIG_416M, CLK_XTAL, 416 * MHZ),
-	FIXED_CLK(CLK_TOP_DSI0_LNTC_DSI, CLK_XTAL, 143 * MHZ),
-	FIXED_CLK(CLK_TOP_HDMI_SCL_RX, CLK_XTAL, 27 * MHZ),
-	FIXED_CLK(CLK_TOP_32K_EXTERNAL, CLK_XTAL, 32000),
-	FIXED_CLK(CLK_TOP_HDMITX_CLKDIG_CTS, CLK_XTAL, 300 * MHZ),
-	FIXED_CLK(CLK_TOP_AUD_EXT1, CLK_XTAL, 0),
-	FIXED_CLK(CLK_TOP_AUD_EXT2, CLK_XTAL, 0),
-	FIXED_CLK(CLK_TOP_NFI1X_PAD, CLK_XTAL, 0),
+	FIXED_CLK0(CLK_TOP_DPI, 108 * MHZ),
+	FIXED_CLK0(CLK_TOP_DMPLL, 400 * MHZ),
+	FIXED_CLK0(CLK_TOP_VENCPLL, 295.75 * MHZ),
+	FIXED_CLK0(CLK_TOP_HDMI_0_PIX340M, 340 * MHZ),
+	FIXED_CLK0(CLK_TOP_HDMI_0_DEEP340M, 340 * MHZ),
+	FIXED_CLK0(CLK_TOP_HDMI_0_PLL340M, 340 * MHZ),
+	FIXED_CLK0(CLK_TOP_HADDS2_FB, 27 * MHZ),
+	FIXED_CLK0(CLK_TOP_WBG_DIG_416M, 416 * MHZ),
+	FIXED_CLK0(CLK_TOP_DSI0_LNTC_DSI, 143 * MHZ),
+	FIXED_CLK0(CLK_TOP_HDMI_SCL_RX, 27 * MHZ),
+	FIXED_CLK0(CLK_TOP_32K_EXTERNAL, 32000),
+	FIXED_CLK0(CLK_TOP_HDMITX_CLKDIG_CTS, 300 * MHZ),
+	FIXED_CLK0(CLK_TOP_AUD_EXT1, 0),
+	FIXED_CLK0(CLK_TOP_AUD_EXT2, 0),
+	FIXED_CLK0(CLK_TOP_NFI1X_PAD, 0),
 };
 
 static const struct mtk_fixed_factor top_fixed_divs[] = {
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 5bbac309e9d..582394f594b 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -61,6 +61,9 @@ static const struct mtk_pll_data apmixed_plls[] = {
 };
 
 /* topckgen */
+#define FIXED_CLK0(_id, _rate)					\
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+
 #define FACTOR0(_id, _parent, _mult, _div)			\
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
 
@@ -71,16 +74,16 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	FACTOR(_id, _parent, _mult, _div, 0)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK(CLK_TOP_TO_U2_PHY, CLK_XTAL, 31250000),
-	FIXED_CLK(CLK_TOP_TO_U2_PHY_1P, CLK_XTAL, 31250000),
-	FIXED_CLK(CLK_TOP_PCIE0_PIPE_EN, CLK_XTAL, 125000000),
-	FIXED_CLK(CLK_TOP_PCIE1_PIPE_EN, CLK_XTAL, 125000000),
-	FIXED_CLK(CLK_TOP_SSUSB_TX250M, CLK_XTAL, 250000000),
-	FIXED_CLK(CLK_TOP_SSUSB_EQ_RX250M, CLK_XTAL, 250000000),
-	FIXED_CLK(CLK_TOP_SSUSB_CDR_REF, CLK_XTAL, 33333333),
-	FIXED_CLK(CLK_TOP_SSUSB_CDR_FB, CLK_XTAL, 50000000),
-	FIXED_CLK(CLK_TOP_SATA_ASIC, CLK_XTAL, 50000000),
-	FIXED_CLK(CLK_TOP_SATA_RBC, CLK_XTAL, 50000000),
+	FIXED_CLK0(CLK_TOP_TO_U2_PHY, 31250000),
+	FIXED_CLK0(CLK_TOP_TO_U2_PHY_1P, 31250000),
+	FIXED_CLK0(CLK_TOP_PCIE0_PIPE_EN, 125000000),
+	FIXED_CLK0(CLK_TOP_PCIE1_PIPE_EN, 125000000),
+	FIXED_CLK0(CLK_TOP_SSUSB_TX250M, 250000000),
+	FIXED_CLK0(CLK_TOP_SSUSB_EQ_RX250M, 250000000),
+	FIXED_CLK0(CLK_TOP_SSUSB_CDR_REF, 33333333),
+	FIXED_CLK0(CLK_TOP_SSUSB_CDR_FB, 50000000),
+	FIXED_CLK0(CLK_TOP_SATA_ASIC, 50000000),
+	FIXED_CLK0(CLK_TOP_SATA_RBC, 50000000),
 };
 
 static const struct mtk_fixed_factor top_fixed_divs[] = {
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 73dc5cfe19d..c90fb2ce787 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -18,6 +18,9 @@
 #define MT7981_CLK_PDN 0x250
 #define MT7981_CLK_PDN_EN_WRITE BIT(31)
 
+#define FIXED_CLK0(_id, _rate)					\
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+
 #define PLL_FACTOR(_id, _name, _parent, _mult, _div)                           \
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
 
@@ -29,19 +32,19 @@
 
 /* FIXED PLLS */
 static const struct mtk_fixed_clk fixed_pll_clks[] = {
-	FIXED_CLK(CLK_APMIXED_ARMPLL, CLK_XTAL, 1300000000),
-	FIXED_CLK(CLK_APMIXED_NET2PLL, CLK_XTAL, 800000000),
-	FIXED_CLK(CLK_APMIXED_MMPLL, CLK_XTAL, 720000000),
-	FIXED_CLK(CLK_APMIXED_SGMPLL, CLK_XTAL, 325000000),
-	FIXED_CLK(CLK_APMIXED_WEDMCUPLL, CLK_XTAL, 208000000),
-	FIXED_CLK(CLK_APMIXED_NET1PLL, CLK_XTAL, 2500000000),
-	FIXED_CLK(CLK_APMIXED_MPLL, CLK_XTAL, 416000000),
-	FIXED_CLK(CLK_APMIXED_APLL2, CLK_XTAL, 196608000),
+	FIXED_CLK0(CLK_APMIXED_ARMPLL, 1300000000),
+	FIXED_CLK0(CLK_APMIXED_NET2PLL, 800000000),
+	FIXED_CLK0(CLK_APMIXED_MMPLL, 720000000),
+	FIXED_CLK0(CLK_APMIXED_SGMPLL, 325000000),
+	FIXED_CLK0(CLK_APMIXED_WEDMCUPLL, 208000000),
+	FIXED_CLK0(CLK_APMIXED_NET1PLL, 2500000000),
+	FIXED_CLK0(CLK_APMIXED_MPLL, 416000000),
+	FIXED_CLK0(CLK_APMIXED_APLL2, 196608000),
 };
 
 /* TOPCKGEN FIXED CLK */
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK(CLK_TOP_CB_CKSQ_40M, CLK_XTAL, 40000000),
+	FIXED_CLK0(CLK_TOP_CB_CKSQ_40M, 40000000),
 };
 
 /* TOPCKGEN FIXED DIV */
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 04040f5ff63..d7b4fc0ddf3 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -23,6 +23,9 @@
 #define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
 #define VOID_PARENT PARENT(-1, 0)
 
+#define FIXED_CLK0(_id, _rate)					\
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+
 #define PLL_FACTOR(_id, _name, _parent, _mult, _div)                           \
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
 
@@ -34,19 +37,19 @@
 
 /* FIXED PLLS */
 static const struct mtk_fixed_clk fixed_pll_clks[] = {
-	FIXED_CLK(CLK_APMIXED_ARMPLL, CLK_XTAL, 2000000000),
-	FIXED_CLK(CLK_APMIXED_NET2PLL, CLK_XTAL, 800000000),
-	FIXED_CLK(CLK_APMIXED_MMPLL, CLK_XTAL, 1440000000),
-	FIXED_CLK(CLK_APMIXED_SGMPLL, CLK_XTAL, 325000000),
-	FIXED_CLK(CLK_APMIXED_WEDMCUPLL, CLK_XTAL, 760000000),
-	FIXED_CLK(CLK_APMIXED_NET1PLL, CLK_XTAL, 2500000000),
-	FIXED_CLK(CLK_APMIXED_MPLL, CLK_XTAL, 416000000),
-	FIXED_CLK(CLK_APMIXED_APLL2, CLK_XTAL, 196608000),
+	FIXED_CLK0(CLK_APMIXED_ARMPLL, 2000000000),
+	FIXED_CLK0(CLK_APMIXED_NET2PLL, 800000000),
+	FIXED_CLK0(CLK_APMIXED_MMPLL, 1440000000),
+	FIXED_CLK0(CLK_APMIXED_SGMPLL, 325000000),
+	FIXED_CLK0(CLK_APMIXED_WEDMCUPLL, 760000000),
+	FIXED_CLK0(CLK_APMIXED_NET1PLL, 2500000000),
+	FIXED_CLK0(CLK_APMIXED_MPLL, 416000000),
+	FIXED_CLK0(CLK_APMIXED_APLL2, 196608000),
 };
 
 /* TOPCKGEN FIXED CLK */
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK(CLK_TOP_XTAL, CLK_XTAL, 40000000),
+	FIXED_CLK0(CLK_TOP_XTAL, 40000000),
 };
 
 /* TOPCKGEN FIXED DIV */
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 3a30d16a158..12408c2e0b1 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -19,6 +19,9 @@
 #define MT7987_CLK_PDN		0x250
 #define MT7987_CLK_PDN_EN_WRITE	BIT(31)
 
+#define FIXED_CLK0(_id, _rate)                                                 \
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+
 #define XTAL_FACTOR(_id, _name, _parent, _mult, _div)                          \
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
 
@@ -33,14 +36,14 @@
 
 /* FIXED PLLS */
 static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
-	FIXED_CLK(CLK_APMIXED_MPLL, CLK_XTAL, 416000000),
-	FIXED_CLK(CLK_APMIXED_APLL2, CLK_XTAL, 196608000),
-	FIXED_CLK(CLK_APMIXED_NET1PLL, CLK_XTAL, 2500000000),
-	FIXED_CLK(CLK_APMIXED_NET2PLL, CLK_XTAL, 800000000),
-	FIXED_CLK(CLK_APMIXED_WEDMCUPLL, CLK_XTAL, 208000000),
-	FIXED_CLK(CLK_APMIXED_SGMPLL, CLK_XTAL, 325000000),
-	FIXED_CLK(CLK_APMIXED_ARM_LL, CLK_XTAL, 2000000000),
-	FIXED_CLK(CLK_APMIXED_MSDCPLL, CLK_XTAL, 384000000),
+	FIXED_CLK0(CLK_APMIXED_MPLL, 416000000),
+	FIXED_CLK0(CLK_APMIXED_APLL2, 196608000),
+	FIXED_CLK0(CLK_APMIXED_NET1PLL, 2500000000),
+	FIXED_CLK0(CLK_APMIXED_NET2PLL, 800000000),
+	FIXED_CLK0(CLK_APMIXED_WEDMCUPLL, 208000000),
+	FIXED_CLK0(CLK_APMIXED_SGMPLL, 325000000),
+	FIXED_CLK0(CLK_APMIXED_ARM_LL, 2000000000),
+	FIXED_CLK0(CLK_APMIXED_MSDCPLL, 384000000),
 };
 
 static const struct mtk_clk_tree mt7987_fixed_pll_clk_tree = {
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 71a16b9f19f..c447936cc40 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -21,6 +21,9 @@
 #define MT7988_ETHDMA_RST_CTRL_OFS	0x34
 #define MT7988_ETHWARP_RST_CTRL_OFS	0x8
 
+#define FIXED_CLK0(_id, _rate)                                                 \
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+
 #define XTAL_FACTOR(_id, _name, _parent, _mult, _div)                          \
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
 
@@ -35,23 +38,23 @@
 
 /* FIXED PLLS */
 static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
-	FIXED_CLK(CLK_APMIXED_NETSYSPLL, CLK_XTAL, 850000000),
-	FIXED_CLK(CLK_APMIXED_MPLL, CLK_XTAL, 416000000),
-	FIXED_CLK(CLK_APMIXED_MMPLL, CLK_XTAL, 720000000),
-	FIXED_CLK(CLK_APMIXED_APLL2, CLK_XTAL, 196608000),
-	FIXED_CLK(CLK_APMIXED_NET1PLL, CLK_XTAL, 2500000000),
-	FIXED_CLK(CLK_APMIXED_NET2PLL, CLK_XTAL, 800000000),
-	FIXED_CLK(CLK_APMIXED_WEDMCUPLL, CLK_XTAL, 208000000),
-	FIXED_CLK(CLK_APMIXED_SGMPLL, CLK_XTAL, 325000000),
-	FIXED_CLK(CLK_APMIXED_ARM_B, CLK_XTAL, 1500000000),
-	FIXED_CLK(CLK_APMIXED_CCIPLL2_B, CLK_XTAL, 960000000),
-	FIXED_CLK(CLK_APMIXED_USXGMIIPLL, CLK_XTAL, 644533000),
-	FIXED_CLK(CLK_APMIXED_MSDCPLL, CLK_XTAL, 400000000),
+	FIXED_CLK0(CLK_APMIXED_NETSYSPLL, 850000000),
+	FIXED_CLK0(CLK_APMIXED_MPLL, 416000000),
+	FIXED_CLK0(CLK_APMIXED_MMPLL, 720000000),
+	FIXED_CLK0(CLK_APMIXED_APLL2, 196608000),
+	FIXED_CLK0(CLK_APMIXED_NET1PLL, 2500000000),
+	FIXED_CLK0(CLK_APMIXED_NET2PLL, 800000000),
+	FIXED_CLK0(CLK_APMIXED_WEDMCUPLL, 208000000),
+	FIXED_CLK0(CLK_APMIXED_SGMPLL, 325000000),
+	FIXED_CLK0(CLK_APMIXED_ARM_B, 1500000000),
+	FIXED_CLK0(CLK_APMIXED_CCIPLL2_B, 960000000),
+	FIXED_CLK0(CLK_APMIXED_USXGMIIPLL, 644533000),
+	FIXED_CLK0(CLK_APMIXED_MSDCPLL, 400000000),
 };
 
 /* TOPCKGEN FIXED CLK */
 static const struct mtk_fixed_clk topckgen_mtk_fixed_clks[] = {
-	FIXED_CLK(CLK_TOP_XTAL, CLK_XTAL, 40000000),
+	FIXED_CLK0(CLK_TOP_XTAL, 40000000),
 };
 
 /* TOPCKGEN FIXED DIV */
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 5a353e82f3f..9d9d00622db 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -67,10 +67,16 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	    0, 0, 32, 8, 0x02B4, 1, 0x02B8, 0),
 };
 
+#define FIXED_CLK0(_id, _rate)						\
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+
+#define FIXED_CLK1(_id, _rate)						\
+	FIXED_CLK(_id, CLK_TOP_UNIVPLL, CLK_PARENT_TOPCKGEN, _rate)
+
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK(CLK_TOP_CLK26M, CLK_XTAL, 26000000),
-	FIXED_CLK(CLK_TOP_ULPOSC, CLK_XTAL, 250000),
-	FIXED_CLK(CLK_TOP_UNIVP_192M, CLK_TOP_UNIVPLL, 192000000),
+	FIXED_CLK0(CLK_TOP_CLK26M, 26000000),
+	FIXED_CLK0(CLK_TOP_ULPOSC, 250000),
+	FIXED_CLK1(CLK_TOP_UNIVP_192M, 192000000),
 };
 
 static const struct mtk_fixed_factor top_fixed_divs[] = {
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 02d30ab12d8..13f63d04ad0 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -68,12 +68,18 @@ static const struct mtk_pll_data apmixed_plls[] = {
 };
 
 /* topckgen */
+#define FIXED_CLK0(_id, _rate)						\
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+
+#define FIXED_CLK1(_id, _rate)						\
+	FIXED_CLK(_id, CLK_TOP_CLK26M, CLK_PARENT_TOPCKGEN, _rate)
+
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK(CLK_TOP_CLK_NULL, CLK_XTAL, 0),
-	FIXED_CLK(CLK_TOP_I2S0_BCK, CLK_XTAL, 26000000),
-	FIXED_CLK(CLK_TOP_DSI0_LNTC_DSICK, CLK_TOP_CLK26M, 75000000),
-	FIXED_CLK(CLK_TOP_VPLL_DPIX, CLK_TOP_CLK26M, 75000000),
-	FIXED_CLK(CLK_TOP_LVDSTX_CLKDIG_CTS, CLK_TOP_CLK26M, 52500000),
+	FIXED_CLK0(CLK_TOP_CLK_NULL, 0),
+	FIXED_CLK0(CLK_TOP_I2S0_BCK, 26000000),
+	FIXED_CLK1(CLK_TOP_DSI0_LNTC_DSICK, 75000000),
+	FIXED_CLK1(CLK_TOP_VPLL_DPIX, 75000000),
+	FIXED_CLK1(CLK_TOP_LVDSTX_CLKDIG_CTS, 52500000),
 };
 
 #define PLL_FACTOR(_id, _name, _parent, _mult, _div)			\
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index bad8c62601d..e6ced91fd06 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -59,6 +59,9 @@ static const struct mtk_pll_data apmixed_plls[] = {
 };
 
 /* topckgen */
+#define FIXED_CLK0(_id, _rate)			\
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+
 #define FACTOR0(_id, _parent, _mult, _div)	\
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
 
@@ -69,8 +72,8 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	FACTOR(_id, _parent, _mult, _div, 0)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK(CLK_TOP_CLK_NULL, CLK_XTAL, 26000000),
-	FIXED_CLK(CLK_TOP_CLK32K, CLK_XTAL, 32000),
+	FIXED_CLK0(CLK_TOP_CLK_NULL, 26000000),
+	FIXED_CLK0(CLK_TOP_CLK32K, 32000),
 };
 
 static const struct mtk_fixed_factor top_fixed_divs[] = {
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index a84a5f360f5..4985ba3e5ce 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -49,6 +49,12 @@ static const struct mtk_pll_data apmixed_plls[] = {
 };
 
 /* topckgen */
+#define FIXED_CLK0(_id, _rate)			\
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+
+#define FIXED_CLK1(_id, _parent, _rate)		\
+	FIXED_CLK(_id, _parent, CLK_PARENT_TOPCKGEN, _rate)
+
 #define FACTOR0(_id, _parent, _mult, _div)	\
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
 
@@ -59,9 +65,9 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	FACTOR(_id, _parent, _mult, _div, 0)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK(CLK_TOP_CLK_NULL, CLK_XTAL, 26000000),
-	FIXED_CLK(CLK_TOP_I2S_INFRA_BCK, CLK_TOP_CLK_NULL, 26000000),
-	FIXED_CLK(CLK_TOP_MEMPLL, CLK_TOP_CLK26M, 800000000),
+	FIXED_CLK0(CLK_TOP_CLK_NULL, 26000000),
+	FIXED_CLK1(CLK_TOP_I2S_INFRA_BCK, CLK_TOP_CLK_NULL, 26000000),
+	FIXED_CLK1(CLK_TOP_MEMPLL, CLK_TOP_CLK26M, 800000000),
 };
 
 static const struct mtk_fixed_factor top_fixed_divs[] = {
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 43a06217d33..2fc492e7170 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -51,6 +51,12 @@ static const struct mtk_pll_data apmixed_plls[] = {
 };
 
 /* topckgen */
+#define FIXED_CLK0(_id, _rate)			\
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+
+#define FIXED_CLK1(_id, _rate)			\
+	FIXED_CLK(_id, CLK_TOP_CLK_NULL, CLK_PARENT_TOPCKGEN, _rate)
+
 #define FACTOR0(_id, _parent, _mult, _div)	\
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
 
@@ -61,10 +67,10 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	FACTOR(_id, _parent, _mult, _div, 0)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK(CLK_TOP_CLK_NULL, CLK_XTAL, 26000000),
-	FIXED_CLK(CLK_TOP_FQ_TRNG_OUT0, CLK_TOP_CLK_NULL, 500000000),
-	FIXED_CLK(CLK_TOP_FQ_TRNG_OUT1, CLK_TOP_CLK_NULL, 500000000),
-	FIXED_CLK(CLK_TOP_CLK32K, CLK_XTAL, 32000),
+	FIXED_CLK0(CLK_TOP_CLK_NULL, 26000000),
+	FIXED_CLK1(CLK_TOP_FQ_TRNG_OUT0, 500000000),
+	FIXED_CLK1(CLK_TOP_FQ_TRNG_OUT1, 500000000),
+	FIXED_CLK0(CLK_TOP_CLK32K, 32000),
 };
 
 static const struct mtk_fixed_factor top_fixed_divs[] = {
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 6ba2fabfd08..e370d304c03 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -798,8 +798,7 @@ static void mtk_topckgen_dump(struct udevice *dev)
 		printf("[FCLK%u] DT: %u", i, fclk->id);
 		mtk_clk_print_mapped_id(fclk->id, i, tree->id_offs_map);
 		mtk_clk_print_rate(dev, i);
-		/* FIXME: fclk needs flags to fully determine parent. */
-		mtk_clk_print_single_parent(fclk->parent, 0);
+		mtk_clk_print_single_parent(fclk->parent, fclk->flags);
 		printf("\n");
 	}
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 25fd156ac30..eefcf5a00e2 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -78,12 +78,14 @@ struct mtk_pll_data {
 struct mtk_fixed_clk {
 	const int id;
 	const int parent;
+	const int flags;
 	unsigned long rate;
 };
 
-#define FIXED_CLK(_id, _parent, _rate) {		\
+#define FIXED_CLK(_id, _parent, _flags, _rate) {	\
 		.id = _id,				\
 		.parent = _parent,			\
+		.flags = _flags,			\
 		.rate = _rate,				\
 	}
 

-- 
2.43.0

