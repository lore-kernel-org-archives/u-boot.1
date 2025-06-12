Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF84C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 08:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA7ED82C4D;
	Thu, 12 Jun 2025 10:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="L0uxr8yg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A87E882C30; Thu, 12 Jun 2025 10:56:03 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 917D682C7F
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 10:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C8tkuP1620393;
 Thu, 12 Jun 2025 03:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749718546;
 bh=XD0eYWDGcOlNuI9vnk4g79XvFvRX1+C3FcV/vYBRcHw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=L0uxr8ygTBLCcfOWIk684eaEKsKDPHXmpR4I/uVWAyE+IrLCAKtHIueROHZeEfAGB
 X/qWdeVz93VakC42UfFa50ttuJHzyLk3HFywXVUST0T00qG5bpJHtSBWrxYVD3kbto
 xjhKrUDxeURrMs6eChWnWdcenbuuzQu9gzAxY5dM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C8tkdY3513062
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 12 Jun 2025 03:55:46 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Jun 2025 03:55:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 03:55:45 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C8tZ461737313;
 Thu, 12 Jun 2025 03:55:41 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <jm@ti.com>, <s-k6@ti.com>,
 <quentin.schulz@cherry.de>, <afd@ti.com>, <j-humphreys@ti.com>,
 <anshuld@ti.com>, <n-francis@ti.com>, <danishanwar@ti.com>,
 <rogerq@kernel.org>, <w.egorov@phytec.de>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <s-vadapalli@ti.com>,
 <srk@ti.com>
Subject: [PATCH 1/3] arm: mach-k3: am64x: Add PCIe device as a boot media
Date: Thu, 12 Jun 2025 14:25:32 +0530
Message-ID: <20250612085534.3457522-2-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612085534.3457522-1-h-salunke@ti.com>
References: <20250612085534.3457522-1-h-salunke@ti.com>
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

AM64X SoC supports PCIe boot, when PCIe controller is configured in
endpoint mode. Now U-Boot has support required for PCIe boot add PCIe
as a valid "bootmedia" to allow booting over PCIe on AM64X.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 arch/arm/mach-k3/am64x/boot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-k3/am64x/boot.c b/arch/arm/mach-k3/am64x/boot.c
index ce8ae941be6..dbaf89e3b0d 100644
--- a/arch/arm/mach-k3/am64x/boot.c
+++ b/arch/arm/mach-k3/am64x/boot.c
@@ -80,6 +80,9 @@ static u32 __get_primary_bootmedia(u32 main_devstat)
 			return BOOT_DEVICE_USB;
 		return BOOT_DEVICE_DFU;
 
+	case BOOT_DEVICE_PCIE:
+		return BOOT_DEVICE_PCIE;
+
 	case BOOT_DEVICE_NOBOOT:
 		return BOOT_DEVICE_RAM;
 	}
-- 
2.34.1

