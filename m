Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5874CDD0E1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 20:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C3388FD6;
	Tue, 22 Oct 2024 22:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IQN0/5Kz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B004288FD6; Tue, 22 Oct 2024 22:07:13 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE71A892CB
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 22:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cbe8119e21so43504486d6.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729627628; x=1730232428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmvLYoekOF9Ag+DYm+N/C5gip1rDM57XGxQQpA3NIJg=;
 b=IQN0/5KzDvr4mI49jLFIaXNkf9fOp3iwKurwC7uvruzUwwk2itbvkM7d+DKm5+ibLD
 MYWS9gVgoPbCf37MswjpTiAUxQuArJtpE63ulSJWS4kGBhRj44u+uftyxdlb0c3NOVIm
 VqGas0CltF5CHf2VJxMz+O31vSa97tDM03ZRtBfvjbx2oahfDmWA4FlybYUR92W8dDPd
 K1B0LQ+xksZg1UiuR0InJsaqRJ6bTt9uxCVXcY+Cu4EEJF68v+WKv7H4g533NgJUj4ap
 nSDifqt1HjFcuCy0DstWcbAq/CZk6OL+3qKtzwWvkb1mtEoZTxGTWA3oooFIOyfAW5pJ
 +imA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729627628; x=1730232428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qmvLYoekOF9Ag+DYm+N/C5gip1rDM57XGxQQpA3NIJg=;
 b=Dfdqy9qaKMynmoumKQZDvkCSwgZxLYYsGhlk5J5XJzxZCWgN1TajDCAPoQnD2wJHAU
 AfiekNNf5xbPPO0BS51HOyqbItUVS/d3L9wiq4JL3Vq4dMn7i5KPJQWxvlzDoq4SfNeO
 jaH6oxDeIfnM0bA0AoJ6okTlWQCV32tmZQFa5/ivHLmmmEUreMEnkDixviXufruKL5Fw
 EJeuO1/J7nNhqsZ0ecZY5kL3T25BjkvNm/hGXiHK+GjVhdnC2TmUR3/soNDzqzA0fNbX
 PqDvOwYuAffBo/t0PepJ0DHnYPEKa6SpK0o3USj9+d8LGecwuAFurjmblRzE06l1TYbo
 mUKg==
X-Gm-Message-State: AOJu0YyFYl2w++tmPoyox4rhBfTVFWb0ZqoxW5nTLWDPSJeGhhsEuWqy
 pMxERJOQIuTewcUWYD5d6Oc8R5raTDoialAJomMyCCB959ATCtnxZDzFR4GEGvpr5lCMB9fCCKV
 J4wo=
X-Google-Smtp-Source: AGHT+IHXJRnhGEdLpIHeGl3QqinItGDywdpPIEYBRs7ENGjQ0nTxdt3E/1EQM5WDHjm6FEBCd7z8dw==
X-Received: by 2002:a05:6214:5890:b0:6cb:e944:c1a9 with SMTP id
 6a1803df08f44-6ce342b481bmr3472066d6.31.1729627628436; 
 Tue, 22 Oct 2024 13:07:08 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce0091a255sm32519956d6.59.2024.10.22.13.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 13:07:07 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: iwamatsu@nigauri.org, marek.vasut+renesas@mailbox.org,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Angelo Dureghello <angelo@kernel-space.org>,
 Alexander Gendin <agendin@matrox.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 4/8] smbios: Refactor smbios library
Date: Tue, 22 Oct 2024 13:05:25 -0700
Message-Id: <20241022200543.116343-5-raymond.mao@linaro.org>
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

Current smbios library does not fully match to the specification.
It hardcodes values instead of exposing values from the device.
It does not support dynamic length for contained object handles
or elements and misses the handling of a few of fields.

The refactoring of this patch includes:
1. Expose values from device via sysinfo interface.
2. Replace smbios_add_prop with smbios_add_prop_si to allow getting
   string values from sysinfo.
3. Add smbios_get_val_si to get int values from sysinfo.
4. Use sysinfo_get_data to get data area.
5. Miscellaneous fixes in smbios.

Moreover, this patch adds SMBIOS type 7 (cache information) write
functions.
Link cache handles from type 7 to type 4.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Combine with #7(v1) patch.
- Move the changes of cmd/smbios.c to a separated patch.
- Refactor smbios_get_val_si to get values from dt when values are
   not available from sysinfo driver.
