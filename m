Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08975C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A85188792;
	Tue, 23 Jul 2024 01:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bc8izFkh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p5FiYLzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F4A887C0; Tue, 23 Jul 2024 01:30:20 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04956886F3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WSc2K4xm9z9smq;
 Tue, 23 Jul 2024 01:30:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721691001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGBgj7+TSLCbbGhwfzk3xwyUWBmxaGWFJkmk3aVBPEQ=;
 b=bc8izFkhXArUlhoOn5Kn/QgBfBc3SZfRLahbyLC2ydcY6OmU5dWiD54/Jd41BvmML3T8oP
 /1tjW/RupwvIhU+r6w7C2G4pgXEs/RFzvhv0diQmWjNa3UufoaWhqEq1hIYcJA+myTbmJi
 lkgngig0h7Jq/8x/VZuFVNkU31Vy2B1M/Yph2GH9cdT9q0Jeq5vl7sgFuKNjghUdAoPWI7
 rFasXmlCMdMhTvJR9yBIcDSG15fxREWdQN8Z95vdAT4W+G8r9ilCCIgWWaA2nxGdGd1agT
 M0ioqrcyRxWuhsoJhZ9394OwuFeRoYF0hHS88PApBc5ThdA4jtPWdaGw/9NGWQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGBgj7+TSLCbbGhwfzk3xwyUWBmxaGWFJkmk3aVBPEQ=;
 b=p5FiYLzJW05igFLTH3mC5stySuyXjEh82FGIdyz1rXfKZ9oAtZCtyJ4/QEwOhGwHcK7upg
 mywvOZgX9luJIQ9grX8iwjB9UDeuzljzSVWAPQ85NBsgZw3wh7tEXAjU68ngXN+kAaYeNw
 JDgkNj+0m1x40qmXwcv9UouSynhLfDiwHBL5wywmisHtF07YfmLE4ot6FFv8wuAcjaVEzF
 Ddhc7xm6QpkFuHRt2YLvPqKi8NKQfkuN38w56dz9brtTx+J3121qrXEzyb0mLd62x8k57J
 Ak5ZtNPcVqs4AfZtrqfuJ1iGukPJ8sqU0w3w1N3TDNOhSZSKke1OjfMePK/fBw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 15/15] include: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:34 +0200
Message-ID: <20240722232910.91249-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3ea9d177cf8b8f005d8
X-MBO-RS-META: 1msxm4aabnnjb69h7n3eu337htfok6pu
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
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 include/ata.h            |  2 --
 include/blkmap.h         |  1 -
 include/bzlib.h          |  6 ------
 include/dfu.h            |  1 -
 include/dw_hdmi.h        |  1 -
 include/ec_commands.h    | 12 ------------
 include/efi_api.h        |  1 -
 include/efi_loader.h     |  1 -
 include/env_internal.h   |  1 -
 include/exports.h        |  1 -
 include/flash.h          |  2 --
 include/fsl_ddr_sdram.h  |  2 --
 include/fsl_dtsec.h      |  1 -
 include/fsl_errata.h     |  2 --
 include/fsl_ifc.h        |  2 --
 include/fsl_mmdc.h       |  1 -
 include/fsl_validate.h   |  1 -
 include/gt64120.h        | 10 ----------
 include/key_matrix.h     |  1 -
 include/malloc.h         | 16 ----------------
 include/mc13892.h        |  1 -
 include/micrel.h         |  1 -
 include/mmc.h            |  2 --
 include/mpc8xx.h         |  5 -----
 include/mv88e6352.h      |  1 -
 include/nand.h           |  1 -
 include/net.h            |  1 -
 include/part.h           |  1 -
 include/pci.h            |  1 -
 include/pci_gt64120.h    |  1 -
 include/pci_ids.h        |  1 -
 include/scsi.h           |  2 --
 include/spd.h            |  1 -
 include/spl.h            |  1 -
 include/tegra-kbc.h      |  1 -
 include/usb.h            |  2 --
 include/usb_defs.h       |  3 ---
 include/usbdescriptors.h |  7 -------
 include/usbdevice.h      |  8 --------
 include/xyzModem.h       |  3 ---
 include/zfs_common.h     |  6 ------
 41 files changed, 115 deletions(-)

diff --git a/include/ata.h b/include/ata.h
index a7bcee6a64c..57be0e87617 100644
--- a/include/ata.h
+++ b/include/ata.h
@@ -73,7 +73,6 @@
 #define ATAPI_CMD_START_STOP 0x1B
 #define ATAPI_CMD_READ_12 0xA8
 
-
 #define ATA_GET_ERR()	inb(ATA_STATUS)
 #define ATA_GET_STAT()	inb(ATA_STATUS)
 #define ATA_OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==(good))
@@ -189,7 +188,6 @@ typedef struct hd_driveid {
 	unsigned short	words164_255[92];/* reserved words 164-255 */
 } hd_driveid_t;
 
-
 /*
  * PIO Mode Configuration
  *
diff --git a/include/blkmap.h b/include/blkmap.h
index 30dc84a7da8..d53095437fa 100644
--- a/include/blkmap.h
+++ b/include/blkmap.h
@@ -65,7 +65,6 @@ int blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 int blkmap_map_pmem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 		    phys_addr_t paddr);
 
-
 /**
  * blkmap_from_label() - Find blkmap from label
  *
diff --git a/include/bzlib.h b/include/bzlib.h
index 19314f8f665..e3cf6f9c593 100644
--- a/include/bzlib.h
+++ b/include/bzlib.h
@@ -62,7 +62,6 @@
   For more information on these sources, see the manual.
 --*/
 
