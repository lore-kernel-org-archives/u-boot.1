Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BF9EEB562
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 17:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20EA286A9C;
	Fri,  8 Sep 2023 19:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wz/uPDmP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB69886A35; Fri,  8 Sep 2023 19:30:29 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1631286AA3
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 19:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388HUOaU094872;
 Fri, 8 Sep 2023 12:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694194224;
 bh=P/8bwBzjVeLiqt80iS4DzdPQfaJPyjLJ/s035q2QhMQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wz/uPDmPy9Py8Nx4KvYgoccoe5VFCzyxmoXkohFwr/VRXZarygK3I5Cgb17ReJE7L
 iJ9jGZ7PaLAZbuV+a32KApUfrhj30XlCRtCrTvpUvv5Ox6QOjYgIYDAZVXzkvLzJum
 LifWGk2Ksbb3GirvzwFuY6uRKnYJJpKVhKm7XJns=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388HUO9p012944
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 12:30:24 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 12:30:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 12:30:23 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388HTfxK052571;
 Fri, 8 Sep 2023 12:30:21 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>
CC: <peng.fan@nxp.com>, <ye.li@nxp.com>, <robimarko@gmail.com>,
 <u-boot@lists.denx.de>, <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [RFC PATCH v2 2/3] arm: mach-k3: update board file to use thermal
 device
Date: Fri, 8 Sep 2023 22:59:16 +0530
Message-ID: <20230908172914.436194-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908172914.436194-1-u-kumar1@ti.com>
References: <20230908172914.436194-1-u-kumar1@ti.com>
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

Update am65 and J721e board files to use thermal device
instead of MISC device

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm/mach-k3/am654_init.c | 2 +-
 arch/arm/mach-k3/j721e_init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/am654_init.c b/arch/arm/mach-k3/am654_init.c
index 0d3889cde2..7496164acf 100644
--- a/arch/arm/mach-k3/am654_init.c
+++ b/arch/arm/mach-k3/am654_init.c
@@ -248,7 +248,7 @@ void board_init_f(ulong dummy)
 	do_board_detect();
 
 #if defined(CONFIG_CPU_V7R) && defined(CONFIG_K3_AVS0)
-	ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(k3_avs),
+	ret = uclass_get_device_by_driver(UCLASS_THERMAL, DM_DRIVER_GET(k3_avs),
 					  &dev);
 	if (ret)
 		printf("AVS init failed: %d\n", ret);
diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
index b6164575b7..db9bbd72c7 100644
--- a/arch/arm/mach-k3/j721e_init.c
+++ b/arch/arm/mach-k3/j721e_init.c
@@ -276,7 +276,7 @@ void board_init_f(ulong dummy)
 	do_board_detect();
 
 #if defined(CONFIG_CPU_V7R) && defined(CONFIG_K3_AVS0)
-	ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(k3_avs),
+	ret = uclass_get_device_by_driver(UCLASS_THERMAL, DM_DRIVER_GET(k3_avs),
 					  &dev);
 	if (ret)
 		printf("AVS init failed: %d\n", ret);
-- 
2.34.1

