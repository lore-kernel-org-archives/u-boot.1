Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B11C83F26
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 13:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C78A680FA1;
	Wed, 30 Jul 2025 15:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jgqNJ+T8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA29D80548; Wed, 30 Jul 2025 15:37:29 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9103B80548
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 15:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56UDbOLV3257206;
 Wed, 30 Jul 2025 08:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753882644;
 bh=niQB8V+l070OrRSvAsBzZOlrM3V5Zv11vqwdwJqvcO8=;
 h=From:To:CC:Subject:Date;
 b=jgqNJ+T8R+setvMLg+4tsDCPD9QW3HMvYaqWkwoxdEEtSMk4YG7aNRI5iqmtw+oy5
 1moUzKsQREHuo+zs7wRAFjMBribEnaFnSiiG4+EbEfvHy0Yh6/Up4q+BW2ne5fdQdw
 sntbkohjONVaVW7j+M8O9TJ3iXI6+eooytw4fols=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56UDbOvc3232903
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 30 Jul 2025 08:37:24 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 30
 Jul 2025 08:37:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 30 Jul 2025 08:37:24 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56UDbKNF1315795;
 Wed, 30 Jul 2025 08:37:21 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v2 0/9] ram: k3-ddrss: Support partial inline ECC
Date: Wed, 30 Jul 2025 19:07:11 +0530
Message-ID: <20250730133720.3315478-1-n-francis@ti.com>
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

This series also introduces support for multiple partial regions of inline
ECC however due to complexity only support for single DDR is present now.

WIP: A commandline test case patch for verifying the correct behaviour
of inline ECC including partial case. Was targeted for v2 however a little
tricky to make it a general test case especially for multi-DDR cases, so
have not combined it in this series for now.

Testing:
- Memtester runs for J721S2 and J784S4 platforms with and without ECC
enablement runs fine.
- Along with patches that add support for the commandline test (see WIP
note above) J784S4 shows expected behavior for three sets of partial
inline ECC regions (non-overlapping, and after modifying J784S4 to have
single DDR instead of multi-DDR):
https://gist.github.com/nehamalcom/68ee1a199c0ea5b8b2c9ae0c2a2626b2

Changes since v1:
- Removed patch cleaning up a header file since it created warnings (Wadim)
- Minor changes not affecting logic of the patch, but cleaning it up (Udit)
- Rebased on top of latest master
- Added support for multiple partial inline ECC regions (note that this
support is only for single DDR controllers and not multi-DDR yet)

Neha Malcom Francis (9):
  ram: k3-ddrss: Use DDR address instead of system address for
    ecc_regions
  ram: k3-ddrss: s/K3_DDRSS_MAX_ECC_REGIONS/K3_DDRSS_MAX_ECC_REG
  ram: k3-ddrss: Add comment about ecc_reserved_space
  ram: k3-ddrss: Add support for a partial inline ECC region
  ram: k3-ddrss: Add CONFIG_K3_MULTI_DDR
  ram: k3-ddrss: Add support for number of controllers under MSMC
  ram: k3-ddrss: Add support for MSMC calculation of DDR inline ECC
    regions
  ram: k3-ddrss: Add support for partial inline ECC in multi-DDR systems
  ram: k3-ddrss: Support multiple ECC regions for a single controller

 drivers/ram/Kconfig             |  10 ++
 drivers/ram/k3-ddrss/k3-ddrss.c | 285 ++++++++++++++++++++++++++++++--
 2 files changed, 278 insertions(+), 17 deletions(-)

-- 
2.34.1

