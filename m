Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DCDC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF3388481;
	Mon, 10 Jun 2024 03:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h4VMqbOI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78DEE884B8; Mon, 10 Jun 2024 03:12:42 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E422884C9
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-254764f5472so1224355fac.1
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981958; x=1718586758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PyC3TThwDEvlFX+fzX3KvxCX5ai2mCtFlnk+pqE4F8=;
 b=h4VMqbOITZQeIE3CZ9f9z22NTIR67e+gFjp/UynKtOXxrPk22LflfdrFeOgjiRA07g
 dARKEiDGiCXa+dyfBHVrxtPo8BJNq37cXw/zIGEVE61iX0CHRB+ItCjUjoiO9gH5spfX
 YMG7km3lZaD5KQPtLYKNCGDqFtVU8Mm3GjAPKcJo8dQ7306zG1pPbKmHl472S/PzDCqv
 QZTsU7I1/i9kE1x/Yxlt33baWkU85NrCRixDgQ54HjnCWJMN5OfRF5cq4iLszoVNiiiF
 2Zzi6aweCQ7LTlF8Xs8fsBhTkcdz43bi57tqNZQIQc6Lc6tAu6XwXsbOQk9i1neUdi7m
 ucyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981958; x=1718586758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PyC3TThwDEvlFX+fzX3KvxCX5ai2mCtFlnk+pqE4F8=;
 b=DjwthnyIWNhP3pctbpu1ugGFmOZh/4GTOoNqFIDNq+v03BV61BF6b/Q4uVub/LPRy8
 VGJrz61zCoLuXFDt3LDSI7W4E8theVQ8kgHjanrDrUJ8NeyDinzpCBIWz5D8X0D+Macj
 St3ssTExIJ8jhjejPoxFZaaDwS8JK2nIIiBKrZhKQgRXRqwjUxcOEcKkN+QugMgc/0mz
 3mgKL/1knL9aWxuXGqfFz7nd0xNKGy4jMBB8pieojKeVuwiccJQbCc4GNo2EzM+uXQO7
 iKGYvfsAzRdnTzDeueUDyyhGLHBiSHAN3OKLYz79EMoIQYKk8F45cDPxjHyhG1tEoND5
 3GKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCx0ioK4YbggQkK31wIIyAxNCeSY90rG5Ow1k3uifiJvtQHoPGYTjDH/1f4CaMtd8Hwxw3d1ZH/tgVsJOpJ94oiAjuxw==
X-Gm-Message-State: AOJu0YwsLmV4QJZ57n3pi1XIEuT2Bt1+Nm8U9XU6T8Kdt0S2nmipi8Z3
 JB/T0eEp6RuOgPF+Dt/qvMejihJ+cRLAP351Ld6tYe4J3ClcauAQ1A4lDg6OiZg=
X-Google-Smtp-Source: AGHT+IH2ju/TrMbrvqnejLoi13Utp05U7VOClpaHYMO/r4FjdI1jWm9VnJ++4iVlCQkRtFAiJ4lW0w==
X-Received: by 2002:a05:6870:c6a8:b0:254:a613:1907 with SMTP id
 586e51a60fabf-254a613270fmr4493897fac.56.1717981958275; 
 Sun, 09 Jun 2024 18:12:38 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254480c17b3sm2038282fac.51.2024.06.09.18.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:38 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 16/40] dt-bindings: exynos: Update bindings doc for DW MMC
 controller
Date: Sun,  9 Jun 2024 20:12:02 -0500
Message-Id: <20240610011226.4050-17-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

