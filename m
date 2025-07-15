Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50764C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 18:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADEB8830B4;
	Tue, 15 Jul 2025 20:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J6uqauNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BF08830C0; Tue, 15 Jul 2025 20:47:12 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E079830B3
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 20:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56FIl76k073341;
 Tue, 15 Jul 2025 13:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752605227;
 bh=be8ohXTMdPCLZqqvM00WqlRcz990vEBQGHqfVigOsIo=;
 h=From:Date:Subject:To:CC;
 b=J6uqauNWmwRWZj4Nzr79rPayWP+fEwumUUhzopQkYYb+4Dwa4dWRl/CZwwCyGUMx6
 EHdQxe5kA2lzF5+zPRVYRcjxFtAGw66iANjuewvQp7DJqIW7FSxEJ5kM8DohlKqAKK
 4Nft5T5RySUCUDby0lcFAdS4D0NADUDIOE/hqq0o=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56FIl6It2936933
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 15 Jul 2025 13:47:06 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 13:47:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 13:47:06 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56FIl6WB3375454;
 Tue, 15 Jul 2025 13:47:06 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 15 Jul 2025 13:47:05 -0500
Subject: [PATCH v2] include: env: ti_common: remove bootm_size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250715-initrd-fixes-v2-1-e2ebbe543464@ti.com>
X-B4-Tracking: v=1; b=H4sIACiidmgC/3WMQQ7CIBBFr9LM2jGA1lZX3sN0QWGwsxAaIETTc
 Hexe5fv/7y3QaLIlODWbRCpcOLgG6hDB2bR/knItjEooXoxyB7Zc44WHb8poXM0CD2erk5oaMo
 aaT+a8ZgaL5xyiJ+9XuRv/RMqEiWO5ixn6Szpy3zPfDThBVOt9Qu0QLzUpQAAAA==
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

As the size of 64b ARM kernels, DTs, vendor firmware, and initial ram
disks continues to grow, the 256MB size limit set aside for image
processing by the bootm command has become too small for some K3
reference boards.

For ARMv7 removing this limit could introduce issues so move the
bootm_size variable to ti_armv7_keystone2.env and remove the limit for
any board using a TI K3 SoC.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v2:
- ensure the size limit is set for ARMv7 platforms
- Link to v1: https://lore.kernel.org/r/20250715-initrd-fixes-v1-1-8c41b1fdea6b@ti.com
---
 include/env/ti/ti_armv7_keystone2.env | 1 +
 include/env/ti/ti_common.env          | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/env/ti/ti_armv7_keystone2.env b/include/env/ti/ti_armv7_keystone2.env
index e0395d302cb9c308cbe56f1e7355fcdd129474f5..1b2aaa2808a8eb896ef821d5d978d77d0f687ef8 100644
--- a/include/env/ti/ti_armv7_keystone2.env
+++ b/include/env/ti/ti_armv7_keystone2.env
@@ -12,6 +12,7 @@ dfu_alt_info_mmc=
 	uEnv.txt fat 0 1
 
 bootdir=/boot
+bootm_size=0x10000000
 tftp_root=/
 nfs_root=/export
 mem_lpae=1
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

