Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE03CF45D4
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 01:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F3B183700;
	Tue, 13 Jan 2026 02:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="KsqpXtHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F5348388D; Tue, 13 Jan 2026 02:21:25 +0100 (CET)
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD79E8382A
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:21:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1768267282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3IyEJfSRnQtccxKUWafkbkujLyB3+ENvMoTiolJ1ZaU=;
 b=KsqpXtHexedNra+CsMoofe1jv5AdF/UCwBeKCmcGYxHG75zmhNStudSq4rxIDZVQdgKigc
 XJR1a5D4v/vRj7UQH98ztpQ1AmsAB1ZGEKD1GiBO999vpj/d8wsx7Jgp5xkPkc+CkpvwYJ
 TZMo/g4c1eW52Vbt+asQQkhpMCsdMt0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3 2/3] PCI: sandbox: Add PCI bridge emulation
Date: Mon, 12 Jan 2026 20:20:36 -0500
Message-Id: <20260113012037.2566942-3-sean.anderson@linux.dev>
In-Reply-To: <20260113012037.2566942-1-sean.anderson@linux.dev>
References: <20260113012037.2566942-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Add a PCI bridge emulation device. Although real bridges need to be
configured in order to forward requests, this happens automatically for
now (see arch/sandbox/lib/pci_io.c). So just record the window registers
and check them in a test to make sure pci_auto is sane.

As each bridge consume at least 4k I/O registers, increase the root
port's I/O space so we have some left for other devices.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v3:
- New

 arch/sandbox/dts/test.dts        |  35 +++++-
 arch/sandbox/include/asm/test.h  |   1 +
 drivers/pci/Makefile             |   2 +-
 drivers/pci/pci_sandbox_bridge.c | 192 +++++++++++++++++++++++++++++++
 test/dm/pci.c                    | 142 +++++++++++++++++++++++
 5 files changed, 370 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/pci_sandbox_bridge.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index e945a47fb01..962d364f9b2 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1279,7 +1279,7 @@
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges = <0x02000000 0 0x10000000 0x10000000 0 0x2000000
-				0x01000000 0 0x20000000 0x20000000 0 0x2000>;
+			  0x01000000 0 0x20000000 0x20000000 0 0x20000>;
 		iommu-map = <0x0010 &iommu 0 1>;
 		iommu-map-mask = <0xfffffff8>;
 		sandbox,emul = <&pci_emul0>;
@@ -1301,6 +1301,15 @@
 			};
 		};
 
+		pci@4,0 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			compatible = "pciclass,0604";
+			reg = <0x00002000 0 0 0 0>;
+			ranges;
+		};
+
 		pci@1e,0 {
 			compatible = "sandbox,pmc";
 			reg = <0xf000 0 0 0 0>;
@@ -1340,6 +1349,30 @@
 			reg = <0x10>;
 		};
 
+		emul@3,0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "sandbox,pci-bridge";
+			reg = <0x18>;
+
+			emul@0,0 {
+				compatible = "sandbox,swap-case";
+				reg = <0x00>;
+			};
+		};
+
+		emul@4,0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "sandbox,pci-bridge";
+			reg = <0x20>;
+
+			emul@0,0 {
+				compatible = "sandbox,swap-case";
+				reg = <0x00>;
+			};
+		};
+
 		emul@1e,0 {
 			compatible = "sandbox,pmc-emul";
 			reg = <0xf0>;
diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index 0e8d19ce232..86c7c833b6e 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -19,6 +19,7 @@ struct unit_test_state;
 #define SANDBOX_PCI_SWAP_CASE_EMUL_ID	0x5678
 #define SANDBOX_PCI_PMC_EMUL_ID		0x5677
 #define SANDBOX_PCI_P2SB_EMUL_ID	0x5676
+#define SANDBOX_PCI_BRIDGE_EMUL_ID	0x5662
 #define SANDBOX_PCI_CLASS_CODE		(PCI_CLASS_COMMUNICATION_SERIAL >> 8)
 #define SANDBOX_PCI_CLASS_SUB_CODE	(PCI_CLASS_COMMUNICATION_SERIAL & 0xff)
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 98f3c226f63..70a0dd3c1e3 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_VIDEO) += pci_rom.o
 obj-$(CONFIG_PCI) += pci-uclass.o pci_auto.o
 obj-$(CONFIG_DM_PCI_COMPAT) += pci_compat.o
 obj-$(CONFIG_PCI_SANDBOX) += pci_sandbox.o
