Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4048AC44503
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B3284A77;
	Tue,  7 Jul 2026 17:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="G8XHl7j5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7DD584A8F; Tue,  7 Jul 2026 17:10:44 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFD3B84A75
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e6128bd9b3so1958809a34.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437041; x=1784041841; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tdjUtBKoJ2mAgf1uOU7hwJYbTuQziwCQ8fUVRgbs/7c=;
 b=G8XHl7j5W8/eAagmXghwaHZ6H5uoPtIGMbxlf9L/RqBaG3q5dpYLEboJ1s67h65BXB
 2QcId2hS9FPNbd2GADrRuV/R78PlFhwIvwFF7wp7KxLeWjoHr3RpnSoUFbpZgO1ATYXU
 L9FjlrPjfO0tKhIOSg5yuZASpyhb2Er/7/f2Ru5wMNG7/+DpCQkHgMHDLul6l1tpQL+J
 uqBbNZuIJa48HAdHeSx709jpAUn3N7rtBFeMpeomTXMjmIs4KWTZeXWOtQp/ol+YBuoP
 8mt/2vLcRWcIZC18lpjsu9U7dBwuPr0rPVRDxKl9PfZETH7HnDjO4vzK9gt+0dSXs1Hu
 Ni6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437041; x=1784041841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tdjUtBKoJ2mAgf1uOU7hwJYbTuQziwCQ8fUVRgbs/7c=;
 b=G89ZAfgpECJylA4u3xPNuQnFAxOyWxBBVl+cDY2zHgeWhuIJLluuJPatsmxe8x607L
 OWK7FusdH+EH0adXvqJ84yrdjtxHlEcUifj16nWlzeUi5oUDZIpp3u6BMsnK675X2zZ5
 I4Po38qAt6PRDZql6X42kKmtDxFFu3PSsR6se0OxgnsF+dfYOPDJTJPF6JGmvSectk4q
 KoWC90Ad70NBafgDrWP6HazKYHaHVqmj2sq4xIlpj5f2Zhh6hHlMI3U3Sf0JQoELaC2R
 axXtyne2TZn2BHyGwFbiMXc0EbDmGw0ZN72Uw9kaohptJhej8eHGA242WWaCS4DB66ri
 n9RQ==
X-Gm-Message-State: AOJu0YxAenS5iiI7ILG67fPzwLGAmwFaiqDWZX97BCh1qt4juoc/JTf2
 iDrkDarH6n4eYnFW0gXXMEdsq0Am2waVK99PCL+AYgNSCEq39OU/h6UK7txh8BUOkZs=
X-Gm-Gg: AfdE7clysUinpdR6XtKwZA+P8MZqq3E19JMVs24uJBdJFRxMfGT12BF4XMXSz3KTbRz
 rerMTcZszMqhyxS3w4hhpZVfWD5mU35T+CQcz4jt49a3teD4ybLEqv1TK2Tgi4tfGG9V+vb6wwT
 9JLAj3+3Bz3UMFObKAfl6cWXpja6NC0D8kk9IIk+u1ALopEx6bCT+XJbLxEBWKqSl77d4If4vFD
 WXXaTxB+kt/Zm7PB81L+/4tptUXbH02Pl5Lj4sQ0BIO6uGF8gXyYKKNMKCdxMj8V7GpRg/3bGYs
 J7k1/IZT71I8xmaknqujLm/cAfxqjYw+HlUCZe/fhFumb6Lqx8ng1DR6khNdyfD2Uv2LBIl4wQC
 XAKGyAb5FoM7PQgt6g9UpnJ6KAky0WvUVBrZ9uuI3BuEJrhBRHINjMV47fOxVmLgvs1N5IJzUpn
 PJbSijwtrtMm7npHzaBw==
X-Received: by 2002:a05:6820:16a1:b0:6a1:87f0:b939 with SMTP id
 006d021491bc7-6a3556c4f11mr3810276eaf.71.1783437041398; 
 Tue, 07 Jul 2026 08:10:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:33 -0500
Subject: [PATCH 13/24] clk: mediaTek: mt8195: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-13-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Q+bLAdyEDm7m2+35CscHpYBZnK2uDLMFdxTiRGZ7msk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRaHfa2d0sc0iasoJIxzneA4EnxWwnOLnFLMV
 4G6nH8/3J6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WhxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A/Y4H/jAz66D7QqE/Y6rfpSKBUoKKZmfkQvcZj4/Cn2o
 PYtLGTz0P9TlLVWIHL2oaU/lwa558XpW/0H+us9z/UiG04JBnfJqTd8JDkoiAPQuwBm1SeWLSCJ
 WN5G6x1tYFgr3FGtsuZzes7B9BpYICp1+eLE8Qv62dgaD0mryhZxUlpRorTMIrz0vBm11DWCc16
 lGSD/jn0i37y/4rqfRy2p4L1ynU6rsNdmDsqPAA3CVMB1rrp/p+EzQZkvVW9HYU2samaR0rkVCE
 CKLlMthLW4Jsw9AuDZfdRUA+P/ZGvf1bpRM19y3FVxT+jp3OUAbHMyMtCDKSkLfJX1ojjNK5D33
 CdMA=
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

Add clock tree type flags to the mt8195 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8195.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index 37cceb5f32b..8763c837781 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -101,6 +101,7 @@ static const struct mtk_clk_tree mt8195_apmixedsys_clk_tree = {
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 #define FIXED_CLK0(_id, _rate)	\
@@ -1423,6 +1424,7 @@ static const struct mtk_clk_tree mt8195_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
 	.num_gates = ARRAY_SIZE(top_cg_clks),
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_gate_regs infra_ao0_cg_regs = {

-- 
2.43.0