- Miscellaneous refactoring.

 include/smbios.h |  14 +-
 lib/smbios.c     | 420 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 383 insertions(+), 51 deletions(-)

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
 
diff --git a/lib/smbios.c b/lib/smbios.c
index 886c40e7594..c2763d036a7 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -206,6 +206,34 @@ void get_str_from_dt(const struct map_sysinfo *nprop, char *str, size_t size)
 	}
 }
 
+/**
+ * smbios_get_val_si() - Get value from the devicetree or sysinfo
+ *
+ * @ctx:	context of SMBIOS
+ * @prop:	property to read
+ * @sysinfo_id: unique identifier for the value to be read
+ * Return:	0 if not found, else value from the devicetree or sysinfo
+ */
+static int smbios_get_val_si(struct smbios_ctx *ctx, const char *prop,
+			     int sysinfo_id)
+{
+	int val;
+
+	if (!sysinfo_id || !ctx->dev)
+		return 0;
+
+	if (!sysinfo_get_int(ctx->dev, sysinfo_id, &val))
+		return val;
+
+	if (!IS_ENABLED(CONFIG_OF_CONTROL) || !prop || !ofnode_valid(ctx->node))
+		return 0;
+
+	if (!ofnode_read_u32(ctx->node, prop, &val))
+		return val;
+
+	return 0;
+}
+
 /**
  * smbios_add_prop_si() - Add a property from the devicetree or sysinfo
  *
@@ -225,9 +253,6 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 	if (!dval || !*dval)
 		dval = NULL;
 
-	if (!prop)
-		return smbios_add_string(ctx, dval);
-
 	if (sysinfo_id && ctx->dev) {
 		char val[SMBIOS_STR_MAX];
 
@@ -235,6 +260,9 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 		if (!ret)
 			return smbios_add_string(ctx, val);
 	}
+	if (!prop)
+		return smbios_add_string(ctx, dval);
+
 	if (IS_ENABLED(CONFIG_OF_CONTROL)) {
 		const char *str = NULL;
 		char str_dt[128] = { 0 };
@@ -336,9 +364,12 @@ static int smbios_write_type0(ulong *current, int handle,
 	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->vendor = smbios_add_prop(ctx, NULL, "U-Boot");
+	t->vendor = smbios_add_prop_si(ctx, NULL, SYSINFO_ID_SMBIOS_BIOS_VENDOR,
+				       "U-Boot");
 
-	t->bios_ver = smbios_add_prop(ctx, "version", PLAIN_VERSION);
+	t->bios_ver = smbios_add_prop_si(ctx, "version",
+					 SYSINFO_ID_SMBIOS_BIOS_VER,
+					 PLAIN_VERSION);
 	if (t->bios_ver)
 		gd->smbios_version = ctx->last_str;
 	log_debug("smbios_version = %p: '%s'\n", gd->smbios_version,
@@ -347,7 +378,9 @@ static int smbios_write_type0(ulong *current, int handle,
 	print_buffer((ulong)gd->smbios_version, gd->smbios_version,
 		     1, strlen(gd->smbios_version) + 1, 0);
 #endif
-	t->bios_release_date = smbios_add_prop(ctx, NULL, U_BOOT_DMI_DATE);
+	t->bios_release_date =
+		smbios_add_prop_si(ctx, NULL, SYSINFO_ID_SMBIOS_BIOS_REL_DATE,
+				   U_BOOT_DMI_DATE);
 #ifdef CONFIG_ROM_SIZE
 	if (CONFIG_ROM_SIZE < SZ_16M) {
 		t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
@@ -392,9 +425,11 @@ static int smbios_write_type1(ulong *current, int handle,
 	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
-					     SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER,
-					     NULL);
+
+	t->manufacturer =
+		smbios_add_prop_si(ctx, "manufacturer",
+				   SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER,
+				   NULL);
 	t->product_name = smbios_add_prop_si(ctx, "product",
 					     SYSINFO_ID_SMBIOS_SYSTEM_PRODUCT,
 					     NULL);
@@ -405,11 +440,14 @@ static int smbios_write_type1(ulong *current, int handle,
 		t->serial_number = smbios_add_prop(ctx, NULL, serial_str);
 		strlcpy((char *)t->uuid, serial_str, sizeof(t->uuid));
 	} else {
-		t->serial_number = smbios_add_prop_si(ctx, "serial",
-						      SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
-						      NULL);
+		t->serial_number =
+			smbios_add_prop_si(ctx, "serial",
+					   SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
+					   NULL);
 	}
-	t->wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN;
+	t->wakeup_type =
+		smbios_get_val_si(ctx, "wakeup-type",
+				  SYSINFO_ID_SMBIOS_SYSTEM_WAKEUP);
 	t->sku_number = smbios_add_prop_si(ctx, "sku",
 					   SYSINFO_ID_SMBIOS_SYSTEM_SKU, NULL);
 	t->family = smbios_add_prop_si(ctx, "family",
@@ -427,29 +465,59 @@ static int smbios_write_type2(ulong *current, int handle,
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
-	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
-					     SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
-					     NULL);
-	t->product_name = smbios_add_prop_si(ctx, "product",
-					     SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
-					     NULL);
-	t->version = smbios_add_prop_si(ctx, "version",
-					SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
-					NULL);
 
-	t->serial_number = smbios_add_prop_si(ctx, "serial",
-					      SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL,
-					      NULL);
-	t->asset_tag_number = smbios_add_prop_si(ctx, "asset-tag",
-						 SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
-						 NULL);
-	t->feature_flags = SMBIOS_BOARD_FEAT_HOST_BOARD;
-	t->board_type = SMBIOS_BOARD_TYPE_MOTHERBOARD;
+	/* eos is at the end of the structure */
+	eos_addr = (u8 *)t + len - sizeof(t->eos);
+	smbios_set_eos(ctx, eos_addr);
+
+	t->manufacturer =
+		smbios_add_prop_si(ctx, "manufacturer",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
+				   NULL);
+	t->product_name =
+		smbios_add_prop_si(ctx, "product",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
+				   NULL);
+	t->version =
+		smbios_add_prop_si(ctx, "version",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
+				   NULL);
+	t->serial_number =
+		smbios_add_prop_si(ctx, "serial",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL,
+				   NULL);
+	t->asset_tag_number =
+		smbios_add_prop_si(ctx, "asset-tag",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
+				   NULL);
+	t->feature_flags =
+		smbios_get_val_si(ctx, "feature-flags",
+				  SYSINFO_ID_SMBIOS_BASEBOARD_FEATURE);
+
+	t->chassis_location =
+		smbios_add_prop_si(ctx, "chassis-location",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_CHASSIS_LOCAT,
+				   NULL);
+	t->board_type =
+		smbios_get_val_si(ctx, "board-type",
+				  SYSINFO_ID_SMBIOS_BASEBOARD_TYPE);
+
+	/*
+	 * TODO:
+	 * Populate the Contained Object Handles if they exist
+	 * t->number_contained_objects = <obj_handle_num>;
+	 */
+
 	t->chassis_handle = handle + 1;
 
 	len = t->hdr.length + smbios_string_table_len(ctx);
