Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A177EEC2AD
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 23:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8816683C8C;
	Tue, 24 Feb 2026 00:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c7M3RnaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57B5483E13; Tue, 24 Feb 2026 00:22:55 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE1483BC9
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 00:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4bc9e48bbso1867633a34.2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771888971; x=1772493771;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0pg85DzG6TPpKvAVOHqaQWwm8Y0/jGDKjzaZzt2UuxI=;
 b=c7M3RnaBWMdJCiwuC2qjF6KRh+uUov/9qBknxWFrXQQaoAl3lcbdROgnmRzZhSS6k9
 2iHW/yNXwHmyP0HQG9L7XNoHib13PuQQI6WT//EiyUZvvrblVi0Q1tf6nOXr/4P1yaZg
 pzSKis0GlVhUAF7zn/K1IXnSEJX3ccdliEluOQkZcIM3s0Cw12UBMthM7nAqZh24ZPl+
 GixVe0GadyfTFpzR1sS/zPghwJUpjiQ+/fuBnyJ6wIhJEHyvGcEoiNtxgCL3Vbcj5uc2
 Me19dlWkHYfHVS5fW+TpMzBt0YlvnqxI1tDUb97+WPpOuKUQ9kZdW8uV+bNtCrMvR9iv
 S3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771888971; x=1772493771;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0pg85DzG6TPpKvAVOHqaQWwm8Y0/jGDKjzaZzt2UuxI=;
 b=TT5jU8wBNfJFWtmm7TeTnGYZHUSGEjjifjXpAJpuDEYRN7/OYvG7o21MEgkAiduR/G
 adJV1NRe1GDXIK7VHHww2NfJ0PpffjCXxCgerzWnbB13GNU+CZKHvMDGvC3VbM3Ay9ky
 3mD1inpT3qZU0LX6yW3FaIQK76eHrLsWiYmRBxMFRKz2ph3IrkP+Pj8s19w5iVhyQEds
 aEtnFCBf7OaO8gozcH6+fhV1lqa4yPHRB/CwKuTV0tEqfgCGWFyRNc1Rk7Xu11JTFxie
 JPNqu9Igao6xy1dM8XlXCVeS2vCVH6km1uQcAQHFLmWYpW4IsI6GY/n9njWIzKQgy074
 IddQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXciNHxAgUnzMJnZo0r8NtkmG4zNktmnW/pA62m1SFDukaIVYQTUUMWAb8zRS40K9DKWq6xkYo=@lists.denx.de
X-Gm-Message-State: AOJu0YwIyOJQPH1TUHSvi9PHIiU9ryXpvj8xp7MVX7Kdf0WjXh/EFPvm
 5/9kTdwXNA3LR98KIUCm5wUAasnq13yQnPehp2+fZ2zvli2QZwlHQ6wIKGNGizIodNs=
X-Gm-Gg: AZuq6aLFnFHCgGSyknq75MXoDylV5N3czvGzaD99kRHg5jiLQNN2u5/Z6089lEb485v
 KoN9TN3HPLotYZZE9zVCFjKYl+jYhs6nuiHPz72TaPx/WlLc2a8bTTRyzfG5+wFZtUu4UbikepM
 DZ7pX9QztfPLI1aI/89dXm0XLU5wvCgxbXOrAV0xcE3ZBOn5JQDeKN3zuRfvI30S4tDUksztLvL
 6tBhMO5xg0X3WdLr8BUyXoJqQfvjO8qlQkBKfDEx54NdOoDiF8DkqSzPveAqJ5EDCzDlZyMCMRr
 PwZAELlnxAPdSFlZ5P+Vj9wRQTAYuJ6I5R4sslnINSxp2xiGS+ayJ6mPIdX7PHVtcSC8Ue4kmQS
 9EKrCCcASfHIEliArhQN4MOhmbCv1DuECM+apDSINh8Dw/OCwtbVZHD6R4tCHYQzNRvEeeO/uof
 fE3DAQCC2qGCYhja10XR89NR4B4wkAbj1v0Gt0Z4A=
