Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FD0C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 14:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A378D88969;
	Fri, 23 Aug 2024 16:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fd/dHBs8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F54F88A56; Fri, 23 Aug 2024 15:50:34 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64AA988CCB
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-371ba7e46easo1020432f8f.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724421029; x=1725025829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8xDu7zZqrTK5rBt6q1IH5mA6wpcm8jKpSLJpqJUpDU=;
 b=fd/dHBs8mB8ULm0opg8RqtQ+0G/Z/Cpc18NpjKhnFcxqrDpeSeM1ixT01BmbmB2Wk0
 eDPRTBl63PPCVIT4MwB6u8AG5QYmnNpw95lDepQFedsd1WVumYRFskMApKNPrCNvdigu
 dyj+uTzPuN0xljOrz5A1YqfSPe4ipz4fSaehNz6uSEqy0ZQf4XYVQWNMj4WFmtV0BK1l
 oLsvOJme5AoO2hZjbP7pVqp5wWOtbqSWEpRdxMUAc+DUMFE09fwBFGb6ajRC2Ftzx7VX
 5SGSI2Wkg91mO6IDy0cbU+eJdBsEgFY/VgI7jzuxLg5SRkRWgM5Fl5WNU5PbqsDqWICk
 WdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724421029; x=1725025829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8xDu7zZqrTK5rBt6q1IH5mA6wpcm8jKpSLJpqJUpDU=;
 b=Bg/S+RpKvjaPUWJE+Tpc9v+C/AX9rag+st3x7slndGdg7xkccUbfSG+xYTyEK5kOX/
 N1vlvm2pBysSdfJRE7Ymndm+AjIwOZlm7P1N7uiwSQse8a55I1Dj1mCvjOUJnBhf5B41
 8EXiRkT2HYhqsNG2joNJjKye27+hoeqy9XaVYcvubEPVCvTq0A23RSt2ZyxekZc3fwsW
 ugwkPxRBZGBYEqpd6SyZke6cS3MM47UzfDPHVjhq7NPi0ZjG9/BgbobvreZSAKg6m22j
 Hr+apGVDN7VCsN3tLoE5YdD71u7jxjfhQa0nN8knvbYc3Ld3byUD2PkrB9F+qiIy5fYy
 dyVg==
X-Gm-Message-State: AOJu0Yznn3xpaPYJrfmJfT8BdxzMfXpVsjmVTzKyb6A2FU4MuTLq1K02
 vp6kS2UhrIUFa2wpe1uEzYZkVcOKiDFj0MMYKhPtT6UgeS0E/R7aGxd2lAS1cbOd3jKf09/Oh7P
 /U3jDWN0K
X-Google-Smtp-Source: AGHT+IHAiZPDOQZiDlg11TWUpdcN8ebZCOkw7hQRHIwV5TV1y5ywNDzwoX2W4Iml2IMjMYSxGwijKg==
X-Received: by 2002:adf:b19a:0:b0:36b:c66a:b9fd with SMTP id
 ffacd0b85a97d-37311841a8dmr1316663f8f.6.1724421028254; 
 Fri, 23 Aug 2024 06:50:28 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:50:27 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 "Andrew F. Davis" <afd@ti.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Christian Hewitt <christianshewitt@gmail.com>, Stefan Roese <sr@denx.de>,
 Dennis Gilmore <dgilmore@redhat.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Viacheslav Bocharov <adeep@lexina.in>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heiko Thiery <heiko.thiery@gmail.com>, Michael Walle <michael@walle.cc>,
 =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>,
 Kostya Porotchkin <kostap@marvell.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>,
 Patrick Bruenn <p.bruenn@beckhoff.com>, Baruch Siach <baruch@tkos.co.il>,
 Fabio Estevam <festevam@gmail.com>, Adrian Alonso <adrian.alonso@nxp.com>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Marek Vasut <marex@denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Richard Hu <richard.hu@technexion.com>,
 Otavio Salvador <otavio@ossystems.com.br>,
 Navin Sankar Velliangiri <navin@linumiz.com>,
 Simon Glass <sjg@chromium.org>, Mathew McBride <matt@traverse.com.au>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Josef Holzmayr <josef.holzmayr@northern.tech>,
 Igor Prusov <ivprusov@sberdevices.ru>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sean Anderson <seanga2@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Josua Mayer <josua@solid-run.com>, Anatolij Gustschin <agust@denx.de>,
 Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Benjamin Hahn <B.Hahn@phytec.de>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Patryk Biel <pbiel7@gmail.com>,
 "Ole P. Orhagen" <ole.orhagen@northern.tech>,
 Kristian Amlie <kristian.amlie@northern.tech>
Subject: [PATCH v9 37/37] [TESTING] configs: set CONFIG_NET=y when PXE is
 enabled
Date: Fri, 23 Aug 2024 15:48:41 +0200
Message-Id: <00fadaf14a9ef16015a5d5e5543d5ff68d1f4803.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Aug 2024 16:26:38 +0200
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

Many platforms won't build when NET_LWIP is the default choice in
Kconfig:

 include/config_distro_bootcmd.h:443:9: error: expected '}' before 'BOOT_TARGET_DEVICES_references_PXE_without_CONFIG_CMD_DHCP_or_PXE'
 [...]

