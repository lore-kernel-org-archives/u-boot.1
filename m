Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C692D29FA5
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 00:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A44988E39;
	Thu,  7 Nov 2024 01:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Xpi6/whw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D95A488CD9; Wed,  6 Nov 2024 22:04:00 +0100 (CET)
Received: from mail-il1-x163.google.com (mail-il1-x163.google.com
 [IPv6:2607:f8b0:4864:20::163])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0567C88CD9
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 22:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-il1-x163.google.com with SMTP id
 e9e14a558f8ab-3a3c5d22663so156475ab.2
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 13:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1730927037; x=1731531837; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CVM7XX0pfQPrT9jpiktWAGsVF6+Go1o2WafEC6azNAs=;
 b=Xpi6/whwa7AO81WUPScrInbs6gQ+qfuhsLhdQTudVKmvNcle1P416n/zv5GLzAZu5u
 D73sbCevnui3O8PU2ZHwMh9B4f8dwiOYmGFNlMIQBpJ51JRYInliS73ZKaAeHiCOVTDL
 lTLEG8qIPJOjvxAVkaG3KE02AGECGPXVSb9NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730927037; x=1731531837;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CVM7XX0pfQPrT9jpiktWAGsVF6+Go1o2WafEC6azNAs=;
 b=MdzKwFwZEgSsdnS6JOzjdkB2Epe+8ZG5rVP6cuTfV+yFU5ZKLjls3S3minI51T9CzP
 3xobue7XcMXGXCmec05LkOWHproTzRItF74Qnvf/byQMYL89JH4NQZ187TvuvN70lhh/
 7j5o9MYnhh5u0rKtM/5MqLxQq9avrkCYSGlGm8oit8x1DE9woPUKqsb2dZmpwopR9eAC
 bUzN+etkfIRam0C5fA7s6DaFcBCjmLUgCCykABlJmtgCmfT+dhStTHKTXzokkDiYAqS/
 g9OFiA0w2pbxOo4/G2Rm8r+6DgoyVMr9nczIjqs9RgELHaeqBOLFmLmfqlqzscSRAkTc
 9pZw==
X-Gm-Message-State: AOJu0YxxNURLiRs3ig3PEgpm1A2WAUs/aCeXHEoSl0BH8IBFYXXAqJp2
 CsZnAq3SaNMnW+w627JMzOz5a3rAH8ppHg7An2pqYNmqIiyjiwKTqcUPtKoDG9SZ/NVlj0BQgvm
 GJlCnyKVtUrFVTjpd+aqhvn2Jb8TVaw67uK+m9vYYGy3OvCAmjLQvNsnbJY+yoOZXc8mZ1zZWZB
 eEj7Z6Wvp7fJ110ZmmGF6/wsD71YJE2zdS1+ndWBkfxU9JxMtzec+x8bReq5hDqYSK5KQL
X-Google-Smtp-Source: AGHT+IEtNLKGXFmlF4LsWA3EWyQ85zimOwn340u1KBLw3PJx9gkU9trjD1lYG8qboO/jd0O2vePNvO9TQ49e
X-Received: by 2002:a92:c56f:0:b0:3a6:b5f7:66ae with SMTP id
 e9e14a558f8ab-3a6e8379cb4mr3705025ab.0.1730927036441; 
 Wed, 06 Nov 2024 13:03:56 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-3a6a9a29b37sm8165005ab.71.2024.11.06.13.03.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Nov 2024 13:03:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: u-boot <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@broadcom.com>,
 David Regan <dregan@mail.com>, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/4] Broadcom BCMBCA nand updates
Date: Wed,  6 Nov 2024 13:03:44 -0800
Message-Id: <20241106210348.218507-1-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Nov 2024 01:52:42 +0100
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

These are ports of upstream Linux patches to U-Boot.

Remove device specific nand driver files as they are now replaced
by a common driver bcmbca_nand.c

Make use of OF_UPSTREAM which uses Linux dts.

Add a SoC read data bus shim for BCMBCA to meet the specific SoC need
and performance improvement using the optimized memcpy function on NAND
cache memory.

https://lore.kernel.org/linux-mtd/20240223034758.13753-12-william.zhang@broadcom.com/

Update log level messages so that more critical messages can be logged
to console and help the troubleshooting with field devices.

https://lore.kernel.org/linux-mtd/20240223034758.13753-4-william.zhang@broadcom.com/

