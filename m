Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A7AE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 22:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0E088ACB;
	Fri,  6 Dec 2024 23:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sHVxnjQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46E18870D; Fri,  6 Dec 2024 23:56:06 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DFF989434
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 23:56:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4668d12b629so22382271cf.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 14:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733525763; x=1734130563; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+H896CW6tvGSIw32RI2JpNxzOWuJ3RTCbjL6vdkxus=;
 b=sHVxnjQdtLzaAHNl8Ccbl/FawhyvZp6YiKVTT0fFzi9S3Ytc4XfTkCvPvnJbKAryvI
 DBs5yVbqFD/LIyq7eibcVmp1jpsdM5fVSOBUOCZTf4CtpF5nbSCukC1kGdWHSLsKn40g
 aUDUAgpSKhUHFmvX0Gk+wAYRUPA9qvmJzWOJV+m5XwrZZI9IWbPb6kzcSoCGyZVDmHrA
 tFtYNze5JvfFv79XQyJqUBi8Tx5pRtNb/Yx7p0gSDOwC+fMmkJR1FC/KVBAclQ+BdWEZ
 fuPOUYiPw/l/0+rZwQrcKdYO6kJAiG/6DtG2ZwNeE9HVBlGRud/jG0qAFY+tq/WltXhS
 cfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525763; x=1734130563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+H896CW6tvGSIw32RI2JpNxzOWuJ3RTCbjL6vdkxus=;
 b=lC/VbEcLNi2SA2qZlb4BNJumOdjs4d/XQId4Hmw89r8pTt7wdZR9gbQkR4fzfU6e7P
 6L8ZVx2H+g1SrcOi8umN8FZ2Ox6Y1s/bLk1qxL81DSrbdqs22KQ3HjKLvodoZNnmXL9N
 QZHbDh312MPSIXUyO0nuY1wPsWg27YQl+rxEilauuAq+lE7suZ8zhcRK8e3+nuYkXQeH
 HUp4QUx0X1yZcr7Vb6ln63mVoveOXxiQhuZTfzvbs9DDAVuHterOABH/aBZJsB8szddz
 k+UDvAXttJYsU0P4eT/nZxpj83lGv0bkcL/VJiKl71rH8DgCbX7Kad6QHBchE2zwvHgF
 mFew==
X-Gm-Message-State: AOJu0Yz9DRZBr/3lvWP6npzFjMQ2FUjQfjkHlyr2Lpau9cyG3z0CPDMz
 hyVz+YI8UK8e4C1r/gR+mTukzjhbHN2mA1QLItdKIVRuBHZwy0TULV3hadYbYAGuEi0f0B7+e4G
 Y
X-Gm-Gg: ASbGncteIM8ZCXM4cCrWqhNS37V5fu6tGT35amKv1Y44quAWLJLaqCs4OFoWopDrKJD
 Iv++0DCltPCZ/veiIPNJ1pwMOjtIQyQFVL1KiHDCWKrHgSi8nsgXXZ5z4ZoYynwg7uGOnZF+A0e
 T/fVv59axTnuv/Rcy80YY2yeFpv0NIxPv7UstFm0uMKGPwDDX2BIF97IIvpmE0jnFZFKP7PUr7m
 D5XLjQRc1EjPQuQM1LE5l1oHIIeN2AcqfqR7FoXi+TRPbatjQYLB/g3xPRQl8/r4vDQZblX8ybz
 0tJRju+LMHeFYujXWQr3CJk8riV38Z5b9vvkbZqca0ksGiVB
X-Google-Smtp-Source: AGHT+IHpcDZgPMMJUq+2CfbctFrRIlajqT80v4Uqu3rw5a5G7QscIGeCavG27lvQpGaBt3obWJLLXQ==
X-Received: by 2002:a05:622a:8e1a:b0:467:4570:bca8 with SMTP id
 d75a77b69052e-4674570c03dmr13210211cf.53.1733525762940; 
 Fri, 06 Dec 2024 14:56:02 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d4d7dsm26080871cf.34.2024.12.06.14.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:56:02 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 05/10] smbios: Refactor smbios library
Date: Fri,  6 Dec 2024 14:54:22 -0800
Message-Id: <20241206225438.13866-6-raymond.mao@linaro.org>
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

Current smbios library does not fully match to the specification.
It hardcodes values instead of exposing values from the device.
It does not reserve the space to support dynamic length for
contained object handles or elements and misses the handling of
a few of fields.

