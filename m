Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF01BD116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7854383CF5;
	Fri, 28 Nov 2025 23:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qw7rH7yu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01B4E83B91; Fri, 28 Nov 2025 21:47:40 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BC9C83B63
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 21:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so19886365e9.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764362857; x=1764967657;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Iom/guv4dIhTbUav8mlCa12BEDkzcHh53HWYurG3w6o=;
 b=qw7rH7yuOwb7r1uhIg1/A58t+WkVzt0jNGEL5xdljiV0q41JumOexIhR2Moqva+Dz2
 HNjKRMFRrInSf1oRtV66zxCJp9GHvuBG1IojK1HTA42niL3yZln8lrRMVvCDvRcK2U/M
 SVq+PkUqHIHEIaaagnT9NhnG/YYbkou8Z0p3Lk5SNQbU4Wejurvv/XYInW/7cDwBAbjF
 P3ZQIj4shmtjQvtymvm388trHsxUpZi9qJIXEPkRu6UGJXRwuZgmxKxqOVYL0CZJka4q
 0iqkZCKTcW7nyqrh5DlO7VEggHE1Qo6Whx8TWwoG1gOq7rH70QnLmkibpBcXwAun2xFV
 4WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764362857; x=1764967657;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Iom/guv4dIhTbUav8mlCa12BEDkzcHh53HWYurG3w6o=;
 b=Lfr+x9tgn4wF7wt568NRCq207f3Lk+HMi8fHXhbtG8/fiFLiI+e3a8loCS/Byu1yF7
 Ka8rxZdrNDfYrBWgW2CX8VHzAiKmfzBDJLrS0FLGCUiT0JMmnKMVhiSSH3QnM6mDAkUr
 D0WwQ4VDD18dCvieSlvd7+Dzk+YmhLlkOyH+xNAjcrLLp+G/fD9euOuDjXiZ7FYRhnVQ
 TMPbs0vxtXgaiCbNXplGYTMl0RigAaPa7Kh0FDUMatzSqfk1Vqxkuq7ZmO/nDFqU5PP+
 pfjJGpZ35wol8lMxfH1dzXCONlauSKFXzFyWOm4KZxbbd39/PWkmGfXAmsmMITMw5kf1
 Sosg==
X-Gm-Message-State: AOJu0Yx0t6C6xjevVCuS0g4kB7z3rKOjA0xuaAyTJG0iClRf1GHI2/eZ
 FsBLu78GX+FHWtQeG+I3vQOB/6YZAp2bJ5fGqIdjWWUNpFekscN0E0uj5onyaSAo/famkvvTOk+
 Xb8Wg
X-Gm-Gg: ASbGncvYR7Jq+cVPPYlj8q7twY/awncuuYy1XloPmwT6sZ7tUUCdaUhqETCCA2fn1Xz
 ERWYxgvspr6vCftLISTmuOwU/wDDaJg9uAscNd5VdJJTcrYVhkUxVYojxCKNkrizHq4APEvOful
 ujpB+aiElfnCTFU1Xo4YZuV9hiz8+mR83vptXcC2MWzy3/bEQ7m3/hOjKjPyVSavoczeqb/N7zA
 bpltIJcVgpC5MqMiwEPhXrt7+Y+X0Sqd1snKeZGJtzgkr03WaD846Z459yUjtJDxeel4O2sIlFp
 xT2CS9FCAmHU3tQG9sr/ARiYRrRNbKcmmnk56lyOJpxQfYPEgZBOp4x/6UeX1hCZDpeO4V6aOcn
 BFK/rQxgT1SpNuK0pT38/IM5/nbxnBOHfEVaegs1WO/zC+AmH8Mtf3df6KC0xeVsZy/0lzUL0tl
 rH5KtCaHk=
X-Google-Smtp-Source: AGHT+IEUkykPq/kD2hU8fm8Vw1zKCOdqAhoEdtHwNR47HGr+RpCCQKE3GshWEA2TmDeubfzt/Dg4Ww==
X-Received: by 2002:a05:600c:4f46:b0:477:fcb:226b with SMTP id
 5b1f17b1804b1-47904ac44c0mr182429975e9.2.1764362857521; 
 Fri, 28 Nov 2025 12:47:37 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-479052ec685sm98571015e9.6.2025.11.28.12.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 12:47:36 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 21:46:32 +0100
Subject: [PATCH v2 2/7] configs: am335x_evm_defconfig: Enable panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-am33-evm-oftree-v2026-01-v2-2-42a863304498@baylibre.com>
References: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
In-Reply-To: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=msp@baylibre.com;
 h=from:subject:message-id; bh=/cVXpbo9y1WYsRjaoC53RzA1V/D67hjkcX/2Iz6Vdi4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwtLsvHNX9ESlWlrA8tCLnwms//Uu3p1aqNmQpalrq9W
 f/O2cZ3lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwET6mRj+x9RHbOQxjWgQYg0+
 ssVGd9sTm7BTU2N6ctk2VkYz15Q+Z/grvbzQZE3hYp+5t/V84z40hnfNMo3uVf00N43xjvODrFl
 cAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 23:32:55 +0100
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

