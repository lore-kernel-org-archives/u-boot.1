Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4734C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 20:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A6BC8214F;
	Fri,  2 May 2025 22:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AgMvXVQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D407582114; Fri,  2 May 2025 22:12:36 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED2C820E1
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 22:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c173211feso665539a34.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 13:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746216752; x=1746821552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1jMxL1gKVc+UCS74EiJ1pRodyrkqCCU51tjT22a8ysE=;
 b=AgMvXVQZWTDRimVSA820NLYxhrkmZzblWYTyKv3FnEwtgBDEMFM2EEGZeha2uN0+Ga
 uEQTuITm9xHaWBc4m3Y2HEsHzDcw1JSkLOnakvm74VD3iJXmHZrZ+7eBtS8sZTchK+yk
 WbebZ7KWQ/3G+i8nrjH0GPLxyVJLvJDpE34Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746216752; x=1746821552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1jMxL1gKVc+UCS74EiJ1pRodyrkqCCU51tjT22a8ysE=;
 b=ZwRLvkOaJmuWBq5mKp022S941twBKNuBDU66GOeWJPwYUDHtPMsA+4ozJbF6iD97SZ
 mw6F9em6RdrE41++XHICXD9ZOAsYac8CSr+Lwbw56bw4Xd7o05dIEf142AEsPDkvJKXv
 Nu+XZzU+Dn2WctBsLCeNl7HTHdFyPK2/Uhe+B1GW+lfUo3l652tGOJzvUoc96xIDKtuI
 5+55HoqxgrLo2hFqfmuUiY0NSpElmsFiTRnPg1v0GtruZwdqK33PwZxLCXobbBdbOvmY
 nTBSJL+jyO/WCX+bS7YMkhzU+ENcAf8mSL31QhgLb+JLfQzAg3DbEHo3538rlpL6YcGh
 8oNg==
X-Gm-Message-State: AOJu0Yz4v3XgvBgqvic295B8gdX0nU/XEIbvCqdqh+d3koSZdUDPNaoN
 9bhMcGvp/8QDppHf9vXpITFA1fEuJNYA47PL3a/q2xsPkfnx+LPMx6DWX7sPRhu/HzR0CdaSSth
 o
X-Gm-Gg: ASbGncs5hwsIk8TvjYYeG62QOyqcmjRys7MiQt/u0s6dqhp6gEj3zuBzc9F1p7uIroj
 YBMrVxrNuaf+RDjgnNCj/mdXsgqAkUaPgo6tlfaXgYKD4nAdSktl+37bse3DgJJHeQxSm2Z2kKQ
 UxcmhgOAVcRa3IEdl9gxnenLd3JdgaxDUYSlQuJYkY0dITlHS9l3CqP7Ps2f+aCDCsDmV1VPgMi
 KB6jhGTcNgxDTnkzHc05y35AzwhQhLJSKFI+5qdjLZFXmVPgcoln0ubMd+NWHJji5ocacjs7tTM
 igHucSRXlw61f5wDcLr1qkM0D1uMOHlHcpmcqJNRf+a+tt3ZozifqbYAiq0dmS46jhbwLct4NvY
 pF13p
X-Google-Smtp-Source: AGHT+IFbEY/nsU37Td9OA7lqCZ/xNurALSiVdxMGptH8qhKBqYr3VVMvrVAMUJz3KQlK439/c5W28g==
X-Received: by 2002:a05:6808:6f98:b0:403:323d:3033 with SMTP id
 5614622812f47-40341471808mr2732734b6e.29.1746216751789; 
 Fri, 02 May 2025 13:12:31 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607fb1117e4sm27786eaf.3.2025.05.02.13.12.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 13:12:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] PowerPC / Layerscape: Finish migration to DM_SERIAL
Date: Fri,  2 May 2025 14:07:39 -0600
Message-ID: <20250502201226.1369013-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502201226.1369013-1-trini@konsulko.com>
References: <20250502201226.1369013-1-trini@konsulko.com>
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

