Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2205BCDD0E2
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 20:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A183F88FA5;
	Tue, 22 Oct 2024 22:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kG/zqh4W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF8C88FA5; Tue, 22 Oct 2024 22:06:32 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065818919D
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 22:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cbd1ae26a6so36175526d6.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729627588; x=1730232388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMnden94f+0q7N3B8+fPEEX7pNT1HwQVii/yPTF+B3c=;
 b=kG/zqh4WjTzBAMNniPTvMrIq6kTAY12xPcjJDex6t1/LgFift9S5Y6cuGWpyFY9bXy
 Beep1Wb2Uo33PTJ9yXXYy5VKx/GO0RKGY/DcxUs/85Aqipd+rHuispPpYx6hUKaZqbS1
 haqbjRH2oJVqSaV3uCVpyLuPndxDvjCIg/VKfkafAEu6nIdsSDlNi6AEiR9uuH3OAOs8
 9UN86fOUx7+YunsPdSPp2YhhXQdVJ8xC4AmjYpBunGO4Bnoqx5NVdsqqZJq/w9a2p+jS
 VnGornxfJ/1kwMBuW1PeFAbamrcYKQQEWIxj3qveT85Fowbabkg0fmpUEmtsTfKh9RDl
 6E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729627588; x=1730232388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMnden94f+0q7N3B8+fPEEX7pNT1HwQVii/yPTF+B3c=;
 b=rdFMkpKnSkAbTb6czyPLb/b/U6bGHPOGYqQZ1dy0kDLep0NtMYcIJA+AdgMkiEoL2N
 FYgrv/hPPf6qzxOk73ulwXcPK0EVNhqRV4btZz4p4+/fhoymHzrAWlc3x9aEGp1lwf6h
 55iLGXRU2odvGm7YU6c3TS1U9HH8blG/ZMn7rV8stqyy+AwcxFHr7k2qHXB0/P4ze4qp
 33rS2GmlOCHb4gE+8MSSrDs1C7yojzD7V8GKxrayLunOEn77PAXduTUoZ+Jr1M7qYDji
 lt6WWeDsqTSPIlC5pMXy1V/+9kcURiR3vJyHjA+ZUiUu3lnOWlVkz32zvFnTLdjYZkqm
 BPSw==
X-Gm-Message-State: AOJu0YxPMIUHuvA5T4NPUl6gb5h7+c3u4eRJeMMAn+2Yd3pUPwPvBguI
 EXU9IlPvDNwznEuzqDHebMFidftqjGHHReqRi/qcm8eh3gJ2ilIcW88ekPxJLrR/eTvz38dEqGB
 m0rg=
X-Google-Smtp-Source: AGHT+IEk3dbGvn/Qqjx2i9Bf/pxVTvVI0ALVdh/Ck5wXa4sZLW6FdsQ/QWk7ijZ/I6gfGDIlwTm6Gw==
X-Received: by 2002:a05:6214:4489:b0:6cb:bebb:ede0 with SMTP id
 6a1803df08f44-6ce340f8854mr4440626d6.11.1729627588370; 
 Tue, 22 Oct 2024 13:06:28 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce0091a255sm32519956d6.59.2024.10.22.13.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 13:06:27 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: iwamatsu@nigauri.org, marek.vasut+renesas@mailbox.org,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 1/8] smbios: Refactor the smbios headfile
Date: Tue, 22 Oct 2024 13:05:22 -0700
Message-Id: <20241022200543.116343-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022200543.116343-1-raymond.mao@linaro.org>
References: <20241022200543.116343-1-raymond.mao@linaro.org>
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

Move the smbios field definitions to a separated simple headfile,
which is a prerequisite to be included by dts files.
Add new definitions for cache information.
This patch also includes a few of code optimizations in smbios.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.

 cmd/smbios.c         |   4 +-
 include/smbios.h     |  81 +++---------------
 include/smbios_def.h | 191 +++++++++++++++++++++++++++++++++++++++++++
 lib/smbios.c         |  44 +++++-----
 4 files changed, 228 insertions(+), 92 deletions(-)
 create mode 100644 include/smbios_def.h

diff --git a/cmd/smbios.c b/cmd/smbios.c
index d3bd8b12a67..2122ac04e55 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -99,12 +99,12 @@ static void smbios_print_type1(struct smbios_type1 *table)
 	smbios_print_str("Product Name", table, table->product_name);
 	smbios_print_str("Version", table, table->version);
 	smbios_print_str("Serial Number", table, table->serial_number);