X-Received: by 2002:a05:6830:2a0b:b0:7d1:a051:9c9c with SMTP id
 46e09a7af769-7d52bccaf57mr5048945a34.0.1771888971175; 
 Mon, 23 Feb 2026 15:22:51 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cb87:475c:5c04:ac92])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78736sm8911230a34.5.2026.02.23.15.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 15:22:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Feb 2026 17:21:53 -0600
Subject: [PATCH 1/7] clk: mediatek: rename HAVE_RST_BAR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-1-a7dc97bc2660@baylibre.com>
References: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com>
In-Reply-To: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11909;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=dLpDznGWDADWpLGSbx5wDsDewTKC10Zpe/fa5QncTM0=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpnOEakgVANdvTUdNlXLjlp98TUJZAQPcCnBof3
 em/C4j1PvqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZzhGhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Atw8IAIgP0A9oGp51rDb1FcW/EPJqvZmgtaFpKu5Yw6T
 z6jKuvX6k/zqLOW8wD+sgSMFQT4VyZ6O+uV44gUj4ZlX3lieCZ+DUIjYffwWaUQ++NJJXTILSsj
 viSFBlbUtHbHKryc54OsG7Qq5Jjmt6r3V+QNrM0COK341JwsUUJO2TVE1tBjGxV7zWstyD6A74s
 GxvXbRDYCxGdaddQxD1er+hTffbtrf8q+ZN2mzI09mpqTuyNkIxNaSPTpr6kVOTRI6JDX5Ihoki
 Lka7o+PXaL4Vb79nJ9Snl5VaolVceUIPp/u9WuWft9dJyxQbL+6RLoFebv5HS2DYfifCmalEsx1
 y28g=
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

