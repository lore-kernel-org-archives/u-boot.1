Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A97C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 15:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FDC388BC8;
	Fri, 16 Aug 2024 17:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AFSpuO3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 420E388BFE; Fri, 16 Aug 2024 17:48:19 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 095F488B9E
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 17:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a5074ebb9aso59706385a.1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723823294; x=1724428094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+GSAlkn089H/W3Sx8g4+yA/E1QFxfKwRDnu1VERFT0=;
 b=AFSpuO3W/VIhYddKNyoPDaTBmluSVZf+q0PrmkaFDugCJb6+U4WI712vn/ekJteiAD
 ODC/hPjiqdSawpBbDtHAyzp8CfWIsZ5z3Agz3r01+pwv86yE+LrlWwlFdPam0gPZkksI
 94UhU6gW4Wpzmv9MWV/5Fcjw/6/DrHDUAZ2VMPBqIa7uWpYMY9xOIh9eo58pPP+aBDT6
 nu2Hrzf14TZm6I+XZJVuC6hMb3Y7fNWko80hAQXZZBo3RUDXhBVgZtPXe3AobbZsy0pg
 aKmKz8xewdu0HXdFlnM+OQE2kzKRaX3vQFHnosmQ2nkwIWOyEgPnydscfs0c+AAFht/Y
 rz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723823294; x=1724428094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+GSAlkn089H/W3Sx8g4+yA/E1QFxfKwRDnu1VERFT0=;
 b=W6x93XDrxKL/5K6vQMSdnJNOzGJ5V2PhGtmD9y1pDoE8o1J7xwtchaUPXGTvh5y3GD
 EUHBOfc1+0+kKaC4glUgNJCZem2gDhcr3tS50DlhTWR3JyvGS8/u9TjckxoloVoONEIT
 69BvfTroPo4bh1P2gYr3CjlUf1DJfE7acHqFUXq4Er7WUwRJM+pv9UH6l3danv27qUlj
 tOepN7GdAnuOVv6Au5ClhONAf1IZ42KGBl+wnlRckcmY08DeB8MuQrSJqe72Ft+3KAlL
 xyMsnhKL5rUxCTwEsRHsyS5q2+4qFbo5a9WFR5UxiQz/zeZgJnCcPVZC9OF5bs1LcV5N
 nu8g==
X-Gm-Message-State: AOJu0YySq7u4bjuY1E7PqCE8gg/lMVjpohH1F3hgchTvF2aSQlbeE+SK
 h9b3dmf6hqaW0f5Mx9V1wcKlnEgAkNQpSIOeTprh+QMAUnC3dWuk0mCiuO6kE6hKzrZGaIwW+2J
 aFug=
X-Google-Smtp-Source: AGHT+IG1GQaE4ci7Q/Wk2ow23trrrEgm65QO2uLIFRomL6MWp3thT50PH33ogSoypTaMHzk87agalg==
X-Received: by 2002:a05:620a:2a10:b0:7a2:d64:1cbc with SMTP id
 af79cd13be357-7a50693d5efmr419882485a.26.1723823294082; 
 Fri, 16 Aug 2024 08:48:14 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff0e53d8sm187041185a.85.2024.08.16.08.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:48:13 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Bin Meng <bmeng@tinylab.org>,
 Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 08/10] armv8: Add sysinfo driver for cache information
Date: Fri, 16 Aug 2024 08:46:51 -0700
Message-Id: <20240816154658.1866186-9-raymond.mao@linaro.org>
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

Add cache information sysinfo driver containing necessary information
required by SMBIOS type 7 for all armv8 platforms.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 arch/arm/cpu/armv8/sysinfo.c | 188 +++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/arch/arm/cpu/armv8/sysinfo.c b/arch/arm/cpu/armv8/sysinfo.c
index a8e17d654be..73e071212ae 100644
--- a/arch/arm/cpu/armv8/sysinfo.c
+++ b/arch/arm/cpu/armv8/sysinfo.c
@@ -13,6 +13,30 @@
 #define ELEMENT_RECORD_DATA_LEN 8
 #define ELEMENT_RECORD_NUM 2
 
