Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764C3E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F4B86DC4;
	Tue, 26 Sep 2023 16:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ilAruyWa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1606A86DCB; Tue, 26 Sep 2023 16:16:21 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B1086E87
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3512b425662so19464055ab.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737767; x=1696342567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ASdypPI6G2BZ/5BJdpc9ljB1I3oWLzF0unnLpST42NM=;
 b=ilAruyWa2kvveLm5Kd/mdha+0ZD+sN37BKQZY3axdnHad07qR6ab3MSf298EDcX5FC
 Tjtt8mle4GWYxI+cI8NqnmEALhlllry33KofZ/VpqtI4qc0TZb3on24HapmfUbqG8iTS
 6HmjxsvSEfQqeAtxxuaqN7tW1r6NDWEtDRN80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737767; x=1696342567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ASdypPI6G2BZ/5BJdpc9ljB1I3oWLzF0unnLpST42NM=;
 b=ag+JZP9dcap+ik8M4WxlY/+CJjZBgcwRcsg63AZcAZwtl/EfWcN5n5H0fxRqbvc76k
 /VMNSaTL80d/ABqhvGsdSfk72EFGYOjysBKEH62Qf6QEfIbRh9vbwhfna9dWtjuM1wvk
 +GtetUI+jLKA6ov90QQ7UdYRAm9DzCEEe5IiflaEvPbqckci2NXWjAn25Wzi2jqXFacX
 O7K/0LzaYNEtghOJRImZLDAmMm9uNLFPmyXMWg9XsGYZ7JhyuHhgk6UIjjgAk23sHmsF
 ozt9gyDQ+oNKGRn4wE6aDUvDNhzMcANCpevmOVD3wrDUo0MScai5amehX087owHisrN6
 9brw==
X-Gm-Message-State: AOJu0YwLbdEUjvjH39XVXCI/EynDRZBC+OeTsmTyLLfqCrM6puqV40Ua
 s33o3YGckS5/tE2eI78UFs5dzayiCM5/Rmnd35A=
X-Google-Smtp-Source: AGHT+IGWjMTlmZh7uosuznFQ1zosuBgJhrIXTTSxbXTL8wo+05ga20OpRMeKDlmAN8pGi68QBcNS3Q==
X-Received: by 2002:a05:6e02:1006:b0:346:d51:9922 with SMTP id
 n6-20020a056e02100600b003460d519922mr11764981ilj.13.1695737766856; 
 Tue, 26 Sep 2023 07:16:06 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:16:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 44/44] pci: serial: Support reading PCI-register size with
 base
Date: Tue, 26 Sep 2023 08:14:58 -0600
Message-ID: <20230926141514.2101787-45-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

The PCI helpers read only the base address for a PCI region. In some cases
the size is needed as well, e.g. to pass along to a driver which needs to
know the size of its register area.

Update the functions to allow the size to be returned. For serial, record
the information and provided it with the serial_info() call.

A limitation still exists in that the size is not available when OF_LIVE
is enabled, so take account of that in the tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Avoid reading size except in SPL

 arch/sandbox/dts/test.dts   |  6 +++---
 drivers/core/fdtaddr.c      |  6 +++---
 drivers/core/ofnode.c       | 11 ++++++++---
 drivers/core/read.c         |  6 ++++--
 drivers/core/util.c         |  2 +-
 drivers/pci/pci-uclass.c    |  2 +-
 drivers/pci/pci_mvebu.c     |  3 ++-
 drivers/pci/pci_tegra.c     |  2 +-
 drivers/pci/pcie_mediatek.c |  4 ++--
 drivers/serial/ns16550.c    | 16 +++++++++++-----
 include/dm/fdtaddr.h        |  3 ++-
 include/dm/ofnode.h         |  4 +++-
 include/dm/read.h           |  8 +++++---
 include/ns16550.h           |  4 +++-
 include/serial.h            |  2 ++
 test/dm/pci.c               | 14 ++++++++++----
 16 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 9a863ea732ff..e58cb9c08722 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1123,8 +1123,8 @@
 		pci@1,0 {
 			compatible = "pci-generic";
 			/* reg 0 is at 0x14, using FDT_PCI_SPACE_MEM32 */
-			reg = <0x02000814 0 0 0 0
-			       0x01000810 0 0 0 0>;
+			reg = <0x02000814 0 0 0x80 0
+			       0x01000810 0 0 0xc0 0>;
 			sandbox,emul = <&swap_case_emul0_1>;
 		};
 		p2sb-pci@2,0 {
@@ -1151,7 +1151,7 @@
 		pci@1f,0 {
 			compatible = "pci-generic";
 			/* reg 0 is at 0x10, using FDT_PCI_SPACE_IO */
-			reg = <0x0100f810 0 0 0 0>;
+			reg = <0x0100f810 0 0 0x100 0>;
 			sandbox,emul = <&swap_case_emul0_1f>;
 		};
 	};
