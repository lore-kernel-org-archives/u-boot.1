Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F71F013FA
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 21:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81A45841CF;
	Mon, 16 Mar 2026 22:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PkG7qNmS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C318884221; Mon, 16 Mar 2026 22:55:51 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C03D84201
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 22:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-41708e43f61so1726071fac.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773698148; x=1774302948;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CfYZNCtV9OQ4ecTRu7DE+nTZi5RBhyep6GrSkNvYwFU=;
 b=PkG7qNmSLn3a6+Keq/FxjZd+e8KiPUfw9DeXpKTGkMdAEFCPeTk060fJHQmpM5BHYy
 ZGqX0K0bmisOUm9fk5z2tJxL8ziu5ViEkuZyBHj/D1em1Nv4qXeEgd3B35x88mr/ZEVa
 VPsUFNhPb7SIoc1q61JiCMRN66oge921+2CmGQ1IDJ3qGz4/qCIoB9k55VHCwAjVS1Ee
 y/sRc0TARjZheJ2Gp1DNmVkDnWZQaEm2od5fVsT62B2kgqG/OaNCpLgFPFpeD1V1CBPq
 z74/CMIm2QuHhapqwuAETE2Tn04pqKlzCJDLYtrYm7ycF25PtXTHeUHIQ+j704OqOjmT
 F6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773698148; x=1774302948;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CfYZNCtV9OQ4ecTRu7DE+nTZi5RBhyep6GrSkNvYwFU=;
 b=DLENR5BRgwfvGg6zf0t2rUzWAI1nAt4KKGDVT9k/6/wB3aFSiI2bwqWflqFuI6gOpK
 N+Ocf8iXyFTEgztnDw3zA30jwIykf8G/OBwlEsgvcFCMiFihuL9eugmKE1KUnrEwi8KM
 vK7QGXtqwvdfLk7S1AfRM5U1ckEQGEBus91qtTFVwcA1fqXN3jZtRQug/FqefTQ+1aAC
 EPDZ78SkhPSp1H4vJJK1hsJMdrCso6qKBLLb88N8dOUQf9VXcIg03geRRSOLNqX6rPfI
 jxFdgpDjL3Sk7LdDdIH+cIHy4xlMlrFjF5fMtbAo0UM+TBgX3piifHBqvlXQod48vtvD
 YQUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMor1sdgp8ZScrLl2PBIn5ahqw522qkNsudIVOxJNjJ90OrDKXI7KIq5GmbgGN5ZzAMAD2wio=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+UgYQAcIvUl9tw4onh5AMUKpJQKNVle98KaAjPHqduZPa4dHJ
 KENB8sbwkkhBmi1GZIBp/pmxrpEQUDDOvZ9npPUoR2g/VpAhfi+rvO3AMhw8g4PtZJo=
X-Gm-Gg: ATEYQzxxiIXwu+thi4qmmkAemClRhOJGVfPyaRiZ+4lYn1bmbx5kc8NLT3A28+4BgGV
 YAPpazpa18L50Tv2r5FTyxqeF4mwK8J7kcuX9Op/tCq5VG7P6tV+oGNzFVu91UU8XIe81/xBoEy
 Ue0ZQFz8vanq/tlTY99j6OjPBlxE5jneAzN7wjh+dQtWommrSaDOi5Ku8PyQwS+JkTaEyc2EQ+I
 p+56Y6Dc7Y0T3WIk8eooPwwaAYhdfWoS4T/CKmufzZ5rjg/xPgklO12cwH1kjr8Xc7ndvQxIRCD
 MBdMAElesHaG6lEiQHsc/J3WvdYUZfDzouEK5+o/HlwcfjT4Jiw7NQ5RYO7mR5QpY28hAj6MHP7
 wNEDliP7Wm8mQvpp/xHSOXU/V8X1cElT1qKUPxUKj3upDJNEmMIoMsmVgqOkUzDU4FmsvxQy64j
 Pms5fxpjAmEistPG6Lc4pflL73pSs=
