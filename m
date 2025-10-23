Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0720ECCD1BF
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 11:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE77835B0;
	Thu, 23 Oct 2025 13:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gt1PoPhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE678334F; Thu, 23 Oct 2025 13:46:15 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57F9782E34
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 13:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59NBk94B1668614;
 Thu, 23 Oct 2025 06:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761219969;
 bh=G4yIr6cU7DNdPG1vT78//wmi+UPXI1O7xb/2Od/iJmU=;
 h=From:To:CC:Subject:Date;
 b=gt1PoPhq2pAnUj0ux6EnCblAf4VMyuXsP7h5sB+0fwLBI+csswmN7033r0kArZxKS
 J5X1GOBN0YaIpUDloEMWXUveEX7DIuTxokpEBeCMJOqzux4Z6ELb1cdqeux0KVDufD
 t/aOw+yMh+/h5pXFDMf7Pd4fU5DWD9qMnTSvamVs=
Received: from DFLE207.ent.ti.com (dfle207.ent.ti.com [10.64.6.65])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59NBk9g13101147
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Oct 2025 06:46:09 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 06:46:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 06:46:09 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59NBk5ho2786743;
 Thu, 23 Oct 2025 06:46:05 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <a-nandan@ti.com>, <trini@konsulko.com>, <rfried.dev@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <s-vadapalli@ti.com>, <semen.protsenko@linaro.org>,
 <jm@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 0/4] Add PCIe Endpoint controller support for TI J784S4 SoC
Date: Thu, 23 Oct 2025 17:16:00 +0530
Message-ID: <20251023114604.3655625-1-h-salunke@ti.com>
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

This series enables PCIe Endpoint mode on TI's J784S4 SoC. The J784S4
SoC features two Cadence PCIe controller instances (PCIe0 and PCIe1)
that can operate in endpoint mode. This series adds support for
configuring these controllers with up to 4 lanes.

Key changes include:
- Adding a stabilization delay after power domain reset to prevent
  timing-related initialization issues
- SERDES mux configuration support for proper lane routing, which is
  essential for SoCs where SERDES lanes are shared between multiple
  controllers (PCIe, USB, etc.) with different configurations across
  boot phases
- J784S4 SoC endpoint configuration with 4-lane support
- Disabling unconfigured endpoint functions to prevent enumeration
  issues on the Root Complex side

This series has been tested on J784S4 EVM with PCIe endpoint boot
configuration. Following are the corresponding test logs.

https://gist.github.com/hrushikesh221/331d65f45f43fd138f57e6adb61c4332

This series is based on commit
4e4a9de31de (origin/next) Merge branch 'next' of git://source.denx.de/u-boot-usb into next

Hrushikesh Salunke (4):
  pci_endpoint: pci_cdns_ti_ep: Add delay after power domain reset
  pci_endpoint: pci_cdns_ti_ep: Add SERDES mux configuration support
  pci_endpoint: pci_cdns_ti_ep: Enable PCIe Endpoint mode in J784S4 SoC
  configs: j784s4_evm_a72_defconfig: Enable configs for PCI Endpoint
    mode

 configs/j784s4_evm_a72_defconfig       |  2 ++
 drivers/pci_endpoint/pcie_cdns_ti_ep.c | 33 ++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.34.1

