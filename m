Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70AFEB3641
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 00:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F85683F6D;
	Tue,  3 Mar 2026 01:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ui+AYv5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64CC383F80; Tue,  3 Mar 2026 01:05:09 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1368C83F14
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 01:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-40427db1300so201536fac.0
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 16:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772496302; x=1773101102;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h883A/OYzscSAJDszfc2lbMoX3xotPaZOGaRQGNnqYM=;
 b=Ui+AYv5rtunqB9TKhWGYVaemFmKjyFHxZnz/g2PJmDDFu/WXoFi7DE8+mm6t+gVSvW
 gOkEcJKx1hZEsM8m+oFynlDxZFNLxaiuhq0MzjseJ475GfKyz7+rfyMRO/tvvoCQMU6p
 sVSxgxZqzc+/+hGC8W/SwBxG7CPkKPYtC4y4+yEk2KBZOw4dsU329hgC6ny5JpBfy+jQ
 R3eThT4E6i+q+6avbLAPgl1iKj5DvUDUnOY2XdJiHaEmnccJeduYxLijDiMGWck3oqts
 y2kqhWk7WZPZcpqcDNlEGWYXJZGjekfOxGQU4Bwp2KTLbw8YClX7EwgkxeZC7wnniJSF
 606A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496302; x=1773101102;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h883A/OYzscSAJDszfc2lbMoX3xotPaZOGaRQGNnqYM=;
 b=ha7tMwOFXrla5ju69Ktu7akkbjzpUKSh2FAVcktmomXDAT0eipEoYa35GlgIHS3bdj
 4mAWIzLZT0YU7G8p8PSEwdpJyYKFxdSFYTvUVF1wPedIbGtK9+VpK8g0lVrewyHKC4jc
 TTfsGPhEVVScVvKVkPwcZvn2d/HlahcY+WOcZ8kxg0ayoFzlYs1ugFzRdZSPOQXjCQbK
 9VULA6V8yXkmhgKEwZShU6A/oZHtBoV4xnCCOCaC02vuWelt80Hn7iWTWiUOUIfxMNn1
 HhliV0g6/pU1fUZkDOxO5J9d/PMuMdTOzt46wixOj+u1yB9mKDxS8hvyLpLrJRD8LI0j
 6hOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJF0eDkraL021CTNJmpKqcnkQ8mZjxoi/7NsFp79jpHqoute/Vn1BD9H3dkQ6SzvSErj05orQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzE5aEEKotYaQA+Sr9jV5XQIixPUOpkBWaPVS85TZbt9hpKPf9l
 laMR2BcrnioIolJnPEoAzAssAdslGlJbDDRF6sdykwU1cmpsNHvCuNd3vMRbBpCr5WA=
X-Gm-Gg: ATEYQzyAh+dbxCzf0QlVDKzclY+hHjz8GHT0lhVUzZ+HvFMma00dRP0erL/9+LcF1hD
 5bsqBqNIUoP4VtLjXOFFV7GApU0To7VYtfY5Jh283ovSRTIrJgvxsshJ8QFtUxNsYJ6liHsWrx7
 qd98Bj2mVp15GzkAN5jC/m2QLpfpdFgXPc0rdraJdncPpQWUE6EmlMTOIHwo8L8//c4fmq76I2c
 HGSYWdFY+5DEFXtsyzN3ziA+qlKP5kDxvq90WsDgO9S/R8ZV+dRaC6YjdB02TzNNl+00IWUDgBr
 yvHS2SeOqqrfbOic5ZGHOSGubC5hpS3JF2KzlpDRI0yoDqQ7q+iqAo4j1HndnHR/vuQ9POWxWNO
 E1PpF77SNawsKXd5ey8TPLpR1h9cUpB+wFr2T0Wrd8jS7nqZEKmwJNvoa3o1Um8Ic0Y45fgf8CY
 ffbsgq6uOHh3Qrg2Cbzt5nlFss0anf
X-Received: by 2002:a05:6870:b3f1:b0:3ec:51e3:4fd4 with SMTP id
 586e51a60fabf-4162707c5c9mr7128354fac.49.1772496302147; 
 Mon, 02 Mar 2026 16:05:02 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf239e0sm13878551fac.1.2026.03.02.16.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 16:05:01 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 18:03:10 -0600
Subject: [PATCH 01/14] clk: mediatek: move common PARENT macros to header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-clk-mtk-unify-mux-parents-v1-1-32f45085f4d0@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7162; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=kBcOtSmuV61g66c4dqds5UxccLImPoRQFFYXikDXv78=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppiVQwAaq0LOGJfvLV4OkGO70LnftRjFxVQ/wS
 vmDaIMdcraJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaYlUBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AXlAH/i8dEjARflguHIhTA44vk+YLb4WvjGsFv7NNeyi
 ZpSzSxNFhmq4ob60IICUXwxnofwsqkIBxem2pazkAurxbMd4R1Edkm7ypmlQ6xbfXT/BP1m6sG4
 XA934mH1VizNq0b5+f4vk7IMfTqE6mmqUac9O/7jiH4zCpQnyIZFz4D2T3uuSM8tdA02sgIIZnO
 +cOinGcbTdvnDr20rEnvqGEwoFOZ7R5m8Vac4fwzKqyshJcm6wAhJvt0RE9K5CpHhW1uv5yosJj
 8irFQuj3H4A+iqY9mwePTF+dmXLRiJ6rF1cv1oVjQRcHk6hPbyzCYl0VtC2g/Ocs1gvuX4hfQAZ
 U65k=
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
 drivers/clk/mediatek/clk-mt7622.c | 8 --------
 drivers/clk/mediatek/clk-mt7623.c | 6 ------
 drivers/clk/mediatek/clk-mt7629.c | 4 ----
 drivers/clk/mediatek/clk-mt7981.c | 5 -----
 drivers/clk/mediatek/clk-mt7986.c | 5 -----
 drivers/clk/mediatek/clk-mt7987.c | 4 ----
 drivers/clk/mediatek/clk-mt7988.c | 4 ----
 drivers/clk/mediatek/clk-mt8189.c | 4 ----
 drivers/clk/mediatek/clk-mtk.h    | 7 +++++++
 9 files changed, 7 insertions(+), 40 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index e420be5a137..88ccb4cb8ea 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -159,10 +159,6 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR0(CLK_TOP_ETH_500M, CLK_APMIXED_ETH1PLL, 1, 1),
 };
 