Migrate the few ARM Layerscape platforms that had not been switched
along with all remaining PowerPC platforms to DM_SERIAL. For PowerPC,
this means that platforms which use SPL/TPL, keeping the non-DM serial
driver enabled there as they do not use DM. We also rework the guards
on how to define CFG_SYS_NS16550_CLK so that this is mostly in one place
now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/powerpc/include/asm/config.h                   | 6 ++++--
 configs/MPC8548CDS_36BIT_defconfig                  | 3 +--
 configs/MPC8548CDS_defconfig                        | 3 +--
 configs/MPC8548CDS_legacy_defconfig                 | 3 +--
 configs/P1010RDB-PA_36BIT_NAND_defconfig            | 3 ++-
 configs/P1010RDB-PA_36BIT_NOR_defconfig             | 2 +-
 configs/P1010RDB-PA_36BIT_SDCARD_defconfig          | 3 ++-
 configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig        | 3 ++-
 configs/P1010RDB-PA_NAND_defconfig                  | 3 ++-
 configs/P1010RDB-PA_NOR_defconfig                   | 2 +-
 configs/P1010RDB-PA_SDCARD_defconfig                | 3 ++-
 configs/P1010RDB-PA_SPIFLASH_defconfig              | 3 ++-
 configs/P1010RDB-PB_36BIT_NAND_defconfig            | 3 ++-
 configs/P1010RDB-PB_36BIT_NOR_defconfig             | 2 +-
 configs/P1010RDB-PB_36BIT_SDCARD_defconfig          | 3 ++-
 configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig        | 3 ++-
 configs/P1010RDB-PB_NAND_defconfig                  | 3 ++-
 configs/P1010RDB-PB_NOR_defconfig                   | 2 +-
 configs/P1010RDB-PB_SDCARD_defconfig                | 3 ++-
 configs/P1010RDB-PB_SPIFLASH_defconfig              | 3 ++-
 configs/P1020RDB-PC_36BIT_NAND_defconfig            | 3 ++-
 configs/P1020RDB-PC_36BIT_SDCARD_defconfig          | 3 ++-
 configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig        | 3 ++-
 configs/P1020RDB-PC_36BIT_defconfig                 | 2 +-
 configs/P1020RDB-PC_NAND_defconfig                  | 3 ++-
 configs/P1020RDB-PC_SDCARD_defconfig                | 3 ++-
 configs/P1020RDB-PC_SPIFLASH_defconfig              | 3 ++-
 configs/P1020RDB-PC_defconfig                       | 2 +-
 configs/P1020RDB-PD_NAND_defconfig                  | 3 ++-
 configs/P1020RDB-PD_SDCARD_defconfig                | 3 ++-
 configs/P1020RDB-PD_SPIFLASH_defconfig              | 3 ++-
 configs/P1020RDB-PD_defconfig                       | 2 +-
 configs/P2020RDB-PC_36BIT_NAND_defconfig            | 3 ++-
 configs/P2020RDB-PC_36BIT_SDCARD_defconfig          | 3 ++-
 configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig        | 3 ++-
 configs/P2020RDB-PC_36BIT_defconfig                 | 2 +-
 configs/P2020RDB-PC_NAND_defconfig                  | 3 ++-
 configs/P2020RDB-PC_SDCARD_defconfig                | 3 ++-
 configs/P2020RDB-PC_SPIFLASH_defconfig              | 3 ++-
 configs/P2020RDB-PC_defconfig                       | 2 +-
 configs/P2041RDB_NAND_defconfig                     | 2 +-
 configs/P2041RDB_SDCARD_defconfig                   | 2 +-
 configs/P2041RDB_SPIFLASH_defconfig                 | 2 +-
 configs/P2041RDB_defconfig                          | 2 +-
 configs/T1024RDB_NAND_defconfig                     | 3 ++-
 configs/T1024RDB_SDCARD_defconfig                   | 3 ++-
 configs/T1024RDB_SPIFLASH_defconfig                 | 3 ++-
 configs/T1042D4RDB_NAND_defconfig                   | 3 ++-
 configs/T1042D4RDB_SDCARD_defconfig                 | 3 ++-
 configs/T1042D4RDB_SPIFLASH_defconfig               | 3 ++-
 configs/T2080QDS_NAND_defconfig                     | 3 ++-
 configs/T2080QDS_SDCARD_defconfig                   | 3 ++-
 configs/T2080QDS_SECURE_BOOT_defconfig              | 3 +--
 configs/T2080QDS_SPIFLASH_defconfig                 | 3 ++-
 configs/T2080QDS_SRIO_PCIE_BOOT_defconfig           | 2 +-
 configs/T2080QDS_defconfig                          | 2 +-
 configs/T2080RDB_NAND_defconfig                     | 3 ++-
 configs/T2080RDB_SDCARD_defconfig                   | 3 ++-
 configs/T2080RDB_SPIFLASH_defconfig                 | 3 ++-
 configs/T2080RDB_revD_NAND_defconfig                | 3 ++-
 configs/T2080RDB_revD_SDCARD_defconfig              | 3 ++-
 configs/T2080RDB_revD_SPIFLASH_defconfig            | 3 ++-
 configs/T4240RDB_SDCARD_defconfig                   | 3 ++-
 configs/ls1012a2g5rdb_tfa_defconfig                 | 3 +--
 configs/ls1012afrdm_tfa_defconfig                   | 3 +--
 configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig       | 3 +--
 configs/ls1012afrwy_tfa_defconfig                   | 3 +--
 configs/ls1012aqds_tfa_SECURE_BOOT_defconfig        | 3 +--
 configs/ls1012aqds_tfa_defconfig                    | 3 +--
 configs/ls1012ardb_tfa_SECURE_BOOT_defconfig        | 3 +--
 configs/ls1012ardb_tfa_defconfig                    | 3 +--
 configs/ls1021aiot_qspi_defconfig                   | 2 +-
 configs/ls1021aiot_sdcard_defconfig                 | 3 ++-
 configs/ls1021aqds_nand_defconfig                   | 3 ++-
 configs/ls1021aqds_nor_SECURE_BOOT_defconfig        | 2 +-
 configs/ls1021aqds_qspi_defconfig                   | 2 +-
 configs/ls1021aqds_sdcard_ifc_defconfig             | 3 ++-
 configs/ls1021aqds_sdcard_qspi_defconfig            | 3 ++-
 configs/ls1021atsn_qspi_defconfig                   | 2 +-
 configs/ls1021atsn_sdcard_defconfig                 | 3 ++-
 configs/ls1021atwr_nor_SECURE_BOOT_defconfig        | 2 +-
 configs/ls1021atwr_qspi_defconfig                   | 2 +-
 configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig | 2 +-
 configs/ls1021atwr_sdcard_ifc_defconfig             | 3 ++-
 configs/ls1021atwr_sdcard_qspi_defconfig            | 3 ++-
 configs/ls1043aqds_tfa_SECURE_BOOT_defconfig        | 2 +-
 configs/ls1043aqds_tfa_defconfig                    | 2 +-
 configs/ls1046aqds_tfa_SECURE_BOOT_defconfig        | 2 +-
 configs/ls1046aqds_tfa_defconfig                    | 2 +-
 configs/ls2080aqds_nand_defconfig                   | 3 ++-
 configs/ls2080aqds_qspi_defconfig                   | 2 +-
 configs/ls2080ardb_nand_defconfig                   | 3 ++-
 include/configs/MPC837XERDB.h                       | 7 -------
 include/configs/MPC8548CDS.h                        | 3 ---
 include/configs/P1010RDB.h                          | 2 --
 include/configs/P2041RDB.h                          | 1 -
 include/configs/T208xQDS.h                          | 1 -
 include/configs/p1_p2_rdb_pc.h                      | 1 -
 98 files changed, 147 insertions(+), 120 deletions(-)

diff --git a/arch/powerpc/include/asm/config.h b/arch/powerpc/include/asm/config.h
index f61f4e1ea6ef..7e53dcf8af58 100644
--- a/arch/powerpc/include/asm/config.h
+++ b/arch/powerpc/include/asm/config.h
@@ -39,12 +39,14 @@
 
 /* The FMAN driver uses the PHYLIB infrastructure */
 
-#if CONFIG_IS_ENABLED(DM_SERIAL) && !defined(CONFIG_CLK_MPC83XX)
+#if !defined(CONFIG_CLK_MPC83XX)
 /*
  * TODO: Convert this to a clock driver exists that can give us the UART
  * clock here.
  */
