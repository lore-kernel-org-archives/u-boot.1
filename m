Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D848C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 08:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E302682C67;
	Thu, 12 Jun 2025 10:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IVb7S12z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C18B280050; Thu, 12 Jun 2025 10:50:44 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C794580050
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 10:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C8ocsl2857053;
 Thu, 12 Jun 2025 03:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749718238;
 bh=7dxAg9u8o1PJKwfsnYBFKk9ZmskCfRWPaI30oxbhoeI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=IVb7S12zDBaUBopMVY7aE1EJMTKkw0ZmbjJS7pBN4XFCk6SYttmw50EKEuQ12OTWE
 r9NIYvNoK7/tT1VZoFwV/AMVhJutNdpUs3fmMKZIOEztHkZM9+64kHT43Xr9CMAuNP
 jZJh/K7VCRLNMsvAohW6HwNn6SkMr97uLdZFmYBM=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C8ocs11804492
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 12 Jun 2025 03:50:38 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 03:50:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 03:50:37 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C8oO4e1732137;
 Thu, 12 Jun 2025 03:50:33 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <vigneshr@ti.com>, <trini@konsulko.com>, <rfried.dev@gmail.com>,
 <jm@ti.com>, <s-k6@ti.com>, <rogerq@kernel.org>, <afd@ti.com>,
 <sjg@chromium.org>, <danishanwar@ti.com>, <anshuld@ti.com>,
 <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <s-vadapalli@ti.com>,
 <srk@ti.com>
Subject: [PATCH 2/2] configs: am64x_evm_a53_defconfig: Enable configs for PCI
 Endpoint mode
Date: Thu, 12 Jun 2025 14:20:23 +0530
Message-ID: <20250612085023.3457117-3-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612085023.3457117-1-h-salunke@ti.com>
References: <20250612085023.3457117-1-h-salunke@ti.com>
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

TI's AM64x SoC has a single instance of PCIe Controller namely PCIe0
which is a Cadence PCIe Controller. To support PCI Endpoint
functionality with the PCIe0 instance of PCIe, enable the corresponding
configs.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/am64x_evm_a53_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index 8f7d098f770..5c3b46d710f 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -144,6 +144,8 @@ CONFIG_TI_ICSSG_PRUETH=y
 CONFIG_NVME_PCI=y
 CONFIG_PCI_CONFIG_HOST_BRIDGE=y
 CONFIG_PCIE_CDNS_TI=y
+CONFIG_PCI_ENDPOINT=y
+CONFIG_PCIE_CDNS_TI_EP=y
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_PHY_CADENCE_TORRENT=y
-- 
2.34.1

