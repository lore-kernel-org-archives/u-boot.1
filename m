Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D0DECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 13:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC2C888AB1;
	Tue, 10 Sep 2024 15:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VsrVlvDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E83890BA; Tue, 10 Sep 2024 15:00:52 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8283089095
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 15:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-374c5bab490so4095754f8f.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 06:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725973237; x=1726578037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MMCDhM+5DD36kuyXbPu5LxxEdrjEBYnfDavT8Nq2IbY=;
 b=VsrVlvDO0GI58bxo2NRXRCnEaw3yEuO95mOe7lIB9/+TlFcRbN0NyGhzCbCk57IMak
 /I4ZaGVVRfA68Yiyrlw1kZIKsxcAmlwJOnXaHWj6hup5zSeamJxTfWFAJrpwsM3eFPVs
 O0dfF9yIww0WvhDgapTifurdeKY77T720eR5xrnRIk95FF9YYlGpJYAUiY/j8H5vXdPG
 Icidb3F4iKr4g/hV9tyCsQfoyr8RFjKYjCm1iioUMcJnmyxRAB6B/h629OVTBfHJebmx
 oT3vW0OeGHrVoSUrBqNnoyXV/H333DlAdPZcNWfCwx4VeEGHG4lT/WfetwvSpfkjq+Jt
 ASog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725973237; x=1726578037;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MMCDhM+5DD36kuyXbPu5LxxEdrjEBYnfDavT8Nq2IbY=;
 b=lFj9tMU6HlE47WC1IFgoud01O2GZRYWVRfpiBgCGqA66j9uNPAaJXImjg2EU0NQILU
 bqq1z/GORdzHvv7Q1Z+m6/20twZTTscUeoI2GJUIktNTx0mtb3aK0iOQFaiHTlNKdmPl
 3ungUnSQgesSGFNQjp1wBIb0UVLXhqvhmbMeG4C1aVJqPkAXIQHLgqJrnvsPyRMWyR0+
 CBge48Rt49ZuZsYytP+dK/wTpLeAlvOveQ1NcvwFedcOTKJF9ZFti2seaihYKR4T5In7
 raT8R3Q9SigDMldZznXgpNeHSRShMDzHwcIsXfYprfp4nZeL8Fx5hCXy5Sh+m/hpkzqr
 sDJw==
X-Gm-Message-State: AOJu0Yy8u86F4rqjZ2n6hatQg7Ma116kcBgLD/Bi4mW0KP96yL3neoSu
 tEuyVHoYyKgybxh4CczojgwbzzwOqlly+g7ODeEwj/q9RH0YMjf2b1fabrgtfiOBCrhZ2HhB04J
 9HYpnIw==
X-Google-Smtp-Source: AGHT+IFFN5hUNUAQbi/ImsiqO3BE99gMlewLY48f5r3EOJowve5jfxE6tl8BaEiQH3tRt8fUAmwVcw==
X-Received: by 2002:a5d:5d82:0:b0:374:c2a3:63cb with SMTP id
 ffacd0b85a97d-378a89695cemr1742105f8f.0.1725973236759; 
 Tue, 10 Sep 2024 06:00:36 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d022:7718:6b27:6851])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956654ffsm8894905f8f.40.2024.09.10.06.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 06:00:36 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Lukas Funke <lukas.funke@weidmueller.com>, Jonas Karlman <jonas@kwiboo.se>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2] spl: ram: hide SPL_RAM_SUPPORT
Date: Tue, 10 Sep 2024 15:00:18 +0200
Message-Id: <20240910130019.3211647-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Make SPL_RAM_SUPPORT a hidden Kconfig symbol, automatically selected
by SPL_RAM_DEVICE or SPL_DFU. Avoids the situation where SPL_RAM_SUPPORT
may be enabled without the other two being enabled, which results in the
following build warning:

common/spl/spl_ram.c:19:14: warning: ‘spl_ram_load_read’ defined but not used [-Wunused-function]
   19 | static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
      |              ^~~~~~~~~~~~~~~~~

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 common/spl/Kconfig         | 8 ++------
 drivers/usb/gadget/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index c08ff064493..885a012461c 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1238,15 +1238,11 @@ config SPL_POWER_DOMAIN
 	  the drivers in drivers/power/domain as part of a SPL build.
 
 config SPL_RAM_SUPPORT
-	bool "Support booting from RAM"
-	default y if MICROBLAZE || ARCH_SOCFPGA || ARCH_TEGRA || ARCH_ZYNQ
-	help
-	  Enable booting of an image in RAM. The image can be preloaded or
-	  it can be loaded by SPL directly into RAM (e.g. using USB).
+	bool
 
 config SPL_RAM_DEVICE
 	bool "Support booting from preloaded image in RAM"
-	depends on SPL_RAM_SUPPORT
+	select SPL_RAM_SUPPORT
 	default y if MICROBLAZE || ARCH_SOCFPGA || ARCH_TEGRA || ARCH_ZYNQ
 	help
 	  Enable booting of an image already loaded in RAM. The image has to
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 4621a6fd5e6..b1247a9eeae 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -323,7 +323,7 @@ config SPL_DFU
 	bool "Support DFU (Device Firmware Upgrade) in SPL"
 	select SPL_HASH
 	select SPL_DFU_NO_RESET
-	depends on SPL_RAM_SUPPORT
+	select SPL_RAM_SUPPORT
 	help
 	  This feature enables the DFU (Device Firmware Upgrade) in SPL with
 	  RAM memory device support. The ROM code will load and execute
-- 
2.40.1

