Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE717EE49A4
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 13:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D588F86422;
	Tue, 22 Aug 2023 15:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=de.bosch.com header.i=@de.bosch.com header.b="iSNxw8ef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C525864A0; Tue, 22 Aug 2023 15:49:27 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0999B8641F
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 15:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Thomas.Mittelstaedt@de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDvD/w8tm7izfBCfI2Y88MiF9K3un0h7pnegPKdsPekdakcDeOdVlR2E4lbACacxP+DssVGK9TjIlqQ8pDAwg6DcU4xOAzV7nQxA3uraKyO0isQ9vtzM+zLOf9LQfVGr/zZkUhg1PZvggzuOU1s0Q/PQy5sUnrICKbdAI/MNblIvO91s79tFAA0EEOaUBTpBqzV3XjPXaOVAsSaAK0+yO2BfoUGWmhfDQsFWaChkgm0bMqJFD2Ifx4Uw1nOjGZ80CaR0KD6j+D+Y9TPFJyj38hAxgIhOUIi8DG7Dd57ClhKwEXy+9NVIRHmpuNS3qja9CJ6awf5l/2F40TLRRRXeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3r0Fqu7Mj3ZRCr5FuCzWOkEGUw/YV8JTguMiZsJR18=;
 b=E+KacKMkVJEoPbUWsHWsb2YWdTYATy2CwQiPj/IT0MrSus4p+lPIAVd5SpZur2q594M/kvhiiD/GYaeX9DlB+01bFYqD+AyHC5Fl91UOln+mY/YLEId9fxN0oliTKTQWbBqSSEuKpfkwH3MplnC4WFHgeQF7xfTwPPclK1cSreVQZtKSrpnI2I0Nxgk9nXFUQjAJckdKvHHXfCG4M1Mc8i5k54TaeabG8ZOcD2IPiK5BDoeIgJZfKB9BLwnTxqNHrCVYxb+hB6RibO8R48W6GGDHsa8sdqRqVNUCR+0BSGlwbUGTkP/a/scYuz81L4+Mv/Ok4t3dF0sWCdRpycHj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.201) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3r0Fqu7Mj3ZRCr5FuCzWOkEGUw/YV8JTguMiZsJR18=;
 b=iSNxw8efI8ku51JFP2gZXs0Jwc8VCl1RUlZFahSccxbUbLl/vv95N29aOJaW+Iqyzri9fd0MGdzHdg/HwWcHslWoAzD9YLRtAfuCQz7nKI+GToR055j+xAwGy8LOQ9/DkKQ0af9+gvT9ckiS4rV3qpo7H2UsOqFfbpTkvOwwJKjDRlaSgR9DZLwrazkiZ28QCvhMoOibH4xyUihp/V0DYJbp2WcJhYEAswaOA72IKZkwV52DuRQtkFDDkBUdnEf2DYvZHMPABfTfDfdeC+tIY4unD9FpGE7tfMqTJFv+ZTJrWsyUzUpVLVgm0rZgb1IAs6+aP9NmcKW58PUlq5FZ2g==
Received: from AM6PR0502CA0063.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::40) by AM0PR10MB3618.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:153::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 13:49:23 +0000
Received: from AM7EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::12) by AM6PR0502CA0063.outlook.office365.com
 (2603:10a6:20b:56::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Tue, 22 Aug 2023 13:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.201)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.201 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=139.15.153.201; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.201) by
 AM7EUR03FT019.mail.protection.outlook.com (100.127.140.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.15 via Frontend Transport; Tue, 22 Aug 2023 13:49:23 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 15:49:17 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.31; Tue, 22 Aug 2023 15:49:17 +0200
Received: from localhost.localdomain (10.34.189.209) by
 SI-HUB2000.de.bosch.com (10.4.103.108) with Microsoft SMTP Server id
 15.1.2507.31; Tue, 22 Aug 2023 15:49:16 +0200
From: <thomas.mittelstaedt@de.bosch.com>
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 1/1] Documentation extended with specific information for
 VirtualBox
Date: Tue, 22 Aug 2023 13:49:02 +0000
Message-ID: <20230822134902.33032-2-thomas.mittelstaedt@de.bosch.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230822134902.33032-1-thomas.mittelstaedt@de.bosch.com>
References: <20230822134902.33032-1-thomas.mittelstaedt@de.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.34.189.209]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7EUR03FT019:EE_|AM0PR10MB3618:EE_
X-MS-Office365-Filtering-Correlation-Id: d688da44-3090-4f10-f42b-08dba31697c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhfXDJR7lcWc9ekcfBBYIW/xmv4knd7ClBav3Ys/Rm/b7c4s5wVxFo6PYI3vqImZML7VBTUw6o8Ii52riEyUG8wf4GBeJk6LHaxQFkjIfbfUz5RhxFTQKdO6/dQwgAa7KhT9E9KaCGd86ts4o6IznBJ3BO9KCxkGeiIFjaVV/CrjNvdI87K7mnC8HJkkROKLtnHjsO7Ngd544/OBE+SxC5b+L2sJk9dajCzhu4EDesc97jIDyVPqb/P83fHkfE8XVHthmi3bTD96mEo/OqDrLtLc9zx3iftRQtkPLo/i5PlpGcb1NTj2zVQZEILXi1XTUpHBHHB2G7Gt/K7q0FwJRAZVCS7maFkWAHWn6qmb8a9BTmO/iGrD100kGE88iHgQezNzW3symerlWzMPbprqINVvAAC8mU6PVjJUKCy7uxleWFd07AjBYeSP+eh53u20tQECx6gl3iPN4w3F085lfd5azIDuNtQi3Oo0O/D4gHOPOaEpIvWElZqEye1n4QjhbiqIkusHUp8QoRbVmXnlYASNDpC+rNErm6MRK3W+sFV6FeSjAvZ0VwkVS3nPbDJAZFZfvJDJ2mqSePGLAm3wuKW5CG1eD3lBVJc8LYYulTdBK5Hynh0aZELOw8WjfUsElb8WjKXVpVGgmp+2UFK6cuosdsHbwvB5xrL48L5ol94agyWbXo0miTeLBJp30fVHCCMfXxNhQGvlubw5RIxiuJo0iZFXK2GtTBbT/pjA5Sv5HOfd+pZWQZVvV/E+2seYMH2Cv7CHvEtB3r6MrZv8ISzdZdWZe4MpmRVVarreTaerEmqzxZmx0++dkXTxifIJI3pYud7V8YTXkqvMD4BTorZ5yZ1VIlpi+qXlAms37UE=
X-Forefront-Antispam-Report: CIP:139.15.153.201; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:eop.bosch-org.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(2906002)(40480700001)(83380400001)(5660300002)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(2876002)(8676002)(2616005)(8936002)(4326008)(316002)(70586007)(6916009)(54906003)(70206006)(82960400001)(478600001)(356005)(82740400003)(81166007)(6666004)(40460700003)(1076003)(41300700001)(36900700001)(139555002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 13:49:23.3322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d688da44-3090-4f10-f42b-08dba31697c9
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4; Ip=[139.15.153.201];
 Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3618
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

The configuration for EFI is enhanced to start U-Boot at VirtualBox (x86_64)
with all features like booting with help of boot scripts and extended linux.
This documentation describes how to use U-Boot at VirtualBox to boot
Linux systems with a some simple example.

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

