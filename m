Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5F1C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 16:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE12D83093;
	Tue, 15 Jul 2025 18:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VWWVs5zV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1ED083096; Tue, 15 Jul 2025 18:21:16 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA31683071
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 18:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56FGLDV92301936;
 Tue, 15 Jul 2025 11:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752596473;
 bh=7f3cyhQsPRjCn+imz/x2sgizRfoUvkviX3VmaWIxvZ4=;
 h=From:Date:Subject:To:CC;
 b=VWWVs5zVp4FgL2Nz7hvcI/6feOiqNyNZClVR/Ml7f4A/gUb3V3T0xsRzkzfQrsTB8
 EoVkC+8OpzYukh7/cldLp5USoa2Ehm5P0X1/eSfQ+99nPRzYz3/II0hWnWdbxDVIIq
 Brdbu3pUHfb/y+FMTjoqdXA/PwGEdIW7YWvXTBhY=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56FGLD2N1372815
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 15 Jul 2025 11:21:13 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 11:21:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 11:21:12 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56FGLCcY2879525;
 Tue, 15 Jul 2025 11:21:12 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 15 Jul 2025 11:21:12 -0500
Subject: [PATCH] include: env: ti_common: remove bootm_size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250715-initrd-fixes-v1-1-8c41b1fdea6b@ti.com>
X-B4-Tracking: v=1; b=H4sIAPd/dmgC/x3LQQqAIBBA0avIrBO0EKurRAvJsWZjMUYE4t0bW
 j4+v0JBJiwwqwqMDxU6s8B2CrYj5B01RTH0pnfGW6cp081RJ3qx6JTQmzAOUzIBZLkY/yDHsrb
 2AZA0NV9eAAAA
X-Change-ID: 20250715-initrd-fixes-ffe70a839f0a
To: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
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

As the size of the kernels, DTs, and initial ram disks continues to grow
in size the 256MB size limit set aside for image processing by the bootm
command has become too small for some boards.

Rather than increasing this limit let's just remove any limit by default
and let each board set its own (if needed) for there use case.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 include/env/ti/ti_common.env | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index 7029d12bf203320fde859965ae57c272ed4c685c..03e3267ef8a1bf3e14c65df124ed1ac842c88760 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -8,7 +8,6 @@ rdaddr=0x88080000
 ramdisk_addr_r=0x88080000
 scriptaddr=0x80000000
 pxefile_addr_r=0x80100000
-bootm_size=0x10000000
 boot_fdt=try
 
 boot_fit=0

---
base-commit: cd79a2839b01571b6f2915c219f71c05e3c97482
change-id: 20250715-initrd-fixes-ffe70a839f0a

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