Set the legacy stack (CONFIG_NET=y) for these platforms.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 configs/ad401_defconfig                     | 1 +
 configs/am43xx_evm_defconfig                | 1 +
 configs/am43xx_evm_qspiboot_defconfig       | 1 +
 configs/am43xx_evm_rtconly_defconfig        | 1 +
 configs/am43xx_evm_usbhost_boot_defconfig   | 1 +
 configs/am43xx_hs_evm_defconfig             | 1 +
 configs/am43xx_hs_evm_qspi_defconfig        | 1 +
 configs/am57xx_evm_defconfig                | 1 +
 configs/am57xx_hs_evm_defconfig             | 1 +
 configs/am57xx_hs_evm_usb_defconfig         | 1 +
 configs/arndale_defconfig                   | 1 +
 configs/bananapi-cm4-cm4io_defconfig        | 1 +
 configs/bananapi-m2-pro_defconfig           | 1 +
 configs/bananapi-m2s_defconfig              | 1 +
 configs/bananapi-m5_defconfig               | 1 +
 configs/beelink-gsking-x_defconfig          | 1 +
 configs/beelink-gt1-ultimate_defconfig      | 1 +
 configs/beelink-gtking_defconfig            | 1 +
 configs/beelink-gtkingpro_defconfig         | 1 +
 configs/clearfog_defconfig                  | 1 +
 configs/clearfog_gt_8k_defconfig            | 1 +
 configs/clearfog_sata_defconfig             | 1 +
 configs/clearfog_spi_defconfig              | 1 +
 configs/dra7xx_evm_defconfig                | 1 +
 configs/dra7xx_hs_evm_defconfig             | 1 +
 configs/dra7xx_hs_evm_usb_defconfig         | 1 +
 configs/helios4_defconfig                   | 1 +
 configs/imx8mn_var_som_defconfig            | 1 +
 configs/jethub_j100_defconfig               | 1 +
 configs/jethub_j80_defconfig                | 1 +
 configs/khadas-vim2_defconfig               | 1 +
 configs/khadas-vim3_defconfig               | 1 +
 configs/khadas-vim3l_defconfig              | 1 +
 configs/khadas-vim_defconfig                | 1 +
 configs/kontron-sl-mx6ul_defconfig          | 1 +
 configs/kontron-sl-mx8mm_defconfig          | 1 +
 configs/kontron_pitx_imx8m_defconfig        | 1 +
 configs/kontron_sl28_defconfig              | 1 +
 configs/libretech-ac_defconfig              | 1 +
 configs/libretech-cc_defconfig              | 1 +
 configs/libretech-cc_v2_defconfig           | 1 +
 configs/libretech-s905d-pc_defconfig        | 1 +
 configs/libretech-s912-pc_defconfig         | 1 +
 configs/marsboard_defconfig                 | 1 +
 configs/mvebu_crb_cn9130_defconfig          | 1 +
 configs/mvebu_db_armada8k_defconfig         | 1 +
 configs/mvebu_db_cn9130_defconfig           | 1 +
 configs/mvebu_mcbin-88f8040_defconfig       | 1 +
 configs/mvebu_puzzle-m801-88f8040_defconfig | 1 +
 configs/mx53cx9020_defconfig                | 1 +
 configs/mx6cuboxi_defconfig                 | 1 +
 configs/mx7dsabresd_defconfig               | 1 +
 configs/mx7dsabresd_qspi_defconfig          | 1 +
 configs/myir_mys_6ulx_defconfig             | 1 +
 configs/nanopi-k2_defconfig                 | 1 +
 configs/novena_defconfig                    | 1 +
 configs/odroid-c2_defconfig                 | 1 +
 configs/odroid-c4_defconfig                 | 1 +
 configs/odroid-go-ultra_defconfig           | 1 +
 configs/odroid-hc4_defconfig                | 1 +
 configs/odroid-n2_defconfig                 | 1 +
 configs/odroid-n2l_defconfig                | 1 +
 configs/odroid-xu3_defconfig                | 1 +
 configs/p200_defconfig                      | 1 +
 configs/p201_defconfig                      | 1 +
 configs/p212_defconfig                      | 1 +
 configs/peach-pi_defconfig                  | 1 +
 configs/peach-pit_defconfig                 | 1 +
 configs/phycore_pcl063_defconfig            | 1 +
 configs/pico-dwarf-imx6ul_defconfig         | 1 +
 configs/pico-dwarf-imx7d_defconfig          | 1 +
 configs/pico-hobbit-imx6ul_defconfig        | 1 +
 configs/pico-hobbit-imx7d_defconfig         | 1 +
 configs/pico-imx6ul_defconfig               | 1 +
 configs/pico-imx7d_bl33_defconfig           | 1 +
 configs/pico-imx7d_defconfig                | 1 +
 configs/pico-nymph-imx7d_defconfig          | 1 +
 configs/pico-pi-imx6ul_defconfig            | 1 +
 configs/pico-pi-imx7d_defconfig             | 1 +
 configs/radxa-zero2_defconfig               | 1 +
 configs/radxa-zero_defconfig                | 1 +
 configs/riotboard_defconfig                 | 1 +
 configs/s400_defconfig                      | 1 +
 configs/seeed_npi_imx6ull_defconfig         | 1 +
 configs/smdk5250_defconfig                  | 1 +
 configs/smdk5420_defconfig                  | 1 +
 configs/snow_defconfig                      | 1 +
 configs/spring_defconfig                    | 1 +
 configs/ten64_tfa_defconfig                 | 1 +
 configs/turris_mox_defconfig                | 1 +
 configs/turris_omnia_defconfig              | 1 +
 configs/u200_defconfig                      | 1 +
 configs/vexpress_aemv8a_juno_defconfig      | 1 +
 configs/vexpress_aemv8a_semi_defconfig      | 1 +
 configs/vexpress_aemv8r_defconfig           | 1 +
 configs/vexpress_ca9x4_defconfig            | 1 +
 configs/vexpress_fvp_defconfig              | 1 +
 configs/videostrong-kii-pro_defconfig       | 1 +
 configs/wandboard_defconfig                 | 1 +
 configs/wetek-core2_defconfig               | 1 +
 configs/wetek-hub_defconfig                 | 1 +
 configs/wetek-play2_defconfig               | 1 +
 102 files changed, 102 insertions(+)

