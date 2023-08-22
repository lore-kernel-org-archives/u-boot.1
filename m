Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C3EEE49AA
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A31864BC;
	Tue, 22 Aug 2023 14:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=de.bosch.com header.i=@de.bosch.com header.b="dJDDzPjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8964864D9; Tue, 22 Aug 2023 14:59:21 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B46E86386
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Thomas.Mittelstaedt@de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYX8t837P9V3Gt2RajGmh07+zAzw4owO8e+MA5zcm3cUw6MQuxVjy+kEvT6MDr7q1K9LckL5O4FMc+d1Q95E5HR7gg+fwii+gVmdW7ty9JH9pkeh07YnMyW+uPnYuHCr9Y4IneYQPdlcbOPQlyu2cR3L+BexAgs6DvlTkaYKFYYmBaAJJqPOk/CsVI8ELOaloBGh+fHbrkTA73rLgA8OGOq30jV/hk2KI2eONNdDFus7+oExOWs2SEkCIOg8dAcr4+sDo6FJLxKxJQOK3i3sPYQ5cCrrcXJvXOpyVK+yFrgwR3tZniB4W7x8bJvs4f8H4uu3K5p/Bu+wH/D1v4pKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyF/t7xh3fNtr/VcAth6AezLK/i5ATCLyEUGuMk0jog=;
 b=DONXCZYX5cDbCi/VrAZvS89JSfT3s79vsmLUafN//cmbrIMNlNQ06va+d5x2RxGkevjEbTcz/Xz6C3ytVLw+NxPPHy6BpxJzEw2XN1JOMyLJDsRHhZMk3X9VSM/YyE5dka5jQcgAVh7duw2W78fYf82mGYB40ZyVA4SmRhrgP32BHuis03F3quifYhX+csSCYtXrdbhX0VEIzZpqdwfPsWCC6SY3SoGvAjxTt2tJlOMpuZLyE51XnRQ/cS0wS44FP39hZEn5e7eINz8CFxL47NSyvpgnB0uzd6ZpoDu/p2WQlSUCIVjPStTZnEEgZrRh4aVtboWvA6KzcDKmjraHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.201) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyF/t7xh3fNtr/VcAth6AezLK/i5ATCLyEUGuMk0jog=;
 b=dJDDzPjqDod184OtCmcipEHLeHiigaufMQnnuzNCBV7nvRX5+uy0E9gpPT0ljWe/Q9H8kTgYo8njmhIR0W3J6CePOSfcGKm7g61uWuQjsTVK2qcbVlzVx9wHKiT0jL6+YQuH5pSd8n4U/z7GZ9mdTjOJ+JPvHcfoaCURuG0vIRpf0syGo+gcAevloYiXaWe5coaMeJN7H2PDXa2nHa0fLSPdewUPhijhJ6wAjBG01hrfIjMuDm+zGBPPMdjFoqwA8V0xsaRjDmxiinghQAdassVrbLwDpH6z4r7DVNgkNLjaqpO2PUdoBew8Y7tuz3af0Abrdpz3ml5rBfCK9hU4vA==
Received: from AS9PR06CA0594.eurprd06.prod.outlook.com (2603:10a6:20b:486::30)
 by AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 12:59:17 +0000
Received: from AM7EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:486:cafe::e0) by AS9PR06CA0594.outlook.office365.com
 (2603:10a6:20b:486::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 12:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.201)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.201 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=139.15.153.201; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.201) by
 AM7EUR03FT044.mail.protection.outlook.com (100.127.140.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.15 via Frontend Transport; Tue, 22 Aug 2023 12:59:17 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 14:59:14 +0200
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.31; Tue, 22 Aug 2023 14:59:14 +0200
Received: from localhost.localdomain (10.34.189.209) by
 FE-HUB2000.de.bosch.com (10.4.103.109) with Microsoft SMTP Server id
 15.1.2507.31; Tue, 22 Aug 2023 14:59:12 +0200
From: <thomas.mittelstaedt@de.bosch.com>
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 1/1] Documentation extended with specific information for
 VirtualBox
