Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E8DCA5FE4
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 04:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B72C540AFD;
	Sun,  4 Oct 2026 04:07:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xaZNKZdiARQt; Sun,  4 Oct 2026 04:07:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4297540AE4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791086847;
	b=fFzAaKtDnkYavUO9dW0fFTyAmiSEzOnXOfCuCR9ivGWzX1bmeK1DdblxvpLzbLZfFqyn
	 dTTyh7LEWo0m3gavLkWCjhnM3aYM85d7xcc2o+3k3r5fflUX2tX4Fa8Zxzndg2Z9ZGpih
	 Q71m6ZLo4ZxVqVkwijPUbi04alskkeD+kKJ9vPh7+dUjigoJ+CSK/w+klbwU8PEPrQFdv
	 b2igQq8iNad6gHVeJ34LfhKT5OZMGsSc/i6sI4frx14Z8rTeBLkBlHfW9Rlz9a9kkknTc
	 zDnImm65HBATcDh0auIMnNXRDpVH/A5+PJvx8x9eMMoHMc6WIPauDsyY+kT+4J1TbeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791086847;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0/7XV+ZyFSaayRLKsRWBJJQrEXgmCl6UXSVs+dar/hA=;
	b=bRdKMCWIcONz/BCVoUrBUteMPuA7Cav5WyCFTnNxVJ/htz6oJETj8Ge4J+oSP7XFhO6+
	 mZ0/kZPS6ZBG6OOhYdQzkhwnaVWQQbE/A6Fl+1YqXsEGh5I+9nb/yCcJGwbGW2zjmZkLr
	 qi4PFbMjRgEeNpbS3xU8v/VH65VynqnePVQeUxcnDVefAgh2xi737vGx5Nbx/G8QKRmAz
	 gjrEvqnA8D3hO0lXjZ99WkFXmf5xSXVjAvK/jT+I/Lr9tRMKRwGbENpqawAIFSumwQndy
	 OD5t/kYcGt8tR5hSbDtd8bOpOhKIDOF9XbDrm/RNA3cVtA9KVW90yV8G7dRL1QpbqWQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791086847;
	bh=0/7XV+ZyFSaayRLKsRWBJJQrEXgmCl6UXSVs+dar/hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oBegFuUOQpal5peIqcRrnwoBP0v9JQIUQsh4QT7xxuVU6oBc1kCn0sEtJA39Vg80l
	 LXbiasO6CvyBnab1Wd33fB7QTbOcueHfzykjxfqmNFJEDg0Lw0iAgoho+Q5lJBi9PQ
	 7B5NdNqlEX3yuCmGP6/xyE9jfASA31RctB17yhIKHjYCI3nBGhvKZRvknrmF6KqgJs
	 feJwzPFIXDxQruDBo7i/Y6zJxDVnzAtrZrmTMlYUDfKtlrMB6TjHn8L6Jj0BCxwwLB
	 eiAokmOF62xopc1VjqqY0sQDiE5aWIIj97DSxT7JwoWjRnPeFuhXGt1SIYHaPnAiVU
	 nTRvTC3hgUqfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4297540AE4;
	Sun,  4 Oct 2026 04:07:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A7951D2
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50D574008E
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NleaTP4Teu27 for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 04:07:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D367F40068
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791086837;
 b=RkXY50BqEbq1jCBqaYPPGrN9LLh/gY4GydKukxaFyE0HGrJYfPbZ1pd4RBTHHyret8BX
 QWRgJsSw44HneDgVqqQsb4keiPHLnl2KxE0WLQIID4nG4dB1nKDKgdJIUlOUOEHYAxHyC
 FxRg64KQzRSq6WoDCMt5fsunMh5eUi9Wgf8A8abMvxiZtspUS8rXUAbirBZF2aKAatqiR
 veWp0SSMnpKaWwcvCCd4Y9Fcx2IjjbcNlBJJLdmU5875IrcfgbAp3tf13usUI6D4lkwDX
 6TrRgBx98rKxDU+B8K+GXHvO9rz5x2Jkx5xNUqYRfIuIoDBaytF0eGoxztsBvypImbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791086837;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=0/7XV+ZyFSaayRLKsRWBJJQrEXgmCl6UXSVs+dar/hA=;
 b=ap1PCMdc1nyhuie2h+qyO8fU7I1Q3imgp4bFlIOyzPs3wQxIjxMA8S4ALIc/jphAhLe7
 MYz5HtFzsdUUvgUA6qp3wmN2UlsMbKEF5gS6pWzw1evgebt2Gly9u+XN4eQ9liH3PAJ3z
 X2/CF4pMYKvOlsFPBWQKgKB+4XKUa70rPG4puwHGkc6VQPTLd+Gt+QebcGaBVsy1FuqnJ
 yWRAQ7TrnUrB3X4yPVwlbI2B6JW7nMiSGKALvj7pa+JB0azqtt7OiLl9bLMZdNB7Lth6Y
 SjvA1nvrpUf2o4HPcweqcT6pu4MaRiy1xRafNU2eOS3536FToYVx5ZNoF4NJmNmMNog==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=CP7NAwYW; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=CP7NAwYW
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D367F40068
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 62195107A36; Sun, 04 Oct 2026 06:07:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791086834; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=0/7XV+ZyFSaayRLKsRWBJJQrEXgmCl6UXSVs+dar/hA=;
 b=CP7NAwYWe1nIjNYNkyUOgjeokqgt4AXlM6SbK3RViBMjkf8/etsPGJSY33EXlaqjCjFnaA
 1uBXV2kZXA1DVzn5UCozQ0jC7I8kDZr41m+2s21uApNzd2OA2x42jaPmz22ybbvdf+TwqT
 6nehmio0p6Ph1NRvy4wdz08PpuOHAuOLu+/jEz535RAkN/xkn5dVM9FpMPM/Mz8xXOmre4
 Grf11g+lpEWqzk44onbUiKI7S4Ta6iIGWzsT0K6ueuK/g//oWRCXSet8pPq7f2M2x/wLEc
 7SeQEe41N1GfhJSbOMlBNMxT00D6t/F2Cmh4wqVIKoRNs39dB0jRpKEl+03rTw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Heiko Schocher <hs@nabladev.com>, Anshul Dalal <anshuld@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 5/5] test: dm: add a test for the Microchip 23LCV1024 SPI
 SRAM