+union ccsidr_el1 {
+	struct {
+		u64 linesize:3;
+		u64 associativity:10;
+		u64 numsets:15;
+		u64 unknown:4;
+		u64 reserved:32;
+	} no_ccidx;
+	struct {
+		u64 linesize:3;
+		u64 associativity:21;
+		u64 reserved1:8;
+		u64 numsets:24;
+		u64 reserved2:8;
+	} ccidx_aarch64;
+	struct {
+		u64 linesize:3;
+		u64 associativity:21;
+		u64 reserved:8;
+		u64 unallocated:32;
+	} ccidx_aarch32;
+	u64 data;
+};
+
 union midr_el1 {
 	struct {
 		u64 revision:4;
@@ -25,6 +49,28 @@ union midr_el1 {
 	u64 data;
 };
 
+enum {
+	CACHE_NONE,
+	CACHE_INST_ONLY,
+	CACHE_DATA_ONLY,
+	CACHE_INST_WITH_DATA,
+	CACHE_UNIFIED,
+};
+
+enum {
+	CACHE_ASSOC_DIRECT_MAPPED = 1,
+	CACHE_ASSOC_2WAY = 2,
+	CACHE_ASSOC_4WAY = 4,
+	CACHE_ASSOC_8WAY = 8,
+	CACHE_ASSOC_16WAY = 16,
+	CACHE_ASSOC_12WAY = 12,
+	CACHE_ASSOC_24WAY = 24,
+	CACHE_ASSOC_32WAY = 32,
+	CACHE_ASSOC_48WAY = 48,
+	CACHE_ASSOC_64WAY = 64,
+	CACHE_ASSOC_20WAY = 20,
+};
+
 enum {
 	VENDOR_RESERVED = 0,
 	VENDOR_ARM = 0x41,
@@ -47,6 +93,7 @@ struct __packed enclosure_element_record {
 	u8 data[ELEMENT_RECORD_DATA_LEN];
 };
 
+struct cache_info cache_info_armv8[SYSINFO_CACHE_LVL_MAX];
 struct processor_info processor_info_armv8;
 
 /* Default data for the enclosure contained elements */
@@ -65,6 +112,144 @@ struct enclosure_element_record contained_elements[ELEMENT_RECORD_NUM] = {
 	},
 };
 
+/*
+ * TODO:
+ * To support ARMv8.3, we need to read "CCIDX, bits [23:20]" from
+ * ID_AA64MMFR2_EL1 to get the format of CCSIDR_EL1:
+ *
+ * 0b0000 - 32-bit format implemented for all levels of the CCSIDR_EL1.
+ * 0b0001 - 64-bit format implemented for all levels of the CCSIDR_EL1.
+ *
+ * Here we assume to use CCSIDR_EL1 in no CCIDX layout:
+ * NumSets, bits [27:13]: (Number of sets in cache) - 1
+ * Associativity, bits [12:3]: (Associativity of cache) - 1
+ * LineSize, bits [2:0]: (Log2(Number of bytes in cache line)) - 4
+ */
+int sysinfo_get_cache_info(u8 level, struct cache_info *cinfo)
+{
+	u64 clidr_el1;
+	u32 csselr_el1;
+	u32 num_sets;
+	union ccsidr_el1 creg;
+	int cache_type;
+
+	sysinfo_cache_info_default(cinfo);
+
+	/* Read CLIDR_EL1 */
+	asm volatile("mrs %0, clidr_el1" : "=r" (clidr_el1));
+	log_debug("CLIDR_EL1: 0x%llx\n", clidr_el1);
+
+	cache_type = (clidr_el1 >> (3 * level)) & 0x7;
+	log_debug("cache_type:%d\n", cache_type);
+
+	if (cache_type == CACHE_NONE) /* level does not exist */
+		return -1;
+
+	switch (cache_type) {
+	case CACHE_INST_ONLY:
+		cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_INSTRUCTION;
+		break;
+	case CACHE_DATA_ONLY:
+		cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_DATA;
+		break;
+	case CACHE_UNIFIED:
+		cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_UNIFIED;
+		break;
+	case CACHE_INST_WITH_DATA:
+		cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_OTHER;
+		break;
+	default:
+		cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_UNKNOWN;
+		break;
+	}
+
+	/* Select cache level */
+	csselr_el1 = (level << 1);
+	asm volatile("msr csselr_el1, %0" : : "r" (csselr_el1));
+
+	/* Read CCSIDR_EL1 */
+	asm volatile("mrs %0, ccsidr_el1" : "=r" (creg.data));
+	log_debug("CCSIDR_EL1 (Level %d): 0x%llx\n", level + 1, creg.data);
+
+	/* Extract cache size and associativity */
+	cinfo->line_size = 1 << (creg.no_ccidx.linesize + 4);
+
+	/* Map the associativity value */
+	switch (creg.no_ccidx.associativity + 1) {
+	case CACHE_ASSOC_DIRECT_MAPPED:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_DMAPPED;
+		break;
+	case CACHE_ASSOC_2WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_2WAY;
+		break;
+	case CACHE_ASSOC_4WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_4WAY;
+		break;
+	case CACHE_ASSOC_8WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_8WAY;
+		break;
+	case CACHE_ASSOC_16WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_16WAY;
+		break;
+	case CACHE_ASSOC_12WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_12WAY;
+		break;
+	case CACHE_ASSOC_24WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_24WAY;
+		break;
+	case CACHE_ASSOC_32WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_32WAY;
+		break;
+	case CACHE_ASSOC_48WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_48WAY;
+		break;
+	case CACHE_ASSOC_64WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_64WAY;
+		break;
+	case CACHE_ASSOC_20WAY:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_20WAY;
+		break;
+	default:
+		cinfo->associativity = SMBIOS_CACHE_ASSOC_UNKNOWN;
+		break;
+	}
+
+	num_sets = creg.no_ccidx.numsets + 1;
+	/* Size in KB */
+	cinfo->max_size = (cinfo->associativity * num_sets * cinfo->line_size) /
+			  1024;
+
+	log_debug("L%d Cache:\n", level + 1);
+	log_debug("Number of bytes in cache line:%u\n", cinfo->line_size);
+	log_debug("Associativity of cache:%u\n", cinfo->associativity);
+	log_debug("Number of sets in cache:%u\n", num_sets);
+	log_debug("Cache size in KB:%u\n", cinfo->max_size);
+
+	cinfo->inst_size = cinfo->max_size;
+
+	/*
+	 * Below fields are set with default values for Arm arch,
+	 * More information are hardware platform specific.
+	 */
+	cinfo->socket_design = "Not Specified";
+	cinfo->config.fields.level = level;
+	/* Generally, "Not-Socketed" is for integrated caches */
+	cinfo->config.fields.bsocketed = SMBIOS_CACHE_UNSOCKETED;
+	/* For modern SoCs, L1/L2 cache are usually internal */
+	cinfo->config.fields.locate = SMBIOS_CACHE_LOCATE_INTERNAL;
+	cinfo->config.fields.benabled = SMBIOS_CACHE_ENABLED;
+	/* Generally, L1 and L2 caches are write-back */
+	cinfo->config.fields.opmode = SMBIOS_CACHE_OP_WB;
+
+	/*
+	 * Other fields are typically specific to the implementation of the ARM
+	 * processor by the silicon vendor:
+	 * supp_sram_type, curr_sram_type, speed, err_corr_type
+	 */
+
+	return 0;
+}
+
 int sysinfo_get_processor_info(struct processor_info *pinfo)
 {
 	u64 mpidr, core_count;
@@ -195,6 +380,9 @@ struct sysinfo_plat sysinfo_smbios_armv8 = {
 
 	/* Processor Information */
 	.processor = &processor_info_armv8,
+
+	/* Cache Information */
+	.cache = &cache_info_armv8[0],
 };
 
 U_BOOT_DRVINFO(sysinfo_smbios_plat) = {
-- 
2.25.1

