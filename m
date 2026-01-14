Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43334D31A09
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 03:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B0EA830CA;
	Wed, 14 Jan 2026 04:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H9g1ApVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ABDF803F5; Wed, 14 Jan 2026 02:53:57 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC369800AE
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 02:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7cfcbe7d176so74800a34.3
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 17:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768355633; x=1768960433;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iWHL3lxhoSjjiOR8xmwAhMjO74hUex37FX9PNy1/a10=;
 b=H9g1ApVee6AN7ZMuK84jn7F3nrUW7aBscXKY9iHEA7Qbu5XU7dIT/Fn0dQKXfIPtVd
 rIPH5N9UgZKOtDqigL0IXY4xO1zdUf+xGfLBeyqJU6MNx5p5Jy8qdc1VrSdMVy0cSOKX
 X7kIsRzI1Ocz7/9f+VlXL4xK1Rfeb2frwWYadqzjmB2yNQ8YaZDBbWGwEU1RzXCcQkGl
 G5x/yW0cAyM7ql6kfZtxsayg0w+ftnsd3jvXWnfsmua/JG9s2DzusS5gBTHU1VTj05id
 l1VWVbugY/QjDZv/S/15uyLvPBWtcef1WPRizBj2yrEwxZ0UCbyUHg5D6hAdglPmdY14
 2seA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768355633; x=1768960433;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWHL3lxhoSjjiOR8xmwAhMjO74hUex37FX9PNy1/a10=;
 b=csqCw8GMpUe+oDrPosHbTDfPsZ2Ah+vNqMCN1kFB4Wlgk7j72qTMeCCelC6Jc4vdNH
 YrcbsbVFv5QI9isJwduKy5shC6dSzAXVylykefQKSmsLrY/Ia/gttp3haHpW+F2pl0BC
 w7kghyE9hnjxhsN4sHVzyWCOgth2wMnk+OpIABOizjqZDecvarphVW/KWLUBntlQ+czI
 F/EpQkUM1B9VyNBKUqSy25eM6KCNTSoiSYXkINAB4aLVeFxFfyLiuQidR69gbN2LuJDI
 TWzHQkWqbYhRetefnzz2MJmTWDm7QeGho/mu7RZ/b/msXlzeFSREvcUwUUdOgFu2SyBn
 60OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1NnFspU31kjc6e2vXXAhlhslPb0mh5+OLlnRcTPKmwkmxzyi1QX+t++mCZ7vkXAk31Q73NWw=@lists.denx.de
X-Gm-Message-State: AOJu0YyF+QB8fWCk18PViyqIAewRNT2bUegtUsR/u9oS8NQU7yC3tKZr
 H9ljrPDOEDatuEfd5q23/kP9Qb022LREQFxzsgEDXDvSieVhpJia++C+UB87efD/UkOC45tgYqi
 NT1PF
X-Gm-Gg: AY/fxX5dQ4WS4v1BWVVb3GEjgmCfkRQhStrZqRsumIw0hXGNXe9OqbZ6HJqPPkGkyFl
 oO2lnpwMhRSxEmUhPg6ci5EDo0+d3px/aJMEjm2tTgOb30wm9gJyyN/hoktvfI7ua8ODcP13/j3
 NrL1a7iRrFV6WL4nJYMm+Ying/LdUjiHrJxSWwLoH8xsz5XkWlSE09ZRkWX8MGZtoTe7aa4azFx
 gvFbK0tWbElfDlXLIQFEH3TuxryNZhDPknSQQwHMZS7I7dJnVa/8X2SIXkNLhWZJ6khgOCBT3u6
 b1Iy3YjNn3UtuNaQZFBJqV94NI2bdaDSOZw5yEtKWjtlVETSKCo/WFjSLdodHuht/mnhq1iUv+x
 utHRO81NfWQ4IgHGhUbJyRJt5+cGk4brsQNMHF0/EIwKU7SAlchYXIxLE4vGYR2RrNd8yv8uSm1
 6+Wb4vDsu5/+g1Qdw=
