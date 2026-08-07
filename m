Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7BEC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 19:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 660FA40A02;
	Fri,  7 Aug 2026 19:17:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dVxkT2ySv9HN; Fri,  7 Aug 2026 19:17:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 330F1409F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786130237;
	bh=0Q7JuimmbxSYFCBmVQLmWw+QtdzSrvLyq2zSGKVXWvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SW9TiFNrKUg8scFsWZoOLLNfrV77bbwv3XYscmNAiw+LeuE/tGjxVy8S9ims/Roie
	 TloryJUwdTJFrtuw1tLJ9EbSbqef1ROI9ZW7emhogsSHaMUlSbjjbQkegEBwIqjVcV
	 zmM/NdeWOeAE3XCrk6dtmkyJj3lmQ43FUO0RxrmTyPyNO22rZ9wSExpSDiVFAedvdl
	 SjJBAj03v2X5F09vaB1VI0pUvGDkytXodjb1/hKbnHr3/BGMsKAH/eMQyRRXtVkEJu
	 MqY1eR9hdxsgucnx+6CJzxUlVVPGVcDPmEyfVpTwGYYQESKf1rH/EbAdgXgCOxFewm
	 7EP2XkPjkcNgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 330F1409F9;
	Fri,  7 Aug 2026 19:17:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30CDF259
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16CD0409A7
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9RVc1H-Dq6LS for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 19:17:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 990654098B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 990654098B
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 990654098B
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:12 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7ea9c6ea7deso2430909a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 12:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786130231; x=1786735031;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Q7JuimmbxSYFCBmVQLmWw+QtdzSrvLyq2zSGKVXWvc=;
 b=eYnDE1a9rV+gI25OnyJ/fT5tSNRzqoJ0esCpbPmuBkVugs/ayE/J5bIU6J62JKMcqz
 UAXUvAnF9ymuvUexFDCXN9Ikfr6NAoamlwQgJpg4RaAf1ChBoIBL3NuhpvedhSX75omm
 xtNP2pQC67WlFJC5Sjx59rzkECBm4N2KiIprB0rwq+PO8qQZesSx4FoU8e0tQEnFqLD1
 x72zXXbJ0QzL8vTIv9cBt+rURHzsJ8ENP9EBYo1tQj9ojChI/Sbczmbu1dDImoDZrZBk
 4FDAlx+T02jaAJjlWYwKC2ywvT9LctUjH/l2TH3muikfHI4QdqR16hZo6DiZAE/nSxhR
 Qo1g==
X-Gm-Message-State: AOJu0Yykd3zP5v6FtuDpyncuG/rC+w0xqi/VbUkFfJlGobWiem6r3U/r
 u3+LuN2eyw74eQpESW/Jtnu9PiIquNAgsr4IbMRE2q91rAvQ0vJsDC7QmeUzPxLw13A=
X-Gm-Gg: AR+sD12OZwfAGWlvFREb91xDiVcqWbmaj+CIZTcHBEZ31QPyUqtzJdCvhqy6oMlyrzG
 b7zHqRAv95t7O2qLmJpJQLkR8zERQB6piALl2nbtmK9UN6pMtGTNXeV7ZW2dJQmbD9LoCsT+kUn
 vGE5B1XLwtEjeoEayOGaojJY6A/kW8uswbH3xcyjrByw0c/s7Hbwe1C0LhQaKZiHSZycxWS6S2+
 6eI1/dbFVsWzGVQD9/UCVk4dUj0KG5TJy92whAW4KgIBpuZaFNPI1/SshuoCuOgWv9IwLqIvEUQ
 F7Qz+tYod5aggY3N3fLFpLBZOvZmw9wovrxZ17ThZEgZS4t7JEGa8mKregc0HPcE9xmC2l1PaSo
 N7MkxrmfVRZxBNAhWuJSyMlMipM3682s9x0WJ5k5FTbALL3L0ST7/gRytcqPwPaHPw32Zw2A8JR
 PDG4sbmKCplAgVMZuROAWczBKnfywB2gcOzLWB4EWpvaIzYZ4qkJiIzmmrbGEECObdQ/gVwa2Ol
 nQ=
