Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DE6C47258
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ADC187885;
	Thu, 11 Jan 2024 14:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="T6Ar4G+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E625687AAB; Thu, 11 Jan 2024 08:06:51 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CA8A876EA
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 08:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40B76U0A080935;
 Thu, 11 Jan 2024 01:06:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704956790;
 bh=FdY4qktSEf3DFpp/RpFHrp96Gh1NM80MBoVuWecQ1Cc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=T6Ar4G+QAHCtdTYNsmHv/G8XCjaZNBiOjPnnT9Y/TVocQz07dhMFKk15OZG1hF4MT
 2yD9PaPsYmrt5+pLzXe8e6+HjkPqAI9DOOxbXl4397Lj1oQZkCtQhnYvoVX+MiLsX5
 /7tFa0wJlsCDlKJAAyrIvmuRxkiikXVRahQQodEM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40B76Ujx039016
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 11 Jan 2024 01:06:30 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jan 2024 01:06:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Jan 2024 01:06:29 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40B76TXg085772;
 Thu, 11 Jan 2024 01:06:29 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40B76S8H017671;
 Thu, 11 Jan 2024 01:06:29 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Maxime Ripard <mripard@kernel.org>, Roger Quadros
 <rogerq@kernel.org>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, Sean Anderson
 <seanga2@gmail.com>, Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Nikhil M Jain
 <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis
 <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Simon Glass
 <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>, FUKAUMI Naoki
 <naoki@radxa.com>, Christian Hewitt <christianshewitt@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH v2 02/15] misc: fs-loader: Use fw_storage_interface
 instead of storage_interface
Date: Thu, 11 Jan 2024 12:35:58 +0530
Message-ID: <20240111070611.342701-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111070611.342701-1-danishanwar@ti.com>
References: <20240111070611.342701-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 11 Jan 2024 14:08:34 +0100
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
firmwares. The env storage_interface will act as fallback so that the
existing implementations do not break.

Also update the FS Loader documentation accordingly.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
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

