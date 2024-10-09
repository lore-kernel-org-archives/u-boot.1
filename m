Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07829CEDDA4
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F3488DC1;
	Wed,  9 Oct 2024 16:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nEJkcGkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ACBC88DB6; Wed,  9 Oct 2024 16:57:14 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A00688D13
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 499Ev8jk069665;
 Wed, 9 Oct 2024 09:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728485828;
 bh=z/JDRiX+jSyCjaEJ2UasVvj6Lbve1/B2dAaGOhf5JKU=;
 h=From:To:CC:Subject:Date;
 b=nEJkcGkHEnf157h2YdJXz/i57UnEmKgteqTKoGa/eY8dlpbPrpVtY6NV+X6rn1Eqt
 MGIlx3Hj5NRySSBQGQPW5qfA5xNgJfhEI41DOqCZB3XVe4kqB03GdBh8w1k1PPOhLb
 QjzgkTJrpT4FD0HnALRBvvNzFVorCmrCI5ZAUwl8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 499Ev8RL052945;
 Wed, 9 Oct 2024 09:57:08 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Oct 2024 09:57:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Oct 2024 09:57:08 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.197])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 499Ev5cc008396;
 Wed, 9 Oct 2024 09:57:05 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2 0/4] Cleanup dma device in spl and move dma channel[0]
Date: Wed, 9 Oct 2024 20:26:59 +0530
Message-ID: <20241009145703.1970034-1-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
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


The channel allocation and deallocation for dma copy was happening on every
dma transfer. This is a overhead for transactions like NAND, which does
page reads recursively for complete data.

So, moving the dma allocation to probe and implement corresponding
remove function and cleanup dma device while exiting from spl.

Enable SPL_DM_DEVICE_REMOVE, for device removal capability in SPL.

v2 <==> v1
==========
1> Improve subject of commit.
2> Add warning on dma device not found.
3> Do channel allocation only for udma and bcdma. Passthrough for all other types.

Prasanth Babu Mantena (2):
  mach-k3: common.c: Remove dma device in spl exit
  configs: k3: Enable device removal in SPL

Santhosh Kumar K (2):
  dma: ti: k3-udma: Move udma_probe() below all APIs
  dma: ti: k3-udma: Move DMA channel[0] allocation to probe and add
    udma_remove()

 arch/arm/mach-k3/common.c        |  25 ++-
 configs/am62ax_evm_a53_defconfig |   1 +
 configs/am62ax_evm_r5_defconfig  |   1 +
 configs/am62x_evm_a53_defconfig  |   1 +
 configs/am62x_evm_r5_defconfig   |   1 +
 configs/j7200_evm_a72_defconfig  |   1 +
 configs/j7200_evm_r5_defconfig   |   1 +
 configs/j721e_evm_a72_defconfig  |   1 +
 configs/j721e_evm_r5_defconfig   |   1 +
 configs/j721s2_evm_a72_defconfig |   1 +
 configs/j721s2_evm_r5_defconfig  |   1 +
 configs/j784s4_evm_a72_defconfig |   1 +
 configs/j784s4_evm_r5_defconfig  |   1 +
 drivers/dma/ti/k3-udma.c         | 333 ++++++++++++++++---------------
 14 files changed, 209 insertions(+), 161 deletions(-)

-- 
2.34.1