X-Received: by 2002:a05:6830:6515:b0:7d7:58b0:7685 with SMTP id
 46e09a7af769-7f1e5efac6dmr17341732a34.13.1786130231331; 
 Fri, 07 Aug 2026 12:17:11 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b5acbcbsm1875251a34.11.2026.08.07.12.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 12:17:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 14:16:32 -0500
Subject: [PATCH v2 4/4] configs: mediatek: drop no longer needed PINCTRL
 options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mtk-pinctrl-kconfig-cleanup-v2-4-509a8f833181@baylibre.com>
References: <20260807-mtk-pinctrl-kconfig-cleanup-v2-0-509a8f833181@baylibre.com>
In-Reply-To: <20260807-mtk-pinctrl-kconfig-cleanup-v2-0-509a8f833181@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 David Woodhouse <dwmw2@infradead.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mingming lee <mingming.lee@mediatek.com>, 
 Fabien Parent <fparent@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10367;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=TwB84B0HvPxB++AvGkex2aad6snoxP50gK09TPFD81Q=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdi8qdrwyPrlqsa/NztdNUCwUnTf8gvuAVwlta
 Q6hbv/mT+iJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYvKhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AR+UIAJNkH0Cdkc7SNwtS7eYeM56F4awpscMjI1cmQnI
 JdBsPDN241HyqDSrd8T7Ar7Y216Tbm8OssPeAA9FmOSC3N6ZI2DSMZPK9+GAwp5jwmBWzAbfl1r
 isI2OP5TrWi8N+eaKbodne0bDBhkYzbl4LQ5KR94k6+r59XjdcCxrllMhG1Zm+35pDz2xkz3Q6Y
 fMeuGN5ypPZSqXzUstMMUKycEBn5vRNeuGeC0oHD3N9stF69EjkshyD52Xdca6KJiw4J17dGXSz
 HBjpoPVCADP2YjL9BIdETObIOfK1znql3sflxBhEaLZ8WrXDi4eqMpf6lchOc67raFm6xaUqfld
 Somw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786130231; x=1786735031;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Q7JuimmbxSYFCBmVQLmWw+QtdzSrvLyq2zSGKVXWvc=;
 b=UIJXdx/BW/TLqBV2KsM+uovHBXQ1OZ25VFpdWzMxpqIvCsOSB985ZtfdmDHiLYWTjM
 b035gdrlY90Lqw8KTfsduTlfF7hNHwG54R038AvkNeFsHcu2mNI5dvBeAc2Z1oUbs2mB
 7LVl7iCtKfdoFE552JmEt3ucEvKiaRpnmIq5sHAfdPEYSktzuxMXxW6tN2l0TtBQtIMu
 /f24BDqr6g9xu0kDPehwO3EkP6X9fBpQC8o2dlC9rxKfzWx/STs2PeCvb3q6N6qbHD5V
 vATwWNAWGz4Wt8jwGdZXpByN2DAZH8V/nA++A6kVq+siRwh5Ss89CMtll1Sa0OTEPhmE
 MR9Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UIJXdx/B
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

Drop CONFIG_PINCONF and CONFIG_PINCTRL_<SoC> from all MediaTek defconfig
files. The former is always selected now and the latter no longer
exists.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt7622_rfb_defconfig               | 2 --
 configs/mt7623a_unielec_u7623_02_defconfig | 2 --
 configs/mt7623n_bpir2_defconfig            | 2 --
 configs/mt7629_rfb_defconfig               | 2 --
 configs/mt7981_emmc_rfb_defconfig          | 2 --
 configs/mt7981_rfb_defconfig               | 2 --
 configs/mt7981_sd_rfb_defconfig            | 2 --
 configs/mt7986_rfb_defconfig               | 2 --
 configs/mt7986a_bpir3_emmc_defconfig       | 2 --
 configs/mt7986a_bpir3_sd_defconfig         | 2 --
 configs/mt7987_emmc_rfb_defconfig          | 2 --
 configs/mt7987_rfb_defconfig               | 2 --
 configs/mt7987_sd_rfb_defconfig            | 2 --
 configs/mt7988_rfb_defconfig               | 2 --
 configs/mt7988_sd_rfb_defconfig            | 2 --
 configs/mt8188.config                      | 2 --
 configs/mt8189.config                      | 2 --
 configs/mt8195.config                      | 2 --
 configs/mt8365_evk_defconfig               | 2 --
 configs/mt8512_bm1_emmc_defconfig          | 2 --
 configs/mt8516_pumpkin_defconfig           | 2 --
 configs/mt8518_ap1_emmc_defconfig          | 1 -
 22 files changed, 43 deletions(-)

