Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C09C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 13:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCAD876E7;
	Mon, 15 Jan 2024 14:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705326722;
	bh=zQoAkpGrY6VaWaJ/+SMAs2dp9L0JAjtts/kqWvzZseg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TuEvDJHhtvAVSglOR/iVz1cHSTjJsyjCU0ZkkN/aXQ+ZwjklGUQpX12xbUO16l9gu
	 lrgPoN24BGMl3FsMrvs/LBQ9vTcRAlggulAQiuxWZhS7zL5i33/yQO9tDjKqiTcejm
	 +z0s5hySskhAXECI979r9QgGxSk02ZtoOnkaG4jeZqXue6MEv6Qq0QQ+57SqPvHkh6
	 gGBe1vaKeewD3dP0aTtA7x9H7pziryXpDzJrsphCymsRVnm4aaZ0ZmlRbYqhPzYzl4
	 lTabJORfFcB9ZV0m3NznAUuDx/od80RKezKdGAim1xqr1UehH6KYL8lKUuFaiHkgQg
	 NyjZrHkmHSZhg==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4D9A186F80;
 Mon, 15 Jan 2024 14:52:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705326720;
 bh=zQoAkpGrY6VaWaJ/+SMAs2dp9L0JAjtts/kqWvzZseg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wDrpPhE1XqsrQ2nHdQWcw9MJnvCWbpwTjnPx2ULKNBiu6igtE9LdcyBoj8sEEWQf+
 xVP5MlzvQUT802jpzJEbTGNfKMXUrQ193RMkbNNhn8gDoj1Fv7gcRvlgJYtFSMETOr
 4HlQ1bzHPGsMn0XDbhRqLAq1bl1O7wPOYNd+9BgmUnUqApXxnkL0tJx0ZNfMltKtKY
 3LCbHQ8fRgoP+Uq3xvKjZWyupRIHiRU7v4ycbO5wdoKVNXml2aL4Eqc2zZQkxFfWPN
 Lp8lMvcGJNUEoGEndsFSFiasf+oIWjuv/qr37d6ArlK2J1s89nocT/BquBJHLP79p1
 Y00z2w5PJmh9A==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 NXP u-boot <uboot-imx@nxp.com>
Cc: Anatolij Gustschin <agust@denx.de>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3 3/3] arm: xea: Add support for boot image source descriptor
 in SPL
Date: Mon, 15 Jan 2024 14:51:30 +0100
Message-Id: <20240115135130.2789123-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115135130.2789123-1-lukma@denx.de>
References: <20240115135130.2789123-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Anatolij Gustschin <agust@denx.de>

We load two boot image source descriptor structures from last
two sectors in the SPI NOR flash and determine the boot source
for loading the kernel/DTB images, then adjust the boot order for
loading image from eMMC boot0 or boot1 partition.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Signed-off-by: Lukasz Majewski <lukma@denx.de>

---

Changes in v3:
- None

 board/liebherr/xea/boot_img_scr.h | 27 ++++++++++
 board/liebherr/xea/xea.c          | 85 +++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 board/liebherr/xea/boot_img_scr.h

diff --git a/board/liebherr/xea/boot_img_scr.h b/board/liebherr/xea/boot_img_scr.h
new file mode 100644
index 0000000000..baa3072b49
--- /dev/null
+++ b/board/liebherr/xea/boot_img_scr.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier:     GPL-2.0+ */
+/*
+ * Struct for boot image source description for placing in last
+ * two SPI NOR flash sectors on legcom.
+ */
+
+struct boot_img_src {
+	u8 magic;	/* Must be 'B' = 0x42 */
+	u8 flags;	/* flags to specify mmcblk[0|1] boot[0|1] */
+	u8 crc8;	/* CRC-8 over above two bytes */
+} __packed;
+
+/*
+ * Bit definition in boot_img_src.flags:
+ *  Bit 0: mmcblk device 0 or 1 (1 - if this bit set)
+ *  Bit 1: mmcblk boot partition 0 or 1.
+ *         for eMMC: boot0 if this bit is cleared, boot1 - if set
+ *         for SD-card the boot partition value will always be 0
+ *         (independent of the value of this bit)
+ *
+ */
+#define BOOT_SRC_MMC1	BIT(0)
+#define BOOT_SRC_PART1	BIT(1)
+
+/* Offset of the first boot image source descriptor in SPI NOR */
+#define SPI_FLASH_BOOT_SRC_OFFS	0xFE0000
+#define SPI_FLASH_SECTOR_SIZE	0x10000
diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
index e4d2eb65cc..c8ac526cb4 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -32,6 +32,11 @@
 #include <errno.h>
 #include <usb.h>
 #include <serial.h>