X-Received: by 2002:a05:6870:2391:b0:417:837:6360 with SMTP id
 586e51a60fabf-417b938fc20mr7894811fac.29.1773698147924; 
 Mon, 16 Mar 2026 14:55:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6995:28aa:eeda:102])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41791432d87sm17978547fac.1.2026.03.16.14.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 14:55:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Mar 2026 16:55:15 -0500
Subject: [PATCH 2/3] arm: dts: add U-Boot overrides for Genio 520 and 720
 SD card
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-mtk-ext-mmc-boot-v1-2-1aae51a44705@baylibre.com>
References: <20260316-mtk-ext-mmc-boot-v1-0-1aae51a44705@baylibre.com>
In-Reply-To: <20260316-mtk-ext-mmc-boot-v1-0-1aae51a44705@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2869; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=YZbzblvE8Zo6ibCs6KVL99La42BVPuN+DE8H/QNnKog=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpuHxUhTrgOoPqQ87g8QbAIGUhO8n+QDaANL55m
 n8xRZ3mQWuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabh8VBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ayo0IAJjrw0T6huNKl1k+NXqYvxXkc/lR613ygEB5rmK
 b/vb75bK0gFt3/wpGjDmM1ag3sZPrBs00H8PtzDE7t0dpJFu/5g2KdVZbZ2f4t1sdlILZ29Vzrr
 xMMcWlTRWAXPrUJDXDXkCxvtpeITUq4z4au0qgw/dZAtBnuQv62mxVzaGTN9lM80KDmOoQNaPqk
 mTTqvPp2zN+w8jdUdY4N4JkBtFUsIY6kBBcxujnz250Xyya9+JUyPHy96zYYirfu9suRNSSTb7N
 T/NKQFLE9eMVzBT/7DYfExAOhj6XV/Ak4cOkP+GJ6IrvnLcuS4CpEFiT+FVNJAFJUFaS9/YOags
 yNYk=
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

Add U-Boot-specific device tree overrides for the Genio 520 and 720 EVK
boards. These are needed to enable SD card support in U-Boot due to
current driver limitations. It is expected that these files will remain
after eventually converting these to CONFIG_OF_UPSTREAM, so we use
separate .u-boot.dtsi files for this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi |  3 +++
 arch/arm/dts/mt8371-genio-common-u-boot.dtsi  | 28 +++++++++++++++++++++++++++
 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi |  3 +++
 board/mediatek/MAINTAINERS                    |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
new file mode 100644
index 00000000000..a69e2db5a04
--- /dev/null
+++ b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+
+#include "mt8371-genio-common-u-boot.dtsi"
diff --git a/arch/arm/dts/mt8371-genio-common-u-boot.dtsi b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
new file mode 100644
index 00000000000..b7a0c0a82a7
--- /dev/null
+++ b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ */
+
+&mmc1 {
+	/* U-Boot driver doesn't support UHS yet. */
+	/delete-property/ sd-uhs-sdr50;
+	/delete-property/ sd-uhs-sdr104;
+	mmc-no-1-8-v;
+};
+
+/*
+ * Needed to trigger U-Boot auto-set-voltage. Default voltages for these
+ * supplies at boot are incorrect and U-Boot MMC drivers don't set them.
+ */
+
+&mt6359_vpa_buck_reg {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-always-on;
+};
+
+&mt6359_vsim1_ldo_reg {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-always-on;
+};
diff --git a/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
new file mode 100644
index 00000000000..a69e2db5a04
--- /dev/null
+++ b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+
+#include "mt8371-genio-common-u-boot.dtsi"
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 4f371592059..49041c8899b 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -1,6 +1,9 @@
 MT8189/MT8371/MT8391 EVK
 M:	Macpaul Lin <macpaul.lin@mediatek.com>
 S:	Maintained
+F:	arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
+F:	arch/arm/dts/mt8371-genio-common-u-boot.dtsi
+F:	arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_520_evk_defconfig
 F:	configs/mt8391_genio_720_evk_defconfig

-- 
2.43.0