Date: Sun,  4 Oct 2026 06:06:49 +0200
Message-ID: <20261004040657.3156402-6-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004040657.3156402-1-hs@nabladev.com>
References: <20261004040657.3156402-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Emulate the device on a second sandbox SPI bus and exercise the driver
through the MTD layer.

The emulation implements byte, page and sequential operation and
advances the internal address counter the way the data sheet describes
for each of them. A transfer running past the 32 byte page of the
device therefore only comes back unharmed once the driver has selected
sequential operation, which is what its probe is for. The test asserts
that mode directly as well, so a failure says which of the two went
wrong.

Test also if erase returns -EOPNOTSUPP and data is not touched.

A second test gives the device two partitions in the test device tree
and writes through the one whose offset is on no erase block boundary,
which a device without an erase size does not have to care about.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
checkpatch asks for a blank line after the two test functions, before
the DM_TEST() that registers them. But in test/dm/ all over is without
a blank line, so ignore this warning.

Changes in v2:
Added comments from Simon:
- The test drives the device through the MTD layer instead of the
  spi_flash uclass.
- Uses sandbox_spi_get_emul() rather than reaching into state->spi[][].
- Added a spi1 alias so that dev_seq() of the bus does not depend on
  probe order.
- The erase part checks for -EOPNOTSUPP now. The v1 comment about
  covering more than one staging step went with the erase loop.