diff --git a/configs/ad401_defconfig b/configs/ad401_defconfig
index b44b9c63e83..9502523b447 100644
--- a/configs/ad401_defconfig
+++ b/configs/ad401_defconfig
@@ -56,3 +56,4 @@ CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_GADGET=y
 CONFIG_WDT=y
+CONFIG_NET=y
diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index d73b1cb804b..394c1a5225c 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -108,3 +108,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_ETHER=y
 CONFIG_SPL_USB_ETHER=y
+CONFIG_NET=y
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index 89e212595af..9d9b96b9adb 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -70,3 +70,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0403
 CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_NET=y
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index 2ff01193285..ccb934cdf96 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -87,3 +87,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0403
 CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_NET=y
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index 845b686ac93..c67d7e86042 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -108,3 +108,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0403
 CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_NET=y
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index ff5073cbb2b..5925f66391d 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -105,3 +105,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_ETHER=y
 CONFIG_SPL_USB_ETHER=y
+CONFIG_NET=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index 5ef59d830e5..c36b572c58e 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -71,3 +71,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0403
 CONFIG_USB_GADGET_PRODUCT_NUM=0xbd00
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_NET=y
diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index 7c3ceeb07db..039efaf7f2f 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -123,3 +123,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
 CONFIG_LIBAVB=y
+CONFIG_NET=y
diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index 1f7eca4691e..5b009f56676 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -119,3 +119,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
 CONFIG_LIBAVB=y
+CONFIG_NET=y
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index 807e1d66a6d..d4b6caa159c 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -120,3 +120,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
 CONFIG_SPL_DFU=y
 CONFIG_LIBAVB=y
+CONFIG_NET=y
diff --git a/configs/arndale_defconfig b/configs/arndale_defconfig
index b664ad58773..9a8439a24df 100644
--- a/configs/arndale_defconfig
+++ b/configs/arndale_defconfig
@@ -57,3 +57,4 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_HOST_ETHER=y
+CONFIG_NET=y
diff --git a/configs/bananapi-cm4-cm4io_defconfig b/configs/bananapi-cm4-cm4io_defconfig
index cb78dabc13a..a2baec987b6 100644
--- a/configs/bananapi-cm4-cm4io_defconfig
+++ b/configs/bananapi-cm4-cm4io_defconfig
@@ -88,3 +88,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/bananapi-m2-pro_defconfig b/configs/bananapi-m2-pro_defconfig
index 196bc4077d6..fad40f49fdc 100644
--- a/configs/bananapi-m2-pro_defconfig
+++ b/configs/bananapi-m2-pro_defconfig
@@ -81,3 +81,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/bananapi-m2s_defconfig b/configs/bananapi-m2s_defconfig
index 7b137d5e1c4..d3e2bb9aeac 100644
--- a/configs/bananapi-m2s_defconfig
+++ b/configs/bananapi-m2s_defconfig
@@ -86,3 +86,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/bananapi-m5_defconfig b/configs/bananapi-m5_defconfig
index 99ed7c9669a..0505283a061 100644
--- a/configs/bananapi-m5_defconfig
+++ b/configs/bananapi-m5_defconfig
@@ -81,3 +81,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/beelink-gsking-x_defconfig b/configs/beelink-gsking-x_defconfig
index c1e60ede4a0..28e13a155b3 100644
--- a/configs/beelink-gsking-x_defconfig
+++ b/configs/beelink-gsking-x_defconfig
@@ -78,3 +78,4 @@ CONFIG_VIDEO_MESON=y
 CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_NET=y
diff --git a/configs/beelink-gt1-ultimate_defconfig b/configs/beelink-gt1-ultimate_defconfig
index 0e30e13c823..73a843f9e5a 100644
--- a/configs/beelink-gt1-ultimate_defconfig
+++ b/configs/beelink-gt1-ultimate_defconfig
@@ -82,3 +82,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_defconfig
index 0b644f0e349..281f6ae496b 100644
--- a/configs/beelink-gtking_defconfig
+++ b/configs/beelink-gtking_defconfig
@@ -78,3 +78,4 @@ CONFIG_VIDEO_MESON=y
 CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_NET=y
diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
index a694617a968..93ac53fb1dc 100644
--- a/configs/beelink-gtkingpro_defconfig
+++ b/configs/beelink-gtkingpro_defconfig
@@ -78,3 +78,4 @@ CONFIG_VIDEO_MESON=y
 CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_NET=y
