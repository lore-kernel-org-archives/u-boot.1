Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF81C43602
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C52F284A6F;
	Tue,  7 Jul 2026 17:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="JH83mCRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 112168496E; Tue,  7 Jul 2026 17:10:46 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDCCE84A77
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-69ec2ebec61so3056899eaf.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437043; x=1784041843; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V04scixZkv+kB0PjTVoPdfTO4q+Jy394tUN2MjsZo4c=;
 b=JH83mCRNldu1aGd9Mg2CS5WEUqdZs1kDQK8g6gqB0yj6bi+399dan7971WCoeARvSi
 Rn3jCdH7VYCuKb3TLVTD0fn6DoNs5loe+CkjVZl7ibexFE1+2bZwie3lBWy4O0ITMEOM
 DB8Kg7GDpJFdNJZWOnpR40DChnW4Cr2OSvcgqthZrx8+YrRSWkTjUJ8oua1xxLe0sxgs
 jcpcJCtpaljP6TmeaYgbndV+LD9GeQYXTfi9d1PCeH0CCDJJz2YvSHwpdvOdWeqOq1Ni
 /5fzZGqlEv9hZlR2afm4oPo0BQ8vgsIvGPMdGT1xt0VBx99LjYUhfLLotw7DfF/j7XTH
 BGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437043; x=1784041843;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V04scixZkv+kB0PjTVoPdfTO4q+Jy394tUN2MjsZo4c=;
 b=kerW1QiEkfV1+TVS9dtX1hRvtBZ7Xdek+HXlZOmuEpamaKgXBLhdHNWPGb33BORwnb
 Fyig4QGY2zl5RVIAsp8tuErmQ82JVeNgK37WIGgSMV3UAhpCwqtJK2pX4ZsHPN2H7y9d
 1ILLeiSudJI/7cPEc2UMkutKFAVGjEbBChUKDvmK7ZEq3Y/xXS7gvbakhP/vN5iRvGrU
 uhuXqdiUaoTXGiagdeztlsMliCIQEk+MzXQSo8Qsigg31KmwaBO/+B+3cYPhymBcPKrG
 uiNylXs4KB2DsOhZQkT2tdUrohPAfYHocmJ7gPRXPQtPCMBR2Sbad0JxpGfUNL89D71w
 fuCg==
X-Gm-Message-State: AOJu0YxJNtlnX3xnyOhdB+PLmRa48i0wdzpHTnSNZTy4CykNne3BVAk8
 vSPgJ/mb1KCMCuOeIayZ2zWWwsYxC733JDOims9HlfmtQHoMk+39r6Me+6e9bMSs4/I=
X-Gm-Gg: AfdE7cmXQat+LoO75EcfWSalOulds0Qr9j60HC5POEPGwPZt8gcIHsTUKIByKd/97ik
 7Hffq3kPEFOMBLARXXy3p8GALWLxNhfJYwmg7R7mKscbDefDGlpyixgewqZ65srOapZmUIebP/B
 +6UiPZGosjWcI5Q1f8PvQuGUu0+nca26wRa9T++UkF/ae1wHeZ40QGaramVmmTMFexEMDL5lFtj
 iM3FJJufRSHb+Xna48UWkaRoP7KPNltz5zVDA+tfjvuyykgyrYXhoV0VuHbRyvXJp0La9py6eNm
 CGhyv3XApWTkgaBr7NbAZWe0SV+gdnjBdJvkzIarPNHK2kJNBCCnz/pR1iD3Gr39W6qV3l4iSKY
 0397fsfZ0un/AIUTiJ50fG6qZTKewwcN27Y0NUuj3N0YhL88K4ptkgZkH0LLmyPyknzje5OFCoL
 Qshoq/XXXuRJzQ0waOhA==
X-Received: by 2002:a05:6820:2012:b0:6a3:ce0:a34d with SMTP id
 006d021491bc7-6a3556d60d9mr3570257eaf.54.1783437042628; 
 Tue, 07 Jul 2026 08:10:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:34 -0500
Subject: [PATCH 14/24] clk: mediaTek: mt8365: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-14-65d24cc0d569@baylibre.com>
References: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
In-Reply-To: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=DZcm0A3p2kA1m3RhGV96jfyYfygnvCnKp8tNDhYRqYU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRaO2bczTLiKX9G59zI1ATAxuz6/G9lXJg4Yh
 FWnPhXcZJSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WjhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AGS4H/iKxdLJfSoo0x0XSaCL3LFtDyfy9lDccU2s3rhQ
 Bq0mFqGkbFrah6AKlaKUGPMLnYRkE0uMqdyCEeqq/CAT75MI0xWmWu98iNF134S2WjnFLvJPthD
 NyQEZfubhQ33V8IyCTkzVH2EObQ8df/OLB22KNNrclUtd+FozG34+ISP8GlrQ87E1mz40XfU396
 zaY0RQcaDOOnLzyO2bGtkhAn2l0LFposOACpV/oIf8pTuPJFhaAFww9nyzQB4JAQvOYOCVdU5/W
 nuldv3NUE/GR7AOlqUAhjlXWrjWaUF1o4oSVGABDgvCvJdw4IqmApHhHS3f7TmexT7OymWzjpzr
 CGBI=
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

Add clock tree type flags to the mt8365 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index eb94b86622c..1882ff9d6cd 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -79,6 +79,7 @@ static const struct mtk_clk_tree mt8365_apmixed_tree = {
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 /* topckgen */
@@ -595,6 +596,7 @@ static const struct mtk_clk_tree mt8365_topckgen_tree = {
 	.num_fdivs = ARRAY_SIZE(top_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
 	.num_gates = ARRAY_SIZE(top_clk_gates),
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 /* infracfg */

-- 
2.43.0

