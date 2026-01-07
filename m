Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86452CFD65D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD8C84099;
	Wed,  7 Jan 2026 17:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fVn1QbbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF6F8398C; Wed,  7 Jan 2026 17:22:35 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B60D83A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 17:22:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c75fc222c3so1181501a34.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 08:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767802951; x=1768407751;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7svgE6HGy85mHi2971DK21jCCG40P7+38+83R7bireA=;
 b=fVn1QbbUOr+Yt/XKEORaQG3OzD+ju/N7ZhfE4tNgxGVq+zb+IvBJT3Y+AgDQazERnH
 cxlADrGhaP/OGfoyBV6pVfKmuUJ/If7Xaa60bct26YhTi5ZhBDhoDQKpaRrYeI/XzK6M
 iMlkB0Z60eQZyYRWb9DIl1k2dynoyXQ2Tx9a7mhoQtltSF+sWVFKg/faViOIMJZ2a1NT
 qA8bdX2xblUriWreNTlJ48oxNlKO92w8V4yCb6YZnDxUquRZ/jx+lMhGyKckCdwl9Fjd
 y9MqZgs8sL7fpjjowssYA81Td8azhUcUxOshVDHt15hvIDWiBGdC7pS/ZwvfZvtC/34W
 31FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767802951; x=1768407751;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7svgE6HGy85mHi2971DK21jCCG40P7+38+83R7bireA=;
 b=OnzbDQmooxMrvsRVl8uHrJCJBwgG7ee0bk96aPN9IX5p/Re0QMw+CZtlMaSuME0gf5
 MM/Q+m261yTTEugBzNWJofRgLx+sM/mqxtOYdUWkVTvkeiMnM/nX46wDAGLE6u21Kg/r
 ajzEWgm8+IvgFX1Lv2+TcIMpf2ZYFcKBHSkSnpOE7wWuhIe1YEeWRTBTQqyF/4SI3qT+
 a6HDpFhz/m75p8Z0Awcy0r2BSBXipKtCz+tPXQB21STqg1+IBpmFYAMFqrX/cz6UZgis
 POmAYZuvbV2c1u4jOK7IHVIiqXLTlx7VQ5YLWyeWbVqsh8xFDKl3nDfyJBI4MQ6dqHu9
 6UcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRoKTWNdC1zxdBqf9TdoBlFn1wmFAOJ7A1t4IAWbKzHMQ4e6nhXvrkplMch7QVHNi5XoVjWp4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp1D9PpqS5fRJxbg1WdYOmrIRUHVD2tRJuVtdwSQlbLljpibiQ
 i5SNQrXvawfkW5YJ/tEqzJVvkiVjGjO39WLNWYjDo+MLpOL8hRRBcHs9kuZfdkT0t08=
X-Gm-Gg: AY/fxX7vRC8PVKknNnUyjqpfMEzWYYc28bxXeWjnovkzEV9sMJLlTgKplN7FtX9Hk4s
 gg37MawAPFjBYQ1zSs3A0222AIPSn99etT5yC10W5bc9OP297Y7lvz5ILWpH9GWBYGO4QvxHDG4
 zi0XBeOGQ1GlQB8dZTNJaa3AbaYpXK6QJ7jo9xyKJEyAbvBnDfE0JLlIFKzmJcAVGWjzhrqMrVh
 wgIOE8ip6iTFuvi6Xc3kArAtkk0bjcs+lmPNjmIrMfRxE9O9o8lcRJpHiSu5MMx+EjIg1zi6fEo
 rbGvqHobgUZYwgjXD8XE6axFzs68naTcHUtf2uFFgRrEgVC24TNuIkS11ZAZUIIS1glQ2nZJsFv
 NCjjXqNaFqNwAzIoQtDfOaGV5OSzqXXWTK1bOP/emdsagFbJBS/YMHHS7d3P1CaPINPSZskhHH9
 JG+k+eziiL0qtdBQk=
X-Google-Smtp-Source: AGHT+IF75lEBPl1z/AkeVmGWXvHDSrHQ9l8WXCOiPDvnd6kgxoBgKV6JYuFvxdFzCsZbWhcQPLmFaQ==
X-Received: by 2002:a05:6830:3c1:b0:7ca:c723:6f42 with SMTP id
 46e09a7af769-7ce508d679amr1636228a34.10.1767802951123; 
 Wed, 07 Jan 2026 08:22:31 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce4762eefbsm3958245a34.0.2026.01.07.08.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 08:22:30 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 10:21:10 -0600
