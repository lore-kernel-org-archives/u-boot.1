Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B24C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D96CC60C17;
	Thu, 24 Sep 2026 19:44:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C8_sVeQGwvCy; Thu, 24 Sep 2026 19:44:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4F2FB60C0F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279044;
	b=MWvuzE82PWRzsMlDy1PbexjIOZCCe1gsyewW+WCwA4DJsqL9TL3IzWwTSaUekXSz+FHT
	 hgu2CzyWFUk/mEE0QYXPn4I7ld3nlymSRylk9xeosMSuVFpnoXgPZ8XbcvendXuX861Lc
	 Ixgk0WBwlv4mNnJ72P8HTuYZ3HvsO4yHMgTj0LhVwKLd7bQDF2VoM+60tKiq6PTa45u56
	 Qfk9Eu5HnRkKnTHVZvjN/NMasMcE+k+93/LhtUEGMDmGdAh1ERaGO/6BkVQI5sI1CTpxh
	 vjzsczah3clQ0WlVa01a6yWofXqni57vvhlLJrQizXUcX69zx+mmjQau/Mjjwr+UHKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279044;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wjJv7NjnE7WEgkk3ruBd+yPafV6aUH1n1JefKfzWcqg=;
	b=kjLlWWk7ej+vf9D0atITFFakoo2A9O3as/zqBqoz4xFa3kcaDPO8tETH/vVonjI5BQrr
	 Jb3RSVBR+2GAPQ+kikIQNOKpatlxhZ8CB9yANmM/svxwQxRDY5ENWiDdyXLo9c8+yx1LM
	 2NlrE3tCGf3iaG5hVC0JGTZllHL5WJPtKE411BaR79rg2Uz6/1XZjPrVUnz3MlarAXSbz
	 GX3emXTc++gPySfqCTatSYFSRkgQXnscUzAvM5/Etpo6dFXICwdXQhxw86EWupYp3byJR
	 dBh40vjgSSoPjiAhp7Ub2SUoqWp/8SePljqc2mnqgj3hHeWfpQ1Gg/wHZwu82o/lGKw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=drd6ZNC9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279044;
	bh=wjJv7NjnE7WEgkk3ruBd+yPafV6aUH1n1JefKfzWcqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u85eqWFREtHi+RMw0TPSn7RMhGhUGqzaUtCD7J8KVALHoAkRXmMYEHReiRdkqDBIZ
	 +Vit7OJPCJU8grM73zF+/rrLhwK4kcLpmRMSz6OlqsRRG4kkaQu26pkzPbVqexFjMB
	 NIv++vB+H+smiqmUMMeAOY7fqq5D8/IyR6wiC4NM69RsvWPTMIhkFylcD12BQDVSEM
	 eIVFcx9yWrzFomm8eIwuHTCFERDSkZhB9jaYAn5jHvQfQ0SjR5T77SDBz3PtuZZuuk
	 2jMeRbhvUsIu7bmJ/3/pparpXC/c1hZtWliGeuA+99GcBJEKlzNL52eqM8CZXpANTf
	 s9GePFgLSSFVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F2FB60C0F;
	Thu, 24 Sep 2026 19:44:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A1009332
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8ED1060BFC
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9J3lU0rPOjoF for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:43:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0787E60BCC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279037;
 b=NOdjcfYDPWyLf48ePKe4wSHG6J0qrJWCAV5/b0294ige+gvjT5CnwQ5CC9PaK272iC44
 zjSUAMjAceCYno/9GvcGgV3NSvX5cTPZ1YHSVmVSS0jO91XMte5X7h8cz/ueHUS4QX2mO
 iNYQ+Fv1KbjFP6CWsKDL4xM5QIPTV+7c54TZb+2yOiBfEsVU+F+oWPLoDf3Qa6qnXkUJZ
 Ysyplo0msu+us02UvWVo4/rkIQR1Tq6uWu5q+eV8pZLYJ8QGjRpgWLdL13uWXWwjFknBH
 jAN5/LGmrbKMSyMWVU6tVZ/Y1hkEJe2xAuj982ZVGg7n45sGIRfD2zlZxrOrzFFPn8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279037;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=wjJv7NjnE7WEgkk3ruBd+yPafV6aUH1n1JefKfzWcqg=;
 b=jUQIFxUeTMtzQ9CdKCSPRQW0r4xqmWz/bZBsVtN13keVi2N/VomksR4aDu8QQi8ORC6H
 HeYkYc/fTfciGWFcaJ3W0ZMtphq7yIUnEwzyuhRqwWbh39T7NI2UmGnMEcfiahqnSaNN/
 tJugebdB4sBQvgzRG72FbP5cj+XTTBnyXSzsqT58eQiXqYfOey+dEoD9clXXthj3+WLAS
 rNVfpn99pJ9GHT6SwY03EwnqAVcQWPcO9vp9b+1m0ClP45Rt5/m9Q7caGMedjw3K1ey4p
 H1qaF2+VsDi99+/aG3NRgMHeXv/0EcaOWj6IRd8uSw6xIqQ/ZBsTIQFZq5/x9Xxo5SQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=drd6ZNC9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=drd6ZNC9
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0787E60BCC
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:56 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b1ae6f5fc7so129067eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279035; x=1790883835;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wjJv7NjnE7WEgkk3ruBd+yPafV6aUH1n1JefKfzWcqg=;
 b=drd6ZNC9Sem4Iq87hSRRkmdkKT+ksvfjzYJ9d36hMGwCXJ40sg1R/4+5BZmZh6dVPc
 VzMks67OdZy6jhymBF9czcvRjuxXM5NwHuPSZKnYCwnhyoqWREJdj9Vxa7qwRmcfYrFo
 5Jn2CfNqAlX52Mvph2ehrhpnHNSfwDnMTmGb/2r0F1StixBe9+PYlT3SbRFwEccJpNYz
 9mkwpJ7x9I6y6iqQfm32YC8fzM4guL2n/B5st7MTuRCM+V4cYCqeWjnNDIE1nZdT9Xs6
 qZ0Nr3G2Fv7YoTHt8KQzVwBsdkhmVjx3BCOhy5GM9DixsH/PQOe2kR8ey0DBHpXdD1TR
 BLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279035; x=1790883835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wjJv7NjnE7WEgkk3ruBd+yPafV6aUH1n1JefKfzWcqg=;
 b=EN28XWL2RkHtw8aue4n2llt8p0/OwEGLSweFRDZJm81CbdrKFGum+yyG8xgd0nT6Yw
 yPf0XMYYAQxhcv5BnP93J1cFoWErBNiLrizOouWb0zx213IYjqZ2UpAkfGxZMjwNHjRL
 HVyQgKYb9YLZdLrgO0nk5lpwWlXY8Q4ruE2GTQqjU8gr3E+bBklgwpDSTzL30FPUHBtf
 xYJvd/gEBAad7PtPDz2O4YL51mklPl7SVq6Q6pdrGvIdXZZaKAMGvLqQBdNKVd9QA9Ld
 ZSwxxrmva3AOGA/ti+ryvf88pFYQ8o8WUX1v8a7Z5hdiPOwOjI4a1tMGu0Gs8OnH79sQ
 gWYw==
