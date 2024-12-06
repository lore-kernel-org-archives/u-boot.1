Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CA9E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 22:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ABF78963C;
	Fri,  6 Dec 2024 23:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dBeK8H7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 873F089737; Fri,  6 Dec 2024 23:55:53 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047C089578
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 23:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-466847440a6so15338121cf.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 14:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733525749; x=1734130549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vygsRAybD5K5leo/xfheOgtfaQI1PL6VMt8n4UlKKI=;
 b=dBeK8H7X61h/tFr8W5qV0uKmvr6OicW2LHWrSFAUSqemJKH6KrWVZSsMXm0Venhafr
 sjoRk+2GdiH7+Ak5ArsLsxxvFCPnF5AHymdcEv2IwDDYQbbIoYKu5450OOijIwDu/Lnz
 3PZb1wOkSqtr5m9hr+IkqMT9MZn0D/LoJFh4xK/5QmK9wwJ8TNhEtnham2mcwzakBztr
 Blz8MlqdFL2cT4YOBu3QY+/u0qUpBTjhGFm7NdFA+UbWpIsaRSB01LZ8LpBI8wOXPvFQ
 XLN/X3vBUoqQnhu3ew4GQ0FwASGsicwp0XT9aiAaAcIzWeXsY+JA7sIGdLU0b062hxSf
 blvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525749; x=1734130549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vygsRAybD5K5leo/xfheOgtfaQI1PL6VMt8n4UlKKI=;
 b=VYSfnztZ91U8by3W/SnoLFLuo93M28ZYhLNWpnE7j7eOMEgOhKdEAiDAu68tObEjr4
 sTAAJQjP30mxcZ1vo8tr0agiu15WLe+0PVaNAZfZJxFEQk6Eq3VIaukuH4DFVX97I8TL
 PuKnOCYHFgxd8x9kNfGWsFgSXCNqRXbNv5PQ8x1dUPOeO3aOuclEQ6sDYqyj5o/DJ/lA
 GWwpXK+yuh8BnAfZxMxcyvU9tENppi8wIjsTzokHhP8pIr4gkZWWLr4oqdzD08NOKuGj
 ZswjX3xt9rLGbaXTFK0+widtF8boFrCQS5l9HCJZd48u335p6ZAsWoq3DGfWYJVu5nNs
 62Rw==
X-Gm-Message-State: AOJu0YzVnMVbnJrCsWG7upI1PWedKNH+PkWsDVuZP6iyIdgrUCQXrHyS
 WGHmCtKBgcsfXDSyEKv3CiTHkhKw0LPKyVRQB1xCvio7YTv1xg/pjJ/oUO3BpcfyTCANKKuX1zJ
 a
X-Gm-Gg: ASbGncvMuV8nfwpN1/Hc/DA4evPPkKpdUCceeSFgOmvdCQPjvkQboq9WM7/006hQe0p
 qLmrFZL/Zn9JpPlYSog2PvP3RRk3zB/KflNDUXSjkXnyJoOAXd16efIbow6q4YPXKUjSPXv+THQ
 +x5pz3gtF3h6ej59Ywx9pyejQVOsb5C4fIgFTT7Kwq+qjEZuVSkSEUcmHc2+nHyYndId5/Hfik+
 UATzqjDqdsps+5X2Kk53KTIn4z4ZvXZ9opzJqiUn5kiYeOKbuxyIAXySYHV0z/97zTu4XsASzTi
 MvkSJyeAd9+kShjfr5zl0mY8EvpNZWS68hMiRfNaPHiErxUJ
X-Google-Smtp-Source: AGHT+IEvWc0n6+0q2Oln7ZRpAuDp15+DGO8sWCIEgfYiQZlzwLkdWqiB+OM4GA+vHHdLdYLGJFsPMA==
X-Received: by 2002:a05:622a:1183:b0:464:94cf:98a0 with SMTP id
 d75a77b69052e-46734f779cdmr65086551cf.34.1733525749372; 
 Fri, 06 Dec 2024 14:55:49 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d4d7dsm26080871cf.34.2024.12.06.14.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:55:48 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 04/10] sysinfo: Add sysinfo driver and data structure for
 smbios
Date: Fri,  6 Dec 2024 14:54:21 -0800
Message-Id: <20241206225438.13866-5-raymond.mao@linaro.org>
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

