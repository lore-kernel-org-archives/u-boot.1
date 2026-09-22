Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2D3C982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 06:10:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C30A360668;
	Tue, 22 Sep 2026 06:10:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aMt26MEh__cp; Tue, 22 Sep 2026 06:10:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 997F5606D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790057421;
	b=ISl/uHnb8fZbV89nBHR5uY6P1qM5OmZmCFsJIZelJGLkLxqQy8BsQQXMTxhsVl55ufN4
	 wkVgMWojo59/Tc75o/srez8fPYNKAWiav/S+naLuLAdbFtXF+tCS1JJh85UcBvQhwVpUA
	 IWXn/ge+vlx9k+/r52FPTrdF69gAFoK+uogZRWVQIXUOBomJY3Vl637YcFMTnXDgRp6Z5
	 ZmBwM73UjnHhoW0cTT4hhzrB4SL92yKf5U0QSR78wrAcWTNTTeZvmlbUeinEOzPHYPD1U
	 +TD7fap8U4Kn/eHSVJBA+pxY1OX1Dri00x0+q7Fj6nA2jsdhBYSoN5B+2jg/22vNkVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790057421;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bfzPFBZ0fkWz3i0OaK11og3SfajZKhhKWUatkFK4+ls=;
	b=tY1vHL/xY5rWwCVj/e2Dst4g3roE5wRD/kcNd/OVTThdsUlIILMM3MsNUAPIXDg5UuU3
	 C1rBdr7bPZTAmNYHvuOc97ST4j1KpSBKyHSy49UzTz6+fv5fvjUdlOdzA9ymP0dgUKDbD
	 pqnl5kAak1CnLJqYaiOpK+iFsaFbrun2Ffm+srAePWMezKCemWJyN1VyHE92uAd792RuS
	 NODWA6dQ79Rr37wO8iTf52pDKaFozJIJfl2BKSnFz3P+ulvTKgRwNx9YX+4Am0PLB9YxH
	 ZHcdtfMxYWJ/JteZi5RUahS4N3b5ZIQWRDaRkKhH18Sj27Vb60mcr+X15Rv/bHZoyZg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=B4cGG63H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790057421;
	bh=bfzPFBZ0fkWz3i0OaK11og3SfajZKhhKWUatkFK4+ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pbn39QHmyegKK+CNv7jvaVxpXdinVJejclIicA16zwFPF++WEj+5I4KWTrosawWvX
	 ge1SwzbGJHjob5DXPgB1MS8o+IRvVhKOK2Pk9lmPA8zUJ/2ghqU0b3pPGjcjWOG9he
	 X060x731QSmKY87BtFZxvj1cTr7F5klVPF6advAGtkHAxbJL7RtmjqTUC/U8Ej1vQ8
	 MabZElufkQ0zwjYZ6buGpWg0u1ThVodBhY6z2Ntuh5WBvVJwTAg32Ci+KC/+CE5hdn
	 hw4YKhLZPnuL1WlHsKAmB5/HKhUT47ZU+9vCUYrF5RX1iEFp/RHtfqHGR5Z0bXU56t
	 rDM/oFHH5fN6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 997F5606D6;
	Tue, 22 Sep 2026 06:10:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2650F472
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C645606D6
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:10:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7S2aM7aKfyAw for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 06:10:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A283260668
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790057419;
 b=mfhwmPZt43Kety2IRh3HTj3HX9Na6k1lWazPDbl1owT0dwcWxvsLhmF+CGn1xOLESfUQ
 1vzJlxPBnjwP8zEqmy78yfHD8+ffSZ+XRSk/J8g3maCS8WOk+naNPgYP8yAMH53Hod6OU
 XKnCyJUsn3mipBkZ4VdTv8w0Nsu5PAAB0pttpBr5KU/WUBpwBzQpeCFAeZWO9S5SNRa3V
 Wq8cxHdl7znAROQgCfZ0hdjhs9tsBbhppVV3QG7W+mMOWlEnnIqujARdSes6hrQmPsRtt
 JUPfkxSLSV1kU02/0K6Tk9L49DyTSAvhlIAfCUH4YB+FQZ+T1wbGxGjeATG6PTh3P/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790057419;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=bfzPFBZ0fkWz3i0OaK11og3SfajZKhhKWUatkFK4+ls=;
 b=V4mnT/XM/vf5SZpKhfu6JME+CB+peajox/G/1DL3kiS1a5C7lnnJPNHuu9uB4PX4OKfG
 5buEgYFquY7lSQA+9YuLbzRK2gOxfzk1WW7UewXpC9UuV0Ls3lIHRWv2aWGcTNzGCUT/z
 It8g24oCWF2+YXNzk7AWco5YWUFGhqoToZLx9O516tNobL8lIQCmFb9bxfeMNI7TflEOr
 wzgeudGQsm+SzniZdkpB+yV5py3iKoXvNkcIpap0o8IDYg64IJWmmGUoSRYoanWGB2PN9
 WBiB2e8rgHpck9P5aRrdX7dJZPTiFFC3W47aWgbvp+OrlXhv4W/cm3GU3bVxOznCGuQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=B4cGG63H; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=B4cGG63H
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A283260668
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:10:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4B7401056F5; Tue, 22 Sep 2026 08:10:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790057412; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=bfzPFBZ0fkWz3i0OaK11og3SfajZKhhKWUatkFK4+ls=;
 b=B4cGG63H9MlH8DnGXfLiegqPBeEL1DX44qXxLiGYwW7MwWIfJ6juC9FwY4YKfpUOCdtY/2
 ohUvWcwEjA4TOEabEK+yHRHqR1shWg0s08TTcs8SeCyZ2/4f2rk+KUpk0cEG8JYXgyPAr1
 mzFBQBR4pU1+g8YvHzJB8XwgDmoAsiyTKcgrLlhYDuvsQSdYVfYNOABz7o2RveLDfjVhZ6
 h7IyNesgiRv7rXWA+yBZtC5YOk9WBILph4yEk0lVZ/S62Dcux4MygS0/VUIt5okNLpN11p
 iduHASfiwA3BE+RnfmVuJ99uRUfSKRJYTHHb8H2SP6IOLY1FicuuLeEyFEj37Q==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Vignesh R <vigneshr@ti.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Heiko Schocher <hs@nabladev.com>, Anshul Dalal <anshuld@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 3/3] test: dm: add a test for the Microchip 23LCV1024 SPI
 SRAM
