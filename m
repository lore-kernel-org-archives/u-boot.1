Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE4CC25B77
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E880886C8;
	Sun, 19 May 2024 14:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="nUfhlsx4";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="IUmIOa4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 877C6886C8; Sun, 19 May 2024 14:57:47 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A382886B9
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.west.internal (Postfix) with ESMTP id 53F6418000B4;
 Sun, 19 May 2024 08:57:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sun, 19 May 2024 08:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716123461;
 x=1716209861; bh=CFn8VOPLiJLHQnyJKcRYngTmxQ6+CvlN42F1m3+zgPQ=; b=
 nUfhlsx40WsGHSINPf3zSuwYPgCsvwBT4Wez2uFcSDRVzbIRJ9objeRRnnV7kLuy
 D7A5fFFX9NWUdtnlSzoYqw+/UEPYA30bpyTahRS5NH/gYNOR+SMwihpppPvNRnB3
 55a/XM79ih2PHk6o/g+PtMJn2sm3PgfPx+Ck6GpBUsD/M3jEldUh+d8uGZ4uHvYA
 MpjpTO/OYxFaKUBFkxaz8VNNbhKEdt2rnhU/e+iEzvDmPFawC1KA0NSdzugua0ZY
 sbMBQWr+cln29x2k0Zp3OKmyUND3XHz6WJ4k3Mq3BekZLBACBjbsC1GF5maMVuw6
 joXs+sntHIs6xgg+u3K+XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716123461; x=
 1716209861; bh=CFn8VOPLiJLHQnyJKcRYngTmxQ6+CvlN42F1m3+zgPQ=; b=I
 UmIOa4rWJG2MVjskZM5MoL6qhJMKhHk0kghB23r/A/SHp10UBxZD2bRogiZW+9ZM
 0llfWz/9ZwPfgMMd7ehMDe6lV52GckmFH5rDS3WETfpn3GT5m6Na52aBy7Rlqlu9
 2nIMTjOELGOXxXTLzsTdBC+s//XEbd8uaVHKGHPLtmwECdzh0RrjoGSq4283GGxt
 RMdH4sBRgbte3aG+pO6afzL5kVj37nXD7y3fN+k2GwEqNCKlGa0bGdehn1G8SUHH
 YKd1lcHlU6nN36MyhFH8VtnZYjB/vnwQQCS6pTEGMqjqlNx0PoQTmcrtdgSvPnrf
 gMWiG9EPYYvkRuTa0F/0A==
X-ME-Sender: <xms:RfdJZvhSrSmu50AP7p_IDeuVdK8JCS_w6gwXnu8RNmqinla2RrQSJQ>
 <xme:RfdJZsA_7Utq1LbyUkwrXVyFXrnD_YgLuL2RGQZvtru61Hs8M-JDjvboJaCyReYLW
 uDOY-lM3xu4OAHePe4>
X-ME-Received: <xmr:RfdJZvH8qrcnrPM76TadSr_OCXTgZUvcziSjBTcWJswiRCh_CLrss-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:RfdJZsSkHUQo-WlESqfAtVogun0AkrlOwt6b_FIbHHz-cDYU1D_LCQ>
 <xmx:RfdJZswDm7vi3uxmikq11ZN5HL29NBI8rVvCsHQDQLqJlO8Py14EVw>
 <xmx:RfdJZi6CYA_XNwJLSQvt3sFx_InEB_CPSCClxxaB0_Qk6QpqHnFSIw>
 <xmx:RfdJZhxTEppwYytbRvNtnTanEwfP9-vl91n556OFtylFn8Xu-tF33Q>
 <xmx:RfdJZgmEkFtT4kxrFY9OxWXvgeztDXnpwQ2CcMREpm_r9gPNyFiTcYFu>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 08:57:39 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 13:56:58 +0100
