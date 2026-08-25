Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E881DC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8F4440648;
	Tue, 25 Aug 2026 22:50:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2NqxkRAxImzw; Tue, 25 Aug 2026 22:50:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698229;
	bh=4Y/63duLEmhySOpdaE6c3xfU7RfI3aLttzc633/w7bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C/kMDPk0c9KPnLmhtWGAPO3LMOvb4QmhkOO0VY+D0kwO3XlGPFxqHrDbkffpZ62V6
	 xmF5WtiX7d2pqAt/0h2vzKsQE3H2OHNnKJTpSHnrdTO5c8/jNAoWgULloJFXRhmcbA
	 8Tj5VCXjoVyHWr28G150+86h9x5bsRpmxFP/FVQXlGPxVCjPRGqJNNbCYIbZolotDj
	 yKLOLKqa2wFEfayZfTLO8Tz/A+R/QNzISAJnpU4HWYCOv7xithPyNQZe/Cn9cgPpUY
	 Vq6xpYxtbzYbG0VSXm500NLBOhVLJXlGlrSP1b4k/Vq93Ikb11V3p/Gx8DTiYeN/H9
	 CeGu2f1ZOOXVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFCB6406E5;
	Tue, 25 Aug 2026 22:50:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A97E2FD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D18E400A4
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VBVGoLdrgc8z for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:44:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=XaWkwa3X
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp2.osuosl.org (Postfix) with ESMTPS id 4EEB04008D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697847; bh=4Y/63duLEmhySOpdaE6c3xfU7RfI3aLttzc633/w7bM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=XaWkwa3XV/iyYUkZTly7uVtw2u/jlQuWRhLy5QyC5i3zqAThjc1UkVUiQaSGtpCEA1+dfcLiAfX2WCM+JoP9jwUCWQ2X4lVu/x3sJBBZbUPF6tINTVbjQoqrjGtcUficKjpgz3Tpii8mV8bPgtQ/cykZ5IWI4uWbGi3Yw61KTMUIm199RqHK+RvjO/lEftydNM5rcpnjFAsgN3PMZD8r6NzjGGN9AXCo8Yvyx25l/CP4mDOCX9gGWUy9JWHF3hqYPAOf1uRYWl7eirOq/Xqik+El/i6Z3q/4D6xNeGMFAtLXx7lNXR+ZDGKwa1rMDca3HC8fRsUSjEPCUaOoHxSV9A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697847; bh=N4FHaWwRMcY4cUuGAFns5Bsnmc3q59P0bQ2Glul2eNb=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=Sdk+tncZjYAQSKqMWITFD3UVx6avFyPYzDOAWNgg6eGxkAWY9rBEd08mP5YkaO8SODKrsS3RXwM9908rC/tx6dGs5LHAc4k57awqDh5UcI2sCNlPAw+NsrmQvR0x8edX5BTW37XkAm5etXX6p6mCUALWBexh9IYAIi3UVMFLGsU6wKB6WDxH2Sn1CcPPed6gkGq1zw26tS10bzrOABH2LskREmU9fglmjz4smwA0JNKfRmeqRQX+GFV4U5Y5pe2eH76rlCFbN5uubgwGPHo01EquWQC35e3YYcZ/is1vchcKjC1Ki6+GAZyanQRehRMX8rGrHTi3f8rhhmppgy6+3g==
X-YMail-OSG: lRA.l8AVM1kKtJOCiEv94JdYA4RTJQREVbUu0F.XqLrDJ6_bTX8weu3C3qBGIDT
 ZPGCDe11TpfkboH2uM73s9VnOPkpIZmbFtPiKEOdhwxEc0M4lOuI8l1GIiYWSM2rAL6DBHlrrllt
 6gxkz0KW7_zM32aAAaySvUypWUdqb_tqrK6OZ6L2vWgTHTnnmZ0CCy3P6HBQZ0Ija9LOEqra_apW
 O5qGHryx1f.IjsqLedmSBX97mx1qGLIMF9LkRSw4nKayLIqJxWUV90.5u2raRBpzKQWAq8JyETZG
 oVK2GkzJ0Zdrlal.u8YCfylGnlGCIhLZDIepNvKD39sctl2Xzola.DWxgJGICzJ5Q6yzrCTA8ZY5
 wmSpegXS0BPgniVlSv7ybz7lQKuhORX9rnCZ3rKpYZLoaqt87nF_BESW9gR33636UVNI.sgYTdlK
 s9nECnrt3HmnV2uNrJ2jl_hcjU16RGwnQlsakYmlInt0GG5aR_zB8Q8rorI963MQxOgzfaj4QItv
 XVQfl1WxZVXO8YoWw7ZvQCT4U.qR9eZg.8ONUTcHVWtRA80Ju1eNRhXAxyvUIlW5M9OX5xFpkYGV
 PX3IPRRHXdK1rwmbu03_DFv7RBCwlKArRAHTePBKLr5bciL6L4u7YT1xTPgYY_qvZn2N7jEhQxeW
 SvPXK56nR3D9cP8KnwiLlcMTpOqPoFBHCdFzsrNAr2Sr3ojwlQJs6StBBcDMkkuaY_AbOd3gToCV
 OQVYx8ohlcpwmiCQUgiqJet.JDaGw.TvEXx78Kf46eujhcduAdg9gloIYy0qpbv.BRUaHcKCpMmS
 LMIM02Wybyxl6ON.zQijHHoPp9b738QlO1Ohg_lDRoLFEU3HdGGjC1HZL9xb2OgXYw.gCuNZl8UM
 Vj4ygMcSecHtGMNJvLhF7xFI.7svi.X71r8zPM2MKjeAExg9NVylQ065VckBqU9lE8l98A3WIFxR
 NnMmt34XkwT09wJ0wFco5IIf.1ilCDceA467kOl1iJZbNbuVFkuF3IbzLUzwnEg89SdugJQp6sEw
 wVxoeCJdx8pNRrkH9mAlWr_70sCG5tI0sjt8G5TaJMqpOwW4jkJnGzDn85cDw3BOpynOPj98Af2K
 mtI2zDx80xstHASxnyExy1l5PaBKZ8Bff76suhmW_HXhvYBRDO_LEUtnL_ew1dfNRSVCNZuzCKq.
 K75EWxuh4D1Ih040c3TLl8EJup91Thoritohb3jtC6MJaRVUkgaCBCd2_AB4WRCLczotMUeJmYky
 hDMZAzT4AZ_l5cRgRLjFCfNf8dq.g3Xe9gfGNzieAbc7eesK5e2Qz6dU5gCP95AnxmK6yKBrqCEW
 JFpvbAXqDYneR9neeviXmblR83WtyjUMxsuMiMcKgLooERB_c1FsR4PX_1tsU2rCiVuQeeRMvo6l
 pmTrtrANskbyPEoiBypHPtRBClBVsIEeoQMwcacJFdu74oon1JMMFl6GE35ZFbgtAM64xDgdFipm
 ARo4ccg8pRRwB9cTZMbhKSdXdnNuRhMNtVziyr6sUqtK3MhG0k5oe7ou1nbaFrfKn2pVSbSp_uIs
 OIRS4dlcDivPU1WWRs6B.tXqdeYG5YTIh7mq85s_d40RoYkcGdabFY9tmMRxtNnXfayOpWtmnkD1
 RqGfxjXgdgzVGck1HaiY1QUHHpclI8wFEQVqXb5vh.wEWwTENUvo2hfOHSbFvvzeXMJ3kW5yqEBg
 u5CaNPTNsHecDcmzMx4NthIET.x5EcxmZ2d2e2J4R5tOKyJOCv9nRSchrrDCAt3IVAoOiLUrNe90
 EGV4rXctvShva.nPX.npo53mmtDAcIyqN3y1HbaG6feDkH5tcSbZDODJE3Q_syb567bYx86qWgE6
 8AMu6LsVwrC4ETPk1rfKGttB.sVXBDkUEMwYnGk9W0cTwDJODEcQT.QLKXr1N1KWsalO8V6vM3rQ
 LspfPtZ9iOI2pKYzkxS7JVmjklA5drkwqMrhUcW52gnOgd_RRzF1TuA6ok4XPqLe5ylWFkhNnQ_h
 HesJ7DxHtUB2bEjldIW9phXBZQ88_jVNwqImCZm.pjKVhW1_4PK2wor5ey9bfZjw3fznNTknMhua
 mwVe4GD4-
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: d33436e6-c0ee-42e5-89de-cfc52af04a3d
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 25 Aug 2026 22:44:07 +0000
Received: from dip125.lsn.sg3.yahoo.com ([106.10.223.134])
 by hello (SMTP) with SMTP ID 692ceff9cbf31ebf3ce1df27c5387b11;
 Tue, 25 Aug 2026 22:44:03 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v1 05/12] mtd: spi-nand: add EN75 BMT bad-block management
 support
