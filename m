Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03B7D10C07
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 02:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EBBD89079;
	Sun, 27 Oct 2024 03:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d1fyjfkp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="x+13AtEB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A81D588C10; Sun, 27 Oct 2024 03:21:37 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A838903B
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 03:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XbgHx5Lzbz9sy4;
 Sun, 27 Oct 2024 03:21:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729995693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Samb3tP23R8JoKjvQ7uzcWjdUK0QWebjArABM/T4l2k=;
 b=d1fyjfkpsArdaj8yLPdeuEYqYjl2roLsvycmd83VtyKnXInYrDBZoBI2+1Vdi2I00XDiEy
 Cv4p7+HxXqY+OfjXRVcty6p++QwixOvFtue1LkjUDrzxLVsYB1l4D+S8Z55IUt/NTA9X4u
 Uk1dmnkV6IF+FmkwukJyIb/TvJjvt1iZ3jyhtBXUQ9lncAvEAV5pR6IsVLpFZek7HQKUTC
 q+tKFZ0FzJUrNGiR8Yt+zwCMQ766K6x6P5fZ/vUAizv+WyGjHqCW1gQgTCeEunMBKt7MLD
 nfzefuBWieoFLR0orXss03LxrsuhaWWgZEdYhemZ4QT3uBz5Pifwl1PI9kxJ5g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729995691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Samb3tP23R8JoKjvQ7uzcWjdUK0QWebjArABM/T4l2k=;
 b=x+13AtEBHwm2yoXgWobg4khvf0v5UUWB33IekXdgFkaUY7Z2LJCroRoXu1udSdBWhOrTG3
 EKECmF013AnWQD7aV3PRwdwXvrnnpEEPaV2UfA+QDidnaz2KlQhlTNMaEAYEkawMFh+ARA
 9uyStvf/8iAiXgSEl/Rst2oSOZWiqFFelXPDNmM1+zPIPEIvfFqPPjUfMuRfHzMKNc8mNx
 oG9rffuNNrJo/Jzc13SwrNtSDibQBKIvVa/i7E89ZJzJ8a3p55nFk8f4hL5jUWpQnq8cKv
 8APy7D4gevtPipy6mJlAx8TgB7hExBip2glDtqMBpXSDax3k2+i+HcmWOYLQ7Q==
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
Subject: [PATCH v2 5/5] ARM: renesas: Deduplicate common Renesas defconfig
Date: Sun, 27 Oct 2024 03:20:07 +0100
Message-ID: <20241027022040.356716-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241027022040.356716-1-marek.vasut+renesas@mailbox.org>
References: <20241027022040.356716-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f33f0769e5e599b7e26
X-MBO-RS-META: wkdrymzs1smfkj7bggwzmmspit7e5psk
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

Deduplicate common Renesas defconfig by factoring out the common
parts into generic renesas_rcar_defconfig and including those using
the #include <configs/...> preprocessor macro in the current set of
board specific defconfigs. The preprocessor macro is applicable
to defconfigs as well.

This introduces no functional change, the resulting .config are
identical for all Renesas systems.

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
 configs/renesas_rcar.config   | 27 +++++++++++++++++++++++++++
 configs/renesas_rcar2.config  | 29 ++---------------------------
 configs/renesas_rcar64.config | 31 ++-----------------------------
 3 files changed, 31 insertions(+), 56 deletions(-)
 create mode 100644 configs/renesas_rcar.config

diff --git a/configs/renesas_rcar.config b/configs/renesas_rcar.config
new file mode 100644
index 00000000000..351803b743a
--- /dev/null
+++ b/configs/renesas_rcar.config
@@ -0,0 +1,27 @@
+CONFIG_CLK=y
+CONFIG_CLK_RENESAS=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
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
+CONFIG_RCAR_GPIO=y
+CONFIG_SCIF_CONSOLE=y
+CONFIG_SPI=y
+CONFIG_VERSION_VARIABLE=y
diff --git a/configs/renesas_rcar2.config b/configs/renesas_rcar2.config
index 77606a47082..74dfd41f1a3 100644
--- a/configs/renesas_rcar2.config
+++ b/configs/renesas_rcar2.config
@@ -1,56 +1,32 @@
+#include <configs/renesas_rcar.config>
+
 # CONFIG_CMD_IMI is not set
 # CONFIG_CMD_XIMG is not set
 # CONFIG_EFI_LOADER is not set
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_BOOTDELAY=3
-CONFIG_CLK=y
-CONFIG_CLK_RENESAS=y
-CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MII=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_SDRAM=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_USB=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4f000000
-CONFIG_DM_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_SPI=y
-CONFIG_DM_SPI_FLASH=y
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_ENV_SIZE=0x40000
-CONFIG_FIT=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_HUSH_PARSER=y
-CONFIG_MTD=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_OF_CONTROL=y
 CONFIG_PARTITION_UUIDS=y
 CONFIG_PCI=y
 CONFIG_PCI_RCAR_GEN2=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_PFC=y
-CONFIG_RCAR_GPIO=y
 CONFIG_RENESAS_SDHI=y
-CONFIG_SCIF_CONSOLE=y
 CONFIG_SH_QSPI=y
-CONFIG_SPI=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_I2C_RCAR_IIC=y
@@ -64,4 +40,3 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_USB_STORAGE=y
-CONFIG_VERSION_VARIABLE=y
diff --git a/configs/renesas_rcar64.config b/configs/renesas_rcar64.config
index 3e2cc50b02c..12211ae2810 100644
--- a/configs/renesas_rcar64.config
+++ b/configs/renesas_rcar64.config
@@ -1,41 +1,14 @@
-CONFIG_ARCH_RENESAS=y
-CONFIG_ARM=y
-CONFIG_CLK=y
-CONFIG_CLK_RENESAS=y
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
+#include <configs/renesas_rcar.config>
+
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_SPI=y
-CONFIG_DM_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_SPI=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_FIT=y
-CONFIG_HUSH_PARSER=y
-CONFIG_MTD=y
-CONFIG_OF_CONTROL=y
 CONFIG_PHY_ANEG_TIMEOUT=20000
-CONFIG_RCAR_GPIO=y
 CONFIG_REGMAP=y
 CONFIG_REMAKE_ELF=y
 CONFIG_RENESAS_RPC_SPI=y
-CONFIG_SCIF_CONSOLE=y
-CONFIG_SPI=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_SYSCON=y
 CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_SYS_MALLOC_BOOTPARAMS=y
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MONITOR_LEN=1048576
-CONFIG_VERSION_VARIABLE=y
-- 
2.45.2