diff --git a/configs/clearfog_defconfig b/configs/clearfog_defconfig
index 62dbf2aa48f..bd21d3e0f02 100644
--- a/configs/clearfog_defconfig
+++ b/configs/clearfog_defconfig
@@ -77,3 +77,4 @@ CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_NET=y
diff --git a/configs/clearfog_gt_8k_defconfig b/configs/clearfog_gt_8k_defconfig
index df7e04a75bb..5e1292dc7e7 100644
--- a/configs/clearfog_gt_8k_defconfig
+++ b/configs/clearfog_gt_8k_defconfig
@@ -81,3 +81,4 @@ CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_NET=y
diff --git a/configs/clearfog_sata_defconfig b/configs/clearfog_sata_defconfig
index 41382f995d3..16d052223b3 100644
--- a/configs/clearfog_sata_defconfig
+++ b/configs/clearfog_sata_defconfig
@@ -78,3 +78,4 @@ CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_NET=y
diff --git a/configs/clearfog_spi_defconfig b/configs/clearfog_spi_defconfig
index f345b12e6c7..820f3575316 100644
--- a/configs/clearfog_spi_defconfig
+++ b/configs/clearfog_spi_defconfig
@@ -78,3 +78,4 @@ CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_NET=y
diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconfig
index 0cea5504364..784b75bd1a0 100644
--- a/configs/dra7xx_evm_defconfig
+++ b/configs/dra7xx_evm_defconfig
@@ -147,3 +147,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
 CONFIG_SPL_DFU=y
+CONFIG_NET=y
diff --git a/configs/dra7xx_hs_evm_defconfig b/configs/dra7xx_hs_evm_defconfig
index 5f56b187503..b9227251d55 100644
--- a/configs/dra7xx_hs_evm_defconfig
+++ b/configs/dra7xx_hs_evm_defconfig
@@ -141,3 +141,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
 CONFIG_SPL_DFU=y
+CONFIG_NET=y
diff --git a/configs/dra7xx_hs_evm_usb_defconfig b/configs/dra7xx_hs_evm_usb_defconfig
index 5b67a0e8392..4263c1a7b8a 100644
--- a/configs/dra7xx_hs_evm_usb_defconfig
+++ b/configs/dra7xx_hs_evm_usb_defconfig
@@ -128,3 +128,4 @@ CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
 CONFIG_SPL_DFU=y
+CONFIG_NET=y
diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
index 29b6230e901..1a2166d3778 100644
--- a/configs/helios4_defconfig
+++ b/configs/helios4_defconfig
@@ -77,3 +77,4 @@ CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_NET=y
diff --git a/configs/imx8mn_var_som_defconfig b/configs/imx8mn_var_som_defconfig
index 218415fad57..cb92a63ab1f 100644
--- a/configs/imx8mn_var_som_defconfig
+++ b/configs/imx8mn_var_som_defconfig
@@ -113,3 +113,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_NET=y
diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfig
index 9de6b4b44d9..805223551a3 100644
--- a/configs/jethub_j100_defconfig
+++ b/configs/jethub_j100_defconfig
@@ -73,3 +73,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_RANDOM_UUID=y
+CONFIG_NET=y
diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
index 85306872f9a..c22d81a755b 100644
--- a/configs/jethub_j80_defconfig
+++ b/configs/jethub_j80_defconfig
@@ -77,3 +77,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_RANDOM_UUID=y
+CONFIG_NET=y
diff --git a/configs/khadas-vim2_defconfig b/configs/khadas-vim2_defconfig
index 50f8b306505..5eb7106b674 100644
--- a/configs/khadas-vim2_defconfig
+++ b/configs/khadas-vim2_defconfig
@@ -77,3 +77,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
 CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_NET=y
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index 32579b8ac36..d0f03dad0a8 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -102,3 +102,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index b9f4690045a..94dd1055b3c 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -102,3 +102,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/khadas-vim_defconfig b/configs/khadas-vim_defconfig
index ac00e8975e1..13be376ebd7 100644
--- a/configs/khadas-vim_defconfig
+++ b/configs/khadas-vim_defconfig
@@ -68,3 +68,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
 CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_NET=y
diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index f295ecfe4b7..7096d21468b 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -109,3 +109,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_NET=y
diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index 1b7d22b43e1..684ec802c5e 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -149,3 +149,4 @@ CONFIG_EFI_SET_TIME=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y
+CONFIG_NET=y
diff --git a/configs/kontron_pitx_imx8m_defconfig b/configs/kontron_pitx_imx8m_defconfig
index c2133470fc9..c49432504ba 100644
--- a/configs/kontron_pitx_imx8m_defconfig
+++ b/configs/kontron_pitx_imx8m_defconfig
@@ -113,3 +113,4 @@ CONFIG_USB_DWC3=y
 CONFIG_EFI_SET_TIME=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y
+CONFIG_NET=y
diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defconfig
index a1d5f89b1ec..f4db4e8f5e0 100644
--- a/configs/kontron_sl28_defconfig
+++ b/configs/kontron_sl28_defconfig
@@ -131,3 +131,4 @@ CONFIG_WDT_SP805=y
 CONFIG_EFI_SET_TIME=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y
