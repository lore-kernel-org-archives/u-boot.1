Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EF3C83F34
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 01:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B1583523;
	Fri, 18 Jul 2025 03:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qkl+83FX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61C7683526; Fri, 18 Jul 2025 03:14:24 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 263828350A
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 03:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2edec6c5511so758471fac.2
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752801261; x=1753406061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KvyU0AL0wasoqVrqq5U9vxahb5pU6QQ8/R9zjvPIJT0=;
 b=qkl+83FX+l1Na/noeh7cOi0J9eQiUXbOIG5rgwCByWUTkrFQbwPwPl2ED5nz4l1MSn
 uAaNu8Dve1w7yfqHC50xqp30UG21W5H4lhDwcarB2MACrcAhAB8jUngQmRZRST+rUKKQ
 50ifw87XXMs1zaU9O2E1r2G1GiAbJlQxNgdaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752801261; x=1753406061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KvyU0AL0wasoqVrqq5U9vxahb5pU6QQ8/R9zjvPIJT0=;
 b=YPExje50zFppMaAPNoR9Vb+O2Rxkd9EnPbbAS0AfpnPv9CLJhfLL9H4ty5Xo+686t2
 AP1A/VrnaqXXpqrshKgITYPFirG/o6pPTk7G1I+j96rmA3LgC4Q3ClE/+th+zSYUwh3Z
 EadH/aQN+VPgKiQ+kc8gKrOq6O8/nH9I8QXZgNwCW7Ee4DIQVOT9dUC6sYEVGN2dQcpb
 nxndxa4hgksW3BxjAwx5wE+mAW7l4zcRnkNtwieEFruOB08TAaJGSnfid9ZY07JipL8k
 eWitIJ6y+R2LGA5yZzJav2SkmsXvOy2iFdyHcJPSBu+xsqQcUQCxZvQOxhsN71hd2LXM
 8ErA==
X-Gm-Message-State: AOJu0YzDXJ1iVWqV+bPP68eh/2W19EEFvN9I2cUGucLOsFYYspGslVmo
 qj5kTbSkSnfaN868kGvQw2NDBHoNXgy9CHU4v8cJhBaFJnuXq3A3Dl+8GLkN3ycKmdHp/1wsYta
 pn/ABbPU=
X-Gm-Gg: ASbGnctozMsg46zdh8y7x8EMXtGvHP184G+MVARvrDDkI3kPrD4IO3A0KdaQHUZP535
 qHKdUd2rq6T6v6yaaAP7zKGUCcKJOyJixlvV2Ewb8VuMtuLUwJMaEJgilAe+RK/LKdq/QZNuBXC
 2ze01+txAWQdysGCpqs53lYzNX422I642E366sYe72BdzZvXOFNHX53vi98BBoTlHB5RmkhDLx4
 9G+To+WcQhMdvCLtOTwgnIRWxc08L2D5F4U79k2fwCri+FiNCKDZZpN5Al7ggztNa+GK9c+qGG2
 aX5dChPWz5jcO2qo1fr0DoY4Hmm8lB7ta0F+ldDkOinW5iPz1f0vHCj1T/caeQ6QcRfOebOWkAW
 nQilaItfp9k1Y+E/KnNauRgeh4VMv3eYa9ZWgaCDudUhUHPCCKmn367HDgyJsOLSsIGShLg==
X-Google-Smtp-Source: AGHT+IHivoIvn0BU7/ulcDQtXJvGlfYID9fGqLxa/2MgrXs1OzRWLxgrnzuIDn4k0vRBi1V9la0M5Q==
X-Received: by 2002:a05:6871:6017:b0:2e4:c018:e5d7 with SMTP id
 586e51a60fabf-2ffaf22ed2emr6719794fac.3.1752801260730; 
 Thu, 17 Jul 2025 18:14:20 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3010178978csm210495fac.5.2025.07.17.18.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 18:14:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2] clk: Tighten some clock driver dependencies
Date: Thu, 17 Jul 2025 19:14:18 -0600
Message-ID: <20250718011418.1333739-1-trini@konsulko.com>
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

A few clock drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
Also make CLK_CDCE9XX depend on ARCH_OMAP2PLUS rather than make the
driver build for 64bit platforms.

Cc: Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
---
 drivers/clk/Kconfig        | 4 ++--
 drivers/clk/at91/Kconfig   | 2 +-
 drivers/clk/sifive/Kconfig | 2 +-
 drivers/clk/ti/Kconfig     | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index ef1e5355be87..87534bc08ec0 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -131,7 +131,7 @@ config CLK_BOSTON
 
 config CLK_CDCE9XX
 	bool "Enable CDCD9XX clock driver"
-	depends on CLK
+	depends on CLK && ARCH_OMAP2PLUS
 	help
 	   Enable the clock synthesizer driver for CDCE913/925/937/949
 	   series of chips.
@@ -169,7 +169,7 @@ config CLK_K210_SET_RATE
 
 config CLK_MPC83XX
 	bool "Enable MPC83xx clock driver"
-	depends on CLK
+	depends on CLK && MPC83xx
 	help
 	  Support for the clock driver of the MPC83xx series of SoCs.
 
diff --git a/drivers/clk/at91/Kconfig b/drivers/clk/at91/Kconfig
index 4563892647be..faeaa2808b03 100644
--- a/drivers/clk/at91/Kconfig
+++ b/drivers/clk/at91/Kconfig
@@ -1,6 +1,6 @@
 config CLK_AT91
 	bool "AT91 clock drivers"
-	depends on CLK
+	depends on CLK && ARCH_AT91
 	select MISC
 	help
 	  This option is used to enable the AT91 clock driver.
diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
index 20fc004b59e9..01e4f33415e1 100644
--- a/drivers/clk/sifive/Kconfig
+++ b/drivers/clk/sifive/Kconfig
@@ -2,7 +2,7 @@
 
 config CLK_SIFIVE
 	bool "SiFive SoC driver support"
-	depends on CLK
+	depends on CLK && RISCV
 	help
 	  SoC drivers for SiFive Linux-capable SoCs.
 
diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
index fbcdefd889ae..e0f15f57f826 100644
--- a/drivers/clk/ti/Kconfig
+++ b/drivers/clk/ti/Kconfig
@@ -5,14 +5,14 @@
 
 config CLK_TI_AM3_DPLL
 	bool "TI AM33XX Digital Phase-Locked Loop (DPLL) clock drivers"
-	depends on CLK && OF_CONTROL
+	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
 	help
 	  This enables the DPLL clock drivers support on AM33XX SoCs. The DPLL
 	  provides all interface clocks and functional clocks to the processor.
 
 config CLK_TI_CTRL
 	bool "TI OMAP4 clock controller"
-	depends on CLK && OF_CONTROL
+	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
 	help
 	  This enables the clock controller driver support on TI's SoCs.
 
-- 
2.43.0

