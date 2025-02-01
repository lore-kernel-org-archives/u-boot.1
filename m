Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291B7C0218A
	for <u-boot@archiver.kernel.org>; Sat,  1 Feb 2025 09:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4101580F86;
	Sat,  1 Feb 2025 10:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pbtQU7RH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF12D80F80; Sat,  1 Feb 2025 10:18:19 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4997A80F86
 for <u-boot@lists.denx.de>; Sat,  1 Feb 2025 10:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5119IEko1855754
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 1 Feb 2025 03:18:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738401494;
 bh=nrrQUI7I2RG13vTWJNWdFOuFbzh6HsD+nzvFRL7Z6Hk=;
 h=From:To:CC:Subject:Date;
 b=pbtQU7RH4PA8SrzUoUyekiaHwS8cZYWrW8PlikqaTTGu7+DuC0i2nDD2ZjI/8/ypo
 CCWkdz+8WmpD1MY7fq7OiDwfH84S0uS1hXKXHrKixXgM2YpRBjWnBRnJrqvbRa55wC
 EOBeHc7de+sVIgT1+CFQn60vni0W2nymw37YCzQ8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5119IEV0012058
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 1 Feb 2025 03:18:14 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Feb 2025 03:18:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Feb 2025 03:18:14 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.104])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5119IAgC096497; 
 Sat, 1 Feb 2025 03:18:10 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <a-limaye@ti.com>, <n-francis@ti.com>, <s-k6@ti.com>,
 <a-dutta@ti.com>, <vaishnav.a@ti.com>, <j-humphreys@ti.com>,
 <p-mantena@ti.com>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] FIX: Re-enable MUX_MMIO on J721E/J7200
Date: Sat, 1 Feb 2025 14:47:58 +0530
Message-ID: <20250201091809.1894892-1-s-vadapalli@ti.com>
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

Hello,

This series re-enables MUX_MMIO at U-Boot proper on J721E and J7200
SoCs. The commits which introduced support for Hyperflash boot on both
of these SoCs disabled MUX_MMIO functionality at U-Boot proper, thereby
introducing a regression.

Series is based on commit
2b1c8d3b2d cmd: Fix Kconfig coding style
of the master branch of U-Boot.

v1 of this series was a single patch which was posted to fix the issue
on J7200. The issue was detected when PCIe functionality on J7200 was
tested and found to be broken.
v1:
https://patchwork.ozlabs.org/project/uboot/patch/20250127162509.965644-1-s-vadapalli@ti.com/
Changes since v1:
- Added patch to fix issue on J721E as well.

Regards,
Siddharth.

Siddharth Vadapalli (2):
  configs: j721e_evm_a72_defconfig: Re-enable MUX_MMIO at U-Boot proper
  configs: j7200_evm_a72_defconfig: Re-enable MUX_MMIO at U-Boot proper

 configs/j7200_evm_a72_defconfig | 1 +
 configs/j721e_evm_a72_defconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0

