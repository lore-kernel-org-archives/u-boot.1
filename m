Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117E4E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 22:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97B9989434;
	Fri,  6 Dec 2024 23:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jHOtf/rL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C96358870D; Fri,  6 Dec 2024 23:56:20 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A4F889434
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 23:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4667931f14bso39701431cf.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 14:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733525777; x=1734130577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdv6GWWQ2zq/8W5Fdi6oxeWrdHVlmKoKAmCJAGw4+xI=;
 b=jHOtf/rLGl5eFO1Qtjp7hn0IhsL8eLzgQCcmIMIo0I0vJdS68+0/sdip85YeJry8Ia
 d2qkJ9+SiXBXI4jS+kkdECivgzIcQSTVjBAw6FS6jAYG1rxtEan0KJWl/g04dbUffecJ
 01jImrvwpHQnnqvydXcdv6Oa9J/F9kMnzZ3OVCJJev9t13psFx9iM0zUQJQP29h1oKbh
 zAUSnvclWbqo8VJxRc63ltgF8OmpmZrrD1pllrR0i2XtX185f9aei9nSOHxREJtfqri1
 V4hTLd+/1xax2JJgq2zvjd51lvBug/idxWQfTH8HkKmjRWWy9LTvCJqE3hMCLzyQIE9z
 d5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525777; x=1734130577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdv6GWWQ2zq/8W5Fdi6oxeWrdHVlmKoKAmCJAGw4+xI=;
 b=Uns+THNUgaoL+iPmQu/RXEIz9eCjy2M0NRqW/XeWoO51cqMsyP4K+zU8EvKKnUs6Is
 q4oDektx17fG7rk33VUD0S1EWxDyywEGFZA7JnTY2sg/7bi6B9ctixZAaYs424MivuFL
 ed/1NXkuapcsTpFjTRvtTKMA4I+VLnFmvFL2IV5jJS4R8aEyIAPU0zegCIWt2BSbX6an
 ve4PJ/rW1gt5Vg5Fygco7b8d0hkh5agvTSXsKr5Ud6MNe7ohZc0SLQ/o97M47Be4Aerz
 6vYL6b7cnLOUc2+uEr9b20f/qFJbYzc/T7ccMQVLDPfCKWxommEOIKqE/GIjKDrKQjgK
 DZlA==
X-Gm-Message-State: AOJu0YzV7/3lfiUXeMzxMInCBbNamJKZMjdiVTRsaHGMvZpinHCYlSF1
 BSTpFVkQsDFBxz5M96UiqIcmBUk45N1mudrBa8gmzmwnZn41vUDOotGXD6IDCGwcGGleSzySChg
 T
X-Gm-Gg: ASbGncvmnSidcVDmFeT+2EBV520x5nRXX4M56Zv7NhcMbbuLLFS2Dtl1+vkqeZ7Jk7K
 JYg7PUfHQG5PCVwRmUuKeYdTA39e94lRGQ7h11C+XSm26eliUsyyskgp4EyqPm/qQAnUN4s5gzO
 3uSWyYsnDRGw/wNGmRpH3LvsH+y4umonx2GT+mOM9oc286472odNbpObELu49z1BgnKImByzqR1
 Nv5EdTSds46wnCJtGiNB1xeqZy2jMuxFKWMQIOSy7Qu45Cjbouw4aRB1HNNGQlXPH4LMR1qJYHU
 er3AWbr7MA7lGipq6r18ctwAdPQtg+YFN5Sl0djmhVqxeoKX
X-Google-Smtp-Source: AGHT+IHY0579k+qXjRcSzHVLzAIgUmyd7StV2XpkfgXQ8k0CqV1Vxr6AR2cGflnljZdH3xYzwe4t9w==
X-Received: by 2002:a05:622a:148b:b0:466:afc3:d649 with SMTP id
 d75a77b69052e-46734e67705mr79271681cf.36.1733525777043; 
 Fri, 06 Dec 2024 14:56:17 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d4d7dsm26080871cf.34.2024.12.06.14.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:56:15 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 06/10] smbios: add detailed smbios information
Date: Fri,  6 Dec 2024 14:54:23 -0800
Message-Id: <20241206225438.13866-7-raymond.mao@linaro.org>
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

Add detailed SMBIOS information as following:
1. Missing fields in Type #3 and #4
2. Type #7

Add support to dynamic length of contained object handles and
elements.

