Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CACC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3853F8128D;
	Mon, 27 Jan 2025 15:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pQJZIcAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF1F812C3; Mon, 27 Jan 2025 15:22:26 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF4A811E1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50REML0I1802106
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 08:22:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737987741;
 bh=AOdrJ5kjT0FImBIg1MWTz6Mn251kgV9fwIMcD0pyIjY=;
 h=From:To:CC:Subject:Date;
 b=pQJZIcAuVEDCrmul6JDlLuainCaax6XyoizbGdFpdq0p2dxS8syNUQSpvhafIZlLh
 GU5hdbYnY0FEAABvxPjvLQWUq+GU2qzVF8B3YKV1tunlFOKNIpZtZVFZmX7fcx36po
 iEl8uK0Lchlfv9ogdjzCWKm0Rw6hWkuK7jJmM5XQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50REML1o065561
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jan 2025 08:22:21 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 08:22:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 08:22:21 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50REMHf6071075;
 Mon, 27 Jan 2025 08:22:18 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 0/8] ram: k3-ddrss: Support partial inline ECC
Date: Mon, 27 Jan 2025 19:52:09 +0530
Message-ID: <20250127142217.1757300-1-n-francis@ti.com>
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

Currently, the inline ECC implementation enables inline ECC across the
entire DDR space. However this is not always required and a more common
ask is to have only a portion of the DDR protected as enabling ECC
impacts read/write performance metrics.

This series aims to modify the logic to firstly support partial inline
ECC in its' most basic form which works for single controllers. Then it
introduces an algorithm to support multi DDR controllers where
interleaving plays a role. Since interleaving is handled by the MSMC, it
only makes sense to have the MSMC decide the inline ECC ranges for each
DDR.

WIP: A commandline test case patch for verifying the correct behaviour
of inline ECC including partial case. Will add the patch in v2, for now
repeated boot tests on the affected platforms as well as internal
memtester runs stand as testing.

Boot logs (J721S2): https://gist.github.com/nehamalcom/e5a76bece133c1ec716e2ed94d60ce74

Neha Malcom Francis (8):
  k3-ddr.c: Remove unwanted header files
  ram: k3-ddrss: Use DDR address instead of system address for
    ecc_regions
  ram: k3-ddrss: Add comment about ecc_reserved_space
  ram: k3-ddrss: Add support for a partial inline ECC region
  ram: k3-ddrss: Add CONFIG_K3_MULTI_DDR
  ram: k3-ddrss: Add support for number of controllers under MSMC
  ram: k3-ddrss: Add support for MSMC calculation of DDR inline ECC
    regions
  ram: k3-ddrss: Add support for partial inline ECC in multi-DDR systems

 arch/arm/mach-k3/k3-ddr.c       |   1 -
 board/ti/common/k3-ddr.c        |   1 -
 drivers/ram/Kconfig             |  10 ++
 drivers/ram/k3-ddrss/k3-ddrss.c | 227 ++++++++++++++++++++++++++++++--
 4 files changed, 226 insertions(+), 13 deletions(-)

-- 
2.34.1

