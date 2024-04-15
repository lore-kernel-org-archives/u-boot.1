Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F06C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 07:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD13F881EF;
	Mon, 15 Apr 2024 09:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="Ymvd3Djx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2945E881EF; Mon, 15 Apr 2024 09:46:10 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F7008822C
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 21576148CFA2; Mon, 15 Apr 2024 09:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1713167163; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=WtYVL2+stfQf5nP5HjHbbXcuK38LCDMmHMEoArXQ9iY=;
 b=Ymvd3DjxDPdJzWNRulR3N6YGEYJ+pDbNyh2d1nlsyzihVGnMPhb/oZGLTNkAlDWyYiKK7G
 7lrQeJhX5+Q7YRBaggHyuiAiPx1IxptpUKO76u02+NXzg1ZR1GaSgy9Mf6ggrdeQULFdbG
 PtFvtWt54QZkBPo52xyPiL7Pvwgk95uuvLD/khJZ0CsZPr5eDQqtwUTUo0nr5ywxtvb4f2
 jPFfq1wZDRimUcbl9QlGBhtOD+MGNiWoFDEHHHnBvaoTziLNxabhexJMszeiicRokVyJDj
 p6X+3GCw8EfVvbVmXeHLRU1ug1nQM+oO1diqTXZn+YSvaK7i2d/PUi11SpZBJA==
From: Alexander Dahl <ada@thorsis.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>, Li Bin <bin.li@microchip.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3 2/3] cmd: nand: Add new optional sub-command 'onfi'
Date: Mon, 15 Apr 2024 09:45:46 +0200
Message-Id: <20240415074547.779264-3-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415074547.779264-1-ada@thorsis.com>
References: <20240415074547.779264-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Override the ONFI timing mode at runtime.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v3:
    - no changes to this patch
    
    v2:
    - initial patch version (not present in v1)

 cmd/Kconfig                      | 10 ++++++
 cmd/nand.c                       | 61 ++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/nand_base.c |  2 +-
 include/linux/mtd/rawnand.h      |  1 +
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8eeb99eea5e..5dc47bd3f51 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1382,6 +1382,7 @@ config CMD_NAND
 	  NAND support.
 
 if CMD_NAND
+
 config CMD_NAND_TRIMFFS
 	bool "nand write.trimffs"
 	default y if ARCH_SUNXI
@@ -1398,6 +1399,15 @@ config CMD_NAND_TORTURE
 	help
 	  NAND torture support.
 
+config CMD_NAND_ONFI
+	bool "nand onfi"
+	help
+	  Set ONFI timing modes explicitly.
+	  This is a debugging command to switch to slower ONFI timing
+	  modes for testing.
+	  In normal operation determining the timing mode automatically
+	  should work fine, and you don't need this.
+
 endif # CMD_NAND
 
 config CMD_NVME
diff --git a/cmd/nand.c b/cmd/nand.c
index fe834c4ac5c..2b83a5ad1b8 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -494,6 +494,48 @@ static void adjust_size_for_badblocks(loff_t *size, loff_t offset, int dev)
 	}
 }
 
+#ifdef CONFIG_CMD_NAND_ONFI
+static int do_nand_onfi(struct mtd_info *mtd, int mode)
+{
+	struct nand_chip *chip;
+	int ret;
+	int i;
+
+	if (mtd->type != MTD_NANDFLASH) {
+		printf("MTD device is no NAND flash!\n");
+		return CMD_RET_FAILURE;
+	}
+
+	chip = mtd_to_nand(mtd);
+
+	if (mode < 0) {
+		printf("Reporting current ONFI settings not yet supported!\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = onfi_init_data_interface(chip, chip->data_interface,
+				       NAND_SDR_IFACE, mode);
+	if (ret) {
+		printf("onfi_init_data_interface() for mode %d failed with error %d\n",
+		       mode, ret);
+		return CMD_RET_FAILURE;
+	}
+
+	for (i = 0; i < chip->numchips; i++) {
+		chip->select_chip(mtd, i);
+		ret = nand_setup_data_interface(chip, i);
+		chip->select_chip(mtd, -1);
+		if (ret) {
+			printf("nand_setup_data_interface() for mode %d failed with error %d\n",
+			       mode, ret);
+			return CMD_RET_FAILURE;
+		}
+	}
+
+	return CMD_RET_SUCCESS;
+}
+#endif
+
 static int do_nand(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
 {
@@ -919,6 +961,21 @@ static int do_nand(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 #endif
 
+#ifdef CONFIG_CMD_NAND_ONFI
+	/*
+	 * Syntax is:
+	 *   0    1     2
+	 *   nand onfi [mode]
+	 */
+	if (strcmp(cmd, "onfi") == 0) {
+		int mode = -1;
+
+		if (argc > 2)
+			mode = dectoul(argv[2], NULL);
+		return do_nand_onfi(mtd, mode);
+	}
+#endif
+
 usage:
 	return CMD_RET_USAGE;
 }
@@ -961,6 +1018,10 @@ U_BOOT_LONGHELP(nand,
 	"    bring nand to lock state or display locked pages\n"
 	"nand unlock[.allexcept] [offset] [size] - unlock section"
 #endif
+#ifdef CONFIG_CMD_NAND_ONFI
+	"\n"
+	"nand onfi [mode] - set ONFI mode\n"
+#endif
 #ifdef CONFIG_ENV_OFFSET_OOB
 	"\n"
 	"nand env.oob - environment offset in OOB of block 0 of"
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 688d17ba3c2..2384425a746 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -983,7 +983,7 @@ static int nand_onfi_set_timings(struct mtd_info *mtd, struct nand_chip *chip)
  *
  * Returns 0 for success or negative error code otherwise.
  */
-static int nand_setup_data_interface(struct nand_chip *chip, int chipnr)
+int nand_setup_data_interface(struct nand_chip *chip, int chipnr)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 4abaf4734cf..07bc4cc9051 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1315,6 +1315,7 @@ void nand_write_buf16(struct mtd_info *mtd, const uint8_t *buf, int len);
 void nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len);
 void nand_read_buf16(struct mtd_info *mtd, uint8_t *buf, int len);
 uint8_t nand_read_byte(struct mtd_info *mtd);
+int nand_setup_data_interface(struct nand_chip *chip, int chipnr);
 
 /* get timing characteristics from ONFI timing mode. */
 const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode);
-- 
2.39.2

