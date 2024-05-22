Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516ADC25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8280588599;
	Thu, 23 May 2024 01:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BOxsNg90";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE9C6884ED; Thu, 23 May 2024 01:31:56 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AA418850C
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-23ee34c33ceso2666677fac.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420710; x=1717025510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PyC3TThwDEvlFX+fzX3KvxCX5ai2mCtFlnk+pqE4F8=;
 b=BOxsNg90CNyNZ/7MVgSBSxVtE0amXFszaoAAuZ1In7l46aHnw+KPdSq8b/RQA9ISjF
 /lvAFqMeJBGvvuujs9IS4kPKBE9Oolztm4tHRTLs/cXhjTCNfbGiWOw55OxcbLlznu9/
 ADLr0KV2qsCPkttOcOJUQUrepFQ1gP9JEaBO+my9hVM3TROUuNSGuSmK9zkSZwoG4Neh
 w9fSRUp0m7jy2H2h6fYwa2LxrQvDgQIK6dpSjw9eoXLc6qcH3FabfYeevdGCgxbxKt+1
 yk5ELhMqOK1G21j+k2Jzqr36gcy0SjVrJXxH3q49n1kyanDpSZ30hUV/ZinOFfe2adAl
 tUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420710; x=1717025510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PyC3TThwDEvlFX+fzX3KvxCX5ai2mCtFlnk+pqE4F8=;
 b=pHByCxKg3Np9739Hux7FA8l/EbWF68jd36Z4efNThZNJv2EAWiFN8HPA2Y13E2Mmj/
 ToTE+J6XSSZoupSPwXveo393/OayQnduvYkIeAnPkyGcJLJAu3TMLSLL3sb5Kl26yJia
 GnmqvaFQSPu+bIqbruIuxizp7XrXb3TGfQF2xtkVpeh7mptdBqZKULMTURO3Mvzvm01E
 aqOYzodHHq+I9Mo2uo20F3HQ69ZKh78iFntjuWq97OaiNvZSsGqEnnAEcfE8r00JaQ1O
 8N2S7vzAUxe+Qz4U96cLwBMguGBjk5GKM9zPXB98hpqgSvP1OLMzThnVmI/sdrbgh4Bw
 40bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf6tBaYoDdtFr1AnrCrOOt+isYl+8ckp93npLxlqQvgC3478e3JI0bPE1ONWAhb56ADEs1uYyt35NoaoqqRjDLhfPMIw==
X-Gm-Message-State: AOJu0YxR2Op44ZFnt363V+/b1jTmV+RHyWBqkrVcNGqX8pQr1EFxVlio
 +v4kGHj5O+vmIa34kVdTEGLBx5RfwVHgNN++xWYXc4SC7EQmySxnb5cUnJIRYs8=
X-Google-Smtp-Source: AGHT+IGXROLv8aWipfPFykRWZ8yAQkt4d5+GyNz8R5aM5QpvLsKM9wUV7rweQkXoBnnSdctuimq5AQ==
X-Received: by 2002:a05:6870:e243:b0:24c:5094:fb92 with SMTP id
 586e51a60fabf-24c68b3de16mr3776351fac.35.1716420710246; 
 Wed, 22 May 2024 16:31:50 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-244c1d52d8bsm5482352fac.4.2024.05.22.16.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:49 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 17/42] dt-bindings: exynos: Update bindings doc for DW MMC
 controller
Date: Wed, 22 May 2024 18:31:10 -0500
Message-Id: <20240522233135.26835-18-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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

