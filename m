Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADA2C71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E4F82CB6;
	Mon, 16 Jun 2025 18:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VMclv1+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3455582CA4; Mon, 16 Jun 2025 18:49:45 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6A9981E18
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55GGnZFL2639790;
 Mon, 16 Jun 2025 11:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750092575;
 bh=VbCKS63Yk9i8gZCz+Udgant4bR+RW5SKotOApnYpMXE=;
 h=From:To:CC:Subject:Date;
 b=VMclv1+HE5ts7CwKWNsZyq9FCQH/rGZK6IzP2UJvARvqqfGhcrWAcNiz7k9Xz5bP3
 adZ6NgTTgrgresmVQMabUh0tEB7m1JM1840e3I5REML/TCih1jBa0M7RzDBVK23SdP
 kL9hGMEl/rPg5RAfpDUsqBBaOYqsxrPhiT9m6SJk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55GGnZDE963996
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 16 Jun 2025 11:49:35 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 16
 Jun 2025 11:49:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 16 Jun 2025 11:49:34 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55GGnUUT416867;
 Mon, 16 Jun 2025 11:49:31 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <vigneshr@ti.com>, <trini@konsulko.com>, <rfried.dev@gmail.com>,
 <jm@ti.com>, <s-k6@ti.com>, <rogerq@kernel.org>, <afd@ti.com>,
 <sjg@chromium.org>, <danishanwar@ti.com>, <anshuld@ti.com>,
 <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <s-vadapalli@ti.com>,
 <srk@ti.com>
Subject: [PATCH v2 0/2] Add TI K3 PCIe Endpoint Controller support for AM64X
Date: Mon, 16 Jun 2025 22:19:27 +0530
Message-ID: <20250616164929.631791-1-h-salunke@ti.com>
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

Hello,

This series adds support for the Endpoint mode on Cadence PCIe controller 
on TI's K3 family of SoCs. The driver is an adaptation of the Linux 
driver (drivers/pci/controller/cadence/pci-j721e.c) and has been 
implemented specifically for Endpoint mode of operation on AM64X. A minor
set of changes will be sufficient to support other K3 SoCs as well.

This patch is tested on AM64X EVM. Following are the log corresponding
to this feature.

https://gist.github.com/hrushikesh221/e8557cbe7667877c50f7d7e9bb96d060

Changes since v1
As per feedback from Tom
1. Removed unused header files
2. Fixed the spacing in Kconfig
3. Updated commit message to reflect linux kernel version from which
endpoint controller driver is adopted.
4. Rebased on current next

v1: https://patchwork.ozlabs.org/project/uboot/cover/20250612085023.3457117-1-h-salunke@ti.com/

Series is based on commit
9de873b4c30 Merge patch series "linux/bitfield.h: sync <linux/bitfield.h> from Linux 6.15 + winbond"

Hrushikesh Salunke (2):
  pci_endpoint: Add TI K3 Cadence PCIe Endpoint Controller driver
  configs: am64x_evm_a53_defconfig: Enable configs for PCI Endpoint mode

 configs/am64x_evm_a53_defconfig        |   2 +
 drivers/pci_endpoint/Kconfig           |   6 +
 drivers/pci_endpoint/Makefile          |   1 +
 drivers/pci_endpoint/pcie_cdns_ti_ep.c | 395 +++++++++++++++++++++++++
 4 files changed, 404 insertions(+)
 create mode 100644 drivers/pci_endpoint/pcie_cdns_ti_ep.c

-- 
2.34.1

