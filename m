Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCCAD3CC84
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 23:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F28B4803F5;
	Thu, 15 Jan 2026 00:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o6TOtnws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 227F083015; Wed, 14 Jan 2026 23:37:35 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA102803F5
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 23:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45c87d82bd2so186413b6e.1
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 14:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768430251; x=1769035051;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9qfr8Nzmo2F79RC8Ae0gdhwyuPdbAFrHu2JsY+EzuNk=;
 b=o6TOtnwsqCFAVSoXx2pUZXBAxjIbp070kykf52irFEX66nQ19gDb/5dOUL7H6EkeBW
 yA0mp1cuUpXwGOLdWxozOYE52Dtxe5vip/sgo9uIUxuAZJuQ55PSDfVtWao7JrUPcEYx
 Y13BQPZ4XT82M5snv6ZOdl/QacnHuNmS1hOzh9CBVVbGdSTx4bt+q/QAahSulxFzZqkx
 YtYP1cqRu59SIorce1leQUfypd8X69mfkYb8Sep4RUAY+ToNR+UZGThUFMaxPcQVp8jD
 vpqn0tmoJD98g73FP16bRGrzPvEn2Qt+7ZVsWP3008gGC45kJ2KZ9dMzGfrcVV3bn8eP
 /wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768430251; x=1769035051;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qfr8Nzmo2F79RC8Ae0gdhwyuPdbAFrHu2JsY+EzuNk=;
 b=OPiqNfsLp33EQMGNz668S3IS1+rBcUoon4kT3Q34aU6tDNaOCTT8S++Ezl6HRfUTHo
 PA4N+nm4SwukTerrbfJ8WK3sk1MKO6sZ4PoxpeYV5gXN5VvhRETBwcXE9+nGXuY6rlFN
 RR/ZHFMrv0SJZ2hjFQNu7fjZurND4Nwa6ooQx95dqioh2jXMoVt7aumRdM6n5g6YGSOj
 TmUyyLlUipSzkDQpZc3rINElrbsH3WehopFyk4vFs2w6HYgqaNhtVsPafaRhG8qGOSn2
 f6Gy283W7He8UnB0e3Va/Tg1cXdsPzis22GUJdeAkKZ+kggGk3pnCPXNo2eWUoxtL9tH
 TgiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV19i8+d9py8ErJUNnJqDXFhusgV7MlTl1u4AJKCm0bdoBMOYMymHiHf/xPyMzlrdcwAaTzTj4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4zpAOvRrO4eO/kMgi374ISOYnbMmSx+N3hiCVoQeK8DC4APuB
 nWwqBdZxGgoJk83inLUvRo7aQ7CbYcTusm/pJ82rWK7lKAcE10U7ObTAruJa7wi2NaU=
X-Gm-Gg: AY/fxX7k163elBgZflXXRYx9RGMQ5cRjN0ZTc8CLMY0RPgj90SfL3+T20PQxS+RMlo6
 2yXFZZTEN5sDlkhAjvjJIknqZ2t6HRGl8tA4ejkGBrAANG2Kn28Mtfzbr6Jp7tj/jVYysEjk4cK
 Q/QMPHicS2LDr5F9Gc90263JzNY55YJ3ATSHbuqBZzaMo224JPbhX9F0+7Zpt4W3VP6A72TUt+D
 CyGy0MyTbx7GMMW1EZsBxEnYe7z3x04hMX9Nl38UUQITchs3Rj5Y8hozxpS0J3gLjh+Nt8higIH
 JF8YihLh4Wzd+7xTgZCzdOpUfUxXsPib2mY/lBQmLCwGxtu0aMFBYjdEnXdtBZDgbYM8/2/Qbh/
 VYY10pPbjFseGtHXXOil9EEUcDGsrqfHb2i//jj3QMH0qjESv2vDKpq0sp7SoyUljRFzJ8oJFby
 V/lTKk2t25YdWmrd0=
X-Received: by 2002:a05:6808:c171:b0:44d:a44f:1e87 with SMTP id
 5614622812f47-45c73e342e8mr2485845b6e.40.1768430251594; 
 Wed, 14 Jan 2026 14:37:31 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3ff3:5a3e:f89a:1938])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa4de55ffsm17732357fac.2.2026.01.14.14.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:37:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 14 Jan 2026 16:37:19 -0600
Subject: [PATCH] pinctrl: mediatek: fix failing to get syscon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-pinctrl-mtk-fix-syscon-lookup-v1-1-2649df7a1f49@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBA0avIrB0wUlrTqxQXNhl1iCYho6IE7
 97Q5YPPzyCUmATeVYZEBwsHX6DqCsw8+ImQbTG0TftslHpgZG+2tOC6ORz5RLnEBI9LCG6POGq
 l6WWH7qstlEdMVKL//9Pf9w9uv01VbwAAAA==
