Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6BEFF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3563A8416F;
	Mon, 27 Apr 2026 14:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="jqpc+2BO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D59EF84144; Mon, 27 Apr 2026 11:03:23 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD9DA84119
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso51441015e9.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777280598; x=1777885398;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JPkQh1mbXFukhjglZ5Uz+w/yM9Y4YzDZBiDwcE/KMjw=;
 b=jqpc+2BOEzaY6R9pOM0/EgY3fEbU4XW7LSZSXnr8NBF019Vjqa0aZ1BZkIWsb8Txby
 sdAOXQmPmH2yazTLz2xkY3zGOyZzk7PlHYhYTEzJQT95ElhtWv8rG6ST1pzDa81gLVyf
 BUQdb6OyqfFfzWmV82L1shQPr9/dEoak6ikIruevCcHGh5/PqEHFoBqzi9em00yIGL3b
 kYQI2xCYLz0E49QUd9z3zrHnzSTXYq0Hkw8MNFABf4hwKmY6rgQ3rtN6brNlwI9pfIY7
 EEtGviIDRTy5iJE6zC+WawfxxNpsD1nF8tlB3/N1AWUMb++n8v3ZkV4sP37QUTDK0toZ
 1EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280598; x=1777885398;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JPkQh1mbXFukhjglZ5Uz+w/yM9Y4YzDZBiDwcE/KMjw=;
 b=Y1mU1Pseqe6/y6jMhDjUChDY95iaJa/MtwCtnVbfG1+sG9oiHKcMG5w/7v+NYK0MvZ
 eUQ8uSBe5mOF7qHqtJNz+ewx9P1E/YpxypjTS2i0EesojX1Ub8W8Lw1rkO8FtyCeeJVR
 /OaV7a4hKYFcwdRtCoekTfJQ7WOXTO21/lXfNhBxn+Eai4OUj81Rn+OmHrBAmoM7Zlfe
 S4h8jtn+/WkcBGOA4GNfF1m1E/d2llJE8syaBF1MzoHe55MoYHZ6bgTVHanpcZv7nEM3
 kI3ar3mfmG7MMnt8YOl8KGScuSi2TOvGZTXYvnFUlBAiDg60a74QIU2O8ZGmXPpLROlb
 mA1Q==
X-Gm-Message-State: AOJu0Yxp82n/K+ZF7zrKfYPjB+P+/Fbb7PE4Ek6axKIBoywQBbTryVrV
 58Gjz9+alEzgg7Ph5Z/mQjZsHcJ8BStoSmuV3dOF6r0iJUm1zefjSGTEYv9ea00Smfo=
X-Gm-Gg: AeBDieu0yNcP7cO7165CHIOLUMjR/3HDfyhwlaXC3E400uJdSADAUBfyBXXGPei/N33
 BxW2TmrozHJZWZhIqoj7yR5hHvcO5WBfPJomTCt3DoUh1uats1Ku5LGn7MKwQwCqQOM+dyzo31g
 DoUDgRRGaVpF+/RTHrdVuMt8aX6/XO0M+7e8YiGzyvPE3xfhwc3t+qo/9Yulb+VdPvKl8j+CTD4
 e3NvHvu8lu+rZ0GolqiOVooqtI+llZLWon6rb+R+PoJG6MIB4/fkjPnhwAmJLCVZu2eX/280Tij
 gohWewfDAbWSy2BE1hjkXwxs25qNxpu6LSBHIwGXZPMCOwAceuSLkBXRdnCqq/TDqLA6eAC3WAp
 Q4Y6bc8zIxqp+C9t/RHoL6m2K1zpHW2lMGqEYIKckqwiftyExXvOh2fh1yVY18RnjhJILZeU/EU
 fq4mN+8GLEpwhqGwA7ziC1eei+Y9mln+8=
X-Received: by 2002:a05:600c:6209:b0:48a:592c:e63d with SMTP id
 5b1f17b1804b1-48a592ce89emr325249345e9.14.1777280598062; 
 Mon, 27 Apr 2026 02:03:18 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a575ad67asm393924035e9.2.2026.04.27.02.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:03:17 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 27 Apr 2026 11:01:18 +0200
Subject: [PATCH v7 02/14] configs: am335x_evm_defconfig: Enable panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-topic-am33-evm-oftree-v2026-01-v7-2-7e6cd1a805a1@baylibre.com>
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
In-Reply-To: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
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
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=msp@baylibre.com;
 h=from:subject:message-id; bh=4ukWTPl11dA7ju943KsRIXw4k3rBB8rkirnMzkQwus4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz3aiIbT9TyiTDMuS+zYWqVWInQcWXpp+7PH77Zo1XHV
 3ns+tQpHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCR7+4M/ys4UwqNL7hqlobL
 zuHbkMjnt3Ln+2d/W1cGR+ceNTx5wICR4YvXHkuvdf7XRYq8Y44um1RU82rZAdYzz3i4XrisyFv
 ymRkA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 27 Apr 2026 14:54:41 +0200
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

