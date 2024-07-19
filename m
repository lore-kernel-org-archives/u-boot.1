Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098B3C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 12:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BB9688BD4;
	Fri, 19 Jul 2024 14:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XodDT9I3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5168B88BA9; Fri, 19 Jul 2024 14:43:56 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B8788BC2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52ea929ea56so2909390e87.0
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393033; x=1721997833; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r/tH18cOYdnbYI0rrw7CpCVnGxtTU4g0IPgerw/jV5c=;
 b=XodDT9I3Xdp7H0WEmgVo2FYQ5r9kyGF7rb5QayxhGByu5rme9W/RkT4OHN8teR8zWu
 uuLX9iqpFcZqPwbWiDbU5fzXJdxCvUXF3gEjS3bWL0sP8RArXABUZCBVOGnbVFIH8awU
 5tDwS7ZbqphDTzaSqfM1uR1hJqSu2qbHc7ZzJv8kbEjTdzKFAzh5tTtT8mjferbCJQFS
 L/kKFk6mIH2fSnKBnSePpqyib0Nf6FHBi8Qha+NEkm9icqmyDejp0i8Qig0LUYXr/Za7
 WbwJvQ4VQp5S+bAk9veyrqb2PDRKchvwfvQbH6MdHSYYmK8U+Kr9MoavLHJJCGZbFU/b
 yPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393033; x=1721997833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/tH18cOYdnbYI0rrw7CpCVnGxtTU4g0IPgerw/jV5c=;
 b=gzskdjYTeH5+eWCSYj+2VXC2IiZOuoqB/oI0BjCDLD3GTWozGICXJtEzO+PpOK7x7w
 //tR0amQB1+ath9qjfcgZHPqMAyspg9JHg3xgxieacbm7w1/g1KHyTTOpyl+DlaAegO8
 rSZ4+vlEseyXHfYbw7jwXiEV9m/6ayoRBnMzLtze4xgi/ACtJI42gUgDcKfuzRGpcKF7
 WJ/a6PiEPHWX3Zd7qnQzjnu6GNcbVD3oPxMUz9XveP5wgA68TS+9GebSqbjDvPyVE8mx
 kS9J9XBP1IJziXYpS3mBRTBGy1ievpDxq5mNnFvXFDkU1Mmpyf573hGZ6eO2wQyt+bNe
 ppcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjN0YWQSoEWwCBGYp46TXQP1UUSIh2U3amVJP587gKShQbmdfy4OpPTy2u/DtBbV7mIVie9r/k23fv88D+Hcc4IHf+jQ==
X-Gm-Message-State: AOJu0YyAPgRhqM1doPN1ggXvtvRh0au4eW6wMYPcjNuk0uygDMqRzQVL
 yHhee3hvoH/qf2uF76yls/FBV7FqtKpaL/onS4IrbPR7oajfK0Zajh5wuDpuAlQ=
X-Google-Smtp-Source: AGHT+IFkwdFPRgGHz2C+nuElSc8SZnY/MF84m/+YjhWTYAcN/VpMEw35E/Mafm7gJcQsPLr6ZyZ82Q==
X-Received: by 2002:a05:6512:3e03:b0:52e:751a:a172 with SMTP id
 2adb3069b0e04-52ee5432a29mr7001799e87.49.1721393033583; 
 Fri, 19 Jul 2024 05:43:53 -0700 (PDT)
Received: from [192.168.2.172] ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785e97sm28577466b.39.2024.07.19.05.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 05:43:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 19 Jul 2024 14:43:46 +0200
Subject: [PATCH v5 06/11] lib: uuid: supporting building as part of host tools
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-b4-dynamic-uuid-v5-6-8a83de3fe3dc@linaro.org>
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
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
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmml+AT5ph8kG5ncs26AfG+wNlpFYmI+/8iXLQu
 7Z54xi3IyWJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZppfgAAKCRAFgzErGV9k
 tnVbEACEUpyrVTfYjfCtCuyVgGYVicaZkuuVeAPwW+kLk2P7ToGwQ3PU038Sr7CW+y4tTJ8gR82
 ekSYglphyDHG2Txy8Y7F3IIFeD3WV934vOH1XgTFUtPqNyHmHTxhEZIbyOwo3Jb17qA7eX/+pxw
 Vt34Ie12obamYlLdZohVaSFgSkNM+ksGGRf8hq7/3VvRnlxlTKEH59ibQN3mHtey4aHH5ZGgACH
 a61XZoVPY4ooenOCW3nBtXs74oX0epfSBf+E9IICCFFiP5vF2X+TF6bYD+bmaloKIn5Ko+aieD9
 nSqM3DJbiIQjcDaG9C+76pIUYCi/6yqKesNvCZlCS8GH1ZyMUz2j7ETyQgjt5CMUIIFveaiDo7V
 Cvt0fD4y4zbhbXlvuvDjhC4qTplq1Dgs3lv5eaGMG0tOxEZggMcBTdeHT2DH0hlfW8E556vp74j
 l60TehWDUbTiJsJjnIeJ1xq1qJBXqce0rtzb0I+WumcwGb4yCz8wb5ez29u83+hJAykmf7hjwYZ
 ZflcL3YQVNJ2cLoNC1uTnmjtkQikWixLY8WZUY7XAPus94l63Eqt3xZvilx6/bU4ffEQQJsdvnj
 cSdpiKCfgobifG+07TkrD+ha69anaOjkJ7id/4Hf5oU9EFsD8+eZUIGn8q9J8ZlIhsJ8COQbr/C
 GNcS4r/+2SGfmiA==
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

