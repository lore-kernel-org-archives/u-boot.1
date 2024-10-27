Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E0DD10C07
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 02:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3075889067;
	Sun, 27 Oct 2024 03:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="O68IXQ/F";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nl5yJSuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78C1189060; Sun, 27 Oct 2024 03:21:37 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 502D288C10
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 03:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XbgHw0Kt2z9sSH;
 Sun, 27 Oct 2024 03:21:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729995692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N79HNVwkRZmoZsaI6I49smtfeTemCPTRIbQlCJoQR9k=;
 b=O68IXQ/Fi0oXCz0mCMTT8MRlWrRyiQQC7KkVLfLLRg5Fo5C5E21IV76zV/cRrWYm1QStFn
 qOPvLFpfhJKk66Vx6TOsQcYmnXkrkdO9QzuCA9Z7M2bJEmGiJEA5LbOknjAVYFyvTWog+M
 /n6Gy4uIApyuMfM9EeCxr3YDIxNoAKhHKX+HbEf0W05ClPqyA79thoiD0D0VfwhgHuRy1+
 ewtsWdd+j4JZHvDre3FsUACV/IzcMUZyh3dokOwwWU42lFxVDceiyNJB2DJ4H6bIa1w1Mq
 Dwu8Uuq0mRQAL4ZqlqPN0gqlLyXFJAjs8D4FDLqI7fp6+Cl2rA3fqJ/FoMcpDQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729995690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N79HNVwkRZmoZsaI6I49smtfeTemCPTRIbQlCJoQR9k=;
 b=nl5yJSuU9K9qwJLjJjtPTliyYvTBxrPs5OlxO9q65v3d6N6lLWN9L62khbqWirVgx6MPO6
 QWW1B1wDE5ZqOrSSr7p/CYM/UmZIs6NmnyQ3lH63nmOTNIBu4dYSh4eow8JZUcUPsQCB0B
 BymlVAae61PIWBE1YGGrkhnb88jWngCpd8bHx7cdCkR9QWlj2kBemQ7SjwIYWPMqzn6afV
 Su6g4becbH8z3BgW+iMRgcfUk8cuLqsQ7hY7wWUWqwpln8bKGZEP+aRalSByySXpjqXghQ
 oBpMhHU5D3GsTT5AQwY2S61UnBasH2Oz0cdgZeR4/2QCcJmrnuNndEVHKKMGyQ==
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
Subject: [PATCH v2 4/5] ARM: renesas: Deduplicate Renesas R-Car 64bit
 defconfigs
Date: Sun, 27 Oct 2024 03:20:06 +0100
Message-ID: <20241027022040.356716-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241027022040.356716-1-marek.vasut+renesas@mailbox.org>
References: <20241027022040.356716-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b6e88ad35635cbff806
X-MBO-RS-META: jipz7q36k5ohktkko3ws1rjr96fm1968
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
out the common parts into generic renesas_rcar64.config and including
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
V2: Rename common _defconfig to .config
---
 configs/renesas_rcar3.config  | 43 ++---------------------------------
 configs/renesas_rcar4.config  | 43 ++---------------------------------
 configs/renesas_rcar64.config | 41 +++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 82 deletions(-)
 create mode 100644 configs/renesas_rcar64.config

diff --git a/configs/renesas_rcar3.config b/configs/renesas_rcar3.config
index 9183abf8f8c..228e1b4c679 100644
--- a/configs/renesas_rcar3.config
+++ b/configs/renesas_rcar3.config
@@ -1,45 +1,6 @@
-CONFIG_ARCH_RENESAS=y
-CONFIG_ARM=y
+#include <configs/renesas_rcar64.config>
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
diff --git a/configs/renesas_rcar4.config b/configs/renesas_rcar4.config
index ebca0591838..87d6a60e56e 100644
--- a/configs/renesas_rcar4.config
+++ b/configs/renesas_rcar4.config
@@ -1,56 +1,17 @@
+#include <configs/renesas_rcar64.config>
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
diff --git a/configs/renesas_rcar64.config b/configs/renesas_rcar64.config
new file mode 100644
index 00000000000..3e2cc50b02c
--- /dev/null
+++ b/configs/renesas_rcar64.config
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