-obj-$(CONFIG_SANDBOX) += pci-emul-uclass.o
+obj-$(CONFIG_SANDBOX) += pci-emul-uclass.o pci_sandbox_bridge.o
 obj-$(CONFIG_X86) += pci_x86.o pci_rom.o
 obj-$(CONFIG_PCI) += pci_auto_common.o pci_common.o
 
diff --git a/drivers/pci/pci_sandbox_bridge.c b/drivers/pci/pci_sandbox_bridge.c
new file mode 100644
index 00000000000..81a4e993b47
--- /dev/null
+++ b/drivers/pci/pci_sandbox_bridge.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCI emulation device which swaps the case of text
+ *
+ * Copyright (c) 2014 Google, Inc
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <pci.h>
+#include <asm/test.h>
+#include <linux/ctype.h>
+
+/**
+ * struct bridge_priv - Sandbox PCI bridge emulation private data
+ */
+struct bridge_priv {
+	u64 pref_base, pref_limit;
+	u32 io_base, io_limit;
+	u16 command, control;
+	u16 mem_base, mem_limit;
+	u8 primary, secondary, sub;
+};
+
+#define mask(s) GENMASK_ULL((1 << ((s) + 3)) - 1, 0)
+#define extract(v, o, s) (((v) >> ((o) * 8)) & mask(s))
+#define deposit(v, o, s, f) ({ \
+	uint _o = (o); \
+	typeof(v) _v = v & ~((typeof(v))mask(s) << (_o * 8)); \
+	_v | ((typeof(v))(f) << (_o * 8)); \
+})
+
+static ulong _sandbox_bridge_read_config(const struct udevice *dev, uint off,
+					 enum pci_size_t size)
+{
+	struct bridge_priv *priv = dev_get_priv(dev);
+
+	switch (off) {
+	case PCI_VENDOR_ID ... PCI_VENDOR_ID + 1:
+		return extract(SANDBOX_PCI_VENDOR_ID, off & 1, size);
+	case PCI_DEVICE_ID ... PCI_DEVICE_ID + 1:
+		return extract(SANDBOX_PCI_BRIDGE_EMUL_ID, off & 1, size);
+	case PCI_COMMAND ... PCI_COMMAND + 1:
+		return extract(priv->command, off & 1, size);
+	case PCI_REVISION_ID ... PCI_CLASS_CODE:
+		return extract(PCI_CLASS_BRIDGE_PCI_NORMAL << 8, off & 3, size);
+	case PCI_HEADER_TYPE:
+		return PCI_HEADER_TYPE_BRIDGE;
+	case PCI_PRIMARY_BUS:
+		return priv->primary;
+	case PCI_SECONDARY_BUS:
+		return priv->secondary;
+	case PCI_SUBORDINATE_BUS:
+		return priv->sub;
+	case PCI_IO_BASE:
+		return priv->io_base;
+	case PCI_IO_LIMIT:
+		return priv->io_limit;
+	case PCI_MEMORY_BASE ... PCI_MEMORY_BASE + 1:
+		return extract(priv->mem_base, off & 1, size);
+	case PCI_MEMORY_LIMIT ... PCI_MEMORY_LIMIT + 1:
+		return extract(priv->mem_limit, off & 1, size);
+	case PCI_PREF_MEMORY_BASE ... PCI_PREF_MEMORY_BASE + 1:
+		return extract(priv->pref_base, off & 1, size);
+	case PCI_PREF_MEMORY_LIMIT ... PCI_PREF_MEMORY_LIMIT + 1:
+		return extract(priv->pref_limit, off & 1, size);
+	case PCI_PREF_BASE_UPPER32 ... PCI_PREF_BASE_UPPER32 + 3:
+		return extract(priv->pref_base >> 16, off & 3, size);
+	case PCI_PREF_LIMIT_UPPER32 ... PCI_PREF_LIMIT_UPPER32 + 3:
+		return extract(priv->pref_limit >> 16, off & 3, size);
+	case PCI_IO_BASE_UPPER16 ... PCI_IO_BASE_UPPER16 + 1:
+		return extract(priv->io_base >> 8, off & 1, size);
+	case PCI_IO_LIMIT_UPPER16 ... PCI_IO_LIMIT_UPPER16 + 1:
+		return extract(priv->io_limit >> 8, off & 1, size);
+	case PCI_BRIDGE_CONTROL ... PCI_BRIDGE_CONTROL + 1:
+		return extract(priv->control, off & 1, size);
+	}
+
+	return 0;
+}
+
+static int sandbox_bridge_read_config(const struct udevice *dev, uint off,
+				      ulong *valp, enum pci_size_t size)
+{
+	*valp = _sandbox_bridge_read_config(dev, off, size);
+	return 0;
+}
+
+static void sandbox_bridge_fix_regs(struct bridge_priv *priv)
+{
+	priv->io_base &= PCI_IO_RANGE_MASK;
+	priv->io_base |= PCI_IO_RANGE_TYPE_32;
+	priv->io_limit &= PCI_IO_RANGE_MASK;
+	priv->io_limit |= PCI_IO_RANGE_TYPE_32;
+	priv->mem_base &= PCI_MEMORY_RANGE_MASK;
+	priv->mem_limit &= PCI_MEMORY_RANGE_MASK;
+	priv->pref_base &= PCI_PREF_RANGE_MASK;
+	priv->pref_base |= PCI_PREF_RANGE_TYPE_64;
+	priv->pref_limit &= PCI_PREF_RANGE_MASK;
+	priv->pref_limit |= PCI_PREF_RANGE_TYPE_64;
+}
+
+static int sandbox_bridge_write_config(struct udevice *dev, uint off, ulong val,
+				       enum pci_size_t size)
+{
+	struct bridge_priv *priv = dev_get_priv(dev);
+
+	switch (off) {
+	case PCI_COMMAND ... PCI_COMMAND + 1:
+		priv->command = deposit(priv->command, off & 1, size, val);
+		break;
+	case PCI_PRIMARY_BUS:
+		priv->primary = val;
+		break;
+	case PCI_SECONDARY_BUS:
+		priv->secondary = val;
+		break;
+	case PCI_SUBORDINATE_BUS:
+		priv->sub = val;
+		break;
+	case PCI_IO_BASE:
+		priv->io_base = deposit(priv->io_base, 0, 0, val);
+		break;
+	case PCI_IO_LIMIT:
+		priv->io_limit = deposit(priv->io_limit, 0, 0, val);
+		break;
+	case PCI_MEMORY_BASE ... PCI_MEMORY_BASE + 1:
+		priv->mem_base = deposit(priv->mem_base, off & 1, size, val);
+		break;
+	case PCI_MEMORY_LIMIT ... PCI_MEMORY_LIMIT + 1:
+		priv->mem_limit = deposit(priv->mem_limit, off & 1, size, val);
+		break;
+	case PCI_PREF_MEMORY_BASE ... PCI_PREF_MEMORY_BASE + 1:
+		priv->pref_base = deposit(priv->pref_base, off & 1, size, val);
+		break;
+	case PCI_PREF_MEMORY_LIMIT ... PCI_PREF_MEMORY_LIMIT + 1:
+		priv->pref_limit = deposit(priv->pref_limit, off & 1, size,
+					   val);
+		break;
+	case PCI_PREF_BASE_UPPER32 ... PCI_PREF_BASE_UPPER32 + 3:
+		priv->pref_base = deposit(priv->pref_base, (off & 3) + 2, size,
+					  val);
+		break;
+	case PCI_PREF_LIMIT_UPPER32 ... PCI_PREF_LIMIT_UPPER32 + 3:
+		priv->pref_limit = deposit(priv->pref_limit, (off & 3) + 2,
+					   size, val);
+		break;
+	case PCI_IO_BASE_UPPER16 ... PCI_IO_BASE_UPPER16 + 1:
+		priv->io_base = deposit(priv->io_base, (off & 1) + 1, size,
+					val);
+		break;
+	case PCI_IO_LIMIT_UPPER16 ... PCI_IO_LIMIT_UPPER16 + 1:
+		priv->io_limit = deposit(priv->io_limit, (off & 1) + 1, size,
+					 val);
+		break;
+	case PCI_BRIDGE_CONTROL ... PCI_BRIDGE_CONTROL + 1:
+		priv->control = deposit(priv->control, off & 1, size, val);
+		break;
+	}
+
+	sandbox_bridge_fix_regs(priv);
+	return 0;
+}
+
+static struct dm_pci_emul_ops sandbox_bridge_emul_ops = {
+	.read_config = sandbox_bridge_read_config,
+	.write_config = sandbox_bridge_write_config,
+};
+
+static int sandbox_bridge_probe(struct udevice *dev)
+{
+	struct bridge_priv *priv = dev_get_priv(dev);
+
+	sandbox_bridge_fix_regs(priv);
+	return 0;
+}
+
+static const struct udevice_id sandbox_bridge_ids[] = {
+	{ .compatible = "sandbox,pci-bridge" },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_bridge_emul) = {
+	.name		= "sandbox_bridge_emul",
+	.id		= UCLASS_PCI_EMUL,
+	.of_match	= sandbox_bridge_ids,
+	.probe		= sandbox_bridge_probe,
+	.ops		= &sandbox_bridge_emul_ops,
+	.priv_auto	= sizeof(struct bridge_priv),
+};
diff --git a/test/dm/pci.c b/test/dm/pci.c
index 6eb19f6fea3..b6fee7b3bb3 100644
--- a/test/dm/pci.c
+++ b/test/dm/pci.c
@@ -4,6 +4,7 @@
  */
 
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <asm/io.h>
 #include <asm/test.h>
 #include <dm/test.h>