The refactoring of this patch includes:
1. Expose values from device via sysinfo interface.
2. Replace smbios_add_prop with smbios_add_prop_si to allow getting
   string values from sysinfo.
3. Add smbios_get_val_si to get values from sysinfo or device tree.
4. Use sysinfo_get_data to get data area.
5. Reserve the space of contained object handles and elements.
6. Miscellaneous fixes in smbios.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Combine with #7(v1) patch.
- Move the changes of cmd/smbios.c to a separated patch.
- Refactor smbios_get_val_si to get values from dt when values are
   not available from sysinfo driver.
- Miscellaneous refactoring.
Changes in v3
- Allows smbios_get_val_si to fallback to the values from device tree.
- Add GENERATE_SMBIOS_TABLE_VERBOSE for the detail information.
- Rebased on the changes of SYSID_
- Split the changes for detailed information of Type 3, 4 and 7 to patch #06.

 include/smbios.h |  14 +++-
 lib/Kconfig      |   6 ++
 lib/smbios.c     | 202 ++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 176 insertions(+), 46 deletions(-)

diff --git a/include/smbios.h b/include/smbios.h
index cb4b3e08b3a..18f568f9b0d 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -122,6 +122,8 @@ struct __packed smbios_type1 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
+#define SMBIOS_TYPE2_CON_OBJ_HANDLE_SIZE sizeof(u16)
+
 struct __packed smbios_type2 {
 	struct smbios_header hdr;
 	u8 manufacturer;
@@ -134,6 +136,10 @@ struct __packed smbios_type2 {
 	u16 chassis_handle;
 	u8 board_type;
 	u8 number_contained_objects;
+	/*
+	 * Dynamic bytes will be inserted here to store the objects.
+	 * length is equal to 'number_contained_objects'.
+	 */
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
@@ -153,12 +159,17 @@ struct __packed smbios_type3 {
 	u8 number_of_power_cords;
 	u8 element_count;
 	u8 element_record_length;
+	/*
+	 * Dynamic bytes will be inserted here to store the elements.
+	 * length is equal to 'element_record_length' * 'element_record_length'
+	 */
+	u8 sku_number;
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
 struct __packed smbios_type4 {
 	struct smbios_header hdr;
-	u8 socket_designation;
+	u8 socket_design;
 	u8 processor_type;
 	u8 processor_family;
 	u8 processor_manufacturer;
@@ -184,6 +195,7 @@ struct __packed smbios_type4 {
 	u16 core_count2;
 	u16 core_enabled2;
 	u16 thread_count2;
+	u16 thread_enabled;
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
diff --git a/lib/Kconfig b/lib/Kconfig
index 0b089814d14..7ac58125f94 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1038,6 +1038,12 @@ config GENERATE_SMBIOS_TABLE
 	  See also SYSINFO_SMBIOS which allows SMBIOS values to be provided in
 	  the devicetree.
 
+config GENERATE_SMBIOS_TABLE_VERBOSE
+	bool "Generate a verbose SMBIOS (System Management BIOS) table"
+	depends on GENERATE_SMBIOS_TABLE
+	help
+	  Provide verbose SMBIOS information.
+
 endmenu
 
 config LIB_RATIONAL
diff --git a/lib/smbios.c b/lib/smbios.c
index 1dd564a1762..e8089e91523 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -206,6 +206,43 @@ void get_str_from_dt(const struct map_sysinfo *nprop, char *str, size_t size)
 	}
 }
 
+/**
+ * smbios_get_val_si() - Get value from the devicetree or sysinfo
+ *
+ * @ctx:	context of SMBIOS
+ * @prop:	property to read
+ * @sysinfo_id: unique identifier for the value to be read
+ * @val_def:	Default value
+ * Return:	Valid value from sysinfo or device tree, otherwise val_def.
+ */
+static int smbios_get_val_si(struct smbios_ctx * __maybe_unused ctx,
+			     const char * __maybe_unused prop,
+			     int __maybe_unused sysinfo_id, int val_def)
+{
+#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
+	int val;
+
+	if (!ctx->dev)
+		return val_def;
+
+	if (!sysinfo_get_int(ctx->dev, sysinfo_id, &val))
+		return val;
+
+	if (!IS_ENABLED(CONFIG_OF_CONTROL) || !prop)
+		return val_def;
+
+	if (ofnode_valid(ctx->node) && !ofnode_read_u32(ctx->node, prop, &val))
+		return val;
+
+	/*
+	 * If the node or property is not valid fallback and try the root
+	 */
+	if (!ofnode_read_u32(ofnode_root(), prop, &val))
+		return val;
+#endif
+	return val_def;
+}
+
 /**
  * smbios_add_prop_si() - Add a property from the devicetree or sysinfo
  *
@@ -225,9 +262,6 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 	if (!dval || !*dval)
 		dval = NULL;
 
-	if (!prop)
-		return smbios_add_string(ctx, dval);
-
 	if (sysinfo_id && ctx->dev) {
 		char val[SMBIOS_STR_MAX];
 
@@ -235,6 +269,9 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 		if (!ret)
 			return smbios_add_string(ctx, val);
 	}
+	if (!prop)
+		return smbios_add_string(ctx, dval);
+
 	if (IS_ENABLED(CONFIG_OF_CONTROL)) {
 		const char *str = NULL;
 		char str_dt[128] = { 0 };
@@ -336,9 +373,11 @@ static int smbios_write_type0(ulong *current, int handle,
 	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->vendor = smbios_add_prop(ctx, NULL, "U-Boot");
+	t->vendor = smbios_add_prop_si(ctx, NULL, SYSID_SM_BIOS_VENDOR,
+				       "U-Boot");
 
-	t->bios_ver = smbios_add_prop(ctx, "version", PLAIN_VERSION);
+	t->bios_ver = smbios_add_prop_si(ctx, "version", SYSID_SM_BIOS_VER,
+					 PLAIN_VERSION);
 	if (t->bios_ver)
 		gd->smbios_version = ctx->last_str;
 	log_debug("smbios_version = %p: '%s'\n", gd->smbios_version,
@@ -347,7 +386,9 @@ static int smbios_write_type0(ulong *current, int handle,
 	print_buffer((ulong)gd->smbios_version, gd->smbios_version,
 		     1, strlen(gd->smbios_version) + 1, 0);
 #endif
-	t->bios_release_date = smbios_add_prop(ctx, NULL, U_BOOT_DMI_DATE);
+	t->bios_release_date = smbios_add_prop_si(ctx, NULL,
+						  SYSID_SM_BIOS_REL_DATE,
+						  U_BOOT_DMI_DATE);
 #ifdef CONFIG_ROM_SIZE
 	if (CONFIG_ROM_SIZE < SZ_16M) {
 		t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
@@ -392,14 +433,13 @@ static int smbios_write_type1(ulong *current, int handle,
 	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
+
 	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
 					     SYSID_SM_SYSTEM_MANUFACTURER,
 					     NULL);
 	t->product_name = smbios_add_prop_si(ctx, "product",
-					     SYSID_SM_SYSTEM_PRODUCT,
-					     NULL);
-	t->version = smbios_add_prop_si(ctx, "version",
-					SYSID_SM_SYSTEM_VERSION,
+					     SYSID_SM_SYSTEM_PRODUCT, NULL);
+	t->version = smbios_add_prop_si(ctx, "version",	SYSID_SM_SYSTEM_VERSION,
 					NULL);
 	if (serial_str) {
 		t->serial_number = smbios_add_prop(ctx, NULL, serial_str);
@@ -409,11 +449,13 @@ static int smbios_write_type1(ulong *current, int handle,
 						      SYSID_SM_SYSTEM_SERIAL,
 						      NULL);
 	}
-	t->wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN;
-	t->sku_number = smbios_add_prop_si(ctx, "sku",
-					   SYSID_SM_SYSTEM_SKU, NULL);
-	t->family = smbios_add_prop_si(ctx, "family",
-				       SYSID_SM_SYSTEM_FAMILY, NULL);
+	t->wakeup_type = smbios_get_val_si(ctx, "wakeup-type",
+					   SYSID_SM_SYSTEM_WAKEUP,
+					   SMBIOS_WAKEUP_TYPE_UNKNOWN);
+	t->sku_number = smbios_add_prop_si(ctx, "sku", SYSID_SM_SYSTEM_SKU,
+					   NULL);
+	t->family = smbios_add_prop_si(ctx, "family", SYSID_SM_SYSTEM_FAMILY,
+				       NULL);
 
 	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
@@ -427,29 +469,49 @@ static int smbios_write_type2(ulong *current, int handle,
 {
 	struct smbios_type2 *t;
 	int len = sizeof(*t);
+	u8 *eos_addr;
 
+	/*
+	 * reserve the space for the dynamic bytes of contained object handles.
+	 * TODO: len += <obj_handle_num> * SMBIOS_TYPE2_CON_OBJ_HANDLE_SIZE
+	 * obj_handle_num can be from DT node "baseboard" or sysinfo driver.
+	 */
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
-	smbios_set_eos(ctx, t->eos);
+
+	/* eos is at the end of the structure */
+	eos_addr = (u8 *)t + len - sizeof(t->eos);
+	smbios_set_eos(ctx, eos_addr);
+
 	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
 					     SYSID_SM_BASEBOARD_MANUFACTURER,
 					     NULL);
 	t->product_name = smbios_add_prop_si(ctx, "product",
-					     SYSID_SM_BASEBOARD_PRODUCT,
-					     NULL);
+					     SYSID_SM_BASEBOARD_PRODUCT, NULL);
 	t->version = smbios_add_prop_si(ctx, "version",
-					SYSID_SM_BASEBOARD_VERSION,
-					NULL);
-
+					SYSID_SM_BASEBOARD_VERSION, NULL);
 	t->serial_number = smbios_add_prop_si(ctx, "serial",
-					      SYSID_SM_BASEBOARD_SERIAL,
-					      NULL);
+					      SYSID_SM_BASEBOARD_SERIAL, NULL);
 	t->asset_tag_number = smbios_add_prop_si(ctx, "asset-tag",
 						 SYSID_SM_BASEBOARD_ASSET_TAG,
 						 NULL);
