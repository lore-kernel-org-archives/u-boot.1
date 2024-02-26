Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB40DC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 10:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9807187DC1;
	Mon, 26 Feb 2024 11:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=tecon.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B880287DEB; Mon, 26 Feb 2024 11:26:39 +0100 (CET)
Received: from mail.tecon.ru (mail.tecon.ru [82.112.190.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF53787DAF
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=tecon.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dunaev@tecon.ru
From: Dmitry Dunaev <dunaev@tecon.ru>
To: 
CC: <dunaich@mail.ru>, Dmitry Dunaev <dunaev@tecon.ru>, Jagan Teki
 <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, Venkatesh Yadav
 Abbarapu <venkatesh.abbarapu@amd.com>, Jonas Karlman <jonas@kwiboo.se>,
 Angelo Dureghello <angelo@kernel-space.org>, Andre Przywara
 <andre.przywara@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Bruce
 Suen <bruce_suen@163.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Nishanth Menon <nm@ti.com>, Jit
 Loon Lim <jit.loon.lim@intel.com>, Ssunk <ssunkkan@gmail.com>, Jim Liu
 <jim.t90615@gmail.com>, <u-boot@lists.denx.de>
Subject: [PATCH] mtd: spi-nor-ids: Add Puya Semiconductor chips description
Date: Mon, 26 Feb 2024 13:25:20 +0300
Message-ID: <20240226102520.1844450-1-dunaev@tecon.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Added support for the Puya Semiconductor chips.

The datasheet can be found here:
https://www.puyasemi.com/h_xilie715.html

Signed-off-by: Dmitry Dunaev <dunaev@tecon.ru>
---
 drivers/mtd/spi/Kconfig       |  5 +++++
 drivers/mtd/spi/spi-nor-ids.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index d068b7860e..407c8fc304 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -176,6 +176,11 @@ config SPI_FLASH_MACRONIX
 	help
 	  Add support for various Macronix SPI flash chips (MX25Lxxx)
 
+config SPI_FLASH_PUYA
+	bool "Puya Semiconductor SPI flash support"
+	help
+	  Add support for various Puya Semiconductor SPI flash chips (P25xxx)
+
 config SPI_FLASH_SILICONKAISER
 	bool "Silicon Kaiser SPI flash support"
 	help
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 4e83b8c94c..92c2d5e2a5 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -294,6 +294,36 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mx25uw6445g",    0xc28137, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25uw6345g",    0xc28437, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 #endif
+#ifdef CONFIG_SPI_FLASH_PUYA
+	/* Puya Semiconductor (Shanghai) Co., Ltd */
+	{ INFO
+	 ("p25q05h", 0x856010, 0, 64 * 1024, 1,
+	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO
+	 ("p25q10h", 0x856011, 0, 64 * 1024, 2,
+	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO
+	 ("p25q20h", 0x856012, 0, 64 * 1024, 4,
+	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO
+	 ("p25q40h", 0x856013, 0, 64 * 1024, 8,
+	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO
+	 ("p25q80h", 0x856014, 0, 64 * 1024, 16,
+	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO
+	 ("p25q16h", 0x856015, 0, 64 * 1024, 32,
+	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO
+	 ("p25q32h", 0x856016, 0, 64 * 1024, 64,
+	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO
+	 ("p25q64h", 0x856017, 0, 64 * 1024, 128,
+	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO
+	 ("p25q128h", 0x856018, 0, 64 * 1024, 256,
+	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+#endif
 
 #ifdef CONFIG_SPI_FLASH_SILICONKAISER
 	{ INFO("sk25lp128", 0x257018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-- 
2.34.1

