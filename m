Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD340CA0FE1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F62588C42;
	Fri, 30 Aug 2024 14:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lQxIC2MK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9DA488BBC; Fri, 30 Aug 2024 14:34:43 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E91A988C1D
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-371ba7e46easo1215347f8f.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725021281; x=1725626081; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+tWn7S7F6fQZgqjDN+flyyE00k/zWkvOf5I9LrWFh+Y=;
 b=lQxIC2MK0abMZJOi5BRHVLvOUZhrYB/267AVST69dO0Iz62Pqp40S9onrKms/qd4KG
 RzjmRSrkND5th31JDb808KuWDuLbU8YdPTjQRYwsdxqBgFsRBwtvFQDmeMGKGWdeHO5T
 fCFUmZ42tpk06vG0oJTC89OPlEAZ3PN4f6EyIgcrEz3BIxuittS1Q0vCSdgbyfESDFo1
 /OVnkBfdAoYHm7kF5aEjnRTsXBwb5ncu1D9rZZKXrO8RMUAQkE+bZ0Ihk6RIczRy98mI
 RHNb+jE1RZLAtxq7Ly8F3HwMFNkAWJh62HSxQT3ygNYEjTQt0osdzPvBGGUkbyp1EKuU
 HCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725021281; x=1725626081;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+tWn7S7F6fQZgqjDN+flyyE00k/zWkvOf5I9LrWFh+Y=;
 b=PTEa3vRjQGpcNW6/vc2pg/E9aBatN7T2nfM+bXBPyeus9GuBRRfTDGtfc3uLRtVNDK
 MAWztjixO1gDLD+avU4KcaR07vH8KsPXlDOVW2Xw7gLnxGwMMLv+13Kc6H0LMjmRczoF
 cUkhC3BeZateuRFc0GnoOzdViLdPh9coLTALdOsrXKHcw/mjorGLhyDiqEpIji4LRw4K
 1NwDBopNAko846fHogHkulApp2ME812L3vZbMXgNwByp++bD0dkFDnUBIcFgUvkz66sj
 5khHykuy5hJruQRPa/v7ubHsl7wnr89MA7hzKxtAeFxC2+dRxVPIGIspqdPeV3JMSgBT
 rljA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjfJELfV5lnCQTmvY850fm0YHAFOXHnfpnvHpcLcotexrennj1HVt8BrhDnR1L9tOq7nGh7tk=@lists.denx.de
X-Gm-Message-State: AOJu0YyMSBFhpGBR9bVnfRloTHeuxoUVFMxF+8q/1MvMV4B3ruD+LH34
 0W9ENDptBgcbLBP3UMUhIb2o6D/+LTl5wskYUYQt6fHYBjybegr2rdhgU373eBs=
X-Google-Smtp-Source: AGHT+IFxf1q84Tgneg/hrQzeMZKGdQi60Wj/ABkDMTFzKFgMTpkIpzqiFUeVn3p3eWOmK7CZheM8wA==
X-Received: by 2002:adf:f008:0:b0:371:93eb:78a4 with SMTP id
 ffacd0b85a97d-3749b52ec3dmr4060667f8f.9.1725021281395; 
 Fri, 30 Aug 2024 05:34:41 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b960ef94sm648207f8f.103.2024.08.30.05.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 05:34:40 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 30 Aug 2024 13:34:36 +0100
