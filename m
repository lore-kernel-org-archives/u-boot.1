Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5A6C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 09:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F8B7876C1;
	Tue, 30 Jan 2024 10:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EbNnR9g3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0FE387751; Tue, 30 Jan 2024 10:42:56 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C0CD871A7
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 10:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40U9gqQl065107;
 Tue, 30 Jan 2024 03:42:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706607772;
 bh=v12ob0pnz6VAcax/FcSA4SP9V9u0IUR8bQzwcgh3gH4=;
 h=From:To:CC:Subject:Date;
 b=EbNnR9g3x24zA1PFXdzjOlxCm8zW4bMK4/dbvgUT9Y/V/UpZ66M+cPUj6EdWptRlZ
 H0iOwMww67uYS0Pj5XrCqn2FeFEhCWAJI9rDa21mB/OObo38FFAgz5zqvft65tYOHB
 dpFJ4HApx99ngD4uHW9Ggm3bZdoli9Hc7hLvh7Ck=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40U9gqsO060161
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 03:42:52 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 03:42:51 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 03:42:51 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40U9gmOb127640;
 Tue, 30 Jan 2024 03:42:48 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <afd@ti.com>,
 <christian.gmeiner@gmail.com>, <j-choudhary@ti.com>, <nm@ti.com>,
 <d.haller@phytec.de>, <joao.goncalves@toradex.com>, <u-boot@lists.denx.de>
Subject: [PATCH v2] arm: mach-k3: j721s2_init: Support less than max DDR
 controllers
Date: Tue, 30 Jan 2024 15:12:47 +0530
Message-ID: <20240130094247.2707253-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The number of DDR controllers to be initialised and used should depend
on the device tree with the constraint of the maximum number of
controllers the device supports. Since J721S2 has multiple (2)
controllers, instead of hardcoding the number of probes, move to
depending on the device tree UCLASS_RAM nodes present.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Changes since v1:
https://lore.kernel.org/all/20240130074139.2627793-1-n-francis@ti.com/
- Moved away from using loop since J721S2 has only two controllers
  (Udit)

Boot logs:
https://gist.github.com/nehamalcom/740e3dcc1e94ca36250f0248d73f6b37

 arch/arm/mach-k3/j721s2_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/j721s2_init.c b/arch/arm/mach-k3/j721s2_init.c
index fb0708bae1..07f9221baf 100644
--- a/arch/arm/mach-k3/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2_init.c
@@ -228,8 +228,8 @@ void k3_mem_init(void)
 			panic("DRAM 0 init failed: %d\n", ret);
 
 		ret = uclass_next_device_err(&dev);
-		if (ret)
-			panic("DRAM 1 init failed: %d\n", ret);
+		if (ret && ret != -ENODEV)
+			panic("DRAM %d init failed: %d\n", ctr, ret);
 	}
 	spl_enable_cache();
 }
-- 
2.34.1

