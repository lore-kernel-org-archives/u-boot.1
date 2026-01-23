Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18693D72362
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 09:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3277983B95;
	Fri, 23 Jan 2026 10:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lbrFJClR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 983728397D; Fri, 23 Jan 2026 10:41:16 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 399EF83B0B
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 10:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so1186141f8f.2
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 01:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769161274; x=1769766074;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t5xBUZqEnR7AKFlgECEwDcAWY9r27SBu0cB8DrXGGLg=;
 b=lbrFJClRc05CLAz01YBUipcAIbNK0o5yFReaxCwcSJpmJHnSA5BLjAZuxKwAyJxGGE
 ArPHYAwvrBP4DPAOfdgBvK5gER/k1V+Wv0fEPKd54jNQKY7APQgkpfOHqtqBpUB0ep+k
 ADEh1jsc/BJP/VqUnIovI83vReXM1JDlMri0cOf8YAlUZb1cgud/SvNVxydm7s4DtsqR
 bCRVGhgT4IEdRcdW8N1Zn0JCZjORtWgGXj/VUP9Izdpf7RkwlvGAJAfnKiYYLF1lg2v0
 tBtbr6kYpUK7KbWQ+2D093O80hP4sxlP1Eh1s0MBkRFJCuaDAQUrn9SuHib5kCmLSWlg
 ksVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769161274; x=1769766074;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t5xBUZqEnR7AKFlgECEwDcAWY9r27SBu0cB8DrXGGLg=;
 b=ZL0KkNeYvH2Fo5Lp2WyYvpw1at6PwTccbXvqMvvGM6sKAN47syfq3by0U6K14Ae1Vu
 TwmoGKGfuv01VQ6mkX5ZLlLRE5SC0Lhusj9bSXmDSH+jX6Oddw2pbkKHCpcEzdD1PJF6
 o+8I22Zu5ada9Nw3RPz0qwKZKTO9idFxKNDbtw4eNCdeA9uYnWrCunJnF7cpRXUr5TJI
 dSw3X656cDRKD9mbXTIcbn0iG+QcZ5NBS6GZUDx8sgVPVd/1lyqEUhlcG5T66I3kPpzg
 U7es/503rwyPKzEg4qxEY4ZBk0/7J24dVZQp2n1lXYgzfM64M0JA3HV5LwUyis3q3829
 tpfw==
X-Gm-Message-State: AOJu0Yy5ZyLeAoWVMFm2TlZvVPBngGvkQr3Lj/Aw0bS1jDEjFUBtlJBB
 Et0UT/goeGVmPmfo2Y4Vz1YMrzSPaAvxkjrpah8zFZgyk1zknwEPn5ykmR0vUaBzoq4=
X-Gm-Gg: AZuq6aL5GETmG00Hy6l7lYqufL2k0P1lDbT6GgaNJKCs9UC4WN/+3Qse1txSFrI9+Aw
 vB5xXWMXZ4G5mk4Cu6QRT3GmbLgoOsPyOSBX7llY18z3q8t3fhafubcCzkZ9dedI53hKIayDWHw
 V/IIWMX2QSWH59lIOJ5AXUPUW7XrrMOJulb1ccNd/iDaX20Sfc4LlQuIfBLHSoLNCXyFkOSgeTo
 CeoDNG70I2KqkST/cfd4Vh88UGp4wkP14Kze1HJOuXDB0h6XwHnZE6Vd+dEH0iu3PJAWQBRnzUP
 Z1Pv1kAmlyL0SBTCW47kSMgOpxq3ulaaaBUjkP/msgEsudNthj9u2tpJ4Nx4jeipPcpaXJFgfec
 EfNmDKE7ZlKYYTY0zVRQX6fQbIr3LH8wq8a6srzpMa+NHJrBOL04mfn0NAPrh+t5RJIgMOopUSO
 orB9yQXDx+exvsQfjZ/4rM7X0zLuCKDgSVEzijj40kPow+S8uOO7bebc7Ur8BG2odsZIM9cTGBJ
 dsTVJSkfMNU21uR8D8c
X-Received: by 2002:a05:6000:1788:b0:432:c0e6:cfc7 with SMTP id
 ffacd0b85a97d-435b92f9696mr1150743f8f.8.1769161273653; 
 Fri, 23 Jan 2026 01:41:13 -0800 (PST)