Date: Tue, 22 Sep 2026 08:09:32 +0200
Message-ID: <20260922060941.534035-4-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922060941.534035-1-hs@nabladev.com>
References: <20260922060941.534035-1-hs@nabladev.com>
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
through the spi_flash uclass.

The emulation implements byte, page and sequential operation and
advances the internal address counter the way the data sheet describes
for each of them. A transfer running past the 32 byte page of the
device therefore only comes back unharmed once the driver has selected
sequential operation, which is what its probe is for. The test asserts
that mode directly as well, so a failure says which of the two went
wrong.

The erase is checked on both counts that matter for a device that has
nothing to erase: that the area reads back as 0xff afterwards, and that
the fill stops at the end of the range it was given rather than running
into the data next to it.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

 arch/sandbox/dts/test.dts         |  14 +++
 arch/sandbox/include/asm/test.h   |   8 ++
 configs/sandbox_defconfig         |   1 +
 drivers/mtd/spi/Kconfig           |   9 ++
 drivers/mtd/spi/Makefile          |   1 +
 drivers/mtd/spi/spi_ram_sandbox.c | 189 ++++++++++++++++++++++++++++++
 drivers/spi/Kconfig               |   2 +-
 test/dm/Makefile                  |   1 +
 test/dm/spi_ram.c                 |  96 +++++++++++++++
 9 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/spi/spi_ram_sandbox.c
 create mode 100644 test/dm/spi_ram.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index a5d8d3977a0..e192be1d1b5 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1644,6 +1644,20 @@
 		};
 	};
 
