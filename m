Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC336D4A61A
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 09:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A7298388D;
	Fri, 16 Jan 2026 10:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uljbfblQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B7E6838BB; Fri, 16 Jan 2026 10:32:34 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E30ED83885
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so12711065e9.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 01:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768555951; x=1769160751;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8o+b4QgAptTiuSTObIwJAex30CKHrPaOPKDjd8dojhA=;
 b=uljbfblQXocwiUqroGqjZvR6sHEYDPq8pJ8l0mvnbSlk4/QYqnry+4pSBeURIZrcfP
 tdtPBuuqlTKmhgFasE7STLd267adKtnB1NWpwwuNoWnrtZ920+NkFr3EPcGeFHtEgajj
 DW1++dgYRm/qDFuYBjYHTQ+lf2cLBIimnhN7tQMR6syWNzrve0NjQVacnCp0hl598cn+
 +xlKi/Wded+K48rKaRGARm9MyiDZsPd1cB0gss9VRDjwg6Um79LKX3eGXPl2kYHv//ht
 Z4OnmsDnM9JCgXGtNWfHwpy3meDOc5YtpRDSPDZQH0QAXZAiB84Sdd3vRuRhTaYbbHIL
 lDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768555951; x=1769160751;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8o+b4QgAptTiuSTObIwJAex30CKHrPaOPKDjd8dojhA=;
 b=hLdZDuxiL/y7V0nyC+GIq0OfkQ9fyZGeB4S3FSYP1cYfv6Aub6P433DjhQIIi1biYu
 ivkxAf7gt22y/clLs+ylyFQ25sQ9UvIkQg5YlbEDcYbr1x0VP77jHlRfwqUhGcznmiVP
 STTcLPWTathZy69wJ00YkZKEOgifYrepUggpbYC/mZCtFcadP1DjfkhvBxbycrXcsVay
 j3FoFY/4LZXz8Rs9M0PxuJ2Ry8xXf0srN5rORo2/1cvbOaKtwPrenWZfdr+gtPJEtV5X
 A4Uhmn7hlhrC9vYB632b7tUlErx1qT1/zm77e5gPlvCrZ8e0XhWeacNifYCHtMLQbTQX
 Rhsw==
X-Gm-Message-State: AOJu0Yyg29QxXrIhBNlFIvXqmeHhaF6t8zXsBZuMjiXNYSPfFVa2sWih
 6NJ/aU5wY4geaCTjzNh/s/QN14kkEzZAszYfvSWczP4XTrSzGLmwsIozSCmcTL+qfvc=
X-Gm-Gg: AY/fxX6Xaw3M4eMMFX6LuTOHkPyuT//O4X3t6xejIJW1oMcmixcEan5SnwtlccSKLru
 BSh/kbYZARhvS5+4fz/Op/g1gx3Y4dv1W23cLXL9BeYUluxxddXNWz12Jacph+Euu7WLrs+Yr5i
 8HBMackLOvCHPDgmFyhzdRvWqyfecf1A2Rq2LTODJ+ewwEi2Dl7IhoJyx8RrE3NQUtCEqwJGp9W
 SObRnIsvLiRNjZZ8C6sowscoJFC/peO13Af3+yMKoJ38JdsF3uXYZNeRpD3AgF7y8w+B2IoihQJ
 /RC2nZGlD3h2S80gOkHL56lxOI0YN8AvoMlv++seh6qv9THl44jUFFv5UYlkYbMWr6xpg6LnZ4U
 XEwFOkvrH3RBupFDsIWdBEhdZCHKSCQbcHy70ni6ohSWlkhxmtu9k0H2fA+O3hvAavfXhp4Y1iG
 V/N55KtiAdsOdX1uTaPqVv
X-Received: by 2002:a05:600c:4f4e:b0:47e:dc64:f1c6 with SMTP id
 5b1f17b1804b1-4801eab51c8mr23378835e9.6.1768555951337; 
 Fri, 16 Jan 2026 01:32:31 -0800 (PST)
Received: from [192.168.1.35] ([2a01:cb1c:39a:2200:bfac:427f:8a06:fcce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435696fbea8sm4179086f8f.0.2026.01.16.01.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 01:32:31 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 16 Jan 2026 10:32:28 +0100
Subject: [PATCH 2/2] pinctrl: mediatek: add pinmux_property_set ops support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-add-mt8188-pinctrl-support-v1-2-fdf3b9227c71@baylibre.com>
References: <20260116-add-mt8188-pinctrl-support-v1-0-fdf3b9227c71@baylibre.com>
In-Reply-To: <20260116-add-mt8188-pinctrl-support-v1-0-fdf3b9227c71@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>, "Jill.Wu" <shu-yun.wu@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

From: Vitor Sato Eschholz <vsatoes@baylibre.com>

Add pinmux_property_set ops for mediatek pinctrl framework

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 0483d532800..fbbe3f8aa25 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -11,6 +11,7 @@
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <linux/bitops.h>
+#include <dt-bindings/pinctrl/mt65xx.h>
 
 #include "pinctrl-mtk-common.h"
 
@@ -651,6 +652,16 @@ static int mtk_pinconf_group_set(struct udevice *dev,
 }
 #endif
 
+static int mtk_pinctrl_pinmux_property_set(struct udevice *dev, u32 pinmux_group)
+{
+	u32 pin = MTK_GET_PIN_NO(pinmux_group);
+	u32 func = MTK_GET_PIN_FUNC(pinmux_group);
+	int ret;
+
+	ret = mtk_hw_set_value(dev, pin, PINCTRL_PIN_REG_MODE, func);
+	return ret ? ret : pin;
+}
+
 const struct pinctrl_ops mtk_pinctrl_ops = {
 	.get_pins_count = mtk_get_pins_count,
 	.get_pin_name = mtk_get_pin_name,
@@ -668,6 +679,7 @@ const struct pinctrl_ops mtk_pinctrl_ops = {
 	.pinconf_group_set = mtk_pinconf_group_set,
 #endif
 	.set_state = pinctrl_generic_set_state,
+	.pinmux_property_set = mtk_pinctrl_pinmux_property_set,
 };
 
 #if CONFIG_IS_ENABLED(DM_GPIO) || \

-- 
2.52.0

