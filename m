Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F353FD2D63
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 12:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C390F83F2A;
	Tue, 10 Mar 2026 13:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vq/lv11H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDD5B83FA4; Tue, 10 Mar 2026 13:00:35 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1FC183981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 13:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ozndrgt@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so25519425e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773144033; x=1773748833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TYUAuBOXB4c0EgwHSfd95iL1jUNXkcg/OkGWp2ZVad8=;
 b=Vq/lv11HtKjpA/Cq9DXuGsJwSRRjaXSoXyH9MJv0d77vRUMoaYDHBqFdrG+M8DWZSR
 EdrHf7iuRQPzhPsm1vzRl2/x78W7tN9IUmFVa052zI/zoduE77+JRSU2GdmIwluHl5g2
 PxVFXqn+W8BaTNBa3hJW/yEOs8VDjNW7B+W9jxUOKNpuefAzSKfQSp9hAxo+UV8GxnED
 sq1ocvVFBnT5jI5B4pMDMWKXOEO/ywfGEQa2djYlNQ64qye7J4P5DArTK0tVv1IBUYmu
 njFCmFpgIeLW0MHK6u5QSfTTQ1p2zrMJUyCOlSDlb8FEYZazlsQI6cHHBhM/EPCX6eRF
 MhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773144033; x=1773748833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYUAuBOXB4c0EgwHSfd95iL1jUNXkcg/OkGWp2ZVad8=;
 b=CxpRO5l/A8E71pLdCbrPzHyR/PCVSQqckqt4bfpprlRDQ336wwTreAsfFCq8ZECSps
 3UE2zwvt/Ul61d9uNEPhvkPSs84a6HRzOX8Eqk+y/owe+ydqfPfvypaDebR7ZJukm6i4
 +lP+C9xaP+tjVbqVaa6V3kxchJBVxZTArqNAeBwrttJ9BfG4P/xEzoiUWh7A2PtrA5x4
 mMID8OCCw6r9GLiAwN8akhACe7tmqjfxDrtXUfzthMcTxdWkMvMF8GoK4ofTIUhMxtLK
 o7Ey/FqX51c1QFrgNO9ZWyuZmgybBOyDGVr8PcP7hoI1LzCMQ5nkQ41WEHr0djTNrDis
 SinQ==
X-Gm-Message-State: AOJu0YxGnUrvLYUq9BP0Sobtd/qFXeCuvOFxyCnR4+ubzxoZ7gSYLHz5
 rAoOqlDVQt5yRhxbVnjrWhTn9yLZpTLpnIQOUK5WhL5z/+3KFUUzr013HICT0A==
X-Gm-Gg: ATEYQzyH3cYUKK7KpLSU8JgisfaNdaqjSw8+zbso3Zwhgh3kt0b3qv8pvHhP88+cTsA
 7o6jgRlEm+2U4bUzVZKDtIfrGr7BYEIPcGId+hZ7wVISSeLEPt7s4yCfSDoU7x+7K87PH79UDyS
 aMEkvsLRNY7iyCdkbBKqY5x3LMR2SE2ZTXaiSgklkvNwy/rb8hfZi+h+vdzY4ky8PT/81arxKys
 zwtyx7ddbqbwSuIbINvFnW/p51kIGxPKJcrdoi0RCzpfxQCmAGwQdmLWu2Hs0CR82n4En3jRWtf
 BAQjf07naVIqKGFKWHDYpkeWG1lkdmcEXkb+MUfXcDDrSdv52t0AQgczVn8bgTu7T/IDsjbr2Ae
 cgwYpmXgixFQTC8LxAzOB4JqT72oBmZxEujgIS6JPay6ZtprGICdIizKvch0NuuQbwIB+wYKQLg
 29jNTyB53gw9KPU+Q7C81uzWcJxgk=
X-Received: by 2002:a05:600c:3e87:b0:485:3e00:9440 with SMTP id
 5b1f17b1804b1-4853e0094acmr88836125e9.24.1773144032567; 
 Tue, 10 Mar 2026 05:00:32 -0700 (PDT)
