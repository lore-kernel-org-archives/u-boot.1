Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537151061B1F
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 20:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7171B8409B;
	Mon, 30 Mar 2026 22:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cVPK6pgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54AC384035; Mon, 30 Mar 2026 22:43:16 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F8480212
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 22:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d74aa6bcdbso2789627a34.2
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 13:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774903391; x=1775508191;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wyJu0hEapYhpV9QaRwo5ec8MxyUXDRq8s8z2mPJrfIc=;
 b=cVPK6pguaoNr2VQGmQUtV/eeW1c2XsVqeeZ0WtIXK6FYJiVQEU8i5JbgjmhCptLDVV
 vJZMY7mW26mW/0l+sgF5dNqfkNbfdIMqvmBknjJwjwdQJCBJCygrp4vhHfiStET/KVFw
 D0a6b+rIiTIGC4qZLwURHLXvremQxPI0tR1hn4fVemqevMshN9yFBqr96ojWRVn9xkhe
 tBZ8tUMahmCNnNmpo+QzVYm9DlNIc1m62xC9WbCxAUPA57bfr8oBMaCi5im34QGEavNC
 tNRqfpPbFoQMr92h5rQHiZWy1YHGiEfj93+TH5dEgalqJpn1Dpod8lY06NQ4V60iJdSm
 JlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774903391; x=1775508191;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wyJu0hEapYhpV9QaRwo5ec8MxyUXDRq8s8z2mPJrfIc=;
 b=B+SdrhoAukP2PWbUkHFleCRvyEU8u1Yyirc9EEf5pCwkbr9+0rGozDG2oKKMJ/Vq6w
 IiHBmh/BxbtLGzUOcjmi9PRAWqEkSpKpRYeKUmXxtcVCEIRT84px1Xq0GGq0FTD03HKw
 ecDM5mVzwzOocsL1jpvq75Kq4alR24KFORX+cl5jsjFYBJ39u1NC86PoKZoGCOp19fS7
 3IN8kxKSnTOVW056gcZaA3rIoUKbz05O38SfiGS1VH0+4h/7GZk8ZCM3R3qq+FHEeNOi
 DNmWephQCtLiM+PJfabjfUE4EGP0P1DR5QVz9eBfB2NJz6ZsotfVrazgJsFA3p3dK3qG
 5vUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvhh6ZC8f0l9bkY3TQBx7vK3iadYKUlrtxsXJXOg0hGOwmCPCzTQ83CSngDh2JWDz0xMirU5U=@lists.denx.de
X-Gm-Message-State: AOJu0YxJKMOPDeKI2x2AwUrONBIAu4ljceyHbiz1mSMugi40oJVzM7oS
 9s2UV3YO6X3OKJdfjW32jhi9yPBH1fwPTcZQWJ0rzQI2I6j//1OXepL2FGOoPVxY/kI=
X-Gm-Gg: ATEYQzwdLbgGQGwTyo3jFeIuhlu+6MpqCmmKQRd1CT6ZjI06Rc2OZZbbXvqcW9Xu+ZQ
 KKOioE+umE0e3xN5Wbfox8v7fc/yJ0yulIlcf/m1IW2r8+Ue+5yq7Yd3RCTYinPCbVokN9aOlJb
 l5SRdkma0axkGiF0d00KA0RbvPNHSHKIEOU4KSkrck6lPoxcLbAyb+aYva4IdPzuIjs0clEy/OR
 hd8YK8RiyEk1fmL5D1e/2cic0Qugm/gITDdRGScUZ97LYhuGWBN/zUv3WHi/4je0lg04MTulx2U
 zBOcRxWHA7X6UuKmhEPzOwFXPKRha+8BmEVSq80unGUFjfOPja1j53FzoujGg3pN7qHugwXoNYM
 eaTUzSt4zCYXiXxLWW/PUGCuwvjtZusRHYiMGbd0PevZW/4jbe7QH4inTmbwsHE9d0Q6XguU/nq
 Mes0Kwa62GdgtA0CssXHosCWEGzl6o
X-Received: by 2002:a05:6830:81c5:b0:7d7:d54c:5b53 with SMTP id
 46e09a7af769-7d9faf22747mr8074524a34.29.1774903391131; 
 Mon, 30 Mar 2026 13:43:11 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a384631sm6595736a34.7.2026.03.30.13.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:43:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 30 Mar 2026 15:42:17 -0500
