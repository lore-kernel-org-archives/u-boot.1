Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2DA107BCE8
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 21:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C739843E4;
	Fri, 13 Mar 2026 22:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JZBofoqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A40FC84348; Fri, 13 Mar 2026 22:56:15 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F7D84348
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 22:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d750eeaec3so988979a34.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773438971; x=1774043771;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vUx4lAEU/bC593XVMkJqkxHGo7vuj+idl2YNDr9pRQM=;
 b=JZBofoqoPJgt7v7EO5hqgM6hz9lVxHb7BwH+RhO5E9RJo9p+qfepeZQU6fT9QW+eBU
 K5EYATIX9/gMqYa5C0UCHwE/Es2nxJzaSRAiMUC91+Gy2PVypIwkwO2gT54geThgv3au
 Ce/Dufl0YoAnZIfBKNhKFFqW9uWP9XqQHGmCMXnAackq2Vj1aUmJiVU0pJiIU5aIMkWZ
 O/4EXPSPr2ZzbDpTCCG1CuvIKA4nfIve4vwKwzdICZVH+7Iewhy/l3ipxCQegn1oWThV
 48qSNQtg9XatRJeq7ssVBaz0s57ene18fRUQD6l3tbto7RQFQ9biKZ3PNPNGQOVPOiG4
 +FTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773438971; x=1774043771;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vUx4lAEU/bC593XVMkJqkxHGo7vuj+idl2YNDr9pRQM=;
 b=mHV/QMSiSRNsOxLM9OblOGjJx+GB+PledGSoIN56qVZC5F4dRZ3tZfdQcY4svbU3IX
 Rz+YKcOMFxSqVUrK5UulNA5sDLaTWPUF7dtPYUXvZlnQnzY+Sy4mRvrJZWewtHogpnC7
 3BUBVvVeyHfj8qkRod3P/6euZf/JPBU2kW/IodO7Vh0BiSWsBY9PhwkkLGi1ApkTgCHx
 KR9jWJJOHqIeOBwZi/7buZBFDF8nmxqXj9vRihJc0KGxWDcPcdhIjL7XdVGGSsCBmB2w
 GIWNH0xa/5aCqj+yeOSBR2Fe80omKpTVocCaAUKEj0ga3gl0LrLmSz8FWmrX9ieaClF7
 VYgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+afsNBkF02lCxAWqns1vOhirjemanM+Y6oJ9CUJrSw0QaVkyUmIKFJFOUWThdVOlVjCScpSM=@lists.denx.de
X-Gm-Message-State: AOJu0YysTVNenqZMfBJwSqSDQvlr1GEK0vMD6XST/KAk7dps4GgkWLrE
 CB5qIsHWQvVyD9Sav8HkI2ozLTzQMCJXNLwKdOpB1yMrxabxr7a7JXyWk31fTE5q4gm9uj57qs8
 cb5ba
X-Gm-Gg: ATEYQzxP/VddHz84GeRVM2LqYgalfGkYDmJs23DL0U1pAfI8jin607RD3TWZ3yWbGY8
 34REthk9kFpgwSf8F/5iTUqjp1KPjBERpUSurZWB1VTNrx+qw3NXI8TjAC3VYT7CG/1NFeSsHNr
 v1HFrmYhBE8AMLxYzJSIg3LiAE2JGn3Yf61039uy4UYF2R9E40A3+m0mlTCPLrhSdKWlTp+lVej
 /zALje3MtBuZQV0Bxce2FxDXmFMmYFDpX4/gwMKOU8hukD4RaELsU9i/4iqTDwAas2Q/Py2FaVN
 hHpkAICDwI3POvRJJEfYsSwZhOBcsEDyPB7RpP182waYSFlEwA2d0utPnD/gBAjpUfMvi3A1z0C
 ov0YQANargxv9AkRuuZgwgNztNVZYtN5JDB3NeMvD7+vHRTmbk6oOb90QKc56RpBYTtqWzkmLfP
 tlfGNHK8kMdDp+KBSYrINMyMFQ
