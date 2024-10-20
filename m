Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1522DD3C92A
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 17:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD0E888F3F;
	Sun, 20 Oct 2024 19:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Yp6zjEtg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sQbjuQ2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6023388EC9; Sun, 20 Oct 2024 19:28:15 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6627E88E6B
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 19:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XWllK10QSz9sZ6;
 Sun, 20 Oct 2024 19:28:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729445293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+wDHr/fmMVdeNSl8a73zmwIn7hiFNtMO1Kj7fREIlw=;
 b=Yp6zjEtgbiDjl3Gj60WD3NUGBdq481kKA7DLUyAFwcf+71oKXs8uPIoXie8KFaa0yLSJjl
 WE6OVyeB/Tp1Hi+KuwTEFbpCZHbzp5hII6r86eCpheO/zPnhIHSqSk6Span3HmBAZ1dAZG
 FIPxfwOzIIFfPJGnhBzh0QJj1EhvfytLTua1NuU3+7Z4h/Pcn9b+hu39WjV2cRPQl0QZRg
 e4gSj32yF356E0lWv3x96AK958gNyqRf7dp3etmnUPODT8K2Zv8xzUgX/+xN0n6+mBGgO1
 tUsT/GGD237ZGCXJZ3sYosoXlHRMTGCr+BQv0NkXP7MHr9UidoGd1ZjBq7vQvg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729445291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+wDHr/fmMVdeNSl8a73zmwIn7hiFNtMO1Kj7fREIlw=;
 b=sQbjuQ2rkBPveGdxH921Ma75cBSDSeb13NskLOweXTQ1H4J3H1Zx7t9WmHMb1iR4Yem7XV
 B9eeOuKdUJx+eGDIV7va+APRCZ2FIRTPK62FZr7qznomHeqGRxAizvPxpyIIWqXPJR9Ep9
 EKgLNzVZtyoUrexOO63Vpz9nBkE8yP8AonjMfDq8blHbsJhm1lUnu/96FC+N8bIpNWgZF7
 K3pYYRjMj+tTUy+uSYjX8L4OKw3SJkyryjQ6UQqByuxMmhAQwhA34Be6Mmv11d9e0kRdRw
 2pMMGUD6E65+lSgaEtlvXjmlYgvDErbG3kiSBYdWJVYj7dh8huNm+MLsCkk6eQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] ARM: renesas: Deduplicate Renesas R-Car 64bit defconfigs
Date: Sun, 20 Oct 2024 19:27:16 +0200
Message-ID: <20241020172734.1187843-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241020172734.1187843-1-marek.vasut+renesas@mailbox.org>
References: <20241020172734.1187843-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ho9j5n4oxj96m8ujbaa71kb8m7a4qq67
X-MBO-RS-ID: 6bcf53f36f308856851
X-Rspamd-Queue-Id: 4XWllK10QSz9sZ6
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

Deduplicate defconfigs for all Renesas R-Car 64bit systems by factoring
out the common parts into generic renesas_rcar64_defconfig and including
those using the #include <configs/...> preprocessor macro in the current
set of board specific defconfigs. The preprocessor macro is applicable
to defconfigs as well.

This introduces no functional change, the resulting .config is identical
for all Renesas R-Car 64bit systems.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Cogent Embedded, Inc." <source@cogentembedded.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/renesas_rcar3_defconfig  | 43 ++------------------------------
 configs/renesas_rcar4_defconfig  | 43 ++------------------------------
 configs/renesas_rcar64_defconfig | 41 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 82 deletions(-)
 create mode 100644 configs/renesas_rcar64_defconfig

