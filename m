Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7EAEEC2AD
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 23:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF59B83E40;
	Tue, 24 Feb 2026 00:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QVjo3JNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C6C83BC9; Tue, 24 Feb 2026 00:22:55 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F5EB83981
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 00:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4b9c839b1so1973004a34.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771888972; x=1772493772;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HJ+H6B3gqhbFyw3molCJSAF1G84TTHh/bET8PcH5yls=;
 b=QVjo3JNV6TMkoVoNzLf8rZ1RvK8xUHfxhDlzuLi4QBp2rEoQRBgAJplaqYuU3NYrUI
 ryt2ZA1b1DjTp2VG22VrA3Jzj9zZ9glGxVyU0df5AkQx6SKgSDQMgOaIv/6sXuzlBcvO
 HrJOSLabJOFX0kXO0AAmpIrKmjNaoXQoFrDpjMmsCuaITIDEUqHYlcYhR4KrP5pmHOoJ
 66SCc6atvBqFI1+MpwKJHmN+Q+vY+9Ig/3qLgxksBaKynV1Z24S8kKsjEFryWPspC0TL
 RmKyqh5CxFGYZ5brSOJXN2Lda84gqpTfxMU4xkvA0vP/1+3M3QmLxZVUUvBArVVNBBlB
 yeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771888972; x=1772493772;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HJ+H6B3gqhbFyw3molCJSAF1G84TTHh/bET8PcH5yls=;
 b=Trw04oEMs7+/g66yzxuvIQFo5F60vGoXBzKwRxCXPGEvVh6wCr3ckSEpLlxT8Ie4R1
 WvWU8LxNyLMtUTOdobbHd0lS7zb0tY1yoJz9rFnItoPAnRT37fctJjnzK8iXAIaKhiry
 EH/bwFZ6kZmdIZhFxEe9ZBpMotwh3AAt+PmClvsns+OSYWujSzB9qVvmKVmpXmhYpHTk
 Nc8GtE4bUU6AvszTBhxL/JLcmOSklh1n50LRxYt9XongNROR3vxXg4vHhlL70KSOB36Z
 FRqGTILH/kJ9YCPErteePwK4GwuHoAtOug3H1t7R4h6+3CI/ABwEGhnhhCxbovkadskf
 TGqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4tO7jYXYJfJBrgwuDP/QoC3uLla66s2FzIpMevuWCd5hfgQcuEkWe2xENDNDg0+g84WamMmY=@lists.denx.de
X-Gm-Message-State: AOJu0YxhhcwyKNsMElVrgAIkg6uIW7CkGF07/+Hb8IO7elDLcOU0c3pW
 zPMf0RSQSEnJM81u+aA5LOJiX4+D2RKKFsVSpdLxYa4dfay4kjUGcSs000jAPB7el3g=
X-Gm-Gg: AZuq6aLm+lg2RacRnF8VEhIbO+K1wY6k7VWzG1ISoN/jKOY6Dno1tKcPEJlBBCxsUWD
 XK0hlObLcWZ/kXs7Zj+b+658TsojP9oH18zmK+b5HJQeckI7bsSzSB3C3YG/zCYrjpobqc0nrqq
 zbreVxdJDwadhCo55o1H/cXH35OEHvG/RALisIeUBV0ul0FfolMgV+kKEl7zu3NET8GRdoO9xZY
 DpqLX3tbqa9r8TQGdOiKRrhMt+yr1gBdSKhNJxaddh36TL33VnneVslaHklgJLVIRChCb/h/WZz
 zQt5Zu2Haw+uwqVA/Mg4lCHID7YtpNBk76N2AR+M1NeWSolob69YqdHbIWUHt/IA7o1uHOq1qSZ
 B2F0gLsckX9F1XkfWBVpOdAarvkqlkLoEWscbBbYITcErwvs+SPqsrCmwmdMW7zfgE6y4LOZrqm
 7gSZV/G8Xg+CVNyacQyyNbLwJ+tx/L
X-Received: by 2002:a05:6830:6690:b0:7ab:e111:1a57 with SMTP id
 46e09a7af769-7d52c2e894amr5269348a34.31.1771888971994; 
 Mon, 23 Feb 2026 15:22:51 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cb87:475c:5c04:ac92])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78736sm8911230a34.5.2026.02.23.15.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 15:22:51 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Feb 2026 17:21:54 -0600
Subject: [PATCH 2/7] clk: mediatek: rename CLK_DOMAIN_SCPSYS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-2-a7dc97bc2660@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4065; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=PC5TFllXuYWWEJNVhEL03ga7IB+kB9snmx03SslWKh0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpnOEh/cqlZKrkVJR+eP9hRnD6NOVjpF5+a99Mj
 KJXbWOvbeGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZzhIRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AePIH/3L/X0ERy+jjDsxAxeZC6euS4R7rb21kIxfcD2E
 CVpgvfDtFG+IPOjLMvoeF3HyEmiTxOSbqPUMbx2bzkLcjqxoRwJaR5LMpJwNEPMlDoSysea+XRe
 5yQllx7jh1NKKr9BVHl1WHw9tbC4dMm9xuA5v6m/BtBUSR22gj7deuiHP6W5BdXhFLuoaD2ARJp
 6o+m2A/FVU96Mtdxc8R8xXTYkoNdQX9KAo4FuCDu101l/Om3zRThvXqV9Xtz5GAN3pTb6n7nsEB
 pyD8udqtxOX9bMsf5+5Lrt4BZ3OUZenyBpGtDmVQSJq6Xht7X6tfCDLbXrboFRCJvT7hj28ULqf
 rGb0=
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

