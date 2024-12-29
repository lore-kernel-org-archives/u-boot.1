Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FECE7718B
	for <u-boot@archiver.kernel.org>; Sun, 29 Dec 2024 17:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B440480243;
	Sun, 29 Dec 2024 18:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xGkPh9uQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JfJVG0QY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0503804CE; Sun, 29 Dec 2024 18:36:51 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C35F8021D
 for <u-boot@lists.denx.de>; Sun, 29 Dec 2024 18:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YLmcw0hvLz9sVN;
 Sun, 29 Dec 2024 18:36:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735493808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5aPzZNyG2kHAf0IHOzBr5tV6omZ71J28mCvKyNF1vAU=;
 b=xGkPh9uQPy4IdI0E0kpX8S9KAHYDZMnh1Y5S+PrLs1uF+Il4yX95/ac020R3EyaorWM4j3
 DSV+g/FnXfNmUzOK26nVJA7AC7q02TKnp2k/GVijMIFDuBML3gLg83R3Jri43cuafOOmyh
 Fg4m41iOvc+Hr6O/w3pe0uZ7VBgtNDTXx7ylU3AphOa/vgZazZSrPgph8bEVaU4CxFBQcQ
 xDUZ6mgIjnk62/jBO/YyLsNBGAW8hYgoaXC62NEzLLAF6mirK3pC/uTQMTmvgvd5kS2s3i
 qHpQLEPhjIk/LuKjXrENwS5hsT4/RnqJyPV+Nbb+l5Ty+VxOovFZp9dzz7m9bw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735493805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5aPzZNyG2kHAf0IHOzBr5tV6omZ71J28mCvKyNF1vAU=;
 b=JfJVG0QYJUqTC8qEc5OYTZKn004Dlme3y5koJwnYkqjkXU2/34ZMNH4ZGp/OHQy7kv4L4z
 W3KRtdR9yfzFw++vAkTCiLBaT3EZlFxol/jujsZGuplYQmeIU3UphMfPWtPJQ+DhN/+8xt
 +YCXWtZ+gMWgpqm1GRLSpQ+3HXlj6myUd2qgvC480H1HEwl6oCJ8xX8eoJjrxWz6Jdysar
 wC3PYoaU+hJtFGTrsbHUb14ok1aEkNTxZeuzgOlqd4qrsAyK3SnUdPjUj9xBIfulKeb7NW
 NIvo1cR8iaBrb0HQUO/6xNImaQKQaaDla3EzLb2Ig/c4C04NSv8NPoBcVXl0xw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/next
Date: Sun, 29 Dec 2024 18:35:50 +0100
Message-ID: <20241229173626.44743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nyibmagaas7ta463t9r1w4eaejof8bf6
X-MBO-RS-ID: 7466f95571154c29182
X-Rspamd-Queue-Id: 4YLmcw0hvLz9sVN
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