Add sysinfo driver to retrieve smbios information (Type 4 and 7).
So that the smbios library can use it for getting values from the
hardware platform instead of device tree.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the changes to smbios.c instead of creating new file.
- Move the headfile to include dir.
- Combine with #6(v1) patch.
- Clean-up the private data structures.
- Clean-up the operations of the strings and common values.
Changes in v3
- Use void pointer to avoid casting.
- Rebased on the changes of SYSID_

 drivers/sysinfo/smbios.c | 228 +++++++++++++++++++++++++++++++++++++++
 include/smbios.h         |  60 +++++++++++
 include/smbios_plat.h    |  79 ++++++++++++++
 include/sysinfo.h        |  95 +++++++++++++++-
 4 files changed, 461 insertions(+), 1 deletion(-)
 create mode 100644 include/smbios_plat.h

diff --git a/drivers/sysinfo/smbios.c b/drivers/sysinfo/smbios.c
index a7ac8e3f072..99104274f72 100644
--- a/drivers/sysinfo/smbios.c
+++ b/drivers/sysinfo/smbios.c
@@ -5,14 +5,240 @@
  */
 
 #include <dm.h>
+#include <smbios_plat.h>
 #include <sysinfo.h>
 
+/* platform information storage */
+struct processor_info processor_info;
+struct cache_info cache_info[SYSINFO_CACHE_LVL_MAX];
+struct sysinfo_plat sysinfo_smbios_p = {
+	/* Processor Information */
+	.processor = &processor_info,
+	/* Cache Information */
+	.cache = &cache_info[0],
+};
+
+/* structure for smbios private data storage */
+struct sysinfo_plat_priv {
+	struct processor_info *t4;
+	struct smbios_type7 t7[SYSINFO_CACHE_LVL_MAX];
+	u16 cache_handles[SYSINFO_CACHE_LVL_MAX];
+	u8 cache_level;
+};
+
+static void smbios_cache_info_dump(struct smbios_type7 *cache_info)
+{
+	log_debug("SMBIOS Type 7 (Cache Information):\n");
+	log_debug("Cache Configuration: 0x%04x\n", cache_info->config.data);
+	log_debug("Maximum Cache Size: %u KB\n", cache_info->max_size.data);
+	log_debug("Installed Size: %u KB\n", cache_info->inst_size.data);
+	log_debug("Supported SRAM Type: 0x%04x\n",
+		  cache_info->supp_sram_type.data);
+	log_debug("Current SRAM Type: 0x%04x\n",
+		  cache_info->curr_sram_type.data);
+	log_debug("Cache Speed: %u\n", cache_info->speed);
+	log_debug("Error Correction Type: %u\n", cache_info->err_corr_type);
+	log_debug("System Cache Type: %u\n", cache_info->sys_cache_type);
+	log_debug("Associativity: %u\n", cache_info->associativity);
+	log_debug("Maximum Cache Size 2: %u KB\n", cache_info->max_size2.data);
+	log_debug("Installed Cache Size 2: %u KB\n",
+		  cache_info->inst_size2.data);
+}
+
+/* weak function for the platforms not yet supported */
+__weak int sysinfo_get_cache_info(u8 level, struct cache_info *cache_info)
+{
+	return -ENOSYS;
+}
+
+__weak int sysinfo_get_processor_info(struct processor_info *pinfo)
+{
+	return -ENOSYS;
+}
+
+void sysinfo_cache_info_default(struct cache_info *ci)
+{
+	memset(ci, 0, sizeof(*ci));
+	ci->config.data = SMBIOS_CACHE_LOCATE_UNKNOWN | SMBIOS_CACHE_OP_UND;
+	ci->supp_sram_type.fields.unknown = 1;
+	ci->curr_sram_type.fields.unknown = 1;
+	ci->speed = SMBIOS_CACHE_SPEED_UNKNOWN;
+	ci->err_corr_type = SMBIOS_CACHE_ERRCORR_UNKNOWN;
+	ci->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_UNKNOWN;
+}
+
+static int sysinfo_plat_detect(struct udevice *dev)
+{
+	return 0;
+}
+
+static int sysinfo_plat_get_str(struct udevice *dev, int id,
+				size_t size, char *val)
+{
+	struct sysinfo_plat_priv *priv = dev_get_priv(dev);
+	const char *str = NULL;
+
+	switch (id) {
+	case SYSID_SM_PROCESSOR_MANUFACT:
+		str = priv->t4->manufacturer;
+		break;
+	default:
+		break;
+	}
+
+	if (!str)
+		return -ENOSYS;
+
+	strlcpy(val, str, size);
+
+	return 0;
+}
+
+static int sysinfo_plat_get_int(struct udevice *dev, int id, int *val)
+{
+	struct sysinfo_plat_priv *priv = dev_get_priv(dev);
+	u8 i;
+
+	if (id >= SYSID_SM_CACHE_INFO_START &&
+	    id <= SYSID_SM_CACHE_INFO_END) {
+		/* For smbios type 7 */
+		for (i = 0; i < priv->cache_level; i++) {
+			switch (id - i) {
+			case SYSID_SM_CACHE_MAX_SIZE:
+				*val = priv->t7[i].max_size.data;
+				return 0;
+			case SYSID_SM_CACHE_INST_SIZE:
+				*val = priv->t7[i].inst_size.data;
+				return 0;
+			case SYSID_SM_CACHE_SCACHE_TYPE:
+				*val = priv->t7[i].sys_cache_type;
+				return 0;
+			case SYSID_SM_CACHE_ASSOC:
+				*val = priv->t7[i].associativity;
+				return 0;
+			case SYSID_SM_CACHE_MAX_SIZE2:
+				*val = priv->t7[i].max_size2.data;
+				return 0;
+			case SYSID_SM_CACHE_INST_SIZE2:
+				*val = priv->t7[i].inst_size2.data;
+				return 0;
+			default:
+				break;
+			}
+		}
+		return -ENOSYS;
+	}
+
+	switch (id) {
+	case SYSID_SM_PROCESSOR_CORE_CNT:
+		*val = priv->t4->core_count;
+		break;
+	case SYSID_SM_PROCESSOR_CORE_EN:
+		*val = priv->t4->core_enabled;
+		break;
+	case SYSID_SM_PROCESSOR_CHARA:
+		*val = priv->t4->characteristics;
+		break;
+	case SYSID_SM_CACHE_LEVEL:
+		if (!priv->cache_level)	/* No cache detected */
+			return -ENOSYS;
+		*val = priv->cache_level - 1;
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	return 0;
+}
+
+static int sysinfo_plat_get_data(struct udevice *dev, int id, void **buf,
+				 size_t *size)
+{
+	struct sysinfo_plat_priv *priv = dev_get_priv(dev);
+
+	switch (id) {
+	case SYSID_SM_PROCESSOR_ID:
+		*buf = priv->t4->id;
+		*size = sizeof(priv->t4->id);
+		break;
+	case SYSID_SM_CACHE_HANDLE:
+		*buf = &priv->cache_handles[0];
+		*size = sizeof(priv->cache_handles);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int sysinfo_plat_probe(struct udevice *dev)
+{
+	struct sysinfo_plat_priv *priv = dev_get_priv(dev);
+	struct sysinfo_plat *plat = &sysinfo_smbios_p;
+	u8 level;
+
+	if (!sysinfo_get_processor_info(plat->processor))
+		priv->t4 = plat->processor;
+
+	for (level = 0; level < SYSINFO_CACHE_LVL_MAX; level++) {
+		struct cache_info *pcache = plat->cache + level;
+
+		if (sysinfo_get_cache_info(level, pcache))
+			break; /* no more levels */
+
+		/*
+		 * Fill in the SMBIOS type 7 structure,
+		 * skip the header members (type, length, handle),
+		 * and the ones in DT smbios node.
+		 */
+		priv->t7[level].sys_cache_type = pcache->cache_type;
+		priv->t7[level].associativity = pcache->associativity;
+
+		if (pcache->max_size > SMBIOS_CACHE_SIZE_EXT_KB) {
+			priv->t7[level].max_size.data = 0xFFFF;
+			priv->t7[level].max_size2.fields.size =
+				pcache->max_size / 64;
+			priv->t7[level].max_size2.fields.granu =
+				SMBIOS_CACHE_GRANU_64K;
+		} else {
+			priv->t7[level].max_size.fields.size = pcache->max_size;
+			priv->t7[level].max_size.fields.granu =
+				SMBIOS_CACHE_GRANU_1K;
+			priv->t7[level].max_size2.data = 0;
+		}
+		if (pcache->inst_size > SMBIOS_CACHE_SIZE_EXT_KB) {
+			priv->t7[level].inst_size.data = 0xFFFF;
+			priv->t7[level].inst_size2.fields.size =
+				pcache->inst_size / 64;
+			priv->t7[level].inst_size2.fields.granu =
+				SMBIOS_CACHE_GRANU_64K;
+		} else {
+			priv->t7[level].inst_size.fields.size =
+				pcache->inst_size;
+			priv->t7[level].inst_size.fields.granu =
+				SMBIOS_CACHE_GRANU_1K;
+			priv->t7[level].inst_size2.data = 0;
+		}
+		smbios_cache_info_dump(&priv->t7[level]);
+	}
+	if (!level) /* no cache detected */
+		return -ENOSYS;
+
+	priv->cache_level = level;
+
+	return 0;
+}
+
 static const struct udevice_id sysinfo_smbios_ids[] = {
 	{ .compatible = "u-boot,sysinfo-smbios" },
 	{ /* sentinel */ }
 };
 
 static const struct sysinfo_ops sysinfo_smbios_ops = {
+	.detect = sysinfo_plat_detect,
+	.get_str = sysinfo_plat_get_str,
+	.get_int = sysinfo_plat_get_int,
+	.get_data = sysinfo_plat_get_data,
 };
 
 U_BOOT_DRIVER(sysinfo_smbios) = {
@@ -20,4 +246,6 @@ U_BOOT_DRIVER(sysinfo_smbios) = {
 	.id             = UCLASS_SYSINFO,
 	.of_match       = sysinfo_smbios_ids,
 	.ops		= &sysinfo_smbios_ops,
+	.priv_auto	= sizeof(struct sysinfo_plat_priv),
+	.probe		= sysinfo_plat_probe,
 };
diff --git a/include/smbios.h b/include/smbios.h
index 78fd14d881b..cb4b3e08b3a 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -187,6 +187,66 @@ struct __packed smbios_type4 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
+union cache_config {
+	struct {
+		u16 level:3;
+		u16 bsocketed:1;
+		u16 rsvd0:1;
+		u16 locate:2;
+		u16 benabled:1;
+		u16 opmode:2;
+		u16 rsvd1:6;
+	} fields;
+	u16 data;
+};
+
+union cache_size_word {
+	struct {
+		u16 size:15;
+		u16 granu:1;
+	} fields;
+	u16 data;
+};
+
+union cache_size_dword {
+	struct {
+		u32 size:31;
+		u32 granu:1;
+	} fields;
+	u32 data;
+};
+
+union cache_sram_type {
+	struct {
+		u16 other:1;
+		u16 unknown:1;
+		u16 nonburst:1;
+		u16 burst:1;
+		u16 plburst:1;
+		u16 sync:1;
+		u16 async:1;
+		u16 rsvd:9;
+	} fields;
+	u16 data;
+};
+
+struct __packed smbios_type7 {
+	struct smbios_header hdr;
+	u8 socket_design;
+	union cache_config config;
+	union cache_size_word max_size;
+	union cache_size_word inst_size;
+	union cache_sram_type supp_sram_type;
+	union cache_sram_type curr_sram_type;
+	u8 speed;
+	u8 err_corr_type;
+	u8 sys_cache_type;
+	u8 associativity;
+	union cache_size_dword max_size2;
+	union cache_size_dword inst_size2;
+	char eos[SMBIOS_STRUCT_EOS_BYTES];
+};
+
 struct __packed smbios_type32 {
 	u8 type;
 	u8 length;
diff --git a/include/smbios_plat.h b/include/smbios_plat.h
new file mode 100644
index 00000000000..70089d5a2ba
--- /dev/null
+++ b/include/smbios_plat.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#ifndef __SMBIOS_PLAT_H
+#define __SMBIOS_PLAT_H
+
+#include <smbios.h>
+
+struct cache_info {
+	union cache_config config;
+	union cache_sram_type supp_sram_type;
+	union cache_sram_type curr_sram_type;
+	u32 line_size;
+	u32 associativity;
+	u32 max_size;
+	u32 inst_size;
+	u8 cache_type;
+	u8 speed;
+	u8 err_corr_type;
+	char *socket_design;
+};
+
+struct processor_info {
+	u32 id[2];
+	u16 ext_clock;
+	u16 max_speed;
+	u16 curr_speed;
+	u16 characteristics;
+	u16 family2;
+	u16 core_count2;
+	u16 core_enabled2;
+	u16 thread_count2;
+	u16 thread_enabled;
+	u8 type;
+	u8 family;
+	u8 voltage;
+	u8 status;
+	u8 upgrade;
+	u8 core_count;
+	u8 core_enabled;
+	u8 thread_count;
+	char *socket_design;
+	char *manufacturer;
+	char *version;
+	char *sn;
+	char *asset_tag;
+	char *pn;
+};
+
+struct sysinfo_plat {
+	struct processor_info *processor;
+	struct cache_info *cache;
+	/* add other sysinfo structure here */
+};
+
+#if defined CONFIG_SYSINFO_SMBIOS
+int sysinfo_get_cache_info(u8 level, struct cache_info *cache_info);
+void sysinfo_cache_info_default(struct cache_info *ci);
+int sysinfo_get_processor_info(struct processor_info *pinfo);
+#else
+static inline int sysinfo_get_cache_info(u8 level,
+					 struct cache_info *cache_info)
+{
+	return -ENOSYS;
+}
+
+static inline void sysinfo_cache_info_default(struct cache_info *ci)
+{
+}
+
+static inline int sysinfo_get_processor_info(struct processor_info *pinfo)
+{
+	return -ENOSYS;
+}
+#endif
+
+#endif	/* __SMBIOS_PLAT_H */
diff --git a/include/sysinfo.h b/include/sysinfo.h
index cb6cf326535..ba2ac273e8e 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -11,6 +11,8 @@
 
 struct udevice;
 
+#define SYSINFO_CACHE_LVL_MAX 3
+
 /*
  * This uclass encapsulates hardware methods to gather information about a
  * sysinfo or a specific device such as hard-wired GPIOs on GPIO expanders,
@@ -42,18 +44,109 @@ struct udevice;
 enum sysinfo_id {
 	SYSID_NONE,
 
-	/* For SMBIOS tables */
+	/* BIOS Information (Type 0) */
+	SYSID_SM_BIOS_VENDOR,
+	SYSID_SM_BIOS_VER,
+	SYSID_SM_BIOS_REL_DATE,
+
+	/* System Information (Type 1) */
 	SYSID_SM_SYSTEM_MANUFACTURER,
 	SYSID_SM_SYSTEM_PRODUCT,
 	SYSID_SM_SYSTEM_VERSION,
 	SYSID_SM_SYSTEM_SERIAL,
+	SYSID_SM_SYSTEM_WAKEUP,
 	SYSID_SM_SYSTEM_SKU,
 	SYSID_SM_SYSTEM_FAMILY,
+
+	/* Baseboard (or Module) Information (Type 2) */
 	SYSID_SM_BASEBOARD_MANUFACTURER,
 	SYSID_SM_BASEBOARD_PRODUCT,
 	SYSID_SM_BASEBOARD_VERSION,
 	SYSID_SM_BASEBOARD_SERIAL,
 	SYSID_SM_BASEBOARD_ASSET_TAG,
+	SYSID_SM_BASEBOARD_FEATURE,
+	SYSID_SM_BASEBOARD_CHASSIS_LOCAT,
+	SYSID_SM_BASEBOARD_TYPE,
+	SYSID_SM_BASEBOARD_OBJS_NUM,
+	SYSID_SM_BASEBOARD_OBJS_HANDLE,
+
+	/* System Enclosure or Chassis (Type 3) */
+	SYSID_SM_ENCLOSURE_MANUFACTURER,
+	SYSID_SM_ENCLOSURE_VERSION,
+	SYSID_SM_ENCLOSURE_SERIAL,
+	SYSID_SM_ENCLOSURE_ASSET_TAG,
+	SYSID_SM_ENCLOSURE_TYPE,
+	SYSID_SM_ENCLOSURE_BOOTUP,
+	SYSID_SM_ENCLOSURE_POW,
+	SYSID_SM_ENCLOSURE_THERMAL,
+	SYSID_SM_ENCLOSURE_SECURITY,
+	SYSID_SM_ENCLOSURE_OEM,
+	SYSID_SM_ENCLOSURE_HEIGHT,
+	SYSID_SM_ENCLOSURE_POWCORE_NUM,
+	SYSID_SM_ENCLOSURE_ELEMENT_CNT,
+	SYSID_SM_ENCLOSURE_ELEMENT_LEN,
+	SYSID_SM_ENCLOSURE_ELEMENTS,
+	SYSID_SM_ENCLOSURE_SKU,
+
+	/* Processor Information (Type 4) */
+	SYSID_SM_PROCESSOR_SOCKET,
+	SYSID_SM_PROCESSOR_TYPE,
+	SYSID_SM_PROCESSOR_MANUFACT,
+	SYSID_SM_PROCESSOR_ID,
+	SYSID_SM_PROCESSOR_VERSION,
+	SYSID_SM_PROCESSOR_VOLTAGE,
+	SYSID_SM_PROCESSOR_EXT_CLOCK,
+	SYSID_SM_PROCESSOR_MAX_SPEED,
+	SYSID_SM_PROCESSOR_CUR_SPEED,
+	SYSID_SM_PROCESSOR_STATUS,
+	SYSID_SM_PROCESSOR_UPGRADE,
+	SYSID_SM_PROCESSOR_SN,
+	SYSID_SM_PROCESSOR_ASSET_TAG,
+	SYSID_SM_PROCESSOR_PN,
+	SYSID_SM_PROCESSOR_CORE_CNT,
+	SYSID_SM_PROCESSOR_CORE_EN,
+	SYSID_SM_PROCESSOR_THREAD_CNT,
+	SYSID_SM_PROCESSOR_CHARA,
+	SYSID_SM_PROCESSOR_FAMILY,
+	SYSID_SM_PROCESSOR_FAMILY2,
+	SYSID_SM_PROCESSOR_CORE_CNT2,
+	SYSID_SM_PROCESSOR_CORE_EN2,
+	SYSID_SM_PROCESSOR_THREAD_CNT2,
+	SYSID_SM_PROCESSOR_THREAD_EN,
+
+	/*
+	 * Cache Information (Type 7)
+	 * Each of the id should reserve space for up to
+	 * SYSINFO_CACHE_LVL_MAX levels of cache
+	 */
+	SYSID_SM_CACHE_LEVEL,
+	SYSID_SM_CACHE_HANDLE,
+	SYSID_SM_CACHE_INFO_START,
+	SYSID_SM_CACHE_SOCKET = SYSID_SM_CACHE_INFO_START,
+	SYSID_SM_CACHE_CONFIG =
+		SYSID_SM_CACHE_SOCKET + SYSINFO_CACHE_LVL_MAX,
+	SYSID_SM_CACHE_MAX_SIZE =
+		SYSID_SM_CACHE_CONFIG + SYSINFO_CACHE_LVL_MAX,
+	SYSID_SM_CACHE_INST_SIZE =
+		SYSID_SM_CACHE_MAX_SIZE + SYSINFO_CACHE_LVL_MAX,
+	SYSID_SM_CACHE_SUPSRAM_TYPE =
+		SYSID_SM_CACHE_INST_SIZE + SYSINFO_CACHE_LVL_MAX,
+	SYSID_SM_CACHE_CURSRAM_TYPE =
+		SYSID_SM_CACHE_SUPSRAM_TYPE + SYSINFO_CACHE_LVL_MAX,
+	SYSID_SM_CACHE_SPEED =
+		SYSID_SM_CACHE_CURSRAM_TYPE + SYSINFO_CACHE_LVL_MAX,
+	SYSID_SM_CACHE_ERRCOR_TYPE =
+		SYSID_SM_CACHE_SPEED + SYSINFO_CACHE_LVL_MAX,
+	SYSID_SM_CACHE_SCACHE_TYPE =
+		SYSID_SM_CACHE_ERRCOR_TYPE + SYSINFO_CACHE_LVL_MAX,
+	SYSID_SM_CACHE_ASSOC =
+		SYSID_SM_CACHE_SCACHE_TYPE + SYSINFO_CACHE_LVL_MAX,
+	SYSID_SM_CACHE_MAX_SIZE2 =
+		SYSID_SM_CACHE_ASSOC + SYSINFO_CACHE_LVL_MAX,
+	SYSID_SM_CACHE_INST_SIZE2 =
+		SYSID_SM_CACHE_MAX_SIZE2 + SYSINFO_CACHE_LVL_MAX,
+	SYSID_SM_CACHE_INFO_END =
+		SYSID_SM_CACHE_INST_SIZE2 + SYSINFO_CACHE_LVL_MAX - 1,
 
 	/* For show_board_info() */
 	SYSID_BOARD_MODEL,
-- 
2.25.1

