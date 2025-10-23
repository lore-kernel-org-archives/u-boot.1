Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14C6CCD1BE
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 11:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E65083677;
	Thu, 23 Oct 2025 13:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hcYkemIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DAE383655; Thu, 23 Oct 2025 13:46:29 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3537E83623
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 13:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59NBkOHl1668640;
 Thu, 23 Oct 2025 06:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761219985;
 bh=h0T63Qlh14neMcomPGvVWxe2UUZs2i6PhfRzYw1Dpqo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hcYkemIA6kfg2t51RCqF8KY68GlEEOpggh03o2KXt6Nh3aDj9jbCzr1h1v948apyY
 xkSXdS+SAs6lcect1U/di1nRCplF/rgAUHtTKG1xz/l36YRchP8N2wzk+CGXknmTBQ
 N3TzBOefUcVG6MnR7rGPpG/X7SNLhxKP8rmPcFcQ=
Received: from DLEE201.ent.ti.com (dlee201.ent.ti.com [157.170.170.76])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59NBkOZG2369107
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Oct 2025 06:46:24 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 06:46:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 06:46:24 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59NBk5hs2786743;
 Thu, 23 Oct 2025 06:46:21 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <a-nandan@ti.com>, <trini@konsulko.com>, <rfried.dev@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <s-vadapalli@ti.com>, <semen.protsenko@linaro.org>,
 <jm@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 4/4] configs: j784s4_evm_a72_defconfig: Enable configs for PCI
 Endpoint mode
Date: Thu, 23 Oct 2025 17:16:04 +0530
Message-ID: <20251023114604.3655625-5-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023114604.3655625-1-h-salunke@ti.com>
References: <20251023114604.3655625-1-h-salunke@ti.com>
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

TI's J784S4 SoC has two instances of PCIe Controller namely PCIe0 and
PCIe1 which are Cadence PCIe Controllers. Enable corresponding configs
to support PCIe Endpoint mode of operation on these instances.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/j784s4_evm_a72_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index 67aa18a16da..fc7acbae694 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -125,6 +125,8 @@ CONFIG_MUX_MMIO=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_PCI_ENDPOINT=y
+CONFIG_PCIE_CDNS_TI_EP=y
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_PHY_CADENCE_TORRENT=y
-- 
2.34.1

