Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8839C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 23:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7387040558;
	Tue, 25 Aug 2026 23:32:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sb00OGxlxOR9; Tue, 25 Aug 2026 23:32:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787700761;
	bh=LTw8r9n+oSnFbqcobMOoz2PX6TOKQF2KBalAuj7B/AI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0oVLfPiVbPU275ng65zjuj5PlOw/g9rV7SWZtGweUVMnciI5q87IQVu2x4ucd0EDF
	 Z8Nz15kZ4r2aMU3sRiComBFaURJtu/4ZC2a+AzDbq+8dLwSbpkELp5zQKhcI6jQOVA
	 N30w152etXKNhpWBRltOlOb9YxGQ7HxgnTEbDhcP6FsfI3ng0v+CaMf5DoYWuIs3iU
	 XDgAEIM9IUabbcn3Acuh4r83QQ/D0/byKZxNSgVlIoaSqSlVAniflQf4qTx0JqKmvp
	 fijDDo1qeFyqLiZb4fRGq4ul5q8P1Cnw5Is0Pbvyapjx4hnKmblnSxujJqKwecmifl
	 PJqonGcCqUovg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32D0B4055F;
	Tue, 25 Aug 2026 23:32:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 209683C3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DB6140055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:32:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id trYL5HcS-6pz for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 23:32:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iwhpj3bR
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 613194000B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:32:33 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4a43c2a126fso239941b6e.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787700752; x=1788305552;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LTw8r9n+oSnFbqcobMOoz2PX6TOKQF2KBalAuj7B/AI=;
 b=iwhpj3bRjnHYAdjYhzdKvWVS/MLOCgbTYYvoEfNEZihoptIpYkgW7Pml4eklcBmsP1
 HW6YkpDi+nLeNehxZ3gaJ7SAzBiViNwWoBWYmzgFf7UvvAmro0ZgARRzQwlWQTMV2uqy
 14tZmqnYn+9KgCjjHBzmP4Zvx0xCS8qlsM32ATNd/dTrKX7mulBhaZlgTHs24dP+8O/V
 WbIINK5YRW2YJEmPSqJ2WRYkwRkb05gJk7LtXX3U81XBct7MqELKpvW2TpBbxhtxGTn8
 JYFVVk7P0WkpAotfPuJDu381Uswsz4lq5X1L2Emhe6DxcIL847s66pdAL+XGNNgDLv7q
 YMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787700752; x=1788305552;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LTw8r9n+oSnFbqcobMOoz2PX6TOKQF2KBalAuj7B/AI=;
 b=cR+GLYde2xX/Lg2DLDp/sByv6Y5hnENDNtoREwzhgovvBs4z0g66Wo9rAVgCTiD8ya
 zW0SUkW3W8dw2syT51sGKyEs4uANNmJ7bu79tZjmPRZmGV3PCCEMoXFN6OMawG08FDXF
 4IxSmnQQLLEQUMQ0dQNmJYcGbZ/2k30fUYrIwy81FCg/pSZ9ZKat06W5dBaGX+zXmQ7v
 mP93A3SPmxQ7tS31RtxLBaxJ4AAL+3hFdAHJnWixb7rV9y1nleC6TJamWrukjKbu8IN6
 9MHDgJtMsUmfDcV9M9Ia+Vdskw58DlHnQmTTscrKRB1wNgAH8OQWEMIqJL6lgTjSf9C7
 ox4w==
X-Gm-Message-State: AFuF++k+2VOBXOEMLwUqi0yqQ+Yd1CIHzSx5WCy3OH0bkkjUmDRs9oo/
 LOtdBOG6IIKwZ1HnXJnstzPj+p7Zeb+T+Q9r4WAPTWNQYwvqaw52UwP13uTejsQ8jb4=
X-Gm-Gg: AR+sD11Kg1x2wgP9gumAyrqnnB4eFzGPfl9DeuGJ9ToBPoiAyvAJjdk4eTKS4j9iDkQ
 1gD9hyk4Fw81M9TBgtk0qleHh3OiB+gA5KbfjRhftVzixIu9rURkCzmLZJchotddvlK8xsL6fQL
 jsGwL+f1D5QFcYgjEBQmQbrczR3+rCAjkvWZGQOxzi85B3y0sDQOe8lPzmAyQU60UjPoxTICkqW
 tstYIoyqblk4XHekGQHR/T+17w3IHi7YCkodSZjIoTFLhWeeS+vIwc18ZtdaOBHvGRjDoPSnfUr
 aRJMHtZ1g6RD98WBD5zARmPRUbumSbNUKVqx+8rejpCEvbzsVVYBLEAMhSPtqVFEPKo36m7uoFD
 A1w0aE8vaXA6uwiU3e/X+gS9oWISgvd/bvYmb9cuy4GOvvkfWSJHYZq0wgtcA3WAlgGjj9sLSLP
 kTeeVpZJ6p3GyUwnyqf2UsJAO/nPlSk8iVRnewmjQqKBCOYzkd9hPwE5vmX5USTNeA