+CONFIG_NET=y
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 6ad04570022..874153174df 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -96,3 +96,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index beb919ca6e8..fe40804f9fc 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -79,3 +79,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
index 6859dfd517c..646f71be6a0 100644
--- a/configs/libretech-cc_v2_defconfig
+++ b/configs/libretech-cc_v2_defconfig
@@ -83,3 +83,4 @@ CONFIG_VIDEO=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_MESON=y
 CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_NET=y
diff --git a/configs/libretech-s905d-pc_defconfig b/configs/libretech-s905d-pc_defconfig
index 0adc0afdf30..eb02012a21d 100644
--- a/configs/libretech-s905d-pc_defconfig
+++ b/configs/libretech-s905d-pc_defconfig
@@ -90,3 +90,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/libretech-s912-pc_defconfig b/configs/libretech-s912-pc_defconfig
index cbce0cf4000..1be8ab43e4b 100644
--- a/configs/libretech-s912-pc_defconfig
+++ b/configs/libretech-s912-pc_defconfig
@@ -89,3 +89,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/marsboard_defconfig b/configs/marsboard_defconfig
index 198fec2cb2c..24c48b101ee 100644
--- a/configs/marsboard_defconfig
+++ b/configs/marsboard_defconfig
@@ -71,3 +71,4 @@ CONFIG_IMX_HDMI=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
+CONFIG_NET=y
diff --git a/configs/mvebu_crb_cn9130_defconfig b/configs/mvebu_crb_cn9130_defconfig
index 4d5f575b038..722fe226b43 100644
--- a/configs/mvebu_crb_cn9130_defconfig
+++ b/configs/mvebu_crb_cn9130_defconfig
@@ -86,3 +86,4 @@ CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_NET=y
diff --git a/configs/mvebu_db_armada8k_defconfig b/configs/mvebu_db_armada8k_defconfig
index 6913796c010..9964c5d8244 100644
--- a/configs/mvebu_db_armada8k_defconfig
+++ b/configs/mvebu_db_armada8k_defconfig
@@ -75,3 +75,4 @@ CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_NET=y
diff --git a/configs/mvebu_db_cn9130_defconfig b/configs/mvebu_db_cn9130_defconfig
index 9133e25b241..3cf83522e67 100644
--- a/configs/mvebu_db_cn9130_defconfig
+++ b/configs/mvebu_db_cn9130_defconfig
@@ -91,3 +91,4 @@ CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_NET=y
diff --git a/configs/mvebu_mcbin-88f8040_defconfig b/configs/mvebu_mcbin-88f8040_defconfig
index eef612a261e..c89d6c33d4e 100644
--- a/configs/mvebu_mcbin-88f8040_defconfig
+++ b/configs/mvebu_mcbin-88f8040_defconfig
@@ -81,3 +81,4 @@ CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_NET=y
diff --git a/configs/mvebu_puzzle-m801-88f8040_defconfig b/configs/mvebu_puzzle-m801-88f8040_defconfig
index b00e92908b3..8304fd6cd87 100644
--- a/configs/mvebu_puzzle-m801-88f8040_defconfig
+++ b/configs/mvebu_puzzle-m801-88f8040_defconfig
@@ -83,3 +83,4 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_EFI_LOADER is not set
+CONFIG_NET=y
diff --git a/configs/mx53cx9020_defconfig b/configs/mx53cx9020_defconfig
index c20c6a40a1d..9d127dd2d64 100644
--- a/configs/mx53cx9020_defconfig
+++ b/configs/mx53cx9020_defconfig
@@ -41,3 +41,4 @@ CONFIG_VIDEO=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_IPUV3=y
 CONFIG_IMX_VIDEO_SKIP=y
+CONFIG_NET=y
diff --git a/configs/mx6cuboxi_defconfig b/configs/mx6cuboxi_defconfig
index e3aba715aa5..cd400eec02f 100644
--- a/configs/mx6cuboxi_defconfig
+++ b/configs/mx6cuboxi_defconfig
@@ -93,3 +93,4 @@ CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_NET=y
diff --git a/configs/mx7dsabresd_defconfig b/configs/mx7dsabresd_defconfig
index 7811b17bf0f..2072fea5bc7 100644
--- a/configs/mx7dsabresd_defconfig
+++ b/configs/mx7dsabresd_defconfig
@@ -89,3 +89,4 @@ CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_IMX_WATCHDOG=y
 CONFIG_ERRNO_STR=y
+CONFIG_NET=y
diff --git a/configs/mx7dsabresd_qspi_defconfig b/configs/mx7dsabresd_qspi_defconfig
index 2ee8bd36252..36464c1387e 100644
--- a/configs/mx7dsabresd_qspi_defconfig
+++ b/configs/mx7dsabresd_qspi_defconfig
@@ -91,3 +91,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_ERRNO_STR=y
+CONFIG_NET=y
diff --git a/configs/myir_mys_6ulx_defconfig b/configs/myir_mys_6ulx_defconfig
index b165dd407d1..39ceea85115 100644
--- a/configs/myir_mys_6ulx_defconfig
+++ b/configs/myir_mys_6ulx_defconfig
@@ -70,3 +70,4 @@ CONFIG_SPL_USB_HOST=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
 # CONFIG_RANDOM_UUID is not set