-	t->feature_flags = SMBIOS_BOARD_FEAT_HOST_BOARD;
-	t->board_type = SMBIOS_BOARD_TYPE_MOTHERBOARD;
+	t->feature_flags = smbios_get_val_si(ctx, "feature-flags",
+					     SYSID_SM_BASEBOARD_FEATURE, 0);
+
+	t->chassis_location =
+		smbios_add_prop_si(ctx, "chassis-location",
+				   SYSID_SM_BASEBOARD_CHASSIS_LOCAT, NULL);
+	t->board_type =	smbios_get_val_si(ctx, "board-type",
+					  SYSID_SM_BASEBOARD_TYPE,
+					  SMBIOS_BOARD_TYPE_UNKNOWN);
+
+	/*
+	 * TODO:
+	 * Populate the Contained Object Handles if they exist
+	 * t->number_contained_objects = <obj_handle_num>;
+	 */
+
 	t->chassis_handle = handle + 1;
 
 	len = t->hdr.length + smbios_string_table_len(ctx);
@@ -464,17 +526,43 @@ static int smbios_write_type3(ulong *current, int handle,
 {
 	struct smbios_type3 *t;
 	int len = sizeof(*t);
+	u8 *eos_addr;
+	size_t elem_size = 0;
+
+	/*
+	 * reserve the space for the dynamic bytes of contained elements.
+	 * TODO: elem_size = <element_count> * <element_record_length>
+	 * element_count and element_record_length can be from DT node
+	 * "chassis" or sysinfo driver.
+	 */
+	len += elem_size;
 
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
-	smbios_set_eos(ctx, t->eos);
-	t->manufacturer = smbios_add_prop(ctx, "manufacturer", NULL);
-	t->chassis_type = SMBIOS_ENCLOSURE_DESKTOP;
-	t->bootup_state = SMBIOS_STATE_SAFE;
-	t->power_supply_state = SMBIOS_STATE_SAFE;
-	t->thermal_state = SMBIOS_STATE_SAFE;
-	t->security_status = SMBIOS_SECURITY_NONE;
+
+	/* eos is at the end of the structure */
+	eos_addr = (u8 *)t + len - sizeof(t->eos);
+	smbios_set_eos(ctx, eos_addr);
+
+	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
+					     SYSID_SM_ENCLOSURE_MANUFACTURER,
+					     NULL);
+	t->chassis_type = smbios_get_val_si(ctx, "chassis-type",
+					    SYSID_SM_ENCLOSURE_TYPE,
+					    SMBIOS_ENCLOSURE_UNKNOWN);
+	t->bootup_state = smbios_get_val_si(ctx, "bootup-state",
+					    SYSID_SM_ENCLOSURE_BOOTUP,
+					    SMBIOS_STATE_UNKNOWN);
+	t->power_supply_state = smbios_get_val_si(ctx, "power-supply-state",
+						  SYSID_SM_ENCLOSURE_POW,
+						  SMBIOS_STATE_UNKNOWN);
+	t->thermal_state = smbios_get_val_si(ctx, "thermal-state",
+					     SYSID_SM_ENCLOSURE_THERMAL,
+					     SMBIOS_STATE_UNKNOWN);
+	t->security_status = smbios_get_val_si(ctx, "security-status",
+					       SYSID_SM_ENCLOSURE_SECURITY,
+					       SMBIOS_SECURITY_UNKNOWN);
 
 	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
@@ -510,11 +598,25 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
 			name = processor_name;
 	}
 #endif