X-Received: by 2002:a05:6808:144f:b0:4b3:29e5:5512 with SMTP id
 5614622812f47-4b366b177b3mr3187750b6e.16.1787700752301; 
 Tue, 25 Aug 2026 16:32:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e96b:b637:f05:5bfd])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b36ab734ddsm238211b6e.14.2026.08.25.16.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 16:32:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 25 Aug 2026 18:31:49 -0500
Subject: [PATCH v3 4/4] board: mediatek: add Genio 360 EVK defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-mtk-genio-360-bringup-v3-4-8e79e93882ad@baylibre.com>
References: <20260825-mtk-genio-360-bringup-v3-0-8e79e93882ad@baylibre.com>
In-Reply-To: <20260825-mtk-genio-360-bringup-v3-0-8e79e93882ad@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2722; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=D2Twzt9cqw9msdQx1vAf6SATq8euoESIGSbpJBGuRbA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqjiYA1Qo5C2qmjObf2swVNPygNXKNjG8jwr9yl
 9AH9ZhkHQ6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCao4mABYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AfsAH/3ZMyjQvWN30GoTm8dr7u0NKRavVPEg8WrDJLB8
 g0ZiTGxTKL9cmv6aHUFUIQ/39oh2I7ENa+RoL8UHFZzkKFZTQEsBGEdyiM8tE8DqJwUB89tfnTF
 6tq3C5gA33eeYjHGV9KJw84lPXPHHrM+yixrCDfXRZcvyfS+jpDNizbwYmS4W8VF8DTNIQFR5oL
 8fzSXj9KxFhJPWRNbM7Pgghd1dpP5V0RT5Y0pWg+/joeA0FKykyDSHQMHczLGNqg/tqT3QrYm1R
 zOWO87XSyzsND5i/UDZAYOOWdjc0VuGQSvoNZeGdLALenlAxBaZqfFoCO57dGnwZbJBP2EGRbon
 Cvu4=
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

From: Macpaul Lin <macpaul.lin@mediatek.com>

Add a new defconfig for the MediaTek Genio 360 Evaluation Kit.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS             |  8 +++++
 configs/mt8366_genio_360_evk_defconfig | 62 ++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index f02159c3ada..9d30cd78455 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -14,6 +14,14 @@ M:	Julien Masson <jmasson@baylibre.com>
 S:	Maintained
 F:	configs/mt8365_evk_defconfig
 
+MT8366
+M:	Macpaul Lin <macpaul.lin@mediatek.com>
+S:	Maintained
+F:	arch/arm/dts/mt8366-genio-360-evk-common.dtsi
+F:	arch/arm/dts/mt8366-genio-360-evk.dts
+F:	arch/arm/dts/mt8366.dtsi
+F:	configs/mt8366_genio_360_evk_defconfig
+
 MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
diff --git a/configs/mt8366_genio_360_evk_defconfig b/configs/mt8366_genio_360_evk_defconfig
new file mode 100644
index 00000000000..33f27edbc1d
--- /dev/null
+++ b/configs/mt8366_genio_360_evk_defconfig
@@ -0,0 +1,62 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="mt8366-genio-360-evk"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_TARGET_MT8366=y
+CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_DEFAULT_FDT_FILE="mt8366-genio-360-evk"
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_NET_LWIP=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK=y
+CONFIG_MMC_MTK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_MTK=y
+CONFIG_PHY_AIROHA=y
+CONFIG_PHY_AIROHA_AN8801=y
+CONFIG_PHY_ETHERNET_ID=y
+CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
+CONFIG_PHY_MTK_XSPHY=y
+CONFIG_PINCTRL=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MT8366_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MTK_PWRAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_MT6358=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MTK_SNOR=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_MTK=y
+CONFIG_USB_MTU3=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y

-- 
2.43.0