- The emulation lives in its own node with its own compatible, which is
  what patch 4 resolves the phandle to.
- Added the emulation and the test to the MAINTAINERS entry.
Found while Stefan Bigler tested the series on hardware:
- Added partitions to the device in the test device tree and a second
  test that writes through one of them, which is what "mtd list" on his
  board fell over.

 MAINTAINERS                     |   2 +
 arch/sandbox/dts/test.dts       |  37 +++++++
 arch/sandbox/include/asm/test.h |   8 ++
 configs/sandbox_defconfig       |   1 +
 drivers/mtd/Kconfig             |   9 ++
 drivers/mtd/Makefile            |   1 +
 drivers/mtd/spi_ram_sandbox.c   | 190 ++++++++++++++++++++++++++++++++
 drivers/spi/Kconfig             |   2 +-
 test/dm/Makefile                |   1 +
 test/dm/spi_ram.c               | 167 ++++++++++++++++++++++++++++
 10 files changed, 417 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/spi_ram_sandbox.c
 create mode 100644 test/dm/spi_ram.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1669972e724..7a03e075e5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1653,6 +1653,8 @@ SPI RAM
 M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 F:	drivers/mtd/spi_ram.c
+F:	drivers/mtd/spi_ram_sandbox.c
+F:	test/dm/spi_ram.c
 
 SPI-NOR
 M:	Vignesh R <vigneshr@ti.com>
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index a5d8d3977a0..39f7cedda41 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -57,6 +57,7 @@
 		rtc0 = &rtc_0;
 		rtc1 = &rtc_1;
 		spi0 = "/spi@0";
+		spi1 = "/spi@1";
 		testfdt6 = "/e-test";
 		testbus3 = "/some-bus";
 		testfdt0 = "/some-bus/c-test@0";
@@ -1644,6 +1645,42 @@
 		};
 	};
 
