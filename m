Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC84C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 10:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A38687904;
	Mon,  4 Dec 2023 11:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ieY8hx/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF09D87928; Mon,  4 Dec 2023 11:48:59 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1B387916
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 11:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33349b3f99aso618067f8f.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 02:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701686935; x=1702291735;
 darn=lists.denx.de; 
 h=mime-version:message-id:references:date:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/huvnVu1C+ZLKb7GuHOSp0tJ2TSZwuheJWpzPAkkv+4=;
 b=ieY8hx/SbMpOHvjEIb9Mi5iKgHwJQHc/ln5gPYJg3i3CxB/l/RMb4aPlxsNwRok8t7
 VYHPQYIsc+DbUbnFg/2iJuINK/jgsMzSwP0c3noGpjtMiXz+KOrNf+Wqpq3AQqWdYwZs
 3wmFlKEEBT3S5ZfQZsWj9dv2nFcIoGnCeCzWjER4UpdVwlCUByF7BZtvOPdBsW8gcA6r
 ARE5hvSE/dMjfkA4xH6uq7SpcfF+4DB075hruAl1zvWLK4e/euuM4R3oBhHJsJJb3pUI
 8Gqx+9dqokilNsQJf3Ou7kYu9ciopsgB511dfEj5JbtNmZb59YbnNvfZvmDYxvZh3tZz
 JyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701686935; x=1702291735;
 h=mime-version:message-id:references:date:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/huvnVu1C+ZLKb7GuHOSp0tJ2TSZwuheJWpzPAkkv+4=;
 b=rqdV3LOEwTeX5IykIRv70Dp1il/2X2GVfoPiLNByKjd83SBgCg3/Y8RGl98nlduuN/
 687SF/lgRFiEtfPtxlEhVZq7k5vuGBtz9ECjwxYueOgsyGcwfMnuuByIFxLuToiozgzn
 fiIuviiyTt8C2m3lKwMv440rpUA6/j5zaOTCDXP7hECuGC6j9bB6quVYIcLwgCMXjRpk
 zZkt4+lKEHaKcj9KfKXxhEqzDW+SAMJwY1AREgBBtcsyFz9nAr24l/XllKRSV6Cn2ROx
 55OsQThVzaBBGeiTt+gNy0kBLjt5nS/RlvP1HXivLQKgcHid1svzUmA2XwhtDKnq97KB
 oNzw==
X-Gm-Message-State: AOJu0YyPQ+aD9ZS6bjRaDQbcFf2Bcs50VwX5sD/59pK49y4Dc5uZhOaZ
 j+ctE3KK5VPS6s/bODkNjS1wKR86zyoleJFQQcnTvg==
X-Google-Smtp-Source: AGHT+IGQHEBRT5PIeDNnHhnNO1GIFKiOhfeuxz9SdBZOQRynzHvTfi8BZCQWMSXxdwdRBG6sW7haGQ==
X-Received: by 2002:adf:ec4d:0:b0:333:3a38:d570 with SMTP id
 w13-20020adfec4d000000b003333a38d570mr1597631wrn.111.1701686934978; 
 Mon, 04 Dec 2023 02:48:54 -0800 (PST)
Received: from localhost ([2a04:cec2:b:6009:c298:6724:4971:1296])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a5d4b52000000b0033334df1259sm7591074wrs.20.2023.12.04.02.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 02:48:54 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Sean Anderson <seanga2@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Vitor Sato Eschholz
 <vsatoes@baylibre.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 3/6] dt-bindings: power: add power-domain header for MediaTek
 MT8365 SoC
In-Reply-To: <87plzm450u.fsf@baylibre.com>
Date: Mon,  4 Dec 2023 11:48:53 +0100
References: <87plzm450u.fsf@baylibre.com>
Message-ID: <87leaa450q.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Add power-domain header for MediaTek MT8365 SoC copied from Linux
source code tag v6.7-rc2.
(commit a1571f1f333c2fced076f0d54ed771d1838d827f)

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 MAINTAINERS                                   |  1 +
 .../dt-bindings/power/mediatek,mt8365-power.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ec5311c8a2..3b13f26e76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -412,6 +412,7 @@ F:	drivers/net/mtk_eth.c
 F:	drivers/net/mtk_eth.h
 F:	drivers/reset/reset-mediatek.c
 F:	include/dt-bindings/clock/mediatek,*
+F:	include/dt-bindings/power/mediatek,*
 F:	tools/mtk_image.c
 F:	tools/mtk_image.h
 F:	tools/mtk_nand_headers.c
diff --git a/include/dt-bindings/power/mediatek,mt8365-power.h b/include/dt-bindings/power/mediatek,mt8365-power.h
new file mode 100644
index 0000000000..e6cfd0ec78
--- /dev/null
+++ b/include/dt-bindings/power/mediatek,mt8365-power.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8365_POWER_H
+#define _DT_BINDINGS_POWER_MT8365_POWER_H
+
+#define MT8365_POWER_DOMAIN_MM		0
+#define MT8365_POWER_DOMAIN_CONN	1
+#define MT8365_POWER_DOMAIN_MFG		2
+#define MT8365_POWER_DOMAIN_AUDIO	3
+#define MT8365_POWER_DOMAIN_CAM		4
+#define MT8365_POWER_DOMAIN_DSP		5
+#define MT8365_POWER_DOMAIN_VDEC	6
+#define MT8365_POWER_DOMAIN_VENC	7
+#define MT8365_POWER_DOMAIN_APU		8
+
+#endif /* _DT_BINDINGS_POWER_MT8365_POWER_H */
-- 
2.43.0

