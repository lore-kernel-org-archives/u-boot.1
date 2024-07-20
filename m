Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E71C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48FFA88C7A;
	Sat, 20 Jul 2024 14:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yiIO7T7i";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dOxUDWZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E541488C37; Sat, 20 Jul 2024 14:43:52 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3972288C66
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WR5nd6qMMz9sT1;
 Sat, 20 Jul 2024 14:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPztX2v5+OaZbcKLUy6161AwTVqSzh99CJXldSn6pFE=;
 b=yiIO7T7ib4ApV/EZWiX8bFsi3mZQ1wHOdCMdc0J7aFtOoblJtCM6mLmht/0YwvADF7CxiW
 juvuXvg3HDojBxDVtCTiEkJxzI+2rttxJ6I4aJ7NSTF0+KrGiAsuVDLbtmF8CSMxK6YyI4
 e58ASNVFzOpVPEWovMwVvqqZ0jMfz4L0a2yNa4DxewBrJr+9NMk5CwlyCxpHT7yrh/nEvd
 5s9E3U6e+iDK6cHVkiuLXo22prlspyweCKBog8B7Dg/7tOrWmSawBWn6lAdb5AKN6hk9Ej
 s6kCk4MbRjD2vzRubOFd59Fz8NRqcTL2COLHOy4CicN4KRYCOLoeYFXJFbyjIg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPztX2v5+OaZbcKLUy6161AwTVqSzh99CJXldSn6pFE=;
 b=dOxUDWZiJ4FNH3/sHxQxK0GjGWh3V7JCiv0zLCI16A+b3Sr2Pq2B4gmAfjHQ+EBRNqkYjf
 IkgF0duNH7u7UIbyl4Hh5+KGQfTHu7LRJQMARm+cfv8K+A5sGxmXExUGuon7Og5/Z4RSfo
 21FT7Qn3ZzOHl3Foz75g15xZGsq9eZ7TaGjC7YGNXFOZLM7dXD9nXWXgw6VhdxNOX4p/7T
 +GDGHnOQcHjTHOp9B3EgoZDJQ8bAyq33EghWEZ8sA6uUTNJ1Z5CIqEmMTWMdwNK1yHP8Jc
 7pWfn46SJkC/lqscgqBnObvt1gGlNxymjesQWzzilxpjTnj0ZvWjicOeEOhckg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 19/40] drivers: mtd: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:44 +0200
Message-ID: <20240720124239.7553-19-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b4eb1e0c7d10a1eba92
X-MBO-RS-META: ucpxyy66qep18x4cxj1qqwhhrhpo878t
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/mtd/jedec_flash.c              | 3 ---
 drivers/mtd/mtdcore.c                  | 2 --
 drivers/mtd/nand/raw/am335x_spl_bch.c  | 2 --
 drivers/mtd/nand/raw/arasan_nfc.c      | 1 -
 drivers/mtd/nand/raw/fsl_ifc_nand.c    | 1 -
 drivers/mtd/nand/raw/mxs_nand.c        | 1 -
 drivers/mtd/nand/raw/mxs_nand_dt.c     | 1 -
 drivers/mtd/nand/raw/nand_base.c       | 3 ---
 drivers/mtd/nand/raw/nand_ecc.c        | 1 -
 drivers/mtd/nand/raw/nand_spl_simple.c | 2 --
 drivers/mtd/nand/raw/nand_util.c       | 1 -
 drivers/mtd/nand/raw/omap_elm.c        | 1 -
 drivers/mtd/nand/raw/omap_elm.h        | 1 -
 drivers/mtd/nand/raw/sunxi_nand_spl.c  | 2 --
 drivers/mtd/nand/raw/tegra_nand.c      | 1 -
 drivers/mtd/nand/raw/zynq_nand.c       | 1 -
 drivers/mtd/nand/spi/paragon.c         | 5 -----
 drivers/mtd/onenand/onenand_base.c     | 4 ----
 drivers/mtd/renesas_rpc_hf.c           | 1 -
 drivers/mtd/spi/sf_internal.h          | 1 -
 drivers/mtd/ubi/build.c                | 1 -
 drivers/mtd/ubi/fastmap.c              | 3 ---
 22 files changed, 39 deletions(-)

