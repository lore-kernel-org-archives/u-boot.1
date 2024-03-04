Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B51C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 16:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F37F787FB1;
	Mon,  4 Mar 2024 17:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709568981;
	bh=JGCDRXAFZVvzpSl+d73MoQEMAIc76AQTCtBZbg/3G6M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CZLUBerQjfe4wPoIfDjILYd5RMOPCx2v0hed/hjh7PojdNCzYpgYHr4hFhOkz6wNU
	 qRPat7x4bNBDeDx9E6gLyjxVhOCpETBgZvWTmRq2YUhulBtEYp5H9Gt1v5H2zuHiAe
	 X9jONZ+Es3hIVeN+oQW/5ixShQnHJkK9CVGWbNZrfGKgaZdjpo7OvtHNNKjwXNqDrx
	 wZ9Xv9q61huHnidgSw2HtFoHOvHxeLsqeE9hO1ZHSfzECNwd/hHgB5ygu/nPOkjXj5
	 Gn5HMIGlmPdJ3elyciVJsneoOVRw80PmqlDsTWWn0BUGKOfIYr0W8onu1hX6aeH8qD
	 TfbndwdGNxjzw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A969287F7F;
 Mon,  4 Mar 2024 17:16:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709568979;
 bh=JGCDRXAFZVvzpSl+d73MoQEMAIc76AQTCtBZbg/3G6M=;
 h=From:To:Cc:Subject:Date:From;
 b=qgk/LM4I523Tg18eKzvmGRWMZj4GEeYd8ETuQGgQnqwUoArfnDOrqkSmr3SbQ5v4Q
 bUpMuWP7A01ebZy+Ps+LWxtEpGh8Mr85lQz+JlVb/rkCiP+FpHc4N/BMl4dyjsjzj9
 2PwwVCNBNBq2+tsX8a1h+NMU/Z0llZeJLvveoWn8SMbYUPyTFErbSK3R5hNrqelhNL
 UWNPAYIAdZzEHhfZxLDKvjuKkIYW92XJQ/HPnjcj+oojdQCyycC5cgCdV/LuYm82lI
 d+jq+C4HazGcscKhBT6j44P9oEdI6hffIDkOxKAnAnmhNxomt1nz0qGLyYMbZk3zay
 2cqSD/9n+PqHw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Johann Neuhauser <jneuhauser@dh-electronics.com>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
Date: Mon,  4 Mar 2024 17:16:05 +0100
Message-ID: <20240304161607.82759-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Some Winbond SPI NORs have special SR3 register which is
used among other things to control whether non-standard
"Individual Block/Sector Write Protection" (WPS bit)
locking scheme is activated. This non-standard locking
scheme is not supported by either U-Boot or Linux SPI
NOR stack so make sure it is disabled, otherwise the
SPI NOR may appear locked for no obvious reason.

This SR3 WPS appears e.g. on W25Q16FW which has the same ID as
W25Q16DW, but the W25Q16DW does not implement the SR3 WPS bit.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Johann Neuhauser <jneuhauser@dh-electronics.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Vignesh R <vigneshr@ti.com>
---
 drivers/mtd/spi/spi-nor-core.c | 47 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |  5 ++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 9a1801ba93d..68dee57258d 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -544,6 +544,24 @@ static int read_cr(struct spi_nor *nor)
 }
 #endif
 
+/**
+ * read_sr3() - Read status register 3 unique to newer Winbond flashes
+ * @nor:	pointer to a 'struct spi_nor'
+ */
+static int read_sr3(struct spi_nor *nor)
+{
+	int ret;
+	u8 val;
+
+	ret = nor->read_reg(nor, SPINOR_OP_RDSR3, &val, 1);
+	if (ret < 0) {
+		dev_dbg(nor->dev, "error %d reading SR3\n", ret);
+		return ret;
+	}
+
+	return val;
+}
+
 /*
  * Write status register 1 byte
  * Returns negative if error occurred.
@@ -554,6 +572,17 @@ static int write_sr(struct spi_nor *nor, u8 val)
 	return nor->write_reg(nor, SPINOR_OP_WRSR, nor->cmd_buf, 1);
 }
 
+/**
+ * write_sr3() - Write status register 3 unique to newer Winbond flashes
+ * @nor:	pointer to a 'struct spi_nor'
+ * @val:	value to be written into SR3
+ */
+static int write_sr3(struct spi_nor *nor, u8 val)
+{
+	nor->cmd_buf[0] = val;
+	return nor->write_reg(nor, SPINOR_OP_WRSR3, nor->cmd_buf, 1);
+}
+
 /*
  * Set write enable latch with Write Enable command.
  * Returns negative if error occurred.
@@ -3890,6 +3919,24 @@ static int spi_nor_init(struct spi_nor *nor)
 		write_enable(nor);
 		write_sr(nor, 0);
 		spi_nor_wait_till_ready(nor);
+
+		/*
+		 * Some Winbond SPI NORs have special SR3 register which is
+		 * used among other things to control whether non-standard
+		 * "Individual Block/Sector Write Protection" (WPS bit)
+		 * locking scheme is activated. This non-standard locking
+		 * scheme is not supported by either U-Boot or Linux SPI
+		 * NOR stack so make sure it is disabled, otherwise the
+		 * SPI NOR may appear locked for no obvious reason.
+		 */
+		if (JEDEC_MFR(nor->info) == SNOR_MFR_WINBOND) {
+			err = read_sr3(nor);
+			if (err > 0 && err & SR3_WPS) {
+				write_enable(nor);
+				write_sr3(nor, err & ~SR3_WPS);
+				write_disable(nor);
+			}
+		}
 	}
 
 	if (nor->quad_enable) {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 2861b73edbc..ceb32e3906f 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -45,6 +45,8 @@
 #define SPINOR_OP_WRSR		0x01	/* Write status register 1 byte */
 #define SPINOR_OP_RDSR2		0x3f	/* Read status register 2 */
 #define SPINOR_OP_WRSR2		0x3e	/* Write status register 2 */
+#define SPINOR_OP_RDSR3		0x15	/* Read status register 3 */
+#define SPINOR_OP_WRSR3		0x11	/* Write status register 3 */
 #define SPINOR_OP_READ		0x03	/* Read data bytes (low frequency) */
 #define SPINOR_OP_READ_FAST	0x0b	/* Read data bytes (high frequency) */
 #define SPINOR_OP_READ_1_1_2	0x3b	/* Read data bytes (Dual Output SPI) */
@@ -185,6 +187,9 @@
 /* Status Register 2 bits. */
 #define SR2_QUAD_EN_BIT7	BIT(7)
 
+/* Status Register 3 bits. */
+#define SR3_WPS			BIT(2)
+
 /* For Cypress flash. */
 #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
 #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
-- 
2.43.0

