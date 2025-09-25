Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12286CAC5B9
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9812F830CA;
	Thu, 25 Sep 2025 22:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rCTnPsG2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 077CA8319C; Thu, 25 Sep 2025 22:43:21 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59684809A5
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-35ba7c71bfdso943219fac.3
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758832997; x=1759437797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oCCaZ14cyiQ1n2mHEQiSMq2gNHiuqpphO362asDRryE=;
 b=rCTnPsG2jhrIgu+esrJUUTVHoHIpkm4zQI5C8p0KTgNuQBOMmivX8i5VlVqbKkcMzd
 PJRevDpnSIA+j4S1/IhZkYA/lUb4F0rOtMKmst59ilwrZbw8AEY4of2qylYRu9q82KeK
 XAi5IlHPf1D2fZuQeaNDUybNICzuNSpTe5iog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758832997; x=1759437797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oCCaZ14cyiQ1n2mHEQiSMq2gNHiuqpphO362asDRryE=;
 b=r54ne1ahxLHJbIXcm90JXCD0K85E5OWYpNUwGrHez+fq+MpIbNOdzwFZQzrie3JmYa
 H8O9OE6+zHamJE6Nf2FZLAmbizglm/3e3rZHkYVQN/EWYA3eQ4MwvVf2V7byILgU2D1S
 IdL/2Xf1Jf0/YhFIRDxF3ttzocPvLpUWMz9vapxgcbEmuVr7eEeN+DWywBKmf+GIy1CX
 5eFdwzpTybbcjFPwu4XMluDWy0ELivg6B7pyg73RT8iqT8uNAPeTj1hFPcycp6KuNm2o
 ZGBW/CNz+0OrhEo6uTSp3cKo7+nJPtELeJT7l2IP10aNVzqrLAI1UfAvKt/PP+K1qmjg
 TVeg==
X-Gm-Message-State: AOJu0Yxxv63yRIzvW62Xx8qTHPjbf96Yze2pHdSjrtZG/RAFYgh3PIXA
 7F/HZbkYj7s+bkinLVwNreiQnf4rpoFrkqEGGMX1KD6pjP37mvK3DLo5YlU4hed6l+oaBIoSGDQ
 Ucz/E930=
X-Gm-Gg: ASbGncukm5XfCznVsz10DlLTNbBWmmfAGxAWU9zMsyT9o0AB/LIE2fe40K99ARxtoPL
 hMUC9Yu8ycICbg3oAwc/Wy3TJ4qzdLaT0Tgv7Dei94DqPKj3/nSerRrV8CE/6NWdnVjMqC4wwai
 BF4lpQyTg2vqUEswUcUxuQL08ocMU1ulEqZZS8St+vJQqIyYogagW7aeHx1tXhrKGOaN2U+LMz6
 B04DGhX8K3HUVBJgV9XCm/iQVAUV4Q7Uu6n23Kbj7U+WEQ0mlxZnX3SCbZsAZL0nTmxVk3aA/zd
 VgZ1G2DFPbdl+Ugf0/9jNYFPWqd2pWAUEAd0B2N1vIEgdr2qOyjcjnhf2n+F0/Tpax8F+g7kmY2
 Ju7KP04K6VCX/vPU1q7DPeXZTH+9FgzwCAonFg2SWjLcnixaT0DQVru1Xqq0=
X-Google-Smtp-Source: AGHT+IG5RLmdbskRaiXNpvFF5b7HAW/Ajw67Rkn5B3ttvx/JsCxnhJQTC3jLiaX6JAjgp2cFXGCX5g==
X-Received: by 2002:a05:6870:8326:b0:35d:45c7:4a97 with SMTP id
 586e51a60fabf-35eea473fbamr2715222fac.34.1758832996871; 
 Thu, 25 Sep 2025 13:43:16 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-63b25ef3ff6sm332359eaf.16.2025.09.25.13.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:43:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Subject: [PATCH] pci: Remove pcie_intel_fpga driver