X-Gm-Message-State: AFuF++m5+G9F/xnoxItt3ih9+V/oj4kD9LV1hzodNq8aNXWVaGOPPfiu
 ianXppbmVg5+hs/3ya+0PAlTonF0GVeLdQqEBwWDYBANINkle45tsj9LpdjLkmrc3ec=
X-Gm-Gg: AYBFou1cqYM4DqmXmP6ofO1SDghgLrSRYI3w1mDQqjZ0vehD3DMnLA9+FbC14MyRiNr
 A1U2iZ0dEgU1Q6Ofhsa2CNz7lf0V9Zb9tn4SNBMf5uyxS4Tuo4fhlQjvt4prmxHcaseYtgREyUd
 LI6lNxAA14E5Ta8cR2gGfCOGxAihF7Q7CiIYaicQhPDLI8eJkeO1vL78J550WLsESxMkcqYpaIH
 6dNCwIgR+bmVGwvt50NyEsyaD1TR8dl8bSN6F45tjM84FGeSwQKDMqucYfWZJqoNcCzxiPAzNeJ
 4AHbUN28xRtGqPHVOUOZtTTO8zCfOakjei4cn5EHfPMFy/1m4iFauJ/OkYzF0dCH9gbMjtNK0Oi
 YD/hKptRHC5xHWVxDubYdJQ2KT6Jt/QSdX+UTw9Qf9L9LbTPCGnmZzUos3JCPwMIcAjrfvK+U81
 cCRDf/nCBB/QVvH95yrvAVf+5OiZTIcV3BWC7z1FmnsvLTWKsU6/BuH5ssX07En3c0pVlzk0rFP
 CY=
