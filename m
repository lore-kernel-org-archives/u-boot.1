Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E7FCD80C1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFCDB869D6;
	Tue, 10 Oct 2023 14:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696942063;
	bh=2/NAfDFD4SeQAtVau2NqkbHSsQha88uP6GTBn3L58o0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O92cIBarU0FZaa+O/HrBpEfcx3joEngMCs/sR7wtdxptM0P5YjcPMtJdtKpy+NJp6
	 iXepPD4SvzO8QSB/52K9XSAsqADb4469IYjsAXm3mV7u3hdl6Dp8eVY9ovJYXrZsUs
	 c5qx0g9jn56c+Fi2YeKh6b5rVzd5govUC0k8m61HkvtyigBhv8bnd6t25dbXjlASCD
	 aJZlxs+V7sdtNkZSkIGU3TQBFpHRmMdDIS2pspBh7m/6C48CfODR0qlylxXFodI4kV
	 FLUvi5ivOgugpS1rQkvMeiRN36zaIfm9uMsiythrWxaHXLZugUHdzsNGaFsRAZNHkC
	 hPxpiuDVnRTlA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DB86581F44;
 Tue, 10 Oct 2023 14:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696942061;
 bh=2/NAfDFD4SeQAtVau2NqkbHSsQha88uP6GTBn3L58o0=;
 h=From:To:Cc:Subject:Date:From;
 b=P0TnSQEfMvX0n287WCDT9OP6lQOSXh77n+bCVRDW8LOlkRY7GeURwAtnkI1qzkFAU
 YBH+/SBHy7PFFZm4RgF3UmYJ07o2Wocb/kEoao/Zqs8K4MpH97+FrBPOstWUTNphff
 VDrnJ/OSZXyUgBv5j+kUxzis/hR8BumBzSiuRyx4izw4Fnj5UA2JTCe8GBDEsUjBWb
 Hx8XSb18qQBFEs665K7737OWEbmhKE+rS5kSTciwBtUXAoS1pRzLEycpiigKJII5Rx
 8y00zga8oRplcppqiMBVVBr6HRleAz7ALNgKgqpCFHexgPKRKVhht1epRmqSGBGBRQ
 Z0ok/ayX7G9wA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ramon Fried <rfried.dev@gmail.com>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v2] cmd: mmc: Add mmc reg read command for reading card
 registers
Date: Tue, 10 Oct 2023 14:47:28 +0200
Message-Id: <20231010124728.7930-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
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

Add extension to the 'mmc' command to read out the card registers.
Currently, only the eMMC OCR/CID/CSD/EXTCSD/RCA/DSR register are
supported. A register value can either be displayed or read into
an environment variable.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Roger Knecht <rknecht@pm.me>
Cc: Sean Edmond <seanedmond@microsoft.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tobias Waldekranz <tobias@waldekranz.com>
---
V2: - Update documentation
---
 cmd/Kconfig           |  8 ++++
 cmd/mmc.c             | 96 +++++++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/mmc.rst | 26 ++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 6470b138d2f..dcd99757a1e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1307,6 +1307,14 @@ config CMD_BKOPS_ENABLE
 	  on a eMMC device. The feature is optionally available on eMMC devices
 	  conforming to standard >= 4.41.
 
+config CMD_MMC_REG
+	bool "Enable support for reading card registers in the mmc command"
+	depends on CMD_MMC
+	default n
+	help
+	  Enable the commands for reading card registers. This is useful
+	  mostly for debugging or extracting details from the card.
+
 config CMD_MMC_RPMB
 	bool "Enable support for RPMB in the mmc command"
 	depends on SUPPORT_EMMC_RPMB
diff --git a/cmd/mmc.c b/cmd/mmc.c
index c6bd81cebbc..c29f44b7a18 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -1110,6 +1110,93 @@ static int do_mmc_boot_wp(struct cmd_tbl *cmdtp, int flag,
 	return CMD_RET_SUCCESS;
 }
 
