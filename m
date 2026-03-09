Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B049FCA192
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 21:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4875D83FC0;
	Mon,  9 Mar 2026 22:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yHr0sFFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41DA883FA3; Mon,  9 Mar 2026 22:29:23 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4EDA83A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-41708f6c3feso1381935fac.3
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773091759; x=1773696559;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dm5B+OoEm4wvnZuQcxNZ1ZjT5DMr55FX76jlnlM0ltM=;
 b=yHr0sFFOl/+1nMhZt+aADr703SYQc2YFbHwzyA3+g8icd1m1OmxirmG05BeDrd+0fQ
 uKffivPYBk9I4v6XjWoGgrvdf0aYdemLF3OxWyHejHNB1qMcdofuV+Jw4JQGjjNMvdPY
 BA+ABkOFfqrloQZYHUQ1WQCSmJaJ9WZfb83LMUvHyRl5hKbm/Y6wTfeqzX8A5QXpWtNI
 NPKmJY8BrcdRUo3jFA77/hrBVTcqlk5fnmxzrGEf1i++mxpzF3lctkpvD/q0ihp5OdQ/
 s26H8/YBZst70QUESmVjXI+Vyx4tQeKHFfDW+o50ZyuVBlOhbY/YoPbba/Em6XKwZXyt
 FNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091759; x=1773696559;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Dm5B+OoEm4wvnZuQcxNZ1ZjT5DMr55FX76jlnlM0ltM=;
 b=Sc4dIV/hnQyzctBOvlG/oxUf8hfDfQ6AmqBHSba1BMjXZWXp3IcCU8cyhKBt1w9bMQ
 1JU5hrNeXi4Gz2/klAw0/IFPByVREajvaJ7+bIkH9BvP7ECdlhO0d3YEjl9EyTy09OKo
 1p6wom3Bu4Td76+rDOwjtIrcCOrjTfkfE4If359Rkx5oxS/4PBbCbfgFgYmBoJAynvCd
 cGjSRHHd2vVMmqcDliVxNrAhevBbLGPxoLK5Fn6EfrTXohiEwEg7OtIanH3Abd524AWn
 JXN0LXXDpiLD/1oads1O9kAYalcpBFwCjWxnZhPzkZNfMdXNBKneeGLNl7bj/oAkTgpF
 E3og==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8S3UOz37TnCsu4iUzMS/OGreaKT4ZjznV3/bAGUA1RBnN9Sw0SIw+E9kZ7tkkCbjOEqFu4fY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3G65IaA0prQyOsS2iW3P7t5J3oAFaEgLHF4apB7Uvh0qKoMgv
 WCUG1eUkJU7edCJjtbQsGVoBb4FyUT/3JtS/zHyUSa19UmgTxqMvuVHUjc6QeSqKYZE=
X-Gm-Gg: ATEYQzyA0IWIQ/Ki9+XTmcgIXbSEFGHEgffMztk2i/11s3L/Tuf+8UZo5jSDDGulIxN
 AJgkSlMKJ5d0qv82mMf8ANHCSqo9vmkXc/maN47Qo1bID7T/LuuuEp3ciK1VzkOydCxjTqQSZpe
 Q+elGgvNrRNHt5JXG6WH1OUFk+13P2dAFvKPbZzta6QKubXPBjfD3L4YLPiypoZjR+YEkeZdM5T
 kZw5WITSKG7zAx9J+fiwz6IzbaiY58Xw23bfhJnZ/5eh3mvrzGRQicczektmZUFIfD8PV9oCoG0
 gFQ8ebZgsffAFYLQqaQ4CzUxhj1vM2d+2h7HYBG2T3N70yytzDCI9OAt/NDS6igalY3M4e9ADEt
 lNgkz1b8nE/Xw/nd7dNV2A96okLde/yeRs4odipdLNTyQjUlCgwfVax6fewclJl+eCM261/Dz+7
 Vv0dWhnQmZA0SOt+L3nBFzgvMynA==
X-Received: by 2002:a05:6871:7815:b0:409:7e70:299f with SMTP id
 586e51a60fabf-416e3e92452mr7293589fac.9.1773091759466; 
 Mon, 09 Mar 2026 14:29:19 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:77:c35f:9c1b:c75f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756b47f0asm826221fac.8.2026.03.09.14.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 14:29:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Mar 2026 16:27:38 -0500
Subject: [PATCH v2 03/13] clk: mediatek: mt7987: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-clk-mtk-unify-mux-parents-v2-3-b084ea74b99d@baylibre.com>
References: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
In-Reply-To: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4557; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=eTvO262mzupBVbqqrvlIq7a0+T6S+caqJRFCXYJc2UY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBprzthx5qOfiS6/KEWaHEztY/tGpzmovzkf5Lt6
 o2JLLEVOIeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaa87YRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALXcH/28U3EiBVxWBRwntdCbCLxF8Yiut5hCRx953oRt
 0EPQypj0kvUKXxrdlRVERs6Ovj9//MWkp5fKMEdnqLGikod9W8nqpM6AjeN9anLFDzQ5Ea999O4
 WQj5DHEdqtek1hIi2qFMgQI+G6b/XhbslUyksW+rrpbNDMeUekHu5y12uenx6rSSnSxYk9sP5Rc
 VR223VUQXlgl6qOsxt+1q55KdhKiuzcPhn+vCQzYocBXhNt6cj/wW6B2E83xio5qAS3YZLwBw7B
 DOusKehv5dLx+cRjlwsdB5FJVDiM9d381p4UEGsjgEJeyKBEuUOtwLZttE8UzY+xMejwbNxZKQT
 ak0E=
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

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7987.c | 71 ++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index e7b81a512de..5ae76a2c47a 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -480,63 +480,63 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 /* INFRASYS MUX PARENTS */
 
 /* CLK_INFRA_MUX_UART0_SEL (infra_mux_uart0_sel) in infracfg */