diff --git a/configs/renesas_rcar3_defconfig b/configs/renesas_rcar3_defconfig
index 28f423bc902..b5e2748d5d7 100644
--- a/configs/renesas_rcar3_defconfig
+++ b/configs/renesas_rcar3_defconfig
@@ -1,46 +1,7 @@
-CONFIG_ARCH_RENESAS=y
-CONFIG_ARM=y
+#include <configs/renesas_rcar64_defconfig>
+
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
-CONFIG_CLK=y
-CONFIG_CLK_RENESAS=y
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_SPI=y
-CONFIG_DM_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_SPI=y
-CONFIG_DM_SPI_FLASH=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_FIT=y
-CONFIG_HUSH_PARSER=y
-CONFIG_MTD=y
-CONFIG_OF_CONTROL=y
-CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_RCAR_GEN3=y
-CONFIG_RCAR_GPIO=y
-CONFIG_REGMAP=y
-CONFIG_REMAKE_ELF=y
-CONFIG_RENESAS_RPC_SPI=y
-CONFIG_SCIF_CONSOLE=y
-CONFIG_SPI=y
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_SYSCON=y
-CONFIG_SYS_LOAD_ADDR=0x58000000
-CONFIG_SYS_MALLOC_BOOTPARAMS=y
-CONFIG_SYS_MALLOC_LEN=0x4000000
-CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SYS_PBSIZE=2068
-CONFIG_VERSION_VARIABLE=y
diff --git a/configs/renesas_rcar4_defconfig b/configs/renesas_rcar4_defconfig
index edc7af8ce4e..7a5fa72fbdf 100644
--- a/configs/renesas_rcar4_defconfig
+++ b/configs/renesas_rcar4_defconfig
@@ -1,57 +1,18 @@
+#include <configs/renesas_rcar64_defconfig>
+
 # CONFIG_PSCI_RESET is not set
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RENESAS=y
-CONFIG_ARM=y
 CONFIG_BOOTARGS="root=/dev/nfs rw nfsroot=192.168.0.1:/export/rfs ip=192.168.0.20"
-CONFIG_CLK=y
-CONFIG_CLK_RENESAS=y
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MII=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_SPI=y
 CONFIG_DM_ETH_PHY=y
-CONFIG_DM_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_SPI=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_FIT=y
-CONFIG_HUSH_PARSER=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MTD=y
-CONFIG_OF_CONTROL=y
-CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_RCAR_GEN4=y
-CONFIG_RCAR_GPIO=y
-CONFIG_REGMAP=y
-CONFIG_REMAKE_ELF=y
-CONFIG_RENESAS_RPC_SPI=y
 CONFIG_RENESAS_SDHI=y
-CONFIG_SCIF_CONSOLE=y
-CONFIG_SPI=y
 CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_SYSCON=y
 CONFIG_SYS_I2C_RCAR_I2C=y
-CONFIG_SYS_LOAD_ADDR=0x58000000
-CONFIG_SYS_MALLOC_BOOTPARAMS=y
-CONFIG_SYS_MALLOC_LEN=0x4000000
-CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_VERSION_VARIABLE=y
diff --git a/configs/renesas_rcar64_defconfig b/configs/renesas_rcar64_defconfig
new file mode 100644
index 00000000000..3e2cc50b02c
--- /dev/null
+++ b/configs/renesas_rcar64_defconfig
@@ -0,0 +1,41 @@
+CONFIG_ARCH_RENESAS=y
+CONFIG_ARM=y
+CONFIG_CLK=y
+CONFIG_CLK_RENESAS=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_SPI=y
+CONFIG_DM_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SPI=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_FIT=y
+CONFIG_HUSH_PARSER=y
+CONFIG_MTD=y
+CONFIG_OF_CONTROL=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
+CONFIG_RCAR_GPIO=y
+CONFIG_REGMAP=y
+CONFIG_REMAKE_ELF=y
+CONFIG_RENESAS_RPC_SPI=y
+CONFIG_SCIF_CONSOLE=y
+CONFIG_SPI=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_SYSCON=y
+CONFIG_SYS_LOAD_ADDR=0x58000000
+CONFIG_SYS_MALLOC_BOOTPARAMS=y
+CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_SYS_MONITOR_LEN=1048576
+CONFIG_VERSION_VARIABLE=y
-- 
2.45.2