+#if CONFIG_IS_ENABLED(CMD_MMC_REG)
+static int do_mmc_reg(struct cmd_tbl *cmdtp, int flag,
+		      int argc, char *const argv[])
+{
+	ALLOC_CACHE_ALIGN_BUFFER(u8, ext_csd, MMC_MAX_BLOCK_LEN);
+	struct mmc *mmc;
+	int i, ret;
+	u32 off;
+
+	if (argc < 3 || argc > 5)
+		return CMD_RET_USAGE;
+
+	mmc = find_mmc_device(curr_device);
+	if (!mmc) {
+		printf("no mmc device at slot %x\n", curr_device);
+		return CMD_RET_FAILURE;
+	}
+
+	if (IS_SD(mmc)) {
+		printf("SD registers are not supported\n");
+		return CMD_RET_FAILURE;
+	}
+
+	off = simple_strtoul(argv[3], NULL, 10);
+	if (!strcmp(argv[2], "cid")) {
+		if (off > 3)
+			return CMD_RET_USAGE;
+		printf("CID[%i]: 0x%08x\n", off, mmc->cid[off]);
+		if (argv[4])
+			env_set_hex(argv[4], mmc->cid[off]);
+		return CMD_RET_SUCCESS;
+	}
+	if (!strcmp(argv[2], "csd")) {
+		if (off > 3)
+			return CMD_RET_USAGE;
+		printf("CSD[%i]: 0x%08x\n", off, mmc->csd[off]);
+		if (argv[4])
+			env_set_hex(argv[4], mmc->csd[off]);
+		return CMD_RET_SUCCESS;
+	}
+	if (!strcmp(argv[2], "dsr")) {
+		printf("DSR: 0x%08x\n", mmc->dsr);
+		if (argv[4])
+			env_set_hex(argv[4], mmc->dsr);
+		return CMD_RET_SUCCESS;
+	}
+	if (!strcmp(argv[2], "ocr")) {
+		printf("OCR: 0x%08x\n", mmc->ocr);
+		if (argv[4])
+			env_set_hex(argv[4], mmc->ocr);
+		return CMD_RET_SUCCESS;
+	}
+	if (!strcmp(argv[2], "rca")) {
+		printf("RCA: 0x%08x\n", mmc->rca);
+		if (argv[4])
+			env_set_hex(argv[4], mmc->rca);
+		return CMD_RET_SUCCESS;
+	}
+	if (!strcmp(argv[2], "extcsd") &&
+	    mmc->version >= MMC_VERSION_4_41) {
+		ret = mmc_send_ext_csd(mmc, ext_csd);
+		if (ret)
+			return ret;
+		if (!strcmp(argv[3], "all")) {
+			/* Dump the entire register */
+			printf("EXT_CSD:");
+			for (i = 0; i < MMC_MAX_BLOCK_LEN; i++) {
+				if (!(i % 10))
+					printf("\n%03i: ", i);
+				printf(" %02x", ext_csd[i]);
+			}
+			printf("\n");
+			return CMD_RET_SUCCESS;
+		}
+		off = simple_strtoul(argv[3], NULL, 10);
+		if (off > 512)
+			return CMD_RET_USAGE;
+		printf("EXT_CSD[%i]: 0x%02x\n", off, ext_csd[off]);
+		if (argv[4])
+			env_set_hex(argv[4], ext_csd[off]);
+		return CMD_RET_SUCCESS;
+	}
+
+	return CMD_RET_FAILURE;
+}
+#endif
+
 static struct cmd_tbl cmd_mmc[] = {
 	U_BOOT_CMD_MKENT(info, 1, 0, do_mmcinfo, "", ""),
 	U_BOOT_CMD_MKENT(read, 4, 1, do_mmc_read, "", ""),
@@ -1142,6 +1229,9 @@ static struct cmd_tbl cmd_mmc[] = {
 	U_BOOT_CMD_MKENT(bkops-enable, 2, 0, do_mmc_bkops_enable, "", ""),
 	U_BOOT_CMD_MKENT(bkops, 4, 0, do_mmc_bkops, "", ""),
 #endif
+#if CONFIG_IS_ENABLED(CMD_MMC_REG)
+	U_BOOT_CMD_MKENT(reg, 5, 0, do_mmc_reg, "", ""),
+#endif
 };
 
 static int do_mmcops(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -1229,6 +1319,12 @@ U_BOOT_CMD(
 	"   WARNING: This is a write-once setting.\n"
 	"mmc bkops <dev> [auto|manual] [enable|disable]\n"
 	" - configure background operations handshake on device\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MMC_REG)
+	"mmc reg read <reg> <offset> [env] - read card register <reg> offset <offset>\n"
+	"                                    (optionally into [env] variable)\n"
+	" - reg: cid/csd/dsr/ocr/rca/extcsd\n"
+	" - offset: for cid/csd [0..3], for extcsd [0..511,all]\n"
 #endif
 	);
 
diff --git a/doc/usage/cmd/mmc.rst b/doc/usage/cmd/mmc.rst
index 71a0303109c..c0924ba5769 100644
--- a/doc/usage/cmd/mmc.rst
+++ b/doc/usage/cmd/mmc.rst
@@ -21,6 +21,7 @@ Synopsis
     mmc bootpart-resize <dev> <dev part size MB> <RPMB part size MB>
     mmc partconf <dev> [[varname] | [<boot_ack> <boot_partition> <partition_access>]]
     mmc rst-function <dev> <value>
+    mmc reg read <reg> <offset> [env]
 
 Description
 -----------
@@ -183,6 +184,31 @@ The 'mmc rst-function' command changes the RST_n_FUNCTION field.
         0x3
             Reserved
 
+The 'mmc reg read <reg> <offset> [env]' reads eMMC card register and
+either print it to standard output, or store the value in environment
+variable.
+
+<reg> with
+optional offset <offset> into the register array, and print it to
+standard output or store it into environment variable [env].
+
+    reg
+        cid
+            The Device IDentification (CID) register. Uses offset.
+        csd
+            The Device-Specific Data (CSD) register. Uses offset.
+        dsr
+            The driver stage register (DSR).
+        ocr
+            The operation conditions register (OCR).
+        rca
+            The relative Device address (RCA) register.
+        extcsd
+            The Extended CSD register. Uses offset.
+    offset
+        For 'cid'/'csd' 128 bit registers '[0..3]' in 32-bit increments. For 'extcsd' 512 bit register '[0..512,all]' in 8-bit increments, or 'all' to read the entire register.
+    env
+        Optional environment variable into which 32-bit value read from register should be stored.
 
 Examples
 --------
-- 
2.40.1