diff --git a/configs/mt7622_rfb_defconfig b/configs/mt7622_rfb_defconfig
index 10df7847a4b..d35bed49afa 100644
--- a/configs/mt7622_rfb_defconfig
+++ b/configs/mt7622_rfb_defconfig
@@ -48,8 +48,6 @@ CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PCIE_MEDIATEK=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7622=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_MT7622_POWER_DOMAIN=y
 CONFIG_RAM=y
diff --git a/configs/mt7623a_unielec_u7623_02_defconfig b/configs/mt7623a_unielec_u7623_02_defconfig
index 77473e2731f..13fe8766b98 100644
--- a/configs/mt7623a_unielec_u7623_02_defconfig
+++ b/configs/mt7623a_unielec_u7623_02_defconfig
@@ -46,8 +46,6 @@ CONFIG_MMC_MTK=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7623=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_MT2701_POWER_DOMAIN=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7623n_bpir2_defconfig b/configs/mt7623n_bpir2_defconfig
index aacaf5380fa..13fd033b2f7 100644
--- a/configs/mt7623n_bpir2_defconfig
+++ b/configs/mt7623n_bpir2_defconfig
@@ -48,8 +48,6 @@ CONFIG_MMC_MTK=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7623=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_MT2701_POWER_DOMAIN=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7629_rfb_defconfig b/configs/mt7629_rfb_defconfig
index 91da684939a..4b2412cc571 100644
--- a/configs/mt7629_rfb_defconfig
+++ b/configs/mt7629_rfb_defconfig
@@ -80,8 +80,6 @@ CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY=y
 CONFIG_PHY_MTK_TPHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7629=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_MT7622_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/mt7981_emmc_rfb_defconfig b/configs/mt7981_emmc_rfb_defconfig
index 75e7140bdfa..3c24da09505 100644
--- a/configs/mt7981_emmc_rfb_defconfig
+++ b/configs/mt7981_emmc_rfb_defconfig
@@ -50,8 +50,6 @@ CONFIG_MMC_MTK=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7981=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7981_rfb_defconfig b/configs/mt7981_rfb_defconfig
index 6322af51b18..e57637b9e01 100644
--- a/configs/mt7981_rfb_defconfig
+++ b/configs/mt7981_rfb_defconfig
@@ -52,8 +52,6 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7981=y
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
 CONFIG_SPI=y
diff --git a/configs/mt7981_sd_rfb_defconfig b/configs/mt7981_sd_rfb_defconfig
index de05e2486a0..a3702dc83fd 100644
--- a/configs/mt7981_sd_rfb_defconfig
+++ b/configs/mt7981_sd_rfb_defconfig
@@ -50,8 +50,6 @@ CONFIG_MMC_MTK=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7981=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7986_rfb_defconfig b/configs/mt7986_rfb_defconfig
index 87fbe677624..519022a8da6 100644
--- a/configs/mt7986_rfb_defconfig
+++ b/configs/mt7986_rfb_defconfig
@@ -52,8 +52,6 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7986=y
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
 CONFIG_SPI=y
