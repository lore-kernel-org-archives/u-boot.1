Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5F3F43857
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 16:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3953E84201;
	Wed, 15 Apr 2026 18:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="huS/9ejg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA14384246; Wed, 15 Apr 2026 18:03:53 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC7E28422D
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 18:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so3250146f8f.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776269031; x=1776873831;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JPkQh1mbXFukhjglZ5Uz+w/yM9Y4YzDZBiDwcE/KMjw=;
 b=huS/9ejgl+veQHBka9dFCPW5KXgifL/iHlMaT5UcBVLsSy08Wzylj3bYGF6x6hsSA6
 5b0QSJTasUKWOLNAsA3Atzm6q+rqaH6+XAfsH6nkfs3oCNa1jxvteQ7LpAvmqQzqni7Y
 BtkT+MzaE0+sB0aRw5Nt9LbGKxH6HSm7Zrta9gzvQXuK70DhM4CqQrI0wmX/Tw9gzdJE
 e+bjZ1pM0SNtyi9VUqjHcXUVJ7vrZRfjNQJG18AhwoI+Br3npR8qblIpFUdTsBlnp/Is
 jblx/38Ovz31j8URdxfRByzPEyOaGxG7N/DRbXc3BM+jsTYu9xmRVAw/ygyCEaFOGJnf
 MGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269031; x=1776873831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JPkQh1mbXFukhjglZ5Uz+w/yM9Y4YzDZBiDwcE/KMjw=;
 b=WOIOMtTJ00qbRQjVvCB/R1NRBhcAZfxeyx/5BfE5Dp7o0vGXMXP+eZNxgH/b7iUoVV
 oZTeokkbJkpmJ8ESdPkx2AMBpwn/ijNhLb10ZV5U+Hv+yeOsJOmqX+8Ccjo+0UK/SJSM
 6MSKdzHyVM79R/TqW1m7Ck5KDqpa+wszN/Vj9og/w5AKUC41EEKBz3qfXf+VYWgREFl3
 0eBtYjblHNhZP1MZa2kCdBWeqXbTmtTN3r9QnH94mf2Y6LujHMHA3MbcnqbaYL+r0SZB
 I6aF9v7hnmxGSNJzo+3IK20/gHniZptVYGrPTRbTKiK/cVAn3pKvuvrZy8Z8/nqzH9qF
 FxDw==
X-Gm-Message-State: AOJu0Yz2nu1vTCee8hUN7Xh6OJMG6+tam8tTBdOkqvT6U0pGKL8votAW
 t3prZSoiUCyuYyp3rPlAcKG29kywTiqxbSwYab59nyo8eN66P+Jjk4R2AnS+yDm0eOg=
X-Gm-Gg: AeBDieuKthF7eDMV5P1WAXst9DMpbASd3x/u6sv5LTFebphvPlLqsTJ2d3eUEe86xKi
 RPvsHhP3xMWhQPNo7VD8u0bxGK6uYZ0gxumhN/6ChM50UFPAUak3ecpx+RrjRnCeEb/hKJBLd9d
 D40GQKhJG3xrmTFNp4m1Idr7cabzg95MErohEoQijWVr2fYc+RoZ3pXggu6lQ12A9wGdpSytiYz
 EPnM9Bm7ryJB9aHbb+DKAQYBLolTHMfIyrNQukIIPptJs7A0eo0ba3QVBmZJS3KVlawV2k5gf+J
 hS861HhcZdm+j1Al7cISe65L60St2fyQyPZm7pqpWegAmrGvPu1dYT29zs5GQl/S4IVAdH7VEsu
 Cg4u+H0+u4IJXYgooBW3OQfsYEi6It2w6DslgaoS05fnos4BqnKpHLDP4ksKsPrWqwn70GI66hG
 syi1J1oIxPgT8llFGnvYTk/iiKvAF16Gk=
X-Received: by 2002:a05:6000:2c0c:b0:43d:2ffc:2f6c with SMTP id
 ffacd0b85a97d-43d6427b958mr34143286f8f.5.1776269030822; 
 Wed, 15 Apr 2026 09:03:50 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5fd6sm6377997f8f.24.2026.04.15.09.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:03:49 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 15 Apr 2026 18:02:23 +0200
Subject: [PATCH v6 02/14] configs: am335x_evm_defconfig: Enable panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-topic-am33-evm-oftree-v2026-01-v6-2-94cde349bb01@baylibre.com>
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
In-Reply-To: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=msp@baylibre.com;
 h=from:subject:message-id; bh=4ukWTPl11dA7ju943KsRIXw4k3rBB8rkirnMzkQwus4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz72+Yd2LjJ8u7Eqn7tJVuVxHkMdmesslib6RnE6pK38
 EULc+KHjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZhImgUjw+oK12VJmzWtq49P
 Kfzacfnf0na+DNcGOfPXdUafWhQ+xTAyzO299tStvunqeZ7ERV+LWWeregYafJ4sX+mq7W2yMfo
 eOwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Enable LCD panel support on am335x-evm:
 - CLK_CCF and CLK_TI_* for display clock tree
 - DM_PWM and PWM_TI_ECAP for backlight control
 - VIDEO and AM335X_LCD for display controller

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 configs/am335x_evm_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 5a3e0530a31663faf565e0afeede5765be16985b..bd188c252780fb541afbbe61a243bddaab79be93 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -60,8 +60,14 @@ CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_SYS_BOOTCOUNT_BE=y
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
 CONFIG_CLK_CDCE9XX=y
+CONFIG_CLK_TI_AM3_DPLL=y
 CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_NAND=y
@@ -71,6 +77,7 @@ CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=1
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_DM_I2C=y
+CONFIG_MISC=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 # CONFIG_MMC_HW_PARTITIONING is not set
 CONFIG_MMC_OMAP_HS=y
@@ -95,6 +102,8 @@ CONFIG_DM_PMIC=y
 # CONFIG_SPL_DM_PMIC is not set
 CONFIG_PMIC_TPS65217=y
 CONFIG_SPL_POWER_TPS65910=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_TI_ECAP=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_OMAP3_SPI=y
@@ -113,6 +122,8 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
 CONFIG_USB_ETHER=y
 CONFIG_SPL_USB_ETHER=y
+CONFIG_VIDEO=y
+CONFIG_AM335X_LCD=y
 CONFIG_WDT=y
 # CONFIG_SPL_WDT is not set
 CONFIG_DYNAMIC_CRC_TABLE=y

-- 
2.53.0

