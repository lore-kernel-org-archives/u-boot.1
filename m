Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D77D1F9DA
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80D808408D;
	Thu,  4 Dec 2025 13:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TkmYo5ew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 977CA83FA5; Thu,  4 Dec 2025 11:26:37 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD31A83FE6
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b739ef3f739so115944966b.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 02:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764843995; x=1765448795;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0LhVisA/dAqNh6vCizgqrXButgnprtcOeAMx1SA0mg0=;
 b=TkmYo5ew9byTYhQ3UmtGE99IP7FSjiSahAsbLZ3mZugs7ttFGg42DP6yBzQF+Gflkz
 tvsmK16oGBm68mkjQEODZEIJyVbsr1YN6tiJ1ax3ehaa5MLP9Vzy0xhBa3LUrt9HzoHn
 rxmjxiIUC83AGFNjnCOXKw4Ax3ZKYUmuI885YiJlwlkVAL1UtrMsscAzjuEV/0q+p+Tj
 e6kXOhvbKqbzQ6VZVLqJlyYoLX4K3DM7rIcWzPksIponO3xh77A++H4elcwSo7Tt1FNg
 9R5vPjPfBM7gcjO7V6a2feRGSDB8g0/rvPhX5hEVD/dVXdTSzumow2YdevV4Z78pIS+3
 ZGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764843995; x=1765448795;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0LhVisA/dAqNh6vCizgqrXButgnprtcOeAMx1SA0mg0=;
 b=RF80NeLz03W4EOcYZQrEwZ9gZbsIrpwCkzssnFXuwmTZzNGrMnxR83TatZaQWtmSkN
 yTNvzk3P2UlwRkSQG7STTF18ttXL3++t37B27vyLSzC7q2OvHv0S4ihA485VJzUonQQe
 atGWRnKaGC0mTtJMB+M2RWBqI3ifb00pjXNUg2sDJIoAC+CUfekgd1yIzCZ15Lbm+iCy
 lDXGJzLHVBaZIm7AM0ruL3HFt23IyxS3aBdK6fQBfONbQz0VP0u+aeHa5Bg/UIrIA5kg
 /jkLS9nphEfJxdaiWBOFIaLdWL4a7+mUxWGLvn2ybNGOcApvZX/PpTGbjYDu4goXE85C
 cpAQ==
X-Gm-Message-State: AOJu0YwoA7VHv/blAN07Ws9PQOuAf1elqxPYUThC17TRtOGWO6T64PzT
 keqFtKDIwuxu4lVhXMSfaza+UXfGcZ9QYmhLSxF2Fl/haGGOrRIsBe3UNYlz/Iq5z1U=
X-Gm-Gg: ASbGnctHfAoDXUZrOTqV53+fGaMAc7iIq1nuLrXNchwGXcZqzPmD/c3EHaoDmiZqnkf
 IIC5ITbepjFjefwSj9ggdxrzuvij0oBKxaT78MtPcpj+/eOkRqRKZvQQMwt6lbU2J6CEfUkb2Qb
 PH4aSBpyC78Cr9om6eMLO3unN97dt46wH7oDfPyBLx/LyKSk3q3kx/ipG966F1tLUCU3Igh2IfH
 wnVuCx0zDPIImLQlsgDRnwuh7gj2ZhwM3YazPRcx8S6SHA+YJoLy49jsKU7NhicepCKTcrU0a3u
 6S3pLYOP4f0elyMth+FsIG2rQZGWO+IxNb+k3cZr8nXf7nuzgySAUgpDN6+ze+eL5a5Mj7Do26B
 aJOBj1u29Twk52Cpv1MQzK2LNqZqe9VuV8TyLxhE8l7/Y7xHfYXHK8y88ETvD4msJtkLIGax5UC
 R6E3hw0hk=
X-Google-Smtp-Source: AGHT+IHo5RFcyCK/RdrSln8XvXclp6fGTp/d/6qw9xmRXdShnceWk1fIjJoZIsjhgPfTs/5XznQvIw==
X-Received: by 2002:a17:907:3f24:b0:b70:68d7:ac0c with SMTP id
 a640c23a62f3a-b79ec6b9586mr291602366b.42.1764843995047; 
 Thu, 04 Dec 2025 02:26:35 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f49e10edsm91535766b.59.2025.12.04.02.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 02:26:34 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 04 Dec 2025 11:25:38 +0100
Subject: [PATCH v3 2/9] configs: am335x_evm_defconfig: Enable panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-topic-am33-evm-oftree-v2026-01-v3-2-3d1566ce4dc7@baylibre.com>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
In-Reply-To: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1752; i=msp@baylibre.com;
 h=from:subject:message-id; bh=V6x6lZUshJD0VlFKXCJ9evMg4jEnIt2esn6+FimOrZo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzDxA35f68pHOB7wKAyfyX7j7Sfezd19f9bfHyZUAnb3
 Nis10wtHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjARzwyG36z3+tYIvuv+xNvu
 lpevNmnh+1/Llbt7wjecLXnvL1V7pIrhv8/sVc2u3r3hgVvnnH4eHhO+Ud2xJ8ePVTnKNMP2651
 DnAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
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
2.51.0

