Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A272C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:41:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1042887AE7;
	Thu, 28 Dec 2023 16:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="fxmu65Ad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD5A687A71; Thu, 28 Dec 2023 16:39:38 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B242487AC5
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 1E09C120011;
 Thu, 28 Dec 2023 18:39:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1E09C120011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1703777974;
 bh=y2pbVGEkTZE7GNrDw/ZfqMH9qs4ezQAxa7WLSxHRZnE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=fxmu65AdAwvL02O47JWgVXlGp/eUGjkakfEMgIjvtbwnKBYtchA7GwcKU+5owPeIc
 S+AD++JvIioBh5yVdRbkcNIqVkrOcsDa6TJcIIPQBkv6FYKOfFVn98imI/gqyVraAl
 xwbWrp1+DvjbTS8dRTGJbHp+ZfMhozvgoslKesk5b+bCU1tuYS42B7ai6yAnXKuIVE
 OxBq+n7I79Z7GNe9cpoiSZKMKWMxXhKQawaxkH2KpsrGZVaxqTwapuR5tQiN/H2HRf
 brW6xKwq/1RDde1aAkpzZzxPehvUpxBjUf7VC1td42iwW7/A2KsHsztoM8aO3/nkQz
 s8yKBGpLvayxw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 28 Dec 2023 18:39:33 +0300 (MSK)
Received: from cab-wsm-0029881.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Dec 2023 18:39:33 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <michal.simek@amd.com>, <marex@denx.de>, <michael@walle.cc>,
 <stcarlso@linux.microsoft.com>, <tobias@waldekranz.com>,
 <seanedmond@microsoft.com>, <abdellatif.elkhlifi@arm.com>,
 <neil.armstrong@linaro.org>, <n-jain1@ti.com>, <xypron.glpk@gmx.de>,
 <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <sjg@chromium.org>, <hs@denx.de>,
 <sean.anderson@seco.com>, <dimorinny@google.com>,
 <mkorpershoek@baylibre.com>, <patrick.delaunay@foss.st.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v1 04/12] nand: move nand_erase_opts() to core NAND folder
Date: Thu, 28 Dec 2023 18:39:07 +0300
Message-ID: <20231228153922.84323-5-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231228153922.84323-1-avromanov@salutedevices.com>
References: <20231228153922.84323-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182415 [Dec 28 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/12/28 11:18:00 #22863388
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 28 Dec 2023 16:40:43 +0100
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

Currently nand_erase_opts() placed in the nand/raw/ folder,
because it uses the RAW NAND specific API (struct nand_chip).
This patch move it to core NAND folder and make function generic,
for both RAW/SPI NAND's usage.

Also, nand_erase_opts() used in fastboot/fb_nand.c, cmd/nand.c
and env/nand.c code. This is also the reason why we should move
it to core folder and make it more general.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/mtd/nand/raw/nand_util.c | 153 ----------------------------
 drivers/mtd/nand/util.c          | 166 +++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+), 153 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_util.c b/drivers/mtd/nand/raw/nand_util.c