X-Received: by 2002:a4a:e847:0:b0:6ae:8a52:ffa9 with SMTP id
 006d021491bc7-6d43f2c71cemr3130060eaf.3.1790279035377; 
 Thu, 24 Sep 2026 12:43:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:43:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:46 -0500
Subject: [PATCH 08/15] clk: mediatek: mt8188: merge the apmixedsys driver
 into mt8188-clk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-8-1c3b5d8744ba@baylibre.com>
References: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
In-Reply-To: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=zghrkjMK0/mkjiArNkWZLwMMvqQWZMnfxeKDz1CfOUw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtX0xVtmVceauKbmfi32KmOU+F4AQQ9meJcZ6s
 B1pWqN2ryuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV9MRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AWoMIAIYYB5N0/SZY28eHvIaV6uHb0da69m17Bjegak7
 +r5FPG0SGQGgRjixHmIdY+CnRzwNSuAatd9FK8ecO1DIXWDdflRRibLQ0HjAw8aW5LmzfX0PFNt
 iDWb6LjNUesnYABgHkEdPdsjC1YPExNngRaL/T4ZGVhEXmbRpRM/OOr9bqG4jvHbKkl5Ig5vg9x
 eMItJoeLS+Zhlj2qbyKyvI+ulMq7CjTRGWbTa77UvLPR8LyZXhG61Js/cRRIY2Z59CbOAidcATE
 JKRnw29vg81XnKqPLfPWLcbyKFs6EFP0cm4frNDX7NuEv7BHys9uWsmEmSsLCIDsJbeAsbqkRFV
 zT84=
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

Move the apmixedsys compatible into the mt8188-clk of_match table and drop
its separate U_BOOT_DRIVER entry.

It was only kept apart because it used different clk_ops. Now that all
MediaTek clock drivers share mtk_clk_ops, its entry is identical to
mt8188-clk apart from the of_match table.

No functional change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 7db5194f0a7..5a142f66faa 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -2063,15 +2063,11 @@ MTK_GATE_CLK_TREE(mt8188_vdo0_clk_tree, vdo0_clks, ext_clock_rates);
 
 MTK_GATE_CLK_TREE(mt8188_vdo1_clk_tree, vdo1_clks, ext_clock_rates);
 
-static const struct udevice_id mt8188_apmixed_compat[] = {
+static const struct udevice_id mt8188_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8188-apmixedsys",
 		.data = (ulong)&mt8188_apmixedsys_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8188_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8188-topckgen",
 		.data = (ulong)&mt8188_topckgen_clk_tree,
@@ -2115,16 +2111,6 @@ static const struct udevice_id mt8188_clk_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mt8188_clk_apmixedsys) = {
-	.name = "mt8188-apmixedsys",
-	.id = UCLASS_CLK,
-	.of_match = mt8188_apmixed_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mt8188_clk) = {
 	.name = "mt8188-clk",
 	.id = UCLASS_CLK,

-- 
2.43.0

