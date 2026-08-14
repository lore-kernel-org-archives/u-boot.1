Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2557AC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 21:21:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8F056067F;
	Fri, 14 Aug 2026 21:21:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qYlDLoGbv2Mg; Fri, 14 Aug 2026 21:21:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AE67606DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786742499;
	bh=PJXi38vYlknPQoveZbcFivpScodOIZ54sXTwSloKBts=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gGOp+Q/cOLtSDD6NFdwq2nrXdlUNHyvh0twra2ZYp2o4QjN5BoWFeCfsKED3YGanl
	 MefclB+0da8RGB1oWE/mSju48lZmIzFMdyq+rum1+4cQP2iGT6IIsHWZX+stBHogX0
	 CrMBPiUQF4vqJJcQi934P/OMLjTJyF/auvVpYWfh7ST7KKK9XBmwrfZKdGy6mtW+eR
	 DppKvxMnmwiehIAy7aS3thvbUyX7I5iI2uCwzlaMxuZSf92/ssW06i3oJM9iBcVaSe
	 kWBKFPO3S7aGGudqC28ki4lSakrND94rutlAunJCXcYxc1Neoh0w/CXJoeAivAKca8
	 UY8nH/6aZwCZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AE67606DC;
	Fri, 14 Aug 2026 21:21:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B71F139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01AD540064
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:21:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oJIvJrmpCQ96 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 21:21:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 53D3140106
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53D3140106
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lBcDYACk
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53D3140106
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:21:35 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7ee125ec926so1214576a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786742494; x=1787347294;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PJXi38vYlknPQoveZbcFivpScodOIZ54sXTwSloKBts=;
 b=lBcDYACkmp5XfbbVltcakcyCwRPmDHG3ZNRnno4WHSvIf11XCs+RgK5tSayhIUWc87
 G7YaRAbk+s6iCepI7rpJNNWZRofUiZiYDkFkZPhkLGiDCwi3kRyTnMWgVuOq4Gvl3eDb
 BQS1TL/S7buWVftkjHIPDo60q6TCU2A5IozSEr0KE85eD8hDyG1ndI/LKIP4FuDa2pYv
 fst/VfaM7gWfW6VoDX+fcE78Qf88BtJI1P/VdqC2tSHuVRNvkJj4qq7/R6FxBg17C7ib
 tUV0iqob6LZNdNlXJjpXyY6JXRcXy1wnOdzdDzbRNDHqqu3QevRZgewg7uFJWfdGqkfT
 MF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786742494; x=1787347294;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PJXi38vYlknPQoveZbcFivpScodOIZ54sXTwSloKBts=;
 b=ottHU1vvcj4rX4qqhKgvoMmUB73DXoY1qZOuoqfQESeA31J90WrIxldKFG7vhPHPqe
 ccRV3zlH1qSMNLYFSnii1kbQy4wCXcqNPdDzzHaknnHfGvrGgO/5Kkq5RsATAL+//IuL
 XsUyGRV9adX0xI4P+30lCU5hqWF0UUAsQA/VOi5E8WPFhqxLOgiTPWJ7g4xayKp9+G7E
 n2ygeMRLoBRXK1Ynok7PnCu9DKwhmQ2+R6dXXzjkykJGQS3BIwINJl9QXZ5bR6P4Rx6i
 FohoM4DcE0nxs5CFVwOqSFtLXvimRUpKb1C7GYojVCbdlxIYMe0Ig+H5gqeDqeknTtvw
 qqpA==
X-Gm-Message-State: AOJu0Yzt1gKYEFuKMkKplq7zCCUV/DfFMsO7mKplYAf5d7IPXGpB9nEu
 mKk54F0QV4aEP0FWhSFszYUC2anCvxjcPcwoOG5mKQVF4WgN26Va1WzhnH8fCXnR/8E=
