Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77A0C282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 17:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF90E80ECC;
	Sun, 16 Mar 2025 18:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Di6n85qE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADDC380F4C; Sun, 16 Mar 2025 18:53:15 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E39A380C93
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 18:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so1963496a91.0
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1742147591; x=1742752391;
 darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cdCTOtQxMwVAPbOUFJNN1Lo11Nus9m8YQ0cbRwizqng=;
 b=Di6n85qE6XPX0IxXKHi/UhHW1X+o6YcsMKEKbSXpcnnjgfi+2WaTXdnsfbP5BvQ+9D
 R1zcqARjUmyY+OzJDh381nhuYJU3cKkKoQtf65Rljn4AaCUQBMdl6u5l57BrrAwUL3PU
 m8RtG47G/MbU2/VolOu19ze9FIiaISC3fMDjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742147591; x=1742752391;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cdCTOtQxMwVAPbOUFJNN1Lo11Nus9m8YQ0cbRwizqng=;
 b=w6c3/+i1NL8yI0HrjuFF1yaZbcKo2/nBVWHoAH2s0rb4TddmG8Dr7m0uULRaJnIVvM
 BgizRvz15D3A6S6VyZZ6C1EAmaZSFt8LvkgBuj1zckMaq9wsjP4XeaLhLgWAlklGgjo1
 Il+Kv78Y5xr7r7mqEIxilIwUTI6G+lx0w6ubr3lnFspbnV6b5w3yYA7JYdZ41aNrcomA
 LOI7xvZ1JfTx8Wxl5Gls+QxUiXlKPVI3Tb6C5BU0dCWInOeenGQewuzz/ZrXrCKLAuML
 Df6A1Zc6wxdW33KZXtB2qRTQo6xGboQtNYM7cJNrCHOZem5Z18BN2H6GF8rbV7Ztz6qS
 hC5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRrywYLbsjmutiET/SW4PuEfFdrSUGEgmXXLCthzmT0No4TDZvUN2zcRTXCpE2bc3mNEwGnnE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6GLiWWGI65dqETuwS50xPkQtWhI7RgAsykqFmRSGMr9qdqdGn
 kAhEuYaalSTIg1S2qgN4SR1XhLMg/sQd5aZPRvhOnuSJaCljkVYxZJ37nh+J+YlXREIm2E3BNok
 Vg0Pth6hyf5G8SeWUkn6j92HxSB1GH2Fezp+vUFCjqusx9NENxfKbVg==
X-Gm-Gg: ASbGncuzjMqyLbnGLG/oPBzu1f5YlYem5sLsBkqo7QPrR+VLiTK9ktwlvXxpOqrF7TK
 wH+R5ShL7xf3+06cXpl1EarpNIOaKuCqux8eGZLYIzL1xTMKoo2G+XjTveyH/ZMkZoqXoBh3ueU
 p7yZDPj2sN8pfFwUPidOPfhkRrzKwPzufhAQ==
X-Google-Smtp-Source: AGHT+IEtyq5WZy5xt698SPHg4btrAICAYK2Mj8YBX8S468+eoLE6ts8b5ZqXLeNpaomrOGuAeexBh5xs9ZmMt1TD8gY=
X-Received: by 2002:a17:90a:e18f:b0:2fe:afa7:eaf8 with SMTP id
 98e67ed59e1d1-30151cd790emr11802263a91.13.1742147591358; Sun, 16 Mar 2025
 10:53:11 -0700 (PDT)
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 16 Mar 2025 18:53:00 +0100
X-Gm-Features: AQ5f1JqH-Cw55XmEDeqOstsKZm-GG1aG_ez58z-dfLC01MfbcmJQFCMDECMCSoA
Message-ID: <CAOf5uwkfa9c7Z=CRorRKxku55G==CDvUpmChm8U+Hfmy6HNOfw@mail.gmail.com>
Subject: Pull request for u-boot-nand-next External
To: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

The following changes since commit 15d6518c942f0da13f9a7ceeadbd925c3317ec8d:

  ARM: dts: imx: Drop bogus regulator extras on DH i.MX6 DHCOM DRC02
(2025-03-13 15:22:48 -0600)

are available in the Git repository at:

  git://source.denx.de:u-boot/custodians/u-boot-nand-flash.git nand-next

for you to fetch changes up to 448d27f6adf6de576860fdb9c3c4ecbe51819e33:

  mtd: rawnand: meson: always use OOB bytes during write (2025-03-16
14:02:05 +0100)

This merge request add support for cadence raw nand driver for agilex board
and
add a fix to meson driver

The patches pass the pipeline CI:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/25178

----------------------------------------------------------------
Arseniy Krasnov (1):
      mtd: rawnand: meson: always use OOB bytes during write

Dinesh Maniyam (17):
      dt: nand: add cadence nand dt-bindings
      arm: dts: agilex5: Enabled cdns-nand dts setting
      drivers: mtd: nand: Add driver for Cadence Nand
      drivers: mtd: nand: cadence: Add support for read status command
      drivers: mtd: nand: cadence: Add support for readid command
      drivers: mtd: nand: cadence: Add support for NAND_CMD_PARAM
      drivers: mtd: nand: cadence: Add support for NAND_CMD_RESET
      drivers: mtd: nand: cadence: Support cmd SET_FEATURES & GET_FEATURES
      drivers: mtd: nand: cadence: Flush & invalidate dma descriptor
      drivers: mtd: nand: cadence: Poll for desc complete status
      drivers: mtd: nand: cadence: Use bounce buffer
      drivers: nand: Enabled Kconfig and Makefile for cdns-nand
      drivers: mtd: nand: base: Add support for Hardware ECC for check bad
block
      drivers: mtd: nand: spl: Add support for nand SPL load image
      drivers: mtd: nand: Enabled Kconfig and Makefile for Cadence-SPL
      drivers: mtd: nand: Kconfig: Add SYS_NAND_PAGE_SIZE dependency
      configs: nand2_defconfig: Enable configs for nand boot

 arch/arm/dts/socfpga_agilex5.dtsi              |   14 +
 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |    9 +-
 arch/arm/dts/socfpga_agilex5_socdk.dts         |   19 +
 board/intel/agilex5-socdk/MAINTAINERS          |    2 +
 configs/socfpga_agilex5_nand2_defconfig        |   31 +
 doc/device-tree-bindings/mtd/cadence,nand.yaml |   98 +
 drivers/mtd/nand/raw/Kconfig                   |   24 +-
 drivers/mtd/nand/raw/Makefile                  |    2 +
 drivers/mtd/nand/raw/cadence_nand.c            | 2423
++++++++++++++++++++++++
 drivers/mtd/nand/raw/cadence_spl.c             |   59 +
 drivers/mtd/nand/raw/meson_nand.c              |    4 +-
 drivers/mtd/nand/raw/nand_base.c               |   69 +-
 include/cadence-nand.h                         |  529 ++++++
 include/linux/mtd/rawnand.h                    |   12 +
 14 files changed, 3266 insertions(+), 29 deletions(-)
 create mode 100644 configs/socfpga_agilex5_nand2_defconfig
 create mode 100644 doc/device-tree-bindings/mtd/cadence,nand.yaml
 create mode 100644 drivers/mtd/nand/raw/cadence_nand.c
 create mode 100644 drivers/mtd/nand/raw/cadence_spl.c
 create mode 100644 include/cadence-nand.h
