Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED508C531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 15:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC98188BEA;
	Fri, 16 Aug 2024 17:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zkfJzBiY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70967889E9; Fri, 16 Aug 2024 17:48:07 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26C1D88BDE
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 17:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5d5e1c86b83so1345385eaf.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 08:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723823281; x=1724428081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/rFyRfaNUH6/utusI/R0Mp3BNY4CZRx252niMnQimcA=;
 b=zkfJzBiYb2aQRyD9LPtU7jsr0v9v2nwJZLQMs93q7uLRyy1PLflwBeCbU7XxV+3/Vc
 Fz7R90z6If8cyRgoMnaFCG1N4C2T/HX/Jb2/5AaaJdhZ5BXNYfsonCJ/vKieOntvLD4I
 K9hnFcteWUJHxuhfRAuJJ4HiGCwfWfgRQPWWrI3ZPobHZN6AgiNLzFETX3k3ZY9UdQbW
 ZnSvcPvehRFPtriEMQ2u2SaUqt4pr+R15S/XsIsCkSxWfOKochJm7oME4OcKkqxrj/f0
 RJlVcwtB3Szf1JAzncoPJKqp5mNIvxnYLMcUrbaLhjkxuFU28l1ifRNLXnFCFf9u6rPE
 uXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723823281; x=1724428081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/rFyRfaNUH6/utusI/R0Mp3BNY4CZRx252niMnQimcA=;
 b=ZmDMLou0iVJkQUcpiJ7+mRljbz2/UTCWzlgesVMHJnaiTUKeOKv0scAoK2G4wfb+BC
 YdjZAhTMwqXnG4cSpMUbzggx3tB4Ms4YVP1v6ipKTlG5Fmv2O2DYsc+YXRMfpzuKgLAP
 x2SWrvh4fW7g4zupedd2UF05RE6+C1I2DMcR4lYKDNEDZGHNN0N1kUyMaZSKOMq/ECFl
 oqTRzquiVZHhCNN3UrKGaeLe1uVMVU8q93NIhAqNj3urSghv+d/GTNfV9U9/NlOFQqHh
 dEmQmk1IxS7gHF6swpvY4LzIWYdHAhlZFINEd7FBzcGmCt9pbZy4yHOMk8TF2eI0B00E
 DGzQ==
X-Gm-Message-State: AOJu0YyNVfcz9ttb8Fz0PT6Z2LtbOEgZ5ZSodIfBQXLpLiTOgGUKrglr
 zcQrJ6QqzlJEHtBYqCDpgxFHOycCUaXtDXyASrhfnh05/aPUMgdYFmM8FCYwjl/4IPVbOKacVwW
 8aI0=
X-Google-Smtp-Source: AGHT+IFT7yCLcooXl8+2gTx4W+jiY6VECHWRidEiUsRcQaA2MoM8k/5iBECKS5Ou+/vnIVVzZFuOOA==
X-Received: by 2002:a05:6358:57a2:b0:1aa:aec5:674b with SMTP id
 e5c5f4694b2df-1b393315bf3mr421111955d.29.1723823281250; 
 Fri, 16 Aug 2024 08:48:01 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff0e53d8sm187041185a.85.2024.08.16.08.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:47:59 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 06/10] sysinfo: Add sysinfo driver for SMBIOS type 7
Date: Fri, 16 Aug 2024 08:46:49 -0700
Message-Id: <20240816154658.1866186-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816154658.1866186-1-raymond.mao@linaro.org>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
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

Add sysinfo interface and data structures for cache information
required by SMBIOS type 7.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 drivers/sysinfo/smbios_plat.c | 172 ++++++++++++++++++++++++++++++++++
 drivers/sysinfo/smbios_plat.h |  27 ++++++
 include/smbios.h              | 112 ++++++++++++++++++++++
 include/sysinfo.h             |  36 +++++++
 4 files changed, 347 insertions(+)

