Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5F3C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8555688B57;
	Thu,  8 Aug 2024 05:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cjiJfipj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE5388AE3; Thu,  8 Aug 2024 05:14:59 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 545E588A34
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5d608060241so294618eaf.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086896; x=1723691696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cUfHwk0Yus8LngelZKE317fNTQM+N79ervvdou1M48=;
 b=cjiJfipjmiiu4D6+OsUztiWlzynDctYOJG9hz5lIK0LaAtqv+2GTybftbycvWYsJwm
 wMYpAylw/RVpxPCJyFpCo3N9QxXp7gSwyyPx96R8wDLMowme6vumQ/Cq57MoLtMbUGR/
 tP3vOZZrj4FL1rwby/5MClyhBpECjRJQKruceu5SYSav3DxKHzc6i7mVez87+gTYFrBw
 T3xksoONqfeIx6ioQe3yWB49qdwgrYwH+NfPtFfopWinkm1eoNePSA/dF2n9zs9wisQt
 30oFxTx5Or6tkrKVAKA1KewGAIZGZxsIZOsAe1AYWlmWJnMhUe2TMKwmiuXFwJlxPziw
 Bv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086896; x=1723691696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6cUfHwk0Yus8LngelZKE317fNTQM+N79ervvdou1M48=;
 b=TcNLGanPYiGQxu3mY3m8ZwvyoTaVIKURh+MmkDYVccFFEQuJ9rGOd/7x47B9X33JHN
 Z7mPhVoEw8g0SO3cJeL4BPU0b5b8itjEUxt9jeSCnDrXjXizW28ytDSLDiBT8jCfXDdu
 FtFZfxENdk1vSIOq3BUwEwTT3UHnvTMnSRKE+nTyTrjWoy1nW2dVf0iCd8okrGX9ep+q
 rJC0EfJGRY6LxDYEmV7ZN9z+blVzmFGmsy/O6ctgBy3cVtaANO/cV2+nBdTbMWfZ7yMe
 hgI0syxXKXt/vMTL6dSLvJwwFMjEi0f5WaRiW2d3/5MP4lY+DzqvbTZ/U34mRqGZyidw
 Wadg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX00c7/Ejz1iT10LfE24x0oOOq8udAU1P8/2oqiw4tLIfwmhZuID6Mr/pF7+eCb72L80zyMOGusHrQ0O5dBFKYh4AkfNw==
X-Gm-Message-State: AOJu0YwKz/TVxFibRcX7msguV26OMIEiwRFTrhCjPLpvrRW6zgikE8m7
 /ePtOg47VyeXOiKPFgtXimPkYE/7yiUouH8kOJu68PlRjULUgrr5uB/+35WDLmY=
X-Google-Smtp-Source: AGHT+IGe2a4dQXMQSlqcmJPrG0N3rq/P00HxS6KlZwn1jhcVvRue/5UnRmdCpl36YDazyoci1crILw==
X-Received: by 2002:a05:6820:4b0b:b0:5c6:61b9:20ba with SMTP id
 006d021491bc7-5d855a51016mr881507eaf.1.1723086896050; 
 Wed, 07 Aug 2024 20:14:56 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d757179759sm3497983eaf.8.2024.08.07.20.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:55 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 15/38] dt-bindings: exynos: Update bindings doc for DW MMC
 controller
Date: Wed,  7 Aug 2024 22:14:21 -0500
Message-Id: <20240808031444.9619-16-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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
Changes in v5:
  - (none)

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

