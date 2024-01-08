Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F90C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 17:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D082F87AD4;
	Mon,  8 Jan 2024 18:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="al/G2dVB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4327C87AE5; Mon,  8 Jan 2024 18:33:22 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1EAA87ACA
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 18:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 408HX937116460;
 Mon, 8 Jan 2024 11:33:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704735189;
 bh=sOqGMxEZGFTI6lv99vJMVl/lomxjZXCsymPTiBKuYRE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=al/G2dVBQ5GGabRPILaOE7sqPoYwQGgmKM3rBS2GGVhvUGFngMlZ1NM1ChwgfuU5i
 ADzktRyZjg93xrmXudukCFEqr3RQMbNMoHhbxqV4JT58Zz3O223KKi1MmUvmrASBIJ
 xjn+dBQwJtBjCi4lAmhHr9PYswoAJ3nRjfSsm1v8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 408HX9SJ072366
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jan 2024 11:33:09 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 11:33:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 11:33:08 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 408HX8MG045355;
 Mon, 8 Jan 2024 11:33:08 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH 10/10] include: env: ti: Drop default_findfdt
Date: Mon, 8 Jan 2024 11:33:01 -0600
Message-ID: <20240108173301.2692332-11-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108173301.2692332-1-nm@ti.com>
References: <20240108173301.2692332-1-nm@ti.com>
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

We shouldn't need finfdt anymore. Drop the env script.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 include/env/ti/default_findfdt.env | 12 ------------
 1 file changed, 12 deletions(-)
 delete mode 100644 include/env/ti/default_findfdt.env

diff --git a/include/env/ti/default_findfdt.env b/include/env/ti/default_findfdt.env
deleted file mode 100644
index a2b51dd923bb..000000000000
--- a/include/env/ti/default_findfdt.env
+++ /dev/null
@@ -1,12 +0,0 @@
-default_device_tree=CONFIG_DEFAULT_DEVICE_TREE
-default_device_tree_arch=ti
-#ifdef CONFIG_ARM64
-findfdt=
-	setenv name_fdt ${default_device_tree_arch}/${default_device_tree}.dtb;
-	setenv fdtfile ${name_fdt}
-#else
-default_device_tree_subarch=omap
-findfdt=
-	setenv name_fdt ${default_device_tree_arch}/${default_device_tree_subarch}/${default_device_tree}.dtb;
-	setenv fdtfile ${name_fdt}
-#endif
-- 
2.43.0

