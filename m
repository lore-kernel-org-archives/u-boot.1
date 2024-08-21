Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2D3C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77F9F88AAA;
	Wed, 21 Aug 2024 16:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f5OG14GQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C2B688BB8; Wed, 21 Aug 2024 16:59:22 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3771C889AE
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LExEGh021026;
 Wed, 21 Aug 2024 09:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724252354;
 bh=Wc2J5SBVcrMuYewOOAA8zL3iI6xCjC1OFEn9+M2Mfaw=;
 h=From:To:CC:Subject:Date;
 b=f5OG14GQ1h0GpeTW0jHSoDuC9apah0kynOgKR3cdMJPGgY+WGHcY+OTVH9s8dslLt
 M2bbAApr2WPaHQzGDtkAP61ea43RPb29wXNyR6N2V6pn3EkiTyTJC8MV/+m8PtBnwf
 bRRIwR5UX3wpUwSChZdvZTGCVGCnZKhF/a+pnUkU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LExES8028126
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 21 Aug 2024 09:59:14 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 09:59:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 09:59:13 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LEx9wW121096;
 Wed, 21 Aug 2024 09:59:09 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <n-francis@ti.com>, <nm@ti.com>, <a-limaye@ti.com>, 
 <marcel.ziswiler@toradex.com>, <seanga2@gmail.com>, <sjg@chromium.org>,
 <marex@denx.de>, <john@phrozen.org>, <ansuelsmth@gmail.com>,
 <sumit.garg@linaro.org>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [RFC PATCH 0/2] Add TI K3 PCIe Controller support for J7200
Date: Wed, 21 Aug 2024 20:29:06 +0530
Message-ID: <20240821145908.3408573-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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
family of SoCs which J7200 belongs to. The driver is an adaptation
of the Linux driver (drivers/pci/controller/cadence/pci-j721e.c)
and has been implemented specifically for Root-Complex mode of operation
on J7200. A minor set of changes will be sufficient to support other
K3 SoCs as well, which has been indicated with "TODO"s added in the
driver code.

Series is based on commit
d2067c3ea5 Merge tag 'u-boot-dfu-next-20240820' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next
of the next branch of U-Boot.

I have posted this series as an RFC for feedback regarding the
implementation. I plan to implement the remaining changes to truly
support all K3 SoCs that are currently supported by the pci-j721e.c
driver in Linux in Root-Complex mode of operation. I have tested this
series with the following changes made to the device-tree for J7200:
https://gist.github.com/Siddharth-Vadapalli-at-TI/1a498722ebb332da6f88abe05a43f2c4

The device-tree changes are required since the "reg-mux" driver is not
currently implemented in U-Boot. I will work on porting the "reg-mux"
driver support from Linux.

The logs corresponding to validating PCI Root-Complex functionality with
an NVMe SSD connected to the PCIe Connector on J7200-EVM, with this series
and the aforementioned device-tree changes applied are:
https://gist.github.com/Siddharth-Vadapalli-at-TI/bbcbfa0b7d593795726c81fb41272823

Regards,
Siddharth.

Siddharth Vadapalli (2):
  pci: Add TI K3 Cadence PCIe Controller
  configs: j7200_evm_a72_defconfig: Enable configs for PCI support

 configs/j7200_evm_a72_defconfig |   4 +
 drivers/pci/Kconfig             |   6 +
 drivers/pci/Makefile            |   1 +
 drivers/pci/pcie_cdns_ti.c      | 645 ++++++++++++++++++++++++++++++++
 4 files changed, 656 insertions(+)
 create mode 100644 drivers/pci/pcie_cdns_ti.c

-- 
2.40.1

