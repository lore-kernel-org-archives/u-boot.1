Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BBAFF6E9B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 23:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A0C8423E;
	Wed, 18 Mar 2026 00:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wNkinXBO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AB15841B9; Wed, 18 Mar 2026 00:26:31 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7318841B9
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-464ba2bb3aeso266661b6e.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773789987; x=1774394787;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r7w83Xfd5gAav6OXWjC/3Kj0Jgtpm0CWf9fYcU8RUCw=;
 b=wNkinXBOd/Ki6XsxfHVt5wQbfJ8jD9E/RX1XB6prk+wgFHsllspygdbnpCRdaqiIWC
 BrDSyGAfdPPISVIW7W1m9f1+KDp2kbwq5X8A/DEITdf/ouT0esxy1uRGQ/pBCP9ymuY5
 p8HmHYFSetbEGqe2hGCyxsJVSDfj91sRfbPWRJ8xZSXaL4C2knclJZOVrCAFruG3mIn1
 Y3eLW8UyJrlnzCA7g/7s4yNM1hWhDuOb+XEo2ipaJRwyXl0DsXFq7sbRA4CHX2WAgxtB
 LAHVcwyZSRS4d05SPKZ6WPlpP/YmBVX7e4RPIVho60dvbpVs/NzSpFkK/as3as1teJY1
 zxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789987; x=1774394787;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r7w83Xfd5gAav6OXWjC/3Kj0Jgtpm0CWf9fYcU8RUCw=;
 b=KwU0D+BuJLP6iwAyVOHXNovWjFq6V9AUhoaSzW5ooP4ksrkT9y7t62bugHBVv1/ytk
 cgsTBZ8b37Nv7jB+m7bU6+3p2whbRDzpMsWLxfg31prw0N2npkLxOWw4Nz5Fw6o14anc
 eOBqNmoMi1XF9mqcwK8lASLek42ukaQ7IFp6IthrXFqdtbGnfcVWsgh40GueMfOKSBK1
 KOFzf3ELZaUq44UbQ8X3BRBpZMzt0ySJUwnpZTnA3bq+JWl8jVj/+2Z+UKpv9Sbcjf8Z
 0OuMRPDntQv3gN0IIrYG/U8lMEXHOh8uODMJ+AxRDZWYbwwVy9eUvRcPsVFHp2V7g32I
 qkqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV21qCfzwrpEpRQHNEMrcaaOCxJPee5+kV4k1IxM1Ma77kFhOomvitUjGLa97dcvOjU8kBNGVI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxb04/YftQH2kfownHiBbN3hsii1I6OWUwCnnpRRrEb5ILN9bxd
 pfZ0+LIxqUaCxtpbds7XZeSD4P/EQr1aaCtda7/+FpVsLTzDpJ6t8ybVPfC+EVVyBc4=
X-Gm-Gg: ATEYQzyOXt888K2NyHly78nAZjs/07FT/KC6A2zq+YZznmlku4mcwRpEiREbns0J3Xy
 Yz7F7bfEJrZgy6aeMOeK1Uy86Yz0iiFnz00mZaGVuh6a0IzRY3eP4zRDdLJC8Yl8ELgilqtLmmF
 UMPrpc/j7uzc7rsxpL3ONymomyOw0J39oUHjoOpkktFqYyM3zt16+emwiuNIjWZAtMFEJouuNa2
 +MMRdq3dSfLZipkK2OxuhaDL3/xbQBz27tFRNEMl+XW4/+py3f4AFhW46gGNmo6iYbd/vdeDSUw
 NpibNxY45HzxiOtlHwyyd3dDO7chDXj/XczIgk7dUHIK2lk8vLPvogrovbqbmPLd/5sDNKyckJ0
 omhiH7seD4RFdj/DaXUg+QzuqvCsDa+iL9IaBiTGNyGhNQkuJHHbCrfAlibB2zoCYFE/UoDk6wj
 1YICYe2RYhxqLmn+9PpKc3WPG9Qg==