X-Received: by 2002:a05:6830:3690:b0:7d7:57c4:3675 with SMTP id
 46e09a7af769-7d782562eeamr3032949a34.30.1773438971634; 
 Fri, 13 Mar 2026 14:56:11 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:bf:9982:ff59:466])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac8e5b4sm7432196a34.12.2026.03.13.14.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 14:56:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 13 Mar 2026 16:55:33 -0500
Subject: [PATCH 1/4] pinctrl: mediatek: add handling for RSEL register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-pinctrl-mtk-fix-mt8189-v1-1-607dd37fde37@baylibre.com>
References: <20260313-pinctrl-mtk-fix-mt8189-v1-0-607dd37fde37@baylibre.com>
In-Reply-To: <20260313-pinctrl-mtk-fix-mt8189-v1-0-607dd37fde37@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=G7CrhQNKHaL1p222dcpfMKTtqBX5v//XobMJ6uN0pLQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBptIffeviIKAIoQ7dOyFaDkrWfU6pnFTxmxavLZ
 CEJHIgW40SJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabSH3xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ASscH/AzcRH602ub+9dGuxUyaRJz6Lr4yhjbEExuwkIo
 YRecqE4j8Uvc+FTtozD/ls0IudQ9YqAteck8X7Wqmg/7IrP31yLUqHws2Sy/qQWFhWAmLwLqO4p
 E2ZETa66apAw/30MurAY7UYpbWVEk3lZQor2TCOhBAYOFq/kcEWdxRPiKes9qhr2wejdFXKDqfD
 iKHDbkgHCt5ZCKwYTu4bopth4i1rTdFPemXYa8WY31pxVnB3cyR9jS12uZDnZcNB59Upk5bc6w7
 IF1Uctyt0QPfY8odKIsBJReHFhx//YV5OQpYlM8y2XwvssTb+qUu2wrdczZ5Z6SggZM2rKPTfbq
 lxu0=
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

Add a new PINCTRL_PIN_REG_RSEL register type and a new function
mtk_pinconf_bias_set_pu_pd_rsel() to handle setting it.

Some MediaTek SoCs have a pin configuration register called RSEL that
sets the resistance value for bias pullup/pulldown.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 14 ++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index d152e216634..1028b8a93f5 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -450,6 +450,20 @@ int mtk_pinconf_bias_set_pupd_r1_r0(struct udevice *dev, u32 pin, bool disable,
 	return 0;
 }
 
+int mtk_pinconf_bias_set_pu_pd_rsel(struct udevice *dev, u32 pin, bool disable,
+				    bool pullup, u32 val)
+{
+	int err;
+
+	/* val is expected to be one of MTK_PULL_SET_RSEL_XXX */
+
+	err = mtk_pinconf_bias_set_pu_pd(dev, pin, disable, pullup, val);
+	if (err)
+		return err;
+
+	return mtk_hw_set_value(dev, pin, PINCTRL_PIN_REG_RSEL, val & 0x7);
+}
+
 int mtk_pinconf_bias_set(struct udevice *dev, u32 pin, u32 arg, u32 val)
 {
 	int err;
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 58f13613633..1215fb7094b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -67,6 +67,7 @@ enum {
 	PINCTRL_PIN_REG_PUPD,
 	PINCTRL_PIN_REG_R0,
 	PINCTRL_PIN_REG_R1,
+	PINCTRL_PIN_REG_RSEL,
 	PINCTRL_PIN_REG_MAX,
 };
 
@@ -253,6 +254,8 @@ int mtk_pinconf_bias_set_pullen_pullsel(struct udevice *dev, u32 pin,
 					bool disable, bool pullup, u32 val);
 int mtk_pinconf_bias_set_pupd_r1_r0(struct udevice *dev, u32 pin, bool disable,
 				    bool pullup, u32 val);
+int mtk_pinconf_bias_set_pu_pd_rsel(struct udevice *dev, u32 pin, bool disable,
+				    bool pullup, u32 val);
 int mtk_pinconf_bias_set_v0(struct udevice *dev, u32 pin, bool disable,
 			    bool pullup, u32 val);
 int mtk_pinconf_bias_set_v1(struct udevice *dev, u32 pin, bool disable,

-- 
2.43.0

