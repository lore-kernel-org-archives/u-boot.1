Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB372C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 20:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A99C240688;
	Mon,  3 Aug 2026 20:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9EJEZZg3TvMI; Mon,  3 Aug 2026 20:57:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 834FB40649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785790670;
	bh=SgrUymI9ugNXZsjzW2QB0dvlxKAA2HWlLTPtEkL3rEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VqjDfH4BhH4m3bMezzdksTWUpdoZRSRE4AAx6eEmf4lbtPqhqpZUqoY1qNhsVWRA7
	 5jnkNmOq42JztWR0KNni7q7nw1ElOqcehfrdP+48pJluNYBuS2BJ26Nz26HHY5g8Ym
	 EXRXEB5L4SWGSubUvqaM89y6hykPe1Smt6cqksAUZlpWU0JCfpKLMy3EZ30THRvWdA
	 B1nasOh+Ng6knR4xLqpsOdD9BqrUcFlb7IUQ/NmBQewFtXDTJHKWS0mpL3iAnYt4jb
	 yB2Zxiub+MRxlJzOEY4SeOBMGoZ/rFY+VMwdaxuT9wa/7npNHpTTlOXmytZ4kj8cQD
	 RGlAmXd6HlI2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 834FB40649;
	Mon,  3 Aug 2026 20:57:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3BEE28F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5623400AF
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w2sW-eay_MiU for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 20:57:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B00E44010D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B00E44010D
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B00E44010D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:47 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7ec58fa3e01so1831311a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 13:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785790666; x=1786395466;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SgrUymI9ugNXZsjzW2QB0dvlxKAA2HWlLTPtEkL3rEw=;
 b=ShNURG7kuncCIs3lUrY3KX0sTJbC3yggD6u0dm4t8dWq7Z5LpGj/pqAFGG9E9Dz1WA
 dl1z/GLyikciI3mEm/BXpfCkOKDkQx45i2S9wOBI+eiFSG4okpghMxVX74VBOTf0Uloj
 WaD84zDsfcQInX0+XTR6sbfSMo2eRdrYHN0aulL9gKEAAmzucZrxICYkyFGwBrJTQRkc
 MfGYQbVTxCpk5Dh5bIWXAiBDclOcBrte63qinuoZAMerEPaKew7EzinCzh0iJg/w5TxO
 iUlrRWafCA2pgTYdjNujVb9s+sSR9rn2hojuviHHbICJtvHd74pGFUX4BEoafixQmLFi
 e93g==
X-Gm-Message-State: AOJu0YwRXiRVoT+H85ymhMCjLIXeE2flm1fd5h41mwHgvNWOiuVuvBQY
 T75twdW3xvE51/E3Rk635b0nXd6W+OxrLvse/cca/V23BT4qpslGaBE181cSZxNYJo4lOahGi8Z
 Z/RSrQVs=
X-Gm-Gg: AR+sD10E/O1fjtEx4FuYXeV+Av7KE9gtMCMKLK5o+HvSpyl/eCjXT578HhugJ9yIef0
 1JEN0P9cni/AUDIznsM9opxz1aqS2If3uyNpSagLUfJxgE0XMdBwWbWNzszhIwTxDzklNoLRNAi
 jUFGLeo7S2eijAw4m62d9cwfb5PqDkVXfzpW13y8QOWLCazlOdR9leGrFxRNqMHAjiPyyT2dHZA
 R8QlUIz6xZWVZG3jDUqvORaOupWccs2bBPTkNwtIapRPnqkNGKELcQGyfeH5dsncR3u2Jz/QiIc
 bXmsOHMdyZON6nT6BsQZ6HZcPhwU3+FVZ8bzT8M2t03YN0g0bK6i8ylamDA34mGBg3C5h3LO3qr
 QzA6VZhGfV1GthYApbnN5UvSaaouf6yZKPf5AsGL2yxaYsK7aSGxV0HKBopQt2Zw5EZoeH8IAeS
 J6Uqb/NMNOiqAlCtLYOSXmungr/UyzCT3EiZEozfOo2hHbh/n+qnZgNPs4nTWcqs4=
