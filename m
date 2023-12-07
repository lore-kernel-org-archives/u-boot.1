Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F0FC4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 09:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83BF287243;
	Thu,  7 Dec 2023 10:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SyQQL6ZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C3C87243; Thu,  7 Dec 2023 10:19:04 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B8586FFE
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 10:19:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c2c65e6aaso1041145e9.2
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 01:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701940741; x=1702545541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vcf8Uy8SIKdN9TXuCeQubka7IJIfrvGMGj1JoUebFs0=;
 b=SyQQL6ZGyEFpFFqauSbHRSSNY+KOw9ohESTeXyy7RkWEEIFaK7yPwRRy9NZX+DJLAJ
 ECaT3Bchk61s+E1ZsuxrqdlxEYWDULw+4O2hm22gVZjL5L6r4+NwNgCHwzYW/bcro87o
 KEGRF7CXG50v6mvrjAOHoy2LbojZLR9d7fjO4gmGtihdnTMOW1cjtrX/3Seiy99QoTK6
 5Hs119W/hO0/5AE1VVSiIxV1Xx+qYcAHvQqcEEkBCKR2MpHTauUEonUf1LC5LKK2gKG5
 UEzq7XLrPki8hih4EcWsoctpdPp4kBtvpVSSshji9yxDX3EXKzcfA8xyqrB+5qKJU100
 zZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701940741; x=1702545541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcf8Uy8SIKdN9TXuCeQubka7IJIfrvGMGj1JoUebFs0=;
 b=L6Ejctx8u+W0IeEi5FfC1q0ah2NYKTScSheLqomwMY3Q4/BPiEUP7KUarxUKsRwI/3
 yP4rTVAXqlGbT6kFKq3jrxXlRS4HIRZxtFbgHZEKuBnXpkHCQpvQwKUcYY9QkbfdZEir
 5YYfONEv2yTHHfoiBZiVmcPARIQ5+2ra+k493og2Bm0Hk5dVWyaHn/YY6Y+FCWH7ZYn0
 Eq1M9Ng8YB3oMx63KwV9XHBURccH8UdCqwsNDvk2gWLKdSvrjlFD7ExiySd90+i9+6vN
 CMLoNESSYj2K9qW/sxbIDgUv1JwYCWgJrDejTzilfagawcPlKY2XtTnOlUsRryYrsPoq
 RbZg==
X-Gm-Message-State: AOJu0YxG7g4q8NdX+N/0Mp5YNkHEVHntPyakSqHCtdqDzgaRcQCbtF0q
 2APTVIQc7yNsT16/19bvkV1NRw3x7lZmC4YcT+s=
X-Google-Smtp-Source: AGHT+IFwnHtGX5IWm5lG5rRTsz6nU13lqUMnEUb8xEq/mngZuRtpzcNdrO7fNaBiIDDQLuKd+Y07Tw==
X-Received: by 2002:a05:600c:2184:b0:40b:dd1f:6dd1 with SMTP id
 e4-20020a05600c218400b0040bdd1f6dd1mr1312043wme.240.1701940741617; 
 Thu, 07 Dec 2023 01:19:01 -0800 (PST)
Received: from localhost.localdomain (ppp046103111243.access.hol.gr.
 [46.103.111.243]) by smtp.gmail.com with ESMTPSA id
 u21-20020a05600c139500b00405d9a950a2sm1299003wmf.28.2023.12.07.01.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 01:19:01 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: sean.anderson@seco.com, neil.armstrong@linaro.org,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 1/2 v3] smbios: Simplify reporting of unknown values
Date: Thu,  7 Dec 2023 11:18:49 +0200
Message-Id: <20231207091850.17776-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
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

If a value is not valid during the DT or SYSINFO parsing,  we explicitly
set that to "Unknown Product" and "Unknown" for the product and
manufacturer respectively.  It's cleaner if we move the checks insisde
smbios_add_prop_si() and provide an alternative string in case the
primary is NULL or empty

pre-patch dmidecode
<snip>
Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Unknown
        Product Name: Unknown Product
        Version: Not Specified
        Serial Number: Not Specified
        UUID: Not Settable
        Wake-up Type: Reserved
        SKU Number: Not Specified
        Family: Not Specified

