Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E59D767F4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 17:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 410D188B0C;
	Thu, 31 Oct 2024 18:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FzJlPAlu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E9688A4C; Thu, 31 Oct 2024 18:50:51 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D7388B55
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 18:50:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cb6b2b7127so1607945a12.1
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397048; x=1731001848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=py4e7M+ibypEHh/opX8+oYPXbZFxbFrWexVDT+HVz2o=;
 b=FzJlPAluUbyjV34wy9iItAfhq+9WxslrehkIOb0hM6zxrgtLa2BPz9DF5twH/Ry/Bq
 ixQVw3GYl3DdiBi4hEuqrlzPNxJIvy0P/pFn0p0dycJsexO14zTJYy+rS1Ho/hojntCC
 Ext6KuuKedkTjYQkDBwRdr82MPBwGU10Z9MTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397048; x=1731001848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=py4e7M+ibypEHh/opX8+oYPXbZFxbFrWexVDT+HVz2o=;
 b=Ji8fT6ZBf6ZOxxVAkhtVL9gPXwFgcvvKGBT5ow7g0wZPbURJZzlmMZaQIH7FHHbeJ7
 DRrYuC4eGzxDRrGZhscPYlwm7IBZ8opXedUEuwXuQwKRhuz83hYVth2J1UG0oDtAihGN
 48TBANa/ch87bMn7kZShbUXkdBsanRpcWPwDXlhADvfWr7CwDTaXjKabmD43ScAte3vG
 DAjBQEjOTatwIqbdYRmNPxXqIC5fuPL+L5lxtQIAplnJWoPDnmQOcHYLypkhp6bdRC3G
 mMcqS+SGwEj/uTZFitotpaNL4DWY9Xw/SUZGIRyWEuLTIj2zLMPaYSpmpq5lOyQV4uF7
 QPEA==
X-Gm-Message-State: AOJu0YxisfQB/sX4JLVpbU0BhRn//nwmBjRmJwooCFrP+aV+kqdTsGiJ
 jmxGDWlTYogW3q6VPLDPsowaA/EclliCuELCWkBjGr/8xbU0hS9hjpEqeJO7dSCY2zON7/0Raby
 V0Q==
X-Google-Smtp-Source: AGHT+IEmvyeH2gliXP4F2VkOM9cjINRE9P/Abo0df95aH3+ZELn9AD70iH5mGpVRfGP44datc7dY8A==
X-Received: by 2002:a05:6402:520b:b0:5c9:6f20:4cf1 with SMTP id
 4fb4d7f45d1cf-5cea971b4b5mr3827565a12.27.1730397047457; 
 Thu, 31 Oct 2024 10:50:47 -0700 (PDT)
