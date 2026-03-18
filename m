Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E338310775E1
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F1B83E36;
	Wed, 18 Mar 2026 17:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2o+ojQSR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C0378341A; Wed, 18 Mar 2026 17:45:29 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E3FD836D3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso4811740f8f.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852325; x=1774457125;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HQhxY8YCNOST9v7g7no9OzoAAWVDdfDQ1BwEtM3GDVw=;
 b=2o+ojQSRwFmDv3WeCLqRggGbe8shznPAJMm+HtEwGZAOgttMiX0hmFO9YTZmG3WGHk
 tGhP7zj6YegCbeyWJMjxW5GYUzR2QzKmx6rILrc7/zRCJHOzHYkDs+RxGgxSydbUaN0D
 BEBfj6PsAJb2nHBq1yhrCyQVWazXMkhTpPEHLeaisGaWtum08k7HZDFEj6IS58GjxXlo
 5epy6ruotpF8n9d12wX1w0fyX7ovPAqxX5G0i51iFBDscNW7pkiPeac5+UUETnCOpFBn
 QwGPT6sW46P5/MYfpq478sVgy3JLoZcbGFv9+t4gFk7PTF4Oz8NFKvswifoDvPFoxmPg
 BwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852325; x=1774457125;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HQhxY8YCNOST9v7g7no9OzoAAWVDdfDQ1BwEtM3GDVw=;
 b=TGKBO4bVS76AGCLpiHjLYnehHqZpnm31KNQmvgoS4TB0O+aEpfbMnWsB6AWwB/dUSr
 1KxuDLSWHS1fywZTC8ryyQJ4WghaBhVdJx3Nnw1t9rHCX5sgL7Z9dBmUSw166IKHZ3tC
 WUalv9NldDSErerzu6wv5pWKLBWLW0ffXSvVu8za3XSD3kmmzJtLLAhwz99eTPoFsbBj
 geqNo8wbNK+z5ksrzAm1X8L5pKXj9moMtVwAuBFu7EwynruHtZJ6OA2kAx/lKMFS+1tW
 nryCUXnXrvKAFqmhghN9ECrHufXxBpQYz+xyBLkKHPUChZTnG3ihaLfOvuAjtLETfJBi
 wvfA==
X-Gm-Message-State: AOJu0YxBaIM/itptjtPFWl2w8p5zuh00f1HLGzScAEAnGO+sQYrEzN+2
 YCKZi4NLUfAsd5Eswc6BpQCwom6ybEWTmq4RgN/JrTwGW0VSFVwjy6vjLUTOJWgojtY=
X-Gm-Gg: ATEYQzypOShxLz12BQUg5aCuT2FAeUqegwWegDFipZQr3o4P06dWtiylkV4EzHg8qSU
 1O/uNdu1nvLCC2mgcOLkMbd7KOd3+5Zp2UxM9dEcMuyZsh6rebx6qst640wvQ7jINJfX+K4X5j7
 ukJM28X5b+h/6EME+J21h15ipkHAdy1T08u4NfqDDZZdyD44wrPQ6DeJLlte/BoYU+zzm3ZG2pH
 cgVlR8eKrMdMama0xBF/HCG63dnuNduymPbnF1AnFst2mtNnIzg3WXz0CFl+KcAwo2yyZcotWsm
 GSj5C/mAnKICV82s+7AHW1cFF+LUX6chCOedhaWZToYpPH/xuNzgrbNoIYmFKLqgho+IDadJf0c
 yb6tTzfzg05qqc6+Zwfi9aEZqCUrz2v/QWYCYzNgY739TJB4NzNL/9Ci2GQ7OcqinEy6B8C2ujF
 o07gZ1P0sTSdixU31N0H3ai0SlP7lx4js+w1whUQnOpYZfZ5ICdXVoc2MoZrweRYynwsOTRICik
 aocUgxWXTO2PWcqqecdAklwwvwEw5pjfuGYBPWTEVGnFNyekwZh5Qh+XA0VC5H5aWPIpRskbWnA
 xRMGkjY=
X-Received: by 2002:a05:6000:2307:b0:439:afd8:621c with SMTP id
 ffacd0b85a97d-43b527d2f29mr7068470f8f.55.1773852324982; 
 Wed, 18 Mar 2026 09:45:24 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51852a64sm8612085f8f.14.2026.03.18.09.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:45:24 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:45:27 +0100