[...]

post-patch dmidecode:

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Unknown
        Product Name: Unknown
        Version: Unknown
        Serial Number: Unknown
        UUID: Not Settable
        Wake-up Type: Reserved
        SKU Number: Unknown
        Family: Unknown
[...]

While at it make smbios_add_prop_si() add a string directly if the prop
node is NULL and replace smbios_add_string() calls with
smbios_add_prop_si(ctx, NULL, ....)

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v2:
- refactor even more code and remove the smbios_add_string calls from the
  main code. Instead use smbios_add_prop() foir everything and add a
  default value, in case the parsed one is NULL or emtpy
Changes since v1:
- None

 lib/smbios.c | 73 +++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index d7f4999e8b2a..444aa245a273 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -102,9 +102,6 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
 	int i = 1;
 	char *p = ctx->eos;

-	if (!*str)
-		str = "Unknown";
-
 	for (;;) {
 		if (!*p) {
 			ctx->last_str = p;
@@ -134,11 +131,18 @@ static int smbios_add_string(struct smbios_ctx *ctx, const char *str)
  *
  * @ctx:	context for writing the tables
  * @prop:	property to write
+ * @dval:	Default value to use if the string is not found or is empty
  * Return:	0 if not found, else SMBIOS string number (1 or more)
  */
 static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
-			      int sysinfo_id)
+			      int sysinfo_id, const char *dval)
 {
+	if (!dval || !*dval)
+		dval = "Unknown";
+
+	if (!prop)
+		return smbios_add_string(ctx, dval);
+
 	if (sysinfo_id && ctx->dev) {
 		char val[SMBIOS_STR_MAX];
 		int ret;
@@ -151,8 +155,8 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 		const char *str;

 		str = ofnode_read_string(ctx->node, prop);
-		if (str)
-			return smbios_add_string(ctx, str);
+
+		return smbios_add_string(ctx, str ? str : dval);
 	}

 	return 0;
@@ -161,12 +165,15 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 /**
  * smbios_add_prop() - Add a property from the devicetree
  *
- * @prop:	property to write
+ * @prop:	property to write. The default string will be written if
+ *		prop is NULL
+ * @dval:	Default value to use if the string is not found or is empty
  * Return:	0 if not found, else SMBIOS string number (1 or more)
  */
-static int smbios_add_prop(struct smbios_ctx *ctx, const char *prop)
+static int smbios_add_prop(struct smbios_ctx *ctx, const char *prop,
+			   const char *dval)
 {
-	return smbios_add_prop_si(ctx, prop, SYSINFO_ID_NONE);
+	return smbios_add_prop_si(ctx, prop, SYSINFO_ID_NONE, dval);
 }

 static void smbios_set_eos(struct smbios_ctx *ctx, char *eos)
@@ -228,11 +235,9 @@ static int smbios_write_type0(ulong *current, int handle,
 	memset(t, 0, sizeof(struct smbios_type0));
 	fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->vendor = smbios_add_string(ctx, "U-Boot");
+	t->vendor = smbios_add_prop(ctx, NULL, "U-Boot");

-	t->bios_ver = smbios_add_prop(ctx, "version");
-	if (!t->bios_ver)
-		t->bios_ver = smbios_add_string(ctx, PLAIN_VERSION);
+	t->bios_ver = smbios_add_prop(ctx, "version", PLAIN_VERSION);
 	if (t->bios_ver)
 		gd->smbios_version = ctx->last_str;
 	log_debug("smbios_version = %p: '%s'\n", gd->smbios_version,
@@ -241,7 +246,7 @@ static int smbios_write_type0(ulong *current, int handle,
 	print_buffer((ulong)gd->smbios_version, gd->smbios_version,
 		     1, strlen(gd->smbios_version) + 1, 0);
 #endif
-	t->bios_release_date = smbios_add_string(ctx, U_BOOT_DMI_DATE);
+	t->bios_release_date = smbios_add_prop(ctx, NULL, U_BOOT_DMI_DATE);
 #ifdef CONFIG_ROM_SIZE
 	t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
 #endif
@@ -280,22 +285,19 @@ static int smbios_write_type1(ulong *current, int handle,
 	memset(t, 0, sizeof(struct smbios_type1));
 	fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->manufacturer = smbios_add_prop(ctx, "manufacturer");
-	if (!t->manufacturer)
-		t->manufacturer = smbios_add_string(ctx, "Unknown");
-	t->product_name = smbios_add_prop(ctx, "product");
-	if (!t->product_name)
-		t->product_name = smbios_add_string(ctx, "Unknown Product");
+	t->manufacturer = smbios_add_prop(ctx, "manufacturer", "Unknown");
+	t->product_name = smbios_add_prop(ctx, "product", "Unknown");
 	t->version = smbios_add_prop_si(ctx, "version",
-					SYSINFO_ID_SMBIOS_SYSTEM_VERSION);
+					SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
+					"Unknown");
 	if (serial_str) {
-		t->serial_number = smbios_add_string(ctx, serial_str);
+		t->serial_number = smbios_add_prop(ctx, NULL, serial_str);
 		strncpy((char *)t->uuid, serial_str, sizeof(t->uuid));
 	} else {
-		t->serial_number = smbios_add_prop(ctx, "serial");
+		t->serial_number = smbios_add_prop(ctx, "serial", "Unknown");
 	}
-	t->sku_number = smbios_add_prop(ctx, "sku");
-	t->family = smbios_add_prop(ctx, "family");
+	t->sku_number = smbios_add_prop(ctx, "sku", "Unknown");
+	t->family = smbios_add_prop(ctx, "family", "Unknown");

 	len = t->length + smbios_string_table_len(ctx);
 	*current += len;
@@ -314,15 +316,12 @@ static int smbios_write_type2(ulong *current, int handle,
 	memset(t, 0, sizeof(struct smbios_type2));
 	fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->manufacturer = smbios_add_prop(ctx, "manufacturer");
-	if (!t->manufacturer)
-		t->manufacturer = smbios_add_string(ctx, "Unknown");
-	t->product_name = smbios_add_prop(ctx, "product");
-	if (!t->product_name)
-		t->product_name = smbios_add_string(ctx, "Unknown Product");
+	t->manufacturer = smbios_add_prop(ctx, "manufacturer", "Unknown");
+	t->product_name = smbios_add_prop(ctx, "product", "Unknown");
 	t->version = smbios_add_prop_si(ctx, "version",
-					SYSINFO_ID_SMBIOS_BASEBOARD_VERSION);
-	t->asset_tag_number = smbios_add_prop(ctx, "asset-tag");
+					SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
+					"Unknown");
+	t->asset_tag_number = smbios_add_prop(ctx, "asset-tag", "Unknown");
 	t->feature_flags = SMBIOS_BOARD_FEATURE_HOSTING;
 	t->board_type = SMBIOS_BOARD_MOTHERBOARD;

@@ -343,9 +342,7 @@ static int smbios_write_type3(ulong *current, int handle,
 	memset(t, 0, sizeof(struct smbios_type3));
 	fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->manufacturer = smbios_add_prop(ctx, "manufacturer");
-	if (!t->manufacturer)
-		t->manufacturer = smbios_add_string(ctx, "Unknown");
+	t->manufacturer = smbios_add_prop(ctx, "manufacturer", "Unknown");
 	t->chassis_type = SMBIOS_ENCLOSURE_DESKTOP;
 	t->bootup_state = SMBIOS_STATE_SAFE;
 	t->power_supply_state = SMBIOS_STATE_SAFE;
@@ -388,8 +385,8 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
 #endif

 	t->processor_family = processor_family;
-	t->processor_manufacturer = smbios_add_string(ctx, vendor);
-	t->processor_version = smbios_add_string(ctx, name);
+	t->processor_manufacturer = smbios_add_prop(ctx, NULL, vendor);
+	t->processor_version = smbios_add_prop(ctx, NULL, name);
 }

 static int smbios_write_type4(ulong *current, int handle,
--
2.40.1

