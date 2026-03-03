Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C47EB3641
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 00:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FD683F64;
	Tue,  3 Mar 2026 01:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0S1MFuuZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6908183F54; Tue,  3 Mar 2026 01:05:13 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 000F383F54
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 01:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4152698e745so102205fac.1
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772496304; x=1773101104;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bFWmVRE1D1dNR4DLo+2b2iB1CJrWRVWsjh1AtBnyn/k=;
 b=0S1MFuuZSALZdX95YTmcHFzUuOUfVkMBgfeiXWnuWj2Cqo/DXQN4gM+FtgD8qNzjKM
 7iofO818tivHU47nHELZvE7xOc2IhKrpHqdXzUQ4Y9+/ZSXQdHfQ0AbwIuM5RDrOmmpp
 HSfGw9eiELwBMokJrv+oPtM2TQuTUpJ6fOzHllTeA0MM8xcysrfIb5a/MDqSRkdGSS3+
 rXDfm/wt3D6/rJ6OBS7UP3sdI8l6vah0f+r7aLMhENHtuvQEMgmOZuoRptNsuhz0cKil
 rU017mX7oqsICns4xTcGq8YpJICIVgC4XaMEl0bGkTpRgY26AlnH8r9wqd8r54PoNoh/
 o6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496304; x=1773101104;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bFWmVRE1D1dNR4DLo+2b2iB1CJrWRVWsjh1AtBnyn/k=;
 b=baPgPIDyr6BvawCOqTJ64OAsyP5PyzDl23e8/HD1ekqkCxchyW0PVZ6fbGUt/uloOR
 vqNlMEWxITf52LQefwfwLTA82IXirWGtd8kdUrfArQUyg7zJVNxN1eBWdQVGPF0aJEIX
 PAeR/McJONrGFJbsp7Lb2W6JKxIyYVU6H0drPeg5JmFP9kMDPqVTbSPho9Kgl/IJtmij
 sMGguzx1Ymg7TWXMKnwYc9IfbBF5CxZSY93yu9WNQRvTC+hcmZkj2XmQdV/iTdenNrsC
 zKO+IIhKMEoeX0RSYmy0GcFkaHrk0FpUpu4xqX/THDPxwEZHuIna5S1pHnF6RSLdRvVM
 bEDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG0zWrnaHqlpTXhc/uzpg5Gqu4bSRsKfDLDUMR0loJOKeApOIvFE/MiL4C1pf36bpHlCuNrD4=@lists.denx.de
X-Gm-Message-State: AOJu0YxOwA1i4P5BDQfqYqySw2AfkWOUNtn71iftec+OnwAOe6FoGpox
 f7hjCT6bs5Q3KrECbr7ARde2P5+SLDH/rXXlHr5z4B9sXZD8RpBq80jGwV8ZsBlMpZdaA0ZJcmZ
 yxdrG
X-Gm-Gg: ATEYQzzzIRukQVtJHEdRpESiZpBW9GN6Lhe+prlnGstBFtUwXy+OBglw4qdpZ8NIQTp
 gIJ2C6xUy38pE4eU2/gH/AMnywDPLxcWTozjfH2z2u5Rup6gp3ElJ0ioXL3pqa9Vm9DT5jf9XX9
 sN7jpaKpz8p4FIfsp5qszsNG7zOCcc7+LtBn13U9vdO4oc7jiPe6vurdb5ISq9luaAR7Q5Xad+5
 Vc06SPYoa8pupfBf/hTunIcUjigggJLzziIvo2avL1sYapUMzhiqJXPWnHw+p04BszAx9iCTzH2
 wt7hanuK3mx7MLRbx17C3ycYd0+fkwsDOSQaJsodo2aKEIndoluJnIlx8vkCis/f0Dnza2y9jr1
 09QLaDpUsnXA4WYRZFKeJHLco3EOSWqQH0+uaqg+RRNuKJ9uCYXVooYY80kuHe4rAi46tA4ORSr
 GTIbeamhiJ2g3C4GirsVKouGead9XS
X-Received: by 2002:a05:6870:4189:b0:40e:e3f6:bc9e with SMTP id
 586e51a60fabf-41626e1df9emr6987372fac.7.1772496304562; 
 Mon, 02 Mar 2026 16:05:04 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf239e0sm13878551fac.1.2026.03.02.16.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 16:05:04 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 18:03:13 -0600
Subject: [PATCH 04/14] clk: mediatek: mt7987: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-clk-mtk-unify-mux-parents-v1-4-32f45085f4d0@baylibre.com>
References: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
In-Reply-To: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4557; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Pk6sehnp7+r+IM22nyU7BY1ya8CXbd/CEOZLl6j4zpA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppiVkXd7z2pm9reuExHbEvhGx0QQKUK+FyhD0P
 DsDA9cqeHGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaYlZBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AE/EH/0RnL+IE2bSk5oaileG3/pYrbWh1yxH7Z3MCazI
 BYXRHKFnuLgCRjhQPcTV0HRg/jkWSAsIYEvr8Q6l45muPdSe4ISsmSNqeOHojZMRU9B4tCnH5bo
 J5o56uQuVIHj5kfhTaE5KcrKuw5qxRYWpurak8HNOmKv9AO47Bbz9/emA34nXMI2+8FtqP3UGuL
 e8aWJje83Xd3U++597gk6kdNAjKEpt8pQuqTnQ8km2lx123Aa+cmYTreMmgirReRgJ+Usdkjm9L
 TNl1yiHG2s/DR81MBuEtIDyT6liobmVEQgaHXs3zH5ppMVRZ7LRVgpxpnmBvepaq+n0DHLln6FS
 kG3w=
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
index 8c6edab6885..4cb500f714e 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -478,63 +478,63 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
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
@@ -543,8 +543,9 @@ static const int infra_pcie_gfmux_tl_ck_o_p1_parents[] = {
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

