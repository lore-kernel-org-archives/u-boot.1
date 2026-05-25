Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A3FCD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6AC98482F;
	Mon, 25 May 2026 04:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="ZaR0Dw6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9127583EF9; Mon, 25 May 2026 03:30:07 +0200 (CEST)
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D66B8039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779672604; x=1779931804;
 bh=ifypk4CTuA3e8ccbCYcoLwV4Gv8EK82pMGqMUqxKQH0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ZaR0Dw6OWMcHKoF1gpqFYE/mPyrH/0ANCioE/rwW7RnOPBrRAysg7CBs2p2BF7ATZ
 m/8Cv69dJm3cVZFc5/ZlNkB37npKyyonid642ChIltQdpty7uznXvkK06nl4Xe6Cjq
 ylVnpoEbtqV+vk2NdWO3/Chy900H3M1EsdF4Nd7i3CiaKto5BmWPxWDx0rIGNmWPn5
 82H3H4FzOZ9mlN8SXhd86Dsc9igSpnkVadFRP3nFwHmTYMY3hZPicEz0G/n4YFKKOr
 9CnQrAqxqXfj/pa55mAqXG4fHpeTaUxQ4IJC94ZazOf/WtgXDHuRa7/VZB4d9S4D0b
 p41MFXMH8d5zw==
Date: Mon, 25 May 2026 01:29:59 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 14/14] arm: rockchip: rk3576: enable TPL DRAM init in
 Kconfig and defconfig
Message-ID: <20260525012824.121-15-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: fde7ea9de67b2b854b1a6b3c3ea389edd24b6f19
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 25 May 2026 04:30:57 +0200
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

Wire up the BLOB-free TPL DRAM init for RK3576:

Kconfig (arch/arm/mach-rockchip/Kconfig):
  Add 11 imply lines to ROCKCHIP_RK3576 to pull in the necessary
  TPL subsystems: TPL_CLK, TPL_DM, TPL_OF_CONTROL, TPL_OF_PLATDATA,
  TPL_RAM, TPL_REGMAP, TPL_ROCKCHIP_COMMON_BOARD, TPL_SERIAL,
  TPL_SYSCON, TPL_TINY_MEMSET, ROCKCHIP_SDRAM_COMMON.

Kconfig (arch/arm/mach-rockchip/rk3576/Kconfig):
  Set TPL_TEXT_BASE =3D 0x3ff82000.  This is the start of the SRAM
  region available for TPL between the boost stub (0x3ff81000) and
  the SPL load address (0x3ffc0000), giving ~248 KB.

Kconfig (drivers/ram/rockchip/Kconfig):
  Add RAM_ROCKCHIP_LPDDR5 config option, required for RK3576 boards
  with LPDDR5 memory.

defconfig (configs/sige5-rk3576_defconfig):
  - Disable ROCKCHIP_EXTERNAL_TPL (use our open-source TPL instead)
  - Enable CONFIG_TPL=3Dy
  - Enable CONFIG_RAM_ROCKCHIP_LPDDR5=3Dy for the Sige5 board

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 arch/arm/mach-rockchip/Kconfig        | 11 +++++++++++
 arch/arm/mach-rockchip/rk3576/Kconfig |  3 +++
 configs/sige5-rk3576_defconfig        |  3 +++
 drivers/ram/rockchip/Kconfig          |  7 +++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfi=
g
index 108713488af..3f76bf7a92a 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -488,6 +488,17 @@ config ROCKCHIP_RK3576
 =09imply SPL_REGMAP
 =09imply SPL_SERIAL
 =09imply SPL_SYSCON
+=09imply ROCKCHIP_SDRAM_COMMON
+=09imply TPL_CLK
+=09imply TPL_DM
+=09imply TPL_OF_CONTROL
+=09imply TPL_OF_PLATDATA
+=09imply TPL_RAM
+=09imply TPL_REGMAP
+=09imply TPL_ROCKCHIP_COMMON_BOARD
+=09imply TPL_SERIAL
+=09imply TPL_SYSCON
+=09imply TPL_TINY_MEMSET
 =09imply ENV_RELOC_GD_ENV_ADDR
 =09imply SYSRESET
 =09help
diff --git a/arch/arm/mach-rockchip/rk3576/Kconfig b/arch/arm/mach-rockchip=
/rk3576/Kconfig
index f347caf8904..58f1eb9fcd6 100644
--- a/arch/arm/mach-rockchip/rk3576/Kconfig
+++ b/arch/arm/mach-rockchip/rk3576/Kconfig
@@ -1,5 +1,8 @@
 if ROCKCHIP_RK3576
=20
+config TPL_TEXT_BASE
+=09default 0x3ff82000
+
 config TARGET_ROC_PC_RK3576
 =09bool "Firefly ROC-RK3576-PC"
 =09help
diff --git a/configs/sige5-rk3576_defconfig b/configs/sige5-rk3576_defconfi=
g
index be46f63798b..38148ccab09 100644
--- a/configs/sige5-rk3576_defconfig
+++ b/configs/sige5-rk3576_defconfig
@@ -4,6 +4,9 @@ CONFIG_COUNTER_FREQUENCY=3D24000000
 CONFIG_ARCH_ROCKCHIP=3Dy
 CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3576-armsom-sige5"
 CONFIG_ROCKCHIP_RK3576=3Dy
+# CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
+CONFIG_TPL=3Dy
+CONFIG_RAM_ROCKCHIP_LPDDR5=3Dy
 CONFIG_SYS_LOAD_ADDR=3D0x40c00800
 CONFIG_DEBUG_UART_BASE=3D0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=3D24000000
diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index d707d09c1c8..51740ed1d12 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -48,4 +48,11 @@ config RAM_ROCKCHIP_LPDDR4
 =09  This enables LPDDR4 sdram code support for the platforms based
 =09  on Rockchip SoCs.
=20
+config RAM_ROCKCHIP_LPDDR5
+=09bool "LPDDR5 support for Rockchip SoCs"
+=09help
+=09  This enables LPDDR5 sdram code support for the platforms based
+=09  on Rockchip SoCs. Required for RK3576 boards with LPDDR5 memory
+=09  (e.g. Flipper One with 8 GB LPDDR5).
+
 endif # RAM_ROCKCHIP
--=20
2.45.1.windows.1