-	if (table->length >= 0x19) {
+	if (table->hdr.length >= SMBIOS_TYPE1_LENGTH_V21) {
 		printf("\tUUID: %pUl\n", table->uuid);
 		printf("\tWake-up Type: %s\n",
 		       smbios_wakeup_type_str(table->wakeup_type));
 	}
-	if (table->length >= 0x1b) {
+	if (table->hdr.length >= SMBIOS_TYPE1_LENGTH_V24) {
 		smbios_print_str("SKU Number", table, table->sku_number);
 		smbios_print_str("Family", table, table->family);
 	}
diff --git a/include/smbios.h b/include/smbios.h
index 00119d7a60c..78fd14d881b 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -9,6 +9,7 @@
 #define _SMBIOS_H_
 
 #include <linux/types.h>
+#include <smbios_def.h>
 
 /* SMBIOS spec version implemented */
 #define SMBIOS_MAJOR_VER	3
@@ -80,19 +81,14 @@ struct __packed smbios3_entry {
 	u64 struct_table_address;
 };
 
-/* BIOS characteristics */
-#define BIOS_CHARACTERISTICS_PCI_SUPPORTED	(1 << 7)
-#define BIOS_CHARACTERISTICS_UPGRADEABLE	(1 << 11)
-#define BIOS_CHARACTERISTICS_SELECTABLE_BOOT	(1 << 16)
-
-#define BIOS_CHARACTERISTICS_EXT1_ACPI		(1 << 0)
-#define BIOS_CHARACTERISTICS_EXT2_UEFI		(1 << 3)
-#define BIOS_CHARACTERISTICS_EXT2_TARGET	(1 << 2)
-
-struct __packed smbios_type0 {
+struct __packed smbios_header {
 	u8 type;
 	u8 length;
 	u16 handle;
+};
+
+struct __packed smbios_type0 {
+	struct smbios_header hdr;
 	u8 vendor;
 	u8 bios_ver;
 	u16 bios_start_segment;
@@ -109,37 +105,12 @@ struct __packed smbios_type0 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
-/**
- * enum smbios_wakeup_type - wake-up type
- *
- * These constants are used for the Wake-Up Type field in the SMBIOS
- * System Information (Type 1) structure.
- */
-enum smbios_wakeup_type {
-	/** @SMBIOS_WAKEUP_TYPE_RESERVED: Reserved */
-	SMBIOS_WAKEUP_TYPE_RESERVED,
-	/** @SMBIOS_WAKEUP_TYPE_OTHER: Other */
-	SMBIOS_WAKEUP_TYPE_OTHER,
-	/** @SMBIOS_WAKEUP_TYPE_UNKNOWN: Unknown */
-	SMBIOS_WAKEUP_TYPE_UNKNOWN,
-	/** @SMBIOS_WAKEUP_TYPE_APM_TIMER: APM Timer */
-	SMBIOS_WAKEUP_TYPE_APM_TIMER,
-	/** @SMBIOS_WAKEUP_TYPE_MODEM_RING: Modem Ring */
-	SMBIOS_WAKEUP_TYPE_MODEM_RING,
-	/** @SMBIOS_WAKEUP_TYPE_LAN_REMOTE: LAN Remote */
-	SMBIOS_WAKEUP_TYPE_LAN_REMOTE,
-	/** @SMBIOS_WAKEUP_TYPE_POWER_SWITCH: Power Switch */
-	SMBIOS_WAKEUP_TYPE_POWER_SWITCH,
-	/** @SMBIOS_WAKEUP_TYPE_PCI_PME: PCI PME# */
-	SMBIOS_WAKEUP_TYPE_PCI_PME,
-	/** @SMBIOS_WAKEUP_TYPE_AC_POWER_RESTORED: AC Power Restored */
-	SMBIOS_WAKEUP_TYPE_AC_POWER_RESTORED,
-};
+#define SMBIOS_TYPE1_LENGTH_V20		0x08
+#define SMBIOS_TYPE1_LENGTH_V21		0x19
+#define SMBIOS_TYPE1_LENGTH_V24		0x1b
 
 struct __packed smbios_type1 {
-	u8 type;
-	u8 length;
-	u16 handle;
+	struct smbios_header hdr;
 	u8 manufacturer;
 	u8 product_name;
 	u8 version;
@@ -151,13 +122,8 @@ struct __packed smbios_type1 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
-#define SMBIOS_BOARD_FEATURE_HOSTING	(1 << 0)
-#define SMBIOS_BOARD_MOTHERBOARD	10
-
 struct __packed smbios_type2 {
-	u8 type;
-	u8 length;
-	u16 handle;
+	struct smbios_header hdr;
 	u8 manufacturer;
 	u8 product_name;
 	u8 version;
@@ -171,14 +137,8 @@ struct __packed smbios_type2 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
-#define SMBIOS_ENCLOSURE_DESKTOP	3
-#define SMBIOS_STATE_SAFE		3
-#define SMBIOS_SECURITY_NONE		3
-
 struct __packed smbios_type3 {
-	u8 type;
-	u8 length;
-	u16 handle;
+	struct smbios_header hdr;
 	u8 manufacturer;
 	u8 chassis_type;
 	u8 version;
@@ -196,17 +156,8 @@ struct __packed smbios_type3 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
-#define SMBIOS_PROCESSOR_TYPE_CENTRAL	3
-#define SMBIOS_PROCESSOR_STATUS_ENABLED	1
-#define SMBIOS_PROCESSOR_UPGRADE_NONE	6
-
-#define SMBIOS_PROCESSOR_FAMILY_OTHER	1
-#define SMBIOS_PROCESSOR_FAMILY_UNKNOWN	2
-
 struct __packed smbios_type4 {
-	u8 type;
-	u8 length;
-	u16 handle;
+	struct smbios_header hdr;
 	u8 socket_designation;
 	u8 processor_type;
 	u8 processor_family;
@@ -252,12 +203,6 @@ struct __packed smbios_type127 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
-struct __packed smbios_header {
-	u8 type;
-	u8 length;
-	u16 handle;
-};
-
 /**
  * fill_smbios_header() - Fill the header of an SMBIOS table
  *
diff --git a/include/smbios_def.h b/include/smbios_def.h
new file mode 100644
index 00000000000..f49a18cd7b0
--- /dev/null
+++ b/include/smbios_def.h
@@ -0,0 +1,191 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+
+#ifndef _SMBIOS_DEF_H_
+#define _SMBIOS_DEF_H_
+
+/*
+ * BIOS characteristics
+ */
+
+#define BIOS_CHARACTERISTICS_PCI_SUPPORTED	0x80 /* BIT(7) */
+#define BIOS_CHARACTERISTICS_UPGRADEABLE	0x800 /* BIT(11) */
+#define BIOS_CHARACTERISTICS_SELECTABLE_BOOT	0x10000  /* BIT(16) */
+
+#define BIOS_CHARACTERISTICS_EXT1_ACPI		1 /* BIT(0) */
+#define BIOS_CHARACTERISTICS_EXT2_UEFI		8 /* BIT(3) */
+#define BIOS_CHARACTERISTICS_EXT2_TARGET	4 /* BIT(2) */
+
+/*
+ * System Information
+ */
+
+#define SMBIOS_WAKEUP_TYPE_RESERVED		0
+#define SMBIOS_WAKEUP_TYPE_OTHER		1
+#define SMBIOS_WAKEUP_TYPE_UNKNOWN		2
+#define SMBIOS_WAKEUP_TYPE_APM_TIMER		3
+#define SMBIOS_WAKEUP_TYPE_MODEM_RING		4
+#define SMBIOS_WAKEUP_TYPE_LAN_REMOTE		5
+#define SMBIOS_WAKEUP_TYPE_POWER_SWITCH		6
+#define SMBIOS_WAKEUP_TYPE_PCI_PME		7
+#define SMBIOS_WAKEUP_TYPE_AC_POWER_RESTORED	8
+
+/*
+ * Baseboard Information
+ */
+
+#define SMBIOS_BOARD_FEAT_HOST_BOARD		1 /* BIT(0) */
+#define SMBIOS_BOARD_FEAT_REQ_AUX		2 /* BIT(1) */
+#define SMBIOS_BOARD_FEAT_REMOVABLE		4 /* BIT(2) */
+#define SMBIOS_BOARD_FEAT_REPLACEABLE		8 /* BIT(3) */
+#define SMBIOS_BOARD_FEAT_HOT_SWAPPABLE		16 /* BIT(4) */
+
+#define SMBIOS_BOARD_TYPE_UNKNOWN		1
+#define SMBIOS_BOARD_TYPE_OTHER			2
+#define SMBIOS_BOARD_TYPE_SERVER_BLADE		3
+#define SMBIOS_BOARD_TYPE_CON_SWITCH		4
+#define SMBIOS_BOARD_TYPE_SM_MODULE		5
+#define SMBIOS_BOARD_TYPE_PROCESSOR_MODULE	6
+#define SMBIOS_BOARD_TYPE_IO_MODULE		7
+#define SMBIOS_BOARD_TYPE_MEM_MODULE		8
+#define SMBIOS_BOARD_TYPE_DAUGHTER_BOARD	9
+#define SMBIOS_BOARD_TYPE_MOTHERBOARD		10
+#define SMBIOS_BOARD_TYPE_PROC_MEM_MODULE	11
+#define SMBIOS_BOARD_TYPE_PROC_IO_MODULE	12
+#define SMBIOS_BOARD_TYPE_INTERCON		13
+
+/*
+ * System Enclosure or Chassis
+ */
+
+#define SMBIOS_ENCLOSURE_DESKTOP	3
+
+#define SMBIOS_STATE_OTHER		1
+#define SMBIOS_STATE_UNKNOWN		2
+#define SMBIOS_STATE_SAFE		3
+#define SMBIOS_STATE_WARNING		4
+#define SMBIOS_STATE_CRITICAL		5
+#define SMBIOS_STATE_NONRECOVERABLE	6
+
+#define SMBIOS_SECURITY_OTHER		1
+#define SMBIOS_SECURITY_UNKNOWN		2
+#define SMBIOS_SECURITY_NONE		3
+#define SMBIOS_SECURITY_EXTINT_LOCK	4
+#define SMBIOS_SECURITY_EXTINT_EN	5
+
+#define SMBIOS_ENCLOSURE_OEM_UND	0
+#define SMBIOS_ENCLOSURE_HEIGHT_UND	0
+#define SMBIOS_POWCORD_NUM_UND		0
+#define SMBIOS_ELEMENT_TYPE_SELECT	0x80 /* BIT(7) */
+
+/*
+ * Processor Information
+ */
+
+#define SMBIOS_PROCESSOR_TYPE_OTHER	1
+#define SMBIOS_PROCESSOR_TYPE_UNKNOWN	2
+#define SMBIOS_PROCESSOR_TYPE_CENTRAL	3
+#define SMBIOS_PROCESSOR_TYPE_MATH	4
+#define SMBIOS_PROCESSOR_TYPE_DSP	5
+#define SMBIOS_PROCESSOR_TYPE_VIDEO	6
+
+#define SMBIOS_PROCESSOR_STATUS_UNKNOWN		0
+#define SMBIOS_PROCESSOR_STATUS_ENABLED		1
+#define SMBIOS_PROCESSOR_STATUS_DISABLED_USER	2
+#define SMBIOS_PROCESSOR_STATUS_DISABLED_BIOS	3
+#define SMBIOS_PROCESSOR_STATUS_IDLE		4
+#define SMBIOS_PROCESSOR_STATUS_OTHER		7
+
+#define SMBIOS_PROCESSOR_UPGRADE_OTHER		1
+#define SMBIOS_PROCESSOR_UPGRADE_UNKNOWN	2
+#define SMBIOS_PROCESSOR_UPGRADE_NONE		6
+
+#define SMBIOS_PROCESSOR_FAMILY_OTHER	1
+#define SMBIOS_PROCESSOR_FAMILY_UNKNOWN	2
+#define SMBIOS_PROCESSOR_FAMILY_RSVD	255
+#define SMBIOS_PROCESSOR_FAMILY_ARMV7	256
+#define SMBIOS_PROCESSOR_FAMILY_ARMV8	257
+#define SMBIOS_PROCESSOR_FAMILY_RV32	512
+#define SMBIOS_PROCESSOR_FAMILY_RV64	513
+
+#define SMBIOS_PROCESSOR_FAMILY_EXT	0xfe
+
+/* Processor Characteristics */
+#define SMBIOS_PROCESSOR_RSVD		1 /* BIT(0) */
+#define SMBIOS_PROCESSOR_UND		2 /* BIT(1) */
+#define SMBIOS_PROCESSOR_64BIT		4 /* BIT(2) */
+#define SMBIOS_PROCESSOR_MULTICORE	8 /* BIT(3) */
+#define SMBIOS_PROCESSOR_HWTHREAD	16 /* BIT(4) */
+#define SMBIOS_PROCESSOR_EXEC_PROT	32 /* BIT(5) */
+#define SMBIOS_PROCESSOR_ENH_VIRT	64 /* BIT(6) */
+#define SMBIOS_PROCESSOR_POW_CON	0x80 /* BIT(7) */
+#define SMBIOS_PROCESSOR_128BIT		0x100 /* BIT(8) */
+#define SMBIOS_PROCESSOR_ARM64_SOCID	0x200 /* BIT(9) */
+
+/*
+ * Cache Information
+ */
+
+#define SMBIOS_CACHE_SIZE_EXT_KB (2047 * 1024) /* 2047 MiB */
+#define SMBIOS_CACHE_HANDLE_NONE 0xffff
+
+/* System Cache Type */
+#define SMBIOS_CACHE_SYSCACHE_TYPE_OTHER	1
+#define SMBIOS_CACHE_SYSCACHE_TYPE_UNKNOWN	2
+#define SMBIOS_CACHE_SYSCACHE_TYPE_INST		3
+#define SMBIOS_CACHE_SYSCACHE_TYPE_DATA		4
+#define SMBIOS_CACHE_SYSCACHE_TYPE_UNIFIED	5
+
+/* Cache Speed */
+#define SMBIOS_CACHE_SPEED_UNKNOWN	0
+
+/* Error Correction Type */
+#define SMBIOS_CACHE_ERRCORR_OTHER	1
+#define SMBIOS_CACHE_ERRCORR_UNKNOWN	2
+#define SMBIOS_CACHE_ERRCORR_NONE	3
+#define SMBIOS_CACHE_ERRCORR_PARITY	4
+#define SMBIOS_CACHE_ERRCORR_SBITECC	5
+#define SMBIOS_CACHE_ERRCORR_MBITECC	6
+
+/* Cache Configuration */
+#define SMBIOS_CACHE_LEVEL_1	0
+#define SMBIOS_CACHE_LEVEL_2	1
+#define SMBIOS_CACHE_LEVEL_3	2
+#define SMBIOS_CACHE_LEVEL_4	3
+#define SMBIOS_CACHE_LEVEL_5	4
+#define SMBIOS_CACHE_LEVEL_6	5
+#define SMBIOS_CACHE_LEVEL_7	6
+#define SMBIOS_CACHE_LEVEL_8	7
+#define SMBIOS_CACHE_SOCKETED	8 /* BIT(3) */
+#define SMBIOS_CACHE_LOCATE_EXTERNAL	32 /* BIT(5) */
+#define SMBIOS_CACHE_LOCATE_RESERVED	64 /* BIT(6) */
+#define SMBIOS_CACHE_LOCATE_UNKNOWN	96 /* (BIT(5) | BIT(6)) */
+#define SMBIOS_CACHE_ENABLED	0x80 /* BIT(7) */
+#define SMBIOS_CACHE_OP_WB	0x100 /* BIT(8), Write Back */
+#define SMBIOS_CACHE_OP_VAR	0x200 /* BIT(9), Varies with Memory Address */
+#define SMBIOS_CACHE_OP_UND	0x300 /* (BIT(8) | BIT(9)), Unknown*/
+
+/* Cache Granularity */
+#define SMBIOS_CACHE_GRANU_1K	0
+#define SMBIOS_CACHE_GRANU_64K	1
+
+/* Cache Associativity */
+#define SMBIOS_CACHE_ASSOC_OTHER	1
+#define SMBIOS_CACHE_ASSOC_UNKNOWN	2
+#define SMBIOS_CACHE_ASSOC_DMAPPED	3
+#define SMBIOS_CACHE_ASSOC_2WAY		4
+#define SMBIOS_CACHE_ASSOC_4WAY		5
+#define SMBIOS_CACHE_ASSOC_FULLY	6
+#define SMBIOS_CACHE_ASSOC_8WAY		7
+#define SMBIOS_CACHE_ASSOC_16WAY	8
+#define SMBIOS_CACHE_ASSOC_12WAY	9
+#define SMBIOS_CACHE_ASSOC_24WAY	10
+#define SMBIOS_CACHE_ASSOC_32WAY	11
+#define SMBIOS_CACHE_ASSOC_48WAY	12
+#define SMBIOS_CACHE_ASSOC_64WAY	13
+#define SMBIOS_CACHE_ASSOC_20WAY	14
+
+#endif /* _SMBIOS_DEF_H_ */
diff --git a/lib/smbios.c b/lib/smbios.c
index 7c24ea129eb..886c40e7594 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -330,10 +330,10 @@ static int smbios_write_type0(ulong *current, int handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type0 *t;
-	int len = sizeof(struct smbios_type0);
+	int len = sizeof(*t);
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type0));
+	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
 	t->vendor = smbios_add_prop(ctx, NULL, "U-Boot");
@@ -374,7 +374,7 @@ static int smbios_write_type0(ulong *current, int handle,
 	t->ec_major_release = 0xff;
 	t->ec_minor_release = 0xff;
 
-	len = t->length + smbios_string_table_len(ctx);
+	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
 	unmap_sysmem(t);
 
@@ -385,11 +385,11 @@ static int smbios_write_type1(ulong *current, int handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type1 *t;
-	int len = sizeof(struct smbios_type1);
+	int len = sizeof(*t);
 	char *serial_str = env_get("serial#");
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type1));
+	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
 	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
@@ -403,7 +403,7 @@ static int smbios_write_type1(ulong *current, int handle,
 					NULL);
 	if (serial_str) {
 		t->serial_number = smbios_add_prop(ctx, NULL, serial_str);
-		strncpy((char *)t->uuid, serial_str, sizeof(t->uuid));
+		strlcpy((char *)t->uuid, serial_str, sizeof(t->uuid));
 	} else {
 		t->serial_number = smbios_add_prop_si(ctx, "serial",
 						      SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
@@ -415,7 +415,7 @@ static int smbios_write_type1(ulong *current, int handle,
 	t->family = smbios_add_prop_si(ctx, "family",
 				       SYSINFO_ID_SMBIOS_SYSTEM_FAMILY, NULL);
 
-	len = t->length + smbios_string_table_len(ctx);
+	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
 	unmap_sysmem(t);
 
@@ -426,10 +426,10 @@ static int smbios_write_type2(ulong *current, int handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type2 *t;
-	int len = sizeof(struct smbios_type2);
+	int len = sizeof(*t);
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type2));
+	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
 	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
@@ -448,11 +448,11 @@ static int smbios_write_type2(ulong *current, int handle,
 	t->asset_tag_number = smbios_add_prop_si(ctx, "asset-tag",
 						 SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
 						 NULL);
-	t->feature_flags = SMBIOS_BOARD_FEATURE_HOSTING;
-	t->board_type = SMBIOS_BOARD_MOTHERBOARD;
+	t->feature_flags = SMBIOS_BOARD_FEAT_HOST_BOARD;
+	t->board_type = SMBIOS_BOARD_TYPE_MOTHERBOARD;
 	t->chassis_handle = handle + 1;
 
-	len = t->length + smbios_string_table_len(ctx);
+	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
 	unmap_sysmem(t);
 
@@ -463,10 +463,10 @@ static int smbios_write_type3(ulong *current, int handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type3 *t;
-	int len = sizeof(struct smbios_type3);
+	int len = sizeof(*t);
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type3));
+	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
 	smbios_set_eos(ctx, t->eos);
 	t->manufacturer = smbios_add_prop(ctx, "manufacturer", NULL);
@@ -476,7 +476,7 @@ static int smbios_write_type3(ulong *current, int handle,
 	t->thermal_state = SMBIOS_STATE_SAFE;
 	t->security_status = SMBIOS_SECURITY_NONE;
 
-	len = t->length + smbios_string_table_len(ctx);
+	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
 	unmap_sysmem(t);
 
@@ -521,10 +521,10 @@ static int smbios_write_type4(ulong *current, int handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type4 *t;
-	int len = sizeof(struct smbios_type4);
+	int len = sizeof(*t);
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type4));
+	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_PROCESSOR_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
 	t->processor_type = SMBIOS_PROCESSOR_TYPE_CENTRAL;
@@ -535,7 +535,7 @@ static int smbios_write_type4(ulong *current, int handle,
 	t->l2_cache_handle = 0xffff;
 	t->l3_cache_handle = 0xffff;
 
-	len = t->length + smbios_string_table_len(ctx);
+	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
 	unmap_sysmem(t);
 
@@ -546,10 +546,10 @@ static int smbios_write_type32(ulong *current, int handle,
 			       struct smbios_ctx *ctx)
 {
 	struct smbios_type32 *t;
-	int len = sizeof(struct smbios_type32);
+	int len = sizeof(*t);
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type32));
+	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_SYSTEM_BOOT_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
 
@@ -563,10 +563,10 @@ static int smbios_write_type127(ulong *current, int handle,
 				struct smbios_ctx *ctx)
 {
 	struct smbios_type127 *t;
-	int len = sizeof(struct smbios_type127);
+	int len = sizeof(*t);
 
 	t = map_sysmem(*current, len);
-	memset(t, 0, sizeof(struct smbios_type127));
+	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_END_OF_TABLE, len, handle);
 
 	*current += len;
-- 
2.25.1