X-Received: by 2002:a05:6830:34a4:b0:790:710f:60e3 with SMTP id
 46e09a7af769-7cfc8b2a084mr1016072a34.23.1768355633633; 
 Tue, 13 Jan 2026 17:53:53 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2f58:e1e3:bd08:f09e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce47835588sm16731426a34.13.2026.01.13.17.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 17:53:53 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 13 Jan 2026 19:53:44 -0600
Subject: [PATCH] pinctrl: mediatek: mt8365: add PUPD registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-pinctrl-mtk-mt8365-pupd-registers-v1-1-4bceaa52198a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQqDMBAFf0X23AVjrGh/pXgI+moX2zTsRimI/
 97QwxzmMnOQQQVGt+ogxS4mn1jEXSqaniEuYJmLU1M3Xe2c5yRxyvrid14Lve+unLY0s2IRy1B
 jN6ANwQNDCyqdpHjI9/+4j+f5A8O2Lr5zAAAA
X-Change-ID: 20260113-pinctrl-mtk-mt8365-pupd-registers-19e4aa3ee94e
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5733; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=72EobGGQrngzVIWJMLU2dEGVKWPjx2Yief1RIwdPH4s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpZvcpljvWHlnvnQ+AlOoGCzrnJFifLwuTZBXKK
 Zw5FMExvZyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWb3KRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AoEMH/A7U+mbxqh11eD7f5TranuCyf1poaH/SlIvR6sU
 8V+EFU3xD+sAk36uiYpd9W+8j4k1q9FxZDNMsEKIjVMkFTWp+D5ZfyK4i8akEl5etzOTbODIzZf
 mygfV5YY2Km0tMANs5BfDfbouDOHaLWtTGwI2/r80J3dAKd8rH3NDpejWZmKC/LEjvTWIqvSvJQ
 MLEXnxAHBRdl79aVVnWgYws7FVhAV/htSm3l+ZaoCKhiMheiq28H6LFMarpXoU8jVXvanpvjqCy
 1j39JBLJgM2Igzt2hUcxJ2Y8l0KhlXJepf7Swonn6OB/FTqeNvY4GKVzTa0N3IGGQ+p1L0Kj0B1
 AHvE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 14 Jan 2026 04:16:18 +0100
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

Add pull-up/pull-down (PUPD) register definitions for mt8365.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8365.c | 132 ++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
index 0eae85b0078..9e4fe44e861 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8365.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -23,6 +23,9 @@
 #define PIN_FIELD_DRV(_s_pin, _e_pin, _s_addr, _s_bit) \
 	PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, 0x10, _s_bit, 4, 32, true)
 
