Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AD0C52D7D
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3520F88BF2;
	Thu,  8 Aug 2024 18:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tkX3nXwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4050488BE6; Thu,  8 Aug 2024 18:22:03 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A206874AC
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5a156557029so1420802a12.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134121; x=1723738921; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SkNwA1p54FnDty/KK32zAM9MXihkh5YACYpriNltkJM=;
 b=tkX3nXwakUBUqNF9MRX7pCgF/NHAQVMjnyxDsRFhVRG9SaH/XeFa0/4FDJ0o2SNdaN
 lVVSW4tMpCH28KLj17Qlv+4CHzIpv+uA7GoZmz9lxKC27oMN0b0B5t6ZJK2YqEdekTna
 ltLKV5Y7Zm1BeYMWg3a5TIHOgc07wr+SsSWaHVFb1IlX/rpo3ebH+n8xNFvpqZWinp0P
 g4DOg2lFMqr/CzZ+x3UzfSmsy3t08qFVeek+vhy2RFCbPI2PQp+G4cZAMHx2a4pjFqs0
 dZOpdohldq8R8u+SEICPA1MMAJlZAhEuI27/+DWWSV8b+SQkAUYgvvKorBZ2T1HRVbom
 FU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134121; x=1723738921;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkNwA1p54FnDty/KK32zAM9MXihkh5YACYpriNltkJM=;
 b=N/0GE6mcENQpgt+S0yOQwJ5V57uoZMolvcKlJgd6GHsfeOd9QT/IUjglEOlFFWCupd
 9pqFhUvUAOWvPXpdA0Hkmb6buAMWwUuH+yl0SG8eTBepGGz78sWyl8NRefrQrXj50rdX
 pVNo/7vrWOvO0YyaN2kxFoyxB1D1aL3rTFduPXagDw12Vny7ulK6ZWTyPZf9j0FWGF3y
 2vTB7qZvoL1vWGPGfzK+BAggnNHCTp0TAqCyFMFbsi2Sq1kTbaZgEQDiXZP5WsWQeUL0
 sNERkaiHkJjrwGct29sRAP4m6gwFJVFC+cy0TUqAGDZj6XgvjHb08uRr+Gxqn4gr+i8x
 VfRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3RgTqhM+ykM6ry3XHi17WFQhAst939jWkMP7K/ix8QfvOl5U7oA68YIjC+14Hb32tCFvzTq1rwCAYjM2ZA/EyOUsclg==
X-Gm-Message-State: AOJu0Yzoc4qGydSYqLLcCDLmbpLhpC34DPlVmfuziXeYGLOQY9ZytiRw
 0wxPwQ2KViLcDBKU1uttgxstez3c8rDOXUxrMcI5XPOc1CJz0j4YEZ/6DDlD+e6Lu12MsXql3Cq
 sdXw=
X-Google-Smtp-Source: AGHT+IFgggi60dAanbdSzN7j7roaUt0ItBmpErLJ0EOIjjb2x9CmD2xj1D7WiyhzFgoihguaXvpxwg==
X-Received: by 2002:a05:6402:274d:b0:58b:9561:650b with SMTP id
 4fb4d7f45d1cf-5bbb23f6b24mr2323446a12.25.1723134120554; 
 Thu, 08 Aug 2024 09:22:00 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5c8fbsm812351a12.79.2024.08.08.09.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:21:59 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 08 Aug 2024 18:21:53 +0200
Subject: [PATCH v6 06/11] lib: uuid: supporting building as part of host tools
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-b4-dynamic-uuid-v6-6-9332e7237119@linaro.org>
References: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
In-Reply-To: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
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
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtPCfuntyb3xwQG1ehEeDz6kXhot3yoLyHH4uA
 1rITKCUZ7yJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrTwnwAKCRAFgzErGV9k
 ttExEACH9GAWvdpBTxLEKEx4O8ZYmItj5Q9lnP4+9uZ0ytYmFs+499iWHYXiWGGCfbkik5pySRb
 PY95lKe/rgkS8VewwcE1z7s2XgTkhnS3OdAQZfPD48v0rohvFQGTRlCihaLyhnoQdO97r5+HQK1
 XqLTwo0ii12q4rHAIaMrWPCfcmt7Q+A5amM6ba0l4UW0wNGhUBY72KNmZyoMy50DCekFUt/7RF3
 TBt6NC8ICQPocV3tUVhXb0B2RaodQTSLPPPOJ6FnpyevjDmRq4LoU/gnnFmG3wP/pnOy65HnD/X
 BGFeLHIns3HDw0dCdKIiSNPKwzZQmjvz8eGBPoPUOjXgkN5VdOWr1jVqC4kRRv9fGrUhZl0X0AY
 jlXbBhFqJzYBrzN6hJJnbAVVhy2LZ/12hs7e8VhMP3E/AgOxIQzFFadrkaeUJ++xovyIJXbx72X
 KcieSASXU7jAQzhzteE/RLDhATE6rJyfCwBMC3oZh4WlaqtDM1AGV50WvewzoAZMiisurssLPNe
 jvDHkvvfQOsI0ogjxyrsqaniHE9SmGZRGUQqy+52yNu6RA5GlSTyN+Igp81bQn7l2tHFRnhkQlU
 CDntIBc27HP9chwIPl5NCda8/wSByWPCxk0q6iZDNaiGOYOTtQkcT0XL4yKFs2DXvFUczB9cCqU
 LaJjyisx6THC7AQ==
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

