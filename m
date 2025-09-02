Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B70CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 09:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F2D832AD;
	Tue,  2 Sep 2025 11:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QNCMAIB0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC5AB83A7A; Tue,  2 Sep 2025 11:42:04 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A85D8329F
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 11:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5829fxPI2500085;
 Tue, 2 Sep 2025 04:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756806119;
 bh=YC4r/dr56By7aGPcb/W0bVTJsKJavrRGan5gx2muPx8=;
 h=From:To:CC:Subject:Date;
 b=QNCMAIB0LAImTV8dG7GPnvF6T3YIo8NUwNNXC+5rCndGKo/cuqTEJyolFGAlri6c/
 OyMmdQvR2YuMzi9Dzw5HJG62oUcT9tYBJU94EDNJtUOWYD9aGqwOVEaqWUzM+bfl9F
 Y/MfAvs4pRYvlcwysdBKVJenAqHxzCV8XSFXXxhA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5829fxAL2647188
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 2 Sep 2025 04:41:59 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 04:41:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 04:41:58 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5829fvv53870190;
 Tue, 2 Sep 2025 04:41:58 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <u-kumar1@ti.com>, <p-mantena@ti.com>
Subject: [PATCH v2 0/2] Fix dma_addr_t for R5 SPL
Date: Tue, 2 Sep 2025 15:10:34 +0530
Message-ID: <20250902094037.2121393-1-anshuld@ti.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi all,

On various TI's K3 platforms boot failure was observed on SPI NOR since the
commit 5609f200d062 ("arm: Kconfig: enable LTO for ARCH_K3"). This issue was
root caused to stack corruption by the 'udma_transfer' function. Where the local
variable 'paddr' of type 'dma_addr_t' was being written to as a 64-bit value
which overwrote the stack frame of the caller (dma_memcpy) as only 32-bits had
been reserved for paddr on the stack, specifically the r4 register in the frame
of dma_memcpy was being overwritten with a 0.

drivers/dma/ti/k3-udma.c:2192:

	int udma_transfer(...)
	{
		...
		dma_addr_t paddr = 0;

		...
		/* paddr was written to as 64-bit value here */
		udma_poll_completion(uc, &paddr);
	}

drivers/dma/dma-uclass.c:234:

	int dma_memcpy(...)
	{
		dma_addr_t destination;
		dma_addr_t source;
		int ret;

		...

		/* This call resolves to udma_transfer */
		ret = ops->transfer(...);

		...

		dma_unmap_single(destination, ...);
		dma_unmap_single(...);
		return ret;
	}

Enabling LTO changed how gcc mapped local variables of dma_memcpy to CPU
registers, where earlier the bug was hidden since the overwritten register
'r4' was allotted to 'ret' but was allotted to 'destination' once LTO was
enabled. And since the overwritten value was 0, the bug remained undetected
as it just meant ret was 0, but having 'destination' set to 0 caused
dma_unmap_single to fail silently leading to boot failures.

The fix entails enabling DMA_ADDR_T_64BIT which changes dma_addr_t from u32 to
u64 for the R5 SPL thus reserving enough space for 'paddr' to prevent the
overflow.

Regards,
Anshul
---
Changes for v2:
 - Add missing typecasts for usb driver
 - Reword commit description
v1: https://lore.kernel.org/u-boot/20250825133233.2475300-1-anshuld@ti.com/
---
Anshul Dalal (2):
  dma: ti: k3-udma: fix dma_addr_t typecasts
  config: arch: k3: enable DMA_ADDR_T_64BIT

 arch/arm/Kconfig         | 1 +
 drivers/dma/ti/k3-udma.c | 6 +++---
 drivers/usb/dwc3/ep0.c   | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.50.1

