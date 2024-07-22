Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52540C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30DE188676;
	Mon, 22 Jul 2024 19:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yig5oAe0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF8D88639; Mon, 22 Jul 2024 19:57:57 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99819885F5
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2610623f445so2168975fac.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671072; x=1722275872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mzjxmrv1UDG7hsQgrCZmQtSMvml8YYhPjJX68Ztli4Y=;
 b=yig5oAe0zJ0wq5bObMxhWZrth1FpnHdiQSqukSnXDEcSXL6HTWPM6wjfORYPZCiW3/
 17hQxYVrOGYiM4TQEV7WLeiSshWuKKQGw0w1gLSqviG6xSquNlvIw941sUyB+FKKyeWf
 rSCuAHuNs/9u609CsFr52bkD7DxVsXgY3LAmyEfK0oJYLqVR5sVgbnvtUZlUWzBn4esd
 kEMeU4uv3nDPrjNmRBcehRuFBfsxuKBb/x1cBGRt93ZFG5+Ak24VTGDnaxCz+ztrYcvo
 z7/gNGAoJM3J/f0FcuGRzEfGsulmKKZBHPXTNQrzbiphZ+PhCoWbdbUhKyX+EWDADPIc
 SViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671072; x=1722275872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mzjxmrv1UDG7hsQgrCZmQtSMvml8YYhPjJX68Ztli4Y=;
 b=l1mWyIfl4sVWVO7C3BHJzVABtus91qxKb8Jvkcfl9EddlJGyDEQJRczppz5QhwyibG
 foWzhkb6VduiARFpK/0YXpXjHU2SNdSvHdn3IUQqajgeE/KFVe9dO5Hto6cPZaj19PG4
 dPMplyFBP3Tkk9r8ZzRZ0+X+LLwghMY/ThVNan9fqwyB9P9hKIQBk1fXaoBXDOex4ndi
 8k/rPBBadD2j+oY5+6aFr+8FuWemgYoqgpOkr4hUVJgZuP7PvWHHP72ix3v1sYPOU6oT
 LnvmWG45Ps90n5OMeFtrM+vLab9hoGR0e/BzOHs9fW3xXELFh/Iibgl4NzXMH26SXZjB
 fxhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkUFkx3rRWLE1J/y/+ssbnEqa5khGaw8UGlgCB0aGEDx8B+nE/Ls19JKJcAoGQSjZTtTiAaB0aY3TnEDCshvh2fb55VQ==
X-Gm-Message-State: AOJu0YxsMxx/CB1pGKEhd5Yw66tsA4mXGxTOzuybulO6NnowHyg75S6U
 bzzDlh19Lnk7kL2V5jO5B57g2yAD1t6jEj7G8kL/Cx7uRTFKq7627mhOrjOlm2g=
X-Google-Smtp-Source: AGHT+IE2/xY7P8tlDbVXBL5S7sUM27coEkbFGTKsHPe6Lm6oV3kqK2t/1dyvcklsBvHeTrKI9X+iqA==
X-Received: by 2002:a05:6871:2b0d:b0:261:2c4:f7a0 with SMTP id
 586e51a60fabf-261216b4775mr7682047fac.51.1721671072326; 
 Mon, 22 Jul 2024 10:57:52 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2610c7cf1fdsm1771388fac.28.2024.07.22.10.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:52 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 15/38] dt-bindings: exynos: Update bindings doc for DW MMC
 controller
Date: Mon, 22 Jul 2024 12:57:17 -0500
Message-Id: <20240722175740.6985-16-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Update the bindings doc for Exynos DW MMC block to follow the upstream
example and reflect the latest changes made in corresponding Linux
kernel bindings.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 doc/device-tree-bindings/exynos/dwmmc.txt | 46 +++++++++++++----------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/doc/device-tree-bindings/exynos/dwmmc.txt b/doc/device-tree-bindings/exynos/dwmmc.txt
index 694d1959162c..d90792be8599 100644
--- a/doc/device-tree-bindings/exynos/dwmmc.txt
+++ b/doc/device-tree-bindings/exynos/dwmmc.txt
@@ -12,7 +12,9 @@ SOC specific and Board specific properties are channel specific.
 Required SoC Specific Properties:
 
 - compatible: should be
-	- samsung,exynos-dwmmc: for exynos platforms
+	- samsung,exynos4412-dw-mshc: for Exynos4 platforms
+	- samsung,exynos-dwmmc: for Exynos5 platforms
+	- samsung,exynos7-dw-mshc-smu: for Exynos7 platforms (with SMU block)
 
 - reg: physical base address of the controller and length of memory mapped
 	region.
@@ -23,32 +25,38 @@ Required Board Specific Properties:
 
 - #address-cells: should be 1.
 - #size-cells: should be 0.
-- samsung,bus-width: The width of the bus used to interface the devices
+- bus-width: The width of the bus used to interface the devices
 	supported by DWC_mobile_storage (SD-MMC/EMMC/SDIO).
 	. Typically the bus width is 4 or 8.
-- samsung,timing: The timing values to be written into the
-	Drv/sample clock selection register of corresponding channel.
-	. It is comprised of 3 values corresponding to the 3 fileds
-	  'SelClk_sample', 'SelClk_drv' and 'DIVRATIO' of CLKSEL register.
-	. SelClk_sample: Select sample clock among 8 shifted clocks.
-	. SelClk_drv: Select drv clock among 8 shifted clocks.
-	. DIVRATIO: Clock Divide ratio select.
-	. The above 3 values are used by the clock phase shifter.
+- samsung,dw-mshc-ciu-div: The divider value for the card interface unit (ciu)
+	clock (0..7).
+- samsung,dw-mshc-sdr-timing: The timing values for single data rate (SDR) mode
+	operation.
+	. First value is CIU clock phase shift value for TX mode (0..7).
+	. Second value is CIU clock phase shift value for RX mode (0..7).
+- samsung,dw-mshc-ddr-timing: The timing values for double data rate (DDR) mode
+	operation. If missing, values from samsung,dw-mshc-sdr-timing are used.
+	. First value is CIU clock phase shift value for TX mode (0..7).
+	. Second value is CIU clock phase shift value for RX mode (0..7).
 
 Example:
 
 mmc@12200000 {
-	samsung,bus-width = <8>;
-	samsung,timing = <1 3 3>;
-	samsung,removable = <1>;
-}
+	bus-width = <8>;
+	non-removable;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <1 3>;
+	samsung,dw-mshc-ddr-timing = <0 2>;
+};
+
 In the above example,
 	. The bus width is 8
-	. Timing is comprised of 3 values as explained below
+	. Divider value for CLKSEL register is 3. The CIU clock rate will be
+	  calculated as SDCLKIN / (3 + 1).
+	. SDR and DDR timings are comprised of 2 values as explained below
 		1 - SelClk_sample
 		3 - SelClk_drv
-		3 - DIVRATIO
-	. The 'removable' flag indicates whether the the particilar device
+	. The 'non-removable' flag indicates whether the particular device
 	  cannot be removed (always present) or it is a removable device.
-		1 - Indicates that the device is removable.
-		0 - Indicates that the device cannot be removed.
+		Flag is present - Indicates that the device cannot be removed.
+		Flag is not present - Indicates that the device is removable.
-- 
2.39.2