diff --git a/configs/mt7986a_bpir3_emmc_defconfig b/configs/mt7986a_bpir3_emmc_defconfig
index 92459ad9fe2..fd255ab8719 100644
--- a/configs/mt7986a_bpir3_emmc_defconfig
+++ b/configs/mt7986a_bpir3_emmc_defconfig
@@ -50,8 +50,6 @@ CONFIG_MMC_MTK=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7986=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7986a_bpir3_sd_defconfig b/configs/mt7986a_bpir3_sd_defconfig
index 2c88255e69d..b3826dad560 100644
--- a/configs/mt7986a_bpir3_sd_defconfig
+++ b/configs/mt7986a_bpir3_sd_defconfig
@@ -50,8 +50,6 @@ CONFIG_MMC_MTK=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7986=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7987_emmc_rfb_defconfig b/configs/mt7987_emmc_rfb_defconfig
index 00d7e5a610a..59a1aadb713 100644
--- a/configs/mt7987_emmc_rfb_defconfig
+++ b/configs/mt7987_emmc_rfb_defconfig
@@ -75,8 +75,6 @@ CONFIG_MTD_UBI=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_ETHERNET_ID=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7987=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7987_rfb_defconfig b/configs/mt7987_rfb_defconfig
index 0b353c6cf01..9e9ad69e50b 100644
--- a/configs/mt7987_rfb_defconfig
+++ b/configs/mt7987_rfb_defconfig
@@ -70,8 +70,6 @@ CONFIG_MTD_UBI=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_ETHERNET_ID=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7987=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7987_sd_rfb_defconfig b/configs/mt7987_sd_rfb_defconfig
index 30ff09365da..5c50dfef072 100644
--- a/configs/mt7987_sd_rfb_defconfig
+++ b/configs/mt7987_sd_rfb_defconfig
@@ -75,8 +75,6 @@ CONFIG_MTD_UBI=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_ETHERNET_ID=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7987=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt7988_rfb_defconfig b/configs/mt7988_rfb_defconfig
index 375df418ce0..3d74f09f436 100644
--- a/configs/mt7988_rfb_defconfig
+++ b/configs/mt7988_rfb_defconfig
@@ -65,8 +65,6 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7988=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_RAM=y
diff --git a/configs/mt7988_sd_rfb_defconfig b/configs/mt7988_sd_rfb_defconfig
index aafbed7bea5..955e6e63d42 100644
--- a/configs/mt7988_sd_rfb_defconfig
+++ b/configs/mt7988_sd_rfb_defconfig
@@ -53,8 +53,6 @@ CONFIG_MTD_SPI_NAND=y
 CONFIG_MEDIATEK_ETH=y
 CONFIG_PHY_FIXED=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT7988=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK=y
 CONFIG_RAM=y
diff --git a/configs/mt8188.config b/configs/mt8188.config
index 29e2b3db878..c6785476d9a 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -17,8 +17,6 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8188=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_MT8188_POWER_DOMAIN=y
 CONFIG_BAUDRATE=921600
diff --git a/configs/mt8189.config b/configs/mt8189.config
index ab56c90a17c..7c37c37a199 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -35,8 +35,6 @@ CONFIG_PHY=y
 CONFIG_PHY_MTK_TPHY=y
 CONFIG_PHY_MTK_XSPHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8189=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/mt8195.config b/configs/mt8195.config
index 03f57d46708..c12ff93e3eb 100644
--- a/configs/mt8195.config
+++ b/configs/mt8195.config
@@ -17,8 +17,6 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8195=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index 5db8418e36f..b3dcc5cc5b4 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -22,8 +22,6 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8365=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/mt8512_bm1_emmc_defconfig b/configs/mt8512_bm1_emmc_defconfig
index c7ac0df39f5..7f0f866e282 100644
--- a/configs/mt8512_bm1_emmc_defconfig
+++ b/configs/mt8512_bm1_emmc_defconfig
@@ -38,8 +38,6 @@ CONFIG_MMC_MTK=y
 CONFIG_PHY=y
 CONFIG_PHY_MTK_TPHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8512=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_RAM=y
diff --git a/configs/mt8516_pumpkin_defconfig b/configs/mt8516_pumpkin_defconfig
index 72ff8c79153..80184898930 100644
--- a/configs/mt8516_pumpkin_defconfig
+++ b/configs/mt8516_pumpkin_defconfig
@@ -70,8 +70,6 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 # CONFIG_MMC_QUIRKS is not set
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_MT8516=y
 CONFIG_RAM=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
diff --git a/configs/mt8518_ap1_emmc_defconfig b/configs/mt8518_ap1_emmc_defconfig
index 2722e107dc7..fa4b88b24ad 100644
--- a/configs/mt8518_ap1_emmc_defconfig
+++ b/configs/mt8518_ap1_emmc_defconfig
@@ -32,7 +32,6 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
-CONFIG_PINCTRL_MT8518=y
 CONFIG_RAM=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y

-- 
2.43.0