X-Gm-Gg: AR+sD11V+ZYUZ9ZX4gnU3/JNmx8nOm/ifwoEDcSQW+OBHbCnLZ/Xi173bNR/KRdaOR+
 Bv2w2o65CmzisoVn1me8nYTyL/j2NkhqWvnX5i85c0ZJEw606CrCc/HLQ22M50QPWfh0xZDGVDr
 lc4FBlArQ7Bq73gAL3TMm7Uq2FUFmSSNgkY20yUVnqhtYuARL5KqNoeqn4OB4PCxcYJCuQMJzi0
 IzWdhthu7auvMZUkBnqOEmu8tGDVPisNzUjVnt6cbqGq7jZHOlYtZA8Ko/hF1N0Hu1E9/NQZCrH
 DLzUA/VY2EF3ETyXadbCtvcBOB1efrddi15l9IyulcBWQ4+58+MK2wEpWmadvZzajpQMGobNRK0
 GRe9ge56CGweXKIB134bliu96d9rJkT5mF+/5I71YfHXF/P1s8YBHqZPSVmzxWRc9syuXgQULXP
 m9zqKf7xjrg5EjibLGtw0+rRpnFqws7tKSlDCg7Pahr3Ol/cCcwGeUoJC03MvINkrMXgMcCZj5Z
 F/oKg==
X-Received: by 2002:a05:6830:71a9:b0:7e6:fa37:9797 with SMTP id
 46e09a7af769-7f3de42968dmr8047618a34.6.1786742494609; 
 Fri, 14 Aug 2026 14:21:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7124:5000:3b37:b131])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e84d80d5sm1870949a34.7.2026.08.14.14.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 14:21:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 14 Aug 2026 16:21:25 -0500
Subject: [PATCH] configs: mediatek: remove UFS defconfigs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-mtk-genio-720-remove-ufs-defconfig-v1-1-000eb476030f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNUQ6CMBCE4auQfXaTUhGMVzE8SDsti6E1LRATw
 t2t+vglk392ykiCTLdqp4RNssRQUJ8qMuMjeLDYYtJKt+paNzwvT/YIErnTihPmuIFXl9nCmRi
 ceLZnlHXXXmwzUAm9Epy8fyf3/u+8DhPM8i3TcXwAQIEYsYYAAAA=
X-Change-ID: 20260814-mtk-genio-720-remove-ufs-defconfig-d3e026765d4b
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5500; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=1DNTrUx9HbUk+xhtcljOz4aElQrgquptAMADtqVed4U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqf4bWVXUlcwos34zPx3UA6TpDzUVexs/m6cJhf
 6OqujaZ9JCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan+G1hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6vwH/jXjvrvARD0KRLLLs8jOEdeK9GnOXY+FjD0+T9s
 ZTZx8dk4vQiQXQmdgFSB9vca6yLwrMwlFqI+4RXbfN3YUheVVcn4VBnFATxR0OrKhwtbKNHQzua
 mT3kfDfSzdGbw3qT2/WDGRRBRHQZGSXZJZimHWFv508zsaQU8J1c2QrUCR8k4fOA/HqkQzOLCZv
 lEfagFe7tuJfcrJTO+qWVFZe8NuntBhTFxTJgGF0EtoYUyU+6IvsyT/nDrwJmT5i4rVG04hy5Wa
 rmt9bLvmw+m1YyR7gZIJhP5RnRlj9qYL4IYuwadbRaSplGr6hy/sWEy2L/wVW79kRx9hOq5bDvI
 G5Vo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Remove the UFS defconfigs for Genio 520/720/1200 and enable the UFS
options in the remaining defconfigs. This simplifies things a bit, e.g.
it makes fewer builds to run when testing. Users can instead use the
base defconfigs and pass DEVICE_TREE= to select the correct devicetree
for the target. Or alternatively, include devicetree overlays in a FIT
image that can be selected at runtime by the SPL.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
A bit more on the motivation behind this...

As we are working on adding support for DSI displays for these that
are removable (and there are dip switches to select different types
of displays wired to the same pins) we need to add additional devicetree
overlays for these EVKs. We don't want to keep adding more defconfigs
for every permutation of the devicetree overlays. So better to go with
a single defconfig that has everything enabled and just control what
probes at runtime via the devicetree overlays.
---
 board/mediatek/MAINTAINERS                  | 4 ----
 configs/mt8189-ufs.config                   | 8 --------
 configs/mt8189.config                       | 4 ++++
 configs/mt8195.config                       | 5 +++++
 configs/mt8371_genio_520_evk_ufs_defconfig  | 4 ----
 configs/mt8391_genio_720_evk_ufs_defconfig  | 4 ----
 configs/mt8395_genio_1200_evk_ufs_defconfig | 8 --------
 7 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index d99c6d708b2..47f91d6e81c 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -5,12 +5,9 @@ F:	arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
 F:	arch/arm/dts/mt8371-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mt8371-genio-common-ufs.dtso
 F:	arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
