Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E07C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 12:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9349A8690D;
	Mon, 26 Aug 2024 14:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEF46866EB; Mon, 26 Aug 2024 14:01:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 79C7E88A2E
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 14:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B88DDA7;
 Mon, 26 Aug 2024 05:02:10 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37D013F762;
 Mon, 26 Aug 2024 05:01:39 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 23/27] sandbox: iommu: remove lmb allocation in the driver
Date: Mon, 26 Aug 2024 17:29:36 +0530
Message-Id: <20240826115940.3233167-24-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
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

The sandbox iommu driver uses the LMB module to allocate a particular
range of memory for the device virtual address(DVA). This used to work
earlier since the LMB memory map was caller specific and not
global. But with the change to make the LMB allocations global and
persistent, adding this memory range has other side effects. On the
other hand, the sandbox iommu test expects to see this particular
value of the DVA. Use the DVA address directly, instead of mapping it
in the LMB memory map, and then have it allocated.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V3: None

 arch/sandbox/include/asm/test.h |  4 ++++
 drivers/iommu/sandbox_iommu.c   | 25 ++++++-------------------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index 17159f8d67..0e8d19ce23 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -49,6 +49,10 @@ struct unit_test_state;
 #define PCI_EA_BAR2_MAGIC		0x72727272
 #define PCI_EA_BAR4_MAGIC		0x74747474
 
+/* Used by the sandbox iommu driver */
+#define SANDBOX_IOMMU_DVA_ADDR		0x89abc000
+#define SANDBOX_IOMMU_PAGE_SIZE		SZ_4K
+
 enum {
 	SANDBOX_IRQN_PEND = 1,	/* Interrupt number for 'pending' test */
 };
diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
index 5b4a6a8982..c5eefec218 100644
--- a/drivers/iommu/sandbox_iommu.c
+++ b/drivers/iommu/sandbox_iommu.c
@@ -5,23 +5,20 @@
 
 #include <dm.h>
 #include <iommu.h>
-#include <lmb.h>
 #include <asm/io.h>
+#include <asm/test.h>
 #include <linux/sizes.h>
 
-#define IOMMU_PAGE_SIZE		SZ_4K
-
 static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
 				    size_t size)
 {
 	phys_addr_t paddr, dva;
 	phys_size_t psize, off;
 
-	paddr = ALIGN_DOWN(virt_to_phys(addr), IOMMU_PAGE_SIZE);
+	paddr = ALIGN_DOWN(virt_to_phys(addr), SANDBOX_IOMMU_PAGE_SIZE);
 	off = virt_to_phys(addr) - paddr;
-	psize = ALIGN(size + off, IOMMU_PAGE_SIZE);
-
-	dva = lmb_alloc(psize, IOMMU_PAGE_SIZE);
+	psize = ALIGN(size + off, SANDBOX_IOMMU_PAGE_SIZE);
+	dva = (phys_addr_t)SANDBOX_IOMMU_DVA_ADDR;
 
 	return dva + off;
 }
@@ -32,11 +29,9 @@ static void sandbox_iommu_unmap(struct udevice *dev, dma_addr_t addr,
 	phys_addr_t dva;
 	phys_size_t psize;
 
-	dva = ALIGN_DOWN(addr, IOMMU_PAGE_SIZE);
+	dva = ALIGN_DOWN(addr, SANDBOX_IOMMU_PAGE_SIZE);
 	psize = size + (addr - dva);
-	psize = ALIGN(psize, IOMMU_PAGE_SIZE);
-
-	lmb_free(dva, psize);
+	psize = ALIGN(psize, SANDBOX_IOMMU_PAGE_SIZE);
 }
 
 static struct iommu_ops sandbox_iommu_ops = {
@@ -44,13 +39,6 @@ static struct iommu_ops sandbox_iommu_ops = {
 	.unmap = sandbox_iommu_unmap,
 };
 
-static int sandbox_iommu_probe(struct udevice *dev)
-{
-	lmb_add(0x89abc000, SZ_16K);
-
-	return 0;
-}
-
 static const struct udevice_id sandbox_iommu_ids[] = {
 	{ .compatible = "sandbox,iommu" },
 	{ /* sentinel */ }
@@ -61,5 +49,4 @@ U_BOOT_DRIVER(sandbox_iommu) = {
 	.id = UCLASS_IOMMU,
 	.of_match = sandbox_iommu_ids,
 	.ops = &sandbox_iommu_ops,
-	.probe = sandbox_iommu_probe,
 };
-- 
2.34.1

