Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60179F364B6
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 20:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419E8841FF;
	Thu,  9 Apr 2026 22:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="xQ1fxFfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3AC584105; Thu,  9 Apr 2026 22:32:12 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33C084189
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 22:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-464bba3a9easo673421b6e.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775766716; x=1776371516;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=whyNEfK3rdRlMHAwRPquKy8qMRJYFzx8frrtIHDrVkQ=;
 b=xQ1fxFfAN7AgySY7D8myHRYa7Y+pn96OvgQBjm4NjBfWK4Xz4FDtVdoZ3bOGATiyre
 2i7GBeF9JeRIjH0pYRoCj+ngKI41GUMDU2Ysq5JtGLwyX1v1+C7p6jYclOLJPnuyyggU
 r0hef8eYggzIWRwMv6Z+exyNJCv2jMcGbVdPJgYzoH+2IESMXPoNCCkbgDQVCmzOiCbG
 uYRX0I26VC4zxyYqEcRbuQiTmHI3d1OWtC87UZVgbsv4RH735yDqCDe8lP0VEQ6AUcg7
 oKsn8QH9c5zbQJFncfrJAzOcfc9aag99NY4oOaPfhIBXRLzsmf07bSPlsIBr+eeL9n0F
 S5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775766716; x=1776371516;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=whyNEfK3rdRlMHAwRPquKy8qMRJYFzx8frrtIHDrVkQ=;
 b=cfA5ozo7OAMo5A7Kw1CNJ1w6TQbCxKR4K4/XTjapmZn2RnxPqANNkWfegBOo+XS96X
 t+dFF2DMMFgkRMrSp/6v12G5aR06rQPSJn85jRbqwa6tTyWqsVrWlK98fiTwWywNBknM
 0dwVTMFnoTP/Ky4BYYH9caOzqQ6uBY0CfvPBcd8WRFxtoKS7cuSe1HtHedtx+f5HP5AB
 0AzpVtwEzWTMydWcbyecT7ohokSnZBWh1wYbrMqcZwXFwj1/K/VOXq6RHdmuqc1zkTaV
 V15kOasPhqQh2Q0gswKf7FnZKwq4H2I6j5dIjP5ujNm6cz3tmMXGUDyFbMX6SPE+zhNk
 CruA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDMIPl+++JYnF2mc6CRvqdOh4vhx2OLr614LHrIN6yAv+CIcYY7SCIjimeCON/K5DdPLzFv6c=@lists.denx.de
X-Gm-Message-State: AOJu0YxgaVnCrk3pX3omfFHMcWkK9YjZqQoG9qoqhwNZLI0lixXbeaYj
 kGy+04t2HETWINLHYdhvKxOSh21bnlPBojywNLdBbnwjgIoFpfY1ovrbnlxS4yAhS10=
X-Gm-Gg: AeBDieviQr+eUMqfuQsYKXkmjIFqAkSgzUL3UFOIhzZi4oNsfQGsTRD18SW5kafgOvq
 fqotNnqrjmx3plm39dbOU+iuQFD1G6eEyE0tvvPdjPxg0fTh9aE3kwXX8Ird5BprVlhRyArtXsz
 tttIlAUhFd7IMQvPtAmlTpyLVgZViYE1Ytm+6f4mG/Fu+6M7Jv/1Ro3pDFGeKoGKnPuFcLhGXUN
 gW3I2y3jNw4rpfkkqIyiLMM49Nu01YEkWynYTsuugBd7pGeIT6hkdTZS/9jAaTDufjxY9thZCCN
 F1VnYDu0baqbBoxAK7vbqVUFThPbvFJ5ntbAr98Il7TN9dmD1vkDROPikfVj3+jooyGee9XHaUA
 80BRLVG91SMzhM6VFAB4mBm1GknQlpblXEotxti84qJokNhbIUyy4azRcbhr3buCMlASwOvU64z
 X4iqkl5TVG/gPdakMjLE3aKkOc977T
X-Received: by 2002:a05:6808:8955:b0:467:284:b3b6 with SMTP id
 5614622812f47-4789ff0b3b5mr370607b6e.41.1775766716325; 
 Thu, 09 Apr 2026 13:31:56 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a101b75esm293075b6e.6.2026.04.09.13.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 13:31:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 09 Apr 2026 15:30:37 -0500
Subject: [PATCH v2 5/8] power: pmic: mtk-pwrap: remove interrupt related code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mtk-pmic-fixes-v2-5-73e83aa6345b@baylibre.com>
References: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
In-Reply-To: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2257; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=W//MdpNeGgMOtCxpDmN9quJF1F1IHSC0pcXkhjkmZ+I=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp2AyXWtq4y7w258FzONzxppLQWA5TEe0SLfJ2b
 DN1rXAFnW2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadgMlxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AFIcH/2ezX8j0RqxIIxPzOEM6mGEEtdh7nmdS6TaG7Iq
 wsSorCAPXg1wkyRi3790wMS8oYJAdAe5dz+nH9XtoD9ivWUWfUzc+4CNhq/P0wo2or+1bbRIRZX
 PwUhsHypuY1j1znBon6jhGQQMGQYFSLlS47NUoRORlqjE0Bc7+RrH7ET8vxkE+tqxK4XLG2v+2b
 o6XjtXZSGQwODNDNGu2KW0jGeiN1wB3UCkrqDSkQppkqF5Pj0mfoC5BJraofImVbLsJrwtP4UZ/
 8s2Z1gkojPZaqypYmQwQDop+fRPTItfjwPw3Uerfy8fK6JvyrrOiDEd7SLBtuEkxNzoCNpZlGBT
 bfXA=
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

Remove the interrupt related code in mtk-pwrap driver. This was just
enabling interrupts without any handler.

Even if we did have a handler, the only thing we could do is log a
message. Since U-Boot isn't long running, this likely wouldn't be very
useful.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 64c483b2f3b..c41ebeb62cc 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -367,8 +367,6 @@ struct pmic_wrapper_type {
 	int *regs;
 	enum pwrap_type type;
 	u32 arb_en_all;
-	u32 int_en_all;
-	u32 int1_en_all;
 	u32 spi_w;
 	u32 wdt_src;
 	/* Flags indicating the capability for the target pwrap */
@@ -774,15 +772,6 @@ static int mtk_pwrap_probe(struct udevice *dev)
 	else
 		pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
 
-	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
-
-	/*
-	 * We add INT1 interrupt to handle starvation and request exception
-	 * If we support it, we should enable it here.
-	 */
-	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
-		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
-
 	return 0;
 }
 
@@ -859,8 +848,6 @@ static struct pmic_wrapper_type pwrap_mt8188 = {
 	.regs = mt8188_regs,
 	.type = PWRAP_MT8188,
 	.arb_en_all = 0x777f,
-	.int_en_all = 0x180000,
-	.int1_en_all = 0x0,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
 	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_ARB,
@@ -870,7 +857,6 @@ static struct pmic_wrapper_type pwrap_mt8189 = {
 	.regs = mt8189_regs,
 	.type = PWRAP_MT8189,
 	.arb_en_all = 0x777f,
-	.int_en_all = 0x180000,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
 	.caps = PWRAP_CAP_ARB,
@@ -880,8 +866,6 @@ static const struct pmic_wrapper_type pwrap_mt8365 = {
 	.regs = mt8365_regs,
 	.type = PWRAP_MT8365,
 	.arb_en_all = 0x3ffff,
-	.int_en_all = 0x7f1fffff,
-	.int1_en_all = 0x0,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
 	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC1 | PWRAP_CAP_INIT,

-- 
2.43.0