Rename CLK_DOMAIN_SCPSYS to CLK_MUX_DOMAIN_SCPSYS to make it more clear
that this flag only applies to MUX clocks and not other clock types.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 2 +-
 drivers/clk/mediatek/clk-mt7623.c | 6 +++---
 drivers/clk/mediatek/clk-mt7629.c | 2 +-
 drivers/clk/mediatek/clk-mtk.c    | 2 +-
 drivers/clk/mediatek/clk-mtk.h    | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 108c0dcd14e..77f3a9fc3d3 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -362,7 +362,7 @@ static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_5 */
 	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
 	MUX_GATE_FLAGS(CLK_TOP_HIF_SEL, eth_parents, 0x90, 8, 3, 15,
-		       CLK_DOMAIN_SCPSYS),
+		       CLK_MUX_DOMAIN_SCPSYS),
 	MUX_GATE(CLK_TOP_AUDIO_SEL, audio_parents, 0x90, 16, 2, 23),
 	MUX_GATE(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
 
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 70570644ca4..d62b9651fa6 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -701,12 +701,12 @@ static const struct mtk_composite top_muxes[] = {
 	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
 	MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
 	MUX_GATE_FLAGS(CLK_TOP_MM_SEL, mm_parents, 0x40, 24, 3, 31,
-		       CLK_DOMAIN_SCPSYS),
+		       CLK_MUX_DOMAIN_SCPSYS),
 
 	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
 	MUX_GATE(CLK_TOP_VDEC_SEL, vdec_parents, 0x50, 8, 4, 15),
 	MUX_GATE_FLAGS(CLK_TOP_MFG_SEL, mfg_parents, 0x50, 16, 3, 23,
-		       CLK_DOMAIN_SCPSYS),
+		       CLK_MUX_DOMAIN_SCPSYS),
 	MUX_GATE(CLK_TOP_CAMTG_SEL, camtg_parents, 0x50, 24, 3, 31),
 
 	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
@@ -745,7 +745,7 @@ static const struct mtk_composite top_muxes[] = {
 	MUX_GATE(CLK_TOP_ASM_H_SEL, asm_parents, 0xD0, 0, 2, 7),
 	MUX_GATE(CLK_TOP_MS_CARD_SEL, ms_card_parents, 0xD0, 16, 2, 23),
 	MUX_GATE_FLAGS(CLK_TOP_ETHIF_SEL, ethif_parents, 0xD0, 24, 3, 31,
-		       CLK_DOMAIN_SCPSYS),
+		       CLK_MUX_DOMAIN_SCPSYS),
 
 	MUX_GATE(CLK_TOP_HDMIRX26_24_SEL, hdmirx_parents, 0xE0, 0, 1, 7),
 	MUX_GATE(CLK_TOP_MSDC30_3_SEL, msdc30_parents, 0xE0, 8, 3, 15),
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 7fe62bdcea5..85011f5327b 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -397,7 +397,7 @@ static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_5 */
 	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
 	MUX_GATE_FLAGS(CLK_TOP_HIF_SEL, hif_parents, 0x90, 8, 3, 15,
-		       CLK_DOMAIN_SCPSYS),
+		       CLK_MUX_DOMAIN_SCPSYS),
 	MUX_GATE(CLK_TOP_SATA_SEL, sata_parents, 0x90, 16, 1, 23),
 	MUX_GATE(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
 
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 0f29627665b..b604bb274c1 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -788,7 +788,7 @@ static int mtk_clk_mux_enable(struct clk *clk)
 		writel(val, priv->base + mux->gate_reg);
 	}
 
-	if (mux->flags & CLK_DOMAIN_SCPSYS) {
+	if (mux->flags & CLK_MUX_DOMAIN_SCPSYS) {
 		/* enable scpsys clock off control */
 		writel(SCP_ARMCK_OFF_EN, priv->base + CLK_SCP_CFG0);
 		writel(SCP_AXICK_DCM_DIS_EN | SCP_AXICK_26M_SEL_EN,
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 806ec2ec20a..d33e5cd2480 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -22,7 +22,7 @@
 
 #define CLK_PLL_HAVE_RST_BAR		BIT(0)
 
-#define CLK_DOMAIN_SCPSYS		BIT(0)
+#define CLK_MUX_DOMAIN_SCPSYS		BIT(0)
 #define CLK_MUX_SETCLR_UPD		BIT(1)
 
 #define CLK_GATE_SETCLR			BIT(0)

-- 
2.43.0

