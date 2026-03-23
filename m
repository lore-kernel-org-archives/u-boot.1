Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986D7F483F7
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 20:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCC378410C;
	Mon, 23 Mar 2026 21:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M8wuF000";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221478407B; Mon, 23 Mar 2026 21:18:14 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14A73838BB
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 21:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-40f1ffba6a0so350803fac.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774297090; x=1774901890;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=82SwtGQ5GHkSM67wD8bDlqdHpk+S8pP+vBp6XxN/6PI=;
 b=M8wuF000xGq1bU+7w6bewUSApxtGXoKWK90Zfpq/5fyT1Yt4px/2qA5XJpk57U7iN8
 25PTF35qAvEtB1T7UUyPNVhmSIC/1Fgb3sPAHxj4vY7xg/dKNtGjfW5ZUepK0Oj1z3N3
 vWN7C5jVPvJ9J+qgZSNbhIaK+JjdUAaBK8CvXFO4fDajc+aWAZfPI4Nb16R5NnjwD2xI
 ROO0Vw5Wf7hD3uBd7mwZXw80k92ZoKaLmiVfW5+0W5XFo2v1OoWHYdspUaopCAtrLR5j
 OUKPsgrPJYrXbQbdkAq6AaQithN4TFiBB59yKFeG4PBVzqBPpOHlHg47PXBaOCKNXFXK
 cwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774297090; x=1774901890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=82SwtGQ5GHkSM67wD8bDlqdHpk+S8pP+vBp6XxN/6PI=;
 b=OrWYK3FBmJlLukSqWxufSJHEiFm0IrrqZRqGI5/qbZwC79MwvSYbK2XOvIjwvKXAhb
 Ad9NWR6weRsQK/Buf5x9MNsglfRiYb57fm62QShLj77Jv+BeYgJXyNt0swq8Fh4SMrN2
 hPr/ARsUU4gXYTh51ubI2DPrq6m4m8v1/m7mD+jSaeDg3gL8Q2pqicWXg0TAFdJwx0qJ
 I7Ak70XRQbw/LbS/EBHhTDCVyqs3UFXrobDUx/PcMsnWmoPhd7jE9FD7o78hUcWnKQW6
 soIunjSa2FmmXCvwO7tJXslT2MLVkOzs0pQOnaIJzTr663mShBfnpt9ic5nL5VFYw2pa
 B3vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlq+5Br8lpLp7kRjHRyelJ+3wWyQspKwnhQEaYeW9iT6XKua38aECLXU08jIaDp7SP1bsOHz4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6CF320pQDAJi0ZgAZfn94c9pVvT9d6yGTgsjGa2El0j1+czB3
 Ibly+y+0BHm106tscUg0MFFqCOOW40F+gJUe7fxbhw0cqRexqA3wUjV6x+P3QvVdifg=
X-Gm-Gg: ATEYQzyfbnKx7ltvshBH3RkzVMtoFd8ZwUrgnbWN/YTPfWltdrVi0LwDJEHwvuWNSuC
 PBaAVeXpA73fR7fCHmZ077jIUPUcoRWQUQxegDMQGAII4vz6nMQFCLBm8tDlSjVGKPs3xVSKICt
 wIX7bhz4dz6BvuW5nZMUMYAz31eFr435ZKTMsh953Lugz+4ILjzzBLN29VxN+BUIhcPrVcUIpFj
 kbGb/GwEu8K1kjKbN9XA8iT+tBCix3MNGxW4t0KMgWlCBe9XfS34O2OTCxBh/vqpGVWPyrIlja6
 Ajn2+QCNMyIAKuyEwG3+dLNyNwHk0B7gqhrfYRKodC7d2ZYPHt3aSEwmhyoCMgpRwVS7KnN1zQC
 UmDx97uG/ax4t4l76BzONuOgZXBmfgCMYC/2hE4Ni+GMqxx3xiDueqPZDYHS+0SCbxcbXwbJZC2
 sg1le3UO+lxtnT5BQxTP/I2ZtR0A8=
