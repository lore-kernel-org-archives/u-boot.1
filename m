Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914D2C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 12:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 719F487C54;
	Wed, 24 Jan 2024 13:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GUmRoc5h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 929B387BED; Wed, 24 Jan 2024 07:49:57 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 761BE87BDF
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 07:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40O6ndBt022622;
 Wed, 24 Jan 2024 00:49:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706078979;
 bh=FdY4qktSEf3DFpp/RpFHrp96Gh1NM80MBoVuWecQ1Cc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=GUmRoc5hikjmCvKUagR4eE+wgUbtjngkX9XyXqMjPIRPPiSZaZzFD8gbBp8HhULTf
 44r8piLCCT0vQfN4nQrvZ8wdb8okUyd6pwzEhHd0bjAVnwubjSQu2BCAgdgdRdSJoI
 n8JbqbjuZgEfUlpu/st3lx4zNyjpjkhu5Mv4NSJg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40O6nd2w104951
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 00:49:39 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 00:49:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 00:49:39 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40O6ndFi071249;
 Wed, 24 Jan 2024 00:49:39 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40O6ncqd024468;
 Wed, 24 Jan 2024 00:49:39 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, Bryan Brattlof
 <bb@ti.com>, Sean Anderson <seanga2@gmail.com>, Martyn Welch
 <martyn.welch@collabora.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Simon
 Glass <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH v3 02/15] misc: fs-loader: Use fw_storage_interface
 instead of storage_interface
Date: Wed, 24 Jan 2024 12:19:17 +0530
Message-ID: <20240124064930.1787929-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124064930.1787929-1-danishanwar@ti.com>
References: <20240124064930.1787929-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 24 Jan 2024 13:42:05 +0100
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

