Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7CAC47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 13:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9DD877E0;
	Sun, 21 Jan 2024 14:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PbFjvQ2M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35CDE877FB; Sun, 21 Jan 2024 14:44:38 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41983877EC
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 14:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 40E7941BB2; 
 Sun, 21 Jan 2024 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705844675;
 bh=TrSz2BzYujwYZfmcB8wbcfFRJCdwFsc1bUwEecmekuo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=PbFjvQ2Ml+E4+DtXuqlvgI2Swg2jmpVyJ4OhQlT5oS8e/kNyWOl7JrUo6pU5qqD2k
 hMAC2vPH99r8PlacgGMtw8Ooz6qPWSH5bRSK/9NKQMI5eoVeBWdUXCrmWnUEF3faRp
 ISHGvOJZxbaB15edhlA3OAy2R53D47VUaqXg03ipQ4oU8N4Sck6HK5izGeAxfZflRk
 XN5gJI1ol/UKu4ge0Tl3bYYimwm0guspVgyMK1F1NH5rTrGTE3Y6+oeN93ZE0l7Lgh
 m9/q/SNMcw7dyRhsyqmdIGigzJlZYqQrUSPnUH68Xmmt0c367RubrGVLaVtw7XIQEs
 xgBL2Lz5gAr+A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] acpi: document HETP table
Date: Sun, 21 Jan 2024 14:44:36 +0100
Message-ID: <20240121134436.173797-1-heinrich.schuchardt@canonical.com>
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

Document struct acpi_gen_regaddr and struct acpi_hpet.

Sphinx requires that the __packed attribute is at the end of the structure
definitions.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/acpi/acpi_table.h | 81 ++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 8256af6d29e..954e3e95037 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -61,13 +61,37 @@ struct __packed acpi_table_header {
 	u32 creator_revision;	/* ASL compiler revision number */
 };
 
+/**
+ * struct acpi_gen_regaddr - generic address structure (GAS)
+ */
 struct acpi_gen_regaddr {
-	u8 space_id;	/* Address space ID */
-	u8 bit_width;	/* Register size in bits */
-	u8 bit_offset;	/* Register bit offset */
-	u8 access_size;	/* Access size */
-	u32 addrl;	/* Register address, low 32 bits */
-	u32 addrh;	/* Register address, high 32 bits */
+	/**
+	 * @space_id: address space ID
+	 *
+	 * See table "Operation Region Address Space Identifiers" in the ACPI
+	 * specification.
+	 */
+	u8 space_id;
+	/** @bit_width: size in bits of the register */
+	u8 bit_width;
+	/** @bit_offset: bit offset of the register */
+	u8 bit_offset;
+	/**
+	 * @access_size: access size
+	 *
+	 * * 0 - undefined
+	 * * 1 - byte access
+	 * * 2 - word (2 bytes) access
+	 * * 3 - Dword (4 bytes) access
+	 * * 4 - Qword (8 bytes) access
+	 *
+	 * See ACPI_ACCESS_SIZE_*_ACCESS macros.
+	 */
+	u8 access_size;
+	/** @addrl: register address, low 32 bits */
+	u32 addrl;
+	/** @addrh: register address, high 32 bits */
+	u32 addrh;
 };
 
 /* A maximum number of 32 ACPI tables ought to be enough for now */
@@ -85,15 +109,26 @@ struct __packed acpi_xsdt {
 	u64 entry[MAX_ACPI_TABLES];
 };
 