-
-	t->processor_family = 0xfe;
-	t->processor_family2 = processor_family;
-	t->processor_manufacturer = smbios_add_prop(ctx, NULL, vendor);
-	t->processor_version = smbios_add_prop(ctx, NULL, name);
+	if (processor_family == SMBIOS_PROCESSOR_FAMILY_UNKNOWN)
+		processor_family =
+			smbios_get_val_si(ctx, "family",
+					  SYSID_SM_PROCESSOR_FAMILY,
+					  SMBIOS_PROCESSOR_FAMILY_UNKNOWN);
+
+	if (processor_family == SMBIOS_PROCESSOR_FAMILY_EXT)
+		t->processor_family2 =
+			smbios_get_val_si(ctx, "family2",
+					  SYSID_SM_PROCESSOR_FAMILY2,
+					  SMBIOS_PROCESSOR_FAMILY_UNKNOWN);
+
+	t->processor_family = processor_family;
+	t->processor_manufacturer =
+		smbios_add_prop_si(ctx, "manufacturer",
+				   SYSID_SM_PROCESSOR_MANUFACT, vendor);
+	t->processor_version = smbios_add_prop_si(ctx, "version",
+						  SYSID_SM_PROCESSOR_VERSION,
+						  name);
 }
 
 static int smbios_write_type4(ulong *current, int handle,
@@ -527,13 +629,23 @@ static int smbios_write_type4(ulong *current, int handle,
 	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_PROCESSOR_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->processor_type = SMBIOS_PROCESSOR_TYPE_CENTRAL;
+	t->socket_design = smbios_add_prop_si(ctx, "socket-design",
+					      SYSID_SM_PROCESSOR_SOCKET, NULL);
+	t->processor_type = smbios_get_val_si(ctx, "processor-type",
+					      SYSID_SM_PROCESSOR_TYPE,
+					      SMBIOS_PROCESSOR_TYPE_UNKNOWN);
 	smbios_write_type4_dm(t, ctx);
-	t->status = SMBIOS_PROCESSOR_STATUS_ENABLED;
-	t->processor_upgrade = SMBIOS_PROCESSOR_UPGRADE_NONE;
-	t->l1_cache_handle = 0xffff;
-	t->l2_cache_handle = 0xffff;
-	t->l3_cache_handle = 0xffff;
+
+	t->status = smbios_get_val_si(ctx, "processor-status",
+				      SYSID_SM_PROCESSOR_STATUS,
+				      SMBIOS_PROCESSOR_STATUS_UNKNOWN);
+	t->processor_upgrade =
+		smbios_get_val_si(ctx, "upgrade", SYSID_SM_PROCESSOR_UPGRADE,
+				  SMBIOS_PROCESSOR_UPGRADE_UNKNOWN);
+
+	t->l1_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
+	t->l2_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
+	t->l3_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
 
 	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
@@ -581,7 +693,7 @@ static struct smbios_write_method smbios_write_funcs[] = {
 	{ smbios_write_type2, "baseboard", },
 	/* Type 3 must immediately follow type 2 due to chassis handle. */
 	{ smbios_write_type3, "chassis", },
-	{ smbios_write_type4, },
+	{ smbios_write_type4, "processor"},
 	{ smbios_write_type32, },
 	{ smbios_write_type127 },
 };
@@ -598,7 +710,7 @@ ulong write_smbios_table(ulong addr)
 	int i;
 
 	ctx.node = ofnode_null();
-	if (IS_ENABLED(CONFIG_OF_CONTROL) && CONFIG_IS_ENABLED(SYSINFO)) {
+	if (CONFIG_IS_ENABLED(SYSINFO)) {
 		uclass_first_device(UCLASS_SYSINFO, &ctx.dev);
 		if (ctx.dev) {
 			int ret;
-- 
2.25.1