+#include <u-boot/crc.h>
+#include "boot_img_scr.h"
+
+#include <spi.h>
+#include <spi_flash.h>
 
 #ifdef CONFIG_SPL_BUILD
 #include <spl.h>
@@ -66,6 +71,52 @@ void board_init_f(ulong arg)
 	preloader_console_init();
 }
 
+static struct boot_img_src img_src[2];
+static int spi_load_boot_info(void)
+{
+	struct spi_flash *flash;
+	int err;
+
+	flash = spi_flash_probe(CONFIG_SF_DEFAULT_BUS,
+				CONFIG_SF_DEFAULT_CS,
+				CONFIG_SF_DEFAULT_SPEED,
+				CONFIG_SF_DEFAULT_MODE);
+	if (!flash) {
+		printf("%s: SPI probe err\n", __func__);
+		return -ENODEV;
+	}
+
+	/*
+	 * Load both boot info structs from SPI flash
+	 */
+	err = spi_flash_read(flash, SPI_FLASH_BOOT_SRC_OFFS,
+			     sizeof(img_src[0]),
+			     (void *)&img_src[0]);
+	if (err) {
+		debug("%s: First boot info NOR sector read error %d\n",
+		      __func__, err);
+		return err;
+	}
+
+	err = spi_flash_read(flash,
+			     SPI_FLASH_BOOT_SRC_OFFS + SPI_FLASH_SECTOR_SIZE,
+			     sizeof(img_src[0]),
+			     (void *)&img_src[1]);
+	if (err) {
+		debug("%s: First boot info NOR sector read error %d\n",
+		      __func__, err);
+		return err;
+	}
+
+	debug("%s: BI0 0x%x 0x%x 0x%x\n", __func__,
+	      img_src[0].magic, img_src[0].flags, img_src[0].crc8);
+
+	debug("%s: BI1 0x%x 0x%x 0x%x\n", __func__,
+	      img_src[1].magic, img_src[1].flags, img_src[1].crc8);
+
+	return 0;
+}
+
 static int boot_tiva0, boot_tiva1;
 
 /* Check if TIVAs request booting via U-Boot proper */
@@ -114,6 +165,40 @@ void spl_board_init(void)
 	boot_tiva1 = dm_gpio_get_value(&btiva1);
 }
 
+int spl_mmc_emmc_boot_partition(struct mmc *mmc)
+{
+	int i, src_idx = -1, ret;
+
+	ret = spi_load_boot_info();
+	if (ret) {
+		printf("%s: Cannot read XEA boot info! [%d]\n", __func__, ret);
+		/* To avoid bricking board - by default boot from boot0 eMMC */
+		return 1;
+	}
+
+	for (i = 0; i < 2; i++) {
+		if (img_src[i].magic == 'B' &&
+		    img_src[i].crc8 == crc8(0, &img_src[i].magic, 2)) {
+			src_idx = i;
+			break;
+		}
+	}
+
+	debug("%s: src idx: %d\n", __func__, src_idx);
+
+	if (src_idx < 0)
+		/*
+		 * Always use eMMC (mmcblkX) boot0 if no
+		 * valid image source description found
+		 */
+		return 1;
+
+	if (img_src[src_idx].flags & BOOT_SRC_PART1)
+		return 2;
+
+	return 1;
+}
+
 void board_boot_order(u32 *spl_boot_list)
 {
 	spl_boot_list[0] = BOOT_DEVICE_MMC1;
-- 
2.39.2

