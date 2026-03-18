Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA43103E168
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 12:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35A484132;
	Wed, 18 Mar 2026 13:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zx1L9/5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E524F8413A; Wed, 18 Mar 2026 13:41:29 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A0AA84118
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 13:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so7735041f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773837685; x=1774442485;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YztaU7EB6PHMqoB/m2tGHdKlmRwbZPK4NCTyxF7yTeE=;
 b=Zx1L9/5/JnFHMKGMbiXqBbZmtOkNELj1gRV/Yoy4Z3hBggwZeGjTjbVP7vGpEVgSt1
 WDzpoKJlgN1VZGqMCKqSqst0YwbHdAF6VPxzlnDq3obnEeAXg8KM61XjORXIWYMdAOMP
 WSPtVAsJ98oxNpsTJLvocAY0mOnuY48+0OBv4OmaFgYEE6RhUgbJlEFevseGR4hTlvRL
 BHBCQosYxrwx+vJn42L0ans/FCU+zFMh+5IJkcYJXeTmnLvw0KfhpwroHKisfjhcPU+o
 pspG1F2O0h8mxvfJk4ZC4ZqsFYRS0bPsatkDPCBFEfjn090WpfC132sZeajWprSp8+z+
 217g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773837685; x=1774442485;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YztaU7EB6PHMqoB/m2tGHdKlmRwbZPK4NCTyxF7yTeE=;
 b=YVCIf7z6s0Ou32ZrZM6F7pA6zWY1CfoMFJx4KDkDRvWWeARTITX8vf2rK0ez5cy2AA
 LMqePxmE3lCNyh68S8Qgw9kZcMjhK2ZKvC6vwo5/qwQEyue2JWI016+4PXiLy0JQ3k51
 KgO5dKdoPtlxCVn1TxolnN5YpXfkOPUd1DUbRL5wzJTJ5NGVMwTPM4oFH9eiBk74CY19
 FZ1X+rRXY0piDDBI/m9f97ZWTyReDLbpAr+gcPnOvrrg+CEa+i2c99nFldU1Xh61jBXF
 /1pXox1bvxsrvFxAG9eTKkQeiaZNf6Fj74H4R9Oo88KkbcHBkPV+aJCjGu0FPcXFvoXg
 IX0A==
X-Gm-Message-State: AOJu0YzdPuDcXqOd/0OSV1BxjqThpSG1fyaBfN8DkA2twFvgFhGXcnMJ
 InCqTopHyg5E4lqIDFLIhip01hln0ZQ4PVgAJTPYI92wJtzIhqwS/Soyo850NKCIQTE=
X-Gm-Gg: ATEYQzz+25/2r0y2bHS3Xbzn7ljmzjtQX7Qq64U2jobTZiACoMLdZAi65kg85vOv6Dr
 kP3KKP762MYe+BPSVhTLCW/UfvGJaQan+xNjxsTbNnvk+wQN+qi1A3a09SaWjP5OX44XbQFIQxh
 kP/qKGzoJTP9PP9Gl4AkxbNODw7yjV8bPfOwO7wBoe4sNjVDM2fu2/a15bXTYn+zUVfZCW8Jo8J
 zUocyGS4cayjw/zaivo4FSQx3SNlOrDELnknm2AHDxeEvquIYDXAm2wYXl4te94FoPj8nZ0INWu
 6V4EUNigBXkmmdggRSpf3mz4PB5xm6UWJG/1yoMNllawk28yCtsvkG0/0/haBltXrZdFDYy3Qed
 DRF7c932wAQQ737m69nDVXhp5mxAYs4EzM9NjbKaq8FGklngkOpVbGmPFtukVkNiL3kCCqTzXZu
 PCMdU9W9+HtNuD91b3W4/ejXzWUUs86Nc3Z6vHJzhtlUnk7j57KqlMATU9cEb/nkFmvEgsQq2zF
 iqa0t9zflxjybxSEuIzqZM=
X-Received: by 2002:a5d:5d11:0:b0:43b:433f:48a9 with SMTP id
 ffacd0b85a97d-43b527aa1efmr5247226f8f.15.1773837684764; 
 Wed, 18 Mar 2026 05:41:24 -0700 (PDT)
