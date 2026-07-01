Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9354EC43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A35F84B9D;
	Wed,  1 Jul 2026 12:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lhaEmxau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAF2284A52; Wed,  1 Jul 2026 08:23:06 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D32184A26
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 08:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C8AA03F8DD
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 06:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782886983;
 bh=CQfeNdw+tQ92B1QkbX76Kcp2J66KOs41+THgdCXWxR8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lhaEmxauV7VFjovkL8cEV0SERyvXm3dzqoo7VzGtz+b5rxXwiif/vJgKuXumXGUb/
 4deph9OZgBiHSg0u9a87lMfK+f9XOdydCi6rZlzdRE2G+F/KmkTTJJcuxOuFc4Rc4t
 6BZuIZ9Sp0fbzVvdvpQYriTIsSM+5ovomJxo0siaIwYd9gNxil1ofFtd7HGMLAIl43
 BGBMnCLmDFVKkyWHjRo6s6F2bhSc4EmQ9LWjqzQnd4dQDhxf40Kv+GtUNZXZG798dz
 8nVPv1pYYOaiGkdmA5dSNygDgzjd/6C06y4/0TdbH0aZx5q/XwaSwdRor1Akoya8SZ
 lZa93tBMU1bqskB4rwmFr+k1iP53awBshl3KPPCaSvkyWYEIBhpDPRsqnkH4+SZgNK
 Zv8SDWgmcRMCwWFqrIaW4yINuTwGJgA7Qsb5fIG9hqBSdAES4uu1LZWpQ+PdpQBh7r
 XQN0A+QXOtc6vgk9ggNOGqo2lIFRuhhB7dX8ha/ShkpMCsqeOWmdobH2GkndUwxdD6
 wIdtqLMKYY4nZwdgUIgXumFOQRmXJMRqP36JiuiPxL6us6Yox7cJJwb/ZW12EwZmZj
 bYYlN01VoSN5CJPHsUiieQ/SZoclwmbrsxFH5YvlOjhq2EkyBz/9mXBDsxcT0Pb2d2
 TURdScm5NIkPDT+hz5gToXrE=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c354050c34so3855455ad.3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 23:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782886982; x=1783491782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQfeNdw+tQ92B1QkbX76Kcp2J66KOs41+THgdCXWxR8=;
 b=Z8h0R+g6WtwlozxEct0ErvlO/X55dUmocMGbokhH4keMF73kdibVt2kOrY1URMrg0S
 dbYYgShP+iBgfKrLEP141TD+Oul7wzrq6z8jeZ2+ocsolrTTgt8cJbX8czTmki62Tue+
 E2j0iM1u6OMNk5BuTwKafylg+0jvXDQYfz/sI5wdUB86Zca4vQoMznFFeLwPHYiLOWnN
 Vshfi7TB1yG8yRRB/gW6ff/ZzR8pSMNa4exMKjlKFHmlUB6Q5iTwQjYol8DfOYtP+Orp
 fELdfr0s9X3LtQoGC9i+DZfzvrDvqAllfisDWeXlDSk4VCwy7pe94oLCU9zjbIWm9ySO
 KnQA==
X-Gm-Message-State: AOJu0YxFvRHtxGcSrHzbE7k2HcMeF3WPOd0gnCEnei+E7B7eXGm8b54w
 bzIrH1SrglqvWsoQejPqtdhg90LPZzQidFapHB9gtpmTiClYOtnPxjdENVWh7lICeCZoIfRHUQ1
 2K263zpzGZQJJj3Cdknx1zYKPqV7Qq6vWTe9xl0G5PMADDHIgwsZPvJWgJUPNlt++B4GJ+I+9Rz
 MGQghDFA==
X-Gm-Gg: AfdE7cluj93f3rpVl0s9w37v+2gfGCFwnfIswCaN/IESftVyGieilaUojSHviDB3n18
 bWLuXRgiTvrTFkjFvvctXqlCRRzBtp0ToyMF4N6dCX9VprfMOTNEZZyMQYcuu0/gly8rzmB/kWl
 1bqddSnPQdY/tTNmSwmezjZhQH7cpFT2sMhqvMp91msIdG/LUkXkLlZfB6bLlVXhxz41dwoeptV
 0wQmMDbx8OB4OhjoMomTJrRgumj0OfglYRJRu5e+AAXL6Yk+wa1EVwmKxzLfokNmcZ4nROJBDQy
 WOibFq77xlQIR7A+G1Wok4syFk1Ij9t6SFW94fdvGz2GIcYYcb4TYM+U0vJtjXbRDnwLTXX7V8I
 LvbbmGs/PrO0M1oO8VZJB9k70CZgs79c69r6zfmrWvioGIMdu3hviXXGm+KLq6g==