+CONFIG_NET=y
diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
index 2e1c756bf7a..db0a6f8c079 100644
--- a/configs/nanopi-k2_defconfig
+++ b/configs/nanopi-k2_defconfig
@@ -46,3 +46,4 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
+CONFIG_NET=y
diff --git a/configs/novena_defconfig b/configs/novena_defconfig
index 322689ef3a2..978a02112b2 100644
--- a/configs/novena_defconfig
+++ b/configs/novena_defconfig
@@ -106,3 +106,4 @@ CONFIG_IMX_VIDEO_SKIP=y
 CONFIG_IMX_HDMI=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_BMP_16BPP=y
+CONFIG_NET=y
diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index ce5eaec3cd2..e922314e54a 100644
--- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -71,3 +71,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index 4ef1e681666..9b59ecea421 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -82,3 +82,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/odroid-go-ultra_defconfig b/configs/odroid-go-ultra_defconfig
index 06437fe3ae0..20e4bdea976 100644
--- a/configs/odroid-go-ultra_defconfig
+++ b/configs/odroid-go-ultra_defconfig
@@ -75,3 +75,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_NET=y
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
index 60233fb9cee..ffcdb4f4a2e 100644
--- a/configs/odroid-hc4_defconfig
+++ b/configs/odroid-hc4_defconfig
@@ -99,3 +99,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index a4cc766f84a..72a0c2e51c7 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -79,3 +79,4 @@ CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/odroid-n2l_defconfig b/configs/odroid-n2l_defconfig
index 3f657d18812..45617f04705 100644
--- a/configs/odroid-n2l_defconfig
+++ b/configs/odroid-n2l_defconfig
@@ -74,3 +74,4 @@ CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/odroid-xu3_defconfig b/configs/odroid-xu3_defconfig
index c80900e2cc5..66e51ad1b79 100644
--- a/configs/odroid-xu3_defconfig
+++ b/configs/odroid-xu3_defconfig
@@ -72,3 +72,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x04e8
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6601
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_ERRNO_STR=y
+CONFIG_NET=y
diff --git a/configs/p200_defconfig b/configs/p200_defconfig
index b6946034795..1a84f5cfb5b 100644
--- a/configs/p200_defconfig
+++ b/configs/p200_defconfig
@@ -45,3 +45,4 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
+CONFIG_NET=y
diff --git a/configs/p201_defconfig b/configs/p201_defconfig
index dcc1454be16..dfbe1b79ed0 100644
--- a/configs/p201_defconfig
+++ b/configs/p201_defconfig
@@ -46,3 +46,4 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
+CONFIG_NET=y
diff --git a/configs/p212_defconfig b/configs/p212_defconfig
index 9cf22ca4db7..1ae033bc804 100644
--- a/configs/p212_defconfig
+++ b/configs/p212_defconfig
@@ -54,3 +54,4 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_MESON_GXL=y
+CONFIG_NET=y
diff --git a/configs/peach-pi_defconfig b/configs/peach-pi_defconfig
index 27d438efb79..b420b278764 100644
--- a/configs/peach-pi_defconfig
+++ b/configs/peach-pi_defconfig
@@ -90,3 +90,4 @@ CONFIG_VIDEO_BRIDGE=y
 CONFIG_VIDEO_BRIDGE_PARADE_PS862X=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
+CONFIG_NET=y
diff --git a/configs/peach-pit_defconfig b/configs/peach-pit_defconfig
index 1c7e0114a85..42323d5e547 100644
--- a/configs/peach-pit_defconfig
+++ b/configs/peach-pit_defconfig
@@ -89,3 +89,4 @@ CONFIG_VIDEO_BRIDGE=y
 CONFIG_VIDEO_BRIDGE_PARADE_PS862X=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
+CONFIG_NET=y
diff --git a/configs/phycore_pcl063_defconfig b/configs/phycore_pcl063_defconfig
index 2f6b158a677..fdc2b1493d9 100644
--- a/configs/phycore_pcl063_defconfig
+++ b/configs/phycore_pcl063_defconfig
@@ -68,3 +68,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x4fff
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 # CONFIG_RANDOM_UUID is not set
+CONFIG_NET=y
diff --git a/configs/pico-dwarf-imx6ul_defconfig b/configs/pico-dwarf-imx6ul_defconfig
index 8b90285980f..668a9321504 100644
--- a/configs/pico-dwarf-imx6ul_defconfig
+++ b/configs/pico-dwarf-imx6ul_defconfig
@@ -79,3 +79,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_NET=y
diff --git a/configs/pico-dwarf-imx7d_defconfig b/configs/pico-dwarf-imx7d_defconfig
index 9d5241a50d0..e390cd4e304 100644
--- a/configs/pico-dwarf-imx7d_defconfig
+++ b/configs/pico-dwarf-imx7d_defconfig
@@ -95,3 +95,4 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
+CONFIG_NET=y
diff --git a/configs/pico-hobbit-imx6ul_defconfig b/configs/pico-hobbit-imx6ul_defconfig
index e3aca6e82e1..7283a6754d1 100644
--- a/configs/pico-hobbit-imx6ul_defconfig
+++ b/configs/pico-hobbit-imx6ul_defconfig
@@ -82,3 +82,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_NET=y
diff --git a/configs/pico-hobbit-imx7d_defconfig b/configs/pico-hobbit-imx7d_defconfig
index 690139c09ca..a48ce623f2b 100644
--- a/configs/pico-hobbit-imx7d_defconfig
+++ b/configs/pico-hobbit-imx7d_defconfig
@@ -94,3 +94,4 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
+CONFIG_NET=y
diff --git a/configs/pico-imx6ul_defconfig b/configs/pico-imx6ul_defconfig
index ce29718a903..2d4e68ca76e 100644
--- a/configs/pico-imx6ul_defconfig
+++ b/configs/pico-imx6ul_defconfig
@@ -90,3 +90,4 @@ CONFIG_VIDEO_LOGO=y
 CONFIG_VIDEO_MXS=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_NET=y
