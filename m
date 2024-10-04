Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD68FCFA779
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 13:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF8A5889E9;
	Fri,  4 Oct 2024 15:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FR0ExmDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9367388966; Fri,  4 Oct 2024 15:21:10 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5873F889C5
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 15:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 494DL2N9050744;
 Fri, 4 Oct 2024 08:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728048062;
 bh=to31Hix4HYPe/uVgt3LDqZyuvJRHQRFROz2W80BZNr8=;
 h=From:To:CC:Subject:Date;
 b=FR0ExmDJqDRR8iXQQJ+Mk7lsW255K00Kp/RJkhfp3c0K6nHI+nzQdhvk9ICp26jUm
 aWIxi5HyQnnYfPS8EGkpDoBpaiAzgnEyjWA3gZUraOz0XxD7KZhYTfB01Z+qz+t/EK
 YiSBPXenm915KxGoadzjgVb9/wuUYiBYss0kjofM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 494DL2GM107414
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 4 Oct 2024 08:21:02 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 08:21:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 08:21:02 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.197])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 494DKx3c061378;
 Fri, 4 Oct 2024 08:20:59 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH 0/4] Cleanup dma device in spl and move dma channel[0]
Date: Fri, 4 Oct 2024 18:50:53 +0530
Message-ID: <20241004132057.1449909-1-p-mantena@ti.com>
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

Prasanth Babu Mantena (2):
  mach-k3: common.c: Add dma device remove in spl exit
  configs: k3: Enable device removal in SPL

Santhosh Kumar K (2):
  dma: ti: k3-udma: Move udma_probe() below all APIs
  dma: ti: k3-udma: Move DMA channel[0] allocation to probe and add
    udma_remove()

 arch/arm/mach-k3/common.c        |  23 ++-
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
 drivers/dma/ti/k3-udma.c         | 334 ++++++++++++++++---------------
 14 files changed, 208 insertions(+), 161 deletions(-)

-- 
2.34.1