The following changes since commit d580a013cca67a8115fb88d260498bde181709a1:

  Merge patch series "vbe: Series part E" (2024-12-27 15:16:39 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git next

for you to fetch changes up to 678f7c8f560775e0ac33300f54281dfcaa2e525a:

  net: rswitch: Implement C22 to C45 access (2024-12-29 16:55:32 +0100)

----------------------------------------------------------------
Marek Vasut (19):
      pinctrl: renesas: Convert to IS_ENABLED() macro
      ram: renesas: Add Renesas R-Car Gen4 DBSC5 driver
      arm64: dts: renesas: Add R8A779G0 V4H DBSC5 and RT-VRAM DT nodes
      arm64: renesas: Make stub PSCI implementation available on 64bit R-Car SoCs
      arm64: renesas: Deduplicate R-Car Gen4 board files
      arm64: renesas: Split R-Car Gen3 and Gen4 common board code
      arm64: renesas: Make bottom 128 MiB of DRAM available in EL3
      arm64: renesas: Add Renesas R-Car V4H SPL implementation
      arm64: renesas: Align configuration headers
      arm64: dts: renesas: Drop OF_UPSTREAM conversion remnant
      remoteproc: renesas: Add Renesas R-Car Gen4 remote processor driver
      arm64: dts: renesas: Add R8A779G0 V4H remoteproc DT node
      arm64: renesas: Enable CR52 remoteproc on R-Car R8A779G0 V4H
      net: rswitch: Replace enum rswitch_reg with plain macros
      net: rswitch: Fix up macro indent
      net: rswitch: Simplify code using clrsetbits_le32()
      net: rswitch: Fold MPSM C45 setting into rswitch_mii_access_c45()
      net: rswitch: Add PHY C22 access support
      net: rswitch: Implement C22 to C45 access

 arch/arm/dts/Makefile                              |    4 -
 arch/arm/dts/r8a779g0-u-boot.dtsi                  |  175 +-
 arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi       |    6 +
 arch/arm/mach-renesas/Kconfig.rcar4                |   10 +
 arch/arm/mach-renesas/Makefile                     |    4 +-
 arch/arm/mach-renesas/include/mach/boot0.h         |   66 +
 .../arm/mach-renesas/include/mach/rcar-gen3-base.h |    5 +
 .../{psci-r8a779a0.c => psci-rcar64.c}             |    3 +-
 board/beacon/beacon-rzg2m/Makefile                 |    2 +-
 board/hoperun/hihope-rzg2/Makefile                 |    2 +-
 board/renesas/condor/Makefile                      |    2 +-
 board/renesas/draak/Makefile                       |    2 +-
 board/renesas/eagle/Makefile                       |    2 +-
 board/renesas/ebisu/Makefile                       |    2 +-
 board/renesas/falcon/Makefile                      |    2 +-
 board/renesas/falcon/falcon.c                      |  102 -
 board/renesas/grayhawk/Makefile                    |    2 +-
 board/renesas/grayhawk/grayhawk.c                  |   66 -
 board/renesas/rcar-common/common.c                 |  200 +-
 board/renesas/rcar-common/gen3-common.c            |  185 +
 .../whitehawk.c => rcar-common/gen4-common.c}      |   36 +-
 board/renesas/rcar-common/gen4-spl.c               |  119 +
 board/renesas/salvator-x/Makefile                  |    2 +-
 board/renesas/spider/Makefile                      |    2 +-
 board/renesas/spider/spider.c                      |   66 -
 board/renesas/ulcb/Makefile                        |    2 +-
 board/renesas/v3hsk/Makefile                       |    2 +-
 board/renesas/v3msk/Makefile                       |    2 +-
 board/renesas/whitehawk/Makefile                   |    6 +-
 board/silinux/ek874/Makefile                       |    2 +-
 configs/r8a779g0_whitehawk_defconfig               |   40 +
 drivers/net/rswitch.c                              |  238 +-
 drivers/pinctrl/renesas/pfc.c                      |  128 +-
 drivers/ram/Kconfig                                |    1 +
 drivers/ram/renesas/Kconfig                        |    7 +
 drivers/ram/renesas/Makefile                       |    3 +
 drivers/ram/renesas/dbsc5/Makefile                 |    3 +
 drivers/ram/renesas/dbsc5/dbsc5.c                  |   79 +
 drivers/ram/renesas/dbsc5/dbsc5.h                  |   28 +
 drivers/ram/renesas/dbsc5/dram.c                   | 4532 ++++++++++++++++++++
 drivers/ram/renesas/dbsc5/qos.c                    |  636 +++
 drivers/ram/renesas/dbsc5/rtvram.c                 |   93 +
 drivers/remoteproc/Kconfig                         |    8 +
 drivers/remoteproc/Makefile                        |    1 +
 drivers/remoteproc/renesas_apmu.c                  |  266 ++
 include/configs/rcar-gen2-common.h                 |   10 +-
 include/configs/rcar-gen3-common.h                 |   19 +-
 include/configs/rcar-gen4-common.h                 |    8 +-
 48 files changed, 6539 insertions(+), 642 deletions(-)
 rename arch/arm/mach-renesas/{psci-r8a779a0.c => psci-rcar64.c} (92%)
 delete mode 100644 board/renesas/falcon/falcon.c
 delete mode 100644 board/renesas/grayhawk/grayhawk.c
 create mode 100644 board/renesas/rcar-common/gen3-common.c
 rename board/renesas/{whitehawk/whitehawk.c => rcar-common/gen4-common.c} (61%)
 create mode 100644 board/renesas/rcar-common/gen4-spl.c
 delete mode 100644 board/renesas/spider/spider.c
 create mode 100644 drivers/ram/renesas/Kconfig
 create mode 100644 drivers/ram/renesas/dbsc5/Makefile
 create mode 100644 drivers/ram/renesas/dbsc5/dbsc5.c
 create mode 100644 drivers/ram/renesas/dbsc5/dbsc5.h
 create mode 100644 drivers/ram/renesas/dbsc5/dram.c
 create mode 100644 drivers/ram/renesas/dbsc5/qos.c
 create mode 100644 drivers/ram/renesas/dbsc5/rtvram.c
 create mode 100644 drivers/remoteproc/renesas_apmu.c
