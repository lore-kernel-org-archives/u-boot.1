Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E96C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D208380D1E;
	Fri,  7 Aug 2026 16:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 92dYRsS9aDmd; Fri,  7 Aug 2026 16:13:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BE6E8136D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119219;
	bh=+WJQRb3Kcl7P4khRceUwSZknoJ/J1tmmzzELP1tmyJ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ihQQf58hlOeBoavMBY+iUDIRCpfXDTImzIABnydZSIAZDlqzz+71r472rx68sA0rR
	 YXigushK18+b6X/D9bLqZEGbuho3uJtz+zmDu9mV4T2P2CEw+DVBYNgTycNgXlMrG9
	 TIMnC5xCIinfie9Q4ya7MzKN40Wtu8Su0Xyt71BpZQrXAO1i4iaofNx8sQTHAm4oBS
	 miHTOZomvr3pyp427Iyfk5eRtqsBZib6XP4jSWLIzIYlhqOOvVMTXBFJPfb8K6wbie
	 BMuNYPmhK86jADjW+tHoWo8hkYYDjUj13nVUeLcROgEfWrjIsecCeYAIJkKiEccjrG
	 i6DaxLYQZdl9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BE6E8136D;
	Fri,  7 Aug 2026 16:13:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE4F2D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C42DD607E6
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CedNaAcz_Faq for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:13:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1624560684
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1624560684
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1624560684
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:33 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-497d3e4460aso1866995b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119213; x=1786724013;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+WJQRb3Kcl7P4khRceUwSZknoJ/J1tmmzzELP1tmyJ8=;
 b=ec3ACLtBYYdOGKEDhlFrMrFw1rFSQ9VfaOWaMZqjEKiondu3On4uQMMdeaGlC4NC7G
 cXW8Glet4q/ONO+AhlFx3Z3XKqJd829XJcBKZ7H68AKJGpVOw2VFejEgiDPOQPocUg24
 gfcSCHxE4tKUfwp18at2CfHvkRmqNJoyzgURBcHhG68PbKW226390kZTnqg54r5ChgEK
 YLfKBjidJ+HsHP7Sn2XXykehEsqefjlOgRvEV6v7e2iN/FGtEh+KvNNy6goM69hPcg8B
 tjdrySSlSsJHVux54ya6fC9tRerur0lWv93U242czOCslpYHNnX/0FcrXbNx1UWv3Mil
 rjBQ==
X-Gm-Message-State: AOJu0YzCjhtSvS3N0sbjT5aJyUT0Wrwj22BHdbJhbLifh6I7e0jCVX+m
 EN2OnxkO4FnkPFfjSkbEMDpQUfZNdGV7d7jhMuFfK6gAel/2cxDs/rcqK2yDhkQ7zOA=
X-Gm-Gg: AR+sD12ODiFwDSR59awiTPUjCjij1WCpwUvxCcBfIzchxp64R7Dm0A2o1m/CbFEE5xo
 xzr7+0yKinGD0PiEYKMxM9lTlVLv90/3a5106QEynAFBXP6mmfjN+dbTDk6Tx5MB/BjbLOdww9s
 YOT4I3OuAO3/EUPezM8499tqkIpRPobgVqolqQFS4gbOTSidwF8fYL2T3nx9Tbg1H1et4hzQaIs
 F470N2Ajp1W84k5Vv5FfRzdRPUU06rzxYZ1URjLrE4bB/ln9rXSi2ww9/owNv8eNnoOBkAKpVoK
 B4dSGrZPwkgPrHJin3Cgedxx0jr9oW1h/a9AKvqaOHMTGmzXygakDyPbSZDsY3te+4kHQPIFQF2
 dYA3hJiv373Jlx++3zcyLqxtRw9XpXMCksDhnF3QE1fVjlE91XmOOa+N+4i2ZqrCKutilIl+BOM
 tpbERvMFz2/6+9c5IMS5tbWTplKGrvU8Lgd+3VPAZHoSek3g2OQCsZtkAqps2AqMXClVnm0oBQn
 7kU
X-Received: by 2002:a05:6808:144e:b0:495:ca1b:7865 with SMTP id
 5614622812f47-4afc5011d31mr8067648b6e.11.1786119212935; 
 Fri, 07 Aug 2026 09:13:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b7b9678sm1537878a34.21.2026.08.07.09.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:13:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 11:12:54 -0500
Subject: [PATCH v2 4/4] board: mediatek: add Genio 360 EVK defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mtk-genio-360-bringup-v2-4-7c3830297d97@baylibre.com>
References: <20260807-mtk-genio-360-bringup-v2-0-7c3830297d97@baylibre.com>
In-Reply-To: <20260807-mtk-genio-360-bringup-v2-0-7c3830297d97@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Xf3x5udj6TyGrZ3mSHGws9rgScUB1ZCpNm9Z7UtqWbU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdgQh2JBTKFompBq543SGmVqtoSMIqFAinO8BH
 6eWCukWIqOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYEIRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AKUsH/3WxKso9IK2+HrmndEOuh3j9yJJw8dIO4nEWro2
 CTR9CGQV/5B1I+MgUf3fFjCr/8LriRN/8j5/To+vf2m7P7AIsfRuDADZr98ya9EL06WetWQ6vLJ
 Dyy1KqNMKwqxvIEXQ1G6jmyB0quQMi1RoFLVDfJtP0Iwp9DEHYaG6MXzvQMksEckkFZpBdH1IY+
 GT4vbJ9EKG9uNkrmeNNyHtWhENOVlLXEPUL4TvIKNXbmOZ98CoNbzSFh9jGjWZjzHSsUtxo9fDz
 +PrtViVmiy83Ckhm/Wnf7XlSpVYawmacVNmMYc6NcdcmYlEe7Z6r20jQywr1vxImKOx4LIBUz+3
 VPZE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786119213; x=1786724013;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+WJQRb3Kcl7P4khRceUwSZknoJ/J1tmmzzELP1tmyJ8=;
 b=KR13wqLhOJuy3W/R1PrpknVTKHx6coyAWFmzJoEGd1/MJ5yle4dp4ceG720aMocuPa
 lLPbCjWkvhKmjg+uJrtRWtD++7sJ5OA1vIkzuVWColnAUvgeK5/mDhZRdQU7g8t6cULA
 T12aCT6SXGqQ8XRnT9OXLs8dUWjPDiE6tMXzh/eqT/4Bd98rtkT9Swmm1O57UnG3PKWi
 R+LsEDUtE0QekWINDy7eWkBEJTXQ+DmuO8n+w9biIVlKUfEO+cYIhT71gY1n7mjmFkvT
 85qymHudDPffHwDBv3ENFU1KakjiOeJC477kXsg6kG88uXl9pF821rftGPO1HG26kRBV
 3ftw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KR13wqLh
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

From: Macpaul Lin <macpaul.lin@mediatek.com>

Add a new defconfig for the MediaTek Genio 360 Evaluation Kit.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS             |  8 +++++
 configs/mt8366_genio_360_evk_defconfig | 59 ++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 75b60d22a2a..1d4ca1bba47 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -17,6 +17,14 @@ M:	Julien Masson <jmasson@baylibre.com>
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
index 00000000000..8fafa67946e
--- /dev/null
+++ b/configs/mt8366_genio_360_evk_defconfig
@@ -0,0 +1,59 @@
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

