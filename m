Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D307EC71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4140C82CCE;
	Mon, 16 Jun 2025 18:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PV+OwWfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D1282C79; Mon, 16 Jun 2025 18:57:05 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8FA282C84
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55GGun0E3795930;
 Mon, 16 Jun 2025 11:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750093009;
 bh=XD0eYWDGcOlNuI9vnk4g79XvFvRX1+C3FcV/vYBRcHw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PV+OwWfE66FMeafScQB7/TeVRcVJ6afIEggynvixXxLbrQyIiwWaNfwDX2+k2/T96
 74vKGR+JUkK8EJCDHpyIK0EqweU+f/qaA0dRqLion7hcwX5tUDeXydu9qjwLIfUd4I
 JdaWN9ecXTchDKyjqT9mAJlaKBBcCkcDSKX+lY/8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55GGun5T1123983
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 16 Jun 2025 11:56:49 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 16
 Jun 2025 11:56:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 16 Jun 2025 11:56:49 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55GGudKY425933;
 Mon, 16 Jun 2025 11:56:44 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <jm@ti.com>, <s-k6@ti.com>,
 <quentin.schulz@cherry.de>, <afd@ti.com>, <j-humphreys@ti.com>,
 <anshuld@ti.com>, <n-francis@ti.com>, <danishanwar@ti.com>,
 <rogerq@kernel.org>, <w.egorov@phytec.de>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <s-vadapalli@ti.com>,
 <srk@ti.com>
Subject: [PATCH v2 1/3] arm: mach-k3: am64x: Add PCIe device as a boot media
Date: Mon, 16 Jun 2025 22:26:36 +0530
Message-ID: <20250616165638.632089-2-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616165638.632089-1-h-salunke@ti.com>
References: <20250616165638.632089-1-h-salunke@ti.com>
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