Rename HAVE_RST_BAR to CLK_PLL_HAVE_RST_BAR. This makes it more clear
that this flag only applies to PLL clocks. Also add a blank line between
CLK_PLL_HAVE_RST_BAR and the CLK_MUX_ macros to keep the grouping of the
flags consistent.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c |  4 ++--
 drivers/clk/mediatek/clk-mt7623.c |  4 ++--
 drivers/clk/mediatek/clk-mt7629.c |  4 ++--
 drivers/clk/mediatek/clk-mt8183.c | 12 ++++++------
 drivers/clk/mediatek/clk-mt8188.c |  6 +++---
 drivers/clk/mediatek/clk-mt8195.c |  6 +++---
 drivers/clk/mediatek/clk-mt8365.c |  4 ++--
 drivers/clk/mediatek/clk-mt8512.c |  4 ++--
 drivers/clk/mediatek/clk-mt8516.c |  4 ++--
 drivers/clk/mediatek/clk-mt8518.c |  4 ++--
 drivers/clk/mediatek/clk-mtk.c    |  4 ++--
 drivers/clk/mediatek/clk-mtk.h    |  3 ++-
 12 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 782eb14e9c5..108c0dcd14e 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -48,9 +48,9 @@
 static const struct mtk_pll_data apmixed_plls[] = {
 	PLL(CLK_APMIXED_ARMPLL, 0x200, 0x20c, 0x1, 0,
 	    21, 0x204, 24, 0x204, 0),
-	PLL(CLK_APMIXED_MAINPLL, 0x210, 0x21c, 0x1, HAVE_RST_BAR,
+	PLL(CLK_APMIXED_MAINPLL, 0x210, 0x21c, 0x1, CLK_PLL_HAVE_RST_BAR,
 	    21, 0x214, 24, 0x214, 0),
-	PLL(CLK_APMIXED_UNIV2PLL, 0x220, 0x22c, 0x1, HAVE_RST_BAR,
+	PLL(CLK_APMIXED_UNIV2PLL, 0x220, 0x22c, 0x1, CLK_PLL_HAVE_RST_BAR,
 	    7, 0x224, 24, 0x224, 14),
 	PLL(CLK_APMIXED_ETH1PLL, 0x300, 0x310, 0x1, 0,
 	    21, 0x300, 1, 0x304, 0),
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 071c4cf8a84..70570644ca4 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -61,9 +61,9 @@ static const int pll_id_offs_map[] = {
 static const struct mtk_pll_data apmixed_plls[] = {
 	PLL(CLK_APMIXED_ARMPLL, 0x200, 0x20c, 0x80000001, 0,
 	    21, 0x204, 24, 0x204, 0),
-	PLL(CLK_APMIXED_MAINPLL, 0x210, 0x21c, 0xf0000001, HAVE_RST_BAR,
+	PLL(CLK_APMIXED_MAINPLL, 0x210, 0x21c, 0xf0000001, CLK_PLL_HAVE_RST_BAR,
 	    21, 0x210, 4, 0x214, 0),
-	PLL(CLK_APMIXED_UNIVPLL, 0x220, 0x22c, 0xf3000001, HAVE_RST_BAR,
+	PLL(CLK_APMIXED_UNIVPLL, 0x220, 0x22c, 0xf3000001, CLK_PLL_HAVE_RST_BAR,
 	    7, 0x220, 4, 0x224, 14),
 	PLL(CLK_APMIXED_MMPLL, 0x230, 0x23c, 0x00000001, 0,
 	    21, 0x230, 4, 0x234, 0),
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 582394f594b..7fe62bdcea5 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -48,9 +48,9 @@
 static const struct mtk_pll_data apmixed_plls[] = {
 	PLL(CLK_APMIXED_ARMPLL, 0x200, 0x20c, 0x1, 0,
 	    21, 0x204, 24, 0x204, 0),
-	PLL(CLK_APMIXED_MAINPLL, 0x210, 0x21c, 0x1, HAVE_RST_BAR,
+	PLL(CLK_APMIXED_MAINPLL, 0x210, 0x21c, 0x1, CLK_PLL_HAVE_RST_BAR,
 	    21, 0x214, 24, 0x214, 0),
-	PLL(CLK_APMIXED_UNIV2PLL, 0x220, 0x22c, 0x1, HAVE_RST_BAR,
+	PLL(CLK_APMIXED_UNIV2PLL, 0x220, 0x22c, 0x1, CLK_PLL_HAVE_RST_BAR,
 	    7, 0x224, 24, 0x224, 14),
 	PLL(CLK_APMIXED_ETH1PLL, 0x300, 0x310, 0x1, 0,
 	    21, 0x300, 1, 0x304, 0),
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 9d9d00622db..752cb1c61ab 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -38,24 +38,24 @@
 
 static const struct mtk_pll_data apmixed_plls[] = {
 	PLL(CLK_APMIXED_ARMPLL_LL, 0x0200, 0x020C, 0x00000001,
-	    HAVE_RST_BAR, BIT(24), 22, 8, 0x0204, 24,
+	    CLK_PLL_HAVE_RST_BAR, BIT(24), 22, 8, 0x0204, 24,
 	    0x0204, 0),
 	PLL(CLK_APMIXED_ARMPLL_L, 0x0210, 0x021C, 0x00000001,
-	    HAVE_RST_BAR, BIT(24), 22, 8, 0x0214, 24,
+	    CLK_PLL_HAVE_RST_BAR, BIT(24), 22, 8, 0x0214, 24,
 	    0x0214, 0),
 	PLL(CLK_APMIXED_CCIPLL, 0x0290, 0x029C, 0x00000001,
-	    HAVE_RST_BAR, BIT(24), 22, 8, 0x0294, 24,
+	    CLK_PLL_HAVE_RST_BAR, BIT(24), 22, 8, 0x0294, 24,
 	    0x0294, 0),
 	PLL(CLK_APMIXED_MAINPLL, 0x0220, 0x022C, 0x00000001,
-	    HAVE_RST_BAR, BIT(24), 22, 8, 0x0224, 24,
+	    CLK_PLL_HAVE_RST_BAR, BIT(24), 22, 8, 0x0224, 24,
 	    0x0224, 0),
 	PLL(CLK_APMIXED_UNIV2PLL, 0x0230, 0x023C, 0x00000001,
-	    HAVE_RST_BAR, BIT(24), 22, 8, 0x0234, 24,
+	    CLK_PLL_HAVE_RST_BAR, BIT(24), 22, 8, 0x0234, 24,
 	    0x0234, 0),
 	PLL(CLK_APMIXED_MSDCPLL, 0x0250, 0x025C, 0x00000001,
 	    0, 0, 22, 8, 0x0254, 24, 0x0254, 0),
 	PLL(CLK_APMIXED_MMPLL, 0x0270, 0x027C, 0x00000001,
-	    HAVE_RST_BAR, BIT(23), 22, 8, 0x0274, 24,
+	    CLK_PLL_HAVE_RST_BAR, BIT(23), 22, 8, 0x0274, 24,
 	    0x0274, 0),
 	PLL(CLK_APMIXED_MFGPLL, 0x0240, 0x024C, 0x00000001,
 	    0, 0, 22, 8, 0x0244, 24, 0x0244, 0),
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index b720eec8ba7..9d1da23d066 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -56,13 +56,13 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	    0x0528, 0),
 	PLL(CLK_APMIXED_TVDPLL2, 0x0534, 0x0540, 0, 0, 22, 0x0538, 24,
 	    0x0538, 0),
-	PLL(CLK_APMIXED_MMPLL, 0x0544, 0x0550, 0xff000000, HAVE_RST_BAR,
+	PLL(CLK_APMIXED_MMPLL, 0x0544, 0x0550, 0xff000000, CLK_PLL_HAVE_RST_BAR,
 	    22, 0x0548, 24, 0x0548, 0),
-	PLL(CLK_APMIXED_MAINPLL, 0x045C, 0x0468, 0xff000000, HAVE_RST_BAR,
+	PLL(CLK_APMIXED_MAINPLL, 0x045C, 0x0468, 0xff000000, CLK_PLL_HAVE_RST_BAR,
 	    22, 0x0460, 24, 0x0460, 0),
 	PLL(CLK_APMIXED_IMGPLL, 0x0554, 0x0560, 0, 0, 22, 0x0558, 24,
 	    0x0558, 0),
-	PLL(CLK_APMIXED_UNIVPLL, 0x0504, 0x0510, 0xff000000, HAVE_RST_BAR,
+	PLL(CLK_APMIXED_UNIVPLL, 0x0504, 0x0510, 0xff000000, CLK_PLL_HAVE_RST_BAR,
 	    22, 0x0508, 24, 0x0508, 0),
 	PLL(CLK_APMIXED_ADSPPLL, 0x042C, 0x0438, 0, 0, 22, 0x0430, 24,
 	    0x0430, 0),
diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index d05d56c9bf6..d9d63601cc4 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -62,15 +62,15 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	    0x00a8, 0, 0x00a8),
 	PLL(CLK_APMIXED_TVDPLL2, 0x00c0, 0x00d0, 0, 0, 0, 22, 0x00c8, 24,
 	    0x00c8, 0, 0x00c8),
-	PLL(CLK_APMIXED_MMPLL, 0x00e0, 0x00f0, 0xff000000, HAVE_RST_BAR,
+	PLL(CLK_APMIXED_MMPLL, 0x00e0, 0x00f0, 0xff000000, CLK_PLL_HAVE_RST_BAR,
 	    BIT(23), 22, 0x00e8, 24, 0x00e8, 0, 0x00e8),
-	PLL(CLK_APMIXED_MAINPLL, 0x01d0, 0x01e0, 0xff000000, HAVE_RST_BAR,
+	PLL(CLK_APMIXED_MAINPLL, 0x01d0, 0x01e0, 0xff000000, CLK_PLL_HAVE_RST_BAR,
 	    BIT(23), 22, 0x01d8, 24, 0x01d8, 0, 0x01d8),
 	PLL(CLK_APMIXED_VDECPLL, 0x0890, 0x08a0, 0, 0, 0, 22, 0x0898, 24,
 	    0x0898, 0, 0x0898),
 	PLL(CLK_APMIXED_IMGPLL, 0x0100, 0x0110, 0, 0, 0, 22, 0x0108, 24,
 	    0x0108, 0, 0x0108),
-	PLL(CLK_APMIXED_UNIVPLL, 0x01f0, 0x0700, 0xff000000, HAVE_RST_BAR,
+	PLL(CLK_APMIXED_UNIVPLL, 0x01f0, 0x0700, 0xff000000, CLK_PLL_HAVE_RST_BAR,
 	    BIT(23), 22, 0x01f8, 24, 0x01f8, 0, 0x01f8),
 	PLL(CLK_APMIXED_HDMIPLL1, 0x08c0, 0x08d0, 0, 0, 0, 22, 0x08c8, 24,
 	    0x08c8, 0, 0x08c8),
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 6ba464097ae..2b1703e7203 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -45,9 +45,9 @@
 static const struct mtk_pll_data apmixed_plls[] = {
 	PLL(CLK_APMIXED_ARMPLL, 0x030C, 0x0318, 0x00000001, PLL_AO, 22, 0x0310,
 	    24, 0x0310, 0, 0, 0),
-	PLL(CLK_APMIXED_MAINPLL, 0x0228, 0x0234, 0xFF000001, HAVE_RST_BAR, 22,
+	PLL(CLK_APMIXED_MAINPLL, 0x0228, 0x0234, 0xFF000001, CLK_PLL_HAVE_RST_BAR, 22,
 	    0x022C, 24, 0x022C, 0, CON0_MT8365_RST_BAR, 0),
-	PLL(CLK_APMIXED_UNIVPLL, 0x0208, 0x0214, 0xFF000001, HAVE_RST_BAR, 22,
+	PLL(CLK_APMIXED_UNIVPLL, 0x0208, 0x0214, 0xFF000001, CLK_PLL_HAVE_RST_BAR, 22,
 	    0x020C, 24, 0x020C, 0, CON0_MT8365_RST_BAR, 0),
 	PLL(CLK_APMIXED_MFGPLL, 0x0218, 0x0224, 0x00000001, 0, 22, 0x021C, 24,
 	    0x021C, 0, 0, 0),
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index e6ced91fd06..69576304f2f 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -41,9 +41,9 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	PLL(CLK_APMIXED_ARMPLL, 0x030C, 0x0318, 0x00000001,
 	    0, 22, 0x0310, 24, 0x0310, 0, 0),
 	PLL(CLK_APMIXED_MAINPLL, 0x0228, 0x0234, 0x00000001,
-	    HAVE_RST_BAR, 22, 0x022C, 24, 0x022C, 0, 0),
+	    CLK_PLL_HAVE_RST_BAR, 22, 0x022C, 24, 0x022C, 0, 0),
 	PLL(CLK_APMIXED_UNIVPLL2, 0x0208, 0x0214, 0x00000001,
-	    HAVE_RST_BAR, 22, 0x020C, 24, 0x020C, 0, 0),
+	    CLK_PLL_HAVE_RST_BAR, 22, 0x020C, 24, 0x020C, 0, 0),
 	PLL(CLK_APMIXED_MSDCPLL, 0x0350, 0x035C, 0x00000001,
 	    0, 22, 0x0354, 24, 0x0354, 0, 0),
 	PLL(CLK_APMIXED_APLL1, 0x031C, 0x032C, 0x00000001,
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 4985ba3e5ce..dac4aad61ef 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -37,9 +37,9 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	PLL(CLK_APMIXED_ARMPLL, 0x0100, 0x0110, 0x00000001, 0,
 		21, 0x0104, 24, 0x0104, 0),
 	PLL(CLK_APMIXED_MAINPLL, 0x0120, 0x0130, 0x00000001,
-		HAVE_RST_BAR, 21, 0x0124, 24, 0x0124, 0),
+		CLK_PLL_HAVE_RST_BAR, 21, 0x0124, 24, 0x0124, 0),
 	PLL(CLK_APMIXED_UNIVPLL, 0x0140, 0x0150, 0x30000001,
-		HAVE_RST_BAR, 7, 0x0144, 24, 0x0144, 0),
+		CLK_PLL_HAVE_RST_BAR, 7, 0x0144, 24, 0x0144, 0),
 	PLL(CLK_APMIXED_MMPLL, 0x0160, 0x0170, 0x00000001, 0,
 		21, 0x0164, 24, 0x0164, 0),
 	PLL(CLK_APMIXED_APLL1, 0x0180, 0x0190, 0x00000001, 0,
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 2fc492e7170..c19828def06 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -37,9 +37,9 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	PLL(CLK_APMIXED_ARMPLL, 0x0100, 0x0110, 0x00000001,
 	    0, 21, 0x0104, 24, 0x0104, 0),
 	PLL(CLK_APMIXED_MAINPLL, 0x0120, 0x0130, 0x00000001,
-	    HAVE_RST_BAR, 21, 0x0124, 24, 0x0124, 0),
+	    CLK_PLL_HAVE_RST_BAR, 21, 0x0124, 24, 0x0124, 0),
 	PLL(CLK_APMIXED_UNIVPLL, 0x0140, 0x0150, 0x30000001,
-	    HAVE_RST_BAR, 7, 0x0144, 24, 0x0144, 0),
+	    CLK_PLL_HAVE_RST_BAR, 7, 0x0144, 24, 0x0144, 0),
 	PLL(CLK_APMIXED_MMPLL, 0x0160, 0x0170, 0x00000001,
 	    0, 21, 0x0164, 24, 0x0164, 0),
 	PLL(CLK_APMIXED_APLL1, 0x0180, 0x0190, 0x00000001,
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 6f7e2144332..0f29627665b 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -598,7 +598,7 @@ static int mtk_apmixedsys_enable(struct clk *clk)
 
 	udelay(20);
 
-	if (pll->flags & HAVE_RST_BAR) {
+	if (pll->flags & CLK_PLL_HAVE_RST_BAR) {
 		r = readl(priv->base + pll->reg + REG_CON0);
 		r |= pll->rst_bar_mask;
 		writel(r, priv->base + pll->reg + REG_CON0);
@@ -622,7 +622,7 @@ static int mtk_apmixedsys_disable(struct clk *clk)
 
 	pll = &priv->tree->plls[clk->id];
 
-	if (pll->flags & HAVE_RST_BAR) {
+	if (pll->flags & CLK_PLL_HAVE_RST_BAR) {
 		r = readl(priv->base + pll->reg + REG_CON0);
 		r &= ~pll->rst_bar_mask;
 		writel(r, priv->base + pll->reg + REG_CON0);
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index c4aeee49abd..806ec2ec20a 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -20,7 +20,8 @@
  */
 #define CLK_BYPASS_XTAL			BIT(0)
 
-#define HAVE_RST_BAR			BIT(0)
+#define CLK_PLL_HAVE_RST_BAR		BIT(0)
+
 #define CLK_DOMAIN_SCPSYS		BIT(0)
 #define CLK_MUX_SETCLR_UPD		BIT(1)
 

-- 
2.43.0