X-Received: by 2002:a05:6830:3149:b0:7e6:fe3a:b777 with SMTP id
 46e09a7af769-7f196ec393emr19264193a34.13.1785790666527; 
 Mon, 03 Aug 2026 13:57:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18f0d6a68sm8421452a34.19.2026.08.03.13.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 13:57:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 03 Aug 2026 15:57:06 -0500
Subject: [PATCH 3/4] pinctrl: mediatek: simplify Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-mtk-pinctrl-kconfig-cleanup-v1-3-fef1ff69d1cc@baylibre.com>
References: <20260803-mtk-pinctrl-kconfig-cleanup-v1-0-fef1ff69d1cc@baylibre.com>
In-Reply-To: <20260803-mtk-pinctrl-kconfig-cleanup-v1-0-fef1ff69d1cc@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 David Woodhouse <dwmw2@infradead.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mingming lee <mingming.lee@mediatek.com>, 
 Fabien Parent <fparent@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4457; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BHY/0fKDkO+j8yWvgDteKk5FKhiqlzZBVR+K4VvjY1Y=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcQC4+MgbTgBqCTKqCTnIlxirkGu07OJl9daU+
 N4bYa6wtVyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanEAuBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AyxYH/2Z77jGjbUheDRIY9SQ9JHPD0HuQxTU0mlMKpgK
 KV0NeL42mJM/KJXk5uHmUMBybEJS1RIzgyXlzoO691cRJAvyZ05or3W2RcVvwkAL1YM4iWx9myS
 xl2YYntiYWRL7fIwlBFw/2iD+O2HKZ2Ehb7TU4AkKwXD18vn92FJyZ3x2t+VVVDlikiwO0cBIqb
 LHW5VMu1LcY5Hu5zKdiE9tznDtJoXibRMQyCe0lC1n4ojMqggRnmLjpfee+Zp4KNqYrFDWmdlPB
 RZPP5LbdB/Sty7AA1HQ/v5uBU6jyIA8Cwlz0pq7pQ9ekai7cZXcddYlxvXg/5+NKZew6TU1tKJ9
 Dxl4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785790666; x=1786395466;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SgrUymI9ugNXZsjzW2QB0dvlxKAA2HWlLTPtEkL3rEw=;
 b=XM3EjPuc+UDA5/vcXC53oq3tA5DKyviVnpwFA2VBhwhaZ5peFJRSt9lDrxOc2jHTmY
 x2hjjQkUV3JIrUYqi2h/zf6It3OHPtBtqxGzBUS4xzLtfeVpFIejmzrkyXKL8/Ysbzgk
 Sn/3CVZDCZfxuiiog8fgtZUE+KVGl4gPS+9Z6CJwAW8OmrUOBoQzDhLfE/6oxIFUVPxK
 BbDxdc2m9N2Zw8Q15cnXXAyXfHk170eYQdtcfNsmQxJ26Xhqb2Nji5Bh15lrlCwrS7lW
 tj+bjg75cNyuqdx3g9UakWjcluYimyO9E+xXJwsqSKrs+wHAkA5zAOzgAlu19xt0ZVyB
 tHRg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XM3EjPuc
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Change the MediaTek pinctrl Kconfig to just have a single option for
all targets. This will simplify adding new targets and SPL support in
the future.

There is only one MediaTek target that does not have a pinctrl driver.
All other targets enable it by default so the configs don't have to
explicitly set it in addition to just enabling PINCTRL.

In the Makefile, we can use the target config symbol to automatically
select the correct driver. And the config selector on the common file
was redundant since we already have the same in the parent Makefile,
so it is dropped.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Closes: https://lore.kernel.org/u-boot/fba47ca8-7cf7-446a-9242-54c50087cf3c@cherry.de/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/Kconfig  | 61 +++------------------------------------
 drivers/pinctrl/mediatek/Makefile | 30 +++++++++----------
 2 files changed, 19 insertions(+), 72 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 42c7c8b8c80..46e35cbfe6c 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -1,66 +1,13 @@
 if ARCH_MEDIATEK
 
 config PINCTRL_MTK
