Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABEDCAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 13:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26006835B3;
	Tue, 23 Sep 2025 15:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uvoo4xvd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7269F8354B; Tue, 23 Sep 2025 15:09:14 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A80EE834E1
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 15:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ND98RD1480024;
 Tue, 23 Sep 2025 08:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758632948;
 bh=JQOwamLnJoLgIi+UQBoAW00OCDXKcR6RGL2Lt8RK2hs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=uvoo4xvd1dRQMOxC/bXznr1q/uxO1RZ8vKFWjlB+mdYKPqixWvY8Ib338ewURFhPp
 kZ107QRC7nLwGjQQDMe3Rc3DdLjh5geF6hS3zm/eACGvq3U2iegyML28FuKGsXv9Xx
 NJ/tQ6NHTL9h+UsNwpXy92f1pRbC3hlmYZfWMxlY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ND98VC2800519
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 23 Sep 2025 08:09:08 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 08:09:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 08:09:07 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ND96Wd341098;
 Tue, 23 Sep 2025 08:09:07 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 2/8] spl: Kconfig: allow K3 devices to use falcon mode
Date: Tue, 23 Sep 2025 18:38:54 +0530
Message-ID: <20250923130901.705124-3-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923130901.705124-1-anshuld@ti.com>
References: <20250923130901.705124-1-anshuld@ti.com>
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

Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32-bit
HS devices and but can now be enabled with the addition of
OS_BOOT_SECURE.

For secure boot, the kernel with x509 headers can be packaged in a fit
container (fitImage) signed with TIFS keys for authentication.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 7e87e50f693..ab780da9e1c 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1201,7 +1201,7 @@ config SPL_ONENAND_SUPPORT
 
 config SPL_OS_BOOT
 	bool "Activate Falcon Mode"
-	depends on !TI_SECURE_DEVICE
+	select SPL_OS_BOOT_SECURE if TI_SECURE_DEVICE
 	help
 	  Enable booting directly to an OS from SPL.
 	  for more info read doc/README.falcon
-- 
2.51.0

