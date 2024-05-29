Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E7AC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D59AB88649;
	Wed, 29 May 2024 16:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D95VpD3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51FFB88641; Wed, 29 May 2024 16:49:08 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01BAD88602
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57883b25b50so2500895a12.2
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716994145; x=1717598945; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5TqztJQmgbCIjWAIrDa+3qg6yWYJjKnXV3xAvJ7iRaw=;
 b=D95VpD3lml69K5QIVka6kzUXgG20nnAfGs3mtA0jAk9gCxA0TmQpQqW4UWUx8hp+LR
 +tUfGQ7NF09t06pa221BMGA3FzdYAOJsV2WS4oMJP/yu1HmnKeP7R2tterI8JywoKWqI
 J/2afZEXq51URr+8sPjL0UApvsCnWxG+AsAKs9BNr7DF9vuIcJGQ6bM0OtN1LM91D5vX
 8yjbhNRcaFZq6zdvJNrQzWQ3r3eww+sHPAFbDvicEVcxF1nkdmxTdEf/cFjazT9wB4su
 XWShtArqXUn7cVrX0r2sOGpZL7kGWpL+2fxk5627v8JJcu+xGjfst5FWadrnJEr1jZrc
 qQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716994145; x=1717598945;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5TqztJQmgbCIjWAIrDa+3qg6yWYJjKnXV3xAvJ7iRaw=;
 b=FkBtMgqN2X9aJ6SGflg9OAjyhHgU5GrDRolJ0w/Wofcn1yXI7hvgzjm+lIgoaoGZN/
 z48M5n/AIvyQJe88zF9QUr5Ceg8O6zhkE9Wbrt5baXgyDmDZMdgYTa5LkcNUoJX1Fog6
 DGivMuMhbs7j0IQ4SbdyBFGL0FEnFpD4w/2pOduqYB5YVi9wa55Orb94NRnag9d9wR+E
 QxFhQIbLyCngsivmnRJEGzlmlfnazW3DnidvLgxSPS2cXmyuFuJaYNUeR4OH8J7KBOGL
 IQLdz5iVNs8thyczgOn3HHJK/1Nh5Cg3hKPJ0hEoAGEmvo8+BboGl7xFhs2j4MNzIKXC
 or0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjuSDQM/c7SAeW4486bd/0yc/dJEXf2F/BK+FC+VxQeDDSErdaKTaStDHuSLtda4nbNGueunKd8Y+7Mxb/SyyF8uGzEg==
X-Gm-Message-State: AOJu0YydDY9UIzohBrmPjma1q4ZPBck/Pd+e0HaWskplt7BazyKVAYkz
 XFKGyRbiCYwRIPvtWU9aK0pnUoqPIGnhpgssOwxj/U5A1HW/kYjZTqVwOM5yg9k=
X-Google-Smtp-Source: AGHT+IF1cBHPZ++Cx5H2HvMyGJyKtbZYsN8Wr2ayKpKbdEEeYnpSDEt87TysbW1ntBReq4V3VlJHCQ==
X-Received: by 2002:a50:c048:0:b0:570:3b8:a990 with SMTP id
 4fb4d7f45d1cf-57851a5156fmr9925777a12.39.1716994145442; 
 Wed, 29 May 2024 07:49:05 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578638009b1sm6922029a12.17.2024.05.29.07.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:49:04 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 29 May 2024 16:48:54 +0200
Subject: [PATCH v2 5/7] lib: uuid: supporting building as part of host
 tools
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-b4-dynamic-uuid-v2-5-c26f31057bbe@linaro.org>
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
In-Reply-To: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5253;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=QHdfRbm/u+JL8Udsf5R9COkCKzsesq/AtWafMSX79IM=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmV0BaS6NQFBRWNqgou2Ldd6s3SOv7GHmQTgLvi
 9Fk898gOq6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZldAWgAKCRAFgzErGV9k
 tsquD/0cP6cm0JP19dbFrWmpcL3XdRVPIkaEYwG+kZuYhizg3d7hNP1sA13GE53h3SkGgzH0B59
 JYnfaHXhqP86N2Ylc2ziJc0cspaexjype+FMHtOOmT6EmHSNqcEvc0BS9qeSb4bmcjN9vhqIrtK
 iI7z4J6qK6L8vSGcmEzvI7ILYIzu+5P2MmB/AOuqsjUmoF1avrHCElI4B701JbV4P+HGMGRAKoZ
 zFJid8+s69EOf9+9/lUujkmwLIT0KCnxQNJvqArGtGZW1vNEz3/WPQf5tgP8tHrp4gwKG2DcT1O
 kin5XG3/unBimu3o27RJwNAql0FyLDSAu5wuXS3LIYtatNYmcwFhZEHpmpZoX147cHndYWyo65t
 Ek/IDICa3kjmzZUCd3zocDAYT2Gt6tZv/W4IUkLjWiXGXLmNqbdtg33gT58tER5MAt1JXqx8ihm
 zZv973GzTuU3aKRqRFPJwAmMCNfLUT7x4LzJtlifAqOvk1eRq15S8AZTDUmJsJIq50nP1RVZJdi
 kvf0aiG1kbeehpB+zg89qgXalje97sRKsZBwwHZxJDSVehTLUtuvPArfHyTsIsTBiFHvPs3hF+O
 diXCcfASQgoxpJUp+XflgNIlMdDNbF1Vl0sd0p6iZ9cCz7NHAB+7geRIufPBPb632tzqtQXZCSq
 BjolrEsV0uOqAdQ==
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
index 539affaa47b9..b38b20d957ef 100644
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
index 6ef006cca1da..b6ad3dd06f6f 100644
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
@@ -405,8 +419,9 @@ void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)
 	uuid->clock_seq_hi_and_reserved |= UUID_VARIANT << UUID_VARIANT_SHIFT;
 }
 #endif
 
+#ifndef USE_HOSTCC
 #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
 void gen_rand_uuid(unsigned char *uuid_bin)
 {
 	u32 ptr[4];
@@ -494,4 +509,5 @@ U_BOOT_CMD(guid, CONFIG_SYS_MAXARGS, 1, do_uuid,
 	   "e.g. guid guid_env"
 );
 #endif /* CONFIG_CMD_UUID */
 #endif /* CONFIG_RANDOM_UUID || CONFIG_CMD_UUID */
+#endif /* !USE_HOSTCC */

-- 
2.45.0

