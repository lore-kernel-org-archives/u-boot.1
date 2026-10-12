Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB20CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 21:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C00A4605E7;
	Mon, 12 Oct 2026 21:16:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5SjPbbgvclsH; Mon, 12 Oct 2026 21:16:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EC78760600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791839802;
	b=UQowPdTZIe1Daw4nGShIVBo0hcemVAEI8aoMxFNzZ1qyRpnK0kuHUQz6POF9sxFY2+cp
	 HtsmkRswLjaTyj3fgIa3HcbV6aTGSRDR4gp1jz5TnJ5D2AKc2XgjkDnXuLXwO4NPsK+HR
	 z88GrhiYFlL4AxxRGU5cG9v+Xl4aZZeLIpgD0wwV4zWcHw0G0X3TZ8iGJ8vJHs3V+/aoY
	 c5ViartQg3his61AcUcXeH6lav5AhbuG17JveG6EJMn9UT8mtoOiTZ11uCsFcUOUXn/P5
	 gZaNViyaULji/0+1Q9GBOqqac9pkXl+FH52f+Yr1MPj+mD01u6vCmkd74GyuWW+2aJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791839802;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Iupcyhmv82Zgr8eukBI9oq6BrTYkRWQRY+AK2+Uw27M=;
	b=FJaVXPvLEdSRslidJTFZBH+EKVi1/TalTF5xRn5VFAVzjuI+QYCeQlP1xDhwytnN54gL
	 dmTAOv98Hx9UcBkulDq/oJJxWvpQjno49kfbBiW6e9jWlp4h2MYmN9j3v2V0deHtvwT92
	 7vLWZmOqXDYoxitzhVDNO5me4kQX5wwXf9el4WCv60Zu8fc6In4ZzF/4AqGjbFzPDrABl
	 LHLteVh9CYYdhOVywTThVBbMX9fflRVaaVJTeJ5zPMKwtW/OLYHUib9xnIeVBR2DQefmu
	 yXgEwWuQEdK5K5XQJJWF31z0VoV/QXopHqmypSUsmQvDqZtmDiss5FavqKm2JZI12sw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=eOYRg9nS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791839802;
	bh=Iupcyhmv82Zgr8eukBI9oq6BrTYkRWQRY+AK2+Uw27M=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Eib/ZgI67wmdET3hAl/D/Z8rvl+clUC1yrVTpMezbSYblxX6+NzABmG8CJgH8pWqo
	 Khu/DXcg9ivobSbS1/KwTc1Znr9Za0+yeZq1VjLL9oEzUBdo1GRPO6S0s4nXPbG69e
	 gcJf26sUerGyUDDk4fKDMRFBXuuRrTXHs7t3QLqMPtkYQlf1Tko4kKqXNbJ3sR46N2
	 hYpH9XlpsEQsPHmolDI3MuRM3/rlB4fzMuIR32TY00pcZTuGPANSV7iAsd4SLinSeN
	 ihbL3Usuwc2P1S4JuCWWdJfZZNz800RG2hfuHkqAk1K4a71mKzFoOE565EkKorQ+cc
	 mYRoKa2jiebDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC78760600;
	Mon, 12 Oct 2026 21:16:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 955E52A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 86D18605E7
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pR2V-RwQMMbb for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 21:16:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 17A8060600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b12e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791839800;
 b=HmbgDj3R8M14sbHXmwEa3zz/EfR7pwLzI9WzfH8kIB6dR1pwEnPTTPBUzVphyFIWhCeG
 kwUAV5VrKq9LVbwQyomBkGF/R1XsObdY5widf8Y8eZJvSVeUwhFhAnPrmFEVPtOM+MslI
 YbCXGvxPBTSfE+ps9VNlE6K8jEIkDBCbl35M6Psn1CZzCsA0dcK9l8lzUf9qByUk/KLK2
 Zs1IsHKMxO/d0sO0icJbU91zSWaDlgj/hGa9C+BEYin92SsyAkHsbGS6zSOkXuZe9HUIX
 b1uXwEVbI4a8+D2c+zZOjlqPGyQYnLNTJ5UY0eZJuGkCT+lDDm+sjPWXDiiv0sgEEwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791839800;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=Iupcyhmv82Zgr8eukBI9oq6BrTYkRWQRY+AK2+Uw27M=;
 b=kF/GsXxZQ9uERkR04ab8PugKNOzjdm2yMVf0UKNT12PHgLp0jrSS3t1iDo4woWUmNiLE
 Z7clUdhnW0+lx7S+2rryPMcisXCeSf0xCNa8dGUvA+AFP1pMM+sAy0UxHNB5wDxGT+480
 4OhjdM1ILm84P4A2HSpTnd/CB8oaNjixi/pZhZ8Annx9egTg7Ls1AZdN0h7uipqxwdvrs
 9iN4lGIebQ3kkXxfZbUuYl+WFJetpZ02mvFc8sKghcou3z7X3OHqdDIpXlVCsKLtMlYTA
 K6zqprqjWAKq6p0HM1PpIgJGm3w6dMxuoGST195WrEnjqVvA72oHlijOP1slOCu3Vnw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eOYRg9nS; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b12e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=eOYRg9nS
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 17A8060600
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:16:39 +0000 (UTC)
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-677ad9083feso1591194d50.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791839798; x=1792444598;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Iupcyhmv82Zgr8eukBI9oq6BrTYkRWQRY+AK2+Uw27M=;
 b=eOYRg9nSmfcuqsQDYNU01fJAQtsXlQg/MAk5hwzUkmzbLXY9HDkU1D/03n0iY8ow0p
 T2N6B378TZS7ufKwBJ3Op+T109F8ia6iMO0KuVcH4sblAydr/sLaltmhtqMHOZLEjdAz
 02RO0advfCaHIbIKJIGoc7qbh9J+IMpvWX1C1VgExMFVibj4Q+Agg5iz+XcbJVlPxucz
 kAjDDiu3iucJxD1P/oNq5XRb0SKqKuWWPSqh8FAhkrwKba/Ff3wGAjey6+67lNX8/iYH
 8nFs3xkT929sEKeELfu5TmfM9gC39mwrQztIVU5536O2KuVIPyRCfDDxCo6h5O3Topjw
 MktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791839798; x=1792444598;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Iupcyhmv82Zgr8eukBI9oq6BrTYkRWQRY+AK2+Uw27M=;
 b=ynG334/fGg83mJQtaPYDuoTCQo/gZjxU+2K6wmGZznseBOCVyY/jSF9XPHJgLVnKic
 Ygz3q1MA+082HKMUkf/8G01E2wFudIcdTx2JE1ZCvqj2GtTGX3ATnhjUAVLB1sVHN4Rx
 2o3UuNFj2XAksA+mR9pNgofOG+4QdqryEH6TyoYH0Gbnqwt7JHGIBZTIwIaXEnMp0bfp
 ys8/TpMxyL3/J5nAwvWWilxsI68Y1CQdaec0rNsgt0sUhnTh6VyRT/vBEHs9grfB2dUp
 updcG2hEf1REMWAA3WzFi51S0LQvpricq1TlTz9T0VGXq+M69w3zl4+qSo6Ycggx4G40
 MuDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8Dxa+cwIi4Ybpx0cxFOHv9yI8slEDxwLbSC/kI3TDr3KKl1O6hEyf9RqCfSZHT+Q0ynbMrAo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL/NgcuG8xrZUYV6x2L4v5e08KNeanK1U+puM0y6VKt1/BSLB0T
 Emdp4LQNXf6Dw78OMVOmnUwrEmVWhmajoqcRy1NWsv/HWdfVzPcoR1Z6UmtdUf4UNmc=
