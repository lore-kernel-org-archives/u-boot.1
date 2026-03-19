Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90B8109024D
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 16:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF1283FC5;
	Thu, 19 Mar 2026 17:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dxrgSZ0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D3D183FC0; Thu, 19 Mar 2026 17:33:50 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DBC583FC0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 17:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d74dbfe84cso772882a34.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773938025; x=1774542825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DLoaJz9do0jr/wdBMEqniDk8ErotERZa5k5Ry/kFP8Y=;
 b=dxrgSZ0g0zTpT+H4YuljQbrmZcu02fugd5SUTLYblXuO8Sf0dUvwlNcLie8ijtny73
 HzMWNhHq4Pli91bgMCI6+es8twkJSbrDjTeXd6Se2Glib+vV+1LSQKHudF8ubdoloolw
 QIa9ZoaIFdlo9YtBtYmvadxybKe0S3fE6QXK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773938025; x=1774542825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLoaJz9do0jr/wdBMEqniDk8ErotERZa5k5Ry/kFP8Y=;
 b=rrF+NcJand5mr8+JjPIAtsCMKuvJD0EXrNm4rdlctqS4SPd0SgXqhCeU6qWQpNP7Fv
 lkIpSAe7ZuYUYF4wx8jgg3X1iP4sZaE4mqqHM14RsC/t+S+I6h32W2/QfrUrkLbtIwzb
 g6WWnim+iNXg49HyaxwOh0s+iq67X9hgFphV2ZsojI97AVfbKb6Ui8pUnqsGcaTowhUe
 2zGH3qIgqzoFzkX3Cz9uiKhkKw6ydk8/vWBqbz+p4V7uTyVqtxgXWtyUOetGYlluFhsh
 3WPumvUXZXV/EBz583sRP2XpER4USJskIRU31VxN7l6JLpR1QxWf3BPz4hS6h/eVexnj
 /cDQ==
X-Gm-Message-State: AOJu0YyKmeWCbf9lkQgMGKH7ihinnQnqyu1V+RTSXFp3avhEU8uzt87s
 eMveAgiFsiy3ttToRU0RSc/fTDkFfqRVbbp04QxqibJMc1gi9qc8X38phTv2YOslBTW57i3MGrs
 JMZNZdRo=
X-Gm-Gg: ATEYQzwS3FPu9mCQsqbWv/F2IOJqDvJewCKdHIZKOEWsOGsBA9t4vnI6MDALdk02oJx
 llceXnpQ7c5sGtrGptfAP+zO5UHK8rsmtyPyuSi1WhF4Nlt/YVIVLu5D7SYVhFS5C4uOaQ5TeYJ
 HUqeVr/wcQVIRBcPIQ7bjoxV27h2xTJF0N4X5w4ZOAcSJHAFu4PnBREjqtbBJd8pJ0Ccittg9rL
 wAVIXvDSdCJawR/LJSyfjLWYOZYuudElYD9Rk2FRUw4TQuF3sbl8o2EizwNTpetDPdR7DVoU596
 LpPTl4xx+aFmE0ep3LVK2kPl0cUJIrhTbnWGgSGDPePENORZcPGpNdiod+gttam7q0CxF3ILtlr
 LuURupti0Wi1EuCwXUIiYTOvWYl/oleFhTM8d3AVc66jwRKo0TB+Hc/EIPBYiNvPbZ+VFg/7QJk
 O3CO2HGBzo7+aiw7V7FqDJAwlEuj8BpGBhIhcXajx/6L5ORGn92H79hVOR7Zw0pys9YwlKzcsAI
 2mi/nN7U67NA1MIU6PyHvb6x0kXz7dAa3tNs/NND7/aZomp/0Y=
X-Received: by 2002:a05:6830:6ac7:b0:7d7:e709:3a7f with SMTP id
 46e09a7af769-7d7e7094379mr883604a34.23.1773938024858; 
 Thu, 19 Mar 2026 09:33:44 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7cb5af492sm4230651a34.24.2026.03.19.09.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 09:33:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michael Walle <mwalle@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 Ashish Kumar <Ashish.kumar@nxp.com>, Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH] serial: Enable SYS_NS16550 on incorrectly migrated platforms
