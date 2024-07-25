Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5CBC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9106885C5;
	Thu, 25 Jul 2024 22:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aqPF2H4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14EA888548; Thu, 25 Jul 2024 22:45:38 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5FDB88599
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d92e1bc90dso112946b6e.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940332; x=1722545132; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7O+j1XkcM7xvkRySBd00VSnTG+7noLEDlPYfT97OsBI=;
 b=aqPF2H4fI67GF9IYDZX2EdJRh/4TecHkdlIsOEAAVKwVMCTKUJSsLj7WVlK+Dc08mF
 iZXSKUCfsMkfAbcQFpjQ4bu+px2h+TMBEs6HAN7euziuao1/E3M223pe1LKgRqlUm54E
 g900X1nFgHFDAYxiJHFp+vARWTLo05wWdNsygCXIvnd1u/8U9Swx4RYd4TK+GIYmjh7s
 u/yDcEJi5CETd+afpp0j6k+S5jHIkgcNSVK0tTUjPrch2VpRmHKZUAfZpkUzFKVQ58k8
 7gH/PDDwnmFx1t6YywOZt7YCuBa4YVFgY+bRmdVXFvB+cuSv7JjNYeT23q3mr6SnliyU
 4hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940332; x=1722545132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7O+j1XkcM7xvkRySBd00VSnTG+7noLEDlPYfT97OsBI=;
 b=iEZwqQ9exbQmgJAw7w9eEp1JOtDiIJfmkw7JHxQ+UyqsDSNUbiHjaq7oLfYirTD/Ad
 iCxVfDQqo3UC251P4IXO/p61rBaMIB2wiYEja79QZpv5uQFbZ8r+IKhS/geLyqNGvzLo
 jc4/zGjAdOCZAod26vhZkCWJ00YiICp7a5j06Jxi9vmPccI1XSA8j2JKE9Sj9frVdVV0
 Kxl/yQYsEoY109tvPy0ymDy8/Ix6qSJzGiFMrIuqbz2i+IYiC997ihtFEgQdyKEn2oC2
 bEzUH7JXZzvchgOV76X1XUMg2W6HThTEHW0PQdMSxQCdRPB97S6iRZn3CvYDpYE0Hshc
 Hi8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLu/8Y5liEiECOF3RTmKVG5bmiKG++hIHr7/DjK4//RISgf4Rcf+XqrIkO/fERZdmxVDnuPitUlBhvIE5G5t0gj1SDhQ==
X-Gm-Message-State: AOJu0YxhSBxYt8MGPIYiq5EWb1qWealWdgaiB6pNRUKek9n5jQQd4qrm
 zh3ml8SlRaIOvSS8ktrhFPBP8A+QYUTOtWdefitSR8ERgVMUcJdondvWX3nSfEE=
X-Google-Smtp-Source: AGHT+IEzmqL+aXj9//U1kpL53B++QJ9fKSHfMImKKCzqz8wWweFwKCpkIkf7wWv1PAX1+SVAkuNw6Q==
X-Received: by 2002:a05:6808:2012:b0:3d9:4221:606b with SMTP id
 5614622812f47-3db10c2fa4amr1461521b6e.8.1721940332421; 
 Thu, 25 Jul 2024 13:45:32 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db13520c1esm436442b6e.40.2024.07.25.13.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:32 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 15/38] dt-bindings: exynos: Update bindings doc for DW MMC
 controller
Date: Thu, 25 Jul 2024 15:44:57 -0500
Message-Id: <20240725204520.18134-16-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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
Changes in v4:
  - (none)

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