+#define PIN_FIELD_PUPD(_s_pin, _s_addr, _s_bit) \
+	PIN_FIELD(_s_pin, _s_pin, _s_addr, 0x10, _s_bit, 1)
+
 static const struct mtk_pin_field_calc mt8365_pin_mode_range[] = {
 	PIN_FIELD_MODE(0,   9,   0x1e0),
 	PIN_FIELD_MODE(10,  19,  0x1f0),
@@ -223,6 +226,132 @@ static const struct mtk_pin_field_calc mt8365_pin_drv_range[] = {
 	PIN_FIELD_DRV(136, 144, 0x770, 24),
 };
 
+static const struct mtk_pin_field_calc mt8365_pin_pupd_range[] = {
+	/* KeyPad */
+	PIN_FIELD_PUPD(22, 0x70, 2),
+	PIN_FIELD_PUPD(23, 0x70, 5),
+	PIN_FIELD_PUPD(24, 0x70, 8),
+	PIN_FIELD_PUPD(25, 0x70, 11),
+	/* MSDC2 */
+	PIN_FIELD_PUPD(80, 0x70, 14),
+	PIN_FIELD_PUPD(81, 0x70, 17),
+	PIN_FIELD_PUPD(82, 0x70, 20),
+	PIN_FIELD_PUPD(83, 0x70, 23),
+	PIN_FIELD_PUPD(84, 0x70, 26),
+	PIN_FIELD_PUPD(85, 0x70, 29),
+	PIN_FIELD_PUPD(86, 0x80, 2),
+	/* MSDC1 */
+	PIN_FIELD_PUPD(87, 0x80, 5),
+	PIN_FIELD_PUPD(88, 0x80, 8),
+	PIN_FIELD_PUPD(89, 0x80, 11),
+	PIN_FIELD_PUPD(90, 0x80, 14),
+	PIN_FIELD_PUPD(91, 0x80, 17),
+	PIN_FIELD_PUPD(92, 0x80, 20),
+	/* MSDC0 */
+	PIN_FIELD_PUPD(93, 0x80, 23),
+	PIN_FIELD_PUPD(94, 0x80, 26),
+	PIN_FIELD_PUPD(95, 0x80, 29),
+	PIN_FIELD_PUPD(96, 0x90, 2),
+	PIN_FIELD_PUPD(97, 0x90, 5),
+	PIN_FIELD_PUPD(98, 0x90, 8),
+	PIN_FIELD_PUPD(99, 0x90, 11),
+	PIN_FIELD_PUPD(100, 0x90, 14),
+	PIN_FIELD_PUPD(101, 0x90, 17),
+	PIN_FIELD_PUPD(102, 0x90, 20),
+	PIN_FIELD_PUPD(103, 0x90, 23),
+	PIN_FIELD_PUPD(104, 0x90, 26),
+	/* NFI */
+	PIN_FIELD_PUPD(105, 0x90, 29),
+	PIN_FIELD_PUPD(106, 0xf0, 2),
+	PIN_FIELD_PUPD(107, 0xf0, 5),
+	PIN_FIELD_PUPD(108, 0xf0, 8),
+	PIN_FIELD_PUPD(109, 0xf0, 11),
+};
+
+static const struct mtk_pin_field_calc mt8365_pin_r1_range[] = {
+	/* KeyPad */
+	PIN_FIELD_PUPD(22, 0x70, 1),
+	PIN_FIELD_PUPD(23, 0x70, 4),
+	PIN_FIELD_PUPD(24, 0x70, 7),
+	PIN_FIELD_PUPD(25, 0x70, 10),
+	/* MSDC2 */
+	PIN_FIELD_PUPD(80, 0x70, 13),
+	PIN_FIELD_PUPD(81, 0x70, 16),
+	PIN_FIELD_PUPD(82, 0x70, 19),
+	PIN_FIELD_PUPD(83, 0x70, 22),
+	PIN_FIELD_PUPD(84, 0x70, 25),
+	PIN_FIELD_PUPD(85, 0x70, 28),
+	PIN_FIELD_PUPD(86, 0x80, 1),
+	/* MSDC1 */
+	PIN_FIELD_PUPD(87, 0x80, 4),
+	PIN_FIELD_PUPD(88, 0x80, 7),
+	PIN_FIELD_PUPD(89, 0x80, 10),
+	PIN_FIELD_PUPD(90, 0x80, 13),
+	PIN_FIELD_PUPD(91, 0x80, 16),
+	PIN_FIELD_PUPD(92, 0x80, 19),
+	/* MSDC0 */
+	PIN_FIELD_PUPD(93, 0x80, 22),
+	PIN_FIELD_PUPD(94, 0x80, 25),
+	PIN_FIELD_PUPD(95, 0x80, 28),
+	PIN_FIELD_PUPD(96, 0x90, 1),
+	PIN_FIELD_PUPD(97, 0x90, 4),
+	PIN_FIELD_PUPD(98, 0x90, 7),
+	PIN_FIELD_PUPD(99, 0x90, 10),
+	PIN_FIELD_PUPD(100, 0x90, 13),
+	PIN_FIELD_PUPD(101, 0x90, 16),
+	PIN_FIELD_PUPD(102, 0x90, 19),
+	PIN_FIELD_PUPD(103, 0x90, 22),
+	PIN_FIELD_PUPD(104, 0x90, 25),
+	/* N */
+	PIN_FIELD_PUPD(105, 0x90, 28),
+	PIN_FIELD_PUPD(106, 0xf0, 1),
+	PIN_FIELD_PUPD(107, 0xf0, 4),
+	PIN_FIELD_PUPD(108, 0xf0, 7),
+	PIN_FIELD_PUPD(109, 0xf0, 10),
+};
+
+static const struct mtk_pin_field_calc mt8365_pin_r0_range[] = {
+	/* KeyPad */
+	PIN_FIELD_PUPD(22, 0x70, 0),
+	PIN_FIELD_PUPD(23, 0x70, 3),
+	PIN_FIELD_PUPD(24, 0x70, 6),
+	PIN_FIELD_PUPD(25, 0x70, 9),
+	/* MSDC2 */
+	PIN_FIELD_PUPD(80, 0x70, 12),
+	PIN_FIELD_PUPD(81, 0x70, 15),
+	PIN_FIELD_PUPD(82, 0x70, 18),
+	PIN_FIELD_PUPD(83, 0x70, 21),
+	PIN_FIELD_PUPD(84, 0x70, 24),
+	PIN_FIELD_PUPD(85, 0x70, 27),
+	PIN_FIELD_PUPD(86, 0x80, 0),
+	/* MSDC1 */
+	PIN_FIELD_PUPD(87, 0x80, 3),
+	PIN_FIELD_PUPD(88, 0x80, 6),
+	PIN_FIELD_PUPD(89, 0x80, 9),
+	PIN_FIELD_PUPD(90, 0x80, 12),
+	PIN_FIELD_PUPD(91, 0x80, 15),
+	PIN_FIELD_PUPD(92, 0x80, 18),
+	/* MSDC0 */
+	PIN_FIELD_PUPD(93, 0x80, 21),
+	PIN_FIELD_PUPD(94, 0x80, 24),
+	PIN_FIELD_PUPD(95, 0x80, 27),
+	PIN_FIELD_PUPD(96, 0x90, 0),
+	PIN_FIELD_PUPD(97, 0x90, 3),
+	PIN_FIELD_PUPD(98, 0x90, 6),
+	PIN_FIELD_PUPD(99, 0x90, 9),
+	PIN_FIELD_PUPD(100, 0x90, 12),
+	PIN_FIELD_PUPD(101, 0x90, 15),
+	PIN_FIELD_PUPD(102, 0x90, 18),
+	PIN_FIELD_PUPD(103, 0x90, 21),
+	PIN_FIELD_PUPD(104, 0x90, 24),
+	/* NFI */
+	PIN_FIELD_PUPD(105, 0x90, 27),
+	PIN_FIELD_PUPD(106, 0xf0, 0),
+	PIN_FIELD_PUPD(107, 0xf0, 3),
+	PIN_FIELD_PUPD(108, 0xf0, 6),
+	PIN_FIELD_PUPD(109, 0xf0, 9),
+};
+
 static const struct mtk_pin_reg_calc mt8365_reg_cals[] = {
 	[PINCTRL_PIN_REG_MODE]    = MTK_RANGE(mt8365_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR]     = MTK_RANGE(mt8365_pin_dir_range),
@@ -233,6 +362,9 @@ static const struct mtk_pin_reg_calc mt8365_reg_cals[] = {
 	[PINCTRL_PIN_REG_PULLSEL] = MTK_RANGE(mt8365_pin_pullsel_range),
 	[PINCTRL_PIN_REG_PULLEN]  = MTK_RANGE(mt8365_pin_pullen_range),
 	[PINCTRL_PIN_REG_DRV]     = MTK_RANGE(mt8365_pin_drv_range),
+	[PINCTRL_PIN_REG_PUPD]    = MTK_RANGE(mt8365_pin_pupd_range),
+	[PINCTRL_PIN_REG_R1]      = MTK_RANGE(mt8365_pin_r1_range),
+	[PINCTRL_PIN_REG_R0]      = MTK_RANGE(mt8365_pin_r0_range),
 };
 
 static const struct mtk_pin_desc mt8365_pins[] = {

---
base-commit: d503633a36767d756c7de28305cf0de79440cbc0
change-id: 20260113-pinctrl-mtk-mt8365-pupd-registers-19e4aa3ee94e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

