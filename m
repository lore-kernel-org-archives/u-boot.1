Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12B4C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 09:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13EB28043C;
	Tue, 18 Feb 2025 10:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QWvElJ4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 237BC80BA8; Tue, 18 Feb 2025 10:50:04 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E7A480079
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 10:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51I9nte71649875
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Feb 2025 03:49:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739872195;
 bh=sGCuMIdaUInzHH2aZnTA5TC7TT4ROyqegPJpeyLNSTE=;
 h=From:To:CC:Subject:Date;
 b=QWvElJ4lYA8mH5Xvt9A465KD7jZs9aQ8nRf8WWnKYmMHUbp7b3jCCAWznRZEhWIaQ
 5Pq4vprSasu809gexWXcs/NJNKZMEhKXphW5Flr08pBfvyCAGC4nk7k1wMs5aDys07
 vxl66WA7CqJAokbISoZDJi+8s1QAcvTqwDN/ulQY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51I9ntOX016152
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Feb 2025 03:49:55 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 03:49:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 03:49:54 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51I9no5Z064686; 
 Tue, 18 Feb 2025 03:49:51 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <j-choudhary@ti.com>,
 <n-francis@ti.com>, <m-chawdhry@ti.com>, <jm@ti.com>,
 <j-humphreys@ti.com>, <u-kumar1@ti.com>, <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 0/2] J784S4: Enable USB DFU boot, DFU flash and UMS configs
Date: Tue, 18 Feb 2025 15:19:43 +0530
Message-ID: <20250218094950.2542006-1-s-vadapalli@ti.com>
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

This series enables configs for USB DFU boot, USB DFU flash and USB Mass
Storage command for J784S4. The device-tree changes required for enabling
these features will be posted as patches to Linux device-tree mailing lists
and will eventually make it to U-Boot via DT Sync.

Series is based on commit
5c33fb0288 u_boot_pylib: Move gitutil into the library
of the next branch of U-Boot.

Regards,
Siddharth.

Siddharth Vadapalli (2):
  configs: j784s4_evm_r5_defconfig: enable USB DFU boot
  configs: j784s4_evm_a72_defconfig: enable USB DFU boot, DFU flash and
    UMS

 configs/j784s4_evm_a72_defconfig | 30 ++++++++++++++++++++++--------
 configs/j784s4_evm_r5_defconfig  | 15 +++++++++++++++
 2 files changed, 37 insertions(+), 8 deletions(-)

-- 
2.43.0

