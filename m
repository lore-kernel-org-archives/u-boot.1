Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DCCC83F07
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 22:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E83B82958;
	Mon,  7 Jul 2025 00:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B12AE8277D; Sun,  6 Jul 2025 13:28:42 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1668980FA8
 for <u-boot@lists.denx.de>; Sun,  6 Jul 2025 13:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d21cecc11fso497347385a.3
 for <u-boot@lists.denx.de>; Sun, 06 Jul 2025 04:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751801319; x=1752406119;
 h=subject:message-id:date:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AoJbloQK9keGBzuZIh9S/Lv8hFrEEXCDGRPrSh1DWkE=;
 b=FugK3mar6jFQsGeGeWNkzczXhytQQhYKcY0fw8XHaRJX3d2q/W72xKHpSHmHRDBlUO
 UQ5UIPXW9NOcG19dmJn+xRdsK/KRYvxUKbBHRo4TOup0mdWuj3b6o41Yi0cDEv5hP+pL
 aC9opsE5AIDF7bYzc4LIpXgt6AmMoowQ12gLz8TAUhnI4rdp4kBd0gvysvDSwf532Vtx
 9bpOwhbJ9ydkSTeCLW8VAgeMRRb+GSvIl1J95NyAr5EqLbPmpwbyoSjKqs7DUN/wJmfX
 Y0AAJIq9DuMqVrXIrJPxIypW9/X7i8mF5DXmr8A3ZceAZ3cmPqW3eONIcychDjDJDkC0
 9aBg==
X-Gm-Message-State: AOJu0YyF1zNdnXsj6leYeQIfqkPVVL7t4Aebsu/XlYwmBVdGDlX+lMLc
 HXwc/fc5U1ULS0IXyJ0T9iPf4+oqLgdg6A68J8MXVbI55ZIrPhC+XWqPxX4Q7dIl
X-Gm-Gg: ASbGncuIq5RgvdysNAxGG15q2kLr09Zkquv7K5pF0maKrL2Fn5kCouZrwFRgNnWKOBl
 C7ppWAUXuctmR6cbNBFNnAzf9ci9mjnr97R76MM35gAXti5/rSTA3txeJ1NQ4BsfbJtTBhy7a13
 c95v50Qrm0KQ84MZaIJ2Ki6AnbaNWiD0JfSZRPuTZmXyIebnGGHgxjcepwPqIAMCUg29e05BShv
 UVKbVgICHMzxKx0v2zyw4jbQtyXrK6/oBd9hehFZVzCPkOkeykP5jr1KBIq5RFbUhLAXmXzd3R0
 kBQKjj6s/QoVPnWvk9oHw8pu1xWgA6x/dtpFAaWhKXeJwkVSbZ40+HAATZVPKhfyE1hw8zbW49y
 dBMMmJlSf8r0nK5gN1A==
X-Google-Smtp-Source: AGHT+IGnJsQpD2GXTX5fm/DDXjJphjDzPfjToNmjjmNsYXZn2yAQsJAHSC9pFiyLp78RamzTDoOEuw==
X-Received: by 2002:a05:620a:4711:b0:7d3:cfc1:9f39 with SMTP id
 af79cd13be357-7d5ec5830c2mr719877385a.0.1751801318628; 
 Sun, 06 Jul 2025 04:28:38 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d60401sm42534476d6.112.2025.07.06.04.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Jul 2025 04:28:38 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, Magnus Damm <damm@opensource.se>,
 marek.vasut+renesas@mailbox.org, geert+renesas@glider.be
Date: Sun, 06 Jul 2025 13:28:36 +0200
Message-Id: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH v3 0/9] RZ/A1 Genmai, RZ/A2 GR-Mango and RZA2MBTC support
X-Mailman-Approved-At: Mon, 07 Jul 2025 00:18:49 +0200
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

RZ/A1 Genmai, RZ/A2 GR-Mango and RZA2MBTC support

[PATCH v3 1/9] ARM: renesas: Put common RZ/A1 code in board/renesas/common
[PATCH v3 2/9] ARM: renesas: Add RZ/A1 Genmai board support
[PATCH v3 3/9] ARM: renesas: Add RZ/A2 support
[PATCH v3 4/9] pinctrl: renesas: Add RZ/A2 pinctrl support
[PATCH v3 5/9] serial: sh: Add RZ/A2 SCIF support
[PATCH v3 6/9] spi: renesas_rpc_spi: Add RZ/A2 SPI Multi I/O support
[PATCH v3 7/9] net: sh_eth: Adjust RZ/A1, add RZ/A2 support
[PATCH v3 8/9] ARM: renesas: Add RZ/A2 GR-Mango board support
[PATCH v3 9/9] ARM: renesas: Add RZ/A2 RZA2MBTC board support

