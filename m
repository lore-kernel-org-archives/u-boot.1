Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F7A10775E7
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD4483F93;
	Wed, 18 Mar 2026 17:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j8QMzOMk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C2068352B; Wed, 18 Mar 2026 17:51:04 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46FC183FD3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso642465e9.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852661; x=1774457461;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JSb+1mk7holnrE2f1j0Uovqy02Xk34hbnPJu157sB6U=;
 b=j8QMzOMkHtgMVjaoxJgmM+odEi3LNl78WmpspvJfg9MzbUadeJ6Hl94XxG70uuRJoV
 jtsAIY76v1cXfTZaO5zpplH+mCWb0yo7aZqhPiP2ePUHUqMYR7NpgTKSThaLHF1+jZ8Z
 uXCafdU7ZGLu3M4Nqy+qJ50IO4qtu91DstAGCazak3SILe53x9vi13ZNk/cVlP5M86nq
 +Q/Ea1bQRwSuV6iwP0NOAss1Q9v5ldox/HPxOutmvpg5jtWcl3gCmV5k7jcyxSrnft9C
 rNGuVzt4vXEs63iUvhLrBzp2rjj60oz2KYBQWIN1GSPwcEqlKc3uEAXeVTl8+az8++ZA
 R97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852661; x=1774457461;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JSb+1mk7holnrE2f1j0Uovqy02Xk34hbnPJu157sB6U=;
 b=Wj0BfETYkDmflSfrBnm0aj4bM/fO7Tf0aQRDq7Kd8TvrxAmsLvOQiddt6IkhzXI1fS
 o4d2NA1Drcj7D1fVuGGgHOLCshmgf3YfyB8oTJXpZIpHz0xPXYU5rcWG5ItKDwMLA+ca
 Ij/G3gIZZXxJLzZi/kVQ/4fCs002oYaEls1b9j8ol3Nc01VsDJXkGDTImsOZ8efneAaQ
 HIlGup8TYiScdmr1d7wqxgzR8b6RjWodrSFjKjuV04tpdn1zGCPPIhHd1MjIjptZhdnm
 sERSdv8mdgOCcbxKK5Oold2u9zNeGvrNadPyeH97NmzOzf626o1jeBwzjbyxwwRKdTmE
 sUEw==
X-Gm-Message-State: AOJu0YwH/kx5jsPeTbSQRIhQRvWf83lRCfJqnM44aUne6d0KgOTbBfxI
 xrXf2iQSpkyKUD8TNDA9fDfVUdIRsk74ET19Uv/jx+U0+P65Un9RNULlCLtAgikiDoU=
X-Gm-Gg: ATEYQzx2E20HTyNcayk3GxX/ynY+4TBCLHafQp1TUEKRQD5qJWHm0ePq0oeyDMXK3pB
 sogJje0QPJst9m/PK9rhJq2sRmeXbPHuvIqt64+NB3BQ+C/+Pp48irDY4xmG4YmmyxL8+/gC/mj
 NUXDRsBIyYfTGEdDmMc8IhjZTDZ9m2q4ghoic7JfQFqkDsumzW2d5qalfBQO4tsZtRY0qGGukpl
 6jgQKGwM8VpnBgokwUmp+P/n8ORg6JPk+rwCdelpRg+DmcoLn0YW4PX1ELPvGcJYbI61skChggz
 Ide0M3WP18uMayipnkvvgAZNL9jE6bvY243mDNPAqij8VSAjy7qUmK5gUvlQ5Fa+g4ZqOc12Kct
 XvilcNIWZX1/+HXmvShcueOzjVsmUpJuJHpMvN5M4+/9zhWyX0CUklP/Ox746TQ96rYrK579+fO
 8UddlluLG8np0tNm8niJGOEbF3nCOkFZ7PxeOuXgKEEGU3sD0+jZDazzs99iZGFwJheElvtPfn2
 qn4gWGi593pDIGst0vDa1DupjekBJeTYN7vTGqKT9Ko3Yfa979Fn1C14A8xB20kyieo2qqPYbU0
 Wk8qyDVJZlqLTtWWGQ==
