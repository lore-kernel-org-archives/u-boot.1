Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BD7C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 17:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A59684994;
	Mon,  6 Jul 2026 19:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB7D384979; Mon,  6 Jul 2026 19:21:53 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE61C846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 19:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 464E868BEB; Mon,  6 Jul 2026 19:21:50 +0200 (CEST)
In-Reply-To: <20260706172028.C148E68BEB@verein.lst.de>
References: <20260706172028.C148E68BEB@verein.lst.de>
Subject: [PATCH v2 2/4] test: Add a unit test in phys_to_bus for dynamically
 created device nodes
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Prashant Kamble <prashant.kamble223@gmail.com>,
 Denis Mukhin <dmukhin@ford.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 u-boot@lists.denx.de
Message-Id: <20260706172150.464E868BEB@verein.lst.de>
Date: Mon,  6 Jul 2026 19:21:50 +0200 (CEST)
From: duwe@lst.de (Torsten Duwe)
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

From: Torsten Duwe <duwe@suse.de>

In order to test whether device_get_dma_constraints() is now able to skip
device nodes without a DT association, temporarily remove those on 2 newly-
created nodes.

Signed-off-by: Torsten Duwe <duwe@suse.de>

---

This test indeed makes a different whether the previous change is
applied or not, but *only* reliably for the non-flat-tree case (!?).
On the flat tree, it always fails after (reverse) applying it.

Either the previous patch is incomplete, or, more likely, the test
assumptions here are not all valid. Suggestions welcome (especially
how to create device nodes from a device tree without a reference to
their origin ;-)

---
 arch/sandbox/dts/test.dts |  9 +++++++++
 test/dm/phys2bus.c        | 25 ++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 0887de4333b..1d92e85c739 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -656,6 +656,15 @@
 		subnode@0 {
 			compatible = "denx,u-boot-fdt-test";
 		};
+		bus@7 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "denx,u-boot-test-bus";
+
+			subnode@8 {
+				  compatible = "denx,u-boot-fdt-test";
+			};
+		};
 	};
 
 	mmio-bus@1 {
diff --git a/test/dm/phys2bus.c b/test/dm/phys2bus.c
index 67f33904943..858ed5410e2 100644
--- a/test/dm/phys2bus.c
+++ b/test/dm/phys2bus.c
@@ -15,7 +15,8 @@
 
 static int dm_test_phys_to_bus(struct unit_test_state *uts)
 {
-	struct udevice *dev;
+	struct udevice *dev, *pdev;
+	ofnode psave, nsave;
 	ofnode node;
 
 	node = ofnode_path("/mmio-bus@0");
@@ -31,6 +32,29 @@ static int dm_test_phys_to_bus(struct unit_test_state *uts)
 	ut_asserteq_addr((void*)0x1003ffffULL, (void*)dev_phys_to_bus(dev, 0x3ffff));
 	ut_asserteq_addr((void*)0x3ffffULL, (void*)(ulong)dev_bus_to_phys(dev, 0x1003ffff));
 
+#if CONFIG_IS_ENABLED(OF_REAL)
+	/* dma-ranges are on the grandparent bus node,
+	 *  OF nodes neither here nor at parent
+	 */
+	node = ofnode_path("/mmio-bus@0/bus@7");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(uclass_get_device_by_ofnode(UCLASS_TEST_BUS, node, &pdev));
+
+	/* pretend the devices were discovered dynamically and have no OF node */
+	psave = pdev->node_;
+	pdev->node_.np = NULL;
+	node = ofnode_path("/mmio-bus@0/bus@7/subnode@8");
+	ut_assert(ofnode_valid(node));
+	nsave = dev->node_;
+	dev->node_.np = NULL;
+	ut_assertok(uclass_get_device_by_ofnode(UCLASS_TEST_FDT, node, &dev));
+
+	ut_asserteq_addr((void *)0x1003ffffULL, (void *)dev_phys_to_bus(dev, 0x3ffff));
+	ut_asserteq_addr((void *)0x3ffffULL, (void *)(ulong)dev_bus_to_phys(dev, 0x1003ffff));
+
+	pdev->node_ = psave;
+	dev->node_ = nsave;
+#endif
 	return 0;
 }
 DM_TEST(dm_test_phys_to_bus, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.54.0

