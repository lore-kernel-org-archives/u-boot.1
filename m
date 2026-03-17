Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952D3FF6E97
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 23:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0749584261;
	Wed, 18 Mar 2026 00:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jAJuckTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0FB784242; Wed, 18 Mar 2026 00:26:33 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B6A58413A
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso3949448fac.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773789989; x=1774394789;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SDCc+oU67YC8c5/DrrC+SRXQS9xXeCuDyyP+XwRY9dU=;
 b=jAJuckTY8SAZHyqmRgD9PIOaxxNrrUT7lFx0cnMg1rKh6ukTF7zFsHTJbI4T40vq3m
 4kVqwf9lKm5PqHNLXhF8NebqG9gUGZl/yeukK5UMrFwZnPQOFnj3fhV+7Ckk9jXnXz0b
 tI1/i3ylhRf2B4Hi/jejabsKCvpc0my2ZYZOYeMve8KOTca6LpAzCgD/0y0PeDkx/fgk
 LEqBtdJw1MMUsi6lOPhINYOnVkehPLiNYd+gBHB9NSX01av0w9AQuTacwSBnZKkt28jA
 Ffki7Sh7BDm/aO1YuDmB+Eunf8ajMkWGkjIMYB49cLB+jP5SOMfc/3xPcl4dVEOrORDU
 eBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789989; x=1774394789;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SDCc+oU67YC8c5/DrrC+SRXQS9xXeCuDyyP+XwRY9dU=;
 b=qvv6gHiJHd6rCkR3VtDMYnaiMXgRsPEN0ff77Zb43PAuXlb07ZVpnWqJ/YZtNUGCjQ
 pSrXW03iLvJO0/MF1pKbUDNbfTXtU8bc34KVKPIh59uX34eG8Om22OFQCJhky8JS/V3d
 lcK5WA8UqApbCHmtmv/o0YnjP+AWD/CtFwP2Vx2kIKjB7/csr0+e9IO6tbUGfUV7810D
 DQpC233r8DPePp2KgBgbqCfLp8E7k2VgIhGqEDsCYBlmhP2Y5zoegucFYiRJy+jGY4Uq
 HtJ76Z5e0Z+07rB9iwe2exjuZ++6F/M6GW1nibIfbGzQV6WCCcv11aaUBwIP6yWbXaHX
 pYvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Onwkm/nJvSWupNJdlQmrD1x//o+39Se3r2ksUWpbOox88UFP7bEav0gZ8rjVqPEra7IbEQw=@lists.denx.de
X-Gm-Message-State: AOJu0YzdmjrFP9N2UZZLKirp0MIU9I5EXm6YN/FGXnxK1/pFVx3jbrhL
 FDWQKXbmqlF+BQJ07Pt77H40jC7upPLJWwzF5qj176tW7T8x1mEfCbx2oMXf5FAJ884=
X-Gm-Gg: ATEYQzws9WHohHPbMaCaFDBt96i0MUFBYpIexexWW/rNtbNrDPaydi0Q/73Werb4azF
 A5pSyb4/jNtAUnL6fHBCfg5LHo6hJIqJvMKrtY1hS3fcTnbaB1VURzYy3Khd/kwrNzp9NmnyRKJ
 BfDYz8CWDZKiEX1+JymHA4eFlO+x9c9iEHOjQwMOzd78o9rorhQaozAo3oevOkjb6Tcw6vos5k/
 gY8YXX9sdSVieEO6o5JeBVxctcTgDOpdIp5rfF4N3EogLfEN1AxwrfiEx67u7yNi2Iz2ViK6h1e
 bLWQbAc7nNqfD1YILxbb4T1m1TdByX/UuLNafn0wD4zxQIGYFngkwGPFPEy4U2PrSLjsoiGhict
 ZZ3k8U4VqVaGQcV9BeBYf5AHwp4qLDNPEwmBnbx2OMjmFuoUVX/bKlOv47NYivfe8nFKC8wkrvf
 KmjnFDLD3jRAmHqlbL35FuRSD+DQ==
X-Received: by 2002:a05:6870:a550:b0:417:349c:dbb with SMTP id
 586e51a60fabf-41bd418b938mr909072fac.34.1773789989033; 
 Tue, 17 Mar 2026 16:26:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2828aa7sm1148309fac.1.2026.03.17.16.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:26:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Mar 2026 18:23:15 -0500