diff --git a/drivers/core/fdtaddr.c b/drivers/core/fdtaddr.c
index 546db675aaf6..b79d138c4196 100644
--- a/drivers/core/fdtaddr.c
+++ b/drivers/core/fdtaddr.c
@@ -215,7 +215,7 @@ void *devfdt_map_physmem(const struct udevice *dev, unsigned long size)
 	return map_physmem(addr, size, MAP_NOCACHE);
 }
 
-fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev)
+fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev, fdt_size_t *sizep)
 {
 	ulong addr;
 
@@ -226,12 +226,12 @@ fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev)
 		int ret;
 
 		ret = ofnode_read_pci_addr(dev_ofnode(dev), FDT_PCI_SPACE_MEM32,
-					   "reg", &pci_addr);
+					   "reg", &pci_addr, sizep);
 		if (ret) {
 			/* try if there is any i/o-mapped register */
 			ret = ofnode_read_pci_addr(dev_ofnode(dev),
 						   FDT_PCI_SPACE_IO, "reg",
-						   &pci_addr);
+						   &pci_addr, sizep);
 			if (ret)
 				return FDT_ADDR_T_NONE;
 		}
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 18d2eb0f1186..29a429451020 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1270,7 +1270,8 @@ const uint8_t *ofnode_read_u8_array_ptr(ofnode node, const char *propname,
 }
 
 int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
-			 const char *propname, struct fdt_pci_addr *addr)
+			 const char *propname, struct fdt_pci_addr *addr,
+			 fdt_size_t *size)
 {
 	const fdt32_t *cell;
 	int len;
@@ -1298,14 +1299,18 @@ int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
 			      (ulong)fdt32_to_cpu(cell[1]),
 			      (ulong)fdt32_to_cpu(cell[2]));
 			if ((fdt32_to_cpu(*cell) & type) == type) {
+				const unaligned_fdt64_t *ptr;
+
 				addr->phys_hi = fdt32_to_cpu(cell[0]);
 				addr->phys_mid = fdt32_to_cpu(cell[1]);
 				addr->phys_lo = fdt32_to_cpu(cell[2]);
+				ptr = (const unaligned_fdt64_t *)(cell + 3);
+				if (size)
+					*size = fdt64_to_cpu(*ptr);
 				break;
 			}
 
-			cell += (FDT_PCI_ADDR_CELLS +
-				 FDT_PCI_SIZE_CELLS);
+			cell += FDT_PCI_ADDR_CELLS + FDT_PCI_SIZE_CELLS;
 		}
 
 		if (i == num) {
diff --git a/drivers/core/read.c b/drivers/core/read.c
index 49066b59cdaf..419013451f0c 100644
--- a/drivers/core/read.c
+++ b/drivers/core/read.c
@@ -405,13 +405,15 @@ int dev_read_alias_highest_id(const char *stem)
 	return fdtdec_get_alias_highest_id(gd->fdt_blob, stem);
 }
 
-fdt_addr_t dev_read_addr_pci(const struct udevice *dev)
+fdt_addr_t dev_read_addr_pci(const struct udevice *dev, fdt_size_t *sizep)
 {
 	ulong addr;
 
 	addr = dev_read_addr(dev);
+	if (sizep)
+		*sizep = 0;
 	if (addr == FDT_ADDR_T_NONE && !of_live_active())
-		addr = devfdt_get_addr_pci(dev);
+		addr = devfdt_get_addr_pci(dev, sizep);
 
 	return addr;
 }
