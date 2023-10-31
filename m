Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688E6C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 10:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765E98709B;
	Tue, 31 Oct 2023 11:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698747390;
	bh=aXmdS5Ms6/0erFqyc3VNhlfRihhyIFCd+S0TC+R5xYI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MmNvnlvZimQuNmI/qCkV46AODV2yODMyDndP++zaOyp6JKa09GqG2M4mOzDtoo+Y4
	 4uXFkkvQMQ+IwjgE2uikqBFRAVpFYskiYl3jvTBAIJL2rLTnrqpPZNnXMq5dsixSv2
	 qZjYNH6tGfkgn8sPqRVjo0OfpEUd4TlVFtLKErugUW916bAshxqAYA9VFQzf7kcArs
	 rkJmYtPlvMCJBmXuQHis5pSEjhxpfN4+S1Q8U1XX6kQUmrGYhYgZPrrqr4PvdCWvgA
	 UdSaQEcp4lNHETgsNFSbTJk3dOvgJkmmFq0oynjPw7a+SCoElSuJ/9h/FvvBZNmHAH
	 l+qCtMpbGek5Q==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DA5E187012;
 Tue, 31 Oct 2023 11:16:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698747389;
 bh=aXmdS5Ms6/0erFqyc3VNhlfRihhyIFCd+S0TC+R5xYI=;
 h=From:To:Cc:Subject:Date:From;
 b=xxkykAgJmkOMuiLQ/3/MddApfqt7u1LprK87KTV0lIWAfs7PFzvqgOqtY3/pR4M4i
 9il/LEcfes/i+ULXJx3/2BPs0coaHbW44NryGqEgVHyoejtIH4mliLvoyylBQihW49
 cmTD3NFo0urvNUPNI6ipm8BqoTmZrLF2uEjKL8G2A9UMmwimkeX1hdcFpsmUSX9WPE
 uDNZaz1CwL3bt184i7I/XuCRPRMlo3xUWuyWdgN3Iil0aUklN+z3reBBQxCCIi7M6f
 1WlKaNbwd0jCPZuENsuNRVr98FhM10geahI3sn3V3tAn3yoQ3YlLH0Vxc/yM10HHXV
 7I5Q/B0rU5LnQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Jaehoon Chung <jh80.chung@samsung.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Roger Knecht <rknecht@pm.me>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v3] cmd: mmc: Add mmc reg read command for reading card
 registers
Date: Tue, 31 Oct 2023 11:15:47 +0100
Message-ID: <20231031101621.24926-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
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
V3: - Return CMD_RET_FAILURE on failure
    - Add RB/TB from Jaehoon
---
 cmd/Kconfig           |  8 ++++
 cmd/mmc.c             | 96 +++++++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/mmc.rst | 26 ++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 60aed2c307c..d8dff42aab7 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1313,6 +1313,14 @@ config CMD_BKOPS_ENABLE
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
index c6bd81cebbc..96befb27eec 100644
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
+			return CMD_RET_FAILURE;
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
2.42.0