Subject: [PATCH v8 06/11] lib: uuid: supporting building as part of host tools
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-b4-dynamic-uuid-v8-6-79b31b199bee@linaro.org>
References: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
In-Reply-To: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5314;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=7aAo+sig05F8UL/v3fHY/H8w6OBhvCpEAQe/4iFU7YM=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm0bxZj20hh4o8PQDSD6NkAg+NaBh55HlUcCYVR
 flTdBjvWsiJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtG8WQAKCRAFgzErGV9k
 tkEbEACDBNOfo/REER3YXLrAHdHA5+7UuI+0ccPIdKUnxiWpSoFuymoEbHYl0oEETtsu6Cuzq3l
 5hKed4S9BksOOzo7ONHOvTYVQiQA9XtBNonvWHxvVuKzn2fjv/4ocJj4CHhCrZ/PS8a7EcPkcjN
 LT9QC1NbnREHx3mEAH9CzTyIQzCpkgh+Tl/O594gPzUyskiRGW+vKtjLtwoADO318oIN3kDVRxw
 JwgQ7Wto5ZP1vP/3dwbBdCw8pdMZCUYCa3zpThb6eyw3QIaG/+idkbP4NfpON9znIxUVIFgCmJ3
 MS1SQAzNBEaJDm2wmxBOKtLepcF50ccZLZYKghr37rXOb3oBLmEHEOVbHaGrPZV2eCsgrZLWolU
 fnKkBY/TTWiInIM2Oj3ii+cilcxwe6Mrcyz8Ev3nhsRByH07rmfU+PXqjpCdvPX1Konrfq2GhlP
 4SvbNjo0EDvG5bARCcsjk9kieZ/MRcPh+Vyl2ruLGqOx2UFBepI9JzNfsAauxRdbgpuX0o66RDj
 324cgba+4y+LYrHpCKJi0wG9yO1X5EtaEqr76HXtM2IraKPs8DryvB75CjyYZlV4Frj9jG3sXcu
 pkw4tB+6FKSb2Pcuf06EYq0a23CYSe+3hYGjpGrDhtSuAqgsNb6lgNWwSR+hwtFBvflSW5kG1W9
 qeNPtsRCTldKukg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Adjust the UUID library code so that it can be compiled as part of a
host tool.

This removes the one redundant log_debug() call, as well as the
incorrectly defined LOG_CATEGORY.

In general this is a fairly trivial change, just adjusting includes and
disabling list_guid.

This will be used by a new genguid tool to generate v5 GUIDs that match
those generated by U-Boot at runtime.

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/uuid.h |  4 ++--
 lib/uuid.c     | 44 ++++++++++++++++++++++++++++++--------------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/include/uuid.h b/include/uuid.h
index 1f4fa103b5e9..7f8414dc906c 100644
--- a/include/uuid.h
+++ b/include/uuid.h
@@ -69,10 +69,10 @@ struct uuid {
 } __packed;
 
 /* Bits of a bitmask specifying the output format for GUIDs */
 #define UUID_STR_FORMAT_STD	0
-#define UUID_STR_FORMAT_GUID	BIT(0)
-#define UUID_STR_UPPER_CASE	BIT(1)
+#define UUID_STR_FORMAT_GUID	0x1
+#define UUID_STR_UPPER_CASE	0x2
 
 /* Use UUID_STR_LEN + 1 for string space */
 #define UUID_STR_LEN		36
 #define UUID_BIN_LEN		sizeof(struct uuid)
diff --git a/lib/uuid.c b/lib/uuid.c
index c9dfdf007a18..6fdae7997702 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -6,25 +6,38 @@
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
-#define LOG_CATEGOT LOGC_CORE
-
+#ifndef USE_HOSTCC
 #include <command.h>
 #include <efi_api.h>
 #include <env.h>
 #include <rand.h>
 #include <time.h>
-#include <uuid.h>
-#include <linux/ctype.h>
-#include <errno.h>
 #include <asm/io.h>
 #include <part_efi.h>
 #include <malloc.h>
 #include <dm/uclass.h>
 #include <rng.h>
+#include <linux/ctype.h>
+#include <hexdump.h>
+#else
+#include <stdarg.h>
+#include <stdint.h>
+#include <eficapsule.h>
+#include <ctype.h>
+#endif
+#include <linux/types.h>
+#include <errno.h>
+#include <linux/kconfig.h>
+#include <uuid.h>
 #include <u-boot/sha1.h>
 
