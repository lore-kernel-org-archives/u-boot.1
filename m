Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14EBD3C92A
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 21:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34C1F88EAE;
	Sun, 20 Oct 2024 23:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729458092;
	bh=eSzUDOAICrQPtXgR7fHD9c6AmGx+Uu+asyraLv2f/gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZeVMuzps8WDPjHe1pOGUIkxlo23Nd+fXc+eyKWNztL3eeyppkIoCwb3obER1B75CP
	 3apkUv/cKGT0fkwjN0q54n4LKyaMBUqif/U88PvG9Hz5LvumHBWsz1g/l6fN7Qq7c7
	 kmC+5QSDWi8tIOGNU7M/0z/YrOw/Xzn5tUwyXXVtXYSQkMKSRD5H9/PIJja+u4NzZ+
	 20Mj+8BDuxck+xH3WeOZ/ZpmU5k7W2ZIKmAw+XliwYjg62B8QAtf2S1YllqlVv2JvR
	 NMJ50bvAlsWp2tePpxTFFKsVfqnuWAdHScSGCLWn9h/G88P5JDT4DG5SGpv+cMsnNs
	 Nfk/87h70bQYg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4612E88D4F;
 Sun, 20 Oct 2024 23:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729458088;
 bh=eSzUDOAICrQPtXgR7fHD9c6AmGx+Uu+asyraLv2f/gc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X8QlZieOJsiCbAKIviUSIdAJUsqDRVNK2JlwOf/L6DF3EDBVO/q8uK7zccPGROYoM
 jBoiaVsw1Q+MlsTOGE0ssIffne0VSA9N8Pg1yVs+K9X8BaxLnH047BIxtA6oBji8Cj
 Lwpsiv66rA19YLpdqgfLK7y3dhlRju+28ukRiUB+oS2auBMPWbh2SlGcZUQrdT+z6w
 BqCOumfB0/AV8CIZUN23dkyJUR2gpfNQAykfK6GwirrSB5jjWKi2cBLv0e1qQ6yvFp
 hXdHNJ1Rh8hC5vAnjgbTOHk1f/lGDiB27ESDQyQKcSEIhmG4Culbtu3tUcQD0ahQf/
 WOy6oeWPfvxzA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH v2 2/2] ARM: imx: soc: Move default TEXT_BASE for i.MX7
Date: Sun, 20 Oct 2024 23:00:39 +0200
Message-ID: <20241020210113.1248062-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241020210113.1248062-1-marex@denx.de>
References: <20241020210113.1248062-1-marex@denx.de>
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

Move i.MX7 TEXT_BASE/SPL_TEXT_BASE to Kconfig and common/spl/Kconfig
which is the best practice.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
---
V2: - New patch

Signed-off-by: Marek Vasut <marex@denx.de>
---
 Kconfig                       | 1 +
 arch/arm/mach-imx/mx7/Kconfig | 7 -------
 common/spl/Kconfig            | 1 +
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/Kconfig b/Kconfig
index b1dd4556a4e..a7b2b6db742 100644
--- a/Kconfig
+++ b/Kconfig
@@ -648,6 +648,7 @@ config TEXT_BASE
 	depends on HAVE_TEXT_BASE
 	default 0x0 if POSITION_INDEPENDENT
 	default 0x17800000 if ARCH_MX6
+	default 0x87800000 if ARCH_MX7
 	default 0x80800000 if ARCH_OMAP2PLUS || ARCH_K3
 	default 0x81700000 if MACH_SUNIV
 	default 0x2a000000 if MACH_SUN9I
diff --git a/arch/arm/mach-imx/mx7/Kconfig b/arch/arm/mach-imx/mx7/Kconfig
index 2e68557d6a9..4e0e8ed0582 100644
--- a/arch/arm/mach-imx/mx7/Kconfig
+++ b/arch/arm/mach-imx/mx7/Kconfig
@@ -17,13 +17,6 @@ config MX7D
 	select ROM_UNIFIED_SECTIONS
 	imply CMD_FUSE
 
-config TEXT_BASE
-	default 0x87800000
-
-config SPL_TEXT_BASE
-	depends on SPL
-	default 0x00912000
-
 choice
 	prompt "MX7 board select"
 	optional
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index ed997d82cfc..045fcac10a5 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -272,6 +272,7 @@ config SPL_TEXT_BASE
 	default 0x402F4000 if AM43XX
 	default 0x402F0400 if AM33XX
 	default 0x00908000 if ARCH_MX6
+	default 0x00912000 if ARCH_MX7
 	default 0x40301350 if OMAP54XX
 	default 0x10060 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN9I
 	default 0x20060 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
-- 
2.45.2