X-Received: by 2002:a17:902:e889:b0:2ca:6c8:abde with SMTP id
 d9443c01a7336-2ca7e73a009mr5047295ad.18.1782886981772; 
 Tue, 30 Jun 2026 23:23:01 -0700 (PDT)
X-Received: by 2002:a17:902:e889:b0:2ca:6c8:abde with SMTP id
 d9443c01a7336-2ca7e73a009mr5047055ad.18.1782886981406; 
 Tue, 30 Jun 2026 23:23:01 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c90548sm26941255ad.36.2026.06.30.23.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 23:23:00 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tang Yuantian <andy.tang@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Chunguang Li <chunguang.li_2@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v1 1/1] ls1028ardb: Move environment variables to .env file
Date: Wed,  1 Jul 2026 06:21:25 +0000
Message-ID: <20260701062237.5346-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Jul 2026 12:58:07 +0200
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

Move the bulk of the board environment from CFG_EXTRA_ENV_SETTINGS in
ls1028ardb.h to board/nxp/ls1028a/ls1028ardb.env. Because the board
directory is shared with ls1028aqds, the file is selected through
CONFIG_ENV_SOURCE_FILE rather than the SYS_BOARD default.

The distro_bootcmd machinery cannot be expressed in a .env file. The
BOOTENV macro expands to environment text with embedded NUL separators,
and the board overrides three distro variables (boot_scripts,
boot_a_script and scan_dev_for_boot_part) that must follow BOOTENV to
take effect. BOOTENV and those three overrides therefore remain in
CFG_EXTRA_ENV_SETTINGS, which is concatenated after the .env text, while
every other variable moves to the .env file.

The resulting default environment is functionally unchanged for both the
ls1028ardb_tfa and ls1028ardb_tfa_SECURE_BOOT defconfigs. This was
verified with an order aware comparison of the default environment before
and after the change. The only difference is that three accidental double
spaces in xspi_bootcmd, sd_bootcmd and emmc_bootcmd collapse to single
spaces, because the preprocessor normalises whitespace in the now
unquoted text, which does not affect command parsing.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 board/nxp/ls1028a/ls1028ardb.env             | 49 ++++++++++
 configs/ls1028ardb_tfa_SECURE_BOOT_defconfig |  1 +
 configs/ls1028ardb_tfa_defconfig             |  1 +
 include/configs/ls1028ardb.h                 | 99 ++++----------------
 4 files changed, 71 insertions(+), 79 deletions(-)
 create mode 100644 board/nxp/ls1028a/ls1028ardb.env

diff --git a/board/nxp/ls1028a/ls1028ardb.env b/board/nxp/ls1028a/ls1028ardb.env
new file mode 100644
index 00000000000..dc1cb01e50a
--- /dev/null
+++ b/board/nxp/ls1028a/ls1028ardb.env
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+board=ls1028ardb
+hwconfig=fsl_ddr:bank_intlv=auto
+fdtfile=fsl-ls1028a-rdb.dtb
+image=Image
+extra_bootargs=iommu.passthrough=1 arm-smmu.disable_bypass=0
+othbootargs=video=1920x1080-32@60 cma=640M
+ramdisk_addr=0x800000
+ramdisk_size=0x2000000
+bootm_size=0x10000000
+kernel_addr=0x01000000
+scriptaddr=0x80000000
+scripthdraddr=0x80080000
+fdtheader_addr_r=0x80100000
+kernelheader_addr_r=0x80200000
+load_addr=0xa0000000
+kernel_addr_r=0x81000000
+fdt_addr_r=0x90000000
+ramdisk_addr_r=0xa0000000
+kernel_start=0x1000000
+kernelheader_start=0x600000
+kernel_load=0xa0000000
+kernel_size=0x2800000
+kernelheader_size=0x40000
+kernel_addr_sd=0x8000
+kernel_size_sd=0x14000
+kernelhdr_addr_sd=0x3000
+kernelhdr_size_sd=0x20
+console=ttyS0,115200
+console_dbg=earlycon=uart8250,mmio,0x21c0500
+boot_script_hdr=hdr_ls1028ardb_bs.out
+xspi_bootcmd=echo Trying load from FlexSPI flash ...;sf probe 0:0 && sf read $load_addr
+	$kernel_start $kernel_size ; env exists secureboot &&sf read $kernelheader_addr_r
+	$kernelheader_start $kernelheader_size && esbc_validate ${kernelheader_addr_r}; bootm
+	$load_addr#$board
+xspi_hdploadcmd=echo Trying load HDP firmware from FlexSPI...;sf probe 0:0 && sf read
+	$load_addr 0x940000 0x30000 && hdp load $load_addr 0x2000
+sd_bootcmd=echo Trying load from SD ...;mmc dev 0;mmcinfo; mmc read $load_addr $kernel_addr_sd
+	$kernel_size_sd && env exists secureboot && mmc read $kernelheader_addr_r $kernelhdr_addr_sd
+	$kernelhdr_size_sd && esbc_validate ${kernelheader_addr_r};bootm $load_addr#$board
+sd_hdploadcmd=echo Trying load HDP firmware from SD..;mmc dev 0;mmcinfo;mmc read $load_addr
+	0x4a00 0x200 && hdp load $load_addr 0x2000
+emmc_bootcmd=echo Trying load from EMMC ..;mmc dev 1;mmcinfo; mmc read $load_addr
+	$kernel_addr_sd $kernel_size_sd && env exists secureboot && mmc read $kernelheader_addr_r
+	$kernelhdr_addr_sd $kernelhdr_size_sd && esbc_validate ${kernelheader_addr_r};bootm
+	$load_addr#$board
+emmc_hdploadcmd=echo Trying load HDP firmware from EMMC..;mmc dev 1;mmcinfo;mmc read $load_addr
+	0x4a00 0x200 && hdp load $load_addr 0x2000
diff --git a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
index 6917fe7783b..a8c7c89c9d3 100644
--- a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
@@ -6,6 +6,7 @@ CONFIG_TARGET_LS1028ARDB=y
 CONFIG_TFABOOT=y
 CONFIG_SYS_MALLOC_LEN=0x202000
 CONFIG_SYS_MALLOC_F_LEN=0x6000