+#ifdef USE_HOSTCC
+/* polyfill hextoul to avoid pulling in strto.c */
+#define hextoul(cp, endp) strtoul(cp, endp, 16)
+#endif
+
 int uuid_str_valid(const char *uuid)
 {
 	int i, valid;
 
@@ -51,8 +64,9 @@ int uuid_str_valid(const char *uuid)
 static const struct {
 	const char *string;
 	efi_guid_t guid;
 } list_guid[] = {
+#ifndef USE_HOSTCC
 #ifdef CONFIG_PARTITION_TYPE_GUID
 	{"system",	PARTITION_SYSTEM_GUID},
 	{"mbr",		LEGACY_MBR_PARTITION_GUID},
 	{"msft",	PARTITION_MSFT_RESERVED_GUID},
@@ -231,8 +245,9 @@ static const struct {
 	{ "EFI_MEMORY_TYPE", EFI_MEMORY_TYPE },
 	{ "EFI_MEM_STATUS_CODE_REC", EFI_MEM_STATUS_CODE_REC },
 	{ "EFI_GUID_EFI_ACPI1", EFI_GUID_EFI_ACPI1 },
 #endif
+#endif /* !USE_HOSTCC */
 };
 
 int uuid_guid_get_bin(const char *guid_str, unsigned char *guid_bin)
 {
@@ -266,9 +281,8 @@ int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
 	uint32_t tmp32;
 	uint64_t tmp64;
 
 	if (!uuid_str_valid(uuid_str)) {
-		log_debug("not valid\n");
 #ifdef CONFIG_PARTITION_TYPE_GUID
 		if (!uuid_guid_get_bin(uuid_str, uuid_bin))
 			return 0;
 #endif
@@ -297,19 +311,19 @@ int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
 
 	tmp16 = cpu_to_be16(hextoul(uuid_str + 19, NULL));
 	memcpy(uuid_bin + 8, &tmp16, 2);
 
-	tmp64 = cpu_to_be64(simple_strtoull(uuid_str + 24, NULL, 16));
+	tmp64 = cpu_to_be64(hextoul(uuid_str + 24, NULL));
 	memcpy(uuid_bin + 10, (char *)&tmp64 + 2, 6);
 
 	return 0;
 }
 
 int uuid_str_to_le_bin(const char *uuid_str, unsigned char *uuid_bin)
 {
-	u16 tmp16;
-	u32 tmp32;
-	u64 tmp64;
+	uint16_t tmp16;
+	uint32_t tmp32;
+	uint64_t tmp64;
 
 	if (!uuid_str_valid(uuid_str) || !uuid_bin)
 		return -EINVAL;
 
@@ -324,22 +338,22 @@ int uuid_str_to_le_bin(const char *uuid_str, unsigned char *uuid_bin)
 
 	tmp16 = cpu_to_le16(hextoul(uuid_str + 19, NULL));
 	memcpy(uuid_bin + 8, &tmp16, 2);
 
-	tmp64 = cpu_to_le64(simple_strtoull(uuid_str + 24, NULL, 16));
+	tmp64 = cpu_to_le64(hextoul(uuid_str + 24, NULL));
 	memcpy(uuid_bin + 10, &tmp64, 6);
 
 	return 0;
 }
 
 void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
 		     int str_format)
 {
-	const u8 uuid_char_order[UUID_BIN_LEN] = {0, 1, 2, 3, 4, 5, 6, 7, 8,
+	const uint8_t uuid_char_order[UUID_BIN_LEN] = {0, 1, 2, 3, 4, 5, 6, 7, 8,
 						  9, 10, 11, 12, 13, 14, 15};
-	const u8 guid_char_order[UUID_BIN_LEN] = {3, 2, 1, 0, 5, 4, 7, 6, 8,
+	const uint8_t guid_char_order[UUID_BIN_LEN] = {3, 2, 1, 0, 5, 4, 7, 6, 8,
 						  9, 10, 11, 12, 13, 14, 15};
-	const u8 *char_order;
+	const uint8_t *char_order;
 	const char *format;
 	int i;
 
 	/*
@@ -419,8 +433,9 @@ void gen_v5_guid(const struct uuid *namespace, struct efi_guid *guid, ...)
 	tmp16 = (uint16_t *)&guid->b[6];
 	*tmp16 = cpu_to_le16(be16_to_cpu(*tmp16));
 }
 
+#ifndef USE_HOSTCC
 #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
 void gen_rand_uuid(unsigned char *uuid_bin)
 {
 	u32 ptr[4];
@@ -502,4 +517,5 @@ U_BOOT_CMD(guid, CONFIG_SYS_MAXARGS, 1, do_uuid,
 	   "e.g. guid guid_env"
 );
 #endif /* CONFIG_CMD_UUID */
 #endif /* CONFIG_RANDOM_UUID || CONFIG_CMD_UUID */
+#endif /* !USE_HOSTCC */

-- 
2.46.0

