Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEDBC4451B
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 16:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 430D6849BD;
	Sat, 18 Jul 2026 18:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="HCV336Yy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98BEF84659; Sat, 18 Jul 2026 18:16:39 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E0BF848A1
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 18:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so7673065e9.1
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 09:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784391397; x=1784996197; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UfaiuGsGMlpTI7Z2M5Ujljl5XqmF1j7Y17WrOtdiHmY=;
 b=HCV336YyWCNha2rWFjE9qRNQwBQNFs/opVnFo9br0JFavUnwY+wLAYUZbqqvFJa4B/
 uN211YQVk/pSEXRj8yY04t6o3X3p/PkeTzzMCnTYsia5nOD6OTL18pWPblAEJ+KCG2xH
 O0yZ+VWqEYJlM3bInfIjuQ03J/Vp6h+Qr8g+YDxZ1fyHPJ7vIK2+lWNejMLe8xWnjlIp
 rMtxCZiWcng2KvqxBZMzLAGHbXf6afz3Ta4sCH0FNmRjEgOOB/n+7d34XWQ/16u+FwV2
 3F1CpryabEEzR6bAo1LzY8SAhV34RqNsl7ofwZhbzFDq4KBE4sNzhqT2NXG+vyqwa/XO
 kUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784391397; x=1784996197;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UfaiuGsGMlpTI7Z2M5Ujljl5XqmF1j7Y17WrOtdiHmY=;
 b=LSr8LolCh/ulmkRIjyWbHQgMDg1bX0D2XYXJC8P0e+Ls2END5f2EAvbceS5NoBiFlV
 JwVDgOcT5bkdrhRwBp2NmKLI+b93z4sVhNf3N5a111d/ix3p9tQvfg/FnAZkGEQbxfF4
 ONTSioBqaGR0NVFUbxDDlDEcRYOmKQ+ymj4IiMTdIJjXUu85IdV8WuolKDX+r7uzPXG8
 S+mvS69ugk6DM6JiQ3RB/QDgwqth/K5CvEptMt7eAHytU+Wo8KjsemUPcU1hNf2SuH02
 i03XfasT1tgukUU7XeQRsxJ+kccIEMgf78ntKZ/Wz2YOjMuNZfZ1WO91MO8APoXNxVvP
 SyzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqIyUHlteyNmqsKH5sXqgm8M+GxduMN+7GAPN3qU9qAp0mU+jPxGM1bHOPjVpijdk6eEzEJAZc=@lists.denx.de
X-Gm-Message-State: AOJu0YyCQcrxRQ0hYkMxtKP6Z3Pk5m4Rixn5nq8NwJMh1k5fPKDxFdA3
 Lk8JsOuLAiB3yd1SdyO6LEmkA0HyIdBJnpczUtWvknoPVYiaLE6d9Ub7iNz8sf2m/Uw=
X-Gm-Gg: AfdE7cnKgFfoIMAykDeaeGNUTG1FQ/c51x2CtSTbhhCB7JFDZhqN6+/mgvcd4jLvGGA
 EIm9X1yu04llKweqt7n8jEuyyoQfuD6DcdkUgOawBnxhfQyCJis1fcwMGeDIvStal8e8nHr2zM6
 Nc09gceWwez6Yp/U9qN6gKgDh49t3iQsGlsuH+y9UgiidF3HOkW/r8ptQ8SWT7yo49gLk7jGp1Q
 Di4XinkW8OuVUIzewMYH+YHz0F1tHTxjBufOrwhMTITh9q1E9lz2qWG/HeG+blUlNNv2+zUHdTD
 cKQA7HCAPkEniX8RXEOEYQd2GW1LB+BAzlwwkG2ERLKuKyPVykl8gmd5ltqH8l6utaNqC5xfMIa
 FP66wKR3LjrtZIIDr8yiVOhUszhI0yili8Na/nnUTrqhHXlh4MUNhVKldJ33CtU4oaGVDJzz7aA
 s/THyL6B85saKxH9gN32gF9xlg7RO5Z9+EgfkRRvuf2vDmruxSfG3wuECZO2vJwDwTYMTDlBM51
 7eklbFSaYVdtzvBSTrG
X-Received: by 2002:a05:600c:c053:b0:493:f13c:9c03 with SMTP id
 5b1f17b1804b1-4954a341bd8mr51330635e9.19.1784391396951; 
 Sat, 18 Jul 2026 09:16:36 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-16-115-126.retail.telecomitalia.it. [79.16.115.126])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495499d1d4asm88915955e9.2.2026.07.18.09.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 09:16:36 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sat, 18 Jul 2026 18:16:07 +0200
Subject: [PATCH 1/4] arm: dts: mediatek: prepare Genio 700 devices for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-ccaione-upstream-mt8390-spl-v1-1-1256b6dfda3f@baylibre.com>
References: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
In-Reply-To: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
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

The Genio 700 boot flow enters U-Boot SPL after an external DDR loader
has initialized DRAM. SPL then needs the debug UART and eMMC controller,
together with their clock, syscon, pinctrl and watchdog providers, to
load the firmware FIT.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8188-u-boot.dtsi               | 40 ++++++++++++++++++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi | 58 +++++++++++++++++++++++++++
 board/mediatek/MAINTAINERS                    |  2 +
 3 files changed, 100 insertions(+)

diff --git a/arch/arm/dts/mt8188-u-boot.dtsi b/arch/arm/dts/mt8188-u-boot.dtsi
index 6d1b2ab82da..131377d9a97 100644
--- a/arch/arm/dts/mt8188-u-boot.dtsi
+++ b/arch/arm/dts/mt8188-u-boot.dtsi
@@ -8,3 +8,43 @@
 	compatible = "mediatek,mt8188-tphy", "mediatek,generic-tphy-v3",
 		     "mediatek,generic-tphy-v2";
 };
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
+&pericfg_ao {
+	bootph-pre-ram;
+};
+
+&mmc0 {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
new file mode 100644
index 00000000000..ace9944ec41
--- /dev/null
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2024, 2026 Baylibre SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+#include "mt8188-u-boot.dtsi"
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
index 37ca35b4dd4..efd38d52338 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -21,6 +21,8 @@ MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
+F:	arch/arm/dts/mt8188-u-boot.dtsi
+F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_defconfig
 F:	configs/mt8390_genio_700_evk_defconfig

-- 
2.55.0

