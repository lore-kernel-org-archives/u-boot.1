Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00962CF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 05:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4451788DB1;
	Mon, 14 Oct 2024 07:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R7a/+czw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9860E88DB1; Mon, 14 Oct 2024 07:39:41 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2595A88CC1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 07:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E5dVrv057194;
 Mon, 14 Oct 2024 00:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728884371;
 bh=+zFbnejTh2eTJN5k0OfA5ztHcAkD8aUmp1MHcena86I=;
 h=From:To:CC:Subject:Date;
 b=R7a/+czw3McxK+Y3LO84yotbJ2+KoVKzSweulHM0xXJHEKjiuACvOi/Ct0lrqCjxn
 RGAIijDjZk115sLChBKd6VxGnahHuHqHtXmqd6ZrqjjTIx6LavxwqpJ/lNEa0t7lpc
 NuaEIy0ZgIwInV1bUaTGzuEc1JUZoM17n/eOFge8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49E5dVbI015447
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Oct 2024 00:39:31 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 00:39:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 00:39:31 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E5dPnc122316;
 Mon, 14 Oct 2024 00:39:26 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <mkorpershoek@baylibre.com>, <nm@ti.com>,
 <n-francis@ti.com>, <a-limaye@ti.com>, <seanga2@gmail.com>,
 <sjg@chromium.org>, <marex@denx.de>, <john@phrozen.org>,
 <ansuelsmth@gmail.com>, <sumit.garg@linaro.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <Oliver.Gaskell@analog.com>, <robert.marko@sartura.hr>,
 <semen.protsenko@linaro.org>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH v3 0/2] Add TI K3 PCIe Controller support for J7200
Date: Mon, 14 Oct 2024 11:09:22 +0530
Message-ID: <20241014053924.4027491-1-s-vadapalli@ti.com>
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
580fb57736 Merge tag 'u-boot-imx-master-20241013' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
of the master branch of U-Boot.

v2:
https://patchwork.ozlabs.org/project/uboot/cover/20241011130258.3452687-1-s-vadapalli@ti.com/
Changes since v2:
- Addressed Tom's feedback at:
  https://patchwork.ozlabs.org/project/uboot/patch/20241011130258.3452687-2-s-vadapalli@ti.com/#3393548
  by adding MAINTAINERS entry for pcie_cdns_ti.c and by fixing
  indentation for all macros.

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
https://gist.github.com/Siddharth-Vadapalli-at-TI/c64a2defa6b5b59e2b734307ad57b2d8

Regards,
Siddharth.

Siddharth Vadapalli (2):
  pci: Add TI K3 Cadence PCIe Controller
  configs: j7200_evm_a72_defconfig: Enable configs for PCI support

 MAINTAINERS                     |   1 +
 configs/j7200_evm_a72_defconfig |   5 +
 drivers/pci/Kconfig             |   6 +
 drivers/pci/Makefile            |   1 +
 drivers/pci/pcie_cdns_ti.c      | 853 ++++++++++++++++++++++++++++++++
 5 files changed, 866 insertions(+)
 create mode 100644 drivers/pci/pcie_cdns_ti.c

-- 
2.40.1

