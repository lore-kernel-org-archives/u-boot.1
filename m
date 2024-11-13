Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FF7D41C3E
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B048089565;
	Wed, 13 Nov 2024 14:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="EeIEVTXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C6788599; Wed, 13 Nov 2024 07:27:24 +0100 (CET)
Received: from mail-io1-xd61.google.com (mail-io1-xd61.google.com
 [IPv6:2607:f8b0:4864:20::d61])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1AB988FE5
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-io1-xd61.google.com with SMTP id
 ca18e2360f4ac-83aaf19594eso4474939f.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 22:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1731479240; x=1732084040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4jAoKLIn+Wpak3m9IGcVnwP6jfVvELIat2S0kgLPzK8=;
 b=EeIEVTXzLDfL4tysWRP7BWzCoTQGWjFOmAZVtLScl2V+2b00liWWoBPJEzT2u0W56i
 YEN1MQMZaF+KL+KYa0TmFsD0+tM+BCGMmHhNY32bYWU8+PgoCvjAunP3oquRkHBX4Hk8
 IceNCPmEWZxLHUYqxRYNeDL6kIe6WHAbAlM8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731479240; x=1732084040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4jAoKLIn+Wpak3m9IGcVnwP6jfVvELIat2S0kgLPzK8=;
 b=QqtgkbXhQT3x9u0HQlx9gGNKavg+/B7Vt9qWe56sflOasOOibxf2SWPRT8nhW/gH0L
 2AxOeBRpp4EIR3HyzPBjboQgkyH5PzVp7+KIYH98V3OtlEp5zcObCyx8g+PYWJ36i4Zc
 sRS/SGaHPWLrwGsk9IgZ3ji0litfCwejXvM6/OlNnu4AfRyVGrgYL2cebTfSkNwhEe2m
 Ow9wwujv2KaC7Kv4a5RGMZXYNcxe0mF86tzWpY9lwp46Uj0gatQNGbYbWTJUAb2jpF51
 RyU86modwaEV+wOXScWcFrf/5xpNon40V1rJqV3Hw6qRnZkbAv6Lau1qQlSWbnEbpOdM
 YENA==
X-Gm-Message-State: AOJu0YwCbMqyxiBfRczB8xlBoCfU1PgUjRU93EB8tOFyrTSV5lBSDEHz
 Ajnzx3dlFf8zjXtFqQZSUVvBCMvbD/PpEpLYpJEq5MbHLUOpVby/i/kgkZPK6uD1mItGmCqAF66
 mjAJXya3F6qVghtqF3gNkDis5k/ywYJHPQUAbHa9srPEctVzDEYFrDzmleDZLE2oc2lBnoOkGnd
 Og8TS/lWTKNI30kKajE1+vjD5ZA191k2M6qFzu0E3rBlgHgo0zezetT+5bll5ggiJ5oPfb
X-Google-Smtp-Source: AGHT+IExBW2R/FVZ6wbIRgkxNQwBjN8j88keYEt4Yincbp8aaB0fR3GemG2hadRd55kRWv0mFcmiUPAegz3N
X-Received: by 2002:a05:6602:3f85:b0:83a:9350:68b with SMTP id
 ca18e2360f4ac-83e030815a7mr602429939f.0.1731479240202; 
 Tue, 12 Nov 2024 22:27:20 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 ca18e2360f4ac-83e13584b67sm87580139f.31.2024.11.12.22.27.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2024 22:27:20 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, dregan@mail.com, dregan@broadcom.com
Subject: [PATCH v2 0/4] Broadcom BCMBCA nand updates
Date: Tue, 12 Nov 2024 22:27:11 -0800
Message-Id: <20241113062715.2872-1-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 Nov 2024 14:00:05 +0100
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

Implement a minimal set of defconfig options to enable basic NAND
functionality. Tested on:
47622
63146
63158
63178
6813

Set parameter_page_big_endian to zero for bcmbca.

Update log level messages so that more critical messages can be logged
to console and help the troubleshooting with field devices.

https://lore.kernel.org/linux-mtd/20240223034758.13753-4-william.zhang@broadcom.com/

---

Changes in v2:
- Set parameter_page_big_endian to zero for bcmbca instead of
  using an extra bit of endian translation code.

david regan (4):
  mtd: nand: brcmnand: remove device specific nand driver files
  arm: dts: Use upstream dts
  mtd: rawnand: brcmnand: Default bcmbca parameter_page_big_endian to
    zero
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
 drivers/mtd/nand/raw/brcmnand/brcmnand.c      |  14 +-
 51 files changed, 132 insertions(+), 2782 deletions(-)
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