diff --git a/drivers/core/util.c b/drivers/core/util.c
index aa60fdd15bc4..81497df85ffd 100644
--- a/drivers/core/util.c
+++ b/drivers/core/util.c
@@ -30,7 +30,7 @@ int pci_get_devfn(struct udevice *dev)
 
 	/* Extract the devfn from fdt_pci_addr */
 	ret = ofnode_read_pci_addr(dev_ofnode(dev), FDT_PCI_SPACE_CONFIG,
-				   "reg", &addr);
+				   "reg", &addr, NULL);
 	if (ret) {
 		if (ret != -ENOENT)
 			return -EINVAL;
diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index ae7350aaff98..e0d01f6a85db 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -123,7 +123,7 @@ static void pci_dev_find_ofnode(struct udevice *bus, phys_addr_t bdf,
 
 	dev_for_each_subnode(node, bus) {
 		ret = ofnode_read_pci_addr(node, FDT_PCI_SPACE_CONFIG, "reg",
-					   &addr);
+					   &addr, NULL);
 		if (ret)
 			continue;
 
diff --git a/drivers/pci/pci_mvebu.c b/drivers/pci/pci_mvebu.c
index 3697cd8d6521..83559550e6fb 100644
--- a/drivers/pci/pci_mvebu.c
+++ b/drivers/pci/pci_mvebu.c
@@ -641,7 +641,8 @@ static int mvebu_pcie_port_parse_dt(ofnode node, ofnode parent, struct mvebu_pci
 		pcie->is_x4 = true;
 
 	/* devfn is in bits [15:8], see PCI_DEV usage */
-	ret = ofnode_read_pci_addr(node, FDT_PCI_SPACE_CONFIG, "reg", &pci_addr);
+	ret = ofnode_read_pci_addr(node, FDT_PCI_SPACE_CONFIG, "reg", &pci_addr,
+				   NULL);
 	if (ret < 0) {
 		printf("%s: property \"reg\" is invalid\n", pcie->name);
 		goto err;
diff --git a/drivers/pci/pci_tegra.c b/drivers/pci/pci_tegra.c
index 131c21b7684e..d6374a58e330 100644
--- a/drivers/pci/pci_tegra.c
+++ b/drivers/pci/pci_tegra.c
@@ -462,7 +462,7 @@ static int tegra_pcie_parse_port_info(ofnode node, uint *index, uint *lanes)
 
 	*lanes = err;
 
-	err = ofnode_read_pci_addr(node, 0, "reg", &addr);
+	err = ofnode_read_pci_addr(node, 0, "reg", &addr, NULL);
 	if (err < 0) {
 		pr_err("failed to parse \"reg\" property\n");
 		return err;
diff --git a/drivers/pci/pcie_mediatek.c b/drivers/pci/pcie_mediatek.c
index ed25a10bcf0f..f0f34b5d1197 100644
--- a/drivers/pci/pcie_mediatek.c
+++ b/drivers/pci/pcie_mediatek.c
@@ -661,7 +661,7 @@ static int mtk_pcie_probe(struct udevice *dev)
 		if (!ofnode_is_enabled(subnode))
 			continue;
 
-		err = ofnode_read_pci_addr(subnode, 0, "reg", &addr);
+		err = ofnode_read_pci_addr(subnode, 0, "reg", &addr, NULL);
 		if (err)
 			return err;
 
@@ -700,7 +700,7 @@ static int mtk_pcie_probe_v2(struct udevice *dev)
 		if (!ofnode_is_enabled(subnode))
 			continue;
 
-		err = ofnode_read_pci_addr(subnode, 0, "reg", &addr);
+		err = ofnode_read_pci_addr(subnode, 0, "reg", &addr, NULL);
 		if (err)
 			return err;
 
diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 5ca2828ae853..6deb1d8ddc56 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -484,6 +484,7 @@ static int ns16550_serial_getinfo(struct udevice *dev,
 	info->addr_space = SERIAL_ADDRESS_SPACE_MEMORY;
 #endif
 	info->addr = plat->base;
+	info->size = plat->size;
 	info->reg_width = plat->reg_width;
 	info->reg_shift = plat->reg_shift;
 	info->reg_offset = plat->reg_offset;
@@ -492,7 +493,8 @@ static int ns16550_serial_getinfo(struct udevice *dev,
 	return 0;
 }
 
-static int ns16550_serial_assign_base(struct ns16550_plat *plat, fdt_addr_t base)
+static int ns16550_serial_assign_base(struct ns16550_plat *plat,
+				      fdt_addr_t base, fdt_size_t size)
 {
 	if (base == FDT_ADDR_T_NONE)
 		return -EINVAL;
@@ -502,6 +504,7 @@ static int ns16550_serial_assign_base(struct ns16550_plat *plat, fdt_addr_t base
 #else
 	plat->base = (unsigned long)map_physmem(base, 0, MAP_NOCACHE);
 #endif
+	plat->size = size;
 
 	return 0;
 }
@@ -512,6 +515,7 @@ int ns16550_serial_probe(struct udevice *dev)
 	struct ns16550 *const com_port = dev_get_priv(dev);
 	struct reset_ctl_bulk reset_bulk;
 	fdt_addr_t addr;
+	fdt_addr_t size;
 	int ret;
 
 	/*
@@ -519,8 +523,8 @@ int ns16550_serial_probe(struct udevice *dev)
 	 * or via a PCI bridge, assign plat->base before probing hardware.
 	 */
 	if (device_is_on_pci_bus(dev)) {
-		addr = devfdt_get_addr_pci(dev);
-		ret = ns16550_serial_assign_base(plat, addr);
+		addr = devfdt_get_addr_pci(dev, &size);
+		ret = ns16550_serial_assign_base(plat, addr, size);
 		if (ret)
 			return ret;
 	}
@@ -547,12 +551,14 @@ int ns16550_serial_of_to_plat(struct udevice *dev)
 {
 	struct ns16550_plat *plat = dev_get_plat(dev);
 	const u32 port_type = dev_get_driver_data(dev);
+	fdt_size_t size = 0;
 	fdt_addr_t addr;
 	struct clk clk;
 	int err;
 
-	addr = dev_read_addr(dev);
-	err = ns16550_serial_assign_base(plat, addr);
+	addr = spl_in_proper() ? dev_read_addr_size(dev, &size) :
+		dev_read_addr(dev);
+	err = ns16550_serial_assign_base(plat, addr, size);
 	if (err && !device_is_on_pci_bus(dev))
 		return err;
 
diff --git a/include/dm/fdtaddr.h b/include/dm/fdtaddr.h
index dcdc19137cc9..6d2fa8f1044b 100644
--- a/include/dm/fdtaddr.h
+++ b/include/dm/fdtaddr.h
@@ -168,8 +168,9 @@ fdt_addr_t devfdt_get_addr_size_name(const struct udevice *dev,
  * devfdt_get_addr_pci() - Read an address and handle PCI address translation
  *
  * @dev: Device to read from
+ * @sizep: If non-NULL, returns size of address space
  * Return: address or FDT_ADDR_T_NONE if not found
  */
-fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev);
+fdt_addr_t devfdt_get_addr_pci(const struct udevice *dev, fdt_size_t *sizep);
 
 #endif
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index ef1437cc5562..19e97a903270 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1153,13 +1153,15 @@ const uint8_t *ofnode_read_u8_array_ptr(ofnode node, const char *propname,
  * @type:	pci address type (FDT_PCI_SPACE_xxx)
  * @propname:	name of property to find
  * @addr:	returns pci address in the form of fdt_pci_addr
+ * @size:	if non-null, returns register-space size
  * Return:
  * 0 if ok, -ENOENT if the property did not exist, -EINVAL if the
  * format of the property was invalid, -ENXIO if the requested
  * address type was not found
  */
 int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
-			 const char *propname, struct fdt_pci_addr *addr);
+			 const char *propname, struct fdt_pci_addr *addr,
+			 fdt_size_t *size);
 
 /**
  * ofnode_read_pci_vendev() - look up PCI vendor and device id
diff --git a/include/dm/read.h b/include/dm/read.h
index c2615f72f405..3c2eea6f0c4b 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -346,9 +346,10 @@ void *dev_read_addr_ptr(const struct udevice *dev);
  *    fdtdec_get_addr() and friends.
  *
  * @dev: Device to read from
+ * @sizep: If non-NULL, returns size of address space found
  * Return: address or FDT_ADDR_T_NONE if not found
  */
-fdt_addr_t dev_read_addr_pci(const struct udevice *dev);
+fdt_addr_t dev_read_addr_pci(const struct udevice *dev, fdt_size_t *sizep);
 
 /**
  * dev_remap_addr() - Get the reg property of a device as a
@@ -996,9 +997,10 @@ static inline void *dev_read_addr_ptr(const struct udevice *dev)
 	return devfdt_get_addr_ptr(dev);
 }
 
-static inline fdt_addr_t dev_read_addr_pci(const struct udevice *dev)
+static inline fdt_addr_t dev_read_addr_pci(const struct udevice *dev,
+					   fdt_size_t *sizep)
 {
-	return devfdt_get_addr_pci(dev);
+	return devfdt_get_addr_pci(dev, sizep);
 }
 
 static inline void *dev_remap_addr(const struct udevice *dev)
diff --git a/include/ns16550.h b/include/ns16550.h
index e7e68663d030..7f481300083a 100644
--- a/include/ns16550.h
+++ b/include/ns16550.h
@@ -58,6 +58,7 @@ enum ns16550_flags {
  * struct ns16550_plat - information about a NS16550 port
  *
  * @base:		Base register address
+ * @size:		Size of register area in bytes
  * @reg_width:		IO accesses size of registers (in bytes, 1 or 4)
  * @reg_shift:		Shift size of registers (0=byte, 1=16bit, 2=32bit...)
  * @reg_offset:		Offset to start of registers (normally 0)
@@ -67,7 +68,8 @@ enum ns16550_flags {
  * @bdf:		PCI slot/function (pci_dev_t)
  */
 struct ns16550_plat {
-	unsigned long base;
+	ulong base;
+	ulong size;
 	int reg_width;
 	int reg_shift;
 	int reg_offset;
diff --git a/include/serial.h b/include/serial.h
index 42bdf3759c00..205889d28be9 100644
--- a/include/serial.h
+++ b/include/serial.h
@@ -137,6 +137,7 @@ enum adr_space_type {
  * @type:	type of the UART chip
  * @addr_space:	address space to access the registers
  * @addr:	physical address of the registers
+ * @size:	size of the register area in bytes
  * @reg_width:	size (in bytes) of the IO accesses to the registers
  * @reg_offset:	offset to apply to the @addr from the start of the registers
  * @reg_shift:	quantity to shift the register offsets by
@@ -147,6 +148,7 @@ struct serial_device_info {
 	enum serial_chip_type type;
 	enum adr_space_type addr_space;
 	ulong addr;
+	ulong size;
 	u8 reg_width;
 	u8 reg_offset;
 	u8 reg_shift;
diff --git a/test/dm/pci.c b/test/dm/pci.c
index 70a736cfdb8a..8c5e7da9e629 100644
--- a/test/dm/pci.c
+++ b/test/dm/pci.c
@@ -301,10 +301,12 @@ static int dm_test_pci_addr_flat(struct unit_test_state *uts)
 {
 	struct udevice *swap1f, *swap1;
 	ulong io_addr, mem_addr;
+	fdt_addr_t size;
 
 	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1f, 0), &swap1f));
 	io_addr = dm_pci_read_bar32(swap1f, 0);
-	ut_asserteq(io_addr, dev_read_addr_pci(swap1f));
+	ut_asserteq(io_addr, dev_read_addr_pci(swap1f, &size));
+	ut_asserteq(0, size);
 
 	/*
 	 * This device has both I/O and MEM spaces but the MEM space appears
@@ -312,7 +314,8 @@ static int dm_test_pci_addr_flat(struct unit_test_state *uts)
 	 */
 	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1, 0), &swap1));
 	mem_addr = dm_pci_read_bar32(swap1, 1);
-	ut_asserteq(mem_addr, dev_read_addr_pci(swap1));
+	ut_asserteq(mem_addr, dev_read_addr_pci(swap1, &size));
+	ut_asserteq(0, size);
 
 	return 0;
 }
@@ -329,12 +332,15 @@ DM_TEST(dm_test_pci_addr_flat, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT |
 static int dm_test_pci_addr_live(struct unit_test_state *uts)
 {
 	struct udevice *swap1f, *swap1;
+	fdt_size_t size;
 
 	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1f, 0), &swap1f));
-	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1f));
+	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1f, &size));
+	ut_asserteq(0, size);
 
 	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x1, 0), &swap1));
-	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1));
+	ut_asserteq_64(FDT_ADDR_T_NONE, dev_read_addr_pci(swap1, &size));
+	ut_asserteq(0, size);
 
 	return 0;
 }
-- 
2.42.0.515.g380fc7ccd1-goog