+	spi@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1 1>;
+		compatible = "sandbox,spi";
+
+		sram@0 {
+			reg = <0>;
+			compatible = "microchip,mchp23lcv1024";
+			spi-max-frequency = <20000000>;
+			sandbox,emul = "sandbox_spi_ram_emul";
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
index f39d2bb062f..23ef9670c0e 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -277,6 +277,7 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_SST=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_RAM=y
+CONFIG_SPI_RAM_SANDBOX=y
 CONFIG_NVMXIP_QSPI=y
 CONFIG_MULTIPLEXER=y
 CONFIG_MUX_MMIO=y
diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index 22bdbc27f9b..1a6daafc94a 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -259,6 +259,15 @@ config SPI_RAM
 
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
 config SPI_FLASH_USE_4K_SECTORS
 	bool "Use small 4096 B erase sectors"
 	depends on SPI_FLASH
diff --git a/drivers/mtd/spi/Makefile b/drivers/mtd/spi/Makefile
index 324c90d423f..2581a735286 100644
--- a/drivers/mtd/spi/Makefile
+++ b/drivers/mtd/spi/Makefile
@@ -19,6 +19,7 @@ endif
 obj-$(CONFIG_SPI_FLASH) += spi-nor.o
 obj-$(CONFIG_SPI_FLASH_DATAFLASH) += sf_dataflash.o
 obj-$(CONFIG_SPI_RAM) += spi_ram.o
+obj-$(CONFIG_SPI_RAM_SANDBOX) += spi_ram_sandbox.o
 obj-$(CONFIG_$(PHASE_)SPI_FLASH_MTD) += sf_mtd.o
 obj-$(CONFIG_SPI_FLASH_SANDBOX) += sandbox.o
 obj-$(CONFIG_$(PHASE_)BOOTDEV_SPI_FLASH) += sf_bootdev.o
diff --git a/drivers/mtd/spi/spi_ram_sandbox.c b/drivers/mtd/spi/spi_ram_sandbox.c
new file mode 100644
index 00000000000..b785010aac0
--- /dev/null
+++ b/drivers/mtd/spi/spi_ram_sandbox.c
@@ -0,0 +1,189 @@
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
+/*
+ * No of_match, so that a device tree scan never binds this driver. It is
+ * bound by name, on the node of the slave it emulates, which already
+ * carries the compatible of the real device.
+ */
+U_BOOT_DRIVER(sandbox_spi_ram_emul) = {
+	.name		= "sandbox_spi_ram_emul",
+	.id		= UCLASS_SPI_EMUL,
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
index 00000000000..3de6a5ab025
--- /dev/null
+++ b/test/dm/spi_ram.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for the Microchip 23LCV1024 SPI SRAM
+ *
+ * Copyright (C) 2026 Heiko Schocher, Nabla Software Engineering <hs@nabladev.com>
+ */
+
+#include <dm.h>
+#include <spi.h>
+#include <spi_flash.h>
+#include <asm/state.h>
+#include <asm/test.h>
+#include <dm/test.h>
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
+static int dm_test_spi_ram(struct unit_test_state *uts)
+{
+	struct sandbox_state *state = state_get_current();
+	struct udevice *dev, *bus, *emul;
+	struct spi_flash *flash;
+	u8 src[SPI_RAM_LEN], dst[SPI_RAM_LEN];
+	int i;
+
+	ut_assertok(uclass_get_device_by_ofnode(UCLASS_SPI_FLASH,
+						ofnode_path(SPI_RAM_PATH),
+						&dev));
+
+	flash = dev_get_uclass_priv(dev);
+	ut_asserteq(SZ_128K, flash->size);
+	ut_asserteq_str("mchp23lcv1024", flash->name);
+
+	/*
+	 * The device is useless in the byte operation it powers up in, so
+	 * the probe has to have switched it over.
+	 */
+	bus = dev_get_parent(dev);
+	emul = state->spi[dev_seq(bus)][SPI_RAM_CS].emul;
+	ut_assertnonnull(emul);
+	ut_assert(sandbox_spi_ram_is_sequential(emul));
+
+	for (i = 0; i < SPI_RAM_LEN; i++)
+		src[i] = i + 1;
+
+	ut_assertok(spi_flash_write_dm(dev, SPI_RAM_OFFSET, SPI_RAM_LEN, src));
+
+	memset(dst, 0, SPI_RAM_LEN);
+	ut_assertok(spi_flash_read_dm(dev, SPI_RAM_OFFSET, SPI_RAM_LEN, dst));
+	ut_asserteq_mem(src, dst, SPI_RAM_LEN);
+
+	/* Neighbouring cells must not have been touched */
+	ut_assertok(spi_flash_read_dm(dev, 0, SPI_RAM_OFFSET, dst));
+	for (i = 0; i < SPI_RAM_OFFSET; i++)
+		ut_asserteq(0, dst[i]);
+
+	/*
+	 * A RAM needs no erase before a write, but an erase that was asked
+	 * for has to leave behind what an erased flash reads, and it has to
+	 * stop at the end of the range it was given.
+	 */
+	ut_assertok(spi_flash_erase_dm(dev, 0, SPI_RAM_OFFSET));
+
+	ut_assertok(spi_flash_read_dm(dev, 0, SPI_RAM_OFFSET, dst));
+	for (i = 0; i < SPI_RAM_OFFSET; i++)
+		ut_asserteq(0xff, dst[i]);
+
+	ut_assertok(spi_flash_read_dm(dev, SPI_RAM_OFFSET, SPI_RAM_LEN, dst));
+	ut_asserteq_mem(src, dst, SPI_RAM_LEN);
+
+	/* Now erase the data itself, over more than one staging step */
+	ut_assertok(spi_flash_erase_dm(dev, SPI_RAM_OFFSET, SPI_RAM_LEN));
+	ut_assertok(spi_flash_read_dm(dev, SPI_RAM_OFFSET, SPI_RAM_LEN, dst));
+	for (i = 0; i < SPI_RAM_LEN; i++)
+		ut_asserteq(0xff, dst[i]);
+
+	/*
+	 * Since we are about to destroy all devices, we must tell sandbox
+	 * to forget the emulation device
+	 */
+	sandbox_sf_unbind_emul(state, dev_seq(bus), SPI_RAM_CS);
+
+	return 0;
+}
+DM_TEST(dm_test_spi_ram, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.55.0

