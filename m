Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14BECCF9F0
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 08:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 144D2832BC;
	Wed, 29 Oct 2025 09:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1178352B; Wed, 29 Oct 2025 09:23:53 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F756800B1
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 09:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 59T8NjCf086320
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 16:23:45 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Oct
 2025 16:23:45 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH 1/1] falcon: support booting linux from MMC/Parallel Flash
Date: Wed, 29 Oct 2025 16:23:28 +0800
Message-ID: <20251029082328.3421001-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 59T8NjCf086320
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

From: Randolph <randolph@andestech.com>

To support booting Linux from MMC, the file name should be
set up correctly. To support booting Linux from Parallel Flash,
the SPL_LOAD_FIT_ADDRESS should point to the Parallel Flash.


Signed-off-by: Randolph <randolph@andestech.com>
---
 common/spl/Kconfig                      | 1 +
 configs/ae350_rv32_falcon_xip_defconfig | 3 ++-
 configs/ae350_rv64_falcon_xip_defconfig | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 24d6ce5d739..6e463a668d1 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -787,6 +787,7 @@ config SPL_FS_LOAD_PAYLOAD_NAME
 	string "File to load for U-Boot from the filesystem"
 	depends on SPL_FS_EXT4 || SPL_FS_FAT || SPL_FS_SQUASHFS || SPL_SEMIHOSTING
 	default "tispl.bin" if SYS_K3_SPL_ATF
+	default "linux.itb" if SPL_LOAD_FIT_OPENSBI_OS_BOOT
 	default "u-boot.itb" if SPL_LOAD_FIT
 	default "linux.itb" if SPL_LOAD_FIT_OPENSBI_OS_BOOT
 	default "u-boot.img"
diff --git a/configs/ae350_rv32_falcon_xip_defconfig b/configs/ae350_rv32_falcon_xip_defconfig
index 2355bac5019..63cd37e4bdb 100644
--- a/configs/ae350_rv32_falcon_xip_defconfig
+++ b/configs/ae350_rv32_falcon_xip_defconfig
@@ -18,7 +18,8 @@ CONFIG_SPL_XIP=y
 CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80010000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x88600000
+CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_SYS_PBSIZE=1050
diff --git a/configs/ae350_rv64_falcon_xip_defconfig b/configs/ae350_rv64_falcon_xip_defconfig
index 8e1b8e20052..4ed636d9714 100644
--- a/configs/ae350_rv64_falcon_xip_defconfig
+++ b/configs/ae350_rv64_falcon_xip_defconfig
@@ -18,7 +18,8 @@ CONFIG_SPL_XIP=y
 CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x80010000
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x88600000
+CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_SYS_PBSIZE=1050
-- 
2.34.1