-#define CFG_SYS_NS16550_CLK		get_serial_clock()
+#ifndef CFG_SYS_NS16550_CLK
+#define CFG_SYS_NS16550_CLK		get_bus_freq(0)
+#endif
 #endif
 
 #endif /* _ASM_CONFIG_H_ */
diff --git a/configs/MPC8548CDS_36BIT_defconfig b/configs/MPC8548CDS_36BIT_defconfig
index 37fe5134449c..e9e4fe28f9af 100644
--- a/configs/MPC8548CDS_36BIT_defconfig
+++ b/configs/MPC8548CDS_36BIT_defconfig
@@ -103,6 +103,5 @@ CONFIG_MII=y
 CONFIG_TSEC_ENET=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
-CONFIG_CONS_INDEX=2
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_ADDR_MAP=y
diff --git a/configs/MPC8548CDS_defconfig b/configs/MPC8548CDS_defconfig
index 4bc3ebe3d52b..182b395462f6 100644
--- a/configs/MPC8548CDS_defconfig
+++ b/configs/MPC8548CDS_defconfig
@@ -102,5 +102,4 @@ CONFIG_MII=y
 CONFIG_TSEC_ENET=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
-CONFIG_CONS_INDEX=2
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
diff --git a/configs/MPC8548CDS_legacy_defconfig b/configs/MPC8548CDS_legacy_defconfig
index 6fcc7271d97e..65ebb6c341c9 100644
--- a/configs/MPC8548CDS_legacy_defconfig
+++ b/configs/MPC8548CDS_legacy_defconfig
@@ -102,5 +102,4 @@ CONFIG_MII=y
 CONFIG_TSEC_ENET=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
