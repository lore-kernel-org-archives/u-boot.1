Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02305C6787B
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EFA986B34;
	Fri, 25 Aug 2023 20:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EHkZI45S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 142D086AB5; Fri, 25 Aug 2023 20:03:27 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7FB086AE8
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PI36Xt114030;
 Fri, 25 Aug 2023 13:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692986586;
 bh=4v5zawe9G4QfdpzIQ7tL3NoMj0N25+3z0+3SpSleEdc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EHkZI45SsoqcpKOD9nO53IAfOGgZxqsQ7JeRZpyVc4WVT7S/+jfC0QeXu9gjo/1k6
 AbfvtRMjdmoouSMMSRZo77RX7lkA16nmIGmhO06RW4HaI/FqGm1lPb3a0dT7BCIvO+
 SvJzHi3gwSe85vk05EDVDfEbhdNURwruI9nyXsak=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PI36rt123984
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 13:03:06 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 13:03:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 13:03:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PI36xc026927;
 Fri, 25 Aug 2023 13:03:06 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V6 01/20] include: env: ti: mmc: envboot/mmcboot: Check result
 of mmc dev before proceeding
Date: Fri, 25 Aug 2023 13:02:46 -0500
Message-ID: <20230825180305.69515-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230825180305.69515-1-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
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

If mmc dev reports that the device is not present, there is no point in
proceeding further to attempt to load the files.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
new patch -  noticed a series of 'MMC: no card present' in boot log
and was wondering why, now I know - shaves off 2 seconds or so into boot
process.

 include/env/ti/mmc.env | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/env/ti/mmc.env b/include/env/ti/mmc.env
index 6fb47fb26673..b8eb51ca1744 100644
--- a/include/env/ti/mmc.env
+++ b/include/env/ti/mmc.env
@@ -15,7 +15,7 @@ loadbootenv=fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
 loadimage=load ${devtype} ${bootpart} ${loadaddr} ${bootdir}/${bootfile}
 loadfdt=load ${devtype} ${bootpart} ${fdtaddr} ${bootdir}/dtb/${fdtfile}
 get_fdt_mmc=load mmc ${bootpart} ${fdtaddr} ${bootdir}/dtb/${name_fdt}
-envboot=mmc dev ${mmcdev};
+envboot=if mmc dev ${mmcdev}; then
 	if mmc rescan; then
 		echo SD/MMC found on device ${mmcdev};
 		if run loadbootscript; then
@@ -31,6 +31,7 @@ envboot=mmc dev ${mmcdev};
 			fi;
 		fi;
 	fi;
+  fi;
 mmcloados=
 	if test ${boot_fdt} = yes || test ${boot_fdt} = try; then
 		if run get_fdt_mmc; then
@@ -45,7 +46,7 @@ mmcloados=
 	else
 		bootz;
 	fi;
-mmcboot=mmc dev ${mmcdev};
+mmcboot=if mmc dev ${mmcdev}; then
 	devnum=${mmcdev};
 	devtype=mmc;
 	if mmc rescan; then
@@ -58,7 +59,8 @@ mmcboot=mmc dev ${mmcdev};
 				run mmcloados;
 			fi;
 		fi;
-fi;
+	fi;
+  fi;
 
 init_mmc=run args_all args_mmc
 get_overlay_mmc=
-- 
2.40.0