@@ -464,17 +532,73 @@ static int smbios_write_type3(ulong *current, int handle,
 {
 	struct smbios_type3 *t;
 	int len = sizeof(*t);
+	u8 *elem_addr, *eos_addr, *sku_num_addr;
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
+	elem_addr = (u8 *)t + offsetof(struct smbios_type3, sku_number);
+	sku_num_addr = elem_addr + elem_size;
+
+	/* eos is at the end of the structure */
+	eos_addr = (u8 *)t + len - sizeof(t->eos);
+	smbios_set_eos(ctx, eos_addr);
+
+	t->manufacturer =
+		smbios_add_prop_si(ctx, "manufacturer",
+				   SYSINFO_ID_SMBIOS_ENCLOSURE_MANUFACTURER,
+				   NULL);
+
+	t->chassis_type = smbios_get_val_si(ctx, "chassis-type",
+					    SYSINFO_ID_SMBIOS_ENCLOSURE_TYPE);
+	t->version = smbios_add_prop_si(ctx, "version",
+					SYSINFO_ID_SMBIOS_ENCLOSURE_VERSION,
+					NULL);
+	t->serial_number =
+		smbios_add_prop_si(ctx, "serial",
+				   SYSINFO_ID_SMBIOS_ENCLOSURE_SERIAL,
+				   NULL);
+	t->asset_tag_number =
+		smbios_add_prop_si(ctx, "asset-tag",
+				   SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
+				   NULL);
+	t->bootup_state = smbios_get_val_si(ctx, "bootup-state",
+					    SYSINFO_ID_SMBIOS_ENCLOSURE_BOOTUP);
+	t->power_supply_state =
+		smbios_get_val_si(ctx, "power-supply-state",
+				  SYSINFO_ID_SMBIOS_ENCLOSURE_POW);
+	t->thermal_state =
+		smbios_get_val_si(ctx, "thermal-state",
+				  SYSINFO_ID_SMBIOS_ENCLOSURE_THERMAL);
+	t->security_status =
+		smbios_get_val_si(ctx, "security-status",
+				  SYSINFO_ID_SMBIOS_ENCLOSURE_SECURITY);
+	t->oem_defined = smbios_get_val_si(ctx, "oem-defined",
+					   SYSINFO_ID_SMBIOS_ENCLOSURE_OEM);
+	t->height = smbios_get_val_si(ctx, "height",
+				      SYSINFO_ID_SMBIOS_ENCLOSURE_HEIGHT);
+	t->number_of_power_cords =
+		smbios_get_val_si(ctx, "number-of-power-cords",
+				  SYSINFO_ID_SMBIOS_ENCLOSURE_POWCORE_NUM);
+
+	/*
+	 * TODO: Populate the Contained Element Record if they exist
+	 * t->element_count = <element_num>;
+	 * t->element_record_length = <element_len>;
+	 */
+
+	*sku_num_addr =
+		smbios_add_prop_si(ctx, "sku", SYSINFO_ID_SMBIOS_ENCLOSURE_SKU,
+				   NULL);
 
 	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
@@ -489,6 +613,8 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
 	u16 processor_family = SMBIOS_PROCESSOR_FAMILY_UNKNOWN;
 	const char *vendor = NULL;
 	const char *name = NULL;
+	u8 *id_data = NULL;
+	size_t id_size = 0;
 
 #ifdef CONFIG_CPU
 	char processor_name[49];
@@ -510,11 +636,33 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
 			name = processor_name;
 	}
 #endif
+	if (processor_family == SMBIOS_PROCESSOR_FAMILY_UNKNOWN)
+		processor_family =
+			smbios_get_val_si(ctx, "family",
+					  SYSINFO_ID_SMBIOS_PROCESSOR_FAMILY);
+
+	if (processor_family == SMBIOS_PROCESSOR_FAMILY_EXT)
+		t->processor_family2 =
+			smbios_get_val_si(ctx, "family2",
+					  SYSINFO_ID_SMBIOS_PROCESSOR_FAMILY2);
+
+	t->processor_family = processor_family;
+	t->processor_manufacturer =
+		smbios_add_prop_si(ctx, "manufacturer",
+				   SYSINFO_ID_SMBIOS_PROCESSOR_MANUFACT,
+				   vendor);
+	t->processor_version =
+		smbios_add_prop_si(ctx, "version",
+				   SYSINFO_ID_SMBIOS_PROCESSOR_VERSION,
+				   name);
+
+	if (t->processor_id[0] || t->processor_id[1] ||
+	    sysinfo_get_data(ctx->dev, SYSINFO_ID_SMBIOS_PROCESSOR_ID,
+			     &id_data, &id_size))
+		return;
 
-	t->processor_family = 0xfe;
-	t->processor_family2 = processor_family;
-	t->processor_manufacturer = smbios_add_prop(ctx, NULL, vendor);
-	t->processor_version = smbios_add_prop(ctx, NULL, name);
+	if (id_data && id_size == sizeof(t->processor_id))
+		memcpy((u8 *)t->processor_id, id_data, id_size);
 }
 
 static int smbios_write_type4(ulong *current, int handle,
@@ -522,18 +670,96 @@ static int smbios_write_type4(ulong *current, int handle,
 {
 	struct smbios_type4 *t;
 	int len = sizeof(*t);
+	u8 *hdl;
+	size_t hdl_size;
 
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_PROCESSOR_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->processor_type = SMBIOS_PROCESSOR_TYPE_CENTRAL;
+	t->socket_design =
+		smbios_add_prop_si(ctx, "socket-design",
+				   SYSINFO_ID_SMBIOS_PROCESSOR_SOCKET,
+				   NULL);
+	t->processor_type =
+		smbios_get_val_si(ctx, "processor-type",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_TYPE);
 	smbios_write_type4_dm(t, ctx);
-	t->status = SMBIOS_PROCESSOR_STATUS_ENABLED;
-	t->processor_upgrade = SMBIOS_PROCESSOR_UPGRADE_NONE;
-	t->l1_cache_handle = 0xffff;
-	t->l2_cache_handle = 0xffff;
-	t->l3_cache_handle = 0xffff;
+
+	t->voltage =
+		smbios_get_val_si(ctx, "voltage",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_VOLTAGE);
+	t->external_clock =
+		smbios_get_val_si(ctx, "external-clock",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_EXT_CLOCK);
+	t->max_speed =
+		smbios_get_val_si(ctx, "max-speed",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_MAX_SPEED);
+	t->current_speed =
+		smbios_get_val_si(ctx, "current-speed",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_CUR_SPEED);
+	t->status =
+		smbios_get_val_si(ctx, "processor-status",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_STATUS);
+	t->processor_upgrade =
+		smbios_get_val_si(ctx, "upgrade",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_UPGRADE);
+
+	t->l1_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
+	t->l2_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
+	t->l3_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
+
+	/* Read the cache handles */
+	if (!sysinfo_get_data(ctx->dev, SYSINFO_ID_SMBIOS_CACHE_HANDLE,
+			      &hdl, &hdl_size) &&
+	    (hdl_size == SYSINFO_CACHE_LVL_MAX * sizeof(u16))) {
+		u16 *handle = (u16 *)hdl;
+
+		if (*handle)
+			t->l1_cache_handle = *handle;
+
+		handle++;
+		if (*handle)
+			t->l2_cache_handle = *handle;
+
+		handle++;
+		if (*handle)
+			t->l3_cache_handle = *handle;
+	}
+
+	t->serial_number = smbios_add_prop_si(ctx, "serial",
+					      SYSINFO_ID_SMBIOS_PROCESSOR_SN,
+					      NULL);
+	t->asset_tag = smbios_add_prop_si(ctx, "asset-tag",
+					  SYSINFO_ID_SMBIOS_PROCESSOR_ASSET_TAG,
+					  NULL);
+	t->part_number = smbios_add_prop_si(ctx, "part-number",
+					    SYSINFO_ID_SMBIOS_PROCESSOR_PN,
+					    NULL);
+	t->core_count =
+		smbios_get_val_si(ctx, "core-count",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT);
+	t->core_enabled =
+		smbios_get_val_si(ctx, "core-enabled",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN);
+	t->thread_count =
+		smbios_get_val_si(ctx, "thread-count",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT);
+	t->processor_characteristics =
+		smbios_get_val_si(ctx, "characteristics",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_CHARA);
+	t->core_count2 =
+		smbios_get_val_si(ctx, "core-count2",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT2);
+	t->core_enabled2 =
+		smbios_get_val_si(ctx, "core-enabled2",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN2);
+	t->thread_count2 =
+		smbios_get_val_si(ctx, "thread-count2",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT2);
+	t->thread_enabled =
+		smbios_get_val_si(ctx, "thread-enabled",
+				  SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_EN);
 
 	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
@@ -542,6 +768,98 @@ static int smbios_write_type4(ulong *current, int handle,
 	return len;
 }
 
+static int smbios_write_type7_1level(ulong *current, int handle,
+				     struct smbios_ctx *ctx, int level)
+{
+	struct smbios_type7 *t;
+	int len = sizeof(*t);
+	u8 *hdl;
+	size_t hdl_size;
+
+	t = map_sysmem(*current, len);
+	memset(t, 0, len);
+	fill_smbios_header(t, SMBIOS_CACHE_INFORMATION, len, handle);
+	smbios_set_eos(ctx, t->eos);
+
+	t->socket_design =
+		smbios_add_prop_si(ctx, "socket-design",
+				   SYSINFO_ID_SMBIOS_CACHE_SOCKET + level,
+				   NULL);
+	t->config.data =
+		smbios_get_val_si(ctx, "config",
+				  SYSINFO_ID_SMBIOS_CACHE_CONFIG + level);
+	t->max_size.data =
+		smbios_get_val_si(ctx, "max-size",
+				  SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE + level);
+	t->inst_size.data =
+		smbios_get_val_si(ctx, "installed-size",
+				  SYSINFO_ID_SMBIOS_CACHE_INST_SIZE + level);
+	t->supp_sram_type.data =
+		smbios_get_val_si(ctx, "supported-sram-type",
+				  SYSINFO_ID_SMBIOS_CACHE_SUPSRAM_TYPE + level);
+	t->curr_sram_type.data =
+		smbios_get_val_si(ctx, "current-sram-type",
+				  SYSINFO_ID_SMBIOS_CACHE_CURSRAM_TYPE + level);
+	t->speed = smbios_get_val_si(ctx, "speed",
+				     SYSINFO_ID_SMBIOS_CACHE_SPEED + level);
+	t->err_corr_type =
+		smbios_get_val_si(ctx, "error-correction-type",
+				  SYSINFO_ID_SMBIOS_CACHE_ERRCOR_TYPE + level);
+	t->sys_cache_type =
+		smbios_get_val_si(ctx, "system-cache-type",
+				  SYSINFO_ID_SMBIOS_CACHE_SCACHE_TYPE + level);
+	t->associativity =
+		smbios_get_val_si(ctx, "associativity",
+				  SYSINFO_ID_SMBIOS_CACHE_ASSOC + level);
+	t->max_size2.data =
+		smbios_get_val_si(ctx, "max-size2",
+				  SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE2 + level);
+	t->inst_size2.data =
+		smbios_get_val_si(ctx, "installed-size2",
+				  SYSINFO_ID_SMBIOS_CACHE_INST_SIZE2 + level);
+
+	/* Save the cache handles */
+	if (!sysinfo_get_data(ctx->dev, SYSINFO_ID_SMBIOS_CACHE_HANDLE,
+			      &hdl, &hdl_size)) {
+		if (hdl_size == SYSINFO_CACHE_LVL_MAX * sizeof(u16))
+			*((u16 *)hdl + level) = handle;
+	}
+
+	len = t->hdr.length + smbios_string_table_len(ctx);
+	*current += len;
+	unmap_sysmem(t);
+
+	return len;
+}
+
+static int smbios_write_type7(ulong *current, int handle,
+			      struct smbios_ctx *ctx)
+{
+	int len = 0;
+	int i, level;
+	ofnode parent = ctx->node;
+	struct smbios_ctx ctx_bak;
+
+	memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
+
+	/* Get the number of level */
+	level =	smbios_get_val_si(ctx, NULL, SYSINFO_ID_SMBIOS_CACHE_LEVEL);
+	if (level >= SYSINFO_CACHE_LVL_MAX) /* Error, return 0-length */
+		return 0;
+
+	for (i = 0; i <= level; i++) {
+		char buf[9] = "";
+
+		if (!snprintf(buf, sizeof(buf), "l%d-cache", i + 1))
+			return 0;
+		ctx->subnode_name = buf;
+		ctx->node = ofnode_find_subnode(parent, ctx->subnode_name);
+		len += smbios_write_type7_1level(current, handle++, ctx, i);
+		memcpy(ctx, &ctx_bak, sizeof(*ctx));
+	}
+	return len;
+}
+
 static int smbios_write_type32(ulong *current, int handle,
 			       struct smbios_ctx *ctx)
 {
@@ -581,7 +899,9 @@ static struct smbios_write_method smbios_write_funcs[] = {
 	{ smbios_write_type2, "baseboard", },
 	/* Type 3 must immediately follow type 2 due to chassis handle. */
 	{ smbios_write_type3, "chassis", },
-	{ smbios_write_type4, },
+	/* Type 7 must ahead of type 4 to get cache handles. */
+	{ smbios_write_type7, "cache", },
+	{ smbios_write_type4, "processor"},
 	{ smbios_write_type32, },
 	{ smbios_write_type127 },
 };
@@ -598,7 +918,7 @@ ulong write_smbios_table(ulong addr)
 	int i;
 
 	ctx.node = ofnode_null();
-	if (IS_ENABLED(CONFIG_OF_CONTROL) && CONFIG_IS_ENABLED(SYSINFO)) {
+	if (CONFIG_IS_ENABLED(SYSINFO)) {
 		uclass_first_device(UCLASS_SYSINFO, &ctx.dev);
 		if (ctx.dev) {
 			int ret;
-- 
2.25.1

