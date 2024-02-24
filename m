Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E68DC54798
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 00:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 326DB87CB1;
	Sat, 24 Feb 2024 01:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IQxzhDm/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EAA487C48; Sat, 24 Feb 2024 01:23:15 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FCEB8781D
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 01:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41O0NAvT040964;
 Fri, 23 Feb 2024 18:23:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708734190;
 bh=6UEwcc8CB3/jLVtQJgROerr2P3RCw7x4iFmIq2RkeYs=;
 h=From:To:CC:Subject:Date;
 b=IQxzhDm/g6fxMdw7oVfIjhCp9ktvSt3nvfW0tBxIOCXbwCYyEddT7rW7RdtFI4eaJ
 isG14/mtEMYZcMiNjFkZ2YdmdmsENjx6ew/9omQ+t0YgMKtcE+iDPhGwVB8uLsz3X9
 scSaIy0ttgv62ry5qyWvnLP9X2aT37m7Qe1ZgPpc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41O0NAK8018946
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Feb 2024 18:23:10 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 18:23:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 18:23:10 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41O0N9vx026379;
 Fri, 23 Feb 2024 18:23:09 -0600
From: Jonathan Humphreys <j-humphreys@ti.com>
To: <trini@konsulko.com>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v2 0/3] Enable OSPI on j721e
Date: Fri, 23 Feb 2024 18:23:04 -0600
Message-ID: <20240224002307.2284386-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Sat, 24 Feb 2024 01:47:06 +0100
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

This series enables OSPI storage and boot.

fixes: 58d61fb5a77e ("arm: dts: k3-j721e-sk: Add initial A72 specific dts support")

Changes from v1:
- added patch to remove the OSPI phy pattern partition, as it wasn't used

v1: https://patchwork.ozlabs.org/project/uboot/list/?series=396241

Jonathan Humphreys (3):
  configs: j721e: Enable OSPI memory
  arm: mach-k3: j721e: Enable OSPI boot
  arm: dts: k3-j721e-sk: Remove OSPI phypattern partition

 arch/arm/dts/k3-j721e-sk-u-boot.dtsi      | 4 ----
 arch/arm/mach-k3/include/mach/j721e_spl.h | 5 +++--
 arch/arm/mach-k3/j721e_init.c             | 3 ++-
 configs/j721e_evm_a72_defconfig           | 7 +++++++
 configs/j721e_evm_r5_defconfig            | 6 ++++++
 5 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.34.1

