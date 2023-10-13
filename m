Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC425CDB474
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 02:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1DD186E47;
	Fri, 13 Oct 2023 03:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eDnsBiK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B6086E37; Fri, 13 Oct 2023 03:21:26 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF5E86D17
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 03:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=inindev@gmail.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-77433e7a876so106144685a.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 18:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697160045; x=1697764845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wMibZ+nHiRs4hLBCMcQlTSQ9ifCuC83ZToz8JDn5Wyo=;
 b=eDnsBiK0lOergkA8kmaEefrBLnqC/k/oVvZ7fs/NiHem8DUONb//i4qVjn6q6mpPgr
 V3i+CJaQzvj782J5i/ABZropUxHgJrrPLNDf1a7XFiT10HGI8ymXffhXTZcClc2HLNSL
 35lPyQzWMsKXahIq4Xyrw1FM0J4mVhaYcm/phU4CJyLOgm6WAxKuuvMx2EnlNuy+HZX5
 A7GCxJuRhS8J+w9AYdG/j7A8E8oCUKHljF7wUDNsEZOcAVTN81hKWJXMlTmLcS9hMI3C
 owc5OxaTM4+6MmGq9/qvJTqaIp8aqLRhWN1GHoXIXRbyPrxfrt37E0LB5HIoTO+ctuzt
 PXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697160045; x=1697764845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMibZ+nHiRs4hLBCMcQlTSQ9ifCuC83ZToz8JDn5Wyo=;
 b=PGSHhNkPQbx0UJzyLotwo5zQBPvSIFXDONPIGFXtoGiOek94rpAuK9W4C+uhjvnVIw
 zRnsaU3eVNvGdrSMjB+VV2Gzv7aFQjxxzvJyl0hyVv25227zX+NC/HKdieQMp4uGYlnp
 XJTmFtI9KgYsTxS8f1iCqJ0HR/HTFWJIl9K5AH2Qdaj+93I5ps88IKYofUjuMepSMOxY
 m2Kb/SMcqfGbAGZa2O/5d2NbRftZNXlNqkowaAPHPrElpbMk3D591MJGRy+82XZsVwNf
 jS/q0mKNaKnpv6ttvNR26y0Mb6SQh9YyNhxsK0Xi1b6ZhAx7y0salQMVNFR/SE1suMLi
 KF0Q==
X-Gm-Message-State: AOJu0Ywwp+U6gwVTBthdDG88PBBHO+gWJw8ByMO3CfPUkNq+o5ldwgl/
 F8D6G2v8fTxhpLVautFR+Tk=
X-Google-Smtp-Source: AGHT+IF020u4bGpamXb7n7ZqNnPxcnvAF7ntdDN14D9HFXjoHZSaH3M5UOa4lcXpGwNT/UZunPTwBA==
X-Received: by 2002:a05:620a:44ca:b0:772:6443:daf3 with SMTP id
 y10-20020a05620a44ca00b007726443daf3mr34245813qkp.66.1697160045128; 
 Thu, 12 Oct 2023 18:20:45 -0700 (PDT)
Received: from localhost.localdomain (cpe-107-15-246-199.nc.res.rr.com.
 [107.15.246.199]) by smtp.gmail.com with ESMTPSA id
 x5-20020a05620a14a500b0076f18be9a64sm230113qkj.81.2023.10.12.18.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 18:20:44 -0700 (PDT)
From: John Clark <inindev@gmail.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: John Clark <inindev@gmail.com>, Chris Morgan <macromorgan@hotmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Jagan Teki <jagan@edgeble.ai>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH v4 0/1] Empirical testing suggests that the rk3588 variants
 require additional spi detection handling based on iomux settings.
Date: Fri, 13 Oct 2023 01:19:21 +0000
Message-ID: <20231013012025.11694-1-inindev@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Jonas Karlman is currently investigating a more comprehensive spi flash detection solution to support all rk3588 iomux variations.
This v4 patch suppresses spi flash support which will be supplied as a subsequent patch.

Changes in v4:
- removed SPI support as Jonas Karlman will be providing a comprehensive solution to support all rk3588 iomux variations.

Changes in v3:
- The vendor device tree uses "FriendlyElec NanoPC-T6" therefore, use FriendlyElec over FriendlyARM.
- Bug: use IS_ENABLED(CONFIG_TARGET_NANOPCT6_RK3588) rather than CONFIG_IS_ENABLED(TARGET_NANOPCT6_RK3588)

Changes in v2:
- resync dt from linux next
- config changes:
    -CONFIG_PCI_INIT_R=y
    -CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
    +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
    -CONFIG_REGULATOR_PWM=y
    -# CONFIG_USB_XHCI_DWC3_OF_SIMPLE is not set
    -CONFIG_SPL_USB_DWC3_GENERIC=y
- added board files:
    Kconfig, MAINTAINERS, Makefile, nanopct6-rk3588.c, nanopct6-rk3588.h
- improved BROM_LAST_BOOTSOURCE handling for SPI NOR

John Clark (1):
  board: rockchip: add FriendlyElec NanoPC-T6 rk3588 board

 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi     |  36 +
 arch/arm/dts/rk3588-nanopc-t6.dts             | 916 ++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/Kconfig         |  46 +
 board/friendlyelec/nanopc-t6-rk3588/Kconfig   |  15 +
 .../friendlyelec/nanopc-t6-rk3588/MAINTAINERS |   9 +
 board/friendlyelec/nanopc-t6-rk3588/Makefile  |   6 +
 .../nanopc-t6-rk3588/nanopc-t6-rk3588.c       |  39 +
 configs/nanopc-t6-rk3588_defconfig            | 108 +++
 doc/board/rockchip/rockchip.rst               |   1 +
 include/configs/nanopc-t6-rk3588.h            |  15 +
 11 files changed, 1192 insertions(+)
 create mode 100644 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-nanopc-t6.dts
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/Kconfig
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/MAINTAINERS
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/Makefile
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
 create mode 100644 configs/nanopc-t6-rk3588_defconfig
 create mode 100644 include/configs/nanopc-t6-rk3588.h

-- 
2.42.0

