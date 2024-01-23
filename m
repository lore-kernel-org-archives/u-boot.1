Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B73C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 16:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9984E87561;
	Tue, 23 Jan 2024 17:18:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BeJedVI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FEC987CA1; Tue, 23 Jan 2024 17:18:33 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 458A480785
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 17:18:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2252540736
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706026708;
 bh=VS1+8mvDR3mIX+d1++nl7o5/XzOwDvrDD34cmgl0sz0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=BeJedVI0MzkZgLoWOQiB7QpVPkN2iMdjsur0yZ+bDY4v5cAC228JsW4/IlnxEH4Kg
 9G5oxB9D7XiiqS6Gl7rEQvKyxRA/13RmtW03PisoP4QMA6JqSdpUB/z4TiBxHO0peL
 n1zIUt3VsGcXij27I0cry3RaPSyxFRxsgj0E7ReNxkcdehuciCfcuMo/pNEDWS5Ad7
 iQmkC5jGN8gP0GkXvUn9tyN9C8DHlWeiZHoSbGtL2GRNfXLGjpo5hU2yZSNVw65GGL
 AkV3n5Yd21R/tzzx9ylNCuS67wtMwd6HvJK/SL3nlU9sjMmyOaDrWBUkyFd0R6udJ2
 5WmYRQv0Cy8qg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e5769e2deso42222065e9.2
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 08:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706026705; x=1706631505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VS1+8mvDR3mIX+d1++nl7o5/XzOwDvrDD34cmgl0sz0=;
 b=w33ZGormBYWzJVgdpNCI1oSN4E1y6GnwzD6PmtAGS1u+QmVl6GP3lDF70tUTh4nphi
 SUa7ZhQMqiU/rgkCwEGmyNPoeUvmhyN17uPuciPgZddlauZpaDqWSBY791udawrOGY/W
 w+cHd4+L0AwMgb0UtNbMaUpxQe2empbUqUI61aFd0Qc9Y/5LNmN2ajCl2ptrJxylPre0
 ihBtuCkhRpdw6xnYrZ4Bfk/IS4ffOM194NPTov7yMlhfcBW3SGEY/a+ME1mLEacRoa2E
 URh2Y2RDAAsfVsLdKiVUPsYyH6x5uxbmZlQUDVdtGQ8bdD2OkOWgDV73iODvyehviw/P
 hTzw==
X-Gm-Message-State: AOJu0YzxqUhIZjveZD4YGyk6I5dn+CAoyYgW+3xrk9+spMduezW0OlUT
 dJqB52p6Bc/PKc2FEbOvjKDN0P8ic219scHn+/9CqkOhQGo8Ggs/CLXfOiYinc9hNGOrXCjqFcq
 8c2+Pqg3UW7eMEYaW7t0/HtlEQk/W2FC8lVXa6R4RvK+MaNdurYzoxtLLEalXdWdsK6o=
X-Received: by 2002:a05:600c:198f:b0:40e:ad0d:75 with SMTP id
 t15-20020a05600c198f00b0040ead0d0075mr199772wmq.132.1706026705265; 
 Tue, 23 Jan 2024 08:18:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1cRn5S+VG4lr17AshMzTWXM+4aoZ+1DW7Kvtj++mNSZblIxNO3k9J2peAu1InZGwARFjOPQ==
X-Received: by 2002:a05:600c:198f:b0:40e:ad0d:75 with SMTP id
 t15-20020a05600c198f00b0040ead0d0075mr199766wmq.132.1706026704859; 
 Tue, 23 Jan 2024 08:18:24 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a05600c469000b0040e39cbf2a4sm47321743wmo.42.2024.01.23.08.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 08:18:24 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Patrice Chotard <patrice.chotard@st.com>,
 Arun Parameswaran <arun.parameswaran@broadcom.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] mmc: Don't suggest to build modules in Kconfig.
Date: Tue, 23 Jan 2024 17:18:16 +0100
Message-ID: <20240123161816.108839-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

U-Boot does not support building kernel modules.

Fixes: 3c0dbed232bd ("mmc: arm_pl180_mmci: adapt driver to DM usage")
Fixes: 36645f45a048 ("drivers: mmc: Add sdhci driver for Broadcom iProc platform")
Fixes: dadd43c14368 ("mmc: synquacer: Add SynQuacer F_SDH30 SDHCI driver")
Fixes: b312c590bcd8 ("mmc: Add MMC support for stm32h7 Socs")
Fixes: d24b69395949 ("mmc: mtk-sd: add SD/MMC host controller driver for MT7623 SoC")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/mmc/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index ffde442cb29..9ce331677b8 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -83,7 +83,7 @@ config ARM_PL180_MMCI
 	  This selects the ARM(R) AMBA(R) PrimeCell Multimedia Card
 	  Interface (PL180, PL181 and compatible) support.
 	  If you have an ARM(R) platform with a Multimedia Card slot,
-	  say Y or M here.
+	  say Y here.
 
 config MMC_QUIRKS
 	bool "Enable quirks"
@@ -592,7 +592,7 @@ config MMC_SDHCI_IPROC
 	  This selects the iProc SD/MMC controller.
 
 	  If you have a Broadcom IPROC platform with SD or MMC devices,
-	  say Y or M here.
+	  say Y here.
 
 	  If unsure, say N.
 
@@ -603,7 +603,7 @@ config MMC_SDHCI_F_SDH30
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  Needed by some Fujitsu/Socionext SoC for MMC / SD / SDIO support.
-	  If you have a controller with this interface, say Y or M here.
+	  If you have a controller with this interface, say Y here.
 	  If unsure, say N.
 
 config MMC_SDHCI_KONA
@@ -797,7 +797,7 @@ config STM32_SDMMC2
 	help
 	  This selects support for the SD/MMC controller on STM32H7 SoCs.
 	  If you have a board based on such a SoC and with a SD/MMC slot,
-	  say Y or M here.
+	  say Y here.
 
 config FTSDC010
 	bool "Ftsdc010 SD/MMC controller Support"
@@ -817,7 +817,7 @@ config MMC_MTK
 	depends on OF_CONTROL
 	help
 	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
-	  If you have a machine with a integrated SD/MMC card reader, say Y or M here.
+	  If you have a machine with a integrated SD/MMC card reader, say Y here.
 	  This is needed if support for any SD/SDIO/MMC devices is required.
 	  If unsure, say N.
 
-- 
2.43.0