-static const int infra_mux_uart0_parents[] = {
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_UART_SEL
+static const struct mtk_parent infra_mux_uart0_parents[] = {
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_UART_SEL),
 };
 
 /* CLK_INFRA_MUX_UART1_SEL (infra_mux_uart1_sel) in infracfg */
-static const int infra_mux_uart1_parents[] = {
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_UART_SEL
+static const struct mtk_parent infra_mux_uart1_parents[] = {
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_UART_SEL),
 };
 
 /* CLK_INFRA_MUX_UART2_SEL (infra_mux_uart2_sel) in infracfg */
-static const int infra_mux_uart2_parents[] = {
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_UART_SEL
+static const struct mtk_parent infra_mux_uart2_parents[] = {
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_UART_SEL),
 };
 
 /* CLK_INFRA_MUX_SPI0_SEL (infra_mux_spi0_sel) in infracfg */
-static const int infra_mux_spi0_parents[] = {
-	CLK_TOP_I2C_SEL,
-	CLK_TOP_SPI_SEL
+static const struct mtk_parent infra_mux_spi0_parents[] = {
+	TOP_PARENT(CLK_TOP_I2C_SEL),
+	TOP_PARENT(CLK_TOP_SPI_SEL),
 };
 
 /* CLK_INFRA_MUX_SPI1_SEL (infra_mux_spi1_sel) in infracfg */
-static const int infra_mux_spi1_parents[] = {
-	CLK_TOP_I2C_SEL,
-	CLK_TOP_SPIM_MST_SEL
+static const struct mtk_parent infra_mux_spi1_parents[] = {
+	TOP_PARENT(CLK_TOP_I2C_SEL),
+	TOP_PARENT(CLK_TOP_SPIM_MST_SEL),
 };
 
 /* CLK_INFRA_MUX_SPI2_BCK_SEL (infra_mux_spi2_bck_sel) in infracfg */
-static const int infra_mux_spi2_bck_parents[] = {
-	CLK_TOP_I2C_SEL,
-	CLK_TOP_SPI_SEL
+static const struct mtk_parent infra_mux_spi2_bck_parents[] = {
+	TOP_PARENT(CLK_TOP_I2C_SEL),
+	TOP_PARENT(CLK_TOP_SPI_SEL),
 };
 
 /* CLK_INFRA_PWM_BCK_SEL (infra_pwm_bck_sel) in infracfg */
-static const int infra_pwm_bck_parents[] = {
-	CLK_TOP_CB_RTC_32P7K,
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_SYSAXI_SEL,
-	CLK_TOP_PWM_SEL
+static const struct mtk_parent infra_pwm_bck_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_RTC_32P7K),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_SYSAXI_SEL),
+	TOP_PARENT(CLK_TOP_PWM_SEL),
 };
 
 /* CLK_INFRA_PCIE_GFMUX_TL_O_P0_SEL (infra_pcie_gfmux_tl_ck_o_p0_sel) in infracfg */
-static const int infra_pcie_gfmux_tl_ck_o_p0_parents[] = {
-	CLK_TOP_CB_RTC_32P7K,
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_PEXTP_TL_SEL
+static const struct mtk_parent infra_pcie_gfmux_tl_ck_o_p0_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_RTC_32P7K),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_PEXTP_TL_SEL),
 };
 
 /* CLK_INFRA_PCIE_GFMUX_TL_O_P1_SEL (infra_pcie_gfmux_tl_ck_o_p1_sel) in infracfg */
-static const int infra_pcie_gfmux_tl_ck_o_p1_parents[] = {
-	CLK_TOP_CB_RTC_32P7K,
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_PEXTP_TL_P1_SEL
+static const struct mtk_parent infra_pcie_gfmux_tl_ck_o_p1_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_RTC_32P7K),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_PEXTP_TL_P1_SEL),
 };
 
 #define INFRA_MUX(_id, _name, _parents, _reg, _shift, _width)                  \
@@ -545,8 +545,9 @@ static const int infra_pcie_gfmux_tl_ck_o_p1_parents[] = {
 		.mux_clr_reg = (_reg) + 0x4, .mux_set_reg = (_reg) + 0x0,      \
 		.mux_shift = (_shift), .mux_mask = BIT(_width) - 1,            \
 		.gate_shift = -1, .upd_shift = -1,                             \
-		.parent = (_parents), .num_parents = ARRAY_SIZE(_parents),     \
-		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_TOPCKGEN,             \
+		.parent_flags = (_parents),				       \
+		.num_parents = ARRAY_SIZE(_parents),			       \
+		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,		       \
 	}
 
 /* INFRA MUX */

-- 
2.43.0

