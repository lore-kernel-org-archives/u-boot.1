Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8729C3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B9488927;
	Thu,  4 Jul 2024 09:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4991D8889D; Thu,  4 Jul 2024 09:37:43 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 624C288933
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2546DA7;
 Thu,  4 Jul 2024 00:38:04 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B76993F762;
 Thu,  4 Jul 2024 00:37:36 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 26/48] sandbox: iommu: remove lmb allocation in the
 driver
Date: Thu,  4 Jul 2024 13:05:22 +0530
Message-Id: <20240704073544.670249-27-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704073544.670249-1-sughosh.ganu@linaro.org>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
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
---
Changes since V1: None

 drivers/iommu/sandbox_iommu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
index 5b4a6a8982..81f10e8433 100644
--- a/drivers/iommu/sandbox_iommu.c
+++ b/drivers/iommu/sandbox_iommu.c
@@ -9,6 +9,7 @@
 #include <asm/io.h>
 #include <linux/sizes.h>
 
+#define DVA_ADDR		0x89abc000
 #define IOMMU_PAGE_SIZE		SZ_4K
 
 static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
@@ -21,7 +22,7 @@ static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
 	off = virt_to_phys(addr) - paddr;
 	psize = ALIGN(size + off, IOMMU_PAGE_SIZE);
 
-	dva = lmb_alloc(psize, IOMMU_PAGE_SIZE);
+	dva = (phys_addr_t)DVA_ADDR;
 
 	return dva + off;
 }
@@ -35,8 +36,6 @@ static void sandbox_iommu_unmap(struct udevice *dev, dma_addr_t addr,
 	dva = ALIGN_DOWN(addr, IOMMU_PAGE_SIZE);
 	psize = size + (addr - dva);
 	psize = ALIGN(psize, IOMMU_PAGE_SIZE);
-
-	lmb_free(dva, psize);
 }
 
 static struct iommu_ops sandbox_iommu_ops = {
@@ -46,8 +45,6 @@ static struct iommu_ops sandbox_iommu_ops = {
 
 static int sandbox_iommu_probe(struct udevice *dev)
 {
-	lmb_add(0x89abc000, SZ_16K);
-
 	return 0;
 }
 
-- 
2.34.1