+	spi@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1 1>;
+		compatible = "sandbox,spi";
+
+		sram@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0>;
+			compatible = "microchip,mchp23lcv1024";
+			spi-max-frequency = <20000000>;
+			sandbox,emul = <&spi_ram_emul>;
+
+			spi_ram_emul: emul {
+				compatible = "sandbox,spi-ram-emul";
+			};
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					label = "spi-ram-part0";
+					reg = <0x0 0xa000>;
+				};
+
+				partition@a000 {
+					label = "spi-ram-part1";
+					reg = <0xa000 0x1000>;
+				};
+			};
+		};
+	};
+
 	syscon0: syscon@0 {
 		compatible = "sandbox,syscon0";
 		reg = <0x10 16>;
diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index 0438790028b..9f25cc690cf 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -251,6 +251,14 @@ uint sandbox_spi_get_mode(struct udevice *dev);
  */
 uint sandbox_spi_get_wordlen(struct udevice *dev);
 
+/**
+ * sandbox_spi_ram_is_sequential() - check the mode of the emulated SPI SRAM
+ *
+ * @dev:	the emulation device
+ * Return: true if the MODE register selects sequential operation
+ */
+bool sandbox_spi_ram_is_sequential(struct udevice *dev);
+
 /**
  * sandbox_get_pch_spi_protect() - Get the PCI SPI protection status
  *
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 0210d54f462..264f57418c8 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -261,6 +261,7 @@ CONFIG_MMC_SANDBOX=y
 CONFIG_MMC_SDHCI=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_RAM=y
+CONFIG_SPI_RAM_SANDBOX=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_MAX_NAND_DEVICE=8
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 437e6ebd196..bfd241edfc3 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -208,6 +208,15 @@ config SPI_RAM
 
 	  If unsure, say N
 
+config SPI_RAM_SANDBOX
+	bool "Sandbox emulation of the Microchip 23LCV1024"
+	depends on SANDBOX && SPI_RAM
+	help
+	  Emulate a 23LCV1024 on the sandbox SPI bus, so that the driver can
+	  be exercised by the unit tests. The emulation implements all three
+	  operating modes of the device, which is what makes it able to tell
+	  whether the driver selects the right one.
+
 config RENESAS_RPC_HF
 	bool "Renesas R-Car Gen3 RPC HyperFlash driver"
 	depends on RCAR_64 && DM_MTD
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index a19498da920..e61580f95de 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -14,6 +14,7 @@ mtd-$(CONFIG_FLASH_CFI_LEGACY) += jedec_flash.o
 mtd-$(CONFIG_STM32_FLASH) += stm32_flash.o
 mtd-$(CONFIG_RENESAS_RPC_HF) += renesas_rpc_hf.o
 mtd-$(CONFIG_SPI_RAM) += spi_ram.o
+mtd-$(CONFIG_SPI_RAM_SANDBOX) += spi_ram_sandbox.o
 mtd-$(CONFIG_HBMC_AM654) += hbmc-am654.o
 
 # U-Boot build
diff --git a/drivers/mtd/spi_ram_sandbox.c b/drivers/mtd/spi_ram_sandbox.c
new file mode 100644
index 00000000000..520c3077a5e
--- /dev/null
+++ b/drivers/mtd/spi_ram_sandbox.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sandbox emulation of the Microchip 23LCV1024 SPI SRAM
+ *
+ * Copyright (C) 2026 Heiko Schocher, Nabla Software Engineering <hs@nabladev.com>
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <spi.h>
+#include <asm/test.h>
+#include <linux/bitops.h>
+#include <linux/sizes.h>
+
+/* Instruction set of the 23x series serial SRAMs */
+#define MCHP23_CMD_WRITE_STATUS	0x01
+#define MCHP23_CMD_WRITE	0x02
+#define MCHP23_CMD_READ		0x03
+
+/* MODE register, bits 7:6 select byte, page or sequential operation */
+#define MCHP23_MODE_MASK	GENMASK(7, 6)
+#define MCHP23_MODE_BYTE	0x00
+#define MCHP23_MODE_SEQ		BIT(6)
+#define MCHP23_MODE_PAGE	BIT(7)
+
+#define MCHP23_PAGE_SIZE	32
+#define MCHP23_ADDR_LEN		3
+#define MCHP23_SIZE		SZ_128K
+
+/**
+ * struct sandbox_spi_ram_priv - state of the emulated SRAM
+ *
+ * @data:	the emulated memory array
+ * @mode:	contents of the MODE register, see MCHP23_MODE_*
+ * @cmd:	opcode of the command being processed
+ * @addr:	address that command started at
+ */
+struct sandbox_spi_ram_priv {
+	u8 *data;
+	u8 mode;
+	u8 cmd;
+	u32 addr;
+};
+
+bool sandbox_spi_ram_is_sequential(struct udevice *dev)
+{
+	struct sandbox_spi_ram_priv *priv = dev_get_priv(dev);
+
+	return priv->mode == MCHP23_MODE_SEQ;
+}
+
+/**
+ * sandbox_spi_ram_addr() - address of the n-th byte of the current command
+ *
+ * The internal address counter of the device is advanced differently in
+ * each of the three operating modes, which is what makes the mode matter
+ * for transfers of more than one byte.
+ *
+ * @priv:	state of the emulated SRAM
+ * @n:		position of the byte within the data phase
+ * Return: index into the emulated memory array
+ */
+static u32 sandbox_spi_ram_addr(struct sandbox_spi_ram_priv *priv, uint n)
+{
+	switch (priv->mode) {
+	case MCHP23_MODE_SEQ:
+		/* The counter runs across the whole array and wraps around */
+		return (priv->addr + n) % MCHP23_SIZE;
+	case MCHP23_MODE_PAGE:
+		/* The counter wraps around within the addressed page */
+		return (priv->addr & ~(MCHP23_PAGE_SIZE - 1)) |
+		       ((priv->addr + n) & (MCHP23_PAGE_SIZE - 1));
+	default:
+		/* Byte operation transfers one byte and gets no further */
+		return priv->addr;
+	}
+}
+
+/*
+ * The command and the data it carries arrive as two transfers, the first
+ * one holding the opcode and, for a read or a write, the address.
+ */
+static int sandbox_spi_ram_xfer(struct udevice *dev, unsigned int bitlen,
+				const void *dout, void *din, unsigned long flags)
+{
+	struct sandbox_spi_ram_priv *priv = dev_get_priv(dev);
+	const u8 *out = dout;
+	u8 *in = din;
+	uint bytes = bitlen / 8;
+	uint n;
+
+	if (bitlen % 8) {
+		log_err("transfer of %u bits is not a whole number of bytes\n",
+			bitlen);
+		return -EINVAL;
+	}
+
+	if (flags & SPI_XFER_BEGIN) {
+		if (!out || !bytes)
+			return -EINVAL;
+
+		priv->cmd = out[0];
+
+		switch (priv->cmd) {
+		case MCHP23_CMD_WRITE_STATUS:
+			if (bytes < 2)
+				return -EINVAL;
+			priv->mode = out[1] & MCHP23_MODE_MASK;
+			break;
+		case MCHP23_CMD_READ:
+		case MCHP23_CMD_WRITE:
+			if (bytes < 1 + MCHP23_ADDR_LEN)
+				return -EINVAL;
+			priv->addr = (out[1] << 16) | (out[2] << 8) | out[3];
+			if (priv->addr >= MCHP23_SIZE)
+				return -EINVAL;
+			break;
+		default:
+			log_err("unknown command %#x\n", priv->cmd);
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	for (n = 0; n < bytes; n++) {
+		u32 addr = sandbox_spi_ram_addr(priv, n);
+
+		switch (priv->cmd) {
+		case MCHP23_CMD_READ:
+			if (!in)
+				return -EINVAL;
+			in[n] = priv->data[addr];
+			break;
+		case MCHP23_CMD_WRITE:
+			if (!out)
+				return -EINVAL;
+			priv->data[addr] = out[n];
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int sandbox_spi_ram_probe(struct udevice *dev)
+{
+	struct sandbox_spi_ram_priv *priv = dev_get_priv(dev);
+
+	/* The device comes out of reset in byte operation */
+	priv->mode = MCHP23_MODE_BYTE;
+
+	priv->data = calloc(1, MCHP23_SIZE);
+	if (!priv->data)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int sandbox_spi_ram_remove(struct udevice *dev)
+{
+	struct sandbox_spi_ram_priv *priv = dev_get_priv(dev);
+
+	free(priv->data);
+	priv->data = NULL;
+
+	return 0;
+}
+
+static const struct dm_spi_emul_ops sandbox_spi_ram_emul_ops = {
+	.xfer = sandbox_spi_ram_xfer,
+};
+
+static const struct udevice_id sandbox_spi_ram_ids[] = {
+	{ .compatible = "sandbox,spi-ram-emul" },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_spi_ram_emul) = {
+	.name		= "sandbox_spi_ram_emul",
+	.id		= UCLASS_SPI_EMUL,
+	.of_match	= sandbox_spi_ram_ids,
+	.probe		= sandbox_spi_ram_probe,
+	.remove		= sandbox_spi_ram_remove,
+	.priv_auto	= sizeof(struct sandbox_spi_ram_priv),
+	.ops		= &sandbox_spi_ram_emul_ops,
+};
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 007ad5e7733..7127337c6ac 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -518,7 +518,7 @@ config SANDBOX_SPI
 config SANDBOX_SPI_MAX_BUS
 	int
 	depends on SANDBOX
-	default 1
+	default 2
 
 config SANDBOX_SPI_MAX_CS
 	int
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 486e6b956fc..97102c051cf 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_SIMPLE_PM_BUS) += simple-pm-bus.o
 obj-$(CONFIG_SOC_DEVICE) += soc.o
 obj-$(CONFIG_SOUND) += sound.o
 obj-$(CONFIG_DM_SPI) += spi.o
+obj-$(CONFIG_SPI_RAM) += spi_ram.o
 obj-$(CONFIG_SPMI) += spmi.o
 obj-y += syscon.o
 obj-$(CONFIG_RESET_SYSCON) += syscon-reset.o
diff --git a/test/dm/spi_ram.c b/test/dm/spi_ram.c
new file mode 100644
index 00000000000..1020fe1f6ee
--- /dev/null
+++ b/test/dm/spi_ram.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for the Microchip 23LCV1024 SPI SRAM
+ *
+ * Copyright (C) 2026 Heiko Schocher, Nabla Software Engineering <hs@nabladev.com>
+ */
+
+#include <dm.h>
+#include <mtd.h>
+#include <spi.h>
+#include <spi_flash.h>
+#include <asm/state.h>
+#include <asm/test.h>
+#include <dm/test.h>
+#include <linux/mtd/mtd.h>
+#include <linux/sizes.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+#define SPI_RAM_PATH	"/spi@1/sram@0"
+#define SPI_RAM_CS	0
+
+/*
+ * Long enough to run past the 32 byte page of the device, and starting
+ * just before a page boundary, so that the transfer only comes back
+ * unharmed if the driver put the device into sequential operation.
+ */
+#define SPI_RAM_OFFSET	0x1f
+#define SPI_RAM_LEN	100
+
+/*
+ * The second partition of the device in the test device tree. Its offset is
+ * on no erase block boundary, which a device that cannot erase does not have
+ * to care about.
+ */
+#define SPI_RAM_PART		"spi-ram-part1"
+#define SPI_RAM_PART_OFFSET	0xa000
+#define SPI_RAM_PART_SIZE	0x1000
+
+static int dm_test_spi_ram(struct unit_test_state *uts)
+{
+	struct sandbox_state *state = state_get_current();
+	struct udevice *dev, *bus, *emul;
+	struct erase_info instr = { };
+	struct mtd_info *mtd, *found;
+	u8 src[SPI_RAM_LEN], dst[SPI_RAM_LEN];
+	struct spi_slave *slave;
+	size_t retlen;
+	int i;
+
+	ut_assertok(uclass_get_device_by_ofnode(UCLASS_MTD,
+						ofnode_path(SPI_RAM_PATH),
+						&dev));
+
+	mtd = dev_get_uclass_priv(dev);
+	ut_asserteq(SZ_128K, mtd->size);
+	ut_asserteq(MTD_RAM, mtd->type);
+
+	/*
+	 * Registering with the MTD layer is what makes the mtd command able
+	 * to reach the device, so check the name it was given resolves back
+	 * to it rather than checking the string itself.
+	 */
+	found = get_mtd_device_nm(mtd->name);
+	ut_asserteq_ptr(mtd, found);
+	put_mtd_device(found);
+
+	/*
+	 * The device is useless in the byte operation it powers up in, so
+	 * the probe has to have switched it over.
+	 */
+	bus = dev_get_parent(dev);
+	ut_assertok(spi_get_bus_and_cs(dev_seq(bus), SPI_RAM_CS, &bus, &slave));
+	ut_assertok(sandbox_spi_get_emul(state, bus, slave->dev, &emul));
+	ut_assert(sandbox_spi_ram_is_sequential(emul));
+
+	for (i = 0; i < SPI_RAM_LEN; i++)
+		src[i] = i + 1;
+
+	ut_assertok(mtd_write(mtd, SPI_RAM_OFFSET, SPI_RAM_LEN, &retlen, src));
+	ut_asserteq(SPI_RAM_LEN, retlen);
+
+	memset(dst, 0, SPI_RAM_LEN);
+	ut_assertok(mtd_read(mtd, SPI_RAM_OFFSET, SPI_RAM_LEN, &retlen, dst));
+	ut_asserteq(SPI_RAM_LEN, retlen);
+	ut_asserteq_mem(src, dst, SPI_RAM_LEN);
+
+	/* Neighbouring cells must not have been touched */
+	ut_assertok(mtd_read(mtd, 0, SPI_RAM_OFFSET, &retlen, dst));
+	for (i = 0; i < SPI_RAM_OFFSET; i++)
+		ut_asserteq(0, dst[i]);
+
+	/*
+	 * The device cannot erase and says so through MTD_NO_ERASE, so a
+	 * caller asking for one has to be told rather than left believing
+	 * the area was cleared.
+	 */
+	ut_assert(mtd->flags & MTD_NO_ERASE);
+	instr.addr = 0;
+	instr.len = SPI_RAM_OFFSET;
+	ut_asserteq(-EOPNOTSUPP, mtd_erase(mtd, &instr));
+
+	ut_assertok(mtd_read(mtd, SPI_RAM_OFFSET, SPI_RAM_LEN, &retlen, dst));
+	ut_asserteq_mem(src, dst, SPI_RAM_LEN);
+
+	/*
+	 * Since we are about to destroy all devices, we must tell sandbox
+	 * to forget the emulation device
+	 */
+	sandbox_spi_unbind_emul(state, dev_seq(bus), SPI_RAM_CS);
+
+	return 0;
+}
+DM_TEST(dm_test_spi_ram, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+static int dm_test_spi_ram_part(struct unit_test_state *uts)
+{
+	struct sandbox_state *state = state_get_current();
+	struct udevice *dev, *bus;
+	struct mtd_info *mtd, *part;
+	u8 src[SPI_RAM_LEN], dst[SPI_RAM_LEN];
+	size_t retlen;
+	int i;
+
+	ut_assertok(uclass_get_device_by_ofnode(UCLASS_MTD,
+						ofnode_path(SPI_RAM_PATH),
+						&dev));
+	mtd = dev_get_uclass_priv(dev);
+
+	/*
+	 * This is what the mtd command does through mtd_probe_devices(),
+	 * called here for this device alone so that the test does not depend
+	 * on what else is registered with the MTD layer.
+	 */
+	ut_assertok(add_mtd_partitions_of(mtd));
+
+	part = get_mtd_device_nm(SPI_RAM_PART);
+	ut_assert(!IS_ERR_OR_NULL(part));
+
+	/*
+	 * The device has no erase size to align a partition to, so the
+	 * partition is aligned on the write size and stays writeable, at
+	 * whatever offset the device tree puts it.
+	 */
+	ut_assert(part->flags & MTD_NO_ERASE);
+	ut_assert(part->flags & MTD_WRITEABLE);
+	ut_asserteq(SPI_RAM_PART_SIZE, part->size);
+
+	for (i = 0; i < SPI_RAM_LEN; i++)
+		src[i] = 0xa0 + i;
+
+	ut_assertok(mtd_write(part, 0, SPI_RAM_LEN, &retlen, src));
+	ut_asserteq(SPI_RAM_LEN, retlen);
+	put_mtd_device(part);
+
+	/* what the partition took has to land at its offset in the device */
+	memset(dst, 0, SPI_RAM_LEN);
+	ut_assertok(mtd_read(mtd, SPI_RAM_PART_OFFSET, SPI_RAM_LEN, &retlen,
+			     dst));
+	ut_asserteq_mem(src, dst, SPI_RAM_LEN);
+
+	bus = dev_get_parent(dev);
+	sandbox_spi_unbind_emul(state, dev_seq(bus), SPI_RAM_CS);
+
+	return 0;
+}
+DM_TEST(dm_test_spi_ram_part, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.55.0