X-Received: by 2002:a05:6871:4515:b0:40a:4467:d5 with SMTP id
 586e51a60fabf-41c11007391mr9100064fac.14.1774297089684; 
 Mon, 23 Mar 2026 13:18:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:964:f712:dbc7:4119])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c148a5ca4sm11077540fac.3.2026.03.23.13.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:18:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Mar 2026 15:16:57 -0500
Subject: [PATCH v3 6/6] board: mediatek: Add Genio 520/720 EVK defconfigs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-mtk-mt8391-initial-support-v3-6-19dd92f4543f@baylibre.com>
References: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
In-Reply-To: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=IQNKpCJGNHqi39Rjo9d72dnAYKEtmvjrwAmyYsWd0Q0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpwZ/xUbnW/BFE7U+MEmLqp9LgwNj7JIUoH/F3x
 JpI9rZ726aJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacGf8RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AmlIIAICf9lRdpurQHNWLcQMOgVniqMZZBz0sF1Zp5FG
 bn6eE1NV6DSGH9IY4zjNxzbvrzD2dyW3klbJ+nZP1+Sv2rHBRBK4u8MDR8hDXCWW+oQiZ9xpdy3
 MTc1bMSzdmr23+YusARvhk8rgyS9mzClboDDjh0AS9d7YGNMZQ04z8jmg7PDF+0SELOC/YOxty6
 C9jX3P4AWHVeb9Tj+S3cZhWyUIr6Ylosr2Y0lmr9O6m0pWy8pSjRS1kj4TUE0ikORskpkMkrPt+
 CdDt1deE12k0BhqJLWAHA9/wADLA6cz3VxwscOvhDn0k47Q83sunYztTN16IALAXsDFrWpaUU1w
 mzao=
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

From: Chris-QJ Chen <chris-qj.chen@mediatek.com>

Add basic defconfigs for Genio 520 and 720 EVKs.

Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS             |  7 +++++++
 configs/mt8189.config                  | 34 ++++++++++++++++++++++++++++++++++
 configs/mt8371_genio_520_evk_defconfig |  4 ++++
 configs/mt8391_genio_720_evk_defconfig |  4 ++++
 4 files changed, 49 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 446a9e8e53c..4f371592059 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -1,3 +1,10 @@
+MT8189/MT8371/MT8391 EVK
+M:	Macpaul Lin <macpaul.lin@mediatek.com>
+S:	Maintained
+F:	configs/mt8189.config
+F:	configs/mt8371_genio_520_evk_defconfig
+F:	configs/mt8391_genio_720_evk_defconfig
+
 MT8365 EVK
 M:	Julien Masson <jmasson@baylibre.com>
 S:	Maintained
diff --git a/configs/mt8189.config b/configs/mt8189.config
new file mode 100644
index 00000000000..966d05d1a03
--- /dev/null
+++ b/configs/mt8189.config
@@ -0,0 +1,34 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_TARGET_MT8189=y
+CONFIG_MTK_MEM_MAP_DDR_SIZE=0x200000000
+CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CLK=y
+# CONFIG_MMC_QUIRKS is not set
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_MTK=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT8189=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MTK_PWRAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_MT6359=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y
diff --git a/configs/mt8371_genio_520_evk_defconfig b/configs/mt8371_genio_520_evk_defconfig
new file mode 100644
index 00000000000..9a5e68e48ee
--- /dev/null
+++ b/configs/mt8371_genio_520_evk_defconfig
@@ -0,0 +1,4 @@
+#include <configs/mt8189.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="mt8371-genio-520-evk"
+CONFIG_DEFAULT_FDT_FILE="mt8371-genio-520-evk"
diff --git a/configs/mt8391_genio_720_evk_defconfig b/configs/mt8391_genio_720_evk_defconfig
new file mode 100644
index 00000000000..3fcd08be50a
--- /dev/null
+++ b/configs/mt8391_genio_720_evk_defconfig
@@ -0,0 +1,4 @@
+#include <configs/mt8189.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="mt8391-genio-720-evk"
+CONFIG_DEFAULT_FDT_FILE="mt8391-genio-720-evk"

-- 
2.43.0