Received: from chromium.org ([82.132.224.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ceac7ccaecsm765079a12.62.2024.10.31.10.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:50:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Raymond Mao <raymond.mao@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] dm: sysinfo: Shorten the SYSINFO_ID prefix
Date: Thu, 31 Oct 2024 18:50:23 +0100
Message-ID: <20241031175025.74124-1-sjg@chromium.org>
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

We are about to add a large number of new entries. Update the prefix to
be a little shorter.

For SMBIOS items, use SYSID_SM_ (for System Management) which is enough
to distinguish it. For now at least, it seems that most items will be
for SMBIOS.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/coreboot/coreboot/sysinfo.c     |  8 +++----
 board/google/chromebook_coral/coral.c |  6 ++---
 board/toradex/common/tdx-common.c     |  2 +-
 common/board_info.c                   |  8 +++----
 drivers/sysinfo/gazerbeam.h           |  4 ++--
 drivers/sysinfo/gpio.c                |  4 ++--
 drivers/sysinfo/rcar3.c               |  2 +-
 drivers/sysinfo/sandbox.h             |  2 +-
 include/sysinfo.h                     | 34 +++++++++++++--------------
 lib/smbios.c                          | 24 +++++++++----------
 test/dm/sysinfo-gpio.c                | 12 +++++-----
 11 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/board/coreboot/coreboot/sysinfo.c b/board/coreboot/coreboot/sysinfo.c
index e0bdc7a5a88..d6b19530023 100644
--- a/board/coreboot/coreboot/sysinfo.c
+++ b/board/coreboot/coreboot/sysinfo.c
@@ -24,21 +24,21 @@ static int cb_get_str(struct udevice *dev, int id, size_t size, char *val)
 	const char *str = NULL;
 
 	switch (id) {
-	case SYSINFO_ID_BOARD_MODEL:
+	case SYSID_BOARD_MODEL:
 		if (priv->t1)
 			str = smbios_string(priv->system,
 					    priv->t1->product_name);
 		break;
-	case SYSINFO_ID_BOARD_MANUFACTURER:
+	case SYSID_BOARD_MANUFACTURER:
 		if (priv->t1)
 			str = smbios_string(priv->system,
 					    priv->t1->manufacturer);
 		break;
-	case SYSINFO_ID_PRIOR_STAGE_VERSION:
+	case SYSID_PRIOR_STAGE_VERSION:
 		if (priv->t0)
 			str = smbios_string(priv->bios, priv->t0->bios_ver);
 		break;
-	case SYSINFO_ID_PRIOR_STAGE_DATE:
+	case SYSID_PRIOR_STAGE_DATE:
 		if (priv->t0)
 			str = smbios_string(priv->bios,
 					    priv->t0->bios_release_date);
diff --git a/board/google/chromebook_coral/coral.c b/board/google/chromebook_coral/coral.c
index 3443dc91885..db96534857c 100644
--- a/board/google/chromebook_coral/coral.c
+++ b/board/google/chromebook_coral/coral.c
@@ -151,8 +151,8 @@ static int coral_get_str(struct udevice *dev, int id, size_t size, char *val)
 		return -ENOSYS;
 
 	switch (id) {
-	case SYSINFO_ID_SMBIOS_SYSTEM_VERSION:
-	case SYSINFO_ID_SMBIOS_BASEBOARD_VERSION: {
+	case SYSID_SM_SYSTEM_VERSION:
+	case SYSID_SM_BASEBOARD_VERSION: {
 		ret = get_skuconfig(dev);
 
 		if (ret < 0)
@@ -162,7 +162,7 @@ static int coral_get_str(struct udevice *dev, int id, size_t size, char *val)
 		sprintf(val, "rev%d", ret);
 		break;
 	}
-	case SYSINFO_ID_BOARD_MODEL: {
+	case SYSID_BOARD_MODEL: {
 		int mem_config, sku_config;
 		const char *model;
 
diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index a6b45cdab81..3badeebd149 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -193,7 +193,7 @@ static int tdx_get_str(struct udevice *dev, int id, size_t size, char *val)
 	int ret = -ENOTSUPP;
 
 	switch (id) {
-	case SYSINFO_ID_BOARD_MODEL:
+	case SYSID_BOARD_MODEL:
 		snprintf(val, size,
 			 "Toradex %04d %s %s",
 			 tdx_hw_tag.prodid,
diff --git a/common/board_info.c b/common/board_info.c
index 33c260b404e..dc26e1a33dd 100644
--- a/common/board_info.c
+++ b/common/board_info.c
@@ -18,9 +18,9 @@ static const struct to_show {
 	const char *name;
 	enum sysinfo_id id;
 } to_show[] = {
-	{ "Manufacturer", SYSINFO_ID_BOARD_MANUFACTURER},
-	{ "Prior-stage version", SYSINFO_ID_PRIOR_STAGE_VERSION },
-	{ "Prior-stage date", SYSINFO_ID_PRIOR_STAGE_DATE },
+	{ "Manufacturer", SYSID_BOARD_MANUFACTURER},
+	{ "Prior-stage version", SYSID_PRIOR_STAGE_VERSION },
+	{ "Prior-stage date", SYSID_PRIOR_STAGE_DATE },
 	{ /* sentinel */ }
 };
 
@@ -39,7 +39,7 @@ static int try_sysinfo(void)
 	if (ret)
 		return ret;
 
-	ret = sysinfo_get_str(dev, SYSINFO_ID_BOARD_MODEL, sizeof(str), str);
+	ret = sysinfo_get_str(dev, SYSID_BOARD_MODEL, sizeof(str), str);
 	if (ret)
 		return ret;
 	printf("Model: %s\n", str);
diff --git a/drivers/sysinfo/gazerbeam.h b/drivers/sysinfo/gazerbeam.h
index 6bf3c0098d1..047f365436f 100644
--- a/drivers/sysinfo/gazerbeam.h
+++ b/drivers/sysinfo/gazerbeam.h
@@ -8,8 +8,8 @@
 #include <sysinfo.h>
 
 enum {
-	BOARD_HWVERSION = SYSINFO_ID_BOARD_MODEL,
-	BOARD_MULTICHANNEL = SYSINFO_ID_USER,
+	BOARD_HWVERSION = SYSID_BOARD_MODEL,
+	BOARD_MULTICHANNEL = SYSID_USER,
 	BOARD_VARIANT
 };
 
diff --git a/drivers/sysinfo/gpio.c b/drivers/sysinfo/gpio.c
index aaca318419b..66d2a913087 100644
--- a/drivers/sysinfo/gpio.c
+++ b/drivers/sysinfo/gpio.c
@@ -38,7 +38,7 @@ static int sysinfo_gpio_get_int(struct udevice *dev, int id, int *val)
 	struct sysinfo_gpio_priv *priv = dev_get_priv(dev);
 
 	switch (id) {
-	case SYSINFO_ID_BOARD_MODEL:
+	case SYSID_BOARD_MODEL:
 		*val = priv->revision;
 		return 0;
 	default:
@@ -51,7 +51,7 @@ static int sysinfo_gpio_get_str(struct udevice *dev, int id, size_t size, char *
 	struct sysinfo_gpio_priv *priv = dev_get_priv(dev);
 
 	switch (id) {
-	case SYSINFO_ID_BOARD_MODEL: {
+	case SYSID_BOARD_MODEL: {
 		const char *name = NULL;
 		int i, ret;
 		u32 revision;
diff --git a/drivers/sysinfo/rcar3.c b/drivers/sysinfo/rcar3.c
index 37e2cccd9af..2994df9ab1c 100644
--- a/drivers/sysinfo/rcar3.c
+++ b/drivers/sysinfo/rcar3.c
@@ -46,7 +46,7 @@ static int sysinfo_rcar_get_str(struct udevice *dev, int id, size_t size, char *
 	struct sysinfo_rcar_priv *priv = dev_get_priv(dev);
 
 	switch (id) {
-	case SYSINFO_ID_BOARD_MODEL:
+	case SYSID_BOARD_MODEL:
 		strncpy(val, priv->boardmodel, size);
 		val[size - 1] = '\0';
 		return 0;
diff --git a/drivers/sysinfo/sandbox.h b/drivers/sysinfo/sandbox.h
index d9c5804c26a..a7cbac0ce18 100644
--- a/drivers/sysinfo/sandbox.h
+++ b/drivers/sysinfo/sandbox.h
@@ -5,7 +5,7 @@
  */
 
 enum {
-	BOOL_CALLED_DETECT = SYSINFO_ID_USER,
+	BOOL_CALLED_DETECT = SYSID_USER,
 	INT_TEST1,
 	INT_TEST2,
 	STR_VACATIONSPOT,
diff --git a/include/sysinfo.h b/include/sysinfo.h
index 8a77ef44856..027a463dc33 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -40,29 +40,29 @@ struct udevice;
 
 /** enum sysinfo_id - Standard IDs defined by U-Boot */
 enum sysinfo_id {
-	SYSINFO_ID_NONE,
+	SYSID_NONE,
 
 	/* For SMBIOS tables */
-	SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER,
-	SYSINFO_ID_SMBIOS_SYSTEM_PRODUCT,
-	SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
-	SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
-	SYSINFO_ID_SMBIOS_SYSTEM_SKU,
-	SYSINFO_ID_SMBIOS_SYSTEM_FAMILY,
-	SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
-	SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
-	SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
-	SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL,
-	SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
+	SYSID_SM_SYSTEM_MANUFACTURER,
+	SYSID_SM_SYSTEM_PRODUCT,
+	SYSID_SM_SYSTEM_VERSION,
+	SYSID_SM_SYSTEM_SERIAL,
+	SYSID_SM_SYSTEM_SKU,
+	SYSID_SM_SYSTEM_FAMILY,
+	SYSID_SM_BASEBOARD_MANUFACTURER,
+	SYSID_SM_BASEBOARD_PRODUCT,
+	SYSID_SM_BASEBOARD_VERSION,
+	SYSID_SM_BASEBOARD_SERIAL,
+	SYSID_SM_BASEBOARD_ASSET_TAG,
 
 	/* For show_board_info() */
-	SYSINFO_ID_BOARD_MODEL,
-	SYSINFO_ID_BOARD_MANUFACTURER,
-	SYSINFO_ID_PRIOR_STAGE_VERSION,
-	SYSINFO_ID_PRIOR_STAGE_DATE,
+	SYSID_BOARD_MODEL,
+	SYSID_BOARD_MANUFACTURER,
+	SYSID_PRIOR_STAGE_VERSION,
+	SYSID_PRIOR_STAGE_DATE,
 
 	/* First value available for downstream/board used */
-	SYSINFO_ID_USER = 0x1000,
+	SYSID_USER = 0x1000,
 };
 
 struct sysinfo_ops {
diff --git a/lib/smbios.c b/lib/smbios.c
index 7c24ea129eb..a36d4b4e54a 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -270,7 +270,7 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 static int smbios_add_prop(struct smbios_ctx *ctx, const char *prop,
 			   const char *dval)
 {
-	return smbios_add_prop_si(ctx, prop, SYSINFO_ID_NONE, dval);
+	return smbios_add_prop_si(ctx, prop, SYSID_NONE, dval);
 }
 
 static void smbios_set_eos(struct smbios_ctx *ctx, char *eos)
@@ -393,27 +393,27 @@ static int smbios_write_type1(ulong *current, int handle,
 	fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
 	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
-					     SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER,
+					     SYSID_SM_SYSTEM_MANUFACTURER,
 					     NULL);
 	t->product_name = smbios_add_prop_si(ctx, "product",
-					     SYSINFO_ID_SMBIOS_SYSTEM_PRODUCT,
+					     SYSID_SM_SYSTEM_PRODUCT,
 					     NULL);
 	t->version = smbios_add_prop_si(ctx, "version",
-					SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
+					SYSID_SM_SYSTEM_VERSION,
 					NULL);
 	if (serial_str) {
 		t->serial_number = smbios_add_prop(ctx, NULL, serial_str);
 		strncpy((char *)t->uuid, serial_str, sizeof(t->uuid));
 	} else {
 		t->serial_number = smbios_add_prop_si(ctx, "serial",
-						      SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
+						      SYSID_SM_SYSTEM_SERIAL,
 						      NULL);
 	}
 	t->wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN;
 	t->sku_number = smbios_add_prop_si(ctx, "sku",
-					   SYSINFO_ID_SMBIOS_SYSTEM_SKU, NULL);
+					   SYSID_SM_SYSTEM_SKU, NULL);
 	t->family = smbios_add_prop_si(ctx, "family",
-				       SYSINFO_ID_SMBIOS_SYSTEM_FAMILY, NULL);
+				       SYSID_SM_SYSTEM_FAMILY, NULL);
 
 	len = t->length + smbios_string_table_len(ctx);
 	*current += len;
@@ -433,20 +433,20 @@ static int smbios_write_type2(ulong *current, int handle,
 	fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
 	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
-					     SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
+					     SYSID_SM_BASEBOARD_MANUFACTURER,
 					     NULL);
 	t->product_name = smbios_add_prop_si(ctx, "product",
-					     SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
+					     SYSID_SM_BASEBOARD_PRODUCT,
 					     NULL);
 	t->version = smbios_add_prop_si(ctx, "version",
-					SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
+					SYSID_SM_BASEBOARD_VERSION,
 					NULL);
 
 	t->serial_number = smbios_add_prop_si(ctx, "serial",
-					      SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL,
+					      SYSID_SM_BASEBOARD_SERIAL,
 					      NULL);
 	t->asset_tag_number = smbios_add_prop_si(ctx, "asset-tag",
-						 SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
+						 SYSID_SM_BASEBOARD_ASSET_TAG,
 						 NULL);
 	t->feature_flags = SMBIOS_BOARD_FEATURE_HOSTING;
 	t->board_type = SMBIOS_BOARD_MOTHERBOARD;
diff --git a/test/dm/sysinfo-gpio.c b/test/dm/sysinfo-gpio.c
index 155da3b6344..de9483c4291 100644
--- a/test/dm/sysinfo-gpio.c
+++ b/test/dm/sysinfo-gpio.c
@@ -29,9 +29,9 @@ static int dm_test_sysinfo_gpio(struct unit_test_state *uts)
 	sandbox_gpio_set_flags(gpio, 16, GPIOD_EXT_PULL_DOWN);
 	sandbox_gpio_set_flags(gpio, 17, 0);
 	ut_assertok(sysinfo_detect(sysinfo));
-	ut_assertok(sysinfo_get_int(sysinfo, SYSINFO_ID_BOARD_MODEL, &val));
+	ut_assertok(sysinfo_get_int(sysinfo, SYSID_BOARD_MODEL, &val));
 	ut_asserteq(19, val);
-	ut_assertok(sysinfo_get_str(sysinfo, SYSINFO_ID_BOARD_MODEL, sizeof(buf),
+	ut_assertok(sysinfo_get_str(sysinfo, SYSID_BOARD_MODEL, sizeof(buf),
 				    buf));
 	ut_asserteq_str("rev_a", buf);
 
@@ -43,9 +43,9 @@ static int dm_test_sysinfo_gpio(struct unit_test_state *uts)
 	sandbox_gpio_set_flags(gpio, 16, GPIOD_EXT_PULL_UP);
 	sandbox_gpio_set_flags(gpio, 17, GPIOD_EXT_PULL_DOWN);
 	ut_assertok(sysinfo_detect(sysinfo));
-	ut_assertok(sysinfo_get_int(sysinfo, SYSINFO_ID_BOARD_MODEL, &val));
+	ut_assertok(sysinfo_get_int(sysinfo, SYSID_BOARD_MODEL, &val));
 	ut_asserteq(5, val);
-	ut_assertok(sysinfo_get_str(sysinfo, SYSINFO_ID_BOARD_MODEL, sizeof(buf),
+	ut_assertok(sysinfo_get_str(sysinfo, SYSID_BOARD_MODEL, sizeof(buf),
 				    buf));
 	ut_asserteq_str("foo", buf);
 
@@ -57,9 +57,9 @@ static int dm_test_sysinfo_gpio(struct unit_test_state *uts)
 	sandbox_gpio_set_flags(gpio, 16, 0);
 	sandbox_gpio_set_flags(gpio, 17, GPIOD_EXT_PULL_UP);
 	ut_assertok(sysinfo_detect(sysinfo));
-	ut_assertok(sysinfo_get_int(sysinfo, SYSINFO_ID_BOARD_MODEL, &val));
+	ut_assertok(sysinfo_get_int(sysinfo, SYSID_BOARD_MODEL, &val));
 	ut_asserteq(15, val);
-	ut_assertok(sysinfo_get_str(sysinfo, SYSINFO_ID_BOARD_MODEL, sizeof(buf),
+	ut_assertok(sysinfo_get_str(sysinfo, SYSID_BOARD_MODEL, sizeof(buf),
 				    buf));
 	ut_asserteq_str("unknown", buf);
 
-- 
2.43.0