-CONFIG_CONS_INDEX=2
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
diff --git a/configs/P1010RDB-PA_36BIT_NAND_defconfig b/configs/P1010RDB-PA_36BIT_NAND_defconfig
index 2a22b8ac9d8b..779c7dacb904 100644
--- a/configs/P1010RDB-PA_36BIT_NAND_defconfig
+++ b/configs/P1010RDB-PA_36BIT_NAND_defconfig
@@ -132,7 +132,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPL_NS16550_MIN_FUNCTIONS=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/P1010RDB-PA_36BIT_NOR_defconfig b/configs/P1010RDB-PA_36BIT_NOR_defconfig
index f21d79e9d7d5..4797994a0726 100644
--- a/configs/P1010RDB-PA_36BIT_NOR_defconfig
+++ b/configs/P1010RDB-PA_36BIT_NOR_defconfig
@@ -96,7 +96,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PA_36BIT_SDCARD_defconfig b/configs/P1010RDB-PA_36BIT_SDCARD_defconfig
index d2ac0b47f531..d3184c967533 100644
--- a/configs/P1010RDB-PA_36BIT_SDCARD_defconfig
+++ b/configs/P1010RDB-PA_36BIT_SDCARD_defconfig
@@ -117,7 +117,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig b/configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig
index 49130342f12d..09fb2661e885 100644
--- a/configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig
+++ b/configs/P1010RDB-PA_36BIT_SPIFLASH_defconfig
@@ -119,7 +119,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PA_NAND_defconfig b/configs/P1010RDB-PA_NAND_defconfig
index 56e7357e5503..56779fdcdf47 100644
--- a/configs/P1010RDB-PA_NAND_defconfig
+++ b/configs/P1010RDB-PA_NAND_defconfig
@@ -131,7 +131,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPL_NS16550_MIN_FUNCTIONS=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/P1010RDB-PA_NOR_defconfig b/configs/P1010RDB-PA_NOR_defconfig
index e1dc33496ca3..e5ccb437398f 100644
--- a/configs/P1010RDB-PA_NOR_defconfig
+++ b/configs/P1010RDB-PA_NOR_defconfig
@@ -95,7 +95,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PA_SDCARD_defconfig b/configs/P1010RDB-PA_SDCARD_defconfig
index 1beb5bb1c0fe..86349579f767 100644
--- a/configs/P1010RDB-PA_SDCARD_defconfig
+++ b/configs/P1010RDB-PA_SDCARD_defconfig
@@ -116,7 +116,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PA_SPIFLASH_defconfig b/configs/P1010RDB-PA_SPIFLASH_defconfig
index a9275e5d22d7..ae79576c30d9 100644
--- a/configs/P1010RDB-PA_SPIFLASH_defconfig
+++ b/configs/P1010RDB-PA_SPIFLASH_defconfig
@@ -118,7 +118,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PB_36BIT_NAND_defconfig b/configs/P1010RDB-PB_36BIT_NAND_defconfig
index d180f3476e62..93d99322c549 100644
--- a/configs/P1010RDB-PB_36BIT_NAND_defconfig
+++ b/configs/P1010RDB-PB_36BIT_NAND_defconfig
@@ -135,7 +135,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPL_NS16550_MIN_FUNCTIONS=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/P1010RDB-PB_36BIT_NOR_defconfig b/configs/P1010RDB-PB_36BIT_NOR_defconfig
index 6237f630866e..60e1cea9f8aa 100644
--- a/configs/P1010RDB-PB_36BIT_NOR_defconfig
+++ b/configs/P1010RDB-PB_36BIT_NOR_defconfig
@@ -98,7 +98,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PB_36BIT_SDCARD_defconfig b/configs/P1010RDB-PB_36BIT_SDCARD_defconfig
index 4237dc960ffb..aefc2d5114e7 100644
--- a/configs/P1010RDB-PB_36BIT_SDCARD_defconfig
+++ b/configs/P1010RDB-PB_36BIT_SDCARD_defconfig
@@ -119,7 +119,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig b/configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig
index 3b5f6beed86f..46cf0be1f62f 100644
--- a/configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig
+++ b/configs/P1010RDB-PB_36BIT_SPIFLASH_defconfig
@@ -121,7 +121,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PB_NAND_defconfig b/configs/P1010RDB-PB_NAND_defconfig
index 25c51c2f0c2e..5979bcef3fec 100644
--- a/configs/P1010RDB-PB_NAND_defconfig
+++ b/configs/P1010RDB-PB_NAND_defconfig
@@ -134,7 +134,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPL_NS16550_MIN_FUNCTIONS=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/P1010RDB-PB_NOR_defconfig b/configs/P1010RDB-PB_NOR_defconfig
index dc181151385f..819d54b1b35a 100644
--- a/configs/P1010RDB-PB_NOR_defconfig
+++ b/configs/P1010RDB-PB_NOR_defconfig
@@ -97,7 +97,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PB_SDCARD_defconfig b/configs/P1010RDB-PB_SDCARD_defconfig
index 5324e7bfaea6..27ed09418aad 100644
--- a/configs/P1010RDB-PB_SDCARD_defconfig
+++ b/configs/P1010RDB-PB_SDCARD_defconfig
@@ -118,7 +118,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1010RDB-PB_SPIFLASH_defconfig b/configs/P1010RDB-PB_SPIFLASH_defconfig
index 7bfa4ebeb848..dc164c0f4361 100644
--- a/configs/P1010RDB-PB_SPIFLASH_defconfig
+++ b/configs/P1010RDB-PB_SPIFLASH_defconfig
@@ -120,7 +120,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1020RDB-PC_36BIT_NAND_defconfig b/configs/P1020RDB-PC_36BIT_NAND_defconfig
index c8897148fadf..03683f0e1e5f 100644
--- a/configs/P1020RDB-PC_36BIT_NAND_defconfig
+++ b/configs/P1020RDB-PC_36BIT_NAND_defconfig
@@ -147,7 +147,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPL_NS16550_MIN_FUNCTIONS=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/P1020RDB-PC_36BIT_SDCARD_defconfig b/configs/P1020RDB-PC_36BIT_SDCARD_defconfig
index d1e097e4d6c5..ea809a95670c 100644
--- a/configs/P1020RDB-PC_36BIT_SDCARD_defconfig
+++ b/configs/P1020RDB-PC_36BIT_SDCARD_defconfig
@@ -129,7 +129,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig b/configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig
index ad7d5b637fb0..eaa892cbd764 100644
--- a/configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig
+++ b/configs/P1020RDB-PC_36BIT_SPIFLASH_defconfig
@@ -131,7 +131,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1020RDB-PC_36BIT_defconfig b/configs/P1020RDB-PC_36BIT_defconfig
index 0391d36a83c7..eb8e4e5d0c9d 100644
--- a/configs/P1020RDB-PC_36BIT_defconfig
+++ b/configs/P1020RDB-PC_36BIT_defconfig
@@ -109,7 +109,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1020RDB-PC_NAND_defconfig b/configs/P1020RDB-PC_NAND_defconfig
index 2d5c83c84d48..3949c4d94d73 100644
--- a/configs/P1020RDB-PC_NAND_defconfig
+++ b/configs/P1020RDB-PC_NAND_defconfig
@@ -146,7 +146,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPL_NS16550_MIN_FUNCTIONS=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/P1020RDB-PC_SDCARD_defconfig b/configs/P1020RDB-PC_SDCARD_defconfig
index 679c6fe7ccd4..ea7e58f3eb0e 100644
--- a/configs/P1020RDB-PC_SDCARD_defconfig
+++ b/configs/P1020RDB-PC_SDCARD_defconfig
@@ -128,7 +128,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1020RDB-PC_SPIFLASH_defconfig b/configs/P1020RDB-PC_SPIFLASH_defconfig
index 2ccb202eb3d3..6d7d97346046 100644
--- a/configs/P1020RDB-PC_SPIFLASH_defconfig
+++ b/configs/P1020RDB-PC_SPIFLASH_defconfig
@@ -130,7 +130,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1020RDB-PC_defconfig b/configs/P1020RDB-PC_defconfig
index 6b7e2b5a1638..e7740064d2bb 100644
--- a/configs/P1020RDB-PC_defconfig
+++ b/configs/P1020RDB-PC_defconfig
@@ -108,7 +108,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1020RDB-PD_NAND_defconfig b/configs/P1020RDB-PD_NAND_defconfig
index 118f510e3880..3361d0db63c6 100644
--- a/configs/P1020RDB-PD_NAND_defconfig
+++ b/configs/P1020RDB-PD_NAND_defconfig
@@ -149,7 +149,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPL_NS16550_MIN_FUNCTIONS=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/P1020RDB-PD_SDCARD_defconfig b/configs/P1020RDB-PD_SDCARD_defconfig
index 6b6b35a08f6d..4c71c73d2f00 100644
--- a/configs/P1020RDB-PD_SDCARD_defconfig
+++ b/configs/P1020RDB-PD_SDCARD_defconfig
@@ -131,7 +131,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1020RDB-PD_SPIFLASH_defconfig b/configs/P1020RDB-PD_SPIFLASH_defconfig
index e30b54144a53..85a5c917594d 100644
--- a/configs/P1020RDB-PD_SPIFLASH_defconfig
+++ b/configs/P1020RDB-PD_SPIFLASH_defconfig
@@ -133,7 +133,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P1020RDB-PD_defconfig b/configs/P1020RDB-PD_defconfig
index f262fa743940..a24aae421036 100644
--- a/configs/P1020RDB-PD_defconfig
+++ b/configs/P1020RDB-PD_defconfig
@@ -111,7 +111,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2020RDB-PC_36BIT_NAND_defconfig b/configs/P2020RDB-PC_36BIT_NAND_defconfig
index ec80871222de..8dfe52ccff5d 100644
--- a/configs/P2020RDB-PC_36BIT_NAND_defconfig
+++ b/configs/P2020RDB-PC_36BIT_NAND_defconfig
@@ -152,7 +152,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPL_NS16550_MIN_FUNCTIONS=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/P2020RDB-PC_36BIT_SDCARD_defconfig b/configs/P2020RDB-PC_36BIT_SDCARD_defconfig
index 0a658738100f..d283e16eb0aa 100644
--- a/configs/P2020RDB-PC_36BIT_SDCARD_defconfig
+++ b/configs/P2020RDB-PC_36BIT_SDCARD_defconfig
@@ -134,7 +134,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig b/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
index ce95ab8fb541..2ef218cb0407 100644
--- a/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
+++ b/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
@@ -136,7 +136,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2020RDB-PC_36BIT_defconfig b/configs/P2020RDB-PC_36BIT_defconfig
index 8c0ce04b7755..8be6d91e5fdf 100644
--- a/configs/P2020RDB-PC_36BIT_defconfig
+++ b/configs/P2020RDB-PC_36BIT_defconfig
@@ -114,7 +114,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2020RDB-PC_NAND_defconfig b/configs/P2020RDB-PC_NAND_defconfig
index 618e82726147..0f79bfee5e69 100644
--- a/configs/P2020RDB-PC_NAND_defconfig
+++ b/configs/P2020RDB-PC_NAND_defconfig
@@ -151,7 +151,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPL_NS16550_MIN_FUNCTIONS=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/P2020RDB-PC_SDCARD_defconfig b/configs/P2020RDB-PC_SDCARD_defconfig
index eb9ee653f3ba..d19646dbd27b 100644
--- a/configs/P2020RDB-PC_SDCARD_defconfig
+++ b/configs/P2020RDB-PC_SDCARD_defconfig
@@ -133,7 +133,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2020RDB-PC_SPIFLASH_defconfig b/configs/P2020RDB-PC_SPIFLASH_defconfig
index f73ddc34b2af..1c5522b34215 100644
--- a/configs/P2020RDB-PC_SPIFLASH_defconfig
+++ b/configs/P2020RDB-PC_SPIFLASH_defconfig
@@ -135,7 +135,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2020RDB-PC_defconfig b/configs/P2020RDB-PC_defconfig
index 492888672d07..95e004b4b446 100644
--- a/configs/P2020RDB-PC_defconfig
+++ b/configs/P2020RDB-PC_defconfig
@@ -113,7 +113,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PT7C4338=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2041RDB_NAND_defconfig b/configs/P2041RDB_NAND_defconfig
index 76b42cb6a154..4f4d2d75cabc 100644
--- a/configs/P2041RDB_NAND_defconfig
+++ b/configs/P2041RDB_NAND_defconfig
@@ -103,7 +103,7 @@ CONFIG_SYS_FMAN_FW_ADDR=0x100000
 CONFIG_MII=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_NAND=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2041RDB_SDCARD_defconfig b/configs/P2041RDB_SDCARD_defconfig