-/* HPET timers */
-struct __packed acpi_hpet {
+/**
+ * struct acpi_hpet: High Precision Event Timers (HETP)
+ *
+ * The structure is defined in the
+ * "IA-PC HPET (High Precision Event Timers) Specification", rev 1.0a, Oct 2004
+ */
+struct acpi_hpet {
+	/** @header: table header */
 	struct acpi_table_header header;
+	/** @id hardware ID of Event Timer Block */
 	u32 id;
+	/** @addr: address of Event Timer Block */
 	struct acpi_gen_regaddr addr;
+	/** @number: HPET sequence number */
 	u8 number;
+	/** @min_tick: minimum clock ticks without lost interrupts */
 	u16 min_tick;
+	/** @attributes: page protection and OEM atttribute */
 	u8 attributes;
-};
+} __packed;
 
 struct __packed acpi_tpm2 {
 	struct acpi_table_header header;
@@ -364,7 +399,7 @@ enum {
  * This holds information about the Generic Interrupt Controller (GIC) CPU
  * interface. See ACPI Spec v6.3 section 5.2.12.14
  */
-struct __packed acpi_madr_gicc {
+struct acpi_madr_gicc {
 	u8 type;
 	u8 length;
 	u16 reserved;
@@ -383,7 +418,7 @@ struct __packed acpi_madr_gicc {
 	u8 efficiency;
 	u8 reserved2;
 	u16 spi_overflow_irq;
-};
+} __packed;
 
 /**
  * struct __packed acpi_madr_gicc - GIC distributor (type 0xc)
@@ -391,7 +426,7 @@ struct __packed acpi_madr_gicc {
  * This holds information about the Generic Interrupt Controller (GIC)
  * Distributor interface. See ACPI Spec v6.3 section 5.2.12.15
  */
-struct __packed acpi_madr_gicd {
+struct acpi_madr_gicd {
 	u8 type;
 	u8 length;
 	u16 reserved;
@@ -400,7 +435,7 @@ struct __packed acpi_madr_gicd {
 	u32 reserved2;
 	u8 gic_version;
 	u8 reserved3[3];
-};
+} __packed;
 
 /* MCFG (PCI Express MMIO config space BAR description table) */
 struct acpi_mcfg {
@@ -653,7 +688,7 @@ struct __packed acpi_spcr {
  *
  * See ACPI Spec v6.3 section 5.2.24 for details
  */
-struct __packed acpi_gtdt {
+struct acpi_gtdt {
 	struct acpi_table_header header;
 	u64 cnt_ctrl_base;
 	u32 reserved0;
@@ -670,7 +705,7 @@ struct __packed acpi_gtdt {
 	u32 plat_timer_offset;
 	u32 virt_el2_gsiv;
 	u32 virt_el2_flags;
-};
+} __packed;
 
 /**
  * struct acpi_bgrt -  Boot Graphics Resource Table (BGRT)
@@ -680,7 +715,7 @@ struct __packed acpi_gtdt {
  *
  * See ACPI Spec v6.3 section 5.2.22 for details
  */
-struct __packed acpi_bgrt {
+struct acpi_bgrt {
 	struct acpi_table_header header;
 	u16 version;
 	u8 status;
@@ -688,7 +723,7 @@ struct __packed acpi_bgrt {
 	u64 addr;
 	u32 offset_x;
 	u32 offset_y;
-};
+} __packed;
 
 /* Types for PPTT */
 #define ACPI_PPTT_TYPE_PROC		0
@@ -709,22 +744,22 @@ struct __packed acpi_bgrt {
  *
  * See ACPI Spec v6.3 section 5.2.29 for details
  */
-struct __packed acpi_pptt_header {
+struct acpi_pptt_header {
 	u8 type;	/* ACPI_PPTT_TYPE_... */
 	u8 length;
 	u16 reserved;
-};
+} __packed;
 
 /**
  * struct acpi_pptt_proc - a processor as described by PPTT
  */
-struct __packed acpi_pptt_proc {
+struct acpi_pptt_proc {
 	struct acpi_pptt_header hdr;
 	u32 flags;
 	u32 parent;
 	u32 proc_id;
 	u32 num_resources;
-};
+} __packed;
 
 /* Cache flags for acpi_pptt_cache */
 #define ACPI_PPTT_SIZE_VALID		BIT(0)
@@ -751,7 +786,7 @@ struct __packed acpi_pptt_proc {
 /**
  * struct acpi_pptt_cache - a cache as described by PPTT
  */
-struct __packed acpi_pptt_cache {
+struct acpi_pptt_cache {
 	struct acpi_pptt_header hdr;
 	u32 flags;
 	u32 next_cache_level;
@@ -760,7 +795,7 @@ struct __packed acpi_pptt_cache {
 	u8 assoc;
 	u8 attributes;
 	u16 line_size;
-};
+} __packed;
 
 /* Tables defined/reserved by ACPI and generated by U-Boot */
 enum acpi_tables {
-- 
2.43.0

