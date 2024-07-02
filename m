Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BC2C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 05:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC1538872B;
	Tue,  2 Jul 2024 07:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f0aaRgWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8544D8872B; Tue,  2 Jul 2024 07:20:42 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C4E1883D9
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 07:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4625KaIN014139;
 Tue, 2 Jul 2024 00:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719897636;
 bh=Rte80oI3hMsTXpKERPJSMKMCv3xzwjPB2CO1bsFh6xw=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=f0aaRgWr1Y1M+2D0N+qGOFO4Oz9paML29KXF0gZOWj7HUwG1EHNg+2SI7va07b63+
 xL4CfTGZyTQhWlVricT1bLR4Px5l7ckIqndQnNdeTMlh+owzm3xklEqN9PAtq1dPu/
 XjWGe9FU9ZUQeKO5Zym2oTqC2BFuEvBgknAT8QJM=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4625Ka9Q025429
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Jul 2024 00:20:36 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 00:20:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 00:20:35 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4625KKsM070700;
 Tue, 2 Jul 2024 00:20:32 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 2 Jul 2024 10:50:03 +0530
Subject: [PATCH v3 3/4] include: env: ti: mmc: Change name_fdt usage to fdtfile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240702-b4-upstream-streamline-platform-v3-3-0ebd7bbd31d5@ti.com>
References: <20240702-b4-upstream-streamline-platform-v3-0-0ebd7bbd31d5@ti.com>
In-Reply-To: <20240702-b4-upstream-streamline-platform-v3-0-0ebd7bbd31d5@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>, Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719897620; l=1317;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=KhJ76qnhULL3bHrmOWCI0uF2uTEYtE9lLFEU9y4cgqk=;
 b=XPb530ql5n66G9fE5I54rpXQvaeLsuPEVqDeFYF23FlcY3Zy9rzMGQUdm33dmeSyA35PhwRe4
 F0vmMVjnsQ+DJy+swcABYEY6kLm0Gu7NhBbzmvjltFW3Hf2Lg2owcqs
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

name_fdt is kept for backward compatibility but it depends on EEPROM
detection logic and some of the TI K3 platforms don't have that anymore
which causes boot failure in legacy boot flow using bootcmd_ti_mmc.

K2g platforms which uses the same file have their own override causing
this change to be no-impact for them.

Replacing name_fdt usage to fdtfile as fdtfile is populated based on
CONFIG_DEFAULT_DEVICE_TREE after using ti_set_fdt_env.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 include/env/ti/mmc.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/env/ti/mmc.env b/include/env/ti/mmc.env
index 0256a2d2aaca..037a09010ce4 100644
--- a/include/env/ti/mmc.env
+++ b/include/env/ti/mmc.env
@@ -16,7 +16,7 @@ importbootenv=echo Importing environment from mmc${mmcdev} ...;
 loadbootenv=fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
 loadimage=load ${devtype} ${bootpart} ${loadaddr} ${bootdir}/${bootfile}
 loadfdt=load ${devtype} ${bootpart} ${fdtaddr} ${bootdir}/dtb/${fdtfile}
-get_fdt_mmc=load mmc ${bootpart} ${fdtaddr} ${bootdir}/dtb/${name_fdt}
+get_fdt_mmc=load mmc ${bootpart} ${fdtaddr} ${bootdir}/dtb/${fdtfile}
 envboot=if mmc dev ${mmcdev}; then
 	if mmc rescan; then
 		echo SD/MMC found on device ${mmcdev};

-- 
2.45.1