Subject: [PATCH 13/13] qemu-arm: Big endian enablement for arm64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-aarch64-be-v1-13-75cc328eddfa@flygoat.com>
References: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
In-Reply-To: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
To: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4142;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=8cCeu59DEKbtNtqJzfpV7RXifJZBZKOgfxiz27RRD/U=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTP7wLRkv0uiW5nFWJUfF5JKIldveyysPBL+zm+w35rV
 sju+nauo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACZyOoHhv8PcqyZ5v4LC65Ue
 7DJc8dBavdJA8vDOlXGhVtfe7p0lcImRYbfxpbv1+kvtHt4/qq23Oezqkqe5X2bPKtocNv2o0Wn
 OLSwA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Select a few config option and generate a new defconfig for
big endian arm64.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 board/emulation/qemu-arm/Kconfig     |  2 +
 board/emulation/qemu-arm/MAINTAINERS |  1 +
 configs/qemu_arm64be_defconfig       | 71 ++++++++++++++++++++++++++++++++++++
 doc/board/emulation/qemu-arm.rst     |  7 +++-
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
index e21c135e86fa..4c98340a62f4 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -5,8 +5,10 @@ config TEXT_BASE
 
 config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
+	select ARMV8_RESET_SET_ENDIAN if ARM64
 	select QFW if ACPI
 	select QFW_MMIO if CMD_QFW
+	select SUPPORT_BIG_ENDIAN if ARM64
 	imply VIRTIO_MMIO
 	imply VIRTIO_PCI
 	imply VIRTIO_NET
diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index 5154262f29ea..9384b1003d2c 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -6,3 +6,4 @@ F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
 F:	configs/qemu_arm_defconfig
 F:	configs/qemu_arm64_defconfig
+F:	configs/qemu_arm64be_defconfig
diff --git a/configs/qemu_arm64be_defconfig b/configs/qemu_arm64be_defconfig
new file mode 100644
index 000000000000..af05f484036d
--- /dev/null
+++ b/configs/qemu_arm64be_defconfig
@@ -0,0 +1,71 @@
+CONFIG_ARM=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_QEMU=y
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_SECT_SIZE=0x40000
+CONFIG_DEFAULT_DEVICE_TREE="qemu-arm64"
+CONFIG_DEBUG_UART_BASE=0x9000000
+CONFIG_DEBUG_UART_CLOCK=0
+CONFIG_ARMV8_CRYPTO=y
+CONFIG_SYS_LOAD_ADDR=0x40200000
+CONFIG_ENV_ADDR=0x4000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_SYS_BIG_ENDIAN=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_FIT_BEST_MATCH=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_PREBOOT=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_PCI_INIT_R=y
+CONFIG_CMD_SMBIOS=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_TPM=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_ENV_IS_IN_FLASH=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_DFU_TFTP=y
+CONFIG_DFU_MTD=y
+CONFIG_DFU_RAM=y
+# CONFIG_MMC is not set
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_NOR_FLASH=y
+CONFIG_FLASH_SHOW_PROGRESS=0
+CONFIG_CFI_FLASH=y
+CONFIG_CFI_FLASH_USE_WEAK_ACCESSORS=y
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
+CONFIG_FLASH_CFI_MTD=y
+CONFIG_SYS_FLASH_CFI=y
+CONFIG_SYS_MAX_FLASH_SECT=256
+CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
+CONFIG_E1000=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_SCSI=y
+CONFIG_DEBUG_UART_PL011=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_TPM2_MMIO=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_PCI=y
+CONFIG_SEMIHOSTING=y
+CONFIG_TPM=y
diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index 1c91c7f3ac67..70108f98c759 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -38,6 +38,11 @@ Set the CROSS_COMPILE environment variable as usual, and run:
     make qemu_arm64_defconfig
     make
 
+- For AArch64 Big Endian::
+
+    make qemu_arm64be_defconfig
+    make
+
 Running U-Boot
 --------------
 The minimal QEMU command line to get U-Boot up and running is:
@@ -46,7 +51,7 @@ The minimal QEMU command line to get U-Boot up and running is:
 
     qemu-system-arm -machine virt -nographic -bios u-boot.bin
 
-- For AArch64::
+- For AArch64 (both endian)::
 
     qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 -bios u-boot.bin
 

-- 
2.43.0

