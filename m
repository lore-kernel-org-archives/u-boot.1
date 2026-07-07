Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED141C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D885A84AC0;
	Tue,  7 Jul 2026 21:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="jodCDfkv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD3384AC0; Tue,  7 Jul 2026 21:12:18 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7473B84AA8
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-491bc1d4e6bso3224685b6e.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451535; x=1784056335; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hf7kqwSf9jjhZn34k4EfqRdBkZLFdjpmLapsf8wyH2c=;
 b=jodCDfkv4KCt+JA+gERqQDWRJZ491X8cuRq7sAxzvTAqE+agyfnMM95XAX5yHydr3+
 D+51doDIcgVOjZORex2Q4G6dEi9pi5Q3eznzMrpEDm3ca3Wt2TPOqhB4aUN1njcjClTP
 c959QdnBD4Sz3bIVRAgLa9RlA9o46cyZOCVDEDCaQVQz9h+5Twe/MIHZxZ2IovpTvurm
 JV1brd3fZHYHncDURdyHnUopS8TRtrkFUs3eA+x0kRBqvPXeo6RE2CrIrzt5SL9Fx3/e
 PlLq5EnvYDiFnoE/nXMntGtkcV+b57k3yz48vnYmVEnuoSuO/guwHEyodg/siYceODYj
 pp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451535; x=1784056335;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hf7kqwSf9jjhZn34k4EfqRdBkZLFdjpmLapsf8wyH2c=;
 b=l94ndWy5aU1UIMcergdwHExe5OofumnmguhCxaFfISEd6jXIAaZNeg67heq4DVatf6
 zBTn9Ybp1PrZ5AEkCKi3c//n8tXgtT4Q5rrZEyHYrx+bRvzgzRTNkAmAUpBPIkZ35eXD
 OEOP7tYkyyY1NX3BZaKQDvQL59zId7jYpnpxGaMHVeuJXuAkBIncOkRAzEHS3Nf7AmoT
 H6zHctS49ckiReeAioefoQ4X9BzFRx+z9b3zsUPqwoPIl/pnOIN6Td4sqpGowuu5Zt0W
 YvqXCDrGQ4sO8cCLNvAuXG+3kBUsDOnl+sll3DGLl7NZM9JTZVAK7KtXT0lCc7n/0fEj
 k1Zg==
X-Gm-Message-State: AOJu0Yz0wVtU1mcqbsnpbfogHSaHC1uqz56YU0f6/Thn41kNe9I8MJdl
 B1YNO3p1hty6gSZdAAryf4MosOmKRZrvI+42Hb52auNKoIrcUmW/M87dyApBe+zS3kY=
X-Gm-Gg: AfdE7ck3nnIhswWhJt56X5p7iu7fBT1jmqcCNLWuAVtRhB66nhxrvD7s9Iv0TJefEFZ
 +hrXFLVMxdGoxbwPsrN635siQ14P70nObk50J6/BFHgFVQo3XayFkhvoygcDkfi3GIjDzfHXBZa
 Qf1ewGODFg27RzuCLl6fm2IsUshOQxHla0e8b+J/yPON2Vpsory1CUIC/nO+sC953qooBBkVKdL
 LQIkBF9DWAp/1BNqiijgUUpbQ+m9vFAIxtXNV1FFYBq9Ja5OVMh6MXI9EE0ZsmrwbxskSd2k1A3
 /PsOSC1yjy/2PB3poDyuPNfmfP6CXB37pEztKZ5le/Ee+KDrP4diCJw39S1nRAM7qf/J7ZpKeyh
 fCPqyZx65LrXANyCKAyzvLfmfefE17X8MeOfz2Z4e1gbZZeB26gPW6/uC15db6OP+AqO4dP+Zu5
 j4I15BEGLvqA7G7LdA6w==
X-Received: by 2002:a05:6808:6d91:b0:49a:72a:4e60 with SMTP id
 5614622812f47-49fde6e902dmr4941003b6e.29.1783451535214; 
 Tue, 07 Jul 2026 12:12:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:16 -0500
Subject: [PATCH 14/15] clk: mediatek: mt8516: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-14-283d9a55361e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=kYXzO0KAwPUihpTQzomwycVQ6tiw696lHjft6EY+D78=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU9wYW7H6KURZpPI2UETvf4e8tlhqEm9DDdkL
 t4jAJRiSBqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PcBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AD5AH/irPWqpULLJVFQrc9Sg/7jW8tfBOlt3nNEmdvSh
 avQMckMGrUvuFuEBZskzbMr4HYl2NzS2c+bj1QsBYKCxCUqwF27mbFT2IAVPh0ByE0V5RFcodU2
 hrdmnp1dDrgayP0KHTeg3bosxbdU0Ko2GmbgG8z27y0YLOaMlK+OoNrdi0uxy4aUXYMSdxoUSAL
 OKbSiQDwxRb30bydwMpkXKMsTmyZxEtzUUTbpiWtIMcfYi7KJSIVIAfkZMAU2ALqJ6vq4gl54HT
 Yx+IOly0U7SBhEm7DECVdmDBtSblCk9rC9qr5wJhAr1FkTFPxwWD/+z0VmgFhe9bY/72qqX6u84
 t6Z4=
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

Change driver names for MediaTek mt8516 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8516/init.c | 2 +-
 drivers/clk/mediatek/clk-mt8516.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8516/init.c b/arch/arm/mach-mediatek/mt8516/init.c
index b470910da7f..d9fe8fc8505 100644
--- a/arch/arm/mach-mediatek/mt8516/init.c
+++ b/arch/arm/mach-mediatek/mt8516/init.c
@@ -44,7 +44,7 @@ static int mtk_pll_early_init(void)
 	int ret, i;
 
 	ret = uclass_get_device_by_driver(UCLASS_CLK,
-			DM_DRIVER_GET(mtk_clk_apmixedsys), &dev);
+			DM_DRIVER_GET(mt8516_clk_apmixedsys), &dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 0aa35a69b47..6bec600a331 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -803,7 +803,7 @@ static const struct udevice_id mt8516_topckgen_cg_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt8516_clk_apmixedsys) = {
 	.name = "mt8516-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8516_apmixed_compat,
@@ -813,7 +813,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt8516_clk_topckgen) = {
 	.name = "mt8516-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8516_topckgen_compat,
@@ -823,7 +823,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen_cg) = {
+U_BOOT_DRIVER(mt8516_clk_topckgen_cg) = {
 	.name = "mt8516-topckgen-cg",
 	.id = UCLASS_CLK,
 	.of_match = mt8516_topckgen_cg_compat,

-- 
2.43.0