Subject: [PATCH v3 02/16] clk: mediatek: mt7623: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-clk-mtk-unify-mux-parents-v3-2-a4760f5b0a80@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=23602;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=75B6SlN0EMJuOiLNDbDi8tlgAO/5dME9hedawJ72qp8=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpueJ7dq9Z39b10DBE3/58pNJEVp7HWTQBdWT0z
 ZEbkRUGS6mJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabniexYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AWKwH/3wdO25OpgBA7TLK6GvroTatBgsxXG9POZxzRNV
 632tkYXvWlAadq4qQ5+nzQMMtTyw3W4QFKnIao6ppBKOvus+4hOYburyjaJEI9nqQ7BRLk76atT
 sKI7y/lVUgYGsbg9Tda6MIy4qH8Jjb+gRWYQYmIRDzF/KUasveQR/XKGExTN0NndXu45/kITc4/
 ofQk2MeWlKYed/a5pXq9LCBlqjTCAoYKfLB5HBfsdj/vEP4qgWyfZBwBpemdM3/4D/gwoMbI14d
 ONqNdDVe28kpWHC1LER2LpAJSbgp96czbMDYHLiqe5Qm2fWpMoUA+2mqIAc6gN1Nq5JKjwWM5k/
 YL1g=
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

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 774 +++++++++++++++++++-------------------
 1 file changed, 387 insertions(+), 387 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index d52555283d2..9bb2a1af734 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -375,399 +375,399 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_8BDAC, CLK_TOP_UNIVPLL_D2, 1, 1),
 };
 