X-Received: by 2002:a05:600c:310d:b0:485:364e:934e with SMTP id
 5b1f17b1804b1-486f457284bmr65672945e9.21.1773852661146; 
 Wed, 18 Mar 2026 09:51:01 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892290sm8639527f8f.20.2026.03.18.09.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:51:00 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:51:01 +0100
Subject: [PATCH v2 9/9] configs: add new defconfig for
 mt8395_genio_1200_evk_ufs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-mt8195-add-ufs-support-v2-9-f18eeeeb0e72@baylibre.com>
References: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
In-Reply-To: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
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

This new defconfig is based on mt8395_genio_1200_evk_defconfig, with
additional configs for UFS.  In order to avoid duplicating defconfig, we
introduce configs/mt8195.config.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 board/mediatek/MAINTAINERS                  |  4 +++-
 configs/mt8195.config                       | 24 ++++++++++++++++++++++++
 configs/mt8395_genio_1200_evk_defconfig     | 26 ++------------------------
 configs/mt8395_genio_1200_evk_ufs_defconfig | 13 +++++++++++++
 4 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 08cbd2ce49f..621d613c9fb 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -11,8 +11,10 @@ F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_defconfig
 F:	configs/mt8390_genio_700_evk_defconfig
 
-MT8395
+MT8195/MT8395
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
+F:	configs/mt8195.config
 F:	configs/mt8395_genio_1200_evk_defconfig
+F:	configs/mt8395_genio_1200_evk_ufs_defconfig
diff --git a/configs/mt8195.config b/configs/mt8195.config
new file mode 100644
index 00000000000..b5bc1848977
--- /dev/null
+++ b/configs/mt8195.config
@@ -0,0 +1,24 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_TARGET_MT8195=y
+CONFIG_SYS_LOAD_ADDR=0x60000000
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
+CONFIG_PINCTRL_MT8195=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y
diff --git a/configs/mt8395_genio_1200_evk_defconfig b/configs/mt8395_genio_1200_evk_defconfig
index 2d73af353f7..47c10757c52 100644
--- a/configs/mt8395_genio_1200_evk_defconfig
+++ b/configs/mt8395_genio_1200_evk_defconfig
@@ -1,26 +1,4 @@
-CONFIG_ARM=y
-CONFIG_COUNTER_FREQUENCY=13000000
-CONFIG_POSITION_INDEPENDENT=y
-CONFIG_ARCH_MEDIATEK=y
-CONFIG_TEXT_BASE=0x4c000000
-CONFIG_NR_DRAM_BANKS=1
+#include <configs/mt8195.config>
+
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk"
-CONFIG_TARGET_MT8195=y
-CONFIG_SYS_LOAD_ADDR=0x60000000
 CONFIG_IDENT_STRING="mt8395-genio-1200-evk"
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
-CONFIG_PINCTRL_MT8195=y
-CONFIG_BAUDRATE=921600
-CONFIG_DM_SERIAL=y
-CONFIG_MTK_SERIAL=y
-CONFIG_WDT=y
-CONFIG_WDT_MTK=y
diff --git a/configs/mt8395_genio_1200_evk_ufs_defconfig b/configs/mt8395_genio_1200_evk_ufs_defconfig
new file mode 100644
index 00000000000..c18d7de4df2
--- /dev/null
+++ b/configs/mt8395_genio_1200_evk_ufs_defconfig
@@ -0,0 +1,13 @@
+#include <configs/mt8195.config>
+
+CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk-ufs"
+CONFIG_IDENT_STRING=" mt8395-genio-1200-evk-ufs"
+CONFIG_CMD_UFS=y
+CONFIG_PHY=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MTK_PWRAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_MT6359=y
+CONFIG_SCSI=y
+CONFIG_UFS=y
+CONFIG_UFS_MEDIATEK=y

-- 
2.52.0

