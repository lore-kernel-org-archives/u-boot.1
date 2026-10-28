Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F9606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GGV1ndAF;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=A2ANuIf5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B10F80683;
	Wed, 28 Oct 2026 06:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fc9AFEdtlIDW; Wed, 28 Oct 2026 06:13:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 079CC806D0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793168021;
	b=tAcgZ/0uuuHn8W7beFzL1eEZYycQNY+G/GrVPwN/CuEeo/Vzg/s4deWrH7j4QlxFB8xr
	 Btna4Y/1EW17ZZAz7hzoAlxbiIIC3KcONVHcUC7zEZ+XNUPtcdibRvBHlMjNZ8ZXKQOXU
	 s0uYI5qLo8vxRnI9Wtfa84nDDQJsM2448xyuoprDNUibQqXIa4fGNwZ+7SyeXUN+h75ii
	 /m2OsbjGYcczKVxdWtaDetpicf7SggF6zeZfhm5NuwhVUXtpm0ZNFUq3O/wxXWlGKTJ7G
	 mOmpGy3xG+Xzg9uJU+4SUQG1ji/nCYhFQ9tZNJMPC1WQ9/o8ulqDatfbrsxnM8YRlBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793168021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LZNo5Ihq4wpRpTjyTrDTPH8SlQ9ONViLvxdZe/1oe+g=;
	b=l4f+6Usny5qw76Y7E3664HHuqjonZsF0vgMVTzBpRrfgqWHQQ/W3LbiUnxvr79oKoinp
	 6aMbQ3ZHgsv8wfo+28HiMeqvO/3RMbvyvdcv4IzMDtMVERS0HR03iK1/kDf4K1+e3Bq6A
	 28ouIbOD8RTQUY8QJobyRxdcfEizQ4Fag6HvoOa4zMGZLVYXOsVTfhfnwsIXmWJCsUjxZ
	 lEIRDEK5hR/fLzwyEK9PySXvdE+f36uMCsoeSoHfnWqWe7TZ9SUUkdnsMsNBBz7rWlGq0
	 47sr+66NtRz9+O0pvH8Jeg4WnrE9yLm8NQBM6iVbWO/9ZBXZW7Qj2FWynylgJosK9DQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793168021;
	bh=LZNo5Ihq4wpRpTjyTrDTPH8SlQ9ONViLvxdZe/1oe+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GGV1ndAF1CkW/Ak7IeHlQq1K0dgHzQXAq5rPW9y++FhBsSBSThKg6ZFmVulFHuHcG
	 qduSB3KRpUMRZi+OXBk+wWJo/Xo6wPAyf+GC2OZrBR9MhTOsd5zKZDW2IcNrz8DahB
	 LPgyUrMKI/wkMDNYM0wOCq1QDYYuk7mIzU6vQMRXx0S6R+S0E+//suiAeXV1QuC/FF
	 sj5Z8I6hiDH6YzhrXoknqRddMhCWAdC0FSXHSd4HHKrNyxGL60JC/tqkNw4PN/5PXm
	 dmeepFk7fGuech+fHgp9sjhniN8oYDnr6CBWw3oXjfnvouDVlPZdE6S+g7CQoxuN45
	 eqZW/GWUMfYAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 079CC806D0;
	Wed, 28 Oct 2026 06:13:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AD2A52E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 936ED4016B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D520UWuJp6NJ for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 06:13:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 145114006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793168018;
 b=r6IjNjv6AD4HhLlXYQoZ9obkWLaE5hi8rwCkqtrQJQIhvLUQqy7r2h6t4zmi4XFX3GKr
 1uPshg4Wz2DpV2HGdwbEapcswJA66s67we89FddKbrmbgd15N6UzPgucSeJ4WTjOq+AsV
 QKrSQH0vPQNs/gmyTOA0nqFtMPuFUjmySo8qbHMbl+f1pkuND38IoYOXJoE6cEz71Q6uk
 1F/t9Ev/+2ESYXXx2tC4gbYCSuSUxwo7xdXu41pGLKGXeHfFoTknuKD8a/ZzRUpmDHOrD
 jso7bHEvRKNXHLJk1YgoYzxMvFSHM0TuPuMejlTawLp97b2Urcg9e2QqN9bYGmmeRgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793168018;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=LZNo5Ihq4wpRpTjyTrDTPH8SlQ9ONViLvxdZe/1oe+g=;
 b=dy/jihk6+pZygQT1i7tYvw80iLDLfqmouPoMlPqfKJW4gHgitzZzeA/rt+DnHD7yF1tR
 G41Nj7CfTYx9cFHKOlljJ2jjhwd8sI4cD4xUl1GvWRqthYLzPsE0T94xT6rva3ERrqpp3
 nky4abuWqzn0Ia5LMHlywFI4uWoBFToCzLkmH224zvyMt07DfdHIPBNMxPsVl6YEV49dF
 EFwVTxcEH2jiPYmJogl11x3LYVV8kSLQezmM7zveQ3k1seMMY0TOMsbdvJxlSJjCAV0ad
 9M0AbCylHIb3R2ns2FzqMSM6YCTBPo/YEu9R0WcJHbl2bHQHiK2QPifdS4XFEkElipw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=A2ANuIf5; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=A2ANuIf5
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 145114006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7B64410BAFB; Wed, 28 Oct 2026 07:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793168012; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=LZNo5Ihq4wpRpTjyTrDTPH8SlQ9ONViLvxdZe/1oe+g=;
 b=A2ANuIf5tgosK3MvK/zgANToIN1Ak5vFoaE6Ub5xvEmh68zTKBN3rZM73kFKlNTTTUvfLy
 6h6m4AihaUK/bqSSUk/PHVuu0fI7x2d/J7IL7KXmzk/npiSP6b7NFTvRSG2kW71qsm3sf3
 W/y67KVozpHCqTnMy9/TEmlzYnj4fv/U7CCJrEb6wgYOv7ycwPd44Wh6rV9obXNlzXpygl
 idtavEWB0Zc6rT5gn7VtNNkwAFj7U6RuMKVOLbTB3P1MY5XLtlBtWrbcibF5ZlOF6panFx
 VkH13u9TbeQVcnsTlFjM7C1pwvcCj1B9Bioxdoq+Mr33mKjOE/xdMZMSs2eF7g==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>,
 Daniel Golle <daniel@makrotopia.org>, Marek Vasut <marex@nabladev.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/7] mtd: add driver for the Microchip 23K256 and 23LCV1024
 SPI SRAM
