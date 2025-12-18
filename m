Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5F7D6E2B8
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4490983979;
	Thu, 18 Dec 2025 18:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iYGYqxWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6354D83642; Thu, 18 Dec 2025 18:18:13 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4658282BF2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3f5c9275b31so549724fac.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766078290; x=1766683090;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gD3JTAQUAdeki81bMKB4j4lbcNXdfEQPQdZtM+Jleis=;
 b=iYGYqxWJZ9CuVoslnr3Aqsz4XmF8WcEPUDxELJBufZ5Q8ZvHz8jAIJDgSr1KOFlHTw
 iNP3ZSU0ts2+ZJ/3+yOlDme0emCtdQYsy+kaxD8mfSkAHqQrhC5tfcU3adUaePus+TFa
 bskFriWf+s2PJSMgDIlWY0uPIdh68dokUKW+53zRnq1CWUc1nTHQ/jg8W9LPkAlSWhmY
 3DsIMMsCmHEf2V/+gJzM7Jc8MIJKGT4C3athDTDDOkaxOvzHRkOcLv5YXRw+sXQFBg2A
 8jzv0OH5gZ1MHyXF0D2Bt3kvkQSWfB1iRbnmcfNWsuZUPpJCjtObBdQ03mG5If3j3ABy
 Vfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766078290; x=1766683090;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gD3JTAQUAdeki81bMKB4j4lbcNXdfEQPQdZtM+Jleis=;
 b=s21EsDhKc5HzWp5kJShSbAdV6rIrsra+Id+nuRgVTLASoMOHHQW8p4Vx8Za6VXDAN5
 xh3smdw+pK06fI6DonJAXMaYKXaD6No0GUw4WkarQ9EkxPeANwTfEw/pS+C1T9LP7a4+
 60uWnjJgPv7iOQywN60oIp+QbJGrXvhGHTpYIRxiqf+kQMnKThk5N/skwKITFa6JrkLl
 rs4/UAz/pckzJlHVUiQd0HoedTOIGjy17fifnsU+0X3BxkMc9zrrn+YRgpMzcp9Un2hb
 V4zWLEmL0yfGU1M0wRj7dMrUaRFYA0/Yi2bdzGqhCWamQCTaA5frYk3X0STqeP4WbZ8s
 8eKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCuVgCrhcUE6XCUl1ppg0kj0C2RFL+NeV3SUO2V2uzrAwpmAxwYnpY3WXVN2LSIkhn9uRd1K0=@lists.denx.de
X-Gm-Message-State: AOJu0YwLm2RcsY+VdtdNYNcHwfL4bFr8Hkl04bc8ioaMaUIpATJ/TPAj
 m+EDVOh8c3qOAahUYqZw24vCjIQDlmTHcXM266Ojqu4n0+RRc002f4m0jHXiSLg0sc0=
X-Gm-Gg: AY/fxX7tXTIFaN39TS6HwV16XQ76pDfWDEhCRMHi8OMDAup926QL/UjK6ndnQgi5Ndm
 lbmAeALDe4jKuZ44a6ooTFRIxKUoQOofAxhThSoxTbNvkv33gCdjhpympTd70Hu4lPdiF+84vy2
 ZTGKd5YQwfmWzG5WKuOhQW6BHqVOmWRKzUVLC7e7A3+YocN+LwKbe1qhz0lp11wgh/gzcbkZ2hR
 Lyfs5s/fDoj+cSSnNDDIYpJMe68wGeefAXrFQj33hthFhiNKxmm5gV96uXsQRWmjO3nVVaLij/Z
 Pr+P03p3MCD95SmLF053uacabJRpRJMwElmJkUGP25+sw6tNqMAayZSjSp9kXN0SuqLztJXGmVR
 qqesvc2PIekBn4FQirVjvv3XRvaCWPUhb8cAL/rU7fhtNOSZ4ngiEhoQTv4MqoJRX+XdGpVod/f
 mLJUH7A+uhgZVKxMs=
X-Google-Smtp-Source: AGHT+IFSK+qMj1UhPCf2gARpS4imCEPAVXABENNA5MHo8k0I1C25U34qXlJejO2Thn2rskBfmW5qGQ==
X-Received: by 2002:a05:6820:8307:b0:65c:fe5b:9f5c with SMTP id
 006d021491bc7-65d0eb6de1fmr52435eaf.56.1766078290005; 
 Thu, 18 Dec 2025 09:18:10 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e5ea:76dc:e589:2d5e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65cff214d66sm1316372eaf.9.2025.12.18.09.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 09:18:09 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 11:17:05 -0600
Subject: [PATCH 7/8] clk: mediatek: mt7623: set unmapped IDs to -1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-improvements-v1-7-72db131ba148@baylibre.com>
References: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
In-Reply-To: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=gfpOIod3WRv7xKKVBcV5wEw/YKY2k9KWceHRU+LE58U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRDc+MOphJGl7wnBTYvsLnKIpgPJzTyFKnO/t6
 ddGldl8Lf2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUQ3PhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AHdcH/0Na4ulH25ByjlCh6/VMB05MD3vsH5IWcaG6kop
 hOyRS8FpCkOdQEirS0l2UV5iFPlG8rj5D/Jd383Swibld2EOznwki+BRlgajoOkes5IC16w9y7h
 shhaNuor2rM10TZHaMLsWxK7pQBz2Ep6FEjOlnX8BvE1dehcTQxLL39/OTQD4vfRfxLUWnHUdfk
 iBV6ucuK1TxOYMhsf13Hs1XYVh8DZP4pD5C+N6z0NfIJyTepHj8yNZ0YStvsRQWvz9R8CbOp8iQ
 Sed3QokbihVWH6Bw/jUaB+iaPtNZZHj4KzSWa6V8iXG7k48U3aI4Xong4hoFgi6B6uH0Ec77yyA
 FJeQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 18 Dec 2025 18:18:40 +0100
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

Add range initializers to the id_offs_map arrays in the mt7623 clk
driver to set unmapped IDs to -1. This prevents accidental usage of
unmapped IDs that would otherwise map to 0.

mtk_common_clk_of_xlate() checks these values for < 0 and returns
-ENOENT in that case.

A range initializer covering the entire array is used since it is less
error-prone than manually looking up the value of each macro in the
existing initializers and checking for gaps. It is placed first so that
the specific initializers override it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index eca8352d8e6..6ce1d729736 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -26,6 +26,7 @@
 
 /* apmixedsys */
 static const int pll_id_offs_map[] = {
+	[0 ... CLK_APMIXED_NR - 1]		= -1,
 	[CLK_APMIXED_ARMPLL]			= 0,
 	[CLK_APMIXED_MAINPLL]			= 1,
 	[CLK_APMIXED_UNIVPLL]			= 2,
@@ -92,6 +93,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 #define CLK_TOP_HDMITX_CLKDIG_CTS		CLK_TOP_NR
 
 static const int top_id_offs_map[CLK_TOP_NR + 1] = {
+	[0 ... CLK_TOP_NR]			= -1,
 	/* Fixed CLK */
 	[CLK_TOP_DPI]				= 0,
 	[CLK_TOP_DMPLL]				= 1,
@@ -808,6 +810,7 @@ static const struct mtk_gate infra_cgs[] = {
 
 /* pericfg */
 static const int peri_id_offs_map[] = {
+	[0 ... CLK_PERI_NR - 1]			= -1,
 	/* MUX CLK */
 	[CLK_PERI_UART0_SEL]			= 1,
 	[CLK_PERI_UART1_SEL]			= 2,

-- 
2.43.0