@@ -486,3 +487,144 @@ static int dm_test_pci_phys_to_bus(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_pci_phys_to_bus, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+#define PCI_BAR(n) (PCI_BASE_ADDRESS_0 + (n) * 4)
+static int read_bar(struct unit_test_state *uts, struct udevice *dev, int bar,
+		    u32 *base, u32 *mask)
+{
+	int addr = PCI_BASE_ADDRESS_0 + bar * 4;
+
+	ut_assertok(dm_pci_read_config32(dev, addr, base));
+	ut_assertok(dm_pci_write_config32(dev, addr, 0xffffffff));
+	ut_assertok(dm_pci_read_config32(dev, addr, mask));
+	ut_assertok(dm_pci_write_config32(dev, addr, *base));
+	return 0;
+}
+
+/*
+ * Test that all BARs on devices under each bridge lie within the bridge's
+ * forwarding windows.
+ */
+static int _dm_test_pci_bridge_windows(struct unit_test_state *uts,
+				       struct udevice *bus)
+{
+	struct udevice *dev;
+	u64 pref_lo, pref_hi;
+	u32 val32, io_lo, io_hi, mem_lo, mem_hi;
+	u16 val16;
+	u8 val8;
+
+	ut_assertok(dm_pci_read_config8(bus, PCI_IO_BASE, &val8));
+	ut_assertok(dm_pci_read_config16(bus, PCI_IO_BASE_UPPER16, &val16));
+	io_lo = ((u32)(val8 & PCI_IO_RANGE_MASK) << 8) | ((u32)val16 << 16);
+	ut_assertok(dm_pci_read_config8(bus, PCI_IO_LIMIT, &val8));
+	ut_assertok(dm_pci_read_config16(bus, PCI_IO_LIMIT_UPPER16, &val16));
+	io_hi = ((u32)(val8 & PCI_IO_RANGE_MASK) << 8) | ((u32)val16 << 16) |
+		GENMASK(11, 0);
+
+	ut_assertok(dm_pci_read_config16(bus, PCI_MEMORY_BASE, &val16));
+	mem_lo = (u32)val16 << 16;
+	ut_assertok(dm_pci_read_config16(bus, PCI_MEMORY_LIMIT, &val16));
+	mem_hi = ((u32)val16 << 16) | GENMASK(19, 0);
+
+	ut_assertok(dm_pci_read_config16(bus, PCI_PREF_MEMORY_BASE, &val16));
+	ut_assertok(dm_pci_read_config32(bus, PCI_PREF_BASE_UPPER32, &val32));
+	pref_lo = ((u64)(val16 & PCI_PREF_RANGE_MASK) << 16) |
+		  ((u64)val32 << 32) | GENMASK(19, 0);
+	ut_assertok(dm_pci_read_config16(bus, PCI_PREF_MEMORY_LIMIT, &val16));
+	ut_assertok(dm_pci_read_config32(bus, PCI_PREF_LIMIT_UPPER32, &val32));
+	pref_hi = ((u64)(val16 & PCI_PREF_RANGE_MASK) << 16) |
+		  ((u64)val32 << 32) | GENMASK(19, 0);
+
+	dev_dbg(bus, "io   %08x %08x\n", io_lo, io_hi);
+	dev_dbg(bus, "mem  %08x %08x\n", mem_lo, mem_hi);
+	dev_dbg(bus, "pref %016llx %016llx\n", pref_lo, pref_hi);
+	device_foreach_child(dev, bus) {
+		unsigned int bar, max_bar;
+
+		ut_assertok(dm_pci_read_config8(dev, PCI_HEADER_TYPE, &val8));
+		switch (val8) {
+		case PCI_HEADER_TYPE_NORMAL:
+			max_bar = 6;
+			break;
+		case PCI_HEADER_TYPE_BRIDGE:
+			max_bar = 2;
+			break;
+		case PCI_HEADER_TYPE_CARDBUS:
+			max_bar = 0;
+			break;
+		default:
+			ut_reportf("Unknown header type %x!\n", val8);
+		}
+
+		for (bar = 0; bar < max_bar; bar++) {
+			u32 base32, mask32;
+
+			if (read_bar(uts, dev, bar, &base32, &mask32))
+				return CMD_RET_FAILURE;
+
+			if (!mask32)
+				continue;
+
+			if (base32 & PCI_BASE_ADDRESS_SPACE_IO) {
+				mask32 &= PCI_BASE_ADDRESS_IO_MASK;
+				dev_dbg(dev, "io   %08x %08x\n", base32,
+					base32 + ~mask32);
+
+				ut_assert(base32 >= io_lo);
+				ut_assert(base32 + ~mask32 <= io_hi);
+			} else {
+				u64 base64 = base32 & PCI_BASE_ADDRESS_MEM_MASK;
+				u64 mask64 = mask32 & PCI_BASE_ADDRESS_MEM_MASK;
+				u64 mem_type = base32 &
+					       PCI_BASE_ADDRESS_MEM_TYPE_MASK;
+				bool pref = base32 &
+					    PCI_BASE_ADDRESS_MEM_PREFETCH;
+
+				if (mem_type == PCI_BASE_ADDRESS_MEM_TYPE_64) {
+					ut_assert(++bar < max_bar);
+					if (read_bar(uts, dev, bar, &base32,
+						     &mask32))
+						return CMD_RET_FAILURE;
+
+					base64 |= (u64)base32 << 32;
+					mask64 |= (u64)mask32 << 32;
+					mask64 = ~mask64;
+				} else {
+					ut_asserteq(PCI_BASE_ADDRESS_MEM_TYPE_32,
+						    mem_type);
+					mask64 |= GENMASK_ULL(63, 32);
+				}
+
+				if (pref) {
+					dev_dbg(dev, "pref %016llx %016llx\n",
+						base64, base64 + ~mask64);
+
+					ut_assert(base64 >= pref_lo);
+					ut_assert(base64 + ~mask64 <= pref_hi);
+				} else {
+					dev_dbg(dev, "mem  %08llx %08llx\n",
+						base64, base64 + ~mask64);
+
+					ut_assert(base64 >= mem_lo);
+					ut_assert(base64 + ~mask64 <= mem_hi);
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int dm_test_pci_bridge_windows(struct unit_test_state *uts)
+{
+	struct udevice *bus;
+
+	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x03, 0), &bus));
+	if (_dm_test_pci_bridge_windows(uts, bus))
+		return CMD_RET_FAILURE;
+
+	ut_assertok(dm_pci_bus_find_bdf(PCI_BDF(0, 0x04, 0), &bus));
+	return _dm_test_pci_bridge_windows(uts, bus);
+}
+DM_TEST(dm_test_pci_bridge_windows, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.35.1.1320.gc452695387.dirty

