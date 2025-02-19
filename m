Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7FBC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 10:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59F7580F67;
	Wed, 19 Feb 2025 11:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U7/9OODj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73F880F67; Wed, 19 Feb 2025 11:48:55 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF5280C98
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 11:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51JAmdA6258772
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2025 04:48:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739962119;
 bh=ova5Hvh3xMAUmojgK2RBBaeLo4Q6ohDEBDP9Cxb6zGM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=U7/9OODju5r1sfFn/Ly/Nq8EIMF2WClUk6heotIqhg/TGSebDOph32LSK8yZw6khz
 NlcTUgUXBQKrPB/cb9r+/RjrKlsPD5Xvy2sKf/6eRiGpO+Yybab++OlS/Cuf9rhTY0
 tG6OUZ15bQ9HusU2VnEwKdMs/lK4nkJ/Hh/gtp7c=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51JAmdM4020582
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Feb 2025 04:48:39 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Feb 2025 04:48:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Feb 2025 04:48:38 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51JAmbP7118676;
 Wed, 19 Feb 2025 04:48:38 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michael Walle <mwalle@kernel.org>, "Roger Quadros" <rogerq@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Santhosh Kumar K <s-k6@ti.com>, "Hari Nagalla" <hnagalla@ti.com>,
 Nishanth Menon <nm@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, "Kishon Vijay
 Abraham I" <kishon@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Wadim Egorov
 <w.egorov@phytec.de>, "Udit Kumar" <u-kumar1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, "Bryan Brattlof" <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 03/13] arm: mach-k3: am62x: am625_init: Remove explicit
 probing of CPSW driver
Date: Wed, 19 Feb 2025 16:18:21 +0530
Message-ID: <20250219104831.2315464-4-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219104831.2315464-1-c-vankar@ti.com>
References: <20250219104831.2315464-1-c-vankar@ti.com>
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

Probe method of CPSW driver is replaced with the bind method which
eventually probes CPSW driver. Hence remove explicit probing of CPSW.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is new in this series.

 arch/arm/mach-k3/am62x/am625_init.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index 595fc391ac5..72a752d38e8 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -282,15 +282,6 @@ void board_init_f(ulong dummy)
 	}
 	spl_enable_cache();
 
-	if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
-	    spl_boot_device() == BOOT_DEVICE_ETHERNET) {
-		struct udevice *cpswdev;
-
-		if (uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
-						&cpswdev))
-			printf("Failed to probe am65_cpsw_nuss driver\n");
-	}
-
 	fixup_a53_cpu_freq_by_speed_grade();
 }
 
-- 
2.34.1