X-Gm-Gg: AYBFou0uuJm8ot7NH/N9Z7JQBooHhMkYxUA7dSqjZBELyp6YEAF+56hhrid70Amvl8E
 EsDIHXoAcW5dztwXh+Ad2legLNDpRbYHum1xltAvO3X/JkDqcjtjz/rbUmlO8ZD283bzExWBkbq
 A8Vm9XCh7K1CZRd77EwdOUiXWRZ9jo+/mUB3Hsh/BJNDfkZgLkZwOH/WOI3VIg5YnTZI1nWtGVf
 1/Nh3oQV3Cp64XSXGSzW/FjeJPXW/KupXXu3saPRvedG4ceujAWU366IJP/Q1AJ3Oha/y8axkTq
 B5ohfBSysQDKltyV23TECmArru51H3hzrZMrhGx+VrnMn0FF4QVM6GyHB1/JYJntlYOrDpPGSiG
 SoTlatpLTf3p1/7iDji7fze8ocLw+EjkaOpWjVhR4TrEQEouwEZIGEf1sNcgSB1SMnaG1U8xiqr
 k2kzfzALNi8ZpCI7+pEuv7+HgM/C3yrhlZ+5IILFrjQAsiii2aaZuOiQnGd6hdgpOivsaVIUKQ7
 Bg=