diff --git a/drivers/sysinfo/smbios_plat.c b/drivers/sysinfo/smbios_plat.c
index adbc8cf3cf2..e225b42d672 100644
--- a/drivers/sysinfo/smbios_plat.c
+++ b/drivers/sysinfo/smbios_plat.c
@@ -12,14 +12,60 @@ struct sysinfo_plat_priv {
 	struct baseboard_info *t2;
 	struct enclosure_info *t3;
 	struct processor_info *t4;
+	struct smbios_type7 t7[SYSINFO_CACHE_LVL_MAX];
+	char *cache_socket_design[SYSINFO_CACHE_LVL_MAX];
+	u16 cache_handles[SYSINFO_CACHE_LVL_MAX];
+	u8 cache_level;
+	/*
+	 * TODO: add other types here:
+	 * Type 9 - System Slots
+	 * Type 16 - Physical Memory Array
+	 * Type 17 - Memory Device
+	 * Type 19 - Memory Array Mapped Address
+	 */
 };
 
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
 /* weak function for the platforms not yet supported */
+__weak int sysinfo_get_cache_info(u8 level, struct cache_info *cache_info)
+{
+	return -ENOSYS;
+}
 __weak int sysinfo_get_processor_info(struct processor_info *pinfo)
 {
 	return -ENOSYS;
 }
 
