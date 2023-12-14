Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0779C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF7187B66;
	Thu, 14 Dec 2023 19:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="al/1FFS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F30387B5B; Thu, 14 Dec 2023 19:17:07 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD2887B61
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3b9d8bfe845so6579593b6e.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577823; x=1703182623; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+Db4uDwqKaRE0VL10HKtQuP264loWdybL1GmPftz4A=;
 b=al/1FFS2V5M6232vu076Jfak/cSoHffU+lemaZOgREguHHyl4hXTjvsj50yH90nF9n
 4ZXPHr7360NV/oTekUgpj27suJyoD53gXq4qb41UrhaAibOwl3n+7GckzT1SupYdWbUO
 BotudlWwSdsgSuflmHo23wSRaKVVD2qgTxAVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577823; x=1703182623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+Db4uDwqKaRE0VL10HKtQuP264loWdybL1GmPftz4A=;
 b=twIIAR8MVLtDamC5NCGFj00OvCPDHkS84Wp4ile+jChWoRRZxeavi/52OH3NOGFAT2
 XizAmvCLVSZElcPNbBg9SHRAofXHuiwBrLt5HFMxH/fW3AtgSvvGJB/6FZKPGQocAL+H
 ZNzGDexgwvIoaUOgwzYwrNFyb46lQ3yWToLqgfTIk6ks4DMwR00Y9I/Mlp/+bLjIV5WS
 c8YSija+28TqsPCB5KL3xcULQtgSkcsN9XMdu3PXoMsdwUVfQoTV8HJqOgyGllCoiMBy
 GVyeFROI8Mpn4bmilFs1aqjjTmqISwGC2RHH99mEwujBCZA8MVwUuuj8iSx2oU5Qrc7B
 H+Xg==
X-Gm-Message-State: AOJu0Yzgik0zQcLk5eEVk1CTxTRZts96Z+T2Y8AMt0tzPCLUFHBtdG/G
 VpOkO5J+9AD++ebjJXPQC4RAMjSUvSVf4/HmZXs=
X-Google-Smtp-Source: AGHT+IHlL4wtALPu7jSDrQPQLvVbZdipK0r6SK69yGo+vfQbiCL8IBVFLgC/C2SUsj4l78ykZ+JEJg==
X-Received: by 2002:a05:6808:30aa:b0:3b9:f1ea:5996 with SMTP id
 bl42-20020a05680830aa00b003b9f1ea5996mr13720927oib.55.1702577823077; 
 Thu, 14 Dec 2023 10:17:03 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:17:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v2 05/16] global: Drop common.h inclusion
Date: Thu, 14 Dec 2023 13:16:47 -0500
Message-Id: <20231214181658.3359902-5-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214181658.3359902-1-trini@konsulko.com>
References: <20231214181658.3359902-1-trini@konsulko.com>
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

In order to make it easier to move on to dropping common.h from code
directly, remove common.h inclusion from the rest of the header file
which had been including it.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 board/BuR/common/br_resetc.h                   | 1 -
 board/CZ.NIC/turris_mox/mox_sp.h               | 2 --
 board/freescale/common/vsc3316_3308.h          | 1 -
 board/ti/ks2_evm/mux-k2g.h                     | 1 -
 board/tq/tqma6/tqma6_bb.h                      | 2 --
 board/xilinx/zynqmp/xil_io.h                   | 1 -
 disk/part_amiga.h                              | 1 -
 drivers/bios_emulator/include/x86emu.h         | 1 -
 drivers/crypto/fsl/jobdesc.h                   | 1 -
 drivers/crypto/fsl/rsa_caam.h                  | 2 --
 drivers/ddr/altera/sdram_soc64.h               | 1 -
 drivers/ddr/marvell/a38x/ddr_ml_wrapper.h      | 1 -
 drivers/net/fm/fm.h                            | 1 -
 drivers/net/fsl-mc/dpio/qbman_private.h        | 1 -
 drivers/net/fsl-mc/dpio/qbman_sys.h            | 1 +
 drivers/net/mscc_eswitch/mscc_mac_table.c      | 1 +
 drivers/net/mscc_eswitch/mscc_mac_table.h      | 2 --
 drivers/net/mscc_eswitch/mscc_xfer.c           | 1 +
 drivers/net/mscc_eswitch/mscc_xfer.h           | 2 --
 drivers/pci/pcie_layerscape_fixup_common.h     | 2 --
 drivers/pci_endpoint/pcie-cadence.h            | 1 -
 drivers/pinctrl/mtmips/pinctrl-mtmips-common.h | 2 --
 drivers/usb/gadget/bcm_udc_otg.h               | 2 --
 fs/btrfs/ctree.h                               | 1 -
 fs/yaffs2/ydirectenv.h                         | 1 -
 lib/libavb/avb_sysdeps.h                       | 4 +++-
 lib/zlib/zlib.h                                | 1 -
 net/arp.h                                      | 2 --
 net/link_local.h                               | 5 +----
 net/net_rand.h                                 | 1 -
 net/ping.h                                     | 1 -
 31 files changed, 7 insertions(+), 40 deletions(-)