index 008c87b72196..3106ee8b7ce5 100644
--- a/configs/P2041RDB_SDCARD_defconfig
+++ b/configs/P2041RDB_SDCARD_defconfig
@@ -98,7 +98,7 @@ CONFIG_SYS_FMAN_FW_ADDR=0xD2000
 CONFIG_MII=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_MMC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2041RDB_SPIFLASH_defconfig b/configs/P2041RDB_SPIFLASH_defconfig
index c01fc869322c..2ef35896c7d2 100644
--- a/configs/P2041RDB_SPIFLASH_defconfig
+++ b/configs/P2041RDB_SPIFLASH_defconfig
@@ -100,7 +100,7 @@ CONFIG_SYS_FMAN_FW_ADDR=0x110000
 CONFIG_MII=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_SPIFLASH=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/P2041RDB_defconfig b/configs/P2041RDB_defconfig
index fef52a61a517..1511fd7710c1 100644
--- a/configs/P2041RDB_defconfig
+++ b/configs/P2041RDB_defconfig
@@ -95,7 +95,7 @@ CONFIG_SYS_FMAN_FW_ADDR=0xEFF00000
 CONFIG_MII=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_NOR=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T1024RDB_NAND_defconfig b/configs/T1024RDB_NAND_defconfig
index 37dfdb4c7b38..d78d89ee07fb 100644
--- a/configs/T1024RDB_NAND_defconfig
+++ b/configs/T1024RDB_NAND_defconfig
@@ -131,7 +131,8 @@ CONFIG_SYS_QE_FW_ADDR=0x200000
 CONFIG_SYS_QE_FMAN_FW_IN_NAND=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1337=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T1024RDB_SDCARD_defconfig b/configs/T1024RDB_SDCARD_defconfig
index 72630f121959..5e2a87392422 100644
--- a/configs/T1024RDB_SDCARD_defconfig
+++ b/configs/T1024RDB_SDCARD_defconfig
@@ -125,7 +125,8 @@ CONFIG_SYS_QE_FW_ADDR=0x124000
 CONFIG_SYS_QE_FMAN_FW_IN_MMC=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1337=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T1024RDB_SPIFLASH_defconfig b/configs/T1024RDB_SPIFLASH_defconfig
index 8d48b399fb43..86fb67c66c85 100644
--- a/configs/T1024RDB_SPIFLASH_defconfig
+++ b/configs/T1024RDB_SPIFLASH_defconfig
@@ -128,7 +128,8 @@ CONFIG_SYS_QE_FW_ADDR=0x130000
 CONFIG_SYS_QE_FMAN_FW_IN_SPIFLASH=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1337=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T1042D4RDB_NAND_defconfig b/configs/T1042D4RDB_NAND_defconfig
index 01a85947d875..e03fcb63d19e 100644
--- a/configs/T1042D4RDB_NAND_defconfig
+++ b/configs/T1042D4RDB_NAND_defconfig
@@ -131,7 +131,8 @@ CONFIG_SYS_QE_FW_ADDR=0x380000
 CONFIG_SYS_QE_FMAN_FW_IN_NAND=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1337=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T1042D4RDB_SDCARD_defconfig b/configs/T1042D4RDB_SDCARD_defconfig
index 26de5bf8b3a5..f3f5c27dd0bb 100644
--- a/configs/T1042D4RDB_SDCARD_defconfig
+++ b/configs/T1042D4RDB_SDCARD_defconfig
@@ -125,7 +125,8 @@ CONFIG_SYS_QE_FW_ADDR=0x124000
 CONFIG_SYS_QE_FMAN_FW_IN_MMC=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1337=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T1042D4RDB_SPIFLASH_defconfig b/configs/T1042D4RDB_SPIFLASH_defconfig
index 674246aaa7dc..36d855a1ac93 100644
--- a/configs/T1042D4RDB_SPIFLASH_defconfig
+++ b/configs/T1042D4RDB_SPIFLASH_defconfig
@@ -128,7 +128,8 @@ CONFIG_SYS_QE_FW_ADDR=0x130000
 CONFIG_SYS_QE_FMAN_FW_IN_SPIFLASH=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1337=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080QDS_NAND_defconfig b/configs/T2080QDS_NAND_defconfig
