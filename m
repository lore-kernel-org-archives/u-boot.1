Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C57C4828D
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 00:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB0887D66;
	Fri,  2 Feb 2024 01:24:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nbgR6HOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A0A687CC4; Fri,  2 Feb 2024 01:24:55 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EA0E87D5A
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 01:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4120OoZX026534;
 Thu, 1 Feb 2024 18:24:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706833490;
 bh=lV3k3sSkk/9wrLsFw1Rx3d3zdoxwkZZMTO+v16jfNE8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=nbgR6HOye3r062Bu0aeJPcdKiKTorknQkiDGDzEw24lrmYX2gYxcfs7qRMtQpbO3O
 +P3BoBUrRfCtOVTji7/u9k/4rTwzuxpUPBTNqUC3SMjCk3eTKHOAHB+bNIwz3lSMoz
 E9wHCaG39Zt/yBkCfS79aORFUWyexrkIUbA2hoao=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4120OoiX039483
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 1 Feb 2024 18:24:50 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 18:24:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 18:24:50 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4120OnBj107441;
 Thu, 1 Feb 2024 18:24:50 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 4/6] arm: mach-k3: am62a7: Disable firewalls only after
 loading SYSFW
Date: Thu, 1 Feb 2024 18:24:46 -0600
Message-ID: <20240202002448.1116407-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202002448.1116407-1-afd@ti.com>
References: <20240202002448.1116407-1-afd@ti.com>
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

Currently we do this multiple times, instead just do it once after loading
SYSFW in R5 SPL.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/am62a7_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/am62a7_init.c b/arch/arm/mach-k3/am62a7_init.c
index d72e19936b9..ccbde5bdd85 100644
--- a/arch/arm/mach-k3/am62a7_init.c
+++ b/arch/arm/mach-k3/am62a7_init.c
@@ -142,6 +142,9 @@ void board_init_f(ulong dummy)
 		panic("ROM has not loaded TIFS firmware\n");
 
 	k3_sysfw_loader(true, NULL, NULL);
+
+	/* Disable ROM configured firewalls right after loading sysfw */
+	remove_fwl_configs(cbass_main_fwls, ARRAY_SIZE(cbass_main_fwls));
 #endif
 
 #if defined(CONFIG_CPU_V7R)
@@ -170,9 +173,6 @@ void board_init_f(ulong dummy)
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
 
-       /* Disable ROM configured firewalls right after loading sysfw */
-       remove_fwl_configs(cbass_main_fwls, ARRAY_SIZE(cbass_main_fwls));
-
 #if defined(CONFIG_K3_AM62A_DDRSS)
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret)
-- 
2.39.2

