Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDA1C2FC29
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E7586B77;
	Thu, 17 Aug 2023 15:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=de.bosch.com header.i=@de.bosch.com header.b="FC1qp2H1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C19F86B87; Thu, 17 Aug 2023 15:47:16 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FDB586B69
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Thomas.Mittelstaedt@de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odxi0rkfx2rW8G7gVBhxxHgTIo2HFKLLyNE85aAPZCigKBUeOB2H4H5y7RLaf/4Uq9THk+bJ3qlemb2M1WW9IAo6agkZ/01P5nKV3A8BLKcUqoCq0nCaOpZ8AHE38/nNm1zsTUTFIWgfnHvpeY5FdrvrwxiYhJ5/z2N9cu91hBVBHungVL3I5bgvTgXfqgjRbaXo6Vt9GlDvhg61f+w1isb6wEJ1GGUBfwzLFBlfWQz2kIA/LpWHmFv/ZGfgj8rZiYsBzs38810CgkWpZxL3zC/poj0LmexZJlX+qs9di+MFUwoG5Sqcxx+CmhJ1XiTTiK0ryDuW3JVktkPF92n7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXDCFzehC2v7bAADpMFnqrp7PLjgA3/kmCTQWboGlrs=;
 b=czQKPou/uVWABGlruGPQSEvEf770sAeJbN1DSwr3g2jgEKi77prhCZGZW5rlGaUsZihM5Y+R7qRmh/kaifHgJGGo+o4+e+zHqZxMICYuNwxtYvzrHMB+4lWIxgcRUgqXqAbdS3BHjCDgXykAkkglJAYv29Cox+9MNlaotuHzRe0KlUhjbT7+JBr/X9ptW+a39Q/A3bX0zaBTDKakTIUwFB1SwCv1vqciV5u++mcZZL1kfitsOOBRzHYmVwqKOcr5bca6eYXg17aESBGFB9EFHTuptL6TjUAahnpo9BsUxmCCwjeHr7oEn0EZDJS1jj1ediTnrKq+05dhKy81xPrP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.201) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXDCFzehC2v7bAADpMFnqrp7PLjgA3/kmCTQWboGlrs=;
 b=FC1qp2H16r+RC1t6AuWG6I+ZvrwUcgl0BhSrv3slpEnm8bLpGgxYDMjHPohwnrV7EMQvrp953korSTwhzbKWr2ZvAO3Si2MMEuf4NDNTx3rdbki6KMoh3If+ARCYaHEYAVn3iEKlfICV411HL9S9G1LlhtxhKZsxvvEeVCcDPQN/Q+dVkEmi6B6n4v6wqpeJ+16+g54iqS0ccOSHc3eyTK7nXELAOIsffVZvKpfxmrmoobfUm1Gm6eqyCxu9X5YHm99CEimeQIxmUQEXTqdSopzZ9xwCaFN4z1U9nLCPpdE1SB0sF14mWMratOgv7CkrfawLLeqFpLh4kKFl7SOmmg==
Received: from DU2PR04CA0069.eurprd04.prod.outlook.com (2603:10a6:10:232::14)
 by GV2PR10MB6982.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 13:47:09 +0000
Received: from DBAEUR03FT065.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:232:cafe::6b) by DU2PR04CA0069.outlook.office365.com
 (2603:10a6:10:232::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 13:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.201)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.201 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=139.15.153.201; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.201) by
 DBAEUR03FT065.mail.protection.outlook.com (100.127.142.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.17 via Frontend Transport; Thu, 17 Aug 2023 13:47:09 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 15:47:08 +0200
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.31; Thu, 17 Aug 2023 15:47:08 +0200
Received: from localhost.localdomain (10.141.98.21) by FE-HUB2000.de.bosch.com
 (10.4.103.109) with Microsoft SMTP Server id 15.1.2507.31;
 Thu, 17 Aug 2023 15:47:08 +0200
From: <thomas.mittelstaedt@de.bosch.com>
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/1] Documentation extended with specific information for
 VirtualBox