+void sysinfo_cache_info_default(struct cache_info *ci)
+{
+	memset(ci, 0, sizeof(*ci));
+	ci->config.fields.locate = SMBIOS_CACHE_LOCATE_UNKNOWN;
+	ci->config.fields.opmode = SMBIOS_CACHE_OP_UND;
+	ci->supp_sram_type.fields.unknown = 1;
+	ci->curr_sram_type.fields.unknown = 1;
+	ci->speed = SMBIOS_CACHE_SPEED_UNKNOWN;
+	ci->err_corr_type = SMBIOS_CACHE_ERRCORR_UNKNOWN;
+	ci->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_UNKNOWN;
+}
+
 static int sysinfo_plat_detect(struct udevice *dev)
 {
 	return 0;
@@ -30,6 +76,22 @@ static int sysinfo_plat_get_str(struct udevice *dev, int id,
 {
 	struct sysinfo_plat_priv *priv = dev_get_priv(dev);
 	const char *str = NULL;
+	u8 i;
+
+	if (id >= SYSINFO_ID_SMBIOS_CACHE_INFO_START &&
+	    id <= SYSINFO_ID_SMBIOS_CACHE_INFO_END) {
+		/* For smbios type 7 */
+		for (i = 0; i < priv->cache_level; i++) {
+			switch (id - i) {
+			case SYSINFO_ID_SMBIOS_CACHE_SOCKET:
+				str = priv->cache_socket_design[i];
+				break;
+			default:
+				break;
+			}
+		}
+		goto handle_str;
+	}
 
 	switch (id) {
 	case SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER:
@@ -105,6 +167,7 @@ static int sysinfo_plat_get_str(struct udevice *dev, int id,
 		break;
 	}
 
+handle_str:
 	if (!str)
 		return -ENOSYS;
 
@@ -116,6 +179,52 @@ static int sysinfo_plat_get_str(struct udevice *dev, int id,
 static int sysinfo_plat_get_int(struct udevice *dev, int id, int *val)
 {
 	struct sysinfo_plat_priv *priv = dev_get_priv(dev);
+	u8 i;
+
+	if (id >= SYSINFO_ID_SMBIOS_CACHE_INFO_START &&
+	    id <= SYSINFO_ID_SMBIOS_CACHE_INFO_END) {
+		/* For smbios type 7 */
+		for (i = 0; i < priv->cache_level; i++) {
+			switch (id - i) {
+			case SYSINFO_ID_SMBIOS_CACHE_CONFIG:
+				*val = priv->t7[i].config.data;
+				break;
+			case SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE:
+				*val = priv->t7[i].max_size.data;
+				break;
+			case SYSINFO_ID_SMBIOS_CACHE_INST_SIZE:
+				*val = priv->t7[i].inst_size.data;
+				break;
+			case SYSINFO_ID_SMBIOS_CACHE_SUPSRAM_TYPE:
+				*val = priv->t7[i].supp_sram_type.data;
+				break;
+			case SYSINFO_ID_SMBIOS_CACHE_CURSRAM_TYPE:
+				*val = priv->t7[i].curr_sram_type.data;
+				break;
+			case SYSINFO_ID_SMBIOS_CACHE_SPEED:
+				*val = priv->t7[i].speed;
+				break;
+			case SYSINFO_ID_SMBIOS_CACHE_ERRCOR_TYPE:
+				*val = priv->t7[i].err_corr_type;
+				break;
+			case SYSINFO_ID_SMBIOS_CACHE_SCACHE_TYPE:
+				*val = priv->t7[i].sys_cache_type;
+				break;
+			case SYSINFO_ID_SMBIOS_CACHE_ASSOC:
+				*val = priv->t7[i].associativity;
+				break;
+			case SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE2:
+				*val = priv->t7[i].max_size2.data;
+				break;
+			case SYSINFO_ID_SMBIOS_CACHE_INST_SIZE2:
+				*val = priv->t7[i].inst_size2.data;
+				break;
+			default:
+				break;
+			}
+		}
+		return 0;
+	}
 
 	switch (id) {
 	case SYSINFO_ID_SMBIOS_SYSTEM_WAKEUP:
@@ -208,6 +317,11 @@ static int sysinfo_plat_get_int(struct udevice *dev, int id, int *val)
 	case SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_EN:
 		*val = priv->t4->thread_enabled;
 		break;
+	case SYSINFO_ID_SMBIOS_CACHE_LEVEL:
+		if (!priv->cache_level)	/* No cache detected */
+			return -ENOSYS;
+		*val = priv->cache_level - 1;
+		break;
 	default:
 		break;
 	}
@@ -233,6 +347,10 @@ static int sysinfo_plat_get_data(struct udevice *dev, int id, uchar **buf,
 		*buf = (uchar *)priv->t4->id;
 		*size = sizeof(priv->t4->id);
 		break;
+	case SYSINFO_ID_SMBIOS_CACHE_HANDLE:
+		*buf = (uchar *)(&priv->cache_handles[0]);
+		*size = sizeof(priv->cache_handles);
+		break;
 	default:
 		break;
 	}
@@ -243,6 +361,7 @@ static int sysinfo_plat_probe(struct udevice *dev)
 {
 	struct sysinfo_plat_priv *priv = dev_get_priv(dev);
 	struct sysinfo_plat *plat = dev_get_plat(dev);
+	u8 level;
 
 	priv->t1 = &plat->sys;
 	priv->t2 = &plat->board;
@@ -251,6 +370,59 @@ static int sysinfo_plat_probe(struct udevice *dev)
 	if (!sysinfo_get_processor_info(plat->processor))
 		priv->t4 = plat->processor;
 
+	for (level = 0; level < SYSINFO_CACHE_LVL_MAX; level++) {
+		struct cache_info *pcache = plat->cache + level;
+
+		if (sysinfo_get_cache_info(level, pcache))
+			break; /* no more levels */
+
+		/*
+		 * Fill in the SMBIOS type 7 structure,
+		 * skip the header members - type, length, handle
+		 */
+		priv->t7[level].config.data = pcache->config.data;
+		priv->t7[level].supp_sram_type.data =
+			pcache->supp_sram_type.data;
+		priv->t7[level].curr_sram_type.data =
+			pcache->curr_sram_type.data;
+		priv->t7[level].speed = pcache->speed;
+		priv->t7[level].err_corr_type = pcache->err_corr_type;
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
+		priv->cache_socket_design[level] = pcache->socket_design;
+		smbios_cache_info_dump(&priv->t7[level]);
+	}
+	if (!level) /* no cache detected */
+		return -ENOSYS;
+
+	priv->cache_level = level;
+
 	return 0;
 }
 
diff --git a/drivers/sysinfo/smbios_plat.h b/drivers/sysinfo/smbios_plat.h
index 3576f492ecb..8439feb9fc5 100644
--- a/drivers/sysinfo/smbios_plat.h
+++ b/drivers/sysinfo/smbios_plat.h
@@ -13,6 +13,20 @@
  * sysinfo_plat and all sub data structure should be moved to <asm/sysinfo.h>
  * if we have this defined for each arch.
  */
+struct __packed cache_info {
+	char *socket_design;
+	union cache_config config;
+	u32 line_size;
+	u32 associativity;
+	u32 max_size;
+	u32 inst_size;
+	u8 cache_type;
+	union cache_sram_type supp_sram_type;
+	union cache_sram_type curr_sram_type;
+	u8 speed;
+	u8 err_corr_type;
+};
+
 struct __packed sys_info {
 	char *manufacturer;
 	char *prod_name;
@@ -89,12 +103,25 @@ struct sysinfo_plat {
 	struct baseboard_info board;
 	struct enclosure_info chassis;
 	struct processor_info *processor;
+	struct cache_info *cache;
 	/* add other sysinfo structure here */
 };
 
 #if CONFIG_IS_ENABLED(SYSINFO_SMBIOS)
+int sysinfo_get_cache_info(u8 level, struct cache_info *cache_info);
+void sysinfo_cache_info_default(struct cache_info *ci);
 int sysinfo_get_processor_info(struct processor_info *pinfo);
 #else
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
 static inline int sysinfo_get_processor_info(struct processor_info *pinfo)
 {
 	return -ENOSYS;
diff --git a/include/smbios.h b/include/smbios.h
index f2269642268..267a672cefe 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -308,8 +308,120 @@ struct __packed smbios_type4 {
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
+/* Cache Information */
+
+#define SMBIOS_CACHE_SIZE_EXT_KB (2047 * 1024) /* 2047 MiB */
 #define SMBIOS_CACHE_HANDLE_NONE 0xffff
 
+#define SMBIOS_CACHE_SYSCACHE_TYPE_OTHER	1
+#define SMBIOS_CACHE_SYSCACHE_TYPE_UNKNOWN	2
+#define SMBIOS_CACHE_SYSCACHE_TYPE_INSTRUCTION	3
+#define SMBIOS_CACHE_SYSCACHE_TYPE_DATA		4
+#define SMBIOS_CACHE_SYSCACHE_TYPE_UNIFIED	5
+
+#define SMBIOS_CACHE_SPEED_UNKNOWN	0
+
+#define SMBIOS_CACHE_ERRCORR_OTHER	1
+#define SMBIOS_CACHE_ERRCORR_UNKNOWN	2
+#define SMBIOS_CACHE_ERRCORR_NONE	3
+#define SMBIOS_CACHE_ERRCORR_PARITY	4
+#define SMBIOS_CACHE_ERRCORR_SBITECC	5
+#define SMBIOS_CACHE_ERRCORR_MBITECC	6
+
+#define SMBIOS_CACHE_UNSOCKETED	0
+#define SMBIOS_CACHE_SOCKETED	1
+
+#define SMBIOS_CACHE_LOCATE_INTERNAL	0
+#define SMBIOS_CACHE_LOCATE_EXTERNAL	1
+#define SMBIOS_CACHE_LOCATE_RESERVED	2
+#define SMBIOS_CACHE_LOCATE_UNKNOWN	3
+
+#define SMBIOS_CACHE_DISABLED	0
+#define SMBIOS_CACHE_ENABLED	1
+
+#define SMBIOS_CACHE_OP_WT	0 /* Write Through */
+#define SMBIOS_CACHE_OP_WB	1 /* Write Back */
+#define SMBIOS_CACHE_OP_VAR	2 /* Varies with Memory Address */
+#define SMBIOS_CACHE_OP_UND	3 /* Unknown*/
+
+#define SMBIOS_CACHE_GRANU_1K	0
+#define SMBIOS_CACHE_GRANU_64K	1
+
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
diff --git a/include/sysinfo.h b/include/sysinfo.h
index 6c9de7744c1..708bfc17ea6 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -11,6 +11,8 @@
 
 struct udevice;
 
+#define SYSINFO_CACHE_LVL_MAX 3
+
 /*
  * This uclass encapsulates hardware methods to gather information about a
  * sysinfo or a specific device such as hard-wired GPIOs on GPIO expanders,
@@ -111,6 +113,40 @@ enum sysinfo_id {
 	SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT2,
 	SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_EN,
 
+	/*
+	 * Cache Information (Type 7)
+	 * Each of the id should reserve space for up to
+	 * SYSINFO_CACHE_LVL_MAX levels of cache
+	 */
+	SYSINFO_ID_SMBIOS_CACHE_LEVEL,
+	SYSINFO_ID_SMBIOS_CACHE_HANDLE,
+	SYSINFO_ID_SMBIOS_CACHE_INFO_START,
+	SYSINFO_ID_SMBIOS_CACHE_SOCKET = SYSINFO_ID_SMBIOS_CACHE_INFO_START,
+	SYSINFO_ID_SMBIOS_CACHE_CONFIG =
+		SYSINFO_ID_SMBIOS_CACHE_SOCKET + SYSINFO_CACHE_LVL_MAX,
+	SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE =
+		SYSINFO_ID_SMBIOS_CACHE_CONFIG + SYSINFO_CACHE_LVL_MAX,
+	SYSINFO_ID_SMBIOS_CACHE_INST_SIZE =
+		SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE + SYSINFO_CACHE_LVL_MAX,
+	SYSINFO_ID_SMBIOS_CACHE_SUPSRAM_TYPE =
+		SYSINFO_ID_SMBIOS_CACHE_INST_SIZE + SYSINFO_CACHE_LVL_MAX,
+	SYSINFO_ID_SMBIOS_CACHE_CURSRAM_TYPE =
+		SYSINFO_ID_SMBIOS_CACHE_SUPSRAM_TYPE + SYSINFO_CACHE_LVL_MAX,
+	SYSINFO_ID_SMBIOS_CACHE_SPEED =
+		SYSINFO_ID_SMBIOS_CACHE_CURSRAM_TYPE + SYSINFO_CACHE_LVL_MAX,
+	SYSINFO_ID_SMBIOS_CACHE_ERRCOR_TYPE =
+		SYSINFO_ID_SMBIOS_CACHE_SPEED + SYSINFO_CACHE_LVL_MAX,
+	SYSINFO_ID_SMBIOS_CACHE_SCACHE_TYPE =
+		SYSINFO_ID_SMBIOS_CACHE_ERRCOR_TYPE + SYSINFO_CACHE_LVL_MAX,
+	SYSINFO_ID_SMBIOS_CACHE_ASSOC =
+		SYSINFO_ID_SMBIOS_CACHE_SCACHE_TYPE + SYSINFO_CACHE_LVL_MAX,
+	SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE2 =
+		SYSINFO_ID_SMBIOS_CACHE_ASSOC + SYSINFO_CACHE_LVL_MAX,
+	SYSINFO_ID_SMBIOS_CACHE_INST_SIZE2 =
+		SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE2 + SYSINFO_CACHE_LVL_MAX,
+	SYSINFO_ID_SMBIOS_CACHE_INFO_END =
+		SYSINFO_ID_SMBIOS_CACHE_INST_SIZE2 + SYSINFO_CACHE_LVL_MAX - 1,
+
 	/* For show_board_info() */
 	SYSINFO_ID_BOARD_MODEL,
 	SYSINFO_ID_BOARD_MANUFACTURER,
-- 
2.25.1