Received: from [192.168.1.35] ([2a01:cb1c:39a:2200:c85b:67ae:76b0:e0c6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51805291sm8073930f8f.0.2026.03.18.05.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 05:41:24 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 13:41:27 +0100
Subject: [PATCH] configs: mediatek: rename genio boards defconfigs to match
 the device tree name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rename-genio-defconfigs-v1-1-1440312442f0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrB0YrbTVq0gXafyTzsKJJCCCe
 HdDl9/ivZMKsqLQ1JyUsWvRZBVd25D/OYtgXaqpl/4pj+7NGeZWcIRp4gXBJwsaC3/9IC/xo2A
 E1XrLCHr8z/Pnum755OeTaQAAAA==
X-Change-ID: 20260318-rename-genio-defconfigs-bc4070c90e9e
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

Rename defconfig for genio boards to match the device tree name:
mt8370_evk_defconfig --> mt8370_genio_510_evk_defconfig
mt8390_evk_defconfig --> mt8390_genio_700_evk_defconfig
mt8395_evk_defconfig --> mt8395_genio_1200_evk_defconfig

While at it, we also
- update the CONFIG_IDENT_STRING to be consistent.
- create a mt8188.config file shared by mt8370_genio_510_evk_defconfig
  and mt8390_genio_700_evk_defconfig files
- refactor MT8188/MT8370/MT8390 under the same entry in
  boards/mediatek/MAINTAINERS
- add myself as maintainer for these boards
- remove useless CONFIG_SYS_BOARD for MT8390

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 board/mediatek/MAINTAINERS                         | 18 +++++++-------
 configs/{mt8390_evk_defconfig => mt8188.config}    |  3 ---
 configs/mt8370_evk_defconfig                       | 28 ----------------------
 configs/mt8370_genio_510_evk_defconfig             |  5 ++++
 configs/mt8390_genio_700_evk_defconfig             |  4 ++++
 ...k_defconfig => mt8395_genio_1200_evk_defconfig} |  2 +-
 6 files changed, 18 insertions(+), 42 deletions(-)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 446a9e8e53c..08cbd2ce49f 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -3,18 +3,16 @@ M:	Julien Masson <jmasson@baylibre.com>
 S:	Maintained
 F:	configs/mt8365_evk_defconfig
 
-MT8370 EVK
+MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
+M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
-F:	configs/mt8370_evk_defconfig
+F:	configs/mt8188.config
+F:	configs/mt8370_genio_510_evk_defconfig
+F:	configs/mt8390_genio_700_evk_defconfig
 
-MT8390 EVK
-M:	Julien Masson <jmasson@baylibre.com>
-M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
-S:	Maintained
-F:	configs/mt8390_evk_defconfig
-
-MT8395 EVK
+MT8395
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
+M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
-F:	configs/mt8395_evk_defconfig
+F:	configs/mt8395_genio_1200_evk_defconfig
diff --git a/configs/mt8390_evk_defconfig b/configs/mt8188.config
similarity index 81%
rename from configs/mt8390_evk_defconfig
rename to configs/mt8188.config
index 06437be625e..9dfba6bf99f 100644
--- a/configs/mt8390_evk_defconfig
+++ b/configs/mt8188.config
@@ -1,14 +1,11 @@
 CONFIG_ARM=y
-CONFIG_SYS_BOARD="mt8390_evk"
 CONFIG_COUNTER_FREQUENCY=13000000
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_TEXT_BASE=0x4c000000
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
 CONFIG_TARGET_MT8188=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
-CONFIG_IDENT_STRING="mt8390-evk"
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
diff --git a/configs/mt8370_evk_defconfig b/configs/mt8370_evk_defconfig
deleted file mode 100644
index 48d3f64a42e..00000000000
--- a/configs/mt8370_evk_defconfig
+++ /dev/null
@@ -1,28 +0,0 @@
-CONFIG_ARM=y
-CONFIG_COUNTER_FREQUENCY=13000000
-CONFIG_POSITION_INDEPENDENT=y
-CONFIG_ARCH_MEDIATEK=y
-CONFIG_TEXT_BASE=0x4c000000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8370-genio-510-evk"
-CONFIG_TARGET_MT8188=y
-CONFIG_MTK_MEM_MAP_DDR_SIZE=0x100000000
-CONFIG_SYS_LOAD_ADDR=0x4c000000
-CONFIG_IDENT_STRING="mt8370-evk"
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
diff --git a/configs/mt8370_genio_510_evk_defconfig b/configs/mt8370_genio_510_evk_defconfig
new file mode 100644
index 00000000000..e3530571cc4
--- /dev/null
+++ b/configs/mt8370_genio_510_evk_defconfig
@@ -0,0 +1,5 @@
+#include <configs/mt8188.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8370-genio-510-evk"
+CONFIG_MTK_MEM_MAP_DDR_SIZE=0x100000000
+CONFIG_IDENT_STRING="mt8370-genio-510-evk"
diff --git a/configs/mt8390_genio_700_evk_defconfig b/configs/mt8390_genio_700_evk_defconfig
new file mode 100644
index 00000000000..0b07e3be2c4
--- /dev/null
+++ b/configs/mt8390_genio_700_evk_defconfig
@@ -0,0 +1,4 @@
+#include <configs/mt8188.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
+CONFIG_IDENT_STRING="mt8390-genio-700-evk"
diff --git a/configs/mt8395_evk_defconfig b/configs/mt8395_genio_1200_evk_defconfig
similarity index 92%
rename from configs/mt8395_evk_defconfig
rename to configs/mt8395_genio_1200_evk_defconfig
index 2edf3cb3e35..2d73af353f7 100644
--- a/configs/mt8395_evk_defconfig
+++ b/configs/mt8395_genio_1200_evk_defconfig
@@ -7,7 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk"
 CONFIG_TARGET_MT8195=y
 CONFIG_SYS_LOAD_ADDR=0x60000000
-CONFIG_IDENT_STRING=" mt8395-evk"
+CONFIG_IDENT_STRING="mt8395-genio-1200-evk"
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y

---
base-commit: 142c805d470cd02470146d6d70aa9c522d4da16c
change-id: 20260318-rename-genio-defconfigs-bc4070c90e9e

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

