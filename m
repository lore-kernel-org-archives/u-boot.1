Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563DF10F2865
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 19:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36CEE83FD9;
	Fri, 27 Mar 2026 20:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="267Ehxeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C92B83C14; Fri, 27 Mar 2026 20:03:52 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF12783EB3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 20:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4042fe53946so965257fac.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774638228; x=1775243028;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1PuFrm88F4R3XZrJQlt7jinlLT88VcNhGpSaYO05K0M=;
 b=267EhxeqqGN8wSkKESftoMmg1XtIZstTuMht4zn1d/Inxcuj6zWPTFJuRJ5SuRuhKd
 k4d5JbE19yrgJdwiYBTsy3ciq8NrUW/yeJE0/3Yb1fJ9GT2X7LR3lh9xkbGBQuExBRFV
 xjJR30Vk5MwQiKxrL0OeNAi7RCbI6VkCU9WuzDPFuO8REWUGIf5LoLD8er8QkhfJFqa+
 RIU6PPKB3q0kPbEvbf01ofrzbkjEj3kH0FSO9JNfJxoB3w4denk6wGjb2o+gvIDKIHnP
 z7kiIwrxeax4A/2rJnElh6LCSTkCwDbeTeWeXKZe8u1EGhiM7SX6GrO2Y7w9ARcmg2kR
 rQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774638228; x=1775243028;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1PuFrm88F4R3XZrJQlt7jinlLT88VcNhGpSaYO05K0M=;
 b=kodZzPx1utwqgtuF8BKcnMjfXWnPDWPm1YtUmpskzg9vajyOON9TDxbE7CYEd6swiT
 13neqNRDEClkbFw/oJhHOU+5k0UIll8QOCKNEVM8fymaOPz7gcdg572s6JPC72aza0kM
 ryBbljhGNrUGyYZgMpGF4S9gWkfGDXhh3qqirJKUlTGAEnyhr8FWx779h818GJ/ai/O8
 DCMdPwFyPcx7SivdrU475II7iQa+H389KefvnjP6CIFMLiKZbl034hl9a1x45KrLD8di
 e3HKmCADuOfijv1ZcMps9TyY5aXXOTpHLRfYrxAaZ2WwlUMVp/Juia5ZFy2Lyxu43yh4
 7OJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw8XlViXOa4xeNIEuGwCXUMitFg7I6RWVBjqOi7QFPyn0jSVZn+uM77p9tS/R19vJR5LMIeXQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwY0aSiXyd/P0hdVM+kCzh/r4/L1WyNyPLLHUWCTdtiX0wNH+y4
 oABKShaSuL8nOlWUPpQCX0verTme64JmVSPp25dKM1RGW9CGxd7bxsbg/NAWt/Vwz/Q=
X-Gm-Gg: ATEYQzxwsyT6F/KMqP0slDGF8EbxKdjswL65S219OmMRTNzCc/U9sDgG5xJ5+3vacp/
 4nNPrPsTpvdxQ+pQNnL2bxlQkg1OSHWuM5mwYTninp5SGie72oeZ/ZJcBEQD8iCjzAq403/PHrk
 G5yemwfc/gQ+t9OpbqMOXM7TponZmkEX3l7QXdd56wxtK4ekcYhOxXJeA2+VGSC7JkUXzz4yEte
 23y/wWh150hB+qbcHHrjn+R1CyHzrmMOUgj9WcmIfAcEoTjd8gfwXFPmAk4TiAPfcDZl+E9EcfY
 xkOUb0KgI78N4oHkfNSC6bk/KcJXRaJXoXo69cGbiIy5tyhMngtnkyTYlh6w6pnEcRdip0z3wnC
 /LGY+fE9eJUk649TAIe5vjZddKuUZPu7k++PhpGF70FpS58NaS+abO1u4Cyni9VWJsGisxDxEsf
 LgRd56RiaY8M0cG58L4nN6fOmQrwTc
X-Received: by 2002:a05:6870:8a0f:b0:417:47c2:6590 with SMTP id
 586e51a60fabf-41cec142a9fmr1863949fac.14.1774638228404; 
 Fri, 27 Mar 2026 12:03:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:54a7:4cbc:7d2e:3b99])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d0496591csm113534fac.8.2026.03.27.12.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:03:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 27 Mar 2026 14:03:16 -0500
Subject: [PATCH 1/3] power: pmic: mtk-pwrap: add init capability flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-mtk-pmic-fixes-v1-1-ef874ca82409@baylibre.com>
References: <20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com>
In-Reply-To: <20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=o1ujKM6Lqu2tEGTDLv2qZJX51UewTtNt6sy13NjKHjk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpxtR868aucY+gyejB0QWOJblEL099zyHyYw07x
 xo56weWcbyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacbUfBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ACWYH/iwHtdtnAN5Ri3cnk4++vLKYXXs78G/k8ppMy6p
 0T1+H44Ad3MEk21M1xHpqJOj8aVXMrxQcm7VTO7L3SBT51lPOySKlS0ez91m+RmwJlcjZDVW89f
 tNkzQEu6uUcFbpOhYlUl3W/+vNbcWfR4TJAH9xBY4t0PSAJM8TTAFGu8qsG8QZAw2CVdFeNRy1R
 vf+/+Jw/7z0AdhmcdIMfL8X+xrdd1B/qpoq3g2HZk4IOhREsAt7FjBWi/WiRApLmVFcKR4E4mFI
 6lZtkZ4ZI5WJ/rOjrwvbpbrj6B1ul9tXozSu984j2dEMf6KAk1MwgslBV1aRl7aoXiYh7S2XVds
 kxuw=
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

Add a PWRAP_CAP_INIT capability flag to specify if it is safe to call
pwrap_init() or not. Not all targets define the registers accessed
by pwrap_init(). In that case, it is expected that an earlier bootloader
has already initialized the PMIC. If not, we now return an error instead
of trying to access undefined registers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 446b78fb0ee..9ff06fdb3bd 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -62,6 +62,8 @@ static const struct pmic_child_info mt6359_pmic_children_info[] = {
 #define PWRAP_CAP_INT1_EN		BIT(3)
 #define PWRAP_CAP_WDT_SRC1		BIT(4)
 #define PWRAP_CAP_ARB			BIT(5)
+/* To implement this capability, the registers used in pwrap_init() must be defined. */
+#define PWRAP_CAP_INIT			BIT(6)
 
 /* defines for slave device wrapper registers */
 enum dew_regs {
@@ -752,6 +754,11 @@ static int mtk_pwrap_probe(struct udevice *dev)
 	 * Skip initialization here in this case.
 	 */
 	if (!pwrap_readl(wrp, PWRAP_INIT_DONE2)) {
+		if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_INIT)) {
+			dev_err(dev, "initialization is required but not supported\n");
+			return -ENODEV;
+		}
+
 		ret = pwrap_init(wrp);
 		if (ret) {
 			dev_err(dev, "init failed with %d\n", ret);
@@ -905,7 +912,7 @@ static const struct pmic_wrapper_type pwrap_mt8365 = {
 	.int1_en_all = 0x0,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
-	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC1,
+	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC1 | PWRAP_CAP_INIT,
 };
 
 static const struct udevice_id mtk_pwrap_ids[] = {

-- 
2.43.0

