Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC28C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 07:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E55E587CC1;
	Tue, 30 Jan 2024 08:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A5o18QQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61E5087CD5; Tue, 30 Jan 2024 08:41:49 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98BEB875B9
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 08:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40U7fhCB115155;
 Tue, 30 Jan 2024 01:41:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706600503;
 bh=15iuQ/KbjThdtDYNxXMGIBrlP0/bpAtUq/kE5WpBhVI=;
 h=From:To:CC:Subject:Date;
 b=A5o18QQxTrwDMz4AAadrL6hqBOSEh1iIoUihlYsXEaBi2gL/3uv3b8hNUkPKvjyNC
 bU85sOq6M0fTETKLJVPA9K8Dt1jgTG0aM+xECDXFeOmyIt6LYtDWxzl2wfz69nJSkV
 hJIcPWFnuQW3naebCjnFnm17n0X6PsedpjIbd3JA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40U7fhOA066297
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 01:41:43 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 01:41:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 01:41:43 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40U7fdwT067121;
 Tue, 30 Jan 2024 01:41:40 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <afd@ti.com>,
 <christian.gmeiner@gmail.com>, <j-choudhary@ti.com>, <nm@ti.com>,
 <d.haller@phytec.de>, <joao.goncalves@toradex.com>, <u-boot@lists.denx.de>
Subject: [PATCH] arm: mach-k3: j721s2_init: Support less than max DDR
 controllers
Date: Tue, 30 Jan 2024 13:11:39 +0530
Message-ID: <20240130074139.2627793-1-n-francis@ti.com>
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
Boot logs:
https://gist.github.com/nehamalcom/07fedf4aa173590214b5cef6e1688fa1

This was also parallely proposed in [1] on the mailing-list for J784S4.

[1] https://lore.kernel.org/all/3a7c817b-de29-463a-b4b6-d62c0df66ade@ti.com/

 arch/arm/mach-k3/j721s2_init.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/j721s2_init.c b/arch/arm/mach-k3/j721s2_init.c
index fb0708bae1..ff21619506 100644
--- a/arch/arm/mach-k3/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2_init.c
@@ -213,10 +213,12 @@ bool check_rom_loaded_sysfw(void)
 	return is_rom_loaded_sysfw(&bootdata);
 }
 
+#define J721S2_MAX_CONTROLLERS	2
+
 void k3_mem_init(void)
 {
 	struct udevice *dev;
-	int ret;
+	int ret, ctr = 1;
 
 	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
 		ret = uclass_get_device_by_name(UCLASS_MISC, "msmc", &dev);
@@ -227,9 +229,14 @@ void k3_mem_init(void)
 		if (ret)
 			panic("DRAM 0 init failed: %d\n", ret);
 
-		ret = uclass_next_device_err(&dev);
-		if (ret)
-			panic("DRAM 1 init failed: %d\n", ret);
+		while (ctr < J721S2_MAX_CONTROLLERS) {
+			ret = uclass_next_device_err(&dev);
+			if (ret == -ENODEV)
+				break;
+			if (ret)
+				panic("DRAM %d init failed: %d\n", ctr, ret);
+			ctr++;
+		}
 	}
 	spl_enable_cache();
 }
-- 
2.34.1