-
 #ifndef _BZLIB_H
 #define _BZLIB_H
 
@@ -117,7 +116,6 @@ typedef
    }
    bz_stream;
 
-
 #ifndef BZ_IMPORT
 #define BZ_EXPORT
 #endif
@@ -141,7 +139,6 @@ typedef
 #   define BZ_EXTERN extern
 #endif
 
-
 /*-- Core (low-level) library functions --*/
 
 BZ_EXTERN int BZ_API(BZ2_bzCompressInit) (
@@ -174,7 +171,6 @@ BZ_EXTERN int BZ_API(BZ2_bzDecompressEnd) (
       bz_stream *strm
    );
 
-
 /*-- High(er) level library functions --*/
 
 #ifndef BZ_NO_STDIO
@@ -247,7 +243,6 @@ BZ_EXTERN void BZ_API(BZ2_bzWriteClose64) (
    );
 #endif
 
-
 /*-- Utility functions --*/
 
 BZ_EXTERN int BZ_API(BZ2_bzBuffToBuffCompress) (
@@ -269,7 +264,6 @@ BZ_EXTERN int BZ_API(BZ2_bzBuffToBuffDecompress) (
       int           verbosity
    );
 
-
 /*--
    Code contributed by Yoshioka Tsuneo
    (QWF00133@niftyserve.or.jp/tsuneo-y@is.aist-nara.ac.jp),
diff --git a/include/dfu.h b/include/dfu.h
index fa1918cd663..6c5431b3948 100644
--- a/include/dfu.h
+++ b/include/dfu.h
@@ -99,7 +99,6 @@ struct virt_internal_data {
 	int dev_num;
 };
 
-
 #if defined(CONFIG_DFU_NAME_MAX_SIZE)
 #define DFU_NAME_SIZE			CONFIG_DFU_NAME_MAX_SIZE
 #else
diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
index f4d66edacee..b73518207ef 100644
--- a/include/dw_hdmi.h
+++ b/include/dw_hdmi.h
@@ -309,7 +309,6 @@ enum {
 	HDMI_FC_INVIDCONF_IN_I_P_INTERLACED = 0x1,
 	HDMI_FC_INVIDCONF_IN_I_P_PROGRESSIVE = 0x0,
 
-
 	/* fc_aviconf0-fc_aviconf3 field values */
 	HDMI_FC_AVICONF0_PIX_FMT_MASK = 0x03,
 	HDMI_FC_AVICONF0_PIX_FMT_RGB = 0x00,
diff --git a/include/ec_commands.h b/include/ec_commands.h
index 36f4a02f936..23597d28b2c 100644
--- a/include/ec_commands.h
+++ b/include/ec_commands.h
@@ -345,7 +345,6 @@
 /* Current version of ACPI memory address space */
 #define EC_ACPI_MEM_VERSION_CURRENT 2
 
-
 /*
  * This header file is used in coreboot both in C and ACPI code.  The ACPI code
  * is pre-processed to handle constants but the ASL compiler is unable to
@@ -984,7 +983,6 @@ struct __ec_align4 ec_response_get_protocol_info {
 	uint32_t flags;
 };
 
-
 /*****************************************************************************/
 /* Get/Set miscellaneous values */
 
@@ -1300,7 +1298,6 @@ struct __ec_align4 ec_params_flash_erase {
 	uint32_t size;     /* Size to erase in bytes */
 };
 
-
 #define EC_VER_FLASH_WRITE 1
 /* v1 add async erase:
  * subcommands can returns:
@@ -1451,7 +1448,6 @@ struct __ec_align4 ec_response_vbnvcontext {
 	uint8_t block[EC_VBNV_BLOCK_SIZE_V2];
 };
 
-
 /* Get SPI flash information */
 #define EC_CMD_FLASH_SPI_INFO 0x0018
 
@@ -1469,7 +1465,6 @@ struct __ec_align1 ec_response_flash_spi_info {
 	uint8_t sr1, sr2;
 };
 
-
 /* Select flash during flash operations */
 #define EC_CMD_FLASH_SELECT 0x0019
 
@@ -1801,7 +1796,6 @@ struct __ec_todo_packed ec_response_lightbar {
 		struct lightbar_params_v0 get_params_v0;
 		struct lightbar_params_v1 get_params_v1;
 
-
 		struct lightbar_params_v2_timing get_params_v2_timing;
 		struct lightbar_params_v2_tap get_params_v2_tap;
 		struct lightbar_params_v2_oscillation get_params_v2_osc;
@@ -2667,7 +2661,6 @@ struct __ec_align2 ec_response_thermal_get_threshold {
 	uint16_t value;
 };
 
-
 /* The version 1 structs are visible. */
 enum ec_temp_thresholds {
 	EC_TEMP_THRESH_WARN = 0,
@@ -2765,7 +2758,6 @@ struct __ec_align4 ec_params_tmp006_set_calibration_v1 {
 	float val[0];
 };
 
-
 /* Read raw TMP006 data */
 #define EC_CMD_TMP006_GET_RAW 0x0055
 
@@ -3082,7 +3074,6 @@ struct __ec_align1 ec_response_temp_sensor_get_info {
 /*****************************************************************************/
 /* Host event commands */
 
-
 /* Obsolete. New implementation should use EC_CMD_PROGRAM_HOST_EVENT instead */
 /*
  * Host event mask params and response structures, shared by all of the host
@@ -3619,7 +3610,6 @@ struct __ec_align4 ec_response_charge_state {
 	};
 };
 
-
 /*
  * Set maximum battery charging current.
  */
@@ -4207,7 +4197,6 @@ struct __ec_align4 ec_response_pd_log {
 	uint8_t payload[0]; /* optional additional data payload: 0..16 bytes */
 };
 
-
 /* The timestamp is the microsecond counter shifted to get about a ms. */
 #define PD_LOG_TIMESTAMP_SHIFT 10 /* 1 LSB = 1024us */
 
@@ -4322,7 +4311,6 @@ struct __ec_align1 ec_params_pd_write_log_entry {
 	uint8_t port; /* port#, or 0 for events unrelated to a given port */
 };
 
-
 /* Control USB-PD chip */
 #define EC_CMD_PD_CONTROL 0x0119
 
diff --git a/include/efi_api.h b/include/efi_api.h
index ab40b1b5ddf..f07d074f93b 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -2017,7 +2017,6 @@ struct efi_firmware_image_authentication {
 	struct win_certificate_uefi_guid auth_info;
 } __attribute__((__packed__));
 
-
 /**
  * struct efi_signature_data - A format of signature
  *
diff --git a/include/efi_loader.h b/include/efi_loader.h
index f2e5063a970..f84852e384f 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -153,7 +153,6 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
 	EFI_GUID(0xb2ac5fc9, 0x92b7, 0x4acd, \
 		 0xae, 0xac, 0x11, 0xe8, 0x18, 0xc3, 0x13, 0x0c)
 
-
 /* Use internal device tree when starting UEFI application */
 #define EFI_FDT_USE_INTERNAL NULL
 
diff --git a/include/env_internal.h b/include/env_internal.h
index cbd1ef3e914..0a267e35592 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -15,7 +15,6 @@
 #ifndef _ENV_INTERNAL_H_
 #define _ENV_INTERNAL_H_
 
-
 /**************************************************************************
  *
  * The "environment" is stored as a list of '\0' terminated
diff --git a/include/exports.h b/include/exports.h
index 6f8c9cf4517..23cc3a66c20 100644
--- a/include/exports.h
+++ b/include/exports.h
@@ -70,7 +70,6 @@ struct jt_funcs {
 #undef EXPORT_FUNC
 };
 
-
 #define XF_VERSION	9
 
 #if defined(CONFIG_X86)
diff --git a/include/flash.h b/include/flash.h
index 0f736977411..60babe8a805 100644
--- a/include/flash.h
+++ b/include/flash.h
@@ -256,7 +256,6 @@ void flash_perror(int err);
 #define AMD_ID_GL128N_2	0x22212221	/* 2nd ID word for S29GL128N */
 #define AMD_ID_GL128N_3	0x22012201	/* 3rd ID word for S29GL128N */
 
-
 #define AMD_ID_LV320B_2 0x221A221A	/* 2d ID word for AM29LV320MB at 0x38 */
 #define AMD_ID_LV320B_3 0x22002200	/* 3d ID word for AM29LV320MB at 0x3c */
 
@@ -476,7 +475,6 @@ void flash_perror(int err);
 
 #define FLASH_UNKNOWN	0xFFFF		/* unknown flash type			*/
 
-
 /* manufacturer offsets
  */
 #define FLASH_MAN_AMD	0x00000000	/* AMD					*/
diff --git a/include/fsl_ddr_sdram.h b/include/fsl_ddr_sdram.h
index c43f780e4cd..182f5836533 100644
--- a/include/fsl_ddr_sdram.h
+++ b/include/fsl_ddr_sdram.h
@@ -197,7 +197,6 @@ typedef struct ddr4_spd_eeprom_s generic_spd_eeprom_t;
 /* DEBUG_29 register */
 #define DDR_TX_BD_DIS	(1 << 10) /* Transmit Bit Deskew Disable */
 
-
 #if (defined(CONFIG_SYS_FSL_DDR_VER) && \
 	(CONFIG_SYS_FSL_DDR_VER >= FSL_DDR_VER_4_7))
 #ifdef CONFIG_SYS_FSL_DDR3L
@@ -473,7 +472,6 @@ extern phys_size_t fixed_sdram(void);
 extern void ddr_enable_ecc(unsigned int dram_size);
 #endif
 
-
 typedef struct fixed_ddr_parm{
 	int min_freq;
 	int max_freq;
diff --git a/include/fsl_dtsec.h b/include/fsl_dtsec.h
index ccd6572ae26..d93f50e95b9 100644
--- a/include/fsl_dtsec.h
+++ b/include/fsl_dtsec.h
@@ -97,7 +97,6 @@ struct dtsec {
 	u32	res9[80];
 };
 
-
 /* TBI register addresses */
 #define TBI_CR			0x00
 #define TBI_SR			0x01
diff --git a/include/fsl_errata.h b/include/fsl_errata.h
index 9f070726acb..c15f9a04848 100644
--- a/include/fsl_errata.h
+++ b/include/fsl_errata.h
@@ -14,7 +14,6 @@
 #include <asm/arch/soc.h>
 #endif
 
-
 #ifdef CONFIG_SYS_FSL_ERRATUM_A006379
 static inline bool has_erratum_a006379(void)
 {
@@ -62,7 +61,6 @@ static inline bool has_erratum_a008378(void)
 	u32 svr = get_svr();
 	u32 soc = SVR_SOC_VER(svr);
 
-
 	switch (soc) {
 #ifdef CONFIG_ARCH_LS1021A
 	case SOC_VER_LS1020:
diff --git a/include/fsl_ifc.h b/include/fsl_ifc.h
index 4991d932200..3ac22687930 100644
--- a/include/fsl_ifc.h
+++ b/include/fsl_ifc.h
@@ -33,7 +33,6 @@
 #error Neither CONFIG_SYS_FSL_IFC_LE nor CONFIG_SYS_FSL_IFC_BE is defined
 #endif
 
-
 /*
  * CSPR - Chip Select Property Register
  */
@@ -790,7 +789,6 @@ enum ifc_nand_fir_opcodes {
  */
 #define IFC_GPCM_STAT_BSY		0x80000000  /* GPCM is busy */
 
-
 #ifndef __ASSEMBLY__
 #include <asm/io.h>
 
diff --git a/include/fsl_mmdc.h b/include/fsl_mmdc.h
index 05fb41f4033..f706cfe12ac 100644
--- a/include/fsl_mmdc.h
+++ b/include/fsl_mmdc.h
@@ -12,7 +12,6 @@
 /* PHY Pre-defined Compare and CA delay-line Configuration (MPPDCMPR2) */
 #define MPPDCMPR2_MPR_COMPARE_EN	(1 << 0)
 
-
 /* MMDC PHY Read DQS gating control register 0 (MPDGCTRL0) */
 #define AUTO_RD_DQS_GATING_CALIBRATION_EN	(1 << 28)
 
diff --git a/include/fsl_validate.h b/include/fsl_validate.h
index 66a5883f1f7..4b69de89ebd 100644
--- a/include/fsl_validate.h
+++ b/include/fsl_validate.h
@@ -161,7 +161,6 @@ struct fsl_secboot_img_hdr {
 
 #endif /* CONFIG_ESBC_HDR_LS */
 
-
 #if defined(CONFIG_FSL_ISBC_KEY_EXT)
 struct ie_key_table {
 	u32 key_len;
diff --git a/include/gt64120.h b/include/gt64120.h
index b58afe3c4af..b8d3f03a5e0 100644
--- a/include/gt64120.h
+++ b/include/gt64120.h
@@ -221,7 +221,6 @@
 #define GT_PCI0_HICMASK_OFS	0xca4
 #define GT_PCI1_SERR1MASK_OFS	0xca8
 
-
 /*
  * I2O Support Registers
  */
@@ -283,7 +282,6 @@
 #define GT_CPU_WR_DXDXDXDX	0
 #define GT_CPU_WR_DDDD		1
 
-
 #define GT_PCI_DCRM_SHF		21
 #define GT_PCI_LD_SHF		0
 #define GT_PCI_LD_MSK		(MSK(15) << GT_PCI_LD_SHF)
@@ -292,7 +290,6 @@
 #define GT_PCI_REMAP_SHF	0
 #define GT_PCI_REMAP_MSK	(MSK(11) << GT_PCI_REMAP_SHF)
 
-
 #define GT_CFGADDR_CFGEN_SHF	31
 #define GT_CFGADDR_CFGEN_MSK	(MSK(1) << GT_CFGADDR_CFGEN_SHF)
 #define GT_CFGADDR_CFGEN_BIT	GT_CFGADDR_CFGEN_MSK
@@ -309,7 +306,6 @@
 #define GT_CFGADDR_REGNUM_SHF	2
 #define GT_CFGADDR_REGNUM_MSK	(MSK(6) << GT_CFGADDR_REGNUM_SHF)
 
-
 #define GT_SDRAM_BM_ORDER_SHF	2
 #define GT_SDRAM_BM_ORDER_MSK	(MSK(1) << GT_SDRAM_BM_ORDER_SHF)
 #define GT_SDRAM_BM_ORDER_BIT	GT_SDRAM_BM_ORDER_MSK
@@ -318,7 +314,6 @@
 
 #define GT_SDRAM_BM_RSVD_ALL1	0xffb
 
-
 #define GT_SDRAM_ADDRDECODE_ADDR_SHF	0
 #define GT_SDRAM_ADDRDECODE_ADDR_MSK	(MSK(3) << GT_SDRAM_ADDRDECODE_ADDR_SHF)
 #define GT_SDRAM_ADDRDECODE_ADDR_0	0
@@ -330,7 +325,6 @@
 #define GT_SDRAM_ADDRDECODE_ADDR_6	6
 #define GT_SDRAM_ADDRDECODE_ADDR_7	7
 
-
 #define GT_SDRAM_B0_CASLAT_SHF		0
 #define GT_SDRAM_B0_CASLAT_MSK		(MSK(2) << GT_SDRAM_B0__SHF)
 #define GT_SDRAM_B0_CASLAT_2		1
@@ -396,7 +390,6 @@
 #define GT_SDRAM_B0_BLEN_8		0
 #define GT_SDRAM_B0_BLEN_4		1
 
-
 #define GT_SDRAM_CFG_REFINT_SHF		0
 #define GT_SDRAM_CFG_REFINT_MSK		(MSK(14) << GT_SDRAM_CFG_REFINT_SHF)
 
@@ -443,7 +436,6 @@
 #define GT_TC_CONTROL_SELTC0_MSK	(MSK(1) << GT_TC_CONTROL_SELTC0_SHF)
 #define GT_TC_CONTROL_SELTC0_BIT	GT_TC_CONTROL_SELTC0_MSK
 
-
 #define GT_PCI0_BARE_SWSCS3BOOTDIS_SHF	0
 #define GT_PCI0_BARE_SWSCS3BOOTDIS_MSK	\
 	(MSK(1) << GT_PCI0_BARE_SWSCS3BOOTDIS_SHF)
@@ -481,7 +473,6 @@
 #define GT_PCI0_BARE_SCS10DIS_MSK	(MSK(1) << GT_PCI0_BARE_SCS10DIS_SHF)
 #define GT_PCI0_BARE_SCS10DIS_BIT	GT_PCI0_BARE_SCS10DIS_MSK
 
-
 #define GT_INTRCAUSE_MASABORT0_SHF	18
 #define GT_INTRCAUSE_MASABORT0_MSK	(MSK(1) << GT_INTRCAUSE_MASABORT0_SHF)
 #define GT_INTRCAUSE_MASABORT0_BIT	GT_INTRCAUSE_MASABORT0_MSK
@@ -490,7 +481,6 @@
 #define GT_INTRCAUSE_TARABORT0_MSK	(MSK(1) << GT_INTRCAUSE_TARABORT0_SHF)
 #define GT_INTRCAUSE_TARABORT0_BIT	GT_INTRCAUSE_TARABORT0_MSK
 
-
 #define GT_PCI0_CMD_MBYTESWAP_SHF	0
 #define GT_PCI0_CMD_MBYTESWAP_MSK	(MSK(1) << GT_PCI0_CMD_MBYTESWAP_SHF)
 #define GT_PCI0_CMD_MBYTESWAP_BIT	GT_PCI0_CMD_MBYTESWAP_MSK
diff --git a/include/key_matrix.h b/include/key_matrix.h
index 17f5d12cdd9..fffe2ddc531 100644
--- a/include/key_matrix.h
+++ b/include/key_matrix.h
@@ -8,7 +8,6 @@
 #ifndef _KEY_MATRIX_H
 #define _KEY_MATRIX_H
 
-
 /* Information about a matrix keyboard */
 struct key_matrix {
 	/* Dimensions of the keyboard matrix, in rows and columns */
diff --git a/include/malloc.h b/include/malloc.h
index 161ccbd1298..07d3e90a855 100644
--- a/include/malloc.h
+++ b/include/malloc.h
@@ -213,7 +213,6 @@
      quickly avoid procedure declaration conflicts and linker symbol
      conflicts with existing memory allocation routines.
 
-
 */
 
 
@@ -256,12 +255,10 @@ extern "C" {
 #include <stdio.h>	/* needed for malloc_stats */
 #endif
 
-
 /*
   Compile-time options
 */
 
-
 /*
     Debugging:
 
@@ -306,10 +303,8 @@ extern "C" {
   returns a unique pointer for malloc(0), so does realloc(p, 0).
 */
 
-
 /*   #define REALLOC_ZERO_BYTES_FREES */
 
-
 /*
   WIN32 causes an emulation of sbrk to be compiled in
   mmap-based options are not currently supported in WIN32.
@@ -335,7 +330,6 @@ extern "C" {
 #include <windows.h>
 #endif
 
-
 /*
   HAVE_MEMCPY should be defined if you are not otherwise using
   ANSI STD C, but still have memcpy and memset in your C library
@@ -460,7 +454,6 @@ do {                                                                          \
 
 #endif
 
-
 /*
   Define HAVE_MMAP to optionally make malloc() use mmap() to
   allocate very large blocks.  These will be returned to the
@@ -563,7 +556,6 @@ do {                                                                          \
 #  endif
 #endif
 
-
 /*
 
   This version of malloc supports the standard SVID/XPG mallinfo
@@ -626,7 +618,6 @@ struct mallinfo {
 #define M_MMAP_THRESHOLD    -3
 #define M_MMAP_MAX          -4
 
-
 #ifndef DEFAULT_TRIM_THRESHOLD
 #define DEFAULT_TRIM_THRESHOLD (128 * 1024)
 #endif
@@ -677,10 +668,8 @@ struct mallinfo {
       It must be greater than page size to have any useful effect.  To
       disable trimming completely, you can set to (unsigned long)(-1);
 
-
 */
 
-
 #ifndef DEFAULT_TOP_PAD
 #define DEFAULT_TOP_PAD        (0)
 #endif
@@ -713,7 +702,6 @@ struct mallinfo {
 
 */
 
-
 #ifndef DEFAULT_MMAP_THRESHOLD
 #define DEFAULT_MMAP_THRESHOLD (128 * 1024)
 #endif
@@ -753,10 +741,8 @@ struct mallinfo {
       All together, these considerations should lead you to use mmap
       only for relatively large requests.
 
-
 */
 
-
 #ifndef DEFAULT_MMAP_MAX
 #ifdef HAVE_MMAP
 #define DEFAULT_MMAP_MAX       (64)
@@ -784,7 +770,6 @@ struct mallinfo {
       in mallopt will fail.
 */
 
-
 /*
     USE_DL_PREFIX will prefix all public routines with the string 'dl'.
       Useful to quickly avoid procedure declaration conflicts and linker
@@ -815,7 +800,6 @@ struct mallinfo {
 
 */
 
-
 #ifdef INTERNAL_LINUX_C_LIB
 
 #if __STD_C
diff --git a/include/mc13892.h b/include/mc13892.h
index 8e8b63e7691..d9ef53b1e48 100644
--- a/include/mc13892.h
+++ b/include/mc13892.h
@@ -6,7 +6,6 @@
  * (C) Copyright 2009 Freescale Semiconductor, Inc.
  */
 
-
 #ifndef __MC13892_H__
 #define __MC13892_H__
 
diff --git a/include/micrel.h b/include/micrel.h
index a2593c5b10c..6294bffc582 100644
--- a/include/micrel.h
+++ b/include/micrel.h
@@ -32,7 +32,6 @@
 #define PHY_ID_KSZ9031				0x00221620
 #define PHY_ID_KSZ9131				0x00221640
 
-
 /* Registers */
 #define MMD_ACCESS_CONTROL	0xd
 #define MMD_ACCESS_REG_DATA	0xe
diff --git a/include/mmc.h b/include/mmc.h
index 7f1900363b9..155a8e9f420 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -73,7 +73,6 @@ struct bd_info;
 #define MMC_MODE_1BIT		BIT(28)
 #define MMC_MODE_SPI		BIT(27)
 
-
 #define SD_DATA_4BIT	0x00040000
 
 #define IS_SD(x)	((x)->version & SD_VERSION_SD)
@@ -113,7 +112,6 @@ struct bd_info;
 #define MMC_CMD62_ARG1			0xefac62ec
 #define MMC_CMD62_ARG2			0xcbaea7
 
-
 #define SD_CMD_SEND_RELATIVE_ADDR	3
 #define SD_CMD_SWITCH_FUNC		6
 #define SD_CMD_SEND_IF_COND		8
diff --git a/include/mpc8xx.h b/include/mpc8xx.h
index 0e0e0cb70d7..53e0be3de47 100644
--- a/include/mpc8xx.h
+++ b/include/mpc8xx.h
@@ -13,7 +13,6 @@
 #ifndef __MPCXX_H__
 #define __MPCXX_H__
 
-
 /*-----------------------------------------------------------------------
  * Exception offsets (PowerPC standard)
  */
@@ -200,7 +199,6 @@
 #define SCCR_DFALCD10	0x00000002	/* Division by 5			*/
 #define SCCR_DFALCD11	0x00000003	/* Division by 7 (maximum)		*/
 
-
 /*-----------------------------------------------------------------------
  * BR - Memory Controler: Base Register					16-9
  */
@@ -253,7 +251,6 @@
 #define OR_TRLX		0x00000004	/* Timing Relaxed			*/
 #define OR_EHTR		0x00000002	/* Extended Hold Time on Read		*/
 
-
 /*-----------------------------------------------------------------------
  * MPTPR - Memory Periodic Timer Prescaler Register			16-17
  */
@@ -464,7 +461,6 @@
 #define TGCR_STP1	0x0002		/* Stop timer	1		*/
 #define TGCR_RST1	0x0001		/* Reset timer	1		*/
 
-
 /*-----------------------------------------------------------------------
  * Timer Mode Register							18-9
  */
@@ -485,7 +481,6 @@
 #define TMR_ICLK_TIN_PIN	0x0006	/* TINx pin				*/
 #define TMR_GE			0x0001	/* Gate Enable				*/
 
-
 /*-----------------------------------------------------------------------
  * I2C Controller Registers
  */
diff --git a/include/mv88e6352.h b/include/mv88e6352.h
index 152a0774fc0..4de9dbdb799 100644
--- a/include/mv88e6352.h
+++ b/include/mv88e6352.h
@@ -7,7 +7,6 @@
 #ifndef __MV886352_H
 #define __MV886352_H
 
-
 /* PHY registers */
 #define PHY(itf)	(itf)
 
diff --git a/include/nand.h b/include/nand.h
index cdba7384ad1..3a0ef6ad9cc 100644
--- a/include/nand.h
+++ b/include/nand.h
@@ -58,7 +58,6 @@ static inline int nand_erase(struct mtd_info *info, loff_t off, size_t size)
 	return mtd_erase(info, &instr);
 }
 
-
 /*****************************************************************************
  * declarations from nand_util.c
  ****************************************************************************/
diff --git a/include/net.h b/include/net.h
index ac511eab103..bb2ae20f52a 100644
--- a/include/net.h
+++ b/include/net.h
@@ -225,7 +225,6 @@ int eth_get_dev_index(void);		/* get the device index */
 int eth_env_set_enetaddr_by_index(const char *base_name, int index,
 				 uchar *enetaddr);
 
-
 /*
  * Initialize USB ethernet device with CONFIG_DM_ETH
  * Returns:
diff --git a/include/part.h b/include/part.h
index 32ee4048856..b187ec4b4bd 100644
--- a/include/part.h
+++ b/include/part.h
@@ -609,7 +609,6 @@ int gpt_verify_partitions(struct blk_desc *desc,
 			  struct disk_partition *partitions, int parts,
 			  gpt_header *gpt_head, gpt_entry **gpt_pte);
 
-
 /**
  * get_disk_guid() - Read the GUID string from a device's GPT
  *
diff --git a/include/pci.h b/include/pci.h
index ea3b73923d6..5fea815b48c 100644
--- a/include/pci.h
+++ b/include/pci.h
@@ -272,7 +272,6 @@
 #define  PCI_X_CMD_MAX_SPLIT    0x0030  /* Max Outstanding Split Transactions */
 #define  PCI_X_CMD_VERSION(x)   (((x) >> 12) & 3) /* Version */
 
-
 /* Slot Identification */
 
 #define PCI_SID_ESR		2	/* Expansion Slot Register */
diff --git a/include/pci_gt64120.h b/include/pci_gt64120.h
index c9fb9fa8d5a..f06e86b98ff 100644
--- a/include/pci_gt64120.h
+++ b/include/pci_gt64120.h
@@ -12,5 +12,4 @@ void gt64120_pci_init(void *regs, unsigned long sys_bus, unsigned long sys_phys,
 		     unsigned long io_bus, unsigned long io_phys,
 		     unsigned long io_size);
 
-
 #endif /* _PCI_GT64120_H */
diff --git a/include/pci_ids.h b/include/pci_ids.h
index 6f095442cac..191d277bc8a 100644
--- a/include/pci_ids.h
+++ b/include/pci_ids.h
@@ -1535,7 +1535,6 @@
 #define PCI_VENDOR_ID_ZIATECH		0x1138
 #define PCI_DEVICE_ID_ZIATECH_5550_HC	0x5550
 
-
 #define PCI_VENDOR_ID_SYSKONNECT	0x1148
 #define PCI_DEVICE_ID_SYSKONNECT_TR	0x4200
 #define PCI_DEVICE_ID_SYSKONNECT_GE	0x4300
diff --git a/include/scsi.h b/include/scsi.h
index cf756aa62e1..b18ae37b861 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -95,7 +95,6 @@ struct scsi_cmd {
 #define	M_X_WIDE_REQ	(0x03)
 #define	M_X_PPR_REQ	(0x04)
 
-
 /*
 **	Status
 */
@@ -131,7 +130,6 @@ struct scsi_cmd {
 #define SENSE_VOLUME_OVERFLOW	0xD
 #define SENSE_MISCOMPARE			0xE
 
-
 #define SCSI_CHANGE_DEF	0x40		/* Change Definition (Optional) */
 #define SCSI_COMPARE		0x39		/* Compare (O) */
 #define SCSI_COPY			0x18		/* Copy (O) */
diff --git a/include/spd.h b/include/spd.h
index 2bcf46de6df..8b24a1e97f4 100644
--- a/include/spd.h
+++ b/include/spd.h
@@ -77,7 +77,6 @@ typedef struct spd_eeprom_s {
 	unsigned char intel_cas;   /* 129 Intel spec: CAS# Latency support */
 } spd_eeprom_t;
 
-
 /*
  * Byte 2 Fundamental Memory Types.
  */
diff --git a/include/spl.h b/include/spl.h
index 5dfdf778d2d..1eebea3f981 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -436,7 +436,6 @@ int spl_load_legacy_img(struct spl_image_info *spl_image,
 			struct spl_load_info *load, ulong offset,
 			struct legacy_img_hdr *hdr);
 
-
 /**
  * spl_load_imx_container() - Loads a imx container image from a device.
  * @spl_image:	Image description to set up
diff --git a/include/tegra-kbc.h b/include/tegra-kbc.h
index 1208b75ee78..316e6b1a680 100644
--- a/include/tegra-kbc.h
+++ b/include/tegra-kbc.h
@@ -7,7 +7,6 @@
 #ifndef __include_tegra_kbc_h__
 #define __include_tegra_kbc_h__
 
-
 #define KEY_IS_MODIFIER(key) ((key) >= KEY_FIRST_MODIFIER)
 
 struct kbc_tegra {
diff --git a/include/usb.h b/include/usb.h
index 3aafdc8bfd1..fcbe2146f7d 100644
--- a/include/usb.h
+++ b/include/usb.h
@@ -274,7 +274,6 @@ int usb_init(void);
 int usb_stop(void); /* stop the USB Controller */
 int usb_detect_change(void); /* detect if a USB device has been (un)plugged */
 
-
 int usb_set_protocol(struct usb_device *dev, int ifnum, int protocol);
 int usb_set_idle(struct usb_device *dev, int ifnum, int duration,
 			int report_id);
@@ -600,7 +599,6 @@ struct usb_hub_descriptor {
 	} u;
 } __attribute__ ((packed));
 
-
 struct usb_hub_device {
 	struct usb_device *pusb_dev;
 	struct usb_hub_descriptor desc;
diff --git a/include/usb_defs.h b/include/usb_defs.h
index ec00161710a..28757c8cae9 100644
--- a/include/usb_defs.h
+++ b/include/usb_defs.h
@@ -30,7 +30,6 @@
 #define USB_PROT_HID_KEYBOARD   1
 #define USB_PROT_HID_MOUSE      2
 
-
 /* Sub STORAGE Classes */
 #define US_SC_RBC              1		/* Typically, flash devices */
 #define US_SC_8020             2		/* CD-ROM */
@@ -190,7 +189,6 @@
 #define USB_TEST_MODE_PACKET        0x04
 #define USB_TEST_MODE_FORCE_ENABLE  0x05
 
-
 /*
  * "pipe" definitions, use unsigned so we can compare reliably, since this
  * value is shifted up to bits 30/31.
@@ -225,7 +223,6 @@
 #define USB_ST_BIT_ERR          0x40	/* Bitstuff error */
 #define USB_ST_NOT_PROC         0x80000000L	/* Not yet processed */
 
-
 /*************************************************************************
  * Hub defines
  */
diff --git a/include/usbdescriptors.h b/include/usbdescriptors.h
index 641b4a3e6f2..db1d6ef791b 100644
--- a/include/usbdescriptors.h
+++ b/include/usbdescriptors.h
@@ -58,7 +58,6 @@
  *
  */
 
-
 #ifndef __USBDESCRIPTORS_H__
 #define __USBDESCRIPTORS_H__
 
@@ -111,7 +110,6 @@
 /* c.f. CDC 4.7 Table 19 */
 #define DATA_INTERFACE_PROTOCOL_NONE	0x00	/* No class protcol required */
 
-
 /* c.f. CDC 5.2.3 Table 24 */
 #define CS_INTERFACE		0x24
 #define CS_ENDPOINT			0x25
@@ -168,7 +166,6 @@
 #define BULK		0x02
 #define INTERRUPT	0x03
 
-
 /* configuration modifiers
  */
 #define BMATTRIBUTE_RESERVED		0x80
@@ -239,7 +236,6 @@ struct usb_generic_descriptor {
 	u8 bDescriptorSubtype;
 } __attribute__ ((packed));
 
-
 /*
  * communications class descriptor structures
  *
@@ -319,7 +315,6 @@ struct usb_class_country_selection_descriptor {
 	u16 wCountryCode0[0];
 } __attribute__ ((packed));
 
-
 struct usb_class_telephone_operational_descriptor {
 	u8 bFunctionLength;
 	u8 bDescriptorType;
@@ -327,7 +322,6 @@ struct usb_class_telephone_operational_descriptor {
 	u8 bmCapabilities;
 } __attribute__ ((packed));
 
-
 struct usb_class_usb_terminal_descriptor {
 	u8 bFunctionLength;
 	u8 bDescriptorType;
@@ -405,7 +399,6 @@ struct usb_class_atm_networking_descriptor {
 	u16 wMaxVC;
 } __attribute__ ((packed));
 
-
 struct usb_class_mdlm_descriptor {
 	u8 bFunctionLength;
 	u8 bDescriptorType;
diff --git a/include/usbdevice.h b/include/usbdevice.h
index e59f5587eea..d173c1c4e37 100644
--- a/include/usbdevice.h
+++ b/include/usbdevice.h
@@ -19,10 +19,8 @@
 
 #include "usbdescriptors.h"
 
-
 #define MAX_URBS_QUEUED 5
 
-
 #if 1
 #define usberr(fmt,args...) serial_printf("ERROR: %s(), %d: "fmt"\n",__FUNCTION__,__LINE__,##args)
 #else
@@ -269,14 +267,12 @@ struct usb_bus_instance;
 #define USB_REQ_SET_IDLE		0x0A
 #define USB_REQ_SET_PROTOCOL		0x0B
 
-
 /*
  * USB Spec Release number
  */
 
 #define USB_BCD_VERSION			0x0110
 
-
 /*
  * Device Requests	(c.f Table 9-2)
  */
@@ -328,7 +324,6 @@ struct usb_bus_instance;
 #define USB_DEVICE_REMOTE_WAKEUP	0x01
 #define USB_TEST_MODE			0x02
 
-
 /* USB Requests
  *
  */
@@ -341,7 +336,6 @@ struct usb_device_request {
 	u16 wLength;
 } __attribute__ ((packed));
 
-
 /* USB Status
  *
  */
@@ -425,7 +419,6 @@ typedef enum usb_device_event {
 
 } usb_device_event_t;
 
-
 typedef struct urb_link {
 	struct urb_link *next;
 	struct urb_link *prev;
@@ -519,7 +512,6 @@ struct usb_configuration_instance {
 	struct usb_interface_instance *interface_instance_array;
 };
 
-
 /* USB Device Instance
  *
  * For each physical bus interface we create a logical device structure. This
diff --git a/include/xyzModem.h b/include/xyzModem.h
index a8911b6bf57..0de8788ca76 100644
--- a/include/xyzModem.h
+++ b/include/xyzModem.h
@@ -44,7 +44,6 @@
 #define xyzModem_close 1
 #define xyzModem_abort 2
 
-
 #define CYGNUM_CALL_IF_SET_COMM_ID_QUERY_CURRENT
 #define CYGACC_CALL_IF_SET_CONSOLE_COMM(x)
 
@@ -60,8 +59,6 @@ typedef struct {
     int   chan;
 } connection_info_t;
 
-
-
 int   xyzModem_stream_open(connection_info_t *info, int *err);
 void  xyzModem_stream_close(int *err);
 void  xyzModem_stream_terminate(bool method, int (*getc)(void));
diff --git a/include/zfs_common.h b/include/zfs_common.h
index cb83e59e836..8b93d689c90 100644
--- a/include/zfs_common.h
+++ b/include/zfs_common.h
@@ -27,14 +27,12 @@
 #define SECTOR_SIZE			0x200
 #define SECTOR_BITS			9
 
-
 typedef enum zfs_endian {
 	UNKNOWN_ENDIAN = -2,
 	LITTLE_ENDIAN = -1,
 	BIG_ENDIAN = 0
 } zfs_endian_t;
 
-
 /* Endian macros. */
 #define zfs_to_cpu16(x, a) (((a) == BIG_ENDIAN) ? be16_to_cpu(x) \
 								: le16_to_cpu(x))
@@ -51,7 +49,6 @@ typedef enum zfs_endian {
 #define cpu_to_zfs64(x, a) (((a) == BIG_ENDIAN) ? cpu_to_be64(x) \
 								: cpu_to_le64(x))
 
-
 enum zfs_errors {
 	ZFS_ERR_NONE = 0,
 	ZFS_ERR_NOT_IMPLEMENTED_YET = -1,
@@ -89,9 +86,6 @@ struct zfs_dirhook_info {
 	time_t mtime2;
 };
 
-
-
-
 struct zfs_filesystem *zfsget_fs(void);
 int zfs_open(zfs_file_t, const char *filename);
 uint64_t zfs_read(zfs_file_t, char *buf, uint64_t len);
-- 
2.43.0