These patches for U-Boot aim at adding initial support for:
- Genmai: (RZ/A1 SoC) Serial Console, SPI flash, Ethernet
- GR-Mango: (RZ/A2 SoC) Serial Console, Ethernet
- RZA2MBTC: (RZ/A2 SoC) Serial Console, SPI flash, Ethernet

Please get DT source files from the following series:
[PATCH 0/6] Add rpc-if to RZ/A1, RZ/A2 and update/add board support
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=979368

On-chip memory is currently utilized for all the boards in this series.
Support for on-board SDRAM will eventually be added as incremental patches.

Thanks to Chris and Marek for their efforts. I've taken the [5/9] SCIF patch
with code initially from Chris and reworked it. Also the [7/9] sh_eth code is
written on top of recent cleanup patches from Marek but adds code for RZ/A1
and RZ/A2 to take the base address of the ethernet controller from DT. Multi
port seems to work on RZ/A2 since RZA2MBTC is using Ethernet #1 via RMII and
GR-Peach is using Ethernet #0 and MII. The PFENET register is setup in low
level board init for RZA2MBTC to switch to RMII, maybe this should be done
in the pinctrl driver instead?

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to u-boot git cbb5672790d400e9ec6e9fceaf89ece2660c0117 (origin/next)
  and
 https://patchwork.ozlabs.org/project/uboot/list/?series=463012
 https://patchwork.ozlabs.org/project/uboot/list/?series=463013

 The first few patches in this series were earlier submitted as
 [PATCH v2 0/2] Initial r7s72100 Genmai board support

 Makefile                                  |    2 
 arch/arm/dts/Makefile                     |    7 +
 arch/arm/dts/r7s72100-genmai-u-boot.dtsi  |   32 ++++++
 arch/arm/dts/r7s9210-gr-mango-u-boot.dtsi |   28 +++++
 arch/arm/dts/r7s9210-rza2mbtc-u-boot.dtsi |   28 +++++
 arch/arm/mach-renesas/Kconfig             |    5 +
 arch/arm/mach-renesas/Kconfig.rza1        |    4 
 arch/arm/mach-renesas/Kconfig.rza2        |   24 +++++
 board/aprg/rza2mbtc/Kconfig               |   15 +++
 board/aprg/rza2mbtc/MAINTAINERS           |    5 +
 board/aprg/rza2mbtc/Makefile              |    1 
 board/aprg/rza2mbtc/rza2mbtc.c            |   34 +++++++
 board/renesas/common/Makefile             |   16 +++
 board/renesas/common/rza1-common.c        |   27 +++++
 board/renesas/common/rza1-lowlevel_init.S |  106 ++++++++++++++++++++++
 board/renesas/common/rza2-common.c        |   28 +++++
 board/renesas/common/rza2-lowlevel_init.S |  130 +++++++++++++++++++++++++++
 board/renesas/genmai/Kconfig              |   12 ++
 board/renesas/genmai/MAINTAINERS          |    5 +
 board/renesas/genmai/Makefile             |    7 +
 board/renesas/genmai/genmai.c             |   49 ++++++++++
 board/renesas/grmango/Kconfig             |   12 ++
 board/renesas/grmango/MAINTAINERS         |    5 +
 board/renesas/grmango/Makefile            |    7 +
 board/renesas/grmango/grmango.c           |   40 ++++++++
 board/renesas/grpeach/Makefile            |    1 
 board/renesas/grpeach/grpeach.c           |   22 ----
 board/renesas/grpeach/lowlevel_init.S     |  106 ----------------------
 configs/genmai_defconfig                  |   17 +++
 configs/grmango_defconfig                 |   10 ++
 configs/renesas_rza2.config               |   53 +++++++++++
 configs/rza2mbtc_defconfig                |   17 +++
 drivers/net/sh_eth.c                      |   16 ++-
 drivers/net/sh_eth.h                      |   31 +++---
 drivers/pinctrl/renesas/Kconfig           |    9 +
 drivers/pinctrl/renesas/Makefile          |    1 
 drivers/pinctrl/renesas/pinctrl-rza2.c    |  136 +++++++++++++++++++++++++++++
 drivers/serial/serial_sh.c                |   26 ++++-
 drivers/serial/serial_sh.h                |   15 +++
 drivers/spi/Kconfig                       |    8 -
 drivers/spi/renesas_rpc_spi.c             |    3 
 include/configs/genmai.h                  |   15 +++
 include/configs/grmango.h                 |   15 +++
 include/configs/rza2mbtc.h                |   27 +++++
 44 files changed, 997 insertions(+), 160 deletions(-)