Date: Thu, 17 Aug 2023 13:46:47 +0000
Message-ID: <20230817134647.49259-2-thomas.mittelstaedt@de.bosch.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230817134647.49259-1-thomas.mittelstaedt@de.bosch.com>
References: <20230817134647.49259-1-thomas.mittelstaedt@de.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.141.98.21]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAEUR03FT065:EE_|GV2PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d72053b-18b6-48f3-a8f6-08db9f2873f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cit1Vw+DTMXRvoZ840yrmPE3SjTFe1dM7PsDOjV0bUcjYN2ZVznW6WUszHf9sbXAWMYzFrOzRW9ozdJuKxb6Ry257B/9rteUs61xc4kDbHZTFI0JokouSWR2KvqjQ7o2SfvZSNeGEBUBJTEjU/jbpbfv1H887Oz5PjRmUWs2V+0gSyoezrJdzVy8pkEUO8h6EI7YJ6inJSdOiJyDDlMAv0NZlDS4w+vgaXKXGRZkU9erygv4/9rHMiZtVr856WzmEjPW41Y7xLRTXEHEvPPxbbRnF6Y6VB7CNnxvBwS6PgF6Ff8hHwmiY/mHudd7NUlnlIwSEcI7CT+8b79lKgDzR1TYSNf5OVLTmp7wudvzRImYd+t4CLD0zabCgSQtydSxIiw6gBETmY2Hb7VJ8azk7wRJJO7XhO/kz2JFN2FH3k5Bu057ovjzMXsQ2eP1LnL7W3bQO81Inh3+OOMRpmL7r2plIfsBYOo/ecIQAN2hFVKQOWNZG6a2mweKmuBMuWwFvyWMUJ+9/pUUF1F/vFvno/C+V5b58uk+9B4WqL9A7U7MgSMHN1yAXHBfrdEby99rIJcDlQpOx+c9PK2O831Ecph7yImAYk4GhritLLOtmAM1uzHQxo7nsDQDSABQe7nI6RB0Fndtdm1Lg99CipnyT5KF0a7V27+2uQZbAQ/AkGSZ/Iaoi5lg94lxBnrz5fNrrO2agGdhhFsff9cQJpZXB9OePdSW4mfqcjeYS7Q7j/vftaveVlca9FSu/gAOhBPyOhV3nx/2Dv/9n801jDfaHY8dwHxjl7A8C3rs9ICqo7TwKk5c33383KjrvaD/6Hz6tHte9gaKe96qKdYALySNJrknAiiekMj9tPb2J07ORF8=
X-Forefront-Antispam-Report: CIP:139.15.153.201; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:eop.bosch-org.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(26005)(86362001)(40480700001)(336012)(478600001)(426003)(6666004)(2616005)(1076003)(16526019)(2876002)(5660300002)(36860700001)(41300700001)(82740400003)(356005)(316002)(54906003)(70586007)(70206006)(81166007)(6916009)(4326008)(8676002)(8936002)(82960400001)(47076005)(36900700001)(139555002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:47:09.4663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d72053b-18b6-48f3-a8f6-08db9f2873f3
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4; Ip=[139.15.153.201];
 Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT065.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6982
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
 doc/develop/uefi/u-boot_on_efi.rst | 76 ++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index acad6397e8..927e1dc266 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -254,6 +254,82 @@ This shows running with serial enabled (see `include/configs/efi-x86_app.h`)::
 
    => QEMU: Terminated
 
+Run at VirtualBox (x86)
+--------------------------
+
+Enable EFI
+~~~~~~~~~~~~
+At settings for virtual machine the flag at **System->Motherboard->Enable EFI (special OSes only)** has to be enabled.
+
+Installation
+~~~~~~~~~~~~
+Install the needed system at a VDI disk and connect this to SATA controller (type AHCI) at settings
+for virtual machine at **System->Storage->Controller:SATA**.
+
+For the following description 3 partitions are assumed:
+
+- Partition 1: formatted as **vfat**, used for U-Boot and and its environment filesenvironment, flag **boot** set
+- Partition 2: formatted as **ext2/ext4**, used for Linux image and boot configuration, flag **boot** set
+- Partition 3: formatted as **ext4**, used for root file system
+
+Create an extlinux.conf or a boot script
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Following files are assumed to be located at system for boot configuration::
+
+ Partition  File                    Comment
+ 1          EFI/BOOT/BOOTX64.efi    # renamed U-Boot EFI image
+ 2          Image                   # Linux image 
+ 2          Initrd                  # Initramfs of Linux
+
+Boot script
+~~~~~~~~~~~
+
+The boot script **boot.scr** is assumed to be located at::
+
+ Partition  File        Comment
+ 2          boot.scr    # Boot script, generated with mkimage from template 
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
+Alternatively a configuration **extlinux.conf** can be used. **extlinux.conf** is assumed to be located at::
+
+ Partition  File                        Comment
+ 2          extlinux/extlinux.conf      # Extlinux boot configuration
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
+	append  root=/dev/sda3 console=tty0 console=ttyS0,115200n8 rootwait rw
+
+
 
 Future work
 -----------
-- 
2.30.2