Date: Thu, 25 Sep 2025 14:43:14 -0600
Message-ID: <20250925204314.3560861-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This driver has never been enabled by a platform since introduction and
does not currently compile. Remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tien Fong Chee <tien.fong.chee@altera.com>

This might have been used on SoCFPA at some point, but not fully
upstreamed.
---
 drivers/pci/Kconfig           |   6 -
 drivers/pci/Makefile          |   1 -
 drivers/pci/pcie_intel_fpga.c | 434 ----------------------------------
 3 files changed, 441 deletions(-)
 delete mode 100644 drivers/pci/pcie_intel_fpga.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 6c2cda1a9666..ea9868425d04 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -333,12 +333,6 @@ config PCIE_IMX
 	bool "i.MX PCIe support"
 	depends on ARCH_MX6
 
-config PCIE_INTEL_FPGA
-	bool "Intel FPGA PCIe support"
-	help
-	  Say Y here if you want to enable PCIe controller support on Intel
-	  FPGA, example Stratix 10.
-
 config PCIE_IPROC
 	bool "Iproc PCIe support"
 	help
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index a0420e733ed2..98f3c226f63e 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -40,7 +40,6 @@ obj-$(CONFIG_PCIE_LAYERSCAPE_GEN4) += pcie_layerscape_gen4.o \
 				pcie_layerscape_fixup_common.o
 obj-$(CONFIG_PCI_XILINX) += pcie_xilinx.o
 obj-$(CONFIG_PCI_PHYTIUM) += pcie_phytium.o
-obj-$(CONFIG_PCIE_INTEL_FPGA) += pcie_intel_fpga.o
 obj-$(CONFIG_PCIE_DW_COMMON) += pcie_dw_common.o
 obj-$(CONFIG_PCI_KEYSTONE) += pcie_dw_ti.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie_mediatek.o
