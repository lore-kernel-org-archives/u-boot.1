Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBD2C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E336F8874C;
	Tue,  2 Jul 2024 15:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hBtGfDJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09FEB8871F; Tue,  2 Jul 2024 15:30:54 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF53288725
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52ce9ba0cedso7329418e87.2
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719927051; x=1720531851; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r/tH18cOYdnbYI0rrw7CpCVnGxtTU4g0IPgerw/jV5c=;
 b=hBtGfDJg3s7JLR2wxUa32gpSIa0sUIM9Rri8xjlcNlQFnAvCrPg7vxK0oE9UyYkT/J
 JycXVTBVN8PFdqxBmZSaix4zBhDkAHDHWQVpR2SCd5xVT9pqSVAJ7KQeUMl/xNEIuk/9
 mpbFTgyBsnlJt+/A/uQklO/3ZGjR3uSpQcUuxQs3ct644+xfM8HwLG5mdvQP+InNgl2A
 r8pbmhcdgdGlxIvQGdC466uziSJku7S/uJdrM2FscoRPMtVD7YVhBlzRTZ4zVleigGzw
 3cyeUB5ddMRiV8HD5ZcH1rTb8jNvI+3CFa0tW6ipMaWgwgde3FkpXGV3NX4yZt2jLrxl
 wfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927051; x=1720531851;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/tH18cOYdnbYI0rrw7CpCVnGxtTU4g0IPgerw/jV5c=;
 b=hWt1pt7+w97cq2a0LZkCz5lJVWgj4kDYuYj7Oi7Oa62OdZi8U3a8i/pVWGe2y/pFKP
 8+iMq5uQgMHGe+oqTWh2LuEdYpwpVoTr5pK9Pm/C4QN6R18O6DSqhe2/7QQxvr1OQtPy
 X9V/Eq5PKR4zPU66e/S6xE9/gWN46r2SF+1JOl8f8yGQf4ftZv+J0ywck4l1IbSPaWiZ
 gN8+nSdMKOEhlRFma5ReWKKO2W61rPf1jJGiWtLehhkc1geZARirLIVnBkK/n7JdlusS
 06nEgmlW/ELH46ldD2k7r2D173ljmLwSkcJXOsGF0HhZtyegZuCsXnV74eze1MygVuNc
 R3ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeWPkEdQJnMJeoZZvWFwx3xK2XcUM7IeKAhn5qyiAt0INIMyfkbSmD1ifWcSABqi4xIIGBI9S6b9JWE3NZxQa7aaQCyg==
X-Gm-Message-State: AOJu0YxmD+kvuQdQWd0yAlh9bZCl5GIKE7g3a+4OVDWQck4MyOenrHtA
 ungowU+Lexwado+LQ7/RMwK8yq85ndbE7xfX2xCxCx1Zvngvo434ekUArrI7c2c=
X-Google-Smtp-Source: AGHT+IFOi2WE5ZNxgPVIL3N1K1MknCLNz19P6zz0Heyj0Tu3S4Sfqi9xL7MqDC2hUD5YisRJadXMJQ==
X-Received: by 2002:ac2:5e22:0:b0:52e:7498:118c with SMTP id
 2adb3069b0e04-52e8266ea3emr5324000e87.21.1719927051145; 
 Tue, 02 Jul 2024 06:30:51 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7430367d55sm323796166b.87.2024.07.02.06.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 06:30:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 02 Jul 2024 15:30:46 +0200
Subject: [PATCH v4 06/10] lib: uuid: supporting building as part of host tools
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-b4-dynamic-uuid-v4-6-a00c82d1f504@linaro.org>
References: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
In-Reply-To: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5243;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=O65GT19i9rQOizkC2sebcSaH7hMe5ytzOraTZ22qXA0=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmhAEC3AyiWuOKjOpzaDd0f3QlfKbLvm2voA1qT
 zLAFt4TH7OJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZoQBAgAKCRAFgzErGV9k
 tvmSD/0fndkvqFnRJOwzb0MYy9Jk9ODoWbrDIIi1bUulN46xP/P6X5itDMz1c4S2Zo7SwiBIUjS
 OKaaUM6L3Qhakn9cyGsjvJoIK/EbPzbjfQNJedG5GWq8etRJtpPP97ya3brtOynWYF7O0XyjywH
 qo2Jwxd6K6gNJI7pz0Qvbl29oK3cuUvpFy17wi5T3JpI+TNvydKZVrYcFvLhXVVhtvwr2bGGp8Y
 UxnWEZR5XPdpoEC2UCqerIkHNh8+gS97wZOc3F8/ZiXk9XGBxqKrJKEDWnOQ3LYKrBlTOQwps6G
 /snR39uHxYYTRGxoqFF1KIDWW0ReFXfaJQ1JUdSXDXhiGChEHasD/CfUdX4OZou2S/sS+QEmKDK
 3GR1KeJMfm648yE0MlJGz/JeEwFtacvNmFUzYx2ufzpSQCvWXJPqEpgcQWkCaKrdmwFNdzBXegb
 zcAHlspHcItBfIB04XhVILBx4v954xSbqcY/QIDX+++JvDloKmfNHL1iqGNy9nCLk2sU7TVZwOT
 l/v4t2mPMGvOsMsEHElcZ3z/MVxuCZV6DKO/5tsmFKMSFEsWca8P2yr/l/eoXFA3IF3uG62K29X
 4Y/TkjuxaadS/AkAILlWl08z7PXBaCbGihN7LCtV1XCrtIIXjoStWXjtbdACQKxOPjrOPppx86x
 ZZiiCJrYjCtiAkw==
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
index 7d0a8273d157..272e07dc1613 100644
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
 	*tmp16 = be16_to_cpu(*tmp16);
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
2.45.2

