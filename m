Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3207CAC581
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 04:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DE3580422;
	Tue,  9 Sep 2025 06:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s8qvFRbg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B34582A9E; Tue,  9 Sep 2025 06:48:26 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A64D3800B6
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 06:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5894mL3d207837;
 Mon, 8 Sep 2025 23:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757393301;
 bh=xdVmX+RbT8KpfWs04siOPkDaGYubLGGxr5LJAKs3e9U=;
 h=From:To:CC:Subject:Date;
 b=s8qvFRbgupE5yhBIRAG7wP+zpNRQztY9woy1ncT14/32ynyt/LI0hj1q77gtAeMlO
 61Ngbz1zKKmB83qJZrBZ/zFhx32fqReDcnx31NdiIJwVb7nDzPU0msm9EbBmYsmBiV
 G0Ig7NL2ZF6nbHTqCy+EWiRnSkRfY6tuTMdunKGg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5894mLIr092116
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 8 Sep 2025 23:48:21 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 23:48:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 23:48:20 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 5894mGmC1722904; Mon, 8 Sep 2025 23:48:17 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <a-dutta@ti.com>, <marek.vasut+renesas@mailbox.org>, 
 <afd@ti.com>, <n-francis@ti.com>, <jm@ti.com>, <p-mantena@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] configs: j7200_evm_a72_defconfig: Enable DP83867 Ethernet PHY
Date: Tue, 9 Sep 2025 10:18:15 +0530
Message-ID: <20250909044816.1670246-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
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

The MCU Ethernet Interface on J7200-EVM uses the DP83867 Ethernet PHY as
described in the section '4.9 MCU Ethernet Interface' of the J7200-EVM
User-Guide [0]. Since the config corresponding to the DP83867 PHY has not
been enabled, the Generic PHY driver is used. As a result, the RGMII delays
do not take effect leading to packet losses.

Fix this by enabling the config for the DP83867 Ethernet PHY.

[0]: https://www.ti.com/lit/ug/spruiw7a/spruiw7a.pdf
Fixes: f8c1e893c82f ("configs: j7200_evm_a72: Add Initial support")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
7a4f3c56521 Prepare v2025.10-rc4
of Mainline U-Boot.

Logs without patch applied:
https://gist.github.com/Siddharth-Vadapalli-at-TI/e016dc8a1bc6a3bad0af395e0c5910a8
Logs with patch applied:
https://gist.github.com/Siddharth-Vadapalli-at-TI/92c841b195f24f01c3542654a6e144c8

Regards,
Siddharth.

 configs/j7200_evm_a72_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index 36274804881..69b77ad5285 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -144,6 +144,7 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_MULTIPLEXER=y
 CONFIG_SPL_MUX_MMIO=y
 CONFIG_MUX_MMIO=y
+CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_TI_DP83869=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
-- 
2.43.0

