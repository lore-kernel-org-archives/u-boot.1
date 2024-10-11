Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD564D0D786
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 13:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02AC1892D4;
	Fri, 11 Oct 2024 15:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IoFA4E8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 204DD892E3; Fri, 11 Oct 2024 15:03:12 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9680F890F7
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 15:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49BD33mm058095;
 Fri, 11 Oct 2024 08:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728651783;
 bh=d2FDoOdYIQ6yNQnuMffxtat7gdGYIyd2f3tpIMZbpt8=;
 h=From:To:CC:Subject:Date;
 b=IoFA4E8+hH1Hn4/uBMPE4q+D1g9eB3exKDg/uSs1rLTlYCfnDCGY/yXyGcKZeuawo
 AsCU43SI04MTRNh48ul7Aav7FDF+QvSNX+UbvW6Y2ZG6YHA1XzooaHgRUaolsoUqcP
 Jpc6EGuADDR83sVKPxw8A7h5G520S35XptXif/II=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BD33fc078309;
 Fri, 11 Oct 2024 08:03:03 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 08:03:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 08:03:03 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BD2xi9122812;
 Fri, 11 Oct 2024 08:02:59 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <n-francis@ti.com>, <a-limaye@ti.com>, 
 <seanga2@gmail.com>, <sjg@chromium.org>, <marex@denx.de>,
 <john@phrozen.org>, <ansuelsmth@gmail.com>, <sumit.garg@linaro.org>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] Add TI K3 PCIe Controller support for J7200
Date: Fri, 11 Oct 2024 18:32:56 +0530
Message-ID: <20241011130258.3452687-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
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

Hello,

This series adds support for the Cadence PCIe controller on TI's K3
family of SoCs to which the J7200 SoC belongs. The driver is an adaptation
of the Linux driver (drivers/pci/controller/cadence/pci-j721e.c) and has
been implemented specifically for Root-Complex mode of operation on the
J7200 SoC. A minor set of changes will be sufficient to support other K3
SoCs as well with plans to implement it in the near future.

Series is based on commit
a404065479 power: pmic: pca9450: Add missing newline
of the master branch of U-Boot.

v1 of this series was posted as an RFC at:
https://patchwork.ozlabs.org/project/uboot/cover/20240821145908.3408573-1-s-vadapalli@ti.com/
Changes since v1:
- Addressed Tom's feedback at:
  https://patchwork.ozlabs.org/project/uboot/patch/20240821145908.3408573-2-s-vadapalli@ti.com/#3365925
  by removing extra headers and replacing usleep_range() with udelay().
- Added inbound translation configuration thereby enabling support for
  NVMe devices.
- Added SoC specific quirks and the corresponding code to handle them.
- Updated j7200_evm_a72_defconfig to enable NVMe configs since NVMe is
  now supported with this series.

The logs corresponding to validating PCI Root-Complex functionality with
an NVMe SSD connected to the PCIe Connector on J7200-EVM are at:
https://gist.github.com/Siddharth-Vadapalli-at-TI/18a64e0c258f74274d80c5871594f0dc

Regards,
Siddharth.

Siddharth Vadapalli (2):
  pci: Add TI K3 Cadence PCIe Controller
  configs: j7200_evm_a72_defconfig: Enable configs for PCI support

 configs/j7200_evm_a72_defconfig |   5 +
 drivers/pci/Kconfig             |   6 +
 drivers/pci/Makefile            |   1 +
 drivers/pci/pcie_cdns_ti.c      | 851 ++++++++++++++++++++++++++++++++
 4 files changed, 863 insertions(+)
 create mode 100644 drivers/pci/pcie_cdns_ti.c

-- 
2.40.1