X-Received: by 2002:a05:690e:1443:b0:675:4b2e:4311 with SMTP id
 956f58d0204a3-67936952dddmr4230339d50.33.1791839798015; 
 Mon, 12 Oct 2026 14:16:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:926f:d0ec:bfa4:a539])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6793570cfe3sm4012714d50.25.2026.10.12.14.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:16:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 12 Oct 2026 16:16:27 -0500
Subject: [PATCH] clk: mediatek: drop unused fdivs_offs from apmixed trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-clk-mediatek-apmixed-fdivs-offs-v1-1-f366cc5dd0d7@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXN3QrCMAyG4VsZOTbQlimyWxEPsjbRuF+abQhj9
 26Hhw98vN8OxlnZoKl2yLyp6TQW+EsF8U3ji1FTMQQXbt75gLHvcOCktHCHNA/65YSSdDOcRAw
 p0r2+km/FEZTKnFnK5nx4PP+2tf1wXM4sHMcP3Q/tDIMAAAA=
X-Change-ID: 20261012-clk-mediatek-apmixed-fdivs-offs-aca845a1bf0a
To: Lukasz Majewski <lukma@nabladev.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.u-boot-project.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2664; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=wEjpq9/pGYf6bfICm72BWlU6GfaP2Z2d1+HIWpLyj4s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqzU4tce7G7WSHf3Trsp+ZiIWyk24eTfFgpl8sn
 swuSkR5JD2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCas1OLRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ArpsH/RgJCl9dbnksmqXvL19bSnwhboTrS8xAMhhv3Zl
 tPtueCwur/4apYiVLCfsFev859ew4+pxpRJNqB2qzwcvzcZK6nvX1O7YhPTE0bStona9dJ8tBAe
 c0abjnN4rXraJQzuu4WQLd2aYUdMRPNc/vCWJF+SrSkGnenCdBFAWQlhd8Ec7wzjmAvm3V1khoV
 keUJA61PS6gQAgz0jTgPWOy8eMuc6eexbQiu5p73f9640zMEgcwUsxisd5B+XoeZTNsv6pPTdL7
 O532ofL7JKHgEYapG4KxZKegQlZc2f1W/tPl7oAvXQUpbheGyh+iKWWrVKNQS7SzkLyMvY2Hlz+
 1fuY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Remove .fdivs_offs from the fixed PLL clock trees for MT7981, MT7987
and MT7988. These trees have no .fdivs table, and mtk_clk_id_is_fdiv()
checks tree->fdivs before looking at the offset, so the value is never
used.

The offset used to mark where the fixed clocks ended, so it was needed
for these trees until commit d09876c4f6ac ("clk: mediatek: add
mtk_clk_id_is_* helper functions") replaced the ID range checks.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 1 -
 drivers/clk/mediatek/clk-mt7987.c | 1 -
 drivers/clk/mediatek/clk-mt7988.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 6d5c967ea78..89be561432a 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -619,7 +619,6 @@ static const struct mtk_gate infracfg_gates[] = {
 static const struct mtk_clk_tree mt7981_fixed_pll_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.fdivs_offs = CLK_APMIXED_NR_CLK,
 	.fclks = fixed_pll_clks,
 	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
 	.type = MTK_CLK_TREE_APMIXED,
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 831fa7177a7..3cf008f420a 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -56,7 +56,6 @@ static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
 static const struct mtk_clk_tree mt7987_fixed_pll_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.fdivs_offs = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.fclks = apmixedsys_mtk_plls,
 	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_PARENT_APMIXED,
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 797274c59ca..3adea0cd9e1 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -804,7 +804,6 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 static const struct mtk_clk_tree mt7988_fixed_pll_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.fdivs_offs = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.fclks = apmixedsys_mtk_plls,
 	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_PARENT_APMIXED,

---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
change-id: 20261012-clk-mediatek-apmixed-fdivs-offs-aca845a1bf0a

Best regards,
--  
David Lechner <dlechner@baylibre.com>