diff --git a/drivers/mtd/jedec_flash.c b/drivers/mtd/jedec_flash.c
index a832f348f22..54ec22d3088 100644
--- a/drivers/mtd/jedec_flash.c
+++ b/drivers/mtd/jedec_flash.c
@@ -85,13 +85,11 @@ enum uaddr {
 	MTD_UADDR_UNNECESSARY,		/* Does not require any address */
 };
 
-
 struct unlock_addr {
 	u32 addr1;
 	u32 addr2;
 };
 
-
 /*
  * I don't like the fact that the first entry in unlock_addrs[]
  * exists, but is for MTD_UADDR_NOT_SUPPORTED - and, therefore,
@@ -139,7 +137,6 @@ static const struct unlock_addr  unlock_addrs[] = {
 	}
 };
 
-
 struct amd_flash_info {
 	const __u16 mfr_id;
 	const __u16 dev_id;
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index aa78d41a55e..5bd64bd6ad4 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -172,7 +172,6 @@ bool mtd_dev_list_updated(void)
 #ifndef __UBOOT__
 static LIST_HEAD(mtd_notifiers);
 
-
 #define MTD_DEVT(index) MKDEV(MTD_CHAR_MAJOR, (index)*2)
 
 /* REVISIT once MTD uses the driver model better, whoever allocates
@@ -747,7 +746,6 @@ out:
 }
 EXPORT_SYMBOL_GPL(get_mtd_device);
 
-
 int __get_mtd_device(struct mtd_info *mtd)
 {
 	int err;
diff --git a/drivers/mtd/nand/raw/am335x_spl_bch.c b/drivers/mtd/nand/raw/am335x_spl_bch.c
index 64d8ce0965a..4b50f351d35 100644
--- a/drivers/mtd/nand/raw/am335x_spl_bch.c
+++ b/drivers/mtd/nand/raw/am335x_spl_bch.c
@@ -25,7 +25,6 @@ static struct nand_chip nand_chip;
 					CFG_SYS_NAND_ECCSIZE)
 #define ECCTOTAL	(ECCSTEPS * CFG_SYS_NAND_ECCBYTES)
 
-
 /*
  * NAND command for large page NAND devices (2k)
  */