index 9c18ce63b9..f7704d4697 100644
--- a/drivers/mtd/nand/raw/nand_util.c
+++ b/drivers/mtd/nand/raw/nand_util.c
@@ -32,159 +32,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <nand.h>
-#include <jffs2/jffs2.h>
-
-typedef struct erase_info	erase_info_t;
-
-/* support only for native endian JFFS2 */
-#define cpu_to_je16(x) (x)
-#define cpu_to_je32(x) (x)
-
-/**
- * nand_erase_opts: - erase NAND flash with support for various options
- *		      (jffs2 formatting)
- *
- * @param mtd		nand mtd instance to erase
- * @param opts		options,  @see struct nand_erase_options
- * Return:		0 in case of success
- *
- * This code is ported from flash_eraseall.c from Linux mtd utils by
- * Arcom Control System Ltd.
- */
-int nand_erase_opts(struct mtd_info *mtd,
-		    const nand_erase_options_t *opts)
-{
-	struct jffs2_unknown_node cleanmarker;
-	erase_info_t erase;
-	unsigned long erase_length, erased_length; /* in blocks */
-	int result;
-	int percent_complete = -1;
-	const char *mtd_device = mtd->name;
-	struct mtd_oob_ops oob_opts;
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
-	if ((opts->offset & (mtd->erasesize - 1)) != 0) {
-		printf("Attempt to erase non block-aligned data\n");
-		return -1;
-	}
-
-	memset(&erase, 0, sizeof(erase));
-	memset(&oob_opts, 0, sizeof(oob_opts));
-
-	erase.mtd = mtd;
-	erase.len = mtd->erasesize;
-	erase.addr = opts->offset;
-	erase_length = lldiv(opts->length + mtd->erasesize - 1,
-			     mtd->erasesize);
-
-	cleanmarker.magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
-	cleanmarker.nodetype = cpu_to_je16(JFFS2_NODETYPE_CLEANMARKER);
-	cleanmarker.totlen = cpu_to_je32(8);
-
-	/* scrub option allows to erase badblock. To prevent internal
-	 * check from erase() method, set block check method to dummy
-	 * and disable bad block table while erasing.
-	 */
-	if (opts->scrub) {
-		erase.scrub = opts->scrub;
-		/*
-		 * We don't need the bad block table anymore...
-		 * after scrub, there are no bad blocks left!
-		 */
-		if (chip->bbt) {
-			kfree(chip->bbt);
-		}
-		chip->bbt = NULL;
-		chip->options &= ~NAND_BBT_SCANNED;
-	}
-
-	for (erased_length = 0;
-	     erased_length < erase_length;
-	     erase.addr += mtd->erasesize) {
-
-		schedule();
-
-		if (opts->lim && (erase.addr >= (opts->offset + opts->lim))) {
-			puts("Size of erase exceeds limit\n");
-			return -EFBIG;
-		}
-		if (!opts->scrub) {
-			int ret = mtd_block_isbad(mtd, erase.addr);
-			if (ret > 0) {
-				if (!opts->quiet)
-					printf("\rSkipping %s at  "
-					       "0x%08llx                 "
-					       "                         \n",
-					       ret == 1 ? "bad block" : "bbt reserved",
-					       erase.addr);
-
-				if (!opts->spread)
-					erased_length++;
-
-				continue;
-
-			} else if (ret < 0) {
-				printf("\n%s: MTD get bad block failed: %d\n",
-				       mtd_device,
-				       ret);
-				return -1;
-			}
-		}
-
-		erased_length++;
-
-		result = mtd_erase(mtd, &erase);
-		if (result != 0) {
-			printf("\n%s: MTD Erase failure: %d\n",
-			       mtd_device, result);
-			continue;
-		}
-
-		/* format for JFFS2 ? */
-		if (opts->jffs2 && chip->ecc.layout->oobavail >= 8) {
-			struct mtd_oob_ops ops;
-			ops.ooblen = 8;
-			ops.datbuf = NULL;
-			ops.oobbuf = (uint8_t *)&cleanmarker;
-			ops.ooboffs = 0;
-			ops.mode = MTD_OPS_AUTO_OOB;
-
-			result = mtd_write_oob(mtd, erase.addr, &ops);
-			if (result != 0) {
-				printf("\n%s: MTD writeoob failure: %d\n",
-				       mtd_device, result);
-				continue;
-			}
-		}
-
-		if (!opts->quiet) {
-			unsigned long long n = erased_length * 100ULL;
-			int percent;
-
-			do_div(n, erase_length);
-			percent = (int)n;
-
-			/* output progress message only at whole percent
-			 * steps to reduce the number of messages printed
-			 * on (slow) serial consoles
-			 */
-			if (percent != percent_complete) {
-				percent_complete = percent;
-
-				printf("\rErasing at 0x%llx -- %3d%% complete.",
-				       erase.addr, percent);
-
-				if (opts->jffs2 && result == 0)
-					printf(" Cleanmarker written at 0x%llx.",
-					       erase.addr);
-			}
-		}
-	}
-	if (!opts->quiet)
-		printf("\n");
-
-	return 0;
-}
 
 #ifdef CONFIG_CMD_NAND_LOCK_UNLOCK
 
diff --git a/drivers/mtd/nand/util.c b/drivers/mtd/nand/util.c
index 4a372bb67d..f02c1ef4ca 100644
--- a/drivers/mtd/nand/util.c
+++ b/drivers/mtd/nand/util.c
@@ -28,10 +28,176 @@
 #include <asm/cache.h>
 #include <dm/devres.h>
 
+#include <jffs2/jffs2.h>
 #include <linux/errno.h>
 #include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/rawnand.h>
 #include <nand.h>
 