index 8d7ca9bbbb09..67e606548a61 100644
--- a/configs/T2080QDS_NAND_defconfig
+++ b/configs/T2080QDS_NAND_defconfig
@@ -141,7 +141,8 @@ CONFIG_MII=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_NAND=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080QDS_SDCARD_defconfig b/configs/T2080QDS_SDCARD_defconfig
index 3ba3022d77e4..b9fd336a35a6 100644
--- a/configs/T2080QDS_SDCARD_defconfig
+++ b/configs/T2080QDS_SDCARD_defconfig
@@ -135,7 +135,8 @@ CONFIG_MII=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_MMC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080QDS_SECURE_BOOT_defconfig b/configs/T2080QDS_SECURE_BOOT_defconfig
index c1230f7e645f..a05d7008e4f2 100644
--- a/configs/T2080QDS_SECURE_BOOT_defconfig
+++ b/configs/T2080QDS_SECURE_BOOT_defconfig
@@ -30,7 +30,6 @@ CONFIG_VOL_MONITOR_IR36021_SET=y
 CONFIG_SYS_FSL_NUM_CC_PLLS=2
 CONFIG_FSL_QIXIS=y
 # CONFIG_QIXIS_I2C_ACCESS is not set
-# CONFIG_SYS_MALLOC_F is not set
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
@@ -110,7 +109,7 @@ CONFIG_MII=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_NOR=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080QDS_SPIFLASH_defconfig b/configs/T2080QDS_SPIFLASH_defconfig
index 1cdcd0d52f97..3e66d47a2578 100644
--- a/configs/T2080QDS_SPIFLASH_defconfig
+++ b/configs/T2080QDS_SPIFLASH_defconfig
@@ -138,7 +138,8 @@ CONFIG_MII=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_SPIFLASH=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080QDS_SRIO_PCIE_BOOT_defconfig b/configs/T2080QDS_SRIO_PCIE_BOOT_defconfig
index a0dbbd0c54d6..841f72ed73dc 100644
--- a/configs/T2080QDS_SRIO_PCIE_BOOT_defconfig
+++ b/configs/T2080QDS_SRIO_PCIE_BOOT_defconfig
@@ -97,7 +97,7 @@ CONFIG_MII=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_REMOTE=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080QDS_defconfig b/configs/T2080QDS_defconfig
index b52112fcba55..1eadcce3ba77 100644
--- a/configs/T2080QDS_defconfig
+++ b/configs/T2080QDS_defconfig
@@ -110,7 +110,7 @@ CONFIG_MII=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_NOR=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080RDB_NAND_defconfig b/configs/T2080RDB_NAND_defconfig
index 63db57b809f8..c3589b19a7e7 100644
--- a/configs/T2080RDB_NAND_defconfig
+++ b/configs/T2080RDB_NAND_defconfig
@@ -137,7 +137,8 @@ CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_NAND=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1307=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080RDB_SDCARD_defconfig b/configs/T2080RDB_SDCARD_defconfig
index 04cc53d93929..becc99eff8f0 100644
--- a/configs/T2080RDB_SDCARD_defconfig
+++ b/configs/T2080RDB_SDCARD_defconfig
@@ -131,7 +131,8 @@ CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_MMC=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1307=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080RDB_SPIFLASH_defconfig b/configs/T2080RDB_SPIFLASH_defconfig
index 26c479f026af..51766dac9c0d 100644
--- a/configs/T2080RDB_SPIFLASH_defconfig
+++ b/configs/T2080RDB_SPIFLASH_defconfig
@@ -134,7 +134,8 @@ CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_SPIFLASH=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1307=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080RDB_revD_NAND_defconfig b/configs/T2080RDB_revD_NAND_defconfig
index 995dc7e9ef25..e7f2b02a4107 100644
--- a/configs/T2080RDB_revD_NAND_defconfig
+++ b/configs/T2080RDB_revD_NAND_defconfig
@@ -139,7 +139,8 @@ CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_NAND=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1307=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080RDB_revD_SDCARD_defconfig b/configs/T2080RDB_revD_SDCARD_defconfig
index a66dba3c1156..92defbe55b5a 100644
--- a/configs/T2080RDB_revD_SDCARD_defconfig
+++ b/configs/T2080RDB_revD_SDCARD_defconfig
@@ -133,7 +133,8 @@ CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_MMC=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1307=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T2080RDB_revD_SPIFLASH_defconfig b/configs/T2080RDB_revD_SPIFLASH_defconfig
index 8a87a1b3a3f3..f37117d3c9d7 100644
--- a/configs/T2080RDB_revD_SPIFLASH_defconfig
+++ b/configs/T2080RDB_revD_SPIFLASH_defconfig
@@ -136,7 +136,8 @@ CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_SPIFLASH=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1307=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/T4240RDB_SDCARD_defconfig b/configs/T4240RDB_SDCARD_defconfig
index 8d03c7d9171f..cf0b7418face 100644
--- a/configs/T4240RDB_SDCARD_defconfig
+++ b/configs/T4240RDB_SDCARD_defconfig
@@ -120,7 +120,8 @@ CONFIG_MII=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_FSL=y
 CONFIG_SYS_QE_FMAN_FW_IN_MMC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
diff --git a/configs/ls1012a2g5rdb_tfa_defconfig b/configs/ls1012a2g5rdb_tfa_defconfig
index 69abd0989820..259279017976 100644
--- a/configs/ls1012a2g5rdb_tfa_defconfig
+++ b/configs/ls1012a2g5rdb_tfa_defconfig
@@ -17,7 +17,6 @@ CONFIG_AHCI=y
 CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
-# CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
@@ -56,7 +55,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_FSL_PFE=y
 CONFIG_DM_RTC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls1012afrdm_tfa_defconfig b/configs/ls1012afrdm_tfa_defconfig
index 883a007c73ee..7fdcc88fc1d5 100644
--- a/configs/ls1012afrdm_tfa_defconfig
+++ b/configs/ls1012afrdm_tfa_defconfig
@@ -17,7 +17,6 @@ CONFIG_PCI=y
 CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
-# CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
@@ -55,7 +54,7 @@ CONFIG_E1000=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_RTC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig b/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
index 0e1452eb78cf..c497cdd92a2d 100644
--- a/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
@@ -17,7 +17,6 @@ CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
-# CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
@@ -57,7 +56,7 @@ CONFIG_E1000=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_RTC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls1012afrwy_tfa_defconfig b/configs/ls1012afrwy_tfa_defconfig
index 0ffae31dae52..ca691aee7371 100644
--- a/configs/ls1012afrwy_tfa_defconfig
+++ b/configs/ls1012afrwy_tfa_defconfig
@@ -18,7 +18,6 @@ CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
-# CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
@@ -60,7 +59,7 @@ CONFIG_E1000=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_RTC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
index 8dc27474200d..38112b4ee085 100644
--- a/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
@@ -20,7 +20,6 @@ CONFIG_PCIE1=y
 CONFIG_FSL_QIXIS=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
-# CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
@@ -73,7 +72,7 @@ CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PCF8563=y
 CONFIG_SCSI=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1012aqds_tfa_defconfig b/configs/ls1012aqds_tfa_defconfig
index 26cddb55e3d3..7b7b7c2becd3 100644
--- a/configs/ls1012aqds_tfa_defconfig
+++ b/configs/ls1012aqds_tfa_defconfig
@@ -22,7 +22,6 @@ CONFIG_PCIE1=y
 CONFIG_FSL_QIXIS=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
-# CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
@@ -82,7 +81,7 @@ CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_PCF8563=y
 CONFIG_SCSI=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
index c63ed6273053..15458f8bafb5 100644
--- a/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
@@ -18,7 +18,6 @@ CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
-# CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
@@ -61,7 +60,7 @@ CONFIG_E1000=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_RTC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1012ardb_tfa_defconfig b/configs/ls1012ardb_tfa_defconfig
index 15f30ebd3878..d77cbe9c6bf6 100644
--- a/configs/ls1012ardb_tfa_defconfig
+++ b/configs/ls1012ardb_tfa_defconfig
@@ -19,7 +19,6 @@ CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x9fffffff
-# CONFIG_SYS_MALLOC_F is not set
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
@@ -62,7 +61,7 @@ CONFIG_E1000=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_RTC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1021aiot_qspi_defconfig b/configs/ls1021aiot_qspi_defconfig
index c91d8c76b3e6..12aa937f94b0 100644
--- a/configs/ls1021aiot_qspi_defconfig
+++ b/configs/ls1021aiot_qspi_defconfig
@@ -67,7 +67,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index c2763b4048ac..9993bfc4c9ca 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -98,7 +98,8 @@ CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_U_QE=y
 CONFIG_SYS_QE_FW_ADDR=0xf40000
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1021aqds_nand_defconfig b/configs/ls1021aqds_nand_defconfig
index f56395a5451b..51d5888c2a75 100644
--- a/configs/ls1021aqds_nand_defconfig
+++ b/configs/ls1021aqds_nand_defconfig
@@ -128,7 +128,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/ls1021aqds_nor_SECURE_BOOT_defconfig b/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
index 29141097b753..ad4b58e517b0 100644
--- a/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
+++ b/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
@@ -95,7 +95,7 @@ CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_SYS_QE_FW_ADDR=0x60940000
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/ls1021aqds_qspi_defconfig b/configs/ls1021aqds_qspi_defconfig
index ec27ad3c7a79..a874cd8e9171 100644
--- a/configs/ls1021aqds_qspi_defconfig
+++ b/configs/ls1021aqds_qspi_defconfig
@@ -83,7 +83,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1021aqds_sdcard_ifc_defconfig b/configs/ls1021aqds_sdcard_ifc_defconfig
index 2f9d10dd6b5e..d14b544dd23b 100644
--- a/configs/ls1021aqds_sdcard_ifc_defconfig
+++ b/configs/ls1021aqds_sdcard_ifc_defconfig
@@ -127,7 +127,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/ls1021aqds_sdcard_qspi_defconfig b/configs/ls1021aqds_sdcard_qspi_defconfig
index 58d1a68f5956..2ab3cf2d0082 100644
--- a/configs/ls1021aqds_sdcard_qspi_defconfig
+++ b/configs/ls1021aqds_sdcard_qspi_defconfig
@@ -112,7 +112,8 @@ CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1021atsn_qspi_defconfig b/configs/ls1021atsn_qspi_defconfig
index 1c7f25ebc6d6..99c2af79289d 100644
--- a/configs/ls1021atsn_qspi_defconfig
+++ b/configs/ls1021atsn_qspi_defconfig
@@ -68,7 +68,7 @@ CONFIG_SJA1105=y
 CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1021atsn_sdcard_defconfig b/configs/ls1021atsn_sdcard_defconfig
index ee3d95696990..6e95bd6ba6d6 100644
--- a/configs/ls1021atsn_sdcard_defconfig
+++ b/configs/ls1021atsn_sdcard_defconfig
@@ -96,7 +96,8 @@ CONFIG_SJA1105=y
 CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1021atwr_nor_SECURE_BOOT_defconfig b/configs/ls1021atwr_nor_SECURE_BOOT_defconfig
index 89c02fe1fd39..38bb415bb81f 100644
--- a/configs/ls1021atwr_nor_SECURE_BOOT_defconfig
+++ b/configs/ls1021atwr_nor_SECURE_BOOT_defconfig
@@ -79,7 +79,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_SYS_QE_FW_ADDR=0x60940000
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/ls1021atwr_qspi_defconfig b/configs/ls1021atwr_qspi_defconfig
index a3fd4ac9baaf..935079cf338a 100644
--- a/configs/ls1021atwr_qspi_defconfig
+++ b/configs/ls1021atwr_qspi_defconfig
@@ -76,7 +76,7 @@ CONFIG_MII=y
 CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
index eb648f1e783d..2a1a704c2709 100644
--- a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
@@ -112,7 +112,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_U_QE=y
 CONFIG_SYS_QE_FW_ADDR=0x940000
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/ls1021atwr_sdcard_ifc_defconfig b/configs/ls1021atwr_sdcard_ifc_defconfig
index f6edabaa76e5..194e78ad2661 100644
--- a/configs/ls1021atwr_sdcard_ifc_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_defconfig
@@ -111,7 +111,8 @@ CONFIG_MII=y
 CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/ls1021atwr_sdcard_qspi_defconfig b/configs/ls1021atwr_sdcard_qspi_defconfig