david regan (4):
  mtd: nand: brcmnand: remove device specific nand driver files
  arm: dts: Use upstream dts
  mtd: rawnand: brcmnand: Add BCMBCA read data bus interface
  mtd: rawnand: brcmnand: update log level messages

 arch/arm/dts/bcm47622.dtsi                    | 126 --------
 arch/arm/dts/bcm4912.dtsi                     | 128 --------
 arch/arm/dts/bcm63146.dtsi                    | 110 -------
 arch/arm/dts/bcm63158.dtsi                    | 278 ------------------
 arch/arm/dts/bcm63178.dtsi                    | 120 --------
 arch/arm/dts/bcm6756.dtsi                     | 130 --------
 arch/arm/dts/bcm6813.dtsi                     | 128 --------
 arch/arm/dts/bcm6855.dtsi                     | 257 ----------------
 arch/arm/dts/bcm6856.dtsi                     | 253 ----------------
 arch/arm/dts/bcm6858.dtsi                     | 272 -----------------
 arch/arm/dts/bcm6878.dtsi                     | 111 -------
 arch/arm/dts/bcm947622.dts                    |  30 --
 arch/arm/dts/bcm94912.dts                     |  30 --
 arch/arm/dts/bcm963146.dts                    |  30 --
 arch/arm/dts/bcm963158.dts                    |  30 --
 arch/arm/dts/bcm963178.dts                    |  30 --
 arch/arm/dts/bcm96756.dts                     |  30 --
 arch/arm/dts/bcm96813.dts                     |  30 --
 arch/arm/dts/bcm96855.dts                     |  30 --
 arch/arm/dts/bcm96856.dts                     |  30 --
 arch/arm/dts/bcm96858.dts                     |  30 --
 arch/arm/dts/bcm96878.dts                     |  30 --
 arch/arm/mach-bcmbca/bcm47622/Kconfig         |   1 +
 arch/arm/mach-bcmbca/bcm4912/Kconfig          |   1 +
 arch/arm/mach-bcmbca/bcm63146/Kconfig         |   1 +
 arch/arm/mach-bcmbca/bcm63158/Kconfig         |   1 +
 arch/arm/mach-bcmbca/bcm63178/Kconfig         |   1 +
 arch/arm/mach-bcmbca/bcm6756/Kconfig          |   1 +
 arch/arm/mach-bcmbca/bcm6813/Kconfig          |   1 +
 arch/arm/mach-bcmbca/bcm6855/Kconfig          |   1 +
 arch/arm/mach-bcmbca/bcm6856/Kconfig          |   1 +
 arch/arm/mach-bcmbca/bcm6858/Kconfig          |   1 +
 arch/arm/mach-bcmbca/bcm6878/Kconfig          |   1 +
 configs/bcm947622_defconfig                   |  11 +-
 configs/bcm94912_defconfig                    |  11 +-
 configs/bcm963146_defconfig                   |  11 +-
 configs/bcm963158_defconfig                   |  11 +-
 configs/bcm963178_defconfig                   |  11 +-
 configs/bcm96756_defconfig                    |  11 +-
 configs/bcm96813_defconfig                    |  11 +-
 configs/bcm96855_defconfig                    |  11 +-
 configs/bcm96856_defconfig                    |  11 +-
 configs/bcm96858_defconfig                    |  11 +-
 configs/bcm96878_defconfig                    |  11 +-
 drivers/mtd/nand/raw/Kconfig                  |  24 --
 drivers/mtd/nand/raw/brcmnand/Makefile        |   4 -
 drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c | 125 --------
 drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c  | 123 --------
 drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c | 124 --------
 drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c  | 125 --------
 drivers/mtd/nand/raw/brcmnand/brcmnand.c      |  21 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.h      |  17 ++
 52 files changed, 142 insertions(+), 2796 deletions(-)
 delete mode 100644 arch/arm/dts/bcm47622.dtsi
 delete mode 100644 arch/arm/dts/bcm4912.dtsi
 delete mode 100644 arch/arm/dts/bcm63146.dtsi
 delete mode 100644 arch/arm/dts/bcm63158.dtsi
 delete mode 100644 arch/arm/dts/bcm63178.dtsi
 delete mode 100644 arch/arm/dts/bcm6756.dtsi
 delete mode 100644 arch/arm/dts/bcm6813.dtsi
 delete mode 100644 arch/arm/dts/bcm6855.dtsi
 delete mode 100644 arch/arm/dts/bcm6856.dtsi
 delete mode 100644 arch/arm/dts/bcm6858.dtsi
 delete mode 100644 arch/arm/dts/bcm6878.dtsi
 delete mode 100644 arch/arm/dts/bcm947622.dts
 delete mode 100644 arch/arm/dts/bcm94912.dts
 delete mode 100644 arch/arm/dts/bcm963146.dts
 delete mode 100644 arch/arm/dts/bcm963158.dts
 delete mode 100644 arch/arm/dts/bcm963178.dts
 delete mode 100644 arch/arm/dts/bcm96756.dts
 delete mode 100644 arch/arm/dts/bcm96813.dts
 delete mode 100644 arch/arm/dts/bcm96855.dts
 delete mode 100644 arch/arm/dts/bcm96856.dts
 delete mode 100644 arch/arm/dts/bcm96858.dts
 delete mode 100644 arch/arm/dts/bcm96878.dts
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c

-- 
2.37.3