Received: from Precision-5570.. ([2a00:20:c34e:e3ff:5ffd:3033:12d3:8e4b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48535c7fb8asm67099265e9.3.2026.03.10.05.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 05:00:31 -0700 (PDT)
From: ozndrgt@gmail.com
To: u-boot@lists.denx.de
Cc: linux@analog.com, Ozan Durgut <ozndrgt@gmail.com>,
 Ozan Durgut <ozan.durgut@analog.com>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Philip Molloy <philip.molloy@analog.com>
Subject: [PATCH] configs: adi: sc5xx: sync command configuration
Date: Tue, 10 Mar 2026 12:59:26 +0100
Message-ID: <20260310115938.2902653-1-ozndrgt@gmail.com>
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

From: Ozan Durgut <ozndrgt@gmail.com>

Sync the command configuration across ADI SC5xx defconfigs by
enabling commands that were missing on some boards.

Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 configs/sc573-ezkit_defconfig          | 3 +++
 configs/sc584-ezkit_defconfig          | 3 +++
 configs/sc589-ezkit_defconfig          | 3 +++
 configs/sc589-mini_defconfig           | 3 +++
 configs/sc594-som-ezkit-spl_defconfig  | 3 +++
 configs/sc594-som-ezlite-spl_defconfig | 3 +++
 configs/sc598-som-ezlite-spl_defconfig | 3 +++
 7 files changed, 21 insertions(+)

diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfig
index 1d2112c3f52..fc4ce13cc70 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezkit_defconfig
@@ -31,8 +31,10 @@ CONFIG_CMD_BOOTZ=y
 # CONFIG_CMD_ELF is not set
 CONFIG_CMD_DM=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 # CONFIG_CMD_PINMUX is not set
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -42,6 +44,7 @@ CONFIG_CMD_DNS=y
 CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
 CONFIG_CMD_PING=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index b7116bb5c8f..a8c6b9f1224 100644
--- a/configs/sc584-ezkit_defconfig
+++ b/configs/sc584-ezkit_defconfig
@@ -37,7 +37,9 @@ CONFIG_CMD_BOOTZ=y
 # CONFIG_CMD_ELF is not set
 CONFIG_CMD_DM=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_MTD=y
 # CONFIG_CMD_PINMUX is not set
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -47,6 +49,7 @@ CONFIG_CMD_DNS=y
 CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
 CONFIG_CMD_PING=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index 74305765ed5..9cd204e40ab 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -40,8 +40,10 @@ CONFIG_CMD_BOOTZ=y
 # CONFIG_CMD_ELF is not set
 CONFIG_CMD_DM=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 # CONFIG_CMD_PINMUX is not set
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -51,6 +53,7 @@ CONFIG_CMD_DNS=y
 CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
 CONFIG_CMD_PING=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 1141237d58b..0908ab1708b 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -37,8 +37,10 @@ CONFIG_CMD_BOOTZ=y
 # CONFIG_CMD_ELF is not set
 CONFIG_CMD_DM=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 # CONFIG_CMD_PINMUX is not set
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -48,6 +50,7 @@ CONFIG_CMD_DNS=y
 CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
 CONFIG_CMD_PING=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index a9f06d603f8..c62097a2ac9 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -25,6 +25,8 @@ CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_DM=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MTD=y
 # CONFIG_CMD_PINMUX is not set
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -33,6 +35,7 @@ CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
 CONFIG_CMD_PING=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_EMBED=y
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 58392dc0ac5..39481351102 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -29,6 +29,8 @@ CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_DM=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MTD=y
 # CONFIG_CMD_PINMUX is not set
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -37,6 +39,7 @@ CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
 CONFIG_CMD_PING=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 # CONFIG_DOS_PARTITION is not set
diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
index 739a774a918..34dbedf12b4 100644
--- a/configs/sc598-som-ezlite-spl_defconfig
+++ b/configs/sc598-som-ezlite-spl_defconfig
@@ -43,7 +43,9 @@ CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_CMD_DM=y
+CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 # CONFIG_CMD_PINMUX is not set
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_SPI=y
@@ -55,6 +57,7 @@ CONFIG_CMD_DNS=y
 CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
 CONFIG_CMD_PING=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_EMBED=y
-- 
2.43.0

