Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26770C25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 13:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFA3887B1;
	Fri, 31 May 2024 15:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H8pd6vB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3E70887CE; Fri, 31 May 2024 15:50:54 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A806882B8
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso190308066b.0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 06:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717163452; x=1717768252; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9akAAz9hF/jdFLeFWjBJfV867XQPVmitXPU4glcZWNs=;
 b=H8pd6vB4cGsmU80giHO5WtfA61T6TEyk9Er/Z4noIbfgAdt8AVJOkgdpAS88CIH4zS
 CCgW7biAp20fa9sv9qUYKYjjbWMfIcVvGZNfxzIqVDK1p/NdRSthVyucAwAFxKMwPP5a
 STC05ArGDl+T0bvPgrM30I1ydCFP+1ZGIUIhQi476UnlvwYEVLFtb+H3/6EHIYcRc6po
 BsL9oRj3A6DIhj84H8wnIdOCPfOuhRLocej0JNsspE+nRhmf0HcfpcmPFmZQxJokGcB6
 9reREfX6y+ch/wdQ05zSie9ELqj9bm0IbdAy1sgwZYXFTp5VUApOO1bIFaCtmwcXFUse
 I+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717163452; x=1717768252;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9akAAz9hF/jdFLeFWjBJfV867XQPVmitXPU4glcZWNs=;
 b=d0nT38vYFKqPaL1SpQKrXcSpndEDNVXwa181FOs3VSwqNsHZHSzUJEkeujHFDJjy+5
 drjC6UA1yb/VYLSPBKmU+baLOhy5/iXTZUSEnq459NdWz8agl2J3/vsRrnRKOz/M654l
 kRA7emmLabWXxPTfwOTLSN0a9g4UjL+Q5M46JYf9o1tKVodo0uVdbrrMUyuE98x3ByFS
 zjh6uy5kJapb+KrBKRmrYDaUYJYAvQUjju4lU2Nq6PWsmcI2fqtoESWl9keuDtJDgILI
 yGnFCdyCHDeUTveMXOBNXmQsyDEcy5u6E9yodDMADrT3jbFIcqqWDkwL0CrqyqEk3i9y
 RiQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCy319kOxT2mL4t3uRhtdEh9sPcPzqImWAQUP65kc78tX/nZIPdeRtVLBjEJiplLEMWjKhhZ+oYrxGJYb1LscZQAIEww==
X-Gm-Message-State: AOJu0YxiMKZN/vUSMd8VFeDYZVHynggYB5fjCwdSPiqZLcWQxk33jsxJ
 MXqlPNEXqEe5j0Rl62GEbBHEv+E2LGfkpuqRRLhn/V11ETGvi26lvwvuexm/1Jo=
X-Google-Smtp-Source: AGHT+IFqe4ZcbUPRBAmRM7T5VVAZ9u7+jYGt1PsfmfCANJs/WHTPEq0OW0hQbe7Hj/MJ6szZtH40qw==
X-Received: by 2002:a17:906:3103:b0:a65:cea9:dd56 with SMTP id
 a640c23a62f3a-a68208fbc54mr128162666b.33.1717163451756; 
 Fri, 31 May 2024 06:50:51 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eab84a99sm89442866b.143.2024.05.31.06.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 06:50:51 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 31 May 2024 15:50:39 +0200
Subject: [PATCH v3 5/7] lib: uuid: supporting building as part of host
 tools
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-b4-dynamic-uuid-v3-5-ca4a4865db00@linaro.org>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
In-Reply-To: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
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
 bh=GIKCAKL8Z6qLwSjriQMI2tPgimrtffN1dSTIvetofgk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmWdW0y1Jnu2fICTePvOy2xxFnc29Cc0N4YrY+K
 2+fy2Jtlj6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlnVtAAKCRAFgzErGV9k
 tmCOD/9RI9KGI3ohzk20kokDx6sDbyzKChW5FaJuBN6rnMJbk2Pt2JXINNPVf+O6LesvNzGJjNE
 XqoIeY3C/vKgmM3YdmHsjbcKec3scPJr7GbrJIQ6f7zNZzGxwiYYlrbOoG4BGAt8N8qmo7DvYup
 8FhzZgwKTkfQC+JQSs7bbBCX/uX9QF7dX41oyQQ7NpD+uImR02S2GVCabpOZ+za60sQ+/D6s7Mi
 0mk30HJuU+qJAQqEvUah4p/NMzq+WvgUjxl8wvoE7ed8Ua+qGmuvm76uajsmx/bnu+xeDW7dzkL
 VxL6KzMkEmbNiWpAIPnhJYcfq9jNlzCJP2SNidYYvQ4WlMKJNDXvHA6LL3YLKMJRr44QVewZlr8
 CQhX+PteTAusHlsK3IZR20sede/RaUwrb++Dd8s3jIlS2cOLhg1fsCevuptKT3rSd963MOWcrR7
 HuO8o3HS6MiXkn+znncNsUAfnfmddMRoLCDrJ75OayEB4L2HFrCA/+eS7Ud4ZSJfx3jhXJd+Ved
 C4PYzYv7Y2WCmVg+BbNksRz7phAATvZHFPHWz3eGmwza2pQKKBNXlsFnsHMQQKiV0hremOrd7LQ
 2HVLFpO8P2AFtk0fsEzHs5Lckb1FkOGd44Zt73oxaSo/bUijmEjwad0r4xiE888IxMVDA2OIQcw
 zFsCaGg6VZFN5hg==
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
index 2df0523e717f..89911b06ccc0 100644
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