Subject: [PATCH v2 4/9] clk: mediatek: fix fixed clock parents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-mt8365-fixes-v2-4-3294a5d2f239@baylibre.com>
References: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
In-Reply-To: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=22083;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=dGA6pqNOckx6ryfV+bjv2wbKlZhtcF4o5QTptt8In+s=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXogbuwg9Tjk8WMQp01DGkJAuuS+JUXWkRkh6x
 mJRgVuRwIKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6IGxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2PgH/RWcP+/M/v27GuvGh4spwsfIY7rYkZms/nNIsj4
 kPbUIsEWTPppplNrPPj75viAvlE5p2rBU3bcgQzqh9IUsulReqSmzCytsHjFRLyGsV6neq6EM8z
 9N8HsMxQA82kNOBnr6Qi3x35+gI4BBjnaTQwytyqAR0Ut5PqhYMVyr1NhqgWOELlEpan4nL2eR0
 12ErZ75af8qcsurrsWewpEvmr4hr8bbqSBBSyD/5XrZdltQW8r1E8x5Ocg9+D/6Bjmvgy9fApf/
 yhJ5yGuARGsjGI374t8ru0Zk9+J/0CdZFebZZiuUdZ+E9jfG3wKam/YU1C4wgHeAf0T9CLBI5nC
 38DM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:23:20 +0100
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
 drivers/clk/mediatek/clk-mt8188.c | 19 +++++++++++--------
 drivers/clk/mediatek/clk-mt8365.c | 16 +++++++++++-----
 drivers/clk/mediatek/clk-mt8512.c |  7 +++++--
 drivers/clk/mediatek/clk-mt8516.c | 12 +++++++++---
 drivers/clk/mediatek/clk-mt8518.c | 14 ++++++++++----
 drivers/clk/mediatek/clk-mtk.c    |  3 +--
 drivers/clk/mediatek/clk-mtk.h    |  4 +++-
 15 files changed, 154 insertions(+), 102 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 9621d5efe11..782eb14e9c5 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -85,6 +85,9 @@ static const struct mtk_gate apmixed_cgs[] = {
 };
 
 /* topckgen */
+#define FIXED_CLK0(_id, _rate)					\
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
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
index 3509ea67e7d..071c4cf8a84 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -259,6 +259,9 @@ static const int top_id_offs_map[CLK_TOP_NR + 1] = {
 	[CLK_TOP_AUD_I2S6_MCLK]			= 158,
 };
 
+#define FIXED_CLK0(_id, _rate)					\
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
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
index 3f96d25db04..09ed4d8a97f 100644
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
index a8f39a3beb6..79efbf43bc4 100644
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
index 818f45ef6bb..959b1c9cff6 100644
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
index 6da7c62c585..cd8726852d7 100644
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
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index d967a915fac..64aeaa5949f 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -88,15 +88,18 @@ static const struct mtk_clk_tree mt8188_apmixedsys_clk_tree = {
 	.num_plls = ARRAY_SIZE(apmixed_plls),
 };
 
+#define FIXED_CLK0(_id, _rate)			\
+	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK(CLK_TOP_ULPOSC1, CLK_XTAL, 260000000),
-	FIXED_CLK(CLK_TOP_MPHONE_SLAVE_BCK, CLK_XTAL, 49152000),
-	FIXED_CLK(CLK_TOP_PAD_FPC, CLK_XTAL, 50000000),
-	FIXED_CLK(CLK_TOP_466M_FMEM, CLK_XTAL, 533000000),
-	FIXED_CLK(CLK_TOP_PEXTP_PIPE, CLK_XTAL, 250000000),
-	FIXED_CLK(CLK_TOP_DSI_PHY, CLK_XTAL, 500000000),
-	FIXED_CLK(CLK_TOP_CLK26M, CLK_XTAL, 260000000),
-	FIXED_CLK(CLK_TOP_CLK32K, CLK_XTAL, 32000),
+	FIXED_CLK0(CLK_TOP_ULPOSC1, 260000000),
+	FIXED_CLK0(CLK_TOP_MPHONE_SLAVE_BCK, 49152000),
+	FIXED_CLK0(CLK_TOP_PAD_FPC, 50000000),
+	FIXED_CLK0(CLK_TOP_466M_FMEM, 533000000),
+	FIXED_CLK0(CLK_TOP_PEXTP_PIPE, 250000000),
+	FIXED_CLK0(CLK_TOP_DSI_PHY, 500000000),
+	FIXED_CLK0(CLK_TOP_CLK26M, 260000000),
+	FIXED_CLK0(CLK_TOP_CLK32K, 32000),
 };
 
 #define FACTOR0(_id, _parent, _mult, _div)	\
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
index 068240b123e..e618e982e8b 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -73,12 +73,14 @@ struct mtk_pll_data {
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