diff --git a/configs/pico-imx7d_bl33_defconfig b/configs/pico-imx7d_bl33_defconfig
index 1327523e289..c63a4620089 100644
--- a/configs/pico-imx7d_bl33_defconfig
+++ b/configs/pico-imx7d_bl33_defconfig
@@ -94,3 +94,4 @@ CONFIG_VIDEO_MXS=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
+CONFIG_NET=y
diff --git a/configs/pico-imx7d_defconfig b/configs/pico-imx7d_defconfig
index 6009b1c65c1..f614c6fbc40 100644
--- a/configs/pico-imx7d_defconfig
+++ b/configs/pico-imx7d_defconfig
@@ -96,3 +96,4 @@ CONFIG_VIDEO_MXS=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
+CONFIG_NET=y
diff --git a/configs/pico-nymph-imx7d_defconfig b/configs/pico-nymph-imx7d_defconfig
index 9d5241a50d0..e390cd4e304 100644
--- a/configs/pico-nymph-imx7d_defconfig
+++ b/configs/pico-nymph-imx7d_defconfig
@@ -95,3 +95,4 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
+CONFIG_NET=y
diff --git a/configs/pico-pi-imx6ul_defconfig b/configs/pico-pi-imx6ul_defconfig
index 81f3e9bbebb..2b86127d59b 100644
--- a/configs/pico-pi-imx6ul_defconfig
+++ b/configs/pico-pi-imx6ul_defconfig
@@ -82,3 +82,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_NET=y
diff --git a/configs/pico-pi-imx7d_defconfig b/configs/pico-pi-imx7d_defconfig
index 28c46abed78..6a14e3bcd72 100644
--- a/configs/pico-pi-imx7d_defconfig
+++ b/configs/pico-pi-imx7d_defconfig
@@ -98,3 +98,4 @@ CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_NET=y
diff --git a/configs/radxa-zero2_defconfig b/configs/radxa-zero2_defconfig
index 92e0a8833cc..ba90842e973 100644
--- a/configs/radxa-zero2_defconfig
+++ b/configs/radxa-zero2_defconfig
@@ -77,3 +77,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/radxa-zero_defconfig b/configs/radxa-zero_defconfig
index 5179c58dadc..b734fa8c6a4 100644
--- a/configs/radxa-zero_defconfig
+++ b/configs/radxa-zero_defconfig
@@ -73,3 +73,4 @@ CONFIG_VIDEO_MESON=y
 CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_NET=y
diff --git a/configs/riotboard_defconfig b/configs/riotboard_defconfig
index a1e806be421..3f61fe5831e 100644
--- a/configs/riotboard_defconfig
+++ b/configs/riotboard_defconfig
@@ -89,3 +89,4 @@ CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
 CONFIG_SPL_OF_LIBFDT=y
+CONFIG_NET=y
diff --git a/configs/s400_defconfig b/configs/s400_defconfig
index d75d296fa0e..01607562552 100644
--- a/configs/s400_defconfig
+++ b/configs/s400_defconfig
@@ -60,3 +60,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
 CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_NET=y
diff --git a/configs/seeed_npi_imx6ull_defconfig b/configs/seeed_npi_imx6ull_defconfig
index e7557025dd2..f093c26dd7f 100644
--- a/configs/seeed_npi_imx6ull_defconfig
+++ b/configs/seeed_npi_imx6ull_defconfig
@@ -75,3 +75,4 @@ CONFIG_SPL_USB_HOST=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
 # CONFIG_RANDOM_UUID is not set
+CONFIG_NET=y
diff --git a/configs/smdk5250_defconfig b/configs/smdk5250_defconfig
index 8b42c8bdb32..abc601da69f 100644
--- a/configs/smdk5250_defconfig
+++ b/configs/smdk5250_defconfig
@@ -73,3 +73,4 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_ERRNO_STR=y
+CONFIG_NET=y
diff --git a/configs/smdk5420_defconfig b/configs/smdk5420_defconfig
index 55a53178f9c..dd4e4fb9849 100644
--- a/configs/smdk5420_defconfig
+++ b/configs/smdk5420_defconfig
@@ -58,3 +58,4 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_HOST_ETHER=y
+CONFIG_NET=y
diff --git a/configs/snow_defconfig b/configs/snow_defconfig
index 2c0757194bd..664ea4032f7 100644
--- a/configs/snow_defconfig
+++ b/configs/snow_defconfig
@@ -108,3 +108,4 @@ CONFIG_VIDEO_BRIDGE_NXP_PTN3460=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
 CONFIG_UNIT_TEST=y