@@ -87,7 +86,6 @@ static int nand_command(int block, int page, uint32_t offs,
 
 	hwctrl(mtd, NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
 
-
 	/*
 	 * Program and erase have their own busy handlers status, sequential
 	 * in and status need no delay.
diff --git a/drivers/mtd/nand/raw/arasan_nfc.c b/drivers/mtd/nand/raw/arasan_nfc.c
index 4f013efafb3..10596ce8ee0 100644
--- a/drivers/mtd/nand/raw/arasan_nfc.c
+++ b/drivers/mtd/nand/raw/arasan_nfc.c
@@ -408,7 +408,6 @@ static int arasan_nand_read_page(struct mtd_info *mtd, u8 *buf, u32 size)
 		for (i = 0; i < pktsize/4; i++)
 			bufptr[i] = readl(&info->reg->buf_dataport);
 
-
 		bufptr += pktsize/4;
 
 		if (rdcount >= pktnum)
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 857d50ef9b0..798036f6028 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -1012,7 +1012,6 @@ static int fsl_ifc_chip_init(int devnum, u8 *addr)
 		priv->bufnum_mask = 0;
 		break;
 
-
 	default:
 		printf("ifc nand: bad csor %#x: bad page size\n", csor);
 		return -ENODEV;
diff --git a/drivers/mtd/nand/raw/mxs_nand.c b/drivers/mtd/nand/raw/mxs_nand.c
index 11b0247b284..80d9307cdd1 100644
--- a/drivers/mtd/nand/raw/mxs_nand.c
+++ b/drivers/mtd/nand/raw/mxs_nand.c
@@ -277,7 +277,6 @@ static inline int mxs_nand_calc_ecc_for_large_oob(struct bch_geometry *geo,
 	max_ecc = min(round_down(max_ecc, 2),
 				nand_info->max_ecc_strength_supported);
 
-
 	/* search a supported ecc strength that makes bbm */
 	/* located in data chunk  */
 	geo->ecc_strength = chip->ecc_strength_ds;
diff --git a/drivers/mtd/nand/raw/mxs_nand_dt.c b/drivers/mtd/nand/raw/mxs_nand_dt.c
index a922a22b273..11dbcbbf442 100644
--- a/drivers/mtd/nand/raw/mxs_nand_dt.c
+++ b/drivers/mtd/nand/raw/mxs_nand_dt.c
@@ -90,7 +90,6 @@ static int mxs_nand_dt_probe(struct udevice *dev)
 
 	info->gpmi_regs = devm_ioremap(dev, res.start, resource_size(&res));
 
-
 	ret = dev_read_resource_byname(dev, "bch", &res);
 	if (ret)
 		return ret;
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 18b95caffef..4401bdcdb90 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -2767,7 +2767,6 @@ out:
 	return ret;
 }
 
-
 /**
  * nand_write_page_raw - [INTERN] raw page write function
  * @mtd: mtd info structure
@@ -2927,7 +2926,6 @@ static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	return 0;
 }
 
-
 /**
  * nand_write_subpage_hwecc - [REPLACEABLE] hardware ECC based subpage write
  * @mtd:	mtd info structure
@@ -2994,7 +2992,6 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 	return 0;
 }
 
-
 /**
  * nand_write_page_syndrome - [REPLACEABLE] hardware ECC syndrome based page write
  * @mtd: mtd info structure
diff --git a/drivers/mtd/nand/raw/nand_ecc.c b/drivers/mtd/nand/raw/nand_ecc.c
index 0530ccb0722..969fd858075 100644
--- a/drivers/mtd/nand/raw/nand_ecc.c
+++ b/drivers/mtd/nand/raw/nand_ecc.c
@@ -22,7 +22,6 @@
  * this file might be covered by the GNU General Public License.
  */
 
-
 #include <linux/errno.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand_ecc.h>
diff --git a/drivers/mtd/nand/raw/nand_spl_simple.c b/drivers/mtd/nand/raw/nand_spl_simple.c
index c0956ab0e49..a4f6c43c1a0 100644
--- a/drivers/mtd/nand/raw/nand_spl_simple.c
+++ b/drivers/mtd/nand/raw/nand_spl_simple.c
@@ -19,7 +19,6 @@ static struct nand_chip nand_chip;
 					CFG_SYS_NAND_ECCSIZE)
 #define ECCTOTAL	(ECCSTEPS * CFG_SYS_NAND_ECCBYTES)
 
