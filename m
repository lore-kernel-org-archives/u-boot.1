Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C6AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 761F188C25;
	Fri,  9 Aug 2024 02:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IeDV33L/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12CCE88C19; Fri,  9 Aug 2024 02:56:40 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF8F288BEA
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7a9a369055so149960166b.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164997; x=1723769797; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SkNwA1p54FnDty/KK32zAM9MXihkh5YACYpriNltkJM=;
 b=IeDV33L/28zrBydmjw/YqGYn/asNwQYLIvocsdoVt+pRqdOaL2daPUlkPrPN1BDSqy
 K2j+YhycJZ3Kb7lzc04V3O0SCxMLi1uOd0j+bVlYwwsAJh+l1hv9ydHDRsuF3j/ugrMt
 QMQhCQmvtJjOduEpfuXR2bESa60tf43YrfaE8UqLIcp/8UiMIBGq7c3H2I6rHFKKUTvg
 zOaFu/Ej6BMvATJH0BUv1tgjUHZ1N8ri2mmIiyOnr4iEzKnY8PVo2AeJcoarQwG8TGC+
 ndrRZn4n07a3xoXGdyIWRTA6HWvrFrz39jkRmXGzHrlMXr0HAJ8XMOToLLfXiCKnraLp
 Nm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164997; x=1723769797;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkNwA1p54FnDty/KK32zAM9MXihkh5YACYpriNltkJM=;
 b=tfstseG+PlEFPIlbf+AG6t0Dy8EYouVb7su6HG0LcgQETP/CLrRTgbzz2rj+XjeJNt
 gAGa3lokfQIkIhps4bmx+umbKNCxp+IY37S5v13ct0pAnzkFDin581kujZ4IyfNutIpS
 92imwumyucQEJmjc2dKEKsFwxFx5+8RyvImYudBS2nyn5lopgMiT2xPB1KJj/0ZlhoaD
 cI57HU2WygNp153TRYTP916rzNt+JcIZGok8ezzk0UY/GHqWvHbMf5jxFQGoGiRcAPWZ
 bN8NPrHNLa/lxY5IocRvTg0nGBR/54LQXBaMv4ms3OJbIF5KMycYCjPbKzYlanqzZwZQ
 dZ+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQM8mY3J99Y1jjDMlBRKXLTzPuvpW1xbuv+xVQgCJv3uCVA8WXul90V5TyN7gWihhW4ke4ZMVox8nc6Gpd2LDNaZsFuQ==
X-Gm-Message-State: AOJu0YzGPTQkgVOYY82MIZNet7lbezd/2knCN8FutPL56UGCTv7wADql
 VQXMAZhZRQoxJrQ98MVEHnXEPrF3B1NnV6icsUduJJD2N/mNWOFjVYdoBDK5h8Y=
X-Google-Smtp-Source: AGHT+IGEhVmGuYb8+H5P7CXy/bVhjr/2/iXapxa/1WMTDAaVMZX9HT4JU6Rx/fnOLDSHAqCDiv+/YA==
X-Received: by 2002:a17:907:efe1:b0:a7a:c812:36c8 with SMTP id
 a640c23a62f3a-a80aa5a62c8mr1047866b.18.1723164997395; 
 Thu, 08 Aug 2024 17:56:37 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80e54sm790680266b.167.2024.08.08.17.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:56:36 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:56:25 +0200
Subject: [PATCH v7 06/11] lib: uuid: supporting building as part of host tools
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-dynamic-uuid-v7-6-8c44ab1f06a5@linaro.org>
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5256;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=TZzWl3PSLPgNZSMayk54PXwrShoczqUb0B/4tNZ/nZ4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWk8xVawBVRbGA7LomAslb6inpEeCCim+uvxy
 TNIlgt+vcqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVpPAAKCRAFgzErGV9k
 tsJ/D/sEk/AHVhH7ThFVid1sV4ezKSq6Nq++ZoDxvAhApj/jkLx6j4mzB2dw+wK/MulHgVJAUik
 IP9NBN4TLJA2RTTuGUzZmVwYiyiwX9zv6R1VnCX3ydcyU/df0UwmmkEj5G4cwLUpfJWjz527SfP
 EvCTFyQBxbBwwnfnvBQwDMNL9uquHTz8LU+Sp1VJfCk4CGOeeIS9wNMzJTgteIWNa4VbgH0YFcR
 kO+YWIideqiV+tbmic6CDJCSvpR2b2phArb7EUT/2jXZXOkYC1OwDsfRFz3KK27imSw7xRZ106I
 eQ4LWyjBX7vCeFrM785HLADAuW51LXLPlyzBW1o+pQ+1LcF9ehVW3ygSWXewfaASI7xxLOB7j6T
 /1a5GO4HSEEsEtpv2P5jIAXEz8LY0updSNYGT9BWvDvrCK0yiWVd1DLf21wP+1dLd7nxej/1fqN
 40u6iyHoP9za+LAwd2brkUojK24J3qGz9zNhYPafDkycmTZIfKwvAZ3yI60nrQJicICyRWTRnsK
 LwOMiFvswXRwS55agJSyzhsnMxD0cNCFeaOTwuOm8oc062x9+w17wwM6lZfIUYFAAq/7R+wV4vp
 R+Piue5FZzKFOD6DIojsHJZqYi+0czktpXUEFrBjIj8IZY1eYGW0PG1crbQ2HeSLRwQZhImS7gE
 t+3sxabAKgwXzVg==
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
index 24b5881600fd..84277cf67ece 100644
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
@@ -418,8 +432,9 @@ void gen_v5_guid(const struct uuid *namespace, struct efi_guid *guid, ...)
 	tmp16 = (uint16_t *)&guid->b[6];
 	*tmp16 = cpu_to_le16(be16_to_cpu(*tmp16));
 }
 
+#ifndef USE_HOSTCC
 #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
 void gen_rand_uuid(unsigned char *uuid_bin)
 {
 	u32 ptr[4];
@@ -501,4 +516,5 @@ U_BOOT_CMD(guid, CONFIG_SYS_MAXARGS, 1, do_uuid,
 	   "e.g. guid guid_env"
 );
 #endif /* CONFIG_CMD_UUID */
 #endif /* CONFIG_RANDOM_UUID || CONFIG_CMD_UUID */
+#endif /* !USE_HOSTCC */

-- 
2.46.0