index 24d20a262bb0..df969dbe4859 100644
--- a/configs/ls1021atwr_sdcard_qspi_defconfig
+++ b/configs/ls1021atwr_sdcard_qspi_defconfig
@@ -105,7 +105,8 @@ CONFIG_MII=y
 CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
index 1cbab056fd41..f3642594ff00 100644
--- a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
@@ -96,7 +96,7 @@ CONFIG_E1000=y
 CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls1043aqds_tfa_defconfig b/configs/ls1043aqds_tfa_defconfig
index f124098b7bf6..4be027c1ac59 100644
--- a/configs/ls1043aqds_tfa_defconfig
+++ b/configs/ls1043aqds_tfa_defconfig
@@ -105,7 +105,7 @@ CONFIG_E1000=y
 CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
index f7b44f64dd49..b657248f918b 100644
--- a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
@@ -97,7 +97,7 @@ CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_PCIE_LAYERSCAPE_EP=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls1046aqds_tfa_defconfig b/configs/ls1046aqds_tfa_defconfig
index 2efc17b9e439..c0529fd848b5 100644
--- a/configs/ls1046aqds_tfa_defconfig
+++ b/configs/ls1046aqds_tfa_defconfig
@@ -107,7 +107,7 @@ CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_PCIE_LAYERSCAPE_EP=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
diff --git a/configs/ls2080aqds_nand_defconfig b/configs/ls2080aqds_nand_defconfig
index 0685960f2185..f028eec4589e 100644
--- a/configs/ls2080aqds_nand_defconfig
+++ b/configs/ls2080aqds_nand_defconfig
@@ -111,7 +111,8 @@ CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_RTC_ENABLE_32KHZ_OUTPUT=y
 CONFIG_RTC_DS3231=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls2080aqds_qspi_defconfig b/configs/ls2080aqds_qspi_defconfig
index 44a1459749fa..ea115f524327 100644
--- a/configs/ls2080aqds_qspi_defconfig
+++ b/configs/ls2080aqds_qspi_defconfig
@@ -90,7 +90,7 @@ CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_RTC_ENABLE_32KHZ_OUTPUT=y
 CONFIG_RTC_DS3231=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
diff --git a/configs/ls2080ardb_nand_defconfig b/configs/ls2080ardb_nand_defconfig
index 66276ec678e9..d04385f36cd5 100644
--- a/configs/ls2080ardb_nand_defconfig
+++ b/configs/ls2080ardb_nand_defconfig
@@ -115,7 +115,8 @@ CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_RTC_DS3231=y
 CONFIG_CONS_INDEX=2
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/include/configs/MPC837XERDB.h b/include/configs/MPC837XERDB.h
index a5176d176dc8..b22c720d07f7 100644
--- a/include/configs/MPC837XERDB.h
+++ b/include/configs/MPC837XERDB.h
@@ -136,13 +136,6 @@
 
 #define CFG_SYS_VSC7385_BASE	0xF0000000
 
-/*
- * Serial Port
- */
-#if !CONFIG_IS_ENABLED(DM_SERIAL) && !CONFIG_IS_ENABLED(DM_CLK)
-#define CFG_SYS_NS16550_CLK		get_bus_freq(0)
-#endif
-
 #define CFG_SYS_BAUDRATE_TABLE \
 		{300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 115200}
 
diff --git a/include/configs/MPC8548CDS.h b/include/configs/MPC8548CDS.h
index 6f3e298a2492..71e81e09ddb5 100644
--- a/include/configs/MPC8548CDS.h
+++ b/include/configs/MPC8548CDS.h
@@ -217,9 +217,6 @@
 
 #define CFG_SYS_INIT_SP_OFFSET	(CFG_SYS_INIT_RAM_SIZE - GENERATED_GBL_DATA_SIZE)
 
-/* Serial Port */
-#define CFG_SYS_NS16550_CLK		get_bus_freq(0)
-
 #define CFG_SYS_BAUDRATE_TABLE \
 	{300, 600, 1200, 2400, 4800, 9600, 19200, 38400,115200}
 
diff --git a/include/configs/P1010RDB.h b/include/configs/P1010RDB.h
index 20fded56b77d..0d312643bc8e 100644
--- a/include/configs/P1010RDB.h
+++ b/include/configs/P1010RDB.h
@@ -309,8 +309,6 @@ extern unsigned long get_sdram_size(void);
 #endif
 
 /* Serial Port */
-#define CFG_SYS_NS16550_CLK		get_bus_freq(0)
-
 #define CFG_SYS_BAUDRATE_TABLE	\
 	{300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200}
 
diff --git a/include/configs/P2041RDB.h b/include/configs/P2041RDB.h
index 7cf6514f1487..f88fb9cdb9ac 100644
--- a/include/configs/P2041RDB.h
+++ b/include/configs/P2041RDB.h
@@ -148,7 +148,6 @@
  * open - index 2
  * shorted - index 1
  */
-#define CFG_SYS_NS16550_CLK		(get_bus_freq(0)/2)
 
 #define CFG_SYS_BAUDRATE_TABLE	\
 	{300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200}
diff --git a/include/configs/T208xQDS.h b/include/configs/T208xQDS.h
index 2023d7497f69..e81937cc3322 100644
--- a/include/configs/T208xQDS.h
+++ b/include/configs/T208xQDS.h
@@ -250,7 +250,6 @@
 /*
  * Serial Port
  */
-#define CFG_SYS_NS16550_CLK		(get_bus_freq(0)/2)
 #define CFG_SYS_BAUDRATE_TABLE	\
 	{300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200}
 #define CFG_SYS_NS16550_COM1 (CFG_SYS_CCSRBAR+0x11C500)
diff --git a/include/configs/p1_p2_rdb_pc.h b/include/configs/p1_p2_rdb_pc.h
index 23d8917b7182..2d9d5b27511a 100644
--- a/include/configs/p1_p2_rdb_pc.h
+++ b/include/configs/p1_p2_rdb_pc.h
@@ -302,7 +302,6 @@
  * open - index 2
  * shorted - index 1
  */
-#define CFG_SYS_NS16550_CLK		get_bus_freq(0)
 
 #define CFG_SYS_BAUDRATE_TABLE	\
 	{300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200}
-- 
2.43.0