diff --git a/drivers/pci/pcie_intel_fpga.c b/drivers/pci/pcie_intel_fpga.c
deleted file mode 100644
index 959fd3690869..000000000000
--- a/drivers/pci/pcie_intel_fpga.c
+++ /dev/null
@@ -1,434 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Intel FPGA PCIe host controller driver
- *
- * Copyright (C) 2013-2018 Intel Corporation. All rights reserved
- *
- */
-
-#include <dm.h>
-#include <pci.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <dm/device_compat.h>
-#include <linux/bitops.h>
-#include <linux/delay.h>
-
-#define RP_TX_REG0			0x2000
-#define RP_TX_CNTRL			0x2004
-#define RP_TX_SOP			BIT(0)
-#define RP_TX_EOP			BIT(1)
-#define RP_RXCPL_STATUS			0x200C
-#define RP_RXCPL_SOP			BIT(0)
-#define RP_RXCPL_EOP			BIT(1)
-#define RP_RXCPL_REG			0x2008
-#define P2A_INT_STATUS			0x3060
-#define P2A_INT_STS_ALL			0xf
-#define P2A_INT_ENABLE			0x3070
-#define RP_CAP_OFFSET			0x70
-
-/* TLP configuration type 0 and 1 */
-#define TLP_FMTTYPE_CFGRD0		0x04	/* Configuration Read Type 0 */
-#define TLP_FMTTYPE_CFGWR0		0x44	/* Configuration Write Type 0 */
-#define TLP_FMTTYPE_CFGRD1		0x05	/* Configuration Read Type 1 */
-#define TLP_FMTTYPE_CFGWR1		0x45	/* Configuration Write Type 1 */
-#define TLP_PAYLOAD_SIZE		0x01
-#define TLP_READ_TAG			0x1d
-#define TLP_WRITE_TAG			0x10
-#define RP_DEVFN			0
-
-#define RP_CFG_ADDR(pcie, reg)						\
-		((pcie->hip_base) + (reg) + (1 << 20))
-#define RP_SECONDARY(pcie)						\
-	readb(RP_CFG_ADDR(pcie, PCI_SECONDARY_BUS))
-#define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
-
-#define TLP_CFGRD_DW0(pcie, bus)					\
-	((((bus > RP_SECONDARY(pcie)) ? TLP_FMTTYPE_CFGRD1		\
-				      : TLP_FMTTYPE_CFGRD0) << 24) |	\
-					TLP_PAYLOAD_SIZE)
-
-#define TLP_CFGWR_DW0(pcie, bus)					\
-	((((bus > RP_SECONDARY(pcie)) ? TLP_FMTTYPE_CFGWR1		\
-				      : TLP_FMTTYPE_CFGWR0) << 24) |	\
-					TLP_PAYLOAD_SIZE)
-
-#define TLP_CFG_DW1(pcie, tag, be)					\
-	(((TLP_REQ_ID(pcie->first_busno,  RP_DEVFN)) << 16) | (tag << 8) | (be))
-#define TLP_CFG_DW2(bus, dev, fn, offset)				\
-	(((bus) << 24) | ((dev) << 19) | ((fn) << 16) | (offset))
-
-#define TLP_COMP_STATUS(s)		(((s) >> 13) & 7)
-#define TLP_BYTE_COUNT(s)		(((s) >> 0) & 0xfff)
-#define TLP_HDR_SIZE			3
-#define TLP_LOOP			20000
-#define DWORD_MASK			3
-
-#define IS_ROOT_PORT(pcie, bdf)				\
-		((PCI_BUS(bdf) == pcie->first_busno) ? true : false)
-
-/**
- * struct intel_fpga_pcie - Intel FPGA PCIe controller state
- * @bus: Pointer to the PCI bus
- * @cra_base: The base address of CRA register space
- * @hip_base: The base address of Rootport configuration space
- * @first_busno: This driver supports multiple PCIe controllers.
- *               first_busno stores the bus number of the PCIe root-port
- *               number which may vary depending on the PCIe setup.
- */
-struct intel_fpga_pcie {
-	struct udevice *bus;
-	void __iomem *cra_base;
-	void __iomem *hip_base;
-	int first_busno;
-};
-
-/**
- * Intel FPGA PCIe port uses BAR0 of RC's configuration space as the
- * translation from PCI bus to native BUS. Entire DDR region is mapped
- * into PCIe space using these registers, so it can be reached by DMA from
- * EP devices.
- * The BAR0 of bridge should be hidden during enumeration to avoid the
- * sizing and resource allocation by PCIe core.
- */
-static bool intel_fpga_pcie_hide_rc_bar(struct intel_fpga_pcie *pcie,
-					pci_dev_t bdf, int offset)
-{
-	if (IS_ROOT_PORT(pcie, bdf) && PCI_DEV(bdf) == 0 &&
-	    PCI_FUNC(bdf) == 0 && offset == PCI_BASE_ADDRESS_0)
-		return true;
-
-	return false;
-}
-
-static inline void cra_writel(struct intel_fpga_pcie *pcie, const u32 value,
-			      const u32 reg)
-{
-	writel(value, pcie->cra_base + reg);
-}
-
-static inline u32 cra_readl(struct intel_fpga_pcie *pcie, const u32 reg)
-{
-	return readl(pcie->cra_base + reg);
-}
-
-static bool intel_fpga_pcie_link_up(struct intel_fpga_pcie *pcie)
-{
-	return !!(readw(RP_CFG_ADDR(pcie, RP_CAP_OFFSET + PCI_EXP_LNKSTA))
-			& PCI_EXP_LNKSTA_DLLLA);
-}
-
-static bool intel_fpga_pcie_addr_valid(struct intel_fpga_pcie *pcie,
-				       pci_dev_t bdf)
-{
-	/* If there is no link, then there is no device */
-	if (!IS_ROOT_PORT(pcie, bdf) && !intel_fpga_pcie_link_up(pcie))
-		return false;
-
-	/* access only one slot on each root port */
-	if (IS_ROOT_PORT(pcie, bdf) && PCI_DEV(bdf) > 0)
-		return false;
-
-	if ((PCI_BUS(bdf) == pcie->first_busno + 1) && PCI_DEV(bdf) > 0)
-		return false;
-
-	return true;
-}
-
-static void tlp_write_tx(struct intel_fpga_pcie *pcie, u32 reg0, u32 ctrl)
-{
-	cra_writel(pcie, reg0, RP_TX_REG0);
-	cra_writel(pcie, ctrl, RP_TX_CNTRL);
-}
-
-static int tlp_read_packet(struct intel_fpga_pcie *pcie, u32 *value)
-{
-	int i;
-	u32 ctrl;
-	u32 comp_status;
-	u32 dw[4];
-	u32 count = 0;
-
-	for (i = 0; i < TLP_LOOP; i++) {
-		ctrl = cra_readl(pcie, RP_RXCPL_STATUS);
-		if (!(ctrl & RP_RXCPL_SOP))
-			continue;
-
-		/* read first DW */
-		dw[count++] = cra_readl(pcie, RP_RXCPL_REG);
-
-		/* Poll for EOP */
-		for (i = 0; i < TLP_LOOP; i++) {
-			ctrl = cra_readl(pcie, RP_RXCPL_STATUS);
-			dw[count++] = cra_readl(pcie, RP_RXCPL_REG);
-			if (ctrl & RP_RXCPL_EOP) {
-				comp_status = TLP_COMP_STATUS(dw[1]);
-				if (comp_status) {
-					*value = pci_get_ff(PCI_SIZE_32);
-					return 0;
-				}
-
-				if (value &&
-				    TLP_BYTE_COUNT(dw[1]) == sizeof(u32) &&
-				    count >= 3)
-					*value = dw[3];
-
-				return 0;
-			}
-		}
-
-		udelay(5);
-	}
-
-	dev_err(pcie->dev, "read TLP packet timed out\n");
-	return -ENODEV;
-}
-
-static void tlp_write_packet(struct intel_fpga_pcie *pcie, u32 *headers,
-			     u32 data)
-{
-	tlp_write_tx(pcie, headers[0], RP_TX_SOP);
-
-	tlp_write_tx(pcie, headers[1], 0);
-
-	tlp_write_tx(pcie, headers[2], 0);
-
-	tlp_write_tx(pcie, data, RP_TX_EOP);
-}
-
-static int tlp_cfg_dword_read(struct intel_fpga_pcie *pcie, pci_dev_t bdf,
-			      int offset, u8 byte_en, u32 *value)
-{
-	u32 headers[TLP_HDR_SIZE];
-	u8 busno = PCI_BUS(bdf);
-
-	headers[0] = TLP_CFGRD_DW0(pcie, busno);
-	headers[1] = TLP_CFG_DW1(pcie, TLP_READ_TAG, byte_en);
-	headers[2] = TLP_CFG_DW2(busno, PCI_DEV(bdf), PCI_FUNC(bdf), offset);
-
-	tlp_write_packet(pcie, headers, 0);
-
-	return tlp_read_packet(pcie, value);
-}
-
-static int tlp_cfg_dword_write(struct intel_fpga_pcie *pcie, pci_dev_t bdf,
-			       int offset, u8 byte_en, u32 value)
-{
-	u32 headers[TLP_HDR_SIZE];
-	u8 busno = PCI_BUS(bdf);
-
-	headers[0] = TLP_CFGWR_DW0(pcie, busno);
-	headers[1] = TLP_CFG_DW1(pcie, TLP_WRITE_TAG, byte_en);
-	headers[2] = TLP_CFG_DW2(busno, PCI_DEV(bdf), PCI_FUNC(bdf), offset);
-
-	tlp_write_packet(pcie, headers, value);
-
-	return tlp_read_packet(pcie, NULL);
-}
-
-int intel_fpga_rp_conf_addr(const struct udevice *bus, pci_dev_t bdf,
-			    uint offset, void **paddress)
-{
-	struct intel_fpga_pcie *pcie = dev_get_priv(bus);
-
-	*paddress = RP_CFG_ADDR(pcie, offset);
-
-	return 0;
-}
-
-static int intel_fpga_pcie_rp_rd_conf(struct udevice *bus, pci_dev_t bdf,
-				      uint offset, ulong *valuep,
-				      enum pci_size_t size)
-{
-	return pci_generic_mmap_read_config(bus, intel_fpga_rp_conf_addr,
-					    bdf, offset, valuep, size);
-}
-
-static int intel_fpga_pcie_rp_wr_conf(struct udevice *bus, pci_dev_t bdf,
-				      uint offset, ulong value,
-				      enum pci_size_t size)
-{
-	int ret;
-	struct intel_fpga_pcie *pcie = dev_get_priv(bus);
-
-	ret = pci_generic_mmap_write_config(bus, intel_fpga_rp_conf_addr,
-					    bdf, offset, value, size);
-	if (!ret) {
-		/* Monitor changes to PCI_PRIMARY_BUS register on root port
-		 * and update local copy of root bus number accordingly.
-		 */
-		if (offset == PCI_PRIMARY_BUS)
-			pcie->first_busno = (u8)(value);
-	}
-
-	return ret;
-}
-
-static u8 pcie_get_byte_en(uint offset, enum pci_size_t size)
-{
-	switch (size) {
-	case PCI_SIZE_8:
-		return 1 << (offset & 3);
-	case PCI_SIZE_16:
-		return 3 << (offset & 3);
-	default:
-		return 0xf;
-	}
-}
-
-static int _pcie_intel_fpga_read_config(struct intel_fpga_pcie *pcie,
-					pci_dev_t bdf, uint offset,
-					ulong *valuep, enum pci_size_t size)
-{
-	int ret;
-	u32 data;
-	u8 byte_en;
-
-	/* Uses memory mapped method to read rootport config registers */
-	if (IS_ROOT_PORT(pcie, bdf))
-		return intel_fpga_pcie_rp_rd_conf(pcie->bus, bdf,
-				       offset, valuep, size);
-
-	byte_en = pcie_get_byte_en(offset, size);
-	ret = tlp_cfg_dword_read(pcie, bdf, offset & ~DWORD_MASK,
-				 byte_en, &data);
-	if (ret)
-		return ret;
-
-	dev_dbg(pcie->dev, "(addr,size,val)=(0x%04x, %d, 0x%08x)\n",
-		offset, size, data);
-	*valuep = pci_conv_32_to_size(data, offset, size);
-
-	return 0;
-}
-
-static int _pcie_intel_fpga_write_config(struct intel_fpga_pcie *pcie,
-					 pci_dev_t bdf, uint offset,
-					 ulong value, enum pci_size_t size)
-{
-	u32 data;
-	u8 byte_en;
-
-	dev_dbg(pcie->dev, "PCIE CFG write: (b.d.f)=(%02d.%02d.%02d)\n",
-		PCI_BUS(bdf), PCI_DEV(bdf), PCI_FUNC(bdf));
-	dev_dbg(pcie->dev, "(addr,size,val)=(0x%04x, %d, 0x%08lx)\n",
-		offset, size, value);
-
-	/* Uses memory mapped method to read rootport config registers */
-	if (IS_ROOT_PORT(pcie, bdf))
-		return intel_fpga_pcie_rp_wr_conf(pcie->bus, bdf, offset,
-						  value, size);
-
-	byte_en = pcie_get_byte_en(offset, size);
-	data = pci_conv_size_to_32(0, value, offset, size);
-
-	return tlp_cfg_dword_write(pcie, bdf, offset & ~DWORD_MASK,
-				   byte_en, data);
-}
-
-static int pcie_intel_fpga_read_config(const struct udevice *bus, pci_dev_t bdf,
-				       uint offset, ulong *valuep,
-				       enum pci_size_t size)
-{
-	struct intel_fpga_pcie *pcie = dev_get_priv(bus);
-
-	dev_dbg(pcie->dev, "PCIE CFG read:  (b.d.f)=(%02d.%02d.%02d)\n",
-		PCI_BUS(bdf), PCI_DEV(bdf), PCI_FUNC(bdf));
-
-	if (intel_fpga_pcie_hide_rc_bar(pcie, bdf, offset)) {
-		*valuep = (u32)pci_get_ff(size);
-		return 0;
-	}
-
-	if (!intel_fpga_pcie_addr_valid(pcie, bdf)) {
-		*valuep = (u32)pci_get_ff(size);
-		return 0;
-	}
-
-	return _pcie_intel_fpga_read_config(pcie, bdf, offset, valuep, size);
-}
-
-static int pcie_intel_fpga_write_config(struct udevice *bus, pci_dev_t bdf,
-					uint offset, ulong value,
-					enum pci_size_t size)
-{
-	struct intel_fpga_pcie *pcie = dev_get_priv(bus);
-
-	if (intel_fpga_pcie_hide_rc_bar(pcie, bdf, offset))
-		return 0;
-
-	if (!intel_fpga_pcie_addr_valid(pcie, bdf))
-		return 0;
-
-	return _pcie_intel_fpga_write_config(pcie, bdf, offset, value,
-					  size);
-}
-
-static int pcie_intel_fpga_probe(struct udevice *dev)
-{
-	struct intel_fpga_pcie *pcie = dev_get_priv(dev);
-
-	pcie->bus = pci_get_controller(dev);
-	pcie->first_busno = dev_seq(dev);
-
-	/* clear all interrupts */
-	cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
-	/* disable all interrupts */
-	cra_writel(pcie, 0, P2A_INT_ENABLE);
-
-	return 0;
-}
-
-static int pcie_intel_fpga_of_to_plat(struct udevice *dev)
-{
-	struct intel_fpga_pcie *pcie = dev_get_priv(dev);
-	struct fdt_resource reg_res;
-	int node = dev_of_offset(dev);
-	int ret;
-
-	DECLARE_GLOBAL_DATA_PTR;
-
-	ret = fdt_get_named_resource(gd->fdt_blob, node, "reg", "reg-names",
-				     "Cra", &reg_res);
-	if (ret) {
-		dev_err(dev, "resource \"Cra\" not found\n");
-		return ret;
-	}
-
-	pcie->cra_base = map_physmem(reg_res.start,
-				     fdt_resource_size(&reg_res),
-				     MAP_NOCACHE);
-
-	ret = fdt_get_named_resource(gd->fdt_blob, node, "reg", "reg-names",
-				     "Hip", &reg_res);
-	if (ret) {
-		dev_err(dev, "resource \"Hip\" not found\n");
-		return ret;
-	}
-
-	pcie->hip_base = map_physmem(reg_res.start,
-				     fdt_resource_size(&reg_res),
-				     MAP_NOCACHE);
-
-	return 0;
-}
-
-static const struct dm_pci_ops pcie_intel_fpga_ops = {
-	.read_config	= pcie_intel_fpga_read_config,
-	.write_config	= pcie_intel_fpga_write_config,
-};
-
-static const struct udevice_id pcie_intel_fpga_ids[] = {
-	{ .compatible = "altr,pcie-root-port-2.0" },
-	{},
-};
-
-U_BOOT_DRIVER(pcie_intel_fpga) = {
-	.name			= "pcie_intel_fpga",
-	.id			= UCLASS_PCI,
-	.of_match		= pcie_intel_fpga_ids,
-	.ops			= &pcie_intel_fpga_ops,
-	.of_to_plat	= pcie_intel_fpga_of_to_plat,
-	.probe			= pcie_intel_fpga_probe,
-	.priv_auto	= sizeof(struct intel_fpga_pcie),
-};
-- 
2.43.0