+CONFIG_NET=y
diff --git a/configs/spring_defconfig b/configs/spring_defconfig
index 2bd45cb9d60..4b5a4e61896 100644
--- a/configs/spring_defconfig
+++ b/configs/spring_defconfig
@@ -101,3 +101,4 @@ CONFIG_VIDEO_BRIDGE=y
 CONFIG_VIDEO_BRIDGE_PARADE_PS862X=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
+CONFIG_NET=y
diff --git a/configs/ten64_tfa_defconfig b/configs/ten64_tfa_defconfig
index 88609d8401f..5cb2c6070ad 100644
--- a/configs/ten64_tfa_defconfig
+++ b/configs/ten64_tfa_defconfig
@@ -97,3 +97,4 @@ CONFIG_WDT=y
 CONFIG_WDT_SP805=y
 CONFIG_TPM=y
 CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
+CONFIG_NET=y
diff --git a/configs/turris_mox_defconfig b/configs/turris_mox_defconfig
index c62e0d04c9c..7b394a904cf 100644
--- a/configs/turris_mox_defconfig
+++ b/configs/turris_mox_defconfig
@@ -106,3 +106,4 @@ CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
 CONFIG_WDT=y
 CONFIG_WDT_ARMADA_37XX=y
+CONFIG_NET=y
diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index c8756a3a788..e82e1e727ed 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -129,3 +129,4 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_WDT=y
 CONFIG_WDT_ORION=y
+CONFIG_NET=y
diff --git a/configs/u200_defconfig b/configs/u200_defconfig
index 879ae0defa7..6079f68d82a 100644
--- a/configs/u200_defconfig
+++ b/configs/u200_defconfig
@@ -63,3 +63,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_NET=y
diff --git a/configs/vexpress_aemv8a_juno_defconfig b/configs/vexpress_aemv8a_juno_defconfig
index 7ac70edc2ea..63647b0ff8d 100644
--- a/configs/vexpress_aemv8a_juno_defconfig
+++ b/configs/vexpress_aemv8a_juno_defconfig
@@ -36,3 +36,4 @@ CONFIG_SYS_FLASH_PROTECTION=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SYS_MAX_FLASH_SECT=259
 CONFIG_USB=y
+CONFIG_NET=y
diff --git a/configs/vexpress_aemv8a_semi_defconfig b/configs/vexpress_aemv8a_semi_defconfig
index 29f8213e6e0..234d7d86cd1 100644
--- a/configs/vexpress_aemv8a_semi_defconfig
+++ b/configs/vexpress_aemv8a_semi_defconfig
@@ -31,3 +31,4 @@ CONFIG_SYS_FLASH_EMPTY_INFO=y
 CONFIG_SYS_FLASH_PROTECTION=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SYS_MAX_FLASH_SECT=256
+CONFIG_NET=y
diff --git a/configs/vexpress_aemv8r_defconfig b/configs/vexpress_aemv8r_defconfig
index 96fbef5fa19..2d8810782ff 100644
--- a/configs/vexpress_aemv8r_defconfig
+++ b/configs/vexpress_aemv8r_defconfig
@@ -14,3 +14,4 @@ CONFIG_SYS_PBSIZE=541
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SYS_PROMPT="VExpress64# "
 # CONFIG_MMC is not set
+CONFIG_NET=y
diff --git a/configs/vexpress_ca9x4_defconfig b/configs/vexpress_ca9x4_defconfig
index 67adba437bf..ec33e22a982 100644
--- a/configs/vexpress_ca9x4_defconfig
+++ b/configs/vexpress_ca9x4_defconfig
@@ -36,6 +36,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
+CONFIG_NET=y
 CONFIG_CLK=y
 CONFIG_ARM_PL180_MMCI=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=127
diff --git a/configs/vexpress_fvp_defconfig b/configs/vexpress_fvp_defconfig
index 7362c1fc35c..c054cbef539 100644
--- a/configs/vexpress_fvp_defconfig
+++ b/configs/vexpress_fvp_defconfig
@@ -3,3 +3,4 @@ CONFIG_ARCH_VEXPRESS64=y
 CONFIG_DEFAULT_DEVICE_TREE="arm_fvp"
 CONFIG_IDENT_STRING=" arm_fvp"
 # CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_NET=y
diff --git a/configs/videostrong-kii-pro_defconfig b/configs/videostrong-kii-pro_defconfig
index 7a5af234471..6f9b2f15e92 100644
--- a/configs/videostrong-kii-pro_defconfig
+++ b/configs/videostrong-kii-pro_defconfig
@@ -69,3 +69,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/wandboard_defconfig b/configs/wandboard_defconfig
index e9deab38038..df41406a7ef 100644
--- a/configs/wandboard_defconfig
+++ b/configs/wandboard_defconfig
@@ -91,3 +91,4 @@ CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_NET=y
diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfig
index c4b126c2b7e..2f601f8c008 100644
--- a/configs/wetek-core2_defconfig
+++ b/configs/wetek-core2_defconfig
@@ -76,3 +76,4 @@ CONFIG_VIDEO=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_MESON=y
 CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_NET=y
diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
index 85cff73f50f..6fd4cc1410a 100644
--- a/configs/wetek-hub_defconfig
+++ b/configs/wetek-hub_defconfig
@@ -69,3 +69,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
index efdf820165b..fa270b4db66 100644
--- a/configs/wetek-play2_defconfig
+++ b/configs/wetek-play2_defconfig
@@ -69,3 +69,4 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_NET=y
-- 
2.40.1