-#define XTAL_PARENT(id)	PARENT(id, CLK_PARENT_XTAL)
-#define TOP_PARENT(id)	PARENT(id, CLK_PARENT_TOPCKGEN)
-#define VOID_PARENT	PARENT(-1, 0)
-
 static const struct mtk_parent axi_parents[] = {
 	XTAL_PARENT(CLK_XTAL),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
@@ -390,10 +386,6 @@ static const struct mtk_composite top_muxes[] = {
 	MUX_MIXED(CLK_TOP_I2S3_MCK_SEL, apll1_ck_parents, 0x120, 161, 1),
 };
 
-/* infracfg */
-#define APMIXED_PARENT(_id) PARENT(_id, CLK_PARENT_APMIXED)
-#define XTAL_PARENT(_id) PARENT(_id, CLK_PARENT_XTAL)
-
 static const struct mtk_parent infra_mux1_parents[] = {
 	XTAL_PARENT(CLK_XTAL),
 	APMIXED_PARENT(CLK_APMIXED_MAINPLL),
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index dfe6f5e113e..16424ba2de6 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -375,9 +375,6 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_8BDAC, CLK_TOP_UNIVPLL_D2, 1, 1),
 };
 
-#define XTAL_PARENT(id)		PARENT(id, CLK_PARENT_XTAL)
-#define TOP_PARENT(id)		PARENT(id, CLK_PARENT_TOPCKGEN)
-
 static const struct mtk_parent axi_parents[] = {
 	XTAL_PARENT(CLK_XTAL),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
@@ -869,9 +866,6 @@ static const int peri_id_offs_map[] = {
 	[CLK_PERI_FCI]				= 48,
 };
 
-#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
-#define XTAL_PARENT(_id) PARENT(_id, CLK_PARENT_XTAL)
-
 static const struct mtk_parent uart_ck_sel_parents[] = {
 	XTAL_PARENT(CLK_XTAL),
 	TOP_PARENT(CLK_TOP_UART_SEL),
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 56f4c99d84b..b82212ec664 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -152,10 +152,6 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_PCIE0_MAC_EN, CLK_TOP_UNIVPLL1_D4, 1, 1),
 };
 
-#define XTAL_PARENT(id)	PARENT(id, CLK_PARENT_XTAL)
-#define TOP_PARENT(id)	PARENT(id, CLK_PARENT_TOPCKGEN)
-#define VOID_PARENT	PARENT(-1, 0)
-
 static const struct mtk_parent axi_parents[] = {
 	XTAL_PARENT(CLK_XTAL),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 87b68559e65..3fb6a3e33df 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -318,11 +318,6 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
 	TOP_FACTOR(CLK_INFRA_66M_MCK, "infra_66m_mck", CLK_TOP_SYSAXI_SEL, 1, 2),
 };
 
-/* INFRASYS MUX PARENTS */
-#define INFRA_PARENT(_id) PARENT(_id, CLK_PARENT_INFRASYS)
-#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
-#define VOID_PARENT PARENT(-1, 0)
-
 static const struct mtk_parent infra_uart0_parents[] = {
 	TOP_PARENT(CLK_TOP_F26M_SEL),
 	TOP_PARENT(CLK_TOP_UART_SEL)
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 3309850aa60..65d4142fa63 100644
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
index b4bb02ca736..8c6edab6885 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -110,10 +110,6 @@ static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
 	TOP_FACTOR(CLK_TOP_CB_RTC_32P7K, "cb_rtc_32p7k", CLK_TOP_CB_CKSQ_40M, 1, 1221),
 };
 
-/* TOPCKGEN MUX PARENTS */
-#define APMIXED_PARENT(_id) PARENT(_id, CLK_PARENT_APMIXED)
-#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
-
 /* CLK_TOP_NETSYS_SEL (netsys_sel) in topckgen */
 static const struct mtk_parent netsys_parents[] = {
 	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 2f0fa9f1ce9..55a4ec858df 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -93,10 +93,6 @@ static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
 	PLL_FACTOR(CLK_TOP_NET2PLL_D8, "net2pll_d8", CLK_APMIXED_NET2PLL, 1, 8),
 };
 
-/* TOPCKGEN MUX PARENTS */
-#define APMIXED_PARENT(_id) PARENT(_id, CLK_PARENT_APMIXED)
-#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
-
 static const struct mtk_parent netsys_parents[] = {
 	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET2PLL_D2),
 	TOP_PARENT(CLK_TOP_MMPLL_D2),
diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 4ade03f2f6c..744e644f138 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -429,10 +429,6 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
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
index 8374ed5ce78..588c940b715 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -122,6 +122,13 @@ struct mtk_parent {
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