+typedef struct erase_info	erase_info_t;
+
+/* support only for native endian JFFS2 */
+#define cpu_to_je16(x) (x)
+#define cpu_to_je32(x) (x)
+
+/**
+ * nand_erase_opts: - erase NAND flash with support for various options
+ *		      (jffs2 formatting)
+ *
+ * @param mtd		nand mtd instance to erase
+ * @param opts		options,  @see struct nand_erase_options
+ * Return:		0 in case of success
+ *
+ * This code is ported from flash_eraseall.c from Linux mtd utils by
+ * Arcom Control System Ltd.
+ */
+int nand_erase_opts(struct mtd_info *mtd,
+		    const nand_erase_options_t *opts)
+{
+	struct jffs2_unknown_node cleanmarker;
+	erase_info_t erase;
+	unsigned long erase_length, erased_length; /* in blocks */
+	int result;
+	int percent_complete = -1;
+	const char *mtd_device = mtd->name;
+	struct mtd_oob_ops oob_opts;
+	u32 oobavail = mtd->oobavail;
+#if CONFIG_IS_ENABLED(MTD_RAW_NAND)
+	struct nand_chip *chip = mtd_to_nand(mtd);
+#elif CONFIG_IS_ENABLED(MTD_SPI_NAND)
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+#endif
+
+	if ((opts->offset & (mtd->erasesize - 1)) != 0) {
+		printf("Attempt to erase non block-aligned data\n");
+		return -1;
+	}
+
+	memset(&erase, 0, sizeof(erase));
+	memset(&oob_opts, 0, sizeof(oob_opts));
+
+	erase.mtd = mtd;
+	erase.len = mtd->erasesize;
+	erase.addr = opts->offset;
+	erase_length = lldiv(opts->length + mtd->erasesize - 1,
+			     mtd->erasesize);
+
+	cleanmarker.magic = cpu_to_je16(JFFS2_MAGIC_BITMASK);
+	cleanmarker.nodetype = cpu_to_je16(JFFS2_NODETYPE_CLEANMARKER);
+	cleanmarker.totlen = cpu_to_je32(8);
+
+	/* scrub option allows to erase badblock. To prevent internal
+	 * check from erase() method, set block check method to dummy
+	 * and disable bad block table while erasing.
+	 */
+	if (opts->scrub) {
+		erase.scrub = opts->scrub;
+
+		/*
+		 * We don't need the bad block table anymore...
+		 * after scrub, there are no bad blocks left!
+		 */
+#if CONFIG_IS_ENABLED(MTD_RAW_NAND)
+		if (chip->bbt) {
+			kfree(chip->bbt);
+		}
+		chip->bbt = NULL;
+		chip->options &= ~NAND_BBT_SCANNED;
+#elif CONFIG_IS_ENABLED(MTD_SPI_NAND)
+		if (nanddev_bbt_is_initialized(nand))
+			nanddev_bbt_cleanup(nand);
+#endif
+	}
+
+	for (erased_length = 0;
+	     erased_length < erase_length;
+	     erase.addr += mtd->erasesize) {
+
+		schedule();
+
+		if (opts->lim && (erase.addr >= (opts->offset + opts->lim))) {
+			puts("Size of erase exceeds limit\n");
+			return -EFBIG;
+		}
+		if (!opts->scrub) {
+			int ret = mtd_block_isbad(mtd, erase.addr);
+			if (ret > 0) {
+				if (!opts->quiet)
+					printf("\rSkipping %s at  "
+					       "0x%08llx                 "
+					       "                         \n",
+					       ret == 1 ? "bad block" : "bbt reserved",
+					       erase.addr);
+
+				if (!opts->spread)
+					erased_length++;
+
+				continue;
+
+			} else if (ret < 0) {
+				printf("\n%s: MTD get bad block failed: %d\n",
+				       mtd_device,
+				       ret);
+				return -1;
+			}
+		}
+
+		erased_length++;
+
+		result = mtd_erase(mtd, &erase);
+		if (result != 0) {
+			printf("\n%s: MTD Erase failure: %d\n",
+			       mtd_device, result);
+			continue;
+		}
+
+		/* format for JFFS2 ? */
+		if (opts->jffs2 && oobavail >= 8) {
+			struct mtd_oob_ops ops;
+			ops.ooblen = 8;
+			ops.datbuf = NULL;
+			ops.oobbuf = (uint8_t *)&cleanmarker;
+			ops.ooboffs = 0;
+			ops.mode = MTD_OPS_AUTO_OOB;
+
+			result = mtd_write_oob(mtd, erase.addr, &ops);
+			if (result != 0) {
+				printf("\n%s: MTD writeoob failure: %d\n",
+				       mtd_device, result);
+				continue;
+			}
+		}
+
+		if (!opts->quiet) {
+			unsigned long long n = erased_length * 100ULL;
+			int percent;
+
+			do_div(n, erase_length);
+			percent = (int)n;
+
+			/* output progress message only at whole percent
+			 * steps to reduce the number of messages printed
+			 * on (slow) serial consoles
+			 */
+			if (percent != percent_complete) {
+				percent_complete = percent;
+
+				printf("\rErasing at 0x%llx -- %3d%% complete.",
+				       erase.addr, percent);
+
+				if (opts->jffs2 && result == 0)
+					printf(" Cleanmarker written at 0x%llx.",
+					       erase.addr);
+			}
+		}
+	}
+	if (!opts->quiet)
+		printf("\n");
+
+	return 0;
+}
+
 /**
  * check_skip_len
  *
-- 
2.30.1

