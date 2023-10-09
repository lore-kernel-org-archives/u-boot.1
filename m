Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0241EE81E18
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 23:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D88E0864A7;
	Tue, 10 Oct 2023 01:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696893317;
	bh=gWz6RzBG7dNOuY3asQQVeYsP9Bz4b//1KRGdya+JWBA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SXTuLnqHD+m9hhj5NRNt70c7qHOfzzmC+Lbj7OlQoO7V12on1PGSHMSDAS6Y7n/mb
	 nGyNr4lRp70wGAM0YKZCgHULBf545sFLQgHBI6hh9cVOJlXahbi2+noVG8SDaNKE2W
	 D7TlCwxvbhfH/ASMx+zzRd4BuA65ObtUv+rWCNOMes6+o9kyrR+nNEg7s/ZP38ZdZ1
	 +CS001KGXsgW+rbPgbKwlm0AClyD1tbq0bEnkpFgiaHevjzTadGHbDdGcgbKyyjQlx
	 zJxDVkz51FKmXfuAHmZOC75FhcQAWFy8Ev1fPKbojiBxVImOdLEsYd063liOf0E3mJ
	 v8B4MnxSUnwBA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BBEDF86459;
 Tue, 10 Oct 2023 01:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696893313;
 bh=gWz6RzBG7dNOuY3asQQVeYsP9Bz4b//1KRGdya+JWBA=;
 h=From:To:Cc:Subject:Date:From;
 b=KmDCOItMzgFLtLT5oT0XsOdfTPVsQbADZsNMjTpVlZ4wuujGl9H7QAxXGqUTDu++7
 Dt6Yd4KMzB8Ucz+aBrjB9zBjY/0lAwW9oUO4D+jfM7VqopcrUMWCqxArhLvSbAAy5a
 JOb/v1rBOH1+br844QzOgekl4qemG7l08im52f/oMoliziECvXVEHGozSmenfvuZCW
 RjdNwTAjx3x2tBl1axzwvFcqoCxv8v1a2fHHnA2NBR3gUj9+Qoaylp3svDVuFhnGL6
 er7OUL+pmHPXuL5KkkJ300oAxsp6XU0aTGhev1nT3fE6lZixF+6cJ1YB/qRDD8LcQu
 C16u3xh2vJj3Q==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ramon Fried <rfried.dev@gmail.com>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH] cmd: mmc: Add mmc reg read command for reading card registers
Date: Tue, 10 Oct 2023 01:14:58 +0200
Message-Id: <20231009231458.354400-1-marex@denx.de>
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
 cmd/Kconfig |  8 +++++
 cmd/mmc.c   | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

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
 
-- 
2.40.1