-static const int axi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_MMPLL_D2,
-	CLK_TOP_DMPLL_D2
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
-static const int mm_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_VENCPLL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_DMPLL
-};
-
-static const int pwm_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_UNIVPLL1_D4
-};
-
-static const int vdec_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_VDECPLL,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_VENCPLL,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_MMPLL_D2
-};
-
-static const int mfg_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_MMPLL,
-	CLK_TOP_DMPLL_X2,
-	CLK_TOP_MSDCPLL,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_UNIVPLL1_D2
-};
-
-static const int camtg_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL_D26,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_MMPLL_D2
-};
-
-static const int uart_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D8
-};
-
-static const int spi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL1_D8
-};
-
-static const int usb20_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_UNIVPLL3_D4
-};
-
-static const int msdc30_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_UNIVPLL2_D4,
-};
-
-static const int aud_intbus_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_UNIVPLL2_D4
-};
-
-static const int pmicspi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_SYSPLL2_D8,
-	CLK_TOP_SYSPLL1_D16,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL_D26,
-	CLK_TOP_DMPLL_D2,
-	CLK_TOP_DMPLL_D4
-};
-
-static const int scp_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_DMPLL_D2,
-	CLK_TOP_DMPLL_D4
-};
-
-static const int dpi0_tve_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_MIPIPLL,
-	CLK_TOP_MIPIPLL_D2,
-	CLK_TOP_MIPIPLL_D4,
-	CLK_XTAL,
-	CLK_TOP_TVDPLL,
-	CLK_TOP_TVDPLL_D2,
-	CLK_TOP_TVDPLL_D4
-};
-
-static const int dpi1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_TVDPLL,
-	CLK_TOP_TVDPLL_D2,
-	CLK_TOP_TVDPLL_D4
-};
-
-static const int hdmi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_HDMIPLL,
-	CLK_TOP_HDMIPLL_D2,
-	CLK_TOP_HDMIPLL_D3
-};
-
-static const int apll_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_AUDPLL,
-	CLK_TOP_AUDPLL_D4,
-	CLK_TOP_AUDPLL_D8,
-	CLK_TOP_AUDPLL_D16,
-	CLK_TOP_AUDPLL_D24,
-	CLK_XTAL,
-	CLK_XTAL
-};
-
-static const int rtc_parents[] = {
-	CLK_TOP_32K_INTERNAL,
-	CLK_TOP_32K_EXTERNAL,
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL3_D8
-};
-
-static const int nfi2x_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_XTAL
-};
-
-static const int emmc_hclk_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL2_D2
-};
-
-static const int flash_parents[] = {
-	CLK_TOP_CLK26M_D8,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL2_D8,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D4
-};
-
-static const int di_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_TVD2PLL,
-	CLK_TOP_TVD2PLL_D2,
-	CLK_XTAL
-};
-
-static const int nr_osd_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_VENCPLL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_DMPLL
-};
-
-static const int hdmirx_bist_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL_D3,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D16,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_VENCPLL,
-	CLK_XTAL
-};
-
-static const int intdir_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_MMPLL,
-	CLK_TOP_SYSPLL_D2,
-	CLK_TOP_UNIVPLL_D2
-};
-
-static const int asm_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL_D5
-};
-
-static const int ms_card_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL3_D8,
-	CLK_TOP_SYSPLL4_D4
-};
-
-static const int ethif_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_DMPLL,
-	CLK_TOP_DMPLL_D2
-};
-
-static const int hdmirx_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL_D52
-};
-
-static const int cmsys_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL
-};
-
-static const int clk_8bdac_parents[] = {
-	CLK_TOP_32K_INTERNAL,
-	CLK_TOP_8BDAC,
-	CLK_XTAL,
-	CLK_XTAL
-};
-
-static const int aud2dvd_parents[] = {
-	CLK_TOP_AUD_48K_TIMING,
-	CLK_TOP_AUD_44K_TIMING
-};
-
-static const int padmclk_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL_D26,
-	CLK_TOP_UNIVPLL_D52,
-	CLK_TOP_UNIVPLL_D108,
-	CLK_TOP_UNIVPLL2_D8,
-	CLK_TOP_UNIVPLL2_D16,
-	CLK_TOP_UNIVPLL2_D32
-};
+static const struct mtk_parent axi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D2),
+	TOP_PARENT(CLK_TOP_DMPLL_D2),
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
+static const struct mtk_parent mm_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_VENCPLL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_DMPLL),
+};
+
+static const struct mtk_parent pwm_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+};
+
+static const struct mtk_parent vdec_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_VDECPLL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_VENCPLL),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D2),
+};
+
+static const struct mtk_parent mfg_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_MMPLL),
+	TOP_PARENT(CLK_TOP_DMPLL_X2),
+	TOP_PARENT(CLK_TOP_MSDCPLL),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+};
+
+static const struct mtk_parent camtg_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D26),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D2),
+};
+
+static const struct mtk_parent uart_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+};
+
+static const struct mtk_parent spi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+};
+
+static const struct mtk_parent usb20_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+};
+
+static const struct mtk_parent msdc30_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+};
+
+static const struct mtk_parent aud_intbus_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+};
+
+static const struct mtk_parent pmicspi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D26),
+	TOP_PARENT(CLK_TOP_DMPLL_D2),
+	TOP_PARENT(CLK_TOP_DMPLL_D4),
+};
+
+static const struct mtk_parent scp_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_DMPLL_D2),
+	TOP_PARENT(CLK_TOP_DMPLL_D4),
+};
+
+static const struct mtk_parent dpi0_tve_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_MIPIPLL),
+	TOP_PARENT(CLK_TOP_MIPIPLL_D2),
+	TOP_PARENT(CLK_TOP_MIPIPLL_D4),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_TVDPLL),
+	TOP_PARENT(CLK_TOP_TVDPLL_D2),
+	TOP_PARENT(CLK_TOP_TVDPLL_D4),
+};
+
+static const struct mtk_parent dpi1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_TVDPLL),
+	TOP_PARENT(CLK_TOP_TVDPLL_D2),
+	TOP_PARENT(CLK_TOP_TVDPLL_D4),
+};
+
+static const struct mtk_parent hdmi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_HDMIPLL),
+	TOP_PARENT(CLK_TOP_HDMIPLL_D2),
+	TOP_PARENT(CLK_TOP_HDMIPLL_D3),
+};
+
+static const struct mtk_parent apll_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_AUDPLL),
+	TOP_PARENT(CLK_TOP_AUDPLL_D4),
+	TOP_PARENT(CLK_TOP_AUDPLL_D8),
+	TOP_PARENT(CLK_TOP_AUDPLL_D16),
+	TOP_PARENT(CLK_TOP_AUDPLL_D24),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+};
 
