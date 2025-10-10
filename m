Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39592CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 16:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F208444B;
	Fri, 10 Oct 2025 18:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96BF884401; Fri, 10 Oct 2025 18:17:34 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 509D784401
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 18:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id EDBF8227AAE; Fri, 10 Oct 2025 18:17:29 +0200 (CEST)
From: Torsten Duwe <duwe@lst.de>
To: Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>
Cc: Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 3/4] Fix #cells lookup in of_get_dma_range
In-Reply-To: <20251010161442.410C4227AAE@verein.lst.de>
References: <20251010161442.410C4227AAE@verein.lst.de>
Message-Id: <20251010161729.EDBF8227AAE@verein.lst.de>
Date: Fri, 10 Oct 2025 18:17:29 +0200 (CEST)
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

of_get_dma_range uses (of_bus *)->count_cells to look up the
#cells for addresses and sizes. It tries to do so for the current
device node and for the parent tree. count_cells defaults to 
of_bus_default_count_cells, which _starts_ looking at the parent
node already, and then upwards. The correct way is to use
of_simple_*_cells for the current node, and count_cells(dev) for
the parent tree.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Signed-off-by: Torsten Duwe <duwe@suse.de>
---

Here is the original, very detailed analysis and explanation
[edited] :

According to the Section 2.3.9 of the Device Tree specification[0]
the format of the value of the dma-ranges property is an arbitrary
number of triplets of (child-bus-address,
parent-bus-address, length).
Where:
* The child-bus-address is a physical address within the child bus’
  address space. The number of cells to represent the address depends on
  the bus and can be determined from the #address-cells of this node
  (the node in which the dma-ranges property appears).
* The parent-bus-address is a physical address within the parent bus’
  address space. The number of cells to represent the parent address
  is bus dependent and can be determined from the #address-cells
  property of the node that defines the parent’s address space.
* The length specifies the size of the range in the child’s address
  space. The number of cells to represent the size can be determined
  from the #size-cells of this node (the node in which the dma-ranges
  property appears)

This description matches comments in the of_addr source code. But the
actual implementation does not match the specification.
'of_match_bus' returns address-cells and size-cells of the parent
device. That's why the following calls were used to receive addr_cells
and size_cells of the current device:
- of_simple_addr_cells
- of_simple_size_cells

This fix was tested on RPI5 board with both device types: directly
connected (e.g Serial) and connected over PCIe (e.g ethernet).

For example when dma_ranges are parsing the following device tree
structure:
/ {
	pcie2: {
		#address-cells = <3>;
		#size-cells = <2>;
		// 64GB system RAM space at PCIe 10_00000000
		dma-ranges =
			   <0x02000000 0x00 0x00000000
			    0x1f 0x00000000
			    0x00 0x00400000>,
			   <0x43000000 0x10 0x00000000
			    0x00 0x00000000
			    0x10 0x00000000>;
		rp1: {
			#address-cells = <2>;
			#size-cells = <2>;
			dma-ranges =
			// inbound RP1 1x_xxxxxxxx -> PCIe 1x_xxxxxxxx
			  <0x10 0x00000000
			  0x43000000 0x10 0x00000000
			  0x10 0x00000000>,

			// inbound RP1 c0_40xxxxxx -> PCIe 00_00xxxxxx
			  <0xc0 0x40000000
			  0x02000000 0x0 0x00000000
			  0x0 0x00400000>,

			// inbound RP1 0x_xxxxxxxx -> PCIe 1x_xxxxxxxx
			  <0x00 0x00000000
			  0x02000000 0x10 0x00000000
			  0x10 0x00000000>;
		};
	};
};

So when we parse ranges on rp1, #address-cells of the rp1 node should
be taken into account.
In the provided example we have the following format:
pcie2:
   #addres-cells = <0x3>;
   #size-cells = <0x2>;
   dma-ranges = < addr_hi addr_mid addr_lo
                  trans_addr_hi trans_addr_lo
		  size_hi size_lo>;

rp1:
   #addres-cells = <0x2>;
   #size-cells = <0x2>;
   dma-ranges = < addr_hi addr_lo
                  trans_addr_hi trans_addr_mid trans_addr_lo
		  size_hi size_lo>;

of_get_dma_range searches for the first dev with dma_ranges
and then executes of_match_bus which follows by count_cells call
for both device and parent.

count_cells returns #address-cells for the parent device to
the caller.
So in the provided example address cells should be 2 for rp1,
but we get 3 when using count_cells.
This breaks address translation and is fixed in the provided patch
by using the of_simple_addr_cells call, which will return correct
address-cells for the node. This matches the requirements of the
device-tree specification.

[0] https://readthedocs.org/projects/devicetree-specification/downloads/pdf/latest/

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---
 drivers/core/of_addr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/core/of_addr.c b/drivers/core/of_addr.c
index 250dd175b55..823a4d70a6b 100644
--- a/drivers/core/of_addr.c
+++ b/drivers/core/of_addr.c
@@ -374,16 +374,16 @@ int of_get_dma_range(const struct device_node *dev, phys_addr_t *cpu,
 	}
 
 	/* Get the address sizes both for the bus and its parent */
-	bus_node = of_match_bus((struct device_node*)dev);
-	bus_node->count_cells(dev, &na, &ns);
+	na = of_simple_addr_cells(dev);
+	ns = of_simple_size_cells(dev);
 	if (!OF_CHECK_COUNTS(na, ns)) {
 		printf("Bad cell count for %s\n", of_node_full_name(dev));
 		ret = -EINVAL;
 		goto out_parent;
 	}
 
-	bus_node = of_match_bus(parent);
-	bus_node->count_cells(parent, &pna, &pns);
+	bus_node = of_match_bus((struct device_node *)dev);
+	bus_node->count_cells(dev, &pna, &pns);
 	if (!OF_CHECK_COUNTS(pna, pns)) {
 		printf("Bad cell count for %s\n", of_node_full_name(parent));
 		ret = -EINVAL;
-- 
2.51.0