X-Received: by 2002:a05:6808:1a17:b0:44d:9f05:7159 with SMTP id
 5614622812f47-467a80c0652mr3095892b6e.29.1773789987134; 
 Tue, 17 Mar 2026 16:26:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2828aa7sm1148309fac.1.2026.03.17.16.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:26:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Mar 2026 18:23:14 -0500
Subject: [PATCH v3 01/16] clk: mediatek: mt7622: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-clk-mtk-unify-mux-parents-v3-1-a4760f5b0a80@baylibre.com>
References: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
In-Reply-To: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14176;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=saUfEiVKc/mgoI57Vl9/HVmza9UktEFp+tmBy7gYeOk=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpueJ0kmiIs8OHbInJakOsfS1Av0lUAgmkYDnY8
 /R7u9ia++KJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabnidBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ai0gH+wWjWzE8vMjZ9COxqzv8Xf4nqFLUC5iyGRCkEAv
 gFWF+HeZv2f9i4DtG0yyHcMM5BPoVDwgQmXg1VJ+HHN7P3FVFAuuxsa9Na80Esp1UERBb6jhegm
 gevGKkgw+EqMfgtjZ1Hi5wpxlVSM7jB1ePZSjiVz0oIxd6Q9Jm02odxxT6g5RK1gbyeSbLzO7hX
 aZa1cJALOzOB8GELo1KAZr+jsXPO9R20MEaaOcw8ghK68a1R+vlFpfmASxsdjFCWGXmTWzUs/LR
 jcAkOfaA676PQBzKKNbKEt6mcxnvzfYBL7MQhl9c/PiH3tsJRJjl8G1miKDBzsgj4fTuP+ULLgB
 EJqE=
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

Convert all parent clock arrays to use struct mtk_parent. This will
allow us to simplify core code later by having only one possible data
type for mux parent arrays.

Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 359 +++++++++++++++++++-------------------
 1 file changed, 178 insertions(+), 181 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 44d2836710e..8a7d446ad79 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -159,231 +159,231 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR0(CLK_TOP_ETH_500M, CLK_APMIXED_ETH1PLL, 1, 1),
 };
 
-static const int axi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL_D7
-};
-
-static const int mem_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_DMPLL
-};
-
-static const int ddrphycfg_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8
-};
-
-static const int eth_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	-1,
-	CLK_TOP_UNIVPLL_D7
-};
-
-static const int pwm_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D4
-};
-
-static const int f10m_ref_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL4_D16
+static const struct mtk_parent axi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+};
+
+static const struct mtk_parent mem_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_DMPLL),
+};
+
+static const struct mtk_parent ddrphycfg_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+};
+
+static const struct mtk_parent eth_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	VOID_PARENT,
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
 };
-
-static const int nfi_infra_parents[] = {
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D8,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_SYSPLL1_D4
+
+static const struct mtk_parent pwm_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+};
+
+static const struct mtk_parent f10m_ref_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D16),
+};
+
+static const struct mtk_parent nfi_infra_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 };
 
-static const int flash_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL_D80_D4,
-	CLK_TOP_SYSPLL2_D8,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D4
+static const struct mtk_parent flash_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D80_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
-static const int uart_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D8
+static const struct mtk_parent uart_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
-static const int spi0_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_XTAL
+static const struct mtk_parent spi0_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int spi1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_XTAL
+static const struct mtk_parent spi1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int msdc30_0_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D16,
-	CLK_TOP_UNIV48M
+static const struct mtk_parent msdc30_0_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
+	TOP_PARENT(CLK_TOP_UNIV48M),
 };
 
-static const int a1sys_hp_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_AUD1PLL,
-	CLK_TOP_AUD2PLL,
-	CLK_XTAL
+static const struct mtk_parent a1sys_hp_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_AUD1PLL),
+	TOP_PARENT(CLK_TOP_AUD2PLL),
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int intdir_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL_D2,
-	CLK_TOP_SGMIIPLL
+static const struct mtk_parent intdir_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
+	TOP_PARENT(CLK_TOP_SGMIIPLL),
 };
 
-static const int aud_intbus_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_SYSPLL3_D2
+static const struct mtk_parent aud_intbus_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
 };
 