Date: Wed, 26 Aug 2026 04:12:00 +0530
Message-ID: <20260825224330.713151-6-maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825224330.713151-1-maskachoska@yahoo.com>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 22:49:58 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add read support for the EcoNet/Airoha BMT/BBT (bad-block management
table) layout used by the EN75xx vendor bootloaders, so U-Boot maps the
SPI-NAND logical blocks the same way as the vendor firmware.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 drivers/mtd/nand/spi/Kconfig    |   8 +
 drivers/mtd/nand/spi/Makefile   |   1 +
 drivers/mtd/nand/spi/core.c     |   9 +-
 drivers/mtd/nand/spi/en75_bmt.c | 665 ++++++++++++++++++++++++++++++++
 drivers/mtd/nand/spi/en75_bmt.h |  24 ++
 5 files changed, 706 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/en75_bmt.c
 create mode 100644 drivers/mtd/nand/spi/en75_bmt.h

diff --git a/drivers/mtd/nand/spi/Kconfig b/drivers/mtd/nand/spi/Kconfig
index 1124dada..09531914 100644
--- a/drivers/mtd/nand/spi/Kconfig
+++ b/drivers/mtd/nand/spi/Kconfig
@@ -6,3 +6,11 @@ menuconfig MTD_SPI_NAND
 	select SPI_MEM
 	help
 	  This is the framework for the SPI NAND device drivers.
