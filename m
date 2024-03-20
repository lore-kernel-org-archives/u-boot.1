Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAC7C54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 09:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B80CF8811B;
	Wed, 20 Mar 2024 10:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="c3+5lxbs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5893D880F3; Wed, 20 Mar 2024 10:02:25 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47387880F8
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 10:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710925337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UC88Tn5WBS0D+oxVQTjTbpzxiT7ycTfRmwEYRg93InU=;
 b=c3+5lxbswbHneCPXqHc+y/YLn+91K+1rtpZWNKWJaf8nK55ogWXJAw+Bv18lsLoBdkGnuh
 1TipFAZzU6EsEXfOciBFpw0HnhU+iFvZQxANin/IB+1Y/rcNW+LwkXAkfaeV3AZM7EYOkt
 V8giblAKP9iS+1hzibs3oElMqNiKHEeec53JCSK2lfwAt9Y27Rb5e4v5HwzfLDFCHIybpS
 zmFjUHcZhL0/l2EgadGcl4rC2STbGq7Fk7skgwpZBoWa6sqEaQAoEbpli1z84yLpKH+1y5
 YDgCGijWNkU6MGeIgoxVRxsx5pfZXCWwjmeiUk1e5XvyaMHAt6sQl/JauxxZUg==
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Mihai Sain <mihai.sain@microchip.com>, Li Bin <bin.li@microchip.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 6/6] cmd: nand: Add new optional sub-command 'onfi'
Date: Wed, 20 Mar 2024 10:02:14 +0100
Message-Id: <20240320090214.40465-7-ada@thorsis.com>
In-Reply-To: <20240320090214.40465-1-ada@thorsis.com>
References: <20240320090214.40465-1-ada@thorsis.com>
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

Override the ONFI timing mode at runtime.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v2:
    - initial patch version (not present in v1)

 cmd/Kconfig                      | 10 ++++++
 cmd/nand.c                       | 61 ++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/nand_base.c |  2 +-
 include/linux/mtd/rawnand.h      |  1 +
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 61e280fb1a4..c39cc297306 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1421,6 +1421,7 @@ config CMD_NAND
 	  NAND support.
 
 if CMD_NAND
+
 config CMD_NAND_TRIMFFS
 	bool "nand write.trimffs"
 	default y if ARCH_SUNXI
@@ -1437,6 +1438,15 @@ config CMD_NAND_TORTURE
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

