Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B48C369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 12:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE86482E40;
	Wed, 16 Apr 2025 14:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f3OILknM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886D082E35; Wed, 16 Apr 2025 14:08:44 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5616982E27
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 14:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53GC8Z3c2649460
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 07:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744805315;
 bh=EIo1pE+18u30kUvzHgMgfC/2HS5z0QwyabnnBmjpZc8=;
 h=From:To:CC:Subject:Date;
 b=f3OILknMhB7GQAoDfwU4Ob/o2Gl6QepngxXGnIHRJYTHYt1sUUavxR7f+nuPAuR6r
 uNDxGPiUuXfPruyNjxGDbqPxhIDOFT4SuRKj3557CWixFwnpT+6carXKQCXgfGw5ne
 E19E0Z1/TJkez1hiM8vWIFffyR3BmRDhbfTGVjhw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53GC8Zfc021856
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 07:08:35 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 07:08:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 07:08:34 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53GC8Uiu127831;
 Wed, 16 Apr 2025 07:08:31 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <vigneshr@ti.com>, <trini@konsulko.com>, <j-humphreys@ti.com>, <jm@ti.com>,
 <sjg@chromium.org>, <s-k6@ti.com>, <n-francis@ti.com>,
 <rogerq@kernel.org>, <danishanwar@ti.com>, <s-vadapalli@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <srk@ti.com>
Subject: [PATCH 0/3] Add PCIe support for TI AM64 SoC
Date: Wed, 16 Apr 2025 17:38:27 +0530
Message-ID: <20250416120830.138965-1-h-salunke@ti.com>
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

TI's AM64 SoC has a single instance of Cadence PCIe Controller. This
series enables support for PCIe in AM64 SoC and to configure it in
Root-Complex mode of operation.

This series is based on following commit in U-Boot next:
f892a7f397a (origin/next) Revert "Merge patch series "pxe: Precursor series for supporting read_all() in extlinux / PXE""

Hrushikesh Salunke (3):
  pci: pcie_cdns_ti: Include linux/sizes.h header
  pci: pcie_cdns_ti: Enable PCIe root-complex mode in AM64 SoC
  configs: am64x_evm_a53_defconfig: Enable configs for PCIe support

 configs/am64x_evm_a53_defconfig |  5 +++++
 drivers/pci/pcie_cdns_ti.c      | 11 +++++++++++
 2 files changed, 16 insertions(+)

-- 
2.34.1