-static const int aud_mux_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_AUD1PLL_98M,
-	CLK_TOP_AUD2PLL_90M,
-	CLK_TOP_HADDS2PLL_98M,
-	CLK_TOP_AUD_EXTCK1_DIV,
-	CLK_TOP_AUD_EXTCK2_DIV
+static const struct mtk_parent rtc_parents[] = {
+	TOP_PARENT(CLK_TOP_32K_INTERNAL),
+	TOP_PARENT(CLK_TOP_32K_EXTERNAL),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D8),
+};
+
+static const struct mtk_parent nfi2x_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent emmc_hclk_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+};
+
+static const struct mtk_parent flash_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M_D8),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+};
+
+static const struct mtk_parent di_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_TVD2PLL),
+	TOP_PARENT(CLK_TOP_TVD2PLL_D2),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent nr_osd_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_VENCPLL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_DMPLL),
+};
+
+static const struct mtk_parent hdmirx_bist_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_VENCPLL),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent intdir_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_MMPLL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
+};
+
+static const struct mtk_parent asm_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+};
+
+static const struct mtk_parent ms_card_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+};
+
+static const struct mtk_parent ethif_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_DMPLL),
+	TOP_PARENT(CLK_TOP_DMPLL_D2),
+};
+
+static const struct mtk_parent hdmirx_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D52),
+};
+
+static const struct mtk_parent cmsys_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent clk_8bdac_parents[] = {
+	TOP_PARENT(CLK_TOP_32K_INTERNAL),
+	TOP_PARENT(CLK_TOP_8BDAC),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent aud2dvd_parents[] = {
+	TOP_PARENT(CLK_TOP_AUD_48K_TIMING),
+	TOP_PARENT(CLK_TOP_AUD_44K_TIMING),
+};
+
+static const struct mtk_parent padmclk_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D26),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D52),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D108),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D32),
+};
+
+static const struct mtk_parent aud_mux_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_AUD1PLL_98M),
+	TOP_PARENT(CLK_TOP_AUD2PLL_90M),
+	TOP_PARENT(CLK_TOP_HADDS2PLL_98M),
+	TOP_PARENT(CLK_TOP_AUD_EXTCK1_DIV),
+	TOP_PARENT(CLK_TOP_AUD_EXTCK2_DIV),
 };
 