Subject: [PATCH 5/6] arm: dts: mediatek: add UFS variant of Genio 520/720 EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mtk-genio-720-ufs-v1-5-3bad8362ed70@baylibre.com>
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2504; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=xaJIIk/MXQ68QI9Fs8KqSRYEdB3WcvRQDizsjxfCtEI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpyuBMibSnmJfuUy1tR+9vGXCYeJN1gx10yNzoh
 5hIZER3cCyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacrgTBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJSkH/RLl4zQU5qz+Bw1tqZR1THi0TwWtoHRq1eYIuRM
 l0IRHhHm3yozNFQnz1NO1Oy2xcFeHc0pnq0MBcaeR4Elh5T3v1O9meyuIGRYnR8bPKWkL/gaoxe
 AISIOLz6VrCp8cWkKBXh3KWMXgenWHyWQ26OmZuO6iIYMeNOIccTP4KPWpPs/cMBrr+bgf3lht2
 QzDgXyU+cCsVxs+CeYPE8ABBwBkwGMdXHzQ+fUROE722Mk6Xl1mgoINLUsMfiXneevvEwbfsL7D
 QOeBCp2RopoO6noVtfOdbVbRQP5Z6YwutV6b0+jcltJnD5GHOoHK1dBeb3Dg/IHmOSDGSZm28e8
 c0no=
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

Add a devicetree overlay and UFS variants of the Genio 520 and Genio 720
EVK devicetree targets. There are dip switches and jumpers on the EVK
that disconnect the eMMC and connect the UFS instead. The overlay
adjusts the devicetree for this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/Makefile                     |  5 +++++
 arch/arm/dts/mt8371-genio-common-ufs.dtso | 18 ++++++++++++++++++
 board/mediatek/MAINTAINERS                |  1 +
 3 files changed, 24 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 4085d4c2de1..bff341d6118 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1105,6 +1105,9 @@ dtb-$(CONFIG_SOC_K3_AM62D2) += k3-am62d2-r5-evm.dtb
 dtb-$(CONFIG_SOC_K3_AM62P5) += k3-am62p5-r5-sk.dtb \
 			       k3-am62p5-verdin-r5.dtb
 
+mt8371-genio-520-evk-ufs-dtbs := mt8371-genio-520-evk.dtb mt8371-genio-common-ufs.dtbo
+mt8391-genio-720-evk-ufs-dtbs := mt8391-genio-720-evk.dtb mt8371-genio-common-ufs.dtbo
+
 dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7622-rfb.dtb \
 	mt7623a-unielec-u7623-02-emmc.dtb \
@@ -1125,7 +1128,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7988-sd-rfb.dtb \
 	mt8183-pumpkin.dtb \
 	mt8371-genio-520-evk.dtb \
+	mt8371-genio-520-evk-ufs.dtb \
 	mt8391-genio-720-evk.dtb \
+	mt8391-genio-720-evk-ufs.dtb \
 	mt8512-bm1-emmc.dtb \
 	mt8516-pumpkin.dtb \
 	mt8518-ap1-emmc.dtb
diff --git a/arch/arm/dts/mt8371-genio-common-ufs.dtso b/arch/arm/dts/mt8371-genio-common-ufs.dtso
new file mode 100644
index 00000000000..b75fdafcf9b
--- /dev/null
+++ b/arch/arm/dts/mt8371-genio-common-ufs.dtso
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ *
+ * Adjusts for when boot DIP switches/jumpers on EVK are set for UFS boot
+ * instead of eMMC.
+ */
+
+/dts-v1/;
+/plugin/;
+
+&ufshci {
+	status = "okay";
+};
+
+&mmc0 {
+	status = "disabled";
+};
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 7a388409742..b0fbffd26ea 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -3,6 +3,7 @@ M:	Macpaul Lin <macpaul.lin@mediatek.com>
 S:	Maintained
 F:	arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
 F:	arch/arm/dts/mt8371-genio-common-u-boot.dtsi
+F:	arch/arm/dts/mt8371-genio-common-ufs.dtso
 F:	arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_520_evk_defconfig

-- 
2.43.0