Date: Wed, 28 Oct 2026 07:11:37 +0100
Message-ID: <20261028061231.39152-4-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028061231.39152-1-hs@nabladev.com>
References: <20261028061231.39152-1-hs@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 23K256 and the 23LCV1024 are a 32 KiB and a 128 KiB serial SRAM on
an SPI bus, the larger one with battery backup, used as non volatile
scratch storage. Register them as an MTD device of type MTD_RAM, so the
mtd command reaches them. A command carries a two byte address on the
smaller part and a three byte one on the larger, which is what the per
compatible data holds.

Sequential operation, where a command transfers as many bytes as the
master clocks, is the mode the devices power up in. Select it during
probe, as nothing says which mode the device was left in by whoever
talked to it before, and in byte operation a command would carry a
single byte. The Linux driver does the same.

Erasing is not required for writing, so the driver sets mtd->_erase to
NULL and says MTD_NO_ERASE through MTD_CAP_RAM in the MTD flags.

Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Named after the Linux driver and moved to
  drivers/mtd/devices/mchp23k256.c, with CONFIG_MTD_MCHP23K256 and the
  driver name mchp23k256. drivers/mtd/devices/ is new in U-Boot, it is
  where the related parts of the family would go (Simon)
- Added the microchip,mchp23k256 compatible, 32 KiB with a two byte
  address, so that the name covers what the driver does. The address
  width comes from the per compatible data
- spi_ram_xfer() dropped, the driver calls spi_write_then_read(), which
  does the same two transfers (Simon)
