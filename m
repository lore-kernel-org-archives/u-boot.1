Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75EFD3EE89
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 16:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91E9D83A6A;
	Thu, 22 Jan 2026 17:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bc6t2fmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3CB783B0B; Thu, 22 Jan 2026 17:38:28 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D69E783AB0
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 17:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4801bc328easo13549365e9.3
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769099905; x=1769704705;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LshzIswTLtiEdAIhMLhDX2zkEfrQA1K2wCqOUqQELdw=;
 b=bc6t2fmC14n926lfO23EHmU46zGG2oXzR85V9GnH64mF/lTgH8etdf2sM1NYJVbpKw
 Yz0yeE/HNiRS5D60gh8EbYejw0Dg193Qd5sfKcLIm0iQugESOc7u/UhewuK/gKk1CUlF
 CiwLWbie1reeKjtWIi9jdIdz1TgrAoi6av5unfFLOC5IINENiL0ioLd1VPHxmWUqQvxF
 upCWGqvQnE/Wx4KvfDVVSWfTnG1VGgTauzzi9NJbSUdJAKx5t+6Xe+O5OJqtPFWMdwtZ
 s5iAaOsM8W+8FjaM6erwvEEQpSYXQS3woxU24DWcg93p819tf+iPzh800eRNPTrb9Czq
 9vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769099905; x=1769704705;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LshzIswTLtiEdAIhMLhDX2zkEfrQA1K2wCqOUqQELdw=;
 b=UABz706kZRb0bxFozdaZ7Rrf9+7/BjohUiamkTNxbxqhUCtiKw5H7XR44l2SnEpRiS
 TdPCQpciDCNQ/cvWVlZWienPZ7dwSHOXMnAUjQiDS4GgANQmxlE4cCanQyua0bTtCvZf
 0LXLgx7PkegI8sO1roJ4mjy0LOGj91xKc0L/Io+cCssuR+0vGVydrM+dOeXRHJ+Eem6J
 8L/FoCjcBSXUIg0P9KFewdEi2FM8N+Lkqc/4iN8wd5/zHek5qgu5EyREwT/ZpftQDmB7
 tvOLzmskF56SNj+MWd5Op+8/xohLoYQVFvw+E2qrMQpQhdoFfkNYbT0Vd2tihZSoqC+U
 5ZNw==
X-Gm-Message-State: AOJu0YxLXxtD/XjgaLQBmlkK2mPnXlCW0EhskW/7dgJHDUU53BAdgLA4
 lBJTbvSHE9HF0c0fPq/v33++ghh8IT+l8/5BJGGdhS4gVf5fP5CDJa9+H9qlKllRIA0=
X-Gm-Gg: AZuq6aJ2NhbpKvoEBT5py70KVToI7G5ozJWtq3lBEjdDOk7Wl8CXvlZTcsHIGCGUhYO
 vjNYHOmH9h6TvXyx8oBmz/R+79qEUUKe1cWdaE7jI8x+i27aa49vqnFzpeNDvRZsSAJ3LPNq9YT
 OrJgVg2CO5deV87GjVdosvnzuAmIKtb+yNU9EG3DRMEYVu1RMghamieiajIsDqHRj7J2SXS4Wt2
 P18UAP7A2AlnUxdoXufs0VzYQ1BMxIrAokWVV7zVupysNIcEK0BRGDaKSFjcHjkhCr6Cplb2FRR
 PZtpGwjcI6X8Wnir5tKQRGILzovaqrvzPao+f/5gezwk6ifHPwzRIhKR1B6lw3OClO+SxFj2v8M
 75RA7wn1u1bPTeOy+A/8LX1wyJG2+qvfrQhkxk0GUoVo/vOhj/x/5R6NwtMjf+3+g8NLnDOCEcW
 S95BQbitVUJ2BmASLz2sja/b9Y/TzOKaPq
X-Received: by 2002:a05:600c:4fcb:b0:47e:e807:a042 with SMTP id
 5b1f17b1804b1-4804c964ad5mr3398305e9.15.1769099905154; 
 Thu, 22 Jan 2026 08:38:25 -0800 (PST)
Received: from [192.168.1.35] ([2a01:cb1c:39a:2200:c85b:67ae:76b0:e0c6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435924ae723sm19468949f8f.41.2026.01.22.08.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 08:38:24 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 22 Jan 2026 17:38:23 +0100
Subject: [PATCH v2 2/2] pinctrl: mediatek: add pinmux_property_set ops support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-add-mt8188-pinctrl-support-v2-2-324b4c8f2b64@baylibre.com>
References: <20260122-add-mt8188-pinctrl-support-v2-0-324b4c8f2b64@baylibre.com>
In-Reply-To: <20260122-add-mt8188-pinctrl-support-v2-0-324b4c8f2b64@baylibre.com>
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
index b1fdcd18027..e991e03ea41 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -15,6 +15,7 @@
 #include <log.h>
 #include <regmap.h>
 #include <syscon.h>
+#include <dt-bindings/pinctrl/mt65xx.h>
 
 #include "pinctrl-mtk-common.h"
 
@@ -657,6 +658,16 @@ static int mtk_pinconf_group_set(struct udevice *dev,
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
@@ -674,6 +685,7 @@ const struct pinctrl_ops mtk_pinctrl_ops = {
 	.pinconf_group_set = mtk_pinconf_group_set,
 #endif
 	.set_state = pinctrl_generic_set_state,
+	.pinmux_property_set = mtk_pinctrl_pinmux_property_set,
 };
 
 #if CONFIG_IS_ENABLED(DM_GPIO) || \

-- 
2.52.0