-static const int pmicspi_parents[] = {
-	CLK_XTAL,
-	-1,
-	-1,
-	-1,
-	-1,
-	CLK_TOP_UNIVPLL2_D16
+static const struct mtk_parent pmicspi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	VOID_PARENT,
+	VOID_PARENT,
+	VOID_PARENT,
+	VOID_PARENT,
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
 };
 
-static const int atb_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5
+static const struct mtk_parent atb_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 };
 
-static const int audio_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_TOP_UNIVPLL1_D16
+static const struct mtk_parent audio_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D16),
 };
 
-static const int usb20_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_XTAL
+static const struct mtk_parent usb20_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
 };
 
-static const int aud1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_AUD1PLL
+static const struct mtk_parent aud1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_AUD1PLL),
 };
 
-static const int asm_l_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_UNIVPLL2_D4
+static const struct mtk_parent asm_l_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
-static const int apll1_ck_parents[] = {
-	CLK_TOP_AUD1_SEL,
-	CLK_TOP_AUD2_SEL
+static const struct mtk_parent apll1_ck_parents[] = {
+	TOP_PARENT(CLK_TOP_AUD1_SEL),
+	TOP_PARENT(CLK_TOP_AUD2_SEL),
 };
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_GATE(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
-	MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
-	MUX_GATE(CLK_TOP_ETH_SEL, eth_parents, 0x40, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_ETH_SEL, eth_parents, 0x40, 24, 3, 31),
 
 	/* CLK_CFG_1 */
-	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
-	MUX_GATE(CLK_TOP_F10M_REF_SEL, f10m_ref_parents, 0x50, 8, 1, 15),
-	MUX_GATE(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
-	MUX_GATE(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_F10M_REF_SEL, f10m_ref_parents, 0x50, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
+	MUX_GATE_MIXED(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
 
 	/* CLK_CFG_2 */
-	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
-	MUX_GATE(CLK_TOP_SPI0_SEL, spi0_parents, 0x60, 8, 3, 15),
-	MUX_GATE(CLK_TOP_SPI1_SEL, spi1_parents, 0x60, 16, 3, 23),
-	MUX_GATE(CLK_TOP_MSDC50_0_SEL, uart_parents, 0x60, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_SPI0_SEL, spi0_parents, 0x60, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_SPI1_SEL, spi1_parents, 0x60, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_SEL, uart_parents, 0x60, 24, 3, 31),
 
 	/* CLK_CFG_3 */
-	MUX_GATE(CLK_TOP_MSDC30_0_SEL, msdc30_0_parents, 0x70, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MSDC30_1_SEL, msdc30_0_parents, 0x70, 8, 3, 15),
-	MUX_GATE(CLK_TOP_A1SYS_HP_SEL, a1sys_hp_parents, 0x70, 16, 3, 23),
-	MUX_GATE(CLK_TOP_A2SYS_HP_SEL, a1sys_hp_parents, 0x70, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_0_SEL, msdc30_0_parents, 0x70, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_1_SEL, msdc30_0_parents, 0x70, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_A1SYS_HP_SEL, a1sys_hp_parents, 0x70, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_A2SYS_HP_SEL, a1sys_hp_parents, 0x70, 24, 3, 31),
 
 	/* CLK_CFG_4 */
-	MUX_GATE(CLK_TOP_INTDIR_SEL, intdir_parents, 0x80, 0, 2, 7),
-	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
-	MUX_GATE(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
-	MUX_GATE(CLK_TOP_SCP_SEL, ddrphycfg_parents, 0x80, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_INTDIR_SEL, intdir_parents, 0x80, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_SCP_SEL, ddrphycfg_parents, 0x80, 24, 2, 31),
 
 	/* CLK_CFG_5 */
-	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
-	MUX_GATE_FLAGS(CLK_TOP_HIF_SEL, eth_parents, 0x90, 8, 3, 15,
-		       CLK_MUX_DOMAIN_SCPSYS),
-	MUX_GATE(CLK_TOP_AUDIO_SEL, audio_parents, 0x90, 16, 2, 23),
-	MUX_GATE(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
+	MUX_GATE_MIXED(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
+	MUX_GATE_MIXED_FLAGS(CLK_TOP_HIF_SEL, eth_parents, 0x90, 8, 3, 15,
+			     CLK_MUX_DOMAIN_SCPSYS),
+	MUX_GATE_MIXED(CLK_TOP_AUDIO_SEL, audio_parents, 0x90, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
 
 	/* CLK_CFG_6 */
-	MUX_GATE(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
-	MUX_GATE(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
-	MUX_GATE(CLK_TOP_IRRX_SEL, f10m_ref_parents, 0xA0, 16, 1, 23),
-	MUX_GATE(CLK_TOP_IRTX_SEL, f10m_ref_parents, 0xA0, 24, 1, 31),
+	MUX_GATE_MIXED(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_IRRX_SEL, f10m_ref_parents, 0xA0, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_IRTX_SEL, f10m_ref_parents, 0xA0, 24, 1, 31),
 
 	/* CLK_CFG_7 */
-	MUX_GATE(CLK_TOP_ASM_L_SEL, asm_l_parents, 0xB0, 0, 2, 7),
-	MUX_GATE(CLK_TOP_ASM_M_SEL, asm_l_parents, 0xB0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_ASM_H_SEL, asm_l_parents, 0xB0, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_ASM_L_SEL, asm_l_parents, 0xB0, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_ASM_M_SEL, asm_l_parents, 0xB0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_ASM_H_SEL, asm_l_parents, 0xB0, 16, 2, 23),
 
 	/* CLK_AUDDIV_0 */
-	MUX(CLK_TOP_APLL1_SEL, apll1_ck_parents, 0x120, 6, 1),
-	MUX(CLK_TOP_APLL2_SEL, apll1_ck_parents, 0x120, 7, 1),
-	MUX(CLK_TOP_I2S0_MCK_SEL, apll1_ck_parents, 0x120, 8, 1),
-	MUX(CLK_TOP_I2S1_MCK_SEL, apll1_ck_parents, 0x120, 9, 1),
-	MUX(CLK_TOP_I2S2_MCK_SEL, apll1_ck_parents, 0x120, 10, 1),
-	MUX(CLK_TOP_I2S3_MCK_SEL, apll1_ck_parents, 0x120, 161, 1),
+	MUX_MIXED(CLK_TOP_APLL1_SEL, apll1_ck_parents, 0x120, 6, 1),
+	MUX_MIXED(CLK_TOP_APLL2_SEL, apll1_ck_parents, 0x120, 7, 1),
+	MUX_MIXED(CLK_TOP_I2S0_MCK_SEL, apll1_ck_parents, 0x120, 8, 1),
+	MUX_MIXED(CLK_TOP_I2S1_MCK_SEL, apll1_ck_parents, 0x120, 9, 1),
+	MUX_MIXED(CLK_TOP_I2S2_MCK_SEL, apll1_ck_parents, 0x120, 10, 1),
+	MUX_MIXED(CLK_TOP_I2S3_MCK_SEL, apll1_ck_parents, 0x120, 161, 1),
 };
 
 /* infracfg */
@@ -423,16 +423,13 @@ static const struct mtk_gate infra_cgs[] = {
 };
 
 /* pericfg */
-static const int peribus_ck_parents[] = {
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYSPLL1_D4,
+static const struct mtk_parent peribus_ck_parents[] = {
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 };
 
-#define PERI_MUX(_id, _parents, _reg, _shift, _width) \
-	MUX_FLAGS(_id, _parents, _reg, _shift, _width, CLK_PARENT_TOPCKGEN)
-
 static const struct mtk_composite peri_muxes[] = {
-	PERI_MUX(CLK_PERIBUS_SEL, peribus_ck_parents, 0x05c, 0, 1),
+	MUX_MIXED(CLK_PERIBUS_SEL, peribus_ck_parents, 0x05c, 0, 1),
 };
 
 static const struct mtk_gate_regs peri0_cg_regs = {

-- 
2.43.0

