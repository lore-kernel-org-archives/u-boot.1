Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E24BD24471
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 05:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE74A89297;
	Fri, 11 Oct 2024 07:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FXZLqflf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F44892A9; Fri, 11 Oct 2024 02:03:38 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B351D892AA
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 02:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49B03VHh122067;
 Thu, 10 Oct 2024 19:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728605011;
 bh=GR/PFm5C34ojj+8k8idzAqxrALnIXv0eLiPtvHat574=;
 h=From:To:CC:Subject:Date;
 b=FXZLqflfmS7zH0tNB0UaQGmmzKHQIxCgzHvoLXJT77rHsEfn8eaElaMP83WBlP9om
 tgIYCMk6J+CWN2EhqOZD1sf2Vyzh/npolraRfkE2UNS7OkJ6GqLwgNpMvuDd6+Y2hr
 fKt3hlWQO5JEokNWnxHsTlfvTsvCCMU3HCObMDec=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49B03Vcq004223;
 Thu, 10 Oct 2024 19:03:31 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Oct 2024 19:03:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Oct 2024 19:03:30 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49B03U3s096589;
 Thu, 10 Oct 2024 19:03:30 -0500
From: Judith Mendez <jm@ti.com>
To: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
CC: Mattijs Korpershoek <mkorpershoek@baylibre.com>, <u-boot@lists.denx.de>,
 Judith Mendez <jm@ti.com>
Subject: [PATCH] TI: include: env: ti_common: move fdtoverlay_addr_r to fix
 ramdisk size
Date: Thu, 10 Oct 2024 19:03:22 -0500
Message-ID: <20241011000322.538287-1-jm@ti.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 11 Oct 2024 07:10:14 +0200
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

From: Mattijs Korpershoek <mkorpershoek@baylibre.com>

When booting Android with adtbo_idx set, we observe the
following crash:

   ** Booting bootflow 'mmc@fa10000.bootdev.whole' with android
   ## Booting Android Image at 0x82000000 ...
   Kernel load addr 0x92000000 size 20195 KiB
   Kernel extra command line: console=ttyS2,115200 cma=768M 8250.
	nr_uarts=10 printk.devkmsg=on init=/init quiet firmware_class.
	path=/vendor/firmware mem_sleep_default=deep bootconfig
   RAM disk load addr 0x88080000 size 16901 KiB
   "Synchronous Abort" handler, esr 0x96000005, far 0x155b104c8
   elr: 0000000080808560 lr : 0000000080808558 (reloc)
   elr: 00000000ffebf560 lr : 00000000ffebf558
   x0 : 00000000fff99000 x1 : 00000000fff9553c
   x2 : 000000000000000a x3 : 0000000002800000
   x4 : 0000000002800000 x5 : 0000000000000020

This happens because the memory at fdtoverlay_addr_r is bogus.
In fact:

=> printenv fdtoverlay_addr_r
fdtoverlay_addr_r=0x89000000

And the ramdisk address range is:
[0x88080000; 0x88080000 + 16901 KiB]

Which is equal to:
[0x88080000; 0x89101400]

So, if we represent the addresses:
fdtaddr             0x88000000
ramdisk             0x88080000
fdtoverlay_addr_r   0x89000000
ramisk (end)        0x89101400

We see that fdtoverlay_addr_r in fact has been overridden by
the Android ramdisk.

The maximum ramdisk size is 0x1080000 (15,5 MiB) and a compressed
Android vendor ramdisk is 15MiB:
$ file vendor_ramdisk.img
vendor_ramdisk.img: LZ4 compressed data (v0.1-v0.9)
$ du -sh vendor_ramdisk.img
15M     vendor_ramdisk.img

When it gets decompressed, it uses 16.5MiB, exceeding the
maximum ramdisk size.

Increase the maximum ramdisk size to 20.5MiB by moving
fdtoverlay_addr_r higher up in the address space to fix the crash.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Judith Mendez <jm@ti.com>
---
 include/env/ti/ti_common.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index 7029d12bf20..a15af79d9c3 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -3,7 +3,7 @@ kernel_addr_r=0x82000000
 fdtaddr=0x88000000
 dtboaddr=0x89000000
 fdt_addr_r=0x88000000
-fdtoverlay_addr_r=0x89000000
+fdtoverlay_addr_r=0x89500000
 rdaddr=0x88080000
 ramdisk_addr_r=0x88080000
 scriptaddr=0x80000000

base-commit: a404065479be2c1fe1167c3c91367e8194a69d1b
-- 
2.46.2