+CONFIG_ENV_SOURCE_FILE="ls1028ardb"
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
diff --git a/configs/ls1028ardb_tfa_defconfig b/configs/ls1028ardb_tfa_defconfig
index f1c13afbb2e..ca19d6035ee 100644
--- a/configs/ls1028ardb_tfa_defconfig
+++ b/configs/ls1028ardb_tfa_defconfig
@@ -6,6 +6,7 @@ CONFIG_TARGET_LS1028ARDB=y
 CONFIG_TFABOOT=y
 CONFIG_SYS_MALLOC_LEN=0x202000
 CONFIG_SYS_MALLOC_F_LEN=0x6000
+CONFIG_ENV_SOURCE_FILE="ls1028ardb"
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x500000
diff --git a/include/configs/ls1028ardb.h b/include/configs/ls1028ardb.h
index 613abc50567..1811825baeb 100644
--- a/include/configs/ls1028ardb.h
+++ b/include/configs/ls1028ardb.h
@@ -50,85 +50,26 @@
 /* Initial environment variables */
 #ifndef SPL_NO_ENV
 #undef CFG_EXTRA_ENV_SETTINGS
-#define CFG_EXTRA_ENV_SETTINGS		\
-	"board=ls1028ardb\0"			\
-	"hwconfig=fsl_ddr:bank_intlv=auto\0"	\
-	"fdtfile=fsl-ls1028a-rdb.dtb\0"         \
-	"image=Image\0"					\
-	"extra_bootargs=iommu.passthrough=1 arm-smmu.disable_bypass=0\0"	\
-	"othbootargs=video=1920x1080-32@60 cma=640M\0"    \
-	"ramdisk_addr=0x800000\0"		\
-	"ramdisk_size=0x2000000\0"		\
-	"bootm_size=0x10000000\0"		\
-	"kernel_addr=0x01000000\0"              \
-	"scriptaddr=0x80000000\0"               \
-	"scripthdraddr=0x80080000\0"		\
-	"fdtheader_addr_r=0x80100000\0"         \
-	"kernelheader_addr_r=0x80200000\0"      \
-	"load_addr=0xa0000000\0"            \
-	"kernel_addr_r=0x81000000\0"            \
-	"fdt_addr_r=0x90000000\0"               \
-	"ramdisk_addr_r=0xa0000000\0"           \
-	"kernel_start=0x1000000\0"		\
-	"kernelheader_start=0x600000\0"		\
-	"kernel_load=0xa0000000\0"		\
-	"kernel_size=0x2800000\0"		\
-	"kernelheader_size=0x40000\0"		\
-	"kernel_addr_sd=0x8000\0"		\
-	"kernel_size_sd=0x14000\0"		\
-	"kernelhdr_addr_sd=0x3000\0"		\
-	"kernelhdr_size_sd=0x20\0"		\
-	"console=ttyS0,115200\0"                \
-	"console_dbg=earlycon=uart8250,mmio,0x21c0500\0"		\
-	BOOTENV					\
-	"boot_scripts=ls1028ardb_boot.scr\0"    \
-	"boot_script_hdr=hdr_ls1028ardb_bs.out\0"	\
-	"scan_dev_for_boot_part="               \
-		"part list ${devtype} ${devnum} devplist; "   \
-		"env exists devplist || setenv devplist 1; "  \
-		"for distro_bootpart in ${devplist}; do "     \
-		  "if fstype ${devtype} "                  \
-			"${devnum}:${distro_bootpart} "      \
-			"bootfstype; then "                  \
-			"run scan_dev_for_boot; "            \
-		  "fi; "                                   \
-		"done\0"                                   \
-	"boot_a_script="				  \
-		"load ${devtype} ${devnum}:${distro_bootpart} "  \
-			"${scriptaddr} ${prefix}${script}; "    \
-		"env exists secureboot && load ${devtype} "     \
-			"${devnum}:${distro_bootpart} "		\
+#define CFG_EXTRA_ENV_SETTINGS \
+	BOOTENV \
+	"boot_scripts=ls1028ardb_boot.scr\0" \
+	"scan_dev_for_boot_part=" \
+		"part list ${devtype} ${devnum} devplist; " \
+		"env exists devplist || setenv devplist 1; " \
+		"for distro_bootpart in ${devplist}; do " \
+		  "if fstype ${devtype} " \
+			"${devnum}:${distro_bootpart} " \
+			"bootfstype; then " \
+			"run scan_dev_for_boot; " \
+		  "fi; " \
+		"done\0" \
+	"boot_a_script=" \
+		"load ${devtype} ${devnum}:${distro_bootpart} " \
+			"${scriptaddr} ${prefix}${script}; " \
+		"env exists secureboot && load ${devtype} " \
+			"${devnum}:${distro_bootpart} " \
 			"${scripthdraddr} ${prefix}${boot_script_hdr} " \
