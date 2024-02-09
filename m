Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430A8C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 10:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BABD787E2B;
	Fri,  9 Feb 2024 11:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Pqb0rHKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01F6787E35; Fri,  9 Feb 2024 11:08:47 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E0A086C72
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 11:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 419A8XU2011681;
 Fri, 9 Feb 2024 04:08:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707473313;
 bh=X08CwN7bjBjeNGfOs+zvfj32FB/v88vgreEogSx4mTc=;
 h=From:To:CC:Subject:Date;
 b=Pqb0rHKUWr1tEnpicX4T0LkBOvX9Njyrskrdc+G03//5iLDoCiRy75qAjyEClmWU+
 gHn++VpwaLvaeYq0350pG4RzrHVhM18hTgLaoBtoIPFixaeMFBH9tNOKvnbi/QtFNu
 Dib0Xy2kvHealiGCNDGSYEmhYuC+qMqH/LBYi2sA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 419A8Wra082188
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 9 Feb 2024 04:08:32 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 04:08:32 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 04:08:32 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 419A8WWm108605;
 Fri, 9 Feb 2024 04:08:32 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 419A8VVj004076;
 Fri, 9 Feb 2024 04:08:32 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Sean Anderson <seanga2@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, MD Danish
 Anwar <danishanwar@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v5] misc: fs-loader: Use fw_storage_interface instead of
 storage_interface
Date: Fri, 9 Feb 2024 15:38:29 +0530
Message-ID: <20240209100829.1079401-1-danishanwar@ti.com>
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

The fs-loader driver reads env storage_interface and uses it to load
firmware file into memory using the medium set by env. Update the driver
to use env fw_storage_interface as this variable is only used to load
firmwares. This is to keep all variables used by fs-loader driver with
'fw_' prefix. All other variables have 'fw_' prefix except for
storage_interface.

The env storage_interface will act as fallback so that the
existing implementations do not break.

Also update the FS Loader documentation accordingly.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Sean Anderson <seanga2@gmail.com>
Changes from v4 to v5:
*) Modified commit message to make the motive cleared for this commit.
*) Added RB tag of Ravi.
*) Rebased on the latest u-boot/master [commit
   a4650bf65e4b7d3ef04c90ba8031374428e4a682]

v4: https://lore.kernel.org/all/20240130062627.2344282-1-danishanwar@ti.com/

 doc/develop/driver-model/fs_firmware_loader.rst | 5 ++++-
 drivers/misc/fs_loader.c                        | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/doc/develop/driver-model/fs_firmware_loader.rst b/doc/develop/driver-model/fs_firmware_loader.rst
index 149b8b436e..410cc1442d 100644
--- a/doc/develop/driver-model/fs_firmware_loader.rst
+++ b/doc/develop/driver-model/fs_firmware_loader.rst
@@ -98,8 +98,11 @@ through the U-Boot environment variable during run time.
 
 For examples:
 
+fw_storage_interface:
+  Firmware storage interface, it can be "mmc", "usb", "sata" or "ubi".
 storage_interface:
-  Storage interface, it can be "mmc", "usb", "sata" or "ubi".
+  Storage interface, it can be "mmc", "usb", "sata" or "ubi". This acts
+  as a fallback if fw_storage_interface is not set.
 fw_dev_part:
   Block device number and its partition, it can be "0:1".
 fw_ubi_mtdpart:
diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 1ffc199ba1..3798dab5b6 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -153,7 +153,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
 	int ret;
 
-	storage_interface = env_get("storage_interface");
+	storage_interface = env_get("fw_storage_interface");
+	if (!storage_interface)
+		storage_interface = env_get("storage_interface");
+
 	dev_part = env_get("fw_dev_part");
 	ubi_mtdpart = env_get("fw_ubi_mtdpart");
 	ubi_volume = env_get("fw_ubi_volume");
-- 
2.34.1

