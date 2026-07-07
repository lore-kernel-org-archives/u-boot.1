Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AC2C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BE3E84AB3;
	Tue,  7 Jul 2026 21:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="K9NKvh9E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9840C84AB7; Tue,  7 Jul 2026 21:12:17 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78D3784AA5
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-446f87b6de1so2043083fac.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451534; x=1784056334; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k9V7pma3xJzeAHOY9h0sJph25xFgxstprSlXY0SAMNM=;
 b=K9NKvh9E1U3QhMLBwHU/XCb13ls1fTzRhxBS9Z8UOdO3Iu93ZDzW1MmA8Z4DJrUjaT
 S8i/yAAvl3kpXVBPOFJFF7UGsrVAFrJdtq0s88mfoG1T0PFfJaruHETdkm99DriTZY5o
 zC4x56zehjk9sg8owEqUgFMRUPIs6xkSQRDpUhmZno12Ybb4ShOIBN1LWYp9dFmHpQsg
 4O9oZxfsr6DIrzRfRkZx2VzRLkOr2i3CMR2Q4BXFQOuRHSbf0v40x6kGAjUxXTcyTBbO
 emQ1O8aFYSiZYRHJdg1aMtHoqGKi2uvK9eBfSq8UsxHE/JCxrRtx5hYKbIl/DxiIkB2C
 lVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451534; x=1784056334;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k9V7pma3xJzeAHOY9h0sJph25xFgxstprSlXY0SAMNM=;
 b=l+Y2XundSVCqpjqPd2ah6qWhwNdLOvZ8NSo5tzbvk5c7nAfuYAZBgcNcEFP4bJucAu
 JUgidapxIe4Qg9y2aypHwhWdAMNyDfDhAynkDuF5VgUR6S+lj1PgUAkpiVSWbtVQwk4N
 xsih4TZgsaP78PfeYAqgHizSB3qbpvYyWDILTT5QTtIc/8H9e9WjUFfYDzASwWwuHxFx
 myOxUGjtP6eTCVermETwKplfvgz4U5ZsNmqglZm8jlNlCCSEvHE4AmxCCdx5RRGAFrtW
 cYaO8uabdodMzl7HaDYZfr7lc046dPDX2OQ7RyN7r35BIwWEQ7S2u4LEL7uTbDkeBMCZ
 nzJg==
X-Gm-Message-State: AOJu0Yw3jFqASU0u6Lhg/u4z4Vzy+Y1jsv7F+brS0ZQhsv8gvK5+XRU8
 qU1/ozEiqDvGePIc/CcXhVlw0JlLCMdMnuavH1MEu6ZZNe87+Z0k7NKhHYo4mwN/swI=
X-Gm-Gg: AfdE7cmWE1aQaS661b8WMOMwQVF6AGIEZjByufzocDgLnmC/Kl3+P3pE5+9J8+b356p
 BJ07xjQS1dPHJJSAy1sQqP3lWHmM00TQ2Rbo9+eg47fG86l20o6ujJoxdRU3R27GuddCyL7ACPx
 y/S44YzWWiiEJ63UUqO0OQOrQFyhgqHATF9HWNABRMVkujnbwS1Sv5l3Hhu2XbpZ6lbJO2AmlDC
 aZur9NqkUqTuJszbtObyOQLMUioa6U67OwwHsen1atXJAMkI5Qapvf5r+5/VZI0wjBXI5U/FsBo
 Ka1p4mkbALwxzi+1FJpv5lyxN+zHwlmeN9XNlgraAC5SsZFHbnvhyMUG8UCNyL8oBj4JNf1Y8Ik
 hD3i9UcUaxw1GccfjRRpMrJNLdkS4686wcA+iZVwZaDp3I1DKBtt1Ebh+OWGXW48xCF6RqLAjb5
 XM08udMzw+i3+ovmmZfCjeBfn/exE5
X-Received: by 2002:a05:6808:4fe9:b0:495:f74a:4080 with SMTP id
 5614622812f47-49fdc553803mr4555944b6e.15.1783451534240; 
 Tue, 07 Jul 2026 12:12:14 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:15 -0500
Subject: [PATCH 13/15] clk: mediatek: mt8512: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-13-283d9a55361e@baylibre.com>
References: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
In-Reply-To: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1634; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=bXpuCX8COYMUSmLl+zQGJzxxqUYFb0kUONOeYeOnaJE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU9pzbWCOqnX0faQeC5A8dKMoQqTmeUyN/Au5
 WA6POe4FJOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PaRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AmbsH/jLKvAvlze46cf+EQCJDxkDG1V+ivlrKVALBEeP
 Nw7MiupzWt0THjhkehcW7bQ86BD6tMQu6lnd1iBr6m60Qckit117724uLHD9rQoWqdO3MloQrBA
 rwwZ4pv+nwwsGpOQJHrdALGe4CAd4ZeTvqLuT2wkHq9TGYZFeCvc3xeHnH0OtdQvScftUdx8EHc
 2nxvEs5PPqEvNMIB/CtFpvcPpSyfm3jKqUgU52aqDi+jA5NHjn+2UNI5rUnyA+A2P9FlmYA27je
 L7J+qFZGZqk1q/8+lZdwGMNGLCF0RA1/jKKylwOlQnZOVRnZJ1DCrs0OwxQkDRINvtRYLiJ/WqT
 KsxM=
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

Change driver names for MediaTek mt8512 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8512.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index 2b0f0a38f81..307f788cc77 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -862,7 +862,7 @@ static const struct udevice_id mt8512_infracfg_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt8512_clk_apmixedsys) = {
 	.name = "mt8512-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8512_apmixed_compat,
@@ -872,7 +872,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt8512_clk_topckgen) = {
 	.name = "mt8512-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8512_topckgen_compat,
@@ -882,7 +882,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen_cg) = {
+U_BOOT_DRIVER(mt8512_clk_topckgen_cg) = {
 	.name = "mt8512-topckgen-cg",
 	.id = UCLASS_CLK,
 	.of_match = mt8512_topckgen_cg_compat,
@@ -892,7 +892,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen_cg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_infracfg) = {
+U_BOOT_DRIVER(mt8512_clk_infracfg) = {
 	.name = "mt8512-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt8512_infracfg_compat,

-- 
2.43.0