Subject: [PATCH v2 5/6] configs: mt8370/mt8390: introduce mt8188.config to
 avoid duplication
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rename-genio-defconfigs-v2-5-1f77580d72f3@baylibre.com>
References: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
In-Reply-To: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
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

mt8370_genio_510_evk_defconfig and mt8390_genio_700_evk_defconfig are
both based on MT8188, add a new mt8188.config file to share common
config.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 board/mediatek/MAINTAINERS             |  8 ++------
 configs/mt8188.config                  | 25 +++++++++++++++++++++++++
 configs/mt8370_genio_510_evk_defconfig | 27 ++-------------------------
 configs/mt8390_genio_700_evk_defconfig | 27 ++-------------------------
 4 files changed, 31 insertions(+), 56 deletions(-)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index a1f34a91ebd..30aa71a0ce7 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -3,15 +3,11 @@ M:	Julien Masson <jmasson@baylibre.com>
 S:	Maintained
 F:	configs/mt8365_evk_defconfig
 
-MT8370
+MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 S:	Maintained
+F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_defconfig
-
-MT8390
-M:	Julien Masson <jmasson@baylibre.com>
-M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
-S:	Maintained
 F:	configs/mt8390_genio_700_evk_defconfig
 
 MT8395
diff --git a/configs/mt8188.config b/configs/mt8188.config
new file mode 100644
index 00000000000..9dfba6bf99f
--- /dev/null
+++ b/configs/mt8188.config
@@ -0,0 +1,25 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_TARGET_MT8188=y
+CONFIG_SYS_LOAD_ADDR=0x4c000000
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_CLK=y
+CONFIG_MMC_MTK=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT8188=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y
+# CONFIG_RANDOM_UUID is not set
diff --git a/configs/mt8370_genio_510_evk_defconfig b/configs/mt8370_genio_510_evk_defconfig
index 53ef067af22..e3530571cc4 100644
--- a/configs/mt8370_genio_510_evk_defconfig
+++ b/configs/mt8370_genio_510_evk_defconfig
@@ -1,28 +1,5 @@
-CONFIG_ARM=y
-CONFIG_COUNTER_FREQUENCY=13000000
-CONFIG_POSITION_INDEPENDENT=y
-CONFIG_ARCH_MEDIATEK=y
-CONFIG_TEXT_BASE=0x4c000000
-CONFIG_NR_DRAM_BANKS=1
+#include <configs/mt8188.config>
+
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8370-genio-510-evk"
-CONFIG_TARGET_MT8188=y
 CONFIG_MTK_MEM_MAP_DDR_SIZE=0x100000000
-CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_IDENT_STRING="mt8370-genio-510-evk"
-# CONFIG_BOARD_INIT is not set
-CONFIG_CMD_CLK=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
-CONFIG_OF_UPSTREAM=y
-CONFIG_CLK=y
-CONFIG_MMC_MTK=y
-CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8188=y
-CONFIG_BAUDRATE=921600
-CONFIG_DM_SERIAL=y
-CONFIG_MTK_SERIAL=y
-CONFIG_WDT=y
-CONFIG_WDT_MTK=y
-# CONFIG_RANDOM_UUID is not set
diff --git a/configs/mt8390_genio_700_evk_defconfig b/configs/mt8390_genio_700_evk_defconfig
index 0ca4279c1ae..0b07e3be2c4 100644
--- a/configs/mt8390_genio_700_evk_defconfig
+++ b/configs/mt8390_genio_700_evk_defconfig
@@ -1,27 +1,4 @@
-CONFIG_ARM=y
-CONFIG_COUNTER_FREQUENCY=13000000
-CONFIG_POSITION_INDEPENDENT=y
-CONFIG_ARCH_MEDIATEK=y
-CONFIG_TEXT_BASE=0x4c000000
-CONFIG_NR_DRAM_BANKS=1
+#include <configs/mt8188.config>
+
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
-CONFIG_TARGET_MT8188=y
-CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_IDENT_STRING="mt8390-genio-700-evk"
-# CONFIG_BOARD_INIT is not set
-CONFIG_CMD_CLK=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
-CONFIG_OF_UPSTREAM=y
-CONFIG_CLK=y
-CONFIG_MMC_MTK=y
-CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8188=y
-CONFIG_BAUDRATE=921600
-CONFIG_DM_SERIAL=y
-CONFIG_MTK_SERIAL=y
-CONFIG_WDT=y
-CONFIG_WDT_MTK=y
-# CONFIG_RANDOM_UUID is not set

-- 
2.52.0