-
 #if (CONFIG_SYS_NAND_PAGE_SIZE <= 512)
 /*
  * NAND command for small page NAND devices (512)
@@ -153,7 +152,6 @@ static int nand_read_page(int block, int page, uchar *dst)
 	for (i = 0; i < ECCTOTAL; i++)
 		ecc_code[i] = oob_data[nand_ecc_pos[i]];
 
-
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		this->ecc.hwctl(mtd, NAND_ECC_READ);
 		this->read_buf(mtd, p, eccsize);
diff --git a/drivers/mtd/nand/raw/nand_util.c b/drivers/mtd/nand/raw/nand_util.c
index fda4239fa79..dd79bfdb5de 100644
--- a/drivers/mtd/nand/raw/nand_util.c
+++ b/drivers/mtd/nand/raw/nand_util.c
@@ -276,7 +276,6 @@ int nand_get_lock_status(struct mtd_info *mtd, loff_t offset)
 	chipnr = (int)(offset >> chip->chip_shift);
 	chip->select_chip(mtd, chipnr);
 
-
 	if ((offset & (mtd->writesize - 1)) != 0) {
 		printf("nand_get_lock_status: "
 			"Start address must be beginning of "
diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
index 61751b9ae2d..30049686ce1 100644
--- a/drivers/mtd/nand/raw/omap_elm.c
+++ b/drivers/mtd/nand/raw/omap_elm.c
@@ -134,7 +134,6 @@ int elm_check_error(u8 *syndrome, enum bch_level bch_type, u32 *error_count,
 	return 0;
 }
 
-
 /**
  * elm_config - Configure ELM module
  * @level: 4 / 8 / 16 bit BCH
diff --git a/drivers/mtd/nand/raw/omap_elm.h b/drivers/mtd/nand/raw/omap_elm.h
index f3db00d55de..65d07065111 100644
--- a/drivers/mtd/nand/raw/omap_elm.h
+++ b/drivers/mtd/nand/raw/omap_elm.h
@@ -34,7 +34,6 @@ enum bch_level {
 	BCH_16_BIT
 };
 
-
 /* BCH syndrome registers */
 struct syndrome {
 	u32 syndrome_fragment_x[7];	/* 0x400, 0x404.... 0x418 */
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 040138e2559..4f1e2d9a577 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -47,7 +47,6 @@
 #define NFC_CTL_PAGE_SIZE_MASK     (0xf << 8)
 #define NFC_CTL_PAGE_SIZE(a)       ((fls(a) - 11) << 8)
 
-
 #define NFC_ECC_EN                 (1 << 0)
 #define NFC_ECC_PIPELINE           (1 << 3)
 #define NFC_ECC_EXCEPTION          (1 << 4)
@@ -55,7 +54,6 @@
 #define NFC_ECC_RANDOM_EN          (1 << 9)
 #define NFC_ECC_RANDOM_DIRECTION   (1 << 10)
 
-
 #define NFC_ADDR_NUM_OFFSET        16
 #define NFC_SEND_ADDR              (1 << 19)
 #define NFC_ACCESS_DIR             (1 << 20)
diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 8285f87359e..ef43dcad079 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -679,7 +679,6 @@ static int nand_write_page_hwecc(struct mtd_info *mtd,
 	return 0;
 }
 
-
 /**
  * Read raw page data without ecc
  *
diff --git a/drivers/mtd/nand/raw/zynq_nand.c b/drivers/mtd/nand/raw/zynq_nand.c
index 5f90171a6fe..ca1aff25a52 100644
--- a/drivers/mtd/nand/raw/zynq_nand.c
+++ b/drivers/mtd/nand/raw/zynq_nand.c
@@ -51,7 +51,6 @@
 				(0x5 << 0))	/* t_rc from nand_cycles */
 #endif
 
-
 #define ZYNQ_NAND_DIRECT_CMD	((0x4 << 23) |	/* Chip 0 from interface 1 */ \
 				(0x2 << 21))	/* UpdateRegs operation */
 
diff --git a/drivers/mtd/nand/spi/paragon.c b/drivers/mtd/nand/spi/paragon.c
index 0c123930f14..079431cea8f 100644
--- a/drivers/mtd/nand/spi/paragon.c
+++ b/drivers/mtd/nand/spi/paragon.c
@@ -11,10 +11,8 @@
 #endif
 #include <linux/mtd/spinand.h>
 
-
 #define SPINAND_MFR_PARAGON	0xa1
 
-
 #define PN26G0XA_STATUS_ECC_BITMASK		(3 << 4)
 
 #define PN26G0XA_STATUS_ECC_NONE_DETECTED	(0 << 4)
@@ -22,7 +20,6 @@
 #define PN26G0XA_STATUS_ECC_ERRORED		(2 << 4)
 #define PN26G0XA_STATUS_ECC_8_CORRECTED		(3 << 4)
 