-F:	configs/mt8189-ufs.config
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_520_evk_defconfig
-F:	configs/mt8371_genio_520_evk_ufs_defconfig
 F:	configs/mt8391_genio_720_evk_defconfig
-F:	configs/mt8391_genio_720_evk_ufs_defconfig
 
 MT8365 EVK
 M:	Julien Masson <jmasson@baylibre.com>
@@ -34,4 +31,3 @@ M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
 F:	configs/mt8195.config
 F:	configs/mt8395_genio_1200_evk_defconfig
-F:	configs/mt8395_genio_1200_evk_ufs_defconfig
diff --git a/configs/mt8189-ufs.config b/configs/mt8189-ufs.config
deleted file mode 100644
index 8a7afb95b1b..00000000000
--- a/configs/mt8189-ufs.config
+++ /dev/null
@@ -1,8 +0,0 @@
-#include <configs/mt8189.config>
-
-CONFIG_PHY=y
-CONFIG_PHY_MTK_UFS=y
-CONFIG_SCSI=y
-CONFIG_UFS=y
-CONFIG_UFS_MEDIATEK=y
-CONFIG_CMD_UFS=y
diff --git a/configs/mt8189.config b/configs/mt8189.config
index ab56c90a17c..8db5815e9e0 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -16,6 +16,7 @@ CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
@@ -42,6 +43,7 @@ CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_MT6359=y
+CONFIG_SCSI=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
@@ -51,5 +53,7 @@ CONFIG_MTK_SNOR=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MTK=y
+CONFIG_UFS=y
+CONFIG_UFS_MEDIATEK=y
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y
diff --git a/configs/mt8195.config b/configs/mt8195.config
index 03f57d46708..909b495e015 100644
--- a/configs/mt8195.config
+++ b/configs/mt8195.config
@@ -13,9 +13,11 @@ CONFIG_BOOTSTD_FULL=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_UFS=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
+CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT8195=y
@@ -23,8 +25,11 @@ CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_MT6359=y
+CONFIG_SCSI=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+CONFIG_UFS=y
+CONFIG_UFS_MEDIATEK=y
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y
diff --git a/configs/mt8371_genio_520_evk_ufs_defconfig b/configs/mt8371_genio_520_evk_ufs_defconfig
deleted file mode 100644
index a0b365a86a2..00000000000
--- a/configs/mt8371_genio_520_evk_ufs_defconfig
+++ /dev/null
@@ -1,4 +0,0 @@
-#include <configs/mt8189-ufs.config>
-
-CONFIG_DEFAULT_DEVICE_TREE="mt8371-genio-520-evk-ufs"
-CONFIG_DEFAULT_FDT_FILE="mt8371-genio-520-evk-ufs"
diff --git a/configs/mt8391_genio_720_evk_ufs_defconfig b/configs/mt8391_genio_720_evk_ufs_defconfig
deleted file mode 100644
index f1de9d5fa1e..00000000000
--- a/configs/mt8391_genio_720_evk_ufs_defconfig
+++ /dev/null
@@ -1,4 +0,0 @@
-#include <configs/mt8189-ufs.config>
-
-CONFIG_DEFAULT_DEVICE_TREE="mt8391-genio-720-evk-ufs"
-CONFIG_DEFAULT_FDT_FILE="mt8391-genio-720-evk-ufs"
diff --git a/configs/mt8395_genio_1200_evk_ufs_defconfig b/configs/mt8395_genio_1200_evk_ufs_defconfig
deleted file mode 100644
index 525638f5800..00000000000
--- a/configs/mt8395_genio_1200_evk_ufs_defconfig
+++ /dev/null
@@ -1,8 +0,0 @@
-#include <configs/mt8195.config>
-
-CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk-ufs"
-CONFIG_CMD_UFS=y
-CONFIG_PHY=y
-CONFIG_SCSI=y
-CONFIG_UFS=y
-CONFIG_UFS_MEDIATEK=y

---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
change-id: 20260814-mtk-genio-720-remove-ufs-defconfig-d3e026765d4b

Best regards,
--  
David Lechner <dlechner@baylibre.com>

