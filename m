Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E24C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A450F40EC9;
	Fri, 14 Aug 2026 14:48:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uYmKRx5-SFeJ; Fri, 14 Aug 2026 14:48:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1266C409DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786718893;
	bh=P0RkIrcGfzspLwB+CiGRlP/RPVlUqeE7uDwERrZEY5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VEiQwyDXEOqyLZt9UElnxTs9YmJ2BZUhIHBvNo79qUzCn8m0we2AVfhmpJSxbuQUG
	 tOWfbh05HEc34knKyFkDuuy5+vxBt//f1Jy2VLlqbLX9D1rawyCatFGOpqpM9B8h7/
	 2uNN3jBuPIsvZGKJdBfXJQpe+fLqOEAFMUb8B66wQMys59PpoABqcf2wSUJXddFkYa
	 Z5lcUhGPe9ZQQyJ3AjGdsUKHLivxYQIl1nobVgwpGlbneGdc6nFkOhYaMbsyNKMh6B
	 jiP6x24SmT7ZV69VunFkDDtiStP3Hh5nCIBQ/O7S2OCcnuejse1DN3on9etbSxJO7m
	 EsdKTkImBU2MQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1266C409DB;
	Fri, 14 Aug 2026 14:48:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 537D023F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39E48607EC
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id moyqBvmhSMz9 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:48:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2652C607EE
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2652C607EE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=oHq7Ri1c
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2652C607EE
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:08 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c160420289bso152616366b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786718887; x=1787323687;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P0RkIrcGfzspLwB+CiGRlP/RPVlUqeE7uDwERrZEY5U=;
 b=oHq7Ri1c8nnNvghEMS4dd9KeHW1v9nVzh7OQisSmda4nTIRKaU1b2AzkGiVRA745Nt
 K4vTYEbXEE9h5GJhwnVz8GCfdVHlmjhowRBp0uEM1ssdmKsMW5tyh5dbjMIhl6ahvLrQ
 jnAUnPhoZrWQa/CQ5R+gBQTS6YLZvYyYZsmfx5X22bMX4jAqHw2AnT6TJ9ZKZn6Dq2JQ
 CuUfDCoDPWRA/ETcD5H6VCgG7T8ECzMZ4ATHWNF41WJSqaLeJ03gqscMwwnI+dZlLrgw
 VnFKmtAu1HHzikdFGMdE5EKY9AffSIs+gOAL+/3qwYYRuau3kWIwlFVyN0AWpy0HUuIQ
 VB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786718887; x=1787323687;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P0RkIrcGfzspLwB+CiGRlP/RPVlUqeE7uDwERrZEY5U=;
 b=O1EZIzqDTRZ3xmghPjVeRNi7CQQqsN+XB7vK/AlbQ/+N1Dmn6ljQPb/bdzLbTzeKHR
 aWjOAAg3g/vgggs9Ip7vMTVEHxXbddvxl/2zrYPtA8ta7yIdHd00joO5xaIAfijIARu0
 7dnXP6XyaSH5/KH0SdwoylVF7dNz5v9wEoFlcgY2tLjV58QyEl89fH298hlfgoKwB6PF
 e4j/kDua+/oTFSvE3Mir29ho/maww3ZXKNLnGYUfQW7DyUulIX/dA6fb/+aEoqGRNlfN
 j6tPrgyybNsOYhgxeA6qsdkPPTrD18Tjs7jJdioxBwP7waUUL/9BRdpK8bnRGeaEyK1W
 tg3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKdlWHr2Top5Ml28Z4r9L36M/P2FzaVsIrmzh7DH7JaJpVJ3Nt/IWZ680/Z3OEaYbC7VC3xeQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyl+4Sr77TNMEMn64fYyLRDpxhi20Dwt3y8kvdsVNgjjpmCdtEg
 NK+pV6CKLcLAPJW6LgsIrfAOWh/s1XU6Eg8P770wp82qEyPnEypoMWVbRHj8ANn/u1E=