+
+config MTD_EN75_BMT
+	bool "EcoNet EN75xx vendor BMT/BBT translation (read-only)"
+	depends on MTD_SPI_NAND
+	help
+	  Honour the EcoNet/Airoha factory BBT and BMT so logical NAND
+	  addresses match the bootbase and Linux. Read-only: never rewrite
+	  the tables.
diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index a7a0b2cb..20aa718d 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 spinand-objs := core.o otp.o
+spinand-objs += $(if $(CONFIG_MTD_EN75_BMT),en75_bmt.o)
 spinand-objs += alliancememory.o ato.o esmt.o fmsh.o foresee.o gigadevice.o macronix.o
 spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 14af4264..29fdefe2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -33,6 +33,7 @@
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
 #include <linux/delay.h>
+#include "en75_bmt.h"
 #endif
 
 struct spinand_plat {
@@ -1703,15 +1704,21 @@ static int spinand_probe(struct udevice *dev)
 #ifndef __UBOOT__
 	ret = mtd_device_register(mtd, NULL, 0);
 #else
+	ret = en75_bmt_attach(mtd);
+	if (ret)
+		goto err_spinand_cleanup;
+
 	ret = add_mtd_device(mtd);
 #endif
 	if (ret)
-		goto err_spinand_cleanup;
+		goto err_bmt_detach;
 
 	plat->mtd = mtd;
 
 	return 0;
 
+err_bmt_detach:
+	en75_bmt_detach(mtd);
 err_spinand_cleanup:
 	spinand_cleanup(spinand);
 
diff --git a/drivers/mtd/nand/spi/en75_bmt.c b/drivers/mtd/nand/spi/en75_bmt.c
new file mode 100644
index 00000000..1cb3ca01
--- /dev/null
+++ b/drivers/mtd/nand/spi/en75_bmt.c
@@ -0,0 +1,665 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * EcoNet/Airoha EN75xx vendor BMT/BBT translation layer (READ-ONLY).
+ *
+ * The vendor bootbase and the Linux en75_bmt driver do not "skip" bad NAND
+ * blocks the way stock MTD does - they *remap* them into a reserve pool kept at
+ * the top of the chip, so that a logical block keeps a stable address after a
+ * block goes bad. A bootloader that ignores this reads the wrong data on any
+ * device that has ever remapped a block.
+ *
+ * This is a deliberately read-only port of that scheme:
+ *
+ *   - the factory Bad Block Table ("RAWB") and the Block Mapping Table ("BMT")
+ *     are located, checksum-verified and parsed,
+ *   - every MTD access is translated logical -> physical exactly as the vendor
+ *     does (BBT shift-up, then BMT lookup),
+ *   - mtd->size is reduced to the user area so partitions land where Linux and
+ *     the bootbase expect them,
+ *   - *nothing is ever written to the tables*. If a block turns bad we report
+ *     the error upward instead of allocating a replacement; leave repair to
+ *     Linux, which implements the full scheme.
+ *
+ * Deliberately NOT ported: BBT reconstruction / factory-BBT writing. Rewriting
+ * the factory BBT shifts the physical address of every block above the first
+ * bad one, which in a bootloader means bricking the board. Omission is the
+ * safest form of "disabled".
+ *
+ * Derived from the Linux drivers by Caleb James DeLisle:
+ *   target/linux/econet/files/drivers/mtd/nand/en75_bmt.c   (back end)
+ *   target/linux/generic/files/drivers/mtd/nand/mtk_bmt.c   (MTD glue)
+ */
+
+#include <malloc.h>
+#include <asm/cache.h>
+#include <dm/ofnode.h>
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/mtd/mtd.h>
+#include <linux/printk.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "en75_bmt.h"
+
+#define LOG_PFX				"en75_bmt"
+
+/* Vendor firmware calls this POOL_GOOD_BLOCK_PERCENT. Must agree with the
+ * bootbase, which prints the resulting figure as "bmt pool size: N".
+ */
+#define REQUIRED_GOOD_BLOCKS(total)	((total) * 8 / 100)
+
+#define MAX_BMT_SIZE			256
+#define MAX_BBT_SIZE			1000
+#define DEFAULT_BBT_TABLE_SIZE		1000
+#define INITIAL_READ_TRIES		3
+
+/* Marked bad by the Linux driver (the bootbase uses 0x00 for everything). */
+#define BLOCK_WORN_MARK			0x55
+
+/*
+ * On-disk structures. All multi-byte fields are host-order little-endian.
+ */
+
+struct bmt_table_header {
+	char signature[3];	/* "BMT" */
+	u8 version;		/* 1 */
+	u8 bad_count;		/* unused */
+	u8 size;		/* number of mappings */
+	u8 checksum;		/* bmt_checksum() */
+	u8 reserved[13];
+};
+
+static_assert(sizeof(struct bmt_table_header) == 20);
+
+struct bmt_entry {
+	u16 from;		/* physical (post-BBT-shift) block being replaced */
+	u16 to;			/* reserve block standing in for it */
+};
+
+struct bmt_table {
+	struct bmt_table_header header;
+	struct bmt_entry table[MAX_BMT_SIZE];
+};
+
+struct bbt_table_header {
+	char signature[4];	/* "RAWB" */
+	u32 checksum;		/* bbt_checksum(), only 16 bits used */
+	u8 version;		/* 1 */
+	u8 size;		/* number of bad blocks */
+	u8 reserved[2];		/* 0xffff */
+};
+
+static_assert(sizeof(struct bbt_table_header) == 12);
+
+struct bbt_table {
+	struct bbt_table_header header;
+	u16 table[MAX_BBT_SIZE];	/* ascending order required */
+};
+
+static_assert(sizeof(struct bbt_table) == 2012);
+
+/*
+ * Runtime state. Single instance: there is one NAND chip on these boards, and
+ * the Linux driver makes the same assumption.
+ */
+struct en75_bmt {
+	struct mtd_info *mtd;
+
+	/* saved raw ops - internal I/O must bypass our own translation */
+	int (*_read_oob)(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops);
+	int (*_write_oob)(struct mtd_info *mtd, loff_t to, struct mtd_oob_ops *ops);
+	int (*_erase)(struct mtd_info *mtd, struct erase_info *instr);
+	int (*_block_isbad)(struct mtd_info *mtd, loff_t ofs);
+	int (*_block_markbad)(struct mtd_info *mtd, loff_t ofs);
+
+	struct bbt_table bbt;
+	struct bmt_table bmt;
+
+	u16 bbt_table_size;
+	u16 total_blks;
+	u16 reserve_area_begin;
+	u32 blk_size;
+	u32 pg_size;
+	u16 blk_shift;
+	u16 pg_shift;
+
+	u8 *data_buf;
+	bool attached;
+};
+
+static struct en75_bmt bmtd;
+
+static inline u32 blk_pg(u16 block)
+{
+	return (u32)(block << (bmtd.blk_shift - bmtd.pg_shift));
+}
+
+/* Read via the *saved* op: reserve-area offsets sit above the shrunken
+ * mtd->size and would be rejected by the bounds-checked wrappers, and going
+ * through our own translation here would recurse.
+ */
+static int bbt_nand_read(u32 page, u8 *dat, int dat_len, u8 *fdm, int fdm_len)
+{
+	struct mtd_oob_ops ops = {
+		.mode = MTD_OPS_PLACE_OOB,
+		.ooboffs = 0,
+		.oobbuf = fdm,
+		.ooblen = fdm_len,
+		.datbuf = dat,
+		.len = dat_len,
+	};
+	int ret;
+
+	ret = bmtd._read_oob(bmtd.mtd, (loff_t)page << bmtd.pg_shift, &ops);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+/*
+ * In-memory helpers (no I/O)
+ */
+
+static u16 bbt_checksum(const struct bbt_table *bbt, u16 table_size)
+{
+	const u8 *data = (const u8 *)bbt->table;
+	u16 checksum = bbt->header.version + bbt->header.size;
+	int i;
+
+	for (i = 0; i < table_size * (int)sizeof(bbt->table[0]); i++)
+		checksum += data[i];
+
+	return checksum;
+}
+
+static u8 bmt_checksum(const struct bmt_table *bmt, int check_entries)
+{
+	const u8 *data = (const u8 *)&bmt->table;
+	u8 checksum = bmt->header.version + bmt->header.size;
+	int length, i;
+
+	if (check_entries > MAX_BMT_SIZE)
+		check_entries = MAX_BMT_SIZE;
+	length = check_entries * (int)sizeof(bmt->table[0]);
+	for (i = 0; i < length; i++)
+		checksum += data[i];
+
+	return checksum;
+}
+
+static void sort_bbt(struct bbt_table *bbt)
+{
+	int i, j;
+
+	/* Insertion sort: at most a few hundred u16s, and it avoids pulling in
+	 * qsort() for something this small. Ascending order is required both by
+	 * the shift algorithm below and by the vendor firmware.
+	 */
+	for (i = 1; i < bbt->header.size; i++) {
+		u16 key = bbt->table[i];
+
+		for (j = i - 1; j >= 0 && bbt->table[j] > key; j--)
+			bbt->table[j + 1] = bbt->table[j];
+		bbt->table[j + 1] = key;
+	}
+}
+
+/*
+ * Stage 1: each factory-bad block shifts everything above it up by one. This
+ * is a shift, not a skip-list, which is why the BBT must be sorted and why
+ * changing it after the fact moves every block above the change.
+ */
+static int get_mapping_block_bbt(int block)
+{
+	int size = bmtd.bbt.header.size;
+	int i;
+
+	for (i = 0; i < size; i++)
+		if (bmtd.bbt.table[i] <= block)
+			block++;
+
+	if (block >= bmtd.reserve_area_begin || block < 0)
+		return -EINVAL;
+
+	return block;
+}
+
+/* Stage 2: BMT lookup, scanned backwards so a later duplicate 'from' wins. */
+static int get_mapping_block(int block)
+{
+	int i;
+
+	block = get_mapping_block_bbt(block);
+	if (block < 0)
+		return block;
+
+	for (i = bmtd.bmt.header.size - 1; i >= 0; i--)
+		if (bmtd.bmt.table[i].from == block)
+			return bmtd.bmt.table[i].to;
+
+	return block;
+}
+
+enum block_is_bad {
+	BB_GOOD,
+	BB_FACTORY_BAD,
+	BB_WORN,
+	BB_UNKNOWN_BAD,
+};
+
+static enum block_is_bad fdm_is_bad(const u8 fdm[4])
+{
+	if (fdm[0] == 0xff && fdm[1] == 0xff)
+		return BB_GOOD;
+	if (fdm[0] == BLOCK_WORN_MARK)
+		return BB_WORN;
+	if (fdm[0] == 0x00 || fdm[1] == 0x00)
+		return BB_FACTORY_BAD;
+	return BB_UNKNOWN_BAD;
+}
+
+static int try_parse_bbt(struct bbt_table *out, const u8 *buf, int len, u16 table_size)
+{
+	static struct bbt_table workspace;
+	size_t bbt_size = sizeof(workspace.header) +
+			  table_size * sizeof(workspace.table[0]);
+
+	if (len < (int)bbt_size)
+		return -EINVAL;
+
+	memcpy(&workspace, buf, bbt_size);
+
+	if (strncmp(workspace.header.signature, "RAWB", 4))
+		return -EINVAL;
+
+	if ((u16)workspace.header.checksum != bbt_checksum(&workspace, table_size))
+		return -EINVAL;
+
+	sort_bbt(&workspace);
+	memcpy(out, &workspace, bbt_size);
+
+	return 0;
+}
+
+static int try_parse_bmt(struct bmt_table *out, const u8 *buf, int len)
+{
+	static struct bmt_table workspace;
+
+	if (len < (int)sizeof(*out))
+		return -EINVAL;
+
+	memcpy(&workspace, buf, sizeof(workspace));
+
+	if (strncmp(workspace.header.signature, "BMT", 3))
+		return -EINVAL;
+
+	if (workspace.header.checksum !=
+	    bmt_checksum(&workspace, workspace.header.size))
+		return -EINVAL;
+
+	memcpy(out, &workspace, sizeof(workspace));
+
+	return 0;
+}
+
+/*
+ * Walk down from the last block until REQUIRED_GOOD_BLOCKS good ones have been
+ * seen; that boundary is where the reserve pool starts. The BBT and BMT are
+ * found by signature+checksum along the way, not at fixed addresses.
+ */
+static int scan_reserve(void)
+{
+	u16 total_blks = bmtd.total_blks;
+	int required = REQUIRED_GOOD_BLOCKS(total_blks);
+	int good_blocks = 0;
+	bool found_bbt = false, found_bmt = false;
+	int cursor;
+
+	for (cursor = total_blks - 1; cursor > 0; cursor--) {
+		u8 fdm[4] = { 0xff, 0xff, 0xff, 0xff };
+		int ret = -EIO;
+		int i;
+
+		for (i = 0; i < INITIAL_READ_TRIES; i++) {
+			ret = bbt_nand_read(blk_pg(cursor), bmtd.data_buf,
+					    bmtd.pg_size, fdm, sizeof(fdm));
+			if (!ret)
+				break;
+		}
+
+		if (ret || fdm_is_bad(fdm)) {
+			pr_info("%s: skipping bad block %d in reserve area\n",
+				LOG_PFX, cursor);
+		} else {
+			good_blocks++;
+			if (!found_bbt &&
+			    !try_parse_bbt(&bmtd.bbt, bmtd.data_buf,
+					   bmtd.pg_size, bmtd.bbt_table_size)) {
+				printf("%s: found BBT in block %d\n", LOG_PFX, cursor);
+				found_bbt = true;
+			} else if (!found_bmt &&
+				   !try_parse_bmt(&bmtd.bmt, bmtd.data_buf,
+						  bmtd.pg_size)) {
+				printf("%s: found BMT in block %d\n", LOG_PFX, cursor);
+				found_bmt = true;
+			}
+		}
+
+		if (good_blocks >= required)
+			break;
+	}
+
+	if (!cursor) {
+		pr_err("%s: not enough valid blocks found, need %d got %d\n",
+		       LOG_PFX, required, good_blocks);
+		return -ENOSPC;
+	}
+
+	bmtd.reserve_area_begin = cursor;
+
+	/*
+	 * Refuse to run without a valid BBT. The alternative - reconstructing
+	 * it - is exactly the operation that can shift every block on the chip,
+	 * so a bootloader must not attempt it.
+	 */
+	if (!found_bbt) {
+		pr_err("%s: no valid BBT found, refusing to translate\n", LOG_PFX);
+		return -ENOENT;
+	}
+	if (!found_bmt)
+		pr_info("%s: no BMT found, assuming no remapped blocks\n", LOG_PFX);
+
+	return 0;
+}
+
+/*
+ * MTD operation wrappers. Each translates then defers to the saved raw op.
+ * Unlike the Linux driver these never allocate a replacement block: a failure
+ * is reported to the caller instead.
+ */
+
+static int en75_bmt_read(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
+{
+	struct mtd_oob_ops cur_ops = *ops;
+	int max_bitflips = 0;
+	int ret = 0;
+
+	ops->retlen = 0;
+	ops->oobretlen = 0;
+
+	while (ops->retlen < ops->len || ops->oobretlen < ops->ooblen) {
+		u32 offset = from & (bmtd.blk_size - 1);
+		u32 block = from >> bmtd.blk_shift;
+		int cur_block, cur_ret;
+		loff_t cur_from;
+
+		cur_block = get_mapping_block(block);
+		if (cur_block < 0)
+			return -EIO;
+
+		cur_from = ((loff_t)cur_block << bmtd.blk_shift) + offset;
+
+		cur_ops.oobretlen = 0;
+		cur_ops.retlen = 0;
+		cur_ops.len = min_t(u32, mtd->erasesize - offset,
+				    ops->len - ops->retlen);
+
+		cur_ret = bmtd._read_oob(mtd, cur_from, &cur_ops);
+		if (cur_ret < 0) {
+			ret = cur_ret;
+			if (!mtd_is_bitflip(cur_ret))
+				goto out;
+		} else {
+			max_bitflips = max_t(int, max_bitflips, cur_ret);
+		}
+
+		ops->retlen += cur_ops.retlen;
+		ops->oobretlen += cur_ops.oobretlen;
+
+		cur_ops.ooboffs = 0;
+		cur_ops.datbuf += cur_ops.retlen;
+		cur_ops.oobbuf += cur_ops.oobretlen;
+		cur_ops.ooblen -= cur_ops.oobretlen;
+
+		if (!cur_ops.len)
+			cur_ops.len = mtd->erasesize - offset;
+
+		from += cur_ops.len;
+	}
+
+out:
+	if (ret < 0 && !mtd_is_bitflip(ret))
+		return ret;
+
+	return max_bitflips;
+}
+
+static int en75_bmt_write(struct mtd_info *mtd, loff_t to, struct mtd_oob_ops *ops)
+{
+	struct mtd_oob_ops cur_ops = *ops;
+	int ret;
+
+	ops->retlen = 0;
+	ops->oobretlen = 0;
+
+	while (ops->retlen < ops->len || ops->oobretlen < ops->ooblen) {
+		u32 offset = to & (bmtd.blk_size - 1);
+		u32 block = to >> bmtd.blk_shift;
+		int cur_block;
+		loff_t cur_to;
+
+		cur_block = get_mapping_block(block);
+		if (cur_block < 0)
+			return -EIO;
+
+		cur_to = ((loff_t)cur_block << bmtd.blk_shift) + offset;
+
+		cur_ops.oobretlen = 0;
+		cur_ops.retlen = 0;
+		cur_ops.len = min_t(u32, bmtd.blk_size - offset,
+				    ops->len - ops->retlen);
+
+		ret = bmtd._write_oob(mtd, cur_to, &cur_ops);
+		if (ret < 0) {
+			/* No remap-on-failure here: the block stays bad and the
+			 * caller finds out. Repairing it is Linux's job.
+			 */
+			pr_err("%s: write failed at block %u (physical %d); "
+			       "not remapping (read-only BMT)\n",
+			       LOG_PFX, block, cur_block);
+			return ret;
+		}
+
+		ops->retlen += cur_ops.retlen;
+		ops->oobretlen += cur_ops.oobretlen;
+
+		cur_ops.ooboffs = 0;
+		cur_ops.datbuf += cur_ops.retlen;
+		cur_ops.oobbuf += cur_ops.oobretlen;
+		cur_ops.ooblen -= cur_ops.oobretlen;
+
+		if (!cur_ops.len)
+			cur_ops.len = mtd->erasesize - offset;
+
+		to += cur_ops.len;
+	}
+
+	return 0;
+}
+
+static int en75_bmt_erase(struct mtd_info *mtd, struct erase_info *instr)
+{
+	struct erase_info mapped_instr = {
+		.len = bmtd.blk_size,
+	};
+	u64 start_addr, end_addr;
+	int ret = 0;
+
+	start_addr = instr->addr & (~mtd->erasesize_mask);
+	end_addr = instr->addr + instr->len;
+
+	while (start_addr < end_addr) {
+		u16 orig_block = start_addr >> bmtd.blk_shift;
+		int block = get_mapping_block(orig_block);
+
+		if (block < 0)
+			return -EIO;
+
+		mapped_instr.addr = (loff_t)block << bmtd.blk_shift;
+		ret = bmtd._erase(mtd, &mapped_instr);
+		if (ret) {
+			pr_err("%s: erase failed at block %u (physical %d); "
+			       "not remapping (read-only BMT)\n",
+			       LOG_PFX, orig_block, block);
+			instr->fail_addr = start_addr;
+			break;
+		}
+		start_addr += mtd->erasesize;
+	}
+
+	return ret;
+}
+
+static int en75_bmt_block_isbad(struct mtd_info *mtd, loff_t ofs)
+{
+	u16 orig_block = ofs >> bmtd.blk_shift;
+	int block = get_mapping_block(orig_block);
+
+	if (block < 0)
+		return -EIO;
+
+	return bmtd._block_isbad(mtd, (loff_t)block << bmtd.blk_shift);
+}
+
+static int en75_bmt_block_markbad(struct mtd_info *mtd, loff_t ofs)
+{
+	u16 orig_block = ofs >> bmtd.blk_shift;
+	int block = get_mapping_block(orig_block);
+
+	if (block < 0)
+		return -EIO;
+
+	return bmtd._block_markbad(mtd, (loff_t)block << bmtd.blk_shift);
+}
+
+static void en75_bmt_replace_ops(struct mtd_info *mtd)
+{
+	bmtd._read_oob		= mtd->_read_oob;
+	bmtd._write_oob		= mtd->_write_oob;
+	bmtd._erase		= mtd->_erase;
+	bmtd._block_isbad	= mtd->_block_isbad;
+	bmtd._block_markbad	= mtd->_block_markbad;
+
+	mtd->_read_oob		= en75_bmt_read;
+	mtd->_write_oob		= en75_bmt_write;
+	mtd->_erase		= en75_bmt_erase;
+	mtd->_block_isbad	= en75_bmt_block_isbad;
+	mtd->_block_markbad	= en75_bmt_block_markbad;
+}
+
+static void en75_bmt_restore_ops(struct mtd_info *mtd)
+{
+	mtd->_read_oob		= bmtd._read_oob;
+	mtd->_write_oob		= bmtd._write_oob;
+	mtd->_erase		= bmtd._erase;
+	mtd->_block_isbad	= bmtd._block_isbad;
+	mtd->_block_markbad	= bmtd._block_markbad;
+}
+
+int en75_bmt_attach(struct mtd_info *mtd)
+{
+	ofnode node = mtd_get_ofnode(mtd);
+	u32 assert_reserve = 0;
+	u32 val;
+	int ret;
+
+	if (!ofnode_valid(node) || !ofnode_read_bool(node, "econet,bmt"))
+		return 0;
+
+	if (bmtd.attached) {
+		pr_err("%s: already attached to an MTD device\n", LOG_PFX);
+		return -EBUSY;
+	}
+
+	memset(&bmtd, 0, sizeof(bmtd));
+	bmtd.mtd = mtd;
+	bmtd.blk_size = mtd->erasesize;
+	bmtd.pg_size = mtd->writesize;
+	bmtd.blk_shift = ffs(mtd->erasesize) - 1;
+	bmtd.pg_shift = ffs(mtd->writesize) - 1;
+	/* Must be taken before the size is shrunk below. */
+	bmtd.total_blks = mtd->size >> bmtd.blk_shift;
+
+	bmtd.bbt_table_size = DEFAULT_BBT_TABLE_SIZE;
+	if (!ofnode_read_u32(node, "econet,bbt-table-size", &val)) {
+		if (val == 0 || val > MAX_BBT_SIZE) {
+			pr_err("%s: econet,bbt-table-size %u out of range\n",
+			       LOG_PFX, val);
+			return -EINVAL;
+		}
+		bmtd.bbt_table_size = val;
+	}
+	ofnode_read_u32(node, "econet,assert-reserve-size", &assert_reserve);
+
+	bmtd.data_buf = memalign(ARCH_DMA_MINALIGN, bmtd.pg_size);
+	if (!bmtd.data_buf)
+		return -ENOMEM;
+
+	en75_bmt_replace_ops(mtd);
+
+	ret = scan_reserve();
+	if (ret)
+		goto err_restore;
+
+	if (assert_reserve &&
+	    assert_reserve != bmtd.total_blks - bmtd.reserve_area_begin) {
+		/* Mismatch means our idea of the pool boundary differs from the
+		 * bootbase's, so every translation would be wrong.
+		 */
+		pr_err("%s: reserve size %d != asserted %u, refusing\n", LOG_PFX,
+		       bmtd.total_blks - bmtd.reserve_area_begin, assert_reserve);
+		ret = -EINVAL;
+		goto err_restore;
+	}
+
+	/* Hide the reserve area and the factory-bad shift from everything
+	 * above, so DT partitions are validated against the same size Linux
+	 * sees. Must happen before partitions are parsed.
+	 */
+	mtd->size = (loff_t)(bmtd.reserve_area_begin - bmtd.bbt.header.size)
+		    << bmtd.blk_shift;
+
+	bmtd.attached = true;
+
+	printf("%s: blocks: total: %d, user: %d, factory_bad: %d, worn: %d reserve: %d\n",
+	       LOG_PFX, bmtd.total_blks, bmtd.reserve_area_begin,
+	       bmtd.bbt.header.size, bmtd.bmt.header.size,
+	       bmtd.total_blks - bmtd.reserve_area_begin);
+	printf("%s: %llu MiB usable space (read-only BMT: no remapping)\n",
+	       LOG_PFX, (u64)mtd->size >> 20);
+
+	return 0;
+
+err_restore:
+	en75_bmt_restore_ops(mtd);
+	free(bmtd.data_buf);
+	bmtd.data_buf = NULL;
+	bmtd.mtd = NULL;
+	return ret;
+}
+
+void en75_bmt_detach(struct mtd_info *mtd)
+{
+	if (!bmtd.attached || bmtd.mtd != mtd)
+		return;
+
+	en75_bmt_restore_ops(mtd);
+	free(bmtd.data_buf);
+	bmtd.data_buf = NULL;
+	bmtd.mtd = NULL;
+	bmtd.attached = false;
+}
diff --git a/drivers/mtd/nand/spi/en75_bmt.h b/drivers/mtd/nand/spi/en75_bmt.h
new file mode 100644
index 00000000..e9d50b8d
--- /dev/null
+++ b/drivers/mtd/nand/spi/en75_bmt.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * EcoNet/Airoha EN75xx vendor BMT/BBT translation layer (read-only).
+ */
+#ifndef __EN75_BMT_H
+#define __EN75_BMT_H
+
+struct mtd_info;
+
+#if CONFIG_IS_ENABLED(MTD_EN75_BMT)
+/*
+ * Install the translation layer on a NAND whose DT node carries "econet,bmt".
+ * Must be called before add_mtd_device(), because it shrinks mtd->size to the
+ * user area and partitions are validated against that.
+ * Returns 0 when attached *or* when the node opts out; negative on error.
+ */
+int en75_bmt_attach(struct mtd_info *mtd);
+void en75_bmt_detach(struct mtd_info *mtd);
+#else
+static inline int en75_bmt_attach(struct mtd_info *mtd) { return 0; }
+static inline void en75_bmt_detach(struct mtd_info *mtd) { }
+#endif
+
+#endif /* __EN75_BMT_H */
-- 
2.53.0