+	bool "MediaTek pinctrl driver"
 	depends on PINCTRL_GENERIC
+	default y if !TARGET_MT8183
 	select PINCONF
 	select REGMAP
 	select SYSCON
-	bool
-
-config PINCTRL_MT7622
-	bool "MT7622 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT7623
-	bool "MT7623 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT7629
-	bool "MT7629 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT7981
-	bool "MT7981 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT7986
-	bool "MT7986 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT7987
-	bool "MT7987 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT7988
-	bool "MT7988 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8188
-	bool "MT8188 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8195
-	bool "MT8195 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8189
-	bool "MT8189 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8365
-	bool "MT8365 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8512
-	bool "MT8512 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8516
-	bool "MT8516 SoC pinctrl driver"
-	select PINCTRL_MTK
-
-config PINCTRL_MT8518
-	bool "MT8518 SoC pinctrl driver"
-	select PINCTRL_MTK
+	help
+	  Enable MediaTek pinctrl support.
 
 endif
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index f90c74314f4..983de040ba3 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -1,19 +1,19 @@
 # SPDX-License-Identifier: GPL-2.0
 # Core
-obj-$(CONFIG_PINCTRL_MTK) += pinctrl-mtk-common.o
+obj-y += pinctrl-mtk-common.o
 
 # SoC Drivers
-obj-$(CONFIG_PINCTRL_MT7622) += pinctrl-mt7622.o
-obj-$(CONFIG_PINCTRL_MT7623) += pinctrl-mt7623.o
-obj-$(CONFIG_PINCTRL_MT7629) += pinctrl-mt7629.o
-obj-$(CONFIG_PINCTRL_MT7981) += pinctrl-mt7981.o
-obj-$(CONFIG_PINCTRL_MT7986) += pinctrl-mt7986.o
-obj-$(CONFIG_PINCTRL_MT7987) += pinctrl-mt7987.o
-obj-$(CONFIG_PINCTRL_MT7988) += pinctrl-mt7988.o
-obj-$(CONFIG_PINCTRL_MT8188) += pinctrl-mt8188.o
-obj-$(CONFIG_PINCTRL_MT8195) += pinctrl-mt8195.o
-obj-$(CONFIG_PINCTRL_MT8189) += pinctrl-mt8189.o
-obj-$(CONFIG_PINCTRL_MT8365) += pinctrl-mt8365.o
-obj-$(CONFIG_PINCTRL_MT8512) += pinctrl-mt8512.o
-obj-$(CONFIG_PINCTRL_MT8516) += pinctrl-mt8516.o
-obj-$(CONFIG_PINCTRL_MT8518) += pinctrl-mt8518.o
+obj-$(CONFIG_TARGET_MT7622) += pinctrl-mt7622.o
+obj-$(CONFIG_TARGET_MT7623) += pinctrl-mt7623.o
+obj-$(CONFIG_TARGET_MT7629) += pinctrl-mt7629.o
+obj-$(CONFIG_TARGET_MT7981) += pinctrl-mt7981.o
+obj-$(CONFIG_TARGET_MT7986) += pinctrl-mt7986.o
+obj-$(CONFIG_TARGET_MT7987) += pinctrl-mt7987.o
+obj-$(CONFIG_TARGET_MT7988) += pinctrl-mt7988.o
+obj-$(CONFIG_TARGET_MT8188) += pinctrl-mt8188.o
+obj-$(CONFIG_TARGET_MT8195) += pinctrl-mt8195.o
+obj-$(CONFIG_TARGET_MT8189) += pinctrl-mt8189.o
+obj-$(CONFIG_TARGET_MT8365) += pinctrl-mt8365.o
+obj-$(CONFIG_TARGET_MT8512) += pinctrl-mt8512.o
+obj-$(CONFIG_TARGET_MT8516) += pinctrl-mt8516.o
+obj-$(CONFIG_TARGET_MT8518) += pinctrl-mt8518.o

-- 
2.43.0