X-Gm-Gg: AR+sD1128UnLI5lLm2iCkEuXfk09V4LGM35l4KpT2hjvA3/kJqLvC3JgSTJxhqR35gO
 EtY863Khu2d49RLo4rK0nJrA1jnvDpZyaqd2Lj59GNdBmqvwF6SUhnpTgnUvv6t4reIjJ13ptqi
 jCBro0Dq9gWTZWG50P0ZHYjZ2Fq5v4YScc56XemMqzwh0BOQjsNnigwSvpe6uRjY5YnpBcM+n9w
 sPuRNMJnCKV39MYAtscDeMQLPDFYMO1Qku60Q/nAh7azAQp44pscca1FIAnJbYVXWY2rIl1ry3S
 aD34rSq12pkxlTNlL62wQdS4MXutqiY6cbMwnfUpm+vtQnLyvEiydHDl6U0MFLf85AeqIERE9zl
 atOXYtpiuRraLJ2GvNinY0XDK7G+LSO+2aMokL8xhqpsbpO55ckxfJXypjMrKf7TJ2ZyKUBKG7Z
 9NTyv+kZPZrgNUG7TbDaXkAFQo6Q9ufySO5LMIb9dYqLCcY0P9xxK/Q7fAalT5SFPBWeLCMeGed
 cVZv4tyq82qna5BOJiPyw+3KA3n4bGowDZXw/wdfZvhue8GAJGMn7BnrMIJ
X-Received: by 2002:a17:907:fdca:b0:c08:417e:3696 with SMTP id
 a640c23a62f3a-c212a0f2e5fmr279051166b.20.1786718886942; 
 Fri, 14 Aug 2026 07:48:06 -0700 (PDT)
Received: from macbook.tail959722.ts.net (static-226232.rol.raiffeisen.net.
 [195.254.226.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c212378d9fcsm114992666b.34.2026.08.14.07.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:48:06 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 14 Aug 2026 16:47:51 +0200
Subject: [PATCH v4 1/6] arm: dts: mediatek: prepare Genio 510 and 700
 devices for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-ccaione-upstream-mt8390-spl-v4-1-f4f92978a79e@baylibre.com>
References: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
In-Reply-To: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.16.0
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

The Genio 510 and Genio 700 boot flows enter U-Boot SPL after an
external DDR loader has initialized DRAM. SPL then needs the debug UART
and eMMC controller, together with their clock, syscon, pinctrl and
watchdog providers, to load the firmware FIT.

Both boards share this MT8188-family dependency chain, so keep the
pre-RAM annotations in a common include used by their board-specific
U-Boot devicetrees.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi |  2 +-
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi |  2 +-
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi  | 94 +++++++++++++++++++++++++++
 board/mediatek/MAINTAINERS                    |  1 +
 4 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 586d15bf72e..1a5f45cba6b 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
-#include "mt8188-u-boot.dtsi"
+#include "mt8390-genio-common-u-boot.dtsi"
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 586d15bf72e..1a5f45cba6b 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
-#include "mt8188-u-boot.dtsi"
+#include "mt8390-genio-common-u-boot.dtsi"
diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
new file mode 100644
index 00000000000..87ebc64e6f6
--- /dev/null
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+#include "mt8188-u-boot.dtsi"
+
+&clk26m {
+	bootph-pre-ram;
+};
+
+&gic {
+	bootph-pre-ram;
+};
+
+&topckgen {
+	bootph-pre-ram;
+};
+
+&infracfg_ao {
+	bootph-pre-ram;
+};
+
+&pio {
+	bootph-pre-ram;
+};
+
+&watchdog {
+	bootph-pre-ram;
+};
+
+&apmixedsys {
+	bootph-pre-ram;
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&mmc0 {
+	bootph-pre-ram;
+};
+
+/ {
+	memory@40000000 {
+		bootph-pre-ram;
+	};
+};
+
+&mmc0_default_pins {
+	bootph-pre-ram;
+
+	pins-clk {
+		bootph-pre-ram;
+	};
+
+	pins-cmd-dat {
+		bootph-pre-ram;
+	};
+
+	pins-rst {
+		bootph-pre-ram;
+	};
+};
+
+&mmc0_uhs_pins {
+	bootph-pre-ram;
+
+	pins-clk {
+		bootph-pre-ram;
+	};
+
+	pins-cmd-dat {
+		bootph-pre-ram;
+	};
+
+	pins-ds {
+		bootph-pre-ram;
+	};
+
+	pins-rst {
+		bootph-pre-ram;
+	};
+};
+
+&uart0_pins {
+	bootph-pre-ram;
+
+	pins {
+		bootph-pre-ram;
+	};
+};
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index d99c6d708b2..d0d25b096e5 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -22,6 +22,7 @@ M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
 F:	arch/arm/dts/mt8188-u-boot.dtsi
+F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	configs/mt8188.config

-- 
2.55.0

