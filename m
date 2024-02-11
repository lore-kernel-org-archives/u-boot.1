Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30560C4829B
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 17:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A41487C69;
	Sun, 11 Feb 2024 18:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OU/QKTaI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dQ4rhh6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 455EA87CAC; Sun, 11 Feb 2024 18:33:25 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAE087C4D
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 18:33:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TXvnZ4CWXz9sc0;
 Sun, 11 Feb 2024 18:33:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1707672802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vkHFB6NwQpNi7OmELrVj2qmlmGJzBT82RZKR5xwzw0g=;
 b=OU/QKTaI6CkDn4pQFU3nt0ctz+gW/3781P8Vku5fFL98mYQl3/N+9laOnDGGS5x3Jx3e3C
 eCPExBv4Fp3X/OWmj3hosuLikRD+VDa/8sjTGCXQhb4RgYhp5yKbpgSq4A60mAmherqMxt
 9/QcyILQgmVhGGpCT2stph7MPV5fs56t6bKRgz0OGXafwiCUIH3zjGQ+1C+z9eqlb3cP4c
 39p/Dia5nWwXgiW7TRgAusk0z6yxC/iZOOUEO/Segl7nA27HxPXDbs/ui9FpKPZnz+GdDg
 009iAl2lT9xWkGe43ZP3MEEZBd9KBO44wR9aafhQXe3RUakLAqmtyMkjkLLIsw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1707672800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vkHFB6NwQpNi7OmELrVj2qmlmGJzBT82RZKR5xwzw0g=;
 b=dQ4rhh6tms5ONa4X9gV2X7hWAmy2EUq5lLK5BrygAJ2j7z8byJDwC9KLEnboFUmodIoYQ7
 4kTsNnZjlFUJpMR6TqsVLo9x77sis0p/yAcapc0DA8Fo62tgf9FhA+Z9aDx/VPO7sATtcT
 JmXpz+vjIIVE7jo+82Go8alaGS2VYX5YkRxHP29UR2Gx0NuSyvP+OV0deRPEwPUmd+x7fA
 x/wWUd8FKgYy0GadfaW/MDjH+jR+X3ymuIhN8FNwwy6Vu30LLz7orzfnFZxq3IPZdDNmvW
 7SX5f4rqOIf2WjfZpgmgDnUylF+1hxHMQLsvBaDE0MUps4uTgOevT5LodmSfBA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>
Subject: [PULL] u-boot-sh/master-779h0-r2
Date: Sun, 11 Feb 2024 18:31:59 +0100
Message-ID: <20240211173301.7077-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6afa6c6aa90556fdbce
X-MBO-RS-META: jym5f8r9i48d7j1bb9xyskuta4zu6nti
X-Rspamd-Queue-Id: 4TXvnZ4CWXz9sc0
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

The following changes since commit d7aaaf4223d0a2f9f8c9eed47d7431860b3116d8:

  Merge tag 'u-boot-dfu-20240209' of https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-02-09 09:00:42 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master-779h0-r2

for you to fetch changes up to 53066deccbedf02439309b0d4aca9f0be853a8da:

  ARM: renesas: Add Renesas R8A779H0 V4M Gray Hawk board code (2024-02-10 17:08:06 +0100)

----------------------------------------------------------------
Duy Nguyen (2):
      dt-bindings: clock: Add R8A779H0 V4M CPG Core Clock Definitions
      dt-bindings: power: Add R8A779H0 V4M SYSC power domain definitions

Hai Pham (8):
      clk: renesas: Add R8A779H0 V4M clock tables
      pinctrl: renesas: Add R8A779H0 V4M PFC tables
      ARM: renesas: Add R8A779H0 V4M Kconfig entry and PRR ID
      mtd: spi: renesas: Add R8A779H0 V4M support
      ARM: dts: renesas: Add Renesas R8A779H0 V4M SoC support
      ARM: dts: renesas: Add Renesas R8A779H0 V4M DT extras
      ARM: dts: renesas: Add Renesas Gray Hawk boards support
      ARM: renesas: Add Renesas R8A779H0 V4M Gray Hawk board code

Marek Vasut (1):
      clk: renesas: Implement R8A779H0 V4M PLL7 support

 arch/arm/dts/Makefile                              |    3 +-
 arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi           |  166 +
 arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi       |   15 +
 arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi      |   15 +
 arch/arm/dts/r8a779h0-gray-hawk-u-boot.dts         |   42 +
 arch/arm/dts/r8a779h0-gray-hawk.dts                |   25 +
 arch/arm/dts/r8a779h0-u-boot.dtsi                  |   27 +
 arch/arm/dts/r8a779h0.dtsi                         |  460 +++
 arch/arm/mach-rmobile/Kconfig.rcar4                |   13 +
 arch/arm/mach-rmobile/cpu_info.c                   |    1 +
 arch/arm/mach-rmobile/include/mach/rmobile.h       |    1 +
 board/renesas/grayhawk/Kconfig                     |   15 +
 board/renesas/grayhawk/MAINTAINERS                 |    5 +
 board/renesas/grayhawk/Makefile                    |    9 +
 board/renesas/grayhawk/grayhawk.c                  |   66 +
 configs/r8a779h0_grayhawk_defconfig                |   75 +
 drivers/clk/renesas/Kconfig                        |    6 +
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/clk-rcar-gen3.c                |    6 +
 drivers/clk/renesas/r8a779h0-cpg-mssr.c            |  293 ++
 drivers/clk/renesas/rcar-gen3-cpg.h                |    3 +
 drivers/pinctrl/renesas/Kconfig                    |    6 +
 drivers/pinctrl/renesas/Makefile                   |    1 +
 drivers/pinctrl/renesas/pfc-r8a779h0.c             | 3969 ++++++++++++++++++++
 drivers/pinctrl/renesas/pfc.c                      |   11 +
 drivers/pinctrl/renesas/sh_pfc.h                   |    1 +
 drivers/spi/renesas_rpc_spi.c                      |    3 +-
 include/configs/grayhawk.h                         |   14 +
 .../dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h  |   96 +
 include/dt-bindings/power/renesas,r8a779h0-sysc.h  |   49 +
 30 files changed, 5395 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi
 create mode 100644 arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi
 create mode 100644 arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi
 create mode 100644 arch/arm/dts/r8a779h0-gray-hawk-u-boot.dts
 create mode 100644 arch/arm/dts/r8a779h0-gray-hawk.dts
 create mode 100644 arch/arm/dts/r8a779h0-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a779h0.dtsi
 create mode 100644 board/renesas/grayhawk/Kconfig
 create mode 100644 board/renesas/grayhawk/MAINTAINERS
 create mode 100644 board/renesas/grayhawk/Makefile
 create mode 100644 board/renesas/grayhawk/grayhawk.c
 create mode 100644 configs/r8a779h0_grayhawk_defconfig
 create mode 100644 drivers/clk/renesas/r8a779h0-cpg-mssr.c
 create mode 100644 drivers/pinctrl/renesas/pfc-r8a779h0.c
 create mode 100644 include/configs/grayhawk.h
 create mode 100644 include/dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/renesas,r8a779h0-sysc.h
