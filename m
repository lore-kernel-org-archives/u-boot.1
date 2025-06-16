Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F13C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB4C82B18;
	Mon, 16 Jun 2025 18:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V16cLPwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 142C282CCF; Mon, 16 Jun 2025 18:49:52 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2233681E18
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55GGniOY2639797;
 Mon, 16 Jun 2025 11:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750092584;
 bh=7dxAg9u8o1PJKwfsnYBFKk9ZmskCfRWPaI30oxbhoeI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=V16cLPwc+Kuzcy3SzbGpBLv9sTBF9cBr7OePJk8KaHOa8Mmc8fe8ISEw9ojrxdMXe
 tn3rE2dxU9wa+cH3zckEccgFU+rEaM5iPnWs9Y66rqTi40IMzvnY515waZ9UJImTPc
 2QPH/02lOiEEdghUgiL3/Zsu/ctiB6vufy1dA/AY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55GGniEN1120038
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 16 Jun 2025 11:49:44 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 16
 Jun 2025 11:49:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 16 Jun 2025 11:49:43 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55GGnUUV416867;
 Mon, 16 Jun 2025 11:49:40 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <vigneshr@ti.com>, <trini@konsulko.com>, <rfried.dev@gmail.com>,
 <jm@ti.com>, <s-k6@ti.com>, <rogerq@kernel.org>, <afd@ti.com>,
 <sjg@chromium.org>, <danishanwar@ti.com>, <anshuld@ti.com>,
 <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <s-vadapalli@ti.com>,
 <srk@ti.com>
Subject: [PATCH v2 2/2] configs: am64x_evm_a53_defconfig: Enable configs for
 PCI Endpoint mode
Date: Mon, 16 Jun 2025 22:19:29 +0530
Message-ID: <20250616164929.631791-3-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616164929.631791-1-h-salunke@ti.com>
References: <20250616164929.631791-1-h-salunke@ti.com>
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