-			"&& esbc_validate ${scripthdraddr};"    \
-		"source ${scriptaddr}\0"	  \
-	"xspi_bootcmd=echo Trying load from FlexSPI flash ...;" \
-		"sf probe 0:0 && sf read $load_addr " \
-		"$kernel_start $kernel_size ; env exists secureboot &&" \
-		"sf read $kernelheader_addr_r $kernelheader_start " \
-		"$kernelheader_size && esbc_validate ${kernelheader_addr_r}; "\
-		" bootm $load_addr#$board\0" \
-	"xspi_hdploadcmd=echo Trying load HDP firmware from FlexSPI...;" \
-		"sf probe 0:0 && sf read $load_addr 0x940000 0x30000 " \
-		"&& hdp load $load_addr 0x2000\0"			\
-	"sd_bootcmd=echo Trying load from SD ...;" \
-		"mmc dev 0;mmcinfo; mmc read $load_addr "		\
-		"$kernel_addr_sd $kernel_size_sd && "	\
-		"env exists secureboot && mmc read $kernelheader_addr_r " \
-		"$kernelhdr_addr_sd $kernelhdr_size_sd "		\
-		" && esbc_validate ${kernelheader_addr_r};"	\
-		"bootm $load_addr#$board\0"		\
-	"sd_hdploadcmd=echo Trying load HDP firmware from SD..;"	\
-		"mmc dev 0;mmcinfo;mmc read $load_addr 0x4a00 0x200 "	\
-		"&& hdp load $load_addr 0x2000\0"	\
-	"emmc_bootcmd=echo Trying load from EMMC ..;"	\
-		"mmc dev 1;mmcinfo; mmc read $load_addr "		\
-		"$kernel_addr_sd $kernel_size_sd && "	\
-		"env exists secureboot && mmc read $kernelheader_addr_r " \
-		"$kernelhdr_addr_sd $kernelhdr_size_sd "		\
-		" && esbc_validate ${kernelheader_addr_r};"	\
-		"bootm $load_addr#$board\0"			\
-	"emmc_hdploadcmd=echo Trying load HDP firmware from EMMC..;"      \
-		"mmc dev 1;mmcinfo;mmc read $load_addr 0x4a00 0x200 "	\
-		"&& hdp load $load_addr 0x2000\0"
+			"&& esbc_validate ${scripthdraddr};" \
+		"source ${scriptaddr}\0"
 #endif
 #endif /* __LS1028A_RDB_H */
-- 
2.43.0