diff --git a/board/BuR/common/br_resetc.h b/board/BuR/common/br_resetc.h
index ba0689bf2050..999045b867d2 100644
--- a/board/BuR/common/br_resetc.h
+++ b/board/BuR/common/br_resetc.h
@@ -7,7 +7,6 @@
  */
 #ifndef __CONFIG_BRRESETC_H__
 #define __CONFIG_BRRESETC_H__
-#include <common.h>
 
 int br_resetc_regget(u8 reg, u8 *dst);
 int br_resetc_regset(u8 reg, u8 val);
diff --git a/board/CZ.NIC/turris_mox/mox_sp.h b/board/CZ.NIC/turris_mox/mox_sp.h
index 720880d5df32..c766c7423ac5 100644
--- a/board/CZ.NIC/turris_mox/mox_sp.h
+++ b/board/CZ.NIC/turris_mox/mox_sp.h
@@ -6,8 +6,6 @@
 #ifndef _BOARD_CZNIC_TURRIS_MOX_MOX_SP_H_
 #define _BOARD_CZNIC_TURRIS_MOX_MOX_SP_H_
 
-#include <common.h>
-
 enum cznic_a3720_board {
 	BOARD_UNDEFINED		= 0x0,
 	BOARD_TURRIS_MOX	= 0x1,
diff --git a/board/freescale/common/vsc3316_3308.h b/board/freescale/common/vsc3316_3308.h
index 8d343ba4d654..9725d6d9e390 100644
--- a/board/freescale/common/vsc3316_3308.h
+++ b/board/freescale/common/vsc3316_3308.h
@@ -6,7 +6,6 @@
 #ifndef __VSC_CROSSBAR_H_
 #define __VSC_CROSSBAR_H_
 
-#include <common.h>
 #include <i2c.h>
 #include <errno.h>
 
diff --git a/board/ti/ks2_evm/mux-k2g.h b/board/ti/ks2_evm/mux-k2g.h
index f24e62850b8b..447e70607f96 100644
--- a/board/ti/ks2_evm/mux-k2g.h
+++ b/board/ti/ks2_evm/mux-k2g.h
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <hang.h>
 #include <asm/io.h>
 #include <asm/arch/mux-k2g.h>
diff --git a/board/tq/tqma6/tqma6_bb.h b/board/tq/tqma6/tqma6_bb.h
index ca81bdf58535..a2f871af1f83 100644
--- a/board/tq/tqma6/tqma6_bb.h
+++ b/board/tq/tqma6/tqma6_bb.h
@@ -7,8 +7,6 @@
 #ifndef __TQMA6_BB__
 #define __TQMA6_BB__
 
-#include <common.h>
-
 int tqma6_bb_board_mmc_getwp(struct mmc *mmc);
 int tqma6_bb_board_mmc_getcd(struct mmc *mmc);
 int tqma6_bb_board_mmc_init(struct bd_info *bis);
diff --git a/board/xilinx/zynqmp/xil_io.h b/board/xilinx/zynqmp/xil_io.h
index e6caa7c85033..dd823d6f62a5 100644
--- a/board/xilinx/zynqmp/xil_io.h
+++ b/board/xilinx/zynqmp/xil_io.h
@@ -5,7 +5,6 @@
 
 /* FIXME remove this when vivado is fixed */
 #include <asm/io.h>
-#include <common.h>
 #include <linux/delay.h>
 
 #define xil_printf(...)
diff --git a/disk/part_amiga.h b/disk/part_amiga.h
index 42f5eb0f941c..dfa70bdb8a8c 100644
--- a/disk/part_amiga.h
+++ b/disk/part_amiga.h
@@ -7,7 +7,6 @@
 
 #ifndef _DISK_PART_AMIGA_H
 #define _DISK_PART_AMIGA_H
-#include <common.h>
 
 #if CONFIG_IS_ENABLED(ISO_PARTITION)
 /* Make the buffers bigger if ISO partition support is enabled -- CD-ROMS
diff --git a/drivers/bios_emulator/include/x86emu.h b/drivers/bios_emulator/include/x86emu.h
index b28cdc6b8cad..d2650a8d1600 100644
--- a/drivers/bios_emulator/include/x86emu.h
+++ b/drivers/bios_emulator/include/x86emu.h
@@ -42,7 +42,6 @@
 #define __X86EMU_X86EMU_H
 
 #include <asm/types.h>
-#include <common.h>
 #include <pci.h>
 #include <asm/io.h>
 #define X86API
diff --git a/drivers/crypto/fsl/jobdesc.h b/drivers/crypto/fsl/jobdesc.h
index c4501abd26b2..69adfdca95b5 100644
--- a/drivers/crypto/fsl/jobdesc.h
+++ b/drivers/crypto/fsl/jobdesc.h
@@ -7,7 +7,6 @@
 #ifndef __JOBDESC_H
 #define __JOBDESC_H
 
-#include <common.h>
 #include <asm/io.h>
 #include "rsa_caam.h"
 
diff --git a/drivers/crypto/fsl/rsa_caam.h b/drivers/crypto/fsl/rsa_caam.h
index 9a6a8afa4aa7..fb132a3d1814 100644
--- a/drivers/crypto/fsl/rsa_caam.h
+++ b/drivers/crypto/fsl/rsa_caam.h
@@ -6,8 +6,6 @@
 #ifndef __RSA_CAAM_H
 #define __RSA_CAAM_H
 
-#include <common.h>
-
 /**
  * struct pk_in_params - holder for input to PKHA block in CAAM
  * These parameters are required to perform Modular Exponentiation
diff --git a/drivers/ddr/altera/sdram_soc64.h b/drivers/ddr/altera/sdram_soc64.h
index 07a0f9f2ae9b..87a70a861baa 100644
--- a/drivers/ddr/altera/sdram_soc64.h
+++ b/drivers/ddr/altera/sdram_soc64.h
@@ -6,7 +6,6 @@
 #ifndef	_SDRAM_SOC64_H_
 #define	_SDRAM_SOC64_H_
 
-#include <common.h>
 #include <linux/sizes.h>
 
 struct altera_sdram_priv {
diff --git a/drivers/ddr/marvell/a38x/ddr_ml_wrapper.h b/drivers/ddr/marvell/a38x/ddr_ml_wrapper.h
index 735731196589..dff56338b19e 100644
--- a/drivers/ddr/marvell/a38x/ddr_ml_wrapper.h
+++ b/drivers/ddr/marvell/a38x/ddr_ml_wrapper.h
@@ -6,7 +6,6 @@
 #ifndef _DDR_ML_WRAPPER_H
 #define _DDR_ML_WRAPPER_H
 
-#include <common.h>
 #include <i2c.h>
 #include <spl.h>
 #include <asm/io.h>
diff --git a/drivers/net/fm/fm.h b/drivers/net/fm/fm.h
index a2d5b03429ab..5c45ad56d0a5 100644
--- a/drivers/net/fm/fm.h
+++ b/drivers/net/fm/fm.h
@@ -6,7 +6,6 @@
 #ifndef __FM_H__
 #define __FM_H__
 
-#include <common.h>
 #include <phy.h>
 #include <fm_eth.h>
 #include <fsl_fman.h>
diff --git a/drivers/net/fsl-mc/dpio/qbman_private.h b/drivers/net/fsl-mc/dpio/qbman_private.h
index 53f1300eaf80..f9dad178075f 100644
--- a/drivers/net/fsl-mc/dpio/qbman_private.h
+++ b/drivers/net/fsl-mc/dpio/qbman_private.h
@@ -4,7 +4,6 @@
  */
 
 /* Perform extra checking */
-#include <common.h>
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bug.h>
diff --git a/drivers/net/fsl-mc/dpio/qbman_sys.h b/drivers/net/fsl-mc/dpio/qbman_sys.h
index 1c6e48913028..cac70a1291c7 100644
--- a/drivers/net/fsl-mc/dpio/qbman_sys.h
+++ b/drivers/net/fsl-mc/dpio/qbman_sys.h
@@ -20,6 +20,7 @@
 
 /* Trace the 3 different classes of read/write access to QBMan. #undef as
  * required. */
+#include <config.h>
 #include <linux/bug.h>
 #include <linux/printk.h>
 #undef QBMAN_CCSR_TRACE
diff --git a/drivers/net/mscc_eswitch/mscc_mac_table.c b/drivers/net/mscc_eswitch/mscc_mac_table.c
index 25b9cad42c97..06e1f625fb74 100644
--- a/drivers/net/mscc_eswitch/mscc_mac_table.c
+++ b/drivers/net/mscc_eswitch/mscc_mac_table.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
+#include <errno.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include "mscc_mac_table.h"
diff --git a/drivers/net/mscc_eswitch/mscc_mac_table.h b/drivers/net/mscc_eswitch/mscc_mac_table.h
index 17fed2e79253..5ec8db25417d 100644
--- a/drivers/net/mscc_eswitch/mscc_mac_table.h
+++ b/drivers/net/mscc_eswitch/mscc_mac_table.h
@@ -3,8 +3,6 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
-
 #define ETH_LEN 6
 #define MAC_VID 1
 
diff --git a/drivers/net/mscc_eswitch/mscc_xfer.c b/drivers/net/mscc_eswitch/mscc_xfer.c
index 6f7474645717..ee6bf065d3a8 100644
--- a/drivers/net/mscc_eswitch/mscc_xfer.c
+++ b/drivers/net/mscc_eswitch/mscc_xfer.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
+#include <errno.h>
 #include <log.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
diff --git a/drivers/net/mscc_eswitch/mscc_xfer.h b/drivers/net/mscc_eswitch/mscc_xfer.h
index c880a4e7e6a6..70f279401e19 100644
--- a/drivers/net/mscc_eswitch/mscc_xfer.h
+++ b/drivers/net/mscc_eswitch/mscc_xfer.h
@@ -3,8 +3,6 @@
  * Copyright (c) 2018 Microsemi Corporation
  */
 
-#include <common.h>
-
 enum mscc_regs_qs {
 	MSCC_QS_XTR_RD,
 	MSCC_QS_XTR_FLUSH,
diff --git a/drivers/pci/pcie_layerscape_fixup_common.h b/drivers/pci/pcie_layerscape_fixup_common.h
index 70bd3f0cba31..3255b7648c0a 100644
--- a/drivers/pci/pcie_layerscape_fixup_common.h
+++ b/drivers/pci/pcie_layerscape_fixup_common.h
@@ -9,8 +9,6 @@
 #ifndef _PCIE_LAYERSCAPE_FIXUP_COMMON_H_
 #define _PCIE_LAYERSCAPE_FIXUP_COMMON_H_
 
-#include <common.h>
-
 void ft_pci_setup_ls(void *blob, struct bd_info *bd);
 
 #ifdef CONFIG_PCIE_LAYERSCAPE_GEN4
diff --git a/drivers/pci_endpoint/pcie-cadence.h b/drivers/pci_endpoint/pcie-cadence.h
index 8a659c36aa24..dd0101a33af9 100644
--- a/drivers/pci_endpoint/pcie-cadence.h
+++ b/drivers/pci_endpoint/pcie-cadence.h
@@ -11,7 +11,6 @@
 #ifndef PCIE_CADENCE_H
 #define PCIE_CADENCE_H
 
-#include <common.h>
 #include <pci_ep.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
diff --git a/drivers/pinctrl/mtmips/pinctrl-mtmips-common.h b/drivers/pinctrl/mtmips/pinctrl-mtmips-common.h
index 1f1023ef4213..7a38f8d87532 100644
--- a/drivers/pinctrl/mtmips/pinctrl-mtmips-common.h
+++ b/drivers/pinctrl/mtmips/pinctrl-mtmips-common.h
@@ -8,8 +8,6 @@
 #ifndef _PINCTRL_MTMIPS_COMMON_H_
 #define _PINCTRL_MTMIPS_COMMON_H_
 
-#include <common.h>
-
 struct mtmips_pmx_func {
 	const char *name;
 	int value;
diff --git a/drivers/usb/gadget/bcm_udc_otg.h b/drivers/usb/gadget/bcm_udc_otg.h
index 24cc936c6b48..48370f37d8a2 100644
--- a/drivers/usb/gadget/bcm_udc_otg.h
+++ b/drivers/usb/gadget/bcm_udc_otg.h
@@ -6,8 +6,6 @@
 #ifndef __BCM_UDC_OTG_H
 #define __BCM_UDC_OTG_H
 
-#include <common.h>
-
 static inline void wfld_set(uintptr_t addr, uint32_t fld_val, uint32_t fld_mask)
 {
 	writel(((readl(addr) & ~(fld_mask)) | (fld_val)), (addr));
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ffd095ffdd2e..59439552a45c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -9,7 +9,6 @@
 #ifndef __BTRFS_CTREE_H__
 #define __BTRFS_CTREE_H__
 
-#include <common.h>
 #include <compiler.h>
 #include <linux/rbtree.h>
 #include <linux/bug.h>
diff --git a/fs/yaffs2/ydirectenv.h b/fs/yaffs2/ydirectenv.h
index d274f22e84d0..790f8512f742 100644
--- a/fs/yaffs2/ydirectenv.h
+++ b/fs/yaffs2/ydirectenv.h
@@ -20,7 +20,6 @@
 #ifndef __YDIRECTENV_H__
 #define __YDIRECTENV_H__
 
-#include <common.h>
 #include <malloc.h>
 #include <linux/compat.h>
 
diff --git a/lib/libavb/avb_sysdeps.h b/lib/libavb/avb_sysdeps.h
index f52428cc622f..aece8e0a0180 100644
--- a/lib/libavb/avb_sysdeps.h
+++ b/lib/libavb/avb_sysdeps.h
@@ -19,7 +19,9 @@ extern "C" {
  * like uint8_t, uint64_t, and bool (with |false|, |true| keywords)
  * must be present.
  */
-#include <common.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <linux/types.h>
 
 /* If you don't have gcc or clang, these attribute macros may need to
  * be adjusted.
diff --git a/lib/zlib/zlib.h b/lib/zlib/zlib.h
index af3703e6d770..560e7be97d3a 100644
--- a/lib/zlib/zlib.h
+++ b/lib/zlib/zlib.h
@@ -2,7 +2,6 @@
 #ifndef __GLUE_ZLIB_H__
 #define __GLUE_ZLIB_H__
 
-#include <common.h>
 #include <linux/compiler.h>
 #include <asm/unaligned.h>
 #include <watchdog.h>
diff --git a/net/arp.h b/net/arp.h
index 25b3c00d5c56..c50885fb9a57 100644
--- a/net/arp.h
+++ b/net/arp.h
@@ -12,8 +12,6 @@
 #ifndef __ARP_H__
 #define __ARP_H__
 
-#include <common.h>
-
 extern struct in_addr net_arp_wait_packet_ip;
 /* MAC address of waiting packet's destination */
 extern uchar *arp_wait_packet_ethaddr;
diff --git a/net/link_local.h b/net/link_local.h
index bb998164df9b..d8701255142f 100644
--- a/net/link_local.h
+++ b/net/link_local.h
@@ -10,15 +10,12 @@
  * Licensed under the GPL v2 or later
  */
 
-#if defined(CONFIG_CMD_LINK_LOCAL)
-
 #ifndef __LINK_LOCAL_H__
 #define __LINK_LOCAL_H__
 
-#include <common.h>
+struct arp_hdr;
 
 void link_local_receive_arp(struct arp_hdr *arp, int len);
 void link_local_start(void);
 
 #endif /* __LINK_LOCAL_H__ */
-#endif
diff --git a/net/net_rand.h b/net/net_rand.h
index 6a52cda85e03..d3c5559adfd4 100644
--- a/net/net_rand.h
+++ b/net/net_rand.h
@@ -9,7 +9,6 @@
 #ifndef __NET_RAND_H__
 #define __NET_RAND_H__
 
-#include <common.h>
 #include <dm/uclass.h>
 #include <rng.h>
 
diff --git a/net/ping.h b/net/ping.h
index 7b6f4e566dbd..76ac225fc075 100644
--- a/net/ping.h
+++ b/net/ping.h
@@ -12,7 +12,6 @@
 #ifndef __PING_H__
 #define __PING_H__
 
-#include <common.h>
 #include <net.h>
 
 /*
-- 
2.34.1

