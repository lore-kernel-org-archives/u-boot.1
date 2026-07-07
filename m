Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27FCC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B6684A1F;
	Tue,  7 Jul 2026 21:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Xytwu+W/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A62D984AC0; Tue,  7 Jul 2026 21:12:20 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8828884ABB
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4a0c883ac23so535046b6e.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451537; x=1784056337; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q2oNqamUbhsIUyf9fmGq6hxIgXPoAw6/qs8YCvgM9Dc=;
 b=Xytwu+W/OpJ5B42u467A06DY1dJTzV1UpQFDg/dWtvbGLpr+/uxbfSC28VbsIOYLKG
 W172pBBMV6c9uOj47Usg77aSyP077esaUDamuJb+SCz5S2t2iQjMQ8H7wjBJg9OUzzFG
 rlxCPRnO9M9gOtRb71Vrp5d2ChF31Ch3bX/lnI3l18pGb1nBOOM2NJy/DexqLBJDu05f
 QUplA6P/KnPfjZkgQszyBtNs7mBDDi8aVoU4jZeXIfy8WLf1f5SF5k5N2xjmnnlMQjEo
 5AUDcExSMZPQAZ6LdmXjtUUB1SkzoI3lXalfOEL6Sm1CHlZ6/LIvCwhtNAtbQi/S6OtR
 MZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451537; x=1784056337;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q2oNqamUbhsIUyf9fmGq6hxIgXPoAw6/qs8YCvgM9Dc=;
 b=BOaOVsC3xGgX33xaYJAldiixnhw7fxLngSK7eCrp+9e0mg+PYOUgrp/g76kNKYIBwO
 KaGOv/g449a5F9N5rpA/r90n5TrcVqMm4QIvWlU7vnUmoEa9CLLG3r6/MwiVZbUoGGP2
 vX7cETRIpciBXKLXGjbaWl06M/JiQa5BbR7ac+Uf9Kt61xVohMvdAu7rYP2xcWT9KHoJ
 EKk3Qw2SdX51wwcCeuJvw0mMGZ+Fri8CrCXrX2HCkufiKkXmg6xdIef1BGjl+I6HHXvQ
 r3CM7Wg/v5whpoMYlwQot6pkIBa1H3GWwP75TizWYw/ho7G62ONFzqKZEYGjWKBS+oRk
 2lkQ==
X-Gm-Message-State: AOJu0YzdR2AoacKfiV3BZMi8bLJV6GvP8b9p/Jtu2ZL1JjZxvtJ0KZtO
 4KsTGs5mkgjCEddxr/YOWYRl2qCx3cxgFNXaguzbTFr02Dq7U51LQtXfxnUpDatJICQ=
X-Gm-Gg: AfdE7cmp6Mv96GYlhjB/7/v485uP8Bzc8dNRgR1BomSijt5h9JYfoFMfEqG5xueIEPu
 rmKPn020RdrI9jmBOXC59b5DURWGIlT5o1VspLGSdq1RjN0xCc8lT2dSjP5VsEU8L5tFj2tOEob
 HYsir6ysdOO4HiXoxLKxKx3f2FQBDS7OR39o2AvhMJ4VYvZ8nwuQIqLNhX2eESRQQV8RWqtz5Gx
 I03Axi/r9DLdkp9K3Ck+Q81mgcU/pZ/2T9/uUxR0926PnEWpgEr95wp4zGDcBEBo5mmVkY/yTNk
 qakI8XC4QnDtflBAMmmJbftLFtCPjGzADhqWnJ8FUXd8E2MsI3kvdTIaUBkPV4CCuE5EswjAxAM
 dGGHbQHNhv9LRFBtcTPXvhp4rE/xD+D07qW4BulubZh/Te34/gFdOutvxz6xIWkOcQAqwhbit5I
 b9LKfHI8Cno/aSaQOWcg==
X-Received: by 2002:a05:6808:3a0f:b0:495:dd23:162f with SMTP id
 5614622812f47-49fdea0cbdfmr4823030b6e.35.1783451537230; 
 Tue, 07 Jul 2026 12:12:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:17 -0500
Subject: [PATCH 15/15] clk: mediatek: mt8518: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-15-283d9a55361e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=b7uSOCMMenIm+Msp2QqmJmIiT6UEZV74WPir30JoauE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU93kmu8OPLVRNUd7jM4ymtDP1dfLBrF2QSbI
 sKMQlmbER2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PdxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A5IoH/3QGwcoT+3tSS3hjFIByZp4hZNS/aYGD3B/1QG8
 6vBP+ndj5Rv+2+wJ7s10Xb7dHQTMUskXE5bFc2/3SIe13I86FMi9pRXaJ1PHUaonsoGoU5Y63Mh
 D2l8kVB6XgjnLnCNjP4EvLeZPRFlvdU15ORecJea46Ck7PSi/EDyeV2Rr8z76cLwGlr6aPPpgYS
 UvMCywe4vgnPsmE1VYY6Di2RR3WdXQVdJMPrQ+htqi+Dh3L6QBfNiuwUCemBig2FNXhBDCHqmPh
 aK5FvTM3YEnaV7kwZQrpsL9pCD+zdnsoibX6Gwc5xNw2Hfg+G2LxqS7xrfKRibm5T3pMCXkBczT
 qwos=
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

Change driver names for MediaTek mt8518 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8518.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 972d634cab7..3e6cd69976d 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1559,7 +1559,7 @@ static const struct udevice_id mt8518_topckgen_cg_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt8518_clk_apmixedsys) = {
 	.name = "mt8518-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8518_apmixed_compat,
@@ -1569,7 +1569,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt8518_clk_topckgen) = {
 	.name = "mt8518-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8518_topckgen_compat,
@@ -1579,7 +1579,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen_cg) = {
+U_BOOT_DRIVER(mt8518_clk_topckgen_cg) = {
 	.name = "mt8518-topckgen-cg",
 	.id = UCLASS_CLK,
 	.of_match = mt8518_topckgen_cg_compat,

-- 
2.43.0