-static const int aud_src_parents[] = {
-	CLK_TOP_AUD_MUX1_SEL,
-	CLK_TOP_AUD_MUX2_SEL
+static const struct mtk_parent aud_src_parents[] = {
+	TOP_PARENT(CLK_TOP_AUD_MUX1_SEL),
+	TOP_PARENT(CLK_TOP_AUD_MUX2_SEL),
 };
 
 static const struct mtk_composite top_muxes[] = {
-	MUX_GATE(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
-	MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
-	MUX_GATE_FLAGS(CLK_TOP_MM_SEL, mm_parents, 0x40, 24, 3, 31,
-		       CLK_MUX_DOMAIN_SCPSYS),
-
-	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
-	MUX_GATE(CLK_TOP_VDEC_SEL, vdec_parents, 0x50, 8, 4, 15),
-	MUX_GATE_FLAGS(CLK_TOP_MFG_SEL, mfg_parents, 0x50, 16, 3, 23,
-		       CLK_MUX_DOMAIN_SCPSYS),
-	MUX_GATE(CLK_TOP_CAMTG_SEL, camtg_parents, 0x50, 24, 3, 31),
-
-	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
-	MUX_GATE(CLK_TOP_SPI0_SEL, spi_parents, 0x60, 8, 3, 15),
-	MUX_GATE(CLK_TOP_USB20_SEL, usb20_parents, 0x60, 16, 2, 23),
-	MUX_GATE(CLK_TOP_MSDC30_0_SEL, msdc30_parents, 0x60, 24, 3, 31),
-
-	MUX_GATE(CLK_TOP_MSDC30_1_SEL, msdc30_parents, 0x70, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MSDC30_2_SEL, msdc30_parents, 0x70, 8, 3, 15),
-	MUX_GATE(CLK_TOP_AUDIO_SEL, msdc30_parents, 0x70, 16, 1, 23),
-	MUX_GATE(CLK_TOP_AUDINTBUS_SEL, aud_intbus_parents, 0x70, 24, 3, 31),
-
-	MUX_GATE(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 0, 4, 7),
-	MUX_GATE(CLK_TOP_SCP_SEL, scp_parents, 0x80, 8, 2, 15),
-	MUX_GATE(CLK_TOP_DPI0_SEL, dpi0_tve_parents, 0x80, 16, 3, 23),
-	MUX_GATE(CLK_TOP_DPI1_SEL, dpi1_parents, 0x80, 24, 2, 31),
-
-	MUX_GATE(CLK_TOP_TVE_SEL, dpi0_tve_parents, 0x90, 0, 3, 7),
-	MUX_GATE(CLK_TOP_HDMI_SEL, hdmi_parents, 0x90, 8, 2, 15),
-	MUX_GATE(CLK_TOP_APLL_SEL, apll_parents, 0x90, 16, 3, 23),
-
-	MUX_GATE(CLK_TOP_RTC_SEL, rtc_parents, 0xA0, 0, 2, 7),
-	MUX_GATE(CLK_TOP_NFI2X_SEL, nfi2x_parents, 0xA0, 8, 3, 15),
-	MUX_GATE(CLK_TOP_EMMC_HCLK_SEL, emmc_hclk_parents, 0xA0, 24, 2, 31),
-
-	MUX_GATE(CLK_TOP_FLASH_SEL, flash_parents, 0xB0, 0, 3, 7),
-	MUX_GATE(CLK_TOP_DI_SEL, di_parents, 0xB0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_NR_SEL, nr_osd_parents, 0xB0, 16, 3, 23),
-	MUX_GATE(CLK_TOP_OSD_SEL, nr_osd_parents, 0xB0, 24, 3, 31),
-
-	MUX_GATE(CLK_TOP_HDMIRX_BIST_SEL, hdmirx_bist_parents, 0xC0, 0, 3, 7),
-	MUX_GATE(CLK_TOP_INTDIR_SEL, intdir_parents, 0xC0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_ASM_I_SEL, asm_parents, 0xC0, 16, 2, 23),
-	MUX_GATE(CLK_TOP_ASM_M_SEL, asm_parents, 0xC0, 24, 3, 31),
-
-	MUX_GATE(CLK_TOP_ASM_H_SEL, asm_parents, 0xD0, 0, 2, 7),
-	MUX_GATE(CLK_TOP_MS_CARD_SEL, ms_card_parents, 0xD0, 16, 2, 23),
-	MUX_GATE_FLAGS(CLK_TOP_ETHIF_SEL, ethif_parents, 0xD0, 24, 3, 31,
-		       CLK_MUX_DOMAIN_SCPSYS),
-
-	MUX_GATE(CLK_TOP_HDMIRX26_24_SEL, hdmirx_parents, 0xE0, 0, 1, 7),
-	MUX_GATE(CLK_TOP_MSDC30_3_SEL, msdc30_parents, 0xE0, 8, 3, 15),
-	MUX_GATE(CLK_TOP_CMSYS_SEL, cmsys_parents, 0xE0, 16, 4, 23),
-
-	MUX_GATE(CLK_TOP_SPI1_SEL, spi_parents, 0xE0, 24, 3, 31),
-	MUX_GATE(CLK_TOP_SPI2_SEL, spi_parents, 0xF0, 0, 3, 7),
-	MUX_GATE(CLK_TOP_8BDAC_SEL, clk_8bdac_parents, 0xF0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_AUD2DVD_SEL, aud2dvd_parents, 0xF0, 16, 1, 23),
-
-	MUX(CLK_TOP_PADMCLK_SEL, padmclk_parents, 0x100, 0, 3),
-
-	MUX(CLK_TOP_AUD_MUX1_SEL, aud_mux_parents, 0x12c, 0, 3),
-	MUX(CLK_TOP_AUD_MUX2_SEL, aud_mux_parents, 0x12c, 3, 3),
-	MUX(CLK_TOP_AUDPLL_MUX_SEL, aud_mux_parents, 0x12c, 6, 3),
-
-	MUX_GATE(CLK_TOP_AUD_K1_SRC_SEL, aud_src_parents, 0x12c, 15, 1, 23),
-	MUX_GATE(CLK_TOP_AUD_K2_SRC_SEL, aud_src_parents, 0x12c, 16, 1, 24),
-	MUX_GATE(CLK_TOP_AUD_K3_SRC_SEL, aud_src_parents, 0x12c, 17, 1, 25),
-	MUX_GATE(CLK_TOP_AUD_K4_SRC_SEL, aud_src_parents, 0x12c, 18, 1, 26),
-	MUX_GATE(CLK_TOP_AUD_K5_SRC_SEL, aud_src_parents, 0x12c, 19, 1, 27),
-	MUX_GATE(CLK_TOP_AUD_K6_SRC_SEL, aud_src_parents, 0x12c, 20, 1, 28),
+	MUX_GATE_MIXED(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
+	MUX_GATE_MIXED_FLAGS(CLK_TOP_MM_SEL, mm_parents, 0x40, 24, 3, 31,
+			     CLK_MUX_DOMAIN_SCPSYS),
+
+	MUX_GATE_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_VDEC_SEL, vdec_parents, 0x50, 8, 4, 15),
+	MUX_GATE_MIXED_FLAGS(CLK_TOP_MFG_SEL, mfg_parents, 0x50, 16, 3, 23,
+			     CLK_MUX_DOMAIN_SCPSYS),
+	MUX_GATE_MIXED(CLK_TOP_CAMTG_SEL, camtg_parents, 0x50, 24, 3, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_SPI0_SEL, spi_parents, 0x60, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_USB20_SEL, usb20_parents, 0x60, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_0_SEL, msdc30_parents, 0x60, 24, 3, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_1_SEL, msdc30_parents, 0x70, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_2_SEL, msdc30_parents, 0x70, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_AUDIO_SEL, msdc30_parents, 0x70, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_AUDINTBUS_SEL, aud_intbus_parents, 0x70, 24, 3, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_SCP_SEL, scp_parents, 0x80, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_DPI0_SEL, dpi0_tve_parents, 0x80, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_DPI1_SEL, dpi1_parents, 0x80, 24, 2, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_TVE_SEL, dpi0_tve_parents, 0x90, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_HDMI_SEL, hdmi_parents, 0x90, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_APLL_SEL, apll_parents, 0x90, 16, 3, 23),
+
+	MUX_GATE_MIXED(CLK_TOP_RTC_SEL, rtc_parents, 0xA0, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_NFI2X_SEL, nfi2x_parents, 0xA0, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_EMMC_HCLK_SEL, emmc_hclk_parents, 0xA0, 24, 2, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_FLASH_SEL, flash_parents, 0xB0, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_DI_SEL, di_parents, 0xB0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_NR_SEL, nr_osd_parents, 0xB0, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_OSD_SEL, nr_osd_parents, 0xB0, 24, 3, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_HDMIRX_BIST_SEL, hdmirx_bist_parents, 0xC0, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_INTDIR_SEL, intdir_parents, 0xC0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_ASM_I_SEL, asm_parents, 0xC0, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_ASM_M_SEL, asm_parents, 0xC0, 24, 3, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_ASM_H_SEL, asm_parents, 0xD0, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_MS_CARD_SEL, ms_card_parents, 0xD0, 16, 2, 23),
+	MUX_GATE_MIXED_FLAGS(CLK_TOP_ETHIF_SEL, ethif_parents, 0xD0, 24, 3, 31,
+			     CLK_MUX_DOMAIN_SCPSYS),
+
+	MUX_GATE_MIXED(CLK_TOP_HDMIRX26_24_SEL, hdmirx_parents, 0xE0, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_3_SEL, msdc30_parents, 0xE0, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_CMSYS_SEL, cmsys_parents, 0xE0, 16, 4, 23),
+
+	MUX_GATE_MIXED(CLK_TOP_SPI1_SEL, spi_parents, 0xE0, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_SPI2_SEL, spi_parents, 0xF0, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_8BDAC_SEL, clk_8bdac_parents, 0xF0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_AUD2DVD_SEL, aud2dvd_parents, 0xF0, 16, 1, 23),
+
+	MUX_MIXED(CLK_TOP_PADMCLK_SEL, padmclk_parents, 0x100, 0, 3),
+
+	MUX_MIXED(CLK_TOP_AUD_MUX1_SEL, aud_mux_parents, 0x12c, 0, 3),
+	MUX_MIXED(CLK_TOP_AUD_MUX2_SEL, aud_mux_parents, 0x12c, 3, 3),
+	MUX_MIXED(CLK_TOP_AUDPLL_MUX_SEL, aud_mux_parents, 0x12c, 6, 3),
+
+	MUX_GATE_MIXED(CLK_TOP_AUD_K1_SRC_SEL, aud_src_parents, 0x12c, 15, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_AUD_K2_SRC_SEL, aud_src_parents, 0x12c, 16, 1, 24),
+	MUX_GATE_MIXED(CLK_TOP_AUD_K3_SRC_SEL, aud_src_parents, 0x12c, 17, 1, 25),
+	MUX_GATE_MIXED(CLK_TOP_AUD_K4_SRC_SEL, aud_src_parents, 0x12c, 18, 1, 26),
+	MUX_GATE_MIXED(CLK_TOP_AUD_K5_SRC_SEL, aud_src_parents, 0x12c, 19, 1, 27),
+	MUX_GATE_MIXED(CLK_TOP_AUD_K6_SRC_SEL, aud_src_parents, 0x12c, 20, 1, 28),
 };
 
 /* infracfg */

-- 
2.43.0