Date: Thu, 19 Mar 2026 10:33:43 -0600
Message-ID: <20260319163343.1679919-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

With the migration to DM_SERIAL in commit 191b10ac70d7 ("PowerPC /
Layerscape: Finish migration to DM_SERIAL") a number of platforms were
incorrectly migrated and did not enable SYS_NS16550 despite previously
having enabled the non-DM NS16650 serial driver. Enable these now.

Fixes: 191b10ac70d7 ("PowerPC / Layerscape: Finish migration to DM_SERIAL")
Reported-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Vladimir Oltean <olteanv@gmail.com>
Cc: Ashish Kumar <Ashish.kumar@nxp.com>,
Cc: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 configs/MPC8548CDS_36BIT_defconfig                  | 1 +
 configs/MPC8548CDS_defconfig                        | 1 +
 configs/MPC8548CDS_legacy_defconfig                 | 1 +
 configs/P1010RDB-PA_36BIT_NOR_defconfig             | 1 +
 configs/P1010RDB-PA_NOR_defconfig                   | 1 +
 configs/P1010RDB-PB_36BIT_NOR_defconfig             | 1 +
 configs/P1010RDB-PB_NOR_defconfig                   | 1 +
 configs/P1020RDB-PC_36BIT_defconfig                 | 1 +
 configs/P1020RDB-PC_defconfig                       | 1 +
 configs/P1020RDB-PD_defconfig                       | 1 +
 configs/P2020RDB-PC_36BIT_defconfig                 | 1 +
 configs/P2020RDB-PC_defconfig                       | 1 +
 configs/P2041RDB_NAND_defconfig                     | 1 +
 configs/P2041RDB_SDCARD_defconfig                   | 1 +
 configs/P2041RDB_SPIFLASH_defconfig                 | 1 +
 configs/P2041RDB_defconfig                          | 1 +
 configs/T2080QDS_SECURE_BOOT_defconfig              | 1 +
 configs/T2080QDS_SRIO_PCIE_BOOT_defconfig           | 1 +
 configs/T2080QDS_defconfig                          | 1 +
 configs/ls1012a2g5rdb_tfa_defconfig                 | 1 +
 configs/ls1012afrdm_tfa_defconfig                   | 1 +
 configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig       | 1 +
 configs/ls1012afrwy_tfa_defconfig                   | 1 +
 configs/ls1012aqds_tfa_SECURE_BOOT_defconfig        | 1 +
 configs/ls1012aqds_tfa_defconfig                    | 1 +
 configs/ls1012ardb_tfa_SECURE_BOOT_defconfig        | 1 +
 configs/ls1012ardb_tfa_defconfig                    | 1 +
 configs/ls1021aiot_qspi_defconfig                   | 1 +
 configs/ls1021aqds_nor_SECURE_BOOT_defconfig        | 1 +
 configs/ls1021aqds_qspi_defconfig                   | 1 +
 configs/ls1021atsn_qspi_defconfig                   | 1 +
 configs/ls1021atwr_nor_SECURE_BOOT_defconfig        | 1 +
 configs/ls1021atwr_qspi_defconfig                   | 1 +
 configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig | 1 +
 configs/ls1043aqds_tfa_SECURE_BOOT_defconfig        | 1 +
 configs/ls1043aqds_tfa_defconfig                    | 1 +
 configs/ls1046aqds_tfa_SECURE_BOOT_defconfig        | 1 +
 configs/ls1046aqds_tfa_defconfig                    | 1 +
 configs/ls2080aqds_qspi_defconfig                   | 1 +
 39 files changed, 39 insertions(+)

diff --git a/configs/MPC8548CDS_36BIT_defconfig b/configs/MPC8548CDS_36BIT_defconfig
index e9e4fe28f9af..bc42068a3e0e 100644
--- a/configs/MPC8548CDS_36BIT_defconfig
+++ b/configs/MPC8548CDS_36BIT_defconfig
@@ -104,4 +104,5 @@ CONFIG_TSEC_ENET=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_ADDR_MAP=y
diff --git a/configs/MPC8548CDS_defconfig b/configs/MPC8548CDS_defconfig
index 182b395462f6..bf1d82b37056 100644
--- a/configs/MPC8548CDS_defconfig
+++ b/configs/MPC8548CDS_defconfig
@@ -103,3 +103,4 @@ CONFIG_TSEC_ENET=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
diff --git a/configs/MPC8548CDS_legacy_defconfig b/configs/MPC8548CDS_legacy_defconfig
index 65ebb6c341c9..05937a986214 100644
--- a/configs/MPC8548CDS_legacy_defconfig
+++ b/configs/MPC8548CDS_legacy_defconfig
@@ -103,3 +103,4 @@ CONFIG_TSEC_ENET=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
diff --git a/configs/P1010RDB-PA_36BIT_NOR_defconfig b/configs/P1010RDB-PA_36BIT_NOR_defconfig
index 4797994a0726..98006672dd4a 100644
--- a/configs/P1010RDB-PA_36BIT_NOR_defconfig
+++ b/configs/P1010RDB-PA_36BIT_NOR_defconfig
@@ -97,6 +97,7 @@ CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PA_NOR_defconfig b/configs/P1010RDB-PA_NOR_defconfig
index e5ccb437398f..299c39983e79 100644
--- a/configs/P1010RDB-PA_NOR_defconfig
+++ b/configs/P1010RDB-PA_NOR_defconfig
@@ -96,6 +96,7 @@ CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PB_36BIT_NOR_defconfig b/configs/P1010RDB-PB_36BIT_NOR_defconfig
index 60e1cea9f8aa..bcdf6bbc5381 100644
--- a/configs/P1010RDB-PB_36BIT_NOR_defconfig
+++ b/configs/P1010RDB-PB_36BIT_NOR_defconfig
@@ -99,6 +99,7 @@ CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PB_NOR_defconfig b/configs/P1010RDB-PB_NOR_defconfig
index 819d54b1b35a..2035703b8585 100644
--- a/configs/P1010RDB-PB_NOR_defconfig
+++ b/configs/P1010RDB-PB_NOR_defconfig
@@ -98,6 +98,7 @@ CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1020RDB-PC_36BIT_defconfig b/configs/P1020RDB-PC_36BIT_defconfig
index eb8e4e5d0c9d..45a9deae440f 100644
--- a/configs/P1020RDB-PC_36BIT_defconfig
+++ b/configs/P1020RDB-PC_36BIT_defconfig
@@ -110,6 +110,7 @@ CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1020RDB-PC_defconfig b/configs/P1020RDB-PC_defconfig
index e7740064d2bb..760e6a6a1c48 100644
--- a/configs/P1020RDB-PC_defconfig
+++ b/configs/P1020RDB-PC_defconfig
@@ -109,6 +109,7 @@ CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1020RDB-PD_defconfig b/configs/P1020RDB-PD_defconfig
index a24aae421036..e65511258481 100644
--- a/configs/P1020RDB-PD_defconfig
+++ b/configs/P1020RDB-PD_defconfig
@@ -112,6 +112,7 @@ CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2020RDB-PC_36BIT_defconfig b/configs/P2020RDB-PC_36BIT_defconfig
index 8be6d91e5fdf..77eca7dd8512 100644
--- a/configs/P2020RDB-PC_36BIT_defconfig
+++ b/configs/P2020RDB-PC_36BIT_defconfig
@@ -115,6 +115,7 @@ CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2020RDB-PC_defconfig b/configs/P2020RDB-PC_defconfig
index 95e004b4b446..46bf6f18b725 100644
--- a/configs/P2020RDB-PC_defconfig
+++ b/configs/P2020RDB-PC_defconfig
@@ -114,6 +114,7 @@ CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2041RDB_NAND_defconfig b/configs/P2041RDB_NAND_defconfig
index a23570e84b7c..1bef841990fe 100644
--- a/configs/P2041RDB_NAND_defconfig
+++ b/configs/P2041RDB_NAND_defconfig
@@ -104,6 +104,7 @@ CONFIG_MII=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_NAND=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2041RDB_SDCARD_defconfig b/configs/P2041RDB_SDCARD_defconfig
index 1ed3a8f72fd0..ad04e2a1172e 100644
--- a/configs/P2041RDB_SDCARD_defconfig
+++ b/configs/P2041RDB_SDCARD_defconfig
@@ -99,6 +99,7 @@ CONFIG_MII=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_MMC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2041RDB_SPIFLASH_defconfig b/configs/P2041RDB_SPIFLASH_defconfig
index 3d47b002b5b1..1b7389178be3 100644
--- a/configs/P2041RDB_SPIFLASH_defconfig
+++ b/configs/P2041RDB_SPIFLASH_defconfig
@@ -101,6 +101,7 @@ CONFIG_MII=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_SPIFLASH=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2041RDB_defconfig b/configs/P2041RDB_defconfig
index 1511fd7710c1..b6c28db4f10f 100644
--- a/configs/P2041RDB_defconfig
+++ b/configs/P2041RDB_defconfig
@@ -96,6 +96,7 @@ CONFIG_MII=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_NOR=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080QDS_SECURE_BOOT_defconfig b/configs/T2080QDS_SECURE_BOOT_defconfig
index 631789b05858..d1785f5e21f1 100644
--- a/configs/T2080QDS_SECURE_BOOT_defconfig
+++ b/configs/T2080QDS_SECURE_BOOT_defconfig
@@ -110,6 +110,7 @@ CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_NOR=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080QDS_SRIO_PCIE_BOOT_defconfig b/configs/T2080QDS_SRIO_PCIE_BOOT_defconfig
index 841f72ed73dc..440adb1663be 100644
--- a/configs/T2080QDS_SRIO_PCIE_BOOT_defconfig
+++ b/configs/T2080QDS_SRIO_PCIE_BOOT_defconfig
@@ -98,6 +98,7 @@ CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_REMOTE=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080QDS_defconfig b/configs/T2080QDS_defconfig
index 1eadcce3ba77..e5d141449e26 100644
--- a/configs/T2080QDS_defconfig
+++ b/configs/T2080QDS_defconfig
@@ -111,6 +111,7 @@ CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_NOR=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/ls1012a2g5rdb_tfa_defconfig b/configs/ls1012a2g5rdb_tfa_defconfig
index 32d95162e9b0..660dcffca724 100644
--- a/configs/ls1012a2g5rdb_tfa_defconfig
+++ b/configs/ls1012a2g5rdb_tfa_defconfig
@@ -56,6 +56,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_FSL_PFE=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls1012afrdm_tfa_defconfig b/configs/ls1012afrdm_tfa_defconfig
index a0081d9f0555..98cdbb46c2d1 100644
--- a/configs/ls1012afrdm_tfa_defconfig
+++ b/configs/ls1012afrdm_tfa_defconfig
@@ -55,6 +55,7 @@ CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig b/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
index 9ccd35ac2236..24ddbf783b29 100644
--- a/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
@@ -57,6 +57,7 @@ CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls1012afrwy_tfa_defconfig b/configs/ls1012afrwy_tfa_defconfig
index 70f051f76e8a..985d3e2b8f0f 100644
--- a/configs/ls1012afrwy_tfa_defconfig
+++ b/configs/ls1012afrwy_tfa_defconfig
@@ -60,6 +60,7 @@ CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
index 643814577ca8..84bd67e5a689 100644
--- a/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
@@ -73,6 +73,7 @@ CONFIG_DM_RTC=y
 CONFIG_RTC_PCF8563=y
 CONFIG_SCSI=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1012aqds_tfa_defconfig b/configs/ls1012aqds_tfa_defconfig
index e7f7031f42df..2fd6dff8452a 100644
--- a/configs/ls1012aqds_tfa_defconfig
+++ b/configs/ls1012aqds_tfa_defconfig
@@ -82,6 +82,7 @@ CONFIG_DM_RTC=y
 CONFIG_RTC_PCF8563=y
 CONFIG_SCSI=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
index bb9cf573cc2e..f0ec4cb3afca 100644
--- a/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
@@ -61,6 +61,7 @@ CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1012ardb_tfa_defconfig b/configs/ls1012ardb_tfa_defconfig
index 428fc58e2f31..c147f3a2b315 100644
--- a/configs/ls1012ardb_tfa_defconfig
+++ b/configs/ls1012ardb_tfa_defconfig
@@ -62,6 +62,7 @@ CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1021aiot_qspi_defconfig b/configs/ls1021aiot_qspi_defconfig
index 9353979a2e7c..8907227448ae 100644
--- a/configs/ls1021aiot_qspi_defconfig
+++ b/configs/ls1021aiot_qspi_defconfig
@@ -67,6 +67,7 @@ CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1021aqds_nor_SECURE_BOOT_defconfig b/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
index 3934d2598875..12b6e2e0e535 100644
--- a/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
+++ b/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
@@ -95,6 +95,7 @@ CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_SYS_QE_FW_ADDR=0x60940000
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/ls1021aqds_qspi_defconfig b/configs/ls1021aqds_qspi_defconfig
index 5b28997dbaa5..6306d04c43fa 100644
--- a/configs/ls1021aqds_qspi_defconfig
+++ b/configs/ls1021aqds_qspi_defconfig
@@ -83,6 +83,7 @@ CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1021atsn_qspi_defconfig b/configs/ls1021atsn_qspi_defconfig
index e36d336d84b1..37629d88c48a 100644
--- a/configs/ls1021atsn_qspi_defconfig
+++ b/configs/ls1021atsn_qspi_defconfig
@@ -68,6 +68,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1021atwr_nor_SECURE_BOOT_defconfig b/configs/ls1021atwr_nor_SECURE_BOOT_defconfig
index 503afd1847b4..09924a5a08b3 100644
--- a/configs/ls1021atwr_nor_SECURE_BOOT_defconfig
+++ b/configs/ls1021atwr_nor_SECURE_BOOT_defconfig
@@ -79,6 +79,7 @@ CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_SYS_QE_FW_ADDR=0x60940000
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/ls1021atwr_qspi_defconfig b/configs/ls1021atwr_qspi_defconfig
index f8c6d82887bb..5527659ef782 100644
--- a/configs/ls1021atwr_qspi_defconfig
+++ b/configs/ls1021atwr_qspi_defconfig
@@ -76,6 +76,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
index af4bb562b870..fdb44503ce19 100644
--- a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
@@ -113,6 +113,7 @@ CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_U_QE=y
 CONFIG_SYS_QE_FW_ADDR=0x940000
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
index 3d38f5841500..7384eb490f5a 100644
--- a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
@@ -97,6 +97,7 @@ CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls1043aqds_tfa_defconfig b/configs/ls1043aqds_tfa_defconfig
index e3fcdd37a40c..7a6a8c3fe2ad 100644
--- a/configs/ls1043aqds_tfa_defconfig
+++ b/configs/ls1043aqds_tfa_defconfig
@@ -105,6 +105,7 @@ CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
index 941224b5ac21..ff59d504ddee 100644
--- a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
@@ -98,6 +98,7 @@ CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_PCIE_LAYERSCAPE_EP=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1046aqds_tfa_defconfig b/configs/ls1046aqds_tfa_defconfig
index 191ab45aec03..77f8d6b53d4b 100644
--- a/configs/ls1046aqds_tfa_defconfig
+++ b/configs/ls1046aqds_tfa_defconfig
@@ -107,6 +107,7 @@ CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_PCIE_LAYERSCAPE_EP=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls2080aqds_qspi_defconfig b/configs/ls2080aqds_qspi_defconfig
index d07ca3217a2b..9141340b1638 100644
--- a/configs/ls2080aqds_qspi_defconfig
+++ b/configs/ls2080aqds_qspi_defconfig
@@ -91,6 +91,7 @@ CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_RTC_ENABLE_32KHZ_OUTPUT=y
 CONFIG_RTC_DS3231=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
-- 
2.43.0