Date: Tue, 22 Aug 2023 12:58:58 +0000
Message-ID: <20230822125858.8018-3-thomas.mittelstaedt@de.bosch.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230822125858.8018-1-thomas.mittelstaedt@de.bosch.com>
References: <20230822125858.8018-1-thomas.mittelstaedt@de.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.34.189.209]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7EUR03FT044:EE_|AS1PR10MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: 053c4339-475d-4e01-a81c-08dba30f983f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4dZBOqNq7IMkOYN65o22/vQv3Oec2XtaKKTgvNqe0Zd8Fxeebntg2VCyE4ZOmJ7xR1inRhgWtWsDD+SSmkT4xIRt2x+Yjwq130coSBtxqs2v2/soHP9urbWHLRfmfa9dJMVrCbs6A3YtlLWzPxfJOZXl1z77PFN9OkDnsEfJ9TJd1c04C31M/to/Mhrc780xDFA0TeUq5V8Zq2ZbCS4yVPBx4wz7eJTrtRauFLfPTz3TuaOOGid+YDeLbqKc3G4lYY3ZmQRO239afJGo7m9OkDq0r6e2EkMn8qkZ4R3E+2XvQ34VMwKCJwQKPQmDPwBT6gvsQ1Rfr+We+C43Guoc6/GbKp4ALI06t/Jx1eQ48SNetUc1A92nI2rI3ldwM8Sc9Px48TZI2MY6DTrz++WdcjAnBloLcxROQM7r4r8fRDMDXgT9+humOZAFmQ5BW9GoAgaXpNY8mGDhRSaUQnBegRbKUSRYNc8Dziw48zpBfQEn52mt8owq2tGSyJHoY+SLKfHNIb3fq7b6nTqy6gyqBmZc5lcNnTDbc5QpruW83xbqdNYohytsdDTSNRpVxNXq9bZk7SOSh+RSryLoPZME1n+fCwxEgljelp5XrW4espzyVjMBAmC22HdYgRndrkrSnMKdpwMbWVHoLBeJExCpBhk+T1OBVYpVH4HTY+RQhIV2ujEc6MmkOBDjL3YzLBS0rcLBytsX8Wt67QAdjDOyKIJe0GYtdubSr31lLyp4SLh3m7/8+Whpx7HC6t+vNJPSawdz9p+d4UL2w44aqKoeyf67br7Dcf5EfVVBr9fZFuSRfngtJ2RQ9ImfvsNrOSAgC5wEvCN3+VCcUWXAyRu6Q==
X-Forefront-Antispam-Report: CIP:139.15.153.201; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:eop.bosch-org.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(6916009)(316002)(70586007)(70206006)(82960400001)(8676002)(8936002)(2616005)(4326008)(40460700003)(41300700001)(1076003)(82740400003)(356005)(81166007)(478600001)(6666004)(40480700001)(83380400001)(2906002)(86362001)(47076005)(2876002)(36860700001)(336012)(426003)(5660300002)(26005)(16526019)(36900700001)(139555002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 12:59:17.6265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 053c4339-475d-4e01-a81c-08dba30f983f
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4; Ip=[139.15.153.201];
 Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5675
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

From: Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>

Signed-off-by: Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
---
 doc/develop/uefi/u-boot_on_efi.rst | 84 ++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index acad6397e8..0d4927807c 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -254,6 +254,90 @@ This shows running with serial enabled (see `include/configs/efi-x86_app.h`)::
 
    => QEMU: Terminated
 
+Run on VirtualBox (x86_64)
+--------------------------
+
+Enable EFI
+~~~~~~~~~~
+At settings for virtual machine the flag at **System->Motherboard->Enable EFI
+(special OSes only)** has to be enabled.
+
+Installation
+~~~~~~~~~~~~
+Provide the preinstalled Linux system as a Virtual Disk Image (VDI) and assign
+it to a SATA controller (type AHCI) using the settings for the virtual machine
+at menu item **System->Storage->Controller:SATA**.
+
+For the following description three GPT partitions are assumed:
+
+- Partition 1: formatted as FAT file-system and marked as EFI system partition
+  (partition type 0xEF00) used for the U-Boot EFI binary. (If VirtualBox is UEFI
+  compliant, it should recognize the ESP as the boot partition.)
+
+- Partition 2: formatted as **ext4**, used for root file system
+
+Create an extlinux.conf or a boot script
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Following files are assumed to be located at system for boot configuration::
+
+ Partition  File                    Comment
+ 1          EFI/BOOT/BOOTX64.efi    # renamed U-Boot EFI image
+ 1          Image                   # Linux image
+ 1          Initrd                  # Initramfs of Linux
+
+**EFI/BOOT/BOOTX64.efi** is a renamed build result **u-boot-payload.efi**, built with
+**efi-x86_payload64_defconfig** configuration.
+
+Boot script
+~~~~~~~~~~~
+
+The boot script **boot.scr** is assumed to be located at::
+
+ Partition  File        Comment
+ 1          boot.scr    # Boot script, generated with mkimage from template
+
+Content of **boot.scr**:
+
+.. code-block:: bash
+
+  ext4load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} ${prefix}Image
+  setenv kernel_size ${filesize}
+  ext4load ${devtype} ${devnum}:${distro_bootpart} ${ramdisk_addr_r} ${prefix}Initrd
+  setenv initrd_size ${filesize}
+  zboot  ${kernel_addr_r} ${kernel_size} ${ramdisk_addr_r} ${initrd_size}
+
+Extlinux configuration
+~~~~~~~~~~~~~~~~~~~~~~
+
+Alternatively a configuration **extlinux.conf** can be used. **extlinux.conf**
+is assumed to be located at::
+
+ Partition  File                        Comment
+ 1          extlinux/extlinux.conf      # Extlinux boot configuration
+
+Content of **extlinux.conf**:
+
+.. code-block:: bash
+
+  default l0
+  menu title U-Boot menu
+  prompt 0
+  timeout 50
+
+  label l0
+    menu label Linux
+    linux /Image
+    initrd /Initrd
+
+
+Additionally something like (sda is assumed as disk device):
+
+.. code-block:: bash
+
+	append  root=/dev/sda2 console=tty0 console=ttyS0,115200n8 rootwait rw
+
+
 
 Future work
 -----------
-- 
2.30.2