As SMBIOS is a fundamental feature which is enabled for all
boards, in order to avoid increasing rom size, all detailed SMBIOS
information is under kconfig GENERATE_SMBIOS_TABLE_VERBOSE.
Board maintainers can determine whether to select this feature.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3
- Initial patch.

 lib/smbios.c | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 1 deletion(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index e8089e91523..203ed6d78b0 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -528,6 +528,8 @@ static int smbios_write_type3(ulong *current, int handle,
 	int len = sizeof(*t);
 	u8 *eos_addr;
 	size_t elem_size = 0;
+	__maybe_unused u8 *elem_addr;
+	__maybe_unused u8 *sku_num_addr;
 
 	/*
 	 * reserve the space for the dynamic bytes of contained elements.
@@ -540,7 +542,10 @@ static int smbios_write_type3(ulong *current, int handle,
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
 	fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
-
+#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
+	elem_addr = (u8 *)t + offsetof(struct smbios_type3, sku_number);
+	sku_num_addr = elem_addr + elem_size;
+#endif
 	/* eos is at the end of the structure */
 	eos_addr = (u8 *)t + len - sizeof(t->eos);
 	smbios_set_eos(ctx, eos_addr);
@@ -564,6 +569,32 @@ static int smbios_write_type3(ulong *current, int handle,
 					       SYSID_SM_ENCLOSURE_SECURITY,
 					       SMBIOS_SECURITY_UNKNOWN);
 
+#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
+	t->version = smbios_add_prop_si(ctx, "version",
+					SYSID_SM_ENCLOSURE_VERSION, NULL);
+	t->serial_number = smbios_add_prop_si(ctx, "serial",
+					      SYSID_SM_ENCLOSURE_SERIAL, NULL);
+	t->asset_tag_number = smbios_add_prop_si(ctx, "asset-tag",
+						 SYSID_SM_BASEBOARD_ASSET_TAG,
+						 NULL);
+	t->oem_defined = smbios_get_val_si(ctx, "oem-defined",
+					   SYSID_SM_ENCLOSURE_OEM, 0);
+	t->height = smbios_get_val_si(ctx, "height",
+				      SYSID_SM_ENCLOSURE_HEIGHT, 0);
+	t->number_of_power_cords =
+		smbios_get_val_si(ctx, "number-of-power-cords",
+				  SYSID_SM_ENCLOSURE_POWCORE_NUM, 0);
+
+	/*
+	 * TODO: Populate the Contained Element Record if they exist
+	 * t->element_count = <element_num>;
+	 * t->element_record_length = <element_len>;
+	 */
+
+	*sku_num_addr =	smbios_add_prop_si(ctx, "sku", SYSID_SM_ENCLOSURE_SKU,
+					   NULL);
+#endif
+
 	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
 	unmap_sysmem(t);
@@ -577,6 +608,8 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
 	u16 processor_family = SMBIOS_PROCESSOR_FAMILY_UNKNOWN;
 	const char *vendor = NULL;
 	const char *name = NULL;
+	__maybe_unused void *id_data = NULL;
+	__maybe_unused size_t id_size = 0;
 
 #ifdef CONFIG_CPU
 	char processor_name[49];
@@ -617,6 +650,16 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
 	t->processor_version = smbios_add_prop_si(ctx, "version",
 						  SYSID_SM_PROCESSOR_VERSION,
 						  name);
+
+#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
+	if (t->processor_id[0] || t->processor_id[1] ||
+	    sysinfo_get_data(ctx->dev, SYSID_SM_PROCESSOR_ID, &id_data,
+			     &id_size))
+		return;
+
+	if (id_data && id_size == sizeof(t->processor_id))
+		memcpy((u8 *)t->processor_id, id_data, id_size);
+#endif
 }
 
 static int smbios_write_type4(ulong *current, int handle,
@@ -624,6 +667,8 @@ static int smbios_write_type4(ulong *current, int handle,
 {
 	struct smbios_type4 *t;
 	int len = sizeof(*t);
+	__maybe_unused void *hdl;
+	__maybe_unused size_t hdl_size;
 
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
@@ -647,6 +692,60 @@ static int smbios_write_type4(ulong *current, int handle,
 	t->l2_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
 	t->l3_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
 
+#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
+	t->voltage = smbios_get_val_si(ctx, "voltage",
+				       SYSID_SM_PROCESSOR_VOLTAGE, 0);
+	t->external_clock = smbios_get_val_si(ctx, "external-clock",
+					      SYSID_SM_PROCESSOR_EXT_CLOCK, 0);
+	t->max_speed = smbios_get_val_si(ctx, "max-speed",
+					 SYSID_SM_PROCESSOR_MAX_SPEED, 0);
+	t->current_speed = smbios_get_val_si(ctx, "current-speed",
+					     SYSID_SM_PROCESSOR_CUR_SPEED, 0);
+
+	/* Read the cache handles */
+	if (!sysinfo_get_data(ctx->dev, SYSID_SM_CACHE_HANDLE, &hdl,
+			      &hdl_size) &&
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
+					      SYSID_SM_PROCESSOR_SN, NULL);
+	t->asset_tag = smbios_add_prop_si(ctx, "asset-tag",
+					  SYSID_SM_PROCESSOR_ASSET_TAG, NULL);
+	t->part_number = smbios_add_prop_si(ctx, "part-number",
+					    SYSID_SM_PROCESSOR_PN, NULL);
+	t->core_count =	smbios_get_val_si(ctx, "core-count",
+					  SYSID_SM_PROCESSOR_CORE_CNT, 0);
+	t->core_enabled = smbios_get_val_si(ctx, "core-enabled",
+					    SYSID_SM_PROCESSOR_CORE_EN, 0);
+	t->thread_count = smbios_get_val_si(ctx, "thread-count",
+					    SYSID_SM_PROCESSOR_THREAD_CNT, 0);
+	t->processor_characteristics =
+		smbios_get_val_si(ctx, "characteristics",
+				  SYSID_SM_PROCESSOR_CHARA,
+				  SMBIOS_PROCESSOR_UND);
+	t->core_count2 = smbios_get_val_si(ctx, "core-count2",
+					   SYSID_SM_PROCESSOR_CORE_CNT2, 0);
+	t->core_enabled2 = smbios_get_val_si(ctx, "core-enabled2",
+					     SYSID_SM_PROCESSOR_CORE_EN2, 0);
+	t->thread_count2 = smbios_get_val_si(ctx, "thread-count2",
+					     SYSID_SM_PROCESSOR_THREAD_CNT2, 0);
+	t->thread_enabled = smbios_get_val_si(ctx, "thread-enabled",
+					      SYSID_SM_PROCESSOR_THREAD_EN, 0);
+#endif
+
 	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
 	unmap_sysmem(t);
@@ -654,6 +753,104 @@ static int smbios_write_type4(ulong *current, int handle,
 	return len;
 }
 
+#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
+
+static int smbios_write_type7_1level(ulong *current, int handle,
+				     struct smbios_ctx *ctx, int level)
+{
+	struct smbios_type7 *t;
+	int len = sizeof(*t);
+	void *hdl;
+	size_t hdl_size;
+
+	t = map_sysmem(*current, len);
+	memset(t, 0, len);
+	fill_smbios_header(t, SMBIOS_CACHE_INFORMATION, len, handle);
+	smbios_set_eos(ctx, t->eos);
+
+	t->socket_design = smbios_add_prop_si(ctx, "socket-design",
+					      SYSID_SM_CACHE_SOCKET + level,
+					      NULL);
+	t->config.data = smbios_get_val_si(ctx, "config",
+					   SYSID_SM_CACHE_CONFIG + level,
+					   (level - 1) | SMBIOS_CACHE_OP_UND);
+	t->max_size.data = smbios_get_val_si(ctx, "max-size",
+					     SYSID_SM_CACHE_MAX_SIZE + level,
+					     0);
+	t->inst_size.data = smbios_get_val_si(ctx, "installed-size",
+					      SYSID_SM_CACHE_INST_SIZE + level,
+					      0);
+	t->supp_sram_type.data =
+		smbios_get_val_si(ctx, "supported-sram-type",
+				  SYSID_SM_CACHE_SUPSRAM_TYPE + level,
+				  SMBIOS_CACHE_SRAM_TYPE_UNKNOWN);
+	t->curr_sram_type.data =
+		smbios_get_val_si(ctx, "current-sram-type",
+				  SYSID_SM_CACHE_CURSRAM_TYPE + level,
+				  SMBIOS_CACHE_SRAM_TYPE_UNKNOWN);
+	t->speed = smbios_get_val_si(ctx, "speed", SYSID_SM_CACHE_SPEED + level,
+				     0);
+	t->err_corr_type = smbios_get_val_si(ctx, "error-correction-type",
+					     SYSID_SM_CACHE_ERRCOR_TYPE + level,
+					     SMBIOS_CACHE_ERRCORR_UNKNOWN);
+	t->sys_cache_type =
+		smbios_get_val_si(ctx, "system-cache-type",
+				  SYSID_SM_CACHE_SCACHE_TYPE + level,
+				  SMBIOS_CACHE_SYSCACHE_TYPE_UNKNOWN);
+	t->associativity = smbios_get_val_si(ctx, "associativity",
+					     SYSID_SM_CACHE_ASSOC + level,
+					     SMBIOS_CACHE_ASSOC_UNKNOWN);
+	t->max_size2.data = smbios_get_val_si(ctx, "max-size2",
+					      SYSID_SM_CACHE_MAX_SIZE2 + level,
+					      0);
+	t->inst_size2.data =
+		smbios_get_val_si(ctx, "installed-size2",
+				  SYSID_SM_CACHE_INST_SIZE2 + level, 0);
+
+	/* Save the cache handles */
+	if (!sysinfo_get_data(ctx->dev, SYSID_SM_CACHE_HANDLE, &hdl,
+			      &hdl_size)) {
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
+	level =	smbios_get_val_si(ctx, NULL, SYSID_SM_CACHE_LEVEL, 0);
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
+#endif /* #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE) */
+
 static int smbios_write_type32(ulong *current, int handle,
 			       struct smbios_ctx *ctx)
 {
@@ -693,6 +890,10 @@ static struct smbios_write_method smbios_write_funcs[] = {
 	{ smbios_write_type2, "baseboard", },
 	/* Type 3 must immediately follow type 2 due to chassis handle. */
 	{ smbios_write_type3, "chassis", },
+#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
+	/* Type 7 must ahead of type 4 to get cache handles. */
+	{ smbios_write_type7, "cache", },
+#endif
 	{ smbios_write_type4, "processor"},
 	{ smbios_write_type32, },
 	{ smbios_write_type127 },
-- 
2.25.1

