Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F4EE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 22:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1892B88815;
	Fri,  6 Dec 2024 23:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wy/6tTXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 361518870D; Fri,  6 Dec 2024 23:55:11 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92BA58929D
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 23:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-46690cbec70so17074561cf.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 14:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733525707; x=1734130507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQ50UbUxUK/TwKTkhNVU37pK6P6lage6W4QHUzMEHZ4=;
 b=Wy/6tTXeCTTT+w9LIa5hV2lrK7q6RFFK9j2DEHFDFpSR8uTwBNXfxSVAeTBOY6pmNp
 NxByhBs3jCv2tG4qpZunj6phibohgPeWIK/+RDr+gYEAxE8P880CgViIWUFzGLd+BPkv
 GsW/Oho5Jx/McwtaOAe2Su2dmN9zDwSJVEluG8O6pf4vnv7pnV3As4EiOPRJ3lFvdexL
 dr55qEd1jX3+Z6qLwQsf3/CsR4uKkSbrxPLu0Qcxwpz9m9gugodPClis0EBvjM8jcUgK
 nRPvL9OVTjgMxLqSTLqN8YonK5HwyPLL0IiAWohewl3rQERBAVdNJds+8b76phXUfZB9
 y1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525707; x=1734130507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQ50UbUxUK/TwKTkhNVU37pK6P6lage6W4QHUzMEHZ4=;
 b=KdXKiSeJNbZnl9E2iQ0PIYVmBEnKjoIxiTJqQZtH9tODhXTr4LNOEXRTCzFtRHi4Vq
 YRN3PnL1wqcNfthLsciMFal9/bFM1Vfj1nqI8hnlug/DjcFow9GJ7jYVu+yj3bKIlFZz
 gyNfaQ1Kldey4OqyWexEd/yYh7tdlMr0+uIuodqtutcTHGb4xqODZ+EV2VphDlumOV5m
 HNpOkyggUxY/yefCs2N8z/lA2Gy5TwwSQsPWPqoVYIpeTEFd9YTOoncba6EGq0gMvaJM
 FA0GvGEXm3NCfKpyAU+Joxz8TD8K5DjymEKZ2WAJ2jXOlMA01tJ8mEXRwU2l32KmwOpB
 G4sg==
X-Gm-Message-State: AOJu0YzhK6GuS50cU6D6gF2glgQKyjCrhdSUayX1dax/dqV9MG4u4y5P
 zAdM125sBHCoHWxgHY1PLaQ0StCuycSs3Ntu1mZj0q1CcAywzyz/Mt6LtMLFOs5RXVnbl2KkHHz
 P
X-Gm-Gg: ASbGnctfbPrjkXiFgFoo/w2Jyu0ssZbI1MDoLmakR+3z1E3BW9ETUgpmlRSygQlJNkU
 vakxebSb2eHTyeF1R+ETq20X+Yn3RHvkIWqd/JuaFZ12d6L5jZNpm4WOd/qtxTZFg46jWt9pUV5
 Q6SY9FqZeIb0g/dw59EfdwDarw22j21s7m0e61umJsjkT4Eqs1x6f79lIuVPb4FtmfwQjjb4wSS
 H7qlpzORYxwX8C4JbYx3U1t9oeGl6voT+9RdAqGgpmbZYjD/AdFMvkAqvpNpopRct1ttF8FKJcK
 lgIhp3aROclG/0UJ9z5MUekV3iE/JuPPu0nnhiN4SeEPYmEtEyz5
X-Google-Smtp-Source: AGHT+IHfNQ4vibbsHfkci9bN8trYMrpZ+o8gFi9yooAmx1PjjkzDAMJPoexws7MUZ8uoTgji6dsyNA==
X-Received: by 2002:ac8:5e11:0:b0:461:313e:8868 with SMTP id
 d75a77b69052e-46734f96856mr63586971cf.50.1733525707181; 
 Fri, 06 Dec 2024 14:55:07 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d4d7dsm26080871cf.34.2024.12.06.14.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:55:06 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 01/10] smbios: Refactor the smbios headfile
Date: Fri,  6 Dec 2024 14:54:18 -0800
Message-Id: <20241206225438.13866-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206225438.13866-1-raymond.mao@linaro.org>
References: <20241206225438.13866-1-raymond.mao@linaro.org>
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
Changes in v3
- Miscellaneous updates.

 cmd/smbios.c         |   4 +-
 include/smbios.h     |  81 +++---------------
 include/smbios_def.h | 194 +++++++++++++++++++++++++++++++++++++++++++
 lib/smbios.c         |  44 +++++-----
 4 files changed, 231 insertions(+), 92 deletions(-)
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
index 00000000000..81c5781217f
--- /dev/null
+++ b/include/smbios_def.h
@@ -0,0 +1,194 @@
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
+#define SMBIOS_ENCLOSURE_UNKNOWN	2
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
+/* SRAM Type */
+#define SMBIOS_CACHE_SRAM_TYPE_UNKNOWN	2 /* BIT(1) */
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
index a36d4b4e54a..1dd564a1762 100644
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
 						      SYSID_SM_SYSTEM_SERIAL,
@@ -415,7 +415,7 @@ static int smbios_write_type1(ulong *current, int handle,
 	t->family = smbios_add_prop_si(ctx, "family",
 				       SYSID_SM_SYSTEM_FAMILY, NULL);
 
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
 						 SYSID_SM_BASEBOARD_ASSET_TAG,
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