Received: from [192.168.1.60]
 (2a02-8428-e55b-1101-a95a-db72-930a-81eb.rev.sfr.net.
 [2a02:8428:e55b:1101:a95a:db72:930a:81eb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e7156dsm5147411f8f.20.2026.01.23.01.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 01:41:13 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 23 Jan 2026 10:41:12 +0100
Subject: [PATCH 4/5] clk: mediatek: mt8188: fix some clock parents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-mt8188-fix-clock-v1-4-e355352bf405@baylibre.com>
References: <20260123-mt8188-fix-clock-v1-0-e355352bf405@baylibre.com>
In-Reply-To: <20260123-mt8188-fix-clock-v1-0-e355352bf405@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Fix a number of clock parent definitions for MT8188 clocks.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index c0f68c41d6e..537aa706d4b 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -26,8 +26,6 @@
 #define CLK_TOP_CLK32K		209
 #define CLK_TOP_IMGPLL		210
 #define CLK_TOP_MSDCPLL		211
-#define CLK_TOP_ULPOSC1_CK1	212
-#define CLK_TOP_ULPOSC_CK1	213
 
 /* apmixedsys */
 #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,	\
@@ -165,21 +163,21 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_MMPLL_D6_D2, CLK_TOP_MMPLL_D6, 1, 2),
 	FACTOR0(CLK_TOP_MMPLL_D7, CLK_APMIXED_MMPLL, 1, 7),
 	FACTOR0(CLK_TOP_MMPLL_D9, CLK_APMIXED_MMPLL, 1, 9),
-	FACTOR1(CLK_TOP_TVDPLL1_D2, CLK_TOP_TVDPLL1, 1, 2),
-	FACTOR1(CLK_TOP_TVDPLL1_D4, CLK_TOP_TVDPLL1, 1, 4),
-	FACTOR1(CLK_TOP_TVDPLL1_D8, CLK_TOP_TVDPLL1, 1, 8),
-	FACTOR1(CLK_TOP_TVDPLL1_D16,  CLK_TOP_TVDPLL1, 1, 16),
-	FACTOR1(CLK_TOP_TVDPLL2_D2, CLK_TOP_TVDPLL2, 1, 2),
-	FACTOR1(CLK_TOP_TVDPLL2_D4, CLK_TOP_TVDPLL2, 1, 4),
-	FACTOR1(CLK_TOP_TVDPLL2_D8, CLK_TOP_TVDPLL2, 1, 8),
-	FACTOR1(CLK_TOP_TVDPLL2_D16, CLK_TOP_TVDPLL2, 1, 16),
+	FACTOR0(CLK_TOP_TVDPLL1_D2, CLK_APMIXED_TVDPLL1, 1, 2),
+	FACTOR0(CLK_TOP_TVDPLL1_D4, CLK_APMIXED_TVDPLL1, 1, 4),
+	FACTOR0(CLK_TOP_TVDPLL1_D8, CLK_APMIXED_TVDPLL1, 1, 8),
+	FACTOR0(CLK_TOP_TVDPLL1_D16,  CLK_APMIXED_TVDPLL1, 1, 16),
+	FACTOR0(CLK_TOP_TVDPLL2_D2, CLK_APMIXED_TVDPLL2, 1, 2),
+	FACTOR0(CLK_TOP_TVDPLL2_D4, CLK_APMIXED_TVDPLL2, 1, 4),
+	FACTOR0(CLK_TOP_TVDPLL2_D8, CLK_APMIXED_TVDPLL2, 1, 8),
+	FACTOR0(CLK_TOP_TVDPLL2_D16, CLK_APMIXED_TVDPLL2, 1, 16),
 	FACTOR0(CLK_TOP_MSDCPLL, CLK_APMIXED_MSDCPLL, 1, 1),
 	FACTOR0(CLK_TOP_MSDCPLL_D2, CLK_APMIXED_MSDCPLL, 1, 2),
 	FACTOR0(CLK_TOP_MSDCPLL_D16, CLK_APMIXED_MSDCPLL, 1, 16),
-	FACTOR1(CLK_TOP_ETHPLL_D2, CLK_TOP_ETHPLL, 1, 2),
-	FACTOR1(CLK_TOP_ETHPLL_D4, CLK_TOP_ETHPLL, 1, 4),
-	FACTOR1(CLK_TOP_ETHPLL_D8, CLK_TOP_ETHPLL, 1, 8),
-	FACTOR1(CLK_TOP_ETHPLL_D10, CLK_TOP_ETHPLL, 1, 10),
+	FACTOR0(CLK_TOP_ETHPLL_D2, CLK_APMIXED_ETHPLL, 1, 2),
+	FACTOR0(CLK_TOP_ETHPLL_D4, CLK_APMIXED_ETHPLL, 1, 4),
+	FACTOR0(CLK_TOP_ETHPLL_D8, CLK_APMIXED_ETHPLL, 1, 8),
+	FACTOR0(CLK_TOP_ETHPLL_D10, CLK_APMIXED_ETHPLL, 1, 10),
 	FACTOR0(CLK_TOP_ADSPPLL_D2, CLK_APMIXED_ADSPPLL, 1, 2),
 	FACTOR0(CLK_TOP_ADSPPLL_D4, CLK_APMIXED_ADSPPLL, 1, 4),
 	FACTOR0(CLK_TOP_ADSPPLL_D8, CLK_APMIXED_ADSPPLL, 1, 8),
@@ -859,7 +857,7 @@ static const int adsp_parents[] = {
 	CLK_TOP_UNIVPLL_D4_D4,
 	CLK_TOP_UNIVPLL_D4,
 	CLK_TOP_ULPOSC1_D2,
-	CLK_TOP_ULPOSC1_CK1,
+	CLK_TOP_ULPOSC1,
 	CLK_TOP_ADSPPLL,
 	CLK_TOP_ADSPPLL_D2,
 	CLK_TOP_ADSPPLL_D4,
@@ -876,7 +874,7 @@ static const int audio_local_bus_parents[] = {
 	CLK_TOP_MAINPLL_D7,
 	CLK_TOP_MAINPLL_D4,
 	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_ULPOSC1_CK1,
+	CLK_TOP_ULPOSC1,
 	CLK_TOP_ULPOSC1_D4,
 	CLK_TOP_ULPOSC1_D2
 };
@@ -1015,7 +1013,7 @@ static const int spinor_parents[] = {
 };
 
 static const int ulposc_parents[] = {
-	CLK_TOP_ULPOSC_CK1,
+	CLK_TOP_ULPOSC1,
 	CLK_TOP_ETHPLL_D2,
 	CLK_TOP_MAINPLL_D4_D2,
 	CLK_TOP_ETHPLL_D10
@@ -1356,8 +1354,6 @@ static const int mt8188_id_offs_map[] = {
 	8, /* CLK_TOP_CLK32K */
 	-1, /* CLK_TOP_IMGPLL */
 	72, /* CLK_TOP_MSDCPLL */
-	-1, /* CLK_TOP_ULPOSC1_CK1 */
-	-1, /* CLK_TOP_ULPOSC_CK1 */
 };
 
 static const struct mtk_gate_regs top0_cg_regs = {

-- 
2.52.0