X-Change-ID: 20260114-pinctrl-mtk-fix-syscon-lookup-f919e7da8b9d
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3365; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ZP1mbwkMjs3LgK93FhZxCe6NCp52R5kGhP9WcMpy/BU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpaBqibcQUJBD2TC2cylBuy+9G224de8To845Se
 SD+BMj1XFKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWgaohYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJSIH/07SRXxljWjgGKyz0mjk31UcQcm6DXzTxTI836o
 biSoAY5dsSMibISL3DN2LHLV59OJuvQNiJz46fLVBNAf4KatHvwk1ZzN1YnnotpjxBPWj2bGc7d
 xCY4nTVO/1eX6LQcSXeDZ2qgS8qU5O7BIL3eL937hxaP1Brll9A/G2V9BeE4/wPcmXnv+cReRqx
 XszwlNbdMHkoi0HTdBr8rVAVmfVhuhGTcjObPIt5dsiWI1UysMvGdDU6fWCCakE7UPV+AUOUPT0
 VxTjQTVQgOYQA04+u1kvlV6wvHGElfYEulhNPSGTWcH03lPYkzOxrX9B9FdDsuaTXStFFb9B9jt
 sQLI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 15 Jan 2026 00:23:23 +0100
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

Replace uclass_get_device_by_ofnode() with syscon_regmap_lookup_by_phandle()
to get the "mediatek,pctl-regmap" syscon device.

Depending on probe order, uclass_get_device_by_ofnode() may fail, but
syscon_regmap_lookup_by_phandle() has logic in it to handle that case
correctly.

The previous implementation could read more than one syscon if the
"mediatek,pctl-regmap" property had more than one phandle, but the one
board with a devicetree that does that is not supported in U-Boot yet,
so we can save that for later (it may never be needed).

Fixes: 424ceba18bfb ("pinctrl: mediatek: support mediatek,pctl-regmap property")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
A few notes:

I missed this in initial testing since by luck the probe order was OK.
And I did consider converting the driver to use regmap everywhere but
it was far from trivial so just using regmap_get_range() to avoid that.
---
 drivers/pinctrl/mediatek/Kconfig              |  2 ++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 37 ++++++++++-----------------
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 4a698568a7e..ed4b02be0dd 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -2,6 +2,8 @@ if ARCH_MEDIATEK
 
 config PINCTRL_MTK
 	depends on PINCTRL_GENERIC
+	select REGMAP
+	select SYSCON
 	bool
 
 config PINCTRL_MT7622
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 0483d532800..9e319185809 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -11,6 +11,10 @@
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <linux/bitops.h>
+#include <linux/err.h>
+#include <log.h>
+#include <regmap.h>
+#include <syscon.h>
 
 #include "pinctrl-mtk-common.h"
 
@@ -820,32 +824,17 @@ int mtk_pinctrl_common_probe(struct udevice *dev,
 	 * for the interrupt controller, so we only use the 1st one currently.
 	 */
 	num_regmaps = dev_count_phandle_with_args(dev, "mediatek,pctl-regmap", NULL, 0);
-	if (num_regmaps > ARRAY_SIZE(priv->base))
-		return -EINVAL;
 
 	if (num_regmaps > 0) {
-		for (i = 0; i < num_regmaps; i++) {
-			struct ofnode_phandle_args args;
-			struct udevice *syscon_dev;
-			int ret;
-
-			ret = dev_read_phandle_with_args(dev, "mediatek,pctl-regmap",
-							 NULL, 0, i, &args);
-			if (ret)
-				return ret;
-
-			ret = uclass_get_device_by_ofnode(UCLASS_SYSCON,
-							  args.node,
-							  &syscon_dev);
-			if (ret)
-				return ret;
-
-			addr = dev_read_addr_index(syscon_dev, 0);
-			if (addr == FDT_ADDR_T_NONE)
-				return -EINVAL;
-
-			priv->base[i] = (void __iomem *)addr;
-		}
+		struct regmap *regmap;
+
+		regmap = syscon_regmap_lookup_by_phandle(dev, "mediatek,pctl-regmap");
+		if (IS_ERR(regmap))
+			return log_msg_ret("regmap: ", PTR_ERR(regmap));
+
+		priv->base[0] = regmap_get_range(regmap, 0);
+		if (!priv->base[0])
+			return log_msg_ret("range: ", -EINVAL);
 
 		return 0;
 	}

---
base-commit: d503633a36767d756c7de28305cf0de79440cbc0
change-id: 20260114-pinctrl-mtk-fix-syscon-lookup-f919e7da8b9d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