-
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -39,7 +36,6 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
-
 static int pn26g0xa_ooblayout_ecc(struct mtd_info *mtd, int section,
 				   struct mtd_oob_region *region)
 {
@@ -97,7 +93,6 @@ static const struct mtd_ooblayout_ops pn26g0xa_ooblayout = {
 	.rfree = pn26g0xa_ooblayout_free,
 };
 
-
 static const struct spinand_info paragon_spinand_table[] = {
 	SPINAND_INFO("PN26G01A",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xe1),
diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index edecb841338..c8bc76794b5 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -503,7 +503,6 @@ static int onenand_wait(struct mtd_info *mtd, int state)
 		return -EIO;
 	}
 
-
 	return 0;
 }
 
@@ -1278,7 +1277,6 @@ int onenand_bbt_read_oob(struct mtd_info *mtd, loff_t from,
 	return ret;
 }
 
-
 #ifdef CONFIG_MTD_ONENAND_VERIFY_WRITE
 /**
  * onenand_verify_oob - [GENERIC] verify the oob contents after a write
@@ -1720,7 +1718,6 @@ static int onenand_block_isbad_nolock(struct mtd_info *mtd, loff_t ofs, int allo
 	return bbm->isbad_bbt(mtd, ofs, allowbbt);
 }
 
-
 /**
  * onenand_erase - [MTD Interface] erase block(s)
  * @param mtd		MTD device structure
@@ -2128,7 +2125,6 @@ static void onenand_unlock_all(struct mtd_info *mtd)
 	onenand_do_lock_cmd(mtd, ofs, len, ONENAND_CMD_UNLOCK);
 }
 
-
 /**
  * onenand_check_features - Check and set OneNAND features
  * @param mtd           MTD data structure
diff --git a/drivers/mtd/renesas_rpc_hf.c b/drivers/mtd/renesas_rpc_hf.c
index 8dcffde9aa3..941f2040983 100644
--- a/drivers/mtd/renesas_rpc_hf.c
+++ b/drivers/mtd/renesas_rpc_hf.c
@@ -361,7 +361,6 @@ static int rpc_hf_probe(struct udevice *dev)
 	if (addrc != 2 || sizec != 2)
 		return -EINVAL;
 
-
 	ret = clk_get_by_index(dev, 0, &clk);
 	if (ret < 0) {
 		dev_err(dev, "Failed to get RPC clock\n");
diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index d3ef69ec74f..8d2249ce354 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -79,7 +79,6 @@ extern const struct flash_info spi_nor_ids[];
 /* Get software write-protect value (BP bits) */
 int spi_flash_cmd_get_sw_write_prot(struct spi_flash *flash);
 
-
 #if CONFIG_IS_ENABLED(SPI_FLASH_MTD)
 int spi_flash_mtd_register(struct spi_flash *flash);
 void spi_flash_mtd_unregister(struct spi_flash *flash);
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index a1941b8eb88..cf0d702421f 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1275,7 +1275,6 @@ int ubi_init(void)
 	if (err)
 		goto out_slab;
 
-
 	/* Attach MTD devices */
 	for (i = 0; i < mtd_devs; i++) {
 		struct mtd_dev_param *p = &mtd_dev_param[i];
diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index b54b56375b4..21750e1817b 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -105,7 +105,6 @@ size_t ubi_calc_fm_size(struct ubi_device *ubi)
 	return roundup(size, ubi->leb_size);
 }
 
-
 /**
  * new_fm_vhdr - allocate a new volume header for fastmap usage.
  * @ubi: UBI device description object
@@ -680,7 +679,6 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		goto fail_bad;
 	}
 
-
 	if (fm->max_pool_size > UBI_FM_MAX_POOL_SIZE ||
 	    fm->max_pool_size < 0) {
 		ubi_err(ubi, "bad maximal pool size: %i", fm->max_pool_size);
@@ -1241,7 +1239,6 @@ static int ubi_write_fastmap(struct ubi_device *ubi,
 	}
 	fmh->scrub_peb_count = cpu_to_be32(scrub_peb_count);
 
-
 	list_for_each_entry(ubi_wrk, &ubi->works, list) {
 		if (ubi_is_erase_work(ubi_wrk)) {
 			wl_e = ubi_wrk->e;
-- 
2.43.0