- The message and the comment in the probe claimed the device powers up
  in byte operation. The data sheet (DS25156A, section 2.5) gives
  sequential as the default, and the Linux driver writes the MODE
  register all the same (Simon)
- Removed two comments in probe. The reason for selecting sequential
  operation is in the commit message, and mtd->_erase is set to NULL
  explicitly (even if that is redundant), so it is obvious that there
  is no erase function
- did not add Simons comment about the single 128k comment in this
  patch, instead moved that to a new patch:
  mtd: mchp23k256: move the transfers to spi-mem
- Added Reviewed-by from Simon

Changes in v2:
Added comments from Simon:
- Moved from UCLASS_SPI_FLASH to UCLASS_MTD, the way the SPI NAND
  driver sits. The struct spi_nor shim and the dm_spi_flash_ops are
  gone with it, and the device is reached through the mtd command
  rather than sf.
- Moved from drivers/mtd/spi/ to drivers/mtd/, where the other
  standalone MTD drivers live.
- Dropped the erase operation. v1 filled the range with 0xff from a
  malloc'd buffer and claimed the bus once per 1 KB chunk. A RAM needs
  no erase, and patch 1 makes mtd_erase() answer -EOPNOTSUPP.
- Dropped the linux/mtd/spi-nor.h include, spi_flash.h pulled it in
  anyway and it advertised a NOR driver.
- sprintf() into a fixed field replaced by snprintf() into a buffer the
  driver owns.
- Copyright: dropped the trailing full stop and added Stefan Bigler's
  address.
fixed checkpatch warning:
- Added a MAINTAINERS entry, as the move out of drivers/mtd/spi/
  dropped a checkpatch warning.

 MAINTAINERS                      |   5 +
 configs/sandbox_defconfig        |   1 +
 drivers/mtd/Kconfig              |   2 +
 drivers/mtd/Makefile             |   1 +
 drivers/mtd/devices/Kconfig      |  17 +++
 drivers/mtd/devices/Makefile     |   3 +
 drivers/mtd/devices/mchp23k256.c | 200 +++++++++++++++++++++++++++++++
 7 files changed, 229 insertions(+)
 create mode 100644 drivers/mtd/devices/Kconfig
 create mode 100644 drivers/mtd/devices/Makefile
 create mode 100644 drivers/mtd/devices/mchp23k256.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 95b1f3b5ab3..5dc2067d1f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1663,6 +1663,11 @@ S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-nand-flash.git
 F:	drivers/mtd/nand/spi/
 
+MICROCHIP 23K256/23LCV1024 SPI SRAM
+M:	Heiko Schocher <hs@nabladev.com>
+S:	Maintained
+F:	drivers/mtd/devices/mchp23k256.c
+
 SPI-NOR
 M:	Vignesh R <vigneshr@ti.com>
 R:	Takahiro Kuwano <takahiro.kuwano@infineon.com>
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a3fa5246082..728470bb0d2 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -265,6 +265,7 @@ CONFIG_MMC_SANDBOX=y
 CONFIG_MMC_SDHCI=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_BLOCK=y
+CONFIG_MTD_MCHP23K256=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_MAX_NAND_DEVICE=8
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index f6bd9f6f2e9..f4f0c58f2fe 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -248,6 +248,8 @@ config SYS_MAX_FLASH_BANKS_DETECT
 	  to reduce the effective number of flash bank, between 0 and
 	  CONFIG_SYS_MAX_FLASH_BANKS
 
+source "drivers/mtd/devices/Kconfig"
+
 source "drivers/mtd/nand/Kconfig"
 
 config SYS_NAND_MAX_OOBFREE
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index ce05e206073..80435729ad6 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -21,6 +21,7 @@ ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 ifneq ($(mtd-y),)
 obj-y += mtd.o
 endif
+obj-$(CONFIG_MTD_MCHP23K256) += devices/
 obj-y += nand/
 obj-y += onenand/
 obj-y += spi/
diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
new file mode 100644
index 00000000000..1b39382bcb9
--- /dev/null
+++ b/drivers/mtd/devices/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+config MTD_MCHP23K256
+	bool "Microchip 23K256 and 23LCV1024 SPI SRAM"
+	depends on DM_SPI && DM_MTD
+	help
+	  Enable support for the Microchip 23K256 and 23LCV1024 serial SRAMs,
+	  a 32 KiB and a 128 KiB SRAM on an SPI bus, the latter with battery
+	  backup. The device is registered as an MTD device of type MTD_RAM,
+	  so the mtd command reaches it.
+
+	  Writing needs no erase, so the driver implements none and the MTD
+	  flags say MTD_NO_ERASE. An erase request is answered with
+	  -EOPNOTSUPP rather than silently doing nothing.
+
+	  If unsure, say N
+
diff --git a/drivers/mtd/devices/Makefile b/drivers/mtd/devices/Makefile
new file mode 100644
index 00000000000..e8404019cb6
--- /dev/null
+++ b/drivers/mtd/devices/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_MTD_MCHP23K256) += mchp23k256.o
diff --git a/drivers/mtd/devices/mchp23k256.c b/drivers/mtd/devices/mchp23k256.c
new file mode 100644
index 00000000000..624fb9e65e1
--- /dev/null
+++ b/drivers/mtd/devices/mchp23k256.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip 23K256 and 23LCV1024 SPI SRAM
+ *
+ * Copyright (C) 2019 Stefan Bigler <stefan.bigler@securiton.ch>
+ * Copyright (C) 2023 Heiko Schocher, DENX Software Engineering, hs@denx.de
+ * Copyright (C) 2026 Heiko Schocher, Nabla Software Engineering <hs@nabladev.com>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <spi.h>
+#include <vsprintf.h>
+#include <linux/bitops.h>
+#include <linux/mtd/mtd.h>
+#include <linux/sizes.h>
+
+/* Instruction set of the 23x series serial SRAMs */
+#define MCHP23K256_CMD_WRITE_STATUS	0x01
+#define MCHP23K256_CMD_WRITE		0x02
+#define MCHP23K256_CMD_READ		0x03
+
+/* MODE register, bits 7:6 select byte, page or sequential operation */
+#define MCHP23K256_MODE_SEQ		BIT(6)
+
+/* The widest address of the supported parts, in bytes */
+#define MCHP23K256_ADDR_MAX		3
+
+/**
+ * struct mchp23_caps - what one supported device looks like
+ *
+ * @size:	usable size of the array in bytes
+ * @addr_width:	width of the address a command carries, in bytes
+ */
+struct mchp23_caps {
+	u32 size;
+	u8 addr_width;
+};
+
+/**
+ * struct mchp23k256_priv - per device state
+ *
+ * @name:	MTD name, built from the technology and the sequence number
+ *		so that several of these can coexist
+ */
+struct mchp23k256_priv {
+	char name[16];
+};
+
+/**
+ * mchp23k256_command() - run one read or write command over the whole length
+ *
+ * Sequential operation was selected during probe, so the device serves a
+ * transfer of any length from a single command and the bus is claimed once.
+ *
+ * @dev:	the SRAM device
+ * @opcode:	MCHP23K256_CMD_READ or MCHP23K256_CMD_WRITE
+ * @offset:	byte offset into the array
+ * @data_out:	data to write, NULL when reading
+ * @data_in:	where to put data read, NULL when writing
+ * @len:	number of bytes to transfer
+ * Return: 0 on success, negative on error
+ */
+static int mchp23k256_command(struct udevice *dev, u8 opcode, u32 offset,
+			      const void *data_out, void *data_in, size_t len)
+{
+	const struct mchp23_caps *caps =
+		(const struct mchp23_caps *)dev_get_driver_data(dev);
+	struct spi_slave *spi = dev_get_parent_priv(dev);
+	u8 cmd[1 + MCHP23K256_ADDR_MAX];
+	uint i;
+	int ret;
+
+	cmd[0] = opcode;
+	for (i = 0; i < caps->addr_width; i++)
+		cmd[1 + i] = offset >> (8 * (caps->addr_width - i - 1));
+
+	ret = spi_claim_bus(spi);
+	if (ret) {
+		dev_dbg(dev, "failed to claim SPI bus: %d\n", ret);
+		return ret;
+	}
+
+	ret = spi_write_then_read(spi, cmd, 1 + caps->addr_width, data_out,
+				  data_in, len);
+
+	spi_release_bus(spi);
+
+	return ret;
+}
+
+static int mchp23k256_read(struct mtd_info *mtd, loff_t from, size_t len,
+			   size_t *retlen, u_char *buf)
+{
+	int ret;
+
+	ret = mchp23k256_command(mtd->dev, MCHP23K256_CMD_READ, from, NULL,
+				 buf, len);
+	if (ret)
+		return ret;
+
+	*retlen = len;
+
+	return 0;
+}
+
+static int mchp23k256_write(struct mtd_info *mtd, loff_t to, size_t len,
+			    size_t *retlen, const u_char *buf)
+{
+	int ret;
+
+	ret = mchp23k256_command(mtd->dev, MCHP23K256_CMD_WRITE, to, buf,
+				 NULL, len);
+	if (ret)
+		return ret;
+
+	*retlen = len;
+
+	return 0;
+}
+
+static int mchp23k256_probe(struct udevice *dev)
+{
+	const struct mchp23_caps *caps =
+		(const struct mchp23_caps *)dev_get_driver_data(dev);
+	struct mtd_info *mtd = dev_get_uclass_priv(dev);
+	struct mchp23k256_priv *priv = dev_get_priv(dev);
+	struct spi_slave *spi = dev_get_parent_priv(dev);
+	u8 cmd[2];
+	int ret;
+
+	ret = spi_claim_bus(spi);
+	if (ret) {
+		dev_dbg(dev, "failed to claim SPI bus: %d\n", ret);
+		return ret;
+	}
+
+	cmd[0] = MCHP23K256_CMD_WRITE_STATUS;
+	cmd[1] = MCHP23K256_MODE_SEQ;
+	ret = spi_write_then_read(spi, cmd, sizeof(cmd), NULL, NULL, 0);
+
+	spi_release_bus(spi);
+
+	if (ret) {
+		dev_dbg(dev, "failed to select sequential operation: %d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * Name the MTD device after the technology, the way nand0 and
+	 * spi-nor0 are named, not after the part.
+	 */
+	snprintf(priv->name, sizeof(priv->name), "spi-ram%d", dev_seq(dev));
+	mtd->name = priv->name;
+	mtd->dev = dev;
+	mtd->type = MTD_RAM;
+	mtd->flags = MTD_CAP_RAM;
+	mtd->size = caps->size;
+	mtd->writesize = 1;
+	mtd->writebufsize = 1;
+
+	mtd->_read = mchp23k256_read;
+	mtd->_write = mchp23k256_write;
+	mtd->_erase = NULL;
+
+	return add_mtd_device(mtd);
+}
+
+static int mchp23k256_remove(struct udevice *dev)
+{
+	return del_mtd_device(dev_get_uclass_priv(dev));
+}
+
+static const struct mchp23_caps mchp23k256_caps = {
+	.size = SZ_32K,
+	.addr_width = 2,
+};
+
+static const struct mchp23_caps mchp23lcv1024_caps = {
+	.size = SZ_128K,
+	.addr_width = 3,
+};
+
+static const struct udevice_id mchp23k256_ids[] = {
+	{ .compatible = "microchip,mchp23k256",
+	  .data = (ulong)&mchp23k256_caps },
+	{ .compatible = "microchip,mchp23lcv1024",
+	  .data = (ulong)&mchp23lcv1024_caps },
+	{ }
+};
+
+U_BOOT_DRIVER(mchp23k256) = {
+	.name		= "mchp23k256",
+	.id		= UCLASS_MTD,
+	.of_match	= mchp23k256_ids,
+	.probe		= mchp23k256_probe,
+	.remove		= mchp23k256_remove,
+	.priv_auto	= sizeof(struct mchp23k256_priv),
+};
-- 
2.55.0

